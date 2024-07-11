Return-Path: <linux-pm+bounces-10975-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D384592E4B5
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2024 12:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0CD01C2151D
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2024 10:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58947158D98;
	Thu, 11 Jul 2024 10:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mT1SzqLv"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2047.outbound.protection.outlook.com [40.107.95.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB0E158848;
	Thu, 11 Jul 2024 10:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720693752; cv=fail; b=Z4OfoU8FL9NJjOTghuoaqWuItlQLgWkgqRgXIBamYeqO9yiyXmMPZQQaYo5G+s1mdm7ufsbHKvSaoxkrqqg9pskOtGPNwlqxQBBAM3DO6Er1G3hJIh+++1G7RqwBcfGMsBLnf4Z/enqvvmPodjywsaLmUBybyNuisfqs1od49XM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720693752; c=relaxed/simple;
	bh=jjxwjpSIDFQutneFONkeSDsEjZqIAuJN1SIlg57ByYk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RhNdV6jD6NLQ8i0172AiLMj+lytVp1oKjITUktcT4VokFW84eTnDxS2oRGs/uoNPOtM7CrHemBEn+0dHBkU/mp6J5LJchftd8jgnzOmf4JfnIqQMievbN6fsmrnQzDOiq3m9ejslperYlJOXStEbMQxD5QV2QiDKcp2x6wH5f3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mT1SzqLv; arc=fail smtp.client-ip=40.107.95.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Na5L2OMsR2DZMzdGNq243eiq3QsBjx5+grytGBA/PUzYBiaEpo3skjmPLF0gCI12DekNAD2t2m/DKRX/BgEf87lC0euIf6YnrUiBEqjzKegDG/9UZn8qNQuqq5JumTgCT9Bk4c50j3hkX97RNak3ZzIeIUuQV2COSMZWdVxob+ttgpKUdQgE+L7Bn6Q2OwKdjzm+h+ngyS/KTTxcm5Nd5X0Mnymg7FsimUaJZSagCohg6x07TDiMboLdP2Lz6Zh4+/tmLDnxMMtE6j38xDME5Q7kCQgVJQmORrkoaobbs0BSpZHMjGbbBXK0CZG1fTZsBhW/BCJviGP5nbYJdAP9wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vPshdKt/fF0jFAO0KhsERHATLshGVzQ8svzvQSujM/Q=;
 b=l2H9mt0lqFnbeSueJIu9VaEmxWOpqc0deea55/Mi3WfCuhLx7Y+nZ3IHt9rnkf74SnVjqrvgo27SzCF/4xDLR3lihPIvVD06lDY1K9fladZFDrXjusPjqOlANE7y1PrYetWp5iS4maaq7lvreJBLnCs/D+A8PG7JUGypBP7yk6AagPvhYm3c4652D+QT4jEsuvXH8DEcX61wga3q4hA7GqP++ATrAVajrpUAiC7nAo5H98L5p3QwFEWPD9mtGeoAZrRaz6eLFO3fwwzBPqyEevaGeWhV+nAzHDvNEYcpYT5Ic58PtK72AfcqbZdZF0jNLhIxP9TQ8JrwcVZcC+2VKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPshdKt/fF0jFAO0KhsERHATLshGVzQ8svzvQSujM/Q=;
 b=mT1SzqLv25hccZi2uJfSGESPxAkJZf3f3rsjCGf2SVPfFM8oobgT5lyC/Iuovv1rOnqE8TzNks7UTFCLmJbLNtOw6qnOpYsZ/HGCaoBNF73y6IK0mXnKMoIfJ7nhP42ekauZWFQbZS1EpD+CO0tXvqAV6ZL21SFT/jQg6eZga+I=
Received: from SN7P220CA0013.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::18)
 by CH3PR12MB9314.namprd12.prod.outlook.com (2603:10b6:610:1c5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Thu, 11 Jul
 2024 10:29:06 +0000
Received: from SA2PEPF00003AE7.namprd02.prod.outlook.com
 (2603:10b6:806:123:cafe::ac) by SN7P220CA0013.outlook.office365.com
 (2603:10b6:806:123::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.22 via Frontend
 Transport; Thu, 11 Jul 2024 10:29:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE7.mail.protection.outlook.com (10.167.248.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Thu, 11 Jul 2024 10:29:06 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 11 Jul
 2024 05:28:59 -0500
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
Subject: [PATCH v4 05/11] perf/x86/rapl: Move cpumask variable to rapl_pmus struct
Date: Thu, 11 Jul 2024 10:24:33 +0000
Message-ID: <20240711102436.4432-6-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE7:EE_|CH3PR12MB9314:EE_
X-MS-Office365-Filtering-Correlation-Id: 2618600f-cf65-4452-1e47-08dca1944b20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5qY1FXIOmYT5s9i5arx0IReEYUzbGFLRztLuCnHKZWkEN4ZfEBbLsoa4LeKX?=
 =?us-ascii?Q?TNMvofDeSb9FUR1eaxDmXaRBiU/S0Vsh/6f7yQu3vdDcfv8l5Tmg7Gyqa/I7?=
 =?us-ascii?Q?U+k/X8Z8GxaSjmjRORo5ZK2CQzzD9x7Aab0Xpb3rGDbyYqD2MinpjYiSsz/g?=
 =?us-ascii?Q?m6Qryft2RD3hM14E2Zud1Nx8v7pOdVU05bmimD0ZnHnqvRFeZPQVA/x/v258?=
 =?us-ascii?Q?wZQ/eBFx0hucCaH6TuUueB/Oh7ElgD+L1DVZSkxjbYEdCgTRC55hpnOwufQZ?=
 =?us-ascii?Q?SdKpVbaCSS+/a5MzsCeFcJ8vicnt8eEOs+GUtOhx7Ij2pvfrx7XtTtIFljmD?=
 =?us-ascii?Q?XU3bnKWUN0iTqArlUyvXbqlI8W9qJCPOP5G+SYs8ygW1d+kMJ3SBtKN/bXzG?=
 =?us-ascii?Q?Zp2WP6B7m4G4fbHr3hrnc7Dc66FLNYs8v31n6VOUV8RpPItnn9jqwNPT7P4n?=
 =?us-ascii?Q?x+CqHe+MxZZhIPUqlKZHgUgmHdqFpHM84Z7YEAa3CzxohdAOFIrGq3WjZKfY?=
 =?us-ascii?Q?vBykSnpbIowNNLCMegpr0LrAba3/6OIkb/IVU2nfTAZ2ox4DmY9wFU9VQMmS?=
 =?us-ascii?Q?eOU42COutTSN59u5kLOTW7lSq2DdNqJIcrVxgMTGcqV01TV/f/JwJNWmqmK5?=
 =?us-ascii?Q?B0YB6YBKl/pLJ8H/dxcZw/ZDNZaYz6skzuvop4cg7Ac9PZhdPoeLHqEhvW9k?=
 =?us-ascii?Q?OOEUMeUry4bVSMQbsPeYe3047D2PH7oLePlzzAxPF8ZEPKJrz1B2y/awRbKj?=
 =?us-ascii?Q?wkND6CfSBBeJYX6tdtTHKPyJa72y+Qp6JsgyEgos+WmfHqSjOIpYgK4JnCxu?=
 =?us-ascii?Q?2Z7s70luJTME8CtFJl2N9i2Pbm7bqt33Z1VChlfFAivXIsMqtvW2Kzp/+dbl?=
 =?us-ascii?Q?rOa9mH1hWUuRKmSiH/C8I+TCcfeCuQsqQQMePhPwKWkSz4fNpN55I5L1OAbQ?=
 =?us-ascii?Q?3t3zqG/Wu/s9fVr6gZ7L3lVrOb/HhTopyVSKgFmRHRoTt5ClWHtQxOtAxpQK?=
 =?us-ascii?Q?iiRzn7dyPUJdP1O8o6asLGbH0E+YGmuALA4LVJDcKiz7X3SZDqfxPWog9153?=
 =?us-ascii?Q?7jT7gyBKba03CijH+gkdVnkWqdy8x9QpBaiySvRuVYUFNp2f/RITNarTIjC9?=
 =?us-ascii?Q?DhzfaBDSl62Fjx8eMeLtJ8Og7C1VcR+zknFG/6QVmETU340j9B+aERlBmFTI?=
 =?us-ascii?Q?44uF1vXUAAC8WRWCODh0ttJdGzifgiEd4K9sjWLW4KpFsIoaXzaa0idPhNZX?=
 =?us-ascii?Q?RyabHFNaVl0QR6Q1qmIwlkwtZiAo28u/3z+T0sPPIy0hcIC+vSEX0ittd55/?=
 =?us-ascii?Q?gGu2g7aB21nLm4g0wo8RnJp8rvbZlrpSiMMRXWzGGtq3wgMjSY/Vr1WLjWW7?=
 =?us-ascii?Q?QjqUPse4EdABxdh8U2NuPNFMvi3WhmOknNgS/S7f5Vm/i62RaG4oR4dAcZtq?=
 =?us-ascii?Q?1gPE8bM4+SDXpS8xQIRdjm6HH4pGck2NkfQHIbATq/0GWZ+qm3vEZg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 10:29:06.5208
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2618600f-cf65-4452-1e47-08dca1944b20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9314

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
Changes in v4:
* Use cpumask_var_t instead of cpumask_t (Peter)
---
 arch/x86/events/rapl.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index d231a9c068af..e3d0a82e12b9 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -122,6 +122,7 @@ struct rapl_pmu {
 
 struct rapl_pmus {
 	struct pmu		pmu;
+	cpumask_var_t		cpumask;
 	unsigned int		nr_rapl_pmu;
 	struct rapl_pmu		*rapl_pmu[] __counted_by(nr_rapl_pmu);
 };
@@ -142,7 +143,6 @@ struct rapl_model {
  /* 1/2^hw_unit Joule */
 static int rapl_hw_unit[NR_RAPL_DOMAINS] __read_mostly;
 static struct rapl_pmus *rapl_pmus;
-static cpumask_t rapl_cpu_mask;
 static unsigned int rapl_cntr_mask;
 static u64 rapl_timer_ms;
 static struct perf_msr *rapl_msrs;
@@ -401,7 +401,7 @@ static void rapl_pmu_event_read(struct perf_event *event)
 static ssize_t rapl_get_attr_cpumask(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
-	return cpumap_print_to_pagebuf(true, buf, &rapl_cpu_mask);
+	return cpumap_print_to_pagebuf(true, buf, rapl_pmus->cpumask);
 }
 
 static DEVICE_ATTR(cpumask, S_IRUGO, rapl_get_attr_cpumask, NULL);
@@ -572,7 +572,7 @@ static int rapl_cpu_offline(unsigned int cpu)
 	int target;
 
 	/* Check if exiting cpu is used for collecting rapl events */
-	if (!cpumask_test_and_clear_cpu(cpu, &rapl_cpu_mask))
+	if (!cpumask_test_and_clear_cpu(cpu, rapl_pmus->cpumask))
 		return 0;
 
 	rapl_pmu->cpu = -1;
@@ -581,7 +581,7 @@ static int rapl_cpu_offline(unsigned int cpu)
 
 	/* Migrate rapl events to the new target */
 	if (target < nr_cpu_ids) {
-		cpumask_set_cpu(target, &rapl_cpu_mask);
+		cpumask_set_cpu(target, rapl_pmus->cpumask);
 		rapl_pmu->cpu = target;
 		perf_pmu_migrate_context(rapl_pmu->pmu, cpu, target);
 	}
@@ -613,11 +613,11 @@ static int rapl_cpu_online(unsigned int cpu)
 	 * Check if there is an online cpu in the package which collects rapl
 	 * events already.
 	 */
-	target = cpumask_any_and(&rapl_cpu_mask, rapl_pmu_cpumask);
+	target = cpumask_any_and(rapl_pmus->cpumask, rapl_pmu_cpumask);
 	if (target < nr_cpu_ids)
 		return 0;
 
-	cpumask_set_cpu(cpu, &rapl_cpu_mask);
+	cpumask_set_cpu(cpu, rapl_pmus->cpumask);
 	rapl_pmu->cpu = cpu;
 	return 0;
 }
@@ -710,6 +710,9 @@ static int __init init_rapl_pmus(void)
 	rapl_pmus = kzalloc(struct_size(rapl_pmus, rapl_pmu, nr_rapl_pmu), GFP_KERNEL);
 	if (!rapl_pmus)
 		return -ENOMEM;
+
+	if (!alloc_cpumask_var(&rapl_pmus->cpumask, GFP_KERNEL))
+		return -ENOMEM;
 
 	rapl_pmus->nr_rapl_pmu		= nr_rapl_pmu;
 	rapl_pmus->pmu.attr_groups	= rapl_attr_groups;
-- 
2.34.1


