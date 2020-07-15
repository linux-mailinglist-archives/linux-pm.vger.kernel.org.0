Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 750FD221715
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 23:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgGOVft (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 17:35:49 -0400
Received: from mx1.riseup.net ([198.252.153.129]:42214 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726356AbgGOVfs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 15 Jul 2020 17:35:48 -0400
Received: from capuchin.riseup.net (capuchin-pn.riseup.net [10.0.1.176])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4B6W040Lk5zFcrC;
        Wed, 15 Jul 2020 14:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1594848948; bh=+EvFjlk56B0RX4XgfDJ2niadmImcxD+3rd4UPIiPMHk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=mpQL2av8YjEbp2d3ROfnjcU1vWvq2vjii/36RS2MgVla+0zIGhX/kf8cicpRwlYB/
         mcu48AcdDyafZos40vjnrxqOIRgkk0hppnWGRANvosH1TUsIFzoLNBH1HDJxvm9agJ
         0gY+/fUO/NixcYszfpoxvAqxcRmUBmV/95qtH+/0=
X-Riseup-User-ID: 2AEF79B635DFDAFAEDCB840878B69694017DA9C5038573DD79D8B4D507259CCD
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by capuchin.riseup.net (Postfix) with ESMTPSA id 4B6W032Tywz8sjr;
        Wed, 15 Jul 2020 14:35:47 -0700 (PDT)
From:   Francisco Jerez <currojerez@riseup.net>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Doug Smythies <dsmythies@telus.net>
Subject: Re: [PATCH] cpufreq: intel_pstate: Implement passive mode with HWP enabled
In-Reply-To: <CAJZ5v0jaRm-wv+ZKhOyGJrrKZAsTKc3sq2GYyv0uerTTe3gXbQ@mail.gmail.com>
References: <3955470.QvD6XneCf3@kreacher> <87r1tdiqpu.fsf@riseup.net> <CAJZ5v0jaRm-wv+ZKhOyGJrrKZAsTKc3sq2GYyv0uerTTe3gXbQ@mail.gmail.com>
Date:   Wed, 15 Jul 2020 14:35:39 -0700
Message-ID: <87imeoihqs.fsf@riseup.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="==-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

--==-=-=
Content-Type: multipart/mixed; boundary="=-=-="

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

"Rafael J. Wysocki" <rafael@kernel.org> writes:

> On Wed, Jul 15, 2020 at 2:09 AM Francisco Jerez <currojerez@riseup.net> wrote:
>>
>> "Rafael J. Wysocki" <rjw@rjwysocki.net> writes:
>>
>> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> >
>> > Allow intel_pstate to work in the passive mode with HWP enabled and
>> > make it set the HWP minimum performance limit (HWP floor) to the
>> > P-state value given by the target frequency supplied by the cpufreq
>> > governor, so as to prevent the HWP algorithm and the CPU scheduler
>> > from working against each other, at least when the schedutil governor
>> > is in use, and update the intel_pstate documentation accordingly.
>> >
>> > Among other things, this allows utilization clamps to be taken
>> > into account, at least to a certain extent, when intel_pstate is
>> > in use and makes it more likely that sufficient capacity for
>> > deadline tasks will be provided.
>> >
>> > After this change, the resulting behavior of an HWP system with
>> > intel_pstate in the passive mode should be close to the behavior
>> > of the analogous non-HWP system with intel_pstate in the passive
>> > mode, except that in the frequency range below the base frequency
>> > (ie. the frequency retured by the base_frequency cpufreq attribute
>> > in sysfs on HWP systems) the HWP algorithm is allowed to go above
>> > the floor P-state set by intel_pstate with or without hardware
>> > coordination of P-states among CPUs in the same package.
>> >
>> > Also note that the setting of the HWP floor may not be taken into
>> > account by the processor in the following cases:
>> >
>> >  * For the HWP floor in the range of P-states above the base
>> >    frequency, referred to as the turbo range, the processor has a
>> >    license to choose any P-state from that range, either below or
>> >    above the HWP floor, just like a non-HWP processor in the case
>> >    when the target P-state falls into the turbo range.
>> >
>> >  * If P-states of the CPUs in the same package are coordinated
>> >    at the hardware level, the processor may choose a P-state
>> >    above the HWP floor, just like a non-HWP processor in the
>> >    analogous case.
>> >
>> > With this change applied, intel_pstate in the passive mode
>> > assumes complete control over the HWP request MSR and concurrent
>> > changes of that MSR (eg. via the direct MSR access interface) are
>> > overridden by it.
>> >
>> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> > ---
>> >
>> > This basically unifies the passive mode behavior of intel_pstate for systems
>> > with and without HWP enabled.  The only case in which there is a difference
>> > between the two (after this patch) is below the turbo range, where the HWP
>> > algorithm can go above the floor regardless of whether or not P-state are
>> > coordinated package-wide (this means the systems with per-core P-states
>> > mostly is where the difference can be somewhat visible).
>> >
>> > Since the passive mode hasn't worked with HWP at all, and it is not going to
>> > the default for HWP systems anyway, I don't see any drawbacks related to making
>> > this change, so I would consider this as 5.9 material unless there are any
>> > serious objections.
>> >
>> > Thanks!
>> >
>> > ---
>> >  Documentation/admin-guide/pm/intel_pstate.rst |   89 +++++++---------
>> >  drivers/cpufreq/intel_pstate.c                |  141 ++++++++++++++++++++------
>> >  2 files changed, 152 insertions(+), 78 deletions(-)
>> >
>> > Index: linux-pm/drivers/cpufreq/intel_pstate.c
>> > ===================================================================
>> > --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
>> > +++ linux-pm/drivers/cpufreq/intel_pstate.c
>> > @@ -36,6 +36,7 @@
>> >  #define INTEL_PSTATE_SAMPLING_INTERVAL       (10 * NSEC_PER_MSEC)
>> >
>> >  #define INTEL_CPUFREQ_TRANSITION_LATENCY     20000
>> > +#define INTEL_CPUFREQ_TRANSITION_DELAY_HWP   5000
>> >  #define INTEL_CPUFREQ_TRANSITION_DELAY               500
>> >
>> >  #ifdef CONFIG_ACPI
>> > @@ -222,6 +223,7 @@ struct global_params {
>> >   *                   preference/bias
>> >   * @epp_saved:               Saved EPP/EPB during system suspend or CPU offline
>> >   *                   operation
>> > + * @epp_cached               Cached HWP energy-performance preference value
>> >   * @hwp_req_cached:  Cached value of the last HWP Request MSR
>> >   * @hwp_cap_cached:  Cached value of the last HWP Capabilities MSR
>> >   * @last_io_update:  Last time when IO wake flag was set
>> > @@ -259,6 +261,7 @@ struct cpudata {
>> >       s16 epp_policy;
>> >       s16 epp_default;
>> >       s16 epp_saved;
>> > +     s16 epp_cached;
>> >       u64 hwp_req_cached;
>> >       u64 hwp_cap_cached;
>> >       u64 last_io_update;
>> > @@ -676,6 +679,8 @@ static int intel_pstate_set_energy_pref_
>> >
>> >               value |= (u64)epp << 24;
>> >               ret = wrmsrl_on_cpu(cpu_data->cpu, MSR_HWP_REQUEST, value);
>> > +
>> > +             WRITE_ONCE(cpu_data->epp_cached, epp);
>>
>> Why introduce a new EPP cache variable if there is already
>> hwp_req_cached?  If intel_pstate_set_energy_pref_index() is failing to
>> update hwp_req_cached maybe we should fix that instead.  That will save
>> you a little bit of work in intel_cpufreq_adjust_hwp().
>
> Yes, it would, but then we'd need to explicitly synchronize
> intel_pstate_set_energy_pref_index() with the scheduler context which
> I'd rather avoid.
>

How does using a differently named variable save you from doing that?

And won't the EPP setting programmed by intel_pstate_set_energy_pref_index()
be lost if intel_pstate_hwp_boost_up() or some other user of
hwp_req_cached is executed afterwards with the current approach?  Seems
like a bug to me.

>> >       } else {
>> >               if (epp == -EINVAL)
>> >                       epp = (pref_index - 1) << 2;
>> > @@ -2047,6 +2052,7 @@ static int intel_pstate_init_cpu(unsigne
>> >               cpu->epp_default = -EINVAL;
>> >               cpu->epp_powersave = -EINVAL;
>> >               cpu->epp_saved = -EINVAL;
>> > +             WRITE_ONCE(cpu->epp_cached, -EINVAL);
>> >       }
>> >
>> >       cpu = all_cpu_data[cpunum];
>> > @@ -2245,7 +2251,10 @@ static int intel_pstate_verify_policy(st
>> >
>> >  static void intel_cpufreq_stop_cpu(struct cpufreq_policy *policy)
>> >  {
>> > -     intel_pstate_set_min_pstate(all_cpu_data[policy->cpu]);
>> > +     if (hwp_active)
>> > +             intel_pstate_hwp_force_min_perf(policy->cpu);
>> > +     else
>> > +             intel_pstate_set_min_pstate(all_cpu_data[policy->cpu]);
>> >  }
>> >
>> >  static void intel_pstate_stop_cpu(struct cpufreq_policy *policy)
>> > @@ -2253,12 +2262,10 @@ static void intel_pstate_stop_cpu(struct
>> >       pr_debug("CPU %d exiting\n", policy->cpu);
>> >
>> >       intel_pstate_clear_update_util_hook(policy->cpu);
>> > -     if (hwp_active) {
>> > +     if (hwp_active)
>> >               intel_pstate_hwp_save_state(policy);
>> > -             intel_pstate_hwp_force_min_perf(policy->cpu);
>> > -     } else {
>> > -             intel_cpufreq_stop_cpu(policy);
>> > -     }
>> > +
>> > +     intel_cpufreq_stop_cpu(policy);
>> >  }
>> >
>> >  static int intel_pstate_cpu_exit(struct cpufreq_policy *policy)
>> > @@ -2388,13 +2395,82 @@ static void intel_cpufreq_trace(struct c
>> >               fp_toint(cpu->iowait_boost * 100));
>> >  }
>> >
>> > +static void intel_cpufreq_adjust_hwp(struct cpudata *cpu, u32 target_pstate,
>> > +                                  bool fast_switch)
>> > +{
>> > +     u64 prev = READ_ONCE(cpu->hwp_req_cached), value = prev;
>> > +     s16 epp;
>> > +
>> > +     value &= ~HWP_MIN_PERF(~0L);
>> > +     value |= HWP_MIN_PERF(target_pstate);
>> > +
>> > +     /*
>> > +      * The entire MSR needs to be updated in order to update the HWP min
>> > +      * field in it, so opportunistically update the max too if needed.
>> > +      */
>> > +     value &= ~HWP_MAX_PERF(~0L);
>> > +     value |= HWP_MAX_PERF(cpu->max_perf_ratio);
>> > +
>> > +     /*
>> > +      * In case the EPP has been adjusted via sysfs, write the last cached
>> > +      * value of it to the MSR as well.
>> > +      */
>> > +     epp = READ_ONCE(cpu->epp_cached);
>> > +     if (epp >= 0) {
>> > +             value &= ~GENMASK_ULL(31, 24);
>> > +             value |= (u64)epp << 24;
>> > +     }
>> > +
>> > +     if (value == prev)
>> > +             return;
>> > +
>> > +     WRITE_ONCE(cpu->hwp_req_cached, value);
>> > +     if (fast_switch)
>> > +             wrmsrl(MSR_HWP_REQUEST, value);
>> > +     else
>> > +             wrmsrl_on_cpu(cpu->cpu, MSR_HWP_REQUEST, value);
>> > +}
>>
>> I've asked this question already but you may have missed it: Given that
>> you are of the opinion that [1] should be implemented in schedutil
>> instead with intel_pstate in HWP passive mode, what's your plan for
>> exposing the HWP_MAX_PERF knob to the governor in addition to
>> HWP_MIN_PERF, since the interface implemented here only allows the
>> governor to provide a single frequency?
>>
>> [1] https://lwn.net/ml/linux-pm/20200428032258.2518-1-currojerez@riseup.net/
>
> This is not just about the schedutil governor, but about cpufreq
> governors in general (someone may still want to use the performance
> governor on top of intel_pstate, for example).
>
> And while governors can only provide one frequency, the policy limits
> in the cpufreq framework are based on QoS lists now and so it is
> possible to add a max limit request, say from a driver, to the max QoS
> list, and update it as needed, causing the max policy limit to be
> adjusted.
>
> That said I'm not exactly sure how useful the max limit generally is
> in practice on HWP systems, given that setting it above the base
> frequency causes it to be ignored, effectively, and the turbo range
> may be wider than the range of P-states below the base frequency.
>

I don't think that's accurate.  I've looked at hundreds of traces while
my series [1] was in control of HWP_REQ_MAX and I've never seen an
excursion above the maximum HWP_REQ_MAX control specified by it within a
given P-state domain, even while that maximum specified was well into
the turbo range.  So, yeah, I agree that HWP_REQ_MAX is nothing like a
hard limit, particularly when multiple threads are running on the same
clock domain, but the processor will still make its best effort to limit
the clock frequency to the maximum of the requested maximums, even if it
happens to be within the turbo range.  That doesn't make it useless.
The exact same thing can be said about controlling HWP_REQ_MIN as you're
doing now in this revision of your patch, BTW.

If you don't believe me here is the turbostat sample with maximum
Bzy_MHz I get on the computer I'm sitting on right now while compiling a
kernel on CPU0 if I set HWP_REQ_MAX to 0x1c (within the turbo range):

| Core    CPU     Avg_MHz Busy%   Bzy_MHz            HWP_REQ      PkgWatt CorWatt
| -       -       757     27.03   2800    0x0000000000000000      7.13    4.90
| 0       0       2794    99.77   2800    0x0000000080001c04      7.13    4.90
| 0       2       83      2.98    2800    0x0000000080001c04
| 1       1       73      2.60    2800    0x0000000080001c04
| 1       3       78      2.79    2800    0x0000000080001c04

With the default HWP_REQUEST:

| Core    CPU     Avg_MHz Busy%   Bzy_MHz            HWP_REQ      PkgWatt CorWatt
| -       -       814     27.00   3015    0x0000000000000000      8.49    6.18
| 0       0       2968    98.24   3021    0x0000000080001f04      8.49    6.18
| 0       2       84      2.81    2982    0x0000000080001f04
| 1       1       99      3.34    2961    0x0000000080001f04
| 1       3       105     3.60    2921    0x0000000080001f04

> Generally, I'm not quite convinced that limiting the max frequency is
> really the right choice for controlling the processor's power draw on
> the systems in question.  There are other ways to do that, which in
> theory should be more effective.  I mentioned RAPL somewhere in this
> context and there's the GUC firmware too.

I feel like we've had that conversation before and it's somewhat
off-topic so I'll keep it short: Yes, in theory RAPL is more effective
than HWP_REQ_MAX as a mechanism to limit the absolute power consumption
of the processor package, but that's not the purpose of [1], its purpose
is setting a lower limit to the energy efficiency of the processor when
the maximum usable CPU frequency is known (due to the existence of an IO
device bottleneck) -- And if the maximum usable CPU frequency is the
information we have at hand, controlling the maximum CPU frequency
directly is optimal, rather than trying to find the RAPL constraint that
achieves the same average frequency by trial an error.  Also, in theory,
even if you had an oracle to tell you what the appropriate RAPL
constraint is, the result would necessarily be more energy-inefficient
than controlling the maximum CPU frequency directly, since you're giving
the processor additional freedom to run at frequencies above the one you
want to average, which is guaranteed to be more energy-inefficient than
running at that fixed frequency, assuming we are in the region of
convexity of the processor's power curve.

Anyway, if you still have some disagreement on the theoretical details
you're more than welcome to bring up the matter on the other thread [1],
or accept the invitation for a presentation I sent you months ago... ;)

--=-=-=--

--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEAREIAB0WIQST8OekYz69PM20/4aDmTidfVK/WwUCXw92qwAKCRCDmTidfVK/
WzqZAP4jdcVNyimkSLM6kPoFCiSgicQ1fpbaC1YpAx7btkH1jAEAhfrpAa7Wp4eH
8a7DibEoG72ORD9ijNW9YAm93npzG84=
=kYrW
-----END PGP SIGNATURE-----
--==-=-=--
