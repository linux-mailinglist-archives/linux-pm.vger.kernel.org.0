Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3F714586F
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2020 16:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgAVPKf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Jan 2020 10:10:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:39536 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbgAVPKd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 22 Jan 2020 10:10:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B490CACD9;
        Wed, 22 Jan 2020 15:10:31 +0000 (UTC)
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
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Subject: [PATCH v5 4/6] x86,sched: Add support for frequency invariance on ATOM_GOLDMONT*
Date:   Wed, 22 Jan 2020 16:16:15 +0100
Message-Id: <20200122151617.531-5-ggherdovich@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200122151617.531-1-ggherdovich@suse.cz>
References: <20200122151617.531-1-ggherdovich@suse.cz>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The scheduler needs the ratio freq_curr/freq_max for frequency-invariant
accounting. On GOLDMONT (aka Apollo Lake), GOLDMONT_D (aka Denverton) and
GOLDMONT_PLUS CPUs (aka Gemini Lake) set freq_max to the highest frequency
reported by the CPU.

The encoding of turbo ratios for GOLDMONT* is identical to the one for
SKYLAKE_X, but we treat the Atom case apart because we want to set freq_max to
a higher value, thus the ratio freq_curr/freq_max to be lower, leading to more
conservative frequency selections (favoring power efficiency).

Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
---
 arch/x86/kernel/smpboot.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 8cb3113377a9..3e32d620f1fb 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1795,6 +1795,10 @@ void native_play_dead(void)
  * which would ignore the entire turbo range (a conspicuous part, making
  * freq_curr/freq_max always maxed out).
  *
+ * An exception to the heuristic above is the Atom uarch, where we choose the
+ * highest turbo level for freq_max since Atom's are generally oriented towards
+ * power efficiency.
+ *
  * Setting freq_max to anything less than the 1C turbo ratio makes the ratio
  * freq_curr / freq_max to eventually grow >1, in which case we clip it to 1.
  */
@@ -1937,18 +1941,18 @@ static bool intel_set_max_freq_ratio(void)
 	/*
 	 * TODO: add support for:
 	 *
-	 * - Atom Goldmont
 	 * - Atom Silvermont
 	 */
 
 	u64 base_freq = 1, turbo_freq = 1;
 
-	if (x86_match_cpu(has_glm_turbo_ratio_limits))
-		return false;
-
 	if (turbo_disabled())
 		goto out;
 
+	if (x86_match_cpu(has_glm_turbo_ratio_limits) &&
+	    skx_set_max_freq_ratio(&base_freq, &turbo_freq, 1))
+		goto out;
+
 	if (knl_set_max_freq_ratio(&base_freq, &turbo_freq, 1))
 		goto out;
 
-- 
2.16.4

