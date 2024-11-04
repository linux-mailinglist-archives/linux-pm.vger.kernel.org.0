Return-Path: <linux-pm+bounces-16992-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4483F9BBCA8
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 18:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA2C91F223B1
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 17:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472CA1D26E7;
	Mon,  4 Nov 2024 17:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="J0CWI0Pv"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2051.outbound.protection.outlook.com [40.107.96.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D47D1D1E79;
	Mon,  4 Nov 2024 17:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730742897; cv=fail; b=qWw9q7oMzsg9jagQvnpOZHXNUp/0qSntONSl9wvLlAXglUVMdDj7ycmwgjx3+NZffMznwTR8e6v2rsYilKOx6Fo+oDQRlIQcwVa7yrFeiMklxRgeG2YZ8IECGOzll9B168S61Tyx6ZovTk+mrftW2ki2JfkrhsbvZhrrcDyoW74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730742897; c=relaxed/simple;
	bh=BGla9d8BjQvkYlOfJT0U6neqZ2x1lv21lAU57QkU7rk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m8KcNWrtVJ+EUDYg/HRjWj6UegC9ko5eD7emyLlEt6M0fCUvdX2Uh1KQdseqAgPj1sK6hCQEtfQ9COJ3Vw4jNlTnYVWwEuDkxuknsTkhPaYj4qA444jtGGUE7vIqmxJjvtoqqnN6fAB0MmxsL7JkVsl6E2dLP0GT9OCmDBuH5YE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=J0CWI0Pv; arc=fail smtp.client-ip=40.107.96.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cyb9VpZL3BhIFhWzHFdkht6kbYOy6pAatNSASxAGSM3JGLKAcmrH74V3EbnRVs0qhoHvNKShiojRykDsaRVlGv030VUX3hY8uzxX67qqnS0VgAxBcHuS/X84opQ6/J5wKREiUAcFoqbYwvh4fNoTu1LOqhNatM9YGQk1VQoHn/5uoSFfIhxyzvDgqhn4+31LLiV/baKmSjb5wjc8QocSAbgJpTqfPIOeovSIXyVv3JKl9GBqtQ/Yv24dU6LaNCkcCa26A+ArFo5r+H3MBNJVVRXlhsechefHhOkLc3bfmEKhKPuG7c1KxbmfjebrsThm4Tij+/9Ku8HfhcWwYkamXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fe//duN24E6na7HtnCV895JdwLlEtIXMz6qZSJwdCao=;
 b=RGeg2rcuutuIYOeymCZnZrIDMwjD7tJFmDI/hRid8A11fSBjRgJfcKEljD8y3lxTk1NPhnUcu0C0aQnSvWZg8ic1eRiBhdquord6SKSCHs+f5BvO27eUO1xrqLlFkDs2BQtOD2+IzW9FhKxjMB83G721b1qe9hImazccynKdZYosTrZk/iT9ikTN+376jAikbsMGwPYAl6lc2u1UZ0fJarDIF1St8SZDU8tcmM8p8VIm328/CZRQBy40gcZl7P+wGRWObquVAzC/CRf6lxmJHCL/yiednihdt4N6uY91ZNDHeXb70zkSGWiqJqnfE1f+lRh1BkPWE6QPzzcsU3cSOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fe//duN24E6na7HtnCV895JdwLlEtIXMz6qZSJwdCao=;
 b=J0CWI0Pv9O2SEYQFwOO4DJCoA2XeSmxsr81raNRS6MXD89XkHBOOsAQQjp9u+QG8ud5ANUtoqAYJfS7jjqMWv42oGXpCFn9pfueBEiQKeLnWFscOug7/CWpPUlSAl/oV5ZgnUXo2zRDxPgjCjzyKdWBqOAEP8rSZq24y9P9Lz64=
Received: from BY3PR03CA0014.namprd03.prod.outlook.com (2603:10b6:a03:39a::19)
 by IA1PR12MB6386.namprd12.prod.outlook.com (2603:10b6:208:38a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 17:54:50 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:a03:39a:cafe::d7) by BY3PR03CA0014.outlook.office365.com
 (2603:10b6:a03:39a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30 via Frontend
 Transport; Mon, 4 Nov 2024 17:54:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Mon, 4 Nov 2024 17:54:50 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 Nov
 2024 11:54:45 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v6 12/12] platform/x86/amd: hfi: Add debugfs support
Date: Mon, 4 Nov 2024 11:54:07 -0600
Message-ID: <20241104175407.19546-13-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241104175407.19546-1-mario.limonciello@amd.com>
References: <20241104175407.19546-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|IA1PR12MB6386:EE_
X-MS-Office365-Filtering-Correlation-Id: 979fcc7a-23db-4826-f07a-08dcfcf9c7b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1yk9PKVVNptE/trC+pckgYevm1qDQjHsWodHMwTGNQ5nJYGX2kxd4Llz2TfD?=
 =?us-ascii?Q?MoxEKoUrCZJZkZ25/j2C3zH4H8nNUfgiAO7TawoEEhzHGQFuVzAnjIgXygMi?=
 =?us-ascii?Q?MMPkhZ8MzkSwjgADQTbzC2I0i4zjBplQY/uDWkkvXmwFljO/UK+sFcCEbZEr?=
 =?us-ascii?Q?tZ/m/ytUjDZhdyOcDzYf/5u9IHtufT+5boCpt7UWCu4UCDwy1rumRy4/aLcq?=
 =?us-ascii?Q?gdgXXilINzhjrmoKy40FZPQlHZED6hh7Hw0ysvfw1wp+wmQzBtwOTJIiaONG?=
 =?us-ascii?Q?DVY6bw8LgvDWMXBtG8Etu4BGou3IG4lwg/E0etDFQE2en2ZSlANjYUA/PwNz?=
 =?us-ascii?Q?bXrIl+WkGr+Kem3z8c8p8VvpGgr9UTbdnqmp5Zmi5D0KlblG7BE1NtOIayzJ?=
 =?us-ascii?Q?7CfXC1Zy0nNIpFgJu8PmaHuIWjpMBgt6fXVHntAWKI/QE1iss18FLmPZYonY?=
 =?us-ascii?Q?GDrMz2Kh/dz3rDRL5lhueYIvKgR2Zd3QMn8NwWfvKFfcRyVq+1TkSL+BLdJ5?=
 =?us-ascii?Q?n4ddKMHnQ2E7bomalSbxFhAg0zvKG9j8LkDur3vfMcMSI7yghelevZbu5sUA?=
 =?us-ascii?Q?jIQD/qXydJ44crA14J/kTubgj05z/JBqSSeVlfopXFMq+c64YUHmwPF0md4Q?=
 =?us-ascii?Q?AHVfKHiXUGEyHJEtU03fYCmtD68rC4hFEgu2x3ZYsxJv/rewuCCmtHQze4JD?=
 =?us-ascii?Q?rGN5VOH26gTdtezTEYRh6Wo4gPWVzTrTrGTAyQGhdx1mOI1Gl/tgOpMmGqQ4?=
 =?us-ascii?Q?wel2VOrjoKNCkbD9ZjOszLqoYQQepBO5o87avTXcDIQv3HXePDRJ+FNQH8f0?=
 =?us-ascii?Q?fSAEUtP8MC8EcWWwW57kGJgWc79fwHc5ZavwLxDhL80iitrNINSqAt274Vd4?=
 =?us-ascii?Q?/akQFyEDY5cbrpSaNHzvD/GYletOum4tXo1OZcaC5CIJCEuEli7+bwYJ2aaH?=
 =?us-ascii?Q?OuryOPUbQq985vjie5Tq3CZgmSPf3kXcJt9VS/6QHXU/0tpq/v0UDRaDMhIy?=
 =?us-ascii?Q?0yr2h4MQyZokM2tuKt+pIRpenNAJBtskkBx3yxTiR+6ovic1SXpHUuCtDGEW?=
 =?us-ascii?Q?LnNR44ZSdCS8iPE3PnZu0IVfW512nqRfVrWJWNB+1cs9N98m1OqmOAXajQKh?=
 =?us-ascii?Q?UJzwuaaXokOu21nj5NeThAkM6wRjSGCsVB6Pg4KAwUtLq3GYeQVGoZztYrMD?=
 =?us-ascii?Q?BUh3d5mWIFg/0HJx25FEeRhs8V/ee9aw+vQahuo1r4DHGi5DYlZ3grMxD4KW?=
 =?us-ascii?Q?pYbO6x4O+Brsy+1e2qEGd9O8pYfgoEEyaDz4OspbcBUJElCN3ffVZ6HcgHXm?=
 =?us-ascii?Q?KKZBwyhPujYvyZ5lDAJTVwp+MmTbw5JOQNCarepzo+xdehhfh8fcm3dYu1Ad?=
 =?us-ascii?Q?ab0WB0/n56R108amdwv+l+VIfjvGwoF+r08l8HOa1FiCDkc9Lw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 17:54:50.5851
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 979fcc7a-23db-4826-f07a-08dcfcf9c7b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6386

Add a dump of the class and capabilities table to debugfs to assist
with debugging scheduler issues.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/amd/hfi/hfi.c | 36 ++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
index 09905a354efdd..840a6a277d062 100644
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


