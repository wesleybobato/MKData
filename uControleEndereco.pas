unit uControleEndereco;

interface

uses
  // System
  System.SysUtils,
  System.Generics.Defaults,
  System.Generics.Collections,

  // Firedac
  FireDAC.Stan.Param,
  FireDAC.Comp.Client,

  // Self
  UDmBanco,
  UEndereco;

type
  TControleEndereco = class
  private
    { Private declarations }
    FQuery:       TFDQuery;
    FTransaction: TFDTransaction;
  public
    { Public declarations }
    constructor Create;
    destructor Destroy; override;

    function Inserir( Value: TEndereco ): Boolean;
    function Editar( Value: TEndereco ): Boolean;
    function Deletar( const Value: TDictionary< string, string > ): Boolean;
    function Consultar( const Value: TDictionary< string, string > ): TObjectList< TEndereco >;
  end;

implementation

{ TControleEndereco }

constructor TControleEndereco.Create;
begin
  inherited Create;
  FTransaction            := TFDTransaction.Create( nil );
  FTransaction.Connection := DmBanco.FDConnection;

  FQuery             := TFDQuery.Create( nil );
  FQuery.Connection  := DmBanco.FDConnection;
  FQuery.Transaction := FTransaction;
end;

destructor TControleEndereco.Destroy;
begin
  FQuery.Free;
  FTransaction.Free;
  inherited Destroy;
end;

function TControleEndereco.Consultar( const Value: TDictionary< string, string > ): TObjectList< TEndereco >;
var
  Item:      TPair< string, string >;
  Endereco:  TEndereco;
  Iteration: Boolean;
begin
  Result := TObjectList< TEndereco >.Create;

  FQuery.Transaction.StartTransaction;
  try
    try
      FQuery.SQL.Add( 'select * from ENDERECOS' );

      if Value.Count > 0 then
      begin
        Iteration := False;

        FQuery.SQL.Add( 'where' );

        for Item in Value do
        begin
          if Iteration then
            FQuery.SQL.Add( 'and' );

          FQuery.SQL.Add( Item.Key + ' = ' + QuotedStr( Item.Value ) );

          Iteration := True;
        end;
      end;

      FQuery.Open;
      try
        FQuery.First;

        while not FQuery.Eof do
        begin
          Endereco            := TEndereco.Create;
          Endereco.Id         := FQuery.FieldByName( 'ID' ).AsInteger;
          Endereco.IdCliente  := FQuery.FieldByName( 'ID_CLIENTE' ).AsInteger;
          Endereco.Logradouro := FQuery.FieldByName( 'LOGRADOURO' ).AsString;
          Endereco.Numero     := FQuery.FieldByName( 'NUMERO' ).AsString;
          Endereco.Cep        := FQuery.FieldByName( 'CEP' ).AsString;
          Endereco.Bairro     := FQuery.FieldByName( 'BAIRRO' ).AsString;
          Endereco.Cidade     := FQuery.FieldByName( 'CIDADE' ).AsString;
          Endereco.Estado     := FQuery.FieldByName( 'ESTADO' ).AsString;
          Endereco.Pais       := FQuery.FieldByName( 'PAIS' ).AsString;

          Result.Add( Endereco );
          FQuery.Next;
        end;

      finally
        FQuery.Close;
      end;

      FQuery.Transaction.Commit;

    finally
      FQuery.SQL.Clear;
    end;

  except
    FQuery.Transaction.Rollback;
  end;
end;

function TControleEndereco.Deletar( const Value: TDictionary< string, string > ): Boolean;
var
  Item:      TPair< string, string >;
  Iteration: Boolean;
begin
  Result := False;

  FQuery.Transaction.StartTransaction;
  try
    try
      FQuery.SQL.Add( 'delete from ENDERECOS' );

      if Value.Count > 0 then
      begin
        Iteration := False;

        FQuery.SQL.Add( 'where' );

        for Item in Value do
        begin
          if Iteration then
            FQuery.SQL.Add( 'and' );

          FQuery.SQL.Add( Item.Key + ' = ' + QuotedStr( Item.Value ) );

          Iteration := True;
        end;
      end;

      FQuery.ExecSQL;

      if FQuery.RowsAffected > 0 then
        FQuery.Transaction.Commit
      else
        FQuery.Transaction.Rollback;

      Result := True;

    finally
      FQuery.SQL.Clear;
    end;

  except
    FQuery.Transaction.Rollback;
  end;
end;

function TControleEndereco.Editar( Value: TEndereco ): Boolean;
begin
  Result := False;

  FQuery.Transaction.StartTransaction;
  try
    try
      FQuery.SQL.Add( 'update ENDERECOS set' );
      FQuery.SQL.Add( 'ID_CLIENTE = :ID_CLIENTE, LOGRADOURO = :LOGRADOURO, NUMERO = :NUMERO, CEP = :CEP, BAIRRO = :BAIRRO, CIDADE = :CIDADE, ESTADO = :ESTADO, PAIS = :PAIS' );
      FQuery.SQL.Add( 'where ID = :ID' );

      FQuery.ParamByName( 'ID' ).AsInteger         := Value.Id;
      FQuery.ParamByName( 'ID_CLIENTE' ).AsInteger := Value.IdCliente;
      FQuery.ParamByName( 'LOGRADOURO' ).AsString  := Value.Logradouro;
      FQuery.ParamByName( 'NUMERO' ).AsString      := Value.Numero;
      FQuery.ParamByName( 'CEP' ).AsString         := Value.Cep;
      FQuery.ParamByName( 'BAIRRO' ).AsString      := Value.Bairro;
      FQuery.ParamByName( 'CIDADE' ).AsString      := Value.Cidade;
      FQuery.ParamByName( 'ESTADO' ).AsString      := Value.Estado;
      FQuery.ParamByName( 'PAIS' ).AsString        := Value.Pais;

      FQuery.ExecSQL;

      if FQuery.RowsAffected > 0 then
      begin
        try
          Result := True;
        finally
          FQuery.Transaction.Commit;
        end;
      end
      else
        FQuery.Transaction.Rollback;

    finally
      FQuery.SQL.Clear;
    end;

  except
    FQuery.Transaction.Rollback;
  end;
end;

function TControleEndereco.Inserir( Value: TEndereco ): Boolean;
begin
  Result := False;

  FQuery.Transaction.StartTransaction;
  try
    try
      FQuery.SQL.Add( 'insert into ENDERECOS' );
      FQuery.SQL.Add( '(ID_CLIENTE, LOGRADOURO, NUMERO, CEP, BAIRRO, CIDADE, ESTADO, PAIS)' );
      FQuery.SQL.Add( 'values' );
      FQuery.SQL.Add( '(:ID_CLIENTE, :LOGRADOURO, :NUMERO, :CEP, :BAIRRO, :CIDADE, :ESTADO, :PAIS)' );
      FQuery.SQL.Add( 'returning id {into :id}' );

      FQuery.ParamByName( 'ID_CLIENTE' ).AsInteger := Value.IdCliente;
      FQuery.ParamByName( 'LOGRADOURO' ).AsString  := Value.Logradouro;
      FQuery.ParamByName( 'NUMERO' ).AsString      := Value.Numero;
      FQuery.ParamByName( 'CEP' ).AsString         := Value.Cep;
      FQuery.ParamByName( 'BAIRRO' ).AsString      := Value.Bairro;
      FQuery.ParamByName( 'CIDADE' ).AsString      := Value.Cidade;
      FQuery.ParamByName( 'ESTADO' ).AsString      := Value.Estado;
      FQuery.ParamByName( 'PAIS' ).AsString        := Value.Pais;

      FQuery.ExecSQL;

      if FQuery.RowsAffected > 0 then
      begin
        Value.Id := FQuery.ParamByName( 'id' ).AsInteger;
        try
          Result := True;
        finally
          FQuery.Transaction.Commit;
        end;
      end
      else
        FQuery.Transaction.Rollback;

    finally
      FQuery.SQL.Clear;
    end;

  except
    FQuery.Transaction.Rollback;
  end;
end;

end.
