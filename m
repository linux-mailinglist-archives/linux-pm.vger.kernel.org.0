Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69AD4C4B4C
	for <lists+linux-pm@lfdr.de>; Fri, 25 Feb 2022 17:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236481AbiBYQso (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Feb 2022 11:48:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240024AbiBYQsn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Feb 2022 11:48:43 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E39C2E6BA
        for <linux-pm@vger.kernel.org>; Fri, 25 Feb 2022 08:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645807691; x=1677343691;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ca00zM2O3NNBpixD0iPrQ3hrP/kkycPnFHmV3BYz8zA=;
  b=Ycy8M2NCztqF30msrgsEzPfNFYgDM7EliLK4XjEz+LdALjcAmnOapM5a
   nyE4/NeNvJTN52ADkd88nQjN34k1Ky0xc+3vcDuk8aAduAnmjlbhhWGfF
   cx3S9Y+2xgYD2wI8AUUv10tm32HSlF0Zf6KlFUGzsrdUf8PjaKI5XrAIw
   NC8xslygsrFltwTXiHTT7Nk+bwLPbPrMHV/eNb4ghUVpCmQobd4Di8sG/
   LAI4p10EPkrzFSg8Fv/xtp2QnRX1tSTxt9F/kIHuNDTgy3gcCp1zNnUTh
   W2i1mroRFtkiByErALsvf9HPRZnG5f7xIydFJZ/1zBnYO+5TZK9atB73O
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="239934410"
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="239934410"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 08:48:10 -0800
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="574649576"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 08:48:09 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nNdkW-008Gi4-5u;
        Fri, 25 Feb 2022 18:47:20 +0200
Date:   Fri, 25 Feb 2022 18:47:19 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH 2/2] power: supply: bq24190_charger: Delay applying
 charge_type changes when OTG 5V Vbus boost is on
Message-ID: <YhkIF7vrwk3sVm5y@smile.fi.intel.com>
References: <20220212164817.204323-1-hdegoede@redhat.com>
 <20220212164817.204323-2-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220212164817.204323-2-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Feb 12, 2022 at 05:48:17PM +0100, Hans de Goede wrote:
> Recently userspace has started switching power_supply class devices with
> a charge_type psy-property between fast and trickle charge mode, see:
> https://gitlab.freedesktop.org/hadess/power-profiles-daemon/-/issues/85
> 
> Before this patch bq24190_charger_set_charge_type() would unconditionally
> write charging or none to the BQ24190_REG_POC_CHG_CONFIG bits, replacing
> the otg setting of those bits when the OTG 5V Vbus boost converter was on,
> turning the 5V Vbus off, removing the power from any attached peripherals.
> 
> This fixes this by keeping track of otg_vbus_enabled and the requested
> charger_type settings and when otg_vbus_enabled is true, delay applying
> the charger_type until the 5V boost converter is turned off.

Both of them looks good to me, FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Cc: Bastien Nocera <hadess@hadess.net>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/power/supply/bq24190_charger.c | 41 +++++++++++++++++++-------
>  1 file changed, 30 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
> index dcbfd97a55be..aa1a589eb9f2 100644
> --- a/drivers/power/supply/bq24190_charger.c
> +++ b/drivers/power/supply/bq24190_charger.c
> @@ -163,6 +163,8 @@ struct bq24190_dev_info {
>  	char				model_name[I2C_NAME_SIZE];
>  	bool				initialized;
>  	bool				irq_event;
> +	bool				otg_vbus_enabled;
> +	int				charge_type;
>  	u16				sys_min;
>  	u16				iprechg;
>  	u16				iterm;
> @@ -176,6 +178,9 @@ struct bq24190_dev_info {
>  	u8				watchdog;
>  };
>  
> +static int bq24190_charger_set_charge_type(struct bq24190_dev_info *bdi,
> +					   const union power_supply_propval *val);
> +
>  static const unsigned int bq24190_usb_extcon_cable[] = {
>  	EXTCON_USB,
>  	EXTCON_NONE,
> @@ -502,8 +507,9 @@ static ssize_t bq24190_sysfs_store(struct device *dev,
>  }
>  #endif
>  
> -static int bq24190_set_charge_mode(struct bq24190_dev_info *bdi, u8 val)
> +static int bq24190_set_otg_vbus(struct bq24190_dev_info *bdi, bool enable)
>  {
> +	union power_supply_propval val = { .intval = bdi->charge_type };
>  	int ret;
>  
>  	ret = pm_runtime_get_sync(bdi->dev);
> @@ -513,9 +519,14 @@ static int bq24190_set_charge_mode(struct bq24190_dev_info *bdi, u8 val)
>  		return ret;
>  	}
>  
> -	ret = bq24190_write_mask(bdi, BQ24190_REG_POC,
> -				 BQ24190_REG_POC_CHG_CONFIG_MASK,
> -				 BQ24190_REG_POC_CHG_CONFIG_SHIFT, val);
> +	bdi->otg_vbus_enabled = enable;
> +	if (enable)
> +		ret = bq24190_write_mask(bdi, BQ24190_REG_POC,
> +					 BQ24190_REG_POC_CHG_CONFIG_MASK,
> +					 BQ24190_REG_POC_CHG_CONFIG_SHIFT,
> +					 BQ24190_REG_POC_CHG_CONFIG_OTG);
> +	else
> +		ret = bq24190_charger_set_charge_type(bdi, &val);
>  
>  	pm_runtime_mark_last_busy(bdi->dev);
>  	pm_runtime_put_autosuspend(bdi->dev);
> @@ -526,14 +537,12 @@ static int bq24190_set_charge_mode(struct bq24190_dev_info *bdi, u8 val)
>  #ifdef CONFIG_REGULATOR
>  static int bq24190_vbus_enable(struct regulator_dev *dev)
>  {
> -	return bq24190_set_charge_mode(rdev_get_drvdata(dev),
> -				       BQ24190_REG_POC_CHG_CONFIG_OTG);
> +	return bq24190_set_otg_vbus(rdev_get_drvdata(dev), true);
>  }
>  
>  static int bq24190_vbus_disable(struct regulator_dev *dev)
>  {
> -	return bq24190_set_charge_mode(rdev_get_drvdata(dev),
> -				       BQ24190_REG_POC_CHG_CONFIG_CHARGE);
> +	return bq24190_set_otg_vbus(rdev_get_drvdata(dev), false);
>  }
>  
>  static int bq24190_vbus_is_enabled(struct regulator_dev *dev)
> @@ -559,8 +568,9 @@ static int bq24190_vbus_is_enabled(struct regulator_dev *dev)
>  	if (ret)
>  		return ret;
>  
> -	return (val == BQ24190_REG_POC_CHG_CONFIG_OTG ||
> -		val == BQ24190_REG_POC_CHG_CONFIG_OTG_ALT);
> +	bdi->otg_vbus_enabled = (val == BQ24190_REG_POC_CHG_CONFIG_OTG ||
> +				 val == BQ24190_REG_POC_CHG_CONFIG_OTG_ALT);
> +	return bdi->otg_vbus_enabled;
>  }
>  
>  static const struct regulator_ops bq24190_vbus_ops = {
> @@ -807,6 +817,14 @@ static int bq24190_charger_set_charge_type(struct bq24190_dev_info *bdi,
>  		return -EINVAL;
>  	}
>  
> +	bdi->charge_type = val->intval;
> +	/*
> +	 * If the 5V Vbus boost regulator is enabled delay setting
> +	 * the charge-type until its gets disabled.
> +	 */
> +	if (bdi->otg_vbus_enabled)
> +		return 0;
> +
>  	if (chg_config) { /* Enabling the charger */
>  		ret = bq24190_write_mask(bdi, BQ24190_REG_CCC,
>  				BQ24190_REG_CCC_FORCE_20PCT_MASK,
> @@ -1788,6 +1806,7 @@ static int bq24190_probe(struct i2c_client *client,
>  	bdi->dev = dev;
>  	strncpy(bdi->model_name, id->name, I2C_NAME_SIZE);
>  	mutex_init(&bdi->f_reg_lock);
> +	bdi->charge_type = POWER_SUPPLY_CHARGE_TYPE_FAST;
>  	bdi->f_reg = 0;
>  	bdi->ss_reg = BQ24190_REG_SS_VBUS_STAT_MASK; /* impossible state */
>  	INIT_DELAYED_WORK(&bdi->input_current_limit_work,
> @@ -1925,7 +1944,7 @@ static void bq24190_shutdown(struct i2c_client *client)
>  	struct bq24190_dev_info *bdi = i2c_get_clientdata(client);
>  
>  	/* Turn off 5V boost regulator on shutdown */
> -	bq24190_set_charge_mode(bdi, BQ24190_REG_POC_CHG_CONFIG_CHARGE);
> +	bq24190_set_otg_vbus(bdi, false);
>  }
>  
>  static __maybe_unused int bq24190_runtime_suspend(struct device *dev)
> -- 
> 2.33.1
> 
> 

-- 
With Best Regards,
Andy Shevchenko


