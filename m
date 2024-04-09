Return-Path: <linux-pm+bounces-6082-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D6089CF65
	for <lists+linux-pm@lfdr.de>; Tue,  9 Apr 2024 02:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BF5A284B58
	for <lists+linux-pm@lfdr.de>; Tue,  9 Apr 2024 00:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D09B15C3;
	Tue,  9 Apr 2024 00:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fH7ORZNt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7515D567D
	for <linux-pm@vger.kernel.org>; Tue,  9 Apr 2024 00:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712622714; cv=none; b=YHbjQag7+ohzp3vef0+xlZKpi0JAfR87AP5MjwdaaV8Xq3vfqy8Kok/ha+Ay6dFappU4F+p9ndnT4EBasRm3JPWrDNHxitGt8gfFLhIp9+1GOqjK2d4S8ErY17enMPh6l8iOYs/3JXZx6cyZ0m24Efw/ysMq/eItordsai/w2x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712622714; c=relaxed/simple;
	bh=cKZminsXRmAkba+ipaBL3A0CRTeWzvkBrhjR5QSzEFg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P0FFCEEIETnnj+0r39J/S59bH93lx76175RAopejfQs9zm24Z/yPO0D7yndD7pQefW4n76aWBXd7DV4wYdjLTUClZ6J6C+fzi5r5h91qtDEFNCDKEYBVoctg7QNjv3g7/hItTrGAgGhjfpYPZp4UjdNLqx+nTVhiED6aHr24j68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fH7ORZNt; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dde0b30ebe2so4324286276.0
        for <linux-pm@vger.kernel.org>; Mon, 08 Apr 2024 17:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712622711; x=1713227511; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KqBOWZZFWs8yV8TPmwsYgqXb9FgrMgTGWqTWOgUhDMc=;
        b=fH7ORZNtpIXFVf4O5npnpHsSg2HLKAH8lAwL2pG+g0g7oEoPXKRY7UmY0aF6AoHESa
         2cwV8Uw5SyyhFwMTNBNmmRsnnnbC1pOHV5DTEwBqRAIsw+QTYLgeD7pwG6ts7YhHltvx
         KmFo5GMVvIPGeXfPm0z7NnPIDsi0tjZOMvhL5EWou2d2rAPilj+HHmGsfah27NMivBya
         HSD8O2lAGfJ8D1JDUu1SwcUHOFAGgxOOycXYv28UCPpan5PLG/n2bCo/D4k6YVjLIvp0
         bey80vLmYwQRojbd8T62/auMLS92x8kdqPzG8pCL9TF56k/g7BBt0j4u/Z3RU0H/Xfci
         Crrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712622711; x=1713227511;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KqBOWZZFWs8yV8TPmwsYgqXb9FgrMgTGWqTWOgUhDMc=;
        b=urDyL5jq6V8uT8KvQmN6y3RUbZrL9QXZ4mC26f26wWbUwTomSlE8fGt0q4aY4e8UEa
         RL7JRejkAoUTBFr22+5VRtju3Rur5qsEWF3MiSWrgNpnx8nwBeBfoM1jELQyjFaXoHj6
         Z/tHq5p4bwt5Kl6gnXc6hHXrtzEs8TsyI+Y5yNGKnAtwuiqospu/MVa9bpxICJsaT2tE
         Pu58sJHJXsCjd0BZGGedTM9fwEZEETFsFbHq8FpF3CMACw5Y1n+j2awuRI5JeU3crdyJ
         O4Vv/gSnMHMQVCFQ4/Q15HSyhewgrr0q1VTASko9WbXFuygeTdKHUyJRuhC3g+tdHd8J
         +aBQ==
X-Gm-Message-State: AOJu0YzAUCk0YHaBlH/l0LNGvgtPa7wNtB1ghHLJNJVJGsCJ9P5InjgQ
	UUx2f36PnYYZNPzVs1+WxbAh+2/+oiocyg/ZEzmo7hIVZnzamti0dbK0bVlx
X-Google-Smtp-Source: AGHT+IHSmiE5xSk5pNXvPwVHZ2iabS+o5i2YOEuSglTt0AXIp/s/DDfxVBsKz64+lzqX906LRfuPKA==
X-Received: by 2002:a25:bece:0:b0:dcb:d8d1:2d59 with SMTP id k14-20020a25bece000000b00dcbd8d12d59mr8049939ybm.38.1712622711185;
        Mon, 08 Apr 2024 17:31:51 -0700 (PDT)
Received: from lenb-Intel-NUC8i7HVKVA.search.charter.net (2603-9000-9f01-67cf-100c-5508-c194-b194.inf6.spectrum.com. [2603:9000:9f01:67cf:100c:5508:c194:b194])
        by smtp.gmail.com with ESMTPSA id h6-20020a25e206000000b00dc74ac54f5fsm1531949ybe.63.2024.04.08.17.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 17:31:50 -0700 (PDT)
Sender: Len Brown <lenb417@gmail.com>
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 10/26] tools/power turbostat: Add --no-msr option
Date: Mon,  8 Apr 2024 20:31:04 -0400
Message-Id: <3e4048466c396cff52c6d435156dbcd0571e4381.1712621427.git.len.brown@intel.com>
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

Add --no-msr option to allow users to run turbostat without
accessing MSRs via the MSR driver.

Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.8 |   2 +
 tools/power/x86/turbostat/turbostat.c | 205 +++++++++++++++++++-------
 2 files changed, 151 insertions(+), 56 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.8 b/tools/power/x86/turbostat/turbostat.8
index 1ba6340d3b3d..28be452fbfe2 100644
--- a/tools/power/x86/turbostat/turbostat.8
+++ b/tools/power/x86/turbostat/turbostat.8
@@ -67,6 +67,8 @@ The column name "all" can be used to enable all disabled-by-default built-in cou
 .PP
 \fB--quiet\fP Do not decode and print the system configuration header information.
 .PP
++\fB--no-msr\fP Disable all the uses of the MSR driver.
++.PP
 \fB--interval seconds\fP overrides the default 5.0 second measurement interval.
 .PP
 \fB--num_iterations num\fP number of the measurement iterations.
diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 60432753fe6a..4d5437a9725b 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -36,6 +36,7 @@
 #include <linux/perf_event.h>
 #include <asm/unistd.h>
 #include <stdbool.h>
+#include <assert.h>
 
 #define UNUSED(x) (void)(x)
 
@@ -265,6 +266,7 @@ unsigned int has_hwp_epp;	/* IA32_HWP_REQUEST[bits 31:24] */
 unsigned int has_hwp_pkg;	/* IA32_HWP_REQUEST_PKG */
 unsigned int first_counter_read = 1;
 int ignore_stdin;
+bool no_msr;
 
 int get_msr(int cpu, off_t offset, unsigned long long *msr);
 
@@ -1282,13 +1284,36 @@ int get_msr_fd(int cpu)
 	sprintf(pathname, "/dev/cpu/%d/msr", cpu);
 	fd = open(pathname, O_RDONLY);
 	if (fd < 0)
-		err(-1, "%s open failed, try chown or chmod +r /dev/cpu/*/msr, or run as root", pathname);
+		err(-1, "%s open failed, try chown or chmod +r /dev/cpu/*/msr, "
+		    "or run with --no-msr, or run as root", pathname);
 
 	fd_percpu[cpu] = fd;
 
 	return fd;
 }
 
+static void bic_disable_msr_access(void)
+{
+	const unsigned long bic_msrs =
+	    BIC_Avg_MHz |
+	    BIC_Busy |
+	    BIC_Bzy_MHz |
+	    BIC_SMI |
+	    BIC_CPU_c1 |
+	    BIC_CPU_c3 |
+	    BIC_CPU_c6 |
+	    BIC_CPU_c7 |
+	    BIC_Mod_c6 |
+	    BIC_CoreTmp |
+	    BIC_Totl_c0 |
+	    BIC_Any_c0 |
+	    BIC_GFX_c0 |
+	    BIC_CPUGFX |
+	    BIC_Pkgpc2 | BIC_Pkgpc3 | BIC_Pkgpc6 | BIC_Pkgpc7 | BIC_Pkgpc8 | BIC_Pkgpc9 | BIC_Pkgpc10 | BIC_PkgTmp;
+
+	bic_enabled &= ~bic_msrs;
+}
+
 static long perf_event_open(struct perf_event_attr *hw_event, pid_t pid, int cpu, int group_fd, unsigned long flags)
 {
 	return syscall(__NR_perf_event_open, hw_event, pid, cpu, group_fd, flags);
@@ -1328,6 +1353,8 @@ int get_msr(int cpu, off_t offset, unsigned long long *msr)
 {
 	ssize_t retval;
 
+	assert(!no_msr);
+
 	retval = pread(get_msr_fd(cpu), msr, sizeof(*msr), offset);
 
 	if (retval != sizeof *msr)
@@ -1371,6 +1398,7 @@ void help(void)
 		"		Override default 5-second measurement interval\n"
 		"  -J, --Joules	displays energy in Joules instead of Watts\n"
 		"  -l, --list	list column headers only\n"
+		"  -M, --no-msr Disable all uses of the MSR driver\n"
 		"  -n, --num_iterations num\n"
 		"		number of the measurement iterations\n"
 		"  -N, --header_iterations num\n"
@@ -2597,6 +2625,7 @@ unsigned long long snapshot_sysfs_counter(char *path)
 int get_mp(int cpu, struct msr_counter *mp, unsigned long long *counterp)
 {
 	if (mp->msr_num != 0) {
+		assert(!no_msr);
 		if (get_msr(cpu, mp->msr_num, counterp))
 			return -1;
 	} else {
@@ -2646,6 +2675,9 @@ int get_epb(int cpu)
 	return epb;
 
 msr_fallback:
+	if (no_msr)
+		return -1;
+
 	get_msr(cpu, MSR_IA32_ENERGY_PERF_BIAS, &msr);
 
 	return msr & 0xf;
@@ -2865,7 +2897,7 @@ int get_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 	if (DO_BIC(BIC_CORE_THROT_CNT))
 		get_core_throt_cnt(cpu, &c->core_throt_cnt);
 
-	if (platform->rapl_msrs & RAPL_AMD_F17H) {
+	if ((platform->rapl_msrs & RAPL_AMD_F17H) && !no_msr) {
 		if (get_msr(cpu, MSR_CORE_ENERGY_STAT, &msr))
 			return -14;
 		c->core_energy = msr & 0xFFFFFFFF;
@@ -2930,41 +2962,44 @@ int get_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 	if (DO_BIC(BIC_SYS_LPI))
 		p->sys_lpi = cpuidle_cur_sys_lpi_us;
 
-	if (platform->rapl_msrs & RAPL_PKG) {
-		if (get_msr_sum(cpu, MSR_PKG_ENERGY_STATUS, &msr))
-			return -13;
-		p->energy_pkg = msr;
-	}
-	if (platform->rapl_msrs & RAPL_CORE_ENERGY_STATUS) {
-		if (get_msr_sum(cpu, MSR_PP0_ENERGY_STATUS, &msr))
-			return -14;
-		p->energy_cores = msr;
-	}
-	if (platform->rapl_msrs & RAPL_DRAM) {
-		if (get_msr_sum(cpu, MSR_DRAM_ENERGY_STATUS, &msr))
-			return -15;
-		p->energy_dram = msr;
-	}
-	if (platform->rapl_msrs & RAPL_GFX) {
-		if (get_msr_sum(cpu, MSR_PP1_ENERGY_STATUS, &msr))
-			return -16;
-		p->energy_gfx = msr;
-	}
-	if (platform->rapl_msrs & RAPL_PKG_PERF_STATUS) {
-		if (get_msr_sum(cpu, MSR_PKG_PERF_STATUS, &msr))
-			return -16;
-		p->rapl_pkg_perf_status = msr;
-	}
-	if (platform->rapl_msrs & RAPL_DRAM_PERF_STATUS) {
-		if (get_msr_sum(cpu, MSR_DRAM_PERF_STATUS, &msr))
-			return -16;
-		p->rapl_dram_perf_status = msr;
-	}
-	if (platform->rapl_msrs & RAPL_AMD_F17H) {
-		if (get_msr_sum(cpu, MSR_PKG_ENERGY_STAT, &msr))
-			return -13;
-		p->energy_pkg = msr;
+	if (!no_msr) {
+		if (platform->rapl_msrs & RAPL_PKG) {
+			if (get_msr_sum(cpu, MSR_PKG_ENERGY_STATUS, &msr))
+				return -13;
+			p->energy_pkg = msr;
+		}
+		if (platform->rapl_msrs & RAPL_CORE_ENERGY_STATUS) {
+			if (get_msr_sum(cpu, MSR_PP0_ENERGY_STATUS, &msr))
+				return -14;
+			p->energy_cores = msr;
+		}
+		if (platform->rapl_msrs & RAPL_DRAM) {
+			if (get_msr_sum(cpu, MSR_DRAM_ENERGY_STATUS, &msr))
+				return -15;
+			p->energy_dram = msr;
+		}
+		if (platform->rapl_msrs & RAPL_GFX) {
+			if (get_msr_sum(cpu, MSR_PP1_ENERGY_STATUS, &msr))
+				return -16;
+			p->energy_gfx = msr;
+		}
+		if (platform->rapl_msrs & RAPL_PKG_PERF_STATUS) {
+			if (get_msr_sum(cpu, MSR_PKG_PERF_STATUS, &msr))
+				return -16;
+			p->rapl_pkg_perf_status = msr;
+		}
+		if (platform->rapl_msrs & RAPL_DRAM_PERF_STATUS) {
+			if (get_msr_sum(cpu, MSR_DRAM_PERF_STATUS, &msr))
+				return -16;
+			p->rapl_dram_perf_status = msr;
+		}
+		if (platform->rapl_msrs & RAPL_AMD_F17H) {
+			if (get_msr_sum(cpu, MSR_PKG_ENERGY_STAT, &msr))
+				return -13;
+			p->energy_pkg = msr;
+		}
 	}
+
 	if (DO_BIC(BIC_PkgTmp)) {
 		if (get_msr(cpu, MSR_IA32_PACKAGE_THERM_STATUS, &msr))
 			return -17;
@@ -3072,7 +3107,7 @@ void probe_cst_limit(void)
 	unsigned long long msr;
 	int *pkg_cstate_limits;
 
-	if (!platform->has_nhm_msrs)
+	if (!platform->has_nhm_msrs || no_msr)
 		return;
 
 	switch (platform->cst_limit) {
@@ -3116,7 +3151,7 @@ static void dump_platform_info(void)
 	unsigned long long msr;
 	unsigned int ratio;
 
-	if (!platform->has_nhm_msrs)
+	if (!platform->has_nhm_msrs || no_msr)
 		return;
 
 	get_msr(base_cpu, MSR_PLATFORM_INFO, &msr);
@@ -3134,7 +3169,7 @@ static void dump_power_ctl(void)
 {
 	unsigned long long msr;
 
-	if (!platform->has_nhm_msrs)
+	if (!platform->has_nhm_msrs || no_msr)
 		return;
 
 	get_msr(base_cpu, MSR_IA32_POWER_CTL, &msr);
@@ -3340,7 +3375,7 @@ static void dump_cst_cfg(void)
 {
 	unsigned long long msr;
 
-	if (!platform->has_nhm_msrs)
+	if (!platform->has_nhm_msrs || no_msr)
 		return;
 
 	get_msr(base_cpu, MSR_PKG_CST_CONFIG_CONTROL, &msr);
@@ -3412,7 +3447,7 @@ void print_irtl(void)
 {
 	unsigned long long msr;
 
-	if (!platform->has_irtl_msrs)
+	if (!platform->has_irtl_msrs || no_msr)
 		return;
 
 	if (platform->supported_cstates & PC3) {
@@ -4193,6 +4228,8 @@ int get_msr_sum(int cpu, off_t offset, unsigned long long *msr)
 	int ret, idx;
 	unsigned long long msr_cur, msr_last;
 
+	assert(!no_msr);
+
 	if (!per_cpu_msr_sum)
 		return 1;
 
@@ -4221,6 +4258,8 @@ static int update_msr_sum(struct thread_data *t, struct core_data *c, struct pkg
 	UNUSED(c);
 	UNUSED(p);
 
+	assert(!no_msr);
+
 	for (i = IDX_PKG_ENERGY; i < IDX_COUNT; i++) {
 		unsigned long long msr_cur, msr_last;
 		off_t offset;
@@ -4465,7 +4504,7 @@ void check_permissions(void)
 	sprintf(pathname, "/dev/cpu/%d/msr", base_cpu);
 	if (euidaccess(pathname, R_OK)) {
 		do_exit++;
-		warn("/dev/cpu/0/msr open failed, try chown or chmod +r /dev/cpu/*/msr");
+		warn("/dev/cpu/0/msr open failed, try chown or chmod +r /dev/cpu/*/msr, or run with --no-msr");
 	}
 
 	/* if all else fails, thell them to be root */
@@ -4482,7 +4521,7 @@ void probe_bclk(void)
 	unsigned long long msr;
 	unsigned int base_ratio;
 
-	if (!platform->has_nhm_msrs)
+	if (!platform->has_nhm_msrs || no_msr)
 		return;
 
 	if (platform->bclk_freq == BCLK_100MHZ)
@@ -4522,7 +4561,7 @@ static void dump_turbo_ratio_info(void)
 	if (!has_turbo)
 		return;
 
-	if (!platform->has_nhm_msrs)
+	if (!platform->has_nhm_msrs || no_msr)
 		return;
 
 	if (platform->trl_msrs & TRL_LIMIT2)
@@ -4845,6 +4884,9 @@ int print_hwp(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 	UNUSED(c);
 	UNUSED(p);
 
+	if (no_msr)
+		return 0;
+
 	if (!has_hwp)
 		return 0;
 
@@ -4931,6 +4973,9 @@ int print_perf_limit(struct thread_data *t, struct core_data *c, struct pkg_data
 	UNUSED(c);
 	UNUSED(p);
 
+	if (no_msr)
+		return 0;
+
 	cpu = t->cpu_id;
 
 	/* per-package */
@@ -5264,7 +5309,7 @@ int print_rapl(struct thread_data *t, struct core_data *c, struct pkg_data *p)
  */
 void probe_rapl(void)
 {
-	if (!platform->rapl_msrs)
+	if (!platform->rapl_msrs || no_msr)
 		return;
 
 	if (genuine_intel)
@@ -5320,7 +5365,7 @@ int set_temperature_target(struct thread_data *t, struct core_data *c, struct pk
 	}
 
 	/* Temperature Target MSR is Nehalem and newer only */
-	if (!platform->has_nhm_msrs)
+	if (!platform->has_nhm_msrs || no_msr)
 		goto guess;
 
 	if (get_msr(base_cpu, MSR_IA32_TEMPERATURE_TARGET, &msr))
@@ -5367,6 +5412,9 @@ int print_thermal(struct thread_data *t, struct core_data *c, struct pkg_data *p
 	UNUSED(c);
 	UNUSED(p);
 
+	if (no_msr)
+		return 0;
+
 	if (!(do_dts || do_ptm))
 		return 0;
 
@@ -5464,6 +5512,9 @@ void decode_feature_control_msr(void)
 {
 	unsigned long long msr;
 
+	if (no_msr)
+		return;
+
 	if (!get_msr(base_cpu, MSR_IA32_FEAT_CTL, &msr))
 		fprintf(outf, "cpu%d: MSR_IA32_FEATURE_CONTROL: 0x%08llx (%sLocked %s)\n",
 			base_cpu, msr, msr & FEAT_CTL_LOCKED ? "" : "UN-", msr & (1 << 18) ? "SGX" : "");
@@ -5473,6 +5524,9 @@ void decode_misc_enable_msr(void)
 {
 	unsigned long long msr;
 
+	if (no_msr)
+		return;
+
 	if (!genuine_intel)
 		return;
 
@@ -5490,6 +5544,9 @@ void decode_misc_feature_control(void)
 {
 	unsigned long long msr;
 
+	if (no_msr)
+		return;
+
 	if (!platform->has_msr_misc_feature_control)
 		return;
 
@@ -5511,6 +5568,9 @@ void decode_misc_pwr_mgmt_msr(void)
 {
 	unsigned long long msr;
 
+	if (no_msr)
+		return;
+
 	if (!platform->has_msr_misc_pwr_mgmt)
 		return;
 
@@ -5530,6 +5590,9 @@ void decode_c6_demotion_policy_msr(void)
 {
 	unsigned long long msr;
 
+	if (no_msr)
+		return;
+
 	if (!platform->has_msr_c6_demotion_policy_config)
 		return;
 
@@ -5626,7 +5689,7 @@ void probe_cstates(void)
 	if (platform->has_msr_module_c6_res_ms)
 		BIC_PRESENT(BIC_Mod_c6);
 
-	if (platform->has_ext_cst_msrs) {
+	if (platform->has_ext_cst_msrs && !no_msr) {
 		BIC_PRESENT(BIC_Totl_c0);
 		BIC_PRESENT(BIC_Any_c0);
 		BIC_PRESENT(BIC_GFX_c0);
@@ -5714,10 +5777,12 @@ void process_cpuid()
 	ecx_flags = ecx;
 	edx_flags = edx;
 
-	if (get_msr(sched_getcpu(), MSR_IA32_UCODE_REV, &ucode_patch))
-		warnx("get_msr(UCODE)");
-	else
-		ucode_patch_valid = true;
+	if (!no_msr) {
+		if (get_msr(sched_getcpu(), MSR_IA32_UCODE_REV, &ucode_patch))
+			warnx("get_msr(UCODE)");
+		else
+			ucode_patch_valid = true;
+	}
 
 	/*
 	 * check max extended function levels of CPUID.
@@ -5892,7 +5957,7 @@ void probe_pm_features(void)
 
 	probe_thermal();
 
-	if (platform->has_nhm_msrs)
+	if (platform->has_nhm_msrs && !no_msr)
 		BIC_PRESENT(BIC_SMI);
 
 	if (!quiet)
@@ -6252,8 +6317,10 @@ void turbostat_init()
 {
 	setup_all_buffers(true);
 	set_base_cpu();
-	check_dev_msr();
-	check_permissions();
+	if (!no_msr) {
+		check_dev_msr();
+		check_permissions();
+	}
 	process_cpuid();
 	probe_pm_features();
 	linux_perf_init();
@@ -6370,6 +6437,9 @@ int add_counter(unsigned int msr_num, char *path, char *name,
 {
 	struct msr_counter *msrp;
 
+	if (no_msr && msr_num)
+		errx(1, "Requested MSR counter 0x%x, but in --no-msr mode", msr_num);
+
 	msrp = calloc(1, sizeof(struct msr_counter));
 	if (msrp == NULL) {
 		perror("calloc");
@@ -6674,6 +6744,7 @@ void cmdline(int argc, char **argv)
 		{ "list", no_argument, 0, 'l' },
 		{ "out", required_argument, 0, 'o' },
 		{ "quiet", no_argument, 0, 'q' },
+		{ "no-msr", no_argument, 0, 'M' },
 		{ "show", required_argument, 0, 's' },
 		{ "Summary", no_argument, 0, 'S' },
 		{ "TCC", required_argument, 0, 'T' },
@@ -6683,7 +6754,22 @@ void cmdline(int argc, char **argv)
 
 	progname = argv[0];
 
-	while ((opt = getopt_long_only(argc, argv, "+C:c:Dde:hi:Jn:o:qST:v", long_options, &option_index)) != -1) {
+	/*
+	 * Parse some options early, because they may make other options invalid,
+	 * like adding the MSR counter with --add and at the same time using --no-msr.
+	 */
+	while ((opt = getopt_long_only(argc, argv, "M", long_options, &option_index)) != -1) {
+		switch (opt) {
+		case 'M':
+			no_msr = 1;
+			break;
+		default:
+			break;
+		}
+	}
+	optind = 0;
+
+	while ((opt = getopt_long_only(argc, argv, "+C:c:Dde:hi:Jn:o:qMST:v", long_options, &option_index)) != -1) {
 		switch (opt) {
 		case 'a':
 			parse_add_command(optarg);
@@ -6741,6 +6827,9 @@ void cmdline(int argc, char **argv)
 		case 'q':
 			quiet = 1;
 			break;
+		case 'M':
+			/* Parsed earlier */
+			break;
 		case 'n':
 			num_iterations = strtod(optarg, NULL);
 
@@ -6817,6 +6906,9 @@ int main(int argc, char **argv)
 	outf = stderr;
 	cmdline(argc, argv);
 
+	if (no_msr)
+		bic_disable_msr_access();
+
 	if (!quiet) {
 		print_version();
 		print_bootcmd();
@@ -6829,7 +6921,8 @@ int main(int argc, char **argv)
 
 	turbostat_init();
 
-	msr_sum_record();
+	if (!no_msr)
+		msr_sum_record();
 
 	/* dump counters and exit */
 	if (dump_only)
-- 
2.40.1


