Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0282C3C8AF6
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jul 2021 20:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbhGNSdh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Jul 2021 14:33:37 -0400
Received: from mail-oo1-f44.google.com ([209.85.161.44]:33442 "EHLO
        mail-oo1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbhGNSdh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Jul 2021 14:33:37 -0400
Received: by mail-oo1-f44.google.com with SMTP id n187-20020a4a40c40000b029025e72bdf5d6so871134ooa.0;
        Wed, 14 Jul 2021 11:30:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ovcwutsXpiG5PF947O/cC+FCzVZA7RGw2zz4tiQl1Po=;
        b=fkyP8gdyxlFpI+tt0mM850kCyJpgCAA3pdTurmsRSjxVKeHLeTmkIXvlU2H3gp5RW0
         TftA2OJ1ywZo7/wYZp73yfQLRcc/UPFuj0G9LaeADz7hukGK1n4gSq4/YAoSQ6Rs1wMR
         j1vdVzuymeGTIqaCGm68aQb01RAGyQ1nmUydcNpMt+rdQh75YLcRiI1ZvsqZYehmzOwz
         rAzVLPOSnAQnnHhlgYk065yBSR9M+AEAe7pmDrOEbpA23jwSiXgoTHlQAGTYyRW5auiD
         /gQ0ak2M15KE03NORFfWhNHT7cJ77/OD7Oton2+9vZ806W8u6d/RCw9PvfUcpnWRCef5
         W/xg==
X-Gm-Message-State: AOAM530YM3/8Qo1GB/SaaaYv2liGav5a07ExO46L43O6T8cvHyR1jygC
        qJZNih1v/5cE1BDop7Q+25t9z/u3zg9eqjJ4Fmk=
X-Google-Smtp-Source: ABdhPJzW7qq0ZzbfQY/MwN8zLoMWCROgoxIjTbOATpmgUKxW48ZSyNTDCkmhve/e8M6aCPI7J3GOghX6E0iCtxUlgFM=
X-Received: by 2002:a4a:5dc6:: with SMTP id w189mr9092015ooa.1.1626287443914;
 Wed, 14 Jul 2021 11:30:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210706131828.22309-1-lukasz.luba@arm.com> <CAJZ5v0ga1O9Y9Lam=BoXofE7sjTNpYVSTjAWvSGZ+j__aCeXJw@mail.gmail.com>
 <1de9d474-fdeb-8db6-0b01-53a90f7c20c8@arm.com> <CAJZ5v0gzpfT__EyrVuZSr32ms7-YJZw7qEok0WZECv1iDRRvWA@mail.gmail.com>
 <4d4801c3-1d84-9754-815c-71a6412cf4f3@arm.com>
In-Reply-To: <4d4801c3-1d84-9754-815c-71a6412cf4f3@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 14 Jul 2021 20:30:33 +0200
Message-ID: <CAJZ5v0i3UUKxQbcfTVWHOeje-LTOnuAMda3FX0D5sqHLXEs3Xg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/6] Introduce Active Stats framework with CPU
 performance statistics
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Chris Redpath <Chris.Redpath@arm.com>, Beata.Michalska@arm.com,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Amit Kachhap <amit.kachhap@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Sorry for the delay.

On Tue, Jul 6, 2021 at 6:51 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
>
>
> On 7/6/21 5:34 PM, Rafael J. Wysocki wrote:
> > On Tue, Jul 6, 2021 at 5:56 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
> >>
> >> On 7/6/21 4:28 PM, Rafael J. Wysocki wrote:
> >>> On Tue, Jul 6, 2021 at 3:18 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
> >>>>
> >>>> Hi all,
> >>>>
> >>>> This patch set introduces a new mechanism: Active Stats framework (ASF), which
> >>>> gathers and maintains statistics of CPU performance - time residency at each
> >>>> performance state.
> >>>>
> >>>> The ASF tracks all the frequency transitions as well as CPU
> >>>> idle entry/exit events for all CPUs. Based on that it accounts the active
> >>>> (non-idle) residency time for each CPU at each frequency. This information can
> >>>> be used by some other subsystems (like thermal governor) to enhance their
> >>>> estimations about CPU usage at a given period.
> >>>
> >>> This seems to mean that what is needed is something like the cpufreq
> >>> stats but only collected during the time when CPUs are not in idle
> >>> states.
> >>
> >> Yes
> >
> > So this is a clear problem statement: the cpufreq statistics cover the
> > time when CPUs are in idle states, so they are not suitable for
> > certain purposes, like thermal control.
>
> Agree, it's better described problem statement.
>
> >
> > The most straightforward approach to address it seems to be to modify
> > the collection of cpufreq statistics so that they don't include the
> > time spent by CPUs in idle states, or to make it possible to
> > distinguish the time spent in idle states from the "active" time.
> >
> >>>> Does it fix something in mainline?
> >>>> Yes, there is thermal governor Intelligent Power Allocation (IPA), which
> >>>> estimates the CPUs power used in the past. IPA is sampling the CPU utilization
> >>>> and frequency and relies on the info available at the time of sampling
> >>>> and this imposes the estimation errors.
> >>>> The use of ASF solve the issue and enables IPA to make better estimates.
> >>>
> >>> Obviously the IPA is not used on all platforms where cpufreq and
> >>> cpuidle are used.  What platforms are going to benefit from this
> >>> change?
> >>
> >> Arm platforms which still use kernel thermal to control temperature,
> >> such as Chromebooks or mid-, low-end phones.
> >
> > Which means that this feature is not going to be universally useful.
> >
> > However, if the time spent by CPUs in idle states were accounted for
> > in the cpufreq statistics, that would be universally useful.
>
> True
>
> >
> >>>
> >>>> Why it couldn't be done using existing frameworks?
> >>>> The CPUFreq and CPUIdle statistics are not combined, so it is not possible
> >>>> to derive the information on how long exactly the CPU was running with a given
> >>>> frequency.
> >>>
> >>> But it doesn't mean that the statistics could not be combined.
> >>>
> >>> For instance, the frequency of the CPU cannot change via cpufreq when
> >>> active_stats_cpu_idle_enter() is running, so instead of using an
> >>> entirely new framework for collecting statistics it might update the
> >>> existing cpufreq stats to register that event.
> >>
> >> True, but keep in mind that the cpufreq most likely works for a few
> >> CPUs (policy::related_cpus), while cpuidle in a per-cpu fashion.
> >> I would say that cpuidle should check during enter/exit what is
> >> the currently set frequency for cluster and account its active
> >> period.
> >
> > Yes, that's not particularly difficult to achieve in principle: on
> > idle entry and exit, update the cpufreq statistics of the policy
> > including the current CPU.
>
> Sounds good.
>
> >
> >>>
> >>> And analogously for the wakeup.
> >>>
> >>>> This new framework combines that information and provides
> >>>> it in a handy way.
> >>>
> >>> I'm not convinced about the last piece.
> >>
> >> The handy structure is called Active Stats Monitor. It samples
> >> the stats gathered after processing idle. That private
> >> structure maintains statistics which are for a given period
> >> (current snapshot - previous snapshot).
> >
> > So collecting the statistics should be fast and simple and processing
> > them need not be.
> >
> > Ideally, they should be processed only when somebody asks the data.
>
> Correct.
>
> >
> > I'm not sure if that is the case in the current patchset.
>
> Which is the case in current implementation, where the Active Stats
> Monitor (ASM) is run in the context of thermal workqueue. It is
> scheduled every 100ms to run IPA throttling, which does the
> statistics gathering and calculation in the ASM. Time accounted for this
> major calculation is moved to the 'client' (like IPA) context.
>
> >
> >>>
> >>>> IMHO it has to be implemented as a new framework, next to
> >>>> CPUFreq and CPUIdle, due to a clean design and not just hooks from thermal
> >>>> governor into the frequency change and idle code paths.
> >>>
> >>> As far as the design is concerned, I'm not sure if I agree with it.
> >>>
> >>>   From my perspective it's all a 1000-line patch that I have to read and
> >>> understand to figure out what the design is.
> >>
> >> I can help you with understanding it with some design docs if you want.
> >
> > That may help, but let's avoid doing extra work just yet.
>
> Understood
>
> >
> >>>
> >>>> Tha patch 4/6 introduces a new API for cooling devices, which allows to
> >>>> stop tracking the freq and idle statistics.
> >>>>
> >>>> The patch set contains also a patches 5/6 6/6 which adds the new power model
> >>>> based on ASF into the cpufreq cooling (used by thermal governor IPA).
> >>>> It is added as ifdef option, since Active Stats might be not compiled in.
> >>>> The ASF is a compile time option, but that might be changed and IPA could
> >>>> select it, which would allow to remove some redundant code from
> >>>> cpufreq_cooling.c.
> >>>>
> >>>> Comments and suggestions are very welcome.
> >>>
> >>> I'm totally not convinced that it is necessary to put the extra 1000
> >>> lines of code into the kernel to address the problem at hand.
> >>>
> >>
> >> I understand your concerns. If you have another idea than this framework
> >> I'm happy to hear it. Maybe better stats in cpuidle, which would be
> >> are of the cpufreq?
> >
> > One idea that I have is outlined above and I'm not seeing a reason to
> > put cpufreq statistics into cpuidle.
> >
>
> I'm happy to prepare such RFC if you like.

Well, it should be quite clear that I would prefer this to the
original approach, if viable at all. :-)

> I would just need a bit more information.

OK

> It sounds your proposed solution might be smaller in code
> size, since the client's statistics accounting might be moved to the
> cpufreq_cooling.c (which now live in the ASM). Also, there won't be a
> new framework to maintain (which is a big plus).

Right.
