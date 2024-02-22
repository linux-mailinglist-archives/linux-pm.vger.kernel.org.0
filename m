Return-Path: <linux-pm+bounces-4277-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45DA885FC82
	for <lists+linux-pm@lfdr.de>; Thu, 22 Feb 2024 16:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69B8F1C23BCF
	for <lists+linux-pm@lfdr.de>; Thu, 22 Feb 2024 15:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7D614D435;
	Thu, 22 Feb 2024 15:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SN8JBdHC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9A35B1E1
	for <linux-pm@vger.kernel.org>; Thu, 22 Feb 2024 15:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708616205; cv=none; b=pQJE3bJY/bDBD2fV5Fs0DJNG+ybcOtZoXpIrTq2+lA7vKg2vM4gJCI4PqtjyU4wj6x+KEb0mEtRRSmZ/HRnQdwL5y6VoPd5JCnN7A6WOdEnC5Fi4XWfsdV6JaXSahzKgKGX0FMJbE5fZJkiUx5UsOo6gTZ5PYGyCMOHn8dvPQIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708616205; c=relaxed/simple;
	bh=nWluQmQSxTtCEtML6EbHWkhsqKBWuwPsQCaDpck1C+Y=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=InhxVyHULEhUR6ulQ5Y2m+dd1xAd81IIdNS+Nu+fAN/5wEovoIhWPXs6Mbd7sUCZygx1OqPkjESYBfw/6N6QqcL0nYJPAZAF9Ie27u9TY2cAcruSiFSHoEgPIRdqPzNQJyVInhwn1v3RdJGMPoID5DQiyiveSQXmD7atrROBfIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SN8JBdHC; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41274cada64so15544755e9.1
        for <linux-pm@vger.kernel.org>; Thu, 22 Feb 2024 07:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708616202; x=1709221002; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rG6qiCLfCPQEkL7kZtcdTc5M6/ygLvFUYyUXsw8H8Iw=;
        b=SN8JBdHCgDQQxrbmJ3nO1/SEdn11RkIx4NMUeIoK5duVgWpH744v3Ow8tqH8N7v+sS
         tUJGwYIfr8kreKCU4e9CRTB8CRJCZdcU0al9F552/WZanlHXGwwR7KLdZN/SxLVTrmau
         DzLCkBY4cxgHTT1R+oYhDDkbREMtkRxosTWQA3E3pjVTRLpiE7M4yLpO/28hlHq/1ELc
         5lCjk/GuSNJZwKV6dhcfPdIz3BZw6SRThKklVf5b2wAPxA7jyMR3U2AgAGs+syEMRUCF
         bT6PrbbPEvb4KxGJn2JRx504ztfX+PlML4mcuTyUt6FOnDPOQjip4gbBrKWi9SRWaARC
         8Iyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708616202; x=1709221002;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rG6qiCLfCPQEkL7kZtcdTc5M6/ygLvFUYyUXsw8H8Iw=;
        b=tAxyZ/Y/DQ9EWp/iNNx+eN9pHuAZjczoNKucejCMicf5DLdnwFN5ee0/6atdnCMe6y
         S+q1mhSUlwekVJSe32PZhD4dEW5+NXdhb+RU4fSG5c6BCMXw3hxHHF9f1MIgzFj8vi5H
         sEi6sWF4ZAqsKcurlBJis2q9PWFa5Xzq1IaLWOM0PUnnqUPkg8qk8ElHbDCEWVAcYf+X
         s0W7Yyy3sbr1WOgRKPrr2V8/yY0hlhnLoefXzHQl3MsroGtMziCrvaEIQmflu/WJJm9s
         nIynbuhtxxUTFgAp/oVeeipg19wNDGwzKYadeYLueqjBs/rJGMT0kY9ljS3QheOqgztD
         aZAg==
X-Forwarded-Encrypted: i=1; AJvYcCV7tugiECJsatdhkARAq5jBZx/d81cnWJQ2TlUv3RmzUvMz3mR0etjnkhSREIlWbRnAkxz0mdouwdxGNP4Y6ELKWgEjNcJwmEc=
X-Gm-Message-State: AOJu0Yy1tTgoGQs5AjRI2VN2wn/mxzjsBe6xvMMpsU0NFfbS5DAbQRss
	pL3V4FLOmUtS6wMzBLCqjNtCwnXLbKUY1hFMFBKUt0wKytOnWlV/6O2D1o4oLHw=
X-Google-Smtp-Source: AGHT+IFHbETJ2129o/mnz9ZnTgSGCEXTNSuh9KppLAt7VStuR79XrDMNMALrvv6J1CYjR2CbD0dmig==
X-Received: by 2002:a05:600c:a39d:b0:410:ed31:9e96 with SMTP id hn29-20020a05600ca39d00b00410ed319e96mr15929865wmb.11.1708616201864;
        Thu, 22 Feb 2024 07:36:41 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ba24-20020a0560001c1800b0033d9ee09b7asm315655wrb.107.2024.02.22.07.36.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 07:36:41 -0800 (PST)
Message-ID: <ad3bc3e4-bff8-43be-b853-3d1ca0b5d0de@linaro.org>
Date: Thu, 22 Feb 2024 16:36:40 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] thermal: core: Add flags to struct thermal_trip
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: Lukasz Luba <lukasz.luba@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, netdev@vger.kernel.org,
 Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 linux-wireless@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
References: <6017196.lOV4Wx5bFT@kreacher> <2173914.irdbgypaU6@kreacher>
 <59e8fd70-5ba6-4256-9127-bd5e76e6bc99@linaro.org>
In-Reply-To: <59e8fd70-5ba6-4256-9127-bd5e76e6bc99@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22/02/2024 15:36, Daniel Lezcano wrote:
> On 12/02/2024 19:31, Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> In order to allow thermal zone creators to specify the writability of
>> trip point temperature and hysteresis on a per-trip basis, add a flags
>> field to struct thermal_trip and define flags to represent the desired
>> trip properties.
>>
>> Also make thermal_zone_device_register_with_trips() set the
>> THERMAL_TRIP_FLAG_RW_TEMP flag for all trips covered by the writable
>> trips mask passed to it and modify the thermal sysfs code to look at
>> the trip flags instead of using the writable trips mask directly or
>> checking the presence of the .set_trip_hyst() zone callback.
>>
>> Additionally, make trip_point_temp_store() and trip_point_hyst_store()
>> fail with an error code if the trip passed to one of them has
>> THERMAL_TRIP_FLAG_RW_TEMP or THERMAL_TRIP_FLAG_RW_HYST,
>> respectively, clear in its flags.
>>
>> No intentional functional impact.
>>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> ---

>> ===================================================================
>> --- linux-pm.orig/drivers/thermal/thermal_core.c
>> +++ linux-pm/drivers/thermal/thermal_core.c
>> @@ -1356,13 +1356,23 @@ thermal_zone_device_register_with_trips(
>>       tz->devdata = devdata;
>>       tz->trips = trips;
>>       tz->num_trips = num_trips;

[ ... ]

>> +    if (num_trips > 0) {
> 
> Is this check really necessary? for_each_trip() should exit immediately 
> if there is no trip points.

Given that is removed in patch 9/9, please ignore this comment

>> +        struct thermal_trip *trip;
>> +
>> +        for_each_trip(tz, trip) {
>> +            if (mask & 1)
>> +                trip->flags |= THERMAL_TRIP_FLAG_RW_TEMP;
>> +
>> +            mask >>= 1;
>> +        }
>> +    }

[ ... ]

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


