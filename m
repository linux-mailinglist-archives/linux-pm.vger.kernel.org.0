Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 896DF44E5C5
	for <lists+linux-pm@lfdr.de>; Fri, 12 Nov 2021 12:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234728AbhKLL4I (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Nov 2021 06:56:08 -0500
Received: from mga02.intel.com ([134.134.136.20]:22763 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234666AbhKLL4H (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 12 Nov 2021 06:56:07 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10165"; a="220329825"
X-IronPort-AV: E=Sophos;i="5.87,229,1631602800"; 
   d="scan'208";a="220329825"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2021 03:53:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,229,1631602800"; 
   d="scan'208";a="492976295"
Received: from chenyu-desktop.sh.intel.com ([10.239.158.186])
  by orsmga007.jf.intel.com with ESMTP; 12 Nov 2021 03:53:14 -0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     linux-pm@vger.kernel.org, Len Brown <lenb@kernel.org>
Cc:     Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org,
        Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 1/2] tools/power turbostat: Support thermal throttle count print
Date:   Fri, 12 Nov 2021 19:51:59 +0800
Message-Id: <20211112115159.725357-1-yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The turbostat data is collected by end user for power evaluationit. However
it looks like we are missing enough thermal context there. Already a couple of
time we found that power management developer asking something like this:
grep -r . /sys/devices/system/cpu/cpu*/thermal_throttle/*

Print the per core thermal throttle count so as to get suffificent thermal
context.

turbostat -i 5 -s Core,CPU,CoreThr
Core	CPU	CoreThr
-	-	104
0	0	61
0	4
1	1	0
1	5
2	2	104
2	6
3	3	7
3	7

Suggested-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 43 +++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 47d3ba895d6d..b7908f1ee969 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -205,6 +205,7 @@ struct core_data {
 	unsigned int core_temp_c;
 	unsigned int core_energy;	/* MSR_CORE_ENERGY_STAT */
 	unsigned int core_id;
+	unsigned long long core_throt_cnt;
 	unsigned long long counter[MAX_ADDED_COUNTERS];
 } *core_even, *core_odd;
 
@@ -610,6 +611,7 @@ struct msr_counter bic[] = {
 	{ 0x0, "Die" },
 	{ 0x0, "GFXAMHz" },
 	{ 0x0, "IPC" },
+	{ 0x0, "CoreThr" },
 };
 
 #define MAX_BIC (sizeof(bic) / sizeof(struct msr_counter))
@@ -666,6 +668,7 @@ struct msr_counter bic[] = {
 #define	BIC_Die		(1ULL << 50)
 #define	BIC_GFXACTMHz	(1ULL << 51)
 #define	BIC_IPC		(1ULL << 52)
+#define	BIC_CORE_THROT_CNT	(1ULL << 53)
 
 #define BIC_TOPOLOGY (BIC_Package | BIC_Node | BIC_CoreCnt | BIC_PkgCnt | BIC_Core | BIC_CPU | BIC_Die )
 #define BIC_THERMAL_PWR ( BIC_CoreTmp | BIC_PkgTmp | BIC_PkgWatt | BIC_CorWatt | BIC_GFXWatt | BIC_RAMWatt | BIC_PKG__ | BIC_RAM__)
@@ -872,6 +875,9 @@ void print_header(char *delim)
 	if (DO_BIC(BIC_CoreTmp))
 		outp += sprintf(outp, "%sCoreTmp", (printed++ ? delim : ""));
 
+	if (DO_BIC(BIC_CORE_THROT_CNT))
+		outp += sprintf(outp, "%sCoreThr", (printed++ ? delim : ""));
+
 	if (do_rapl && !rapl_joules) {
 		if (DO_BIC(BIC_CorWatt) && (do_rapl & RAPL_PER_CORE_ENERGY))
 			outp += sprintf(outp, "%sCorWatt", (printed++ ? delim : ""));
@@ -1011,6 +1017,7 @@ int dump_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p
 		outp += sprintf(outp, "c6: %016llX\n", c->c6);
 		outp += sprintf(outp, "c7: %016llX\n", c->c7);
 		outp += sprintf(outp, "DTS: %dC\n", c->core_temp_c);
+		outp += sprintf(outp, "cpu_throt_count: %016llX\n", c->core_throt_cnt);
 		outp += sprintf(outp, "Joules: %0X\n", c->core_energy);
 
 		for (i = 0, mp = sys.cp; mp; i++, mp = mp->next) {
@@ -1225,6 +1232,10 @@ int format_counters(struct thread_data *t, struct core_data *c, struct pkg_data
 	if (DO_BIC(BIC_CoreTmp))
 		outp += sprintf(outp, "%s%d", (printed++ ? delim : ""), c->core_temp_c);
 
+	/* Core throttle count */
+	if (DO_BIC(BIC_CORE_THROT_CNT))
+		outp += sprintf(outp, "%s%lld", (printed++ ? delim : ""), c->core_throt_cnt);
+
 	for (i = 0, mp = sys.cp; mp; i++, mp = mp->next) {
 		if (mp->format == FORMAT_RAW) {
 			if (mp->width == 32)
@@ -1311,6 +1322,7 @@ int format_counters(struct thread_data *t, struct core_data *c, struct pkg_data
 	if (DO_BIC(BIC_PkgWatt))
 		outp +=
 		    sprintf(outp, fmt8, (printed++ ? delim : ""), p->energy_pkg * rapl_energy_units / interval_float);
+
 	if (DO_BIC(BIC_CorWatt) && !(do_rapl & RAPL_PER_CORE_ENERGY))
 		outp +=
 		    sprintf(outp, fmt8, (printed++ ? delim : ""), p->energy_cores * rapl_energy_units / interval_float);
@@ -1467,6 +1479,7 @@ void delta_core(struct core_data *new, struct core_data *old)
 	old->c6 = new->c6 - old->c6;
 	old->c7 = new->c7 - old->c7;
 	old->core_temp_c = new->core_temp_c;
+	old->core_throt_cnt = new->core_throt_cnt;
 	old->mc6_us = new->mc6_us - old->mc6_us;
 
 	DELTA_WRAP32(new->core_energy, old->core_energy);
@@ -1626,6 +1639,7 @@ void clear_counters(struct thread_data *t, struct core_data *c, struct pkg_data
 	c->mc6_us = 0;
 	c->core_temp_c = 0;
 	c->core_energy = 0;
+	c->core_throt_cnt = 0;
 
 	p->pkg_wtd_core_c0 = 0;
 	p->pkg_any_core_c0 = 0;
@@ -1710,6 +1724,7 @@ int sum_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 	average.cores.mc6_us += c->mc6_us;
 
 	average.cores.core_temp_c = MAX(average.cores.core_temp_c, c->core_temp_c);
+	average.cores.core_throt_cnt = MAX(average.cores.core_throt_cnt, c->core_throt_cnt);
 
 	average.cores.core_energy += c->core_energy;
 
@@ -1987,6 +2002,26 @@ void get_apic_id(struct thread_data *t)
 		fprintf(outf, "cpu%d: BIOS BUG: apic 0x%x x2apic 0x%x\n", t->cpu_id, t->apic_id, t->x2apic_id);
 }
 
+int get_core_throt_cnt(int cpu, unsigned long long *cnt)
+{
+	char path[128 + PATH_BYTES];
+	unsigned long long tmp;
+	FILE *fp;
+	int ret;
+
+	sprintf(path, "/sys/devices/system/cpu/cpu%d/thermal_throttle/core_throttle_count", cpu);
+	fp = fopen(path, "r");
+	if (!fp)
+		return -1;
+	ret = fscanf(fp, "%lld", &tmp);
+	if (ret != 1)
+		return -1;
+	fclose(fp);
+	*cnt = tmp;
+
+	return 0;
+}
+
 /*
  * get_counters(...)
  * migrate to cpu
@@ -2129,6 +2164,9 @@ int get_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 		c->core_temp_c = tj_max - ((msr >> 16) & 0x7F);
 	}
 
+	if (DO_BIC(BIC_CORE_THROT_CNT))
+		get_core_throt_cnt(cpu, &c->core_throt_cnt);
+
 	if (do_rapl & RAPL_AMD_F17H) {
 		if (get_msr(cpu, MSR_CORE_ENERGY_STAT, &msr))
 			return -14;
@@ -5572,6 +5610,11 @@ void process_cpuid()
 	else
 		BIC_NOT_PRESENT(BIC_CPU_LPI);
 
+	if (!access("/sys/devices/system/cpu/cpu0/thermal_throttle/core_throttle_count", R_OK))
+		BIC_PRESENT(BIC_CORE_THROT_CNT);
+	else
+		BIC_NOT_PRESENT(BIC_CORE_THROT_CNT);
+
 	if (!access(sys_lpi_file_sysfs, R_OK)) {
 		sys_lpi_file = sys_lpi_file_sysfs;
 		BIC_PRESENT(BIC_SYS_LPI);
-- 
2.25.1

