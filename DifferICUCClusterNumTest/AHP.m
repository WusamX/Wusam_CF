function [w] = AHP(z,m)
%AHP Summary of this function goes here
%   Detailed explanation goes here
%�����жϾ���
for i=1:m
    for j=1:m
        A(i,j)=z(i)/z(j);
    end
end
clear i j
%��η�����
x=ones(m,100);
y=ones(m,100);
c=zeros(1,100);
c(1)=max(x(:,1));
y(:,1)=x(:,1);
x(:,2)=A*y(:,1);
c(2)=max(x(:,2));
y(:,2)=x(:,2)/c(2);
p=0.0001;i=2;k=abs(c(2)-c(1));
while  k>p
  i=i+1;
  x(:,i)=A*y(:,i-1);
  c(i)=max(x(:,i));
  y(:,i)=x(:,i)/c(i);
  k=abs(c(i)-c(i-1));
end
a=sum(y(:,i));
w=y(:,i)/a;
t=c(i);
disp('Ȩ����');disp(w);
disp('�������ֵ');disp(t);
% %������һ���Լ���
% CI=(t-m)/(m-1);RI=[0 0 0.52 0.89 1.12 1.26 1.36 1.41 1.46 1.49 1.52 1.54 1.56 1.58 1.59];
% CR=CI/RI(m);
% if CR<0.10
%     disp('�˾����һ���Կ��Խ���!');
%     disp('CI=');disp(CI);
%     disp('CR=');disp(CR);
% else 
%     disp('�˾����һ���Բ����Խ���!');
% end
end

