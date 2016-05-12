{*********************************************}
{  TeeBI Software Library                     }
{  Query Editor Dialog                        }
{  Copyright (c) 2015-2016 by Steema Software }
{  All Rights Reserved                        }
{*********************************************}
unit BI.VCL.Editor.Query;

interface

{
  This form is used to edit a TBIQuery (pivot-table) component.

  Data can be drag-dropped from the left tree to the Rows, Columns or Measures
  listboxes.

  The listboxes can also be drag-dropped to reorder elements or to move items
  from one list to another.

}

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, BI.VCL.Grid, Vcl.ComCtrls,
  BI.Data, BI.Summary, BI.DataSource, BI.VCL.DataSelect, Vcl.StdCtrls, BI.Query,
  VCL.CheckLst, Vcl.Buttons, BI.VCL.DataControl, BI.Persist,
  BI.Expression;

type
  TBIQueryEditor = class(TForm)
    PanelSelector: TPanel;
    PanelEdit: TPanel;
    BIGrid1: TBIGrid;
    Splitter1: TSplitter;
    SplitterSelector: TSplitter;
    PanelRows: TPanel;
    PanelColumns: TPanel;
    PanelMeasures: TPanel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    ListRows: TCheckListBox;
    ListMeasures: TCheckListBox;
    ListColumns: TCheckListBox;
    Panel4: TPanel;
    CBDistinct: TCheckBox;
    Panel5: TPanel;
    Panel7: TPanel;
    BDeleteColumn: TButton;
    PageMeasures: TPageControl;
    TabMeasure: TTabSheet;
    CBAggregate: TComboBox;
    CBMissingAsZero: TCheckBox;
    TabCalc: TTabSheet;
    RGRunning: TRadioGroup;
    CBRunningRows: TCheckBox;
    RGPercentage: TRadioGroup;
    TabMeasureInfo: TTabSheet;
    Label4: TLabel;
    LabelMeasureKind: TLabel;
    Label5: TLabel;
    LMeasureError: TLabel;
    EMeasureExpression: TEdit;
    CBRemoveRows: TCheckBox;
    CBRemoveCols: TCheckBox;
    PanelButtons: TPanel;
    Panel9: TPanel;
    BOK: TButton;
    Button1: TButton;
    LMax: TLabel;
    EMax: TEdit;
    PanelFilter: TPanel;
    EFilter: TEdit;
    CBFilter: TCheckBox;
    Label1: TLabel;
    BDeleteMeasure: TButton;
    Label2: TLabel;
    BDeleteRow: TButton;
    PageOptions: TPageControl;
    TabItem: TTabSheet;
    TabMeasureOptions: TTabSheet;
    Label3: TLabel;
    CBDatePart: TComboBox;
    GBHistogram: TGroupBox;
    CBHistoActive: TCheckBox;
    SBRowUp: TSpeedButton;
    SBRowDown: TSpeedButton;
    SBMeasureUp: TSpeedButton;
    SBMeasureDown: TSpeedButton;
    SBColUp: TSpeedButton;
    SBColDown: TSpeedButton;
    LFilterError: TLabel;
    Label6: TLabel;
    EBins: TEdit;
    UDBins: TUpDown;
    BIQuery1: TBIQuery;
    SBSwap: TSpeedButton;
    SBSelector: TSpeedButton;
    Label7: TLabel;
    ETitle: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure ListRowsDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure ListRowsDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure ListRowsClick(Sender: TObject);
    procedure BDeleteRowClick(Sender: TObject);
    procedure CBDistinctClick(Sender: TObject);
    procedure BDeleteMeasureClick(Sender: TObject);
    procedure ListMeasuresClick(Sender: TObject);
    procedure ListColumnsClick(Sender: TObject);
    procedure BDeleteColumnClick(Sender: TObject);
    procedure CBAggregateChange(Sender: TObject);
    procedure CBMissingAsZeroClick(Sender: TObject);
    procedure RGPercentageClick(Sender: TObject);
    procedure RGRunningClick(Sender: TObject);
    procedure CBRunningRowsClick(Sender: TObject);
    procedure EMeasureExpressionChange(Sender: TObject);
    procedure CBRemoveRowsClick(Sender: TObject);
    procedure CBRemoveColsClick(Sender: TObject);
    procedure CBDatePartChange(Sender: TObject);
    procedure ListMeasuresDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure ListRowsClickCheck(Sender: TObject);
    procedure EMaxChange(Sender: TObject);
    procedure EFilterChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure BOKClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CBFilterClick(Sender: TObject);
    procedure CBHistoActiveClick(Sender: TObject);
    procedure SBRowUpClick(Sender: TObject);
    procedure SBRowDownClick(Sender: TObject);
    procedure SBMeasureDownClick(Sender: TObject);
    procedure SBMeasureUpClick(Sender: TObject);
    procedure SBColUpClick(Sender: TObject);
    procedure SBColDownClick(Sender: TObject);
    procedure EBinsChange(Sender: TObject);
    procedure SBSwapClick(Sender: TObject);
    procedure SBSelectorClick(Sender: TObject);
    procedure ETitleChange(Sender: TObject);
  private
    { Private declarations }

    IQuery : TBIQuery;

    CompTree,
    DataTree : TTreeView;

    IModified : Boolean;

    ICurrent : TQueryItem;

    function AddData(const AList:TCheckListBox; const AData:TDataItem; const IsActive:Boolean=True):TQueryItem;
    procedure AddItem(const AList:TCheckListBox; const AItem:TQueryItem);
    procedure ChangeItem(const AList:TCheckListBox);
    function ChangingQuery:Boolean;
    procedure DeleteItem(const AList:TCheckListBox);
    procedure DoExchangeItem(const AList:TCheckListBox; const A,B:Integer); overload;
    procedure DoExchangeItem(const AList:TCheckListBox; const Delta:Integer); overload;

    procedure EnableHistogramControls;
    procedure EnableColumnButtons;
    procedure EnableMeasureButtons;
    procedure EnableRowButtons;
    procedure EnableRowSettings;
    procedure EnableSwap;
    procedure FilterComponent(Sender: TComponent; var Valid:Boolean);
    function ListOf(const ABy:TGroupBy):TCheckListBox;
    function Measure:TMeasure;
    procedure Modified;
    procedure RemoveFromList(const AList:TCheckListBox);
    procedure SetByProperties(const ACurrent:TQueryItem);
    procedure SetMeasureProperties(const ACurrent:TQueryItem);
    procedure SetPart(const ACombo:TComboBox; const APart:TDateTimePart);
  public
    { Public declarations }

    Selector : TDataSelector;

    class function Edit(const AOwner:TComponent; const AQuery:TBIQuery):Boolean; static;
    class function Embedd(const AOwner: TComponent; const AParent: TWinControl): TBIQueryEditor; static;

    procedure Refresh(const AQuery:TBIQuery);
  end;

implementation
