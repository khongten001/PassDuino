//
//  PassDuino
//  Version 1.0 (August 2020)
//
//  Made by ERDesigns - Ernst Reidinga
//  as an open-source project
//
//  If you change code, add functions, fix bugs or anything else
//  please share them - so i can update the GIT and update the code
//  on the website so others can use it too :)
//
//  I used some open-source / public domain - code from Torry, and SourceForce.
//
//  If you like my work, and you like to support by donating please send a mail
//  and ill send my paypal address where you can send the donation.
//
//

unit untSelectProfile;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, dxGDIPlusClasses,
  Vcl.ExtCtrls;

type
  TfrmSelectProfile = class(TForm)
    Label3: TLabel;
    Panel1: TPanel;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Panel2: TPanel;
    btnCancel: TButton;
    btnOK: TButton;
    cbProfile: TComboBox;
  private
    { Private declarations }
    procedure LoadProfiles;
  public
    { Public declarations }
    function Execute : TModalResult;
  end;

var
  frmSelectProfile: TfrmSelectProfile;

implementation

{$R *.dfm}

//
//  Load Profiles in the ComboBox
//
procedure TfrmSelectProfile.LoadProfiles;
var
  Path : string;
  SRec : TSearchRec;
begin
  cbProfile.Clear;
  Path := ExtractFileDir(Application.ExeName) + '\Profiles\';
  if not DirectoryExists(Path) then CreateDir(Path);
  if FindFirst(Path + '*.pdp', faArchive, SRec) = 0 then
  begin
    repeat
      cbProfile.Items.Add(ChangeFileExt(ExtractFilename(SRec.Name), ''));
    until FindNext(SRec) <> 0;
    FindClose(SRec);
  end;
end;

//
//  Execute Dialog
//
function TfrmSelectProfile.Execute : TModalResult;
begin
  LoadProfiles;
  if cbProfile.Items.Count > 0 then
    cbProfile.ItemIndex := 0;
  Result := ShowModal;
end;

end.
