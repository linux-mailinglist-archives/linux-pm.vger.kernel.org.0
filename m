Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEB121A88D
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jul 2020 22:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbgGIUFg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Jul 2020 16:05:36 -0400
Received: from mga17.intel.com ([192.55.52.151]:60931 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbgGIUFg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 9 Jul 2020 16:05:36 -0400
IronPort-SDR: 3eOz8SEHUZgz0gjdV4IV/qbAx7vajirNY7N8/tgCURfm9BYS0B1/Pggc6+9vdOCn+4qsgTJ0xf
 U0EHOEVdnxzQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9677"; a="128163456"
X-IronPort-AV: E=Sophos;i="5.75,332,1589266800"; 
   d="scan'208";a="128163456"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2020 13:05:34 -0700
IronPort-SDR: 5gj3bKx/CeHZJos+SOEy+1FMP/mAqE7tvzXQiqtUOIEIrHt6GcUSaLOvhEm+HPB540UMmQeiLk
 QxtdROqf2Ldg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,332,1589266800"; 
   d="scan'208";a="324330039"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by orsmga007.jf.intel.com with ESMTP; 09 Jul 2020 13:05:34 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rjw@rjwysocki.net, lenb@kernel.org, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com, kernel-janitors@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] cpufreq: intel_pstate: Fix static checker warning for epp variable
Date:   Thu,  9 Jul 2020 13:05:22 -0700
Message-Id: <20200709200522.3566181-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix warning for:
drivers/cpufreq/intel_pstate.c:731 store_energy_performance_preference()
error: uninitialized symbol 'epp'.

This warning is for a case, when energy_performance_preference attribute
matches pre defined strings. In this case the value of raw epp will not
be used to set EPP bits in MSR_HWP_REQUEST. So initializing with any
value is fine.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
This patch is on top of bleed-edge branch at
https://kernel.googlesource.com/pub/scm/linux/kernel/git/rafael/linux-pm

 drivers/cpufreq/intel_pstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 44c7b4677675..94cd07678ee3 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -709,7 +709,7 @@ static ssize_t store_energy_performance_preference(
 	struct cpudata *cpu_data = all_cpu_data[policy->cpu];
 	char str_preference[21];
 	bool raw = false;
-	u32 epp;
+	u32 epp = 0;
 	int ret;
 
 	ret = sscanf(buf, "%20s", str_preference);
-- 
2.25.4

