object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 243
  ClientWidth = 527
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 256
    Top = 136
    Width = 31
    Height = 13
    Caption = 'Label1'
  end
  object GTPaintBox1: TGTPaintBox
    Left = 88
    Top = 24
    Width = 281
    Height = 185
    OnPaint = GTPaintBox1Paint
    OnKeyPress = GTPaintBox1KeyPress
  end
  object Edit1: TEdit
    Left = 384
    Top = 40
    Width = 121
    Height = 21
    TabOrder = 1
    Text = 'Edit1'
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 32
    Top = 88
  end
end
