package mymemberone;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import jdbc.DBPoolUtil2;

public class UserDAO {
	private static UserDAO instance = null;

	private UserDAO() {

	}

	public static UserDAO getInstance() {
		if (instance == null) {
			synchronized (UserDAO.class) {
				instance = new UserDAO();
			}
		}
		return instance;
	}

	private Connection getConnection() {
		Connection conn = null;
		try {
			Context init = new InitialContext();
			DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/myOracle");
			conn = ds.getConnection();
		} catch (Exception e) {
			System.err.println("Connection 생성실패");
		}
		return conn;
	}

	// 아이디 체크 기능
	public boolean idCheck(String id) {
		boolean result = true;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DBPoolUtil2.makeConnection();
			pstmt = conn.prepareStatement("SELECT * FROM USERTBL WHERE USERID = ?");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (!rs.next())
				result = false;
		} catch (SQLException sqle) {
			sqle.printStackTrace();
		} finally {
			DBPoolUtil2.dbReleaseClose(rs, pstmt, conn);
		}
		return result;
	}

	// 회원가입 입력기능
	public boolean memberInsert(UserVO vo) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean flag = false;
		try {
			conn = DBPoolUtil2.makeConnection();
			String strQuery = "insert into USERTBL values(?,?,?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(strQuery);
			pstmt.setString(1, vo.getUserId());
			pstmt.setString(2, vo.getUserPw());
			pstmt.setString(3, vo.getUserName());
			pstmt.setString(4, vo.getEmail());
			pstmt.setString(5, vo.getAdressNum());
			pstmt.setString(6, vo.getAdress1());
			pstmt.setString(7, vo.getAdress2());
			pstmt.setString(8, vo.getAdress3());
			pstmt.setString(9, vo.getPhoneNum());
			int count = pstmt.executeUpdate();
			if (count > 0) {
				flag = true;
			}
		} catch (Exception ex) {
			System.out.println("Exception" + ex);
		} finally {
			DBPoolUtil2.dbReleaseClose(rs, pstmt, conn);
		}
		return flag;
	}

	public UserVO getMember(String userid) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		UserVO vo = null;
		try {
			conn = DBPoolUtil2.makeConnection();
			pstmt = conn.prepareStatement("select * from usertbl where userid = ?");
			pstmt.setString(1, userid);
			rs = pstmt.executeQuery();
			if (rs.next()) {// 해당 아이디에 대한 회원이 존재
				vo = new UserVO();
				vo.setUserId(rs.getString("userid"));// 대소문자 상관 없나?
				vo.setUserPw(rs.getString("userpw"));
				vo.setUserName(rs.getString("username"));
				vo.setEmail(rs.getString("email"));
				vo.setAdressNum(rs.getString("adressnum"));
				vo.setAdress1(rs.getString("adress1"));
				vo.setAdress2(rs.getString("adress2"));
				vo.setAdress3(rs.getString("adress3"));
				vo.setPhoneNum(rs.getString("phonenum"));
				vo.setMileage(rs.getInt("mileage"));
				vo.setGrade(rs.getString("grade"));
				vo.setAmount(rs.getInt("amount"));
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			DBPoolUtil2.dbReleaseClose(rs, pstmt, conn);
		}
		return vo;
	}

	// 로그인 체크 입려기능(세션 등록 인증 기능) (1:로그인 성공 0:비밀번호오류 -1:아이디없음)
	public int loginCheck(String userId, String userPw) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int check = -1;
		try {
			conn = DBPoolUtil2.makeConnection();
			String strQuery = "select userpw from usertbl where userId = ?";
			pstmt = conn.prepareStatement(strQuery);
			pstmt.setString(1, userId);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				String dbPass = rs.getString("userpw");
				if (userPw.equals(dbPass))
					check = 1;
				else
					check = 0;
			}
		} catch (Exception ex) {
			System.out.println("Exception" + ex);
		} finally {
			DBPoolUtil2.dbReleaseClose(rs, pstmt, conn);
		}
		return check;
	}

	// 회원정보 로그인
	public int updateMember(UserVO vo) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int count = -1;
		try {
			conn = DBPoolUtil2.makeConnection();
			pstmt = conn.prepareStatement(
					"update usertbl set USERPW=?, EMAIL=?, ADRESSNUM=?, ADRESS1=?, ADRESS2=?, ADRESS3=?, PHONENUM=? where USERID=?");

			pstmt.setString(1, vo.getUserPw());
			pstmt.setString(2, vo.getEmail());
			pstmt.setString(3, vo.getAdressNum());
			pstmt.setString(4, vo.getAdress1());
			pstmt.setString(5, vo.getAdress2());
			pstmt.setString(6, vo.getAdress3());
			pstmt.setString(7, vo.getPhoneNum());
			pstmt.setString(8, vo.getUserId());
			count = pstmt.executeUpdate();
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			DBPoolUtil2.dbReleaseClose(pstmt, conn);

		}
		return count;
	}

	// 회원삭제 기능
	public int deleteMember(String userId, String userPw) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String dbPass = "";// 데이터베이스에 실제 저장된 패스워드
		int result = -1;// 결과치
		try {
			conn = DBPoolUtil2.makeConnection();
			pstmt = conn.prepareStatement("select userpw from usertbl where userid = ? ");
			pstmt.setString(1, userId);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dbPass = rs.getString("userpw");
				if (dbPass.equals(userPw)) {// true - 본인 확인
					pstmt = conn.prepareStatement("delete from usertbl where userid = ?");
					pstmt.setString(1, userId);
					result = pstmt.executeUpdate();
				} else { // 본인확인 실패 - 비밀번호 오류
					result = 0;
				}
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			DBPoolUtil2.dbReleaseClose(rs, pstmt, conn);
		}
		return result;
	}

	// 관리자 회원삭제 기능
	public int deleteMember(String userId) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int result = -1;// 결과치
		try {
			conn = DBPoolUtil2.makeConnection();
			pstmt = conn.prepareStatement("delete from usertbl where userid = ?");
			pstmt.setString(1, userId);
			result = pstmt.executeUpdate();
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			DBPoolUtil2.dbReleaseClose(pstmt, conn);
		}
		return result;
	}

	public ArrayList<UserVO> getMemberList() {
		ArrayList<UserVO> list = new ArrayList<UserVO>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		UserVO vo = null;
		try {
			conn = DBPoolUtil2.makeConnection();
			pstmt = conn.prepareStatement("select * from usertbl where grade!='ADMIN'");
			rs = pstmt.executeQuery();
			while (rs.next()) {// 해당 아이디에 대한 회원이 존재
				vo = new UserVO();
				vo.setUserId(rs.getString("userid"));
				vo.setUserPw(rs.getString("userpw"));
				vo.setUserName(rs.getString("username"));
				vo.setEmail(rs.getString("email"));
				vo.setAdressNum(rs.getString("adressnum"));
				vo.setAdress1(rs.getString("adress1"));
				vo.setAdress2(rs.getString("adress2"));
				vo.setAdress3(rs.getString("adress3"));
				vo.setPhoneNum(rs.getString("phonenum"));
				list.add(vo);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			DBPoolUtil2.dbReleaseClose(rs, pstmt, conn);
		}
		return list;
	}

	public static int getMileage(String userId) {
		int mileage = 0;
		String sql = "CALL USERTBL_MILEAGE(?,?)";
		Connection con = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		try {
			con = DBPoolUtil2.makeConnection();
			cstmt = con.prepareCall(sql);
			cstmt.setString(1, userId);
			cstmt.registerOutParameter(2, Types.INTEGER);
			cstmt.execute();

			mileage = cstmt.getInt(2);

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBPoolUtil2.dbReleaseClose(rs, cstmt, con);
		}
		return mileage;
	}

}
