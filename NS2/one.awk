BEGIN{
	totalSent = 0;
	totalReceived = 0;
	totalLost = 0;
}

{	
	pt = $5;
	e = $1;
	
	if (pt == "cbr")
	{
		if (e == "+")
		{
			totalSent ++;
		}
		
		else if (e == "r")
		{
			totalReceived ++;
		}
		
		else if (e == "d")
		{
			totalLost ++;
		}
	}
}

END{
	printf("TR = %d\n",totalReceived);
}
