<div class="modal-dialog modal-lg no-modal-header">
    <div class="modal-content">
        <div class="modal-body">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                <i class="fa fa-2x">&times;</i>
            </button>
			<table class="table table-striped table-bordered table-condensed table-hover dfTable reports-table dataTable">
				<thead>
					<tr>
						<th><?=lang("code");?></th>
						<th><?=lang("name");?></th>
						<th><?=lang("unit");?></th>
						<th><?=lang("cost");?></th>
						<th><?=lang("price");?></th>
					</tr>
				</thead>
				<tbody align="center">
					<?php foreach($category as $row){ ?>
						<tr>
							<td align="left"><?php echo $row->code;?></td>
							<td align="left"><?php echo $row->name;?></td>
							<td><?php echo $row->unit_name;?></td>
							<td><?php echo $this->erp->formatMoney($row->cost);?></td>
							<td><?php echo $this->erp->formatMoney($row->price);?></td>
						</tr>
					<?php } ?>
				</tbody>
			</table>
		</div>
    </div>
</div>
