{*******************************************************************************

     The contents of this file are subject to the Mozilla Public License
     Version 1.1 (the "License"); you may not use this file except in
     compliance with the License. You may obtain a copy of the License at
     http://www.mozilla.org/MPL/

     Software distributed under the License is distributed on an "AS IS"
     basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
     License for the specific language governing rights and limitations
     under the License.

*******************************************************************************}

// JCL_DEBUG_EXPERT_INSERTJDBG ON
// JCL_DEBUG_EXPERT_GENERATEJDBG ON
// JCL_DEBUG_EXPERT_DELETEMAPFILE ON

program SSEDump;

{$APPTYPE CONSOLE}

uses
  TypInfo,
  Classes,
  SysUtils,
  Windows,
  Registry,
  IniFiles,
  Zlibex,
  lz4,
  wbBSA,
  wbSort,
  wbInterface,
  wbSaveInterface,
  wbImplementation,
  wbLocalization,
  wbHelpers,
  wbLoadOrder,
  wbDefinitionsFNV,
  wbDefinitionsFNVSaves,
  wbDefinitionsFO3,
  wbDefinitionsFO3Saves,
  wbDefinitionsFO4,
  wbDefinitionsFO4Saves,
  wbDefinitionsFO76,
  wbDefinitionsTES3,
  wbDefinitionsTES4,
  wbDefinitionsTES4Saves,
  wbDefinitionsTES5,
  wbDefinitionsTES5Saves;

const
  IMAGE_FILE_LARGE_ADDRESS_AWARE = $0020;

{$SetPEFlags IMAGE_FILE_LARGE_ADDRESS_AWARE}

var
  dtArrays : set of TwbDefType = [
    dtSubRecordArray,
    dtArray
  ];

var
  StartTime       : TDateTime;
  DumpGroups      : TStringList;
  SkipChildGroups : TStringList;
  DumpChapters : TStringList;
  DumpForms    : TStringList;
  DumpCount       : Integer;
  DumpMax         : Integer;
  DumpCheckReport : Boolean = False;

procedure ReportProgress(const aStatus: string);
begin
  WriteLn(ErrOutput, FormatDateTime('<hh:nn:ss.zzz>', Now - StartTime), ' ', aStatus);
end;

type
  TExportFormat = (efUESPWiki, efRaw);
  TwbDefProfile = string;
  TwbExportPass = ( epRead, epSimple, epShared, epChapters, epRemaining, epNothing);
var
  wbDefProfiles : TStringList = nil;
function StrToTExportFormat(aFormat: string): TExportFormat;
begin
  Result := efRaw;
  if Uppercase(aFormat)='RAW' then
    Result := efRaw
  else if Uppercase(aFormat)='UESPWIKI' then
    Result := efUESPWiki;
end;

function UESPName(aName: String): String;
begin
  while Pos(' ', aName)>0 do
    aName[Pos(' ', aName)] := '_';
  Result := aName;
end;

function UESPType(aType: String): String;

  function UESParrayType(aType: String): String; forward;

  function UESPsingleType(aType, aStandard, aResult: String): String;
  var
    i: Integer;
    l: Integer;
  begin
    i := Pos(UpperCase(aStandard), Uppercase(aType));
    if i>0 then begin
      Result := '';
      l := Length(aStandard);
      if i>1 then begin
        Result := Copy(aType, 1, i-1);
        Delete(aType, 1, i+l-1);
      end else
        Delete(aType, 1, l);
      Result := Result + aResult + aType;
    end else
      Result := aType;
  end;

  function UESParrayCount(aType: String): String;
  var
    i: Integer;
    c: String;
  begin
    i := Pos('_', aType);
    if i>1 then begin
      c := Copy(aType, 1, i-1);
      Delete(aType, 1, i);
    end else
      c := '';
    Result := '_'+aType+'['+c+']';
  end;

  function UESParrayType(aType: String): String;
  const
    cArray = '_ARRAY';
    cof = '_OF_';
  var
    i: Integer;
    j : Integer;
    l: Integer;
    t: String;
  begin
    i := Pos(cArray, UpperCase(aType));
    l := Length(cArray);
    if (i>0) and ((i+l-1) = Length(aType)) then begin
      Delete(aType, i, l);
      j := Pos(cOf, UpperCase(aType));
      if j>1 then begin
        Result := Copy(aType, 1, j-1);
        Delete(aType, 1, j+Length(cOf)-1);
        t := UESParrayCount(aType);
        Result := Result + t;
      end;
    end else
      Result := aType;
  end;

begin
  Result := UESPName(aType);
  Result := UESParrayType(Result);

  Result := UESPsingleType(Result, 'Unsigned_Bytes', 'uint8');
  Result := UESPsingleType(Result, 'Signed_Bytes', 'int8');
  Result := UESPsingleType(Result, 'Bytes', 'int8');
  Result := UESPsingleType(Result, 'Unsigned_Byte', 'uint8');
  Result := UESPsingleType(Result, 'Signed_Byte', 'int8');
  Result := UESPsingleType(Result, 'Byte', 'int8');
  Result := UESPsingleType(Result, 'Unsigned_DWord', 'uint32');
  Result := UESPsingleType(Result, 'Signed_DWord', 'int32');
  Result := UESPsingleType(Result, 'DWord', 'int32');
  Result := UESPsingleType(Result, 'Unsigned_Word', 'uint16');
  Result := UESPsingleType(Result, 'Signed_Word', 'int16');
  Result := UESPsingleType(Result, 'Word', 'int16');
  Result := UESPsingleType(Result, 'Float', 'float32');

  Result := UESPsingleType(Result, 'FormID', 'formid');
end;

const
  UESPWikiTable = '{| class="wikitable" border="1" width="100%"'+#13+#10+
  '! width="3%" | [[Tes5Mod:File Format Conventions|C]]'+#13+#10+
  '! width="10%" | SubRecord'+#13+#10+
  '! width="15%" | Name'+#13+#10+
  '! width="15%" | [[Tes5Mod:File Format Conventions|Type/Size]]'+#13+#10+
  '! width="57%" | Info';
  UESPWikiClose ='|}'+#13+#10;

function AnchorProfile(aFormat: TExportFormat; aIndent, aProfile: String; useProfile: Boolean; aName, aType: String): String;
begin
  case aFormat of
    efUESPWiki: begin
      if aIndent='' then
        Result := '=== [[Tes5Mod:Save File Format/'+aProfile+'|'+UESPName(aName)+']] ==='+#13+#10+UESPWikiTable
      else begin
        Result := '|-'+#13+#10+'|'+UESPName(aName)+#13+#10+'|';
        if useProfile then
          Result := Result+'[[Tes5Mod:Save File Format/'+aProfile+'|'+UESPType(aType)+']]'
        else
          Result := Result+UESPType(aType);
        Result := Result+#13+#10+'|';
      end;
    end;
    efRaw: begin
      Result := aIndent+aName+' as '+aType;
      if useProfile then Result := Result+' ['+aProfile+']';
    end;
  end;
end;

procedure AddProfile(aProfile: String);
var
  i       : Integer;
begin
  i := wbDefProfiles.IndexOf(aProfile);
  if i >= 0 then begin
    wbDefProfiles.Objects[i] := Pointer(Integer(wbDefProfiles.Objects[i])+1);
  end else begin
    wbDefProfiles.AddObject(aProfile, Pointer(1));
  end;
end;

function FindProfile(aProfile: String): Integer;
var
  i       : Integer;
begin
  i := wbDefProfiles.IndexOf(aProfile);
  if i >= 0 then begin
    Result := Integer(wbDefProfiles.Objects[i]);
  end else
    Result := 0;
end;

procedure MarkProfile(aProfile: String);
var
  i       : Integer;
begin
  i := wbDefProfiles.IndexOf(aProfile);
  if i >= 0 then
    wbDefProfiles.Objects[i] := Pointer(-1);
end;

procedure LockProfile(aProfile: String);
var
  i       : Integer;
begin
  i := wbDefProfiles.IndexOf(aProfile);
  if i >= 0 then
    wbDefProfiles.Objects[i] := Pointer(-2);
end;

procedure ProfileContainer(aFormat: TExportFormat; aElement: IwbNamedDef; var aProfile: String;
  Pass: TwbExportPass; aIndent: String); forward;

procedure ExportElement(aFormat: TExportFormat; aElement: IwbNamedDef; var aProfile: String;
  Pass: TwbExportPass; aIndent: string = ''); forward;

procedure ExportContainer(aFormat: TExportFormat; aElement: IwbNamedDef; var aProfile: String;
  Pass: TwbExportPass; aIndent: String; skipFirst: Boolean);
var
  i       : Integer;
  j       : Integer;
  Profile : String;
begin
  case aElement.DefType of
    dtSubRecordStruct,
    dtSubRecordUnion,
    dtRecord :
      with aElement as IwbRecordDef do
        for i := 0 to Pred(MemberCount) do begin
          Profile := '';
          ExportElement(aFormat, Members[i], Profile, Pass, aIndent);
          aProfile := aProfile + Profile;
        end;
    dtSubRecord :
      with aElement as IwbSubRecordDef do begin
        Profile := '';
        ExportElement(aFormat, Value, Profile, Pass, aIndent);
        aProfile := aProfile + Profile;
      end;
    dtString,
    dtLString,
    dtLenString,
    dtByteArray,
    dtInteger,
    dtIntegerFormater,
    dtFloat : ;
    dtSubRecordArray :
      with aElement as IwbSubRecordArrayDef do begin
        Profile := '';
        ExportElement(aFormat, Element, Profile, Pass, aIndent);
        aProfile := aProfile + Profile;
      end;
    dtArray :
      with aElement as IwbArrayDef do begin
        Profile := '';
        ExportElement(aFormat, Element, Profile, Pass, aIndent);
        aProfile := aProfile + Profile;
      end;
    dtStruct,
    dtStructChapter :
      with aElement as IwbStructDef do
        for i := 0 to Pred(MemberCount) do begin
          Profile := '';
          ExportElement(aFormat, Members[i], Profile, Pass, aIndent);
          aProfile := aProfile + Profile;
        end;
    dtUnion :
      with aElement as IwbUnionDef do begin
        if skipFirst then j := 1 else j := 0;
        for i := j to Pred(MemberCount) do begin
          Profile := '';
          ExportElement(aFormat, Members[i], Profile, Pass, aIndent);
          aProfile := aProfile + Profile;
        end;
      end;
    dtEmpty: ;
  end;
end;

procedure ExportElement(aFormat: TExportFormat; aElement: IwbNamedDef; var aProfile: String;
  Pass: TwbExportPass; aIndent: string = '');
var
  doIt       : Boolean;
  skipFirst  : Boolean;
  theElement : IwbNamedDef;
  theIndent  : String;
  Profile    : String;
begin
  doIt := False;
  skipFirst := False;
  theElement := aElement;
  if aElement.defType in dtArrays then begin
    case aElement.DefType of
      dtArray: with aElement as IwbArrayDef do begin
        doIt := Element.DefType in dtNonValues;
        theElement := Element;
      end;
      dtSubRecordArray: with aElement as IwbSubRecordArrayDef do begin
        doIt := Element.DefType in dtNonValues;
      end;
    end;
  end else if aElement.defType in [dtSubrecord] then begin
    with aElement as IwbSubRecordDef do begin
      doIt := Value.DefType in dtNonValues;
      theElement := Value;
    end;
  end else if aElement.defType in [dtUnion] then begin
    with aElement as IwbUnionDef do if MemberCount>0 then begin
      doIt := True;
      skipFirst := Members[0].DefTypeName = 'Null';
    end;
  end else if (aElement.defType in dtNonValues) then
    doIt := True;

  Profile := ':' + wbDefToName(aElement)+'='+aElement.DefTypeName;
  aProfile := aProfile + Profile;
  if doIt then begin
    Profile := '';
    ProfileContainer(aFormat, theElement, Profile, Pass, aIndent);
    aProfile := aProfile + Profile;
  end;
  Write(AnchorProfile(aFormat, aIndent, aProfile, doIt, wbDefToName(aElement), aElement.DefTypeName));
  if skipFirst then Write(' Present only if ...');
  WriteLn;
  theIndent := aIndent + '  ';
  if ((aIndent='') or (FindProfile(aProfile)<>-1)) and doIt then begin
    Profile := '';
    ExportContainer(aFormat, theElement, Profile, Pass, theIndent, skipFirst);
  end;
  if aIndent = '' then begin
    case aFormat of
      efUESPWiki: Write(UESPWikiClose);
    end;
    WriteLN;
  end;
end;

procedure ProfileElement(aFormat: TExportFormat; aElement: IwbNamedDef; var aProfile: String;
  Pass: TwbExportPass; aIndent: String); forward;

procedure ProfileContainer(aFormat: TExportFormat; aElement: IwbNamedDef; var aProfile: String;
  Pass: TwbExportPass; aIndent: String);
var
  i       : Integer;
  Profile : string;
begin
  Profile := '';
  case aElement.DefType of
    dtSubRecordStruct,
    dtSubRecordUnion,
    dtRecord :
      with aElement as IwbRecordDef do
        for i := 0 to Pred(MemberCount) do begin
          Profile := '';
          ProfileElement(aFormat, Members[i], Profile, Pass, aIndent);
          aProfile := aProfile + Profile;
        end;
    dtSubRecord :
      with aElement as IwbSubRecordDef do begin
        Profile := '';
        ProfileElement(aFormat, Value, profile, Pass, aIndent);
        aProfile := aProfile + Profile;
      end;
    dtString,
    dtLString,
    dtLenString,
    dtByteArray,
    dtInteger,
    dtIntegerFormater,
    dtFloat : ;
    dtSubRecordArray :
      with aElement as IwbSubRecordArrayDef do begin
        Profile := '';
        ProfileElement(aFormat, Element, Profile, Pass, aIndent);
        aProfile := aProfile + Profile;
      end;
    dtArray :
      with aElement as IwbArrayDef do begin
        Profile := '';
        ProfileElement(aFormat, Element, Profile, Pass, aIndent);
        aProfile := aProfile + Profile;
      end;
    dtStruct,
    dtStructChapter :
      with aElement as IwbStructDef do
        for i := 0 to Pred(MemberCount) do begin
          Profile := '';
          ProfileElement(aFormat, Members[i], Profile, Pass, aIndent);
          aProfile := aProfile + Profile;
        end;
    dtUnion :
      with aElement as IwbUnionDef do
        for i := 0 to Pred(MemberCount) do begin
          Profile := '';
          ProfileElement(aFormat, Members[i], Profile, Pass, aIndent);
          aProfile := aProfile + Profile;
        end;
    dtEmpty: ;
  end;
end;

procedure ProfileElement(aFormat: TExportFormat; aElement: IwbNamedDef; var aProfile: String; Pass: TwbExportPass;
  aIndent: String);
var
  Profile    : String;
  doIt       : Boolean;
  doubleIt   : Boolean;
  theElement : IwbNamedDef;
  n          : Integer;

  procedure doFindSimpleProfile(aProfile: String);
  begin
    n := FindProfile(aProfile);
    if not (aElement.DefType in dtNonValues) and (n>1) then begin
      LockProfile(aProfile);
    end;
  end;

  procedure doFindSharedProfile(aProfile: String);
  begin
    if (aElement.DefType in [dtStruct, dtSubRecordStruct]) and (FindProfile(aProfile)>0) then begin
      MarkProfile(aProfile);
      ExportElement(aFormat, aElement, Profile, Pass, aIndent);
    end;
    if (aElement.DefType in [dtUnion, dtSubRecordUnion]) and (FindProfile(aProfile)>1) then begin
      MarkProfile(aProfile);
      ExportElement(aFormat, aElement, Profile, Pass, aIndent);
    end;
  end;

  procedure doFindChaptersProfile(aProfile: String);
  begin
    if (aElement.DefType in [dtRecord, dtStructChapter]) then begin
      MarkProfile(aProfile);
      ExportElement(aFormat, aElement, Profile, Pass, aIndent);
    end;
  end;

  procedure doFindProfile(aProfile: String);
  begin
    if FindProfile(aProfile)>0 then begin
      MarkProfile(aProfile);
    end;
  end;

  procedure CheckPass(Pass: TwbExportPass; aProfile: String);
  begin
    Profile := '';
    case Pass of
      epRead:      AddProfile(aProfile);
      epSimple:    doFindSimpleProfile(aProfile);
      epShared:    doFindSharedProfile(aProfile);
      epChapters:  doFindChaptersProfile(aProfile);
      epRemaining: doFindProfile(aProfile);
    end;
  end;

begin
  if not Assigned(wbDefProfiles) then begin
    wbDefProfiles := TStringList.Create;
    wbDefProfiles.Sorted := True;
    wbDefProfiles.Duplicates := dupIgnore;
  end;

  Profile := ':' + wbDefToName(aElement)+'='+aElement.DefTypeName;
  aProfile := aProfile + Profile;

  doIt := False;
  doubleIt := False;
  theElement := aElement;
  if aElement.defType in dtArrays then begin
    case aElement.DefType of
      dtArray: with aElement as IwbArrayDef do begin
        doIt := Element.DefType in dtNonValues;
        doubleIt := doIt;
        theElement := Element;
      end;
      dtSubRecordArray: with aElement as IwbSubRecordArrayDef do begin
        doIt := Element.DefType in dtNonValues;
        doubleIt := doIt;
      end;
    end;
  end else if aElement.defType in [dtSubrecord] then begin
    with aElement as IwbSubRecordDef do begin
      doIt := Value.DefType in dtNonValues;
      theElement := Value;
    end;
  end else if (aElement.defType in dtNonValues) then
    doIt := True;
  if doIt then begin
    Profile := '';
    ProfileContainer(aFormat, theElement, Profile, Pass, aIndent);
    aProfile := aProfile + Profile;
    if doubleIt then begin
      Profile := '';
      ProfileContainer(aFormat, theElement, Profile, Pass, aIndent);
      aProfile := aProfile + Profile;
    end;

  end;
  CheckPass(Pass, aProfile);
end;

procedure ProfileHeader(aFormat: TExportFormat; Pass: TwbExportPass);
var
  RecordDef : PwbMainRecordDef;
  Profile   : String;
begin
  Profile := '';
  case wbToolSource of
    tsPlugins: begin
      if wbFindRecordDef(wbHeaderSignature, RecordDef) then
        ProfileElement(aFormat, RecordDef^, Profile, Pass, '');
    end;
    tsSaves: begin
      ProfileElement(aFormat, wbFileHeader, Profile, Pass, '');
    end;
  end;
end;

procedure ProfileArray(aFormat: TExportFormat; Pass: TwbExportPass);
var
  i         : Integer;
  RecordDef : PwbMainRecordDef;
  Profile   : String;
begin
  case wbToolSource of
    tsPlugins: for i := 0 to Pred(wbGroupOrder.Count) do
      if wbGroupOrder[i]<>wbHeaderSignature then begin
        Profile := '';
        if wbFindRecordDef(AnsiString(wbGroupOrder[i]), RecordDef) then
          ProfileElement(aFormat, RecordDef^, Profile, Pass, '');
      end;
  end;
end;

procedure ProfileChapters(aFormat: TExportFormat; Pass: TwbExportPass);
var
  i         : Integer;
  Profile   : String;
begin
  Profile := '';
  case wbToolSource of
    tsSaves: for i := 0 to Pred(wbFileChapters.MemberCount) do begin
      ProfileElement(aFormat, wbFileChapters.Members[i], Profile, Pass, '');
    end;
  end;
end;

procedure WriteElement(aElement: IwbElement; aIndent: string = ''); forward;

procedure WriteContainer(aContainer: IwbContainer; aIndent: string = '');
var
  i            : Integer;
  GroupRecord  : IwbGroupRecord;
  ContainerRef : IwbContainerElementRef;
  Chapter      : IwbChapter;
begin
  if (wbToolSource in [tsPlugins]) then if (aContainer.ElementType = etGroupRecord) then
    if Supports(aContainer, IwbGroupRecord, GroupRecord) then
      if GroupRecord.GroupType = 0 then begin
        if Assigned(DumpGroups) and not DumpGroups.Find(String(TwbSignature(GroupRecord.GroupLabel)), i) then
          Exit;
        ReportProgress('Dumping: ' + GroupRecord.Name);
      end
      else
        if Assigned(SkipChildGroups) and Assigned(GroupRecord.ChildrenOf) and
           SkipChildGroups.Find(String(TwbSignature(GroupRecord.ChildrenOf.Signature)), i)
        then
          Exit;
  if (wbToolSource in [tsSaves]) and Assigned(DumpChapters) and Supports(aContainer, IwbChapter, Chapter) then begin
    if not DumpChapters.Find(IntToStr(Chapter.ChapterType), i) then
      Exit;
    ReportProgress('Dumping: ' + aContainer.Name);
  end;
  if (wbToolSource in [tsSaves]) and Assigned(ChaptersToSkip) and Supports(aContainer, IwbChapter, Chapter) then
    if ChaptersToSkip.Find(IntToStr(Chapter.ChapterType), i) then begin
      ReportProgress('Skiping: ' + Chapter.ChapterTypeName);
      Exit;
    end;

  if aContainer.Skipped then begin
    if ((not wbReportMode) or DumpCheckReport) then WriteLn(aIndent, '<contents skipped>');
  end else begin
    Supports(aContainer, IwbContainerElementRef, ContainerRef);
    for i := 0 to Pred(aContainer.ElementCount) do
      WriteElement(aContainer.Elements[i], aIndent);
  end;
end;

procedure WriteElement(aElement: IwbElement; aIndent: string = '');
var
  Container   : IwbContainer;
  Name        : string;
  Value       : string;
  Error       : string;

  i            : Integer;
  GroupRecord  : IwbGroupRecord;
begin
  if Assigned(DumpGroups) and (aElement.ElementType = etGroupRecord) then
    if Supports(aElement, IwbGroupRecord, GroupRecord) then
      if GroupRecord.GroupType = 0 then begin
        if not DumpGroups.Find(String(TwbSignature(GroupRecord.GroupLabel)), i) then
          Exit;
      end
      else
        if Assigned(SkipChildGroups) and Assigned(GroupRecord.ChildrenOf) and
           SkipChildGroups.Find(String(TwbSignature(GroupRecord.ChildrenOf.Signature)), i)
        then
          Exit;

  if aElement.ElementType = etMainRecord then
    Inc(DumpCount);
  if (DumpMax > 0) and (DumpCount > DumpMax) then
    Exit;

  Name := aElement.Name;
  Value := aElement.Value;
  if DumpCheckReport then
    Error := aElement.Check;

  if (aElement.Name <> 'Unused') and (Name <> 'Unused') then begin
    if (Name <> '') and ((not wbReportMode) or DumpCheckReport) then
      Write(aIndent, Name);
    if (Name <> '') or (Value <> '') then
      aIndent := aIndent + '  ';
    if (Value <> '') and (Pos('Hidden: ', Name)<>1) then begin
      if ((not wbReportMode) or DumpCheckReport) then
        WriteLn(': ', Value);
    end else begin
      if (Name <> '') and ((not wbReportMode) or DumpCheckReport) then
        WriteLn;
    end;
  end;

  if DumpCheckReport and (Error <> '') then
    WriteLn(aIndent, '[ERROR: ', Error ,']');

  if Supports(aElement, IwbContainer, Container) and (Pos('Hidden: ', Name)<>1) then
    WriteContainer(Container, aIndent);
end;

{==============================================================================}
function CheckForErrors(const aIndent: Integer; const aElement: IwbElement): Boolean;
var
  Error                       : string;
  Container                   : IwbContainerElementRef;
  i                           : Integer;
  GroupRecord                 : IwbGroupRecord;
begin
  Error := aElement.Check;
  Result := Error <> '';
  if Result then
    WriteLn(StringOfChar(' ', aIndent * 2) + aElement.Name, ' -> ', Error);

  if Supports(aElement, IwbContainerElementRef, Container) then begin

    if (wbToolSource in [tsPlugins]) then if (Container.ElementType = etGroupRecord) then
      if Supports(Container, IwbGroupRecord, GroupRecord) then
        if GroupRecord.GroupType = 0 then begin
          if Assigned(DumpGroups) and not DumpGroups.Find(String(TwbSignature(GroupRecord.GroupLabel)), i) then
            Exit;
          ReportProgress('Checking: ' + GroupRecord.Name);
        end
        else
          if Assigned(SkipChildGroups) and Assigned(GroupRecord.ChildrenOf) and
             SkipChildGroups.Find(String(TwbSignature(GroupRecord.ChildrenOf.Signature)), i)
          then
            Exit;

    for i := Pred(Container.ElementCount) downto 0 do
      Result := CheckForErrors(aIndent + 1, Container.Elements[i]) or Result;
  end;

  if Result and (Error = '') then
    WriteLn(StringOfChar(' ', aIndent * 2), 'Above errors were found in: ', aElement.Name);
end;
{==============================================================================}


{==============================================================================}

function wbFindCmdLineParam(const aSwitch     : string;
                            const aChars      : TSysCharSet;
                                  aIgnoreCase : Boolean;
                              out aValue      : string)
                                              : Boolean; overload;
var
  i : Integer;
  s : string;
begin
  Result := False;
  aValue := '';
  for i := 1 to ParamCount do begin
    s := ParamStr(i);
    if (aChars = []) or (s[1] in aChars) then
      if aIgnoreCase then begin
        if AnsiCompareText(Copy(s, 2, Length(aSwitch)), aSwitch) = 0 then begin
          if (length(s)>(length(aSwitch)+2)) and (s[Length(aSwitch) + 2] = ':') then begin
            aValue := Copy(s, Length(aSwitch) + 3, MaxInt);
            Result := True;
            Exit;
          end;
        end;
      end else
        if AnsiCompareStr(Copy(s, 2, Length(aSwitch)), aSwitch) = 0 then begin
          if s[Length(aSwitch) + 2] = ':' then begin
            aValue := Copy(s, Length(aSwitch) + 3, MaxInt);
            Result := True;
            Exit;
          end;
        end;
  end;
end;
{------------------------------------------------------------------------------}
function wbFindCmdLineParam(const aSwitch : string;
                              out aValue  : string)
                                          : Boolean; overload;
begin
  Result := wbFindCmdLineParam(aSwitch, SwitchChars, True, aValue);
end;
{==============================================================================}

function CheckAppPath: string;
const
  //gmFNV, gmFO3, gmTES3, gmTES4, gmTES5, gmFO4
  ExeName : array[TwbGameMode] of string =(
    'FalloutNV.exe',  // gmFNV
    'Fallout3.exe',   // gmFO3
    'Morrowind.exe',  // gmTES3
    'Oblivion.exe',   // gmTES4
    'TESV.exe',       // gmTES5
    'SkyrimVR.exe',   // gmTES5VR
    'SkyrimSE.exe',   // gmSSE
    'Fallout4.exe',   // gmFO4
    'Fallout4VR.exe', // gmFO4VR
    'Fallout76.exe'  // gmFO76
  );

var
  s: string;
begin
  Result := '';
  s := ParamStr(0);
  s := ExtractFilePath(s);
  while Length(s) > 3 do begin
    if FileExists(s + ExeName[wbGameMode]) and DirectoryExists(s + 'Data') then begin
      Result := s;
      Exit;
    end;
    s := ExtractFilePath(ExcludeTrailingPathDelimiter(s));
  end;
end;

function CheckParamPath: string; // for Dump, do we have bsa in the same directory
var
  s: string;
  F : TSearchRec;
begin
  Result := '';
  s := ParamStr(ParamCount);
  s := ChangeFileExt(s, '*' + wbArchiveExtension);
  if FindFirst(s, faAnyfile, F)=0 then begin
    Result := ExtractFilePath(ParamStr(ParamCount));
    SysUtils.FindClose(F);
  end;
end;

procedure DoInitPath;
const
  sBethRegKey   = '\SOFTWARE\Bethesda Softworks\';
  sBethRegKey64 = '\SOFTWARE\Wow6432Node\Bethesda Softworks\';
  sTempRegKey   = '\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\';
  sTempRegKey64 = '\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\';
var
  ProgramPath : String;
  DataPath    : String;
begin
  ProgramPath := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)));

  if not wbFindCmdLineParam('D', DataPath) then begin
    DataPath := CheckAppPath;

    if DataPath = '' then with TRegistry.Create do try
      RootKey := HKEY_LOCAL_MACHINE;

      if wbGameMode = gmFO76 then begin
        if not OpenKeyReadOnly(sTempRegKey + wbGameNameReg + '\') then
          if not OpenKeyReadOnly(sTempRegKey64 + wbGameNameReg + '\') then begin
            ReportProgress('Warning: Could not open registry key: ' + sTempRegKey + wbGameNameReg + '\');
            Exit;
          end;

        wbDataPath := ReadString('Path');
            wbDataPath := StringReplace(wbDataPath, '"', '', [rfReplaceAll]);

        if wbDataPath = '' then begin
          ReportProgress('Warning: Could not determine ' + wbGameName2 + ' installation path, no "Path" registry key');
        end;
      end else begin
        if not OpenKeyReadOnly(sBethRegKey + wbGameNameReg + '\') then
          if not OpenKeyReadOnly(sBethRegKey64 + wbGameNameReg + '\') then begin
            ReportProgress('Warning: Could not open registry key: ' + sBethRegKey + wbGameName + '\');
            ReportProgress('This can happen after Steam updates, run game''s launcher to restore registry settings');
            Exit;
          end;

        DataPath := ReadString('Installed Path');

        if DataPath = '' then begin
          ReportProgress('Warning: Could not determine '+wbGameName+' installation path, no "Installed Path" registry key');
          ReportProgress('This can happen after Steam updates, run game''s launcher to restore registry settings');
        end;
      end;
    finally
      Free;
    end;

    if DataPath <>'' then
      DataPath := IncludeTrailingPathDelimiter(DataPath) + 'Data\';
  end else
    DataPath := IncludeTrailingPathDelimiter(DataPath);

  wbDataPath := DataPath;
end;

function isMode(aMode: String): Boolean;
begin
  Result := FindCmdLineSwitch(aMode) or (Pos(Uppercase(aMode), UpperCase(ExtractFileName(ParamStr(0))))<>0);
end;

function isFormatValid(aFormatName: String): Boolean;
begin
  if Uppercase(aFormatName) = 'RAW' then
    Result := True
  else if Uppercase(aFormatName) = 'UESPWIKI' then
    Result := True
  else
    Result := False;
end;

procedure SwitchToCoSave;
begin
  case wbGameMode of
    gmFNV:            SwitchToFNVCoSave;
    gmFO3:            SwitchToFO3CoSave;
    gmFO4, gmFO4vr:   SwitchToFO4CoSave;
    gmTES4:           SwitchToTES4CoSave;
    gmTES5, gmTES5vr: SwitchToTES5CoSave;
    gmSSE:            SwitchToTES5CoSave;
  end;
end;

var
  NeedsSyntaxInfo : Boolean;
  s, t            : string;
  i,j             : integer;
  c               : Integer;
  _File           : IwbFile;
  Masters         : TStringList;
  IsLocalized     : Boolean;
//  F               : TSearchRec;
  n,m             : TStringList;
  Pass            : TwbExportPass;
  ts              : TwbToolSource;
  tm              : TwbToolMode;
  gm              : TwbGameMode;
  tss             : TwbSetOfSource;
  tms             : TwbSetOfMode;
  Found           : Boolean;
begin
  {$IF CompilerVersion >= 24}
  FormatSettings.DecimalSeparator := '.';
  {$ELSE}
  SysUtils.DecimalSeparator := '.';
  {$IFEND}
  _wbProgressCallback := ReportProgress;
  wbDontSave := True;
  wbAllowInternalEdit := False;
  wbMoreInfoForUnknown := False;
  wbSimpleRecords := False;
  wbHideUnused := False;
  StartTime := Now;

  try
    try
      t := ExtractFileName(ParamStr(0)).ToLowerInvariant;

      Found := False;
      for ts := Low(TwbToolSource) to High(TwbToolSource) do begin
        s := GetEnumName(TypeInfo(TwbToolSource), Ord(ts) );
        Delete(s, 1, 2);
        if FindCmdLineSwitch(s) then begin
          wbToolSource := ts;
          Found := True;
          Break;
        end;
      end;
      if not Found then
        for ts := Low(TwbToolSource) to High(TwbToolSource) do begin
          s := GetEnumName(TypeInfo(TwbToolSource), Ord(ts) ).ToLowerInvariant;
          Delete(s, 1, 2);
          if t.Contains(s) then begin
            wbToolSource := ts;
            Found := True;
            Break;
          end;
        end;
      if not Found then
        wbToolSource := tsPlugins;

      Found := False;
      for tm := Low(TwbToolMode) to High(TwbToolMode) do begin
        s := GetEnumName(TypeInfo(TwbToolMode), Ord(tm) );
        Delete(s, 1, 2);
        if FindCmdLineSwitch(s) then begin
          wbToolMode := tm;
          Found := True;
          Break;
        end;
      end;
      if not Found then
        for tm := Low(TwbToolMode) to High(TwbToolMode) do begin
          s := GetEnumName(TypeInfo(TwbToolMode), Ord(tm) ).ToLowerInvariant;
          Delete(s, 1, 2);
          if t.Contains(s) then begin
            wbToolMode := tm;
            Found := True;
            Break;
          end;
        end;
      if not Found then begin
        WriteLn(ErrOutput, 'Can''t determine ToolMode.');
        Exit;
      end;

      Found := False;
      for gm := Low(TwbGameMode) to High(TwbGameMode) do begin
        s := GetEnumName(TypeInfo(TwbGameMode), Ord(gm) );
        Delete(s, 1, 2);
        if FindCmdLineSwitch(s) then begin
          wbGameMode := gm;
          Found := True;
          Break;
        end;
      end;
      if not Found then
        for gm := Low(TwbGameMode) to High(TwbGameMode) do begin
          s := GetEnumName(TypeInfo(TwbGameMode), Ord(gm) ).ToLowerInvariant;
          Delete(s, 1, 2);
          if t.Contains(s) then begin
            wbGameMode := gm;
            Found := True;
            Break;
          end;
        end;
      if not Found then begin
        WriteLn(ErrOutput, 'Can''t determine GameMode.');
        Exit;
      end;

      wbToolName := GetEnumName(TypeInfo(TwbToolMode), Ord(wbToolMode) );
      Delete(wbToolName, 1 ,2);
      wbSourceName := GetEnumName(TypeInfo(TwbToolSource), Ord(wbToolSource) );
      Delete(wbSourceName, 1 ,2);
      wbAppName := GetEnumName(TypeInfo(TwbGameMode), Ord(wbGameMode) );
      Delete(wbAppName, 1 ,2);

      wbLoadBSAs := FindCmdLineSwitch('bsa') or FindCmdLineSwitch('allbsa');
      tss := [tsPlugins, tsSaves];
      tms := [tmDump, tmExport];

      wbLanguage := 'English';

      case wbGameMode of
        gmFNV: begin
          wbGameName := 'FalloutNV';
          case wbToolSource of
            tsSaves:   DefineFNVSaves;
            tsPlugins: DefineFNV;
          end;
        end;
        gmFO3: begin
          wbGameName := 'Fallout3';
          case wbToolSource of
            tsSaves:   DefineFO3Saves;
            tsPlugins: DefineFO3;
          end;
        end;
        gmTES3: begin
          wbGameName := 'Morrowind';
          wbLoadBSAs := false;
          tms := [tmDump];
          tss := [tsPlugins];
          DefineTES3;
        end;
        gmTES4: begin
          wbGameName := 'Oblivion';
          case wbToolSource of
            tsSaves:   DefineTES4Saves;
            tsPlugins: DefineTES4;
          end;
        end;
        gmTES5: begin
          wbGameName := 'Skyrim';
          case wbToolSource of
            tsSaves:   DefineTES5Saves;
            tsPlugins: DefineTES5;
          end;
        end;
        gmTES5VR: begin
          wbGameName := 'Skyrim';
          wbGameName2 := 'Skyrim VR';
          tss := [tsPlugins];
          case wbToolSource of
            //tsSaves:   DefineTES5Saves;
            tsPlugins: DefineTES5;
          end;
        end;
        gmFO4: begin
          wbGameName := 'Fallout4';
          wbCreateContainedIn := False;
          case wbToolSource of
            tsSaves:   DefineFO4Saves;
            tsPlugins: DefineFO4;
          end;
        end;
        gmFO4VR: begin
          wbGameName := 'Fallout4';
          wbGameName2 := 'Fallout4VR';
          wbGameNameReg := 'Fallout 4 VR';
          wbCreateContainedIn := False;
          tss := [tsPlugins];
          case wbToolSource of
            //tsSaves:   DefineFO4Saves;
            tsPlugins: DefineFO4;
          end;
        end;
        gmSSE: begin
          wbGameName := 'Skyrim';
          wbGameName2 := 'Skyrim Special Edition';
          case wbToolSource of
            tsSaves:   DefineTES5Saves;
            tsPlugins: DefineTES5;
          end;
        end;
        gmFO76: begin
          wbGameName := 'Fallout76';
          wbGameNameReg := 'Fallout 76';
          wbGameMasterEsm := 'SeventySix.esm';
          wbCreateContainedIn := False;
          tss := [tsPlugins];
          case wbToolSource of
            tsPlugins: DefineFO76;
          end;
        end;
      else
        WriteLn(ErrOutput, 'Application name must contain FNV, FO3, FO4, FO4VR, FO76, SSE, TES4, TES5 or TES5VR to select game.');
        Exit;
      end;

      if wbGameName2 = '' then
        wbGameName2 := wbGameName;

      if wbGameNameReg = '' then
        wbGameNameReg := wbGameName2;

      if wbGameMasterEsm = '' then
        wbGameMasterEsm := wbGameName + csDotEsm;

      if not (wbToolMode in tms) then begin
        WriteLn(ErrOutput, 'Application '+wbGameName+' does not currently support ToolMode: '+wbToolName);
        Exit;
      end;
      if not (wbToolSource in tss) then begin
        WriteLn(ErrOutput, 'Application '+wbGameName+' does not currently support ToolSource: '+wbSourceName);
        Exit;
      end;

      if wbGameMode in [gmFO4, gmFO4vr, gmFO76] then
        wbArchiveExtension := '.ba2';

      DoInitPath;
      if (wbToolMode in [tmDump]) and (wbDataPath = '') then // Dump can be run in any directory configuration
        wbDataPath := CheckParamPath;

      wbLoadModules;

      if FindCmdLineSwitch('report') then
        wbReportMode := True
      else
        wbReportMode := False;

      if FindCmdLineSwitch('dcr') then begin
        wbReportMode := True;
        DumpCheckReport := True;
      end;

      if wbReportMode then
        wbShowFlagEnumValue := True;

      if not FindCmdLineSwitch('q') and not wbReportMode then begin
        WriteLn(ErrOutput, wbAppName, wbToolName,' ', VersionString.ToString);
        WriteLn(ErrOutput);

        WriteLn(ErrOutput, 'This Program is subject to the Mozilla Public License');
        WriteLn(ErrOutput, 'Version 1.1 (the "License"); you may not use this program except in');
        WriteLn(ErrOutput, 'compliance with the License. You may obtain a copy of the License at');
        WriteLn(ErrOutput, 'http://www.mozilla.org/MPL/');
        WriteLn(ErrOutput);
        WriteLn(ErrOutput, 'Software distributed under the License is distributed on an "AS IS"');
        WriteLn(ErrOutput, 'basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the');
        WriteLn(ErrOutput, 'License for the specific language governing rights and limitations');
        WriteLn(ErrOutput, 'under the License.');
        WriteLn(ErrOutput);
      end;

      if wbFindCmdLineParam('dg', s) then begin
        DumpGroups := TStringList.Create;
        DumpGroups.Sorted := True;
        DumpGroups.Duplicates := dupIgnore;
        DumpGroups.CommaText := s;
        DumpGroups.Sort;
      end;

      if wbFindCmdLineParam('xcg', s) then begin
        SkipChildGroups := TStringList.Create;
        SkipChildGroups.Sorted := True;
        SkipChildGroups.Duplicates := dupIgnore;
        SkipChildGroups.CommaText := s;
        SkipChildGroups.Sort;
      end;

      if wbFindCmdLineParam('dc', s) or wbFindCmdLineParam('df', s) then begin
        DumpChapters := TStringList.Create;
        DumpChapters.Sorted := True;
        DumpChapters.Duplicates := dupIgnore;
      end;

      if wbFindCmdLineParam('dc', s) then begin
        DumpChapters.CommaText := s;
        DumpChapters.Sort;
      end;

      if wbFindCmdLineParam('df', s) then begin
        DumpForms := TStringList.Create;
        DumpForms.Sorted := True;
        DumpForms.Duplicates := dupIgnore;
        DumpForms.CommaText := s;
        DumpForms.Sort;
        for i := 0 to DumpForms.Count-1 do try
          c := StrToInt(DumpForms[i]);
          DumpChapters.Add(IntToStr(wbChangedFormOffset+c));
        finally
        end;
        DumpForms.Free;
      end;

      wbLoadAllBSAs := FindCmdLineSwitch('allbsa');

      if FindCmdLineSwitch('more') then
        wbMoreInfoForUnknown:= True
      else
        wbMoreInfoForUnknown:= False;

      if wbFindCmdLineParam('xr', s) then
        RecordToSkip.CommaText := s;

      if wbFindCmdLineParam('xg', s) then
        GroupToSkip.CommaText := s
      else if FindCmdLineSwitch('xbloat') then begin
        GroupToSkip.Add('LAND');
        GroupToSkip.Add('REGN');
        GroupToSkip.Add('PGRD');
        GroupToSkip.Add('SCEN');
        GroupToSkip.Add('PACK');
        GroupToSkip.Add('PERK');
        GroupToSkip.Add('NAVI');
        GroupToSkip.Add('CELL');
        GroupToSkip.Add('WRLD');
      end;

      if wbFindCmdLineParam('xc', s) then
        ChaptersToSkip.CommaText := s
      else if FindCmdLineSwitch('xcbloat') then begin
        ChaptersToSkip.Add('1001');
      end;

      if wbFindCmdLineParam('xf', s) then begin
        DumpForms := TStringList.Create;
        DumpForms.Sorted := True;
        DumpForms.Duplicates := dupIgnore;
        DumpForms.CommaText := s;
        DumpForms.Sort;
        for i := 0 to DumpForms.Count-1 do try
          c := StrToInt(DumpForms[i]);
          ChaptersToSkip.Add(IntToStr(wbChangedFormOffset+c));
        finally
        end;
        DumpForms.Free;
      end;

      if wbGameMode in [gmFO4, gmFO4vr, gmFO76] then
        wbLanguage := 'En';

      if wbGameMode <= gmTES5 then
        wbAddDefaultLEncodingsIfMissing(False)
      else begin
        wbLEncodingDefault[False] := TEncoding.UTF8;
        case wbGameMode of
        gmSSE, gmTES5VR:
          wbAddLEncodingIfMissing('english', '1252', False);
        else {FO4, FO76}
          wbAddLEncodingIfMissing('en', '1252', False);
        end;
      end;

      wbAddDefaultLEncodingsIfMissing(True);

      if wbFindCmdLineParam('l', s) then begin
        wbLanguage := s;
      end else
        if FileExists(wbTheGameIniFileName) then begin
          with TMemIniFile.Create(wbTheGameIniFileName) do try
            case wbGameMode of
              gmTES4: case ReadInteger('Controls', 'iLanguage', 0) of
                1: s := 'German';
                2: s := 'French';
                3: s := 'Spanish';
                4: s := 'Italian';
              else
                s := 'English';
              end;
            else
              s := Trim(ReadString('General', 'sLanguage', '')).ToLower;
            end;
            if (s <> '') and not SameText(s, wbLanguage) then
              wbLanguage := s;
          finally
            Free;
          end;
        end;

      wbEncodingTrans := wbEncodingForLanguage(wbLanguage, False);

      if wbFindCmdLineParam('cp-general', s) then
        wbEncoding :=  wbMBCSEncoding(s);

      if wbFindCmdLineParam('cp', s) or wbFindCmdLineParam('cp-trans', s) then
        wbEncodingTrans :=  wbMBCSEncoding(s);

      if wbFindCmdLineParam('bts', s) then
        wbBytesToSkip := StrToInt64Def(s, wbBytesToSkip);
      if wbFindCmdLineParam('btd', s) then
        wbBytesToDump := StrToInt64Def(s, wbBytesToDump);

      if wbFindCmdLineParam('do', s) then
        wbDumpOffset := StrToInt64Def(s, wbDumpOffset);

      if wbFindCmdLineParam('top', s) then
        DumpMax := StrToIntDef(s, 0);

      s := ParamStr(ParamCount);

      NeedsSyntaxInfo := False;
      if (wbToolMode in [tmDump]) and (ParamCount >= 1) and not FileExists(s) then begin
        if s[1] in SwitchChars then
          WriteLn(ErrOutput, 'No inputfile was specified. Please check the command line parameters.')
        else
          WriteLn(ErrOutput, 'Can''t find the file "',s,'". Please check the command line parameters.');
        WriteLn;
        NeedsSyntaxInfo := True;
      end else if (wbToolMode in [tmExport]) and (ParamCount >=1) and not isFormatValid(s) then begin
        if s[1] in SwitchChars then
          WriteLn(ErrOutput, 'No format was specified. Please check the command line parameters.')
        else
          WriteLn(ErrOutput, 'Cannot handle the format "',s,'". Please check the command line parameters.');
        WriteLn;
        NeedsSyntaxInfo := True;
      end;
      if wbToolSource = tsSaves then
        case wbGameMode of
          gmFNV:    if SameText(ExtractFileExt(s), '.nvse') then SwitchToCoSave;
          gmFO3:    if SameText(ExtractFileExt(s), '.fose') then SwitchToCoSave
            else
              WriteLn(ErrOutput, 'Save are not supported yet "',s,'". Please check the command line parameters.');
          gmFO4,
          gmFO4vr:  if SameText(ExtractFileExt(s), '.f4se') then SwitchToCoSave;
          gmTES4:   if SameText(ExtractFileExt(s), '.obse') then SwitchToCoSave
            else
              WriteLn(ErrOutput, 'Save are not supported yet "',s,'". Please check the command line parameters.');
          gmTES5,
          gmTES5vr: if SameText(ExtractFileExt(s), '.skse') then SwitchToCoSave;
          gmSSE:    if SameText(ExtractFileExt(s), '.skse') then SwitchToCoSave;
        else
            WriteLn(ErrOutput, 'CoSave are not supported yet "',s,'". Please check the command line parameters.');
        end;

      if NeedsSyntaxInfo or (ParamCount < 1) or FindCmdLineSwitch('?') or FindCmdLineSwitch('help') then begin
        WriteLn(ErrOutput, 'Syntax:  '+wbAppName+'Dump [options] inputfile');
        WriteLn(ErrOutput, '  or     '+wbAppName+'Export [options] format');
        WriteLn(ErrOutput);
        WriteLn(ErrOutput, wbAppName + 'Dump will load the specified esp/esm files and all it''s masters and will dump the decoded contents of the specified file to stdout. Masters are searched for in the same directory as the specified file.');
        WriteLn(ErrOutput);
        WriteLn(ErrOutput, wbAppName + 'Dump -Saves will load the specified save or coSave file and all it''s masters and will dump the decoded contents of the specified file to stdout. Masters are searched for in the game directory.');
        WriteLn(ErrOutput);
        WriteLn(ErrOutput, wbAppName + 'Export will dump the plugin definition in the specified format.');
        WriteLn(ErrOutput, wbAppName + 'Export -Saves will dump the save file definition in the specified format.');
        WriteLn(ErrOutput);
        WriteLn(ErrOutput, 'You can use the normal redirect mechanism to send the output to a file.');
        WriteLn(ErrOutput, 'e.g. "'+wbAppName+'Dump '+wbGameMasterEsm+' > '+wbGameName+'.txt"');
        WriteLn(ErrOutput);
        WriteLn(ErrOutput, 'Currently supported options:');
        WriteLn(ErrOutput, '-? / -help   ', 'This help screen');
        WriteLn(ErrOutput, '-q           ', 'Suppress version message');
        WriteLn(ErrOutput, '-more        ', 'Displays aditional information on Unknowns');
        WriteLn(ErrOutput, '-l:language  ', 'Specifies language for localization files (since TES5)');
        WriteLn(ErrOutput, '             ', '  Default language is English for TES5 or SSE and En for FO4');
        WriteLn(ErrOutput, '-bsa         ', 'Loads default associated BSAs');
        WriteLn(ErrOutput, '             ', ' (plugin'+wbArchiveExtension+' and plugin - interface.'+wbArchiveExtension+')');
        WriteLn(ErrOutput, '-allbsa      ', 'Loads all associated BSAs (plugin*.bsa)');
        WriteLn(ErrOutput, '             ', '   useful if strings are in a non-standard BSA');
        WriteLn(ErrOutput, '-d:datapath  ', 'Path to the game plugins directory');
        WriteLn(ErrOutput, '-do:value    ', 'Dump objects offsets and size and/or array count');
        WriteLn(ErrOutput, '             ', '  -do:0 nothing');
        WriteLn(ErrOutput, '             ', '  -do:1 starting offset');
        WriteLn(ErrOutput, '             ', '  -do:2 starting offset and array count  PERFORMANCE PENALTY');
        WriteLn(ErrOutput, '             ', '  -do:3 starting and ending offset, size and array count  PERFORMANCE PENALTY');
        WriteLn(ErrOutput, '-bts         ', 'BytesToSkip  = number of undecoded bytes to skip, default = 0');
        WriteLn(ErrOutput, '-btd         ', 'BytesToDump  = number of undecoded bytes to dump as unknown, default = all');
        WriteLn(ErrOutput, '             ', '');
        WriteLn(ErrOutput, 'Plugin mode ONLY');
        WriteLn(ErrOutput, '-xr:list     ', 'Excludes the contents of specified records from being');
        WriteLn(ErrOutput, '             ', '  decompressed and processed.');
        WriteLn(ErrOutput, '-xg:list     ', 'Excludes complete top level groups from being processed');
        WriteLn(ErrOutput, '-xcg:list    ', 'Excludes record child groups from being processed');
        WriteLn(ErrOutput, '-xbloat      ', 'The following value applies:');
        WriteLn(ErrOutput, '             ', '  -xg:LAND,REGN,PGRD,SCEN,PACK,PERK,NAVI,CELL,WRLD');
        WriteLn(ErrOutput, '-dg:list     ', 'If specified, only dump the listed top level groups');
        WriteLn(ErrOutput, '-top:N       ', 'If specified, only dump the first N records');
        WriteLn(ErrOutput, '-check       ', 'Performs "Check for Errors" instead of dumping content');
        WriteLn(ErrOutput, '-dcr         ', 'Dumps record content while performing "Check for Errors" on each element and generates a report');
        WriteLn(ErrOutput, '             ', '');
        WriteLn(ErrOutput, 'Saves mode ONLY');
        WriteLn(ErrOutput, '-df:list     ', 'If specified, only dump the listed ChangedForm type');
        WriteLn(ErrOutput, '-xf:list     ', 'Excludes complete ChangedForm type from being processed');
        WriteLn(ErrOutput, '-dc:GlobalDataIDlist   ', 'If specified, only process those global data ID');
        WriteLn(ErrOutput, '-xc:GlobalDataIDlist   ', 'Excludes those global data from being processed');
        WriteLn(ErrOutput, '-xcbloat     ', 'The following value applies:');
        WriteLn(ErrOutput, '             ', '  -xc:1001');
        WriteLn(ErrOutput, '             ', '    1001 is the ID of Papyrus data the largest part of the save.');
        WriteLn(ErrOutput, '             ', '');
        WriteLn(ErrOutput, 'Example: full dump of Fallout4.esm excluding "bloated" records');
        WriteLn(ErrOutput, '  TES5Dump.exe -FO4 -xr:NAVI,NAVM,WRLD,CELL,LAND,REFR,ACHR Fallout4.esm');
        WriteLn(ErrOutput, '             ', '');
        WriteLn(ErrOutput, 'Currently supported export formats:');
        WriteLn(ErrOutput, 'RAW          ','Private format for debugging');
        WriteLn(ErrOutput, 'UESPWIKI     ','UESP Wiki table format [Very WIP]');
        WriteLn(ErrOutput, '             ', '');
        Exit;
      end;

      if wbToolMode = tmExport then begin
        wbLoadBSAs := False;
        wbReportMode := False;
        wbMoreInfoForUnknown:= False;
      end;

      if not Assigned(wbContainerHandler) then
        wbContainerHandler := wbCreateContainerHandler;

      StartTime := Now;
      ReportProgress('['+s+'] Application name : '+wbAppName+' - '+wbGamename+
        ' Mode:'+wbToolName+' Source:'+wbSourceName);
      if Assigned(Dumpgroups) then
        ReportProgress('['+s+']   Dumping groups : '+DumpGroups.CommaText);
      if Assigned(GroupToSkip) and (GroupToSkip.Count>0) then
        ReportProgress('['+s+']   Excluding groups : '+GroupToSkip.CommaText);
      if Assigned(RecordToSkip) and (RecordToSkip.Count>0) then
        ReportProgress('['+s+']   Excluding records : '+RecordToSkip.CommaText);

      if Assigned(DumpChapters) then
        ReportProgress('['+s+']   Dumping chapters : '+DumpChapters.CommaText);
      if Assigned(ChaptersToSkip) and (ChaptersToSkip.Count>0) then
        ReportProgress('['+s+']   Excluding chapters : '+ChaptersToSkip.CommaText);
      if wbBytesToSkip>0 then
        ReportProgress('['+s+']   BytesToSkip : '+IntToStr(wbBytesToSkip));
      if wbBytesToDump<$FFFFFFFF then
        ReportProgress('['+s+']   BytesToDump : '+IntToStr(wbBytesToDump));
      if wbDumpOffset>0 then
        ReportProgress('['+s+']   Dump Offset mode : '+IntToStr(wbDumpOffset));

      Masters := TStringList.Create;
      try
        IsLocalized := False;
        wbMastersForFile(s, Masters, nil, nil, @IsLocalized);
        if IsLocalized and not wbLoadBSAs and not FindCmdLineSwitch('nobsa') then begin
          t := ExtractFilePath(s) + 'Strings\' + ChangeFileExt(ExtractFileName(s), '') + '_' + wbLanguage + '.STRINGS';
          if not FileExists(t) then
            wbLoadBSAs := True;
        end;
        if wbLoadBSAs then begin
          Masters.Add(ExtractFileName(s));

          if wbLoadAllBSAs then begin
            n := TStringList.Create;
            try
              m := TStringList.Create;
              try
                if (Length(wbTheGameIniFileName)>0) and (FindBSAs(wbTheGameIniFileName, wbDataPath, n, m)>0) then begin
                  for i := 0 to Pred(n.Count) do begin
                    ReportProgress('[' + n[i] + '] Loading Resources.');
                    wbContainerHandler.AddBSA(MakeDataFileName(n[i], wbDataPath));
                  end;
                end;
              finally
                FreeAndNil(m);
              end;
            finally
              FreeAndNil(n);
            end;
          end;

          for i := 0 to Pred(Masters.Count) do begin
            if wbLoadAllBSAs then begin
    //          if (ExtractFileExt(Masters[i]) = '.esp') or (wbGameMode in [gmFO3, gmFNV, gmTES5]) then begin
    //            s2 := ChangeFileExt(Masters[i], '');
    //            if FindFirst(wbDataPath + s2 + '*.bsa', faAnyFile, F) = 0 then try
    //              repeat
    //                ReportProgress('[' + F.Name + '] Loading Resources.');
    //                wbContainerHandler.AddBSA(wbDataPath + F.Name);
    //              until FindNext(F) <> 0;
    //            finally
    //              SysUtils.FindClose(F);
    //            end;
    //          end;
              n := TStringList.Create;
              try
                m := TStringList.Create;
                try
                  if HasBSAs(ChangeFileExt(Masters[i], ''), wbDataPath,
                      wbGameMode in [gmTES5, gmTES5vr, gmSSE], wbGameMode in [gmTES5, gmTES5vr, gmSSE], n, m)>0 then begin
                    for j := 0 to Pred(n.Count) do begin
                      ReportProgress('[' + n[j] + '] Loading Resources.');
                      wbContainerHandler.AddBSA(MakeDataFileName(n[j], wbDataPath));
                    end;
                  end;
                finally
                  FreeAndNil(m);
                end;
              finally
                FreeAndNil(n);
              end;
            end else begin
    //          if (ExtractFileExt(Masters[i]) = '.esp') or (wbGameMode in [gmFO3, gmFNV, gmTES5]) then begin
    //            s2 := ChangeFileExt(Masters[i], '');
    //            if FindFirst(wbDataPath + s2 + '.bsa', faAnyFile, F) = 0 then try
    //              repeat
    //                ReportProgress('[' + F.Name + '] Loading Resources.');
    //                wbContainerHandler.AddBSA(wbDataPath + F.Name);
    //              until FindNext(F) <> 0;
    //            finally
    //              SysUtils.FindClose(F);
    //            end;
    //            if FindFirst(wbDataPath + s2 + ' - Interface.bsa', faAnyFile, F) = 0 then try
    //              repeat
    //                ReportProgress('[' + F.Name + '] Loading Resources.');
    //                wbContainerHandler.AddBSA(wbDataPath + F.Name);
    //              until FindNext(F) <> 0;
    //            finally
    //              SysUtils.FindClose(F);
    //            end;
    //          end;
              n := TStringList.Create;
              try
                m := TStringList.Create;
                try
                  if HasBSAs(ChangeFileExt(Masters[i], ''), wbDataPath, true, false, n, m)>0 then begin
                    for j := 0 to Pred(n.Count) do begin
                      ReportProgress('[' + n[j] + '] Loading Resources.');
                      wbContainerHandler.AddBSA(MakeDataFileName(n[j], wbDataPath));
                    end;
                  end;
                  m.Clear;
                  n.Clear;
                  if HasBSAs(ChangeFileExt(Masters[i], '')+' - Interface', wbDataPath, true, false, n, m)>0 then begin
                    for j := 0 to Pred(n.Count) do begin
                      ReportProgress('[' + n[j] + '] Loading Resources.');
                      wbContainerHandler.AddBSA(MakeDataFileName(n[j], wbDataPath));
                    end;
                  end;
                  m.Clear;
                  n.Clear;
                  if HasBSAs(ChangeFileExt(Masters[i], '')+' - Localization', wbDataPath, true, false, n, m)>0 then begin
                    for j := 0 to Pred(n.Count) do begin
                      ReportProgress('[' + n[j] + '] Loading Resources.');
                      wbContainerHandler.AddBSA(MakeDataFileName(n[j], wbDataPath));
                    end;
                  end;
                finally
                  FreeAndNil(m);
                end;
              finally
                FreeAndNil(n);
              end;
            end;
          end;
        end;
      finally
        FreeAndNil(Masters);
      end;

      ReportProgress('[' + wbDataPath + '] Setting Resource Path.');
      wbContainerHandler.AddFolder(wbDataPath);

      if wbToolMode in [tmDump] then
        _File := wbFile(s, High(Integer));

      with wbModuleByName(wbGameMasterEsm)^ do
        if mfHasFile in miFlags then begin
          s := wbProgramPath + wbGameName + wbHardcodedDat;
          if FileExists(s) then
            wbFile(s, 0, wbGameMasterEsm);
        end;

      ReportProgress('Finished loading record. Starting Dump.');

      if wbToolMode in [tmDump] then begin
        if FindCmdLineSwitch('check') and not wbReportMode then
          CheckForErrors(0, _File)
        else
          WriteContainer(_File);

        if wbReportMode then begin
          if DumpCheckReport then begin
            WriteLn;
            WriteLn('==================================== REPORT ====================================');
            WriteLn;
          end;

          ReportDefs;
        end;
      end else if wbToolMode in [tmExport] then begin
        for Pass := epRead to epRemaining do begin
          ProfileHeader(StrToTExportFormat(s), Pass);
          ProfileArray(StrToTExportFormat(s), Pass);
          ProfileChapters(StrToTExportFormat(s), Pass);
        end;

        wbDefProfiles.SaveToFile(wbAppName+wbToolName+wbSourceName+'.txt');
      end;

      ReportProgress('All Done.');
    except
      on e: Exception do
        ReportProgress('Unexpected Error: <'+e.ClassName+': '+e.Message+'>');
    end;
  finally
    if DebugHook <> 0 then begin
      ReportProgress('Press enter to continue...');
      ReadLn;
    end;
  end;
end.
