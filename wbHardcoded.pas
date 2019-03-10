unit wbHardcoded;

interface

uses
  System.SysUtils, System.Classes, FileContainer;

type
  TwbHardcodedContainer = class(TDataModule)
    fcOblivion: TFileContainer;
    fcSkyrim: TFileContainer;
    fcFallout4: TFileContainer;
    fcFallout76: TFileContainer;
    fcFallout3: TFileContainer;
    fcFalloutNV: TFileContainer;
    fcEnderal: TFileContainer; // This is the same as Skyrim
  public
    class function GetHardCodedDat: TBytes;
  end;

implementation

uses
  wbInterface;

{$R *.dfm}

{ TwbHardcodedContainer }

class function TwbHardcodedContainer.GetHardCodedDat: TBytes;
var
  s             : string;
  FileContainer : TFileContainer;
begin
  Result := nil;
  with Create(nil) do try
    s := wbProgramPath + wbGameName + '.Hardcoded.Override.dat';
    if FileExists(s) then
      with TBytesStream.Create do try
        LoadFromFile(s);
        Result := Copy(Bytes);
        SetLength(Result, Size);
        Exit;
      finally
        Free;
      end;
    FileContainer := FindComponent('fc' + wbGameName) as TFileContainer;
    if Assigned(FileContainer) then
      Result := FileContainer.Data;
  finally
    Free;
  end;
end;

end.
