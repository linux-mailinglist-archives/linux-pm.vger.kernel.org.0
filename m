Return-Path: <linux-pm+bounces-39118-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B3AC9D0D7
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 22:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 18AD04E3412
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 21:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BEFF2FBDE1;
	Tue,  2 Dec 2025 21:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZOK9d7h"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD602F83AA
	for <linux-pm@vger.kernel.org>; Tue,  2 Dec 2025 21:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764710325; cv=none; b=aFliwNctRLpwL4lMunYcssZ2KtclhzwZNZu7Tqx2ZsY+RnOmB2aUjlpG1x7nhj3hLrIP5cWMgy1M2x17bs2C6CWbj44VxvH/t6sLQ0GIzoY0+DLVZl0E4R+jf8ewgZDcrJSWrLlE06UPdMzIVjIf6d9jo/nNE6beLrHa+gC4JSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764710325; c=relaxed/simple;
	bh=PwWHEU9SuLHQOEYeYGU85OPHZzENGcgqlMBD4Ynck5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R+VhMFNn5zqtyHHrb+PBLgyvohwe0KNBCzCoaHDuw8tqR00KugAsEEURE9D9eR7g6P8Tp60AwXfhpkkZ+ESm91NPZa8WNUrms+f+BJM6xpNXGNuBAFH/clko2qqsC1JREyCxeb/KmNWL98B6F1jzk/qSYcdI+YgHIs8uDpUvkKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZOK9d7h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D092C113D0;
	Tue,  2 Dec 2025 21:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764710324;
	bh=PwWHEU9SuLHQOEYeYGU85OPHZzENGcgqlMBD4Ynck5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=PZOK9d7huY1sNiyRY082fS2Dn2r2pufMBzi1BC+tX3pVESIufhzHOMt6GYdo+s+LF
	 +S910Bh7+ve/j6XgdMi3zhzblKIkQAHOZX1PYJDaKJOY3KzPzlnu41XvOtbJqXTNFc
	 wgPiNq0jJ2wqC6RIUna1ZSqyey+YwRZI2nJpQguGNukaWpT+eEKJttl4McitB64AFE
	 oAVsBdKH9eZ8WStceozBI4GR4fSXMaTb80Hp8gwqcM9c5tHHhM7weRA6ppjf8hgfpf
	 /SrSPArW5lgjyxOkQkqCd35dbKPcc+zvVjFbmy63JDK3pISwmTrgOKPyLVTuqSW+mg
	 7xYcOONJgcEiA==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 12/21] tools/power x86_energy_perf_policy: Simplify Android MSR probe
Date: Tue,  2 Dec 2025 16:13:30 -0500
Message-ID: <90a2fe257679ee931a99e7555a5844e05ed3945c.1764710012.git.len.brown@intel.com>
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

no functional change

Signed-off-by: Len Brown <len.brown@intel.com>
---
 .../x86_energy_perf_policy.c                  | 38 ++++++-------------
 1 file changed, 11 insertions(+), 27 deletions(-)

diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
index 5301efc741ce..e68eaa9f7cd4 100644
--- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
+++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
@@ -95,7 +95,6 @@ unsigned int bdx_highest_ratio;
 #define PATH_TO_CPU "/sys/devices/system/cpu/"
 #define SYSFS_PATH_MAX 255
 
-/* keep Default as a linux path */
 static int use_android_msr_path;
 
 /*
@@ -681,29 +680,6 @@ void err_on_hypervisor(void)
 		    "not supported on this virtual machine");
 }
 
-static void probe_msr_path_format(void)
-{
-	struct stat sb;
-	char test_path[32];
-
-	/* Test standard Linux path */
-	sprintf(test_path, "/dev/cpu/%d/msr", base_cpu);
-	if (stat(test_path, &sb) == 0) {
-		use_android_msr_path = 0;
-		return;
-	}
-
-	/* Test Android-style path */
-	sprintf(test_path, "/dev/msr%d", base_cpu);
-	if (stat(test_path, &sb) == 0) {
-		use_android_msr_path = 1;
-		return;
-	}
-
-	/* If neither exists, keep the default Linux format */
-	use_android_msr_path = 0;
-}
-
 int get_msr(int cpu, int offset, unsigned long long *msr)
 {
 	int retval;
@@ -1450,12 +1426,23 @@ void set_base_cpu(void)
 		err(-ENODEV, "No valid cpus found");
 }
 
+static void probe_android_msr_path(void)
+{
+	struct stat sb;
+	char test_path[32];
+
+	sprintf(test_path, "/dev/msr%d", base_cpu);
+	if (stat(test_path, &sb) == 0)
+		use_android_msr_path = 1;
+}
 
 void probe_dev_msr(void)
 {
 	struct stat sb;
 	char pathname[32];
 
+	probe_android_msr_path();
+
 	sprintf(pathname, use_android_msr_path ? "/dev/msr%d" : "/dev/cpu/%d/msr", base_cpu);
 	if (stat(pathname, &sb)) {
 		if (system("/sbin/modprobe msr > /dev/null 2>&1")) {
@@ -1582,9 +1569,6 @@ int main(int argc, char **argv)
 {
 	set_base_cpu();
 
-	/* probe MSR path */
-	probe_msr_path_format();
-
 	probe_dev_msr();
 	init_data_structures();
 
-- 
2.45.2


