Return-Path: <linux-pm+bounces-22965-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD831A4571D
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 08:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 001473ABC20
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 07:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588C327FE85;
	Wed, 26 Feb 2025 07:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNMcut6w"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E90B27FE7F;
	Wed, 26 Feb 2025 07:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740556199; cv=none; b=GPAAGqEeJyTt58+ziW1uco+UNgx5mlkG/d3ML2M4tFWcLj0o882lsAMaR2MX2oIZs7M6pITaTDxqjRnm4UjVlKQb4baqH2pvQcZyNRW8i/d6Hd8sWjgWgrR1+ky3nLSSLqpU0snkyafGiqkfquIzIJqev/7Hc/52tGkYXXBjrRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740556199; c=relaxed/simple;
	bh=zUQLVSiK6mFv12RaGNpEy8Bq9plyBiFjeVEZJAYlASc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M6bOYGso/+9I1nIOOW4+s1RcQXhmB2vY4CGvO+fuV7TMgpexJ9WWkB0T3Mfyg5osuz6bUqYcM9e/+LpTA6jc5msfNLYMj4lYI/1M/n7CHx4TqcpclEN1RKEKOK4OR6SlSio7/jyv2VSk5qiMxJU6t07JGZWyXrZlOzi6r2KS07M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nNMcut6w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97A27C4CEE2;
	Wed, 26 Feb 2025 07:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740556198;
	bh=zUQLVSiK6mFv12RaGNpEy8Bq9plyBiFjeVEZJAYlASc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nNMcut6wFXBPTzxS+50jjqwMd6cS3pEWGPQXXfrokTr1DA8zE3tlVdf6JfHczmaqE
	 P9iGuWzj3N4nJGf/UiQabySVuFNq6TmbTisKdNTkvOhCkqTaWca/t/+IVLCk8Y2Mla
	 qnWd6FffSIiXN8Fvd2zLzcDdjvzNUi/b6/b5EaOf7X6S5bapqywb7le7Q4I9Pud+fp
	 eCZySv0gsppuHDIDYdnq4lqf6hYy1E24RRc7U/zIBWw29nMKG3awJe/KwqliVKvO4I
	 XScqtqK+cWhq5grmZcYkrUW0/OCZk5HmZZ40FLsO1T4csMmjvOPgoTMao4Piy/D5Sw
	 ReCy4qZH4/Nzw==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>,
	Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Subject: [PATCH v5 12/19] cpufreq/amd-pstate: Replace all AMD_CPPC_* macros with masks
Date: Wed, 26 Feb 2025 01:49:27 -0600
Message-ID: <20250226074934.1667721-13-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250226074934.1667721-1-superm1@kernel.org>
References: <20250226074934.1667721-1-superm1@kernel.org>
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
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v3:
 * Add tag
 * Add missing includes
v2:
 * Add a comment in msr-index.h
 * Pick up tag
---
 arch/x86/include/asm/msr-index.h | 20 +++++++++++---------
 arch/x86/kernel/acpi/cppc.c      |  4 +++-
 drivers/cpufreq/amd-pstate-ut.c  |  9 +++++----
 drivers/cpufreq/amd-pstate.c     | 16 ++++++----------
 4 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index c84930610c7e6..cfcc49e5cf925 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -701,15 +701,17 @@
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
index d745dd586303c..77bfb846490c0 100644
--- a/arch/x86/kernel/acpi/cppc.c
+++ b/arch/x86/kernel/acpi/cppc.c
@@ -4,6 +4,8 @@
  * Copyright (c) 2016, Intel Corporation.
  */
 
+#include <linux/bitfield.h>
+
 #include <acpi/cppc_acpi.h>
 #include <asm/msr.h>
 #include <asm/processor.h>
@@ -149,7 +151,7 @@ int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf)
 		if (ret)
 			goto out;
 
-		val = AMD_CPPC_HIGHEST_PERF(val);
+		val = FIELD_GET(AMD_CPPC_HIGHEST_PERF_MASK, val);
 	} else {
 		ret = cppc_get_highest_perf(cpu, &val);
 		if (ret)
diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
index edc1475989e3d..e671bc7d15508 100644
--- a/drivers/cpufreq/amd-pstate-ut.c
+++ b/drivers/cpufreq/amd-pstate-ut.c
@@ -22,6 +22,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/bitfield.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
@@ -142,10 +143,10 @@ static int amd_pstate_ut_check_perf(u32 index)
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
index 2cec8d7d92f51..c2260bbee4eb7 100644
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


