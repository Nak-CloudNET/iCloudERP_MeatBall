<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?php echo $this->lang->line("invoice") . " " . $inv->reference_no; ?></title>
    <link href="<?php echo $assets ?>styles/theme.css" rel="stylesheet">
    <style type="text/css">
        html, body {
            height: 100%;
            background: #FFF;
        }

        body:before, body:after {
            display: none !important;
        }

        .table th {
            text-align: center;
            padding: 5px;
        }

        .table td {
            padding: 4px;
        }
		hr{
			border-color: #333;
			width:100px;
			margin-top: 70px;
		}
    </style>
</head>

<body>
<div class="print_rec" id="wrap" style="width: 90%; margin: 0 auto;">
    <div class="row">
            <?php if ($logo) { ?>
				<div style="float:left;height:91px">
                    <img src="<?= base_url() . 'assets/uploads/logos/' . $biller->logo; ?>"
                         alt="<?= $biller->company != '-' ? $biller->company : $biller->name; ?>">
				</div>
				<div style="text-align:center;">
					<p style="font-family:Khmer OS Muol;font-size:22px"><b>ភ្នំពេញផ្លាស្ទិច<br>PHNOM PENH PLASTIC</b></p>
					<p class="bold" style="font-size:16px"><b>
						<?php
							echo $biller->address  . $biller->city."<br>";
						?>
					</b></p>
                </div>
				<div class="col-md-12 well well-sm">
					<p class="text-left" style="font-size:14px;font-family:Khmer OS Muol"><b>
						មានផលិតដបទឹកសុទ្ទ ដបទឹកស៊ីអ៊ីវ ដបទឹកម្ទេស ដបទឹកត្រី ដបប្រេងឆា ដបទឹកក្រូច ធុងថ្លា20L និង ផ្លាស្ទិច គ្រប់ប្រភេទ<br>
						<?php
							echo lang("tel") . ": " . $biller->phone ."<br>";
							echo lang("email").": " . $biller->email;
						?>
					</b></p>
				</div>
            <?php } ?>
		<div class="col-lg-12">
            <div class="clearfix"></div>
            <div class="row padding10">
                <div class="col-xs-4" style="font-size:14px">
					អតិថិជន: &nbsp;&nbsp;<?= $customer->company ? $customer->company : $customer->name; ?>
                    <?= $customer->company ? "" : "Attn: " . $customer->name ?><br>
                    <?php
                    echo "អាស័យដ្ធាន:  &nbsp;&nbsp;".$customer->address . " " . $customer->city."<br>" ;
					if($customer->phone !="-"){
						echo lang("ទូរស័ព្ទ  ") . ": &nbsp;&nbsp;" . $customer->phone;
					}else{
						echo "ទូរស័ព្ទ : &nbsp;&nbsp;";
					}
					
                    ?>
                </div>
				<div class="col-xs-4" style="text-align:center;margin-top:-20px">
					<h4><b><?= lang("invoice"); ?></b></h4>
				</div>
				<div class="col-xs-4" style="float: left;font-size:14px">
						<?= lang("លេខ Invoice"); ?>: <?= $inv->reference_no; ?><br>
						<?= lang("ថ្ងៃ ខែ ឆ្នាំ"); ?>: <?= $this->erp->hrld($inv->date); ?>
                    <div class="clearfix"></div>
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
							<th><?= lang("លរ<br>N<sup>o</sup>"); ?></th>
							<th><?= lang("ឈ្មោះទំនិញ<br>NAME OF GOODS"); ?></th>
							<th><?= lang("ឯកត្តា<br>UNIT"); ?></th>
							<th><?= lang("បរិមាណ<br>Quantity"); ?></th>
							<?php
							/* if ($Settings->product_serial) {
								echo '<th style="text-align:center; vertical-align:middle;">' . lang("serial_no") . '</th>';
							} */
							?>
							<th><?= lang("តំលៃរាយ<br>UNIT PRICE"); ?></th>
							<?php
							/* if ($Settings->tax1) {
								echo '<th>' . lang("tax") . '</th>';
							}
							if ($Settings->product_discount) {
								echo '<th>' . lang("discount") . '</th>';
							} */
							?>
							<th><?= lang("សរុប<br>AMOUNT"); ?></th>
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
							$product_name_setting = ($row->promotion == 1 ? '<i class="fa fa-check-circle"></i> ' : '') . $row->product_name;
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
								/* if ($Settings->product_serial) {
									echo '<td>' . $row->serial_no . '</td>';
								} */
								?>
								<td style="text-align:center; width:15%;vertical-align:middle;"><?= $row->subtotal!=0?$this->erp->formatMoney($row->unit_price):$free; ?></td>
								<?php
								/* if ($Settings->tax1) {
									echo '<td style="width: 8%; text-align:right; vertical-align:middle;">' . ($row->item_tax != 0 && $row->tax_code ? '<small>(' . $row->tax_code . ')</small> ' : '') . $this->erp->formatMoney($row->item_tax) . '</td>';
								}
								if ($Settings->product_discount) {
									echo '<td style="width: 7%; text-align:right; vertical-align:middle;">' . ($row->discount != 0 ? '<small>(' . $row->discount . ')</small> ' : '') . $this->erp->formatMoney($row->item_discount) . '</td>';
								} */
								?>
								<td style="vertical-align:middle; text-align:center; width:20%;"><?= $row->subtotal!=0?$this->erp->formatMoney($row->subtotal):$free; 
									$total += $row->subtotal;
									?></td>
							</tr>
							<?php
							$r++;
						endforeach;
						if(count($rows) <9){
							$s=$r;
							for($i=$r;$i<=8;$i++){
						?>
							<tr>
								<td style="text-align:center; width:5%; vertical-align:middle;"><?php echo $s++; ?></td>
								<td style="vertical-align:middle;width:35%" ></td>
								<td style="width: 10%; text-align:center; vertical-align:middle;"></td>
								<td style="width: 10%; text-align:center; vertical-align:middle;"></td>
								<td style="text-align:center; width:15%;vertical-align:middle;"></td>
								<!--<td style="width: 8%; text-align:right; vertical-align:middle;"></td>
								<td style="width: 7%; text-align:right; vertical-align:middle;"></td>-->
								<td style="vertical-align:middle; text-align:right; width:20%;"></td>
							</tr>
						<?php
							}
						}
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
                    /* if ($Settings->product_discount && $Settings->tax1) {
                        $tcol = $col - 2;
                    } elseif ($Settings->product_discount) {
                        $tcol = $col - 1;
                    } elseif ($Settings->tax1) {
                        $tcol = $col - 1;
                    } else {
                        $tcol = $col;
                    } */
					$discount_percentage = '';
					if (strpos($inv->order_discount_id, '%') !== false) {
						$discount_percentage = $inv->order_discount_id;
					}
                    ?>
                    <?php if ($inv->grand_total != $inv->total) { ?>
                        <tr>
                            <td colspan="5" style="text-align:right;"><?= lang("សរុប/TOTAL"); ?>
                                (<?= $default_currency->code; ?>)
                            </td>
                            <?php
                            /* if ($Settings->tax1) {
                                echo '<td style="text-align:right;">' . $this->erp->formatMoney($inv->product_tax) . '</td>';
                            }
                            if ($Settings->product_discount) {
                                echo '<td style="text-align:right;">' . $this->erp->formatMoney($inv->product_discount) . '</td>';
                            } */
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
                        <td colspan="5"
                            style="text-align:right; font-weight:bold;"><?= lang("សរុប/TOTAL"); ?>
                            (<?= $default_currency->code; ?>)
                        </td>
                        <td style="text-align:right; font-weight:bold;"><?= $this->erp->formatMoney($inv->grand_total); ?></td>
                    </tr>

                    <tr>
                        <td colspan="5" style="text-align:right; font-weight:bold;"><?= lang("ប្រាក់អោយ/PAID"); ?>
                            (<?= $default_currency->code; ?>)
                        </td>
                        <td style="text-align:right; font-weight:bold;"><?= $this->erp->formatMoney($inv->paid); ?></td>
                    </tr>
                    <tr>
                        <td colspan="5" style="text-align:right; font-weight:bold;"><?= lang("ប្រាក់ជំពាក់/CREDIT"); ?>
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
                <div class="col-xs-4  pull-left" style="text-align:center">
					<hr/>
                    <p><?= lang("អ្នកទិញ"); ?>
                        <!--: <?= $biller->company != '-' ? $biller->company : $biller->name; ?> --></p>
                    <!--<p><?= lang("stamp_sign"); ?></p>-->
                </div>
                <!--<div class="col-xs-3  pull-right" style="text-align:center">
					<hr/>
                    <p><?= lang("customer"); ?>
                        : <?= $customer->company ? $customer->company : $customer->name; ?></p>
                    <p><?= lang("stamp_sign"); ?></p>
                </div>-->
				<div class="col-xs-4  pull-right" style="text-align:center">
					<hr/>
                    <p><?= lang("អ្នកលក់"); ?>
                        <!--: <?= $customer->company ? $customer->company : $customer->name; ?>--> </p>
                    <!--<p><?= lang("stamp_sign"); ?></p>-->
                </div>
				<div class="col-xs-4  pull-right" style="text-align:center">
					<hr/>
                    <p><?= lang("អ្នកដឹក"); ?>
                        <!--: <?= $warehouse->company ? $warehouse->company : $warehouse->name; ?>--> </p>
                    <!--<p><?= lang("stamp_sign"); ?></p>-->
                </div>
            </div>
        </div>
    </div>
</div>
<div id="mydiv" style="display:none;">
	
<div id="wrap" style="width: 90%; margin: 0 auto;">
    <div class="row">
        <div class="col-lg-12">
            <?php if ($logo) { ?>
                <div class="text-center" style="margin-bottom:20px; text-align: center;">
                    <!--<img src="<?= base_url() . 'assets/uploads/logos/' . $Settings->logo; ?>" alt="<?= $Settings->site_name; ?>">-->
                    <img src="<?= base_url() . 'assets/uploads/logos/' . $biller->logo; ?>"
                         alt="<?= $biller->company != '-' ? $biller->company : $biller->name; ?>">
                </div>
            <?php } ?>
            <div class="clearfix"></div>
            <div class="row padding10">
                <div class="col-xs-5" style="float: left;">
                    <h2 class=""><?= $biller->company != '-' ? $biller->company : $biller->name; ?></h2>
                    <?= $biller->company ? "" : "Attn: " . $biller->name ?>
                    <?php
                    echo $biller->address . "<br />" . $biller->city . " " . $biller->postal_code . " " . $biller->state . "<br />" . $biller->country;
                    echo "<p>";
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
                    echo "</p>";
                    echo lang("tel") . ": " . $biller->phone . "<br />" . lang("email") . ": " . $biller->email;
                    ?>
                    <div class="clearfix"></div>
                </div>
                <div class="col-xs-5"  style="float: right;">
                    <h2 class=""><?= $customer->company ? $customer->company : $customer->name; ?></h2>
                    <?= $customer->company ? "" : "Attn: " . $customer->name ?>
                    <?php
                    echo $customer->address . "<br />" . $customer->city . " " . $customer->postal_code . " " . $customer->state . "<br />" . $customer->country;
                    echo "<p>";
                    if ($customer->cf1 != "-" && $customer->cf1 != "") {
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
                    echo "</p>";
                    echo lang("tel") . ": " . $customer->phone . "<br />" . lang("email") . ": " . $customer->email;
                    ?>
                </div>
            </div>
            <div class="clearfix"></div>
            <div class="row padding10">
                <div class="col-xs-5" style="float: left;">
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
            <div class="-table-responsive">
                <table class="table table-bordered table-hover table-striped" style="width: 100%;">
                    <thead  style="font-size: 13px;">
                    <tr>
                        <th><?= lang("លរ"); ?></th>
                        <th><?= lang("ឈ្មោះទំនិញ<br>NAME OF GOODS"); ?> (<?= lang("code"); ?>)</th>
                        <th><?= lang("បរិមាណ<br>Quantity"); ?></th>
                        <?php
                        if ($Settings->product_serial) {
                            echo '<th style="text-align:center; vertical-align:middle;">' . lang("serial_no") . '</th>';
                        }
                        ?>
                        <th><?= lang("តំលៃរាយ<br>UNIT PRICE"); ?></th>
                        <?php
                        if ($Settings->tax1) {
                            echo '<th>' . lang("tax") . '</th>';
                        }
                        if ($Settings->product_discount) {
                            echo '<th>' . lang("discount") . '</th>';
                        }
                        ?>
                        <th><?= lang("សរុប<br>AMOUNT"); ?></th>
                    </tr>
                    </thead>
                    <tbody style="font-size: 13px;">
                    <?php $r = 1;
                    foreach ($rows as $row):
                        ?>
                        <tr>
                            <td style="text-align:center; width:40px; vertical-align:middle;"><?= $r; ?></td>
                            <td style="vertical-align:middle;"><?= $row->product_name . " (" . $row->product_code . ")" . ($row->variant ? ' (' . $row->variant . ')' : ''); ?>
                                <?= $row->details ? '<br>' . $row->details : ''; ?>
                            </td>
                            <td style="width: 80px; text-align:center; vertical-align:middle;"><?= $this->erp->formatQuantity($row->quantity); ?></td>
                            <?php
                            if ($Settings->product_serial) {
                                echo '<td>' . $row->serial_no . '</td>';
                            }
                            ?>
                            <td style="text-align:right; width:90px;"><?= $this->erp->formatMoney($row->real_unit_price); ?></td>
                            <?php
                            if ($Settings->tax1) {
                                echo '<td style="width: 90px; text-align:right; vertical-align:middle;">' . ($row->item_tax != 0 && $row->tax_code ? '<small>(' . $row->tax_code . ')</small> ' : '') . $this->erp->formatMoney($row->item_tax) . '</td>';
                            }
                            if ($Settings->product_discount) {
                                echo '<td style="width: 90px; text-align:right; vertical-align:middle;">' . ($row->discount != 0 ? '<small>(' . $row->discount . ')</small> ' : '') . $this->erp->formatMoney($row->item_discount) . '</td>';
                            }
                            ?>
                            <td style="vertical-align:middle; text-align:right; width:110px;"><?= $this->erp->formatMoney($row->subtotal); 
                                ?></td>
                        </tr>
                        <?php
                        $r++;
                    endforeach;
                    ?>
                    </tbody>
                    <tfoot style="font-size: 13px;">
                    <?php
                    $col = 4;
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
                            <td style="text-align:right;"><?= $this->erp->formatMoney($inv->total + $inv->product_tax); ?></td>
                        </tr>
                    <?php } ?>
                    <?php if ($return_sale && $return_sale->surcharge != 0) {
                        echo '<tr><td colspan="' . $col . '" style="text-align:right;">' . lang("surcharge") . ' (' . $default_currency->code . ')</td><td style="text-align:right;">' . $this->erp->formatMoney($return_sale->surcharge) . '</td></tr>';
                    }
                    ?>
                    <?php if ($inv->order_discount != 0) {
                        echo '<tr><td colspan="' . $col . '" style="text-align:right;">' . lang("order_discount") . ' (' . $default_currency->code . ')</td><td style="text-align:right;">' . $this->erp->formatMoney($inv->order_discount) . '</td></tr>';
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
                <div class="col-xs-4  pull-left" style="float: left;">
                    <p style="height: 80px;"><?= lang("seller"); ?>
                        : <?= $biller->company != '-' ? $biller->company : $biller->name; ?> </p>
                    <hr>
                    <p><?= lang("stamp_sign"); ?></p>
                </div>
                <div class="col-xs-4  pull-right" style="float: right;">
                    <p style="height: 80px;"><?= lang("customer"); ?>
                        : <?= $customer->company ? $customer->company : $customer->name; ?> </p>
                    <hr>
                    <p><?= lang("stamp_sign"); ?></p>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
<div class="col-md-12">
	<button type="button" class="btn btn-primary btn-default no-print pull-left" onclick="window.print();">
		<i class="fa fa-print"></i> <?= lang('print'); ?>
	</button>&nbsp;&nbsp;&nbsp;
	<a href="<?= site_url('sales'); ?>"><button class="btn btn-warning no-print" ><i class="fa fa-heart"></i>&nbsp;<?= lang("back_to_sale"); ?></button></a>
</div>
<script type="text/javascript" src="http://jqueryjs.googlecode.com/files/jquery-1.3.1.min.js" > </script> 
<!--<script type="text/javascript">
$(document).ready(function(){
	$(window).load(function(){
		window.print();
	});
});-->
	
</script>
</body>
</html>