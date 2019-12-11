Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D43111A754
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2019 10:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbfLKJgZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Dec 2019 04:36:25 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42244 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727493AbfLKJgZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Dec 2019 04:36:25 -0500
Received: by mail-ot1-f68.google.com with SMTP id 66so18221312otd.9
        for <linux-pm@vger.kernel.org>; Wed, 11 Dec 2019 01:36:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5v/V1j5G85ien6p4lq+TatwrjzuO6wf75tSVQ3zRMPU=;
        b=FWlghPvzS5f7HVXcuZo2MdED9lprGrzazRi25Ch1xAuANhc8t2nRvlL1/u8YvMkQPW
         ffC326fT+cAhRDRY7kR7HDgEfFIGaUOp6htVPgvZjNoUBz2zbi3gkg2+5HKbcxLD2mFi
         AUyc2xABMDqo4+GGeUkLAwiCaW5AY9oRqe1sTJ5uQZMJxu01XW5sgqn+cRuT8yI+/0yX
         6iO1kYSZKqnFA105fNqbGrSnlv08H6M2qCTymCm7cUscWpbCdwcWkZ9Nnhf4EBdOfRO9
         xSrnfCTCIo19aUk7tRoNZE1+gYFIFF7s2JpgGcH6jaMeK9NIQLCYTazSZc1Vtc6RibOU
         d9mQ==
X-Gm-Message-State: APjAAAVCW0jko0K3Aikz/Bm5n5LULK7RwYkSuVjepayyL6jz4Vzze3a0
        T6fMhaRwdabAyAc2VD/SnpJo6k8q42KllDFSLuxlZA==
X-Google-Smtp-Source: APXvYqx5GZqWblJRUb/42J6S70q29yxpOigXTAJhhq80Ppw/udU0DD9g2xyzbYw1G51Qd2iBzPAjOYjY1s44WUCFXks=
X-Received: by 2002:a05:6830:95:: with SMTP id a21mr1472257oto.167.1576056983367;
 Wed, 11 Dec 2019 01:36:23 -0800 (PST)
MIME-Version: 1.0
References: <DB3PR0402MB39165E1B832597ADBAB241AAF55C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <DB3PR0402MB3916C7E77C885343B2B961CFF55B0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <5310126.hg2rr5Fjtk@kreacher> <7233060.oySJ2cjCuV@kreacher> <AM0PR04MB4481EDA9EB0374E698A6754C885A0@AM0PR04MB4481.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB4481EDA9EB0374E698A6754C885A0@AM0PR04MB4481.eurprd04.prod.outlook.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 11 Dec 2019 10:36:12 +0100
Message-ID: <CAJZ5v0g15AupBe05kN5Mp8NRQYgTEwd80QoJ3kTajnnfD51O6w@mail.gmail.com>
Subject: Re: About CPU hot-plug stress test failed in cpufreq driver
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Anson Huang <anson.huang@nxp.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jacky Bai <ping.bai@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Dec 11, 2019 at 9:59 AM Peng Fan <peng.fan@nxp.com> wrote:
>
> > Subject: Re: About CPU hot-plug stress test failed in cpufreq driver
> >
> > On Tuesday, December 10, 2019 11:39:25 AM CET Rafael J. Wysocki wrote:
> > > On Tuesday, December 10, 2019 9:51:43 AM CET Anson Huang wrote:
> > > >
> > > > > -----Original Message-----
> > > > > From: Rafael J. Wysocki <rjw@rjwysocki.net>
> > > > > Sent: Tuesday, December 10, 2019 4:51 PM
> > > > > To: Anson Huang <anson.huang@nxp.com>
> > > > > Cc: Rafael J. Wysocki <rafael@kernel.org>; Viresh Kumar
> > > > > <viresh.kumar@linaro.org>; Peng Fan <peng.fan@nxp.com>; Jacky Bai
> > > > > <ping.bai@nxp.com>; linux-pm@vger.kernel.org; Vincent Guittot
> > > > > <vincent.guittot@linaro.org>; Peter Zijlstra
> > > > > <peterz@infradead.org>; Paul McKenney
> > <paulmck@linux.vnet.ibm.com>
> > > > > Subject: Re: About CPU hot-plug stress test failed in cpufreq
> > > > > driver
> > > > >
> > > > > On Tuesday, December 10, 2019 9:45:09 AM CET Anson Huang wrote:
> > > > > >
> > > > > > > -----Original Message-----
> > > > > > > From: Rafael J. Wysocki <rafael@kernel.org>
> > > > > > > Sent: Tuesday, December 10, 2019 4:38 PM
> > > > > > > To: Anson Huang <anson.huang@nxp.com>
> > > > > > > Cc: Rafael J. Wysocki <rafael@kernel.org>; Viresh Kumar
> > > > > > > <viresh.kumar@linaro.org>; Peng Fan <peng.fan@nxp.com>; Rafael
> > J.
> > > > > > > Wysocki <rjw@rjwysocki.net>; Jacky Bai <ping.bai@nxp.com>;
> > > > > > > linux- pm@vger.kernel.org; Vincent Guittot
> > > > > > > <vincent.guittot@linaro.org>; Peter Zijlstra
> > > > > > > <peterz@infradead.org>; Paul McKenney
> > > > > > > <paulmck@linux.vnet.ibm.com>
> > > > > > > Subject: Re: About CPU hot-plug stress test failed in cpufreq
> > > > > > > driver
> > > > > > >
> > > > > > > On Tue, Dec 10, 2019 at 9:29 AM Anson Huang
> > > > > > > <anson.huang@nxp.com>
> > > > > > > wrote:
> > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > > -----Original Message-----
> > > > > > > > > From: Rafael J. Wysocki <rafael@kernel.org>
> > > > > > > > > Sent: Tuesday, December 10, 2019 4:22 PM
> > > > > > > > > To: Viresh Kumar <viresh.kumar@linaro.org>
> > > > > > > > > Cc: Peng Fan <peng.fan@nxp.com>; Rafael J. Wysocki
> > > > > > > > > <rafael@kernel.org>; Anson Huang <anson.huang@nxp.com>;
> > > > > > > > > Rafael
> > > > > J.
> > > > > > > > > Wysocki <rjw@rjwysocki.net>; Jacky Bai <ping.bai@nxp.com>;
> > > > > > > > > linux- pm@vger.kernel.org; Vincent Guittot
> > > > > > > > > <vincent.guittot@linaro.org>; Peter Zijlstra
> > > > > > > > > <peterz@infradead.org>; Paul McKenney
> > > > > > > > > <paulmck@linux.vnet.ibm.com>
> > > > > > > > > Subject: Re: About CPU hot-plug stress test failed in
> > > > > > > > > cpufreq driver
> > > > > > > > >
> > > > > > > > > On Tue, Dec 10, 2019 at 8:05 AM Viresh Kumar
> > > > > > > > > <viresh.kumar@linaro.org>
> > > > > > > > > wrote:
> > > > > > > > > >
> > > > > > > > > > +few more guys
> > > > > > > > > >
> > > > > > > > > > On 10-12-19, 05:53, Peng Fan wrote:
> > > > > > > > > > > But per
> > > > > > > > > > > https://eur01.safelinks.protection.outlook.com/?url=ht
> > > > > > > > > > > tps%3A
> > > > > > > > > > > %2F%
> > > > > > > > > > > 2Fel
> > > > > > > > > > > ixir.bootlin.com%2Flinux%2Fv5.5-
> > > > > > > > > rc1%2Fsource%2Fkernel%2Fsched%2Fsche
> > > > > > > > > > >
> > > > > > > > >
> > > > > > >
> > > > >
> > d.h%23L2293&amp;data=02%7C01%7Canson.huang%40nxp.com%7C6f4490
> > 0
> > > > > > > > > be3404
> > > > > > > > > > >
> > > > > > > > >
> > > > > > >
> > > > >
> > e7d355708d77d4a16fa%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0
> > %
> > > > > > > > > 7C637
> > > > > > > > > > >
> > > > > > > > >
> > > > > > >
> > > > >
> > 115629475456329&amp;sdata=XXhwvuTOBb3TLmerwkr1zKbaWNA8xA%2Bl
> > > > > > > > > W%2Faw31
> > > > > > > > > > > 0AYcM%3D&amp;reserved=0
> > > > > > > > > > > cpu_of(rq) and smp_processor_id() is possible to not
> > > > > > > > > > > the same,
> > > > > > > > > > >
> > > > > > > > > > > When cpu_of(rq) is not equal to smp_processor_id(),
> > > > > > > > > > > dbs_update_util_handler will use irq_work_queue to
> > > > > > > > > > > smp_processor_id(), not cpu_of(rq). Is this expected?
> > > > > > > > > > > Or should the irq_work be queued to cpu_of(rq)?
> > > > > > > > > >
> > > > > > > > > > Okay, sorry for the long weekend where I couldn't get
> > > > > > > > > > time to reply at
> > > > > > > all.
> > > > > > > > >
> > > > > > > > > No worries. :-)
> > > > > > > > >
> > > > > > > > > > First of all, lets try to understand dvfs_possible_from_any_cpu.
> > > > > > > > > >
> > > > > > > > > > Who can update the frequency of a CPU ? For many
> > > > > > > > > > architectures/platforms the eventual code that writes to
> > > > > > > > > > some register to change the frequency should only run on
> > > > > > > > > > the local CPU, as these registers are per-cpu registers
> > > > > > > > > > and not something shared
> > > > > > > between CPUs.
> > > > > > > > > >
> > > > > > > > > > But for the ARM architecture, we have a PLL and then
> > > > > > > > > > some more registers to play with the clk provided to the
> > > > > > > > > > CPU blocks and these registers (which are updated as a
> > > > > > > > > > result of
> > > > > > > > > > clk_set_rate()) are part of a
> > > > > > > > > block outside of the CPU blocks.
> > > > > > > > > > And so any CPU (even if it is not part of the same
> > > > > > > > > > cpufreq
> > > > > > > > > > policy) can update it. Setting this flag allows that and
> > > > > > > > > > eventually we may end up updating the frequency sooner,
> > > > > > > > > > instead of later (which may be less effective). That was
> > > > > > > > > > the idea of
> > > > > the remote-wakeup series.
> > > > > > > > > > This stuff is absolutely correct and so cpufreq-dt does
> > > > > > > > > > it for
> > > > > everyone.
> > > > > > > > > >
> > > > > > > > > > This also means that the normal work and irq-work both
> > > > > > > > > > can run on any CPU for your platform and it should be okay to
> > do that.
> > > > > > > > >
> > > > > > > > > And it the failing case all of the CPUs in the system are
> > > > > > > > > in the same policy anyway, so dvfs_possible_from_any_cpu is a
> > red herring.
> > > > > > > > >
> > > > > > > > > > Now, we have necessary measures in place to make sure
> > > > > > > > > > that after stopping and before starting a governor, the
> > > > > > > > > > scheduler hooks to save the cpufreq governor pointer and
> > > > > > > > > > updates to
> > > > > > > > > > policy->cpus are made properly, to make sure that we
> > > > > > > > > > policy->never
> > > > > > > > > > ever schedule a work or irq-work on a CPU which is offline.
> > > > > > > > > > Now it looks like this isn't working as expected and we
> > > > > > > > > > need to find
> > > > > what exactly is broken here.
> > > > > > > > > >
> > > > > > > > > > And yes, I did the testing on Hikey 620, an octa-core
> > > > > > > > > > ARM platform which has a single cpufreq policy which has
> > > > > > > > > > all the 8 CPUs. And yes, I am using cpufreq-dt only and
> > > > > > > > > > I wasn't able to reproduce the problem with mainline kernel as
> > I explained earlier.
> > > > > > > > > >
> > > > > > > > > > The problem is somewhere between the scheduler's
> > > > > > > > > > governor hook
> > > > > > > > > running
> > > > > > > > > > or queuing work on a CPU which is in the middle of
> > > > > > > > > > getting offline/online and there is some race around
> > > > > > > > > > that. The problem hence may not be related to just
> > > > > > > > > > cpufreq, but a wider variety of
> > > > > clients.
> > > > > > > > >
> > > > > > > > > The problem is that a CPU is running a governor hook which
> > > > > > > > > it shouldn't be running at all.
> > > > > > > > >
> > > > > > > > > The observation that dvfs_possible_from_any_cpu makes a
> > > > > > > > > difference only means that the governor hook is running on
> > > > > > > > > a CPU that is not present in the
> > > > > > > > > policy->cpus mask.  On the platform(s) in question this
> > > > > > > > > policy->cannot happen as
> > > > > > > > > long as RCU works as expected.
> > > > > > > >
> > > > > > > > If I understand correctly, the governor hook ONLY be clear
> > > > > > > > on the CPU being offline and after governor stopped, but the
> > > > > > > > CPU being offline could still run into below function to
> > > > > > > > help other CPU update the util, and it ONLY checks the
> > > > > > > > cpu_of(rq)'s governor hook which is valid as that
> > > > > > > CPU is online.
> > > > > > > >
> > > > > > > > So the question is how to avoid the CPU being offline and
> > > > > > > > already finish the governor stop flow be scheduled to help
> > > > > > > > other CPU update the
> > > > > > > util.
> > > > > > > >
> > > > > > > >  static inline void cpufreq_update_util(struct rq *rq,
> > > > > > > > unsigned int
> > > > > > > > flags)  {
> > > > > > > >          struct update_util_data *data;
> > > > > > > >
> > > > > > > >          data =
> > > > > > > rcu_dereference_sched(*per_cpu_ptr(&cpufreq_update_util_data,
> > > > > > > >
> > cpu_of(rq)));
> > > > > > > >          if (data)
> > > > > > > >                  data->func(data, rq_clock(rq), flags);  }
> > > > > > >
> > > > > > > OK, so that's where the problem is, good catch!
> > > > > > >
> > > > > > > So what happens is that a CPU going offline runs some
> > > > > > > scheduler code that invokes cpufreq_update_util().
> > > > > > > Incidentally, it is not the cpu_of(rq), but that CPU is still
> > > > > > > online, so the callback is invoked and then policy->cpus test
> > > > > > > is bypassed because of
> > > > > dvfs_possible_from_any_cpu.
> > > > > >
> > > > > > If this is the issue, add another check here for the current
> > > > > > CPU's governor
> > > > > hook?
> > > > > > Or any other better place to make sure the CPU being offline NOT
> > > > > > to be
> > > > > queued to irq work?
> > > > >
> > > > > Generally, yes.
> > > > >
> > > > > Something like the patch below should help if I'm not mistaken:
> > > > >
> > > > > ---
> > > > >  include/linux/cpufreq.h |    8 +++++---
> > > > >  1 file changed, 5 insertions(+), 3 deletions(-)
> > > > >
> > > > > Index: linux-pm/include/linux/cpufreq.h
> > > > >
> > ==============================================================
> > ==
> > > > > ===
> > > > > --- linux-pm.orig/include/linux/cpufreq.h
> > > > > +++ linux-pm/include/linux/cpufreq.h
> > > > > @@ -599,11 +599,13 @@ static inline bool cpufreq_this_cpu_can_  {
> > > > >         /*
> > > > >          * Allow remote callbacks if:
> > > > > -        * - dvfs_possible_from_any_cpu flag is set
> > > > >          * - the local and remote CPUs share cpufreq policy
> > > > > +        * - dvfs_possible_from_any_cpu flag is set and the CPU running
> > the
> > > > > +        *   code is not going offline.
> > > > >          */
> > > > > -       return policy->dvfs_possible_from_any_cpu ||
> > > > > -               cpumask_test_cpu(smp_processor_id(), policy->cpus);
> > > > > +       return cpumask_test_cpu(smp_processor_id(), policy->cpus) ||
> > > > > +               (policy->dvfs_possible_from_any_cpu &&
> > > > > +                !cpumask_test_cpu(smp_processor_id(), policy-
> > > > > >related_cpus));
> > > > >  }
> > > >
> > > > I will start a stress test of this patch, thanks!
> > >
> > > OK, thanks!
> > >
> > > Another patch to test is appended and it should be more robust.
> > >
> > > Instead of doing the related_cpus cpumask check in the previous patch
> > > (which only covered CPUs that belog to the target policy) it checks if
> > > the update_util hook is set for the local CPU (if it is not, that CPU
> > > is not expected to run the uodate_util code).
> >
> > One more thing.
> >
> > Both of the previous patches would not fix the schedutil governor in which
> > cpufreq_this_cpu_can_update() only is called in the fast_switch case and that
> > is not when irq_works are used.
> >
> > So please discard the patch I have just posted and here is an updated patch
> > that covers schedutil too, so please test this one instead.
> >
> > ---
> >  include/linux/cpufreq.h          |   11 -----------
> >  include/linux/sched/cpufreq.h    |    3 +++
> >  kernel/sched/cpufreq.c           |   18 ++++++++++++++++++
> >  kernel/sched/cpufreq_schedutil.c |    8 +++-----
> >  4 files changed, 24 insertions(+), 16 deletions(-)
> >
> > Index: linux-pm/include/linux/cpufreq.h
> > ==============================================================
> > =====
> > --- linux-pm.orig/include/linux/cpufreq.h
> > +++ linux-pm/include/linux/cpufreq.h
> > @@ -595,17 +595,6 @@ struct governor_attr {
> >                        size_t count);
> >  };
> >
> > -static inline bool cpufreq_this_cpu_can_update(struct cpufreq_policy *policy)
> > -{
> > -     /*
> > -      * Allow remote callbacks if:
> > -      * - dvfs_possible_from_any_cpu flag is set
> > -      * - the local and remote CPUs share cpufreq policy
> > -      */
> > -     return policy->dvfs_possible_from_any_cpu ||
> > -             cpumask_test_cpu(smp_processor_id(), policy->cpus);
> > -}
> > -
> >
> > /*************************************************************
> > ********
> >   *                     FREQUENCY TABLE HELPERS
> > *
> >
> > **************************************************************
> > *******/
> > Index: linux-pm/kernel/sched/cpufreq.c
> > ==============================================================
> > =====
> > --- linux-pm.orig/kernel/sched/cpufreq.c
> > +++ linux-pm/kernel/sched/cpufreq.c
> > @@ -5,6 +5,8 @@
> >   * Copyright (C) 2016, Intel Corporation
> >   * Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >   */
> > +#include <linux/cpufreq.h>
> > +
> >  #include "sched.h"
> >
> >  DEFINE_PER_CPU(struct update_util_data __rcu *,
> > cpufreq_update_util_data); @@ -57,3 +59,19 @@ void
> > cpufreq_remove_update_util_hook(int
> >       rcu_assign_pointer(per_cpu(cpufreq_update_util_data, cpu), NULL);  }
> > EXPORT_SYMBOL_GPL(cpufreq_remove_update_util_hook);
> > +
> > +/**
> > + * cpufreq_this_cpu_can_update - Check if cpufreq policy can be updated.
> > + * @policy: cpufreq policy to check.
> > + *
> > + * Return 'true' if:
> > + * - the local and remote CPUs share @policy,
> > + * - dvfs_possible_from_any_cpu is set in @policy and the local CPU is not
> > going
> > + *   offline (in which it is not expected to run cpufreq updates any more).
> > + */
> > +bool cpufreq_this_cpu_can_update(struct cpufreq_policy *policy) {
> > +     return cpumask_test_cpu(smp_processor_id(), policy->cpus) ||
> > +             (policy->dvfs_possible_from_any_cpu &&
> > +
> > rcu_dereference_sched(*this_cpu_ptr(&cpufreq_update_util_data)));
> > +}
> > Index: linux-pm/include/linux/sched/cpufreq.h
> > ==============================================================
> > =====
> > --- linux-pm.orig/include/linux/sched/cpufreq.h
> > +++ linux-pm/include/linux/sched/cpufreq.h
> > @@ -12,6 +12,8 @@
> >  #define SCHED_CPUFREQ_MIGRATION      (1U << 1)
> >
> >  #ifdef CONFIG_CPU_FREQ
> > +struct cpufreq_policy;
> > +
> >  struct update_util_data {
> >         void (*func)(struct update_util_data *data, u64 time, unsigned int
> > flags);  }; @@ -20,6 +22,7 @@ void cpufreq_add_update_util_hook(int cp
> >                         void (*func)(struct update_util_data *data, u64
> > time,
> >                                   unsigned int flags));
> >  void cpufreq_remove_update_util_hook(int cpu);
> > +bool cpufreq_this_cpu_can_update(struct cpufreq_policy *policy);
> >
> >  static inline unsigned long map_util_freq(unsigned long util,
> >                                       unsigned long freq, unsigned long cap)
> > Index: linux-pm/kernel/sched/cpufreq_schedutil.c
> > ==============================================================
> > =====
> > --- linux-pm.orig/kernel/sched/cpufreq_schedutil.c
> > +++ linux-pm/kernel/sched/cpufreq_schedutil.c
> > @@ -82,12 +82,10 @@ static bool sugov_should_update_freq(str
> >        * by the hardware, as calculating the frequency is pointless if
> >        * we cannot in fact act on it.
> >        *
> > -      * For the slow switching platforms, the kthread is always scheduled on
> > -      * the right set of CPUs and any CPU can find the next frequency and
> > -      * schedule the kthread.
> > +      * This is needed on the slow switching platforms too to prevent CPUs
> > +      * going offline from leaving stale IRQ work items behind.
> >        */
> > -     if (sg_policy->policy->fast_switch_enabled &&
> > -         !cpufreq_this_cpu_can_update(sg_policy->policy))
> > +     if (!cpufreq_this_cpu_can_update(sg_policy->policy))
> >               return false;
> >
> >       if (unlikely(sg_policy->limits_changed)) {
>
> So we will not queue irq_work on the offlining CPU in your patch.
>
> When we met issue on CPU3, it is CPU3 has irq_work pending,
> but the SGI IRQ_WORK interrupt is not handled because irq is
> always disabled, see stack in idle irq disabled state.
>
> [  227.344678] CPU: 3 PID: 0 Comm: swapper/3 Not tainted 5.4.0-03554-gbb1159fa5556-dirty #95
> [  227.344682] Hardware name: Freescale i.MX8QXP MEK (DT)
> [  227.344686] Call trace:
> [  227.344701]  dump_backtrace+0x0/0x140
> [  227.344708]  show_stack+0x14/0x20
> [  227.344717]  dump_stack+0xb4/0xf8
> [  227.344730]  dbs_update_util_handler+0x150/0x180
> [  227.344739]  update_load_avg+0x38c/0x3c8
> [  227.344746]  enqueue_task_fair+0xcc/0x3a0
> [  227.344756]  activate_task+0x5c/0xa0
> [  227.344766]  ttwu_do_activate.isra.0+0x4c/0x70
> [  227.344776]  try_to_wake_up+0x2d8/0x410
> [  227.344786]  wake_up_process+0x14/0x20
> [  227.344794]  swake_up_locked.part.0+0x18/0x38
> [  227.344801]  swake_up_one+0x30/0x48
> [  227.344808]  rcu_gp_kthread_wake+0x5c/0x80
> [  227.344815]  rcu_report_qs_rsp+0x40/0x50
> [  227.344825]  rcu_report_qs_rnp+0x120/0x148
> [  227.344832]  rcu_report_dead+0x120/0x130
> [  227.344841]  cpuhp_report_idle_dead+0x3c/0x80
> [  227.344847]  do_idle+0x198/0x280
> [  227.344856]  cpu_startup_entry+0x24/0x40
> [  227.344865]  secondary_start_kernel+0x154/0x190
> [  227.344905] CPU3: shutdown
> [  227.444015] psci: CPU3 killed.
>
>
> I also met CPU1 offlining have irq_work queued, but CPU1
> not trigger issue, because SGI IRQ_WORK interrupt is handled.
>
> There are multiple path to run into dbs_update_util_handler
> irq_work_queue, the path might will enable interrupt, might not.
>
> Seem do_idle is the only path that will trigger cpu_die for HOTPLUG
> ARM/ARM64.
>
> So do we need to use idle as flag to queue irq_work or not?
> In this way, we could still inject irq work on offlining/offline cpu, until
> it runs into idle to cpu_die.

To be honest, I'm not sure what you mean.

In cpufreq we cannot just avoid queuing up an IRQ work, because we've
already made changes in preparation for it to run.  We need to decide
whether or not to carry out the entire utilization update upfront.

But preventing CPUs with NULL cpufreq_update_util_data pointers from
running cpufreq utilization update code at all (like in the last
patch) should be sufficient to address this problem entirely.  At
least I don't see why not.

Thanks!
