Return-Path: <linux-pm+bounces-36793-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 756B6C07107
	for <lists+linux-pm@lfdr.de>; Fri, 24 Oct 2025 17:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 066E64EA69B
	for <lists+linux-pm@lfdr.de>; Fri, 24 Oct 2025 15:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F53324B32;
	Fri, 24 Oct 2025 15:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qwFRYBnZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4142C12CD8B
	for <linux-pm@vger.kernel.org>; Fri, 24 Oct 2025 15:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761320819; cv=none; b=OuMpI8bBqXbdS/FSzuAczsyJftHktqVfdZ5pXjIRsfnWQfwocMT1iL3tOfeHJzZ6OO8303HeIvpSc9kou6Uy/8yID9rxSvQYMbbfbubDSGuJ6/0ctZ2BzSaGK9p9eVNbeKm0tDMjxr3mTPH9Z1nXl1TjpaoG7vVA9Pdm7U/wzdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761320819; c=relaxed/simple;
	bh=mlYBP7ydH/U9dnMOsX3IqtwZiopGDBAWzpDXNIjfI2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dYtNnWxAgyS5WjRC+x61Iy+ntA91wujmgUeRXT2jvuPFtvFStLrtqcvj9xcr9V051qQi8JoA7/oLCxGq8436mq+ejiUb+JMnZ0figXtOJkSIXsedGl6zgIsXm3txaUmkSkICCGSPJQuA5aH2FPc/GD4s6l6cTQTLyUrP0Vx1k+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qwFRYBnZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E043C4CEFF;
	Fri, 24 Oct 2025 15:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761320819;
	bh=mlYBP7ydH/U9dnMOsX3IqtwZiopGDBAWzpDXNIjfI2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=qwFRYBnZVFuCACzdk98mObPlhQ+j16mzw2xG/zaJ7qP31YiD+YkBlc8M1OWNiQdZI
	 aNPyL3LudlKo6Vl19SMe+RiL39aCUEapzppnUqKWa/U8+Zz2fo9Ey6GpUdxH63cMW8
	 m7Zcqb6839Yv9IKrTpG0/3ryYVlWOcMj/viXjd1LJDg6I8Eho/Aro/oJKkE9P7euT1
	 RP6SmyXQr5UzVd5kIi1C/BxJVwdBdyBbwtSaVRiLpoEqdDUs6tqXXNNt1ZJt5IL51Y
	 juMcYxZt7ViMvPQP7ccwfWLousRXhrq6I0uL+zyd0rxo5ejTGHRJ+B5hAOSiZgMwRl
	 r4yf+nFeYHHVg==
From: Len Brown <lenb@kernel.org>
To: rafael@kernel.org,
	linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 8/8] tools/power turbostat: Add LLC stats
Date: Fri, 24 Oct 2025 12:38:18 -0300
Message-ID: <102cf736ba1b4ee5299cab47bc5e0df605898606.1761320252.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <92664f2e6ab2228a3330734fc72dabeaf8a49ee1.1761320252.git.len.brown@intel.com>
References: <92664f2e6ab2228a3330734fc72dabeaf8a49ee1.1761320252.git.len.brown@intel.com>
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

LLCkRPS = Last Level Cache Thousands of References Per Second
LLC%hit = Last Level Cache Hit %

These columns are enabled by-default.
They can be controlled with the --show/--hide options
by individual column names above,
or together using the "llc" or "cache" groups.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.8 |   6 +-
 tools/power/x86/turbostat/turbostat.c | 176 ++++++++++++++++++++++----
 2 files changed, 154 insertions(+), 28 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.8 b/tools/power/x86/turbostat/turbostat.8
index ad3fc201552f..1551fcdbfd8a 100644
--- a/tools/power/x86/turbostat/turbostat.8
+++ b/tools/power/x86/turbostat/turbostat.8
@@ -101,7 +101,7 @@ The column name "all" can be used to enable all disabled-by-default built-in cou
 .PP
 \fB--show column\fP show only the specified built-in columns.  May be invoked multiple times, or with a comma-separated list of column names.
 .PP
-\fB--show CATEGORY --hide CATEGORY\fP  Show and hide also accept a single CATEGORY of columns: "all", "topology", "idle", "frequency", "power", "cpuidle", "hwidle", "swidle", "other".  "idle" (enabled by default), includes "hwidle" and "pct_idle".  "cpuidle" (default disabled) includes cpuidle software invocation counters.  "swidle" includes "cpuidle" plus "pct_idle".  "hwidle" includes only hardware based idle residency counters.  Older versions of turbostat used the term "sysfs" for what is now "swidle".
+\fB--show CATEGORY --hide CATEGORY\fP  Show and hide also accept a comma-separated-list of CATEGORIES of columns: "all", "topology", "idle", "frequency", "power", "cpuidle", "hwidle", "swidle", "cache", "llc", "other".  "idle" (enabled by default), includes "hwidle" and "pct_idle".  "cpuidle" (default disabled) includes cpuidle software invocation counters.  "swidle" includes "cpuidle" plus "pct_idle".  "hwidle" includes only hardware based idle residency counters.  Older versions of turbostat used the term "sysfs" for what is now "swidle".
 .PP
 \fB--Dump\fP displays the raw counter values.
 .PP
@@ -159,6 +159,10 @@ The system configuration dump (if --quiet is not used) is followed by statistics
 .PP
 \fBSMI\fP The number of System Management Interrupts  serviced CPU during the measurement interval.  While this counter is actually per-CPU, SMI are triggered on all processors, so the number should be the same for all CPUs.
 .PP
+\fBLLCkRPS\fP Last Level Cache Thousands of References Per Second.  For CPUs with an L3 LLC, this is the number of references that CPU made to the L3 (and the number of misses that CPU made to it's L2).  For CPUs with an L2 LLC, this is the number of references to the L2 (and the number of misses to the CPU's L1).  The system summary row shows the sum for all CPUs.  In both cases, the value displayed is the actual value divided by 1000 in the interest of usually fitting into 8 columns.
+.PP
+\fBLLC%hit\fP Last Level Cache Hit Rate %.  Hit Rate Percent = 100.0 * (References - Misses)/References.  The system summary row shows the weighted average for all CPUs (100.0 * (Sum_References - Sum_Misses)/Sum_References).
+.PP
 \fBC1, C2, C3...\fP The number times Linux requested the C1, C2, C3 idle state during the measurement interval.  The system summary line shows the sum for all CPUs.  These are C-state names as exported in /sys/devices/system/cpu/cpu*/cpuidle/state*/name.  While their names are generic, their attributes are processor specific. They the system description section of output shows what MWAIT sub-states they are mapped to on each system.  These counters are in the "cpuidle" group, which is disabled, by default.
 .PP
 \fBC1+, C2+, C3+...\fP The idle governor idle state misprediction statistics. Inidcates the number times Linux requested the C1, C2, C3 idle state during the measurement interval, but should have requested a deeper idle state (if it exists and enabled). These statistics come from the /sys/devices/system/cpu/cpu*/cpuidle/state*/below file.  These counters are in the "cpuidle" group, which is disabled, by default.
diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index f63525a1877c..b85fa6bda96b 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -209,6 +209,8 @@ struct msr_counter bic[] = {
 	{ 0x0, "NMI", NULL, 0, 0, 0, NULL, 0 },
 	{ 0x0, "CPU%c1e", NULL, 0, 0, 0, NULL, 0 },
 	{ 0x0, "pct_idle", NULL, 0, 0, 0, NULL, 0 },
+	{ 0x0, "LLCkRPS", NULL, 0, 0, 0, NULL, 0 },
+	{ 0x0, "LLC%hit", NULL, 0, 0, 0, NULL, 0 },
 };
 
 /* n.b. bic_names must match the order in bic[], above */
@@ -278,6 +280,8 @@ enum bic_names {
 	BIC_NMI,
 	BIC_CPU_c1e,
 	BIC_pct_idle,
+	BIC_LLC_RPS,
+	BIC_LLC_HIT,
 	MAX_BIC
 };
 
@@ -305,6 +309,7 @@ static cpu_set_t bic_group_frequency;
 static cpu_set_t bic_group_hw_idle;
 static cpu_set_t bic_group_sw_idle;
 static cpu_set_t bic_group_idle;
+static cpu_set_t bic_group_cache;
 static cpu_set_t bic_group_other;
 static cpu_set_t bic_group_disabled_by_default;
 static cpu_set_t bic_enabled;
@@ -413,9 +418,14 @@ static void bic_groups_init(void)
 	SET_BIC(BIC_pct_idle, &bic_group_sw_idle);
 
 	BIC_INIT(&bic_group_idle);
+
 	CPU_OR(&bic_group_idle, &bic_group_idle, &bic_group_hw_idle);
 	SET_BIC(BIC_pct_idle, &bic_group_idle);
 
+	BIC_INIT(&bic_group_cache);
+	SET_BIC(BIC_LLC_RPS, &bic_group_cache);
+	SET_BIC(BIC_LLC_HIT, &bic_group_cache);
+
 	BIC_INIT(&bic_group_other);
 	SET_BIC(BIC_IRQ, &bic_group_other);
 	SET_BIC(BIC_NMI, &bic_group_other);
@@ -470,6 +480,7 @@ char *proc_stat = "/proc/stat";
 FILE *outf;
 int *fd_percpu;
 int *fd_instr_count_percpu;
+int *fd_llc_percpu;
 struct timeval interval_tv = { 5, 0 };
 struct timespec interval_ts = { 5, 0 };
 
@@ -1992,6 +2003,10 @@ void pmt_counter_resize(struct pmt_counter *pcounter, unsigned int new_size)
 	pmt_counter_resize_(pcounter, new_size);
 }
 
+struct llc_stats {
+	unsigned long long references;
+	unsigned long long misses;
+};
 struct thread_data {
 	struct timeval tv_begin;
 	struct timeval tv_end;
@@ -2004,6 +2019,7 @@ struct thread_data {
 	unsigned long long irq_count;
 	unsigned long long nmi_count;
 	unsigned int smi_count;
+	struct llc_stats llc;
 	unsigned int cpu_id;
 	unsigned int apic_id;
 	unsigned int x2apic_id;
@@ -2363,23 +2379,19 @@ int for_all_cpus(int (func) (struct thread_data *, struct core_data *, struct pk
 	return retval;
 }
 
-int is_cpu_first_thread_in_core(PER_THREAD_PARAMS)
+int is_cpu_first_thread_in_core(struct thread_data *t, struct core_data *c)
 {
-	UNUSED(p);
-
 	return ((int)t->cpu_id == c->base_cpu || c->base_cpu < 0);
 }
 
-int is_cpu_first_core_in_package(PER_THREAD_PARAMS)
+int is_cpu_first_core_in_package(struct thread_data *t, struct pkg_data *p)
 {
-	UNUSED(c);
-
 	return ((int)t->cpu_id == p->base_cpu || p->base_cpu < 0);
 }
 
-int is_cpu_first_thread_in_package(PER_THREAD_PARAMS)
+int is_cpu_first_thread_in_package(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 {
-	return is_cpu_first_thread_in_core(t, c, p) && is_cpu_first_core_in_package(t, c, p);
+	return is_cpu_first_thread_in_core(t, c) && is_cpu_first_core_in_package(t, p);
 }
 
 int cpu_migrate(int cpu)
@@ -2657,6 +2669,12 @@ void bic_lookup(cpu_set_t *ret_set, char *name_list, enum show_hide_mode mode)
 			} else if (!strcmp(name_list, "idle")) {
 				CPU_OR(ret_set, ret_set, &bic_group_idle);
 				break;
+			} else if (!strcmp(name_list, "cache")) {
+				CPU_OR(ret_set, ret_set, &bic_group_cache);
+				break;
+			} else if (!strcmp(name_list, "llc")) {
+				CPU_OR(ret_set, ret_set, &bic_group_cache);
+				break;
 			} else if (!strcmp(name_list, "swidle")) {
 				CPU_OR(ret_set, ret_set, &bic_group_sw_idle);
 				break;
@@ -2794,6 +2812,12 @@ void print_header(char *delim)
 	if (DO_BIC(BIC_SMI))
 		outp += sprintf(outp, "%sSMI", (printed++ ? delim : ""));
 
+	if (DO_BIC(BIC_LLC_RPS))
+		outp += sprintf(outp, "%sLLCkRPS", (printed++ ? delim : ""));
+
+	if (DO_BIC(BIC_LLC_HIT))
+		outp += sprintf(outp, "%sLLC%%hit", (printed++ ? delim : ""));
+
 	for (mp = sys.tp; mp; mp = mp->next)
 		outp += print_name(mp->width, &printed, delim, mp->name);
 
@@ -2864,7 +2888,6 @@ void print_header(char *delim)
 
 		ppmt = ppmt->next;
 	}
-
 	if (DO_BIC(BIC_PkgTmp))
 		outp += sprintf(outp, "%sPkgTmp", (printed++ ? delim : ""));
 
@@ -3001,6 +3024,10 @@ int dump_counters(PER_THREAD_PARAMS)
 		if (DO_BIC(BIC_SMI))
 			outp += sprintf(outp, "SMI: %d\n", t->smi_count);
 
+		outp += sprintf(outp, "LLC refs: %lld", t->llc.references);
+		outp += sprintf(outp, "LLC miss: %lld", t->llc.misses);
+		outp += sprintf(outp, "LLC Hit%%: %.2f", 100.0 * (t->llc.references - t->llc.misses) / t->llc.references);
+
 		for (i = 0, mp = sys.tp; mp; i++, mp = mp->next) {
 			outp +=
 			    sprintf(outp, "tADDED [%d] %8s msr0x%x: %08llX %s\n", i, mp->name, mp->msr_num,
@@ -3008,7 +3035,7 @@ int dump_counters(PER_THREAD_PARAMS)
 		}
 	}
 
-	if (c && is_cpu_first_thread_in_core(t, c, p)) {
+	if (c && is_cpu_first_thread_in_core(t, c)) {
 		outp += sprintf(outp, "core: %d\n", c->core_id);
 		outp += sprintf(outp, "c3: %016llX\n", c->c3);
 		outp += sprintf(outp, "c6: %016llX\n", c->c6);
@@ -3030,7 +3057,7 @@ int dump_counters(PER_THREAD_PARAMS)
 		outp += sprintf(outp, "mc6_us: %016llX\n", c->mc6_us);
 	}
 
-	if (p && is_cpu_first_core_in_package(t, c, p)) {
+	if (p && is_cpu_first_core_in_package(t, p)) {
 		outp += sprintf(outp, "package: %d\n", p->package_id);
 
 		outp += sprintf(outp, "Weighted cores: %016llX\n", p->pkg_wtd_core_c0);
@@ -3088,6 +3115,23 @@ double rapl_counter_get_value(const struct rapl_counter *c, enum rapl_unit desir
 	return scaled;
 }
 
+void get_perf_llc_stats(int cpu, struct llc_stats *llc)
+{
+	struct read_format {
+		unsigned long long num_read;
+		struct llc_stats llc;
+	} r;
+	const ssize_t expected_read_size = sizeof(r);
+	ssize_t actual_read_size;
+
+	actual_read_size = read(fd_llc_percpu[cpu], &r, expected_read_size);
+
+	llc->references = r.llc.references;
+	llc->misses = r.llc.misses;
+	if (actual_read_size != expected_read_size)
+		warn("%s: failed to read perf_data (req %zu act %zu)", __func__, expected_read_size, actual_read_size);
+}
+
 /*
  * column formatting convention & formats
  */
@@ -3097,7 +3141,8 @@ int format_counters(PER_THREAD_PARAMS)
 
 	struct platform_counters *pplat_cnt = NULL;
 	double interval_float, tsc;
-	char *fmt8;
+	char *fmt8 = "%s%.2f";
+
 	int i;
 	struct msr_counter *mp;
 	struct perf_counter_info *pp;
@@ -3111,11 +3156,11 @@ int format_counters(PER_THREAD_PARAMS)
 	}
 
 	/* if showing only 1st thread in core and this isn't one, bail out */
-	if (show_core_only && !is_cpu_first_thread_in_core(t, c, p))
+	if (show_core_only && !is_cpu_first_thread_in_core(t, c))
 		return 0;
 
 	/* if showing only 1st thread in pkg and this isn't one, bail out */
-	if (show_pkg_only && !is_cpu_first_core_in_package(t, c, p))
+	if (show_pkg_only && !is_cpu_first_core_in_package(t, p))
 		return 0;
 
 	/*if not summary line and --cpu is used */
@@ -3237,6 +3282,16 @@ int format_counters(PER_THREAD_PARAMS)
 	if (DO_BIC(BIC_SMI))
 		outp += sprintf(outp, "%s%d", (printed++ ? delim : ""), t->smi_count);
 
+	/* LLC Stats */
+	if (DO_BIC(BIC_LLC_RPS) || DO_BIC(BIC_LLC_HIT)) {
+		if (DO_BIC(BIC_LLC_RPS))
+			outp += sprintf(outp, "%s%.0f", (printed++ ? delim : ""), t->llc.references / interval_float / 1000);
+
+		if (DO_BIC(BIC_LLC_HIT))
+			outp += sprintf(outp, fmt8, (printed++ ? delim : ""), 100.0 * (t->llc.references - t->llc.misses) / t->llc.references);
+	}
+
+
 	/* Added Thread Counters */
 	for (i = 0, mp = sys.tp; mp; i++, mp = mp->next) {
 		if (mp->format == FORMAT_RAW)
@@ -3290,7 +3345,7 @@ int format_counters(PER_THREAD_PARAMS)
 		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * t->c1 / tsc);
 
 	/* print per-core data only for 1st thread in core */
-	if (!is_cpu_first_thread_in_core(t, c, p))
+	if (!is_cpu_first_thread_in_core(t, c))
 		goto done;
 
 	if (DO_BIC(BIC_CPU_c3))
@@ -3351,8 +3406,6 @@ int format_counters(PER_THREAD_PARAMS)
 		}
 	}
 
-	fmt8 = "%s%.2f";
-
 	if (DO_BIC(BIC_CorWatt) && platform->has_per_core_rapl)
 		outp +=
 		    sprintf(outp, fmt8, (printed++ ? delim : ""),
@@ -3362,7 +3415,7 @@ int format_counters(PER_THREAD_PARAMS)
 				rapl_counter_get_value(&c->core_energy, RAPL_UNIT_JOULES, interval_float));
 
 	/* print per-package data only for 1st core in package */
-	if (!is_cpu_first_core_in_package(t, c, p))
+	if (!is_cpu_first_core_in_package(t, p))
 		goto done;
 
 	/* PkgTmp */
@@ -3808,6 +3861,12 @@ int delta_thread(struct thread_data *new, struct thread_data *old, struct core_d
 	if (DO_BIC(BIC_SMI))
 		old->smi_count = new->smi_count - old->smi_count;
 
+	if (DO_BIC(BIC_LLC_RPS))
+		old->llc.references = new->llc.references - old->llc.references;
+
+	if (DO_BIC(BIC_LLC_HIT))
+		old->llc.misses = new->llc.misses - old->llc.misses;
+
 	for (i = 0, mp = sys.tp; mp; i++, mp = mp->next) {
 		if (mp->format == FORMAT_RAW || mp->format == FORMAT_AVERAGE)
 			old->counter[i] = new->counter[i];
@@ -3838,14 +3897,14 @@ int delta_cpu(struct thread_data *t, struct core_data *c,
 	int retval = 0;
 
 	/* calculate core delta only for 1st thread in core */
-	if (is_cpu_first_thread_in_core(t, c, p))
+	if (is_cpu_first_thread_in_core(t, c))
 		delta_core(c, c2);
 
 	/* always calculate thread delta */
 	retval = delta_thread(t, t2, c2);	/* c2 is core delta */
 
 	/* calculate package delta only for 1st core in package */
-	if (is_cpu_first_core_in_package(t, c, p))
+	if (is_cpu_first_core_in_package(t, p))
 		retval |= delta_package(p, p2);
 
 	return retval;
@@ -3886,6 +3945,9 @@ void clear_counters(PER_THREAD_PARAMS)
 	t->nmi_count = 0;
 	t->smi_count = 0;
 
+	t->llc.references = 0;
+	t->llc.misses = 0;
+
 	c->c3 = 0;
 	c->c6 = 0;
 	c->c7 = 0;
@@ -3894,6 +3956,9 @@ void clear_counters(PER_THREAD_PARAMS)
 	rapl_counter_clear(&c->core_energy);
 	c->core_throt_cnt = 0;
 
+	t->llc.references = 0;
+	t->llc.misses = 0;
+
 	p->pkg_wtd_core_c0 = 0;
 	p->pkg_any_core_c0 = 0;
 	p->pkg_any_gfxe_c0 = 0;
@@ -3991,6 +4056,9 @@ int sum_counters(PER_THREAD_PARAMS)
 	average.threads.nmi_count += t->nmi_count;
 	average.threads.smi_count += t->smi_count;
 
+	average.threads.llc.references += t->llc.references;
+	average.threads.llc.misses += t->llc.misses;
+
 	for (i = 0, mp = sys.tp; mp; i++, mp = mp->next) {
 		if (mp->format == FORMAT_RAW)
 			continue;
@@ -4008,7 +4076,7 @@ int sum_counters(PER_THREAD_PARAMS)
 	}
 
 	/* sum per-core values only for 1st thread in core */
-	if (!is_cpu_first_thread_in_core(t, c, p))
+	if (!is_cpu_first_thread_in_core(t, c))
 		return 0;
 
 	average.cores.c3 += c->c3;
@@ -4038,7 +4106,7 @@ int sum_counters(PER_THREAD_PARAMS)
 	}
 
 	/* sum per-pkg values only for 1st core in pkg */
-	if (!is_cpu_first_core_in_package(t, c, p))
+	if (!is_cpu_first_core_in_package(t, p))
 		return 0;
 
 	if (DO_BIC(BIC_Totl_c0))
@@ -5009,6 +5077,9 @@ int get_counters(PER_THREAD_PARAMS)
 
 	get_smi_aperf_mperf(cpu, t);
 
+	if (DO_BIC(BIC_LLC_RPS) || DO_BIC(BIC_LLC_HIT))
+		get_perf_llc_stats(cpu, &t->llc);
+
 	if (DO_BIC(BIC_IPC))
 		if (read(get_instr_count_fd(cpu), &t->instr_count, sizeof(long long)) != sizeof(long long))
 			return -4;
@@ -5032,7 +5103,7 @@ int get_counters(PER_THREAD_PARAMS)
 		t->pmt_counter[i] = pmt_read_counter(pp, t->cpu_id);
 
 	/* collect core counters only for 1st thread in core */
-	if (!is_cpu_first_thread_in_core(t, c, p))
+	if (!is_cpu_first_thread_in_core(t, c))
 		goto done;
 
 	if (platform->has_per_core_rapl) {
@@ -5076,7 +5147,7 @@ int get_counters(PER_THREAD_PARAMS)
 		c->pmt_counter[i] = pmt_read_counter(pp, c->core_id);
 
 	/* collect package counters only for 1st core in package */
-	if (!is_cpu_first_core_in_package(t, c, p))
+	if (!is_cpu_first_core_in_package(t, p))
 		goto done;
 
 	if (DO_BIC(BIC_Totl_c0)) {
@@ -5631,6 +5702,20 @@ void free_fd_instr_count_percpu(void)
 	fd_instr_count_percpu = NULL;
 }
 
+void free_fd_llc_percpu(void)
+{
+	if (!fd_llc_percpu)
+		return;
+
+	for (int i = 0; i < topo.max_cpu_num + 1; ++i) {
+		if (fd_llc_percpu[i] != 0)
+			close(fd_llc_percpu[i]);
+	}
+
+	free(fd_llc_percpu);
+	fd_llc_percpu = NULL;
+}
+
 void free_fd_cstate(void)
 {
 	if (!ccstate_counter_info)
@@ -5755,6 +5840,7 @@ void free_all_buffers(void)
 
 	free_fd_percpu();
 	free_fd_instr_count_percpu();
+	free_fd_llc_percpu();
 	free_fd_msr();
 	free_fd_rapl_percpu();
 	free_fd_cstate();
@@ -6101,6 +6187,7 @@ void linux_perf_init(void);
 void msr_perf_init(void);
 void rapl_perf_init(void);
 void cstate_perf_init(void);
+void perf_llc_init(void);
 void added_perf_counters_init(void);
 void pmt_init(void);
 
@@ -6112,6 +6199,7 @@ void re_initialize(void)
 	msr_perf_init();
 	rapl_perf_init();
 	cstate_perf_init();
+	perf_llc_init();
 	added_perf_counters_init();
 	pmt_init();
 	fprintf(outf, "turbostat: re-initialized with num_cpus %d, allowed_cpus %d\n", topo.num_cpus,
@@ -7976,7 +8064,7 @@ int print_thermal(PER_THREAD_PARAMS)
 	cpu = t->cpu_id;
 
 	/* DTS is per-core, no need to print for each thread */
-	if (!is_cpu_first_thread_in_core(t, c, p))
+	if (!is_cpu_first_thread_in_core(t, c))
 		return 0;
 
 	if (cpu_migrate(cpu)) {
@@ -7984,7 +8072,7 @@ int print_thermal(PER_THREAD_PARAMS)
 		return -1;
 	}
 
-	if (do_ptm && is_cpu_first_core_in_package(t, c, p)) {
+	if (do_ptm && is_cpu_first_core_in_package(t, p)) {
 		if (get_msr(cpu, MSR_IA32_PACKAGE_THERM_STATUS, &msr))
 			return 0;
 
@@ -8263,6 +8351,11 @@ void linux_perf_init(void)
 		if (fd_instr_count_percpu == NULL)
 			err(-1, "calloc fd_instr_count_percpu");
 	}
+	if (BIC_IS_ENABLED(BIC_LLC_RPS) && has_aperf) {
+		fd_llc_percpu = calloc(topo.max_cpu_num + 1, sizeof(int));
+		if (fd_llc_percpu == NULL)
+			err(-1, "calloc fd_llc_percpu");
+	}
 }
 
 void rapl_perf_init(void)
@@ -8933,6 +9026,33 @@ void probe_pm_features(void)
 		decode_misc_feature_control();
 }
 
+void perf_llc_init(void)
+{
+	int cpu;
+	int retval;
+
+	for (cpu = 0; cpu < topo.max_cpu_num; ++cpu) {
+
+		if (cpu_is_not_allowed(cpu))
+			continue;
+
+		fd_llc_percpu[cpu] = open_perf_counter(cpu, PERF_TYPE_HARDWARE, PERF_COUNT_HW_CACHE_REFERENCES, -1, PERF_FORMAT_GROUP);
+		if (fd_llc_percpu[cpu] == -1) {
+			warnx("%s: perf REFS: failed to open counter on cpu%d", __func__, cpu);
+			free_fd_llc_percpu();
+			return;
+		}
+		retval = open_perf_counter(cpu, PERF_TYPE_HARDWARE, PERF_COUNT_HW_CACHE_MISSES, fd_llc_percpu[cpu], PERF_FORMAT_GROUP);
+		if (retval == -1) {
+			warnx("%s: perf MISS: failed to open counter on cpu%d", __func__, cpu);
+			free_fd_llc_percpu();
+			return;
+		}
+	}
+	BIC_PRESENT(BIC_LLC_RPS);
+	BIC_PRESENT(BIC_LLC_HIT);
+}
+
 /*
  * in /dev/cpu/ return success for names that are numbers
  * ie. filter out ".", "..", "microcode".
@@ -9239,6 +9359,7 @@ void init_counter(struct thread_data *thread_base, struct core_data *core_base,
 
 	t->cpu_id = cpu_id;
 	if (!cpu_is_not_allowed(cpu_id)) {
+
 		if (c->base_cpu < 0)
 			c->base_cpu = t->cpu_id;
 		if (pkg_base[pkg_id].base_cpu < 0)
@@ -9909,6 +10030,7 @@ void turbostat_init()
 	linux_perf_init();
 	rapl_perf_init();
 	cstate_perf_init();
+	perf_llc_init();
 	added_perf_counters_init();
 	pmt_init();
 
@@ -10014,7 +10136,7 @@ int get_and_dump_counters(void)
 
 void print_version()
 {
-	fprintf(outf, "turbostat version 2025.10.18 - Len Brown <lenb@kernel.org>\n");
+	fprintf(outf, "turbostat version 2025.10.24 - Len Brown <lenb@kernel.org>\n");
 }
 
 #define COMMAND_LINE_SIZE 2048
-- 
2.45.2


