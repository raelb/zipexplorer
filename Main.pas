unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, TB2Dock, TB2Toolbar, SpTBXItem,
  Vcl.ExtCtrls, RzTabs, AbBase, AbBrowse, AbZBrows, AbUnzper, Vcl.ComCtrls,
  AbComCtrls, RxPlacemnt, TextEditor, System.Actions, Vcl.ActnList, AbZipKit;

type
  TMainForm = class(TForm)
    SpTBXDock1: TSpTBXDock;
    SpTBXToolbar1: TSpTBXToolbar;
    Panel1: TPanel;
    RightPanel: TPanel;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    PageControl1: TRzPageControl;
    tsFolder: TRzTabSheet;
    tsArchive: TRzTabSheet;
    ArchivePanel: TPanel;
    FolderPanel: TPanel;
    AbUnZipper: TAbUnZipper;
    AbTreeView: TAbTreeView;
    FormStorage1: TFormStorage;
    ActionList1: TActionList;
    actOpen: TAction;
    OpenDialog: TOpenDialog;
    MiddlePanel: TPanel;
    AbListView: TAbListView;
    PageControl2: TRzPageControl;
    tsEditor: TRzTabSheet;
    tsImage: TRzTabSheet;
    Editor: TTextEditor;
    procedure FormDestroy(Sender: TObject);
    procedure AbListViewSelectItem(Sender: TObject; Item: TListItem; Selected:
        Boolean);
    procedure actOpenExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FArcFileName: string;
    FFolder: string;
    FSettings: TStringList;
    function GetSettingsFileName: string;
    function IsFPA: Boolean;
    procedure OpenArchive(FileName: string);
    function StreamToString(Stream: TMemoryStream): string;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

uses
  Utils;

{$R *.dfm}

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  FSettings.SaveToFile(GetSettingsFileName);
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  SpTBXDock1.Hide;

  FormStorage1.IniFileName := ExtractFilePath(ParamStr(0)) + 'layout.ini';
  Editor.Lines.Text := '';

  Editor.Fonts.Text.Size := 10;
  Editor.Fonts.LineNumbers.Size := 9;

  FSettings := TStringList.Create;
  if FileExists(GetSettingsFileName) then
  begin
    FSettings.LoadFromFile(GetSettingsFileName);
    if FSettings.Values['arcfilename'] <> '' then
      OpenArchive(FSettings.Values['arcfilename']);
  end;
end;

procedure TMainForm.AbListViewSelectItem(Sender: TObject; Item: TListItem;
    Selected: Boolean);
var
  CurrFileName: string;
  Stream: TMemoryStream;
begin
  if TAbListItem(Item).IsDirectory then
	  Editor.Clear
  else
  begin
    Stream := TMemoryStream.Create;
    try
      CurrFileName := TAbListItem(Item).ArchiveItem.FileName;
      AbUnZipper.ExtractToStream(CurrFileName, Stream);
      Stream.Position := 0;

      if not IsBinaryStream(Stream) then
      begin
        PageControl2.ActivePageIndex := 0;
        //if IsFPA then
          Editor.Lines.Text := StreamToString(Stream)
        //else Editor.Lines.LoadFromStream(Stream);
      end
      else
      begin
        Editor.lines.Clear;
      end;
    finally
      Stream.Free;
    end;
  end;
end;

procedure TMainForm.actOpenExecute(Sender: TObject);
begin
  if OpenDialog.Execute then
    OpenArchive(OpenDialog.FileName);
end;

function TMainForm.GetSettingsFileName: string;
begin
  Result := ExtractFilePath(ParamStr(0)) + 'settings.txt';
end;

function TMainForm.IsFPA: Boolean;
begin
  Result := ExtractFileExt(FArcFileName) = '.fpa';
end;

procedure TMainForm.OpenArchive(FileName: string);
begin
  FArcFileName := FileName;
  FSettings.Values['arcfilename'] := FileName;
  AbUnZipper.FileName := FileName;
end;

function TMainForm.StreamToString(Stream: TMemoryStream): string;
var
  StrStream: TStringStream;
begin
  StrStream := TStringStream.Create;
  try
    StrStream.LoadFromStream(Stream);
    Result := StrStream.DataString;

    if IsFPA then
      Result := StringReplace(Result, '?', #9 + '|' + #9, [rfReplaceAll]);
  finally
    StrStream.Free;
  end;
end;


end.
