<div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="fa fa-2x">&times;</i>
            </button>
            <h4 class="modal-title" id="myModalLabel"><?php echo lang('add_payment_term'); ?></h4>
        </div>
        <?php $attrib = array('data-toggle' => 'validator', 'role' => 'form');
        echo form_open("system_settings/edit_payment_term/".$id, $attrib); ?>
        <div class="modal-body">
            <p><?= lang('enter_info'); ?></p>

            <div class="form-group">
                <label class="control-label" for="description"><?php echo $this->lang->line("description"); ?></label>

                <div class="controls"> <?php echo form_input('description', $data->description, 'class="form-control" id="description" required="required"'); ?> </div>
            </div>
            <div class="form-group">
                <label class="control-label" for="payment_day"><?php echo $this->lang->line("payment_day"); ?></label>

                <div class="controls"> <?php echo form_input('payment_day', $data->payment_days, 'class="form-control" id="payment_day"'); ?> </div>
            </div>
            <div class="form-group">
                <label class="control-label" for="over_due_day"><?php echo $this->lang->line("over_due_day"); ?></label>

                <div class="controls"> <?php echo form_input('over_due_day', $data->over_due_days, 'class="form-control" id="over_due_day"'); ?> </div>
            </div>
			<div class="form-group">
                <label class="control-label" for="payment_date"><?php echo $this->lang->line("payment_date"); ?></label>

                <div class="controls"> <?php echo form_input('payment_date', $data->payment_date, 'class="form-control date" id="payment_date"'); ?> </div>
            </div>
			<div class="form-group">
                <label class="control-label" for="discount"><?php echo $this->lang->line("discount"); ?></label>

                <div class="controls"> <?php echo form_input('discount', $data->discount, 'class="form-control" id="discount"'); ?> </div>
            </div>
        </div>
        <div class="modal-footer">
            <?php echo form_submit('add_payment_term', lang('add_payment_term'), 'class="btn btn-primary"'); ?>
        </div>
    </div>
    <?php echo form_close(); ?>
</div>
<?= $modal_js ?>
