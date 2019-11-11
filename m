Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5B7F7A5C
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2019 19:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfKKSAY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Nov 2019 13:00:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:33684 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726741AbfKKSAY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 11 Nov 2019 13:00:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4F721B2E9;
        Mon, 11 Nov 2019 18:00:21 +0000 (UTC)
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     x86@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Paul Turner <pjt@google.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Quentin Perret <qperret@qperret.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Doug Smythies <dsmythies@telus.net>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Subject: [PATCH 0/6] Add support for frequency invariance for (some) x86
Date:   Mon, 11 Nov 2019 19:05:43 +0100
Message-Id: <20191111180549.12166-1-ggherdovich@suse.cz>
X-Mailer: git-send-email 2.16.4
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

v2 at https://lore.kernel.org/lkml/20191002122926.385-1-ggherdovich@suse.cz/

Changes wrt v2:

- Removing the tick_disable mechanism. Frequency scale-invariance isn't
  just about helping schedutil choose better frequencies, but also
  providing the scheduler load balancer with better metrics. All users of
  PELT signals benefit from this feature. The tick_disable patch disabled
  frequency invariant calculation when a specific driver is in use
  (intel_pstate in active mode).

- static_branch_enable(&arch_scale_freq_key) is now called earlier, right
  after we learn that X86_FEATURE_APERFMPERF is available. Previously Peter
  Z. commented "if we can't tell the max_freq we don't want to use the
  invariant stuff.". I've decided to do it differently: if we can't tell
  the max_freq, then it's because the CPU encodes max_freq in MSRs in a way
  this patch doesn't understand, and we assume max_p is the max_freq which
  seems like a safe bet. As a reminder, max_freq=max_p is encoded by
  setting arch_max_freq=1024 as default value. I'm open to feedback.

- Refactoring the switch case statement in set_cpu_max_freq() as Rafael
  W. Now the first patch doesn't hint at what the following patch will
  bring along.

- Handling the case were turbo is disabled at runtime and a _PPC ACPI
  notification is issued, as requested by Rafael W. This happens eg. when
  some laptop model is disconnected from AC. (Patch #6)

- Handling all Intel x86_64 micro-arches.

- A note for Srinivas P., who expressed concern for Atoms: on Atom CPUs the
  max_freq is set to the highest turbo level, as a power-efficiency
  oriented measure. In this way the ratio curr_freq/max_freq tends to be
  lower, PELT signals are consequently lower, and schedutil doesn't push
  too hard on speed. (Patches #4 and #5).

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Cover Letter from v2:

v1 at https://lore.kernel.org/lkml/20190909024216.5942-1-ggherdovich@suse.cz/

Changes wrt v1:

- add x86-specific implementation of arch_scale_freq_invariant() using a
  static key that checks for the availability of APERF and MPERF
- refer to GOLDMONT_D instead of GOLDMONT_X, according to recent rename
- set arch_cpu_freq to 1024 from x86_arch_scale_freq_tick_disable() to prevent
  PELT from being fed stale data

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Cover Letter from v1:

This is a resend with of Peter Zijlstra's patch to support frequency
scale-invariance on x86 from May 2018 [see 1]. I've added some modifications
and included performance test results. If Peter doesn't mind, I'm slapping my
name on it :)

The changes from Peter's original implementation are:

1) normalizing against the 4-cores turbo level instead or 1-core turbo
2) removing the run-time search for when the above value isn't found in the
   various Intel MSRs -- the base frequency value is taken in that case.

The section "4. KNOWN LIMITATIONS" in the first patch commit message addresses
the reason why this approach was dropped back in 2018, and explains that the
performance gains outweight that issue.

The second patch from Srinivas is taken verbatim from the May 2018 submission
as it still applies.

I apologies for the length of patch #1 commit message; I've made a table of
contents with summaries of each section that should make easier to skim
through the content.

This submission incorporates the feedback and requests for additional tests
received during the presentation made at OSPM 2019 in Pisa three months ago.

[1] https://lore.kernel.org/lkml/20180516044911.28797-2-srinivas.pandruvada@linux.intel.com/


Giovanni Gherdovich (6):
  x86,sched: Add support for frequency invariance
  x86,sched: Add support for frequency invariance on SKYLAKE_X
  x86,sched: Add support for frequency invariance on XEON_PHI_KNL/KNM
  x86,sched: Add support for frequency invariance on ATOM_GOLDMONT*
  x86,sched: Add support for frequency invariance on ATOM
  x86: intel_pstate: handle runtime turbo disablement/enablement in
    freq. invariance

 arch/x86/include/asm/topology.h |  25 ++++
 arch/x86/kernel/smpboot.c       | 324 +++++++++++++++++++++++++++++++++++++++-
 drivers/cpufreq/intel_pstate.c  |   1 +
 kernel/sched/core.c             |   1 +
 kernel/sched/sched.h            |   7 +
 5 files changed, 357 insertions(+), 1 deletion(-)

-- 
2.16.4

