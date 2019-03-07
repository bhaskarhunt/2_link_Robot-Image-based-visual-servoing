function o02 = posit12(theta1,theta2,l1,l2)
c1 = cos(theta1);
s1 = sin(theta1);
c2 = cos(theta2);
s2 = sin(theta2);
c12 = cos(theta1 + theta2);
s12 = sin(theta1 + theta2);
o02 = [l1*c1 + l2*c12,l1*s1+l2*s12,0];
end