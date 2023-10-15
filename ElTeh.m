e1 = (977.5 / sqrt(2)) * (cos(-0.248) + j * sin(-0.248));
J2 = (6.3 / sqrt(2)) * (cos(3.605) + j * sin(3.605));
e3 = (1037.7 / sqrt(2)) * (cos(2.837) + j * sin(2.837));
e6 = (200.0 / sqrt(2)) * (cos(0.785) + j * sin(0.785));

omega = 1000;

z1 = 30 + j * omega * 20 * 10^(-3);
z2 = 10;
z3 = 80;
z4 = 60 - j / (omega * 14.3 * 10^(-6));
z5 = 60 - j / (omega * 10.0 * 10^(-6));

A = [1, 0, 0;
     -z3, z5 + z3, z5;
     z1, z5, z5 + z1 + z4];
B = [J2;
     -e3 - e6;
     e1];
X = linsolve(A, B);

I_I = X(1, 1);
I_II = X(2, 1);
I_III = X(3, 1);

I1 = - I_I - I_III;
I2 = I_I;
I3 = I_I - I_II;
I4 = I_III;
I5 = - I_III - I_II;
I6 = - I_II;

Uj = I2 * z2 - I1 * z1 + I3 * z3 - e3 - e1;

% Генератор

z_gen = (z3 * z5) / (z3 + z5) + z1;

I_I_gen = J2;
I_II_gen = (e1 + e3 + e6 - I_I_gen * (z1 + z3)) / (z1 + z3 + z4);
I3_s = I_I_gen + I_II_gen;

U_gen = e3 + e6 - I3_s * z3;

z_pair = z1 + z4;
z_gen = (z_pair * z3) / (z_pair + z3);

z_all = z_gen + z5;
I5_gen = U_gen / z_all;



FileID = fopen("./EltehOut.txt", "w");

string = "Вычесленные значения: \n\n";

string = string + "Мгновенные значения напряжений и токов на источниках:\n";

string = string + "E1 = " + real(e1) + " + j(" + imag(e1) + ")\n";
string = string + "E3 = " + real(e3) + " + j(" + imag(e3) + ")\n";
string = string + "E6 = " + real(e6) + " + j(" + imag(e6) + ")\n";
string = string + "J2 = " + real(J2) + " + j(" + imag(J2) + ")\n\n";

string = string + "Комплексные эквиваленты сопротивлений:\n";
string = string + "Z1 = " + real(z1) + " + j(" + imag(z1) + ")\n";
string = string + "Z2 = " + real(z2) + " + j(" + imag(z2) + ")\n";
string = string + "Z3 = " + real(z3) + " + j(" + imag(z3) + ")\n";
string = string + "Z4 = " + real(z4) + " + j(" + imag(z4) + ")\n";
string = string + "Z5 = " + real(z5) + " + j(" + imag(z5) + ")\n\n";

string = string + "Вычесленные токи:\n";
string = string + "I1 = " + real(I1) + " + j(" + imag(I1) + ")\n";
string = string + "I2 = " + real(I2) + " + j(" + imag(I2) + ")\n";
string = string + "I3 = " + real(I3) + " + j(" + imag(I3) + ")\n";
string = string + "I4 = " + real(I4) + " + j(" + imag(I4) + ")\n";
string = string + "I5 = " + real(I5) + " + j(" + imag(I5) + ")\n";
string = string + "I6 = " + real(I6) + " + j(" + imag(I6) + ")\n\n";

string = string + "Напряжение на источнике тока:\n";
string = string + "U_J2 = " + real(Uj) + " + j(" + imag(Uj) + ")\n\n";

string = string + "Расчёт тока I5 методом эквивалентного генератора:\n";
string = string + "Zэкв = " + real(z_gen) + " + j(" + imag(z_gen) + ")\n";
string = string + "Eэкв = " + real(U_gen) + " + j(" + imag(U_gen) + ")\n";
string = string + "I5 = " + real(I5_gen) + " + j(" + imag(I5_gen) + ")\n";

fprintf(FileID, string);

fclose(FileID);
