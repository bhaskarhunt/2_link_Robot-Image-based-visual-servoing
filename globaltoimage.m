%image to camera co-ordinate converter
function i = globaltoimage(X,Y,Z)
% f = focal_lenght;
% alpha = ;
% cu = ;
% cv = ;
lembda = 0.5;
% a = [cu,cv,f,alpha];
u = lembda*X/Z;
v = lembda*Y/Z;
s = [u;v];
i = s;
end