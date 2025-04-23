Return-Path: <linux-pm+bounces-25994-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 900C0A97C6A
	for <lists+linux-pm@lfdr.de>; Wed, 23 Apr 2025 03:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 785C47ACF0F
	for <lists+linux-pm@lfdr.de>; Wed, 23 Apr 2025 01:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB9C267709;
	Wed, 23 Apr 2025 01:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MxkllRVI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0283A2676F4;
	Wed, 23 Apr 2025 01:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745372840; cv=none; b=KGKYhpNKp3T0Gd+ThoXMVA3otafq0STBlSwB3oAFVox8/xTipUv8bZR9pS47KmNpFQg6XdSPOHDpgUR8v8gMXNKXCyZZVGHKui6ifUWc9rO1K/q3qF8nqj1Vd9akxDTeUz11lPLS1L9nvHugMiN40V1lFBGzJauod1Z9h8khZAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745372840; c=relaxed/simple;
	bh=oHtRIsAptTXF54+4BJ34mKmBZlrungbNMyhnHWfvkmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f1fVgoab5fFnxGacph8B088XALRknki/ZAikf55CeMq1UxYJutRh6lEeF29LNsooPgh7+m+xWv5+hweuCv9M0Sy53yC7IvH4E4KsMuoAv99MPJjyJjapuD6asa3Wdyq/hIm8IbXiadcTLu4mQAXkO2+JyAfFgVOKBVVJQf/kZeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MxkllRVI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21F88C4CEEF;
	Wed, 23 Apr 2025 01:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745372839;
	bh=oHtRIsAptTXF54+4BJ34mKmBZlrungbNMyhnHWfvkmQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MxkllRVIR1L49NVQ5QWSnp3FHQl7uHEehZpLAPQktYeanFhRhycBxfmMvxeelxrGi
	 LEDZDtxwSu+0NLw66eWwXnR3eLe75y9h3aNOd82x9MOyEOO3jzLeJ+aw9NLWAk9uij
	 M55fi2i/YfPec3P2fgvbdiiUPyFlI3F+ZMzxSSl7RAicjSt+RK6f1A+6GHUOS+weZI
	 sAdVBac+POYlO36pY5RS9KUKPJUqtlL8yJFMhTBKDxUQNMxz+crKYLvwwSWV0q5Xfh
	 yJ/VBmpvdirfxxVrwLekcOiQqswbOCHIdKOzALcZ7G5BJC+lxMJ6/bp5ET3j2tYnFK
	 +NgXPCittT0yw==
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
Subject: [PATCH v9 11/13] platform/x86/amd: hfi: Set ITMT priority from ranking data
Date: Tue, 22 Apr 2025 20:46:29 -0500
Message-ID: <20250423014631.3224338-12-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250423014631.3224338-1-superm1@kernel.org>
References: <20250423014631.3224338-1-superm1@kernel.org>
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
index 476e4a9ed67a9..75b0f73407047 100644
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
index 921e07acf2ff1..22a5bf977daf5 100644
--- a/drivers/platform/x86/amd/hfi/hfi.c
+++ b/drivers/platform/x86/amd/hfi/hfi.c
@@ -114,6 +114,12 @@ static DEFINE_PER_CPU(struct amd_hfi_cpuinfo, amd_hfi_cpuinfo) = {.class_index =
 
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
@@ -237,6 +243,8 @@ static int amd_set_hfi_ipcc_score(struct amd_hfi_cpuinfo *hfi_cpuinfo, int cpu)
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


