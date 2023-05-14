function varargout = pro1(varargin)
% PRO1 MATLAB code for pro1.fig
%      PRO1, by itself, creates a new PRO1 or raises the existing
%      singleton*.
%
%      H = PRO1 returns the handle to a new PRO1 or the handle to
%      the existing singleton*.
%
%      PRO1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PRO1.M with the given input arguments.
%
%      PRO1('Property','Value',...) creates a new PRO1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before pro1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to pro1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help pro1

% Last Modified by GUIDE v2.5 18-May-2022 23:53:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @pro1_OpeningFcn, ...
                   'gui_OutputFcn',  @pro1_OutputFcn, ...
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


% --- Executes just before pro1 is made visible.
function pro1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to pro1 (see VARARGIN)

% Choose default command line output for pro1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes pro1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = pro1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in threshold.
function threshold_Callback(hObject, eventdata, handles)
% hObject    handle to threshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=getappdata(0,'a');
image=a
grayImage=rgb2gray(image);

[h r]=size(grayImage);
for i=1:h
    for j=1:r
        if image(i,j)>=150
            y(i,j)=255;
        else
            y(i,j)=0;
        end
    end
end 

imshow(y);



% --- Executes on button press in contrast.
function contrast_Callback(hObject, eventdata, handles)
% hObject    handle to contrast (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global oldim
%  a=getappdata(0,'a');
prompt = {'Enter max value:','Enter min value:'};
dlgtitle = 'Input';
dims = [1 35];
definput = {'255','0'};
n= inputdlg(prompt,dlgtitle,dims,definput)
s_max=str2double(n{1})
s_min=str2double(n{2})
% oldim=a

r_max=max(oldim)
r_min=min(oldim)

s_min=0
S=(s_max-s_min)./(r_max-r_min).*(oldim-r_min)+s_min
imshow(S)
oldim=S
% --- Executes on button press in darken.
function darken_Callback(hObject, eventdata, handles)
% hObject    handle to darken (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=getappdata(0,'a');
adark=a
gray_image = rgb2gray(adark); 
subImage = gray_image-120;
imshow(subImage)


% --- Executes on button press in lighten.
function lighten_Callback(hObject, eventdata, handles)
% hObject    handle to lighten (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=getappdata(0,'a');
alight=a
gray_image = rgb2gray(alight); 
AddImage = gray_image+120;
imshow(AddImage)

% --- Executes on button press in slicing.
function slicing_Callback(hObject, eventdata, handles)
% hObject    handle to slicing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=getappdata(0,'a');
asli=a
gray_image = rgb2gray(asli);  
newImage = gray_image;
[rows cols] = size(gray_image);
for row_index=1:1:rows
    for col_index=1:1:cols
        if(gray_image(row_index,col_index)>=100 && gray_image(row_index,col_index)<=150)
            newImage(row_index,col_index) = 255;
        else
             newImage(row_index,col_index) = 0;
        end
    end
end
imshow(newImage);




% --- Executes on button press in upload.
function upload_Callback(hObject, eventdata, handles)
% hObject    handle to upload (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=uigetfile('.jpg')
a=imread(a);
axes(handles.axes1);
imshow(a);

setappdata(0,'a',a)
% --- Executes on button press in subsample.
function subsample_Callback(hObject, eventdata, handles)
% hObject    handle to subsample (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

a=getappdata(0,'a');
asub=a

[rows cols matricesNo] = size(asub);
SamplingFactor = 16;
for metricesIndex=1:1:matricesNo
    resizedImage(:,:,metricesIndex) = subSampling(asub(:,:,metricesIndex),SamplingFactor);
end
imshow(resizedImage);
imwrite(resizedImage,'resizedImage.png');
function [outImage] = subSampling(image, subSamplingFactor)
[rows cols] = size(image);
outImage = image(1:subSamplingFactor:rows,1:subSamplingFactor:cols);
% --- Executes on button press in gray.
function gray_Callback(~, eventdata, handles)
% hObject    handle to gray (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in neg.
function neg_Callback(hObject, eventdata, handles)
% hObject    handle to neg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=getappdata(0,'a');
aneg=a
% global oldim
L = 2 ^ 8; 
neg = (L - 1) - aneg;
imshow(neg)
% oldim=neg
%   
% --- Executes on button press in log.
function log_Callback(hObject, eventdata, handles)
% hObject    handle to log (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=getappdata(0,'a');
alog=a
gray_image = rgb2gray(alog);
double_value = im2double(gray_image);
out1= 2*log(1+double_value);
imshow(out1)


% --- Executes on button press in power.
function power_Callback(hObject, eventdata, handles)
% hObject    handle to power (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles  structure with handles and user data (see GUIDATA)
a=getappdata(0,'a');
% global oldim
prompt = "What is the power value? ";
dlgtitle = 'Input';
dims = [1 35];
definput = {'2','hsv'};
n= inputdlg(prompt,dlgtitle,dims,definput)
h=str2double(n)
c=1
apow=a
gray_image = rgb2gray(apow);
double_value = im2double(apow);
out2= c*(double_value.^h);
imshow(out2)
oldim=out2


% --- Executes on button press in hestogram.
function hestogram_Callback(hObject, eventdata, handles)
% hObject    handle to hestogram (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=getappdata(0,'a');
ahesto=a
gray_image = rgb2gray(ahesto);  
[rows,cols]=size(gray_image);
counts=zeros(1,256);
for i=1:rows
 for j=1:cols
    grayLevel=gray_image(i,j);
    counts(grayLevel+1)=counts(grayLevel+1)+1;
end
end
grayLevels = 0 : 255;
bar(grayLevels, counts, 'BarWidth', 1, 'FaceColor', 'b');
xlabel('Gray Level', 'FontSize', 20);
ylabel('Pixel Count', 'FontSize', 20);
title('Histogram', 'FontSize', 20);
grid on;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in re.
function re_Callback(hObject, eventdata, handles)
% hObject    handle to re (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in ex.
function ex_Callback(hObject, eventdata, handles)
% hObject    handle to ex (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox('thanks for using image processing tool')
pause(1)
close();
close();


% --- Executes on button press in bit.
function bit_Callback(hObject, eventdata, handles)
% hObject    handle to bit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=getappdata(0,'a');
abit=a
gray_image = rgb2gray(abit); 
[rows cols] = size(gray_image);
newImage = zeros(rows,cols,8);
for k=1:8
    for row_index=1:1:rows
        for col_index=1:1:cols
            newImage(row_index,col_index,k)=bitget(gray_image(row_index,col_index),k);
        end
    end
end
prompt = "enter bit number ";
dlgtitle = 'Input';
dims = [1 35];
definput = {'4','hsv'};
n= inputdlg(prompt,dlgtitle,dims,definput)
k=str2double(n)  
% subplot(2, 5, k+1),
imshow(newImage(:,:,k));







% --- Executes on button press in median.
function median_Callback(hObject, eventdata, handles)
% hObject    handle to median (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% a=getappdata(0,'a');
% amed=a
global oldim
% gray_image = rgb2gray(oldim); 

[rows,cols]=size(oldim);
out=oldim;
for i=2:rows-1
 for j=2:cols-1
     temp = [oldim(i-1, j-1) oldim(i-1, j) oldim(i-1, j + 1) oldim(i, j-1) oldim(i, j) oldim(i, j + 1) oldim(i + 1, j-1) oldim(i + 1, j) oldim(i + 1, j + 1)];
     temp = sort(temp);
     out(i, j)= temp(5);
end
end
imshow(out)
oldim=out

% --- Executes on button press in avg.
function avg_Callback(hObject, eventdata, handles)
% hObject    handle to avg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global oldim
% a=getappdata(0,'a');
% aavg=a

aavg=oldim
[row,cols]=size(aavg);
for i=4:1:row-3
    
    for j=4:1:cols-3
        
        x=aavg(i-3 :i+3 ,j-3:j+3);
       
        c=x(:)';
        
        c=sort(c);
        
        avg=sum(c)/49;
        
        aavg(i,j)=avg;
    end
end 
imshow(aavg);
oldim=aavg
% --- Executes on button press in sharp.
function sharp_Callback(hObject, eventdata, handles)
% hObject    handle to sharp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% a=getappdata(0,'a');
% asharp=a
global oldim
% gray_image = rgb2gray(asharp);  
double_image = double(oldim);
[rows,cols]=size(oldim);
mask = [0,1,0;1,-4,1;0,1,0];
out = oldim;
for i=2:rows-1
 for j=2:cols-1
     temp = mask.*double_image(i-1:i+1,j-1:j+1);
     value = sum(temp(:));
     out(i, j)= value;
end
end
imshow(out)
oldim= out 
% --- Executes on button press in togray.
function togray_Callback(hObject, eventdata, handles)
% hObject    handle to togray (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global oldim
a=getappdata(0,'a');
oldim=a
gray=rgb2gray(oldim)
imshow(gray)
oldim=gray


% --- Executes on button press in bw.
function bw_Callback(hObject, eventdata, handles)
% hObject    handle to bw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=getappdata(0,'a');
abw=a
grayImage=rgb2gray(abw);
[h r]=size(image);
for i=1:h
    for j=1:r
        if ashold(i,j)>=150
            y(i,j)=255;
        else
            y(i,j)=0;
        end
    end
end 
imshow(grayImage)


% --- Executes on button press in lap.
function lap_Callback(hObject, eventdata, handles)
% hObject    handle to lap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=getappdata(0,'a');
alap=a;
gray_image = rgb2gray(alap);  
 gray_image = double(alap);
[rows,cols]=size(gray_image);
mask = [0,-1,0;-1,5,-1;0,-1,0];
out = gray_image;
for i=2:rows-1
 for j=2:cols-1
     temp = mask.*gray_image(i-1:i+1,j-1:j+1);
     value = sum(temp(:));
     out(i, j)= value;
end
end
out = uint8(out);
imshow(out)


% --- Executes on button press in sobel.
function sobel_Callback(hObject, eventdata, handles)
% hObject    handle to sobel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=getappdata(0,'a');
asob=a
gray_image = double(asob);
[rows,cols]=size(gray_image);
% mask = [-1 -2 -1;0 0 0;1 2 1];
mask = [-1 0 1;-2 0 2;-1 0 1];
out = gray_image;
for i=2:rows-1
 for j=2:cols-1
     temp = mask.*gray_image(i-1:i+1,j-1:j+1);
     value = sum(temp(:));
     out(i, j)= value;
end
end
out = uint8(out);
imshow(out)


% --- Executes on button press in low.
function low_Callback(hObject, eventdata, handles)
% hObject    handle to low (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=getappdata(0,'a');
image=a
alow = rgb2gray(image); 
[M, N] = size(alow);
 FT_img = fft2(double(alow));
  D0 = 30; 
u = 0:(M-1);
idx = find(u>M/2);
u(idx) = u(idx)-M;
v = 0:(N-1);
idy = find(v>N/2);
v(idy) = v(idy)-N;
[V, U ] = meshgrid(v, u);
D = sqrt(U.^2+V.^2);
H = double(D <= D0);
G = H.*FT_img;
 
output_image = real(ifft2(double(G)));
%   subplot(2, 1, 1), imshow(alow),
% subplot(2, 1, 2), imshow(output_image, [ ]);
newImage=cat(2,alow,output_image)
imshow(newImage)

% --- Executes on button press in pushbutton41.
function pushbutton41_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=getappdata(0,'a');
ahi=a
[M, N ,~] = size(ahi);
FT_img = fft2(double(ahi));
D0 = 10;
u = 0:(M-1);
idx = find(u>M/2);
u(idx) = u(idx)-M;
v = 0:(N-1);
idy = find(v>N/2);
v(idy) = v(idy)-N;
[V, U] = meshgrid(v, u);
D = sqrt(U.^2+V.^2);
H = double(D > D0);
G = H.*FT_img;
output_image = real(ifft2(double(G)));
imshow(output_image, [ ]);


% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function figure1_WindowButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function axes2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes2
imshow('b2.jpg')


% --- Executes on button press in blbf.
function blbf_Callback(hObject, eventdata, handles)
% hObject    handle to blbf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in glpf.
function glpf_Callback(hObject, eventdata, handles)
% hObject    handle to glpf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=getappdata(0,'a');
agl=a
[M, N,~] = size(agl);
FT_img = fft2(double(agl));
D0 = 15; 
D0 = (D0^2)*2;
u = 0:(M-1);
idx = find(u>M/2);
u(idx) = u(idx)-M;
v = 0:(N-1);
idy = find(v>N/2);
v(idy) = v(idy)-N;
[V, U] = meshgrid(v, u);
D = sqrt(U.^2+V.^2);

D = -D.^2;
H = exp(D/D0);
G = H.*FT_img;
output_image = real(ifft2(double(G)));
imshow(output_image, [ ]);
newImage=cat(2,agl,output_image)
imshow(newImage)






% --- Executes on button press in blpf.
function blpf_Callback(hObject, eventdata, handles)
% hObject    handle to blpf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=getappdata(0,'a');
 abl=a
 [M, N,~] = size(abl);
 FT_img = fft2(double(abl));
 D0 = 15; 
n=2*2;
u = 0:(M-1);
idx = find(u>M/2);
u(idx) = u(idx)-M;
v = 0:(N-1);
idy = find(v>N/2);
v(idy) = v(idy)-N;
[V, U] = meshgrid(v, u);
D = sqrt(U.^2+V.^2);
D = D./ D0;
H = 1./((1+D).^n);
G = H.*FT_img;
output_image = real(ifft2(double(G)));
imshow(output_image, [ ]);
newImage=cat(2,abl,output_image)
imshow(newImage)


% --- Executes on button press in gr2.
function gr2_Callback(hObject, eventdata, handles)
% hObject    handle to gr2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=getappdata(0,'a');
ags=a
gray_image = rgb2gray(ags);  
newImage = gray_image;
[rows, cols] = size(gray_image);
for row_index=1:1:rows
    for col_index=1:1:cols
        if(gray_image(row_index,col_index)>=100 && gray_image(row_index,col_index)<=150)
            newImage(row_index,col_index) = 255;
        else
             newImage(row_index,col_index) = gray_image(row_index,col_index);
        end
    end
end

imshow(newImage);


% --- Executes on button press in adim.
function adim_Callback(hObject, eventdata, handles)
% hObject    handle to adim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=getappdata(0,'a');
id=a
im1=rgb2gray(id);
id2=imread("im2.jpg")
im2=rgb2gray(id2);
 im1=imresize(im1,size(im2))
k = im1 + im2 ;
imshow(k)


% --- Executes on button press in sbi.
function sbi_Callback(hObject, eventdata, handles)
% hObject    handle to sbi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

a=getappdata(0,'a');
is=a
im11=rgb2gray(is);
id2=imread("im2.jpg")
im22=rgb2gray(id2);
 im11=imresize(im11,size(im22))
b = im11 - im22 ;
imshow(b)


% --- Executes on button press in max.
function max_Callback(hObject, eventdata, handles)
% hObject    handle to max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=getappdata(0,'a');
img=a
out=img;
[rows,cols]=size(img);
for i=2:rows-1
 for j=2:cols-1
          out(i,j)=max([img(i-1,j-1) img(i-1,j) img(i-1,j+1) img(i,j-1) img(i,j) img(i,j+1) img(i+1,j-1) img(i+1,j) img(i+1,j+1)]);
         
 end
end
imshow(out);


% --- Executes on button press in min.
function min_Callback(hObject, eventdata, handles)
% hObject    handle to min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=getappdata(0,'a');
img=a
out=img;
[rows,cols]=size(img);
for i=2:rows-1
 for j=2:cols-1
          out(i,j)=min([img(i-1,j-1) img(i-1,j) img(i-1,j+1) img(i,j-1) img(i,j) img(i,j+1) img(i+1,j-1) img(i+1,j) img(i+1,j+1)]);
         
 end
end
imshow(out);


% --- Executes on button press in eq.
function eq_Callback(hObject, eventdata, handles)
% hObject    handle to eq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=getappdata(0,'a');
aeq=a
GIm = rgb2gray(aeq);
numofpixels=size(GIm,1)*size(GIm,2);
HIm=uint8(zeros(size(GIm,1),size(GIm,2)));

freq=zeros(256,1);

probc=zeros(256,1);

output=zeros(256,1);

for i=1:size(GIm,1)

    for j=1:size(GIm,2)

        value=GIm(i,j);

        freq(value+1)=freq(value+1)+1;

    end

end

sum=0;
no_bins=255;

for i=1:size(freq)

   sum=sum+freq(i);

   probc(i)=sum/numofpixels;

   output(i)=round(probc(i)*no_bins);

end

for i=1:size(GIm,1)

    for j=1:size(GIm,2)

            HIm(i,j)=output(GIm(i,j)+1);

    end

end
imshow(HIm);


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);


% --- Executes during object creation, after setting all properties.
function axes3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes3
imshow('E:\Martina\Faculty\year 3\Second Term\DIP\Project\istockphoto-995719694-170667a.jpg');
