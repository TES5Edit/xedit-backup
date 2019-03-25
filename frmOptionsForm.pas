unit frmOptionsForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, wbInterface,
  Vcl.Styles.Utils.SystemMenu, Vcl.Samples.Spin;

type
  TfrmOptions = class(TForm)
    pcOptions: TPageControl;
    tsCleaning: TTabSheet;
    btnOK: TButton;
    btnCancel: TButton;
    cbUDRSetXESP: TCheckBox;
    cbUDRSetScale: TCheckBox;
    cbUDRSetZ: TCheckBox;
    edUDRSetScaleValue: TEdit;
    edUDRSetZValue: TEdit;
    cbUDRSetMSTT: TCheckBox;
    edUDRSetMSTTValue: TEdit;
    Label1: TLabel;
    tsGeneral: TTabSheet;
    cbIKnow: TCheckBox;
    cbHideUnused: TCheckBox;
    cbHideIgnored: TCheckBox;
    cbHideNeverShow: TCheckBox;
    cbLoadBSAs: TCheckBox;
    cbSortFLST: TCheckBox;
    tsUISettings: TTabSheet;
    clbConflictThis: TColorBox;
    Label3: TLabel;
    cbConflictThis: TComboBox;
    Label4: TLabel;
    cbConflictAll: TComboBox;
    clbConflictAll: TColorBox;
    cbSimpleRecords: TCheckBox;
    cbAutoSave: TCheckBox;
    cbTrackAllEditorID: TCheckBox;
    cbSortGroupRecord: TCheckBox;
    cbShowFlagEnumValue: TCheckBox;
    cbRemoveOffsetData: TCheckBox;
    pnlFontRecords: TPanel;
    pnlFontMessages: TPanel;
    pnlFontViewer: TPanel;
    cbActorTemplateHide: TCheckBox;
    cbClampFormID: TCheckBox;
    cbShowGroupRecordCount: TCheckBox;
    Label5: TLabel;
    edColumnWidth: TEdit;
    edRowHeight: TEdit;
    Label6: TLabel;
    cbShowTip: TCheckBox;
    sedAutoCompareSelectedLimit: TSpinEdit;
    Label7: TLabel;
    Label8: TLabel;
    cbShowFileFlags: TCheckBox;
    cbAlignArrayElements: TCheckBox;
    Label9: TLabel;
    sedNavChangeDelay: TSpinEdit;
    Label10: TLabel;
    cbRequireCtrlForDblClick: TCheckBox;
    cbFocusAddedElement: TCheckBox;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure cbConflictThisChange(Sender: TObject);
    procedure clbConflictThisChange(Sender: TObject);
    procedure cbConflictAllChange(Sender: TObject);
    procedure clbConflictAllChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure pnlFontRecordsClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    _Files: ^TDynFiles;
  end;

var
  frmOptions: TfrmOptions;

implementation

{$R *.dfm}

uses
  frmViewMain,
  FileSelectFrm, TypInfo;

var
  wbColorConflictAllDefault: TConflictAllColors;
  wbColorConflictThisDefault: TConflictThisColors;

procedure TfrmOptions.cbConflictAllChange(Sender: TObject);
begin
  clbConflictAll.Selected := wbColorConflictAll[TConflictAll(cbConflictAll.Items.Objects[cbConflictAll.ItemIndex])];
end;

procedure TfrmOptions.cbConflictThisChange(Sender: TObject);
begin
  clbConflictThis.Selected := wbColorConflictThis[TConflictThis(cbConflictThis.Items.Objects[cbConflictThis.ItemIndex])];
end;

procedure TfrmOptions.clbConflictAllChange(Sender: TObject);
begin
  wbColorConflictAll[TConflictAll(cbConflictAll.Items.Objects[cbConflictAll.ItemIndex])] := clbConflictAll.Selected;
end;

procedure TfrmOptions.clbConflictThisChange(Sender: TObject);
begin
  wbColorConflictThis[TConflictThis(cbConflictThis.Items.Objects[cbConflictThis.ItemIndex])] := clbConflictThis.Selected;
end;

procedure TfrmOptions.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if ModalResult <> mrOk then begin
    wbColorConflictAll := wbColorConflictAllDefault;
    wbColorConflictThis := wbColorConflictThisDefault;
  end;
end;

procedure TfrmOptions.FormCreate(Sender: TObject);
var
  ct: TConflictThis;
  ca: TConflictAll;
begin
  wbApplyFontAndScale(Self);

  if wbThemesSupported then
    with TVclStylesSystemMenu.Create(Self) do begin
      ShowNativeStyle := True;
      MenuCaption := 'Theme';
    end;

  for ct := ctNotDefined to High(TConflictThis) do
    cbConflictThis.Items.AddObject(Copy(GetEnumName(TypeInfo(TConflictThis), Integer(ct)), 3, 100), Pointer(ct));
  cbConflictThis.ItemIndex := 0;
  cbConflictThisChange(nil);

  for ca := caNoConflict to High(TConflictAll) do
    cbConflictAll.Items.AddObject(Copy(GetEnumName(TypeInfo(TConflictAll), Integer(ca)), 3, 100), Pointer(ca));
  cbConflictAll.ItemIndex := 0;
  cbConflictAllChange(nil);

  wbColorConflictAllDefault := wbColorConflictAll;
  wbColorConflictThisDefault := wbColorConflictThis;

  pcOptions.ActivePageIndex := 0;
end;

procedure TfrmOptions.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    ModalResult := mrCancel;
end;

procedure TfrmOptions.pnlFontRecordsClick(Sender: TObject);
begin
  with TFontDialog.Create(Self) do try
    Font := TPanel(Sender).Font;
    if Execute then
      TPanel(Sender).Font := Font;
  finally
    Free;
  end;
end;

end.
