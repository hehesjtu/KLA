clear all; clc; warning off; close all;
%Manga，BSDS200,General100,RealSRSet、T91
clear all;clc;close all;warning off;
Pathr = '.\data\';
Pathw = '.\resuls\';
if ~exist(Pathw, 'dir')  
    mkdir(Pathw);  
end  
Files = dir(strcat(Pathr,'*.png')); 
LengthFiles = length(Files);
factor = 4;
global N T;
% Control parameters

global K1 ; 
global K2 ;
N =6; % The number of search agents in the optimization algorithm
T = 5; % Maximum number of iterations
 K1 = 0.001; 
 K2 = 0.001;
% Initialize the time record variable.
totalTime = 0;
timePerImage = zeros(LengthFiles, 1);
for ii = 1:LengthFiles
    disp(strcat('Now is processing the image named:',Files(ii).name));
    tic
    image=double(imread(strcat(Pathr,Files(ii).name)));
    outimg1=image(:,:,1);
    outimg2=image(:,:,2);
    outimg3=image(:,:,3);
    % using KOA to get H1
    H1_outimg1= KLA(outimg1);             
    H1_outimg2= KLA(outimg2); 
    H1_outimg3= KLA(outimg3);
    % get details
    Details=zeros(size(image,1),size(image,2),3);
    Details(:,:,1)=imresize(H1_outimg1,[size(image,1),size(image,2)],'bilinear');
    Details(:,:,2)=imresize(H1_outimg2,[size(image,1),size(image,2)],'bilinear');
    Details(:,:,3)=imresize(H1_outimg3,[size(image,1),size(image,2)],'bilinear');
    % add details to the original images
    outimg1=outimg1+Details(:,:,1)*factor;
    outimg2=outimg2+Details(:,:,2)*factor;
    outimg3=outimg3+Details(:,:,3)*factor;
    outimg(:,:,1)=outimg1;
    outimg(:,:,2)=outimg2;
    outimg(:,:,3)=outimg3;
    outimg = uint8(outimg);
    toc
      imwrite(outimg,strcat(Pathw, Files(ii).name(1:end-4),'_X',num2str(factor),'_KLA.png'));
    elapsedTime = toc; % Stop the timer.
    timePerImage(ii) = elapsedTime;
    totalTime = totalTime + elapsedTime;
    
    fprintf('图片 %d/%d 处理完成，耗时: %.4f s\n', ii, LengthFiles, elapsedTime);    

      clear outimg;
    disp('...........................');
end
% Calculate and display statistical information.
averageTime = totalTime / LengthFiles;
fprintf('\n处理完成！\n');
fprintf('总处理时间: %.4f 秒\n', totalTime);
fprintf('平均每张图片处理时间: %.4f 秒\n', averageTime);

