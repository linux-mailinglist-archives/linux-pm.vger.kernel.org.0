Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47B3CF7A5E
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2019 19:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfKKSA0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Nov 2019 13:00:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:33848 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726741AbfKKSA0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 11 Nov 2019 13:00:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 733D5AF79;
        Mon, 11 Nov 2019 18:00:24 +0000 (UTC)
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
Subject: [PATCH 4/6] x86,sched: Add support for frequency invariance on ATOM_GOLDMONT*
Date:   Mon, 11 Nov 2019 19:05:47 +0100
Message-Id: <20191111180549.12166-5-ggherdovich@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191111180549.12166-1-ggherdovich@suse.cz>
References: <20191111180549.12166-1-ggherdovich@suse.cz>
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
 arch/x86/kernel/smpboot.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 0e79dcc03ae4..4d192abf337d 100644
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
@@ -1841,6 +1845,27 @@ static const struct x86_cpu_id has_glm_turbo_ratio_limits[] = {
 	{}
 };
 
+static bool glm_set_cpu_max_freq(u64 *ratio, u64 *turbo_ratio)
+{
+	int err;
+
+	if (!x86_match_cpu(has_glm_turbo_ratio_limits))
+		return false;
+
+	err = rdmsrl_safe(MSR_PLATFORM_INFO, ratio);
+	if (err)
+		return false;
+
+	err = rdmsrl_safe(MSR_TURBO_RATIO_LIMIT, turbo_ratio);
+	if (err)
+		return false;
+
+	*ratio = (*ratio >> 8) & 0xFF;        /* max P state ratio */
+	*turbo_ratio = *turbo_ratio & 0xFF;   /* highest turbo ratio */
+
+	return true;
+}
+
 static int get_knl_turbo_ratio(u64 *turbo_ratio)
 {
 	u64 msr;
@@ -1962,7 +1987,6 @@ static void intel_set_cpu_max_freq(void)
 	/*
 	 * TODO: add support for:
 	 *
-	 * - Atom Goldmont
 	 * - Atom Silvermont
 	 *
 	 * which all now get by default arch_max_freq = SCHED_CAPACITY_SCALE
@@ -1970,10 +1994,12 @@ static void intel_set_cpu_max_freq(void)
 
 	u64 ratio = 1, turbo_ratio = 1;
 
-	if (turbo_disabled() ||
-		x86_match_cpu(has_glm_turbo_ratio_limits))
+	if (turbo_disabled())
 		return;
 
+	if (glm_set_cpu_max_freq(&ratio, &turbo_ratio))
+		goto set_value;
+
 	if (knl_set_cpu_max_freq(&ratio, &turbo_ratio))
 		goto set_value;
 
-- 
2.16.4

