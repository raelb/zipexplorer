object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'Zip Explorer'
  ClientHeight = 414
  ClientWidth = 675
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 185
    Top = 26
    Width = 6
    Height = 388
    ExplicitHeight = 389
  end
  object Splitter2: TSplitter
    Left = 457
    Top = 26
    Width = 6
    Height = 388
    ExplicitLeft = 433
    ExplicitHeight = 389
  end
  object SpTBXDock1: TSpTBXDock
    Left = 0
    Top = 0
    Width = 675
    Height = 26
    object SpTBXToolbar1: TSpTBXToolbar
      Left = 0
      Top = 0
      CloseButton = False
      FullSize = True
      ProcessShortCuts = True
      ShrinkMode = tbsmWrap
      Stretch = True
      TabOrder = 0
      Customizable = False
      MenuBar = True
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 26
    Width = 185
    Height = 388
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 1
    object PageControl1: TRzPageControl
      Left = 0
      Top = 0
      Width = 185
      Height = 388
      Hint = ''
      ActivePage = tsArchive
      Align = alClient
      ShowCardFrame = False
      ShowShadow = False
      TabIndex = 1
      TabOrder = 0
      TabOrientation = toBottom
      FixedDimension = 19
      object tsFolder: TRzTabSheet
        Caption = 'Folder'
        ExplicitWidth = 0
        ExplicitHeight = 0
        object FolderPanel: TPanel
          Left = 0
          Top = 0
          Width = 185
          Height = 25
          Align = alTop
          Caption = 'Folder'
          TabOrder = 0
          ExplicitTop = 8
        end
      end
      object tsArchive: TRzTabSheet
        Caption = 'Archive'
        object ArchivePanel: TPanel
          Left = 0
          Top = 0
          Width = 185
          Height = 25
          Cursor = crHandPoint
          Align = alTop
          Caption = 'Open Archive'
          TabOrder = 0
          OnClick = actOpenExecute
        end
        object AbTreeView: TAbTreeView
          Left = 0
          Top = 25
          Width = 185
          Height = 344
          Align = alClient
          BorderStyle = bsNone
          Indent = 19
          TabOrder = 1
          Items.NodeData = {
            0301000000200000000000000000000000FFFFFFFFFFFFFFFF00000000000000
            000000000001015C00}
          Archive = AbUnZipper
          ListView = AbListView
        end
      end
    end
  end
  object RightPanel: TPanel
    Left = 463
    Top = 26
    Width = 212
    Height = 388
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object PageControl2: TRzPageControl
      Left = 0
      Top = 0
      Width = 212
      Height = 388
      Hint = ''
      ActivePage = tsEditor
      Align = alClient
      ShowCardFrame = False
      TabIndex = 0
      TabOrder = 0
      TabOrientation = toBottom
      FixedDimension = 19
      object tsEditor: TRzTabSheet
        Caption = 'Editor'
        object Editor: TTextEditor
          Left = 0
          Top = 0
          Width = 212
          Height = 369
          Align = alClient
          BorderStyle = bsNone
          LeftMargin.Width = 55
          TabOrder = 0
          WordWrap.Indicator.MaskColor = clFuchsia
        end
      end
      object tsImage: TRzTabSheet
        Caption = 'Image'
        ExplicitWidth = 0
        ExplicitHeight = 0
      end
    end
  end
  object MiddlePanel: TPanel
    Left = 191
    Top = 26
    Width = 266
    Height = 388
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 3
    object AbListView: TAbListView
      Left = 0
      Top = 0
      Width = 266
      Height = 388
      Align = alClient
      Archive = AbUnZipper
      BorderStyle = bsNone
      TabOrder = 0
      TreeView = AbTreeView
      ViewStyle = vsReport
      VisibleColumns = [vcName, vcSize, vcRatio, vcPacked, vcAttributes, vcEncrypted, vcMethod, vcPath]
      OnSelectItem = AbListViewSelectItem
    end
  end
  object AbUnZipper: TAbUnZipper
    Left = 80
    Top = 112
  end
  object FormStorage1: TFormStorage
    StoredProps.Strings = (
      'Panel1.Width'
      'MiddlePanel.Width')
    StoredValues = <>
    Left = 312
    Top = 208
  end
  object ActionList1: TActionList
    Left = 80
    Top = 168
    object actOpen: TAction
      Caption = 'Open'
      ShortCut = 16463
      OnExecute = actOpenExecute
    end
  end
  object OpenDialog: TOpenDialog
    Filter = 'All Files|*.*|Archive Files|*.zip;*.tar;*.gz;*.tgz;*.bz2;*.tbz'
    Options = [ofEnableSizing]
    Left = 80
    Top = 64
  end
end
