Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8F6D3AA44A
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jun 2021 21:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbhFPT2H (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Jun 2021 15:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbhFPT2G (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Jun 2021 15:28:06 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A480FC061574
        for <linux-pm@vger.kernel.org>; Wed, 16 Jun 2021 12:25:58 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id l4so5472174ljg.0
        for <linux-pm@vger.kernel.org>; Wed, 16 Jun 2021 12:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QpD0jrWW3F2Djy8vNVOSNel8eIzeclXpCinXK192tNA=;
        b=Z/95wOnJkBvZrnN7uwM0/AhddfjvG0YA/5HXcH4rt4FnpoQNIOa4i3gH+rZ9pxdFTR
         yvMI2+WazcDJDDhaXJEri2jt0wj7fVzDRxQ/wplA8DAPs05zfmUYevJGxFzIGId9gmAc
         GqoBzzx/uYS3KCbiK2AIcC6H5aAPoO5cA4d1jVsHDYtasfe6iCxJCZ0ocmK6PvRvj6BV
         0iISjoH2AVIpg6al+SvIvDNVp7E8eZVBJswig/X2grdfMWsNhe9DJ6BHCymo652SCV6s
         d5nh6tePkPAp4amIa5BPu7tBbsvUKmTmb08Cj3Na8mMjtV08xwpAviJSHOKTcmgrDTrU
         0DrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QpD0jrWW3F2Djy8vNVOSNel8eIzeclXpCinXK192tNA=;
        b=LCI0tv9KcKuFhWV76o2Z1sYBpnK5t4v6AyhPKdOzlFq443hxD8KMie+cz9//5gAjhQ
         CHzxJFsV8nRiC75aX1iTG+hHD/Zf4c2vyIQ1LO47ibCwPXqawCi0g4fRUSQHKj9FvjLR
         FpjwAVNYjPh1taSIMiLMD1LO38WZq4wrcGoZBQIJV5l8l0eIhHUBvR2oRosTw6V+yGlF
         0cp46R6O3udVeDGfdG15eQjTFOHOhZfRNKrbjMA8uvkYSjyYahgRTMpKHnQTgSzF6nmE
         1Lmv9noAaA0UOqAiVNqpp2I23aX4K+novdKZdUq7ynyrYarMLZsnh8SZoJEvHJCWzSXF
         1D5A==
X-Gm-Message-State: AOAM532J4cT5AgWqbwsRR91pIGIg+JgtwFwp7tVMryHnuqfSI1kzfDrX
        bfx3R0oV/Z8rlpe7XaMlesACDxUAxr4LX9b2H9pwPQ==
X-Google-Smtp-Source: ABdhPJzll2bcsnDx+MEkquTClRqluVgTTHbjQvOkdR3cnKFjseC1yuSuUpE2pS4MRXOB39WIE5+2RY7EQgOzYvz0vgQ=
X-Received: by 2002:a2e:b80f:: with SMTP id u15mr1287036ljo.284.1623871557012;
 Wed, 16 Jun 2021 12:25:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210614185815.15136-1-lukasz.luba@arm.com> <20210614191128.22735-1-lukasz.luba@arm.com>
 <237ef538-c8ca-a103-b2cc-240fc70298fe@arm.com> <d214db57-879c-cf3f-caa8-76c2cd369e0d@arm.com>
 <9821712d-be27-a2e7-991c-b0010e23fa70@arm.com>
In-Reply-To: <9821712d-be27-a2e7-991c-b0010e23fa70@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 16 Jun 2021 21:25:45 +0200
Message-ID: <CAKfTPtCpWrubqp2W8NQA0JTh2dJx3oxGuCBJbZ04reFzCbDxEg@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] sched/fair: Take thermal pressure into account
 while estimating energy
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Lukasz Luba <lukasz.luba@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Quentin Perret <qperret@google.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Beata Michalska <Beata.Michalska@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, segall@google.com,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Amit Kachhap <amit.kachhap@gmail.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 16 Jun 2021 at 19:24, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 15/06/2021 18:09, Lukasz Luba wrote:
> >
> > On 6/15/21 4:31 PM, Dietmar Eggemann wrote:
> >> On 14/06/2021 21:11, Lukasz Luba wrote:
>
> [...]
>
> >> It's important to highlight that this will only fix this issue between
> >> schedutil and EAS when it's due to `thermal pressure` (today only via
> >> CPU cooling). There are other places which could restrict policy->max
> >> via freq_qos_update_request() and EAS will be unaware of it.
> >
> > True, but for this I have some other plans.
>
> As long as people are aware of the fact that this was developed to be
> beneficial for `EAS - IPA` integration, I'm fine with this.

I don't think it's only for EAS - IPA. Thermal_pressure can be used by
HW throttling like here:
https://lkml.org/lkml/2021/6/8/1791

EAS is involved but not IPA

>
> [...]
>
> >> IMHO, this means that this is catered for the IPA governor then. I'm not
> >> sure if this would be beneficial when another thermal governor is used?
> >
> > Yes, it will be, the cpufreq_set_cur_state() is called by
> > thermal exported function:
> > thermal_cdev_update()
> >   __thermal_cdev_update()
> >     thermal_cdev_set_cur_state()
> >       cdev->ops->set_cur_state(cdev, target)
> >
> > So it can be called not only by IPA. All governors call it, because
> > that's the default mechanism.
>
> True, but I'm still not convinced that it is useful outside `EAS - IPA`.
>
> >> The mechanical side of the code would allow for such benefits, I just
> >> don't know if their CPU cooling device + thermal zone setups would cater
> >> for this?
> >
> > Yes, it's possible. Even for custom vendor governors (modified clones
> > of IPA)
>
> Let's stick to mainline here ;-) It's complicated enough ...
>
> [...]
>
> >> Maybe shorter?
> >>
> >>          struct cpumask *pd_mask = perf_domain_span(pd);
> >> -       unsigned long cpu_cap =
> >> arch_scale_cpu_capacity(cpumask_first(pd_mask));
> >> +       int cpu = cpumask_first(pd_mask);
> >> +       unsigned long cpu_cap = arch_scale_cpu_capacity(cpu);
> >> +       unsigned long _cpu_cap = cpu_cap -
> >> arch_scale_thermal_pressure(cpu);
> >>          unsigned long max_util = 0, sum_util = 0;
> >> -       unsigned long _cpu_cap = cpu_cap;
> >> -       int cpu;
> >> -
> >> -       _cpu_cap -= arch_scale_thermal_pressure(cpumask_first(pd_mask));
> >
> > Could be, but still, the definitions should be sorted from longest on
> > top, to shortest at the bottom. I wanted to avoid modifying too many
> > lines with this simple patch.
>
> Only if there are no dependencies, but here we have already `cpu_cap ->
> pd_mask`. OK, not a big deal.
>
> [...]
>
> >> There is IPA specific code in cpufreq_set_cur_state() ->
> >> get_state_freq() which accesses the EM:
> >>
> >>      ...
> >>      return cpufreq_cdev->em->table[idx].frequency;
> >>      ...
> >>
> >> Has it been discussed that the `per-PD max (allowed) CPU capacity` (1)
> >> could be stored in the EM from there so that code like the EAS wakeup
> >> code (compute_energy()) could retrieve this information from the EM?
> >
> > No, we haven't think about this approach in these patch sets.
> > The EM structure given to the cpufreq_cooling device and stored in:
> > cpufreq_cdev->em should not be modified. There are a few places which
> > receive the EM, but they all should not touch it. For those clients
> > it's a read-only data structure.
> >
> >> And there wouldn't be any need to pass (1) into the EM (like now via
> >> em_cpu_energy()).
> >> This would be signalling within the EM compared to external signalling
> >> via `CPU cooling -> thermal pressure <- EAS wakeup -> EM`.
> >
> > I see what you mean, but this might cause some issues in the design
> > (per-cpu scmi cpu perf control). Let's use this EM pointer gently ;)
>
> OK, with the requirement that clients see the EM as ro:
>
> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
