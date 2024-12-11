Return-Path: <linux-pm+bounces-19037-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 731CB9ED0EA
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 17:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1765528E5A6
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 16:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2C41D9A50;
	Wed, 11 Dec 2024 16:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XD4dFt2p"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A6419F471
	for <linux-pm@vger.kernel.org>; Wed, 11 Dec 2024 16:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733933515; cv=none; b=e6J9lTmzYSXIC2YRZjVNTeNCUKZGoHnvz03JADDeUrVZdNCVTlpu4NnIB2aEDSPfuBRQ+E7YXF8jzQ0DHh3ONB0jOH4RDjkJmvasliP9Jb/d9LSDjHotolHvEmliNIhkfTkjnEuOoHVtZQ0MDFXxr5DszGHW94b44j70KlZHxOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733933515; c=relaxed/simple;
	bh=WhBijUHpTxJZ1H7HPQ7nhAgAH3Z9mL6B2lVx4lMN9jU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CUpseBZ1x2yoZeT5HP5vccV7wT6TEqnnUk4xhU8KVmFAuw8voA5qrGm2siNIYC1nb9ZmGL2giEkI8yLFaefdaBCnwmiJrHeiKkniyV3+UP+quAYYvIuVC5C039VygyK8PrFjkCAVy556/DPsGqbbgHeOkJMoA3Q8HXsGXJ4Oo34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XD4dFt2p; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733933513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZN8vHGiR2okTDuCeNuzLSyM2kRbk+d8ifjg0Um0z2+k=;
	b=XD4dFt2pCBqocvPr3t1BrRu/Bbsx7kyV+5uFpzol1f0wo4HJRQ89gSOaTlehH9uyC1KbLQ
	KaSRYaHNB7gUctJ5SYeThTVR3XqkqWWHSabqGXU39Mv+fTmZ4k9c+96vshSyJnALPN9hOy
	i5yNzD8AACbfE4Hsuk686Vtat64gT5o=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-HjT4LXRTNCWLPr5pivS1qw-1; Wed, 11 Dec 2024 11:11:51 -0500
X-MC-Unique: HjT4LXRTNCWLPr5pivS1qw-1
X-Mimecast-MFC-AGG-ID: HjT4LXRTNCWLPr5pivS1qw
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-aa6a3367fd1so215079866b.3
        for <linux-pm@vger.kernel.org>; Wed, 11 Dec 2024 08:11:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733933510; x=1734538310;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZN8vHGiR2okTDuCeNuzLSyM2kRbk+d8ifjg0Um0z2+k=;
        b=slK16aLj+BLq+AZl1fcp5XbwVXYC/fZSOWOiIBmzNkvwPeLN4oQEELgJh9+r/mPeil
         wQ1VwuAumHb4GNPaut4d4h3ZCdLmE82HbSbKJhx8BPUdJSdcRj3pO9GqV0DanQ1G/uZO
         Wj1DcrF7LtGvso2p+f+te3tu2EyElC1TXpnAayEdmXlBM4oWWqhB0GN3ObHztQ/xDnZW
         PvRJRfzP0YDgyNNK5Ao3nw4bVeq0ZgT4sPLRqdvUU6yyZL2lmD/mi0Tv+YOxd3R7hUNp
         /iJ40RwQgWfuIPDCQkH/9QaEGMSavVNCujZF57nBEuFeiU+EYXnAiLCGnXrk0uhwiID9
         67tA==
X-Forwarded-Encrypted: i=1; AJvYcCXiJ3KTA/VfX/6elISrVqz3srB22wK+bsoVF+FtbJ/gUKdAUI2KpXSsXQQv0lL7ul7XP8l3tlFUVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2xuJWRNgdEK4Pr54oUR2vZJ5TK2UGoOvSHohwhEHfL/AtZFU+
	myXU2u5TXuCA7eKLiJ0crkFUCYYQiSL/6gpTxJeBtfhIApt7InWV/ZWLzbghjYeaZYB386T7j8Q
	rFwGLtMVNUrSGBGgJfOds6ebvOuNV4LV0bm4r9x96SBZLd3oOJRNOHpRI
X-Gm-Gg: ASbGnct/BaDiAcQShdS+hzwMYHQdmvK8LLGgEAAvsqzEye/0ApSFICBKonVfqbmoveo
	LP9hGremFL4Lt6/b25CJFyCnMWpO09zNe8fvyTOZZahSJFDrA6NZAMRNW+WgdLJE5l0tQnYOx67
	oJ4Ji/L8JbHgM+7gKrepHFDPLtSGrqVkz7ZcwckE1BdMFOpkWHgceW9QLuCT7uefzqyr1gtlzNl
	P1QsA1FuRStlz5Hlf/vVBD2djAyw19U8e38L1dNst1OiUBAn6UPrmYXxpIvcMEIeHfQoIqq8JXG
	cu9CdNidB5+JY/WYDoWkTl56WkQHY6JM1YOIsv9GbxwLVvCOM+FijJ7eQwbSzluS4EnVkVh6F/C
	5bc8o197gqyHSlPYheh/e51FeEGVq
X-Received: by 2002:a17:906:3190:b0:aa6:851d:af4d with SMTP id a640c23a62f3a-aa6b115b2bcmr234591966b.21.1733933510444;
        Wed, 11 Dec 2024 08:11:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFeMcdeaCwcEe+AaaUi17mMfcF2euU0L/cWYEDHTSrxjvY27bas3CgrcmdOM9vh4LwYgJl9xw==
X-Received: by 2002:a17:906:3190:b0:aa6:851d:af4d with SMTP id a640c23a62f3a-aa6b115b2bcmr234589666b.21.1733933509980;
        Wed, 11 Dec 2024 08:11:49 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa673474d96sm601893666b.96.2024.12.11.08.11.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 08:11:49 -0800 (PST)
Message-ID: <e30dec47-724d-48fb-8ffa-1e73a7f53f64@redhat.com>
Date: Wed, 11 Dec 2024 17:11:49 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] power: supply: core: Add new "charge_types"
 property
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Andy Shevchenko <andy@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 platform-driver-x86@vger.kernel.org, Jelle van der Waa <jelle@vdwaa.nl>,
 linux-pm@vger.kernel.org
References: <20241209204051.8786-1-hdegoede@redhat.com>
 <20241209204051.8786-3-hdegoede@redhat.com>
 <9aa6ad55-d0c3-4cdc-82a9-0c3906f77f30@t-8ch.de>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <9aa6ad55-d0c3-4cdc-82a9-0c3906f77f30@t-8ch.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Thomas,

Thank you for the reviews!

On 10-Dec-24 5:50 PM, Thomas Weißschuh wrote:
> On 2024-12-09 21:40:49+0100, Hans de Goede wrote:
>> Add a new "charge_types" property, this is identical to "charge_type" but
>> reading returns a list of supported charge-types with the currently active
>> type surrounded by square brackets, e.g.:
>>
>> Fast [Standard] "Long_Life"
>>
>> This has the advantage over the existing "charge_type" property that this
>> allows userspace to find out which charge-types are supported for writable
>> charge_type properties.
>>
>> Drivers which already support "charge_type" can easily add support for
>> this by setting power_supply_desc.charge_types to a bitmask representing
>> valid charge_type values. The existing "charge_type" get_property() and
>> set_property() code paths can be re-used for "charge_types".
> 
> IMO it would be nice to have the psy core implement "charge_type" in
> terms of "charge_types" if that is available.
> (And reject a custom "charge_type" in that case)

I'm afraid that adding support to the core for that is going to be
tricky / ugly. While as supporting both in the same driver is trivial.

Also this raises the question if we even want new drivers to have
charge_type at all ? For old drivers we want to keep it to not break
userspace ABI. But for new drivers arguably only having
the new charge_types attribute is better ?


>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Changes in v2:
>> - Add "Check charge_types to get the values supported by the battery."
>>   to Documentation/ABI/testing/sysfs-class-power
>> - Add a note about labels with spaces having these replaced by '_'
>>   to Documentation/ABI/testing/sysfs-class-power
>> - Use power_supply_match_string() in power_supply_charge_types_parse()
>> ---
>>  Documentation/ABI/testing/sysfs-class-power | 20 ++++++++++++
>>  drivers/power/supply/power_supply_sysfs.c   | 34 +++++++++++++++++++++
>>  include/linux/power_supply.h                | 23 +++++++++++++-
>>  3 files changed, 76 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
>> index 45180b62d426..4421815cfb40 100644
>> --- a/Documentation/ABI/testing/sysfs-class-power
>> +++ b/Documentation/ABI/testing/sysfs-class-power
>> @@ -407,10 +407,30 @@ Description:
>>  
>>  		Access: Read, Write
>>  
>> +		Reading this returns the current active value, e.g. 'Standard'.
>> +		Check charge_types to get the values supported by the battery.
>> +
>>  		Valid values:
>>  			      "Unknown", "N/A", "Trickle", "Fast", "Standard",
>>  			      "Adaptive", "Custom", "Long Life", "Bypass"
>>  
>> +What:		/sys/class/power_supply/<supply_name>/charge_types
>> +Date:		November 2024
>> +Contact:	linux-pm@vger.kernel.org
>> +Description:
>> +		Identical to charge_type but reading returns a list of supported
>> +		charge-types with the currently active type surrounded by square
>> +		brackets, e.g.: "Fast [Standard] Long_Life".
>> +
>> +		power_supply class devices may support both charge_type and
>> +		charge_types for backward compatibility. In this case both will
>> +		always have the same active value and the active value can be
>> +		changed by writing either property.
>> +
>> +		Note charge-types which contain a space such as "Long Life" will
>> +		have the space replaced by a '_' resulting in e.g. "Long_Life".
>> +		When writing charge-types both variants are accepted.
>> +
>>  What:		/sys/class/power_supply/<supply_name>/charge_term_current
>>  Date:		July 2014
>>  Contact:	linux-pm@vger.kernel.org
>> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
>> index 034e1848f1ca..48a9bf791a38 100644
>> --- a/drivers/power/supply/power_supply_sysfs.c
>> +++ b/drivers/power/supply/power_supply_sysfs.c
>> @@ -182,6 +182,8 @@ static struct power_supply_attr power_supply_attrs[] __ro_after_init = {
>>  	POWER_SUPPLY_ATTR(CHARGE_CONTROL_START_THRESHOLD),
>>  	POWER_SUPPLY_ATTR(CHARGE_CONTROL_END_THRESHOLD),
>>  	POWER_SUPPLY_ENUM_ATTR(CHARGE_BEHAVIOUR),
>> +	/* Same enum value texts as "charge_type" without the 's' at the end */
>> +	_POWER_SUPPLY_ENUM_ATTR(CHARGE_TYPES, POWER_SUPPLY_CHARGE_TYPE_TEXT),
>>  	POWER_SUPPLY_ATTR(INPUT_CURRENT_LIMIT),
>>  	POWER_SUPPLY_ATTR(INPUT_VOLTAGE_LIMIT),
>>  	POWER_SUPPLY_ATTR(INPUT_POWER_LIMIT),
>> @@ -335,6 +337,10 @@ static ssize_t power_supply_show_property(struct device *dev,
>>  		ret = power_supply_charge_behaviour_show(dev, psy->desc->charge_behaviours,
>>  							 value.intval, buf);
>>  		break;
>> +	case POWER_SUPPLY_PROP_CHARGE_TYPES:
> 
> This should only show a single value for uevent. The same as
> charge_behaviours above (done in a recent change).

Ack, I'll look at what you have done for charge_behaviors and replicate
that for v4 of the series.

<snip>

>> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
>> index b98106e1a90f..60c7f669ec3e 100644
>> --- a/include/linux/power_supply.h
>> +++ b/include/linux/power_supply.h
>> @@ -40,7 +40,7 @@ enum {
>>  };
>>  
>>  /* What algorithm is the charger using? */
>> -enum {
>> +enum power_supply_charge_type {
>>  	POWER_SUPPLY_CHARGE_TYPE_UNKNOWN = 0,
>>  	POWER_SUPPLY_CHARGE_TYPE_NONE,
>>  	POWER_SUPPLY_CHARGE_TYPE_TRICKLE,	/* slow speed */
>> @@ -135,6 +135,7 @@ enum power_supply_property {
>>  	POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD, /* in percents! */
>>  	POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD, /* in percents! */
>>  	POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR,
>> +	POWER_SUPPLY_PROP_CHARGE_TYPES,
> 
> Could the related enum values be kept together?

I but this after POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR since it
is somewhat related to it, also see your uevent remark.

But since the enum values are kernel internal only this
can easily be changed. I assume you want this to be
directly after POWER_SUPPLY_PROP_CHARGE_TYPE instead ?

Regards,

Hans


