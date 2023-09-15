program PAT23_P;

uses
  Vcl.Forms,
  PAT23_U in 'PAT23_U.pas' {frmWasteDis},
  clsUser_u in 'clsUser_u.pas',
  dmPAT_u in 'dmPAT_u.pas' {DataModule1: TDataModule},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmWasteDis, frmWasteDis);
  Application.CreateForm(TDataModule1, dmPAT);
  Application.Run;
end.
