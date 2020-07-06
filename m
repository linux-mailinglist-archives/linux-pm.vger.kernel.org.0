Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C881A2157AA
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jul 2020 14:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbgGFMxn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Jul 2020 08:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729129AbgGFMxn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jul 2020 08:53:43 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2423C08C5E0
        for <linux-pm@vger.kernel.org>; Mon,  6 Jul 2020 05:53:42 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id d17so30462714ljl.3
        for <linux-pm@vger.kernel.org>; Mon, 06 Jul 2020 05:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/kf8XpEHtbeQdMwb593bTKgkwWmEXGWcjlGcKk8ZtLM=;
        b=lIMHAYEnDoTDnQw3kbbyB2DV6u+iRH61ntgcT+nikRfMnjuEOpSCRkVcUFW2OKmOIj
         T4wZZJMDnYc14xOS30AQi872WwRnsazqCwP3pq2ej14PDjQD/LCeJt6TyIIPHozpWzvi
         8wSFq9his57cAWNkMeu1xXcO1HlmXVpJ5tSwbtn59kLNs3UIn7KEnoBmrsxYMmK2lbCV
         SXx1RWNWPzK+BdHjJhFm2B/7FqU9hWv6SLIIDt7SvfeSrx2m+Uwzl3l2i8nawQ14RZ9j
         4Q2eINZDNNU8icc442lcEjo5HyXH5A9O3j/OsEwm0rJik6lJXPP4MjxQl/Fz0V55UflK
         8Nnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/kf8XpEHtbeQdMwb593bTKgkwWmEXGWcjlGcKk8ZtLM=;
        b=R/+U6T5INmk1rXvPTHUj+N+bAB8lYitdN3NCVhd+uIUcR/YGtYb478A7ov1jcywL9B
         dF/1dBS+sVzexIsnkJTGQahTIulfVnYyWOXlWW1hBQWC3B38YC3cxJTVdwerU32D7EaN
         q48fPnl/54OoIpwsD4mAzOBCtMU4ujHEp8jnqQ6ibxDPrPtHJkGGC4fpc71v3H5jGIHM
         VzyoupMd1MaVfVezhTU0OfViVNvMUvJFhm1jVHr3bR6vySaYht3yzsYIR5lcRxWredJX
         QUqKKCJEwIWC+hPdjlt4bZk/nOqLop/f98rf7nyZ+JXMZMDGibSPHnxyUlAVS0KxF8VG
         wZcA==
X-Gm-Message-State: AOAM532Y+Iqjjm6CTEoVSlRdVKfwC0EBEEuAkBZyDnhjvicKycw/pGq8
        FEK4xh+bpIxwIJ9dl0LuJpF1u6mokRloNaRuoxVLFQ==
X-Google-Smtp-Source: ABdhPJyxNYWgOTp01bZNMPWxzM24WAj0YUUrWBidrb8af0xzvibgprxn25Um6smrU2neKmcpJO7DGGEvP15Mn4LdQBs=
X-Received: by 2002:a2e:3c0e:: with SMTP id j14mr27501114lja.25.1594040021125;
 Mon, 06 Jul 2020 05:53:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200614010755.9129-1-valentin.schneider@arm.com>
 <20200614010755.9129-2-valentin.schneider@arm.com> <CAKfTPtCyi9acak95_2_2uL3Cf0OMAbZhDav2LbPY+ULPrD7z4w@mail.gmail.com>
 <20200620174912.GA18358@arm.com> <jhjmu4xcqyk.mognet@arm.com>
 <CAKfTPtDG26Y9s4c+MbdmbxJaiCv6s6WTqmzztcoFsm2SnRL=vQ@mail.gmail.com> <jhjlfjyf3i7.mognet@arm.com>
In-Reply-To: <jhjlfjyf3i7.mognet@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 6 Jul 2020 14:53:29 +0200
Message-ID: <CAKfTPtB4wadVkAnonZ=imBOPVHGowL46juoSAfXv4F7Y7wo_zA@mail.gmail.com>
Subject: Re: [PATCH 1/3] thermal/cpu-cooling, sched/core: Cleanup thermal
 pressure definition
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Ionela Voinescu <ionela.voinescu@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, 5 Jul 2020 at 16:19, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
>
> Sorry for getting back to this only now;
>
> On 22/06/20 09:37, Vincent Guittot wrote:
> > On Sun, 21 Jun 2020 at 00:28, Valentin Schneider <valentin.schneider@arm.com> wrote:
> >> On 20/06/20 18:49, Ionela Voinescu wrote:
> >> > On Thursday 18 Jun 2020 at 17:03:24 (+0200), Vincent Guittot wrote:
> >> >> Having this weak function declared in cpufreq_cooling is weird. This
> >> >> means that we will have to do so for each one that wants to use it.
> >> >>
> >> >> Can't you declare an empty function in a common header file ?
> >> >
> >> > Do we expect anyone other than cpufreq_cooling to call
> >> > arch_set_thermal_pressure()?
> >> >
> >> > I'm not against any of the options, either having it here as a week
> >> > default definition (same as done for arch_set_freq_scale() in cpufreq.c)
> >> > or in a common header (as done for arch_scale_freq_capacity() in sched.h).
> >> >
> >>
> >> Same thoughts here; I was going for the arch_set_freq_scale() way.
> >>
> >> > But for me, Valentin's implementation seems more natural as setters are
> >> > usually only called from within the framework that does the control
> >> > (throttling for thermal or frequency setting for cpufreq) and we
> >> > probably want to think twice if we want to call them from other places.
> >> >
> >>
> >> Well TBH I was tempted to go the other way and keep the definition in
> >> core.c, given a simple per-cpu value is fairly generic. More precisely, it
> >
> > Having all definitions in the same place is my main concern here.
> > If topology.c defines arch_set_thermal_pressure it should also provide
> > the empty function when the feature is not available or possible
> > instead of relying of each user of the interface to define a weak
> > function just in case.
> >
>
> include/linux/sched/topology.h already defines a stub for
> arch_scale_thermal_pressure(), I suppose we could have one for
> arch_set_thermal_pressure() there.
>
> That would require having something like
>
> #define arch_set_thermal_pressure topology_set_thermal_pressure
>
> in the arm & arm64 include/asm/topology.h headers, with
> topology_set_thermal_pressure() being what arch_set_thermal_pressure()
> currently is in this patchset.

That looks like a better solution IMO. At least everything is gathered
in the same place:
topology_get/set_thermal_pressure are in arch_topology.c
and arch_scale_thermal_pressure/arch_set_thermal_pressure in the
respective topology.h

>
>
> This would set an odd precedent in that so far we only ever had to #define
> getter functions, the setters being either:
> - entirely contained within arch_topology. (for the CPU scale)
> - defined in arch_topology, declared in cpufreq and contained there (for
>   the freq scale).
>
> It made the most sense to me to follow the arch_set_freq_scale() pattern
> and contain the thermal pressure setter within cpufreq_cooling, especially
> since I didn't see a strong point in breaking the current patterns.
