Return-Path: <linux-pm+bounces-8484-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7178D6568
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2024 17:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 793F8B2CA05
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2024 15:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914B26F2EB;
	Fri, 31 May 2024 15:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="hSlGC0q5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AA97483
	for <linux-pm@vger.kernel.org>; Fri, 31 May 2024 15:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717167976; cv=none; b=Hcraf8Y66KMC/MkCrKOqeJv7/0OUWT+zBzXUVQxjuUcfaQN3OZCb760A4z0p/nhPyqfrVGyFFaNuo8hUcOkoklGhqGsCv1FZL9AWNUavTNaYsYvcGr3lhPsowcj9ZuM3+sGQdj/9jcqLlreSKFjMGo3NiLqbU2V4xDOce5fRTx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717167976; c=relaxed/simple;
	bh=oAsirbDJMkVo6kb6NwpvBmP1eMzhBz0gfaiI/XVgtfM=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=pZDRZSX3rrpzDWg3zrvAw+oF2cVhZsYjwgEFz5O6wD9zKSdGi8yunlYuOR2g4yzGvvQ4MmQ9DoZ//NZnCPEUrPUFu1dAKeGvnXPiyZ3DdllQC0c3ushtz4/5O5P7sKebxZaCx2IeSrvUIELJHk8LzhPTweYDj4TnYKrjcEfivMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net; spf=pass smtp.mailfrom=telus.net; dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b=hSlGC0q5; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telus.net
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f44b45d6abso15126775ad.0
        for <linux-pm@vger.kernel.org>; Fri, 31 May 2024 08:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1717167974; x=1717772774; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=mW3mTTO64IQux68SvBpLSNFg5/t3Gc8RBFFNZihPeKo=;
        b=hSlGC0q50Hm/9Pv4FcX2naYDHNCji3uyq/kkWVNGyNDcYpnU63yICrHzvOTdM/xEKt
         OYWEF1aJylb/0uGrnrHSVSddkzhUeUvmgUB28urLJHU5lkov3XwHHtYk6FSP/b3V+ctY
         QGRbWkuYObuB6hz3NEp6J5W+ci1JD2emrYi4nQuCpH7L97EChpHCwmsbwHWv+QXJyuuw
         9aHrtxcqmYeiCKmE2wQODS0knoCpgaoLeIZAG+jI0QXxR0IjermDBX8asW9UqxnDAq79
         8Zrf12kPiXEvcSrZSXTwvXJpC5KskvF5T0N/c4JzKYQH5NwNo5C8K3M9/67rnXu4fyFD
         pfyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717167974; x=1717772774;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mW3mTTO64IQux68SvBpLSNFg5/t3Gc8RBFFNZihPeKo=;
        b=kutF6VUjpYLhs7vayDsVLDCxkLgsx9g2c8yG9VmWs7pSOX/ZT25Czse1r4qXtdsFfU
         k1gsTuAtkOXLCO+B4fEYjfK2CmE7yffLdnUKqqtf89p31pot3FLS8sBXcjoCY084s78s
         rk/0czFuAnqvMjiC13UAQoMPDVniFpeXAO7BbFBU6wtrkJTNySP35nRd1Plt0msLST9E
         aSQchym/HKe6sj94NLnYsjDxkxSWpzcKsKy2rYP9yAVaSET5KM2e3UqXxMm2nDw1MxCT
         HhzVwcwABxpQ5r+KFZeoBnhaYgDUPbTS/077iW0xYLhnjJuv3ZlMPuecooV+JZHOYyxk
         NRDw==
X-Gm-Message-State: AOJu0YwHIZPiRs9bNUAZ8BtFzb4C6XG79v4O/k/X2vBt1bSVnAvsl/jQ
	v52Vj5/U2xAkSoaHDfdJxyQTABbBD7tXUnn8kxWc0C9pwpy8i9wSupl7gbsZXXg=
X-Google-Smtp-Source: AGHT+IE+UU30BCrMcJf+V77oeyAJu9zmyFk43BULL6DDKE8sdWHZw9dH5jr+mG4O4DCpX78UjNPo+g==
X-Received: by 2002:a17:902:8ec2:b0:1f4:5dc0:5fe8 with SMTP id d9443c01a7336-1f636fecca4mr18114265ad.15.1717167973716;
        Fri, 31 May 2024 08:06:13 -0700 (PDT)
Received: from DougS18 (s66-183-142-209.bc.hsia.telus.net. [66.183.142.209])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323f6d97sm17266305ad.218.2024.05.31.08.06.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2024 08:06:13 -0700 (PDT)
From: "Doug Smythies" <dsmythies@telus.net>
To: "'Billes Tibor'" <tbilles@gmx.com>,
	<rafael@kernel.org>
Cc: <linux-pm@vger.kernel.org>,
	<daniel.lezcano@linaro.org>,
	"Doug Smythies" <dsmythies@telus.net>
References: <3f71747b-f852-4ee0-b384-cf46b2aefa3f@gmx.com>
In-Reply-To: <3f71747b-f852-4ee0-b384-cf46b2aefa3f@gmx.com>
Subject: RE: Bisected regression, maximum frequency drops after sleep
Date: Fri, 31 May 2024 08:06:14 -0700
Message-ID: <001601dab36c$14d47a00$3e7d6e00$@telus.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIVTsJQ65NlNGVFqU5YwIYpfzfmVrE8No4w
Content-Language: en-ca

Hi,

FWIW (For What It's Worth),
There is a poster on one of the Linux forums [1]
with the exact same processor,  i7-4710HQ,
with, apparently, the exact same issue.

... Doug

On 2024.05.30 12:40 Tibor wrote:

> Hi,
>
> I noticed an issue, that with every sleep-wake cycle, the maximum frequency of
> the CPU drops further down. For example, my CPU has a maximum (turbo) frequency
> of 3.5 Ghz, on first boot, this is the case. I put the laptop to sleep, wake it
> up later, and now it reports only 2.1 Ghz as maximum frequency. After the next
> cycle it reports 1.4 Ghz. A reboot restores the original maximum frequency.
>
> Details:
> My CPU is an Intel Core i7-4710HQ. On bootup the
> "grep -H . /sys/devices/system/cpu/cpufreq/policy0/*" command tell me this:
> /sys/devices/system/cpu/cpufreq/policy0/affected_cpus:0
> /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_max_freq:3500000
> /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_min_freq:800000
> /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_transition_latency:20000
> /sys/devices/system/cpu/cpufreq/policy0/related_cpus:0
> /sys/devices/system/cpu/cpufreq/policy0/scaling_available_governors:conservative ondemand userspace powersave performance schedutil
> /sys/devices/system/cpu/cpufreq/policy0/scaling_cur_freq:900000
> /sys/devices/system/cpu/cpufreq/policy0/scaling_driver:intel_cpufreq
> /sys/devices/system/cpu/cpufreq/policy0/scaling_governor:ondemand
> /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq:3500000
> /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq:800000
> /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed:<unsupported>
>
> After sleep:
> /sys/devices/system/cpu/cpufreq/policy0/affected_cpus:0
> /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_max_freq:3500000
> /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_min_freq:800000
> /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_transition_latency:20000
> /sys/devices/system/cpu/cpufreq/policy0/related_cpus:0
> /sys/devices/system/cpu/cpufreq/policy0/scaling_available_governors:conservative ondemand userspace powersave performance schedutil
> /sys/devices/system/cpu/cpufreq/policy0/scaling_cur_freq:904557
> /sys/devices/system/cpu/cpufreq/policy0/scaling_driver:intel_cpufreq
> /sys/devices/system/cpu/cpufreq/policy0/scaling_governor:ondemand
> /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq:2100000
> /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq:800000
> /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed:<unsupported>
>
> Notice the scaling_max_freq file says different frequencies. I tried writing
> the scaling_max_freq file, it allows me to lower the maximum available
> frequency, does not allow to raise back to 3.5 Ghz, it only raises back to
> 2.1 Ghz (in this case).
>
> If I keep repeating this sleep-wake cycle, the scaling_max_freq reaches its
> minimum at 1.4 Ghz, but the actual available frequency continues to drop, in
> the following example to around 550 Mhz which is even below scaling_min_freq.
> This was taken under full load, notice the value of scaling_cur_freq:
>
> /sys/devices/system/cpu/cpufreq/policy0/affected_cpus:0
> /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_max_freq:3500000
> /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_min_freq:800000
> /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_transition_latency:20000
> /sys/devices/system/cpu/cpufreq/policy0/related_cpus:0
> /sys/devices/system/cpu/cpufreq/policy0/scaling_available_governors:conservative ondemand userspace powersave performance schedutil
> /sys/devices/system/cpu/cpufreq/policy0/scaling_cur_freq:553861
> /sys/devices/system/cpu/cpufreq/policy0/scaling_driver:intel_cpufreq
> /sys/devices/system/cpu/cpufreq/policy0/scaling_governor:ondemand
> /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq:1400000
> /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq:800000
> /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed:<unsupported>
>
> I first noticed this when updating my kernel from 6.6.12 to 6.7.1. Since then
> I've been trying to bisecting it, after a few failed attempts I think I came
> reasonably close, this commit came out as the first bad one:
>
> commit 950210887670cbb7d2eb9af6fb743b70f1a1ebdc (refs/bisect/bad)
> Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Date:   Tue Sep 19 20:54:37 2023 +0200
>
>    thermal: core: Drop trips_disabled bitmask
>    
>    After recent changes, thermal_zone_get_trip() cannot fail, as invoked
>    from thermal_zone_device_register_with_trips(), so the only role of
>    the trips_disabled bitmask is struct thermal_zone_device is to make
>    handle_thermal_trip() skip trip points whose temperature was initially
>    zero.  However, since the unit of temperature in the thermal core is
>    millicelsius, zero may very well be a valid temperature value at least
>    in some usage scenarios and the trip temperature may as well change
>    later.  Thus there is no reason to permanently disable trip points
>    with initial temperature equal to zero.
>    
>    Accordingly, drop the trips_disabled bitmask along with the code
>    related to it.
>    
>    Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>    Tested-by: Ido Schimmel <idosch@nvidia.com>
>    Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>
> I also tested a recent stable kernel, 6.9.2 and it is still dropping the maximum
> frequency after sleep.
>
> Can someone help me find the cause of this issue? Is there something I can do to
> help debug this?
>
> Thanks in advance,
> Tibor

[1] https://ubuntuforums.org/showthread.php?t=2498097



