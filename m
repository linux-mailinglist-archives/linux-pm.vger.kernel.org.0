Return-Path: <linux-pm+bounces-9868-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB78914264
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 08:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D3F1B22C5D
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 06:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603101BDE6;
	Mon, 24 Jun 2024 06:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZsglOjwx"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841F01B28D;
	Mon, 24 Jun 2024 06:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719208862; cv=fail; b=hNJ6zrm/Ygko228cvgZPsbM5aMNo81O3C2n4awrBHxHIAdRRXcuQZ2doFdrDjQCIDQ1YFLImNwlIHXLF+x/cvVySXcUZ+q8fvx5nLNjDiXPDT/GAtQViAJfF8gQ3ECNyg4GpUH52fI4JWs/9k4OAHu2XG4hGpJskT88kOSch7o4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719208862; c=relaxed/simple;
	bh=8ayQTd/qimBdn61F5QCpbR4M/6gGUQSWoz9lIWUkteY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lNk0zkxRCe4LgrEsEF18AMAqVEyqZsCQjTggPYOqHM1dN6WTxQ2Lj5eYOW5JXS9kqE985eR4qaOnKkBiRIvWHVDwWdH1Jv+mAiNyrLZHZDUWjjGLS0h2xcUr6NPWsz1mXHxFphblK2Ht3W1cL4wrvyhRjRQvSpnpz5jXUC4ymYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZsglOjwx; arc=fail smtp.client-ip=40.107.223.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ajU2Vim2x2ThuclCG9VzT+qPaJjAZMf2ewl+I52RoQK+lkG82tvFqNoqR+ZOTEbpLeCz5XVQayyGiv9/PJogwuRylMrGEW81GgTBBMK9Fvyptg3uvqQxaVSc4glMBvuPKMp+F8wv9GXTWOtxn4NA91roMW/HoKYxrMWYdm0BI93XZZBVfTMN6f4IxS7ZZMPXSKEc/JpD+axRARVlNz9rNaylsURFFSAny6UzW/dRiT30uLn430PkB2YVhYLQujJLDfK7KriTj0tcwDhS9VXCEowKxM6+9Zl9aZVRkTx0jZ44m6fH5jMt4QUSMoO7S91MP3IYnj0yHY6uUIyIbg4W8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z1A1PMXRxwmFPpA2Kipxu5AUpAjeD2dSCqTpe8xo/ZU=;
 b=ccEcr8/cg+Y4sqwBeGO9RJNItf95MSW4OmD9KJwRFpQ8u6QdSN6SVnDHSsz5vdE6LeT+M0OCxivbMT8M30FNOb3k6hyMcSUHAAeYcZu7sr7hD+D92tg+uxpvyMn6MB7C1xjTARNBEQDokVqquTR9Cf/h91ldPA1A3SQS2NEGag7wgZMyWzzSVADmt+8ZuH49mhRJlo0xlLqDIL8QxCg4buo6HwVT4jOiz5c5VPrbHOK04RChNgHupnPvjjwIrNv3mUr9qUBcaQD4WjLNVmYz7mD5an8Ssw9hIpcNipzDDbJRsRFxYp6uS1eZksTLzK/Dgqfq+b2mj+FafmjrgXiLPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z1A1PMXRxwmFPpA2Kipxu5AUpAjeD2dSCqTpe8xo/ZU=;
 b=ZsglOjwxw0v+moRWRv9Zf6QbYbpWLpsiVqxzlotTqza5pk/G1UZgfIsjjYeuhYpMMxPmsOX6VkRjno/CFmCg6hmLoOwjQQcAp5gE8rtdwNXLKjexwBcYqMXznYKXgX3OymO1z1eazxQiMRSVa2OpOAAO+v3D2WmVSSzk1Gl2j/o=
Received: from BL0PR0102CA0045.prod.exchangelabs.com (2603:10b6:208:25::22) by
 DM4PR12MB6183.namprd12.prod.outlook.com (2603:10b6:8:a7::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.26; Mon, 24 Jun 2024 06:00:58 +0000
Received: from BN2PEPF000055DC.namprd21.prod.outlook.com
 (2603:10b6:208:25:cafe::23) by BL0PR0102CA0045.outlook.office365.com
 (2603:10b6:208:25::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Mon, 24 Jun 2024 06:00:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DC.mail.protection.outlook.com (10.167.245.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.0 via Frontend Transport; Mon, 24 Jun 2024 06:00:57 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Jun
 2024 01:00:50 -0500
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
Subject: [PATCH v3 02/10] perf/x86/rapl: Fix the energy-pkg event for AMD CPUs
Date: Mon, 24 Jun 2024 05:58:59 +0000
Message-ID: <20240624055907.7720-3-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DC:EE_|DM4PR12MB6183:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d0aaa06-6bb6-494d-50f9-08dc9413044a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|1800799021|82310400023|36860700010|7416011|921017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FyYSYCqwQC0SPgmER4WsgO88JVW8aXCytDRZftMOMjiQ9P/y/IjWruipFYk3?=
 =?us-ascii?Q?HnOuouii0WIR3hy4ovlappRoaayEO1lVA4Jg6kdihKaPZVXkki1/MclW/qml?=
 =?us-ascii?Q?eT2iJrgKLxt8FfrtMhr5SBUi0lzCV0chuAr3AG/xHMo+Lmpy+MJ4L3nVY0pH?=
 =?us-ascii?Q?yhJBNqdyWJlf2jqYs87rGZB8KLluxFgLhF54mLggo0sMzk8dg3YQHU74u1lU?=
 =?us-ascii?Q?pZNJFgvzo66XKeXaiPx6oZoE1VdyASJuIzidlMhMnrDCU0oiyMq9BlSfyeus?=
 =?us-ascii?Q?qyHQUZmhIMAtg+iPznDEkEY1esWeXBlX1dtRFAEOmCOAEZ6yM0qHXLb5kLmU?=
 =?us-ascii?Q?ESYRey8HnhQdRCtShXLYc8njm0ZvlXwYGy35C9nMCPMxY/qkF1gSrSen+mNq?=
 =?us-ascii?Q?ghBSb0IvTpge93ipnHfPoiymEGjFyUIohSLYo5ajuKnF+ot1wLktKOrF/4dH?=
 =?us-ascii?Q?UznfN5bsmyf8Bsn2vzTJhepwUIj78xjjOovJHwYKWNEQYffhfmAh3pDMfpqX?=
 =?us-ascii?Q?Eo1y1dmZyLNYljpnUkLiHdwvnxMbbR9EwlGMuoGEamC+QaCsQgQ8UTpjc/Nq?=
 =?us-ascii?Q?QhCt2mj3p6U0p93DDd3fCpcRwgP20dWTYXQu4Jb/i2lfM4x16EIDh8J6ShXW?=
 =?us-ascii?Q?xkt0+MW4hhsoiaGgM4RCT0znwuz6/WXqaBZSj4OhgwJ1y86ahUfFtMnuOeDS?=
 =?us-ascii?Q?Mf0jIWMKOuLBNSrRQNIF+oQCbD+qRH4wiFtrV/BnTUAB+6D3V9004JDtlE8D?=
 =?us-ascii?Q?+5Rlmns9VEvPhyPHKF2GPgJfEwcUqCtbPm/XHq6aL46Nd3YNm1mUVcLFhfVa?=
 =?us-ascii?Q?COjkJVgDI+IFgJG0zk7HzDYXV+eaxJmkDLRENAC1YIAWbp4uJRT2rE66M8jO?=
 =?us-ascii?Q?+agYOODsWN8YJAFdsrBkxv9ZaqFaH7LBMM6bAZXb3JFRWDYCUDdx7fxIRlJ4?=
 =?us-ascii?Q?k/nOzDIGcDK2jNWE2sE1Do5ko4szpg6OdeEeRbMBeymgnea3wmu7o1o3d5T8?=
 =?us-ascii?Q?x6Rs8mxKc40OzG37U2I2SERIzqR9ipHrMKFlX6ijyJUcnKCROYkr59fXsO0d?=
 =?us-ascii?Q?IPGMt794oxXq5vXLOOuegfTjH5sxYegefSF1QDc7Pjhaso50GYQQTOrcxRYF?=
 =?us-ascii?Q?lw/I7E9QzDQPEAZrhw/Qf6oQq9BmaoubZ7W2V0OrJ0K4CRL5e2lQoMqYYOcD?=
 =?us-ascii?Q?dXlx7fokf4GB0na80nBwRl/6JAA0gpKdPxqw0ODVhiVEjXmiCZ1PVVBOKnZG?=
 =?us-ascii?Q?EjBr9fdNCMGg0sWuO//GlYH8dWmCBCEXQemALmqhZFZjImPCgDSzW2QBJdY9?=
 =?us-ascii?Q?uSp4Q/BzmEC9pGydCLxnDH9bO3dUO60lrd+uL8R/hHiNB5b2JlKrlCnSv0ES?=
 =?us-ascii?Q?FsySExjKU6MZfp3JtQSvL7ZF416s7FDcU9bxoY1zYYI4TOVGjosuH0XQVhTr?=
 =?us-ascii?Q?2wDyOcGWg6w=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(376011)(1800799021)(82310400023)(36860700010)(7416011)(921017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 06:00:57.6255
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d0aaa06-6bb6-494d-50f9-08dc9413044a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6183

After commit ("x86/cpu/topology: Add support for the AMD 0x80000026 leaf"),
on AMD processors that support extended CPUID leaf 0x80000026, the
topology_die_cpumask() and topology_logical_die_id() macros, no longer
return the package cpumask and package id, instead they return the CCD
(Core Complex Die) mask and id respectively. This leads to the energy-pkg
event scope to be modified to CCD instead of package.

Replacing these macros with their package counterparts fixes the
energy-pkg event for AMD CPUs.

However due to the difference between the scope of energy-pkg event for
Intel and AMD CPUs, we have to replace these macros conditionally only for
AMD CPUs.

On a 12 CCD 1 Package AMD Zen4 Genoa machine:

Before:
$ cat /sys/devices/power/cpumask
0,8,16,24,32,40,48,56,64,72,80,88.

The expected cpumask here is supposed to be just "0", as it is a package
scope event, only one CPU will be collecting the event for all the CPUs in
the package.

After:
$ cat /sys/devices/power/cpumask
0

Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Fixes: 63edbaa48a57 ("x86/cpu/topology: Add support for the AMD 0x80000026 leaf")
---
 arch/x86/events/rapl.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index b985ca79cf97..73be25e1f4b4 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -103,6 +103,10 @@ static struct perf_pmu_events_attr event_attr_##v = {				\
 	.event_str	= str,							\
 };
 
+#define rapl_pmu_is_pkg_scope()				\
+	(boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||	\
+	 boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
+
 struct rapl_pmu {
 	raw_spinlock_t		lock;
 	int			n_active;
@@ -140,9 +144,21 @@ static unsigned int rapl_cntr_mask;
 static u64 rapl_timer_ms;
 static struct perf_msr *rapl_msrs;
 
+static inline unsigned int get_rapl_pmu_idx(int cpu)
+{
+	return rapl_pmu_is_pkg_scope() ? topology_logical_package_id(cpu) :
+					 topology_logical_die_id(cpu);
+}
+
+static inline const struct cpumask *get_rapl_pmu_cpumask(int cpu)
+{
+	return rapl_pmu_is_pkg_scope() ? topology_core_cpumask(cpu) :
+					 topology_die_cpumask(cpu);
+}
+
 static inline struct rapl_pmu *cpu_to_rapl_pmu(unsigned int cpu)
 {
-	unsigned int rapl_pmu_idx = topology_logical_die_id(cpu);
+	unsigned int rapl_pmu_idx = get_rapl_pmu_idx(cpu);
 
 	/*
 	 * The unsigned check also catches the '-1' return value for non
@@ -543,6 +559,7 @@ static struct perf_msr amd_rapl_msrs[] = {
 
 static int rapl_cpu_offline(unsigned int cpu)
 {
+	const struct cpumask *rapl_pmu_cpumask = get_rapl_pmu_cpumask(cpu);
 	struct rapl_pmu *pmu = cpu_to_rapl_pmu(cpu);
 	int target;
 
@@ -552,7 +569,7 @@ static int rapl_cpu_offline(unsigned int cpu)
 
 	pmu->cpu = -1;
 	/* Find a new cpu to collect rapl events */
-	target = cpumask_any_but(topology_die_cpumask(cpu), cpu);
+	target = cpumask_any_but(rapl_pmu_cpumask, cpu);
 
 	/* Migrate rapl events to the new target */
 	if (target < nr_cpu_ids) {
@@ -565,6 +582,8 @@ static int rapl_cpu_offline(unsigned int cpu)
 
 static int rapl_cpu_online(unsigned int cpu)
 {
+	unsigned int rapl_pmu_idx = get_rapl_pmu_idx(cpu);
+	const struct cpumask *rapl_pmu_cpumask = get_rapl_pmu_cpumask(cpu);
 	struct rapl_pmu *pmu = cpu_to_rapl_pmu(cpu);
 	int target;
 
@@ -579,14 +598,14 @@ static int rapl_cpu_online(unsigned int cpu)
 		pmu->timer_interval = ms_to_ktime(rapl_timer_ms);
 		rapl_hrtimer_init(pmu);
 
-		rapl_pmus->pmus[topology_logical_die_id(cpu)] = pmu;
+		rapl_pmus->pmus[rapl_pmu_idx] = pmu;
 	}
 
 	/*
 	 * Check if there is an online cpu in the package which collects rapl
 	 * events already.
 	 */
-	target = cpumask_any_and(&rapl_cpu_mask, topology_die_cpumask(cpu));
+	target = cpumask_any_and(&rapl_cpu_mask, rapl_pmu_cpumask);
 	if (target < nr_cpu_ids)
 		return 0;
 
@@ -677,6 +696,9 @@ static int __init init_rapl_pmus(void)
 {
 	int nr_rapl_pmu = topology_max_packages() * topology_max_dies_per_package();
 
+	if (rapl_pmu_is_pkg_scope())
+		nr_rapl_pmu = topology_max_packages();
+
 	rapl_pmus = kzalloc(struct_size(rapl_pmus, pmus, nr_rapl_pmu), GFP_KERNEL);
 	if (!rapl_pmus)
 		return -ENOMEM;
-- 
2.34.1


