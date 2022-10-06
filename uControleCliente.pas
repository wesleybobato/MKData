unit uControleCliente;

interface

uses
  // System
  System.Generics.Defaults,
  System.Generics.Collections,

  // Firedac
  FireDAC.Stan.Param,
  FireDAC.Comp.Client,

  // Self
  UDmBanco,
  UCliente;

type
  TControleCliente = class
  private
    { Private declarations }
    FQuery:       TFDQuery;
    FTransaction: TFDTransaction;
  public
    { Public declarations }
    constructor Create;
    destructor Destroy; override;

    function Inserir( Value: TCliente ): Boolean;
    function Editar( Value: TCliente ): Boolean;
    function Deletar( const Value: TDictionary< string, string > ): Boolean;
    function Consultar( const Value: TDictionary< string, string > ): TObjectList< TCliente >;
  end;

implementation

uses
  // System
  System.SysUtils,

  // Self
  UTelefone,
  UEndereco,
  UControleEndereco,
  UControleTelefone;

{ TControleCliente }

constructor TControleCliente.Create;
begin
  inherited Create;

  FTransaction            := TFDTransaction.Create( nil );
  FTransaction.Connection := DmBanco.FDConnection;

  FQuery             := TFDQuery.Create( nil );
  FQuery.Connection  := DmBanco.FDConnection;
  FQuery.Transaction := FTransaction;
end;

destructor TControleCliente.Destroy;
begin
  FQuery.Free;
  FTransaction.Free;
  inherited Destroy;
end;

function TControleCliente.Consultar( const Value: TDictionary< string, string > ): TObjectList< TCliente >;
var
  I:                Integer;
  Item:             TPair< string, string >;
  Cliente:          TCliente;
  Iteration:        Boolean;
  Enderecos:        TObjectList< TEndereco >;
  Telefones:        TObjectList< TTelefone >;
  FiltroEndereco:   TDictionary< string, string >;
  FiltroTelefone:   TDictionary< string, string >;
  ControleTelefone: TControleTelefone;
  ControleEndereco: TControleEndereco;
begin
  Result := TObjectList< TCliente >.Create;

  FQuery.Transaction.StartTransaction;
  try
    try
      FQuery.SQL.Add( 'select * from CLIENTES' );

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
        ControleEndereco := TControleEndereco.Create;
        try
          ControleTelefone := TControleTelefone.Create;
          try
            FQuery.First;
            while not FQuery.Eof do
            begin
              Cliente            := TCliente.Create;
              Cliente.Id         := FQuery.FieldByName( 'ID' ).AsInteger;
              Cliente.Nome       := FQuery.FieldByName( 'NOME' ).AsString;
              Cliente.TipoPessoa := TTipoPessoa( FQuery.FieldByName( 'TIPO_PESSOA' ).AsInteger );
              Cliente.CPF        := FQuery.FieldByName( 'CPF' ).AsString;
              Cliente.CNPJ       := FQuery.FieldByName( 'CNPJ' ).AsString;
              Cliente.RG         := FQuery.FieldByName( 'RG' ).AsString;
              Cliente.IE         := FQuery.FieldByName( 'IE' ).AsString;
              Cliente.Data       := FQuery.FieldByName( 'DATA' ).AsDateTime;
              Cliente.Ativo      := FQuery.FieldByName( 'ATIVO' ).AsBoolean;

              FiltroEndereco := TDictionary< string, string >.Create;
              try
                FiltroEndereco.Add( 'ID_CLIENTE', IntToStr( Cliente.Id ) );

                Enderecos := ControleEndereco.Consultar( FiltroEndereco );
                try
                  for I := Enderecos.Count - 1 downto 0 do
                    Cliente.Enderecos.Add( Enderecos.Extract( Enderecos.Items[ I ] ) );
                finally
                  Enderecos.Free;
                end;
              finally
                FiltroEndereco.Free;
              end;

              FiltroTelefone := TDictionary< string, string >.Create;
              try
                FiltroTelefone.Add( 'ID_CLIENTE', IntToStr( Cliente.Id ) );

                Telefones := ControleTelefone.Consultar( FiltroTelefone );
                try
                  for I := Telefones.Count - 1 downto 0 do
                    Cliente.Telefones.Add( Telefones.Extract( Telefones.Items[ I ] ) );
                finally
                  Telefones.Free;
                end;
              finally
                FiltroTelefone.Free;
              end;

              Result.Add( Cliente );
              FQuery.Next;
            end;

          finally
            ControleTelefone.Free;
          end;

        finally
          ControleEndereco.Free;
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

function TControleCliente.Deletar( const Value: TDictionary< string, string > ): Boolean;
var
  Item:             TPair< string, string >;
  Iteration:        Boolean;
  ControleTelefone: TControleTelefone;
  ControleEndereco: TControleEndereco;
begin
  Result := False;

  FQuery.Transaction.StartTransaction;
  try
    try
      FQuery.SQL.Add( 'delete from CLIENTES' );

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
      begin
        try
          ControleEndereco := TControleEndereco.Create;
          try
            ControleTelefone := TControleTelefone.Create;
            try
              ControleEndereco.Deletar( Value );
              ControleTelefone.Deletar( Value );

              Result := True;
            finally
              ControleTelefone.Free;
            end;
          finally
            ControleEndereco.Free;
          end;
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

function TControleCliente.Editar( Value: TCliente ): Boolean;
var
  I:                Integer;
  Telefone:         TTelefone;
  Endereco:         TEndereco;
  FiltroEndereco:   TDictionary< string, string >;
  FiltroTelefone:   TDictionary< string, string >;
  ControleTelefone: TControleTelefone;
  ControleEndereco: TControleEndereco;
begin
  Result := False;

  FQuery.Transaction.StartTransaction;
  try
    try
      FQuery.SQL.Add( 'update CLIENTES set' );
      FQuery.SQL.Add( 'NOME = :NOME, TIPO_PESSOA = :TIPO_PESSOA, CPF = :CPF, CNPJ = :CNPJ, RG = :RG, IE = :IE, DATA = :DATA, ATIVO = :ATIVO' );
      FQuery.SQL.Add( 'where ID = :ID' );

      FQuery.ParamByName( 'ID' ).AsInteger          := Value.Id;
      FQuery.ParamByName( 'NOME' ).AsString         := Value.Nome;
      FQuery.ParamByName( 'TIPO_PESSOA' ).AsInteger := Ord( Value.TipoPessoa );
      FQuery.ParamByName( 'CPF' ).AsString          := Value.CPF;
      FQuery.ParamByName( 'CNPJ' ).AsString         := Value.CNPJ;
      FQuery.ParamByName( 'RG' ).AsString           := Value.RG;
      FQuery.ParamByName( 'IE' ).AsString           := Value.IE;
      FQuery.ParamByName( 'DATA' ).AsDate           := Value.Data;
      FQuery.ParamByName( 'ATIVO' ).AsBoolean       := Value.Ativo;

      FQuery.ExecSQL;

      if FQuery.RowsAffected > 0 then
      begin
        try
          ControleEndereco := TControleEndereco.Create;
          try
            FiltroEndereco := TDictionary< string, string >.Create;
            try
              FiltroEndereco.Add( 'ID_CLIENTE', Value.Id.ToString );

              if ControleEndereco.Deletar( FiltroEndereco ) then
              begin
                for I := 0 to Value.Enderecos.Count - 1 do
                begin
                  Endereco           := Value.Enderecos.Items[ I ];
                  Endereco.IdCliente := Value.Id;
                  if not ControleEndereco.Inserir( Endereco ) then
                    Exit;
                end;
              end;
            finally
              FiltroEndereco.Free;
            end;
          finally
            ControleEndereco.Free;
          end;

          ControleTelefone := TControleTelefone.Create;
          try
            FiltroTelefone := TDictionary< string, string >.Create;
            try
              FiltroTelefone.Add( 'ID_CLIENTE', Value.Id.ToString );

              if ControleTelefone.Deletar( FiltroTelefone ) then
              begin
                for I := 0 to Value.Telefones.Count - 1 do
                begin
                  Telefone           := Value.Telefones.Items[ I ];
                  Telefone.IdCliente := Value.Id;
                  if not ControleTelefone.Inserir( Telefone ) then
                    Exit;
                end;
              end;
            finally
              FiltroTelefone.Free;
            end;
          finally
            ControleTelefone.Free;
          end;

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

function TControleCliente.Inserir( Value: TCliente ): Boolean;
var
  I:                Integer;
  Telefone:         TTelefone;
  Endereco:         TEndereco;
  ControleTelefone: TControleTelefone;
  ControleEndereco: TControleEndereco;
begin
  Result := False;

  FQuery.Transaction.StartTransaction;
  try
    try
      FQuery.SQL.Add( 'insert into CLIENTES' );
      FQuery.SQL.Add( '(NOME, TIPO_PESSOA, CPF, CNPJ, RG, IE, DATA, ATIVO)' );
      FQuery.SQL.Add( 'values' );
      FQuery.SQL.Add( '(:NOME, :TIPO_PESSOA, :CPF, :CNPJ, :RG, :IE, :DATA, :ATIVO)' );
      FQuery.SQL.Add( 'returning id {into :id}' );
      // https://docwiki.embarcadero.com/RADStudio/Sydney/en/RETURNING_Unified_Support_(FireDAC)

      FQuery.ParamByName( 'NOME' ).AsString         := Value.Nome;
      FQuery.ParamByName( 'TIPO_PESSOA' ).AsInteger := Ord( Value.TipoPessoa );
      FQuery.ParamByName( 'CPF' ).AsString          := Value.CPF;
      FQuery.ParamByName( 'CNPJ' ).AsString         := Value.CNPJ;
      FQuery.ParamByName( 'RG' ).AsString           := Value.RG;
      FQuery.ParamByName( 'IE' ).AsString           := Value.IE;
      FQuery.ParamByName( 'DATA' ).AsDate           := Value.Data;
      FQuery.ParamByName( 'ATIVO' ).AsBoolean       := Value.Ativo;

      FQuery.ExecSQL;

      if FQuery.RowsAffected > 0 then
      begin
        Value.Id := FQuery.ParamByName( 'id' ).AsInteger;
        try

          if Value.Enderecos.Count > 0 then
          begin
            ControleEndereco := TControleEndereco.Create;
            try
              for I := 0 to Value.Enderecos.Count - 1 do
              begin
                Endereco           := Value.Enderecos.Items[ I ];
                Endereco.IdCliente := Value.Id;
                if not ControleEndereco.Inserir( Endereco ) then
                  Exit;
              end;
            finally
              ControleEndereco.Free;
            end;
          end;

          if Value.Telefones.Count > 0 then
          begin
            ControleTelefone := TControleTelefone.Create;
            try
              for I := 0 to Value.Telefones.Count - 1 do
              begin
                Telefone           := Value.Telefones.Items[ I ];
                Telefone.IdCliente := Value.Id;
                if not ControleTelefone.Inserir( Telefone ) then
                  Exit;
              end;
            finally
              ControleTelefone.Free;
            end;
          end;

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
