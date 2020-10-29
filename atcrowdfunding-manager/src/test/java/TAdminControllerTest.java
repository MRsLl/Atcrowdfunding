import com.atguigu.atcrowdfunding.bean.TAdmin;
import com.atguigu.atcrowdfunding.controller.TAdminController;
import com.atguigu.atcrowdfunding.service.TAdminService;
import com.atguigu.atcrowdfunding.service.impl.TAdminServiceImpl;
import com.atguigu.atcrowdfunding.util.MD5Util;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;


public class TAdminControllerTest {


    @Test
    public void test() {
        System.out.println(MD5Util.digest("123"));
    }
}
