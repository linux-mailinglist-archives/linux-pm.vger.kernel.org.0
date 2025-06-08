Return-Path: <linux-pm+bounces-28243-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8515AD13B9
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 20:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59B5C169093
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 18:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35A81DB346;
	Sun,  8 Jun 2025 18:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="szaYqb0M"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F34D1D9A5D
	for <linux-pm@vger.kernel.org>; Sun,  8 Jun 2025 18:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749406744; cv=none; b=dgvj4jFfG8YG5/yuwoVoKIT89DlkXxUdcagaf1MNJ9/oTLKLXjPqnd1ThGXSLLu9Uhct1pAKSMpOXCE2jtGsHKt+98Z0ygpKi0p9D9a6jLGij4qQqAFWWA7/zSvrg643WegxZ6N7omqW1pl4dv8TAFukZ/mEGZKc69PbE7pNSIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749406744; c=relaxed/simple;
	bh=dhKZXh3UvyCJg6lVLdXV+DpeISLhXwrODuJPquMoqrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zo1X074VdrRlwja0kIgX6+rD+ZX7A+XSy1mPrWUbtm6Oc65R/+nSIgS/kD7Fay4g1Kbu24FFXkCu7HUJ8vF3cTo/ZSVwPUA3/OvXbF/elseUg9YfpKdzyk+LWGfL5Qym/p2hqjE59OD0nQCX8j0ETk3umIx+qerTVhi9PqZJjVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=szaYqb0M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5E51C4CEF5;
	Sun,  8 Jun 2025 18:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749406744;
	bh=dhKZXh3UvyCJg6lVLdXV+DpeISLhXwrODuJPquMoqrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=szaYqb0Mz9Yfeqe0yslmioyHZvscefiYrd35oTJ2ixoPM4WjeqemKWR0zvw/hTBBE
	 cEZZvw/kWVJM9vM7zm+TQUlMxUZdRURs1iqG/js8gjfxHTdA2rOv6yIQnl/8tK4oZq
	 RJoc9wdb9usdtWDVtPprMLYk5uz2gEOWlOzLUfAheQheULOwxHXsLnFowSH+sENVM5
	 rEK1c6c2+JfOV4x+bdatSo9nFdJ/ddRg7f++NIGRCqDqxNtj0PPHTzOqgnHQZQPmSm
	 /MEQvGrnssCrOrG3e1wXub40wBwqIiWcCOrwcdPlVr2q0Hc7rqVtpzMgjY4HA2yD29
	 RKYsvI6h6bpPA==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 18/18] tools/power turbostat: version 2025.06.08
Date: Sun,  8 Jun 2025 14:17:17 -0400
Message-ID: <f7edc3f645d990a8e6708439258a56b9df191077.1749406068.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <780da8a9557f2d114aaffda0eb0a517fe6a244c8.1749406068.git.len.brown@intel.com>
References: <780da8a9557f2d114aaffda0eb0a517fe6a244c8.1749406068.git.len.brown@intel.com>
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

Add initial DMR support, which required smarter RAPL probe
Fix AMD MSR RAPL energy reporting
Add RAPL power limit configuration output
Minor fixes

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 73 +++++++++++++--------------
 1 file changed, 36 insertions(+), 37 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index db0134adc8ce..5230e072e414 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -280,7 +280,7 @@ struct msr_counter bic[] = {
 #define BIC_GROUP_FREQUENCY (BIC_Avg_MHz | BIC_Busy | BIC_Bzy_MHz | BIC_TSC_MHz | BIC_GFXMHz | BIC_GFXACTMHz | BIC_SAMMHz | BIC_SAMACTMHz | BIC_UNCORE_MHZ)
 #define BIC_GROUP_HW_IDLE (BIC_Busy | BIC_CPU_c1 | BIC_CPU_c3 | BIC_CPU_c6 | BIC_CPU_c7 | BIC_GFX_rc6 | BIC_Pkgpc2 | BIC_Pkgpc3 | BIC_Pkgpc6 | BIC_Pkgpc7 | BIC_Pkgpc8 | BIC_Pkgpc9 | BIC_Pkgpc10 | BIC_CPU_LPI | BIC_SYS_LPI | BIC_Mod_c6 | BIC_Totl_c0 | BIC_Any_c0 | BIC_GFX_c0 | BIC_CPUGFX | BIC_SAM_mc6 | BIC_Diec6)
 #define BIC_GROUP_SW_IDLE (BIC_Busy | BIC_cpuidle | BIC_pct_idle )
-#define BIC_GROUP_IDLE (BIC_GROUP_HW_IDLE | BIC_pct_idle) 
+#define BIC_GROUP_IDLE (BIC_GROUP_HW_IDLE | BIC_pct_idle)
 #define BIC_OTHER (BIC_IRQ | BIC_NMI | BIC_SMI | BIC_ThreadC | BIC_CoreTmp | BIC_IPC)
 
 #define BIC_DISABLED_BY_DEFAULT	(BIC_USEC | BIC_TOD | BIC_APIC | BIC_X2APIC | BIC_cpuidle)
@@ -1091,7 +1091,6 @@ void probe_platform_features(unsigned int family, unsigned int model)
 {
 	int i;
 
-
 	if (authentic_amd || hygon_genuine) {
 		/* fallback to default features on unsupported models */
 		force_load++;
@@ -1125,8 +1124,7 @@ void probe_platform_features(unsigned int family, unsigned int model)
 	if (platform)
 		return;
 
-	fprintf(stderr, "Unsupported platform detected.\n"
-		"\tSee RUN THE LATEST VERSION on turbostat(8)\n");
+	fprintf(stderr, "Unsupported platform detected.\n\tSee RUN THE LATEST VERSION on turbostat(8)\n");
 	exit(1);
 }
 
@@ -1146,7 +1144,8 @@ char *progname;
 
 #define CPU_SUBSET_MAXCPUS	8192	/* need to use before probe... */
 cpu_set_t *cpu_present_set, *cpu_possible_set, *cpu_effective_set, *cpu_allowed_set, *cpu_affinity_set, *cpu_subset;
-size_t cpu_present_setsize, cpu_possible_setsize, cpu_effective_setsize, cpu_allowed_setsize, cpu_affinity_setsize, cpu_subset_size;
+size_t cpu_present_setsize, cpu_possible_setsize, cpu_effective_setsize, cpu_allowed_setsize, cpu_affinity_setsize,
+    cpu_subset_size;
 #define MAX_ADDED_THREAD_COUNTERS 24
 #define MAX_ADDED_CORE_COUNTERS 8
 #define MAX_ADDED_PACKAGE_COUNTERS 16
@@ -2373,8 +2372,7 @@ void help(void)
 		"		  degrees Celsius\n"
 		"  -h, --help\n"
 		"		print this help message\n"
-		"  -v, --version\n"
-		"		print version information\n\nFor more help, run \"man turbostat\"\n");
+		"  -v, --version\n\t\tprint version information\n\nFor more help, run \"man turbostat\"\n");
 }
 
 /*
@@ -3989,7 +3987,6 @@ void compute_average(struct thread_data *t, struct core_data *c, struct pkg_data
 	if (average.threads.nmi_count > 9999999)
 		sums_need_wide_columns = 1;
 
-
 	average.cores.c3 /= topo.allowed_cores;
 	average.cores.c6 /= topo.allowed_cores;
 	average.cores.c7 /= topo.allowed_cores;
@@ -4812,7 +4809,6 @@ unsigned long pmt_read_counter(struct pmt_counter *ppmt, unsigned int domain_id)
 	return (value & value_mask) >> value_shift;
 }
 
-
 /* Rapl domain enumeration helpers */
 static inline int get_rapl_num_domains(void)
 {
@@ -6822,8 +6818,10 @@ static void probe_intel_uncore_frequency_cluster(void)
 		 * This allows "--show/--hide UncMHz" to be effective for
 		 * the clustered MHz counters, as a group.
 		 */
-		if BIC_IS_ENABLED(BIC_UNCORE_MHZ)
-			add_counter(0, path, name_buf, 0, SCOPE_PACKAGE, COUNTER_K2M, FORMAT_AVERAGE, 0, package_id);
+		if BIC_IS_ENABLED
+			(BIC_UNCORE_MHZ)
+			    add_counter(0, path, name_buf, 0, SCOPE_PACKAGE, COUNTER_K2M, FORMAT_AVERAGE, 0,
+					package_id);
 
 		if (quiet)
 			continue;
@@ -6895,17 +6893,21 @@ static void probe_graphics(void)
 		else
 			goto next;
 
-		set_graphics_fp("/sys/class/drm/card0/device/tile0/gt0/gtidle/idle_residency_ms", gt0_is_gt ? GFX_rc6 : SAM_mc6);
+		set_graphics_fp("/sys/class/drm/card0/device/tile0/gt0/gtidle/idle_residency_ms",
+				gt0_is_gt ? GFX_rc6 : SAM_mc6);
 
 		set_graphics_fp("/sys/class/drm/card0/device/tile0/gt0/freq0/cur_freq", gt0_is_gt ? GFX_MHz : SAM_MHz);
 
-		set_graphics_fp("/sys/class/drm/card0/device/tile0/gt0/freq0/act_freq", gt0_is_gt ? GFX_ACTMHz : SAM_ACTMHz);
+		set_graphics_fp("/sys/class/drm/card0/device/tile0/gt0/freq0/act_freq",
+				gt0_is_gt ? GFX_ACTMHz : SAM_ACTMHz);
 
-		set_graphics_fp("/sys/class/drm/card0/device/tile0/gt1/gtidle/idle_residency_ms", gt0_is_gt ? SAM_mc6 : GFX_rc6);
+		set_graphics_fp("/sys/class/drm/card0/device/tile0/gt1/gtidle/idle_residency_ms",
+				gt0_is_gt ? SAM_mc6 : GFX_rc6);
 
 		set_graphics_fp("/sys/class/drm/card0/device/tile0/gt1/freq0/cur_freq", gt0_is_gt ? SAM_MHz : GFX_MHz);
 
-		set_graphics_fp("/sys/class/drm/card0/device/tile0/gt1/freq0/act_freq", gt0_is_gt ? SAM_ACTMHz : GFX_ACTMHz);
+		set_graphics_fp("/sys/class/drm/card0/device/tile0/gt1/freq0/act_freq",
+				gt0_is_gt ? SAM_ACTMHz : GFX_ACTMHz);
 
 		goto end;
 	}
@@ -7428,7 +7430,7 @@ static int fread_int(char *path, int *val)
 	FILE *filep;
 	int ret;
 
-	filep = fopen (path, "r");
+	filep = fopen(path, "r");
 	if (!filep)
 		return -1;
 
@@ -7442,7 +7444,7 @@ static int fread_ull(char *path, unsigned long long *val)
 	FILE *filep;
 	int ret;
 
-	filep = fopen (path, "r");
+	filep = fopen(path, "r");
 	if (!filep)
 		return -1;
 
@@ -7457,7 +7459,7 @@ static int fread_str(char *path, char *buf, int size)
 	int ret;
 	char *cp;
 
-	filep = fopen (path, "r");
+	filep = fopen(path, "r");
 	if (!filep)
 		return -1;
 
@@ -7500,17 +7502,16 @@ static int dump_one_domain(char *domain_path)
 		return 0;
 	}
 
-	for (constraint = 0;; constraint++)
-	{
+	for (constraint = 0;; constraint++) {
 		snprintf(path, PATH_MAX, "%s/constraint_%d_time_window_us", domain_path, constraint);
 		ret = fread_ull(path, &val);
 		if (ret <= 0)
 			break;
 
 		if (val > 1000000)
-			fprintf(outf, " %0.1fs", (double)val/1000000);
+			fprintf(outf, " %0.1fs", (double)val / 1000000);
 		else if (val > 1000)
-			fprintf(outf, " %0.1fms", (double)val/1000);
+			fprintf(outf, " %0.1fms", (double)val / 1000);
 		else
 			fprintf(outf, " %0.1fus", (double)val);
 
@@ -7541,30 +7542,29 @@ static int print_rapl_sysfs(void)
 		return 1;
 	}
 
-	while ((entry = readdir (dir)) != NULL) {
+	while ((entry = readdir(dir)) != NULL) {
 		if (strlen(entry->d_name) > 100)
-                        continue;
+			continue;
 
 		if (strncmp(entry->d_name, "intel-rapl", strlen("intel-rapl")))
-                        continue;
+			continue;
 
 		snprintf(path, PATH_MAX, "%s/%s/name", PATH_RAPL_SYSFS, entry->d_name);
 
 		/* Parse top level domains first, including package and psys */
 		fread_str(path, str, PATH_MAX);
-		if (strncmp(str, "package", strlen("package")) &&
-		    strncmp(str, "psys", strlen("psys")))
+		if (strncmp(str, "package", strlen("package")) && strncmp(str, "psys", strlen("psys")))
 			continue;
 
 		snprintf(path, PATH_MAX, "%s/%s", PATH_RAPL_SYSFS, entry->d_name);
 		if ((cdir = opendir(path)) == NULL) {
-			perror ("opendir() error");
+			perror("opendir() error");
 			return 1;
 		}
 
 		dump_one_domain(path);
 
-		while ((centry = readdir (cdir)) != NULL) {
+		while ((centry = readdir(cdir)) != NULL) {
 			if (strncmp(centry->d_name, "intel-rapl", strlen("intel-rapl")))
 				continue;
 			snprintf(path, PATH_MAX, "%s/%s/%s", PATH_RAPL_SYSFS, entry->d_name, centry->d_name);
@@ -8049,7 +8049,7 @@ static int has_instr_count_access(void)
 }
 
 int add_rapl_perf_counter(int cpu, struct rapl_counter_info_t *rci, const struct rapl_counter_arch_info *cai,
-			   double *scale_, enum rapl_unit *unit_)
+			  double *scale_, enum rapl_unit *unit_)
 {
 	int ret = -1;
 
@@ -8188,7 +8188,7 @@ void rapl_perf_init(void)
 				rci->unit[cai->rci_index] = unit;
 				rci->flags[cai->rci_index] = cai->flags;
 
-			/* Use MSR for this counter */
+				/* Use MSR for this counter */
 			} else if (add_rapl_msr_counter(cpu, cai) >= 0) {
 				rci->source[cai->rci_index] = COUNTER_SOURCE_MSR;
 				rci->msr[cai->rci_index] = cai->msr;
@@ -9299,15 +9299,14 @@ int added_perf_counters_init_(struct perf_counter_info *pinfo)
 					perf_device = "cpu_atom";
 					break;
 
-				default: /* Don't change, we will probably fail and report a problem soon. */
+				default:	/* Don't change, we will probably fail and report a problem soon. */
 					break;
 				}
 			}
 
 			perf_type = read_perf_type(perf_device);
 			if (perf_type == (unsigned int)-1) {
-				warnx("%s: perf/%s/%s: failed to read %s",
-				      __func__, perf_device, pinfo->event, "type");
+				warnx("%s: perf/%s/%s: failed to read %s", __func__, perf_device, pinfo->event, "type");
 				continue;
 			}
 
@@ -9409,7 +9408,7 @@ struct pmt_mmio *pmt_mmio_open(unsigned int target_guid)
 		return NULL;
 	}
 
-	for ( ; entry != NULL; entry = pmt_diriter_next(&pmt_iter)) {
+	for (; entry != NULL; entry = pmt_diriter_next(&pmt_iter)) {
 		if (fstatat(dirfd(pmt_iter.dir), entry->d_name, &st, 0) == -1)
 			break;
 
@@ -9849,7 +9848,7 @@ int get_and_dump_counters(void)
 
 void print_version()
 {
-	fprintf(outf, "turbostat version 2025.04.06 - Len Brown <lenb@kernel.org>\n");
+	fprintf(outf, "turbostat version 2025.06.08 - Len Brown <lenb@kernel.org>\n");
 }
 
 #define COMMAND_LINE_SIZE 2048
@@ -10305,7 +10304,7 @@ void parse_add_command_pmt(char *add_command)
 	unsigned int lsb;
 	unsigned int msb;
 	unsigned int guid;
-	unsigned int seq = 0; /* By default, pick first file in a sequence with a given GUID. */
+	unsigned int seq = 0;	/* By default, pick first file in a sequence with a given GUID. */
 	unsigned int domain_id;
 	enum counter_scope scope = 0;
 	enum pmt_datatype type = PMT_TYPE_RAW;
-- 
2.45.2


