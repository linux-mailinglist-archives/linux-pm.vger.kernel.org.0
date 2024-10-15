Return-Path: <linux-pm+bounces-15710-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9673B99FA68
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 23:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 184EF1F21A11
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 21:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D4D227BA8;
	Tue, 15 Oct 2024 21:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QmPsUAdi"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0B7227394;
	Tue, 15 Oct 2024 21:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729028265; cv=fail; b=hFaYlvcnzefEH6uBGAhLYyUPbWELVz1n0WJZS6Kf8QEejnDJz/GFWLA65BJvTP1wz8cPoFJ5XZMalp6WR2I8Q+F7YAQsaIOCkObP9EiXAbEH+z48P5hOLtUbKd7aCg8JbUtvTDK7I44iub85FgvYvpWt2amR11McBO3DTm8Ts/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729028265; c=relaxed/simple;
	bh=/QoTUS+pqdujq/XVYeoY3WE4U2hs/Jg3l1Tc+a4DkpQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FWzSFF3G9Ok8DegshqMjcgrb8QSHQji6FFMhAyFwuAs7LGqEOnfyJ0SUi8EcnFFjchx8I4Oawqe30JHqrKII4CuAXn2G5VBvAXYRcCTgVs7J1QHB8i4lpsQbeNebovWnFCvh8Wb7PQa09PJBTmTpnRPTEFBiw07LsV6Cu6cOnLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QmPsUAdi; arc=fail smtp.client-ip=40.107.236.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NgkO/7f+E8RYYSBaAqE0wv/aGzVfglobTt2/cC6zA3kGgx4SBB32i3pr8eqF6VkLvKrLotFUnOJYkMDnZG0JMQ9TSJPfKNZNgVEWBZBfBl8vtL154eA4lW+r6QGrK9pGpFLPIcskm7hDvopvN4qvJSqjjgzi8VIrCbBvYZAlff0iCmIrdq6zL5HJl4aRn9gYDJwvSTloFuw9AuHVIB+nwEz/bxhHNMP8SohrzgYzex2+z7Fh7nfuPPrK645GOddLPibKadXG4SucqRyoTyDcH+m2V/rlLDJ5LTn+1CS4ABObbabGWlLlVZmPFSamB9FhgtquMncv/Ti3Eqgs7rAG7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XfpZgescQjpWXN1v9vPph7nPAsr/SHJOxlJjO7c06HM=;
 b=PJDXGCm5GrJ+LRZ2TSFsDlbWhtYPOAdvgM/fhAG+HOl6F1alH689K4G7mOLJZQ/OiZe38jL/K5N6WyRasfSpZTLqgIJKo1fGQqcbS8MDJ2qUakSmyAbijXSznT5HlbQeRoh7uRDrthVQZr2po3dLnJOU8kbnZprhqBl6WS+vZEN5LvmROVnMWdEzlkKhLHWU1eq3ZpTqWfENqIJ9BxDkf2904iU43w/09C4LGEhsVcmXmVwrwagZq77QNwUGOX+JQnyxUivEwV5cY+PyTaFmVhlOalSfFtWQGuTC59bkL5NZDhMb8tzINGkul8bdKzPnTxLmdlQjRed7bbhLH3wghQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XfpZgescQjpWXN1v9vPph7nPAsr/SHJOxlJjO7c06HM=;
 b=QmPsUAditrJEZg1Yqnp3h8OiNmGWVkcKDMyPfZuw6iVrlosvELueQAjy6GiU3UGUrLniXlKAoATLKGu7nmN/cYlSOp5nmEyqeXY0PzZ5NQR2ddtRkZZ955lje/+L8qxAz5UCpDlcCoUWYRifZBIAsW34NYKKLAEdst+JRxsnDHY=
Received: from MN2PR20CA0046.namprd20.prod.outlook.com (2603:10b6:208:235::15)
 by MN0PR12MB5785.namprd12.prod.outlook.com (2603:10b6:208:374::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 21:37:38 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:235:cafe::a4) by MN2PR20CA0046.outlook.office365.com
 (2603:10b6:208:235::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27 via Frontend
 Transport; Tue, 15 Oct 2024 21:37:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 21:37:38 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Oct
 2024 16:37:35 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v3 14/14] platform/x86: hfi: Add debugfs support
Date: Tue, 15 Oct 2024 16:36:45 -0500
Message-ID: <20241015213645.1476-15-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015213645.1476-1-mario.limonciello@amd.com>
References: <20241015213645.1476-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|MN0PR12MB5785:EE_
X-MS-Office365-Filtering-Correlation-Id: 81a34033-d854-411a-c804-08dced619717
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KLnWZYZDa04Wl6e867JEBmKwqocMGK90WiwUKonporyDvqEYsUd9tLxIp677?=
 =?us-ascii?Q?4DC3Q4sKRo2OC3DusNF6n4zDM4mCAN7TXVPuADdBA1Ws1ppTlldbtrSj9uuj?=
 =?us-ascii?Q?1DUKOD2mCoxHOMlF+8PIEJRyk7ONho70lSllF+RnGFT3oa+AkDT1AiR42J+t?=
 =?us-ascii?Q?8TgLlvKLevHcGzvjNLoCTkZTwlKDg6KYaaej0336kpCH+hcLHbiUMjxJ8VnG?=
 =?us-ascii?Q?jW0bjeCHe89AVeeXTMLAxPQhyFEKW9a6lx6ZYgWT7JCgUYvqSXfb7FwNEi+Y?=
 =?us-ascii?Q?SmfI7dc94QJywLWF0ARuUXSsRKPT0buhvZR38uTYDr3WhHQn5+IJaprKSfxG?=
 =?us-ascii?Q?X2k6iyqDZt5t6t+OjU/FKRXxq3efItf5Hy6KWpX4/ffmyOfj1JY/Lqm3dxFr?=
 =?us-ascii?Q?R962jHr/1awecAmlfC2wg9d3bsD99CQw3CQQEPib8e7YvFQ2YvqiHg0+QZPe?=
 =?us-ascii?Q?UjXoMC1fgy8fRQd6Umd+8fb7V8yaidLozd2UjHzNS6WRoIQ4KoxrZLmw2s2p?=
 =?us-ascii?Q?trYAhsX+naBug2G4JThjSctdv+T+AE1MhoUvUCL+lXCi4om1hPJ18q2pCz8D?=
 =?us-ascii?Q?kHpGkWoGFhSETdlKmERuF+CbjVdh7fZjKF4Qx8tWHXYMQfgZX73j+lcnar/p?=
 =?us-ascii?Q?11+J+kb8W4Bdajp5L7VqynuxxuNE3tfkcUgE2bSsyTLWBeL853Cb0qbqKGcF?=
 =?us-ascii?Q?mZaHx9bjptak9xANiHDVJaukb2fCwTjaaSUYKzrvA/tqF23dYR/bN204Ugp4?=
 =?us-ascii?Q?oSINttm3m9sVnKrDWMzsUecQhqViP1OeGdcNkij5jz0eENVgC2PRVrPoEv4J?=
 =?us-ascii?Q?twZ/wGoTZTxk9MMZNg7TSuRIu28uHQuQIOfRm6Zp9pMl8YxmjAGtBsRfpnV6?=
 =?us-ascii?Q?PenaCsfxEMxIZ6dyh5EzpUX7Zhw7Gwrw6olT+Bl4Ym+uKDIwY98JKT2cImPl?=
 =?us-ascii?Q?5MZOd3Rc+0/6uyHD7BhHUsCLKEH8+X/AkcgwAbD1TU4tjTB1FNvqSJLb5I88?=
 =?us-ascii?Q?KS25U15qY/mQNCeOnJwA/4LN6DWR+mhOsbE9dD1aGV8E0E6sagp4kNljtSvw?=
 =?us-ascii?Q?33fNVNrn4bsiZ56DUvlIm04S70vIBsSaeKhBqm/T+F5iR1Xf6Wh8+Ubtbt9Z?=
 =?us-ascii?Q?7LfmYGWgiSfZww/04rSmMkWfVRTuX0Wr7aV53phHXuSdRl6xMZDjTyJVi598?=
 =?us-ascii?Q?NeWszXAB1b9NddRYUVyl9NZ+yFno9yP4w80O00/7Ux5fR6+k9eAjdRnNgrZ+?=
 =?us-ascii?Q?GzOZb/tkYHvweFIbdPV2wa+p/jMxwK4Zr4qVmexrnOYge+heKEJF+HyeTOlw?=
 =?us-ascii?Q?M7QR1Vk01g2sNjurDxN9Wonh6AQaWy4JmxdyAqr190H4zvjXQxbwKqZ9pbDe?=
 =?us-ascii?Q?EKxBIz/BNh1jIl2gS1U76R6YkgRk?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 21:37:38.1671
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81a34033-d854-411a-c804-08dced619717
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5785

Add a dump of the class and capabilities table to debugfs to assist
with debugging scheduler issues.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2->v3:
  * New patch
---
 drivers/platform/x86/amd/hfi/hfi.c | 31 ++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
index 6c90b50f0a40..6df80f6ac73c 100644
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
@@ -79,6 +80,8 @@ struct amd_hfi_data {
 	void __iomem		*pcc_comm_addr;
 	struct acpi_subtable_header	*pcct_entry;
 	struct amd_shmem_info	*shmem;
+
+	struct dentry *dbgfs_dir;
 };
 
 /**
@@ -243,6 +246,8 @@ static void amd_hfi_remove(struct platform_device *pdev)
 {
 	struct amd_hfi_data *dev = platform_get_drvdata(pdev);
 
+	debugfs_remove_recursive(dev->dbgfs_dir);
+
 	mutex_destroy(&dev->lock);
 }
 
@@ -400,6 +405,28 @@ static int amd_hfi_metadata_parser(struct platform_device *pdev,
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
+		seq_printf(s, "%d\t", cpu);
+		for (idx = 0; idx < hfi_cpuinfo->nr_class; idx++) {
+			seq_printf(s, "%s%d\t%d\t%d\n",
+				   idx == 0 ? "" : "\t",
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
@@ -473,6 +500,10 @@ static int amd_hfi_probe(struct platform_device *pdev)
 
 	schedule_work(&sched_amd_hfi_itmt_work);
 
+	amd_hfi_data->dbgfs_dir = debugfs_create_dir("amd_hfi", arch_debugfs_dir);
+	debugfs_create_file("class_capabilities", 0644, amd_hfi_data->dbgfs_dir, pdev,
+			    &class_capabilities_fops);
+
 	return 0;
 }
 
-- 
2.43.0


