<style type="text/css" media="all">
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    .padding0 {
        padding: 0px;
    }

    .bt {
        width: 100px;
        border: solid 2px;
        margin: 0px;
        color: #AFAEAE !important;
    }

    .title h1 {
        font-family: Khmer OS Muol Light;
        color: orange !important;
        text-decoration: underline;
        text-decoration-style: double;
    }

    body {
        margin: 0;
        font-weight: 500;
        -webkit-print-color-adjust: exact;
    }

    .row-content {
        width: 100%;
        float: left;
    }

    .foot {
        border-bottom: 1px solid #fff !important;
        border-left: 1px solid #fff !important;
        padding-right: 10px;
    }

    .sub-title h2 {
        font-family: "Khmer OS Muol Light";
        font-size: 20px;
        margin-bottom: 20px;
    }

    .bg th {
        background-color: orange !important;
        text-align: center !important;
        font-size: 12px !important;
    }
    th, td,p{
        font-family: "Khmer OS Battambang";
    }
    .border_style {
        padding-left: 0px !important;
        padding-right: 0px !important;
        padding-top: 0px !important;
        border-top: 0px !important;
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
                            <div class="col-md-3 col-sm-3 col-xs-3">
                                <img src="<?= base_url() . 'assets/uploads/logos/' . $biller->logo; ?>"
                                     alt="<?= $biller->company != '-' ? $biller->company : $biller->name; ?>">
                            </div>
                            <div class="col-md-9 col-sm-9 col-xs-9">
                                <div class="title">
                                    <div class="sub-title"><h2>សិប្បកម្មជាងួន(បិតាប្រហិត888)</h2></div>
                                    <div class="describe">មានលក់ដំុ​ និងលក់រាយ​ ប្រហិតសាច់គោ ប្រហិតសាច់ជ្រូក</p></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row-content">
                        <div class="col-md-12 padding0">
                            <br>
                            <div class="col-md-7 col-sm-8 col-xs-7">
                                <p>ផ្ទះលេខ4D ផ្លូវ265 សង្កាត់ទឹកល្អក់3 ខណ្ឌទួលគោក រាជធានីភ្មំពេញ</p>
                                <p>អ៊ីម៉ែល​ : <?php echo $biller->email; ?></p>
                                <p>ហ្វេសប៊ុក : បិតាប្រហិត888</p>
                            </div>
                            <div class="col-md-5 col-sm-4 col-xs-5">
                                <div class="pull-right">
                                    <p>No.</p>
                                    <p>លេខកម្មង់: <?php echo $biller->phone; ?></p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row-content">
                        <div class="col-md-12">
                            <h2 class="sub-title" style="text-align: center; font-family: khmer os moul Light">វិក្កយបត្រ</h2>
                        </div>
                    </div>
                    <div class="row-content">
                        <div class="col-md-12" class="he">
                            <table border="1px" width="100%" style="margin-top:35px;">
                                <thead>
                                <tr height="30px" class="bg">
                                    <th style="width: 10px;"><?= lang("ល.រ"); ?></th>
                                    <th><?= lang("បរិយាយមុខទំនិញ"); ?></th>
                                    <th><?= lang("បរិមាណ"); ?></th>
                                    <th><?= lang("តំលៃរាយ"); ?></th>
                                    <th><?= lang("តំលៃសរុប"); ?></th>
                                </tr>
                                </thead>
                                <tbody>
                                <?php
                                function formateQTY($x)
                                {
                                    $str = (String)$x;
                                    $inter = explode(".", $str);
                                    $num = $inter[1];
                                    if ($num != 0) {
                                        $res = $num;
                                    } else {
                                        $res = '';
                                    }
                                    return (Float)($inter[0] . '.' . $res);
                                }

                                $r = 1;
                                $total = 0;
                                foreach ($rows as $row):
                                    $free = lang('free');
                                    $product_unit = '';
                                    if ($row->variant) {
                                        $product_unit = $row->variant;
                                    } else {
                                        $product_unit = $row->unit;
                                    }

                                    $product_name_setting;
                                    if ($pos->show_product_code == 0) {
                                        $product_name_setting = ($row->promotion == 1 ? '<i class="fa fa-check-circle"></i> ' : '') . $row->product_name . ($row->variant ? ' (' . $row->variant . ')' : '');
                                    } else {
                                        $product_name_setting = ($row->promotion == 1 ? '<i class="fa fa-check-circle"></i> ' : '') . $row->product_name . " (" . $row->product_code . ")" . ($row->variant ? ' (' . $row->variant . ')' : '');
                                    }
                                    ?>

                                    <tr height="30px">
                                        <td style="width: 10px;" align="center"><?php echo $r ?></td>
                                        <td style="padding-left:5px !important;"><?= $product_name_setting ?> <?= $row->details ? '<br>' . $row->details : ''; ?> </td>
                                        <td align="center"><?= formateQTY($row->quantity); ?><?php echo ' ' . $product_unit ?></td>
                                        <td align="center"><?= $row->subtotal != 0 ? $this->erp->formatMoney($row->unit_price) . ' ៛' : $free; ?></td>
                                        <td align="center"><?php echo $this->erp->formatMoney($row->subtotal) . ' ៛' ?></td>

                                    </tr>


                                    <?php
                                    $r++;
                                endforeach;
                                ?>

                                </tbody>
                                <tfoot>

                                <tr height="30px">
                                    <td colspan="2"
                                        style="border-bottom: transparent 1px solid; border-right: transparent 1px solid; border-left: transparent 1px solid">
                                        ថ្ងៃទី <?= date('d', strtotime( $inv->date )); ?> ខែ​ <?= date('m', strtotime( $inv->date )); ?> ឆ្នាំ <?= date('Y', strtotime( $inv->date )); ?>
                                    </td>
                                    <td class="foot" colspan="2" border="0" align="right">សរុបទឹកប្រាក់​</td>
                                    <td align="center">
                                        <?= $this->erp->formatMoney($inv->grand_total) . ' ៛'; ?>
                                    </td>
                                </tr>
                                <tr height="30px">
                                    <td colspan="2"
                                        style="  border-left: transparent 1px solid">
                                    </td>

                                    <td class="foot" colspan="2" border="0" align="right">ប្រាក់កក់​</td>
                                    <td align="center">
                                        <?= $this->erp->formatMoney($inv->paid) . ' ៛'; ?>
                                    </td>
                                </tr>
                                <tr height="30px">
                                    <td colspan="2"
                                        style="border-bottom:">
                                        ឈ្មោះអតិថិជន: <?= $customer->name ?>
                                    </td>
                                    <td class="foot" colspan="2" border="0" align="right">នៅខ្វះ​</td>
                                    <td align="center">
                                        <?= $this->erp->formatMoney($inv->grand_total-$inv->paid) . ' ៛'; ?>
                                    </td>
                                </tr>

                                </tfoot>
                            </table>


                        </div>
                    </div>
                </div>
                <div class="container">
                    <div class="row-content">
                        <div class="col-md-12" style="padding-left:30px;margin-top:100px">
                            <div class="col-md-4 col-sm-4 col-xs-4">
                                <hr class="bt">
                                <p style="padding-left:35px;"> អ្នកទិញ</p>
                            </div>
                            <div class="col-md-4 col-sm-4 col-xs-4">
                                <hr class="bt">
                                <p style="padding-left:23px;"> អ្នកដឹកជញ្ជូន</p>
                            </div>
                            <div class="col-md-4 col-sm-4 col-xs-4">
                                <hr class="bt">
                                <p style="padding-left:36px;"> អ្នកលក់</p>
                            </div>

                        </div>
                    </div>
                    <div class="row-content no-print">
                        <div class="col-md-12" style="margin:50px 0px;">
                            <button type="button" class="btn btn-primary btn-default     pull-left"
                                    onclick="window.print();">
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

