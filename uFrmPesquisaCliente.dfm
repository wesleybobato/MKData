object FrmPesquisaCliente: TFrmPesquisaCliente
  Left = 0
  Top = 0
  Caption = 'Pesquisa de Clientes'
  ClientHeight = 379
  ClientWidth = 803
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object dbgClientes: TDBGrid
    Left = 0
    Top = 57
    Width = 803
    Height = 272
    Align = alClient
    DataSource = dsClientes
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
        FieldName = 'ATIVO'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TIPO_PESSOA'
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CPF'
        Width = 95
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CNPJ'
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'RG'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'IE'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATA'
        Width = 70
        Visible = True
      end>
  end
  object pnClientes: TPanel
    Left = 0
    Top = 0
    Width = 803
    Height = 57
    Align = alTop
    TabOrder = 1
    object Label1: TLabel
      Left = 7
      Top = 4
      Width = 33
      Height = 13
      Caption = 'Campo'
    end
    object Label2: TLabel
      Left = 158
      Top = 4
      Width = 42
      Height = 13
      Caption = 'Pesquisa'
    end
    object cbxCampo: TComboBox
      Left = 7
      Top = 23
      Width = 145
      Height = 21
      Style = csDropDownList
      TabOrder = 0
    end
    object edtPesquisa: TEdit
      Left = 158
      Top = 23
      Width = 499
      Height = 21
      MaxLength = 50
      TabOrder = 1
    end
    object btnFiltrar: TButton
      AlignWithMargins = True
      Left = 724
      Top = 4
      Width = 75
      Height = 49
      Align = alRight
      Caption = 'Filtrar'
      TabOrder = 2
      OnClick = btnFiltrarClick
      ExplicitHeight = 42
    end
    object chkAtivos: TCheckBox
      Left = 547
      Top = 3
      Width = 110
      Height = 17
      Caption = 'Somente Ativos?'
      TabOrder = 3
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 329
    Width = 803
    Height = 50
    Align = alBottom
    TabOrder = 2
    object btnIncluir: TButton
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 75
      Height = 42
      Align = alLeft
      Caption = 'Incluir'
      TabOrder = 0
      OnClick = btnIncluirClick
    end
    object btnAlterar: TButton
      AlignWithMargins = True
      Left = 85
      Top = 4
      Width = 75
      Height = 42
      Align = alLeft
      Caption = 'Alterar'
      TabOrder = 1
      OnClick = btnAlterarClick
    end
    object btnEccluir: TButton
      AlignWithMargins = True
      Left = 166
      Top = 4
      Width = 75
      Height = 42
      Align = alLeft
      Caption = 'Excluir'
      TabOrder = 2
      OnClick = btnEccluirClick
    end
  end
  object tblClientes: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 688
    Top = 208
    object tblClientesID: TIntegerField
      FieldName = 'ID'
      Visible = False
    end
    object tblClientesATIVO: TStringField
      DisplayLabel = 'Ativo'
      FieldName = 'ATIVO'
      Visible = False
      Size = 10
    end
    object tblClientesNOME: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'NOME'
      Size = 50
    end
    object tblClientesTIPO_PESSOA: TStringField
      DisplayLabel = 'Tipo de Pessoa'
      FieldName = 'TIPO_PESSOA'
      Size = 8
    end
    object tblClientesCPF: TStringField
      FieldName = 'CPF'
      EditMask = '999.999.999-99;0;_'
      Size = 11
    end
    object tblClientesCNPJ: TStringField
      FieldName = 'CNPJ'
      EditMask = '99.999.999/9999-99;0;_'
      Size = 14
    end
    object tblClientesRG: TStringField
      FieldName = 'RG'
      EditMask = '9.999.999-9;0;_'
      Size = 8
    end
    object tblClientesIE: TStringField
      FieldName = 'IE'
      EditMask = '99.999.999-9;0;_'
      Size = 9
    end
    object tblClientesDATA: TDateField
      DisplayLabel = 'Data'
      FieldName = 'DATA'
    end
  end
  object dsClientes: TDataSource
    DataSet = tblClientes
    Left = 688
    Top = 264
  end
end
