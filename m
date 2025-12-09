Return-Path: <linux-pm+bounces-39340-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E656CAFA22
	for <lists+linux-pm@lfdr.de>; Tue, 09 Dec 2025 11:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8433304B037
	for <lists+linux-pm@lfdr.de>; Tue,  9 Dec 2025 10:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A46829B22F;
	Tue,  9 Dec 2025 10:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iUjjqstY"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F196726AA93;
	Tue,  9 Dec 2025 10:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765275957; cv=none; b=iOxYqZRDOR/O95XMHStdj+yvhP2sSdtM86+HQCSKzMGyTQedNRSjKZ0fh0bA5SnPgTwD7Ru465wYUQ/MOe8yVwn5GeAbAfWWNe7psN/jyXx0SAu/j65PJjt1lEzo5SxUxa8v0LAem4ios7PObJAlQ3Uynz1mQ345AUphTaop8nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765275957; c=relaxed/simple;
	bh=Ma6ciW7Fv/SxrIFMmep8BtiQ6K6zp1+83zB38ucVrCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cBtd06f7QUTrSqmwc4ZzBPdhvAV/wY19YG01ff42MUd1A8oHlg7DCP1WtKVlAoqyTdREszrx37jp2PSoIDlarFqESRRjnSjNW1IZNvmLJP2ZO0uqf2xugI8DcnyRRvoSZkL2jrGkGt6+prbf5sIPLmJC2VhEy6ss8OsiB+SruFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iUjjqstY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3094C4CEF5;
	Tue,  9 Dec 2025 10:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765275956;
	bh=Ma6ciW7Fv/SxrIFMmep8BtiQ6K6zp1+83zB38ucVrCU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iUjjqstYAF1gbZCfS4z7c0ftamOxZ+q4deAIiyh6XAIiurBbRfceoXh6F6KHq3OxQ
	 uF+K9VpSrJJp27tZ2EZ+MDtexPUbO5faO5xA5tt6I7F8sbK2w5u/Zv6wiiBMVXiZ/8
	 p8sB97bVbCkfjsZG+cljcLLNbsRh30hbmURVA5A8pr872SPtbrDZWDK3lxj0QIdkfx
	 2kmIFph/x/Xs0b/dPRHu6tPSrVK3E4hVCl7jEwxzPApEqvqu1hIHpdCRKpfbzVotfS
	 jYV+n9WbCuioMUWiK1ZeykEDfTC9IjERE6ksi5j8WcYTud6eXJRDziUybHqtdAzBjU
	 6OZ+MKqHK6ecg==
Date: Tue, 9 Dec 2025 11:25:51 +0100
From: Benjamin Tissoires <bentiss@kernel.org>
To: Lucas Zampieri <lzampier@redhat.com>, 
	Lucas Zampieri <lcasmz54@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jiri Kosina <jikos@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
	Bastien Nocera <hadess@hadess.net>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 2/2] HID: input: Add support for multiple batteries
 per device
Message-ID: <6c4qs4rdxls73unutzzjkl5tocomhfgih7bt4pjtj5p52zdsgt@pisip2xtgvyr>
References: <20251121131556.601130-1-lzampier@redhat.com>
 <20251121131556.601130-3-lzampier@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121131556.601130-3-lzampier@redhat.com>

Hi Lucas,

On Nov 21 2025, Lucas Zampieri wrote:
> Introduce struct hid_battery to encapsulate individual battery state and
> enable HID devices to register multiple batteries, each identified by
> its report ID.

That very much looks like we need two patches here as well:
- first introduces the struct hid_battery and converts everybody to use
	it
- second, introduce multiple batteries

This allows to keep the multiple batteries changes separated so we can
validate the hid-apple.c changes by itself for instance.

Looking further at the patch it should be a matter of splitting the
hidinput_setup_battery into a separate patch and in that second patch
add the list support in the struct hid_battery.

> 
> This struct hid_battery replaces the legacy dev->battery_* fields with
> a batteries list.
> Batteries are named using their report ID with the pattern
> hid-{uniq}-battery-{report_id}. External drivers hid-apple and
> hid-magicmouse are updated to use the new battery API via the
> hid_get_first_battery() helper, and hid-input-test is updated for the
> new battery structure.
> 
> This enables proper battery reporting for devices with multiple
> batteries such as split keyboards, gaming headsets with charging docks,
> and wireless earbuds with per-earbud batteries.
> 
> Suggested-by: Benjamin Tissoires <bentiss@kernel.org>
> Signed-off-by: Lucas Zampieri <lzampier@redhat.com>
> ---
>  drivers/hid/hid-apple.c      |  10 ++-
>  drivers/hid/hid-core.c       |   4 +
>  drivers/hid/hid-input-test.c |  39 +++++----
>  drivers/hid/hid-input.c      | 163 +++++++++++++++++++++--------------
>  drivers/hid/hid-magicmouse.c |  10 ++-
>  include/linux/hid.h          |  54 +++++++++---
>  6 files changed, 178 insertions(+), 102 deletions(-)
> 
> diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
> index 61404d7a43ee..fb09b616f8cc 100644
> --- a/drivers/hid/hid-apple.c
> +++ b/drivers/hid/hid-apple.c
> @@ -618,17 +618,19 @@ static int apple_fetch_battery(struct hid_device *hdev)
>  	struct apple_sc *asc = hid_get_drvdata(hdev);
>  	struct hid_report_enum *report_enum;
>  	struct hid_report *report;
> +	struct hid_battery *bat;
> 
> -	if (!(asc->quirks & APPLE_RDESC_BATTERY) || !hdev->battery)
> +	bat = hid_get_first_battery(hdev);

Maybe hid_get_battery(hdev) and add then when multiple batteries are
supported either change the API to hid_get_battery(hdev, 0) either
introduce a new function (you already has hid_find_battery).

> +	if (!(asc->quirks & APPLE_RDESC_BATTERY) || !bat)
>  		return -1;
> 
> -	report_enum = &hdev->report_enum[hdev->battery_report_type];
> -	report = report_enum->report_id_hash[hdev->battery_report_id];
> +	report_enum = &hdev->report_enum[bat->report_type];
> +	report = report_enum->report_id_hash[bat->report_id];
> 
>  	if (!report || report->maxfield < 1)
>  		return -1;
> 
> -	if (hdev->battery_capacity == hdev->battery_max)
> +	if (bat->capacity == bat->max)
>  		return -1;
> 
>  	hid_hw_request(hdev, report, HID_REQ_GET_REPORT);
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index a5b3a8ca2fcb..76d628547e9a 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -2990,6 +2990,10 @@ struct hid_device *hid_allocate_device(void)
>  	mutex_init(&hdev->ll_open_lock);
>  	kref_init(&hdev->ref);
> 
> +#ifdef CONFIG_HID_BATTERY_STRENGTH
> +	INIT_LIST_HEAD(&hdev->batteries);
> +#endif
> +
>  	ret = hid_bpf_device_init(hdev);
>  	if (ret)
>  		goto out_err;
> diff --git a/drivers/hid/hid-input-test.c b/drivers/hid/hid-input-test.c
> index 6f5c71660d82..c92008dafddf 100644
> --- a/drivers/hid/hid-input-test.c
> +++ b/drivers/hid/hid-input-test.c
> @@ -9,54 +9,59 @@
> 
>  static void hid_test_input_update_battery_charge_status(struct kunit *test)
>  {
> -	struct hid_device *dev;
> +	struct hid_battery *bat;
>  	bool handled;
> 
> -	dev = kunit_kzalloc(test, sizeof(*dev), GFP_KERNEL);
> -	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
> +	bat = kunit_kzalloc(test, sizeof(*bat), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, bat);
> 
> -	handled = hidinput_update_battery_charge_status(dev, HID_DG_HEIGHT, 0);
> +	handled = hidinput_update_battery_charge_status(bat, HID_DG_HEIGHT, 0);
>  	KUNIT_EXPECT_FALSE(test, handled);
> -	KUNIT_EXPECT_EQ(test, dev->battery_charge_status, POWER_SUPPLY_STATUS_UNKNOWN);
> +	KUNIT_EXPECT_EQ(test, bat->charge_status, POWER_SUPPLY_STATUS_UNKNOWN);
> 
> -	handled = hidinput_update_battery_charge_status(dev, HID_BAT_CHARGING, 0);
> +	handled = hidinput_update_battery_charge_status(bat, HID_BAT_CHARGING, 0);
>  	KUNIT_EXPECT_TRUE(test, handled);
> -	KUNIT_EXPECT_EQ(test, dev->battery_charge_status, POWER_SUPPLY_STATUS_DISCHARGING);
> +	KUNIT_EXPECT_EQ(test, bat->charge_status, POWER_SUPPLY_STATUS_DISCHARGING);
> 
> -	handled = hidinput_update_battery_charge_status(dev, HID_BAT_CHARGING, 1);
> +	handled = hidinput_update_battery_charge_status(bat, HID_BAT_CHARGING, 1);
>  	KUNIT_EXPECT_TRUE(test, handled);
> -	KUNIT_EXPECT_EQ(test, dev->battery_charge_status, POWER_SUPPLY_STATUS_CHARGING);
> +	KUNIT_EXPECT_EQ(test, bat->charge_status, POWER_SUPPLY_STATUS_CHARGING);
>  }
> 
>  static void hid_test_input_get_battery_property(struct kunit *test)
>  {
>  	struct power_supply *psy;
> +	struct hid_battery *bat;
>  	struct hid_device *dev;
>  	union power_supply_propval val;
>  	int ret;
> 
>  	dev = kunit_kzalloc(test, sizeof(*dev), GFP_KERNEL);
>  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
> -	dev->battery_avoid_query = true;
> +
> +	bat = kunit_kzalloc(test, sizeof(*bat), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, bat);
> +	bat->dev = dev;
> +	bat->avoid_query = true;
> 
>  	psy = kunit_kzalloc(test, sizeof(*psy), GFP_KERNEL);
>  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, psy);
> -	psy->drv_data = dev;
> +	psy->drv_data = bat;
> 
> -	dev->battery_status = HID_BATTERY_UNKNOWN;
> -	dev->battery_charge_status = POWER_SUPPLY_STATUS_CHARGING;
> +	bat->status = HID_BATTERY_UNKNOWN;
> +	bat->charge_status = POWER_SUPPLY_STATUS_CHARGING;
>  	ret = hidinput_get_battery_property(psy, POWER_SUPPLY_PROP_STATUS, &val);
>  	KUNIT_EXPECT_EQ(test, ret, 0);
>  	KUNIT_EXPECT_EQ(test, val.intval, POWER_SUPPLY_STATUS_UNKNOWN);
> 
> -	dev->battery_status = HID_BATTERY_REPORTED;
> -	dev->battery_charge_status = POWER_SUPPLY_STATUS_CHARGING;
> +	bat->status = HID_BATTERY_REPORTED;
> +	bat->charge_status = POWER_SUPPLY_STATUS_CHARGING;
>  	ret = hidinput_get_battery_property(psy, POWER_SUPPLY_PROP_STATUS, &val);
>  	KUNIT_EXPECT_EQ(test, ret, 0);
>  	KUNIT_EXPECT_EQ(test, val.intval, POWER_SUPPLY_STATUS_CHARGING);
> 
> -	dev->battery_status = HID_BATTERY_REPORTED;
> -	dev->battery_charge_status = POWER_SUPPLY_STATUS_DISCHARGING;
> +	bat->status = HID_BATTERY_REPORTED;
> +	bat->charge_status = POWER_SUPPLY_STATUS_DISCHARGING;
>  	ret = hidinput_get_battery_property(psy, POWER_SUPPLY_PROP_STATUS, &val);
>  	KUNIT_EXPECT_EQ(test, ret, 0);
>  	KUNIT_EXPECT_EQ(test, val.intval, POWER_SUPPLY_STATUS_DISCHARGING);
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index 5f313c3c35e2..9eeaba0229d5 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -418,18 +418,18 @@ static unsigned find_battery_quirk(struct hid_device *hdev)
>  	return quirks;
>  }
> 
> -static int hidinput_scale_battery_capacity(struct hid_device *dev,
> +static int hidinput_scale_battery_capacity(struct hid_battery *bat,
>  					   int value)
>  {
> -	if (dev->battery_min < dev->battery_max &&
> -	    value >= dev->battery_min && value <= dev->battery_max)
> -		value = ((value - dev->battery_min) * 100) /
> -			(dev->battery_max - dev->battery_min);
> +	if (bat->min < bat->max &&
> +	    value >= bat->min && value <= bat->max)
> +		value = ((value - bat->min) * 100) /
> +			(bat->max - bat->min);
> 
>  	return value;
>  }
> 
> -static int hidinput_query_battery_capacity(struct hid_device *dev)
> +static int hidinput_query_battery_capacity(struct hid_battery *bat)
>  {
>  	u8 *buf;
>  	int ret;
> @@ -438,14 +438,14 @@ static int hidinput_query_battery_capacity(struct hid_device *dev)
>  	if (!buf)
>  		return -ENOMEM;
> 
> -	ret = hid_hw_raw_request(dev, dev->battery_report_id, buf, 4,
> -				 dev->battery_report_type, HID_REQ_GET_REPORT);
> +	ret = hid_hw_raw_request(bat->dev, bat->report_id, buf, 4,
> +				 bat->report_type, HID_REQ_GET_REPORT);
>  	if (ret < 2) {
>  		kfree(buf);
>  		return -ENODATA;
>  	}
> 
> -	ret = hidinput_scale_battery_capacity(dev, buf[1]);
> +	ret = hidinput_scale_battery_capacity(bat, buf[1]);
>  	kfree(buf);
>  	return ret;
>  }
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
> -			value = hidinput_query_battery_capacity(dev);
> +		if (bat->status != HID_BATTERY_REPORTED &&
> +		    !bat->avoid_query) {
> +			value = hidinput_query_battery_capacity(bat);
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
> -			value = hidinput_query_battery_capacity(dev);
> +		if (bat->status != HID_BATTERY_REPORTED &&
> +		    !bat->avoid_query) {
> +			value = hidinput_query_battery_capacity(bat);
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
> @@ -510,33 +511,52 @@ static int hidinput_get_battery_property(struct power_supply *psy,
>  	return ret;
>  }
> 
> +static struct hid_battery *hidinput_find_battery(struct hid_device *dev,
> +						 int report_id)
> +{
> +	struct hid_battery *bat;
> +
> +	list_for_each_entry(bat, &dev->batteries, list) {
> +		if (bat->report_id == report_id)
> +			return bat;
> +	}
> +	return NULL;
> +}
> +
>  static int hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
>  				  struct hid_field *field, bool is_percentage)
>  {
> +	struct hid_battery *bat;
>  	struct power_supply_desc *psy_desc;
> -	struct power_supply_config psy_cfg = { .drv_data = dev, };
> +	struct power_supply_config psy_cfg = { 0 };
>  	unsigned quirks;
>  	s32 min, max;
> -	int error;
> 
> -	if (dev->battery)
> -		return 0;	/* already initialized? */
> +	if (hidinput_find_battery(dev, field->report->id))
> +		return 0;
> 
>  	quirks = find_battery_quirk(dev);
> 
> -	hid_dbg(dev, "device %x:%x:%x %d quirks %d\n",
> -		dev->bus, dev->vendor, dev->product, dev->version, quirks);
> +	hid_dbg(dev, "device %x:%x:%x %d quirks %d report_id %d\n",
> +		dev->bus, dev->vendor, dev->product, dev->version, quirks,
> +		field->report->id);
> 
>  	if (quirks & HID_BATTERY_QUIRK_IGNORE)
>  		return 0;
> 
> +	bat = devm_kzalloc(&dev->dev, sizeof(*bat), GFP_KERNEL);
> +	if (!bat)
> +		return -ENOMEM;

Looking at the current code path (pre 1/2 in this series), we never
check for the return value of hidinput_setup_battery(), so in case
something goes wrong, we are just hammering even more for every battery
field, which is not ideal. I don't think the issue is in this patch, but
I just happened to realize it as I'm reviewing it now.

My chain of thoughts was whether we need a special devm_group for this
so we can partially clean this up in case of failure but I honestly
don't know if this is the good approach either.

I guess the -ENOMEM is not of an issue (because everything will fall
apart as well), but what if the power_supply_register fails?

Cheers,
Benjamin

> +
>  	psy_desc = devm_kzalloc(&dev->dev, sizeof(*psy_desc), GFP_KERNEL);
>  	if (!psy_desc)
>  		return -ENOMEM;
> 
> -	psy_desc->name = devm_kasprintf(&dev->dev, GFP_KERNEL, "hid-%s-battery",
> +	psy_desc->name = devm_kasprintf(&dev->dev, GFP_KERNEL,
> +					"hid-%s-battery-%d",
>  					strlen(dev->uniq) ?
> -						dev->uniq : dev_name(&dev->dev));
> +						dev->uniq : dev_name(&dev->dev),
> +					field->report->id);
>  	if (!psy_desc->name)
>  		return -ENOMEM;
> 
> @@ -557,77 +577,80 @@ static int hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
>  	if (quirks & HID_BATTERY_QUIRK_FEATURE)
>  		report_type = HID_FEATURE_REPORT;
> 
> -	dev->battery_min = min;
> -	dev->battery_max = max;
> -	dev->battery_report_type = report_type;
> -	dev->battery_report_id = field->report->id;
> -	dev->battery_charge_status = POWER_SUPPLY_STATUS_DISCHARGING;
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
> -	dev->battery = devm_power_supply_register(&dev->dev, psy_desc, &psy_cfg);
> -	if (IS_ERR(dev->battery)) {
> +	psy_cfg.drv_data = bat;
> +	bat->ps = devm_power_supply_register(&dev->dev, psy_desc, &psy_cfg);
> +	if (IS_ERR(bat->ps)) {
>  		hid_warn(dev, "can't register power supply: %ld\n",
> -			 PTR_ERR(dev->battery));
> -		return PTR_ERR(dev->battery);
> +			 PTR_ERR(bat->ps));
> +		return PTR_ERR(bat->ps);
>  	}
> 
> -	power_supply_powers(dev->battery, &dev->dev);
> +	power_supply_powers(bat->ps, &dev->dev);
> +
> +	list_add_tail(&bat->list, &dev->batteries);
> +
>  	return 0;
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
>  		return true;
>  	}
> 
>  	return false;
>  }
> 
> -static void hidinput_update_battery(struct hid_device *dev, unsigned int usage,
> -				    int value)
> +static void hidinput_update_battery(struct hid_battery *bat,
> +				    unsigned int usage, int value)
>  {
>  	int capacity;
> 
> -	if (!dev->battery)
> -		return;
> -
> -	if (hidinput_update_battery_charge_status(dev, usage, value)) {
> -		power_supply_changed(dev->battery);
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
> -	capacity = hidinput_scale_battery_capacity(dev, value);
> +	capacity = hidinput_scale_battery_capacity(bat, value);
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
> +		power_supply_changed(bat->ps);
>  	}
>  }
>  #else  /* !CONFIG_HID_BATTERY_STRENGTH */
> @@ -637,8 +660,14 @@ static int hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
>  	return 0;
>  }
> 
> -static void hidinput_update_battery(struct hid_device *dev, unsigned int usage,
> -				    int value)
> +static struct hid_battery *hidinput_find_battery(struct hid_device *dev,
> +						 int report_id)
> +{
> +	return NULL;
> +}
> +
> +static void hidinput_update_battery(struct hid_battery *bat,
> +				    unsigned int usage, int value)
>  {
>  }
>  #endif	/* CONFIG_HID_BATTERY_STRENGTH */
> @@ -1506,7 +1535,11 @@ void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct
>  		return;
> 
>  	if (usage->type == EV_PWR) {
> -		hidinput_update_battery(hid, usage->hid, value);
> +		struct hid_battery *bat = hidinput_find_battery(hid,
> +								 report->id);
> +
> +		if (bat)
> +			hidinput_update_battery(bat, usage->hid, value);
>  		return;
>  	}
> 
> diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
> index 7d4a25c6de0e..b495f7a4bc6c 100644
> --- a/drivers/hid/hid-magicmouse.c
> +++ b/drivers/hid/hid-magicmouse.c
> @@ -812,19 +812,21 @@ static int magicmouse_fetch_battery(struct hid_device *hdev)
>  #ifdef CONFIG_HID_BATTERY_STRENGTH
>  	struct hid_report_enum *report_enum;
>  	struct hid_report *report;
> +	struct hid_battery *bat;
> 
> -	if (!hdev->battery ||
> +	bat = hid_get_first_battery(hdev);
> +	if (!bat ||
>  	    (!is_usb_magicmouse2(hdev->vendor, hdev->product) &&
>  	     !is_usb_magictrackpad2(hdev->vendor, hdev->product)))
>  		return -1;
> 
> -	report_enum = &hdev->report_enum[hdev->battery_report_type];
> -	report = report_enum->report_id_hash[hdev->battery_report_id];
> +	report_enum = &hdev->report_enum[bat->report_type];
> +	report = report_enum->report_id_hash[bat->report_id];
> 
>  	if (!report || report->maxfield < 1)
>  		return -1;
> 
> -	if (hdev->battery_capacity == hdev->battery_max)
> +	if (bat->capacity == bat->max)
>  		return -1;
> 
>  	hid_hw_request(hdev, report, HID_REQ_GET_REPORT);
> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index a4ddb94e3ee5..3e33ef74c3c1 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -634,6 +634,36 @@ enum hid_battery_status {
>  	HID_BATTERY_REPORTED,		/* Device sent unsolicited battery strength report */
>  };
> 
> +/**
> + * struct hid_battery - represents a single battery power supply
> + * @dev: pointer to the parent hid_device
> + * @ps: the power supply instance
> + * @min: minimum battery value from HID descriptor
> + * @max: maximum battery value from HID descriptor
> + * @report_type: HID report type (input/feature)
> + * @report_id: HID report ID for this battery
> + * @charge_status: current charging status
> + * @status: battery reporting status
> + * @capacity: current battery capacity (0-100)
> + * @avoid_query: if true, avoid querying battery (e.g., for stylus)
> + * @ratelimit_time: rate limiting for battery reports
> + * @list: list node for linking into hid_device's battery list
> + */
> +struct hid_battery {
> +	struct hid_device *dev;
> +	struct power_supply *ps;
> +	__s32 min;
> +	__s32 max;
> +	__s32 report_type;
> +	__s32 report_id;
> +	__s32 charge_status;
> +	enum hid_battery_status status;
> +	__s32 capacity;
> +	bool avoid_query;
> +	ktime_t ratelimit_time;
> +	struct list_head list;
> +};
> +
>  struct hid_driver;
>  struct hid_ll_driver;
> 
> @@ -670,19 +700,10 @@ struct hid_device {
>  #ifdef CONFIG_HID_BATTERY_STRENGTH
>  	/*
>  	 * Power supply information for HID devices which report
> -	 * battery strength. power_supply was successfully registered if
> -	 * battery is non-NULL.
> +	 * battery strength. Each battery is tracked separately in the
> +	 * batteries list.
>  	 */
> -	struct power_supply *battery;
> -	__s32 battery_capacity;
> -	__s32 battery_min;
> -	__s32 battery_max;
> -	__s32 battery_report_type;
> -	__s32 battery_report_id;
> -	__s32 battery_charge_status;
> -	enum hid_battery_status battery_status;
> -	bool battery_avoid_query;
> -	ktime_t battery_ratelimit_time;
> +	struct list_head batteries;
>  #endif
> 
>  	unsigned long status;						/* see STAT flags above */
> @@ -743,6 +764,15 @@ static inline void hid_set_drvdata(struct hid_device *hdev, void *data)
>  	dev_set_drvdata(&hdev->dev, data);
>  }
> 
> +#ifdef CONFIG_HID_BATTERY_STRENGTH
> +static inline struct hid_battery *hid_get_first_battery(struct hid_device *hdev)
> +{
> +	if (list_empty(&hdev->batteries))
> +		return NULL;
> +	return list_first_entry(&hdev->batteries, struct hid_battery, list);
> +}
> +#endif
> +
>  #define HID_GLOBAL_STACK_SIZE 4
>  #define HID_COLLECTION_STACK_SIZE 4
> 
> --
> 2.51.1
> 

