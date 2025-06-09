Return-Path: <linux-pm+bounces-28325-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F8AAD2746
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jun 2025 22:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BB4C18946AA
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jun 2025 20:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A4D224AF7;
	Mon,  9 Jun 2025 20:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pdQEyUPB"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6745D224AE8;
	Mon,  9 Jun 2025 20:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749499542; cv=none; b=S31YV1FjM16Yo6dio1AjMRcyfFqZrFActyAGEQgOJwd80HQ8Rl/s71Xw5zscQwRJ+yA2kAFy308hfMhkbmRHfKPT6ge3dhMf48Bm7eWiY5z0nbjcZqjQhBzUW8bMS4Xbi0lMFd4H4BqrPSv1dxF4ajZha4OlhJT03g/83fdCmLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749499542; c=relaxed/simple;
	bh=A0PimShuH3lA4xwk1tp0mt3DYevGbEQvlECDRve1+7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DirOuAHLT+fdzi67NafByK6jbG7HlteK5AflJLHxDxva4ekFIGTuCYK5MTqEK1RZ4YtAt06BvQkiL2H+ptQnvI9/NEMhIXfJOMB2UI4mJMDUQD6aHbo2Wf37mEUOcgRycJ4SYo6k6UvppYjROrU1Tu6w4ytjeF9B5S07waOb8/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pdQEyUPB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 893F7C4CEF2;
	Mon,  9 Jun 2025 20:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749499542;
	bh=A0PimShuH3lA4xwk1tp0mt3DYevGbEQvlECDRve1+7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pdQEyUPBjA9sfxRU11xE0csgHTF7mv/6v6JroqFi8mFELLfhIKejyV5TBGcPVlPIX
	 59mj7JVhkj44qD9wdZLpZ5i0xK2VbORHxSuKSSESUTtQpF2GPToDqEJ9WVtAWDNNtq
	 JS8gac4lCOP2d5XMJIUJ/mhILaX5gz4QuKrwiUwSoGnjfLbAMs5HHK9FH2LqdgerAu
	 ru6jrPo+jxv7IczCCIfWiadmDDc79F/OIUvaPKKJuwOdYJMnespAWuh+VltEG1LuNB
	 ++ZEiBues6HX9o595JxPJQ5VAlVzmBTA0xhHdrTM++DkQRo4/5Bl7Ymh0ZspVt77Kl
	 oNY2u2wQXU4Fw==
From: Mario Limonciello <superm1@kernel.org>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
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
	linux-pm@vger.kernel.org (open list:AMD PSTATE DRIVER),
	Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v11 08/13] platform/x86: hfi: add power management callback
Date: Mon,  9 Jun 2025 15:05:13 -0500
Message-ID: <20250609200518.3616080-9-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250609200518.3616080-1-superm1@kernel.org>
References: <20250609200518.3616080-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Perry Yuan <Perry.Yuan@amd.com>

Introduces power management callbacks for the `amd_hfi` driver.
Specifically, the `suspend` and `resume` callbacks have been added
to handle the necessary operations during system low power states
and wake-up.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/amd/hfi/hfi.c | 33 ++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
index 681767d169c26..2c6832a3020ec 100644
--- a/drivers/platform/x86/amd/hfi/hfi.c
+++ b/drivers/platform/x86/amd/hfi/hfi.c
@@ -385,6 +385,38 @@ static int amd_hfi_metadata_parser(struct platform_device *pdev,
 	return ret;
 }
 
+static int amd_hfi_pm_resume(struct device *dev)
+{
+	int ret, cpu;
+
+	for_each_online_cpu(cpu) {
+		ret = amd_hfi_set_state(cpu, true);
+		if (ret < 0) {
+			dev_err(dev, "failed to enable workload class config: %d\n", ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int amd_hfi_pm_suspend(struct device *dev)
+{
+	int ret, cpu;
+
+	for_each_online_cpu(cpu) {
+		ret = amd_hfi_set_state(cpu, false);
+		if (ret < 0) {
+			dev_err(dev, "failed to disable workload class config: %d\n", ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(amd_hfi_pm_ops, amd_hfi_pm_suspend, amd_hfi_pm_resume);
+
 static const struct acpi_device_id amd_hfi_platform_match[] = {
 	{"AMDI0104", 0},
 	{ }
@@ -434,6 +466,7 @@ static struct platform_driver amd_hfi_driver = {
 	.driver = {
 		.name = AMD_HFI_DRIVER,
 		.owner = THIS_MODULE,
+		.pm = &amd_hfi_pm_ops,
 		.acpi_match_table = ACPI_PTR(amd_hfi_platform_match),
 	},
 	.probe = amd_hfi_probe,
-- 
2.43.0


