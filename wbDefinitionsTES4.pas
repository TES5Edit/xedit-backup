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

unit wbDefinitionsTES4;

{$I wbDefines.inc}

interface

uses
  wbInterface;

var
	wbPKDTFlags: IwbFlagsDef;
	wbServiceFlags: IwbFlagsDef;

	wbAxisEnum: IwbEnumDef;
	wbBlendModeEnum: IwbEnumDef;
	wbBlendOpEnum: IwbEnumDef;
	wbCrimeTypeEnum: IwbEnumDef;
	wbFormTypeEnum: IwbEnumDef;
	wbFunctionsEnum: IwbEnumDef;
	wbMagicSchoolEnum: IwbEnumDef;
	wbMusicEnum: IwbEnumDef;
	wbOBMEResolutionInfo: IwbEnumDef;
	wbPKDTType: IwbEnumDef;
	wbQuadrantEnum: IwbEnumDef;
	wbSexEnum: IwbEnumDef;
	wbSkillEnum: IwbEnumDef;
	wbSoulGemEnum: IwbEnumDef;
	wbSpecializationEnum: IwbEnumDef;
	wbZTestFuncEnum: IwbEnumDef;

procedure DefineTES4;

implementation

uses
  Types,
  Classes,
  SysUtils,
  Math,
  Variants,
  wbHelpers,
  wbDefinitionsCommon;

const
  ACBS : TwbSignature = 'ACBS';
  ACHR : TwbSignature = 'ACHR';
  ACRE : TwbSignature = 'ACRE';
  TRGT : TwbSignature = 'TRGT';
  ACTI : TwbSignature = 'ACTI';
  AIDT : TwbSignature = 'AIDT';
  ALCH : TwbSignature = 'ALCH';
  AMMO : TwbSignature = 'AMMO';
  ANAM : TwbSignature = 'ANAM';
  ANIO : TwbSignature = 'ANIO';
  APPA : TwbSignature = 'APPA';
  ARMO : TwbSignature = 'ARMO';
  ATTR : TwbSignature = 'ATTR';
  ATXT : TwbSignature = 'ATXT';
  BMDT : TwbSignature = 'BMDT';
  BNAM : TwbSignature = 'BNAM';
  BOOK : TwbSignature = 'BOOK';
  BSGN : TwbSignature = 'BSGN';
  BTXT : TwbSignature = 'BTXT';
  CELL : TwbSignature = 'CELL';
  CLAS : TwbSignature = 'CLAS';
  CLMT : TwbSignature = 'CLMT';
  CLOT : TwbSignature = 'CLOT';
  CNAM : TwbSignature = 'CNAM';
  CNTO : TwbSignature = 'CNTO';
  CONT : TwbSignature = 'CONT';
  CREA : TwbSignature = 'CREA';
  CSAD : TwbSignature = 'CSAD';
  CSCR : TwbSignature = 'CSCR';
  CSDC : TwbSignature = 'CSDC';
  CSDI : TwbSignature = 'CSDI';
  CSDT : TwbSignature = 'CSDT';
  CSTD : TwbSignature = 'CSTD';
  CSTY : TwbSignature = 'CSTY';
  CTDA : TwbSignature = 'CTDA';
  CTDT : TwbSignature = 'CTDT';
  DATA : TwbSignature = 'DATA';
  DATX : TwbSignature = 'DATX';
  DELE : TwbSignature = 'DELE';
  DESC : TwbSignature = 'DESC';
  DIAL : TwbSignature = 'DIAL';
  DNAM : TwbSignature = 'DNAM';
  DOOR : TwbSignature = 'DOOR';
  EDID : TwbSignature = 'EDID';
  EDDX : TwbSignature = 'EDDX';
  EFID : TwbSignature = 'EFID';
  EFIT : TwbSignature = 'EFIT';
  ACVA : TwbSignature = 'ACVA';
  EFII : TwbSignature = 'EFII';
  EFXX : TwbSignature = 'EFXX';
  EFIX : TwbSignature = 'EFIX';
  EFME : TwbSignature = 'EFME';
  EFSH : TwbSignature = 'EFSH';
  ENAM : TwbSignature = 'ENAM';
  ENCH : TwbSignature = 'ENCH';
  ENIT : TwbSignature = 'ENIT';
  ESCE : TwbSignature = 'ESCE';
  EYES : TwbSignature = 'EYES';
  FACT : TwbSignature = 'FACT';
  FGGA : TwbSignature = 'FGGA';
  FGGS : TwbSignature = 'FGGS';
  FGTS : TwbSignature = 'FGTS';
  FLOR : TwbSignature = 'FLOR';
  FLTV : TwbSignature = 'FLTV';
  FNAM : TwbSignature = 'FNAM';
  FULL : TwbSignature = 'FULL';
  FURN : TwbSignature = 'FURN';
  GLOB : TwbSignature = 'GLOB';
  GMST : TwbSignature = 'GMST';
  GNAM : TwbSignature = 'GNAM';
  GRAS : TwbSignature = 'GRAS';
  HAIR : TwbSignature = 'HAIR';
  HCLR : TwbSignature = 'HCLR';
  HEDR : TwbSignature = 'HEDR';
  HNAM : TwbSignature = 'HNAM';
  ICO2 : TwbSignature = 'ICO2';
  ICON : TwbSignature = 'ICON';
  IDLE : TwbSignature = 'IDLE';
  NULL : TwbSignature = 'NULL';
  INAM : TwbSignature = 'INAM';
  INDX : TwbSignature = 'INDX';
  INFO : TwbSignature = 'INFO';
  INGR : TwbSignature = 'INGR';
  JNAM : TwbSignature = 'JNAM';
  KEYM : TwbSignature = 'KEYM';
  KFFZ : TwbSignature = 'KFFZ';
  LAND : TwbSignature = 'LAND';
  LIGH : TwbSignature = 'LIGH';
  LNAM : TwbSignature = 'LNAM';
  LSCR : TwbSignature = 'LSCR';
  LTEX : TwbSignature = 'LTEX';
  LVLC : TwbSignature = 'LVLC';
  LVLD : TwbSignature = 'LVLD';
  LVLF : TwbSignature = 'LVLF';
  LVLI : TwbSignature = 'LVLI';
  LVLO : TwbSignature = 'LVLO';
  LVSP : TwbSignature = 'LVSP';
  MAST : TwbSignature = 'MAST';
  MGEF : TwbSignature = 'MGEF';
  MISC : TwbSignature = 'MISC';
  MNAM : TwbSignature = 'MNAM';
  MO2B : TwbSignature = 'MO2B';
  MO2T : TwbSignature = 'MO2T';
  MO3B : TwbSignature = 'MO3B';
  MO3T : TwbSignature = 'MO3T';
  MO4B : TwbSignature = 'MO4B';
  MO4T : TwbSignature = 'MO4T';
  MOD2 : TwbSignature = 'MOD2';
  MOD3 : TwbSignature = 'MOD3';
  MOD4 : TwbSignature = 'MOD4';
  MODB : TwbSignature = 'MODB';
  MODL : TwbSignature = 'MODL';
  MODT : TwbSignature = 'MODT';
  NAM0 : TwbSignature = 'NAM0';
  NAM1 : TwbSignature = 'NAM1';
  NAM2 : TwbSignature = 'NAM2';
  NAM9 : TwbSignature = 'NAM9';
  NAME : TwbSignature = 'NAME';
  NIFT : TwbSignature = 'NIFT';
  NIFZ : TwbSignature = 'NIFZ';
  NPC_ : TwbSignature = 'NPC_';
  OFST : TwbSignature = 'OFST';
  OBME : TwbSignature = 'OBME';
  ONAM : TwbSignature = 'ONAM';
  PACK : TwbSignature = 'PACK';
  PFIG : TwbSignature = 'PFIG';
  PFPC : TwbSignature = 'PFPC';
  PGAG : TwbSignature = 'PGAG';
  PGRD : TwbSignature = 'PGRD';
  PGRI : TwbSignature = 'PGRI';
  PGRL : TwbSignature = 'PGRL';
  PGRP : TwbSignature = 'PGRP';
  PGRR : TwbSignature = 'PGRR';
  PKDT : TwbSignature = 'PKDT';
  PKID : TwbSignature = 'PKID';
  PLDT : TwbSignature = 'PLDT';
  PNAM : TwbSignature = 'PNAM';
  PSDT : TwbSignature = 'PSDT';
  PTDT : TwbSignature = 'PTDT';
  QNAM : TwbSignature = 'QNAM';
  QSDT : TwbSignature = 'QSDT';
  QSTA : TwbSignature = 'QSTA';
  QSTI : TwbSignature = 'QSTI';
  QSTR : TwbSignature = 'QSTR';
  TPIC : TwbSignature = 'TPIC';
  QUST : TwbSignature = 'QUST';
  RACE : TwbSignature = 'RACE';
  RCLR : TwbSignature = 'RCLR';
  RDAT : TwbSignature = 'RDAT';
  RDGS : TwbSignature = 'RDGS';
  RDMD : TwbSignature = 'RDMD';
  RDMP : TwbSignature = 'RDMP';
  RDOT : TwbSignature = 'RDOT';
  RDSD : TwbSignature = 'RDSD';
  RDWT : TwbSignature = 'RDWT';
  REFR : TwbSignature = 'REFR';
  PLYR : TwbSignature = 'PLYR';
  REGN : TwbSignature = 'REGN';
  RNAM : TwbSignature = 'RNAM';
  ROAD : TwbSignature = 'ROAD';
  RPLD : TwbSignature = 'RPLD';
  RPLI : TwbSignature = 'RPLI';
  SBSP : TwbSignature = 'SBSP';
  SCHD : TwbSignature = 'SCHD';
  SCHR : TwbSignature = 'SCHR';
  SCIT : TwbSignature = 'SCIT';
  SCPT : TwbSignature = 'SCPT';
  SCRI : TwbSignature = 'SCRI';
  SCRO : TwbSignature = 'SCRO';
  SCRV : TwbSignature = 'SCRV';
  SCVR : TwbSignature = 'SCVR';
  SGST : TwbSignature = 'SGST';
  SKIL : TwbSignature = 'SKIL';
  SLCP : TwbSignature = 'SLCP';
  SLGM : TwbSignature = 'SLGM';
  SLSD : TwbSignature = 'SLSD';
  SNAM : TwbSignature = 'SNAM';
  SNDD : TwbSignature = 'SNDD';
  SNDX : TwbSignature = 'SNDX';
  SOUL : TwbSignature = 'SOUL';
  SOUN : TwbSignature = 'SOUN';
  SPEL : TwbSignature = 'SPEL';
  SPIT : TwbSignature = 'SPIT';
  SPLO : TwbSignature = 'SPLO';
  STAT : TwbSignature = 'STAT';
  TCLF : TwbSignature = 'TCLF';
  TCLT : TwbSignature = 'TCLT';
  TES4 : TwbSignature = 'TES4';
  TNAM : TwbSignature = 'TNAM';
  TRDT : TwbSignature = 'TRDT';
  TREE : TwbSignature = 'TREE';
  UNAM : TwbSignature = 'UNAM';
  VCLR : TwbSignature = 'VCLR';
  VHGT : TwbSignature = 'VHGT';
  VNAM : TwbSignature = 'VNAM';
  VNML : TwbSignature = 'VNML';
  VTEX : TwbSignature = 'VTEX';
  VTXT : TwbSignature = 'VTXT';
  WATR : TwbSignature = 'WATR';
  WEAP : TwbSignature = 'WEAP';
  WLST : TwbSignature = 'WLST';
  WNAM : TwbSignature = 'WNAM';
  WRLD : TwbSignature = 'WRLD';
  WTHR : TwbSignature = 'WTHR';
  XACT : TwbSignature = 'XACT';
  XCCM : TwbSignature = 'XCCM';
  XCHG : TwbSignature = 'XCHG';
  XCLC : TwbSignature = 'XCLC';
  XCLL : TwbSignature = 'XCLL';
  XCLR : TwbSignature = 'XCLR';
  XCLW : TwbSignature = 'XCLW';
  XCMT : TwbSignature = 'XCMT';
  XCNT : TwbSignature = 'XCNT';
  XCWT : TwbSignature = 'XCWT';
  XESP : TwbSignature = 'XESP';
  XGLB : TwbSignature = 'XGLB';
  XHLT : TwbSignature = 'XHLT';
  XHRS : TwbSignature = 'XHRS';
  XLCM : TwbSignature = 'XLCM';
  XLOC : TwbSignature = 'XLOC';
  XLOD : TwbSignature = 'XLOD';
  XMRC : TwbSignature = 'XMRC';
  XMRK : TwbSignature = 'XMRK';
  XNAM : TwbSignature = 'XNAM';
  XOWN : TwbSignature = 'XOWN';
  XPCI : TwbSignature = 'XPCI';
  XRGD : TwbSignature = 'XRGD';
  XRNK : TwbSignature = 'XRNK';
  XRTM : TwbSignature = 'XRTM';
  XSCL : TwbSignature = 'XSCL';
  XSED : TwbSignature = 'XSED';
  XSOL : TwbSignature = 'XSOL';
  XTEL : TwbSignature = 'XTEL';
  XTRG : TwbSignature = 'XTRG';
  XXXX : TwbSignature = 'XXXX';
  ZNAM : TwbSignature = 'ZNAM';

var
  wbEDID: IwbSubRecordDef;
  wbXOWN: IwbSubRecordDef;
  wbXGLB: IwbSubRecordDef;
  wbXRGD: IwbSubRecordDef;
  wbSLSD: IwbRecordMemberDef;
  wbBodyDataIndex: IwbSubRecordDef;
  wbSPLO: IwbSubRecordDef;
  wbSPLOs: IwbSubRecordArrayDef;
  wbCNTO: IwbRecordMemberDef;
  wbCNTOs: IwbSubRecordArrayDef;
  wbCSDT: IwbSubRecordStructDef;
  wbCSDTs: IwbSubRecordArrayDef;
  wbFULL: IwbSubRecordDef;
  wbFULLReq: IwbSubRecordDef;
  wbXNAM: IwbRecordMemberDef;
  wbXNAMs: IwbSubRecordArrayDef;
  wbDESC: IwbSubRecordDef;
  wbXSCL: IwbSubRecordDef;
  wbDATAPosRot : IwbSubRecordDef;
  wbPosRot : IwbStructDef;
  wbMODL: IwbRecordMemberDef;
  wbCTDA: IwbSubRecordUnionDef;
  wbSCHR: IwbSubRecordUnionDef;
  wbCTDAs: IwbSubRecordArrayDef;
  wbSCROs: IwbRecordMemberDef;
  wbPGRP: IwbSubRecordDef;
  wbResultScript: IwbRecordMemberDef;
//  wbResultScriptOld: IwbSubRecordStructDef;
  wbSCRI: IwbSubRecordDef;
  wbFaceGen: IwbSubRecordStructDef;
  wbENAM: IwbSubRecordDef;
//  wbFGGS: IwbSubRecordDef;
  wbXLOD: IwbSubRecordDef;
  wbXESP: IwbSubRecordDef;
  wbICON: IwbSubRecordDef;
  wbEFID: IwbSubRecordDef;
  wbEFIDOBME: IwbSubRecordDef;
  wbEFIT: IwbSubRecordDef;
  wbEFITOBME: IwbSubRecordDef;
  wbEFIX: IwbSubRecordDef;
  wbSCIT: IwbSubRecordStructDef;
  wbSCITOBME: IwbSubRecordStructDef;
  wbMaleBipedModel: IwbRecordMemberDef;
  wbMaleWorldModel: IwbRecordMemberDef;
  wbFemaleBipedModel: IwbRecordMemberDef;
  wbFemaleWorldModel: IwbRecordMemberDef;

function wbClmtMoonsPhaseLength(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
var
  PhaseLength : Byte;
  Masser      : Boolean;
  Secunda     : Boolean;
begin
  Result := '';
  if aType = ctToSortKey then begin
    Result := IntToHex64(aInt, 2);
  end else if aType = ctToStr then begin
    PhaseLength := aInt mod 64;
    Masser := (aInt and 64) <> 0;
    Secunda := (aInt and 128) <> 0;
    if Masser then
      if Secunda then
        Result := 'Masser, Secunda / '
      else
        Result := 'Masser / '
    else
      if Secunda then
        Result := 'Secunda / '
      else
        Result := 'No Moon / ';
    Result := Result + IntToStr(PhaseLength);
  end;
end;

function wbClmtTime(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
begin
  Result := '';
  if aType = ctToSortKey then
    Result := IntToHex64(aInt, 4)
  else if aType = ctToStr then
    Result := TimeToStr( EncodeTime(aInt div 6, (aInt mod 6) * 10, 0, 0) );
end;

var
  wbCtdaTypeFlags : IwbFlagsDef;

function wbCtdaType(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
var
  s: string;
begin
  Result := '';
  case aType of
    ctToStr: begin
      case aInt and $F0 of
        $00 : Result := 'Equal to';
        $20 : Result := 'Not equal to';
        $40 : Result := 'Greater than';
        $60 : Result := 'Greater than or equal to';
        $80 : Result := 'Less than';
        $A0 : Result := 'Less than or equal to';
      else
        Result := '<Unknown Compare operator>'
      end;

      if not Assigned(wbCtdaTypeFlags) then
        wbCtdaTypeFlags := wbFlags([
          {0x01} 'Or',
          {0x02} 'Run on target',
          {0x04} 'Use global'
        ]);

      s := wbCtdaTypeFlags.ToString(aInt and $0F, aElement, aType = ctToSummary);

      if s <> '' then
        Result := Result + ' / ' + s;
    end;
    ctToSortKey: begin
      Result := IntToHex64(aInt, 2);
      Exit;
    end;
    ctCheck: begin
      case aInt and $F0 of
        $00, $20, $40, $60, $80, $A0 : Result := '';
      else
        Result := '<Unknown Compare operator>'
      end;

      if not Assigned(wbCtdaTypeFlags) then
        wbCtdaTypeFlags := wbFlags([
          {0x01} 'Or',
          {0x02} 'Run on target',
          {0x04} 'Use global'
        ]);

      s := wbCtdaTypeFlags.Check(aInt and $0F, aElement);

      if s <> '' then
        Result := Result + ' / ' + s;
    end;
  end;
end;

function wbIdleAnam(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
begin
  Result := '';
  case aType of
    ctToStr: begin
      case aInt and not $80 of
        0: Result := 'Lower Body';
        1: Result := 'Left Arm';
        2: Result := 'Left Hand';
        3: Result := 'Right Arm';
        4: Result := 'Special Idle';
        5: Result := 'Whole Body';
        6: Result := 'Upper Body';
      else
        Result := '<Unknown: '+IntToStr(aInt and not $80)+'>';
      end;

      if (aInt and $80) = 0 then
        Result := Result + ', Must return a file';
    end;
    ctToSortKey: begin
      Result := IntToHex64(aInt, 2);
    end;
    ctCheck: begin
      case aInt and not $80 of
        0..6: Result := '';
      else
        Result := '<Unknown: '+IntToStr(aInt and not $80)+'>';
      end;
    end;
  end;
end;

function wbScaledInt4ToStr(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
const
  PlusMinus : array[Boolean] of string = ('+', '-');
begin
  Result := '';
  case aType of
    ctToStr, ctToEditValue: Result := FloatToStrF(aInt / 10000, ffFixed, 99, 4);
    ctToSortKey: begin
      Result := FloatToStrF(aInt / 10000, ffFixed, 99, 4);
      if Length(Result) < 22 then
        Result := StringOfChar('0', 22 - Length(Result)) + Result;
      Result := PlusMinus[aInt < 0] + Result;
    end;
    ctCheck: Result := '';
  end;
end;

function wbScaledInt4ToInt(const aString: string; const aElement: IwbElement): Int64;
var
  f: Extended;
begin
  f := StrToFloat(aString);
  f := f * 10000;
  Result := Round(f);
end;

function wbHideFFFF(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
begin
  Result := '';
  if aType = ctToSortKey then
    Result := IntToHex64(aInt, 4)
  else if aType = ctToStr then
    if aInt = $FFFF then
      Result := 'None'
    else
      Result := IntToStr(aInt);
end;

function wbAtxtPosition(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
begin
  Result := '';
  if aType = ctToSortKey then
    Result := IntToHex64(aInt div 17, 2) + IntToHex64(aInt mod 17, 2)
  else if aType = ctCheck then begin
    if (aInt < 0) or (aInt > 288) then
      Result := '<Out of range: '+IntToStr(aInt)+'>'
    else
      Result := '';
  end else if aType = ctToStr then
    Result := IntToStr(aInt) + ' -> ' + IntToStr(aInt div 17) + ':' + IntToStr(aInt mod 17);
end;

function wbWthrDataClassification(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
begin
  Result := '';
  case aType of
    ctToStr: begin
      case aInt and not 192 of
        0: Result := 'None';
        1: Result := 'Pleasant';
        2: Result := 'Cloudy';
        3: Result := 'Unknown 3';
        4: Result := 'Rainy';
        8: Result := 'Snow';
      else
        Result := '<Unknown: '+IntToStr(aInt and not 192)+'>';
      end;
    end;
    ctToSortKey: begin
      Result := IntToHex64(aInt, 2)
    end;
    ctCheck: begin
      case aInt and not 192 of
        0..4, 8: Result := '';
      else
        Result := '<Unknown: '+IntToStr(aInt and not 192)+'>';
      end;
    end;
  end;
end;

function wbGLOBFNAM(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
begin
  Result := '';
  case aType of
    ctToStr: begin
      case aInt of
        Ord('s'): Result := 'Short';
        Ord('l'): Result := 'Long';
        Ord('f'): Result := 'Float';
      else
        Result := '<Unknown: '+IntToStr(aInt)+'>';
      end;
    end;
    ctToSortKey: Result := Chr(aInt);
    ctCheck: begin
      case aInt of
        Ord('s'), Ord('l'), Ord('f'): Result := '';
      else
        Result := '<Unknown: '+IntToStr(aInt)+'>';
      end;
    end;
  end;
end;

function wbPlacedAddInfo(const aMainRecord: IwbMainRecord): string;
var
  Rec: IwbRecord;
  Container: IwbContainer;
  s: string;
  Cell: IwbMainRecord;
  Position: TwbVector;
  Grid: TwbGridCell;
begin
  Result := '';

  Rec := aMainRecord.RecordBySignature['NAME'];
  if Assigned(Rec) then begin
    s := Trim(Rec.Value);
    if s <> '' then
      Result := 'places ' + s;
  end;

  Container := aMainRecord.Container;
  while Assigned(Container) and (Container.ElementType <> etGroupRecord) do
    Container := Container.Container;

  if Assigned(Container) then begin
    s := Trim(Container.Name);
    if s <> '' then begin
      if Result <> '' then
        Result := Result + ' ';
      Result := Result + 'in ' + s;

      // grid position of persistent reference in exterior persistent cell (interior cells are not persistent)
      if Supports(aMainRecord.Container, IwbGroupRecord, Container) then
        Cell := IwbGroupRecord(Container).ChildrenOf;
      if Assigned(Cell) and Cell.IsPersistent and (Cell.Signature = 'CELL') then
        if aMainRecord.GetPosition(Position) then begin
          Grid := wbPositionToGridCell(Position);
          Result := Result + ' at ' + IntToStr(Grid.x) + ',' + IntToStr(Grid.y);
        end;
    end;
  end;
end;

function wbCellAddInfo(const aMainRecord: IwbMainRecord): string;
var
  Rec: IwbRecord;
  Container: IwbContainer;
  GroupRecord : IwbGroupRecord;
  s: string;
begin
  Result := '';

  if not aMainRecord.IsPersistent then begin
    Rec := aMainRecord.RecordBySignature['XCLC'];
    if Assigned(Rec) then
      Result := 'at ' + Rec.Elements[0].Value + ',' + Rec.Elements[1].Value;
  end;

  Container := aMainRecord.Container;
  while Assigned(Container) and not
    (Supports(Container, IwbGroupRecord, GroupRecord) and (GroupRecord.GroupType = 1))  do
    Container := Container.Container;

  if Assigned(Container) then begin
    s := wbFormID.ToString(GroupRecord.GroupLabel, aMainRecord, False);
    if s <> '' then begin
      if Result <> '' then
        s := s + ' ';
      Result := 'in ' + s + Result;
    end;
  end;
end;

function wbGMSTUnionDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  rEDID: IwbRecord;
  s: string;
begin
  Result := 1;
  rEDID := aElement.Container.RecordBySignature[EDID];
  if Assigned(rEDID) then begin
    s := rEDID.Value;
    if Length(s) > 0 then
      case s[1] of
        's': Result := 0;
        'f': Result := 2;
      end;
  end;
end;

function wbMISCActorValueDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  MainRecord : IwbMainRecord;
begin
  Result := 0;

  if not Assigned(aElement) then
    Exit;

  MainRecord := aElement.ContainingMainRecord;
  if not Assigned(MainRecord) then
    Exit;

  if (MainRecord.Flags._Flags and $000000C0) = $000000C0 then
    Result := 1;
end;

function wbXLOCFillerDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container : IwbContainer;
  SubRecord : IwbSubRecord;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Container := GetContainerFromUnion(aElement);
  if not Assigned(Container) then Exit;

  if Supports(Container, IwbSubRecord, SubRecord) then
    if SubRecord.SubRecordHeaderSize = 16 then
      Result := 1;
end;

function wbPACKPKDTDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container : IwbContainer;
  SubRecord : IwbSubRecord;
begin
  Result := 1;
  if not Assigned(aElement) then Exit;
  Container := GetContainerFromUnion(aElement);
  if not Assigned(Container) then Exit;
  if Supports(Container, IwbSubRecord, SubRecord) then
    if SubRecord.SubRecordHeaderSize = 4 then
      Result := 0;
end;

function wbREFRXSEDDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container : IwbContainer;
  SubRecord : IwbSubRecord;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Container := GetContainerFromUnion(aElement);
  if not Assigned(Container) then Exit;

  if Supports(Container, IwbSubRecord, SubRecord) then
    if SubRecord.SubRecordHeaderSize = 4 then
      Result := 1;
end;


type
  TCTDAFunctionParamType = (
    ptNone,
    ptInteger,
    ptVariableName,  //Integer
    ptSex,           //Enum: Male, Female
    ptActorValue,    //Enum: wbActorValue
    ptCrimeType,     //?? Enum
    ptAxis,          //?? Char
    ptFormType,      //?? Enum
    ptQuestStage,

    ptObjectReference,    //REFR, ACHR, ACRE, PGRE
    ptInventoryObject,    //ARMO, BOOK, MISC, WEAP, AMMO, KEYM, ALCH, NOTE, ARMA
    ptActor,              //ACHR, ACRE
    ptQuest,              //QUST
    ptFaction,            //FACT
    ptCell,               //CELL
    ptClass,              //CLAS
    ptRace,               //RACE
    ptActorBase,          //NPC_, CREA
    ptGlobal,             //GLOB
    ptWeather,            //WTHR
    ptPackage,            //PACK
    ptOwnerOpt,           //FACT, NPC_
    ptBirthsign,          //BSGN
    ptFurniture,          //FURN
    ptMagicItem,          //SPEL
    ptMagicEffect,        //MGEF
    ptWorldspace,         //WRLD
    ptReferencableObject
  );

  PCTDAFunction = ^TCTDAFunction;
  TCTDAFunction = record
    Index: Integer;
    Name: string;
    ParamType1: TCTDAFunctionParamType;
    ParamType2: TCTDAFunctionParamType;
  end;

const
  wbCTDAFunctions : array[0..191] of TCTDAFunction = (
    (Index:   1; Name: 'GetDistance'; ParamType1: ptObjectReference),
    (Index:   5; Name: 'GetLocked'),
    (Index:   6; Name: 'GetPos'; ParamType1: ptAxis),
    (Index:   8; Name: 'GetAngle'; ParamType1: ptAxis),
    (Index:  10; Name: 'GetStartingPos'; ParamType1: ptAxis),
    (Index:  11; Name: 'GetStartingAngle'; ParamType1: ptAxis),
    (Index:  12; Name: 'GetSecondsPassed'),
    (Index:  14; Name: 'GetActorValue'; ParamType1: ptActorValue),
    (Index:  18; Name: 'GetCurrentTime'),
    (Index:  24; Name: 'GetScale'),
    (Index:  27; Name: 'GetLineOfSight'; ParamType1: ptObjectReference),
    (Index:  32; Name: 'GetInSameCell'; ParamType1: ptObjectReference),
    (Index:  35; Name: 'GetDisabled'),
    (Index:  36; Name: 'MenuMode'; ParamType1: ptInteger),
    (Index:  39; Name: 'GetDisease'),
    (Index:  40; Name: 'GetVampire'),
    (Index:  41; Name: 'GetClothingValue'),
    (Index:  42; Name: 'SameFaction'; ParamType1: ptActor),
    (Index:  43; Name: 'SameRace'; ParamType1: ptActor),
    (Index:  44; Name: 'SameSex'; ParamType1: ptActor),
    (Index:  45; Name: 'GetDetected'; ParamType1: ptActor),
    (Index:  46; Name: 'GetDead'),
    (Index:  47; Name: 'GetItemCount'; ParamType1: ptInventoryObject),
    (Index:  48; Name: 'GetGold'),
    (Index:  49; Name: 'GetSleeping'),
    (Index:  50; Name: 'GetTalkedToPC'),
    (Index:  53; Name: 'GetScriptVariable'; ParamType1: ptObjectReference; ParamType2: ptVariableName),
    (Index:  56; Name: 'GetQuestRunning'; ParamType1: ptQuest),
    (Index:  58; Name: 'GetStage'; ParamType1: ptQuest),
    (Index:  59; Name: 'GetStageDone'; ParamType1: ptQuest; ParamType2: ptQuestStage),
    (Index:  60; Name: 'GetFactionRankDifference'; ParamType1: ptFaction; ParamType2: ptActor),
    (Index:  61; Name: 'GetAlarmed'),
    (Index:  62; Name: 'IsRaining'),
    (Index:  63; Name: 'GetAttacked'),
    (Index:  64; Name: 'GetIsCreature'),
    (Index:  65; Name: 'GetLockLevel'),
    (Index:  66; Name: 'GetShouldAttack'; ParamType1: ptActor),
    (Index:  67; Name: 'GetInCell'; ParamType1: ptCell),
    (Index:  68; Name: 'GetIsClass'; ParamType1: ptClass),
    (Index:  69; Name: 'GetIsRace'; ParamType1: ptRace),
    (Index:  70; Name: 'GetIsSex'; ParamType1: ptSex),
    (Index:  71; Name: 'GetInFaction'; ParamType1: ptFaction),
    (Index:  72; Name: 'GetIsID'; ParamType1: ptReferencableObject),
    (Index:  73; Name: 'GetFactionRank'; ParamType1: ptFaction),
    (Index:  74; Name: 'GetGlobalValue'; ParamType1: ptGlobal),
    (Index:  75; Name: 'IsSnowing'),
    (Index:  76; Name: 'GetDisposition'; ParamType1: ptActor),
    (Index:  77; Name: 'GetRandomPercent'),
    (Index:  79; Name: 'GetQuestVariable'; ParamType1: ptQuest; ParamType2: ptVariableName),
    (Index:  80; Name: 'GetLevel'),
    (Index:  81; Name: 'GetArmorRating'),
    (Index:  84; Name: 'GetDeadCount'; ParamType1: ptActorBase),
    (Index:  91; Name: 'GetIsAlerted'),
    (Index:  98; Name: 'GetPlayerControlsDisabled'),
    (Index:  99; Name: 'GetHeadingAngle'; ParamType1: ptObjectReference),
    (Index: 101; Name: 'IsWeaponOut'),
    (Index: 102; Name: 'IsTorchOut'),
    (Index: 103; Name: 'IsShieldOut'),
    (Index: 104; Name: 'IsYielding'),
    (Index: 106; Name: 'IsFacingUp'),
    (Index: 107; Name: 'GetKnockedState'),
    (Index: 108; Name: 'GetWeaponAnimType'),
    (Index: 109; Name: 'GetWeaponSkillType'),
    (Index: 110; Name: 'GetCurrentAIPackage'),
    (Index: 111; Name: 'IsWaiting'),
    (Index: 112; Name: 'IsIdlePlaying'),
    (Index: 116; Name: 'GetCrimeGold'),
    (Index: 122; Name: 'GetCrime'; ParamType1: ptActor; ParamType2: ptCrimeType),
    (Index: 125; Name: 'IsGuard'),
    (Index: 127; Name: 'CanPayCrimeGold'),
    (Index: 128; Name: 'GetFatiguePercentage'),
    (Index: 129; Name: 'GetPCIsClass'; ParamType1: ptClass),
    (Index: 130; Name: 'GetPCIsRace'; ParamType1: ptRace),
    (Index: 131; Name: 'GetPCIsSex'; ParamType1: ptSex),
    (Index: 132; Name: 'GetPCInFaction'; ParamType1: ptFaction),
    (Index: 133; Name: 'SameFactionAsPC'),
    (Index: 134; Name: 'SameRaceAsPC'),
    (Index: 135; Name: 'SameSexAsPC'),
    (Index: 136; Name: 'GetIsReference'; ParamType1: ptObjectReference),
    (Index: 141; Name: 'IsTalking'),
    (Index: 142; Name: 'GetWalkSpeed'),
    (Index: 143; Name: 'GetCurrentAIProcedure'),
    (Index: 144; Name: 'GetTrespassWarningLevel'),
    (Index: 145; Name: 'IsTrespassing'),
    (Index: 146; Name: 'IsInMyOwnedCell'),
    (Index: 147; Name: 'GetWindSpeed'),
    (Index: 148; Name: 'GetCurrentWeatherPercent'),
    (Index: 149; Name: 'GetIsCurrentWeather'; ParamType1: ptWeather),
    (Index: 150; Name: 'IsContinuingPackagePCNear'),
    (Index: 153; Name: 'CanHaveFlames'),
    (Index: 154; Name: 'HasFlames'),
    (Index: 157; Name: 'GetOpenState'),
    (Index: 159; Name: 'GetSitting'),
    (Index: 160; Name: 'GetFurnitureMarkerID'),
    (Index: 161; Name: 'GetIsCurrentPackage'; ParamType1: ptPackage),
    (Index: 162; Name: 'IsCurrentFurnitureRef'; ParamType1: ptObjectReference),
    (Index: 163; Name: 'IsCurrentFurnitureObj'; ParamType1: ptFurniture),
    (Index: 170; Name: 'GetDayOfWeek'),
    (Index: 171; Name: 'IsPlayerInJail'),
    (Index: 172; Name: 'GetTalkedToPCParam'; ParamType1: ptActor),
    (Index: 175; Name: 'IsPCSleeping'),
    (Index: 176; Name: 'IsPCAMurderer'),
    (Index: 180; Name: 'GetDetectionLevel'; ParamType1: ptActor),
    (Index: 182; Name: 'GetEquipped'; ParamType1: ptInventoryObject),
    (Index: 185; Name: 'IsSwimming'),
    (Index: 190; Name: 'GetAmountSoldStolen'),
    (Index: 193; Name: 'GetPCExpelled'; ParamType1: ptFaction),
    (Index: 195; Name: 'GetPCFactionMurder'; ParamType1: ptFaction),
    (Index: 197; Name: 'GetPCFactionSteal'; ParamType1: ptFaction),
    (Index: 199; Name: 'GetPCFactionAttack'; ParamType1: ptFaction),
    (Index: 201; Name: 'GetPCFactionSubmitAuthority'; ParamType1: ptFaction),
    (Index: 203; Name: 'GetDestroyed'),
    (Index: 214; Name: 'HasMagicEffect'; ParamType1: ptMagicEffect),
    (Index: 215; Name: 'GetDoorDefaultOpen'),
    (Index: 223; Name: 'IsSpellTarget'; ParamType1: ptMagicItem),
    (Index: 224; Name: 'GetIsPlayerBirthsign'; ParamType1: ptBirthsign),
    (Index: 225; Name: 'GetPersuasionNumber'),
    (Index: 227; Name: 'HasVampireFed'),
    (Index: 228; Name: 'GetIsClassDefault'; ParamType1: ptClass),
    (Index: 229; Name: 'GetClassDefaultMatch'),
    (Index: 230; Name: 'GetInCellParam'; ParamType1: ptCell; ParamType2: ptObjectReference),
    (Index: 237; Name: 'GetIsGhost'),
    (Index: 242; Name: 'GetUnconscious'),
    (Index: 244; Name: 'GetRestrained'),
    (Index: 246; Name: 'GetIsUsedItem'; ParamType1: ptReferencableObject),
    (Index: 247; Name: 'GetIsUsedItemType'; ParamType1: ptFormType),
    (Index: 249; Name: 'GetPCFame'),
    (Index: 251; Name: 'GetPCInfamy'),
    (Index: 254; Name: 'GetIsPlayableRace'),
    (Index: 255; Name: 'GetOffersServicesNow'),
    (Index: 258; Name: 'GetUsedItemLevel'),
    (Index: 259; Name: 'GetUsedItemActivate'),
    (Index: 264; Name: 'GetBarterGold'),
    (Index: 265; Name: 'IsTimePassing'),
    (Index: 266; Name: 'IsPleasant'),
    (Index: 267; Name: 'IsCloudy'),
    (Index: 274; Name: 'GetArmorRatingUpperBody'),
    (Index: 277; Name: 'GetBaseActorValue'; ParamType1: ptActorValue),
    (Index: 278; Name: 'IsOwner'; ParamType1: ptOwnerOpt),
    (Index: 280; Name: 'IsCellOwner'; ParamType1: ptCell; ParamType2: ptOwnerOpt),
    (Index: 282; Name: 'IsHorseStolen'),
    (Index: 285; Name: 'IsLeftUp'),
    (Index: 286; Name: 'IsSneaking'),
    (Index: 287; Name: 'IsRunning'),
    (Index: 288; Name: 'GetFriendHit'; ParamType1: ptActor),
    (Index: 289; Name: 'IsInCombat'),
    (Index: 300; Name: 'IsInInterior'),
    (Index: 305; Name: 'GetInvestmentGold'),
    (Index: 306; Name: 'IsActorUsingATorch'),
    (Index: 309; Name: 'IsXBox'),
    (Index: 310; Name: 'GetInWorldspace'; ParamType1: ptWorldSpace),
    (Index: 312; Name: 'GetPCMiscStat'; ParamType1: ptInteger),
    (Index: 313; Name: 'IsActorEvil'),
    (Index: 314; Name: 'IsActorAVictim'),
    (Index: 315; Name: 'GetTotalPersuasionNumber'),
    (Index: 318; Name: 'GetIdleDoneOnce'),
    (Index: 320; Name: 'GetNoRumors'),
    (Index: 323; Name: 'WhichServiceMenu'),
    (Index: 327; Name: 'IsRidingHorse'),
    (Index: 329; Name: 'IsTurnArrest'),
    (Index: 332; Name: 'IsInDangerousWater'),
    (Index: 338; Name: 'GetIgnoreFriendlyHits'),
    (Index: 339; Name: 'IsPlayersLastRiddenHorse'),
    (Index: 353; Name: 'IsActor'),
    (Index: 354; Name: 'IsEssential'),
    (Index: 358; Name: 'IsPlayerMovingIntoNewSpace'),
    (Index: 361; Name: 'GetTimeDead'),
    (Index: 362; Name: 'GetPlayerHasLastRiddenHorse'),
    (Index: 365; Name: 'GetPlayerInSEWorld'),

    // Added by OBSE:
    (Index: 1107; Name: 'IsAmmo,'; ParamType1: ptInteger),
    (Index: 1884; Name: 'GetPCTrainingSessionsUsed'; ParamType1: ptPackage),
    (Index: 2213; Name: 'GetPackageOffersServices'; ParamType1: ptPackage),
    (Index: 2214; Name: 'GetPackageMustReachLocation'; ParamType1: ptPackage),
    (Index: 2215; Name: 'GetPackageMustComplete'; ParamType1: ptPackage),
    (Index: 2216; Name: 'GetPackageLockDoorsAtStart'; ParamType1: ptPackage),
    (Index: 2217; Name: 'GetPackageLockDoorsAtEnd'; ParamType1: ptPackage),
    (Index: 2218; Name: 'GetPackageLockDoorsAtLocation'; ParamType1: ptPackage),
    (Index: 2219; Name: 'GetPackageUnlockDoorsAtStart'; ParamType1: ptPackage),
    (Index: 2220; Name: 'GetPackageUnlockDoorsAtEnd'; ParamType1: ptPackage),
    (Index: 2221; Name: 'GetPackageUnlockDoorsAtLocation'; ParamType1: ptPackage),
    (Index: 2222; Name: 'GetPackageContinueIfPCNear'; ParamType1: ptPackage),
    (Index: 2223; Name: 'GetPackageOncePerDay'; ParamType1: ptPackage),
    (Index: 2224; Name: 'GetPackageSkipFalloutBehavior'; ParamType1: ptPackage),
    (Index: 2225; Name: 'GetPackageAlwaysRun'; ParamType1: ptPackage),
    (Index: 2226; Name: 'GetPackageAlwaysSneak'; ParamType1: ptPackage),
    (Index: 2227; Name: 'GetPackageAllowSwimming'; ParamType1: ptPackage),
    (Index: 2228; Name: 'GetPackageAllowFalls'; ParamType1: ptPackage),
    (Index: 2229; Name: 'GetPackageArmorUnequipped'; ParamType1: ptPackage),
    (Index: 2230; Name: 'GetPackageWeaponsUnequipped'; ParamType1: ptPackage),
    (Index: 2231; Name: 'GetPackageDefensiveCombat'; ParamType1: ptPackage),
    (Index: 2232; Name: 'GetPackageUseHorse'; ParamType1: ptPackage),
    (Index: 2233; Name: 'GetPackageNoIdleAnims'; ParamType1: ptPackage)
  );

var
  wbCTDAFunctionEditInfo : string;

function wbCTDAParamDescFromIndex(aIndex: Integer): PCTDAFunction;
var
  L, H, I, C: Integer;
begin
  Result := nil;

  L := Low(wbCTDAFunctions);
  H := High(wbCTDAFunctions);
  while L <= H do begin
    I := (L + H) shr 1;
    C := CmpW32(wbCTDAFunctions[I].Index, aIndex);
    if C < 0 then
      L := I + 1
    else begin
      H := I - 1;
      if C = 0 then begin
        L := I;
        Result := @wbCTDAFunctions[L];
      end;
    end;
  end;
end;

function wbCTDACompValueDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container: IwbContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Container := GetContainerFromUnion(aElement);
  if not Assigned(Container) then Exit;

  if Integer(Container.ElementByName['Type'].NativeValue) and $04 <> 0 then
    Result := 1;
end;

function wbEFITOBMEParamDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  ParamInfo: Variant;
  Container: IwbContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Container := GetContainerFromUnion(aElement);
  if not Assigned(Container) then Exit;

  ParamInfo := Container.ElementNativeValues['..\EFME\EFIT Param Info'];
  if VarIsNull(ParamInfo) or VarIsEmpty(ParamInfo) then
  else
    Result := ParamInfo;
end;

function wbEFIXParamDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  ParamInfo: Variant;
  Container: IwbContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Container := GetContainerFromUnion(aElement);
  if not Assigned(Container) then Exit;

  ParamInfo := Container.ElementNativeValues['..\EFME\EFIX Param Info'];
  if VarIsNull(ParamInfo) or VarIsEmpty(ParamInfo) then
  else
    Result := ParamInfo;
end;

function wbCTDAParam1Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Desc: PCTDAFunction;
  Container: IwbContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Container := GetContainerFromUnion(aElement);
  if not Assigned(Container) then Exit;

  Desc := wbCTDAParamDescFromIndex(Container.ElementByName['Function'].NativeValue);
  if Assigned(Desc) then
    Result := Succ(Integer(Desc.ParamType1));
end;

function wbCTDAParam2Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Desc: PCTDAFunction;
  Container: IwbContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Container := GetContainerFromUnion(aElement);
  if not Assigned(Container) then Exit;

  Desc := wbCTDAParamDescFromIndex(Container.ElementByName['Function'].NativeValue);
  if Assigned(Desc) then
    Result := Succ(Integer(Desc.ParamType2));
end;
{
function wbCTDAFunction(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
var
  Desc: PCTDAFunction;
begin
  Result := '';
  case aType of
    ctToStr: begin
      Desc := wbCTDAParamDescFromIndex(aInt);
      if Assigned(Desc) then
        Result := Desc.Name
      else
        Result := '<Unknown: '+IntToStr(aInt)+'>';
    end;
    ctToSortKey: Result := IntToHex(aInt, 8);
    ctCheck: begin
      Desc := wbCTDAParamDescFromIndex(aInt);
      if Assigned(Desc) then
        Result := ''
      else
        Result := '<Unknown: '+IntToStr(aInt)+'>';
    end;
  end;
end;
}
function wbCTDAFunctionToStr(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
var
  Desc : PCTDAFunction;
  i    : Integer;
begin
  Result := '';
  case aType of
    ctToStr, ctToEditValue: begin
      Desc := wbCTDAParamDescFromIndex(aInt);
      if Assigned(Desc) then
        Result := Desc.Name
      else if aType = ctToEditValue then
        Result := IntToStr(aInt)
      else
        Result := '<Unknown: '+IntToStr(aInt)+'>';
    end;
    ctToSortKey: Result := IntToHex(aInt, 8);
    ctCheck: begin
      Desc := wbCTDAParamDescFromIndex(aInt);
      if Assigned(Desc) then
        Result := ''
      else
        Result := '<Unknown: '+IntToStr(aInt)+'>';
    end;
    ctEditType:
      Result := 'ComboBox';
    ctEditInfo: begin
      Result := wbCTDAFunctionEditInfo;
      if Result = '' then begin
        with TStringList.Create do try
          for i := Low(wbCTDAFunctions) to High(wbCTDAFunctions) do
            Add(wbCTDAFunctions[i].Name);
          Sort;
          Result := CommaText;
        finally
          Free;
        end;
        wbCTDAFunctionEditInfo := Result;
      end;
    end;
  end;
end;

function wbCTDAFunctionToInt(const aString: string; const aElement: IwbElement): Int64;
var
  i: Integer;
begin
  for i := Low(wbCTDAFunctions) to High(wbCTDAFunctions) do
    with wbCTDAFunctions[i] do
      if SameText(Name, aString) then begin
        Result := Index;
        Exit;
      end;
  Result := StrToInt64(aString);
end;

function wbNeverShow(const aElement: IwbElement): Boolean;
begin
  Result := wbHideNeverShow;
end;

function wbCTDAParam2VariableNameToStr(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
var
  Container  : IwbContainerElementRef;
  Param1     : IwbElement;
  MainRecord : IwbMainRecord;
  BaseRecord : IwbMainRecord;
  ScriptRef  : IwbElement;
  Script     : IwbMainRecord;
  Variables  : TStringList;
  LocalVars  : IwbContainerElementRef;
  LocalVar   : IwbContainerElementRef;
  i, j       : Integer;
  s          : string;
begin
  case aType of
    ctToStr: Result := IntToStr(aInt) + ' <Warning: Could not resolve Parameter 1>';
    ctToEditValue: Result := IntToStr(aInt);
    ctToSortKey: begin
      Result := IntToHex64(aInt, 8);
      Exit;
    end;
    ctCheck: Result := '<Warning: Could not resolve Parameter 1>';
    ctEditType: Result := '';
    ctEditInfo: Result := '';
  end;

  if not Assigned(aElement) then Exit;
  Container := GetContainerRefFromUnionOrValue(aElement);
  if not Assigned(Container) then Exit;

  Param1 := Container.ElementByName['Parameter #1'];

  if not Assigned(Param1) then
    Exit;

  MainRecord := nil;
  if not Supports(Param1.LinksTo, IwbMainRecord, MainRecord) then
    Exit;
{    if Param1.NativeValue = 0 then
      if Supports(Container.Container, IwbContainerElementRef, Container) then
        for i := 0 to Pred(Container.ElementCount) do
          if Supports(Container.Elements[i], IwbContainerElementRef, Container2) then
            if SameText(Container2.ElementValues['Function'], 'GetIsID') then begin
              Param1 := Container2.ElementByName['Parameter #1'];
              if Supports(Param1.LinksTo, IwbMainRecord, MainRecord) then
                Break;
            end;}

  if not Assigned(MainRecord) then
    Exit;

  BaseRecord := MainRecord.BaseRecord;
  if Assigned(BaseRecord) then
    MainRecord := BaseRecord;

  ScriptRef := MainRecord.RecordBySignature['SCRI'];

  if not Assigned(ScriptRef) then begin
    case aType of
      ctToStr: Result := IntToStr(aInt) + ' <Warning: "'+MainRecord.ShortName+'" does not contain a SCRI subrecord>';
      ctCheck: Result := '<Warning: "'+MainRecord.ShortName+'" does not contain a SCRI subrecord>';
    end;
    Exit;
  end;

  if not Supports(ScriptRef.LinksTo, IwbMainRecord, Script) then begin
    case aType of
      ctToStr: Result := IntToStr(aInt) + ' <Warning: "'+MainRecord.ShortName+'" does not have a valid script>';
      ctCheck: Result := '<Warning: "'+MainRecord.ShortName+'" does not have a valid script>';
    end;
    Exit;
  end;

  case aType of
    ctEditType: begin
      Result := 'ComboBox';
      Exit;
    end;
    ctEditInfo:
      Variables := TStringList.Create;
  else
    Variables := nil;
  end;
  try
    if Supports(Script.ElementByName['Local Variables'], IwbContainerElementRef, LocalVars) then begin
      for i := 0 to Pred(LocalVars.ElementCount) do
        if Supports(LocalVars.Elements[i], IwbContainerElementRef, LocalVar) then begin
          j := LocalVar.ElementNativeValues['SLSD\Index'];
          s := LocalVar.ElementNativeValues['SCVR'];
          if Assigned(Variables) then
            Variables.AddObject(s, TObject(j))
          else if j = aInt then begin
            case aType of
              ctToStr, ctToEditValue: Result := s;
              ctCheck: Result := '';
            end;
            Exit;
          end;
        end;
    end;

    case aType of
      ctToStr: Result := IntToStr(aInt) + ' <Warning: Variable Index not found in "' + Script.Name + '">';
      ctCheck: Result := '<Warning: Variable Index not found in "' + Script.Name + '">';
      ctEditInfo: begin
        Variables.Sort;
        Result := Variables.CommaText;
      end;
    end;
  finally
    FreeAndNil(Variables);
  end;
end;

function wbCTDAParam2VariableNameToInt(const aString: string; const aElement: IwbElement): Int64;
var
  Container  : IwbContainerElementRef;
  Param1     : IwbElement;
  MainRecord : IwbMainRecord;
  BaseRecord : IwbMainRecord;
  ScriptRef  : IwbElement;
  Script     : IwbMainRecord;
  LocalVars  : IwbContainerElementRef;
  LocalVar   : IwbContainerElementRef;
  i, j       : Integer;
  s          : string;
begin
  Result := StrToInt64Def(aString, Low(Cardinal));
  if Result <> Low(Cardinal) then
    Exit;

  if not Assigned(aElement) then
    raise Exception.Create('aElement not specified');

  Container := GetContainerRefFromUnionOrValue(aElement);

  if not Assigned(Container) then
    raise Exception.Create('Container not assigned');

  Param1 := Container.ElementByName['Parameter #1'];

  if not Assigned(Param1) then
    raise Exception.Create('Could not find "Parameter #1"');

  if not Supports(Param1.LinksTo, IwbMainRecord, MainRecord) then
    raise Exception.Create('"Parameter #1" does not reference a valid main record');

  BaseRecord := MainRecord.BaseRecord;
  if Assigned(BaseRecord) then
    MainRecord := BaseRecord;

  ScriptRef := MainRecord.RecordBySignature['SCRI'];

  if not Assigned(ScriptRef) then
    raise Exception.Create('"'+MainRecord.ShortName+'" does not contain a SCRI subrecord');

  if not Supports(ScriptRef.LinksTo, IwbMainRecord, Script) then
    raise Exception.Create('"'+MainRecord.ShortName+'" does not have a valid script');

  if Supports(Script.ElementByName['Local Variables'], IwbContainerElementRef, LocalVars) then begin
    for i := 0 to Pred(LocalVars.ElementCount) do
      if Supports(LocalVars.Elements[i], IwbContainerElementRef, LocalVar) then begin
        j := LocalVar.ElementNativeValues['SLSD\Index'];
        s := LocalVar.ElementNativeValues['SCVR'];
        if SameText(s, Trim(aString)) then begin
          Result := j;
          Exit;
        end;
      end;
  end;

  raise Exception.Create('Variable "'+aString+'" was not found in "'+MainRecord.ShortName+'"');
end;

function wbCTDAParam2QuestStageToStr(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
var
  Container  : IwbContainerElementRef;
  Param1     : IwbElement;
  MainRecord : IwbMainRecord;
  EditInfos  : TStringList;
  Stages     : IwbContainerElementRef;
  Stage      : IwbContainerElementRef;
  i, j       : Integer;
  s, t       : string;
begin
  case aType of
    ctToStr, ctToSummary: Result := IntToStr(aInt) + ' <Warning: Could not resolve Parameter 1>';
    ctToEditValue: Result := IntToStr(aInt);
    ctToSortKey: begin
      Result := IntToHex64(aInt, 8);
      Exit;
    end;
    ctCheck: Result := '<Warning: Could not resolve Parameter 1>';
    ctEditType: Result := '';
    ctEditInfo: Result := '';
  end;

  if not Assigned(aElement) then Exit;
  Container := GetContainerRefFromUnionOrValue(aElement);
  if not Assigned(Container) then Exit;

  Param1 := Container.ElementByName['Parameter #1'];

  if not Assigned(Param1) then
    Exit;

  if not Supports(Param1.LinksTo, IwbMainRecord, MainRecord) then
    Exit;

  MainRecord := MainRecord.WinningOverride;

  if MainRecord.Signature <> QUST then begin
    case aType of
      ctToStr, ctToSummary: Result := IntToStr(aInt) + ' <Warning: "'+MainRecord.ShortName+'" is not a Quest record>';
      ctCheck: Result := '<Warning: "'+MainRecord.ShortName+'" is not a Quest record>';
    end;
    Exit;
  end;

  case aType of
    ctEditType: begin
      Result := 'ComboBox';
      Exit;
    end;
    ctEditInfo:
      EditInfos := TStringList.Create;
  else
    EditInfos := nil;
  end;
  try
    if Supports(MainRecord.ElementByName['Stages'], IwbContainerElementRef, Stages) then begin
      for i := 0 to Pred(Stages.ElementCount) do
        if Supports(Stages.Elements[i], IwbContainerElementRef, Stage) then begin
          j := Stage.ElementNativeValues['INDX'];
          if aType = ctToSummary then
            s := Stage.ElementSummaries['Log Entries\Log Entry\CNAM']
          else
            s := Stage.ElementValues['Log Entries\Log Entry\CNAM'];
          s := s.Trim;
          t := IntToStr(j);
          while Length(t) < 3 do
            t := '0' + t;
          if s <> '' then
            t := t + ' ' + s;
          if Assigned(EditInfos) then
            EditInfos.AddObject(t, TObject(j))
          else if j = aInt then begin
            case aType of
              ctToStr, ctToSummary, ctToEditValue: Result := t;
              ctCheck: Result := '';
            end;
            Exit;
          end;
        end;
    end;

    case aType of
      ctToStr, ctToSummary: Result := IntToStr(aInt) + ' <Warning: Quest Stage not found in "' + MainRecord.Name + '">';
      ctCheck: Result := '<Warning: Quest Stage not found in "' + MainRecord.Name + '">';
      ctEditInfo: begin
        EditInfos.Sort;
        Result := EditInfos.CommaText;
      end;
    end;
  finally
    FreeAndNil(EditInfos);
  end;
end;

function wbCTDAParam2QuestStageToInt(const aString: string; const aElement: IwbElement): Int64;
var
  i    : Integer;
  s    : string;
begin
  i := 1;
  s := Trim(aString);
  while (i <= Length(s)) and (s[i] in ['0'..'9']) do
    Inc(i);
  s := Copy(s, 1, Pred(i));

  Result := StrToInt(s);
end;

procedure wbRemoveOFST(const aElement: IwbElement);
var
  Container: IwbContainer;
  rOFST: IwbRecord;
begin
  if not wbRemoveOffsetData then
    Exit;

  if Supports(aElement, IwbContainer, Container) then begin
    rOFST := Container.RecordBySignature[OFST];
    if Assigned(rOFST) then
      Container.RemoveElement(rOFST);
  end;
end;

procedure wbCELLAfterLoad(const aElement: IwbElement);
var
  Container    : IwbContainerElementRef;
//  Container2   : IwbContainerElementRef;
  MainRecord   : IwbMainRecord;
//  i            : Integer;
  IsInterior   : Boolean;
  GroupRecord  : IwbGroupRecord;
//  Removed      : Boolean;
begin
  if wbBeginInternalEdit then try
    if not Supports(aElement, IwbContainerElementRef, Container) then
      Exit;

    if Container.ElementCount < 1 then
      Exit;

    if not Supports(aElement, IwbMainRecord, MainRecord) then
      Exit;

    if MainRecord.IsDeleted then
      Exit;

    if not Container.ElementExists['DATA'] then
      Exit;

    IsInterior := (Container.ElementNativeValues['DATA'] and 1) <> 0;

    if IsInterior then
      Container.Add('XCLL')
    else begin
      Container.Add('XCLC');
      if (Container.ElementNativeValues['DATA'] and 2) = 0 then
        if Supports(MainRecord.Container, IwbGroupRecord, GroupRecord) then
          if GroupRecord.GroupType = 1 then
            Container.ElementNativeValues['DATA'] :=
              Container.ElementNativeValues['DATA'] or 2;
    end;

//    Removed := False;
//    if Supports(Container.ElementBySignature[XCLR], IwbContainerElementRef, Container2) then begin
//      for i:= Pred(Container2.ElementCount) downto 0 do
//        if not Supports(Container2.Elements[i].LinksTo, IwbMainRecord, MainRecord) or (MainRecord.Signature <> 'REGN') then begin
//          if not Removed then begin
//            Removed := True;
//            Container2.MarkModifiedRecursive;
//          end;
//          Container2.RemoveElement(i);
//        end;
//      if Container2.ElementCount < 1 then
//        Container2.Remove;
//    end;
  finally
    wbEndInternalEdit;
  end;
end;

procedure wbMGEFAfterLoad(const aElement: IwbElement);
var
  Container    : IwbContainerElementRef;
  MainRecord   : IwbMainRecord;
  _File        : IwbFile;
begin
  if wbBeginInternalEdit then try
    if not Supports(aElement, IwbContainerElementRef, Container) then
      Exit;

    if Container.ElementCount < 1 then
      Exit;

    if not Supports(aElement, IwbMainRecord, MainRecord) then
      Exit;

    if MainRecord.IsDeleted then
      Exit;

    _File := MainRecord._File;

    if not Assigned(_File) then
      Exit;

    if not SameText(_File.FileName, 'Oblivion.esm') then
      Exit;

    if SameText(MainRecord.EditorID, 'RSFI') or
       SameText(MainRecord.EditorID, 'RSFR') or
       SameText(MainRecord.EditorID, 'RSPA') or
       SameText(MainRecord.EditorID, 'RSSH') then begin

         Container.ElementNativeValues['DATA - Data\Flags'] :=
           Cardinal(Container.ElementNativeValues['DATA - Data\Flags']) or $8;

       end;

    if SameText(MainRecord.EditorID, 'REAN') then begin

         Container.ElementNativeValues['DATA - Data\Flags'] :=
           Cardinal(Container.ElementNativeValues['DATA - Data\Flags']) and not $20000;

       end;

  finally
    wbEndInternalEdit;
  end;
end;

procedure wbCounterEffectsAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
begin
  wbCounterByPathAfterSet('DATA - Data\Counter effect count', aElement);
end;

procedure wbMGEFAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
begin
  wbCounterContainerByPathAfterSet('DATA - Data\Counter effect count', 'ESCE - Counter Effects', aElement);
end;

procedure wbEFITAfterLoad(const aElement: IwbElement);
var
  Container : IwbContainerElementRef;
  Element   : IwbElement;
  ActorValue: Variant;
  MainRecord: IwbMainRecord;
begin
  if wbBeginInternalEdit then try
    if not Supports(aElement, IwbContainerElementRef, Container) then
      Exit;
    if Container.ElementCount < 1 then
      Exit;

    Element := Container.ElementByName['Magic effect name'];
    if not Assigned(Element) then
      Exit;
    if not Supports(Element.LinksTo, IwbMainRecord, MainRecord) then
      Exit;
    if MainRecord.Signature <> 'MGEF' then
      Exit;

    if (MainRecord.ElementNativeValues['DATA - Data\Flags'] and $01000000) = 0 then
      Exit;

    ActorValue := MainRecord.ElementNativeValues['DATA - Data\Assoc. Item'];
    if VarIsNull(ActorValue) or VarIsClear(ActorValue) then
      Exit;
    if VarCompareValue(ActorValue, Container.ElementNativeValues['Actor Value']) <> vrEqual then
      Container.ElementNativeValues['Actor Value'] := ActorValue;
  finally
    wbEndInternalEdit;
  end;
end;

procedure wbREFRAfterLoad(const aElement: IwbElement);
var
  Container: IwbContainerElementRef;
begin
  if wbBeginInternalEdit then try
    if not Supports(aElement, IwbContainerElementRef, Container) then
      Exit;
    if Container.ElementCount < 1 then
      Exit;

    Container.RemoveElement('XPCI');
  finally
    wbEndInternalEdit;
  end;
end;

procedure wbLIGHAfterLoad(const aElement: IwbElement);
var
  Container  : IwbContainerElementRef;
  MainRecord : IwbMainRecord;
begin
  if wbBeginInternalEdit then try
    if not Supports(aElement, IwbContainerElementRef, Container) then
      Exit;

    if Container.ElementCount < 1 then
      Exit;

    if not Supports(aElement, IwbMainRecord, MainRecord) then
      Exit;

    if MainRecord.IsDeleted then
      Exit;

    if Container.ElementExists['DATA'] then begin
      if SameValue(Container.ElementNativeValues['DATA\Falloff Exponent'], 0.0) then
        Container.ElementNativeValues['DATA\Falloff Exponent'] := 1.0;
      if SameValue(Container.ElementNativeValues['DATA\FOV'], 0.0) then
        Container.ElementNativeValues['DATA\FOV'] := 90.0;
    end;
  finally
    wbEndInternalEdit;
  end;
end;

procedure wbLVLAfterLoad(const aElement: IwbElement);
var
  Container  : IwbContainerElementRef;
  MainRecord : IwbMainRecord;
  Chance     : Integer;
begin
  if wbBeginInternalEdit then try
    if not Supports(aElement, IwbContainerElementRef, Container) then
      Exit;

    if Container.ElementCount < 1 then
      Exit;

    if not Supports(aElement, IwbMainRecord, MainRecord) then
      Exit;

    if MainRecord.IsDeleted then
      Exit;

    Container.RemoveElement('DATA');

    Chance := Container.ElementNativeValues['LVLD'];
    if (Chance and $80) <> 0 then begin
      Chance := Chance and not $80;
      Container.ElementNativeValues['LVLD'] := Chance;
      Container.ElementNativeValues['LVLF'] := Container.ElementNativeValues['LVLF'] or $01;
    end;
  finally
    wbEndInternalEdit;
  end;
end;

procedure wbRPLDAfterLoad(const aElement: IwbElement);
var
  Container : IwbContainer;
  a, b      : Single;
  NeedsFlip : Boolean;
begin
  if wbBeginInternalEdit then try
    if not Supports(aElement, IwbContainer, Container) then
      Exit;

    NeedsFlip := False;
    if Container.ElementCount > 1 then begin
      a := (Container.Elements[0] as IwbContainer).Elements[0].NativeValue;
      b := (Container.Elements[Pred(Container.ElementCount)] as IwbContainer).Elements[0].NativeValue;
      case CompareValue(a, b) of
        EqualsValue: begin
          a := (Container.Elements[0] as IwbContainer).Elements[1].NativeValue;
          b := (Container.Elements[Pred(Container.ElementCount)] as IwbContainer).Elements[1].NativeValue;
          NeedsFlip := CompareValue(a, b) = GreaterThanValue;
        end;
        GreaterThanValue:
          NeedsFlip := True;
      end;
    end;
    if NeedsFlip then
      Container.ReverseElements;
  finally
    wbEndInternalEdit;
  end;
end;

procedure wbPGRDAfterLoad(const aElement: IwbElement);
var
  Container   : IwbContainerElementRef;
  MainRecord  : IwbMainRecord;
  Points      : IwbContainerElementRef;
  Connections : IwbContainerElementRef;
  i, j        : Integer;
  Point       : IwbContainerElementRef;
  Connection  : IwbContainerElementRef;
  Removed     : Boolean;
  FirstRemoved: Boolean;
begin
  if wbBeginInternalEdit then try
    if not Supports(aElement, IwbContainerElementRef, Container) then
      Exit;

    if Container.ElementCount < 1 then
      Exit;

    if not Supports(aElement, IwbMainRecord, MainRecord) then
      Exit;

    if MainRecord.IsDeleted then
      Exit;

    if not Supports(Container.ElementBySignature['PGRP'], IwbContainerElementRef, Points) then
      Exit;

    if not Container.ElementExists['PGAG'] then
      Container.Add('PGAG').DataSize := (Points.ElementCount + 7) div 8;

    MainRecord.IsCompressed := True;

    if not Supports(Container.ElementBySignature['PGRR'], IwbContainerElementRef, Connections) then
      Exit;

    if Points.ElementCount < Connections.ElementCount then
      Exit;

    FirstRemoved := False;
    for i := Pred(Connections.ElementCount) downto 0 do begin
      Connection := Connections.Elements[i] as IwbContainerElementRef;

      Removed := False;
      j := Connection.ElementCount;
      while j > 0 do begin
        Dec(j);
        if Connection.Elements[j].NativeValue = 65535 then begin
          if not FirstRemoved then begin
            FirstRemoved := True;
            Connections.MarkModifiedRecursive(AllElementTypes);
          end;
          Connection.Elements[j].Remove;
          Removed := True;
        end else
          Break;
      end;

      if Removed then begin
        Point := Points.Elements[i] as IwbContainerElementRef;
        Point.ElementNativeValues['Connections'] := Connection.ElementCount;
      end;

    end;

  finally
    wbEndInternalEdit;
  end;
end;

procedure wbPGRRPointAfterLoad(const aElement: IwbElement);
var
  Connections : IwbContainerElementRef;
  i           : Integer;
//  Index       : Integer;
begin
  if wbBeginInternalEdit then try
    if not Supports(aElement, IwbContainerElementRef, Connections) then
      Exit;
    for i := Pred(Connections.ElementCount) downto 0 do
      if Connections.Elements[i].NativeValue = 65535 then begin
        Connections.RemoveElement(i);
      end;
{    if Removed then begin
      Index := aElement.Container.ElementCount;
      (aElement.ContainingMainRecord.RecordBySignature['PGRP'].Elements[Index] as IwbContainer).Elements[3].NativeValue := Connections.ElementCount;
    end;}
  finally
    wbEndInternalEdit;
  end;
end;

procedure wbPGRIPointerAfterLoad(const aElement: IwbElement);
var
  Connections : IwbContainerElementRef;
  i, j        : Integer;
  s           : string;
  Keys        : TStringList;
begin
  if wbBeginInternalEdit then try
    if not Supports(aElement, IwbContainerElementRef, Connections) then
      Exit;

    Keys := TStringList.Create;
    try
      Keys.Sorted := True;
      Keys.Duplicates := dupError;
      for i := Pred(Connections.ElementCount) downto 0 do begin
        s := Connections.Elements[i].SortKey[True];
        if Keys.Find(s, j) then
          Connections.RemoveElement(i, True)
        else
          Keys.Add(s);
      end;
    finally
      Keys.Free;
    end;
  finally
    wbEndInternalEdit;
  end;
end;

{
function wbPGRPConnectionsCallback(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
var
  Point : IwbContainerElementRef;
  s     : string;
  i     : Integer;
  PGRP  : IwbContainerElementRef;
  PGRD  : IwbMainRecord;
  PGRR  : IwbContainerElementRef;
  Cons  : IwbContainerElementRef;
begin
  Result := '';
  if aType = ctCheck then
    Exit;

  if wbFixupPGRD and (aInt > 0) and Assigned(aElement) and (aElement.ElementStates * [esModified] = []) then begin
    Point := aElement.Container as IwbContainerElementRef;
    if Assigned(Point) then begin
      s := Trim(Point.Name);
      i := Pos('#', s);
      if i > 0 then begin
        i := StrToIntDef(Copy(s, i+1, High(Integer)), -1);
        if i >= 0 then begin
          PGRP := Point.Container as IwbContainerElementRef;
          if Assigned(PGRP) then begin
            if Supports(PGRP.Container, IwbMainRecord, PGRD) then begin
              if (csInitDone in PGRD.ContainerStates) and (PGRD.Signature = 'PGRD') then begin
                PGRR := PGRD.RecordBySignature['PGRR'] as IwbContainerElementRef;
                if Assigned(PGRR) and (PGRR.ElementCount > 0) and (csInitDone in PGRR.ContainerStates) then begin
                  if (i < PGRR.ElementCount) then begin
                    if Supports(PGRR.Elements[i], IwbContainer, Cons) then begin
                      aInt := Cons.ElementCount;
                    end;
                  end;
                end;
                PGRR := nil;
              end;
            end;
          end;
        end;
      end;
    end;
  end;

  if aType = ctToSortKey then
    Result := IntToHex64(aInt, 2)
  else if aType = ctToStr then
    Result := IntToStr(aInt);
end;
}

function wbPxDTLocationDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container: IwbContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Container := GetContainerFromUnion(aElement);
  if not Assigned(Container) then Exit;

  Result := Container.ElementByName['Type'].NativeValue;
end;

function wbCalcPGRRSize(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;
var
  Index: Integer;

  function ExtractCountFromLabel(const aElement: IwbElement; aCount: Integer): Integer;
  var
    i: Integer;
  begin
    i := Pos('#', aElement.Name);
    if i = 0 then
      Result := aCount
    else try
      Result := StrToInt(Trim(Copy(aElement.Name, i+1, Length(aElement.Name))))+1;
    except
      Result := aCount;
    end;

  end;

begin
  Index := ExtractCountFromLabel(aElement, aElement.Container.ElementCount);
  Result := ((aElement.Container.Container as IwbMainRecord).RecordBySignature['PGRP'].Elements[Pred(Index)] as IwbContainer).Elements[3].NativeValue;
end;

function wbMGEFFAssocItemDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  s: string;
  Container: IwbContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Container := GetContainerFromUnion(aElement);
  if not Assigned(Container) then Exit;

  s := Container.ElementByName['Flags'].SortKey[False];
  if s[17] = '1' then
    Result := 1
  else if s[18] = '1' then
    Result := 2
  else if s[19] = '1' then
    Result := 3
  else if s[25] = '1' then
    Result := 4;
end;

function wbEDDXDontShow(const aElement: IwbElement): Boolean;
var
  MainRecord : IwbMainRecord;
begin
  Result := True;

  if Supports(aElement.Container, IwbMainRecord, MainRecord) then
    Result := not Assigned(MainRecord.ElementBySignature[OBME]);
end;

function wbOBMEDontShow(const aElement: IwbElement): Boolean;
var
  _File: IwbFile;
begin
  if not Assigned(aElement) then begin
    Result := True;
    Exit;
  end;

  Result := False;

  _File := aElement._File;
  if Assigned(_File) and SameText(_File.FileName, 'Oblivion.esm') then
    Result := True;
end;

function wbOffsetDataColsCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;
var
  Container : IwbDataContainer;
  Element   : IwbElement;
  fResult   : Extended;
begin
  Result := 0;

  if Supports(aElement.Container, IwbDataContainer, Container) and (Container.Name = 'OFST - Offset Data') and
     Supports(Container.Container, IwbDataContainer, Container) then begin
    Element := Container.ElementByPath['Object Bounds\NAM0 - Min\X'];
    if Assigned(Element) then begin
      fResult :=  Element.NativeValue;
      if fResult >= MaxInt then
        Result := 0
      else
        Result := Trunc(fResult);
      Element := Container.ElementByPath['Object Bounds\NAM9 - Max\X'];
      if Assigned(Element) then begin
        fResult :=  Element.NativeValue;
        if fResult >= MaxInt then
          Result := 1
        else
          Result := Trunc(fResult) - Result + 1;
      end;
    end;
  end;
end;

procedure DefineTES4;
var
  wbEffect: IwbRecordMemberDef;
  wbFactionRank: IwbRecordMemberDef;
  wbEffects: IwbRecordMemberDef;
  wbFaction: IwbRecordMemberDef;
  wbLeveledListEntryCreature: IwbRecordMemberDef;
  wbLeveledListEntryItem: IwbRecordMemberDef;
  wbLeveledListEntrySpell: IwbRecordMemberDef;
begin
  wbRecordFlags := wbInteger('Record Flags', itU32, wbFlags([
    {0x00000001}'ESM',
    {0x00000002}'',
    {0x00000004}'',
    {0x00000008}'',
    {0x00000010}'',
    {0x00000020}'Deleted',
    {0x00000040}'Border Region / Actor Value',
    {0x00000080}'Turn Off Fire / Actor Value',
    {0x00000100}'',
    {0x00000200}'Casts shadows',
    {0x00000400}'Quest item / Persistent reference / Show in Menu',
    {0x00000800}'Initially disabled',
    {0x00001000}'Ignored',
    {0x00002000}'',
    {0x00004000}'',
    {0x00008000}'Visible when distant',
    {0x00010000}'',
    {0x00020000}'Dangerous / Off limits (Interior cell)',
    {0x00040000}'Compressed',
    {0x00080000}'Can''t wait'
  ]));

  wbMainRecordHeader := wbStruct('Record Header', [
    wbString('Signature', 4, cpCritical),
    wbInteger('Data Size', itU32, nil, cpIgnore),
    wbRecordFlags,
    wbFormID('FormID', cpFormID),
    wbByteArray('Version Control Info', 4, cpIgnore).SetToStr(wbVCI1ToStrBeforeFO4)
  ]).SetToStr(wbRecordHeaderToStr).IncludeFlag(dfCollapsed, wbCollapseRecordHeader);

  wbSizeOfMainRecordStruct := 20;

  wbIgnoreRecords.Add(XXXX);

  wbXRGD := wbByteArray(XRGD, 'Ragdoll Data');

  wbMusicEnum := wbEnum(['Default', 'Public', 'Dungeon']);

  wbEDID := wbString(EDID, 'Editor ID', 0, cpNormal); // not cpBenign according to Arthmoor
  wbFULL := wbStringKC(FULL, 'Name', 0, cpTranslate);
  wbFULLReq := wbStringKC(FULL, 'Name', 0, cpTranslate, True);
  wbDESC := wbStringKC(DESC, 'Description', 0, cpTranslate);
  wbXSCL := wbFloat(XSCL, 'Scale');

  wbPosRot :=
    wbStruct('Position/Rotation', [
      wbStruct('Position', [
        wbFloat('X'),
        wbFloat('Y'),
        wbFloat('Z')
      ]).SetToStr(wbVec3ToStr).IncludeFlag(dfCollapsed, wbCollapseVec3),
      wbStruct('Rotation', [
        wbFloat('X', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize),
        wbFloat('Y', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize),
        wbFloat('Z', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize)
      ]).SetToStr(wbVec3ToStr).IncludeFlag(dfCollapsed, wbCollapseVec3)
    ]);

  wbDATAPosRot :=
    wbStruct(DATA, 'Position/Rotation', [
      wbStruct('Position', [
        wbFloat('X'),
        wbFloat('Y'),
        wbFloat('Z')
      ]).SetToStr(wbVec3ToStr).IncludeFlag(dfCollapsed, wbCollapseVec3),
      wbStruct('Rotation', [
        wbFloat('X', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize),
        wbFloat('Y', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize),
        wbFloat('Z', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize)
      ]).SetToStr(wbVec3ToStr).IncludeFlag(dfCollapsed, wbCollapseVec3)
    ], cpNormal, True);

  wbMODL :=
    wbRStructSK([0], 'Model', [
      wbString(MODL, 'Model FileName'),
      wbFloat(MODB, 'Bound Radius', cpBenign),
      wbByteArray(MODT, 'Texture Files Hashes', 0, cpIgnore)
//      wbArray(MODT, 'Unknown',
//        wbByteArray('Unknown', 24, cpBenign),
//      0, nil, cpBenign)
    ], []).SetToStr(wbModelToStr).IncludeFlag(dfCollapsed, wbCollapseModels);

  wbSCRI := wbFormIDCk(SCRI, 'Script', [SCPT]);
  wbENAM := wbFormIDCk(ENAM, 'Enchantment', [ENCH]);

  wbXLOD := wbArray(XLOD, 'Distant LOD Data', wbFloat('Unknown'), 3);
  wbXESP := wbStruct(XESP, 'Enable Parent', [
    wbFormIDCk('Reference', [PLYR, REFR, ACRE, ACHR]),
    wbInteger('Flags', itU8, wbFlags([
      'Set Enable State to Opposite of Parent'
    ])),
    wbByteArray('Unused', 3)
  ]);

  wbRefRecord(ACHR, 'Placed NPC', [
    wbEDID,
    wbFormIDCk(NAME, 'Base', [NPC_], False, cpNormal, True),
    wbRStruct('Unused', [
      wbFormIDCk(XPCI, 'Unused', [CELL]),
      wbString(FULL, 'Unused')
    ], []),
    wbXLOD,
    wbXESP,
    wbFormIDCk(XMRC, 'Merchant container', [REFR], True),
    wbFormIDCk(XHRS, 'Horse', [ACRE], True),
    wbXRGD,
    wbXSCL,
    wbDATAPosRot
  ], True, wbPlacedAddInfo, cpNormal, False, wbREFRAfterLoad);

  wbXOWN := wbFormIDCkNoReach(XOWN, 'Owner', [FACT, NPC_]);
  wbXGLB := wbFormIDCk(XGLB, 'Global variable', [GLOB]);

  wbRefRecord(ACRE, 'Placed Creature', [
    wbEDID,
    wbFormIDCk(NAME, 'Base', [CREA], False, cpNormal, True),
    wbRStruct('Ownership', [
      wbXOWN,
      wbInteger(XRNK, 'Faction rank', itS32),
      wbXGLB
    ], []).SetToStr(wbFactionToStr).IncludeFlag(dfCollapsed, wbCollapseFactions),
    wbXESP,
    wbXRGD,
    wbXSCL,
    wbDATAPosRot
  ], True, wbPlacedAddInfo);

  wbRecord(ACTI, 'Activator', [
    wbEDID,
    wbFULL,
    wbMODL,
    wbSCRI,
    wbFormIDCk(SNAM, 'Sound', [SOUN])
  ]);

  wbICON := wbString(ICON, 'Icon FileName');

  wbActorValueEnum :=
    wbEnum([
      'Strength',
      'Intelligence',
      'Willpower',
      'Agility',
      'Speed',
      'Endurance',
      'Personality',
      'Luck',
      'Health',
      'Magicka',
      'Fatigue',
      'Encumbrance',
      'Armorer',
      'Athletics',
      'Blade',
      'Block',
      'Blunt',
      'Hand To Hand',
      'Heavy Armor',
      'Alchemy',
      'Alteration',
      'Conjuration',
      'Destruction',
      'Illusion',
      'Mysticism',
      'Restoration',
      'Acrobatics',
      'Light Armor',
      'Marksman',
      'Mercantile',
      'Security',
      'Sneak',
      'Speechcraft',
 {33} 'Aggression',
 {34} 'Confidence',
 {35} 'Energy',
 {36} 'Responsibility',
 {37} 'Bounty',
 {38} 'Fame',
 {39} 'Infamy',
 {40} 'Magicka Multiplier',
 {41} 'Night Eye Bonus',
 {42} 'Attack Bonus',
 {43} 'Defend Bonus',
 {44} 'Casting Penalty',
 {45} 'Blindness',
 {46} 'Chameleon',
 {47} 'Invisibility',
 {48} 'Paralysis',
 {49} 'Silence',
 {50} 'Confusion',
 {51} 'Detect Item Range',
 {52} 'Spell Absorb Chance',
 {53} 'Spell Reflect Chance',
 {54} 'Swim Speed Multiplier',
 {55} 'Water Breathing',
 {56} 'Water Walking',
 {57} 'Stunted Magicka',
 {58} 'Detect Life Range',
 {59} 'Reflect Damage',
 {60} 'Telekinesis',
 {61} 'Resist Fire',
 {62} 'Resist Frost',
 {63} 'Resist Disease',
 {64} 'Resist Magic',
 {65} 'Resist Normal Weapons',
 {66} 'Resist Paralysis',
 {67} 'Resist Poison',
 {68} 'Resist Shock',
 {69} 'Vampirism',
 {70} 'Darkness',
 {71} 'Resist Water Damage'
    ], [
      -1, 'None'
    ]);

  wbSkillEnum :=
    wbEnum([
      'Armorer',
      'Athletics',
      'Blade',
      'Block',
      'Blunt',
      'Hand To Hand',
      'Heavy Armor',
      'Alchemy',
      'Alteration',
      'Conjuration',
      'Destruction',
      'Illusion',
      'Mysticism',
      'Restoration',
      'Acrobatics',
      'Light Armor',
      'Marksman',
      'Mercantile',
      'Security',
      'Sneak',
      'Speechcraft'
    ], [
      -1, 'None'
    ]);


  wbEFID := wbInteger(EFID, 'Magic effect name', itU32, wbChar4, cpNormal, True);

  wbEFIDOBME := wbStringMgefCode(EFID, 'Magic Effect Code', 4, cpNormal, True);

  wbEFIT :=
    wbStructSK(EFIT, [4, 5], '', [
      wbInteger('Magic effect name', itU32, wbChar4),
      wbInteger('Magnitude', itU32),
      wbInteger('Area', itU32),
      wbInteger('Duration', itU32),
      wbInteger('Type', itU32, wbEnum(['Self', 'Touch', 'Target'])),
      wbInteger('Actor Value', itS32, wbActorValueEnum)
    ], cpNormal, True, nil, -1, wbEFITAfterLoad);

  wbEFITOBME :=
    wbStructSK(EFIT, [4, 5], '', [
      wbStringMgefCode('Magic Effect Code', 4),
      wbInteger('Magnitude', itU32),
      wbInteger('Area', itU32),
      wbInteger('Duration', itU32),
      wbInteger('Type', itU32, wbEnum(['Self', 'Touch', 'Target'])),
      wbUnion('Param #1', wbEFITOBMEParamDecider, [
        wbByteArray('Param #1 - Unknown Type', 4),
        wbFormID('Param #1 - FormID'),
        wbStringMgefCode('Param #1 - Magic Effect Code', 4),
        wbFormIDCk('Param #1 - Actor Value', [ACVA])
      ])
    ], cpNormal, True, nil, -1{, wbEFITAfterLoad});

  wbEFIX :=
    wbStructSK(EFIX, [3], '', [
      wbInteger('Override Mask', itU32, wbFlags([])),
      wbInteger('Flags', itU32, wbFlags([])),
      wbFloat('Base Cost'),
      wbUnion('Param #2', wbEFIXParamDecider, [
        wbByteArray('Param #2 - Unknown Type', 4),
        wbFormID('Param #2 - FormID'),
        wbStringMgefCode('Param #2 - Magic Effect Code', 4),
        wbFormIDCk('Param #2 - Actor Value', [ACVA])
      ]),
      wbUnknown
    ], cpNormal, True, nil, -1, wbEFITAfterLoad);

  wbMagicSchoolEnum :=
    wbEnum([
      'Alteration',
      'Conjuration',
      'Destruction',
      'Illusion',
      'Mysticism',
      'Restoration'
    ]);

  wbSCIT :=
    wbRStructSK([0], 'Script effect', [
      wbStructSK(SCIT, [0], 'Script effect data', [
        wbFormIDCk('Script effect', [NULL, SCPT]),
        wbInteger('Magic school', itU32, wbMagicSchoolEnum),
        wbInteger('Visual effect name', itU32, wbChar4),
        wbInteger('Flags', itU8, wbFlags(['Hostile'])),
        wbByteArray('Unused', 3)
      ], cpNormal, True, nil, 1),
      wbFULLReq
    ], []);

  wbSCITOBME :=
    wbRStructSK([0], 'Script effect', [
      wbStructSK(SCIT, [0], 'Script effect data', [
        wbFormIDCk('Script effect', [NULL, SCPT]),
        wbInteger('Magic school', itU32, wbMagicSchoolEnum),
        wbStringMgefCode('Visual Effect Code', 4),
        wbInteger('Flags', itU8, wbFlags(['Hostile'])),
        wbByteArray('Unused', 3)
      ], cpNormal, True, nil, 1),
      wbFULLReq
    ], []);


  wbOBMEResolutionInfo := wbEnum(['None', 'FormID', 'Magic Effect Code', 'Actor Value']);

  wbEffect :=
    wbRStruct('Effect', [
      wbStruct(EFME, 'Oblivion Magic Extender', [
        wbInteger('Record Version', itU8),
        wbStruct('OBME Version', [
          wbInteger('Beta', itU8),
          wbInteger('Minor', itU8),
          wbInteger('Major', itU8)
        ]),
        wbInteger('EFIT Param Info', itU8, wbOBMEResolutionInfo),
        wbInteger('EFIX Param Info', itU8, wbOBMEResolutionInfo),
        wbByteArray('Unused', $0A)
      ]),
      wbEFIDOBME,
      wbEFITOBME,
      wbSCITOBME,
      wbString(EFII, 'Icon'),
      wbEFIX
    ], []);

  wbEffects := wbRArray('Effects',
    wbRUnion('Effects', [
      wbRStructSK([0, 1], 'Effect', [
        wbEFID,
        wbEFIT,
        wbSCIT
      ], []),
      wbRStruct('Effects', [
        wbRArray('Effects', wbEffect),
        wbEmpty(EFXX, 'Effects End Marker', cpNormal, True),
        wbFULLReq
      ], [])
    ], [])
  );

//  wbEffects :=
//    wbRUnion('Effects', [
//      wbRStruct('Effects', [
//        wbRStructs('Effects','Effect', [
//          wbEFID,
//          wbEFIT,
//          wbSCIT
//        ], [])
//      ], []),
//      wbRStruct('Effects', [
//        wbRStructs('Effects','Effect', [
//          wbStruct(EFME, 'Oblivion Magic Extender', [
//            wbInteger('Record Version', itU8),
//            wbStruct('OBME Version', [
//              wbInteger('Beta', itU8),
//              wbInteger('Minor', itU8),
//              wbInteger('Major', itU8)
//            ]),
//            wbInteger('EFIT Param Info', itU8, wbOBMEResolutionInfo),
//            wbInteger('EFIX Param Info', itU8, wbOBMEResolutionInfo),
//            wbByteArray('Unused', $0A)
//          ]),
//          wbEFIDOBME,
//          wbEFITOBME,
//          wbSCITOBME,
//          wbString(EFII, 'Icon'),
//          wbEFIX
//        ], []),
//        wbEmpty(EFXX, 'Effects End Marker', cpNormal, True),
//        wbFULLReq
//      ], [])
//    ], []);

  wbRecord(ALCH, 'Potion', [
    wbEDID,
    wbStruct(OBME, 'Oblivion Magic Extender', [
      wbInteger('Record Version', itU8),
      wbStruct('OBME Version', [
        wbInteger('Beta', itU8),
        wbInteger('Minor', itU8),
        wbInteger('Major', itU8)
      ]),
      wbByteArray('Unused', $1C)
    ], cpNormal, False, wbOBMEDontShow),
    wbFULL,
    wbMODL,
    wbICON,
    wbSCRI,
    wbFloat(DATA, 'Weight', cpNormal, True),
    wbStruct(ENIT, '', [
      wbInteger('Value', itS32),
      wbInteger('Flags', itU8, wbFlags(['No auto-calculation', 'Food item'])),
      wbByteArray('Unused', 3)
    ], cpNormal, True),
    wbEffects
  ]);

  wbRecord(AMMO, 'Ammunition', [
    wbEDID,
    wbFULL,
    wbMODL,
    wbICON,
    wbFormIDCk(ENAM, 'Enchantment', [ENCH]),
    wbInteger(ANAM, 'Enchantment Points', itU16),
    wbStruct(DATA, '', [
      wbFloat('Speed'),
      wbInteger('Flags', itU8, wbFlags(['Ignores Normal Weapon Resistance'])),
      wbByteArray('Unused', 3),
      wbInteger('Value', itU32),
      wbFloat('Weight'),
      wbInteger('Damage', itU16)
    ], cpNormal, True)
  ]);

  wbRecord(ANIO, 'Animated Object', [
    wbEDID,
    wbMODL,
    wbFormIDCk(DATA, 'IDLE animation', [IDLE], False, cpNormal, True)
  ]).SetSummaryKey([1, 2]).IncludeFlag(dfSummaryNoName);

  wbRecord(APPA, 'Alchemical Apparatus', [
    wbEDID,
    wbFULL,
    wbMODL,
    wbICON,
    wbSCRI,
    wbStruct(DATA, '', [
      wbInteger('Type', itU8, wbEnum(['Mortar and Pestle', 'Alembic', 'Calcinator', 'Retort'])),
      wbInteger('Value', itU32),
      wbFloat('Weight'),
      wbFloat('Quality')
    ], cpNormal, True)
  ]);

  wbMaleBipedModel :=
    wbRStruct('Male biped model', [
      wbString(MODL, 'Model FileName'),
      wbFloat(MODB, 'Bound Radius', cpBenign),
      wbByteArray(MODT, 'Texture Files Hashes', 0, cpIgnore)
    ], []).SetToStr(wbModelToStr).IncludeFlag(dfCollapsed, wbCollapseModels);

  wbMaleWorldModel :=
    wbRStruct('Male world model', [
      wbString(MOD2, 'Model FileName'),
      wbFloat(MO2B, 'Bound Radius', cpBenign),
      wbByteArray(MO2T, 'Texture Files Hashes', 0, cpIgnore)
    ], []).SetToStr(wbModelToStr).IncludeFlag(dfCollapsed, wbCollapseModels);

  wbFemaleBipedModel :=
    wbRStruct('Female biped model', [
      wbString(MOD3, 'Model FileName'),
      wbFloat(MO3B, 'Bound Radius', cpBenign),
      wbByteArray(MO3T, 'Texture Files Hashes', 0, cpIgnore)
    ], []).SetToStr(wbModelToStr).IncludeFlag(dfCollapsed, wbCollapseModels);

  wbFemaleWorldModel :=
    wbRStruct('Female world model', [
      wbString(MOD4, 'Model FileName'),
      wbFloat(MO4B, 'Bound Radius', cpBenign),
      wbByteArray(MO4T, 'Texture Files Hashes', 0, cpIgnore)
    ], []).SetToStr(wbModelToStr).IncludeFlag(dfCollapsed, wbCollapseModels);

  wbRecord(ARMO, 'Armor', [
    wbEDID,
    wbFULL,
    wbSCRI,
    wbENAM,
    wbInteger(ANAM, 'Enchantment Points', itU16),
    wbStruct(BMDT, '', [
      wbInteger('Biped Flags', itU16, wbFlags([
        {0x00000001} 'Head',
        {0x00000002} 'Hair',
        {0x00000004} 'Upper Body',
        {0x00000008} 'Lower Body',
        {0x00000010} 'Hand',
        {0x00000020} 'Foot',
        {0x00000040} 'Right Ring',
        {0x00000080} 'Left Ring',
        {0x00000100} 'Amulet',
        {0x00000200} 'Weapon',
        {0x00000400} 'Back Weapon',
        {0x00000800} 'Side Weapon',
        {0x00001000} 'Quiver',
        {0x00002000} 'Shield',
        {0x00004000} 'Torch',
        {0x00008000} 'Tail'
      ])),
      wbInteger('General Flags', itU8, wbFlags([
        {0x0001} 'Hide Rings',
        {0x0002} 'Hide Amulets',
        {0x0004} '',
        {0x0008} '',
        {0x0010} '',
        {0x0020} '',
        {0x0040} 'Non-Playable',
        {0x0080} 'Heavy armor'
      ])),
      wbByteArray('Unused', 1)
    ], cpNormal, True),
    wbMaleBipedModel,
    wbMaleWorldModel,
    wbString(ICON, 'Male icon FileName'),
    wbFemaleBipedModel,
    wbFemaleWorldModel,
    wbString(ICO2, 'Female icon FileName'),
    wbStruct(DATA, '', [
      wbInteger('Armor', itU16, wbDiv(100)),
      wbInteger('Value', itU32),
      wbInteger('Health', itU32),
      wbFloat('Weight')
    ], cpNormal, True)
  ]);

  wbRecord(BOOK, 'Book', [
    wbEDID,
    wbFULL,
    wbMODL,
    wbICON,
    wbSCRI,
    wbENAM,
    wbInteger(ANAM, 'Enchantment Points', itU16),
    wbDESC,
    wbStruct(DATA, '', [
      wbInteger('Flags', itU8, wbFlags(['Scroll', 'Can''t be taken'])),
      wbInteger('Teaches', itS8, wbSkillEnum),
      wbInteger('Value', itU32),
      wbFloat('Weight')
    ], cpNormal, True)
  ], True);

  wbSPLO := wbFormIDCk(SPLO, 'Spell', [SPEL, LVSP]);
  wbSPLOs := wbRArrayS('Spells', wbSPLO);

  wbRecord(BSGN, 'Birthsign', [
    wbEDID,
    wbFULL,
    wbICON,
    wbDESC,
    wbSPLOs
  ]);

  wbRecord(CELL, 'Cell', [
    wbEDID,
    wbFULL,
    wbInteger(DATA, 'Flags', itU8, wbFlags([
      {0x01} 'Is Interior Cell',
      {0x02} 'Has water',
      {0x04} 'Invert Fast Travel behavior',
      {0x08} 'Force hide land (exterior cell) / Oblivion interior (interior cell)',
      {0x10} '',
      {0x20} 'Public place',
      {0x40} 'Hand changed',
      {0x80} 'Behave like exterior'
    ]), cpNormal, True),
    wbStruct(XCLC, 'Grid', [
      wbInteger('X', itS32),
      wbInteger('Y', itS32)
    ]),
    wbStruct(XCLL, 'Lighting', [
      wbStruct('Ambient Color', [
        wbInteger('Red', itU8),
        wbInteger('Green', itU8),
        wbInteger('Blue', itU8),
        wbByteArray('Unused', 1)
      ]).SetToStr(wbRGBAToStr).IncludeFlag(dfCollapsed, wbCollapseRGBA),
      wbStruct('Directional Color', [
        wbInteger('Red', itU8),
        wbInteger('Green', itU8),
        wbInteger('Blue', itU8),
        wbByteArray('Unused', 1)
      ]).SetToStr(wbRGBAToStr).IncludeFlag(dfCollapsed, wbCollapseRGBA),
      wbStruct('Fog Color', [
        wbInteger('Red', itU8),
        wbInteger('Green', itU8),
        wbInteger('Blue', itU8),
        wbByteArray('Unused', 1)
      ]).SetToStr(wbRGBAToStr).IncludeFlag(dfCollapsed, wbCollapseRGBA),
      wbFloat('Fog Near'),
      wbFloat('Fog Far'),
      wbInteger('Directional Rotation XY', itS32),
      wbInteger('Directional Rotation Z', itS32),
      wbFloat('Directional Fade', cpNormal, False, 1, -1, nil, nil, 1.0),
      wbFloat('Fog Clip Dist')
    ]),
    wbArrayS(XCLR, 'Regions', wbFormIDCk('Region', [REGN])),
    wbInteger(XCMT, 'Music', itU8, wbMusicEnum),
    wbFloat(XCLW, 'Water Height', cpBenign),
    wbFormIDCk(XCCM, 'Climate', [CLMT]),
    wbFormIDCk(XCWT, 'Water', [WATR]),
    wbRStruct('Ownership', [
      wbXOWN,
      wbInteger(XRNK, 'Faction rank', itS32),
      wbXGLB
    ], [XCLW, XCMT, XCCM]).SetToStr(wbFactionToStr).IncludeFlag(dfCollapsed, wbCollapseFactions)
  ], True, wbCellAddInfo, cpNormal, False, wbCELLAfterLoad);

  wbServiceFlags :=
    wbFlags([
      {0x00000001} 'Weapons',
      {0x00000002} 'Armor',
      {0x00000004} 'Clothing',
      {0x00000008} 'Books',
      {0x00000010} 'Ingredients',
      {0x00000020} '',
      {0x00000040} '',
      {0x00000080} 'Lights',
      {0x00000100} 'Apparatus',
      {0x00000200} '',
      {0x00000400} 'Miscellaneous',
      {0x00000800} 'Spells',
      {0x00001000} 'Magic Items',
      {0x00002000} 'Potions',
      {0x00004000} 'Training',
      {0x00008000} '',
      {0x00010000} 'Recharge',
      {0x00020000} 'Repair'
    ]);

  wbSpecializationEnum := wbEnum(['Combat', 'Magic', 'Stealth']);

  wbRecord(CLAS, 'Class', [
    wbEDID,
    wbFULL,
    wbDESC,
    wbICON,
    wbStruct(DATA, '', [
      wbArrayS('Primary Attributes', wbInteger('Primary Attribute', itS32, wbActorValueEnum), 2),
      wbInteger('Specialization', itU32, wbSpecializationEnum),
      wbArrayS('Major Skills', wbInteger('Major Skill', itS32, wbActorValueEnum), 7),
      wbInteger('Flags', itU32, wbFlags(['Playable', 'Guard'])),
      wbInteger('Buys/Sells and Services', itU32, wbServiceFlags),
      wbInteger('Teaches', itS8, wbSkillEnum),
      wbInteger('Maximum training level', itU8),
      wbInteger('Unused', itU16)
    ], cpNormal, True, nil, 5)
  ]);

  wbRecord(CLMT, 'Climate', [
    wbEDID,
    wbArrayS(WLST, 'Weather Types', wbStructSK([0], 'Weather Type', [
      wbFormIDCk('Weather', [WTHR]),
      wbInteger('Chance', itS32)
    ])),
    wbString(FNAM, 'Sun Texture'),
    wbString(GNAM, 'Sun Glare Texture'),
    wbMODL,
    wbStruct(TNAM, 'Timing', [
      wbStruct('Sunrise', [
        wbInteger('Begin', itU8, wbClmtTime),
        wbInteger('End', itU8, wbClmtTime)
      ]),
      wbStruct('Sunset', [
        wbInteger('Begin', itU8, wbClmtTime),
        wbInteger('End', itU8, wbClmtTime)
      ]),
      wbInteger('Volatility', itU8),
      wbInteger('Moons / Phase Length', itU8, wbClmtMoonsPhaseLength)
    ], cpNormal, True)
  ]);

  wbRecord(CLOT, 'Clothing', [
    wbEDID,
    wbFULL,
    wbSCRI,
    wbENAM,
    wbInteger(ANAM, 'Enchantment Points', itU16),
    wbStruct(BMDT, '', [
      wbInteger('Biped Flags', itU16, wbFlags([
        {0x00000001} 'Head',
        {0x00000002} 'Hair',
        {0x00000004} 'Upper Body',
        {0x00000008} 'Lower Body',
        {0x00000010} 'Hand',
        {0x00000020} 'Foot',
        {0x00000040} 'Right Ring',
        {0x00000080} 'Left Ring',
        {0x00000100} 'Amulet',
        {0x00000200} 'Weapon',
        {0x00000400} 'Back Weapon',
        {0x00000800} 'Side Weapon',
        {0x00001000} 'Quiver',
        {0x00002000} 'Shield',
        {0x00004000} 'Torch',
        {0x00008000} 'Tail'
      ])),
      wbInteger('General Flags', itU8, wbFlags([
        {0x0001} 'Hide Rings',
        {0x0002} 'Hide Amulets',
        {0x0004} '',
        {0x0008} '',
        {0x0010} '',
        {0x0020} '',
        {0x0040} 'Non-Playable',
        {0x0080} '' {Heavy armor}
      ])),
      wbByteArray('Unused', 1)
    ], cpNormal, True),
    wbMaleBipedModel,
    wbMaleWorldModel,
    wbString(ICON, 'Male icon FileName'),
    wbFemaleBipedModel,
    wbFemaleWorldModel,
    wbString(ICO2, 'Female icon FileName'),
    wbStruct(DATA, '', [
      wbInteger('Value', itU32),
      wbFloat('Weight')
    ], cpNormal, True)
  ]);

  wbCNTO :=
    wbStructSK(CNTO, [0], 'Item', [
      wbFormIDCk('Item', [ARMO, AMMO, MISC, WEAP, INGR, SLGM, SGST, BOOK, LVLI, KEYM, CLOT, ALCH, APPA, LIGH]),
      wbInteger('Count', itS32)
    ]).SetToStr(wbItemToStr).IncludeFlag(dfCollapsed, wbCollapseItems);

  wbCNTOs := wbRArrayS('Items', wbCNTO);

  wbRecord(CONT, 'Container', [
    wbEDID,
    wbFULL,
    wbMODL,
    wbSCRI,
    wbCNTOs,
    wbStruct(DATA, '', [
      wbInteger('Flags', itU8, wbFlags(['', 'Respawns'])),
      wbFloat('Weight')
    ], cpNormal, True),
    wbFormIDCk(SNAM, 'Open sound', [SOUN]),
    wbFormIDCk(QNAM, 'Close sound', [SOUN])
  ]);

  wbCSDT := wbRStructSK([0], 'Sound Type', [
    wbInteger(CSDT, 'Type', itU32,wbEnum([
      {0x00} 'Left Foot',
      {0x01} 'Right Foot',
      {0x02} 'Left Back Foot',
      {0x03} 'Right Back Foot',
      {0x04} 'Idle',
      {0x05} 'Aware',
      {0x06} 'Attack',
      {0x07} 'Hit',
      {0x08} 'Death',
      {0x09} 'Weapon'
    ])),
    wbRArrayS('Sounds', wbRStructSK([0], 'Sound', [
      wbFormIDCk(CSDI, 'Sound', [SOUN, NULL], False, cpNormal, True),
      wbInteger(CSDC, 'Sound Chance', itU8, nil, cpNormal, True)
    ], []), cpNormal, True)
  ], []);

  wbCSDTs := wbRArrayS('Sound Types', wbCSDT);

  wbSoulGemEnum := wbEnum([
    {0} 'None',
    {1} 'Petty',
    {2} 'Lesser',
    {3} 'Common',
    {4} 'Greater',
    {5} 'Grand'
  ]);

  wbFaction :=
    wbStructSK(SNAM, [0], 'Faction', [
      wbFormIDCk('Faction', [FACT]),
      wbInteger('Rank', itU8),
      wbByteArray('Unused', 3)
    ]).SetToStr(wbFactionToStr).IncludeFlag(dfCollapsed, wbCollapseFactions);

  wbRecord(CREA, 'Creature', [
    wbEDID,
    wbFULL,
    wbMODL,
    wbCNTOs,
    wbSPLOs,
    wbArrayS(NIFZ, 'Models', wbStringLC('Model')),
    wbByteArray(NIFT, 'Texture Files Hashes', 0, cpIgnore),
    wbStruct(ACBS, 'Configuration', [
      wbInteger('Flags', itU32, wbFlags([
        {0x000001} 'Biped',
        {0x000002} 'Essential',
        {0x000004} 'Weapon & Shield',
        {0x000008} 'Respawn',
        {0x000010} 'Swims',
        {0x000020} 'Flies',
        {0x000040} 'Walks',
        {0x000080} 'PC Level Offset',
        {0x000100} 'Unused', //??
        {0x000200} 'No Low Level Processing',
        {0x000400} 'Unused', //??
        {0x000800} 'No Blood Spray',
        {0x001000} 'No Blood Decal',
        {0x002000} '',
        {0x004000} '',
        {0x008000} 'No Head',
        {0x010000} 'No Right Arm',
        {0x020000} 'No Left Arm',
        {0x040000} 'No Combat in Water',
        {0x080000} 'No Shadow',
        {0x100000} 'No Corpse Check'
      ])),
      wbInteger('Base spell points', itU16),
      wbInteger('Fatigue', itU16),
      wbInteger('Barter gold', itU16),
      wbInteger('Level (offset)', itS16),
      wbInteger('Calc min', itU16),
      wbInteger('Calc max', itU16)
    ], cpNormal, True),
    wbRArrayS('Factions', wbFaction),
    wbFormIDCk(INAM, 'Death item', [LVLI]),
    wbSCRI,
    wbStruct(AIDT, 'AI Data', [
      wbInteger('Aggression', itU8),
      wbInteger('Confidence', itU8),
      wbInteger('Energy Level', itU8),
      wbInteger('Responsibility', itU8),
      wbInteger('Buys/Sells and Services', itU32, wbServiceFlags),
      wbInteger('Teaches', itS8, wbSkillEnum),
      wbInteger('Maximum training level', itU8),
      wbByteArray('Unused', 2)
    ], cpNormal, True),
    wbRArray('AI Packages', wbFormIDCk(PKID, 'AI Package', [PACK])),
    wbArrayS(KFFZ, 'Animations', wbStringLC('Animation')),
    wbStruct(DATA, 'Creature Data', [
      wbInteger('Type', itU8, wbEnum([
        'Creature',
        'Daedra',
        'Undead',
        'Humanoid',
        'Horse',
        'Giant'
      ])),
      wbInteger('Combat Skill', itU8),
      wbInteger('Magic Skill', itU8),
      wbInteger('Stealth Skill', itU8),
      wbInteger('Soul', itU8, wbSoulGemEnum),
      wbByteArray('Unused', 1),
      wbInteger('Health', itU16),
      wbByteArray('Unused', 2),
      wbInteger('Attack Damage', itU16),
      wbInteger('Strength', itU8),
      wbInteger('Intelligence', itU8),
      wbInteger('Willpower', itU8),
      wbInteger('Agility', itU8),
      wbInteger('Speed', itU8),
      wbInteger('Endurance', itU8),
      wbInteger('Personality', itU8),
      wbInteger('Luck', itU8)
    ], cpNormal, True),
    wbInteger(RNAM, 'Attack reach', itU8, nil, cpNormal, True),
    wbFormIDCk(ZNAM, 'Combat Style', [CSTY]),
    wbFloat(TNAM, 'Turning Speed', cpNormal, True),
    wbFloat(BNAM, 'Base Scale', cpNormal, True),
    wbFloat(WNAM, 'Foot Weight', cpNormal, True),
    wbString(NAM0, 'Blood Spray'),
    wbString(NAM1, 'Blood Decal'),
    wbFormIDCk(CSCR, 'Inherits Sounds from', [CREA]),
    wbCSDTs
  ], True);

  wbRecord(CSTY, 'Combat Style', [
    wbEDID,
    wbStruct(CSTD, 'Standard', [
      {000}wbInteger('Dodge % Chance', itU8),
      {001}wbInteger('Left/Right % Chance', itU8),
      {002}wbByteArray('Unused', 2),
      {004}wbFloat('Dodge L/R Timer (min)'),
      {008}wbFloat('Dodge L/R Timer (max)'),
      {012}wbFloat('Dodge Forward Timer (min)'),
      {016}wbFloat('Dodge Forward Timer (max)'),
      {020}wbFloat('Dodge Back Timer Min'),
      {024}wbFloat('Dodge Back Timer Max'),
      {028}wbFloat('Idle Timer min'),
      {032}wbFloat('Idle Timer max'),
      {036}wbInteger('Block % Chance', itU8),
      {037}wbInteger('Attack % Chance', itU8),
      {038}wbByteArray('Unused', 2),
      {040}wbFloat('Recoil/Stagger Bonus to Attack'),
      {044}wbFloat('Unconscious Bonus to Attack'),
      {048}wbFloat('Hand-To-Hand Bonus to Attack'),
      {052}wbInteger('Power Attack % Chance', itU8),
      {053}wbByteArray('Unused', 3),
      {056}wbFloat('Recoil/Stagger Bonus to Power'),
      {060}wbFloat('Unconscious Bonus to Power Attack'),
      {064}wbInteger('Power Attack - Normal', itU8),
      {065}wbInteger('Power Attack - Forward', itU8),
      {066}wbInteger('Power Attack - Back', itU8),
      {067}wbInteger('Power Attack - Left', itU8),
      {068}wbInteger('Power Attack - Right', itU8),
      {069}wbByteArray('Unused', 3),
      {072}wbFloat('Hold Timer (min)'),
      {076}wbFloat('Hold Timer (max)'),
      {080}wbInteger('Flags 1', itU8, wbFlags([
             'Advanced',
             'Choose Attack using % Chance',
             'Ignore Allies in Area',
             'Will Yield',
             'Rejects Yields',
             'Fleeing Disabled',
             'Prefers Ranged',
             'Melee Alert OK'
           ])),
      {081}wbInteger('Acrobatic Dodge % Chance', itU8),
      {082}wbByteArray('Unused', 2),
      {084}wbFloat('Range Mult (Optimal)'),
      {088}wbFloat('Range Mult (Max)'),
      {092}wbFloat('Switch Distance (Melee)'),
      {096}wbFloat('Switch Distance (Ranged)'),
      {100}wbFloat('Buff standoff Distance'),
      {104}wbFloat('Ranged standoff Distance'),
      {108}wbFloat('Group standoff Distance'),
      {112}wbInteger('Rushing Attack % Chance', itU8),
      {113}wbByteArray('Unused', 3),
      {116}wbFloat('Rushing Attack Distance Mult'),
      {120}wbInteger('Flags 2', itU32, wbFlags([
             'Do Not Acquire'
           ]))
    ], cpNormal, True, nil, 31),
    wbStruct(CSAD, 'Advanced', [
      wbFloat('Dodge Fatigue Mod Mult'),
      wbFloat('Dodge Fatigue Mod Base'),
      wbFloat('Encumb. Speed Mod Base'),
      wbFloat('Encumb. Speed Mod Mult'),
      wbFloat('Dodge While Under Attack Mult'),
      wbFloat('Dodge Not Under Attack Mult'),
      wbFloat('Dodge Back While Under Attack Mult'),
      wbFloat('Dodge Back Not Under Attack Mult'),
      wbFloat('Dodge Forward While Attacking Mult'),
      wbFloat('Dodge Forward Not Attacking Mult'),
      wbFloat('Block Skill Modifier Mult'),
      wbFloat('Block Skill Modifier Base'),
      wbFloat('Block While Under Attack Mult'),
      wbFloat('Block Not Under Attack Mult'),
      wbFloat('Attack Skill Modifier Mult'),
      wbFloat('Attack Skill Modifier Base'),
      wbFloat('Attack While Under Attack Mult'),
      wbFloat('Attack Not Under Attack Mult'),
      wbFloat('Attack During Block Mult'),
      wbFloat('Power Att. Fatigue Mod Base'),
      wbFloat('Power Att. Fatigue Mod Mult')
    ])
  ]);

  wbRecord(DIAL, 'Dialog Topic', [
    wbEDID,
    wbRArrayS('Quests', wbFormIDCkNoReach(QSTI, 'Quest', [QUST], False, cpBenign)),
    wbRArrayS('Quests?', wbFormIDCkNoReach(QSTR, 'Quest?', [QUST], False, cpBenign)),
    wbFULL,
    wbInteger(DATA, 'Type', itU8, wbEnum([
      {0} 'Topic',
      {1} 'Conversation',
      {2} 'Combat',
      {3} 'Persuasion',
      {4} 'Detection',
      {5} 'Service',
      {6} 'Miscellaneous'
    ]), cpNormal, True)
  ], True);

  wbRecord(DOOR, 'Door', [
    wbEDID,
    wbFULL,
    wbMODL,
    wbSCRI,
    wbFormIDCk(SNAM, 'Open sound', [SOUN]),
    wbFormIDCk(ANAM, 'Close sound', [SOUN]),
    wbFormIDCk(BNAM, 'Loop sound', [SOUN]),
    wbInteger(FNAM, 'Flags', itU8, wbFlags([
      {0x01} 'Oblivion gate',
      {0x02} 'Automatic door',
      {0x04} 'Hidden',
      {0x08} 'Minimal use'
    ]), cpNormal, True),
    wbRArrayS('Random teleport destinations', wbFormIDCk(TNAM, 'Destination', [CELL, WRLD]))
  ]);

  wbBlendModeEnum := wbEnum([
    '',
    'Zero',
    'One',
    'Source Color',
    'Source Inverse Color',
    'Source Alpha',
    'Source Inverted Alpha',
    'Dest Alpha',
    'Dest Inverted Alpha',
    'Dest Color',
    'Dest Inverse Color',
    'Source Alpha SAT'
  ]);

  wbBlendOpEnum := wbEnum([
    '',
    'Add',
    'Subtract',
    'Reverse Subtract',
    'Minimum',
    'Maximum'
  ]);
  wbZTestFuncEnum := wbEnum([
    '',
    '',
    '',
    'Equal To',
    'Normal',
    'Greater Than',
    '',
    'Greater Than or Equal Than',
    'Always Show'
  ]);

  wbRecord(EFSH, 'Effect Shader', [
    wbEDID,
    wbString(ICON, 'Fill Texture'),
    wbString(ICO2, 'Particle Shader Texture'),
    wbStruct(DATA, '', [
      wbInteger('Flags', itU8, wbFlags([
        {0} 'No Membrane Shader',
        {1} '',
        {2} '',
        {3} 'No Particle Shader',
        {4} 'Edge Effect - Inverse',
        {5} 'Membrane Shader - Affect Skin Only'
      ])),
      wbByteArray('Unused', 3),
      wbInteger('Membrane Shader - Source Blend Mode', itU32, wbBlendModeEnum),
      wbInteger('Membrane Shader - Blend Operation', itU32, wbBlendOpEnum),
      wbInteger('Membrane Shader - Z Test Function', itU32, wbZTestFuncEnum),
      wbStruct('Fill/Texture Effect - Color', [
        wbInteger('Red', itU8),
        wbInteger('Green', itU8),
        wbInteger('Blue', itU8),
        wbByteArray('Unused', 1)
      ]).SetToStr(wbRGBAToStr).IncludeFlag(dfCollapsed, wbCollapseRGBA),
      wbFloat('Fill/Texture Effect - Alpha Fade In Time'),
      wbFloat('Fill/Texture Effect - Full Alpha Time'),
      wbFloat('Fill/Texture Effect - Alpha Fade Out Time'),
      wbFloat('Fill/Texture Effect - Presistent Alpha Ratio'),
      wbFloat('Fill/Texture Effect - Alpha Pulse Amplitude'),
      wbFloat('Fill/Texture Effect - Alpha Pulse Frequency'),
      wbFloat('Fill/Texture Effect - Texture Animation Speed (U)'),
      wbFloat('Fill/Texture Effect - Texture Animation Speed (V)'),
      wbFloat('Edge Effect - Fall Off'),
      wbStruct('Edge Effect - Color', [
        wbInteger('Red', itU8),
        wbInteger('Green', itU8),
        wbInteger('Blue', itU8),
        wbByteArray('Unused', 1)
      ]).SetToStr(wbRGBAToStr).IncludeFlag(dfCollapsed, wbCollapseRGBA),
      wbFloat('Edge Effect - Alpha Fade In Time'),
      wbFloat('Edge Effect - Full Alpha Time'),
      wbFloat('Edge Effect - Alpha Fade Out Time'),
      wbFloat('Edge Effect - Persistent Alpha Ratio'),
      wbFloat('Edge Effect - Alpha Pulse Amplitude'),
      wbFloat('Edge Effect - Alpha Pusle Frequence'),
      wbFloat('Fill/Texture Effect - Full Alpha Ratio'),
      wbFloat('Edge Effect - Full Alpha Ratio'),
      wbInteger('Membrane Shader - Dest Blend Mode', itU32, wbBlendModeEnum),
      wbInteger('Particle Shader - Source Blend Mode', itU32, wbBlendModeEnum),
      wbInteger('Particle Shader - Blend Operation', itU32, wbBlendOpEnum),
      wbInteger('Particle Shader - Z Test Function', itU32, wbZTestFuncEnum),
      wbInteger('Particle Shader - Dest Blend Mode', itU32, wbBlendModeEnum),
      wbFloat('Particle Shader - Particle Birth Ramp Up Time'),
      wbFloat('Particle Shader - Full Particle Birth Time'),
      wbFloat('Particle Shader - Particle Birth Ramp Down Time'),
      wbFloat('Particle Shader - Full Particle Birth Ratio'),
      wbFloat('Particle Shader - Persistant Particle Birth Ratio'),
      wbFloat('Particle Shader - Particle Lifetime'),
      wbFloat('Particle Shader - Particle Lifetime +/-'),
      wbFloat('Particle Shader - Initial Speed Along Normal'),
      wbFloat('Particle Shader - Acceleration Along Normal'),
      wbFloat('Particle Shader - Initial Velocity #1'),
      wbFloat('Particle Shader - Initial Velocity #2'),
      wbFloat('Particle Shader - Initial Velocity #3'),
      wbFloat('Particle Shader - Acceleration #1'),
      wbFloat('Particle Shader - Acceleration #2'),
      wbFloat('Particle Shader - Acceleration #3'),
      wbFloat('Particle Shader - Scale Key 1'),
      wbFloat('Particle Shader - Scale Key 2'),
      wbFloat('Particle Shader - Scale Key 1 Time'),
      wbFloat('Particle Shader - Scale Key 2 Time'),
      wbStruct('Color Key 1 - Color', [
        wbInteger('Red', itU8),
        wbInteger('Green', itU8),
        wbInteger('Blue', itU8),
        wbByteArray('Unused', 1)
      ]).SetToStr(wbRGBAToStr).IncludeFlag(dfCollapsed, wbCollapseRGBA),
      wbStruct('Color Key 2 - Color', [
        wbInteger('Red', itU8),
        wbInteger('Green', itU8),
        wbInteger('Blue', itU8),
        wbByteArray('Unused', 1)
      ]).SetToStr(wbRGBAToStr).IncludeFlag(dfCollapsed, wbCollapseRGBA),
      wbStruct('Color Key 3 - Color', [
        wbInteger('Red', itU8),
        wbInteger('Green', itU8),
        wbInteger('Blue', itU8),
        wbByteArray('Unused', 1)
      ]).SetToStr(wbRGBAToStr).IncludeFlag(dfCollapsed, wbCollapseRGBA),
      wbFloat('Color Key 1 - Color Alpha'),
      wbFloat('Color Key 2 - Color Alpha'),
      wbFloat('Color Key 3 - Color Alpha'),
      wbFloat('Color Key 1 - Color Key Time'),
      wbFloat('Color Key 2 - Color Key Time'),
      wbFloat('Color Key 3 - Color Key Time')
    ], cpNormal, True, nil, 25)
  ]);

  wbRecord(ENCH, 'Enchantment', [
    wbEDID,
    wbStruct(OBME, 'Oblivion Magic Extender', [
      wbInteger('Record Version', itU8),
      wbStruct('OBME Version', [
        wbInteger('Beta', itU8),
        wbInteger('Minor', itU8),
        wbInteger('Major', itU8)
      ]),
      wbByteArray('Unused', $1C)
    ], cpNormal, False, wbOBMEDontShow),
    wbFULL,
    wbStruct(ENIT, '', [
      wbInteger('Type', itU32, wbEnum([
        {0} 'Scroll',
        {1} 'Staff',
        {2} 'Weapon',
        {3} 'Apparel'
      ])),
      wbInteger('Charge Amount', itU32),
      wbInteger('Enchant Cost', itU32),
      wbInteger('Flags', itU8, wbFlags(['Manual Enchant Cost (Autocalc Off)'])),
      wbByteArray('Unused', 3)
    ], cpNormal, True),
    wbEffects
  ]);

  wbRecord(EYES, 'Eyes', [
    wbEDID,
    wbFULL,
    wbString(ICON, 'Texture', 0, cpNormal, True),
    wbInteger(DATA, 'Flags', itU8, wbFlags(['Playable']), cpNormal, True)
  ]);

  wbXNAM :=
    wbStructSK(XNAM, [0], 'Relation', [
      wbFormIDCkNoReach('Faction', [FACT, RACE]),
      wbInteger('Modifier', itS32)
    ]).SetToStr(wbFactionRelationToStr).IncludeFlag(dfCollapsed, wbCollapseFactionRelations);

  wbXNAMs := wbRArrayS('Relations', wbXNAM);

  wbFactionRank :=
    wbRStructSK([0], 'Rank', [
      wbInteger(RNAM, 'Rank#', itS32),
      wbString(MNAM, 'Male', 0, cpTranslate),
      wbString(FNAM, 'Female', 0, cpTranslate),
      wbString(INAM, 'Insignia')
    ], []);

  wbRecord(FACT, 'Faction', [
    wbEDID,
    wbFULL,
    wbXNAMs,
    wbInteger(DATA, 'Flags', itU8, wbFlags(['Hidden from Player', 'Evil', 'Special Combat']), cpNormal, True),
    wbFloat(CNAM, 'Crime Gold Multiplier', cpNormal, True, 1, -1, nil, nil, 1.0),
    wbRArrayS('Ranks', wbFactionRank)
  ]);

  wbRecord(FLOR, 'Flora', [
    wbEDID,
    wbFULL,
    wbMODL,
    wbSCRI,
    wbFormIDCk(PFIG, 'Ingredient', [INGR]),
    wbStruct(PFPC, 'Seasonal ingredient production', [
      wbInteger('Spring', itU8),
      wbInteger('Summer ', itU8),
      wbInteger('Fall', itU8),
      wbInteger('Winter', itU8)
    ], cpNormal, True)
  ]);

  wbRecord(FURN, 'Furniture', [
    wbEDID,
    wbFULL,
    wbMODL,
    wbSCRI,
    wbByteArray(MNAM, 'Marker Flags', 0, cpNormal, True)
  ]);

  wbRecord(GLOB, 'Global', [
    wbEDID,
    wbInteger(FNAM, 'Type', itU8, wbEnum([], [
      Ord('s'), 'Short',
      Ord('l'), 'Long',
      Ord('f'), 'Float'
    ]), cpNormal, True).SetDefaultEditValue('Float'),
    wbFloat(FLTV, 'Value', cpNormal, True)
  ]).SetSummaryKey([2]);

  wbRecord(GMST, 'Game Setting', [
    wbEDID,
    wbUnion(DATA, 'Value', wbGMSTUnionDecider, [
      wbString('', 0, cpTranslate),
      wbInteger('', itS32),
      wbFloat('')
    ], cpNormal, True)
  ]).SetSummaryKey([1]);

  wbRecord(GRAS, 'Grass', [
    wbEDID,
    wbMODL,
    wbStruct(DATA, '', [
      wbInteger('Density', itU8),
      wbInteger('Min Slope', itU8),
      wbInteger('Max Slope', itU8),
      wbByteArray('Unused', 1),
      wbInteger('Unit from water amount', itU16),
      wbByteArray('Unused', 2),
      wbInteger('Unit from water type', itU32, wbEnum([
        'Above - At Least',
        'Above - At Most',
        'Below - At Least',
        'Below - At Most',
        'Either - At Least',
        'Either - At Most',
        'Either - At Most Above',
        'Either - At Most Below'
      ])),
      wbFloat('Position Range'),
      wbFloat('Height Range'),
      wbFloat('Color Range'),
      wbFloat('Wave Period'),
      wbInteger('Flags', itU8, wbFlags([
        'Vertex Lighting',
        'Uniform Scaling',
        'Fit to Slope'
      ])),
      wbByteArray('Unused', 3)
    ], cpNormal, True)
  ]).SetSummaryKey([1]);

  wbRecord(HAIR, 'Hair', [
    wbEDID,
    wbFULL,
    wbMODL,
    wbString(ICON, 'Texture', 0, cpNormal, True),
    wbInteger(DATA, 'Flags', itU8, wbFlags([
      'Playable',
      'Not Male',
      'Not Female',
      'Fixed'
    ]), cpNormal, True)
  ]);

  wbCrimeTypeEnum :=
    wbEnum([
      'Steal',
      'Pickpocket',
      'Trespass',
      'Attack',
      'Murder',
      'Steal Horse'
    ], [
      -1, 'None'
    ]);

  wbFormTypeEnum :=
    wbEnum([], [
      $03, 'Game Setting',
      $04, 'Global',
      $05, 'Class',
      $06, 'Faction',
      $07, 'Hair',
      $08, 'Eyes',
      $09, 'Race',
      $0A, 'Sound',
      $0B, 'Skill',
      $0C, 'Magic Effect',
      $0D, 'Script',
      $0E, 'Land Texture',
      $0F, 'Enchantment',
      $10, 'Spell',
      $11, 'BirthSign',
      $12, 'Activator',
      $13, 'Apparatus',
      $14, 'Armor',
      $15, 'Book',
      $16, 'Clothing',
      $17, 'Container',
      $18, 'Door',
      $19, 'Ingredient',
      $1A, 'Light',
      $1B, 'Misc',
      $1C, 'Static',
      $1D, 'Grass',
      $1E, 'Tree',
      $1F, 'Flora',
      $20, 'Furniture',
      $21, 'Weapon',
      $22, 'Ammi',
      $23, 'NPC',
      $24, 'Creature',
      $25, 'Leveled Creature',
      $26, 'Soul Gem',
      $27, 'Key',
      $28, 'Alchemy',
      $29, 'SubSpace',
      $2A, 'Sigil Stone',
      $2B, 'Leveled Item',
      $2D, 'Weather',
      $2E, 'Climate',
      $2F, 'Region',
      $30, 'Cell',
      $31, 'Placed Object',
      $32, 'Placed NPC',
      $33, 'Placed Creature',
      $34, 'Path Grid',
      $35, 'Worldspace',
      $36, 'Landscape',
      $38, 'Road',
      $39, 'Dialog Topic',
      $3A, 'Dialog Response',
      $3B, 'Quest',
      $3C, 'Idle Animation',
      $3D, 'Package',
      $3E, 'Combat Style',
      $3F, 'Load Screen',
      $40, 'Leveled Spell',
      $41, 'Animated Object',
      $42, 'Water',
      $43, 'Effect Shader'
  ]);

  wbSexEnum :=
    wbEnum(['Male','Female']);

  wbAxisEnum :=
    wbEnum([], [
      88, 'X',
      89, 'Y',
      90, 'Z'
    ]);

  wbCTDA :=
    wbRUnion('Condition', [
      wbStructSK(CTDA, [3, 4], 'Condition', [
     {0}wbInteger('Type', itU8, wbCtdaType),
     {1}wbByteArray('Unused', 3),
     {2}wbUnion('Comparison Value', wbCTDACompValueDecider, [
          wbFloat('Comparison Value - Float'),
          wbFormIDCk('Comparison Value - Global', [GLOB])
        ]),
     {3}wbInteger('Function', itU16, wbCTDAFunctionToStr, wbCTDAFunctionToInt),   // Limited to itu16
     {4}wbByteArray('Unused', 2, cpIgnore, False, wbNeverShow),
     {5}wbUnion('Parameter #1', wbCTDAParam1Decider, [
          {00} wbByteArray('Unknown', 4),
          {01} wbByteArray('None', 4, cpIgnore).IncludeFlag(dfZeroSortKey),
          {02} wbInteger('Integer', itS32),
          {03} wbInteger('Variable Name (INVALID)', itS32).IncludeFlag(dfZeroSortKey),
          {04} wbInteger('Sex', itU32, wbSexEnum),
          {05} wbFormIDCk('Actor Value', [ACVA]),
//          {05} wbInteger('Actor Value', itS32, wbActorValueEnum),
          {06} wbInteger('Crime Type', itU32, wbCrimeTypeEnum),
          {07} wbInteger('Axis', itU32, wbAxisEnum),
          {08} wbInteger('Form Type', itU32, wbFormTypeEnum),
          {09} wbInteger('Quest Stage (INVALID)', itS32).IncludeFlag(dfZeroSortKey),
          {10} wbFormIDCkNoReach('Object Reference', [PLYR, REFR, ACHR, ACRE, TRGT]),
          {12} wbFormIDCkNoReach('Inventory Object', [ARMO, AMMO, MISC, WEAP, INGR, SLGM, SGST, BOOK, KEYM, CLOT, ALCH, APPA, LIGH]),
          {13} wbFormIDCkNoReach('Actor', [PLYR, ACHR, ACRE, TRGT]),
          {14} wbFormIDCkNoReach('Quest', [QUST]),
          {15} wbFormIDCkNoReach('Faction', [FACT]),
          {16} wbFormIDCkNoReach('Cell', [CELL]),
          {17} wbFormIDCkNoReach('Class', [CLAS]),
          {18} wbFormIDCkNoReach('Race', [RACE]),
          {19} wbFormIDCkNoReach('Actor Base', [NPC_, CREA, ACTI]),
          {20} wbFormIDCkNoReach('Global', [GLOB]),
          {21} wbFormIDCkNoReach('Weather', [WTHR]),
          {22} wbFormIDCkNoReach('Package', [PACK]),
          {23} wbFormIDCkNoReach('Owner', [FACT, NPC_]),
          {24} wbFormIDCkNoReach('Birthsign', [BSGN]),
          {25} wbFormIDCkNoReach('Furniture', [FURN]),
          {26} wbFormIDCkNoReach('Magic Item', [SPEL]),
          {27} wbFormIDCkNoReach('Magic Effect', [MGEF]),
          {28} wbFormIDCkNoReach('Worldspace', [WRLD]),
          {29} wbFormIDCkNoReach('Referenceable Object', [CREA, NPC_, TREE, SBSP, LVLC, SOUN, ACTI, DOOR, FLOR, STAT, FURN, CONT, ARMO, AMMO, MISC, WEAP, INGR, SLGM, SGST, BOOK, KEYM, CLOT, ALCH, APPA, LIGH, GRAS])
        ]),
     {6}wbUnion('Parameter #2', wbCTDAParam2Decider, [
          {00} wbByteArray('Unknown', 4),
          {01} wbByteArray('None', 4, cpIgnore).IncludeFlag(dfZeroSortKey),
          {02} wbInteger('Integer', itS32),
          {03} wbInteger('Variable Name', itS32, wbCTDAParam2VariableNameToStr, wbCTDAParam2VariableNameToInt),
          {04} wbInteger('Sex', itU32, wbSexEnum),
          {05} wbFormIDCk('Actor Value', [ACVA]),
//          {05} wbInteger('Actor Value', itS32, wbActorValueEnum),
          {06} wbInteger('Crime Type', itU32, wbCrimeTypeEnum),
          {07} wbInteger('Axis', itU32, wbAxisEnum),
          {08} wbInteger('Form Type', itU32, wbFormTypeEnum),
          {09} wbInteger('Quest Stage', itS32, wbCTDAParam2QuestStageToStr, wbCTDAParam2QuestStageToInt),
          {10} wbFormIDCkNoReach('Object Reference', [PLYR, REFR, ACHR, ACRE, TRGT]),
          {12} wbFormIDCkNoReach('Inventory Object', [ARMO, AMMO, MISC, WEAP, INGR, SLGM, SGST, BOOK, KEYM, CLOT, ALCH, APPA, LIGH]),
          {13} wbFormIDCkNoReach('Actor', [PLYR, ACHR, ACRE, TRGT]),
          {14} wbFormIDCkNoReach('Quest', [QUST]),
          {15} wbFormIDCkNoReach('Faction', [FACT]),
          {16} wbFormIDCkNoReach('Cell', [CELL]),
          {17} wbFormIDCkNoReach('Class', [CLAS]),
          {18} wbFormIDCkNoReach('Race', [RACE]),
          {19} wbFormIDCkNoReach('Actor Base', [NPC_, CREA, ACTI]),
          {20} wbFormIDCkNoReach('Global', [GLOB]),
          {21} wbFormIDCkNoReach('Weather', [WTHR]),
          {22} wbFormIDCkNoReach('Package', [PACK]),
          {23} wbFormIDCkNoReach('Owner', [FACT, NPC_]),
          {24} wbFormIDCkNoReach('Birthsign', [BSGN]),
          {25} wbFormIDCkNoReach('Furniture', [FURN]),
          {26} wbFormIDCkNoReach('Magic Item', [SPEL]),
          {27} wbFormIDCkNoReach('Magic Effect', [MGEF]),
          {28} wbFormIDCkNoReach('Worldspace', [WRLD]),
          {29} wbFormIDCkNoReach('Referenceable Object', [CREA, NPC_, TREE, SBSP, LVLC, SOUN, ACTI, DOOR, FLOR, STAT, FURN, CONT, ARMO, AMMO, MISC, WEAP, INGR, SLGM, SGST, BOOK, KEYM, CLOT, ALCH, APPA, LIGH, GRAS])
        ]),
     {7}wbInteger('Unused', itU32, nil, cpIgnore)
      ], cpNormal, False, nil, 7).SetToStr(wbConditionToStr).IncludeFlag(dfCollapsed, wbCollapseConditions),

      wbStructSK(CTDT, [3, 4], 'Condition (old format)', [
     {0}wbInteger('Type', itU8, wbCtdaType),
     {1}wbByteArray('Unused', 3),
     {2}wbUnion('Comparison Value', wbCTDACompValueDecider, [
          wbFloat('Comparison Value - Float'),
          wbFormIDCk('Comparison Value - Global', [GLOB])
        ]),
     {3}wbInteger('Function', itU16, wbCTDAFunctionToStr, wbCTDAFunctionToInt),   // Limited to itu16
     {4}wbByteArray('Unused', 2, cpIgnore, False, wbNeverShow),
     {5}wbUnion('Parameter #1', wbCTDAParam1Decider, [
          {00} wbByteArray('Unknown', 4),
          {01} wbByteArray('None', 4, cpIgnore),
          {02} wbInteger('Integer', itS32),
          {03} wbInteger('Variable Name (INVALID)', itS32),
          {04} wbInteger('Sex', itU32, wbSexEnum),
          {05} wbFormIDCk('Actor Value', [ACVA]),
//          {05} wbInteger('Actor Value', itS32, wbActorValueEnum),
          {06} wbInteger('Crime Type', itU32, wbCrimeTypeEnum),
          {07} wbInteger('Axis', itU32, wbAxisEnum),
          {08} wbInteger('Form Type', itU32, wbFormTypeEnum),
          {09} wbInteger('Quest Stage (INVALID)', itS32),
          {10} wbFormIDCkNoReach('Object Reference', [PLYR, REFR, ACHR, ACRE, TRGT]),
          {12} wbFormIDCkNoReach('Inventory Object', [ARMO, AMMO, MISC, WEAP, INGR, SLGM, SGST, BOOK, KEYM, CLOT, ALCH, APPA, LIGH]),
          {13} wbFormIDCkNoReach('Actor', [PLYR, ACHR, ACRE, TRGT]),
          {14} wbFormIDCkNoReach('Quest', [QUST]),
          {15} wbFormIDCkNoReach('Faction', [FACT]),
          {16} wbFormIDCkNoReach('Cell', [CELL]),
          {17} wbFormIDCkNoReach('Class', [CLAS]),
          {18} wbFormIDCkNoReach('Race', [RACE]),
          {19} wbFormIDCkNoReach('Actor Base', [NPC_, CREA, ACTI]),
          {20} wbFormIDCkNoReach('Global', [GLOB]),
          {21} wbFormIDCkNoReach('Weather', [WTHR]),
          {22} wbFormIDCkNoReach('Package', [PACK]),
          {23} wbFormIDCkNoReach('Owner', [FACT, NPC_]),
          {24} wbFormIDCkNoReach('Birthsign', [BSGN]),
          {25} wbFormIDCkNoReach('Furniture', [FURN]),
          {26} wbFormIDCkNoReach('Magic Item', [SPEL]),
          {27} wbFormIDCkNoReach('Magic Effect', [MGEF]),
          {28} wbFormIDCkNoReach('Worldspace', [WRLD]),
          {29} wbFormIDCkNoReach('Referenceable Object', [CREA, NPC_, TREE, SBSP, LVLC, SOUN, ACTI, DOOR, FLOR, STAT, FURN, CONT, ARMO, AMMO, MISC, WEAP, INGR, SLGM, SGST, BOOK, KEYM, CLOT, ALCH, APPA, LIGH, GRAS])
        ]),
     {6}wbUnion('Parameter #2', wbCTDAParam2Decider, [
          {00} wbByteArray('Unknown', 4),
          {01} wbByteArray('None', 4, cpIgnore),
          {02} wbInteger('Integer', itS32),
          {03} wbInteger('Variable Name', itS32, wbCTDAParam2VariableNameToStr, wbCTDAParam2VariableNameToInt),
          {04} wbInteger('Sex', itU32, wbSexEnum),
          {05} wbFormIDCk('Actor Value', [ACVA]),
//          {05} wbInteger('Actor Value', itS32, wbActorValueEnum),
          {06} wbInteger('Crime Type', itU32, wbCrimeTypeEnum),
          {07} wbInteger('Axis', itU32, wbAxisEnum),
          {08} wbInteger('Form Type', itU32, wbFormTypeEnum),
          {09} wbInteger('Quest Stage', itS32, wbCTDAParam2QuestStageToStr, wbCTDAParam2QuestStageToInt),
          {10} wbFormIDCkNoReach('Object Reference', [PLYR, REFR, ACHR, ACRE, TRGT]),
          {12} wbFormIDCkNoReach('Inventory Object', [ARMO, AMMO, MISC, WEAP, INGR, SLGM, SGST, BOOK, KEYM, CLOT, ALCH, APPA, LIGH]),
          {13} wbFormIDCkNoReach('Actor', [PLYR, ACHR, ACRE, TRGT]),
          {14} wbFormIDCkNoReach('Quest', [QUST]),
          {15} wbFormIDCkNoReach('Faction', [FACT]),
          {16} wbFormIDCkNoReach('Cell', [CELL]),
          {17} wbFormIDCkNoReach('Class', [CLAS]),
          {18} wbFormIDCkNoReach('Race', [RACE]),
          {19} wbFormIDCkNoReach('Actor Base', [NPC_, CREA, ACTI]),
          {20} wbFormIDCkNoReach('Global', [GLOB]),
          {21} wbFormIDCkNoReach('Weather', [WTHR]),
          {22} wbFormIDCkNoReach('Package', [PACK]),
          {23} wbFormIDCkNoReach('Owner', [FACT, NPC_]),
          {24} wbFormIDCkNoReach('Birthsign', [BSGN]),
          {25} wbFormIDCkNoReach('Furniture', [FURN]),
          {26} wbFormIDCkNoReach('Magic Item', [SPEL]),
          {27} wbFormIDCkNoReach('Magic Effect', [MGEF]),
          {28} wbFormIDCkNoReach('Worldspace', [WRLD]),
          {29} wbFormIDCkNoReach('Referenceable Object', [CREA, NPC_, TREE, SBSP, LVLC, SOUN, ACTI, DOOR, FLOR, STAT, FURN, CONT, ARMO, AMMO, MISC, WEAP, INGR, SLGM, SGST, BOOK, KEYM, CLOT, ALCH, APPA, LIGH, GRAS])
        ]),
     {7}wbEmpty('Unused', cpIgnore)
      ])
    ], []);

  wbCTDAs := wbRArray('Conditions', wbCTDA);

  wbSCHR :=
    wbRUnion('Basic Script Data', [
      wbStruct(SCHR, 'Basic Script Data', [
        wbByteArray('Unused', 4),
        wbInteger('RefCount', itU32),
        wbInteger('CompiledSize', itU32),
        wbInteger('VariableCount', itU32),
        wbInteger('Type', itU32, wbEnum([
          'Object',
          'Quest'
        ], [
          $100, 'Magic Effect'
        ]))
      ]),
      wbStruct(SCHD, 'Basic Script Data', [
        wbByteArray('Unused', 4),
        wbInteger('RefCount', itU32),
        wbInteger('CompiledSize', itU32),
        wbInteger('VariableCount', itU32),
        wbInteger('Type', itU32, wbEnum([
          'Object',
          'Quest'
        ], [
          $100, 'Magic Effect'
        ])),
        wbByteArray('Unknown')
      ])
    ], []);

  wbSCROs :=
    wbRArray('References',
      wbRUnion('', [
        wbFormID(SCRO, 'Global Reference'),
//        wbFormIDCk(SCRO, 'Global Reference',
//          [ACTI, DOOR, FLOR, STAT, FURN, CREA, SPEL, NPC_, CONT, ARMO, AMMO, MISC, WEAP,
//           INGR, SLGM, SGST, BOOK, KEYM, CLOT, ALCH, APPA, LIGH, QUST, PLYR, PACK, LVLI,
//           FACT, ACHR, REFR, ACRE, GLOB, DIAL, CELL, SOUN, MGEF, WTHR, CLAS, EFSH, RACE,
//           LVLC, CSTY, WATR, WRLD, SCPT, BSGN, TREE, ENCH, NULL]),
        wbInteger(SCRV, 'Local Variable', itU32)
      ], [])
    ).IncludeFlag(dfNotAlignable);

  wbResultScript := wbRStruct('Result Script', [
    wbSCHR,
    wbByteArray(SCDA, 'Compiled result script'),
    wbStringScript(SCTX, 'Result script source'),
    wbSCROs
  ], []).SetToStr(wbScriptToStr);

  wbRecord(IDLE, 'Idle Animation', [
    wbEDID,
    wbMODL,
    wbCTDAs,
    wbInteger(ANAM, 'Animation Group Section', itU8, wbIdleAnam, nil, cpNormal, True),
    wbArray(DATA, 'Related Idle Animations', wbFormIDCk('Related Idle Animation', [IDLE, NULL]), ['Parent', 'Previous Sibling'], cpNormal, True)
  ]).SetSummaryKey([1]);

  wbRecord(INFO, 'Dialog response', [
    wbStruct(DATA, '', [
      wbInteger('Type', itU8, wbEnum([], [
        0, 'Topic',
        1, 'Conversation',
        2, 'Combat',
        3, 'Persuasion',
        4, 'Detection',
        5, 'Service',
        6, 'Miscellaneous'
      ])),
      wbInteger('Next Speaker', itU8, wbEnum([
        {0} 'Target',
        {1} 'Self',
        {2} 'Either'
      ])),
      wbInteger('Flags', itU8, wbFlags([
        {0x0001} 'Goodbye',
        {0x0002} 'Random',
        {0x0004} 'Say Once',
        {0x0008} 'Run Immediately',
        {0x0010} 'Info Refusal',
        {0x0020} 'Random End',
        {0x0040} 'Run for Rumors'
      ]))
    ], cpNormal, True),
    wbFormIDCkNoReach(QSTI, 'Quest', [QUST], False, cpNormal, True),
    wbFormIDCk(TPIC, 'Topic', [DIAL]),
    wbFormIDCkNoReach(PNAM, 'Previous INFO', [INFO, NULL]),
    wbRArray('Add topics', wbFormIDCk(NAME, 'Topic', [DIAL])),
    wbRArray('Responses',
      wbRStruct('Response', [
        wbStruct(TRDT, 'Response Data', [
          wbInteger('Emotion Type', itU32, wbEnum([
            {0} 'Neutral',
            {1} 'Anger',
            {2} 'Disgust',
            {3} 'Fear',
            {4} 'Sad',
            {5} 'Happy',
            {6} 'Surprise'
          ])),
          wbInteger('Emotion Value', itS32),
          wbByteArray('Unused', 4),
          wbInteger('Response number', itU8),
          wbByteArray('Unused', 3)
        ]),
        wbStringKC(NAM1, 'Response Text', 0, cpTranslate),
        wbString(NAM2, 'Actor notes', 0, cpTranslate)
      ], [])
    ),
    wbCTDAs,
    wbRArray('Choices', wbFormIDCk(TCLT, 'Choice', [DIAL])),
    wbRArray('Link From', wbFormIDCk(TCLF, 'Topic', [DIAL])),
    wbResultScript
  ]);

  wbRecord(INGR, 'Ingredient', [
    wbEDID,
    wbStruct(OBME, 'Oblivion Magic Extender', [
      wbInteger('Record Version', itU8),
      wbStruct('OBME Version', [
        wbInteger('Beta', itU8),
        wbInteger('Minor', itU8),
        wbInteger('Major', itU8)
      ]),
      wbByteArray('Unused', $1C)
    ], cpNormal, False, wbOBMEDontShow),
    wbFULL,
    wbMODL,
    wbICON,
    wbSCRI,
    wbFloat(DATA, 'Weight', cpNormal, True),
    wbStruct(ENIT, '', [
      wbInteger('Value', itS32),
      wbInteger('Flags', itU8, wbFlags(['No auto-calculation', 'Food item'])),
      wbByteArray('Unused', 3)
    ], cpNormal, True),
    wbEffects
  ]);

  wbRecord(KEYM, 'Key', [
    wbEDID,
    wbFULL,
    wbMODL,
    wbICON,
    wbSCRI,
    wbStruct(DATA, '', [
      wbInteger('Value', itS32),
      wbFloat('Weight')
    ], cpNormal, True)
  ]);

  wbQuadrantEnum := wbEnum([
    {0} 'Bottom Left',
    {1} 'Bottom Right',
    {2} 'Top Left',
    {3} 'Top Right'
  ]);

  if wbSimpleRecords then begin

    wbRecord(LAND, 'Landscape', [
      wbByteArray(DATA, 'Unknown'),
      wbByteArray(VNML, 'Vertex Normals'),
      wbByteArray(VHGT, 'Vertex Height Map'),
      wbByteArray(VCLR, 'Vertex Colours'),

      wbRArrayS('Layers', wbRUnion('Layer', [
        wbRStructSK([0],'Base Layer', [
          wbStructSK(BTXT, [1, 3], 'Base Layer Header', [
            wbFormIDCk('Texture', [LTEX, NULL]),
            wbInteger('Quadrant', itU8, wbQuadrantEnum),
            wbByteArray('Unused', 1),
            wbInteger('Layer', itS16)
          ])
        ], []),
        wbRStructSK([0],'Alpha Layer', [
          wbStructSK(ATXT, [1, 3], 'Alpha Layer Header', [
            wbFormIDCk('Texture', [LTEX, NULL]),
            wbInteger('Quadrant', itU8, wbQuadrantEnum),
            wbByteArray('Unused', 1),
            wbInteger('Layer', itS16)
          ]),
          wbByteArray(VTXT, 'Alpha Layer Data')
        ], [])
      ], [])),

      wbArray(VTEX, 'Textures', wbFormIDCk('Texture', [LTEX, NULL]))
    ]);

  end else begin

    wbRecord(LAND, 'Landscape', [
      wbByteArray(DATA, 'Unknown'),
//      wbStruct(DATA, '', [
//        wbInteger('Flags', itU8, wbFlags([])),
//        wbByteArray('Unknown')
//      ]),
      wbArray(VNML, 'Vertex Normals', wbStruct('Row', [
        wbArray('Columns', wbStruct('Column', [
          wbInteger('X', itU8),
          wbInteger('Y', itU8),
          wbInteger('Z', itU8)
        ]).SetToStr(wbVec3ToStr).IncludeFlag(dfCollapsed, wbCollapseVec3), 33)
      ]), 33),
      wbStruct(VHGT, 'Vertex Height Map', [
        wbFloat('Offset'),
        wbArray('Rows', wbStruct('Row', [
          wbArray('Columns', wbInteger('Column', itU8), 33)
        ]), 33),
        wbByteArray('Unused', 3)
      ]),
      wbArray(VCLR, 'Vertex Colours', wbStruct('Row', [
        wbArray('Columns', wbStruct('Column', [
          wbInteger('X', itU8),
          wbInteger('Y', itU8),
          wbInteger('Z', itU8)
        ]).SetToStr(wbVec3ToStr).IncludeFlag(dfCollapsed, wbCollapseVec3), 33)
      ]), 33),

      wbRArrayS('Layers', wbRUnion('Layer', [
        wbRStructSK([0],'Base Layer', [
          wbStructSK(BTXT, [1, 3], 'Base Layer Header', [
            wbFormIDCk('Texture', [LTEX, NULL]),
            wbInteger('Quadrant', itU8, wbQuadrantEnum),
            wbByteArray('Unused', 1),
            wbInteger('Layer', itS16)
          ])
        ], []),
        wbRStructSK([0],'Alpha Layer', [
          wbStructSK(ATXT, [1, 3], 'Alpha Layer Header', [
            wbFormIDCk('Texture', [LTEX, NULL]),
            wbInteger('Quadrant', itU8, wbQuadrantEnum),
            wbByteArray('Unused', 1),
            wbInteger('Layer', itS16)
          ]),
          wbArrayS(VTXT, 'Alpha Layer Data', wbStructSK([0], 'Cell', [
            wbInteger('Position', itU16, wbAtxtPosition),
            wbByteArray('Unused', 2),
            wbFloat('Opacity')
          ]))
        ], [])
      ], [])),

      wbArray(VTEX, 'Textures', wbFormIDCk('Texture', [LTEX, NULL]))
    ]);

  end;

  wbRecord(LIGH, 'Light', [
    wbEDID,
    wbMODL,
    wbSCRI,
    wbFULL,
    wbICON,
    wbStruct(DATA, '', [
      wbInteger('Time', itS32),
      wbInteger('Radius', itU32),
      wbStruct('Color', [
        wbInteger('Red', itU8),
        wbInteger('Green', itU8),
        wbInteger('Blue', itU8),
        wbInteger('Unused', itU8)
      ]).SetToStr(wbRGBAToStr).IncludeFlag(dfCollapsed, wbCollapseRGBA),
      wbInteger('Flags', itU32, wbFlags([
        {0x00000001} 'Dynamic',
        {0x00000002} 'Can be Carried',
        {0x00000004} 'Negative',
        {0x00000008} 'Flicker',
        {0x00000010} 'Unused',
        {0x00000020} 'Off By Default',
        {0x00000040} 'Flicker Slow',
        {0x00000080} 'Pulse',
        {0x00000100} 'Pulse Slow',
        {0x00000200} 'Spot Light',
        {0x00000400} 'Spot Shadow'
      ])),
      wbFloat('Falloff Exponent'),
      wbFloat('FOV'),
      wbInteger('Value', itU32),
      wbFloat('Weight')
    ], cpNormal, True, nil, 6),
    wbFloat(FNAM, 'Fade value', cpNormal, True, 1, -1, nil, nil, 1.0),
    wbFormIDCk(SNAM, 'Sound', [SOUN])
  ], False, nil, cpNormal, False, wbLIGHAfterLoad);

  wbRecord(LSCR, 'Load Screen', [
    wbEDID,
    wbICON,
    wbDESC,
    wbRArrayS('Locations', wbStructSK(LNAM, [0, 1], 'Location', [
      wbFormIDCkNoReach('Direct', [CELL, WRLD, NULL]),
      wbStructSK([0, 1], 'Indirect', [
        wbFormIDCkNoReach('World', [NULL, WRLD]),
        wbStructSK([0,1], 'Grid', [
          wbInteger('Y', itS16),
          wbInteger('X', itS16)
        ])
      ])
    ]))
  ]).SetSummaryKey([2]);

  wbRecord(LTEX, 'Landscape Texture', [
    wbEDID,
    wbICON,
    wbStruct(HNAM, 'Havok Data', [
      wbInteger('Material Type', itU8, wbEnum([
        {00} 'STONE',
        {01} 'CLOTH',
        {02} 'DIRT',
        {03} 'GLASS',
        {04} 'GRASS',
        {05} 'METAL',
        {06} 'ORGANIC',
        {07} 'SKIN',
        {08} 'WATER',
        {09} 'WOOD',
        {10} 'HEAVY STONE',
        {11} 'HEAVY METAL',
        {12} 'HEAVY WOOD',
        {13} 'CHAIN',
        {14} 'SNOW'
      ]), cpNormal, True, nil, nil, 2),
      wbInteger('Friction', itU8, nil, cpNormal, True, nil, nil, 30),
      wbInteger('Restitution', itU8, nil, cpNormal, True, nil, nil, 30)
    ], cpNormal, True),
    wbInteger(SNAM, 'Texture Specular Exponent', itU8, nil, cpNormal, True, False, nil, nil, 30),
    wbRArrayS('Grasses', wbFormIDCk(GNAM, 'Grass', [GRAS]))
  ]).SetSummaryKey([1]);

  wbLeveledListEntryCreature :=
    wbStructExSK(LVLO, [0, 2], [3], 'Leveled List Entry', [
      wbInteger('Level', itS16),
      wbByteArray('Unused', 2),
      wbFormIDCk('Reference', [NPC_, CREA, LVLC]),
      wbInteger('Count', itS16),
      wbByteArray('Unused', 2)
    ], cpNormal, False, nil, 3).SetToStr(wbLeveledListEntryToStr).IncludeFlag(dfCollapsed, wbCollapseLeveledItems);

  wbLeveledListEntryItem :=
    wbStructExSK(LVLO, [0, 2], [3], 'Leveled List Entry', [
      wbInteger('Level', itS16),
      wbByteArray('Unused', 2),
      wbFormIDCk('Reference', [ARMO, AMMO, MISC, WEAP, INGR, SLGM, SGST, BOOK, LVLI, KEYM, CLOT, ALCH, APPA, LIGH]),
      wbInteger('Count', itS16),
      wbByteArray('Unused', 2)
    ], cpNormal, False, nil, 3).SetToStr(wbLeveledListEntryToStr).IncludeFlag(dfCollapsed, wbCollapseLeveledItems);

  wbLeveledListEntrySpell :=
    wbStructExSK(LVLO, [0, 2], [3], 'Leveled List Entry', [
      wbInteger('Level', itS16),
      wbByteArray('Unused', 2),
      wbFormIDCk('Reference', [SPEL, LVSP]),
      wbInteger('Count', itS16),
      wbByteArray('Unused', 2)
    ], cpNormal, False, nil, 3).SetToStr(wbLeveledListEntryToStr).IncludeFlag(dfCollapsed, wbCollapseLeveledItems);

  wbRecord(LVLC, 'Leveled Creature', [
    wbEDID,
    wbInteger(LVLD, 'Chance none', itU8, nil, cpNormal, True),
    wbInteger(LVLF, 'Flags', itU8, wbFlags([
      {0x01} 'Calculate from all levels <= player''s level',
      {0x02} 'Calculate for each item in count'
    ]), cpNormal, True),
    wbRArrayS('Leveled List Entries', wbLeveledListEntryCreature, cpNormal, True),
    wbSCRI,
    wbFormIDCk(TNAM, 'Creature template', [NPC_, CREA])
  ], True, nil, cpNormal, False, wbLVLAfterLoad).SetSummaryKey([3]);

  wbRecord(LVLI, 'Leveled Item', [
    wbEDID,
    wbInteger(LVLD, 'Chance none', itU8, nil, cpNormal, True),
    wbInteger(LVLF, 'Flags', itU8, wbFlags([
      {0x01} 'Calculate from all levels <= player''s level',
      {0x02} 'Calculate for each item in count'
    ]), cpNormal, True),
    wbRArrayS('Leveled List Entries', wbLeveledListEntryItem, cpNormal, True),
    wbByteArray(DATA, 'Unused', 1)
  ], False, nil, cpNormal, False, wbLVLAfterLoad).SetSummaryKey([3]);

  wbRecord(LVSP, 'Leveled Spell', [
    wbEDID,
    wbInteger(LVLD, 'Chance none', itU8, nil, cpNormal, True),
    wbInteger(LVLF, 'Flags', itU8, wbFlags([
      {0x01} 'Calculate from all levels <= player''s level',
      {0x02} 'Calculate for each item in count',
      {0x04} 'Use all spells'
    ]), cpNormal, True),
    wbRArrayS('Leveled List Entries', wbLeveledListEntrySpell, cpNormal, True)
  ], False, nil, cpNormal, False, wbLVLAfterLoad).SetSummaryKey([3]);

  wbRecord(MGEF, 'Magic Effect', [
    wbStringMgefCode(EDID, 'Magic Effect Code'),
    wbStruct(OBME, 'Oblivion Magic Extender', [
      wbInteger('Record Version', itU8),
      wbStruct('OBME Version', [
        wbInteger('Beta', itU8),
        wbInteger('Minor', itU8),
        wbInteger('Major', itU8)
      ]),
      wbInteger('Param A Info', itU8, wbOBMEResolutionInfo),
      wbInteger('Param B Info', itU8, wbOBMEResolutionInfo),
      wbByteArray('Unused', 2),
      wbString('Handler', 4),
      wbInteger('Flag Overrides', itU32, wbFlags([
        { 0} '',
        { 1} '',
        { 2} 'ParamFlagA',
        { 3} 'Beneficial',
        { 4} '',
        { 5} '',
        { 6} '',
        { 7} '',
        { 8} '',
        { 9} '',
        {10} '',
        {11} '',
        {12} '',
        {13} '',
        {14} '',
        {15} '',
        {16} 'ParamFlagB',
        {17} 'Magnitude Is Range',
        {18} 'Atomic Resistance',
        {19} 'ParamFlagC',
        {20} 'ParamFlagD',
        {21} '',
        {22} '',
        {23} '',
        {24} '',
        {25} '',
        {26} '',
        {27} '',
        {28} '',
        {29} '',
        {30} 'Hidden'
      ])),
      wbByteArray('ParamB', 4),
      wbByteArray('Unused', $1C)
    ], cpNormal, False, wbOBMEDontShow),
    wbString(EDDX, 'EditorID', 0, cpNormal, False, wbEDDXDontShow),
    wbFULL,
    wbDESC,
    wbICON,
    wbMODL,
    wbStruct(DATA, 'Data', [
      wbInteger('Flags', itU32, wbFlags([
        {0x00000001} 'Hostile',
        {0x00000002} 'Recover',
        {0x00000004} 'Detrimental',
        {0x00000008} 'Magnitude %',
        {0x00000010} 'Self',
        {0x00000020} 'Touch',
        {0x00000040} 'Target',
        {0x00000080} 'No duration',
        {0x00000100} 'No magnitude',
        {0x00000200} 'No area',
        {0x00000400} 'FX persist',
        {0x00000800} 'Spellmaking',
        {0x00001000} 'Enchanting',
        {0x00002000} 'No Ingredient',
        {0x00004000} 'Unknown 14',
        {0x00008000} 'Unknown 15',
        {0x00010000} 'Use weapon',
        {0x00020000} 'Use armor',
        {0x00040000} 'Use creature',
        {0x00080000} 'Use skill',
        {0x00100000} 'Use attribute',
        {0x00200000} 'Unknown 21',
        {0x00400000} 'Unknown 22',
        {0x00800000} 'Unknown 23',
        {0x01000000} 'Use actor value',
        {0x02000000} 'Spray projectile type (or Fog if Bolt is specified as well)',
        {0x04000000} 'Bolt projectile type',
        {0x08000000} 'No hit effect',
        {0x10000000} 'Unknown 28',
        {0x20000000} 'Unknown 29',
        {0x40000000} 'Unknown 30',
        {0x80000000} 'Unknown 31'
      ])),
      wbFloat('Base cost'),
      wbUnion('Assoc. Item', wbMGEFFAssocItemDecider, [
        wbFormIDCk('Unused', [NULL]),
        wbFormIDCk('Assoc. Weapon', [WEAP]),
        wbFormIDCk('Assoc. Armor', [ARMO, NULL{?}]),
        wbFormIDCk('Assoc. Creature', [CREA, LVLC, NPC_]),
        wbInteger('Assoc. Actor Value', itS32, wbActorValueEnum)
      ]),
      wbInteger('Magic School', itS32, wbMagicSchoolEnum),
      wbInteger('Resist value', itS32, wbActorValueEnum),
      wbInteger('Counter Effect Count', itU16), //!!! must be updated automatically when ESCE length changes!
      wbByteArray('Unused', 2),
      wbFormIDCk('Light', [LIGH, NULL]),
      wbFloat('Projectile speed'),
      wbFormIDCk('Effect Shader', [EFSH, NULL]),
      wbFormIDCk('Enchant effect', [EFSH, NULL]),
      wbFormIDCk('Casting sound', [NULL, SOUN]),
      wbFormIDCk('Bolt sound', [NULL, SOUN]),
      wbFormIDCk('Hit sound', [NULL, SOUN]),
      wbFormIDCk('Area sound', [NULL, SOUN]),
      wbFloat('Constant Effect enchantment factor'),
      wbFloat('Constant Effect barter factor')
    ], cpNormal, True, nil, 10),
    wbArrayS(ESCE, 'Counter Effects', wbStringMgefCode('Counter Effect Code', 4),
      0, cpNormal, False, nil, wbCounterEffectsAfterSet)
  ], False, nil, cpNormal, False, wbMGEFAfterLoad, wbMGEFAfterSet);

  wbRecord(MISC, 'Misc. Item', [
    wbEDID,
    wbFULL,
    wbMODL,
    wbICON,
    wbSCRI,
    wbStruct(DATA, '', [
      wbUnion('', wbMISCActorValueDecider, [
        wbInteger('Value', itS32),
        wbFormIDCk('Actor Value', [ACVA])
      ]),
      wbUnion('', wbMISCActorValueDecider, [
        wbFloat('Weight'),
        wbInteger('Group', itU32, wbEnum([], [
          $40E00000, ' [NONE]',
          $40400000, 'AI',
          $00000000, 'Attribute',
          $40C00000, 'Combat',
          $40A00000, 'Misc',
          $40000000, 'Skill',
          $40800000, 'Social',
          $3F800000, 'Stat'
        ]))
      ])
    ], cpNormal, True)
  ]);

  wbFaceGen := wbRStruct('FaceGen Data', [
    wbByteArray(FGGS, 'FaceGen Geometry-Symmetric', 0, cpNormal, True),
    wbByteArray(FGGA, 'FaceGen Geometry-Asymmetric', 0, cpNormal, True),
    wbByteArray(FGTS, 'FaceGen Texture-Symmetric', 0, cpNormal, True)
  ], [], cpNormal, True);

  wbRecord(NPC_, 'Non-Player Character', [
    wbEDID,
    wbFULL,
    wbMODL,
    wbStruct(ACBS, 'Configuration', [
      wbInteger('Flags', itU32, wbFlags([
        {0x000001} 'Female',
        {0x000002} 'Essential',
        {0x000004} '',
        {0x000008} 'Respawn',
        {0x000010} 'Auto-calc stats',
        {0x000020} '',
        {0x000040} '',
        {0x000080} 'PC Level Offset',
        {0x000100} '',
        {0x000200} 'No Low Level Processing',
        {0x000400} '',
        {0x000800} '',
        {0x001000} '',
        {0x002000} 'No Rumors',
        {0x004000} 'Summonable',
        {0x008000} 'No Persuasion',
        {0x010000} '',
        {0x020000} '',
        {0x040000} '',
        {0x080000} '',
        {0x100000} 'Can Corpse Check'
      ])),
      wbInteger('Base spell points', itU16),
      wbInteger('Fatigue', itU16),
      wbInteger('Barter gold', itU16),
      wbInteger('Level (offset)', itS16),
      wbInteger('Calc min', itU16),
      wbInteger('Calc max', itU16)
    ], cpNormal, True),
    wbRArrayS('Factions', wbFaction),
    wbFormIDCk(INAM, 'Death item', [LVLI]),
    wbFormIDCk(RNAM, 'Race', [RACE], False, cpNormal, True),
    wbCNTOs,
    wbSPLOs,
    wbSCRI,
    wbStruct(AIDT, 'AI Data', [
      wbInteger('Aggression', itU8),
      wbInteger('Confidence', itU8),
      wbInteger('Energy Level', itU8),
      wbInteger('Responsibility', itU8),
      wbInteger('Buys/Sells and Services', itU32, wbServiceFlags),
      wbInteger('Teaches', itS8, wbSkillEnum),
      wbInteger('Maximum training level', itU8),
      wbByteArray('Unused', 2)
    ], cpNormal, True),
    wbRArray('AI Packages', wbFormIDCk(PKID, 'AI Package', [PACK])),
    wbArrayS(KFFZ, 'Animations', wbString('Animation')),
    wbFormIDCk(CNAM, 'Class', [CLAS], False, cpNormal, True),
    wbStruct(DATA, 'Stats', [
      wbInteger('Armorer', itU8),
      wbInteger('Athletics', itU8),
      wbInteger('Blade', itU8),
      wbInteger('Block', itU8),
      wbInteger('Blunt', itU8),
      wbInteger('Hand to Hand', itU8),
      wbInteger('Heavy Armor', itU8),
      wbInteger('Alchemy', itU8),
      wbInteger('Alteration', itU8),
      wbInteger('Conjuration', itU8),
      wbInteger('Destruction', itU8),
      wbInteger('Illusion', itU8),
      wbInteger('Mysticism', itU8),
      wbInteger('Restoration', itU8),
      wbInteger('Acrobatics', itU8),
      wbInteger('Light Armor', itU8),
      wbInteger('Marksman', itU8),
      wbInteger('Mercantile', itU8),
      wbInteger('Security', itU8),
      wbInteger('Sneak', itU8),
      wbInteger('Speechcraft', itU8),
      wbInteger('Health', itU16),
      wbByteArray('Unused', 2),
      wbInteger('Strength', itU8),
      wbInteger('Intelligence', itU8),
      wbInteger('Willpower', itU8),
      wbInteger('Agility', itU8),
      wbInteger('Speed', itU8),
      wbInteger('Endurance', itU8),
      wbInteger('Personality', itU8),
      wbInteger('Luck', itU8)
    ], cpNormal, True),
    wbFormIDCk(HNAM, 'Hair', [HAIR]),
    wbFloat(LNAM, 'Hair length'),
    wbArray(ENAM, 'Eyes', wbFormIDCk('Eyes', [EYES])),
    wbStruct(HCLR, 'Hair color', [
      wbInteger('Red', itU8),
      wbInteger('Green', itU8),
      wbInteger('Blue', itU8),
      wbByteArray('Unused', 1)
    ], cpNormal, True).SetToStr(wbRGBAToStr).IncludeFlag(dfCollapsed, wbCollapseRGBA),
    wbFormIDCk(ZNAM, 'Combat Style', [CSTY]),
    wbFaceGen,
    wbByteArray(FNAM, 'Unknown', 0, cpBenign)
  ], True);

  wbPKDTFlags := wbFlags([
          {0x00000001} 'Offers services',
          {0x00000002} 'Must reach location',
          {0x00000004} 'Must complete',
          {0x00000008} 'Lock doors at package start',
          {0x00000010} 'Lock doors at package end',
          {0x00000020} 'Lock doors at location',
          {0x00000040} 'Unlock doors at package start',
          {0x00000080} 'Unlock doors at package end',
          {0x00000100} 'Unlock doors at location',
          {0x00000200} 'Continue if PC near',
          {0x00000400} 'Once per day',
          {0x00000800} 'Unused',
          {0x00001000} 'Skip fallout behavior',
          {0x00002000} 'Always run',
          {0x00004000} '',
          {0x00008000} '',
          {0x00010000} '',
          {0x00020000} 'Always sneak',
          {0x00040000} 'Allow swimming',
          {0x00080000} 'Allow falls',
          {0x00100000} 'Armor unequipped',
          {0x00200000} 'Weapons unequipped',
          {0x00400000} 'Defensive combat',
          {0x00800000} 'Use horse',
          {0x01000000} 'No idle anims',
          {0x02000000} '',
          {0x04000000} '',
          {0x08000000} '',
          {0x10000000} '',
          {0x20000000} '',
          {0x40000000} '',
          {0x80000000} ''
        ]);

  wbPKDTType := wbEnumSummary([
           {0} 'Find', '',
           {1} 'Follow', '',
           {2} 'Escort', '',
           {3} 'Eat', '',
           {4} 'Sleep', '',
           {5} 'Wander', '',
           {6} 'Travel', '',
           {7} 'Accompany', '',
           {8} 'Use item at', 'Use',
           {9} 'Ambush', '',
          {10} 'Flee not combat', 'Flee',
          {11} 'Cast magic', 'Cast'
        ]);

  wbRecord(PACK, 'AI Package', [
    wbEDID,
    wbUnion(PKDT, 'General', wbPACKPKDTDecider, [
      wbStruct('', [
        wbInteger('Flags', itU16, wbPKDTFlags),
        wbInteger('Type', itU8, wbPKDTType),
        wbByteArray('Unused', 1)
      ]).SetSummaryKey([1]).IncludeFlag(dfSummaryNoName),
      wbStruct('', [
        wbInteger('Flags', itU32, wbPKDTFlags),
        wbInteger('Type', itU8, wbPKDTType),
        wbByteArray('Unused', 3)
      ]).SetSummaryKey([1]).IncludeFlag(dfSummaryNoName)
    ]).IncludeFlag(dfSummaryNoName),
    wbStruct(PLDT, 'Location', [
      wbInteger('Type', itS32, wbEnumSummary([
        {0} 'Near reference', 'near',
        {1} 'In cell', 'in',
        {2} 'Near current location', 'near current location',
        {3} 'Near editor location', 'near editor location',
        {4} 'Object ID', 'at any',
        {5} 'Object type', 'at any object type'
      ])),
      wbUnion('Location', wbPxDTLocationDecider, [
        wbFormIDCkNoReach('Reference', [REFR, ACHR, ACRE, PLYR], True),
        wbFormIDCkNoReach('Cell', [CELL]),
        wbFormIDCk('Unused', [NULL]),
        wbFormIDCk('Unused', [NULL]),
        wbFormIDCkNoReach('Object ID', [ACTI, DOOR, FLOR, STAT, FURN, CREA, SPEL, NPC_, CONT, ARMO, AMMO, MISC, WEAP, INGR, SLGM, SGST, BOOK, KEYM, CLOT, ALCH, APPA, LIGH]),
        wbInteger('Object type', itU32)
      ]),
      wbInteger('Radius', itS32)
    ]).ForValue(procedure (const v: IwbValueDef) begin (v as IwbStructDef).SetSummaryKey([0, 1]).IncludeFlag(dfSummaryNoName) end).IncludeFlag(dfSummaryNoName),
    wbStruct(PSDT, 'Schedule', [
      wbInteger('Month', itS8),
      wbInteger('Day of week', itS8, wbEnum([
        'Sundas',
        'Morndas',
        'Tirdas',
        'Middas',
        'Turdas',
        'Fredas',
        'Loredas',
        'Morndas to Fredas',
        'Loredas, Sundas',
        'Morndas, Middas, Fredas',
        'Tirdas, Turdas'
      ], [
        -1, 'Any'
      ])),
      wbInteger('Date', itU8),
      wbInteger('Time', itS8),
      wbInteger('Duration', itS32)
    ]),
    wbStruct(PTDT, 'Target', [
      wbInteger('Type', itS32, wbEnumSummary([
        {0} 'Specific reference', 'only',
        {1} 'Object ID', 'any',
        {2} 'Object type', 'any object type'
      ])),
      wbUnion('Target', wbPxDTLocationDecider, [
        wbFormIDCkNoReach('Reference', [ACHR, ACRE, REFR, PLYR], True),
        wbFormIDCkNoReach('Object ID', [ACTI, DOOR, FLOR, STAT, FURN, CREA, SPEL, NPC_, CONT, ARMO, AMMO, MISC, WEAP, INGR, SLGM, SGST, BOOK, KEYM, CLOT, ALCH, APPA, LIGH]),
        wbInteger('Object type', itU32)
      ]),
      wbInteger('Count', itS32)
    ]).ForValue(procedure (const v: IwbValueDef) begin (v as IwbStructDef).SetSummaryKey([0, 1]).IncludeFlag(dfSummaryNoName) end).IncludeFlag(dfSummaryNoName),
    wbCTDAs
  ]).SetSummaryKey([1, 2, 4, 5]).IncludeFlag(dfSummaryNoName);

  wbPGRP :=
    wbArray(PGRP, 'Points', wbStruct('Point', [
      wbFloat('X'),
      wbFloat('Y'),
      wbFloat('Z (Even = Red/Orange, Odd = Blue)'),
      wbInteger('Connections', itU8{, wbPGRPConnectionsCallback}),
      wbByteArray('Unused', 3)
    ]), 0, nil, nil, cpNormal, True);

      {The Connection Count in the PGRP record specifies how many entries in this
       array belong to each point. If the first 4 points in the PGRP array have
       Connection Counts 2, 5, 2, 4 then the first 2 entries are the connections
       of point 0, then next 5 are the connections of point 1, the next 2 of point 2,
       the next 4 of point 3 and so on..., this can currently not be represented
       declaratively }

  wbRecord(PGRD, 'Path Grid', [
    wbInteger(DATA, 'Point Count', itU16, nil, cpNormal, True),
    wbPGRP,
    wbByteArray(PGAG, 'Unknown'),
    wbArray(PGRR, 'Point-to-Point Connections',
      wbArrayS('Point', wbInteger('Point', itS16), wbCalcPGRRSize{, cpNormal, False, wbPGRRPointAfterLoad})
    ),
    wbArrayS(PGRI, 'Inter-Cell Connections', wbStructSK([0,2,3,4], 'Inter-Cell Connection', [
      wbInteger('Point', itU16),
      wbByteArray('Unused', 2),
      wbFloat('X'),
      wbFloat('Y'),
      wbFloat('Z')
    ]), 0, cpNormal, False, wbPGRIPointerAfterLoad),
    wbRArrayS('Point-to-Reference Mappings',
      wbStructSK(PGRL, [0], 'Point-to-Reference Mapping', [
        wbFormIDCk('Reference', [REFR]),
        wbArrayS('Points', wbInteger('Point', itU32))
      ])
    )
  ], False, nil, cpNormal, False, wbPGRDAfterLoad);

  wbRecord(QUST, 'Quest', [
    wbEDID,
    wbSCRI,
    wbFULL,
    wbICON,
    wbStruct(DATA, 'General', [
      wbInteger('Flags', itU8, wbFlags([
        {0x01} 'Start game enabled',
        {0x02} '',
        {0x04} 'Allow repeated conversation topics',
        {0x08} 'Allow repeated stages'
      ])),
      wbInteger('Priority', itU8)
    ], cpNormal, True),
    wbCTDAs,
    wbRArrayS('Stages', wbRStructSK([0], 'Stage', [
      wbInteger(INDX, 'Stage index', itS16),
      wbRArray('Log Entries', wbRStruct('Log Entry', [
        wbInteger(QSDT, 'Stage Flags', itU8, wbFlags([
          {0x01} 'Complete quest'
        ])),
        wbCTDAs,
        wbStringKC(CNAM, 'Log Entry', 0, cpTranslate),
        wbResultScript
      ], []).SetSummaryKey([2, 1]))
    ], []).SetSummaryKey([1])),
    wbRArray('Targets', wbRStruct('Target', [
      wbStructSK(QSTA, [0], 'Target', [
        wbFormIDCkNoReach('Target', [REFR, ACRE, ACHR], True),
        wbInteger('Flags', itU8, wbFlags([
          {0x01} 'Compass marker ignores locks'
        ])),
        wbByteArray('Unused', 3)
      ]),
      wbCTDAs
    ], []).SetSummaryKey([0, 1]))
  ]);

  wbBodyDataIndex :=
    wbInteger(INDX, 'Index', itU32, wbEnum([
      'Upper Body',
      'Lower Body',
      'Hand',
      'Foot',
      'Tail'
    ]));

  wbRecord(RACE, 'Race', [
    wbEDID,
    wbFULL,
    wbDESC,
    wbSPLOs,
    wbXNAMs,
    wbStruct(DATA, '', [
      wbArrayS('Skill Boosts', wbStructSK([0], 'Skill Boost', [
        wbInteger('Skill', itS8, wbActorValueEnum),
        wbInteger('Boost', itS8)
      ]), 7),
      wbByteArray('Unused', 2),
      wbFloat('Male Height'),
      wbFloat('Female Height'),
      wbFloat('Male Weight'),
      wbFloat('Female Weight'),
      wbInteger('Flags', itU32, wbFlags([
        'Playable'
      ]))
    ], cpNormal, True),
    wbStruct(VNAM, 'Voice', [
      wbFormIDCk('Male', [RACE, NULL]),
      wbFormIDCk('Female', [RACE, NULL])
    ]),
    wbStruct(DNAM, 'Default Hair', [
      wbFormIDCk('Male', [HAIR]),
      wbFormIDCk('Female', [HAIR])
    ]),
    wbInteger(CNAM, 'Default Hair Color', itU8, nil, cpNormal, True),
    wbFloat(PNAM, 'FaceGen - Main clamp', cpNormal, True),
    wbFloat(UNAM, 'FaceGen - Face clamp', cpNormal, True),
    wbStruct(ATTR, 'Base Attributes', [
      wbStruct('Male', [
        wbInteger('Strength', itU8),
        wbInteger('Intelligence', itU8),
        wbInteger('Willpower', itU8),
        wbInteger('Agility', itU8),
        wbInteger('Speed', itU8),
        wbInteger('Endurance', itU8),
        wbInteger('Personality', itU8),
        wbInteger('Luck', itU8)
      ]),
      wbStruct('Female', [
        wbInteger('Strength', itU8),
        wbInteger('Intelligence', itU8),
        wbInteger('Willpower', itU8),
        wbInteger('Agility', itU8),
        wbInteger('Speed', itU8),
        wbInteger('Endurance', itU8),
        wbInteger('Personality', itU8),
        wbInteger('Luck', itU8)
      ])
    ]),
    wbRStruct('Face Data', [
      wbEmpty(NAM0, 'Face Data Marker'),
      wbRArrayS('Parts', wbRStructSK([0], 'Part', [
        wbInteger(INDX, 'Index', itU32, wbEnum([
          'Head',
          'Ear (Male)',
          'Ear (Female)',
          'Mouth',
          'Teeth (Lower)',
          'Teeth (Upper)',
          'Tongue',
          'Eye (Left)',
          'Eye (Right)'
        ])),
        wbMODL,
        wbICON
      ], []))
    ], [], cpNormal, True),
    wbEmpty(NAM1, 'Body Data Marker', cpNormal, True),
    wbRStruct('Male Body Data', [
      wbEmpty(MNAM, 'Male Body Data Marker'),
      wbMODL,
      wbRArrayS('Parts', wbRStructSK([0], 'Part', [
        wbBodyDataIndex,
        wbICON
      ], []))
    ], [], cpNormal, True),
    wbRStruct('Female Body Data', [
      wbEmpty(FNAM, 'Female Body Data Marker'),
      wbMODL,
      wbRArrayS('Parts', wbRStructSK([0], 'Part', [
        wbBodyDataIndex,
        wbICON
      ], []))
    ], [], cpNormal, True),
    wbArrayS(HNAM, 'Hairs', wbFormIDCk('Hair', [HAIR]), 0, cpNormal, True),
    wbArrayS(ENAM, 'Eyes', wbFormIDCk('Eye', [EYES]),  0,  cpNormal, True),
    wbFaceGen,
    wbByteArray(SNAM, 'Unknown', 2, cpNormal, True)
  ], True);

  wbRefRecord(REFR, 'Placed Object', [
    wbEDID,
    wbFormIDCk(NAME, 'Base', [TREE, SBSP, LVLC, SOUN, ACTI, DOOR, FLOR, STAT, FURN, CONT, ARMO, AMMO, MISC, WEAP, INGR, SLGM, SGST, BOOK, KEYM, CLOT, ALCH, APPA, LIGH, GRAS], False, cpNormal, True),
    wbStruct(XTEL, 'Teleport Destination', [
      wbFormIDCk('Door', [REFR], True),
      wbPosRot
    ]),
    wbStruct(XLOC, 'Lock information', [
      wbInteger('Lock Level', itU8),
      wbByteArray('Unused', 3),
      wbFormIDCk('Key', [KEYM, NULL]),
      wbUnion('Unused', wbXLOCFillerDecider, [
        wbEmpty('Unused'),
        wbByteArray('Unused', 4)
      ]),
      wbInteger('Flags', itU8, wbFlags(['', '', 'Leveled Lock'])),
      wbByteArray('Unused', 3)
    ]),
    wbRStruct('Ownership', [
      wbXOWN,
      wbInteger(XRNK, 'Faction rank', itS32),
      wbXGLB
    ], [XLOC]).SetToStr(wbFactionToStr).IncludeFlag(dfCollapsed, wbCollapseFactions),
    wbXESP,
    wbFormIDCk(XTRG, 'Target', [REFR, ACHR, ACRE], True),
    wbStruct(XSED, 'SpeedTree', [
      wbInteger('Seed', itU8),
      wbUnion('Unused', wbREFRXSEDDecider, [
        wbEmpty('Unused', cpIgnore),
        wbByteArray('Unused', 3, cpIgnore)
      ])
    ]),
    wbXLOD,
    wbFloat(XCHG, 'Charge'),
    wbInteger(XHLT, 'Health', itS32),
    wbRStruct('Unused', [
      wbFormIDCk(XPCI, 'Unused', [CELL]),
      wbString(FULL, 'Unused')
    ], []),
    wbInteger(XLCM, 'Level Modifier', itS32),
    wbFormIDCk(XRTM, 'Unknown', [REFR]),
    wbInteger(XACT, 'Action Flag', itU32, wbFlags([
      'Use Default',
      'Activate',
      'Open',
      'Open by Default'
    ])),
    wbInteger(XCNT, 'Count', itS32),
    wbRStruct('Map Marker', [
      wbEmpty(XMRK, 'Map Marker Data'),
      wbInteger(FNAM, 'Map Flags', itU8, wbFlags([
        {0x01} 'Visible',
        {0x02} 'Can Travel To'
      ]), cpNormal, True),
      wbFULLReq,
      wbStruct(TNAM, '', [
        wbInteger('Type', itU8, wbEnum([
          {0x00} 'None',
          {0x01} 'Camp',
          {0x02} 'Cave',
          {0x03} 'City',
          {0x04} 'Elven Ruin',
          {0x05} 'Fort Ruin',
          {0x06} 'Mine',
          {0x07} 'Landmark',
          {0x08} 'Tavern',
          {0x09} 'Settlement',
          {0x0A} 'Daedric Shrine',
          {0x0B} 'Oblivion Gate',
          {0x0C} 'Unknown? (door icon)'
        ])),
        wbByteArray('Unused', 1)
      ], cpNormal, True)
    ], []),
    wbEmpty(ONAM, 'Open by Default'),
    wbXRGD,
    wbXSCL,
    wbInteger(XSOL, 'Contained Soul', itU8, wbSoulGemEnum),
    wbDATAPosRot
  ], True, wbPlacedAddInfo, cpNormal, False, wbREFRAfterLoad);

  wbRecord(REGN, 'Region', [
    wbEDID,
    wbICON,
    wbStruct(RCLR, 'Map Color', [
      wbInteger('Red', itU8),
      wbInteger('Green', itU8),
      wbInteger('Blue', itU8),
      wbByteArray('Unused', 1)
    ], cpNormal, True).SetToStr(wbRGBAToStr).IncludeFlag(dfCollapsed, wbCollapseRGBA),
    wbFormIDCkNoReach(WNAM, 'Worldspace', [WRLD]),

    wbRArray('Region Areas', wbRStruct('Region Area', [
      wbInteger(RPLI, 'Edge Fall-off', itU32),
      wbArray(RPLD, 'Points', wbStruct('Point', [
        wbFloat('X'),
        wbFloat('Y')
      ]), 0, wbRPLDAfterLoad)
    ], []).SetSummaryKey([1]).IncludeFlag(dfSummaryNoName), cpNormal, True),

    wbRArrayS('Region Data Entries', wbRStructSK([0], 'Region Data Entry', [
      {always starts with an RDAT}
      wbStructSK(RDAT, [0], 'Data Header', [
        wbInteger('Type', itU32, wbEnum([
          {0}'',
          {1}'',
          {2}'Objects',
          {3}'Weather',
          {4}'Map',
          {5}'Unknown 5',
          {6}'Grass',
          {7}'Sound',
          {8}'',
          {9}''
        ])),
        wbInteger('Flags', itU8, wbFlags([
          'Override'
        ])),
        wbInteger('Priority', itU8),
        wbByteArray('Unused', 2)
      ], cpNormal, True, nil, 3),

      {followed by one of these: }

      {--- Objects ---}
      wbArray(RDOT, 'Objects', wbStruct('Object', [
        wbFormIDCk('Object', [TREE, FLOR, STAT, LTEX]),
        wbInteger('Parent Index', itU16, wbHideFFFF),
        wbByteArray('Unused', 2),
        wbFloat('Density'),
        wbInteger('Clustering', itU8),
        wbInteger('Min Slope', itU8),
        wbInteger('Max Slope', itU8),
        wbInteger('Flags', itU8, wbFlags([
          {0}'Conform to slope',
          {1}'Paint Vertices',
          {2}'Size Variance +/-',
          {3}'X +/-',
          {4}'Y +/-',
          {5}'Z +/-',
          {6}'Tree',
          {7}'Huge Rock'
        ])),
        wbInteger('Radius wrt Parent', itU16),
        wbInteger('Radius', itU16),
        wbFloat('Min Height'),
        wbFloat('Max Height'),
        wbFloat('Sink'),
        wbFloat('Sink Variance'),
        wbFloat('Size Variance'),
        wbStruct('Angle Variance', [
          wbInteger('X', itU16),
          wbInteger('Y', itU16),
          wbInteger('Z', itU16)
        ]).SetToStr(wbVec3ToStr).IncludeFlag(dfCollapsed, wbCollapseVec3),
        wbByteArray('Unused', 2),
        wbByteArray('Unknown', 4)
      ])),

      {--- Map ---}
      wbString(RDMP, 'Map Name', 0, cpTranslate),

      {--- Grass ---}
      wbArrayS(RDGS, 'Grasses', wbStructSK([0], 'Grass', [
        wbFormIDCk('Grass', [GRAS]),
        wbByteArray('Unused', 4)
      ])),

      {--- Sound ---}
      wbInteger(RDMD, 'Music Type', itU32, wbMusicEnum),
      wbArrayS(RDSD, 'Sounds', wbStructSK([0], 'Sound', [
        wbFormIDCk('Sound', [SOUN]),
        wbInteger('Flags', itU32, wbFlags([
          'Pleasant',
          'Cloudy',
          'Rainy',
          'Snowy'
        ])),
        wbInteger('Chance', itU32, wbScaledInt4ToStr, wbScaledInt4ToInt)
      ])),

      {--- Weather ---}
      wbArrayS(RDWT, 'Weather Types', wbStructSK([0], 'Weather Type', [
        wbFormIDCk('Weather', [WTHR]),
        wbInteger('Chance', itU32)
      ]))
    ], []))
  ], True).SetSummaryKey([3, 4]).IncludeFlag(dfSummaryNoName);

  wbRecord(ROAD, 'Road', [
    wbPGRP,
    wbArray(PGRR, 'Point-to-Point Connections (complex structure can''t be represented, see source)',
      {The Connection Count in the PGRP record specifies how many entries in this
       array belong to each point. If the first 4 points in the PGRP array have
       Connection Counts 2, 5, 2, 4 then the first 2 entries are the connections
       of point 0, then next 5 are the connections of point 1, the next 2 of point 2,
       the next 4 of point 3 and so on..., this can currently not be represented
       declaratively }
      wbStruct('Point', [
        wbFloat('X'),
        wbFloat('Y'),
        wbFloat('Z')
      ]).SetToStr(wbVec3ToStr).IncludeFlag(dfCollapsed, wbCollapseVec3), 0, nil, nil, cpNormal, True)
  ]);

  wbRecord(SBSP, 'Subspace', [
    wbEDID,
    wbStruct(DNAM, '', [
      wbFloat('X'),
      wbFloat('Y'),
      wbFloat('Z')
    ], cpNormal, True).SetToStr(wbVec3ToStr).IncludeFlag(dfCollapsed, wbCollapseVec3)
  ]).SetSummaryKey([1]);

  wbSLSD := wbStructSK(SLSD, [0], 'Local Variable Data', [
    wbInteger('Index', itU32),
    wbByteArray('Unused', 12),
    wbInteger('Flags', itU8, wbFlags(['IsLongOrShort']), cpCritical),
    wbByteArray('Unused')
  ]).IncludeFlag(dfSummaryNoName);

  wbRecord(SCPT, 'Script', [
    wbEDID,
    wbByteArray(SCHD, 'Unknown (Script Header?)'),
    wbSCHR,
    wbByteArray(SCDA, 'Compiled Script'),
    wbStringScript(SCTX, 'Script Source', 0, cpNormal, True),
    wbRArrayS('Local Variables', wbRStructSK([0], 'Local Variable', [
      wbSLSD,
      wbString(SCVR, 'Name', 0, cpCritical)
    ], []).SetSummaryKey([1]).IncludeFlag(dfSummaryNoName)),
    wbSCROs
  ]).SetToStr(wbScriptToStr);

  wbRecord(SGST, 'Sigil Stone', [
    wbEDID,
    wbStruct(OBME, 'Oblivion Magic Extender', [
      wbInteger('Record Version', itU8),
      wbStruct('OBME Version', [
        wbInteger('Beta', itU8),
        wbInteger('Minor', itU8),
        wbInteger('Major', itU8)
      ]),
      wbByteArray('Unused', $1C)
    ], cpNormal, False, wbOBMEDontShow),
    wbFULL,
    wbMODL,
    wbICON,
    wbSCRI,
    wbEffects,
    wbStruct(DATA, '', [
      wbInteger('Uses ', itU8),
      wbInteger('Value', itU32),
      wbFloat('Weight')
    ], cpNormal, True)
  ]);

  wbRecord(SKIL, 'Skill', [
    wbEDID,
    wbInteger(INDX, 'Skill', itS32, wbActorValueEnum, cpNormal, True),
    wbDESC,
    wbICON,
    wbStruct(DATA, 'Skill Data', [
      wbInteger('Action', itS32, wbActorValueEnum),
      wbInteger('Attribute', itS32, wbActorValueEnum),
      wbInteger('Specialization', itU32, wbSpecializationEnum),
      wbArray('Use Values', wbFloat('Use Value'), 2)
    ], cpNormal, True),
    wbString(ANAM, 'Apprentice Text', 0, cpTranslate, True),
    wbString(JNAM, 'Journeyman Text', 0, cpTranslate, True),
    wbString(ENAM, 'Expert Text', 0, cpTranslate, True),
    wbString(MNAM, 'Master Text', 0, cpTranslate, True)
  ]).SetSummaryKey([2]);

  wbRecord(SLGM, 'Soul Gem', [
    wbEDID,
    wbFULL,
    wbMODL,
    wbICON,
    wbSCRI,
    wbStruct(DATA, '', [
      wbInteger('Value', itU32),
      wbFloat('Weight')
    ], cpNormal, True),
    wbInteger(SOUL, 'Contained Soul', itU8, wbSoulGemEnum, cpNormal, True),
    wbInteger(SLCP, 'Maximum Capacity', itU8, wbSoulGemEnum, cpNormal, True)
  ]);

  wbRecord(SOUN, 'Sound', [
    wbEDID,
    wbString(FNAM, 'Sound FileName'),
    wbRUnion('Sound Data', [
      wbStruct(SNDX, 'Sound Data', [
        wbInteger('Minimum attenuation distance', itU8, wbMul(5)),
        wbInteger('Maximum attenuation distance', itU8, wbMul(100)),
        wbInteger('Frequency adjustment %', itS8),
        wbByteArray('Unused', 1),
        wbInteger('Flags', itU16, wbFlags([
          {0x0001} 'Random Frequency Shift',
          {0x0002} 'Play At Random',
          {0x0004} 'Environment Ignored',
          {0x0008} 'Random Location',
          {0x0010} 'Loop',
          {0x0020} 'Menu Sound',
          {0x0040} '2D',
          {0x0080} '360 LFE'
        ])),
        wbByteArray('Unused', 2),
        wbInteger('Static Attenuation (db)', itU16, wbDiv(100)),
        wbInteger('Stop time', itU8),
        wbInteger('Start time', itU8)
      ], cpNormal, True),
      wbStruct(SNDD, 'Sound Data', [
        wbInteger('Minimum attenuation distance', itU8, wbMul(5)),
        wbInteger('Maximum attenuation distance', itU8, wbMul(100)),
        wbInteger('Frequency adjustment %', itS8),
        wbByteArray('Unused', 1),
        wbInteger('Flags', itU16, wbFlags([
          {0x0001} 'Random Frequency Shift',
          {0x0002} 'Play At Random',
          {0x0004} 'Environment Ignored',
          {0x0008} 'Random Location',
          {0x0010} 'Loop',
          {0x0020} 'Menu Sound',
          {0x0040} '2D',
          {0x0080} '360 LFE'
        ])),
        wbByteArray('Unused', 2),
        wbEmpty('Unused'),
        wbEmpty('Unused'),
        wbEmpty('Unused')
      ], cpNormal, True)
    ], [], cpNormal, True)
  ]).SetSummaryKey([1]);

  wbRecord(SPEL, 'Spell', [
    wbEDID,
    wbStruct(OBME, 'Oblivion Magic Extender', [
      wbInteger('Record Version', itU8),
      wbStruct('OBME Version', [
        wbInteger('Beta', itU8),
        wbInteger('Minor', itU8),
        wbInteger('Major', itU8)
      ]),
      wbByteArray('Unused', $1C)
    ], cpNormal, False, wbOBMEDontShow),
    wbFULL,
    wbStruct(SPIT, '', [
      wbInteger('Type', itU32, wbEnum([
        {0} 'Spell',
        {1} 'Disease',
        {2} 'Power',
        {3} 'Lesser Power',
        {4} 'Ability',
        {5} 'Poison'
      ])),
      wbInteger('Cost', itU32),
      wbInteger('Level', itU32, wbEnum([
        {0} 'Novice',
        {1} 'Apprentice',
        {2} 'Journeyman',
        {3} 'Expert',
        {4} 'Master'
      ])),
      wbInteger('Flags', itU8, wbFlags([
        {0x00000001} 'Manual Spell Cost',
        {0x00000002} 'Immune to Silence 1',
        {0x00000004} 'Player Start Spell',
        {0x00000008} 'Immune to Silence 2',
        {0x00000010} 'Area Effect Ignores LOS',
        {0x00000020} 'Script Effect Always Applies',
        {0x00000040} 'Disallow Spell Absorb/Reflect',
        {0x00000080} 'Touch Spell Explodes w/ no Target'
      ])),
      wbByteArray('Unused', 3)
    ], cpNormal, True),
    wbEffects
  ]);

  wbRecord(STAT, 'Static', [
    wbEDID,
    wbMODL
  ]).SetSummaryKey([1]);

  wbRecord(TES4, 'Main File Header', [
    wbStruct(HEDR, 'Header', [
      wbFloat('Version'),
      wbInteger('Number of Records', itU32),
      wbInteger('Next Object ID', itU32, wbNextObjectIDToString, wbNextObjectIDToInt)
    ], cpNormal, True),
    wbByteArray(OFST, 'Unknown', 0, cpIgnore),
    wbByteArray(DELE, 'Unknown', 0, cpIgnore),
    wbString(CNAM, 'Author', 0, cpTranslate, True),
    wbString(SNAM, 'Description', 0, cpTranslate),
    wbRArray('Master Files', wbRStruct('Master File', [
      wbStringForward(MAST, 'FileName', 0, cpNormal, True),
      wbByteArray(DATA, 'Unused', 8, cpIgnore, True)
    ], [])).IncludeFlag(dfInternalEditOnly, not wbAllowMasterFilesEdit)
  ], False, nil, cpNormal, True, wbRemoveOFST);

  wbRecord(PLYR, 'Player Reference', [
    wbEDID,
    wbFormID(PLYR, 'Player', cpNormal, True).SetDefaultNativeValue($7)
  ]).IncludeFlag(dfInternalEditOnly);

  wbRecord(TREE, 'Tree', [
    wbEDID,
    wbMODL,
    wbICON,
    wbArrayS(SNAM, 'SpeedTree Seeds', wbInteger('SpeedTree Seed', itU32)),
    wbStruct(CNAM, 'Tree Data', [
      wbFloat('Leaf Curvature'),
      wbFloat('Minimum Leaf Angle'),
      wbFloat('Maximum Leaf Angle'),
      wbFloat('Branch Dimming Value'),
      wbFloat('Leaf Dimming Value'),
      wbInteger('Shadow Radius', itS32),
      wbFloat('Rock Speed'),
      wbFloat('Rustle Speed')
    ], cpNormal, True),
    wbStruct(BNAM, 'Billboard Dimensions', [
      wbFloat('Width'),
      wbFloat('Height')
    ], cpNormal, True)
  ]).SetSummaryKey([1]);

  wbRecord(WATR, 'Water', [
    wbEDID,
    wbString(TNAM, 'Texture', 0, cpNormal, True),
    wbInteger(ANAM, 'Opacity', itU8, nil, cpNormal, True),
    wbInteger(FNAM, 'Flags', itU8, wbFlags([
      {0}'Causes Damage',
      {1}'Reflective'
    ]), cpNormal, True),
    wbString(MNAM, 'Material ID'{>>>}, 0, cpNormal, True{<<<}),
    wbFormIDCk(SNAM, 'Sound', [SOUN]),
    wbStruct(DATA, '', [
      wbFloat('Wind Velocity'),
      wbFloat('Wind Direction'),
      wbFloat('Wave Amplitude'),
      wbFloat('Wave Frequency'),
      wbFloat('Sun Power'),
      wbFloat('Reflectivity Amount'),
      wbFloat('Fresnel Amount'),
      wbFloat('Scroll X Speed'),
      wbFloat('Scroll Y Speed'),
      wbFloat('Fog Distance - Near Plane'),
      wbFloat('Fog Distance - Far Plane'),
      wbStruct('Shallow Color', [
        wbInteger('Red', itU8),
        wbInteger('Green', itU8),
        wbInteger('Blue', itU8),
        wbByteArray('Unused', 1)
      ]).SetToStr(wbRGBAToStr).IncludeFlag(dfCollapsed, wbCollapseRGBA),
      wbStruct('Deep Color', [
        wbInteger('Red', itU8),
        wbInteger('Green', itU8),
        wbInteger('Blue', itU8),
        wbByteArray('Unused', 1)
      ]).SetToStr(wbRGBAToStr).IncludeFlag(dfCollapsed, wbCollapseRGBA),
      wbStruct('Reflection Color', [
        wbInteger('Red', itU8),
        wbInteger('Green', itU8),
        wbInteger('Blue', itU8),
        wbByteArray('Unused', 1)
      ]).SetToStr(wbRGBAToStr).IncludeFlag(dfCollapsed, wbCollapseRGBA),
      wbInteger('Texture Blend', itU8),
      wbByteArray('Unused', 3),
      wbFloat('Rain Simulator - Force'),
      wbFloat('Rain Simulator - Velocity'),
      wbFloat('Rain Simulator - Falloff'),
      wbFloat('Rain Simulator - Dampner'),
      wbFloat('Rain Simulator - Starting Size'),
      wbFloat('Displacement Simulator - Force'),
      wbFloat('Displacement Simulator - Velocity'),
      wbFloat('Displacement Simulator - Falloff'),
      wbFloat('Displacement Simulator - Dampner'),
      wbFloat('Displacement Simulator - Starting Size'),
      wbInteger('Damage', itU16)
    ], cpNormal, True, nil, 0),
    wbStruct(GNAM, 'Related Waters', [
      wbFormIDCk('Daytime', [WATR, NULL]),
      wbFormIDCk('Nighttime', [WATR, NULL]),
      wbFormIDCk('Underwater', [WATR, NULL])
    ], cpNormal{>>>, True<<<})
  ]).SetSummaryKey([1]);

  wbRecord(WEAP, 'Weapon', [
    wbEDID,
    wbFULL,
    wbMODL,
    wbICON,
    wbSCRI,
    wbENAM,
    wbInteger(ANAM, 'Enchantment Points', itU16),
    wbStruct(DATA, '', [
      wbInteger('Type', itU32, wbEnum([
        {0} 'Blade One Hand',
        {1} 'Blade Two Hand',
        {2} 'Blunt One Hand',
        {3} 'Blunt Two Hand',
        {4} 'Staff',
        {5} 'Bow'
      ])),
      wbFloat('Speed'),
      wbFloat('Reach'),
      wbInteger('Flags', itU32, wbFlags(['Ignores Normal Weapon Resistance'])),
      wbInteger('Value', itU32),
      wbInteger('Health', itU32),
      wbFloat('Weight'),
      wbInteger('Damage', itU16)
    ], cpNormal, True)
  ]);

  if wbSimpleRecords then
    wbRecord(WRLD, 'Worldspace', [
      wbEDID,
      wbFULL,
      wbRStruct('Parent', [
        wbFormIDCk(WNAM, 'Worldspace', [WRLD])
      ], []),
      wbFormIDCk(CNAM, 'Climate', [CLMT]),
      wbFormIDCk(NAM2, 'Water', [WATR]),
      wbICON,
      wbStruct(MNAM, 'Map Data', [
        wbStruct('Usable Dimensions', [
          wbInteger('X', itS32),
          wbInteger('Y', itS32)
        ]),
        wbStruct('Cell Coordinates', [
          wbStruct('NW Cell', [
            wbInteger('X', itS16),
            wbInteger('Y', itS16)
          ]),
          wbStruct('SE Cell', [
            wbInteger('X', itS16),
            wbInteger('Y', itS16)
          ])
        ])
      ]),
      wbInteger(DATA, 'Flags', itU8, wbFlags([
        {0x01} 'Small world',
        {0x02} 'Can''t fast travel',
        {0x04} 'Oblivion worldspace',
        {0x08} '',
        {0x10} 'No LOD water'
      ]), cpNormal, True),
      //wbArray(NAM0, 'Unknown', wbFloat(''), 0, nil, nil, cpNormal, True),
      //wbArray(NAM9, 'Unknown', wbFloat(''), 0, nil, nil, cpNormal, True),
      wbRStruct('Object Bounds', [
        wbStruct(NAM0, 'Min', [
          wbFloat('X', cpNormal, False, 1/4096),
          wbFloat('Y', cpNormal, False, 1/4096)
        ], cpIgnore, True),
        wbStruct(NAM9, 'Max', [
          wbFloat('X', cpNormal, False, 1/4096),
          wbFloat('Y', cpNormal, False, 1/4096)
        ], cpIgnore, True)
      ], []),
      wbInteger(SNAM, 'Music', itU32, wbMusicEnum),
      wbByteArray(OFST, 'Offset Data')
    ], False, nil, cpNormal, False, wbRemoveOFST)
  else
	wbRecord(WRLD, 'Worldspace', [
      wbEDID,
      wbFULL,
      wbRStruct('Parent', [
        wbFormIDCk(WNAM, 'Worldspace', [WRLD])
      ], []),
      wbFormIDCk(CNAM, 'Climate', [CLMT]),
      wbFormIDCk(NAM2, 'Water', [WATR]),
      wbICON,
      wbStruct(MNAM, 'Map Data', [
        wbStruct('Usable Dimensions', [
          wbInteger('X', itS32),
          wbInteger('Y', itS32)
        ]),
        wbStruct('Cell Coordinates', [
          wbStruct('NW Cell', [
            wbInteger('X', itS16),
            wbInteger('Y', itS16)
          ]),
          wbStruct('SE Cell', [
            wbInteger('X', itS16),
            wbInteger('Y', itS16)
          ])
        ])
      ]),
      wbInteger(DATA, 'Flags', itU8, wbFlags([
        {0x01} 'Small world',
        {0x02} 'Can''t fast travel',
        {0x04} 'Oblivion worldspace',
        {0x08} '',
        {0x10} 'No LOD water'
      ]), cpNormal, True),
      //wbArray(NAM0, 'Unknown', wbFloat(''), 0, nil, nil, cpNormal, True),
      //wbArray(NAM9, 'Unknown', wbFloat(''), 0, nil, nil, cpNormal, True),
      wbRStruct('Object Bounds', [
        wbStruct(NAM0, 'Min', [
          wbFloat('X', cpNormal, False, 1/4096),
          wbFloat('Y', cpNormal, False, 1/4096)
        ], cpIgnore, True),
        wbStruct(NAM9, 'Max', [
          wbFloat('X', cpNormal, False, 1/4096),
          wbFloat('Y', cpNormal, False, 1/4096)
        ], cpIgnore, True)
      ], []),
      wbInteger(SNAM, 'Music', itU32, wbMusicEnum),
      wbArray(OFST, 'Offset Data', wbArray('Rows', wbInteger('Offset', itU32), wbOffsetDataColsCounter), 0)
    ], False, nil, cpNormal, False, wbRemoveOFST);

  wbRecord(WTHR, 'Weather', [
    wbEDID,
    wbString(CNAM, 'Texture Lower Layer'),
    wbString(DNAM, 'Texture Upper Layer'),
    wbMODL,
    wbArray(NAM0, 'Colors by Types/Times',
      wbArray('Type',
        wbStruct('Time', [
          wbInteger('Red', itU8),
          wbInteger('Green', itU8),
          wbInteger('Blue', itU8),
          wbByteArray('Unused', 1)
        ]).SetToStr(wbRGBAToStr).IncludeFlag(dfCollapsed, wbCollapseRGBA),
        ['Sunrise', 'Day', 'Sunset', 'Night']
      ),
      ['Sky-Upper','Fog','Clouds-Lower','Ambient','Sunlight','Sun','Stars','Sky-Lower','Horizon','Clouds-Upper']
    , cpNormal, True),
    wbStruct(FNAM, 'Fog Distance', [
      wbFloat('Day Near'),
      wbFloat('Day Far'),
      wbFloat('Night Near'),
      wbFloat('Night Far')
    ], cpNormal, True),
    wbStruct(HNAM, 'HDR Data', [
      wbFloat('Eye Adapt Speed'),
      wbFloat('Blur Radius'),
      wbFloat('Blur Passes'),
      wbFloat('Emissive Mult'),
      wbFloat('Target LUM'),
      wbFloat('Upper LUM Clamp'),
      wbFloat('Bright Scale'),
      wbFloat('Bright Clamp'),
      wbFloat('LUM Ramp No Tex'),
      wbFloat('LUM Ramp Min'),
      wbFloat('LUM Ramp Max'),
      wbFloat('Sunlight Dimmer'),
      wbFloat('Grass Dimmer'),
      wbFloat('Tree Dimmer')
    ], cpNormal, True),
    wbStruct(DATA, '', [
      wbInteger('Wind Speed', itU8),
      wbInteger('Cloud Speed (Lower)', itU8),
      wbInteger('Cloud Speed (Upper)', itU8),
      wbInteger('Trans Delta', itU8),
      wbInteger('Sun Glare', itU8),
      wbInteger('Sun Damage', itU8),
      wbInteger('Precipitation - Begin Fade In', itU8),
      wbInteger('Precipitation - End Fade Out', itU8),
      wbInteger('Thunder/Lightning - Begin Fade In', itU8),
      wbInteger('Thunder/Lightning - End Fade Out', itU8),
      wbInteger('Thunder/Lightning - Frequency', itU8),
      wbInteger('Weather Classification', itU8, wbWthrDataClassification),
      wbStruct('Lightning Color', [
        wbInteger('Red', itU8),
        wbInteger('Green', itU8),
        wbInteger('Blue', itU8)
      ]).SetToStr(wbRGBAToStr).IncludeFlag(dfCollapsed, wbCollapseRGBA)
    ], cpNormal, True),
    wbRArray('Sounds', wbStruct(SNAM, 'Sound', [
      wbFormIDCk('Sound', [SOUN]),
      wbInteger('Type', itU32, wbEnum([
       {0}'Default',
       {1}'Precip',
       {2}'Wind',
       {3}'Thunder'
      ]))
    ]))
  ]).SetSummaryKey([1,2,3]);

  wbAddGroupOrder(GMST);
  wbAddGroupOrder(GLOB);
  wbAddGroupOrder(CLAS);
  wbAddGroupOrder(FACT);
  wbAddGroupOrder(HAIR);
  wbAddGroupOrder(EYES);
  wbAddGroupOrder(RACE);
  wbAddGroupOrder(SOUN);
  wbAddGroupOrder(SKIL);
  wbAddGroupOrder(MGEF);
  wbAddGroupOrder(SCPT);
  wbAddGroupOrder(LTEX);
  wbAddGroupOrder(ENCH);
  wbAddGroupOrder(SPEL);
  wbAddGroupOrder(BSGN);
  wbAddGroupOrder(ACTI);
  wbAddGroupOrder(APPA);
  wbAddGroupOrder(ARMO);
  wbAddGroupOrder(BOOK);
  wbAddGroupOrder(CLOT);
  wbAddGroupOrder(CONT);
  wbAddGroupOrder(DOOR);
  wbAddGroupOrder(INGR);
  wbAddGroupOrder(LIGH);
  wbAddGroupOrder(MISC);
  wbAddGroupOrder(STAT);
  wbAddGroupOrder(GRAS);
  wbAddGroupOrder(TREE);
  wbAddGroupOrder(FLOR);
  wbAddGroupOrder(FURN);
  wbAddGroupOrder(WEAP);
  wbAddGroupOrder(AMMO);
  wbAddGroupOrder(NPC_);
  wbAddGroupOrder(PLYR);
  wbAddGroupOrder(CREA);
  wbAddGroupOrder(LVLC);
  wbAddGroupOrder(SLGM);
  wbAddGroupOrder(KEYM);
  wbAddGroupOrder(ALCH);
  wbAddGroupOrder(SBSP);
  wbAddGroupOrder(SGST);
  wbAddGroupOrder(LVLI);
  wbAddGroupOrder(WTHR);
  wbAddGroupOrder(CLMT);
  wbAddGroupOrder(REGN);
  wbAddGroupOrder(CELL);
  wbAddGroupOrder(WRLD);
  wbAddGroupOrder(DIAL);
  wbAddGroupOrder(QUST);
  wbAddGroupOrder(IDLE);
  wbAddGroupOrder(PACK);
  wbAddGroupOrder(CSTY);
  wbAddGroupOrder(LSCR);
  wbAddGroupOrder(LVSP);
  wbAddGroupOrder(ANIO);
  wbAddGroupOrder(WATR);
  wbAddGroupOrder(EFSH);
  wbNexusModsUrl := 'https://www.nexusmods.com/oblivion/mods/11536';
  if wbToolMode = tmLODgen then
    wbNexusModsUrl := 'https://www.nexusmods.com/oblivion/mods/15781';
end;

initialization
end.
