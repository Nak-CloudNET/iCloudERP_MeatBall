<div class="modal-dialog">
	<div class="modal-content">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal">&times;</button>
			<button type="button" class="prints"><i class="fa fa-print"></i></button>
			<h4 class="modal-title"><?=lang('view_order')?></h4>
		</div>
		<div class="modal-body">
			<div class="table-responsive" id="printarea">
				<table class="table table-hover table-bordered table-striped">
					<thead>
						<tr>
							<th><?=lang('product_name');?></th>
							<th><?=lang('price');?></th>
							<th><?=lang('quantity');?></th>
						</tr>
					</thead>
					<tbody>
						<?php
							
							foreach($data as $rows){
								echo '<tr>';
									echo '<td>'.$rows->product_name.'</td>';
									echo '<td>'.$rows->unit_price.'</td>';
									echo '<td>'.$rows->quantity.'</td>';
								echo '</tr>'; 
							}
						?>
					</tbody>
				</table>
			</div>
		</div>
    </div>
	<script>
		$(".prints").click(function () {
			$(".panel-body").hide();
			window.print();
			$(".panel-body").show();
		});
	</script>
</div>