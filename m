Return-Path: <linux-pm+bounces-35432-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6423BA243A
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 04:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61FB0387D6F
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 02:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110AE265CA8;
	Fri, 26 Sep 2025 02:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="beoHAghe"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1845265621
	for <linux-pm@vger.kernel.org>; Fri, 26 Sep 2025 02:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758855269; cv=none; b=uFeo5SPAt5jHnxFAzEo0sPnyOUjzpCWEvVGSHBYHZ2Agw8MjSvm9FvVqt0YRVWzj995tyxNQ4h5bhlnw9AfS1+APwQG24to+Hfq0cB2WdqbA+a7KsmvFByzGIw6yFub5w/7BifERjRhB7UCrWVNKcRbm3B46kTJglWg4wcWUrOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758855269; c=relaxed/simple;
	bh=6XRM4a1BM120fO1dyTTuPC/zTYLFaYkjvj2gh10I0zc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=am7R1T9G/w9u7RysQgTEYW5EByjcTxOK9/CkjDk594K4GZiGIuUDfn2dsVkVb/hqydfO/j+RikbIa8ZlLPvdaUKSkvtQtt2lkO0dx9teIMYgg4XuLxOnM1dBRqGkJD1bC2jUQhJjGmkRUiZFKMdFHCid07jcmzqyT6NU50RvKyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=beoHAghe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C260C4CEF0
	for <linux-pm@vger.kernel.org>; Fri, 26 Sep 2025 02:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758855268;
	bh=6XRM4a1BM120fO1dyTTuPC/zTYLFaYkjvj2gh10I0zc=;
	h=From:To:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=beoHAgheS5Ks9SbYO1eYvBd1GmDG/utsTUyjgGJDGhV8Xs1E/HeN9y6x28SEzZJcZ
	 6iTCGoFrd933nG7TAitpGU7VWmiQ9VuJQJAL5JfQOZdjkkKy6X/hnk6IQb7TfY62oQ
	 EqT/0VgQyHYmwqeQLNCMWiiweRQbFdggcns0madm5l7BEdKDs2nWy0i7dD0rL0BN3h
	 EG/S566YpGQRJ0Y27DPMBQ+LhrB+q7R9I3cNpyMe/97TJAFfG7OPbv30qAPm/XJzty
	 GqX8/3SWmpKiX3YMFPywChdHa2hPUTx99K9ELvPmMpVr4JMWD1EmP413SFr4JWu/zD
	 +oZaWN9wvOY+w==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Subject: [PATCH 4/7] tools/power x86_energy_perf_policy: EPB access is only via sysfs
Date: Thu, 25 Sep 2025 22:51:06 -0400
Message-ID: <031fe4622f5d4fae908c74e6362068d98721ace5.1758855052.git.len.brown@intel.com>
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

Comprehend that EPB writes are now only via sysfs
by moving it out of the _msr specific path.

No functional change.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 .../x86_energy_perf_policy.c                  | 25 ++++++++++++-------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
index 47b4efa34a4c..0267f5ecaa77 100644
--- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
+++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
@@ -1182,19 +1182,23 @@ int enable_hwp_on_cpu(int cpu)
 	return 0;
 }
 
-int update_cpu_msrs(int cpu)
+int update_cpu_epb_sysfs(int cpu)
 {
-	unsigned long long msr;
 	int epb;
 
-	if (update_epb) {
-		epb = get_epb_sysfs(cpu);
-		set_epb_sysfs(cpu, new_epb);
+	epb = get_epb_sysfs(cpu);
+	set_epb_sysfs(cpu, new_epb);
 
-		if (verbose)
-			printf("cpu%d: ENERGY_PERF_BIAS old: %d new: %d\n",
-				cpu, epb, (unsigned int) new_epb);
-	}
+	if (verbose)
+		printf("cpu%d: ENERGY_PERF_BIAS old: %d new: %d\n",
+			cpu, epb, (unsigned int) new_epb);
+
+	return 0;
+}
+
+int update_cpu_msrs(int cpu)
+{
+	unsigned long long msr;
 
 	if (update_turbo) {
 		int turbo_is_present_and_disabled;
@@ -1584,8 +1588,11 @@ int main(int argc, char **argv)
 
 	/* update CPU set */
 	if (cpu_selected_set) {
+		if (update_epb)
+			for_all_cpus_in_set(cpu_setsize, cpu_selected_set, update_cpu_epb_sysfs);
 		for_all_cpus_in_set(cpu_setsize, cpu_selected_set, update_sysfs);
 		for_all_cpus_in_set(cpu_setsize, cpu_selected_set, update_cpu_msrs);
+
 	} else if (pkg_selected_set)
 		for_packages(pkg_selected_set, update_hwp_request_pkg_msr);
 
-- 
2.45.2


