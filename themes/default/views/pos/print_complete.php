<style>
@media print {
	.no-print {
		display:none !important;
	}
	.print {
		display:block !important;
	}
}
</style>
<div class="modal-dialog">
	<div class="modal-content">
		<div class="modal-header">
			<button type="button" class="close no-print" data-dismiss="modal">&times;</button>
			<button type="button" class="prints no-print"><i class="fa fa-print" aria-hidden="true"></i></button>
			<h5 class="modal-title"><?= lang('print');?></h5>
		</div>
		<div class="modal-body">
			 <div class="table-responsive show-print">
				<table class="table table-hover table-bordered table-striped">
					<thead>
						<tr>
							<th><?= lang('product_name');?></th>
							<th><?= lang('unit_price');?></th>
							<th><?= lang('quantity');?></th>
						</tr>
					</thead>
					<tbody>
						<?php
						foreach($data as $item){
						?>
						<tr>
							<th><?= $item->product_name.' ('.$item->product_code.')';?></th>
							<th><?= $item->price;?></th>
							<th><input class="form-control quantity no-print" value="<?= $this->erp->formatQuantity($item->quantity);?>"><span style="display:none" class="print qty"></span></th>
						</tr>
						<?php
							}
						?>
					</tbody>
				</table>
			</div> 
		</div>
    </div>
	<script>
		$(document).ready(function () {
			$(".quantity").on('change', function(){
				var val = $(this).val();
				$(this).parent().find('.qty').text(val);
			}).trigger('change');
		});
		$(".prints").click(function () {
			$('.panel-body').hide();
			window.print($(".show-print").html());
			$('.panel-body').show();
			window.location.reload();
		});
			
	</script>
  </div>