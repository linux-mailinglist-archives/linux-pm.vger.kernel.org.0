Return-Path: <linux-pm+bounces-39117-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E806BC9D0F2
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 22:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CE05D34A6DA
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 21:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08802FA0EF;
	Tue,  2 Dec 2025 21:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3QeeOve"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C112B2FBDE1
	for <linux-pm@vger.kernel.org>; Tue,  2 Dec 2025 21:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764710323; cv=none; b=sAadzCxB/q+M697D6FmrOJH09I943K76juQsT8IPv8VRF47GbaaS3+RVrBtiBKCTOx2kHhOuaydpvC667IQT5CSF8g/i4yfa0UzWEd3U0lVxZ4gdHykALIYOYaBgXtB8svoonzOIbze+H8b9xaGyk4FT2KbcOY+VNDmBLeknc2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764710323; c=relaxed/simple;
	bh=PcxOvf3fAnfMJ7ZAb5+wH5ezBZ3XpB4aBJfmKkhF8kY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lPmmQYD9SEM80s6JzzURvZGJgdnJStJT6DTZ+d/u2XNp6aDZL/5OwQexppg5IEgvk1YsftD6ZHNZvKW9vcEH+SAbKZS4vcAtb0ooDSurDZOX+2K8+/5bfGq6jqeQ0ZFdVIId0dff6Rbnz3n55mL6p+Z0RSSwaP/CTeSA4E8swUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3QeeOve; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4463C113D0;
	Tue,  2 Dec 2025 21:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764710323;
	bh=PcxOvf3fAnfMJ7ZAb5+wH5ezBZ3XpB4aBJfmKkhF8kY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=l3QeeOved2j+Z3pqLnqThzocZtdG5ws73aFPNhJoroKrdNq7iNCGgeYOq0XzFn96T
	 KsmXvN98R4wCdjwidY1nlDPXUMLIVtbIbEB00ZUh1gvpC72F0dO/lwWDn0QEo0WmNJ
	 LpoBtj1Z749QnqcoNjsY+V7E5gOaqUhRWozigNI8fgOzml+/VlclChkoE0eDggbv/I
	 yD6d0kPRzbC1hYknBJIo9PU8Q4GgrL3CV68d/9Ze33zBpbs8uu2KmUJK/9AflvPFHw
	 YiTjNnU6yXwOxoDL8tbWixRPofXUpdSH8HAlJ6fYwa96izBAajkH/4cwRh+TgPENFe
	 j4tIRYiceymKw==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Kaushlendra Kumar <kaushlendra.kumar@intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 11/21] tools/power x86_energy_perf_policy: Add Android MSR device support
Date: Tue,  2 Dec 2025 16:13:29 -0500
Message-ID: <2ff4b59f2e6222a13d76c4178bcd1878be3d23ac.1764710012.git.len.brown@intel.com>
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

From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>

Add support for Android MSR device paths which use /dev/msrN format
instead of the standard Linux /dev/cpu/N/msr format. The tool now
probes both path formats at startup and uses the appropriate one.

This enables x86_energy_perf_policy to work on Android systems where
MSR devices follow a different naming convention while maintaining
full compatibility with standard Linux systems.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 .../x86_energy_perf_policy.c                  | 54 ++++++++++++++++---
 1 file changed, 46 insertions(+), 8 deletions(-)

diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
index 884a4c746f32..5301efc741ce 100644
--- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
+++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
@@ -95,6 +95,9 @@ unsigned int bdx_highest_ratio;
 #define PATH_TO_CPU "/sys/devices/system/cpu/"
 #define SYSFS_PATH_MAX 255
 
+/* keep Default as a linux path */
+static int use_android_msr_path;
+
 /*
  * maintain compatibility with original implementation, but don't document it:
  */
@@ -678,16 +681,41 @@ void err_on_hypervisor(void)
 		    "not supported on this virtual machine");
 }
 
+static void probe_msr_path_format(void)
+{
+	struct stat sb;
+	char test_path[32];
+
+	/* Test standard Linux path */
+	sprintf(test_path, "/dev/cpu/%d/msr", base_cpu);
+	if (stat(test_path, &sb) == 0) {
+		use_android_msr_path = 0;
+		return;
+	}
+
+	/* Test Android-style path */
+	sprintf(test_path, "/dev/msr%d", base_cpu);
+	if (stat(test_path, &sb) == 0) {
+		use_android_msr_path = 1;
+		return;
+	}
+
+	/* If neither exists, keep the default Linux format */
+	use_android_msr_path = 0;
+}
+
 int get_msr(int cpu, int offset, unsigned long long *msr)
 {
 	int retval;
 	char pathname[32];
 	int fd;
 
-	sprintf(pathname, "/dev/cpu/%d/msr", cpu);
+	sprintf(pathname, use_android_msr_path ? "/dev/msr%d" : "/dev/cpu/%d/msr", cpu);
 	fd = open(pathname, O_RDONLY);
 	if (fd < 0)
-		err(-1, "%s open failed, try chown or chmod +r /dev/cpu/*/msr, or run as root", pathname);
+		err(-1, "%s open failed, try chown or chmod +r %s, or run as root",
+		   pathname, use_android_msr_path ? "/dev/msr*" : "/dev/cpu/*/msr");
+
 
 	retval = pread(fd, msr, sizeof(*msr), offset);
 	if (retval != sizeof(*msr)) {
@@ -708,10 +736,11 @@ int put_msr(int cpu, int offset, unsigned long long new_msr)
 	int retval;
 	int fd;
 
-	sprintf(pathname, "/dev/cpu/%d/msr", cpu);
+	sprintf(pathname, use_android_msr_path ? "/dev/msr%d" : "/dev/cpu/%d/msr", cpu);
 	fd = open(pathname, O_RDWR);
 	if (fd < 0)
-		err(-1, "%s open failed, try chown or chmod +r /dev/cpu/*/msr, or run as root", pathname);
+		err(-1, "%s open failed, try chown or chmod +r %s, or run as root",
+		   pathname, use_android_msr_path ? "/dev/msr*" : "/dev/cpu/*/msr");
 
 	retval = pwrite(fd, &new_msr, sizeof(new_msr), offset);
 	if (retval != sizeof(new_msr))
@@ -1427,10 +1456,15 @@ void probe_dev_msr(void)
 	struct stat sb;
 	char pathname[32];
 
-	sprintf(pathname, "/dev/cpu/%d/msr", base_cpu);
-	if (stat(pathname, &sb))
-		if (system("/sbin/modprobe msr > /dev/null 2>&1"))
-			err(-5, "no /dev/cpu/0/msr, Try \"# modprobe msr\" ");
+	sprintf(pathname, use_android_msr_path ? "/dev/msr%d" : "/dev/cpu/%d/msr", base_cpu);
+	if (stat(pathname, &sb)) {
+		if (system("/sbin/modprobe msr > /dev/null 2>&1")) {
+			if (use_android_msr_path)
+				err(-5, "no /dev/msr0, Try \"# modprobe msr\" ");
+			else
+				err(-5, "no /dev/cpu/0/msr, Try \"# modprobe msr\" ");
+		}
+	}
 }
 
 static void get_cpuid_or_exit(unsigned int leaf,
@@ -1547,6 +1581,10 @@ void parse_cpuid(void)
 int main(int argc, char **argv)
 {
 	set_base_cpu();
+
+	/* probe MSR path */
+	probe_msr_path_format();
+
 	probe_dev_msr();
 	init_data_structures();
 
-- 
2.45.2


