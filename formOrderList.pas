unit formOrderList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.UI.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys, Data.DB,
  FireDAC.Comp.Client, FireDAC.Comp.DataSet, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.ExtCtrls, FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLite, FireDAC.VCLUI.Wait,
  FireDAC.Comp.UI,

  //added
  formOrderAdd, OrderHandler, Order ;

type
  TfrmOrderList = class(TForm)
    ListView1: TListView;
    Button1: TButton;
    Button2: TButton;
    FDConnection1: TFDConnection;
    FDQuery1: TFDQuery;
    Button3: TButton;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    Button4: TButton;
    Button5: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmOrderList: TfrmOrderList;

implementation

{$R *.dfm}

uses formOrderEdit;

procedure TfrmOrderList.Button1Click(Sender: TObject);
begin
   application.Terminate;
end;

procedure TfrmOrderList.Button2Click(Sender: TObject);
begin
  frmOrderAdd.showModal;
  Button3Click(nil);
end;

procedure TfrmOrderList.Button3Click(Sender: TObject);
var
  li : TListItem;
  Orders : TList;
  i: Integer;
  Order : TOrder;
begin

  Orders := TList.Create();
  with TOrderHandler.create(frmOrderList.FDConnection1) do
  begin
    GetOrders(Orders);
    free();
  end;

  ListView1.Items.Clear;

  for i := 0 to Orders.Count - 1 do
  begin
    Order := TOrder(Orders[i]);
    li := ListView1.Items.Add();
    li.Caption := inttostr(Order.Id);
    li.SubItems.Add(Order.Description);
    li.SubItems.Add(currtostr(Order.Total));
  end;

  while Orders.Count > 0 do
  begin
    TOrder(Orders[0]).Free();
    Orders.Delete(0);
  end;
end;

procedure TfrmOrderList.Button4Click(Sender: TObject);
begin
  frmOrderEdit.Desc.Text := ListView1.Selected.SubItems[0];
  frmOrderEdit.Total.Text := ListView1.Selected.SubItems[1];
  frmOrderEdit.ShowModal;
  Button3Click(nil);
end;

procedure TfrmOrderList.Button5Click(Sender: TObject);
begin
  FDQuery1.Connection.Connected := true;

  FDQuery1.SQL.Clear;
  FDQuery1.SQL.Add('delete from orders where id = ' + ListView1.Selected.Caption);
  FDQuery1.ExecSQL();

  Button3Click(nil);
end;

procedure TfrmOrderList.FormCreate(Sender: TObject);
begin
  FDConnection1.Connected := true;
  Button3Click(nil);
end;

end.
