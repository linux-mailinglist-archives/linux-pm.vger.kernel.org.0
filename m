Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F03DD29F471
	for <lists+linux-pm@lfdr.de>; Thu, 29 Oct 2020 20:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbgJ2TDW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Oct 2020 15:03:22 -0400
Received: from mail.skyhub.de ([5.9.137.197]:44282 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbgJ2TDN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 29 Oct 2020 15:03:13 -0400
Received: from zn.tnic (p200300ec2f0ce9003d743c4902fedd6b.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:e900:3d74:3c49:2fe:dd6b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DDBC11EC04DF;
        Thu, 29 Oct 2020 20:03:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1603998192;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6cXGQZ8AQHng+4XungGa7nZ70/GyrbVXVlX6fuu7CYg=;
        b=rRIPC++yKmVFUu1skX92udzN+vwHCb5zUfQQcJ6G1j6X5MmtkrPMtK1GV7VVsrUHVSZz7s
        KauTClOAL2TRKP7hcQ6UjYf7vgqWpSgmUY/5P+9IVh/bv/wxazaIL2IyX6lclnQO8lcF/b
        OF7Xouy80KJI7dVpPwXTUbHIoClZ6SI=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 3/4] tools/power/x86_energy_perf_policy: Read energy_perf_bias from sysfs
Date:   Thu, 29 Oct 2020 20:02:58 +0100
Message-Id: <20201029190259.3476-4-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201029190259.3476-1-bp@alien8.de>
References: <20201029190259.3476-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

... and stop poking at the MSR directly.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 .../x86_energy_perf_policy.c                  | 109 ++++++++++++++++--
 1 file changed, 99 insertions(+), 10 deletions(-)

diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
index 3fe1eed900d4..ad6aed1fabf8 100644
--- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
+++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
@@ -91,6 +91,9 @@ unsigned int has_hwp_request_pkg;	/* IA32_HWP_REQUEST_PKG */
 
 unsigned int bdx_highest_ratio;
 
+#define PATH_TO_CPU "/sys/devices/system/cpu/"
+#define SYSFS_PATH_MAX 255
+
 /*
  * maintain compatibility with original implementation, but don't document it:
  */
@@ -668,6 +671,48 @@ int put_msr(int cpu, int offset, unsigned long long new_msr)
 	return 0;
 }
 
+static unsigned int read_sysfs(const char *path, char *buf, size_t buflen)
+{
+	ssize_t numread;
+	int fd;
+
+	fd = open(path, O_RDONLY);
+	if (fd == -1)
+		return 0;
+
+	numread = read(fd, buf, buflen - 1);
+	if (numread < 1) {
+		close(fd);
+		return 0;
+	}
+
+	buf[numread] = '\0';
+	close(fd);
+
+	return (unsigned int) numread;
+}
+
+static unsigned int write_sysfs(const char *path, char *buf, size_t buflen)
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
+		perror("write failed\n");
+		close(fd);
+		return -1;
+	}
+
+	close(fd);
+
+	return (unsigned int) numwritten;
+}
+
 void print_hwp_cap(int cpu, struct msr_hwp_cap *cap, char *str)
 {
 	if (cpu != -1)
@@ -745,17 +790,61 @@ void write_hwp_request(int cpu, struct msr_hwp_request *hwp_req, unsigned int ms
 	put_msr(cpu, msr_offset, msr);
 }
 
+static int get_epb(int cpu)
+{
+	char path[SYSFS_PATH_MAX];
+	char linebuf[3];
+	char *endp;
+	long val;
+
+	if (!has_epb)
+		return -1;
+
+	snprintf(path, sizeof(path), PATH_TO_CPU "cpu%u/power/energy_perf_bias", cpu);
+
+	if (!read_sysfs(path, linebuf, 3))
+		return -1;
+
+	val = strtol(linebuf, &endp, 0);
+	if (endp == linebuf || errno == ERANGE)
+		return -1;
+
+	return (int)val;
+}
+
+static int set_epb(int cpu, int val)
+{
+	char path[SYSFS_PATH_MAX];
+	char linebuf[3];
+	char *endp;
+	int ret;
+
+	if (!has_epb)
+		return -1;
+
+	snprintf(path, sizeof(path), PATH_TO_CPU "cpu%u/power/energy_perf_bias", cpu);
+	snprintf(linebuf, sizeof(linebuf), "%d", val);
+
+	ret = write_sysfs(path, linebuf, 3);
+	if (ret <= 0)
+		return -1;
+
+	val = strtol(linebuf, &endp, 0);
+	if (endp == linebuf || errno == ERANGE)
+		return -1;
+
+	return (int)val;
+}
+
 int print_cpu_msrs(int cpu)
 {
-	unsigned long long msr;
 	struct msr_hwp_request req;
 	struct msr_hwp_cap cap;
+	int epb;
 
-	if (has_epb) {
-		get_msr(cpu, MSR_IA32_ENERGY_PERF_BIAS, &msr);
-
-		printf("cpu%d: EPB %u\n", cpu, (unsigned int) msr);
-	}
+	epb = get_epb(cpu);
+	if (epb >= 0)
+		printf("cpu%d: EPB %u\n", cpu, (unsigned int) epb);
 
 	if (!has_hwp)
 		return 0;
@@ -1038,15 +1127,15 @@ int enable_hwp_on_cpu(int cpu)
 int update_cpu_msrs(int cpu)
 {
 	unsigned long long msr;
-
+	int epb;
 
 	if (update_epb) {
-		get_msr(cpu, MSR_IA32_ENERGY_PERF_BIAS, &msr);
-		put_msr(cpu, MSR_IA32_ENERGY_PERF_BIAS, new_epb);
+		epb = get_epb(cpu);
+		set_epb(cpu, new_epb);
 
 		if (verbose)
 			printf("cpu%d: ENERGY_PERF_BIAS old: %d new: %d\n",
-				cpu, (unsigned int) msr, (unsigned int) new_epb);
+				cpu, epb, (unsigned int) new_epb);
 	}
 
 	if (update_turbo) {
-- 
2.21.0

