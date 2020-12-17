Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 068252DCFA9
	for <lists+linux-pm@lfdr.de>; Thu, 17 Dec 2020 11:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgLQKoC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Dec 2020 05:44:02 -0500
Received: from mga07.intel.com ([134.134.136.100]:55396 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726488AbgLQKoC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 17 Dec 2020 05:44:02 -0500
IronPort-SDR: s66Y0Qk9giK0z/AgtkyfiFdB7QDjPdkR55qHGR1BFoH4mTu/pZQtWU5j+3zZF5I1pi4mVHtCYw
 NF8MzyS70YJA==
X-IronPort-AV: E=McAfee;i="6000,8403,9837"; a="239317982"
X-IronPort-AV: E=Sophos;i="5.78,426,1599548400"; 
   d="scan'208";a="239317982"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2020 02:42:16 -0800
IronPort-SDR: 7hufJF96aVJs3jdNcuUbOOcQhj+zIz9abFidDLlL7O18bylSQpbmgUbdGXdS42E6ofOkj9CHhu
 cfpUQ/uSa8Ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,426,1599548400"; 
   d="scan'208";a="392483698"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Dec 2020 02:42:15 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     lenb@kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        srinivas.pandruvada@linux.intel.com
Subject: [PATCH] cpufreq: intel_pstate: Use the latest guaranteed freq during verify
Date:   Thu, 17 Dec 2020 02:42:15 -0800
Message-Id: <20201217104215.2544837-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This change tries to address an issue, when BIOS disabled turbo
but HWP_CAP guaranteed is changed later and user space wants to take
advantage of this increased guaranteed performance.

The HWP_CAP.GUARANTEED value is not a static value. It can be changed
by some out of band agent or during Intel Speed Select performance
level change. The HWP_CAP.MAX still shows max possible performance when
BIOS disabled turbo. So guaranteed can still change as long as this is
same or below HWP_CAP.MAX.

When guaranteed is changed, the sysfs base_frequency attributes shows
the latest guaranteed frequency. This attribute can be used by user
space software to update scaling min/max frequency.

Currently the setpolicy callback already uses the latest HWP_CAP
values when setting HWP_REQ. But the verify callback will still restrict
the user settings to the to old guaranteed value. So if the guaranteed
is increased, user space can't take advantage of it.

To solve this similar to setpolicy callback, read the latest HWP_CAP
values and use it to restrict the maximum setting. This is done by
calling intel_pstate_get_hwp_max(), which already accounts for user
and BIOS turbo disable to get the current max performance.

This issue is side effect of fixing the issue of scaling frequency
limits by the
 'commit eacc9c5a927e ("cpufreq: intel_pstate:
 Fix intel_pstate_get_hwp_max() for turbo disabled")'
The fix resulted in correct setting of reduced scaling frequencies,
but this resulted in capping HWP.REQ to HWP_CAP.GUARANTEED in this case.

Cc: 5.8+ <stable@vger.kernel.org> # 5.8+
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 2a4db856222f..7081d1edb22b 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2199,6 +2199,12 @@ static void intel_pstate_clear_update_util_hook(unsigned int cpu)
 
 static int intel_pstate_get_max_freq(struct cpudata *cpu)
 {
+	if (hwp_active) {
+		int turbo_max, max_state;
+
+		intel_pstate_get_hwp_max(cpu->cpu, &turbo_max, &max_state);
+		return max_state * cpu->pstate.scaling;
+	}
 	return global.turbo_disabled || global.no_turbo ?
 			cpu->pstate.max_freq : cpu->pstate.turbo_freq;
 }
-- 
2.29.2

