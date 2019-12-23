# Uno PWM bipolar curve tracer app by simple-circuit 12-22-19

from tkinter import *
from tkinter import ttk
from tkinter import filedialog
import numpy as np
import serial

root = Tk()
canvas = Canvas(root)
root.geometry("720x540")
root.title('Uno Curve Tracer in Python')

canvas.grid(column=0, row=0, sticky=(N,W,E,S))
root.grid_columnconfigure(0, weight=1)
root.grid_rowconfigure(0, weight=1)

xtvar = BooleanVar()
xtvar.set(False)

contvar = BooleanVar()
contvar.set(False)

crampvar = BooleanVar()
crampvar.set(False)

ser = serial.Serial('/dev/ttyACM0', baudrate=115200, timeout = 1)
#ser = serial.Serial('COM10', baudrate=115200, timeout = 1)

def globalVar():
    global x
    global y 
    global tms
    global mkv,mki,mkt
    global dv,di,dt
    x = np.zeros((10,256))
    y = np.zeros((10,256))
    tms = np.zeros((10,256))
    mkv = np.zeros((1))
    mki = np.zeros((1))
    mkt = np.zeros((1))
    dv = np.zeros((1))
    di = np.zeros((1))
    dt = np.zeros((1))
   
def plotxy(xtra = 0):
    if xtra == 0:
        canvas.delete('currentline')
    canvas.delete('currentcursor')    
    a = int(curvar.get())
    n = int(trcvar.get())
    m = int(mtrcvar.get())
    if m == 1:
        m=n+1
        n2 = n
    else:
        n2 = 0
    if xtvar.get() == False:
        if xtra == 0:
            for j in range(n2,m):
                for i in range(255):
                    canvas.create_line((256+x[j][i]*22.07, 256-y[j][i]*51.2, 256+x[j][i+1]*22.07, 256-y[j][i+1]*51.2), fill='lime', width=2, tags='currentline')
        canvas.create_oval(253+x[n][a]*22.07, 253-y[n][a]*51.2, 259+x[n][a]*22.07, 259-y[n][a]*51.2, fill='', outline='white', width=1, tags='currentcursor')               
    else:
        if xtra == 0:
            for j in range(n2,m):
                for i in range(255):       
                    canvas.create_line((i*2, 256-y[j][i]*51.2, (i+1)*2, 256-y[j][i+1]*51.2), fill='blue', width=2, tags='currentline')
                for i in range(255):       
                    canvas.create_line((i*2, 256-x[j][i]*22.07, (i+1)*2, 256-x[j][i+1]*22.07), fill='orange', width=2, tags='currentline')   
        canvas.create_oval(a*2-3, 253-x[n][a]*22.07, a*2 + 3, 259-x[n][a]*22.07, fill='', outline='white', width=1, tags='currentcursor')               
        canvas.create_oval(a*2-3, 253-y[n][a]*51.2, a*2 + 3, 259-y[n][a]*51.2, fill='', outline='white', width=1, tags='currentcursor')               
    label1.config(text = str(format(x[n][a],'0.3f')+'V')) 
    label2.config(text = str(format(y[n][a],'0.3f')+'mA'))
    label3.config(text = str(format(tms[n][a],'3.2f')+'ms'))
    runDelta()

def sweep(c = b'cct'):
    m = int(trcvar.get())
    if c == b'cct':
        tms[m][:] = np.linspace(0,30.95,256,endpoint=True)
    else:
        tms[m][:] = np.linspace(0,29.88,256,endpoint=True)
    ser.write(b'@' + c + b'0000')   
    for i in range(256):
        line = ser.readline()
        x[m][i] = int(line[line.find(c)+3:line.find(c)+7])
        x[m][i] = (x[m][i]-512)*0.02266
        y[m][i] = int(line[line.find(c)+7:])
        y[m][i] = -(y[m][i]-509.7)*0.00977 + x[m][i]*0.0055 
    plotxy()

def runSine(event):
    sweep(b'cct')

def runCont():
    if contvar.get() == True:
        sweep(b'cct')
    if (crampvar.get() == True) & (contvar.get() == False):
        if stepn.get() >= 0:
            trcvar.set(stepn.get())
            m = float(startvar.get()) + stepn.get() * float(stepvar.get())
            if m > 5.0:
                m = 5.0
            mi = int(m*51)
            ms = '@dac' + str(mi) + '\r'
            ser.write(bytes(ms, 'utf-8'))
            ser.readline()
            stepn.set(stepn.get() + 1) 
            if stepn.get() > 4:
                stepn.set(-1)
                crampvar.set(False)
        sweep(b'mea')
    root.after(500, runCont)    
            
def runRamp(event):
    sweep(b'mea')

def runMouse(event):
    xx = canvas.canvasx(event.x)
    xx = int(xx/2)
    if xx <= 255:
        curvar.set(xx)  
        cursor.invoke("buttondown")

def runMag(xtra = 0):
    m = float(sinmag.get())
    if m>11.5:
        m = 11.5
        sinmag.invoke("buttonup")
    if m<2.4:
        m=2.3
        sinmag.invoke("buttonup")
    mi = int(m*127/11.5)
    ms = '@mag' + str(mi) + '\r'
    ser.write(bytes(ms, 'utf-8'))
    magvar.set(m)

def runPos(xtra = 0):
    m = float(posmag.get())
    if m>11.5:
        m = 11.5
        posmag.invoke("buttonup")
    if m<-11.5:
        m=-11.6
        posmag.invoke("buttonup")
    mi = int(m*127/11.5) + 128
    ms = '@pos' + str(mi) + '\r'
    ser.write(bytes(ms, 'utf-8'))
    posvar.set(m)

def runNeg(xtra = 0):
    m = float(negmag.get())
    if m>11.5:
        m = 11.5
        negmag.invoke("buttonup")
    if m<-11.5:
        m=-11.6
        negmag.invoke("buttonup")
    mi = int(m*127/11.5) + 128
    ms = '@neg' + str(mi) + '\r'
    ser.write(bytes(ms, 'utf-8'))
    negvar.set(m)

def runFreq(xtra = 0):
    mi = int(freq.get())
    if mi>50:
        mi = 50
    if mi<4:
        mi=4
    ms = '@frq' + str(mi) + '\r'
    ser.write(bytes(ms, 'utf-8'))
    labelfreq.config(text = str(format(963.234/mi,'3.1f'))+'Hz')
    
def runStart(xtra = 0):
    m = float(startvar.get())
    mi = int(m*51)
    ms = '@dac' + str(mi) + '\r'
    ser.write(bytes(ms, 'utf-8'))

def runAdc(xtra = 0):
    c = b'ad'
    mi = int(adcvar.get())
    ms = '@adc' + str(mi) + '\r'
    ser.write(bytes(ms, 'utf-8'))
    line = ser.readline()
    chval = int(line[line.find(c)+4:])
    labeladc.config(text = str(format(chval*5.0/1024,'1.3f'))+' V')

def runSteps(xtra = 0):
    stepn.set(0)
    trcvar.set(0)
    mtrcvar.set(5)
    crampvar.set(True)
    contvar.set(False)
     
def runMark(c = b'cct'):
    n = int(trcvar.get())
    a = int(curvar.get())
    mkv[0] = x[n][a]
    mki[0] = y[n][a]
    mkt[0] = tms[n][a]
    labelm1.config(text = str(format(mkv[0],'0.3f'))+'V') 
    labelm2.config(text = str(format(mki[0],'0.3f'))+'mA')
    labelm3.config(text = str(format(mkt[0],'3.2f'))+'ms')
    runDelta()
    
def runDelta():
    n = int(trcvar.get())
    a = int(curvar.get())
    mi = int(freq.get())
    dv[0] = x[n][a] - mkv
    di[0] = y[n][a] - mki
    dt[0] = tms[n][a] - mkt
    try:
        f = abs(1000/dt[0])
    except:
        f = 10000
    labeld1.config(text = str(format(dv[0],'0.3f'))+'V') 
    labeld2.config(text = str(format(di[0],'0.3f'))+'mA')
    labeld3.config(text = str(format(dt[0],'3.2f'))+'ms      ' + str(format(f,'3.1f'))+' Hz')  
    try:
        r = abs(dv[0]/di[0]) * 1000
        c = (max(y[n][:]) - min(y[n][:]))/(max(x[n][:]) - min(x[n][:])) / (2 * np.pi * 0.963234/mi)
        labelr.config(text = 'R = ' + str(format(r,'6.0f'))+' ohms') 
        labelc.config(text = 'C = ' + str(format(c,'2.2f'))+' uF')
    except:
        labelr.config(text = 'R = inf ohms') 
        
def runXt():
    plotxy(0)

def runPlot(xtra = 0):
    plotxy(1)
    
def runSave(extra = 0):
    with filedialog.asksaveasfile() as f:
        for i in range(256):
            for j in range(10):
                f.write(str(format(x[j][i],'1.3f')+' '))            
                f.write(str(format(y[j][i],'1.3f')+' '))            
                f.write(str(format(tms[j][i],'1.6f')+' '))
            f.write('\n') 
        f.close()    
            
def runLoad(extra = 0):
    with filedialog.askopenfile() as f:
        for j in range(256):
            s = f.readline()
            fs = s.split(' ')
            for k in range(10):
                x[k][j] = float(fs[k*3])
                y[k][j] = float(fs[k*3+1])
                tms[k][j] = float(fs[k*3+2])
           
    f.close()
    plotxy(0)                    
        
def endserial():
    ser.close()
    root.destroy()     

globalVar()

stepn = IntVar()
stepn.set(-1) 

canvas.create_rectangle((0,0,512,512),fill='green')
for i in range(11):
    canvas.create_line((51.2*i, 0, 51.2*i, 512), fill='black', width=1) 
    canvas.create_line((0,51.2*i, 512, 51.2*i), fill='black', width=1) 

canvas.create_line((610,10,610,480), fill='grey', width=3)

canvas.create_line((520,10,605,10), fill='grey', width=3)
canvas.create_line((520,115,605,115), fill='grey', width=3)
canvas.create_line((520,220,605,220), fill='grey', width=3)
canvas.create_line((520,247,605,247), fill='grey', width=3)
canvas.create_line((520,335,605,335), fill='grey', width=3)
canvas.create_line((520,430,605,430), fill='grey', width=3)

canvas.create_line((620,10,705,10), fill='grey', width=3)
canvas.create_line((620,75,705,75), fill='grey', width=3)
canvas.create_line((620,170,705,170), fill='grey', width=3)
canvas.create_line((620,275,705,275), fill='grey', width=3)
canvas.create_line((620,370,705,370), fill='grey', width=3)

canvas.create_line((520,515,705,515), fill='grey', width=3)

trcvar = IntVar(value=0)  # initial value
trc = Spinbox(canvas, from_= 0, to = 4, increment = 1, width = 1, command = plotxy, textvariable=trcvar)
trc.place(x = 620, y = 20)
trcvar.set(0)

labeltrc = Label(canvas)
labeltrc.place(x = 645, y = 20)
labeltrc.config(text = 'Trace')

mtrcvar = IntVar(value=1)  # initial value
mtrc = Spinbox(canvas, from_= 1, to = 5, increment = 1, width = 1, command = plotxy, textvariable=mtrcvar)
mtrc.place(x = 620, y = 45)
mtrcvar.set(1)

labelmtrc = Label(canvas)
labelmtrc.place(x = 645, y = 45)
labelmtrc.config(text = 'Multiple')

trcsave = ttk.Button(canvas, text="Save", command = runSave)
trcsave.place(x = 620, y = 90)

trcload = ttk.Button(canvas, text="Load", command = runLoad)
trcload.place(x = 620, y = 130)

startvar = DoubleVar(value=0.6)  # initial value
startval = Spinbox(canvas, from_= 0.0, to = 5.0, increment = 0.02, width = 4, command = runStart, textvariable=startvar)
startval.place(x = 620, y = 185)
startvar.set(0.6)

labelstart = Label(canvas)
labelstart.place(x = 670, y = 185)
labelstart.config(text = 'Start')

stepvar = DoubleVar(value=0.88)  # initial value
stepval = Spinbox(canvas, from_= 0.0, to = 5.0, increment = 0.02, width = 4, textvariable=stepvar)
stepval.place(x = 620, y = 205)
stepvar.set(0.88)

labelstep = Label(canvas)
labelstep.place(x = 670, y = 205)
labelstep.config(text = 'Step')

trcload = ttk.Button(canvas, text="Run Steps", command = runSteps)
trcload.place(x = 620, y = 235)

adcvar = IntVar(value=0)  # initial value
adcval = Spinbox(canvas, from_= 0, to = 5, increment = 1, width = 4, textvariable=adcvar)
adcval.place(x = 620, y = 325)
adcvar.set(0)

labeladc = Label(canvas)
labeladc.place(x = 670, y = 325)
labeladc.config(text = '0.000 V')

adcread = ttk.Button(canvas, text="Read ADC", command = runAdc)
adcread.place(x = 620, y = 295)

cts = ttk.Button(canvas, text="Sine")
cts.place(x = 520, y = 20)
cts.bind("<Button-1>", runSine)

magvar = DoubleVar(value=11.5)  # initial value
sinmag = Spinbox(canvas, from_= 2.4, to = 11.5, increment = 0.1, width = 4, command = runMag, textvariable=magvar)
sinmag.place(x = 520, y = 50)
magvar.set(11.5)
sinmag.bind("<Return>", runMag)

labelmag = Label(canvas)
labelmag.place(x = 565, y = 50)
labelmag.config(text = 'Vp')

freqvar = DoubleVar(value=16)  # initial value
freq = Spinbox(canvas, from_= 4, to =50, increment = 1.0, width = 2, command = runFreq, textvariable=freqvar)
freq.place(x = 520, y = 75)
freqvar.set(16)

labelfreq = Label(canvas)
labelfreq.place(x = 560, y = 75)
labelfreq.config(text = '60.2 Hz')

cnt = ttk.Checkbutton(canvas, text="Cont. Sine", variable=contvar, onvalue=True)
cnt.place(x = 520, y = 95)

ctr = ttk.Button(canvas, text="Ramp")
ctr.place(x = 520, y = 125)
ctr.bind("<Button-1>", runRamp)

posvar = DoubleVar(value=11.5)  # initial value
posmag = Spinbox(canvas, from_= -11.5, to = 11.5, increment = 0.1, width = 4, command = runPos, textvariable=posvar)
posmag.place(x = 520, y = 155)
posvar.set(11.5)
posmag.bind("<Return>", runPos)

labelpos = Label(canvas)
labelpos.place(x = 565, y = 155)
labelpos.config(text = 'Vmax')

negvar = DoubleVar(value=-11.5)  # initial value
negmag = Spinbox(canvas, from_= -11.5, to = 11.5, increment = 0.1, width = 4, command = runNeg, textvariable=negvar)
negmag.place(x = 520, y = 180)
negvar.set(-11.5)
negmag.bind("<Return>", runNeg)

labelneg = Label(canvas)
labelneg.place(x = 565, y = 180)
labelneg.config(text = 'Vmin')

cramp = ttk.Checkbutton(canvas, text="Cont. Ramp", variable=crampvar, onvalue=True)
cramp.place(x = 520, y = 200)

xt = ttk.Checkbutton(canvas, text="X-t Plot", variable=xtvar, command=runXt, onvalue=True)
xt.place(x = 520, y = 225)

curvar = IntVar(value= 0)
cursor = Spinbox(canvas, from_= 0, to = 255, width = 4, command = runPlot, textvariable = curvar)
cursor.place(x = 520, y = 255)
cursor.bind("<Return>", runPlot)

labelcur = Label(canvas)
labelcur.place(x = 565, y = 255)
labelcur.config(text = 'Cursor')

label1 = Label(canvas)
label1.place(x = 520, y = 275)
label1.config(text = 'V')

label2 = Label(canvas)
label2.place(x = 520, y = 295)
label2.config(text = 'mA')

label3 = Label(canvas)
label3.place(x = 520, y = 315)
label3.config(text = 'ms')

mrk = ttk.Button(canvas, text="Mark")
mrk.place(x = 520, y = 345, height = 22)
mrk.bind("<Button-1>", runMark)

labelm1 = Label(canvas)
labelm1.place(x = 520, y = 370)
labelm1.config(text = 'V')

labelm2 = Label(canvas)
labelm2.place(x = 520, y = 390)
labelm2.config(text = 'mA')

labelm3 = Label(canvas)
labelm3.place(x = 520, y = 410)
labelm3.config(text = 'ms')

labeldt = Label(canvas)
labeldt.place(x = 540, y = 433)
labeldt.config(text = 'Delta')

labeld1 = Label(canvas)
labeld1.place(x = 520, y = 450)
labeld1.config(text = 'V')

labeld2 = Label(canvas)
labeld2.place(x = 520, y = 470)
labeld2.config(text = 'mA')

labeld3 = Label(canvas)
labeld3.place(x = 520, y = 490)
labeld3.config(text = 'ms')

labelr = Label(canvas)
labelr.place(x = 520, y = 520)
labelr.config(text = 'ohms')

labelc = Label(canvas)
labelc.place(x = 640, y = 520)
labelc.config(text = 'C = uF')

canvas.bind("<Button-1>", runMouse)

plotxy()

root.after(0, runCont)

root.wm_protocol ("WM_DELETE_WINDOW", endserial)

root.mainloop()
