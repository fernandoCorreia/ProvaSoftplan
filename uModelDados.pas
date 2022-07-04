unit uModelDados;


interface
USES
  UDataMPrincipal, system.Classes, IdHTTP, IdSSLOpenSSL, system.SysUtils, xmldom,
  xmlDoc, uControllerDados, xmlIntf, forms, system.json;

  type
    tDados = class
    private
      function DesserializaJason(Parametro: string; Tipo: integer): boolean;
      function DesserializaXML(Parametro: string): boolean ;
      function RemoverCaracters(Parametro: string; Parametro2: Char): string;
    public
      function PesquisaBD(Cep, Uf, Cidade, Logradouro: string): boolean;
      function PesquisaViaCep(TipoIntegracao, TipoArray: integer; Parametro: string): boolean;
  end;

implementation

{ tDados }

function tDados.DesserializaJason(Parametro: string; Tipo: integer): boolean;
var
  jsonArray : TJSONArray;
  jsonObj : TJSONObject;
  dados: tObjetosEnd;
  
  i : integer;
begin
 try
   try
     dados := tObjetosEnd.Create;

     if tipo = 0 then
       begin
         jsonobj := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(Parametro),0) as TJSONObject;
         dados.Cep := StrToint(StringReplace(jsonobj.values['cep'].Value, '-', '', []));
         dados.Lugradouro := jsonobj.Values['logradouro'].Value;
         dados.Complemento := jsonobj.Values['complemento'].Value;
         dados.Bairro := jsonobj.Values['bairro'].Value;
         dados.Localidade := jsonobj.Values['localidade'].Value;
         dados.UF := jsonobj.Values['uf'].Value;

         uDMPrincipal.GravaLocalidade(dados);
       end
     else
       begin
          jsonArray := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(Parametro),0) as TJSONArray;

          for i := 0 to jsonArray.Size -1 do
            begin
             dados.Cep :=  StrToint(StringReplace(jsonArray.Get(i).GetValue<string>('cep'), '-', '', []));
             dados.Lugradouro := jsonArray.Get(i).GetValue<string>('logradouro');
             dados.Complemento :=jsonArray.Get(i).GetValue<string>('complemento');
             dados.Bairro := jsonArray.Get(i).GetValue<string>('bairro');
             dados.Localidade := jsonArray.Get(i).GetValue<string>('localidade');
             dados.UF := jsonArray.Get(i).GetValue<string>('uf');
             uDMPrincipal.GravaLocalidade(dados);
            end;
       end;

     result := true;
   Except
     result := false;
   end;
 finally
   FreeAndNil(dados);
   if assigned(jsonArray) then
     FreeAndNil(jsonArray);

   if assigned(jsonobj) then
     FreeAndNil(jsonobj);

 end;
end;

function tDados.DesserializaXML(Parametro: string) : boolean;
var
  XML : TXMLDocument;
  lista : TStringList;
  dado : tObjetosEnd;
  no : IXMLNode;
  i : integer;
  teste : string;
begin
  try
    try
      dado := tObjetosEnd.Create;
      lista := TStringList.Create;

      XML := TXMLDocument.Create(nil);


      XML.XML.Add(parametro);
      xml.Active := true;

      for I := 0 to xml.XML.Count - 1 do
        begin
          if Pos('cep', xml.XML.Strings[i]) > 0  then
             dado.Cep := StrToInt(RemoverCaracters(XML.XML.Strings[i], 'C'));
          if Pos('logradouro', xml.XML.Strings[i]) > 0  then
            dado.Lugradouro := RemoverCaracters(XML.XML.Strings[i], 'G');
          if Pos('Complemento', xml.XML.Strings[i]) > 0  then
            dado.Complemento := RemoverCaracters(XML.XML.Strings[i], 'O');
          if Pos('Bairro', xml.XML.Strings[i]) > 0  then
            dado.Bairro := RemoverCaracters(XML.XML.Strings[i], 'B');
          if Pos('Localidade', xml.XML.Strings[i]) > 0  then
            dado.Localidade := RemoverCaracters(XML.XML.Strings[i], 'L');
          if Pos('uf', xml.XML.Strings[i]) > 0  then
           dado.UF := RemoverCaracters(XML.XML.Strings[i], 'U');

         if dado.cep <> 0 then
           uDMPrincipal.GravaLocalidade(dado);
        end;

      result := true;
    Except
      Result := false;
    end;
  finally
    FreeAndNil(lista);
  end;
end;

function tDados.PesquisaBD(Cep, Uf, Cidade, Logradouro: string): boolean;
begin
  If uDMPrincipal.Pesquisar(Cep, Uf, Cidade, Logradouro) then;
    result := true;
end;

function tDados.PesquisaViaCep(TipoIntegracao, TipoArray: integer; Parametro: string): boolean;
var
  response : TStringStream;
  IDSSLHandler : TIdSSLIOHandlerSocketOpenSSL;
  HTTP : TIdHTTP;
begin
  try
    try
      result := false;
      HTTP := TIdHTTP.Create;
      IDSSLHandler := TIdSSLIOHandlerSocketOpenSSL.Create;
      IDSSLHandler.SSLOptions.Method := sslvTLSv1_2;
      HTTP.IOHandler := IDSSLHandler;

      response := TStringStream.Create('');
      case TipoIntegracao of
        0:
          begin
             HTTP.Get('https://viacep.com.br/ws/' + Parametro + '/xml', response);
             if pos('Bad Request', response.DataString) > 0 then
             result := DesserializaXML(response.DataString);
          end;
        1:
          begin
             HTTP.Get('https://viacep.com.br/ws/' + Parametro + '/json', Response);
             result := DesserializaJason(response.DataString, TipoArray);
          end;
      end;
    Except
      begin
        Result := false;
        raise Exception.Create('Não foi encontrado o endereço na base de dados VIACEP');
      end;
    end;
  finally
    FreeAndNil(HTTP);
    FreeAndNil(IDSSLHandler);
    FreeAndNil(response);
  end;
end;

function tDados.RemoverCaracters(Parametro: string; Parametro2 : char): string;
var
  Palavra: String;
begin
  case Parametro2 of
    'C':
      begin
         Palavra := StringReplace(Parametro, '<cep>', '', [rfReplaceAll]);
         Palavra := StringReplace(Palavra, '</cep>', '', [rfReplaceAll]);
         Palavra := StringReplace(Palavra, '-', '', [rfReplaceAll]);
      end;
    'O':
       begin
         Palavra := StringReplace(Parametro, '<complemento>', '', [rfReplaceAll]);
         Palavra := StringReplace(Palavra, '</complemento>', '', [rfReplaceAll]);
       end;
    'G':
       begin
         Palavra := StringReplace(Parametro, '<logradouro>', '', [rfReplaceAll]);
         Palavra := StringReplace(Palavra, '</logradouro>', '', [rfReplaceAll]);
       end;
    'L':
       begin
         Palavra := StringReplace(Parametro, '<localidade>', '', [rfReplaceAll]);
         Palavra := StringReplace(Palavra, '</localidade>', '', [rfReplaceAll]);
       end;
    'B':
       begin
         Palavra := StringReplace(Parametro, '<bairro>', '', [rfReplaceAll]);
         Palavra := StringReplace(Palavra, '</bairro>', '', [rfReplaceAll]);
       end;
    'U':
       begin  
         Palavra := StringReplace(Parametro, '<uf>', '', [rfReplaceAll]);
         Palavra := StringReplace(Palavra, '</uf>', '', [rfReplaceAll]);
       end;
  end;

  result := TRIM(Palavra);
end;

end.
