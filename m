Return-Path: <linux-pm+bounces-9667-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01AB7910560
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2024 15:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 758281F237CE
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2024 13:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F9A1AF6A5;
	Thu, 20 Jun 2024 13:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GIpBb36t"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE391AD9D8;
	Thu, 20 Jun 2024 13:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718888541; cv=fail; b=rz5zyYkxkUdqZkK8AbC/NoLNgN+Ec+KUTz21vCOj74LhETjZrUmHgqTq9For9Hms3HRI4agsvLEg4RHMpDIvurrS2S1ruiQ1wv4ILCCDYXlEVuccmwLAqcGyjhWgPsx41N/nMjVeTXIbNOOIdwisKig/t20PLsmPHcFv8jomNPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718888541; c=relaxed/simple;
	bh=qS/Wq/wwRZfU17xl+lbRzk7z5HbMg+NLEVu+HvsuOXE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vk2SVeEHYsHxPHdMnILrq+KFCo1d3BKVrlRd5sjVQLsOZ8vHXNLcK26PQfzQ/RuifqSaNdCXPNA7dca5SOsnB9DmlTjzUK69k+eEQ5T/oX4zRAfYo8j2xHgnn7En8Ole6sItPRdFyjiMGLxv6mVvHAI8GWEN62MVy7twyqJ1zE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GIpBb36t; arc=fail smtp.client-ip=40.107.93.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CxQqFYpE85i6fDbfikDNC8USIapFJYve1g42gZlBl2cPVDMbfodW9Spwdy9/gsef6UWiSM2kB7pRC+ks7QOf+KIYE/X2oPcbA72Se6PYD/H8CtkPY4KF6+9j0nX5fX/GjGhU0QZXzx4uTvMlir8NsU4r6LRgpoC9GGVhnvELLARbxtpd+0ogV63hzj6fTOiwUvbanjlwmT8U576u903HNByPpdn+fyNHERzmRFv0cxVVmure+z8hUGreUhD8nrPRdOHOBdlRwgurn1ARuMkr+/vLWqwWJEOp+bqHrn5XfV3soe8v27JzmxD64v0fq6Wk+Yvpe+JoDfHdrUJAjOmz5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j6GYhfZK2/e8rYuOISt+j+ov/9zcEqHtJ6OJpZIqp0w=;
 b=T+c/J8X33mJT8mm6YPQc80ZBWdypdSgqPh0xxQRcd1kGinS1GWNQvMMA1s3Z2janC6Ss4dNkI+BIw9J93s41xOlbMPDkAXxd99TOufX2NBq7dfo4XulYSKDX33uzXO18vZ/dfdj4Op7ttqYpKYRW5mZiKGzfw/ZUaM3N4v5RmtjacaKhYvH84rM6MNj//UZ4OG6ZYLStmfZoqO4+ZInlWe51p9r8IVNCErn/7NgGK+3yXswi0LDuMjMFypvP894ZKCsRZRjBsajTKtkKMFbC5zqNyCZxpOXladuloTl0zk07WQ7jilqXjeFUpbz01nagjrAerVLutXCbJjQXMzvRuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j6GYhfZK2/e8rYuOISt+j+ov/9zcEqHtJ6OJpZIqp0w=;
 b=GIpBb36t8NZK2rxDBinomaxu/ZwVSvYNxAGgqQgf59VI9GH7bZJ95ZdrxXsn3NPBQawFf/6j3xmP4Bhs4+LSHVOtDpQZzhXz+/4oa/OMOyfbk6D+FQdP2tQ05aypUWScXVIXgPy1ytwBH2QkpAn2kLtUDdJ4qrTmyELNVj7Cwcc=
Received: from BL0PR0102CA0050.prod.exchangelabs.com (2603:10b6:208:25::27) by
 DS0PR12MB8453.namprd12.prod.outlook.com (2603:10b6:8:157::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.21; Thu, 20 Jun 2024 13:02:15 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:208:25:cafe::d4) by BL0PR0102CA0050.outlook.office365.com
 (2603:10b6:208:25::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.34 via Frontend
 Transport; Thu, 20 Jun 2024 13:02:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 20 Jun 2024 13:02:15 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Jun
 2024 08:02:03 -0500
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
Subject: [PATCH v2 5/9] perf/x86/rapl: Add wrapper for online/offline functions
Date: Thu, 20 Jun 2024 12:56:59 +0000
Message-ID: <20240620125703.3297-6-Dhananjay.Ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620125703.3297-1-Dhananjay.Ugwekar@amd.com>
References: <20240620125703.3297-1-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|DS0PR12MB8453:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f393b00-a11e-4085-c32d-08dc91293575
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|7416011|36860700010|82310400023|1800799021|921017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1UPhibH1E9egVayvbe1vGrpNUh8wtmdyKxhjxlRGDc4SRKabjGbbmBa+0Tu3?=
 =?us-ascii?Q?O2n1dG3oHu8DRHQogPJQJ7ItaPV0WqNtSjIG0QI6Opre1QkAUXPVtmR9i0PC?=
 =?us-ascii?Q?H5O6qs+xs5F1/x3ZOOvliXnKx7ejX2rYGy28Ugeo7g718VJ/oriDOZ43bEAP?=
 =?us-ascii?Q?Ze+gmVmRS39UGJ1JspzSXS1IdoLEmSja5cURA9YyKurgOaJf5AuHf66zJs+U?=
 =?us-ascii?Q?nc6VjcMA2Kg2joW13OSVILl/oJoRpUOACbniezmAp01gtIgjHqEoX8QUkbQu?=
 =?us-ascii?Q?z0j7Uzmq0DDfXVdP0iruOxYjZb9NjwZQuMouIcOT6Y1MG640u4fkd/oBq4x0?=
 =?us-ascii?Q?hSlnB1PmCO5Y5N8y6mn8ACS3BNTReZqpByUUwhw6vWRD1xjIx9iUGqhPpKHo?=
 =?us-ascii?Q?MfRQ9NgFnixwpiChyOMX4jZBn2DnS4LF1njbep3N3TnQpDOyGgc06u9aDXGP?=
 =?us-ascii?Q?8jeqwI7kr2RnxxTEUofqHccYHzqCxmI0QACEVx4Ibw7v4soz6VHjQPeVrgzs?=
 =?us-ascii?Q?FHm/0CvS3SDoYeYZNpCKsTNS+ZK6lCM1kpJGRj4QAfZd9DKfBlshcFqPmdzY?=
 =?us-ascii?Q?eZrZiu68GHVg8EanJiQtpVF4mWtA7MKTrzfg4Qz1bagOnH6DRwPoUTwQleQ9?=
 =?us-ascii?Q?x7ATcY43JnYt10IOzPqe2oX8ZVo7E04k5dYKAwrFXgCOBkAJrchft5/bqxx5?=
 =?us-ascii?Q?y1IHX/F/WPfyGhC0OPlCoqWu2TjCHO6Uc4yBacaGx5Ra2j/ZZ+Qo546xIYYQ?=
 =?us-ascii?Q?kVRavdSSaeZTLiVwHd0pk38Q7wV0nOdUI1BpdrPG9jmaPRrmQ6DbdtSpNF6y?=
 =?us-ascii?Q?BqFYuQ+CJi0yiKKBuvFzAxZzCJ/fbegg4R97BWju5gWQSUu9heL/bMBQKSXZ?=
 =?us-ascii?Q?qNIMv+3KW51UiaEnX89f14rFY7X8pha6By3rAndxvdgnV2IyeBYig7CeyjFe?=
 =?us-ascii?Q?rUWwd2Gp5MIjNNoQohu03KCTwKpbxMY8OysW9um/b9HsaFXt0op5a7r/Gsgx?=
 =?us-ascii?Q?AP41UwaNU2Y3HZPR8L9C6uPw23Z3HTeX9wATfl4PbOjwWWgDdtvBSje71Y0A?=
 =?us-ascii?Q?YDy4JwZL2jSMG3I8y0lJ2x3j8m4RAjlciA/3bO5hboW9xvneXwzJ7ocd/xqk?=
 =?us-ascii?Q?+b+2vJgoq3eusfkctithXOwDCLnBZ3TL5bl1/Ji+U0mcH2/ZlNsNlQFJ/K27?=
 =?us-ascii?Q?AUk1VTy0o7rJ6xyZAvNxx124mjXQfjI7goSlm+UGUD7n/beFwXdD4G2FYJUI?=
 =?us-ascii?Q?cXns0Ab+rYkl7CMtu9piIk4dNfG1UyU338lTWqdu9wl35xBA8/U1fGgRIZa9?=
 =?us-ascii?Q?suOsYUnRieWSN352KRNszcaaKsp0MMjh/govHB+SlrfJM6idG/udxUyYfjzO?=
 =?us-ascii?Q?lIvSR6ltJ/Q9tGDbcuiZFo2lD59kwKRsII5DSLVvFszKdx8Kd5+XBLAr9xRd?=
 =?us-ascii?Q?gkbVaByKKoo=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(376011)(7416011)(36860700010)(82310400023)(1800799021)(921017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 13:02:15.5583
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f393b00-a11e-4085-c32d-08dc91293575
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8453

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


