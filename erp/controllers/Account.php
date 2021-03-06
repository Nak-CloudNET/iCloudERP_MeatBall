<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Account extends MY_Controller
{
	function __construct()
	{
		parent::__construct();

		if (!$this->loggedIn) {
			$this->session->set_userdata('requested_page', $this->uri->uri_string());
			redirect('login');
		}
		if ($this->Customer || $this->Supplier) {
			$this->session->set_flashdata('warning', lang('access_denied'));
			redirect($_SERVER["HTTP_REFERER"]);
		}
		$this->lang->load('accounts', $this->Settings->language);
		$this->load->library('form_validation');
		$this->load->model('companies_model');
		$this->load->model('accounts_model');

		if(!$this->Owner && !$this->Admin) {
			$gp = $this->site->checkPermissions();
			$this->permission = $gp[0];
			$this->permission[] = $gp[0];
		} else {
			$this->permission[] = NULL;
		}
	}

	function index($action = NULL)
	{
		$this->erp->checkPermissions('index', true, 'accounts');

		$this->data['error'] = (validation_errors()) ? validation_errors() : $this->session->flashdata('error');
		$this->data['action'] = $action;
		$bc = array(array('link' => base_url(), 'page' => lang('home')), array('link' => '#', 'page' => lang('accounts')));
		$meta = array('page_title' => lang('accounts'), 'bc' => $bc);
		$this->page_construct('accounts/index', $meta, $this->data);
	}
	
	function settings()
	{
		$this->erp->checkPermissions();
		if($this->input->post('update_settings')){
			if($this->input->post('biller') == null){
				$biller = $this->input->post('biller_id');
			}else{
				$biller = $this->input->post('biller');
			}
			if($this->input->post('default_open_balance') == null){
				$open_balance = $this->input->post('open_balance');
			}else{
				$open_balance = $this->input->post('default_open_balance');
			}
			if($this->input->post('default_sale') == null){
				$sale = $this->input->post('sales');
			}else{
				$sale = $this->input->post('default_sale');
			}
			if($this->input->post('default_sale_discount') == null){
				$sale_discount = $this->input->post('sale_discount');
			}else{
				$sale_discount = $this->input->post('default_sale_discount');
			}
			if($this->input->post('default_sale_tax') == null){
				$sale_tax = $this->input->post('dsale_tax');
			}else{
				$sale_tax = $this->input->post('default_sale_tax');
			}
			if($this->input->post('default_receivable') == null){
				$receivable = $this->input->post('receivable');
			}else{
				$receivable = $this->input->post('default_receivable');
			}
			if($this->input->post('default_purchase') == null){
				$dpurchase = $this->input->post('dpurchase');
			}else{
				$dpurchase = $this->input->post('default_purchase');
			}
			if($this->input->post('default_purchase_discount') == null){
				$dpurchase_discount = $this->input->post('dpurchase_discount');
			}else{
				$dpurchase_discount = $this->input->post('default_purchase_discount');
			}
			if($this->input->post('default_purchase_tax') == null){
				$dpurchase_tax = $this->input->post('dpurchase_tax');
			}else{
				$dpurchase_tax = $this->input->post('default_purchase_tax');
			}
			if($this->input->post('default_payable') == null){
				$dpayable = $this->input->post('dpayable');
			}else{
				$dpayable = $this->input->post('default_payable');
			}
			if($this->input->post('default_sale_freight') == null){
				$dsale_freight = $this->input->post('dsale_freight');
			}else{
				$dsale_freight = $this->input->post('default_sale_freight');
			}
			if($this->input->post('default_purchase_freight') == null){
				$dpurchase_freight = $this->input->post('dpurchase_freight');
			}else{
				$dpurchase_freight = $this->input->post('default_purchase_freight');
			}
			if($this->input->post('default_cost') == null){
				$dcost = $this->input->post('dcost');
			}else{
				$dcost = $this->input->post('default_cost');
			}
			if($this->input->post('default_stock') == null){
				$dstock = $this->input->post('dstock');
			}else{
				$dstock = $this->input->post('default_stock');
			}
			if($this->input->post('default_stock_adjust') == null){
				$dstock_adjust = $this->input->post('dstock_adjust');
			}else{
				$dstock_adjust = $this->input->post('default_stock_adjust');
			}
			if($this->input->post('default_payroll') == null){
				$dpayroll = $this->input->post('dpayroll');
			}else{
				$dpayroll = $this->input->post('default_payroll');
			}
			if($this->input->post('default_cash') == null){
				$dcash = $this->input->post('dcash');
			}else{
				$dcash = $this->input->post('default_cash');
			}
			if($this->input->post('default_credit_card') == null){
				$dcredit_card = $this->input->post('dcredit_card');
			}else{
				$dcredit_card = $this->input->post('default_credit_card');
			}
			if($this->input->post('default_gift_card') == null){
				$dgift_card = $this->input->post('dgift_card');
			}else{
				$dgift_card = $this->input->post('default_gift_card');
			}
			if($this->input->post('default_sale_deposit') == null){
				$dsale_deposit = $this->input->post('dsale_deposit');
			}else{
				$dsale_deposit = $this->input->post('default_sale_deposit');
			}
			if($this->input->post('default_purchase_deposit') == null){
				$dpurchase_deposit = $this->input->post('dpurchase_deposit');
			}else{
				$dpurchase_deposit = $this->input->post('default_purchase_deposit');
			}
			if($this->input->post('default_cheque') == null){
				$dcheque = $this->input->post('dcheque');
			}else{
				$dcheque = $this->input->post('default_cheque');
			}
			if($this->input->post('default_loan') == null){
				$dloan = $this->input->post('dloan');
			}else{
				$dloan = $this->input->post('default_loan');
			}
			if($this->input->post('default_retained_earnings') == null){
				$dretained_earning = $this->input->post('dretained_earning');
			}else{
				$dretained_earning = $this->input->post('default_retained_earnings');
			}
			$data = array(
				'biller_id'            => $biller,
				'default_open_balance' => $open_balance,
				'default_sale'         => $sale, 
				'default_sale_discount'=> $sale_discount,
				'default_sale_tax'     => $sale_tax,
				'default_receivable'   => $receivable, 
				'default_purchase'     => $dpurchase,
				'default_purchase_discount' => $dpurchase_discount, 
				'default_purchase_tax' => $dpurchase_tax, 
				'default_payable'      => $dpayable,
				'default_sale_freight'      => $dsale_freight,
				'default_purchase_freight'  => $dpurchase_freight,
				'default_cost'         => $dcost, 
				'default_stock' 	   => $dstock,
				'default_stock_adjust' => $dstock_adjust, 
				'default_payroll'      => $dpayroll,
				'default_cash'         => $dcash,
				'default_credit_card'  => $dcredit_card,
				'default_gift_card'    => $dgift_card,
				'default_sale_deposit' => $dsale_deposit,
				'default_purchase_deposit' => $dpurchase_deposit,
				'default_cheque'       => $dcheque,
				'default_loan'         => $dloan,
				'default_retained_earnings'	=> $dretained_earning
				);
			//echo '<pre>';print_r($data);echo '</pre>';exit;
			$this->accounts_model->updateSetting($data);
		}
		$this->data['default'] = $this->companies_model->getDefaults();
		$this->data['get_biller'] = $this->accounts_model->getCustomers();
		$this->data['get_biller_name'] = $this->accounts_model->getBillers();
		$this->data['chart_accounts'] = $this->accounts_model->getAllChartAccounts();
		$this->data['sale_name'] = $this->accounts_model->getSalename();
		$this->data['sale_discount'] = $this->accounts_model->getsalediscount();
		$this->data['sale_tax'] = $this->accounts_model->getsale_tax();
		$this->data['receivable'] = $this->accounts_model->getreceivable();
		$this->data['purchases'] = $this->accounts_model->getpurchases();
		$this->data['purchase_tax'] = $this->accounts_model->getpurchase_tax();
		$this->data['purchasediscount'] = $this->accounts_model->getpurchasediscount();
		$this->data['payable'] = $this->accounts_model->getpayable();
		$this->data['get_sale_freight'] = $this->accounts_model->get_sale_freights();
		$this->data['get_purchase_freight'] = $this->accounts_model->get_purchase_freights();
		$this->data['getstock'] = $this->accounts_model->getstocks();
		$this->data['stock_adjust'] = $this->accounts_model->getstock_adjust();
		$this->data['getcost'] = $this->accounts_model->get_cost();
		$this->data['getpayroll'] = $this->accounts_model->getpayrolls();
		$this->data['get_cashs'] = $this->accounts_model->get_cash();
		$this->data['credit_card'] = $this->accounts_model->getcredit_card();
		$this->data['sale_deposit'] = $this->accounts_model->get_sale_deposit();
		$this->data['purchased_eposit'] = $this->accounts_model->get_purchase_deposit();
		$this->data['gift_card'] = $this->accounts_model->getgift_card();
		$this->data['cheque'] = $this->accounts_model->getcheque();
		$this->data['loan'] = $this->accounts_model->get_loan();
		$this->data['retained_earning'] = $this->accounts_model->get_retained_earning();
		$this->data['error'] = (validation_errors()) ? validation_errors() : $this->session->flashdata('error');
        //$this->data['action'] = $action;
		$bc = array(array('link' => base_url(), 'page' => lang('home')), array('link' => '#', 'page' => lang('accounts')));
		$meta = array('page_title' => lang('acount_settings'), 'bc' => $bc);
		$this->page_construct('accounts/settings', $meta, $this->data);
	}
	
	function list_ac_recevable($warehouse_id = NULL, $datetime = NULL)
	{
		$this->erp->checkPermissions('index', true, 'accounts');
		$this->load->model('reports_model');

		if(isset($_GET['d']) != ""){
			$date = $_GET['d'];
		}else{
			$date = NULL;
		}

		$search_id = NULL;
		if($this->input->get('id')){
			$search_id = $this->input->get('id');
		}

		$this->data['users'] = $this->reports_model->getStaff();
		$this->data['warehouses'] = $this->site->getAllWarehouses();
		$this->data['billers'] = $this->site->getAllCompanies('biller');
		
		$this->data['error'] = (validation_errors()) ? validation_errors() : $this->session->flashdata('error');
		if ($this->Owner || $this->Admin) {
			$this->data['warehouses'] = $this->site->getAllWarehouses();
			$this->data['warehouse_id'] = $warehouse_id;
			$this->data['warehouse'] = $warehouse_id ? $this->site->getWarehouseByID($warehouse_id) : NULL;
		} else {
			$this->data['warehouses'] = NULL;
			$this->data['warehouse_id'] = $this->session->userdata('warehouse_id');
			$this->data['warehouse'] = $this->session->userdata('warehouse_id') ? $this->site->getWarehouseByID($this->session->userdata('warehouse_id')) : NULL;
		}
		$this->data['dt'] = $datetime;
		$this->data['date'] = $date;
		
		$this->data['search_id'] = $search_id;

		$bc = array(array('link' => base_url(), 'page' => lang('home')), array('link' => '#', 'page' => lang('accounts')));
		$meta = array('page_title' => lang('sales'), 'bc' => $bc);
		$this->page_construct('accounts/acc_receivable', $meta, $this->data);
	}
	function list_ar_aging() {
		$this->data['user_id'] = $user_id;
		$bc = array(array('link' => base_url(), 'page' => lang('home')), array('link' => site_url('reports'), 'page' => lang('accounts')), array('link' => '#', 'page' => lang('list_ar_aging')));
		$meta = array('page_title' => lang('list_ar_aging'), 'bc' => $bc);
		$this->page_construct('accounts/list_ar_aging', $meta, $this->data);
	}

	function getSales_pending($warehouse_id = NULL, $date = NULL)
	{
		$this->erp->checkPermissions('index');
		
		if ($this->input->get('user')) {
			$user_query = $this->input->get('user');
		} else {
			$user_query = NULL;
		}
		if ($this->input->get('reference_no')) {
			$reference_no = $this->input->get('reference_no');
		} else {
			$reference_no = NULL;
		}
		if ($this->input->get('customer')) {
			$customer = $this->input->get('customer');
		} else {
			$customer = NULL;
		}
		if ($this->input->get('biller')) {
			$biller = $this->input->get('biller');
		} else {
			$biller = NULL;
		}
		if ($this->input->get('warehouse')) {
			$warehouse = $this->input->get('warehouse');
		} else {
			$warehouse = NULL;
		}
		if ($this->input->get('start_date')) {
			$start_date = $this->input->get('start_date');
		} else {
			$start_date = NULL;
		}
		if ($this->input->get('end_date')) {
			$end_date = $this->input->get('end_date');
		} else {
			$end_date = NULL;
		}
		if ($start_date) {
			$start_date = $this->erp->fld($start_date);
			$end_date = $this->erp->fld($end_date);
		}

		if ((! $this->Owner || ! $this->Admin) && ! $warehouse_id) {
			$user = $this->site->getUser();
			$warehouse_id = $user->warehouse_id;
		}

		$this->load->library('datatables');
		if ($warehouse_id) {
			$this->datatables
			->select("id, customer,
				SUM(
					IFNULL(grand_total, 0)
				) as grand_total, 
				SUM(
					IFNULL(paid, 0) 
				) as paid, 
				SUM(
					IFNULL(grand_total-paid, 0)
				) as balance,
				COUNT(
					id
				) as ar_number
				")
			->from('sales')
			->where('payment_status !=', 'paid')
			->where('payment_status !=', 'Returned')
			->where('DATE_SUB('. $this->db->dbprefix('sales')  .'.date, INTERVAL 1 DAY) <= CURDATE()')
			->where('warehouse_id', $warehouse_id)
			->group_by('customer');
		} else {
			$this->datatables
			->select("id, customer, 
				SUM(
					IFNULL(grand_total, 0)
				) as grand_total, 
				SUM(
					IFNULL(paid, 0)
				) as paid, 
				SUM(
					IFNULL(grand_total-paid, 0)
				) as balance,
				COUNT(
					id
				) as ar_number
				")
			->from('sales')
			->where('payment_status !=', 'Returned')
			->where('payment_status !=', 'paid')
			->where('DATE_SUB('. $this->db->dbprefix('sales')  .'.date, INTERVAL 1 DAY) <= CURDATE()')
			->where('(grand_total-paid) <> ', 0);
			if(isset($_REQUEST['d'])){
				$date = $_GET['d'];
				$date1 = str_replace("/", "-", $date);
				$date =  date('Y-m-d', strtotime($date1));

				$this->datatables
				->where("date >=", $date)
				->where('sales.payment_term <>', 0);
			}
			$this->datatables->group_by('customer');
		}
			//$this->datatables->where('pos !=', 1);
		if ($this->permission['sales-index'] = ''){
			if (!$this->Customer && !$this->Supplier && !$this->Owner && !$this->Admin) {
				$this->datatables->where('created_by', $this->session->userdata('user_id'));
			} elseif ($this->Customer) {
				$this->datatables->where('customer_id', $this->session->userdata('user_id'));
			}
		}

		if ($user_query) {
			$this->datatables->where('sales.created_by', $user_query);
		}/*
		if ($customer) {
			$this->datatables->where('sales.id', $customer);
		}*/
		if ($reference_no) {
			$this->datatables->where('sales.reference_no', $reference_no);
		}
		if ($biller) {
			$this->datatables->where('sales.biller_id', $biller);
		}
		if ($customer) {
			$this->datatables->where('sales.customer_id', $customer);
		}
		if ($warehouse) {
			$this->datatables->where('sales.warehouse_id', $warehouse);
		}

		if ($start_date) {
			$this->datatables->where($this->db->dbprefix('sales').'.date BETWEEN "' . $start_date . '" and "' . $end_date . '"');
		}
		
		$this->datatables->add_column("Actions", "<div class=\"text-center\"><a class=\"tip\" title='" . $this->lang->line("'list_ac_recevable'") . "' href='" . site_url('account/list_ac_recevable') . "'><span class=\"label label-primary\">View</span></a></div>");
		echo $this->datatables->generate();
	}
	function list_ar_aging_0_30() {
		$this->erp->checkPermissions('index');
		
		if ($this->input->get('user')) {
			$user_query = $this->input->get('user');
		} else {
			$user_query = NULL;
		}
		if ($this->input->get('reference_no')) {
			$reference_no = $this->input->get('reference_no');
		} else {
			$reference_no = NULL;
		}
		if ($this->input->get('customer')) {
			$customer = $this->input->get('customer');
		} else {
			$customer = NULL;
		}
		if ($this->input->get('biller')) {
			$biller = $this->input->get('biller');
		} else {
			$biller = NULL;
		}
		if ($this->input->get('warehouse')) {
			$warehouse = $this->input->get('warehouse');
		} else {
			$warehouse = NULL;
		}
		if ($this->input->get('start_date')) {
			$start_date = $this->input->get('start_date');
		} else {
			$start_date = NULL;
		}
		if ($this->input->get('end_date')) {
			$end_date = $this->input->get('end_date');
		} else {
			$end_date = NULL;
		}
		if ($start_date) {
			$start_date = $this->erp->fld($start_date);
			$end_date = $this->erp->fld($end_date);
		}

		if ((! $this->Owner || ! $this->Admin) && ! $warehouse_id) {
			$user = $this->site->getUser();
			$warehouse_id = $user->warehouse_id;
		}

	$this->load->library('datatables');
	if ($warehouse_id) {
		$this->datatables
		->select("id, customer,
			SUM(
				IFNULL(grand_total, 0)
			) as grand_total, 
			SUM(
				IFNULL(paid, 0)
			) as paid, 
			SUM(
				IFNULL(grand_total-paid, 0)
			) as balance,
			COUNT(
				id
			) as ar_number
			")
		->from('sales')
		->where('payment_status !=', 'paid')
		->where('payment_status !=', 'Returned')
		->where('warehouse_id', $warehouse_id)
		->where('date('. $this->db->dbprefix('sales') .'.date) > CURDATE() AND date('. $this->db->dbprefix('sales') .'.date) <= DATE_ADD(now(), INTERVAL + 30 DAY)')
		->group_by('customer');
	} else {
		$this->datatables
		->select("id, customer, 
			SUM(
				IFNULL(grand_total, 0)
			) as grand_total, 
			SUM(
				IFNULL(paid, 0)
			) as paid, 
			SUM(
				IFNULL(grand_total-paid, 0)
			) as balance,
			COUNT(
				id
			) as ar_number
			")
		->from('sales')
		->where('payment_status !=', 'Returned')
		->where('payment_status !=', 'paid')
		->where('date('. $this->db->dbprefix('sales') .'.date) > CURDATE() AND date('. $this->db->dbprefix('sales') .'.date) <= DATE_ADD(now(), INTERVAL + 30 DAY)')
		->where('(grand_total-paid) <> ', 0);
		if(isset($_REQUEST['d'])){
			$date = $_GET['d'];
			$date1 = str_replace("/", "-", $date);
			$date =  date('Y-m-d', strtotime($date1));

			$this->datatables
			->where("date >=", $date)
			->where('sales.payment_term <>', 0);
		}
		$this->datatables->group_by('customer');
	}

	if ($this->permission['sales-index'] = ''){
		if (!$this->Customer && !$this->Supplier && !$this->Owner && !$this->Admin) {
			$this->datatables->where('created_by', $this->session->userdata('user_id'));
		} elseif ($this->Customer) {
			$this->datatables->where('customer_id', $this->session->userdata('user_id'));
		}
	}

	if ($user_query) {
		$this->datatables->where('sales.created_by', $user_query);
	}

	if ($reference_no) {
		$this->datatables->where('sales.reference_no', $reference_no);
	}
	if ($biller) {
		$this->datatables->where('sales.biller_id', $biller);
	}
	if ($customer) {
		$this->datatables->where('sales.customer_id', $customer);
	}
	if ($warehouse) {
		$this->datatables->where('sales.warehouse_id', $warehouse);
	}

	if ($start_date) {
		$this->datatables->where($this->db->dbprefix('sales').'.date BETWEEN "' . $start_date . '" and "' . $end_date . '"');
	}

	$this->datatables->add_column("Actions", "<div class=\"text-center\"><a class=\"tip\" title='" . $this->lang->line("'list_ac_recevable'") . "' href='" . site_url('account/list_ac_recevable/0/30') . "'><span class=\"label label-primary\">View</span></a></div>");
	echo $this->datatables->generate();
}

function list_ar_aging_30_60() {
	$this->erp->checkPermissions('index');

	if ($this->input->get('user')) {
		$user_query = $this->input->get('user');
	} else {
		$user_query = NULL;
	}
	if ($this->input->get('reference_no')) {
		$reference_no = $this->input->get('reference_no');
	} else {
		$reference_no = NULL;
	}
	if ($this->input->get('customer')) {
		$customer = $this->input->get('customer');
	} else {
		$customer = NULL;
	}
	if ($this->input->get('biller')) {
		$biller = $this->input->get('biller');
	} else {
		$biller = NULL;
	}
	if ($this->input->get('warehouse')) {
		$warehouse = $this->input->get('warehouse');
	} else {
		$warehouse = NULL;
	}
	if ($this->input->get('start_date')) {
		$start_date = $this->input->get('start_date');
	} else {
		$start_date = NULL;
	}
	if ($this->input->get('end_date')) {
		$end_date = $this->input->get('end_date');
	} else {
		$end_date = NULL;
	}
	if ($start_date) {
		$start_date = $this->erp->fld($start_date);
		$end_date = $this->erp->fld($end_date);
	}

	if ((! $this->Owner || ! $this->Admin) && ! $warehouse_id) {
		$user = $this->site->getUser();
		$warehouse_id = $user->warehouse_id;
	}
	$this->load->library('datatables');
	if ($warehouse_id) {
		$this->datatables
		->select("id, customer, 
			SUM(
				IFNULL(grand_total, 0)
			) as grand_total, 
			SUM(
				IFNULL(paid, 0)
			) as paid, 
			SUM(
				IFNULL(grand_total-paid, 0) + IFNULL(grand_total-paid, 0)
			) as balance
			COUNT(
				id 
			) as ar_number
			")
		->from('sales')
		->where('payment_status !=', 'paid')
		->where('payment_status !=', 'Returned')
		->where('date('. $this->db->dbprefix('sales') .'.date) > DATE_ADD(now(), INTERVAL + 30 DAY) AND date('. $this->db->dbprefix('sales') .'.date) <= DATE_ADD(now(), INTERVAL + 60 DAY)')
		->where('warehouse_id', $warehouse_id)
		->group_by('customer');
	} else {
		$this->datatables
		->select("id, customer, 
			SUM(
				IFNULL(grand_total, 0)
			) as grand_total, 
			SUM(
				IFNULL(paid, 0)
			) as paid, 
			SUM(
				IFNULL(grand_total-paid, 0)
			) as balance,
			COUNT(
				id 
			) as ar_number
			")
		->from('sales')
		->where('payment_status !=', 'Returned')
		->where('payment_status !=', 'paid')
		->where('date('. $this->db->dbprefix('sales') .'.date) > DATE_ADD(now(), INTERVAL + 30 DAY) AND date('. $this->db->dbprefix('sales') .'.date) <= DATE_ADD(now(), INTERVAL + 60 DAY)')
		->where('(grand_total-paid) <> ', 0);
		if(isset($_REQUEST['d'])){
			$date = $_GET['d'];
			$date1 = str_replace("/", "-", $date);
			$date =  date('Y-m-d', strtotime($date1));
			$this->datatables
			->where("date >=", $date)
			->where($this->db->dbprefix('sales') . '.payment_term <>', 0);
		}
		$this->datatables->group_by('customer');

	}

			//$this->datatables->where('pos !=', 1);
	if ($this->permission['sales-index'] = ''){
		if (!$this->Customer && !$this->Supplier && !$this->Owner && !$this->Admin) {
			$this->datatables->where('created_by', $this->session->userdata('user_id'));
		} elseif ($this->Customer) {
			$this->datatables->where('customer_id', $this->session->userdata('user_id'));
		}
	}

	if ($user_query) {
		$this->datatables->where('sales.created_by', $user_query);
	}

	if ($reference_no) {
		$this->datatables->where('sales.reference_no', $reference_no);
	}
	if ($biller) {
		$this->datatables->where('sales.biller_id', $biller);
	}
	if ($customer) {
		$this->datatables->where('sales.customer_id', $customer);
	}
	if ($warehouse) {
		$this->datatables->where('sales.warehouse_id', $warehouse);
	}

	if ($start_date) {
		$this->datatables->where($this->db->dbprefix('sales').'.date BETWEEN "' . $start_date . '" and "' . $end_date . '"');
	}

	$this->datatables->add_column("Actions", "<div class=\"text-center\"><a class=\"tip\" title='" . $this->lang->line("'list_ac_recevable'") . "' href='" . site_url('account/list_ac_recevable/0/60') . "'><span class=\"label label-primary\">View</span></a></div>");
	echo $this->datatables->generate();
}

function list_ar_aging_60_90() {
	$this->erp->checkPermissions('index');

	if ($this->input->get('user')) {
		$user_query = $this->input->get('user');
	} else {
		$user_query = NULL;
	}
	if ($this->input->get('reference_no')) {
		$reference_no = $this->input->get('reference_no');
	} else {
		$reference_no = NULL;
	}
	if ($this->input->get('customer')) {
		$customer = $this->input->get('customer');
	} else {
		$customer = NULL;
	}
	if ($this->input->get('biller')) {
		$biller = $this->input->get('biller');
	} else {
		$biller = NULL;
	}
	if ($this->input->get('warehouse')) {
		$warehouse = $this->input->get('warehouse');
	} else {
		$warehouse = NULL;
	}
	if ($this->input->get('start_date')) {
		$start_date = $this->input->get('start_date');
	} else {
		$start_date = NULL;
	}
	if ($this->input->get('end_date')) {
		$end_date = $this->input->get('end_date');
	} else {
		$end_date = NULL;
	}
	if ($start_date) {
		$start_date = $this->erp->fld($start_date);
		$end_date = $this->erp->fld($end_date);
	}

	if ((! $this->Owner || ! $this->Admin) && ! $warehouse_id) {
		$user = $this->site->getUser();
		$warehouse_id = $user->warehouse_id;
	}
	

	$this->load->library('datatables');
	if ($warehouse_id) {
		$this->datatables
		->select("id, customer, 
			SUM(IFNULL(grand_total, 0) + IFNULL(grand_total, 0)) as grand_total, 
			SUM(IFNULL(paid, 0) + IFNULL(paid, 0)) as paid, 
			SUM(IFNULL(grand_total-paid, 0) + IFNULL(grand_total-paid, 0)) as balance")
		->from('sales')
		->where('payment_status !=', 'paid')
		->where('payment_status !=', 'Returned')
		->where('date('. $this->db->dbprefix('sales') .'.date) > DATE_ADD(now(), INTERVAL + 60 DAY) AND date('. $this->db->dbprefix('sales') .'.date) <= DATE_ADD(now(), INTERVAL + 90 DAY)')
		->where('warehouse_id', $warehouse_id)
		->group_by('customer');
	} else {
		$this->datatables
		->select("id, customer, 
			SUM(
				IFNULL(grand_total, 0)
			) as grand_total, 
			SUM(
				IFNULL(paid, 0)
			) as paid, 
			SUM(
				IFNULL(grand_total-paid, 0)
			) as balance,
			COUNT(
				id
			) as ar_number
			")
		->from('sales')
		->where('payment_status !=', 'Returned')
		->where('payment_status !=', 'paid')
		->where('date('. $this->db->dbprefix('sales') .'.date) > DATE_ADD(now(), INTERVAL + 60 DAY) AND date('. $this->db->dbprefix('sales') .'.date) <= DATE_ADD(now(), INTERVAL + 90 DAY)')
		->where('(grand_total-paid) <> ', 0);
		if(isset($_REQUEST['d'])){
			$date = $_GET['d'];
			$date1 = str_replace("/", "-", $date);
			$date =  date('Y-m-d', strtotime($date1));

			$this->datatables
			->where("date >=", $date)
			->where('sales.payment_term <>', 0);
		}

		$this->datatables->group_by('customer');
	}

			//$this->datatables->where('pos !=', 1);
	if ($this->permission['sales-index'] = ''){
		if (!$this->Customer && !$this->Supplier && !$this->Owner && !$this->Admin) {
			$this->datatables->where('created_by', $this->session->userdata('user_id'));
		} elseif ($this->Customer) {
			$this->datatables->where('customer_id', $this->session->userdata('user_id'));
		}
	}

	if ($user_query) {
		$this->datatables->where('sales.created_by', $user_query);
	}
	if ($customer) {
		$this->datatables->where('sales.id', $customer);
	}
	if ($reference_no) {
		$this->datatables->where('sales.reference_no', $reference_no);
	}
	if ($biller) {
		$this->datatables->where('sales.biller_id', $biller);
	}
	if ($customer) {
		$this->datatables->where('sales.customer_id', $customer);
	}
	if ($warehouse) {
		$this->datatables->where('sales.warehouse_id', $warehouse);
	}

	if ($start_date) {
		$this->datatables->where($this->db->dbprefix('sales').'.date BETWEEN "' . $start_date . '" and "' . $end_date . '"');
	}

	$this->datatables->add_column("Actions", "<div class=\"text-center\"><a class=\"tip\" title='" . $this->lang->line("'list_ac_recevable'") . "' href='" . site_url('account/list_ac_recevable/0/90') . "'><span class=\"label label-primary\">View</span></a></div>");
	echo $this->datatables->generate();
}

function list_ar_aging_over_90() {
	$this->erp->checkPermissions('index');

	if ($this->input->get('user')) {
		$user_query = $this->input->get('user');
	} else {
		$user_query = NULL;
	}
	if ($this->input->get('reference_no')) {
		$reference_no = $this->input->get('reference_no');
	} else {
		$reference_no = NULL;
	}
	if ($this->input->get('customer')) {
		$customer = $this->input->get('customer');
	} else {
		$customer = NULL;
	}
	if ($this->input->get('biller')) {
		$biller = $this->input->get('biller');
	} else {
		$biller = NULL;
	}
	if ($this->input->get('warehouse')) {
		$warehouse = $this->input->get('warehouse');
	} else {
		$warehouse = NULL;
	}
	if ($this->input->get('start_date')) {
		$start_date = $this->input->get('start_date');
	} else {
		$start_date = NULL;
	}
	if ($this->input->get('end_date')) {
		$end_date = $this->input->get('end_date');
	} else {
		$end_date = NULL;
	}
	if ($start_date) {
		$start_date = $this->erp->fld($start_date);
		$end_date = $this->erp->fld($end_date);
	}

	if ((! $this->Owner || ! $this->Admin) && ! $warehouse_id) {
		$user = $this->site->getUser();
		$warehouse_id = $user->warehouse_id;
	}

	$this->load->library('datatables');
	if ($warehouse_id) {
		$this->datatables
		->select("id, customer, 
			SUM(
				IFNULL(grand_total, 0)
			) as grand_total, 
			SUM(
				IFNULL(paid, 0)
			) as paid, 
			SUM(
				IFNULL(grand_total-paid, 0)
			) as balance,
			COUNT(
				id
			) as ar_number
			")
		->from('sales')
		->where('payment_status !=', 'paid')
		->where('payment_status !=', 'Returned')
		->where('date('. $this->db->dbprefix('sales') .'.date) >= DATE_ADD(now(), INTERVAL + 90 DAY)')
		->where('warehouse_id', $warehouse_id)
		->group_by('customer');
	} else {
		$this->datatables
		->select("id, customer, 
			SUM(
				IFNULL(grand_total, 0)
			) as grand_total, 
			SUM(
				IFNULL(paid, 0)
			) as paid, 
			SUM(
				IFNULL(grand_total-paid, 0)
			) as balance,
			COUNT(
				id
			) as ar_number
			")
		->from('sales')
		->where('payment_status !=', 'Returned')
		->where('payment_status !=', 'paid')
		->where('(grand_total-paid) <> ', 0)
		->where('date('. $this->db->dbprefix('sales') .'.date) >= DATE_ADD(now(), INTERVAL + 90 DAY)');
		if(isset($_REQUEST['d'])){
			$date = $_GET['d'];
			$date1 = str_replace("/", "-", $date);
			$date =  date('Y-m-d', strtotime($date1));

			$this->datatables
			->where("date >=", $date)
			->where('sales.payment_term <>', 0);
		}
		$this->datatables->group_by('customer');
	}

	//$this->datatables->where('pos !=', 1);
	if ($this->permission['sales-index'] = ''){
		if (!$this->Customer && !$this->Supplier && !$this->Owner && !$this->Admin) {
			$this->datatables->where('created_by', $this->session->userdata('user_id'));
		} elseif ($this->Customer) {
			$this->datatables->where('customer_id', $this->session->userdata('user_id'));
		}
	}

	if ($user_query) {
		$this->datatables->where('sales.created_by', $user_query);
	}
	if ($customer) {
		$this->datatables->where('sales.id', $customer);
	}
	if ($reference_no) {
		$this->datatables->where('sales.reference_no', $reference_no);
	}
	if ($biller) {
		$this->datatables->where('sales.biller_id', $biller);
	}
	if ($customer) {
		$this->datatables->where('sales.customer_id', $customer);
	}
	if ($warehouse) {
		$this->datatables->where('sales.warehouse_id', $warehouse);
	}

	if ($start_date) {
		$this->datatables->where($this->db->dbprefix('sales').'.date BETWEEN "' . $start_date . '" and "' . $end_date . '"');
	}

	$this->datatables->add_column("Actions", "<div class=\"text-center\"><a class=\"tip\" title='" . $this->lang->line("'list_ac_recevable'") . "' href='" . site_url('account/list_ac_recevable/0/91') . "'><span class=\"label label-primary\">View</span></a></div>");
	echo $this->datatables->generate();
}

function list_ac_payable($warehouse_id = null, $rows = NULL, $dt = NULL)
{
	$search_id = NULL;
	if($this->input->get('id')){
		$search_id = $this->input->get('id');
	}

	$this->erp->checkPermissions('index', true, 'accounts');
	$this->load->model('reports_model');

	if(isset($_GET['d']) != ""){
		$date = $_GET['d'];
	}else{
		$date = NULL;
	}

	$this->data['users'] = $this->reports_model->getStaff();
	$this->data['error'] = (validation_errors()) ? validation_errors() : $this->session->flashdata('error');
	if ($this->Owner || $this->Admin || !$this->session->userdata('warehouse_id')) {
		$this->data['warehouses'] = $this->site->getAllWarehouses();
		$this->data['warehouse_id'] = $warehouse_id;
		$this->data['warehouse'] = $warehouse_id ? $this->site->getWarehouseByID($warehouse_id) : null;
	} else {
		$this->data['warehouses'] = null;
		$this->data['warehouse_id'] = $this->session->userdata('warehouse_id');
		$this->data['warehouse'] = $this->session->userdata('warehouse_id') ? $this->site->getWarehouseByID($this->session->userdata('warehouse_id')) : null;
	}

	$this->data['dt'] = $dt;
	$this->data['date'] = $date;
	$this->data['search_id'] = $search_id;

	$bc = array(array('link' => base_url(), 'page' => lang('home')), array('link' => '#', 'page' => lang('accounts')));
	$meta = array('page_title' => lang('list_ac_payable'), 'bc' => $bc);
	$this->page_construct('accounts/acc_payable', $meta, $this->data);
}

function getChartAccount()
{
	$this->erp->checkPermissions('index', true, 'accounts');

	$this->load->library('datatables');
	$this->datatables
	->select("(erp_gl_charts.accountcode) as id,erp_gl_charts.accountcode, erp_gl_charts.accountname, erp_gl_charts.parent_acc, erp_gl_sections.sectionname")
	->from("erp_gl_charts")
	->join("erp_gl_sections","erp_gl_charts.sectionid=erp_gl_sections.sectionid","INNER")
	->add_column("Actions", "<center><a class=\"tip\" title='" . $this->lang->line("edit_account") . "' href='" . site_url('account/edit/$1') . "' data-toggle='modal' data-target='#myModal'><i class=\"fa fa-edit\"></i></a>  <a href='#' class='tip po' title='<b>" . $this->lang->line("delete_account") . "</b>' data-content=\"<p>" . lang('r_u_sure') . "</p><a class='btn btn-danger po-delete' href='" . site_url('account/delete/$1') . "'>" . lang('i_m_sure') . "</a> <button class='btn po-close'>" . lang('no') . "</button>\"  rel='popover'><i class=\"fa fa-trash-o\"></i></a></center>", "erp_gl_charts.accountcode");
        //->unset_column('id');
	echo $this->datatables->generate();
}

function billReceipt()
{
	$this->erp->checkPermissions('index', true, 'accounts');
	$this->load->model('reports_model');
	$this->data['error'] = (validation_errors()) ? validation_errors() : $this->session->flashdata('error');
	$this->data['users'] = $this->reports_model->getStaff();
	$this->data['billers'] = $this->site->getAllCompanies('biller');
	$bc = array(array('link' => base_url(), 'page' => lang('home')), array('link' => site_url('accounts'), 'page' => lang('accounts')), array('link' => '#', 'page' => lang('Bill Receipt')));
	$meta = array('page_title' => lang('Account'), 'bc' => $bc);
	$this->page_construct('accounts/bill_reciept', $meta, $this->data);
}


function getBillReciept($pdf = NULL, $xls = NULL)
{
	$this->erp->checkPermissions('payments', TRUE);
	if ($this->input->get('user')) {
		$user = $this->input->get('user');
	} else {
		$user = NULL;
	}
	if ($this->input->get('supplier')) {
		$supplier = $this->input->get('supplier');
	} else {
		$supplier = NULL;
	}
	if ($this->input->get('customer')) {
		$customer = $this->input->get('customer');
	} else {
		$customer = NULL;
	}
	if ($this->input->get('biller')) {
		$biller = $this->input->get('biller');
	} else {
		$biller = NULL;
	}
	if ($this->input->get('payment_ref')) {
		$payment_ref = $this->input->get('payment_ref');
	} else {
		$payment_ref = NULL;
	}
	if ($this->input->get('sale_ref')) {
		$sale_ref = $this->input->get('sale_ref');
	} else {
		$sale_ref = NULL;
	}
	if ($this->input->get('purchase_ref')) {
		$purchase_ref = $this->input->get('purchase_ref');
	} else {
		$purchase_ref = NULL;
	}
	if ($this->input->get('start_date')) {
		$start_date = $this->input->get('start_date');
	} else {
		$start_date = NULL;
	}
	if ($this->input->get('end_date')) {
		$end_date = $this->input->get('end_date');
	} else {
		$end_date = NULL;
	}
	if ($start_date) {
		$start_date = $this->erp->fsd($start_date);
		$end_date = $this->erp->fsd($end_date);
	}
	if (!$this->Owner && !$this->Admin) {
		$user = $this->session->userdata('user_id');
	}
	if ($pdf || $xls) {

		$this->db
		->select("" . $this->db->dbprefix('payments') . ".date, 
			" . $this->db->dbprefix('payments') . ".reference_no as payment_ref, 
			" . $this->db->dbprefix('sales') . ".reference_no as sale_ref,customer,paid_by, amount, type")
		->from('payments')
		->join('sales', 'payments.sale_id=sales.id', 'left')
		->join('purchases', 'payments.purchase_id=purchases.id', 'left')
		->group_by('payments.id')
		->order_by('payments.date asc');
		$this->db->where('payments.type != "sent"');
			//	$this->db->where('sales.customer !=""');

		if ($user) {
			$this->db->where('payments.created_by', $user);
		}
		if ($customer) {
			$this->db->where('sales.customer_id', $customer);
		}
		if ($supplier) {
			$this->db->where('purchases.supplier_id', $supplier);
		}
		if ($biller) {
			$this->db->where('sales.biller_id', $biller);
		}
		if ($customer) {
			$this->db->where('sales.customer_id', $customer);
		}
		if ($payment_ref) {
			$this->db->like('payments.reference_no', $payment_ref, 'both');
		}
		if ($sale_ref) {
			$this->db->like('sales.reference_no', $sale_ref, 'both');
		}
		if ($purchase_ref) {
			$this->db->like('purchases.reference_no', $purchase_ref, 'both');
		}
		if ($start_date) {
			$this->db->where($this->db->dbprefix('payments').'.date BETWEEN "' . $start_date . '" and "' . $end_date . '"');
		}

		$q = $this->db->get();
		if ($q->num_rows() > 0) {
			foreach (($q->result()) as $row) {
				$data[] = $row;
			}
		} else {
			$data = NULL;
		}

		if (!empty($data)) {

			$this->load->library('excel');
			$this->excel->setActiveSheetIndex(0);
			$this->excel->getActiveSheet()->setTitle(lang('payments_report'));
			$this->excel->getActiveSheet()->SetCellValue('A1', lang('date'));
			$this->excel->getActiveSheet()->SetCellValue('B1', lang('payment_reference'));
			$this->excel->getActiveSheet()->SetCellValue('C1', lang('sale_reference'));
			$this->excel->getActiveSheet()->SetCellValue('D1', lang('customer'));
			$this->excel->getActiveSheet()->SetCellValue('E1', lang('paid_by'));
			$this->excel->getActiveSheet()->SetCellValue('F1', lang('amount'));
			$this->excel->getActiveSheet()->SetCellValue('G1', lang('type'));

			$row = 2;
			$total = 0;
			foreach ($data as $data_row) {
				$this->excel->getActiveSheet()->SetCellValue('A' . $row, $this->erp->hrld($data_row->date));
				$this->excel->getActiveSheet()->SetCellValue('B' . $row, $data_row->payment_ref);
				$this->excel->getActiveSheet()->SetCellValue('C' . $row, $data_row->sale_ref);
				$this->excel->getActiveSheet()->SetCellValue('D' . $row, $data_row->customer);
				$this->excel->getActiveSheet()->SetCellValue('E' . $row, lang($data_row->paid_by));
				$this->excel->getActiveSheet()->SetCellValue('F' . $row, $data_row->amount);
				$this->excel->getActiveSheet()->SetCellValue('G' . $row, $data_row->type);
				if ($data_row->type == 'returned' || $data_row->type == 'sent') {
					$total -= $data_row->amount;
				} else {
					$total += $data_row->amount;
				}
				$row++;
			}
			$this->excel->getActiveSheet()->getStyle("F" . $row)->getBorders()
			->getTop()->setBorderStyle(PHPExcel_Style_Border::BORDER_MEDIUM);
			$this->excel->getActiveSheet()->SetCellValue('F' . $row, $total);

			$this->excel->getActiveSheet()->getColumnDimension('A')->setWidth(20);
			$this->excel->getActiveSheet()->getColumnDimension('B')->setWidth(25);
			$this->excel->getActiveSheet()->getColumnDimension('C')->setWidth(25);
			$this->excel->getActiveSheet()->getColumnDimension('D')->setWidth(25);
			$this->excel->getActiveSheet()->getColumnDimension('E')->setWidth(15);
			$this->excel->getActiveSheet()->getColumnDimension('F')->setWidth(15);
			$this->excel->getActiveSheet()->getColumnDimension('G')->setWidth(15);
			$filename = 'payments_report';
			$this->excel->getDefaultStyle()->getAlignment()->setVertical(PHPExcel_Style_Alignment::VERTICAL_CENTER);
			if ($pdf) {
				$styleArray = array(
					'borders' => array(
						'allborders' => array(
							'style' => PHPExcel_Style_Border::BORDER_THIN
							)
						)
					);
				$this->excel->getDefaultStyle()->applyFromArray($styleArray);
				$this->excel->getActiveSheet()->getPageSetup()->setOrientation(PHPExcel_Worksheet_PageSetup::ORIENTATION_LANDSCAPE);
				require_once(APPPATH . "third_party" . DIRECTORY_SEPARATOR . "MPDF" . DIRECTORY_SEPARATOR . "mpdf.php");
				$rendererName = PHPExcel_Settings::PDF_RENDERER_MPDF;
				$rendererLibrary = 'MPDF';
				$rendererLibraryPath = APPPATH . 'third_party' . DIRECTORY_SEPARATOR . $rendererLibrary;
				if (!PHPExcel_Settings::setPdfRenderer($rendererName, $rendererLibraryPath)) {
					die('Please set the $rendererName: ' . $rendererName . ' and $rendererLibraryPath: ' . $rendererLibraryPath . ' values' .
						PHP_EOL . ' as appropriate for your directory structure');
				}

				header('Content-Type: application/pdf');
				header('Content-Disposition: attachment;filename="' . $filename . '.pdf"');
				header('Cache-Control: max-age=0');

				$objWriter = PHPExcel_IOFactory::createWriter($this->excel, 'PDF');
				$objWriter->save('php://output');
				exit();
			}
			if ($xls) {
				ob_clean();
				header('Content-Type: application/vnd.ms-excel');
				header('Content-Disposition: attachment;filename="' . $filename . '.xls"');
				header('Cache-Control: max-age=0');
				ob_clean();
				$objWriter = PHPExcel_IOFactory::createWriter($this->excel, 'Excel5');
				$objWriter->save('php://output');
				exit();
			}
		}
		$this->session->set_flashdata('error', lang('nothing_found'));
		redirect($_SERVER["HTTP_REFERER"]);
	} else {
		$this->load->library('datatables');
		$this->datatables
		->select($this->db->dbprefix('payments') . ".id,
			" . $this->db->dbprefix('payments') . ".date AS date,
			" . $this->db->dbprefix('payments') . ".reference_no as payment_ref, 
			" . $this->db->dbprefix('sales') . ".reference_no as sale_ref, customer,
			(
			CASE 
			WHEN " . $this->db->dbprefix('payments') . ".note = ' ' THEN 
			".$this->db->dbprefix('sales') . ".suspend_note 
			WHEN " . $this->db->dbprefix('sales') . ".suspend_note != ''  THEN 
			CONCAT(".$this->db->dbprefix('sales') . ".suspend_note, ' - ',  " . $this->db->dbprefix('payments') . ".note) 
			ELSE " . $this->db->dbprefix('payments') . ".note END
			), 
			paid_by, amount, type")
		->from('payments')
		->join('sales', 'payments.sale_id=sales.id', 'left')
		->join('purchases', 'payments.purchase_id=purchases.id', 'left')
		->group_by('payments.id')
		->order_by('payments.date desc');
		$this->db->where('payments.type != "sent"');
		$this->db->where('sales.customer !=""');

		if ($this->permission['accounts-index'] = ''){
			if (isset($user)) {
				$this->datatables->where('payments.created_by', $user);
			}
		}
		if (isset($customer)) {
			$this->datatables->where('sales.customer_id', $customer);
		}
		if (isset($supplier)) {
			$this->datatables->where('purchases.supplier_id', $supplier);
		}
		if (isset($biller)) {
			$this->datatables->where('sales.biller_id', $biller);
		}
		if (isset($customer)) {
			$this->datatables->where('sales.customer_id', $customer);
		}
		if (isset($payment_ref)) {
			$this->datatables->like('payments.reference_no', $payment_ref, 'both');
		}
		if (isset($sale_ref)) {
			$this->datatables->like('sales.reference_no', $sale_ref, 'both');
		}
		if (isset($customers)){
			$this->datatables->like('sales.customers',$customers,'both');
		}
		if (isset($purchase_ref)) {
			$this->datatables->like('payments.paid_bys', $purchase_ref, 'both');
		}
		if (isset($grand_total)) {
			$this->datatables->like('sales.grand_total', $grand_total, 'both');
		}
		if (isset($start_date)) {
			$this->datatables->where($this->db->dbprefix('payments').'.date BETWEEN "' . $start_date . '" and "' . $end_date . '"');
		}


		echo $this->datatables->generate();

	}

}

	function list_ap_aging(){
		$this->data['user_id'] = $user_id;
		$bc = array(array('link' => base_url(), 'page' => lang('home')), array('link' => site_url('reports'), 'page' => lang('accounts')), array('link' => '#', 'page' => lang('list_ap_aging')));
		$meta = array('page_title' => lang('list_ap_aging'), 'bc' => $bc);
		$this->page_construct('accounts/list_ap_aging', $meta, $this->data);
	}

	public function getpending_Purchases($warehouse_id = null)
	{
		$this->erp->checkPermissions('index', true,'accounts');
		if ($this->input->get('product')) {
			$product = $this->input->get('product');
		} else {
			$product = NULL;
		}
		if ($this->input->get('user')) {
			$user_query = $this->input->get('user');
		} else {
			$user_query = NULL;
		}
		if ($this->input->get('supplier')) {
			$supplier = $this->input->get('supplier');
		} else {
			$supplier = NULL;
		}
		if ($this->input->get('warehouse')) {
			$warehouse = $this->input->get('warehouse');
		} else {
			$warehouse = NULL;
		}
		if ($this->input->get('reference_no')) {
			$reference_no = $this->input->get('reference_no');
		} else {
			$reference_no = NULL;
		}
		if ($this->input->get('start_date')) {
			$start_date = $this->input->get('start_date');
		} else {
			$start_date = NULL;
		}
		if ($this->input->get('end_date')) {
			$end_date = $this->input->get('end_date');
		} else {
			$end_date = NULL;
		}
		if ($start_date) {
			$start_date = $this->erp->fld($start_date);
			$end_date = $this->erp->fld($end_date);
		}
		if ($this->input->get('note')) {
			$note = $this->input->get('note');
		} else {
			$note = NULL;
		}

		if ((!$this->Owner || !$this->Admin) && !$warehouse_id) {
			$user = $this->site->getUser();
			$warehouse_id = $user->warehouse_id;
		}


		$this->load->library('datatables');
		if ($warehouse_id) {

			$this->datatables
			->select("id, supplier,
				SUM(
					IFNULL(grand_total, 0)
				) AS grand_total,
				SUM(
					IFNULL(paid, 0)
				) AS paid,
				SUM(
					IFNULL(grand_total - paid, 0)
				) AS balance,
				COUNT(
					id
				) as ap_number
				")
			->from('purchases')
			->where('payment_status !=','paid')
			->where('warehouse_id', $warehouse_id)
			->where('DATE_SUB('. $this->db->dbprefix('purchases')  .'.date, INTERVAL 1 DAY) <= CURDATE()')
			->group_by('supplier');
		} else {
			$this->datatables
			->select("id, supplier,
				SUM(
					IFNULL(grand_total, 0)
				) AS grand_total,
				SUM(
					IFNULL(paid, 0)
				) AS paid,
				SUM(
					IFNULL(grand_total - paid, 0)
				) AS balance,
				COUNT(
					id
				) as ap_number
				")
			->from('purchases')
			->where('payment_status !=','paid')
			->where('DATE_SUB('. $this->db->dbprefix('purchases')  .'.date, INTERVAL 1 DAY) <= CURDATE()');

			if(isset($_REQUEST['d'])){
				$date_c = date('Y-m-d', strtotime('+3 months'));
				$date = $_GET['d'];
				$date1 = str_replace("/", "-", $date);
				$date =  date('Y-m-d', strtotime($date1));

				$this->datatables
				->where("date >=", $date)
				->where('payment_status !=','paid')
				->where('purchases.payment_term <>', 0)
				->group_by('supplier');

			}

		}

		// search options

		if ($user_query) {
			$this->datatables->where('purchases.created_by', $user_query);
		}

		if ($product) {
			$this->datatables->like('purchase_items.product_id', $product);
		}
		if ($supplier) {
			$this->datatables->where('purchases.supplier_id', $supplier);
		}
		if ($warehouse) {
			$this->datatables->where('purchases.warehouse_id', $warehouse);
		}
		if ($reference_no) {
			$this->datatables->like('purchases.reference_no', $reference_no, 'both');
		}
		if ($start_date) {
			$this->datatables->where($this->db->dbprefix('purchases').'.date BETWEEN "' . $start_date . '" and "' . $end_date . '"');
		}
		if ($note) {
			$this->datatables->like('purchases.note', $note, 'both');
		}

		/*if (!$this->Customer && !$this->Supplier && !$this->Owner && !$this->Admin && !$this->session->userdata('view_right')) {
			$this->datatables->where('created_by', $this->session->userdata('user_id'));
		} elseif ($this->Supplier) {
			$this->datatables->where('supplier_id', $this->session->userdata('user_id'));
		}*/
		$this->datatables->add_column("Actions", "<div class=\"text-center\"><a class=\"tip\" title='" . $this->lang->line("'list_ac_recevable'") . "' href='" . site_url('account/list_ac_payable') . "'><span class=\"label label-primary\">View</span></a></div>");
		echo $this->datatables->generate();
	}

		# AP AGING 0 - 30
	public function list_ap_aging_0_30($warehouse_id = null)
	{
		$this->erp->checkPermissions('index', true,'accounts');
		if ($this->input->get('product')) {
			$product = $this->input->get('product');
		} else {
			$product = NULL;
		}
		if ($this->input->get('user')) {
			$user_query = $this->input->get('user');
		} else {
			$user_query = NULL;
		}
		if ($this->input->get('supplier')) {
			$supplier = $this->input->get('supplier');
		} else {
			$supplier = NULL;
		}
		if ($this->input->get('warehouse')) {
			$warehouse = $this->input->get('warehouse');
		} else {
			$warehouse = NULL;
		}
		if ($this->input->get('reference_no')) {
			$reference_no = $this->input->get('reference_no');
		} else {
			$reference_no = NULL;
		}
		if ($this->input->get('start_date')) {
			$start_date = $this->input->get('start_date');
		} else {
			$start_date = NULL;
		}
		if ($this->input->get('end_date')) {
			$end_date = $this->input->get('end_date');
		} else {
			$end_date = NULL;
		}
		if ($start_date) {
			$start_date = $this->erp->fld($start_date);
			$end_date = $this->erp->fld($end_date);
		}
		if ($this->input->get('note')) {
			$note = $this->input->get('note');
		} else {
			$note = NULL;
		}

		if ((!$this->Owner || !$this->Admin) && !$warehouse_id) {
			$user = $this->site->getUser();
			$warehouse_id = $user->warehouse_id;
		}

		//$action = '<div class="text-center">' . $detail_link . ' ' . $edit_link . ' ' . $email_link . ' ' . $delete_link . '</div>';

		$this->load->library('datatables');
		if ($warehouse_id) {

			$this->datatables
			->select("id, supplier,
						SUM(
							IFNULL(grand_total, 0)
						) AS grand_total,
						SUM(
							IFNULL(paid, 0)
						) AS paid,
						SUM(
							IFNULL(grand_total - paid, 0)
						) AS balance,
						COUNT(
							id
						) as ap_number
						")
			->from('purchases')
			->where('payment_status !=','paid')
			->where('date('. $this->db->dbprefix('purchases')  .'.date) > CURDATE() AND date('. $this->db->dbprefix('purchases')  .'.date) <= DATE_ADD(now(), INTERVAL + 30 DAY)')
			->where('warehouse_id', $warehouse_id)
			->group_by('supplier');
		} else {
			$this->datatables
			->select("id, supplier,
						SUM(
							IFNULL(grand_total, 0)
						) AS grand_total,
						SUM(
							IFNULL(paid, 0)
						) AS paid,
						SUM(
							IFNULL(grand_total - paid, 0)
						) AS balance,
						COUNT(
							id
						) as ap_number
						")
			->from('purchases')
			->where('payment_status !=','paid')
			->where('date('. $this->db->dbprefix('purchases')  .'.date) > CURDATE() AND date('. $this->db->dbprefix('purchases')  .'.date) <= DATE_ADD(now(), INTERVAL + 30 DAY)');
			if(isset($_REQUEST['d'])){
				$date_c = date('Y-m-d', strtotime('+3 months'));
				$date = $_GET['d'];
				$date1 = str_replace("/", "-", $date);
				$date =  date('Y-m-d', strtotime($date1));

				$this->datatables
				->where("date >=", $date)
				->where('payment_status !=','paid')
				->where('purchases.payment_term <>', 0)
				->group_by('supplier');

			}

		}

		// search options

		if ($user_query) {
			$this->datatables->where('purchases.created_by', $user_query);
		}

		if ($product) {
			$this->datatables->like('purchase_items.product_id', $product);
		}
		if ($supplier) {
			$this->datatables->where('purchases.supplier_id', $supplier);
		}
		if ($warehouse) {
			$this->datatables->where('purchases.warehouse_id', $warehouse);
		}
		if ($reference_no) {
			$this->datatables->like('purchases.reference_no', $reference_no, 'both');
		}
		if ($start_date) {
			$this->datatables->where($this->db->dbprefix('purchases').'.date BETWEEN "' . $start_date . '" and "' . $end_date . '"');
		}
		if ($note) {
			$this->datatables->like('purchases.note', $note, 'both');
		}

		$this->datatables->add_column("Actions", "<div class=\"text-center\"><a class=\"tip\" title='" . $this->lang->line("'list_ac_recevable'") . "' href='" . site_url('account/list_ac_payable/0/0/30') . "'><span class=\"label label-primary\">View</span></a></div>");
		echo $this->datatables->generate();
	}

	# AP AGING 30 - 60
	public function list_ap_aging_30_60($warehouse_id = null)
	{
		$this->erp->checkPermissions('index', true,'accounts');
		if ($this->input->get('product')) {
			$product = $this->input->get('product');
		} else {
			$product = NULL;
		}
		if ($this->input->get('user')) {
			$user_query = $this->input->get('user');
		} else {
			$user_query = NULL;
		}
		if ($this->input->get('supplier')) {
			$supplier = $this->input->get('supplier');
		} else {
			$supplier = NULL;
		}
		if ($this->input->get('warehouse')) {
			$warehouse = $this->input->get('warehouse');
		} else {
			$warehouse = NULL;
		}
		if ($this->input->get('reference_no')) {
			$reference_no = $this->input->get('reference_no');
		} else {
			$reference_no = NULL;
		}
		if ($this->input->get('start_date')) {
			$start_date = $this->input->get('start_date');
		} else {
			$start_date = NULL;
		}
		if ($this->input->get('end_date')) {
			$end_date = $this->input->get('end_date');
		} else {
			$end_date = NULL;
		}
		if ($start_date) {
			$start_date = $this->erp->fld($start_date);
			$end_date = $this->erp->fld($end_date);
		}
		if ($this->input->get('note')) {
			$note = $this->input->get('note');
		} else {
			$note = NULL;
		}

		if ((!$this->Owner || !$this->Admin) && !$warehouse_id) {
			$user = $this->site->getUser();
			$warehouse_id = $user->warehouse_id;
		}

			//$action = '<div class="text-center">' . $detail_link . ' ' . $edit_link . ' ' . $email_link . ' ' . $delete_link . '</div>';

		$this->load->library('datatables');
		if ($warehouse_id) {

			$this->datatables
			->select("id, date, supplier,
								SUM(
									IFNULL(grand_total, 0)
								) AS grand_total,
								SUM(
									IFNULL(paid, 0)
								) AS paid,
								SUM(
									IFNULL(grand_total - paid, 0)
								) AS balance, 
								COUNT(
									id
								) as ap_number
								")
			->from('purchases')
			->where('payment_status !=','paid')
			->where('date('. $this->db->dbprefix('purchases')  .'.date) > DATE_ADD(now(), INTERVAL + 30 DAY) AND date('. $this->db->dbprefix('purchases')  .'.date) <= DATE_ADD(now(), INTERVAL + 60 DAY)')
			->where('warehouse_id', $warehouse_id);
		} else {
			$this->datatables
			->select("id, date, supplier,
								SUM(
									IFNULL(grand_total, 0)
								) AS grand_total,
								SUM(
									IFNULL(paid, 0)
								) AS paid,
								SUM(
									IFNULL(grand_total - paid, 0)
								) AS balance,
								COUNT(
									id
								) as ap_number
								")
			->from('purchases')
			->where('payment_status !=','paid')
			->where('date('. $this->db->dbprefix('purchases')  .'.date) > DATE_ADD(now(), INTERVAL + 30 DAY) AND date('. $this->db->dbprefix('purchases')  .'.date) <= DATE_ADD(now(), INTERVAL + 60 DAY)')
			->group_by('supplier');
			if(isset($_REQUEST['d'])){
				$date_c = date('Y-m-d', strtotime('+3 months'));
				$date = $_GET['d'];
				$date1 = str_replace("/", "-", $date);
				$date =  date('Y-m-d', strtotime($date1));

				$this->datatables
				->where("date >=", $date)
				->where('payment_status !=','paid')
				->where('purchases.payment_term <>', 0)
				->group_by('supplier');

			}

		}

		// search options

		if ($user_query) {
			$this->datatables->where('purchases.created_by', $user_query);
		}

		if ($product) {
			$this->datatables->like('purchase_items.product_id', $product);
		}
		if ($supplier) {
			$this->datatables->where('purchases.supplier_id', $supplier);
		}
		if ($warehouse) {
			$this->datatables->where('purchases.warehouse_id', $warehouse);
		}
		if ($reference_no) {
			$this->datatables->like('purchases.reference_no', $reference_no, 'both');
		}
		if ($start_date) {
			$this->datatables->where($this->db->dbprefix('purchases').'.date BETWEEN "' . $start_date . '" and "' . $end_date . '"');
		}
		if ($note) {
			$this->datatables->like('purchases.note', $note, 'both');
		}

        /*if (!$this->Customer && !$this->Supplier && !$this->Owner && !$this->Admin && !$this->session->userdata('view_right')) {
            $this->datatables->where('created_by', $this->session->userdata('user_id'));
        } elseif ($this->Supplier) {
            $this->datatables->where('supplier_id', $this->session->userdata('user_id'));
        }*/
        $this->datatables->add_column("Actions", "<div class=\"text-center\"><a class=\"tip\" title='" . $this->lang->line("'list_ac_recevable'") . "' href='" . site_url('account/list_ac_payable/0/0/60') . "'><span class=\"label label-primary\">View</span></a></div>");
        echo $this->datatables->generate();
    }

    # AP AGING 60 - 90
    public function list_ap_aging_60_90($warehouse_id = null)
    {
    	$this->erp->checkPermissions('index', true,'accounts');
    	if ($this->input->get('product')) {
    		$product = $this->input->get('product');
    	} else {
    		$product = NULL;
    	}
    	if ($this->input->get('user')) {
    		$user_query = $this->input->get('user');
    	} else {
    		$user_query = NULL;
    	}
    	if ($this->input->get('supplier')) {
    		$supplier = $this->input->get('supplier');
    	} else {
    		$supplier = NULL;
    	}
    	if ($this->input->get('warehouse')) {
    		$warehouse = $this->input->get('warehouse');
    	} else {
    		$warehouse = NULL;
    	}
    	if ($this->input->get('reference_no')) {
    		$reference_no = $this->input->get('reference_no');
    	} else {
    		$reference_no = NULL;
    	}
    	if ($this->input->get('start_date')) {
    		$start_date = $this->input->get('start_date');
    	} else {
    		$start_date = NULL;
    	}
    	if ($this->input->get('end_date')) {
    		$end_date = $this->input->get('end_date');
    	} else {
    		$end_date = NULL;
    	}
    	if ($start_date) {
    		$start_date = $this->erp->fld($start_date);
    		$end_date = $this->erp->fld($end_date);
    	}
    	if ($this->input->get('note')) {
    		$note = $this->input->get('note');
    	} else {
    		$note = NULL;
    	}

    	if ((!$this->Owner || !$this->Admin) && !$warehouse_id) {
    		$user = $this->site->getUser();
    		$warehouse_id = $user->warehouse_id;
    	}
        //$action = '<div class="text-center">' . $detail_link . ' ' . $edit_link . ' ' . $email_link . ' ' . $delete_link . '</div>';

		$this->load->library('datatables');
		if ($warehouse_id) {

			$this->datatables
			->select("id, date, supplier,
								SUM(
									IFNULL(grand_total, 0)
								) AS grand_total,
								SUM(
									IFNULL(paid, 0)
								) AS paid,
								SUM(
									IFNULL(grand_total - paid, 0)
								) AS balance,
								COUNT(
									id
								) as ap_number
								")
			->from('purchases')
			->where('payment_status !=','paid')
			->where('date('. $this->db->dbprefix('purchases')  .'.date) > DATE_ADD(now(), INTERVAL + 60 DAY) AND date('. $this->db->dbprefix('purchases')  .'.date) <= DATE_ADD(now(), INTERVAL + 90 DAY)')
			->where('warehouse_id', $warehouse_id)
			->group_by('supplier');
		} else {
			$this->datatables
			->select("id, date, supplier,
								SUM(
									IFNULL(grand_total, 0)
								) AS grand_total,
								SUM(
									IFNULL(paid, 0)
								) AS paid,
								SUM(
									IFNULL(grand_total - paid, 0)
								) AS balance,
								COUNT(
									id
								) as ap_number
								")
			->from('purchases')
			->where('payment_status !=','paid')
			->where('date('. $this->db->dbprefix('purchases')  .'.date) > DATE_ADD(now(), INTERVAL + 60 DAY) AND date('. $this->db->dbprefix('purchases')  .'.date) <= DATE_ADD(now(), INTERVAL + 90 DAY)');
			if(isset($_REQUEST['d'])){
				$date_c = date('Y-m-d', strtotime('+3 months'));
				$date = $_GET['d'];
				$date1 = str_replace("/", "-", $date);
				$date =  date('Y-m-d', strtotime($date1));

				$this->datatables
				->where("date >=", $date)
				->where('payment_status !=','paid')
				->where('purchases.payment_term <>', 0)
				->group_by('supplier');

			}

		}

			// search options

		if ($user_query) {
			$this->datatables->where('purchases.created_by', $user_query);
		}

		if ($product) {
			$this->datatables->like('purchase_items.product_id', $product);
		}
		if ($supplier) {
			$this->datatables->where('purchases.supplier_id', $supplier);
		}
		if ($warehouse) {
			$this->datatables->where('purchases.warehouse_id', $warehouse);
		}
		if ($reference_no) {
			$this->datatables->like('purchases.reference_no', $reference_no, 'both');
		}
		if ($start_date) {
			$this->datatables->where($this->db->dbprefix('purchases').'.date BETWEEN "' . $start_date . '" and "' . $end_date . '"');
		}
		if ($note) {
			$this->datatables->like('purchases.note', $note, 'both');
		}

        /*if (!$this->Customer && !$this->Supplier && !$this->Owner && !$this->Admin && !$this->session->userdata('view_right')) {
            $this->datatables->where('created_by', $this->session->userdata('user_id'));
        } elseif ($this->Supplier) {
            $this->datatables->where('supplier_id', $this->session->userdata('user_id'));
        }*/
        $this->datatables->add_column("Actions", "<div class=\"text-center\"><a class=\"tip\" title='" . $this->lang->line("'list_ac_recevable'") . "' href='" . site_url('account/list_ac_payable/0/0/90') . "'><span class=\"label label-primary\">View</span></a></div>");
        echo $this->datatables->generate();
    }

    # AP AGING OVER 90
    public function list_ap_aging_over_90($warehouse_id = null)
    {
    	$this->erp->checkPermissions('index', true,'accounts');
    	if ($this->input->get('product')) {
    		$product = $this->input->get('product');
    	} else {
    		$product = NULL;
    	}
    	if ($this->input->get('user')) {
    		$user_query = $this->input->get('user');
    	} else {
    		$user_query = NULL;
    	}
    	if ($this->input->get('supplier')) {
    		$supplier = $this->input->get('supplier');
    	} else {
    		$supplier = NULL;
    	}
    	if ($this->input->get('warehouse')) {
    		$warehouse = $this->input->get('warehouse');
    	} else {
    		$warehouse = NULL;
    	}
    	if ($this->input->get('reference_no')) {
    		$reference_no = $this->input->get('reference_no');
    	} else {
    		$reference_no = NULL;
    	}
    	if ($this->input->get('start_date')) {
    		$start_date = $this->input->get('start_date');
    	} else {
    		$start_date = NULL;
    	}
    	if ($this->input->get('end_date')) {
    		$end_date = $this->input->get('end_date');
    	} else {
    		$end_date = NULL;
    	}
    	if ($start_date) {
    		$start_date = $this->erp->fld($start_date);
    		$end_date = $this->erp->fld($end_date);
    	}
    	if ($this->input->get('note')) {
    		$note = $this->input->get('note');
    	} else {
    		$note = NULL;
    	}

    	if ((!$this->Owner || !$this->Admin) && !$warehouse_id) {
    		$user = $this->site->getUser();
    		$warehouse_id = $user->warehouse_id;
    	}

        //$action = '<div class="text-center">' . $detail_link . ' ' . $edit_link . ' ' . $email_link . ' ' . $delete_link . '</div>';

		$this->load->library('datatables');
		if ($warehouse_id) {

			$this->datatables
			->select("id, date, supplier,
								SUM(
									IFNULL(grand_total, 0)
								) AS grand_total,
								SUM(
									IFNULL(paid, 0)
								) AS paid,
								SUM(
									IFNULL(grand_total - paid, 0)
								) AS balance,
								COUNT(
									id
								) as ap_number
								")
			->from('purchases')
			->where('payment_status !=','paid')
			->where('date(purchases.date) >= DATE_ADD(now(), INTERVAL + 90 DAY)')
			->where('warehouse_id', $warehouse_id)
			->group_by('supplier');
		} else {
			$this->datatables
			->select("id, date, supplier,
								SUM(
									IFNULL(grand_total, 0)
								) AS grand_total,
								SUM(
									IFNULL(paid, 0)
								) AS paid,
								SUM(
									IFNULL(grand_total - paid, 0)
								) AS balance,
								COUNT(
									id
								) as ap_number
								")
			->from('purchases')
			->where('payment_status !=','paid')
			->where('date('. $this->db->dbprefix('purchases')  .'.date) >= DATE_ADD(now(), INTERVAL + 90 DAY)');
			if(isset($_REQUEST['d'])){
				$date_c = date('Y-m-d', strtotime('+3 months'));
				$date = $_GET['d'];
				$date1 = str_replace("/", "-", $date);
				$date =  date('Y-m-d', strtotime($date1));

				$this->datatables
				->where("date >=", $date)
				->where('payment_status !=','paid')
				->where('purchases.payment_term <>', 0)
				->group_by('supplier');

			}

		}

			// search options

		if ($user_query) {
			$this->datatables->where('purchases.created_by', $user_query);
		}

		if ($product) {
			$this->datatables->like('purchase_items.product_id', $product);
		}
		if ($supplier) {
			$this->datatables->where('purchases.supplier_id', $supplier);
		}
		if ($warehouse) {
			$this->datatables->where('purchases.warehouse_id', $warehouse);
		}
		if ($reference_no) {
			$this->datatables->like('purchases.reference_no', $reference_no, 'both');
		}
		if ($start_date) {
			$this->datatables->where($this->db->dbprefix('purchases').'.date BETWEEN "' . $start_date . '" and "' . $end_date . '"');
		}
		if ($note) {
			$this->datatables->like('purchases.note', $note, 'both');
		}

        /*if (!$this->Customer && !$this->Supplier && !$this->Owner && !$this->Admin && !$this->session->userdata('view_right')) {
            $this->datatables->where('created_by', $this->session->userdata('user_id'));
        } elseif ($this->Supplier) {
            $this->datatables->where('supplier_id', $this->session->userdata('user_id'));
        }*/
        $this->datatables->add_column("Actions", "<div class=\"text-center\"><a class=\"tip\" title='" . $this->lang->line("'list_ac_recevable'") . "' href='" . site_url('account/list_ac_payable/0/0/91') . "'><span class=\"label label-primary\">View</span></a></div>");
        echo $this->datatables->generate();
    }

    function payment_note($id = NULL)
    {
    	$this->load->model('sales_model');
    	$payment = $this->sales_model->getPaymentByID($id);
    	$inv = $this->sales_model->getInvoiceByID($payment->sale_id);
    	$this->data['biller'] = $this->site->getCompanyByID($inv->biller_id);
    	$this->data['customer'] = $this->site->getCompanyByID($inv->customer_id);
    	$this->data['inv'] = $inv;
    	$this->data['payment'] = $payment;
    	$this->data['page_title'] = $this->lang->line("payment_note");

    	$this->load->view($this->theme . 'accounts/payment_note', $this->data);
    }

    function purchase_note($id = NULL)
    {
    	$this->load->model('sales_model');
    	$purchase = $this->sales_model->getPurchaseByID($id);
    	$inv = $this->sales_model->getInvoiceByID($purchase->id);
    	$this->data['biller'] = $this->site->getCompanyByID($purchase->biller_id);
    	$this->data['customer'] = $this->site->getCompanyByID($purchase->supplier_id);
    	$this->data['inv'] = $inv;
    	$this->data['payment'] = $purchase;
    	$this->data['page_title'] = $this->lang->line("purchase_note");

    	$this->load->view($this->theme . 'accounts/purchase_note', $this->data);
    }

    function account_head($id = NULL)
    {
		/*
		$this->load->model('sales_model');
        $payment = $this->sales_model->getPaymentByID($id);
        $inv = $this->sales_model->getInvoiceByID($payment->sale_id);
        $this->data['biller'] = $this->site->getCompanyByID($inv->biller_id);
        $this->data['customer'] = $this->site->getCompanyByID($inv->customer_id);
        $this->data['inv'] = $inv;
		$this->data['payment'] = $payment;
		*/
		$this->data['id'] = $id;
		$this->data['page_title'] = $this->lang->line("account_head");

		$this->load->view($this->theme . 'accounts/account_head', $this->data);
	}
	
	function dataLedger()
	{
		$output = "";
		//$start_date = $this->erp->fld($_GET['start_date']);
		//$end_date = $this->erp->fld($_GET['end_date']);
		$start_date = $this->erp->fsd($_GET['start_date']);
		$end_date = $this->erp->fsd($_GET['end_date']);
		$id = $_GET['id'];
		$this->db->select('*')->from('gl_charts');
		$this->db->where('accountcode', $id);
		
		$acc = $this->db->get()->result();
		foreach($acc as $val){
			$gl_tranStart = $this->db->select('sum(amount) as startAmount')->from('gl_trans');
			$gl_tranStart->where(array('tran_date < '=> $this->erp->fld($this->input->post('start_date')), 'account_code'=> $val->accountcode));
			$startAmount = $gl_tranStart->get()->row();
			
			$endAccountBalance = 0;
			$getListGLTran = $this->db->select("*")->from('gl_trans')->where('account_code =', $val->accountcode);
			if ($this->input->post('start_date')) {
				$getListGLTran->where('tran_date >=', $this->erp->fld($this->input->post('start_date')) );
			}
			if ($this->input->post('end_date')) {
				$getListGLTran->where('tran_date <=', $this->erp->fld($this->input->post('end_date')) );
			}
			$gltran_list = $getListGLTran->get()->result();
			if($gltran_list) 
			{
				$output.='<tr>';
				$output.='<td colspan="4">Account:'.$val->accountcode . ' ' .$val->accountname.'</td>';
				$output.='<td colspan="2">Begining Account Balance: </td>';
				$output.='<td colspan="2" style="text-align: center;">';
				$output.='$'.abs($startAmount->startAmount);
				$output.='</td>';
				$output.='</tr>';
				foreach($gltran_list as $rw)
				{
					$endAccountBalance += $rw->amount; 
					$output.='<tr>';
					$output.='<td>'.$rw->tran_id.'</td>';
					$output.='<td>'.$rw->reference_no.'</td>';
					$output.='<td>'.$rw->tran_no.'</td>';
					$output.='<td>'.$rw->narrative.'</td>';
					$output.='<td>'.$rw->tran_date.'</td>';
					$output.='<td>'.$rw->tran_type.'</td>';
					$output.='<td>'.($rw->amount > 0 ? $rw->amount : '0.00').'</td>';
					$output.='<td>'.($rw->amount < 1 ? abs($rw->amount) : '0.00').'</td>';
					$output.='</tr>';
				}
				$output.='<tr>';
				$output.='<td colspan="4"> </td>';
				$output.='<td colspan="2">Ending Account Balance: </td>';
				$output.='<td colspan="2">$ '.abs($endAccountBalance).'</td>';
				$output.='</tr>';
			}else{
				$output.='<tr>';
				$output.='<td colspan="8" class="dataTables_empty">No Data</td>';
				$output.='</tr>';
			}
		}
		echo json_encode($output);
	}
	
	function billPayable()
	{
		$this->erp->checkPermissions('index', true, 'accounts');
		$this->load->model('reports_model');
		$this->data['error'] = (validation_errors()) ? validation_errors() : $this->session->flashdata('error');
		$this->data['users'] = $this->reports_model->getStaff();
		$this->data['billers'] = $this->site->getAllCompanies('biller');
		$bc = array(array('link' => base_url(), 'page' => lang('home')), array('link' => site_url('accounts'), 'page' => lang('accounts')), array('link' => '#', 'page' => lang('Bill Payable Report')));
		$meta = array('page_title' => lang('payments_report'), 'bc' => $bc);
		$this->page_construct('accounts/bill_payable', $meta, $this->data);
	}
	
	function getBillPaymentReport($pdf = NULL, $xls = NULL)
	{
		$this->erp->checkPermissions('index', true, 'accounts');
		if ($this->input->get('user')) {
			$user = $this->input->get('user');
		} else {
			$user = NULL;
		}
		if ($this->input->get('supplier')) {
			$supplier = $this->input->get('supplier');
		} else {
			$supplier = NULL;
		}
		if ($this->input->get('customer')) {
			$customer = $this->input->get('customer');
		} else {
			$customer = NULL;
		}
		if ($this->input->get('biller')) {
			$biller = $this->input->get('biller');
		} else {
			$biller = NULL;
		}
		if ($this->input->get('payment_ref')) {
			$payment_ref = $this->input->get('payment_ref');
		} else {
			$payment_ref = NULL;
		}
		if ($this->input->get('sale_ref')) {
			$sale_ref = $this->input->get('sale_ref');
		} else {
			$sale_ref = NULL;
		}
		if ($this->input->get('purchase_ref')) {
			$purchase_ref = $this->input->get('purchase_ref');
		} else {
			$purchase_ref = NULL;
		}
		if ($this->input->get('start_date')) {
			$start_date = $this->input->get('start_date');
		} else {
			$start_date = NULL;
		}
		if ($this->input->get('end_date')) {
			$end_date = $this->input->get('end_date');
		} else {
			$end_date = NULL;
		}
		if ($start_date) {
			$start_date = $this->erp->fsd($start_date);
			$end_date = $this->erp->fsd($end_date);
		}
		if (!$this->Owner && !$this->Admin) {
			$user = $this->session->userdata('user_id');
		}
		if ($pdf || $xls) {

			$this->db
			->select($this->db->dbprefix('purchases') . ".id, 
				" . $this->db->dbprefix('purchases') . ".date,
				" . $this->db->dbprefix('purchases') . ".reference_no,
				" . $this->db->dbprefix('purchases') . ".supplier as purchase_ref,
				" . $this->db->dbprefix('payments') . ".paid_by,
				" . $this->db->dbprefix('payments') . ".note,
				" . $this->db->dbprefix('purchases') . ".paid,
				" . $this->db->dbprefix('purchases') . ".payment_status")
			->from('purchases')
			->JOIN('payments','purchases.id=payments.purchase_id','left');
                //->group_by('purchases.id');
			if ($this->permission['accounts-index'] = ''){
				if ($user) {
					$this->db->where('payments.created_by', $user);
				}
			}
			if ($customer) {
				$this->db->where('sales.customer_id', $customer);
			}
			if ($supplier) {
				$this->db->where('purchases.supplier_id', $supplier);
			}
			if ($biller) {
				$this->db->where('sales.biller_id', $biller);
			}
			if ($customer) {
				$this->db->where('sales.customer_id', $customer);
			}
			if ($payment_ref) {
				$this->db->like('payments.reference_no', $payment_ref, 'both');
			}
			if ($sale_ref) {
				$this->db->like('sales.reference_no', $sale_ref, 'both');
			}
			if ($purchase_ref) {
				$this->db->like('purchases.reference_no', $purchase_ref, 'both');
			}
			if ($start_date) {
				$this->db->where($this->db->dbprefix('payments').'.date BETWEEN "' . $start_date . '" and "' . $end_date . '"');
			}

			$q = $this->db->get();
			if ($q->num_rows() > 0) {
				foreach (($q->result()) as $row) {
					$data[] = $row;
				}
			} else {
				$data = NULL;
			}

			if (!empty($data)) {

				$this->load->library('excel');
				$this->excel->setActiveSheetIndex(0);
				$this->excel->getActiveSheet()->setTitle(lang('bill_payable'));
				$this->excel->getActiveSheet()->SetCellValue('A1', lang('date'));
				$this->excel->getActiveSheet()->SetCellValue('B1', lang('reference_no'));
				$this->excel->getActiveSheet()->SetCellValue('C1', lang('supplier'));
				$this->excel->getActiveSheet()->SetCellValue('D1', lang('paid_by'));
				$this->excel->getActiveSheet()->SetCellValue('E1', lang('paid'));
                //$this->excel->getActiveSheet()->SetCellValue('F1', lang('amount'));
				$this->excel->getActiveSheet()->SetCellValue('F1', lang('type'));

				$row = 2;
				$total = 0;
				$paid=0;
				foreach ($data as $data_row) {
					$this->excel->getActiveSheet()->SetCellValue('A' . $row, $this->erp->hrld($data_row->date));
					$this->excel->getActiveSheet()->SetCellValue('B' . $row, $data_row->reference_no);
					$this->excel->getActiveSheet()->SetCellValue('C' . $row, $data_row->supplier);
					$this->excel->getActiveSheet()->SetCellValue('D' . $row, lang($data_row->paid_by));
					$this->excel->getActiveSheet()->SetCellValue('E' . $row, $data_row->paid);
					$this->excel->getActiveSheet()->SetCellValue('F' . $row, $data_row->grand_total);
					$this->excel->getActiveSheet()->SetCellValue('G' . $row, $data_row->type);
					$paid+=$data_row->paid;
					$total+=$data_row->grand_total;
					$row++;
				}
				$this->excel->getActiveSheet()->getStyle("F" . $row)->getBorders()
				->getTop()->setBorderStyle(PHPExcel_Style_Border::BORDER_MEDIUM);
				$this->excel->getActiveSheet()->setCellValue('E'.$row,$paid);
				$this->excel->getActiveSheet()->SetCellValue('F' . $row, $total);

				$this->excel->getActiveSheet()->getColumnDimension('A')->setWidth(20);
				$this->excel->getActiveSheet()->getColumnDimension('B')->setWidth(25);
				$this->excel->getActiveSheet()->getColumnDimension('C')->setWidth(25);
				$this->excel->getActiveSheet()->getColumnDimension('D')->setWidth(25);
				$this->excel->getActiveSheet()->getColumnDimension('E')->setWidth(15);
				$this->excel->getActiveSheet()->getColumnDimension('F')->setWidth(15);
				$this->excel->getActiveSheet()->getColumnDimension('G')->setWidth(15);
				$filename = 'payments_report';
				$this->excel->getDefaultStyle()->getAlignment()->setVertical(PHPExcel_Style_Alignment::VERTICAL_CENTER);
				if ($pdf) {
					$styleArray = array(
						'borders' => array(
							'allborders' => array(
								'style' => PHPExcel_Style_Border::BORDER_THIN
								)
							)
						);
					$this->excel->getDefaultStyle()->applyFromArray($styleArray);
					$this->excel->getActiveSheet()->getPageSetup()->setOrientation(PHPExcel_Worksheet_PageSetup::ORIENTATION_LANDSCAPE);
					require_once(APPPATH . "third_party" . DIRECTORY_SEPARATOR . "MPDF" . DIRECTORY_SEPARATOR . "mpdf.php");
					$rendererName = PHPExcel_Settings::PDF_RENDERER_MPDF;
					$rendererLibrary = 'MPDF';
					$rendererLibraryPath = APPPATH . 'third_party' . DIRECTORY_SEPARATOR . $rendererLibrary;
					if (!PHPExcel_Settings::setPdfRenderer($rendererName, $rendererLibraryPath)) {
						die('Please set the $rendererName: ' . $rendererName . ' and $rendererLibraryPath: ' . $rendererLibraryPath . ' values' .
							PHP_EOL . ' as appropriate for your directory structure');
					}

					header('Content-Type: application/pdf');
					header('Content-Disposition: attachment;filename="' . $filename . '.pdf"');
					header('Cache-Control: max-age=0');

					$objWriter = PHPExcel_IOFactory::createWriter($this->excel, 'PDF');
					$objWriter->save('php://output');
					exit();
				}
				if ($xls) {
					ob_clean();
					header('Content-Type: application/vnd.ms-excel');
					header('Content-Disposition: attachment;filename="' . $filename . '.xls"');
					header('Cache-Control: max-age=0');
					ob_clean();
					$objWriter = PHPExcel_IOFactory::createWriter($this->excel, 'Excel5');
					$objWriter->save('php://output');
					exit();
				}

			}
			$this->session->set_flashdata('error', lang('nothing_found'));
			redirect($_SERVER["HTTP_REFERER"]);

		} else {

			$this->load->library('datatables');
			$this->datatables
			->select($this->db->dbprefix('purchases') . ".id as pid, 
				" . $this->db->dbprefix('purchases') . ".date,
				" . $this->db->dbprefix('purchases') . ".reference_no as payment_ref,
				" . $this->db->dbprefix('purchases') . ".supplier as purchase_ref,
				" . $this->db->dbprefix('payments') . ".paid_by,
				" . $this->db->dbprefix('payments') . ".note,
				" . $this->db->dbprefix('payments') . ".amount, 
				'paid' as payment_status")
			->from('purchases')
			->where('purchases.paid != 0')
			->JOIN('payments','purchases.id=payments.purchase_id','left');
                //->group_by('purchases.id');
			if ($this->permission['accounts-index'] = ''){
				if ($user) {
					$this->datatables->where('payments.created_by', $user);
				}
			}
			if ($customer) {
				$this->datatables->where('sales.customer_id', $customer);
			}
			if ($supplier) {
				$this->datatables->where('purchases.supplier_id', $supplier);
			}
			if ($biller) {
				$this->datatables->where('sales.biller_id', $biller);
			}
			if ($customer) {
				$this->datatables->where('sales.customer_id', $customer);
			}
			if ($payment_ref) {
				$this->datatables->like('payments.reference_no', $payment_ref, 'both');
			}
			if ($sale_ref) {
				$this->datatables->like('sales.reference_no', $sale_ref, 'both');
			}
			if ($purchase_ref) {
				$this->datatables->like('purchases.reference_no', $purchase_ref, 'both');
			}
			if ($start_date) {
				$this->datatables->where($this->db->dbprefix('payments').'.date BETWEEN "' . $start_date . '" and "' . $end_date . '"');
			}

			echo $this->datatables->generate();

		}

	}
	
	function listJournal()
	{
		$this->erp->checkPermissions('index', true, 'accounts');

		$this->data['error'] = (validation_errors()) ? validation_errors() : $this->session->flashdata('error');
        //$this->data['action'] = $action;
		$bc = array(array('link' => base_url(), 'page' => lang('home')), array('link' => '#', 'page' => lang('accounts')));
		$meta = array('page_title' => lang('Account'), 'bc' => $bc);
		$this->page_construct('accounts/list_journal', $meta, $this->data);
	}

	function getJournalList()
	{
		$this->erp->checkPermissions('index', true, 'accounts');
		if ($this->input->get('reference_no')) {
			$reference_no = $this->input->get('reference_no');
		} else {
			$reference_no = NULL;
		}
		if ($this->input->get('start_date')) {
			$start_date = $this->input->get('start_date');
		} else {
			$start_date = NULL;
		}
		if ($this->input->get('end_date')) {
			$end_date = $this->input->get('end_date');
		} else {
			$end_date = NULL;
		}
		if ($start_date) {
			$start_date = $this->erp->fld($start_date);
			$end_date = $this->erp->fld($end_date);
		}

		$this->load->library('datatables');
		$this->datatables
		->select("gt.tran_id, gt.tran_no AS g_tran_no, companies.company, gt.tran_type, gt.tran_date, 
			gt.reference_no, gt.account_code, 
			gt.narrative, gt.description, 
			(IF(gt.amount > 0, gt.amount, IF(gt.amount = 0, 0, null))) as debit, 
			(IF(gt.amount < 0, abs(gt.amount), null)) as credit")
		->from("erp_gl_trans gt")
		->join('companies', 'companies.id = (gt.biller_id)', 'left');
		if ($reference_no) {
			$this->datatables->like('gt.reference_no', $reference_no, 'both');
		}
		if ($start_date) {
			$this->datatables->where('gt.tran_date BETWEEN "' . $start_date . '" AND "' . $end_date . '"');
		}
        //$this->datatables->add_column("Actions", "<center><a class=\"tip\" title='" . $this->lang->line("edit_journal") . "' href='" . site_url('account/edit_journal/$1') . "' data-toggle='modal' data-target='#myModal'><i class=\"fa fa-edit\"></i></a>  <a href='#' class='tip po' title='<b>" . $this->lang->line("delete_account") . "</b>' data-content=\"<p>" . lang('r_u_sure') . "</p><a class='btn btn-danger po-delete' href='" . site_url('account/deleteJournal/$2') . "'>" . lang('i_m_sure') . "</a> <button class='btn po-close'>" . lang('no') . "</button>\"  rel='popover'><i class=\"fa fa-trash-o\"></i></a></center>", "gt.reference_no,gt.tran_id");
		$this->datatables->add_column("Actions", "<center><a class=\"tip\" title='" . $this->lang->line("edit_journal") . "' href='" . site_url('account/edit_journal/$1') . "' data-toggle='modal' data-target='#myModal'><i class=\"fa fa-edit\"></i></a></center>", "g_tran_no");
        //->unset_column('id');
		echo $this->datatables->generate();
	}
	
	public function edit_journal($tran_no){
		$this->erp->checkPermissions('edit', true, 'accounts');
		
		$chart_acc_details = $this->accounts_model->getAllChartAccount();
		foreach($chart_acc_details as $chart) {
			$section_id = $chart->sectionid;
		}
		

		$this->data['supplier'] = $chart_acc_details;
		$this->data['sectionacc'] = $chart_acc_details;
		$this->data['journals'] = $this->accounts_model->getJournalByTranNo($tran_no);
		$this->data['subacc'] = $this->accounts_model->getSubAccounts($section_id);
		$this->data['billers'] = $this->site->getAllCompanies('biller');
		$this->data['error'] = (validation_errors() ? validation_errors() : $this->session->flashdata('error'));
		$this->data['modal_js'] = $this->site->modal_js();
		$this->load->view($this->theme . 'accounts/edit_journal', $this->data);
	}
	
	public function add_journal(){
		$this->erp->checkPermissions('add', true, 'accounts');
		$this->data['sectionacc'] = $this->accounts_model->getAccountSections();
		$this->data['error'] = (validation_errors() ? validation_errors() : $this->session->flashdata('error'));
		$this->data['modal_js'] = $this->site->modal_js();
		$this->data['sectionacc'] = $this->accounts_model->getAllChartAccount();
		$this->data['billers'] = $this->site->getAllCompanies('biller');
		$this->data['rate'] = $this->accounts_model->getKHM();
		$this->load->view($this->theme . 'accounts/add_journal', $this->data);
	}
	
	function save_journal(){
		$account_code = $this->input->post('account_section');
		$reference_no = $this->input->post('reference_no')?$this->input->post('reference_no'):$this->site->getReference('tr');

		$date = $this->input->post('date');
		$tran_date = strtr($date, '/', '-');
		$tran_date = date('Y-m-d h:m', strtotime($tran_date));
		
		$description = $this->input->post('description');
		$biller_id = $this->input->post('biller_id');
		$debit = $this->input->post('debit');
		$credit = $this->input->post('credit');
		$i = 0;

		$tran_no = $this->accounts_model->getTranNo();
		$data = array();
		for($i=0;$i<count($account_code);$i++) {
			if($debit[$i]>0) {
				$amount = $debit[$i];
			}
			elseif($credit[$i]>0) {
				$amount = -$credit[$i];
			}
			$data[] = array(
				'tran_type' => 'JOURNAL',
				'tran_no' => $tran_no,
				'account_code' => $account_code[$i],
				'tran_date' => $tran_date,
				'reference_no' => $reference_no,
				'description' => $description,
				'amount' => $amount,
				'biller_id' => $biller_id
				);
		}
		$this->accounts_model->addJournal($data);
		
		$this->session->set_flashdata('message', $this->lang->line("journal_added"));
		redirect('account/listJournal');
	}
	
	public function updateJournal(){
		$this->erp->checkPermissions('edit', true, 'accounts');
		$account_code = $this->input->post('account_section');
		$reference_no = $this->input->post('reference_no');
		$biller_id = $this->input->post('biller_id');
		$date = $this->input->post('date');
		$tran_date = strtr($date, '/', '-');
		$tran_date = date('Y-m-d h:m', strtotime($tran_date));
		$tran_id = $this->input->post('tran_id');
		$description = $this->input->post('description');
		$debit = $this->input->post('debit');
		$credit = $this->input->post('credit');
		
		$i = 0;
		$tran_no_old = $this->accounts_model->getTranNoByRef($reference_no);
		
		$tran_type = '';
		$tran_type = $this->accounts_model->getTranTypeByRef($reference_no);
		
		if(!$tran_type){
			$tran_type = 'JOURNAL';
		}
		
		$data = array();
		for($i=0;$i<count($account_code);$i++) {
			if($debit[$i]>0) {
				$amount = $debit[$i];
			}
			elseif($credit[$i]>0 ) {
				$amount = -$credit[$i];
			}else{
				$amount = 0;
			}

			if($tran_id[$i] != 0){
				$data[] = array(
					'tran_type' => $tran_type,
					'tran_id' => $tran_id[$i],
					'account_code' => $account_code[$i],
					'tran_date' => $tran_date,
					'reference_no' => $reference_no,
					'description' => $description,
					'amount' => $amount,
					'biller_id' => $biller_id
					);
			}else{
				$data[] = array(
					'tran_type' => $tran_type,
					'tran_no' => $tran_no_old,
					'account_code' => $account_code[$i],
					'tran_date' => $tran_date,
					'reference_no' => $reference_no,
					'description' => $description,
					'amount' => $amount,
					'biller_id' => $biller_id
					);
			}
		}
		$this->accounts_model->updateJournal($data);
		$this->session->set_flashdata('message', $this->lang->line("journal_updated"));
		redirect('account/listJournal');
	}


	public function deleteJournal($id){
		$this->erp->checkPermissions(NULL, TRUE);

		if ($this->input->get('id')) {
			$id = $this->input->get('id');
		}

		if ($this->accounts_model->deleteJournalById($id)) {
			echo $this->lang->line("deleted_journal");
		} else {
			$this->session->set_flashdata('warning', lang('journal_x_deleted_have_account'));
			die("<script type='text/javascript'>setTimeout(function(){ window.top.location.href = '" . (isset($_SERVER["HTTP_REFERER"]) ? $_SERVER["HTTP_REFERER"] : site_url('welcome')) . "'; }, 0);</script>");
		}
	}

	function getSubAccount($section_code = null){
		if ($rows = $this->accounts_model->getSubAccounts($section_code)) {
			$data = json_encode($rows);
		} else {
			$data = false;
		}
		echo $data;
	}

	function add()
	{
		$this->erp->checkPermissions(false, true);

		$this->form_validation->set_rules('email', $this->lang->line("email_address"), 'is_unique[companies.email]');
		//$this->form_validation->set_rules('account_code', $this->lang->line("account_code"), 'is_unique[gl_charts.accountcode]');

		if ($this->form_validation->run('account/add') == true) {
			
			$data = array('accountcode' => $this->input->post('account_code'),
				'accountname' => $this->input->post('account_name'),
				'parent_acc' => $this->input->post('sub_account'),
				'sectionid' => $this->input->post('account_section'),
				'bank' => $this->input->post('bank_account')
				);
		}

		if ($this->form_validation->run() == true && $sid = $this->accounts_model->addChartAccount($data)) {
			$this->session->set_flashdata('message', $this->lang->line("accound_added"));
			$ref = isset($_SERVER["HTTP_REFERER"]) ? explode('?', $_SERVER["HTTP_REFERER"]) : NULL;
			redirect($ref[0] . '?account=' . $sid);
		} else {
			$this->data['sectionacc'] = $this->accounts_model->getAccountSections();
			$this->data['error'] = (validation_errors() ? validation_errors() : $this->session->flashdata('error'));
			$this->data['modal_js'] = $this->site->modal_js();
			$this->load->view($this->theme . 'accounts/add', $this->data);
		}
	}
	
	public function updateAccount(){
		$parent_account = $this->input->post('sub_acc');
		$acc_code = $this->input->post('account_code');
		if($this->input->post('sub_account') != '' || $this->input->post('sub_account') != null){
			$parent_account = $this->input->post('sub_account');
		}
		
		$data = array('accountcode' => $acc_code,
			'accountname' => $this->input->post('account_name'),
			'parent_acc' => $parent_account,
			'sectionid' => $this->input->post('account_section'),
			'bank' => $this->input->post('bank_account')
			);

		$this->accounts_model->updateChartAccount($acc_code, $data);
		$this->session->set_flashdata('message', $this->lang->line("accound_updated"));
		redirect('account');	
	}

	function edit($id = NULL)
	{
		$this->erp->checkPermissions(false, true);
		
		$chart_acc_details = $this->accounts_model->getChartAccountByID($id);
		$section_id = $chart_acc_details->sectionid;

		$this->data['supplier'] = $chart_acc_details;
		$this->data['sectionacc'] = $this->accounts_model->getAccountSections();
		$this->data['subacc'] = $this->accounts_model->getSubAccounts($section_id);
		$this->data['error'] = (validation_errors() ? validation_errors() : $this->session->flashdata('error'));
		$this->data['modal_js'] = $this->site->modal_js();
		$this->load->view($this->theme . 'accounts/edit', $this->data);
	}

	function users($company_id = NULL)
	{
		$this->erp->checkPermissions(false, true);

		if ($this->input->get('id')) {
			$company_id = $this->input->get('id');
		}


		$this->data['error'] = (validation_errors() ? validation_errors() : $this->session->flashdata('error'));
		$this->data['modal_js'] = $this->site->modal_js();
		$this->data['company'] = $this->companies_model->getCompanyByID($company_id);
		$this->data['users'] = $this->companies_model->getCompanyUsers($company_id);
		$this->load->view($this->theme . 'suppliers/users', $this->data);

	}

	function add_user($company_id = NULL)
	{
		$this->erp->checkPermissions(false, true);

		if ($this->input->get('id')) {
			$company_id = $this->input->get('id');
		}
		$company = $this->companies_model->getCompanyByID($company_id);

		$this->form_validation->set_rules('email', $this->lang->line("email_address"), 'is_unique[users.email]');
		$this->form_validation->set_rules('password', $this->lang->line('password'), 'required|min_length[8]|max_length[20]|matches[password_confirm]');
		$this->form_validation->set_rules('password_confirm', $this->lang->line('confirm_password'), 'required');

		if ($this->form_validation->run('companies/add_user') == true) {
			$active = $this->input->post('status');
			$notify = $this->input->post('notify');
			list($username, $domain) = explode("@", $this->input->post('email'));
			$email = strtolower($this->input->post('email'));
			$password = $this->input->post('password');
			$additional_data = array(
				'first_name' => $this->input->post('first_name'),
				'last_name' => $this->input->post('last_name'),
				'phone' => $this->input->post('phone'),
				'gender' => $this->input->post('gender'),
				'company_id' => $company->id,
				'company' => $company->company,
				'group_id' => 3
				);
			$this->load->library('ion_auth');
		} elseif ($this->input->post('add_user')) {
			$this->session->set_flashdata('error', validation_errors());
			redirect('suppliers');
		}

		if ($this->form_validation->run() == true && $this->ion_auth->register($username, $password, $email, $additional_data, $active, $notify)) {
			$this->session->set_flashdata('message', $this->lang->line("user_added"));
			redirect("suppliers");
		} else {
			$this->data['error'] = (validation_errors() ? validation_errors() : $this->session->flashdata('error'));
			$this->data['modal_js'] = $this->site->modal_js();
			$this->data['company'] = $company;
			$this->load->view($this->theme . 'suppliers/add_user', $this->data);
		}
	}

	function import_csv()
	{
		$this->erp->checkPermissions();
		$this->load->helper('security');
		$this->form_validation->set_rules('csv_file', $this->lang->line("upload_file"), 'xss_clean');

		if ($this->form_validation->run() == true) {

			if (DEMO) {
				$this->session->set_flashdata('warning', $this->lang->line("disabled_in_demo"));
				redirect($_SERVER["HTTP_REFERER"]);
			}

			if (isset($_FILES["csv_file"])) /* if($_FILES['userfile']['size'] > 0) */ {

				$this->load->library('upload');

				$config['upload_path'] = 'assets/uploads/csv/';
				$config['allowed_types'] = 'csv';
				$config['max_size'] = '15360';
				$config['overwrite'] = TRUE;

				$this->upload->initialize($config);

				if (!$this->upload->do_upload('csv_file')) {

					$error = $this->upload->display_errors();
					$this->session->set_flashdata('error', $error);
					redirect("suppliers");
				}

				$csv = $this->upload->file_name;

				$arrResult = array();
				$handle = fopen("assets/uploads/csv/" . $csv, "r");
				if ($handle) {
					while (($row = fgetcsv($handle, 5001, ",")) !== FALSE) {
						$arrResult[] = $row;
					}
					fclose($handle);
				}
				$titles = array_shift($arrResult);

				$keys = array('company', 'name', 'email', 'phone', 'address', 'city', 'state', 'postal_code', 'country', 'vat_no', 'cf1', 'cf2', 'cf3', 'cf4', 'cf5', 'cf6');

				$final = array();

				foreach ($arrResult as $key => $value) {
					$final[] = array_combine($keys, $value);
				}
				$rw = 2;
				foreach ($final as $csv) {
					if ($this->companies_model->getCompanyByEmail($csv['email'])) {
						$this->session->set_flashdata('error', $this->lang->line("check_supplier_email") . " (" . $csv['email'] . "). " . $this->lang->line("supplier_already_exist") . " (" . $this->lang->line("line_no") . " " . $rw . ")");
						redirect("suppliers");
					}
					$rw++;
				}
				foreach ($final as $record) {
					$record['group_id'] = 4;
					$record['group_name'] = 'supplier';
					$data[] = $record;
				}
                //$this->erp->print_arrays($data);
			}

		} elseif ($this->input->post('import')) {
			$this->session->set_flashdata('error', validation_errors());
			redirect('customers');
		}

		if ($this->form_validation->run() == true && !empty($data)) {
			if ($this->companies_model->addCompanies($data)) {
				$this->session->set_flashdata('message', $this->lang->line("suppliers_added"));
				redirect('suppliers');
			}
		} else {

			$this->data['error'] = (validation_errors() ? validation_errors() : $this->session->flashdata('error'));
			$this->data['modal_js'] = $this->site->modal_js();
			$this->load->view($this->theme . 'suppliers/import', $this->data);
		}
	}

	function delete($id = NULL)
	{
		$this->erp->checkPermissions(NULL, TRUE);

		if ($this->input->get('id')) {
			$id = $this->input->get('id');
		}

		if ($this->accounts_model->deleteChartAccount($id)) {
			echo $this->lang->line("deleted_chart_account");
		} else {
			$this->session->set_flashdata('warning', lang('chart_account_x_deleted_have_account'));
			die("<script type='text/javascript'>setTimeout(function(){ window.top.location.href = '" . (isset($_SERVER["HTTP_REFERER"]) ? $_SERVER["HTTP_REFERER"] : site_url('welcome')) . "'; }, 0);</script>");
		}
	}

	function suggestions($term = NULL, $limit = NULL)
	{
        // $this->erp->checkPermissions('index');
		if ($this->input->get('term')) {
			$term = $this->input->get('term', TRUE);
		}
		$limit = $this->input->get('limit', TRUE);
		$rows['results'] = $this->companies_model->getSupplierSuggestions($term, $limit);
		echo json_encode($rows);
	}

	function getSupplier($id = NULL)
	{
        // $this->erp->checkPermissions('index');
		$row = $this->companies_model->getCompanyByID($id);
		echo json_encode(array(array('id' => $row->id, 'text' => $row->company)));
	}

	function account_actions()
	{
		if (!$this->Owner) {
			$this->session->set_flashdata('warning', lang('access_denied'));
			redirect($_SERVER["HTTP_REFERER"]);
		}

		$this->form_validation->set_rules('form_action', lang("form_action"), 'required');

		if ($this->form_validation->run() == true) {

			if (!empty($_POST['val'])) {
				if ($this->input->post('form_action') == 'delete') {
					
					$error = false;
					foreach ($_POST['val'] as $id) {
						if (!$this->accounts_model->deleteChartAccount($id)) {
							$error = true;
						}
					}
					if ($error) {
						$this->session->set_flashdata('warning', lang('suppliers_x_deleted_have_purchases'));
					} else {
						$this->session->set_flashdata('message', $this->lang->line("account_deleted_successfully"));
					}
					redirect($_SERVER["HTTP_REFERER"]);
				}

				if ($this->input->post('form_action') == 'export_excel' || $this->input->post('form_action') == 'export_pdf') {

					$this->load->library('excel');
					$this->excel->setActiveSheetIndex(0);
					$this->excel->getActiveSheet()->setTitle(lang('account'));
					$this->excel->getActiveSheet()->SetCellValue('A1', lang('account_code'));
					$this->excel->getActiveSheet()->SetCellValue('B1', lang('account_name'));
					$this->excel->getActiveSheet()->SetCellValue('C1', lang('parent_account'));
					$this->excel->getActiveSheet()->SetCellValue('D1', lang('account_section'));

					$row = 2;
					foreach ($_POST['val'] as $id) {
						$account = $this->site->getAccountByID($id);
						$this->excel->getActiveSheet()->SetCellValue('A' . $row, $account->accountcode);
						$this->excel->getActiveSheet()->SetCellValue('B' . $row, $account->accountname);
						$this->excel->getActiveSheet()->SetCellValue('C' . $row, $account->parent_acc);
						$this->excel->getActiveSheet()->SetCellValue('D' . $row, $account->sectionname);
						$row++;
					}

					$this->excel->getActiveSheet()->getColumnDimension('A')->setWidth(20);
					$this->excel->getActiveSheet()->getColumnDimension('B')->setWidth(20);
					$this->excel->getActiveSheet()->getColumnDimension('C')->setWidth(20);
					$this->excel->getDefaultStyle()->getAlignment()->setVertical(PHPExcel_Style_Alignment::VERTICAL_CENTER);
					$filename = 'Account_' . date('Y_m_d_H_i_s');
					if ($this->input->post('form_action') == 'export_pdf') {
						$styleArray = array('borders' => array('allborders' => array('style' => PHPExcel_Style_Border::BORDER_THIN)));
						$this->excel->getDefaultStyle()->applyFromArray($styleArray);
						$this->excel->getActiveSheet()->getPageSetup()->setOrientation(PHPExcel_Worksheet_PageSetup::ORIENTATION_LANDSCAPE);
						require_once(APPPATH . "third_party" . DIRECTORY_SEPARATOR . "MPDF" . DIRECTORY_SEPARATOR . "mpdf.php");
						$rendererName = PHPExcel_Settings::PDF_RENDERER_MPDF;
						$rendererLibrary = 'MPDF';
						$rendererLibraryPath = APPPATH . 'third_party' . DIRECTORY_SEPARATOR . $rendererLibrary;
						if (!PHPExcel_Settings::setPdfRenderer($rendererName, $rendererLibraryPath)) {
							die('Please set the $rendererName: ' . $rendererName . ' and $rendererLibraryPath: ' . $rendererLibraryPath . ' values' .
								PHP_EOL . ' as appropriate for your directory structure');
						}

						header('Content-Type: application/pdf');
						header('Content-Disposition: attachment;filename="' . $filename . '.pdf"');
						header('Cache-Control: max-age=0');

						$objWriter = PHPExcel_IOFactory::createWriter($this->excel, 'PDF');
						return $objWriter->save('php://output');
					}
					if ($this->input->post('form_action') == 'export_excel') {
						header('Content-Type: application/vnd.ms-excel');
						header('Content-Disposition: attachment;filename="' . $filename . '.xls"');
						header('Cache-Control: max-age=0');

						$objWriter = PHPExcel_IOFactory::createWriter($this->excel, 'Excel5');
						return $objWriter->save('php://output');
					}

					redirect($_SERVER["HTTP_REFERER"]);
				}
			} else {
				$this->session->set_flashdata('error', $this->lang->line("no_supplier_selected"));
				redirect($_SERVER["HTTP_REFERER"]);
			}
		} else {
			$this->session->set_flashdata('error', validation_errors());
			redirect($_SERVER["HTTP_REFERER"]);
		}
	}
	
	function receivable_actions()
	{
		if (!$this->Owner) {
			$this->session->set_flashdata('warning', lang('access_denied'));
			redirect($_SERVER["HTTP_REFERER"]);
		}

		$this->form_validation->set_rules('form_action', lang("form_action"), 'required');

		if ($this->form_validation->run() == true) {

			if (!empty($_POST['val'])) {
				if ($this->input->post('form_action') == 'delete') {
					
					$error = false;
					foreach ($_POST['val'] as $id) {
						if (!$this->accounts_model->deleteChartAccount($id)) {
							$error = true;
						}
					}
					if ($error) {
						$this->session->set_flashdata('warning', lang('suppliers_x_deleted_have_purchases'));
					} else {
						$this->session->set_flashdata('message', $this->lang->line("account_deleted_successfully"));
					}
					redirect($_SERVER["HTTP_REFERER"]);
				}

				if ($this->input->post('form_action') == 'export_excel' || $this->input->post('form_action') == 'export_pdf') {

					$this->load->library('excel');
					$this->excel->setActiveSheetIndex(0);
					$this->excel->getActiveSheet()->setTitle(lang('acc_receivable'));
					$this->excel->getActiveSheet()->SetCellValue('A1', lang('date'));
					$this->excel->getActiveSheet()->SetCellValue('B1', lang('reference_no'));
					$this->excel->getActiveSheet()->SetCellValue('C1', lang('shop'));
					$this->excel->getActiveSheet()->SetCellValue('D1', lang('customer'));
					$this->excel->getActiveSheet()->SetCellValue('E1', lang('sale_status'));
					$this->excel->getActiveSheet()->SetCellValue('F1', lang('grand_total'));
					$this->excel->getActiveSheet()->SetCellValue('G1', lang('paid'));
					$this->excel->getActiveSheet()->SetCellValue('H1', lang('balance'));
					$this->excel->getActiveSheet()->SetCellValue('I1', lang('payment_status'));

					$row = 2;
					foreach ($_POST['val'] as $id) {
						$account = $this->site->getReceivableByID($id);
						$this->excel->getActiveSheet()->SetCellValue('A' . $row, $account->date);
						$this->excel->getActiveSheet()->SetCellValue('B' . $row, $account->reference_no);
						$this->excel->getActiveSheet()->SetCellValue('C' . $row, $account->biller);
						$this->excel->getActiveSheet()->SetCellValue('D' . $row, $account->customer);
						$this->excel->getActiveSheet()->SetCellValue('E' . $row, $account->sale_status);
						$this->excel->getActiveSheet()->SetCellValue('F' . $row, $account->grand_total);
						$this->excel->getActiveSheet()->SetCellValue('G' . $row, $account->paid);
						$this->excel->getActiveSheet()->SetCellValue('H' . $row, $account->balance);
						$this->excel->getActiveSheet()->SetCellValue('I' . $row, $account->payment_status);
						$row++;
					}

					$this->excel->getActiveSheet()->getColumnDimension('A')->setWidth(20);
					$this->excel->getActiveSheet()->getColumnDimension('B')->setWidth(20);
					$this->excel->getActiveSheet()->getColumnDimension('C')->setWidth(20);
					$this->excel->getDefaultStyle()->getAlignment()->setVertical(PHPExcel_Style_Alignment::VERTICAL_CENTER);
					$filename = 'Acc_Receivable_' . date('Y_m_d_H_i_s');
					if ($this->input->post('form_action') == 'export_pdf') {
						$styleArray = array('borders' => array('allborders' => array('style' => PHPExcel_Style_Border::BORDER_THIN)));
						$this->excel->getDefaultStyle()->applyFromArray($styleArray);
						$this->excel->getActiveSheet()->getPageSetup()->setOrientation(PHPExcel_Worksheet_PageSetup::ORIENTATION_LANDSCAPE);
						require_once(APPPATH . "third_party" . DIRECTORY_SEPARATOR . "MPDF" . DIRECTORY_SEPARATOR . "mpdf.php");
						$rendererName = PHPExcel_Settings::PDF_RENDERER_MPDF;
						$rendererLibrary = 'MPDF';
						$rendererLibraryPath = APPPATH . 'third_party' . DIRECTORY_SEPARATOR . $rendererLibrary;
						if (!PHPExcel_Settings::setPdfRenderer($rendererName, $rendererLibraryPath)) {
							die('Please set the $rendererName: ' . $rendererName . ' and $rendererLibraryPath: ' . $rendererLibraryPath . ' values' .
								PHP_EOL . ' as appropriate for your directory structure');
						}

						header('Content-Type: application/pdf');
						header('Content-Disposition: attachment;filename="' . $filename . '.pdf"');
						header('Cache-Control: max-age=0');

						$objWriter = PHPExcel_IOFactory::createWriter($this->excel, 'PDF');
						return $objWriter->save('php://output');
					}
					if ($this->input->post('form_action') == 'export_excel') {
						header('Content-Type: application/vnd.ms-excel');
						header('Content-Disposition: attachment;filename="' . $filename . '.xls"');
						header('Cache-Control: max-age=0');

						$objWriter = PHPExcel_IOFactory::createWriter($this->excel, 'Excel5');
						return $objWriter->save('php://output');
					}

					redirect($_SERVER["HTTP_REFERER"]);
				}
			} else {
				$this->session->set_flashdata('error', $this->lang->line("no_supplier_selected"));
				redirect($_SERVER["HTTP_REFERER"]);
			}
		} else {
			$this->session->set_flashdata('error', validation_errors());
			redirect($_SERVER["HTTP_REFERER"]);
		}
	}
	
	function reciept_actions()
	{
		if (!$this->Owner) {
			$this->session->set_flashdata('warning', lang('access_denied'));
			redirect($_SERVER["HTTP_REFERER"]);
		}

		$this->form_validation->set_rules('form_action', lang("form_action"), 'required');

		if ($this->form_validation->run() == true) {

			if (!empty($_POST['val'])) {
				if ($this->input->post('form_action') == 'delete') {
					
					$error = false;
					foreach ($_POST['val'] as $id) {
						if (!$this->accounts_model->deleteChartAccount($id)) {
							$error = true;
						}
					}
					if ($error) {
						$this->session->set_flashdata('warning', lang('suppliers_x_deleted_have_purchases'));
					} else {
						$this->session->set_flashdata('message', $this->lang->line("account_deleted_successfully"));
					}
					redirect($_SERVER["HTTP_REFERER"]);
				}

				if ($this->input->post('form_action') == 'export_excel' || $this->input->post('form_action') == 'export_pdf') {

					$this->load->library('excel');
					$this->excel->setActiveSheetIndex(0);
					$this->excel->getActiveSheet()->setTitle(lang('bill_reciept'));
					$this->excel->getActiveSheet()->SetCellValue('A1', lang('suspend'));
					$this->excel->getActiveSheet()->SetCellValue('B1', lang('date'));
					$this->excel->getActiveSheet()->SetCellValue('C1', lang('reference_no'));
					$this->excel->getActiveSheet()->SetCellValue('D1', lang('sale_ref'));
					$this->excel->getActiveSheet()->SetCellValue('E1', lang('customer'));
					$this->excel->getActiveSheet()->SetCellValue('F1', lang('paid_by'));
					$this->excel->getActiveSheet()->SetCellValue('G1', lang('amount'));
					$this->excel->getActiveSheet()->SetCellValue('H1', lang('type'));

					$row = 2;
					foreach ($_POST['val'] as $id) {
						$account = $this->site->getRecieptByID($id);
						$this->excel->getActiveSheet()->SetCellValue('A' . $row, $account->noted);
						$this->excel->getActiveSheet()->SetCellValue('B' . $row, $account->date);
						$this->excel->getActiveSheet()->SetCellValue('C' . $row, $account->payment_ref);
						$this->excel->getActiveSheet()->SetCellValue('D' . $row, $account->sale_ref);
						$this->excel->getActiveSheet()->SetCellValue('E' . $row, $account->customer);
						$this->excel->getActiveSheet()->SetCellValue('F' . $row, $account->paid_by);
						$this->excel->getActiveSheet()->SetCellValue('G' . $row, $account->amount);
						$this->excel->getActiveSheet()->SetCellValue('H' . $row, $account->type);
						$row++;
					}

					$this->excel->getActiveSheet()->getColumnDimension('A')->setWidth(20);
					$this->excel->getActiveSheet()->getColumnDimension('B')->setWidth(20);
					$this->excel->getActiveSheet()->getColumnDimension('C')->setWidth(20);
					$this->excel->getDefaultStyle()->getAlignment()->setVertical(PHPExcel_Style_Alignment::VERTICAL_CENTER);
					$filename = 'Bill_Reciept_' . date('Y_m_d_H_i_s');
					if ($this->input->post('form_action') == 'export_pdf') {
						$styleArray = array('borders' => array('allborders' => array('style' => PHPExcel_Style_Border::BORDER_THIN)));
						$this->excel->getDefaultStyle()->applyFromArray($styleArray);
						$this->excel->getActiveSheet()->getPageSetup()->setOrientation(PHPExcel_Worksheet_PageSetup::ORIENTATION_LANDSCAPE);
						require_once(APPPATH . "third_party" . DIRECTORY_SEPARATOR . "MPDF" . DIRECTORY_SEPARATOR . "mpdf.php");
						$rendererName = PHPExcel_Settings::PDF_RENDERER_MPDF;
						$rendererLibrary = 'MPDF';
						$rendererLibraryPath = APPPATH . 'third_party' . DIRECTORY_SEPARATOR . $rendererLibrary;
						if (!PHPExcel_Settings::setPdfRenderer($rendererName, $rendererLibraryPath)) {
							die('Please set the $rendererName: ' . $rendererName . ' and $rendererLibraryPath: ' . $rendererLibraryPath . ' values' .
								PHP_EOL . ' as appropriate for your directory structure');
						}

						header('Content-Type: application/pdf');
						header('Content-Disposition: attachment;filename="' . $filename . '.pdf"');
						header('Cache-Control: max-age=0');

						$objWriter = PHPExcel_IOFactory::createWriter($this->excel, 'PDF');
						return $objWriter->save('php://output');
					}
					if ($this->input->post('form_action') == 'export_excel') {
						header('Content-Type: application/vnd.ms-excel');
						header('Content-Disposition: attachment;filename="' . $filename . '.xls"');
						header('Cache-Control: max-age=0');

						$objWriter = PHPExcel_IOFactory::createWriter($this->excel, 'Excel5');
						return $objWriter->save('php://output');
					}

					redirect($_SERVER["HTTP_REFERER"]);
				}
			} else {
				$this->session->set_flashdata('error', $this->lang->line("no_supplier_selected"));
				redirect($_SERVER["HTTP_REFERER"]);
			}
		} else {
			$this->session->set_flashdata('error', validation_errors());
			redirect($_SERVER["HTTP_REFERER"]);
		}
	}
	
	function payable_actions()
	{
		if (!$this->Owner) {
			$this->session->set_flashdata('warning', lang('access_denied'));
			redirect($_SERVER["HTTP_REFERER"]);
		}

		$this->form_validation->set_rules('form_action', lang("form_action"), 'required');

		if ($this->form_validation->run() == true) {

			if (!empty($_POST['val'])) {
				if ($this->input->post('form_action') == 'delete') {
					
					$error = false;
					foreach ($_POST['val'] as $id) {
						if (!$this->accounts_model->deleteChartAccount($id)) {
							$error = true;
						}
					}
					if ($error) {
						$this->session->set_flashdata('warning', lang('suppliers_x_deleted_have_purchases'));
					} else {
						$this->session->set_flashdata('message', $this->lang->line("account_deleted_successfully"));
					}
					redirect($_SERVER["HTTP_REFERER"]);
				}

				if ($this->input->post('form_action') == 'export_excel' || $this->input->post('form_action') == 'export_pdf') {

					$this->load->library('excel');
					$this->excel->setActiveSheetIndex(0);
					$this->excel->getActiveSheet()->setTitle(lang('acc_payable'));
					$this->excel->getActiveSheet()->SetCellValue('A1', lang('date'));
					$this->excel->getActiveSheet()->SetCellValue('B1', lang('reference_no'));
					$this->excel->getActiveSheet()->SetCellValue('C1', lang('supplier'));
					$this->excel->getActiveSheet()->SetCellValue('D1', lang('purchase_status'));
					$this->excel->getActiveSheet()->SetCellValue('E1', lang('grand_total'));
					$this->excel->getActiveSheet()->SetCellValue('F1', lang('paid'));
					$this->excel->getActiveSheet()->SetCellValue('G1', lang('balance'));
					$this->excel->getActiveSheet()->SetCellValue('H1', lang('payment_status'));

					$row = 2;
					foreach ($_POST['val'] as $id) {
						$account = $this->site->getPayableByID($id);
						$this->excel->getActiveSheet()->SetCellValue('A' . $row, $account->date);
						$this->excel->getActiveSheet()->SetCellValue('B' . $row, $account->reference_no);
						$this->excel->getActiveSheet()->SetCellValue('C' . $row, $account->supplier);
						$this->excel->getActiveSheet()->SetCellValue('D' . $row, $account->status);
						$this->excel->getActiveSheet()->SetCellValue('E' . $row, $account->grand_total);
						$this->excel->getActiveSheet()->SetCellValue('F' . $row, $account->paid);
						$this->excel->getActiveSheet()->SetCellValue('G' . $row, $account->balance);
						$this->excel->getActiveSheet()->SetCellValue('H' . $row, $account->payment_status);
						$row++;
					}

					$this->excel->getActiveSheet()->getColumnDimension('A')->setWidth(20);
					$this->excel->getActiveSheet()->getColumnDimension('B')->setWidth(20);
					$this->excel->getActiveSheet()->getColumnDimension('C')->setWidth(20);
					$this->excel->getDefaultStyle()->getAlignment()->setVertical(PHPExcel_Style_Alignment::VERTICAL_CENTER);
					$filename = 'Acc_Payable_' . date('Y_m_d_H_i_s');
					if ($this->input->post('form_action') == 'export_pdf') {
						$styleArray = array('borders' => array('allborders' => array('style' => PHPExcel_Style_Border::BORDER_THIN)));
						$this->excel->getDefaultStyle()->applyFromArray($styleArray);
						$this->excel->getActiveSheet()->getPageSetup()->setOrientation(PHPExcel_Worksheet_PageSetup::ORIENTATION_LANDSCAPE);
						require_once(APPPATH . "third_party" . DIRECTORY_SEPARATOR . "MPDF" . DIRECTORY_SEPARATOR . "mpdf.php");
						$rendererName = PHPExcel_Settings::PDF_RENDERER_MPDF;
						$rendererLibrary = 'MPDF';
						$rendererLibraryPath = APPPATH . 'third_party' . DIRECTORY_SEPARATOR . $rendererLibrary;
						if (!PHPExcel_Settings::setPdfRenderer($rendererName, $rendererLibraryPath)) {
							die('Please set the $rendererName: ' . $rendererName . ' and $rendererLibraryPath: ' . $rendererLibraryPath . ' values' .
								PHP_EOL . ' as appropriate for your directory structure');
						}

						header('Content-Type: application/pdf');
						header('Content-Disposition: attachment;filename="' . $filename . '.pdf"');
						header('Cache-Control: max-age=0');

						$objWriter = PHPExcel_IOFactory::createWriter($this->excel, 'PDF');
						return $objWriter->save('php://output');
					}
					if ($this->input->post('form_action') == 'export_excel') {
						header('Content-Type: application/vnd.ms-excel');
						header('Content-Disposition: attachment;filename="' . $filename . '.xls"');
						header('Cache-Control: max-age=0');

						$objWriter = PHPExcel_IOFactory::createWriter($this->excel, 'Excel5');
						return $objWriter->save('php://output');
					}

					redirect($_SERVER["HTTP_REFERER"]);
				}
			} else {
				$this->session->set_flashdata('error', $this->lang->line("no_supplier_selected"));
				redirect($_SERVER["HTTP_REFERER"]);
			}
		} else {
			$this->session->set_flashdata('error', validation_errors());
			redirect($_SERVER["HTTP_REFERER"]);
		}
	}
	
	function journal_actions()
	{
		if (!$this->Owner) {
			$this->session->set_flashdata('warning', lang('access_denied'));
			redirect($_SERVER["HTTP_REFERER"]);
		}

		$this->form_validation->set_rules('form_action', lang("form_action"), 'required');

		if ($this->form_validation->run() == true) {

			if (!empty($_POST['val'])) {
				if ($this->input->post('form_action') == 'delete') {
					
					$error = false;
					foreach ($_POST['val'] as $id) {
						if (!$this->accounts_model->deleteChartAccount($id)) {
							$error = true;
						}
					}
					if ($error) {
						$this->session->set_flashdata('warning', lang('suppliers_x_deleted_have_purchases'));
					} else {
						$this->session->set_flashdata('message', $this->lang->line("account_deleted_successfully"));
					}
					redirect($_SERVER["HTTP_REFERER"]);
				}

				if ($this->input->post('form_action') == 'export_excel' || $this->input->post('form_action') == 'export_pdf') {

					$this->load->library('excel');
					$this->excel->setActiveSheetIndex(0);
					$this->excel->getActiveSheet()->setTitle(lang('journal'));
					$this->excel->getActiveSheet()->SetCellValue('A1', lang('journal_no'));
					$this->excel->getActiveSheet()->SetCellValue('B1', lang('type'));
					$this->excel->getActiveSheet()->SetCellValue('C1', lang('date'));
					$this->excel->getActiveSheet()->SetCellValue('D1', lang('reference_no'));
					$this->excel->getActiveSheet()->SetCellValue('E1', lang('account_code'));
					$this->excel->getActiveSheet()->SetCellValue('F1', lang('account_name'));
					$this->excel->getActiveSheet()->SetCellValue('G1', lang('description'));
					$this->excel->getActiveSheet()->SetCellValue('H1', lang('debit'));
					$this->excel->getActiveSheet()->SetCellValue('I1', lang('credit'));

					$row = 2;
					foreach ($_POST['val'] as $id) {
						$account = $this->site->getJournalByID($id);
						$this->excel->getActiveSheet()->SetCellValue('A' . $row, $account->g_tran_no);
						$this->excel->getActiveSheet()->SetCellValue('B' . $row, $account->tran_type);
						$this->excel->getActiveSheet()->SetCellValue('C' . $row, $account->tran_date);
						$this->excel->getActiveSheet()->SetCellValue('D' . $row, $account->reference_no);
						$this->excel->getActiveSheet()->SetCellValue('E' . $row, $account->account_code);
						$this->excel->getActiveSheet()->SetCellValue('F' . $row, $account->narrative);
						$this->excel->getActiveSheet()->SetCellValue('G' . $row, $account->description);
						$this->excel->getActiveSheet()->SetCellValue('H' . $row, $account->debit);
						$this->excel->getActiveSheet()->SetCellValue('I' . $row, $account->credit);
						$row++;
					}

					$this->excel->getActiveSheet()->getColumnDimension('A')->setWidth(20);
					$this->excel->getActiveSheet()->getColumnDimension('B')->setWidth(20);
					$this->excel->getActiveSheet()->getColumnDimension('C')->setWidth(20);
					$this->excel->getDefaultStyle()->getAlignment()->setVertical(PHPExcel_Style_Alignment::VERTICAL_CENTER);
					$filename = 'Journal_' . date('Y_m_d_H_i_s');
					if ($this->input->post('form_action') == 'export_pdf') {
						$styleArray = array('borders' => array('allborders' => array('style' => PHPExcel_Style_Border::BORDER_THIN)));
						$this->excel->getDefaultStyle()->applyFromArray($styleArray);
						$this->excel->getActiveSheet()->getPageSetup()->setOrientation(PHPExcel_Worksheet_PageSetup::ORIENTATION_LANDSCAPE);
						require_once(APPPATH . "third_party" . DIRECTORY_SEPARATOR . "MPDF" . DIRECTORY_SEPARATOR . "mpdf.php");
						$rendererName = PHPExcel_Settings::PDF_RENDERER_MPDF;
						$rendererLibrary = 'MPDF';
						$rendererLibraryPath = APPPATH . 'third_party' . DIRECTORY_SEPARATOR . $rendererLibrary;
						if (!PHPExcel_Settings::setPdfRenderer($rendererName, $rendererLibraryPath)) {
							die('Please set the $rendererName: ' . $rendererName . ' and $rendererLibraryPath: ' . $rendererLibraryPath . ' values' .
								PHP_EOL . ' as appropriate for your directory structure');
						}

						header('Content-Type: application/pdf');
						header('Content-Disposition: attachment;filename="' . $filename . '.pdf"');
						header('Cache-Control: max-age=0');

						$objWriter = PHPExcel_IOFactory::createWriter($this->excel, 'PDF');
						return $objWriter->save('php://output');
					}
					if ($this->input->post('form_action') == 'export_excel') {
						header('Content-Type: application/vnd.ms-excel');
						header('Content-Disposition: attachment;filename="' . $filename . '.xls"');
						header('Cache-Control: max-age=0');

						$objWriter = PHPExcel_IOFactory::createWriter($this->excel, 'Excel5');
						return $objWriter->save('php://output');
					}

					redirect($_SERVER["HTTP_REFERER"]);
				}
			} else {
				$this->session->set_flashdata('error', $this->lang->line("no_supplier_selected"));
				redirect($_SERVER["HTTP_REFERER"]);
			}
		} else {
			$this->session->set_flashdata('error', validation_errors());
			redirect($_SERVER["HTTP_REFERER"]);
		}
	}

	function import_journal_csv()
	{
		$this->erp->checkPermissions();
		$this->load->helper('security');
		$this->form_validation->set_rules('csv_file', $this->lang->line("upload_file"), 'xss_clean');

		if ($this->form_validation->run() == true) {

			if (DEMO) {
				$this->session->set_flashdata('warning', $this->lang->line("disabled_in_demo"));
				redirect($_SERVER["HTTP_REFERER"]);
			}

			if (isset($_FILES["csv_file"])) /* if($_FILES['userfile']['size'] > 0) */ {

				$this->load->library('upload');

				$config['upload_path'] = 'assets/uploads/csv/';
				$config['allowed_types'] = 'csv';
				$config['max_size'] = '15360';
				$config['overwrite'] = TRUE;

				$this->upload->initialize($config);

				if (!$this->upload->do_upload('csv_file')) {

					$error = $this->upload->display_errors();
					$this->session->set_flashdata('error', $error);
					redirect("account/listJournal");
				}

				$csv = $this->upload->file_name;

				$arrResult = array();
				$handle = fopen("assets/uploads/csv/" . $csv, "r");
				if ($handle) {
					while (($row = fgetcsv($handle, 5001, ",")) !== FALSE) {
						$arrResult[] = $row;
					}
					fclose($handle);
				}
				$titles = array_shift($arrResult);

				$keys = array('tran_type', 'tran_no', 'tran_date','account_code', 'narrative', 'amount', 'reference_no', 'description', 'biller_id', 'created_by');

				$final = array();

				foreach ($arrResult as $key => $value) {
					$final[] = array_combine($keys, $value);
				}
                /*$rw = 2;
                foreach ($final as $csv) {
                    if ($this->companies_model->getCompanyByEmail($csv['email'])) {
                        $this->session->set_flashdata('error', $this->lang->line("check_supplier_email") . " (" . $csv['email'] . "). " . $this->lang->line("supplier_already_exist") . " (" . $this->lang->line("line_no") . " " . $rw . ")");
                        redirect("suppliers");
                    }
                    $rw++;
                }*/
                foreach ($final as $record) {    

                	$record['sectionid'] = $this->accounts_model->getSectionIdByCode($record['account_code'])->sectionid;
					//$date = strtr($record['tran_date'], '/', '-');
                	$record['tran_date'] = date('Y-m-d h:m:i', strtotime($record['tran_date']));
                	$data[] = $record;
                }
                //$this->erp->print_arrays($data);
            }

        } 

        if ($this->form_validation->run() == true && !empty($data)) {
        	if ($this->accounts_model->addJournals($data)) {
        		$this->session->set_flashdata('message', $this->lang->line("journal_added"));
        		redirect('account/listJournal');
        	}
        } else {

        	$this->data['error'] = (validation_errors() ? validation_errors() : $this->session->flashdata('error'));
        	$this->data['modal_js'] = $this->site->modal_js();
        	$this->load->view($this->theme . 'accounts/import_journal_csv', $this->data);
        }
    }

    function import_chart_csv()
    {
    	$this->erp->checkPermissions();
    	$this->load->helper('security');
    	$this->form_validation->set_rules('csv_file', $this->lang->line("upload_file"), 'xss_clean');

    	if ($this->form_validation->run() == true) {

    		if (DEMO) {
    			$this->session->set_flashdata('warning', $this->lang->line("disabled_in_demo"));
    			redirect($_SERVER["HTTP_REFERER"]);
    		}

    		if (isset($_FILES["csv_file"])) /* if($_FILES['userfile']['size'] > 0) */ {

    			$this->load->library('upload');

    			$config['upload_path'] = 'assets/uploads/csv/';
    			$config['allowed_types'] = 'csv';
    			$config['max_size'] = '15360';
    			$config['overwrite'] = TRUE;

    			$this->upload->initialize($config);

    			if (!$this->upload->do_upload('csv_file')) {

    				$error = $this->upload->display_errors();
    				$this->session->set_flashdata('error', $error);
    				redirect("account");
    			}

    			$csv = $this->upload->file_name;

    			$arrResult = array();
    			$handle = fopen("assets/uploads/csv/" . $csv, "r");
    			if ($handle) {
    				while (($row = fgetcsv($handle, 5001, ",")) !== FALSE) {
    					$arrResult[] = $row;
    				}
    				fclose($handle);
    			}
    			$titles = array_shift($arrResult);

    			$keys = array('accountcode','accountname','parent_acc','sectionid','bank','account_tax_id','acc_level','lineage');

    			$final = array();

    			foreach ($arrResult as $key => $value) {
    				$final[] = array_combine($keys, $value);
    			}
                /*$rw = 2;
                foreach ($final as $csv) {
                    if ($this->companies_model->getCompanyByEmail($csv['email'])) {
                        $this->session->set_flashdata('error', $this->lang->line("check_supplier_email") . " (" . $csv['email'] . "). " . $this->lang->line("supplier_already_exist") . " (" . $this->lang->line("line_no") . " " . $rw . ")");
                        redirect("suppliers");
                    }
                    $rw++;
                }*/
                foreach ($final as $record) {             
                	$data[] = $record;
                }
                //$this->erp->print_arrays($data);
            }

        } 

        if ($this->form_validation->run() == true && !empty($data)) {
        	if ($this->accounts_model->addCharts($data)) {
        		$this->session->set_flashdata('message', $this->lang->line("Chart_Account_Added"));
        		redirect('account');
        	}
        } else {

        	$this->data['error'] = (validation_errors() ? validation_errors() : $this->session->flashdata('error'));
        	$this->data['modal_js'] = $this->site->modal_js();
        	$this->load->view($this->theme . 'accounts/import_chart_csv', $this->data);
        }
    }

    /* Check Account Code */
    public function checkAccount(){
    	$accountcode = $this->input->get('code', TRUE);
    	$row = $this->accounts_model->getAccountCode($accountcode);
    	if ($row) {
    		echo 1;
    	} else {
    		echo 0;
    	}
    }
    /*selling tax*/
    function selling_tax()
    {
    	$this->erp->checkPermissions();
    	$this->load->model('reports_model');



    	$this->data['users'] = $this->reports_model->getStaff();
    	$this->data['warehouses'] = $this->site->getAllWarehouses();
    	$this->data['billers'] = $this->site->getAllCompanies('biller');

    	$this->data['error'] = (validation_errors()) ? validation_errors() : $this->session->flashdata('error');
    	if ($this->Owner || $this->Admin) {
    		$this->data['warehouses'] = $this->site->getAllWarehouses();
    		$this->data['warehouse_id'] = $warehouse_id;
    		$this->data['warehouse'] = $warehouse_id ? $this->site->getWarehouseByID($warehouse_id) : NULL;
    	} else {
    		$this->data['warehouses'] = NULL;
    		$this->data['warehouse_id'] = $this->session->userdata('warehouse_id');
    		$this->data['warehouse'] = $this->session->userdata('warehouse_id') ? $this->site->getWarehouseByID($this->session->userdata('warehouse_id')) : NULL;
    	}


    	$bc = array(array('link' => base_url(), 'page' => lang('home')), array('link' => '#', 'page' => lang('selling_tax')));
    	$meta = array('page_title' => lang('selling_tax'), 'bc' => $bc);
    	$this->page_construct('accounts/selling_tax', $meta, $this->data);
    }

    /*export selling tax*/
    function selling_actions(){
    	if (!$this->Owner) {
    		$this->session->set_flashdata('warning', lang('access_denied'));
    		redirect($_SERVER["HTTP_REFERER"]);
    	}

    	$this->form_validation->set_rules('form_action', lang("form_action"), 'required');

    	if ($this->form_validation->run() == true) {

    		if (!empty($_POST['val'])) {
    			if ($this->input->post('form_action') == 'delete') {

    				$error = false;
    				foreach ($_POST['val'] as $id) {
    					if (!$this->accounts_model->deleteChartAccount($id)) {
    						$error = true;
    					}
    				}
    				if ($error) {
    					$this->session->set_flashdata('warning', lang('suppliers_x_deleted_have_purchases'));
    				} else {
    					$this->session->set_flashdata('message', $this->lang->line("account_deleted_successfully"));
    				}
    				redirect($_SERVER["HTTP_REFERER"]);
    			}

    			if ($this->input->post('form_action') == 'export_excel' || $this->input->post('form_action') == 'export_pdf') {

    				$this->load->library('excel');
    				$this->excel->setActiveSheetIndex(0);
    				$this->excel->getActiveSheet()->setTitle(lang('selling_tax'));
    				$this->excel->getActiveSheet()->SetCellValue('A1', lang('date'));
    				$this->excel->getActiveSheet()->SetCellValue('B1', lang('reference_no'));
    				$this->excel->getActiveSheet()->SetCellValue('C1', lang('biller'));
    				$this->excel->getActiveSheet()->SetCellValue('D1', lang('customer'));
    				$this->excel->getActiveSheet()->SetCellValue('E1', lang('sale_status'));
    				$this->excel->getActiveSheet()->SetCellValue('F1', lang('grand_total'));
    				$this->excel->getActiveSheet()->SetCellValue('G1', lang('paid'));
    				$this->excel->getActiveSheet()->SetCellValue('H1', lang('balance'));
    				$this->excel->getActiveSheet()->SetCellValue('I1', lang('payment_status'));

    				$row = 2;
    				foreach ($_POST['val'] as $id) {
    					$account = $this->site->getSellingByID($id);
    					$this->excel->getActiveSheet()->SetCellValue('A' . $row, $account->date);
    					$this->excel->getActiveSheet()->SetCellValue('B' . $row, $account->reference_no);
    					$this->excel->getActiveSheet()->SetCellValue('C' . $row, $account->biller);
    					$this->excel->getActiveSheet()->SetCellValue('D' . $row, $account->customer);
    					$this->excel->getActiveSheet()->SetCellValue('E' . $row, $account->sale_status);
    					$this->excel->getActiveSheet()->SetCellValue('F' . $row, $account->grand_total);
    					$this->excel->getActiveSheet()->SetCellValue('G' . $row, $account->paid);
    					$this->excel->getActiveSheet()->SetCellValue('H' . $row, $account->balance);
    					$this->excel->getActiveSheet()->SetCellValue('I' . $row, $account->payment_status);
    					$row++;
    				}

    				$this->excel->getActiveSheet()->getColumnDimension('A')->setWidth(20);
    				$this->excel->getActiveSheet()->getColumnDimension('B')->setWidth(20);
    				$this->excel->getActiveSheet()->getColumnDimension('C')->setWidth(20);
    				$this->excel->getDefaultStyle()->getAlignment()->setVertical(PHPExcel_Style_Alignment::VERTICAL_CENTER);
    				$filename = 'Selling_Tax_' . date('Y_m_d_H_i_s');
    				if ($this->input->post('form_action') == 'export_pdf') {
    					$styleArray = array('borders' => array('allborders' => array('style' => PHPExcel_Style_Border::BORDER_THIN)));
    					$this->excel->getDefaultStyle()->applyFromArray($styleArray);
    					$this->excel->getActiveSheet()->getPageSetup()->setOrientation(PHPExcel_Worksheet_PageSetup::ORIENTATION_LANDSCAPE);
    					require_once(APPPATH . "third_party" . DIRECTORY_SEPARATOR . "MPDF" . DIRECTORY_SEPARATOR . "mpdf.php");
    					$rendererName = PHPExcel_Settings::PDF_RENDERER_MPDF;
    					$rendererLibrary = 'MPDF';
    					$rendererLibraryPath = APPPATH . 'third_party' . DIRECTORY_SEPARATOR . $rendererLibrary;
    					if (!PHPExcel_Settings::setPdfRenderer($rendererName, $rendererLibraryPath)) {
    						die('Please set the $rendererName: ' . $rendererName . ' and $rendererLibraryPath: ' . $rendererLibraryPath . ' values' .
    							PHP_EOL . ' as appropriate for your directory structure');
    					}

    					header('Content-Type: application/pdf');
    					header('Content-Disposition: attachment;filename="' . $filename . '.pdf"');
    					header('Cache-Control: max-age=0');

    					$objWriter = PHPExcel_IOFactory::createWriter($this->excel, 'PDF');
    					return $objWriter->save('php://output');
    				}
    				if ($this->input->post('form_action') == 'export_excel') {
    					header('Content-Type: application/vnd.ms-excel');
    					header('Content-Disposition: attachment;filename="' . $filename . '.xls"');
    					header('Cache-Control: max-age=0');

    					$objWriter = PHPExcel_IOFactory::createWriter($this->excel, 'Excel5');
    					return $objWriter->save('php://output');
    				}

    				redirect($_SERVER["HTTP_REFERER"]);
    			}
    		} else {
    			$this->session->set_flashdata('error', $this->lang->line("no_supplier_selected"));
    			redirect($_SERVER["HTTP_REFERER"]);
    		}
    	} else {
    		$this->session->set_flashdata('error', validation_errors());
    		redirect($_SERVER["HTTP_REFERER"]);
    	}
    }
    /* purchasing tax */
    function purchasing_tax()
    {
    	$this->erp->checkPermissions();
    	$this->load->model('reports_model');

    	if(isset($_GET['d']) != ""){
    		$date = $_GET['d'];
    		$this->data['date'] = $date;
    	}

    	$this->data['users'] = $this->reports_model->getStaff();
    	$this->data['error'] = (validation_errors()) ? validation_errors() : $this->session->flashdata('error');
    	if ($this->Owner || $this->Admin || !$this->session->userdata('warehouse_id')) {
    		$this->data['warehouses'] = $this->site->getAllWarehouses();
    		$this->data['warehouse_id'] = $warehouse_id;
    		$this->data['warehouse'] = $warehouse_id ? $this->site->getWarehouseByID($warehouse_id) : null;
    	} else {
    		$this->data['warehouses'] = null;
    		$this->data['warehouse_id'] = $this->session->userdata('warehouse_id');
    		$this->data['warehouse'] = $this->session->userdata('warehouse_id') ? $this->site->getWarehouseByID($this->session->userdata('warehouse_id')) : null;
    	}

    	$bc = array(array('link' => base_url(), 'page' => lang('home')), array('link' => '#', 'page' => lang('purchasing_tax')));
    	$meta = array('page_title' => lang('purchasing_tax'), 'bc' => $bc);
    	$this->page_construct('accounts/purchasing_tax', $meta, $this->data);
    }

    function deposits($action = NULL)
    {
    	$this->erp->checkPermissions('index', true, 'accounts');

    	$this->data['error'] = (validation_errors()) ? validation_errors() : $this->session->flashdata('error');
    	$this->data['action'] = $action;
    	$bc = array(array('link' => base_url(), 'page' => lang('home')), array('link' => '#', 'page' => lang('accounts')));
    	$meta = array('page_title' => lang('customer_deposits'), 'bc' => $bc);
    	$this->page_construct('accounts/deposits', $meta, $this->data);
    }

    public function getDeposits(){

    	$return_deposit = anchor('customers/return_deposit/$1', '<i class="fa fa-reply"></i> ' . lang('return_deposit'), 'data-toggle="modal" data-target="#myModal2"');
    	$deposit_note = anchor('customers/deposit_note/$1', '<i class="fa fa-file-text-o"></i> ' . lang('deposit_note'), 'data-toggle="modal" data-target="#myModal2"');
    	$edit_deposit = anchor('customers/edit_deposit/$1', '<i class="fa fa-edit"></i> ' . lang('edit_deposit'), 'data-toggle="modal" data-target="#myModal2"');
    	$delete_deposit = "<a href='#' class='po' title='<b>" . lang("delete_deposit") . "</b>' data-content=\"<p>"
    	. lang('r_u_sure') . "</p><a class='btn btn-danger po-delete' href='" . site_url('customers/delete_deposit/$1') . "'>"
    	. lang('i_m_sure') . "</a> <button class='btn po-close'>" . lang('no') . "</button>\"  rel='popover'><i class=\"fa fa-trash-o\"></i> "
    	. lang('delete_deposit') . "</a>";

    	$action = '<div class="text-center"><div class="btn-group text-left">'
    	. '<button type="button" class="btn btn-default btn-xs btn-primary dropdown-toggle" data-toggle="dropdown">'
    	. lang('actions') . ' <span class="caret"></span></button>
    	<ul class="dropdown-menu pull-right" role="menu">
    		<li>' . $deposit_note . '</li>
    		<li>' . $edit_deposit . '</li>
    		<li>' . $return_deposit . '</li>
    		<li>' . $delete_deposit . '</li>
    		<ul>
    		</div></div>';

    		$this->load->library('datatables');
    		$this->datatables
    		->select("deposits.id as dep_id, companies.id AS id , deposits.date,companies.name, deposits.amount, deposits.paid_by, CONCAT({$this->db->dbprefix('users')}.first_name, ' ', {$this->db->dbprefix('users')}.last_name) as created_by", false)
    		->from("deposits")
			->join('companies', 'companies.id = deposits.company_id', 'left')
    		->join('users', 'users.id=deposits.created_by', 'left')
    		->where('deposits.amount <>', 0)
			->where('companies.group_name', 'customer')
    		->add_column("Actions", $action, "dep_id")
			->unset_column('dep_id');

    		echo $this->datatables->generate();
    }

	// theng add//
	public function exchange_rate_tax(){
		$this->erp->checkPermissions('index', true, 'accounts');

		$this->data['error'] = (validation_errors()) ? validation_errors() : $this->session->flashdata('error');
		$this->data['action'] = $action;
		$this->data['condition_tax']=$this->accounts_model->getConditionTax();
		$bc = array(array('link' => base_url(), 'page' => lang('home')), array('link' => '#', 'page' => lang('accounts')));
		$meta = array('page_title' => lang('exchange_rate_tax'), 'bc' => $bc);
		$this->page_construct('accounts/exchange_rate_tax', $meta, $this->data);
	}
	public function edit_condition_tax($id){
		$this->erp->checkPermissions(false, true);

		$this->data['condition_tax'] = $this->accounts_model->getConditionTaxById($id);
		$this->data['error'] = (validation_errors() ? validation_errors() : $this->session->flashdata('error'));
		$this->data['modal_js'] = $this->site->modal_js();
		$this->load->view($this->theme . 'accounts/edit_condition_tax', $this->data);
	}
	function update_exchange_tax_rate($id){
		$data=array(
			'rate'=>$this->input->post('rate')
			);
		$update=$this->accounts_model->update_exchange_tax_rate($id,$data);
		if($update){
			redirect('account/exchange_rate_tax');
		}
	}
	
	function condition_tax(){
		$this->erp->checkPermissions();
		$this->form_validation->set_rules('name', $this->lang->line("name"), 'required');

		if ($this->form_validation->run('account/add_condition_tax') == true) {
			
			$data = array(
				'code' => 'Salary',
				'name' => $this->input->post('name'),
				'rate' => $this->input->post('rate'),
				'reduct_tax' => $this->input->post('reduct_tax'),
				'min_salary' => $this->input->post('min_salary'),
				'max_salary' => $this->input->post('max_salary')
			);
			//$this->erp->print_arrays($data);
		}

		if ($this->form_validation->run() == true && $this->accounts_model->addConditionTax($data)) {
			$this->session->set_flashdata('message', $this->lang->line("condition_tax_added"));
			redirect('account/condition_tax');
		} else {
			$this->data['error'] = (validation_errors()) ? validation_errors() : $this->session->flashdata('error');
			$bc = array(array('link' => base_url(), 'page' => lang('home')), array('link' => '#', 'page' => lang('accounts')));
			$meta = array('page_title' => lang('condition_tax'), 'bc' => $bc);
			$this->page_construct('accounts/condition_tax', $meta, $this->data);
		}
	}
	
	function getConditionTax(){
		$this->erp->checkPermissions('index', true, 'accounts');

		$this->load->library('datatables');
		$this->datatables->select("id,code, name, rate, min_salary, max_salary, reduct_tax")
		->from("condition_tax")
		->where("code", "Salary")
		->add_column("Actions", "<center><a class=\"tip\" title='" . $this->lang->line("edit_condition_tax") . "' href='" . site_url('account/edit_condition/$1') . "' data-toggle='modal' data-target='#myModal'><i class=\"fa fa-edit\"></i></a>  <a href='#' class='tip po' title='<b>" . $this->lang->line("delete_condition_tax") . "</b>' data-content=\"<p>" . lang('r_u_sure') . "</p><a class='btn btn-danger po-delete' href='" . site_url('account/delete_condition_tax/$1') . "'>" . lang('i_m_sure') . "</a> <button class='btn po-close'>" . lang('no') . "</button>\"  rel='popover'><i class=\"fa fa-trash-o\"></i></a></center>", "id");
		echo $this->datatables->generate();
	}

	function add_condition_tax()
	{
		$this->data['error'] = (validation_errors() ? validation_errors() : $this->session->flashdata('error'));
		$this->data['modal_js'] = $this->site->modal_js();
		$this->load->view($this->theme . 'accounts/add_condition_tax', $this->data);
	}
	
	function edit_condition($id = null){
		$this->erp->checkPermissions();
		$this->form_validation->set_rules('name', $this->lang->line("name"), 'required');
		if ($this->form_validation->run('account/edit_condition_tax') == true) {
			$data = array(
				'code' => 'Salary',
				'name' => $this->input->post('name'),
				'rate' => $this->input->post('rate'),
				'reduct_tax' => $this->input->post('reduct_tax'),
				'min_salary' => $this->input->post('min_salary'),
				'max_salary' => $this->input->post('max_salary')
			);
			//$this->erp->print_arrays($data);
			$ids = $this->input->post('id');
		}
		if ($this->form_validation->run() == true && $this->accounts_model->update_exchange_tax_rate($ids,$data)) {
			$this->session->set_flashdata('message', $this->lang->line("condition_tax_updateed"));
			redirect('account/condition_tax');
		} else {
			$this->data['error'] = (validation_errors() ? validation_errors() : $this->session->flashdata('error'));
			$this->data['modal_js'] = $this->site->modal_js();
			$this->data['id'] = $id;
			$this->data['data'] = $this->accounts_model->getConditionTaxById($id);
			$this->load->view($this->theme . 'accounts/update_condition_tax', $this->data);
		}
	}
	// end theng add
	function delete_condition_tax($id){
		$this->erp->checkPermissions();

		if ($this->accounts_model->deleteConditionTax($id)) {
			$this->session->set_flashdata('message', $this->lang->line("condition_tax_deleted"));
			redirect('account/condition_tax');
		} else {
			$this->session->set_flashdata('message', $this->lang->line("connot_deleted"));
			redirect('account/condition_tax');
		}
	}
	
	public function deposits_action(){
		if (!$this->Owner) {
            $this->session->set_flashdata('warning', lang('access_denied'));
            redirect($_SERVER["HTTP_REFERER"]);
        }

        $this->form_validation->set_rules('form_action', lang("form_action"), 'required');

        if ($this->form_validation->run() == true) {

            if (!empty($_POST['val'])) {
				
				//print_r($_POST['val']);
				//die();
				
                if ($this->input->post('form_action') == 'export_excel' || $this->input->post('form_action') == 'export_pdf') {

                    $this->load->library('excel');
                    $this->excel->setActiveSheetIndex(0);
                    $this->excel->getActiveSheet()->setTitle(lang('deposits'));
                    $this->excel->getActiveSheet()->SetCellValue('A1', lang('date'));
                    $this->excel->getActiveSheet()->SetCellValue('B1', lang('customer'));
					$this->excel->getActiveSheet()->SetCellValue('C1', lang('amount'));
                    $this->excel->getActiveSheet()->SetCellValue('D1', lang('paid_by'));
                    $this->excel->getActiveSheet()->SetCellValue('E1', lang('created_by'));

                    $row = 2;
					$total_amount = 0;
                    foreach ($_POST['val'] as $id) {
                        $dep = $this->accounts_model->getCustomersDepositByCustomerID($id);
                        $this->excel->getActiveSheet()->SetCellValue('A' . $row, $this->erp->hrld($dep->date));
                        $this->excel->getActiveSheet()->SetCellValue('B' . $row, $dep->name);
                        $this->excel->getActiveSheet()->SetCellValue('C' . $row, $dep->amount);
                        $this->excel->getActiveSheet()->SetCellValue('D' . $row, $dep->paid_by);
						$this->excel->getActiveSheet()->SetCellValue('E' . $row, $dep->created_by);
						$total_amount += $dep->amount;
                        $row++;
                    }
					
					$this->excel->getActiveSheet()->getStyle("C" . $row . ":C" . $row)->getBorders()
						->getTop()->setBorderStyle(PHPExcel_Style_Border::BORDER_MEDIUM);
					$this->excel->getActiveSheet()->SetCellValue('C' . $row, $total_amount);

                    $this->excel->getActiveSheet()->getColumnDimension('A')->setWidth(20);
                    $this->excel->getActiveSheet()->getColumnDimension('B')->setWidth(30);
					$this->excel->getActiveSheet()->getColumnDimension('C')->setWidth(20);
					$this->excel->getActiveSheet()->getColumnDimension('D')->setWidth(18);
					$this->excel->getActiveSheet()->getColumnDimension('E')->setWidth(25);
					
                    $this->excel->getDefaultStyle()->getAlignment()->setVertical(PHPExcel_Style_Alignment::VERTICAL_CENTER);
                    $filename = 'deposits_' . date('Y_m_d_H_i_s');
                    if ($this->input->post('form_action') == 'export_pdf') {
                        $styleArray = array('borders' => array('allborders' => array('style' => PHPExcel_Style_Border::BORDER_THIN)));
                        $this->excel->getDefaultStyle()->applyFromArray($styleArray);
                        $this->excel->getActiveSheet()->getPageSetup()->setOrientation(PHPExcel_Worksheet_PageSetup::ORIENTATION_LANDSCAPE);
                        require_once(APPPATH . "third_party" . DIRECTORY_SEPARATOR . "MPDF" . DIRECTORY_SEPARATOR . "mpdf.php");
                        $rendererName = PHPExcel_Settings::PDF_RENDERER_MPDF;
                        $rendererLibrary = 'MPDF';
                        $rendererLibraryPath = APPPATH . 'third_party' . DIRECTORY_SEPARATOR . $rendererLibrary;
                        if (!PHPExcel_Settings::setPdfRenderer($rendererName, $rendererLibraryPath)) {
                            die('Please set the $rendererName: ' . $rendererName . ' and $rendererLibraryPath: ' . $rendererLibraryPath . ' values' .
                                PHP_EOL . ' as appropriate for your directory structure');
                        }

                        header('Content-Type: application/pdf');
                        header('Content-Disposition: attachment;filename="' . $filename . '.pdf"');
                        header('Cache-Control: max-age=0');

                        $objWriter = PHPExcel_IOFactory::createWriter($this->excel, 'PDF');
                        return $objWriter->save('php://output');
                    }
                    if ($this->input->post('form_action') == 'export_excel') {
                        header('Content-Type: application/vnd.ms-excel');
                        header('Content-Disposition: attachment;filename="' . $filename . '.xls"');
                        header('Cache-Control: max-age=0');

                        $objWriter = PHPExcel_IOFactory::createWriter($this->excel, 'Excel5');
                        return $objWriter->save('php://output');
                    }

                    redirect($_SERVER["HTTP_REFERER"]);
                }
            } else {
                $this->session->set_flashdata('error', lang("no_deposit_selected"));
                redirect($_SERVER["HTTP_REFERER"]);
            }
        } else {
            $this->session->set_flashdata('error', validation_errors());
            redirect($_SERVER["HTTP_REFERER"]);
        }
	}
}
