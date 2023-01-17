% MODIFIED HUNGARIAN METHOD 
% © Md Asifuzzaman khan
% Created- Aug8,2020
% ISLAMIC UNIVERSITY OF TECHNOLOGY (IUT),OIC


clc
clear all;
close all;
A=input("Enter the objective matrix:\n");

mode=input("Maximization type? If yes enter 1 other wise 0 : ");

%filling empty row/col to form square marix

AAcol=0; %flag variable for dummy row/col
AArow=0;
sz=size(A);
if (sz(1)~= sz(2))
    if(sz(1)>sz(2))
        AAcol=zeros(1,sz(1));
        AArow=zeros(1,sz(1));
        for i=sz(2)+1:sz(1)
            AAcol(i)=1; %flagging the dummy column
            A(:,i)=zeros(sz(1),1);    
        end
    else
        AAcol=zeros(1,sz(2));
        AArow=zeros(1,sz(2));

        for i=sz(1)+1:sz(2)
            AArow(i,:)=1; %flagging the dummy row
            A(i,:)=zeros(sz(2),1);
        end
    end 
    disp('After making square matrix:')
    disp(A);
else
[n,~]=size(A);
AAcol=zeros(1,n);
AArow=zeros(1,n); 
end

D=A;

if(mode==1)
     % converting to minimization type if type was maximum
    A=max(A)-A;
end


[n,~]=size(A); %determining new square matrix size

%row reduction
for i=1:n
    A(i,:)=A(i,:)-min(A(i,:));   
end

%column reduction
for i=1:n
    A(:,i)=A(:,i)-min(A(:,i));   
end


[A,row,col,totalLines,linematrix]=findminlines2coverall0(A); %find min number of lines to cover all zeros

%if total number of line is less than row number then go for improvement of the reduced matrix

while (totalLines<n) 
  [min,A]=improve(A,linematrix);
  [A,row,col,totalLines,linematrix]=findminlines2coverall0(A); %Again find min number of lines to cover all zeros of the improved matrix
end


disp('Optimality is reached');
disp('Final line Matrix is :');
disp(linematrix);
disp('Final reduced matrix is :');
disp(A);

PossibleAssignmentMatrix=finalAssignment(A);        %making the final assignment

Total=0;
for i=1:n
    for j=1:n
        if (PossibleAssignmentMatrix(i,j,1)==1)       
            Total=Total+D(i,j);          % finding the max/min value obtained through optimization
        end
    end
end

if(mode==1)
disp(['Maximum value is : ',num2str(Total)]);
else                                            %displaying the max/min value
disp(['Minimum value is : ',num2str(Total)]);
end

[~,~,sz]=size(PossibleAssignmentMatrix);

%Rejecting assigned values in dummy row/col 
for t=1:sz
    for i=1:size(AArow)
        if(AArow(i)==1)
            PossibleAssignmentMatrix(i,:,t)=0;
        end
    end                                        
    for i=1:size(AAcol)
        if(AAcol(i)==1)
            PossibleAssignmentMatrix(:,i,t)=0;
        end
    end
end

[n,m,p]=size(PossibleAssignmentMatrix);
a=reshape(PossibleAssignmentMatrix,n,[],1);
b=reshape(a(:),n*m,[])';      %only choosing unique set of solutions in case of multiple solutions
c=unique(b,'rows','stable')';
PossibleAssignmentMatrix=reshape(c,n,m,[]);



PossibleAssignmentMatrix
