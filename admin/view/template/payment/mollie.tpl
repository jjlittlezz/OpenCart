<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
	<div class="page-header">
		<div class="container-fluid">
			<div class="pull-right">
				<?php if ($update_url){ ?>
				<a href="<?php echo $update_url; ?>" class="btn btn-success" data-toggle="tooltip" title="<?php echo $button_update; ?>"><i class="fa fa-arrow-circle-up"></i></a>
				<?php } ?>
				<button type="submit" form="form-mollie" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
				<a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
			<h1><?php echo $heading_title; ?></h1>
			<ul class="breadcrumb">
				<?php foreach ($breadcrumbs as $breadcrumb) { ?>
					<li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
				<?php } ?>
			</ul>
		</div>
	</div>
	<div class="container-fluid">
		<?php if ($modFilesError) { ?>
			<?php echo $modFilesError; ?>
		<?php } ?>
		<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-mollie" class="form-horizontal" <?php echo ($modFilesError) ? 'style="display: none;"' : ''?>>
			<?php $api_key = false; ?>
			<?php foreach ($stores as $store) { ?>
				<?php if ($error_warning) { ?>
				<div class="alert alert-danger alert-dismissable">
					<i class="fa fa-exclamation-circle"></i>
					<?php echo $store['name']; ?>: <?php echo $error_warning; ?>
					<button type="button" class="close" data-dismiss="alert">&times;
					</button>
				</div>
				<?php } ?>
				<?php if (!empty($store[$code . '_api_key'])) { ?>
					<?php $api_key = true; ?>
				<?php } ?>
			<?php } ?>
			<?php if (!$api_key) { ?>
			<div class="alert alert-info alert-dismissable">
				<i class="fa fa-info-circle"></i> <?php echo $help_view_profile; ?>
				<button type="button" class="close" data-dismiss="alert">&times;</button>
			</div>
			<?php } ?>
			<?php if ($update_url) { ?>
			<div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $text_update; ?>
				<button type="button" class="close" data-dismiss="alert">&times;</button>
			</div>
			<?php } ?>
			<?php if ($success) { ?>
			<div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
				<button type="button" class="close" data-dismiss="alert">&times;</button>
			</div>
			<?php } ?>
			<?php if ($warning) { ?>
			<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $warning; ?>
				<button type="button" class="close" data-dismiss="alert">&times;</button>
			</div>
			<?php } ?>
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
				</div>
				<div class="panel-body">
					<div class="form-group">
						<div class="col-sm-12">
							<a href="https://www.mollie.com/" target="_blank"><img src=" ../image/mollie/mollie_logo.png" border="0" alt="Mollie"/></a><br/><br/>
							<?php echo $entry_version; ?><br/><br/>
							&copy; 2004-<?php echo date('Y'); ?> Mollie
							B.V.
						</div>
					</div>

					<ul class="nav nav-tabs">
						<?php foreach ($stores as $store) { ?>
							<li class="<?php echo $store['store_id'] === 0 ? 'active' : ''; ?>"><a data-toggle="tab" href="#store<?php echo $store['store_id']; ?>"><?php echo $store['name']; ?></a></li>
						<?php } ?>
					</ul>

					<div class="tab-content">
						<?php foreach ($stores as $store) { ?>
						<div id="store<?php echo $store['store_id']; ?>" class="tab-pane fade in <?php echo $store['store_id'] === 0 ? 'active' : ''; ?>">
							<ul id="tabs<?php echo $store['store_id']; ?>" class="nav nav-tabs">
								<li class="active"><a data-toggle="tab" href="#mollie-options-<?php echo $store['store_id']; ?>"><?php echo $title_global_options; ?></a></li>
								<li><a data-toggle="tab" href="#payment-methods-<?php echo $store['store_id']; ?>"><?php echo $entry_payment_method; ?></a></li>
								<li><a data-toggle="tab" href="#payment-statuses-<?php echo $store['store_id']; ?>"><?php echo $title_payment_status; ?></a></li>
								<li><a data-toggle="tab" href="#mollie-mail-<?php echo $store['store_id']; ?>"><?php echo $title_mail; ?></a></li>
								<li><a data-toggle="tab" href="#support-<?php echo $store['store_id']; ?>">Support</a></li>
							</ul>

							<div class="tab-content">
								<div id="payment-methods-<?php echo $store['store_id']; ?>" class="tab-pane fade in" style="margin-left:30px;margin-right: 30px;">
									<div class="form-group">
										<div class="col-sm-3"><strong><?php echo $entry_payment_method; ?></strong></div>
										<div class="col-sm-2"><strong><?php echo $entry_activate; ?></strong></div>
										<div class="col-sm-3"><strong><?php echo $entry_geo_zone; ?></strong></div>
										<div class="col-sm-2 text-right"><strong><?php echo $entry_sort_order; ?></strong></div>
										<div class="col-sm-2 text-right"><strong><?php echo $text_more; ?></strong></div>
									</div>
									<?php foreach ($store_data[$store['store_id'] . '_' . $code . '_payment_methods'] as $module_id => $payment_method) { ?>
									<div class="form-group">
										<div class="col-sm-3">
											<img src="<?php echo $payment_method['icon']; ?>" width="25" style="float:left; margin-right:1em; margin-top:-3px"/>
											<?php echo $payment_method['name']; ?>
											<?php if(($payment_method['name'] == 'Apple Pay') && !$store_data['creditCardEnabled']) { ?>
												<span data-toggle="tooltip" title="<?php echo $help_apple_pay; ?>" style="border: 1px solid; border-radius: 9px; background: #fff; color: #ffb100; text-transform: uppercase; margin-left: 5px; letter-spacing: .03em; line-height: 17px; padding: 0 6px; font-size: 10px;"><?php echo $text_creditcard_required; ?></span>
											<?php } ?>
										</div>
										<div class="col-sm-2">
											<?php $show_checkbox = true ?>
											<?php if (empty($store[$code . '_api_key']) || !empty($store['error_api_key'])) { ?>
											<?php $show_checkbox = false ?>
											<?php echo $text_missing_api_key; ?>
											<?php } elseif (!$payment_method['allowed']) { ?>
											<?php $show_checkbox = false ?>
											<?php echo (!$store['mollie_connection']) ? $text_activate_payment_method : ''; ?>
											<?php } ?>
											<input type="checkbox" value="1" name="<?php echo $store['store_id']; ?>_<?php echo $code; ?>_<?php echo $module_id; ?>_status" <?php echo $payment_method['status'] ? 'checked' : ''; ?> style="cursor:pointer;<?php echo !$show_checkbox ? 'display: none;' : ''; ?>" />
											<?php if($store['mollie_connection'] && !empty($store[$code . '_api_key']) && empty($store['error_api_key'])) { ?>
											<?php if(!$show_checkbox) { ?>
												<?php $apiExcludedMethods = array("creditcard", "paysafecard", "giftcard", "p24", "paypal"); ?>
												<?php if(in_array(strtolower($payment_method['name']), $apiExcludedMethods)) { ?>
													<?php echo $text_enable_payment_method; ?>
												<?php } else { ?>
												<a href="<?php echo $payment_method['enable']; ?>" style="position: relative; bottom: 4px; <?php echo ((strtolower($payment_method['name']) == 'apple pay') && !$store_data['creditCardEnabled']) ? 'pointer-events: none; cursor: default; opacity: 0.8;' : ''; ?>"><span class="label label-success"><?php echo $text_enable; ?></span></a>
												<?php } ?>
											<?php } ?>
											<?php } ?> 
										</div>
										<div class="col-sm-3">
											<select name="<?php echo $store['store_id']; ?>_<?php echo $code; ?>_<?php echo $module_id; ?>_geo_zone" class="form-control">
												<option value="0"><?php echo $text_all_zones; ?></option>
												<?php foreach ($geo_zones as $geo_zone) { ?>
													<?php if ($geo_zone['geo_zone_id'] === $payment_method['geo_zone']) { ?>
													<option value="<?php echo $geo_zone['geo_zone_id']; ?>" selected="selected"><?php echo $geo_zone['name']; ?></option>
													<?php } else { ?>
													<option value="<?php echo $geo_zone['geo_zone_id']; ?>"><?php echo $geo_zone['name']; ?></option>
													<?php } ?>
												<?php } ?>
											</select>
										</div>
										<div class="col-sm-2">
											<input type="text" name="<?php echo $store['store_id']; ?>_<?php echo $code; ?>_<?php echo $module_id; ?>_sort_order" value="<?php echo $payment_method['sort_order']; ?>" class="form-control" style="text-align:right;"/>
										</div>
										<div class="col-sm-2 text-right">
											<a href="javascript:void(0)" data-toggle="modal" data-target="#payment-option-<?php echo $store['store_id']; ?>-<?php echo $module_id; ?>" class="btn btn-primary"><i class="fa fa-cog"></i></a>
										</div>
									</div>

									<!-- Advance Options -->
									<div class="modal fade" id="payment-option-<?php echo $store['store_id']; ?>-<?php echo $module_id; ?>" tabindex="-1" role="dialog" aria-hidden="true">
									  <div class="modal-dialog modal-lg" role="document">
									    <div class="modal-content">
									      <div class="modal-header">
									        <button type="button" class="close" data-dismiss="modal">&times;</button>
									        <h4 class="modal-title"><?php echo sprintf($text_advance_option, ucwords($payment_method['name'])); ?></h4>
									      </div>
									      <div class="modal-body">
									      	<div class="form-group">
												<label class="col-sm-2 control-label"><?php echo $entry_title; ?></label>
												<div class="col-sm-10">
													<?php foreach ($languages as $language) { ?>
													<div class="input-group"><span class="input-group-addon"><img src="<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
													<input type="text" name="<?php echo $store['store_id']; ?>_<?php echo $code; ?>_<?php echo $module_id; ?>_description[<?php echo $language['language_id']; ?>][title]" value="<?php echo isset($payment_method['description'][$language['language_id']]) ? $payment_method['description'][$language['language_id']]['title'] : $payment_method['name']; ?>" class="form-control"/>
													</div>
													<?php } ?>
													<input type="hidden" name="<?php echo $store['store_id']; ?>_<?php echo $code; ?>_<?php echo $module_id; ?>_name" value="<?php echo $payment_method['name']; ?>">													
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-2 control-label"><?php echo $entry_image; ?></label>
												<div class="col-sm-10">
													<a href="" id="thumb-image-<?php echo $store['store_id']; ?>-<?php echo $module_id; ?>" data-toggle="image" class="img-thumbnail"><img src="<?php echo $payment_method['thumb']; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>"/></a> <input type="hidden" name="<?php echo $store['store_id']; ?>_<?php echo $code; ?>_<?php echo $module_id; ?>_image" value="<?php echo $payment_method['image']; ?>" id="input-image-<?php echo $store['store_id']; ?>-<?php echo $module_id; ?>"/>
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-2 control-label"><?php echo $entry_payment_fee; ?></label>
												<div class="col-sm-10">
													<label class="col-sm-2 control-label"><?php echo $entry_title; ?></label>
													<div class="col-sm-4">														
														<?php foreach ($languages as $language) { ?>
														<div class="input-group"><span class="input-group-addon"><img src="<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
														<input type="text" name="<?php echo $store['store_id']; ?>_<?php echo $code; ?>_<?php echo $module_id; ?>_payment_fee[description][<?php echo $language['language_id']; ?>][title]" value="<?php echo isset($payment_method['payment_fee']['description'][$language['language_id']]) ? $payment_method['payment_fee']['description'][$language['language_id']]['title'] : ''; ?>" placeholder="<?php echo $entry_title; ?>" class="form-control"/>
														</div>
														<?php } ?>
													</div>
													<label class="col-sm-2 control-label"><?php echo $entry_amount; ?></label>
													<div class="col-sm-4">
														<input type="text" name="<?php echo $store['store_id']; ?>_<?php echo $code; ?>_<?php echo $module_id; ?>_payment_fee[amount]" value="<?php echo $payment_method['payment_fee']['amount']; ?>" placeholder="<?php echo $entry_amount; ?>" class="form-control"/>
													</div>
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_total; ?>"><?php echo $entry_total; ?></span></label>
												<div class="col-sm-10">
													<label class="col-sm-2 control-label"><?php echo $entry_minimum; ?></label>
													<div class="col-sm-4">
														<input type="text" name="<?php echo $store['store_id']; ?>_<?php echo $code; ?>_<?php echo $module_id; ?>_total_minimum" value="<?php echo isset($payment_method['total_minimum']) ? $payment_method['total_minimum'] : ''; ?>" placeholder="<?php echo $entry_minimum; ?>" class="form-control"/>
														<sub><?php echo isset($payment_method['minimumAmount']) ? $payment_method['minimumAmount'] : ''; ?></sub>
													</div>
													<label class="col-sm-2 control-label"><?php echo $entry_maximum; ?></label>
													<div class="col-sm-4">
														<input type="text" name="<?php echo $store['store_id']; ?>_<?php echo $code; ?>_<?php echo $module_id; ?>_total_maximum" value="<?php echo isset($payment_method['total_maximum']) ? $payment_method['total_maximum'] : ''; ?>" placeholder="<?php echo $entry_maximum; ?>" class="form-control"/>
														<sub><?php echo isset($payment_method['maximumAmount']) ? $payment_method['maximumAmount'] : ''; ?></sub>
													</div>												
												</div>
											</div>
									      </div>
									      <div class="modal-footer">
									        <button type="button" class="btn btn-secondary" data-dismiss="modal"><?php echo $button_save; ?></button>
									      </div>
									    </div>
									  </div>
									</div>
									<?php } ?>
								</div>

								<div id="payment-statuses-<?php echo $store['store_id']; ?>" class="tab-pane fade in">
									<div class="form-group">
										<label class="col-sm-2 control-label" for="<?php echo $code; ?>_ideal_pending_status_id"><?php echo $entry_pending_status; ?></label>
										<div class="col-sm-10">
											<select name="<?php echo $store['store_id']; ?>_<?php echo $code; ?>_ideal_pending_status_id" id="<?php echo $code; ?>_ideal_pending_status_id" class="form-control">
												<?php foreach ($order_statuses as $order_status) { ?>
													<?php if ($order_status['order_status_id'] == $store[$code . '_ideal_pending_status_id']) { ?>
													<option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
													<?php } else { ?>
													<option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
													<?php } ?>
												<?php } ?>
											</select>
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-2 control-label" for="<?php echo $code; ?>_ideal_failed_status_id"><?php echo $entry_failed_status; ?></label>
										<div class="col-sm-10">
											<select name="<?php echo $store['store_id']; ?>_<?php echo $code; ?>_ideal_failed_status_id" id="<?php echo $code; ?>_ideal_failed_status_id" class="form-control">
												<?php if (empty($store[$code . '_ideal_failed_status_id'])) { ?>
												<option value="0" selected="selected"><?php echo $text_no_status_id; ?></option>
												<?php } else { ?>
												<option value="0"><?php echo $text_no_status_id; ?></option>
												<?php } ?>
												<?php foreach ($order_statuses as $order_status) { ?>
													<?php if ($order_status['order_status_id'] == $store[$code . '_ideal_failed_status_id']) { ?>
													<option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
													<?php } else { ?>
													<option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
													<?php } ?>
												<?php } ?>
											</select>
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-2 control-label" for="<?php echo $code; ?>_ideal_canceled_status_id"><?php echo $entry_canceled_status; ?></label>
										<div class="col-sm-10">
											<select name="<?php echo $store['store_id']; ?>_<?php echo $code; ?>_ideal_canceled_status_id" id="<?php echo $code; ?>_ideal_canceled_status_id" class="form-control">
												<?php if (empty($store[$code . '_ideal_canceled_status_id'])) { ?>
												<option value="0" selected="selected"><?php echo $text_no_status_id; ?></option>
												<?php } else { ?>
												<option value="0"><?php echo $text_no_status_id; ?></option>
												<?php } ?>
												<?php foreach ($order_statuses as $order_status) { ?>
													<?php if ($order_status['order_status_id'] == $store[$code . '_ideal_canceled_status_id']) { ?>
													<option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
													<?php } else { ?>
													<option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
													<?php } ?>
												<?php } ?>
											</select>
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-2 control-label" for="<?php echo $code; ?>_ideal_expired_status_id"><?php echo $entry_expired_status; ?></label>
										<div class="col-sm-10">
											<select name="<?php echo $store['store_id']; ?>_<?php echo $code; ?>_ideal_expired_status_id" id="<?php echo $code; ?>_ideal_expired_status_id" class="form-control">
												<?php if (empty($store[$code . '_ideal_expired_status_id'])) { ?>
												<option value="0" selected="selected"><?php echo $text_no_status_id; ?></option>
												<?php } else { ?>
												<option value="0"><?php echo $text_no_status_id; ?></option>
												<?php } ?>
												<?php foreach ($order_statuses as $order_status) { ?>
													<?php if ($order_status['order_status_id'] == $store[$code . '_ideal_expired_status_id']) { ?>
													<option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
													<?php } else { ?>
													<option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
													<?php } ?>
												<?php } ?>
											</select>
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-2 control-label" for="<?php echo $code; ?>_ideal_processing_status_id"><?php echo $entry_processing_status; ?></label>
										<div class="col-sm-10">
											<select name="<?php echo $store['store_id']; ?>_<?php echo $code; ?>_ideal_processing_status_id" id="<?php echo $code; ?>_ideal_processing_status_id" class="form-control">
												<?php foreach ($order_statuses as $order_status) { ?>
													<?php if ($order_status['order_status_id'] == $store[$code . '_ideal_processing_status_id']) { ?>
													<option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
													<?php } else { ?>
													<option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
													<?php } ?>
												<?php } ?>
											</select>
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-2 control-label" for="<?php echo $code; ?>_ideal_shipping_status_id"><?php echo $entry_shipping_status; ?></label>
										<div class="col-sm-10">
											<select name="<?php echo $store['store_id']; ?>_<?php echo $code; ?>_ideal_shipping_status_id" id="<?php echo $code; ?>_ideal_shipping_status_id" class="form-control">
												<?php foreach ($order_statuses as $order_status) { ?>
													<?php if ($order_status['order_status_id'] == $store[$code . '_ideal_shipping_status_id']) { ?>
													<option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
													<?php } else { ?>
													<option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
													<?php } ?>
												<?php } ?>
											</select>
										</div>
									</div>

									<div class="form-group">
										<label class="col-sm-2 control-label" for="<?php echo $code; ?>_ideal_refund_status_id"><?php echo $entry_refund_status; ?></label>
										<div class="col-sm-10">
											<select name="<?php echo $store['store_id']; ?>_<?php echo $code; ?>_ideal_refund_status_id" id="<?php echo $code; ?>_ideal_refund_status_id" class="form-control">
												<?php foreach ($order_statuses as $order_status) { ?>
													<?php if ($order_status['order_status_id'] == $store[$code . '_ideal_refund_status_id']) { ?>
													<option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
													<?php } else { ?>
													<option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
													<?php } ?>
												<?php } ?>
											</select>
										</div>
									</div>

									<div class="form-group">
										<label class="col-sm-2 control-label" for="<?php echo $code; ?>_ideal_partial_refund_status_id"><?php echo $entry_partial_refund_status; ?></label>
										<div class="col-sm-10">
											<select name="<?php echo $store['store_id']; ?>_<?php echo $code; ?>_ideal_partial_refund_status_id" id="<?php echo $code; ?>_ideal_partial_refund_status_id" class="form-control">
												<?php foreach ($order_statuses as $order_status) { ?>
													<?php if ($order_status['order_status_id'] == $store[$code . '_ideal_partial_refund_status_id']) { ?>
													<option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
													<?php } else { ?>
													<option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
													<?php } ?>
												<?php } ?>
											</select>
										</div>
									</div>
								</div>

								<div id="mollie-options-<?php echo $store['store_id']; ?>" class="tab-pane fade in active">
									<fieldset>
										<legend><?php echo $text_mollie_api; ?></legend>
										<div class="form-group <?php echo $api_required ? 'required' : '' ?>">
											<label class="col-sm-2 control-label" for="<?php echo $code; ?>_api_key"><span data-toggle="tooltip" title="<?php echo $help_api_key; ?>"><?php echo $entry_api_key; ?></span></label>
											<div class="col-sm-10">
												<div class="input-group">
													<span class="input-group-addon"><?php echo ($store[$code . '_api_key']) ? '<i class="fa fa-check text-success"></i>' : '<i class="fa fa-minus"></i>' ;?></span>
													<input type="text" name="<?php echo $store['store_id']; ?>_<?php echo $code; ?>_api_key" value="<?php echo $store[$code . '_api_key']; ?>" placeholder="live_..." id="<?php echo $code; ?>_api_key" class="form-control" store="<?php echo $store['store_id']; ?>" <?php echo $store['store_id']; ?>-data-payment-mollie-api-key/>
													<input type="text" value="" class="form-control" <?php echo $store['store_id']; ?>-data-payment-mollie-api-key-hide>
													<span class="input-group-addon toggleAPIKey<?php echo $store['store_id']; ?>"><i class="fa fa-eye"></i></span>
												</div>
												<?php if ($store['error_api_key']) { ?>
												<div class="text-danger"><?php echo $store['error_api_key']; ?></div>
												<?php } ?>
											</div>
										</div>
									</fieldset>
									<fieldset>
										<legend><?php echo $text_mollie_app; ?></legend>
										<div class="form-group">
											<label class="col-sm-2 control-label" for="<?php echo $code; ?>_client_id"><span data-toggle="tooltip" title="<?php echo $help_mollie_app; ?>"><?php echo $entry_client_id; ?></span></label>
											<div class="col-sm-10">					
												<input type="text" name="<?php echo $store['store_id']; ?>_<?php echo $code; ?>_client_id" value="<?php echo $store[$code . '_client_id']; ?>" placeholder="<?php echo $entry_client_id; ?>" id="<?php echo $code; ?>_client_id" class="form-control" store="<?php echo $store['store_id']; ?>" <?php echo $store['store_id']; ?>-data-payment-mollie-client-id/>
											</div>
										</div>

										<div class="form-group">
											<label class="col-sm-2 control-label" for="<?php echo $code; ?>_client_secret"><span data-toggle="tooltip" title="<?php echo $help_mollie_app; ?>"><?php echo $entry_client_secret; ?></span></label>
											<div class="col-sm-10">				
												<input type="text" name="<?php echo $store['store_id']; ?>_<?php echo $code; ?>_client_secret" value="<?php echo $store[$code . '_client_secret']; ?>" placeholder="<?php echo $entry_client_secret; ?>" id="<?php echo $code; ?>_client_secret" class="form-control" store="<?php echo $store['store_id']; ?>" <?php echo $store['store_id']; ?>-data-payment-mollie-client-secret/>
											</div>
										</div>

										<div class="form-group">
											<label class="col-sm-2 control-label" for="<?php echo $code; ?>_client_secret"><span data-toggle="tooltip" title="<?php echo $help_redirect_uri; ?>"><?php echo $entry_redirect_uri; ?></span></label>
											<div class="col-sm-10">				
												<input type="text" name="" value="<?php echo $store['redirect_uri']; ?>" class="form-control" readonly />
											</div>
										</div>

										<div class="form-group">
											<label class="col-sm-2 control-label" for="mollie-connect"><?php echo $entry_mollie_connect; ?></label>
											<div class="col-sm-10">
												<div class="input-group">
													<span class="input-group-addon"><?php echo ($store['mollie_connection']) ? '<i class="fa fa-check text-success"></i>' : '<i class="fa fa-minus"></i>' ;?></span>
													<a href="<?php echo $store['mollie_connect']; ?>" id="<?php echo $store['store_id']; ?>_button_mollie_connect" mollie-connection="<?php echo ($store['mollie_connection']) ? '1' : '0' ;?>" style="<?php echo (($store[$code . '_client_id'] == '') || ($store[$code . '_client_secret'] == '') || ($store['mollie_connection'])) ? 'opacity: 0.6; pointer-events: none;' : ''; ?>"><img src="../image/mollie/mollie_connect.png" alt="<?php echo $button_mollie_connect; ?>" style="width: 152px;height: auto;" /></a>
												</div>
											</div>
										</div>

										<input type="hidden" name="<?php echo $store['store_id']; ?>_<?php echo $code; ?>_refresh_token" value="<?php echo $store[$code . '_refresh_token']; ?>">
									</fieldset>
									<fieldset>
										<legend><?php echo $text_general; ?></legend>		
										<div class="form-group">
											<label class="col-sm-2 control-label" for="input-show-icons"><span data-toggle="tooltip" title="<?php echo $help_show_icons; ?>"><?php echo $entry_show_icons; ?></span></label>
											<div class="col-sm-10">
												<select name="<?php echo $store['store_id']; ?>_<?php echo $code; ?>_show_icons" id="<?php echo $store['store_id']; ?>-show-icons" class="form-control">
													<?php if ($store[$code . '_show_icons']) { ?>
													<option value="1" selected="selected"><?php echo $text_yes; ?></option>
													<option value="0"><?php echo $text_no; ?></option>
													<?php } else { ?>
													<option value="1"><?php echo $text_yes; ?></option>
													<option value="0" selected="selected"><?php echo $text_no; ?></option>
													<?php } ?>
												</select>
											</div>
										</div>
										<div class="form-group" id="<?php echo $store['store_id']; ?>-align-icons">
											<label class="col-sm-2 control-label" for="input-align-icons"><?php echo $entry_align_icons; ?></label>
											<div class="col-sm-10">
												<label class="radio-inline">
													<?php if ($store[$code . '_align_icons'] == 'left') { ?>
													<input type="radio" name="<?php echo $store['store_id']; ?>_<?php echo $code; ?>_align_icons" value="left" checked="checked" />
													<?php echo $text_left; ?>
													<?php } else { ?>
													<input type="radio" name="<?php echo $store['store_id']; ?>_<?php echo $code; ?>_align_icons" value="left" />
													<?php echo $text_left; ?>
													<?php } ?>
												</label>
												<label class="radio-inline">
													<?php if ($store[$code . '_align_icons'] != 'left') { ?>
													<input type="radio" name="<?php echo $store['store_id']; ?>_<?php echo $code; ?>_align_icons" value="right" checked="checked" />
													<?php echo $text_right; ?>
													<?php } else { ?>
													<input type="radio" name="<?php echo $store['store_id']; ?>_<?php echo $code; ?>_align_icons" value="right" />
													<?php echo $text_right; ?>
													<?php } ?>
												</label>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label" for="input-status"><span data-toggle="tooltip" title="<?php echo $help_show_order_canceled_page; ?>"><?php echo $entry_show_order_canceled_page; ?></span></label>
											<div class="col-sm-10">
												<select name="<?php echo $store['store_id']; ?>_<?php echo $code; ?>_show_order_canceled_page" id="input-status" class="form-control">
													<?php if ($store[$code . '_show_order_canceled_page']) { ?>
													<option value="1" selected="selected"><?php echo $text_yes; ?></option>
													<option value="0"><?php echo $text_no; ?></option>
													<?php } else { ?>
													<option value="1"><?php echo $text_yes; ?></option>
													<option value="0" selected="selected"><?php echo $text_no; ?></option>
													<?php } ?>
												</select>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label" for="input-language"><?php echo $entry_payment_screen_language; ?></label>
											<div class="col-sm-10">
												<select name="<?php echo $store['store_id']; ?>_<?php echo $code; ?>_payment_screen_language" id="input-language" class="form-control">
													<?php foreach ($languages as $language) { ?>
								                    <?php if ($language['code'] == $store[$code . '_payment_screen_language']) { ?>
								                    <option value="<?php echo $language['code']; ?>" selected="selected"><?php echo $language['name']; ?></option>
								                    <?php } else { ?>
								                    <option value="<?php echo $language['code']; ?>"><?php echo $language['name']; ?></option>
								                    <?php } ?>
								                    <?php } ?>
												</select>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label" for="input-shipment"><span data-toggle="tooltip" title="<?php echo $help_shipment; ?>"><?php echo $entry_shipment; ?></span></label>
											<div class="col-sm-10">
												<select name="<?php echo $store['store_id']; ?>_<?php echo $code; ?>_create_shipment" id="<?php echo $store['store_id']; ?>-create-shipment" class="form-control">
													<?php if ($store[$code . '_create_shipment'] == 1) { ?>
													<option value="1" selected="selected"><?php echo $text_create_shipment_automatically; ?></option>
													<option value="2"><?php echo $text_create_shipment_on_status; ?></option>
													<?php if($is_order_complete_status) { ?>
													<option value="3"><?php echo $text_create_shipment_on_order_complete; ?></option>
													<?php } ?>
													<?php } elseif ($store[$code . '_create_shipment'] == 2) { ?>
													<option value="1"><?php echo $text_create_shipment_automatically; ?></option>
													<option value="2" selected="selected"><?php echo $text_create_shipment_on_status; ?></option>
													<?php if($is_order_complete_status) { ?>
													<option value="3"><?php echo $text_create_shipment_on_order_complete; ?></option>
													<?php } ?>
													<?php } else { ?>
													<option value="1"><?php echo $text_create_shipment_automatically; ?></option>
													<option value="2" selected="selected"><?php echo $text_create_shipment_on_status; ?></option>
													<option value="3" selected="selected"><?php echo $text_create_shipment_on_order_complete; ?></option>
													<?php } ?>
												</select>
											</div>
										</div>
										<div class="form-group" id="<?php echo $store['store_id']; ?>-create-shipment-status">
											<label class="col-sm-2 control-label" for="<?php echo $code; ?>_create_shipping_status_id"><?php echo $entry_create_shipment_status; ?></label>
											<div class="col-sm-10">
												<select name="<?php echo $store['store_id']; ?>_<?php echo $code; ?>_create_shipment_status_id" id="<?php echo $code; ?>_create_shipment_status_id" class="form-control">
													<?php foreach ($order_statuses as $order_status) { ?>
														<?php if ($order_status['order_status_id'] == $store[$code . '_create_shipment_status_id']) { ?>
														<option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
														<?php } else { ?>
														<option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
														<?php } ?>
													<?php } ?>
												</select>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label" for="<?php echo $code; ?>_order_expiry_days"><?php echo $entry_order_expiry_days; ?></label>
											<div class="col-sm-10">				
												<input type="text" name="<?php echo $store['store_id']; ?>_<?php echo $code; ?>_order_expiry_days" value="<?php echo $store[$code . '_order_expiry_days']; ?>" placeholder="<?php echo $entry_order_expiry_days; ?> [1-100]" id="<?php echo $code; ?>_order_expiry_days" class="form-control" store="<?php echo $store['store_id']; ?>" <?php echo $store['store_id']; ?>-data-payment-mollie-order-expiry-days/>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label" for="input-payment-fee-tax-class"><?php echo $entry_payment_fee_tax_class; ?></label>
											<div class="col-sm-10">
												<select name="<?php echo $store['store_id']; ?>_<?php echo $code; ?>_payment_fee_tax_class_id" id="input-payment-fee-tax-class" class="form-control">
													<option value="0"><?php echo $text_select; ?></option>
													<?php foreach ($tax_classes as $tax_class) { ?>		
														<?php if ($tax_class['tax_class_id'] == $store[$code . '_payment_fee_tax_class_id']) { ?>
														<option value="<?php echo $tax_class['tax_class_id']; ?>" selected="selected"><?php echo $tax_class['title']; ?></option>
														<?php } else { ?>
														<option value="<?php echo $tax_class['tax_class_id']; ?>"><?php echo $tax_class['title']; ?></option>
														<?php } ?>
													<?php } ?>
												</select>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label" for="input-single-click-payment"><span data-toggle="tooltip" title="<?php echo $help_single_click_payment; ?>"><?php echo $entry_single_click_payment; ?></span></label>
											<div class="col-sm-10">
												<select name="<?php echo $store['store_id']; ?>_<?php echo $code; ?>_single_click_payment" id="input-single-click-payment" class="form-control">
													<?php if ($store[$code . '_single_click_payment']) { ?>
													<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
													<option value="0"><?php echo $text_disabled; ?></option>
													<?php } else { ?>
													<option value="1"><?php echo $text_enabled; ?></option>
													<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
													<?php } ?>
												</select>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label" for="input-partial-refund"><?php echo $entry_partial_refund; ?></label>
											<div class="col-sm-10">
												<select name="<?php echo $store['store_id']; ?>_<?php echo $code; ?>_partial_refund" id="input-partial-refund" class="form-control">
													<?php if ($store[$code . '_partial_refund']) { ?>
													<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
													<option value="0"><?php echo $text_disabled; ?></option>
													<?php } else { ?>
													<option value="1"><?php echo $text_enabled; ?></option>
													<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
													<?php } ?>
												</select>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label" for="input-default-currency"><?php echo $entry_default_currency; ?></label>
											<div class="col-sm-10">
												<select name="<?php echo $store['store_id']; ?>_<?php echo $code; ?>_default_currency" id="input-default-currency" class="form-control">
													<option value="DEF" selected="selected"><?php echo $text_default_currency; ?></option>
													<?php foreach ($currencies as $key=>$currency) { ?>
								                    <?php if ($currency['code'] == $store[$code . '_default_currency']) { ?>
								                    <option value="<?php echo $currency['code']; ?>" selected="selected"><?php echo $currency['title']; ?></option>
								                    <?php } else { ?>
								                    <option value="<?php echo $currency['code']; ?>"><?php echo $currency['title']; ?></option>
								                    <?php } ?>
								                    <?php } ?>
												</select>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label" for="input-mollie-component"><span data-toggle="tooltip" title="<?php echo $help_mollie_component; ?>"><?php echo $entry_mollie_component; ?></span></label>
											<div class="col-sm-10">
												<select name="<?php echo $store['store_id']; ?>_<?php echo $code; ?>_mollie_component" id="input-mollie-component" class="form-control">
													<?php if ($store[$code . '_mollie_component']) { ?>
													<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
													<option value="0"><?php echo $text_disabled; ?></option>
													<?php } else { ?>
													<option value="1"><?php echo $text_enabled; ?></option>
													<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
													<?php } ?>
												</select>
											</div>
										</div>
									</fieldset>
									<fieldset>
										<legend><?php echo $text_custom_css; ?></legend>
										<div class="row">
											<div class="col-sm-4">
												<div class="col-sm-12 text-center form-group"><h4><?php echo $entry_mollie_component_base; ?></h4></div>
												<div class="form-group">
													<label class="col-sm-6 control-label" for="input-bg-color-base"><?php echo $text_bg_color; ?></label>
													<div class="col-sm-6">
														<input type="text" name="<?php echo $store['store_id']; ?>_<?php echo $code; ?>_mollie_component_css_base[background_color]" id="input-bg-color-base" class="form-control" value="<?php echo $store[$code . '_mollie_component_css_base']['background_color']; ?>">
													</div>
												</div>
												<div class="form-group">
													<label class="col-sm-6 control-label" for="input-color-base"><?php echo $text_color; ?></label>
													<div class="col-sm-6">
														<input type="text" name="<?php echo $store['store_id']; ?>_<?php echo $code; ?>_mollie_component_css_base[color]" id="input-color-base" class="form-control" value="<?php echo $store[$code . '_mollie_component_css_base']['color']; ?>">
													</div>
												</div>
												<div class="form-group">
													<label class="col-sm-6 control-label" for="input-font-size-base"><?php echo $text_font_size; ?></label>
													<div class="col-sm-6">
														<input type="text" name="<?php echo $store['store_id']; ?>_<?php echo $code; ?>_mollie_component_css_base[font_size]" id="input-font-size-base" class="form-control" value="<?php echo $store[$code . '_mollie_component_css_base']['font_size']; ?>">
													</div>
												</div>
												<div class="form-group">
													<label class="col-sm-6 control-label" for="input-other-css"><?php echo $text_other_css; ?></label>
													<div class="col-sm-6">
														<textarea name="<?php echo $store['store_id']; ?>_<?php echo $code; ?>_mollie_component_css_base[other_css]" id="input-other-css" class="form-control"><?php echo $store[$code . '_mollie_component_css_base']['other_css']; ?></textarea>
													</div>
												</div>												
											</div>
											<div class="col-sm-4">
												<div class="col-sm-12 text-center form-group"><h4><?php echo $entry_mollie_component_valid; ?></h4></div>
												<div class="form-group">
													<label class="col-sm-6 control-label" for="input-bg-color-valid"><?php echo $text_bg_color; ?></label>
													<div class="col-sm-6">
														<input type="text" name="<?php echo $store['store_id']; ?>_<?php echo $code; ?>_mollie_component_css_valid[background_color]" id="input-bg-color-valid" class="form-control" value="<?php echo $store[$code . '_mollie_component_css_valid']['background_color']; ?>">
													</div>
												</div>
												<div class="form-group">
													<label class="col-sm-6 control-label" for="input-color-valid"><?php echo $text_color; ?></label>
													<div class="col-sm-6">
														<input type="text" name="<?php echo $store['store_id']; ?>_<?php echo $code; ?>_mollie_component_css_valid[color]" id="input-color-valid" class="form-control" value="<?php echo $store[$code . '_mollie_component_css_valid']['color']; ?>">
													</div>
												</div>
												<div class="form-group">
													<label class="col-sm-6 control-label" for="input-font-size-valid"><?php echo $text_font_size; ?></label>
													<div class="col-sm-6">
														<input type="text" name="<?php echo $store['store_id']; ?>_<?php echo $code; ?>_mollie_component_css_valid[font_size]" id="input-font-size-valid" class="form-control" value="<?php echo $store[$code . '_mollie_component_css_valid']['font_size']; ?>">
													</div>
												</div>
												<div class="form-group">
													<label class="col-sm-6 control-label" for="input-other-css"><?php echo $text_other_css; ?></label>
													<div class="col-sm-6">
														<textarea name="<?php echo $store['store_id']; ?>_<?php echo $code; ?>_mollie_component_css_valid[other_css]" id="input-other-css" class="form-control"><?php echo $store[$code . '_mollie_component_css_valid']['other_css']; ?></textarea>
													</div>
												</div>
											</div>
											<div class="col-sm-4">
												<div class="col-sm-12 text-center form-group"><h4><?php echo $entry_mollie_component_invalid; ?></h4></div>
												<div class="form-group">
													<label class="col-sm-6 control-label" for="input-bg-color-invalid"><?php echo $text_bg_color; ?></label>
													<div class="col-sm-6">
														<input type="text" name="<?php echo $store['store_id']; ?>_<?php echo $code; ?>_mollie_component_css_invalid[background_color]" id="input-bg-color-invalid" class="form-control" value="<?php echo $store[$code . '_mollie_component_css_invalid']['background_color']; ?>">
													</div>
												</div>
												<div class="form-group">
													<label class="col-sm-6 control-label" for="input-color-invalid"><?php echo $text_color; ?></label>
													<div class="col-sm-6">
														<input type="text" name="<?php echo $store['store_id']; ?>_<?php echo $code; ?>_mollie_component_css_invalid[color]" id="input-color-invalid" class="form-control" value="<?php echo $store[$code . '_mollie_component_css_invalid']['color']; ?>">
													</div>
												</div>
												<div class="form-group">
													<label class="col-sm-6 control-label" for="input-font-size-invalid"><?php echo $text_font_size; ?></label>
													<div class="col-sm-6">
														<input type="text" name="<?php echo $store['store_id']; ?>_<?php echo $code; ?>_mollie_component_css_invalid[font_size]" id="input-font-size-invalid" class="form-control" value="<?php echo $store[$code . '_mollie_component_css_invalid']['font_size']; ?>">
													</div>
												</div>
												<div class="form-group">
													<label class="col-sm-6 control-label" for="input-other-css"><?php echo $text_other_css; ?></label>
													<div class="col-sm-6">
														<textarea name="<?php echo $store['store_id']; ?>_<?php echo $code; ?>_mollie_component_css_invalid[other_css]" id="input-other-css" class="form-control"><?php echo $store[$code . '_mollie_component_css_invalid']['other_css']; ?></textarea>
													</div>
												</div>
											</div>
										</div>	
									</fieldset>
								</div>

								<div id="mollie-mail-<?php echo $store['store_id']; ?>" class="tab-pane fade in">
								   <ul class="nav nav-tabs" id="language<?php echo $store['store_id']; ?>">
					                <?php foreach ($languages as $language) { ?>
					                <li><a href="#language<?php echo $store['store_id']; ?><?php echo $language['language_id']; ?>" data-toggle="tab"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>
					                <?php } ?>
					              </ul>
					              <div class="tab-content">
					                <?php foreach ($languages as $language) { ?>
					                <div class="tab-pane" id="language<?php echo $store['store_id']; ?><?php echo $language['language_id']; ?>">
					                  <div class="form-group">
					                    <label class="col-sm-2 control-label" for="input-subject<?php echo $store['store_id']; ?><?php echo $language['language_id']; ?>"><?php echo $entry_email_subject; ?></label>
					                    <div class="col-sm-10">
					                      <input type="text" name="<?php echo $store['store_id']; ?>_<?php echo $code; ?>_recurring_email[<?php echo $language['language_id']; ?>][subject]" value="<?php echo isset($store[$code . '_recurring_email'][$language['language_id']]) ? $store[$code . '_recurring_email'][$language['language_id']]['subject'] : ''; ?>" placeholder="<?php echo $entry_email_subject; ?>" id="input-subject<?php echo $store['store_id']; ?><?php echo $language['language_id']; ?>" class="form-control" />
					                    </div>
					                  </div>
					                  <div class="form-group">
					                    <label class="col-sm-2 control-label" for="input-body<?php echo $store['store_id']; ?><?php echo $language['language_id']; ?>"><?php echo $entry_email_body; ?></label>
					                    <div class="col-sm-10">
					                      <textarea name="<?php echo $store['store_id']; ?>_<?php echo $code; ?>_recurring_email[<?php echo $language['language_id']; ?>][body]" placeholder="<?php echo $entry_email_body; ?>" id="input-body<?php echo $store['store_id']; ?><?php echo $language['language_id']; ?>" data-toggle="summernote" class="form-control summernote"><?php echo isset($store[$code . '_recurring_email'][$language['language_id']]) ? $store[$code . '_recurring_email'][$language['language_id']]['body'] : ''; ?></textarea>
					                      <small><?php echo $text_allowed_variables; ?></small>
					                    </div>
					                  </div>	
					                </div>
					                <?php } ?>
					              </div>
								</div>

								<div id="support-<?php echo $store['store_id']; ?>" class="tab-pane fade in">
									<div class="form-group">
										<label class="col-sm-2 control-label"><?php echo $entry_comm_status; ?></label>
										<div class="col-sm-10">
											<p class="form-control-static" data-communication-status><?php echo $store['entry_cstatus']; ?></p>
										</div>
									</div>
									<fieldset>
										<legend><?php echo $text_module_by; ?></legend>
										<div class="row">
											<label class="col-sm-2 control-label">Quality Works B.V.</label>
											<div class="col-sm-10">Tel: +31(0)85 7430150<br>E-mail: <a href="mailto:support.mollie@qualityworks.eu">support.mollie@qualityworks.eu</a><br>Internet: <a href="https://www.qualityworks.eu" target="_blank">www.qualityworks.eu</a>
											</div>
										</div>										
									</fieldset>
									<fieldset>
										<legend><?php echo $text_mollie_support; ?></legend>
										<div class="form-group">
											<label class="col-sm-2 control-label">Mollie B.V.</label>
											<div class="col-sm-10">
												<p class="form-control-static"><a href="https://www.mollie.com/contact" target="_blank"><?php echo $text_contact; ?></a></p>
											</div>
										</div>									
										<div class="form-group">
											<label class="col-sm-2 control-label" for="input-debug-mode"><?php echo $entry_debug_mode; ?></label>
											<div class="col-sm-10">
												<select name="<?php echo $store['store_id']; ?>_<?php echo $code; ?>_debug_mode" id="input-debug-mode" class="form-control">
													<?php if ($store[$code . '_debug_mode']) { ?>
													<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
													<option value="0"><?php echo $text_disabled; ?></option>
													<?php } else { ?>
													<option value="1"><?php echo $text_enabled; ?></option>
													<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
													<?php } ?>
												</select>
											</div>
										</div>
										<div class="form-group">
											<div class="col-sm-2">&nbsp;</div>
											<div class="col-sm-10">
												<div class="panel-heading">
													<h3 class="panel-title"><i class="fa fa-exclamation-triangle"></i> <?php echo $text_log_list; ?></h3>

												<div class="pull-right" style="position: relative;bottom: 8px;">
													<a href="<?php echo $download; ?>" data-toggle="tooltip" title="<?php echo $button_download; ?>" class="btn btn-primary"><i class="fa fa-download"></i></a>
													<a onclick="confirm('<?php echo $text_confirm; ?>') ? location.href='<?php echo $clear; ?>' : false;" data-toggle="tooltip" title="<?php echo $button_clear; ?>" class="btn btn-danger"><i class="fa fa-eraser"></i></a>
												  </div>
												</div>
												<div class="panel-body">
												    <textarea wrap="off" rows="15" readonly class="form-control"><?php echo $log; ?></textarea>
												</div>
											</div>
										</div>
									</fieldset>
									<fieldset>
										<legend><?php echo $text_contact_us; ?></legend>
											<div id="contact-<?php echo $store['store_id']; ?>"></div>
											<div class="form-group required">
												<label class="col-sm-2 control-label"><?php echo $entry_name; ?></label>
												<div class="col-sm-10">
													<input type="text" name="name" value="" placeholder="<?php echo $entry_name; ?>" id="name" class="form-control"/>
												</div>
											</div>
											<div class="form-group required">
												<label class="col-sm-2 control-label"><?php echo $entry_email; ?></label>
												<div class="col-sm-10">
													<input type="text" name="email" value="<?php echo $store_email; ?>" placeholder="<?php echo $entry_email; ?>" id="email" class="form-control"/>
												</div>
											</div>
											<div class="form-group required">
												<label class="col-sm-2 control-label"><?php echo $entry_subject; ?></label>
												<div class="col-sm-10">
													<input type="text" name="subject" value="" placeholder="<?php echo $entry_subject; ?>" id="subject" class="form-control"/>
												</div>
											</div>											
											<div class="form-group required">
												<label class="col-sm-2 control-label"><?php echo $entry_enquiry; ?></label>
												<div class="col-sm-10">
													<textarea name="enquiry" placeholder="<?php echo $text_enquiry; ?>" id="enquiry" class="form-control"></textarea>
												</div>
											</div>
											<button type="button" id="button-support" onclick="sendMessage(<?php echo $store['store_id']; ?>)" class="btn btn-primary pull-right"><?php echo $button_submit; ?></button>
									</fieldset>
								</div>
							</div>
						</div>
						<?php } ?>
					</div>
				</div>
			</div>
			<input type="hidden" name="0_<?php echo $code; ?>_version" value="<?php echo $mollie_version; ?>">
			<input type="hidden" name="0_<?php echo $code; ?>_mod_file" value="<?php echo $mod_file; ?>">
		</form>
	</div>
</div>
<?php echo $footer; ?>

<script type="text/javascript" src="view/javascript/summernote/summernote.js"></script>
<link href="view/javascript/summernote/summernote.css" rel="stylesheet"/>
<script type="text/javascript" src="view/javascript/summernote/summernote-image-attributes.js"></script>
<script type="text/javascript" src="view/javascript/summernote/opencart.js"></script>

<script type="text/javascript">
	function sendMessage(store_id = 0) {
		var data = {
            'name':  $("#support-" + store_id + " input[name=\"name\"]").val(),
            'email':  $("#support-" + store_id + " input[name=\"email\"]").val(),
            'subject': $("#support-" + store_id + " input[name=\"subject\"]").val(),
            'enquiry': $("#support-" + store_id + " textarea[name=\"enquiry\"]").val()
        };

		$.ajax({
		  type: "POST",
		  url: 'index.php?route=payment/mollie_<?php echo $module_name; ?>/sendMessage&<?php echo $token; ?>',
		  data: data,
		  beforeSend: function() {
				$('#button-support').button('loading');
			},
			complete: function() {
				$('#button-support').button('reset');
			},
		  success: function(json) {
		  	$('.alert-success, .alert-danger').remove();

			if (json['error']) {
				$('#contact-' + store_id).after('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + '</div>');
			}

			if (json['success']) {
				$('#contact-' + store_id).after('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + '</div>');

				$('input[name=\'subject\']').val('');
				$('textarea[name=\'enquiry\']').val('');
			}
		  }
		});
	}

	(function () {
		var timeout, xhr;
		var api_check_url = $('<div/>').html('<?php echo $api_check_url; ?>').text();

		function checkIfAPIKeyIsValid(key) {
			if (xhr) xhr.abort();

			xhr = $.get(api_check_url + '&key=' + key);

			return xhr;
		}

		function validateAPIKey(value, $icon_container, store_id) {
			if (value === '') {
				updateIcon($icon_container, 'fa-minus', null, true);
				return;
			}

			clearTimeout(timeout);
			timeout = setTimeout(function () {
				updateIcon($icon_container, 'fa-spinner fa-spin', null);

				checkIfAPIKeyIsValid(value).then(function (response) {
					if (response.valid) {
						updateIcon($icon_container, 'fa-check');
						saveAPIKey(value, store_id);
					} else if (response.invalid) {
						updateIcon($icon_container, 'fa-times', response.message);
					} else if (response.error) {
						updateIcon($icon_container, 'fa-exclamation-triangle', response.message);
					}
				});
			}, 400);
		}

		function saveAPIKey(key, store_id) {
			var data = {
                'api_key': key,
                'store_id': store_id
            };
			$.ajax({
			  type: "POST",
			  url: 'index.php?route=payment/mollie_<?php echo $module_name; ?>/saveAPIKey&<?php echo $token; ?>',
			  data: data,
			  success: function() {
			  	window.location.reload();
			  }
			});
		}

		function updateIcon($container, className, message, dontClearErrors) {
			var colorClass = '';
			var classPerIcon = {
				'fa-check': 'text-success',
				'fa-times': 'text-danger',
				'fa-exclamation-triangle': 'text-danger'
			};

			if (classPerIcon[className]) {
				colorClass += ' ' + classPerIcon[className];
			}

			var icon = '<i class="fa ' + className + colorClass + '"></i>';

			$container.html(icon);
			$container.popover('destroy');

			if (message) {
				$container.popover({
					content: '<span class="' + colorClass + '">' + message + '</span>',
					html: true,
					placement: 'top',
					trigger: 'hover manual'
				});

				if ($container.is(':visible')) {
					$container.popover('show');
				}
			}

			if (!message && -1 !== className.indexOf('spinner')) {
				message = icon;
			}

			if (!dontClearErrors && $container.closest('.form-group').hasClass('has-error')) {
				$container.parent().next().remove();
				$container.closest('.form-group').removeClass('has-error');
			}

			$container.closest('.tab-content').find('[data-communication-status]').html('<span class="' + colorClass + '">' + (message || 'OK') + '</span>');
		}

		<?php foreach ($stores as $store) { ?>

			$('[<?php echo $store["store_id"] ?>-data-payment-mollie-api-key]').on('keyup', function () {
				validateAPIKey(this.value, $(this).siblings('.input-group-addon'), $(this).attr('store'));
			});

			var elem = document.getElementById('<?php echo $store["store_id"] ?>-create-shipment');
			var hiddenDiv = document.getElementById('<?php echo $store["store_id"] ?>-create-shipment-status');
			if(elem.value == 2) {
				hiddenDiv.style.display = "block";
			} else {
				hiddenDiv.style.display = "none";
			}
			
			elem.onchange = function(){
				var hiddenDiv = document.getElementById('<?php echo $store["store_id"] ?>-create-shipment-status');

			    if(this.value == 2) {
					hiddenDiv.style.display = "block";
				} else {
					hiddenDiv.style.display = "none";
				}
			};

			// Hide/Show Align Icons Option
			var elem2 = document.getElementById('<?php echo $store["store_id"] ?>-show-icons');
			var hiddenDiv2 = document.getElementById('<?php echo $store["store_id"] ?>-align-icons');
			if(elem2.value == 1) {
				hiddenDiv2.style.display = "block";
			} else {
				hiddenDiv2.style.display = "none";
			}
			
			elem2.onchange = function(){
				var hiddenDiv2 = document.getElementById('<?php echo $store["store_id"] ?>-align-icons');

			    if(this.value == 1) {
					hiddenDiv2.style.display = "block";
				} else {
					hiddenDiv2.style.display = "none";
				}
			};
			
			$('.settings').click(function(){
		      $('#tabs<?php echo $store["store_id"] ?> a[href=#mollie-options-<?php echo $store["store_id"] ?>]').tab('show');
		    });

		    $('[<?php echo $store["store_id"] ?>-data-payment-mollie-client-id], [<?php echo $store["store_id"] ?>-data-payment-mollie-client-secret]').on('keyup', function() {

		    	var client_id = $('[<?php echo $store["store_id"] ?>-data-payment-mollie-client-id]').val();
			    var client_secret = $('[<?php echo $store["store_id"] ?>-data-payment-mollie-client-secret]').val();

			    if((client_id == '') || (client_secret == '')) {
			    	$("#<?php echo $store["store_id"] ?>_button_mollie_connect").css({ "opacity" : "0.6", "pointer-events" : "none" });
			    } else {
			    	if($("#<?php echo $store["store_id"] ?>_button_mollie_connect").attr('mollie-connection') == '1') {
			    		$("#<?php echo $store["store_id"] ?>_button_mollie_connect").css({ "opacity" : "0.6", "pointer-events" : "none" });
			    	} else {
			    		$("#<?php echo $store["store_id"] ?>_button_mollie_connect").css({ "opacity" : "1", "pointer-events" : "unset" });
			    	}			    	

			    	saveAppData(client_id, client_secret, '<?php echo $store["store_id"] ?>');
			    }
		    });

		    $('[<?php echo $store["store_id"] ?>-data-payment-mollie-order-expiry-days]').on('keyup', function() {
		    	$('.error-expiry-days').remove();
		    	var expiry_days = $('[<?php echo $store["store_id"] ?>-data-payment-mollie-order-expiry-days]').val();
		    	if ((expiry_days != '') && (expiry_days > 28)) {
		    		$('[<?php echo $store["store_id"] ?>-data-payment-mollie-order-expiry-days]').after('<div class="error-expiry-days" style="color: #e3503e;"><?php echo $error_order_expiry_days; ?></div>');
		    	}
		    });
		    $('[<?php echo $store["store_id"] ?>-data-payment-mollie-order-expiry-days]').trigger('keyup');

		    $('#language<?php echo $store["store_id"] ?> a:first').tab('show');

		<?php } ?>

		function saveAppData(client_id, client_secret, store_id) {
			var data = {
                'client_id': client_id,
                'client_secret': client_secret,
                'store_id': store_id
            };
			$.ajax({
			  type: "POST",
			  url: 'index.php?route=payment/mollie_<?php echo $module_name; ?>/saveAppData&<?php echo $token; ?>',
			  data: data,
			  dataType: 'json',
			  success: function(json) {
			  	if(json != '') {
			  		$("#" + store_id + "_button_mollie_connect").attr('href', json['connect_url']);
			  	}			  	
			  }
			});
		}

	})();

// Hide API Key
$(document).ready(function () {
<?php foreach ($stores as $store) { ?>
	var apiKey = $('[<?php echo $store["store_id"] ?>-data-payment-mollie-api-key]').val();
	if(apiKey != '') {
		var prefix = apiKey.substr(0, 5);
		$('[<?php echo $store["store_id"] ?>-data-payment-mollie-api-key]').hide();
		$('[<?php echo $store["store_id"] ?>-data-payment-mollie-api-key-hide]').val(prefix + '******************************');

		const toggleAPIKey = document.querySelector('.toggleAPIKey<?php echo $store['store_id']; ?>');

		toggleAPIKey.addEventListener('click', function (e) {
			var elem1 = $('[<?php echo $store["store_id"] ?>-data-payment-mollie-api-key-hide]');
			var elem2 = $('[<?php echo $store["store_id"] ?>-data-payment-mollie-api-key]');
			elem1.is(":visible") ? elem1.hide() : elem1.show();
			elem2.is(":hidden") ? elem2.show() : elem2.hide();

			$(this).children('i').toggleClass('fa-eye-slash');	
		});
	} else {
		$('[<?php echo $store["store_id"] ?>-data-payment-mollie-api-key-hide]').hide();
	}
<?php } ?>
});
</script>