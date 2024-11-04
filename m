Return-Path: <linux-pm+bounces-16991-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0647B9BBCA3
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 18:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA7942816C8
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 17:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2EC1D1F70;
	Mon,  4 Nov 2024 17:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rSo48iHW"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2084.outbound.protection.outlook.com [40.107.236.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FFD1D173E;
	Mon,  4 Nov 2024 17:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730742896; cv=fail; b=FlTgwzzirFk3/1v1E2Enoz96c6yaSWbkK7HXXyapgD7RhTwl/8ZFJ7SSaNom/FNvknd9ina5c9cujme+sYCM0Q2BabmUmXJJGwGgsyo6PCxqbwbr3h5aRN8vCbxZSuj6aRDbn4dYOb3p6z9/2LQ7grW6crNvi2WhvUeNND6YXqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730742896; c=relaxed/simple;
	bh=HUwctRrds1tf6FMB+v0b8kBmsw1qxyTR1Ve3yh0HTaE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PwaafgCqSEJ+Iog/YSJT/HNodvB8ileDVAG4+K4rj/x1sbxmWhQMDdlU+VibIFUVBrUfRr+IHb61Or+rhURy0hxzevfa135McoIiFRyCM2x97tSDT+1/iYw4umJBLEVlgIiTR6NBT58Mksb1+lsgJik5ZaC02MaALbXmhYSdhOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rSo48iHW; arc=fail smtp.client-ip=40.107.236.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CUjEVJo4VbZGHoMqGCNAVfHSt0uGBYTTB0tPJmUDWw1ybu53HoCPQicxQUCuGYjaiHbq8jZ7VdxSmU2c1IcYeGt9jIYFt4Sx9Q19FuZ5k+fFZnv1uT1b2GTkIu2RCPnZhY9BAn8eXCiM1uk+v9vMQcTS1C3NZHocgi6dZ6Oakx0PmUA79zYv6+/C8fURZ+kIkfm2FrZjuzQ5jD/5mMSzvq5NrH8a2hRfp2Dp++n955pRN8fkk3KjzTNMRjK1tXzy4+y2auUKMbfkrIms7+b92nI3urV/HdQNScNvB/xCGCQWFplGRN5oj+trayzPkEuuTtA9SQAl+pXUrg6Qt5zC8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FdX9qPVfi9PzCLqtqgVMNGtMH6DibVFFwW20tp2VzLY=;
 b=vX57CBTrQWSEEnwlSJmTP5XjrEiz+zoI+VFKuUBL4qPquLCn5JPbqoPUEDT1In6TwivAtVJLNl3omBacaRyh8USdB6OJxJCSU1UzMzVGgUk081hR70wwddUBGjweAyjQLWEe3s9C7KlozJ3KMWQ6ulT1CFnkpZLlcKDNfUsqMNpvmPIibuhPYSlSnFD1AVDn5zP0Cdr8UZMxFAqfYPpyO5Cl42VEzUwuaaEXwYCTB0VX29UjmbB1OjX5cFiXTzNoWUsBWYM+2CJxNZZ5/mXnKW+mTftUmli3ARrgA1meX0Q66aCH7NaI1Q+AW2L8ms0M2KO63ZUKFCM5Pe+8WAc9+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FdX9qPVfi9PzCLqtqgVMNGtMH6DibVFFwW20tp2VzLY=;
 b=rSo48iHWlqXD/2oR1Wz9/oyVukg/wzQKX6KY0dBZpI+EJ6gwe5erIUQ1A/aMsLtq/mEjWOl5Yh613jSmhHjwJAxDtsitKCmSJoQt2hS5USDT+OAzR2SftWhl01h+BPVhfKUDJWjZspcKZZo3/btv8VwEWWV6Lu6ZSvI9eBTjrx4=
Received: from BY3PR03CA0005.namprd03.prod.outlook.com (2603:10b6:a03:39a::10)
 by PH7PR12MB7968.namprd12.prod.outlook.com (2603:10b6:510:272::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 17:54:50 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:a03:39a:cafe::f4) by BY3PR03CA0005.outlook.office365.com
 (2603:10b6:a03:39a::10) with Microsoft SMTP Server (version=TLS1_2,
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
 2024 11:54:44 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v6 11/12] platform/x86/amd: hfi: Set ITMT priority from ranking data
Date: Mon, 4 Nov 2024 11:54:06 -0600
Message-ID: <20241104175407.19546-12-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|PH7PR12MB7968:EE_
X-MS-Office365-Filtering-Correlation-Id: d8de2f22-52ee-4bb2-0746-08dcfcf9c76c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?suZauJVZ+FPD8E7xPCi6xsfJ6j7Sk0pX085AHT9S+mj8r6yRefVilVncmqlo?=
 =?us-ascii?Q?xP1foIdDEVShk0UhmC4lpbTgjAnY8TvUsMT80IyNJzipod8rLzgNhXQ4ZnOn?=
 =?us-ascii?Q?K198ts21bx65JyzxCnqQLp1ynI6cCtKushufisR5SkN6LxGfkIBeha3xUL/U?=
 =?us-ascii?Q?7bMqgNp2UiUYpBh5vw/E7k7I4WYdMLTI0uTO9GcVbPTcDVk/YV607CBsguUT?=
 =?us-ascii?Q?Pg30P2DDWnER2HPyd4A1IL+PSL0YE8VUMy372P0JidXM5oddxYPaioxKGnso?=
 =?us-ascii?Q?8BmkjFLLXmDcO8jGNcpqUykYq9+ikaPyFrMe6Ms7tVXVY1EG0Q2+LY9vkuoj?=
 =?us-ascii?Q?dFGHsLrp+Lq1LecSmCuzYnx5O+aeB/AGreGv7YbZv4YinsV5TAM2hZ239YAL?=
 =?us-ascii?Q?guJdYfxBsoICiUZrrxwOTstb+HjBKk0sSln2cYBOVbqtSy83qe5ocRGvTjnU?=
 =?us-ascii?Q?AHnyclrSyoovlMTeMV1/r98TXuAO/2DYKKAlkZfiiS4C9AnTVfKvhogrIc7s?=
 =?us-ascii?Q?R3BsHYLSpzaTfr7ax3nkfJrkfriwILxKCKQPQTunTgt/4YaJkZgVoy90zXWb?=
 =?us-ascii?Q?Gl/TkRM+tn6UNscTQNDuEX+9dMs375SnxA44wuFO70q4lIWYJ7oICeBABHtj?=
 =?us-ascii?Q?gvpfJtLPXDKkdh7NIkQXSK/J8fbrrIHtBhaXE3PX+93mrpvYcmrmPTuTnqib?=
 =?us-ascii?Q?c/34F3bD9jbiREXd2x/62MTq5aRJpdyke1gXee6avqBYCAPrLry0vgwH3NkN?=
 =?us-ascii?Q?tB2cpbb8SdkEMhOy+ZsTNXUVkKeDWUDP2keB8n5eTnYW4TK1NGSdu15bPKxk?=
 =?us-ascii?Q?j6M2fVouLVw6gvJmRYU5Sz8jIlk14Ixx3IT0fIcUwr8Yt8dlA0a+3PSFQ0zP?=
 =?us-ascii?Q?2V4Zel3BjZHxFxL3Jx1y/gMU9CsbX39PNRnh2S4ksk5+mCdIIKcbRiY48RRO?=
 =?us-ascii?Q?HLLtu2n3oByBU1Hw6+18pl1gw6TYvTBHFosBy8+kZbcMMWqhEOMOCbUPjx1v?=
 =?us-ascii?Q?o8bLaJIrh51I1DNZ4nJjQia4dPimNgA2TM+v63BpQoUrGYUugUd7/TlhS4ab?=
 =?us-ascii?Q?CtixvmhSRtMK3VYY3rYjIuG32ln/vFcrTItFpGKnZzvu6jmQQe/4nXCuS4QR?=
 =?us-ascii?Q?y5crcklXRvHPUZvCEan31u/z/MdsF9WoDUPL+zCSSkpZlx/UoGPch2YPEZoF?=
 =?us-ascii?Q?W3DH/uzt0cBD3U8TAwwkFO6umaeJwYIg/+ODLxe+1+pPzCu8n4i9d8tAFYXp?=
 =?us-ascii?Q?46Vf8lRnCARr9ZDuvNq0MegH4LRS62+v1VlB5qWtE1qmjBigQyCLV/3iWE3j?=
 =?us-ascii?Q?x6ehZ20p5qEdaL1N1nfPCkJCwH6wtPZn/3yjOoMxWnxmxd/2WTmRkLGloI0j?=
 =?us-ascii?Q?uB1b1mfX/71FMfTsw3osTR6Cjv52ST5W8+pqmVn+QKKyRbVwKg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 17:54:50.1007
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8de2f22-52ee-4bb2-0746-08dcfcf9c76c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7968

The static ranking data that is read at module load should be used
to set up the priorities for the cores relative to the performance
values.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/amd/hfi/Kconfig |  1 +
 drivers/platform/x86/amd/hfi/hfi.c   | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/platform/x86/amd/hfi/Kconfig b/drivers/platform/x86/amd/hfi/Kconfig
index 79e3b0073275c..5b7c2865f4aa9 100644
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
index cef6aa84bd85e..09905a354efdd 100644
--- a/drivers/platform/x86/amd/hfi/hfi.c
+++ b/drivers/platform/x86/amd/hfi/hfi.c
@@ -115,6 +115,12 @@ static DEFINE_PER_CPU(struct amd_hfi_cpuinfo, amd_hfi_cpuinfo) = {.class_index =
 
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
@@ -234,6 +240,8 @@ static int amd_set_hfi_ipcc_score(struct amd_hfi_cpuinfo *hfi_cpuinfo, int cpu)
 		WRITE_ONCE(hfi_cpuinfo->ipcc_scores[i],
 			   hfi_cpuinfo->amd_hfi_classes[i].perf);
 
+	sched_set_itmt_core_prio(hfi_cpuinfo->ipcc_scores[0], cpu);
+
 	return 0;
 }
 
@@ -453,6 +461,8 @@ static int amd_hfi_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
+	schedule_work(&sched_amd_hfi_itmt_work);
+
 	return 0;
 }
 
-- 
2.43.0


