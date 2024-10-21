Return-Path: <linux-pm+bounces-16135-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 825889A71E2
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 20:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A24831C21A4E
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 18:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9681FCC4B;
	Mon, 21 Oct 2024 18:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dOIYQ6fm"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27A51FB3D8;
	Mon, 21 Oct 2024 18:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729533812; cv=fail; b=F9mOlqzzF34f1uR/uHNM+tjTTSBwbPuTINxitlTc/cXME7d35ypSQOWTxYVyyqXWHMsY4CjoMGxCoMZ+YwZFbQbh84DXXxynui5PTVMN+pWsWDETBsvRWJ5ouftSEv/ZXY0AR01IQc8qG409dxwvBneyo3wXwQpWDpMUiTsGzH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729533812; c=relaxed/simple;
	bh=v20A+qYcbUcJYDh1KpTP4gkfDSx1jIxGDQLp4XRswGw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CUwFMr0cLSdDGz34fVrJ0bbQFJyJCkj4h2JGMDk5DQnhFCse1cCTfblWX+prd8HdRZTI3F2SMO07mBWOtxU+AfA8x8tDXYQS8gaED9jTumvdJ3I+IPU+/RxgrA1pERvzXVwl8BZaIczHD25aeGMKHO0rJ/dm2xNXfny+kQODNmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dOIYQ6fm; arc=fail smtp.client-ip=40.107.223.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s1AU+ajeFOAC+m39BUqUcYJ6+A3tfCLS0wGrWowiOk9AS8OVTydHTyOvitlGsf5U16hVsFxYK+enMgbIkw+JvszgeviQ3RRW8OSQrxglm8nzj+iSrCYk0K75OCoClHiT8Ig278QEeEAdU61snOz3h6vXRJeCh8IHBgIGNi850syj0+vX2wbQuvnE7ahTwxoa2Iwy032skAfOG0ILWhakU507HiVtfMQlyKqxZGEny52lW4DdQKKMG220DQvhhxdxXDRK8nVaBESQMglY2bfCnGfr0PiGR2l980W5JW7wLM3qPl/6y+z8Rlg7jxQQguCpwK95VqsGcKX+5DvQJeGZtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kxV7Q56HF37N215gSoJzMyoaTl4ZgHOlFr7GHMSiEq4=;
 b=wVl11OYOShf3D5CA/tRK7aurmp1YGohIT3FYBEKhrPuBL4ITJWJbGfQf4NMrGdHX7zn3skc8/lWKyUYwH8rVE3m3UAswqItKbzloOTWs+7GK9BXVA/L4Z3D2lHFvGyonaCt1qAA2Cl4MRpLcXFwbXt8dIu3ppYkY6na8IJni7iTtZzJeBqYNOBHjM8TdDcJ1zKRcRzRvw4UiUUUpt8CUYRT2ggbeigaiQcCM9evMnkLeG8DfU8QxN0CSRnOsS4J2JKYRTf0Oc83kuZnQzAVxhklvOeXdCr6SFGiBnAlnApz7MAZF84QTm1KwssZDz317HwNkEbTd8Cy3/khZ5BTPuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxV7Q56HF37N215gSoJzMyoaTl4ZgHOlFr7GHMSiEq4=;
 b=dOIYQ6fmXMpGKHvREDa8LOs/rsgcHNuzXUg/WgWZ8SA0GlK1cDlhRzCj1LKF1in3f0V4j95mxzRqr7yoouU3pB+N5E4eJuVNeiZnL5QNNMw6l3mpw5twg6YL6paYeBn/bUAzeKiR8CO162ef+EuKwaX/KG5fjhDXcgiU2qTKS04=
Received: from BY3PR05CA0054.namprd05.prod.outlook.com (2603:10b6:a03:39b::29)
 by IA1PR12MB7542.namprd12.prod.outlook.com (2603:10b6:208:42e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 18:03:26 +0000
Received: from SJ1PEPF000023D0.namprd02.prod.outlook.com
 (2603:10b6:a03:39b:cafe::ef) by BY3PR05CA0054.outlook.office365.com
 (2603:10b6:a03:39b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.15 via Frontend
 Transport; Mon, 21 Oct 2024 18:03:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D0.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Mon, 21 Oct 2024 18:03:25 +0000
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
Subject: [PATCH v4 12/13] platform/x86/amd: hfi: Set ITMT priority from ranking data
Date: Mon, 21 Oct 2024 13:02:51 -0500
Message-ID: <20241021180252.3531-13-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D0:EE_|IA1PR12MB7542:EE_
X-MS-Office365-Filtering-Correlation-Id: 590d0aaa-18fd-424e-ee6f-08dcf1faa900
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?56Z5G1b46TrD5LN7QN66DctaxmAJxTwkqkfnKjP0LqTx8GbWJsHT7qMbdnhm?=
 =?us-ascii?Q?+bDpZMdtb7S1p1gKTQ4dgceKDHlaDiIbmtzTdA9vKWjFrzyeb8/KnvB4etPX?=
 =?us-ascii?Q?HkBYXA5RusmfitAWoEHdXVUUu5eMsOunaB1p0tlx/WlLxfCOBRGJkDt6j/Z8?=
 =?us-ascii?Q?0JIFeX+l1LxcoxqydrQClsOYpvpGs+vfY7fsEqUTOelvbPysZv2AGGni2ciR?=
 =?us-ascii?Q?hYc2kjiw4WyOjwgfnTLMsCX40piCRXQvYhOdtDuNJkEAO7grX9Z2oZcyECcP?=
 =?us-ascii?Q?gZPmxLsBfK32xrVMA8onImqf1oUlBdn4Gc4ZGDk5i+WEsLopdhh+byD6nzDL?=
 =?us-ascii?Q?IwI9y5e8DXq3wDzL6v4wFGx/ZPhTt1uZignqKxsnRdMJXzX4LiGHBK1kVaKc?=
 =?us-ascii?Q?8Q2o6BZ7zRLZDX/94GPx/HDh6nKaqit+nqPdCPm75EMdpr74rwI7BEZxVa5x?=
 =?us-ascii?Q?v8/q1OIqrgIxfNb2MoTqfori38rfEeCYiKMATAjNEe/kWrOzZ/OuiS++AjmZ?=
 =?us-ascii?Q?5vdYG74qmddqYiAghkA/kT6COUs2pxSClng27RIBDFPRLngJ+YNyiXFQizLj?=
 =?us-ascii?Q?GOKXgG4vR/aVNKIG+T5+R9VaIsQan2vQRxz0I6bBZOuvf8mgNKBzX9CYG7pt?=
 =?us-ascii?Q?wZTRG/1uxOaNVl56V7oeAxr5kf6SHPVCDc/1zo+kT0zPZhnlTrEZxQtaOTzi?=
 =?us-ascii?Q?LuDLaqSVt/pn/bamOlnvU73dBjMyCQUVArxst9zj9JJvQCZ53kbuEht4VTDP?=
 =?us-ascii?Q?P2bxSYg/QromQZcbU1ayihWrEUd2CjxM7hbLxt93uthFadvn+oDDwpNZrMxp?=
 =?us-ascii?Q?EG29+yN8bZO0H4+PCiMFa66IazfmnCd4GZJPGwZs0pQGMWMojznLB7Y1GoQt?=
 =?us-ascii?Q?qrbcqcK9TWqQ8s4KegUS5oOHGWB1oHXG+u22e2vadwOo0lJziUvLjX9DnmkN?=
 =?us-ascii?Q?2KB95S9D+CgsrQxx3hoUqjoVBCaJzapbdQccJqMBh2pD+qoDxoGYJysaMQ2K?=
 =?us-ascii?Q?GpURtzAE6CreReFnY3ySFCCnEaDmI6brC4ij7M0bOIZdHY+KmErHSF/sG587?=
 =?us-ascii?Q?D+f5lnfCpoS/bMZs/S9Z+OC+PXktgY0ihoQbDLqXnmJ9mrMzmySwwCACsGS9?=
 =?us-ascii?Q?2U03OrrLy8ei7LAq5s0ZJQs3Rhs4LV3O7DPM+jkQxs2gVNE8nqol1XaIZmZt?=
 =?us-ascii?Q?+Ph3eQUtvo6Bloj26+9c7kts4n53t1fjRQrvWxKtEEWtPUwQDT7JhwPNnGSw?=
 =?us-ascii?Q?j+e/J7eXkwAZSYcUHvHJS7O4HydcmAs0tv74EpOoV+ZhnDsfE1mIyLqN04C6?=
 =?us-ascii?Q?T6xyWkV7neoMNwqoWmTQlk7m2TCinIzWOXJs0iyqp27zQbAjrZgKSHSE8glW?=
 =?us-ascii?Q?YTIhhGMZz5qzijViNwFML8YDbDK5uQhYJGE/gER63aigBDJCEA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 18:03:25.7890
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 590d0aaa-18fd-424e-ee6f-08dcf1faa900
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7542

The static ranking data that is read at module load should be used
to set up the priorities for the cores relative to the performance
values.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/amd/hfi/Kconfig |  1 +
 drivers/platform/x86/amd/hfi/hfi.c   | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/platform/x86/amd/hfi/Kconfig b/drivers/platform/x86/amd/hfi/Kconfig
index 08051cd4f74db..4dfa7641b35bf 100644
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
index c8fe03d0c9ccd..50407ab805169 100644
--- a/drivers/platform/x86/amd/hfi/hfi.c
+++ b/drivers/platform/x86/amd/hfi/hfi.c
@@ -116,6 +116,12 @@ static DEFINE_PER_CPU(struct amd_hfi_cpuinfo, amd_hfi_cpuinfo) = {.class_index =
 
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
@@ -242,6 +248,8 @@ static int amd_set_hfi_ipcc_score(struct amd_hfi_cpuinfo *hfi_cpuinfo, int cpu)
 		WRITE_ONCE(hfi_cpuinfo->ipcc_scores[i],
 			   hfi_cpuinfo->amd_hfi_classes[i].perf);
 
+	sched_set_itmt_core_prio(hfi_cpuinfo->ipcc_scores[0], cpu);
+
 	return 0;
 }
 
@@ -459,6 +467,8 @@ static int amd_hfi_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
+	schedule_work(&sched_amd_hfi_itmt_work);
+
 	return 0;
 }
 
-- 
2.43.0


