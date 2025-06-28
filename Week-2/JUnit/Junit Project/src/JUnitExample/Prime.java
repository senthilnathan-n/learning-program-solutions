package JUnitExample;

public class Prime {
	
	public boolean isPrime(int a)
	{
		if(a<=1)
		{
			return false;
		}
		if(a==2)
		{
			return true;
		}
		for(int i=2;i<=a/2;i++)
		{
			if(a%i==0)
			{
				return false;
			}
		}
		return true;
	}
}
