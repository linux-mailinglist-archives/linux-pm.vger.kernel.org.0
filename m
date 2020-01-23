Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0688D146CDB
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2020 16:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbgAWPat (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Jan 2020 10:30:49 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39440 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbgAWPas (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jan 2020 10:30:48 -0500
Received: by mail-ot1-f65.google.com with SMTP id 77so3095969oty.6;
        Thu, 23 Jan 2020 07:30:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dJBGS4e0jWaAWLLcuuHxgK6M1UmjccQT8Vf0obsUZeE=;
        b=Y9yFrQ9PyknN7p4NsknuKCrrfpYSDR+Zh0lFxOVz2yG7Om5A0Kj/VWxWzH6jQxO9oG
         UsCpKRTzBmzz/CPGVStPWJDnVYsEhleBaKSqzM4egLuFnX1alArFvhDLE8e0zKlvcQHV
         g4dYV31ZIeIn2qKQae3HJKqiA0ovAWmILIGlZyv2E0PIInZ3ixwXyD14oVFT7kAvnVIZ
         DdcEICmv+GWfXyku8BrnAvsoJytM+eF4CyD5IwgUGykeFHpX/FemNZM/rW5rss+D0kTL
         0BBqNrmpuZIc3zKDL2c1NEcUao/kEoPaFaH9YCMEkqYW4w4qyQyxrbgjkv2MhzeQEScq
         hmCA==
X-Gm-Message-State: APjAAAUCDdG4VFagodb9UERtUkoY4B2jKrR8InBnnRN3AMAbpCgMzjkj
        lyMdQDAyFfWGhjMn+XRFLC48a+kS3bLcIBFHK0c=
X-Google-Smtp-Source: APXvYqw6IP+WgUGRKWpK62i5avBtF0C6itxi/KoBk1PUkIzbGmaBwLHz4G94k4M9YBc6eq2FJByHi9fUpk84qYEfUy8=
X-Received: by 2002:a05:6830:1e67:: with SMTP id m7mr11717398otr.262.1579793447589;
 Thu, 23 Jan 2020 07:30:47 -0800 (PST)
MIME-Version: 1.0
References: <20200122151617.531-1-ggherdovich@suse.cz>
In-Reply-To: <20200122151617.531-1-ggherdovich@suse.cz>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 23 Jan 2020 16:30:36 +0100
Message-ID: <CAJZ5v0gO18Oz4qvf3L9LfAX+1ww2XTeP_o_3WixYixB9d=s8Wg@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] Add support for frequency invariance for (some) x86
To:     Giovanni Gherdovich <ggherdovich@suse.cz>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Paul Turner <pjt@google.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Quentin Perret <qperret@qperret.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Doug Smythies <dsmythies@telus.net>,
        Ionela Voinescu <ionela.voinescu@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jan 22, 2020 at 4:10 PM Giovanni Gherdovich <ggherdovich@suse.cz> wrote:
>
> v4 at https://lore.kernel.org/lkml/20191113124654.18122-1-ggherdovich@suse.cz/
>
> Changes wrt v4:
>
> - Removing conditional access in the function arch_scale_freq_capacity()
>   and initialize arch_freq_scale to 1024 to account for when freq
>   invariance isn't enabled (Ionela V.)
> - In case the max frequency can't be read in MSRs, do not enable frequency
>   invariance at all (Ionela V., Peter Z.).
> - Renames:
>     variables:
>       arch_cpu_freq  -> arch_freq_scale
>       arch_max_freq  -> arch_max_freq_ratio
>       ... and others
>     functions:
>       init_scale_freq  -> init_counter_refs
>       set_cpu_max_freq -> init_freq_invariance
>       {core,skx,knl...}_set_cpu_max_freq  -> {core,skx,knl...}_set_max_freq_ratio
>       ... and others
> - Use the same function for parsing SKX and GLM registers (Peter Z.)
> - Pass a parameter to the function parsing KNL registers (Peter Z.)
> - Fix a bug whereby refs to [am]perf were initialized only on cpu #0
>
> - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
> Cover Letter from v4:
>
> v3 at https://lore.kernel.org/lkml/20191111180549.12166-1-ggherdovich@suse.cz/
>
> Changes wrt v3:
>
> - Add definition of function set_arch_max_freq if !CONFIG_SMP
>
> - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
> Cover Letter from v3:
>
> v2 at https://lore.kernel.org/lkml/20191002122926.385-1-ggherdovich@suse.cz/
>
> Changes wrt v2:
>
> - Removing the tick_disable mechanism. Frequency scale-invariance isn't
>   just about helping schedutil choose better frequencies, but also
>   providing the scheduler load balancer with better metrics. All users of
>   PELT signals benefit from this feature. The tick_disable patch disabled
>   frequency invariant calculation when a specific driver is in use
>   (intel_pstate in active mode).
>
> - static_branch_enable(&arch_scale_freq_key) is now called earlier, right
>   after we learn that X86_FEATURE_APERFMPERF is available. Previously Peter
>   Z. commented "if we can't tell the max_freq we don't want to use the
>   invariant stuff.". I've decided to do it differently: if we can't tell
>   the max_freq, then it's because the CPU encodes max_freq in MSRs in a way
>   this patch doesn't understand, and we assume max_p is the max_freq which
>   seems like a safe bet. As a reminder, max_freq=max_p is encoded by
>   setting arch_max_freq=1024 as default value. I'm open to feedback.
>
> - Refactoring the switch case statement in set_cpu_max_freq() as Rafael
>   W. Now the first patch doesn't hint at what the following patch will
>   bring along.
>
> - Handling the case were turbo is disabled at runtime and a _PPC ACPI
>   notification is issued, as requested by Rafael W. This happens eg. when
>   some laptop model is disconnected from AC. (Patch #6)
>
> - Handling all Intel x86_64 micro-arches.
>
> - A note for Srinivas P., who expressed concern for Atoms: on Atom CPUs the
>   max_freq is set to the highest turbo level, as a power-efficiency
>   oriented measure. In this way the ratio curr_freq/max_freq tends to be
>   lower, PELT signals are consequently lower, and schedutil doesn't push
>   too hard on speed. (Patches #4 and #5).
>
> - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
> Cover Letter from v2:
>
> v1 at https://lore.kernel.org/lkml/20190909024216.5942-1-ggherdovich@suse.cz/
>
> Changes wrt v1:
>
> - add x86-specific implementation of arch_scale_freq_invariant() using a
>   static key that checks for the availability of APERF and MPERF
> - refer to GOLDMONT_D instead of GOLDMONT_X, according to recent rename
> - set arch_cpu_freq to 1024 from x86_arch_scale_freq_tick_disable() to prevent
>   PELT from being fed stale data
>
> - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
> Cover Letter from v1:
>
> This is a resend with of Peter Zijlstra's patch to support frequency
> scale-invariance on x86 from May 2018 [see 1]. I've added some modifications
> and included performance test results. If Peter doesn't mind, I'm slapping my
> name on it :)
>
> The changes from Peter's original implementation are:
>
> 1) normalizing against the 4-cores turbo level instead or 1-core turbo
> 2) removing the run-time search for when the above value isn't found in the
>    various Intel MSRs -- the base frequency value is taken in that case.
>
> The section "4. KNOWN LIMITATIONS" in the first patch commit message addresses
> the reason why this approach was dropped back in 2018, and explains that the
> performance gains outweight that issue.
>
> The second patch from Srinivas is taken verbatim from the May 2018 submission
> as it still applies.
>
> I apologies for the length of patch #1 commit message; I've made a table of
> contents with summaries of each section that should make easier to skim
> through the content.
>
> This submission incorporates the feedback and requests for additional tests
> received during the presentation made at OSPM 2019 in Pisa three months ago.
>
> [1] https://lore.kernel.org/lkml/20180516044911.28797-2-srinivas.pandruvada@linux.intel.com/
>
> Giovanni Gherdovich (6):
>   x86,sched: Add support for frequency invariance
>   x86,sched: Add support for frequency invariance on SKYLAKE_X
>   x86,sched: Add support for frequency invariance on XEON_PHI_KNL/KNM
>   x86,sched: Add support for frequency invariance on ATOM_GOLDMONT*
>   x86,sched: Add support for frequency invariance on ATOM
>   x86: intel_pstate: handle runtime turbo disablement/enablement in
>     freq. invariance
>
>  arch/x86/include/asm/topology.h |  25 ++++
>  arch/x86/kernel/smpboot.c       | 290 +++++++++++++++++++++++++++++++++++++++-
>  drivers/cpufreq/intel_pstate.c  |   1 +
>  kernel/sched/core.c             |   1 +
>  kernel/sched/sched.h            |   7 +
>  5 files changed, 323 insertions(+), 1 deletion(-)
>

All looks good to me, so

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

for the whole series (and I'm assuming that it will go it through the tip tree).

Thanks!
