Return-Path: <linux-pm+bounces-8858-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B047901EFE
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2024 12:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4E4AB2828C
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2024 10:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC4F770FE;
	Mon, 10 Jun 2024 10:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RbloV99+"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBB775813;
	Mon, 10 Jun 2024 10:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718014210; cv=fail; b=NiZT9pqme8L56ABGzkaeGB6naPhRIyfMwjd8WWHY8tM+zAdbLZ2DnnpC7T3oEaPgtIdOKk53hKaQgde9LgxOb9Ryw+O/37k64/UstmTVz3iVZs8DRK8tg7xzcyZw75iETVF8NISEn2bfh9Xwd4TQqOSLZ/SAFozLw0pgQeXV4RI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718014210; c=relaxed/simple;
	bh=sKa+6Oml3qc2aKAlIW8Xw8a3d8rh2qf9bUcsvD2ryOg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hydq2eEtxTOEc5jueLv/S8bTe2U7ubnBnibtC3Chy1GyhJczjfnLWj+dWBcKdVwKvMRWbHWq7+PoUPwFX73zX2piVwRZuAJD6hrImKo5DYxH6dubvTLcgzGZ5ifT39WmjBVc7ChuSXJQqcr2IhPUWvMnUDe5kC7NIuLmR29jopg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RbloV99+; arc=fail smtp.client-ip=40.107.92.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FeAPrLYqsNdlpaWpx4MU18WyfXu7E9ENv+scN9sXE8L0eojpzsxITFf6HwxzvsdQQ4BRaRgidcDFouxA1cpGEqHBKKsKxNv9PGf9Kh1KuFEpklEKIZB18wKZMHYOz+K5NH3+qTob13Kue3vp/QpQmGb4+SJ8flYakKgtVqk1VIdBM29QfSIELvlyiHka5muabPFTHVS1ZDSULkkaLx6IMFhuuf6S3bGfgy/ND45bRF/qasyT+2Ns1lsjWWlLPfXZFqKjqzyUUE60MDOkulle2aZbHEcloUNhwipl73pzCziqBaThH6q0JkbI5NhZezxaNinzovR4Yb9xgYOOrhZ7kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WY8VqnGdrPq2J+1erPP2h4cwKHwAaA3xpfyFLY5wwxM=;
 b=F6HNInch46zteiMp2GBPM4t1mQpInNCndYbBpD19X+NKgJ/ruVvhPi1yG4+gmqkC+OdF2bdcoC+8lGVTohw2L0MLrf0LdZcX8pJorPZbMExrJG19ZLntmKp1+REhgbapooLgX5Vxlat4sqe0UIH9Fp/cfp6zKTONBMyHjVx8jY5zr6w4iNDMB6Fwq9TPITB2SIOqmkYD44mlnZZSMedzVnheaW8mI1Z3vojE2S24/Bko6fdfeb7W0vk3KxMlRvVvlNr60kDllHpejImXNJnJvlUaTpdcNMZl6wrm1zLWT0XE1HcZANbezjj7FQV9Ioy0iET1Ch0aNnDV/t+qomykIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WY8VqnGdrPq2J+1erPP2h4cwKHwAaA3xpfyFLY5wwxM=;
 b=RbloV99+7Ch1dU5D9toYn9jRNqWXD7yIvTinskL6na08LcO9Ow9H6F0t8ugN61ASo6tRrIfs+FGEbJWgRKxiPvt5I1NscWaziv8zlxpHcUzgiAmyr2btH3jRmtQFibR7G0EmzMH62MDmN14b8zK57i60Soetykp0kSfFfnbHt0E=
Received: from BL1P223CA0008.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::13)
 by LV3PR12MB9258.namprd12.prod.outlook.com (2603:10b6:408:1bb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 10:10:04 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:208:2c4:cafe::72) by BL1P223CA0008.outlook.office365.com
 (2603:10b6:208:2c4::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.25 via Frontend
 Transport; Mon, 10 Jun 2024 10:10:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 10 Jun 2024 10:10:03 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Jun
 2024 05:09:56 -0500
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<tglx@linutronix.de>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <kees@kernel.org>, <gustavoars@kernel.org>
CC: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>, <ananth.narayan@amd.com>,
	<gautham.shenoy@amd.com>, <kprateek.nayak@amd.com>, <ravi.bangoria@amd.com>,
	<sandipan.das@amd.com>, <linux-pm@vger.kernel.org>, Dhananjay Ugwekar
	<Dhananjay.Ugwekar@amd.com>
Subject: [PATCH 4/6] perf/x86/rapl: Move cpumask variable to rapl_pmus struct
Date: Mon, 10 Jun 2024 10:07:49 +0000
Message-ID: <20240610100751.4855-5-Dhananjay.Ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240610100751.4855-1-Dhananjay.Ugwekar@amd.com>
References: <20240610100751.4855-1-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|LV3PR12MB9258:EE_
X-MS-Office365-Filtering-Correlation-Id: d17fb615-1163-48a8-ecc8-08dc89357ef8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|7416005|82310400017|376005|36860700004|921011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LLQur81gOWvjUVOOXrZZs9sqgJLAsvj2oD1AV1mx/4RsTi+UPsP/YEWokYQj?=
 =?us-ascii?Q?4DFwY26hF9Eoca1aE1XdHSi8lEgtfg2Re26VUMSWUb7DTo94cLCP/EypESFd?=
 =?us-ascii?Q?yjGz9jDywci5ceFscGtPPkPPfhAVtybUfG58+oKNOZtRHbN4YMv2hJlyF48C?=
 =?us-ascii?Q?/9i+vH3JjXO1DDMUgSIYbiRv2XnZ27Z2xyHnBD5jA175Jo68wxZ+9d1tVOqn?=
 =?us-ascii?Q?NDQZuFqHgmTfxwcqgUoDp2DxOXz2O1BmWfYft4rwxhkWFtX4LMkB1xcC7C3+?=
 =?us-ascii?Q?FlfCe9KSEZnJ7vlJwHRITj+JEh9BgN/5kzgnCEsXasYLDhVgf8MihfBNivWB?=
 =?us-ascii?Q?XHeB1GJHjhuu3ZS52D20x0lDJHUWadtPHIWWhgRCUht4nD0ueEPo12aWcThs?=
 =?us-ascii?Q?H+esRp2mMI9Pw0cxUAosQlQ2E42C8q6h7qh2+DPFuRyzjiIMMOgHhXOq1rJc?=
 =?us-ascii?Q?xt5y8GoqBy2VhhOKSoEBpCPh+uWYJ7GZ/zPWmZf5ps/rc9/R0cbL/4h3/TI0?=
 =?us-ascii?Q?C4o0ZmE6lRvBsViv0oD0id28T50Tszw720GGQvnntyhj1MwIBYHZlt5fsT8W?=
 =?us-ascii?Q?dWtZ8FJDD7lEPpjYML3oqMIRDO9HMtwGQcxRV3jjYXaQtM2amajedBE6OmTP?=
 =?us-ascii?Q?6VqOv64XqZeQ5UjVctCpWLMq2R16mKl0KLe5P0B9833F+EA2MaRruvs8KWHw?=
 =?us-ascii?Q?0lwIYdxIAguRaGS4nUaOo+vqG696FAdKbv5SexwogLpsMokQr6LuQoXu02xV?=
 =?us-ascii?Q?AWmgj/aS8IYIaQMTbI3qFJbrmkIZcakST/DvhnxpAweQZhygCnOKI12b7XAk?=
 =?us-ascii?Q?SSA+pFd/4lK4aj7k2eXjG8547F1W70mvioU4/GgKdiY6G5oYd2pbl/qsqZG3?=
 =?us-ascii?Q?Q6seXqsskSkg34piK2E2mcj5pBPMsfRpGGwbkebfRGoP8JJR7CBGNpdoIrgX?=
 =?us-ascii?Q?VJ2aaeTOFQiYmIRZnXb55hCaRWN8IdphqbQ+DEBveVXDeCROES30eHmm89Mf?=
 =?us-ascii?Q?ekAWMWNMKh0Y6SwHYmY5Ut9b08QuyiegeuHr+4WlHmRbb4+w3qsWI3L7QMA5?=
 =?us-ascii?Q?UgP/11wcP63gcVfVbvQLqKrT34H4OyBIfcO88xT6P3jtDuNzUqntTY83uB05?=
 =?us-ascii?Q?AcHOPx4A76E4goqYmlKZ8xyyeua/j6lGuOV+xDRCHd2Yp19zRMDzV8iqSw5I?=
 =?us-ascii?Q?OQBqDopD7svmH/RqIgq+cDif6p6s3WTxlpMSVTnsiH8ZGqqsZS0YvQMlypr2?=
 =?us-ascii?Q?7/JHWmZPm9Xj6a8l6zVuZYayVmmPH0Pfj3et4MYmBujF+LlvPULYkr9i/Ay8?=
 =?us-ascii?Q?qW9gZfLkjmmg3xHXj0WCOBpwZkkGOlHcpFpUa47s8twhYL3TyuV4k03jmPwZ?=
 =?us-ascii?Q?7NWIHe9d78nesbJTc6+FKvHcXeHZwFMrdQCLj/jHHS9Q+I4Iudj4okQj2YiP?=
 =?us-ascii?Q?auIhKHUR9XY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(82310400017)(376005)(36860700004)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 10:10:03.5501
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d17fb615-1163-48a8-ecc8-08dc89357ef8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9258

This patch is in preparation for addition of per-core energy counter
support for AMD CPUs.

Per-core energy counter PMU will need a separate cpumask. It seems like
a better approach to add the cpumask inside the rapl_pmus struct, instead
of creating another global cpumask variable for per-core PMU. This way, in
future, if there is a need for a new PMU with a different scope (e.g. CCD) 
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


