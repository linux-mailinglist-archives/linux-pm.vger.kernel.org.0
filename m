Return-Path: <linux-pm+bounces-10974-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD86B92E4B3
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2024 12:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 948D22816FE
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2024 10:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D7C158DA8;
	Thu, 11 Jul 2024 10:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mKwvcYCs"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAFA1586F5;
	Thu, 11 Jul 2024 10:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720693732; cv=fail; b=e4pDqQ92HsR75wvyYtW6i1P0MmiEmMSbp0WAXvrB2VcVvZAPENx6DzSQy8aDBfgXhIvG+35Ng6FcCJ91y6k0O/H4igLtcWenjdyKZYiX0+O7IbjjqCKSsoeTBWJfHgPQKY/CYVg83VVnGo4y60drgWu7Ei2gLGM9uynm0QTCwkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720693732; c=relaxed/simple;
	bh=BGlL3wKkjX1ahoEXEoOMehGxN0nrWF1fTc5vtApf8bs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iPeVly2+ZlgscR6wvevY+gbBPDimnCBl+n+WZEiOgCgj4Kd/uCB8Oy/YBJ2xAJshQqlZrUi6rS7FxwzrONoAH+SosffJj2uQciikLDcYlqczzMKU/HbhelZqIMIxHvDufNMpKk0srNyW5CBDOzxaYBnuHiTvago6pz83hGXNUFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mKwvcYCs; arc=fail smtp.client-ip=40.107.237.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WGzOkjkT4FnG5n5s2O0LA+6jQs7xTvrWZWOUrhavqTbHiX1Ml4t7VmDkUMeqZl0fMeLhelIIT/IagfGhWegoJwxpZ0MNSmO4SSfPhUhfVxMigFalhgm7Z5iQQTxg1aRBSSzpewzXp7vv/oWYmorNlZMM8tkTuogHCiQrfhgOqNdf45WDZxUCFOZgECCjecwTPyhv8YPqRo1S+w7Wlmc5ln6P+33BXyALGnrf/ez2BN6XwrL49pfDJCeTzUkzmn7Czc5D3+dW0Oeu/PQiag/5YqCyd3Zc1f6aNlNKgmwGWZrlfAAOKKeJZyTIGsqvnZDTWqeT1sr3HrByYU1SoewIMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QwvKzhiCu8RUG++KiyHsiIQq6fkd/iM2B2yf3UIOWqs=;
 b=Po+Id89Ql8e7cT7yKoRrVSjWdSqEran8lBGDAz+cJs7hcyrqvqh7D8QGKnHzQz1wQhXfG439PDcMDMLS5KTgVhZgZzuPdfjiJOo0c3zCdosUHJI9R0bR5E4+n0o1NI4HKxdGGiCrF88X5PBHvEMYs6lkmr0lSbvgMjVfv6Zo1nZv3Ww3Gw4qPm1O0c4ScA68UcUlxA6PQpCQwBF8BBo+5ggkKODF+mfDKnD/kkgFpfD7bN0MWAGdQfoQZjRDU91t5DO72sbv5IDib4l8rHQ3Ku1v5NC+rIpb2wGNA6qfMEHUkLB5QC5vLM4dvZs3tLv2dAm/7hYegFjR/w1UIX/wBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QwvKzhiCu8RUG++KiyHsiIQq6fkd/iM2B2yf3UIOWqs=;
 b=mKwvcYCsibFuXG/SoGCROQoo950RLEZRb0qfyIDD2Pf5xMecEY4/E/zjDJiRcDQQkdonkc6J1r3DClZ4d9UXDE0UaEFOADgQSOWU/xTRZmg5C2VhDyR5/QHYQnyRxuDQP5b1ZaGEhsEeTkzbBB+esdX2yMG3DgK/iUVwIKlwFdg=
Received: from SA0PR11CA0173.namprd11.prod.outlook.com (2603:10b6:806:1bb::28)
 by CYXPR12MB9428.namprd12.prod.outlook.com (2603:10b6:930:d5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Thu, 11 Jul
 2024 10:28:48 +0000
Received: from SA2PEPF00003AE6.namprd02.prod.outlook.com
 (2603:10b6:806:1bb:cafe::32) by SA0PR11CA0173.outlook.office365.com
 (2603:10b6:806:1bb::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23 via Frontend
 Transport; Thu, 11 Jul 2024 10:28:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE6.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Thu, 11 Jul 2024 10:28:47 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 11 Jul
 2024 05:28:38 -0500
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
Subject: [PATCH v4 04/11] perf/x86/rapl: Make rapl_model struct global
Date: Thu, 11 Jul 2024 10:24:32 +0000
Message-ID: <20240711102436.4432-5-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE6:EE_|CYXPR12MB9428:EE_
X-MS-Office365-Filtering-Correlation-Id: 70ae9840-6cc6-4a4c-371b-08dca1943f8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A92bHzRfxvni/+0xNpYjNKodt/MRu24cQsOkLCvZc0Yzvhpgp9Q1e72JXUnF?=
 =?us-ascii?Q?xKmjW0yQRNLMu1ZoKUo3hhfkNGMIbeKB0XrS9kkCo7fJeDblzX9hRScvPJuu?=
 =?us-ascii?Q?0a+bLzDuxjosmPqv5jnyXBg/l7Z6vFFoMrHnjxTX0gxm+0evifWgTK7tIKfC?=
 =?us-ascii?Q?oH4qHyLPBcyJ2b8Tfv3phOJ3pJZRtY6GhugTuc5zF6SKh0q8HqPk3lGWQpbE?=
 =?us-ascii?Q?FoUMKSSRRqmrzwgtQLCm7u9XA16UGZoBIN4EO8ml33jzPPLcLxQtn4aeg0hO?=
 =?us-ascii?Q?rND54vqoXzhzPOlhXWWCu+w2xFI7wDPR6+gnMCftTtY86oMFs+8Sf8IXMMIG?=
 =?us-ascii?Q?9wHHqg4iFZLMruZPDL3Dm97yWD6rrziXaKnjmrpqg0wKFetxJMF3sWGgaBiN?=
 =?us-ascii?Q?EKhCl7WF/uid/BKQshUidnoMBYL2MZJvqLELkmMibPIzCc+UU32OXoQK3oZg?=
 =?us-ascii?Q?2bWNkVHh53FWafU+XpWaAznm9vCGrKzQSrzcU/rZR3BxTb6IWfAe8njkog5B?=
 =?us-ascii?Q?716+/H8aw3F7It4I0cn6Q+GBY+z9G5FblAA9227698q3/lxhgAyi7OorlFgi?=
 =?us-ascii?Q?/lvONG53q7FNvdB9E9qmttWFTfJRk0w6bYskygdMIS1Ia3zLSz3JOOUGDpb3?=
 =?us-ascii?Q?1g5NVl4c/Kxu3azyVRe3jKg+RtK9ONI2ZB2sr6V1qvRjl8VLSft6byQDRJYw?=
 =?us-ascii?Q?DmcVDkGWp8cYeohVxAhn1btYfuFJb+WF2Dv+gK+1D9LwFc0ywugynrLMc8j3?=
 =?us-ascii?Q?STN70mdEaJBFZD06MOdASTge/Cuhp9pr8b9r4CZ+GfA7KVC4q4PQgDvEQQ9S?=
 =?us-ascii?Q?V/76CAFeLosKf9CNPnFI6dfWyNlCdhuJeiijvAxqyFt9sQanucQyTBLeAPZ5?=
 =?us-ascii?Q?ZONfRxx+6Mpe6etNKXXxT8KGzcewLVqZZr0m91XySlXuT8cLWcr0Z5kjhd6T?=
 =?us-ascii?Q?TavDB9Wlc9AgyzwJgT/uvKDSU8WFkJlbkmOvjE7UuejwqLt/2btit4BDgv/6?=
 =?us-ascii?Q?k330zd9WQMZDVnsd6a1AKsm3w3YMj5kL6663OKoSx9ZsEG+IadOsRYoa/2r0?=
 =?us-ascii?Q?dt40CGVnTdwibm76mfk9qDWOPbH5a6zP4T5WCDR9R95vhiM+ZL00qxO2s85A?=
 =?us-ascii?Q?Rr0QnJ3/p2eIBsFf92ZEqAWa7zozuW25YKX9jDer8i7zudDNG6PXxj61J1LH?=
 =?us-ascii?Q?Ic8L/mtbtGINLRdz1GsRPgRv2Vc/qWDpL8fljpSwSdDBpecR2fXSNPxrsdl6?=
 =?us-ascii?Q?yYbxnnq1mnsouwFM+e5stsEfoE/k7tUx4ETyOFZ3kl6ZgWdxOjIfKsi/WLo+?=
 =?us-ascii?Q?3INWHOkbBO8BBex+8xpQMpBlwBJ+aykrIm3mz22p6XfHzznZkJNsKGqNoKWU?=
 =?us-ascii?Q?dAfNswIpXl1Qni+dZBoijUgUJYGym8/Q2yOcOhgqp2K8NzJ9OaSifw3Ze1Fh?=
 =?us-ascii?Q?u1PoWujmKAgNYXWYg76M1sIEWy8F8orP5sLiTkaD1QZDkC7rbGnaOA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 10:28:47.1096
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70ae9840-6cc6-4a4c-371b-08dca1943f8e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9428

To support AMD's per_core RAPL counter, we will need to check
per_core capability of the current rapl_model multiple times in
rapl_cpu_online/offline, init_rapl_pmus functions, so cache the
matched rapl model in a global variable, to avoid calling
x86_match_cpu() multiple times.

No functional change.

Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
---
 arch/x86/events/rapl.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index c3afeaf679c2..4ee0877eb4d8 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -146,6 +146,7 @@ static cpumask_t rapl_cpu_mask;
 static unsigned int rapl_cntr_mask;
 static u64 rapl_timer_ms;
 static struct perf_msr *rapl_msrs;
+static struct rapl_model *rapl_model;
 
 /*
  * Helper functions to get the correct topology macros according to the
@@ -621,18 +622,18 @@ static int rapl_cpu_online(unsigned int cpu)
 	return 0;
 }
 
-static int rapl_check_hw_unit(struct rapl_model *rm)
+static int rapl_check_hw_unit(void)
 {
 	u64 msr_rapl_power_unit_bits;
 	int i;
 
 	/* protect rdmsrl() to handle virtualization */
-	if (rdmsrl_safe(rm->msr_power_unit, &msr_rapl_power_unit_bits))
+	if (rdmsrl_safe(rapl_model->msr_power_unit, &msr_rapl_power_unit_bits))
 		return -1;
 	for (i = 0; i < NR_RAPL_DOMAINS; i++)
 		rapl_hw_unit[i] = (msr_rapl_power_unit_bits >> 8) & 0x1FULL;
 
-	switch (rm->unit_quirk) {
+	switch (rapl_model->unit_quirk) {
 	/*
 	 * DRAM domain on HSW server and KNL has fixed energy unit which can be
 	 * different than the unit from power unit MSR. See
@@ -846,21 +847,20 @@ MODULE_DEVICE_TABLE(x86cpu, rapl_model_match);
 static int __init rapl_pmu_init(void)
 {
 	const struct x86_cpu_id *id;
-	struct rapl_model *rm;
 	int ret;
 
 	id = x86_match_cpu(rapl_model_match);
 	if (!id)
 		return -ENODEV;
 
-	rm = (struct rapl_model *) id->driver_data;
+	rapl_model = (struct rapl_model *) id->driver_data;
 
-	rapl_msrs = rm->rapl_msrs;
+	rapl_msrs = rapl_model->rapl_msrs;
 
 	rapl_cntr_mask = perf_msr_probe(rapl_msrs, PERF_RAPL_MAX,
-					false, (void *) &rm->events);
+					false, (void *) &rapl_model->events);
 
-	ret = rapl_check_hw_unit(rm);
+	ret = rapl_check_hw_unit();
 	if (ret)
 		return ret;
 
-- 
2.34.1


