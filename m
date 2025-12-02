Return-Path: <linux-pm+bounces-39116-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BE5C9D0CB
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 22:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A3AE3A340C
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 21:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BDA2FABE0;
	Tue,  2 Dec 2025 21:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQJyv3TQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06772F7ADD
	for <linux-pm@vger.kernel.org>; Tue,  2 Dec 2025 21:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764710322; cv=none; b=uUb3Z/U1DbFO+6Pd56Jee7SLoP0+BZcalDzCELvFbhg4Py9DYQzy1gTZPQSXCEbXJ6a8zwhQp06edHUIzte8W0S4z7dxN69RQvOu0w9k1VhMNazjNfkOlKy21kCvU/vZ5+vHXtORTEsGQc8DUOlQi/qNsZiIq4c2pBg+M1mpTD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764710322; c=relaxed/simple;
	bh=0NV7MVHhaCKa4zPP6gXCVmmu7yfcNvGq9j3exfQbFgc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VECURBAhD1mIgVMj+nkseAglSuZdCCABBHs4s8Rl5cPBVdfteo4DmbycEH0XL5qTpetOlwELpVT8t8fhloCZfvVBuJoAit4nohumm57pBRxUSn3p3oR9KcHrLNSPKhLyvn0SdLHKhzdUHCKa+wj7Rd9msvFfFSyZ+CX+6cYfOfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQJyv3TQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1B1BC4CEF1;
	Tue,  2 Dec 2025 21:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764710322;
	bh=0NV7MVHhaCKa4zPP6gXCVmmu7yfcNvGq9j3exfQbFgc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=aQJyv3TQiUQrskRwlW6fKgBeXjaKxmpst7VH/SP3O1fSdGxfnAtMQ+KmOCpZzb7MS
	 xZ9pGgZcQ4aHcFglcP2pG7WR0JjgfsT2PmKuKB7+iHSNZr+ARBjcOGp5MDx/6M3DkO
	 Y7wp+dRMCNJauWkXIsrwNgjzf9olCBezhhrlIHBoTnTYZ8I/TC4l9I8NuZvnQ2nFOq
	 MxpiRiCiv3SrXr75nvtQ2rZylZi+itsmuTslAH6a2iuWaGVAcUomLPwPJjF6NE7OP2
	 hbzE73kHC0NHIj8e1KrMmUTK84fD1ueBDYGAhcp1y7OyHA5LBBy3BcKi5VT1GYCs5Z
	 tdXOTnt/uJZIw==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 10/21] tools/power turbostat: Add run-time MSR driver probe
Date: Tue,  2 Dec 2025 16:13:28 -0500
Message-ID: <d71cb404f002d0aa012e6b394752ff3cfc8d9f73.1764710012.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <92664f2e6ab2228a3330734fc72dabeaf8a49ee1.1764710012.git.len.brown@intel.com>
References: <92664f2e6ab2228a3330734fc72dabeaf8a49ee1.1764710012.git.len.brown@intel.com>
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

Rather than starting down the conditional-compile road...

Probe the location of the MSR files at run-time.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 68 +++++++++++++++------------
 1 file changed, 39 insertions(+), 29 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 8154d110dd07..e85bdb00f24a 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -142,6 +142,7 @@ struct msr_counter {
 #define	FLAGS_SHOW	(1 << 1)
 #define	SYSFS_PERCPU	(1 << 1)
 };
+static int use_android_msr_path;
 
 struct msr_counter bic[] = {
 	{ 0x0, "usec", NULL, 0, 0, 0, NULL, 0 },
@@ -2413,20 +2414,11 @@ int get_msr_fd(int cpu)
 
 	if (fd)
 		return fd;
-#if defined(ANDROID)
-	sprintf(pathname, "/dev/msr%d", cpu);
-#else
-	sprintf(pathname, "/dev/cpu/%d/msr", cpu);
-#endif
+	sprintf(pathname, use_android_msr_path ? "/dev/msr%d" : "/dev/cpu/%d/msr", cpu);
 	fd = open(pathname, O_RDONLY);
 	if (fd < 0)
-#if defined(ANDROID)
-		err(-1, "%s open failed, try chown or chmod +r /dev/msr*, "
-		    "or run with --no-msr, or run as root", pathname);
-#else
-		err(-1, "%s open failed, try chown or chmod +r /dev/cpu/*/msr, "
-		    "or run with --no-msr, or run as root", pathname);
-#endif
+		err(-1, "%s open failed, try chown or chmod +r %s, "
+		    "or run with --no-msr, or run as root", pathname, use_android_msr_path ? "/dev/msr*" : "/dev/cpu/*/msr");
 	fd_percpu[cpu] = fd;
 
 	return fd;
@@ -6777,21 +6769,43 @@ void turbostat_loop()
 	}
 }
 
-void check_dev_msr()
+int probe_dev_msr(void)
+{
+	struct stat sb;
+	char pathname[32];
+
+        sprintf(pathname, "/dev/msr%d", base_cpu);
+        return !stat(pathname, &sb);
+}
+
+int probe_dev_cpu_msr(void)
 {
 	struct stat sb;
 	char pathname[32];
 
-	if (no_msr)
-		return;
-#if defined(ANDROID)
-	sprintf(pathname, "/dev/msr%d", base_cpu);
-#else
 	sprintf(pathname, "/dev/cpu/%d/msr", base_cpu);
-#endif
-	if (stat(pathname, &sb))
-		if (system("/sbin/modprobe msr > /dev/null 2>&1"))
-			no_msr = 1;
+	return !stat(pathname, &sb);
+}
+
+int probe_msr_driver(void)
+{
+	if (probe_dev_msr()) {
+		use_android_msr_path = 1;
+		return 1;
+	}
+	return probe_dev_cpu_msr();
+}
+
+void check_msr_driver(void)
+{
+	if (probe_msr_driver())
+		return;
+
+	if (system("/sbin/modprobe msr > /dev/null 2>&1"))
+		no_msr = 1;
+
+	if (!probe_msr_driver())
+		no_msr = 1;
 }
 
 /*
@@ -6846,11 +6860,7 @@ void check_msr_permission(void)
 	failed += check_for_cap_sys_rawio();
 
 	/* test file permissions */
-#if defined(ANDROID)
-	sprintf(pathname, "/dev/msr%d", base_cpu);
-#else
-	sprintf(pathname, "/dev/cpu/%d/msr", base_cpu);
-#endif
+	sprintf(pathname, use_android_msr_path ? "/dev/msr%d" : "/dev/cpu/%d/msr", base_cpu);
 	if (euidaccess(pathname, R_OK)) {
 		failed++;
 	}
@@ -9476,7 +9486,7 @@ bool has_added_counters(void)
 
 void check_msr_access(void)
 {
-	check_dev_msr();
+	check_msr_driver();
 	check_msr_permission();
 
 	if (no_msr)
@@ -10147,7 +10157,7 @@ int get_and_dump_counters(void)
 
 void print_version()
 {
-	fprintf(outf, "turbostat version 2025.10.24 - Len Brown <lenb@kernel.org>\n");
+	fprintf(outf, "turbostat version 2025.11.29 - Len Brown <lenb@kernel.org>\n");
 }
 
 #define COMMAND_LINE_SIZE 2048
-- 
2.45.2


