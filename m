Return-Path: <linux-pm+bounces-6085-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E771D89CF67
	for <lists+linux-pm@lfdr.de>; Tue,  9 Apr 2024 02:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FFAE284B6F
	for <lists+linux-pm@lfdr.de>; Tue,  9 Apr 2024 00:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A353236;
	Tue,  9 Apr 2024 00:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LkguIzDU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D481C0DE3
	for <linux-pm@vger.kernel.org>; Tue,  9 Apr 2024 00:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712622718; cv=none; b=J3yveFlpvB7j/lV0Cq6y8t2juWcr4ZGOka+I5sPA+O8/nu7jcCgNZvO7gkrXzTzKsSxw+wf1JDgKtNlRFM1MUAPgictZoUTn7Ui0kgUDhdCAazuzl5fhoOOCCjU8fVixltvfPvX6H9B+m6IWovgsWmTeNqovfLhJs4u9Zpwqrb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712622718; c=relaxed/simple;
	bh=O3WBjxzijtOOljjxqiKDXIEExZKGASh26HNwEDt5ij8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VpXyYH4tfY2pTrYIF293v3KIEx9r4t6T2RzzwRviBVHsetHSLj4rGrxeAFFoNqUVwlLKdpPQ1w8Zmq1Hgurl0Fso4OmnOGMvy/L8ybVKCuQJ5+cfxKV+cHj3h9TalNcYfBpbQIqj8WRC5/TQ3f+QJ8ys+8CFwXgmS2dVTyhuUa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LkguIzDU; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dcd7c526cc0so4975609276.1
        for <linux-pm@vger.kernel.org>; Mon, 08 Apr 2024 17:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712622715; x=1713227515; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vVmERnvsolsD5JaqNgfzO+yzuTJ3ZM8oOWu4Tr3CsD0=;
        b=LkguIzDU29CREEbFANTiFlgGdtperG6M7HUJ+GR80zQ3vRE4kI1R+95iM8z3W4X3z3
         0HjhFf+jKoMUQfrewncJRgM/Q9MffJdpH66OSVoChAneI3QmuKpGwcfWDHuG7CzCBYJz
         JnGTN67me1H/Wow2qU+hty4Lzhgag9hTufbyJ7Vnmnwu6g08FAwp554rkVtpfzzubr0a
         VGxD3q+fO5W55pL6wJ94H9H4Z3K05u0SJ8YzuEVjGwgd/rPRuVuMkYQutvIdgz5oEhBA
         +fPUTRKRPf/AwgMTszNJrCN1w1frPuU/fDeciy4uM+zGMcwpfW0CApBeJOwAgIqIRM83
         CDxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712622715; x=1713227515;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vVmERnvsolsD5JaqNgfzO+yzuTJ3ZM8oOWu4Tr3CsD0=;
        b=eujCprEsOHmlp2oztRn38neBJiZCO1d4MrsyVmd2GG3ZUDzifGGvaBXJHI1fZ1Mqou
         sunB4F0afG4mRZ5RytfV0GFcJGyhj4liOEPiLre4Nw8e6ud/dMy0TzrGHRdJHWEf3BQE
         bYEWpdBp4FQzDro01g+S9NNQejE2nMABjODawLCK+H4lIRUoLxp1PTons869T3a8VcvA
         d0iHBX0rogPzZrEdnTJmoet4w4SQfuqHOtudslpGLSnAOMDa1umjfUpHNwqmTzyxVtsX
         No4fQgJwHkuKCgNCNfEVNbUnBvgag6fXcE2k4MkUBejMCnMungKfxoOtqWRzGwmWiPwH
         RDhw==
X-Gm-Message-State: AOJu0Yy0daa5EFd345sxOQTbOYt2XUCx7afzHlqpeev3xlU/nuBaSqAA
	5EkLywrKjVA1vtO5DEiyQVi8UKEoVPSZoBC+ySq/+msEFkA/nb0U5vGxh/iL
X-Google-Smtp-Source: AGHT+IF7Tiu6FCIM1PbGdc8RCUelcLA/I8t9W7bosIm+XZ1DYaIzfzPc2jH1ahoyY04XwTUY2RZeiQ==
X-Received: by 2002:a25:bcc7:0:b0:dc6:c617:7ca with SMTP id l7-20020a25bcc7000000b00dc6c61707camr8553204ybm.29.1712622714748;
        Mon, 08 Apr 2024 17:31:54 -0700 (PDT)
Received: from lenb-Intel-NUC8i7HVKVA.search.charter.net (2603-9000-9f01-67cf-100c-5508-c194-b194.inf6.spectrum.com. [2603:9000:9f01:67cf:100c:5508:c194:b194])
        by smtp.gmail.com with ESMTPSA id h6-20020a25e206000000b00dc74ac54f5fsm1531949ybe.63.2024.04.08.17.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 17:31:53 -0700 (PDT)
Sender: Len Brown <lenb417@gmail.com>
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 13/26] tools/power turbostat: detect and disable unavailable BICs at runtime
Date: Mon,  8 Apr 2024 20:31:07 -0400
Message-Id: <5088741ec805cd249e27c7176ed09bdab164960e.1712621427.git.len.brown@intel.com>
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

To allow unprivileged user to run turbostat seamlessly.

Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 188 +++++++++++++++++---------
 1 file changed, 125 insertions(+), 63 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 1294c46c2170..30db6e92193a 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1317,13 +1317,6 @@ static void bic_disable_msr_access(void)
 	bic_enabled &= ~bic_msrs;
 }
 
-static void bic_disable_perf_access(void)
-{
-	const unsigned long bic_perf = BIC_IPC;
-
-	bic_enabled &= ~bic_perf;
-}
-
 static long perf_event_open(struct perf_event_attr *hw_event, pid_t pid, int cpu, int group_fd, unsigned long flags)
 {
 	assert(!no_perf);
@@ -1331,12 +1324,14 @@ static long perf_event_open(struct perf_event_attr *hw_event, pid_t pid, int cpu
 	return syscall(__NR_perf_event_open, hw_event, pid, cpu, group_fd, flags);
 }
 
-static long open_perf_counter_or_fail(int cpu, unsigned int type, unsigned int config, int group_fd, __u64 read_format)
+static long open_perf_counter(int cpu, unsigned int type, unsigned int config, int group_fd, __u64 read_format)
 {
 	struct perf_event_attr attr;
 	const pid_t pid = -1;
 	const unsigned long flags = 0;
 
+	assert(!no_perf);
+
 	memset(&attr, 0, sizeof(struct perf_event_attr));
 
 	attr.type = type;
@@ -1347,15 +1342,6 @@ static long open_perf_counter_or_fail(int cpu, unsigned int type, unsigned int c
 	attr.read_format = read_format;
 
 	const int fd = perf_event_open(&attr, pid, cpu, group_fd, flags);
-	if (fd == -1) {
-		if (errno == EACCES) {
-			errx(1, "capget(CAP_PERFMON) failed, try \"# setcap cap_sys_admin=ep %s\""
-			     " or use --no-perf or run as root", progname);
-		} else {
-			perror("perf_event_open");
-			errx(1, "use --no-perf or run as root");
-		}
-	}
 
 	return fd;
 }
@@ -1365,8 +1351,7 @@ int get_instr_count_fd(int cpu)
 	if (fd_instr_count_percpu[cpu])
 		return fd_instr_count_percpu[cpu];
 
-	fd_instr_count_percpu[cpu] =
-	    open_perf_counter_or_fail(cpu, PERF_TYPE_HARDWARE, PERF_COUNT_HW_INSTRUCTIONS, -1, 0);
+	fd_instr_count_percpu[cpu] = open_perf_counter(cpu, PERF_TYPE_HARDWARE, PERF_COUNT_HW_INSTRUCTIONS, -1, 0);
 
 	return fd_instr_count_percpu[cpu];
 }
@@ -2833,8 +2818,8 @@ static struct amperf_group_fd open_amperf_fd(int cpu)
 	const unsigned int mperf_config = read_mperf_config();
 	struct amperf_group_fd fds = {.aperf = -1,.mperf = -1 };
 
-	fds.aperf = open_perf_counter_or_fail(cpu, msr_type, aperf_config, -1, PERF_FORMAT_GROUP);
-	fds.mperf = open_perf_counter_or_fail(cpu, msr_type, mperf_config, fds.aperf, PERF_FORMAT_GROUP);
+	fds.aperf = open_perf_counter(cpu, msr_type, aperf_config, -1, PERF_FORMAT_GROUP);
+	fds.mperf = open_perf_counter(cpu, msr_type, mperf_config, fds.aperf, PERF_FORMAT_GROUP);
 
 	return fds;
 }
@@ -4509,7 +4494,8 @@ void msr_sum_record(void)
 
 /*
  * set_my_sched_priority(pri)
- * return previous
+ * return previous priority on success
+ * return value < -20 on failure
  */
 int set_my_sched_priority(int priority)
 {
@@ -4519,16 +4505,16 @@ int set_my_sched_priority(int priority)
 	errno = 0;
 	original_priority = getpriority(PRIO_PROCESS, 0);
 	if (errno && (original_priority == -1))
-		err(errno, "getpriority");
+		return -21;
 
 	retval = setpriority(PRIO_PROCESS, 0, priority);
 	if (retval)
-		errx(retval, "capget(CAP_SYS_NICE) failed,try \"# setcap cap_sys_nice=ep %s\"", progname);
+		return -21;
 
 	errno = 0;
 	retval = getpriority(PRIO_PROCESS, 0);
 	if (retval != priority)
-		err(retval, "getpriority(%d) != setpriority(%d)", retval, priority);
+		return -21;
 
 	return original_priority;
 }
@@ -4543,6 +4529,9 @@ void turbostat_loop()
 
 	/*
 	 * elevate own priority for interval mode
+	 *
+	 * ignore on error - we probably don't have permission to set it, but
+	 * it's not a big deal
 	 */
 	set_my_sched_priority(-20);
 
@@ -4628,10 +4617,13 @@ void check_dev_msr()
 	struct stat sb;
 	char pathname[32];
 
+	if (no_msr)
+		return;
+
 	sprintf(pathname, "/dev/cpu/%d/msr", base_cpu);
 	if (stat(pathname, &sb))
 		if (system("/sbin/modprobe msr > /dev/null 2>&1"))
-			err(-5, "no /dev/cpu/0/msr, Try \"# modprobe msr\" ");
+			no_msr = 1;
 }
 
 /*
@@ -4643,47 +4635,51 @@ int check_for_cap_sys_rawio(void)
 {
 	cap_t caps;
 	cap_flag_value_t cap_flag_value;
+	int ret = 0;
 
 	caps = cap_get_proc();
 	if (caps == NULL)
-		err(-6, "cap_get_proc\n");
+		return 1;
 
-	if (cap_get_flag(caps, CAP_SYS_RAWIO, CAP_EFFECTIVE, &cap_flag_value))
-		err(-6, "cap_get\n");
+	if (cap_get_flag(caps, CAP_SYS_RAWIO, CAP_EFFECTIVE, &cap_flag_value)) {
+		ret = 1;
+		goto free_and_exit;
+	}
 
 	if (cap_flag_value != CAP_SET) {
-		warnx("capget(CAP_SYS_RAWIO) failed," " try \"# setcap cap_sys_rawio=ep %s\"", progname);
-		return 1;
+		ret = 1;
+		goto free_and_exit;
 	}
 
+free_and_exit:
 	if (cap_free(caps) == -1)
 		err(-6, "cap_free\n");
 
-	return 0;
+	return ret;
 }
 
-void check_permissions(void)
+void check_msr_permission(void)
 {
-	int do_exit = 0;
+	int failed = 0;
 	char pathname[32];
 
+	if (no_msr)
+		return;
+
 	/* check for CAP_SYS_RAWIO */
-	do_exit += check_for_cap_sys_rawio();
+	failed += check_for_cap_sys_rawio();
 
 	/* test file permissions */
 	sprintf(pathname, "/dev/cpu/%d/msr", base_cpu);
 	if (euidaccess(pathname, R_OK)) {
-		do_exit++;
-		warn("/dev/cpu/0/msr open failed, try chown or chmod +r /dev/cpu/*/msr, or run with --no-msr");
+		failed++;
 	}
 
-	/* if all else fails, thell them to be root */
-	if (do_exit)
-		if (getuid() != 0)
-			warnx("... or simply run as root");
-
-	if (do_exit)
-		exit(-6);
+	if (failed) {
+		warnx("Failed to access %s. Some of the counters may not be available\n"
+		      "\tRun as root to enable them or use %s to disable the access explicitly", pathname, "--no-msr");
+		no_msr = 1;
+	}
 }
 
 void probe_bclk(void)
@@ -5800,6 +5796,28 @@ void print_dev_latency(void)
 	close(fd);
 }
 
+static int has_instr_count_access(void)
+{
+	int fd;
+	int has_access;
+
+	if (no_perf)
+		return 0;
+
+	fd = open_perf_counter(base_cpu, PERF_TYPE_HARDWARE, PERF_COUNT_HW_INSTRUCTIONS, -1, 0);
+	has_access = fd != -1;
+
+	if (fd != -1)
+		close(fd);
+
+	if (!has_access)
+		warnx("Failed to access %s. Some of the counters may not be available\n"
+		      "\tRun as root to enable them or use %s to disable the access explicitly",
+		      "instructions retired perf counter", "--no-perf");
+
+	return has_access;
+}
+
 /*
  * Linux-perf manages the HW instructions-retired counter
  * by enabling when requested, and hiding rollover
@@ -5826,13 +5844,15 @@ void linux_perf_init(void)
 
 static int has_amperf_access_via_msr(void)
 {
-	const int cpu = sched_getcpu();
 	unsigned long long dummy;
 
-	if (get_msr(cpu, MSR_IA32_APERF, &dummy))
+	if (no_msr)
+		return 0;
+
+	if (get_msr(base_cpu, MSR_IA32_APERF, &dummy))
 		return 0;
 
-	if (get_msr(cpu, MSR_IA32_MPERF, &dummy))
+	if (get_msr(base_cpu, MSR_IA32_MPERF, &dummy))
 		return 0;
 
 	return 1;
@@ -5840,16 +5860,44 @@ static int has_amperf_access_via_msr(void)
 
 static int has_amperf_access_via_perf(void)
 {
-	if (access("/sys/bus/event_source/devices/msr/type", F_OK))
-		return 0;
+	struct amperf_group_fd fds;
 
-	if (access("/sys/bus/event_source/devices/msr/events/aperf", F_OK))
-		return 0;
+	/*
+	 * Cache the last result, so we don't warn the user multiple times
+	 *
+	 * Negative means cached, no access
+	 * Zero means not cached
+	 * Positive means cached, has access
+	 */
+	static int has_access_cached;
 
-	if (access("/sys/bus/event_source/devices/msr/events/mperf", F_OK))
+	if (no_perf)
 		return 0;
 
-	return 1;
+	if (has_access_cached != 0)
+		return has_access_cached > 0;
+
+	fds = open_amperf_fd(base_cpu);
+	has_access_cached = (fds.aperf != -1) && (fds.mperf != -1);
+
+	if (fds.aperf == -1)
+		warnx("Failed to access %s. Some of the counters may not be available\n"
+		      "\tRun as root to enable them or use %s to disable the access explicitly",
+		      "APERF perf counter", "--no-perf");
+	else
+		close(fds.aperf);
+
+	if (fds.mperf == -1)
+		warnx("Failed to access %s. Some of the counters may not be available\n"
+		      "\tRun as root to enable them or use %s to disable the access explicitly",
+		      "MPERF perf counter", "--no-perf");
+	else
+		close(fds.mperf);
+
+	if (has_access_cached == 0)
+		has_access_cached = -1;
+
+	return has_access_cached > 0;
 }
 
 /* Check if we can access APERF and MPERF */
@@ -6542,14 +6590,34 @@ static void set_amperf_source(void)
 	fprintf(outf, "aperf/mperf source preference: %s\n", amperf_source == AMPERF_SOURCE_MSR ? "msr" : "perf");
 }
 
+void check_msr_access(void)
+{
+	check_dev_msr();
+	check_msr_permission();
+
+	if (no_msr)
+		bic_disable_msr_access();
+}
+
+void check_perf_access(void)
+{
+	if (no_perf || !has_instr_count_access())
+		bic_enabled &= ~BIC_IPC;
+
+	if (!has_amperf_access()) {
+		bic_enabled &= ~BIC_Avg_MHz;
+		bic_enabled &= ~BIC_Busy;
+		bic_enabled &= ~BIC_Bzy_MHz;
+		bic_enabled &= ~BIC_IPC;
+	}
+}
+
 void turbostat_init()
 {
 	setup_all_buffers(true);
 	set_base_cpu();
-	if (!no_msr) {
-		check_dev_msr();
-		check_permissions();
-	}
+	check_msr_access();
+	check_perf_access();
 	process_cpuid();
 	probe_pm_features();
 	set_amperf_source();
@@ -7150,12 +7218,6 @@ int main(int argc, char **argv)
 	outf = stderr;
 	cmdline(argc, argv);
 
-	if (no_msr)
-		bic_disable_msr_access();
-
-	if (no_perf)
-		bic_disable_perf_access();
-
 	if (!quiet) {
 		print_version();
 		print_bootcmd();
-- 
2.40.1


