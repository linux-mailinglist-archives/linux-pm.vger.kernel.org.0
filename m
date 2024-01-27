Return-Path: <linux-pm+bounces-2829-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1637983ED26
	for <lists+linux-pm@lfdr.de>; Sat, 27 Jan 2024 14:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 900261F226DF
	for <lists+linux-pm@lfdr.de>; Sat, 27 Jan 2024 13:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCF125569;
	Sat, 27 Jan 2024 13:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Em+RCRtm"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F181DDFF
	for <linux-pm@vger.kernel.org>; Sat, 27 Jan 2024 13:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706360792; cv=none; b=L20ch7XnzmNOM6P+4Domo17ZPTR70DdYuyRC+/AzBBIG/DE3jrb/a3XeqXs8UnGPGL6RK0WucYKcHgJOHPfcLFN+3NsG9Yo6LocPplN2crmkQZ05kqnzS4gKq9Z83xFIW3BIPfLyfloUuhRPAROd4pvVZGx7pk3i4wUj/kgyP5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706360792; c=relaxed/simple;
	bh=T2jkl6JeHcq8JAVkftbxTsEgbZoigbntE4Ixt9Z9k4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F2fiayDGpf1+yg2Bnip5ViVhsRui9r3JQSOrZdxN/OJNSFwwgcZv63maheIa+3kPC+hWpG93ecO5blem1vgIkUuYh/bmqsGnAtLThFRVUNkEdGNHFB/Gl7ZEkBcQCqaDhOUTfvhajp2d+s2UsQKAfw9aHvvp6M1KUMQOp+mSnPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Em+RCRtm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706360789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TlrvmaBks+F+BrW8suzgEkHSLBKnIwMlUfsIbhMTRoA=;
	b=Em+RCRtmy80xj8YxQpcJzZ5J/G2t4BqujKp35PLnKj+kDnfl0WboIKF9hj69QNrXNkyj2U
	reYArJW/RRFAIX2jvjwBfrc/ftylZtUidRRCNoBnpf8vY0NY/BAB2ivljejIQfV9mhv0+K
	4xYn9mmjsZ86P8+VMDMyT6bDUGJXncY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-OCQ0D4TLNS-EVbLoU3QP8g-1; Sat, 27 Jan 2024 08:06:27 -0500
X-MC-Unique: OCQ0D4TLNS-EVbLoU3QP8g-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40e40126031so16240785e9.0
        for <linux-pm@vger.kernel.org>; Sat, 27 Jan 2024 05:06:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706360785; x=1706965585;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TlrvmaBks+F+BrW8suzgEkHSLBKnIwMlUfsIbhMTRoA=;
        b=WhHlXWMJrt2DlD9i4E41YDB1KE4WRcn0tlUo/ZpSYljIzuRf2eNBShqTygTFmD28PA
         40XYK8y/AApRDsBIudaivkHvq/zuOeWJcb16mkmumWmNTp4HPfh70dCCLucc2ySn2uSq
         k/BtNuGD/U1DTFZQjJhnzeJbBEHXRAi856mebH+YvJsLrQEJ23dXImgS0d3SMfxl5CIK
         lCljz/uCPu8m6Qlv1sZYWlotzrN5Z/n6pXiZmxNu3gm82NzJKLvKctfKxEHuPnfVnzpd
         QZkkt/KiMzO7qDQ1II8c2AJaLz8Di8AOSNC92zwQcimzp4O5DfrPwTeldfr8VcLToB+0
         oIuA==
X-Gm-Message-State: AOJu0Yx1pZ57gJOJjlglbo023CA6lf0gMcIcZt5pZfCMoVWMDV5YjrOv
	RBwlXbszXi8V/D4MP6vp2BItNR91LxqKYtM2CzOpKKq8JnMguJZhovFo13qHv0WbLuotHdeOXdm
	iraU0dARBA8zgLofv1t0jsVkQ874+NUt7UrNmjlda+22AkDiSz1V69a/BwAkzn24L
X-Received: by 2002:a05:6000:1e1a:b0:33a:e61d:9b21 with SMTP id bj26-20020a0560001e1a00b0033ae61d9b21mr613799wrb.128.1706360785489;
        Sat, 27 Jan 2024 05:06:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFpK1kC633ksaQFKXoctRzM099CGcRF70LaT2JT3rFOR/IcC4siAGEoKLPIECfjEz3dvAI8ag==
X-Received: by 2002:a05:6000:1e1a:b0:33a:e61d:9b21 with SMTP id bj26-20020a0560001e1a00b0033ae61d9b21mr613786wrb.128.1706360785108;
        Sat, 27 Jan 2024 05:06:25 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id fx20-20020a170906b75400b00a34b15c5cedsm1759746ejb.170.2024.01.27.05.06.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jan 2024 05:06:24 -0800 (PST)
Message-ID: <7c09ad89-bd7a-4f2d-a5ff-87d34296670d@redhat.com>
Date: Sat, 27 Jan 2024 14:06:23 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] power: supply: axp288_charger: Add charge-inhibit
 support
To: Sebastian Reichel <sre@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org
References: <20240104183516.312044-1-hdegoede@redhat.com>
 <20240104183516.312044-3-hdegoede@redhat.com>
 <m665fuuwj77duku4zsr5a22tn2ml44dh6l4vldypfxeihwipvq@fsh7rigfvgxg>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <m665fuuwj77duku4zsr5a22tn2ml44dh6l4vldypfxeihwipvq@fsh7rigfvgxg>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Sebastian,

On 1/27/24 01:46, Sebastian Reichel wrote:
> Hello Hans,
> 
> On Thu, Jan 04, 2024 at 07:35:16PM +0100, Hans de Goede wrote:
>> Add charge-inhibit support by adding a rw status attribute and
>> inhibiting charging when "Not charging" or "Discharging"
>> is written to it.
>>
>> The userspace API with status being writable is a bit weird,
>> but this is already done this way in the following psy drivers:
>> axp20x_battery.c, bq24735-charger.c, bq25980_charger.c, ip5xxx_power.c,
>> rt9467-charger.c, rt9471.c.
> 
> We have since then added a new property for this:
> 
> POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR
> 
> That can have auto (0), inhibit charge (1) or force discharge (2).

Right I'm aware of that, but that is a property which so far
has only been used on batteries, not chargers. So putting it
on the charger would make things more complicated when
adding support for this property to say upower (which is
something which people are looking into to allow a fuel-gauge
calibration UI).

I did think about using this and then putting it in
the axp288_fuel_gauge.c driver where this IMHO would belong.

The problem is that the very same register bit is also toggled
on/off when plugging in an external charger, so the control of
the bit needs to stay in axp288_charger.c as is done in this
patch.

So one possible solution which I came up with when originally
preparing this series would be for axp288_charger.c to export a:

int axp288_charger_inhibit_charger(struct power_supply *psy, bool inhibit);

And then have axp288_fuel_gauge.c call
power_supply_get_by_name("axp288_charger");
and then call axp288_charger_inhibit_charger()
with on the retrieved "axp288_charger" psy.

And add a POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR prop
to the fuel-gauge/battery driver this way.

Putting a POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR prop directly on
the charger (type = POWER_SUPPLY_TYPE_USB) would be another option.
This would actually make sense based on the property having charge
in the name, but as mentioned so far we have only been using
POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR on type = POWER_SUPPLY_TYPE_BATTERY
supplies.

My own preference would be my first suggestion of exporting
axp288_charger_inhibit_charger() and adding
POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR on the battery/fuel-gauge
psy class device, so as to keep things consistent for userspace.

Regards,

Hans














> 
> Greetings,
> 
> -- Sebastian
> 
>> Note on systems with an AXP288 some (about 400mA depending on load)
>> current will be drawn from the battery when charging is disabled
>> even if there is an external power-supply which can provide all
>> the necessary current. So unfortunately one cannot simply disable
>> charging to keep the battery in good health when using a tablet
>> with an AXP288 permanently connected to an external power-supply.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  drivers/power/supply/axp288_charger.c | 43 +++++++++++++++++++++++++--
>>  1 file changed, 40 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
>> index a327933cfd6a..351431f3cf0e 100644
>> --- a/drivers/power/supply/axp288_charger.c
>> +++ b/drivers/power/supply/axp288_charger.c
>> @@ -2,7 +2,7 @@
>>  /*
>>   * axp288_charger.c - X-power AXP288 PMIC Charger driver
>>   *
>> - * Copyright (C) 2016-2017 Hans de Goede <hdegoede@redhat.com>
>> + * Copyright (C) 2016-2024 Hans de Goede <hdegoede@redhat.com>
>>   * Copyright (C) 2014 Intel Corporation
>>   * Author: Ramakrishna Pallala <ramakrishna.pallala@intel.com>
>>   */
>> @@ -148,6 +148,8 @@ struct axp288_chrg_info {
>>  	unsigned int op_mode;
>>  	unsigned int backend_control;
>>  	bool valid;
>> +	bool charge_enable;
>> +	bool charge_inhibit;
>>  };
>>  
>>  static inline int axp288_charger_set_cc(struct axp288_chrg_info *info, int cc)
>> @@ -285,9 +287,9 @@ static int axp288_charger_vbus_path_select(struct axp288_chrg_info *info,
>>  	return ret;
>>  }
>>  
>> -static int axp288_charger_enable_charger(struct axp288_chrg_info *info,
>> -								bool enable)
>> +static int axp288_charger_update_charge_en(struct axp288_chrg_info *info)
>>  {
>> +	bool enable = info->charge_enable && !info->charge_inhibit;
>>  	int ret;
>>  
>>  	if (enable)
>> @@ -302,6 +304,18 @@ static int axp288_charger_enable_charger(struct axp288_chrg_info *info,
>>  	return ret;
>>  }
>>  
>> +static int axp288_charger_enable_charger(struct axp288_chrg_info *info, bool enable)
>> +{
>> +	info->charge_enable = enable;
>> +	return axp288_charger_update_charge_en(info);
>> +}
>> +
>> +static int axp288_charger_inhibit_charger(struct axp288_chrg_info *info, bool inhibit)
>> +{
>> +	info->charge_inhibit = inhibit;
>> +	return axp288_charger_update_charge_en(info);
>> +}
>> +
>>  static int axp288_get_charger_health(struct axp288_chrg_info *info)
>>  {
>>  	if (!(info->input_status & PS_STAT_VBUS_PRESENT))
>> @@ -327,6 +341,19 @@ static int axp288_charger_usb_set_property(struct power_supply *psy,
>>  
>>  	mutex_lock(&info->lock);
>>  	switch (psp) {
>> +	case POWER_SUPPLY_PROP_STATUS:
>> +		switch (val->intval) {
>> +		case POWER_SUPPLY_STATUS_CHARGING:
>> +			ret = axp288_charger_inhibit_charger(info, false);
>> +			break;
>> +		case POWER_SUPPLY_STATUS_DISCHARGING:
>> +		case POWER_SUPPLY_STATUS_NOT_CHARGING:
>> +			ret = axp288_charger_inhibit_charger(info, true);
>> +			break;
>> +		default:
>> +			ret = -EINVAL;
>> +		}
>> +		break;
>>  	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
>>  		scaled_val = min(val->intval, info->max_cc);
>>  		scaled_val = DIV_ROUND_CLOSEST(scaled_val, 1000);
>> @@ -423,6 +450,14 @@ static int axp288_charger_usb_get_property(struct power_supply *psy,
>>  		goto out;
>>  
>>  	switch (psp) {
>> +	case POWER_SUPPLY_PROP_STATUS:
>> +		if (info->charge_enable && !info->charge_inhibit)
>> +			val->intval = POWER_SUPPLY_STATUS_CHARGING;
>> +		else if (info->charge_enable && info->charge_inhibit)
>> +			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
>> +		else /* !info->charge_enable && xxx */
>> +			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
>> +		break;
>>  	case POWER_SUPPLY_PROP_PRESENT:
>>  		/* Check for OTG case first */
>>  		if (info->otg.id_short) {
>> @@ -472,6 +507,7 @@ static int axp288_charger_property_is_writeable(struct power_supply *psy,
>>  	int ret;
>>  
>>  	switch (psp) {
>> +	case POWER_SUPPLY_PROP_STATUS:
>>  	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
>>  	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
>>  	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
>> @@ -485,6 +521,7 @@ static int axp288_charger_property_is_writeable(struct power_supply *psy,
>>  }
>>  
>>  static enum power_supply_property axp288_usb_props[] = {
>> +	POWER_SUPPLY_PROP_STATUS,
>>  	POWER_SUPPLY_PROP_PRESENT,
>>  	POWER_SUPPLY_PROP_ONLINE,
>>  	POWER_SUPPLY_PROP_TYPE,
>> -- 
>> 2.43.0
>>
>>


