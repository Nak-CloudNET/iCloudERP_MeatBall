<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Drivers extends MY_Controller
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
        $this->lang->load('customers', $this->Settings->language);
        $this->load->library('form_validation');
        $this->load->model('companies_model');
    }
	
	function index($action = NULL)
    {
        $this->erp->checkPermissions();

        $this->data['error'] = (validation_errors()) ? validation_errors() : $this->session->flashdata('error');
        $this->data['action'] = $action;
        $bc = array(array('link' => base_url(), 'page' => lang('home')), array('link' => '#', 'page' => lang('drivers')));
        $meta = array('page_title' => lang('List_Driver'), 'bc' => $bc);
        $this->page_construct('drivers/index', $meta, $this->data);
    }

    function getCustomers()
    {
        $this->erp->checkPermissions('index');
        $this->load->library('datatables');
        $this->datatables
            ->select("id, id AS cus_no, company, name, email, phone, city, customer_group_name, vat_no, deposit_amount, award_points, attachment")
            ->from("companies")
            ->where('group_name', 'customer')
            ->add_column("Actions", "<div class=\"text-center\"><a class=\"tip\" title='" . lang("list_users") . "' href='" . site_url('customers/users/$1') . "' data-toggle='modal' data-target='#myModal'><i class=\"fa fa-users\"></i></a> <a class=\"tip\" title='" . lang("add_user") . "' href='" . site_url('customers/add_user/$1') . "' data-toggle='modal' data-target='#myModal'><i class=\"fa fa-user-plus\"></i></a> <a class=\"tip\" title='" . lang("list_deposits") . "' href='" . site_url('customers/deposits/$1') . "' data-toggle='modal' data-target='#myModal'><i class=\"fa fa-money\"></i></a> <a class=\"tip\" title='" . lang("add_deposit") . "' href='" . site_url('customers/add_deposit/$1') . "' data-toggle='modal' data-target='#myModal'><i class=\"fa fa-plus\"></i></a> <a class=\"tip\" title='" . lang("edit_customer") . "' href='" . site_url('customers/edit/$1') . "' data-toggle='modal' data-target='#myModal'><i class=\"fa fa-edit\"></i></a> <a href='#' class='tip po' title='<b>" . lang("delete_customer") . "</b>' data-content=\"<p>" . lang('r_u_sure') . "</p><a class='btn btn-danger po-delete' href='" . site_url('customers/delete/$1') . "'>" . lang('i_m_sure') . "</a> <button class='btn po-close'>" . lang('no') . "</button>\"  rel='popover'><i class=\"fa fa-trash-o\"></i></a></div>", "id");
        //->unset_column('id');
        echo $this->datatables->generate();
    }
	
	function getDrivers()
    {
        $this->erp->checkPermissions('index');
        $this->load->library('datatables');
        $this->datatables
            ->select("id, name, email, phone")
            ->from("companies")
            ->where('group_id', 5)
			->where('group_name','driver')
            ->add_column("Actions", "<div class=\"text-center\"><a class=\"tip\" title='" . lang("edit_driver") . "' href='" . site_url('drivers/edit/$1') . "' data-toggle='modal' data-target='#myModal'><i class=\"fa fa-edit\"></i></a> <a href='#' class='tip po' title='<b>" . lang("delete_driver") . "</b>' data-content=\"<p>" . lang('r_u_sure') . "</p><a class='btn btn-danger po-delete' href='" . site_url('drivers/delete/$1') . "'>" . lang('i_m_sure') . "</a> <button class='btn po-close'>" . lang('no') . "</button>\"  rel='popover'><i class=\"fa fa-trash-o\"></i></a></div>", "id");
        //->unset_column('id');
        echo $this->datatables->generate();
    }

    function view($id = NULL)
    {
        $this->erp->checkPermissions('index', true);
        $this->data['error'] = (validation_errors()) ? validation_errors() : $this->session->flashdata('error');
        $this->data['customer'] = $this->companies_model->getCompanyByID($id);
        $this->load->view($this->theme.'customers/view',$this->data);
    }
	
	function add()
    {
        $this->erp->checkPermissions(false, true);

        $this->form_validation->set_rules('email', lang("email_address"), 'is_unique[companies.email]');

        if ($this->form_validation->run('companies/add') == true) {
			
        }

        if ($this->form_validation->run() == true) {
			
        } else {
            $this->data['error'] = (validation_errors() ? validation_errors() : $this->session->flashdata('error'));
            $this->data['modal_js'] = $this->site->modal_js();
            $this->load->view($this->theme . 'drivers/add', $this->data);
        }
    }
	
    function edit($id = NULL)
    {
        $this->erp->checkPermissions(false, true);
		
		$this->data['driver']=$this->companies_model->getCompanyByID($id);
		$this->data['id']=$id;
		$this->data['error'] = (validation_errors() ? validation_errors() : $this->session->flashdata('error'));
		$this->data['modal_js'] = $this->site->modal_js();
		$this->load->view($this->theme . 'drivers/edit_driver', $this->data);
    }
	
	function create_driver(){
		$this->erp->checkPermissions(false, true);

		$this->form_validation->set_rules('driver_name', lang("driver_name"), 'required');
        if ($this->form_validation->run('drivers/create_driver') == true) {
			
            $data = array(
				'name' => $this->input->post('driver_name'),
                'email' => $this->input->post('email'),
                'phone' => $this->input->post('phone'),
				'group_id'=>5,
				'group_name'=>'driver'
            );
        }
		if($this->companies_model->createDriver($data)) {
			$this->session->set_flashdata('message', lang("driver_added"));
            redirect('drivers');
		}else {
			$this->session->set_flashdata('error', validation_errors());
            redirect('drivers/add');
		}
	}
	
	function Save($id=null){
		
		$this->erp->checkPermissions(false, true);
		
		$this->form_validation->set_rules('driver_name', lang("driver_name"), 'required');
        if ($this->form_validation->run('drivers/Save') == true) {
			
            $data = array(
				'name' => $this->input->post('driver_name'),
                'email' => $this->input->post('email'),
                'phone' => $this->input->post('phone'),
				
            );
        }
		if($this->companies_model->saveDriver($id,$data)) {
			$this->session->set_flashdata('message', lang("driver_Save"));
            redirect('drivers');
		}else {
			$this->session->set_flashdata('error', validation_errors());
            redirect('drivers');
		}
	}
	
	function delete($id=null){
		
		$this->erp->checkPermissions(false, true);
		if($this->companies_model->delete_driver($id)){
			$this->session->set_flashdata('message', lang("driver_deleted"));
            die("<script type='text/javascript'>setTimeout(function(){ window.top.location.href = '" . (isset($_SERVER["HTTP_REFERER"]) ? $_SERVER["HTTP_REFERER"] : site_url('welcome')) . "'; }, 0);</script>");
		}else {
			$this->session->set_flashdata('error', validation_errors());
            die("<script type='text/javascript'>setTimeout(function(){ window.top.location.href = '" . (isset($_SERVER["HTTP_REFERER"]) ? $_SERVER["HTTP_REFERER"] : site_url('welcome')) . "'; }, 0);</script>");
		}
	}
}
