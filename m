Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6A04A41B0
	for <lists+linux-pm@lfdr.de>; Sat, 31 Aug 2019 04:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbfHaCV7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 30 Aug 2019 22:21:59 -0400
Received: from [110.188.70.11] ([110.188.70.11]:6810 "EHLO spam1.hygon.cn"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728410AbfHaCV6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 30 Aug 2019 22:21:58 -0400
Received: from MK-FE.hygon.cn ([172.23.18.61])
        by spam1.hygon.cn with ESMTP id x7V2L0jd005974;
        Sat, 31 Aug 2019 10:21:00 +0800 (GMT-8)
        (envelope-from puwen@hygon.cn)
Received: from cncheex01.Hygon.cn ([172.23.18.10])
        by MK-FE.hygon.cn with ESMTP id x7V2KplQ015477;
        Sat, 31 Aug 2019 10:20:51 +0800 (GMT-8)
        (envelope-from puwen@hygon.cn)
Received: from pw-vbox.hygon.cn (172.23.18.44) by cncheex01.Hygon.cn
 (172.23.18.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Sat, 31 Aug
 2019 10:20:58 +0800
From:   Pu Wen <puwen@hygon.cn>
To:     <lenb@kernel.org>, <calvin.walton@kepstin.ca>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Pu Wen <puwen@hygon.cn>
Subject: [RFC PATCH v2] tools/power turbostat: Add support for Hygon Fam 18h (Dhyana) RAPL
Date:   Sat, 31 Aug 2019 10:20:31 +0800
Message-ID: <1567218031-4401-1-git-send-email-puwen@hygon.cn>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.23.18.44]
X-ClientProxiedBy: cncheex02.Hygon.cn (172.23.18.12) To cncheex01.Hygon.cn
 (172.23.18.10)
X-MAIL: spam1.hygon.cn x7V2L0jd005974
X-DNSRBL: 
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Commit 9392bd98bba760be96ee ("tools/power turbostat: Add support for AMD
Fam 17h (Zen) RAPL") and the commit 3316f99a9f1b68c578c5 ("tools/power
turbostat: Also read package power on AMD F17h (Zen)") add AMD Fam 17h
RAPL support.

Hygon Family 18h(Dhyana) support RAPL in bit 14 of CPUID 0x80000007 EDX,
and has MSRs RAPL_PWR_UNIT/CORE_ENERGY_STAT/PKG_ENERGY_STAT. So add Hygon
Dhyana Family 18h support for RAPL.

Already tested on Hygon multi-node systems and it shows correct per-core
energy usage and the total package power.

Signed-off-by: Pu Wen <puwen@hygon.cn>
Reviewed-by: Calvin Walton <calvin.walton@kepstin.ca>
---
 tools/power/x86/turbostat/turbostat.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 1cd28eb..d42f3f5 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -60,6 +60,7 @@ unsigned int do_irtl_hsw;
 unsigned int units = 1000000;	/* MHz etc */
 unsigned int genuine_intel;
 unsigned int authentic_amd;
+unsigned int hygon_genuine;
 unsigned int max_level, max_extended_level;
 unsigned int has_invariant_tsc;
 unsigned int do_nhm_platform_info;
@@ -1714,7 +1715,7 @@ void get_apic_id(struct thread_data *t)
 	if (!DO_BIC(BIC_X2APIC))
 		return;
 
-	if (authentic_amd) {
+	if (authentic_amd || hygon_genuine) {
 		unsigned int topology_extensions;
 
 		if (max_extended_level < 0x8000001e)
@@ -3803,6 +3804,7 @@ double get_tdp_amd(unsigned int family)
 {
 	switch (family) {
 	case 0x17:
+	case 0x18:
 	default:
 		/* This is the max stock TDP of HEDT/Server Fam17h chips */
 		return 250.0;
@@ -3982,6 +3984,7 @@ void rapl_probe_amd(unsigned int family, unsigned int model)
 
 	switch (family) {
 	case 0x17: /* Zen, Zen+ */
+	case 0x18: /* Hygon Dhyana */
 		do_rapl = RAPL_AMD_F17H | RAPL_PER_CORE_ENERGY;
 		if (rapl_joules) {
 			BIC_PRESENT(BIC_Pkg_J);
@@ -4018,7 +4021,7 @@ void rapl_probe(unsigned int family, unsigned int model)
 {
 	if (genuine_intel)
 		rapl_probe_intel(family, model);
-	if (authentic_amd)
+	if (authentic_amd || hygon_genuine)
 		rapl_probe_amd(family, model);
 }
 
@@ -4600,6 +4603,8 @@ void process_cpuid()
 		genuine_intel = 1;
 	else if (ebx == 0x68747541 && ecx == 0x444d4163 && edx == 0x69746e65)
 		authentic_amd = 1;
+	else if (ebx == 0x6f677948 && ecx == 0x656e6975 && edx == 0x6e65476e)
+		hygon_genuine = 1;
 
 	if (!quiet)
 		fprintf(outf, "CPUID(0): %.4s%.4s%.4s ",
-- 
2.7.4

