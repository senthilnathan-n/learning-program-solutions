package JunitTestPackage;

import static org.junit.Assert.*;

import org.junit.BeforeClass;
import org.junit.Test;
import JUnitExample.Prime;
public class PrimeTest {

	static Prime p;
	@BeforeClass
	public static void setUpBeforeClass() throws Exception {
		p=new Prime();
	}

	@Test
	public void test1() {
		boolean res=p.isPrime(8);
		assertEquals(false,res);
	}
	@Test
	public void test2() {
		boolean res=p.isPrime(2);
		assertEquals(true,res);
	}
	@Test
	public void test3() {
		boolean res=p.isPrime(1);
		assertEquals(false,res);
	}
	@Test
	public void test4() {
		boolean res=p.isPrime(0);
		assertEquals(false,res);
	}

}
