Return-Path: <linux-pm+bounces-39341-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D4FCDCAFA4A
	for <lists+linux-pm@lfdr.de>; Tue, 09 Dec 2025 11:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 417A93011186
	for <lists+linux-pm@lfdr.de>; Tue,  9 Dec 2025 10:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04ABB2857CD;
	Tue,  9 Dec 2025 10:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ed1D5u/A"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDAB1EE033;
	Tue,  9 Dec 2025 10:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765276362; cv=none; b=HYXsARApYjKf8XVfVjb452B+9pon7S7CR0fiQomEd5dSe7mfC9UzHQnwLw5jf8eKg79UAgKZ/LMxGsLAbtAXcPkZ0WfuypHe0YgcWVyo+AdaNJsLimdUs/bWfkwPsklKcanAaqnJCerBZc8s7XJRbbq7whsZMayQK0SyJEzJiP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765276362; c=relaxed/simple;
	bh=PndLdpaaxi55sQ8QpGxvUhn/SLKC13Su10SE7RFjHVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WYjee9uN0t2rxNdPt3qXj4G8jABZQ2zSZliABxh4fm6a6TkRuvapza4ZHZmRzccOhgHwguuH9r/l594lfVH/ipaTqu7BUVL2jwlcGyh0V3etk5oJH6XvLlQm5i7ouYnZb2Fy62g2L25OlPh9bBbU2pNJfkemauiF2ipvNayDGtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ed1D5u/A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFE1AC4CEF5;
	Tue,  9 Dec 2025 10:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765276362;
	bh=PndLdpaaxi55sQ8QpGxvUhn/SLKC13Su10SE7RFjHVo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ed1D5u/AREKnGNM6mMd4BFALwWhx4xfs0IdQT8zZkt7Z5YUXFaoH2msadFscEg4yd
	 n8Ot/rn7EM22I3K9+mceMWalKJCRqygUYWO+nNOtxOdtBmPYGdUgOFNWAVBQ1XRfU7
	 NIYXxGYvhjuKgLKmuTdS0qU4ZQv/qV3vtxfW4vURiNLOcn67w46SnJImdSEsSQ+12Y
	 uX3Nbggt9ZPNOC7BSb9yhV9cSqFzk8qe1FyOWGfo8iyR5YaH/6a69yLSeX6rNoMHdl
	 vODNKt2Y0LMaiDgM7WlkTSPBqUUsuFQAIRHBvBiu2J4EmagRM7l1980qpuXJ/b8FyN
	 mjzXmpOILf0CQ==
Date: Tue, 9 Dec 2025 11:32:37 +0100
From: Benjamin Tissoires <bentiss@kernel.org>
To: Lucas Zampieri <lzampier@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jiri Kosina <jikos@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
	Bastien Nocera <hadess@hadess.net>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 1/2] HID: input: Convert battery code to devm_*
Message-ID: <hn2vabg7wvyqzdvp4erwuhfsyahsx35l6ehmo5fmklfnbybqgo@on5mev5x7svd>
References: <20251121131556.601130-1-lzampier@redhat.com>
 <20251121131556.601130-2-lzampier@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121131556.601130-2-lzampier@redhat.com>

On Nov 21 2025, Lucas Zampieri wrote:
> Convert the HID battery code to use devm_* managed resource APIs.
> 
> This changes the following allocations:
> - kzalloc() -> devm_kzalloc() for power_supply_desc
> - kasprintf() -> devm_kasprintf() for battery name
> - power_supply_register() -> devm_power_supply_register()
> 
> No functional behavior changes.
> 
> Signed-off-by: Lucas Zampieri <lzampier@redhat.com>
> ---
>  drivers/hid/hid-input.c | 49 +++++++++--------------------------------
>  1 file changed, 10 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index e56e7de53279..5f313c3c35e2 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -530,17 +530,15 @@ static int hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
>  	if (quirks & HID_BATTERY_QUIRK_IGNORE)
>  		return 0;
>  
> -	psy_desc = kzalloc(sizeof(*psy_desc), GFP_KERNEL);
> +	psy_desc = devm_kzalloc(&dev->dev, sizeof(*psy_desc), GFP_KERNEL);
>  	if (!psy_desc)
>  		return -ENOMEM;
>  
> -	psy_desc->name = kasprintf(GFP_KERNEL, "hid-%s-battery",
> -				   strlen(dev->uniq) ?
> -					dev->uniq : dev_name(&dev->dev));
> -	if (!psy_desc->name) {
> -		error = -ENOMEM;
> -		goto err_free_mem;
> -	}
> +	psy_desc->name = devm_kasprintf(&dev->dev, GFP_KERNEL, "hid-%s-battery",
> +					strlen(dev->uniq) ?
> +						dev->uniq : dev_name(&dev->dev));
> +	if (!psy_desc->name)
> +		return -ENOMEM;
>  
>  	psy_desc->type = POWER_SUPPLY_TYPE_BATTERY;
>  	psy_desc->properties = hidinput_battery_props;
> @@ -576,36 +574,15 @@ static int hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
>  	if (quirks & HID_BATTERY_QUIRK_AVOID_QUERY)
>  		dev->battery_avoid_query = true;
>  
> -	dev->battery = power_supply_register(&dev->dev, psy_desc, &psy_cfg);
> +	dev->battery = devm_power_supply_register(&dev->dev, psy_desc, &psy_cfg);
>  	if (IS_ERR(dev->battery)) {
> -		error = PTR_ERR(dev->battery);
> -		hid_warn(dev, "can't register power supply: %d\n", error);
> -		goto err_free_name;
> +		hid_warn(dev, "can't register power supply: %ld\n",
> +			 PTR_ERR(dev->battery));
> +		return PTR_ERR(dev->battery);
>  	}
>  
>  	power_supply_powers(dev->battery, &dev->dev);
>  	return 0;
> -
> -err_free_name:
> -	kfree(psy_desc->name);
> -err_free_mem:
> -	kfree(psy_desc);
> -	dev->battery = NULL;
> -	return error;

As mentioned in my other reply (and this is more of an open question):
what if there is a failure in devm_power_supply_register? Everything
will be allocated and kept until the end of life of the HID device, but
we'll try to recreate the battery for every matching field in the HID
device, meaning we are waiting a lot of space for nothing.

The previous appraoch was cleaning things up, so we were trying a lot,
but at least we were not keeping the memory allocated.

I think we should keep the error path for devm_power_supply_register()
and dealloc (with devm_kfree) the few memories we've done and also clear
dev->battery.  This way we keep the current path and can make use of
devm and get the benefits of removing the hidinput_cleanup_battery()
function.

Cheers,
Benjamin

> -}
> -
> -static void hidinput_cleanup_battery(struct hid_device *dev)
> -{
> -	const struct power_supply_desc *psy_desc;
> -
> -	if (!dev->battery)
> -		return;
> -
> -	psy_desc = dev->battery->desc;
> -	power_supply_unregister(dev->battery);
> -	kfree(psy_desc->name);
> -	kfree(psy_desc);
> -	dev->battery = NULL;
>  }
>  
>  static bool hidinput_update_battery_charge_status(struct hid_device *dev,
> @@ -660,10 +637,6 @@ static int hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
>  	return 0;
>  }
>  
> -static void hidinput_cleanup_battery(struct hid_device *dev)
> -{
> -}
> -
>  static void hidinput_update_battery(struct hid_device *dev, unsigned int usage,
>  				    int value)
>  {
> @@ -2379,8 +2352,6 @@ void hidinput_disconnect(struct hid_device *hid)
>  {
>  	struct hid_input *hidinput, *next;
>  
> -	hidinput_cleanup_battery(hid);
> -
>  	list_for_each_entry_safe(hidinput, next, &hid->inputs, list) {
>  		list_del(&hidinput->list);
>  		if (hidinput->registered)
> -- 
> 2.51.1
> 

