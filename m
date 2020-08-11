Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D86E241D30
	for <lists+linux-pm@lfdr.de>; Tue, 11 Aug 2020 17:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbgHKPcC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Aug 2020 11:32:02 -0400
Received: from mga05.intel.com ([192.55.52.43]:25702 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728872AbgHKPcC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 11 Aug 2020 11:32:02 -0400
IronPort-SDR: gkLFVq43yFxVNhLlfEn5nYYsjfVRX+mGWNu7rW59HFnNX4UqhPKnuKgAr56xzB957WDB/DHIEQ
 T9XY3Q9PAIDw==
X-IronPort-AV: E=McAfee;i="6000,8403,9710"; a="238588471"
X-IronPort-AV: E=Sophos;i="5.76,300,1592895600"; 
   d="scan'208";a="238588471"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2020 08:32:01 -0700
IronPort-SDR: TXDaOCEVDObMBOvM5BF1iTY/3Zj+ti7oaI10m+Q0gaoFv3nCcjbaDTxjaOocZtde1ia3yQVG52
 urufk8Sq61vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,300,1592895600"; 
   d="scan'208";a="439077212"
Received: from xzhao1-mobl.ccr.corp.intel.com (HELO rzhang1-mobile.ccr.corp.intel.com) ([10.249.175.227])
  by orsmga004.jf.intel.com with ESMTP; 11 Aug 2020 08:31:58 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org
Cc:     linux-pm@vger.kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        kan.liang@linux.intel.com, len.brown@intel.com, rafael@kernel.org
Subject: [PATCH v2 2/3] perf/x86/rapl: Support multiple rapl unit quirks
Date:   Tue, 11 Aug 2020 23:31:48 +0800
Message-Id: <20200811153149.12242-3-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200811153149.12242-1-rui.zhang@intel.com>
References: <20200811153149.12242-1-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There will be more platforms with different fixed energy units.
Enhance the code to support different rapl unit quirks for different
platforms.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
---
 arch/x86/events/rapl.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index e9723833551f..d0002eb971b7 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -130,11 +130,16 @@ struct rapl_pmus {
 	struct rapl_pmu		*pmus[];
 };
 
+enum rapl_unit_quirk {
+	RAPL_UNIT_QUIRK_NONE,
+	RAPL_UNIT_QUIRK_INTEL_HSW,
+};
+
 struct rapl_model {
 	struct perf_msr *rapl_msrs;
 	unsigned long	events;
 	unsigned int	msr_power_unit;
-	bool		apply_quirk;
+	enum rapl_unit_quirk	unit_quirk;
 };
 
  /* 1/2^hw_unit Joule */
@@ -612,14 +617,20 @@ static int rapl_check_hw_unit(struct rapl_model *rm)
 	for (i = 0; i < NR_RAPL_DOMAINS; i++)
 		rapl_hw_unit[i] = (msr_rapl_power_unit_bits >> 8) & 0x1FULL;
 
+	switch (rm->unit_quirk) {
 	/*
 	 * DRAM domain on HSW server and KNL has fixed energy unit which can be
 	 * different than the unit from power unit MSR. See
 	 * "Intel Xeon Processor E5-1600 and E5-2600 v3 Product Families, V2
 	 * of 2. Datasheet, September 2014, Reference Number: 330784-001 "
 	 */
-	if (rm->apply_quirk)
+	case RAPL_UNIT_QUIRK_INTEL_HSW:
 		rapl_hw_unit[PERF_RAPL_RAM] = 16;
+		break;
+	default:
+		break;
+	}
+
 
 	/*
 	 * Calculate the timer rate:
@@ -698,7 +709,6 @@ static struct rapl_model model_snb = {
 	.events		= BIT(PERF_RAPL_PP0) |
 			  BIT(PERF_RAPL_PKG) |
 			  BIT(PERF_RAPL_PP1),
-	.apply_quirk	= false,
 	.msr_power_unit = MSR_RAPL_POWER_UNIT,
 	.rapl_msrs      = intel_rapl_msrs,
 };
@@ -707,7 +717,6 @@ static struct rapl_model model_snbep = {
 	.events		= BIT(PERF_RAPL_PP0) |
 			  BIT(PERF_RAPL_PKG) |
 			  BIT(PERF_RAPL_RAM),
-	.apply_quirk	= false,
 	.msr_power_unit = MSR_RAPL_POWER_UNIT,
 	.rapl_msrs      = intel_rapl_msrs,
 };
@@ -717,7 +726,6 @@ static struct rapl_model model_hsw = {
 			  BIT(PERF_RAPL_PKG) |
 			  BIT(PERF_RAPL_RAM) |
 			  BIT(PERF_RAPL_PP1),
-	.apply_quirk	= false,
 	.msr_power_unit = MSR_RAPL_POWER_UNIT,
 	.rapl_msrs      = intel_rapl_msrs,
 };
@@ -726,7 +734,7 @@ static struct rapl_model model_hsx = {
 	.events		= BIT(PERF_RAPL_PP0) |
 			  BIT(PERF_RAPL_PKG) |
 			  BIT(PERF_RAPL_RAM),
-	.apply_quirk	= true,
+	.unit_quirk	= RAPL_UNIT_QUIRK_INTEL_HSW,
 	.msr_power_unit = MSR_RAPL_POWER_UNIT,
 	.rapl_msrs      = intel_rapl_msrs,
 };
@@ -734,7 +742,7 @@ static struct rapl_model model_hsx = {
 static struct rapl_model model_knl = {
 	.events		= BIT(PERF_RAPL_PKG) |
 			  BIT(PERF_RAPL_RAM),
-	.apply_quirk	= true,
+	.unit_quirk	= RAPL_UNIT_QUIRK_INTEL_HSW,
 	.msr_power_unit = MSR_RAPL_POWER_UNIT,
 	.rapl_msrs      = intel_rapl_msrs,
 };
@@ -745,14 +753,12 @@ static struct rapl_model model_skl = {
 			  BIT(PERF_RAPL_RAM) |
 			  BIT(PERF_RAPL_PP1) |
 			  BIT(PERF_RAPL_PSYS),
-	.apply_quirk	= false,
 	.msr_power_unit = MSR_RAPL_POWER_UNIT,
 	.rapl_msrs      = intel_rapl_msrs,
 };
 
 static struct rapl_model model_amd_fam17h = {
 	.events		= BIT(PERF_RAPL_PKG),
-	.apply_quirk	= false,
 	.msr_power_unit = MSR_AMD_RAPL_POWER_UNIT,
 	.rapl_msrs      = amd_rapl_msrs,
 };
-- 
2.17.1

