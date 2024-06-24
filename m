Return-Path: <linux-pm+bounces-9872-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D80891426C
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 08:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B67121F2468D
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 06:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC181CA94;
	Mon, 24 Jun 2024 06:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jfJUcjba"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A3F1C69A;
	Mon, 24 Jun 2024 06:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719208942; cv=fail; b=KgANARGAhnBUoNQF5LC8xEiSBFi/+p6xY1d+xCwQEnqPbfPKqrpGjyI9GBLv5hu5kBakqVCH5Hov/IIYfmkf+l8yy2DZfKlZiS0CTMaEZDZ8Ft8r+rO5rDHHtUp8Q6U9IPROVi30rQQIyU/6f+YHCKRFbBUkwmjUB9Q1k/BqfmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719208942; c=relaxed/simple;
	bh=qS/Wq/wwRZfU17xl+lbRzk7z5HbMg+NLEVu+HvsuOXE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QxcWZrQDjMJYBROvyIWuOQ7ObyWSuDeXgfyi+Z4XrjMrWC2rMiQ6BGdDYbjS2pTBU9ciqWbLFeA4fS0lhvi3a5t2h6WNQ5uLdV9v1AHga1GAhKbJWnrb+dx3OL9HJ1W4Fro0tZzCRrrNnZZGeco7YoC0LcTT5RTYvn7Jf6ugD70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jfJUcjba; arc=fail smtp.client-ip=40.107.223.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GA0mxkBYHuFFQkSOGll/JOwwqEhQ8OcqVUoMutQiGtlB1hQpItJlHS7ZuSEIlOoTFUjJSA5w2uLeezI5nsnUTJ9/dE53AN42TCR2A/iASblZW7DgHbDTnkFW76eztwjlmegf5r5WAoAAMGEdpVoupYfBCg85zyDiEd4V1MuBSjaHM7ZgFB/okfTrSFc3gl2xFxYXjCiIPCMm7sG4VBTjRV7Q/ZMCmNJPC/wQSNS7T8Qwgl5aYyrBi97QHHG/w1eKy8H7Kt9hq/Vf6hk61sntr7Bk9Ziqj0If7S2o+eRoQaQwsXHikMlRZFHdjWlqKCcsoygV3sIJVFtmZTGNvG/tBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j6GYhfZK2/e8rYuOISt+j+ov/9zcEqHtJ6OJpZIqp0w=;
 b=ebJehWXpsBj1cCjf7dNEm4c4f+t+WxWpUVI722oPFD9eMD14ZXATK0JmD8xLNVSccvhRFMNg2quypsGPU8LUG13N05dIB2YiQ4C2n+2a6JPSlTWvIMq9kaVZLLGZ3VGJ8tQKMc4s2np9eO0Sy64CsXbuLOxrnLBEDqKQ6LC5kOcAj52MOYOmf9vrUxPQqHxkNeh2MrytwK3wDj7efSwmKEFB4WMRsBMffSsbqb+LUREhDxxmWdx7MV+0maWT+jR1d/ATF6z7mrmMFfvh5z1RQNc0Lrrm2UBndc4vpzlnOZCP+Fci2RLHpueivy1qs8ITL/ubfGcPTr+H2Q1XXd1zyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j6GYhfZK2/e8rYuOISt+j+ov/9zcEqHtJ6OJpZIqp0w=;
 b=jfJUcjbaicIAbirD2qa5rRDGggyslqjmX9LUS63cfE9H9dfgm2lNRspc6GxBIKDnvOnlRSnzB4opXfDi6yTkKq+rfHO5t3x9/UgD/NthEc4jYFvhU9XWrX8D58SzeCom/2I2gNmtFjI9wEfFAzvF/aUmpoNn7wzSulY3UoI6UIQ=
Received: from BN1PR10CA0012.namprd10.prod.outlook.com (2603:10b6:408:e0::17)
 by PH8PR12MB6747.namprd12.prod.outlook.com (2603:10b6:510:1c3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Mon, 24 Jun
 2024 06:02:17 +0000
Received: from BN2PEPF000055DE.namprd21.prod.outlook.com
 (2603:10b6:408:e0:cafe::db) by BN1PR10CA0012.outlook.office365.com
 (2603:10b6:408:e0::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Mon, 24 Jun 2024 06:02:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DE.mail.protection.outlook.com (10.167.245.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.0 via Frontend Transport; Mon, 24 Jun 2024 06:02:16 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Jun
 2024 01:02:09 -0500
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
	<sandipan.das@amd.com>, <linux-pm@vger.kernel.org>, Dhananjay Ugwekar
	<Dhananjay.Ugwekar@amd.com>
Subject: [PATCH v3 06/10] perf/x86/rapl: Add wrapper for online/offline functions
Date: Mon, 24 Jun 2024 05:59:03 +0000
Message-ID: <20240624055907.7720-7-Dhananjay.Ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240624055907.7720-1-Dhananjay.Ugwekar@amd.com>
References: <20240624055907.7720-1-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DE:EE_|PH8PR12MB6747:EE_
X-MS-Office365-Filtering-Correlation-Id: 93ad435a-0f0c-4628-8878-08dc94133390
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|82310400023|1800799021|36860700010|376011|7416011|921017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?smrnxDQ6Bj2oTvhLcOqQXoeqYK5pUGJ9UW+zMetbhifFO2mCGyQ8Hw6WjNAl?=
 =?us-ascii?Q?63gX5LpKtwNCl+bAaLzhIuSvsU0wPkrla9670KWblLOrxLSZWsMa/wpvuJxq?=
 =?us-ascii?Q?td3XcANzhA2qkYKBSkEZan8+OBvym6/VWaZ0yvloH10YHIsbJ07Ii5m4Y5oZ?=
 =?us-ascii?Q?psLGtzu6KeCo5likbWEiejJeanAf/LUYoSZyz009GJxjBr73IJjanUuIDIuO?=
 =?us-ascii?Q?iAA1PdealnVEGF2saF8MFxmXohz2oFtLvVsxeDOV+PXg5+v4nhRXUv6SiVqb?=
 =?us-ascii?Q?wTBjTi2FeUqwrzdmLlFedzBYZ6LijfpWg+RxbhIRXbS8Ev/8Or3VgcLh1rc3?=
 =?us-ascii?Q?ZxbOzjwCAdXmXayBP9zhKI9ED3kw6klfIPWjmzgRWa3GStOdIGWUXVMNTjDf?=
 =?us-ascii?Q?pVpPBwBpWbtHdtRbdg6ZkQ4MxpC0IJDqRvozL6wVQroGyHTOvnFB6kiSKfbD?=
 =?us-ascii?Q?hH3RXcXurxjlignmHlUpyH41T8Phwwxji7ETWFGMd4wzpud3/7ne7/LOuShb?=
 =?us-ascii?Q?03My184LcU3adW8Vs2HdrAZHc3To6ouBGCZg1cjqARgPd1jgtBuVioyTonQx?=
 =?us-ascii?Q?XURuyl/wasue+P4cS5gxWj1LeWfmU5OTaYeNjOj0++lCwIrIRsuH4QkVjc0F?=
 =?us-ascii?Q?JutGtZqpzAATmfRHVWFiNNBcP2FK97KRDPujOH65VKGk/C3sN0Ey2nFa2xh+?=
 =?us-ascii?Q?ZWgA3KWyHH81XY5V2QZzyHwmkQpYlKtm+JPc3jumoYT5sDdLjL1E3Lma8q1B?=
 =?us-ascii?Q?ucaxg2wV7CMGw6PQrBGGFXCkTO1dhh5lqqW5cD2nEQ4+O2iYThpB4rtFFDfU?=
 =?us-ascii?Q?KTiX2EHbvz+faQ9Q2KdxrPSCbIBRoPgCdhOvHjsZS0vpQCf/6PIFxCnOM/T/?=
 =?us-ascii?Q?yicoJkfDFeesAjGqSJxzO19XTjHINpIJV5aPs+ykDWa+YOguslUbZFJ4FuBQ?=
 =?us-ascii?Q?ph/hjrfSiSfyXGvUDNLxMKlq+ua8rG0Alvs6PQrR+K2iiP+dAThUeILAzNK6?=
 =?us-ascii?Q?jxeUTEMjoTLWiY0SV+E/hpn1lHZ3EVC2M/yHhPNeBizgdETbCFs4gYD8dS6a?=
 =?us-ascii?Q?GA0qCwf7BiqjVHvQey6zJHZedMrVd3s3S/+kUz0IB3M7FoQYIU0Xhc3SsN20?=
 =?us-ascii?Q?9HjMJihbe3QK3PVoW7Zly2iYTzViMfjhBwMbmctBJhI2ce54vyhL8y6OPjgZ?=
 =?us-ascii?Q?S8SH7bCfyeKe1Gna36JgHaha+5wJZRW0OZWw7ETKjwz5HTx9BgJz3bzYmk7p?=
 =?us-ascii?Q?LCvacj7+OeV2PPsjTEb+4hZTUcfyiM8vEltEfl+0Wm9fjH/2sXs9xOfXEhIZ?=
 =?us-ascii?Q?sBxOl0suYJNwRWWkveLkFfZ0NnR0UUXd1PRd1FRVE4z9ezLh0r/7Cfn2UVVD?=
 =?us-ascii?Q?UcwdaCM2B8240lFwxQ6ePLpPMdcoBQFxREWUJacHUMcV30mvowG5tEJEZ4e0?=
 =?us-ascii?Q?ubsnh8VTbGc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(82310400023)(1800799021)(36860700010)(376011)(7416011)(921017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 06:02:16.9229
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93ad435a-0f0c-4628-8878-08dc94133390
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DE.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6747

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
index be139e9f9ee0..70c7b35fb4d2 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -558,10 +558,10 @@ static struct perf_msr amd_rapl_msrs[] = {
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
@@ -570,7 +570,7 @@ static int rapl_cpu_offline(unsigned int cpu)
 
 	rapl_pmu->cpu = -1;
 	/* Find a new cpu to collect rapl events */
-	target = cpumask_any_but(rapl_pmu_cpumask, cpu);
+	target = cpumask_any_but(event_cpumask, cpu);
 
 	/* Migrate rapl events to the new target */
 	if (target < nr_cpu_ids) {
@@ -581,11 +581,16 @@ static int rapl_cpu_offline(unsigned int cpu)
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
@@ -606,7 +611,7 @@ static int rapl_cpu_online(unsigned int cpu)
 	 * Check if there is an online cpu in the package which collects rapl
 	 * events already.
 	 */
-	target = cpumask_any_and(&rapl_pmus->cpumask, rapl_pmu_cpumask);
+	target = cpumask_any_and(&rapl_pmus->cpumask, event_cpumask);
 	if (target < nr_cpu_ids)
 		return 0;
 
@@ -615,6 +620,13 @@ static int rapl_cpu_online(unsigned int cpu)
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


