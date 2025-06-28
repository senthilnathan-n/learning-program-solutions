package TestPackage;

import static org.junit.Assert.*;
import org.junit.Before;
import org.junit.After;
import org.junit.Test;

import ExamplePackage.Sum;

public class TestSum {
	private Sum s;

	 @Before
	    public void setUp() {
	        s=new Sum();
	        System.out.println("Setup: Adder initialized.");
	    }
	  @After
	    public void tearDown() {
	       
	        s.close();
	        System.out.println("Teardown: Adder closed.");
	    }

	  @Test
	public void test() {
		  int result = s.add(10, 5);

	        assertEquals(15, result);
	}
	  @Test
		public void test2() {
		  int result = s.add(-3, -7);

	        assertEquals(-10, result);
		}

}
