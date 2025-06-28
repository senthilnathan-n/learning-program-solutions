
class Finance {

    public static double predictFuturevalue(int principal, double interest, int years) {
        if (years == 0) {
            return principal;
        }
        return predictFuturevalue(principal, interest, years - 1) * (1 + interest);
    }
}

class Main {

    public static void main(String ar[]) {
        int principal = 7000;
        double interest = 0.07;
        int years = 5;
        double futureValue = Finance.predictFuturevalue(principal, interest, years);
        System.out.printf("Predicted Future Value of principal with compound interest: %.2f\n", futureValue);
    }
}
