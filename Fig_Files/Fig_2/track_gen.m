clear all
close all
clc


theta = linspace(0, 2*pi, 50);
theta(end) = [];

radius = 30e-03;

x = radius.*sin(theta);
y = radius.*cos(theta);
z = 0.1;

phase = asin(sin(2.*theta));

