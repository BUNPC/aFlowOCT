function varargout = GUI_Flow_Vz(varargin)
% GUI_Flow_Vz MATLAB code for GUI_Flow_Vz.fig
%      GUI_Flow_Vz, by itself, creates a new GUI_Flow_Vz or raises the existing
%      singleton*.
%
%      H = GUI_Flow_Vz returns the handle to a new GUI_Flow_Vz or the handle to
%      the existing singleton*.
%
%      GUI_Flow_Vz('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_Flow_Vz.M with the given input arguments.
%
%      GUI_Flow_Vz('Property','Value',...) creates a new GUI_Flow_Vz or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_Flow_Vz_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_Flow_Vz_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_Flow_Vz

% Last Modified by GUIDE v2.5 25-Aug-2017 16:25:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_Flow_Vz_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_Flow_Vz_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% clear;clc
% --- Executes just before GUI_Flow_Vz is made visible.
function GUI_Flow_Vz_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_Flow_Vz (see VARARGIN)
%% add MATLAB functions' path
% addpath('/autofs/cluster/MOD/OCT/Jianbo/CODE/Functions') % Path on server
addpath('/projectnb/npboctiv/ns/Evren/CODES/Vz for Flow')
addpath('/projectnb/npboctiv/ns/Evren/CODES/Vz for Flow')
handles.defpath='/projectnb/npboctiv/ns/Evren/EXPERIMENTS/';
handles.avg=0;
handles.lam0=1310; % center frequency, nm
handles.lam_w=170; % bandwidth, nm
handles.dZ=3.29; % axial resolution, um
handles.SingMuti=1; % 
handles.GGori=0;
% Choose default command line output for GUI_Flow_Vz
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_Flow_Vz wait for user response (see UIRESUME)
% uiwait(handles.figure1);
% --- Executes on button press in btnfile.
function btnfile_Callback(hObject, eventdata, handles)
% hObject    handle to btnfile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
addpath('/projectnb/npboctiv/ns/Evren/CODES/Vz for Flow')
addpath('/projectnb/npboctiv/ns/Evren/CODES/Vz for Flow')
%% select file path %%%%%%%%%
defaultpath=handles.defpath;
[filename,datapath]=uigetfile(defaultpath);
handles.defpath=datapath;
guidata(hObject, handles);
% pathparts=strsplit(datapath,'\');
% filefolder=pathparts{end-1};
%% load data %%%%%%%%%%
%%%%% input number of sub GG to be loaded %%%%%%%%
%%%% show data loading information
filename_Vz=filename;
filename_Vz(1:2)='Vz';
%%%% load data %%%%%%%%
lding=msgbox(['Loading data...  ',datestr(now,'DD:HH:MM')]);
Vz=LoadMAT(datapath,filename_Vz);
[nz,nx,ny]=size(Vz);
lded=msgbox(['Data loaded. ',datestr(now,'DD:HH:MM')]);
pause(0.5);
delete(lding); delete(lded);
%% 
prompt={['Xlength (um),)nx=',num2str(nx),')'],['Ylength (um),)ny=',num2str(ny),')']};
numinput=inputdlg(prompt,'pixel size',1,{num2str(nx*1.5),num2str(ny*1.5)});
l_pix_x=str2num(numinput{1})/nx*1e-3; % mm
l_pix_y=str2num(numinput{2})/ny*1e-3; % mm

%% global 
handles.pix_x=l_pix_x;
handles.pix_y=l_pix_y;
handles.Vz=Vz;
handles.datapath=datapath;
handles.filename=filename;
guidata(hObject, handles);


% --- Executes on button press in btnSHOWXY.
function btnSHOWXY_Callback(hObject, eventdata, handles)
%%%%%%%%%%
addpath('/projectnb/npboctiv/ns/Evren/CODES/Vz for Flow')
addpath('/projectnb/npboctiv/ns/Evren/CODES/Vz for Flow')
%%%%%%%%%
Vz=handles.Vz;
[Vcmap, Vzcmap, Dcmap, Mfcmap, Rcmap]=Colormaps_DLSOCT;
StartZ=str2num(get(handles.startZ,'string'));
StackZ=str2num(get(handles.stackZ,'string'));
VzShow=squeeze(max(abs(Vz(StartZ:StartZ+StackZ,:,:)),[],1)).*squeeze(sign(min(Vz(StartZ:StartZ+StackZ,:,:),[],1)+0.01));
axes(handles.AXEACF1);
imagesc(VzShow);colormap(Vzcmap);caxis([-2 2]);

handles.Viz=VzShow;
guidata(hObject,handles);
% --- Executes on button press in btnsltLocs.

% --- Executes on button press in VesSlt.
function VesSlt_Callback(hObject, eventdata, handles)
% hObject    handle to VesSlt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% hObject    handle to SEGselect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%%
Img_V=handles.Viz;
StartZ=str2num(get(handles.startZ,'string'));
StackZ=str2num(get(handles.stackZ,'string'));
Fgaxe(1)=handles.AXEACF1; 
[Vcmap, Vzcmap, Dcmap, Mfcmap, Rcmap]=Colormaps_DLSOCT;
%%%% INPUT number of locs to analysis
% prompt={'Number of Vertices for mask polygon '};
% numinput=inputdlg(prompt,'Select Locs',1,{'6'});
numinput={'12'};
if ~isempty(numinput)
    Select_locs=str2num(numinput{:});
    %% Get selected coordinates of locs
    [loc_x, loc_y]=ginput(Select_locs);  % no image rotation,
    BW=roipoly(Img_V,loc_x,loc_y);
    handles.BW=BW;
    ImgV_slt=Img_V.*BW;
    
    %%
    Vz_roi=ImgV_slt(abs(ImgV_slt)>0.1);
    size_roi=numel(Vz_roi)*handles.pix_x*handles.pix_y; % mm^2
    flow_roi=sum(Vz_roi)*handles.pix_x*handles.pix_y; % mm^3/s
    
    flow_roi_ml=flow_roi/1000; % ml/s
    figure,
    OlapPlot = imagesc(ImgV_slt);colormap(Vzcmap); caxis([-3 3]);
    title (['iz=',num2str(StartZ),'-', num2str(StartZ+StackZ),', Flow=',num2str(flow_roi_ml),' ml/s; ','Avg_Vz=',num2str(mean(Vz_roi)),'; Size=', num2str(size_roi),' mm^2']);
end
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_Flow_Vz_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;




function Select_it_Callback(hObject, eventdata, handles)
% hObject    handle to Select_it (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Select_it as text
%        str2double(get(hObject,'String')) returns contents of Select_it as a double


% --- Executes during object creation, after setting all properties.
function Select_it_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Select_it (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes during object creation, after setting all properties.
function AXEXY1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AXEXY1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate AXEXY1


function shname_Callback(hObject, eventdata, handles)
% hObject    handle to shname (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of shname as text
%        str2double(get(hObject,'String')) returns contents of shname as a double


% --- Executes during object creation, after setting all properties.
function shname_CreateFcn(hObject, eventdata, handles)
% hObject    handle to shname (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function startZ_Callback(hObject, eventdata, handles)
% hObject    handle to startZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of startZ as text
%        str2double(get(hObject,'String')) returns contents of startZ as a double


% --- Executes during object creation, after setting all properties.
function startZ_CreateFcn(hObject, eventdata, handles)
% hObject    handle to startZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function intZ_Callback(hObject, eventdata, handles)
% hObject    handle to intZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of intZ as text
%        str2double(get(hObject,'String')) returns contents of intZ as a double


% --- Executes during object creation, after setting all properties.
function intZ_CreateFcn(hObject, eventdata, handles)
% hObject    handle to intZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function shLocs_Callback(hObject, eventdata, handles)
% hObject    handle to shLocs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of shLocs as text
%        str2double(get(hObject,'String')) returns contents of shLocs as a double


% --- Executes during object creation, after setting all properties.
function shLocs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to shLocs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end






function shFIT_Callback(hObject, eventdata, handles)
% hObject    handle to shFIT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of shFIT as text
%        str2double(get(hObject,'String')) returns contents of shFIT as a double


% --- Executes during object creation, after setting all properties.
function shFIT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to shFIT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end






function perfACF_Callback(hObject, eventdata, handles)
% hObject    handle to perfACF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of perfACF as text
%        str2double(get(hObject,'String')) returns contents of perfACF as a double


% --- Executes during object creation, after setting all properties.
function perfACF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to perfACF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function resolution_Callback(hObject, eventdata, handles)
% hObject    handle to resolution (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of resolution as text
%        str2double(get(hObject,'String')) returns contents of resolution as a double


% --- Executes during object creation, after setting all properties.
function resolution_CreateFcn(hObject, eventdata, handles)
% hObject    handle to resolution (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function btnFIT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to btnFIT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in Reset.
function Reset_Callback(hObject, eventdata, handles)
% hObject    handle to Reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.defpath='D:\EXPERIMENT';
handles.avg=0;
handles.lam0=1310; % center frequency, nm
handles.lam_w=170; % bandwidth, nm
handles.dZ=3.29; % axial resolution, um
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function btnfile_CreateFcn(hObject, eventdata, handles)
% hObject    handle to btnfile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function stackZ_Callback(hObject, eventdata, handles)
% hObject    handle to stackZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of stackZ as text
%        str2double(get(hObject,'String')) returns contents of stackZ as a double


% --- Executes during object creation, after setting all properties.
function stackZ_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stackZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
