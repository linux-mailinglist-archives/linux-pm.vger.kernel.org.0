Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1D6E220C9D
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 14:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbgGOMEY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 08:04:24 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38311 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbgGOMEX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 08:04:23 -0400
Received: by mail-ot1-f68.google.com with SMTP id t18so1251048otq.5;
        Wed, 15 Jul 2020 05:04:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=COgSnqiHdsvpSrUVDPxZKyeGd8a5JZvZGl/ezVnlLsM=;
        b=XrtocoybbpYlg29cub96BwdbdVYNAZ4hGHAGDJaFSVI8c62Jz5XbXqv58FH31c2Iqa
         cbKhz0sI0oOlEeR2PkR2r9slhWH7gNfSmZH3cncEzyu9Q5GK4PADnLSbxqRb6vRYVbFK
         aNppHUP2rqL0kVuuCSMnqT0rEEwCCEGRIggWB4IqjiJujsZv63leOFgHIMIXqQ4PqA9Z
         K9I584LqZ3tp9Mg8BY2GW97N8jPWuSVhIF6qxHq9c1Fe3DV3twoLuszBIUEvMUWsMf5y
         K04eFPAcCC6+NT2DI/y0oeJbMAZF9lhDtEb8r1D5bfXAKDy9fhb1QKQ6qPbX/KfJvVsk
         NIlg==
X-Gm-Message-State: AOAM533i+GI7tV2lHj5+CdVqlp6i15zgmsDuCByHG46CxBWBiAo3+1vn
        uLt9uWjf0pYAersNd/WlBjJZK9yKPjUp+bNg7lc=
X-Google-Smtp-Source: ABdhPJyKCemu4mOfDTJCxGJcxJsVgLiBuXRCBwVxkm973hf9JUl9+h+WYEK9LpVhOv4zwbeb0L2qf43Sf1/8duSzFJg=
X-Received: by 2002:a9d:1c82:: with SMTP id l2mr8261569ota.167.1594814662056;
 Wed, 15 Jul 2020 05:04:22 -0700 (PDT)
MIME-Version: 1.0
References: <3955470.QvD6XneCf3@kreacher> <87r1tdiqpu.fsf@riseup.net>
In-Reply-To: <87r1tdiqpu.fsf@riseup.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 15 Jul 2020 14:04:11 +0200
Message-ID: <CAJZ5v0jaRm-wv+ZKhOyGJrrKZAsTKc3sq2GYyv0uerTTe3gXbQ@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Implement passive mode with HWP enabled
To:     Francisco Jerez <currojerez@riseup.net>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Doug Smythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 15, 2020 at 2:09 AM Francisco Jerez <currojerez@riseup.net> wrote:
>
> "Rafael J. Wysocki" <rjw@rjwysocki.net> writes:
>
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Allow intel_pstate to work in the passive mode with HWP enabled and
> > make it set the HWP minimum performance limit (HWP floor) to the
> > P-state value given by the target frequency supplied by the cpufreq
> > governor, so as to prevent the HWP algorithm and the CPU scheduler
> > from working against each other, at least when the schedutil governor
> > is in use, and update the intel_pstate documentation accordingly.
> >
> > Among other things, this allows utilization clamps to be taken
> > into account, at least to a certain extent, when intel_pstate is
> > in use and makes it more likely that sufficient capacity for
> > deadline tasks will be provided.
> >
> > After this change, the resulting behavior of an HWP system with
> > intel_pstate in the passive mode should be close to the behavior
> > of the analogous non-HWP system with intel_pstate in the passive
> > mode, except that in the frequency range below the base frequency
> > (ie. the frequency retured by the base_frequency cpufreq attribute
> > in sysfs on HWP systems) the HWP algorithm is allowed to go above
> > the floor P-state set by intel_pstate with or without hardware
> > coordination of P-states among CPUs in the same package.
> >
> > Also note that the setting of the HWP floor may not be taken into
> > account by the processor in the following cases:
> >
> >  * For the HWP floor in the range of P-states above the base
> >    frequency, referred to as the turbo range, the processor has a
> >    license to choose any P-state from that range, either below or
> >    above the HWP floor, just like a non-HWP processor in the case
> >    when the target P-state falls into the turbo range.
> >
> >  * If P-states of the CPUs in the same package are coordinated
> >    at the hardware level, the processor may choose a P-state
> >    above the HWP floor, just like a non-HWP processor in the
> >    analogous case.
> >
> > With this change applied, intel_pstate in the passive mode
> > assumes complete control over the HWP request MSR and concurrent
> > changes of that MSR (eg. via the direct MSR access interface) are
> > overridden by it.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > This basically unifies the passive mode behavior of intel_pstate for systems
> > with and without HWP enabled.  The only case in which there is a difference
> > between the two (after this patch) is below the turbo range, where the HWP
> > algorithm can go above the floor regardless of whether or not P-state are
> > coordinated package-wide (this means the systems with per-core P-states
> > mostly is where the difference can be somewhat visible).
> >
> > Since the passive mode hasn't worked with HWP at all, and it is not going to
> > the default for HWP systems anyway, I don't see any drawbacks related to making
> > this change, so I would consider this as 5.9 material unless there are any
> > serious objections.
> >
> > Thanks!
> >
> > ---
> >  Documentation/admin-guide/pm/intel_pstate.rst |   89 +++++++---------
> >  drivers/cpufreq/intel_pstate.c                |  141 ++++++++++++++++++++------
> >  2 files changed, 152 insertions(+), 78 deletions(-)
> >
> > Index: linux-pm/drivers/cpufreq/intel_pstate.c
> > ===================================================================
> > --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
> > +++ linux-pm/drivers/cpufreq/intel_pstate.c
> > @@ -36,6 +36,7 @@
> >  #define INTEL_PSTATE_SAMPLING_INTERVAL       (10 * NSEC_PER_MSEC)
> >
> >  #define INTEL_CPUFREQ_TRANSITION_LATENCY     20000
> > +#define INTEL_CPUFREQ_TRANSITION_DELAY_HWP   5000
> >  #define INTEL_CPUFREQ_TRANSITION_DELAY               500
> >
> >  #ifdef CONFIG_ACPI
> > @@ -222,6 +223,7 @@ struct global_params {
> >   *                   preference/bias
> >   * @epp_saved:               Saved EPP/EPB during system suspend or CPU offline
> >   *                   operation
> > + * @epp_cached               Cached HWP energy-performance preference value
> >   * @hwp_req_cached:  Cached value of the last HWP Request MSR
> >   * @hwp_cap_cached:  Cached value of the last HWP Capabilities MSR
> >   * @last_io_update:  Last time when IO wake flag was set
> > @@ -259,6 +261,7 @@ struct cpudata {
> >       s16 epp_policy;
> >       s16 epp_default;
> >       s16 epp_saved;
> > +     s16 epp_cached;
> >       u64 hwp_req_cached;
> >       u64 hwp_cap_cached;
> >       u64 last_io_update;
> > @@ -676,6 +679,8 @@ static int intel_pstate_set_energy_pref_
> >
> >               value |= (u64)epp << 24;
> >               ret = wrmsrl_on_cpu(cpu_data->cpu, MSR_HWP_REQUEST, value);
> > +
> > +             WRITE_ONCE(cpu_data->epp_cached, epp);
>
> Why introduce a new EPP cache variable if there is already
> hwp_req_cached?  If intel_pstate_set_energy_pref_index() is failing to
> update hwp_req_cached maybe we should fix that instead.  That will save
> you a little bit of work in intel_cpufreq_adjust_hwp().

Yes, it would, but then we'd need to explicitly synchronize
intel_pstate_set_energy_pref_index() with the scheduler context which
I'd rather avoid.

> >       } else {
> >               if (epp == -EINVAL)
> >                       epp = (pref_index - 1) << 2;
> > @@ -2047,6 +2052,7 @@ static int intel_pstate_init_cpu(unsigne
> >               cpu->epp_default = -EINVAL;
> >               cpu->epp_powersave = -EINVAL;
> >               cpu->epp_saved = -EINVAL;
> > +             WRITE_ONCE(cpu->epp_cached, -EINVAL);
> >       }
> >
> >       cpu = all_cpu_data[cpunum];
> > @@ -2245,7 +2251,10 @@ static int intel_pstate_verify_policy(st
> >
> >  static void intel_cpufreq_stop_cpu(struct cpufreq_policy *policy)
> >  {
> > -     intel_pstate_set_min_pstate(all_cpu_data[policy->cpu]);
> > +     if (hwp_active)
> > +             intel_pstate_hwp_force_min_perf(policy->cpu);
> > +     else
> > +             intel_pstate_set_min_pstate(all_cpu_data[policy->cpu]);
> >  }
> >
> >  static void intel_pstate_stop_cpu(struct cpufreq_policy *policy)
> > @@ -2253,12 +2262,10 @@ static void intel_pstate_stop_cpu(struct
> >       pr_debug("CPU %d exiting\n", policy->cpu);
> >
> >       intel_pstate_clear_update_util_hook(policy->cpu);
> > -     if (hwp_active) {
> > +     if (hwp_active)
> >               intel_pstate_hwp_save_state(policy);
> > -             intel_pstate_hwp_force_min_perf(policy->cpu);
> > -     } else {
> > -             intel_cpufreq_stop_cpu(policy);
> > -     }
> > +
> > +     intel_cpufreq_stop_cpu(policy);
> >  }
> >
> >  static int intel_pstate_cpu_exit(struct cpufreq_policy *policy)
> > @@ -2388,13 +2395,82 @@ static void intel_cpufreq_trace(struct c
> >               fp_toint(cpu->iowait_boost * 100));
> >  }
> >
> > +static void intel_cpufreq_adjust_hwp(struct cpudata *cpu, u32 target_pstate,
> > +                                  bool fast_switch)
> > +{
> > +     u64 prev = READ_ONCE(cpu->hwp_req_cached), value = prev;
> > +     s16 epp;
> > +
> > +     value &= ~HWP_MIN_PERF(~0L);
> > +     value |= HWP_MIN_PERF(target_pstate);
> > +
> > +     /*
> > +      * The entire MSR needs to be updated in order to update the HWP min
> > +      * field in it, so opportunistically update the max too if needed.
> > +      */
> > +     value &= ~HWP_MAX_PERF(~0L);
> > +     value |= HWP_MAX_PERF(cpu->max_perf_ratio);
> > +
> > +     /*
> > +      * In case the EPP has been adjusted via sysfs, write the last cached
> > +      * value of it to the MSR as well.
> > +      */
> > +     epp = READ_ONCE(cpu->epp_cached);
> > +     if (epp >= 0) {
> > +             value &= ~GENMASK_ULL(31, 24);
> > +             value |= (u64)epp << 24;
> > +     }
> > +
> > +     if (value == prev)
> > +             return;
> > +
> > +     WRITE_ONCE(cpu->hwp_req_cached, value);
> > +     if (fast_switch)
> > +             wrmsrl(MSR_HWP_REQUEST, value);
> > +     else
> > +             wrmsrl_on_cpu(cpu->cpu, MSR_HWP_REQUEST, value);
> > +}
>
> I've asked this question already but you may have missed it: Given that
> you are of the opinion that [1] should be implemented in schedutil
> instead with intel_pstate in HWP passive mode, what's your plan for
> exposing the HWP_MAX_PERF knob to the governor in addition to
> HWP_MIN_PERF, since the interface implemented here only allows the
> governor to provide a single frequency?
>
> [1] https://lwn.net/ml/linux-pm/20200428032258.2518-1-currojerez@riseup.net/

This is not just about the schedutil governor, but about cpufreq
governors in general (someone may still want to use the performance
governor on top of intel_pstate, for example).

And while governors can only provide one frequency, the policy limits
in the cpufreq framework are based on QoS lists now and so it is
possible to add a max limit request, say from a driver, to the max QoS
list, and update it as needed, causing the max policy limit to be
adjusted.

That said I'm not exactly sure how useful the max limit generally is
in practice on HWP systems, given that setting it above the base
frequency causes it to be ignored, effectively, and the turbo range
may be wider than the range of P-states below the base frequency.

Generally, I'm not quite convinced that limiting the max frequency is
really the right choice for controlling the processor's power draw on
the systems in question.  There are other ways to do that, which in
theory should be more effective.  I mentioned RAPL somewhere in this
context and there's the GUC firmware too.
