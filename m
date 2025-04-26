Return-Path: <linux-pm+bounces-26268-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2605EA9DA5A
	for <lists+linux-pm@lfdr.de>; Sat, 26 Apr 2025 13:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A64D176AF7
	for <lists+linux-pm@lfdr.de>; Sat, 26 Apr 2025 11:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352F1226865;
	Sat, 26 Apr 2025 11:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RsiZSbbD"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8222253A5
	for <linux-pm@vger.kernel.org>; Sat, 26 Apr 2025 11:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745665753; cv=none; b=FePAuEmrEAO76EbFs7VgHZPVcORPqAdf4qEXn/OtmH7G+0Ym1mxfXRWmw6zhGJcAXiHa6kdBFuPdJzbKxJjubWrgTthCyeBjnBSlRtyVXmJoWtndCzTUDffPCcwDC91JoiApfCasfmn58Bn7CfoP9CIrGKAHSzS93H1jJdsedWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745665753; c=relaxed/simple;
	bh=UXxl8hSK1TuouiYf7DKLdc3mMGzmwoJ1FsBGNK4PyuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bJzyTUA8krsR7AAtmARgbvN9MikRWYF5U52s9IHrSBclOZyOfSMxiMxOrQH84YHS0pDIcSbTNbZV+j2WE3L23bBhUQ40SnPrnK31BCCpWK/utGd/B0s1jHKgBaNH27fIfgejvqWb/VIcogDM1++74LKvJULpxJErehzagPByvW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RsiZSbbD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745665748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7z4dFzfvb8ySvV/gweWyi1fm2nrOtc44d4j9ssf1utg=;
	b=RsiZSbbDfhVyDbsStdCJyeVHozvXuGGpGmjxLMlkiNsw4B8ZdqufgsKeiBmczVOXIeeCoV
	5SWoO8l0vr5/xgsDjoBKT94WWrzEqqJlBTsoDRnvN4F/eqle300h4AmWS7sxxUknAHIfyA
	bDuZxSoP71ElLY8+4UmCE4o5y48jcLM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-Ld0R7-0EMpS8vQQ5zKAe_w-1; Sat, 26 Apr 2025 07:09:06 -0400
X-MC-Unique: Ld0R7-0EMpS8vQQ5zKAe_w-1
X-Mimecast-MFC-AGG-ID: Ld0R7-0EMpS8vQQ5zKAe_w_1745665745
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-acb5a03afdcso260138766b.3
        for <linux-pm@vger.kernel.org>; Sat, 26 Apr 2025 04:09:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745665744; x=1746270544;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7z4dFzfvb8ySvV/gweWyi1fm2nrOtc44d4j9ssf1utg=;
        b=JYjXFS7HHQh0z2XbHK5XpMhMW9BZ6bSCJXZNOPwUgcvp7M+T8lquBCN7/nWEhbH6LA
         9xBCayyr4N3HWmXp5PC5caOx15OCOUwmPlVu/T1az79EYff/0DcK8im1e3r1skiUfxiN
         GynR6XIocMoSSGihgpKvn/ZsPWpqfZCor2JCbw1TW7ipSIxBdIMpyXixD+fwkvz+Qkux
         goH5G8FbpEFi6t41fWKSs44cD3Az3620LcUmTO/R+yec1rdqwYWlwz0DKdZTjEpycs+o
         sbjVufXhCisJoeaSHZi8EJUKEHZrfqxfulIw5x+lNBeUO2VxtApTagESw8MhTzutaCrG
         IIeg==
X-Forwarded-Encrypted: i=1; AJvYcCVB6S933xzB/JOvh/6tKqEERfdGI60CV5IHFvkumPyqtdNC9jYFvxX2PfX6bXGcpIVceIhrQXFflw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxnR9EDyqR8QFHwo01L/ZDilWJdqhwjUqwBbES3Fv+VPjMepCcq
	6xSn2ei3zw0psPO2wKYseJLPpe4y7c7F5QgnueXWx7c8j27ODOdvv5N64ak5u3e51enR3d6LQfR
	n6mdj0n6tZA+n/e90fcZXdUr/wC1fmAGwIFsberlf/ma2H/OnmsrNXRtOYydkK4Ae
X-Gm-Gg: ASbGncsmjqq0DMjkRwb1Jl4nmL7vCkSjDm8kRlkrgV5/c7ago0zm5vGQNuFRVcrZfNa
	hwQXN5cxHNn8Z1QOAMGBc5fQw38cSZeKsVk6XIwHcyhOsznZBAqXbiVvTDAe3oUycLE73/ECl8T
	C9aq6tZ0X8InRrExR0/Z7Ls7GHXHD8sf2M+W7SNPYVSaHzi5pS8JegI4dE+jGj6WWP5ASWyZu4v
	DrKRsADX7WBWJQX6QXMDJTFBXPF70adcwMYqem38BRSjWA4Pqgl21L+TKV7nTlg3STdLLxK9bSG
	mg/yMTNSpoIvH4nWq29q6KnZ/y6in7Ym+onIVZw5lQtANQ/5iV8G5eaeO0oQEhGWUW+N7iYogvp
	6PtpzfY6jtTWr9XqoAfVlYvNgSLKzT7pko/NHLTaxPVV2vZI+Qwtev95zhauSNg==
X-Received: by 2002:a17:907:1c0d:b0:aca:aeb4:9bd6 with SMTP id a640c23a62f3a-ace710377dcmr612317866b.10.1745665744220;
        Sat, 26 Apr 2025 04:09:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE95r6Let4oOwnqtqnjgeYXA8WWJGEN2ecsznKI9AM0hby5iwzoaxzLW2oJKFj9DYTm2B3v4A==
X-Received: by 2002:a17:907:1c0d:b0:aca:aeb4:9bd6 with SMTP id a640c23a62f3a-ace710377dcmr612315766b.10.1745665743805;
        Sat, 26 Apr 2025 04:09:03 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6e4e7326sm279049266b.62.2025.04.26.04.09.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Apr 2025 04:09:03 -0700 (PDT)
Message-ID: <25b88c26-3141-433a-8dc7-59ea47615509@redhat.com>
Date: Sat, 26 Apr 2025 13:09:02 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] power: supply: support charge_types in extensions
To: Jelle van der Waa <jvanderwaa@redhat.com>,
 Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
References: <20250414131840.382756-1-jvanderwaa@redhat.com>
 <20250414131840.382756-2-jvanderwaa@redhat.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20250414131840.382756-2-jvanderwaa@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 14-Apr-25 3:18 PM, Jelle van der Waa wrote:
> Similar to charge_behaviour, charge_types is an enum option where
> reading the property shows the supported values, with the active value
> surrounded by brackets. To be able to use it with a power_supply
> extension a bitmask with the supported charge_Types values has to be
> added to power_supply_ext.
> 
> Signed-off-by: Jelle van der Waa <jvanderwaa@redhat.com>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

FWIW my Reviewed-by is still valid for this version.

Sebastian, can you pick this one up, or are you waiting for
the first power-supply extension driver which actually uses
this to show up ?

Because I think that Jelle might be waiting with posting
the first power-supply extension driver which actually uses
this until this is merged, which would be sort of a deadlock ...

Regards,

Hans




> ---
> V1->V2: clarified commit message, fix small logic error discovered by
> -Wparentheses and changed example charge_types to use Long
> Life/Standard.
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
> index 2a975a110f48..b5f148081c51 100644
> --- a/drivers/power/supply/test_power.c
> +++ b/drivers/power/supply/test_power.c
> @@ -37,6 +37,8 @@ static int battery_charge_counter	= -1000;
>  static int battery_current		= -1600;
>  static enum power_supply_charge_behaviour battery_charge_behaviour =
>  	POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO;
> +static enum power_supply_charge_type battery_charge_types =
> +	POWER_SUPPLY_CHARGE_TYPE_STANDARD;
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
> +	return psp == POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR || psp == POWER_SUPPLY_PROP_CHARGE_TYPES;
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
> +		.charge_types = BIT(POWER_SUPPLY_CHARGE_TYPE_STANDARD)
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


