package mymemberone;

public class PaymentDAO {
	public static PaymentDAO instance=null;
	
	private PaymentDAO() {}
	
	public PaymentDAO getInstance() {
		if(instance==null) {
			synchronized (PaymentDAO.class) {
				instance= new PaymentDAO();
			}
		}
		return instance;
	}
}
