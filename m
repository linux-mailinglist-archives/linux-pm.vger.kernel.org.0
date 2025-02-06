Return-Path: <linux-pm+bounces-21511-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3619DA2B481
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 22:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 421C6162892
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 21:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE13259499;
	Thu,  6 Feb 2025 21:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fLnH7lEK"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B32259483;
	Thu,  6 Feb 2025 21:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738879044; cv=none; b=eSmYmqBHgbuazo0ktDI1Zdlzg9Bjd/V/QqctStGtk6C8HTEjYXwP5qjcQLsfhYdDaDsNDeVAq/97KXOH+nGiIKK8g5b40MyGW8ly5kFjq0a9USLTGmrylMRohYFTewHe/Wu+iVaomevqMmC4i8mEMeKvQzcwY+emZItzTXhie0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738879044; c=relaxed/simple;
	bh=SctYPNo35jzvmJTpkstLkgXOB6nJ920jf0cSOSsTqiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WlyObEt0MadQYiTHnKWSBy1NUlNIv7w14OfzOSW+7wozTZxWyDDNVzs/Ou3so6n/nu3FJvlqLUiXqrTVKzKDJEj3KxgvSYpi5ikjZeDZpT8MgFIFwFqJvdz3s59xMW4t9anR5QxVzZlamhp177BJN1P2mXaYv2C6hIYrA2rkxk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fLnH7lEK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F45BC4CEE0;
	Thu,  6 Feb 2025 21:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738879043;
	bh=SctYPNo35jzvmJTpkstLkgXOB6nJ920jf0cSOSsTqiU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fLnH7lEK0yDkxRUvlv+fqs+zdZXyvxOa/EexqETNgQR57LroKPU61FXlzAMOALkTo
	 10L9InuZX5GsSFVdaqNKLFH0k6wdDmFgwHP2YBrxlDt0UXz3eZUjp3+X+bWn05ind1
	 azmflJ+rWjiRn7REYFOzrBE8MqmJ9p4UpdqyYD7FfVU+nDUZKaaZv/38AMPNAgOsZv
	 SdMPCgmWo6Cip5P0hlM5zfAVWSvWaNmzBc11+TRhHdp7IuBrj8mOfuxj4+euhy1HOB
	 WCtjVrIw/tdnrtHqXfDryvOeFe4T4EAqq6Z6G1IAhkvmF+3r9JcaVn3pqA1/WnyDK6
	 HIwILi9UITvCQ==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 07/14] cpufreq/amd-pstate: Replace all AMD_CPPC_* macros with masks
Date: Thu,  6 Feb 2025 15:56:52 -0600
Message-ID: <20250206215659.3350066-8-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250206215659.3350066-1-superm1@kernel.org>
References: <20250206215659.3350066-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

Bitfield masks are easier to follow and less error prone.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 arch/x86/include/asm/msr-index.h | 18 +++++++++---------
 arch/x86/kernel/acpi/cppc.c      |  2 +-
 drivers/cpufreq/amd-pstate-ut.c  |  8 ++++----
 drivers/cpufreq/amd-pstate.c     | 16 ++++++----------
 4 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 3eadc4d5de837..f77335ebae981 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -700,15 +700,15 @@
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
+#define AMD_CPPC_LOWEST_PERF_MASK	GENMASK(7, 0)
+#define AMD_CPPC_LOWNONLIN_PERF_MASK	GENMASK(15, 8)
+#define AMD_CPPC_NOMINAL_PERF_MASK	GENMASK(23, 16)
+#define AMD_CPPC_HIGHEST_PERF_MASK	GENMASK(31, 24)
+
+#define AMD_CPPC_MAX_PERF_MASK		GENMASK(7, 0)
+#define AMD_CPPC_MIN_PERF_MASK		GENMASK(15, 8)
+#define AMD_CPPC_DES_PERF_MASK		GENMASK(23, 16)
+#define AMD_CPPC_EPP_PERF_MASK		GENMASK(31, 24)
 
 /* AMD Performance Counter Global Status and Control MSRs */
 #define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS	0xc0000300
diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
index d745dd586303c..d68a4cb0168fa 100644
--- a/arch/x86/kernel/acpi/cppc.c
+++ b/arch/x86/kernel/acpi/cppc.c
@@ -149,7 +149,7 @@ int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf)
 		if (ret)
 			goto out;
 
-		val = AMD_CPPC_HIGHEST_PERF(val);
+		val = FIELD_GET(AMD_CPPC_HIGHEST_PERF_MASK, val);
 	} else {
 		ret = cppc_get_highest_perf(cpu, &val);
 		if (ret)
diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
index adaa62fb2b04e..2595faa492bf1 100644
--- a/drivers/cpufreq/amd-pstate-ut.c
+++ b/drivers/cpufreq/amd-pstate-ut.c
@@ -158,10 +158,10 @@ static void amd_pstate_ut_check_perf(u32 index)
 				return;
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
 
 		if (highest_perf != READ_ONCE(cpudata->perf.highest_perf) &&
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 71636bd9884c8..cd96443fc117f 100644
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
@@ -445,12 +440,13 @@ static int msr_init_perf(struct amd_cpudata *cpudata)
 
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


