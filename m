Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFB7401F1E
	for <lists+linux-pm@lfdr.de>; Mon,  6 Sep 2021 19:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240979AbhIFRYS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Sep 2021 13:24:18 -0400
Received: from mga05.intel.com ([192.55.52.43]:3037 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233888AbhIFRYS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 6 Sep 2021 13:24:18 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10099"; a="305571875"
X-IronPort-AV: E=Sophos;i="5.85,272,1624345200"; 
   d="scan'208";a="305571875"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2021 10:23:13 -0700
X-IronPort-AV: E=Sophos;i="5.85,272,1624345200"; 
   d="scan'208";a="502379955"
Received: from ibelagox-mobl1.gar.corp.intel.com ([10.213.76.130])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2021 10:23:10 -0700
Message-ID: <8dc57921f157b154e4af2dba26ce697dc4d4fcc2.camel@linux.intel.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Fix for HWP interrupt before
 driver is ready
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 06 Sep 2021 10:23:06 -0700
In-Reply-To: <CAJZ5v0jaXnw0zjpnsb81Hauy4-ApuULfQaaLG10qqL67H-YTNA@mail.gmail.com>
References: <20210904053703.581297-1-srinivas.pandruvada@linux.intel.com>
         <CAJZ5v0hQp8Hxf__tL22s0oOcTym5mx9tND34ijufTDE3_NSW6A@mail.gmail.com>
         <926ac4b9-1bb5-e96e-ded3-6461f7a215b7@kernel.dk>
         <b1d5b6daacef349eb6fcc23ce7264e4786d1d9f4.camel@linux.intel.com>
         <CAJZ5v0jaXnw0zjpnsb81Hauy4-ApuULfQaaLG10qqL67H-YTNA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 2021-09-06 at 18:58 +0200, Rafael J. Wysocki wrote:
> On Mon, Sep 6, 2021 at 6:55 PM Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> > 
> > On Mon, 2021-09-06 at 10:43 -0600, Jens Axboe wrote:
> > > On 9/6/21 10:17 AM, Rafael J. Wysocki wrote:
> > > > On Sat, Sep 4, 2021 at 7:37 AM Srinivas Pandruvada
> > > > <srinivas.pandruvada@linux.intel.com> wrote:
> > > > > 
> > > > > In Lenovo X1 gen9 laptop, HWP interrupts arrive before driver
> > > > > is
> > > > > ready
> > > > > to handle on that CPU. Basically didn't even allocated memory
> > > > > for
> > > > > per
> > > > > cpu data structure and not even started interrupt enable
> > > > > process
> > > > > on that
> > > > > CPU. So interrupt handler observes a NULL pointer to schedule
> > > > > work.
> > > > > 
> > > > > This interrupt was probably for SMM, but since it is
> > > > > redirected
> > > > > to
> > > > > OS by OSC call, OS receives it, but not ready to handle. That
> > > > > redirection
> > > > > of interrupt to OS was also done to solve one SMM crash on
> > > > > Yoga
> > > > > 260 for
> > > > > HWP interrupt a while back.
> > > > > 
> > > > > To solve this the HWP interrupt handler should ignore such
> > > > > request if the
> > > > > driver is not ready. This will require some flag to wait till
> > > > > the
> > > > > driver
> > > > > setup a workqueue to handle on a CPU. We can't simply assume
> > > > > cpudata to
> > > > > be NULL and avoid processing as it may not be NULL but data
> > > > > structure is
> > > > > not in consistent state.
> > > > > 
> > > > > So created a cpumask which sets the CPU on which interrupt
> > > > > was
> > > > > setup. If
> > > > > not setup, simply clear the interrupt status and return.
> > > > > Since
> > > > > the
> > > > > similar issue can happen during S3 resume, clear the bit
> > > > > during
> > > > > offline.
> > > > > 
> > > > > Since interrupt timing may be before HWP is enabled, use safe
> > > > > MSR
> > > > > read
> > > > > writes as before the change for HWP interrupt.
> > > > > 
> > > > > Fixes: d0e936adbd22 ("cpufreq: intel_pstate: Process HWP
> > > > > Guaranteed change notification")
> > > > > Reported-and-tested-by: Jens Axboe <axboe@kernel.dk>
> > > > > Signed-off-by: Srinivas Pandruvada <
> > > > > srinivas.pandruvada@linux.intel.com>
> > > > > ---
> > > > >  drivers/cpufreq/intel_pstate.c | 23 ++++++++++++++++++++++-
> > > > >  1 file changed, 22 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/drivers/cpufreq/intel_pstate.c
> > > > > b/drivers/cpufreq/intel_pstate.c
> > > > > index b4ffe6c8a0d0..5ac86bfa1080 100644
> > > > > --- a/drivers/cpufreq/intel_pstate.c
> > > > > +++ b/drivers/cpufreq/intel_pstate.c
> > > > > @@ -298,6 +298,8 @@ static bool hwp_boost __read_mostly;
> > > > > 
> > > > >  static struct cpufreq_driver *intel_pstate_driver
> > > > > __read_mostly;
> > > > > 
> > > > > +static cpumask_t hwp_intr_enable_mask;
> > > > > +
> > > > >  #ifdef CONFIG_ACPI
> > > > >  static bool acpi_ppc;
> > > > >  #endif
> > > > > @@ -1067,11 +1069,15 @@ static void
> > > > > intel_pstate_hwp_set(unsigned
> > > > > int cpu)
> > > > >         wrmsrl_on_cpu(cpu, MSR_HWP_REQUEST, value);
> > > > >  }
> > > > > 
> > > > > +static void intel_pstate_disable_hwp_interrupt(struct
> > > > > cpudata
> > > > > *cpudata);
> > > > > +
> > > > >  static void intel_pstate_hwp_offline(struct cpudata *cpu)
> > > > >  {
> > > > >         u64 value = READ_ONCE(cpu->hwp_req_cached);
> > > > >         int min_perf;
> > > > > 
> > > > > +       intel_pstate_disable_hwp_interrupt(cpu);
> > > > > +
> > > > >         if (boot_cpu_has(X86_FEATURE_HWP_EPP)) {
> > > > >                 /*
> > > > >                  * In case the EPP has been set to
> > > > > "performance"
> > > > > by the
> > > > > @@ -1645,20 +1651,35 @@ void notify_hwp_interrupt(void)
> > > > >         if (!hwp_active ||
> > > > > !boot_cpu_has(X86_FEATURE_HWP_NOTIFY))
> > > > >                 return;
> > > > > 
> > > > > -       rdmsrl(MSR_HWP_STATUS, value);
> > > > > +       rdmsrl_safe(MSR_HWP_STATUS, &value);
> > > > >         if (!(value & 0x01))
> > > > >                 return;
> > > > > 
> > > > > +       if (!cpumask_test_cpu(this_cpu,
> > > > > &hwp_intr_enable_mask)) {
> > > > > +               wrmsrl_safe(MSR_HWP_STATUS, 0);
> > > > > +               return;
> > > > > +       }
> > > > 
> > > > Without additional locking, there is a race between this and
> > > > intel_pstate_disable_hwp_interrupt().
> > > > 
> > > > 1. notify_hwp_interrupt() checks hwp_intr_enable_mask() and the
> > > > target
> > > > CPU is in there, so it will go for scheduling the delayed work.
> > > > 2. intel_pstate_disable_hwp_interrupt() runs between the check
> > > > and
> > > > the
> > > > cpudata load below.
> > > > 3. hwp_notify_work is scheduled on the CPU that isn't there in
> > > > the
> > > > mask any more.
> > > 
> > > I noticed that too, not clear to me how much of an issue that is
> > > in
> > > practice. But there's definitely a race there.
> > Glad to see how this is possible from code running in ISR context.
> 
> intel_pstate_disable_hwp_interrupt() may very well run on a different
> CPU in parallel with the interrupt handler running on this CPU.  Or
> is
> this not possible for some reason?
I see the offline callback is called from cpufreq core from hotplug
online/offline callback. So this should run the call on the target CPU.
From Documentation
"The states CPUHP_AP_OFFLINE … CPUHP_AP_ONLINE are invoked just the
after the CPU has been brought up. The interrupts are off and the
scheduler is not yet active on this CPU. Starting with CPUHP_AP_OFFLINE
the callbacks are invoked on the target CPU."

The only other place it is called is from subsys remove callback. Not
sure how can you remove cpufreq subsys on fly.

Let's say it is possible:
While running ISR on a local CPU, how can someone pull the CPU before
its completion? If the CPU is going away after that, the workqueue is
unbounded. So it will run on some other CPU, here if that happens it
will call cpufreq update policy, which will be harmless.

"
static void unbind_workers(int cpu)

This is solved by allowing the pools to be disassociated from the CPU
 * running as an unbound one and allowing it to be reattached later if
the
 * cpu comes back online.
"


Thanks,
Srinivas



