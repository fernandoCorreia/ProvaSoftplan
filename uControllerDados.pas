unit uControllerDados;

interface
type
  tObjetosEnd = class
  private
    FCep: integer;
    FLugradouro: string;
    FComplemento: String;
    FBairro: String;
    FLocalidade: String;
    FUf : string;
    procedure SetCep(aValue:Integer);
    function GetCep: Integer;
    procedure SetLugradouro(aValue:String);
    function GetLugradouro: String;
    procedure SetComplemento(aValue:String);
    function GetComplemento: String;
    procedure SetBairro(aValue:String);
    function GetBairro: String;
    procedure SetLocalidade(aValue:String);
    function GetLocalidade: String;
    procedure SetUf(aValue:String);
    function GetUf: String;
  public
    property Cep: integer read GetCep write  SetCep;
    property Lugradouro: String read GetLugradouro write  SetLugradouro;
    property Complemento: string read GetComplemento write  SetComplemento;
    property Bairro: string read GetBairro write  SetBairro;
    property Localidade: string read GetLocalidade write  SetLocalidade;
    property UF: string read GetUf write  SetUf;

  end;



implementation

{ tObjetosEnd }

function tObjetosEnd.GetBairro: String;
begin
  result := FBairro;
end;

function tObjetosEnd.GetCep: Integer;
begin
  result := FCep;
end;

function tObjetosEnd.GetComplemento: String;
begin
  result := FComplemento;
end;

function tObjetosEnd.GetLocalidade: String;
begin
  Result := FLocalidade;
end;

function tObjetosEnd.GetLugradouro: String;
begin
  Result := fLugradouro;
end;

function tObjetosEnd.GetUf: String;
begin
  Result := FUf;
end;

procedure tObjetosEnd.SetBairro(aValue: String);
begin
  FBairro := aValue;
end;

procedure tObjetosEnd.SetCep(aValue: Integer);
begin
  FCep := aValue;
end;

procedure tObjetosEnd.SetComplemento(aValue: String);
begin
  FComplemento := aValue;
end;

procedure tObjetosEnd.SetLocalidade(aValue: String);
begin
  FLocalidade := aValue;
end;

procedure tObjetosEnd.SetLugradouro(aValue: String);
begin
  FLugradouro := aValue;
end;

procedure tObjetosEnd.SetUf(aValue: String);
begin
  FUf := aValue;
end;

end.
