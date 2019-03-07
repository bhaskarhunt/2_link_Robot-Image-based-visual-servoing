function R02 = rotation(theta1,theta2)
c1 = cos(theta1);
s1 = sin(theta1);
c2 = cos(theta2);
s2 = sin(theta2);
c12 = cos(theta1 + theta2);
s12 = sin(theta1 + theta2);
R02 = [c12,-s12,0;s12,c12,0;0,0,1];
end