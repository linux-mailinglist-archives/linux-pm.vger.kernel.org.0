Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A400D29726A
	for <lists+linux-pm@lfdr.de>; Fri, 23 Oct 2020 17:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S465926AbgJWPgk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Oct 2020 11:36:40 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:49018 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S462626AbgJWPgk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Oct 2020 11:36:40 -0400
Received: from 89-64-88-190.dynamic.chello.pl (89.64.88.190) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.491)
 id caedd8ec897095a1; Fri, 23 Oct 2020 17:36:38 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v2 4/4] cpufreq: schedutil: Always call drvier if need_freq_update is set
Date:   Fri, 23 Oct 2020 17:36:05 +0200
Message-ID: <1905098.zDJocX6404@kreacher>
In-Reply-To: <2183878.gTFULuzKx9@kreacher>
References: <2183878.gTFULuzKx9@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Because sugov_update_next_freq() may skip a frequency update even if
the need_freq_update flag has been set for the policy at hand, policy
limits updates may not take effect as expected.

For example, if the intel_pstate driver operates in the passive mode
with HWP enabled, it needs to update the HWP min and max limits when
the policy min and max limits change, respectively, but that may not
happen if the target frequency does not change along with the limit
at hand.  In particular, if the policy min is changed first, causing
the target frequency to be adjusted to it, and the policy max limit
is changed later to the same value, the HWP max limit will not be
updated to follow it as expected, because the target frequency is
still equal to the policy min limit and it will not change until
that limit is updated.

To address this issue, modify get_next_freq() to clear
need_freq_update only if the CPUFREQ_NEED_UPDATE_LIMITS flag is
not set for the cpufreq driver in use (and it should be set for all
potentially affected drivers) and make sugov_update_next_freq()
check need_freq_update and continue when it is set regardless of
whether or not the new target frequency is equal to the old one.

Fixes: f6ebbcf08f37 ("cpufreq: intel_pstate: Implement passive mode with HWP enabled")
Reported-by: Zhang Rui <rui.zhang@intel.com>
Cc: 5.9+ <stable@vger.kernel.org> # 5.9+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

New patch in v2.

---
 kernel/sched/cpufreq_schedutil.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

Index: linux-pm/kernel/sched/cpufreq_schedutil.c
===================================================================
--- linux-pm.orig/kernel/sched/cpufreq_schedutil.c
+++ linux-pm/kernel/sched/cpufreq_schedutil.c
@@ -102,11 +102,12 @@ static bool sugov_should_update_freq(str
 static bool sugov_update_next_freq(struct sugov_policy *sg_policy, u64 time,
 				   unsigned int next_freq)
 {
-	if (sg_policy->next_freq == next_freq)
+	if (sg_policy->next_freq == next_freq && !sg_policy->need_freq_update)
 		return false;
 
 	sg_policy->next_freq = next_freq;
 	sg_policy->last_freq_update_time = time;
+	sg_policy->need_freq_update = false;
 
 	return true;
 }
@@ -164,7 +165,10 @@ static unsigned int get_next_freq(struct
 	if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
 		return sg_policy->next_freq;
 
-	sg_policy->need_freq_update = false;
+	if (sg_policy->need_freq_update)
+		sg_policy->need_freq_update =
+			cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS);
+
 	sg_policy->cached_raw_freq = freq;
 	return cpufreq_driver_resolve_freq(policy, freq);
 }



