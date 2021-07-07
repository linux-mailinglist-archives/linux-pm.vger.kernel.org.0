Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4E073BE411
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jul 2021 10:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbhGGIDH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Jul 2021 04:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbhGGIDG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Jul 2021 04:03:06 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F80BC061574
        for <linux-pm@vger.kernel.org>; Wed,  7 Jul 2021 01:00:26 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id q184so1059556ljq.0
        for <linux-pm@vger.kernel.org>; Wed, 07 Jul 2021 01:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=haGVx5xtTBF+VtzwL/lf0Kn8JJj/cDxNCUCB/6GBJpg=;
        b=Pbd+/aMolsKOQG+lwZY8mgF04Ayl5UHoly0ldhMkisOAGIhNt5qwhhQ/P3EcyhLNas
         glu4XAf1X2q8XsK5AbHYivdZfc+gEy8MtYEFkyxi8qrLiCPabCblemNaQ70uBOzShmjk
         KLnt3PM5wrzFmPQgsV6bbHaFX+wAi7ZVMxcYBeaXMr3BcBL0E79YtKSjySrOkOLqEYBc
         h0LJNdg+RN50S9Hyt1l9vbkwQdHemPeiluOoSUIzegZdDnaa9EN/htD46iUErWF+G1vr
         7qBvUrJG/qtKQ516HgeWpx5tNgEU5nrsgg4dIYNVLh3X9Lxa10eDTbjIadSUFUvlQLzR
         Mdzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=haGVx5xtTBF+VtzwL/lf0Kn8JJj/cDxNCUCB/6GBJpg=;
        b=fEb4Mo5AFPbkscVjUHICSPm0BXJceBa+0Sqmrcw5UL+Bfdj5dn0BWCOj2i4qFItzUf
         2AJrkVUD3Nsm2XzcStbPtutjuEP1zlM7mDwG8jBhejtaMq6bf4z2N8Cgk9OsZXfNoxRe
         KEtxI6zsExDTLMSMalQdxxhZYpCnLmA8wYehNcA4+sBTlq+Pas4NlJQVKAU5DFp9/3re
         VluEF1FCcK29/qwiba0JIH5HPGm/dkqDvovdhrX8BgcuvGoNhweie5s123iCkSlxOSwc
         YiOYXuKB1KUGxNWt1KLif4G82qruxcrQXXQJByoWmW07rWk51OVjCFQBsOfpgF1SODMv
         FD6w==
X-Gm-Message-State: AOAM533Rk39yMP0YFrxeqmG5jTWvTS4lh8BYLvn6jrf+tQay1nCqeaTP
        RhGWzpnNLB2PunXoN6D3hCH24aC4yne3zzMog0FirA==
X-Google-Smtp-Source: ABdhPJz0lm5Be97IeqSsNKXdCQo7E3elpVDfj98ujSXkZ5RvypuKhI42qylz+ZcbGgwbPiBFBCxchCyO37/GwC3bkaY=
X-Received: by 2002:a2e:3a05:: with SMTP id h5mr6279612lja.209.1625644824533;
 Wed, 07 Jul 2021 01:00:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210625152603.25960-1-lukasz.luba@arm.com> <20210625152603.25960-2-lukasz.luba@arm.com>
 <CAKfTPtAV9GjQaXc2FV0OuEzTGQw9hFiKpwMfAxP-JQ_QFCUC3w@mail.gmail.com> <a6a49480-7d5d-fd0e-3940-0b6baac5acc0@arm.com>
In-Reply-To: <a6a49480-7d5d-fd0e-3940-0b6baac5acc0@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 7 Jul 2021 10:00:13 +0200
Message-ID: <CAKfTPtAbck=mTR4g9L1hVGzN2dz4PjKNXoDZeMH19HGwpW3Buw@mail.gmail.com>
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

On Wed, 7 Jul 2021 at 09:49, Lukasz Luba <lukasz.luba@arm.com> wrote:
>
>
>
> On 7/7/21 8:07 AM, Vincent Guittot wrote:
> > On Fri, 25 Jun 2021 at 17:26, Lukasz Luba <lukasz.luba@arm.com> wrote:
> >>
> >> The Energy Aware Scheduler (EAS) tries to find best CPU for a waking up
> >> task. It probes many possibilities and compares the estimated energy values
> >> for different scenarios. For calculating those energy values it relies on
> >> Energy Model (EM) data and em_cpu_energy(). The precision which is used in
> >> EM data is in milli-Watts (or abstract scale), which sometimes is not
> >> sufficient. In some cases it might happen that two CPUs from different
> >> Performance Domains (PDs) get the same calculated value for a given task
> >> placement, but in more precised scale, they might differ. This rounding
> >> error has to be addressed. This patch prepares EAS code for better
> >> precision in the coming EM improvements.
> >
> > Could you explain why 32bits results are not enough and you need to
> > move to 64bits ?
> >
> > Right now the result is in the range [0..2^32[ mW. If you need more
> > precision and you want to return uW instead, you will have a result in
> > the range  [0..4kW[ which seems to be still enough
> >
>
> Currently we have the max value limit for 'power' in EM which is
> EM_MAX_POWER 0xffff (64k - 1). We allow to register such big power
> values ~64k mW (~64Watts) for an OPP. Then based on 'power' we
> pre-calculate 'cost' fields:
> cost[i] = power[i] * freq_max / freq[i]
> So, for max freq the cost == power. Let's use that in the example.
>
> Then the em_cpu_energy() calculates as follow:
> cost * sum_util / scale_cpu
> We are interested in the first part - the value of multiplication.

But all these are internal computations of the energy model. At the
end, the computed energy that is returned by compute_energy() and
em_cpu_energy(), fits in a long

>
> The sum_util values that we can see for x CPUs which have scale_cap=1024
> can be close to 800, let's use it in the example:
> cost * sum_util = 64k * (x * 800), where
> x=4: ~200mln
> x=8: ~400mln
> x=16: ~800mln
> x=64: ~3200mln (last one which would fit in u32)
>
> When we increase the precision by even 100, then the above values won't
> fit in the u32. Even a max cost of e.g. 10k mW and 100 precision has
> issues:
> cost * sum_util = (10k *100) * (x * 800), where
> x=4: ~3200mln
> x=8: ~6400mln
>
> For *1000 precision even a power of 1Watt becomes an issue:
> cost * sum_util = (1k *1000) * (x * 800), where
> x=4: ~3200mln
> x=8: ~6400mln
>
> That's why to make the code safe for bigger power values, I had to use
> the u64 on 32bit machines.
