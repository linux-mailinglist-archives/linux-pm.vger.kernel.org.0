Return-Path: <linux-pm+bounces-8857-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C75B1901EF8
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2024 12:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A42C41C21E0D
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2024 10:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B04C770E9;
	Mon, 10 Jun 2024 10:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Y9zbNXvg"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E8575813;
	Mon, 10 Jun 2024 10:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718014188; cv=fail; b=si0BAccSWBrjnmBAoLEg7+tc1W1Z0QSM+Qh/J2/oFYxIOKua8BBMFKEz4i9XVVqWIa37B36PZAAQ3bonkG2kTuXl/QuGJa/07v+LazrvP+93ODuo/1LwmvBJHLbVNnlBHZAZi5ps+ij/Ix7qNQsVB/XX8bA7b7tR+8KKSZIlve0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718014188; c=relaxed/simple;
	bh=B+Bs1/Sl2/ea1Kh8kgxU+jxLkhgENSqya1IQw4U1OCQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kBwHgbGmaScnJoAxm1KA2zJIw1YYkyJug4LNx+J02Qr5qQb77SrB//1a6D+ocXAh9aJTXmMB3uIxUUw2jqEWwPQqAIe/WE0GERZzC7AUm3n4MdWtZ0ZlrGE87EfqBf0j121/MuZMBn77Ax8uJ13Xb0xrnuU77Ff/LNIPI0J6mEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Y9zbNXvg; arc=fail smtp.client-ip=40.107.93.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S+lh+BgrJCroKVaAPQKMQhrAWKd5K4ucc0SK2W8HWZk0/j9DiaArzqXImdgGp/VXsNqy1F6mvng21Fk7v8xGEgOvjhpm/F73SbXq3Ms7xrYIefpTsGX19IsQNyaXdBBBe0wbOmK3i8caMxY4TeIvzB+yyGr504L8Gk05SgVyepSl9mxdf52tuZffjYVx5gLzM3D4hxkhGHhrZSVoQNOOUUfMaSTHX6u/e2RqYJUqy7e3qomgrNgnoG2Gc8WqleG3SHlIPwxEicFr75Wb/xxxGS1Lu1EypHRrzdApyDK/sQKRv+I7J5OXTmqct4RiN/PDBxxKi0OfWoG8cLVMfxgDBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3XxBOYQHTq6+VWT/1eEZw5vU3Ql+de6j2SbkY2U/TVY=;
 b=Tz63/lqw19/YWE8tF+zAjR0U2gTRn/s3c3BifzvKqB5qS9FxGoFxtwFGxUMBTTtgE/3v9sRBfq5c+TEjsE7/1uk7/xq/duzzULMnaJBSVFl9F8EfqlRf1z46bghuFt1ms3vSXyTYB3pNoCJ1L/uB71WPZANrEqAR1KrrjhbJFgBLZg7fbPhGNgHFmFQzDI7Trq+CLYc5TiRjtdvv85wIpFSKbEL5O33VIMf+NVqTgfwj6rCZ7hSdoDpU6jpPGp0lJ+sBR9E1rrrwrdJ6OaoXUsr5a38FlN2IS5IqKs+kmZ9RXxmhv5w3rk6SFfstz27HIaTJs28rFXv4IY+xx9pPFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3XxBOYQHTq6+VWT/1eEZw5vU3Ql+de6j2SbkY2U/TVY=;
 b=Y9zbNXvgAbXCkzcwjL2E47LSuhGl3cwWUpmozX5aI01uhLuODivp/hViwwBsl9rypMQelgsiul/+DLx/2VZ+s9onMTOY8+Sy3znTkNA7cez530Qblf/zq4xJDQwMl5BKczsl43ocZPUAjl+44aUi/cheIoZPTk5Og/4zfnQ2KQE=
Received: from CY8P220CA0031.NAMP220.PROD.OUTLOOK.COM (2603:10b6:930:47::17)
 by CY8PR12MB7315.namprd12.prod.outlook.com (2603:10b6:930:51::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 10:09:42 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:930:47:cafe::9) by CY8P220CA0031.outlook.office365.com
 (2603:10b6:930:47::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.25 via Frontend
 Transport; Mon, 10 Jun 2024 10:09:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 10 Jun 2024 10:09:41 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Jun
 2024 05:09:34 -0500
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
Subject: [PATCH 3/6] perf/x86/rapl: Make rapl_model struct global
Date: Mon, 10 Jun 2024 10:07:48 +0000
Message-ID: <20240610100751.4855-4-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|CY8PR12MB7315:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a44ab45-6914-485c-ff50-08dc89357220
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|7416005|36860700004|376005|82310400017|921011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HWeJmN7AraNjnXGFO0pSatRzDEoGmRe8bNfUKSv6HR+NDkFyF2/Q7WWQJSTm?=
 =?us-ascii?Q?Ff8zqirp5S4/3aVJMdYDudZwuKdybfkok6s+lp+KWUfHeg+kuUcZpgkN8qV7?=
 =?us-ascii?Q?MiAhek0ePi+xyNzxVmz52wxAi3dj8fpx1QC10if6U9GuIY3UJRWXgIH8k8XU?=
 =?us-ascii?Q?ZAciQ1FWXcE9+oFLPC0F7sWC4xfSjFx9bafdI+IA8P2G19uSRK58MWjDosIO?=
 =?us-ascii?Q?lODAV55UyMye2uV2CVXa/8XjswgZQ7SuBsZcrIo/f1jY5YixQ3YBetWH972A?=
 =?us-ascii?Q?jEtBa8bAV40M44lkG07VTAZSHqzBgVBWQ5uoGMkg4TUaIQcwV0npTZysZmFF?=
 =?us-ascii?Q?ehQCTXjPcc/xZnYDJmkdPUdNEqzD7KgVlObDyRwf7vu8eZRNsnO+XPSaAdtw?=
 =?us-ascii?Q?boezcToe6OzvLmNsBprjGpK3xEEweGKB/4nW0vI33HpNn1+VJ0Fxxwk3u5Px?=
 =?us-ascii?Q?1mIUqesUnfBJsX7V5x/D18CGxsC+lfHcMwfifnPhdYskTzomv/ebwkqLnbB9?=
 =?us-ascii?Q?Dm/Vb39PK5rF27dIc/+AedSyBCx9sYrF91toM43aeLIYulADZRVThtFRXi7i?=
 =?us-ascii?Q?r83HRYIXK3kGH5TFtMCKHWdbjTu7YDWvQTnEe/EN+ZBL65YHoeCv80sQ/KHT?=
 =?us-ascii?Q?w+RhVRcIPwO6WX09M2ajABknv7I+D8Ebl4Ru8GKEBNt9sP+2diQJypIzxuWI?=
 =?us-ascii?Q?igxdMHsXFDjYdmgoyshzjFOyYfbyVuWxr6TPbrvscDTgyWb+aJnfDFU3qHHB?=
 =?us-ascii?Q?5v94+w738CTDqyimQ11sPLLrjiIg5eRS3AzgF9MDXG+S85TbZyCmNJBGPeO5?=
 =?us-ascii?Q?gHTZePQwTPiwN5mga2zRvBeMXOzcfW/sQFCCo3JP2NEwHs3nsr+3N9x+e7wy?=
 =?us-ascii?Q?IxGJgDoRJL/wZnLEiLiCg+R1YTQyaAwv7qWRiWJgPh3jLSn7MBMuz3wv2tUl?=
 =?us-ascii?Q?Wih5PtQnvSeCutE34PbSO/aiJ6q2s16b1EboOiY8cUJEmYw0YQJzeeP0rYnB?=
 =?us-ascii?Q?0dTtYg18nuNtZDAwRWuGD/VZb/uXyh9gRvpGpFPs5nA3b7buZq1RSG4UoFpO?=
 =?us-ascii?Q?8CF2pBRVQvqjHNPq+pbZYFe27woBQtMeYXcerAz8nWZHimILfLlTWy1Bn1Hs?=
 =?us-ascii?Q?uy7vHWnZt302LoMYLUNvAgvAke+Gvpt9mEeHhZjlwfSJsnGebMlts5gxLFs/?=
 =?us-ascii?Q?+W0J1UUS0crLCLLdJL1g8uGquCxZ5qKbnD3LV5zBiWRxHVBiXIho+WJ2aE8u?=
 =?us-ascii?Q?gaxXFJ+tAYXJwy9VkS6o8t6bYJe1hT6qImdqvFdUUQBMNq7ltqO4rA5mk5jc?=
 =?us-ascii?Q?fkF3a+8Xov0l3N8FyFp+KUVc05UfMfpWEB69/L3iHlF+0YXq65y5kCFmHQ0A?=
 =?us-ascii?Q?KGxXhckhIQ8g4GINOrvil1zxkvXpLj9WXBQnYmWF5QtvTtADmFhLw6daJgVc?=
 =?us-ascii?Q?rkha+AbCB6c=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(36860700004)(376005)(82310400017)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 10:09:41.9554
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a44ab45-6914-485c-ff50-08dc89357220
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7315

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
index b4e2073a178e..e5e878146542 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -143,6 +143,7 @@ static cpumask_t rapl_cpu_mask;
 static unsigned int rapl_cntr_mask;
 static u64 rapl_timer_ms;
 static struct perf_msr *rapl_msrs;
+static struct rapl_model *rapl_model;
 
 static inline unsigned int get_rapl_pmu_idx(int cpu)
 {
@@ -614,18 +615,18 @@ static int rapl_cpu_online(unsigned int cpu)
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
@@ -839,21 +840,20 @@ MODULE_DEVICE_TABLE(x86cpu, rapl_model_match);
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


