Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F377D3F24DA
	for <lists+linux-pm@lfdr.de>; Fri, 20 Aug 2021 04:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237643AbhHTClE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Aug 2021 22:41:04 -0400
Received: from mga11.intel.com ([192.55.52.93]:28085 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237269AbhHTClE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 19 Aug 2021 22:41:04 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10081"; a="213577046"
X-IronPort-AV: E=Sophos;i="5.84,336,1620716400"; 
   d="scan'208";a="213577046"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2021 19:40:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,336,1620716400"; 
   d="scan'208";a="532781071"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by fmsmga002.fm.intel.com with ESMTP; 19 Aug 2021 19:40:27 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, lenb@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 1/2] thermal: intel: Allow processing of HWP interrupt
Date:   Thu, 19 Aug 2021 19:40:05 -0700
Message-Id: <20210820024006.2347720-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add a weak function to process HWP (Hardware P-states) notifications and
move updating HWP_STATUS MSR to this function.

This allows HWP interrupts to be processed by the intel_pstate driver in
HWP mode by overriding the implementation.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/thermal/intel/therm_throt.c       | 7 ++++++-
 drivers/thermal/intel/thermal_interrupt.h | 3 +++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/therm_throt.c b/drivers/thermal/intel/therm_throt.c
index 99abdc03c44c..dab7e8fb1059 100644
--- a/drivers/thermal/intel/therm_throt.c
+++ b/drivers/thermal/intel/therm_throt.c
@@ -569,13 +569,18 @@ static void notify_thresholds(__u64 msr_val)
 		platform_thermal_notify(msr_val);
 }
 
+void __weak notify_hwp_interrupt(void)
+{
+	wrmsrl_safe(MSR_HWP_STATUS, 0);
+}
+
 /* Thermal transition interrupt handler */
 void intel_thermal_interrupt(void)
 {
 	__u64 msr_val;
 
 	if (static_cpu_has(X86_FEATURE_HWP))
-		wrmsrl_safe(MSR_HWP_STATUS, 0);
+		notify_hwp_interrupt();
 
 	rdmsrl(MSR_IA32_THERM_STATUS, msr_val);
 
diff --git a/drivers/thermal/intel/thermal_interrupt.h b/drivers/thermal/intel/thermal_interrupt.h
index 53f427bb58dc..01e7bed2ffc7 100644
--- a/drivers/thermal/intel/thermal_interrupt.h
+++ b/drivers/thermal/intel/thermal_interrupt.h
@@ -12,4 +12,7 @@ extern int (*platform_thermal_notify)(__u64 msr_val);
  * callback has rate control */
 extern bool (*platform_thermal_package_rate_control)(void);
 
+/* Handle HWP interrupt */
+extern void notify_hwp_interrupt(void);
+
 #endif /* _INTEL_THERMAL_INTERRUPT_H */
-- 
2.31.1

