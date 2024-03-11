
package com.project.controller.notice;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.project.model.dao.NoticeBoardDAO;
import com.project.model.vo.NoticeBoardVO;

@WebServlet("/notice/noticedelete")
public class NoticeDeleteController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// POST 요청 처리 (게시글 작성 등)
		System.out.println("noticedelete POST 시작~~~");
		request.setCharacterEncoding("UTF-8");

		// 1.체크박스 선택후 삭제 코드 작성
//    	String nbIdx = request.getParameter("nbIdx");
//      String[] selectedItems = request.getParameterValues("selectedItems");
//    	int result;
//    	
//        if (selectedItems == null) {
//        	System.out.println("널값이라구요!!!!!!!!!!!!!!!");
//        	selectedItems = new String[0];
//        }
//       
//        int length = selectedItems.length;
//        System.out.println(length);
//        
//        for (int i = 0; i < selectedItems.length; i++) {
//        	System.out.println(selectedItems[i]);
//        }       

		// 2. 글 1개 삭제
		String nbIdx = request.getParameter("nbIdx");
		System.out.println("전달된 delete 파라미터 : " + nbIdx);
		int result = NoticeBoardDAO.delete(Integer.parseInt(nbIdx));
		System.out.println("삭제완료 : " + result);

		request.setAttribute("noticeboardadmin", nbIdx);
		response.sendRedirect("noticeboardadmin");

	}

}
