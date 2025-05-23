Return-Path: <linux-pm+bounces-27619-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF17AC2B83
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 23:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA5637A16F5
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 21:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685E5202F79;
	Fri, 23 May 2025 21:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MzQXetTV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973C63D76;
	Fri, 23 May 2025 21:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748036854; cv=none; b=BRV0z2ezXVonB4YCvzQxhIr2OGaSgBHy8EIyxbG2RDR4bM9Ajj7t3NsgW+X7Ef2imtL89gdwr5zHCckmXr/tZksb0MhhaGrNresov90XyD+FL4A2LnmlN5mMGRADftKj1eAdG3gYGPz1bhRHQK6E3reh9Mj+ODc0XoxLTkU+Lqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748036854; c=relaxed/simple;
	bh=fhPAlDbOG5HyAawH7JLmusZbx+86SF4MxmwX95wKXpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oWEsBAJTxo1evYrAjIZeV1SmkoELMvIJMN14Mr9L13kCTr8NmO5KD7BzqopG7ruNgkETAREKIBMDFRNgYETz9LCRGVNfxocVylNwLd9PP+6amyzQcAzkZJlHrWJzfPJu+Z8PfXl/7+/I1iEBwG53RWV2wlTfblHlnBwmVqwvBF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MzQXetTV; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e7c5d470a8bso303263276.0;
        Fri, 23 May 2025 14:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748036850; x=1748641650; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hGy2ccPh/CViJ6eWW2JFWtauMqcjGtl82E9Hd+SYN9U=;
        b=MzQXetTVgIdXoVhRfXcUheyruR9DI+cnqCZ+0OmkhI++cNMDiWszNU/9ADJHvlf3Gk
         MDM18mYSbC0fa0gZ1Dt7cvwLKIZLLLyHEjiWGAfPAV5Xw4mqaUATGL3R0i1BO0hkGSA3
         DBghrLlTtQ5CV7VijPJ4ogp+4iLHRl1udX/vVFWkDGpw1Yb3f4gxE0BWxKpi+b+CI7Lv
         f9p5fOwiVUyk5DZG97LkwqudI/3aJjuz/t5D6vbjRLIEozb2moaCMj6058PX2L8LtIEZ
         cgsiVJ/vth8F9lXo81Wo7aBBz/K1tSJ2r7CO2cZinKrSWr90hDn+d/6HSalHLML71vM6
         cqwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748036850; x=1748641650;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hGy2ccPh/CViJ6eWW2JFWtauMqcjGtl82E9Hd+SYN9U=;
        b=IiV/mS6RqnLDFQZPrCReejPGwInTbEKmVipQFoZTj2124BwWrTu7JWHdm6J+QIPe6v
         6XUR7YNb6dvUSIo4cciRxjzcvOgMu78y2PPzHkebHu30SAykMBclyVxawsR7xyT80G4v
         bY/PjSspGFeS/bNU7QdQTidGDGVM0EaCvjA9L314wH0Oqp4aVkKGD1pZWRV7Wy3iSfpI
         WJv7raioANJszX9wgtgoVYrk17kZdWBoyhlKvgNOqDNdvKzun6gMRav+nF0jBRiknmv2
         WC0403ufLoxLi2KbEpeTXoKieiTmJ5A5BlwRKWPWXYIgTq6VZTT4AVN2tJx7nCpaGmHt
         UVPg==
X-Forwarded-Encrypted: i=1; AJvYcCWftpNZgBmQSHZ07T5rEEOjvlsA345/D5TOn7Zd+LcfN4pApthf7cKmd5sCD+71axzgNo+k+D+wz/Q=@vger.kernel.org, AJvYcCXaXucLMoWdUszwiDsQy27hEY3AxGNuEXb4h6VTaBXs0YT0GfKWhbHI/L1Oht9NxExE3c6HFccMWmo=@vger.kernel.org, AJvYcCXmpAgliCdGayUg/ujCjX4dUrdWeQGgTfuQy+KP3MIPogdkJKqLBR0bAxa2ZXNRBFcijG4wz5tkrjj6PefB@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/FrrE/KjB3Y93Oxzc7B+4VEqh5H9MkVu0Pwt53r+uTMX4Daqn
	mU7M7TWfjgS4BFP3Ayvj+3KDRuBeRszUCYznyLgKmqT43zEzUuqGkqqU
X-Gm-Gg: ASbGncux/zTVdSPCz7z3/R+rb083VbZjRg+FkZWw2kotjGDiPl4bXIS/u2eNt3JrLEJ
	pGUCl3YMa5JMJW+fBF7SeJJE0+tLkUICD8dCmZJq8fY6p601BL8lcTsly+pe+/5GlLU80ebuqOn
	I2pZ3qYhK18g/WmSVLGXTJCqMAFWR7sYB1/1sSA0bDnABVbwBa6GdtZtCMvn6NnG9p7Nfxd5V8x
	d1L8uFCt8dGmooGDycJFqmN/cmz2YN00cwFqe2DzFipQhqqnqHVHMJ4KFba7P8r/VDUcrmlVLOd
	6f5gtlJgTv5F7mg4lxVlaLH++B76aXLObEz+llJOHiArSK19RjCxPJ45gRUFSJjlg4Y=
X-Google-Smtp-Source: AGHT+IEK2ofhGIZM2ngoU8KxP4VorOYY4yaj08SlJ8NBjEZfjg6fX/L29sdxg6et0J1FWHwQ+3AfUA==
X-Received: by 2002:a05:6902:1587:b0:e7d:6ee0:17ac with SMTP id 3f1490d57ef6-e7d9176d4c3mr1400817276.9.1748036850364;
        Fri, 23 May 2025 14:47:30 -0700 (PDT)
Received: from ?IPV6:2600:6c56:7d00:582f::64e? ([2600:6c56:7d00:582f::64e])
        by smtp.googlemail.com with ESMTPSA id 3f1490d57ef6-e7b6adcce03sm5506559276.50.2025.05.23.14.47.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 May 2025 14:47:29 -0700 (PDT)
Message-ID: <60d84153-9ccf-45c1-8b5b-71d51a59aacd@gmail.com>
Date: Fri, 23 May 2025 16:47:28 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq, docs: (userspace governor) add that actual freq
 is >= scaling_setspeed
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Shashank Balaji <shashank.mahadasyam@sony.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shinya Takumi <shinya.takumi@sony.com>
References: <20250522-userspace-governor-doc-v1-1-c8a038e39084@sony.com>
 <15871c67-0d18-430f-935e-261b2cda855b@gmail.com>
 <CAJZ5v0gz3Y+RGqBf9E1hzq9rwfrryd98Xpk51DtLd-uck5y-rw@mail.gmail.com>
 <b62c0462-8185-4eb8-8ac6-7f2abc387768@gmail.com>
 <aC_4yLsFVVszI_FA@JPC00244420>
 <CAJZ5v0g1o03La9aWJF1rheC9CM8SU2iC52auEAnaBpUCMunpJA@mail.gmail.com>
Content-Language: en-US
From: Russell Haley <yumpusamongus@gmail.com>
In-Reply-To: <CAJZ5v0g1o03La9aWJF1rheC9CM8SU2iC52auEAnaBpUCMunpJA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/23/25 2:06 PM, Rafael J. Wysocki wrote:
> On Fri, May 23, 2025 at 6:25 AM Shashank Balaji
> <shashank.mahadasyam@sony.com> wrote:
>>
>> Hi Russell,
>>
>> On Thu, May 22, 2025 at 06:15:24AM -0500, Russell Haley wrote:
>>>> The userspace governor requests a frequency between policy->min and
>>>> policy->max on behalf of user space.  In intel_pstate this translates
>>>> to setting DESIRED_PERF to the requested value which is also the case
>>>> for the other governors.
>>>
>>> Huh.  On this Skylake box with kernel 6.14.6, it seems to be setting
>>> Minimum_Performance, and leaving desired at 0.
>>>
>>>> echo userspace | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
>>> userspace
>>>> echo 1400000 | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_setspeed
>>> 1400000
>>>> sudo x86_energy_perf_policy &| grep REQ
>>> cpu0: HWP_REQ: min 14 max 40 des 0 epp 128 window 0x0 (0*10^0us) use_pkg 0
>>
>> Oh cool, I didn't know about x86_energy_perf_policy.
>>
>> Consider the following on a Raptor Lake machine:
>>
>> 1. HWP_REQUEST MSR set by intel_pstate in active mode:
>>
>>         # echo active > intel_pstate/status
>>         # x86_energy_perf_policy -c 0 2>&1 | grep REQ
>>         cpu0: HWP_REQ: min 11 max 68 des 0 epp 128 window 0x0 (0*10^0us) use_pkg 0
>>         pkg0: HWP_REQ_PKG: min 1 max 255 des 0 epp 128 window 0x0 (0*10^0us)
>>         # echo 2000000 > cpufreq/policy0/scaling_min_freq
>>         # echo 3000000 > cpufreq/policy0/scaling_max_freq
>>         # x86_energy_perf_policy -c 0 2>&1 | grep REQ
>>         cpu0: HWP_REQ: min 26 max 39 des 0 epp 128 window 0x0 (0*10^0us) use_pkg 0
>>         pkg0: HWP_REQ_PKG: min 1 max 255 des 0 epp 128 window 0x0 (0*10^0us)
>>
>>         scaling_{min,max}_freq just affect the min and max frequencies
>>         set in HWP_REQEST. desired_freq is left at 0.
>>
>> 2. HWP_REQUEST MSR set by intel_pstate in passive mode with userspace
>> governor:
>>
>>         # echo passive > intel_pstate/status
>>         # echo userspace > cpufreq/policy0/scaling_governor
>>         # cat cpufreq/policy0/scaling_setspeed
>>         866151
>>         # x86_energy_perf_policy -c 0 2>&1 | grep REQ
>>         cpu0: HWP_REQ: min 11 max 68 des 0 epp 128 window 0x0 (0*10^0us) use_pkg 0
>>         pkg0: HWP_REQ_PKG: min 1 max 255 des 0 epp 128 window 0x0 (0*10^0us)
>>         # echo 2000000 > cpufreq/policy0/scaling_setspeed
>>         # x86_energy_perf_policy -c 0 2>&1 | grep REQ
>>         cpu0: HWP_REQ: min 26 max 68 des 0 epp 128 window 0x0 (0*10^0us) use_pkg 0
>>         pkg0: HWP_REQ_PKG: min 1 max 255 des 0 epp 128 window 0x0 (0*10^0us)
>>
>>         scaling_setspeed only changes the min frequency in HWP_REQUEST.
>>         Meaning, software is explicitly allowing the hardware to choose
>>         higher frequencies.
>>
>> 3. Same as above, except with strictuserspace governor, which is a
>> custom kernel module which is exactly the same as the userspace
>> governor, except it has the CPUFREQ_GOV_STRICT_TARGET flag set:
>>
>>         # echo strictuserspace > cpufreq/policy0/scaling_governor
>>         # x86_energy_perf_policy -c 0 2>&1 | grep REQ
>>         cpu0: HWP_REQ: min 26 max 26 des 0 epp 128 window 0x0 (0*10^0us) use_pkg 0
>>         pkg0: HWP_REQ_PKG: min 1 max 255 des 0 epp 128 window 0x0 (0*10^0us)
>>         # echo 3000000 > cpufreq/policy0/scaling_setspeed
>>         # x86_energy_perf_policy -c 0 2>&1 | grep REQ
>>         cpu0: HWP_REQ: min 39 max 39 des 0 epp 128 window 0x0 (0*10^0us) use_pkg 0
>>         pkg0: HWP_REQ_PKG: min 1 max 255 des 0 epp 128 window 0x0 (0*10^0us)
>>
>>         With the strict flag set, intel_pstate honours this by setting
>>         the min and max freq same.
>>
>> desired_perf is always 0 in the above cases. The strict flag check is done in
>> intel_cpufreq_update_pstate, which sets max_pstate to target_pstate if policy
>> has strict target, and cpu->max_perf_ratio otherwise.
>>
>> As Russell and Rafael have noted, CPU frequency is subject to hardware
>> coordination and optimizations. While I get that, shouldn't software try
>> its best with whatever interface it has available? If a user sets the
>> userspace governor, that's because they want to have manual control over
>> CPU frequency, for whatever reason. The kernel should honor this by
>> setting the min and max freq in HWP_REQUEST equal. The current behaviour
>> explicitly lets the hardware choose higher frequencies.
> 
> Well, the userspace governor ends up calling the same function,
> intel_cpufreq_target(), as other cpufreq governors except for
> schedutil.  This function needs to work for all of them and for some
> of them setting HWP_MIN_PERF to the same value as HWP_MAX_PERF would
> be too strict.  HWP_DESIRED_PERF can be set to the same value as
> HWP_MIN_PERF, though (please see the attached patch).

The other governors have been around a lot longer than HWP, though, and
and are used on non-Intel hardware, which may not have a, "this
frequency or higher subject to firmware heuristics," interface.

I tried this on a non-HWP Haswell machine, and there it works like
DESIRED=MIN. Or maybe DESIRED=MAX=MIN; I don't understand when or why
hardware would choose frequencies between DESIRED and MAX (before module
coordination).

IMO, intel_cpufreq_target() being wired up to HWP_MIN_PERF is actually
*more* strange for the other governors than for userspace, because at
least with userspace governor, the userspace program is free to write to
scaling_{min,max}_freq instead of scaling_setspeed if it wants.

The conservative governor on HWP hardware, for example, will cause
strictly higher frequencies (and typically, higher energy consumption)
than HWP powersave. But on non-HWP hardware, conservative is an
efficient, slow-ramping governor.

Changing the behavior of the old-style cpufreq governors is fraught,
because the defaults are schedutil and HWP-powersave, so users of the
other governors likely made an intentional choice, presumably after
tests on a specific platform. A change would invalidate those tests.

But on the other hand, they might *already* be invalid because of an
upgrade from non-HWP hardware. In that case, changing to DES=MIN would
move closer to the tested behavior.

And then there's churn coming from other parts of the stack. For
example, until recently [1] tuned would select conservative for its
"balanced" profile and ondemand for its "powersave" profile, based on
very old data. But that didn't matter until Redhat stopped funding work
on power-profiles-daemon, and the desktop environments' power-profile
selectors got wired up to tuned in Fedora. Hector Martin fixed that,
switching both to schedutil (unless CONFIG_CPU_FREQ_GOV_SCHEDUTIL=n,
which is rare I think). That is at least not terrible on non-HWP
hardware, but given what he was working on at the time, it might not
have been tested on x86.

[1]
https://github.com/redhat-performance/tuned/commit/e24bfef651aa7f4da95727815b2cacbf571b59af

Cheers,
Russell


