Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2FEE41DABB
	for <lists+linux-pm@lfdr.de>; Thu, 30 Sep 2021 15:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349025AbhI3NLk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Sep 2021 09:11:40 -0400
Received: from mga17.intel.com ([192.55.52.151]:40038 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234439AbhI3NLj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 30 Sep 2021 09:11:39 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10122"; a="205331927"
X-IronPort-AV: E=Sophos;i="5.85,336,1624345200"; 
   d="scan'208";a="205331927"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2021 06:09:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,336,1624345200"; 
   d="scan'208";a="476984809"
Received: from srpawnik.iind.intel.com ([10.223.107.57])
  by orsmga007.jf.intel.com with ESMTP; 30 Sep 2021 06:09:55 -0700
From:   Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
To:     lenb@kernel.org, tony.luck@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     sumeet.r.pawnikar@intel.com
Subject: [PATCH] tools/power turbostat: print power values upto three decimal
Date:   Thu, 30 Sep 2021 18:40:18 +0530
Message-Id: <20210930131018.30100-1-sumeet.r.pawnikar@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Print power values upto three decimal places in watts.

Suggested-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 47d3ba895d6d..26f640f61010 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -4698,7 +4698,7 @@ int print_thermal(struct thread_data *t, struct core_data *c, struct pkg_data *p
 
 void print_power_limit_msr(int cpu, unsigned long long msr, char *label)
 {
-	fprintf(outf, "cpu%d: %s: %sabled (%f Watts, %f sec, clamp %sabled)\n",
+	fprintf(outf, "cpu%d: %s: %sabled (%0.3f Watts, %f sec, clamp %sabled)\n",
 		cpu, label,
 		((msr >> 15) & 1) ? "EN" : "DIS",
 		((msr >> 0) & 0x7FFF) * rapl_power_units,
@@ -4762,7 +4762,7 @@ int print_rapl(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 			cpu, msr, (msr >> 63) & 1 ? "" : "UN");
 
 		print_power_limit_msr(cpu, msr, "PKG Limit #1");
-		fprintf(outf, "cpu%d: PKG Limit #2: %sabled (%f Watts, %f* sec, clamp %sabled)\n",
+		fprintf(outf, "cpu%d: PKG Limit #2: %sabled (%0.3f Watts, %f* sec, clamp %sabled)\n",
 			cpu,
 			((msr >> 47) & 1) ? "EN" : "DIS",
 			((msr >> 32) & 0x7FFF) * rapl_power_units,
-- 
2.17.1

