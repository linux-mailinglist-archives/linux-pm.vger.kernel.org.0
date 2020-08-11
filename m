Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEFE241D32
	for <lists+linux-pm@lfdr.de>; Tue, 11 Aug 2020 17:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728997AbgHKPcF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Aug 2020 11:32:05 -0400
Received: from mga05.intel.com ([192.55.52.43]:25702 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728872AbgHKPcF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 11 Aug 2020 11:32:05 -0400
IronPort-SDR: X6z4YWAt25i41ZnfxZoZdmeimnqCdi8A0fpsAsmMBsPqobS/wH3p36nKWLZFphWlZcFUlwncO5
 f0kJRlGTakvQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9710"; a="238588489"
X-IronPort-AV: E=Sophos;i="5.76,300,1592895600"; 
   d="scan'208";a="238588489"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2020 08:32:05 -0700
IronPort-SDR: sWZ0iP7OQfetX0mCXGFAvQ+l0v2LMMCdFmOQ9ZmFz7Ix7835l3pidZmkpoh8SdOeL8fLbnKdHb
 APPduLquFb2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,300,1592895600"; 
   d="scan'208";a="439077256"
Received: from xzhao1-mobl.ccr.corp.intel.com (HELO rzhang1-mobile.ccr.corp.intel.com) ([10.249.175.227])
  by orsmga004.jf.intel.com with ESMTP; 11 Aug 2020 08:32:01 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org
Cc:     linux-pm@vger.kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        kan.liang@linux.intel.com, len.brown@intel.com, rafael@kernel.org
Subject: [PATCH v2 3/3] perf/x86/rapl: Add support for Intel SPR platform
Date:   Tue, 11 Aug 2020 23:31:49 +0800
Message-Id: <20200811153149.12242-4-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200811153149.12242-1-rui.zhang@intel.com>
References: <20200811153149.12242-1-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Intel SPR platform uses fixed 16 bit energy unit for DRAM RAPL domain,
and fixed 0 bit energy unit for Psys RAPL domain.
After this, on SPR platform the energy counters appear in perf list.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Acked-by: Len Brown <len.brown@intel.com>
---
 arch/x86/events/rapl.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index d0002eb971b7..67b411f7e8c4 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -133,6 +133,7 @@ struct rapl_pmus {
 enum rapl_unit_quirk {
 	RAPL_UNIT_QUIRK_NONE,
 	RAPL_UNIT_QUIRK_INTEL_HSW,
+	RAPL_UNIT_QUIRK_INTEL_SPR,
 };
 
 struct rapl_model {
@@ -627,6 +628,14 @@ static int rapl_check_hw_unit(struct rapl_model *rm)
 	case RAPL_UNIT_QUIRK_INTEL_HSW:
 		rapl_hw_unit[PERF_RAPL_RAM] = 16;
 		break;
+	/*
+	 * SPR shares the same DRAM domain energy unit as HSW, plus it
+	 * also has a fixed energy unit for Psys domain.
+	 */
+	case RAPL_UNIT_QUIRK_INTEL_SPR:
+		rapl_hw_unit[PERF_RAPL_RAM] = 16;
+		rapl_hw_unit[PERF_RAPL_PSYS] = 0;
+		break;
 	default:
 		break;
 	}
@@ -757,6 +766,16 @@ static struct rapl_model model_skl = {
 	.rapl_msrs      = intel_rapl_msrs,
 };
 
+static struct rapl_model model_spr = {
+	.events		= BIT(PERF_RAPL_PP0) |
+			  BIT(PERF_RAPL_PKG) |
+			  BIT(PERF_RAPL_RAM) |
+			  BIT(PERF_RAPL_PSYS),
+	.unit_quirk	= RAPL_UNIT_QUIRK_INTEL_SPR,
+	.msr_power_unit = MSR_RAPL_POWER_UNIT,
+	.rapl_msrs      = intel_rapl_msrs,
+};
+
 static struct rapl_model model_amd_fam17h = {
 	.events		= BIT(PERF_RAPL_PKG),
 	.msr_power_unit = MSR_AMD_RAPL_POWER_UNIT,
@@ -793,6 +812,7 @@ static const struct x86_cpu_id rapl_model_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,		&model_hsx),
 	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE_L,		&model_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE,		&model_skl),
+	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&model_spr),
 	X86_MATCH_VENDOR_FAM(AMD,	0x17,		&model_amd_fam17h),
 	X86_MATCH_VENDOR_FAM(HYGON,	0x18,		&model_amd_fam17h),
 	{},
-- 
2.17.1

