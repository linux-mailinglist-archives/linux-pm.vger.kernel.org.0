Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB5A180ACC
	for <lists+linux-pm@lfdr.de>; Tue, 10 Mar 2020 22:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbgCJVqY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Mar 2020 17:46:24 -0400
Received: from mx1.riseup.net ([198.252.153.129]:49240 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727551AbgCJVqY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 10 Mar 2020 17:46:24 -0400
Received: from bell.riseup.net (unknown [10.0.1.178])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 48cTDw0378zFf59;
        Tue, 10 Mar 2020 14:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1583876784; bh=ltwuhymiRp0VE2eGHyBbW5dhX5HoTXYQ8tBDbkFknOM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BEQDPbgw4AFgInKuxEXiyG6FyPYZvsQhtCWhvbRFbNd1QwRwlwiaAucd5RGHSlcvb
         +nwClGR6I18+Jef9P791Em/n0bngfm31Vd/R9TnNzvW8T/65UHLhtjtIAp30kxszpe
         6xw6eKaGNg5QyLmzoVaZm/E2rOBI3pWsPvGibZFg=
X-Riseup-User-ID: 27D01099CFA45474A2CF5CDB74DB5D1B94D423BF3BF6EE795CB3C483527536A2
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by bell.riseup.net (Postfix) with ESMTPSA id 48cTDv5PBzzJs07;
        Tue, 10 Mar 2020 14:46:23 -0700 (PDT)
From:   Francisco Jerez <currojerez@riseup.net>
To:     linux-pm@vger.kernel.org, intel-gfx@lists.freedesktop.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 07/10] cpufreq: intel_pstate: Implement VLP controller for HWP parts.
Date:   Tue, 10 Mar 2020 14:42:00 -0700
Message-Id: <20200310214203.26459-8-currojerez@riseup.net>
In-Reply-To: <20200310214203.26459-1-currojerez@riseup.net>
References: <20200310214203.26459-1-currojerez@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This implements a simple variably low-pass-filtering governor in
control of the HWP MIN/MAX PERF range based on the previously
introduced get_vlp_target_range().  See "cpufreq: intel_pstate:
Implement VLP controller target P-state range estimation." for the
rationale.

Signed-off-by: Francisco Jerez <currojerez@riseup.net>
---
 drivers/cpufreq/intel_pstate.c | 79 +++++++++++++++++++++++++++++++++-
 1 file changed, 77 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index cecadfec8bc1..a01eed40d897 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1905,6 +1905,20 @@ static void intel_pstate_reset_vlp(struct cpudata *cpu)
 	vlp->gain = max(1, div_fp(1000, vlp_params.setpoint_0_pml));
 	vlp->target.p_base = 0;
 	vlp->stats.last_response_frequency_hz = vlp_params.avg_hz;
+
+	if (hwp_active) {
+		const uint32_t p0 = max(cpu->pstate.min_pstate,
+					cpu->min_perf_ratio);
+		const uint32_t p1 = max_t(uint32_t, p0, cpu->max_perf_ratio);
+		const uint64_t hwp_req = (READ_ONCE(cpu->hwp_req_cached) &
+					  ~(HWP_MAX_PERF(~0L) |
+					    HWP_MIN_PERF(~0L) |
+					    HWP_DESIRED_PERF(~0L))) |
+					 HWP_MIN_PERF(p0) | HWP_MAX_PERF(p1);
+
+		wrmsrl_on_cpu(cpu->cpu, MSR_HWP_REQUEST, hwp_req);
+		cpu->hwp_req_cached = hwp_req;
+	}
 }
 
 /**
@@ -2222,6 +2236,46 @@ static void intel_pstate_adjust_pstate(struct cpudata *cpu)
 		fp_toint(cpu->iowait_boost * 100));
 }
 
+static void intel_pstate_adjust_pstate_range(struct cpudata *cpu,
+					     const unsigned int range[])
+{
+	const int from = cpu->hwp_req_cached;
+	unsigned int p0, p1, p_min, p_max;
+	struct sample *sample;
+	uint64_t hwp_req;
+
+	update_turbo_state();
+
+	p0 = max(cpu->pstate.min_pstate, cpu->min_perf_ratio);
+	p1 = max_t(unsigned int, p0, cpu->max_perf_ratio);
+	p_min = clamp_t(unsigned int, range[0], p0, p1);
+	p_max = clamp_t(unsigned int, range[1], p0, p1);
+
+	trace_cpu_frequency(p_max * cpu->pstate.scaling, cpu->cpu);
+
+	hwp_req = (READ_ONCE(cpu->hwp_req_cached) &
+		   ~(HWP_MAX_PERF(~0L) | HWP_MIN_PERF(~0L) |
+		     HWP_DESIRED_PERF(~0L))) |
+		  HWP_MIN_PERF(vlp_params.debug & 2 ? p0 : p_min) |
+		  HWP_MAX_PERF(vlp_params.debug & 4 ? p1 : p_max);
+
+	if (hwp_req != cpu->hwp_req_cached) {
+		wrmsrl(MSR_HWP_REQUEST, hwp_req);
+		cpu->hwp_req_cached = hwp_req;
+	}
+
+	sample = &cpu->sample;
+	trace_pstate_sample(mul_ext_fp(100, sample->core_avg_perf),
+			    fp_toint(sample->busy_scaled),
+			    from,
+			    hwp_req,
+			    sample->mperf,
+			    sample->aperf,
+			    sample->tsc,
+			    get_avg_frequency(cpu),
+			    fp_toint(cpu->iowait_boost * 100));
+}
+
 static void intel_pstate_update_util(struct update_util_data *data, u64 time,
 				     unsigned int flags)
 {
@@ -2260,6 +2314,22 @@ static void intel_pstate_update_util(struct update_util_data *data, u64 time,
 		intel_pstate_adjust_pstate(cpu);
 }
 
+/**
+ * Implementation of the cpufreq update_util hook based on the VLP
+ * controller (see get_vlp_target_range()).
+ */
+static void intel_pstate_update_util_hwp_vlp(struct update_util_data *data,
+					     u64 time, unsigned int flags)
+{
+	struct cpudata *cpu = container_of(data, struct cpudata, update_util);
+
+	if (update_vlp_sample(cpu, time, flags)) {
+		const struct vlp_target_range *target =
+			get_vlp_target_range(cpu);
+		intel_pstate_adjust_pstate_range(cpu, target->value);
+	}
+}
+
 static struct pstate_funcs core_funcs = {
 	.get_max = core_get_max_pstate,
 	.get_max_physical = core_get_max_pstate_physical,
@@ -2389,6 +2459,9 @@ static int intel_pstate_init_cpu(unsigned int cpunum)
 
 	intel_pstate_get_cpu_pstates(cpu);
 
+	if (pstate_funcs.update_util == intel_pstate_update_util_hwp_vlp)
+		intel_pstate_reset_vlp(cpu);
+
 	pr_debug("controlling: cpu %d\n", cpunum);
 
 	return 0;
@@ -2398,7 +2471,8 @@ static void intel_pstate_set_update_util_hook(unsigned int cpu_num)
 {
 	struct cpudata *cpu = all_cpu_data[cpu_num];
 
-	if (hwp_active && !hwp_boost)
+	if (hwp_active && !hwp_boost &&
+	    pstate_funcs.update_util != intel_pstate_update_util_hwp_vlp)
 		return;
 
 	if (cpu->update_util_set)
@@ -2526,7 +2600,8 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
 		 * was turned off, in that case we need to clear the
 		 * update util hook.
 		 */
-		if (!hwp_boost)
+		if (!hwp_boost && pstate_funcs.update_util !=
+				  intel_pstate_update_util_hwp_vlp)
 			intel_pstate_clear_update_util_hook(policy->cpu);
 		intel_pstate_hwp_set(policy->cpu);
 	}
-- 
2.22.1

