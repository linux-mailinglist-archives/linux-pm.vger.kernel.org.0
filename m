Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49AC81E0F62
	for <lists+linux-pm@lfdr.de>; Mon, 25 May 2020 15:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390719AbgEYNX7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 May 2020 09:23:59 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33149 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388685AbgEYNX7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 May 2020 09:23:59 -0400
Received: by mail-ot1-f67.google.com with SMTP id v17so13846711ote.0;
        Mon, 25 May 2020 06:23:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lKcylKx93r/wOpHzhdxMmD4v8ts9DIzYV8SX+zfE+o4=;
        b=Mga+gPdMFYSxfTDanPPWzS7dABd95BqA+P1ZXa8VPNHvFIfpRywgh/Mbpxgsuz7VgL
         QDJZKLd6cXXpNVg8fYl6TiSYYSpCFhaqm/3APuoh7qKFkxfWb941igk6EKNojXbEUIqX
         uecbvhEq+EAUBfJkfVEFLVsfVRqKkzTEUUKAKQtXonPBDPpWXh5lj3phM+FcFGUzLqpE
         IdxoNSoqopsi7DZ9SVneKYfkT6lLtHHyMCcbq/3Ksj9SKKb5GeigfP0hnOBf5HGoXZVp
         vT0wWk0NCSIL/Wd7oVjqg5CrxGwpeZQxQ4pUr9uR6lPaR6GcXNx+RbFJ+H2qvJYanp0f
         glVg==
X-Gm-Message-State: AOAM531H8NXVw/cUHJapW2gjky27ZrhYpI7fXZqtl+3n/2if1J78RVrm
        fbf9q3XCHjiyXpdUKI5lDBeYq8ZY7xTZNyiqYKE=
X-Google-Smtp-Source: ABdhPJyY61c7eNoJeM8XyhRi5p7Ejy0kYy1iwAmz5dGvp4vUrjEqJHVevMb3DUOBdBVsgzkhA8nS2/iEz71bbBDgjHw=
X-Received: by 2002:a9d:6c0f:: with SMTP id f15mr18601337otq.118.1590413037749;
 Mon, 25 May 2020 06:23:57 -0700 (PDT)
MIME-Version: 1.0
References: <3169564.ZRsPWhXyMD@kreacher> <87mu5wre1v.fsf@intel.com>
In-Reply-To: <87mu5wre1v.fsf@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 25 May 2020 15:23:46 +0200
Message-ID: <CAJZ5v0hBiKdDQJjdcuV72+3jCOZPNekmGxdtod-f9Sgwc_7D+g@mail.gmail.com>
Subject: Re: [RFC/RFT][PATCH] cpufreq: intel_pstate: Work in passive mode with
 HWP enabled
To:     Francisco Jerez <francisco.jerez.plata@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Doug Smythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, May 25, 2020 at 3:39 AM Francisco Jerez
<francisco.jerez.plata@intel.com> wrote:
>
> "Rafael J. Wysocki" <rjw@rjwysocki.net> writes:
>
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Allow intel_pstate to work in the passive mode with HWP enabled and
> > make it translate the target frequency supplied by the cpufreq
> > governor in use into an EPP value to be written to the HWP request
> > MSR (high frequencies are mapped to low EPP values that mean more
> > performance-oriented HWP operation) as a hint for the HWP algorithm
> > in the processor, so as to prevent it and the CPU scheduler from
> > working against each other at least when the schedutil governor is
> > in use.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > This is a prototype not intended for production use (based on linux-next).
> >
> > Please test it if you can (on HWP systems, of course) and let me know the
> > results.
> >
> > The INTEL_CPUFREQ_TRANSITION_DELAY_HWP value has been guessed and it very well
> > may turn out to be either too high or too low for the general use, which is one
> > reason why getting as much testing coverage as possible is key here.
> >
> > If you can play with different INTEL_CPUFREQ_TRANSITION_DELAY_HWP values,
> > please do so and let me know the conclusions.
> >
> > Cheers,
> > Rafael
> >
> > ---
> >  drivers/cpufreq/intel_pstate.c |  169 +++++++++++++++++++++++++++++++----------
> >  1 file changed, 131 insertions(+), 38 deletions(-)
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
> > @@ -95,6 +96,8 @@ static inline int32_t percent_ext_fp(int
> >       return div_ext_fp(percent, 100);
> >  }
> >
> > +#define HWP_EPP_TO_BYTE(x)   (((u64)x >> 24) & 0xFF)
> > +
> >  /**
> >   * struct sample -   Store performance sample
> >   * @core_avg_perf:   Ratio of APERF/MPERF which is the actual average
> > @@ -2175,7 +2178,10 @@ static int intel_pstate_verify_policy(st
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
> > @@ -2183,12 +2189,10 @@ static void intel_pstate_stop_cpu(struct
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
> > @@ -2296,7 +2300,8 @@ static int intel_cpufreq_verify_policy(s
> >  #define      INTEL_PSTATE_TRACE_TARGET 10
> >  #define      INTEL_PSTATE_TRACE_FAST_SWITCH 90
> >
> > -static void intel_cpufreq_trace(struct cpudata *cpu, unsigned int trace_type, int old_pstate)
> > +static void intel_cpufreq_trace(struct cpudata *cpu, unsigned int trace_type,
> > +                             int from, int to)
> >  {
> >       struct sample *sample;
> >
> > @@ -2309,8 +2314,8 @@ static void intel_cpufreq_trace(struct c
> >       sample = &cpu->sample;
> >       trace_pstate_sample(trace_type,
> >               0,
> > -             old_pstate,
> > -             cpu->pstate.current_pstate,
> > +             from,
> > +             to,
> >               sample->mperf,
> >               sample->aperf,
> >               sample->tsc,
> > @@ -2318,40 +2323,110 @@ static void intel_cpufreq_trace(struct c
> >               fp_toint(cpu->iowait_boost * 100));
> >  }
> >
> > -static int intel_cpufreq_target(struct cpufreq_policy *policy,
> > -                             unsigned int target_freq,
> > -                             unsigned int relation)
> > +static void intel_cpufreq_update_hwp_request(struct cpudata *cpu, u8 new_epp)
> >  {
> > -     struct cpudata *cpu = all_cpu_data[policy->cpu];
> > -     struct cpufreq_freqs freqs;
> > -     int target_pstate, old_pstate;
> > +     u64 value, prev;
> >
> > -     update_turbo_state();
> > +     prev = READ_ONCE(cpu->hwp_req_cached);
> > +     value = prev;
> >
> > -     freqs.old = policy->cur;
> > -     freqs.new = target_freq;
> > +     /*
> > +      * The entire MSR needs to be updated in order to update the EPP field
> > +      * in it, so opportunistically update the min and max too if needed.
> > +      */
> > +     value &= ~HWP_MIN_PERF(~0L);
> > +     value |= HWP_MIN_PERF(cpu->min_perf_ratio);
> > +
> > +     value &= ~HWP_MAX_PERF(~0L);
> > +     value |= HWP_MAX_PERF(cpu->max_perf_ratio);
> > +
> > +     if (boot_cpu_has(X86_FEATURE_HWP_EPP)) {
> > +             intel_cpufreq_trace(cpu, INTEL_PSTATE_TRACE_TARGET,
> > +                                 HWP_EPP_TO_BYTE(prev), new_epp);
> > +
> > +             value &= ~GENMASK_ULL(31, 24);
> > +             value |= HWP_ENERGY_PERF_PREFERENCE(new_epp);
> > +     }
> > +
> > +     if (value != prev) {
> > +             WRITE_ONCE(cpu->hwp_req_cached, value);
> > +             wrmsrl_on_cpu(cpu->cpu, MSR_HWP_REQUEST, value);
> > +     }
> > +}
> > +
> > +/**
> > + * intel_cpufreq_adjust_hwp_request - Adjust the HWP reuqest register.
> > + * @cpu: Target CPU.
> > + * @max_freq: Maximum frequency to consider.
> > + * @target_freq: Target frequency selected by the governor.
> > + *
> > + * Translate the target frequency into a new EPP value to be written into the
> > + * HWP request MSR of @cpu as a hint for the HW-driven P-state selection.
> > + *
> > + * The purpose of this is to avoid situations in which the kernel and the HWP
> > + * algorithm work against each other by giving a hint about the expectations of
> > + * the former to the latter.
> > + *
> > + * The mapping betweeen the target frequencies and the hint values need not be
> > + * exact, but it must be monotonic, so that higher target frequencies always
> > + * indicate more performance-oriented P-state selection.
> > + */
> > +static void intel_cpufreq_adjust_hwp_request(struct cpudata *cpu, s64 max_freq,
> > +                                          unsigned int target_freq)
> > +{
> > +     s64 epp_fp = div_fp(255 * (max_freq - target_freq), max_freq);
> > +
> > +     intel_cpufreq_update_hwp_request(cpu, fp_toint(epp_fp));
> > +}
> > +
>
> Hey Rafael, I'm building a kernel with this in order to give it a try on
> my system, but I'm skeptical that translating the target frequency to an
> EPP value will work reliably.  AFAIA the EPP value only has an indirect
> influence on the processor's performance by adjusting the trade-off
> between its responsiveness (rather than the actual clock frequency which
> it will sustain in the long run) and its energy usage, in a largely
> unspecified and non-linear way (non-linear like the effect of switching
> CPU energy optimization features on and off, or like its effect on the
> energy balancing behavior of the processor which can have a paradoxical
> effect on performance).
>
> I doubt that the scheduling-based CPU utilization is a good predictor
> for the optimal trade-off between those two variables.

While I agree that this is not perfect, there barely is anything else
that can be used for this purpose.

Using the desired field or trying to adjust the limits relatively
often would basically cause the P-state selection to be driven
entirely by the kernel which simply doesn't know certain things only
known to the P-unit, so it is reasonable to leave some level of
control to the latter, so as to allow it to use the information known
to it only.

However, if it is allowed to do whatever it likes without any hints
from the kernel, it may very well go against the scheduler's decisions
which is not going to be optimal.

I'm simply not sure if there is any other way to give such hints to it
that through the EPP.

Thanks!
