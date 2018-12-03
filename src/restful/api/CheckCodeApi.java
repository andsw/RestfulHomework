package restful.api;  
  
import java.awt.Color;  
import java.awt.Font;  
import java.awt.Graphics;  
import java.awt.image.BufferedImage;  
import java.io.IOException;  
import java.util.Random;  
  

import javax.imageio.ImageIO;  
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;  
import javax.servlet.http.HttpServletRequest;  
import javax.servlet.http.HttpServletResponse;  
import javax.servlet.http.HttpSession;

@SuppressWarnings("serial")
@WebServlet(name = "CheckCodeApi", urlPatterns = "/checkcode")
public class CheckCodeApi extends HttpServlet {  
      
    public final static int W = 120;  
    public final static int H = 50;  
    Random random = new Random();  
    StringBuilder builder = new StringBuilder();
      
    public void doGet(HttpServletRequest request, HttpServletResponse response)  
            throws ServletException, IOException {
        doPost(request, response);
    }  
      
    public void doPost(HttpServletRequest request, HttpServletResponse response)  
            throws ServletException, IOException {  
    	System.out.println("doPost");
        BufferedImage img = new BufferedImage(W,H,BufferedImage.TYPE_INT_BGR);  
        Graphics g = img.getGraphics();  
        g.setColor(Color.yellow);  
        g.fillRect(200,500,W,H);  
        drawLines(g);  
        drawCharacter(g);
        HttpSession session = request.getSession(true);
        
        /*String existedCheckCode = (String) session.getAttribute("checkcode");
        //若原先已存在验证码,则先将原来的内容清除，不然会和新内容产生叠加！
        if(existedCheckCode != null) {
        	System.out.println("existedCheckCode = " 
        + existedCheckCode + " 不为空，先清除再加入新的验证码");
        	session.removeAttribute("checkcode");
        }*/
        
        session.setAttribute("checkcode", builder.toString());
        //session.setMaxInactiveInterval(10); // 设置session过期时间为10分钟！
        System.out.println("验证码生成成功 ： " + session.getAttribute("checkcode"));
        ImageIO.write(img, "jpg", response.getOutputStream());
        builder.setLength(0);
        g.dispose();//释放资源！  
    }  
      
    //在图片上写下随机数字！  
    public void drawCharacter(Graphics g){  
        String str = "0123456789qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHKJLZXCVBNM";  
        
        for(int i = 0; i<4; i++){  
            int index = random.nextInt(str.length());  
            setColor(g);  
            g.setFont(new Font("宋体", Font.BOLD, 30));  
            g.drawString("" + str.charAt(index), 20*i+20, 30);  
            builder.append(str.charAt(index));
        }
    }  
      
    //画随机线  
    public void drawLines(Graphics g){  
        int count = random.nextInt(20);  
          
        for(int i = 0; i<count; i++){  
            int x1 = random.nextInt(W);  
            int x2 = random.nextInt(W);  
            int y1 = random.nextInt(H);  
            int y2 = random.nextInt(H);  
            setColor(g);  
            g.drawLine(x1, y1, x2, y2);  
        }  
    }  
      
    //随机选择画笔颜色！  
    public void setColor(Graphics g){  
        int R = random.nextInt(256);  
        int B = random.nextInt(256);  
        int G = random.nextInt(256);  
        Color c = new Color(R, B, G);  
        g.setColor(c);  
    }  
}