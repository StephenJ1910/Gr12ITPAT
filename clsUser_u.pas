unit clsUser_u;

interface
uses dateutils,Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.Menus, Data.DB, Vcl.Grids, Vcl.DBGrids, dmPAT_u,
  Vcl.Buttons, Vcl.Imaging.pngimage;

type
  tUser = class(TObject)
  private
    fName: string;
    fSurname:string;
    fEmail: string;
    fAddress: string;
    fProvince:string;
    fContactNumber: string;
    fPassword:string;
    fAddressNum:string;
    fDOB:tDateTime;
    fCode:string;
  public
    constructor Create(sName, sSurname, sEmail, sAddress, sAddNum, sContactNumber, sProvince, sPassword: string; dtDOB:tDateTime);
    procedure SetCode(sEmail:string);
    function GetAge: Integer;
    function GetDOB: tDateTime;
    function GetEmail:string;
    function GetName:string;
    function GetSurname:string;
    function GetCode:string;
    function CheckPassword(sConPass:string):boolean;
    function CheckInteger(sValue:string):boolean;
    function EmailGood(sEm:string):boolean;
    function ComboGood(iSelect:integer):boolean;
    function CreateCode:string;
  end;

implementation

function tUser.ComboGood(iSelect: integer): boolean;
begin
  if iSelect=-1
  then result:=false
  else result:=true;
end;

function tUser.EmailGood(sEm: string): boolean;
var I, iCount:integer;
bLet:boolean;
begin
  result:=false;
  iCount:=0;
  if sEm=''
  then
  else
  begin
  for I := 1 to length(sEm) do
  begin
    if (sEm[I]='@')
    then begin
           result:=true;
           inc(iCount);
         end;
  end;
  if iCount>1
  then result:=false;
  end;
end;

function tUser.CheckInteger(sValue:string): boolean;
var I:integer;
bLet:boolean;
begin
  result:=false;
  for I := 1 to length(sValue) do
  begin if not (sValue[I] in ['0'..'9'])
  then result:=true;
  end;


end;

function tUser.CheckPassword(sConPass: string): boolean;
begin
  if fPassword=sConPass
  then result:=true
  else result:=false;
end;

constructor tUser.Create(sName, sSurname, sEmail, sAddress, sAddNum, sContactNumber, sProvince, sPassword: string; dtDOB:tDateTime);
begin
  fName := sName;
  fSurname:=sSurname;
  fEmail := sEmail;
  fAddress := sAddress;
  fContactNumber := sContactNumber;
  fPassword:=sPassword;
  fProvince:=sProvince;
  fAddressNum:=sAddNum;

  fDOB:=dtDOB;
end;

function tUser.CreateCode: string;
begin
  result:=IntToStr(dmPAT.tblUsers.recordcount+1)+copy(fName,1,2)+copy(fSurname,1,2);
end;

procedure tUser.SetCode(sEmail:string);    //find user account basedon email given in login
begin
  dmPAT.tblUsers.first;
  while not dmPAT.tblUsers.eof do
  begin
  if sEmail=dmPAT.tblUsers['Email']
  then begin
       fCode:=dmPAT.tblUsers['User_Code'];
       exit;
       end
  else
  dmPAT.tblUsers.next;
  end;
end;

function tUser.GetAge: Integer;
var
  Today: TDateTime;
  iYDiff: Integer;
begin
  Today := Now;
  iYDiff := YearOf(Today) - YearOf(fDOB);

  if (MonthOf(Today) < MonthOf(fDOB)) or
     ((MonthOf(Today) = MonthOf(fDOB)) and (DayOf(Today) < DayOf(fDOB)))
     then Dec(iYDiff);

  Result := iYDiff;
end;

function tUser.GetCode: string;
begin
 result:=fCode
end;

function tUser.GetDOB: tDateTime;
begin
  result:=fDOB;
end;

function tUser.GetName: string;
begin
  result:=fName;
end;

function tUser.GetSurname: string;
begin
  result:=fSurname;
end;

function tUser.GetEmail: string;
begin
  result:=fEmail;
end;

end.
