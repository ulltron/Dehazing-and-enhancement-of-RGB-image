function HSIImage = rgb2hsi(img)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
[R, G, B]=imread(img);
i=R+G+B;
I=i/3;
r=R/i;
g=G/i;
b=B/i;


    
%%
if(R==G && G==B)
    S=0;  H=0;
else 
    w = 0.5*(R-G+R-B)/ sqrt((R-G)*(R-G)+(R-B)*(G-B));
    if(w<-1) w=-1;
    end
    if(w>1)  w=1;
    H=acos(w);
    end
    if(B>G) H=2*Pi-H;
    end
    if(r<=g && r<=b) S=1-3*r;
    end
    if(g<=r && g<=b) S=1-3*g;
    end
    if(b<=r && b<=g) S=1-3*b;
    end
end

HSIImage = [H S I];
return 



 
    



