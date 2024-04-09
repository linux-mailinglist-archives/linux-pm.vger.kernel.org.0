Return-Path: <linux-pm+bounces-6084-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C393D89CF68
	for <lists+linux-pm@lfdr.de>; Tue,  9 Apr 2024 02:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E568B23548
	for <lists+linux-pm@lfdr.de>; Tue,  9 Apr 2024 00:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C166FA7;
	Tue,  9 Apr 2024 00:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFm+pHJk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A1E63B9
	for <linux-pm@vger.kernel.org>; Tue,  9 Apr 2024 00:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712622716; cv=none; b=Ai0z2ZJpsofJDoFlbWlQe7zEb6yxtoHxITdjYkS3ITtXi39czqtoVb3cj3HBL6dApOz2+TcRgL2XvyYXCXJ+qw8jJY/DQ3iQwQHXN0MJSCzWaMINkESjOz7CG4OY5qRk0D6gQGAXVbxKgQbkm/XdubYY8dStslRtItHTFTrdyiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712622716; c=relaxed/simple;
	bh=9u4LDygUSJNbvCcPxY32luG48Ykc4+WI7oADho3SoZo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lx4R3zh4J6fJ8p9pzQfOIGShS1budJGLXuSjlQQjv+hXFcsBVQyXs3ccPIcmdNGJWsNY3k3ybITKofI29g/DXizEo1Vh5VV+ubbtGtVlXOVcka1lA+4DjKDN25xniN9cpmtjZdKIgSqz8cBdVtFwENpOyN4AVTWG4iH1DdBsqb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XFm+pHJk; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dcc80d6006aso4934578276.0
        for <linux-pm@vger.kernel.org>; Mon, 08 Apr 2024 17:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712622713; x=1713227513; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1aqLo7FxmYNAeq1PrSoXqNG3uLgrhRemYSont5YDwgY=;
        b=XFm+pHJk9hET9BmVsfzCibZWEvULD6EZPgwxddD043DfI2o02+9SRTOGMvr7shoXaw
         nfZtJter2e/9iTBIgyT+dXioAwAYiH7fmt2Xj5xvgZ6XCfmFj6aewrddMe203MMpZ5Su
         C/zIHg8i5FESp5zWsmc72ZNds9gFmFLtZKYCJYJ8IFbVDt5fGt+CV3D7Z1Z3AnrN666c
         IXT4TKV9OefxuGBr77AVnbT7Kmj0maycscGBuieUbikSHcDCG93ydKuSA4NfsaVl84uE
         jbDAzg2QfUjOdnsvIZdsP6kinnptKB4XnKlQteUp/zPT4coWNcTKqz8yMM+19xkm+1dd
         3dsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712622713; x=1713227513;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1aqLo7FxmYNAeq1PrSoXqNG3uLgrhRemYSont5YDwgY=;
        b=gcQ/X5e5aQ8zvZ5cuzNTlw+/jeUjd4VntyODNXV0dIQzhHJuL+/16jSc6cpzwGEKir
         y8+pq53rgDt3qK06UAk7vyM+bT45N+LMoAmEtH8xoa+aC3qfrk8TZzLZKYMYGRxf3Oug
         IWdf+y17dtajFv3Pi2l2EOIPSjVik43Z34ha4dCOajJ3m83y/BRi8oNGVeaCL9W+ZUpC
         jZfo8stdK6RztxKUFD/THdc4Tf9qPnLYr9nlZdJ8Rjx0KicUoL70X3KognqQ0MyBVcEE
         RE41Lg3aAz3UGYsi6nc+FjPEfwybGS3ZGZ8jFnT6+uGJwVjx49ZrwBIuGfona1Ku9QoA
         g8IA==
X-Gm-Message-State: AOJu0YzhdRjbLgUoF45JfboPlO7QIPScrvWQOUtUlAr39kQ5FyRJjuNm
	s4v01aRgPXLkDqboUzI5VGRyy4/atLP0yIj0hTOFmYPT5w9amgU8P5K+Xw+3
X-Google-Smtp-Source: AGHT+IE3IvGbveZIIs3VOJMkdvLgN/FUAVwbW6cuszLR4/y0zdrH/UbQ9F5f/gxFCvMVRfjVkavzPQ==
X-Received: by 2002:a25:7189:0:b0:dc6:cc35:35e9 with SMTP id m131-20020a257189000000b00dc6cc3535e9mr7452885ybc.35.1712622712910;
        Mon, 08 Apr 2024 17:31:52 -0700 (PDT)
Received: from lenb-Intel-NUC8i7HVKVA.search.charter.net (2603-9000-9f01-67cf-100c-5508-c194-b194.inf6.spectrum.com. [2603:9000:9f01:67cf:100c:5508:c194:b194])
        by smtp.gmail.com with ESMTPSA id h6-20020a25e206000000b00dc74ac54f5fsm1531949ybe.63.2024.04.08.17.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 17:31:52 -0700 (PDT)
Sender: Len Brown <lenb417@gmail.com>
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 12/26] tools/power turbostat: Add reading aperf and mperf via perf API
Date: Mon,  8 Apr 2024 20:31:06 -0400
Message-Id: <e48934c9f1048ed4640b60321baf1986d1a470e1.1712621427.git.len.brown@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <e5f4e68eed85fa8495d78cd966eecc2b27bb9e53.1712621427.git.len.brown@intel.com>
References: <e5f4e68eed85fa8495d78cd966eecc2b27bb9e53.1712621427.git.len.brown@intel.com>
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

By using the perf API we spend less time in between the reads of the
counters, resulting in more accurate calculations of the dependent
metrics.

Using perf API is also usually faster overall, although cache miss, if
we get one, is more costly when using perf vs MSR driver.

We would fallback to the msr reads if the sysfs isn't there or when in
--no-perf mode.

Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 374 +++++++++++++++++++++-----
 1 file changed, 301 insertions(+), 73 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index bad2fec7f342..1294c46c2170 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -59,6 +59,7 @@
 enum counter_scope { SCOPE_CPU, SCOPE_CORE, SCOPE_PACKAGE };
 enum counter_type { COUNTER_ITEMS, COUNTER_CYCLES, COUNTER_SECONDS, COUNTER_USEC };
 enum counter_format { FORMAT_RAW, FORMAT_DELTA, FORMAT_PERCENT };
+enum amperf_source { AMPERF_SOURCE_PERF, AMPERF_SOURCE_MSR };
 
 struct msr_counter {
 	unsigned int msr_num;
@@ -207,10 +208,13 @@ unsigned long long bic_present = BIC_USEC | BIC_TOD | BIC_sysfs | BIC_APIC | BIC
 #define BIC_NOT_PRESENT(COUNTER_BIT) (bic_present &= ~COUNTER_BIT)
 #define BIC_IS_ENABLED(COUNTER_BIT) (bic_enabled & COUNTER_BIT)
 
+struct amperf_group_fd;
+
 char *proc_stat = "/proc/stat";
 FILE *outf;
 int *fd_percpu;
 int *fd_instr_count_percpu;
+struct amperf_group_fd *fd_amperf_percpu;	/* File descriptors for perf group with APERF and MPERF counters. */
 struct timeval interval_tv = { 5, 0 };
 struct timespec interval_ts = { 5, 0 };
 
@@ -268,6 +272,7 @@ unsigned int first_counter_read = 1;
 int ignore_stdin;
 bool no_msr;
 bool no_perf;
+enum amperf_source amperf_source;
 
 int get_msr(int cpu, off_t offset, unsigned long long *msr);
 
@@ -1296,9 +1301,6 @@ int get_msr_fd(int cpu)
 static void bic_disable_msr_access(void)
 {
 	const unsigned long bic_msrs =
-	    BIC_Avg_MHz |
-	    BIC_Busy |
-	    BIC_Bzy_MHz |
 	    BIC_SMI |
 	    BIC_CPU_c1 |
 	    BIC_CPU_c3 |
@@ -1329,21 +1331,30 @@ static long perf_event_open(struct perf_event_attr *hw_event, pid_t pid, int cpu
 	return syscall(__NR_perf_event_open, hw_event, pid, cpu, group_fd, flags);
 }
 
-static int perf_instr_count_open(int cpu_num)
+static long open_perf_counter_or_fail(int cpu, unsigned int type, unsigned int config, int group_fd, __u64 read_format)
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
-		warnx("capget(CAP_PERFMON) failed, try \"# setcap cap_sys_admin=ep %s\" or use --no-perf", progname);
-		bic_disable_perf_access();
+		if (errno == EACCES) {
+			errx(1, "capget(CAP_PERFMON) failed, try \"# setcap cap_sys_admin=ep %s\""
+			     " or use --no-perf or run as root", progname);
+		} else {
+			perror("perf_event_open");
+			errx(1, "use --no-perf or run as root");
+		}
 	}
 
 	return fd;
@@ -1354,7 +1365,8 @@ int get_instr_count_fd(int cpu)
 	if (fd_instr_count_percpu[cpu])
 		return fd_instr_count_percpu[cpu];
 
-	fd_instr_count_percpu[cpu] = perf_instr_count_open(cpu);
+	fd_instr_count_percpu[cpu] =
+	    open_perf_counter_or_fail(cpu, PERF_TYPE_HARDWARE, PERF_COUNT_HW_INSTRUCTIONS, -1, 0);
 
 	return fd_instr_count_percpu[cpu];
 }
@@ -2762,6 +2774,175 @@ int get_core_throt_cnt(int cpu, unsigned long long *cnt)
 	return 0;
 }
 
+struct amperf_group_fd {
+	int aperf;		/* Also the group descriptor */
+	int mperf;
+};
+
+static unsigned int read_perf_counter_info(const char *const path, const char *const parse_format)
+{
+	int fdmt;
+	char buf[16];
+	unsigned int v;
+
+	fdmt = open(path, O_RDONLY, 0);
+	if (fdmt == -1)
+		errx(1, "Failed to read perf counter info %s\n", path);
+
+	if (read(fdmt, buf, sizeof(buf)) <= 0)
+		return 0;
+
+	buf[sizeof(buf) - 1] = '\0';
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
+	const char *const path = "/sys/bus/event_source/devices/msr/type";
+	const char *const format = "%u";
+
+	return read_perf_counter_info(path, format);
+}
+
+static unsigned read_aperf_config(void)
+{
+	const char *const path = "/sys/bus/event_source/devices/msr/events/aperf";
+	const char *const format = "event=%x";
+
+	return read_perf_counter_info(path, format);
+}
+
+static unsigned read_mperf_config(void)
+{
+	const char *const path = "/sys/bus/event_source/devices/msr/events/mperf";
+	const char *const format = "event=%x";
+
+	return read_perf_counter_info(path, format);
+}
+
+static struct amperf_group_fd open_amperf_fd(int cpu)
+{
+	const unsigned int msr_type = read_msr_type();
+	const unsigned int aperf_config = read_aperf_config();
+	const unsigned int mperf_config = read_mperf_config();
+	struct amperf_group_fd fds = {.aperf = -1,.mperf = -1 };
+
+	fds.aperf = open_perf_counter_or_fail(cpu, msr_type, aperf_config, -1, PERF_FORMAT_GROUP);
+	fds.mperf = open_perf_counter_or_fail(cpu, msr_type, mperf_config, fds.aperf, PERF_FORMAT_GROUP);
+
+	return fds;
+}
+
+static int get_amperf_fd(int cpu)
+{
+	assert(fd_amperf_percpu);
+
+	if (fd_amperf_percpu[cpu].aperf)
+		return fd_amperf_percpu[cpu].aperf;
+
+	fd_amperf_percpu[cpu] = open_amperf_fd(cpu);
+
+	return fd_amperf_percpu[cpu].aperf;
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
+	const int fd_amperf = get_amperf_fd(cpu);
+
+	/*
+	 * Read the TSC with rdtsc, because we want the absolute value and not
+	 * the offset from the start of the counter.
+	 */
+	t->tsc = rdtsc();
+
+	const int n = read(fd_amperf, &cnt.as_array[0], sizeof(cnt.as_array));
+	if (n != sizeof(cnt.as_array))
+		return -2;
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
@@ -2771,7 +2952,6 @@ int get_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 {
 	int cpu = t->cpu_id;
 	unsigned long long msr;
-	int aperf_mperf_retry_count = 0;
 	struct msr_counter *mp;
 	int i;
 
@@ -2784,63 +2964,26 @@ int get_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 
 	if (first_counter_read)
 		get_apic_id(t);
-retry:
+
 	t->tsc = rdtsc();	/* we are running on local CPU of interest */
 
 	if (DO_BIC(BIC_Avg_MHz) || DO_BIC(BIC_Busy) || DO_BIC(BIC_Bzy_MHz) || DO_BIC(BIC_IPC)
 	    || soft_c1_residency_display(BIC_Avg_MHz)) {
-		unsigned long long tsc_before, tsc_between, tsc_after, aperf_time, mperf_time;
-
-		/*
-		 * The TSC, APERF and MPERF must be read together for
-		 * APERF/MPERF and MPERF/TSC to give accurate results.
-		 *
-		 * Unfortunately, APERF and MPERF are read by
-		 * individual system call, so delays may occur
-		 * between them.  If the time to read them
-		 * varies by a large amount, we re-read them.
-		 */
-
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
+		int status = -1;
 
-		tsc_after = rdtsc();
+		assert(!no_perf || !no_msr);
 
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
+		switch (amperf_source) {
+		case AMPERF_SOURCE_PERF:
+			status = read_aperf_mperf_tsc_perf(t, cpu);
+			break;
+		case AMPERF_SOURCE_MSR:
+			status = read_aperf_mperf_tsc_msr(t, cpu);
+			break;
 		}
-		aperf_mperf_retry_count = 0;
 
-		t->aperf = t->aperf * aperf_mperf_multiplier;
-		t->mperf = t->mperf * aperf_mperf_multiplier;
+		if (status != 0)
+			return status;
 	}
 
 	if (DO_BIC(BIC_IPC))
@@ -3516,6 +3659,21 @@ void free_fd_percpu(void)
 	free(fd_percpu);
 }
 
+void free_fd_amperf_percpu(void)
+{
+	int i;
+
+	for (i = 0; i < topo.max_cpu_num + 1; ++i) {
+		if (fd_amperf_percpu[i].mperf != 0)
+			close(fd_amperf_percpu[i].mperf);
+
+		if (fd_amperf_percpu[i].aperf != 0)
+			close(fd_amperf_percpu[i].aperf);
+	}
+
+	free(fd_amperf_percpu);
+}
+
 void free_all_buffers(void)
 {
 	int i;
@@ -3557,6 +3715,7 @@ void free_all_buffers(void)
 	outp = NULL;
 
 	free_fd_percpu();
+	free_fd_amperf_percpu();
 
 	free(irq_column_2_cpu);
 	free(irqs_per_cpu);
@@ -5647,17 +5806,62 @@ void print_dev_latency(void)
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
+	if (BIC_IS_ENABLED(BIC_IPC) && has_aperf) {
+		fd_instr_count_percpu = calloc(topo.max_cpu_num + 1, sizeof(int));
+		if (fd_instr_count_percpu == NULL)
+			err(-1, "calloc fd_instr_count_percpu");
+	}
 
-	BIC_PRESENT(BIC_IPC);
+	const bool aperf_required = BIC_IS_ENABLED(BIC_Avg_MHz) || BIC_IS_ENABLED(BIC_Busy) ||
+	    BIC_IS_ENABLED(BIC_Bzy_MHz) || BIC_IS_ENABLED(BIC_IPC);
+	if (aperf_required && has_aperf && amperf_source == AMPERF_SOURCE_PERF) {
+		fd_amperf_percpu = calloc(topo.max_cpu_num + 1, sizeof(*fd_amperf_percpu));
+		if (fd_amperf_percpu == NULL)
+			err(-1, "calloc fd_amperf_percpu");
+	}
+}
+
+static int has_amperf_access_via_msr(void)
+{
+	const int cpu = sched_getcpu();
+	unsigned long long dummy;
+
+	if (get_msr(cpu, MSR_IA32_APERF, &dummy))
+		return 0;
+
+	if (get_msr(cpu, MSR_IA32_MPERF, &dummy))
+		return 0;
+
+	return 1;
+}
+
+static int has_amperf_access_via_perf(void)
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
+static int has_amperf_access(void)
+{
+	if (!no_msr && has_amperf_access_via_msr())
+		return 1;
+
+	if (!no_perf && has_amperf_access_via_perf())
+		return 1;
+
+	return 0;
 }
 
 void probe_cstates(void)
@@ -5845,10 +6049,11 @@ void process_cpuid()
 
 	__cpuid(0x6, eax, ebx, ecx, edx);
 	has_aperf = ecx & (1 << 0);
-	if (has_aperf) {
+	if (has_aperf && has_amperf_access()) {
 		BIC_PRESENT(BIC_Avg_MHz);
 		BIC_PRESENT(BIC_Busy);
 		BIC_PRESENT(BIC_Bzy_MHz);
+		BIC_PRESENT(BIC_IPC);
 	}
 	do_dts = eax & (1 << 0);
 	if (do_dts)
@@ -6324,6 +6529,19 @@ void set_base_cpu(void)
 	err(-ENODEV, "No valid cpus found");
 }
 
+static void set_amperf_source(void)
+{
+	amperf_source = AMPERF_SOURCE_PERF;
+
+	if (no_perf || !has_amperf_access_via_perf())
+		amperf_source = AMPERF_SOURCE_MSR;
+
+	if (quiet || !debug)
+		return;
+
+	fprintf(outf, "aperf/mperf source preference: %s\n", amperf_source == AMPERF_SOURCE_MSR ? "msr" : "perf");
+}
+
 void turbostat_init()
 {
 	setup_all_buffers(true);
@@ -6334,6 +6552,7 @@ void turbostat_init()
 	}
 	process_cpuid();
 	probe_pm_features();
+	set_amperf_source();
 	linux_perf_init();
 
 	for_all_cpus(get_cpu_type, ODD_COUNTERS);
@@ -6341,6 +6560,15 @@ void turbostat_init()
 
 	if (DO_BIC(BIC_IPC))
 		(void)get_instr_count_fd(base_cpu);
+
+	/*
+	 * If TSC tweak is needed, but couldn't get it,
+	 * disable more BICs, since it can't be reported accurately.
+	 */
+	if (platform->enable_tsc_tweak && !has_base_hz) {
+		bic_enabled &= ~BIC_Busy;
+		bic_enabled &= ~BIC_Bzy_MHz;
+	}
 }
 
 int fork_it(char **argv)
-- 
2.40.1


