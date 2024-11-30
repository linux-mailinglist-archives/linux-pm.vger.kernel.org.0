Return-Path: <linux-pm+bounces-18296-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F19E9DF1A4
	for <lists+linux-pm@lfdr.de>; Sat, 30 Nov 2024 16:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3F4A281768
	for <lists+linux-pm@lfdr.de>; Sat, 30 Nov 2024 15:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7329C1B85C1;
	Sat, 30 Nov 2024 15:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="i320SDkv"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D250E1AE00B;
	Sat, 30 Nov 2024 15:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732980070; cv=fail; b=Ik5HIJ0Y0q4ahnKJD9UJzDSlLk5i/6JAdKZXVpo5GuLpplzmq0I2+Q1AauxpPOZB7CkPmOYOs4zxJ8u1WcZ5WjNccssro1s3tVI94tavj0g+HwxPN03TQhV3dfWPdofoYIY9yFFdWcsRZbbxRhd3nQ/Mla9HhFzQDKZF4Fzfw0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732980070; c=relaxed/simple;
	bh=Q7DY709JgBs+QNd6i5wQZjcCds4ZMiJT05soWR23iNM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rlred2T8S1hVbs6Oy2i9FE6w6qIAzebNF+OMh125ggQELfv1hE9X1JRkAF4whuzoVF2dXx3CzzGo+rlyQESSPq3tWD9NjEscgYu3/OoGYmDssufDle3hdtWwvn+eSruHGpGRYu1Dt5L26BiF6fKsnmvja9NHq0HRvg1P0ieZ1/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=i320SDkv; arc=fail smtp.client-ip=40.107.93.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nM7K1JICHPbHqy5SNC0aQFd/6hCC3BziwTR4andiGpCK5kBGIEC/hVu5D+q+7k/2qdPw3oetV2Bcvau1sOBvtC5uxNmecfwXA+eNZTTT86gMKWWCrHNZ5/nKY6BlQJTL1SnYWtn3uCMBMp2G55oOb3rSgoU1O1R4BZEf0dQdINiX97uh9Uv9vPmx+O1FIXOOIjHnmX7QBGg0ocY+daKvNVSybnbw2FFTkVQjGvw50+Ak2rLyXOmg/o9ctN1IyhLhDjy6lZ9rYwWupSkE7D5YQ6ejIGzKkvJ/nZ7YTNxNLRZxgyt8qi/DQzQ6/5stukwvwUgk+VnQ5W0Smb5Kz2s/sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CbsR33tA3QUueZBtjGdlP0wv8lbAXeI77bNgCXHd8C8=;
 b=GF8jRaqtgR0g3hV/FArZEYXUpmtFoQfAih24LHJ4TXqMuJ3AP7YJ235Cfrp7Tij5Wh1Ot/xtklmF8tl8kyj0yLHnwf/uHiw41wBoYzDRyVnUYKHYi3TRyvlTmVwMVbJsg5Ay6aSA9ZUkqxJ2HZNEJQuFEb1dKexlrq//aDPwGA9ngNgt29T4LlckZ74vLB9XIbrYEmog+VQ2dw/QsZOST3FO1T+eI2wCTIEDooIcK5BW8nQQR3aKAQZ5hKMPrlef8B5oTWfT0548Wo66mt1gxXT4/NEUGqi8kfwOnStTOfPeCv/iyTcwxL39tbtA8OgvdEfOuprJK6+hrNizdAg3Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CbsR33tA3QUueZBtjGdlP0wv8lbAXeI77bNgCXHd8C8=;
 b=i320SDkv1UiOVNs/dNFeE1ESCf6+P1bInDa+6qazFHdGovb+PAxQXnyfbahtd3Pqg8cyibzaCIa1JpWEUbFcp8UxNdcqkcKk8CZJnhEfsvloH1Y6wWs/DlY+E2lJoZ4o5lm8mcvnZLU5zLyUqUm8As+6g2BdVvE8QjMzbXP+DVo=
Received: from DM5PR07CA0057.namprd07.prod.outlook.com (2603:10b6:4:ad::22) by
 DS0PR12MB8341.namprd12.prod.outlook.com (2603:10b6:8:f8::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.16; Sat, 30 Nov 2024 15:21:02 +0000
Received: from DS3PEPF0000C37F.namprd04.prod.outlook.com
 (2603:10b6:4:ad:cafe::80) by DM5PR07CA0057.outlook.office365.com
 (2603:10b6:4:ad::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.15 via Frontend Transport; Sat,
 30 Nov 2024 15:21:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37F.mail.protection.outlook.com (10.167.23.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Sat, 30 Nov 2024 15:21:02 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 30 Nov
 2024 09:21:00 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v7 12/12] platform/x86/amd: hfi: Add debugfs support
Date: Sat, 30 Nov 2024 09:20:23 -0600
Message-ID: <20241130152023.684-13-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241130152023.684-1-mario.limonciello@amd.com>
References: <20241130152023.684-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37F:EE_|DS0PR12MB8341:EE_
X-MS-Office365-Filtering-Correlation-Id: b04c5e12-6ba0-4744-2f76-08dd11529a10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7wz+gVJQMHftqp9NqYnNyyZQwV0+1QDiuaf0bB/Ht0Kz/Qll23XCL+tN2eRL?=
 =?us-ascii?Q?hMgid1A4rekBhrVmvQpBxZMdPEc8c2ZP1L6CLhlibpRR+BVvZYuJz/zYfapc?=
 =?us-ascii?Q?T615bsxxMHoDA13OpHvJSmP0qOqUa9WrXCUlELc5Io5xkdnDYFWM0PZWBVmR?=
 =?us-ascii?Q?fAWmM4AN8zTJzI+tyK3GA0gNzoBeg+MBsrnlx0g6krt4/9s9xR2paC2G47HY?=
 =?us-ascii?Q?rk2T9Jal8SyDpID5gQWFpl0ed2o7g/ZlrTjkKZmTjTRju+BtaxH2yDayacVz?=
 =?us-ascii?Q?LsbO1JBlb1KDo06vD9yUsYlt2cnU8k3g/OBoTbyWbQkbkFaUuatfB4j07rzY?=
 =?us-ascii?Q?iM3lQBA9Kc12JS31gBh5uJrOYvQtmpbGWeFUKLkSQrft7uuW4IMd9c3NfpuR?=
 =?us-ascii?Q?jfcNnFjgL693EG8e2Q913xgFMuBq1fiTSeO9mBzyf0x4G1/74I0taAkE31DE?=
 =?us-ascii?Q?ruilF2WuEV+LMcDcsBxMvvu7xuapqVAKlF8LRDHVWpHf1x8FFmtxhV/f4v+H?=
 =?us-ascii?Q?SQhcmfH7s5IySOe5aSLgYNhgkVfhAmxxS3bilUw9dkDn1bUcEEjES0fY3kxl?=
 =?us-ascii?Q?vBHR/uoyx7sWemT29iZdCGpf6OK2GLqUIfZwtfXzrqqQehEyw0YlowiyGMHL?=
 =?us-ascii?Q?slZWaK7qwCCuG4BsTrzojs1u+Mcwz+iMGqJwAamizB4XYSv/QhR+w3XaIr14?=
 =?us-ascii?Q?or+D4uvUTkTM7JkjcwFxgnVDJxHBrXG5Unwk2Wqz8qZ9cPaWix9TRQxrwjp+?=
 =?us-ascii?Q?kUtSvCWsWr4i5JaeDoMeN4xtzJxaoQKyxd4lEov+TBmwP0HBOyjj1FkqY4tl?=
 =?us-ascii?Q?lAs8O7DV+GNFlXjQY8huI1b9QkEggFsYto72W+LrEBkd2H/BviOiSMxAqAl9?=
 =?us-ascii?Q?pkni6/1SnFi6uC930Haynwfo5vPNwR+9hMKQ9tzx76qM+g1I9ZKoAEGkD8Dl?=
 =?us-ascii?Q?Dtk26/fNt01L/Tb7wkP5jX0cmmd0Wr7UA3oVzJAzAQh07KTAC27tlG9d9jsR?=
 =?us-ascii?Q?Gl4pqBLNuY7EksHbsPn6uqUwE5RLSuv+7QpQ1dNXyT6BDjLakWt7JnsN86mq?=
 =?us-ascii?Q?zyitkoMhNRVvNfkHkXRFQft+VP1C6QwIjt3t9z5Vlzk/iRgxchNaEOwZGvUF?=
 =?us-ascii?Q?OfPC9SAOxF2Y+VzwYPobbLFT/xn+LoHh0iG94BU9XUjxvjeCaXY22nTJSLI3?=
 =?us-ascii?Q?LfKMsMtTyYNk196JAwImf3k3rpRA330ArSi8wzUzLO2Ml8DpmJQZAIvAT71O?=
 =?us-ascii?Q?RhyMJu2gv0z0eZ7sAOPYy3v5wdaa8BgtcOmjzXp9h114hicMq3n8AoASXXxm?=
 =?us-ascii?Q?BLNLUOdx8mPIEkGnL45ErO9Ly2BHwBOwHTVqC76pqb4agiZK8HesPTs7fAkj?=
 =?us-ascii?Q?1MzOjBGCR927XW03eDNbWlFXU2vwySbnSLum39a4qvcwq/rYT0fGs4ezcFp4?=
 =?us-ascii?Q?WRGmLySHyJQ7B6KsDWZ/PN9D2yTXnbgw?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2024 15:21:02.5127
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b04c5e12-6ba0-4744-2f76-08dd11529a10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8341

Add a dump of the class and capabilities table to debugfs to assist
with debugging scheduler issues.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/amd/hfi/hfi.c | 36 ++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
index 0940950dd7adc..b6dc379bfd546 100644
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
@@ -74,6 +75,8 @@ struct amd_hfi_data {
 	void __iomem		*pcc_comm_addr;
 	struct acpi_subtable_header	*pcct_entry;
 	struct amd_shmem_info	*shmem;
+
+	struct dentry *dbgfs_dir;
 };
 
 /**
@@ -234,6 +237,13 @@ static int amd_hfi_alloc_class_data(struct platform_device *pdev)
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
@@ -388,6 +398,27 @@ static int amd_hfi_metadata_parser(struct platform_device *pdev,
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
@@ -463,6 +494,10 @@ static int amd_hfi_probe(struct platform_device *pdev)
 
 	schedule_work(&sched_amd_hfi_itmt_work);
 
+	amd_hfi_data->dbgfs_dir = debugfs_create_dir("amd_hfi", arch_debugfs_dir);
+	debugfs_create_file("class_capabilities", 0644, amd_hfi_data->dbgfs_dir, pdev,
+			    &class_capabilities_fops);
+
 	return 0;
 }
 
@@ -474,6 +509,7 @@ static struct platform_driver amd_hfi_driver = {
 		.acpi_match_table = ACPI_PTR(amd_hfi_platform_match),
 	},
 	.probe = amd_hfi_probe,
+	.remove = amd_hfi_remove,
 };
 
 static int __init amd_hfi_init(void)
-- 
2.43.0


