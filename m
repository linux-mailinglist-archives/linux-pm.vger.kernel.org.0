Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 263ED28F51F
	for <lists+linux-pm@lfdr.de>; Thu, 15 Oct 2020 16:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389186AbgJOOqp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Oct 2020 10:46:45 -0400
Received: from mail.skyhub.de ([5.9.137.197]:48162 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389099AbgJOOqT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 15 Oct 2020 10:46:19 -0400
Received: from zn.tnic (p200300ec2f0ed2005c4d90d75300802a.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:d200:5c4d:90d7:5300:802a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0C3EB1EC0380;
        Thu, 15 Oct 2020 16:46:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1602773177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ift/+6nNDAL5TzMTDEhFdJR7nk8eIUURJcaFE6ruXfs=;
        b=NsH5A8XEoWrwlRuhlZivwmms705isQUhPvwfB3J9ggq/WyyJXJKq9PRmfARXzlFgUrvGLR
        LqrtlwDOsBbKRiZi9R8HABFnf7lHSqAL7dkMQnwCVGdAHKtf99l2LgS9dIH9p4s1I0YiFK
        PCTVhM9WABkfEHyMWPVfN+67LxGhfaM=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/4] tools/power/cpupower: Read energy_perf_bias from sysfs
Date:   Thu, 15 Oct 2020 16:46:00 +0200
Message-Id: <20201015144603.27933-2-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201015144603.27933-1-bp@alien8.de>
References: <20201015144603.27933-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

... instead of poking at the MSR. For that, move the accessor functions
to misc.c and add a sysfs-writing function too.

There should be no functional changes resulting from this.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Thomas Renninger <trenn@suse.com>
Cc: Shuah Khan <shuah@kernel.org>
---
 tools/power/cpupower/lib/cpupower.c          | 23 +++++++++-
 tools/power/cpupower/lib/cpupower_intern.h   |  5 ++
 tools/power/cpupower/utils/cpupower-info.c   |  2 +-
 tools/power/cpupower/utils/cpupower-set.c    |  2 +-
 tools/power/cpupower/utils/helpers/helpers.h |  8 ++--
 tools/power/cpupower/utils/helpers/misc.c    | 48 ++++++++++++++++++++
 tools/power/cpupower/utils/helpers/msr.c     | 28 ------------
 7 files changed, 81 insertions(+), 35 deletions(-)

diff --git a/tools/power/cpupower/lib/cpupower.c b/tools/power/cpupower/lib/cpupower.c
index 3656e697537e..d2fa4bbecf74 100644
--- a/tools/power/cpupower/lib/cpupower.c
+++ b/tools/power/cpupower/lib/cpupower.c
@@ -16,8 +16,8 @@
 
 unsigned int cpupower_read_sysfs(const char *path, char *buf, size_t buflen)
 {
-	int fd;
 	ssize_t numread;
+	int fd;
 
 	fd = open(path, O_RDONLY);
 	if (fd == -1)
@@ -35,6 +35,27 @@ unsigned int cpupower_read_sysfs(const char *path, char *buf, size_t buflen)
 	return (unsigned int) numread;
 }
 
+unsigned int cpupower_write_sysfs(const char *path, char *buf, size_t buflen)
+{
+	ssize_t numwritten;
+	int fd;
+
+	fd = open(path, O_WRONLY);
+	if (fd == -1)
+		return 0;
+
+	numwritten = write(fd, buf, buflen - 1);
+	if (numwritten < 1) {
+		perror("write failed");
+		close(fd);
+		return -1;
+	}
+
+	close(fd);
+
+	return (unsigned int) numwritten;
+}
+
 /*
  * Detect whether a CPU is online
  *
diff --git a/tools/power/cpupower/lib/cpupower_intern.h b/tools/power/cpupower/lib/cpupower_intern.h
index 4887c76d23f8..ac1112b956ec 100644
--- a/tools/power/cpupower/lib/cpupower_intern.h
+++ b/tools/power/cpupower/lib/cpupower_intern.h
@@ -1,6 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #define PATH_TO_CPU "/sys/devices/system/cpu/"
+
+#ifndef MAX_LINE_LEN
 #define MAX_LINE_LEN 4096
+#endif
+
 #define SYSFS_PATH_MAX 255
 
 unsigned int cpupower_read_sysfs(const char *path, char *buf, size_t buflen);
+unsigned int cpupower_write_sysfs(const char *path, char *buf, size_t buflen);
diff --git a/tools/power/cpupower/utils/cpupower-info.c b/tools/power/cpupower/utils/cpupower-info.c
index 0ba61a2c4d81..06345b543786 100644
--- a/tools/power/cpupower/utils/cpupower-info.c
+++ b/tools/power/cpupower/utils/cpupower-info.c
@@ -101,7 +101,7 @@ int cmd_info(int argc, char **argv)
 		}
 
 		if (params.perf_bias) {
-			ret = msr_intel_get_perf_bias(cpu);
+			ret = cpupower_intel_get_perf_bias(cpu);
 			if (ret < 0) {
 				fprintf(stderr,
 			_("Could not read perf-bias value[%d]\n"), ret);
diff --git a/tools/power/cpupower/utils/cpupower-set.c b/tools/power/cpupower/utils/cpupower-set.c
index 052044d7e012..180d5ba877e6 100644
--- a/tools/power/cpupower/utils/cpupower-set.c
+++ b/tools/power/cpupower/utils/cpupower-set.c
@@ -95,7 +95,7 @@ int cmd_set(int argc, char **argv)
 		}
 
 		if (params.perf_bias) {
-			ret = msr_intel_set_perf_bias(cpu, perf_bias);
+			ret = cpupower_intel_set_perf_bias(cpu, perf_bias);
 			if (ret) {
 				fprintf(stderr, _("Error setting perf-bias "
 						  "value on CPU %d\n"), cpu);
diff --git a/tools/power/cpupower/utils/helpers/helpers.h b/tools/power/cpupower/utils/helpers/helpers.h
index c258eeccd05f..37dac161f3fe 100644
--- a/tools/power/cpupower/utils/helpers/helpers.h
+++ b/tools/power/cpupower/utils/helpers/helpers.h
@@ -105,8 +105,8 @@ extern struct cpupower_cpu_info cpupower_cpu_info;
 extern int read_msr(int cpu, unsigned int idx, unsigned long long *val);
 extern int write_msr(int cpu, unsigned int idx, unsigned long long val);
 
-extern int msr_intel_set_perf_bias(unsigned int cpu, unsigned int val);
-extern int msr_intel_get_perf_bias(unsigned int cpu);
+extern int cpupower_intel_set_perf_bias(unsigned int cpu, unsigned int val);
+extern int cpupower_intel_get_perf_bias(unsigned int cpu);
 extern unsigned long long msr_intel_get_turbo_ratio(unsigned int cpu);
 
 /* Read/Write msr ****************************/
@@ -150,9 +150,9 @@ static inline int read_msr(int cpu, unsigned int idx, unsigned long long *val)
 { return -1; };
 static inline int write_msr(int cpu, unsigned int idx, unsigned long long val)
 { return -1; };
-static inline int msr_intel_set_perf_bias(unsigned int cpu, unsigned int val)
+static inline int cpupower_intel_set_perf_bias(unsigned int cpu, unsigned int val)
 { return -1; };
-static inline int msr_intel_get_perf_bias(unsigned int cpu)
+static inline int cpupower_intel_get_perf_bias(unsigned int cpu)
 { return -1; };
 static inline unsigned long long msr_intel_get_turbo_ratio(unsigned int cpu)
 { return 0; };
diff --git a/tools/power/cpupower/utils/helpers/misc.c b/tools/power/cpupower/utils/helpers/misc.c
index f406adc40bad..e8f8f643a627 100644
--- a/tools/power/cpupower/utils/helpers/misc.c
+++ b/tools/power/cpupower/utils/helpers/misc.c
@@ -1,7 +1,15 @@
 // SPDX-License-Identifier: GPL-2.0
+
+#include <stdio.h>
+#include <errno.h>
+#include <stdlib.h>
+
 #if defined(__i386__) || defined(__x86_64__)
 
 #include "helpers/helpers.h"
+#include "helpers/sysfs.h"
+
+#include "cpupower_intern.h"
 
 #define MSR_AMD_HWCR	0xc0010015
 
@@ -40,4 +48,44 @@ int cpufreq_has_boost_support(unsigned int cpu, int *support, int *active,
 		*support = *active = 1;
 	return 0;
 }
+
+int cpupower_intel_get_perf_bias(unsigned int cpu)
+{
+	char linebuf[MAX_LINE_LEN];
+	char path[SYSFS_PATH_MAX];
+	unsigned long val;
+	char *endp;
+
+	if (!(cpupower_cpu_info.caps & CPUPOWER_CAP_PERF_BIAS))
+		return -1;
+
+	snprintf(path, sizeof(path), PATH_TO_CPU "cpu%u/power/energy_perf_bias", cpu);
+
+	if (cpupower_read_sysfs(path, linebuf, MAX_LINE_LEN) == 0)
+		return -1;
+
+	val = strtol(linebuf, &endp, 0);
+	if (endp == linebuf || errno == ERANGE)
+		return -1;
+
+	return val;
+}
+
+int cpupower_intel_set_perf_bias(unsigned int cpu, unsigned int val)
+{
+	char path[SYSFS_PATH_MAX];
+	char linebuf[3] = {};
+
+	if (!(cpupower_cpu_info.caps & CPUPOWER_CAP_PERF_BIAS))
+		return -1;
+
+	snprintf(path, sizeof(path), PATH_TO_CPU "cpu%u/power/energy_perf_bias", cpu);
+	snprintf(linebuf, sizeof(linebuf), "%d", val);
+
+	if (cpupower_write_sysfs(path, linebuf, 3) <= 0)
+		return -1;
+
+	return 0;
+}
+
 #endif /* #if defined(__i386__) || defined(__x86_64__) */
diff --git a/tools/power/cpupower/utils/helpers/msr.c b/tools/power/cpupower/utils/helpers/msr.c
index ab9950748838..8b0b6be74bb8 100644
--- a/tools/power/cpupower/utils/helpers/msr.c
+++ b/tools/power/cpupower/utils/helpers/msr.c
@@ -11,7 +11,6 @@
 /* Intel specific MSRs */
 #define MSR_IA32_PERF_STATUS		0x198
 #define MSR_IA32_MISC_ENABLES		0x1a0
-#define MSR_IA32_ENERGY_PERF_BIAS	0x1b0
 #define MSR_NEHALEM_TURBO_RATIO_LIMIT	0x1ad
 
 /*
@@ -73,33 +72,6 @@ int write_msr(int cpu, unsigned int idx, unsigned long long val)
 	return -1;
 }
 
-int msr_intel_get_perf_bias(unsigned int cpu)
-{
-	unsigned long long val;
-	int ret;
-
-	if (!(cpupower_cpu_info.caps & CPUPOWER_CAP_PERF_BIAS))
-		return -1;
-
-	ret = read_msr(cpu, MSR_IA32_ENERGY_PERF_BIAS, &val);
-	if (ret)
-		return ret;
-	return val;
-}
-
-int msr_intel_set_perf_bias(unsigned int cpu, unsigned int val)
-{
-	int ret;
-
-	if (!(cpupower_cpu_info.caps & CPUPOWER_CAP_PERF_BIAS))
-		return -1;
-
-	ret = write_msr(cpu, MSR_IA32_ENERGY_PERF_BIAS, val);
-	if (ret)
-		return ret;
-	return 0;
-}
-
 unsigned long long msr_intel_get_turbo_ratio(unsigned int cpu)
 {
 	unsigned long long val;
-- 
2.21.0

