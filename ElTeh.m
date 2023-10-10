%% Программа расчёта значений ДЗ1 Электротехника Вариант 63

% Hz
omega = 1000;

% Volt or Amper
E1_A = 977.5;
J2_A = 6.3;
E3_A = 1037.7;
E6_A = 200;


% Rad
fi0_e1 = -0.248;
fi0_J2 = 3.605;
fi0_e3 = 2.837;
fi0_e6 = 0.785;

R1 = 30; % Ohm
L1 = 20 * 10^(-3); % Hn
R2 = 10; % Ohm
R3 = 80; % Ohm
R4 = 60; % Ohm
C4 = 14.3 * 10^(-6); % F
R5 = 60; % Ohm
C5 = 10 * 10^(-6); % F

% Calculate imaginary equivalent

z1 = R1 + j * (omega * L1);
z2 = R2;
z3 = R3;
z4 = R4 - j / (omega * C4);
z5 = R5 - j / (omega * C5);

E1 = (E1_A/sqrt(2)) * (cos(fi0_e1) + j*sin(fi0_e1));
E3 = (E3_A/sqrt(2)) * (cos(fi0_e3) + j*sin(fi0_e3));
E6 = (E6_A/sqrt(2)) * (cos(fi0_e6) + j*sin(fi0_e6));
J2 = (J2_A/sqrt(2)) * (cos(fi0_J2) + j*sin(fi0_J2));

% Method of equivalent currents

A = [1, 0, 0;
    -z3, z5+z3, z5;
    z1, z5, z1+z4+z5];
B = [J2;
    -E3-E6;
    E1];

X = linsolve(A, B);
I_I = X(1, 1);
I_II = X(2, 1);
I_III = X(3, 1);

I1 = I_I + I_III;
I2 = I_I;
I3 = I_I - I_II;
I4 = - I_III;
I5 = I_III;
I6 = -I_II;

U_J2 = I2 * z2 + I1 * z1 + I3 * z3 - E1 - E3;


FileID = fopen("./ElTeh_output.txt", "w");
string = "Вычесленные значения: \n\n";

string = string + "Мгновенные значения напряжений и токов на источниках:\n";

string = string + "E1 = " + real(E1) + " + j(" + imag(E1) + ")\n";
string = string + "E3 = " + real(E3) + " + j(" + imag(E3) + ")\n";
string = string + "E6 = " + real(E6) + " + j(" + imag(E6) + ")\n";
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
string = string + "U_J2 = " + real(U_J2) + " + j(" + imag(U_J2) + ")\n";


fprintf(FileID, string);
fclose(FileID);