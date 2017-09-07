clear;
close all;

f1 = figure;
figure(f1);

axis([-2 2 -2 2])
hold on

global trajectory;
global mouseDown;
global recordFinished;

trajectory = [];
mouseDown = false;
recordFinished = false;

set(gcf, 'WindowButtonMotionFcn', @mouseMove);
set(gcf,'WindowButtonDownFcn', @record, 'WindowButtonUpFcn',   @stop);