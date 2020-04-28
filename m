Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55AC61BB487
	for <lists+linux-pm@lfdr.de>; Tue, 28 Apr 2020 05:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgD1D1w (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Apr 2020 23:27:52 -0400
Received: from mx1.riseup.net ([198.252.153.129]:48912 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726312AbgD1D1v (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 27 Apr 2020 23:27:51 -0400
Received: from bell.riseup.net (unknown [10.0.1.178])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 49B6Xl3gxvzFfHC;
        Mon, 27 Apr 2020 20:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1588044471; bh=sGuXA/+5WIjTQ087osfcebpmWG4DqRI3IB3ZQpHAqWY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QqZvh+CzSLblaHHShm99+PvMpQ8+JZCqOMTUHTAgLsF7Xs9oDMgRehNSEnHOirThS
         +5osZwRoFKBtKTk0GC3RlxBwGSMshPRBkO7yr/gti+jNBsQuqHgsv9rJ51Gxd63SWz
         iEi71SnS29/2WSKgkL4IYCNf+VcgJGt6eWNbPY0c=
X-Riseup-User-ID: 114744E557F2DD3C88A19DFBDF3999A048F0F63B1DAC11BE228326A912507F03
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by bell.riseup.net (Postfix) with ESMTPSA id 49B6Xl1ms9zJqbk;
        Mon, 27 Apr 2020 20:27:51 -0700 (PDT)
From:   Francisco Jerez <currojerez@riseup.net>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Pandruvada\, Srinivas" <srinivas.pandruvada@intel.com>
Cc:     linux-pm@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        chris.p.wilson@intel.com,
        "Vivi\, Rodrigo" <rodrigo.vivi@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCHv2.99 06/11] cpufreq: intel_pstate: Call intel_pstate_set_update_util_hook() once from the setpolicy hook.
Date:   Mon, 27 Apr 2020 20:22:53 -0700
Message-Id: <20200428032258.2518-7-currojerez@riseup.net>
In-Reply-To: <20200428032258.2518-1-currojerez@riseup.net>
References: <20200428032258.2518-1-currojerez@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

And let it figure out whether an update_util hook is needed, and what
the appropriate function pointer is based on the CPUFREQ policy of the
current CPU.

Signed-off-by: Francisco Jerez <currojerez@riseup.net>
---
 drivers/cpufreq/intel_pstate.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 49401cfe9858..fd7eee57c05c 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2016,10 +2016,11 @@ static void intel_pstate_set_update_util_hook(unsigned int cpu_num)
 {
 	struct cpudata *cpu = all_cpu_data[cpu_num];
 
-	if (hwp_active && !hwp_boost)
-		return;
-
 	if (cpu->update_util_set)
+		intel_pstate_clear_update_util_hook(cpu_num);
+
+	if (cpu->policy == CPUFREQ_POLICY_PERFORMANCE ||
+	    (hwp_active && !hwp_boost))
 		return;
 
 	/* Prevent intel_pstate_update_util() from using stale data. */
@@ -2117,27 +2118,18 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
 
 	intel_pstate_update_perf_limits(cpu, policy->min, policy->max);
 
+	intel_pstate_set_update_util_hook(policy->cpu);
+
 	if (cpu->policy == CPUFREQ_POLICY_PERFORMANCE) {
 		/*
 		 * NOHZ_FULL CPUs need this as the governor callback may not
 		 * be invoked on them.
 		 */
-		intel_pstate_clear_update_util_hook(policy->cpu);
 		intel_pstate_max_within_limits(cpu);
-	} else {
-		intel_pstate_set_update_util_hook(policy->cpu);
 	}
 
-	if (hwp_active) {
-		/*
-		 * When hwp_boost was active before and dynamically it
-		 * was turned off, in that case we need to clear the
-		 * update util hook.
-		 */
-		if (!hwp_boost)
-			intel_pstate_clear_update_util_hook(policy->cpu);
+	if (hwp_active)
 		intel_pstate_hwp_set(policy->cpu);
-	}
 
 	mutex_unlock(&intel_pstate_limits_lock);
 
-- 
2.22.1

