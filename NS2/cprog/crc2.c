#include<stdio.h>
#include<stdlib.h>
#include<string.h>

int da[20],di[20],te[20],tem[20],l;
int i,j,m,n,data,divisor,t,k,e,pos,tem1[20];
 
void main() {

	printf("\nEnter the total bit of data and divisor");
	scanf("%d %d",&data,&divisor);
	m=data+divisor-1;
	printf("\nEnter the data:");
 
	for(i=0;i<data;i++) {
    	scanf("%d",&da[i]);
    	te[i]=da[i];  
    }
 		
 	for(i=data;i<m;i++) {   
		te[i]=0;                        
	}
 
	printf("\nEnter the divisor");
 	for(i=0;i<divisor;i++) {   
 		scanf("%d",&di[i]);             }
 		l=divisor;t=0;
 		k=0;
 		
 		for(i=0;i<data;i++) {
      		e=0;t=0;
      		
      		for(j=1;j<divisor;j++) {
           		
           		if(((da[j]==1)&&(di[j]==1))||((da[j]==0)&&(di[j]==0))) {
                	tem[j-1]=0;
                	if(e!=1) {
                    	k=k+1;
                     	t=t+1;
                     	i=i+1;
                    }
              	}
           
           		else {
                	tem[j-1]=1;
                	e=1;
              	}
         	}
      		j=0;
      
      		for(e=t;e<divisor-1;e++) {
          		da[j]=tem[e];
            	j++;
         	}
         	
      		for(j=j;j<divisor;j++) {
           		if(l>=data+1) {
                	da[j]=0;
              	}
           
           		else {
                	da[j]=te[l];
                	l=l+1;
              	}
         	}
    	}
 	
 	printf("\n The CRC BITS are\t ");
 	
 	for(i=0;i<divisor-1;i++) {
    	printf(" %d",tem[i]);
    }
    
    srand(time(0));
    pos = rand()%m;
    da[pos] = (da[pos] == 0)? 1:0;
    te[pos] = da[pos];
    
 		t=0;
 		k=0;
 		l = divisor;
 		for(i=0;i<data;i++) {
      		e=0;t=0;
      		
      		for(j=1;j<divisor;j++) {
           		
           		if(((da[j]==1)&&(di[j]==1))||((da[j]==0)&&(di[j]==0))) {
                	tem1[j-1]=0;
                	if(e!=1) {
                    	k=k+1;
                     	t=t+1;
                     	i=i+1;
                    }
              	}
           
           		else {
                	tem1[j-1]=1;
                	e=1;
              	}
         	}
      		j=0;
      
      		for(e=t;e<divisor-1;e++) {
          		da[j]=tem1[e];
            	j++;
         	}
         	
      		for(j=j;j<divisor;j++) {
           		if(l>=data+1) {
                	da[j]=0;
              	}
           
           		else {
                	da[j]=te[l];
                	l=l+1;
              	}
         	}
    	}
 	
 	printf("\n The CRC BITS are\t ");
 	
 	for(i=0;i<divisor-1;i++) {
    	printf(" %d",tem1[i]);
    }
    
    int flag = 0;
    
    for(i=0;i<divisor-1;i++) {
    	if (tem[i] != tem1[i]) {
    		flag = 1;
    		break;
    	}
    	}
    		if(flag == 1)
    			printf("Error detected");
    		else
    			printf("No");
       
   
}

