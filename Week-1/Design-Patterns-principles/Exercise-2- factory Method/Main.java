import java.util.*;
interface document {
  public void createDocument();
}

class Main {
	public  static void main(String[] args)
	{
		Scanner s=new Scanner(System.in);
		String ip=s.nextLine();

		document d=DocumentFactory.getDocument(ip);
		if(d!=null)
		{
			d.createDocument();

		}
		else
		{
			System.out.println(ip+" is not supported");
		}
	}
}
 class DocumentFactory {

	public static document getDocument(String ip)
	{
		document d;
		if(ip.equalsIgnoreCase("pdf"))
		{
			d=new PdfDocument();
		}
		else if(ip.equalsIgnoreCase("word"))
		{
			d=new WordDocument();
		}
		else if(ip.equalsIgnoreCase("Excel"))
		{
			d=new ExcelDocument();
		}
		else
		{
			d=null;
		}
		return d;
	}
}
 class PdfDocument implements document {
 
	public void createDocument()
	{
		System.out.println("Pdf Created successfully..");
	}
}


 class ExcelDocument implements document {
	public void createDocument()
	{
		System.out.println("Excel Created successfully..");
	}
}


 class WordDocument implements document{
	
	public void createDocument()
	{
		System.out.println("Word Created successfully..");
	}
}
