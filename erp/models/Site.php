<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Site extends CI_Model
{

    public function __construct() {
        parent::__construct();
    }

    public function get_total_qty_alerts() {
        $this->db->where('quantity < alert_quantity', NULL, FALSE)->where('track_quantity', 1);
        return $this->db->count_all_results('products');
    }

    public function get_expiring_qty_alerts() {
        $date = date('Y-m-d', strtotime('+3 months'));
        $this->db->select('SUM(quantity_balance) as alert_num')
        ->where('expiry !=', NULL)->where('expiry !=', '0000-00-00')
        ->where('expiry <', $date);
        $q = $this->db->get('purchase_items');
        if ($q->num_rows() > 0) {
            $res = $q->row();
            return (INT) $res->alert_num;
        }
        return FALSE;
    }

	/* Alert Customer Payments */
	public function get_sale_suspend_alerts(){
        $q = $this->db->query('
				SELECT COUNT(n.date) AS alert_num, MIN(n.date) AS date
				FROM 
				(
					SELECT date
					FROM erp_suspended_bills 
				) AS n
				WHERE
				DATE_SUB(n.date, INTERVAL 1 DAY) <= CURDATE()
		');
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
	}
	
	/* Alert Customer Payments */
	/*public function get_customer_payments_alerts(){
        $q = $this->db->query('
				SELECT COUNT(n.date) AS alert_num, MIN(n.date) AS date
				FROM 
				(
					SELECT payment_term , date
					FROM erp_sales
					WHERE
					`payment_term` <> 0
					ORDER BY date DESC
				) AS n
				WHERE
				DATE_SUB(n.date, INTERVAL 1 DAY) <= CURDATE()
		');
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
	}*/
	public function get_customer_payments_alerts(){
        $q = $this->db->query('
				SELECT COUNT(n.due_date) AS alert_num, MIN(n.due_date) AS date
				FROM 
				(
					SELECT payment_term , due_date
					FROM erp_sales
					WHERE
					`payment_term` <> 0
					ORDER BY due_date DESC
				) AS n
				WHERE
					n.due_date <= CURDATE()
		');
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
	}
	/* Alert Purchase Payments */
	public function get_purchase_payments_alerts(){
        $q = $this->db->query('
			SELECT COUNT(n.date) AS alert_num, MIN(n.date) AS date
				FROM 
				(
					SELECT payment_term , date
					FROM erp_purchases
					WHERE 
					`payment_term` <> 0
					ORDER BY date DESC
				) AS n
				WHERE
				DATE_SUB(n.date, INTERVAL 1 DAY) <= CURDATE()
		');
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
	}
	/* Alert Day Payment Term */
	public function get_day_payments_alerts(){
		$customer_day_term = '(SELECT erp_companies.id, erp_companies.day_payment_term as day_payment_term FROM erp_companies WHERE erp_companies.day_payment_term <> 0) customer_day_term';
        $q = $this->db->query("SELECT COUNT(DISTINCT erp_sales.customer_id) as alert_num FROM erp_sales LEFT JOIN ".$customer_day_term." ON customer_day_term.id = erp_sales.customer_id WHERE erp_sales.customer_id = customer_day_term.id AND CURDATE() >= (DATE(erp_sales.date) + INTERVAL (customer_day_term.day_payment_term) DAY) AND erp_sales.payment_status <> 'paid'");
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
	}
	/* Alert Invoce Payment Term */
	public function get_invoice_payment_term_alerts(){
		$customer_invoice_payment_term = '(SELECT erp_companies.id, erp_companies.invoice_payment_term as invoice_payment_term FROM erp_companies WHERE erp_companies.invoice_payment_term <> 0) invoice_payment_term';
        $q = $this->db->query("SELECT CASE WHEN	COUNT(erp_sales.customer_id) =	invoice_payment_term.invoice_payment_term THEN 1 ELSE 0 END as alert_num, CASE WHEN COUNT(erp_sales.customer_id) = invoice_payment_term.invoice_payment_term THEN erp_sales.customer_id ELSE NULL END AS customer_id FROM erp_sales LEFT JOIN ".$customer_invoice_payment_term." ON invoice_payment_term.id = erp_sales.customer_id WHERE erp_sales.customer_id = invoice_payment_term.id AND erp_sales.payment_status <> 'paid' GROUP BY  erp_sales.customer_id");
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return FALSE;
	}
	/* Alert Quatations */
	public function get_quatation_alerts(){
		$query = $this->db->select('COUNT(*)')
						->where('status', 'pending')
						->get('quotes');
		return $query->num_rows();
	}
	
	public function getProducts()
    {
		$this->db->select('id, code, name');
        $q = $this->db->get('products');
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return FALSE;
    }
	
	public function get_deliveries_alert(){
        $q = $this->db->query('
			SELECT COUNT(n.date) AS alert_num, MIN(n.date) AS date
				FROM 
				(
					SELECT date
					FROM erp_deliveries
					WHERE
					delivery_status = "pending"
					ORDER BY date DESC
				) AS n
				WHERE
				DATE_SUB(n.date, INTERVAL 1 DAY) <= CURDATE()
		');
        if ($q->num_rows() > 0) {
            //$res = $q->row();
            return $q->row();
        }
        return FALSE;
	}
	
	/* Customer Alerts */
	public function get_customer_alerts(){
		$this->db->select('COUNT(*) AS count');
		$this->db->where('CURDATE() >= DATE_SUB(end_date , INTERVAL (SELECT alert_day FROM erp_settings) DAY)');
		$q = $this->db->get('companies');
		if($q->num_rows() > 0 ){
			$q = $q->row();
			return $q->count;
		}
		return false;
	}

    public function get_setting() {
        $q = $this->db->get('settings');
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
    }

    public function getDateFormat($id) {
        $q = $this->db->get_where('date_format', array('id' => $id), 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
    }

    public function getAllCompanies($group_name) {
        $q = $this->db->get_where('companies', array('group_name' => $group_name));
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return FALSE;
    }
	
	public function getSupplierByArray($array){
		$this->db->select("id, CONCAT(company, ' (', name, ')') as text", FALSE)
				->from("erp_companies")
				->where_in('id', $array);
		$q = $this->db->get();
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return FALSE;
	}
	
	public function getProductSupplier($group_name) {
		//$this->db->select("id, name as text", FALSE);
        $q = $this->db->get_where('products', array('code' => $group_name));
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
    }

    public function getCompanyByID($id) {
        $q = $this->db->get_where('companies', array('id' => $id), 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
    }
    public function getPriceName($id) {
	    $this->db->select("companies.id, companies.id AS cus_no, company, companies.name, price_groups.name as price_group_name, customer_group_name, address, phone, invoice_payment_term");

        $this->db->join('price_groups', 'price_groups.id = companies.price_group_id', 'left');
        $this->db->where('group_name', 'customer');
        $q = $this->db->get('companies');

        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
    }
	public function getSuppliers(){
		$this->db->select("id, name");
		$this->db->where('group_name', 'supplier');
		$q = $this->db->get('companies');
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return FALSE;
	}
	
	public function getCustomers(){
		$this->db->select("id, name");
		$this->db->where('group_name', 'customer');
		$q = $this->db->get('companies');
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return FALSE;
	}

    
    function getSupplierNameByID($sup_id = null)
	{
        $this->db->select('name, company');
		$this->db->where(array('id' => $sup_id));
        $q = $this->db->get('companies');
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
	}
    
      function getBillerNameByID($biller_id = null)
	{
		$this->db->select('company, name');
		$this->db->where(array('id' => $biller_id));
        $q = $this->db->get('companies');
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
	}
	
	public function getCompanyByArray($id) {
		$this->db->select();
		$this->db->where_in('id', $id);
        $q = $this->db->get('companies');
        if ($q->num_rows() > 0) {
            return $q->result();
        }
        return FALSE;
    }
	
	public function getAccountByID($id) {
		$this->db->select("erp_gl_charts.accountcode, erp_gl_charts.accountname, erp_gl_charts.parent_acc, erp_gl_sections.sectionname")
				->from("erp_gl_charts")
				->join("erp_gl_sections","erp_gl_charts.sectionid=erp_gl_sections.sectionid","INNER")
				->where(array('erp_gl_charts.accountcode' => $id));
		$q = $this->db->get();
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
    }
	
	public function getTaxByID($id) {
		$this->db->select("gl_charts_tax.accountcode, gl_charts_tax.accountname, gl_charts_tax.accountname_kh, erp_gl_sections.sectionname")
				->from("gl_charts_tax")
				->join("erp_gl_sections","gl_charts_tax.sectionid=erp_gl_sections.sectionid","INNER")
				->where(array('gl_charts_tax.accountcode' => $id));
		$q = $this->db->get();
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
    }
	
	public function getJournalByID($id) {
		$this->db
				->select("gt.tran_no,gt.tran_no AS g_tran_no, gt.tran_type, gt.tran_date, 
							gt.reference_no, gt.account_code, 
							gt.narrative, gt.description, 
							(IF(gt.amount > 0, gt.amount, IF(gt.amount = 0, 0, null))) as debit, 
							(IF(gt.amount < 0, abs(gt.amount), null)) as credit")
				->from("erp_gl_trans gt")
				->where('gt.tran_id', $id);
		$q = $this->db->get();
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
    }
	
	public function getReceivableByID($id){
		$this->db
				->select("id, date, reference_no, biller, customer, sale_status, grand_total, paid, (grand_total-paid) as balance, payment_status")
				->from('sales')
				->where(array('payment_status !=' => 'Returned', 'payment_status !='=>'paid', '(grand_total-paid) <>' =>0, 'id' =>$id));
		$q = $this->db->get();
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
	}
	
	public function getRecieptByID($id){
		$this->db
				->select($this->db->dbprefix('payments') . ".id,
				" . $this->db->dbprefix('sales') . ".suspend_note AS noted,
				" . $this->db->dbprefix('payments') . ".date AS date,
				" . $this->db->dbprefix('payments') . ".reference_no as payment_ref, 
				" . $this->db->dbprefix('sales') . ".reference_no as sale_ref, customer,paid_by, amount, type", $this->db->dbprefix('payments') . ".id")
                ->from('payments')
                ->join('sales', 'payments.sale_id=sales.id', 'left')
                ->join('purchases', 'payments.purchase_id=purchases.id', 'left')
                ->group_by('payments.id')
				->order_by('payments.date desc')
				->where(array('payments.type !='=>"sent", 'sales.customer !='=>'', 'payments.id'=>$id));
		$q = $this->db->get();
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
	}
	
	public function getPayableByID($id){
		$this->db
				->select("id, date, reference_no, supplier, status, grand_total, paid, (grand_total-paid) as balance, payment_status")
                ->from('purchases')
				->where(array('payment_status !='=>'paid', 'id'=>$id));
		$q = $this->db->get();
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
	}

    public function getCustomerGroupByID($id) {
        $q = $this->db->get_where('customer_groups', array('id' => $id), 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
    }

	public function getCompanyWarehouseByID($id) {
        $q = $this->db->get_where('companies', array('id' => $id), 1);
        if ($q->num_rows() > 0) {
			$rs = $q->row();
			$warehouses = $rs->cf5;
	
			$query = $this->db->query('
				SELECT
					erp_companies.id,
					erp_companies.cf5,
					erp_users.warehouse_id,
					wh.`name`
				FROM
					erp_companiess

				INNER JOIN erp_users ON erp_users.biller_id = erp_companies.id
				INNER JOIN 
				(
					SELECT w.`name`,w.id
					FROM erp_warehouses w
				) AS wh
				WHERE
					wh.id IN ('.$warehouses.')
					AND erp_companies.id = '.$id.'
				GROUP BY wh.`name`
			');
			if ($query->num_rows() > 0) {
				foreach($query->result() as $row){
					$data[] = $row;
				}
				return $data;
			}
        }
		return FALSE;
    } 
	
	public function getWarehouseCompanyByID($id) {
        $q = $this->db->get_where('companies', array('id' => $id), 1);
        if ($q->num_rows() > 0) {
			$rs = $q->row();
			$warehouses = $rs->cf5;
	
			$query = $this->db->query('
				SELECT
					erp_companies.id AS company_id,
					erp_companies.cf5,
					wh.id,
					wh.`name`
				FROM
					erp_companies
				LEFT JOIN erp_users
				ON erp_users.id = erp_companies.id
				INNER JOIN 
				(
					SELECT w.`name`,w.id
					FROM erp_warehouses w
				) AS wh
				WHERE
					wh.id IN ('.$warehouses.')
					/* AND erp_companies.id = '.$id.' */
					
				GROUP BY wh.`name`
			');
			if ($query->num_rows() > 0) {
				foreach($query->result() as $row){
					$data[] = $row;
				}
				return $data;
			}
        }
		return FALSE;
    } 
	
	public function getSuspendByID($id){
		$this->db->select("floor,erp_suspended.name as room_name, erp_suspended_bills.total as price, (SELECT deposit_amount FROM erp_companies WHERE erp_companies.id = erp_suspended_bills.customer_id) as deposite ,description, (SELECT MAX(customer) FROM erp_suspended_bills sb WHERE sb.suspend_id = erp_suspended.id ) as customer_name, (SELECT MAX(date) FROM erp_suspended_bills sb WHERE sb.suspend_id = erp_suspended.id ) as start_date, erp_companies.end_date as end_date, (12 * (YEAR (erp_companies.end_date) - YEAR (erp_suspended_bills.date)) + (MONTH (erp_companies.end_date) - MONTH (erp_suspended_bills.date))) as term_year, CASE WHEN erp_suspended.status = 0 THEN 'free' WHEN erp_suspended.status = 1 THEN 'busy' ELSE 'busy' END AS status")
		->join('erp_suspended_bills', 'erp_suspended.id = erp_suspended_bills.suspend_id', 'left')
		->join('erp_companies', 'erp_companies.id = erp_suspended_bills.customer_id', 'left')
		->from("erp_suspended")
		->where('erp_suspended.id',$id);
		$q = $this->db->get();
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
	}
	
	/*
	public function getCompanyWarehouseByID($id) {
        $q = $this->db->query('
				SELECT
					erp_companies.id,
					erp_companies.cf5,
					erp_users.warehouse_id,
					wh.`name`
				FROM
					erp_companies

				INNER JOIN erp_users ON erp_users.biller_id = erp_companies.id
				INNER JOIN 
				(
					SELECT w.`name`,w.id
					FROM erp_warehouses w
				) AS wh
				WHERE
					wh.id IN (cf5)
					AND erp_companies.id = 400
				GROUP BY wh.`name`
		');
        if ($q->num_rows() > 0) {
			foreach($q->result() as $row){
				$data[] = $row;
			}
			return $data;
        }
		return FALSE;
    }
	*/

    public function getUser($id = NULL) {
        if (!$id) {
            $id = $this->session->userdata('user_id');
        }
        $q = $this->db->get_where('users', array('id' => $id), 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
    }
	
	/*Use to Export*/
	public function getUsers($id){
		$this->db
			->select($this->db->dbprefix('users').".id as id, first_name, last_name, email, company, award_points, " . $this->db->dbprefix('groups') . ".name, (CASE WHEN active = 0 THEN 'Inactive' ELSE 'Active' END) as astatus")
            ->from("users")
            ->join('groups', 'users.group_id=groups.id', 'left')
            ->group_by('users.id')
            ->where(array('company_id'=> NULL, 'users.id'=>$id));
		$q = $this->db->get();
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
	}
	
	/*Use to Export*/
	public function getEmployees($id){
		$this->db
			->select($this->db->dbprefix('users').".id as id, first_name, last_name, email, company, award_points, " . $this->db->dbprefix('groups') . ".name, (CASE WHEN active = 0 THEN 'Inactive' ELSE 'Active' END) as astatus")
            ->from("users")
            ->join('groups', 'users.group_id=groups.id', 'left')
            ->group_by('users.id')
            ->where(array('company_id'=> NULL, 'users.id'=>$id));
		$q = $this->db->get();
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
	}
	
	public function getProductVariantByID($id, $uom = null) {
        if($uom) {
            $q = $this->db->get_where('product_variants', array('product_id' => $id, 'name' => $uom), 1);
        }else{
            $q = $this->db->get_where('product_variants', array('product_id' => $id), 1);
        }
        
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
    }
	
	public function getProductVariantByOptionID($option_id){
		$q = $this->db->get_where('product_variants', array('id' => $option_id), 1);
		if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
	}
	
    public function getProductByID($id) {
		$this->db->SELECT("erp_products.*,erp_units.name as units")
		->join('erp_units','erp_units.id=erp_products.unit','left');
        $q = $this->db->get_where('products', array('products.id' => $id), 1);
	     
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
    }
	
	public function getProductByArray($id, $customer_id) {
		$data = array();
		foreach($id as $idd)
		{
			$this->db->where_in('sale_items.id', $idd)
					 ->select('products.*, sale_items.real_unit_price as hprice, sale_items.quantity as hquantity')
					 ->join('sale_items', 'products.id = sale_items.product_id')
					 ->join('sales', 'sales.id = sale_items.sale_id')
					 ->where('sales.customer_id', $customer_id)
					 ->order_by('sale_items.id', 'desc')
					 ->limit(1);
			$q = $this->db->get('products');
			if ($q->num_rows() > 0) {
				foreach (($q->result()) as $row) {
					$data[] = $row;
				}
			}
		}
		return $data;
    }

    public function getAllCurrencies() {
        $q = $this->db->get('currencies');
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return FALSE;
    }

    public function getCurrencyByCode($code) {
        $q = $this->db->get_where('currencies', array('code' => $code), 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
    }

    public function getAllTaxRates() {
        $q = $this->db->get('tax_rates');
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return FALSE;
    }
	
	public function getAllUsers() {
        $q = $this->db->get('users');
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return FALSE;
    }

    public function getTaxRateByID($id) {
        $q = $this->db->get_where('tax_rates', array('id' => $id), 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
    }

    public function getAllWarehouses() {
        $q = $this->db->get('warehouses');
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return FALSE;
    }

    public function getWarehouseByID($id) {
        $q = $this->db->get_where('warehouses', array('id' => $id), 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
    }
	public function getWarehouseByCode($code) {
        $q = $this->db->get_where('warehouses', array('code' => $code), 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
    }
	 public function getChartByID($id) {
        $q = $this->db->get_where('gl_charts', array('accountcode' => $id), 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
    }
    public function getAllCategories() {
        $this->db->order_by('name');
        $q = $this->db->order_by('name')->get('categories');
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return FALSE;
    }
	 
	
	public function getAllSuppliers() {
        $q = $this->db->get_where('companies', array('group_name' => 'supplier'));
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return FALSE;
    }

    public function getCategoryByID($id) {
        $q = $this->db->get_where('categories', array('id' => $id), 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
    }

    public function getGiftCardByID($id) {
        $q = $this->db->get_where('gift_cards', array('id' => $id), 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
    }

    public function getGiftCardByNO($no) {
        $q = $this->db->get_where('gift_cards', array('card_no' => $no), 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
    }
	
	public function getGiftCardHistoryByNo($no) {
        $q = $this->db->get_where('gift_cards', array('card_no' => $no), 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
    }
	
	public function getDepositByCompanyID($comapny_id) {
        $q = $this->db->get_where('companies', array('id' => $comapny_id), 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
    }

    public function updateInvoiceStatus() {
        $date = date('Y-m-d');
        $q = $this->db->get_where('invoices', array('status' => 'unpaid'));
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                if ($row->due_date < $date) {
                    $this->db->update('invoices', array('status' => 'due'), array('id' => $row->id));
                }
            }
            $this->db->update('settings', array('update' => $date), array('setting_id' => '1'));
            return true;
        }
    }

    public function modal_js() {
        return '<script type="text/javascript">' . file_get_contents($this->data['assets'] . 'js/modal.js') . '</script>';
    }

    public function getReference($field, $date = null) {
		if(!$date){
			$date = date('Y-m');
		}
        $q = $this->db->get_where('order_ref', array('DATE_FORMAT(date,"%Y-%m")' => $date), 1);
		
        if ($q->num_rows() > 0) {
            $ref = $q->row();
            switch ($field) {
                case 'so':
                    $prefix = $this->Settings->sales_prefix;
                    break;
                case 'qu':
                    $prefix = $this->Settings->quote_prefix;
                    break;
                case 'po':
                    $prefix = $this->Settings->purchase_prefix;
                    break;
                case 'to':
                    $prefix = $this->Settings->transfer_prefix;
                    break;
                case 'do':
                    $prefix = $this->Settings->delivery_prefix;
                    break;
                case 'pay':
                    $prefix = $this->Settings->payment_prefix;
                    break;
                case 'pos':
                    $prefix = '';
                    break;
                case 're':
                    $prefix = $this->Settings->return_prefix;
                    break;
                case 'ex':
                    $prefix = $this->Settings->expense_prefix;
                    break;
				case 'sp':
                    $prefix = $this->Settings->sale_payment_prefix;
                    break;
				case 'pp':
                    $prefix = $this->Settings->purchase_payment_prefix;
                    break;
				case 'sl':
                    $prefix = $this->Settings->sale_loan_prefix;
                    break;
				case 'tr':
                    $prefix = $this->Settings->transaction_prefix;
					break;
				case 'con':
                    $prefix = $this->Settings->convert_prefix;
					break;
                case 'rep':
                    $prefix = $this->Settings->returnp_prefix;
					break;
				case 'qa':
                    $prefix = $this->Settings->adjustment_prefix;
					break;
                default:
                    $prefix = '';
            }
			
            $ref_no = (!empty($prefix)) ? $prefix . '/' : '';
			if ($this->Settings->reference_format == 1) {
                $ref_no .= date('ym') . "/" . sprintf("%05s", $ref->{$field});
            }elseif ($this->Settings->reference_format == 2) {
                $ref_no .= date('Y') . "/" . sprintf("%05s", $ref->{$field});
            } elseif ($this->Settings->reference_format == 3) {
                $ref_no .= date('Y/m') . "/" . sprintf("%05s", $ref->{$field});
            } elseif ($this->Settings->reference_format == 4) {
                $ref_no .= sprintf("%05s", $ref->{$field});
            } else {
				$ref_no .= $this->getRandomReference();
            }
            return $ref_no;
        }
        return FALSE;
    }

    public function getRandomReference($len = 12) {
        $result = '';
        for ($i = 0; $i < $len; $i++) {
            $result .= mt_rand(0, 9);
        }

        if ($this->getSaleByReference($result)) {
            $this->getRandomReference();
        }

        return $result;
    }

    public function getSaleByReference($ref) {
        $this->db->like('reference_no', $ref, 'before');
        $q = $this->db->get('sales', 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
    }

    public function updateReference($field, $date = null) {
		if(!$date){
			$date = date('Y-m');
		}
        $q = $this->db->get_where('order_ref', array('DATE_FORMAT(date,"%Y-%m")' => $date), 1);
        if ($q->num_rows() > 0) {
            $ref = $q->row();
            $this->db->update('order_ref', array($field => $ref->{$field} + 1), array('DATE_FORMAT(date,"%Y-%m")' => $date));
            return TRUE;
        }
        return FALSE;
    }

    public function checkPermissions() {
        $q = $this->db->get_where('permissions', array('group_id' => $this->session->userdata('group_id')), 1);
        if ($q->num_rows() > 0) {
            return $q->result_array();
        }
        return FALSE;
    }
    
    public function getPermission() {
        $q = $this->db->get_where('permissions', array('group_id' => $this->session->userdata('group_id')), 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
    }

    public function getNotifications() {
        $date = date('Y-m-d H:i:s', time());
        $this->db->where("from_date <=", $date);
        $this->db->where("till_date >=", $date);
        if (!$this->Owner) {
            if ($this->Supplier) {
                $this->db->where('scope', 4);
            } elseif ($this->Customer) {
                $this->db->where('scope', 1)->or_where('scope', 3);
            } elseif (!$this->Customer && !$this->Supplier) {
                $this->db->where('scope', 2)->or_where('scope', 3);
            }
        }
        $q = $this->db->get("notifications");
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
    }

    public function getUpcomingEvents() {
        $dt = date('Y-m-d');
        $this->db->where('start >=', $dt)->order_by('start')->limit(5);
        if ($this->Settings->restrict_calendar) {
            $this->db->where('user_id', $this->session->userdata('user_id'));
        }

        $q = $this->db->get('calendar');

        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return FALSE;
    }

    public function getUserGroup($user_id = false) {
        if (!$user_id) {
            $user_id = $this->session->userdata('user_id');
        }
        $group_id = $this->getUserGroupID($user_id);
        $q = $this->db->get_where('groups', array('id' => $group_id), 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
    }

    public function getUserGroupID($user_id = false) {
        $user = $this->getUser($user_id);
        return $user->group_id;
    }

    public function getWarehouseProductsVariants($option_id, $warehouse_id = NULL) {
        if ($warehouse_id) {
            $this->db->where('warehouse_id', $warehouse_id);
        }
        $q = $this->db->get_where('warehouses_products_variants', array('option_id' => $option_id));
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return FALSE;
    }

    public function getPurchasedItem($where_clause) {
        $orderby = ($this->Settings->accounting_method == 1) ? 'asc' : 'desc';
        $this->db->order_by('date', $orderby);
        $this->db->order_by('purchase_id', $orderby);
        $q = $this->db->get_where('purchase_items', $where_clause);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
    }

    public function syncVariantQty($variant_id, $warehouse_id, $product_id = NULL) {
        $balance_qty = $this->getBalanceVariantQuantity($variant_id);
        $wh_balance_qty = $this->getBalanceVariantQuantity($variant_id, $warehouse_id);		
		
        if ($this->db->update('product_variants', array('quantity' => $balance_qty), array('id' => $variant_id))) {
            if ($this->getWarehouseProductsVariants($variant_id, $warehouse_id)) {
                $this->db->update('warehouses_products_variants', array('quantity' => $wh_balance_qty), array('option_id' => $variant_id, 'warehouse_id' => $warehouse_id));
            } else {
                if($wh_balance_qty) {
					//$option = $this->getProductVariantByID($product_id);
					//$variant_qty = $option->qty_unit;
					//$quantity = $option->quantity;
                    $this->db->insert('warehouses_products_variants', array('quantity' => $wh_balance_qty, 'option_id' => $variant_id, 'warehouse_id' => $warehouse_id, 'product_id' => $product_id));
                }
            }
            return TRUE;
        }
        return FALSE;
    }

    public function getWarehouseProducts($product_id, $warehouse_id = NULL) {
        if ($warehouse_id) {
            $this->db->where('warehouse_id', $warehouse_id);
        }
        $q = $this->db->get_where('warehouses_products', array('product_id' => $product_id));
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return FALSE;
    }
	
    public function getPurchaseBalanceQuantity($product_id, $warehouse_id = NULL) {
        $this->db->select('SUM(COALESCE(quantity_balance, 0)) as stock', False);
        $this->db->where('product_id', $product_id)->where('quantity_balance !=', 0);
        if ($warehouse_id) {
            $this->db->where('warehouse_id', $warehouse_id);
        }
        $q = $this->db->get('purchase_items');
        if ($q->num_rows() > 0) {
            $data = $q->row();
            return $data->stock;
        }
        return 0;
    }
	
	public function getProudctBalanceQuantity($product_id, $warehouse_id = NULL) {
        $this->db->select('SUM(COALESCE('.$this->db->dbprefix('product_variants').'.quantity, 0)) as stock', False);
		$this->db->join('warehouses_products_variant', 'warehouses_products_variants.product_id = product_variants.product_id');
        $this->db->where($this->db->dbprefix('product_variants').'.product_id', $product_id)->where($this->db->dbprefix('product_variants').'.quantity !=', 0);
        if ($warehouse_id) {
            $this->db->where('warehouse_id', $warehouse_id);
        }
        $q = $this->db->get('product_variants');
        if ($q->num_rows() > 0) {
            $data = $q->row();
            return $data->stock;
        }
        return 0;
    }
	
	public function getProductQty($product_id){
		$this->db->select('SUM(COALESCE(quantity, 0)) as stock', False);
		$this->db->where('id',$product_id);
		$q = $this->db->get('products');
        if ($q->num_rows() > 0) {
            $data = $q->row();
            return $data->stock;
        }
        return 0;
	}
	
    public function syncProductQty($product_id, $warehouse_id) {
        $balance_qty = $this->getBalanceQuantity($product_id);
        $wh_balance_qty = $this->getBalanceQuantity($product_id, $warehouse_id);

        if ($this->db->update('products', array('quantity' => $balance_qty), array('id' => $product_id))) {
            if ($this->getWarehouseProducts($product_id, $warehouse_id)) {
                $this->db->update('warehouses_products', array('quantity' => $wh_balance_qty), array('product_id' => $product_id, 'warehouse_id' => $warehouse_id));
            } else {
                if( ! $wh_balance_qty) { $wh_balance_qty = 0; }
                $this->db->insert('warehouses_products', array('quantity' => $wh_balance_qty, 'product_id' => $product_id, 'warehouse_id' => $warehouse_id));
            }
            return TRUE;
        }
        return FALSE;
    }
	
	public function syncProductQuantity($product_id, $warehouse_id) {
        $balance_qty = $this->getBalanceQty($product_id);
        $wh_balance_qty = $this->getBalanceQty($product_id, $warehouse_id);
		$this->db->update('products', array('quantity' => $balance_qty), array('id' => $product_id));
        return FALSE;
    }
    
    function getCustomerNameByID($cus_id = null)
	{
        $this->db->select('name, company');
		$this->db->where(array('id' => $cus_id));
        $q = $this->db->get('companies');
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
	}

    public function getSaleByID($id) {
        $q = $this->db->get_where('sales', array('id' => $id), 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
    }
	
	function getSellingByID($cus_id = null)
	{
        $this->db->select("id, date, reference_no, biller, customer, sale_status, grand_total, paid, (grand_total-paid) as balance, payment_status");
		$this->db->where(array('id' => $cus_id));
        $q = $this->db->get('sales');
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
	}

    public function getSalePayments($sale_id) {
        $q = $this->db->get_where('payments', array('sale_id' => $sale_id));
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return FALSE;
    }
	
    public function syncSalePaymentsCur($id) {
		
        $sale = $this->getSaleByID($id);
        $payments = $this->getSalePayments($id);
        $paid = 0;
        foreach ($payments as $payment) {
            if ($payment->type == 'returned') {
				$paid -= $sale->paid;
            } else {
				$paid += $payment->amount;
            }
        }
		$payment_term = $sale->payment_term;
		$sale_status = $sale->sale_status;
        $payment_status = $paid <= 0 ? 'due' : $sale->payment_status;
        if ($paid <= 0 && $sale->due_date <= date('Y-m-d')) {
            if ($payment->type == 'returned') {
				$payment_status = 'returned';
				$payment_term = 0;
				$paid = -1 * abs($paid);
			} else {
				if($sale->paid == 0 && $sale->grand_total == 0 || $sale->payment_status == 'paid'){
					$payment_status = 'paid';
					$sale_status = 'completed';
				} else {
					$payment_status = 'due';
				}
			}
        } elseif ($this->erp->formatDecimal($sale->grand_total) > $this->erp->formatDecimal($paid) && $paid > 0) {
            $payment_status = 'partial';
        } elseif ($this->erp->formatDecimal($sale->grand_total) <= $this->erp->formatDecimal($paid)) {
			if ($payment->type == 'returned') {
				$payment_status = 'returned';
				$paid = -1 * abs($paid);
			}else{
				$payment_status = 'paid';
				$sale_status = 'completed';
			}
			$payment_term = 0;
        }
        if ($this->db->update('sales', array('paid' => $paid, 'sale_status' => $sale_status ,'payment_status' => $payment_status,'payment_term'=>$payment_term), array('id' => $id))) {
            return true;
        }
        return FALSE;
    }
	
	public function syncSalePayments($id) {
        $sale = $this->getSaleByID($id);
        $payments = $this->getSalePayments($id);
        $paid = 0;
        foreach ($payments as $payment) {
            if ($payment->type == 'returned') {
                $paid -= ($payment->amount-$payment->extra_paid);
				//$paid -= $sale->paid;
            } else {
                $paid += ($payment->amount-$payment->extra_paid);
				//$paid += $sale->paid;
            }
        }
		$sale_status = $sale->sale_status;
        $payment_status = $paid <= 0 ? 'pending' : $sale->payment_status;
        if ($paid <= 0 && $sale->due_date <= date('Y-m-d')) {
            if ($payment->type == 'returned') {
				$payment_status = 'returned';
				$payment_term = 0;
				$paid = -1 * abs($paid);
			}else{
				if($sale->paid == 0 && $sale->grand_total == 0){
					$payment_status = 'paid';
					$sale_status = 'completed';
				}else{
					$payment_status = 'due';
				}
			}
        } elseif ($this->erp->formatDecimal($sale->grand_total) > $this->erp->formatDecimal($paid) && $paid > 0) {
            $payment_status = 'partial';
        } elseif ($this->erp->formatDecimal($sale->grand_total) <= $this->erp->formatDecimal($paid)) {
			if ($payment->type == 'returned') {
				$payment_status = 'returned';
				$paid = -1 * abs($paid);
			}else{
				$payment_status = 'paid';
				$sale_status = 'completed';
			}
			$payment_term = 0;
        }
		
        if ($this->db->update('sales', array('paid' => $paid, 'sale_status' => $sale_status ,'payment_status' => $payment_status,'payment_term'=>$payment_term), array('id' => $id))) {
            return true;
        }
        return FALSE;
    }

    public function getPurchaseByID($id) {
        $q = $this->db->get_where('purchases', array('id' => $id), 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
    }

    public function getPurchasePayments($purchase_id) {
        $q = $this->db->get_where('payments', array('purchase_id' => $purchase_id));
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return FALSE;
    }

    public function syncPurchasePayments($id) {
        $purchase = $this->getPurchaseByID($id);
        $payments = $this->getPurchasePayments($id);
        $paid = 0;
        foreach ($payments as $payment) {
            $paid += $payment->amount;
        }

        $payment_status = $paid <= 0 ? 'pending' : $purchase->payment_status;
		$payment_term = $purchase->payment_term;
        if ($this->erp->formatDecimal($purchase->grand_total) > $this->erp->formatDecimal($paid) && $paid > 0) {
            $payment_status = 'partial';
        } elseif ($this->erp->formatDecimal($purchase->grand_total) <= $this->erp->formatDecimal($paid)) {
            $payment_status = 'paid';
			$payment_term = 0;
        }

        if ($this->db->update('purchases', array('paid' => $paid, 'payment_status' => $payment_status, 'payment_term' => $payment_term), array('id' => $id))) {
            return true;
        }
        return FALSE;
    }

	private function getBalanceQtySaleItems($product_id, $warehouse_id = NULL) {
        $this->db->select("SUM(COALESCE(quantity, 0)) as stock", False);
        $this->db->where('product_id', $product_id);
		if ($warehouse_id) {
            $this->db->where('warehouse_id', $warehouse_id);
        }
        $q = $this->db->get('sale_items');
        if ($q->num_rows() > 0) {
            $data = $q->row();
            return $data->stock;
        }
        return 0;
    }
	
    private function getBalanceQuantity($product_id, $warehouse_id = NULL) {
        $this->db->select("SUM(COALESCE(quantity_balance, 0)) as stock", False);
        $this->db->where('product_id', $product_id);
        if ($warehouse_id) {
            $this->db->where('warehouse_id', $warehouse_id);
        }
        $q = $this->db->get('purchase_items');
        if ($q->num_rows() > 0) {
            $data = $q->row();
            return $data->stock;
        }
        return 0;
    }
	
	private function getBalanceQty($product_id, $warehouse_id = NULL) {
        $this->db->select("SUM(COALESCE(quantity, 0)) as stock", False);
        $this->db->where('product_id', $product_id);
        if ($warehouse_id) {
            $this->db->where('warehouse_id', $warehouse_id);
        }
        $q = $this->db->get('warehouses_products');
        if ($q->num_rows() > 0) {
            $data = $q->row();
            return $data->stock;
        }
        return 0;
    }
    
    public function getProductType($product_id){
        $this->db->select('type');
        $this->db->where('id', $product_id);
        $q = $this->db->get('products');
        if ($q->num_rows() > 0) {
            $data = $q->row();
            return $data->type;
        }
        return FALSE;
    }

    private function getBalanceVariantQuantity($variant_id, $warehouse_id = NULL) {
        $this->db->select('SUM(COALESCE(quantity_balance, 0)) as stock', False);
        $this->db->where('option_id', $variant_id)->where('quantity_balance !=', 0);
        if ($warehouse_id) {
            $this->db->where('warehouse_id', $warehouse_id);
        }
        $q = $this->db->get('purchase_items');
        if ($q->num_rows() > 0) {
            $data = $q->row();
            return $data->stock;
        }
        return 0;
    }

	public function getSaleItemsByTwoID($product_id, $sale_id){
		$q = $this->db->get_where('sale_items', array('product_id' => $product_id, 'sale_id' => $sale_id), 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
	}
	
    /*************/
	public function calculateAVCost($product_id, $warehouse_id, $net_unit_price, $unit_price, $quantity, $product_name, $option_id, $item_quantity, $pur_id = NULL, $sale_id) {
        $qty		 	= 0;
        $product 		= $this->getProductByID($product_id);
		$sale_item 		= $this->getSaleItemsByTwoID($product_id, $sale_id);
		if($pur_id == ""){
			$real_item_qty 	= $product->quantity - $quantity;
			if($real_item_qty < 0){
				$qty++;
			}
		}else{
			$real_item_qty 	= ($product->quantity + $sale_item->quantity) - $quantity;
			if($real_item_qty < 0){
				$qty++;
			}
		}
		
        if ($qty > 0 && $this->Settings->overselling) {
            $this->session->set_flashdata('error', sprintf(lang("quantity_out_of_stock_for_%s"), ($pi->product_name ? $pi->product_name : $product_name)));
            redirect($_SERVER["HTTP_REFERER"]);
        } else {
            $cost[] = array(
				'date' 				=> date('Y-m-d'),
				'pi_overselling' 	=> 1, 
				'product_id' 		=> $product->id, 
				'product_code'		=> $product->code,
				'product_name'		=> $product->name,
				'quantity_balance' 	=> (0 - $quantity), 
				'warehouse_id' 		=> $warehouse_id, 
				'option_id' 		=> $option_id,
				'sale_id'			=> $sale_id
			);
        }
		
        return $cost;
    }
	
	public function calculateAVCosts($product_id, $warehouse_id, $net_unit_price, $unit_price, $quantity, $product_name, $option_id, $item_quantity, $shipping) {
        $real_item_qty = $quantity;
		$average_cost = 0;
        if ($pis = $this->getPurchasedItems($product_id, $warehouse_id, $option_id)) {
            $cost_row = array();
            $quantity = $item_quantity;
            $balance_qty = $quantity;
            $total_net_unit_cost = 0;
            $total_unit_cost = 0;
			$total_unit_costs = 0;
			$total_shipping = 0;

            foreach ($pis as $pi) {
				
				$oldcost = $this->getoldcost($product_id);
				$getoldcost = $oldcost->cost;
				$old_qty = $oldcost->quantity;

				if($getoldcost == 0 || $getoldcost == ''){
					if ($pi->item_discount || $shipping) {
						$percentage = '%';
						$purchase_discount = $pi->discount;
						$opos = strpos($purchase_discount, $percentage);
						if ($opos !== false) {
							$ods = explode("%", $purchase_discount);
							//$total_new_cost = ($unit_price * $quantity)-(($unit_price * $quantity)*($pi->discount/100));
							$total_new_cost = (($unit_price * $quantity) * (Float)($ods[0])) / 100;
						} else {
							$total_new_cost = (($unit_price * $quantity)) - $pi->item_discount;
						}
						$average_cost = ($total_new_cost/$quantity);
					} else {
						$average_cost = $unit_price;
					}
				}else{
					$total_old_cost = $old_qty * $getoldcost;
					$total_new_cost = ($unit_price * $quantity);
					
					if ($pi->item_discount) {
						$percentage = '%';
						$purchase_discount = $pi->discount;
						$opos = strpos($purchase_discount, $percentage);
						if ($opos !== false) {
							$ods = explode("%", $purchase_discount);
							//$total_new_cost = ($unit_price * $quantity)-(($unit_price * $quantity)*($pi->discount/100));
							$total_new_cost = (($unit_price * $quantity) * (Float)($ods[0])) / 100;
						} else {
							$total_new_cost = ($unit_price * $quantity) - $pi->item_discount;
						}
					}
					
					$total_qty = $quantity + $old_qty;
					$total_cost = $total_new_cost + $total_old_cost;
					
					$average_cost = ($total_cost/$total_qty);
				}
			}
		}
        return $average_cost;
    }
	
	public function getoldcost($product_id){
		$this->db->select('cost, quantity');
        $q = $this->db->get_where('products', array('id'=>$product_id), 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
	}
	
	public function calculateAverageCostShipping($product_id, $warehouse_id, $net_unit_cost, $quantity,$option_id, $shipping, $subtotal, $t_po_item_amount){	
		$costunit = 0;
		//if ($pis = $this->getPurchasedItems($product_id, $warehouse_id, $option_id)) {
		$freight_net = $shipping;
		$unit_cost = $net_unit_cost;
		$total_cost_line = $subtotal;
		$qty_new_receive = $quantity;
		
		$f_percents = ($total_cost_line / $t_po_item_amount) * 100;
		
		$f_atm = $freight_net * ($f_percents / 100);
		
		$f_cost = $f_atm / $qty_new_receive;
		
		$f_total_cost = $total_cost_line + $f_atm;
		
		$average_cost = $f_total_cost/$qty_new_receive;
		if ($pis = $this->getPurchasedItems($product_id, $warehouse_id, $option_id)) {

			$oldcost = $this->getoldcost($product_id);
			$old_cost = $oldcost->cost;
			$old_qty = $oldcost->quantity;
			if($option_id != "false" || $option_id == NULL){
				$option = $this->getProductVariantByOptionID($option_id);
				if($option){
					$new_cost = ($unit_cost + $f_cost) / $option->qty_unit;
				}else {
					$new_cost = ($unit_cost + $f_cost);
				}
			} else {
				$new_cost = ($unit_cost + $f_cost);
			}
			$new_qty = $qty_new_receive;
			$total_old_cost = $old_qty * $old_cost;
			//$total_new_cost = $new_cost * $new_qty;
			$total_new_cost = $new_cost;
			$total_qty = $new_qty + $old_qty;
			$total_cost = $total_new_cost + $total_old_cost;
			if($old_cost == 0 && $old_qty > 0 || $old_cost == ''){
				$average_cost = $total_new_cost/$total_qty;
			}else{
				$average_cost = $total_cost/$total_qty;
			}
		}
		
		return $average_cost;
	}
	
	public function calculateAverageCost($product_id, $unit_cost, $quantity, $product_amount, $item_discount, $order_discount, $shipping, $subtotal){
		$average_cost = 0;
		$discount = 0;
		$ship = 0;
		//New Product which have no cost products and purchase_item;
		$average_cost = $unit_cost;
		
		//Get old cost from products
		$oldcost = $this->getoldcost($product_id);
		$old_cost = $oldcost->cost;
		$old_qty = $oldcost->quantity;
		
		//Have Discounts and Shipping
		if ($item_discount || $order_discount || $shipping) {
			if ($order_discount) {
				$percentage = '%';
				$opos = strpos($order_discount, $percentage);
				if ($opos !== false) {
					$ods = explode("%", $order_discount);
					$discount = (($unit_cost * $quantity) * (Float)($ods[0])) /100 ;
				} else {
					$discount = $this->erp->formatPurDecimal($order_discount/$product_amount);
				}
			}
			if($shipping){
				if($product_amount > 1){
					$ship = ($shipping * $unit_cost)/$subtotal; 
				}else{
					$ship = $shipping;
				}
			}
			$total_new_cost = ($unit_cost * $quantity)-($item_discount + $discount) + $ship;
		} else {
			$total_new_cost = $unit_cost * $quantity;
		}
		
		$total_old_cost = $old_cost * $old_qty;
		$total_cost     = $total_new_cost + $total_old_cost;
		$total_qty      = $quantity + $old_qty;
		$average_cost   = $total_cost/$total_qty;
		
		return $average_cost;
	}
	
	public function updateQualityPro($SQLdata, $id){
		$this->db->where('code',$id);
		$this->db->update('products',$SQLdata);
		return $this->db->affected_rows();
	}
	
	public function updateCostPro($SQLdata, $id){
		$this->db->where('id',$id);
		$this->db->update('products',$SQLdata);
		return $this->db->affected_rows();
	}
	
	public function calculateCONAVCost($convert_id) {
		$average_cost = '';
		$total_cost = '';
		$total_qty  = '';
		$pro_id = '';
        if ($pis = $this->getConvertItemsById($convert_id)) {
            foreach ($pis as $pi) {
				if($pi->status == 'deduct'){
					$total_cost += $pi->ccost;
				}else{
					$total_qty += $pi->c_quantity;
					$pro_id[] = $pi->product_id;
				}
			}
			foreach($pro_id as $id){
				$result = $this->getProductinfo($id, $convert_id);
				if($result->p_cost > 0){
					$new_cost = $total_cost / $total_qty;
					$avgcost = ($result->p_cost + $new_cost) / 2;
				}else{
					$avgcost = $total_cost/$total_qty;
				}
                //echo $avgcost;exit;
				$this->updateCostPro(array('cost' => $avgcost), $id);
                
			}
        }
    }

	public function getConvertItemsById($convert_id){
		$this->db->select('convert_items.status, convert_items.convert_id, convert_items.quantity AS c_quantity , products.cost AS pcost, convert_items.cost AS ccost, convert_items.product_id');
		$this->db->join('products', 'products.id = convert_items.product_id', 'INNER');
		$this->db->where(array('convert_items.convert_id'=> $convert_id));
		$query = $this->db->get('convert_items');
		
		if ($query->num_rows() > 0) {
            foreach ($query->result() as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return false;
	}
	
	public function getProductinfo($id, $convert_id){
		$this->db->select('convert_items.quantity AS Cquantity , products.cost AS p_cost, products.quantity AS Pquantity');
		$this->db->join('products', 'products.id = convert_items.product_id', 'left');
		$this->db->where(array('convert_items.convert_id'=> $convert_id, 'convert_items.product_id'=> $id));
		$query = $this->db->get('convert_items');
		
		if ($query->num_rows() > 0) {
            return $query->row();
        }
        return false;
	}
	
	public function calculateCosts($unit_price, $item_quantity, $shipping){
		$new_unit_cost = ($unit_price*$item_quantity)+$shipping;
		$final_cost    = $new_unit_cost / $item_quantity;
		return $final_cost;
	}
	public function calculateCost($unit_price, $item_quantity, $shipping){
		$new_unit_cost = ($unit_price*$item_quantity);
		$final_cost    = $new_unit_cost / $item_quantity;
		return $final_cost;
	}
	/*
    public function getPurchasedItems($product_id, $warehouse_id, $option_id = NULL) {
		$orderby = ($this->Settings->accounting_method == 1) ? 'asc' : 'desc';
        $this->db->select('id, quantity, quantity_balance, net_unit_cost, unit_cost, item_tax, purchase_id, real_unit_cost');
        $this->db->where('product_id', $product_id)->where('warehouse_id', $warehouse_id)->where('quantity_balance !=', 0);
        if ($option_id) {
            $this->db->where('option_id', $option_id);
        }
        $this->db->group_by('id');
        $this->db->order_by('date', $orderby);
        $this->db->order_by('purchase_id', $orderby);
        $q = $this->db->get('purchase_items');
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return FALSE;

    }
	*/
	
	public function getPurchasedItems($product_id, $warehouse_id, $option_id = NULL, $convert_id = NULL) {
        $orderby = ($this->Settings->accounting_method == 1) ? 'asc' : 'desc';
        $this->db->select('id, quantity, SUM(quantity_balance) as quantity_balance, net_unit_cost, unit_cost, item_tax');
        $this->db->where('product_id', $product_id)->where('warehouse_id', $warehouse_id)->where('quantity_balance !=', 0);
        if ($option_id == 'false' || $option_id == null || $option_id == 'undefined') {
            //$this->db->where('option_id', $option_id);
        }else{
			$this->db->where('option_id', $option_id);
		}
		if($convert_id){
			$this->db->where('convert_id', $convert_id);
		}
        $this->db->group_by('product_id');
        $this->db->order_by('date', $orderby);
        $this->db->order_by('purchase_id', $orderby);
        $q = $this->db->get('purchase_items');
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return FALSE;
    }
	
	public function getShippingItems($id) {
        $this->db->select('shipping');
        $this->db->where('id', $id);
        $q = $this->db->get('purchases');
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return FALSE;
    }

    public function getProductComboItems($pid, $warehouse_id = NULL)
    {
        $this->db->select('products.id as id, combo_items.item_code as code, combo_items.quantity as qty, products.name as name, products.type as type, combo_items.unit_price as unit_price, warehouses_products.quantity as quantity')
            ->join('products', 'products.code=combo_items.item_code', 'left')
            ->join('warehouses_products', 'warehouses_products.product_id=products.id', 'left')
            ->group_by('combo_items.id');
        if($warehouse_id) {
            $this->db->where('warehouses_products.warehouse_id', $warehouse_id);
        }
        $q = $this->db->get_where('combo_items', array('combo_items.product_id' => $pid));
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }

            return $data;
        }
        return FALSE;
    }
	
    public function item_costing($item, $pi = NULL, $pur_id = NULL) {
        $item_quantity = $pi ? $item['aquantity'] : $item['quantity'];
        if (!isset($item['option_id']) || $item['option_id'] == 'null') {
            $item['option_id'] = NULL;
        }
		
        if ($this->Settings->accounting_method != 2 && !$this->Settings->overselling) {
            if ($this->site->getProductByID($item['product_id'])) {
                if ($item['product_type'] == 'standard') {
					$cost = $this->site->calculateAVCost($item['product_id'], $item['warehouse_id'], $item['net_unit_price'], $item['unit_price'], $item['quantity'], $item['product_name'], $item['option_id'], $item_quantity, $pur_id, $item['sale_id']);
                } elseif ($item['product_type'] == 'combo') {
					$combo_items = $this->getProductComboItems($item['product_id'], $item['warehouse_id']);
                    foreach ($combo_items as $combo_item) {
                        $pr = $this->getProductByCode($combo_item->code);
                        if ($pr->tax_rate) {
                            $pr_tax = $this->site->getTaxRateByID($pr->tax_rate);
                            if ($pr->tax_method) {
                                $item_tax = $this->erp->formatDecimal((($combo_item->unit_price) * $pr_tax->rate) / (100 + $pr_tax->rate));
                                $net_unit_price = $combo_item->unit_price - $item_tax;
                                $unit_price = $combo_item->unit_price;
                            } else {
                                $item_tax = $this->erp->formatDecimal((($combo_item->unit_price) * $pr_tax->rate) / 100);
                                $net_unit_price = $combo_item->unit_price;
                                $unit_price = $combo_item->unit_price + $item_tax;
                            }
                        } else {
                            $net_unit_price = $combo_item->unit_price;
                            $unit_price = $combo_item->unit_price;
                        }
                        if ($pr->type == 'standard') {
                            $cost = $this->site->calculateAVCost($pr->id, $item['warehouse_id'], $net_unit_price, $unit_price, ($combo_item->qty * $item['quantity']), $pr->name, NULL, $item_quantity, $pur_id, $item['sale_id']);
                        } else {
                            $cost = array(
								array(
									'date' 				=> date('Y-m-d'), 
									'product_id' 		=> $pr->id, 
									'sale_item_id' 		=> 'sale_items.id', 
									'purchase_item_id' 	=> NULL, 
									'quantity' 			=> ($combo_item->qty * $item['quantity']), 'purchase_net_unit_cost' => 0, 
									'purchase_unit_cost' 	=> 0, 
									'sale_net_unit_price' 	=> $combo_item->unit_price, 'sale_unit_price' 	=> $combo_item->unit_price, 
									'quantity_balance' 	=> NULL, 
									'inventory' 		=> NULL,
									'sale_id'			=> $item['sale_id']
								));
                        }
                    }
                } else {
					$cost = array(
						array(
							'date' 						=> date('Y-m-d'), 
							'product_id' 				=> $item['product_id'], 
							'sale_item_id' 				=> 'sale_items.id', 
							'purchase_item_id' 			=> NULL, 
							'quantity' 					=> $item['quantity'], 
							'purchase_net_unit_cost' 	=> 0, 
							'purchase_unit_cost' 		=> 0, 
							'sale_net_unit_price' 		=> $item['net_unit_price'], 
							'sale_unit_price' 			=> $item['unit_price'], 
							'quantity_balance' 			=> NULL, 
							'inventory' 				=> NULL,
							'sale_id'					=> $item['sale_id']
						));
                }
            } elseif ($item['product_type'] == 'manual') {
                $cost = array(
					array(
						'date' 						=> date('Y-m-d'), 
						'product_id' 				=> $item['product_id'], 
						'sale_item_id' 				=> 'sale_items.id', 
						'purchase_item_id' 			=> NULL, 
						'quantity' 					=> $item['quantity'], 
						'purchase_net_unit_cost' 	=> 0, 
						'purchase_unit_cost' 		=> 0, 
						'sale_net_unit_price' 		=> $item['net_unit_price'], 
						'sale_unit_price' 			=> $item['unit_price'], 
						'quantity_balance' 			=> NULL, 
						'inventory' 				=> NULL,
						'sale_id'					=> $item['sale_id']
					));
            }

        } 
		else {
			
            if ($this->site->getProductByID($item['product_id'])) {
                if ($item['product_type'] == 'standard') {
					$cost = $this->site->calculateAVCost($item['product_id'], $item['warehouse_id'], $item['net_unit_price'], $item['unit_price'], $item['quantity'], $item['product_name'], $item['option_id'], $item_quantity, $pur_id, $item['sale_id']);
				} elseif ($item['product_type'] == 'combo') {
                    $combo_items = $this->getProductComboItems($item['product_id'], $item['warehouse_id']);
                    foreach ($combo_items as $combo_item) {
                        $cost = $this->site->calculateAVCost($combo_item->id, $item['warehouse_id'], ($combo_item->qty * $item['quantity']), $item['unit_price'], $item['quantity'], $item['product_name'], $item['option_id'], $item_quantity, $pur_id, $item['sale_id']);
                    }
                } else {
                    $cost = array(
						array(
							'date' 						=> date('Y-m-d'), 
							'product_id' 				=> $item['product_id'], 
							'sale_item_id' 				=> 'sale_items.id', 
							'purchase_item_id' 			=> NULL, 
							'quantity' 					=> $item['quantity'], 
							'purchase_net_unit_cost' 	=> 0, 
							'purchase_unit_cost' 		=> 0, 
							'sale_net_unit_price' 		=> $item['net_unit_price'], 
							'sale_unit_price' 			=> $item['unit_price'], 
							'quantity_balance' 			=> NULL, 
							'inventory' 				=> NULL,
							'sale_id'					=> $item['sale_id']
						));
                }
            } elseif ($item['product_type'] == 'manual') {
                $cost = array(
					array(
						'date' 						=> date('Y-m-d'), 
						'product_id' 				=> $item['product_id'], 
						'sale_item_id' 				=> 'sale_items.id', 
						'purchase_item_id' 			=> NULL, 
						'quantity' 					=> $item['quantity'], 
						'purchase_net_unit_cost' 	=> 0, 
						'purchase_unit_cost' 		=> 0, 
						'sale_net_unit_price' 		=> $item['net_unit_price'], 
						'sale_unit_price' 			=> $item['unit_price'], 
						'quantity_balance' 			=> NULL, 
						'inventory' 				=> NULL,
						'sale_id'					=> $item['sale_id']
					));
            }
        }
		
        return $cost;
		
    }

    public function costing($items, $id = NULL) {
		
        $citems = array();
        foreach ($items as $item) {
            $pr = $this->getProductByID($item['product_id']);
			
            if ($pr->type == 'standard') {
                if (isset($citems['p' . $item['product_id'] . 'o' . $item['option_id']])) {
                    $citems['p' . $item['product_id'] . 'o' . $item['option_id']]['aquantity'] += $item['quantity'];
                } else {
                    $citems['p' . $item['product_id'] . 'o' . $item['option_id']] = $item;
                    $citems['p' . $item['product_id'] . 'o' . $item['option_id']]['aquantity'] = $item['quantity'];
                }
            } elseif ($pr->type == 'combo') {
                $combo_items = $this->getProductComboItems($item['product_id'], $item['warehouse_id']);
                foreach ($combo_items as $combo_item) {
                    if ($combo_item->type == 'standard') {
                        if (isset($citems['p' . $combo_item->id . 'o' . $item['option_id']])) {
                            $citems['p' . $combo_item->id . 'o' . $item['option_id']]['aquantity'] += ($combo_item->qty*$item['quantity']);
                        } else {
                            $cpr = $this->getProductByID($combo_item->id);
                            if ($cpr->tax_rate) {
                                $cpr_tax = $this->site->getTaxRateByID($cpr->tax_rate);
                                if ($cpr->tax_method) {
                                    $item_tax = $this->erp->formatDecimal((($combo_item->unit_price) * $cpr_tax->rate) / (100 + $cpr_tax->rate));
                                    $net_unit_price = $combo_item->unit_price - $item_tax;
                                    $unit_price = $combo_item->unit_price;
                                } else {
                                    $item_tax = $this->erp->formatDecimal((($combo_item->unit_price) * $cpr_tax->rate) / 100);
                                    $net_unit_price = $combo_item->unit_price;
                                    $unit_price = $combo_item->unit_price + $item_tax;
                                }
                            } else {
                                $net_unit_price = $combo_item->unit_price;
                                $unit_price = $combo_item->unit_price;
                            }
                            $cproduct = array('product_id' => $combo_item->id, 'product_name' => $cpr->name, 'product_type' => $combo_item->type, 'quantity' => ($combo_item->qty*$item['quantity']), 'net_unit_price' => $net_unit_price, 'unit_price' => $unit_price, 'warehouse_id' => $item['warehouse_id'], 'item_tax' => $item_tax, 'tax_rate_id' => $cpr->tax_rate, 'tax' => ($cpr_tax->type == 1 ? $cpr_tax->rate.'%' : $cpr_tax->rate), 'option_id' => NULL);
                            $citems['p' . $combo_item->id . 'o' . $item['option_id']] = $cproduct;
                            $citems['p' . $combo_item->id . 'o' . $item['option_id']]['aquantity'] = ($combo_item->qty*$item['quantity']);
                        }
                    }
                }
            }
        }
        $cost = array();
        foreach ($citems as $item) {
            $item['aquantity'] = $citems['p' . $item['product_id'] . 'o' . $item['option_id']]['aquantity'];
            $cost[] = $this->item_costing($item, TRUE, $id);
        }
		//$this->erp->print_arrays($cost);
        return $cost;
    }

    public function syncQuantity($sale_id = NULL, $purchase_id = NULL, $oitems = NULL, $product_id = NULL) {
        if ($sale_id) {
            $sale_items = $this->getAllSaleItems($sale_id);
            foreach ($sale_items as $item) {
                if ($item->product_type == 'standard') {
                    $this->syncProductQty($item->product_id, $item->warehouse_id);
                    if (isset($item->option_id) && !empty($item->option_id)) {
                        $this->syncVariantQty($item->option_id, $item->warehouse_id, $item->product_id);
                    }
                } elseif ($item->product_type == 'combo') {
                    $combo_items = $this->getProductComboItems($item->product_id, $item->warehouse_id);
                    foreach ($combo_items as $combo_item) {
                        if($combo_item->type == 'standard') {
                            $this->syncProductQty($combo_item->id, $item->warehouse_id);
                        }
                    }
                }
            }
        } 
		elseif ($purchase_id) {
            $purchase_items = $this->getAllPurchaseItems($purchase_id);
			
			$var_option = 0;
            foreach ($purchase_items as $item) {
				
				if($item->option_id != 0) {
					$var_option = $item->option_id;
				}
                $type = $this->getProductType($item->product_id);
                if($type != 'service'){
                    $this->syncProductQty($item->product_id, $item->warehouse_id);
					$this->syncProductQuantity($item->product_id, $item->warehouse_id);
                    if (isset($item->option_id) && !empty($item->option_id)) {
                        $this->syncVariantQty($item->option_id, $item->warehouse_id, $item->product_id);
                    }
                }
            }

        } 
		elseif ($oitems) {

            foreach ($oitems as $item) {
                if (isset($item->product_type)) {
                    if ($item->product_type == 'standard') {
                        $this->syncProductQty($item->product_id, $item->warehouse_id);
                        if (isset($item->option_id) && !empty($item->option_id)) {
                            $this->syncVariantQty($item->option_id, $item->warehouse_id, $item->product_id);
                        }
                    } elseif ($item->product_type == 'combo') {
                        $combo_items = $this->getProductComboItems($item->product_id, $item->warehouse_id);
                        foreach ($combo_items as $combo_item) {
                            if($combo_item->type == 'standard') {
                                $this->syncProductQty($combo_item->id, $item->warehouse_id);
                            }
                        }
                    }
                } else {
                    $this->syncProductQty($item->product_id, $item->warehouse_id);
                    if (isset($item->option_id) && !empty($item->option_id)) {
                        $this->syncVariantQty($item->option_id, $item->warehouse_id, $item->product_id);
                    }
                }
            }

        } 
		elseif ($product_id) {
            $warehouses = $this->getAllWarehouses();
            foreach ($warehouses as $warehouse) {
                $type = $this->getProductType($product_id);
                if($type != 'service'){
                    $this->syncProductQty($product_id, $warehouse->id);
                    if ($product_variants = $this->getProductVariants($product_id)) {
                        foreach ($product_variants as $pv) {
                            $this->syncVariantQty($pv->id, $warehouse->id, $product_id);
                        }
                    }
                }else{
					if($this->getBalanceQuantity($product_id)){
						$this->db->update('products', array('quantity' => 1), array('id' => $product_id));
					}else{
						$this->db->update('products', array('quantity' => 0), array('id' => $product_id));
					}
				}
            }
        }
    }

    public function getProductVariants($product_id)
    {
        $q = $this->db->get_where('product_variants', array('product_id' => $product_id));
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return FALSE;
    }
	
	public function getProductVariantOptionIDPID($option_id, $product_id)
    {
        $q = $this->db->get_where('product_variants', array('id' => $option_id, 'product_id' => $product_id));
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
    }

    public function getAllSaleItems($sale_id) {
        $q = $this->db->get_where('sale_items', array('sale_id' => $sale_id));
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return FALSE;
    }
	
	public function getSaleItems($id) {
		$this->db->select('sale_items.*, products.category_id');
		$this->db->join('products', 'products.id = sale_items.product_id');
        $q = $this->db->get_where('sale_items', array('product_id' => $id));
        if ($q->num_rows() > 0) {
			return $q->row();
        }
        return FALSE;
    }

    public function getAllPurchaseItems($purchase_id) {
        $q = $this->db->get_where('purchase_items', array('purchase_id' => $purchase_id));
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return FALSE;
    }
	
	public function deleteStrapByProductCode($code = NULL) {
        if ( $this->db->delete('related_products', array('product_code' => $code))) {
            return true;
        }
        return false;
	}

    public function syncPurchaseItems($data = array()) {
        if (!empty($data)) {
            foreach ($data as $items) {
                foreach ($items as $item) {
					$product = $this->getProductByID($item['product_id']);
                    if($product->type != 'service'){
						if (isset($item['pi_overselling'])) {
							unset($item['pi_overselling']);
							$option_id = (isset($item['option_id']) && !empty($item['option_id'])) ? $item['option_id'] : NULL;

							$clause = array(
								'purchase_id' 	=> NULL, 
								'transfer_id' 	=> NULL, 
								'product_id' 	=> $item['product_id'], 
								'warehouse_id' 	=> $item['warehouse_id'], 
								'option_id' 	=> $option_id
							);

							if ($pi = $this->getPurchasedItem($clause)) {
								$clause['quantity'] = 0;
								$clause['item_tax'] = 0;
								if($option_id){
									$option = $this->getProductVariantOptionIDPID($option_id, $item['product_id']);
									$clause['quantity_balance'] = $item['quantity_balance'] * $option->qty_unit;
								}else{
									$clause['quantity_balance'] = $item['quantity_balance'];
								}
								$clause['product_name'] = $product->name;
								$clause['product_code'] = $product->code;
								$clause['sale_id'] 		= $item['sale_id'];
								$clause['date'] = $item['date']?$item['date']:date('Y-m-d');
								//echo '<pre>';print_r($clause);echo '</pre>';
								$this->db->insert('purchase_items', $clause);

							} else {
								$clause['quantity'] = 0;
								$clause['item_tax'] = 0;
								if($option_id){
									$option = $this->getProductVariantOptionIDPID($option_id, $item['product_id']);
									$clause['quantity_balance'] = $item['quantity_balance'] * $option->qty_unit;
								}else{
									$clause['quantity_balance'] = $item['quantity_balance'];
								}
								$clause['product_name'] = $product->name;
								$clause['product_code'] = $product->code;
								$clause['sale_id'] 		= $item['sale_id'];
								$clause['date'] 		= $item['date']?$item['date']:date('Y-m-d');
								//echo '<pre>';print_r($clause);echo '</pre>';
								$this->db->insert('purchase_items', $clause);
							}
						} else {
							/* Add New */
							if ($item['inventory']) {
								$pr_item = $this->getPurchaseItemByID($item['purchase_item_id']);
								if($pr_item){
									$new_arr_data = array(
										'product_id' 		=> $item['product_id'],
										'product_code' 		=> $product->code,
										'product_name' 		=> $product->name,
										'net_unit_cost' 	=> $pr_item->net_unit_cost?$pr_item->net_unit_cost:$product->cost,
										'quantity' 			=> 0,
										'item_tax' 			=> 0,
										'warehouse_id' 		=> $pr_item->warehouse_id?$pr_item->warehouse_id:'',
										'subtotal' 			=> $pr_item->subtotal?$pr_item->subtotal:0,
										'date' 				=> date('Y-m-d'),
										'status' 			=> $pr_item->status ? $pr_item->status : '',
										'quantity_balance' 	=> -1 * abs($item['quantity']),
										'sales'				=> 1
									);
									//echo '<pre>';print_r($clause);echo '</pre>';
									$this->db->insert('purchase_items', $new_arr_data);
								}
							}
							
						}
                    }
					
                    $this->site->syncQuantity(NULL, NULL, NULL, $item['product_id']);
                }
            }
            return TRUE;
        }
        return FALSE;
    }
	
	public function getPurchaseItemByID($purchase_item_id){
		$q = $this->db->get_where('purchase_items', array('id' => $purchase_item_id), 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
	}
	
	public function getMakeupCostByCompanyID($customer_id){
		$this->db->select('percent, makeup_cost')
						->join('customer_groups', 'customer_groups.id = companies.customer_group_id')
						->where('companies.id', $customer_id);
		$q = $this->db->get('companies');
		if($q->num_rows() > 0){
			return $q->row();
		}
	}


    public function getProductByCode($code)
    {
        $q = $this->db->get_where('products', array('code' => $code), 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
    }
	
	public function getPaymentBySaleID($sale_id)
    {
        $q = $this->db->get_where('payments', array('sale_id' => $sale_id), 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
    }
	
	public function getPaymentByPurchaseID($purchase_id)
    {
        $q = $this->db->get_where('payments', array('purchase_id' => $purchase_id), 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
    }
	
	public function getAllBom($id)
    {
        $this->db->select('*');
        $this->db->where('id', $id);
        $q = $this->db->get('bom');
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return FALSE;
    }
	
	public function getBom_itemsTop($id)
    {
        $this->db->select('*');
        $this->db->where(array('bom_id'=> $id, 'status'=> 'deduct'));
        $q = $this->db->get('bom_items');
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return FALSE;
    }

	public function getBom_itemsBottom($id)
    {
        $this->db->select('*');
        $this->db->where(array('bom_id'=> $id, 'status'=> 'add'));
        $q = $this->db->get('bom_items');
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return FALSE;
    }
    
    public function default_biller_id() {
        $this->db->select('default_biller');
        $q = $this->db->get('settings');
        if($q->num_rows() > 0){
            $q = $q->row();
            return $q->default_biller;
        }
        return false;
    }
	
	public function suspend_room(){
		$q = $this->db->get_where('suspended');
        if ($q->num_rows() > 0) {
            return $q->result();
        }
        return FALSE;
	}
	
	public function month($month, $id){
		$start = '';
		$end   = '';
		if($month == 01){
			$date = date('Y');
			$dates = $date - 1;
			$years = $dates.'-'.$month.'-23';	
			$y = new DateTime( $years ); 
			$end  = $y->format( 'Y-m-t' );	
			$start = $dates.'-'.$month.'-01';	
		}elseif($month == '0-1'){
			$date = date('Y');
			$years = $date.'-01-23';	
			$y = new DateTime( $years ); 
			$end  = $y->format( 'Y-m-t' );	
			$start = $date.'-01-01';	
		}else{
			$date = date('Y');
			$years = $date.'-'.$month.'-23';	
			$y = new DateTime( $years ); 
			$end  = $y->format( 'Y-m-t' );	
			$start = $date.'-'.$month.'-01';	
		}
		
		$this->db->select('date')
					  ->from('purchase_items')
					  ->where('date >= "'.$start.'" and date <= "'.$end.'" and product_code = '.$id.' ')
					  ->order_by('date', 'desc')
					  ->limit(1);
		$q = $this->db->get();
		if ($q->num_rows() > 0) {
           $result = $q->row();
		   return $result->date;
        }
        return FALSE;	
	}
	
	public function months($year,$month){
		$start = '';
		$end   = '';
		if($month == 01){
			$dates = $year - 1;
			$years = $dates.'-12-23';	
			$y = new DateTime( $years ); 
			$end  = $y->format( 'Y-m-t' );	
			$start = $dates.'-12-01';	
		}else{
			$months = $month - 1;
			$years = $year.'-'.$months.'-23';	
			$y = new DateTime( $years ); 
			$end  = $y->format( 'Y-m-t' );	
			$start = $year.'-'.$months.'-01';	
		}
		$RD = '0000-00-00';
		$this->db->select('date')
					  ->from('purchase_items')
					  ->where('date >= "'.$start.'" and date <= "'.$end.'" ')
					  ->order_by('date', 'desc')
					  ->limit(1);
		$q = $this->db->get();
		if ($q->num_rows() > 0) {
            $result = $q->row();
			if($result){
				return $result->date;
			}else{
				return $RD;
			}
        }
        return FALSE;	
	}
	
	public function getCurrency(){
		$this->db->select()
				 ->from('currencies')
				 ->order_by('id', 'ASC');
		$q = $this->db->get();
		if ($q->num_rows() > 0) {
            return $q->result();
        }
        return FALSE;
	}
	
	
	/* New Function */
	public function getAllBaseUnits()
    {
        $q = $this->db->get_where("units", array('base_unit' => NULL));
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return FALSE;
    }

    public function getUnitsByBUID($base_unit)
    {
        $this->db->where('id', $base_unit)->or_where('base_unit', $base_unit);
        $q = $this->db->get("units");
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return FALSE;
    }

    public function getUnitByID($id)
    {
        $q = $this->db->get_where("units", array('id' => $id), 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
    }
	
	public function getPriceGroups()
    {
        $q = $this->db->get('price_groups');
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return FALSE;
    }

    public function getPriceGroupByID($id)
    {
        $q = $this->db->get_where('price_groups', array('id' => $id), 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
    }

    public function getProductGroupPrice($product_id, $group_id)
    {
        $q = $this->db->get_where('product_prices', array('price_group_id' => $group_id, 'product_id' => $product_id), 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
    }
	
	public function getProductPriceByProductID($product_id){
		$q = $this->db->get_where('product_prices', array('product_id' => $product_id), 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
	}
	
    public function getAllBrands()
    {
        $q = $this->db->get("brands");
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return FALSE;
    }

    public function getBrandByID($id)
    {
        $q = $this->db->get_where('brands', array('id' => $id), 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
    }
	
	public function getAllProducts()
	{
		$q = $this->db->get("products");
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return FALSE;
	}
	
	public function getUserSetting($id){
		$q = $this->db->get_where('users', array('id' => $id), 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
	}
	
	public function getTwoCurrencies(){
		$this->db->where('code', 'KHM');
		$this->db->or_where('code', 'USD');
		$this->db->order_by('id', 'desc');
		$q = $this->db->get('currencies');
		if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return FALSE;
	}
	
	public function getAllPaymentTerm() {
        $q = $this->db->get('payment_term');
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return FALSE;
    }
	
	public function getDriverByGroupId()
	{
		$this->db->select('id,name');
		$this->db->where(array('group_id' => '5', 'group_name' => 'driver'));
		$q = $this->db->get('companies');
		if($q->num_rows() > 0) {
			foreach($q->result() as $row) {
				$data[] = $row;
			}
			return $data;
		}
		return FALSE;
	}
	
}
