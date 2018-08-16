
<div class="modal-dialog modal-lg">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="fa fa-2x">&times;</i>
            </button>
            <h4 class="modal-title" id="myModalLabel"><?php echo lang('add_customer'); ?></h4>
        </div>
        <?php $attrib = array('data-toggle' => 'validator', 'role' => 'form', 'id' => 'add-customer-form');
        echo form_open_multipart("customers/add", $attrib); ?>
        <div class="modal-body">
            <p><?= lang('enter_info'); ?></p>

            <div class="form-group">
                <label class="control-label"
                       for="customer_group"><?php echo $this->lang->line("default_customer_group"); ?></label>

                <div class="controls"> <?php
                    foreach ($customer_groups as $customer_group) {
                        $cgs[$customer_group->id] = $customer_group->name;
                    }
                    echo form_dropdown('customer_group', $cgs, $this->Settings->customer_group, 'class="form-control tip select" id="customer_group" style="width:100%;" required="required"');
                    ?>
                </div>
            </div>
			
			<div class="form-group">
                <label class="control-label"
                       for="price_group"><?php echo $this->lang->line("price_groups"); ?></label>

                <div class="controls"> <?php
					$pr_group["0"] = "Select Price Group";
                    foreach ($price_groups as $price_group) {
                        $pr_group[$price_group->id] = $price_group->name;
                    }
                    echo form_dropdown('price_groups',$pr_group, $customer->price_group_id, 'class="form-control tip select" id=" " style="width:100%;" placeholder="' . lang("select") . ' ' . lang("price_groups") . '" ');
                    ?>
                </div>
            </div>

            <div class="row">
                <div class="col-md-6">
                    <div class="form-group company">
                        <?= lang("company", "company"); ?>
                        <?php echo form_input('company', '', 'class="form-control tip" id="company" '); ?>
                    </div>
                    <div class="form-group person">
                        <?= lang("name", "name"); ?>
                        <?php echo form_input('name', '', 'class="form-control tip" id="name" data-bv-notempty="true"'); ?>
                    </div>
                <!--    <div class="form-group">
                        <?= lang("vat_no", "vat_no"); ?>
                        <?php echo form_input('vat_no', '', 'class="form-control" id="vat_no"'); ?>
                    </div>
                    <div class="form-group company">
						<?= lang("contact_person", "contact_person"); ?>
						<?php echo form_input('contact_person', '', 'class="form-control" id="contact_person" data-bv-notempty="true"'); ?>
					</div>-->
                    <div class="form-group">
                        <?= lang("email_address", "email_address"); ?>
                        <input type="email" name="email" class="form-control" id="email_address"/>
                    </div>
                    <div class="form-group">
                        <?= lang("phone", "phone"); ?>
						<?php echo form_input('phone', '', 'class="form-control" id="phone" type="tel" data-bv-notempty="true" '); ?>
                    </div>
                    <div class="form-group">
                        <?= lang("address", "address"); ?>
                        <?php echo form_input('address', '', 'class="form-control" id="address"'); ?>
                    </div>
					<div class="form-group invoice_payment_term">
                        <?= lang("invoice_payment_term", "invoice_payment_term"); ?>
                        <?php echo form_input('invoice_payment_term', '', 'class="form-control tip" id="invoice_payment_term"'); ?>
                    </div>
                <!--    <div class="form-group">
                        <?= lang("city", "city"); ?>
                        <?php echo form_input('city', '', 'class="form-control" id="city"'); ?>
                    </div>
                    <div class="form-group">
                        <?= lang("state", "state"); ?>
                        <?php echo form_input('state', '', 'class="form-control" id="state"'); ?>
                    </div> -->

                </div>
                <div class="col-md-6">
                    <!-- <div class="form-group">
                        <?= lang("postal_code", "postal_code"); ?>
                        <?php echo form_input('postal_code', '', 'class="form-control" id="postal_code"'); ?>
                    </div> 
                    <div class="form-group">
                        <?= lang("country", "country"); ?>
                        <?php echo form_input('country', '', 'class="form-control" id="country"'); ?>
                    </div> 
                    <div class="form-group">
                        <?= lang("postal_code", "postal_code"); ?>
                        <?php echo form_input('postal_code', isset($customer->postal_code)?$customer->postal_code:'', 'class="form-control" id="postal_code"'); ?>

                    </div> -->
					
					<div class="form-group">
                        <?= lang("marital_status", "status"); ?>
                        <?php
                        $status[""] = "Select Marital Status";
                        $status['single'] = "Single";
                        $status['married'] = "Married";
                        echo form_dropdown('status', $status, isset($customer->status)?$customer->status:'', 'class="form-control select" id="status" placeholder="' . lang("select") . ' ' . lang("Marital Status") . '" style="width:100%"')
                        ?>
                    </div>
					
                    <div class="form-group">
                        <?= lang("gender", "gender"); ?>
                        <?php
                        $gender[""] = "Select Gender";
                        $gender['male'] = "Male";
                        $gender['female'] = "Female";
                        echo form_dropdown('gender', $gender, isset($customer->gender)?$customer->gender:'', 'class="form-control select" id="gender" placeholder="' . lang("select") . ' ' . lang("gender") . '" style="width:100%"')
                        ?>
                    </div>
					
					<div class="form-group">
                        <?= lang("Identity Number", "cf1"); ?>
                        <?php echo form_input('cf1', isset($customer->cf1)?$customer->cf1:'', 'class="form-control" id="cf1"'); ?>
                    </div>
					
                    <div class="form-group">
                        <?= lang("attachment", "cf4"); ?><input id="attachment" type="file" name="userfile" data-show-upload="false" data-show-preview="false"
                       class="file">

                    </div>
                    <div class="form-group">
                        <?= lang("date_of_birth", "cf5"); ?> <?= lang("Ex: YYYY-MM-DD"); ?>
                        <?php echo form_input('date_of_birth', isset($customer->date_of_birth)?date('d-m-Y', strtotime($customer->date_of_birth)):'', 'class="form-control date" id="datepicker date_of_birth"'); ?>

                    </div>
				<!--	<div class="form-group">
						 <input type="checkbox" name="option" id="option" value='0'>
						 <label for="option" class="padding05"><?= lang('payment_term'); ?></label>
					</div>
                    <div class="form-group day_payment_term">
                        <?= lang("day_payment_term", "day_payment_term"); ?>
                        <?php echo form_input('day_payment_term', '', 'class="form-control tip" id="day_payment_term"'); ?>
                    </div> -->
				<!--	<div class="form-group">
                        <?= lang("start_date", "cf5"); ?> <?= lang("Ex: YYYY-MM-DD"); ?>
                        <?php echo form_input('start_date', isset($customer->start_date)?date('d-m-Y', strtotime($customer->start_date)):'', 'class="form-control date" id="datepicker start_date"'); ?>
                        <!--<a href="javascript:void(0);" class="btn btn-info">Add End Date</a>
                    </div>
                    <div class="form-group">
                        <?= lang("end_date", "cf5"); ?> <?= lang("Ex: YYYY-MM-DD"); ?>
                        <?php echo form_input('end_date', isset($customer->end_date)?date('d-m-Y', strtotime($customer->end_date)):'', 'class="form-control date" id="datepicker end_date"'); ?>
                    </div> -->
                </div>
            </div>


        </div>
        <div class="modal-footer">
            <?php echo form_submit('add_customer', lang('add_customer'), 'class="btn btn-primary"'); ?>
        </div>
    </div>
    <?php echo form_close(); ?>
</div>
<?= $modal_js ?>
<script type="text/javascript">
	/*$(document).ready(function () {
		$('.invoice_payment_term').hide();
		$('#option').on('ifChecked', function (event) {
			 $('.day_payment_term').slideUp();
            $('.invoice_payment_term').slideDown();
		});
		$('#option').on('ifUnchecked', function (event) {
			 $('.invoice_payment_term').slideUp();
            $('.day_payment_term').slideDown();
		});
	});*/
</script>