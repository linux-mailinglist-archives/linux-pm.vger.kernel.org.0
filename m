Return-Path: <linux-pm+bounces-37190-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0612C25451
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 14:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16489425A3F
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 13:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E85E34B416;
	Fri, 31 Oct 2025 13:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mR0jLNBQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE4A34B1BF
	for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 13:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761917399; cv=none; b=tdvcP3NH4Kg40RVaIZBUZ3THN26XBUfS9E2v3Vc9MFQyhGuXEHVYtmPxCfalgg+2vreR+YfDOUiG2gEzk13l6rRtaA9W22Bj59nmIZFbO4Cnu8/p37O2I2ZwCmltabGdSQ1RR5XrBevG+n1qRJmQRrHYshEu7fzNDMVIxs1gKT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761917399; c=relaxed/simple;
	bh=kJq6pF4RUzF8+MkDYTbzR3CtlJvz/pzreELzwlcMDZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LTaSi12cnF89GO/KSk66wmhWVdpx7ta8Zx7TqiDXVjNT0+Q4QQfognh0i/gEIRNmDoqxSrT2HRenCU7EZGNJwUKL7aIP++DOT95VPCuWg/RKKgL8pmTg8yr8hvT2UFwpxa8F4J44ifv9s+d1TfNSJu8Aqogu9SLApRodxlPwGsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mR0jLNBQ; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-63f870cc79aso1834819d50.0
        for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 06:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761917396; x=1762522196; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9LhgrUlmmxFGDMB8p25qzITbn9PUAW71mtJ/vs7gzP4=;
        b=mR0jLNBQk4zqZTUmgrWzNAs4TgwWKHAEeqZZe3bMV6VjCt9ggB+dJWxhGIRozG488f
         fQPKfzLxA3D0qtT2pkJaUjdmSe3dOZUDFhvor2n5bhswJtRrrgX+lJdx5MZJwOIyOJ2g
         Alsa4WV32vPMJfWuFNx3iEtd6ZMudg7/XPtdgjXC7qTfd9EfS/iOWMKk8mKWpZIt6BZH
         W7oHZhe6BImLMWS6V5oE0sRjASkWsb+ZlnsbEBvKP/A1UL18zsUKdf6rtIPM28OZT2UO
         CpZHNJddC5aF3yLm9KhmYBLeetbhwb0ipxaX5nr4pnlz4bH2R24cDl+aqQbn/QbF+jDm
         1YOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761917396; x=1762522196;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9LhgrUlmmxFGDMB8p25qzITbn9PUAW71mtJ/vs7gzP4=;
        b=ff5Zjyt6NoSGDBNXyLkVSyGLSZAp6LbNdCD7Du51nV45Miw8kbApbzuo4gAFdMYGIc
         rn6/O7yBuA2ghtJPtEBF/GKOSbpjaTyvtPTyvVBA0NNjVdu8zYuT2JEPG84tZ2v48Abx
         D0dTW3S0kCAgQBxyCQSvVXNnGGR+Ajh25JYLbaucXey/Sp39AQD6CB5fll9zdI2jlTqq
         HK5ONAXMtwyU8TMxicKqZ8wo/LLKv8NUAkjE86FqXMBDHTt+upcGUGVxs0IsN4oID4kw
         W4lHdoWdx5fsGOAvNWAyIahqyKZuRcaHrhPkRf2wtgmAHCkNjLoytfCpzluCPz4N+5bY
         yqPg==
X-Forwarded-Encrypted: i=1; AJvYcCVvzcalNGy4m9mye4W9eFA6NrQkbJfnEBA0TsD2W2BIaI6L9IIcS3iI6o3jH1GfqelAIkkjldXXNw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyGqTvgxiXB3g5Uwzs9v9kJmqQmKTJQyFeuNVEVbRHhiYnaFl6m
	sSlqytmAaCrUdQ8XCmcAAwoaGjjQxkIV0krLnPfvRCFexLBhh+Sai9QXf4F450xi1orSkMOWTrb
	9AccZfHezle9GvccB8dYxgaqFmL6LmxxrPEtfw4r+bg==
X-Gm-Gg: ASbGnctBIWIuMM8i6rqcYMYGaFVQ3onQhbdO35cnPVqm8pCJV6wMyMYnyMpB+VDfyrg
	QnF/4UnzJpkLZmciuH/5y/w/ZM7wBQ9lk6ieCD0AAHotBO5H1v+nUy/vH+TtO/EJ3miHlZrZAI3
	k4sR64mDFoU11cj0u/9mSpWgCpwcn5jTSWiz+kAH2syb2SG9k0msGTfCsZaMuxQCMBMMNZaKn1v
	OafZuS3hYSbfJIaAy2uA44TZiIOvuHIdPLtJEBCZcPS3UBmXyurc7wzqIqFtg==
X-Google-Smtp-Source: AGHT+IFWctisbs7b0B1NucRddlQojfK84XgQWld8tSIGOBU7xw/xmJeq9stpfe87eWCG1HAC4KOZxHfy2SJA8sh8/9s=
X-Received: by 2002:a05:690c:7204:b0:786:5789:57d1 with SMTP id
 00721157ae682-786578959a6mr1490667b3.52.1761917396007; Fri, 31 Oct 2025
 06:29:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016151929.75863-1-ulf.hansson@linaro.org>
 <20251016151929.75863-5-ulf.hansson@linaro.org> <20251031105723.iwhrpoluzwlikpwf@lcpd911>
In-Reply-To: <20251031105723.iwhrpoluzwlikpwf@lcpd911>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 31 Oct 2025 14:29:19 +0100
X-Gm-Features: AWmQ_bn3dXkWDYUdLlh8_bycVPm_pBoUVc8DATuTJQH_coSBh18MfJKWCGt_o1Q
Message-ID: <CAPDyKFpZa0Dm5km-0QWxq+RjKFTXsWC0UMdPFhi-fXJ4t710tQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] Documentation: power/cpuidle: Document the CPU
 system-wakeup latency QoS
To: Dhruva Gole <d-gole@ti.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
	Kevin Hilman <khilman@baylibre.com>, Pavel Machek <pavel@kernel.org>, Len Brown <len.brown@intel.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Saravana Kannan <saravanak@google.com>, 
	Maulik Shah <quic_mkshah@quicinc.com>, Prasad Sodagudi <psodagud@quicinc.com>, 
	linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"

On Fri, 31 Oct 2025 at 11:57, Dhruva Gole <d-gole@ti.com> wrote:
>
> Hi Ulf,
>
> On Oct 16, 2025 at 17:19:24 +0200, Ulf Hansson wrote:
> > Let's document how the new CPU system-wakeup latency QoS can be used from
> > user space, along with how the corresponding latency constraint gets
> > respected during s2idle.
> >
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >
> > Changes in v2:
> >       - New patch.
>
> Similar to how I did for v1 RFC,
> I have applied this series on a ti-linux-6.12 branch[1] and have been testing on
> the TI K3 AM62L device, my 2 cents:
>
> >
> > ---
> >  Documentation/admin-guide/pm/cpuidle.rst | 7 +++++++
> >  Documentation/power/pm_qos_interface.rst | 9 +++++----
> >  2 files changed, 12 insertions(+), 4 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/pm/cpuidle.rst b/Documentation/admin-guide/pm/cpuidle.rst
> > index 0c090b076224..3f6f79a9bc8f 100644
> > --- a/Documentation/admin-guide/pm/cpuidle.rst
> > +++ b/Documentation/admin-guide/pm/cpuidle.rst
> > @@ -580,6 +580,13 @@ the given CPU as the upper limit for the exit latency of the idle states that
> >  they are allowed to select for that CPU.  They should never select any idle
> >  states with exit latency beyond that limit.
> >
> > +While the above CPU QoS constraints applies to a running system, user space may
> > +also request a CPU system-wakeup latency QoS limit, via the `cpu_wakeup_latency`
> > +file.  This QoS constraint is respected when selecting a suitable idle state
> > +for the CPUs, while entering the system-wide suspend-to-idle sleep state.
> > +
> > +Note that, in regards how to manage the QoS request from user space for the
> > +`cpu_wakeup_latency` file, it works according to the `cpu_dma_latency` file.
> >
> >  Idle States Control Via Kernel Command Line
> >  ===========================================
> > diff --git a/Documentation/power/pm_qos_interface.rst b/Documentation/power/pm_qos_interface.rst
> > index 5019c79c7710..723f4714691a 100644
> > --- a/Documentation/power/pm_qos_interface.rst
> > +++ b/Documentation/power/pm_qos_interface.rst
> > @@ -55,7 +55,8 @@ int cpu_latency_qos_request_active(handle):
> >
> >  From user space:
> >
> > -The infrastructure exposes one device node, /dev/cpu_dma_latency, for the CPU
> > +The infrastructure exposes two separate device nodes, /dev/cpu_dma_latency for
> > +the CPU latency QoS and /dev/cpu_wakeup_latency for the CPU system-wakeup
>
> If others are interested to test this out, I have a quick and dirty C
> program here that you can compile on the target to test setting
> constraints [2]
>
> >  latency QoS.
> >
> >  Only processes can register a PM QoS request.  To provide for automatic
> > @@ -63,15 +64,15 @@ cleanup of a process, the interface requires the process to register its
> >  parameter requests as follows.
> >
> >  To register the default PM QoS target for the CPU latency QoS, the process must
> > -open /dev/cpu_dma_latency.
> > +open /dev/cpu_dma_latency. To register a CPU system-wakeup QoS limit, the
> > +process must open /dev/cpu_wakeup_latency.
> >
> >  As long as the device node is held open that process has a registered
> >  request on the parameter.
> >
> >  To change the requested target value, the process needs to write an s32 value to
> >  the open device node.  Alternatively, it can write a hex string for the value
> > -using the 10 char long format e.g. "0x12345678".  This translates to a
> > -cpu_latency_qos_update_request() call.
> > +using the 10 char long format e.g. "0x12345678".
>
> Here, can we please also mention the units ns or msec? I see that you
> might have changed from usec to nsec from v1->v2, which may not be obvious to
> everyone at first glance.

I haven't changed the unit in-between the versions, but just using the
same format as cpu_dma_latency.

Yes, I agree the unit deserves to be described, but I suggest we make
that a separate change as the unit should be described for the
existing cpu_dma_latency too.

>
> Also, In my local setup I have a single CPU system with the following
> low power-states:
>
> 8<----------------------------------------------------------------------------
>         idle-states {
>                 entry-method = "psci";
>
>                 CLST_STBY: STBY {
>                         compatible = "arm,idle-state";
>                         idle-state-name = "Standby";
>                         arm,psci-suspend-param = <0x00000001>;
>                         entry-latency-us = <300>;
>                         exit-latency-us = <600>;
>                         min-residency-us = <1000>;
>                 };
>         };
> [...]
>         domain-idle-states {
>                 main_sleep_0: main-deep-sleep {
>                         compatible = "domain-idle-state";
>                         arm,psci-suspend-param = <0x13333>;
>                         entry-latency-us = <1000>;
>                         exit-latency-us = <1000>;
>                         min-residency-us = <500000>;
>                         local-timer-stop;
>                 };
>
>                 main_sleep_1: main-sleep-rtcddr {
>                         compatible = "domain-idle-state";
>                         arm,psci-suspend-param = <0x12333>;
>                         local-timer-stop;
>                         entry-latency-us = <300000>;
>                         exit-latency-us = <600000>;
>                         min-residency-us = <1000000>;
>                 };
>         };
>
>
> ---------------------------------------------------------------------->8
>
> Now, when I set the latency constraint 0x7a110 into cpu_wakeup_latency,
> I expect it _not_ to pick main_sleep_0 because it has min-residency of
> 0x7A120 (500000 us) and since 0x7a110 < 0x7a120 I expect the governor
> should pick the least latency state of the cpu which is the CLST_STBY or
> maybe just kernel WFI (which is the default lowest possible idle state?).
>
> I decided to go even lower with just setting 0x1000 (4096), but even
> then s2idle picked main_sleep_0!
>
> Only after I set something very very low like 0x1 or 0x10 did it pick
> the shallower state than main_sleep_0...

The residency has nothing to do with QoS.

It's only the entry+exit latency that matters during state selection.

>
> I haven't dug deeper into where things might be getting miscalculated
> yet but just thought to share my experiments with you before you respin
> the next rev. Curious to know if I may be just confusing the units or am
> missing something obvious here?

See above.

>
> Few of the other things that I tried that _did_ work was, setting
> constraint to 0x1312D00 (20000000) which is obviously much higher than
> the highest min-residency , and then I can see s2idle pick the deepest
> state ie. main_sleep_1. So that worked as expected.
>
> In conclusion, I am happy that this still works in a way that I am able to
> switch between low power states, but just not in the most explainable
> way :(

I hope this above makes sense to you - and thanks a lot for helping
out with testing!

Kind regards
Uffe

>
> [1] https://github.com/DhruvaG2000/dbg-linux/tree/tiL6.12-am62l-s2idle-prep-v2
> [2] https://gist.github.com/DhruvaG2000/a902b815b5db296bb7096ad7cb093929
>
> --
> Best regards,
> Dhruva Gole
> Texas Instruments Incorporated

