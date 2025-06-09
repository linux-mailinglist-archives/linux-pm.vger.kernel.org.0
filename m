Return-Path: <linux-pm+bounces-28329-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55602AD2758
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jun 2025 22:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38D2416EED6
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jun 2025 20:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1737C227E82;
	Mon,  9 Jun 2025 20:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hNoOtvB3"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C3522128C;
	Mon,  9 Jun 2025 20:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749499549; cv=none; b=I6YxxHJb9mPGpKgicy/DFU8xbFFmjwI02qQYizpEXOm8aHbVHMqjb7U/YGXLT/N5TVSeiZnHy0C5BvqVRbN9ynPw2RIjMoxEdfCfr6S8+PZEwAxZEVHmUBhcqrqlM4xX0OtsvKscWuCkFMWb0wdhsUPCjvVcRL7+4kuouvfJwHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749499549; c=relaxed/simple;
	bh=98IFVg/2xavMwcAK1kftPNwdCjBQz1GB//A4WKY7EPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JDTXAQyx3udE1sb3MJ2WpsjViAOIBo8yBr8jrH3taQVAYM30pQopEovxw1RWXbaIdmqOxWNyYFyz/ZOkVq+h98wGLOzKIKNArSlmRxfjh2W4pQszUCccEom04YtxrPsbbahwbIDl+/zL807uZnScxxOCnVn7MzYkdFRFUaAoySM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hNoOtvB3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 295CCC4CEF0;
	Mon,  9 Jun 2025 20:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749499549;
	bh=98IFVg/2xavMwcAK1kftPNwdCjBQz1GB//A4WKY7EPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hNoOtvB3EVe330aRisayDJKGm2M8xd5X0cMlaHa/rodUM4+BNSA8pPlWc48YUrQZf
	 yjwB89qJdg8ML4xmCNR9aLpgxAJuz02HwKG0CyfpV6DLgLo830SuySHg/mUoNHjtnk
	 1E5tf5vMV2ZzOCUZTTsJwXc7/L1J/EczhkWagDbnwS8krX/NvGD/r1b+zvAohlXnAu
	 pGEw8AC6lUA2mQAa8b9oxfsNpnezklUlr6TWMtiGToTTUMv8KtkKttjW2Mg08govoj
	 EmE1/ihZJY9tvy1127h0/URRhOSrQMVee/TkfV5SCplOSApVUw9EFro/IqBP59JmNo
	 LvoquiBuUtxPA==
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
	linux-pm@vger.kernel.org (open list:AMD PSTATE DRIVER)
Subject: [PATCH v11 12/13] platform/x86/amd: hfi: Add debugfs support
Date: Mon,  9 Jun 2025 15:05:17 -0500
Message-ID: <20250609200518.3616080-13-superm1@kernel.org>
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

From: Mario Limonciello <mario.limonciello@amd.com>

Add a dump of the class and capabilities table to debugfs to assist
with debugging scheduler issues.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v9:
 * signed->unsigned
v8:
 * s,for_each_present_cpu,for_each_possible_cpu,
v3:
 * Move idx to earlier line
---
 drivers/platform/x86/amd/hfi/hfi.c | 35 ++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
index ef38bc367eecc..17df96d47de88 100644
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
@@ -238,6 +241,13 @@ static int amd_hfi_alloc_class_data(struct platform_device *pdev)
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
@@ -393,6 +403,26 @@ static int amd_hfi_metadata_parser(struct platform_device *pdev,
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
@@ -469,6 +499,10 @@ static int amd_hfi_probe(struct platform_device *pdev)
 
 	schedule_work(&sched_amd_hfi_itmt_work);
 
+	amd_hfi_data->dbgfs_dir = debugfs_create_dir("amd_hfi", arch_debugfs_dir);
+	debugfs_create_file("class_capabilities", 0644, amd_hfi_data->dbgfs_dir, pdev,
+			    &class_capabilities_fops);
+
 	return 0;
 }
 
@@ -480,6 +514,7 @@ static struct platform_driver amd_hfi_driver = {
 		.acpi_match_table = ACPI_PTR(amd_hfi_platform_match),
 	},
 	.probe = amd_hfi_probe,
+	.remove = amd_hfi_remove,
 };
 
 static int __init amd_hfi_init(void)
-- 
2.43.0


