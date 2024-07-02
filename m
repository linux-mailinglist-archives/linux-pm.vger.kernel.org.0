Return-Path: <linux-pm+bounces-10390-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 413DA924BDA
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 00:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64F4E1C22242
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 22:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD1E55C08;
	Tue,  2 Jul 2024 22:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KDg1fRFU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5D7282E1
	for <linux-pm@vger.kernel.org>; Tue,  2 Jul 2024 22:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719960562; cv=none; b=mL9raxGGBzKdbgDE919cdXG+EmVi1SwgeETkWf+0kSQ5xUKsj+ZtUxZLP3w27sMhbCUswKKIkUJ2S6ywOaKZYs1GGWza4ww9DXIFO+CXdKr1Ay+7S8WnYrDtlMe0xzbDZ+L8fk0x8zDoFg2yhQNWo6m4HcXTF2zNl4foQfGmpi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719960562; c=relaxed/simple;
	bh=f72sgl9HgTryowTt7EdpeaHpn2BZ6YRNHHd5iRwtpHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sWDgUIs5MhyeCEbZfZzAGgAHKKD/fbYU9/TCU61hpbaAoRGBysBg9iyyEOgdoz3uJXXRfo0KCith62YWK5uXllifgAOWsqi724exRFLza3dvSk1ufEC7AbD5c1rn4coH8Lcnu4DCiKPjfcrQ8bVBjTPonya2uvQRPTDvBZ7WizU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KDg1fRFU; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4255fc43f1cso33074765e9.0
        for <linux-pm@vger.kernel.org>; Tue, 02 Jul 2024 15:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719960559; x=1720565359; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1X9Mr7VvvrMC5BvvERD+zHgsQw9rHtnn682J6Yla/9s=;
        b=KDg1fRFUrFNUICN/FQBKcrzjyMdTnGiEFTbRZosf807wFcXbMnMsR7DJ/tmVQulOSf
         UaNsSc6Hxj7XjBcP9G/on9jeos6CFrq22GeR55kwdwhDBf6jDDz/4kCoN8Oqcod40Jfo
         tKJ5EihHKWlFPgPzeYv6PwPY9s1HAL3qkg4ijv3B5wZWouWbWwrzBclPZUMVoNQZC0y/
         d932anUGqUzZsCYJ2n6ZRCFRi45YejfuvdvkNsNv9fCFOFhkvw3duHtwjIPLQs/0SjVU
         Wd7yfKoHefio86XCt/UkD5OVFVAb89/Jl587c/cgbZJpUiLhaeNDYzVOEQRd7d5eZWHB
         H6lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719960559; x=1720565359;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1X9Mr7VvvrMC5BvvERD+zHgsQw9rHtnn682J6Yla/9s=;
        b=lv/4voBfvg8woLDX7NnRMb0YLHxaBPvGoKwFqmyWQCtAt0s8RwuG7TQH6wthHKpJik
         3rWOpMgmY/p78errLGIYxSDdCQ0Om+7LZ8w2qNIisISB6HqHdy3v6VL0Qv117GY0vMSB
         HEGKHIBJBbXAQyfPW4V3jDFHoDNfNirneT/wBFs9uFi6AYxI6jwKn+eGhDbnaT4kDQNV
         HUS81Gw1ZAh2noiHKF0FXZApSqGTMCM48Ydz8w6AWOc16PlUGGnXQaPFo9ZFg/k58Yb+
         YW+fwFaJNDVqUFY7mcrSq1fFglXh4T7qHh+FBxHcW+oh9FvwPKZhRGqmrDBSncKIagLh
         91mQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWub4Q6/TsjSlUNTzKu9a1N6HTXJmYNfhV1m6bwKpySFJQC88MYgmRSiDTPGWDM64QxMzsR+UYFxpaevGM28YSeYqzTLNPdxE=
X-Gm-Message-State: AOJu0YzW3jqc24jIfY/u7kAvxUbqY6EL4kBMeLIEmXnNlgYc2zRgoZI6
	zt4BdokcP7Fxzqb3bhUBo3vPGLWzpQ40auTsjWD7p87AMq4r7AjEv21KLgzK2fo=
X-Google-Smtp-Source: AGHT+IGrzd+OgUwniDfKP25uSNN76P3kSHeLADfH+5HAk1sC0dugFwWllYe+gz0UV85WWIUGzY2l8Q==
X-Received: by 2002:a7b:c4cd:0:b0:425:6385:83bc with SMTP id 5b1f17b1804b1-4257a034fa2mr84787865e9.15.1719960559098;
        Tue, 02 Jul 2024 15:49:19 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4256b064f16sm214518255e9.27.2024.07.02.15.49.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 15:49:18 -0700 (PDT)
Message-ID: <c5931c93-248a-43cf-bcaa-d9bfdac9916a@linaro.org>
Date: Wed, 3 Jul 2024 00:49:17 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal/core: Introduce user trip points
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rob Herring <robh@kernel.org>, linux-pm@vger.kernel.org,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20240627085451.3813989-1-daniel.lezcano@linaro.org>
 <20240701162600.GA4119789-robh@kernel.org>
 <98fe3146-07ae-4095-b372-6aed6e080d94@linaro.org>
 <CAJZ5v0ix+RDtrR+r3jd=A_W7D5U7JodMiirJ519-wwLrHeBbSw@mail.gmail.com>
 <1eb7eb88-4230-4803-83fe-415ce0745951@linaro.org>
 <CAJZ5v0jV+0bWqpCR1Q2rYLJvx0J6hgExzRks6YDPL9gX_HK0rA@mail.gmail.com>
 <2a8f5b5f-b67a-4bd0-afe9-f09473aea2d5@linaro.org>
 <CAJZ5v0g4A1FYZ+7Cb5ocw78y=1Kdg=HSuza2FpYSAiT2c_ZzaQ@mail.gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0g4A1FYZ+7Cb5ocw78y=1Kdg=HSuza2FpYSAiT2c_ZzaQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02/07/2024 19:15, Rafael J. Wysocki wrote:
> On Tue, Jul 2, 2024 at 6:31 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>> On 02/07/2024 13:03, Rafael J. Wysocki wrote:
>>
>> [ ... ]
>>
>>>>> Trips cannot be created on the fly ATM.
>>>>>
>>>>> What can be done is to create trips that are invalid to start with and
>>>>> then set their temperature via sysfs.  This has been done already for
>>>>> quite a while AFAICS.
>>>>
>>>> Yes, I remember that.
>>>>
>>>> I would like to avoid introducing more weirdness in the thermal
>>>> framework which deserve a clear ABI.
>>>>
>>>> What is missing to create new trip points on the fly ?
>>>
>>> A different data structure to store them (essentially, a list instead
>>> of an array).
>>>
>>> I doubt it's worth the hassle.
>>>
>>> What's wrong with the current approach mentioned above?  It will need
>>> to be supported going forward anyway.
>>
>> So when the "user trip point" option will be set, a thermal zone will
>> have ~ten(?) user trip points initialized to an invalid temperature ?
> 
> If a thermal zone is registered with 10 invalid trip points, htat can
> happen already today.

IINW, this is the case for a particular driver (int340x_thermal_zone?), 
may be for a thermal zone. But in the general case where we can have 
more the 50 thermal zones it is not adequate as we will end up with more 
than 500 trip points overall.

Assuming it is the int340x_thermal_zone driver, it is active trip 
points, so that assumes the associated cooling device will be active. 
TBH, it is fuzzy regarding a notification mechanism

> Let's talk about the usage model, though.

Sure

> IIUC, this would be something like "triggers" I mentioned before: If a
> certain temperature level is reached, a notification is sent to user
> space, and there are multiple (possibly many) levels like this.  They
> can be added and deleted at any time.

Yes, except I don't think the usage will be to often creating trip 
points. More likely, depending on the kind of sensors and the associated 
logic, a number of trip points will created for a specific profile and 
then modified on the fly.

> There can be an interface for this, as simple as a pair of sysfs
> attributes under a thermal zone: add_trigger and remove_trigger.  If
> root (or equivalent) writes a (valid) temperature value to
> add_trigger, a new trigger is added (up to a limit and provided that
> enough memory can be allocated).  Conversely, if a temperature value
> is written to remove_trigger and there is a trigger with that
> temperature, it will be deleted.

A hysteresis would be needed too. IMO, netlinks are more adequate for 
this purpose.

> Internally, the triggers can be stored in a sorted list (with some
> optimizations, so it need not be walked every time the zone
> temperature changes) or a tree, independent of the trips table (if
> any).  Every time the zone temperature changes, the triggers list is
> consulted (in addition to the trips table) and if any of them have
> been crossed, notifications are sent to user space.

So basically, thermal_zone_device_update() will browse two lists, 
triggers + trip points, right ?

> If polling is used, this would just work, but without polling the
> driver needs to support setting a pair (at least) of temperature
> levels causing an interrupt to occur.  

I'm missing this point, can you elaborate ?

> If a specific callback, say
> .set_triggers(), is provided by the driver, it can be used for setting
> those temperature levels to the triggers right above and right below
> the current zone temperature, in analogy with .set_trips().
> 
> Does this reflect what you are after?

At the first glance I would say yes, but I don't get why it is more 
complicate to just add 'triggers' with the trip points (formerly 'user' 
trip points)

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


