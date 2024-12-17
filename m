Return-Path: <linux-pm+bounces-19376-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B41AA9F4F3E
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2024 16:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 414BA1882B72
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2024 15:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D981F707C;
	Tue, 17 Dec 2024 15:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g//tTu2u"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98D01F6671
	for <linux-pm@vger.kernel.org>; Tue, 17 Dec 2024 15:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734448736; cv=none; b=nTKpHxH/UJ3frYiAKUidcH8JBG3i4P22p5Y6MYYV9quRuQHQkszkn5fg6dFYp+Rhx4vywfV+lcK80cuA8JXlljY4dZQYa2jmUnPNEDJXwLNsv5bPrPs95f24J3VhgJ7rrTSCzlaYKIHHZCTvorw8CZ5pFtoCZVVSiQgQrhWbWlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734448736; c=relaxed/simple;
	bh=kevnlIu4qigmWwTaQmWmuADC2YOcbyjDZNvYWUnCkmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a7jLfmrNVT7qIbG6ABKnOhEsSvkEdzvjSJkgqay/YPPWGg5SrkV4dQo2xMsZN0Gj86QIIfDXibTsdpsEtDOYY82wW7C+FgzRyh+mA0vZs8scmZCUXofY9ecwpN0vfVyUPaJTKhYCM63szLnW4ostl/cIJbmvg/KNeHy/DlSDE7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g//tTu2u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734448733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xq101dymicO3ny9c58AOyV/yGv8BITs7F2tAWV4ri14=;
	b=g//tTu2uYl23H31rec43nybCH95LmVw30s4e+dd2BxTTdAVLMiHMQ4vt3X0uR5hoUOTJmh
	QyJcHcGR28lFAWYayvB3KMiAcl6pCICK51B+grhZ0yI3di2qqpwGI8tmL2RRqT73BCbIe8
	hla4PHzCa4andgXrtgGRABAaTr+dRKc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-MrLNmhfRNB2OcvZr7xpdog-1; Tue, 17 Dec 2024 10:18:52 -0500
X-MC-Unique: MrLNmhfRNB2OcvZr7xpdog-1
X-Mimecast-MFC-AGG-ID: MrLNmhfRNB2OcvZr7xpdog
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-aa66ab24344so223035766b.3
        for <linux-pm@vger.kernel.org>; Tue, 17 Dec 2024 07:18:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734448730; x=1735053530;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xq101dymicO3ny9c58AOyV/yGv8BITs7F2tAWV4ri14=;
        b=oOW9mQsttYNuorjMIaIYJHDfwlNEKZ1tBUPsdXoUs3oID74uMREeHfPPP6E2icZRdR
         C5uaagTbZDMj/ckXlNsFH3WubMRl2NBrlBNt/oW6irBGYT9BjZRyIvgmIrSXZsBpnpML
         VuGEBoj+8qaefa9PrJiLlaz0nFAcwCyh7khiJQp6aFAYr33TAW4ROndEOoFYL9ioqOhO
         wAS8KDaBdZG6WrM+Bn/vhAbL2jJOdeSDgfkcnmQ5QBkdo2CGUaqQHRFIyXYTRjdIo1nu
         AYbEIgsSblMUtO/xkLHT52kx058qlHra/mwtuR54RWeOS+CDx7am2zrInapw1DKgpui6
         ijsw==
X-Forwarded-Encrypted: i=1; AJvYcCWG2JwTeXln+/oj9umoT6yfZcIVDtAP6sq1HQGmsoArLvPGTUa2Klmo9qdjG9tRfK5Ch2CLz+iuOA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXenI07sEqo7o3PoF7bh/mvFTNfY03HHN9GbRXci1t4fT6guqq
	KY8vquwFM0aFGQ5cQo/hl49iz2V2p92TAh3lyFFHEBVCt+NzmOQz6d2ChgEXKcPDkAC7tyAumxW
	4IT14l/+C/o2aZhA1lmHO7gF/B3uiodW4o+58J2rySHHjBHhoC/sYH00h
X-Gm-Gg: ASbGnctELrnELjx2h9icdoayxAHyELEU02lbRZy8KDyFhWQcdCxETUVaSxpE3zUoB3U
	DtWVShOSaEbcGvWEsPELWOcYwPQKU4ZYG+KbwJGpS52QbDf4jg1Yq3GyRIhOGD+75aA49UQ/e0B
	+3+w/FBEUZd2tkM4mFchZ+plEI/QgWUidYycGOIcvC1S8aPJw2TUpvHmXcD5jJKx2HHjwbM5B+G
	M4M/CTjDtyGN3F/F11Rr09OGCqlEC4PAdJfXIIswChs6Lv+pp9XqCtdgiGQDz4O
X-Received: by 2002:a17:906:32ce:b0:aa6:77e6:ea3d with SMTP id a640c23a62f3a-aab77e7b4d0mr1482682266b.45.1734448730094;
        Tue, 17 Dec 2024 07:18:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkrZjicTe172QHbDlkwxpry2Ghax4PvnFFbFyd1/WzbGOAXOHkiXLeWDlmR19lCHTa+y3KFQ==
X-Received: by 2002:a17:906:32ce:b0:aa6:77e6:ea3d with SMTP id a640c23a62f3a-aab77e7b4d0mr1482679566b.45.1734448729654;
        Tue, 17 Dec 2024 07:18:49 -0800 (PST)
Received: from [192.168.162.203] ([109.36.231.174])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab96068988sm462807966b.62.2024.12.17.07.18.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 07:18:49 -0800 (PST)
Message-ID: <6760c9d3-ccf4-47de-bfe5-b59b8b9fca07@redhat.com>
Date: Tue, 17 Dec 2024 16:18:47 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] platform/x86: dell-laptop: Use
 power_supply_charge_types_show/_parse() helpers
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Andy Shevchenko <andy@kernel.org>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?=
 <linux@weissschuh.net>, Sebastian Reichel <sre@kernel.org>,
 Jelle van der Waa <jelle@vdwaa.nl>, platform-driver-x86@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20241211174451.355421-1-hdegoede@redhat.com>
 <20241211174451.355421-5-hdegoede@redhat.com>
 <0030c3dd-c70c-d21b-de2b-ace0aeb4030d@linux.intel.com>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <0030c3dd-c70c-d21b-de2b-ace0aeb4030d@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 17-Dec-24 1:01 PM, Ilpo Järvinen wrote:
> On Wed, 11 Dec 2024, Hans de Goede wrote:
> 
>> Make battery_modes a map between tokens and enum power_supply_charge_type
>> values instead of between tokens and strings and use the new
>> power_supply_charge_types_show/_parse() helpers for show()/store()
>> to ensure that things are handled in the same way as in other drivers.
>>
>> This also changes battery_supported_modes to be a bitmap of charge-types
>> (enum power_supply_charge_type values) rather then a bitmap of indices
>> into battery_modes[].
>>
>> Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  drivers/platform/x86/dell/dell-laptop.c | 54 ++++++++++++-------------
>>  1 file changed, 25 insertions(+), 29 deletions(-)
>>
>> diff --git a/drivers/platform/x86/dell/dell-laptop.c b/drivers/platform/x86/dell/dell-laptop.c
>> index 5671bd0deee7..9a4cfcb8bbe0 100644
>> --- a/drivers/platform/x86/dell/dell-laptop.c
>> +++ b/drivers/platform/x86/dell/dell-laptop.c
>> @@ -103,15 +103,15 @@ static bool mute_led_registered;
>>  
>>  struct battery_mode_info {
>>  	int token;
>> -	const char *label;
>> +	enum power_supply_charge_type charge_type;
>>  };
>>  
>>  static const struct battery_mode_info battery_modes[] = {
>> -	{ BAT_PRI_AC_MODE_TOKEN,   "Trickle" },
>> -	{ BAT_EXPRESS_MODE_TOKEN,  "Fast" },
>> -	{ BAT_STANDARD_MODE_TOKEN, "Standard" },
>> -	{ BAT_ADAPTIVE_MODE_TOKEN, "Adaptive" },
>> -	{ BAT_CUSTOM_MODE_TOKEN,   "Custom" },
>> +	{ BAT_PRI_AC_MODE_TOKEN,   POWER_SUPPLY_CHARGE_TYPE_TRICKLE },
>> +	{ BAT_EXPRESS_MODE_TOKEN,  POWER_SUPPLY_CHARGE_TYPE_FAST },
>> +	{ BAT_STANDARD_MODE_TOKEN, POWER_SUPPLY_CHARGE_TYPE_STANDARD },
>> +	{ BAT_ADAPTIVE_MODE_TOKEN, POWER_SUPPLY_CHARGE_TYPE_ADAPTIVE },
>> +	{ BAT_CUSTOM_MODE_TOKEN,   POWER_SUPPLY_CHARGE_TYPE_CUSTOM },
>>  };
>>  static u32 battery_supported_modes;
>>  
>> @@ -2261,46 +2261,42 @@ static ssize_t charge_types_show(struct device *dev,
>>  		struct device_attribute *attr,
>>  		char *buf)
>>  {
>> -	ssize_t count = 0;
>> +	enum power_supply_charge_type charge_type;
>>  	int i;
>>  
>>  	for (i = 0; i < ARRAY_SIZE(battery_modes); i++) {
>> -		bool active;
>> +		charge_type = battery_modes[i].charge_type;
>>  
>> -		if (!(battery_supported_modes & BIT(i)))
>> +		if (!(battery_supported_modes & BIT(charge_type)))
>>  			continue;
>>  
>> -		active = dell_battery_mode_is_active(battery_modes[i].token);
>> -		count += sysfs_emit_at(buf, count, active ? "[%s] " : "%s ",
>> -				battery_modes[i].label);
>> +		if (!dell_battery_mode_is_active(battery_modes[i].token))
>> +			continue;
>> +
>> +		return power_supply_charge_types_show(dev, battery_supported_modes,
>> +						      charge_type, buf);
>>  	}
>>  
>> -	/* convert the last space to a newline */
>> -	if (count > 0)
>> -		count--;
>> -	count += sysfs_emit_at(buf, count, "\n");
>> -
>> -	return count;
>> +	/* No active mode found */
>> +	return -EIO;
>>  }
>>  
>>  static ssize_t charge_types_store(struct device *dev,
>>  		struct device_attribute *attr,
>>  		const char *buf, size_t size)
>>  {
>> -	bool matched = false;
>> -	int err, i;
>> +	int charge_type, err, i;
>> +
>> +	charge_type = power_supply_charge_types_parse(battery_supported_modes, buf);
>> +	if (charge_type < 0)
>> +		return charge_type;
>>  
>>  	for (i = 0; i < ARRAY_SIZE(battery_modes); i++) {
>> -		if (!(battery_supported_modes & BIT(i)))
>> -			continue;
>> -
>> -		if (sysfs_streq(battery_modes[i].label, buf)) {
>> -			matched = true;
>> +		if (battery_modes[i].charge_type == charge_type)
>>  			break;
>> -		}
>>  	}
>> -	if (!matched)
>> -		return -EINVAL;
>> +	if (i == ARRAY_SIZE(battery_modes))
>> +		return -EIO;
> 
> Hi Hans,
> 
> Is this errno change helpful/correct?

power_supply_charge_types_parse() already checks that the user-input
is one of the values advertised in the passed in battery_supported_modes,
so when we loop to translate the enum power_supply_charge_type value
returned by power_supply_charge_types_parse() then we should find
a matching entry in battery_modes[] if not something is wrong at
the driver level. So not -EINVAL, since this is a driver issue not
a user input issue.

> There is zero I/O done before 
> reaching this point, just input validation, so why does it return errno 
> that is "I/O error"? If you want to differentiate from -EINVAL, I suggest 
> using -ENOENT (but I personally think -EINVAL would be fine as well 
> because it's still an invalid argument even if it passed one stage of 
> the input checks).

-ENOENT instead of -EIO works for me.

Shall I send out a new version with that changed?

Note that merging this requires the earlier patches from this
series which have been merged into:

https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git/log/?h=for-next

so this either requires an immutable tag from Sebastian for you to merge,
or this should be merged through Sebastian's tree.

Regards,

Hans



