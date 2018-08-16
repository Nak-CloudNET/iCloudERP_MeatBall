<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title><?= lang('view_order')?></title>
    <base href="<?= base_url() ?>"/>
    <meta http-equiv="cache-control" content="max-age=0"/>
    <meta http-equiv="cache-control" content="no-cache"/>
    <meta http-equiv="expires" content="0"/>
	<meta http-equiv="refresh" content="300">
    <meta http-equiv="pragma" content="no-cache"/>
    <link rel="stylesheet" href="<?= $assets ?>styles/kitchen.css" type="text/css"/>
    <link rel="stylesheet" href="<?= $assets ?>styles/helpers/bootstrap.min.css" type="text/css" />
	<link rel="stylesheet" href="<?= $assets ?>pos/css/posajax.css" type="text/css"/>
</head>
<body>
<div class="wrapper">
    <div class="col-sm-12">
        <div class="panel panel-default">
            <div class="panel-body">
                <div class="containers">
                    <table>
                        <?php
                            $i=1;
                            foreach($data as $order)
                            {
                        ?>
                            <tr>
                                <td>
                                    <div class="order-table" id="<?=$order->id?>">
                                        <span style="font-size:11pt;font-weight:bold" class="refer<?=$order->id?>"><?= $order->reference_no;?> </span>
                                        <div>
                                            <span><?= lang('qty'); ?>: </span>
                                            <span style="font-size:18pt;font-weight:bold">
                                                <?php
                                                    $this->db->select("sum(erp_sale_items.quantity) as num")
                                                        ->from('sale_items')
                                                        ->join('sales', 'sales.id = sale_items.sale_id', 'left')
                                                        ->where('sale_items.sale_id', $order->id);
                                                    $q = $this->db->get();
                                                    if ($q->num_rows() > 0) {
                                                        foreach ($q->result() as $row) {
                                                            echo $this->erp->formatQuantity($row->num);
                                                        }
                                                    }
                                                ?>											
                                            </span>
											<input type="hidden" value="<?= $order->id?>" name="item_id">
                                        </div>
										<div class="action">
											<div class="col-sm-4 col-xs-4  dollor" id="<?=$order->id?>"><i class="fa fa-usd" aria-hidden="true"></i></div>
											<div class="col-sm-4 col-xs-4 truck" id="<?=$order->id?>"><i class="fa fa-truck" aria-hidden="true"></i></div>
											<div class="col-sm-4 col-xs-4 addplus new" text="" id="<?=$order->id?>"><i class="fa fa-plus" aria-hidden="true"></i></div>
										</div>
                                    </div>
                                </td>
                                <?php
                                $this->db->select('erp_products.id as idd, product_code, erp_sale_items.product_name, erp_products.image, erp_sale_items.quantity, erp_sale_items.id as sale_id, erp_sale_items.sale_id as idsale')
                                         ->from('sale_items')
                                         ->join('products', 'products.id = sale_items.product_id', 'left')
                                         ->where('erp_sale_items.sale_id', $order->id);
                                $q = $this->db->get();
                                if ($q->num_rows() > 0) {
                                    foreach ($q->result() as $frow) {
										$qty = '';
										if($frow->quantity != 0){
											$qty = number_format($frow->quantity);
										}else{
											$qty = 0;
										}
										$this->db->select('quantity')
												 ->from('delivery_items')
												 ->where(array('sale_id'=>$frow->idsale, 'product_id'=>$frow->idd));
										$q = $this->db->get();
										$quantity = '';
										if ($q->num_rows() > 0) {
											foreach ($q->result() as $qq) {
												$quantity = number_format($qq->quantity);
											}
										}
                            ?>
                                <td>
                                    <div class="food <?= $quantity == $qty ? 'change' : ''?>">
										<span class="tick">
											<input type="checkbox" value="<?=$frow->idd?>" name="tick_id[]" <?= $quantity == $qty ? 'disabled' : '';?> class="id_tick<?=$order->id?>">
										</span>
                                        <span id="<?=base_url()."pos/deleteOrderitem/".$frow->idd?>" class="clear"><i class="fa fa-times icon" aria-hidden="true"></i></span>
                                        <img src="<?=base_url().'assets/uploads/'.$frow->image?>" class="img-thumbnail"/>
										<span class="qty">
											<div id="<?=$frow->sale_id?>" class="col-sm-4 col-xs-4 <?= $quantity == $qty ? 'minusd' : 'minus'?>">
												<i class="fa fa-minus icons" aria-hidden="true"></i>
                                            </div>
											<div class="col-sm-4 col-xs-4 no-padd">
												<div class = "input-group">
													<input type = "text" id="val<?=$frow->sale_id?>" class="num<?=$order->id?> input_type" value="<?= $quantity == '' ? '0' : $quantity;?>" <?= $quantity == $qty ? 'disabled' : '';?> >
													<span class = "input-group-addon input_show">
														<?=$qty;?>
													</span>
												</div>
											</div>
											<div id="<?=$frow->sale_id?>" class="col-sm-4 col-xs-4 <?= $quantity == $qty ? 'plusd' : 'plus'?>">
												<i class="fa fa-plus iconplus" aria-hidden="true"></i>
                                            </div>
										</span>
                                    </div>
                                </td>
                            <?php
                                    }
                                }
                            ?>    
                            </tr>
                        <?php
                            $i++;
                            }
                        ?>
                    </table>
                </div>
				<?php if ($page) { ?>
					<div class="modal-footer" style="padding:0;">
						<center>
							<div class="page_con"><?= $page ?></div>
						</center>
					</div>
				<?php } ?>
            </div>
        </div>	
    </div>
	<div id="myModal" class="modal fade" role="dialog"></div>
    <div class="modal" id="seFoModal" tabindex="-1" role="dialog" aria-labelledby="prModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true"><i class="fa fa-2x">&times;</i></span><span class="sr-only"><?=lang('close');?></span></button>
                    <h4 class="modal-title" id="prModalLabel"><?=lang('add_product');?></h4>
                </div>
				<?php $attrib = array('data-toggle' => 'validator', 'role' => 'form', 'id' => 'pos-sale-form');
                echo form_open("pos/addOrderitem", $attrib); ?>
					<div class="result"></div>
				<?php echo form_close()?>
                <div class="modal-body" id="pr_popover_content">
					<div class="well well-sm">
						<div style="margin-bottom:0;" class="form-group">
							<div class="input-group wide-tip">
								<div style="padding-left: 10px; padding-right: 10px;" class="input-group-addon">
									<i class="fa fa-2x fa-barcode addIcon"></i>
								</div>
								<input type="text" placeholder="Please add products to order list" id="add_item" class="form-control input-lg ui-autocomplete-input" value="" name="add_item" autocomplete="off"/>
							</div>
						</div>
						<div class="clearfix"></div>
					</div>
                    <form class="form-horizontal" role="form" id="s_seModal">
                        <table class="table table-bordered colors">
                            <thead>
                                <tr>
                                    <th style="width:45px;">
                                        <center>
                                            <input class="checkbox checkth input-xs" type="checkbox" name="check"/>
                                        </center>
                                    </th>
                                    <th><?php echo lang('code'); ?></th>
                                    <th><?php echo lang('name'); ?></th>
                                    <th><?php echo lang('quantity'); ?></th>
                                </tr>
                            </thead>
                            <tbody class="floor"></tbody>
                        </table>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" id="addItem"><?= lang('submit') ?></button>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript" src="<?= $assets ?>js/jquery-2.0.3.min.js"></script>
<script type="text/javascript" src="<?= $assets ?>js/jquery-ui.min.js"></script>
<script type="text/javascript" src="<?= $assets ?>pos/js/plugins.min.js"></script>
<script type="text/javascript" src="<?= $assets ?>js/bootstrap.min.js"></script>
<script>
	$(document).ready(function(){
		$('.check').each(function(){
			var color = $(this).val();
		});
		
		$('.order-table').click(function(){
			var pa_id = $(this).attr('id');
			var base_url = '<?php echo base_url()?>';
			$('#myModal').modal({remote: base_url + 'pos/view_order_print/' + pa_id});
			$('#myModal').modal('show');
		});
		$('#myModal').on('hidden.bs.modal', function() {
			window.location.reload();
		});
		$('.clear').click(function(){
			var id = $(this).attr('id');
			window.location.href = id;
		});
		$('.truck').click(function(){
			var arr   = []; 
			var array = [];
			var pa_id = $(this).attr('id');
			/*
			$('.id_tick'+pa_id).each(function(id){
				var id = $(this).val();
				arr.push(id);
			});
			*/
			$(":checkbox:checked").each(function() {
				var id = $(this).val();
				arr.push(id);
			});
			$('.num'+pa_id).each(function(){
				var id = $(this).val();
				if(id != 0){
					array.push(id);
				}
			});
			
			var refer  = $('.refer'+pa_id).text();
			var pro_id = arr.join(",");
			var qty = array.join(",");
			if(pro_id == ''){
				alert('please select any products!');
			}else{
				$.ajax({
					type: "GET",
					url: '<?= site_url('pos/addDeliveryitem'); ?>',
					data: {
						pro_id : pro_id,
						refer  : refer,
						qty    : qty,
						sale_id: pa_id
					},
					success: function(data)
					{
						base_url = '<?php echo base_url()?>';
						$('#myModal').modal({remote: base_url + 'pos/view_order_print/' + pa_id});
						//window.location.reload();
						$('#myModal').modal('show');
					}
				});
			}
			
		});
		$('.dollor').click(function(){
			var sid = $(this).attr("id");
            window.location.href = "<?= site_url('pos/index') ?>/" + sid;
            
            return false;
		});
        var idd = '';
		var ware = '';
		$('.new').click(function(){
            idd = $(this).attr('id');
            $('#seFoModal').appendTo("body").modal('show');
            return false;
        });
		$('#addItem').click(function(){
			var arr = [];
			var test = '';
			var result = $('input[name="val"]:checked');
			if(result.length > 0){
				result.each(function(){
					var str = $(this).val();
					arr.push(str);
					product_id = arr.join(',');
					//window.location.href = '<?= base_url().'pos/add_item/'?>' + str +'/'+ idd;
				});
			}
			//var html = '<input type="text" value="'+product_id+'" name="pro_id"/><input type="text" value="'+idd+'" name="sus_id"/><input type="text" value="'+ware+'" name="ware_id"/>';
			//$(html).appendTo('.result');
			//$('#pos-sale-form').submit();
			//alert(id +'-'+ product_id);
			$.ajax({
				type: "GET",
				url: '<?= site_url('pos/addOrderitem'); ?>',
				data: {
					pro_id : product_id,
					sale_id: idd
				},
				success: function(data)
				{
					window.location.reload();
				}
			});
		});
        $("#add_item").autocomplete({
			search: function(event, ui) {
				$('.floor').empty();
			},
            source: function (request, response) {
				var test = request.term;
				if($.isNumeric(test)){
					$.ajax({
						type: 'get',
						url: '<?= site_url('pos/suggests'); ?>',
						dataType: "json",
						data: {
							term: request.term,
							pros: idd
						},
						success: function (data) {
							response(data);
						}
					});
				}else{
					$.ajax({
						type: 'get',
						url: '<?= site_url('pos/suggestions'); ?>',
						dataType: "json",
						data: {
							term: request.term,
							pros: idd
						},
						success: function (data) {
							response(data);
						}
					});
				}
            },
			minLength: 1,
            autoFocus: false,
            delay: 200,
            response: function (event, ui) {
                if ($(this).val().length >= 16 && ui.content[0].id == 0) {
                    //audio_error.play();
					
                   bootbox.alert('<?= lang('no_match_found') ?>', function () {
                        $('#add_item').focus();
                    });
					
                    $(this).val('');
                }
				/*
                else if (ui.content.length == 1 && ui.content[0].id != 0) {
                    ui.item = ui.content[0];
                    $(this).data('ui-autocomplete')._trigger('select', 'autocompleteselect', ui);
                    $(this).autocomplete('close');
                    $(this).removeClass('ui-autocomplete-loading');
                }
				*/
                else if (ui.content.length == 1 && ui.content[0].id == 0) {
                    bootbox.alert('<?= lang('no_match_found') ?>', function () {
                        $('#add_item').focus();
                    });
                }
            },
            select: function (event, ui) {
                event.preventDefault();
                if (ui.item.id !== 0) {
                    var row = add_purchase_item(ui.item);
                    if (row)
                        $(this).val('');
                } else {
                    //audio_error.play();
                    bootbox.alert('<?= lang('no_match_found') ?>');
                }
            },
			open: function(event, ui) {
				$(".ui-autocomplete").css("width", "0");
				$(".ui-autocomplete").css("z-index", "99999");
			}
        }).autocomplete( "instance" )._renderItem = function( ul, item ) {
			var inner_html  = 	'<td style="width:50px;height:30px;">' +
									'<center>'+
										'<input class="checkbox multi-select input-xs" type="checkbox" name="val" value="'+ item.id +'"/>'+
									'</center>' +
								'</td>' +
								'<td style="width:140px;">'+
									item.code +
								'</td>' +
								'<td style="width:142px;">'+
									item.label +
								'</td>' +
								'<td style="width:114px;">'+
									item.qty +
								'</td>';
			return $( "<tr></tr>")
				.data( "item.autocomplete", item )
				.append(inner_html)
				.appendTo($('.floor'));
		}
		
		$('#add_item').bind('keypress', function (e) {
            if (e.keyCode == 13) {
                e.preventDefault();
                $(this).autocomplete("search");
            }
        });

        $('.minus').click(function(){
			var minus = $(this).attr('id');
			minus_number(minus);
        });
		
		$('.plus').click(function(){
			var plus = $(this).attr('id');
			plus_number(plus);
        });
		
		function minus_number(num){
			var val   = $('#val'+num).val();
			var minus = Math.max(parseInt(val) - 1);
			$('#val'+num).val(minus);
		}
		
		function plus_number(num){
			var val   = $('#val'+num).val();
			var plus  = Math.max(parseInt(val) + 1);
			$('#val'+num).val(plus);
		}
	});
</script>
</body>
</html>