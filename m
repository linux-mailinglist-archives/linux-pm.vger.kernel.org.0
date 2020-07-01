Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AED84210FBB
	for <lists+linux-pm@lfdr.de>; Wed,  1 Jul 2020 17:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732024AbgGAPvj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Jul 2020 11:51:39 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36314 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728105AbgGAPvi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jul 2020 11:51:38 -0400
Received: by mail-ot1-f66.google.com with SMTP id 72so21784544otc.3;
        Wed, 01 Jul 2020 08:51:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7CgWcGqMVGu85tSwcPfY6iFZQOZQ9HLynyZ95T8j5pA=;
        b=gJ37C+5N7fBUwP3VEyJWxV3fiwMAql2HTnIPW5207VjN4Pt0pU+coMeQEvAhvuy3ln
         nPQexR5yxoOi9BljUnKa4lpcuIcDHQscSQnJp59itF5m/uxzPTO2e4z3VYOItvoMzMTJ
         NAf068t5jgMwvmdSfeiCc2jOohv3SkAz+VHe3YHscV2QhsWnKQ63Po8+njPSRo9uV97R
         EjdgZR6IxrgCFk0l4D/04UbEvAHU2wpIN/kCVaOQhez1fysD/JXkQaR+3MgAs+qt3sIl
         zZiRWZ/dJCQ9V5eJEMh2ZqTK6XGdp/SwCs3Dy8h+01pI67RjgpOr7O+pzryMbXSy0u32
         JxVA==
X-Gm-Message-State: AOAM531iblnuPEvPTiGg10vdMC2o6naMo1y8gnPdZ/WkmR/BNsMl3LcJ
        /RZ7gSWEooG2geRRF17a+pk9BNlNehsup5CP9j5vvA3q
X-Google-Smtp-Source: ABdhPJwhRsjhXZKzUR1OnXm9DZo2OalsEw+NEpFM7aYk8N/BlKSBwuXCL3Ci7BynRlZ5yOzj1nn0arezhFRvq5PdgVY=
X-Received: by 2002:a9d:39f5:: with SMTP id y108mr23620584otb.262.1593618697292;
 Wed, 01 Jul 2020 08:51:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200701090751.7543-1-ionela.voinescu@arm.com>
 <20200701090751.7543-3-ionela.voinescu@arm.com> <20200701095219.gxrkowtukosnfmwp@vireshk-i7>
 <20200701152751.GA29496@arm.com>
In-Reply-To: <20200701152751.GA29496@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 1 Jul 2020 17:51:26 +0200
Message-ID: <CAJZ5v0gg4CtixKXEWG4agPATJxm5NZ4bnNVsqt7mRpwZS0Nygw@mail.gmail.com>
Subject: Re: [PATCH 2/8] cpufreq: move invariance setter calls in cpufreq core
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Will Deacon <will@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 1, 2020 at 5:28 PM Ionela Voinescu <ionela.voinescu@arm.com> wrote:
>
> Hey,
>
> On Wednesday 01 Jul 2020 at 16:16:19 (+0530), Viresh Kumar wrote:
> > On 01-07-20, 10:07, Ionela Voinescu wrote:
> > > From: Valentin Schneider <valentin.schneider@arm.com>
> > >
> > > To properly scale its per-entity load-tracking signals, the task scheduler
> > > needs to be given a frequency scale factor, i.e. some image of the current
> > > frequency the CPU is running at. Currently, this scale can be computed
> > > either by using counters (APERF/MPERF on x86, AMU on arm64), or by
> > > piggy-backing on the frequency selection done by cpufreq.
> > >
> > > For the latter, drivers have to explicitly set the scale factor
> > > themselves, despite it being purely boiler-plate code: the required
> > > information depends entirely on the kind of frequency switch callback
> > > implemented by the driver, i.e. either of: target_index(), target(),
> > > fast_switch() and setpolicy().
> > >
> > > The fitness of those callbacks with regard to driving the Frequency
> > > Invariance Engine (FIE) is studied below:
> > >
> > > target_index()
> > > ==============
> > > Documentation states that the chosen frequency "must be determined by
> > > freq_table[index].frequency". It isn't clear if it *has* to be that
> > > frequency, or if it can use that frequency value to do some computation
> > > that ultimately leads to a different frequency selection. All drivers
> > > go for the former, while the vexpress-spc-cpufreq has an atypical
> > > implementation.
> > >
> > > Thefore, the hook works on the asusmption the core can use
> > > freq_table[index].frequency.
> > >
> > > target()
> > > =======
> > > This has been flagged as deprecated since:
> > >
> > >   commit 9c0ebcf78fde ("cpufreq: Implement light weight ->target_index() routine")
> > >
> > > It also doesn't have that many users:
> > >
> > >   cpufreq-nforce2.c:371:2:  .target = nforce2_target,
> > >   cppc_cpufreq.c:416:2:             .target = cppc_cpufreq_set_target,
> > >   pcc-cpufreq.c:573:2:              .target = pcc_cpufreq_target,
> > >
> > > Should we care about drivers using this hook, we may be able to exploit
> > > cpufreq_freq_transition_{being, end}(). Otherwise, if FIE support is
> > > desired in their current state, arch_set_freq_scale() could still be
> > > called directly by the driver, while CPUFREQ_CUSTOM_SET_FREQ_SCALE
> > > could be used to mark support for it.
> > >
> > > fast_switch()
> > > =============
> > > This callback *has* to return the frequency that was selected.
> > >
> > > setpolicy()
> > > ===========
> > > This callback does not have any designated way of informing what was the
> > > end choice. But there are only two drivers using setpolicy(), and none
> > > of them have current FIE support:
> > >
> > >   drivers/cpufreq/longrun.c:281:    .setpolicy      = longrun_set_policy,
> > >   drivers/cpufreq/intel_pstate.c:2215:      .setpolicy      = intel_pstate_set_policy,
> > >
> > > The intel_pstate is known to use counter-driven frequency invariance.
> >
> > Same for acpi-cpufreq driver as well ?
> >
>
> The acpi-cpufreq driver defines target_index() and fast_switch() so it
> should go through the setting in cpufreq core. But x86 does not actually
> define arch_set_freq_scale() so when called it won't do anything (won't
> set any frequency scale factor), but rely on counters to set it through
> the arch_scale_freq_tick().

Right.

So on x86 (Intel flavor of it at least), cpufreq has nothing to do
with this regardless of what driver is in use.

> But this cpufreq functionality could potentially be used.

How so?

>
> > And I think we should do the freq-invariance thing for all the above categories
> > nevertheless.
> >
>
> I'm not sure what you mean by this. You mean we should also (try to) set
> the frequency scale factor for drivers defining setpolicy() and target()?

No, we shouldn't.

The sched tick potentially does that already and nothing more needs to
be done unless we know it for the fact that the scale factor is not
set by the tick.

> > > If FIE support is desired in their current state, arch_set_freq_scale()
> > > could still be called directly by the driver, while
> > > CPUFREQ_CUSTOM_SET_FREQ_SCALE could be used to mark support for it.
> > >
> > > Conclusion
> > > ==========
> > >
> > > Given that the significant majority of current FIE enabled drivers use
> > > callbacks that lend themselves to triggering the setting of the FIE scale
> > > factor in a generic way, move the invariance setter calls to cpufreq core,
> > > while filtering drivers that flag custom support using
> > > CPUFREQ_CUSTOM_SET_FREQ_SCALE.
> > >
> > > Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> > > Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
> > > Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> > > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > > ---
> > >  drivers/cpufreq/cpufreq.c | 20 +++++++++++++++++---
> > >  1 file changed, 17 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > > index 0128de3603df..83b58483a39b 100644
> > > --- a/drivers/cpufreq/cpufreq.c
> > > +++ b/drivers/cpufreq/cpufreq.c
> > > @@ -2046,9 +2046,16 @@ EXPORT_SYMBOL(cpufreq_unregister_notifier);
> > >  unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
> > >                                     unsigned int target_freq)
> > >  {
> > > +   unsigned int freq;
> > > +
> > >     target_freq = clamp_val(target_freq, policy->min, policy->max);
> > > +   freq = cpufreq_driver->fast_switch(policy, target_freq);
> > > +
> >
> > > +   if (freq && !(cpufreq_driver->flags & CPUFREQ_CUSTOM_SET_FREQ_SCALE))
> > > +           arch_set_freq_scale(policy->related_cpus, freq,
> > > +                               policy->cpuinfo.max_freq);

policy->cpuinfo.max_freq need not be the one to use in all cases when
boost is supported.

policy->cpuinfo.max_freq may be the max boost freq and you may want to
scale with respect to the max sustainable one anyway.

> > This needs to be a separate function.
> >
>
> Yes, that would be nicer.
>
> > >
> > > -   return cpufreq_driver->fast_switch(policy, target_freq);
> > > +   return freq;
> > >  }
> > >  EXPORT_SYMBOL_GPL(cpufreq_driver_fast_switch);
> > >
> > > @@ -2140,7 +2147,7 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
> > >                         unsigned int relation)
> > >  {
> > >     unsigned int old_target_freq = target_freq;
> > > -   int index;
> > > +   int index, retval;
> > >
> > >     if (cpufreq_disabled())
> > >             return -ENODEV;
> > > @@ -2171,7 +2178,14 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
> > >
> > >     index = cpufreq_frequency_table_target(policy, target_freq, relation);
> > >
> > > -   return __target_index(policy, index);
> > > +   retval = __target_index(policy, index);
> > > +
> > > +   if (!retval && !(cpufreq_driver->flags & CPUFREQ_CUSTOM_SET_FREQ_SCALE))
> > > +           arch_set_freq_scale(policy->related_cpus,
> > > +                               policy->freq_table[index].frequency,
> >
> > policy->cur gets updated for both target and target_index type drivers. You can
> > use that safely. It gets updated after the postchange notification.
> >
>
> This would allow us to cover the drivers that define target() as well (not
> only target_index() and fast_switch()). Looking over the code we only take
> that path (calling cpufreq_freq_transition_end()), for
> !CPUFREQ_ASYNC_NOTIFICATION. But again, that's only used for
> powernow-k8 which is deprecated.
>
> I'll attempt a nice way to use this.

On arches like x86, policy->cur may not be the current frequency of
the CPU, though.  On relatively recent systems it actually isn't that
frequency most of the time.

Thanks!
