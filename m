Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE3C9F1EE
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2019 19:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbfH0R5V (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Aug 2019 13:57:21 -0400
Received: from mga07.intel.com ([134.134.136.100]:38492 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727683AbfH0R5V (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 27 Aug 2019 13:57:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2019 10:57:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,438,1559545200"; 
   d="scan'208";a="180296909"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by fmsmga008.fm.intel.com with ESMTP; 27 Aug 2019 10:57:20 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     lenb@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] tools/power turbostat: Fix CPU%C1 display value
Date:   Tue, 27 Aug 2019 10:57:14 -0700
Message-Id: <20190827175714.82143-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In some case C1% will be wrong value, when platform doesn't have MSR for
C1 residency.

For example:
Core    CPU     CPU%c1
-       -       100.00
0       0       100.00
0       2       100.00
1       1       100.00
1       3       100.00

But adding Busy% will fix this
Core    CPU     Busy%   CPU%c1
-       -       99.77   0.23
0       0       99.77   0.23
0       2       99.77   0.23
1       1       99.77   0.23
1       3       99.77   0.23

This issue can be reproduced on most of the recent systems including
Broadwell, Skylake and later.

This is because if we don't select Busy% or Avg_MHz or Bzy_MHz then
mperf value will not be read from MSR, so it will be 0. But this
is required for C1% calculation when MSR for C1 residency is not present.
Same is true for C3, C6 and C7 column selection.

So add another define DO_BIC_READ(), which doesn't depend on user
column selection and use for mperf, C3, C6 and C7 related counters.
So when there is no platform support for C1 residency counters,
we still read these counters, if the CPU has support and user selected
display of CPU%c1.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
Note:
This is the first public version of this patch, which is v2 of the
patch which was sent to you and Rafael only.

 tools/power/x86/turbostat/turbostat.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 75fc4fb9901c..71a4090b0024 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -506,6 +506,7 @@ unsigned long long bic_enabled = (0xFFFFFFFFFFFFFFFFULL & ~BIC_DISABLED_BY_DEFAU
 unsigned long long bic_present = BIC_USEC | BIC_TOD | BIC_sysfs | BIC_APIC | BIC_X2APIC;
 
 #define DO_BIC(COUNTER_NAME) (bic_enabled & bic_present & COUNTER_NAME)
+#define DO_BIC_READ(COUNTER_NAME) (bic_present & COUNTER_NAME)
 #define ENABLE_BIC(COUNTER_NAME) (bic_enabled |= COUNTER_NAME)
 #define BIC_PRESENT(COUNTER_BIT) (bic_present |= COUNTER_BIT)
 #define BIC_NOT_PRESENT(COUNTER_BIT) (bic_present &= ~COUNTER_BIT)
@@ -1287,6 +1288,14 @@ delta_core(struct core_data *new, struct core_data *old)
 	}
 }
 
+int soft_c1_residency_display(int bic)
+{
+	if (!DO_BIC(BIC_CPU_c1) || use_c1_residency_msr)
+		return 0;
+
+	return DO_BIC_READ(bic);
+}
+
 /*
  * old = new - old
  */
@@ -1322,7 +1331,8 @@ delta_thread(struct thread_data *new, struct thread_data *old,
 
 	old->c1 = new->c1 - old->c1;
 
-	if (DO_BIC(BIC_Avg_MHz) || DO_BIC(BIC_Busy) || DO_BIC(BIC_Bzy_MHz)) {
+	if (DO_BIC(BIC_Avg_MHz) || DO_BIC(BIC_Busy) || DO_BIC(BIC_Bzy_MHz) ||
+	    soft_c1_residency_display(BIC_Avg_MHz)) {
 		if ((new->aperf > old->aperf) && (new->mperf > old->mperf)) {
 			old->aperf = new->aperf - old->aperf;
 			old->mperf = new->mperf - old->mperf;
@@ -1774,7 +1784,8 @@ int get_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 retry:
 	t->tsc = rdtsc();	/* we are running on local CPU of interest */
 
-	if (DO_BIC(BIC_Avg_MHz) || DO_BIC(BIC_Busy) || DO_BIC(BIC_Bzy_MHz)) {
+	if (DO_BIC(BIC_Avg_MHz) || DO_BIC(BIC_Busy) || DO_BIC(BIC_Bzy_MHz) ||
+	    soft_c1_residency_display(BIC_Avg_MHz)) {
 		unsigned long long tsc_before, tsc_between, tsc_after, aperf_time, mperf_time;
 
 		/*
@@ -1851,20 +1862,20 @@ int get_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 	if (!(t->flags & CPU_IS_FIRST_THREAD_IN_CORE))
 		goto done;
 
-	if (DO_BIC(BIC_CPU_c3)) {
+	if (DO_BIC(BIC_CPU_c3) || soft_c1_residency_display(BIC_CPU_c3)) {
 		if (get_msr(cpu, MSR_CORE_C3_RESIDENCY, &c->c3))
 			return -6;
 	}
 
-	if (DO_BIC(BIC_CPU_c6) && !do_knl_cstates) {
+	if ((DO_BIC(BIC_CPU_c6) || soft_c1_residency_display(BIC_CPU_c6)) && !do_knl_cstates) {
 		if (get_msr(cpu, MSR_CORE_C6_RESIDENCY, &c->c6))
 			return -7;
-	} else if (do_knl_cstates) {
+	} else if (do_knl_cstates || soft_c1_residency_display(BIC_CPU_c6)) {
 		if (get_msr(cpu, MSR_KNL_CORE_C6_RESIDENCY, &c->c6))
 			return -7;
 	}
 
-	if (DO_BIC(BIC_CPU_c7))
+	if (DO_BIC(BIC_CPU_c7) || soft_c1_residency_display(BIC_CPU_c7))
 		if (get_msr(cpu, MSR_CORE_C7_RESIDENCY, &c->c7))
 			return -8;
 
-- 
2.17.2

