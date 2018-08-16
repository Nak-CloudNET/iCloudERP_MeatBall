<link href="<?= $assets ?>styles/helpers/bootstrap.min.css" rel="stylesheet"/>
<?php
	$address = '';
	$address.=$biller->address;
	$address.=($biller->city != '')? ', '.$biller->city : '';
	$address.=($biller->postal_code != '')? ', '.$biller->postal_code : '';
	$address.=($biller->state != '')? ', '.$biller->state : '';
	$address.=($biller->country != '')? ', '.$biller->country : '';
	
	if ($modal) {
		echo '<div style="width:100%" class="modal-dialog"><div class="modal-content"><div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="fa fa-2x">&times;</i>
            </button>
            <button type="button" class="btn btn-xs btn-default no-print pull-right" style="margin-right:15px;" onclick="window.print();">
                <i class="fa fa-print"></i> Print
            </button>
        </div><div class="modal-body">';
	}
?>

	<div class="print_rec" id="wrap" style="width: 50%; margin: 0 auto;">
		<div class="row">
			<div class="col-lg-12">
				<?php if ($logo) { ?>
					<div class="text-center" style="margin-bottom:20px;">
						<img src="<?= base_url() . 'assets/uploads/logos/' . $biller->logo; ?>"
							 alt="<?= $biller->company != '-' ? $biller->company : $biller->name; ?>">
					</div>
					<!--<div class="text-center" style="margin-bottom:20px; text-align: center;">-->
						<!--<img src="<?= base_url() . 'assets/uploads/logos/' . $Settings->logo; ?>" alt="<?= $Settings->site_name; ?>">-->
						<!--<img src="<?= base_url() . 'assets/uploads/logos/' . $biller->logo; ?>"
							 alt="<?= $biller->company != '-' ? $biller->company : $biller->name; ?>" style="width:388px;height:69px;">
					</div>-->
					<div class="well well-sm" style="height:88px;">
						<div class="row bold" style="font-size:12px">
							<div class="col-xs-6">
							<p class="bold">
								<?= lang("ref"); ?>: <?= $inv->reference_no; ?><br>
								<?= lang("date"); ?>: <?= $this->erp->hrld($inv->date); ?><br>
								<?= lang("sale_status"); ?>: <?= lang($inv->sale_status); ?><br>
								<?= lang("payment_status"); ?>: <?= lang($inv->payment_status); ?>
							</p>
							</div>
							<div class="col-xs-6 text-right">
								<?php $br = $this->erp->save_barcode($inv->reference_no, 'code39', 70, false); ?>
								<img src="<?= base_url() ?>assets/uploads/barcode<?= $this->session->userdata('user_id') ?>.png"
									 alt="<?= $inv->reference_no ?>" style="height:40px"/>
									 <?php 
									if($pos->display_qrcode) {
									?>
								<?php $this->erp->qrcode('link', urlencode(site_url('sales/view/' . $inv->id)), 2); ?>
								<img src="<?= base_url() ?>assets/uploads/qrcode<?= $this->session->userdata('user_id') ?>.png"
									 alt="<?= $inv->reference_no ?>"/>
							<?php } ?>
							</div>
						</div>
					</div>
				<?php } ?>
				<div class="clearfix"></div>
				<div class="row padding10">
					<div class="col-xs-4" style="float: left;font-size:14px">
						<h5><?= lang("from"); ?> :</h5>
						<h4 class=""><?= $biller->company != '-' ? $biller->company : $biller->name; ?></h4>
						<?= $biller->company ? "" : "Attn: " . $biller->name ?>
						<?php
						echo $biller->address . "<br />" . $biller->city . " " . $biller->postal_code . " " . $biller->state . "<br />" . $biller->country;
						/* echo "<p>";
						if ($biller->cf1 != "-" && $biller->cf1 != "") {
							echo "<br>" . lang("bcf1") . ": " . $biller->cf1;
						}
						if ($biller->cf2 != "-" && $biller->cf2 != "") {
							echo "<br>" . lang("bcf2") . ": " . $biller->cf2;
						}
						if ($biller->cf3 != "-" && $biller->cf3 != "") {
							echo "<br>" . lang("bcf3") . ": " . $biller->cf3;
						}
						if ($biller->cf4 != "-" && $biller->cf4 != "") {
							echo "<br>" . lang("bcf4") . ": " . $biller->cf4;
						}
						if ($biller->cf5 != "-" && $biller->cf5 != "") {
							echo "<br>" . lang("bcf5") . ": " . $biller->cf5;
						}
						if ($biller->cf6 != "-" && $biller->cf6 != "") {
							echo "<br>" . lang("bcf6") . ": " . $biller->cf6;
						}
						echo "</p>"; */
						echo lang("tel") . ": " . $biller->phone . "<br />" . lang("email") . ": " . $biller->email;
						?>
						<div class="clearfix"></div>
					</div>
					<div class="col-xs-4" style="text-align:center;margin-top:-20px">
						<h4><b><?= lang("invoice"); ?></b></h4>
					</div>
					<div class="col-xs-4"  style="float: right;font-size:14px">
						<h5><?= lang("to_");?> :</h5>
						<h4 class=""><?= $customer->company ? $customer->company : $customer->name; ?></h4>
						<?= $customer->company ? "" : "Attn: " . $customer->name ?>
						<?php
						echo $customer->address . "<br />" . $customer->city . " " . $customer->postal_code . " " . $customer->state . "<br />" . $customer->country;
						echo "<p>";
						/*if ($customer->cf1 != "-" && $customer->cf1 != "") {
							echo "<br>" . lang("ccf1") . ": " . $customer->cf1;
						}
						if ($customer->cf2 != "-" && $customer->cf2 != "") {
							echo "<br>" . lang("ccf2") . ": " . $customer->cf2;
						}
						if ($customer->cf3 != "-" && $customer->cf3 != "") {
							echo "<br>" . lang("ccf3") . ": " . $customer->cf3;
						}
						if ($customer->cf4 != "-" && $customer->cf4 != "") {
							echo "<br>" . lang("ccf4") . ": " . $customer->cf4;
						}
						if ($customer->cf5 != "-" && $customer->cf5 != "") {
							echo "<br>" . lang("ccf5") . ": " . $customer->cf5;
						}
						if ($customer->cf6 != "-" && $customer->cf6 != "") {
							echo "<br>" . lang("ccf6") . ": " . $customer->cf6;
						}
						echo "</p>";*/
						if($customer->phone !="-"){
							echo lang("tel") . ": " . $customer->phone;
						}
						/* if($customer->email !=""){
							 echo "<br />" . lang("email") . ": " . $customer->email;
						} */
						?>
					</div>
				</div>
				<div class="clearfix"></div>
				<div class="row padding10" style="display:none">
					<div class="col-xs-6" style="float: left;">
						<span class="bold"><?= $Settings->site_name; ?></span><br>
						<?= $warehouse->name ?>

						<?php
						echo $warehouse->address . "<br>";
						echo ($warehouse->phone ? lang("tel") . ": " . $warehouse->phone . "<br>" : '') . ($warehouse->email ? lang("email") . ": " . $warehouse->email : '');
						?>
						<div class="clearfix"></div>
					</div>
					<div class="col-xs-5" style="float: right;">
						<div class="bold">
							<?= lang("date"); ?>: <?= $this->erp->hrld($inv->date); ?><br>
							<?= lang("ref"); ?>: <?= $inv->reference_no; ?>
							<div class="clearfix"></div>
							<?php $this->erp->qrcode('link', urlencode(site_url('sales/view/' . $inv->id)), 1); ?>
							<img src="<?= base_url() ?>assets/uploads/qrcode<?= $this->session->userdata('user_id') ?>.png"
								 alt="<?= $inv->reference_no ?>" class="pull-right"/>
							<?php $br = $this->erp->save_barcode($inv->reference_no, 'code39', 50, false); ?>
							<img src="<?= base_url() ?>assets/uploads/barcode<?= $this->session->userdata('user_id') ?>.png"
								 alt="<?= $inv->reference_no ?>" class="pull-left"/>
						</div>
						<div class="clearfix"></div>
					</div>
				</div>

				<div class="clearfix"></div>
				<div><br/></div>
				<div class="-table-responsive">
					<table class="table table-bordered table-hover table-striped" style="width: 100%;">
						<thead  style="font-size: 13px;">
							<tr>
								<th><?= lang("no"); ?></th>
								<th><?= lang("description"); ?> (<?= lang("code"); ?>)</th>
								<th><?= lang("unit"); ?></th>
								<th><?= lang("quantity"); ?></th>
								<?php
								if ($Settings->product_serial) {
									echo '<th style="text-align:center; vertical-align:middle;">' . lang("serial_no") . '</th>';
								}
								?>
								<th><?= lang("unit_price"); ?></th>
								<?php
								if ($Settings->tax1) {
									echo '<th>' . lang("tax") . '</th>';
								}
								if ($Settings->product_discount) {
									echo '<th>' . lang("discount") . '</th>';
								}
								?>
								<th><?= lang("subtotal"); ?></th>
							</tr>
						</thead>
						<tbody style="font-size: 13px;">
							<?php $r = 1;
							$total = 0;
							foreach ($rows as $row):
							$free = lang('free');
							$product_unit = '';
							if($row->variant){
								$product_unit = $row->variant;
							}else{
								$product_unit = $row->unit;
							}
							
							$product_name_setting;
							if($pos->show_product_code == 0) {
								$product_name_setting = ($row->promotion == 1 ? '<i class="fa fa-check-circle"></i> ' : '') . $row->product_name . ($row->variant ? ' (' . $row->variant . ')' : '');
							}else{
								$product_name_setting = ($row->promotion == 1 ? '<i class="fa fa-check-circle"></i> ' : '') . $row->product_name . " (" . $row->product_code . ")" . ($row->variant ? ' (' . $row->variant . ')' : '');
							}
								?>
								<tr>
									<td style="text-align:center; width:5%; vertical-align:middle;"><?= $r; ?></td>
									<td style="vertical-align:middle;width:35%" >
										<?= $product_name_setting ?>
										<?= $row->details ? '<br>' . $row->details : ''; ?>
									</td>
									<td style="width: 10%; text-align:center; vertical-align:middle;"><?php echo $product_unit ?></td>
									<td style="width: 10%; text-align:center; vertical-align:middle;"><?= $this->erp->formatQuantity($row->quantity); ?></td>
									<?php
									if ($Settings->product_serial) {
										echo '<td>' . $row->serial_no . '</td>';
									}
									?>
									<td style="text-align:center; width:15%;vertical-align:middle;"><?= $row->subtotal!=0?$this->erp->formatMoney($row->unit_price):$free; ?></td>
									<?php
									if ($Settings->tax1) {
										echo '<td style="width: 8%; text-align:right; vertical-align:middle;">' . ($row->item_tax != 0 && $row->tax_code ? '<small>(' . $row->tax_code . ')</small> ' : '') . $this->erp->formatMoney($row->item_tax) . '</td>';
									}
									if ($Settings->product_discount) {
										echo '<td style="width: 7%; text-align:right; vertical-align:middle;">' . ($row->discount != 0 ? '<small>(' . $row->discount . ')</small> ' : '') . $this->erp->formatMoney($row->item_discount) . '</td>';
									}
									?>
									<td style="vertical-align:middle; text-align:right; width:20%;"><?= $row->subtotal!=0?$this->erp->formatMoney($row->subtotal):$free; 
										$total += $row->subtotal;
										?></td>
								</tr>
								<?php
								$r++;
							endforeach;
							?>
						</tbody>
						<tfoot style="font-size: 13px;">
						<?php
						$col = 5;
						if ($Settings->product_serial) {
							$col++;
						}
						if ($Settings->product_discount) {
							$col++;
						}
						if ($Settings->tax1) {
							$col++;
						}
						if ($Settings->product_discount && $Settings->tax1) {
							$tcol = $col - 2;
						} elseif ($Settings->product_discount) {
							$tcol = $col - 1;
						} elseif ($Settings->tax1) {
							$tcol = $col - 1;
						} else {
							$tcol = $col;
						}
						$discount_percentage = '';
						if (strpos($inv->order_discount_id, '%') !== false) {
							$discount_percentage = $inv->order_discount_id;
						}
						?>
						<?php if ($inv->grand_total != $inv->total) { ?>
							<tr>
								<td colspan="<?= $tcol; ?>" style="text-align:right;"><?= lang("total"); ?>
									(<?= $default_currency->code; ?>)
								</td>
								<?php
								if ($Settings->tax1) {
									echo '<td style="text-align:right;">' . $this->erp->formatMoney($inv->product_tax) . '</td>';
								}
								if ($Settings->product_discount) {
									echo '<td style="text-align:right;">' . $this->erp->formatMoney($inv->product_discount) . '</td>';
								}
								?>
								<!-- <td style="text-align:right;"><?= $this->erp->formatMoney($inv->total + $inv->product_tax); ?></td> -->
								<td style="text-align:right;"><?= $this->erp->formatMoney($total); ?></td>
							</tr>
						<?php } ?>
						<?php if ($return_sale && $return_sale->surcharge != 0) {
							echo '<tr><td colspan="' . $col . '" style="text-align:right;">' . lang("surcharge") . ' (' . $default_currency->code . ')</td><td style="text-align:right;">' . $this->erp->formatMoney($return_sale->surcharge) . '</td></tr>';
						}
						?>
						<?php if ($inv->order_discount != 0) {
							echo '<tr><td colspan="' . $col . '" style="text-align:right;">' . lang("order_discount") . ' (' . $default_currency->code . ')</td><td style="text-align:right;"><span class="pull-left">'.($discount_percentage?"(" . $discount_percentage . ")" : '').'</span>' . $this->erp->formatMoney($inv->order_discount) . '</td></tr>';
						}
						?>
						<?php if ($Settings->tax2 && $inv->order_tax != 0) {
							echo '<tr><td colspan="' . $col . '" style="text-align:right;">' . lang("order_tax") . ' (' . $default_currency->code . ')</td><td style="text-align:right;">' . $this->erp->formatMoney($inv->order_tax) . '</td></tr>';
						}
						?>
						<?php if ($inv->shipping != 0) {
							echo '<tr><td colspan="' . $col . '" style="text-align:right;">' . lang("shipping") . ' (' . $default_currency->code . ')</td><td style="text-align:right;">' . $this->erp->formatMoney($inv->shipping) . '</td></tr>';
						}
						?>
						<tr>
							<td colspan="<?= $col; ?>"
								style="text-align:right; font-weight:bold;"><?= lang("total_amount"); ?>
								(<?= $default_currency->code; ?>)
							</td>
							<td style="text-align:right; font-weight:bold;"><?= $this->erp->formatMoney($inv->grand_total); ?></td>
						</tr>

						<tr>
							<td colspan="<?= $col; ?>" style="text-align:right; font-weight:bold;"><?= lang("paid"); ?>
								(<?= $default_currency->code; ?>)
							</td>
							<td style="text-align:right; font-weight:bold;"><?= $this->erp->formatMoney($inv->paid); ?></td>
						</tr>
						<tr>
							<td colspan="<?= $col; ?>" style="text-align:right; font-weight:bold;"><?= lang("balance"); ?>
								(<?= $default_currency->code; ?>)
							</td>
							<td style="text-align:right; font-weight:bold;"><?= $this->erp->formatMoney($inv->grand_total - $inv->paid); ?></td>
						</tr>

						</tfoot>
					</table>
				</div>

				<div class="row">
					<div class="col-xs-12">
						<?php if ($inv->note || $inv->note != "") { ?>
							<div class="well well-sm">
								<p class="bold"><?= lang("note"); ?>:</p>

								<div><?= $this->erp->decode_html($inv->note); ?></div>
							</div>
						<?php } ?>
					</div>
					<div class="clearfix"></div>
					<div class="col-xs-3  pull-left" style="text-align:center">
						<hr/>
						<p><?= lang("seller"); ?>
							<!--: <?= $biller->company != '-' ? $biller->company : $biller->name; ?> --></p>
						<!--<p><?= lang("stamp_sign"); ?></p>-->
					</div>
					<div class="col-xs-3  pull-right" style="text-align:center">
						<hr/>
						<p><?= lang("customer"); ?>
						   <!-- : <?= $customer->company ? $customer->company : $customer->name; ?> --></p>
						<!--<p><?= lang("stamp_sign"); ?></p>-->
					</div>
					<div class="col-xs-3  pull-right" style="text-align:center">
						<hr/>
						<p><?= lang("Account"); ?>
							<!--: <?= $customer->company ? $customer->company : $customer->name; ?>--> </p>
						<!--<p><?= lang("stamp_sign"); ?></p>-->
					</div>
					<div class="col-xs-3  pull-right" style="text-align:center">
						<hr/>
						<p><?= lang("Ware House"); ?>
							<!--: <?= $warehouse->company ? $warehouse->company : $warehouse->name; ?>--> </p>
						<!--<p><?= lang("stamp_sign"); ?></p>-->
					</div>
				</div>
			</div>
		</div>
	</div>


<?php 
if ($modal) {
	echo '</div></div></div>';
}?>