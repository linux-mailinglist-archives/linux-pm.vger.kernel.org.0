Return-Path: <linux-pm+bounces-2161-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B21782BFFD
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jan 2024 13:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B45101F24ADC
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jan 2024 12:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3E559B59;
	Fri, 12 Jan 2024 12:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ChYCfxlw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CFC6BB2F
	for <linux-pm@vger.kernel.org>; Fri, 12 Jan 2024 12:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705063756; x=1736599756;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ggmgc7eG0KYdbb8K3cKPSE4JX2hcKTybeoQ3VrNjiaM=;
  b=ChYCfxlwMz7fRHlQo9hDyR454JX0iBlzfumGKNCnwTwvPDsPFnsH66rz
   K5w2hMFlBFpyyKAEErhFeiRsitGR39ev7b1JmrtTek2eznbYK1S9hhpmf
   u+/Uo8f5HbiCARU9l0m75+HGgYl7t9rUTljW8FdQ/w9yJwbnIRL/kK+Xo
   wIxIFf/yV3tJ+BrUm7myTIocR4NbASJyRfL+XijDaRAjm+IQQzabQ5AsZ
   P0fvxyd/Fb8IK1PlQW+X9YH3ZVoZM6i96Rym+Nuc52x0oRNfxvMOh/941
   2dTihyrAeYFfdyos7sRMr64FtQAn/bzKJnD/vk8wDPV3ix8+Dq4p/3ltw
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="6525669"
X-IronPort-AV: E=Sophos;i="6.04,189,1695711600"; 
   d="scan'208";a="6525669"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 04:49:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,189,1695711600"; 
   d="scan'208";a="17390872"
Received: from pwlazlyn-mobl.ger.corp.intel.com (HELO pwlazlyn) ([10.246.16.73])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 04:49:14 -0800
From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
To: len.brown@intel.com
Cc: linux-pm@vger.kernel.org
Subject: [PATCH 4/4] tools/power turbostat: Add reading aperf and mperf via perf API
Date: Fri, 12 Jan 2024 13:48:15 +0100
Message-Id: <20240112124815.970-5-patryk.wlazlyn@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240112124815.970-1-patryk.wlazlyn@linux.intel.com>
References: <20240112124815.970-1-patryk.wlazlyn@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reading the counters via perf API is *usually* faster than going through
the msr driver, mainly because we do less syscalls, which also helps
with narrowing the gap between the reads. Getting cache misses on the
perf path does cost more and this is where the "usually faster" comes
from.

We would fallback to the msr reads if the sysfs isn't there or when in
--no-perf mode.

Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 345 +++++++++++++++++++++-----
 1 file changed, 277 insertions(+), 68 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index bf733e7d73b5..d85e38cbadcb 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -57,6 +57,7 @@
 enum counter_scope { SCOPE_CPU, SCOPE_CORE, SCOPE_PACKAGE };
 enum counter_type { COUNTER_ITEMS, COUNTER_CYCLES, COUNTER_SECONDS, COUNTER_USEC };
 enum counter_format { FORMAT_RAW, FORMAT_DELTA, FORMAT_PERCENT };
+enum xperf_source { XPERF_SOURCE_PERF, XPERF_SOURCE_MSR };
 
 struct msr_counter {
 	unsigned int msr_num;
@@ -209,6 +210,7 @@ char *proc_stat = "/proc/stat";
 FILE *outf;
 int *fd_percpu;
 int *fd_instr_count_percpu;
+int *fd_xperf_percpu; /* File descriptors for perf group with APERF and MPERF counters. */
 struct timeval interval_tv = { 5, 0 };
 struct timespec interval_ts = { 5, 0 };
 
@@ -266,6 +268,7 @@ unsigned int first_counter_read = 1;
 int ignore_stdin;
 bool no_msr;
 bool no_perf;
+enum xperf_source xperf_source;
 
 int get_msr(int cpu, off_t offset, unsigned long long *msr);
 
@@ -1336,18 +1339,27 @@ static long perf_event_open(struct perf_event_attr *hw_event, pid_t pid, int cpu
 	return syscall(__NR_perf_event_open, hw_event, pid, cpu, group_fd, flags);
 }
 
-static int perf_instr_count_open(int cpu_num)
+static long open_perf_counter(
+	int cpu,
+	unsigned type,
+	unsigned config,
+	int group_fd,
+	__u64 read_format)
 {
-	struct perf_event_attr pea;
-	int fd;
+	struct perf_event_attr attr;
+	const pid_t pid = -1;
+	const unsigned long flags = 0;
+
+	memset(&attr, 0, sizeof(struct perf_event_attr));
 
-	memset(&pea, 0, sizeof(struct perf_event_attr));
-	pea.type = PERF_TYPE_HARDWARE;
-	pea.size = sizeof(struct perf_event_attr);
-	pea.config = PERF_COUNT_HW_INSTRUCTIONS;
+	attr.type = type;
+	attr.size = sizeof(struct perf_event_attr);
+	attr.config = config;
+	attr.disabled = 0;
+	attr.sample_type = PERF_SAMPLE_IDENTIFIER;
+	attr.read_format = read_format;
 
-	/* counter for cpu_num, including user + kernel and all processes */
-	fd = perf_event_open(&pea, -1, cpu_num, -1, 0);
+	const int fd = perf_event_open(&attr, pid, cpu, group_fd, flags);
 	if (fd == -1) {
 		warnx("capget(CAP_PERFMON) failed, try \"# setcap cap_sys_admin=ep %s\""
 		      " or use --no-perf", progname);
@@ -1362,7 +1374,7 @@ int get_instr_count_fd(int cpu)
 	if (fd_instr_count_percpu[cpu])
 		return fd_instr_count_percpu[cpu];
 
-	fd_instr_count_percpu[cpu] = perf_instr_count_open(cpu);
+	fd_instr_count_percpu[cpu] = open_perf_counter(cpu, PERF_TYPE_HARDWARE, PERF_COUNT_HW_INSTRUCTIONS, -1, 0);
 
 	return fd_instr_count_percpu[cpu];
 }
@@ -2753,6 +2765,182 @@ int get_core_throt_cnt(int cpu, unsigned long long *cnt)
 	return 0;
 }
 
+static unsigned read_perf_counter_info(
+	const char * const path,
+	const char * const parse_format)
+{
+	int fdmt;
+	char buf[16];
+	unsigned v;
+
+	fdmt = open(path, O_RDONLY, 0);
+	if (fdmt == -1)
+		errx(1, "Failed to read perf counter info %s\n", path);
+
+	if (read(fdmt, buf, sizeof(buf)) <= 0)
+		return 0;
+
+	buf[sizeof(buf)-1] = '\0';
+
+	if (sscanf(buf, parse_format, &v) != 1)
+		errx(1, "Failed to parse perf counter info %s\n", path);
+
+	close(fdmt);
+
+	return v;
+}
+
+static unsigned read_msr_type(void)
+{
+	const char * const path = "/sys/bus/event_source/devices/msr/type";
+	const char * const format = "%u";
+
+	return read_perf_counter_info(path, format);
+}
+
+static unsigned read_aperf_config(void)
+{
+	const char * const path = "/sys/bus/event_source/devices/msr/events/aperf";
+	const char * const format = "event=%x";
+
+	return read_perf_counter_info(path, format);
+}
+
+static unsigned read_mperf_config(void)
+{
+	const char * const path = "/sys/bus/event_source/devices/msr/events/mperf";
+	const char * const format = "event=%x";
+
+	return read_perf_counter_info(path, format);
+}
+
+static int open_xperf_fd(int cpu)
+{
+	const unsigned msr_type = read_msr_type();
+	const unsigned aperf_config = read_aperf_config();
+	const unsigned mperf_config = read_mperf_config();
+	int fd_aperf = -1, fd_mperf = -1;
+
+	fd_aperf = open_perf_counter(cpu, msr_type, aperf_config, -1, PERF_FORMAT_GROUP);
+	if (fd_aperf == -1) {
+		perror("open_perf_counter aperf");
+		return 0;
+	}
+
+	fd_mperf = open_perf_counter(cpu, msr_type, mperf_config, fd_aperf, PERF_FORMAT_GROUP);
+	if (fd_mperf == -1) {
+		perror("open_perf_counter mperf");
+		close(fd_aperf);
+		return 0;
+	}
+
+	return fd_aperf;
+}
+
+static int get_xperf_fd(int cpu)
+{
+	assert(fd_xperf_percpu);
+
+	if (fd_xperf_percpu[cpu])
+		return fd_xperf_percpu[cpu];
+
+	fd_xperf_percpu[cpu] = open_xperf_fd(cpu);
+
+	return fd_xperf_percpu[cpu];
+}
+
+/* Read APERF, MPERF and TSC using the perf API. */
+static int read_aperf_mperf_tsc_perf(struct thread_data *t, int cpu)
+{
+	union {
+		struct {
+			unsigned long nr_entries;
+			unsigned long aperf;
+			unsigned long mperf;
+		};
+
+		unsigned long as_array[3];
+	} cnt;
+
+	const int fd_xperf = get_xperf_fd(cpu);
+
+	/*
+	 * Read the TSC with rdtsc, because we want the absolute value and not
+	 * the offset from the start of the process.
+	 */
+	t->tsc = rdtsc();
+
+	const int n = read(fd_xperf, &cnt.as_array[0], sizeof(cnt.as_array));
+	if (n != sizeof(cnt.as_array))
+		return 1;
+
+	t->aperf = cnt.aperf * aperf_mperf_multiplier;
+	t->mperf = cnt.mperf * aperf_mperf_multiplier;
+
+	return 0;
+}
+
+/* Read APERF, MPERF and TSC using the MSR driver and rdtsc instruction. */
+static int read_aperf_mperf_tsc_msr(struct thread_data *t, int cpu)
+{
+	unsigned long long tsc_before, tsc_between, tsc_after, aperf_time, mperf_time;
+	int aperf_mperf_retry_count = 0;
+
+	/*
+	 * The TSC, APERF and MPERF must be read together for
+	 * APERF/MPERF and MPERF/TSC to give accurate results.
+	 *
+	 * Unfortunately, APERF and MPERF are read by
+	 * individual system call, so delays may occur
+	 * between them.  If the time to read them
+	 * varies by a large amount, we re-read them.
+	 */
+
+	/*
+	 * This initial dummy APERF read has been seen to
+	 * reduce jitter in the subsequent reads.
+	 */
+
+	if (get_msr(cpu, MSR_IA32_APERF, &t->aperf))
+		return -3;
+
+retry:
+	t->tsc = rdtsc();	/* re-read close to APERF */
+
+	tsc_before = t->tsc;
+
+	if (get_msr(cpu, MSR_IA32_APERF, &t->aperf))
+		return -3;
+
+	tsc_between = rdtsc();
+
+	if (get_msr(cpu, MSR_IA32_MPERF, &t->mperf))
+		return -4;
+
+	tsc_after = rdtsc();
+
+	aperf_time = tsc_between - tsc_before;
+	mperf_time = tsc_after - tsc_between;
+
+	/*
+	 * If the system call latency to read APERF and MPERF
+	 * differ by more than 2x, then try again.
+	 */
+	if ((aperf_time > (2 * mperf_time)) || (mperf_time > (2 * aperf_time))) {
+		aperf_mperf_retry_count++;
+		if (aperf_mperf_retry_count < 5)
+			goto retry;
+		else
+			warnx("cpu%d jitter %lld %lld", cpu, aperf_time, mperf_time);
+	}
+	aperf_mperf_retry_count = 0;
+
+	t->aperf = t->aperf * aperf_mperf_multiplier;
+	t->mperf = t->mperf * aperf_mperf_multiplier;
+
+	return 0;
+}
+
 /*
  * get_counters(...)
  * migrate to cpu
@@ -2762,7 +2950,6 @@ int get_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 {
 	int cpu = t->cpu_id;
 	unsigned long long msr;
-	int aperf_mperf_retry_count = 0;
 	struct msr_counter *mp;
 	int i;
 
@@ -2775,63 +2962,26 @@ int get_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 
 	if (first_counter_read)
 		get_apic_id(t);
-retry:
+
 	t->tsc = rdtsc();	/* we are running on local CPU of interest */
 
 	if (DO_BIC(BIC_Avg_MHz) || DO_BIC(BIC_Busy) || DO_BIC(BIC_Bzy_MHz) || DO_BIC(BIC_IPC)
 	    || soft_c1_residency_display(BIC_Avg_MHz)) {
-		unsigned long long tsc_before, tsc_between, tsc_after, aperf_time, mperf_time;
+		int status = -1;
 
-		/*
-		 * The TSC, APERF and MPERF must be read together for
-		 * APERF/MPERF and MPERF/TSC to give accurate results.
-		 *
-		 * Unfortunately, APERF and MPERF are read by
-		 * individual system call, so delays may occur
-		 * between them.  If the time to read them
-		 * varies by a large amount, we re-read them.
-		 */
+		assert(!no_perf || !no_msr);
 
-		/*
-		 * This initial dummy APERF read has been seen to
-		 * reduce jitter in the subsequent reads.
-		 */
-
-		if (get_msr(cpu, MSR_IA32_APERF, &t->aperf))
-			return -3;
-
-		t->tsc = rdtsc();	/* re-read close to APERF */
-
-		tsc_before = t->tsc;
-
-		if (get_msr(cpu, MSR_IA32_APERF, &t->aperf))
-			return -3;
-
-		tsc_between = rdtsc();
-
-		if (get_msr(cpu, MSR_IA32_MPERF, &t->mperf))
-			return -4;
-
-		tsc_after = rdtsc();
-
-		aperf_time = tsc_between - tsc_before;
-		mperf_time = tsc_after - tsc_between;
-
-		/*
-		 * If the system call latency to read APERF and MPERF
-		 * differ by more than 2x, then try again.
-		 */
-		if ((aperf_time > (2 * mperf_time)) || (mperf_time > (2 * aperf_time))) {
-			aperf_mperf_retry_count++;
-			if (aperf_mperf_retry_count < 5)
-				goto retry;
-			else
-				warnx("cpu%d jitter %lld %lld", cpu, aperf_time, mperf_time);
+		switch (xperf_source) {
+			case XPERF_SOURCE_PERF:
+				status = read_aperf_mperf_tsc_perf(t, cpu);
+				break;
+			case XPERF_SOURCE_MSR:
+				status = read_aperf_mperf_tsc_msr(t, cpu);
+				break;
 		}
-		aperf_mperf_retry_count = 0;
 
-		t->aperf = t->aperf * aperf_mperf_multiplier;
-		t->mperf = t->mperf * aperf_mperf_multiplier;
+		if (status != 0)
+			return status;
 	}
 
 	if (DO_BIC(BIC_IPC))
@@ -5597,17 +5747,50 @@ void print_dev_latency(void)
  */
 void linux_perf_init(void)
 {
-	if (!BIC_IS_ENABLED(BIC_IPC))
-		return;
-
 	if (access("/proc/sys/kernel/perf_event_paranoid", F_OK))
 		return;
 
-	fd_instr_count_percpu = calloc(topo.max_cpu_num + 1, sizeof(int));
-	if (fd_instr_count_percpu == NULL)
-		err(-1, "calloc fd_instr_count_percpu");
+	if (BIC_IS_ENABLED(BIC_IPC)) {
+		fd_instr_count_percpu = calloc(topo.max_cpu_num + 1, sizeof(int));
+		if (fd_instr_count_percpu == NULL)
+			err(-1, "calloc fd_instr_count_percpu");
 
-	BIC_PRESENT(BIC_IPC);
+		BIC_PRESENT(BIC_IPC);
+	}
+
+	const bool aperf_required = DO_BIC(BIC_Avg_MHz) || DO_BIC(BIC_Busy) ||
+				    DO_BIC(BIC_Bzy_MHz) || DO_BIC(BIC_IPC);
+	if (aperf_required && xperf_source == XPERF_SOURCE_PERF) {
+		fd_xperf_percpu = calloc(topo.max_cpu_num + 1, sizeof(int));
+		if (fd_xperf_percpu == NULL)
+			err(-1, "calloc fd_xperf_percpu");
+	}
+}
+
+static int has_xperf_access_via_perf(void)
+{
+	if (access("/sys/bus/event_source/devices/msr/type", F_OK))
+		return 0;
+
+	if (access("/sys/bus/event_source/devices/msr/events/aperf", F_OK))
+		return 0;
+
+	if (access("/sys/bus/event_source/devices/msr/events/mperf", F_OK))
+		return 0;
+
+	return 1;
+}
+
+/* Check if we can access APERF and MPERF */
+static int has_xperf_access(void)
+{
+	if (!no_msr)
+		return 1;
+
+	if (!no_perf && has_xperf_access_via_perf())
+		return 1;
+
+	return 0;
 }
 
 void probe_cstates(void)
@@ -5795,7 +5978,7 @@ void process_cpuid()
 
 	__cpuid(0x6, eax, ebx, ecx, edx);
 	has_aperf = ecx & (1 << 0);
-	if (has_aperf) {
+	if (has_aperf && has_xperf_access()) {
 		BIC_PRESENT(BIC_Avg_MHz);
 		BIC_PRESENT(BIC_Busy);
 		BIC_PRESENT(BIC_Bzy_MHz);
@@ -6264,6 +6447,20 @@ void set_base_cpu(void)
 	err(-ENODEV, "No valid cpus found");
 }
 
+static void set_xperf_source(void)
+{
+	xperf_source = XPERF_SOURCE_PERF;
+
+	if (no_perf || !has_xperf_access_via_perf())
+		xperf_source = XPERF_SOURCE_MSR;
+
+	if (quiet)
+		return;
+
+	fprintf(outf, "aperf/mperf source: %s\n",
+		xperf_source == XPERF_SOURCE_MSR ? "msr" : "perf");
+}
+
 void turbostat_init()
 {
 	setup_all_buffers(true);
@@ -6272,6 +6469,7 @@ void turbostat_init()
 	check_permissions();
 	process_cpuid();
 	probe_pm_features();
+	set_xperf_source();
 	linux_perf_init();
 
 	for_all_cpus(get_cpu_type, ODD_COUNTERS);
@@ -6859,6 +7057,17 @@ int main(int argc, char **argv)
 
 	turbostat_init();
 
+	/*
+	 * We can't get TSC tweak in no-msr mode,
+	 * so have to disable more BICs, since we can't report them accurately.
+	 */
+	if (platform->enable_tsc_tweak && no_msr) {
+		bic_enabled &= ~BIC_Avg_MHz;
+		bic_enabled &= ~BIC_Busy;
+		bic_enabled &= ~BIC_Bzy_MHz;
+		bic_enabled &= ~BIC_IPC;
+	}
+
 	if (!no_msr)
 		msr_sum_record();
 
-- 
2.43.0


