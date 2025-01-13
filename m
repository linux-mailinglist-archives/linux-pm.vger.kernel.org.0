Return-Path: <linux-pm+bounces-20288-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFAA5A0AE7D
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 05:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8551161077
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 04:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D825170A0A;
	Mon, 13 Jan 2025 04:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tHO0uebs"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0E82F56;
	Mon, 13 Jan 2025 04:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736743297; cv=fail; b=eTdV6NmuVKrWy5L6aEo3bL8hKhGPXfxoYH7KYrlFwygSoW/rZj0dMBZnb0/suUXUoIxvtie0iU1Qh5e5w0Udj2SPo479lm/XjKO/Cf7Bmy5rc2CcJ9j0TiQ/0VnQkOK6SfLsJyo5vTDwtkQ7XwLnIPwgS2L8WRzkQqLcsFOOe4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736743297; c=relaxed/simple;
	bh=r29RHFUVIL8h8Hhk9J2YxwWBX2IZzlaFypfn6BydsPM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gLQnHuVQAAvgPr6311C3SrUTJcM2ZgTEL0/v18itm6Jfe0BIAPWtdVweI7kwN5AIU0sK3v8VIKWnyxROqvCvqOgnR47GbGse2u3Y9NSL7VTtwhOEeupEbp0nxJiTxQZC9PFLwHVlnK6k2j8/BLpKre7x0oAfKxx/tseC42f3cRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tHO0uebs; arc=fail smtp.client-ip=40.107.223.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mc4F+Y6+puC6ovk2MiURVm9UYvDL/cQUqvJEKlOe9mADtK91zex9F/6LIYXbcJ9StMMCdnoc5PDuy7amg32xp6wyrIpx3COYWzn5LVp7s5tno8Cq4xId4R+i3SVHDNL8CD9WWqz96q6+y0os4V51+qlkmY0/WtOyRxSAtJl0EOV9+5XoZI3KIMMaEE9D6wzrpfXNAS8C3Y4nnJDEMh9cA5NKNLaFEgQ+ttQoWUUwtBrWobhxZTcEgqZIyyR/PEvay4pu9+0GIEylwozRgio2PTwgkY0bMI7tRtKJlCNLgDcw0smD3UDLnRjuBH5gQ/BsjBi8HqecctP/dpu6kxL0QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LVboevyEFnP+mTgNuEpCVZVKW9azmsSR3xZBhdh9th4=;
 b=eTgcVHRtA2LjLCFX+M3oleE7kaJ1WQ2QCBtejrqcn4xLxcXro4XRrK1Yuq69vJttkoDziGn7+MHbqwdsdz68DESgfB5Bfew/MbW8YJagxBMT5O3wmSa1TM/Z6O7MP411LmcPGVknc7Qkuxb53sRXS7BA1v2HqnXdVxvBRuEb+JjxedhS7A5S1eQGV4bFz0r17xT4LDN5Xv3d01WlFn90AS6ibU+Zsz3y0fM7jiE3J6nlXFJoRtVYkZWK66uyHMcJIGBvM2JnR3nUKcZntQyyflzwEglBsa8LW6VOUHDqPUWa1A9AlIzgvnQB1jzU3wwLGgitLIhdIc7VYVCXQhip5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LVboevyEFnP+mTgNuEpCVZVKW9azmsSR3xZBhdh9th4=;
 b=tHO0uebsH5gyR9CYvcsM/noiIeEHyThO9ZQfgFAGsKxUfchrSrZ4ZC/jPy2oUdMa9fovaURkUWTAUMMnAMplmq7L15OpUaXmq3VX38G054+8Dk3LJqcNDGOiet/eie3wZm9Z3rm5efrBHZ/TCRBcuoyYn3ST3o+d2AUSVaVDoos=
Received: from PH8PR15CA0023.namprd15.prod.outlook.com (2603:10b6:510:2d2::22)
 by MN6PR12MB8591.namprd12.prod.outlook.com (2603:10b6:208:471::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.17; Mon, 13 Jan
 2025 04:41:32 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:510:2d2:cafe::ea) by PH8PR15CA0023.outlook.office365.com
 (2603:10b6:510:2d2::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.18 via Frontend Transport; Mon,
 13 Jan 2025 04:41:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Mon, 13 Jan 2025 04:41:31 +0000
Received: from BLRRASHENOY1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 12 Jan
 2025 22:41:28 -0600
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, Dhananjay Ugwekar
	<Dhananjay.Ugwekar@amd.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
	"Viresh Kumar" <viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Adam Clark
	<Adam.Clark@amd.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Subject: [PATCH] acpi-cpufreq: Fix max-frequency computation
Date: Mon, 13 Jan 2025 10:11:07 +0530
Message-ID: <20250113044107.566-1-gautham.shenoy@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|MN6PR12MB8591:EE_
X-MS-Office365-Filtering-Correlation-Id: 649105c0-a4e3-4b19-f6fd-08dd338c8d59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q/385HxkBA2BEjWbgFMcIVbxpn6lVUt8sjzRp3aSY/QvcaonZAhdyv1U+eaF?=
 =?us-ascii?Q?U3m1yo4hK/hGcYKKHMxur3g7CbQw/FXxlw5kJj2iJIcctb07VAI0NVV0Z9pH?=
 =?us-ascii?Q?CH4rltFATgADLym7BplVD3ZPrD7J7y2tkOr0b01KwbGagHR/B54A2JlMo6AZ?=
 =?us-ascii?Q?u+poSwvEa2We7ZaJ3TirCpazoBZoKJ/P3QKQYtgWaa9CmYAMWrCvIzQZGtuU?=
 =?us-ascii?Q?Ya3j++tuifyNqaN9uUjmmwMtNjL5JSfw1AKiUXJOjkc6IQOzsTOWbBbybz0N?=
 =?us-ascii?Q?LrTAXs3NyN3H7gMGUvMAdTAAwjzj9vx8NMk9jhPFjdWu4adfVAropXGzJcUK?=
 =?us-ascii?Q?+6wOlI2qf2cYF9C9SGAscWVRD7LtRxThUhadhJQxAfZXSrl3LMBdsvlXldj7?=
 =?us-ascii?Q?AuAZW/7wqWeOR11FKO3b1CWBZy/dHfuuexGHwD6gqPC+px28yRzij43lacF9?=
 =?us-ascii?Q?kOPRBL09Gm7Hy7tRA5Lo0Tqve/BoTT633NXvwApJeQlLLgaH4XVvJ4NPI42c?=
 =?us-ascii?Q?97pqTGIfbnqLqHGchddQPs6fNdRpoVER45xh6gwUKPhGnZjpHqIEhnUh6fkE?=
 =?us-ascii?Q?0g3l6r4i4e/Bu3qcr281P3o6rsZZMvJgkRVGREyLKOJHmmAmg2eRGw00fdWZ?=
 =?us-ascii?Q?4xCH0PjVmlB8zZhYXyJgiI+PmgbUvtAkOesFh5laAkjyl3TJrc8opy/83vHM?=
 =?us-ascii?Q?9Gkik9AsdlGR20oadazb6s0zSH9JsjH4kW49mQcUllkaEcg1gvBFJT5oO1wN?=
 =?us-ascii?Q?Jt1ElSWSE88D0ZZwOKfeBUaMGMi1G+YjvUcCbaKRiqfMiuUXgsVoocFOWNc9?=
 =?us-ascii?Q?+TIVnbD9qqaJxBtO7ZerLh2MnnuMVkJKP2vQT1VR45NlzLolFynoPGb+P6Ol?=
 =?us-ascii?Q?aRqh8eMxAi6BwAD7tuyZj1XdueamfiGGygXd1XcPTaLNuoBjrCGILPBCJloI?=
 =?us-ascii?Q?NuTlDjbyvr9n7Eqp4LxPGR2a4OrOEERLzJ+hr+XW9hsxEhjurpP1ZTXU8sNS?=
 =?us-ascii?Q?QqgYnenL70TPf2vIXiXq40EMhf2wR/dbBlLUEyCuyBiHDiP8NOPasy9bFufi?=
 =?us-ascii?Q?xiRIUN8UN/6as2ohTvK5j6Q2YZi+xRbBaWK8XWXg+36qqA7QiVk80xtgNm74?=
 =?us-ascii?Q?GgnXzNq+m2OKm8VgrF8YwHrJLLcoFvShKsrjs+BOeG2UZvhSZaPIlQdTTl2l?=
 =?us-ascii?Q?q8pPl1TSdcoj6M2kJJFudS4Q6vosyt3i99v7lZxX3NuBkAV2+MBLHCt2ezGP?=
 =?us-ascii?Q?RsDA5YRfTF3iOfuiK2+V902n3vOPeGwBg0z+QqSPZWlr8gpXpJ7bOSFEdp2e?=
 =?us-ascii?Q?zeRpsUaDkh6rWlSt5WhvLWwFvrB225i6VJSQJu/9UINDvm4uTZQ2Pi1Dxdi0?=
 =?us-ascii?Q?DjqqnZHdbo6gn3IAU3bloyEjYKwpLzQNa9W876VbE8cSxxxCz3fm65rlY1K3?=
 =?us-ascii?Q?7qnRnYCeA1hM104k1SEgBBv9rBFpRSaSPsfTZ/6BzcpH1lnYW4zyLwd/Kc1/?=
 =?us-ascii?Q?J1kRyC7AtA55MFc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 04:41:31.5618
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 649105c0-a4e3-4b19-f6fd-08dd338c8d59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8591

commit 3c55e94c0ade ("cpufreq: ACPI: Extend frequency tables to cover
boost frequencies") introduces an assumption in
acpi_cpufreq_cpu_init() that the first entry in the P-state table is
the nominal frequency. This assumption is incorrect. The frequency
corresponding to the P0 P-State need not be the same as the nominal
frequency advertised via CPPC.

Since the driver is using the CPPC.highest_perf and CPPC.nominal_perf
to compute the boost-ratio, it makes sense to use CPPC.nominal_freq to
compute the max-frequency. CPPC.nominal_freq is advertised on
platforms supporting CPPC revisions 3 or higher.

Hence, fallback to using the first entry in the P-State table only on
platforms that do not advertise CPPC.nominal_freq.

Fixes: 3c55e94c0ade ("cpufreq: ACPI: Extend frequency tables to cover boost frequencies")
Tested-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
 drivers/cpufreq/acpi-cpufreq.c | 36 +++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index c9ebacf5c88e..744fcdeab173 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -623,7 +623,14 @@ static int acpi_cpufreq_blacklist(struct cpuinfo_x86 *c)
 #endif
 
 #ifdef CONFIG_ACPI_CPPC_LIB
-static u64 get_max_boost_ratio(unsigned int cpu)
+/*
+ * get_max_boost_ratio: Computes the max_boost_ratio as the ratio
+ * between the highest_perf and the nominal_perf.
+ *
+ * Returns the max_boost_ratio for @cpu. Returns the CPPC nominal
+ * frequency via @nominal_freq if it is non-NULL pointer.
+ */
+static u64 get_max_boost_ratio(unsigned int cpu, u64 *nominal_freq)
 {
 	struct cppc_perf_caps perf_caps;
 	u64 highest_perf, nominal_perf;
@@ -652,6 +659,9 @@ static u64 get_max_boost_ratio(unsigned int cpu)
 
 	nominal_perf = perf_caps.nominal_perf;
 
+	if (nominal_freq)
+		*nominal_freq = perf_caps.nominal_freq;
+
 	if (!highest_perf || !nominal_perf) {
 		pr_debug("CPU%d: highest or nominal performance missing\n", cpu);
 		return 0;
@@ -664,8 +674,12 @@ static u64 get_max_boost_ratio(unsigned int cpu)
 
 	return div_u64(highest_perf << SCHED_CAPACITY_SHIFT, nominal_perf);
 }
+
 #else
-static inline u64 get_max_boost_ratio(unsigned int cpu) { return 0; }
+static inline u64 get_max_boost_ratio(unsigned int cpu, u64 *nominal_freq)
+{
+	return 0;
+}
 #endif
 
 static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
@@ -677,7 +691,7 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
 	unsigned int valid_states = 0;
 	unsigned int result = 0;
-	u64 max_boost_ratio;
+	u64 max_boost_ratio, nominal_freq = 0;
 	unsigned int i;
 #ifdef CONFIG_SMP
 	static int blacklisted;
@@ -827,16 +841,20 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	}
 	freq_table[valid_states].frequency = CPUFREQ_TABLE_END;
 
-	max_boost_ratio = get_max_boost_ratio(cpu);
+	max_boost_ratio = get_max_boost_ratio(cpu, &nominal_freq);
 	if (max_boost_ratio) {
-		unsigned int freq = freq_table[0].frequency;
+		unsigned int freq = nominal_freq;
 
 		/*
-		 * Because the loop above sorts the freq_table entries in the
-		 * descending order, freq is the maximum frequency in the table.
-		 * Assume that it corresponds to the CPPC nominal frequency and
-		 * use it to set cpuinfo.max_freq.
+		 * The loop above sorts the freq_table entries in the
+		 * descending order. If ACPI CPPC has not advertised
+		 * the nominal frequency (this is possible in CPPC
+		 * revisions prior to 3), then use the first entry in
+		 * the pstate table as a proxy for nominal frequency.
 		 */
+		if (!freq)
+			freq = freq_table[0].frequency;
+
 		policy->cpuinfo.max_freq = freq * max_boost_ratio >> SCHED_CAPACITY_SHIFT;
 	} else {
 		/*
-- 
2.34.1


