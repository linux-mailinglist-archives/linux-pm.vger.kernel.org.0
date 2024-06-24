Return-Path: <linux-pm+bounces-9918-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 200C4915915
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 23:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 900E51F244BB
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 21:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4380B1A0AE1;
	Mon, 24 Jun 2024 21:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sisxVU2c"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2064.outbound.protection.outlook.com [40.107.100.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6261A08CC
	for <linux-pm@vger.kernel.org>; Mon, 24 Jun 2024 21:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719264864; cv=fail; b=Bq3PxNLXyL3Qx7Vq1O0BWfN987lFY9sNTA7SUeObi0mOuQD87ISH4RMRq0Rj+PGSxSQ1gqKGNoXkOFzo1K1Yx2SylLY71VEWrsd1IJrvcB0re0WfGaVk4HHVjhctXxpfXDPcW2fOuYmBZfq1N5M+wd4m0qrjqyzCsZUUUubj52E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719264864; c=relaxed/simple;
	bh=fLJjwFzSn27vcEH85Il5LRx+tblcte+zCAPIN06OzFo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bKqSn5zLkOyhKkpX5xFSem7/MlXWd9svLMVaHvg31wjfF49FkNdRfBjc3oh3GaRBtdgT6YgjCLX4QoLtttnAtrNL45DPsIT8wDFdNCV7gxeJroB1+hVOJr4fAJZgiLVAxltE5A5nsRSHE42fQ1yr53+Qto5W8a4gPB5q4ggtmQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sisxVU2c; arc=fail smtp.client-ip=40.107.100.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fiYzPiqK9LfYG+Dp1gXWg+vbsl2ZwVJ2P3zBBtCCMa9HXuEXyyCm7K4OcYSP1kryXyvuVa/Mo7Zs6G6Z+A6dyM/fy5VwAvxL7RmJCiGdY75rDt5agBUjlLC+/fDARknGCSV4w1hksHzab1snyGNhfbOr20xD9+NxIfRKT+urHjZ0GBHl4u1xxdxoMoBOSnFEn0s6KMy6C8HmzDEhRoiWk8hdLiNJ6NYktufTUggJAcr7d6mXDQ8uDipqVEOR0NTyddXN1A+ARsOodA3+KxMkE3hgJpwiyfayfhARkrU1lEvTkgVscSePw2xIT4OiUe1eNnb8Q5JF3BRDPSxWo2oCpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/EGO2J+SS6xz4VGkHPdkXA8PuPElSsbHEahnoj3NJ8M=;
 b=MpvnmuoABqaPyPZ28Q9OXY97iCpqcf0cEhF+tOwzmKyGrh/TzC6SBTQnBsS8mvJhC8wNmdVZIwth5dRPVBJWkAPIWwCu+DguSDDG8cR9LTp5udteX4VjB1zISFKXOIRA8Ek/X4QVlz6UDb8buek+EWFeYaF9k6bHxjBhGufHs/xldtZTFgsBUfQ//eNjxYO15F4DG5mYInezRmdE8/ty/INrflmJSbbzWyoygF/WnfQYSuWYPwZDH2eb8VwfseIwTlU1c7wEHmV1TPtHMO3ADmng8cpcMCsPj6PxL09psdYqSDLT/MaJeAcoznjOctyIqLUkSP5Ffda0ok5uh7ds8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/EGO2J+SS6xz4VGkHPdkXA8PuPElSsbHEahnoj3NJ8M=;
 b=sisxVU2ceA15RtePyijMQSbF7JgmMPAA8a51cM+Yi9tWuIIZtkk1VbTtThKzaHmVjj1PWhOAqjxgoIcfxptBsYA21DewzjiL0ARi801Wf0dUhKEjNCHE1HtQ66LcnMBRrGRvDKshkfUStNBE80Y5xTXrwR8EF10NybhQhPmq1bw=
Received: from CH5PR03CA0005.namprd03.prod.outlook.com (2603:10b6:610:1f1::24)
 by CH0PR12MB8488.namprd12.prod.outlook.com (2603:10b6:610:18d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.26; Mon, 24 Jun
 2024 21:34:19 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:1f1:cafe::13) by CH5PR03CA0005.outlook.office365.com
 (2603:10b6:610:1f1::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Mon, 24 Jun 2024 21:34:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 24 Jun 2024 21:34:19 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Jun
 2024 16:34:17 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <perry.yuan@amd.com>, <gautham.shenoy@amd.com>
CC: Linux PM <linux-pm@vger.kernel.org>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Huang Rui <ray.huang@amd.com>, Mario Limonciello
	<mario.limonciello@amd.com>
Subject: [PATCH v14 1/5] cpufreq: acpi: move MSR_K7_HWCR_CPB_DIS_BIT into msr-index.h
Date: Mon, 24 Jun 2024 16:33:56 -0500
Message-ID: <20240624213400.67773-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240624213400.67773-1-mario.limonciello@amd.com>
References: <20240624213400.67773-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|CH0PR12MB8488:EE_
X-MS-Office365-Filtering-Correlation-Id: 38fb7653-11a4-440f-31f1-08dc949567d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|1800799021|82310400023|376011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jxbwi8Upf69eutJ+RcBtbES+9okKk3p1SA/crDT5vFBOUSht5sMElZLsqrxv?=
 =?us-ascii?Q?ejFRspwRFxHxPwyJ2goInzk/ikEx+U1XrNVWzPPbV8tGqNtdotsHnR7o8Wst?=
 =?us-ascii?Q?tb31zXPvS6HwqJrRl1FJU1hSTfg5855MWLQlvon3uEWM698Rn33aEGxjcJJx?=
 =?us-ascii?Q?u21ZJxHnPwElXhd7Snb6NcKjgzsFELlZ/DAEWdz/1NB5ArVgG27+RbYhMYQ6?=
 =?us-ascii?Q?QOdcqDdUPU4CMD1UactQlB21nt08qRiiTHXWQvanmRHUbX3HWiKFkkkvq5I/?=
 =?us-ascii?Q?LQWGNSit2dlkgGnyk+qkpCM7A6lHs3FjZFQjTa6SAWKbuEqWigFZqX46Y1Z3?=
 =?us-ascii?Q?H2aqKOgCxdCQPWP59PLkpW6SybqSwcdEl/uxb6nuJRTb8MwTpEoUxxqBcM8F?=
 =?us-ascii?Q?kuwkD2n7hJoKa8Qg0k7g2D93KzXoPv8lNG7DWgs7AvQeMZLl+5xUFpecvYxR?=
 =?us-ascii?Q?pNnuc3KPrhjzMszb7p8YUf9uJm3EAKxHTT2CmC4SKNhT+vhq1o+D2gjneDqk?=
 =?us-ascii?Q?u1AEuIO/30MmMXUaTLT0bcmmqgdwhgf2VFyHw09iV/BzictDfcDWtkY7iL2z?=
 =?us-ascii?Q?p8kN41FcuaBFgAUHSOBQ980b/C5qn0N5vcp71zvjWSAmz1bkL8HHK5z4byny?=
 =?us-ascii?Q?PVY/2d/jdjH1r42i02Pno2ypSAIob7/on0okimf2do5wF5SXyqIR2aIpimME?=
 =?us-ascii?Q?Eug2QFQkOoaQ3dKWeE8Hcp63Ud/an0hlLfC0gRA9d9kFQq14bVUaxxYnNzUG?=
 =?us-ascii?Q?Kmaaw0agG6DKzvQP5U+1FgP2wao6RJl8wiNDBUX+k/XKysRdQmSyySCYxx1V?=
 =?us-ascii?Q?EM3XOPbtvlpSx/S1SkH4aeTEQdJyGDWU9ODxj7yyBlSAoyf6Qk3k7g1a7To8?=
 =?us-ascii?Q?kSRTjfCuxFYwN7ngljqyEvlWbj2wEiH2DnEkGWGTxdQkKujc03TNpeSOUEQO?=
 =?us-ascii?Q?oJgjSLXh5gFLmBFyaBuMrSNA00bgjbKeknbxdgfdwOqFeaTS57gFSO/dtyXF?=
 =?us-ascii?Q?Pu7Zh801hiHViBR0JpVZG9v8cZPAP+IKDo/NckTY0BIGRGvt56Ch8Cw04zoR?=
 =?us-ascii?Q?uevvh59l9ivMJ6c3NJLNLQHgVM41MVt1mj4gA6ZJfsvA/tTnXICIKqA+zmU7?=
 =?us-ascii?Q?taLE5rcwcUCMxc6V0dBakFWi0XU6IiPl1+LwiFScON1xNAMGX17v2aKHHNPn?=
 =?us-ascii?Q?/ZOIARG0gNgcY+tP0bphe/+Iv2dwqVtW5/VyrjH7+OVSD332HttcNpISB+HZ?=
 =?us-ascii?Q?pYRD8jR/ZHfSVQJAYr/j+SVktSNVgVe6fg20v3Qu2iLQUz/vuPX8VXN3TYPO?=
 =?us-ascii?Q?rap/MbNcsSR8/yhx4X5fzOWEJ0fvcAoyKn0EPizH85psbg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(1800799021)(82310400023)(376011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 21:34:19.1631
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38fb7653-11a4-440f-31f1-08dc949567d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8488

From: Perry Yuan <perry.yuan@amd.com>

There are some other drivers also need to use the
MSR_K7_HWCR_CPB_DIS_BIT for CPB control bit, so it makes sense to move
the definition to a common header file to allow other driver to use it.

No intentional functional impact.

Suggested-by: Gautham Ranjal Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Acked-by: Huang Rui <ray.huang@amd.com>
Link: https://lore.kernel.org/r/78b6c75e6cffddce3e950dd543af6ae9f8eeccc3.1718988436.git.perry.yuan@amd.com
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 arch/x86/include/asm/msr-index.h | 2 ++
 drivers/cpufreq/acpi-cpufreq.c   | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index e022e6eb766c..384739d592af 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -781,6 +781,8 @@
 #define MSR_K7_HWCR_IRPERF_EN		BIT_ULL(MSR_K7_HWCR_IRPERF_EN_BIT)
 #define MSR_K7_FID_VID_CTL		0xc0010041
 #define MSR_K7_FID_VID_STATUS		0xc0010042
+#define MSR_K7_HWCR_CPB_DIS_BIT		25
+#define MSR_K7_HWCR_CPB_DIS		BIT_ULL(MSR_K7_HWCR_CPB_DIS_BIT)
 
 /* K6 MSRs */
 #define MSR_K6_WHCR			0xc0000082
diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 37f1cdf46d29..2fc82831bddd 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -50,8 +50,6 @@ enum {
 #define AMD_MSR_RANGE		(0x7)
 #define HYGON_MSR_RANGE		(0x7)
 
-#define MSR_K7_HWCR_CPB_DIS	(1ULL << 25)
-
 struct acpi_cpufreq_data {
 	unsigned int resume;
 	unsigned int cpu_feature;
-- 
2.43.0


