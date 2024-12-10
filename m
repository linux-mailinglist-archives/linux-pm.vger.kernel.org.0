Return-Path: <linux-pm+bounces-18926-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AF79EB75E
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 18:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 648BC280A92
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 17:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85D823278B;
	Tue, 10 Dec 2024 17:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="iSbNefuI"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58C322FE17;
	Tue, 10 Dec 2024 17:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733850224; cv=none; b=N14ovxuA4clr+I4LBF0HLG1WBRS9PWLrfSrQ/2rSWSrMOvs9zw9Qk/HbvhNOqc9k3KWX7V57AGfsza1Bkj7nxHVvqcRaDU5Lbqowlu0njEcKsMJiwVpnIV/IrusOHsMp7oVhVAt92qm6+6MEdEjuXclr2HgWwCjH9GInVqoXG/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733850224; c=relaxed/simple;
	bh=Lp8Jhgg1qVhtZgXWwaHfbQ7G7Qq7eMQKR/S57j01VfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RmiJf3BIMNDTqatXChSxtXQaLBtiJvpXSx5Td8jaz7qfsFdvMcdEYuIbWteFecDABw4qkZO2WVMyp9qBHY0GVBGnGnTu1pYY/jOi0Few2tYsTVklwUIuedUCpIk2T3gL98agISCy+IeSAxlvtB2RoHvQhHJPKhRLeOHldfOQyl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=iSbNefuI; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733850219;
	bh=Lp8Jhgg1qVhtZgXWwaHfbQ7G7Qq7eMQKR/S57j01VfQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iSbNefuI29Sm/0xB3x4crw7wYQYO1tRxmUoseWqSq0q1F97ZJWcaU3H4IOSPy4Ru0
	 7lSQvPtp6qi8s4bIOC7/U4YDXkP4lwxA+EdwAVAKJBIMW5S/Q1Dci+IDXIb6/nJZuD
	 nprgQJF/ZQR6zgcD5sC+aQsalkpxah3cDUWbgPJ4=
Date: Tue, 10 Dec 2024 18:03:39 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Andy Shevchenko <andy@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
	platform-driver-x86@vger.kernel.org, Jelle van der Waa <jelle@vdwaa.nl>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 4/4] platform/x86: dell-laptop: Use
 power_supply_charge_types_show/_parse() helpers
Message-ID: <f57031ce-8d5c-4601-87bc-2f1362a8de78@t-8ch.de>
References: <20241209204051.8786-1-hdegoede@redhat.com>
 <20241209204051.8786-5-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241209204051.8786-5-hdegoede@redhat.com>

On 2024-12-09 21:40:51+0100, Hans de Goede wrote:
> Make battery_modes a map between tokens and enum power_supply_charge_type
> values instead of between tokens and strings and use the new
> power_supply_charge_types_show/_parse() helpers for show()/store()
> to ensure that things are handled in the same way as in other drivers.
> 
> This also changes battery_supported_modes to be a bitmap of charge-types
> (enum power_supply_charge_type values) rather then a bitmap of indices
> into battery_modes[].
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

This screams for power supply extensions.

Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>

> ---
>  drivers/platform/x86/dell/dell-laptop.c | 54 ++++++++++++-------------
>  1 file changed, 25 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/platform/x86/dell/dell-laptop.c b/drivers/platform/x86/dell/dell-laptop.c
> index 5671bd0deee7..9a4cfcb8bbe0 100644
> --- a/drivers/platform/x86/dell/dell-laptop.c
> +++ b/drivers/platform/x86/dell/dell-laptop.c
> @@ -103,15 +103,15 @@ static bool mute_led_registered;
>  
>  struct battery_mode_info {
>  	int token;
> -	const char *label;
> +	enum power_supply_charge_type charge_type;
>  };
>  
>  static const struct battery_mode_info battery_modes[] = {
> -	{ BAT_PRI_AC_MODE_TOKEN,   "Trickle" },
> -	{ BAT_EXPRESS_MODE_TOKEN,  "Fast" },
> -	{ BAT_STANDARD_MODE_TOKEN, "Standard" },
> -	{ BAT_ADAPTIVE_MODE_TOKEN, "Adaptive" },
> -	{ BAT_CUSTOM_MODE_TOKEN,   "Custom" },
> +	{ BAT_PRI_AC_MODE_TOKEN,   POWER_SUPPLY_CHARGE_TYPE_TRICKLE },
> +	{ BAT_EXPRESS_MODE_TOKEN,  POWER_SUPPLY_CHARGE_TYPE_FAST },
> +	{ BAT_STANDARD_MODE_TOKEN, POWER_SUPPLY_CHARGE_TYPE_STANDARD },
> +	{ BAT_ADAPTIVE_MODE_TOKEN, POWER_SUPPLY_CHARGE_TYPE_ADAPTIVE },
> +	{ BAT_CUSTOM_MODE_TOKEN,   POWER_SUPPLY_CHARGE_TYPE_CUSTOM },
>  };
>  static u32 battery_supported_modes;
>  
> @@ -2261,46 +2261,42 @@ static ssize_t charge_types_show(struct device *dev,
>  		struct device_attribute *attr,
>  		char *buf)
>  {
> -	ssize_t count = 0;
> +	enum power_supply_charge_type charge_type;
>  	int i;
>  
>  	for (i = 0; i < ARRAY_SIZE(battery_modes); i++) {
> -		bool active;
> +		charge_type = battery_modes[i].charge_type;
>  
> -		if (!(battery_supported_modes & BIT(i)))
> +		if (!(battery_supported_modes & BIT(charge_type)))
>  			continue;
>  
> -		active = dell_battery_mode_is_active(battery_modes[i].token);
> -		count += sysfs_emit_at(buf, count, active ? "[%s] " : "%s ",
> -				battery_modes[i].label);
> +		if (!dell_battery_mode_is_active(battery_modes[i].token))
> +			continue;
> +
> +		return power_supply_charge_types_show(dev, battery_supported_modes,
> +						      charge_type, buf);
>  	}
>  
> -	/* convert the last space to a newline */
> -	if (count > 0)
> -		count--;
> -	count += sysfs_emit_at(buf, count, "\n");
> -
> -	return count;
> +	/* No active mode found */
> +	return -EIO;
>  }
>  
>  static ssize_t charge_types_store(struct device *dev,
>  		struct device_attribute *attr,
>  		const char *buf, size_t size)
>  {
> -	bool matched = false;
> -	int err, i;
> +	int charge_type, err, i;
> +
> +	charge_type = power_supply_charge_types_parse(battery_supported_modes, buf);
> +	if (charge_type < 0)
> +		return charge_type;
>  
>  	for (i = 0; i < ARRAY_SIZE(battery_modes); i++) {
> -		if (!(battery_supported_modes & BIT(i)))
> -			continue;
> -
> -		if (sysfs_streq(battery_modes[i].label, buf)) {
> -			matched = true;
> +		if (battery_modes[i].charge_type == charge_type)
>  			break;
> -		}
>  	}
> -	if (!matched)
> -		return -EINVAL;
> +	if (i == ARRAY_SIZE(battery_modes))
> +		return -EIO;
>  
>  	err = dell_battery_set_mode(battery_modes[i].token);
>  	if (err)
> @@ -2430,7 +2426,7 @@ static u32 __init battery_get_supported_modes(void)
>  
>  	for (i = 0; i < ARRAY_SIZE(battery_modes); i++) {
>  		if (dell_smbios_find_token(battery_modes[i].token))
> -			modes |= BIT(i);
> +			modes |= BIT(battery_modes[i].charge_type);
>  	}
>  
>  	return modes;
> -- 
> 2.47.1
> 

