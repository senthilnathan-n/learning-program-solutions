package Mock1;
import static org.mockito.Mockito.*;
import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;
import org.mockito.Mockito;


public class verify {

    @Test
    public void testVerifyInteraction() {
        ExternalApi mockApi = Mockito.mock(ExternalApi.class);
        MyService service = new MyService(mockApi);
        service.fetchData();
        System.out.println("🟢 fetchData() was called. Now verifying interaction...");
        verify(mockApi).getData();
        System.out.println("✅ Verified: getData() was called exactly once.");
    }
}
