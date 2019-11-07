Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C73FEF23E9
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2019 02:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbfKGBAe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Nov 2019 20:00:34 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:46582 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727393AbfKGBAd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Nov 2019 20:00:33 -0500
Received: by mail-io1-f66.google.com with SMTP id c6so333726ioo.13
        for <linux-pm@vger.kernel.org>; Wed, 06 Nov 2019 17:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=hxQWDQLia8lBiCl3uezgDZARO/XKOgU53YhhxKvDPQ4=;
        b=Fc3C09MzNnOZ7M1uyelRHdlimoZPtVk84uewH1Ix9SNkTsWkNeRe5+EffYjOBJzcD1
         bWpKERnCJ2dd3gWw4jpdUJ7L/mN941p7qyG3ctzFzjk8KBpxwJ6weJi+7I07Xlg0arPp
         tEHH6NKfvcWXOw2qgmaaDPmIfAJpFnKJSyfjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=hxQWDQLia8lBiCl3uezgDZARO/XKOgU53YhhxKvDPQ4=;
        b=FGzjGPlDgoNq/dNoPZyuPnU4n++VTX9cTc/TdQW6yAJsAYFZe62C0N+DVi1VzAZt3J
         pkjsecdhtkc364+NFWSYeMB8zAAml7A1e8c4SyGoabYezhtBWhIjiV3yMfPB+JBENjOZ
         xrTEax1nLPjB9lGIytiPexKwhXyOoAhDdOtazY6b+/Uaes3jmLjolgnRSJP59/bEitrs
         H4TZyOEnmd5bWpnZjYIMhpbLFIvFRFXiZI5E4ewCf7vkJR6F0ESDf5kcOAWzAWoXzTlq
         uXaAN53u7b35PujyBQB359fM4UD2k6wIKy+q99Cko6SELRGKaBHNbVsjGApCXQcvLA8B
         T0mw==
X-Gm-Message-State: APjAAAXzg4z2FFo6mSnn0NUjVBDDzH89mH1esYIv/LksguFAQH18wVAA
        KQoZ24Z8qRuNVbIaxDeK/2L5Fg==
X-Google-Smtp-Source: APXvYqx3VJUjsjfHRNmIy8AteeKYhAPmvVdmF7mS5ckPGRvJJK6CmkwEoUs0kGYyLG8NrL6iUu6imQ==
X-Received: by 2002:a6b:5503:: with SMTP id j3mr606382iob.151.1573088432612;
        Wed, 06 Nov 2019 17:00:32 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id c5sm40993ioc.26.2019.11.06.17.00.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 17:00:31 -0800 (PST)
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Thomas Renninger <trenn@suse.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] cpupower update for Linux 5.5-rc1
Message-ID: <49ce5255-a0aa-1c64-90c6-ad80381d333a@linuxfoundation.org>
Date:   Wed, 6 Nov 2019 18:00:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------B5F8CB7DCC81A355BF0AA2F8"
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This is a multi-part message in MIME format.
--------------B5F8CB7DCC81A355BF0AA2F8
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Rafael,

Please pull the following update for Linux 5.5-rc1.

This cpupower update for Linux 5.5-rc1 consists of bug fixes and
improvements to make it more accurate by removing the userspace
to kernel transition and read_msr initiated IPI delays.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

   Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux 
tags/linux-cpupower-5.5-rc1

for you to fetch changes up to 4611a4fb0cce3973dce8c9d74e5d6261ffa4210f:

   cpupower: ToDo: Update ToDo with ideas for per_cpu_schedule handling 
(2019-11-05 17:23:23 -0700)

----------------------------------------------------------------
linux-cpupower-5.5-rc1

This cpupower update for Linux 5.5-rc1 consists of bug fixes and
improvements to make it more accurate by removing the userspace
to kernel transition and read_msr initiated IPI delays.

----------------------------------------------------------------
Abhishek Goel (1):
       cpupower : Handle set and info subcommands correctly

Janakarajan Natarajan (4):
       cpupower: Move needs_root variable into a sub-struct
       cpupower: mperf_monitor: Introduce per_cpu_schedule flag
       cpupower: mperf_monitor: Update cpupower to use the RDPRU instruction
       cpupower: ToDo: Update ToDo with ideas for per_cpu_schedule handling

Nathan Chancellor (1):
       tools/power/cpupower: Fix initializer override in hsw_ext_cstates

  tools/power/cpupower/ToDo                          | 14 +++++
  tools/power/cpupower/utils/cpupower-info.c         |  9 +++
  tools/power/cpupower/utils/cpupower-set.c          |  9 +++
  tools/power/cpupower/utils/helpers/cpuid.c         |  4 ++
  tools/power/cpupower/utils/helpers/helpers.h       |  1 +
  .../cpupower/utils/idle_monitor/amd_fam14h_idle.c  |  2 +-
  .../cpupower/utils/idle_monitor/cpuidle_sysfs.c    |  2 +-
  .../cpupower/utils/idle_monitor/cpupower-monitor.c |  2 +-
  .../cpupower/utils/idle_monitor/cpupower-monitor.h |  5 +-
  .../cpupower/utils/idle_monitor/hsw_ext_idle.c     |  3 +-
  .../cpupower/utils/idle_monitor/mperf_monitor.c    | 64 
++++++++++++++++++----
  tools/power/cpupower/utils/idle_monitor/nhm_idle.c |  2 +-
  tools/power/cpupower/utils/idle_monitor/snb_idle.c |  2 +-
  13 files changed, 100 insertions(+), 19 deletions(-)
----------------------------------------------------------------

--------------B5F8CB7DCC81A355BF0AA2F8
Content-Type: text/x-patch;
 name="linux-cpupower-5.5-rc1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-cpupower-5.5-rc1.diff"

diff --git a/tools/power/cpupower/ToDo b/tools/power/cpupower/ToDo
index 6e8b89f282e6..b196a139a3e4 100644
--- a/tools/power/cpupower/ToDo
+++ b/tools/power/cpupower/ToDo
@@ -8,3 +8,17 @@ ToDos sorted by priority:
 - Add another c1e debug idle monitor
   -> Is by design racy with BIOS, but could be added
      with a --force option and some "be careful" messages
+- Add cpu_start()/cpu_stop() callbacks for monitor
+  -> This is to move the per_cpu logic from inside the
+     monitor to outside it. This can be given higher
+     priority in fork_it.
+- Fork as many processes as there are CPUs in case the
+  per_cpu_schedule flag is set.
+  -> Bind forked process to each cpu.
+  -> Execute start measures via the forked processes on
+     each cpu.
+  -> Run test executable in a forked process.
+  -> Execute stop measures via the forked processes on
+     each cpu.
+  This would be ideal as it will not introduce noise in the
+  tested executable.
diff --git a/tools/power/cpupower/utils/cpupower-info.c b/tools/power/cpupower/utils/cpupower-info.c
index 4c9d342b70ff..d3755ea70d4d 100644
--- a/tools/power/cpupower/utils/cpupower-info.c
+++ b/tools/power/cpupower/utils/cpupower-info.c
@@ -10,6 +10,7 @@
 #include <errno.h>
 #include <string.h>
 #include <getopt.h>
+#include <sys/utsname.h>
 
 #include "helpers/helpers.h"
 #include "helpers/sysfs.h"
@@ -30,6 +31,7 @@ int cmd_info(int argc, char **argv)
 	extern char *optarg;
 	extern int optind, opterr, optopt;
 	unsigned int cpu;
+	struct utsname uts;
 
 	union {
 		struct {
@@ -39,6 +41,13 @@ int cmd_info(int argc, char **argv)
 	} params = {};
 	int ret = 0;
 
+	ret = uname(&uts);
+	if (!ret && (!strcmp(uts.machine, "ppc64le") ||
+		     !strcmp(uts.machine, "ppc64"))) {
+		fprintf(stderr, _("Subcommand not supported on POWER.\n"));
+		return ret;
+	}
+
 	setlocale(LC_ALL, "");
 	textdomain(PACKAGE);
 
diff --git a/tools/power/cpupower/utils/cpupower-set.c b/tools/power/cpupower/utils/cpupower-set.c
index 3cd95c6cb974..3cca6f715dd9 100644
--- a/tools/power/cpupower/utils/cpupower-set.c
+++ b/tools/power/cpupower/utils/cpupower-set.c
@@ -10,6 +10,7 @@
 #include <errno.h>
 #include <string.h>
 #include <getopt.h>
+#include <sys/utsname.h>
 
 #include "helpers/helpers.h"
 #include "helpers/sysfs.h"
@@ -31,6 +32,7 @@ int cmd_set(int argc, char **argv)
 	extern char *optarg;
 	extern int optind, opterr, optopt;
 	unsigned int cpu;
+	struct utsname uts;
 
 	union {
 		struct {
@@ -41,6 +43,13 @@ int cmd_set(int argc, char **argv)
 	int perf_bias = 0;
 	int ret = 0;
 
+	ret = uname(&uts);
+	if (!ret && (!strcmp(uts.machine, "ppc64le") ||
+		     !strcmp(uts.machine, "ppc64"))) {
+		fprintf(stderr, _("Subcommand not supported on POWER.\n"));
+		return ret;
+	}
+
 	setlocale(LC_ALL, "");
 	textdomain(PACKAGE);
 
diff --git a/tools/power/cpupower/utils/helpers/cpuid.c b/tools/power/cpupower/utils/helpers/cpuid.c
index 5cc39d4e23ed..73bfafc60e9b 100644
--- a/tools/power/cpupower/utils/helpers/cpuid.c
+++ b/tools/power/cpupower/utils/helpers/cpuid.c
@@ -131,6 +131,10 @@ int get_cpu_info(struct cpupower_cpu_info *cpu_info)
 		if (ext_cpuid_level >= 0x80000007 &&
 		    (cpuid_edx(0x80000007) & (1 << 9)))
 			cpu_info->caps |= CPUPOWER_CAP_AMD_CBP;
+
+		if (ext_cpuid_level >= 0x80000008 &&
+		    cpuid_ebx(0x80000008) & (1 << 4))
+			cpu_info->caps |= CPUPOWER_CAP_AMD_RDPRU;
 	}
 
 	if (cpu_info->vendor == X86_VENDOR_INTEL) {
diff --git a/tools/power/cpupower/utils/helpers/helpers.h b/tools/power/cpupower/utils/helpers/helpers.h
index 357b19bb136e..c258eeccd05f 100644
--- a/tools/power/cpupower/utils/helpers/helpers.h
+++ b/tools/power/cpupower/utils/helpers/helpers.h
@@ -69,6 +69,7 @@ enum cpupower_cpu_vendor {X86_VENDOR_UNKNOWN = 0, X86_VENDOR_INTEL,
 #define CPUPOWER_CAP_HAS_TURBO_RATIO	0x00000010
 #define CPUPOWER_CAP_IS_SNB		0x00000020
 #define CPUPOWER_CAP_INTEL_IDA		0x00000040
+#define CPUPOWER_CAP_AMD_RDPRU		0x00000080
 
 #define CPUPOWER_AMD_CPBDIS		0x02000000
 
diff --git a/tools/power/cpupower/utils/idle_monitor/amd_fam14h_idle.c b/tools/power/cpupower/utils/idle_monitor/amd_fam14h_idle.c
index 3f893b99b337..33dc34db4f3c 100644
--- a/tools/power/cpupower/utils/idle_monitor/amd_fam14h_idle.c
+++ b/tools/power/cpupower/utils/idle_monitor/amd_fam14h_idle.c
@@ -328,7 +328,7 @@ struct cpuidle_monitor amd_fam14h_monitor = {
 	.stop			= amd_fam14h_stop,
 	.do_register		= amd_fam14h_register,
 	.unregister		= amd_fam14h_unregister,
-	.needs_root		= 1,
+	.flags.needs_root	= 1,
 	.overflow_s		= OVERFLOW_MS / 1000,
 };
 #endif /* #if defined(__i386__) || defined(__x86_64__) */
diff --git a/tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c b/tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c
index f634aeb65c5f..3c4cee160b0e 100644
--- a/tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c
+++ b/tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c
@@ -207,6 +207,6 @@ struct cpuidle_monitor cpuidle_sysfs_monitor = {
 	.stop			= cpuidle_stop,
 	.do_register		= cpuidle_register,
 	.unregister		= cpuidle_unregister,
-	.needs_root		= 0,
+	.flags.needs_root	= 0,
 	.overflow_s		= UINT_MAX,
 };
diff --git a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
index d3c3e6e7aa26..6d44fec55ad5 100644
--- a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
+++ b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
@@ -408,7 +408,7 @@ int cmd_monitor(int argc, char **argv)
 		dprint("Try to register: %s\n", all_monitors[num]->name);
 		test_mon = all_monitors[num]->do_register();
 		if (test_mon) {
-			if (test_mon->needs_root && !run_as_root) {
+			if (test_mon->flags.needs_root && !run_as_root) {
 				fprintf(stderr, _("Available monitor %s needs "
 					  "root access\n"), test_mon->name);
 				continue;
diff --git a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.h b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.h
index a2d901d3bfaf..5b5eb1da0cce 100644
--- a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.h
+++ b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.h
@@ -60,7 +60,10 @@ struct cpuidle_monitor {
 	struct cpuidle_monitor* (*do_register) (void);
 	void (*unregister)(void);
 	unsigned int overflow_s;
-	int needs_root;
+	struct {
+		unsigned int needs_root:1;
+		unsigned int per_cpu_schedule:1;
+	} flags;
 };
 
 extern long long timespec_diff_us(struct timespec start, struct timespec end);
diff --git a/tools/power/cpupower/utils/idle_monitor/hsw_ext_idle.c b/tools/power/cpupower/utils/idle_monitor/hsw_ext_idle.c
index 7c7451d3f494..97ad3233a521 100644
--- a/tools/power/cpupower/utils/idle_monitor/hsw_ext_idle.c
+++ b/tools/power/cpupower/utils/idle_monitor/hsw_ext_idle.c
@@ -39,7 +39,6 @@ static cstate_t hsw_ext_cstates[HSW_EXT_CSTATE_COUNT] = {
 	{
 		.name			= "PC9",
 		.desc			= N_("Processor Package C9"),
-		.desc			= N_("Processor Package C2"),
 		.id			= PC9,
 		.range			= RANGE_PACKAGE,
 		.get_count_percent	= hsw_ext_get_count_percent,
@@ -188,7 +187,7 @@ struct cpuidle_monitor intel_hsw_ext_monitor = {
 	.stop			= hsw_ext_stop,
 	.do_register		= hsw_ext_register,
 	.unregister		= hsw_ext_unregister,
-	.needs_root		= 1,
+	.flags.needs_root	= 1,
 	.overflow_s		= 922000000 /* 922337203 seconds TSC overflow
 					       at 20GHz */
 };
diff --git a/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c b/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
index 44806a6dae11..e7d48cb563c0 100644
--- a/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
+++ b/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
@@ -19,6 +19,10 @@
 #define MSR_APERF	0xE8
 #define MSR_MPERF	0xE7
 
+#define RDPRU ".byte 0x0f, 0x01, 0xfd"
+#define RDPRU_ECX_MPERF	0
+#define RDPRU_ECX_APERF	1
+
 #define MSR_TSC	0x10
 
 #define MSR_AMD_HWCR 0xc0010015
@@ -86,15 +90,51 @@ static int mperf_get_tsc(unsigned long long *tsc)
 	return ret;
 }
 
+static int get_aperf_mperf(int cpu, unsigned long long *aval,
+				    unsigned long long *mval)
+{
+	unsigned long low_a, high_a;
+	unsigned long low_m, high_m;
+	int ret;
+
+	/*
+	 * Running on the cpu from which we read the registers will
+	 * prevent APERF/MPERF from going out of sync because of IPI
+	 * latency introduced by read_msr()s.
+	 */
+	if (mperf_monitor.flags.per_cpu_schedule) {
+		if (bind_cpu(cpu))
+			return 1;
+	}
+
+	if (cpupower_cpu_info.caps & CPUPOWER_CAP_AMD_RDPRU) {
+		asm volatile(RDPRU
+			     : "=a" (low_a), "=d" (high_a)
+			     : "c" (RDPRU_ECX_APERF));
+		asm volatile(RDPRU
+			     : "=a" (low_m), "=d" (high_m)
+			     : "c" (RDPRU_ECX_MPERF));
+
+		*aval = ((low_a) | (high_a) << 32);
+		*mval = ((low_m) | (high_m) << 32);
+
+		return 0;
+	}
+
+	ret  = read_msr(cpu, MSR_APERF, aval);
+	ret |= read_msr(cpu, MSR_MPERF, mval);
+
+	return ret;
+}
+
 static int mperf_init_stats(unsigned int cpu)
 {
-	unsigned long long val;
+	unsigned long long aval, mval;
 	int ret;
 
-	ret = read_msr(cpu, MSR_APERF, &val);
-	aperf_previous_count[cpu] = val;
-	ret |= read_msr(cpu, MSR_MPERF, &val);
-	mperf_previous_count[cpu] = val;
+	ret = get_aperf_mperf(cpu, &aval, &mval);
+	aperf_previous_count[cpu] = aval;
+	mperf_previous_count[cpu] = mval;
 	is_valid[cpu] = !ret;
 
 	return 0;
@@ -102,13 +142,12 @@ static int mperf_init_stats(unsigned int cpu)
 
 static int mperf_measure_stats(unsigned int cpu)
 {
-	unsigned long long val;
+	unsigned long long aval, mval;
 	int ret;
 
-	ret = read_msr(cpu, MSR_APERF, &val);
-	aperf_current_count[cpu] = val;
-	ret |= read_msr(cpu, MSR_MPERF, &val);
-	mperf_current_count[cpu] = val;
+	ret = get_aperf_mperf(cpu, &aval, &mval);
+	aperf_current_count[cpu] = aval;
+	mperf_current_count[cpu] = mval;
 	is_valid[cpu] = !ret;
 
 	return 0;
@@ -305,6 +344,9 @@ struct cpuidle_monitor *mperf_register(void)
 	if (init_maxfreq_mode())
 		return NULL;
 
+	if (cpupower_cpu_info.vendor == X86_VENDOR_AMD)
+		mperf_monitor.flags.per_cpu_schedule = 1;
+
 	/* Free this at program termination */
 	is_valid = calloc(cpu_count, sizeof(int));
 	mperf_previous_count = calloc(cpu_count, sizeof(unsigned long long));
@@ -333,7 +375,7 @@ struct cpuidle_monitor mperf_monitor = {
 	.stop			= mperf_stop,
 	.do_register		= mperf_register,
 	.unregister		= mperf_unregister,
-	.needs_root		= 1,
+	.flags.needs_root	= 1,
 	.overflow_s		= 922000000 /* 922337203 seconds TSC overflow
 					       at 20GHz */
 };
diff --git a/tools/power/cpupower/utils/idle_monitor/nhm_idle.c b/tools/power/cpupower/utils/idle_monitor/nhm_idle.c
index be7256696a37..114271165182 100644
--- a/tools/power/cpupower/utils/idle_monitor/nhm_idle.c
+++ b/tools/power/cpupower/utils/idle_monitor/nhm_idle.c
@@ -208,7 +208,7 @@ struct cpuidle_monitor intel_nhm_monitor = {
 	.stop			= nhm_stop,
 	.do_register		= intel_nhm_register,
 	.unregister		= intel_nhm_unregister,
-	.needs_root		= 1,
+	.flags.needs_root	= 1,
 	.overflow_s		= 922000000 /* 922337203 seconds TSC overflow
 					       at 20GHz */
 };
diff --git a/tools/power/cpupower/utils/idle_monitor/snb_idle.c b/tools/power/cpupower/utils/idle_monitor/snb_idle.c
index 968333571cad..df8b223cc096 100644
--- a/tools/power/cpupower/utils/idle_monitor/snb_idle.c
+++ b/tools/power/cpupower/utils/idle_monitor/snb_idle.c
@@ -192,7 +192,7 @@ struct cpuidle_monitor intel_snb_monitor = {
 	.stop			= snb_stop,
 	.do_register		= snb_register,
 	.unregister		= snb_unregister,
-	.needs_root		= 1,
+	.flags.needs_root	= 1,
 	.overflow_s		= 922000000 /* 922337203 seconds TSC overflow
 					       at 20GHz */
 };

--------------B5F8CB7DCC81A355BF0AA2F8--
