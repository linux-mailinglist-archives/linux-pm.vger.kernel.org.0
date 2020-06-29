Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3070D20D345
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jun 2020 21:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbgF2S5d (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jun 2020 14:57:33 -0400
Received: from mga05.intel.com ([192.55.52.43]:57272 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728942AbgF2S52 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 29 Jun 2020 14:57:28 -0400
IronPort-SDR: YicFCowbxuoQM4Gw4wwtqvmk5B9wNcA7wZ7hVFiNtpGavry5L/SEb7f68WuXkhszTB7jLyh4fa
 co4UDkPQjvfA==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="230725847"
X-IronPort-AV: E=Sophos;i="5.75,294,1589266800"; 
   d="scan'208";a="230725847"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2020 22:34:57 -0700
IronPort-SDR: nKb8wG9RWla5JJT3JADlZfStBphHCrokT3cd2SE9MXtJwU7d+r9MrbeDaputaYyzY1SWR1ZVp9
 tRt4gIOfc39A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,294,1589266800"; 
   d="scan'208";a="480662173"
Received: from jielin1-mobl.ccr.corp.intel.com (HELO rzhang1-mobile.ccr.corp.intel.com) ([10.249.173.170])
  by fmsmga005.fm.intel.com with ESMTP; 28 Jun 2020 22:34:54 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     rjw@rjwysocki.net
Cc:     linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH] powercap/intel_rapl: add support for Sapphire Rapids
Date:   Mon, 29 Jun 2020 13:34:50 +0800
Message-Id: <20200629053450.12392-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

RAPL on SPR behaves similar to HSW server, except that SPR uses a fixed
energy unit (1 Joule) for the PSYS RAPL domain.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/powercap/intel_rapl_common.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 61a63a16b5e7..b739ce4f390d 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -93,6 +93,7 @@ struct rapl_defaults {
 	u64 (*compute_time_window)(struct rapl_package *rp, u64 val,
 				    bool to_raw);
 	unsigned int dram_domain_energy_unit;
+	unsigned int psys_domain_energy_unit;
 };
 static struct rapl_defaults *rapl_defaults;
 
@@ -533,12 +534,23 @@ static void rapl_init_domains(struct rapl_package *rp)
 		for (j = 0; j < RAPL_DOMAIN_REG_MAX; j++)
 			rd->regs[j] = rp->priv->regs[i][j];
 
-		if (i == RAPL_DOMAIN_DRAM) {
+		switch (i) {
+		case RAPL_DOMAIN_DRAM:
 			rd->domain_energy_unit =
 			    rapl_defaults->dram_domain_energy_unit;
 			if (rd->domain_energy_unit)
 				pr_info("DRAM domain energy unit %dpj\n",
 					rd->domain_energy_unit);
+			break;
+		case RAPL_DOMAIN_PLATFORM:
+			rd->domain_energy_unit =
+			    rapl_defaults->psys_domain_energy_unit;
+			if (rd->domain_energy_unit)
+				pr_info("Platform domain energy unit %dpj\n",
+					rd->domain_energy_unit);
+			break;
+		default:
+			break;
 		}
 		rd++;
 	}
@@ -919,6 +931,14 @@ static const struct rapl_defaults rapl_defaults_hsw_server = {
 	.dram_domain_energy_unit = 15300,
 };
 
+static const struct rapl_defaults rapl_defaults_spr_server = {
+	.check_unit = rapl_check_unit_core,
+	.set_floor_freq = set_floor_freq_default,
+	.compute_time_window = rapl_compute_time_window_core,
+	.dram_domain_energy_unit = 15300,
+	.psys_domain_energy_unit = 1000000000,
+};
+
 static const struct rapl_defaults rapl_defaults_byt = {
 	.floor_freq_reg_addr = IOSF_CPU_POWER_BUDGET_CTL_BYT,
 	.check_unit = rapl_check_unit_atom,
@@ -978,6 +998,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE_L,		&rapl_defaults_core),
 	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE,		&rapl_defaults_core),
 	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L,		&rapl_defaults_core),
+	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&rapl_defaults_spr_server),
 
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT,	&rapl_defaults_byt),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_AIRMONT,	&rapl_defaults_cht),
-- 
2.17.1

