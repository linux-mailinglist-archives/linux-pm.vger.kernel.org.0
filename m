Return-Path: <linux-pm+bounces-4744-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 982CC873B4F
	for <lists+linux-pm@lfdr.de>; Wed,  6 Mar 2024 16:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23972281F45
	for <lists+linux-pm@lfdr.de>; Wed,  6 Mar 2024 15:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793AA135A5F;
	Wed,  6 Mar 2024 15:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LT+083dN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A169213540D
	for <linux-pm@vger.kernel.org>; Wed,  6 Mar 2024 15:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709740556; cv=none; b=ED/DA8x+21eOeIPklT63J50fF75m5GsUoGdOxo36fPaicWEkT7VVKjAAfmQXtxzrHWEP1ZCStgRSy4Jb4cHnKI6ITlG9CcW0gRUOaPTHwcnxVT3pMmGKoUvdsNTiSzezOde8beQCvouyMWNxHxav4PjRTWwqGnxhcqGKAOFUNYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709740556; c=relaxed/simple;
	bh=S63c2sNZMMYma70DFF7Q9B7pmKfrKJBfr4eRWQ2DWSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D331wtl3XgipEmv9w9bmITXMuO3tr6ziSOwS+EgFlD97X+g1emj2ei88Gg3EsEuW3Am/g+3924UspAHyj3SHBRQycSeLQENawtSol5plq7Or/3sgsUufGOErnaENr0o+czVlpdQto8w/e/mvPbzVh6NGiovtclAcJXBkzgpy/Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LT+083dN; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-412f1fc5613so9387845e9.2
        for <linux-pm@vger.kernel.org>; Wed, 06 Mar 2024 07:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709740553; x=1710345353; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XZt95k/86iLi9wV68qjX2HqV51z+ByDGihNj6bj2L/M=;
        b=LT+083dNGyrPdnoA7flbYtJRIfs2651fBPE9hm/78+ZJ6L3a7QuJQs60zmZbXF651s
         lWKeKqXaoFIOhdCQwqyIsGjJ4/SS0oKVuPS1mct030uOGhqsNOLLygQj4GxOT6K6lL/9
         9aKckZIG+9ADo0D20dDscH/0x885hvPREtrJcIxNoCa97WZJ8Uo7isBPWp+FncLDRf35
         T0zTTZoG4n0LXtXW+xoqqcsvSI9eDVg78h/ReOjqqhoOjKzI2zAYrtDPJROTl/2Gdh+Q
         OIcLgcaEcWpwYYHiwMUxoqVg0VygxT8SriIKpa36UrhGfZj3j4z4EDvxYOT517ZhswWs
         mndQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709740553; x=1710345353;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XZt95k/86iLi9wV68qjX2HqV51z+ByDGihNj6bj2L/M=;
        b=Qp0fjRPcVWTNVgw0N+kJtls6Scd4wUOIBrOfo0DHkAbIRHSb6dkhRfDnXuyIHD9Lmi
         oE/73166Ps2y7oLyLILIfrbOH1RS55EJz3e+Xk6N0L0ML/yTLdXhAkdAIEyesYWxUj5f
         m+P1SFnsMzLv8QLZSLS7OGBrxiUJN5XTNXq4vU/Mi4DwTgsWz7XUjdxjG/dNBq7fJcb+
         lHMZGv6ndv/DgmwsyH0u1McyKySOg0IoA6DHRmUfJ0YqpMVzYWlGHf0lzl5ZTGjpWl2k
         0Zb/xLrMWrDUmduDq/meTMKN3bXt2rACcuB8sTRNVx1iwP1JxQh6E+3LwtAJvMMQls4o
         6i4w==
X-Forwarded-Encrypted: i=1; AJvYcCWQEA5ifU9F1iu/YPp9eUzsgEY8zf2DqVewdN3JVUm5u9EiKlkStw9/QTwARJU7g4K1VHMPUBQS8rWzJj9vkvPH69/6jgUf/xw=
X-Gm-Message-State: AOJu0Yxb2oR3pfwd1Ul54/MlbizPzNCcN6e3j3+M82h0h67IcK6WOYkX
	C2XkKWlU56ybK0rHgnBlTACBJYAW0usbUG+i7r5bRhSTDnLuSD/JarQ4CkN1SG8=
X-Google-Smtp-Source: AGHT+IF8Ps/jDtz8CnXzXspP0aFRnqs7Bqs2fvkUzIE3ZTrMwpDofRipU2owwFHDX9E7zuS//MFTWg==
X-Received: by 2002:a5d:550c:0:b0:33d:a2f7:ab33 with SMTP id b12-20020a5d550c000000b0033da2f7ab33mr10287562wrv.55.1709740552769;
        Wed, 06 Mar 2024 07:55:52 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id f15-20020adffccf000000b0033dedd63382sm17969939wrs.101.2024.03.06.07.55.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 07:55:52 -0800 (PST)
Message-ID: <3bb7c6cf-f7a8-4059-ad8e-02e09c2a44b1@linaro.org>
Date: Wed, 6 Mar 2024 16:55:51 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] thermal/core: Fix trip point crossing events ordering
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 "open list:THERMAL" <linux-pm@vger.kernel.org>
References: <20240306085428.88011-1-daniel.lezcano@linaro.org>
 <CAJZ5v0jAn2F-GH=fguX0+3bG38vyAxfufadtFiBUfg=EjTBh6Q@mail.gmail.com>
 <14651d5b-0f67-4bff-b699-2cd1601b4fb2@linaro.org>
 <CAJZ5v0j6At1DuQYjjbA-fw9Z-jJPhXSVSz=_uLa3KfNMJowYbA@mail.gmail.com>
 <0e7f32aa-b2c3-43d0-8ebe-7118cb6e0edf@linaro.org>
 <CAJZ5v0gWhNqTGpoOH01scCdC51cEnt_8_T5ccqZC6yXPDv9QcA@mail.gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0gWhNqTGpoOH01scCdC51cEnt_8_T5ccqZC6yXPDv9QcA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 06/03/2024 16:41, Rafael J. Wysocki wrote:
> On Wed, Mar 6, 2024 at 2:16 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>> On 06/03/2024 13:53, Rafael J. Wysocki wrote:
>>> On Wed, Mar 6, 2024 at 1:43 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>>>
>>>> On 06/03/2024 13:02, Rafael J. Wysocki wrote:
>>>>
>>>> [ ... ]
>>>>
>>>>>> +#define for_each_trip_reverse(__tz, __trip)    \
>>>>>> +       for (__trip = &__tz->trips[__tz->num_trips - 1]; __trip >= __tz->trips ; __trip--)
>>>>>> +
>>>>>>     void __thermal_zone_set_trips(struct thermal_zone_device *tz);
>>>>>>     int thermal_zone_trip_id(const struct thermal_zone_device *tz,
>>>>>>                             const struct thermal_trip *trip);
>>>>>> --
>>>>>
>>>>> Generally speaking, this is a matter of getting alignment on the
>>>>> expectations between the kernel and user space.
>>>>>
>>>>> It looks like user space expects to get the notifications in the order
>>>>> of either growing or falling temperatures, depending on the direction
>>>>> of the temperature change.  Ordering the trips in the kernel is not
>>>>> practical, but the notifications can be ordered in principle.  Is this
>>>>> what you'd like to do?
>>>>
>>>> Yes
>>>>
>>>>> Or can user space be bothered with recognizing that it may get the
>>>>> notifications for different trips out of order?
>>>>
>>>> IMO it is a bad information if the trip points events are coming
>>>> unordered. The temperature signal is a time related measurements, the
>>>> userspace should receive thermal information from this signal in the
>>>> right order. It sounds strange to track the temperature signal in the
>>>> kernel, then scramble the information, pass it to the userspace and
>>>> except it to apply some kind of logic to unscramble it.
>>>
>>> So the notifications can be ordered before sending them out, as long
>>> as they are produced by a single __thermal_zone_device_update() call.
>>>
>>> I guess you also would like the thermal_debug_tz_trip_up/down() calls
>>> to be ordered, wouldn't you?
>>
>> Right
> 
> I have an idea how to do this, but it is based on a couple of patches
> that I've been working on in the meantime.
> 
> Let me post these patches first and then I'll send a prototype patch
> addressing this on top of them.

That is awesome, thanks !

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


