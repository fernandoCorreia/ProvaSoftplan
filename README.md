# ProvaSoftplan

#Função do projeto
* MVP 
* Implementado busca por CEP no portal VIACEP;
* As buscas serão realizadas por XML ou Json, variando com a escolha do usuário
* Após realizar a busca, a informação será armazenada em banco de dados.
* Caso já exista a informação no banco de dados, a mesma será buscada do BD, caso não haja, será realizada a busca no VIACEP e será gravado em banco caso exista.



#Arquitetura

* IDE: Embarcadero Delphi Seattle
* Modelo MVC
* Orientado a Objetos
* BD: Firebird
* Componentes de acesso ao banco: Firedac
* Componentes de manipulação de XML e Json nativos do Delphi
* Grid, botões, edits nativos do Delphi


#Como executar

* Rodar a aplicação ou executável gerado após compilação
* informar CEP para pesquisa ou informar UF, cidade e logradouro
* Pesquisa em branco trará todos os registros inseridos no banco de dados
* Caso não haja registros no banco após pesquisa por CEP ou endereço, o sistema irá fazer uma requisição ao webservice VIACEP para pesquisa de informações, se encontradas serão adicionadas no banco de dados.
