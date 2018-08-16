<?php

$v = "";
if ($this->input->post('start_date')) {
    $v .= "&start_date=" . $this->input->post('start_date');
}
if ($this->input->post('end_date')) {
    $v .= "&end_date=" . $this->input->post('end_date');
}
?>
<script>
    $(document).ready(function () {
        var oTable = $('#SlRData').dataTable({
            "aaSorting": [[0, "desc"]],
            "aLengthMenu": [[10, 25, 50, 100, -1], [10, 25, 50, 100, "<?= lang('all') ?>"]],
            "iDisplayLength": <?= $Settings->rows_per_page ?>,
            'bProcessing': true, 'bServerSide': true,
            'sAjaxSource': '<?= site_url('reports/getOpeningDetail/'.$purchase_details->product_code) ?>',
            'fnServerData': function (sSource, aoData, fnCallback) {
                aoData.push({
                    "name": "<?= $this->security->get_csrf_token_name() ?>",
                    "value": "<?= $this->security->get_csrf_hash() ?>"
                });
                $.ajax({'dataType': 'json', 'type': 'POST', 'url': sSource, 'data': aoData, 'success': fnCallback});
            },
			"bAutoWidth": false,
            "aoColumns": [null, null, {"mRender": fld}, {"mRender": currencyFormat}, {"mRender": currencyFormat}, {"mRender": currencyFormat}],
            "fnFooterCallback": function (nRow, aaData, iStart, iEnd, aiDisplay) {
                var unit_cost = 0, qty = 0, cogs = 0;
                for (var i = 0; i < aaData.length; i++) {
						unit_cost += parseFloat(aaData[aiDisplay[i]][3]);
						qty += parseFloat(aaData[aiDisplay[i]][4]);
						cogs += parseFloat(aaData[aiDisplay[i]][5]);
                }
                var nCells = nRow.getElementsByTagName('th');
                nCells[3].innerHTML = currencyFormat(parseFloat(unit_cost));
                nCells[4].innerHTML = currencyFormat(parseFloat(qty));
                nCells[5].innerHTML = currencyFormat(parseFloat(cogs));
            }
        }).fnSetFilteringDelay().dtFilter([
			{column_number: 0, filter_default_label: "[<?=lang('product_code');?>]", filter_type: "text", data: []},
			{column_number: 1, filter_default_label: "[<?=lang('product_name');?>]", filter_type: "text", data: []},
            {column_number: 2, filter_default_label: "[<?=lang('date');?> (yyyy-mm-dd)]", filter_type: "text", data: []},   
        ], "footer");
    });
</script>
<div class="modal-dialog modal-lg">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="fa fa-2x">&times;</i>
            </button>
			<button type="button" class="btn btn-xs btn-default no-print pull-right" style="margin-right:15px;" onclick="window.print();">
                <i class="fa fa-print"></i> <?= lang('print'); ?>
            </button>
            <h4 class="modal-title" id="myModalLabel"><?php echo $this->lang->line('View Purchase Detail'); ?></h4>
        </div>
        <div class="modal-body">
            <div class="table-responsive">
                <table id="SlRData"
                           class="table table-bordered table-hover table-striped table-condensed reports-table">
                        <thead>
                    <tr>
                        <th style="width:10%;"><?= $this->lang->line("product_code"); ?></th>
                        <th style="width:25%;"><?= $this->lang->line("product_name"); ?></th>
						<th style="width:10%;"><?= $this->lang->line("date"); ?></th>
                        <th style="width:15%;"><?= $this->lang->line("unit_cost"); ?></th>
						<th style="width:15%;"><?= $this->lang->line("quantity"); ?></th>
						<th style="width:15%;"><?= $this->lang->line("cogs"); ?></th>
                    </tr>
                    </thead>
                    <tbody>
						<tr>
                            <td colspan="6" class="dataTables_empty"><?= lang('loading_data_from_server') ?></td>
                        </tr>
                    </tbody>
					<tfoot class="dtFilter">
                        <tr class="active">
							<th style="min-width:5%; width: 5%; text-align: center;"></th>
                            <th></th>
                            <th></th>
                            <th></th>
                            <th></th>
                            <th></th>
                        </tr>
                        </tfoot>
                </table>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript" charset="UTF-8">
    $(document).ready(function () {
        $(document).on('click', '.po-delete', function () {
            var id = $(this).attr('id');
            $(this).closest('tr').remove();
        });
    });
</script>
