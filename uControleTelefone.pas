unit uControleTelefone;

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
  UTelefone;

type
  TControleTelefone = class
  private
    { Private declarations }
    FQuery:       TFDQuery;
    FTransaction: TFDTransaction;
  public
    { Public declarations }
    constructor Create;
    destructor Destroy; override;

    function Inserir( Value: TTelefone ): Boolean;
    function Editar( Value: TTelefone ): Boolean;
    function Deletar( const Value: TDictionary< string, string > ): Boolean;
    function Consultar( const Value: TDictionary< string, string > ): TObjectList< TTelefone >;
  end;

implementation

{ TControleTelefone }

constructor TControleTelefone.Create;
begin
  inherited Create;
  FTransaction            := TFDTransaction.Create( nil );
  FTransaction.Connection := DmBanco.FDConnection;

  FQuery             := TFDQuery.Create( nil );
  FQuery.Connection  := DmBanco.FDConnection;
  FQuery.Transaction := FTransaction;
end;

destructor TControleTelefone.Destroy;
begin
  FQuery.Free;
  FTransaction.Free;
  inherited Destroy;
end;

function TControleTelefone.Consultar( const Value: TDictionary< string, string > ): TObjectList< TTelefone >;
var
  Item:      TPair< string, string >;
  Telefone:  TTelefone;
  Iteration: Boolean;
begin
  Result := TObjectList< TTelefone >.Create;

  FQuery.Transaction.StartTransaction;
  try
    try
      FQuery.SQL.Add( 'select * from TELEFONES' );

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
          Telefone           := TTelefone.Create;
          Telefone.Id        := FQuery.FieldByName( 'ID' ).AsInteger;
          Telefone.IdCliente := FQuery.FieldByName( 'ID_CLIENTE' ).AsInteger;
          Telefone.DDD       := FQuery.FieldByName( 'DDD' ).AsString;
          Telefone.Telefone  := FQuery.FieldByName( 'TELEFONE' ).AsString;

          Result.Add( Telefone );
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

function TControleTelefone.Deletar( const Value: TDictionary< string, string > ): Boolean;
var
  Item:      TPair< string, string >;
  Iteration: Boolean;
begin
  Result := False;

  FQuery.Transaction.StartTransaction;
  try
    try
      FQuery.SQL.Add( 'delete from TELEFONES' );

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

function TControleTelefone.Editar( Value: TTelefone ): Boolean;
begin
  Result := False;

  FQuery.Transaction.StartTransaction;
  try
    try
      FQuery.SQL.Add( 'update TELEFONES set' );
      FQuery.SQL.Add( 'ID_CLIENTE = :ID_CLIENTE, DDD = :DDD, TELEFONE = :TELEFONE' );
      FQuery.SQL.Add( 'where ID = :ID' );

      FQuery.ParamByName( 'ID' ).AsInteger         := Value.Id;
      FQuery.ParamByName( 'ID_CLIENTE' ).AsInteger := Value.IdCliente;
      FQuery.ParamByName( 'DDD' ).AsString         := Value.DDD;
      FQuery.ParamByName( 'TELEFONE' ).AsString    := Value.Telefone;

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

function TControleTelefone.Inserir( Value: TTelefone ): Boolean;
begin
  Result := False;

  FQuery.Transaction.StartTransaction;
  try
    try
      FQuery.SQL.Add( 'insert into TELEFONES' );
      FQuery.SQL.Add( '(ID_CLIENTE, DDD, TELEFONE)' );
      FQuery.SQL.Add( 'values' );
      FQuery.SQL.Add( '(:ID_CLIENTE, :DDD, :TELEFONE)' );
      FQuery.SQL.Add( 'returning id {into :id}' );

      FQuery.ParamByName( 'ID_CLIENTE' ).AsInteger := Value.IdCliente;
      FQuery.ParamByName( 'DDD' ).AsString         := Value.DDD;
      FQuery.ParamByName( 'TELEFONE' ).AsString    := Value.Telefone;

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
