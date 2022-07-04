unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Actions, Vcl.ActnList, Vcl.Menus,
  IPPeerClient, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, REST.Response.Adapter, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, IPPeerServer, Datasnap.DSCommonServer, Datasnap.DSHTTP,
  Datasnap.DSHTTPWebBroker, Datasnap.DSMetadata, Datasnap.DSClientMetadata,
  Datasnap.DSClientRest, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack,
  IdSSL, IdSSLOpenSSL, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdHTTP, uModelDados, System.StrUtils, Vcl.Grids,
  Vcl.DBGrids, uDataMPrincipal;

type
  TForm1 = class(TForm)
    RadioGroup1: TRadioGroup;
    BtConsultar: TButton;
    Edit1: TEdit;
    dsCep: TDataSource;
    DBGrid1: TDBGrid;
    CEP: TLabel;
    Label1: TLabel;
    edUF: TEdit;
    Label2: TLabel;
    edCidade: TEdit;
    Label3: TLabel;
    edLogradouro: TEdit;
    procedure BtConsultarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.BtConsultarClick(Sender: TObject);
var
  Dados : tDados;
begin
  try
    Dados := tDados.Create;
    if dados.PesquisaBD(Edit1.Text, edUF.Text, edCidade.Text, edLogradouro.Text) then
      dsCep.DataSet := uDMPrincipal.qryCep;

    if uDmPrincipal.qryCep.RecordCount < 1 then
      begin
        ShowMessage('Não foi encontrado o CEP pesquisado em base local. O sistema irá pesquisar o CEP pelo portal VIACEP' + SLineBreak + 'Aguarde!');
        if (edUF.Text <> emptyStr) and (edCidade.Text <> emptyStr) and (edLogradouro.Text <> emptyStr) then
          begin
           if Dados.PesquisaViaCep(RadioGroup1.ItemIndex, 1, edUF.Text + '/' + edCidade.Text + '/' + edLogradouro.Text + '/') then
             dados.PesquisaBD(Edit1.Text, edUF.Text, edCidade.Text, edLogradouro.Text)
          end
        else
          if dados.PesquisaViaCep(RadioGroup1.ItemIndex, 0, Edit1.Text) then
            dados.PesquisaBD(Edit1.Text, edUF.Text, edCidade.Text, edLogradouro.Text)
      end;
  finally
    freeAndNil(Dados);
  end;

end;

end.
