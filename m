Return-Path: <linux-pm+bounces-10976-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF29192E4B7
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2024 12:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F05201C2120E
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2024 10:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7720158DA7;
	Thu, 11 Jul 2024 10:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fhxHwBvR"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CC814D44F;
	Thu, 11 Jul 2024 10:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720693776; cv=fail; b=NKRUWZTA9jz/giqtb9KSAJ5pbgGJ2NVSNknNeRCNqdN5H30+lOzmwAPm9Qp+uNPfDP7RlUNSr8aCaeMQVHlzH/QB4l5DIccapSwy3/HyMC/RyiZfyvBDu8oYqqRM35S9mjrs/HMw4A7fpwqvsVBbJprAbGnisq1bTYjWwAd/inU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720693776; c=relaxed/simple;
	bh=omifWwMgL75tly7bRNMfyrMsb2mGwm57uU9jhd6MT+I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kk4n85qQH3TQsyr8E98d7M8oVt15ub/aAdAYNao/3gR+vASBgKCwrrvQPh3ya84kBUF1H/3qKe8r5lENn5+ptlGxpYG655em6Kc5dVvS0WgdhIgsM7rHO1/vMvxnck1Y8cJHPDmS6CS8sRzQaSIIcKjR/hJMUBAQT3TGGPgAGOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fhxHwBvR; arc=fail smtp.client-ip=40.107.92.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JQHUJi83apgWv3+YU9HxhWrML+nfsbIxXNETVoNPLDyP/8HQgPLWo3n7aIxWoUVt1Q0Zj+FYwHnF1XaJS+7xqReub0X5UMajjGON16xEictIpet6k1sSuCqEnexervyKdnfwKmeJMrseXE5IlR9DG5q7dyH5kRdEzS5teW2/OvgyFpESjtZEdDV6uNP9HtdygHsUEvvcY6czzPuYZMTjxbYjgL61jwICCIxvkadArf4WYcHf9NmnWPB+r09+YsZcU9eD3QNqhYGWY76AuKcPF6BTyV43EHPwM5hWBSQeV80zALKgmXB+xbk5vhJngLMwvT8kSjsGeLnTzOMik7Wcog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V2o5vVrSzegCXlx7d4sKaxeoqAOh8OXb8m9Fv7s/wTQ=;
 b=UWnzPVzF3T1yKIciACp3mEyD0PE1yVlofuRNS2Rh1JcglGZdbAiZicTvA7UE8coQNRxMTxYf+l6+4E+MngXXZbJ1hrOE4Sh9gN3gP8Y4mU4tUa/ELmahbapPCFJC7xD6TBeglXiFen258OJByqJ3ueMkt61U3bw943M9GWL2xiYzgYlcAaW4FaoJPP7pVXy+aD9ODkeleTR6s6zGgkjffmJq5qMA0DoPfTs5fAAJQVrj3UqljvZUS/1SFxW7TIeCni/U9CVw0+RaVW/vLyklFJnVWE2yG9zmMJx63Z63/gdzBW9CmONQueYf4K0mYk2OJ9yJBjdbF63Tnc6fK+Rbow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2o5vVrSzegCXlx7d4sKaxeoqAOh8OXb8m9Fv7s/wTQ=;
 b=fhxHwBvR9++kDYlOZA0vAc7QA4ujn/U1y8QU9T79pXtLVhJ3mUSNjraOlx0mEPgiIkNvnsl16LFCf81LN8a2+Lrw0sZhpHNdrBU3Wd1Qcu3fU+RULlPre6yoGAEC67V8rj74vPCgpF0uHGYbqpr1kio2GyvwEA6hshnFpb6bz7k=
Received: from SN6PR2101CA0005.namprd21.prod.outlook.com
 (2603:10b6:805:106::15) by LV2PR12MB6013.namprd12.prod.outlook.com
 (2603:10b6:408:171::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Thu, 11 Jul
 2024 10:29:32 +0000
Received: from SA2PEPF00003AEA.namprd02.prod.outlook.com
 (2603:10b6:805:106:cafe::f5) by SN6PR2101CA0005.outlook.office365.com
 (2603:10b6:805:106::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.12 via Frontend
 Transport; Thu, 11 Jul 2024 10:29:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AEA.mail.protection.outlook.com (10.167.248.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Thu, 11 Jul 2024 10:29:31 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 11 Jul
 2024 05:29:22 -0500
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<tglx@linutronix.de>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <kees@kernel.org>, <gustavoars@kernel.org>,
	<rui.zhang@intel.com>, <oleksandr@natalenko.name>
CC: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>, <ananth.narayan@amd.com>,
	<gautham.shenoy@amd.com>, <kprateek.nayak@amd.com>, <ravi.bangoria@amd.com>,
	<sandipan.das@amd.com>, <linux-pm@vger.kernel.org>,
	<Dhananjay.Ugwekar@amd.com>
Subject: [PATCH v4 06/11] perf/x86/rapl: Add wrapper for online/offline functions
Date: Thu, 11 Jul 2024 10:24:34 +0000
Message-ID: <20240711102436.4432-7-Dhananjay.Ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240711102436.4432-1-Dhananjay.Ugwekar@amd.com>
References: <20240711102436.4432-1-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEA:EE_|LV2PR12MB6013:EE_
X-MS-Office365-Filtering-Correlation-Id: f7521a8c-a939-495a-fb8c-08dca1945a26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f0pAssa8JLXYAC30q0eSNp1QgUC45+vuPhUc4YtF6o84t9EUeAMIvwzzoNKs?=
 =?us-ascii?Q?9y5kBnEhqaUHKC0xsnlaqoX/Lqhs5Pib38IXivjoEk6Bpp2QYAt+2JtZbMcQ?=
 =?us-ascii?Q?4l25Y9ItU8ZKcFUTN34FoPYIhdAuhosvIiCl9Cuyh2R4M7NYFSUSRUvQwJzO?=
 =?us-ascii?Q?H+bYvIiHqB9RzrZl5Ypls60q9N3+DAQ8ifJ1WP+vmRrjpZ0Qb1fBiTLvo+eN?=
 =?us-ascii?Q?UlQyLvuUi1g3ZoKCxUtnvEisfeSQBC76ZRlx97NgFn40XJLpEqJ180rda6pl?=
 =?us-ascii?Q?7JvGUna7RZQ1qqJQwNhC3APlKdX+QUDgtMCsFgnEUt3zPfpcTPOIHBqcsa/G?=
 =?us-ascii?Q?uttZrFQXUIHUCSnc8VWK7fEZJb4idtjZKotOQAzTGxVA1IxD2xTnGsM483XO?=
 =?us-ascii?Q?fC0Y2wnIabQwKAJBbZAhO3TsxcQGxE+w1eTmbgx8jkFhsPcI/PCBia74NBZS?=
 =?us-ascii?Q?w2ytJwu8n62Qt3znzvex9Kd6woEy38YflmqpZMVZDx+fJmMKscDGVaZHRBLO?=
 =?us-ascii?Q?s6iTUm6VCgs7HWzLvOGdg0ht1vUUaDP7rmn2g+6BfsjEq09m1f3LvgycUria?=
 =?us-ascii?Q?FnZXR7Dg+TmkShGWPes5EMIg0jONzECyIyyGf9BRZCCUhifAZVT/kKMgj5QN?=
 =?us-ascii?Q?736UN7/u5hDspVniGyleZ/JcSKSwWa6ldlE3zrzXfiXJoAA4xreV5btCmYi2?=
 =?us-ascii?Q?ThLoIkz6le6NGjNMaJYfGs7i96RNCm558IcSHYypRJ6cmhU83NF0D8gf9ijN?=
 =?us-ascii?Q?EeDAg788tovWelbToJFGfj6qe8iayMRHPk3UCxydnc+Tl2cwm0jrc39OqWDs?=
 =?us-ascii?Q?UoHnHKwJSYrwEtfN/M1byMpGx2JnTcuLQSBbaW+w4d29p7hoHivZeFXcU77W?=
 =?us-ascii?Q?zZeKJzMyC9V/y6tYogbHaAmUSfc23zOq2gbzcnDwk9NwPWiKJBCvB964Dzzi?=
 =?us-ascii?Q?ito2caRQ15/8m05K15p7QrCRQy9aliv1MG7CO8v9m9weOkZGWl1yFSy+l+qO?=
 =?us-ascii?Q?U9LHHKLIKW70km3e8xPkcEz942ze0UsODJcPBWpsy0RN2vwHO8086rH5y3pl?=
 =?us-ascii?Q?wymo9dyTyb3mMKccK6SKi9mB2sLQpOBEYo0l8jRPX7n4ZHJZ1qm5QDZzdnQ/?=
 =?us-ascii?Q?NJOHaAnGXzqO6hhVAF0SXfZxUj506O2bpJ+MdcPs8DXWkJC2GxCRsr4uwA0g?=
 =?us-ascii?Q?vnjq/PlUxx7acMoqu4O+x6t3iF6ZBlV9Vp8NyQHZOA0SyvvRIvFeuXoZMfTp?=
 =?us-ascii?Q?Ea3M7lnRBuUCiKiTgZhCEK14HXF4Hh8yRPh+4wbQeYtDb6h27Z2ch+drWzs5?=
 =?us-ascii?Q?YKxWPYBXWRcEjL11pHl8BBYETgb4oyOj0CHximpV/2LmmAMguxuT+zNV03k3?=
 =?us-ascii?Q?fVHGx/oU9nvTCWFLcIl82htJRtb+LnfwEkco7S+yDIiPaaCOnyXRB4bbAcuc?=
 =?us-ascii?Q?q4kPLLVKJlNjLWLuH5wB8CDwKYVvLpPG/kiK7Jef1S81FxtwVWru6Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 10:29:31.7003
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7521a8c-a939-495a-fb8c-08dca1945a26
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AEA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6013

This is in preparation for the addition of per-core RAPL counter support
for AMD CPUs.

The CPU online and offline functions will need to handle the setting up and
migration of the new per-core PMU as well. The wrapper functions added
below will make it easier to pass the corresponding args for both the PMUs.

No functional change.

Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
---
 arch/x86/events/rapl.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index e3d0a82e12b9..1d36565d0cb9 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -565,10 +565,10 @@ static struct perf_msr amd_rapl_msrs[] = {
 	[PERF_RAPL_PSYS] = { 0, &rapl_events_psys_group,  NULL, false, 0 },
 };
 
-static int rapl_cpu_offline(unsigned int cpu)
+static int __rapl_cpu_offline(struct rapl_pmus *rapl_pmus, unsigned int rapl_pmu_idx,
+			      const struct cpumask *event_cpumask, unsigned int cpu)
 {
-	const struct cpumask *rapl_pmu_cpumask = get_rapl_pmu_cpumask(cpu);
-	struct rapl_pmu *rapl_pmu = cpu_to_rapl_pmu(cpu);
+	struct rapl_pmu *rapl_pmu = rapl_pmus->rapl_pmu[rapl_pmu_idx];
 	int target;
 
 	/* Check if exiting cpu is used for collecting rapl events */
@@ -577,7 +577,7 @@ static int rapl_cpu_offline(unsigned int cpu)
 
 	rapl_pmu->cpu = -1;
 	/* Find a new cpu to collect rapl events */
-	target = cpumask_any_but(rapl_pmu_cpumask, cpu);
+	target = cpumask_any_but(event_cpumask, cpu);
 
 	/* Migrate rapl events to the new target */
 	if (target < nr_cpu_ids) {
@@ -588,11 +588,16 @@ static int rapl_cpu_offline(unsigned int cpu)
 	return 0;
 }
 
-static int rapl_cpu_online(unsigned int cpu)
+static int rapl_cpu_offline(unsigned int cpu)
 {
-	unsigned int rapl_pmu_idx = get_rapl_pmu_idx(cpu);
-	const struct cpumask *rapl_pmu_cpumask = get_rapl_pmu_cpumask(cpu);
-	struct rapl_pmu *rapl_pmu = cpu_to_rapl_pmu(cpu);
+	return __rapl_cpu_offline(rapl_pmus, get_rapl_pmu_idx(cpu),
+				  get_rapl_pmu_cpumask(cpu), cpu);
+}
+
+static int __rapl_cpu_online(struct rapl_pmus *rapl_pmus, unsigned int rapl_pmu_idx,
+			     const struct cpumask *event_cpumask, unsigned int cpu)
+{
+	struct rapl_pmu *rapl_pmu = rapl_pmus->rapl_pmu[rapl_pmu_idx];
 	int target;
 
 	if (!rapl_pmu) {
@@ -613,7 +618,7 @@ static int rapl_cpu_online(unsigned int cpu)
 	 * Check if there is an online cpu in the package which collects rapl
 	 * events already.
 	 */
-	target = cpumask_any_and(rapl_pmus->cpumask, rapl_pmu_cpumask);
+	target = cpumask_any_and(rapl_pmus->cpumask, event_cpumask);
 	if (target < nr_cpu_ids)
 		return 0;
 
@@ -622,6 +627,13 @@ static int rapl_cpu_online(unsigned int cpu)
 	return 0;
 }
 
+static int rapl_cpu_online(unsigned int cpu)
+{
+	return __rapl_cpu_online(rapl_pmus, get_rapl_pmu_idx(cpu),
+				 get_rapl_pmu_cpumask(cpu), cpu);
+}
+
+
 static int rapl_check_hw_unit(void)
 {
 	u64 msr_rapl_power_unit_bits;
-- 
2.34.1


