Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB32F2F0D53
	for <lists+linux-pm@lfdr.de>; Mon, 11 Jan 2021 08:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbhAKHlK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Jan 2021 02:41:10 -0500
Received: from mga09.intel.com ([134.134.136.24]:37525 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727666AbhAKHlK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 11 Jan 2021 02:41:10 -0500
IronPort-SDR: ocXrBnJrTVUTVUSs2KHD9grsp29dmsH9Mk/l1MHQKkXcpENMwYcXqzVPmk76cIIrXjYYsLlR13
 V97wdSuzlA2g==
X-IronPort-AV: E=McAfee;i="6000,8403,9860"; a="177968048"
X-IronPort-AV: E=Sophos;i="5.79,337,1602572400"; 
   d="scan'208";a="177968048"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2021 23:40:29 -0800
IronPort-SDR: VlYwKUzp1mzzE3fVOmDmmJqAI1KfKXPKkEowabRmPbZ2s6pnfuw6Gyi93/YCshaIsx/bWnU74N
 M+AN7xy4vA0w==
X-IronPort-AV: E=Sophos;i="5.79,337,1602572400"; 
   d="scan'208";a="571328609"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2021 23:40:26 -0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhang Rui <rui.zhang@intel.com>,
        Wendy Wang <wendy.wang@intel.com>,
        Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 2/2][v2] cpufreq: intel_pstate: Get percpu max freq via HWP MSR register if available
Date:   Mon, 11 Jan 2021 15:43:42 +0800
Message-Id: <0ca097c7bbf58415b1df150ea50cb37579f8f8ab.1610338353.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1610338353.git.yu.c.chen@intel.com>
References: <cover.1610338353.git.yu.c.chen@intel.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently when turbo is disabled(either by BIOS or by the user), the intel_pstate
driver reads the max frequency from the package-wide MSR_PLATFORM_INFO(0xce) register.
However on asymmetric platforms it is possible in theory that small and big core with
HWP enabled might have different max cpu frequency, because the MSR_HWP_CAPABILITIES
is percpu scope according to Intel Software Developer Manual.

The turbo max freq is already percpu basis in current code, thus make similar change
to the max non-turbo frequency as well.

Reported-by: Wendy Wang <wendy.wang@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
v2: per Srinivas' suggestion, avoid duplicated assignment of max_pstate.
--
 drivers/cpufreq/intel_pstate.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index bd3dd1be73ba..f2d18991d969 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1725,11 +1725,9 @@ static void intel_pstate_max_within_limits(struct cpudata *cpu)
 static void intel_pstate_get_cpu_pstates(struct cpudata *cpu)
 {
 	cpu->pstate.min_pstate = pstate_funcs.get_min();
-	cpu->pstate.max_pstate = pstate_funcs.get_max();
 	cpu->pstate.max_pstate_physical = pstate_funcs.get_max_physical();
 	cpu->pstate.turbo_pstate = pstate_funcs.get_turbo();
 	cpu->pstate.scaling = pstate_funcs.get_scaling();
-	cpu->pstate.max_freq = cpu->pstate.max_pstate * cpu->pstate.scaling;
 
 	if (hwp_active && !hwp_mode_bdw) {
 		unsigned int phy_max, current_max, guar_state;
@@ -1737,8 +1735,12 @@ static void intel_pstate_get_cpu_pstates(struct cpudata *cpu)
 		intel_pstate_get_hwp_max(cpu, &phy_max, &current_max, &guar_state);
 		cpu->pstate.turbo_freq = phy_max * cpu->pstate.scaling;
 		cpu->pstate.turbo_pstate = phy_max;
+		cpu->pstate.max_pstate = guar_state;
+		cpu->pstate.max_freq = guar_state * cpu->pstate.scaling;
 	} else {
 		cpu->pstate.turbo_freq = cpu->pstate.turbo_pstate * cpu->pstate.scaling;
+		cpu->pstate.max_pstate = pstate_funcs.get_max();
+		cpu->pstate.max_freq = cpu->pstate.max_pstate * cpu->pstate.scaling;
 	}
 
 	if (pstate_funcs.get_aperf_mperf_shift)
-- 
2.17.1

