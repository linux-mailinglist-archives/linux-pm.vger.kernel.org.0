Return-Path: <linux-pm+bounces-3725-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8907A84FF74
	for <lists+linux-pm@lfdr.de>; Fri,  9 Feb 2024 23:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4179328314C
	for <lists+linux-pm@lfdr.de>; Fri,  9 Feb 2024 22:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59272134B;
	Fri,  9 Feb 2024 22:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t7/5usPD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C406107AA
	for <linux-pm@vger.kernel.org>; Fri,  9 Feb 2024 22:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707516654; cv=none; b=UibXz6hd6iw7lgUF7FRC1Dm9WZI+eS0fE9jsZJ6FYnES0V6+mICJ3fwj87Mvq9Y9KLXBGIpIqtLmXbV2BnUzdQeo6ErPpTLs/eGYm+Ob3ovVsCL4rLYLHNqXlw1ZGUSPvfrPXw1uEklGvcxjuetZqILHovWScuPfrx2LxX8wE78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707516654; c=relaxed/simple;
	bh=n2ZCswoigTORXv5QKqqqOOgLyFjY4RM6hrHLeJlO/aU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MdV0SqjQ00Bw6Xoe9gn7l0xWV0xEhqcUFhyQQABrTeM5II2YdhRznfXdA1YeS0bVAIplqC+9T/IRgP0T+KVlBQ9NwYoAOhsZJBf4cZ4DEU46mPDaonnMEvwebHH4NjlP30PQQh478HZx+urhPQxP0T0rF1qKkNd+pZ02/oW2R1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t7/5usPD; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5ceb3fe708eso955543a12.3
        for <linux-pm@vger.kernel.org>; Fri, 09 Feb 2024 14:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707516652; x=1708121452; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3268oKGsBgJrtUhQbj/DpUrS5yqVV5gSrp5rNb8j/5Y=;
        b=t7/5usPDkNBzwAodiU06QFo+HRs9U0eFkVkDpG8NVXLL5ejSGPZJCokAwiLNangV1V
         gI9EnETFnDeIHz0N3JnlvKFm8sHjWX3/YiNo8HyXn7mPNarYdd2NMw1/4jZ5h4n1tE9H
         Ghray1p4GYC29hxV/k+SjO9JQICNbRg1CLGg+x7T55j2AAgj+pTuRzGNSpYeWLICoGTR
         vOEV8M/h6fJtAnB2rFYuNwaUNnEoEnNxUNec+hTJ0yVybfR3wXmbH+8W96mexvNb9XnT
         EW4gC2NG/SMJ5OTDP5Jc/bxkFCHlaObjyoarHqTEIvG4C+MA9wI/PpHVAJ4UuJrn0Yhj
         cYPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707516652; x=1708121452;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3268oKGsBgJrtUhQbj/DpUrS5yqVV5gSrp5rNb8j/5Y=;
        b=OgEYCNgKynym7FHGC1vY+m/9zc4g8gRn1vGm3S1QRDbELuBDd9HQV6eBd3w1qen1oy
         uFaZpWfIK+iYK845aprlTqUq/6hi1jzmgl52nH3lKzWoajb+r2DsFwdBa2W2CoLBAX1r
         Fpv6PtvBVhHj7TIe/S6cQSYJMAF74iHwxeSBWUSSJVsJZ7yS8CsLsJNJr2vQpqK9zxDw
         fYAj5aTb81E2uX/4x9VNVp6sfRr0IqG+pzqqs7yvtRo32A92HH9gLEGzB5IIJR333LXM
         muMxCIo1tFSMzzarRQUfeZv01QAASda361Luen+nJM/3A0C+RjK+wV4NlL2DzGMXNgMY
         koOg==
X-Forwarded-Encrypted: i=1; AJvYcCUAmolxqdwYFQmentgqBMIKvzXhtVx5ko23uJgxlcdOiPfORt0/D4FBOy9ImHZ2GcBfuO8YSpitHezMyyIgNvioEan4O2xAfV4=
X-Gm-Message-State: AOJu0YzesiE3NrP6XQwgki8LNoynR90iXhXT5Zc5l2HrZrwdpEXuAXRM
	AsLbx6qMX4MHXNpjmrgfhSPZ7G/Q8AqrXNmnmZMp9JayPMGlHyseMnfc2cJfQFv2pw+DzjGeElp
	sP1AGYzgjym79CFksg/ZELrXVnlKIcCvWahue8CEAbHX+Wrh43tg=
X-Google-Smtp-Source: AGHT+IG7fHVeQvinopxX4gN8uI6+vc/oAgzWdEDMX8r117G8fvLodu3rqNc3Rj8Ey72Q/XNzfvtAvUxaA19iw7Ea/fM=
X-Received: by 2002:a17:90a:d498:b0:297:410:4b54 with SMTP id
 s24-20020a17090ad49800b0029704104b54mr316720pju.45.1707516652316; Fri, 09 Feb
 2024 14:10:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <002f01da5ba0$49cbf810$dd63e830$@telus.net>
In-Reply-To: <002f01da5ba0$49cbf810$dd63e830$@telus.net>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 9 Feb 2024 23:10:40 +0100
Message-ID: <CAKfTPtA-jizig0sh_shmkAMudAxDPYHP0SdanZe=Gc57jVKouQ@mail.gmail.com>
Subject: Re: sched/cpufreq: Rework schedutil governor performance estimation -
 Regression bisected
To: Doug Smythies <dsmythies@telus.net>
Cc: Ingo Molnar <mingo@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 Feb 2024 at 22:38, Doug Smythies <dsmythies@telus.net> wrote:
>
> Hi,
>
> I noticed a regression in the 6.8rc series kernels. Bisecting the kernel pointed to:
>
> # first bad commit: [9c0b4bb7f6303c9c4e2e34984c46f5a86478f84d]
> sched/cpufreq: Rework schedutil governor performance estimation
>
> There was previous bisection and suggestion of reversion,
> but I guess it wasn't done in the end. [1]

This has been fixed with
https://lore.kernel.org/all/170539970061.398.16662091173685476681.tip-bot2@tip-bot2/

>
> The regression: reduced maximum CPU frequency is ignored.

This seems to be something new.
schedutil doesn't impact the max_freq and it's up to cpufreq driver
select the final freq which should stay within the limits

>
> Conditions:
> CPU frequency scaling driver: intel_cpufreq (a.k.a intel_pstate in passive mode)
> CPU frequency scaling governor: schedutil
> HWP (HardWare Pstate) control (a.k.a. Intel_speedshift): Enabled
> Processor: Intel(R) Core(TM) i5-10600K CPU @ 4.10GHz
>
> I did not check any other conditions, i.e. HWP disabled or the acpi-cpufreq driver.
>
> Example: A 100% load on CPU 5.
>
> sudo turbostat --quiet --Summary --show Busy%,Bzy_MHz,IRQ,PkgWatt,PkgTmp,RAMWatt,GFXWatt,CorWatt --interval 15
> Busy%   Bzy_MHz IRQ     PkgTmp  PkgWatt CorWatt GFXWatt RAMWatt
> 8.42    4636    21823   67      28.40   27.56   0.00    2.59
> 8.40    4577    17724   66      27.57   26.73   0.00    2.59
> 8.35    4637    19535   66      28.65   27.81   0.00    2.60
> 8.41    4578    20723   66      27.73   26.89   0.00    2.59
> 8.40    4558    19156   67      27.39   26.55   0.00    2.58
> 8.34    4502    18127   67      26.79   25.96   0.00    2.57
>
> grep . /sys/devices/system/cpu/cpu*/cpufreq/scaling_max_freq
> /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq:2400000
> /sys/devices/system/cpu/cpu10/cpufreq/scaling_max_freq:2400000
> /sys/devices/system/cpu/cpu11/cpufreq/scaling_max_freq:2400000
> /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq:2400000
> /sys/devices/system/cpu/cpu2/cpufreq/scaling_max_freq:2400000
> /sys/devices/system/cpu/cpu3/cpufreq/scaling_max_freq:2400000
> /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq:2400000
> /sys/devices/system/cpu/cpu5/cpufreq/scaling_max_freq:2400000
> /sys/devices/system/cpu/cpu6/cpufreq/scaling_max_freq:2400000
> /sys/devices/system/cpu/cpu7/cpufreq/scaling_max_freq:2400000
> /sys/devices/system/cpu/cpu8/cpufreq/scaling_max_freq:2400000
> /sys/devices/system/cpu/cpu9/cpufreq/scaling_max_freq:2400000
>
> grep . /sys/devices/system/cpu/cpu5/cpufreq/*
> /sys/devices/system/cpu/cpu5/cpufreq/affected_cpus:5
> /sys/devices/system/cpu/cpu5/cpufreq/base_frequency:4100000
> /sys/devices/system/cpu/cpu5/cpufreq/cpuinfo_max_freq:4800000
> /sys/devices/system/cpu/cpu5/cpufreq/cpuinfo_min_freq:800000
> /sys/devices/system/cpu/cpu5/cpufreq/cpuinfo_transition_latency:20000
> /sys/devices/system/cpu/cpu5/cpufreq/energy_performance_available_preferences:default performance balance_performance balance_power
> power
> /sys/devices/system/cpu/cpu5/cpufreq/energy_performance_preference:balance_performance
> /sys/devices/system/cpu/cpu5/cpufreq/related_cpus:5
> /sys/devices/system/cpu/cpu5/cpufreq/scaling_available_governors:conservative ondemand userspace powersave performance schedutil
> /sys/devices/system/cpu/cpu5/cpufreq/scaling_cur_freq:4799998
> /sys/devices/system/cpu/cpu5/cpufreq/scaling_driver:intel_cpufreq
> /sys/devices/system/cpu/cpu5/cpufreq/scaling_governor:schedutil
> /sys/devices/system/cpu/cpu5/cpufreq/scaling_max_freq:2400000
> /sys/devices/system/cpu/cpu5/cpufreq/scaling_min_freq:800000
> /sys/devices/system/cpu/cpu5/cpufreq/scaling_setspeed:<unsupported>
>
> [1] https://lore.kernel.org/all/CAKfTPtDCQuJjpi6=zjeWPcLeP+ZY5Dw7XDrZ-LpXqEAAUbXLhA@mail.gmail.com/
>
>

