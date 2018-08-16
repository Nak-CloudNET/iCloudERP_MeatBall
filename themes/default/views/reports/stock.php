<?php
	$v = "";

	if($this->input->post('product_name')){
		$v .= "&product_name=" .$this->input->post('product_name');
	}
	if($this->input->post('daterange')){
		$getDate = $this->input->post('daterange');
		$getDate_ = explode(" - ",$getDate[0]);
		$start_date   = $getDate_[0];
		$end_date     = $getDate_[1];
		$v .="&start=" .$start_date."&end=".$end_date;
	}

?>
<script>
    $(document).ready(function () {
        var oTable = $('#PrRData').dataTable({
            "aaSorting": [[3, "desc"], [2, "desc"]],
            "aLengthMenu": [[10, 25, 50, 100, -1], [10, 25, 50, 100, "<?= lang('all') ?>"]],
            "iDisplayLength": <?= $Settings->rows_per_page ?>,
            'bProcessing': true, 'bServerSide': true,
            'sAjaxSource': '<?= site_url('reports/daily_stock/?v=1'.$v) ?>',
            'fnServerData': function (sSource, aoData, fnCallback) {
                aoData.push({
                    "name": "<?= $this->security->get_csrf_token_name() ?>",
                    "value": "<?= $this->security->get_csrf_hash() ?>"
                });
                $.ajax({'dataType': 'json', 'type': 'POST', 'url': sSource, 'data': aoData, 'success': fnCallback});
            },
			'fnRowCallback': function (nRow, aData, iDisplayIndex) {
                var oSettings = oTable.fnSettings();
                //$("td:first", nRow).html(oSettings._iDisplayStart+iDisplayIndex +1);
                
				nRow.id = aData[0];
					//nRow.className = "category_link";
                return nRow;
            },
            "aoColumns": [
				{"bSortable": false, "mRender": checkbox}, null, null, 
				{"mRender": formatQuantity}, 
				{"mRender": formatQuantity}, 
				{"mRender": formatQuantity}, 
				{"mRender": formatQuantity}, 
				{"mRender": formatQuantity}, null],
            "fnFooterCallback": function (nRow, aaData, iStart, iEnd, aiDisplay) {
                var opening_qty = 0, total_sale = 0, balance = 0, stock_remain = 0, import_stock = 0;
                for (var i = 0; i < aaData.length; i++) {
					import_stock += parseFloat(aaData[aiDisplay[i]][3]);
					stock_remain += parseFloat(aaData[aiDisplay[i]][4]);
					opening_qty += parseFloat(aaData[aiDisplay[i]][5]);
					total_sale += parseFloat(aaData[aiDisplay[i]][6]);
					balance += parseFloat(aaData[aiDisplay[i]][7]); 
                }
                var nCells = nRow.getElementsByTagName('th');
                nCells[3].innerHTML = formatQuantity(parseFloat(import_stock));
                nCells[4].innerHTML = formatQuantity(parseFloat(stock_remain));
                nCells[5].innerHTML = formatQuantity(parseFloat(opening_qty));
                nCells[6].innerHTML = formatQuantity(parseFloat(total_sale));
                nCells[7].innerHTML = formatQuantity(parseFloat(balance));
            }
        }).fnSetFilteringDelay().dtFilter([
            {column_number: 1, filter_default_label: "[<?=lang('product_code');?>]", filter_type: "text", data: []},
            {column_number: 2, filter_default_label: "[<?=lang('product_name');?>]", filter_type: "text", data: []},
        ], "footer");
    });
</script>
<script type="text/javascript">
    $(document).ready(function () {
        $('#form').hide();
        $('.toggle_down').click(function () {
            $("#form").slideDown();
            return false;
        });
        $('.toggle_up').click(function () {
            $("#form").slideUp();
            return false;
        });

    });
</script>
<?php if ($Owner) {
    echo form_open('reports/categories_actions', 'id="action-form"');
} ?>
<div class="box">
    <div class="box-header">
        <h2 class="blue"><i class="fa-fw fa fa-folder-open"></i><?= lang('daily_stock'); ?> <?php
            if ($this->input->post('start_date')) {
                echo "From " . $this->input->post('start_date') . " to " . $this->input->post('end_date');
            }
            ?>
		</h2>
        <div class="box-icon">
            <ul class="btn-tasks">
                <li class="dropdown"><a href="#" class="toggle_up tip" title="<?= lang('hide_form') ?>"><i
                            class="icon fa fa-toggle-up"></i></a></li>
                <li class="dropdown"><a href="#" class="toggle_down tip" title="<?= lang('show_form') ?>"><i
                            class="icon fa fa-toggle-down"></i></a></li>
            </ul>
        </div>
        <div class="box-icon">
            <ul class="btn-tasks">
                <li class="dropdown"><a href="#" id="pdf" data-action="export_pdf"  class="tip" title="<?= lang('download_pdf') ?>"><i
                            class="icon fa fa-file-pdf-o"></i></a></li>
                <li class="dropdown"><a href="#" id="xls" data-action="export_excel"  class="tip" title="<?= lang('download_xls') ?>"><i
                            class="icon fa fa-file-excel-o"></i></a></li>
                <li class="dropdown"><a href="#" id="image" class="tip" title="<?= lang('save_image') ?>"><i
                            class="icon fa fa-file-picture-o"></i></a></li>
            </ul>
        </div>
    </div>
<?php if ($Owner) { ?>
    <div style="display: none;">
        <input type="hidden" name="form_action" value="" id="form_action"/>
        <?= form_submit('performAction', 'performAction', 'id="action-form-submit"') ?>
    </div>
    <?php echo form_close(); ?>
<?php } ?>
<?php 
?>    
	<div class="box-content">
        <div class="row">
            <div class="col-lg-12">

                <p class="introtext"><?= lang('customize_report'); ?></p>

                <div id="form">

                    <?php echo form_open("reports/stock"); ?>
                    <div class="row">
                         <div class="col-sm-4">
							<div class="form-group choose-date hidden-xs" style="width:100%;">
								<?= lang("date", "date") ?>
								<div class="controls">
									<div class="input-group">
										<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
										<input type="text" value="<?= ($start > 0 && $end > 0 ? $start .' - '. $end : date('d/m/Y 00:00') . ' - ' . date('d/m/Y 23:49')) ?>" id="daterange" name ="daterange[]" class="form-control">
									</div>
								</div>
							</div>
						</div>
						<div class="col-sm-4">
                            <div class="form-group">
                                <?= lang("product_name", "product_name") ?>
                                <?php
                                $pro['0'] = lang("all");
                                foreach ($products as $product) {
                                    $pro[$product->id] = $product->name;
                                }
                                echo form_dropdown('product_name', $pro, (isset($_POST['product_name']) ? $_POST['product_name'] : ''), 'class="form-control select" id="category_name" placeholder="' . lang("select") . " " . lang("product_name") . '" style="width:100%"')
                                ?>
                            </div>
                        </div>  
                    </div>
                    <div class="form-group">
                        <div
                            class="controls"> <?php echo form_submit('submit_report', $this->lang->line("submit"), 'class="btn btn-primary"'); ?> </div>
                    </div>
                    <?php echo form_close(); ?>

                </div>

                <div class="clearfix"></div>

                <div class="table-responsive">
                    <table id="PrRData"
                           class="table table-striped table-bordered table-condensed table-hover dfTable reports-table"
                           style="margin-bottom:5px;">
                        <thead>
                        <tr class="active">
							<th style="min-width:5px; width: 5px; text-align: center;">
                                <input class="checkbox checkth" type="checkbox" name="check"/>
                            </th>
                            <th style="min-width: 5px; width: 5px; text-align: center;"><?= lang("product_code"); ?></th>
                            <th><?= lang("product_name"); ?></th>
                            <th><?= lang("stock_remain"); ?></th>
                            <th><?= lang("import_stock"); ?></th>
                            <th><?= lang("opening_quantity"); ?></th>
                            <th><?= lang("sales_qty"); ?></th>
                            <th><?= lang("stock_in_hand"); ?></th>
                            <th><?= lang("action"); ?></th> 
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td colspan="6" class="dataTables_empty"><?= lang('loading_data_from_server') ?></td>
                        </tr>
                        </tbody>
                        <tfoot class="dtFilter">
                        <tr class="active">
							<th style="min-width:10px; width: 10px; text-align: center;">
                                <input class="checkbox checkth" type="checkbox" name="check"/>
                            </th>
                            <th style="min-width: 5; width: 5px; text-align: center;"></th>
                            <th></th>
                            <th></th>
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
</div>

<script type="text/javascript" src="<?= $assets ?>js/html2canvas.min.js"></script>
<script type="text/javascript">
  /*  $(document).ready(function () {

        $('#pdf').click(function (event) {
            event.preventDefault();
            window.location.href = "<?=site_url('reports/getCategoriesReport/pdf/?v=1'.$v)?>";
            return false;
        });
        $('#xls').click(function (event) {
            event.preventDefault();
            window.location.href = "<?=site_url('reports/getCategoriesReport/0/xls/?v=1'.$v)?>";
            return false;
        });

        $('#image').click(function (event) {
            event.preventDefault();
            html2canvas($('.box'), {
                onrendered: function (canvas) {
                    var img = canvas.toDataURL()
                    window.open(img);
                }
            });
            return false;
        });
    });*/
</script>