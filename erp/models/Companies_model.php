<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Companies_model extends CI_Model
{

    public function __construct()
    {
        parent::__construct();
    }

    public function getAllBillerCompanies()
    {
        $q = $this->db->get_where('companies', array('group_name' => 'biller'));
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return FALSE;
    }

    public function getAllCustomerCompanies()
    {
        $q = $this->db->get_where('companies', array('group_name' => 'customer'));
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return FALSE;
    }

    public function getAllSupplierCompanies()
    {
        $q = $this->db->get_where('companies', array('group_name' => 'supplier'));
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return FALSE;
    }

    public function getAllCustomerGroups()
    {
        $q = $this->db->get('customer_groups');
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return FALSE;
    }
    public function getCompanyUsers($company_id)
    {
        $q = $this->db->get_where('users', array('company_id' => $company_id));
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return FALSE;
    }

    public function getCompanyByID($id)
    {
        $this->db->select('companies.*,price_groups.id AS price_group_id, price_groups.name AS price_group_name');
		$this->db->from('companies');
		$this->db->join('price_groups','price_groups.id = companies.price_group_id', 'left');
		$this->db->where('companies.id', $id);
		$q = $this->db->get();
		if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
    }

	public function getDefaults()
    {
		$this->db->select('*');
		$this->db->from('account_settings');
		$this->db->join('gl_charts', 'account_settings.default_open_balance=gl_charts.accountcode');
        $q = $this->db->get();
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return FALSE;
    }
	
    public function getCompanyByEmail($email)
    {
        $q = $this->db->get_where('companies', array('email' => $email), 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
    }

    public function addCompany($data = array())
    {
		//$this->erp->print_arrays($data);
        if ($this->db->insert('companies', $data)) {
            $cid = $this->db->insert_id();
            return $cid;
        }
        return false;
    }

    public function updateCompany($id, $data = array())
    {
        $this->db->where('id', $id);
        if ($this->db->update('companies', $data)) {
            return true;
        }
        return false;
    }

    public function addCompanies($data = array())
    {
        if ($this->db->insert_batch('companies', $data)) {
            return true;
        }
        return false;
    }

    public function deleteCustomer($id)
    {
        if ($this->getCustomerSales($id)) {
            return false;
        }
        if ($this->db->delete('companies', array('id' => $id, 'group_name' => 'customer')) && $this->db->delete('users', array('company_id' => $id))) {
            return true;
        }
        return FALSE;
    }

    public function deleteSupplier($id)
    {
        if ($this->getSupplierPurchases($id)) {
            return false;
        }
        if ($this->db->delete('companies', array('id' => $id, 'group_name' => 'supplier')) && $this->db->delete('users', array('company_id' => $id))) {
            return true;
        }
        return FALSE;
    }

    public function deleteBiller($id)
    {
        if ($this->getBillerSales($id)) {
            return false;
        }
        if ($this->db->delete('companies', array('id' => $id, 'group_name' => 'biller'))) {
            return true;
        }
        return FALSE;
    }

    public function getBillerSuggestions($term, $limit = 10)
    {
        $this->db->select("id, company as text");
        $this->db->where(" (id LIKE '%" . $term . "%' OR name LIKE '%" . $term . "%' OR company LIKE '%" . $term . "%') ");
        $q = $this->db->get_where('companies', array('group_name' => 'biller'), $limit);
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }

            return $data;
        }
    }

    public function getCustomerSuggestions($term, $limit = 10)
    {
        $this->db->select("id, (CASE WHEN (LENGTH(CONCAT(name, ' (', company, ')')) > 50) THEN CONCAT(LEFT (CONCAT(name, ' (', company, ')'), 50), '...') ELSE CONCAT(name, ' (', company, ')') END) as text", FALSE);
        $this->db->where(" (id LIKE '%" . $term . "%' OR name LIKE '%" . $term . "%' OR company LIKE '%" . $term . "%' OR email LIKE '%" . $term . "%' OR phone LIKE '%" . $term . "%') ");
        $q = $this->db->get_where('companies', array('group_name' => 'customer'), $limit);
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }

            return $data;
        }
    }
	
	public function getBalanceSuggestions($term, $limit = 10)
    {
        $this->db->select("*");
        $this->db->where(" (accountcode LIKE '%" . $term . "%' OR accountname LIKE '%" . $term . "%') ");
        $q = $this->db->get_where('gl_charts', $limit);
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
    }

    public function getCustomerGroupSuggestions($term, $limit = 10)
    {
        $this->db->select("id, CONCAT(name, ' (', name, ')') as text", FALSE);
        $this->db->where(" (id LIKE '%" . $term . "%' OR name LIKE '%" . $term . "%' OR name LIKE '%" . $term . "%' OR name LIKE '%" . $term . "%' OR name LIKE '%" . $term . "%') ");
        $q = $this->db->get('erp_customer_groups');
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }

            return $data;
        }
    }

    public function getSupplierSuggestions($term, $limit = 10)
    {
        $this->db->select("id, CONCAT(company, ' (', name, ')') as text", FALSE);
        $this->db->where(" (id LIKE '%" . $term . "%' OR name LIKE '%" . $term . "%' OR company LIKE '%" . $term . "%' OR email LIKE '%" . $term . "%' OR phone LIKE '%" . $term . "%') ");
        $q = $this->db->get_where('companies', array('group_name' => 'supplier'), $limit);
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }

            return $data;
        }
    }

    public function getCustomerSales($id)
    {
        $this->db->where('customer_id', $id)->from('sales');
        return $this->db->count_all_results();
    }

    public function getBillerSales($id)
    {
        $this->db->where('biller_id', $id)->from('sales');
        return $this->db->count_all_results();
    }

    public function getSupplierPurchases($id)
    {
        $this->db->where('supplier_id', $id)->from('purchases');
        return $this->db->count_all_results();
    }
	
	public function addDeposit($data, $cdata, $payment = array())
    {
        if ($this->db->insert('deposits', $data)) {
				$deposit_id = $this->db->insert_id();
				$this->db->update('companies', $cdata, array('id' => $data['company_id']));
				if($payment){
					$payment['deposit_id'] = $deposit_id;
					if ($this->db->insert('payments', $payment)) {
						if ($this->site->getReference('sp') == $payment['reference_no']) {
							$this->site->updateReference('sp');
						}
						if ($payment['paid_by'] == 'gift_card') {
							$gc = $this->site->getGiftCardByNO($payment['cc_no']);
							$this->db->update('gift_cards', array('balance' => ($gc->balance - $payment['amount'])), array('card_no' => $payment['cc_no']));
						}
						return true;
					}
				}
            return true;
        }
        return false;
    }

    public function updateDeposit($id, $data, $cdata, $payment)
    {
        if ($this->db->update('deposits', $data, array('id' => $id)) && $this->db->update('companies', $cdata, array('id' => $data['company_id']))) {
			$this->db->update('payments', $payment , array('deposit_id' => $id));
            return true;
        }
        return false;
    }
	
	public function ReturnDeposit($id, $data, $cdata, $payment)
    {
        if ($this->db->update('deposits', $data, array('id' => $id)) && $this->db->update('companies', $cdata, array('id' => $data['company_id']))) {
				$this->db->insert('payments', $payment);
				if ($this->site->getReference('pp') == $payment['reference_no']) {
					$this->site->updateReference('pp');
				}
            return true;
        }
        return false;
    }
	
	public function getPaymentBySupplierDeposit($purchase_deposit_id)
    {
        $q = $this->db->get_where('payments', array('purchase_deposit_id' => $purchase_deposit_id), 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
    }

    public function getDepositByID($id)
    {
        $q = $this->db->get_where('deposits', array('id' => $id), 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
    }

    public function deleteDeposit($id)
    {
        $deposit = $this->getDepositByID($id);
        $company = $this->getCompanyByID($deposit->company_id);
        $cdata = array(
			'deposit_amount' => ($company->deposit_amount - $deposit->amount)
		);
        if ($this->db->update('companies', $cdata, array('id' => $deposit->company_id)) &&
            $this->db->delete('deposits', array('id' => $id))) {
            return true;
        }
        return false;
    }
	
	public function createDriver($data = array()) {
		if($data) {
			
			if($this->db->insert('companies', $data)) {
				return true;
			}
		}
		return false;
	}
	public function saveDriver($id=null,$data = array()) {
		
		if($data) {
			if($this->db->update('companies', $data,array('id'=>$id)))  {
				return true;
			}
		}
		return false;
	}
	
	/* Supplier Deposit */
	public function addSupplierDeposit($data, $cdata, $payment = array())
    {
		//$this->erp->print_arrays($data, $cdata, $payment);
        if ($this->db->insert('deposits', $data)) {
			$deposit_id = $this->db->insert_id();
			$this->db->update('companies', $cdata, array('id' => $data['company_id']));
			if($payment){
				$payment['purchase_deposit_id'] = $deposit_id;
				if ($this->db->insert('payments', $payment)) {
					if ($this->site->getReference('pp') == $payment['reference_no']) {
						$this->site->updateReference('pp');
					}
					if ($payment['paid_by'] == 'gift_card') {
						$gc = $this->site->getGiftCardByNO($payment['cc_no']);
						$this->db->update('gift_cards', array('balance' => ($gc->balance - $payment['amount'])), array('card_no' => $payment['cc_no']));
					}
					return true;
				}
			}
            return true;
        }
        return false;
    }
	
	public function updateSupplierDeposit($id, $data, $cdata, $payment)
    {
		// $this->erp->print_arrays($data, $cdata, $payment);
        if ($this->db->update('deposits', $data, array('id' => $id)) && $this->db->update('companies', $cdata, array('id' => $data['company_id']))) {
			$this->db->update('payments', $payment , array('purchase_deposit_id' => $id));
            return true;
        }
        return false;
    }
	
	public function deleteSupplierDeposit($id){
		$deposit = $this->getDepositByID($id);
		
		if($this->db->delete('deposits',array('id'=>$id))){
			$this->db->update('companies', array('deposit_amount' => 0), array('id' => $deposit->company_id));
			return true;
		}
			return false;
		
		
	}
	
	public function delete_driver($id=null){
		if($this->db->delete('companies',array('id'=>$id))){
			return true;
		}
			return false;
		
		
	}

}
