Return-Path: <linux-pm+bounces-7447-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86ECC8B9C27
	for <lists+linux-pm@lfdr.de>; Thu,  2 May 2024 16:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 019491F24D3E
	for <lists+linux-pm@lfdr.de>; Thu,  2 May 2024 14:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7C713C808;
	Thu,  2 May 2024 14:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fp/WHmhD"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E4F13C697
	for <linux-pm@vger.kernel.org>; Thu,  2 May 2024 14:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714659369; cv=none; b=gpaf3swoNYt+dbaS4248+LD7a/sCJpxAbgkqfzmf2FTXxufQKBdGrbkJ+1aR3PPZMasZ/kZ4yz0o6IGrTlS2I0W9GHSrDJ15ibNUPgaca9RcZqrwdK5hm2DeH/IBMJeQBV+nJ75wGAB5p0frS7ctIe4jRr7vf/n5Aq1KLBtHWp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714659369; c=relaxed/simple;
	bh=YEcAj8srd3V75btjipe3KsaEaAYXfQhZuT8tqv5/w5o=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=TeGl1iUUilPoN+Zx9oA6n/h/Qsfnlzbei2pXK23fPLrhfBGSX5xLphDpIRmo9qz18MhcyZlfQOHLZJiHVkeHg8HLZ4IBcivkrosLxBvTOOik38az9Z5RgMSpwSziY+sjpnSBLF6S+ggDVPWJbybNZsWHEbqQknY11RcCz+mfcmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fp/WHmhD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714659367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sZ4UzRIIGK2aOiAwEqLKI181g7DFssC7VDcdyml65wE=;
	b=fp/WHmhD9BvJjlxuVmVNJcLU6OuViYr7prcsImmny8j99zcp+Ok2v58M+bKJhJWixOV+Y7
	RA+v3lxDTDaptL2uXx8j2JoxYyos+QRXhfkFcwn+dj0pf7zWUVK8TjEvrsMAVsp3hyJRwf
	i24/JHStwgVD+lcUrZ3xVoYbyPGKphI=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-3vyqDBKXOgCPQKrGbmGYag-1; Thu, 02 May 2024 10:16:03 -0400
X-MC-Unique: 3vyqDBKXOgCPQKrGbmGYag-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-51ad9e780f5so6249343e87.1
        for <linux-pm@vger.kernel.org>; Thu, 02 May 2024 07:16:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714659362; x=1715264162;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sZ4UzRIIGK2aOiAwEqLKI181g7DFssC7VDcdyml65wE=;
        b=l1hw9rYE68YaMqFu83Mji3GFu/FDLldCT25n4wRhZ5Z2si/FxQrBSQbSRC55qpwctQ
         JVNVNboLGaEt2y/YLtc58f4vFvv7mqu/gPG8EW17p7XS9Gl23vbL0+9TgtpCVempfaf5
         GeY3htsp0PdpcS3CuHVVtT4xNPDnT6by0fbsJCOgFt1cL0cO2YA1s0jUm7bZe7eiZXwE
         Ak9VqmnikTcFvb3vN2gjUMZLM9vLuYWLJmCs2nYl+OGm2pc7KKqUlrfE+1ubs8X2v9Sf
         WCGsCMv+AYq4/979rJ5poCx51KPNnbTbtT/m62fX+YZJtVYSLzgNqtUGc0cOi/Ap+9mh
         BwcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsKKvjcDogPxc64+Z8hyoPwzuX7ku6DN1oPzBBLcx/BPiOzRqKx3ItzVBvgA4NeBHfsO5gOyvDYmGWDn/tjSnJlEv1QK9f/ww=
X-Gm-Message-State: AOJu0Yys6SxA/8GZvTu015meHa7n/zeDckKED/isOr4wPK+dLPVgi6SQ
	ACJViQOd5bIXi8VTsUvVxRM3Wq1/j1DYFodgqOZUmNWuCc0J8prjkkxCl/yQGelVRHQK8Kgd8L6
	4+gFMv+B4/2uUpm6P+DGfd/GdJGeXViFk2m4UMPqAx9rE50p548ulwkFS
X-Received: by 2002:a19:5f1c:0:b0:519:6e94:9b4d with SMTP id t28-20020a195f1c000000b005196e949b4dmr1316932lfb.48.1714659361761;
        Thu, 02 May 2024 07:16:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGFKqwUL1G8AwHkaR8dNSc8/1vDp6htw2RRNOnHE8EcC9/aV65GJ1AZT+8k5GT9Cm0uLNabw==
X-Received: by 2002:a19:5f1c:0:b0:519:6e94:9b4d with SMTP id t28-20020a195f1c000000b005196e949b4dmr1316910lfb.48.1714659361249;
        Thu, 02 May 2024 07:16:01 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id y8-20020a170906070800b00a5889ee66d6sm607104ejb.45.2024.05.02.07.16.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 07:16:00 -0700 (PDT)
Message-ID: <4e0dfa1b-3712-430f-a97d-f4763c2740e5@redhat.com>
Date: Thu, 2 May 2024 16:15:59 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/6] power: supply: power-supply-leds: Add
 charging_orange_full_green trigger for RGB LED
From: Hans de Goede <hdegoede@redhat.com>
To: Kate Hsuan <hpa@redhat.com>, Pavel Machek <pavel@ucw.cz>,
 Lee Jones <lee@kernel.org>, linux-leds@vger.kernel.org,
 platform-driver-x86@vger.kernel.org,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 =?UTF-8?Q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>,
 linux-kernel@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>,
 Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20240424065212.263784-1-hpa@redhat.com>
 <20240424065212.263784-6-hpa@redhat.com>
 <6c692ae4-e78a-441d-8487-71a6ad4a4ed8@redhat.com>
Content-Language: en-US, nl
In-Reply-To: <6c692ae4-e78a-441d-8487-71a6ad4a4ed8@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 4/29/24 1:10 PM, Hans de Goede wrote:
> Hi,
> 
> On 4/24/24 8:52 AM, Kate Hsuan wrote:
>> Add a charging_orange_full_green LED trigger and the trigger is based on
>> led_mc_trigger_event() which can set an RGB LED when the trigger is
>> triggered. The LED will show orange when the battery status is charging.
>> The LED will show green when the battery status is full.
>>
>> Link: https://lore.kernel.org/linux-leds/f40a0b1a-ceac-e269-c2dd-0158c5b4a1ad@gmail.com/
>>
>> Signed-off-by: Kate Hsuan <hpa@redhat.com>
>> Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> 
> Thanks, patch looks good to me:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

I withdraw this I just noticed that this:

+	unsigned int intensity_green[3] = {255, 0, 0};
+	unsigned int intensity_orange[3] = {128, 0, 255};

Is based on the color order being "green blue red" which
is a pretty exotic color order. The device tree / fwnode bindings
for the ktd2026 with which we are using this allow changing
the order to red green blue simply by listing the child cells
for each color in that order.

Also this:

+	unsigned int intensity_red[3] = {0, 0, 255};

is not necessary since it is only used with LED_OFF
as brightness the code can simply use:

	led_trigger_event(psy->charging_orange_full_green_trig, LED_OFF);

to turn the LED off.

I'll prepare a new version of this series with this fixed.

Regards,

Hans




>> ---
>>  drivers/power/supply/power_supply_leds.c | 26 ++++++++++++++++++++++++
>>  include/linux/power_supply.h             |  2 ++
>>  2 files changed, 28 insertions(+)
>>
>> diff --git a/drivers/power/supply/power_supply_leds.c b/drivers/power/supply/power_supply_leds.c
>> index c7db29d5fcb8..8dd99199c65b 100644
>> --- a/drivers/power/supply/power_supply_leds.c
>> +++ b/drivers/power/supply/power_supply_leds.c
>> @@ -22,6 +22,9 @@
>>  static void power_supply_update_bat_leds(struct power_supply *psy)
>>  {
>>  	union power_supply_propval status;
>> +	unsigned int intensity_green[3] = {255, 0, 0};
>> +	unsigned int intensity_orange[3] = {128, 0, 255};
>> +	unsigned int intensity_red[3] = {0, 0, 255};
>>  
>>  	if (power_supply_get_property(psy, POWER_SUPPLY_PROP_STATUS, &status))
>>  		return;
>> @@ -36,12 +39,20 @@ static void power_supply_update_bat_leds(struct power_supply *psy)
>>  		/* Going from blink to LED on requires a LED_OFF event to stop blink */
>>  		led_trigger_event(psy->charging_blink_full_solid_trig, LED_OFF);
>>  		led_trigger_event(psy->charging_blink_full_solid_trig, LED_FULL);
>> +		led_mc_trigger_event(psy->charging_orange_full_green_trig,
>> +				     intensity_green,
>> +				     ARRAY_SIZE(intensity_green),
>> +				     LED_FULL);
>>  		break;
>>  	case POWER_SUPPLY_STATUS_CHARGING:
>>  		led_trigger_event(psy->charging_full_trig, LED_FULL);
>>  		led_trigger_event(psy->charging_trig, LED_FULL);
>>  		led_trigger_event(psy->full_trig, LED_OFF);
>>  		led_trigger_blink(psy->charging_blink_full_solid_trig, 0, 0);
>> +		led_mc_trigger_event(psy->charging_orange_full_green_trig,
>> +				     intensity_orange,
>> +				     ARRAY_SIZE(intensity_orange),
>> +				     LED_FULL);
>>  		break;
>>  	default:
>>  		led_trigger_event(psy->charging_full_trig, LED_OFF);
>> @@ -49,6 +60,10 @@ static void power_supply_update_bat_leds(struct power_supply *psy)
>>  		led_trigger_event(psy->full_trig, LED_OFF);
>>  		led_trigger_event(psy->charging_blink_full_solid_trig,
>>  			LED_OFF);
>> +		led_mc_trigger_event(psy->charging_orange_full_green_trig,
>> +				     intensity_red,
>> +				     ARRAY_SIZE(intensity_red),
>> +				     LED_OFF);
>>  		break;
>>  	}
>>  }
>> @@ -74,6 +89,11 @@ static int power_supply_create_bat_triggers(struct power_supply *psy)
>>  	if (!psy->charging_blink_full_solid_trig_name)
>>  		goto charging_blink_full_solid_failed;
>>  
>> +	psy->charging_orange_full_green_trig_name = kasprintf(GFP_KERNEL,
>> +		"%s-charging-orange-full-green", psy->desc->name);
>> +	if (!psy->charging_orange_full_green_trig_name)
>> +		goto charging_red_full_green_failed;
>> +
>>  	led_trigger_register_simple(psy->charging_full_trig_name,
>>  				    &psy->charging_full_trig);
>>  	led_trigger_register_simple(psy->charging_trig_name,
>> @@ -82,9 +102,13 @@ static int power_supply_create_bat_triggers(struct power_supply *psy)
>>  				    &psy->full_trig);
>>  	led_trigger_register_simple(psy->charging_blink_full_solid_trig_name,
>>  				    &psy->charging_blink_full_solid_trig);
>> +	led_trigger_register_simple(psy->charging_orange_full_green_trig_name,
>> +				    &psy->charging_orange_full_green_trig);
>>  
>>  	return 0;
>>  
>> +charging_red_full_green_failed:
>> +	kfree(psy->charging_blink_full_solid_trig_name);
>>  charging_blink_full_solid_failed:
>>  	kfree(psy->full_trig_name);
>>  full_failed:
>> @@ -101,10 +125,12 @@ static void power_supply_remove_bat_triggers(struct power_supply *psy)
>>  	led_trigger_unregister_simple(psy->charging_trig);
>>  	led_trigger_unregister_simple(psy->full_trig);
>>  	led_trigger_unregister_simple(psy->charging_blink_full_solid_trig);
>> +	led_trigger_unregister_simple(psy->charging_orange_full_green_trig);
>>  	kfree(psy->charging_blink_full_solid_trig_name);
>>  	kfree(psy->full_trig_name);
>>  	kfree(psy->charging_trig_name);
>>  	kfree(psy->charging_full_trig_name);
>> +	kfree(psy->charging_orange_full_green_trig_name);
>>  }
>>  
>>  /* Generated power specific LEDs triggers. */
>> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
>> index c0992a77feea..9b6898085224 100644
>> --- a/include/linux/power_supply.h
>> +++ b/include/linux/power_supply.h
>> @@ -318,6 +318,8 @@ struct power_supply {
>>  	char *online_trig_name;
>>  	struct led_trigger *charging_blink_full_solid_trig;
>>  	char *charging_blink_full_solid_trig_name;
>> +	struct led_trigger *charging_orange_full_green_trig;
>> +	char *charging_orange_full_green_trig_name;
>>  #endif
>>  };
>>  


