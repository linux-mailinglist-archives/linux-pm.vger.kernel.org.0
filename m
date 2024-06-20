Return-Path: <linux-pm+bounces-9666-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3969191055E
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2024 15:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBE531F21276
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2024 13:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACB31B012C;
	Thu, 20 Jun 2024 13:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="al+3bEEM"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEB81B0125;
	Thu, 20 Jun 2024 13:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718888516; cv=fail; b=JFLsS/5iqqaTI1/xcPiBXs94gfjFkrqZgCY6ZVyxA25fnnUvGCZnV1ETI0dtP6Q+ahVeDTxlUR8a9rpYmaXQT+WvVs58AWnPnOIrSedcRV3kdnII2zibyHfTz7ENFWHU0heNKQ7ZzWsDIoNt9CQxTfk+34Ur49r39LDm5ta43gk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718888516; c=relaxed/simple;
	bh=FbVldJAzwBUz/OiIKlBv24FGlyQJ3s39q84DqVs7d1o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JPAIvMQR+UvtuqKxcVFwcHOMTkKADkta+EoKKn852i8epz1QTlOWW97jU//g8qCpYxXQzCygX0iN9WhAIilYJbKHBw+yP7JJNFL5lc6DY/m5vwHLe57DDxfEsAAa873KQJHqzOuHdDYuePD7VDgBQT0XNRfdxZfjCLgrMEQIZmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=al+3bEEM; arc=fail smtp.client-ip=40.107.244.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nXCw1HR3RtvUTGjbcb6wlkwJotrXSk094QBX4ezJ5+NOvDDTPHXoplmWyhArJc0GR/R8AIuke3xhptNKhOr9DtMGdZ/Wcvi8US40p9EduUIEg/Oh27cyDBR+MiUoQBA2agfAYNHoAhHwtFb7uTmAp+c53Wq9wkVUW9Dbj7j10a/8hLY2rQ507wpoiSHiE9im3yFEA3/lwciKYovn4nxOL+JDFUzoG/iNuzkS38nHjJt3tuGQ2dfAVgB6RB+teFCEzaKueDJmUC0TZdTHIQ7Xd5cpK1uFJ2x7g5mFudnABihbahSH1NDDUYAnJ1uogm9WB5QM0XuglMTP4pcHq9ySXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3WSqqtWS5pLK7gm63CqzM301h8Bv9ShBNsN1dNvF7Fg=;
 b=itSyW2conT+zNmvfYgjWe5vnOlJVRT65+WA268YDL4S7y7TL83Lf2+qP76dyhqDJM56rhVDUQMBVqt1gzmgFWTsQ9kPRgtdQTN2ew5twZClz3zGxS0T8Hyy3At/crcn9Ewakyz3I8xwIrWOzTC1KOMsBlzxQ/36kJDJrrVV2vax8ET/XRxqtixTOpJNqEEWtq5nIxlPAzW5+rj9trN+dryEcGK9RLJHWjUQ3oHX4lPrkxb3/ai3fq/jYa3vvcrv4nA7vrL8tlozsIy3wbBdE8nBLjXY9AJjIDwWopDg4qvA2EuNK05ocorBvRL2Q0xEbmbJxjK4nc7/hZXJlXFrdTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3WSqqtWS5pLK7gm63CqzM301h8Bv9ShBNsN1dNvF7Fg=;
 b=al+3bEEMruG5txl6Vt4Rr530awRLP6N5a+HxA5rb7dBx7OM2XBsvt/HqSqwGY1Kk3rmDCnGuHwQPLBCkrruQY8osxfj1sEqbsF7wFykm/zOvVrmHcvp14YZcVVnFrHmReILIPvTae3TnFREMtTQK4eJmOcW8XEX/xnPnNuo7/yQ=
Received: from MN2PR10CA0024.namprd10.prod.outlook.com (2603:10b6:208:120::37)
 by SJ2PR12MB9243.namprd12.prod.outlook.com (2603:10b6:a03:578::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Thu, 20 Jun
 2024 13:01:51 +0000
Received: from BL6PEPF0001AB51.namprd04.prod.outlook.com
 (2603:10b6:208:120:cafe::45) by MN2PR10CA0024.outlook.office365.com
 (2603:10b6:208:120::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Thu, 20 Jun 2024 13:01:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB51.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 20 Jun 2024 13:01:51 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Jun
 2024 08:01:43 -0500
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
Subject: [PATCH v2 4/9] perf/x86/rapl: Move cpumask variable to rapl_pmus struct
Date: Thu, 20 Jun 2024 12:56:58 +0000
Message-ID: <20240620125703.3297-5-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB51:EE_|SJ2PR12MB9243:EE_
X-MS-Office365-Filtering-Correlation-Id: 155241ba-6da9-4438-e0d4-08dc91292701
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|82310400023|7416011|376011|36860700010|921017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ddXNMXxIo9KbfPEYjlkvk8nHOpBn439qKmVZ9h1miqmVTBAhMrY3HYL3gA9H?=
 =?us-ascii?Q?or3A8zv900bgM+UyfhZm2CZGHRhYoPnE5xTL2paklMKHerHlsIxlWMXxwelA?=
 =?us-ascii?Q?N+k3VVHVl/6/lCikx5xsFGddZla0AtZHdq+kA9WUffzw/1Qjh3Z85E3XFovF?=
 =?us-ascii?Q?gnu4Jpnoz/KIs4j+tHJvkdQClmvPJ+U4NG4ps7YXOplX2+v1nQLGOWzFIeu8?=
 =?us-ascii?Q?uZa/ha4z/4fSmhtR1GwAIJi9XH7abuTW2e30/JNoQHnbbBdILAz7KJJ7Q3du?=
 =?us-ascii?Q?lFHph1eVDCka2g315c2m9B4O1iAQH36KQrYPfF7TUURf/AFBn+v0VUQLAFFH?=
 =?us-ascii?Q?oPc8uj+M8E/gnrYvxU+PBVXGwXW4qMErcMQPtPaBqTkYggoI0wDJf+KtcHsI?=
 =?us-ascii?Q?s1ocURWEjkWJVIAsODApGodjhGtWyoW8/e0cnsG1yHructVPoK5dlmWXy2ZX?=
 =?us-ascii?Q?nsBtlGVIrAIBIQ2S5X2e9yDblISO+Ni5+YJ/AbZX5cld4ZZDQSrHH5OVgmGJ?=
 =?us-ascii?Q?qLr3CHPRY4viJFz7g1sDqW2ZqLRVnbPMTCNC09fdOkaEOR60KXRrS9gFqtwb?=
 =?us-ascii?Q?HgIBg2Ski+/ytp/9PezQGnChvNCBqbbxeeddlujZUXpZOJzm1bPHyQw+O03f?=
 =?us-ascii?Q?KXJxsvsFS1eDNuNdydWPXNPGD0m+Y5Wg3CQQS/PabEFUWbMUP+n+FJgfsKnO?=
 =?us-ascii?Q?RV1SFzGxsqaw3eB4U1aU1e7zZdhZOnuv6Ac2MlLRoOoMAzJ6sA9qq3WkI+Ns?=
 =?us-ascii?Q?pVd1dj0UTIL6Iwt7RbwPcoXWDk8pmO5N9e42YLlSpE1vl0jnF9gvYvbixoQA?=
 =?us-ascii?Q?ynYtuBjK+QpLc9VMY/xCGzT1DMNJS+0DtETbUqcjG0ZTglyIpu8/U2UnPUoU?=
 =?us-ascii?Q?GInMkBMoSxzhOc7G10OZX8I6qIEssGZkwJHG/iHZFFI1IL61bc54ZOnE9Kvq?=
 =?us-ascii?Q?XnW5FXVOX/PdfD/ylk3zRKU6Si8A/XW/Y73vNNyzPes3HVQUoRCDA42BskSx?=
 =?us-ascii?Q?IjTEMnCu85xTpLwyzQrsaPYOzuQbS82be5m65y5/xVnCRUF0ldwYLW35FVub?=
 =?us-ascii?Q?+bhJUwQqkr76EqLAeg/wPc7NKb7kr2cIw+/PEiend83dUBYC74wddmv4+72F?=
 =?us-ascii?Q?1McOq40LKdXxd8hGp/tzVu6pirNTiST0fAJT4gf6k5kaPUF01LgZlP7F4cAv?=
 =?us-ascii?Q?ILkeJlCQBE/NopJ8vQ24LD27BnOIsMhVyzpUxe6Ur3PFq532pZCTljTNSaRT?=
 =?us-ascii?Q?G8/MhFa77c6FgZvfrTcXii8yEhsxWvixrDM0lPLVnitejF7bLazZbf2CdSsM?=
 =?us-ascii?Q?ujf+c7iPZhaOrHwgvXw6Zrbqwv4+ADTYE1c7ZsQzajSBiTgovOVm/aAtGcwF?=
 =?us-ascii?Q?FicO1GLb17aPHo8910OxQMRNoR7y2VXtN7ZDi0FODvcAAc3f7SAmu9sfa4Wr?=
 =?us-ascii?Q?5rLICTEOhJM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(1800799021)(82310400023)(7416011)(376011)(36860700010)(921017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 13:01:51.3263
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 155241ba-6da9-4438-e0d4-08dc91292701
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB51.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9243

This patch is in preparation for addition of per-core energy counter
support for AMD CPUs.

Per-core energy counter PMU will need a separate cpumask. It seems like
a better approach to add the cpumask inside the rapl_pmus struct, instead
of creating another global cpumask variable for per-core PMU. This way, in
future, if there is a need for a new PMU with a different scope (e.g. CCD),
adding a new global cpumask variable won't be necessary.

No functional change.

Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
---
 arch/x86/events/rapl.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index e5e878146542..be139e9f9ee0 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -119,6 +119,7 @@ struct rapl_pmu {
 
 struct rapl_pmus {
 	struct pmu		pmu;
+	cpumask_t		cpumask;
 	unsigned int		nr_rapl_pmu;
 	struct rapl_pmu		*rapl_pmu[] __counted_by(nr_rapl_pmu);
 };
@@ -139,7 +140,6 @@ struct rapl_model {
  /* 1/2^hw_unit Joule */
 static int rapl_hw_unit[NR_RAPL_DOMAINS] __read_mostly;
 static struct rapl_pmus *rapl_pmus;
-static cpumask_t rapl_cpu_mask;
 static unsigned int rapl_cntr_mask;
 static u64 rapl_timer_ms;
 static struct perf_msr *rapl_msrs;
@@ -394,7 +394,7 @@ static void rapl_pmu_event_read(struct perf_event *event)
 static ssize_t rapl_get_attr_cpumask(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
-	return cpumap_print_to_pagebuf(true, buf, &rapl_cpu_mask);
+	return cpumap_print_to_pagebuf(true, buf, &rapl_pmus->cpumask);
 }
 
 static DEVICE_ATTR(cpumask, S_IRUGO, rapl_get_attr_cpumask, NULL);
@@ -565,7 +565,7 @@ static int rapl_cpu_offline(unsigned int cpu)
 	int target;
 
 	/* Check if exiting cpu is used for collecting rapl events */
-	if (!cpumask_test_and_clear_cpu(cpu, &rapl_cpu_mask))
+	if (!cpumask_test_and_clear_cpu(cpu, &rapl_pmus->cpumask))
 		return 0;
 
 	rapl_pmu->cpu = -1;
@@ -574,7 +574,7 @@ static int rapl_cpu_offline(unsigned int cpu)
 
 	/* Migrate rapl events to the new target */
 	if (target < nr_cpu_ids) {
-		cpumask_set_cpu(target, &rapl_cpu_mask);
+		cpumask_set_cpu(target, &rapl_pmus->cpumask);
 		rapl_pmu->cpu = target;
 		perf_pmu_migrate_context(rapl_pmu->pmu, cpu, target);
 	}
@@ -606,11 +606,11 @@ static int rapl_cpu_online(unsigned int cpu)
 	 * Check if there is an online cpu in the package which collects rapl
 	 * events already.
 	 */
-	target = cpumask_any_and(&rapl_cpu_mask, rapl_pmu_cpumask);
+	target = cpumask_any_and(&rapl_pmus->cpumask, rapl_pmu_cpumask);
 	if (target < nr_cpu_ids)
 		return 0;
 
-	cpumask_set_cpu(cpu, &rapl_cpu_mask);
+	cpumask_set_cpu(cpu, &rapl_pmus->cpumask);
 	rapl_pmu->cpu = cpu;
 	return 0;
 }
-- 
2.34.1


