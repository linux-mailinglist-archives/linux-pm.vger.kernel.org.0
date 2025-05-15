Return-Path: <linux-pm+bounces-27219-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7E9AB91B8
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 23:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C607A03B7B
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 21:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1138929CB50;
	Thu, 15 May 2025 21:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CK1msQhP"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CF129CB4C;
	Thu, 15 May 2025 21:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747344023; cv=none; b=PZrBfzwDduE2PltEjHb6vp9H8143COAKEawIqKOczcp49tBRFTn27CaYJx4vFC42/ZIZBtV+gN1TnnNm+YidkuZ/xW+DXdVCJioujqkPxFtOhrKZhUNZozD0Jdwt3WfpCMSi3o+UUMcJ8Gz6HSLQfX0QXxCARs3opcrbC9Y6+c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747344023; c=relaxed/simple;
	bh=9RclwTvkbddnT6kR7d8w74N4/VbFnr277HYosPXZksY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TnIe0mZoYKOTZWryfpLoK1dVVSP8BG8ScqRGOQqFwLkfhgcwQmEbdCuJzNzE/meMOOXQ6HN61A/b9/rX9VhAxhKferEAvG1mtjPw3ZkKzp1UfSEgasqXxn8SZu1OKZzVhzr/CBGrnwiX71MsfA9xFRcQsV9puxujJ6kXiM/OOEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CK1msQhP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A17B1C4CEF1;
	Thu, 15 May 2025 21:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747344022;
	bh=9RclwTvkbddnT6kR7d8w74N4/VbFnr277HYosPXZksY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CK1msQhPGGTBKz9UcO8D8kLueYoCqxWd+pyIb1Do1abl6LIo6izs9+jGmw89CSQ/t
	 rRa3ck1JhrJIfwDUaH7ZsfaqWixEDApTaX+oR4Pou8dr1lPFyoxjjqK/KM6UAu3N1z
	 zcOWyYE3Wt0zcEs7+Ok1JQxWznJn9xfdScLES2up2eO1AJeO0zZvSJwJ3z2TUcmw5/
	 tgFucwhec2Lc3+/HJx9OrM17/mNy+9KoNIZhhnk43w11cCcze8oAX4DOJVtNaeame3
	 71BzofHQPNsTUk/HVWV240bYOvSIyw5pO1ClJJ7VewXGdUQQX1lcWkShMoHqxJsWWk
	 7r1/Avk7x7qGw==
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
Subject: [PATCH v10 12/13] platform/x86/amd: hfi: Add debugfs support
Date: Thu, 15 May 2025 16:19:49 -0500
Message-ID: <20250515211950.3102922-13-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515211950.3102922-1-superm1@kernel.org>
References: <20250515211950.3102922-1-superm1@kernel.org>
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


