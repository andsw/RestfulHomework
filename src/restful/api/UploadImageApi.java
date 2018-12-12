package restful.api;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.Context;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import restful.bean.Result;
import restful.dao.ClothesDao;
import restful.entity.Clothes;

@Path("uploadImg")
public class UploadImageApi {
	
	@Context 
	private HttpServletRequest request;
	
	@POST
	@Path("/upload")
	@Produces("application/json;charset=UTF-8")
	//@Permission("admin")
	public Result uploadImage(@QueryParam("code") String suitCode) {
		
		Result result = new Result(1, null, "上传失败", "");
		
		// 创建DiskFileItem工厂
		DiskFileItemFactory factory = new DiskFileItemFactory();
	    // 设置缓存目录
		File tempPath = new File(request.getServletContext().getRealPath("temp"));
		if(!tempPath.exists()) {
			tempPath.mkdirs();
		}
		factory.setRepository(tempPath);
	    // 设置缓冲区大小,文件体积超出缓冲区大小将保持至缓存目录然后再进行后续处理，这里设置为1M bytes
		factory.setSizeThreshold(1024*1024);
	    // 创建文件上传解析对象
		ServletFileUpload upload = new ServletFileUpload(factory);
	    // 按照UTF-8编码格式读取
		try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
	    // 设置每个文件最大为5M
		upload.setSizeMax(1024*1024*5);
	    // 一共最多能上传10M
	    // 获取文件保存目录
		
	    List<FileItem> items = null;
	    try {
	        // 解析请求
	        items = upload.parseRequest(request);
	        Iterator<FileItem> iter = items.iterator();
	        while (iter.hasNext()) {
	            FileItem item = (FileItem) iter.next();
	            if (item.isFormField()) {
	               //文本域处理
	                String name = item.getFieldName();
	                String value = item.getString();
	                System.out.println("name:"+name+"\nvalue:"+value);
	                
	            } else {
	                //文件域处理
	                String fieldName = item.getFieldName();
	                //获取文件名
	                String fileName = item.getName();
	                String contentType = item.getContentType();
	                boolean isInMemory = item.isInMemory();
	                long sizeInBytes = item.getSize();
	                
	                System.out.println("fieldName:"+fieldName
	                        +"\nfileName"+fileName+"\ncontentType"
	                        +contentType+"\nisInMemory"+isInMemory
	                        +"\nsizeInBytes"+sizeInBytes);
	                
	                //文件名
	                String name = fileName.substring(fileName.indexOf("."));
	                //通过随机数产生文件名
	                //String str = new Date().getTime()+""+(int)Math.random()*10000;
	                //上传文件保存的路径
	                String path = "D:/temp/"+name;
	                File uploadedFile = new File(path);
	                // 将路径写入数据库（在此不进行写入数据库的操作）
	                ClothesDao clothesDao = new ClothesDao();
	                Clothes clothes = new Clothes();
	                clothes.setId(Integer.parseInt(suitCode));
	                clothes.setImgUrl(path);
	                if(clothesDao.update(clothes)) {
	                	result.setDescription("上传成功！");
	                    result.setCode(0);
	                }
	                try {
	                    item.write(uploadedFile);
	                    result.setDescription("上传成功！");
	                    result.setCode(0);
	                } catch (Exception e) {
	                	result.setDescription("上传失败！");
	                    result.setCode(1);
	                    e.printStackTrace();
	                }
	            }
	        }
	    } catch (FileUploadException e) {
	    	result.setDescription("上传失败！");
            result.setCode(1);
	        e.printStackTrace();
	    }
		return result;
	}
}
