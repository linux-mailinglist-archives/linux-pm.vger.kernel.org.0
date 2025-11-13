Return-Path: <linux-pm+bounces-37939-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2E5C570E1
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 11:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 82AB64EC105
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 10:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3C1332EDE;
	Thu, 13 Nov 2025 10:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a1qD2+4I"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A4C2D0C9D;
	Thu, 13 Nov 2025 10:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763031248; cv=none; b=Zu3fNxJlA7HROFjuE3T538br1hhW3faimgb/RP5yR5dTUCDEmW6mPRMf8bQQoBdCQY7N+S99Jy1OzutoU3WX6iRfSYzj1yCT7tkD3qTavpuY9EWDrL6T2lwaq5POoAxKDsgwVDQBRCzlNp+AA/rGdew1GJEuAQvnAkCCZxQ5UDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763031248; c=relaxed/simple;
	bh=PzK14SvG7N/t66+P3sz5TYl1/qlVz0bnYMNysBsqTV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rc+WGUglMLsAB3YWMKn/d6L33lXlJTWpUu0LvPVKzvdPnHRYDtsfdXOzITI4OipzxbAgPducf/lSqShhqnvBl+oTy2JBaruzjrDt97t8NzCnkbsT7yHS1wl/f6l5D2y/EIYltGsyZG1ExGSK/xEBg3hHfoimU4pfsYe361WE/CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a1qD2+4I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4D31C4CEF5;
	Thu, 13 Nov 2025 10:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763031248;
	bh=PzK14SvG7N/t66+P3sz5TYl1/qlVz0bnYMNysBsqTV8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a1qD2+4Irtx6W/aPKdFqvS8/3/SJ6qlAl1SJ0jec+w7AlC6/1CW3Yv69flnDE/zzG
	 iJvTMwlK2F4Y2gGolPysWl/r/U5WHPKaXKZnCTeFb+bMmnWf0oPJ4xbwWYr0SR0kZH
	 s1S3PEGxwnwec24hJpUS13rCkDriCadgqUw1d0d0AEhHbfjJlP1Scv2GiHp1BWPdPg
	 oB+j5fhLn7w7235xqbwhVQgOwgVkoiNlFcz3DOe4JZssgmbCPcVTnZKoVbEKhlExRG
	 uoZdxTzjHQM1G5gxnmhUiQmaJQdEAVu833Dz4kMDOHRE/SMfnhgzsFA1x5ONaagS2z
	 h1c0gT047BYEw==
Date: Thu, 13 Nov 2025 11:54:04 +0100
From: Benjamin Tissoires <bentiss@kernel.org>
To: Lucas Zampieri <lzampier@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jiri Kosina <jikos@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
	Bastien Nocera <hadess@hadess.net>, linux-pm@vger.kernel.org
Subject: Re: [RFC PATCH v2 2/3] HID: input: Refactor battery code to use
 struct hid_battery
Message-ID: <jil4fvsfddgdj46yjy5rzw7zg6xlb2u2pgzlpkn2bte6du2ht6@5plrpdaf4u7w>
References: <20251113001508.713574-1-lzampier@redhat.com>
 <20251113001508.713574-3-lzampier@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113001508.713574-3-lzampier@redhat.com>

On Nov 13 2025, Lucas Zampieri wrote:
> Refactor the battery handling code to use the newly introduced
> struct hid_battery internally, replacing direct access to individual
> power_supply and state fields.
> 
> The legacy dev->battery and dev->battery_* fields are maintained and
> synchronized for backward compatibility. This refactoring prepares
> the code for supporting multiple batteries per device in a subsequent
> patch.
> 
> Signed-off-by: Lucas Zampieri <lzampier@redhat.com>
> ---
>  drivers/hid/hid-input.c | 125 ++++++++++++++++++++++++++--------------
>  1 file changed, 83 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index e56e7de53279..0e71efea9da3 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -454,7 +454,8 @@ static int hidinput_get_battery_property(struct power_supply *psy,
>  					 enum power_supply_property prop,
>  					 union power_supply_propval *val)
>  {
> -	struct hid_device *dev = power_supply_get_drvdata(psy);
> +	struct hid_battery *bat = power_supply_get_drvdata(psy);
> +	struct hid_device *dev = bat->dev;
>  	int value;
>  	int ret = 0;
> 
> @@ -465,13 +466,13 @@ static int hidinput_get_battery_property(struct power_supply *psy,
>  		break;
> 
>  	case POWER_SUPPLY_PROP_CAPACITY:
> -		if (dev->battery_status != HID_BATTERY_REPORTED &&
> -		    !dev->battery_avoid_query) {
> +		if (bat->status != HID_BATTERY_REPORTED &&
> +		    !bat->avoid_query) {
>  			value = hidinput_query_battery_capacity(dev);
>  			if (value < 0)
>  				return value;
>  		} else  {
> -			value = dev->battery_capacity;
> +			value = bat->capacity;
>  		}
> 
>  		val->intval = value;
> @@ -482,20 +483,20 @@ static int hidinput_get_battery_property(struct power_supply *psy,
>  		break;
> 
>  	case POWER_SUPPLY_PROP_STATUS:
> -		if (dev->battery_status != HID_BATTERY_REPORTED &&
> -		    !dev->battery_avoid_query) {
> +		if (bat->status != HID_BATTERY_REPORTED &&
> +		    !bat->avoid_query) {
>  			value = hidinput_query_battery_capacity(dev);
>  			if (value < 0)
>  				return value;
> 
> -			dev->battery_capacity = value;
> -			dev->battery_status = HID_BATTERY_QUERIED;
> +			bat->capacity = value;
> +			bat->status = HID_BATTERY_QUERIED;
>  		}
> 
> -		if (dev->battery_status == HID_BATTERY_UNKNOWN)
> +		if (bat->status == HID_BATTERY_UNKNOWN)
>  			val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
>  		else
> -			val->intval = dev->battery_charge_status;
> +			val->intval = bat->charge_status;
>  		break;
> 
>  	case POWER_SUPPLY_PROP_SCOPE:
> @@ -513,8 +514,9 @@ static int hidinput_get_battery_property(struct power_supply *psy,
>  static int hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
>  				  struct hid_field *field, bool is_percentage)
>  {
> +	struct hid_battery *bat;
>  	struct power_supply_desc *psy_desc;
> -	struct power_supply_config psy_cfg = { .drv_data = dev, };
> +	struct power_supply_config psy_cfg;
>  	unsigned quirks;
>  	s32 min, max;
>  	int error;
> @@ -530,16 +532,22 @@ static int hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
>  	if (quirks & HID_BATTERY_QUIRK_IGNORE)
>  		return 0;
> 
> -	psy_desc = kzalloc(sizeof(*psy_desc), GFP_KERNEL);
> -	if (!psy_desc)
> +	bat = kzalloc(sizeof(*bat), GFP_KERNEL);
> +	if (!bat)
>  		return -ENOMEM;
> 
> +	psy_desc = kzalloc(sizeof(*psy_desc), GFP_KERNEL);
> +	if (!psy_desc) {
> +		error = -ENOMEM;
> +		goto err_free_bat;
> +	}
> +
>  	psy_desc->name = kasprintf(GFP_KERNEL, "hid-%s-battery",
>  				   strlen(dev->uniq) ?
>  					dev->uniq : dev_name(&dev->dev));
>  	if (!psy_desc->name) {
>  		error = -ENOMEM;
> -		goto err_free_mem;
> +		goto err_free_desc;

I wonder if a devm conversion of the whole battery support handling
would not be beneficial here.

>  	}
> 
>  	psy_desc->type = POWER_SUPPLY_TYPE_BATTERY;
> @@ -559,63 +567,85 @@ static int hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
>  	if (quirks & HID_BATTERY_QUIRK_FEATURE)
>  		report_type = HID_FEATURE_REPORT;
> 
> -	dev->battery_min = min;
> -	dev->battery_max = max;
> -	dev->battery_report_type = report_type;
> -	dev->battery_report_id = field->report->id;
> -	dev->battery_charge_status = POWER_SUPPLY_STATUS_DISCHARGING;
> +	/* Initialize battery structure */
> +	bat->dev = dev;
> +	bat->min = min;
> +	bat->max = max;
> +	bat->report_type = report_type;
> +	bat->report_id = field->report->id;
> +	bat->charge_status = POWER_SUPPLY_STATUS_DISCHARGING;
> +	bat->status = HID_BATTERY_UNKNOWN;
> 
>  	/*
>  	 * Stylus is normally not connected to the device and thus we
>  	 * can't query the device and get meaningful battery strength.
>  	 * We have to wait for the device to report it on its own.
>  	 */
> -	dev->battery_avoid_query = report_type == HID_INPUT_REPORT &&
> -				   field->physical == HID_DG_STYLUS;
> +	bat->avoid_query = report_type == HID_INPUT_REPORT &&
> +			   field->physical == HID_DG_STYLUS;
> 
>  	if (quirks & HID_BATTERY_QUIRK_AVOID_QUERY)
> -		dev->battery_avoid_query = true;
> +		bat->avoid_query = true;
> 
> -	dev->battery = power_supply_register(&dev->dev, psy_desc, &psy_cfg);
> -	if (IS_ERR(dev->battery)) {
> -		error = PTR_ERR(dev->battery);
> +	psy_cfg.drv_data = bat;
> +	bat->ps = power_supply_register(&dev->dev, psy_desc, &psy_cfg);
> +	if (IS_ERR(bat->ps)) {
> +		error = PTR_ERR(bat->ps);
>  		hid_warn(dev, "can't register power supply: %d\n", error);
>  		goto err_free_name;
>  	}
> 
> -	power_supply_powers(dev->battery, &dev->dev);
> +	power_supply_powers(bat->ps, &dev->dev);
> +
> +	/* Maintain legacy single battery fields for backward compatibility */
> +	dev->battery = bat->ps;
> +	dev->battery_min = bat->min;
> +	dev->battery_max = bat->max;
> +	dev->battery_report_type = bat->report_type;
> +	dev->battery_report_id = bat->report_id;
> +	dev->battery_charge_status = bat->charge_status;
> +	dev->battery_status = bat->status;
> +	dev->battery_avoid_query = bat->avoid_query;

Already mentioned in the cover letter, but what's the point of keeping
those legacy fields when the exact same data is stored in bat?

> +
>  	return 0;
> 
>  err_free_name:
>  	kfree(psy_desc->name);
> -err_free_mem:
> +err_free_desc:
>  	kfree(psy_desc);
> -	dev->battery = NULL;
> +err_free_bat:
> +	kfree(bat);
>  	return error;
>  }
> 
>  static void hidinput_cleanup_battery(struct hid_device *dev)
>  {
> +	struct hid_battery *bat;
>  	const struct power_supply_desc *psy_desc;
> 
>  	if (!dev->battery)
>  		return;
> 
> +	bat = power_supply_get_drvdata(dev->battery);
>  	psy_desc = dev->battery->desc;
>  	power_supply_unregister(dev->battery);
>  	kfree(psy_desc->name);
>  	kfree(psy_desc);
> +	kfree(bat);
>  	dev->battery = NULL;
>  }
> 
> -static bool hidinput_update_battery_charge_status(struct hid_device *dev,
> +static bool hidinput_update_battery_charge_status(struct hid_battery *bat,
>  						  unsigned int usage, int value)
>  {
>  	switch (usage) {
>  	case HID_BAT_CHARGING:
> -		dev->battery_charge_status = value ?
> -					     POWER_SUPPLY_STATUS_CHARGING :
> -					     POWER_SUPPLY_STATUS_DISCHARGING;
> +		bat->charge_status = value ?
> +				     POWER_SUPPLY_STATUS_CHARGING :
> +				     POWER_SUPPLY_STATUS_DISCHARGING;
> +		/* Update legacy field for backward compatibility */
> +		if (bat->dev->battery == bat->ps)
> +			bat->dev->battery_charge_status = bat->charge_status;
>  		return true;
>  	}
> 
> @@ -625,32 +655,43 @@ static bool hidinput_update_battery_charge_status(struct hid_device *dev,
>  static void hidinput_update_battery(struct hid_device *dev, unsigned int usage,
>  				    int value)
>  {
> +	struct hid_battery *bat;
>  	int capacity;
> 
>  	if (!dev->battery)
>  		return;
> 
> -	if (hidinput_update_battery_charge_status(dev, usage, value)) {
> -		power_supply_changed(dev->battery);
> +	bat = power_supply_get_drvdata(dev->battery);
> +
> +	if (hidinput_update_battery_charge_status(bat, usage, value)) {
> +		power_supply_changed(bat->ps);
>  		return;
>  	}
> 
>  	if ((usage & HID_USAGE_PAGE) == HID_UP_DIGITIZER && value == 0)
>  		return;
> 
> -	if (value < dev->battery_min || value > dev->battery_max)
> +	if (value < bat->min || value > bat->max)
>  		return;
> 
>  	capacity = hidinput_scale_battery_capacity(dev, value);
> 
> -	if (dev->battery_status != HID_BATTERY_REPORTED ||
> -	    capacity != dev->battery_capacity ||
> -	    ktime_after(ktime_get_coarse(), dev->battery_ratelimit_time)) {
> -		dev->battery_capacity = capacity;
> -		dev->battery_status = HID_BATTERY_REPORTED;
> -		dev->battery_ratelimit_time =
> +	if (bat->status != HID_BATTERY_REPORTED ||
> +	    capacity != bat->capacity ||
> +	    ktime_after(ktime_get_coarse(), bat->ratelimit_time)) {
> +		bat->capacity = capacity;
> +		bat->status = HID_BATTERY_REPORTED;
> +		bat->ratelimit_time =
>  			ktime_add_ms(ktime_get_coarse(), 30 * 1000);
> -		power_supply_changed(dev->battery);
> +
> +		/* Update legacy fields for backward compatibility */
> +		if (dev->battery == bat->ps) {
> +			dev->battery_capacity = bat->capacity;
> +			dev->battery_status = bat->status;
> +			dev->battery_ratelimit_time = bat->ratelimit_time;
> +		}
> +
> +		power_supply_changed(bat->ps);
>  	}
>  }
>  #else  /* !CONFIG_HID_BATTERY_STRENGTH */
> --
> 2.51.1
> 

Cheers,
Benjamin

