object FrmCadastroCliente: TFrmCadastroCliente
  Left = 0
  Top = 0
  Caption = 'Cadastro de Cliente'
  ClientHeight = 481
  ClientWidth = 794
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 17
    Width = 27
    Height = 13
    Caption = 'Nome'
  end
  object Label2: TLabel
    Left = 8
    Top = 70
    Width = 19
    Height = 13
    Caption = 'CPF'
  end
  object Label3: TLabel
    Left = 147
    Top = 70
    Width = 25
    Height = 13
    Caption = 'CNPJ'
  end
  object Label4: TLabel
    Left = 320
    Top = 70
    Width = 14
    Height = 13
    Caption = 'RG'
  end
  object Label5: TLabel
    Left = 448
    Top = 70
    Width = 10
    Height = 13
    Caption = 'IE'
  end
  object Label6: TLabel
    Left = 596
    Top = 70
    Width = 85
    Height = 13
    Caption = 'Data de Cadastro'
  end
  object edtNome: TEdit
    Left = 8
    Top = 36
    Width = 569
    Height = 21
    MaxLength = 50
    TabOrder = 0
  end
  object rdgTipoPessoa: TRadioGroup
    Left = 596
    Top = 8
    Width = 185
    Height = 49
    Caption = 'Tipo de Pessoa'
    Columns = 2
    Items.Strings = (
      'Fisica'
      'Juridica')
    TabOrder = 1
    OnClick = rdgTipoPessoaClick
  end
  object chkAtivo: TCheckBox
    Left = 528
    Top = 14
    Width = 49
    Height = 17
    Caption = 'Ativo'
    TabOrder = 2
  end
  object edtCPF: TMaskEdit
    Left = 8
    Top = 89
    Width = 119
    Height = 21
    EditMask = '999.999.999-99;0;_'
    MaxLength = 14
    TabOrder = 3
    Text = ''
  end
  object edtCNPJ: TMaskEdit
    Left = 147
    Top = 89
    Width = 151
    Height = 21
    EditMask = '99.999.999/9999-99;0;_'
    MaxLength = 18
    TabOrder = 4
    Text = ''
  end
  object edtRG: TMaskEdit
    Left = 320
    Top = 89
    Width = 112
    Height = 21
    EditMask = '9.999.999-9;0;_'
    MaxLength = 11
    TabOrder = 5
    Text = ''
  end
  object edtIE: TMaskEdit
    Left = 448
    Top = 89
    Width = 128
    Height = 21
    EditMask = '99.999.999-9;0;_'
    MaxLength = 12
    TabOrder = 6
    Text = ''
  end
  object edtData: TDateTimePicker
    Left = 596
    Top = 89
    Width = 85
    Height = 21
    Date = 44839.430635555550000000
    Time = 44839.430635555550000000
    TabOrder = 7
  end
  object pnlAcoes: TPanel
    Left = 0
    Top = 431
    Width = 794
    Height = 50
    Align = alBottom
    TabOrder = 8
    object btnSalvar: TButton
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 75
      Height = 42
      Align = alLeft
      Caption = 'Salvar'
      TabOrder = 0
      OnClick = btnSalvarClick
    end
    object btnCancelar: TButton
      AlignWithMargins = True
      Left = 85
      Top = 4
      Width = 75
      Height = 42
      Align = alLeft
      Caption = 'Cancelar'
      TabOrder = 1
      OnClick = btnCancelarClick
    end
  end
  object pgcItems: TPageControl
    Left = 0
    Top = 128
    Width = 794
    Height = 303
    ActivePage = tbsEnderecos
    Align = alBottom
    TabOrder = 9
    object tbsEnderecos: TTabSheet
      Caption = 'Endere'#231'os'
      object Label7: TLabel
        Left = 4
        Top = 2
        Width = 19
        Height = 13
        Caption = 'CEP'
      end
      object Label8: TLabel
        Left = 248
        Top = 2
        Width = 55
        Height = 13
        Caption = 'Logradouro'
      end
      object Label9: TLabel
        Left = 590
        Top = 4
        Width = 37
        Height = 13
        Caption = 'Numero'
      end
      object Label10: TLabel
        Left = 4
        Top = 50
        Width = 28
        Height = 13
        Caption = 'Bairro'
      end
      object Label11: TLabel
        Left = 183
        Top = 50
        Width = 33
        Height = 13
        Caption = 'Cidade'
      end
      object Label12: TLabel
        Left = 407
        Top = 50
        Width = 33
        Height = 13
        Caption = 'Estado'
      end
      object Label13: TLabel
        Left = 560
        Top = 50
        Width = 19
        Height = 13
        Caption = 'Pais'
      end
      object dbgEnderecos: TDBGrid
        Left = 0
        Top = 135
        Width = 786
        Height = 140
        Align = alBottom
        DataSource = dsEnderecos
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'LOGRADOURO'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NUMERO'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CEP'
            Width = 70
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'BAIRRO'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CIDADE'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ESTADO'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'PAIS'
            Visible = True
          end>
      end
      object edtCEP: TMaskEdit
        Left = 4
        Top = 21
        Width = 145
        Height = 21
        EditMask = '99999.999;0;_'
        MaxLength = 9
        TabOrder = 1
        Text = ''
      end
      object btnViaCep: TButton
        AlignWithMargins = True
        Left = 156
        Top = 19
        Width = 85
        Height = 25
        Caption = 'API Viacep'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        OnClick = btnViaCepClick
      end
      object edtLogradouro: TEdit
        Left = 248
        Top = 21
        Width = 325
        Height = 21
        MaxLength = 50
        TabOrder = 3
      end
      object edtNumero: TEdit
        Left = 590
        Top = 21
        Width = 97
        Height = 21
        MaxLength = 10
        TabOrder = 4
      end
      object edtBairro: TEdit
        Left = 4
        Top = 69
        Width = 158
        Height = 21
        MaxLength = 50
        TabOrder = 5
      end
      object edtCidade: TEdit
        Left = 183
        Top = 69
        Width = 205
        Height = 21
        MaxLength = 50
        TabOrder = 6
      end
      object edtEstado: TEdit
        Left = 407
        Top = 69
        Width = 136
        Height = 21
        MaxLength = 30
        TabOrder = 7
      end
      object edtPais: TEdit
        Left = 560
        Top = 69
        Width = 127
        Height = 21
        MaxLength = 50
        TabOrder = 8
      end
      object pnlBotoesEndereco: TPanel
        Left = 698
        Top = 0
        Width = 88
        Height = 135
        Align = alRight
        TabOrder = 9
        object btnExcluirEndereco: TButton
          AlignWithMargins = True
          Left = 4
          Top = 56
          Width = 80
          Height = 20
          Align = alTop
          Caption = 'Excluir'
          TabOrder = 0
          OnClick = btnExcluirEnderecoClick
        end
        object btnAlterarEndereco: TButton
          AlignWithMargins = True
          Left = 4
          Top = 30
          Width = 80
          Height = 20
          Align = alTop
          Caption = 'Alterar'
          TabOrder = 1
          OnClick = btnAlterarEnderecoClick
        end
        object btnIncluirEndereco: TButton
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 80
          Height = 20
          Align = alTop
          Caption = 'Incluir'
          TabOrder = 2
          OnClick = btnIncluirEnderecoClick
        end
        object btnSalvarEndereco: TButton
          AlignWithMargins = True
          Left = 4
          Top = 108
          Width = 80
          Height = 20
          Align = alTop
          Caption = 'Salvar'
          TabOrder = 3
          OnClick = btnSalvarEnderecoClick
        end
        object btnCancelarEndereco: TButton
          AlignWithMargins = True
          Left = 4
          Top = 82
          Width = 80
          Height = 20
          Align = alTop
          Caption = 'Cancelar'
          TabOrder = 4
          OnClick = btnCancelarEnderecoClick
        end
      end
    end
    object tbsTelefones: TTabSheet
      Caption = 'Telefones'
      ImageIndex = 1
      object Label14: TLabel
        Left = 4
        Top = 2
        Width = 21
        Height = 13
        Caption = 'DDD'
      end
      object Label16: TLabel
        Left = 70
        Top = 2
        Width = 37
        Height = 13
        Caption = 'N'#250'mero'
      end
      object dbgTelefones: TDBGrid
        Left = 0
        Top = 135
        Width = 786
        Height = 140
        Align = alBottom
        DataSource = dsTelefones
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'DDD'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'TELEFONE'
            Visible = True
          end>
      end
      object Panel3: TPanel
        Left = 698
        Top = 0
        Width = 88
        Height = 135
        Align = alRight
        TabOrder = 1
        object btnExcluirTelefone: TButton
          AlignWithMargins = True
          Left = 4
          Top = 56
          Width = 80
          Height = 20
          Align = alTop
          Caption = 'Excluir'
          TabOrder = 0
          OnClick = btnExcluirTelefoneClick
        end
        object btnAlterarTelefone: TButton
          AlignWithMargins = True
          Left = 4
          Top = 30
          Width = 80
          Height = 20
          Align = alTop
          Caption = 'Alterar'
          TabOrder = 1
          OnClick = btnAlterarTelefoneClick
        end
        object btnIncluirTelefone: TButton
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 80
          Height = 20
          Align = alTop
          Caption = 'Incluir'
          TabOrder = 2
          OnClick = btnIncluirTelefoneClick
        end
        object btnSalvarTelefone: TButton
          AlignWithMargins = True
          Left = 4
          Top = 108
          Width = 80
          Height = 20
          Align = alTop
          Caption = 'Salvar'
          TabOrder = 3
          OnClick = btnSalvarTelefoneClick
        end
        object btnCancelarTelefone: TButton
          AlignWithMargins = True
          Left = 4
          Top = 82
          Width = 80
          Height = 20
          Align = alTop
          Caption = 'Cancelar'
          TabOrder = 4
          OnClick = btnCancelarTelefoneClick
        end
      end
      object edtDDD: TMaskEdit
        Left = 4
        Top = 21
        Width = 48
        Height = 21
        EditMask = '(099);0;_'
        MaxLength = 5
        TabOrder = 2
        Text = ''
      end
      object edtTelefone: TMaskEdit
        Left = 70
        Top = 21
        Width = 130
        Height = 21
        EditMask = '9.9999.9999;0;_'
        MaxLength = 11
        TabOrder = 3
        Text = ''
      end
    end
  end
  object dsTelefones: TDataSource
    DataSet = tblTelefones
    Left = 439
    Top = 432
  end
  object dsEnderecos: TDataSource
    DataSet = tblEnderecos
    Left = 502
    Top = 432
  end
  object tblTelefones: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 559
    Top = 432
    object tblTelefonesID: TIntegerField
      FieldName = 'ID'
      Visible = False
    end
    object tblTelefonesID_CLIENTE: TIntegerField
      FieldName = 'ID_CLIENTE'
      Visible = False
    end
    object tblTelefonesDDD: TStringField
      FieldName = 'DDD'
      Size = 3
    end
    object tblTelefonesTELEFONE: TStringField
      DisplayLabel = 'Telefone'
      FieldName = 'TELEFONE'
      Size = 9
    end
  end
  object tblEnderecos: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 615
    Top = 432
    object tblEnderecosID: TIntegerField
      FieldName = 'ID'
      Visible = False
    end
    object tblEnderecosID_CLIENTE: TIntegerField
      FieldName = 'ID_CLIENTE'
      Visible = False
    end
    object tblEnderecosLOGRADOURO: TStringField
      DisplayLabel = 'Logradouro'
      FieldName = 'LOGRADOURO'
      Size = 50
    end
    object tblEnderecosNUMERO: TStringField
      DisplayLabel = 'N'#250'mero'
      FieldName = 'NUMERO'
      Size = 10
    end
    object tblEnderecosCEP: TStringField
      FieldName = 'CEP'
      EditMask = '99999.999;0;_'
      Size = 8
    end
    object tblEnderecosBAIRRO: TStringField
      DisplayLabel = 'Bairro'
      FieldName = 'BAIRRO'
      Size = 50
    end
    object tblEnderecosCIDADE: TStringField
      DisplayLabel = 'Cidade'
      FieldName = 'CIDADE'
      Size = 50
    end
    object tblEnderecosESTADO: TStringField
      DisplayLabel = 'Estado'
      FieldName = 'ESTADO'
      Size = 30
    end
    object tblEnderecosPAIS: TStringField
      DisplayLabel = 'Pa'#237's'
      FieldName = 'PAIS'
      Size = 50
    end
  end
  object RESTClient1: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'UTF-8, *;q=0.8'
    Params = <>
    HandleRedirects = True
    RaiseExceptionOn500 = False
    Left = 311
    Top = 432
  end
  object RESTRequest1: TRESTRequest
    Client = RESTClient1
    Params = <>
    Response = RESTResponse1
    SynchronizedEvents = False
    Left = 255
    Top = 432
  end
  object RESTResponse1: TRESTResponse
    ContentType = 'application/json'
    Left = 375
    Top = 432
  end
end
