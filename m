Return-Path: <linux-pm+bounces-24860-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23875A7CFDA
	for <lists+linux-pm@lfdr.de>; Sun,  6 Apr 2025 20:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABDD818894C5
	for <lists+linux-pm@lfdr.de>; Sun,  6 Apr 2025 18:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF391A9B29;
	Sun,  6 Apr 2025 18:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xlj1pESg"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD80F1A8F9E
	for <linux-pm@vger.kernel.org>; Sun,  6 Apr 2025 18:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743965912; cv=none; b=dDZKiFlzA60/QosBa59YbAXcv2jyZYLAr80iKLrOjx450oBuEiNeiP6qTyR2grxmJwxjzCkkOXx22KM84rHfsx4NEZhCbzjzZSQTsjbiiv7Uj8QzdC3A0XqSjqyVJwwuHHAcpeDBiaMcCAin/MvHmGOs87RpOk2Z2NA9yZ9GiwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743965912; c=relaxed/simple;
	bh=OzC/HdfftBnvfrUQOID09G7YqUNwp6J582o5d/B05ms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q3yWFOczrAEl5vG6Z1MMN0uJOL7j/dE/SpxKsjinEl212QglslOtw3iei1IPb0zlSU74PLH6woX1TM51DO/K72Z9Ev272oql2zm5/ragVFmFPUj7YKtso0LLbQSrwhll0TWEmhFvgrxGEbtEjpXOD/64xDr5A8rR0QviKAQqwaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xlj1pESg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D6F9C4CEE3;
	Sun,  6 Apr 2025 18:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743965912;
	bh=OzC/HdfftBnvfrUQOID09G7YqUNwp6J582o5d/B05ms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=Xlj1pESgK0JpRSTHxZdO5gTPORvdMNCUhD8B4wmTFM/2pMfoK0icTb6CPpjRaHVvt
	 Rwrm49M73CaxWKmDKihf+M2zjNIXRta0HLf6SG0P0+qMlo2GjtZlm2a1NqDkCxY3Jn
	 I7M0E6jaZng5gf2dXbZ3fUrCKCPpk8fcxgHTiIb25KSnYbs9MfSzuL6KMh/jSpGWuj
	 cuncNPGuzSrbb7nrychQTk5OdSGhw+8m35LQFm7UnBsQQTE6QsnZvw+59e2K4cPuAS
	 LoCb6ev91Gbva/c40Fcy/7UEImeesdvc7qATiCZWldTa+1p6KqclKOb7TqhhzJTBld
	 0ZZonMUAhBD+A==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 09/10] tools/power turbostat: re-factor sysfs code
Date: Sun,  6 Apr 2025 14:57:18 -0400
Message-ID: <994633894f208a0151baaee1688ab3c431912553.1743965272.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <1c7c7388e6c31f46b26a884d80b45efbad8237b2.1743965272.git.len.brown@intel.com>
References: <1c7c7388e6c31f46b26a884d80b45efbad8237b2.1743965272.git.len.brown@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Len Brown <len.brown@intel.com>

Probe cpuidle "sysfs" residency and counts separately,
since soon we will make one disabled on, and the
other disabled off.

Clarify that some BIC (build-in-counters) are actually "groups".
since we're about to re-name some of those groups.

no functional change.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 31 ++++++++++++++++++---------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index c9a34c16c7a8..df0391bedcde 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -273,10 +273,10 @@ struct msr_counter bic[] = {
 #define	BIC_NMI			(1ULL << 61)
 #define	BIC_CPU_c1e		(1ULL << 62)
 
-#define BIC_TOPOLOGY (BIC_Package | BIC_Node | BIC_CoreCnt | BIC_PkgCnt | BIC_Core | BIC_CPU | BIC_Die)
-#define BIC_THERMAL_PWR (BIC_CoreTmp | BIC_PkgTmp | BIC_PkgWatt | BIC_CorWatt | BIC_GFXWatt | BIC_RAMWatt | BIC_PKG__ | BIC_RAM__ | BIC_SysWatt)
-#define BIC_FREQUENCY (BIC_Avg_MHz | BIC_Busy | BIC_Bzy_MHz | BIC_TSC_MHz | BIC_GFXMHz | BIC_GFXACTMHz | BIC_SAMMHz | BIC_SAMACTMHz | BIC_UNCORE_MHZ)
-#define BIC_IDLE (BIC_Busy | BIC_sysfs | BIC_CPU_c1 | BIC_CPU_c3 | BIC_CPU_c6 | BIC_CPU_c7 | BIC_GFX_rc6 | BIC_Pkgpc2 | BIC_Pkgpc3 | BIC_Pkgpc6 | BIC_Pkgpc7 | BIC_Pkgpc8 | BIC_Pkgpc9 | BIC_Pkgpc10 | BIC_CPU_LPI | BIC_SYS_LPI | BIC_Mod_c6 | BIC_Totl_c0 | BIC_Any_c0 | BIC_GFX_c0 | BIC_CPUGFX | BIC_SAM_mc6 | BIC_Diec6)
+#define BIC_GROUP_TOPOLOGY (BIC_Package | BIC_Node | BIC_CoreCnt | BIC_PkgCnt | BIC_Core | BIC_CPU | BIC_Die)
+#define BIC_GROUP_THERMAL_PWR (BIC_CoreTmp | BIC_PkgTmp | BIC_PkgWatt | BIC_CorWatt | BIC_GFXWatt | BIC_RAMWatt | BIC_PKG__ | BIC_RAM__ | BIC_SysWatt)
+#define BIC_GROUP_FREQUENCY (BIC_Avg_MHz | BIC_Busy | BIC_Bzy_MHz | BIC_TSC_MHz | BIC_GFXMHz | BIC_GFXACTMHz | BIC_SAMMHz | BIC_SAMACTMHz | BIC_UNCORE_MHZ)
+#define BIC_GROUP_IDLE (BIC_Busy | BIC_sysfs | BIC_CPU_c1 | BIC_CPU_c3 | BIC_CPU_c6 | BIC_CPU_c7 | BIC_GFX_rc6 | BIC_Pkgpc2 | BIC_Pkgpc3 | BIC_Pkgpc6 | BIC_Pkgpc7 | BIC_Pkgpc8 | BIC_Pkgpc9 | BIC_Pkgpc10 | BIC_CPU_LPI | BIC_SYS_LPI | BIC_Mod_c6 | BIC_Totl_c0 | BIC_Any_c0 | BIC_GFX_c0 | BIC_CPUGFX | BIC_SAM_mc6 | BIC_Diec6)
 #define BIC_OTHER (BIC_IRQ | BIC_NMI | BIC_SMI | BIC_ThreadC | BIC_CoreTmp | BIC_IPC)
 
 #define BIC_DISABLED_BY_DEFAULT	(BIC_USEC | BIC_TOD | BIC_APIC | BIC_X2APIC)
@@ -2354,16 +2354,16 @@ unsigned long long bic_lookup(char *name_list, enum show_hide_mode mode)
 				retval |= ~0;
 				break;
 			} else if (!strcmp(name_list, "topology")) {
-				retval |= BIC_TOPOLOGY;
+				retval |= BIC_GROUP_TOPOLOGY;
 				break;
 			} else if (!strcmp(name_list, "power")) {
-				retval |= BIC_THERMAL_PWR;
+				retval |= BIC_GROUP_THERMAL_PWR;
 				break;
 			} else if (!strcmp(name_list, "idle")) {
-				retval |= BIC_IDLE;
+				retval |= BIC_GROUP_IDLE;
 				break;
 			} else if (!strcmp(name_list, "frequency")) {
-				retval |= BIC_FREQUENCY;
+				retval |= BIC_GROUP_FREQUENCY;
 				break;
 			} else if (!strcmp(name_list, "other")) {
 				retval |= BIC_OTHER;
@@ -10260,7 +10260,7 @@ int is_deferred_skip(char *name)
 	return 0;
 }
 
-void probe_sysfs(void)
+void probe_cpuidle_residency(void)
 {
 	char path[64];
 	char name_buf[16];
@@ -10304,6 +10304,16 @@ void probe_sysfs(void)
 		if (state < min_state)
 			min_state = state;
 	}
+}
+
+void probe_cpuidle_counts(void)
+{
+	char path[64];
+	char name_buf[16];
+	FILE *input;
+	int state;
+	int min_state = 1024, max_state = 0;
+	char *sp;
 
 	for (state = 10; state >= 0; --state) {
 
@@ -10602,7 +10612,8 @@ int main(int argc, char **argv)
 		print_bootcmd();
 	}
 
-	probe_sysfs();
+	probe_cpuidle_residency();
+	probe_cpuidle_counts();
 
 	if (!getuid())
 		set_rlimit();
-- 
2.45.2


