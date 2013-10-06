unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  Tadd = class(TForm)
    edtDesc: TLabeledEdit;
    edtTotal: TLabeledEdit;
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Button2: TButton;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  add: Tadd;

implementation

uses
  Unit1;

{$R *.dfm}

procedure Tadd.Button1Click(Sender: TObject);
begin
  edtTotal.Text := inttostr(strtoint(edit1.Text) + strtoint(Edit2.Text));
end;

procedure Tadd.Button3Click(Sender: TObject);
begin
  with Form1 do
  begin
    FDQuery1.Connection.Connected := true;

    FDQuery1.SQL.Clear;
    FDQuery1.SQL.Add('insert into orders (description, total) values (');
    FDQuery1.SQL.Add('''' + edtDesc.Text + ''',');
    FDQuery1.SQL.Add(edtTotal.Text + ')');
    FDQuery1.ExecSQL();
  end;

  close();
end;

end.
