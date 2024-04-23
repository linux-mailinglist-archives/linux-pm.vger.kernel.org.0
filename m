Return-Path: <linux-pm+bounces-6952-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 425688AF64E
	for <lists+linux-pm@lfdr.de>; Tue, 23 Apr 2024 20:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F40A3295B17
	for <lists+linux-pm@lfdr.de>; Tue, 23 Apr 2024 18:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9E913E3F8;
	Tue, 23 Apr 2024 18:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hs/z0vmp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A5A339A8
	for <linux-pm@vger.kernel.org>; Tue, 23 Apr 2024 18:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713895787; cv=none; b=U3zZorU6xC65sgB7OwrgC+S83pF64wtJfGy99ZNZEmmU90vMLDyvN+w2laz4o0iKMHlYrvLc4h/uL3V+ZSDUTv3NBp9tmp3nTBlmi8VMZkztlUAbUb0KLOWG7o7UGaL5lsCfJqnomkFUtKJ34Hm3Xiylm+8ZQ1WODOTobFIUEwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713895787; c=relaxed/simple;
	bh=FF7iWnaWE+9ecuoFHYzt6Gxh4VQLPipcHvypjs7PkEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bgZeohIr9+CBXcTNJUD9okAoIfffp1Es+NHYsRmojakr9SJVB57XO7+cz8Mous8RrZOARb06DnyLHIr8q4I/gFSH42fJNNB0EwoA8HnVQ5Djb+9O5Axg9NM+fn+1EOIb3mldn+pv1eGEa8D8F/6plUHUwCykhfobOnofFbWr+6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Hs/z0vmp; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-346f4266e59so4362476f8f.3
        for <linux-pm@vger.kernel.org>; Tue, 23 Apr 2024 11:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713895782; x=1714500582; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=49AEZ8yLm4WjNc+IjD5cDuG0qOxIOXTYKsg3bQTJ5pE=;
        b=Hs/z0vmp6DirfxhbJseZPfOsEpjMiZvVHKBcKPuolqxIxlcDGiNXUYu9OM46VFPxhy
         prC6puy+T8Ut7RCBatedR6D+kI9FPioJu9t0mSdySRAcsTsUUhtG6RoE9i6QKK+5hKWy
         ga4937LFA3AKC182X+878unhtgIMGtDo18EbPDO2LDq3o2bHLfITWuRltVf9A3nOvm+7
         owSPoN0mX/ZdOpMfc5SUDeFbYY8RLhfS6RieKOs58YxijYcnk3BuRLjRrFdLbnoZFSFp
         5LWtStbI/zc1U3tFyiiSrIAdR8bQz7UPhJO/tQvaqdQPW0EpUtS6eWt8/6jzT+Ys90Ow
         SKvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713895782; x=1714500582;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=49AEZ8yLm4WjNc+IjD5cDuG0qOxIOXTYKsg3bQTJ5pE=;
        b=Kp70kPcHceFhPjoxPykzbo0ko7p+AvnnJ8OYZ59Veb7IzSl7UZFkdBS8Yz3i7gUQ6r
         D6jmL/5vR+3Ogdkyrdc9H3BD3HY4d7NxMCw3s1OyCOSHABOqycZnrYEZXDB3OHonaMhl
         yPW34E3AE0eZZEETEKG/nj2AMXi+FQwK2EGtU4MBB2yAPQVB6088m+hjN6uT2bWS3oEW
         SwtUzLRLMrrSxasYOalRJCqa6Ehf+g8RIzMEHnpIE+z8VJ38m5G3Rx+hss6M9ZHrKtK9
         fPheM/4rQY7e6CfJcKZnx7XBM+XusVCp0RgOBdTsFkrfcBROlAAAOMlIyNXNliBB2O4G
         QTRw==
X-Forwarded-Encrypted: i=1; AJvYcCXQEXJ4uZwy9PMMGIyrwBrR3Z3dnWnIYh3pVM3lQo1HtkAsU7psKb70vVH8iJN0ZRZx8LZKh4SYfb/SuLMeSlyt6KiirobR7ko=
X-Gm-Message-State: AOJu0YwYCt7xmxQ5/hp7bFKAa2G/+88gx2EwfCQKr6FbHKY36rVurlW3
	QkJVYoksdyfSRZ0g1sQnSqA2DPvn+n0gVL42paLpZYzxnyHlqHGsKD9haGRqO1c=
X-Google-Smtp-Source: AGHT+IGsQSohpAha/LsPn9O8PrE8OTf9iZxKAOzgt6KZdJrEzjYJHiG+lRT+Cc410bAZPw8KyTCb2Q==
X-Received: by 2002:adf:e542:0:b0:34a:4d1:b913 with SMTP id z2-20020adfe542000000b0034a04d1b913mr10130089wrm.52.1713895782586;
        Tue, 23 Apr 2024 11:09:42 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id a3-20020adffb83000000b0034b32e5e9ccsm4726273wrr.64.2024.04.23.11.09.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 11:09:42 -0700 (PDT)
Message-ID: <61560bc6-d453-4b0c-a4ea-b375d547b143@linaro.org>
Date: Tue, 23 Apr 2024 20:09:41 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 07/16] thermal: gov_power_allocator: Eliminate a
 redundant variable
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <13515747.uLZWGnKmhe@kreacher> <1913649.CQOukoFCf9@kreacher>
 <8e26c3cb-1283-4561-95aa-30432f1d13ee@linaro.org>
 <CAJZ5v0h=15LYhukPWmHPK5hvD=2u75rTEiC8oJMVBFziMkB5gQ@mail.gmail.com>
 <33cafcb3-af9c-4058-b6b6-4e5aab6e21cb@linaro.org>
 <CAJZ5v0hR-fN08g-g_S261e+U=2Enfza3b9NZpmp4yhzAa=426A@mail.gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0hR-fN08g-g_S261e+U=2Enfza3b9NZpmp4yhzAa=426A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 23/04/2024 20:05, Rafael J. Wysocki wrote:
> On Tue, Apr 23, 2024 at 8:00 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 23/04/2024 19:54, Rafael J. Wysocki wrote:
>>> On Tue, Apr 23, 2024 at 7:35 PM Daniel Lezcano
>>> <daniel.lezcano@linaro.org> wrote:
>>>>
>>>> On 10/04/2024 18:12, Rafael J. Wysocki wrote:
>>>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>>
>>>>> Notice that the passive field in struct thermal_zone_device is not
>>>>> used by the Power Allocator governor itself and so the ordering of
>>>>> its updates with respect to allow_maximum_power() or allocate_power()
>>>>> does not matter.
>>>>>
>>>>> Accordingly, make power_allocator_manage() update that field right
>>>>> before returning, which allows the current value of it to be passed
>>>>> directly to allow_maximum_power() without using the additional update
>>>>> variable that can be dropped.
>>>>>
>>>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>> ---
>>>>
>>>> The step_wise and the power allocator are changing the tz->passive
>>>> values, so telling the core to start and stop the passive mitigation timer.
>>>>
>>>> It looks strange that a plugin controls the core internal and not the
>>>> opposite.
>>>>
>>>> I'm wondering if it would not make sense to have the following ops:
>>>>
>>>>           .start
>>>>           .stop
>>>>
>>>> .start is called when the first trip point is crossed the way up
>>>> .stop is called when the first trip point is crossed the way down
>>>>
>>>>     - The core is responsible to start and stop the passive mitigation timer.
>>>>
>>>>     - the governors do no longer us tz->passive
>>>>
>>>> The reset of the governor can happen at start or stop, as well as the
>>>> device cooling states.
>>>
>>> I have a patch that simply increments tz->passive when a passive trip
>>> point is passed on the way up and decrements it when a passive trip
>>> point is crossed on the way down.  It appears to work reasonably well.
>>
>> Does it make the governors getting ride of it ? Or at least not changing
>> its value ?
> 
> Not yet, but I'm going to update it this way.  The governors should
> not mess up with tz->passive IMV.

+1

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


