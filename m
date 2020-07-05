Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C11DC214D0A
	for <lists+linux-pm@lfdr.de>; Sun,  5 Jul 2020 16:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgGEOT4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 5 Jul 2020 10:19:56 -0400
Received: from foss.arm.com ([217.140.110.172]:55728 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726781AbgGEOT4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 5 Jul 2020 10:19:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C87C1042;
        Sun,  5 Jul 2020 07:19:55 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 377F83F718;
        Sun,  5 Jul 2020 07:19:53 -0700 (PDT)
References: <20200614010755.9129-1-valentin.schneider@arm.com> <20200614010755.9129-2-valentin.schneider@arm.com> <CAKfTPtCyi9acak95_2_2uL3Cf0OMAbZhDav2LbPY+ULPrD7z4w@mail.gmail.com> <20200620174912.GA18358@arm.com> <jhjmu4xcqyk.mognet@arm.com> <CAKfTPtDG26Y9s4c+MbdmbxJaiCv6s6WTqmzztcoFsm2SnRL=vQ@mail.gmail.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ionela Voinescu <ionela.voinescu@arm.com>,
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
In-reply-to: <CAKfTPtDG26Y9s4c+MbdmbxJaiCv6s6WTqmzztcoFsm2SnRL=vQ@mail.gmail.com>
Date:   Sun, 05 Jul 2020 15:19:44 +0100
Message-ID: <jhjlfjyf3i7.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Sorry for getting back to this only now;

On 22/06/20 09:37, Vincent Guittot wrote:
> On Sun, 21 Jun 2020 at 00:28, Valentin Schneider <valentin.schneider@arm.com> wrote:
>> On 20/06/20 18:49, Ionela Voinescu wrote:
>> > On Thursday 18 Jun 2020 at 17:03:24 (+0200), Vincent Guittot wrote:
>> >> Having this weak function declared in cpufreq_cooling is weird. This
>> >> means that we will have to do so for each one that wants to use it.
>> >>
>> >> Can't you declare an empty function in a common header file ?
>> >
>> > Do we expect anyone other than cpufreq_cooling to call
>> > arch_set_thermal_pressure()?
>> >
>> > I'm not against any of the options, either having it here as a week
>> > default definition (same as done for arch_set_freq_scale() in cpufreq.c)
>> > or in a common header (as done for arch_scale_freq_capacity() in sched.h).
>> >
>>
>> Same thoughts here; I was going for the arch_set_freq_scale() way.
>>
>> > But for me, Valentin's implementation seems more natural as setters are
>> > usually only called from within the framework that does the control
>> > (throttling for thermal or frequency setting for cpufreq) and we
>> > probably want to think twice if we want to call them from other places.
>> >
>>
>> Well TBH I was tempted to go the other way and keep the definition in
>> core.c, given a simple per-cpu value is fairly generic. More precisely, it
>
> Having all definitions in the same place is my main concern here.
> If topology.c defines arch_set_thermal_pressure it should also provide
> the empty function when the feature is not available or possible
> instead of relying of each user of the interface to define a weak
> function just in case.
>

include/linux/sched/topology.h already defines a stub for
arch_scale_thermal_pressure(), I suppose we could have one for
arch_set_thermal_pressure() there.

That would require having something like

#define arch_set_thermal_pressure topology_set_thermal_pressure

in the arm & arm64 include/asm/topology.h headers, with
topology_set_thermal_pressure() being what arch_set_thermal_pressure()
currently is in this patchset.


This would set an odd precedent in that so far we only ever had to #define
getter functions, the setters being either:
- entirely contained within arch_topology. (for the CPU scale)
- defined in arch_topology, declared in cpufreq and contained there (for
  the freq scale).

It made the most sense to me to follow the arch_set_freq_scale() pattern
and contain the thermal pressure setter within cpufreq_cooling, especially
since I didn't see a strong point in breaking the current patterns.
