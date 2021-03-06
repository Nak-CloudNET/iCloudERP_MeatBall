<?php defined('BASEPATH') OR exit('No direct script access allowed');

/*
 * Module: General Language File for common lang keys
 * Language: Khmer
 *
 * Last edited:
 * 20th October 2015
 *
 * Package:
 * iCloudERP - POS v3.0
 *
 * You can translate this file to your language.
 * For instruction on new language setup, please visit the documentations.
 * You also can share your language files by emailing to icloud.erp@gmail.com
 * Thank you
 */

/* --------------------- CUSTOM FIELDS ------------------------ */
/*
* Below are custome field labels
* Please only change the part after = and make sure you change the the words in between "";
* $lang['bcf1']                         = "Biller Custom Field 1";
* Don't change this                     = "You can change this part";
* For support email icloud.erp@gmail.com Thank you!
*/

$lang['bcf1']                           = "Biller Custom Field 1";
$lang['bcf2']                           = "Biller Custom Field 2";
$lang['bcf3']                           = "Biller Custom Field 3";
$lang['bcf4']                           = "Biller Custom Field 4";
$lang['bcf5']                           = "Biller Custom Field 5";
$lang['bcf6']                           = "Biller Custom Field 6";
$lang['pcf1']                           = "Product Custom Field 1";
$lang['pcf2']                           = "Product Custom Field 2";
$lang['pcf3']                           = "Product Custom Field 3";
$lang['pcf4']                           = "Product Custom Field 4";
$lang['pcf5']                           = "Product Custom Field 5";
$lang['pcf6']                           = "Product Custom Field 6";
$lang['ccf1']                           = "Customer Custom Field 1";
$lang['ccf2']                           = "Customer Custom Field 2";
$lang['ccf3']                           = "Customer Custom Field 3";
$lang['ccf4']                           = "Customer Custom Field 4";
$lang['ccf5']                           = "Customer Custom Field 5";
$lang['ccf6']                           = "Customer Custom Field 6";
$lang['scf1']                           = "Supplier Custom Field 1";
$lang['scf2']                           = "Supplier Custom Field 2";
$lang['scf3']                           = "Supplier Custom Field 3";
$lang['scf4']                           = "Supplier Custom Field 4";
$lang['scf5']                           = "Supplier Custom Field 5";
$lang['scf6']                           = "Supplier Custom Field 6";

/* ----------------- DATATABLES LANGUAGE ---------------------- */
/*
* Below are datatables language entries
* Please only change the part after = and make sure you change the the words in between "";
* 'sEmptyTable'                     => "No data available in table",
* Don't change this                 => "You can change this part but not the word between and ending with _ like _START_;
* For support email support@cloud--net.com Thank you!
*/

$lang['datatables_lang']        		= array(
    'sEmptyTable'                   		=> "គ្មានទិនិ្នន័យក្នុងតារាង",
    'sInfo'                         			=> "ការបង្ហាញ _START_ ទៅ _END_ នៃ _TOTAL_ ទិនិ្នន័យ",
    'sInfoEmpty'                    		=> "ការបង្ហាញ 0 to 0 of 0 ទិនិ្នន័យ",
    'sInfoFiltered'                 		=> "(ការតម្រង់តាម  _MAX_ ចំនួនទិនិ្នន័យសរុប)",
    'sInfoPostFix'                  		=> "",
    'sInfoThousands'                		=> ",",
    'sLengthMenu'                   		=> "បង្ហាញ _MENU_ ",
    'sLoadingRecords'               		=> "កំពុងទាញមក...",
    'sProcessing'                   		=> "កំពុងដំណើរការ...",
    'sSearch'                       			=> "ស្វែងរក",
    'sZeroRecords'                  		=> "គ្មានដូចទិនិ្នន័យដែលស្វែងរក",
    'oAria'                     				=> array(
      'sSortAscending'              		=> ": activate to sort column ascending",
      'sSortDescending'             		=> ": activate to sort column descending"
      ),
    'oPaginate'                 			=> array(
      'sFirst'                      			=> "<< ដំបូង",
      'sLast'                       			=> "ចុងក្រោយ >>",
      'sNext'                      			=> "បន្ទាប់ >",
      'sPrevious'                   			=> "< ថយក្រោយ",
      )
    );

/* ----------------- Select2 LANGUAGE ---------------------- */
/*
* Below are select2 lib language entries
* Please only change the part after = and make sure you change the the words in between "";
* 's2_errorLoading'                 => "The results could not be loaded",
* Don't change this                 => "You can change this part but not the word between {} like {t};
* For support email support@cloud--net.com Thank you!
*/

$lang['select2_lang']               		= array(
    'formatMatches_s'               	=> "លទ្ធផលមួយគឺអាចប្រើបានចុចបញ្ចូលដើម្បីជ្រើសវា",
    'formatMatches_p'               	=> "លទ្ធផលនៃការដែលអាចរកបាន, ប្រើឡើងចុះគ្រាប់ចុចព្រួញដើម្បីរុករក.",
    'formatNoMatches'               	=> "គ្មានដូចទៅនឹង",
    'formatInputTooShort'           	=> "សូមវាយតួរអក្សរ {n} រឺតួរអក្សរច្រើន",
    'formatInputTooLong_s'          	=> "សូមលប់ {n} តួរអក្សរ",
    'formatInputTooLong_p'          	=> "សូមលប់ {n} តួរអក្សរ",
    'formatSelectionTooBig_s'       	=> "អ្នកអាចជ្រើសរើសបានត្រឹមទំនិញ {n} ",
    'formatSelectionTooBig_p'       	=> "អ្នកអាចជ្រើសរើសបានត្រឹមទំនិញ {n} ",
    'formatLoadMore'                		=> "កំពុងទាញលទ្ធផលមកបន្ថែម...",
    'formatAjaxError'               		=> "ប្រព័ន្ធAjax ធ្វើសំណើមិនជោគជ័យ",
    'formatSearching'               		=> "កំពុងស្វែងរក..."
    );


/* ----------------- ERP GENERAL LANGUAGE KEYS -------------------- */

$lang['home']                              	 	= "ទំព័រដើម";
$lang['dashboard']                          		= "ផ្ទាំងគ្រប់គ្រង";
$lang['username']                         		= "ឈ្មោះអ្នកប្រើ";
$lang['password']                           		= "ពាក្យសម្ងាត់";
$lang['first_name']                         		= "នាមខ្លួន";
$lang['last_name']                          		= "នាមត្រកូល";
$lang['confirm_password']                   	= "បញ្ជ឵ក់ពាក្យសម្ងាត់";
$lang['email']                              		= "អ៊ីម៉ែល";
$lang['phone']                              		= "ទូរស័ព្ទ";
$lang['company']                            		= "ក្រុមហ៊ុន";
$lang['product_code']                       	= "លេខកូដ ផលិតផល";
$lang['product_name']                       	= "ឈ្មោះ ផលិតផល";
$lang['cname']                              		= "ឈ្មោះ អតិថិជន";
$lang['barcode_symbology']                  = "លេខកូដ Symbology";
$lang['product_unit']                       		= "ឯកតា ផលិតផល";
$lang['product_price']                      		= "ថ្លៃលក់ ផលិតផល";
$lang['contact_person']                     	= "អ្នកទាក់ទង";
$lang['email_address']                      	= "អាស័យដ្ឋានអ៊ីម៉េល";
$lang['address']                            		= "អាសយដ្ឋាន";
$lang['city']                               			= "ទីក្រុង";
$lang['today']                              		= "ថ្ងៃនេះ";
$lang['welcome']                            		= "សូមស្វាគមន៍!";
$lang['profile']                            		= "ទម្រង់ឯកសារ";
$lang['change_password']                    	= "ផ្លាស់ប្តូរពាក្យសម្ងាត់";
$lang['logout']                             		= "ចាក់ចេញ";
$lang['notifications']                      		= "ការជូនដំណឹង";
$lang['calendar']                           		= "ប្រតិទិន";
$lang['messages']                           	= "សារ";
$lang['styles']                             		= "រចនាប័ទ្ម";
$lang['language']                           		= "ភាសា";
$lang['alerts']                             		= "ការជូនដំណឹង";
$lang['list_products']                      		= "បញ្ជី ផលិតផល";
$lang['add_product']                        	= "បន្ថែមផលិតផល";
$lang['print_barcodes']                     	= "បោះពុម្ពលេខកូដ";
$lang['print_labels']                       		= "បោះពុម្ពស្លាក";
$lang['import_products']                    	= "នាំចូលទិន្នន៏យ";
$lang['update_price']                       	= "កែប្រែតំលៃ";
$lang['damage_products']                    	= "ផលិតផលខូច";
$lang['sales']                              		= "ការលក់";
$lang['list_sales']                         		= "បញ្ជីលក់	";
$lang['add_sale']                           		= "បន្ថែមការលក់";
$lang['list_deliveries']                    		= "បញ្ជីដឹកជញ្ជូន";
$lang['deliveries']                         		= "ការដឹកជញ្ជូន";
$lang['gift_cards']                         		= "កាតបញ្ចុះតំលៃ";
$lang['quotes']                             		= "សម្រង់តំលៃ";
$lang['list_quotes']                       		= "បញ្ជី សម្រង់តំលៃ";
$lang['add_quote']                          	= "បន្ថែម សម្រង់តំលៃ";
$lang['purchases']                          		= "ការទិញ";
$lang['list_purchases']                     	= "បញ្ជីការទិញ";
$lang['add_purchase']                       	= "បន្ថែមការទិញ";
$lang['add_purchase_by_csv']               = "បន្ថែមការទិញពីCSV";
$lang['transfers']                          		= "ការផ្ទេរ";
$lang['list_transfers']                     		= "បញ្ជីផ្ទេរ";
$lang['add_transfer']                       		= "បន្ថែមការផ្ទេរ";
$lang['add_transfer_by_csv']                	= "បន្ថែមការផ្ទេរពីCSV";
//$lang['list_journal']                			= "List Journal";
//$lang['add_journal']                			= "Add Journal";
$lang['list_ac_head']                			= "បញ្ជីឈ្មោះគណនី";
$lang['add_ac_head']                			= "បន្ថែមឈ្មោះគណនី";
$lang['list_money_receipt']                	= "List Money Receipt";
$lang['add_money_receipt']                	= "Add Money Receipt";
$lang['list_payment_receipt']               	= "List Payment Receipt";
$lang['add_payment_receipt']               = "Add Payment Receipt";
$lang['people']                             		= "មនុស្ស";
$lang['list_users']                         		= "បញ្ជីឈ្មោះអ្នកប្រើ";
$lang['new_user']                           		= "បន្ថែមអ្នកប្រើ";
$lang['list_billers']                       		= "បញ្ជី ហាង";
$lang['add_biller']                         		= "បន្ថែម ហាង";
$lang['list_customers']                     	= "បញ្ជីឈ្មោះអតិថិជន";
$lang['add_customer']                       	= "បន្ថែមអតិថិជន";
$lang['list_suppliers']                     		= "បញ្ជីអ្នកផ្គត់ផ្គង់";
$lang['add_supplier']                       	= "បន្ថែមហាងទំនិញ";
$lang['settings']                           		= "ការកំណត់";
$lang['system_settings']                    	= "ការកំណត់ប្រព័ន្ធ";
$lang['change_logo']                        	= "ប្តូរ Logo";
$lang['currencies']                         		= "រូបិយប័ណ្ណ";
$lang['attributes']                         		= "ផ្លាស់ប្តូរតំលៃផលិតផល";
$lang['customer_groups']                    	= "ក្រុមអតិថិជន";
$lang['categories']                         		= "ប្រភេទផលិតផល";
$lang['subcategories']                      	= "ប្រភេទផលិតផលរង";
$lang['tax_rates']                          		= "អត្រាតំលៃពន្ធ";
$lang['warehouses']                         	= "ឃ្លាំង";
$lang['email_templates']                    	= "អ៊ីម៉ែលឝំរូ";
$lang['group_permissions']                  	= "ក្រុមកំណត់សិទ្ធិ";
$lang['backup_database']                    	= "Backup ទិន្នន៍យ";
$lang['reports']                            		= "របាយការណ៍";
$lang['overview_chart']                     	= "តារាងទិដ្ឋភាពទូទៅ";
$lang['warehouse_stock']                    	= "ឃ្លាំងផលិតផលជា តារាង";
$lang['product_quantity_alerts']            = "បរិមាណផលិតផលត្រូវជូនដំណឹង";
$lang['product_expiry_alerts']              	= "ផុតកំណត់ផលិតផលត្រូវជូនដំណឹង ";
$lang['products_report']                    	= "របាយការណ៍ផលិតផល";
$lang['daily_sales']                        		= "ការលក់ប្រចាំថ្ងៃ";
$lang['monthly_sales']                      	= "ការលក់ប្រចាំខែ";
$lang['sales_report']                       		= "របាយការណ៍លក់ចេញ";
$lang['payments_report']                    	= "របាយការណ៍ការទូទាត់";
$lang['profit_and_loss']                    	= "របាយការណ៍ចំណេញខាត";
$lang['purchases_report']                   	= "របាយការណ៍ទិញចូល";
$lang['customers_report']                   	= "របាយការណ៍អតិថិជន";
$lang['suppliers_report']                   	= "របាយការណ៍អ្នកផ្គត់ផ្គង់";
$lang['staff_report']                       		= "របាយការណ៍បុគ្គលិក";
$lang['ledger']                       				= "Ledger";
$lang['trial_balance']                      		= "តារាងតុល្យភាព";
$lang['balance_sheet']                      	= "តារាងតុល្យការ";
$lang['income_statement']                   = "សេចក្តីថ្លែងការណ៍ប្រាក់ចំណូល";
$lang['bill_receivable']                    		= "វិក័យប័ត្រទទួល";
$lang['bill_payable']                      		= "វិក័យប័ត្រដែលត្រូវបង់";
$lang['cash_book']                       		= "សៀវភៅសាច់ប្រាក់";
$lang['bank_book']                       		= "សៀវភៅធនាគារ";
$lang['list_ar_aging']                       		= "បញ្ជីភាព AR ខែចាស់";
$lang['list_ap_aging']                       		= "បញ្ជីភាព AP ខែចាស់";
$lang['your_ip']                            		= "អាសយដ្ឋាន IP របស់អ្នក";
$lang['last_login_at']                      		= "ចូលប្រើលើកមុននៅ";
$lang['notification_post_at']               	= "ការជូនដំណឹងដែលបានបង្ហោះនៅ";
$lang['quick_links']                        		= "ភ្ជាប់ទំនាក់ទំនងរហ័ស";
$lang['date']                               		= "ថ្ងៃកាលបរិច្ឆេទ";
$lang['reference_no']                       	= "យោងលេខ";
$lang['products']                           		= "ផលិតផល";
$lang['customers']                          		= "អតិថិជន";
$lang['suppliers']                          		= "អ្នកផ្គត់ផ្គង់";
$lang['users']                              		= "អ្នកប្រើប្រាស់";
$lang['latest_five']                        		= "បង្ហាញចំនួនប្រាំចុងក្រោយ";
$lang['total']                              		= "សរុប";
$lang['payment_status']                     	= "លក្ខខ៍ណ្ឌការទូទាត់";
$lang['paid']                               		= "បង់ប្រាក់";
$lang['customer']                           		= "អតិថិជន";
$lang['status']                             		= "លក្ខខ៍ណ្ឌ";
$lang['amount']                             		= "ចំនួនទឹកប្រាក់";
$lang['supplier']                           		= "អ្នកផ្គត់ផ្គង់";
$lang['from']                               		= "ពី";
$lang['to']                                 			= "ទៅ";
$lang['name']                               		= "ឈ្មោះ";
$lang['create_user']                        		= "បន្ថែមអ្នកប្រើ";
$lang['gender']                             		= "ភេទ";
$lang['biller']                             			= "ហាង";
$lang['select']                             		= "ជ្រើសរើស";
$lang['warehouse']                          	= "ឃ្លាំង";


$lang['active']                             		= "Active";
$lang['inactive']                           		= "Inactive";


$lang['all']                                			= "ទាំងអស់";
$lang['list_results']                       		= "សូមប្រើប្រាស់តារាងខាងក្រោមដើម្បីរុករកឬត្រងលទ្ធផល។ អ្នកអាចទាញយកតារាងនេះជា Excel និង PDF";
$lang['actions']                            		= "សកម្មភាព";
$lang['pos']                                		= "POS";
$lang['access_denied']                      	= "ការចូលដំណើរការត្រូវបានបដិសេធ! អ្នកមិនមានសិទ្ធិដើម្បីចូលដំណើរការទំព័រដែលបានស្នើ។ ប្រសិនបើអ្នកគិតថាវាជាការច្រឡំ សូមទាក់ទងអ្នកគ្រប់គ្រង ";
$lang['add']                                		= "បន្ថែម";
$lang['edit']                               			= "កែតំរូវ";
$lang['delete']                             		= "លុប";
$lang['view']                               		= "បង្ហាញ";
$lang['update']                             		= "កែសម្រួល";
$lang['save']                               		= "រក្សាទុក";
$lang['login']                              		= "ចូល";
$lang['submit']                             		= "ដាក់ស្នើ";
$lang['no']                                 			= "";
$lang['yes']                                		= "Yes";
$lang['disable']                            		= "មិនអនុញ្ញាត";
$lang['enable']                             		= "អនុញ្ញាត";
$lang['enter_info']                         		= "សូមបំពេញនៅក្នុងព៌តមានខាងក្រោម។ ប្រអប់ដែលមានសញ្ញា * គឺត្រូវបានទាមទារវាលបញ្ចូល ";
$lang['update_info']                        		= "សូមកែសម្រួលនៅក្នុងព៌តមានខាងក្រោម។ ប្រអប់ដែលមានសញ្ញា * គឺត្រូវបានទាមទារវាលបញ្ចូល ";
$lang['no_suggestions']                     	= "មិនអាចយកទិន្នន័យសម្រាប់ការផ្ដល់យោបល់, សូមពិនិត្យមើលការបញ្ចូលរបស់អ្នក!";
$lang['i_m_sure']                           		= 'បាទខ្ញុំ ប្រាកដថា';
$lang['r_u_sure']                           		= 'តើអ្នកប្រាកដឬអត់?';
$lang['export_to_excel']                    	= "នាំចេញទៅកម្មវិធី Excel";
$lang['export_to_pdf']                      	= "នាំចេញទៅកម្មវិធី PDF";
$lang['image']                              		= "រូបភាព";
$lang['sale']                               		= "លក់";
$lang['quote']                              		= "សម្រង់តំលៃ";
$lang['purchase']                           		= "ទិញ";
$lang['transfer']                           		= "ផ្ទេរ";
$lang['payment']                            		= "ការទូទាត់";
$lang['payments']                           		= "ការទូទាត់";
$lang['orders']                             		= "ការបញ្ជាទិញ";
$lang['pdf']                                			= "PDF";
$lang['vat_no']                             		= "លេខ VAT";
$lang['country']                            		= "ប្រទេស";
$lang['add_user']                           		= "បន្ថែមអ្នកប្រើ";
$lang['type']                               		= "ប្រភេទ";
$lang['person']                             		= "បុគ្គល";
$lang['state']                              		= "រដ្ឋ";
$lang['postal_code']                        	= "លេខកូដប្រៃសណីយ";
$lang['id']                                 			= "ID";
$lang['close']                              		= "បិទ";
$lang['male']                               		= "ប្រុស";
$lang['female']                             		= "ស្ត្រី";
$lang['notify_user']                        		= "ជូនដំណឹងអ្នកប្រើ";
$lang['notify_user_by_email']               	= "ជូនដំណឹងអ្នកប្រើដោយអ៊ីម៉ែល";
$lang['billers']                            			= "ហាង";
$lang['all_warehouses']                     	= "ឃ្លាំងទាំងអស់";
$lang['category']                           		= "ប្រភេទក្រុម";
$lang['product_cost']                       	= "ថ្លៃដើមផលិតផល";
$lang['quantity']                           		= "បរិមាណ";
$lang['loading_data_from_server']         = "កំពុងទាញទិន្នន័យពីម៉ាស៊ីនមេ";
$lang['excel']                              		= "កម្មវិធី Excel";
$lang['print']                              			= "ការបោះពុម្ព";
$lang['ajax_error']                         		= "ប្រព័ន្ធAjax បានកើតឡើងកំហុស សូមសាក់ជាថ្មីម្តងទៀត .";
$lang['product_tax']                        		= "ពន្ធលើផលិតផល";
$lang['order_tax']                          		= "ពន្ធការលក់";
$lang['prepayment_profit_tax']                      = "ពន្ធលើប្រាក់ចំណេញ";
$lang['prepayment_profit_tax_list']                      = "បញ្ជីពន្ធលើប្រាក់ចំណេញ";
$lang['upload_file']                        		= "ផ្ទុកឡើងឯកសារ";
$lang['download_sample_file']              = "ទាញយកឯកសារគំរូ";
$lang['csv1']                               		= "បន្ទាត់ទីមួយក្នុងឯកសារ csv ដែលបានទាញយកគួរតែនៅតែជាការវាគឺជា។ សូមកុំផ្លាស់ប្តូរលំដាប់ជួរឈរ .";
$lang['csv2']                               		= "លំដាប់ជួរឈរដែលត្រឹមត្រូវគឺជា";
$lang['csv3']                               		= "&amp; អ្នកត្រូវតែអនុវត្តតាមនេះ។ ប្រសិនបើអ្នកកំពុងប្រើភាសាផ្សេងទៀតណាមួយបន្ទាប់មកជាភាសាអង់គ្លេស, សូមធ្វើឱ្យប្រាកដថាឯកសារ csv ជា UTF-8 ដែលបានអ៊ិនកូដនិងមិនបានរក្សាទុកជាមួយនឹងសញ្ញាគោលបំណងបៃ (BOM)";
$lang['import']                             		= "នាំចូល";
$lang['note']                               		= "សំគាល់";
$lang['grand_total']                        		= "តំលៃបូកសរុប";
$lang['download_pdf']                       	= "ទាញយកជា PDF";
$lang['no_zero_required']                   	= "ប្រអប់ %s គឺត្រូវបានទាមទារ";
$lang['no_product_found']                   	= "មិនមានទិន្នន័យ";
$lang['pending']                            		= "កំពុងរង់ចាំ";
$lang['sent']                               		= "បានផ្ញើ";
$lang['completed']                          		= "Completed";
$lang['shipping']                           		= "ការដឹកជញ្ជូន";
$lang['add_product_to_order']               = "សូមបន្ថែមផលិតផលទៅក្នុងបញ្ជីការលក់";
$lang['order_items']                        		= "លំដាប់ទំនិញ";
$lang['net_unit_cost']                      	= "តម្លៃដើមសុទ្ធ";
$lang['net_unit_price']                     	= "តម្លៃលក់សុទ្ធ";
$lang['expiry_date']                        		= "ថ្ងៃផុតកំណត់";
$lang['subtotal']                           		= "សរុបរង";
$lang['reset']                              		= "កំណត់ឡើងវិញ";
$lang['items']                              		= "ទំនិញ";
$lang['au_pr_name_tip']                     	= "សូមចាប់ផ្ដើមវាយលេខកូដ / ឈ្មោះសម្រាប់ការផ្ដល់យោបល់ឬលេខកូដស្កេនគ្រាន់តែជាការ";
$lang['no_match_found']                     	= "មិនមានលទ្ធផលផ្គូផ្គងរកឃើញ! ផលិតផលអាចត្រូវបានអស់ពីស្តុកក្នុងឃ្លាំងដែលបានជ្រើស ";
$lang['csv_file']                           		= "ឯកសារ CSV";
$lang['documents']                          	= "ភ្ជាប់ឯកសារ";
$lang['product']                            		= "ផលិតផល";
$lang['user']                               		= "អ្នកប្រើ";
$lang['created_by']                         		= "បង្កើតឡើងដោយ";
$lang['loading_data']                       	= "កំពុងផ្ទុកតារាងទិន្នន័យពីម៉ាស៊ីនបម្រើ";
$lang['tel']                                			= "ទូរស័ព្ទ";
$lang['ref']                                			= "សេចក្តីយោង";
$lang['description']                        		= "បរិយាយ";
$lang['code']                               		= "កូដ";
$lang['tax']                                			= "ពន្ធដារ";
$lang['unit_price']                         		= "ឯកតាតម្លៃ";
$lang['discount']                           		= "បញ្ចុះតំលៃ";
$lang['order_discount']                     	= "បញ្ចុះតំលៃការលក់";
$lang['total_amount']                       	= "ចំនួនទឹកប្រាក់សរុប";
$lang['download_excel']                     	= "ទាញយកជា Excel";
$lang['subject']                            		= "ប្រធានបទ";
$lang['cc']                                 			= "ចម្លងជូន";
$lang['bcc']                                			= "ចម្លងជាសម្ងាត់ជូន";
$lang['message']                            		= "សារ";
$lang['show_bcc']                           		= "បង្ហាញ / លាក់ ចម្លងជាសម្ងាត់ជូន";
$lang['price']                              		= "តម្លៃ";
$lang['add_product_manually']              = "បន្ថែមផលិតផលដោយដៃ";
$lang['currency']                           		= "រូបិយវត្ថុ";
$lang['product_discount']                   	= "បញ្ចុះតម្លៃផលិតផល";
$lang['email_sent']                         		= "អ៊ីម៉ែលផ្ញើដោយជោគជ័យ";
$lang['add_event']                          		= "បន្ថែមព្រឹត្តិការណ៍";
$lang['add_modify_event']                   	= "បន្ថែម / កែប្រែ ព្រឹត្តិការណ៍នេះ";
$lang['adding']                             		= "ការបន្ថែម ...";
$lang['delete']                             		= "លុប";
$lang['deleting']                           		= "ការលុប...";
$lang['calendar_line']                      		= "សូមចុចលើកាលបរិច្ឆេទដើម្បីបន្ថែម / កែប្រែព្រឹត្តិការណ៍នេះ ";
$lang['discount_label']                     	= "បញ្ចុះតំលៃ (5/5%)";
$lang['product_expiry']                     	= "ផលិតផលផុតកំណត់";
$lang['unit']                               			= "ឯកតា";
$lang['cost']                               		= "ថ្លៃដើម";
$lang['tax_method']                         	= "វិធីសាស្រ្តពន្ធដារ";
$lang['inclusive']                          		= "ការរួមបញ្ចូល";
$lang['exclusive']                          		= "មិនរួមបញ្ចូល";
$lang['expiry']                             		= "ផុតកំណត់";
$lang['customer_group']                     	= "ក្រុមអតិថិជន";
$lang['is_required']                        		= "ជាតំរូវការ";
$lang['form_action']                        		= "Form Action";
$lang['return_sales']                       		= "វិលត្រឡប់វិញការលក់";
$lang['list_return_sales']                  	= "បញ្ជីវិលត្រឡប់វិញលក់";
$lang['no_data_available']                  	= "គ្មានទិន្នន័យ";
$lang['disabled_in_demo']                   	= "យើងមានការសោកស្តាយប៉ុន្តែលក្ខណៈពិសេសនេះគឺត្រូវបានបិទនៅក្នុងការទស្សនាការបង្ហាញ .";
$lang['payment_reference_no']             	= "យោងការទូទាត់ លេខ";
$lang['gift_card_no']                       		= "កាតអំណោយ លេខ";
$lang['paying_by']                          		= "ការបង់ប្រាក់ដោយ";
$lang['cash']                               		= "ថវិកា";
$lang['gift_card']                          		= "កាតអំណោយ";
$lang['CC']                                 		= "Credit Card";
$lang['cheque']                             		= "Cheque";
$lang['cc_no']                              		= "Credit Card No";
$lang['cc_holder']                          		= "ឈ្មោះម្ចាស់កាត";
$lang['card_type']                          		= "Card Type";
$lang['Visa']                               		= "Visa";
$lang['MasterCard']                         		= "MasterCard";
$lang['Amex']                               		= "Amex";
$lang['Discover']                           		= "Discover";
$lang['month']                              		= "ខែ";
$lang['year']                               		= "ឆ្នាំ";
$lang['cvv2']                               		= "CVV2";
$lang['cheque_no']                          	= "Cheque No";
$lang['Visa']                               		= "Visa";
$lang['MasterCard']                         		= "MasterCard";
$lang['Amex']                               		= "Amex";
$lang['Discover']                           		= "Discover";
$lang['send_email']                         	= "ផ្ញើអ៊ីម៉ែល";
$lang['order_by']                           		= "បានតំរៀប ដោយ";
$lang['updated_by']                         	= "បានកែប្រែ ដោយ";
$lang['update_at']                          		= "កែប្រែ នៅ";
$lang['error_404']                          		= "404 រកមិនឃើញទំព័រ ";
$lang['default_customer_group']           	= "លំនាំដើមក្រុមអតិថិជន";
$lang['pos_settings']                       	= "ការកំណត់ POS";
$lang['pos_sales']                          		= "ការលក់ POS";
$lang['seller']                             		= "អ្នកលក់";
$lang['ip:']                                			= "IP:";
$lang['sp_tax']                             		= "បានលក់ផលិតផលជាប់ពន្ធ";
$lang['pp_tax']                             		= "បានទិញផលិតផលជាប់ពន្ធ";
$lang['overview_chart_heading']            = "ទិដ្ឋភាពទូទៅនៃគំនូសតាងសន្និធិរួមបញ្ចូលទាំងការលក់ប្រចាំខែជាមួយនឹងពន្ធលើផលិតផលនិងពន្ធលើការបញ្ជា (ជួរឈរ) ទិញ (បន្ទាត់) និងតម្លៃភាគហ៊ុននាពេលបច្ចុប្បន្ននេះដោយការចំណាយនិងតម្លៃ (ការនំ) ។ អ្នកអាចរក្សាទុកក្រាហ្វដែលជាទម្រង់ jpg, PNG, និង PDF បាន ";
$lang['stock_value']                        		= "ទំនិញជាតម្លៃ";
$lang['stock_value_by_price']               	= "ទំនិញជាតម្លៃ ដោយតំលៃលក់";
$lang['stock_value_by_cost']                	= "ទំនិញជាតម្លៃ ដោយតំលៃទិញ";
$lang['sold']                               		= "បានលក់";
$lang['purchased']                          		= "បានទិញ";
$lang['chart_lable_toggle']                 	= "អ្នកអាចផ្លាស់ប្ដូរដោយការចុចលើចំណងជើងគំនូសតាង។ សូមចុចចំណងជើងាំងអស់ខាងលើដើម្បីបង្ហាញ / លាក់វានៅក្នុងគំនូសតាង.";
$lang['register_report']                    		= "របាយការណ៍ការចុះឈ្មោះ";
$lang['sEmptyTable']                        	= "មិនមានទិន្នន័យដែលមាននៅក្នុងតារាង";
$lang['upcoming_events']                    	= "ព្រឹត្តិការណ៍ជិតមកដល់";
$lang['clear_ls']                           		= "សំអាតទិន្នន័យរក្សាទុកនៅក្នុងមូលដ្ឋានទាំងអស់";
$lang['clear']                              		= "សំអាត";
$lang['edit_order_discount']                	= "កែសម្រួលការលក់បញ្ចុះតំលៃ";
$lang['sales_discount_report']                	= "របាយការណ៍លក់បញ្ចុះតំលៃ";
$lang['product_variant']                    	= "ផលិផលតម្លៃលំអៀង";
$lang['product_variants']                   	= "ផលិផលតម្លៃលំអៀង";
$lang['prduct_not_found']                  	= "រកមិនឃើញផលិផល";
$lang['list_open_registers']                	= "បញ្ជីអ្នកចុះឈ្មោះ";
$lang['delivery']                           		= "ការដឹកជញ្ជូន";
$lang['serial_no']                          		= "លេខសម្គាល់";
$lang['logo']                               		= "Logo";
$lang['attachment']                         	= "ឯកសារភ្ជាប់";
$lang['balance']                            		= "តុល្យការ";
$lang['nothing_found']                      	= "គ្មានកំណត់ត្រាដែលបានផ្គូផ្គងបានរកឃើញ";
$lang['db_restored']                        		= "មូលដ្ឋានទិន្នន័យដែលបានស្ដារឡើងវិញដោយជោគជ័យ .";
$lang['backups']                            		= "ឯកសារបម្រុងទុក";
$lang['best_seller']                        		= "អ្នកលក់ដ៏ល្អបំផុត";
$lang['chart']                              		= "តារាង";
$lang['received']                           		= "Received";
$lang['returned']                           		= "Returned";
$lang['award_points']                       	= 'ចំនុចកំណត់រង្វាន់';
$lang['expenses']                           		= "ការចំណាយ";
$lang['add_expense']                        	= "បន្ថែមការចំណាយ";
$lang['other']                              		= "ផ្សេងទៀត";
$lang['none']                               		= "គ្មាន";
$lang['calculator']                         		= "ម៉ាស៊ីនគណនា";
$lang['updates']                            		= "កែសម្រួល";
$lang['update_available']                   	= "កម្មវិធីកែសម្រួលថ្មីអាចយកបាន, សូមទាញយកពេលនេះបាន.";
$lang['please_select_customer_warehouse']   = "សូមជ្រើសរើសអតិថិជន / ឃ្លាំង";
$lang['variants']                           		= "ផ្លាស់ប្តូរតំលៃ";
$lang['add_sale_by_csv']                    	= "បន្ថែមការលក់ CSV";
$lang['categories_report']                  	= "ប្រភេទរាយការណ៍";
$lang['adjust_quantity']                    	= "កែតម្រូវបរិមាណ";
$lang['quantity_adjustments']              	= "កែតម្រូវបរិមាណ";
$lang['partial']                            		= "ផ្នែក";
$lang['unexpected_value']                   	= "គុណតម្លៃដែលមិនបានរំពឹងទុកដែលបានផ្ដល់ !";
$lang['select_above']                       	= "សូមជ្រើសខាងលើមុន";
$lang['no_user_selected']                   	= "គ្មានអ្នកប្រើដែលបានជ្រើសទេ នោះសូមជ្រើសអ្នកប្រើយ៉ាងហោចណាស់មួយ";
$lang['due'] 										= "Due";
$lang['ordered'] 									= "លំដាប់";
$lang['profit'] 						    			= "ប្រាក់ចំណេញ";
$lang['unit_and_net_tip'] 				    = "គណនានៅលើឯកតា (ជាមួយនឹងការបង់ពន្ធ) ហើយសុទ្ធ (ដោយគ្មានការបង់ពន្ធ) ពោលគឺ <strong> ឬឯកតា (សុទ្ធ): </ strong> សម្រាប់លក់";
$lang['expiry_alerts'] 							= "ការជូនដំណឹង ផុតកំណត់";
$lang['quantity_alerts'] 						= "ការជូនដំណឹង បរិមាណ";
$lang['customer_payment_alerts']         = "ការជូនដំណឹង ការទូទាត់អតិថិជន";
$lang['supplier_payment_alerts']           = "ការជូនដំណឹង ការទូទាត់អ្នកផ្គត់ផ្គង់";
$lang['sale_suspend_alerts']  	            = "ការជូនដំណឹង ការទូទាត់កំណត់";
$lang['products_sale']                      	= "ថ្លៃលក់ផលិតផល";
$lang['products_cost']                      	= "ថ្លៃដើមផលិតផល";
$lang['day_profit']                         		= "ទិវាប្រាក់ចំណេញនិង / ឬការបាត់បង់";
$lang['get_day_profit']                     	= "អ្នកអាចចុចលើកាលបរិច្ឆេទដែលបានដើម្បីទទួលបានរបាយការណ៍ពីប្រាក់ចំណេញនិង / ឬការបាត់បង់តាមថ្ងៃ។ ";

$lang['please_select_these_before_adding_product'] = "សូមជ្រើសទាំងនេះមុនពេលលោកបានបន្ថែមថាផលិតផលណា";
$lang['deliveries_alerts']						= "ការជូនដំណឹង ដឹងជញ្ជូន";
$lang['accounts']									="គណនេយ្យ";
$lang['list_convert']								="បំលែងទំនិញ";
$lang['add_convert']					    	="បន្ថែមការបំលែងទំនិញ";
$lang['print_bacode_label']					="បោះពុម្ពបាកូដ";
$lang['adjustment_quantity']				="បរិមាណកែប្រែ";
$lang['update_quantity']						="នាំចូលទំនិញ";
$lang['import_purchase']						="នាំទំនិញចូល";
$lang['list_return_purchases']				="បញ្ជីផ្ទេរត្រឡប់";
$lang['list_billers']								="ហាងទំនិញ";
$lang['add_biller']								="បង្កើតហាង";
$lang['products_in_out']						= "របាយការណ៌ទំនិញចេញចូល";
$lang['account_settings']						= "កំណត់គណនេយ្យ";
$lang['products_return']						= "ទំនិញត្រឡប់";
$lang['print_barcode_label']					= "បោះពុម្ពបាកូដ";
$lang['list_loans']								= "បញ្ជីខ្ចី";
$lang['list_gift_cards']							= "បញ្ជីកាតសមាជិក";
$lang['list_sales_return']						= "បញ្ជីលក់ ត្រឡប់";
$lang['add_sale_return']						= "លក់ ត្រឡប់";
$lang['list_sales_suspend']					= "បញ្ជីលក់ព្យួរទុក";
$lang['suspend_calendar']					= "ប្រតិទិន​ ព្យួរទុក";
$lang['suspend_layout']						= "ប្លង់ព្យួរទុក";
$lang['document']								= "ឯកសារ";
$lang['list_products_return']					= "បញ្ជីផលិតផលត្រឡប់";
$lang['list_purchases_return']				= "បញ្ជីទិញត្រឡប់";
$lang['list_gift_cards']				    		= "បញ្ជីកាដូកាត";
$lang['list_journal']				    			= "បញ្ជីទិនានុប្បវត្តិ";
$lang['add_journal']				    			= "បង្កើតទិនានុប្បវត្តិ";
$lang['list_ac_receivable']					= "បញ្ជីប្រាក់អតិថិជនជំពាក់";
$lang['bill_receipt']				    			= "សាច់ប្រាក់អតិថិជនសង";
$lang['list_ac_payable']				    	= "បញ្ជីប្រាក់ជំពាក់អ្នកផ្គត់ផ្គង់";
$lang['bill_payable']				    		= "សាច់ប្រាក់សងអ្នកផ្គត់ផ្គង់";
$lang['biller_report']                      		= "រាយការណ៍ហាង";
$lang['print_cabon']								= "ការបោះពុម្ពCabon";
$lang['supplier_by_item_report']     	    = "របាយការណ៍ផលិតផលអ្នកផ្គត់ផ្គង់";
$lang['supplier_by_item']  					= "អ្នកផ្គត់ផ្គង់ផលិតផល";
$lang['suspend_report']  						= "របាយការណ៍ ព្យួរទុកលក់";
$lang['product_monthly_in_out']           	= "ផលិតផលប្រចាំខែនៅក្នុងការចេញ";
$lang['customer_no'] 							= "អតិថិជន ល.រ";
$lang['deposit']									= "ការកក់ប្រាក់";
$lang['this_customer_has_no_deposit']	= "អតិថិជននេះមានកក់ប្រាក់ទេ";
$lang['deposit_amount']						= "ចំនួនប្រាក់កក់";
$lang['list_deposits']							= "បញ្ញើចំនួនប្រាក់កក់";
$lang['deposits']									= "ប្រាក់កក់";
$lang['return_deposit']							= "បង្វល់ប្រាក់កក់វិញ";
$lang['deposit_note']							= "កំណត់ហេតុប្រាក់កក់";
$lang['edit_deposit']							= "កែតម្រូវប្រាក់កក់";
$lang['delete_deposit']						= "លុបប្រាក់កក់";

$lang['jobs']										= "ការងារ";
$lang['list_jobs']									= "បញ្ជីការងារធ្វើ";
$lang['job_activities']							= "សកម្មភាពការងារ";
$lang['job_employees']						= "ការងារបុគ្គលិក";
$lang['list_marchine']							= "បញ្ជីម៉ាស៊ីន";
$lang['marchine_activities']					= "សកម្មភាពម៉ាស៊ីន";
$lang['list_expenses']							= "បញ្ជីចំណាយ";
$lang['import_expense']						= "ចំណាយលើការនាំចូល";

$lang['gov_taxs']									= "ពន្ធរដ្ឋ";
$lang['selling_tax']								= "ពន្ធលើការលក់";
$lang['purchasing_tax']						= "ពន្ធលើការទិញ";
$lang['selling_tax_manual']								= "ពន្ធលើការលក់ដៃ";
$lang['purchasing_tax_manual']						= "ពន្ធលើការទិញដៃ";
$lang['staffing_tax']							= "ពន្ធលើបុគ្គលិក";
$lang['condition_tax']							= "លក្ខខណ្ឌពន្ធ";
$lang['exchange_rate_tax']					= "ពន្ធលើអត្រាប្តូរប្រាក់";
$lang['list_ac_head_tax']						= "តារាងបញ្ជីពន្ធគណនីពន្";
$lang['salary_tax']								= "ពន្ធលើប្រាក់ខែ";
$lang['value_added_tax']						= "តម្លៃពន្ធដែលបានបន្ថែម";
$lang['withholding_tax']						= "ពន្ធកាត់ទុក";
$lang['profit_tax']								= "ពន្ធលើប្រាក់ចំណេញ";
$lang['trial_balance_tax']								= "ពន្ធលើតារាងតុល្យភាព";

$lang['list_employees']						= "បញ្ជីបុគ្គលិក";
$lang['add_employee']							= "បន្ថែមបុគ្គលិក";
$lang['suspend']									= "ផ្អាក";

$lang['category_stock_chart']				= "តារាងប្រភេទស្តុក";
$lang['profit_chart']								= "តារាងប្រាក់ចំណេញ";
$lang['cash_analysis_chart']					= "តារាងវិភាគសាច់ប្រាក់";
$lang['monthly_product']						= "ផលិតផលប្រចាំខែ";
$lang['daily_product']							= "ផលិតផលប្រចាំថ្ងៃ";
$lang['supplier_products']						= "ផលិតផលក្រុមហ៊ុនផ្គត់ផ្គង់";
$lang['warehouse_reports']					= "របាយការណ៍ឃ្លាំង";
$lang['product_customers']					= "ផលិតផលអតិថិជន";
$lang['sales_profit_report']					= "របាយការណ៍ប្រាក់ចំណេញ";
$lang['saleman_report']						= "របាយការណ៍អ្នកលក់";
$lang['ledger']									= "សៀវភៅគណនី";
$lang['income_statement']					= "របាយការណ៍ចំណូល";
$lang['cash_book']								= "សៀវភៅសាច់ប្រាក់";
$lang['daily_purchases']						= "ការទិញប្រចាំថ្ងៃ";
$lang['monthly_purchases']					= "ការទិញប្រចាំខែ";

$lang['gov_reports']								= "របាយការណ៍រដ្ឋ";
$lang['annual_profit_tax']						= "ពន្ធលើប្រាក់ចំណេញប្រចាំឆ្នាំ";
$lang['sales_journal_list']						= "កំណត់ហេតុការលក់";
$lang['purchase_journal_list']				= "កំណត់ហេតុការទិញ";
$lang['tax_salary_list']							= "បញ្ជីពន្ធប្រាក់ខែ";
$lang['profit_lost']								= "ការខាតបង់ប្រាក់ចំណេញ";
$lang['profit_lost_tax']							= "ពន្ធការខាតបង់ប្រាក់ចំណេញ";
$lang['list_deposits']							= "បញ្ជីប្រាក់បញ្ញើ";
$lang['add_purchase_return']				= "បញ្ជីប្រាក់បញ្ញើ";
$lang['balance_sheet_tax']					= "ពន្ធលើតារាងតុល្យការ";
$lang['bom']										= "ផ្គុំ";
$lang['balance_sheet']							= "តារាងតុល្យការ";

//jobs

$lang['customer_name']						= "ឈ្មោះ​អតិថិជន";
$lang['developed_quantity']					= "បរិមាណអភិវឌ្ឍន៍";
$lang['total_quantity']							= "បរិមាណសរុប";
$lang['quantity_index']							= "បរិមាណគំរូ";
$lang['quantity_break']						= "បរិមាណខូច";
$lang['marchine_name']						= "ឈ្មោះម៉ាស៊ីន";
$lang['branch_name']							= "ឈ្មោះសាខា";
$lang['branch']									= "ឈ្មោះសាខា";
$lang['list_marchines']							= "បញ្ជីម៉ាស៊ីន";
$lang["benefit"]									= "អត្ថប្រយោជន៍";
$lang["deposit"]									= "ការដាក់ប្រាក់";
$lang["start_date"]								= "ថ្ងៃ​ចាប់​ផ្តើ​ម";
$lang["end_date"]								= "ថ្ងៃបញ្ចប់";
$lang["register"]									= "ចុះឈ្មោះ";
$lang["warehouse_products"]				= "ឃ្លាំងផលិតផល";
$lang["due"]										= "នៅសល់ប្រាក់";
$lang['due']										= "នៅសល់ប្រាក់";
$lang['trial_balance']							= "តារាងតុល្យភាព";
$lang['sale_code']								= "លេខកូដ";
$lang['saleman_name']						= "ឈ្មោះរបស់អ្នកលក់";
$lang['phone_number']							= "លេខទូរសព្ទ";
$lang['total_earned']							= "សរុបការរក ប្រាក់ចំណូល";
$lang['total_income']							= "ប្រាក់ចំណូលសរុប";
$lang['total_cost']								= "ចំណាយសរុប";
$lang['gross_margin']							= "ប្រាក់ចំណេញដុល";
$lang['total_expense']							= "ការចំណាយសរុប";
$lang['operating_expense']					= "ចំណាយលើប្រតិបត្តិការ";
$lang['current_assets']							= "ទ្រព្យសកម្ម";
$lang['fixed_assets']							= "ទ្រព្យសកម្មថេរ";
$lang['current_liabilities']						= "ទ្រព្យសកម្មរយះពេលខ្លី";
$lang['non_liabilities']							= "បំណុលរយះពេលវែង";
$lang['other_income']							= "ប្រាក់​ចំណូល​ផ្សេង​ទៀត";
$lang['other_expense']							= "ការចំណាយផ្សេងទៀត";
$lang['reports/trial_balance']				= "របាយការណ៍ / តារាងតុល្យភាព";
$lang['total_asset']								= "ទ្រព្យសកម្មសរុប";
$lang['liabilities']								= "បំណុល";
$lang['asset']										= "ទ្រព្យសកម្ម";
$lang['total_liabilities']						= "បំណុល​សរុប";
$lang['equities']									= "មូលនិធិ";
$lang['total_equities']							= "មូលនិធិសរុប";
$lang['total_liabilities_equities']			= "បំណុលមូលនិធិសរុប";
$lang["Total ASSET = LIABILITIES + EQUITY"]	= "ទ្រព្យសកម្មសរុប = បំណុល + មូលនិធិ";
$lang['please_wait']							= "សូម​រង់ចាំ";
$lang['list_ac_head_tax']						= "បញ្ជីគណនេយ្យពន្ធ";
$lang['add_jobs']								= "បន្ថែមការងារ";
$lang['edit_jobs']								= "កែសម្រួលការងារ";
$lang['delete_jobs']								= "លុបការងារ";
$lang['view_jobs']								= "មើលការងារ";

$lang['add_marchine_logs']					="បន្ថែមកំណត់ហេតុម៉ាស៊ីន";
$lang['edit_marchine']							= "ម៉ាស៊ីនកែសម្រួល";
$lang['delete_marchine']						= "លុបម៉ាស៊ីន";
$lang['[actions]']									= "[សកម្មភាព]";

$lang['group']										= "ក្រុម";
$lang['save_image']								= "រក្សាទុក​រូបភាព";
$lang['hide_form']								= "លាក់ Form";
$lang['show_form']								= "បង្ហាញ Form";
$lang['warehouse']								= "ឃ្លាំង";

$lang['edit_convert']							= "កែប្រែការបំលែង";
$lang['product_analysis']						= "ការវិភាគផលិតផល";
$lang['download_xls']							= "ទាញយក XLS";
$lang['add_suppend']							= "បន្ថែមព្យួរទុក";
$lang['free']										= "ឥតគិតថ្លៃ";
$lang['manage_sales']							= "គ្រប់គ្រងការលក់ ";
$lang['manage_products']						= "គ្រប់គ្រងផលិតផល";
$lang['manage_quotes']						= "គ្រប់គ្រងសម្រង់តំលៃ ";
$lang['manage_purchases']					= "គ្រប់គ្រងការទិញ";
$lang['manage_transfers']					= "គ្រប់គ្រងការផ្ទេរ ";
$lang['manage_jobs']							= "គ្រប់គ្រងការងារ ";
$lang['manage_accounts']					= "គ្រប់គ្រងគណនេយ្យ";
$lang['manage_gov_taxs']					= "គ្រប់គ្រងពន្ធរដ្ឋ";
$lang['manage_people']						= "គ្រប់គ្រងមនុស្ស ";
$lang['categories_value_report']			= "របាយការណ៍តម្លៃប្រភេទ";
$lang['sale_by_delivery_person']			= "លក់ដោយបុគ្គលដឹកជញ្ជូន";
$lang['print_tax_invoice']						= "វិក័យប័ត្រពន្ធ";
// calendar
$lang['title']										= "ចំណងជើង ";
$lang['start']										= "ចាប់ផ្តើម";
$lang['end']										= "បញ្ចប់";
$lang['event_color']								= "ដាក់ពណ៌ព្រឹត្តិការណ៍";


 // employee
 
 

$lang["edit_profile"]							= "កែសម្រួល  Profile ";
$lang["avatar"]									= "រូបតំនាង ";
$lang["change_avatar"]						= "ការផ្លាស់ប្តូររូបតំនាង ";
$lang["login_email"]							= "អ៊ីម៉ែលសម្រាប់ចូល ";
$lang["user_options"]							= "ជម្រើសរបស់អ្នកប្រើ ";
$lang["view_right"]								= "សិទ្ធក្នុងការមើល ";
$lang["edit_right"]								= "សិទ្ធក្នុងការកែសម្រួល";
$lang["allow_discount"]						= "អនុញ្ញាតឱ្យបញ្ចុះតម្លៃ";
 
