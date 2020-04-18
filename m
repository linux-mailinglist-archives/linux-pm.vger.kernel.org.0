Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 937101AEAED
	for <lists+linux-pm@lfdr.de>; Sat, 18 Apr 2020 10:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgDRIbk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 18 Apr 2020 04:31:40 -0400
Received: from mga07.intel.com ([134.134.136.100]:56271 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbgDRIbj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 18 Apr 2020 04:31:39 -0400
IronPort-SDR: OL7yKVU8kd3J/jLxVuwJd35EN3BOlIJj4FB6Q20Bv4JmFJ5iqcQz2dg7kkCzrFkwhX7BVXEYOj
 VshssAFYXOAA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2020 01:31:38 -0700
IronPort-SDR: bfSFfTVDcKltw7Q5JBo71kyfC8v8UwfHz80cbBkrqBkDEvki7/lPCjLE2GcP5cCyOmR2cBNoez
 dQ2SKO2rxPkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,398,1580803200"; 
   d="scan'208";a="254442291"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by orsmga003.jf.intel.com with ESMTP; 18 Apr 2020 01:31:36 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     linux-pm@vger.kernel.org
Cc:     Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Doug Smythies <dsmythies@telus.net>,
        linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 3/3][v3] tools/power turbostat: Enable accumulate RAPL display
Date:   Sat, 18 Apr 2020 16:32:05 +0800
Message-Id: <1f6d32e14f121a8ccf8807b8343597c3ae88c7d2.1587196252.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1587196252.git.yu.c.chen@intel.com>
References: <cover.1587196252.git.yu.c.chen@intel.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Enable the accumulated RAPL display by default.

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 38 +++++++++++----------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 44fd3822a5fa..cc1661e753d2 100644
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
@@ -2069,39 +2062,39 @@ int get_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
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
-		if (get_msr(cpu, MSR_PKG_ENERGY_STAT, &msr))
+		if (get_msr_sum(cpu, MSR_PKG_ENERGY_STAT, &msr))
 			return -13;
-		p->energy_pkg = msr & 0xFFFFFFFF;
+		p->energy_pkg = msr;
 	}
 	if (DO_BIC(BIC_PkgTmp)) {
 		if (get_msr(cpu, MSR_IA32_PACKAGE_THERM_STATUS, &msr))
@@ -6076,6 +6069,7 @@ int main(int argc, char **argv)
 		return 0;
 	}
 
+	msr_sum_record();
 	/*
 	 * if any params left, it must be a command to fork
 	 */
-- 
2.17.1

