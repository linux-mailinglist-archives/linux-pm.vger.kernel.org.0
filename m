Return-Path: <linux-pm+bounces-31908-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8876BB1A3A4
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 15:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C3791886197
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 13:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9699026B2AC;
	Mon,  4 Aug 2025 13:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mwIsjIN3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885E326A1A4
	for <linux-pm@vger.kernel.org>; Mon,  4 Aug 2025 13:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754314907; cv=none; b=jVWRd1OlMBM8Op/6tRX211zxBi2wNtzM/8oB74FyIYHBydtq7uYo8/vcHM040ufGUySZNHGAkqgDhtk8sEm+g88604SY8eH6FMCTlI6AdYIIoe0TfyyIYWrTsGGGU0IaNAH2fYJE2mYlmS4GGqS2JvpAfjwukTCMibWdiiicrZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754314907; c=relaxed/simple;
	bh=l0w9LTq3nxpNLofNSQvPns8jfPBpB3DXhsHLD/Wnnm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gtnh/6HgQUpdr2ZbdF8cnVmf62G4gLatsA5JGTs6A6U0iBGIpB7WzA7AmJ29RQ3sw5I9XXb12o5OD9kmm/TZcItjYdcx6l9VqzxH9ymMOFGZ5UIwUQhcKXOhO8yPVSnaz4YmyFB53wg+MpCMl/wjNYAtZsqyEyraS5X1SzknG5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mwIsjIN3; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-af91a6b7a06so780079066b.2
        for <linux-pm@vger.kernel.org>; Mon, 04 Aug 2025 06:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754314904; x=1754919704; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wG3bWWNoyezaNlH593nDv63NxvsrvfP1is3XEB/K068=;
        b=mwIsjIN3m64t6C6Tyi0imYWHdAl2/h5oXuHvCm8vr7qVvJa4S82pVDNHnVxjVAapkx
         oU19zzs5QIBvc4eJ/mUJem7FBd0Nm7Y2cCjCfLNOeajLh7gmdTE0VWANYmOBjQ0gVFzZ
         /LfirwwvzP++NcpcH40ziL61pjUcnaIK6ndT2jp3buqwLDFmmw8P3nA4MZLQaepeaZM1
         EzMCJHM3B6x1DjgbisDZkV7NdZ2cEE0x/KyqSCyd23AIBzT1pWgWx+fJaSwFUtc/ipKq
         +9PX3kq0BKaenq/9E4Kz8if1D1Vx0xkMEPhWY9o4Jc4gUKpzAtPr9K4lYdHyeZx5ljEA
         dNhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754314904; x=1754919704;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wG3bWWNoyezaNlH593nDv63NxvsrvfP1is3XEB/K068=;
        b=XleDzR7c0WUWKiEjMlWjWin65L0STU3w4Uo5oj0/i/YxLmI4QRLfEeuleJrDeiA6UE
         AUi15IbYcug1PDtQH/VT9jtv+FrxAvXFezyVnA5Qwe2FYwPbN+99Rtg3vQSZ0wwAMWHN
         XDK+EYWi167JzF2XSyBLHd0085lrBCKH7LHmieOB67OPzkJB3XYw5qDwU5VG75fx1W/K
         Wa1iLsNZHPerYYzW4wax7Arbdg7vMBWQmnJxG0OS0j/xbxwkl6YeXdrcFGR3PKNdxA2B
         IWUoM18owOhCjxJJ5OW0RRwMc4WRi8ucuwe0+whpe8+Ue2N6/XPSwWVH6nPelSz91wDn
         MOzw==
X-Forwarded-Encrypted: i=1; AJvYcCXng/K9strVGcg1mZfuRihKu1Q/pIhEk90zeuN09G9ahhRvVWpNTdk4YnNZ0Zgp28ZxFXdDse1UuQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx4ryQRNszBUXY8qG3xVq3edWknp55gLkalVFUhXARysk47obq
	fwvHUs5I/IPO93GU3G0FbLW/HZHNZmkaPPm/wYYQbzAgEsSoCAG0TDqyJyyxvXeSpi1U6slswQD
	HgobvOHv5DXzcXptBnEhDRE74QV0BwkA0jFKUFN+2Nw==
X-Gm-Gg: ASbGncvofMtw6WdzuNMgD7T8UOT6wVMc6Qt2aubP3Uw0ouGshMHR7lEQvoVkcK0VDDr
	ueC33TTJB3LPQD4W+FzHoc4CboAcZ1Q0dH+SLwcjq6+q+hYg+sGZkNQtVF+mfjSoFqPNOT9vdhb
	qGVSIv8wFJNZ+bOKQe2lXLbLeQlqJXlLOK6mwtps9xd2EIvqPhizEHV8WcVNRv9j0gwRU10lP1Y
	J6d1OeYTdyEHGsU6wGnMhOcgBzrYB3kExTqPtOn6uWvc1c=
X-Google-Smtp-Source: AGHT+IESrWFAHDwo5kNZ03foClcZhqP5hAG108r3+ygBQ/PsbdMyWesXe6fbU/MbdWUE23A6rUIYxKQcgrRSH7Fu2N4=
X-Received: by 2002:a17:907:3f99:b0:af9:24e7:1c85 with SMTP id
 a640c23a62f3a-af9402225cfmr1221198066b.55.1754314903825; Mon, 04 Aug 2025
 06:41:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626093018.106265-1-dietmar.eggemann@arm.com>
 <e89b250a-7e9b-45fa-9e81-fc071487078b@arm.com> <CAKfTPtAwy1ZFQ=-t7SbbDuHj6ZJPtB3pJS6fZxt=1robLwvXjg@mail.gmail.com>
 <16b728e6-6fb9-48eb-8160-73c4ace229d2@arm.com>
In-Reply-To: <16b728e6-6fb9-48eb-8160-73c4ace229d2@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 4 Aug 2025 15:41:31 +0200
X-Gm-Features: Ac12FXwWOW3XzATspCSMiAAw8_TBtHWvCLIrlnZ929Z97HfBLJqceHXRFnl2CvM
Message-ID: <CAKfTPtDXRKt8zOe7XTG8L037myS4DBr+4FXfLEeF2Ai42=s+8g@mail.gmail.com>
Subject: Re: [RFC PATCH] cpufreq,base/arch_topology: Calculate cpu_capacity
 according to boost
To: Christian Loehle <christian.loehle@arm.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>, 
	Beata Michalska <beata.michalska@arm.com>, zhenglifeng1@huawei.com, 
	Ionela Voinescu <ionela.voinescu@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 Aug 2025 at 15:18, Christian Loehle <christian.loehle@arm.com> wrote:
>
> On 8/4/25 14:01, Vincent Guittot wrote:
> > On Mon, 14 Jul 2025 at 14:17, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> >>
> >> +cc Vincent Guittot <vincent.guittot@linaro.org>
> >> +cc Ionela Voinescu <ionela.voinescu@arm.com>
> >>
> >> On 26/06/2025 11:30, Dietmar Eggemann wrote:
> >>> I noticed on my Arm64 big.Little platform (Juno-r0, scmi-cpufreq) that
> >>> the cpu_scale values (/sys/devices/system/cpu/cpu*/cpu_capacity) of the
> >>> little CPU changed in v6.14 from 446 to 505. I bisected and found that
> >>> commit dd016f379ebc ("cpufreq: Introduce a more generic way to set
> >>> default per-policy boost flag") (1) introduced this change.
> >>> Juno's scmi FW marks the 2 topmost OPPs of each CPUfreq policy (policy0:
> >>> 775000 850000, policy1: 950000 1100000) as boost OPPs.
> >>>
> >>> The reason is that the 'policy->boost_enabled = true' is now done after
> >>> 'cpufreq_table_validate_and_sort() -> cpufreq_frequency_table_cpuinfo()'
> >>> in cpufreq_online() so that 'policy->cpuinfo.max_freq' is set to the
> >>> 'highest non-boost' instead of the 'highest boost' frequency.
> >>>
> >>> This is before the CPUFREQ_CREATE_POLICY notifier is fired in
> >>> cpufreq_online() to which the cpu_capacity setup code in
> >>> [drivers/base/arch_topology.c] has registered.
> >>>
> >>> Its notifier_call init_cpu_capacity_callback() uses
> >>> 'policy->cpuinfo.max_freq' to set the per-cpu
> >>> capacity_freq_ref so that the cpu_capacity can be calculated as:
> >>>
> >>> cpu_capacity = raw_cpu_capacity (2) * capacity_freq_ref /
> >>>                                     'max system-wide cpu frequency'
> >>>
> >>> (2) Juno's little CPU has 'capacity-dmips-mhz = <578>'.
> >>>
> >>> So before (1) for a little CPU:
> >>>
> >>> cpu_capacity = 578 * 850000 / 1100000 = 446
> >>>
> >>> and after:
> >>>
> >>> cpu_capacity = 578 * 700000 / 800000 = 505
> >>>
> >>> This issue can also be seen on Arm64 boards with cpufreq-dt drivers
> >>> using the 'turbo-mode' dt property for boosted OPPs.
> >>>
> >>> What's actually needed IMHO is to calculate cpu_capacity according to
> >>> the boost value. I.e.:
> >>>
> >>> (a) The infrastructure to adjust cpu_capacity in arch_topology.c has to
> >>>     be kept alive after boot.
> >
> > If we adjust the cpu_capacity at runtime this will create oscillation
> > in PELT values. We should stay with one single capacity all time :
> > - either include boost value but when boost is disable we will never
> > reach the max capacity of the cpu which could imply that the cpu will
> > never be overloaded (from scheduler pov)
>
> overutilized I'm assuming, that's the issue I was worried about here.

no I was referring to group_is_overloaded which use /Sum of CPU's capacity
That' also true for EAS and overutilized

> Strictly speaking the platform doesn't guarantee that the capacity can
> be reached and sustained indefinitely. Whether the frequency is marked
> as boost or not.

Regarding thermal mitigation and user max freq, we take that into account

>
> > - either not include boost_value but allow to go above cpu max compute
> > capacity which is something we already discussed for x86 and the turbo
> > freq in the past.
> >
>
> But that currently breaks schedutil, i.e. boost frequencies will never
> be used with schedutil. There's also some other locations where capacities

We should allow capacity to go above 1024 to reflect HW reality with
turbo and here enabling/diabling boost

> >1024 just break some assumptions (e.g. the kernel/sched/ext.c cpuperf
> interface defines SCX_CPUPERF_ONE).
>
>
> So we have either:
> a) Potential wrong capacity estimation of CPUs when boost is disabled
> (but capacity calculation assumed enabled).
> b) Boost frequencies completely unused by schedutil.
> c) Oscillating PELT values due to boost enable/disable.
>
> Isn't c) (what Dietmar proposed here) by far the smallest evil of these
> three?

No, this breaks PELT invariance

> I've also found a) very hard to actually trigger, although it's obviously
> a problem that depends on the platform.

