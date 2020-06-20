Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 403D82025B2
	for <lists+linux-pm@lfdr.de>; Sat, 20 Jun 2020 19:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbgFTRtP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 20 Jun 2020 13:49:15 -0400
Received: from foss.arm.com ([217.140.110.172]:56222 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726838AbgFTRtP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 20 Jun 2020 13:49:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 748B4C0A;
        Sat, 20 Jun 2020 10:49:14 -0700 (PDT)
Received: from localhost (unknown [10.1.198.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1479B3F6CF;
        Sat, 20 Jun 2020 10:49:13 -0700 (PDT)
Date:   Sat, 20 Jun 2020 18:49:12 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
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
Subject: Re: [PATCH 1/3] thermal/cpu-cooling, sched/core: Cleanup thermal
 pressure definition
Message-ID: <20200620174912.GA18358@arm.com>
References: <20200614010755.9129-1-valentin.schneider@arm.com>
 <20200614010755.9129-2-valentin.schneider@arm.com>
 <CAKfTPtCyi9acak95_2_2uL3Cf0OMAbZhDav2LbPY+ULPrD7z4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtCyi9acak95_2_2uL3Cf0OMAbZhDav2LbPY+ULPrD7z4w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Vincent,

On Thursday 18 Jun 2020 at 17:03:24 (+0200), Vincent Guittot wrote:
> On Sun, 14 Jun 2020 at 03:10, Valentin Schneider
> <valentin.schneider@arm.com> wrote:
[..]
> > diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
> > index e297e135c031..a1efd379b683 100644
> > --- a/drivers/thermal/cpufreq_cooling.c
> > +++ b/drivers/thermal/cpufreq_cooling.c
> > @@ -417,6 +417,11 @@ static int cpufreq_get_cur_state(struct thermal_cooling_device *cdev,
> >         return 0;
> >  }
> >
> > +__weak void
> > +arch_set_thermal_pressure(const struct cpumask *cpus, unsigned long th_pressure)
> > +{
> > +}
> 
> Having this weak function declared in cpufreq_cooling is weird. This
> means that we will have to do so for each one that wants to use it.
> 
> Can't you declare an empty function in a common header file ?

Do we expect anyone other than cpufreq_cooling to call
arch_set_thermal_pressure()?

I'm not against any of the options, either having it here as a week
default definition (same as done for arch_set_freq_scale() in cpufreq.c)
or in a common header (as done for arch_scale_freq_capacity() in sched.h).

But for me, Valentin's implementation seems more natural as setters are
usually only called from within the framework that does the control
(throttling for thermal or frequency setting for cpufreq) and we
probably want to think twice if we want to call them from other places.

Thanks,
Ionela.
