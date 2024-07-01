Return-Path: <linux-pm+bounces-10285-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F7C91E3BE
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2024 17:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96F031F237E9
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2024 15:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7881016EB56;
	Mon,  1 Jul 2024 15:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xvnNdvzZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8959616E88C
	for <linux-pm@vger.kernel.org>; Mon,  1 Jul 2024 15:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719846832; cv=none; b=jocmFsR75BczD70UP5B4lkrZRfj0Z00hczpsjz08m1qwQcacvNhDnmyOT6kUlMdS/1fT9aKc4D4/k3DDx06IZ5+9d6oVwuaaEAU3d0gWXom6cLXkM21L9aURfILlH9VsXfsgmbQ9DaapAQJ0R/9E5NHII4ksi3fWm59vYlnJ9v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719846832; c=relaxed/simple;
	bh=8XOLp81OzlTJJHbaW9uPIcZnR43qb3BjCtlX+MMfPp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fSv62NqEMKNISN9R1pYnwjgtfr0vFqiJVKVkU79pQ4YiBpf9N0UHq3olIhBZKCEcQ4CJulYSosaDDAkQO6Uik0JNH40Fh3YzNWSg8wRWSnpRZu/0HG1ylMzAJjEzlkRdC5vq/xqZDk6io/Ux5a+6GI/cco2ZRY6Jr4VJD1w8Le0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xvnNdvzZ; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-367339bd00aso2429141f8f.3
        for <linux-pm@vger.kernel.org>; Mon, 01 Jul 2024 08:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719846829; x=1720451629; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UzPODOkiRF+Ul7AAMGg53DSYXK0WfpNzUmVPE/Vi3NU=;
        b=xvnNdvzZ1brqwjI5SbjG8Ee2sSTO3TjZ59oyGyDuLg1lyy1dLvNxv7f4AgSsGEKUXH
         DZ9C+t9MFaSPFe07YAWNy3rqTvFUu+pNW4fZ3XtLMj9HCxoZbRQo4suDLFaXpNSwu/yg
         +LHrsozqYv/Z0qD7a+gXnVQD/m65SKNr3uW8oLsnMJlO7jZDWmRWf1nBTVQ33QGPRikD
         tu+3ZUbDCZoE56RvnnRrqqsyZBsOzB3bOCpEAM4wMHUI1UeFso4Ox0ElHMTeF1ijQwST
         8/y24B50RYRpKQH0BQDovrlicF2D2J2ux2mr4rUwg5AMnlnFZZ1LXlcXMKRcXebva5vr
         oQHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719846829; x=1720451629;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UzPODOkiRF+Ul7AAMGg53DSYXK0WfpNzUmVPE/Vi3NU=;
        b=YsqDx0kywaa84jZmNA1lBGoN/hQI9VwsgA4BXSnHr4Dc84tDgZ5W5hP62jBdOyXnAQ
         mMOVB7VzM1t33Dfe3o9i2A3FfuZ92prxpMxO/c6j3SNOTR2+VN6+2eqnYMofgczy3SFw
         rR/bFgr+M15Ycc/soFRd1VWSIiYBHZcbsB96UYd4bQk0P9njyAyaVnL3lqh0+fpgD0F1
         g9pbtQAUU5C93QZLBmYErSbB4479zcSg3Lf6IyP7d9bl6fSXcHYRr2F5K7XgrFqkNmZh
         kyCoLlpTzdTuXa3VOTIYezIscNtkvnoO9ToW6sABP3VFUcNsWBShAyl+vmxB3zXYjuUK
         hOMw==
X-Gm-Message-State: AOJu0YxfS1hjZec3sM1pa785Um0OHz0B+0VYDjhY4eNxAvsYRBWUSp6D
	CIcUTkGBwnUzGD8IaA9RuUEClKTQhOSZ0wJg8u6pDMB6I6r+hYlU6zMQxBUDK9o=
X-Google-Smtp-Source: AGHT+IEsfAsS6Jxp21mX/YsiTZnspNYFLFuMLgII2hZwYP9owd+AsAgpuZ/N9pdlEdXMkZ38EzJ5Jw==
X-Received: by 2002:adf:f48e:0:b0:360:8537:ce27 with SMTP id ffacd0b85a97d-367756e5165mr4212418f8f.42.1719846828847;
        Mon, 01 Jul 2024 08:13:48 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:d5d7:31af:53ed:6dbc? ([2a05:6e02:1041:c10:d5d7:31af:53ed:6dbc])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3675a1030dfsm10272616f8f.100.2024.07.01.08.13.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 08:13:48 -0700 (PDT)
Message-ID: <9c2971dd-2f2d-426f-9107-eae93d5dd554@linaro.org>
Date: Mon, 1 Jul 2024 17:13:47 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal/core: Introduce user trip points
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20240627085451.3813989-1-daniel.lezcano@linaro.org>
 <CAJZ5v0iO6MrX3QxAu4Wj4grUL2g7gPPXO3f8PFmZBot-Ud32TQ@mail.gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0iO6MrX3QxAu4Wj4grUL2g7gPPXO3f8PFmZBot-Ud32TQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/06/2024 15:56, Rafael J. Wysocki wrote:
> On Thu, Jun 27, 2024 at 10:55 AM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
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
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>   .../devicetree/bindings/thermal/thermal-zones.yaml        | 1 +
>>   drivers/thermal/thermal_core.c                            | 8 ++++++++
>>   drivers/thermal/thermal_of.c                              | 1 +
>>   drivers/thermal/thermal_trace.h                           | 4 +++-
>>   drivers/thermal/thermal_trip.c                            | 1 +
>>   include/uapi/linux/thermal.h                              | 1 +
>>   6 files changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
>> index 68398e7e8655..cb9ea54a192e 100644
>> --- a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
>> +++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
>> @@ -153,6 +153,7 @@ patternProperties:
>>                 type:
>>                   $ref: /schemas/types.yaml#/definitions/string
>>                   enum:
>> +                  - user     # enable user notification
>>                     - active   # enable active cooling e.g. fans
>>                     - passive  # enable passive cooling e.g. throttling cpu
>>                     - hot      # send notification to driver
>> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
>> index 2aa04c46a425..506f880d9aa9 100644
>> --- a/drivers/thermal/thermal_core.c
>> +++ b/drivers/thermal/thermal_core.c
>> @@ -734,6 +734,14 @@ int thermal_bind_cdev_to_trip(struct thermal_zone_device *tz,
>>          if (tz != pos1 || cdev != pos2)
>>                  return -EINVAL;
>>
>> +       /*
>> +        * It is not allowed to bind a cooling device with a trip
>> +        * point user type because no mitigation should happen from
>> +        * the kernel with these trip points
>> +        */
>> +       if (trip->type == THERMAL_TRIP_USER)
>> +               return -EINVAL;
> 
> Maybe print a debug message when bailing out here?

After thinking a bit about the message, it sounds to me that is a really 
an error in the firmware if we end up binding an 'user' trip point.

What about the following message:

dev_err(tz->device, "Trying to bind the cooling device '%s' with an 
'user' trip point id=%d", cdev->type, trip->id);


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


