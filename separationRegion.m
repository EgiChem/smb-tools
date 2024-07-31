clc;

Q = [17.544	17.606];  % Langmuir isotherm constant Q (capacity)
b = [0.103	0.109];  % Langmuir isotherm constant b (b1 < b2)
Cfeed = [1.5 0.5];
m2m3 = [];

triangleTheory.plotLinearSepRegion(Q.*b, m2m3)
hold on;
triangleTheory.plotLangmuirSepRegion(Q, b, Cfeed, m2m3)