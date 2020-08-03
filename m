Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5AAA23AC7E
	for <lists+linux-pm@lfdr.de>; Mon,  3 Aug 2020 20:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbgHCShZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Aug 2020 14:37:25 -0400
Received: from mga04.intel.com ([192.55.52.120]:52139 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgHCShY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 3 Aug 2020 14:37:24 -0400
IronPort-SDR: uRxGN6cHl4iWkPE48NT9Sxf/8kaTAQOJFSyA/VhAfu9zhmxW7jYH+NysKhkZANq6dFlzAngg4j
 ZGy0SmG4ejWA==
X-IronPort-AV: E=McAfee;i="6000,8403,9702"; a="149630908"
X-IronPort-AV: E=Sophos;i="5.75,430,1589266800"; 
   d="scan'208";a="149630908"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2020 11:37:22 -0700
IronPort-SDR: F4v4HaqDRpeNzu6H96SRvtrH+se8ECVzBKnuOfsr5PeVIO8Z3ojtd5jruGuUynSQCAgPQcyh5a
 4EKffRXzgU3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,430,1589266800"; 
   d="scan'208";a="492505104"
Received: from spandruv-mobl.amr.corp.intel.com ([10.254.116.3])
  by fmsmga005.fm.intel.com with ESMTP; 03 Aug 2020 11:37:22 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rjw@rjwysocki.net, lenb@kernel.org, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] cpufreq: intel_pstate: Fix cpuinfo_max_freq when MSR_TURBO_RATIO_LIMIT is 0
Date:   Mon,  3 Aug 2020 11:37:20 -0700
Message-Id: <20200803183720.13082-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The MSR_TURBO_RATIO_LIMIT can be 0. This is not an error. User can update
this MSR via BIOS settings on some systems or can use msr tools to update.
Also some systems boot with value = 0.

This results in display of cpufreq/cpuinfo_max_freq wrong. This value
will be equal to cpufreq/base_frequency, even though turbo is enabled.

But platform will still function normally in HWP mode as we get max
1-core frequency from the MSR_HWP_CAPABILITIES. This MSR is already used
to calculate cpu->pstate.turbo_freq, which is used for to set
policy->cpuinfo.max_freq. But some other places cpu->pstate.turbo_pstate
is used. For example to set policy->max.

To fix this, also update cpu->pstate.turbo_pstate when updating
cpu->pstate.turbo_freq.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 7e0f7880b21a..c7540ad28995 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1572,6 +1572,7 @@ static void intel_pstate_get_cpu_pstates(struct cpudata *cpu)
 
 		intel_pstate_get_hwp_max(cpu->cpu, &phy_max, &current_max);
 		cpu->pstate.turbo_freq = phy_max * cpu->pstate.scaling;
+		cpu->pstate.turbo_pstate = phy_max;
 	} else {
 		cpu->pstate.turbo_freq = cpu->pstate.turbo_pstate * cpu->pstate.scaling;
 	}
-- 
2.17.1

