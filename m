Return-Path: <linux-pm+bounces-13863-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 723C09708C5
	for <lists+linux-pm@lfdr.de>; Sun,  8 Sep 2024 18:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00A7C280D10
	for <lists+linux-pm@lfdr.de>; Sun,  8 Sep 2024 16:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7302173347;
	Sun,  8 Sep 2024 16:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eXFpA/el"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A926DEAF9
	for <linux-pm@vger.kernel.org>; Sun,  8 Sep 2024 16:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725813510; cv=none; b=BiS4QA0vqqYQMYytGRDYjhIAZSYw/WlK5FkN1/inNpYoamR3P3/CT0foX+xEoN2OhWYUN4ZmTZ5sE9QgwMpD3iTGWD2vlAFjntzTQ8TwTpAOtmWp/J35EhDHm5qdFgslFJaumdJek5f/No3+Sr+C+c+ADhOp+gx4VURcxW4dHaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725813510; c=relaxed/simple;
	bh=x/w7pz07QhYsayp3PNItx0bCA64F/EFbrJYbltFW8DA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TDIyK6SVJIeQxVN1WApDREpZg7wl1J/80ebd+XsZbXQ9+YzUllEGLB2ieQasVEIZFcwX5mPU34o/linatnqYsQeQ8W1/0gWyPa3bgnyrDZoVLnJnlzRGDRcadxGol81d20f9neXuzXTDFOorEV3cW24nZ6haqVhhZq3tTEsNHeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eXFpA/el; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725813507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lzMcfrgXG2XIff9SaXPnBJ27ObTZWuLyYGwwYQ2OyHw=;
	b=eXFpA/eleixjlUDWECbol/pJOaHp6FrIajkg5yycM7Ii9vZ5EgjePl63pTg7O/af5LTDx2
	YNi8f6HMmraX2v1YMyb7FF7G1B4rp24CjGrq46UdE3+bXfAd1KeqfH62h1RSK97lotNTHd
	CT0d8uw7q7PG1KUqW4p5DE3TnixfBA0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-YUuza-POOyq9Ndc4lWGaHg-1; Sun, 08 Sep 2024 12:38:26 -0400
X-MC-Unique: YUuza-POOyq9Ndc4lWGaHg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a8a9094c973so143452666b.2
        for <linux-pm@vger.kernel.org>; Sun, 08 Sep 2024 09:38:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725813505; x=1726418305;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lzMcfrgXG2XIff9SaXPnBJ27ObTZWuLyYGwwYQ2OyHw=;
        b=aDnEY1mXULe2VrIfYY5mdS2Tg3r0UPGPcaOqWwpQ7ed1N9/BQDSQwJWJyPINcwCf8q
         KMF+dlzmaH1WRdIBM8bZ0zNvtDAO2gwdP5WiO59/dlf6AQz4EdmmmBkMQPWWya/usdP8
         76EtFrmfEHhkMm1NSntUHH5LRq7e0+t+XQNRGwZY4LnHpHXLriNfJzf2wv+YLnqTLG4K
         lRUnlJ8OUArI5C0c+UpGotqJs9fUGiWm/fTL2AGZ0IhtuhMfV3wEbSS7mv0VYXB3o40M
         IiI+GlIXAMxr11Hspc5RNtz7+32o36BK455FiUIBtb+erVxxsY8cT0zSjIWxSgZL9A+v
         ohCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDeH+JizYewzhD0J2dmvRFeT4APM5vgwPjgxEf2K4R88C61ZOTBryL5/0d1tV+WClVQZD44L83cw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/adah/37Q53fHKRALK8TLhT/+v3Tm23XMdYGFOVNQO6JCOUPa
	VKsjbX4oUhf9hfv6Gge1dqfuSnw3L4NKDg0x1QTIApZCZ6wgrm5m02FOrJRaRN7bSh1siIutKY+
	gSivjxydtfn8pAY2tqGDT7eJpMivisW/nnhx9AJwE+w1CJa2c/zeVDQWK1C34y8Sol/E=
X-Received: by 2002:a17:907:60cb:b0:a8d:3998:2d2 with SMTP id a640c23a62f3a-a8d3998277bmr301152266b.58.1725813504890;
        Sun, 08 Sep 2024 09:38:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkhD0Q+G50M/V4STwhzFjV1FktTYedfy6dxOC9dBoE0mLJqJ+XmyoR5AYJrJ3Fbcsbnkl6jw==
X-Received: by 2002:a17:907:60cb:b0:a8d:3998:2d2 with SMTP id a640c23a62f3a-a8d3998277bmr301148666b.58.1725813503808;
        Sun, 08 Sep 2024 09:38:23 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d259511c0sm224093666b.62.2024.09.08.09.38.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Sep 2024 09:38:23 -0700 (PDT)
Message-ID: <44c3d02a-cab2-4d51-86cf-600fdf19f1a4@redhat.com>
Date: Sun, 8 Sep 2024 18:38:21 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.11 regression fix] power: supply: sysfs: Revert use
 power_supply_property_is_writeable()
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
References: <20240908144414.82887-1-hdegoede@redhat.com>
 <de97c24e-85b2-4196-80da-5718075c900b@t-8ch.de>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <de97c24e-85b2-4196-80da-5718075c900b@t-8ch.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 9/8/24 4:52 PM, Thomas Weißschuh wrote:
> Hi Hans,
> 
> On 2024-09-08 16:44:14+0000, Hans de Goede wrote:
>> power_supply_property_is_writeable() contains the following check:
>>
>>         if (atomic_read(&psy->use_cnt) <= 0 ||
>>                         !psy->desc->property_is_writeable)
>>                 return -ENODEV;
>>
>> psy->use_cnt gets initialized to 0 and is incremented by
>> __power_supply_register() after it calls device_add(); and thus after
>> the driver core calls power_supply_attr_is_visible() to get the attr's
>> permissions.
>>
>> So when power_supply_attr_is_visible() runs psy->use_cnt is 0 failing
>> the above check. This is causing all the attributes to have permissions
>> of 444 even those which should be writable.
>>
>> Move back to manually calling psy->desc->property_is_writeable() without
>> the psy->use_cnt check to fix this.
> 
> Thanks for the fix!
> 
> OTOH the whole power_supply_attr_is_visible() is completely unused
> outisde of the psy core. So instead we could unexport it, drop the use_cnt
> check and use it again.
> (All of this as part of the psy extension series, for now your revert
> should be used)
> 
> What do you think?

So I took a look at other users of power_supply_attr_is_visible() and
the only other user is power_supply_hwmon_is_visible() which suffers
from the exact same problem.

NACK.

So self-nack for this fix. It is better to drop the use_cnt check
from power_supply_property_is_writeable() altogether since currently
all hwmon attributes are always 0444 too. I checked with a max170xx_battery
where /sys/class/hwmon/hwmon5/temp1_min_alarm should be 0644, but
until I fix power_supply_property_is_writeable() it is 0444.

Also temp1_max_alarm is missing from the hwmon, I also have a fix
for that one ...

Regards,

Hans


>> Fixes: be6299c6e55e ("power: supply: sysfs: use power_supply_property_is_writeable()")
>> Cc: Thomas Weißschuh <linux@weissschuh.net>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Note this is a straight-forward revert of be6299c6e55e
>> ---
>>  drivers/power/supply/power_supply_sysfs.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
>> index 6cd3fac1891b..fb9b67b5a9aa 100644
>> --- a/drivers/power/supply/power_supply_sysfs.c
>> +++ b/drivers/power/supply/power_supply_sysfs.c
>> @@ -387,7 +387,8 @@ static umode_t power_supply_attr_is_visible(struct kobject *kobj,
>>  		int property = psy->desc->properties[i];
>>  
>>  		if (property == attrno) {
>> -			if (power_supply_property_is_writeable(psy, property) > 0)
>> +			if (psy->desc->property_is_writeable &&
>> +			    psy->desc->property_is_writeable(psy, property) > 0)
>>  				mode |= S_IWUSR;
>>  
>>  			return mode;
>> -- 
>> 2.46.0
>>
> 


