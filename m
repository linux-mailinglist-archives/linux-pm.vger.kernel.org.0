Return-Path: <linux-pm+bounces-10325-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FA3923A0A
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 11:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70E251C2295A
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 09:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0835A153836;
	Tue,  2 Jul 2024 09:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q3M7S8qi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B108F1514E3
	for <linux-pm@vger.kernel.org>; Tue,  2 Jul 2024 09:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719912588; cv=none; b=s060vK8SKRX5EQKGLGwWuuI/vgRu+cv63UruVIJdZP4MHCDhQ8beECOEfFHjdagtbKdIwcM+qz90LwQlqEmH9/gPOSCX2l1x4+hlVH03OSnH24DCMhjr0d8IDEqMbpXzCy2djObMWVFeJdyrH04pcZM868azIjk/6R/K0Nk+HFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719912588; c=relaxed/simple;
	bh=TerRgP+v40fCEJSwAyzuLhhySHf5Xi59Fhbfu6zqEXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fFwTHtuQLg0eq2F1D8Jyu5Azv33VsL1lA/unDFeCIS5mD7y3dnoju4fLISnF4rTF/aRLv5fCF1zWohOfoKhTrZCqQM/CcZFzz1CHPuDQ1jP/gEhC0shB3oJ/WoAuZID2pzBwD8U5MMOAPEcuvUo+OvzxJxiam5YKVLpdwRv2t00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q3M7S8qi; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4256eec963eso27802895e9.1
        for <linux-pm@vger.kernel.org>; Tue, 02 Jul 2024 02:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719912584; x=1720517384; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gFNGLntKhW/Guwso71i4rkzJq++IdrdgxniMyjmtpdk=;
        b=q3M7S8qiINZ8QiqZFJsYYDWmjZIzHPeL+Ii+Ea89O7yX9IZH6ufX/Wj2huYB1UaLhR
         kuLgT4ro33yssRFoPGNOUUz04TIIAJhuf4PuPC+Q3QsghdViLQOF+8rv6A23fG72gBWO
         YtEtiN7cY7GpXmbc1uBlZ634AykFVlYL57wxDpS3P5wYn1qYzML6RWWZ9UN93TwdyZY+
         MVxJVBiBftqJS4Rm+kGQ7ZzAFdD8Gmw/7Pd4wWA9aOYFMQCvdZpdc9weDC4HBKFy9Rg9
         l+rjxDk3EPzr4GG2qaizQnGnRSmA2NCRmuIhmEltxUCSDCY/VcIixzue9Fb68GDczadS
         g6lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719912584; x=1720517384;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gFNGLntKhW/Guwso71i4rkzJq++IdrdgxniMyjmtpdk=;
        b=IbV4Iri1wZHCqQDxa3P0z4YWo4+Bf7N13Vb0Iifj95OgTTjb1i1OvY+1C3xoQszzz7
         YBay+44oQtTtaCMnW0eag1xJK/v+ND4/aGPZDIJRGnZ2rmBr4bw0vkVDvh5digPk4R/y
         +PN+nMpLb/eG+6Xb90SB0sJHRVovEiDdxLAPldV3nfePw+BIyCTfnqKN6lj+5aNpoQLD
         wTOCkAqeqnHhR2vnJytj08ugZlhWSTgWT+DaoiE8LXRrKtxuRLVFIGFF5iA4xV3xt/sX
         SkUthtIM8aS7VQ7S58IJ/rd2XiUoydk+jObrgXQ+Zg0slYOv/x/xhDeTjle1iDly1yBD
         qBYA==
X-Forwarded-Encrypted: i=1; AJvYcCU8mkdbc/rv5M5eMlEXCOQSx5OiPbFAdjmxD1jw4phFpFnGLggKuCVJlhkxemo6fyu4PlSmH2b2A3E9kdvAHal/YmQqPUrM0ak=
X-Gm-Message-State: AOJu0YzY3lVnCa1H1jGspH9qqmk515rCZplI3ZUgzsMZnwvyvDu60+BM
	XfcSgTkVL/Pqbel/Od/QHxxKO/9BReutvaykUJYSDhPmdtB8M0Z0npfsciEAd9MqtgIxUgEWIGT
	G
X-Google-Smtp-Source: AGHT+IGcvq6Md4bK4F0AZvBieiuaKUIzYS5wkTsJTtgZyqDebBXPayfayMlcGBx0YgPhznQfC9z7ug==
X-Received: by 2002:a05:600c:4589:b0:425:6911:eb00 with SMTP id 5b1f17b1804b1-4257a02c894mr52320595e9.5.1719912583999;
        Tue, 02 Jul 2024 02:29:43 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:de58:360d:d635:3977? ([2a05:6e02:1041:c10:de58:360d:d635:3977])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4257fb4fabdsm96567125e9.46.2024.07.02.02.29.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 02:29:43 -0700 (PDT)
Message-ID: <98fe3146-07ae-4095-b372-6aed6e080d94@linaro.org>
Date: Tue, 2 Jul 2024 11:29:42 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal/core: Introduce user trip points
To: Rob Herring <robh@kernel.org>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20240627085451.3813989-1-daniel.lezcano@linaro.org>
 <20240701162600.GA4119789-robh@kernel.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240701162600.GA4119789-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 01/07/2024 18:26, Rob Herring wrote:
> On Thu, Jun 27, 2024 at 10:54:50AM +0200, Daniel Lezcano wrote:
>> Currently the thermal framework has 4 trip point types:
>>
>> - active : basically for fans (or anything requiring energy to cool
>>    down)
>>
>> - passive : a performance limiter
>>
>> - hot : for a last action before reaching critical
>>
>> - critical : a without return threshold leading to a system shutdown
>>
>> A thermal zone monitors the temperature regarding these trip
>> points. The old way to do that is actively polling the temperature
>> which is very bad for embedded systems, especially mobile and it is
>> even worse today as we can have more than fifty thermal zones. The
>> modern way is to rely on the driver to send an interrupt when the trip
>> points are crossed, so the system can sleep while the temperature
>> monitoring is offloaded to a dedicated hardware.
>>
>> However, the thermal aspect is also managed from userspace to protect
>> the user, especially tracking down the skin temperature sensor. The
>> logic is more complex than what we found in the kernel because it
>> needs multiple sources indicating the thermal situation of the entire
>> system.
>>
>> For this reason it needs to setup trip points at different levels in
>> order to get informed about what is going on with some thermal zones
>> when running some specific application.
>>
>> For instance, the skin temperature must be limited to 43°C on a long
>> run but can go to 48°C for 10 minutes, or 60°C for 1 minute.
>>
>> The thermal engine must then rely on trip points to monitor those
>> temperatures. Unfortunately, today there is only 'active' and
>> 'passive' trip points which has a specific meaning for the kernel, not
>> the userspace. That leads to hacks in different platforms for mobile
>> and embedded systems where 'active' trip points are used to send
>> notification to the userspace. This is obviously not right because
>> these trip are handled by the kernel.
>>
>> This patch introduces the 'user' trip point type where its semantic is
>> simple: do nothing at the kernel level, just send a notification to
>> the user space.
> 
> Sounds like OS behavior/policy though I guess the existing ones kind are
> too. Maybe we should have defined *what* action to take and then the OS
> could decide whether what actions to handle vs. pass it up a level.

Right

> Why can't userspace just ask to be notified at a trip point it
> defines?

Yes I think it is possible to create a netlink message to create a trip 
point which will return a trip id.

Rafael what do you think ?

> If we keep this in DT, perhaps 'notice' would be a better name that
> doesn't encode the OS architecture details.

[ ... ]

> BTW, can we decide what to do about 'trips' node being required or not?
> That's nearly the only DT warning left for some platforms.

A thermal zone is a combination of a sensor, a mitigation logic (user or 
kernel), hardware limits with trip points to activate the logic. Without 
trip points, this logic can not operate, consequently the thermal zone 
description is incomplete.

I guess those thermal zones are set to have the sensor exported in 
/sys/class/thermal, so the userspace can access the temperature.

However, existing thermal zone description should have at least a 'hot' 
trip point and a 'critical' trip point.

On the other hand, now that we are introducing the 'user' trip point, 
those thermal zone can exist without trip points because we can create 
them at any time from userspace.

So at the first glance, I would say we can drop the "required" 
constraint for the trip points in the thermal zone description.


>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>   .../devicetree/bindings/thermal/thermal-zones.yaml        | 1 +
> 
> Please make bindings a separate patch.
> 
>>   drivers/thermal/thermal_core.c                            | 8 ++++++++
>>   drivers/thermal/thermal_of.c                              | 1 +
>>   drivers/thermal/thermal_trace.h                           | 4 +++-
>>   drivers/thermal/thermal_trip.c                            | 1 +
>>   include/uapi/linux/thermal.h                              | 1 +
>>   6 files changed, 15 insertions(+), 1 deletion(-)
> 

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


