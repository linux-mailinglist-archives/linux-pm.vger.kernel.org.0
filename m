Return-Path: <linux-pm+bounces-3757-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB02685096B
	for <lists+linux-pm@lfdr.de>; Sun, 11 Feb 2024 14:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61971282369
	for <lists+linux-pm@lfdr.de>; Sun, 11 Feb 2024 13:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326985B20C;
	Sun, 11 Feb 2024 13:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MiX72M0V"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41A65B1FD
	for <linux-pm@vger.kernel.org>; Sun, 11 Feb 2024 13:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707658576; cv=none; b=bojHKZv5xShEPBnzDul9Gfi/o0/pAd+63ledap4BjbwjIs9vva1APZ1M6NH75YWNMPVrX8shgxe8YZgxYbJrKlXbTg8mkWauazK8hTFECeXnpcU2cBCECJ7BYMrDogYWgdaNbCDmwCh3xPfpmtZMqcJExN09gHEHVy/KI/VfnMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707658576; c=relaxed/simple;
	bh=cSC/pimE3Iy+VDI3cTIwQFKtWYnbm3GXqblRGRDLR7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eS5AS+MwIGRRN9FvnYogzFO/V3u0G4uxF7aSoli6uTM7IbJNw2aXznAivVXu7sst1nOiOaJVYhhMqcoc4bX/zCs/WiJGLrAjuYIpijCnEa7uz90b8ndrEmh5OkUf1MFzY3XyUqJnRgj0PkH0d+jzGWkt3g82CdA+Qqf4oYSZ1fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MiX72M0V; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2971562c3ceso822801a91.1
        for <linux-pm@vger.kernel.org>; Sun, 11 Feb 2024 05:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707658574; x=1708263374; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WPDq0dQl6dXYIIyP7cnfbKNa6fJRI/QjeeGnYd/0tns=;
        b=MiX72M0V+/8n2saalHGlDDzxBwnO/wNljNmSPmA3BRnxqlx6fHVRDUFUTuZ2jX8/lT
         WJEj+yFx8yKmevnuu1N1fhjM+q1Z/WNPYjNXoDrOYKX+FUUA4v+wot+rPv+As3FLwBfv
         qx/d1UN22MyjcS2xJoiv1rBzsPLV/y2WwmJeuraMVQYT0qVdwzbBBqqusezVkKRV6K80
         /Dh76mawBwLvK248gXghVIluI2ZRIXfh8TTWYetQ3prMDJGpzSa5r8hAzHvWbDqRjV5P
         /IKKzG+3te5mRo/9UBI7d4EIuoBJ1uVreSx5LqMr12dji47O1fspZHdxtpDYArmDc7XF
         +NpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707658574; x=1708263374;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WPDq0dQl6dXYIIyP7cnfbKNa6fJRI/QjeeGnYd/0tns=;
        b=Kuff/u1ZDjRarXxgLAn3l4nME0cuvSQpUdXZuD7+lvirMa+iXWzbXXmK2mnjerdqxS
         jKk1MeSdZMxRozCc98oBBzhRc6CZf6mSXW8NRcx9me6amNa8JYz8RtwL8+hlGwsZikF5
         BY6UPiN2f0Ld5MUEwhlnL39865zVkHkiGzQvcK6NB4n6oR1mHsFRj3u5kaIIsJ/tOBVz
         giKAoA2EuMWE/8tQ/HhrxivKZyFXvTlyfDGJzYR/hKHh3A+ywqt7Cp+89iEAaQkuK6Ib
         DaH8j7SdbTixOocRh9YmCltJrzKbk0GIumuMjAqIg5j/0ZokKHOoB2NJjza7in1RtG+S
         uxRA==
X-Gm-Message-State: AOJu0YwHmUORujLSU8rH+xTA+x+avukP5zTMJJvBXl9x1/b8aoCoB2gj
	bfGoYpQXpuCu3ei+QeBD3NXCupM60mlRyoL6ZgcYzg5mrziqpvwwP4/mT/Clbpxk/e5hfwG/wgX
	lYkkaXXgq8JGGGUoF6nFE8aP91UvDyboKn4gTJg==
X-Google-Smtp-Source: AGHT+IEClU2JTNSOESKH8zQTkime1Nj7q+tmc3KyT4dIi8A/3zLMDsWMJF5lpa9uN9sNQA+8m/nIRudoQAg4f9aCwhw=
X-Received: by 2002:a17:90a:7186:b0:295:e149:a0d8 with SMTP id
 i6-20020a17090a718600b00295e149a0d8mr2554378pjk.29.1707658573867; Sun, 11 Feb
 2024 05:36:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <002f01da5ba0$49cbf810$dd63e830$@telus.net> <CAKfTPtA-jizig0sh_shmkAMudAxDPYHP0SdanZe=Gc57jVKouQ@mail.gmail.com>
 <003801da5bae$02d6f550$0884dff0$@telus.net>
In-Reply-To: <003801da5bae$02d6f550$0884dff0$@telus.net>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Sun, 11 Feb 2024 14:36:02 +0100
Message-ID: <CAKfTPtC7pOtb-srrgQLFbTueLLDqHay+GQBm9=sNsnZDg_UYSQ@mail.gmail.com>
Subject: Re: sched/cpufreq: Rework schedutil governor performance estimation -
 Regression bisected
To: Doug Smythies <dsmythies@telus.net>
Cc: Ingo Molnar <mingo@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 10 Feb 2024 at 00:16, Doug Smythies <dsmythies@telus.net> wrote:
>
> Hi Vincent,
> Thank you for your quick reply.
>
> On 2024.02.09.14:11 Vincent wrote:
> On Fri, 9 Feb 2024 at 22:38, Doug Smythies <dsmythies@telus.net> wrote:
> >>
> >> Hi,
> >>
> >> I noticed a regression in the 6.8rc series kernels. Bisecting the kernel pointed to:
> >>
> >> # first bad commit: [9c0b4bb7f6303c9c4e2e34984c46f5a86478f84d]
> >> sched/cpufreq: Rework schedutil governor performance estimation
> >>
> >> There was previous bisection and suggestion of reversion,
> >> but I guess it wasn't done in the end. [1]
> >
> > This has been fixed with
> > https://lore.kernel.org/all/170539970061.398.16662091173685476681.tip-bot2@tip-bot2/
>
> Okay, thanks. I didn't find that one.
>
> >> The regression: reduced maximum CPU frequency is ignored.
>
> > This seems to be something new.
> > schedutil doesn't impact the max_freq and it's up to cpufreq driver
> > select the final freq which should stay within the limits
>
> Okay. All I know is this is the commit that caused the regression.

Could you check if the fix solved your problem ?

> I do not know why, but I do wonder if there could any relationship with
> the old, never fixed, problem of incorrect stale frequencies reported
> under the same operating conditions. See the V2 note:
> https://lore.kernel.org/all/001d01d9d3a7$71736f50$545a4df0$@telus.net/

IIUC the problem is that policy->cur is not used by intel_cpufreq and
stays set to the last old/init value.
Do I get it right that this is only informative ?

Normally cpufreq governor checks the new limits and updates current
freq if necessary except when fast switch is enabled.

>
> where I haven't been able to figure out a solution.
>
> >> Conditions:
> >> CPU frequency scaling driver: intel_cpufreq (a.k.a intel_pstate in passive mode)
> >> CPU frequency scaling governor: schedutil
> >> HWP (HardWare Pstate) control (a.k.a. Intel_speedshift): Enabled
> >> Processor: Intel(R) Core(TM) i5-10600K CPU @ 4.10GHz
> >>
> >> I did not check any other conditions, i.e. HWP disabled or the acpi-cpufreq driver.
> >>
> >> Example: A 100% load on CPU 5.
> >>
> >> sudo turbostat --quiet --Summary --show Busy%,Bzy_MHz,IRQ,PkgWatt,PkgTmp,RAMWatt,GFXWatt,CorWatt --interval 15
> >> Busy%   Bzy_MHz IRQ     PkgTmp  PkgWatt CorWatt GFXWatt RAMWatt
> >> 8.42    4636    21823   67      28.40   27.56   0.00    2.59
> >> 8.40    4577    17724   66      27.57   26.73   0.00    2.59
> >> 8.35    4637    19535   66      28.65   27.81   0.00    2.60
> >> 8.41    4578    20723   66      27.73   26.89   0.00    2.59
> >> 8.40    4558    19156   67      27.39   26.55   0.00    2.58
> >> 8.34    4502    18127   67      26.79   25.96   0.00    2.57
> >>
> >> grep . /sys/devices/system/cpu/cpu*/cpufreq/scaling_max_freq
> >> /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq:2400000
> >> /sys/devices/system/cpu/cpu10/cpufreq/scaling_max_freq:2400000
> >> /sys/devices/system/cpu/cpu11/cpufreq/scaling_max_freq:2400000
> >> /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq:2400000
> >> /sys/devices/system/cpu/cpu2/cpufreq/scaling_max_freq:2400000
> >> /sys/devices/system/cpu/cpu3/cpufreq/scaling_max_freq:2400000
> >> /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq:2400000
> >> /sys/devices/system/cpu/cpu5/cpufreq/scaling_max_freq:2400000
> >> /sys/devices/system/cpu/cpu6/cpufreq/scaling_max_freq:2400000
> >> /sys/devices/system/cpu/cpu7/cpufreq/scaling_max_freq:2400000
> >> /sys/devices/system/cpu/cpu8/cpufreq/scaling_max_freq:2400000
> >> /sys/devices/system/cpu/cpu9/cpufreq/scaling_max_freq:2400000
> >>
> >> grep . /sys/devices/system/cpu/cpu5/cpufreq/*
> >> /sys/devices/system/cpu/cpu5/cpufreq/affected_cpus:5
> >> /sys/devices/system/cpu/cpu5/cpufreq/base_frequency:4100000
> >> /sys/devices/system/cpu/cpu5/cpufreq/cpuinfo_max_freq:4800000
> >> /sys/devices/system/cpu/cpu5/cpufreq/cpuinfo_min_freq:800000
> >> /sys/devices/system/cpu/cpu5/cpufreq/cpuinfo_transition_latency:20000
> >> /sys/devices/system/cpu/cpu5/cpufreq/energy_performance_available_preferences:default performance balance_performance balance_power
> >> power
> >> /sys/devices/system/cpu/cpu5/cpufreq/energy_performance_preference:balance_performance
> >> /sys/devices/system/cpu/cpu5/cpufreq/related_cpus:5
> >> /sys/devices/system/cpu/cpu5/cpufreq/scaling_available_governors:conservative ondemand userspace powersave performance schedutil
> >> /sys/devices/system/cpu/cpu5/cpufreq/scaling_cur_freq:4799998
> >> /sys/devices/system/cpu/cpu5/cpufreq/scaling_driver:intel_cpufreq
> >> /sys/devices/system/cpu/cpu5/cpufreq/scaling_governor:schedutil
> >> /sys/devices/system/cpu/cpu5/cpufreq/scaling_max_freq:2400000
> >> /sys/devices/system/cpu/cpu5/cpufreq/scaling_min_freq:800000
> >> /sys/devices/system/cpu/cpu5/cpufreq/scaling_setspeed:<unsupported>
> >>
> >> [1] https://lore.kernel.org/all/CAKfTPtDCQuJjpi6=zjeWPcLeP+ZY5Dw7XDrZ-LpXqEAAUbXLhA@mail.gmail.com/
>
>

