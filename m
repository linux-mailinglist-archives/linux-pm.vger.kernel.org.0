Return-Path: <linux-pm+bounces-39122-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A1058C9D0E3
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 22:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B1DD34E4C6B
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 21:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA952FBE10;
	Tue,  2 Dec 2025 21:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jD9Zz8JX"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B3F2F7AD3
	for <linux-pm@vger.kernel.org>; Tue,  2 Dec 2025 21:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764710330; cv=none; b=lp4IxXpGFIgSInMW1uOPTHHPmODPvmPIyW6PBlXbdRPQFadbRYzxpuLWk6wOnHcMgVvPhEqKQ4gXtr/fzoejgQFD0petrjAj9mcAA+vTlxZ1VGAm/XzGHAGj921a0DPOqW5OgVhNcX/tSowkTKQFvRPCorjRWvowdEOOCsLbxZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764710330; c=relaxed/simple;
	bh=/ZI+roWvLZwH1c3pB/k9kTQZXX8Gv+V2DN7BALMCv4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qR7jiLRNXm/pyflVuIG/DpgwP76DGxbGSkjbmBObw+eh/0rnJ200g0e0doezGdmP1c5j10qlAv02GbmTgc2CBcqOhgV6u0nO4lDLY5Nci1UY3AqtWF8fUKi+GiRCFD/YfjIm3k932vsCT8c8W89Z46TlIPr5FNMCwQbJfu9+pGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jD9Zz8JX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 470A8C4CEF1;
	Tue,  2 Dec 2025 21:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764710330;
	bh=/ZI+roWvLZwH1c3pB/k9kTQZXX8Gv+V2DN7BALMCv4E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=jD9Zz8JXXY9ob3OXJ7bZDgyxK+ivV70dCQVbZH3MDTVqoJIJdxgDUH67XabRBJEEm
	 HuvWgpNVx2RP4McepUMZdjYIC/HaZTjuH5P3brWw1WXKYATNXFWnJgihN3YcuUi0jN
	 l3IsTOXsG/t1b50/qOnNSaGDv4uH0FCVFCIxLgufEix3zd+mj/Tux0+6xWw0LN3JNa
	 OX3TizCId42YcDUuTf9pqfqj3Lc7Cyu6JWkkxJOIFHRBputIUexw/sNSUyUQinTHog
	 7WjgrrvJiUKlXe9aNlNGUR9GRbxH4KuLh0V8xVlALINk57VfL68laM2MFEcu+HUAYX
	 x2Bw4hyn3EMqA==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 16/21] tools/power turbostat: Enhance perf probe
Date: Tue,  2 Dec 2025 16:13:34 -0500
Message-ID: <68769a0b5ada367d6911a8dfe50fc1e480c89fd1.1764710012.git.len.brown@intel.com>
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

check_perf_access() will now check both IPC and LLC perf counters
if they are enabled.  If any fail, it now disables perf
and all perf counters.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 54 ++++++++++++++++++++++-----
 1 file changed, 44 insertions(+), 10 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 4411ef44294f..ab28ac6e74b6 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2438,6 +2438,13 @@ static void bic_disable_msr_access(void)
 	free_sys_msr_counters();
 }
 
+static void bic_disable_perf_access(void)
+{
+	CLR_BIC(BIC_IPC, &bic_enabled);
+	CLR_BIC(BIC_LLC_RPS, &bic_enabled);
+	CLR_BIC(BIC_LLC_HIT, &bic_enabled);
+}
+
 static long perf_event_open(struct perf_event_attr *hw_event, pid_t pid, int cpu, int group_fd, unsigned long flags)
 {
 	assert(!no_perf);
@@ -8327,26 +8334,23 @@ void print_dev_latency(void)
 	close(fd);
 }
 
-static int has_instr_count_access(void)
+static int has_perf_instr_count_access(void)
 {
 	int fd;
-	int has_access;
 
 	if (no_perf)
 		return 0;
 
 	fd = open_perf_counter(base_cpu, PERF_TYPE_HARDWARE, PERF_COUNT_HW_INSTRUCTIONS, -1, 0);
-	has_access = fd != -1;
-
 	if (fd != -1)
 		close(fd);
 
-	if (!has_access)
+	if (fd == -1)
 		warnx("Failed to access %s. Some of the counters may not be available\n"
-		      "\tRun as root to enable them or use %s to disable the access explicitly",
-		      "instructions retired perf counter", "--no-perf");
+		      "\tRun as root to enable them or use %s to disable the access explicitly", "perf instructions retired counter",
+		      "'--hide IPC' or '--no-perf'");
 
-	return has_access;
+	return (fd != -1);
 }
 
 int add_rapl_perf_counter(int cpu, struct rapl_counter_info_t *rci, const struct rapl_counter_arch_info *cai,
@@ -9080,6 +9084,28 @@ void probe_pm_features(void)
 		decode_misc_feature_control();
 }
 
+/* perf_llc_probe
+ *
+ * return 1 on success, else 0
+ */
+int has_perf_llc_access(void)
+{
+	int fd;
+
+	if (no_perf)
+		return 0;
+
+	fd = open_perf_counter(base_cpu, PERF_TYPE_HARDWARE, PERF_COUNT_HW_CACHE_REFERENCES, -1, PERF_FORMAT_GROUP);
+	if (fd != -1)
+		close(fd);
+
+	if (fd == -1)
+		warnx("Failed to access %s. Some of the counters may not be available\n"
+		      "\tRun as root to enable them or use %s to disable the access explicitly", "perf LLC counters", "'--hide LLC' or '--no-perf'");
+
+	return (fd != -1);
+}
+
 void perf_llc_init(void)
 {
 	int cpu;
@@ -9535,8 +9561,16 @@ void check_msr_access(void)
 
 void check_perf_access(void)
 {
-	if (no_perf || !BIC_IS_ENABLED(BIC_IPC) || !has_instr_count_access())
-		CLR_BIC(BIC_IPC, &bic_enabled);
+	if (BIC_IS_ENABLED(BIC_IPC))
+		if (!has_perf_instr_count_access())
+			no_perf = 1;
+
+	if (BIC_IS_ENABLED(BIC_LLC_RPS) || BIC_IS_ENABLED(BIC_LLC_HIT))
+		if (!has_perf_llc_access())
+			no_perf = 1;
+
+	if (no_perf)
+		bic_disable_perf_access();
 }
 
 bool perf_has_hybrid_devices(void)
-- 
2.45.2


