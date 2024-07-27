Return-Path: <linux-pm+bounces-11475-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 594E993E080
	for <lists+linux-pm@lfdr.de>; Sat, 27 Jul 2024 20:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E9B5281E9B
	for <lists+linux-pm@lfdr.de>; Sat, 27 Jul 2024 18:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D2C187350;
	Sat, 27 Jul 2024 18:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMI6CWsE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A63187345
	for <linux-pm@vger.kernel.org>; Sat, 27 Jul 2024 18:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722104814; cv=none; b=Lwm7nq9dZa/YkisGgJqaUU95Kos7zmwP6p/0F55NLd3JU3uK38ifhkUYJzcypoeSq9GPOPwwesPQMQOTBb5Db1+QDuU7yLE5s43t4QQMMwL3x5xdyGfAbb4EH4v3MTVfeGwDa0XRoakOjjya8fRDljfp+8q9fNceymvwcTiP9lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722104814; c=relaxed/simple;
	bh=t/22cyAUEBKVQkYWdETGhrAwauB4ct6RimGrbuxJTUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i+RStQOyEuHmCrgYYbzLqHCx8dC6seaZYyr4ZrAUVmA8Of93t2HVmlWkJ6nh6vRFdDcp3COMbAlfQ35Iav3TYMp1B3DDvHeBrbV/Axu9lH8lr1qSgpcdhCy/7EaXxLBZS93LBV+xj/2PSvIz4PficKRgRLt7AjJ1wR6bFan5Fh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gMI6CWsE; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-264988283a3so1298263fac.0
        for <linux-pm@vger.kernel.org>; Sat, 27 Jul 2024 11:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722104811; x=1722709611; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SpZhel1R9Xk8twn/rQPEsOemW+XBZY8Jb0E2NGaYeBg=;
        b=gMI6CWsEUrHoGXsnDrMB+JpmW9C+Dy6Cy3VFzHCMpNfVBL0VHy1EPkg2CmY13C/1K1
         AEbcAoxRG7f3BJaHlf0AfMkUjHDoys7JviL8mnKZ2RSZ+a9rGCMdKHrpzCywjpmsulOZ
         mbrgowkM9zmoifZ2On8xFhSRQYwdzYlx1QfYWMFdbedWIW5iIz7+EQ8iG2jMwyPMx2Z2
         O7Kmd8dSZgsN5E/hEvlrcMR3skKJtNAk4t6J2CjTNKWtTEij33uWNopjB8JSxP8turTg
         dp+BtNtx7xsN4/Xc2+hKpoRHFtTvfEqq5QjvD9EKw2SsUwV+l93fMZ9ssv0V4op7MFCC
         dDHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722104811; x=1722709611;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SpZhel1R9Xk8twn/rQPEsOemW+XBZY8Jb0E2NGaYeBg=;
        b=S2edOwH0B+DRgiFUqwhwPB6yBrFFGErvKddEhsCxiDRPZFV93BIKnG4HlJ9FHJ+Y97
         sSM8acOlpUxnAss44zONusBlYj/ENDqs1/V5EVybH79Bp2u7ZCjkeecd2Cxz6/+2teTg
         hvsyjDlnHO4ndbe/mJ99AU89gCNz+VYLizumKHMh1fxOcldgqD7dvZHvrjeZei+Om+RE
         uBaKEzpczMVdNdbQUT8H6GYqUhE8ksNkbnz8gqyp+W9q7caOOCpVfYYqYgw/SNLmPD8J
         FRCiVXv1Bi9teEti/q5I3EoX8bi33F30zicf6GE5DRiqvCXEy1blBIBOeZ4K/R9c1LF1
         9fHg==
X-Gm-Message-State: AOJu0Yx+mx80vldFgTCTMsj6fYUwL1P9FgGUliWEMnmgZqpJVEU4rVa7
	/g58OzZ6hQYKwBVKlR49ep7RIqpeLUfce5jMwL6MaxnLzBgQA2x8BkkVZA==
X-Google-Smtp-Source: AGHT+IEtzNahB3E0o1FYAyQOZHq6VYjuVYuMb/eaLTmk++6boV8Uc5SXBo8YaKnguqaCvY1OA/i1YQ==
X-Received: by 2002:a05:6870:8195:b0:260:e713:ae8b with SMTP id 586e51a60fabf-267d4d37e61mr3892497fac.20.1722104811048;
        Sat, 27 Jul 2024 11:26:51 -0700 (PDT)
Received: from lenb-intel-nuc8i7hvkva.. (h75-100-80-185.cntcnh.broadband.dynamic.tds.net. [75.100.80.185])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7093050a35fsm1314136a34.6.2024.07.27.11.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 11:26:50 -0700 (PDT)
Sender: Len Brown <lenb417@gmail.com>
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 05/18] tools/power turbostat: Group SMI counter with APERF and MPERF
Date: Sat, 27 Jul 2024 14:23:31 -0400
Message-ID: <67bab430f4e71332aced7562a67d73444f5b4b77.1722019621.git.len.brown@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <1b3bf0747d4f1a963e59c26e602868bdce195318.1722019621.git.len.brown@intel.com>
References: <1b3bf0747d4f1a963e59c26e602868bdce195318.1722019621.git.len.brown@intel.com>
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

These three counters now are treated similar to other perf counters
groups. This simplifies and gets rid of a lot of special cases for APERF
and MPERF.

Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 635 ++++++++++++--------------
 1 file changed, 280 insertions(+), 355 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 29751b41ea0d..495235055fa2 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -85,7 +85,6 @@
 enum counter_scope { SCOPE_CPU, SCOPE_CORE, SCOPE_PACKAGE };
 enum counter_type { COUNTER_ITEMS, COUNTER_CYCLES, COUNTER_SECONDS, COUNTER_USEC, COUNTER_K2M };
 enum counter_format { FORMAT_RAW, FORMAT_DELTA, FORMAT_PERCENT, FORMAT_AVERAGE };
-enum amperf_source { AMPERF_SOURCE_PERF, AMPERF_SOURCE_MSR };
 enum counter_source { COUNTER_SOURCE_NONE, COUNTER_SOURCE_PERF, COUNTER_SOURCE_MSR };
 
 struct sysfs_path {
@@ -275,7 +274,6 @@ char *proc_stat = "/proc/stat";
 FILE *outf;
 int *fd_percpu;
 int *fd_instr_count_percpu;
-struct amperf_group_fd *fd_amperf_percpu;	/* File descriptors for perf group with APERF and MPERF counters. */
 struct timeval interval_tv = { 5, 0 };
 struct timespec interval_ts = { 5, 0 };
 
@@ -290,6 +288,7 @@ unsigned int summary_only;
 unsigned int list_header_only;
 unsigned int dump_only;
 unsigned int has_aperf;
+unsigned int has_aperf_access;
 unsigned int has_epb;
 unsigned int has_turbo;
 unsigned int is_hybrid;
@@ -330,7 +329,6 @@ unsigned int first_counter_read = 1;
 int ignore_stdin;
 bool no_msr;
 bool no_perf;
-enum amperf_source amperf_source;
 
 enum gfx_sysfs_idx {
 	GFX_rc6,
@@ -1381,6 +1379,67 @@ static struct cstate_counter_arch_info ccstate_counter_arch_infos[] = {
 	  },
 };
 
+/* Indexes used to map data read from perf and MSRs into global variables */
+enum msr_rci_index {
+	MSR_RCI_INDEX_APERF = 0,
+	MSR_RCI_INDEX_MPERF = 1,
+	MSR_RCI_INDEX_SMI = 2,
+	NUM_MSR_COUNTERS,
+};
+
+struct msr_counter_info_t {
+	unsigned long long data[NUM_MSR_COUNTERS];
+	enum counter_source source[NUM_MSR_COUNTERS];
+	unsigned long long msr[NUM_MSR_COUNTERS];
+	unsigned long long msr_mask[NUM_MSR_COUNTERS];
+	int fd_perf;
+};
+
+struct msr_counter_info_t *msr_counter_info;
+unsigned int msr_counter_info_size;
+
+struct msr_counter_arch_info {
+	const char *perf_subsys;
+	const char *perf_name;
+	unsigned long long msr;
+	unsigned long long msr_mask;
+	unsigned int rci_index;	/* Maps data from perf counters to global variables */
+	bool needed;
+	bool present;
+};
+
+enum msr_arch_info_index {
+	MSR_ARCH_INFO_APERF_INDEX = 0,
+	MSR_ARCH_INFO_MPERF_INDEX = 1,
+	MSR_ARCH_INFO_SMI_INDEX = 2,
+};
+
+static struct msr_counter_arch_info msr_counter_arch_infos[] = {
+	[MSR_ARCH_INFO_APERF_INDEX] = {
+		.perf_subsys = "msr",
+		.perf_name = "aperf",
+		.msr = MSR_IA32_APERF,
+		.msr_mask = 0xFFFFFFFFFFFFFFFF,
+		.rci_index = MSR_RCI_INDEX_APERF,
+	},
+
+	[MSR_ARCH_INFO_MPERF_INDEX] = {
+		.perf_subsys = "msr",
+		.perf_name = "mperf",
+		.msr = MSR_IA32_MPERF,
+		.msr_mask = 0xFFFFFFFFFFFFFFFF,
+		.rci_index = MSR_RCI_INDEX_MPERF,
+	},
+
+	[MSR_ARCH_INFO_SMI_INDEX] = {
+		.perf_subsys = "msr",
+		.perf_name = "smi",
+		.msr = MSR_SMI_COUNT,
+		.msr_mask = 0xFFFFFFFF,
+		.rci_index = MSR_RCI_INDEX_SMI,
+	},
+};
+
 struct thread_data {
 	struct timeval tv_begin;
 	struct timeval tv_end;
@@ -1767,7 +1826,7 @@ int get_msr_fd(int cpu)
 
 static void bic_disable_msr_access(void)
 {
-	const unsigned long bic_msrs = BIC_SMI | BIC_Mod_c6 | BIC_CoreTmp |
+	const unsigned long bic_msrs = BIC_Mod_c6 | BIC_CoreTmp |
 	    BIC_Totl_c0 | BIC_Any_c0 | BIC_GFX_c0 | BIC_CPUGFX | BIC_PkgTmp;
 
 	bic_enabled &= ~bic_msrs;
@@ -3402,30 +3461,6 @@ static unsigned int read_perf_counter_info_n(const char *const path, const char
 	return v;
 }
 
-static unsigned int read_msr_type(void)
-{
-	const char *const path = "/sys/bus/event_source/devices/msr/type";
-	const char *const format = "%u";
-
-	return read_perf_counter_info_n(path, format);
-}
-
-static unsigned int read_aperf_config(void)
-{
-	const char *const path = "/sys/bus/event_source/devices/msr/events/aperf";
-	const char *const format = "event=%x";
-
-	return read_perf_counter_info_n(path, format);
-}
-
-static unsigned int read_mperf_config(void)
-{
-	const char *const path = "/sys/bus/event_source/devices/msr/events/mperf";
-	const char *const format = "event=%x";
-
-	return read_perf_counter_info_n(path, format);
-}
-
 static unsigned int read_perf_type(const char *subsys)
 {
 	const char *const path_format = "/sys/bus/event_source/devices/%s/type";
@@ -3479,124 +3514,6 @@ static double read_perf_rapl_scale(const char *subsys, const char *event_name)
 	return scale;
 }
 
-static struct amperf_group_fd open_amperf_fd(int cpu)
-{
-	const unsigned int msr_type = read_msr_type();
-	const unsigned int aperf_config = read_aperf_config();
-	const unsigned int mperf_config = read_mperf_config();
-	struct amperf_group_fd fds = {.aperf = -1, .mperf = -1 };
-
-	fds.aperf = open_perf_counter(cpu, msr_type, aperf_config, -1, PERF_FORMAT_GROUP);
-	fds.mperf = open_perf_counter(cpu, msr_type, mperf_config, fds.aperf, PERF_FORMAT_GROUP);
-
-	return fds;
-}
-
-static int get_amperf_fd(int cpu)
-{
-	assert(fd_amperf_percpu);
-
-	if (fd_amperf_percpu[cpu].aperf)
-		return fd_amperf_percpu[cpu].aperf;
-
-	fd_amperf_percpu[cpu] = open_amperf_fd(cpu);
-
-	return fd_amperf_percpu[cpu].aperf;
-}
-
-/* Read APERF, MPERF and TSC using the perf API. */
-static int read_aperf_mperf_tsc_perf(struct thread_data *t, int cpu)
-{
-	union {
-		struct {
-			unsigned long nr_entries;
-			unsigned long aperf;
-			unsigned long mperf;
-		};
-
-		unsigned long as_array[3];
-	} cnt;
-
-	const int fd_amperf = get_amperf_fd(cpu);
-
-	/*
-	 * Read the TSC with rdtsc, because we want the absolute value and not
-	 * the offset from the start of the counter.
-	 */
-	t->tsc = rdtsc();
-
-	const int n = read(fd_amperf, &cnt.as_array[0], sizeof(cnt.as_array));
-
-	if (n != sizeof(cnt.as_array))
-		return -2;
-
-	t->aperf = cnt.aperf * aperf_mperf_multiplier;
-	t->mperf = cnt.mperf * aperf_mperf_multiplier;
-
-	return 0;
-}
-
-/* Read APERF, MPERF and TSC using the MSR driver and rdtsc instruction. */
-static int read_aperf_mperf_tsc_msr(struct thread_data *t, int cpu)
-{
-	unsigned long long tsc_before, tsc_between, tsc_after, aperf_time, mperf_time;
-	int aperf_mperf_retry_count = 0;
-
-	/*
-	 * The TSC, APERF and MPERF must be read together for
-	 * APERF/MPERF and MPERF/TSC to give accurate results.
-	 *
-	 * Unfortunately, APERF and MPERF are read by
-	 * individual system call, so delays may occur
-	 * between them.  If the time to read them
-	 * varies by a large amount, we re-read them.
-	 */
-
-	/*
-	 * This initial dummy APERF read has been seen to
-	 * reduce jitter in the subsequent reads.
-	 */
-
-	if (get_msr(cpu, MSR_IA32_APERF, &t->aperf))
-		return -3;
-
-retry:
-	t->tsc = rdtsc();	/* re-read close to APERF */
-
-	tsc_before = t->tsc;
-
-	if (get_msr(cpu, MSR_IA32_APERF, &t->aperf))
-		return -3;
-
-	tsc_between = rdtsc();
-
-	if (get_msr(cpu, MSR_IA32_MPERF, &t->mperf))
-		return -4;
-
-	tsc_after = rdtsc();
-
-	aperf_time = tsc_between - tsc_before;
-	mperf_time = tsc_after - tsc_between;
-
-	/*
-	 * If the system call latency to read APERF and MPERF
-	 * differ by more than 2x, then try again.
-	 */
-	if ((aperf_time > (2 * mperf_time)) || (mperf_time > (2 * aperf_time))) {
-		aperf_mperf_retry_count++;
-		if (aperf_mperf_retry_count < 5)
-			goto retry;
-		else
-			warnx("cpu%d jitter %lld %lld", cpu, aperf_time, mperf_time);
-	}
-	aperf_mperf_retry_count = 0;
-
-	t->aperf = t->aperf * aperf_mperf_multiplier;
-	t->mperf = t->mperf * aperf_mperf_multiplier;
-
-	return 0;
-}
-
 size_t rapl_counter_info_count_perf(const struct rapl_counter_info_t *rci)
 {
 	size_t ret = 0;
@@ -3853,6 +3770,84 @@ int get_cstate_counters(unsigned int cpu, struct thread_data *t, struct core_dat
 	return 0;
 }
 
+size_t msr_counter_info_count_perf(const struct msr_counter_info_t *mci)
+{
+	size_t ret = 0;
+
+	for (int i = 0; i < NUM_MSR_COUNTERS; ++i)
+		if (mci->source[i] == COUNTER_SOURCE_PERF)
+			++ret;
+
+	return ret;
+}
+
+int get_smi_aperf_mperf(unsigned int cpu, struct thread_data *t)
+{
+	unsigned long long perf_data[NUM_MSR_COUNTERS + 1];
+
+	struct msr_counter_info_t *mci;
+
+	if (debug)
+		fprintf(stderr, "%s: cpu%d\n", __func__, cpu);
+
+	assert(msr_counter_info);
+	assert(cpu <= msr_counter_info_size);
+
+	mci = &msr_counter_info[cpu];
+
+	ZERO_ARRAY(perf_data);
+	ZERO_ARRAY(mci->data);
+
+	if (mci->fd_perf != -1) {
+		const size_t num_perf_counters = msr_counter_info_count_perf(mci);
+		const ssize_t expected_read_size = (num_perf_counters + 1) * sizeof(unsigned long long);
+		const ssize_t actual_read_size = read(mci->fd_perf, &perf_data[0], sizeof(perf_data));
+
+		if (actual_read_size != expected_read_size)
+			err(-1, "%s: failed to read perf_data (%zu %zu)", __func__, expected_read_size,
+			    actual_read_size);
+	}
+
+	for (unsigned int i = 0, pi = 1; i < NUM_MSR_COUNTERS; ++i) {
+		switch (mci->source[i]) {
+		case COUNTER_SOURCE_NONE:
+			break;
+
+		case COUNTER_SOURCE_PERF:
+			assert(pi < ARRAY_SIZE(perf_data));
+			assert(mci->fd_perf != -1);
+
+			if (debug)
+				fprintf(stderr, "Reading msr counter via perf at %u: %llu\n", i, perf_data[pi]);
+
+			mci->data[i] = perf_data[pi];
+
+			++pi;
+			break;
+
+		case COUNTER_SOURCE_MSR:
+			assert(!no_msr);
+
+			if (get_msr(cpu, mci->msr[i], &mci->data[i]))
+				return -2 - i;
+
+			mci->data[i] &= mci->msr_mask[i];
+
+			if (debug)
+				fprintf(stderr, "Reading msr counter via msr at %u: %llu\n", i, mci->data[i]);
+
+			break;
+		}
+	}
+
+	BUILD_BUG_ON(NUM_MSR_COUNTERS != 3);
+	t->aperf = mci->data[MSR_RCI_INDEX_APERF];
+	t->mperf = mci->data[MSR_RCI_INDEX_MPERF];
+	t->smi_count = mci->data[MSR_RCI_INDEX_SMI];
+
+	return 0;
+}
+
 /*
  * get_counters(...)
  * migrate to cpu
@@ -3878,24 +3873,7 @@ int get_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 
 	t->tsc = rdtsc();	/* we are running on local CPU of interest */
 
-	if (DO_BIC(BIC_Avg_MHz) || DO_BIC(BIC_Busy) || DO_BIC(BIC_Bzy_MHz) || DO_BIC(BIC_IPC)
-	    || soft_c1_residency_display(BIC_Avg_MHz)) {
-		int status = -1;
-
-		assert(!no_perf || !no_msr);
-
-		switch (amperf_source) {
-		case AMPERF_SOURCE_PERF:
-			status = read_aperf_mperf_tsc_perf(t, cpu);
-			break;
-		case AMPERF_SOURCE_MSR:
-			status = read_aperf_mperf_tsc_msr(t, cpu);
-			break;
-		}
-
-		if (status != 0)
-			return status;
-	}
+	get_smi_aperf_mperf(cpu, t);
 
 	if (DO_BIC(BIC_IPC))
 		if (read(get_instr_count_fd(cpu), &t->instr_count, sizeof(long long)) != sizeof(long long))
@@ -3903,11 +3881,6 @@ int get_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 
 	if (DO_BIC(BIC_IRQ))
 		t->irq_count = irqs_per_cpu[cpu];
-	if (DO_BIC(BIC_SMI)) {
-		if (get_msr(cpu, MSR_SMI_COUNT, &msr))
-			return -5;
-		t->smi_count = msr & 0xFFFFFFFF;
-	}
 
 	get_cstate_counters(cpu, t, c, p);
 
@@ -4489,25 +4462,6 @@ void free_fd_percpu(void)
 	fd_percpu = NULL;
 }
 
-void free_fd_amperf_percpu(void)
-{
-	int i;
-
-	if (!fd_amperf_percpu)
-		return;
-
-	for (i = 0; i < topo.max_cpu_num + 1; ++i) {
-		if (fd_amperf_percpu[i].mperf != 0)
-			close(fd_amperf_percpu[i].mperf);
-
-		if (fd_amperf_percpu[i].aperf != 0)
-			close(fd_amperf_percpu[i].aperf);
-	}
-
-	free(fd_amperf_percpu);
-	fd_amperf_percpu = NULL;
-}
-
 void free_fd_instr_count_percpu(void)
 {
 	if (!fd_instr_count_percpu)
@@ -4542,6 +4496,21 @@ void free_fd_cstate(void)
 	ccstate_counter_info_size = 0;
 }
 
+void free_fd_msr(void)
+{
+	if (!msr_counter_info)
+		return;
+
+	for (int cpu = 0; cpu < topo.max_cpu_num; ++cpu) {
+		if (msr_counter_info[cpu].fd_perf != -1)
+			close(msr_counter_info[cpu].fd_perf);
+	}
+
+	free(msr_counter_info);
+	msr_counter_info = NULL;
+	msr_counter_info_size = 0;
+}
+
 void free_fd_rapl_percpu(void)
 {
 	if (!rapl_counter_info_perdomain)
@@ -4601,7 +4570,7 @@ void free_all_buffers(void)
 
 	free_fd_percpu();
 	free_fd_instr_count_percpu();
-	free_fd_amperf_percpu();
+	free_fd_msr();
 	free_fd_rapl_percpu();
 	free_fd_cstate();
 
@@ -4938,6 +4907,7 @@ static void update_effective_set(bool startup)
 }
 
 void linux_perf_init(void);
+void msr_perf_init(void);
 void rapl_perf_init(void);
 void cstate_perf_init(void);
 
@@ -4946,6 +4916,7 @@ void re_initialize(void)
 	free_all_buffers();
 	setup_all_buffers(false);
 	linux_perf_init();
+	msr_perf_init();
 	rapl_perf_init();
 	cstate_perf_init();
 	fprintf(outf, "turbostat: re-initialized with num_cpus %d, allowed_cpus %d\n", topo.num_cpus,
@@ -6799,15 +6770,6 @@ static int has_instr_count_access(void)
 	return has_access;
 }
 
-bool is_aperf_access_required(void)
-{
-	return BIC_IS_ENABLED(BIC_Avg_MHz)
-	    || BIC_IS_ENABLED(BIC_Busy)
-	    || BIC_IS_ENABLED(BIC_Bzy_MHz)
-	    || BIC_IS_ENABLED(BIC_IPC)
-	    || BIC_IS_ENABLED(BIC_CPU_c1);
-}
-
 int add_rapl_perf_counter_(int cpu, struct rapl_counter_info_t *rci, const struct rapl_counter_arch_info *cai,
 			   double *scale_, enum rapl_unit *unit_)
 {
@@ -6866,14 +6828,6 @@ void linux_perf_init(void)
 		if (fd_instr_count_percpu == NULL)
 			err(-1, "calloc fd_instr_count_percpu");
 	}
-
-	const bool aperf_required = is_aperf_access_required();
-
-	if (aperf_required && has_aperf && amperf_source == AMPERF_SOURCE_PERF) {
-		fd_amperf_percpu = calloc(topo.max_cpu_num + 1, sizeof(*fd_amperf_percpu));
-		if (fd_amperf_percpu == NULL)
-			err(-1, "calloc fd_amperf_percpu");
-	}
 }
 
 void rapl_perf_init(void)
@@ -6966,75 +6920,11 @@ void rapl_perf_init(void)
 	free(domain_visited);
 }
 
-static int has_amperf_access_via_msr(void)
-{
-	if (no_msr)
-		return 0;
-
-	if (probe_msr(base_cpu, MSR_IA32_APERF))
-		return 0;
-
-	if (probe_msr(base_cpu, MSR_IA32_MPERF))
-		return 0;
-
-	return 1;
-}
-
-static int has_amperf_access_via_perf(void)
-{
-	struct amperf_group_fd fds;
-
-	/*
-	 * Cache the last result, so we don't warn the user multiple times
-	 *
-	 * Negative means cached, no access
-	 * Zero means not cached
-	 * Positive means cached, has access
-	 */
-	static int has_access_cached;
-
-	if (no_perf)
-		return 0;
-
-	if (has_access_cached != 0)
-		return has_access_cached > 0;
-
-	fds = open_amperf_fd(base_cpu);
-	has_access_cached = (fds.aperf != -1) && (fds.mperf != -1);
-
-	if (fds.aperf == -1)
-		warnx("Failed to access %s. Some of the counters may not be available\n"
-		      "\tRun as root to enable them or use %s to disable the access explicitly",
-		      "APERF perf counter", "--no-perf");
-	else
-		close(fds.aperf);
-
-	if (fds.mperf == -1)
-		warnx("Failed to access %s. Some of the counters may not be available\n"
-		      "\tRun as root to enable them or use %s to disable the access explicitly",
-		      "MPERF perf counter", "--no-perf");
-	else
-		close(fds.mperf);
-
-	if (has_access_cached == 0)
-		has_access_cached = -1;
-
-	return has_access_cached > 0;
-}
-
-/* Check if we can access APERF and MPERF */
+/* Assumes msr_counter_info is populated */
 static int has_amperf_access(void)
 {
-	if (!is_aperf_access_required())
-		return 0;
-
-	if (!no_msr && has_amperf_access_via_msr())
-		return 1;
-
-	if (!no_perf && has_amperf_access_via_perf())
-		return 1;
-
-	return 0;
+	return msr_counter_arch_infos[MSR_ARCH_INFO_APERF_INDEX].present &&
+	    msr_counter_arch_infos[MSR_ARCH_INFO_MPERF_INDEX].present;
 }
 
 int *get_cstate_perf_group_fd(struct cstate_counter_info_t *cci, const char *group_name)
@@ -7083,6 +6973,114 @@ int add_cstate_perf_counter(int cpu, struct cstate_counter_info_t *cci, const st
 	return ret;
 }
 
+int add_msr_perf_counter_(int cpu, struct msr_counter_info_t *cci, const struct msr_counter_arch_info *cai)
+{
+	if (no_perf)
+		return -1;
+
+	const unsigned int type = read_perf_type(cai->perf_subsys);
+	const unsigned int config = read_rapl_config(cai->perf_subsys, cai->perf_name);
+
+	const int fd_counter = open_perf_counter(cpu, type, config, cci->fd_perf, PERF_FORMAT_GROUP);
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
+int add_msr_perf_counter(int cpu, struct msr_counter_info_t *cci, const struct msr_counter_arch_info *cai)
+{
+	int ret = add_msr_perf_counter_(cpu, cci, cai);
+
+	if (debug)
+		fprintf(stderr, "%s: %s/%s: %d (cpu: %d)\n", __func__, cai->perf_subsys, cai->perf_name, ret, cpu);
+
+	return ret;
+}
+
+void msr_perf_init_(void)
+{
+	const int mci_num = topo.max_cpu_num + 1;
+
+	msr_counter_info = calloc(mci_num, sizeof(*msr_counter_info));
+	if (!msr_counter_info)
+		err(1, "calloc msr_counter_info");
+	msr_counter_info_size = mci_num;
+
+	for (int cpu = 0; cpu < mci_num; ++cpu)
+		msr_counter_info[cpu].fd_perf = -1;
+
+	for (int cidx = 0; cidx < NUM_MSR_COUNTERS; ++cidx) {
+
+		struct msr_counter_arch_info *cai = &msr_counter_arch_infos[cidx];
+
+		cai->present = false;
+
+		for (int cpu = 0; cpu < mci_num; ++cpu) {
+
+			struct msr_counter_info_t *const cci = &msr_counter_info[cpu];
+
+			if (cpu_is_not_allowed(cpu))
+				continue;
+
+			if (cai->needed) {
+				/* Use perf API for this counter */
+				if (!no_perf && cai->perf_name && add_msr_perf_counter(cpu, cci, cai) != -1) {
+					cci->source[cai->rci_index] = COUNTER_SOURCE_PERF;
+					cai->present = true;
+
+					/* User MSR for this counter */
+				} else if (!no_msr && cai->msr && probe_msr(cpu, cai->msr) == 0) {
+					cci->source[cai->rci_index] = COUNTER_SOURCE_MSR;
+					cci->msr[cai->rci_index] = cai->msr;
+					cci->msr_mask[cai->rci_index] = cai->msr_mask;
+					cai->present = true;
+				}
+			}
+		}
+	}
+}
+
+/* Initialize data for reading perf counters from the MSR group. */
+void msr_perf_init(void)
+{
+	bool need_amperf = false, need_smi = false;
+	const bool need_soft_c1 = (!platform->has_msr_core_c1_res) && (platform->supported_cstates & CC1);
+
+	need_amperf = BIC_IS_ENABLED(BIC_Avg_MHz) || BIC_IS_ENABLED(BIC_Busy) || BIC_IS_ENABLED(BIC_Bzy_MHz)
+	    || BIC_IS_ENABLED(BIC_IPC) || need_soft_c1;
+
+	if (BIC_IS_ENABLED(BIC_SMI))
+		need_smi = true;
+
+	/* Enable needed counters */
+	msr_counter_arch_infos[MSR_ARCH_INFO_APERF_INDEX].needed = need_amperf;
+	msr_counter_arch_infos[MSR_ARCH_INFO_MPERF_INDEX].needed = need_amperf;
+	msr_counter_arch_infos[MSR_ARCH_INFO_SMI_INDEX].needed = need_smi;
+
+	msr_perf_init_();
+
+	const bool has_amperf = has_amperf_access();
+	const bool has_smi = msr_counter_arch_infos[MSR_ARCH_INFO_SMI_INDEX].present;
+
+	has_aperf_access = has_amperf;
+
+	if (has_amperf) {
+		BIC_PRESENT(BIC_Avg_MHz);
+		BIC_PRESENT(BIC_Busy);
+		BIC_PRESENT(BIC_Bzy_MHz);
+		BIC_PRESENT(BIC_SMI);
+	}
+
+	if (has_smi)
+		BIC_PRESENT(BIC_SMI);
+}
+
 void cstate_perf_init_(bool soft_c1)
 {
 	bool has_counter;
@@ -7340,12 +7338,6 @@ void process_cpuid()
 
 	__cpuid(0x6, eax, ebx, ecx, edx);
 	has_aperf = ecx & (1 << 0);
-	if (has_aperf && has_amperf_access()) {
-		BIC_PRESENT(BIC_Avg_MHz);
-		BIC_PRESENT(BIC_Busy);
-		BIC_PRESENT(BIC_Bzy_MHz);
-		BIC_PRESENT(BIC_IPC);
-	}
 	do_dts = eax & (1 << 0);
 	if (do_dts)
 		BIC_PRESENT(BIC_CoreTmp);
@@ -7462,6 +7454,11 @@ static void counter_info_init(void)
 		if (platform->has_msr_atom_pkg_c6_residency && cai->msr == MSR_PKG_C6_RESIDENCY)
 			cai->msr = MSR_ATOM_PKG_C6_RESIDENCY;
 	}
+
+	for (int i = 0; i < NUM_MSR_COUNTERS; ++i) {
+		msr_counter_arch_infos[i].present = false;
+		msr_counter_arch_infos[i].needed = false;
+	}
 }
 
 void probe_pm_features(void)
@@ -7837,21 +7834,6 @@ void set_base_cpu(void)
 	err(-ENODEV, "No valid cpus found");
 }
 
-static void set_amperf_source(void)
-{
-	amperf_source = AMPERF_SOURCE_PERF;
-
-	const bool aperf_required = is_aperf_access_required();
-
-	if (no_perf || !aperf_required || !has_amperf_access_via_perf())
-		amperf_source = AMPERF_SOURCE_MSR;
-
-	if (quiet || !debug)
-		return;
-
-	fprintf(outf, "aperf/mperf source preference: %s\n", amperf_source == AMPERF_SOURCE_MSR ? "msr" : "perf");
-}
-
 bool has_added_counters(void)
 {
 	/*
@@ -7862,54 +7844,8 @@ bool has_added_counters(void)
 	return sys.added_core_counters | sys.added_thread_counters | sys.added_package_counters;
 }
 
-bool is_msr_access_required(void)
-{
-	if (no_msr)
-		return false;
-
-	if (has_added_counters())
-		return true;
-
-	return BIC_IS_ENABLED(BIC_SMI)
-	    || BIC_IS_ENABLED(BIC_CPU_c1)
-	    || BIC_IS_ENABLED(BIC_CPU_c3)
-	    || BIC_IS_ENABLED(BIC_CPU_c6)
-	    || BIC_IS_ENABLED(BIC_CPU_c7)
-	    || BIC_IS_ENABLED(BIC_Mod_c6)
-	    || BIC_IS_ENABLED(BIC_CoreTmp)
-	    || BIC_IS_ENABLED(BIC_Totl_c0)
-	    || BIC_IS_ENABLED(BIC_Any_c0)
-	    || BIC_IS_ENABLED(BIC_GFX_c0)
-	    || BIC_IS_ENABLED(BIC_CPUGFX)
-	    || BIC_IS_ENABLED(BIC_Pkgpc3)
-	    || BIC_IS_ENABLED(BIC_Pkgpc6)
-	    || BIC_IS_ENABLED(BIC_Pkgpc2)
-	    || BIC_IS_ENABLED(BIC_Pkgpc7)
-	    || BIC_IS_ENABLED(BIC_Pkgpc8)
-	    || BIC_IS_ENABLED(BIC_Pkgpc9)
-	    || BIC_IS_ENABLED(BIC_Pkgpc10)
-	    /* TODO: Multiplex access with perf */
-	    || BIC_IS_ENABLED(BIC_CorWatt)
-	    || BIC_IS_ENABLED(BIC_Cor_J)
-	    || BIC_IS_ENABLED(BIC_PkgWatt)
-	    || BIC_IS_ENABLED(BIC_CorWatt)
-	    || BIC_IS_ENABLED(BIC_GFXWatt)
-	    || BIC_IS_ENABLED(BIC_RAMWatt)
-	    || BIC_IS_ENABLED(BIC_Pkg_J)
-	    || BIC_IS_ENABLED(BIC_Cor_J)
-	    || BIC_IS_ENABLED(BIC_GFX_J)
-	    || BIC_IS_ENABLED(BIC_RAM_J)
-	    || BIC_IS_ENABLED(BIC_PKG__)
-	    || BIC_IS_ENABLED(BIC_RAM__)
-	    || BIC_IS_ENABLED(BIC_PkgTmp)
-	    || (is_aperf_access_required() && !has_amperf_access_via_perf());
-}
-
 void check_msr_access(void)
 {
-	if (!is_msr_access_required())
-		no_msr = 1;
-
 	check_dev_msr();
 	check_msr_permission();
 
@@ -7919,19 +7855,8 @@ void check_msr_access(void)
 
 void check_perf_access(void)
 {
-	const bool intrcount_required = BIC_IS_ENABLED(BIC_IPC);
-
-	if (no_perf || !intrcount_required || !has_instr_count_access())
+	if (no_perf || !BIC_IS_ENABLED(BIC_IPC) || !has_instr_count_access())
 		bic_enabled &= ~BIC_IPC;
-
-	const bool aperf_required = is_aperf_access_required();
-
-	if (!aperf_required || !has_amperf_access()) {
-		bic_enabled &= ~BIC_Avg_MHz;
-		bic_enabled &= ~BIC_Busy;
-		bic_enabled &= ~BIC_Bzy_MHz;
-		bic_enabled &= ~BIC_IPC;
-	}
 }
 
 void turbostat_init()
@@ -7943,7 +7868,7 @@ void turbostat_init()
 	process_cpuid();
 	counter_info_init();
 	probe_pm_features();
-	set_amperf_source();
+	msr_perf_init();
 	linux_perf_init();
 	rapl_perf_init();
 	cstate_perf_init();
@@ -7951,8 +7876,8 @@ void turbostat_init()
 	for_all_cpus(get_cpu_type, ODD_COUNTERS);
 	for_all_cpus(get_cpu_type, EVEN_COUNTERS);
 
-	if (DO_BIC(BIC_IPC))
-		(void)get_instr_count_fd(base_cpu);
+	if (BIC_IS_ENABLED(BIC_IPC) && has_aperf_access && get_instr_count_fd(base_cpu) != -1)
+		BIC_PRESENT(BIC_IPC);
 
 	/*
 	 * If TSC tweak is needed, but couldn't get it,
-- 
2.43.0


