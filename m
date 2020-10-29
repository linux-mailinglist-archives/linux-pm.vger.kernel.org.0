Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28F1629EA37
	for <lists+linux-pm@lfdr.de>; Thu, 29 Oct 2020 12:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725805AbgJ2LMt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Oct 2020 07:12:49 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:41710 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbgJ2LMt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Oct 2020 07:12:49 -0400
Received: from 89-64-89-121.dynamic.chello.pl (89.64.89.121) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.491)
 id 1a55d32a351296d0; Thu, 29 Oct 2020 12:12:47 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v2.2 4/4] cpufreq: schedutil: Always call driver if CPUFREQ_NEED_UPDATE_LIMITS is set
Date:   Thu, 29 Oct 2020 12:12:46 +0100
Message-ID: <4720046.CcxZZ2xs9j@kreacher>
In-Reply-To: <1905098.zDJocX6404@kreacher>
References: <2183878.gTFULuzKx9@kreacher> <1905098.zDJocX6404@kreacher>
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

To address this issue, modify get_next_freq() to let the driver
callback run if the CPUFREQ_NEED_UPDATE_LIMITS cpufreq driver flag
is set regardless of whether or not the new frequency to set is
equal to the previous one.

Fixes: f6ebbcf08f37 ("cpufreq: intel_pstate: Implement passive mode with HWP enabled")
Reported-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Cc: 5.9+ <stable@vger.kernel.org> # 5.9+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v2.1 -> v2.2:
   * Instead of updating need_freq_update if CPUFREQ_NEED_UPDATE_LIMITS is set
     in get_next_freq() and checking it again in sugov_update_next_freq(),
     check CPUFREQ_NEED_UPDATE_LIMITS directly in sugov_update_next_freq().
   * Update the subject.

v2 -> v2.1:
   * Fix typo in the subject.
   * Make get_next_freq() and sugov_update_next_freq() ignore the
     sg_policy->next_freq == next_freq case when CPUFREQ_NEED_UPDATE_LIMITS
     is set for the driver.
   * Add Tested-by from Rui (this version lets the driver callback run more
     often than the v2, so the behavior in the Rui's case doesn't change).

---
 kernel/sched/cpufreq_schedutil.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

Index: linux-pm/kernel/sched/cpufreq_schedutil.c
===================================================================
--- linux-pm.orig/kernel/sched/cpufreq_schedutil.c
+++ linux-pm/kernel/sched/cpufreq_schedutil.c
@@ -102,7 +102,8 @@ static bool sugov_should_update_freq(str
 static bool sugov_update_next_freq(struct sugov_policy *sg_policy, u64 time,
 				   unsigned int next_freq)
 {
-	if (sg_policy->next_freq == next_freq)
+	if (sg_policy->next_freq == next_freq &&
+	    !cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS))
 		return false;
 
 	sg_policy->next_freq = next_freq;
@@ -161,7 +162,8 @@ static unsigned int get_next_freq(struct
 
 	freq = map_util_freq(util, freq, max);
 
-	if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
+	if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update &&
+	    !cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS))
 		return sg_policy->next_freq;
 
 	sg_policy->need_freq_update = false;




