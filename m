Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D461B3BE5B7
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jul 2021 11:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbhGGJkY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Jul 2021 05:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbhGGJkX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Jul 2021 05:40:23 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE2CC06175F
        for <linux-pm@vger.kernel.org>; Wed,  7 Jul 2021 02:37:42 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id t17so3078043lfq.0
        for <linux-pm@vger.kernel.org>; Wed, 07 Jul 2021 02:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=deNkM43HVrzzox3/O3Vf0dj4Yd0AsDTSqL5zXDoRHrQ=;
        b=j9VDxZYoMcJ9CKs8I3W2QKoYU1FWDBYA+P9rAg5P0WjqmAHy8IkqVJz/4Te+OPOZaV
         HQUZO7OaFwMr/zN/a3f/ofcSSv54xCFaSH3jh4V7pMaeJqiXIY3SO6c/aoBBBT1hiZqr
         Zi7TwZY30QNnzaXazHbvKjHZqBr3+FWqrCa7qfoAjBm13MHLW2zOqEAjvQvcKqqUBdb7
         hh8c7IPUt76uko5dYfti2tcsXmjK3AkxBneuK3fP9INu8Gyxg1N/MTmsFlzEMj9P02/q
         8nkp5FPHlF4tfg/UoLTq6OFYLgyBu9JfAd1NZNDEt6jKJEpIbjXEuJE/h6MJ7AE/6cr2
         Y5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=deNkM43HVrzzox3/O3Vf0dj4Yd0AsDTSqL5zXDoRHrQ=;
        b=ZMqmJxjAPp9yUwATgU/Tslv9f6UkqrHKSIx9d3OFBjZ7eu8kwmfreEo1+zlFXe1Ayu
         i18ofSzk306GAxSEVEYERbchkrrQrjHrhGvLNOQZxuAQsXAdv20krvfYRNwccQGk8qau
         bDcJr8adKpj8MNfxo2D9TaM6Ii7o5vOa2JRSNjvukupRz2SIbi0Z4L19d50wyVo843w5
         w7zhoBslJQYtKQom4OObZN1dBRqmcULMj1L11z/BhvMpQfyNouhWPAwNpf+70ZJC1BNL
         40yi23+D2MbSY8FXBSo12WZK+Xd1bcIJOgQ2/gMYL68hh+gIEOb67bslPg/8PzXatvMX
         8Vkw==
X-Gm-Message-State: AOAM5322/WmfhLmSQhR5wxvag9vaOoPCsKzEWvuS/PuqpWObBR16Rg/u
        xMi3+GWyQVjKMgNBAvSuarlndOhQ+v9sUOsA12+G7Q==
X-Google-Smtp-Source: ABdhPJzYccMNM8M2j+Gtfgi11USPxzJNhiNtBRZWdYhl5aVN++I+dSz8KMcogNb7tmtIg4pAuamzEyPHZha3pdTsUf8=
X-Received: by 2002:a05:6512:3d11:: with SMTP id d17mr6100684lfv.254.1625650660885;
 Wed, 07 Jul 2021 02:37:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210625152603.25960-1-lukasz.luba@arm.com> <20210625152603.25960-2-lukasz.luba@arm.com>
 <CAKfTPtAV9GjQaXc2FV0OuEzTGQw9hFiKpwMfAxP-JQ_QFCUC3w@mail.gmail.com>
 <a6a49480-7d5d-fd0e-3940-0b6baac5acc0@arm.com> <CAKfTPtAbck=mTR4g9L1hVGzN2dz4PjKNXoDZeMH19HGwpW3Buw@mail.gmail.com>
 <2f43b211-da86-9d48-4e41-1c63359865bb@arm.com>
In-Reply-To: <2f43b211-da86-9d48-4e41-1c63359865bb@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 7 Jul 2021 11:37:29 +0200
Message-ID: <CAKfTPtDk1ANfjR5h_EjErVfQ7=is3n9QOaKKxz81tMHtqUM7jA@mail.gmail.com>
Subject: Re: [PATCH 1/3] sched/fair: Prepare variables for increased precision
 of EAS estimated energy
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Chris Redpath <Chris.Redpath@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Quentin Perret <qperret@google.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, segall@google.com,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        CCj.Yeh@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 7 Jul 2021 at 10:23, Lukasz Luba <lukasz.luba@arm.com> wrote:
>
>
>
> On 7/7/21 9:00 AM, Vincent Guittot wrote:
> > On Wed, 7 Jul 2021 at 09:49, Lukasz Luba <lukasz.luba@arm.com> wrote:
> >>
> >>
> >>
> >> On 7/7/21 8:07 AM, Vincent Guittot wrote:
> >>> On Fri, 25 Jun 2021 at 17:26, Lukasz Luba <lukasz.luba@arm.com> wrote:
> >>>>
> >>>> The Energy Aware Scheduler (EAS) tries to find best CPU for a waking up
> >>>> task. It probes many possibilities and compares the estimated energy values
> >>>> for different scenarios. For calculating those energy values it relies on
> >>>> Energy Model (EM) data and em_cpu_energy(). The precision which is used in
> >>>> EM data is in milli-Watts (or abstract scale), which sometimes is not
> >>>> sufficient. In some cases it might happen that two CPUs from different
> >>>> Performance Domains (PDs) get the same calculated value for a given task
> >>>> placement, but in more precised scale, they might differ. This rounding
> >>>> error has to be addressed. This patch prepares EAS code for better
> >>>> precision in the coming EM improvements.
> >>>
> >>> Could you explain why 32bits results are not enough and you need to
> >>> move to 64bits ?
> >>>
> >>> Right now the result is in the range [0..2^32[ mW. If you need more
> >>> precision and you want to return uW instead, you will have a result in
> >>> the range  [0..4kW[ which seems to be still enough
> >>>
> >>
> >> Currently we have the max value limit for 'power' in EM which is
> >> EM_MAX_POWER 0xffff (64k - 1). We allow to register such big power
> >> values ~64k mW (~64Watts) for an OPP. Then based on 'power' we
> >> pre-calculate 'cost' fields:
> >> cost[i] = power[i] * freq_max / freq[i]
> >> So, for max freq the cost == power. Let's use that in the example.
> >>
> >> Then the em_cpu_energy() calculates as follow:
> >> cost * sum_util / scale_cpu
> >> We are interested in the first part - the value of multiplication.
> >
> > But all these are internal computations of the energy model. At the
> > end, the computed energy that is returned by compute_energy() and
> > em_cpu_energy(), fits in a long
>
> Let's take a look at existing *10000 precision for x CPUs:
> cost * sum_util / scale_cpu =
> (64k *10000) * (x * 800) / 1024
> which is:
> x * ~500mln
>
> So to be close to overflowing u32 the 'x' has to be > (?=) 8
> (depends on sum_util).

Sorry but I don't get your point.
This patch is about the return type of compute_energy() and
em_cpu_energy(). And even if we decide to return uW instead of mW,
there is still a lot of margin.

It's not because you need u64 for computing intermediate value that
you must returns u64

>
> >
> >>
> >> The sum_util values that we can see for x CPUs which have scale_cap=1024
> >> can be close to 800, let's use it in the example:
> >> cost * sum_util = 64k * (x * 800), where
> >> x=4: ~200mln
> >> x=8: ~400mln
> >> x=16: ~800mln
> >> x=64: ~3200mln (last one which would fit in u32)
> >>
> >> When we increase the precision by even 100, then the above values won't
> >> fit in the u32. Even a max cost of e.g. 10k mW and 100 precision has
> >> issues:
> >> cost * sum_util = (10k *100) * (x * 800), where
> >> x=4: ~3200mln
> >> x=8: ~6400mln
> >>
> >> For *1000 precision even a power of 1Watt becomes an issue:
> >> cost * sum_util = (1k *1000) * (x * 800), where
> >> x=4: ~3200mln
> >> x=8: ~6400mln
> >>
> >> That's why to make the code safe for bigger power values, I had to use
> >> the u64 on 32bit machines.
