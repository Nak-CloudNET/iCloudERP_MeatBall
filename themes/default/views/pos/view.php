<style type="text/css" media="all">
	* {
	margin: 0;
	padding:0;				  
		box-sizing: border-box; 
	}
	.padding0{
		padding:0px;
	}
	.bt{
		width:150px; 
		border:solid 2px;
		margin:0px;
		color:#AFAEAE !important;
	}
	.title h1{
			font-family:Khmer OS Muol Light;
			color:orange!important;
			text-decoration:underline;
			text-decoration-style:double;
			}
	body {
		margin: 0; 
		font-weight: 500;
		-webkit-print-color-adjust: exact;
	}
	.row-content{
		width:100%;
		float:left;
	}
	.foot{
		border-bottom:1px solid #fff !important;
		border-left:1px solid #fff !important;
		padding-right:20px;
	}
	.sub-title h2{
			font-family:Khmer OS Muol;
			font-size:25px;
			margin-bottom:20px;
	}
	.bg th{
		background-color:orange !important;	
		text-align:center !important;
		font-size:18px !important;
	}
	.border_style{		
		padding-left : 0px !important;
		padding-right : 0px !important;
		padding-top : 0px !important;
		border-top : 0px !important;
	}
</style>
<div class="modal-dialog no-modal-header modal-lg border_style">
	<div class="modal-content">
		<div class="modal-body">
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
				<i class="fa fa-2x">&times;</i>
			</button>

			<div class="wraper">  
				<div class="container-fluid pdT50">
					<div class="row-content">
						   <div class="col-md-12 padding0">
						   <div class="col-md-6 col-sm-6 col-xs-6">
								<img src="<?= base_url() . 'assets/uploads/logos/' . $biller->logo; ?>"
								alt="<?= $biller->company != '-' ? $biller->company : $biller->name; ?>">
						   </div>
						   <div class="col-md-6 col-sm-6 col-xs-6">
							   <div class="pull-right title">
								 <h1>វិក័យប័ត្រ</h1>
							   </div>
						   </div>
						</div>
					</div>
					<div class="row-content">
						<div class="col-md-12 padding0">
							<div class="col-md-6 col-sm-8 col-xs-6">
								<div class="sub-title"><h2>សិប្បកម្មជាងួន</h2></div>
								<div class="describe"><p>ផលិតផលប្រហិតសាច់គោ ប្រហិតសាច់ជ្រូក</p></div>
								<table width="99%" border="0">
									<tr>
										<td valign="top" width="90px">អាស័យដ្ឋាន :</td>
										<td>
											 <?php
											   echo $biller->address;'<br>'
											  ?>
										</td>
									</tr>
									<tr>
										<td>ទំនាក់ទំនង​​ :</td>
										<td><?php echo $biller->phone;?></td>
									</tr>
									<tr>
										<td>អ៊ីម៉ែល​ :</td>
										<td><?php echo $biller->email;?></td>
									</tr>
									<tr>
										<td>ហ្វេសប៊ុក :</td>
										<td>បិតាប្រហិត888</td>
									</tr>
								</table>
							</div>
							<div class="col-md-6 col-sm-4 col-xs-6">
								<div class="invoice">
									<div class="pull-right">
									   <table  width="100%">
										  <tr>
											  <td width="115px"><?= lang("កាលបរិច្ឆេទ"); ?>:</td>
											  <td style="text-align:center;border:solid 1px">
											   <?= $this->erp->hrld($inv->date); ?>
											  </td>
										  </tr>
										  <tr>	
											  <td>
												<?= lang("លេខវិក័យប័ត្រ"); ?>:
											  </td>
											  <td style="text-align:center;border:solid 1px">
											  ​​​	<?= $inv->reference_no; ?>
											  </td> 
										  </tr>
										  <tr style="background-color:orange !important;">
											  <th colspan="2" height="35px;" style="text-align:left;border:solid 1px;font-size:18px;">អតិថិជន : <?=$customer->name?></th>
											 
										  </tr>
										  <tr style="border:solid 1px">
											  <td colspan="2">
												<?php
												if($customer->phone !="-"){
													echo lang("លេខទូរសព័្ទ") . ": " . $customer->phone;
												}
												?>
												<br/>
												អាស័យដ្ឋាន : <?php echo $customer->address;?>
											  </td>
										  </tr>
										</table>
									
									</div>
								</div>
							</div>
						</div>
					</div>
					
					<div class="row-content">
						<div class="col-md-12" class="he">
						  <table border="1px" width="100%" style="margin-top:35px;">
							<thead>
								  <tr height="30px" class="bg">
									<th width="30px"><?= lang("ល.រ"); ?></th>
									<th><?= lang("បរិយាយមុខទំនិញ"); ?></th>
									<th><?= lang("បរិមាណ"); ?></th>
									<th><?= lang("តំលៃរាយ"); ?></th>
									<th><?= lang("តំលៃសរុប"); ?></th>
								  </tr>
							</thead>
						<tbody>	
								<?php 
									function formateQTY($x){
									$str  = (String) $x;
									$inter = explode(".",$str);
									$num = $inter[1];
									if($num != 0){
										$res = $num;
									}else{
										$res = '';
									}
									return (Float)($inter[0].'.'.$res);
									}
									$r = 1;
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
						
							  <tr height="30px">
									<td align="center"><?php echo $r?></td>
									<td style="padding-left:5px !important;"><?= $product_name_setting ?> <?= $row->details ? '<br>' . $row->details : ''; ?> </td>
									<td align="center"><?= formateQTY($row->quantity); ?><?php echo ' '.$product_unit?></td>
									<td align="center"><?= $row->subtotal!=0?$this->erp->formatMoney($row->unit_price).' ៛':$free; ?></td>
									<td align="center"><?php echo $this->erp->formatMoney($row->subtotal).' ៛'?></td>
								
							  </tr>
							 
							  
							 <?php
								$r++;
							endforeach;
							?>
							<tr>
								<td>&nbsp;</td><td></td><td></td><td></td><td></td>
							</tr>
							<tr>
								<td>&nbsp;</td><td></td><td></td><td></td><td></td>
							</tr>
						</tbody>
						  <tfoot>
							  <tr height="30px"> 
								<td class="foot" colspan="4" border="0" align="right">សរុបទឹកប្រាក់​ </td>
								<td align="center">
								  <?= $this->erp->formatMoney($inv->grand_total).' ៛';?>
								</td>
							  </tr>
						  </tfoot>
						  </table>
						  
					</div>
					   </div>
				</div>
				<div class="container">
						   <div class="row-content">
							   <div class="col-md-12"style="padding-left:30px;margin-top:100px">
									   <div class="col-md-4 col-sm-4 col-xs-4">
										  <hr class="bt">
										 <p style="padding-left:45px;"> អ្នកទទួល</p>
									   </div>
									   <div class="col-md-4 col-sm-4 col-xs-4">
										  <hr class="bt">
										 <p style="padding-left:36px;"> អ្នកដឹកជញ្ជូន</p>
									   </div>
									   <div class="col-md-4 col-sm-4 col-xs-4">
										   <hr class="bt">
										 <p style="padding-left:49px;"> អ្នកលក់</p>
									   </div>
									   
							   </div>
						   </div>
							<div class="row-content no-print">
							  <div class="col-md-12" style="margin:50px 0px;">
											<button type="button" class="btn btn-primary btn-default     pull-left" onclick="window.print();">
												<i class="fa fa-print"></i> <?= lang('print'); ?>
											</button>
							  </div>
							</div>
				</div>
				
			</div>
		</div>
	</div>
	<script type="text/javascript">
		$(document).ready(function () {
			$(window).load(function () {
				window.print();
			});
		});
	</script>
</div>

