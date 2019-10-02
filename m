Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8598EC884A
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2019 14:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfJBMYT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Oct 2019 08:24:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:57182 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725747AbfJBMYT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 2 Oct 2019 08:24:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 45594B11B;
        Wed,  2 Oct 2019 12:24:17 +0000 (UTC)
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
Subject: [PATCH v2 0/2] Add support for frequency invariance for (some) x86
Date:   Wed,  2 Oct 2019 14:29:24 +0200
Message-Id: <20191002122926.385-1-ggherdovich@suse.cz>
X-Mailer: git-send-email 2.16.4
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

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

Giovanni Gherdovich (1):
  x86,sched: Add support for frequency invariance

Srinivas Pandruvada (1):
  cpufreq: intel_pstate: Conditional frequency invariant accounting

 arch/x86/include/asm/topology.h |  33 +++++++
 arch/x86/kernel/smpboot.c       | 195 +++++++++++++++++++++++++++++++++++++++-
 drivers/cpufreq/intel_pstate.c  |   5 ++
 kernel/sched/core.c             |   1 +
 kernel/sched/sched.h            |   7 ++
 5 files changed, 240 insertions(+), 1 deletion(-)

-- 
2.16.4

