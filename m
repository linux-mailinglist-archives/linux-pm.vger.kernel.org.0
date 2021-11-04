Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74D9A444E26
	for <lists+linux-pm@lfdr.de>; Thu,  4 Nov 2021 06:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbhKDFWH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Nov 2021 01:22:07 -0400
Received: from mga04.intel.com ([192.55.52.120]:23484 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230011AbhKDFWH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 4 Nov 2021 01:22:07 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10157"; a="230367859"
X-IronPort-AV: E=Sophos;i="5.87,207,1631602800"; 
   d="scan'208";a="230367859"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2021 22:19:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,207,1631602800"; 
   d="scan'208";a="497845484"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by fmsmga007.fm.intel.com with ESMTP; 03 Nov 2021 22:19:27 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rafael@kernel.org, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, torvalds@linux-foundation.org,
        lenb@kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] cpufreq: intel_pstate: Fix unchecked MSR 0x773 access
Date:   Wed,  3 Nov 2021 22:19:25 -0700
Message-Id: <20211104051925.119941-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

It is possible that on some platforms HWP interrupts are disabled. In
that case accessing MSR 0x773 will result in warning.

So check X86_FEATURE_HWP_NOTIFY feature to access MSR 0x773. The other
places in code where this MSR is accessed, already checks this feature
except during disable path called during cpufreq offline and suspend
callbacks.

Fixes: 57577c996d73 ("cpufreq: intel_pstate: Process HWP Guaranteed change notification")
Reported-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 349ddbaef796..1e6898dc76b6 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1620,6 +1620,9 @@ static void intel_pstate_disable_hwp_interrupt(struct cpudata *cpudata)
 {
 	unsigned long flags;
 
+	if (!boot_cpu_has(X86_FEATURE_HWP_NOTIFY))
+		return;
+
 	/* wrmsrl_on_cpu has to be outside spinlock as this can result in IPC */
 	wrmsrl_on_cpu(cpudata->cpu, MSR_HWP_INTERRUPT, 0x00);
 
-- 
2.31.1

