Return-Path: <linux-pm+bounces-16547-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 729749B228C
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 03:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32A83281FEF
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 02:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3461CF2AE;
	Mon, 28 Oct 2024 02:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TFS+2WK6"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8002E1CB9E0;
	Mon, 28 Oct 2024 02:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730081014; cv=fail; b=Nr2kZLLKWnFrBQvyDyH+n3yFFBUIqq3ibURMxbVzmWnMB2OmZxApgP/jy95EYLlNoEguAui68cggcIrw//+VCyDQNuq0bAFnBXRr8sVFwEiWQiIN3ZvqrAlbZs3VTIivypmBfzqGL7j4/frqsYuMWBZvJd/mqkKq8x+XgPYn7Sk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730081014; c=relaxed/simple;
	bh=umJJHqwuOCy6C8LmcO5UOXfq97Xmp4VOdH1D5BZmT2M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CzIsAMmXxfrfzdFc+RtYX0xltRfy1EwIaBlC4YDzpd+9mlVAFW1bCORrPrho24EUvpIyGZp6hX/flheRMi5Et36B8o2pjuXT3/TP9d8bgRg8RgHyAEdqooCbXGPhhRAFG4bWUGh3JgJaiNVtqudPMF1NafTX/z+ueS3Y5+AwhF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TFS+2WK6; arc=fail smtp.client-ip=40.107.236.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YKxoxp8gyHbo6Avz/Bvoe6XcHnKrtu4NSVgieE6U+qyUamdQ2ehgSX/NYpfcStvoNyMLAxNdNWQhyWxfQpDKrjDVgBSvty5fO8QoTOI4mqKqockWyBRj3+IJSB5Yp96KEYVqUVIzOFk/yRDGccWh1DeTS9+LI7OmNly6T2AznWSISspSEIj8uD3zN4cSVoq+dmQBtlJh5sqkXR/Nwg4LTXASW0ufdmu2434QmxbslAc20XBBfYYDZhqPreNfkOIhV4C6AS2BUCcuGcVB/e05/9OGOrEe2VuSjTrFSGuGRmm0d4LtmCvyVR6wDHkxe5iMCUsfMgRMsbMfRX5AnOzovA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WYZyAnPuYdwR7uSDv5rn0zv/+3aE44TMIWo6CoVMgtc=;
 b=tNAK2+Hlgb1mxHHDqg29qUYJITbSlXYbEcZlSPicJEXTfhBSBgf8nWizM/KSHqACKchG+79iLhDjtfIa1pLzUs1LsoA3ZNEup2ZNZOoJDdHOTyN6mO/ptiiutkIy+5Ci49bx/FLp9AOdqjrrzVqNlWlr4Me+rWCM7Jwz/cuN8zNnfu+TvqTUKGPzNHJ/q+HRcFgPw3Y1+AChEpW1I21R3c/bjaXuMUkDvpIrRRo4gqWnwyodzADpc17skf9ovH2H55B1RXf13kqYqgfy5AAO7npQGlHbDQwUG/cVJX/bL6ddiPFhBOLOYCt/RT4Wx8dE1uoBuVA4Nq4QhX6bFVP4Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WYZyAnPuYdwR7uSDv5rn0zv/+3aE44TMIWo6CoVMgtc=;
 b=TFS+2WK63scMWp6SHEBLRZXJ6Ni6XF66ko9ajRd4/HY9II3DBW06uJmkIC6kIChK4s8njl0KZeSbzTTwc8GCX9kyWwpIunLN1jBtXmVeZgJ0c0A4lmgnEEEtFK78KQd9YN/BX9iLgHxXQnhzwbpGqTqCcomLUAgP3F0cuehUbdc=
Received: from BN9PR03CA0905.namprd03.prod.outlook.com (2603:10b6:408:107::10)
 by CH3PR12MB7546.namprd12.prod.outlook.com (2603:10b6:610:149::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 02:03:27 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:408:107:cafe::1d) by BN9PR03CA0905.outlook.office365.com
 (2603:10b6:408:107::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21 via Frontend
 Transport; Mon, 28 Oct 2024 02:03:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Mon, 28 Oct 2024 02:03:27 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 27 Oct
 2024 21:03:25 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v5 13/13] platform/x86/amd: hfi: Add debugfs support
Date: Sun, 27 Oct 2024 21:02:51 -0500
Message-ID: <20241028020251.8085-14-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241028020251.8085-1-mario.limonciello@amd.com>
References: <20241028020251.8085-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|CH3PR12MB7546:EE_
X-MS-Office365-Filtering-Correlation-Id: 676cfc29-54fc-424c-922e-08dcf6f4b669
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JqcXLXzNOB6tgEvsEUM9nzrC6V9ZwiUzRr8FA/jihbDJJDOQc+Q5H6ma/dAb?=
 =?us-ascii?Q?0PEI8KYHsy6JdBbx9hhDfhjcuAn2rpL8kOD92o0svo0ARjIVX6qkHrAQcSqk?=
 =?us-ascii?Q?8jLKHyp4WC7iQn7BIpjoFpt4TchpTwZZIRXk/Gpz83qA853Ajy2vkSzpmaeg?=
 =?us-ascii?Q?LL5cBMoApRCYX3D2RB/4Dg+6zDpt1X7a1whz4tjSSVcy/p0M293BsmhJPyML?=
 =?us-ascii?Q?HXVa/YI0ARJWu/sZYB+DlHljLtbAaLTne8SVrAzeS66Rj5cTZkR4Eft/buUa?=
 =?us-ascii?Q?PutGsBrU1PIri1WPgvJpqSaXB6LC0eKzoGZ3Y6HujDk0E0t3IKIej1OVzjsZ?=
 =?us-ascii?Q?2Yipiozk/m9/dC8CAGx7qh8kDuHMSJFYZRdCdpHSJvfo31Ac5+60VSyBdkvy?=
 =?us-ascii?Q?/GPfvkfZEYLHkGaNMx1/LsR8g868po1BjLpbLI1mR8InIzBAWSQMxVhL3qiN?=
 =?us-ascii?Q?q/TjgWrpxEGq/6crntUrOMP+fvfDOsbHomJEDhtT+E2HRBECXwq5Ba53JFu4?=
 =?us-ascii?Q?WqpsAZhLzUjvddekG80PDcpEBomQpbWq8F3MCV6iNXql9gOKzuHyTfaeAfQ5?=
 =?us-ascii?Q?F69KAhwE+dqhHdMNpQi5M122o3ggqLkoFaWGtWjtu6o1ibvZtbOlCDz9CZ5H?=
 =?us-ascii?Q?G9v85ninZg+OJ7pEvg3Xb3zKerpO1H9WJX29KIgZ588RSwhbkIorxQCgK2/y?=
 =?us-ascii?Q?1NS+FSV9BPQwDaG1oKlTyLuO9njlpWfcn+kNVMWjDysPIt3o4sOAE0i3ZpPv?=
 =?us-ascii?Q?BHXp7eXWbfcpwVrQuRzwtFCOprdYq3phsmHQLKV/mjZtHKdi3KZtersmK2MY?=
 =?us-ascii?Q?WA4hcZnmdZg+nJW2VQ+S4mWo39bmMRIntXDDDwXuIMb4jnA0sFN5JghoLbF7?=
 =?us-ascii?Q?vMowHJ1xQPvRrZbA45CLo/cgaBR0g0FAA0AXkPmhLd65Vw7w7zW/VvV1zeqe?=
 =?us-ascii?Q?2PcO3n01lCa5vHOq3dhHj9+PaFl+KqDHJoEvPbA5kQM0DOb1cddqi86vVYsy?=
 =?us-ascii?Q?cxfiYNvN7cV4Lnl2fjt6rCMaYcBtJZA6oJWCCVkjxY116ghXA8J2WFRiIdgO?=
 =?us-ascii?Q?tLRXyXobtKW4fFpScwmLkXPL0xJ4/e1+uDukrNYDZ9HiR+ddb5j/auwtGm7h?=
 =?us-ascii?Q?wleVbkkZfvhT775gvMMOGMiLUXD2y21xyKNWNiFfJc7GdozVRsxL9i7mluGh?=
 =?us-ascii?Q?c1M41fUbv3ryx/CFGjFAy13cbNL7XHgVFmV7FxZtNbgWecgQR1k7unv/V8AM?=
 =?us-ascii?Q?zCJN+LLvtT1eTRvTr6rN4peIteh4I5c0NiTa7IadvnApiyOEFh9to8TamI/R?=
 =?us-ascii?Q?wrkgc5fSUdUZ4txCk0Z/VLUd5zWjd0dUDlRoImr3wo9jhNdIuHvv1S3p1Xfm?=
 =?us-ascii?Q?xMdOCzlbNw7L/f5N5ME/L+f7IBLF14pskrqepqf+ROHExj4wAg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 02:03:27.1967
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 676cfc29-54fc-424c-922e-08dcf6f4b669
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7546

Add a dump of the class and capabilities table to debugfs to assist
with debugging scheduler issues.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/amd/hfi/hfi.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
index 50407ab805169..839007684b049 100644
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
@@ -75,6 +76,8 @@ struct amd_hfi_data {
 	void __iomem		*pcc_comm_addr;
 	struct acpi_subtable_header	*pcct_entry;
 	struct amd_shmem_info	*shmem;
+
+	struct dentry *dbgfs_dir;
 };
 
 /**
@@ -239,6 +242,8 @@ static void amd_hfi_remove(struct platform_device *pdev)
 {
 	struct amd_hfi_data *dev = platform_get_drvdata(pdev);
 
+	debugfs_remove_recursive(dev->dbgfs_dir);
+
 	mutex_destroy(&dev->lock);
 }
 
@@ -396,6 +401,27 @@ static int amd_hfi_metadata_parser(struct platform_device *pdev,
 	return ret;
 }
 
+static int class_capabilities_show(struct seq_file *s, void *unused)
+{
+	int cpu, idx;
+
+	seq_puts(s, "CPU #\tWLC\tPerf\tEff\n");
+	for_each_present_cpu(cpu) {
+		struct amd_hfi_cpuinfo *hfi_cpuinfo = per_cpu_ptr(&amd_hfi_cpuinfo, cpu);
+
+		seq_printf(s, "%d", cpu);
+		for (idx = 0; idx < hfi_cpuinfo->nr_class; idx++) {
+			seq_printf(s, "\t%d\t%d\t%d\n",
+				   idx,
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
@@ -469,6 +495,10 @@ static int amd_hfi_probe(struct platform_device *pdev)
 
 	schedule_work(&sched_amd_hfi_itmt_work);
 
+	amd_hfi_data->dbgfs_dir = debugfs_create_dir("amd_hfi", arch_debugfs_dir);
+	debugfs_create_file("class_capabilities", 0644, amd_hfi_data->dbgfs_dir, pdev,
+			    &class_capabilities_fops);
+
 	return 0;
 }
 
-- 
2.43.0


