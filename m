Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1F1644518D
	for <lists+linux-pm@lfdr.de>; Thu,  4 Nov 2021 11:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbhKDKZY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Nov 2021 06:25:24 -0400
Received: from mga12.intel.com ([192.55.52.136]:1545 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230148AbhKDKZX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 4 Nov 2021 06:25:23 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10157"; a="211731014"
X-IronPort-AV: E=Sophos;i="5.87,208,1631602800"; 
   d="scan'208";a="211731014"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2021 03:22:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,208,1631602800"; 
   d="scan'208";a="600209803"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by orsmga004.jf.intel.com with ESMTP; 04 Nov 2021 03:22:44 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rafael@kernel.org, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        lenb@kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] cpufreq: intel_pstate: Clear HWP Status during HWP Interrupt enable
Date:   Thu,  4 Nov 2021 03:22:30 -0700
Message-Id: <20211104102230.123679-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

It is possible that some performance excursions happened before OS boot
or enable HWP interrupts. So clear MSR_HWP_STATUS bits when we enable
HWP interrupt. In this way a next excursion will results in a HWP
interrupt.

The status bits of MSR_HWP_STATUS must be cleared (0) by software so
that a new status condition change will cause the hardware to set the
bit again and issue the notification.

Fixes: 57577c996d73 ("cpufreq: intel_pstate: Process HWP Guaranteed change notification")
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 1e6898dc76b6..54cf21896889 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1645,6 +1645,7 @@ static void intel_pstate_enable_hwp_interrupt(struct cpudata *cpudata)
 
 		/* wrmsrl_on_cpu has to be outside spinlock as this can result in IPC */
 		wrmsrl_on_cpu(cpudata->cpu, MSR_HWP_INTERRUPT, 0x01);
+		wrmsrl_on_cpu(cpudata->cpu, MSR_HWP_STATUS, 0);
 	}
 }
 
-- 
2.31.1

