Return-Path: <linux-pm+bounces-10169-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 399A691B95E
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 10:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8B241F228BD
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 08:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10C614290E;
	Fri, 28 Jun 2024 08:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GSozCNB1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A92F4436A
	for <linux-pm@vger.kernel.org>; Fri, 28 Jun 2024 08:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719561882; cv=none; b=WNsuBCKZxHM1S323emf8HoEdAFSTZ0HIIVInUB/zMQbv09v/LOFgAY7gmvekBFlrUlTzTIbnvFpy7A+sPzeRkVqivHV4UnpYQhrh6AJWZjCRBrSaAghWjkY3snsaz+RqUXdRKE+KVqmaO5Zig1LCwLjwhCN+ts7/P2g/CPxh4HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719561882; c=relaxed/simple;
	bh=wra5UCLuXTxotyh08u84Jn9mFxoB6C9fDzA1wJD33xk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OGEOURw76DIVVMBLyCQULC0DiZ7IdkoM6IyWWNaZKvnv0XUI7AObiWaJrjJzgltRigfoKO4oVoGCELhBQkzXM9jAOREcbeeK15eRQLrRDlRkKKYI/nLYuzNfghAfJUF6LpWVZUQ8rUf9xGNX5qFCnlirBx6g64uZBBHC0YrIqG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GSozCNB1; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ebe0a81dc8so4002341fa.2
        for <linux-pm@vger.kernel.org>; Fri, 28 Jun 2024 01:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719561879; x=1720166679; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UvCwVubOhRTBJsAzpmAfKG0t0pfhxycVa3K5Jo7OmcI=;
        b=GSozCNB1OaMQrDdjrttgyMhNdJ3OkEB+O0ldBmj1+k1qpcC0ts9W80BGtSZGXnCrdU
         nKnv75N7vrWnVbo8ADJpm7WQilqvxLqnzUcEHGCIY/A09k9OMcKVKEllXjikFRNJ1WjW
         fiaAdYi7G7VJSm+DTLJfpaE+2eAtGX6IB1CoXzUzrquW6t3ruWkzQTygqy0hbKYTnE6b
         Fhi1GM72AJPx+UZfPo7gynqe95k6tltivUZ/6/6MYZg8k19aqDj3B2kDnYsCEqaa20j4
         9jAHhEF+G0yNtrFDOGxcery1CJ+4TocYBB/FlNH+JOqI98UHV3Lpks9479TVtCY9yjys
         FueQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719561879; x=1720166679;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UvCwVubOhRTBJsAzpmAfKG0t0pfhxycVa3K5Jo7OmcI=;
        b=k/w2a8kwpYiasbj+u3diA9/GhjXDbkULRHCp+bKExjEfGYZ1zjk7Xv3au55pnkqfnq
         OabcLRFdsF4+j/h4J7DCGP1H8Mds21RHui9HvL1lf5+99tYAKKsrMkq582zHUazflh10
         xVWBTUckWeWBmyi/CLCKJPoBLwlXWp1HQsKYrI4PUjhfcu7yx2GCmhZ/rgYF9UIg+l2N
         AWlALqa1IjGLsGjVsKKhrZ2s3fWbgWztFM/ZcPtAypfisujwOpZzceXNPUo3UwHjAmyc
         RCvba3ivo1rNgJ9qK1aQR6fzb4hHj6GJC6XVwXFcf6W+oQdI0K90dWrzsK92GURnJnBe
         645w==
X-Gm-Message-State: AOJu0Yy11OXwCzOYB5FiNhpcx6PABY5nWJu3dy+KP3RILqckSrYFlbHV
	qRDjooZNoJAoIBCGW2r5UDdLRrDFh5zMRhtv2q4BqwrhdrF1vzH8YzZpTuiiqC2Cd/t1OWpfKhA
	1
X-Google-Smtp-Source: AGHT+IFgOXven3W8dxZY8Bv1Rq/0KZ+pA7OFDhy9LjdbkovQB+9+jTpDYApaQ0WOTZk3ZHM5nxHuaQ==
X-Received: by 2002:a2e:9213:0:b0:2ec:4de9:7334 with SMTP id 38308e7fff4ca-2ec5b2fd2bdmr116872971fa.11.1719561879092;
        Fri, 28 Jun 2024 01:04:39 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4256b0c161csm22968625e9.46.2024.06.28.01.04.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jun 2024 01:04:38 -0700 (PDT)
Message-ID: <ff495355-3a9f-422b-b9c8-707f7e35ba43@linaro.org>
Date: Fri, 28 Jun 2024 10:04:38 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Trip points crossed not detected when no cooling device bound
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM mailing list <linux-pm@vger.kernel.org>,
 Lukasz Luba <Lukasz.Luba@arm.com>
References: <dc1e6cba-352b-4c78-93b5-94dd033fca16@linaro.org>
 <CAJZ5v0iu9dg-tzfzZH5vfDZAv_OD1PKiZwaU-Q07Jz0-ULjtYg@mail.gmail.com>
 <a1600a02-18e1-4e5c-bb64-6b1058a09fe5@linaro.org>
 <025ac119-e940-4dfb-aff6-9bd6121eb5c6@linaro.org>
 <CAJZ5v0htedijN5V9NFY8JXejuvvEASrGTpz=NG_5uBYnK0soCg@mail.gmail.com>
 <43ded807-be8d-4673-ab8c-1ed2a5a32077@linaro.org>
 <CAJZ5v0g0=k4HZhKhs=2iwO8zc=jkng898wF-nn_bUT-xA_iu6w@mail.gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0g0=k4HZhKhs=2iwO8zc=jkng898wF-nn_bUT-xA_iu6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 27/06/2024 20:23, Rafael J. Wysocki wrote:
> On Thu, Jun 27, 2024 at 6:30 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 27/06/2024 11:54, Rafael J. Wysocki wrote:
>>> On Thu, Jun 27, 2024 at 12:24 AM Daniel Lezcano
>>> <daniel.lezcano@linaro.org> wrote:
>>>>
>>>> On 26/06/2024 23:21, Daniel Lezcano wrote:
>>>>
>>>> [ ... ]
>>>>
>>>>>> Oh, I see where the problem can be.  If the zone is polling only, it
>>>>>> will not rearm the timer when the current zone temperature is invalid
>>>>>> after the above commit, so does the attached patch help?
>>>>>
>>>>> At this point, I went far when bisecting another problem and I ended up
>>>>> screwing my config file. So I had to generate a new one from the default
>>>>> config. Since then the issue is no longer happening which sounds very
>>>>> strange to me.
>>>>>
>>>>> I'm still investigating but if you have a suggestion coming in mind, it
>>>>> would be welcome because I'm failing to find out what is going on ... :/
>>>>
>>>> I finally reproduced the issue. That happens when there is *no* cooling
>>>> device bound on *any* thermal zones.
>>>
>>> Interesting.
>>>
>>>> Your patch seems to fix the problem but I'm not sure to understand the
>>>> conditions of the bug
>>>
>>> It's probably the same as for commit 202aa0d4bb53:
>>> thermal_zone_device_init() sets tz->temperature to
>>> THERMAL_TEMP_INVALID and if the first invocation of
>>> __thermal_zone_get_temp() returns an error (because the .get_temp()
>>> callback returns an error), monitor_thermal_zone().  If polling is the
>>> only way in which the zone temperature can be updated, things go south
>>> because the timer is not set and there is no other way to set it.  No
>>> updates will be coming
>>
>> If there is no polling delay (aka interrupt driven), the routine will
>> skip the _set_trips function and the monitor_thermal_zone() will do
>> nothing in this case, right ?
> 
> _set_trips() looks at tz->temperature, however, and it doesn't make
> sense to call it if the latter is invalid.
> 
> Same for handle_thermal_trip() and governor callbacks.
> 
>> Even setting a label jump to "monitor:" the routine is broken AFAICT
> 
> I beg to differ.
> 
> Yes, monitor_thermal_zone() does nothing if there is no polling, but
> it needs to be called anyway because it checks whether or not polling
> is there in the first place.
> 
> And if there is no polling, it is assumed that
> __thermal_zone_device_update() will be called by other means.

AFAICT, the interrupt can fire and it will result in a 
thermal_zone_device_update() but the interrupt must be setup by 
__set_trips() which is skipped because of the invalid temperature.

I've confirmed that with my evb board.

  - trips point
  - no polling delay (interrupt based)
  - no cooling device

That does not work, there is no trip crossed notification.

>>> The reason why the presence of cooling devices can "fix" this is
>>> because thermal_bind_cdev_to_trip() sets tz->need_update to 1 which
>>> then causes the thermal_zone_device_update() in
>>> __thermal_cooling_device_register() to trigger and that will update
>>> the temperature.
>>
>> IIUC, the first time get_temp() fails and then when the tz is bound, the
>> update triggers a new call with get_temp() which returns a valid
>> temperature ?

Ok, I can see another glitch here. Actually the thermal_of is calling 
thermal_of_zone_register() which in turn calls 
thermal_zone_device_enable(). However, the driver can be not fully setup 
yet (eg. rockchip_thermal.c), so it results in an error in get_temp and 
an invalid temperature.

With the aforementioned setup, that leads to a broken thermal platform 
because no trip notification will happen.

All this result in a fragile code :/

That is working only because there is a cooling device bound to the 
thermal zone which happens after the sensor is fully setup.

IMO, we should be much less resilient to .get_temp failing ...

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


