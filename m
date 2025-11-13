Return-Path: <linux-pm+bounces-37943-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C4AC571A2
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 12:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF1F23A7883
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 11:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D914B33375F;
	Thu, 13 Nov 2025 11:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uc00NlNW"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB33F2D6E51;
	Thu, 13 Nov 2025 11:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763032116; cv=none; b=eeoOH5GgwfqL8tBT06UW39ApOzArqbt3PAMpm7jjFcWT6aK5gJdmuKbti8frbd1gCby7cWqqWKjPpAPlhFXOC2ddWYnoNieJlL8aQeN1lGgganELvc1QDQScZJqJCXQIdLN5w4NYqVdVoSMJeUUZrSr3PXARsWJaSkyeBVUMbks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763032116; c=relaxed/simple;
	bh=afemL/E0l10dPwi2FABl4iJ1F+RV+CutUeg4nsajqIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hlFOwgnRVkk4Hb9VdsorE6T1ViAW2/es3nSojlHl/lD53Y1/Z+wZnr4SWA6viiiR8QkPmLiL/BLDPngJMQpCNtGp5KAKcj+jwBM7OQsNuuvjTVM7RGWBKBAWAJmHxErFhAofDdOJBc+0OKLc+iqYYpkaMMd8Rx1i/cPjU5H8NeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uc00NlNW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DCB6C4CEF5;
	Thu, 13 Nov 2025 11:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763032116;
	bh=afemL/E0l10dPwi2FABl4iJ1F+RV+CutUeg4nsajqIo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uc00NlNWah6gFEoJlQ6Hqi4MUonk/PXXlhnKMAQrAhAviUMfhtpZIMMcDA5kB1Fce
	 DIRatPNyEn2V/+eFBZ1UNLI5Y5psOzoYeaYsA2yr05Jk/Cgc/wRoFmZRsGw85f3/2F
	 tsEdkU+7xX+wbpyhTSI4pmaPfoD7jHCbPA8It1dLA+x12v0lPsS7Ou+D8cAtVpQ0Sz
	 mhJvpuRPkaz+zwHdF0kiYkK0Gp3yn2aZZzeUSvZoxhx4nXyoFOPgiq8B0ZcocvbRfp
	 qAV9jRj/QTowYwyAHWOZjCRpxKRYdxotDlXnHCAI/TRMpoRs5eq6MzRenRnfqwkHHA
	 2VNCh0ilH08+g==
Date: Thu, 13 Nov 2025 12:08:32 +0100
From: Benjamin Tissoires <bentiss@kernel.org>
To: Lucas Zampieri <lzampier@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jiri Kosina <jikos@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
	Bastien Nocera <hadess@hadess.net>, linux-pm@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/3] HID: input: Add support for multiple
 batteries per device
Message-ID: <my3aleryrl57cp3lc7y2puh45rccgxmkvlkyib5537zvhjnnwc@bfbyknryvp2u>
References: <20251113001508.713574-1-lzampier@redhat.com>
 <20251113001508.713574-4-lzampier@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113001508.713574-4-lzampier@redhat.com>

On Nov 13 2025, Lucas Zampieri wrote:
> Enable HID devices to register and manage multiple batteries by
> maintaining a list of hid_battery structures, each identified by
> its report ID.
> 
> The legacy dev->battery field and related fields are maintained for
> backward compatibility, pointing to the first battery in the list.
> This allows existing code to continue working unchanged while
> enabling new functionality for multi-battery devices.
> 
> Example hardware that can benefit from this:
> - Gaming headsets with charging docks (e.g., SteelSeries Arctis Nova Pro
>   Wireless)
> - Graphics tablets with stylus batteries (Wacom)
> - Wireless earbuds with per-earbud batteries plus charging case
> - Split keyboards with independent battery per side
> 
> Signed-off-by: Lucas Zampieri <lzampier@redhat.com>
> ---
>  drivers/hid/hid-core.c  |  4 ++
>  drivers/hid/hid-input.c | 99 +++++++++++++++++++++++++++--------------
>  include/linux/hid.h     | 12 ++++-
>  3 files changed, 80 insertions(+), 35 deletions(-)
> 
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
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index 0e71efea9da3..9d0be3d4ce04 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -520,14 +520,20 @@ static int hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
>  	unsigned quirks;
>  	s32 min, max;
>  	int error;
> +	int battery_num = 0;
> 
> -	if (dev->battery)
> -		return 0;	/* already initialized? */
> +	/* Check if battery with this report_id already exists */
> +	list_for_each_entry(bat, &dev->batteries, list) {
> +		if (bat->report_id == field->report->id)
> +			return 0;	/* already initialized */

I wonder if we should not make this test stick out a little bit more.

Something like "get_battery(field)" which would return a battery if the
field matches. This way, if we ever encounter multiple batteries
reported on the same report ID, we can always split them by logical
collection, physical, or something else.

> +		battery_num++;
> +	}
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
> @@ -542,9 +548,17 @@ static int hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
>  		goto err_free_bat;
>  	}
> 
> -	psy_desc->name = kasprintf(GFP_KERNEL, "hid-%s-battery",
> -				   strlen(dev->uniq) ?
> -					dev->uniq : dev_name(&dev->dev));
> +	/* Create unique name for each battery based on report ID */
> +	if (battery_num == 0) {
> +		psy_desc->name = kasprintf(GFP_KERNEL, "hid-%s-battery",
> +					   strlen(dev->uniq) ?
> +						dev->uniq : dev_name(&dev->dev));
> +	} else {
> +		psy_desc->name = kasprintf(GFP_KERNEL, "hid-%s-battery-%d",
> +					   strlen(dev->uniq) ?
> +						dev->uniq : dev_name(&dev->dev),
> +					   battery_num);
> +	}

Not sure how much conservative you need to be here, but I would prefer
we stick to the same naming pattern whether this is the first or second
battery.

>  	if (!psy_desc->name) {
>  		error = -ENOMEM;
>  		goto err_free_desc;
> @@ -597,15 +611,23 @@ static int hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
> 
>  	power_supply_powers(bat->ps, &dev->dev);
> 
> -	/* Maintain legacy single battery fields for backward compatibility */
> -	dev->battery = bat->ps;
> -	dev->battery_min = bat->min;
> -	dev->battery_max = bat->max;
> -	dev->battery_report_type = bat->report_type;
> -	dev->battery_report_id = bat->report_id;
> -	dev->battery_charge_status = bat->charge_status;
> -	dev->battery_status = bat->status;
> -	dev->battery_avoid_query = bat->avoid_query;
> +	list_add_tail(&bat->list, &dev->batteries);
> +
> +	/*
> +	 * The legacy single battery API is preserved by exposing the first
> +	 * discovered battery. Systems relying on a single battery view maintain
> +	 * unchanged behavior.
> +	 */
> +	if (battery_num == 0) {
> +		dev->battery = bat->ps;
> +		dev->battery_min = bat->min;
> +		dev->battery_max = bat->max;
> +		dev->battery_report_type = bat->report_type;
> +		dev->battery_report_id = bat->report_id;
> +		dev->battery_charge_status = bat->charge_status;
> +		dev->battery_status = bat->status;
> +		dev->battery_avoid_query = bat->avoid_query;
> +	}

Again, why keeping the old fields? Are they used anywhere?

> 
>  	return 0;
> 
> @@ -620,21 +642,33 @@ static int hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
> 
>  static void hidinput_cleanup_battery(struct hid_device *dev)
>  {
> -	struct hid_battery *bat;
> +	struct hid_battery *bat, *next;
>  	const struct power_supply_desc *psy_desc;
> 
> -	if (!dev->battery)
> -		return;
> +	list_for_each_entry_safe(bat, next, &dev->batteries, list) {
> +		psy_desc = bat->ps->desc;
> +		power_supply_unregister(bat->ps);
> +		kfree(psy_desc->name);
> +		kfree(psy_desc);
> +		list_del(&bat->list);
> +		kfree(bat);
> +	}

Really, switching to devm the batteries would greatly help not making
mistakes here.

> 
> -	bat = power_supply_get_drvdata(dev->battery);
> -	psy_desc = dev->battery->desc;
> -	power_supply_unregister(dev->battery);
> -	kfree(psy_desc->name);
> -	kfree(psy_desc);
> -	kfree(bat);
>  	dev->battery = NULL;
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

Oh, so you already have this function. So why not making use of it in
hidinput_setup_battery()?

> +
>  static bool hidinput_update_battery_charge_status(struct hid_battery *bat,
>  						  unsigned int usage, int value)
>  {
> @@ -652,17 +686,16 @@ static bool hidinput_update_battery_charge_status(struct hid_battery *bat,
>  	return false;
>  }
> 
> -static void hidinput_update_battery(struct hid_device *dev, unsigned int usage,
> -				    int value)
> +static void hidinput_update_battery(struct hid_device *dev, int report_id,
> +				    unsigned int usage, int value)
>  {
>  	struct hid_battery *bat;
>  	int capacity;
> 
> -	if (!dev->battery)
> +	bat = hidinput_find_battery(dev, report_id);
> +	if (!bat)
>  		return;
> 
> -	bat = power_supply_get_drvdata(dev->battery);
> -
>  	if (hidinput_update_battery_charge_status(bat, usage, value)) {
>  		power_supply_changed(bat->ps);
>  		return;
> @@ -705,8 +738,8 @@ static void hidinput_cleanup_battery(struct hid_device *dev)
>  {
>  }
> 
> -static void hidinput_update_battery(struct hid_device *dev, unsigned int usage,
> -				    int value)
> +static void hidinput_update_battery(struct hid_device *dev, int report_id,
> +				    unsigned int usage, int value)

Why not hidinput_update_battery(struct hid_battery *bat, unsigned int usage, int value)?

>  {
>  }
>  #endif	/* CONFIG_HID_BATTERY_STRENGTH */
> @@ -1574,7 +1607,7 @@ void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct
>  		return;
> 
>  	if (usage->type == EV_PWR) {
> -		hidinput_update_battery(hid, usage->hid, value);
> +		hidinput_update_battery(hid, report->id, usage->hid, value);

With the suggested change in hidinput_update_battery, first query the
battery and then change it.

>  		return;
>  	}
> 
> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index 63422130de20..a6e36835fb3c 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -700,8 +700,16 @@ struct hid_device {
>  #ifdef CONFIG_HID_BATTERY_STRENGTH
>  	/*
>  	 * Power supply information for HID devices which report
> -	 * battery strength. power_supply was successfully registered if
> -	 * battery is non-NULL.
> +	 * battery strength. Each battery is tracked separately in the
> +	 * batteries list.
> +	 */
> +	struct list_head batteries;		/* List of hid_battery structures */
> +
> +	/*
> +	 * Legacy single battery support - kept for backwards compatibility.
> +	 * Points to the first battery in the list if any exists.
> +	 * power_supply was successfully registered if battery is non-NULL.
> +	 * DEPRECATED: New code should iterate through batteries list instead.
>  	 */
>  	struct power_supply *battery;

Nah. hid_device is pure internal interface. So change all the users if
needed, but don't keep something around in the hope that others will do
the work for you.

For references there has been a very long discussion with Linus about
API changes, and the result was that any API change that introduced a
duplicate API was probably a bad design ;)

Cheers,
Benjamin

>  	__s32 battery_capacity;
> --
> 2.51.1
> 

