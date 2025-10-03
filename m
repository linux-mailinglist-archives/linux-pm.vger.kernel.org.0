Return-Path: <linux-pm+bounces-35687-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D855FBB6835
	for <lists+linux-pm@lfdr.de>; Fri, 03 Oct 2025 13:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3984434525F
	for <lists+linux-pm@lfdr.de>; Fri,  3 Oct 2025 11:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561A92E9729;
	Fri,  3 Oct 2025 11:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K5dSu53T"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245FB283680
	for <linux-pm@vger.kernel.org>; Fri,  3 Oct 2025 11:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759489512; cv=none; b=GKi8cvO6Wy5KQbVbNlbuSDTI72bUsPxkD36vO/z9dvsaNC58Pw34hJZ733JthKGjuZfpideJ5lbMyR0fmpV+4oVz1fkX2cHDiXBAUirvCDg94QIOfPNP+76cThByz/ci11CNrNyl5xTuswa4AjcxF0tYhF33HiUj8cH3GgbKN3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759489512; c=relaxed/simple;
	bh=ay4M8DRq1bh6ZMCKSmm3z2G15Pc2p69dwSm7+JMeAlo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CHui34OJLuvnxBhIc94VBkNGjuR+CskF49f9RJ9yq/xm2CVsNG0m4AZ2vDA+RaYZHPYFKsK7rc9+rd06MPn/tRt7sqP3ApI+999qmQE9jDFnncflTmPrDVQxib+URaFG5SR7ctUQFTOcOM1C4+4xH93pnLqrI6pTvf+bMq0Fecs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K5dSu53T; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759489510; x=1791025510;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ay4M8DRq1bh6ZMCKSmm3z2G15Pc2p69dwSm7+JMeAlo=;
  b=K5dSu53TJKMB4tasHXpMP8ctxMvmOKgLPG/n4OoENrOz0SrPphSnJ4iA
   5trXrf1qs9brlYfWOVykrQC5RGFyQMwz8ABk8psq11JWiZlI2F7z9YAx4
   CSHXX54ehQzAo6jvkXnte6GfSPL80Ji7IdO/eLc84XQ2C8y3xbgpJlxWI
   FYR+/gb8We68277UsuWB4aIMnx46WehYe9/hDNlnVDiS5vUA9/oIXFfME
   nhI9c+42/qxLgAPGs243Xx/Xfxy+DS4k2Je53mJmhu57RxrVZ05VMrMR5
   aDA1Rq5tR5Pj9jx2/J6v+HVByxM/zipDSZ6uRwl3jra2l51Dp+/il/WJE
   g==;
X-CSE-ConnectionGUID: 3eWv26RXRYSEEvju4wwZOg==
X-CSE-MsgGUID: aeflyMSJROCM80W5zSxOYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11570"; a="79421011"
X-IronPort-AV: E=Sophos;i="6.18,312,1751266800"; 
   d="scan'208";a="79421011"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2025 04:05:09 -0700
X-CSE-ConnectionGUID: i9v6UjnvTlaNGfRN152Bvg==
X-CSE-MsgGUID: E3Js46hiSCm2UFQLZkT89A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,312,1751266800"; 
   d="scan'208";a="178556099"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by orviesa010.jf.intel.com with ESMTP; 03 Oct 2025 04:05:07 -0700
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: lenb@kernel.org
Cc: linux-pm@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH] tools/power x86_energy_perf_policy: Add Android MSR device support
Date: Fri,  3 Oct 2025 16:33:19 +0530
Message-Id: <20251003110319.515085-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for Android MSR device paths which use /dev/msrN format
instead of the standard Linux /dev/cpu/N/msr format. The tool now
probes both path formats at startup and uses the appropriate one.

This enables x86_energy_perf_policy to work on Android systems where
MSR devices follow a different naming convention while maintaining
full compatibility with standard Linux systems.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
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
2.34.1


