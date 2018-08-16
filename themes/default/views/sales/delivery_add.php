<div class="modal-dialog modal-lg no-modal-header">
    <div class="modal-content">
        <div class="modal-body">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="fa fa-2x">&times;</i>
            </button>
			<button type="button" class="btn btn-xs btn-default no-print pull-right" style="margin-right:15px;" onclick="window.print();">
                <i class="fa fa-print"></i> <?= lang('print'); ?>
            </button>
            <?php if ($logo) { ?>
                <div class="text-center" style="margin-bottom:20px;">
                    <img src="<?= base_url() . 'assets/uploads/logos/' . $biller->logo; ?>"
                         alt="<?= $biller->company != '-' ? $biller->company : $biller->name; ?>">
                </div>
            <?php } ?>
			<?php
                $attrib = array('data-toggle' => 'validator', 'role' => 'form', 'class' => 'edit-so-form');
                echo form_open_multipart("sales/delivery_add/" . $did, $attrib)
            ?>
            <div class="table-responsive">
                <table class="table table-bordered">

                    <tbody>
                    <tr>
                        <td width="30%"><?php echo $this->lang->line("date"); ?></td>
                        <td width="70%"><?php echo $this->erp->hrld($delivery->date); ?></td>
                    </tr>
                    <tr>
                        <td><?php echo $this->lang->line("do_reference_no"); ?></td>
                        <td>
							<?php echo $delivery->do_reference_no; ?>
							<input type="hidden" value="<?php echo $delivery->do_reference_no; ?>" name="do_reference_no"/>
						</td>
                    </tr>
                    <tr>
                        <td><?php echo $this->lang->line("sale_reference_no"); ?></td>
                        <td><?php echo $delivery->sale_reference_no; ?></td>
                    </tr>
                    <tr>
                        <td><?php echo $this->lang->line("customer"); ?></td>
                        <td><?php echo $delivery->customer; ?></td>
                    </tr>
                    <tr>
                        <td><?php echo $this->lang->line("address"); ?></td>
                        <td><?php echo $delivery->address; ?></td>
                    </tr>
                    <?php if ($delivery->note) { ?>
                        <tr>
                            <td><?php echo $this->lang->line("note"); ?></td>
                            <td><?php echo $this->erp->decode_html($delivery->note); ?></td>
                        </tr>
                    <?php } ?>
                    </tbody>

                </table>
            </div>
            <div class="table-responsive">
                <table class="table table-bordered table-hover table-striped">

                    <h3><?php echo $this->lang->line("items"); ?></h3>
                    <thead>

						<tr>

							<th style="text-align:center; vertical-align:middle;"><?php echo $this->lang->line("no"); ?></th>
							<th style="vertical-align:middle;"><?php echo $this->lang->line("description"); ?></th>
							<th style="text-align:center; vertical-align:middle;"><?php echo $this->lang->line("quantity"); ?></th>
							<th style="text-align:center; vertical-align:middle;"><?php echo $this->lang->line("dq"); ?></th>
							<th style="text-align:center; vertical-align:middle;"><?php echo $this->lang->line("balance"); ?></th>
						</tr>

                    </thead>

                    <tbody>

                    <?php $r = 1;
                    foreach ($rows as $row): ?>
                        <tr>
                            <td style="text-align:center; width:40px; vertical-align:middle;"><?php echo $r; ?></td>
                            <td style="vertical-align:middle;">
								<?php echo $row->product_name . " (" . $row->product_code . ")";
									if ($row->details) {
										echo '<br><strong>' . $this->lang->line("product_details") . '</strong> ' . html_entity_decode($row->details);
									}
                                ?>
								<input type="hidden" value="<?= $row->product_id?>" name="product_id[]">
								<input type="hidden" value="<?= $row->product_name?>" name="product_name[]">
								<input type="hidden" value="<?= $row->ware?>" name="ware[]">
								<input type="hidden" value="<?= $row->catename?>" name="catename[]">
								<input type="hidden" value="<?= $row->net_unit_price?>" name="price[]">
								<input type="hidden" value="<?= $row->variant?>" name="variant[]">
							</td>
							<td style="width: 70px; text-align:center; vertical-align:middle;"><?php echo $this->erp->formatQuantity($row->quantity); ?></td>
							<td style="width: 110px; text-align:center; vertical-align:middle;">
								<!--<input type="text" class="form-control" name="delivery_qty[]" required="required">-->
								<div class="form-group all">
									<?= form_input('delivery_qty[]', '', 'class="form-control" id="delivery_qty"  required="required"') ?>
								</div>
							</td>
							<td style="width: 70px; text-align:center; vertical-align:middle;">
								<?php
									/*if($row->dq != ""){
										$balance = $row->quantity - $row->dq;
										echo $this->erp->formatQuantity($balance);
									}else{
										echo '0';
									}*/
									$this->db->select('COALESCE(quantity, 0) as qty');
									$this->db->from('erp_delivery_items');
									$this->db->where('do_reference_no = "'.$delivery->do_reference_no.'" and product_id = "'.$row->product_id.'" ');
									$q = $this->db->get();
									if ($q->num_rows() > 0) {
										foreach ($q->result() as $r) {
											if($r->qty == ""){
												echo '0';
											}else{
												echo $this->erp->formatQuantity($r->qty);
											}
										}
									}
								?>
							</td>
                        </tr>
                        <?php
                        $r++;
                    endforeach;
                    ?>
                    </tbody>
                </table>
            </div>

            <div class="row">
                <div class="col-xs-10">&nbsp;</div>
                <div class="col-xs-2">
                    <?php echo form_submit('add_delivery', lang("add_delivery"), 'id="add_delivery" class="btn btn-primary" style="padding: 6px 15px; margin:15px 0;"'); ?>
                </div>
            </div>

			<?php echo form_close(); ?>
        </div>
    </div>
</div>
<?= $modal_js;?>


