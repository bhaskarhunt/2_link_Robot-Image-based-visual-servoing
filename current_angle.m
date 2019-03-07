function a = current_angle(endfactor_coordinate,l1,l2)
x = endfactor_coordinate(1);
y = endfactor_coordinate(2);
% alpha = acos((l1^2 + l2^2 - endfactor_coordinate(1)^2 - endfactor_coordinate(2)^2)/2*l1*l2);
% beta = acos((endfactor_coordinate(1)^2 + endfactor_coordinate(2)^2 + l1^2 - l2^2)/2*l1*(endfactor_coordinate(1)^2 + endfactor_coordinate(2)^2)^.5);
theta2 = atan2((1-((x^2+y^2-l1^2-l2^2)/2*l1*l2)^2)^.5,(x^2+y^2-l1^2-l2^2)/2*l1*l2); %pi-alpha];
theta1 = atan2(x,y)-atan2((y^2+x^2-(l1+l2*cos(theta2))^2)^.5,l1+l2*cos(theta2)); %atan2(y,x)-beta];
a = [theta1,theta2];
end