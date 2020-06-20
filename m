Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 872EC202703
	for <lists+linux-pm@lfdr.de>; Sun, 21 Jun 2020 00:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbgFTW22 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 20 Jun 2020 18:28:28 -0400
Received: from foss.arm.com ([217.140.110.172]:51632 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727930AbgFTW22 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 20 Jun 2020 18:28:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 608BCD6E;
        Sat, 20 Jun 2020 15:28:27 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C1623F73C;
        Sat, 20 Jun 2020 15:28:25 -0700 (PDT)
References: <20200614010755.9129-1-valentin.schneider@arm.com> <20200614010755.9129-2-valentin.schneider@arm.com> <CAKfTPtCyi9acak95_2_2uL3Cf0OMAbZhDav2LbPY+ULPrD7z4w@mail.gmail.com> <20200620174912.GA18358@arm.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        "open list\:THERMAL" <linux-pm@vger.kernel.org>,
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
Subject: Re: [PATCH 1/3] thermal/cpu-cooling, sched/core: Cleanup thermal pressure definition
In-reply-to: <20200620174912.GA18358@arm.com>
Date:   Sat, 20 Jun 2020 23:28:19 +0100
Message-ID: <jhjmu4xcqyk.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 20/06/20 18:49, Ionela Voinescu wrote:
> Hi Vincent,
>
> On Thursday 18 Jun 2020 at 17:03:24 (+0200), Vincent Guittot wrote:
>> On Sun, 14 Jun 2020 at 03:10, Valentin Schneider
>> <valentin.schneider@arm.com> wrote:
> [..]
>> > diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
>> > index e297e135c031..a1efd379b683 100644
>> > --- a/drivers/thermal/cpufreq_cooling.c
>> > +++ b/drivers/thermal/cpufreq_cooling.c
>> > @@ -417,6 +417,11 @@ static int cpufreq_get_cur_state(struct thermal_cooling_device *cdev,
>> >         return 0;
>> >  }
>> >
>> > +__weak void
>> > +arch_set_thermal_pressure(const struct cpumask *cpus, unsigned long th_pressure)
>> > +{
>> > +}
>>
>> Having this weak function declared in cpufreq_cooling is weird. This
>> means that we will have to do so for each one that wants to use it.
>>
>> Can't you declare an empty function in a common header file ?
>
> Do we expect anyone other than cpufreq_cooling to call
> arch_set_thermal_pressure()?
>
> I'm not against any of the options, either having it here as a week
> default definition (same as done for arch_set_freq_scale() in cpufreq.c)
> or in a common header (as done for arch_scale_freq_capacity() in sched.h).
>

Same thoughts here; I was going for the arch_set_freq_scale() way.

> But for me, Valentin's implementation seems more natural as setters are
> usually only called from within the framework that does the control
> (throttling for thermal or frequency setting for cpufreq) and we
> probably want to think twice if we want to call them from other places.
>

Well TBH I was tempted to go the other way and keep the definition in
core.c, given a simple per-cpu value is fairly generic. More precisely, it
seems somewhat awkward that architectures have to redefine those interfaces
when, given what cpufreq_cooling is doing, they'll have to go for per-cpu
storage in some way or another.

I ultimately decided against it, seeing as it isn't too difficult to come
up with other drivers of thermal pressure. There was that TDP-bound thing
[1], where IIUC you could end up with throttling not because of thermal but
because of power constraints. And then there's always FW that can cap stuff
as a last resort, and some architectures will want to inform the scheduler
of that when/if they'll be able to query FW for that.

[1]: 20200428032258.2518-1-currojerez@riseup.net

> Thanks,
> Ionela.
