Return-Path: <linux-pm+bounces-15491-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7879992AB
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 21:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22A7F2816CE
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 19:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5B81EABC5;
	Thu, 10 Oct 2024 19:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uwVRjs1U"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2062.outbound.protection.outlook.com [40.107.95.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A456C1CF2B4;
	Thu, 10 Oct 2024 19:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728589079; cv=fail; b=AfxeRTVhroVnwK/kNZez3C6lQ1r5q2TfE+SyqiNHfdBey2FGYD7IT8mFb6VN60CO4poshZQ+Sd42WI6iYUNWwhXAKt4lwPM4GoIzcRolwgmmBStw4gLeKmp3AiHg+u2mxGJhvWbGwBpXV84gtHHMhrL+9dFqW4fUTVufkz1vpxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728589079; c=relaxed/simple;
	bh=5MwpwAK0XAOIBD3SIGN511DONmNC0pEPVIZm3eyrnvg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mD0VYhi6WFi72J6MAAtStX6cnwlLy+oubUt6nHVoZaRfbyYi03WYF7PLNn7bbS316mqWXDJwB0J41PMbrOms14XMKcmck1g83Z42nAl4ikByIIpGPQzUvaxRCo0BkBUpDOHkT1ApTWB1dHRFEXAPmMlUfL1sgukfBvvEQ0Vv7Wk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uwVRjs1U; arc=fail smtp.client-ip=40.107.95.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fmeQEySZIgKBl7ZTDC099U05YryvTxZeFGGWJMsfQVAaYXSy6W2x9wUv6uiGoBQxYB6YFpzHx87ghLS3URrN3RuJ4/o+uKknFedvykvxOGu0ZIiz8PyAf3cxotv5DOqf3BfJyZbP82Tag3wMVbtpa8NYqzIrAFt5jVedHsnTogwKTO9ifixnQCgh36kSkTyNUonFPwdsM2YH+BkewbpyV8owFDzBPP8J6B8RMOXIoblAOUgMsvJGqs4wWMigRToRvjgTi76+B6EH1SXCLII3cGEfXTqFxXQaBDxcMpKpTWH4NMW0WB6rS5HGvb8EataLAb2GimA/aRF6YvB8QiRSAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GElOAKDz1JLyshcJfsdRfLDz3rfkEDU9C+Or6ZrSaXs=;
 b=KXuZesrOwqAn9wZ3fuSqgdNKiuhLO5sBXM28l5Lj7wh7m4SNWOqExgn2DGl4eaoNjCXWOba8puWh0DYPOlQBQ27YDk/auU2L8fz9nS7LOpKd695A5yPybcCI+uRwEx/AebPpRNvj9qTYR8c0Zmnxt5GtFJn+hx+eCgaq09WsXLcqKy7OatNt15VA2JbrRNO5sMycmV8cl9AZI3BgzVMiBIVm0ZEdc3zYTg5tKLsBX3E4X7nFKcfAjCgnwscC1YTPBF05vk7QniwGibr5pAStzyuoKuXWZO2vXCkB2TRyd18VJfvUkuSLe2d3jS5CJ6D9ZmtFHsNx0OO6cgUzfzoTzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GElOAKDz1JLyshcJfsdRfLDz3rfkEDU9C+Or6ZrSaXs=;
 b=uwVRjs1Uvif5AOz4GRN+yrUzGeLbbFTR0jI93DSNTx1Kz4vkYih9cYhPY6hol/q32lI11E7Ad7SfWQc4XxIh8Al0t3/SVgXaegBc8LLQTI3Aag5TtpBrOnGxTAAnVPzdXN7snG+B0rDXytSpdEnWKrB72w7l3xyWux5Ugt7hpmU=
Received: from SA1PR04CA0013.namprd04.prod.outlook.com (2603:10b6:806:2ce::19)
 by MW5PR12MB5682.namprd12.prod.outlook.com (2603:10b6:303:19f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 19:37:54 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:806:2ce:cafe::9a) by SA1PR04CA0013.outlook.office365.com
 (2603:10b6:806:2ce::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.19 via Frontend
 Transport; Thu, 10 Oct 2024 19:37:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Thu, 10 Oct 2024 19:37:54 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Oct
 2024 14:37:52 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v2 13/13] platform/x86/amd: hfi: Set ITMT priority from ranking data
Date: Thu, 10 Oct 2024 14:37:05 -0500
Message-ID: <20241010193705.10362-14-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241010193705.10362-1-mario.limonciello@amd.com>
References: <20241010193705.10362-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|MW5PR12MB5682:EE_
X-MS-Office365-Filtering-Correlation-Id: a3738b1b-d99c-4f6e-894d-08dce9630930
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I+5C4qrkIdTNcPemA4x4qRscndtj+8Tjbl31FSswMkKViwy96Um9qPoQU/z7?=
 =?us-ascii?Q?EhWPpdqoJluYpvRXnCW4bBNP9ie9Nmdu8apI85bvBUT5ieW1Wu4REbdxdoLD?=
 =?us-ascii?Q?4/cPpVuP8Xr4Ddqqvq8GnWYFWE6FLl/L4wghA/SP9LI9X4VJwsXzwEhLmqYe?=
 =?us-ascii?Q?i1TbFGwXVLJ1ltniHPItOyXUAAu46GX3QbQJsKcfgFrLAbFgQg+AaCHrbH6t?=
 =?us-ascii?Q?wl2jl5XnTShB3c5xmoT+4Sl58lWkuuD2//FiTDeRxA81qIzR+yMMvpigDRpv?=
 =?us-ascii?Q?d+ih3GdlApW3Um7bOeP9xFfX5wkb9kopq1Swq0Xb34Ohlz6IGJjviGQTy6pg?=
 =?us-ascii?Q?CNoroBuTezLIyVAb4vudCO2gMm07M4aVVGiryGBNYpZBS9vSYtADE8S6q7Zi?=
 =?us-ascii?Q?T5CfsjMxqsmOqlRqSrLsWn1DGEFmovLEJxF1wgjPPwq9FUxBPQc0E4Rmdfqd?=
 =?us-ascii?Q?syt/k87QjdHzx7TiD0AJAZOdMtN647TSQAxi7jhZXLO7tilbQNIDSFI9Ldpv?=
 =?us-ascii?Q?8derBw8P581CW25uyzCx1txUFoshJmwbi63J8OHs33Vv74wsFlGeuFjuCDVz?=
 =?us-ascii?Q?7Gy9csanQVybQjC/0f2qTPqF55aPYQoxsNmSPmaZS6Ek3Xv9mfZ48zIURwPZ?=
 =?us-ascii?Q?M/h9hGmkDln5Ok3GlMMV45uZdjsA09zNRWVMvOjn4jWKyeOWahlsaEm9DhaQ?=
 =?us-ascii?Q?OFf1kINxPiSn1epeORhftYvnWH/NqRWwDf90syDloPKIuECs9bnQopf0zMTG?=
 =?us-ascii?Q?7c2wCCztmml/F83HNYg8GtewOB3TEr+a+wsOZXmuhsUNdZ6LDfIWT7HYdW7Y?=
 =?us-ascii?Q?DM2WfbcUo3wUlylz1nEZGrGIJCAvlvnUQw9TPHEM1bceRFK4h1A3zbL/7+ev?=
 =?us-ascii?Q?lWYQJmfM7IIC+DVPcgZd8yUW6cu2N6D1A6rpbejh1tCEp3ICxEBpnwBDDQ/a?=
 =?us-ascii?Q?BdoAiJHFOl3/wX460JjI+OVu1gOjyNhtlEpRP83xENz38RDKZyymX97qhk8/?=
 =?us-ascii?Q?6KfKNavl1qWosfAbwjDaXTHGt0XxnYPpbPrkeu+3WlesUGYRI06dIGypwBnf?=
 =?us-ascii?Q?SupxqvRzwaSs/Xk9iyhgKpfZEO2pQxnw8CadH/tGEQ6M8JEiTPiN7ZqeOhHI?=
 =?us-ascii?Q?1vq8mVM5nTNmSJY/asJvk7IHg2aPEvSLW3Vkcgow6WvLow3J1M7ppZ0+8lqD?=
 =?us-ascii?Q?9nSynDkQqgMKf+k3EaN4IjJz4EJXhLQAz0hia6Wy196py+vNAu0WkKG7qiRz?=
 =?us-ascii?Q?Q9c8v3T8ZN4cP0gctMy5Vy8zviWtEVg4VOvMHUs+L/D5zIuWEdj/FDpgxT9I?=
 =?us-ascii?Q?zKSP0YtP/k+DidKvMo89S7uV6v20uy7iY+VzsUojEx3nL6EPkUGiEX1uC8vE?=
 =?us-ascii?Q?rCmW0Ow=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 19:37:54.4040
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3738b1b-d99c-4f6e-894d-08dce9630930
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5682

The static ranking data that is read at module load should be used
to set up the priorities for the cores relative to the performance
values.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/amd/hfi/Kconfig | 1 +
 drivers/platform/x86/amd/hfi/hfi.c   | 9 +++++++++
 2 files changed, 10 insertions(+)

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
index 0263993b0a94..f212820a0e4a 100644
--- a/drivers/platform/x86/amd/hfi/hfi.c
+++ b/drivers/platform/x86/amd/hfi/hfi.c
@@ -121,6 +121,12 @@ static DEFINE_PER_CPU(struct amd_hfi_cpuinfo, amd_hfi_cpuinfo) = {.class_index =
 
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
@@ -241,6 +247,8 @@ static int amd_set_hfi_ipcc_score(struct amd_hfi_cpuinfo *hfi_cpuinfo, int cpu)
 		WRITE_ONCE(hfi_cpuinfo->ipcc_scores[i],
 			   hfi_cpuinfo->amd_hfi_classes[i].perf);
 
+	sched_set_itmt_core_prio(hfi_cpuinfo->ipcc_scores[0], cpu);
+
 	return 0;
 }
 
@@ -482,6 +490,7 @@ static int amd_hfi_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto out;
 
+	schedule_work(&sched_amd_hfi_itmt_work);
 out:
 	return ret < 0 ? ret : 0;
 }
-- 
2.43.0


