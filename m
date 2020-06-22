Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65A622031FD
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jun 2020 10:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgFVIW7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Jun 2020 04:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgFVIW4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jun 2020 04:22:56 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE589C061794
        for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2020 01:22:55 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id g2so9098194lfb.0
        for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2020 01:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h+ozlEIO/qxyAds7OwFWzzEoRVVdD8s4jy8p/vmQnnY=;
        b=UcMLx/8mYxw2ta2G1/AB6B/unlXIkPifTtiot243yO126jlfY/UOTtF9MCEG5lyfMC
         HmQRn9k87Yx2sKznyi3g+INXCkHZRLFyNwCVHk08E+ah9lynlEZFF8OXAH8fAw9biDMa
         BaFpQKhYbNAkudPei3ewrrAa+HdCHeTrqHgFtVFbcbn3FapOccKSDthv/QZQYz6RtvRX
         UWLAaLzXVZYIWirxe5Y/JtYqurly+ki1Ns9F1Qs0NxRr5yPSzLRqMQNwzgOXKcywg12K
         OrIFAmz/DsdS91xHgTN/cgBFJ800I0InulmYvE6WqojOE/rGewhSAgjGuB72Aogatxt0
         ZV6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h+ozlEIO/qxyAds7OwFWzzEoRVVdD8s4jy8p/vmQnnY=;
        b=BAsiP103to3bPnEx+s+RBuP/RC2egU6agWKk+RRyStZz0med95P9TcEB5r6lwHvjn4
         13kSQpZ/EOBQ3Trxf5KNaXg/itIEszars9/dPqFwF0Qh04UgO5vhTbtaIeDeLHndgYl7
         n79b5v8dbdkvGkQd5stTlueZQmsmBzNZZ3zxGYM4QkurMbtalZFKmoU9uKkjSXhAfb+Y
         ViuCTbpih7zcvotKBixCQsK8Eam5NyZK23WkgNLzhdONzPMe4xj4WcmJcwjf9piRMiBW
         c9o1mcXNELOI8dDEVTyY73dXDzUfDCRiMwxSbTwYiUc7PdftcamzO/XM8sk2ptkpnRix
         S10w==
X-Gm-Message-State: AOAM532c7D4wdzbRlDnmzPsDhEmuVnKw1eYsV8JneVPb14KVKEzRmih/
        /hRq4zxRyiVr7JvPwPqJFszkEjuJi1VObTSkjO1ojw==
X-Google-Smtp-Source: ABdhPJxyq3Xqu94mRkWd8rRoN/XkS/DhYnK8sHEIOt5mcr9WKVN7v3S6QLEPKw8ZT4mciLtuhkJ+Ae9wqzcESAsUXjQ=
X-Received: by 2002:a05:6512:6ca:: with SMTP id u10mr9407371lff.184.1592814174117;
 Mon, 22 Jun 2020 01:22:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200614010755.9129-1-valentin.schneider@arm.com>
 <20200614010755.9129-2-valentin.schneider@arm.com> <CAKfTPtCyi9acak95_2_2uL3Cf0OMAbZhDav2LbPY+ULPrD7z4w@mail.gmail.com>
 <20200620174912.GA18358@arm.com>
In-Reply-To: <20200620174912.GA18358@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 22 Jun 2020 10:22:42 +0200
Message-ID: <CAKfTPtDcKnF5kgORXCbppcF==ejcPcCqoCo0_vtSMX9_hJCjMg@mail.gmail.com>
Subject: Re: [PATCH 1/3] thermal/cpu-cooling, sched/core: Cleanup thermal
 pressure definition
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
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

On Sat, 20 Jun 2020 at 19:49, Ionela Voinescu <ionela.voinescu@arm.com> wrote:
>
> Hi Vincent,
>
> On Thursday 18 Jun 2020 at 17:03:24 (+0200), Vincent Guittot wrote:
> > On Sun, 14 Jun 2020 at 03:10, Valentin Schneider
> > <valentin.schneider@arm.com> wrote:
> [..]
> > > diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
> > > index e297e135c031..a1efd379b683 100644
> > > --- a/drivers/thermal/cpufreq_cooling.c
> > > +++ b/drivers/thermal/cpufreq_cooling.c
> > > @@ -417,6 +417,11 @@ static int cpufreq_get_cur_state(struct thermal_cooling_device *cdev,
> > >         return 0;
> > >  }
> > >
> > > +__weak void
> > > +arch_set_thermal_pressure(const struct cpumask *cpus, unsigned long th_pressure)
> > > +{
> > > +}
> >
> > Having this weak function declared in cpufreq_cooling is weird. This
> > means that we will have to do so for each one that wants to use it.
> >
> > Can't you declare an empty function in a common header file ?
>
> Do we expect anyone other than cpufreq_cooling to call
> arch_set_thermal_pressure()?

Yes, cpufreq cooling device is only 1 possible way to do thermal mitigation

>
> I'm not against any of the options, either having it here as a week
> default definition (same as done for arch_set_freq_scale() in cpufreq.c)
> or in a common header (as done for arch_scale_freq_capacity() in sched.h).
>
> But for me, Valentin's implementation seems more natural as setters are
> usually only called from within the framework that does the control
> (throttling for thermal or frequency setting for cpufreq) and we
> probably want to think twice if we want to call them from other places.
>
> Thanks,
> Ionela.
