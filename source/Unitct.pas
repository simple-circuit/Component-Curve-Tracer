unit Unitct;

{$MODE Delphi}

{MIT License

Copyright (c) 2019 simple-circuit

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE. }


//{$DEFINE pi3}  //comment out for windows 10 compile
{$DEFINE win10}
//Windows(R) uses native serial port calls to improve data transfer speed
//native windows serial functions allow for test of an active port


interface

{$ifdef pi3}
uses
  SysUtils, LCLIntf, LCLType, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Menus, Spin, Buttons, Clipbrd, math,
  ComCtrls, printers, Grids, PrintersDlgs, serial, strutils;
{$else}

uses
  windows,LCLIntf, LCLType, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Menus, Spin, Buttons, Clipbrd, math,
  printers, Grids, ComCtrls, Arrow, PrintersDlgs, strutils;
 {$endif}

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    ButtonNeg: TButton;
    Button5steps: TButton;
    ButtonClrTrace: TButton;
    ButtonADC: TButton;
    ButtonC: TButton;
    Button6: TButton;
    Button7: TButton;
    ButtonPos: TButton;
    ButtonMax: TButton;
    CheckBox1: TCheckBox;
    checkXt: TCheckBox;
    Checkcct: TCheckBox;
    CheckContinuous: TCheckBox;
    ClearMemo: TButton;
    dacspin: TFloatSpinEdit;
    dacspin1: TFloatSpinEdit;
    FloatSineMag: TFloatSpinEdit;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    LabelMaxV: TLabel;
    LabelMinV: TLabel;
    LabelFreq: TLabel;
    LabelSineMag: TLabel;
    LabeladcV: TLabel;
    LabelC: TLabel;
    Label2: TLabel;
    LabelChannel: TLabel;
    Labelinfo: TLabel;
    LabelE1: TLabel;
    LabelE2: TLabel;
    LabelE: TLabel;
    Labeltime: TLabel;
    Labeltime1: TLabel;
    Labeltime2: TLabel;
    com81: TMenuItem;
    com91: TMenuItem;
    com101: TMenuItem;
    com111: TMenuItem;
    com121: TMenuItem;
    com131: TMenuItem;
    com141: TMenuItem;
    com151: TMenuItem;
    com161: TMenuItem;
    com171: TMenuItem;
    LabelTrace: TLabel;
    LabelMult: TLabel;
    MenuLoadCal: TMenuItem;
    PrintDialog1: TPrintDialog;
    PrinterSetupDialog1: TPrinterSetupDialog;
    SaveDialog1: TSaveDialog;
    OpenDialog1: TOpenDialog;
    MainMenu1: TMainMenu;
    Copy1: TMenuItem;
    Copy2: TMenuItem;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    Shape5: TShape;
    Shape6: TShape;
    SpinFreq: TSpinEdit;
    SpinMultiple: TSpinEdit;
    SpinTrace: TSpinEdit;
    TimerS: TTimer;
    tmrchkstatus: TTimer;
    Memo1: TMemo;
    LabelSP: TLabel;
    S1: TMenuItem;
    Save2: TMenuItem;
    Load3: TMenuItem;
    Timer7: TTimer;
    ComPort1: TMenuItem;
    Com11: TMenuItem;
    Com21: TMenuItem;
    Com31: TMenuItem;
    Com41: TMenuItem;
    Com51: TMenuItem;
    Com61: TMenuItem;
    Com71: TMenuItem;
    UDchannel: TUpDown;
    PrintPlot1: TMenuItem;
    SavetoFile1: TMenuItem;
    SamplePoint: TSpinEdit;
    UpDownMax: TUpDown;
    UpDownMin: TUpDown;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button5stepsClick(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure ButtonADCClick(Sender: TObject);
    procedure ButtonCClick(Sender: TObject);
    procedure ButtonClrTraceClick(Sender: TObject);
    procedure ButtonMaxClick(Sender: TObject);
    procedure ButtonNegClick(Sender: TObject);
    procedure ButtonPosClick(Sender: TObject);
    procedure CheckBox1Change(Sender: TObject);
    procedure checkXtChange(Sender: TObject);
    procedure CheckcctChange(Sender: TObject);
    procedure CheckContinuousChange(Sender: TObject);
    procedure ClearMemoClick(Sender: TObject);
    procedure com111Click(Sender: TObject);
    procedure com121Click(Sender: TObject);
    procedure com131Click(Sender: TObject);
    procedure com141Click(Sender: TObject);
    procedure com151Click(Sender: TObject);
    procedure com161Click(Sender: TObject);
    procedure com171Click(Sender: TObject);
    procedure dacspinChange(Sender: TObject);
    procedure FloatSineMagChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure com81Click(Sender: TObject);
    procedure com91Click(Sender: TObject);
    procedure com101Click(Sender: TObject);
    procedure getcal(Sender: TObject);
    procedure LabelMinVClick(Sender: TObject);
    procedure mnuExitClick(Sender: TObject);
    procedure FomrDestroy(Sender: TObject);
    procedure Copy2Click(Sender: TObject);
    procedure Plotdata1(Sender: TObject);
    procedure SamplePointChange(Sender: TObject);
    procedure SpinFreqChange(Sender: TObject);
    procedure SpinMultipleChange(Sender: TObject);
    procedure SpinTraceChange(Sender: TObject);
    procedure TimerSTimer(Sender: TObject);
    procedure tmrchkstatusTimer(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
    Shift: TShiftState; X, Y: Integer);
    procedure Save2Click(Sender: TObject);
    procedure Load3Click(Sender: TObject);
    procedure Timer7Timer(Sender: TObject);
    procedure Com11Click(Sender: TObject);
    procedure Com21Click(Sender: TObject);
    procedure Com31Click(Sender: TObject);
    procedure Com41Click(Sender: TObject);
    procedure Com51Click(Sender: TObject);
    procedure Com61Click(Sender: TObject);
    procedure Com71Click(Sender: TObject);
    procedure UDchannelClick(Sender: TObject; Button: TUDBtnType);
    procedure UDp01Click(Sender: TObject; Button: TUDBtnType);
    procedure PrintPlot1Click(Sender: TObject);
    procedure SavetoFile1Click(Sender: TObject);
    procedure UpDownMaxClick(Sender: TObject; Button: TUDBtnType);
    procedure UpDownMinClick(Sender: TObject; Button: TUDBtnType);
  private
     { Private declarations }

  public
    { Public declarations }

  end;

var
  Form1: TForm1;

implementation


{$R *.lfm}

var

   myimage : TBitMap;  //TBitmap plot image

   dcount : integer;

   FileName : string;
   LogName : string;               //File name for sript file saves
   cstring : string;
   fname : string;                 //File Name for script file saves

   //Serial port I/O definitions
   {$ifdef pi3}
   {$else}
      d : tDCB;
      cp : tcommprop;
      cs : tcomstat;
      a : longbool;
      a2 : bool;
   {$endif}

   p : ^dword;
   dw :dword;
   comhand: thandle;


   adc0,adc1,adcA,adcB,adcC,adcD,adcE,adcF,adcG, adcI : integer;
   cctVI : array[0..2,0..512,1..10] of single;  //{V,I,t},{values},{trace}
   ledstate : integer;
   bit7 : integer;
   plotf : integer;
   pxr : word;
   markV,markT,markI : single;
   deltaV, deltaT,deltaI : single;
   scancount : integer;
   vgain, igain, voff, ioff, icomp : single;
   freq, bv : single;
   trace, trace_count : integer;


 {$ifdef pi3}

   //Open serial comport #1 to #20 and set to 8 data no parity baud=921600. return 0 on error;
   Function opencomport(portnum : smallint): smallint;
   begin
    if (portnum < 1) or (portnum > 4) then portnum := 1;
    if portnum = 1 then FileName := '/dev/ttyACM0';
    if portnum = 2 then FileName := '/dev/ttyACM1';
    if portnum = 3 then FileName := '/dev/ttyUSB0';
    if portnum = 4 then FileName := '/dev/ttyUSB1';

    comhand := Serial.SerOpen(FileName);    //Open ComX for input-output mode
    opencomport := -1;                                 //If open works, return all ones
     try
      serial.SerSetParams(comhand,115200,8,NoneParity,1,[]);
     except
       opencomport := 0;                            //Return zero if error
     end;
    end;
   //Close the serial port
   procedure closecomport;                         //Shut down the serial port
   begin
    try
     Serial.SerClose(comhand);
    except
    end;
   end;

   //Transmit the lower byte of an integer through the serial port. return -1 on error
   function transmitcombyte(databyte : smallint): smallint;
   var
      c : char;
      p9 : array[0..2] of char;
      f : word;
   begin
    if databyte <0 then databyte := 0;
    if databyte >255 then databyte := 255;
    c := chr(databyte);
    p9[0] := c;
    p9[1] := chr(0);
    try
     f := serial.SerWrite(comhand, p9[0], 1);
     sleep(1);
    except
      f := 0;
    end;
    if f = 0 then transmitcombyte := -1 else transmitcombyte := 0;  //on error return -1 else 0 if sent
   end;

   //write a serial string command to the arduino
   procedure writecommand(cs2 : shortstring);
   var
    i : smallint;
    p9 : array[0..255] of char;
    f : word;
    count : integer;
   begin
    count := Length(cs2);
    if count < 1 then exit;
    for i := 0 to count-1 do p9[i]:= cs2[i+1];
    p9[count] := char(13);       //add CR
    p9[count+1] := char(10);     //add LF
   try
    f := Serial.SerWrite(comhand, p9[0], count+2);
    sleep(15);
   except
   end;
   end;

   //get one byte from com port buffer. return byte 0-255 but if no data available, return 256
   function readcombyte(): integer;
   var
    f : word;
    b : array[0..1] of byte;
   begin
     b[0] := 0;
     readcombyte := 256;                  //return 256 if no byte was recieved
   try
    f := Serial.SerRead(comhand, b[0], 1);
   except
    f := 0;
   end;
    if f = 1 then readcombyte := b[0] else readcombyte := 256;
   end;
// Transmits command string cmds + integer i4 converted to a 4 byte string
   procedure transmitcommand(cmds : string ; i4 : integer);
   var
    j1, j2, j3, j4 : integer;
   begin
      transmitcombyte(ord('@'));
      transmitcombyte(ord(cmds[1]));
      transmitcombyte(ord(cmds[2]));
      transmitcombyte(ord(cmds[3]));
      j4 := i4 mod 10;
      i4 := i4 div 10;
      j3 := i4 mod 10;
      i4 := i4 div 10;
      j2 := i4 mod 10;
      i4 := i4 div 10;
      j1 := i4 mod 10;
      i4 := i4 div 10;
      transmitcombyte(j1+ord('0'));
      transmitcombyte(j2+ord('0'));
      transmitcombyte(j3+ord('0'));
      transmitcombyte(j4+ord('0'));
   end;
 {$else}

   //Open serial comport 8 data no parity baud=19200 return 0 on error;
   Function opencomport(portnum : smallint): smallint;
   begin
     if (portnum < 1) or (portnum > 30) then portnum := 1;
     if portnum = 1 then FileName := 'com1';
     if portnum = 2 then FileName := 'com2';
     if portnum = 3 then FileName := 'com3';
     if portnum = 4 then FileName := 'com4';
     if portnum = 5 then FileName := 'com5';
     if portnum = 6 then FileName := 'com6';
     if portnum = 7 then FileName := 'com7';
     if portnum = 8 then FileName := 'com8';
     if portnum = 9 then FileName := 'com9';
     if portnum = 10 then FileName := '\\.\COM10';
     if portnum = 11 then FileName := '\\.\COM11';
     if portnum = 12 then FileName := '\\.\COM12';
     if portnum = 13 then FileName := '\\.\COM13';
     if portnum = 14 then FileName := '\\.\COM14';
     if portnum = 15 then FileName := '\\.\COM15';
     if portnum = 16 then FileName := '\\.\COM16';
     if portnum = 17 then FileName := '\\.\COM17';
     if portnum = 18 then FileName := '\\.\COM18';
     if portnum = 19 then FileName := '\\.\COM19';
     if portnum = 20 then FileName := '\\.\COM20';
     if portnum = 21 then FileName := '\\.\COM21';
     if portnum = 22 then FileName := '\\.\COM22';
     if portnum = 23 then FileName := '\\.\COM23';
     if portnum = 24 then FileName := '\\.\COM24';
     if portnum = 25 then FileName := '\\.\COM25';
     if portnum = 26 then FileName := '\\.\COM26';
     if portnum = 27 then FileName := '\\.\COM27';
     if portnum = 28 then FileName := '\\.\COM28';
     if portnum = 29 then FileName := '\\.\COM29';
     if portnum = 30 then FileName := '\\.\COM30';
     comhand := FileOpen(FileName, fmOpenReadWrite);    //Open ComX for input-output mode
     opencomport := -1;                                 //If open works, return all ones
     if (comhand > 0) and (comhand < 4294967295) then begin
       //valid file handle, so set up port parameters
       getcommproperties(comhand, cp);                 //Get the com port windows handle
       a2 := SetUpComm(comhand, 32768, 512);           //Set up for a 32768 byte receive buffer and a 512 byte write buffer
       a2 := GetCommState(comhand, d);                //Get the current set up for the port
       dw := d.wreserved;
       dw := d.wreserved1;
       d.BaudRate := 115200;                           //Change the speed and bit settings
       d.ByteSize := 8;
       d.Parity := NOPARITY;
       d.StopBits := ONESTOPBIT;
       a2 := SetCommState(comhand, d);               //Configure the new speed and bit settings
      end
     else begin
       opencomport := 0;                            //Return zero if error
     end;
   end;

   //Close the serial port
   procedure closecomport;                         //Shut down the serial port
   begin
    FileClose(comhand); { *Converted from CloseHandle* }
   end;

   //Transmit the lower byte of an integer through the serial port. return -1 on error
   function transmitcombyte(databyte : smallint): smallint;
   var
      c : char;
      p9 : array[0..2] of char;
      f : word;
   begin
    if databyte <0 then databyte := 0;
    if databyte >255 then databyte := 255;
    c := chr(databyte);
    p9[0] := c;
    p9[1] := chr(0);
    f := filewrite(comhand, p9, 1);
    if f = 0 then transmitcombyte := -1 else transmitcombyte := 0;  //on error return -1 else 0 if sent
   end;

   //write a serial string command to the curve tracer
   procedure writecommand(cs2 : shortstring);
   var
    i : smallint;
    p9 : array[0..255] of char;
    f : word;
    count : integer;
   begin
    count := Length(cs2);
    if count < 1 then exit;
    for i := 0 to count-1 do p9[i]:= cs2[i+1];
    p9[count] := char(13);   //add CR
    p9[count+1] := char(10);     //add LF
    f := filewrite(comhand, p9, count+2);
   end;

   //get one byte from com port buffer. return byte 0-255 but if no data available, return 256
   function readcombyte(): integer;
   var
    d : dword;
    f : word;
    b : byte;
   begin
    clearcommerror(comhand, d, @cs);
     b := 0;
     readcombyte := 256;                  //return 256 if no byte was recieved
    if cs.cbinque <> 0 then begin
     f := fileread (comhand, b, 1);
     if f <> 0 then begin
      readcombyte := b;
     end;
    end;
   end;
   // Transmits command string cmds + integer i4 converted to a 4 byte string
   procedure transmitcommand(cmds : string ; i4 : integer);
   var
    j1, j2, j3, j4 : integer;
   begin
      transmitcombyte(ord('@'));
      transmitcombyte(ord(cmds[1]));
      transmitcombyte(ord(cmds[2]));
      transmitcombyte(ord(cmds[3]));
      j4 := i4 mod 10;
      i4 := i4 div 10;
      j3 := i4 mod 10;
      i4 := i4 div 10;
      j2 := i4 mod 10;
      i4 := i4 div 10;
      j1 := i4 mod 10;
      i4 := i4 div 10;
      transmitcombyte(j1+ord('0'));
      transmitcombyte(j2+ord('0'));
      transmitcombyte(j3+ord('0'));
      transmitcombyte(j4+ord('0'));
   end;
{$endif}

procedure updateCursor();
begin
  if plotf = 0 then begin
  form1.labelE.caption := format('%1.3fV',[cctVI[0,form1.samplepoint.Value,trace]]);
  form1.labeltime.caption := format('%1.3fmA',[cctVI[1,form1.samplepoint.Value,trace]]);
  form1.labelE1.caption := format('%1.3fV',[markV]);
  form1.labeltime1.caption := format('%1.3fmA',[markI]);
  deltaV := cctVI[0,form1.samplepoint.Value,trace]-markV;
  deltaI := cctVI[1,form1.samplepoint.Value,trace]-markI;
  form1.labelE2.caption := format('%1.3fV',[deltaV]);
  form1.labeltime2.caption := format('%1.3fmA',[deltaI]);
  form1.labelinfo.caption :=  format('R = %3.1fohms',[1000.0*deltav/(deltaI+0.000001)]);
 end;
 if plotf = 1 then begin
  form1.labelE.caption := format('%1.3fV',[cctVI[0,form1.samplepoint.Value,trace]]);
  form1.labeltime.caption := format('%1.4fs',[cctVI[2,form1.samplepoint.Value,trace]]);
  form1.labelE1.caption := format('%1.3fV',[markV]);
  form1.labeltime1.caption := format('%1.4fs',[markT]);
  deltaV := cctVI[0,form1.samplepoint.Value,trace]-markV;
  deltaT := cctVI[2,form1.samplepoint.Value,trace]-markT;
  form1.labelE2.caption := format('%1.3fV',[deltaV]);
  form1.labeltime2.caption := format('%1.4fs',[deltaT]);
  form1.labelinfo.caption :=  format('f = %3.1fHz',[1.0/(deltaT+0.000001)]);
 end;
end;

//Paints the bitmap array for the plot to the Form
procedure paintdib;
begin
 Form1.canvas.draw(0, 0, myimage);
end;
 
// Plot the converted ADC values for 256 points of data
procedure plotdata;
var
 i,j : integer;
 v1, v2  : integer;
 cntL : integer;
begin


//cntL := form1.memo1.Lines.Count - 1;
//if cntL > 811 then cntL := 811;
 cntL := 811;
//Set graphing pen and background colors
myimage.Canvas.Pen.mode := pmcopy;
myimage.canvas.pen.Width := 1;
myimage.canvas.Rectangle(0, 0, 512, 512);

myimage.canvas.Brush.Color := rgb(0,80,0);
myimage.canvas.brush.style := bssolid;
myimage.canvas.FillRect(rect(1, 1, 511, 511));

for j := 1 to form1.SpinMultiple.Value do begin
 if form1.SpinMultiple.Value = 1 then trace := form1.SpinTrace.Value else trace := j;

//Plot the voltage versus current in plotcolor
 myimage.canvas.pen.Color := rgb(0,250,0);
 myimage.canvas.pen.Width := 2;
 myimage.canvas.pen.style := pssolid;

 if plotf = 0 then begin
  for i := 0 to 255 do begin  //Plot V-I
   v2 := 256-trunc(cctVI[1,i,trace] * 51.2);
   v1 := 256+trunc(cctVI[0,i,trace] * 21.34);
   if i=0 then begin
    myimage.canvas.moveto(v1, v2); //Move to the first point to prevent wild lines on plot
   end;
   myimage.canvas.lineto(v1, v2);
   if ((i = form1.SamplePoint.value) and (trace = form1.SpinTrace.Value)) then begin
    myimage.canvas.Ellipse(v1-3,v2-3,v1+3,v2+3);
    updateCursor;
   end;
  end; {i}
 end;

 if plotf = 1 then begin
  for i := 0 to 255 do begin  //Plot V-t
   v2 := 256-trunc(cctVI[0,i,trace] * 21.34);
   v1 := i*2;
   if i=0 then myimage.canvas.moveto(v1, v2); //Move to the first point to prevent wild lines on plot
   myimage.canvas.lineto(v1, v2);
   if ((i = form1.SamplePoint.value) and (trace = form1.SpinTrace.Value)) then begin
    myimage.canvas.Ellipse(v1-3,v2-3,v1+3,v2+3);
    updateCursor;
   end;
  end; {i}
  myimage.canvas.pen.Color := rgb(250,100,0);
  for i := 0 to 255 do begin  //Plot V-t
   v2 := 256-trunc(cctVI[1,i,trace] * 51.2);
   v1 := i*2;
   if i=0 then myimage.canvas.moveto(v1, v2); //Move to the first point to prevent wild lines on plot
   myimage.canvas.lineto(v1, v2);
   if ((i = form1.SamplePoint.value) and (trace = form1.SpinTrace.Value)) then begin
    myimage.canvas.Ellipse(v1-3,v2-3,v1+3,v2+3);
    updateCursor;
   end;
  end; {i}
 end;
end;

trace := form1.SpinTrace.Value;

 myimage.canvas.pen.Mode := pmxor;


 myimage.canvas.pen.color := rgb(110,110,140);
 myimage.canvas.pen.width := 1;

//Draw grids
for i := 1 to 9 do begin
 myimage.canvas.moveto(1,1+i*510 div 10);
 myimage.canvas.lineto(511,1+i*510 div 10);
 myimage.canvas.moveto(1+i*510 div 10,2);
 myimage.canvas.lineto(1+i*510 div 10,511);
end; {i}

myimage.canvas.pen.Mode := pmcopy;
myimage.canvas.pen.Style := pssolid;

myimage.canvas.brush.style := bssolid;  //restore text mode to solid background

 paintdib;      //paint the image to the form
end; {plotdata}

// Redraw Plot on Display
procedure doredraw;
begin
 myimage.PixelFormat := pf24bit; //Use true RGB for the image
 plotdata;                       //Draw grids on plot then traces
end; {doredraw}

procedure TForm1.CheckBox1Change(Sender: TObject);
begin
  if checkbox1.Checked then form1.timer7.Interval:=2000 else form1.timer7.Interval:=750 ;
end;

procedure TForm1.checkXtChange(Sender: TObject);
begin
  if form1.checkXt.Checked then plotf := 1 else plotf := 0;
  plotdata;
end;

procedure TForm1.CheckcctChange(Sender: TObject);
begin
  if checkcct.Checked then form1.timer7.enabled := true else if checkcontinuous.Checked = false then form1.timer7.enabled := false;
end;

procedure TForm1.CheckContinuousChange(Sender: TObject);
begin
  if checkcontinuous.Checked then form1.timer7.enabled := true else if checkcct.Checked = false then form1.timer7.enabled := false;
end;

procedure TForm1.ClearMemoClick(Sender: TObject);
begin
  form1.Memo1.Clear;
end;

procedure TForm1.com111Click(Sender: TObject);
begin
   closecomport;
 if opencomport(1) <> 0 then begin
  form1.com11.checked := true;
  form1.comport1.caption := 'com11';
 end else
  form1.comport1.caption := 'Com: XX';
end;

procedure TForm1.com121Click(Sender: TObject);
begin
   closecomport;
 if opencomport(12) <> 0 then begin
  form1.com121.checked := true;
  form1.comport1.caption := 'com12';
 end else
  form1.comport1.caption := 'Com: XX';
end;

procedure TForm1.com131Click(Sender: TObject);
begin
   closecomport;
 if opencomport(13) <> 0 then begin
  form1.com131.checked := true;
  form1.comport1.caption := 'com13';
 end else
  form1.comport1.caption := 'Com: XX';
end;

procedure TForm1.com141Click(Sender: TObject);
begin
   closecomport;
 if opencomport(14) <> 0 then begin
  form1.com141.checked := true;
  form1.comport1.caption := 'com14';
 end else
  form1.comport1.caption := 'Com: XX';
end;

procedure TForm1.com151Click(Sender: TObject);
begin
   closecomport;
 if opencomport(15) <> 0 then begin
  form1.com151.checked := true;
  form1.comport1.caption := 'com15';
 end else
  form1.comport1.caption := 'Com: XX';
end;

procedure TForm1.com161Click(Sender: TObject);
begin
   closecomport;
 if opencomport(16) <> 0 then begin
  form1.com161.checked := true;
  form1.comport1.caption := 'com16';
 end else
  form1.comport1.caption := 'Com: XX';
end;

procedure TForm1.com171Click(Sender: TObject);
begin
   closecomport;
 if opencomport(17) <> 0 then begin
  form1.com171.checked := true;
  form1.comport1.caption := 'com17';
 end else
  form1.comport1.caption := 'Com: XX';
end;

procedure TForm1.dacspinChange(Sender: TObject);
begin
  dcount := 0;
  transmitcommand('dac',trunc(dacspin.Value*255.0/5.0));
end;

procedure TForm1.FloatSineMagChange(Sender: TObject);
begin
  dcount := 0;
  transmitcommand('mag',trunc(floatSineMag.Value * 127.0 / 11.15));
end;


//Routine to test for serial input data after a new line char is received
procedure checkforbyte;
var
 ctest : char;
 i, ic, i2, j: integer;
 s : string;
 tf : boolean;
 vs : single;
begin
 for i := 0 to 511 do begin
  ic := readcombyte;
  if (ic = 256) then begin
   break;
  end;
  ctest := char(ic);
  if ic = 13 then  begin
    if form1.checkbox1.checked then form1.memo1.Lines.Append(cstring);

    s :=  cstring;

    i2 := Pos('cct', s);
    if i2 <> 0 then begin
     trystrtoint(copy(s,4,4),adc0);
     trystrtoint(copy(s,8,4),adc1);
     cctVI[0,dcount,trace] :=  (adc0-voff)*vgain;
     cctVI[1,dcount,trace] :=  -(adc1-ioff)*igain + cctVI[0,dcount,trace]*icomp;
     dcount := dcount+1;
     if dcount = 256 then begin
      for j := 0 to 255 do begin
        cctVI[2,j,trace] := j * 121.36e-6;
      end;
      plotdata;
     end;
    end;


    i2 := Pos('mea', s);
    if i2 <> 0 then begin
     trystrtoint(copy(s,4,4),adc0);
     trystrtoint(copy(s,8,4),adc1);
     cctVI[0,dcount,trace] :=  (adc0-voff)*vgain;
     cctVI[1,dcount,trace] := -(adc1-ioff)*igain + cctVI[0,dcount,trace]*icomp;
     dcount := dcount+1;
     if dcount = 256 then begin
      for j := 0 to 255 do begin
        cctVI[2,j,trace] := j * 1117.19e-6;
      end;
      plotdata;
     end;
    end;

    i2 := Pos('ad', s);
    if i2 <> 0 then begin
     trystrtoint(copy(s,4,4),adc0);
     vs := (adc0*5.0)/1024.0;
     form1.labeladcV.caption := format('%1.3f',[vs]);
    end;


     if dcount >= 256 then begin
      dcount := 256;
      form1.timerS.enabled := true;
     end;

  end;
  if (ic = 13) or (ic=10) then cstring := '' else  cstring :=  cstring + ctest;
 end;
end; {checkforbyte}

//When the form starts up, all variables must be initiallized
procedure TForm1.FormCreate(Sender: TObject);
var
 i, cstats : integer;
begin

 {$ifdef pi3}
   form1.comport1.caption:='/dev/ttyACM1';
   com11.Caption:='/dev/ttyACM0';
   com21.Caption:='/dev/ttyACM1';
   com31.Caption:='/dev/ttyUSB0';
   com41.Caption:='/dev/ttyUSB1';
   com51.Visible:=false;
   com51.Visible:=false;
   com61.Visible:=false;
   com71.Visible:=false;
   com81.Visible:=false;
   com91.Visible:=false;
   com101.Visible:=false;
   com111.Visible:=false;
   com121.Visible:=false;
   com131.Visible:=false;
   com141.Visible:=false;
   com151.Visible:=false;
   com161.Visible:=false;
   com171.Visible:=false;
 {$endif}

 scancount := -1;
 dcount := 0;
 fname := 'LogNull'; //Script file default file name for data output

 vgain := 0.0233;    //default calibration constants
 igain := 0.00976;
 voff := 512.0;
 ioff := 509.5;
 icomp := 0.00518;
 freq := 60.2;
 trace := 1;
 trace_count := 0;

 for i := 1 to 18 do begin; //set default com port for arduino ACM0
  cstats := opencomport(i); //open up serial port-i
  if cstats <> 0 then break;
 end;

 //Mark port selection with port number and put a check by port number
 if i < 18 then begin
  form1.comport1.caption := 'com'+inttostr(i);
  if i = 1 then form1.com11.checked := true;
  if i = 2 then form1.com21.checked := true;
  if i = 3 then form1.com31.checked := true;
  if i = 4 then form1.com41.checked := true;
  if i = 5 then form1.com51.checked := true;
  if i = 6 then form1.com61.checked := true;
  if i = 7 then form1.com71.checked := true;
  if i = 8 then form1.com81.checked := true;
  if i = 9 then form1.com91.checked := true;
  if i = 10 then form1.com101.checked := true;
  if i = 11 then form1.com111.checked := true;
  if i = 12 then form1.com121.checked := true;
  if i = 13 then form1.com131.checked := true;
  if i = 14 then form1.com141.checked := true;
  if i = 15 then form1.com151.checked := true;
  if i = 16 then form1.com161.checked := true;
  if i = 17 then form1.com171.checked := true;
 end;

 if i = 18 then form1.comport1.caption := 'Com: XX'; //dos equis if port not found

 myimage := TBitMap.Create; //Define the image as png for plotting data
 myimage.Height := 512;
 myimage.Width := 512;
 myimage.PixelFormat := pf24bit; //Use true RGB for the image
 form1.tmrchkstatus.Enabled := true;
 pxr := 0;
 dcount := 256;
end; {formcreate}

procedure TForm1.com81Click(Sender: TObject);
begin
  closecomport;
 if opencomport(8) <> 0 then begin
  form1.com81.checked := true;
  form1.comport1.caption := 'com8';
 end else
  form1.comport1.caption := 'Com: XX';
end;

procedure TForm1.com91Click(Sender: TObject);
begin
  closecomport;
 if opencomport(9) <> 0 then begin
  form1.com91.checked := true;
  form1.comport1.caption := 'com9';
 end else
  form1.comport1.caption := 'Com: XX';
end;

procedure TForm1.com101Click(Sender: TObject);
begin
   closecomport;
 if opencomport(10) <> 0 then begin
  form1.com101.checked := true;
  form1.comport1.caption := 'com10';
 end else
  form1.comport1.caption := 'Com: XX';
end;
// Read calibration data from cal.dat file
procedure TForm1.getcal(Sender: TObject);
var
  F: TextFile;
begin
   try
    AssignFile(F, 'cal.dat');
    ReSet(F);
    Read(F, vgain);
    form1.memo1.Append(format('vgain = %1.5f',[vgain]));
    Read(F, igain);
    form1.memo1.Append(format('igain = %1.5f',[igain]));
    Read(F, voff);
    form1.memo1.Append(format('voff = %3.1f',[voff]));
    Read(F, ioff);
    form1.memo1.Append(format('ioff = %3.1f',[ioff]));
    Read(F, icomp);
    form1.memo1.Append(format('icomp = %0.5f',[icomp]));
   except
    form1.memo1.Append('Calibration file did not load');
   end;
end;

procedure TForm1.LabelMinVClick(Sender: TObject);
begin

end;

//Menu exit item
procedure TForm1.mnuExitClick(Sender: TObject);
begin
 close;
end;

//On exit close serial acquisition and program
procedure TForm1.FomrDestroy(Sender: TObject);
begin
   closecomport;
   Close;
end;

//Copy the curve trace image to the clip board for use in pasting (word, photo edti, etc)
procedure TForm1.Copy2Click(Sender: TObject);
begin
  Clipboard.Assign(myimage);
end;

procedure TForm1.Plotdata1(Sender: TObject);
begin
  plotdata;
end;

procedure TForm1.SamplePointChange(Sender: TObject);
begin
  updateCursor;
  plotdata;
end;
//Update frequency selection
procedure TForm1.SpinFreqChange(Sender: TObject);
begin
  dcount := 0;
  transmitcommand('frq',spinFreq.Value);
  freq := 963.234/spinFreq.Value;
  labelFreq.caption := format('f = %3.1f',[freq]);
end;

procedure TForm1.SpinMultipleChange(Sender: TObject);
begin
  plotdata;
end;

procedure TForm1.SpinTraceChange(Sender: TObject);
begin
  trace := SpinTrace.Value;
  plotdata;
end;

procedure TForm1.TimerSTimer(Sender: TObject);
begin
    if scancount = -1 then begin
     plotdata;
     scancount := 0;
     exit;
    end;
end;

//Every 2ms, we are looking for serial data in the com buffer (data polling)
procedure TForm1.tmrchkstatusTimer(Sender: TObject);
begin
 checkforbyte;
end;

// Process mouse click on dispaly graph: Converts mouse x data to voltage and current
procedure TForm1.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 if (x < 512) and (y < 512) then begin
  if x >512 then x := 512;
  if x < 0 then x := 0;
  form1.SamplePoint.value := x/2;
 end;
end;
// Saves the trace data
procedure dosavetraces;
var
  F: TextFile;
  i, j, jm : integer;
begin
  form1.SaveDialog1.DefaultExt := '*.trc';
  form1.OpenDialog1.DefaultExt := '*.trc';
  form1.SaveDialog1.FilterIndex := 4;
  form1.SaveDialog1.Filename := ChangeFileExt(form1.SaveDialog1.FileName, '.trc');
  if form1.SaveDialog1.Execute then begin
   form1.OpenDialog1.Filename := ChangeFileExt(form1.SaveDialog1.FileName, '.trc');
   try
    AssignFile(F, form1.SaveDialog1.FileName);
    Rewrite(F);
     for j := 0 to 255 do begin
      for i := 1 to 10 do begin                          //write in column format
        if i <> 1 then Write(F,' ');
        Write(F, format('%2.3f',[cctVI[0,j,i]]));        //Write the voltage to 1mV
        Write(F, ' ' + format('%2.3f',[cctVI[1,j,i]]));  //Write the current to 1uA
        Write(F, ' ' + format('%0.6f',[cctVI[2,j,i]]));  //Write the time to 1us
      end;
      Writeln(F, '');                                  //end with a return
    end;
  finally
    CloseFile(F);
  end;
  end;
end;

// Saves the data contained in the memo pad
procedure dosavescript;
begin
  form1.SaveDialog1.DefaultExt := '*.txt';
  form1.OpenDialog1.DefaultExt := '*.txt';
  form1.SaveDialog1.FilterIndex := 1;
  form1.SaveDialog1.Filename := ChangeFileExt(form1.SaveDialog1.FileName, '.txt');
  if form1.SaveDialog1.Execute then begin
   form1.OpenDialog1.Filename := ChangeFileExt(form1.SaveDialog1.FileName, '.txt');
  with Form1.Memo1.Lines do
   begin
    SaveToFile(ChangeFileExt(form1.SaveDialog1.FileName, '.txt'));
   end;
  end;
end;

// Process Menu item Scipt File Save
procedure TForm1.Save2Click(Sender: TObject);
begin
 dosavetraces;
end;

// Loads a trace file into memoy
procedure doloadtraces;
var
  F: TextFile; //The holder for the file name
  i, j : integer;
  x : single;
begin
  form1.SaveDialog1.DefaultExt := '*.trc';
  form1.OpenDialog1.DefaultExt := '*.trc';
  form1.OpenDialog1.FilterIndex := 4;
  form1.OpenDialog1.Filename := ChangeFileExt(form1.OpenDialog1.FileName, '.trc');
  if form1.OpenDialog1.Execute then begin
   form1.SaveDialog1.Filename := form1.OpenDialog1.FileName;
   try
    AssignFile(F, form1.OpenDialog1.FileName);
    ReSet(F);
    for i := 0 to 255 do begin    //trace number
     for j := 1 to 10 do begin  //Read voltage, current, time 256 values
      Read(F,x);
      cctVI[0,i,j] := x;    //voltage
      Read(F,x);
      cctVI[1,i,j] := x;    //current
      Read(F,x);
      cctVI[2,i,j] := x;   //time
      end;
    end;
   finally                //Close the file
    CloseFile(F);
   end;
  plotdata;              //Plot current trace
 end;
end;
// Loads a script file into the memo pad
procedure doloadscript;
var
  F: TextFile;
  S: string;
begin
  form1.SaveDialog1.DefaultExt := '*.txt';
  form1.OpenDialog1.DefaultExt := '*.txt';
  form1.OpenDialog1.FilterIndex := 1;
  form1.OpenDialog1.Filename := ChangeFileExt(form1.OpenDialog1.FileName, '.txt');
  if form1.OpenDialog1.Execute then begin
  form1.SaveDialog1.Filename := form1.OpenDialog1.FileName;
  AssignFile(F, form1.OpenDialog1.FileName);
  Reset(F);
  while not Eof(F) do
   begin
   Readln(F, s);
   form1.Memo1.Lines.add(s);
  end;
  CloseFile(F);
 end;
end;

// Menu Script File Load
procedure TForm1.Load3Click(Sender: TObject);
begin
  doloadtraces;
end;

//Timer7 processes the Run 5 Base Steps mode
procedure TForm1.Timer7Timer(Sender: TObject);
begin

 if trace_count <> 0 then begin
  bv := bv + dacspin1.Value;
  if bv > 4.98 then bv := 4.98;
  button7.Click;
  dcount := 0;
  transmitcommand('dac',trunc(bv*255.0/5.0));
  spintrace.Value := trace_count;
  trace_count :=  trace_count + 1;

  if trace_count > 5 then begin
   trace_count := 0;
   spinMultiple.Value := 5;
   checkContinuous.Checked := false;
  end;
  exit;
 end;

 dcount := 0;
 if checkcct.Checked then button6.click else button7.Click;
end;

//Process for unchecking Com Port Numbers on pull down menu
procedure uncheckall;
begin
 form1.Com11.Checked := false;
 form1.Com21.Checked := false;
 form1.Com31.Checked := false;
 form1.Com41.Checked := false;
 form1.Com51.Checked := false;
 form1.Com61.Checked := false;
 form1.Com71.Checked := false;
end;

//Process Com:1 menu click
procedure TForm1.Com11Click(Sender: TObject);
begin
 closecomport;
 if opencomport(1) <> 0 then begin
  form1.com11.checked := true;
  form1.comport1.caption := 'com1';
  {$ifdef pi3}
   form1.comport1.caption:='/dev/ttyACM0';
  {$endif}
 end else
  form1.comport1.caption := 'Com: XX';
end;

//Process Com:2 menu click
procedure TForm1.Com21Click(Sender: TObject);
begin
 closecomport;
 if opencomport(2) <> 0 then begin
  form1.com21.checked := true;
  form1.comport1.caption := 'com2';
  {$ifdef pi3}
   form1.comport1.caption:='/dev/ttyACM1';
  {$endif}
 end else
  form1.comport1.caption := 'Com: XX';
end;

//Process Com:3 menu click
procedure TForm1.Com31Click(Sender: TObject);
begin
 closecomport;
 if opencomport(3) <> 0 then begin
  form1.com31.checked := true;
  form1.comport1.caption := 'com3';
  {$ifdef pi3}
   form1.comport1.caption:='/dev/ttyUSB0';
  {$endif}
 end else
  form1.comport1.caption := 'Com: XX';
end;

//Process Com:4 menu click
procedure TForm1.Com41Click(Sender: TObject);
begin
 closecomport;
 if opencomport(4) <> 0 then begin
  form1.com41.checked := true;
  form1.comport1.caption := 'com4';
  {$ifdef pi3}
   form1.comport1.caption:='/dev/ttyUSB1';
  {$endif}
 end else
  form1.comport1.caption := 'Com: XX';
end;

//Process Com:5 menu click
procedure TForm1.Com51Click(Sender: TObject);
begin
 closecomport;
 if opencomport(5) <> 0 then begin
  form1.com51.checked := true;
  form1.comport1.caption := 'com5';
 end else
  form1.comport1.caption := 'Com: XX';
end;

//Process Com:6 menu click
procedure TForm1.Com61Click(Sender: TObject);
begin
 closecomport;
 if opencomport(6) <> 0 then begin
  form1.com61.checked := true;
  form1.comport1.caption := 'com6';
 end else
  form1.comport1.caption := 'Com: XX';
end;

//Process Com:7 menu click
procedure TForm1.Com71Click(Sender: TObject);
begin
 closecomport;
 if opencomport(7) <> 0 then begin
  form1.com71.checked := true;
  form1.comport1.caption := 'com7';
 end else
  form1.comport1.caption := 'Com: XX';
end;

procedure TForm1.UDchannelClick(Sender: TObject; Button: TUDBtnType);
begin
   if UDchannel.position = 0 then form1.LabelChannel.Caption := 'A0';
   if UDchannel.position = 1 then form1.LabelChannel.Caption := 'A1';
   if UDchannel.position = 2 then form1.LabelChannel.Caption := 'A2';
   if UDchannel.position = 3 then form1.LabelChannel.Caption := 'A3';
   if UDchannel.position = 4 then form1.LabelChannel.Caption := 'A4';
   if UDchannel.position = 5 then form1.LabelChannel.Caption := 'A5';
end;

procedure TForm1.UDp01Click(Sender: TObject; Button: TUDBtnType);
begin
end;

//Menu Image Print Plot processing
procedure TForm1.PrintPlot1Click(Sender: TObject);
begin
  printersetupdialog1.execute;
  try
    with Printer do
    begin
      BeginDoc;
      canvas.stretchdraw(rect(100, 100, 2500, 2500), myimage);
      EndDoc;
    end;
  finally
  end;

end;
//Menu Image Save to File processing
procedure TForm1.SavetoFile1Click(Sender: TObject);
begin
  form1.SaveDialog1.DefaultExt := '*.bmp';
  form1.SaveDialog1.FilterIndex := 3;
  form1.SaveDialog1.Filename := ChangeFileExt(form1.SaveDialog1.FileName, '.bmp');
  if form1.SaveDialog1.Execute then  myimage.SaveToFile(form1.SaveDialog1.Filename);
end;

procedure TForm1.UpDownMaxClick(Sender: TObject; Button: TUDBtnType);
begin
 dcount := 0;
 transmitcommand('pos',UpDownMax.Position);
 labelMaxV.Caption := format('%1.1fV',[(UpDownMax.Position - 128)*11.5/128.0]);
end;

procedure TForm1.UpDownMinClick(Sender: TObject; Button: TUDBtnType);
begin
 dcount := 0;
 transmitcommand('neg',UpDownMin.Position);
 labelMinV.Caption := format('%1.1fV',[(UpDownMin.Position - 128)*11.5/128.0]);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  dosavescript;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin

    if plotf = 0 then begin
      markV := cctVI[0,form1.samplepoint.Value,trace];
      markI := cctVI[1,form1.samplepoint.Value,trace];
    end;
    if plotf = 1 then begin
     markV := cctVI[0,form1.samplepoint.Value,trace];
     markT := cctVI[2,form1.samplepoint.Value,trace];
    end;
    updateCursor;

end;


procedure TForm1.Button5Click(Sender: TObject);
begin
end;

procedure TForm1.Button5stepsClick(Sender: TObject);
begin
  checkcct.Checked := false;
  checkContinuous.Checked := false;
  form1.timer7.enabled := false;
  bv := dacspin.Value;
  dcount := 0;
  transmitcommand('dac',trunc(bv*255.0/5.0));
  trace_count := 1;
  checkContinuous.Checked := true;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  timerS.enabled := false;
  dcount := 0;
  transmitcommand('cct',0);
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
 timerS.enabled := false;
 dcount := 0;
 transmitcommand('mea',0);
end;

procedure TForm1.ButtonADCClick(Sender: TObject);
begin
  dcount := 0;
  transmitcommand('adc', UDchannel.Position);
end;
//Calculate Capacitance
procedure TForm1.ButtonCClick(Sender: TObject);
var
  i : integer;
  imax, imin, vmax, vmin, c : single;
  Vx : array[0..255] of single;
  Ix : array[0..255] of single;
begin
 for i := 0 to 255 do begin
   Vx[i] := cctVI[0,i,trace];
   Ix[i] := cctVI[1,i,trace];
 end;
 imax := maxvalue(Ix[0..255]);
 imax := minvalue(Ix[0..255]);
 vmax := maxvalue(Vx[0..255]);
 vmax := minvalue(Vx[0..255]);
 c := 1000.0*(imax-imin)/((vmax-vmin) * 6.2832 * freq);
 labelC.caption := format('%2.2fuf',[c-0.005]);
end;

procedure TForm1.ButtonClrTraceClick(Sender: TObject);
var
  i : integer;
begin
 for i := 0 to 255 do begin
    cctVI[0,i,trace] := 0.0;
    cctVI[1,i,trace] := 0.0;
    cctVI[2,i,trace] := 0.0;
 end;
 plotdata;
end;

procedure TForm1.ButtonMaxClick(Sender: TObject);
begin
  UpDownMin.Position:=0;
  UpDownMax.Position:=255;
  dcount := 0;
  transmitcommand('neg',UpDownMin.Position);
  labelMinV.Caption := format('%1.1fV',[(UpDownMin.Position - 128)*11.5/128.0]);
  transmitcommand('pos',UpDownMax.Position);
  labelMaxV.Caption := format('%1.1fV',[(UpDownMax.Position - 128)*11.5/128.0]);
end;

procedure TForm1.ButtonNegClick(Sender: TObject);
begin
  UpDownMin.Position:=0;
  UpDownMax.Position:=128;
  dcount := 0;
  transmitcommand('neg',UpDownMin.Position);
  labelMinV.Caption := format('%1.1fV',[(UpDownMin.Position - 128)*11.5/128.0]);
  transmitcommand('pos',UpDownMax.Position);
  labelMaxV.Caption := format('%1.1fV',[(UpDownMax.Position - 128)*11.5/128.0]);
end;

procedure TForm1.ButtonPosClick(Sender: TObject);
begin
  UpDownMin.Position:=128;
  UpDownMax.Position:=255;
  dcount := 0;
  transmitcommand('neg',UpDownMin.Position);
  labelMinV.Caption := format('%1.1fV',[(UpDownMin.Position - 128)*11.5/128.0]);
  transmitcommand('pos',UpDownMax.Position);
  labelMaxV.Caption := format('%1.1fV',[(UpDownMax.Position - 128)*11.5/128.0]);
end;

end.

