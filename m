Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5241B4FC2
	for <lists+linux-pm@lfdr.de>; Thu, 23 Apr 2020 00:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725839AbgDVWCJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Apr 2020 18:02:09 -0400
Received: from mga01.intel.com ([192.55.52.88]:59118 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbgDVWCJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 22 Apr 2020 18:02:09 -0400
IronPort-SDR: ck6HmqzW+kZIYYEyN1ZA6Q64uu0f9IjCm1jVR6PaQFBJ2EJStHCCJyfk4meoqbfB9FnJKldtdc
 nRZzMbSlIE9g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2020 15:02:07 -0700
IronPort-SDR: QAHe3goTvsHaS/dNWZEA1KO17U43CpqWo/UF2tIUv5BXu9FbZTdOkl39pqUAJXtTdkdMbhJLe9
 gWZB7vh1OdqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,304,1583222400"; 
   d="scan'208";a="290982812"
Received: from njamal-mobl.amr.corp.intel.com (HELO rantogno-mobl3.intel.com) ([10.251.145.212])
  by fmsmga002.fm.intel.com with ESMTP; 22 Apr 2020 15:02:07 -0700
From:   Rafael Antognolli <rafael.antognolli@intel.com>
To:     linux-pm@vger.kernel.org
Subject: [PATCH 1/1] turbostat: Add a new GFXAMHz column that exposes gt_act_freq_mhz.
Date:   Wed, 22 Apr 2020 15:02:07 -0700
Message-Id: <20200422220207.17425-2-rafael.antognolli@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422220207.17425-1-rafael.antognolli@intel.com>
References: <20200422220207.17425-1-rafael.antognolli@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The column already present called GFXMHz reads from gt_cur_freq_mhz,
which represents the GT frequency that was requested, but power
management might not be able to do that. So the new column will display
what the actual frequency GT is running at.

Signed-off-by: Rafael Antognolli <rafael.antognolli@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 50 +++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 33b370865d16..d2adc633a71d 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -79,6 +79,7 @@ unsigned long long  gfx_cur_rc6_ms;
 unsigned long long cpuidle_cur_cpu_lpi_us;
 unsigned long long cpuidle_cur_sys_lpi_us;
 unsigned int gfx_cur_mhz;
+unsigned int gfx_act_mhz;
 unsigned int tcc_activation_temp;
 unsigned int tcc_activation_temp_override;
 double rapl_power_units, rapl_time_units;
@@ -210,6 +211,7 @@ struct pkg_data {
 	unsigned long long pkg_both_core_gfxe_c0;
 	long long gfx_rc6_ms;
 	unsigned int gfx_mhz;
+	unsigned int gfx_act_mhz;
 	unsigned int package_id;
 	unsigned int energy_pkg;	/* MSR_PKG_ENERGY_STATUS */
 	unsigned int energy_dram;	/* MSR_DRAM_ENERGY_STATUS */
@@ -451,6 +453,7 @@ struct msr_counter bic[] = {
 	{ 0x0, "APIC" },
 	{ 0x0, "X2APIC" },
 	{ 0x0, "Die" },
+	{ 0x0, "GFXAMHz" },
 };
 
 #define MAX_BIC (sizeof(bic) / sizeof(struct msr_counter))
@@ -505,6 +508,7 @@ struct msr_counter bic[] = {
 #define	BIC_APIC	(1ULL << 48)
 #define	BIC_X2APIC	(1ULL << 49)
 #define	BIC_Die		(1ULL << 50)
+#define	BIC_GFXACTMHz	(1ULL << 51)
 
 #define BIC_DISABLED_BY_DEFAULT	(BIC_USEC | BIC_TOD | BIC_APIC | BIC_X2APIC)
 
@@ -724,6 +728,9 @@ void print_header(char *delim)
 	if (DO_BIC(BIC_GFXMHz))
 		outp += sprintf(outp, "%sGFXMHz", (printed++ ? delim : ""));
 
+	if (DO_BIC(BIC_GFXACTMHz))
+		outp += sprintf(outp, "%sGFXAMHz", (printed++ ? delim : ""));
+
 	if (DO_BIC(BIC_Totl_c0))
 		outp += sprintf(outp, "%sTotl%%C0", (printed++ ? delim : ""));
 	if (DO_BIC(BIC_Any_c0))
@@ -1098,6 +1105,10 @@ int format_counters(struct thread_data *t, struct core_data *c,
 	if (DO_BIC(BIC_GFXMHz))
 		outp += sprintf(outp, "%s%d", (printed++ ? delim : ""), p->gfx_mhz);
 
+	/* GFXACTMHz */
+	if (DO_BIC(BIC_GFXACTMHz))
+		outp += sprintf(outp, "%s%d", (printed++ ? delim : ""), p->gfx_act_mhz);
+
 	/* Totl%C0, Any%C0 GFX%C0 CPUGFX% */
 	if (DO_BIC(BIC_Totl_c0))
 		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->pkg_wtd_core_c0/tsc);
@@ -1253,6 +1264,7 @@ delta_package(struct pkg_data *new, struct pkg_data *old)
 		old->gfx_rc6_ms = new->gfx_rc6_ms - old->gfx_rc6_ms;
 
 	old->gfx_mhz = new->gfx_mhz;
+	old->gfx_act_mhz = new->gfx_act_mhz;
 
 	DELTA_WRAP32(new->energy_pkg, old->energy_pkg);
 	DELTA_WRAP32(new->energy_cores, old->energy_cores);
@@ -1469,6 +1481,7 @@ void clear_counters(struct thread_data *t, struct core_data *c, struct pkg_data
 
 	p->gfx_rc6_ms = 0;
 	p->gfx_mhz = 0;
+	p->gfx_act_mhz = 0;
 	for (i = 0, mp = sys.tp; mp; i++, mp = mp->next)
 		t->counter[i] = 0;
 
@@ -1564,6 +1577,7 @@ int sum_counters(struct thread_data *t, struct core_data *c,
 
 	average.packages.gfx_rc6_ms = p->gfx_rc6_ms;
 	average.packages.gfx_mhz = p->gfx_mhz;
+	average.packages.gfx_act_mhz = p->gfx_act_mhz;
 
 	average.packages.pkg_temp_c = MAX(average.packages.pkg_temp_c, p->pkg_temp_c);
 
@@ -2012,6 +2026,9 @@ int get_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 	if (DO_BIC(BIC_GFXMHz))
 		p->gfx_mhz = gfx_cur_mhz;
 
+	if (DO_BIC(BIC_GFXACTMHz))
+		p->gfx_act_mhz = gfx_act_mhz;
+
 	for (i = 0, mp = sys.pp; mp; i++, mp = mp->next) {
 		if (get_mp(cpu, mp, &p->counter[i]))
 			return -10;
@@ -2915,6 +2932,33 @@ int snapshot_gfx_mhz(void)
 	return 0;
 }
 
+/*
+ * snapshot_gfx_cur_mhz()
+ *
+ * record snapshot of
+ * /sys/class/graphics/fb0/device/drm/card0/gt_act_freq_mhz
+ *
+ * return 1 if config change requires a restart, else return 0
+ */
+int snapshot_gfx_act_mhz(void)
+{
+	static FILE *fp;
+	int retval;
+
+	if (fp == NULL)
+		fp = fopen_or_die("/sys/class/graphics/fb0/device/drm/card0/gt_act_freq_mhz", "r");
+	else {
+		rewind(fp);
+		fflush(fp);
+	}
+
+	retval = fscanf(fp, "%d", &gfx_act_mhz);
+	if (retval != 1)
+		err(1, "GFX ACT MHz");
+
+	return 0;
+}
+
 /*
  * snapshot_cpu_lpi()
  *
@@ -2980,6 +3024,9 @@ int snapshot_proc_sysfs_files(void)
 	if (DO_BIC(BIC_GFXMHz))
 		snapshot_gfx_mhz();
 
+	if (DO_BIC(BIC_GFXACTMHz))
+		snapshot_gfx_act_mhz();
+
 	if (DO_BIC(BIC_CPU_LPI))
 		snapshot_cpu_lpi_us();
 
@@ -4980,6 +5027,9 @@ void process_cpuid()
 	if (!access("/sys/class/graphics/fb0/device/drm/card0/gt_cur_freq_mhz", R_OK))
 		BIC_PRESENT(BIC_GFXMHz);
 
+	if (!access("/sys/class/graphics/fb0/device/drm/card0/gt_act_freq_mhz", R_OK))
+		BIC_PRESENT(BIC_GFXACTMHz);
+
 	if (!access("/sys/devices/system/cpu/cpuidle/low_power_idle_cpu_residency_us", R_OK))
 		BIC_PRESENT(BIC_CPU_LPI);
 	else
-- 
2.26.2

