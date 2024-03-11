package com.project.controller.admin;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.project.model.dao.CartDAO;
import com.project.model.dao.OrderDAO;
import com.project.model.vo.BookVO;
import com.project.model.vo.CartVO;
import com.project.model.vo.MembersVO;
import com.project.model.vo.OrderVO;


@WebServlet("/admin/SelectOneOrder")
public class SelectOneOrder extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			String memId = request.getParameter("memberId");

			//1. memId를 받아서 장바구니에 있는 모든 상품을 조회 후 주문 확인 목록에 출력
			List<OrderVO> list = OrderDAO.checkUserOrder(memId);
			
			System.out.println(list);
			 
			//2. 응답페이지(list.jsp)에 전달
		    request.setAttribute("list", list);
			
		    //3. 페이지 전환 - 응답할 페이지(list.jsp)로 포워딩(위임,전가)
		    request.getRequestDispatcher("userOrderList.jsp").forward(request, response);
    	
		} catch (IOException e) {
	        e.printStackTrace();
	        response.sendRedirect("error.jsp");
	    }
    
	}



	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			
			System.out.println("> OrderAllController doPost() 시작");
		    request.setCharacterEncoding("UTF-8");
		    doGet(request, response);
		    System.out.println("> OrderAllController doPost() 끝");
	    
		} catch (IOException e) {
	        e.printStackTrace();
	        response.sendRedirect("error.jsp");
	    }


	}
	

}
