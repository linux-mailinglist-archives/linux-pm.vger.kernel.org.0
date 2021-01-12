Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94A072F27A1
	for <lists+linux-pm@lfdr.de>; Tue, 12 Jan 2021 06:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388099AbhALFTV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Jan 2021 00:19:21 -0500
Received: from mga18.intel.com ([134.134.136.126]:57059 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388021AbhALFTV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 12 Jan 2021 00:19:21 -0500
IronPort-SDR: ecsMgOW9diD2knyCkidLv5DdvRc+8MF6DE0JYakXJWlcEJbGbtw58pEcBvXK0SmQ1hdW9HAIXB
 ty6Yxn8PaCkQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9861"; a="165665016"
X-IronPort-AV: E=Sophos;i="5.79,340,1602572400"; 
   d="scan'208";a="165665016"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 21:18:40 -0800
IronPort-SDR: N57qnaswHAjoBWYTtAsg/j9ePny0owRBy9M+qDgKajr4QodcEZK5rzWQjlDqw75XPtKFbbHJvT
 nJUscfW9CGVQ==
X-IronPort-AV: E=Sophos;i="5.79,340,1602572400"; 
   d="scan'208";a="381285562"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 21:18:38 -0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH][v3] cpufreq: intel_pstate: Get percpu max freq via HWP MSR register if available
Date:   Tue, 12 Jan 2021 13:21:27 +0800
Message-Id: <20210112052127.4557-1-yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently when turbo is disabled(either by BIOS or by the user), the
intel_pstate driver reads the max non-turbo frequency from the package-wide
MSR_PLATFORM_INFO(0xce) register. However on asymmetric platforms it is
possible in theory that small and big core with HWP enabled might have
different max non-turbo cpu frequency, because the MSR_HWP_CAPABILITIES
is percpu scope according to Intel Software Developer Manual.

The turbo max freq is already percpu basis in current code, thus make
similar change to the max non-turbo frequency as well.

Reported-by: Wendy Wang <wendy.wang@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
v2: Per Srinivas' suggestion, avoid duplicated assignment of max_pstate.
v3: Per Rafael's suggestion, do not add new argument in intel_pstate_get_hwp_max()
    to avoid redundant local vars.
    Per Srinivas' suggestion, refined the commit log to reflect the 'non-turbo'
    max frequency.
--
 drivers/cpufreq/intel_pstate.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index eaf32ef7a030..99e180f644c3 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1724,11 +1724,9 @@ static void intel_pstate_max_within_limits(struct cpudata *cpu)
 static void intel_pstate_get_cpu_pstates(struct cpudata *cpu)
 {
 	cpu->pstate.min_pstate = pstate_funcs.get_min();
-	cpu->pstate.max_pstate = pstate_funcs.get_max();
 	cpu->pstate.max_pstate_physical = pstate_funcs.get_max_physical();
 	cpu->pstate.turbo_pstate = pstate_funcs.get_turbo();
 	cpu->pstate.scaling = pstate_funcs.get_scaling();
-	cpu->pstate.max_freq = cpu->pstate.max_pstate * cpu->pstate.scaling;
 
 	if (hwp_active && !hwp_mode_bdw) {
 		unsigned int phy_max, current_max;
@@ -1736,9 +1734,12 @@ static void intel_pstate_get_cpu_pstates(struct cpudata *cpu)
 		intel_pstate_get_hwp_max(cpu, &phy_max, &current_max);
 		cpu->pstate.turbo_freq = phy_max * cpu->pstate.scaling;
 		cpu->pstate.turbo_pstate = phy_max;
+		cpu->pstate.max_pstate = HWP_GUARANTEED_PERF(READ_ONCE(cpu->hwp_cap_cached));
 	} else {
 		cpu->pstate.turbo_freq = cpu->pstate.turbo_pstate * cpu->pstate.scaling;
+		cpu->pstate.max_pstate = pstate_funcs.get_max();
 	}
+	cpu->pstate.max_freq = cpu->pstate.max_pstate * cpu->pstate.scaling;
 
 	if (pstate_funcs.get_aperf_mperf_shift)
 		cpu->aperf_mperf_shift = pstate_funcs.get_aperf_mperf_shift();
-- 
2.17.1

