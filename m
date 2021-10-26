Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6C5043ADDC
	for <lists+linux-pm@lfdr.de>; Tue, 26 Oct 2021 10:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbhJZITo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Oct 2021 04:19:44 -0400
Received: from mga07.intel.com ([134.134.136.100]:33243 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233583AbhJZITo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 26 Oct 2021 04:19:44 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10148"; a="293312374"
X-IronPort-AV: E=Sophos;i="5.87,182,1631602800"; 
   d="scan'208";a="293312374"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 01:17:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,182,1631602800"; 
   d="scan'208";a="497194750"
Received: from power-sh.sh.intel.com ([10.239.183.1])
  by orsmga008.jf.intel.com with ESMTP; 26 Oct 2021 01:17:18 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-pm@vger.kernel.org
Cc:     rjw@rjwysocki.net, srinivas.pandruvada@linux.intel.com,
        rui.zhang@intel.com
Subject: [PATCH] cpufreq: intel_pstate: Fix cpu->pstate.turbo_freq initialization
Date:   Tue, 26 Oct 2021 16:32:42 +0800
Message-Id: <20211026083242.27472-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix a problem in active mode that cpu->pstate.turbo_freq is initialized
only if HWP-to-frequency scaling factor is refined.

In passive mode, this problem is not exposed, because
cpu->pstate.turbo_freq is set again, later in
intel_cpufreq_cpu_init()->intel_pstate_get_hwp_cap().

Fixes: eb3693f0521e ("cpufreq: intel_pstate: hybrid: CPU-specific scaling factor")
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/cpufreq/intel_pstate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 8c176b7dae41..fc7a429f22d3 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -537,7 +537,8 @@ static void intel_pstate_hybrid_hwp_adjust(struct cpudata *cpu)
 	 * scaling factor is too high, so recompute it to make the HWP_CAP
 	 * highest performance correspond to the maximum turbo frequency.
 	 */
-	if (turbo_freq < cpu->pstate.turbo_pstate * scaling) {
+	cpu->pstate.turbo_freq = cpu->pstate.turbo_pstate * scaling;
+	if (turbo_freq < cpu->pstate.turbo_freq) {
 		cpu->pstate.turbo_freq = turbo_freq;
 		scaling = DIV_ROUND_UP(turbo_freq, cpu->pstate.turbo_pstate);
 		cpu->pstate.scaling = scaling;
-- 
2.17.1

