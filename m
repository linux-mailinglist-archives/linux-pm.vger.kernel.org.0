Return-Path: <linux-pm+bounces-25995-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9033A97C6D
	for <lists+linux-pm@lfdr.de>; Wed, 23 Apr 2025 03:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C13BA1B6126A
	for <lists+linux-pm@lfdr.de>; Wed, 23 Apr 2025 01:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25DDA267AFB;
	Wed, 23 Apr 2025 01:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oLRs32Zy"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0CD26773E;
	Wed, 23 Apr 2025 01:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745372842; cv=none; b=RdgNxZi+JPchiOQr1VknrQnSyNpGpu5khhxFzUkhBKhEkr3VZwBIoDWValGruGHumBMOfAmix3lrTfAbszEjM6/ZLSjkOmvdRgKYlTJyIRjj/cEqWrqSrqnEljRb/+eAzvZ8cS4ICOKQ5HoGn6UULwvKU8jYQHX4Su7Rp/mkPlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745372842; c=relaxed/simple;
	bh=A/O4Dt67rxVBdlL7XTxTilh3HCgVsRxhzYv/zKTNPow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lVtyvgepmMrZG3++FyoUtjEAquaugyCc6JxQqQOypyYwsAorhmA15gRYw1ko8kgx8lBXJyD8gBzcbQhwOx0NfOcq2Qk+QfT1M15vcDaQZIcloEAPHCpkUPnksyurdaCWAMCd3CX1BGSXh97nmJbz47LQbsBzpy8vF5spiy1nS/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oLRs32Zy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C0E4C4CEE9;
	Wed, 23 Apr 2025 01:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745372841;
	bh=A/O4Dt67rxVBdlL7XTxTilh3HCgVsRxhzYv/zKTNPow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oLRs32ZyLS0c9xOsFAxPLdjzLZZSDztW9guL4uih2pX/NuPExpHcQpNINiKfNZxCZ
	 REbDtCglIMzg766BC9NQo/LdIkkmXGiBqiOaYHtyM8SGLKB6cQk9GAMr6Fj6IsoT9U
	 OSSTCN9EYiY80o6097R9atUeDZQtTzXeXsoS9DrGcqruxYv3tpYSs8jsbn1Sq2c+4p
	 3FtkLHeTXBXEFhiruAEgo5VOdxcoYrQqfKDTPrPWuZ542FQJiOH6/kFl+ijj7MEIrK
	 PSZwYS2Tr4mIob0NsUmQaRd9Iw+DQi2+CuGalIUH0aASdxj2i70FmZ3nAHFf6nM/DD
	 x5xf2soGQ3G7w==
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
Subject: [PATCH v9 12/13] platform/x86/amd: hfi: Add debugfs support
Date: Tue, 22 Apr 2025 20:46:30 -0500
Message-ID: <20250423014631.3224338-13-superm1@kernel.org>
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

Add a dump of the class and capabilities table to debugfs to assist
with debugging scheduler issues.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v9:
 * signed->unsigned
---
 drivers/platform/x86/amd/hfi/hfi.c | 35 ++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
index 22a5bf977daf5..0d6966f138bc6 100644
--- a/drivers/platform/x86/amd/hfi/hfi.c
+++ b/drivers/platform/x86/amd/hfi/hfi.c
@@ -13,6 +13,7 @@
 #include <linux/acpi.h>
 #include <linux/cpu.h>
 #include <linux/cpumask.h>
+#include <linux/debugfs.h>
 #include <linux/gfp.h>
 #include <linux/init.h>
 #include <linux/io.h>
@@ -73,6 +74,8 @@ struct amd_hfi_data {
 	void __iomem		*pcc_comm_addr;
 	struct acpi_subtable_header	*pcct_entry;
 	struct amd_shmem_info	*shmem;
+
+	struct dentry *dbgfs_dir;
 };
 
 /**
@@ -237,6 +240,13 @@ static int amd_hfi_alloc_class_data(struct platform_device *pdev)
 	return 0;
 }
 
+static void amd_hfi_remove(struct platform_device *pdev)
+{
+	struct amd_hfi_data *dev = platform_get_drvdata(pdev);
+
+	debugfs_remove_recursive(dev->dbgfs_dir);
+}
+
 static int amd_set_hfi_ipcc_score(struct amd_hfi_cpuinfo *hfi_cpuinfo, int cpu)
 {
 	for (int i = 0; i < hfi_cpuinfo->nr_class; i++)
@@ -392,6 +402,26 @@ static int amd_hfi_metadata_parser(struct platform_device *pdev,
 	return ret;
 }
 
+static int class_capabilities_show(struct seq_file *s, void *unused)
+{
+	u32 cpu, idx;
+
+	seq_puts(s, "CPU #\tWLC\tPerf\tEff\n");
+	for_each_possible_cpu(cpu) {
+		struct amd_hfi_cpuinfo *hfi_cpuinfo = per_cpu_ptr(&amd_hfi_cpuinfo, cpu);
+
+		seq_printf(s, "%d", cpu);
+		for (idx = 0; idx < hfi_cpuinfo->nr_class; idx++) {
+			seq_printf(s, "\t%u\t%u\t%u\n", idx,
+				   hfi_cpuinfo->amd_hfi_classes[idx].perf,
+				   hfi_cpuinfo->amd_hfi_classes[idx].eff);
+		}
+	}
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(class_capabilities);
+
 static int amd_hfi_pm_resume(struct device *dev)
 {
 	int ret, cpu;
@@ -468,6 +498,10 @@ static int amd_hfi_probe(struct platform_device *pdev)
 
 	schedule_work(&sched_amd_hfi_itmt_work);
 
+	amd_hfi_data->dbgfs_dir = debugfs_create_dir("amd_hfi", arch_debugfs_dir);
+	debugfs_create_file("class_capabilities", 0644, amd_hfi_data->dbgfs_dir, pdev,
+			    &class_capabilities_fops);
+
 	return 0;
 }
 
@@ -479,6 +513,7 @@ static struct platform_driver amd_hfi_driver = {
 		.acpi_match_table = ACPI_PTR(amd_hfi_platform_match),
 	},
 	.probe = amd_hfi_probe,
+	.remove = amd_hfi_remove,
 };
 
 static int __init amd_hfi_init(void)
-- 
2.43.0


