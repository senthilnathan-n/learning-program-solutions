import java.util.*;
public class Main {

public static void main(String[] args)
{
		Logger l1=Logger.getinstance();
		Logger l2=Logger.getinstance();
		if(l1==l2)
		{
		    System.out.println("Same Object");
		}
		else{
		    System.out.println("Different Object");
		}
	
	}
}
 class Logger {
	
	private static Logger instance;
	private Logger()
	{
		System.out.println("Instance created ");
	}
	public static Logger getinstance()
	{
		if(instance==null)
		{
			instance=new Logger();
		}
		return instance;
	}
}