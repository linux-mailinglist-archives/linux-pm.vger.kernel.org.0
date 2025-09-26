Return-Path: <linux-pm+bounces-35434-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF50ABA243D
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 04:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F512386F4D
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 02:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83DF266EEA;
	Fri, 26 Sep 2025 02:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/Muah3Y"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4664265621
	for <linux-pm@vger.kernel.org>; Fri, 26 Sep 2025 02:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758855269; cv=none; b=WWgFbEABikJkhNl3CLkT7PKdpJz1eIXuIyzgvYy5Y+7XuoyTMUSqE/DS/59KTHz0KdaxG2JOQXaKIDyM+0cqWVuQhi2lpbZwdLpfJSuRNjj15b+pQIxcwchYCAS392x3xkRPk/QbomUAA2cazwU4X5z4XJx2p0WqRkF45cnnLd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758855269; c=relaxed/simple;
	bh=fomFzH41n8L/dmbp9FfpGe6qotw3o+FsX9UHxv5cbis=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fR3+dSYzbpBGwbmFSAbxdyJq5xAqKv05YeRDb8MPAlUhpYHrq59cPJLz21LPs4AV0V0iAu/kJVR6DaI+bJcCvv5Ev29EZEGLNeZX21wVfNffERpMOQmh03ZmPBm/k+bLxIG5TOFZB7PdnifTs5kNmz1mjMElMpBYYqBGNIIsM6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/Muah3Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2E72C113D0
	for <linux-pm@vger.kernel.org>; Fri, 26 Sep 2025 02:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758855269;
	bh=fomFzH41n8L/dmbp9FfpGe6qotw3o+FsX9UHxv5cbis=;
	h=From:To:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=G/Muah3Y4jYmzU+04XWl5SUrxgaoY9ZQM+WVPzgr4Z4apJKNWvaNEkiMjq3YzYYv0
	 ByLZoE0clW+GG5aSHA6DJnucPRDrS/D4bTJ7S49/B7dMeuQgtwQs1G0EXynall2sfE
	 Srmlz64FlHKfEHZVJCz75U2bZ0iLmjW6u9W/x5JivCnQc+KeDdfYl2ojMGJChd/ToZ
	 Z9PG3Cz9YIgylX2GXMu/hmFURU4bQAQn7I6TfPqJiopPULFjCAMpbv9m0GbOywqgLo
	 03iipP8U5MeXnqtHlcc5ICNd51GEWpDebh/a0GZOBGLtdFMZLy1lrMfrg4EVBgHGYh
	 2DyJRFKZXf9+A==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Subject: [PATCH 5/7] tools/power x86_energy_perf_policy: Prefer driver HWP limits
Date: Thu, 25 Sep 2025 22:51:07 -0400
Message-ID: <908ec95eb51597b66814072889eaa75138c8792e.1758855052.git.len.brown@intel.com>
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

When we are successful in using cpufreq min/max limits,
skip setting the raw MSR limits entirely.

This is necessary to avoid undoing any modification that
the cpufreq driver makes to our sysfs request.

eg. intel_pstate may take our request for a limit
that is valid according to HWP.CAP.MIN/MAX and clip
it to be within the range available in PLATFORM_INFO.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 .../x86_energy_perf_policy/x86_energy_perf_policy.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
index 0267f5ecaa77..150cfed95288 100644
--- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
+++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
@@ -62,6 +62,7 @@ unsigned char turbo_update_value;
 unsigned char update_hwp_epp;
 unsigned char update_hwp_min;
 unsigned char update_hwp_max;
+unsigned char hwp_limits_done_via_sysfs;
 unsigned char update_hwp_desired;
 unsigned char update_hwp_window;
 unsigned char update_hwp_use_pkg;
@@ -951,8 +952,10 @@ int ratio_2_sysfs_khz(int ratio)
 }
 /*
  * If HWP is enabled and cpufreq sysfs attribtes are present,
- * then update sysfs, so that it will not become
- * stale when we write to MSRs.
+ * then update via sysfs. The intel_pstate driver may modify (clip)
+ * this request, say, when HWP_CAP is outside of PLATFORM_INFO limits,
+ * and the driver-chosen value takes precidence.
+ *
  * (intel_pstate's max_perf_pct and min_perf_pct will follow cpufreq,
  *  so we don't have to touch that.)
  */
@@ -1007,6 +1010,8 @@ int update_sysfs(int cpu)
 	if (update_hwp_max)
 		update_cpufreq_scaling_freq(1, cpu, req_update.hwp_max);
 
+	hwp_limits_done_via_sysfs = 1;
+
 	return 0;
 }
 
@@ -1085,10 +1090,10 @@ int update_hwp_request_msr(int cpu)
 	if (debug)
 		print_hwp_request(cpu, &req, "old: ");
 
-	if (update_hwp_min)
+	if (update_hwp_min && !hwp_limits_done_via_sysfs)
 		req.hwp_min = req_update.hwp_min;
 
-	if (update_hwp_max)
+	if (update_hwp_max && !hwp_limits_done_via_sysfs)
 		req.hwp_max = req_update.hwp_max;
 
 	if (update_hwp_desired)
-- 
2.45.2


