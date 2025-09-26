Return-Path: <linux-pm+bounces-35431-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE71BA2437
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 04:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A58241C28080
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 02:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6852652A4;
	Fri, 26 Sep 2025 02:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rd9j/DIG"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9970F264A60
	for <linux-pm@vger.kernel.org>; Fri, 26 Sep 2025 02:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758855268; cv=none; b=IMCOUm92pLtuyJ3lGvWrJvSkwmAWw0UIa8v11hoOE7jghzunYh7ki7FmTIuzi7Y2cP/1gzNEDZov76/vXVAfK8/dn+z70n/2A9Uo0Es01cw1wNuho3OlfNJipN82xoLAATrAz+2K6l0eR60P3zfLijCE4x6GAbUN/kTzSKcq4wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758855268; c=relaxed/simple;
	bh=eu+TOO2kwiAgUzUE5i0WxQgFqOkFOGRHbsZxUBzU4dA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uiMbd4Rjg4vKuYCNP64VS8qV8TUPrdtym5LkgGLXLrIbnHAPczO6yzgDURNtrVIQHC9JsvNEU6+vd7kcEd1bt9cxDOA9AZET6B7QyVy+OW5akL9r7beiQJYjVEpGbMiBSexYKz4KzaNWvD8YEGPGkG/l8T5R7syC4rSfKCShMf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rd9j/DIG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04B74C113D0
	for <linux-pm@vger.kernel.org>; Fri, 26 Sep 2025 02:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758855268;
	bh=eu+TOO2kwiAgUzUE5i0WxQgFqOkFOGRHbsZxUBzU4dA=;
	h=From:To:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=rd9j/DIGJVH/ljMRRREEeVe3jdixSOjEr8fGgzfoAFzGEyPq0LbRt96xmOOdqDrrU
	 vRods8DkwMAhp5p6+kiJCSSVqGeCJjYpuG/1gwFqn996nEGzth1VOI5Kyqdh4X/KU+
	 xXJRk3hJ6G1C9qESbaXEgiqdOrEdonn3LNBUN0mHG0kuH3R2AEWrzyJiqb6/5mZMMX
	 oNrH0gxMVRfUlt8DmWbt7l12XYhY5UGV4EGf9Uu9noRnNj9o6TqDUo8qlaSa9KAFly
	 iw++45Te1aChgAZJ7N810k/zJTdYmYiMhTyIMEVo9HHJGXqRhiYQ32GIF59cZUMN4F
	 EfZSMfoWbMWqA==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Subject: [PATCH 3/7] tools/power x86_energy_perf_policy: Prepare for MSR/sysfs refactoring
Date: Thu, 25 Sep 2025 22:51:05 -0400
Message-ID: <b0b7ef58299924158b3447c0f00229d068ab4467.1758855052.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <4902665808e17a711200c46558803f526cbb154a.1758855052.git.len.brown@intel.com>
References: <4902665808e17a711200c46558803f526cbb154a.1758855052.git.len.brown@intel.com>
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

Rename routines to make "_msr" and "_sysfs" access  methods clear

No functional change

Signed-off-by: Len Brown <len.brown@intel.com>
---
 .../x86_energy_perf_policy.c                  | 38 +++++++++----------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
index 534e2a70f8ae..47b4efa34a4c 100644
--- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
+++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
@@ -809,7 +809,7 @@ void print_hwp_request_pkg(int pkg, struct msr_hwp_request *h, char *str)
 		h->hwp_min, h->hwp_max, h->hwp_desired, h->hwp_epp,
 		h->hwp_window, h->hwp_window & 0x7F, (h->hwp_window >> 7) & 0x7);
 }
-void read_hwp_request(int cpu, struct msr_hwp_request *hwp_req, unsigned int msr_offset)
+void read_hwp_request_msr(int cpu, struct msr_hwp_request *hwp_req, unsigned int msr_offset)
 {
 	unsigned long long msr;
 
@@ -823,7 +823,7 @@ void read_hwp_request(int cpu, struct msr_hwp_request *hwp_req, unsigned int msr
 	hwp_req->hwp_use_pkg = (((msr) >> 42) & 0x1);
 }
 
-void write_hwp_request(int cpu, struct msr_hwp_request *hwp_req, unsigned int msr_offset)
+void write_hwp_request_msr(int cpu, struct msr_hwp_request *hwp_req, unsigned int msr_offset)
 {
 	unsigned long long msr = 0;
 
@@ -843,7 +843,7 @@ void write_hwp_request(int cpu, struct msr_hwp_request *hwp_req, unsigned int ms
 	put_msr(cpu, msr_offset, msr);
 }
 
-static int get_epb(int cpu)
+static int get_epb_sysfs(int cpu)
 {
 	char path[SYSFS_PATH_MAX];
 	char linebuf[3];
@@ -865,7 +865,7 @@ static int get_epb(int cpu)
 	return (int)val;
 }
 
-static int set_epb(int cpu, int val)
+static int set_epb_sysfs(int cpu, int val)
 {
 	char path[SYSFS_PATH_MAX];
 	char linebuf[3];
@@ -895,14 +895,14 @@ int print_cpu_msrs(int cpu)
 	struct msr_hwp_cap cap;
 	int epb;
 
-	epb = get_epb(cpu);
+	epb = get_epb_sysfs(cpu);
 	if (epb >= 0)
 		printf("cpu%d: EPB %u\n", cpu, (unsigned int) epb);
 
 	if (!has_hwp)
 		return 0;
 
-	read_hwp_request(cpu, &req, MSR_HWP_REQUEST);
+	read_hwp_request_msr(cpu, &req, MSR_HWP_REQUEST);
 	print_hwp_request(cpu, &req, "");
 
 	read_hwp_cap(cpu, &cap, MSR_HWP_CAPABILITIES);
@@ -919,7 +919,7 @@ int print_pkg_msrs(int pkg)
 	if (!has_hwp)
 		return 0;
 
-	read_hwp_request(first_cpu_in_pkg[pkg], &req, MSR_HWP_REQUEST_PKG);
+	read_hwp_request_msr(first_cpu_in_pkg[pkg], &req, MSR_HWP_REQUEST_PKG);
 	print_hwp_request_pkg(pkg, &req, "");
 
 	if (has_hwp_notify) {
@@ -1074,14 +1074,14 @@ int check_hwp_request_v_hwp_capabilities(int cpu, struct msr_hwp_request *req, s
 	return 0;
 }
 
-int update_hwp_request(int cpu)
+int update_hwp_request_msr(int cpu)
 {
 	struct msr_hwp_request req;
 	struct msr_hwp_cap cap;
 
 	int msr_offset = MSR_HWP_REQUEST;
 
-	read_hwp_request(cpu, &req, msr_offset);
+	read_hwp_request_msr(cpu, &req, msr_offset);
 	if (debug)
 		print_hwp_request(cpu, &req, "old: ");
 
@@ -1111,15 +1111,15 @@ int update_hwp_request(int cpu)
 
 	verify_hwp_req_self_consistency(cpu, &req);
 
-	write_hwp_request(cpu, &req, msr_offset);
+	write_hwp_request_msr(cpu, &req, msr_offset);
 
 	if (debug) {
-		read_hwp_request(cpu, &req, msr_offset);
+		read_hwp_request_msr(cpu, &req, msr_offset);
 		print_hwp_request(cpu, &req, "new: ");
 	}
 	return 0;
 }
-int update_hwp_request_pkg(int pkg)
+int update_hwp_request_pkg_msr(int pkg)
 {
 	struct msr_hwp_request req;
 	struct msr_hwp_cap cap;
@@ -1127,7 +1127,7 @@ int update_hwp_request_pkg(int pkg)
 
 	int msr_offset = MSR_HWP_REQUEST_PKG;
 
-	read_hwp_request(cpu, &req, msr_offset);
+	read_hwp_request_msr(cpu, &req, msr_offset);
 	if (debug)
 		print_hwp_request_pkg(pkg, &req, "old: ");
 
@@ -1155,10 +1155,10 @@ int update_hwp_request_pkg(int pkg)
 
 	verify_hwp_req_self_consistency(cpu, &req);
 
-	write_hwp_request(cpu, &req, msr_offset);
+	write_hwp_request_msr(cpu, &req, msr_offset);
 
 	if (debug) {
-		read_hwp_request(cpu, &req, msr_offset);
+		read_hwp_request_msr(cpu, &req, msr_offset);
 		print_hwp_request_pkg(pkg, &req, "new: ");
 	}
 	return 0;
@@ -1188,8 +1188,8 @@ int update_cpu_msrs(int cpu)
 	int epb;
 
 	if (update_epb) {
-		epb = get_epb(cpu);
-		set_epb(cpu, new_epb);
+		epb = get_epb_sysfs(cpu);
+		set_epb_sysfs(cpu, new_epb);
 
 		if (verbose)
 			printf("cpu%d: ENERGY_PERF_BIAS old: %d new: %d\n",
@@ -1229,7 +1229,7 @@ int update_cpu_msrs(int cpu)
 	if (!hwp_update_enabled())
 		return 0;
 
-	update_hwp_request(cpu);
+	update_hwp_request_msr(cpu);
 	return 0;
 }
 
@@ -1587,7 +1587,7 @@ int main(int argc, char **argv)
 		for_all_cpus_in_set(cpu_setsize, cpu_selected_set, update_sysfs);
 		for_all_cpus_in_set(cpu_setsize, cpu_selected_set, update_cpu_msrs);
 	} else if (pkg_selected_set)
-		for_packages(pkg_selected_set, update_hwp_request_pkg);
+		for_packages(pkg_selected_set, update_hwp_request_pkg_msr);
 
 	return 0;
 }
-- 
2.45.2


