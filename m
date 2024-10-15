Return-Path: <linux-pm+bounces-15708-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DED99FA61
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 23:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 240FD1F23D5D
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 21:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89735227B80;
	Tue, 15 Oct 2024 21:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="X9txct9X"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76C620F5DD;
	Tue, 15 Oct 2024 21:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729028264; cv=fail; b=G63nPZQwPv0glRFZx4v4V6v+aNhNiI9oAxUGQzhu1t/2DYhp5H82oRX3c5WFkZzJjYd4598cKn1W9NMwcuPJWfFnRPjNB1nbR5E4dpFRHCBXaLrhiupRFyGmajHDflecLqu4oAOSG+OAtGZzktyo0NOUc+3XMMSkeXpODmsig0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729028264; c=relaxed/simple;
	bh=JP5X2xo4Su4P1di2bUgZ+XhkwholwKaopEROJGUOybc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=abw+/MKEbb1B1JLGSTIGgiOT1pBFRVW0YjdR07J+C6OtEvJIXbaSFH+fU0NVqupwO3qjGbpTlgBYETDrcDt0DIRJSyyDER4W1bI1Txj9bDh+JYyxziy0T9IDDxQcaU8HF4kot4WU+c9pMCfprw2YbTbwNz2tP68Uq55ud11McFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=X9txct9X; arc=fail smtp.client-ip=40.107.236.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ANfABdIwhExVpKNRYSi9nYD/B3St5btxvh0YjFLpmdHqOrVAlLB+lmtk36z/NGVmgAo6s0jYc6uwjEOEweBQXDcaT77O1GJppMl2OQx0ntZKukORjYYcMkaNFO07ZgxJQQmKoi+jkMalP8E/x2v2FswzPTx2Y6RM1pOabBKY+3vWRtDC6I1SUpFM2aXe+njrhC+HdCaAl6frVZyHXbNrZI17D5mewlhzQbLiDXvKIdvwid8nNwVhNx+vo1iyKXKUfxinaaqWA4w5/QkPiVKHk/MhT9EY8MEaKVgUGhuBKb7h+wSYNtuSSaQuUu5pYOgcb3y1yBnrFhgnGfr6U67qrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KkqveYXjXyxYdU6a6l3F0J+BwlcZAc4ibqC1XF2+X4I=;
 b=OH73tzXzpPQVwSWtk/LDWuYv7X5bnWo/EMBxzxCh6vLeu8kBCjatQ+l2/aXyOR4WvTTgJqCURxWyK6VfAylqo60lC6dLwLDQPBojf3gxMZLzCOjxQwv/z8IjMvjnqhzXsxpYXzqBnTspFza47DmRpjoYtFFP2AdT3ibrFQ/Siq30PfamZuIEYmTauF43cLnggnntq5VH1R/nKpQZRZcyEQfglWM7auOjQ8IbaAmmzvVIvcx9qoX8hRiqtcVmDwb4fXBkMsVVAXYtgqg7+hrlL9LEC4y7Da3H3v4btc+l2zdPv+Q6lmSvmEcekes8F/Tkyrx3vPfwILm7T1kA2xmtnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KkqveYXjXyxYdU6a6l3F0J+BwlcZAc4ibqC1XF2+X4I=;
 b=X9txct9XXAiUQEPF8h7ZWMxqAC4QPk5spFtfPn0jPUf9m0fBX8lFScINIsKohbnBCj96Dgb1Uzfpu5J26ywnzKzBsqqKB/9CWYKxpF55oFrUzULk+3wyvKBqjBSUWXxfhmZ6Dq2HmJKI3YtlQssCkiIBlUHrprvqn39f9y/7siQ=
Received: from MN2PR20CA0047.namprd20.prod.outlook.com (2603:10b6:208:235::16)
 by PH7PR12MB7210.namprd12.prod.outlook.com (2603:10b6:510:205::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 21:37:36 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:235:cafe::82) by MN2PR20CA0047.outlook.office365.com
 (2603:10b6:208:235::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17 via Frontend
 Transport; Tue, 15 Oct 2024 21:37:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 21:37:35 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Oct
 2024 16:37:34 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v3 13/14] platform/x86/amd: hfi: Set ITMT priority from ranking data
Date: Tue, 15 Oct 2024 16:36:44 -0500
Message-ID: <20241015213645.1476-14-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|PH7PR12MB7210:EE_
X-MS-Office365-Filtering-Correlation-Id: 2df18b1f-593f-496b-d80b-08dced6195a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bh3/MIqLOqNPTcF8pHZd/YgRT7S3opvUhZ41f/TrzvOzaXWOSazjHnWx810v?=
 =?us-ascii?Q?qx2VgOQEpnSD1SCBw9LjeXQKLpR3WzFP6JNrlIVD+bSRsANp32Q1HV5OLZsj?=
 =?us-ascii?Q?/QnOCEvrG26i4VSR+BE3Ehh78TZTELtFm3MTWzgi1Lfn83Mo3nzqfcYv+3TF?=
 =?us-ascii?Q?TO4TuHnYs0BePHcGXQulqx1q7VYGcrlMK8tkejMW2gHTp2WuWocozLImPJzf?=
 =?us-ascii?Q?RwLIdTzEGNHYB6qDBVJQaAiIXX+/zE4wS/VXq/MRXpcIfGQed0vR8KptmU4Z?=
 =?us-ascii?Q?5AkCv8hOQ9Mg6nf9x0kC+b1YD+utz67oOBQVKA1zHhImuoZbFz+BWnd0CKnN?=
 =?us-ascii?Q?cJvdz4wv3zOZFwubu3ec1aZNRXevXZ5bghS63O9TEMZxs/B4YM8vE3JttIFa?=
 =?us-ascii?Q?7wHYpiUOgMe+cTnw5h1hE51Mo0yrn1VA9XVCRseFIOUnS3+3Eh2qvpGcSmqA?=
 =?us-ascii?Q?bwS0gn30lRL0wIHrxGZwyMgpMSHHgoHp8Eg8GKJw2jqtEueOCRxGm3vNxjv8?=
 =?us-ascii?Q?f1nCIgJJe/DdarL28edWq2SWyhT7SG9SgyZ5waTa1y+XNtutS3/fPalOkRfE?=
 =?us-ascii?Q?WQ9OGZ7+BgmGB0z9FIDvyoHV21/wPtnbqm9ptvUNWzqtmJdJP/01MjYWFAS/?=
 =?us-ascii?Q?5C4WWSFXIh5Y0uwWWUipEx1q862YFztklqKOsPQ4Yn4UZYLvmZ2PcB60XnE8?=
 =?us-ascii?Q?LHAjFFsZOQNhy5aal/7WGIL3S+GSAJdVZCNwvmvrjB3AGV4Bu1Td0B7EOtOG?=
 =?us-ascii?Q?s/MFB3rtBRBCLHHrRsIz/Av9THdo24CLhw20GV55J2tQJA4J9zI6nVcG9buK?=
 =?us-ascii?Q?TYj17MPJ1Djn2REMmHSbHPx2vQoari9F7nfOl1lVf8G7MdM2nYRYIsVLlztZ?=
 =?us-ascii?Q?osEzx8ggfK8to9lGxQnxzzeP1Xj8nTBn0e37ACTDYBkcmJ3KK1/tcx39d4CO?=
 =?us-ascii?Q?GnheSJVt+/d25ZhbUy6/AugCGQPp1FUsroTan46RIHnv06cw6VAy1GBSQeTE?=
 =?us-ascii?Q?FySkMO4UzqsXZO6FxfzIhYi5S16hNv3yu79NSz9R2hYcloyiaFO+nc9NmGW5?=
 =?us-ascii?Q?bF3J4wHt7p5TRX/U4eErR4YutSVhZ+QogZTGVPXQlehXMPbmpkXwOwdFCW8+?=
 =?us-ascii?Q?iShNF0fBjfP8cRJ8q44FxC5IhU8+hEMZcd5b9Zdgq+4VKUDwHQkCz0FaTFgO?=
 =?us-ascii?Q?aRF2NIH/xIUEwZJ2u9bl7ICJ7ayM4oc1FA+GZsjyyq7Cnyv/Zi+dEey/4SqF?=
 =?us-ascii?Q?OQd/IfqA68/hN0Mj5dg2uevvUqn6PLpxwdb0kzOB20Z8hT2tnsdT8W8Vzp7K?=
 =?us-ascii?Q?Zue4/zs1fP4UBpV91krgzdpNGtEmfcmeUQ6SqO+Vl1+/bgoDChqElcOlfY2e?=
 =?us-ascii?Q?yNjOwaQ=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 21:37:35.7296
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2df18b1f-593f-496b-d80b-08dced6195a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7210

The static ranking data that is read at module load should be used
to set up the priorities for the cores relative to the performance
values.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/amd/hfi/Kconfig |  1 +
 drivers/platform/x86/amd/hfi/hfi.c   | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/platform/x86/amd/hfi/Kconfig b/drivers/platform/x86/amd/hfi/Kconfig
index 08051cd4f74d..4dfa7641b35b 100644
--- a/drivers/platform/x86/amd/hfi/Kconfig
+++ b/drivers/platform/x86/amd/hfi/Kconfig
@@ -7,6 +7,7 @@ config AMD_HFI
 	bool "AMD Hetero Core Hardware Feedback Driver"
 	depends on ACPI
 	depends on CPU_SUP_AMD
+	depends on SCHED_MC_PRIO
 	help
 	 Select this option to enable the AMD Heterogeneous Core Hardware Feedback Interface. If
 	 selected, hardware provides runtime thread classification guidance to the operating system
diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
index 79963c423d35..6c90b50f0a40 100644
--- a/drivers/platform/x86/amd/hfi/hfi.c
+++ b/drivers/platform/x86/amd/hfi/hfi.c
@@ -120,6 +120,12 @@ static DEFINE_PER_CPU(struct amd_hfi_cpuinfo, amd_hfi_cpuinfo) = {.class_index =
 
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
@@ -246,6 +252,8 @@ static int amd_set_hfi_ipcc_score(struct amd_hfi_cpuinfo *hfi_cpuinfo, int cpu)
 		WRITE_ONCE(hfi_cpuinfo->ipcc_scores[i],
 			   hfi_cpuinfo->amd_hfi_classes[i].perf);
 
+	sched_set_itmt_core_prio(hfi_cpuinfo->ipcc_scores[0], cpu);
+
 	return 0;
 }
 
@@ -463,6 +471,8 @@ static int amd_hfi_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
+	schedule_work(&sched_amd_hfi_itmt_work);
+
 	return 0;
 }
 
-- 
2.43.0


