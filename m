Return-Path: <linux-pm+bounces-24861-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E00A7CFDC
	for <lists+linux-pm@lfdr.de>; Sun,  6 Apr 2025 20:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DE23188924B
	for <lists+linux-pm@lfdr.de>; Sun,  6 Apr 2025 18:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3FD1AA1E0;
	Sun,  6 Apr 2025 18:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NOCepBxi"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FA61A9B5B
	for <linux-pm@vger.kernel.org>; Sun,  6 Apr 2025 18:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743965913; cv=none; b=LdKtWfXH7qcm4HdIkq/znjYAz7c1zSVDh2mUYwPOyMJZMSKOTNClH4fIYnksjNiuz9CMzIbhDlohORH60ZmEJytT6Gv3meqNWLBN6vgfnW2OPsHxfHRhuW+tse2lPFN+tYUf0mKSDNiZXg7ID7rMqmjYpL0FiJCGSnc0/aO9y5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743965913; c=relaxed/simple;
	bh=3e0FlyM0W2Z2jhqUPcjwaLhkDQi2aqZtdh5W6JoljNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=boeqd+79KdIasZwn+aAyY2H9DJwB8mW/AeIZKH/5z4fxbUc74O3Xn/i6CZwD9fSwip+UEpqD/mCGQKe8bpcOWfRaLNWJUCwzAk6ll9gTPwyGg5vQ45KIO9uPjxsnt9RHRPb9mKID/PjnqMtirkbTlc6VMlkaenRylszjdxv+8Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NOCepBxi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B64D3C4CEE7;
	Sun,  6 Apr 2025 18:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743965913;
	bh=3e0FlyM0W2Z2jhqUPcjwaLhkDQi2aqZtdh5W6JoljNc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=NOCepBxiOqmy7Xr2BXa4+Tl7Jf2rmpXrIo6AnRmq515oFupSQDVBkTiJFYEw3f9kq
	 WJjinrzMZ6TKPnxYUt5Rs6hfDAIgC9s9P6nJTebMIz3XhBbPVe5cvkXFZLCW2AZKPB
	 aReguf8GjIyaxMB4LpVBCcQ2C8FjrZc1a3W8ltSysFoJ35w6qcIz6Uau5bF0rZd7uJ
	 znqN6oEHMEBRQAq52YfPLGAOeslhDK7B7bwMYLVm9aRi17pK+vaz7OTfuQz2Am5aJB
	 aMIcp2x72zfc1mqW1VweBeZWVmltc666aDsPbq+vHD5xno3epEW3xElwgLQcD40CTI
	 eI+bAwD9NINog==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 10/10] tools/power turbostat: disable "cpuidle" invocation counters, by default
Date: Sun,  6 Apr 2025 14:57:19 -0400
Message-ID: <ec4acd3166d8a7a03b059d01b9c6f11a658e833f.1743965272.git.len.brown@intel.com>
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

Create "pct_idle" counter group, the sofware notion of residency
so it can now be singled out, independent of other counter groups.

Create "cpuidle" group, the cpuidle invocation counts.
Disable "cpuidle", by default.

Create "swidle" = "cpuidle" + "pct_idle".
Undocument "sysfs", the old name for "swidle", but keep it working
for backwards compatibilty.

Create "hwidle", all the HW idle counters

Modify "idle", enabled by default
"idle" = "hwidle" + "pct_idle" (and now excludes "cpuidle")

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.8 | 12 +++++-----
 tools/power/x86/turbostat/turbostat.c | 34 +++++++++++++++++++++------
 2 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.8 b/tools/power/x86/turbostat/turbostat.8
index e86493880c16..b74ed916057e 100644
--- a/tools/power/x86/turbostat/turbostat.8
+++ b/tools/power/x86/turbostat/turbostat.8
@@ -100,7 +100,7 @@ The column name "all" can be used to enable all disabled-by-default built-in cou
 .PP
 \fB--show column\fP show only the specified built-in columns.  May be invoked multiple times, or with a comma-separated list of column names.
 .PP
-\fB--show CATEGORY --hide CATEGORY\fP  Show and hide also accept a single CATEGORY of columns: "all", "topology", "idle", "frequency", "power", "sysfs", "other".
+\fB--show CATEGORY --hide CATEGORY\fP  Show and hide also accept a single CATEGORY of columns: "all", "topology", "idle", "frequency", "power", "cpuidle", "hwidle", "swidle", "other".  "idle" (enabled by default), includes "hwidle" and "idle_pct".  "cpuidle" (default disabled) includes cpuidle software invocation counters.  "swidle" includes "cpuidle" plus "idle_pct".  "hwidle" includes only hardware based idle residency counters.  Older versions of turbostat used the term "sysfs" for what is now "swidle".
 .PP
 \fB--Dump\fP displays the raw counter values.
 .PP
@@ -158,15 +158,15 @@ The system configuration dump (if --quiet is not used) is followed by statistics
 .PP
 \fBSMI\fP The number of System Management Interrupts  serviced CPU during the measurement interval.  While this counter is actually per-CPU, SMI are triggered on all processors, so the number should be the same for all CPUs.
 .PP
-\fBC1, C2, C3...\fP The number times Linux requested the C1, C2, C3 idle state during the measurement interval.  The system summary line shows the sum for all CPUs.  These are C-state names as exported in /sys/devices/system/cpu/cpu*/cpuidle/state*/name.  While their names are generic, their attributes are processor specific. They the system description section of output shows what MWAIT sub-states they are mapped to on each system.
+\fBC1, C2, C3...\fP The number times Linux requested the C1, C2, C3 idle state during the measurement interval.  The system summary line shows the sum for all CPUs.  These are C-state names as exported in /sys/devices/system/cpu/cpu*/cpuidle/state*/name.  While their names are generic, their attributes are processor specific. They the system description section of output shows what MWAIT sub-states they are mapped to on each system.  These counters are in the "cpuidle" group, which is disabled, by default.
 .PP
-\fBC1+, C2+, C3+...\fP The idle governor idle state misprediction statistics. Inidcates the number times Linux requested the C1, C2, C3 idle state during the measurement interval, but should have requested a deeper idle state (if it exists and enabled). These statistics come from the /sys/devices/system/cpu/cpu*/cpuidle/state*/below file.
+\fBC1+, C2+, C3+...\fP The idle governor idle state misprediction statistics. Inidcates the number times Linux requested the C1, C2, C3 idle state during the measurement interval, but should have requested a deeper idle state (if it exists and enabled). These statistics come from the /sys/devices/system/cpu/cpu*/cpuidle/state*/below file.  These counters are in the "cpuidle" group, which is disabled, by default.
 .PP
-\fBC1-, C2-, C3-...\fP The idle governor idle state misprediction statistics. Inidcates the number times Linux requested the C1, C2, C3 idle state during the measurement interval, but should have requested a shallower idle state (if it exists and enabled). These statistics come from the /sys/devices/system/cpu/cpu*/cpuidle/state*/above file.
+\fBC1-, C2-, C3-...\fP The idle governor idle state misprediction statistics. Inidcates the number times Linux requested the C1, C2, C3 idle state during the measurement interval, but should have requested a shallower idle state (if it exists and enabled). These statistics come from the /sys/devices/system/cpu/cpu*/cpuidle/state*/above file.  These counters are in the "cpuidle" group, which is disabled, by default.
 .PP
-\fBC1%, C2%, C3%\fP The residency percentage that Linux requested C1, C2, C3....  The system summary is the average of all CPUs in the system.  Note that these are software, reflecting what was requested.  The hardware counters reflect what was actually achieved.
+\fBC1%, C2%, C3%\fP The residency percentage that Linux requested C1, C2, C3....  The system summary is the average of all CPUs in the system.  Note that these are software, reflecting what was requested.  The hardware counters reflect what was actually achieved.  These counters are in the "pct_idle" group, which is enabled by default.
 .PP
-\fBCPU%c1, CPU%c3, CPU%c6, CPU%c7\fP show the percentage residency in hardware core idle states.  These numbers are from hardware residency counters.
+\fBCPU%c1, CPU%c3, CPU%c6, CPU%c7\fP show the percentage residency in hardware core idle states.  These numbers are from hardware residency counters and are in the "hwidle" group, which is enabled, by default.
 .PP
 \fBCoreTmp\fP Degrees Celsius reported by the per-core Digital Thermal Sensor.
 .PP
diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index df0391bedcde..ab184f95cdaf 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -153,7 +153,7 @@ struct msr_counter bic[] = {
 	{ 0x0, "TSC_MHz", NULL, 0, 0, 0, NULL, 0 },
 	{ 0x0, "IRQ", NULL, 0, 0, 0, NULL, 0 },
 	{ 0x0, "SMI", NULL, 32, 0, FORMAT_DELTA, NULL, 0 },
-	{ 0x0, "sysfs", NULL, 0, 0, 0, NULL, 0 },
+	{ 0x0, "cpuidle", NULL, 0, 0, 0, NULL, 0 },
 	{ 0x0, "CPU%c1", NULL, 0, 0, 0, NULL, 0 },
 	{ 0x0, "CPU%c3", NULL, 0, 0, 0, NULL, 0 },
 	{ 0x0, "CPU%c6", NULL, 0, 0, 0, NULL, 0 },
@@ -206,6 +206,7 @@ struct msr_counter bic[] = {
 	{ 0x0, "Sys_J", NULL, 0, 0, 0, NULL, 0 },
 	{ 0x0, "NMI", NULL, 0, 0, 0, NULL, 0 },
 	{ 0x0, "CPU%c1e", NULL, 0, 0, 0, NULL, 0 },
+	{ 0x0, "pct_idle", NULL, 0, 0, 0, NULL, 0 },
 };
 
 #define MAX_BIC (sizeof(bic) / sizeof(struct msr_counter))
@@ -219,7 +220,7 @@ struct msr_counter bic[] = {
 #define	BIC_TSC_MHz	(1ULL << 7)
 #define	BIC_IRQ		(1ULL << 8)
 #define	BIC_SMI		(1ULL << 9)
-#define	BIC_sysfs	(1ULL << 10)
+#define	BIC_cpuidle	(1ULL << 10)
 #define	BIC_CPU_c1	(1ULL << 11)
 #define	BIC_CPU_c3	(1ULL << 12)
 #define	BIC_CPU_c6	(1ULL << 13)
@@ -272,17 +273,20 @@ struct msr_counter bic[] = {
 #define	BIC_Sys_J		(1ULL << 60)
 #define	BIC_NMI			(1ULL << 61)
 #define	BIC_CPU_c1e		(1ULL << 62)
+#define	BIC_pct_idle		(1ULL << 63)
 
 #define BIC_GROUP_TOPOLOGY (BIC_Package | BIC_Node | BIC_CoreCnt | BIC_PkgCnt | BIC_Core | BIC_CPU | BIC_Die)
 #define BIC_GROUP_THERMAL_PWR (BIC_CoreTmp | BIC_PkgTmp | BIC_PkgWatt | BIC_CorWatt | BIC_GFXWatt | BIC_RAMWatt | BIC_PKG__ | BIC_RAM__ | BIC_SysWatt)
 #define BIC_GROUP_FREQUENCY (BIC_Avg_MHz | BIC_Busy | BIC_Bzy_MHz | BIC_TSC_MHz | BIC_GFXMHz | BIC_GFXACTMHz | BIC_SAMMHz | BIC_SAMACTMHz | BIC_UNCORE_MHZ)
-#define BIC_GROUP_IDLE (BIC_Busy | BIC_sysfs | BIC_CPU_c1 | BIC_CPU_c3 | BIC_CPU_c6 | BIC_CPU_c7 | BIC_GFX_rc6 | BIC_Pkgpc2 | BIC_Pkgpc3 | BIC_Pkgpc6 | BIC_Pkgpc7 | BIC_Pkgpc8 | BIC_Pkgpc9 | BIC_Pkgpc10 | BIC_CPU_LPI | BIC_SYS_LPI | BIC_Mod_c6 | BIC_Totl_c0 | BIC_Any_c0 | BIC_GFX_c0 | BIC_CPUGFX | BIC_SAM_mc6 | BIC_Diec6)
+#define BIC_GROUP_HW_IDLE (BIC_Busy | BIC_CPU_c1 | BIC_CPU_c3 | BIC_CPU_c6 | BIC_CPU_c7 | BIC_GFX_rc6 | BIC_Pkgpc2 | BIC_Pkgpc3 | BIC_Pkgpc6 | BIC_Pkgpc7 | BIC_Pkgpc8 | BIC_Pkgpc9 | BIC_Pkgpc10 | BIC_CPU_LPI | BIC_SYS_LPI | BIC_Mod_c6 | BIC_Totl_c0 | BIC_Any_c0 | BIC_GFX_c0 | BIC_CPUGFX | BIC_SAM_mc6 | BIC_Diec6)
+#define BIC_GROUP_SW_IDLE (BIC_Busy | BIC_cpuidle | BIC_pct_idle )
+#define BIC_GROUP_IDLE (BIC_GROUP_HW_IDLE | BIC_pct_idle) 
 #define BIC_OTHER (BIC_IRQ | BIC_NMI | BIC_SMI | BIC_ThreadC | BIC_CoreTmp | BIC_IPC)
 
-#define BIC_DISABLED_BY_DEFAULT	(BIC_USEC | BIC_TOD | BIC_APIC | BIC_X2APIC)
+#define BIC_DISABLED_BY_DEFAULT	(BIC_USEC | BIC_TOD | BIC_APIC | BIC_X2APIC | BIC_cpuidle)
 
 unsigned long long bic_enabled = (0xFFFFFFFFFFFFFFFFULL & ~BIC_DISABLED_BY_DEFAULT);
-unsigned long long bic_present = BIC_USEC | BIC_TOD | BIC_sysfs | BIC_APIC | BIC_X2APIC;
+unsigned long long bic_present = BIC_USEC | BIC_TOD | BIC_cpuidle | BIC_pct_idle | BIC_APIC | BIC_X2APIC;
 
 #define DO_BIC(COUNTER_NAME) (bic_enabled & bic_present & COUNTER_NAME)
 #define DO_BIC_READ(COUNTER_NAME) (bic_present & COUNTER_NAME)
@@ -2362,6 +2366,15 @@ unsigned long long bic_lookup(char *name_list, enum show_hide_mode mode)
 			} else if (!strcmp(name_list, "idle")) {
 				retval |= BIC_GROUP_IDLE;
 				break;
+			} else if (!strcmp(name_list, "swidle")) {
+				retval |= BIC_GROUP_SW_IDLE;
+				break;
+			} else if (!strcmp(name_list, "sysfs")) {	/* legacy compatibility */
+				retval |= BIC_GROUP_SW_IDLE;
+				break;
+			} else if (!strcmp(name_list, "hwidle")) {
+				retval |= BIC_GROUP_HW_IDLE;
+				break;
 			} else if (!strcmp(name_list, "frequency")) {
 				retval |= BIC_GROUP_FREQUENCY;
 				break;
@@ -2372,6 +2385,7 @@ unsigned long long bic_lookup(char *name_list, enum show_hide_mode mode)
 
 		}
 		if (i == MAX_BIC) {
+			fprintf(stderr, "deferred %s\n", name_list);
 			if (mode == SHOW_LIST) {
 				deferred_add_names[deferred_add_index++] = name_list;
 				if (deferred_add_index >= MAX_DEFERRED) {
@@ -10269,6 +10283,9 @@ void probe_cpuidle_residency(void)
 	int min_state = 1024, max_state = 0;
 	char *sp;
 
+	if (!DO_BIC(BIC_pct_idle))
+		return;
+
 	for (state = 10; state >= 0; --state) {
 
 		sprintf(path, "/sys/devices/system/cpu/cpu%d/cpuidle/state%d/name", base_cpu, state);
@@ -10291,7 +10308,7 @@ void probe_cpuidle_residency(void)
 
 		sprintf(path, "cpuidle/state%d/time", state);
 
-		if (!DO_BIC(BIC_sysfs) && !is_deferred_add(name_buf))
+		if (!DO_BIC(BIC_pct_idle) && !is_deferred_add(name_buf))
 			continue;
 
 		if (is_deferred_skip(name_buf))
@@ -10315,6 +10332,9 @@ void probe_cpuidle_counts(void)
 	int min_state = 1024, max_state = 0;
 	char *sp;
 
+	if (!DO_BIC(BIC_cpuidle))
+		return;
+
 	for (state = 10; state >= 0; --state) {
 
 		sprintf(path, "/sys/devices/system/cpu/cpu%d/cpuidle/state%d/name", base_cpu, state);
@@ -10327,7 +10347,7 @@ void probe_cpuidle_counts(void)
 
 		remove_underbar(name_buf);
 
-		if (!DO_BIC(BIC_sysfs) && !is_deferred_add(name_buf))
+		if (!DO_BIC(BIC_cpuidle) && !is_deferred_add(name_buf))
 			continue;
 
 		if (is_deferred_skip(name_buf))
-- 
2.45.2


