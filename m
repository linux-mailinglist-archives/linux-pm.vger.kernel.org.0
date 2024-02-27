Return-Path: <linux-pm+bounces-4452-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9D7869CF6
	for <lists+linux-pm@lfdr.de>; Tue, 27 Feb 2024 17:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A5F7B2D598
	for <lists+linux-pm@lfdr.de>; Tue, 27 Feb 2024 16:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AAF421A0B;
	Tue, 27 Feb 2024 16:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IYoEErTY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6808D208B0
	for <linux-pm@vger.kernel.org>; Tue, 27 Feb 2024 16:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709052469; cv=none; b=E7bG2/Ps5k00uDHHkqhZCjAFJEAKa7ZNj0rF45rdd0gRzfKwAuA01XGwXten1Gtj1Y1DM9kTUaowDidl9uLb4aTJakVi9GoFmq4Uf5NKq2NNM+2MCniypsksWEnmbaf+Qzd9MfkAicgzs/RmGrklt6q4lpx5r61QPwFnlMKYaiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709052469; c=relaxed/simple;
	bh=6zkBEAuVKD3dn+SJ9jTkTMgU/DW87RV1/7vWT8Sk0h8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IGP+ZJ1sw2YXgvRIUOOE59REK03KFnnJOtCTUIwIVOat8BQ+ZMO/ms6dSyz0OD54Tn/b4McVaZkPhjoe5ir5whuW0oJ7N/Cazm5TSvwhuJkKmvHP6m1Icc+klCszIcAFUSiW1vtCjMnfteSUQJC0jRKk5ipVy+RDwWSVAbG83Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IYoEErTY; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-412a3ebad2aso19223095e9.1
        for <linux-pm@vger.kernel.org>; Tue, 27 Feb 2024 08:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709052466; x=1709657266; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BJeS3+GsoLHCZD1u/+yVO3ToKC1f+F8eZicM2YTy7dM=;
        b=IYoEErTYB6GFiD+3D9YhSMVV9zfEKNHJuBQeDw6CLiZqUQJn4QwdFw94m9CmFQXJC+
         ua1udJOjo58cZX8VVvNYjYuRl+d9IjYneYxP70EpnbGLvxPw0xVGJ+UZ8s5aa2CsMw/I
         PPTv62/zYv9UXKylBJz3gdfC/9PYIYnaJYqUFJB43gc2hOPObHqWu1HPOhGrk7AGJl2R
         q/JgeccaRifQzwlVhmDlkZZTkC8oMCVniw4fWaL/yzboJtRUC2d2prrgbj7lxZz/z21Q
         uRimOe9ljw3BtLiBmaOyZC16jfXP8+iAzi6I1Y8tJthkuFLR1uve2ZQD7LfDSsOAqnsD
         6ixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709052466; x=1709657266;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BJeS3+GsoLHCZD1u/+yVO3ToKC1f+F8eZicM2YTy7dM=;
        b=RmvZmM+zow/ygBXYQ8fKAwYsArAojvxyZwoIKYzvRyCTg/kgm8MXdzp3bnHGlvhf36
         uFwXwjg1XsSx4MOXOTAlF2srpNiUdbJM9jfMvqNlQqnJ8GjmiKH9J6mdovnmTeNCwtfD
         xuaRFCmTwIqltMbGdEsVBxuubtRO3Mya2AZETl8NMGDyadiUJRbyPzOzPNxYDAAE+Xhx
         w6A7DeBie/2xIfp2n3NZKMWsyiStbzpCBm8Aj0qvqYKcw2Bknu9f2RmXGGKq6w4BYZRc
         yqd07i8xUjPWh7nxNtG+ykH3XnuUJebXq/B5tFbRIwFEWglbzGmabor9ZlUCHGu8Edn6
         tU5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVyFNWeoX74x5Fh+A9HDSf2XgyBmfoCp11wELQwjTb2Bw7YmQXvpraaGBVVdrOpXEZ6nyEvSBkzMsS1TuH+5l2YGRDMVlxdpGc=
X-Gm-Message-State: AOJu0Yzg7k2RakXCmBe21GUcGQyHRcApnDvapDx3ANo7GbogWejRrJVT
	OTxUaVN7nkIOc6ij1XjTByt1LEQAlcvgX3r7Z9zpd9WHKmqub36WevXJO7nDEuM=
X-Google-Smtp-Source: AGHT+IFR7ptc3nvFIOiQO3yUySKihomDEnERXujeGlC81SqO5CS+DQw5OwFhlkPhWppuYiMTGE5r5A==
X-Received: by 2002:a05:600c:1c90:b0:412:ae2f:e9fa with SMTP id k16-20020a05600c1c9000b00412ae2fe9famr1761559wms.11.1709052465690;
        Tue, 27 Feb 2024 08:47:45 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id v13-20020a05600c444d00b0041294d015fbsm11929001wmn.40.2024.02.27.08.47.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 08:47:45 -0800 (PST)
Message-ID: <bbc65508-eb0e-4d63-921b-85d242cc556f@linaro.org>
Date: Tue, 27 Feb 2024 17:47:44 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal: core: Move initial num_trips assignment before
 memcpy()
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>, rui.zhang@intel.com,
 lukasz.luba@arm.com, gustavoars@kernel.org, morbo@google.com,
 justinstitt@google.com, stanislaw.gruszka@linux.intel.com,
 linux-pm@vger.kernel.org, linux-hardening@vger.kernel.org,
 llvm@lists.linux.dev, patches@lists.linux.dev
References: <20240226-thermal-fix-fortify-panic-num_trips-v1-1-accc12a341d7@kernel.org>
 <6a6be01d-3453-4268-8b2e-0279cc20835d@linaro.org>
 <CAJZ5v0h87k6xoi-9V0Cfb2rHQcr-STfG_bNWpzfoj4Dy46U0Lw@mail.gmail.com>
 <f81af0ae-7458-47d3-90ae-71d5217ee7dd@linaro.org>
 <202402270816.0EA3349A76@keescook>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <202402270816.0EA3349A76@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 27/02/2024 17:26, Kees Cook wrote:
> On Tue, Feb 27, 2024 at 04:37:36PM +0100, Daniel Lezcano wrote:
>> On 27/02/2024 12:09, Rafael J. Wysocki wrote:
>>> On Tue, Feb 27, 2024 at 11:14 AM Daniel Lezcano
>>> <daniel.lezcano@linaro.org> wrote:
>>>>
>>>> On 27/02/2024 01:54, Nathan Chancellor wrote:
>>>>> When booting a CONFIG_FORTIFY_SOURCE=y kernel compiled with a toolchain
>>>>> that supports __counted_by() (such as clang-18 and newer), there is a
>>>>> panic on boot:
>>>>>
>>>>>      [    2.913770] memcpy: detected buffer overflow: 72 byte write of buffer size 0
>>>>>      [    2.920834] WARNING: CPU: 2 PID: 1 at lib/string_helpers.c:1027 __fortify_report+0x5c/0x74
>>>>>      ...
>>>>>      [    3.039208] Call trace:
>>>>>      [    3.041643]  __fortify_report+0x5c/0x74
>>>>>      [    3.045469]  __fortify_panic+0x18/0x20
>>>>>      [    3.049209]  thermal_zone_device_register_with_trips+0x4c8/0x4f8
>>>>>
>>>>> This panic occurs because trips is counted by num_trips but num_trips is
>>>>> assigned after the call to memcpy(), so the fortify checks think the
>>>>> buffer size is zero because tz was allocated with kzalloc().
>>>>>
>>>>> Move the num_trips assignment before the memcpy() to resolve the panic
>>>>> and ensure that the fortify checks work properly.
>>>>>
>>>>> Fixes: 9b0a62758665 ("thermal: core: Store zone trips table in struct thermal_zone_device")
>>>>> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
>>>>> ---
>>>>>     drivers/thermal/thermal_core.c | 2 +-
>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
>>>>> index bb21f78b4bfa..1eabc8ebe27d 100644
>>>>> --- a/drivers/thermal/thermal_core.c
>>>>> +++ b/drivers/thermal/thermal_core.c
>>>>> @@ -1354,8 +1354,8 @@ thermal_zone_device_register_with_trips(const char *type,
>>>>>
>>>>>         tz->device.class = thermal_class;
>>>>>         tz->devdata = devdata;
>>>>> -     memcpy(tz->trips, trips, num_trips * sizeof(*trips));
>>>>>         tz->num_trips = num_trips;
>>>>> +     memcpy(tz->trips, trips, num_trips * sizeof(*trips));
>>>>
>>>> IIUC, clang-18 is used and supports __counted_by().
>>>>
>>>> Is it possible sizeof(*trips) returns already the real trips array size
>>>> and we are multiplying it again by num_trips ?
>>>>
>>>> While with an older compiler, __counted_by() does nothing and we have to
>>>> multiply by num_trips ?
>>>>
>>>> IOW, the array size arithmetic is different depending if we have
>>>> _counted_by supported or not ?
>>>
>>> IIUC it is just the instrumentation using the current value of
>>> tz->num_trips (which is 0 before the initialization).
>>
>> Right, but I am wondering if
>>
>> 	memcpy(tz->trips, trips, num_trips * sizeof(*trips));
>>
>> 	is still correct with __counted_by because:
>>
>>   (1) if the compiler supports it:
>>
>> 	sizeof(*trips) == 24 bytes * num_trips
> 
> I think you're misunderstanding. The above sizeof() only evaluates a
> single instance -- it has no idea how many more there may be.
> Specifically:
> 
> 	sizeof(*trips) == sizeof(struct thermal_trip)
> 
>> 	then:
>>
>> 	memcpy(tz->trips, trips, num_trips * sizeof(*trips));
>>
>> 	memcpy(tz->trips, trips, num_trips * 24 * num_trips);
>>
>> 	==> memory size = 24 * num_trips^2
> 
> It's not counted twice. Under CONFIG_FORTIFY_SOURCE=y, memcpy is a macro
> that expands to a checking routine (see include/linux/fortify-string.h),
> which is using __builtin_dynamic_object_size() to determine the
> available size of the destination buffer (tz->trips). Specifically:
> 
> 	__builtin_dynamic_object_size(tz->trips)
> 
> When __bdos evaluates a flexible array (i.e. tz->trips), it will see the
> associated 'counted_by' attribute, and go look up the value of the
> designated struct member (tz->num_trips). It then calculates:
> 
> 	sizeof(*tz->trips) /* a single instance */
> 		*
> 	tz->num_trips

Ok my misunderstanding was I thought sizeof() was calling _bdos under 
the hood, so when calling sizeof(flex_array), it was returning the 
computed size inferring from the __counted_by field.


> Before the patch, tz->num_trips is 0, so the destination buffer size
> appears to be of size 0 bytes. After the patch, it contains the
> same value as the "num_trips" function argument, so the destination
> buffer appears to be the matching size of "num_trips * sizeof(struct
> thermal_trip)".
> 
> Hopefully that helps! If not, I can try again. :)

It is ok thanks for the clarification



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


