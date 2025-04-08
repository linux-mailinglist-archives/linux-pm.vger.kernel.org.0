Return-Path: <linux-pm+bounces-24927-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9D2A7F74A
	for <lists+linux-pm@lfdr.de>; Tue,  8 Apr 2025 10:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBC997A8FE6
	for <lists+linux-pm@lfdr.de>; Tue,  8 Apr 2025 08:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C91A263C95;
	Tue,  8 Apr 2025 08:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jx65mswq"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EDC25F96E
	for <linux-pm@vger.kernel.org>; Tue,  8 Apr 2025 08:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744099652; cv=none; b=g64plhKFjtdui1dVoQ0aOm4yFX94Fv9rej7E72vWEIgkEbmp3Sqb7/FHzO8i6E/bjOAhJ1HiLSILr4gCTDiBTZ0NdbbCTfQ46dCVmQ5b0xDdZLEdITvxNVKy/Fv7wEfC2sHnIEzzkl+p0kr0hnZEZKTj6yaSqUtJ7bOaB0oGJqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744099652; c=relaxed/simple;
	bh=s7MVm1YTr6AMX86P33IyohlvuRiDI0oPnYPp9kxAW0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pKYJzMObLLmo3ZEPgy3PWn72FWRYjg7JckbefGXIGOv0bi3kFONLOcH4jeBa8cls+FQ7Ns4ZYeq54qDPkx5etY+ohOnVGJDAtZNsyVylCfRW74kJhEMDCzGYrTgbV1Z5I7WpbVaBQU5YguBIBwX4hEOfMEDl4LShI/CdLC1EJE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jx65mswq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744099649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FFtlg+pR9gIX2B7BqaLn6AjV2rMhZ5LyunJA9o5t8sU=;
	b=Jx65mswqUBo6PvPVdo6Lg4YdFH6z3jDFF3Izn8X/9Em9DGsbZtPLvk0s/msNg/T5cROD1n
	1yEWGKjbIIE4c1zRD4Z7N5RYxs3i0Rf4vBgfN9M64/1p+TZ2c4dettjAs0v9TCgOPBrMQf
	ROPiiDIom/g3USxGmIICEQHfWyMReOU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-qRVOniJ9OWWyivYMA2aeQw-1; Tue, 08 Apr 2025 04:07:27 -0400
X-MC-Unique: qRVOniJ9OWWyivYMA2aeQw-1
X-Mimecast-MFC-AGG-ID: qRVOniJ9OWWyivYMA2aeQw_1744099646
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5ed2a1bfec7so4659526a12.1
        for <linux-pm@vger.kernel.org>; Tue, 08 Apr 2025 01:07:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744099646; x=1744704446;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FFtlg+pR9gIX2B7BqaLn6AjV2rMhZ5LyunJA9o5t8sU=;
        b=NDygRgoRmH8L8x8SwbQg+NnE6fOyeyrjGi7W5PC0yLOeIrRNYwFYYbMEQ56pctWtF7
         kAnQb0BrLCBMEfSog36RudJukXZs147SWAbhZUJh0K1XzkWFsRTTx+PCb+ub0vx/mx1a
         zi01XYcz3dovDdzPSsVV9iCs1O+ZVC6H8g4OM5N44vebXwWNDYbTkXV1ig8vsL4kyFoL
         yxsZ1VmV5iaWsCyibyM56j1ONCBnAF+T7p2I9v0d29PWzFkuwzTkVhW1Syq3QOIO4Ucw
         lbtSnKf9U9gzLlyrVIZCOo3Xnf2YC9udGDPVO85UKHPy1ZPC+XHqzip9fnPiNREjfXpT
         X2KA==
X-Forwarded-Encrypted: i=1; AJvYcCV53qp6niuAnJQxfsMP0+2/jE+YMCiSM+s9njhDR/fXV1QtYpt3gX8jjc4YWIDxPJyIga1SEfO2Ew==@vger.kernel.org
X-Gm-Message-State: AOJu0YwVn2+xmeqE0BS+wzgSwuW3nCOqx9NsqBqqFCH9O/PBOu9FKVU0
	FZi/GIyUXhaGIG1f5A313VHRYsCojUb+r3wsFRm0TXFAZNpDeWWoJQNCIKRQIO8Rvq+EpVAbvPC
	A7km4RRjFaOgL73bHVNlQHuoTCuYuSpBNcDalTCj60I2Bl1eJNLMED9ra
X-Gm-Gg: ASbGnctz+E8pdaB2eDCGk5zX70k1ps+HRl1VHIOvsM/nZjBK3hESW7ObWZAv0hTvl82
	LoScPHwHdrdHf/ZaB0hDuWFSQtHVVk3f9LJER2gOrtp9dVZjyOk4NOulriDvC7xqgsUsimI9RS+
	sSHGxWsnQDF2AzQkn8F9IQlx+Ch8J/0x7MwQ7gu95x/DVk6g1KpZY2sNinR3hwYkV1TxKHS/Wkb
	E/hiR0h7m21kgpemW8qu9lsam1BgC3NWfjO7Yk+Sx/CAe6NIGUxYMtfHgm7rJnN0xWXSQzRQKb4
	SSqblzwm3GGzAsBvxJytXyoVOqGCs6V16gRVj72CO6aQhJ8ofyxmGgtbBopVmrUJjzMHVerXU5X
	y/vjyrfr0AU0gho2gaotqAjs4XKHmNZeFspoSIm9TCa45eCPCh2jHIMb4DQ0N4SXnqA==
X-Received: by 2002:a05:6402:3584:b0:5e5:dbd0:2a4d with SMTP id 4fb4d7f45d1cf-5f0db80a58fmr9394980a12.8.1744099646214;
        Tue, 08 Apr 2025 01:07:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFEa+H9i6bNZ80VuGRR/WaJTf/jT3yZVEznoqM+YifUkE8ZCtIO7jJUL+cK68m9MvBSaqz6Q==
X-Received: by 2002:a05:6402:3584:b0:5e5:dbd0:2a4d with SMTP id 4fb4d7f45d1cf-5f0db80a58fmr9394943a12.8.1744099645790;
        Tue, 08 Apr 2025 01:07:25 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f087eedf61sm7564543a12.32.2025.04.08.01.07.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 01:07:25 -0700 (PDT)
Message-ID: <ff81cb29-cf02-4e71-9859-2c650caaeb8d@redhat.com>
Date: Tue, 8 Apr 2025 10:07:24 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] power: supply: support charge_types in extensions
To: Jelle van der Waa <jvanderw@redhat.com>,
 Sebastian Reichel <sre@kernel.org>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 linux-pm@vger.kernel.org, Jelle van der Waa <jvanderwaa@redhat.com>
References: <20250407201845.332348-1-jvanderw@redhat.com>
 <20250407201845.332348-2-jvanderw@redhat.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20250407201845.332348-2-jvanderw@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jelle,

Thank you for your patch.

On 7-Apr-25 10:18 PM, Jelle van der Waa wrote:
> From: Jelle van der Waa <jvanderwaa@redhat.com>
> 
> Similar to charge_behaviour, charge_types is an enum option with
> multiple possible values. To be able to use it with a power_supply
> extension its known values have to be exposed.

"multiple possible values" sounds like the actual setting
is a bitmask where multiple options can be enabled at once.

And "its known values" sounds like this is about the currently
active value(s).

Instead I suggest a text like this:

"""
Similar to charge_behaviour, charge_types is an enum option where reading
the property shows the supported values, with the active value surrounded
by brackets. To be able to use it with a power_supply extension a bitmask
with the supported charge_Types values has to be added to power_supply_ext.
"""

Feel free to re-use this verbatim, or just the bits you like.

> Signed-off-by: Jelle van der Waa <jvanderwaa@redhat.com>
> ---
>  drivers/power/supply/power_supply_sysfs.c | 23 ++++++++++++++++++++++-
>  drivers/power/supply/test_power.c         | 20 ++++++++++++++++++--
>  include/linux/power_supply.h              |  1 +
>  3 files changed, 41 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
> index edb058c19c9c..6d80640511b5 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -321,6 +321,27 @@ static ssize_t power_supply_show_charge_behaviour(struct device *dev,
>  						  value->intval, buf);
>  }
>  
> +static ssize_t power_supply_show_charge_types(struct device *dev,
> +					      struct power_supply *psy,
> +					      enum power_supply_charge_type current_type,
> +					      char *buf)
> +{
> +	struct power_supply_ext_registration *reg;
> +
> +	scoped_guard(rwsem_read, &psy->extensions_sem) {
> +		power_supply_for_each_extension(reg, psy) {
> +			if (power_supply_ext_has_property(reg->ext,
> +							  POWER_SUPPLY_PROP_CHARGE_TYPES))
> +				return power_supply_charge_types_show(dev,
> +						reg->ext->charge_types,
> +						current_type, buf);
> +		}
> +	}
> +
> +	return power_supply_charge_types_show(dev, psy->desc->charge_types,
> +						  current_type, buf);
> +}
> +

Once the last external user of power_supply_charge_types_show() (dell-laptop)
is ported to become a power-supply extension, we should stop exporting
power_supply_charge_types_show(). The question then becomes do we just stop
exporting it; or do we remove it entirely ? My vote would go to remove it
entirely. This could be done if the above function were to directly call
power_supply_show_enum_with_available() instead of using the helper, e.g.:

static ssize_t power_supply_show_charge_types(struct device *dev,
					      struct power_supply *psy,
					      enum power_supply_charge_type current_type,
					      char *buf)
{
	struct power_supply_ext_registration *reg;

	scoped_guard(rwsem_read, &psy->extensions_sem) {
		power_supply_for_each_extension(reg, psy) {
			if (power_supply_ext_has_property(reg->ext,
							  POWER_SUPPLY_PROP_CHARGE_TYPES))
				return power_supply_show_enum_with_available(dev,
						POWER_SUPPLY_CHARGE_TYPE_TEXT,
						ARRAY_SIZE(POWER_SUPPLY_CHARGE_TYPE_TEXT),
						reg->ext->charge_types,
						current_type, buf);
		}
	}

	return power_supply_show_enum_with_available(dev, POWER_SUPPLY_CHARGE_TYPE_TEXT,
						     ARRAY_SIZE(POWER_SUPPLY_CHARGE_TYPE_TEXT),
						     psy->desc->charge_types, current_type, buf);
}

Since we already know we want to eventually remove power_supply_charge_types_show()
I think it would be better to write this as above right away.

Sebastian, Thomas any opinions on this ?

>  static ssize_t power_supply_format_property(struct device *dev,
>  					    bool uevent,
>  					    struct device_attribute *attr,
> @@ -365,7 +386,7 @@ static ssize_t power_supply_format_property(struct device *dev,
>  	case POWER_SUPPLY_PROP_CHARGE_TYPES:
>  		if (uevent) /* no possible values in uevents */
>  			goto default_format;
> -		ret = power_supply_charge_types_show(dev, psy->desc->charge_types,
> +		ret = power_supply_show_charge_types(dev, psy,
>  						     value.intval, buf);
>  		break;
>  	case POWER_SUPPLY_PROP_MODEL_NAME ... POWER_SUPPLY_PROP_SERIAL_NUMBER:
> diff --git a/drivers/power/supply/test_power.c b/drivers/power/supply/test_power.c
> index 2a975a110f48..0d9cc0c5613e 100644
> --- a/drivers/power/supply/test_power.c
> +++ b/drivers/power/supply/test_power.c
> @@ -37,6 +37,8 @@ static int battery_charge_counter	= -1000;
>  static int battery_current		= -1600;
>  static enum power_supply_charge_behaviour battery_charge_behaviour =
>  	POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO;
> +static enum power_supply_charge_type battery_charge_types =
> +	POWER_SUPPLY_CHARGE_TYPE_NONE;
>  static bool battery_extension;
>  
>  static bool module_initialized;
> @@ -87,7 +89,7 @@ static int test_power_get_battery_property(struct power_supply *psy,
>  		val->intval = battery_status;
>  		break;
>  	case POWER_SUPPLY_PROP_CHARGE_TYPE:
> -		val->intval = POWER_SUPPLY_CHARGE_TYPE_FAST;
> +		val->intval = battery_charge_types;
>  		break;
>  	case POWER_SUPPLY_PROP_HEALTH:
>  		val->intval = battery_health;
> @@ -129,6 +131,9 @@ static int test_power_get_battery_property(struct power_supply *psy,
>  	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
>  		val->intval = battery_charge_behaviour;
>  		break;
> +	case POWER_SUPPLY_PROP_CHARGE_TYPES:
> +		val->intval = battery_charge_types;
> +		break;
>  	default:
>  		pr_info("%s: some properties deliberately report errors.\n",
>  			__func__);
> @@ -140,7 +145,7 @@ static int test_power_get_battery_property(struct power_supply *psy,
>  static int test_power_battery_property_is_writeable(struct power_supply *psy,
>  						    enum power_supply_property psp)
>  {
> -	return psp == POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR;
> +	return psp == POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR | POWER_SUPPLY_PROP_CHARGE_TYPES;
>  }
>  
>  static int test_power_set_battery_property(struct power_supply *psy,
> @@ -156,6 +161,14 @@ static int test_power_set_battery_property(struct power_supply *psy,
>  		}
>  		battery_charge_behaviour = val->intval;
>  		break;
> +	case POWER_SUPPLY_PROP_CHARGE_TYPES:
> +		if (val->intval < 0 ||
> +		    val->intval >= BITS_PER_TYPE(typeof(psy->desc->charge_types)) ||
> +		    !(BIT(val->intval) & psy->desc->charge_types)) {
> +			return -EINVAL;
> +		}
> +		battery_charge_types = val->intval;
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -188,6 +201,7 @@ static enum power_supply_property test_power_battery_props[] = {
>  	POWER_SUPPLY_PROP_CURRENT_AVG,
>  	POWER_SUPPLY_PROP_CURRENT_NOW,
>  	POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR,
> +	POWER_SUPPLY_PROP_CHARGE_TYPES,
>  };
>  
>  static char *test_power_ac_supplied_to[] = {
> @@ -215,6 +229,8 @@ static const struct power_supply_desc test_power_desc[] = {
>  		.charge_behaviours = BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO)
>  				   | BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE)
>  				   | BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE),
> +		.charge_types = BIT(POWER_SUPPLY_CHARGE_TYPE_NONE)
> +				   | BIT(POWER_SUPPLY_CHARGE_TYPE_LONGLIFE)
>  	},
>  	[TEST_USB] = {
>  		.name = "test_usb",
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index 888824592953..c4cb854971f5 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -288,6 +288,7 @@ struct power_supply_desc {
>  struct power_supply_ext {
>  	const char *const name;
>  	u8 charge_behaviours;
> +	u32 charge_types;
>  	const enum power_supply_property *properties;
>  	size_t num_properties;
>  

Otherwise this patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


