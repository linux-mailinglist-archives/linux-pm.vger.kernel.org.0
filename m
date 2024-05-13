Return-Path: <linux-pm+bounces-7780-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D447E8C47BD
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2024 21:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61F281F24993
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2024 19:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4FA7B3E5;
	Mon, 13 May 2024 19:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JcI3ZhUR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E307711B
	for <linux-pm@vger.kernel.org>; Mon, 13 May 2024 19:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715629280; cv=none; b=kK2J33ha+RmDkW8beLFMr06Sj34vmQvPRCYQ2IHtr7glRwrgJB23bHEPPbfXOKFVtMddrUBK0D3bOzS+1i80MuzctgNbS0ZbJ7FESGjpX7uMmj97sWT4MyOK5frsoQNAKww+0b7X62i0Ziv/ia9AHyfEYwoq/kBbmFF0PzcY1vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715629280; c=relaxed/simple;
	bh=fcjkvVCw5jmz+cVRVVw0JlGzJOUxnO3rivIuOXBzY3M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gLj0G60/EKYFq9x20jhcdlUOjt3x6uyzbfBsCqx4j1A4xDjH0VGpJB2QLSNcF6nBGWFpfQwx77eTou3mO77DS4f8V/hsf6wFB0q9bdu2HQeIWxU+DBXCugKqjK6bbCyMZgEkpZfFcAjWQIF82JTNOQGCqfVcYw1Ksvu6ewbmskU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JcI3ZhUR; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-61816fc256dso47086387b3.0
        for <linux-pm@vger.kernel.org>; Mon, 13 May 2024 12:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715629278; x=1716234078; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FgBA5BDFD81dqwz+3d3WeOUcXKcgYgkIHKAGJIk9fyQ=;
        b=JcI3ZhURgXsmgj5PBiLfGIk6TybN3OOcHkz9rgTENPDMoKg2d57wYztqvrUlru5zUl
         LHXbpil6C7X6l3Mnb0w7hvb1WAou7Aw8os9YEFnIyBEsaeVyLrQuglAXAO8pZN660RnE
         uLLfjVaPnf/4DnktHZvl0DAkjoGpXqa31WkQ7dIZQHSOjczeJZ6fINJMB/jwqLO0qM0t
         pPfbG23vuwfbdFvEcaxn8rMg4SwRUhwA56pUjPKcNteR9tVCSLtpAaznBMSpjVb+OetR
         SABwWYSgDK8mBh14xjQqGTYTC122aFSGA5SLMt5kzNtEnVcdgrybqB2oojgRaTa1/9I6
         GcIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715629278; x=1716234078;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FgBA5BDFD81dqwz+3d3WeOUcXKcgYgkIHKAGJIk9fyQ=;
        b=D+WErLsZJ02hRo3DTM0FxJyAUqKCahanzxzyEn+EvidCZw9EsGtNkv8cnT2WnuNsuE
         Cg78bzaFvxvzX4lsoZZqesKJpHTOJLH7/PMG8UYTwX3nLXjw47fBQDvu/b1nJNxv7iW/
         3LRyMryZKnG/UHYeAgZ5nv/0318DesvWipHQYhrcsU6B+4v8IQrAXRQypqvNLOCwWxn2
         ksAtviF5qSd/5TguaosQnr2emp9a53SRPnTl8wAwMUU4IixaiO0RSW5Lyon/VNx9KyY+
         TjqUVW8A80Oe5HzqboenAiCT0JSHnkAvP7GqMn//oM/7/YOJ/J8M1TWazsz2Yu/Y3rBU
         LIeg==
X-Gm-Message-State: AOJu0YysFgVSkWQ+P8uqXgpPKaM7OMxOZdiS4JXDTASit5IHGGnnx+pc
	oGHFpEhD6DIOp0WQogfbA/b4w7mLqFCKDrSsS0RgrEci/0GddoBXjjDqGQ==
X-Google-Smtp-Source: AGHT+IF9ukJziNMYau8ca0rA2mtDHv6rVio1tPvwLRYWXdYTIKjWQ0PTfb8lJiVzE3J+W4ehSOseoQ==
X-Received: by 2002:a0d:d603:0:b0:620:34a3:da1 with SMTP id 00721157ae682-622b0147ed4mr92021017b3.39.1715629277572;
        Mon, 13 May 2024 12:41:17 -0700 (PDT)
Received: from lenb-Intel-NUC8i7HVKVA.search.charter.net ([2600:6c60:4a00:22d:edc9:ad0e:d214:6024])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6209e26fc1csm22266417b3.71.2024.05.13.12.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 12:41:17 -0700 (PDT)
Sender: Len Brown <lenb417@gmail.com>
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 11/15] tools/power turbostat: Read Core-cstates via perf
Date: Mon, 13 May 2024 15:40:47 -0400
Message-Id: <fa491dc73862025bd67801bfb0947bbffc6c98be.1715628187.git.len.brown@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <231ce08b662a58d4392da998699b3d4a7e2e87cf.1715628187.git.len.brown@intel.com>
References: <231ce08b662a58d4392da998699b3d4a7e2e87cf.1715628187.git.len.brown@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>

Reading the counters via perf can be done in bulk with a single syscall,
making the counter values more accurate with respect to one another by
minimizing the time gap between individual counter reads.

Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 379 +++++++++++++++++++++++---
 1 file changed, 335 insertions(+), 44 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 66c0c64b4494..030e0f8692a6 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -63,6 +63,7 @@ enum counter_type { COUNTER_ITEMS, COUNTER_CYCLES, COUNTER_SECONDS, COUNTER_USEC
 enum counter_format { FORMAT_RAW, FORMAT_DELTA, FORMAT_PERCENT, FORMAT_AVERAGE };
 enum amperf_source { AMPERF_SOURCE_PERF, AMPERF_SOURCE_MSR };
 enum rapl_source { RAPL_SOURCE_NONE, RAPL_SOURCE_PERF, RAPL_SOURCE_MSR };
+enum cstate_source { CSTATE_SOURCE_NONE, CSTATE_SOURCE_PERF, CSTATE_SOURCE_MSR };
 
 struct sysfs_path {
 	char path[PATH_BYTES];
@@ -1183,6 +1184,77 @@ struct rapl_counter {
 	double scale;
 };
 
+/* Indexes used to map data read from perf and MSRs into global variables */
+enum ccstate_rci_index {
+	CCSTATE_RCI_INDEX_C1_RESIDENCY = 0,
+	CCSTATE_RCI_INDEX_C3_RESIDENCY = 1,
+	CCSTATE_RCI_INDEX_C6_RESIDENCY = 2,
+	CCSTATE_RCI_INDEX_C7_RESIDENCY = 3,
+	NUM_CCSTATE_COUNTERS,
+};
+
+struct cstate_counter_info_t {
+	unsigned long long data[NUM_CCSTATE_COUNTERS];
+	enum cstate_source source[NUM_CCSTATE_COUNTERS];
+	unsigned long long msr[NUM_CCSTATE_COUNTERS];
+	int fd_perf;
+};
+
+struct cstate_counter_info_t *ccstate_counter_info;
+unsigned int ccstate_counter_info_size;
+
+#define CSTATE_COUNTER_FLAG_COLLECT_PER_THREAD (1u << 0)
+#define CSTATE_COUNTER_FLAG_SOFT_C1_DEPENDENCY (1u << 1)
+
+struct cstate_counter_arch_info {
+	int feature_mask;	/* Mask for testing if the counter is supported on host */
+	const char *perf_subsys;
+	const char *perf_name;
+	unsigned long long msr;
+	unsigned int rci_index;	/* Maps data from perf counters to global variables */
+	unsigned long long bic;
+	unsigned long long flags;
+};
+
+static struct cstate_counter_arch_info ccstate_counter_arch_infos[] = {
+	{
+	 .feature_mask = CC1,
+	 .perf_subsys = "cstate_core",
+	 .perf_name = "c1-residency",
+	 .msr = MSR_CORE_C1_RES,
+	 .rci_index = CCSTATE_RCI_INDEX_C1_RESIDENCY,
+	 .bic = BIC_CPU_c1,
+	 .flags = CSTATE_COUNTER_FLAG_COLLECT_PER_THREAD,
+	  },
+	{
+	 .feature_mask = CC3,
+	 .perf_subsys = "cstate_core",
+	 .perf_name = "c3-residency",
+	 .msr = MSR_CORE_C3_RESIDENCY,
+	 .rci_index = CCSTATE_RCI_INDEX_C3_RESIDENCY,
+	 .bic = BIC_CPU_c3,
+	 .flags = CSTATE_COUNTER_FLAG_SOFT_C1_DEPENDENCY,
+	  },
+	{
+	 .feature_mask = CC6,
+	 .perf_subsys = "cstate_core",
+	 .perf_name = "c6-residency",
+	 .msr = MSR_CORE_C6_RESIDENCY,
+	 .rci_index = CCSTATE_RCI_INDEX_C6_RESIDENCY,
+	 .bic = BIC_CPU_c6,
+	 .flags = CSTATE_COUNTER_FLAG_SOFT_C1_DEPENDENCY,
+	  },
+	{
+	 .feature_mask = CC7,
+	 .perf_subsys = "cstate_core",
+	 .perf_name = "c7-residency",
+	 .msr = MSR_CORE_C7_RESIDENCY,
+	 .rci_index = CCSTATE_RCI_INDEX_C7_RESIDENCY,
+	 .bic = BIC_CPU_c7,
+	 .flags = CSTATE_COUNTER_FLAG_SOFT_C1_DEPENDENCY,
+	  },
+};
+
 struct thread_data {
 	struct timeval tv_begin;
 	struct timeval tv_end;
@@ -1571,10 +1643,6 @@ static void bic_disable_msr_access(void)
 {
 	const unsigned long bic_msrs =
 	    BIC_SMI |
-	    BIC_CPU_c1 |
-	    BIC_CPU_c3 |
-	    BIC_CPU_c6 |
-	    BIC_CPU_c7 |
 	    BIC_Mod_c6 |
 	    BIC_CoreTmp |
 	    BIC_Totl_c0 |
@@ -3421,6 +3489,17 @@ size_t rapl_counter_info_count_perf(const struct rapl_counter_info_t *rci)
 	return ret;
 }
 
+static size_t cstate_counter_info_count_perf(const struct cstate_counter_info_t *cci)
+{
+	size_t ret = 0;
+
+	for (int i = 0; i < NUM_CCSTATE_COUNTERS; ++i)
+		if (cci->source[i] == CSTATE_SOURCE_PERF)
+			++ret;
+
+	return ret;
+}
+
 void write_rapl_counter(struct rapl_counter *rc, struct rapl_counter_info_t *rci, unsigned int idx)
 {
 	rc->raw_value = rci->data[idx];
@@ -3519,6 +3598,90 @@ char *find_sysfs_path_by_id(struct sysfs_path *sp, int id)
 	return NULL;
 }
 
+int get_cstate_counters(unsigned int cpu, struct thread_data *t, struct core_data *c)
+{
+	unsigned long long perf_data[NUM_CCSTATE_COUNTERS + 1];
+	struct cstate_counter_info_t *cci;
+
+	if (debug)
+		fprintf(stderr, "%s: cpu%d\n", __func__, cpu);
+
+	assert(ccstate_counter_info);
+	assert(cpu <= ccstate_counter_info_size);
+
+	cci = &ccstate_counter_info[cpu];
+
+	/*
+	 * If we have any perf counters to read, read them all now, in bulk
+	 */
+	if (cci->fd_perf != -1) {
+		const size_t num_perf_counters = cstate_counter_info_count_perf(cci);
+		const ssize_t expected_read_size =
+			(num_perf_counters + 1) * sizeof(unsigned long long);
+		const ssize_t actual_read_size =
+			read(cci->fd_perf, &perf_data[0], sizeof(perf_data));
+
+		if (actual_read_size != expected_read_size)
+			err(-1, "%s: failed to read perf_data (%zu %zu)",
+				__func__, expected_read_size, actual_read_size);
+	}
+
+	for (unsigned int i = 0, pi = 1; i < NUM_CCSTATE_COUNTERS; ++i) {
+		switch (cci->source[i]) {
+		case CSTATE_SOURCE_NONE:
+			break;
+
+		case CSTATE_SOURCE_PERF:
+			assert(pi < ARRAY_SIZE(perf_data));
+			assert(cci->fd_perf != -1);
+
+			if (debug) {
+				fprintf(stderr, "cstate via %s %u: %llu\n",
+					"perf", i, perf_data[pi]);
+			}
+
+			cci->data[i] = perf_data[pi];
+
+			++pi;
+			break;
+
+		case CSTATE_SOURCE_MSR:
+			assert(!no_msr);
+			if (get_msr(cpu, cci->msr[i], &cci->data[i]))
+				return -13 - i;
+
+			if (debug) {
+				fprintf(stderr, "cstate via %s0x%llx %u: %llu\n",
+					"msr", cci->msr[i], i, cci->data[i]);
+			}
+
+			break;
+		}
+	}
+
+	/*
+	 * Helper to write the data only if the source of
+	 * the counter for the current cpu is not none.
+	 *
+	 * Otherwise we would overwrite core data with 0 (default value),
+	 * when invoked for the thread sibling.
+	 */
+#define PERF_COUNTER_WRITE_DATA(out_counter, index) do {	\
+	if (cci->source[index] != CSTATE_SOURCE_NONE)		\
+		out_counter = cci->data[index];			\
+} while (0)
+
+	BUILD_BUG_ON(NUM_CCSTATE_COUNTERS != 4);
+	PERF_COUNTER_WRITE_DATA(t->c1, CCSTATE_RCI_INDEX_C1_RESIDENCY);
+	PERF_COUNTER_WRITE_DATA(c->c3, CCSTATE_RCI_INDEX_C3_RESIDENCY);
+	PERF_COUNTER_WRITE_DATA(c->c6, CCSTATE_RCI_INDEX_C6_RESIDENCY);
+	PERF_COUNTER_WRITE_DATA(c->c7, CCSTATE_RCI_INDEX_C7_RESIDENCY);
+
+#undef PERF_COUNTER_WRITE_DATA
+
+	return 0;
+}
+
 /*
  * get_counters(...)
  * migrate to cpu
@@ -3574,10 +3737,8 @@ int get_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 			return -5;
 		t->smi_count = msr & 0xFFFFFFFF;
 	}
-	if (DO_BIC(BIC_CPU_c1) && platform->has_msr_core_c1_res) {
-		if (get_msr(cpu, MSR_CORE_C1_RES, &t->c1))
-			return -6;
-	}
+
+	get_cstate_counters(cpu, t, c);
 
 	for (i = 0, mp = sys.tp; mp; i++, mp = mp->next) {
 		if (get_mp(cpu, mp, &t->counter[i], mp->sp->path))
@@ -3594,31 +3755,14 @@ int get_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 			return status;
 	}
 
-	if (DO_BIC(BIC_CPU_c3) || soft_c1_residency_display(BIC_CPU_c3)) {
-		if (get_msr(cpu, MSR_CORE_C3_RESIDENCY, &c->c3))
-			return -6;
-	}
-
-	if ((DO_BIC(BIC_CPU_c6) || soft_c1_residency_display(BIC_CPU_c6)) && !platform->has_msr_knl_core_c6_residency) {
-		if (get_msr(cpu, MSR_CORE_C6_RESIDENCY, &c->c6))
-			return -7;
-	} else if (platform->has_msr_knl_core_c6_residency && soft_c1_residency_display(BIC_CPU_c6)) {
-		if (get_msr(cpu, MSR_KNL_CORE_C6_RESIDENCY, &c->c6))
-			return -7;
-	}
-
-	if (DO_BIC(BIC_CPU_c7) || soft_c1_residency_display(BIC_CPU_c7)) {
-		if (get_msr(cpu, MSR_CORE_C7_RESIDENCY, &c->c7))
-			return -8;
-		else if (t->is_atom) {
-			/*
-			 * For Atom CPUs that has core cstate deeper than c6,
-			 * MSR_CORE_C6_RESIDENCY returns residency of cc6 and deeper.
-			 * Minus CC7 (and deeper cstates) residency to get
-			 * accturate cc6 residency.
-			 */
-			c->c6 -= c->c7;
-		}
+	if (DO_BIC(BIC_CPU_c7) && t->is_atom) {
+		/*
+		 * For Atom CPUs that has core cstate deeper than c6,
+		 * MSR_CORE_C6_RESIDENCY returns residency of cc6 and deeper.
+		 * Minus CC7 (and deeper cstates) residency to get
+		 * accturate cc6 residency.
+		 */
+		c->c6 -= c->c7;
 	}
 
 	if (DO_BIC(BIC_Mod_c6))
@@ -4258,6 +4402,23 @@ void free_fd_instr_count_percpu(void)
 	fd_instr_count_percpu = NULL;
 }
 
+void free_fd_cstate(void)
+{
+	if (!ccstate_counter_info)
+		return;
+
+	const int counter_info_num = ccstate_counter_info_size;
+
+	for (int counter_id = 0; counter_id < counter_info_num; ++counter_id) {
+		if (ccstate_counter_info[counter_id].fd_perf != -1)
+			close(ccstate_counter_info[counter_id].fd_perf);
+	}
+
+	free(ccstate_counter_info);
+	ccstate_counter_info = NULL;
+	ccstate_counter_info_size = 0;
+}
+
 void free_fd_rapl_percpu(void)
 {
 	if (!rapl_counter_info_perdomain)
@@ -4319,6 +4480,7 @@ void free_all_buffers(void)
 	free_fd_instr_count_percpu();
 	free_fd_amperf_percpu();
 	free_fd_rapl_percpu();
+	free_fd_cstate();
 
 	free(irq_column_2_cpu);
 	free(irqs_per_cpu);
@@ -4654,6 +4816,7 @@ static void update_effective_set(bool startup)
 
 void linux_perf_init(void);
 void rapl_perf_init(void);
+void cstate_perf_init(void);
 
 void re_initialize(void)
 {
@@ -4661,6 +4824,7 @@ void re_initialize(void)
 	setup_all_buffers(false);
 	linux_perf_init();
 	rapl_perf_init();
+	cstate_perf_init();
 	fprintf(outf, "turbostat: re-initialized with num_cpus %d, allowed_cpus %d\n", topo.num_cpus,
 		topo.allowed_cpus);
 }
@@ -6508,7 +6672,8 @@ bool is_aperf_access_required(void)
 	return BIC_IS_ENABLED(BIC_Avg_MHz)
 	    || BIC_IS_ENABLED(BIC_Busy)
 	    || BIC_IS_ENABLED(BIC_Bzy_MHz)
-	    || BIC_IS_ENABLED(BIC_IPC);
+	    || BIC_IS_ENABLED(BIC_IPC)
+	    || BIC_IS_ENABLED(BIC_CPU_c1);
 }
 
 int add_rapl_perf_counter_(int cpu, struct rapl_counter_info_t *rci, const struct rapl_counter_arch_info *cai,
@@ -6740,21 +6905,132 @@ static int has_amperf_access(void)
 	return 0;
 }
 
-void probe_cstates(void)
+int add_cstate_perf_counter_(int cpu, struct cstate_counter_info_t *cci,
+			     const struct cstate_counter_arch_info *cai)
 {
-	probe_cst_limit();
+	if (no_perf)
+		return -1;
 
-	if (platform->supported_cstates & CC1)
-		BIC_PRESENT(BIC_CPU_c1);
+	const unsigned int type = read_perf_type(cai->perf_subsys);
+	const unsigned int config = read_rapl_config(cai->perf_subsys, cai->perf_name);
+
+	const int fd_counter =
+		open_perf_counter(cpu, type, config, cci->fd_perf, PERF_FORMAT_GROUP);
+
+	if (fd_counter == -1)
+		return -1;
+
+	/* If it's the first counter opened, make it a group descriptor */
+	if (cci->fd_perf == -1)
+		cci->fd_perf = fd_counter;
+
+	return fd_counter;
+}
+
+int add_cstate_perf_counter(int cpu, struct cstate_counter_info_t *cci,
+			    const struct cstate_counter_arch_info *cai)
+{
+	int ret = add_cstate_perf_counter_(cpu, cci, cai);
+
+	if (debug)
+		fprintf(stderr, "%s: %d (cpu: %d)\n", __func__, ret, cpu);
+
+	return ret;
+}
+
+void cstate_perf_init_(bool soft_c1)
+{
+	bool has_counter;
+	bool *cores_visited;
+	const int cores_visited_elems = topo.max_core_id + 1;
+	const int cci_num = topo.max_cpu_num + 1;
+
+	ccstate_counter_info = calloc(cci_num, sizeof(*ccstate_counter_info));
+	if (!ccstate_counter_info)
+		err(1, "calloc ccstate_counter_arch_info");
+	ccstate_counter_info_size = cci_num;
+
+	cores_visited = calloc(cores_visited_elems, sizeof(*cores_visited));
+	if (!cores_visited)
+		err(1, "calloc cores_visited");
+
+	/* Initialize cstate_counter_info_percpu */
+	for (int cpu = 0; cpu < cci_num; ++cpu)
+		ccstate_counter_info[cpu].fd_perf = -1;
+
+	for (int cidx = 0; cidx < NUM_CCSTATE_COUNTERS; ++cidx) {
+		has_counter = false;
+		memset(cores_visited, 0, cores_visited_elems * sizeof(*cores_visited));
+
+		const struct cstate_counter_arch_info *cai = &ccstate_counter_arch_infos[cidx];
+
+		for (int cpu = 0; cpu < cci_num; ++cpu) {
 
-	if (platform->supported_cstates & CC3)
-		BIC_PRESENT(BIC_CPU_c3);
+			struct cstate_counter_info_t *const cci = &ccstate_counter_info[cpu];
 
-	if (platform->supported_cstates & CC6)
-		BIC_PRESENT(BIC_CPU_c6);
+			if (cpu_is_not_allowed(cpu))
+				continue;
+
+			const int core_id = cpus[cpu].physical_core_id;
+
+			assert(core_id < cores_visited_elems);
+
+			const bool per_thread = cai->flags & CSTATE_COUNTER_FLAG_COLLECT_PER_THREAD;
+
+			if (!per_thread && cores_visited[core_id])
+				continue;
+
+			const bool counter_needed = BIC_IS_ENABLED(cai->bic) ||
+			    (soft_c1 && (cai->flags & CSTATE_COUNTER_FLAG_SOFT_C1_DEPENDENCY));
+			const bool counter_supported =
+				platform->supported_cstates & cai->feature_mask;
+
+			if (counter_needed && counter_supported) {
+				/* Use perf API for this counter */
+				if (!no_perf && cai->perf_name
+				    && add_cstate_perf_counter(cpu, cci, cai) != -1) {
 
-	if (platform->supported_cstates & CC7)
-		BIC_PRESENT(BIC_CPU_c7);
+					cci->source[cai->rci_index] = CSTATE_SOURCE_PERF;
+
+					/* User MSR for this counter */
+				} else if (!no_msr && cai->msr && probe_msr(cpu, cai->msr) == 0) {
+					cci->source[cai->rci_index] = CSTATE_SOURCE_MSR;
+					cci->msr[cai->rci_index] = cai->msr;
+				}
+			}
+
+			if (cci->source[cai->rci_index] != CSTATE_SOURCE_NONE) {
+				has_counter = true;
+				cores_visited[core_id] = true;
+			}
+		}
+
+		/* If any CPU has access to the counter, make it present */
+		if (has_counter)
+			BIC_PRESENT(cai->bic);
+	}
+
+	free(cores_visited);
+}
+
+void cstate_perf_init(void)
+{
+	/*
+	 * If we don't have a C1 residency MSR, we calculate it "in software",
+	 * but we need APERF, MPERF too.
+	 */
+	const bool soft_c1 = !platform->has_msr_core_c1_res && has_amperf_access()
+			     && platform->supported_cstates & CC1;
+
+	if (soft_c1)
+		BIC_PRESENT(BIC_CPU_c1);
+
+	cstate_perf_init_(soft_c1);
+}
+
+void probe_cstates(void)
+{
+	probe_cst_limit();
 
 	if (platform->supported_cstates & PC2 && (pkg_cstate_limit >= PCL__2))
 		BIC_PRESENT(BIC_Pkgpc2);
@@ -7033,6 +7309,19 @@ void process_cpuid()
 	BIC_PRESENT(BIC_TSC_MHz);
 }
 
+static void counter_info_init(void)
+{
+	for (int i = 0; i < NUM_CCSTATE_COUNTERS; ++i) {
+		struct cstate_counter_arch_info *const cai = &ccstate_counter_arch_infos[i];
+
+		if (platform->has_msr_knl_core_c6_residency && cai->msr == MSR_CORE_C6_RESIDENCY)
+			cai->msr = MSR_KNL_CORE_C6_RESIDENCY;
+
+		if (!platform->has_msr_core_c1_res && cai->msr == MSR_CORE_C1_RES)
+			cai->msr = 0;
+	}
+}
+
 void probe_pm_features(void)
 {
 	probe_pstates();
@@ -7510,10 +7799,12 @@ void turbostat_init()
 	check_msr_access();
 	check_perf_access();
 	process_cpuid();
+	counter_info_init();
 	probe_pm_features();
 	set_amperf_source();
 	linux_perf_init();
 	rapl_perf_init();
+	cstate_perf_init();
 
 	for_all_cpus(get_cpu_type, ODD_COUNTERS);
 	for_all_cpus(get_cpu_type, EVEN_COUNTERS);
-- 
2.40.1


