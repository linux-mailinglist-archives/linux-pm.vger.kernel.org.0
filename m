Return-Path: <linux-pm+bounces-22132-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 332CFA36A3F
	for <lists+linux-pm@lfdr.de>; Sat, 15 Feb 2025 01:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DC3416E8A6
	for <lists+linux-pm@lfdr.de>; Sat, 15 Feb 2025 00:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1411C19CC27;
	Sat, 15 Feb 2025 00:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q6zj7yqm"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF28C74E09;
	Sat, 15 Feb 2025 00:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739580787; cv=none; b=hv4zRcRb/+MGpVRX4MMMxiA4UGDNSAa+0w1LLQIU4UmWZsvF9qlnHzSn91OIovZOHPGBNH9wCeiDKTht/hlXqeFNUz01QQzDuLpQbLzixJHu8arQqM/dHpLXh+plyyd5vja4W93zMsicWkyoFQoAu9IzCIItM1pME9IzBDhKF9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739580787; c=relaxed/simple;
	bh=/hvvswEZPts18ut4G6heXGgXmNoDuLWSh37II+hvcYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WZVsqJGIr3zgRhEXDe2h/uIH8Lg4O0GME4NA2Fr5Heozq9isOQU2tmwUeqqfTr2uBzMAjG8hf/1i9qvZH34DSJRSylCQ6spAUDJ1VaxU1te/BIQmss/zEkiF1ybAqTkUeSQssUKlDQfAE4vKiG1vhMsnhlSPSzLvh2UVvfGy5Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q6zj7yqm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA71C4CEE6;
	Sat, 15 Feb 2025 00:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739580786;
	bh=/hvvswEZPts18ut4G6heXGgXmNoDuLWSh37II+hvcYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q6zj7yqmfvN3gBuVMwVjYiMbdggyzoUQh+KJn9RuAkgvs4tCC6dhdG5p2LrJjq14V
	 Tq1lKg70PIgiUgi9oCE8WYr9K+EPTSd+xXLGHiyDG26afq81AngjxbEyjYX0mewsYF
	 vLM8LvqJFc/rpIHyco2b2X3LDsdSLM+Sd6kY13KHRhsuR+9YOCS8Nc+ID1t0VWEon3
	 QCMgs4kGJJfpPSH8+tKcP8y+8maT2tpEVeDT7bwZqIPgdEaGZzROsC6U/qLE8uWGgy
	 SBV7TA8P+m04KRiz8vc8l/mmfdmmiMaMJFmRaI/ECQ7sARvFnb+7qAjuri4NX6/8TS
	 TIbB8v4jyQ2ew==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>,
	Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Subject: [PATCH v2 11/17] cpufreq/amd-pstate: Replace all AMD_CPPC_* macros with masks
Date: Fri, 14 Feb 2025 18:52:38 -0600
Message-ID: <20250215005244.1212285-12-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250215005244.1212285-1-superm1@kernel.org>
References: <20250215005244.1212285-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

Bitfield masks are easier to follow and less error prone.

Reviewed-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2:
 * Add a comment in msr-index.h
 * Pick up tag
---
 arch/x86/include/asm/msr-index.h | 20 +++++++++++---------
 arch/x86/kernel/acpi/cppc.c      |  2 +-
 drivers/cpufreq/amd-pstate-ut.c  |  8 ++++----
 drivers/cpufreq/amd-pstate.c     | 16 ++++++----------
 4 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 3eadc4d5de837..4bb87884998a0 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -700,15 +700,17 @@
 #define MSR_AMD_CPPC_REQ		0xc00102b3
 #define MSR_AMD_CPPC_STATUS		0xc00102b4
 
-#define AMD_CPPC_LOWEST_PERF(x)		(((x) >> 0) & 0xff)
-#define AMD_CPPC_LOWNONLIN_PERF(x)	(((x) >> 8) & 0xff)
-#define AMD_CPPC_NOMINAL_PERF(x)	(((x) >> 16) & 0xff)
-#define AMD_CPPC_HIGHEST_PERF(x)	(((x) >> 24) & 0xff)
-
-#define AMD_CPPC_MAX_PERF(x)		(((x) & 0xff) << 0)
-#define AMD_CPPC_MIN_PERF(x)		(((x) & 0xff) << 8)
-#define AMD_CPPC_DES_PERF(x)		(((x) & 0xff) << 16)
-#define AMD_CPPC_ENERGY_PERF_PREF(x)	(((x) & 0xff) << 24)
+/* Masks for use with MSR_AMD_CPPC_CAP1 */
+#define AMD_CPPC_LOWEST_PERF_MASK	GENMASK(7, 0)
+#define AMD_CPPC_LOWNONLIN_PERF_MASK	GENMASK(15, 8)
+#define AMD_CPPC_NOMINAL_PERF_MASK	GENMASK(23, 16)
+#define AMD_CPPC_HIGHEST_PERF_MASK	GENMASK(31, 24)
+
+/* Masks for use with MSR_AMD_CPPC_REQ */
+#define AMD_CPPC_MAX_PERF_MASK		GENMASK(7, 0)
+#define AMD_CPPC_MIN_PERF_MASK		GENMASK(15, 8)
+#define AMD_CPPC_DES_PERF_MASK		GENMASK(23, 16)
+#define AMD_CPPC_EPP_PERF_MASK		GENMASK(31, 24)
 
 /* AMD Performance Counter Global Status and Control MSRs */
 #define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS	0xc0000300
diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
index f96053c305c61..77bfb846490c0 100644
--- a/arch/x86/kernel/acpi/cppc.c
+++ b/arch/x86/kernel/acpi/cppc.c
@@ -151,7 +151,7 @@ int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf)
 		if (ret)
 			goto out;
 
-		val = AMD_CPPC_HIGHEST_PERF(val);
+		val = FIELD_GET(AMD_CPPC_HIGHEST_PERF_MASK, val);
 	} else {
 		ret = cppc_get_highest_perf(cpu, &val);
 		if (ret)
diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
index 9db20ac357042..067e9e325102e 100644
--- a/drivers/cpufreq/amd-pstate-ut.c
+++ b/drivers/cpufreq/amd-pstate-ut.c
@@ -142,10 +142,10 @@ static int amd_pstate_ut_check_perf(u32 index)
 				return ret;
 			}
 
-			highest_perf = AMD_CPPC_HIGHEST_PERF(cap1);
-			nominal_perf = AMD_CPPC_NOMINAL_PERF(cap1);
-			lowest_nonlinear_perf = AMD_CPPC_LOWNONLIN_PERF(cap1);
-			lowest_perf = AMD_CPPC_LOWEST_PERF(cap1);
+			highest_perf = FIELD_GET(AMD_CPPC_HIGHEST_PERF_MASK, cap1);
+			nominal_perf = FIELD_GET(AMD_CPPC_NOMINAL_PERF_MASK, cap1);
+			lowest_nonlinear_perf = FIELD_GET(AMD_CPPC_LOWNONLIN_PERF_MASK, cap1);
+			lowest_perf = FIELD_GET(AMD_CPPC_LOWEST_PERF_MASK, cap1);
 		}
 
 		cur_perf = READ_ONCE(cpudata->perf);
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index e5983e5c77ba2..0a7e69fd32dbf 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -89,11 +89,6 @@ static bool cppc_enabled;
 static bool amd_pstate_prefcore = true;
 static struct quirk_entry *quirks;
 
-#define AMD_CPPC_MAX_PERF_MASK		GENMASK(7, 0)
-#define AMD_CPPC_MIN_PERF_MASK		GENMASK(15, 8)
-#define AMD_CPPC_DES_PERF_MASK		GENMASK(23, 16)
-#define AMD_CPPC_EPP_PERF_MASK		GENMASK(31, 24)
-
 /*
  * AMD Energy Preference Performance (EPP)
  * The EPP is used in the CCLK DPM controller to drive
@@ -439,12 +434,13 @@ static int msr_init_perf(struct amd_cpudata *cpudata)
 
 	perf.highest_perf = numerator;
 	perf.max_limit_perf = numerator;
-	perf.min_limit_perf = AMD_CPPC_LOWEST_PERF(cap1);
-	perf.nominal_perf = AMD_CPPC_NOMINAL_PERF(cap1);
-	perf.lowest_nonlinear_perf = AMD_CPPC_LOWNONLIN_PERF(cap1);
-	perf.lowest_perf = AMD_CPPC_LOWEST_PERF(cap1);
+	perf.min_limit_perf = FIELD_GET(AMD_CPPC_LOWEST_PERF_MASK, cap1);
+	perf.nominal_perf = FIELD_GET(AMD_CPPC_NOMINAL_PERF_MASK, cap1);
+	perf.lowest_nonlinear_perf = FIELD_GET(AMD_CPPC_LOWNONLIN_PERF_MASK, cap1);
+	perf.lowest_perf = FIELD_GET(AMD_CPPC_LOWEST_PERF_MASK, cap1);
 	WRITE_ONCE(cpudata->perf, perf);
-	WRITE_ONCE(cpudata->prefcore_ranking, AMD_CPPC_HIGHEST_PERF(cap1));
+	WRITE_ONCE(cpudata->prefcore_ranking, FIELD_GET(AMD_CPPC_HIGHEST_PERF_MASK, cap1));
+
 	return 0;
 }
 
-- 
2.43.0


