<?php if ($Owner) {
    echo form_open('reports/room_actions', 'id="action-form"');
} ?>
<div class="box">
    <div class="box-header">
        <h2 class="blue"><i class="fa-fw fa fa-users"></i><?= lang('suspend_profit_loss'); ?></h2>

        <!--<div class="box-icon">
            <ul class="btn-tasks"> 
                <li class="dropdown">
                    <a data-toggle="dropdown" class="dropdown-toggle" href="#">
						<i class="icon fa fa-tasks tip" data-placement="left" title="<?= lang("actions") ?>"></i>
					</a>
                    <ul class="dropdown-menu pull-right" class="tasks-menus" role="menu" aria-labelledby="dLabel">
                        <li><a href="<?= site_url('system_settings/addSuppend'); ?>" data-toggle="modal" data-target="#myModal"
                               id="add"><i class="fa fa-plus-circle"></i> <?= lang("add_Suppend"); ?></a></li>
                        <li><a href="<?= site_url('system_settings/import_chart_csv'); ?>" data-toggle="modal" data-target="#myModal"><i class="fa fa-plus-circle"></i> <?= lang("add_suppend_csv"); ?></a></li>
                        <li><a href="#" id="excel" data-action="export_excel"><i class="fa fa-file-excel-o"></i> <?= lang('export_to_excel') ?></a></li>
                        <li><a href="#" id="pdf" data-action="export_pdf"><i class="fa fa-file-pdf-o"></i> <?= lang('export_to_pdf') ?></a></li>
                        <li class="divider"></li>
                        <li><a href="#" class="bpo" title="<b><?= $this->lang->line("delete_suppend") ?></b>"
                               data-content="<p><?= lang('r_u_sure') ?></p><button type='button' class='btn btn-danger' id='delete' data-action='delete'><?= lang('i_m_sure') ?></a> <button class='btn bpo-close'><?= lang('no') ?></button>"
                               data-html="true" data-placement="left"><i
                                    class="fa fa-trash-o"></i> <?= lang('delete_suppend') ?></a></li>
                    </ul>
                </li>
            </ul>
        </div>-->
    </div>
    <div class="box-content">
        <div class="row">
            <div class="col-lg-12">

                <p class="introtext"><?= lang('list_results'); ?></p>

                <div class="table-responsive">
                    <table id="ProData" cellpadding="0" cellspacing="0" border="0" class="table table-bordered table-condensed table-hover table-striped">
                        <thead>
							<tr class="primary">
								<th style="width:10%;" rowspan="2"><?= lang("no"); ?></th>
								<th style="width:20%;" rowspan="2"><?= lang("description"); ?></th>
								<th style="width:20%;" colspan="6"><?= lang("revenuce"); ?></th>
								<th style="width:20%;" colspan="2"><?= lang("expenses"); ?></th>
								<th style="width:100px;" rowspan="2"><?php echo lang('date'); ?></th>
							</tr>
							<tr class="primary">
								<th style="background-color:#428BCA;border-color:#357ebd;color:#fff;text-align:center;"><?= lang("rent"); ?></th>
								<th style="background-color:#428BCA;border-color:#357ebd;color:#fff;text-align:center;"><?= lang("security_deposit"); ?></th>
								<th style="background-color:#428BCA;border-color:#357ebd;color:#fff;text-align:center;"><?= lang("water"); ?></th>
								<th style="background-color:#428BCA;border-color:#357ebd;color:#fff;text-align:center;"><?= lang("electricity"); ?></th>
								<th style="background-color:#428BCA;border-color:#357ebd;color:#fff;text-align:center;"><?= lang("internet"); ?></th>
								<th style="background-color:#428BCA;border-color:#357ebd;color:#fff;text-align:center;"><?= lang("others"); ?></th>
								<th style="background-color:#428BCA;border-color:#357ebd;color:#fff;text-align:center;"><?= lang("commission"); ?></th>
								<th style="background-color:#428BCA;border-color:#357ebd;color:#fff;text-align:center;"><?= lang("others"); ?></th>
							</tr>
                        </thead>
                        <tbody>
							<tr>
								<td colspan="11" class="dataTables_empty"><?= lang('loading_data_from_server') ?></td>
							</tr>
                        </tbody>
                        <tfoot class="dtFilter">
							<tr class="active">
								<th></th>
								<th></th>
								<th></th>
								<th></th>
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
<?php if ($Owner) { ?>
    <div style="display: none;">
        <input type="hidden" name="form_action" value="" id="form_action"/>
        <?= form_submit('performAction', 'performAction', 'id="action-form-submit"') ?>
    </div>
    <?= form_close() ?>
<?php } ?>

	

