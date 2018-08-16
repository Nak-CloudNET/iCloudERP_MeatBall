<?php
	function formatQuantity2($x, $decimal) {
		return ($x != null) ? number_format($x, $decimal) : '';
	}
	function pqFormat($x, $de){
		if($x != null){
			$d = '';
			$pqc = explode('___', $x);
			$i = 0;
			foreach($pqc as $pq){
				$v = explode('__', $pq);
				$d .= $v[0].' ('.formatQuantity2($v[1], $de).')<br/>';
			}
			return $d;
		}else{
			return false;
		}
	}
	function row_status($x) {
		if($x == null) {
			return '';
		} else if($x == 'pending' || $x == 'book' || $x == 'free') {
			return '<div class="text-center"><span class="label label-warning">'.lang($x).'</span></div>';
		} else if($x == 'completed' || $x == 'paid' || $x == 'sent' || $x == 'received') {
			return '<div class="text-center"><span class="label label-success">'.lang($x).'</span></div>';
		} else if($x == 'partial' || $x == 'partial_payment' || $x == 'transferring' || $x == 'ordered'  || $x == 'busy'  || $x == 'processing') {
			return '<div class="text-center"><span class="label label-info">'.lang($x).'</span></div>';
		} else if($x == 'due' || $x == 'returned') {
			return '<div class="text-center"><span class="label label-danger">'.lang($x).'</span></div>';
		} else {
			return '<div class="text-center"><span class="label label-default">'.lang($x).'</span></div>';
		}
	}
?>
<div class="modal-dialog modal-lg" style="width:75%;">
	<?php if ($Owner) {
		echo form_open('reports/salemandaily_actions', 'id="action-form"');
	} ?>
    <div class="modal-content">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal">&times;</button>
			<h4 class="modal-title">Report</h4>
		</div>
		<div class="modal-body">
			<div class="box">
				<div class="box-header">
					<h2 class="blue"><i class="fa-fw fa fa-heart nb"></i> <?= lang('staff_report'); ?></h2>
					<div class="box-icon">
						<ul class="btn-tasks">
							<li class="dropdown">
								<a href="#" id="pdf" data-action="export_pdf" class="tip" title="<?= lang('download_pdf') ?>">
									<i class="icon fa fa-file-pdf-o"></i>
								</a>
							</li>
							<li class="dropdown">
								<a href="#" id="excel"" class="tip" data-action="export_excel" title="<?= lang('download_xls') ?>">
									<i class="icon fa fa-file-excel-o"></i>
								</a>
							</li>
						</ul>
					</div>
				</div>
				<div class="box-content">
					<div class="row">
						<div class="col-lg-12">
							<p class="introtext"><?= lang('customize_report'); ?></p>
							<input type="hidden" value="<?= $datetime;?>" name="todaydate">
							<div class="clearfix"></div>
							<div class="table-responsive">
								<table id="SData" class="table table-bordered table-hover table-striped table-condensed reports-table">
									<thead>
										<tr>
											<th style="min-width:30px; width: 30px; text-align: center;">
												<input class="checkbox checkth" type="checkbox" name="check"/>
											</th>
											<th><?= lang("date"); ?></th>
											<th><?= lang("reference_no"); ?></th>
											<th><?= lang("biller"); ?></th>
											<th><?= lang("customer"); ?></th>
											<th><?= lang("product_qty"); ?></th>
											<th><?= lang("grand_total"); ?></th>
											<th><?= lang("paid"); ?></th>
											<th><?= lang("balance"); ?></th>
											<th><?= lang("payment_status"); ?></th>
										</tr>
									</thead>
									<tbody>
										<?php 
											if($data == ""){
												
											}else{
											foreach($data as $item){
										?>
											<tr>
												<td>
													<input type="checkbox" value="<?= $item->idd; ?>" name="val[]" class="checkbox multi-select input-xs">
												</td>
												<td><?= $item->date; ?></td>
												<td><?= $item->reference_no; ?></td>
												<td><?= $item->biller; ?></td>
												<td><?= $item->customer; ?></td>
												<td><?= pqFormat($item->iname, $decimals); ?></td>
												<td><?= $this->erp->formatMoney($item->grand_total); ?></td>
												<td><?= $this->erp->formatMoney($item->paid); ?></td>
												<td><?= $this->erp->formatMoney($item->balance); ?></td>
												<td><?= row_status($item->payment_status); ?></td>
											</tr>	
										<?php
											}
											}
										?>
									</tbody>
									<tfoot class="dtFilter">
										<tr class="active">
											<th style="min-width:30px; width: 30px; text-align: center;">
												<input class="checkbox checkth" type="checkbox" name="check"/>
											</th>
											<th></th>
											<th></th>
											<th></th>
											<th></th>
											<th></th>
											<th><?= lang("grand_total"); ?></th>
											<th><?= lang("paid"); ?></th>
											<th><?= lang("balance"); ?></th>
											<th></th>
										</tr>
									</tfoot>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
    </div>
	<?php if ($Owner) { ?>
		<div style="display: none;">
			<input type="hidden" name="form_action" value="" id="form_action"/>
			<?= form_submit('performAction', 'performAction', 'id="action-form-submit"') ?>
		</div>
		<?php form_close(); ?>
	<?php } ?>
</div>
