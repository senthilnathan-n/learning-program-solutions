
import java.util.*;

class Product {

    int productId;
    String productName;
    String category;

    Product(int id, String name, String category) {
        this.productId = id;
        this.productName = name;
        this.category = category;
    }

    public String toString() {
        return productId + " " + productName + " " + category;
    }
}

class Search {

    static Product linearSearch(Product productsarr[], int id) {
        for (Product product : productsarr) {
            if (product.productId == id) {
                return product;
            }
        }
        return null;
    }

    static Product binarySearch(Product productsarr[], int id) {
        int left = 0, right = productsarr.length - 1;
        while (left <= right) {
            int mid = (left + right) / 2;
            if (productsarr[mid].productId == id) {
                return productsarr[mid];
            } else if (productsarr[mid].productId < id) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        return null;
    }
}

class Main {

    public static void main(String args[]) {
        Product productsarr[] = {
            new Product(10, "Keyboard", "Electronics"),
            new Product(3, "Sneakers", "Footwear"),
            new Product(15, "Notebook", "Stationery"),
            new Product(6, "Shampoo", "Health"),
            new Product(9, "Headphones", "Electronics")
        };

        Product linearResult = Search.linearSearch(productsarr, 3);

        Arrays.sort(productsarr, (a, b) -> a.productId - b.productId);
        Product binaryResult = Search.binarySearch(productsarr, 3);

        System.out.println("Linear Search Result: " + linearResult);
        System.out.println("Binary Search Result: " + binaryResult);
    }
}
