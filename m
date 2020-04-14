Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDB91A7B85
	for <lists+linux-pm@lfdr.de>; Tue, 14 Apr 2020 14:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502435AbgDNM4j (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Apr 2020 08:56:39 -0400
Received: from mga18.intel.com ([134.134.136.126]:30327 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502379AbgDNM4h (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 14 Apr 2020 08:56:37 -0400
IronPort-SDR: RALUCLWzA513w5YLsdb+DuMoI3qmO9SBvtQ+wz21FWHI0TEjmB5d1hhQBzoGGJD30K1kL3tsX6
 Zeu0OusZ0E9g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 05:56:35 -0700
IronPort-SDR: 0t2LpaZzXlrLiysgg+XThqX3bjmDETP/jkxtCWox8fvVjUjySzFjzb/fbcs52LNgL3lyv+Fwjo
 Ppo2e/h182MA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,382,1580803200"; 
   d="scan'208";a="277244660"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by fmsmga004.fm.intel.com with ESMTP; 14 Apr 2020 05:56:34 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     linux-pm@vger.kernel.org
Cc:     Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 3/3][RFC v2] tools/power turbostat: Enable accumulate RAPL display
Date:   Tue, 14 Apr 2020 20:57:07 +0800
Message-Id: <81e85cd2b8e2d386bac71731307c0dcd4ad2871f.1586782089.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1586782089.git.yu.c.chen@intel.com>
References: <cover.1586782089.git.yu.c.chen@intel.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Enable the accumulated RAPL display by default.

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 34 +++++++++++----------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index ef380db38cba..29fc4069f467 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1169,14 +1169,7 @@ int format_counters(struct thread_data *t, struct core_data *c,
 		}
 	}
 
-	/*
-	 * If measurement interval exceeds minimum RAPL Joule Counter range,
-	 * indicate that results are suspect by printing "**" in fraction place.
-	 */
-	if (interval_float < rapl_joule_counter_range)
-		fmt8 = "%s%.2f";
-	else
-		fmt8 = "%6.0f**";
+	fmt8 = "%s%.2f";
 
 	if (DO_BIC(BIC_CorWatt) && (do_rapl & RAPL_PER_CORE_ENERGY))
 		outp += sprintf(outp, fmt8, (printed++ ? delim : ""), c->core_energy * rapl_energy_units / interval_float);
@@ -2069,34 +2062,34 @@ int get_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 		p->sys_lpi = cpuidle_cur_sys_lpi_us;
 
 	if (do_rapl & RAPL_PKG) {
-		if (get_msr(cpu, MSR_PKG_ENERGY_STATUS, &msr))
+		if (get_msr_sum(cpu, MSR_PKG_ENERGY_STATUS, &msr))
 			return -13;
-		p->energy_pkg = msr & 0xFFFFFFFF;
+		p->energy_pkg = msr;
 	}
 	if (do_rapl & RAPL_CORES_ENERGY_STATUS) {
-		if (get_msr(cpu, MSR_PP0_ENERGY_STATUS, &msr))
+		if (get_msr_sum(cpu, MSR_PP0_ENERGY_STATUS, &msr))
 			return -14;
-		p->energy_cores = msr & 0xFFFFFFFF;
+		p->energy_cores = msr;
 	}
 	if (do_rapl & RAPL_DRAM) {
-		if (get_msr(cpu, MSR_DRAM_ENERGY_STATUS, &msr))
+		if (get_msr_sum(cpu, MSR_DRAM_ENERGY_STATUS, &msr))
 			return -15;
-		p->energy_dram = msr & 0xFFFFFFFF;
+		p->energy_dram = msr;
 	}
 	if (do_rapl & RAPL_GFX) {
-		if (get_msr(cpu, MSR_PP1_ENERGY_STATUS, &msr))
+		if (get_msr_sum(cpu, MSR_PP1_ENERGY_STATUS, &msr))
 			return -16;
-		p->energy_gfx = msr & 0xFFFFFFFF;
+		p->energy_gfx = msr;
 	}
 	if (do_rapl & RAPL_PKG_PERF_STATUS) {
-		if (get_msr(cpu, MSR_PKG_PERF_STATUS, &msr))
+		if (get_msr_sum(cpu, MSR_PKG_PERF_STATUS, &msr))
 			return -16;
-		p->rapl_pkg_perf_status = msr & 0xFFFFFFFF;
+		p->rapl_pkg_perf_status = msr;
 	}
 	if (do_rapl & RAPL_DRAM_PERF_STATUS) {
-		if (get_msr(cpu, MSR_DRAM_PERF_STATUS, &msr))
+		if (get_msr_sum(cpu, MSR_DRAM_PERF_STATUS, &msr))
 			return -16;
-		p->rapl_dram_perf_status = msr & 0xFFFFFFFF;
+		p->rapl_dram_perf_status = msr;
 	}
 	if (do_rapl & RAPL_AMD_F17H) {
 		if (get_msr(cpu, MSR_PKG_ENERGY_STAT, &msr))
@@ -6073,6 +6066,7 @@ int main(int argc, char **argv)
 		return 0;
 	}
 
+	msr_sum_record();
 	/*
 	 * if any params left, it must be a command to fork
 	 */
-- 
2.20.1

