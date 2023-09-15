//Stephen Jacobson
unit PAT23_U;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.Menus, Data.DB, Vcl.Grids, Vcl.DBGrids, clsUser_u, dmPAT_u,
  Vcl.Buttons, Vcl.Imaging.pngimage, Vcl.Samples.Spin, IdMessage,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdExplicitTLSClientServerBase, IdMessageClient, IdSMTPBase, IdSMTP,
  IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL,
  Data.Bind.Components, Data.Bind.ObjectScope, REST.Client, MMSystem,
  REST.Authenticator.Simple, Vcl.MPlayer, Vcl.Imaging.GIFImg;

type
  TfrmWasteDis = class(TForm)
    pgcReg: TPageControl;
    tbsReg: TTabSheet;
    lblR: TLabel;
    edtName: TEdit;
    edtSur: TEdit;
    edtEmail1: TEdit;
    edtPass1: TEdit;
    edtConPass: TEdit;
    edtConNum: TEdit;
    edtStrName: TEdit;
    edtStrNum: TEdit;
    lblN1: TLabel;
    lblSur1: TLabel;
    lblEm1: TLabel;
    lblStrName: TLabel;
    lblStrNum: TLabel;
    lblNum: TLabel;
    lblDOB: TLabel;
    lblPass1: TLabel;
    lblConPass: TLabel;
    Panel1: TPanel;
    btnConfirm: TButton;
    tbsLogin: TTabSheet;
    lblLogin: TLabel;
    lblEm2: TLabel;
    lblPass2: TLabel;
    edtEmail2: TEdit;
    edtPass2: TEdit;
    Panel2: TPanel;
    lblT: TLabel;
    lblCReg: TLabel;
    btnLogin: TButton;
    tbsHome: TTabSheet;
    lblAccName: TLabel;
    lbltDOB: TLabel;
    lblAccEm: TLabel;
    lblRegWas: TLabel;
    btnRegWas: TButton;
    Label1: TLabel;
    lblHome: TLabel;
    lblBackReg: TLabel;
    lblAl: TLabel;
    lblAlAcc: TLabel;
    tbsWaste: TTabSheet;
    cbxWClass: TComboBox;
    dtpDOB: TDateTimePicker;
    lblProv: TLabel;
    cbxProv: TComboBox;
    lblBackToHome: TLabel;
    btnConWaste: TButton;
    lblWaste: TLabel;
    tbsAdmin: TTabSheet;
    dbgUsers: TDBGrid;
    dbgOrders: TDBGrid;
    lblUser: TLabel;
    lblOrders: TLabel;
    tbsWelcome: TTabSheet;
    Panel4: TPanel;
    Panel5: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Image1: TImage;
    bbtnWelcome: TBitBtn;
    Label6: TLabel;
    Label7: TLabel;
    Image2: TImage;
    Label9: TLabel;
    sedWeight: TSpinEdit;
    Label8: TLabel;
    cbxActivities: TComboBox;
    dtpActDate: TDateTimePicker;
    Label10: TLabel;
    btnConBook: TButton;
    Label11: TLabel;
    dbgActivities: TDBGrid;
    Label12: TLabel;
    btnSQL1: TButton;
    btnSQL2: TButton;
    btnSQL3: TButton;
    btnSQL6: TButton;
    btnSQL5: TButton;
    btnSQL4: TButton;
    lstHistOr: TListBox;
    lstHistAc: TListBox;
    tbsAdmin2: TTabSheet;
    btnSQL7: TButton;
    lblBackAd: TLabel;
    lblAd2: TLabel;
    redRec: TRichEdit;
    MediaPlayer1: TMediaPlayer;
    procedure btnConfirmClick(Sender: TObject);
    procedure bbtnWelcomeClick(Sender: TObject);
    procedure lblAlAccClick(Sender: TObject);
    procedure tbsHomeShow(Sender: TObject);
    procedure btnLoginClick(Sender: TObject);
    procedure btnConWasteClick(Sender: TObject);
    procedure btnConBookClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure lstHistOrClick(Sender: TObject);
    procedure btnRegWasClick(Sender: TObject);
    procedure lblBackRegClick(Sender: TObject);
    procedure lstHistAcClick(Sender: TObject);
    procedure pgcRegChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSQL1Click(Sender: TObject);
    procedure btnSQL2Click(Sender: TObject);
    procedure btnSQL3Click(Sender: TObject);
    procedure btnSQL4Click(Sender: TObject);
    procedure btnSQL5Click(Sender: TObject);
    procedure btnSQL6Click(Sender: TObject);
    procedure btnSQL7Click(Sender: TObject);
    procedure lblCRegClick(Sender: TObject);
    procedure lblBackToHomeClick(Sender: TObject);
    procedure btnAd2Click(Sender: TObject);
    procedure lblBackAdClick(Sender: TObject);
    procedure lblAd2Click(Sender: TObject);
    procedure ClearReg;
    procedure tbsRegEnter(Sender: TObject);
    procedure tbsLoginEnter(Sender: TObject);
  private
    { Private declarations }
    redOr : TRichEdit;
    redAct : TRichEdit;
    dbgMain:TDBGrid;
    dbg1:TDBGrid;
    dbg2:TDBGrid;
  public
    { Public declarations }
  end;

var
  frmWasteDis: TfrmWasteDis;
  User:tUser;                //object
  iRow, iCol1, iCol2, iCount, iCount2:integer;
  arrUOr: array of array of string;         //stores orders to put specific user orders into list later
  arrUActivities: array of array of string;    //stores activities to put specific user activities into list later
  bActive1, bActive2,  bAd1, bAd2, bAd3:boolean;
const
  rRec:real=9.04;        //cost of recycled waste
  rNRec:real=14.46;      //cost of non recycled waste
  rDis:real=10/100;      //discount for students

implementation

{$R *.dfm}

procedure TfrmWasteDis.bbtnWelcomeClick(Sender: TObject);  //welcome page button to take to registration
begin
  pgcReg.ActivePage:=tbsReg;
end;

procedure TfrmWasteDis.btnAd2Click(Sender: TObject); //takes to second admin screen
begin
  pgcReg.ActivePage:=tbsAdmin2;

  if bActive1=true      //frees dynamic richedit if it exists
  then redOr.free;
  bActive1:=false;

  if bActive2=true      //frees dynamic richedit if it exists
  then redAct.free;
  bActive2:=false;


  if bAd1=true          //frees dynamic DBGrid if it exists
  then dbgMain.free;
  bAd1:=false;

  if bAd2=true          //frees dynamic DBGrid if it exists
  then dbg1.free;
  bAd2:=false;

  if bAd3=true          //frees dynamic DBGrid if it exists
  then dbg2.free;
  bAd3:=false;
end;

procedure TfrmWasteDis.btnConBookClick(Sender: TObject); //confirm booking made
begin
  redRec.clear;
  if cbxActivities.ItemIndex = -1 then
  begin
    ShowMessage('Please select a waste type.');
    Exit;
  end;                       //checks if activity has been selected

  if dtpActDate.Date = Date then
  begin
    ShowMessage('Selected date cannot be today.');
    Exit;
  end;                       //checks if date has been selected

  if dtpActDate.Date < Date then
  begin
    ShowMessage('Selected date cannot be in the past.');
    Exit;
  end;                       //checks if date is in the past

    dmPAT.tblActivities.Insert;
    dmPAT.tblActivities['Activity']:= cbxActivities.Items[cbxActivities.ItemIndex];
    dmPAT.tblActivities['DateOf']:= dtpActDate.date;
    dmPAT.tblActivities['User_Code']:=User.GetCode;
    dmPAT.tblActivities['Date_Booked']:=date;
    dmPAT.tblActivities.Post;     //if all went well then activity is booked and added to database

    dmPAT.tblUsers.edit;
    dmPAT.tblUsers['Last_Made']:=date;
    dmPAT.tblUsers['Made']:=true;
    dmPAT.tblUsers.post;       //user last made is changed to keep track if user is active

    ShowMessage('Date booked is valid and booking has been made!');   //confirmation

    dtpActDate.DateTime:=now;
    cbxActivities.ItemIndex:=-1;
    cbxActivities.text:='Activities to Book';     //resets inputs

    dmPAT.tblActivities.last;
    arrUActivities[strToInt(copy(User.GetCode,1,length(User.GetCode)-4)),iCount2+1]:=IntToStr(dmPAT.tblActivities['Booking_Num']);   //adds booking to array

    dmPAT.tblActivities.Last;
    redRec.Lines.Add('Receipt for Booked Activity '+IntToStr(dmPAT.tblActivities['Booking_Num'])+#13+'Activity: '+dmPAT.tblActivities['Activity']+#13+'Date: '+FormatDateTime('yyyy/mm/dd', date));  //generates receipt
end;

procedure TfrmWasteDis.btnConfirmClick(Sender: TObject);  //confirm registration
var sName,sSur,sError:string;
bError, bEm, bDis:boolean;
tUsers:TextFile;
begin
  User.free;
  User:=tUser.create(edtName.Text,edtSur.text, edtEmail1.text, edtStrName.text, edtStrNum.text, edtConNum.text, cbxProv.text, edtPass1.text, dtpDOB.DateTime );   //creates object
  sName:=edtName.text;
  sError:='';
  bError:=false;
  if (sName='')AND(length(sName)<2)
  then begin
         sError:=sError+'Name is not vaild'+#13;
         bError:=true;
       end;          //confirms name

  sSur:=edtSur.text;
  if (sSur='')AND(length(sSur)<2)
  then begin
         sError:=sError+'Surname is not vaild'+#13;
         bError:=true;
       end;          //confirms surname

  if (user.EmailGood(edtEmail1.text)=false)OR(Pos('#', edtEmail1.text) > 0)
  then begin
         sError:=sError+'Email is not vaild'+#13;
         bError:=true;
       end;          //confirms email

  if (edtstrNum.text='') or (edtstrName.text='')
  then begin
         sError:=sError+'Street name or number is not valid'+#13;
         bError:=true;
       end;          //confirms street name

  if user.ComboGood(cbxProv.ItemIndex)=false
  then begin
         sError:=sError+'No province selected'+#13;
         bError:=true;
       end;          //confirms province

  if User.getAge <16         //uses opjects
  then begin
         sError:=sError+'You are below the age of 18, therefore you may not yet use our service'+#13;
         bError:=true;
       end;          //confirms age
  bDis:=false;
  if (User.getAge<18)or(User.getAge>64)
  then bDis:=true;   //check if user is eligible for discount

  if (User.CheckInteger(edtConNum.text)=true)or(length(edtConNum.text)<>10)or(edtConNum.text='')
  then begin
         sError:=sError+'Enter a valid contact number'+#13;
         bError:=true;            //confirms contact number
       end
  else if (edtConNum.text[1]<>'0')        //make sure starts with '0'
       then begin
              sError:=sError+'Enter a valid contact number'+#13;
              bError:=true;
            end;

  if (edtPass1.text='')or(edtConPass.text='')or(length(edtPass1.text)<8)or(length(edtPass1.text)>15)
  then begin
         sError:=sError+'Enter a valid password'+#13;
         bError:=true;
       end                    //checks that password is valid
  else
  begin
  if User.CheckPassword(edtConPass.text)=false
  then begin
         sError:=sError+'Passwords do not match'+#13;
         bError:=true;
       end;
  end;                     //checks that passwords are the same

  bEm:=false;
  if bError=false        //continues if there are no errors
  then
  begin
  dmPAT.tblUsers.First;
  while not dmPAT.tblUsers.Eof do
    begin
    if dmPAT.tblUsers['Email'] =edtEmail1.text
    then
      begin
        bEm:=true;
        ShowMessage('An account with this email already exists');
        Exit;
      end
    else dmPAT.tblUsers.Next;
    end;                       //goes through DB to check if email already exists

    if bEm=False
    then begin
           dmPAT.tblUsers.Append;
           dmPAT.tblUsers['User_Code']:=User.CreateCode;
           dmPAT.tblUsers['User_Name']:=edtName.text;
           dmPAT.tblUsers['User_Surname']:=edtSur.text;
           dmPAT.tblUsers['Email']:=edtEmail1.text;
           dmPAT.tblUsers['Contact_Num']:=edtConNum.text;
           dmPAT.tblUsers['Province']:=cbxProv.text;
           dmPAT.tblUsers['DOB']:=(dtpDOB.date);
           dmPAT.tblUsers['Street']:=edtStrName.text;
           dmPAT.tblUsers['Street_Number']:=edtStrNum.text;
           dmPAT.tblUsers['Date_Joined']:=date;
           dmPAT.tblUsers['Last_Made']:=date;
           dmPAT.tblUsers['Discount']:=bDis;
           dmPAT.tblUsers['Active']:=true;
           dmPAT.tblUsers['Made']:=false;
           dmPAT.tblUsers.Post;             //user info added to DB if all is successful

           if fileexists('Users.txt')=true
           then
           begin
           AssignFile(tUsers,'Users.txt');
           Append(tUsers);
           Writeln(tUsers,edtEmail1.text+'#'+edtPass1.text);
           CloseFile(tUsers);
           pgcReg.ActivePage:=tbsLogin;
           end                         //adds email+password to text file delimited by '#'
           else begin
                AssignFile(tUsers,'Users.txt');
                Rewrite(tUsers);
                Writeln(tUsers,edtEmail1.text+'#'+edtPass1.text);
                CloseFile(tUsers);
                pgcReg.ActivePage:=tbsLogin;
                end;           //creates a user textfile if doesnt already exist
           ClearReg;           //procedure to clear all registration components
         end;
  end
  else Showmessage(sError);   //show error message
end;

procedure TfrmWasteDis.btnConWasteClick(Sender: TObject);   //confirm waste order
var rCost:real;
begin
  redRec.clear;
  if cbxWClass.ItemIndex = -1 then
  begin
    ShowMessage('Please select a waste type.');
    Exit;
  end;            //checks waste type is selected

  if sedWeight.Value < sedWeight.MinValue then
  begin
    ShowMessage('Waste weight cannot be less than ' + IntToStr(sedWeight.MinValue) + '.');
    Exit;
  end
  else if sedWeight.Value > sedWeight.MaxValue then
  begin
    ShowMessage('Waste weight cannot exceed ' + IntToStr(sedWeight.MaxValue) + '.');
    Exit;             //checks waste weight is within specified range
  end;


    
    dmPAT.tblOrders.Insert;
    dmPAT.tblOrders['Type']:= cbxWClass.Items[cbxWClass.ItemIndex];
    dmPAT.tblOrders['Waste_Weight']:= sedWeight.Value;
    dmPAT.tblOrders['User_Code']:=User.GetCode;     //adds info to order table
    if cbxWClass.Items[cbxWClass.ItemIndex]='Recycleable Waste'
    then rCost:= sedWeight.Value*rRec
    else rCost:= sedWeight.Value*rNRec;  //determines cost of order
    if dmPAT.tblUsers['Discount']=true
    then rCost:=rCost-(rCost*rDis);      //determines cost if discount present
    dmPAT.tblOrders['Cost']:=rCost;
    dmPAT.tblOrders['Date_Order']:=date;
    dmPAT.tblOrders.Post;

    dmPAT.tblUsers.edit;
    dmPAT.tblUsers['Last_Made']:=date;
    dmPAT.tblUsers['Made']:=true;
    dmPAT.tblUsers.post;               //updates last made to see if user active

    sedWeight.value:=1;
    cbxWClass.ItemIndex:=-1;
    cbxWClass.text:='Waste Classification';        //resets component values

    dmPAT.tblOrders.last;
    arrUOr[strToInt(copy(User.GetCode,1,length(User.GetCode)-4)),iCount+1]:=IntToStr(dmPAT.tblOrders['Order_Num']);      //adds order to array

    ShowMessage('Waste data added to the database and online receipt has been generated.');   //confirmation message

    dmPAT.tblOrders.Last;
    redRec.Lines.Add('Receipt for Order '+IntToStr(dmPAT.tblOrders['Order_Num'])+#13+'Waste Type: '+dmPAT.tblOrders['Type']+#13+'Waste Weight: '+IntToStr(dmPAT.tblOrders['Waste_Weight'])+'kg'+#13+'Cost of Order: '+FloatToStrf(dmPAT.tblOrders['Cost'],ffcurrency,10,2)+#13#13+'Date: '+FormatDateTime('yyyy/mm/dd', date));   //generate receipt
end;

procedure TfrmWasteDis.btnLoginClick(Sender: TObject);   //login, checks login info and goes to home screen
var
  sLine, sEm, sPass: string;
  bFound: Boolean;
  tUsers, tAdmin: TextFile;
begin
  if bActive1=true
  then redOr.free;
  bActive1:=false;

  if bActive2=true
  then redAct.free;
  bActive2:=false;


  if bAd1=true
  then dbgMain.free;
  bAd1:=false;

  if bAd2=true
  then dbg1.free;
  bAd2:=false;

  if bAd3=true
  then dbg2.free;
  bAd3:=false;

  bFound := False;
  AssignFile(tUsers,'Users.txt');
  Reset(tUsers);
    while not Eof(tUsers) do
    begin
      Readln(tUsers, sLine);
      sEm:= Copy(sLine, 1, Pos('#', sLine) - 1);
      sPass:= Copy(sLine, Pos('#', sLine) + 1, Length(sLine));  //looks through text file to see if email and password exist as an account
      if Pos('#', sLine) > 0 then
      begin
        if sEm = edtEmail2.text
        then
        begin
          if sPass = edtPass2.text
          then
          begin
            bFound := True;
            Break;
          end;         //checks if email and password match else will repeat on next line
        end;
      end;
    end;

    if bFound=true then     //if all well then will go to home screen
      begin
      ShowMessage('You have successfully logged in.');   //confirmation message

      dmPAT.tblUsers.First;
      while not dmPAT.tblUsers.Eof do
        begin
        if (edtEmail2.Text=dmPAT.tblUsers['Email'])
        then
        begin
          user.free;
          User:=tUser.create(dmPAT.tblUsers['User_Name'],dmPAT.tblUsers['User_Surname'], dmPAT.tblUsers['Email'], dmPAT.tblUsers['Street'], dmPAT.tblUsers['Street_Number'], dmPAT.tblUsers['Contact_Num'], dmPAT.tblUsers['Province'], sPass, dmPAT.tblUsers['DOB'] );
          User.SetCode(sEm);
          pgcReg.ActivePage:=tbsHome;
          edtEmail2.clear;
          edtPass2.clear;
          Exit;
        end
        else
        dmPAT.tblUsers.Next;
        end;
        
      end    //if user is found then creates user object and receives object information from DB
    else
      begin
      bFound := False;
  AssignFile(tAdmin,'Admin.txt');
  Reset(tAdmin);
    while not Eof(tAdmin) do
    begin
      Readln(tAdmin, sLine);
      sEm:= Copy(sLine, 1, Pos('#', sLine) - 1);
      sPass:= Copy(sLine, Pos('#', sLine) + 1, Length(sLine));
      if Pos('#', sLine) > 0 then
      begin
        if sEm = edtEmail2.text
        then
        begin
          if sPass = edtPass2.text
          then
          begin
            bFound := True;
            Break;
          end;
        end;
      end;
    end;
      end;   //if not found in first textfile then will look through admin textfile to see if user is a admin
  if bFound=true
  then begin
         showmessage('Admin Recognised');
         pgcReg.ActivePage:=tbsAdmin;
         CloseFile(tAdmin);
         edtEmail2.clear;
         edtPass2.clear;
         exit;
       end;     //if admin found then will take to admin screen
  ShowMessage('Email or password is incorrect.');     //if no user is found then error message
end;


procedure TfrmWasteDis.btnRegWasClick(Sender: TObject);    //takes to waste registration page and frees any present dynamic components
begin
  redRec.clear;
  pgcReg.ActivePage:=tbsWaste;

  if bActive1=true
  then redOr.free;
  bActive1:=false;

  if bActive2=true
  then redAct.free;
  bActive2:=false;


  if bAd1=true
  then dbgMain.free;
  bAd1:=false;

  if bAd2=true
  then dbg1.free;
  bAd2:=false;

  if bAd3=true
  then dbg2.free;
  bAd3:=false;
end;

procedure TfrmWasteDis.btnSQL1Click(Sender: TObject);  //SQL button to get specific command and info from DB
begin
  if bAd1=true
  then dbgMain.free;
  bAd1:=false;

  if bAd2=true
  then dbg1.free;
  bAd2:=false;

  if bAd3=true
  then dbg2.free;
  bAd3:=false;

  bAd1:=true;
  dbgMain := TDBGrid.Create(frmWasteDis);    //creates DBGrid to store SQL query data
  dbgMain.DataSource:=dmPat.dsGen;
  dbgMain.Parent := frmWasteDis;
  dbgMain.Top := 135;
  dbgMain.Left := 24;
  dbgMain.Height:=249;
  dbgMain.Width:=497;            //sets size and position
  dmPAT.qrGen.Close;
  dmPAT.qrGen.SQL.Clear;
  dmPAT.qrGen.SQL.add('SELECT Table_User.User_Code, Format(SUM(Table_Orders.Cost),"currency") AS TotalCost, Format(SUM(Table_Orders.Cost * 0.1),"currency") AS Charity, SUM(Table_Orders.Cost) - SUM(Table_Orders.Cost * 0.1) AS Profit ');
  dmPAT.qrGen.SQL.add('FROM Table_User INNER JOIN Table_Orders ON Table_User.User_Code = Table_Orders.User_Code GROUP BY Table_User.User_Code');
  dmPAT.qrGen.Open;  //Query to show total price user has paid for orders, profit made by business for each individual user, and donation amount generated by each user
end;

procedure TfrmWasteDis.btnSQL2Click(Sender: TObject);
begin
  if bAd1=true
  then dbgMain.free;
  bAd1:=false;

  if bAd2=true
  then dbg1.free;
  bAd2:=false;

  if bAd3=true
  then dbg2.free;
  bAd3:=false;

  bAd2:=true;
  dbg1 := TDBGrid.Create(frmWasteDis);
  dbg1.DataSource:=dmPat.dsGen;
  dbg1.Parent := frmWasteDis;
  dbg1.Top := 135;
  dbg1.Left := 288;
  dbg1.Height:=249;
  dbg1.Width:=256;
  dmPAT.qrGen.Close;
  dmPAT.qrGen.SQL.Clear;
  dmPAT.qrGen.SQL.add('SELECT Table_User.User_code, Count(Table_Orders.Order_Num) AS TotalOrders FROM Table_User INNER JOIN Table_Orders ON Table_User.User_code = Table_Orders.User_code GROUP BY Table_User.User_code');
  dmPAT.qrGen.Open;

  bAd3:=true;
  dbg2 := TDBGrid.Create(frmWasteDis);
  dbg2.DataSource:=dmPat.dsSub;
  dbg2.Parent := frmWasteDis;
  dbg2.Top := 135;
  dbg2.Left := 24;
  dbg2.Height:=249;
  dbg2.Width:=256;
  dmPAT.qrSub.Close;
  dmPAT.qrSub.SQL.Clear;
  dmPAT.qrSub.SQL.add('SELECT Table_User.User_code, Count(Table_ActivitiesBooked.Booking_Num) AS TotalActivitiesBooked FROM Table_User INNER JOIN Table_ActivitiesBooked ON Table_User.User_code = Table_ActivitiesBooked.User_code GROUP BY Table_User.User_code');
  dmPAT.qrSub.Open; //creates 2 DBGrids, one shows total orders from each user, other shows total activities booked by each user
end;

procedure TfrmWasteDis.btnSQL3Click(Sender: TObject);
begin
  if bAd1=true
  then dbgMain.free;
  bAd1:=false;

  if bAd2=true
  then dbg1.free;
  bAd2:=false;

  if bAd3=true
  then dbg2.free;
  bAd3:=false;

  bAd1:=true;
  dbgMain := TDBGrid.Create(frmWasteDis);
  dbgMain.DataSource:=dmPat.dsGen;
  dbgMain.Parent := frmWasteDis;
  dbgMain.Top := 135;
  dbgMain.Left := 24;
  dbgMain.Height:=249;
  dbgMain.Width:=497;
  dmPAT.qrGen.Close;
  dmPAT.qrGen.SQL.Clear;
  dmPAT.qrGen.SQL.add('SELECT COUNT(*) AS total_users, (SELECT COUNT(*) FROM Table_Orders) AS total_orders, (SELECT COUNT(*) FROM Table_ActivitiesBooked) AS total_booked_activities FROM Table_User;');
  dmPAT.qrGen.Open;  //shows total users, total orders, and total activties booked
end;

procedure TfrmWasteDis.btnSQL4Click(Sender: TObject);
begin
  if bAd1=true
  then dbgMain.free;
  bAd1:=false;

  if bAd2=true
  then dbg1.free;
  bAd2:=false;

  if bAd3=true
  then dbg2.free;
  bAd3:=false;

  bAd1:=true;
  dbgMain := TDBGrid.Create(frmWasteDis);
  dbgMain.DataSource:=dmPat.dsGen;
  dbgMain.Parent := frmWasteDis;
  dbgMain.Top := 135;
  dbgMain.Left := 24;
  dbgMain.Height:=249;
  dbgMain.Width:=497;
  dmPAT.qrGen.Close;
  dmPAT.qrGen.SQL.Clear;
  dmPAT.qrGen.SQL.add('SELECT Table_User.user_code, ROUND(SUM( Table_Orders.waste_weight) / COUNT( Table_Orders.order_Num), 2) AS average_waste_weight ');
  dmPAT.qrGen.SQL.add('FROM Table_User, Table_Orders WHERE Table_User.user_code =  Table_Orders.user_code GROUP BY Table_User.user_code ORDER BY ROUND(SUM( Table_Orders.waste_weight) / COUNT( Table_Orders.order_Num), 2) DESC');
  dmPAT.qrGen.Open;    //shows average kgs of waste generated by each user and orders desc by average weight
end;

procedure TfrmWasteDis.btnSQL5Click(Sender: TObject);
begin
  if bAd1=true
  then dbgMain.free;
  bAd1:=false;

  if bAd2=true
  then dbg1.free;
  bAd2:=false;

  if bAd3=true
  then dbg2.free;
  bAd3:=false;

  bAd1:=true;
  dbgMain := TDBGrid.Create(frmWasteDis);
  dbgMain.DataSource:=dmPat.dsGen;
  dbgMain.Parent := frmWasteDis;
  dbgMain.Top := 135;
  dbgMain.Left := 24;
  dbgMain.Height:=249;
  dbgMain.Width:=497;
  dmPAT.qrGen.Close;
  dmPAT.qrGen.SQL.Clear;
  dmPAT.qrGen.SQL.add('SELECT * FROM Table_User WHERE Active=true ORDER BY User_Code ASC');
  dmPAT.qrGen.Open;  //shows all active users
end;

procedure TfrmWasteDis.btnSQL6Click(Sender: TObject);
begin
  dmPAT.dsUsers.DataSet:=dmPAT.qrUser;

  dmPAT.qrUser.Close;
  dmPAT.qrUser.SQL.Clear;
  dmPAT.qrUser.SQL.add('UPDATE Table_User SET active = false WHERE Last_Made <= now() - 90;');
  dmPAT.qrUser.execSQL; //changes all user active field to false which havent made an order or booked anything in 3 or more months

  dmPAT.qrUser.Close;
  dmPAT.qrUser.SQL.Clear;
  dmPAT.qrUser.SQL.add('SELECT * FROM Table_User Order By User_Code');
  dmPAT.qrUser.open;  //then shows updated table
end;

procedure TfrmWasteDis.btnSQL7Click(Sender: TObject);
begin
  dmPAT.dsUsers.DataSet:=dmPAT.qrUser;

  dmPAT.qrUser.Close;
  dmPAT.qrUser.SQL.Clear;
  dmPAT.qrUser.SQL.add('DELETE FROM Table_User WHERE Active=false AND Made=false');
  dmPAT.qrUser.execSQL; //deleets users who arent active and havent made any orders/bookings

  dmPAT.qrUser.Close;
  dmPAT.qrUser.SQL.Clear;
  dmPAT.qrUser.SQL.add('SELECT * FROM Table_User Order By User_Code');
  dmPAT.qrUser.open;   //shows updated table
end;

procedure TfrmWasteDis.ClearReg;  //procedure to reset registration screen
begin
  edtName.clear;
  edtSur.Clear;
  edtEmail1.clear;
  edtStrNum.clear;
  edtStrname.clear;
  cbxProv.ItemIndex:=-1;
  dtpDOB.DateTime:=now;
  edtConNum.clear;
  edtPass1.clear;
  edtConPass.clear;
end;

procedure TfrmWasteDis.FormActivate(Sender: TObject);
var j, i:integer;
begin
  dtpActDate.DateTime:=now;
  dtpDOB.DateTime:=now;       //sets datetime pickers to today

  bActive1:=false;
  bActive2:=false;
  bAd1:=false;
  bAd2:=false;
  bAd3:=false;           //setting all boolean variables to default state
  dmPAT.tblUsers.last;
  iRow:=strToInt(copy(dmPAT.tblUsers['User_Code'],1,length(dmPAT.tblUsers['User_Code'])-4));   //get number of 2d array rows from user table user code
  iCol1:=dmPAT.tblOrders.recordcount;
  iCol2:=dmPAT.tblActivities.recordcount;
  SetLength(arrUOr, iRow+1, iCol1);
  SetLength(arrUActivities, iRow+1, iCol2);  //sets length of arrays based off length of tables


  dmPAT.tblUsers.first;
  while not dmPAT.tblUsers.Eof do    //goes through all users
  begin
    dmPAT.tblOrders.first;
      for j := 1 to iCol1 do    //then through all orders for each user
    begin
      i:=0;
      while not dmPAT.tblOrders.Eof do
      begin
        if dmPAT.tblUsers['User_Code']=dmPAT.tblOrders['User_Code']   //if order matches with user then order will be added to that users row in the 2d array
        then begin
               inc(i);
               arrUOr[strToInt(copy(dmPAT.tblUsers['User_Code'],1,length(dmPAT.tblUsers['User_Code'])-4)), i] := IntToStr(dmPAT.tblOrders['Order_Num']);  //adds to array
             end;
        dmPAT.tblOrders.next;
      end;
    end;
    dmPAT.tblUsers.Next;
  end;

  dmPAT.tblUsers.first;              //does the same for the actvities
  while not dmPAT.tblUsers.Eof do
  begin
    dmPAT.tblActivities.first;
      for j := 1 to iCol2 do
    begin
      i:=0;
      while not dmPAT.tblActivities.Eof do
      begin
        if dmPAT.tblUsers['User_Code']=dmPAT.tblActivities['User_Code']
        then begin
               inc(i);
               arrUActivities[strToInt(copy(dmPAT.tblUsers['User_Code'],1,length(dmPAT.tblUsers['User_Code'])-4)), i] := IntToStr(dmPAT.tblActivities['Booking_Num']);
             end;
        dmPAT.tblActivities.next;
      end;
    end;
    dmPAT.tblUsers.Next;
  end;
end;

procedure TfrmWasteDis.FormCreate(Sender: TObject);
var i:integer;
begin
  for i := 0 to pgcReg.PageCount-1 do
    pgcReg.Pages[i].TabVisible:=false;

  (Image1.Picture.Graphic as TGIFImage).Animate := True;
  (Image2.Picture.Graphic as TGIFImage).Animate := True; //animates the image components so the gifs start moving for aethetic purpose

  pgcReg.ActivePage:=tbsWelcome;
  try
  MediaPlayer1.FileName := 'OPPAT.mp3';
  MediaPlayer1.Open;
  MediaPlayer1.TimeFormat := tfMilliseconds;
  MediaPlayer1.Play;      //sets music to play as soon as program opens
  except
    showmessage('Error loading background music, program will instead remain silent'); //error message if an error occurs
  end;
end;

procedure TfrmWasteDis.lblAd2Click(Sender: TObject);
begin
  pgcReg.ActivePage:=tbsAdmin2;

  if bActive1=true
  then redOr.free;
  bActive1:=false;

  if bActive2=true
  then redAct.free;
  bActive2:=false;


  if bAd1=true
  then dbgMain.free;
  bAd1:=false;

  if bAd2=true
  then dbg1.free;
  bAd2:=false;

  if bAd3=true
  then dbg2.free;
  bAd3:=false;
end;

procedure TfrmWasteDis.lblAlAccClick(Sender: TObject);   //takes user to login screen
begin
  pgcReg.ActivePage:=tbsLogin;
end;

procedure TfrmWasteDis.lblBackAdClick(Sender: TObject);
begin
  pgcReg.ActivePage:=tbsAdmin;

  if bActive1=true
  then redOr.free;
  bActive1:=false;

  if bActive2=true
  then redAct.free;
  bActive2:=false;


  if bAd1=true
  then dbgMain.free;
  bAd1:=false;

  if bAd2=true
  then dbg1.free;
  bAd2:=false;

  if bAd3=true
  then dbg2.free;
  bAd3:=false;
end;

procedure TfrmWasteDis.lblBackRegClick(Sender: TObject);
begin
  pgcReg.ActivePage:=tbsReg;

  if bActive1=true
  then redOr.free;
  bActive1:=false;

  if bActive2=true
  then redAct.free;
  bActive2:=false;


  if bAd1=true
  then dbgMain.free;
  bAd1:=false;

  if bAd2=true
  then dbg1.free;
  bAd2:=false;

  if bAd3=true
  then dbg2.free;
  bAd3:=false;
end;

procedure TfrmWasteDis.lblBackToHomeClick(Sender: TObject);
begin
  pgcReg.ActivePage:=tbsHome;
  redRec.clear;
end;

procedure TfrmWasteDis.lblCRegClick(Sender: TObject);
begin
  pgcReg.ActivePage:=tbsReg;

  if bActive1=true
  then redOr.free;
  bActive1:=false;

  if bActive2=true
  then redAct.free;
  bActive2:=false;


  if bAd1=true
  then dbgMain.free;
  bAd1:=false;

  if bAd2=true
  then dbg1.free;
  bAd2:=false;

  if bAd3=true
  then dbg2.free;
  bAd3:=false;
end;

procedure TfrmWasteDis.lstHistAcClick(Sender: TObject);
begin
  dmPAT.tblActivities.first;
  while not dmPAT.tblActivities.eof do
  begin
  if arrUActivities[strToInt(copy(dmPAT.tblUsers['User_Code'],1,length(dmPAT.tblUsers['User_Code'])-4)),lstHistAc.Itemindex+1]=dmPAT.tblActivities['Booking_Num']
  then break;
  dmPAT.tblActivities.next;
  end;

  if bActive2=true
  then redAct.free;
  bActive2:=true;
  redAct := TRichEdit.Create(frmWasteDis);
  redAct.Parent := frmWasteDis;
  redAct.Top := 246;
  redAct.Left := 360;
  redAct.Height:=110;
  redAct.Width:=185;
  redAct.Text := 'Booked Activity Information:'+ #13;
  redAct.Lines.Add('Activity Booking Number: '+IntToStr(dmPAT.tblActivities['Booking_Num'])+#13+'Activity: '+dmPAT.tblActivities['Activity']+#13+'Date  Activity was Booked: '+FormatDateTime('yyyy/mm/dd', dmPAT.tblActivities['DateOf'])+#13+'Date Activity was Booked for: '+FormatDateTime('yyyy/mm/dd', dmPAT.tblActivities['Date_Booked']));
         //allows to click on order in list then activity info is displayed in dynamic richedit component
end;

procedure TfrmWasteDis.lstHistOrClick(Sender: TObject);
begin
  dmPAT.tblOrders.first;
  while not dmPAT.tblOrders.eof do
  begin
  if arrUOr[strToInt(copy(dmPAT.tblUsers['User_Code'],1,length(dmPAT.tblUsers['User_Code'])-4)),lstHistOr.Itemindex+1]=dmPAT.tblOrders['Order_Num']
  then break;
  dmPAT.tblOrders.next;
  end;

  if bActive1=true
  then redOr.free;
  bActive1:=true;
  redOr := TRichEdit.Create(frmWasteDis);
  redOr.Parent := frmWasteDis;
  redOr.Top := 110;
  redOr.Left := 360;
  redOr.Height:=89;
  redOr.Width:=185;
  redOr.Text := 'Order Information:'+ #13;
  redOr.Lines.Add('Order Number: '+IntToStr(dmPAT.tblOrders['Order_Num'])+#13+'Waste Type: '+dmPAT.tblOrders['Type']+#13+'Order Cost: '+FloatToStrf(dmPAT.tblOrders['Cost'],ffcurrency,10,2)+#13+'Date of Order: '+FormatDateTime('yyyy/mm/dd', dmPAT.tblOrders['Date_Order'])+#13+'Waste Weight: '+IntToStr(dmPAT.tblOrders['Waste_Weight']));
      //allows to click on order in list then order info is displayed in dynamic richedit component
  end;

procedure TfrmWasteDis.pgcRegChange(Sender: TObject);
begin
  if bActive1=true
  then redOr.free;
  bActive1:=false;

  if bActive2=true
  then redAct.free;
  bActive2:=false;


  if bAd1=true
  then dbgMain.free;
  bAd1:=false;

  if bAd2=true
  then dbg1.free;
  bAd2:=false;

  if bAd3=true
  then dbg2.free;
  bAd3:=false;

end;

procedure TfrmWasteDis.tbsHomeShow(Sender: TObject);
var i:integer;
begin
  lblAccName.caption:=User.GetName+' '+User.GetSurname;
  lblAccEm.caption:=User.GetEmail;
  lbltDOB.caption:=FormatDateTime('yyyy/mm/dd', User.GetDOB);  //loads some user information onto home screen so the user knows they have logged into correct account

  dmPAT.tblUsers.last;
  iRow:=strToInt(copy(dmPAT.tblUsers['User_Code'],1,length(dmPAT.tblUsers['User_Code'])-4));
  iCol1:=dmPAT.tblOrders.recordcount;
  iCol2:=dmPAT.tblActivities.recordcount;
  SetLength(arrUOr, iRow+1, iCol1);
  SetLength(arrUActivities, iRow+1, iCol2);

  lstHistOr.clear;
  lstHistAc.clear;

  iCount:=0;
  dmPAT.tblOrders.first;
  while not dmPAT.tblOrders.eof do
  begin
    if User.GetCode=dmPAT.tblOrders['User_Code']
    then inc(iCount);
    dmPAT.tblOrders.next;
  end;

  iCount2:=0;
  dmPAT.tblActivities.first;
  while not dmPAT.tblActivities.eof do
  begin
    if User.GetCode=dmPAT.tblActivities['User_Code']
    then inc(iCount2);
    dmPAT.tblActivities.next;
  end;


  dmPAT.tblActivities.First;
  User.SetCode(User.GetEmail);
  for I := 1 to iCount2 do
  begin
  dmPAT.tblActivities.First;
  while not(dmPAT.tblActivities.eof) do
    begin
      if arrUActivities[strToInt(copy(dmPAT.tblUsers['User_Code'],1,length(dmPAT.tblUsers['User_Code'])-4)),i]=IntToStr(dmPAT.tblActivities['Booking_Num'])
      then begin
             lstHistAc.Items.Add('Activity Number: '+IntToStr(dmPAT.tblActivities['Booking_Num']));
           end;
      dmPAT.tblActivities.Next;
    end;

  end;    //loads the specific user activities into the list

  dmPAT.tblOrders.First;
  User.SetCode(User.GetEmail);
  for I := 1 to iCount do
  begin
  dmPAT.tblOrders.First;
  while not(dmPAT.tblOrders.eof) do
    begin
      if arrUOr[strToInt(copy(dmPAT.tblUsers['User_Code'],1,length(dmPAT.tblUsers['User_Code'])-4)),i]=IntToStr(dmPAT.tblOrders['Order_Num'])
      then begin
             lstHistOr.Items.Add('Order Number: '+IntToStr(dmPAT.tblOrders['Order_Num']));
           end;
      dmPAT.tblOrders.Next;
    end;

  end;   //loads the specific user orders into the list
  
end;

procedure TfrmWasteDis.tbsLoginEnter(Sender: TObject);
begin
  edtEmail2.SetFocus;
end;

procedure TfrmWasteDis.tbsRegEnter(Sender: TObject);
begin
  edtName.setfocus;
end;

end.
