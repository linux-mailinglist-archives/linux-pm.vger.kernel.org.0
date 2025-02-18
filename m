Return-Path: <linux-pm+bounces-22334-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8EFA3A713
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 20:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94FA23AB02E
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 19:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1D41E834D;
	Tue, 18 Feb 2025 19:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gmU0Fz5t"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908021E8348;
	Tue, 18 Feb 2025 19:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739905753; cv=none; b=MBFXBd3PJS43UmNXLo3IbYmUT/p3StTfXGDgdBoATW/MtwzOpC0epfJgKGbmdzlQ1HpeX8Mw6pMJIBRuyLnnAq0FuS0OQ7P4t0hYYV5nEXqGTH6hJJotreG1+WFEeK3951n1jek2yNbOTtFx8dMi+FXUKgCHE7U0k3P8PC0JCdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739905753; c=relaxed/simple;
	bh=YGEAUNoTxiERCe+Zc0PbxN3oROVjMDUCDEuhQhPA2Wg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LP6k5tRUHJD27BGhzzdjv84En9tioW+3j4px64E9DCsjL+8GOVZaY13cpFU8sLGvc3Zx+sl4RZHjahTteDcnBHWZGRCn+WHHug/W7O/eOimeMMZlhqOPTAd7ADbgJTk0A+91mPLyBFykYSzdXtlfwUwIRB5GwhLiIDwLIjg840Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gmU0Fz5t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51B67C4AF0B;
	Tue, 18 Feb 2025 19:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739905753;
	bh=YGEAUNoTxiERCe+Zc0PbxN3oROVjMDUCDEuhQhPA2Wg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gmU0Fz5tJAaUm6z+U40ArTbs2+jxyzM3QuDxgNSpak9bqS+kNKjO+j7J7IaT1BCvB
	 uVQVR9HQmncLS45cO0QMOTHgMc42JBeRyERVS2fX5c3EoKd6VyLga4AjLBUWkGmgLM
	 sP7MPUPJqdhPevq4pzQZgYZiQ2LrMTtX1ASJFLXYwmWOPEtBknTWZ9EacNgDhhZITc
	 nPNyuzEP2qKW48J2p+wFw1W2fmu8tQhhhqKDm1SPTSmxFAuU7/aX5ohVV8rbnk71tX
	 LEQCAC/rXke7aWAzeSH3vLFgz5N+xFnqOxxK75lGDsCRKXilnIWofXid0aye/sOehs
	 N4AjBcCJUVkJA==
From: Mario Limonciello <superm1@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	"H . Peter Anvin" <hpa@zytor.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Huang Rui <ray.huang@amd.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	platform-driver-x86@vger.kernel.org (open list:AMD HETERO CORE HARDWARE FEEDBACK DRIVER),
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-pm@vger.kernel.org (open list:AMD PSTATE DRIVER)
Subject: [PATCH v8 11/13] platform/x86/amd: hfi: Set ITMT priority from ranking data
Date: Tue, 18 Feb 2025 13:08:20 -0600
Message-ID: <20250218190822.1039982-12-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250218190822.1039982-1-superm1@kernel.org>
References: <20250218190822.1039982-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

The static ranking data that is read at module load should be used
to set up the priorities for the cores relative to the performance
values.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/amd/hfi/Kconfig |  1 +
 drivers/platform/x86/amd/hfi/hfi.c   | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/platform/x86/amd/hfi/Kconfig b/drivers/platform/x86/amd/hfi/Kconfig
index 532939eb08a6a..045f598f4866c 100644
--- a/drivers/platform/x86/amd/hfi/Kconfig
+++ b/drivers/platform/x86/amd/hfi/Kconfig
@@ -7,6 +7,7 @@ config AMD_HFI
 	bool "AMD Hetero Core Hardware Feedback Driver"
 	depends on ACPI
 	depends on CPU_SUP_AMD
+	depends on SCHED_MC_PRIO
 	help
 	 Select this option to enable the AMD Heterogeneous Core Hardware
 	 Feedback Interface. If selected, hardware provides runtime thread
diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
index ad93c3b5d5ddf..14378a0e09e21 100644
--- a/drivers/platform/x86/amd/hfi/hfi.c
+++ b/drivers/platform/x86/amd/hfi/hfi.c
@@ -115,6 +115,12 @@ static DEFINE_PER_CPU(struct amd_hfi_cpuinfo, amd_hfi_cpuinfo) = {.class_index =
 
 static DEFINE_MUTEX(hfi_cpuinfo_lock);
 
+static void amd_hfi_sched_itmt_work(struct work_struct *work)
+{
+	sched_set_itmt_support();
+}
+static DECLARE_WORK(sched_amd_hfi_itmt_work, amd_hfi_sched_itmt_work);
+
 static int find_cpu_index_by_apicid(unsigned int target_apicid)
 {
 	int cpu_index;
@@ -235,6 +241,8 @@ static int amd_set_hfi_ipcc_score(struct amd_hfi_cpuinfo *hfi_cpuinfo, int cpu)
 		WRITE_ONCE(hfi_cpuinfo->ipcc_scores[i],
 			   hfi_cpuinfo->amd_hfi_classes[i].perf);
 
+	sched_set_itmt_core_prio(hfi_cpuinfo->ipcc_scores[0], cpu);
+
 	return 0;
 }
 
@@ -458,6 +466,8 @@ static int amd_hfi_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
+	schedule_work(&sched_amd_hfi_itmt_work);
+
 	return 0;
 }
 
-- 
2.43.0


