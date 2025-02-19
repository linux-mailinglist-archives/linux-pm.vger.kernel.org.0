Return-Path: <linux-pm+bounces-22503-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86AB7A3CADD
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 22:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91126189AFE1
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 21:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826EF2586D8;
	Wed, 19 Feb 2025 21:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hi4Dz6L9"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5C82586CE;
	Wed, 19 Feb 2025 21:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739999008; cv=none; b=sk+tJ/uVdUgOknoyu1I006t77WnaLE28/o/8qGdEnHu8ocir1NpvCDCMnSgX2zgGuhUfv0QpTEJAOL9MDqXyY4OG2fCH6zGzoJohal/zwgMeRB5GBmhtDxi3CnYp3Qc2BOs6O2X7aqQMdKLeyHCegByY9kndLe/r8Gt61k7wArY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739999008; c=relaxed/simple;
	bh=5dGQm0kFicDM1YQWe+KXcWsodAbUPKyxRXa/xmrMJ08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tDy4ryWj62tJGD6rT158Hf1FHRBzQO0s0mlAHPLH8WoyqTJTGdBooX5bD0HA7pl5E9UyXRMgx1JmFgfM1VJ+0a7gpg+7k+CaUVyVZomMOQfcCNysaEQae4f1oyJuPJIFJAVeexnEgqx3JIdFDIMOC4xeKVyL00vvzbkQ/Je7hNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hi4Dz6L9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EC1CC4CED1;
	Wed, 19 Feb 2025 21:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739999008;
	bh=5dGQm0kFicDM1YQWe+KXcWsodAbUPKyxRXa/xmrMJ08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hi4Dz6L9vXEhT1fmCpWs33qH6Y2oEh6+qBV4biJDZbPh8DZlelh7+bJL2CxWzMoFF
	 dMxnIsQy3YUSxL7kpt6sHy+he2EkyEgd5dirtWsO7PqCe2Zqg1AXrq7goyIinDoDyY
	 KaGWJOrnxJr/Kfa8xq+rz6HpJf303W0IY5jqMrj7SS0DC3+g3ApoUXRkc2hn1IQ41F
	 KNWPx2gT3UxEKU3pqnYuIaLBugJTpMIv5ZWcnW92fvy+xKSTf6V6nQRSVhzrodfaky
	 0IJaOVK9xmIehx29CFkuJu4TCwUW04gVjPCDeY/gcbEGnCpl31ECpw0WUKEwtDxrqo
	 cjlBK0OonWhRw==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>,
	Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Subject: [PATCH v4 12/19] cpufreq/amd-pstate: Replace all AMD_CPPC_* macros with masks
Date: Wed, 19 Feb 2025 15:02:55 -0600
Message-ID: <20250219210302.442954-13-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250219210302.442954-1-superm1@kernel.org>
References: <20250219210302.442954-1-superm1@kernel.org>
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
index 6b04b5b54b3b5..9a2de25a4b749 100644
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
index e61a430183693..cd4048908acf8 100644
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


