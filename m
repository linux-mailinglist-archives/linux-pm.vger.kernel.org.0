Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C81A72272BF
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jul 2020 01:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgGTXU2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Jul 2020 19:20:28 -0400
Received: from mx1.riseup.net ([198.252.153.129]:56754 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726021AbgGTXU0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 20 Jul 2020 19:20:26 -0400
Received: from bell.riseup.net (bell-pn.riseup.net [10.0.1.178])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4B9d4P3wZSzFdyf;
        Mon, 20 Jul 2020 16:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1595287225; bh=sDr3kdRmMdT/WIc7Z3aT8j3JHq43FtNVOqJRvBUyxSE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=EaCkIs5IpLJzAa5H909qLXPvveFTRdEKi7vQ2K+8PiENJsWk9VOYFNWoGwl+EXw/L
         uENyDevtcpPB2x5xrrB1B/AAyuMXgauF2CeUsq3o/Lni00I/Oo3Fe+A3G/hyjDjk3r
         QOfL7lmPyYA0gWtG4R0K4Hc/SCh2wcpJGNb3i4zs=
X-Riseup-User-ID: 07A1EBB7FC8835B184CCDFC4873882C7E69A91846E7F3DC0123145C1A6DD6859
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by bell.riseup.net (Postfix) with ESMTPSA id 4B9d4N3C0XzJnYL;
        Mon, 20 Jul 2020 16:20:20 -0700 (PDT)
From:   Francisco Jerez <currojerez@riseup.net>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Doug Smythies <dsmythies@telus.net>
Subject: Re: [PATCH] cpufreq: intel_pstate: Implement passive mode with HWP enabled
In-Reply-To: <CAJZ5v0g2U+1wD5rUQwJ4_x9sQyvGyGiBiLFs7MA-xdhRBX9zBQ@mail.gmail.com>
References: <3955470.QvD6XneCf3@kreacher> <87r1tdiqpu.fsf@riseup.net> <CAJZ5v0jaRm-wv+ZKhOyGJrrKZAsTKc3sq2GYyv0uerTTe3gXbQ@mail.gmail.com> <87imeoihqs.fsf@riseup.net> <CAJZ5v0hhLWvbNA6w0yHtzKa5ANR9yF++u63dh8wWAgkhbtLXXA@mail.gmail.com> <875zanhty6.fsf@riseup.net> <CAJZ5v0g2U+1wD5rUQwJ4_x9sQyvGyGiBiLFs7MA-xdhRBX9zBQ@mail.gmail.com>
Date:   Mon, 20 Jul 2020 16:20:14 -0700
Message-ID: <87mu3thiz5.fsf@riseup.net>
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

> On Fri, Jul 17, 2020 at 2:21 AM Francisco Jerez <currojerez@riseup.net> wrote:
>>
>> "Rafael J. Wysocki" <rafael@kernel.org> writes:
>>
>> > On Wed, Jul 15, 2020 at 11:35 PM Francisco Jerez <currojerez@riseup.net> wrote:
>> >>
>> >> "Rafael J. Wysocki" <rafael@kernel.org> writes:
>> >>
>> >> > On Wed, Jul 15, 2020 at 2:09 AM Francisco Jerez <currojerez@riseup.net> wrote:
>> >> >>
>> >> >> "Rafael J. Wysocki" <rjw@rjwysocki.net> writes:
>> >> >>
>> >> >> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> >> >> >
>> >> >> > Allow intel_pstate to work in the passive mode with HWP enabled and
>> >> >> > make it set the HWP minimum performance limit (HWP floor) to the
>> >> >> > P-state value given by the target frequency supplied by the cpufreq
>> >> >> > governor, so as to prevent the HWP algorithm and the CPU scheduler
>> >> >> > from working against each other, at least when the schedutil governor
>> >> >> > is in use, and update the intel_pstate documentation accordingly.
>> >> >> >
>> >> >> > Among other things, this allows utilization clamps to be taken
>> >> >> > into account, at least to a certain extent, when intel_pstate is
>> >> >> > in use and makes it more likely that sufficient capacity for
>> >> >> > deadline tasks will be provided.
>> >> >> >
>> >> >> > After this change, the resulting behavior of an HWP system with
>> >> >> > intel_pstate in the passive mode should be close to the behavior
>> >> >> > of the analogous non-HWP system with intel_pstate in the passive
>> >> >> > mode, except that in the frequency range below the base frequency
>> >> >> > (ie. the frequency retured by the base_frequency cpufreq attribute
>> >> >> > in sysfs on HWP systems) the HWP algorithm is allowed to go above
>> >> >> > the floor P-state set by intel_pstate with or without hardware
>> >> >> > coordination of P-states among CPUs in the same package.
>> >> >> >
>> >> >> > Also note that the setting of the HWP floor may not be taken into
>> >> >> > account by the processor in the following cases:
>> >> >> >
>> >> >> >  * For the HWP floor in the range of P-states above the base
>> >> >> >    frequency, referred to as the turbo range, the processor has a
>> >> >> >    license to choose any P-state from that range, either below or
>> >> >> >    above the HWP floor, just like a non-HWP processor in the case
>> >> >> >    when the target P-state falls into the turbo range.
>> >> >> >
>> >> >> >  * If P-states of the CPUs in the same package are coordinated
>> >> >> >    at the hardware level, the processor may choose a P-state
>> >> >> >    above the HWP floor, just like a non-HWP processor in the
>> >> >> >    analogous case.
>> >> >> >
>> >> >> > With this change applied, intel_pstate in the passive mode
>> >> >> > assumes complete control over the HWP request MSR and concurrent
>> >> >> > changes of that MSR (eg. via the direct MSR access interface) are
>> >> >> > overridden by it.
>> >> >> >
>> >> >> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> >> >> > ---
>> >> >> >
>> >> >> > This basically unifies the passive mode behavior of intel_pstate for systems
>> >> >> > with and without HWP enabled.  The only case in which there is a difference
>> >> >> > between the two (after this patch) is below the turbo range, where the HWP
>> >> >> > algorithm can go above the floor regardless of whether or not P-state are
>> >> >> > coordinated package-wide (this means the systems with per-core P-states
>> >> >> > mostly is where the difference can be somewhat visible).
>> >> >> >
>> >> >> > Since the passive mode hasn't worked with HWP at all, and it is not going to
>> >> >> > the default for HWP systems anyway, I don't see any drawbacks related to making
>> >> >> > this change, so I would consider this as 5.9 material unless there are any
>> >> >> > serious objections.
>> >> >> >
>> >> >> > Thanks!
>> >> >> >
>> >> >> > ---
>> >> >> >  Documentation/admin-guide/pm/intel_pstate.rst |   89 +++++++---------
>> >> >> >  drivers/cpufreq/intel_pstate.c                |  141 ++++++++++++++++++++------
>> >> >> >  2 files changed, 152 insertions(+), 78 deletions(-)
>> >> >> >
>> >> >> > Index: linux-pm/drivers/cpufreq/intel_pstate.c
>> >> >> > ===================================================================
>> >> >> > --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
>> >> >> > +++ linux-pm/drivers/cpufreq/intel_pstate.c
>> >> >> > @@ -36,6 +36,7 @@
>> >> >> >  #define INTEL_PSTATE_SAMPLING_INTERVAL       (10 * NSEC_PER_MSEC)
>> >> >> >
>> >> >> >  #define INTEL_CPUFREQ_TRANSITION_LATENCY     20000
>> >> >> > +#define INTEL_CPUFREQ_TRANSITION_DELAY_HWP   5000
>> >> >> >  #define INTEL_CPUFREQ_TRANSITION_DELAY               500
>> >> >> >
>> >> >> >  #ifdef CONFIG_ACPI
>> >> >> > @@ -222,6 +223,7 @@ struct global_params {
>> >> >> >   *                   preference/bias
>> >> >> >   * @epp_saved:               Saved EPP/EPB during system suspend or CPU offline
>> >> >> >   *                   operation
>> >> >> > + * @epp_cached               Cached HWP energy-performance preference value
>> >> >> >   * @hwp_req_cached:  Cached value of the last HWP Request MSR
>> >> >> >   * @hwp_cap_cached:  Cached value of the last HWP Capabilities MSR
>> >> >> >   * @last_io_update:  Last time when IO wake flag was set
>> >> >> > @@ -259,6 +261,7 @@ struct cpudata {
>> >> >> >       s16 epp_policy;
>> >> >> >       s16 epp_default;
>> >> >> >       s16 epp_saved;
>> >> >> > +     s16 epp_cached;
>> >> >> >       u64 hwp_req_cached;
>> >> >> >       u64 hwp_cap_cached;
>> >> >> >       u64 last_io_update;
>> >> >> > @@ -676,6 +679,8 @@ static int intel_pstate_set_energy_pref_
>> >> >> >
>> >> >> >               value |= (u64)epp << 24;
>> >> >> >               ret = wrmsrl_on_cpu(cpu_data->cpu, MSR_HWP_REQUEST, value);
>> >> >> > +
>> >> >> > +             WRITE_ONCE(cpu_data->epp_cached, epp);
>> >> >>
>> >> >> Why introduce a new EPP cache variable if there is already
>> >> >> hwp_req_cached?  If intel_pstate_set_energy_pref_index() is failing to
>> >> >> update hwp_req_cached maybe we should fix that instead.  That will save
>> >> >> you a little bit of work in intel_cpufreq_adjust_hwp().
>> >> >
>> >> > Yes, it would, but then we'd need to explicitly synchronize
>> >> > intel_pstate_set_energy_pref_index() with the scheduler context which
>> >> > I'd rather avoid.
>> >> >
>> >>
>> >> How does using a differently named variable save you from doing that?
>> >
>> > It is a separate variable.
>> >
>> > The only updater of epp_cached, except for the initialization, is
>> > intel_pstate_set_energy_pref_index() and it cannot race with another
>> > instance of itself, so there are no concurrent writes to epp_cached.
>> >
>> > In the passive mode the only updater of hwp_req_cached, except for the
>> > initialization, is intel_cpufreq_adjust_hwp() (or there is a bug in
>> > the patch that I have missed) and it cannot race with another instance
>> > of itself for the same CPU, so there are no concurrent writes to
>> > hwp_req_cached.
>> >
>> >  if intel_pstate_set_energy_pref_index() updated hwp_req_cached
>> > directly, however, it might be updated in two places concurrently and
>> > so explicit synchronization would be necessary.
>> >
>>
>> That's fair, but we may need to add such synchronization anyway due to
>> the bug I pointed out above,
>
> I guess you've not regarded my explanation of this as sufficient.
>

No, and I just checked that the bug can be reproduced successfully on my
system with a couple of bash commands -- See below.

>> so it might be simpler to avoid introducing
>> additional state and simply stick to hwp_req_cached with proper
>> synchronization.
>
> Not really.  In the v2 of the patch the race (which was not a bug
> anyway) is explicitly avoided.
>
>> >> And won't the EPP setting programmed by intel_pstate_set_energy_pref_index()
>> >> be lost if intel_pstate_hwp_boost_up() or some other user of
>> >> hwp_req_cached is executed afterwards with the current approach?
>> >
>> > The value written to the register by it may be overwritten by a
>> > concurrent intel_cpufreq_adjust_hwp(), but that is not a problem,
>> > because next time intel_cpufreq_adjust_hwp() runs for the target CPU,
>> > it will pick up the updated epp_cached value which will be written to
>> > the register.
>>
>> However intel_cpufreq_adjust_hwp() may never be executed afterwards if
>> intel_pstate is in active mode,
>
> intel_cpufreq_adjust_hwp() is not executed in the active mode at all.
>

On that we agree, in which case...

>> in which case the overwritten value may remain there forever
>> potentially.
>
> However, in the active mode the only updater of hwp_req_cached is
> intel_pstate_hwp_set() and this patch doesn't introduce any
> differences in behavior in that case.
>

intel_pstate_hwp_set() is the only updater, but there are other
consumers that can get out of sync with the HWP request value written by
intel_pstate_set_energy_pref_index().  intel_pstate_hwp_boost_up() seems
like the most concerning example I named earlier.

>> > So there may be a short time window after the
>> > intel_pstate_set_energy_pref_index() invocation in which the new EPP
>> > value may not be in effect, but in general there is no guarantee that
>> > the new EPP will take effect immediately after updating the MSR
>> > anyway, so that race doesn't matter.
>> >
>> > That said, that race is avoidable, but I was thinking that trying to
>> > avoid it might not be worth it.  Now I see a better way to avoid it,
>> > though, so I'm going to update the patch to that end.
>> >
>> >> Seems like a bug to me.
>> >
>> > It is racy, but not every race is a bug.
>> >
>>
>> Still seems like there is a bug in intel_pstate_set_energy_pref_index()
>> AFAICT.
>
> If there is a bug, then what exactly is it, from the users' perspective?
>

It can be reproduced easily as follows:

| echo 1 > /sys/devices/system/cpu/intel_pstate/hwp_dynamic_boost
| for p in /sys/devices/system/cpu/cpufreq/policy*/energy_performance_preference; do echo performance > $p; done

Let's make sure that the EPP updates landed on the turbostat output:

|[..]
| Core    CPU     Avg_MHz Busy%   Bzy_MHz            HWP_REQ
| -       -       1       0.05    2396    0x0000000000000000
| 0       0       1       0.05    2153    0x0000000000002704
| 0       4       1       0.04    2062    0x0000000000002704
| 1       1       1       0.02    2938    0x0000000000002704
| 1       5       2       0.09    2609    0x0000000000002704
| 2       2       1       0.04    1857    0x0000000000002704
| 2       6       1       0.05    2561    0x0000000000002704
| 3       3       0       0.01    1883    0x0000000000002704
| 3       7       2       0.07    2703    0x0000000000002704
|[..]

Now let's do some non-trivial IO activity in order to trigger HWP
dynamic boost, and watch while random CPUs start losing their EPP
setting requested via sysfs:

|[..]
| Core    CPU     Avg_MHz Busy%   Bzy_MHz            HWP_REQ
| -       -       16      0.81    2023    0x0000000000000000
| 0       0       7       0.66    1069    0x0000000080002704
                                                    ^^
| 0       4       24      2.19    1116    0x0000000080002704
                                                    ^^
| 1       1       18      0.68    2618    0x0000000000002704
| 1       5       1       0.03    2005    0x0000000000002704
| 2       2       2       0.07    2512    0x0000000000002704
| 2       6       33      1.35    2402    0x0000000000002704
| 3       3       1       0.04    2470    0x0000000000002704
| 3       7       45      1.42    3185    0x0000000080002704
                                                    ^^

>> >> >> >       } else {
>> >> >> >               if (epp == -EINVAL)
>> >> >> >                       epp = (pref_index - 1) << 2;
>> >> >> > @@ -2047,6 +2052,7 @@ static int intel_pstate_init_cpu(unsigne
>> >> >> >               cpu->epp_default = -EINVAL;
>> >> >> >               cpu->epp_powersave = -EINVAL;
>> >> >> >               cpu->epp_saved = -EINVAL;
>> >> >> > +             WRITE_ONCE(cpu->epp_cached, -EINVAL);
>> >> >> >       }
>> >> >> >
>> >> >> >       cpu = all_cpu_data[cpunum];
>> >> >> > @@ -2245,7 +2251,10 @@ static int intel_pstate_verify_policy(st
>> >> >> >
>> >> >> >  static void intel_cpufreq_stop_cpu(struct cpufreq_policy *policy)
>> >> >> >  {
>> >> >> > -     intel_pstate_set_min_pstate(all_cpu_data[policy->cpu]);
>> >> >> > +     if (hwp_active)
>> >> >> > +             intel_pstate_hwp_force_min_perf(policy->cpu);
>> >> >> > +     else
>> >> >> > +             intel_pstate_set_min_pstate(all_cpu_data[policy->cpu]);
>> >> >> >  }
>> >> >> >
>> >> >> >  static void intel_pstate_stop_cpu(struct cpufreq_policy *policy)
>> >> >> > @@ -2253,12 +2262,10 @@ static void intel_pstate_stop_cpu(struct
>> >> >> >       pr_debug("CPU %d exiting\n", policy->cpu);
>> >> >> >
>> >> >> >       intel_pstate_clear_update_util_hook(policy->cpu);
>> >> >> > -     if (hwp_active) {
>> >> >> > +     if (hwp_active)
>> >> >> >               intel_pstate_hwp_save_state(policy);
>> >> >> > -             intel_pstate_hwp_force_min_perf(policy->cpu);
>> >> >> > -     } else {
>> >> >> > -             intel_cpufreq_stop_cpu(policy);
>> >> >> > -     }
>> >> >> > +
>> >> >> > +     intel_cpufreq_stop_cpu(policy);
>> >> >> >  }
>> >> >> >
>> >> >> >  static int intel_pstate_cpu_exit(struct cpufreq_policy *policy)
>> >> >> > @@ -2388,13 +2395,82 @@ static void intel_cpufreq_trace(struct c
>> >> >> >               fp_toint(cpu->iowait_boost * 100));
>> >> >> >  }
>> >> >> >
>> >> >> > +static void intel_cpufreq_adjust_hwp(struct cpudata *cpu, u32 target_pstate,
>> >> >> > +                                  bool fast_switch)
>> >> >> > +{
>> >> >> > +     u64 prev = READ_ONCE(cpu->hwp_req_cached), value = prev;
>> >> >> > +     s16 epp;
>> >> >> > +
>> >> >> > +     value &= ~HWP_MIN_PERF(~0L);
>> >> >> > +     value |= HWP_MIN_PERF(target_pstate);
>> >> >> > +
>> >> >> > +     /*
>> >> >> > +      * The entire MSR needs to be updated in order to update the HWP min
>> >> >> > +      * field in it, so opportunistically update the max too if needed.
>> >> >> > +      */
>> >> >> > +     value &= ~HWP_MAX_PERF(~0L);
>> >> >> > +     value |= HWP_MAX_PERF(cpu->max_perf_ratio);
>> >> >> > +
>> >> >> > +     /*
>> >> >> > +      * In case the EPP has been adjusted via sysfs, write the last cached
>> >> >> > +      * value of it to the MSR as well.
>> >> >> > +      */
>> >> >> > +     epp = READ_ONCE(cpu->epp_cached);
>> >> >> > +     if (epp >= 0) {
>> >> >> > +             value &= ~GENMASK_ULL(31, 24);
>> >> >> > +             value |= (u64)epp << 24;
>> >> >> > +     }
>> >> >> > +
>> >> >> > +     if (value == prev)
>> >> >> > +             return;
>> >> >> > +
>> >> >> > +     WRITE_ONCE(cpu->hwp_req_cached, value);
>> >> >> > +     if (fast_switch)
>> >> >> > +             wrmsrl(MSR_HWP_REQUEST, value);
>> >> >> > +     else
>> >> >> > +             wrmsrl_on_cpu(cpu->cpu, MSR_HWP_REQUEST, value);
>> >> >> > +}
>> >> >>
>> >> >> I've asked this question already but you may have missed it: Given that
>> >> >> you are of the opinion that [1] should be implemented in schedutil
>> >> >> instead with intel_pstate in HWP passive mode, what's your plan for
>> >> >> exposing the HWP_MAX_PERF knob to the governor in addition to
>> >> >> HWP_MIN_PERF, since the interface implemented here only allows the
>> >> >> governor to provide a single frequency?
>> >> >>
>> >> >> [1] https://lwn.net/ml/linux-pm/20200428032258.2518-1-currojerez@riseup.net/
>> >> >
>> >> > This is not just about the schedutil governor, but about cpufreq
>> >> > governors in general (someone may still want to use the performance
>> >> > governor on top of intel_pstate, for example).
>> >> >
>> >> > And while governors can only provide one frequency, the policy limits
>> >> > in the cpufreq framework are based on QoS lists now and so it is
>> >> > possible to add a max limit request, say from a driver, to the max QoS
>> >> > list, and update it as needed, causing the max policy limit to be
>> >> > adjusted.
>> >> >
>> >> > That said I'm not exactly sure how useful the max limit generally is
>> >> > in practice on HWP systems, given that setting it above the base
>> >> > frequency causes it to be ignored, effectively, and the turbo range
>> >> > may be wider than the range of P-states below the base frequency.
>> >> >
>> >>
>> >> I don't think that's accurate.  I've looked at hundreds of traces while
>> >> my series [1] was in control of HWP_REQ_MAX and I've never seen an
>> >> excursion above the maximum HWP_REQ_MAX control specified by it within a
>> >> given P-state domain, even while that maximum specified was well into
>> >> the turbo range.
>> >
>> > I'm not going to argue with your experience. :-)
>> >
>> > What I'm saying is that there is no guarantee that the processor will
>> > always select P-states below HWP_REQ_MAX in the turbo range.  That may
>> > not happen in practice, but it is not precluded AFAICS.
>> >
>> > Also while HWP_REQ_MAX can work in practice most of the time with HWP
>> > enabled, without HWP there is no easy way to limit the max frequency
>> > if the current request falls into the turbo range.  The HWP case is
>> > more important nowadays, but there still are systems without it and
>> > ideally they should be covered as well.
>> >
>>
>> In the non-HWP case we have a single P-state control so the question of
>> how to plumb an extra P-state control from the CPUFREQ governor seems
>> largely irrelevant.  The current interface seems fine as-is for such
>> systems.
>
> Which doesn't mean that the non-HWP systems aren't affected by the
> problem you want addressed, does it?
>
> And so if they are affected by it, then ideally the way it is
> addressed should also be applicable to them.
>

Yes they are affected, and I have patches for them that give
energy-efficiency improvements comparable to the HWP-specific ones, but
addressing the issue on non-HWP parts doesn't require any changes to the
CPUFREQ interface we're discussing, even if the logic is moved into a
generic governor from intel_pstate.c.

>> >> So, yeah, I agree that HWP_REQ_MAX is nothing like a
>> >> hard limit, particularly when multiple threads are running on the same
>> >> clock domain, but the processor will still make its best effort to limit
>> >> the clock frequency to the maximum of the requested maximums, even if it
>> >> happens to be within the turbo range.  That doesn't make it useless.
>> >
>> > I haven't used the word "useless" anywhere in my previous message.
>> >
>> > Using the max frequency to control power has merit, but how much of it
>> > is there depends on some factors that may change from one system to
>> > another.
>> >
>> > The alternative power control methods may be more reliable in general.
>> >
>>
>> That's precisely what I've been calling into question.  IIRC the
>> alternative power control methods we have discussed in the past are:
>>
>>  - EPP: The semantics of this control are largely unspecified beyond
>>    higher values being more energy-efficient than lower values.  The set
>>    of energy efficiency optimizations controlled by it and the
>>    thresholds at which they become active are fully platform-specific.
>>    I guess you didn't mean this one as example of a more reliable and
>>    less platform-specific control.
>>
>>  - RAPL: The semantics of this control are indeed well-defined, it's
>>    able to set an absolute average power constraint to the involved
>>    power planes.  However, the relationship between the information
>>    available to the kernel about a given workload (e.g. from CPU
>>    performance counters) and the optimal value of the RAPL constraints
>>    is highly platform-specific, requiring multiple iterations of
>>    adjustments and performance monitoring in order to approach the
>>    optimal value (unlike HWP_REQ_MAX since there is a simple,
>>    platform-independent relationship between observed frequency
>>    and... frequency -- More on that below).
>
> But the relationship between the power budget and HWP_REQ_MAX is more
> convoluted.
>

Actually the energy efficiency optimization I'm working on is fully
independent of the processor's absolute power budget.  IOW the
relationship between power budget and HWP_REQ_MAX is trivial (please
take a look at the code if you don't believe me).

>>  - P-code mailbox interface: Available to the graphics driver when GuC
>>    submission is in use, which is not available currently on any
>>    production platform.  It won't allow the energy efficiency
>>    optimization I'm proposing to be taken advantage of by discrete
>>    graphics nor IO devices other than the GPU.  Like HWP_REQ_MAX it sets
>>    a constraint on the CPU P-states so most caveats of HWP_REQ_MAX would
>>    apply to it too.  But unlike HWP_REQ_MAX it has global effect on the
>>    system limiting its usefulness in a multitasking environment.
>>    Requires a governor to run in a GPU microcontroller with more limited
>>    information than CPUFREQ.
>
> The way it works is beyond the scope of discussion here.

Oh?  If one of the proposed solutions imposes some architectural
constraints like running the controller in an environment with limited
information or forces its effect to be global across the whole system,
why shouldn't it be a matter of discussion?

> The point is that it can be used to achieve the goal at least in some
> case, which wouldn't require complexity to be added to the CPU
> performance scaling subsystem of the kernel.
>

Sure, but the complexity of interfacing with the microcontroller, shipping
and maintaining a proprietary binary dependency also needs to be considered.

> To really decide what is better, the two alternatively would need to
> be compared quatitatively, but it doesn't look like they have been.
>

That's a fair request, I'm all for justifying design decisions
quantitatively -- And in fact we did compare my non-HWP controller with
the GuC-based solution quantitatively in a BXT platform, and results
showed the kernel-based solution to be superior by a significant margin.
That was a couple of years ago though and many things have changed, we
can get you the results of the previous comparison or an updated
comparison if you don't find it appealing to look at old numbers.

>> So I'm either missing some alternative power control method or I
>> strongly disagree that there is a more reliable and platform-independent
>> alternative to HWP_REQ_MAX.
>>
>> >> The exact same thing can be said about controlling HWP_REQ_MIN as you're
>> >> doing now in this revision of your patch, BTW.
>> >
>> > Which has been clearly stated in the changelog I believe.
>> >
>>
>> Right, which is why I found it surprising to hear the same point as a
>> counterargument against HWP_REQ_MAX.
>
> The argument is against adding an extra constraint, beyond what's
> there already, that isn't guaranteed to be effective even.
>
> We kind of know that what is there already is not ideal, so adding
> more stuff that is not ideal on top of that is kind of questionable at
> least in principle.
>
>> > The point here is that this is as good as using the perf control
>> > register to ask for a given P-state without HWP which trying to drive
>> > the max too is added complexity.
>> >
>> >> If you don't believe me here is the turbostat sample with maximum
>> >> Bzy_MHz I get on the computer I'm sitting on right now while compiling a
>> >> kernel on CPU0 if I set HWP_REQ_MAX to 0x1c (within the turbo range):
>> >>
>> >> | Core    CPU     Avg_MHz Busy%   Bzy_MHz            HWP_REQ      PkgWatt CorWatt
>> >> | -       -       757     27.03   2800    0x0000000000000000      7.13    4.90
>> >> | 0       0       2794    99.77   2800    0x0000000080001c04      7.13    4.90
>> >> | 0       2       83      2.98    2800    0x0000000080001c04
>> >> | 1       1       73      2.60    2800    0x0000000080001c04
>> >> | 1       3       78      2.79    2800    0x0000000080001c04
>> >>
>> >> With the default HWP_REQUEST:
>> >>
>> >> | Core    CPU     Avg_MHz Busy%   Bzy_MHz            HWP_REQ      PkgWatt CorWatt
>> >> | -       -       814     27.00   3015    0x0000000000000000      8.49    6.18
>> >> | 0       0       2968    98.24   3021    0x0000000080001f04      8.49    6.18
>> >> | 0       2       84      2.81    2982    0x0000000080001f04
>> >> | 1       1       99      3.34    2961    0x0000000080001f04
>> >> | 1       3       105     3.60    2921    0x0000000080001f04
>> >>
>> >> > Generally, I'm not quite convinced that limiting the max frequency is
>> >> > really the right choice for controlling the processor's power draw on
>> >> > the systems in question.  There are other ways to do that, which in
>> >> > theory should be more effective.  I mentioned RAPL somewhere in this
>> >> > context and there's the GUC firmware too.
>> >>
>> >> I feel like we've had that conversation before and it's somewhat
>> >> off-topic so I'll keep it short: Yes, in theory RAPL is more effective
>> >> than HWP_REQ_MAX as a mechanism to limit the absolute power consumption
>> >> of the processor package, but that's not the purpose of [1], its purpose
>> >> is setting a lower limit to the energy efficiency of the processor when
>> >> the maximum usable CPU frequency is known (due to the existence of an IO
>> >> device bottleneck)
>> >
>> > Whether or not that frequency is actually known seems quite
>> > questionable to me, but that's aside.
>> >
>>
>> It's not actually known, but it can be approximated easily under a
>> widely-applicable assumption -- More on that below.
>>
>> > More important, it is unclear to me what you mean by "a lower limit to
>> > the energy efficiency of the processor".
>> >
>>
>> If we define the instantaneous energy efficiency of a CPU (eta) to be
>> the ratio between its instantaneous frequency (f) and power consumption
>> (P),
>
> I'm sorry, but this definition is conceptually misguided.
>
> Energy-efficiency (denote it as \phi) can be defined as work/energy which means
>
> \phi = dW / dE
>
> for the instantaneous one and in general that is not the same as the
> simple fraction below.
>

Hah!  Actually both definitions are mathematically equivalent everywhere
they're both defined.  I assume that the 'd' symbols in your expression
denote Leibniz's notation for a total derivative (if they didn't --
e.g. if they denoted some sort finite increment instead then I would
disagree that your expression is a valid definition of *instantaneous*
energy efficiency).  In addition I assume that we agree on there being
two well-defined functions of time in the case that concerns us, which
we call "instantaneous power consumption" [P(t) = dE(t)/dt] and
"instantaneous frequency" [f(t) = dW(t)/dt].  With that in mind you just
have to apply the standard chain rule from calculus in order to prove
the equivalence of both expressions:

| \phi = dW(t(E))/dE = dW(t)/dt * dt(E)/dE = dW(t)/dt * (dE(t)/dt)^-1 =
|      = f(t) * P(t)^-1 = eta

>> I want to be able to set a lower limit to that ratio in cases where
>> I can determine that doing so won't impact the performance of the
>> application:
>>
>> |  eta_min <= eta = f / P
>>
>> Setting such a lower limit to the instantaneous energy efficiency of the
>> processor can only lower the total amount of energy consumed by the
>> processor in order to perform a given amount of work (If you don't
>> believe me on that feel free to express it as the integral of P over
>> time, with P recovered from the expression above), therefore it can only
>> improve the average energy efficiency of the workload in the long run.
>>
>> Because of the convex relationship between P and f above a certain
>> inflection point (AKA maximum efficiency ratio, AKA min_pstate in
>> intel_pstate.c), eta is monotonically decreasing with respect to
>> frequency above that point, therefore setting a lower limit to the
>> energy efficiency of the processor is equivalent to setting an upper
>> limit to its frequency within that range.
>
> So under the usual assumptions, in order to increase the frequency it
> is necessary to increase power at least linearly which roughly means
> what you said above.
>
> And if increasing the frequency above a certain limit is not going to
> increase the amount of work done, which very well may be the case,
> then it makes sense to set a limit on the frequency.
>
> The entire CPU performance scaling is based on that concept and the
> trick is to determine the "useful max" frequency in question reliably
> enough.
>

Yes, seems like we are on the same page there.

>> > I guess what you mean is that the processor might decide to go for a
>> > more energy-efficient configuration by increasing its frequency in a
>> > "race to idle" fashion (in response to a perceived utilization spike)
>> > and you want to prevent that from occurring.
>> >
>>
>> No, a race to idle response to a utilization spike would only be more
>> energy efficient than the performance-equivalent constant-frequency
>> response in cases where the latter constant frequency is in the
>> concavity region of the system's power curve (below the inflection
>> point).  I certainly don't want to prevent that from occurring when it's
>> the most energy-efficient thing to do.
>>
>> > Or, generally speaking, that the CPU performance scaling logic, either
>> > in the kernel or in the processor itself, might select a higher
>> > operating frequency of a CPU in response to a perceived utilization
>> > spike, but that may be a mistake in the presence of another data
>> > processing device sharing the power budget with the processor, so you
>> > want to prevent that from taking place.
>> >
>>
>> Yes, I do.
>>
>> > In both cases, I wouldn't call that limiting the energy-efficiency of
>> > the processor.  Effectively, this means putting a limit on the
>> > processor's power budget, which is exactly what RAPL is for.
>> >
>>
>> No, limiting the processor frequency also imposes a limit to its energy
>> efficiency due to the reason explained above.
>
> I suppose that you mean the instantaneous thing which I don't think
> can really be referred to as "energy-efficiency".
>

Well I showed above that it's equivalent to your definition of energy
efficiency everywhere they're both defined.  So I meant the same thing
as you.

> Regardless, the ultimate goal appears to be to allow the non-CPU
> component you care about draw more power.
>

No, I explicitly dismissed that in my previous reply.

>> >> -- And if the maximum usable CPU frequency is the
>> >> information we have at hand,
>> >
>> > How so?
>> >
>> > How can you tell what that frequency is?
>> >
>>
>> In the general case it would take a crystal ball to know the amount of
>> work the CPU is going to have to do in the future, however as soon as
>> the system has reached a steady state (which amounts to a large fraction
>> of the time and energy consumption of many workloads, therefore it's an
>> interesting case to optimize for) its previous behavior can be taken as
>> proxy for its future behavior (by definition of steady state), therefore
>> we can measure the performance delivered by the processor in the
>> immediate past and make sure that the governor's response doesn't
>> prevent it from achieving the same performance (plus some margin in
>> order to account for potential fluctuations in the workload).
>>
>> That's, yes, an essentially heuristic assumption, but one that underlies
>> every other CPU frequency governor in the Linux kernel tree to a greater
>> or lower extent.
>
> Yes, it is, and so I don't quite see the connection between it and my question.
>
> Apparently, the unmodified performance scaling governors are not
> sufficient, so there must be something beyond the above which allows
> you to determine the frequency in question and so I'm asking what that
> is.
>

The underlying heuristic assumption is the same as I outlined above, but
in any implementation of such a heuristic there is necessarily a
trade-off between responsiveness to short-term fluctuations and
long-term energy usage.  This trade-off is a function of the somewhat
arbitrary time interval I was referring to as "immediate past" -- A
longer time parameter allows the controller to consider a greater
portion of the workload's history while computing the response with
optimal energy usage, at the cost of increasing its reaction time to
discontinuous changes in the behavior of the workload (AKA increased
latency).

One of the key differences between the governor I proposed and the
pre-existing ones is that it doesn't attempt to come up with a magic
time parameter that works for everybody, because there isn't such a
thing, since different devices and applications have latency
requirements which often differ by orders of magnitude.  Instead, a PM
QoS-based interface is introduced [2] which aggregates the latency
requirements from multiple clients, and forwards the result to the
CPUFREQ governor which dynamically adjusts its time parameter to suit
the workloads (hence the name "variably low-pass filtering").

Individual device drivers are generally in a better position to decide
what their latency requirements are than any central PM agent (including
the HWP) -- We can talk more about the algorithm used to do that as soon
as we've reached some agreement on the basics.

[2] https://lwn.net/ml/linux-pm/20200428032258.2518-2-currojerez@riseup.net/

>> >> controlling the maximum CPU frequency
>> >> directly is optimal, rather than trying to find the RAPL constraint that
>> >> achieves the same average frequency by trial an error.  Also, in theory,
>> >> even if you had an oracle to tell you what the appropriate RAPL
>> >> constraint is, the result would necessarily be more energy-inefficient
>> >> than controlling the maximum CPU frequency directly, since you're giving
>> >> the processor additional freedom to run at frequencies above the one you
>> >> want to average, which is guaranteed to be more energy-inefficient than
>> >> running at that fixed frequency, assuming we are in the region of
>> >> convexity of the processor's power curve.
>> >
>> > So the reason why you want to limit the processor's max frequency in
>> > the first place is because it is sharing the power budget with
>> > something else.
>>
>> No, my ultimate goal is to optimize the energy efficiency of the CPU in
>> cases where the system has a bottleneck elsewhere.
>
> I don't know what you mean here, sorry.
>

I'm having trouble coming up with simpler words to express the same
thing: My ultimate goal is to improve the energy efficiency of the CPU.
Improved energy balancing behavior is only a nice bonus.

>> > If there's no sharing of the power budget or thermal constraints,
>> > there is no need to limit the CPU frequency other than for the sake of
>> > saving energy.
>> >
>>
>> Yes!
>>
>> > What you can achieve by limiting the max CPU frequency is to make the
>> > processor draw less power (and cause it to use either less or more
>> > energy, depending on the energy-efficiency curve).
>>
>> Yes, in order to make sure that limiting the maximum CPU frequency
>> doesn't lead to increased energy usage the response of the governor is
>> clamped to the convexity range of the CPU power curve (which yes, I'm
>> aware is only an approximation to the convexity range of the
>> whole-system power curve).
>>
>> > You don't know how much less power it will draw then, however.
>> >
>>
>> I don't see any need to care how much less power is drawn in absolute
>> terms, as long as the energy efficiency of the system is improved *and*
>> its performance is at least the same as it was before.
>
> There is obviously a connection between power and energy and you were
> talking about steady states above.
>
> In a steady state energy is a product of power and time, approximately.
>
> Besides, I was talking on the average and that's what means for power budgets.
>

My point is that even if I knew the exact absolute power consumption of
the CPU as a function of its P-state, that wouldn't help me construct a
governor which is significantly more energy-efficient in the typical
steady-state case, since the governor's response is already optimal
energy-wise under the heuristic assumptions outlined above and in my
series.

>> > You seem to be saying "I know exactly what the maximum frequency of
>> > the CPU can be, so why I don't set it as the upper limit", but I'm
>> > questioning the source of that knowledge.  Does it not come from
>> > knowing the power budget you want to give to the processor?
>> >
>>
>> No, it comes from CPU performance counters -- More on that above.
>
> I guess you mean the paragraph regarding reaching a steady state etc.,
> but there's nothing about the CPU performance counters in there, so it
> is kind of hard for me to understand this remark.
>

It comes from monitoring the CPU performance counters in the immediate
past (the exact definition of "immediate past" being a function of the
PM QoS constraints in place) in order to compute the average amount of
work delivered by the CPU thread per unit of time, which allows us to
find the most energy-efficient P-state which won't negatively impact the
performance of the workload under the assumption of steady state.

> Overall, so far, I'm seeing a claim that the CPU subsystem can be made
> use less energy and do as much work as before (which is what improving
> the energy-efficiency means in general) if the maximum frequency of
> CPUs is limited in a clever way.
>
> I'm failing to see what that clever way is, though.

Hopefully the clarifications above help some.

--=-=-=--

--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEAREIAB0WIQST8OekYz69PM20/4aDmTidfVK/WwUCXxYmrgAKCRCDmTidfVK/
Wzv2AP9UJCiMdg7UtDd3bK0TiUrQMGOTlinuqeVtmrpCDfsz5QD/eohJoheEvDpq
utCL6xezQ9k3VSHw7AYLHqQxsMtnWj0=
=RIDt
-----END PGP SIGNATURE-----
--==-=-=--
