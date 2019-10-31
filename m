Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4663CEB7EF
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2019 20:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729507AbfJaT0o (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 31 Oct 2019 15:26:44 -0400
Received: from mga06.intel.com ([134.134.136.31]:49730 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729347AbfJaT0o (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 31 Oct 2019 15:26:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Oct 2019 12:26:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,252,1569308400"; 
   d="scan'208";a="400610761"
Received: from spandruv-mobl3.jf.intel.com ([10.254.190.10])
  by fmsmga005.fm.intel.com with ESMTP; 31 Oct 2019 12:26:43 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, cai@lca.pw
Subject: [PATCH] cpufreq: intel_pstate: Fix Invalid EPB setting
Date:   Thu, 31 Oct 2019 12:26:20 -0700
Message-Id: <20191031192620.23482-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The max value of EPB can be only be 0x0F. Setting more than that results
in "unchecked MSR access error". During CPU offline via cpufreq stop_cpu()
callback, this error condition is triggered in the function
intel_pstate_hwp_force_min_perf().

Instead, EPB corresponding to preference to maximize energy saving (0x0F),
can be set. But this will conflict with the save/restore done in
arch/x86/kernel/cpu/intel_epb.c. Based on the test, if 0x0F is set in the
function intel_pstate_hwp_force_min_perf(), this gets restored during next
CPU online operation. This is not desired.

Hence don't set EPB in the offline path in this driver and let the
processing in intel_epb.c handle EPB.

Fixes: af3b7379e2d70 ("cpufreq: intel_pstate: Force HWP min perf before offline")
Reported-by: Qian Cai <cai@lca.pw>
Cc: 5.0+ <stable@vger.kernel.org> # 5.0+
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 53a51c169451..8ab31702cf6a 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -847,11 +847,9 @@ static void intel_pstate_hwp_force_min_perf(int cpu)
 	value |= HWP_MAX_PERF(min_perf);
 	value |= HWP_MIN_PERF(min_perf);
 
-	/* Set EPP/EPB to min */
+	/* Set EPP to min */
 	if (boot_cpu_has(X86_FEATURE_HWP_EPP))
 		value |= HWP_ENERGY_PERF_PREFERENCE(HWP_EPP_POWERSAVE);
-	else
-		intel_pstate_set_epb(cpu, HWP_EPP_BALANCE_POWERSAVE);
 
 	wrmsrl_on_cpu(cpu, MSR_HWP_REQUEST, value);
 }
-- 
2.17.2

