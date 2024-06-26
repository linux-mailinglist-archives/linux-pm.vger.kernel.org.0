Return-Path: <linux-pm+bounces-9995-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B3F917727
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 06:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 421781F23BEA
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 04:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1BA13AA2A;
	Wed, 26 Jun 2024 04:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BbLmLW2i"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1C4132103;
	Wed, 26 Jun 2024 04:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719375122; cv=fail; b=nsvlRZ7wxX9UeTQgz51+HL11A0EjnDwfHkQAxA8tZWDqjfPbiieiDiQJ+0JK70igCVO3oTdCXdMDaDXQki5LLsMPYnAQgI56POw+J5aZPdakxcLS5hXRYqjSMSs4uMpl3iiF50lMMv2qLEMo1VfPUC/csW3EtPAItV21OJNXCD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719375122; c=relaxed/simple;
	bh=ph/i/hOIECV3t+OXmUnLWiQBGQB3uE5uVzbJ552mBcU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HjEsv/kO5NRd3i9aI3j8kuzGq72R2dPdb+LQKDmdrDUC4OKq86LfG/nmxT+KqGbj7MiGSFHKPEAJeHtjJCbw5JG8ocj4i5dmk9EZ9UW+gImK26YH3jdOq1AVnJyi2Yw3n1HqbZT4rdlaGA6Y8wwjdward4kK7XE6cD+wU4rl9HY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BbLmLW2i; arc=fail smtp.client-ip=40.107.244.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l4AK2Jam22vdaStAMa5wCCpjYXaaWVdaSJaVSZT4uVk4nkIsyuU0ETZucPSNXFBnVc9JIL7x+fZV01qPEtbihV3J5F1KmKvZrP/YUmsKHDkLbIzCnpk3T0gVEkTio2eKDn1Nui81o2HK1xDLeBE278K0ewbGOz2b7rj4qq3nd8Smasidq6lgd7G8KxCYdcvDtZilHb558s88cyq34rgwFnHW+dt2AssLjMW5h/jeUFq/H6yMPd9JouGlGn5ov8pgiXRmex73l9P4qxVM09hl5ARxbMzLIy7H2byHbjYVNl++DLMguvJCPX/2RoKIecWuPtFwdcQPExMfOmQLnVT+hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+N0EqU9KJmRDxGTL7GS4daqqAccSP4Cq4bfiV/51jnw=;
 b=SufbdHPk59xCTwBhXxLPCKrIrPNT0xwIM1nLJ47HIt5uhz3NAaivg8X855STwANuO+GH2ydVqE7c6uAjhNpY7dVHmgoh8p4/DyLASrQfU0hGXbiDxfJbN0nof7e1JOsZS5GmdHsb34orzmBmvNuamGtr3Tncq96oKIU2dkgveW94XY1zlstliOj0bqs7ugK2h54eiXkja11T9NpnTzqilvgbKSyEliq80+M+Y30xv3EpW7PZSoXXRHAxMkdzyr9u0Sl0BYzsOnexC0P/vBUY6f4j8VrLJ+g7IK7mUxeWQvhqswAxsqNPSkglxj34EkBfIkMfeTBEIn+zeqpg94MaRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+N0EqU9KJmRDxGTL7GS4daqqAccSP4Cq4bfiV/51jnw=;
 b=BbLmLW2i4NpztoAucFJXAjAucy89wO5ndj5CG/Z3QHLa3E7L9IwfXiJ4WiaxuwK7OySWdU5Y1mamC87Q2X+IAuQgMk3YtwH7uV3uf/LNI4Hv1LnGO7klfF/dJ35g9A+DYy2hgQ3GS3DAb4vFZ4IaGsVIEja2HLORcrvn1PvU854=
Received: from SN7P220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::22)
 by CH3PR12MB9454.namprd12.prod.outlook.com (2603:10b6:610:1c7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 04:11:58 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:806:123:cafe::f2) by SN7P220CA0017.outlook.office365.com
 (2603:10b6:806:123::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Wed, 26 Jun 2024 04:11:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 04:11:58 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Jun
 2024 23:11:57 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <linux-pm@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Mario Limonciello
	<mario.limonciello@amd.com>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Sibi Sankar <quic_sibis@quicinc.com>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, "Dhruva
 Gole" <d-gole@ti.com>, Yipeng Zou <zouyipeng@huawei.com>, "Rafael J .
 Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 2/2] cpufreq: acpi: Mark boost policy as enabled when setting boost
Date: Tue, 25 Jun 2024 23:11:35 -0500
Message-ID: <20240626041135.1559-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626041135.1559-1-mario.limonciello@amd.com>
References: <20240626041135.1559-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|CH3PR12MB9454:EE_
X-MS-Office365-Filtering-Correlation-Id: c1c0a54b-2f3d-4bd3-b63c-08dc95961f72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|1800799022|82310400024|36860700011|376012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LqGjnO2zHJrjNfcwof3Kx1yYuzrH5PM6FtrQoms1gx1ZSwNxKLpJlVvR8W95?=
 =?us-ascii?Q?luri16Ekpq1vMH4VPn2Wth2mSVgAmrW++4kwEdPBtVmXNnzXElN08k43tv+W?=
 =?us-ascii?Q?wXHbdnEjKAsv7w0ybQ7SWAGhuTRMdM4h5vearsC+3j7xJMcODyd2hB5hE8Go?=
 =?us-ascii?Q?59o3vSO9kRpM9fYEKEKJ9Q9nM9VVSXjbBHzSH77JDhIW2FTzwtW/EPC++L6z?=
 =?us-ascii?Q?cr9zB8w8+9eMXgpPKti8BuKgLE6uH6lWlL1ly7Vqqq4nhffKQjtiB5oG1vQF?=
 =?us-ascii?Q?jkj8aXbyuFzUgOZH86lPKcEB4FTp4GvH0LoWZmltdxE9zIT6VzCHZxOYS/Fg?=
 =?us-ascii?Q?+SXWQr+BbuukXEbtSWzrJ8sKRNB+y2eSt15mFNrWiJr7OiVuQojcD7vxpLvm?=
 =?us-ascii?Q?nzc6U07KuKUvAuiO+CyADE/8kFFImBj3FrVZDytsSsn93VC2FGqRhohZCmKr?=
 =?us-ascii?Q?InUYdrj+AaJ5mGgTGvbL6VWenMMjO8czYMWh3pVvtejRbMg1OfzmSI1mZLLf?=
 =?us-ascii?Q?eu/GozyX7D34MvkaHOHd4eXqwzpr8xo5qxYiBsGYY70PXh60OY+yW0XKXPVK?=
 =?us-ascii?Q?bCp3Q+uo6F0hYNZNtdNFN6ze4mGWKMIp+6UC7s+P8cdmvc9pcaZ03sBDgB8P?=
 =?us-ascii?Q?TDGjZl16IJAAbbWSqGN20rlLFiiOEtbYpQSvI/UevaS6no+25dPaEvHnS6sJ?=
 =?us-ascii?Q?r8nQ7cJMLA8s5GxvjeujfH3ZLPE/Pb3lKygsXiJsO39NUQRmqKd5hwVFw5Eu?=
 =?us-ascii?Q?hQ/Y5mJIFipMSUYSs1IsRg9a+o+yiOZ5Cjy2mzqr+hDtri5dBdGu+0SEzdza?=
 =?us-ascii?Q?HZQiUz0PX6ddB9PHPC0WWtivi4TST798b1ZdVE0xbVHFmtZTCpH38eCBXo7c?=
 =?us-ascii?Q?e3LuGmO9vZwPvllja3lOZPIymfIGTt2NrJoiZX1RcME70EDrUNm//U5ZA5H+?=
 =?us-ascii?Q?cW6BptoVxp7PPnqAunJlr4yHjkfsIjy8uYjeiMKB5RgrFKTpU6+HuHYiGkK5?=
 =?us-ascii?Q?rXc/p8ecBTe3BxXG5TGDCr0LdfinMJAlMI49opvqZTuO693YtYsdvJayyFt3?=
 =?us-ascii?Q?k7eKeiF9TNv+Wf9uAVtaTPSnQHqYNDXfCUXORhM9w9WeDoOidkt33aUA9mf5?=
 =?us-ascii?Q?MTjEtO5u44Y9sq3WHRC8Yv/Bwg+TSGVmhsJiYL6LS5G9v/GXjz4swVlJkq5Z?=
 =?us-ascii?Q?oAEBaZyZerMKFmUt4GRoTXgJbvfzEbC5Aj8IiXHpWBqXTTeab5ddbrfOszAJ?=
 =?us-ascii?Q?q57FLMm+VH8DbL1Y+sTfEZ8i/weP5f/MJYRQ89RW/zI3P82QtZNUkmUmdE6a?=
 =?us-ascii?Q?OkuQbiMbTV63NEB6s5dZk6gix8ZsjMT1iBvlRU9L1+V48QrT2IOd560vTW6y?=
 =?us-ascii?Q?5rRMliFbRvmN8JihNwwAjqrCNgqTWUyc/lTlfSYULLvQneu7f2xGV+tpSpIo?=
 =?us-ascii?Q?ka/XV9PaZWN2kSoelriXQ5B7Yd/nVWrF?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230038)(1800799022)(82310400024)(36860700011)(376012);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 04:11:58.4231
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1c0a54b-2f3d-4bd3-b63c-08dc95961f72
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9454

When boost is set for CPUs using acpi-cpufreq the policy is not
updated which can cause boost to be incorrectly not reported.

Suggested-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
Cc: Sibi Sankar <quic_sibis@quicinc.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Dhruva Gole <d-gole@ti.com>
Cc: Yipeng Zou <zouyipeng@huawei.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
v14->v15:
 * Use Gautham's suggestion instead
---
 drivers/cpufreq/acpi-cpufreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 37f1cdf46d29..bd3f95a7a4fe 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -139,6 +139,7 @@ static int set_boost(struct cpufreq_policy *policy, int val)
 			 (void *)(long)val, 1);
 	pr_debug("CPU %*pbl: Core Boosting %s.\n",
 		 cpumask_pr_args(policy->cpus), str_enabled_disabled(val));
+	policy->boost_enabled = val;
 
 	return 0;
 }
-- 
2.43.0


