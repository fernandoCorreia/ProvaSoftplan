unit UDataMPrincipal;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, vcl.dialogs, uControllerDados;

type
  TuDMPrincipal = class(TDataModule)
    FDConexao: TFDConnection;
    qryCep: TFDQuery;
    qryCepCODIGO: TIntegerField;
    qryCepCEP: TIntegerField;
    qryCepLOGRADOURO: TStringField;
    qryCepCOMPLEMENTO: TStringField;
    qryCepBAIRRO: TStringField;
    qryCepLOCALIDADE: TStringField;
    qryCepUF: TStringField;
    InsCep: TFDCommand;
    FDTransaction1: TFDTransaction;
  private
    { Private declarations }
  public
    { Public declarations }
    function GeraID: integer;
    function Pesquisar(Cep, Uf, Cidade, Logradouro: String): boolean;
    function GravaLocalidade(oObjEnd : tObjetosEnd): boolean;
  end;

var
  uDMPrincipal: TuDMPrincipal;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TuDMPrincipal }

function TuDMPrincipal.GeraID: integer;
var
  sqlMax: TFDQuery;
begin
  try
    try
      sqlMax := TFDQuery.Create(nil);
      sqlMax.Connection := FDConexao;
      sqlMax.SQL.Add('SELECT COALESCE(MAX(CODIGO), 1) + 1 AS CODIGO FROM VIACEP');
      sqlMax.Open;

      Result := sqlMax.FieldByName('CODIGO').AsInteger;
    except on e:exception do
      begin
        showMessage('Não foi possível obter sequenciador' + SLineBreak + e.Message);
        Result := -1
      end;
    end;
  finally
    if assigned(sqlMax) then
      FreeAndNil(sqlMax);
  end;
end;

function TuDMPrincipal.GravaLocalidade(oObjEnd : tObjetosEnd): boolean;
var
 dados : tObjetosEnd;
begin
  try
    if not (InsCep.Transaction.Active) then
      InsCep.Transaction.StartTransaction ;

    InsCep.Close;
    InsCep.ParamByName('CODIGO').AsInteger := GeraID;
    InsCep.ParamByName('CEP').AsInteger := oObjEnd.Cep;
    InsCep.ParamByName('LOGRADOURO').AsString := oObjEnd.Lugradouro;
    InsCep.ParamByName('COMPLEMENTO').AsString := oObjEnd.Complemento;
    InsCep.ParamByName('BAIRRO').AsString := oObjEnd.Bairro;
    InsCep.ParamByName('LOCALIDADE').AsString := oObjEnd.Localidade;
    InsCep.ParamByName('UF').AsString := oObjEnd.UF;
    InsCep.Execute(0);
    InsCep.Transaction.Commit;

  finally
    result := true;
  end;
end;

function TuDMPrincipal.Pesquisar(Cep, Uf, Cidade, Logradouro: String): boolean;
begin
  try
    try
      qryCep.Close;
      qryCep.SQL.Clear;
      qryCep.SQL.Add('SELECT * FROM VIACEP');
      if Cep <> EmptyStr then
        qryCep.SQL.Add('WHERE CEP = ' + Cep)
      else
        if (uf <> EmptyStr) or (cidade <> EmptyStr) or (Logradouro <> EmptyStr ) then
          begin
            qryCep.SQL.Add('WHERE UF = ' + QuotedStr(UF));
            qryCep.SQL.Add('  AND LOCALIDADE = ' + QuotedStr(Cidade));
            qryCep.SQL.Add('  AND LOGRADOURO  like (' + QuotedStr('%' + Logradouro + '%')+ ')' );
          end;

      qryCep.Open();
    Except
      result := false;
    end;
  finally
    result := true;
  end;
end;

end.
