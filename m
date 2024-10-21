Return-Path: <linux-pm+bounces-16136-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA66D9A71E8
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 20:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CECE1F2041D
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 18:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A4A1FDFA9;
	Mon, 21 Oct 2024 18:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="v4f3mYpa"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFF01FBF7F;
	Mon, 21 Oct 2024 18:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729533814; cv=fail; b=A3sNBJJpRYrJzKwOmkraRHYYgnQvGptXs7PMh19MpPbqfZ6fUlakX0TKV4bYHPL9KGaPSxDLWpzt/lvky9FvgRjxuXMutSyDFOH2vp2tnZWYz7znhy7zjYNotXmkULlZUnYJX+eqDU0gDl5yKb83jnheLIS9v3cos39Gb1LlijA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729533814; c=relaxed/simple;
	bh=v+nTus0gD6qj+auBQQHGfkWKR/9AiLE3GwDUj5LCzmY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AxBsZjCRxn5kqrqIBISDrExZzd1edWn6Kk2mIzVsfyaMeWKmpU8F6pp4SXSbDtBWISXF/CS9UPxneZU0irBbML8H6yugS/Brf9mbC4V0BlcwxUu6xDQUmB/Ge1wwGZ9nlfJecyPCkL1TsctZl0k63lRZ0auqHviiwfiMJaAqgQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=v4f3mYpa; arc=fail smtp.client-ip=40.107.236.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o34kzAfhDUPC/ae6/ZXGPaOEIYhwXC7appi1eylbhzSrHBOZqcv207jYrbmWHmOF0yoXIF4Q/0VkQevSESAPEwQ4HVCHbbn8SMiLg5FtXvNzJNTePmLSEySPVEittY684XuyFzdrMUXOt+Er+SJN6C7rCDi/m25JK+5j0Gzi6YAepglXCIQ82Cfj0oXfzDfkW3kbHQ9dSHm0F2SfjIazN9crIsbb43iNKjmQN2C/3fnRW53YkJYyVA53r5IsYxIB/uY5qAOMZy4qfplVQkbMITIbMbpVRfsKQpn3cBEhkcPKSZ5CT6lhM9RaBnN+NAJcRjMWltoUKZOR/WLZSZB4KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qmr49eQLPrG0tFYXwCTU8c79T4nfEKV4Zezby/7jkJQ=;
 b=QhdD59u85KNTAA9TMmhOBg1IWOtPPm/bF5wXNwZxrAej/oAqAqYq3Zh8/z3JLCkHSY0jbuPajqK/9m/+J5Dj3STwbLeNrbRG886p2UVU4aVtTlT/DNBt7vQB/EG5Y5p6z9MukZpAjCzaek20f9Hf6P0rwkhvPWWtFjO8W6GS0orOxS9E0XRHU4cIV90GLvDlIhCqWykeeRl8uxrJ7qciTBrg3YZDQJ1RwCsrDICMPQcpEq1EotU/OTqiUGV7zai5od1S2ABpi9pVGhKYN99fp4nLEz9Ib3R8cTn1v9Jabjb/YRgeXE5lUzALey7LgjrjTftYAqk2aMZN8KJ0TdKWww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qmr49eQLPrG0tFYXwCTU8c79T4nfEKV4Zezby/7jkJQ=;
 b=v4f3mYpa/4E3Pp7vZQokHic5IqKLFFLhh51BUrtIB+EEFN8f9VRAAZAL/TKzJWRmW3O44FHFl1NjDR/lm7cpSZ0T0e+JRszjF405J+R66eBeRjovM9CDaoJN/lqLvqlds8jx76LrnDf2vnxlYTuRNBMs3DqAxEoHal1E6QFQ7N4=
Received: from BY3PR05CA0036.namprd05.prod.outlook.com (2603:10b6:a03:39b::11)
 by PH7PR12MB5655.namprd12.prod.outlook.com (2603:10b6:510:138::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 18:03:27 +0000
Received: from SJ1PEPF000023D0.namprd02.prod.outlook.com
 (2603:10b6:a03:39b:cafe::71) by BY3PR05CA0036.outlook.office365.com
 (2603:10b6:a03:39b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.15 via Frontend
 Transport; Mon, 21 Oct 2024 18:03:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D0.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Mon, 21 Oct 2024 18:03:27 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Oct
 2024 13:03:23 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v4 13/13] platform/x86/amd: hfi: Add debugfs support
Date: Mon, 21 Oct 2024 13:02:52 -0500
Message-ID: <20241021180252.3531-14-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241021180252.3531-1-mario.limonciello@amd.com>
References: <20241021180252.3531-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D0:EE_|PH7PR12MB5655:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a1710d3-8f52-4a87-bd75-08dcf1faa9d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IffY0QXVPI/83oy5zr1MgO65zAjpy+5PS/bU7DBovmVi44zi68UWuoHx7aHZ?=
 =?us-ascii?Q?FnlAtX8xJDDLMGvljnBeSkBIVWLrBQa8qqV8UhUrldS5xMzRukBZF12d9jcn?=
 =?us-ascii?Q?qORvhR/YaR6wUxU6L5bDv1L29YGqzuBCjZojfxli47bAsn9xocfpTFPnmNeZ?=
 =?us-ascii?Q?33hMo1ilZ/9N+kXdzTMOr4T+JHjQWkoiqmPzKb48Q7faEi2CMpOncStvWmQ/?=
 =?us-ascii?Q?9OeP2BY9c4h560FipnTkUGyzLkFTpNA+TT5rc0NxT8gXOeGMMTDI+W5lXQEY?=
 =?us-ascii?Q?SQmnRe0OwMv1bX+ntZ4wjIc4pLqlX8/GfRoXXt3iqdF4WtcmUyGP5wyT+K/q?=
 =?us-ascii?Q?Wj5ZtpwV3dx7xEhUNMwR/DTvP1GbaPKbRNMnAWSwYdffBs/dmF9PAKAKUsoy?=
 =?us-ascii?Q?W1dlLMnJ7OMoD3dP1Uw85alRU26DST40R0i9MKhVzHNuhvue1berIxOTHsnm?=
 =?us-ascii?Q?9Iel3wzjzkhAbzES75zk62LJRl202Y/g601RZepIN9AT+ccGcg7rWPqWG8SE?=
 =?us-ascii?Q?ZfA/6iwa1aDfMgUH7o9CPr6sWb4v1s8pHA3eKOQGit9Ymo7e6bgXd+QHH0En?=
 =?us-ascii?Q?35vEXK/uewZj5dWUj/k3kiQlBQ+5KWtmQTFPaGCvcRY5t5Jt/YgLlY83TjYz?=
 =?us-ascii?Q?DnTxpNt+IYhvDrrkcVg4ZwEXzks5czp/9pPzc5r9aSDsYLyBir/Uk6n5n66g?=
 =?us-ascii?Q?iURj94TAIz6F4h/golWhLBngv/7EaXzdOXivWKZPI8srxLxVsZEekJZ+DENE?=
 =?us-ascii?Q?aeUgJD+q00Uq7uGp0QKY09ayRLJNtUYq2rgA0IN3kk40Va+TCaLnqjU87SZM?=
 =?us-ascii?Q?l89sVkIBozViARPDM0DDR6fcyqV/rIfljSSllY8ejl6ioZPOc8ZOsqQ4jxFV?=
 =?us-ascii?Q?juaWw/m/l+gS+Iy6stgla2fFf9yr50/qzrQpNOpm1cvZLf5QVEaP2DIBUmcC?=
 =?us-ascii?Q?u60Vczj+resvrHrCXpGF5es2STJWOX3YHdGdZETLKh/vAWEWvqTZMrS1IPoA?=
 =?us-ascii?Q?OMToIOG/fr+/Mkihnr/jSaXrPRRMsh3S9OIgQoBFeCh1bAnUxAdma0WtECim?=
 =?us-ascii?Q?wAJJQbs8F0/2GKXI6oDM8asOQXn5e6n2gW1r3bGxB5SVbUIowOJf5+/jxuDh?=
 =?us-ascii?Q?4FPsMg3cYM6Kjiqq+v5KKpTupQ/Mo00twrArpcUThgOHYxF9is5cjYBrSESy?=
 =?us-ascii?Q?ZRRi+uWBN3xWvi95qG9KIXonQgRZzZV69P5mlrVVaSplxt3HXbfHaJ481Ytf?=
 =?us-ascii?Q?Wru8HEz0gB53/W/7UZw/uojctk7RN8G/QB00Nn0LpBCJUq1bZ6KyL8I3Z4Qn?=
 =?us-ascii?Q?quet13M949RC9KgpHCz6QmxxGtuVJ1mNG4mzQ0auMVkJVNk0oPlPjhvICndH?=
 =?us-ascii?Q?/NoqvSZIQ8XA8NEJsRNI/CwciN06Cd5ejmsTkvn7ebwTDkUpOg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 18:03:27.1640
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a1710d3-8f52-4a87-bd75-08dcf1faa9d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5655

Add a dump of the class and capabilities table to debugfs to assist
with debugging scheduler issues.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v3->v4:
 * Drop conditional printing (Ilpo)
v2->v3:
  * New patch
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


