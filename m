Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7201C1A7B81
	for <lists+linux-pm@lfdr.de>; Tue, 14 Apr 2020 14:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502425AbgDNM4K (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Apr 2020 08:56:10 -0400
Received: from mga12.intel.com ([192.55.52.136]:26251 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502421AbgDNM4I (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 14 Apr 2020 08:56:08 -0400
IronPort-SDR: Iuw97+zNMYVYRzx5Wb/0BcU3jYSml2NyxDPAaNOK7UComUtGU+6t+b/uHlGz1zLx3lXVGzYdKU
 PYS3G8+CyZJg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 05:56:06 -0700
IronPort-SDR: YDhToaAQ8QVCDvW8130+8/xYpkoTTxD8O/IDwjqMoO7gk2PJQScEcSEiZthSuJiOY0z1I5+jef
 7S4peVVZ0VCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,382,1580803200"; 
   d="scan'208";a="277244581"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by fmsmga004.fm.intel.com with ESMTP; 14 Apr 2020 05:56:05 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     linux-pm@vger.kernel.org
Cc:     Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 1/3][RFC v2] tools/power turbostat: Make the energy variable to be 64 bit
Date:   Tue, 14 Apr 2020 20:56:38 +0800
Message-Id: <26544f20ea67c0e9f426b9248a0e9e265d0f3005.1586782089.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1586782089.git.yu.c.chen@intel.com>
References: <cover.1586782089.git.yu.c.chen@intel.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Change the energy variable from 32bit to 64bit, so that it can record long
time duration. After this conversion, adjust the DELTA_WRAP32() accordingly.

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 30 ++++++++++++---------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 33b370865d16..95f3047e94ae 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -211,12 +211,12 @@ struct pkg_data {
 	long long gfx_rc6_ms;
 	unsigned int gfx_mhz;
 	unsigned int package_id;
-	unsigned int energy_pkg;	/* MSR_PKG_ENERGY_STATUS */
-	unsigned int energy_dram;	/* MSR_DRAM_ENERGY_STATUS */
-	unsigned int energy_cores;	/* MSR_PP0_ENERGY_STATUS */
-	unsigned int energy_gfx;	/* MSR_PP1_ENERGY_STATUS */
-	unsigned int rapl_pkg_perf_status;	/* MSR_PKG_PERF_STATUS */
-	unsigned int rapl_dram_perf_status;	/* MSR_DRAM_PERF_STATUS */
+	unsigned long long energy_pkg;	/* MSR_PKG_ENERGY_STATUS */
+	unsigned long long energy_dram;	/* MSR_DRAM_ENERGY_STATUS */
+	unsigned long long energy_cores;	/* MSR_PP0_ENERGY_STATUS */
+	unsigned long long energy_gfx;	/* MSR_PP1_ENERGY_STATUS */
+	unsigned long long rapl_pkg_perf_status;	/* MSR_PKG_PERF_STATUS */
+	unsigned long long rapl_dram_perf_status;	/* MSR_DRAM_PERF_STATUS */
 	unsigned int pkg_temp_c;
 	unsigned long long counter[MAX_ADDED_COUNTERS];
 } *package_even, *package_odd;
@@ -858,13 +858,13 @@ int dump_counters(struct thread_data *t, struct core_data *c,
 		outp += sprintf(outp, "pc10: %016llX\n", p->pc10);
 		outp += sprintf(outp, "cpu_lpi: %016llX\n", p->cpu_lpi);
 		outp += sprintf(outp, "sys_lpi: %016llX\n", p->sys_lpi);
-		outp += sprintf(outp, "Joules PKG: %0X\n", p->energy_pkg);
-		outp += sprintf(outp, "Joules COR: %0X\n", p->energy_cores);
-		outp += sprintf(outp, "Joules GFX: %0X\n", p->energy_gfx);
-		outp += sprintf(outp, "Joules RAM: %0X\n", p->energy_dram);
-		outp += sprintf(outp, "Throttle PKG: %0X\n",
+		outp += sprintf(outp, "Joules PKG: %0llX\n", p->energy_pkg);
+		outp += sprintf(outp, "Joules COR: %0llX\n", p->energy_cores);
+		outp += sprintf(outp, "Joules GFX: %0llX\n", p->energy_gfx);
+		outp += sprintf(outp, "Joules RAM: %0llX\n", p->energy_dram);
+		outp += sprintf(outp, "Throttle PKG: %0llX\n",
 			p->rapl_pkg_perf_status);
-		outp += sprintf(outp, "Throttle RAM: %0X\n",
+		outp += sprintf(outp, "Throttle RAM: %0llX\n",
 			p->rapl_dram_perf_status);
 		outp += sprintf(outp, "PTM: %dC\n", p->pkg_temp_c);
 
@@ -1210,11 +1210,7 @@ void format_all_counters(struct thread_data *t, struct core_data *c, struct pkg_
 }
 
 #define DELTA_WRAP32(new, old)			\
-	if (new > old) {			\
-		old = new - old;		\
-	} else {				\
-		old = 0x100000000 + new - old;	\
-	}
+	old = ((((unsigned long long)new << 32) - ((unsigned long long)old << 32)) >> 32);
 
 int
 delta_package(struct pkg_data *new, struct pkg_data *old)
-- 
2.20.1

