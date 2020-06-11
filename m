Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4F11F6D02
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jun 2020 19:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgFKRs7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 11 Jun 2020 13:48:59 -0400
Received: from mga07.intel.com ([134.134.136.100]:12262 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725824AbgFKRs7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 11 Jun 2020 13:48:59 -0400
IronPort-SDR: 1npZfPRDTMvR7jEZiEK+ljNb7AeK4zNBQmrf6WYnYNFVZe4O5HfDQAalauHsDQO/aJc+VyVtGw
 V+KGhYCn2gqQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2020 10:48:57 -0700
IronPort-SDR: t8T5ThLb800ZCYyZU53/6ra7m2IakAD76dJbXTJlaMqV9KdUunjbV508yM5308qpZV5gBVDlDU
 vefs3l/WeaIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,500,1583222400"; 
   d="scan'208";a="275407817"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by orsmga006.jf.intel.com with ESMTP; 11 Jun 2020 10:48:57 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     lenb@kernel.org, viresh.kumar@linaro.org, rjw@rjwysocki.net
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] cpufreq: intel_pstate: Add additional OOB enabling bit
Date:   Thu, 11 Jun 2020 10:48:38 -0700
Message-Id: <20200611174838.2822533-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add additional bit for OOB (Out of band) enabling of P-states. In this
case intel_pstate shouldn't load. Currently, only "BIT(8) == 1" of the
MSR MSR_MISC_PWR_MGMT is considered as OOB. Also add "BIT(18) == 1" as
OOB condition.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 8e23a698ce04..f21761443c90 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2686,8 +2686,8 @@ static bool __init intel_pstate_platform_pwr_mgmt_exists(void)
 	id = x86_match_cpu(intel_pstate_cpu_oob_ids);
 	if (id) {
 		rdmsrl(MSR_MISC_PWR_MGMT, misc_pwr);
-		if (misc_pwr & (1 << 8)) {
-			pr_debug("Bit 8 in the MISC_PWR_MGMT MSR set\n");
+		if ((misc_pwr & BIT(8)) || (misc_pwr & BIT(18))) {
+			pr_debug("Bit 8 or 18 in the MISC_PWR_MGMT MSR set\n");
 			return true;
 		}
 	}
-- 
2.24.1

