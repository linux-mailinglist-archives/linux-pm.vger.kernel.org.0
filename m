Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B962522F3A1
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jul 2020 17:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbgG0PRp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jul 2020 11:17:45 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:61416 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728824AbgG0PRo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jul 2020 11:17:44 -0400
Received: from 89-64-87-33.dynamic.chello.pl (89.64.87.33) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 2e44a79a69b3ba76; Mon, 27 Jul 2020 17:17:42 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Linux Documentation <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Doug Smythies <dsmythies@telus.net>,
        Francisco Jerez <francisco.jerez.plata@intel.com>
Subject: [PATCH v3 1/2] cpufreq: intel_pstate: Rearrange the storing of new EPP values
Date:   Mon, 27 Jul 2020 17:15:43 +0200
Message-ID: <1874278.Dp5iLYrgV3@kreacher>
In-Reply-To: <1709487.Bxjb1zNRZM@kreacher>
References: <4981405.3kqTVLv5tO@kreacher> <1709487.Bxjb1zNRZM@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Move the locking away from intel_pstate_set_energy_pref_index()
into its only caller and drop the (now redundant) return_pref label
from it.

Also move the "raw" EPP value check into the caller of that function,
so as to do it before acquiring the mutex, and reduce code duplication
related to the "raw" EPP values processing somewhat.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v2 -> v3:

   * Fix error handling in intel_pstate_set_energy_pref_index() and
     rebase.

---
 drivers/cpufreq/intel_pstate.c |   35 +++++++++++++++--------------------
 1 file changed, 15 insertions(+), 20 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -649,28 +649,18 @@ static int intel_pstate_set_energy_pref_
 	if (!pref_index)
 		epp = cpu_data->epp_default;
 
-	mutex_lock(&intel_pstate_limits_lock);
-
 	if (boot_cpu_has(X86_FEATURE_HWP_EPP)) {
 		u64 value;
 
 		ret = rdmsrl_on_cpu(cpu_data->cpu, MSR_HWP_REQUEST, &value);
 		if (ret)
-			goto return_pref;
+			return ret;
 
 		value &= ~GENMASK_ULL(31, 24);
 
-		if (use_raw) {
-			if (raw_epp > 255) {
-				ret = -EINVAL;
-				goto return_pref;
-			}
-			value |= (u64)raw_epp << 24;
-			ret = wrmsrl_on_cpu(cpu_data->cpu, MSR_HWP_REQUEST, value);
-			goto return_pref;
-		}
-
-		if (epp == -EINVAL)
+		if (use_raw)
+			epp = raw_epp;
+		else if (epp == -EINVAL)
 			epp = epp_values[pref_index - 1];
 
 		value |= (u64)epp << 24;
@@ -680,8 +670,6 @@ static int intel_pstate_set_energy_pref_
 			epp = (pref_index - 1) << 2;
 		ret = intel_pstate_set_epb(cpu_data->cpu, epp);
 	}
-return_pref:
-	mutex_unlock(&intel_pstate_limits_lock);
 
 	return ret;
 }
@@ -708,8 +696,8 @@ static ssize_t store_energy_performance_
 	struct cpudata *cpu_data = all_cpu_data[policy->cpu];
 	char str_preference[21];
 	bool raw = false;
+	ssize_t ret;
 	u32 epp = 0;
-	int ret;
 
 	ret = sscanf(buf, "%20s", str_preference);
 	if (ret != 1)
@@ -724,14 +712,21 @@ static ssize_t store_energy_performance_
 		if (ret)
 			return ret;
 
+		if (epp > 255)
+			return -EINVAL;
+
 		raw = true;
 	}
 
+	mutex_lock(&intel_pstate_limits_lock);
+
 	ret = intel_pstate_set_energy_pref_index(cpu_data, ret, raw, epp);
-	if (ret)
-		return ret;
+	if (!ret)
+		ret = count;
 
-	return count;
+	mutex_unlock(&intel_pstate_limits_lock);
+
+	return ret;
 }
 
 static ssize_t show_energy_performance_preference(



