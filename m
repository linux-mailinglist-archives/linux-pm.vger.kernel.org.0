Return-Path: <linux-pm+bounces-11619-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 062D59406A4
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 06:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65F49283D5E
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 04:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DE315A86D;
	Tue, 30 Jul 2024 04:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aMh/igHf"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4252C13B780;
	Tue, 30 Jul 2024 04:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722315092; cv=fail; b=phQTpzdKSMM2KUt7K+TyON6jZGGxD70E8Fxj3LQKZ2qMW7z+yHa4SrRU989exZsZ56WDJRgUo7QW4ek6MTwH21YQYIaVWOf3MWyuVi1YomlV0oZ+IeAtztfRzb/iWTEcrt5qgy8hi6gZSD1/I2yBe3A61oGPOONb3/jAEnfjlNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722315092; c=relaxed/simple;
	bh=6Gz+AcAJ7YXBmKy+Px+2y4RGTNVQM/Xj5aVpxD3VDZ4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D++o6FbqcdAL5ZYPwdyBsxuLb4YahykLHDPd0f/zv/9ZchpACeFZHvr8vV2VtqSYGhZMtuxjgy7qh7aJBQdasbPlni4g2Z/ECZHDL9zl0/s/F1Zfc3N6CCnYsfQYzZ+ULmXuL2alYmMR6DhXfyF1CfHgJdTldein+WQrG6XlTsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aMh/igHf; arc=fail smtp.client-ip=40.107.244.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XRd6iBzWnUsn/Jig7cJjG9ZkGzOnLy48FuyKlBLFUcuQtJ/ETqfBYI/8b8TmWJbWWqRQL7Iwqinu3maO2vGdmzLBHNK68uR9cNTbPggLbTGIVEaqOSrRpWgYei5In0CWtEe4pwCcdYiGzTBu3R4FyTRjJoP2+wTqA+H7kKxhJXHurKMHHBc8wQnnHmyBAdpxo+SC5FB3hA+8izWiPu7dy3Akc5tlrAoUzRiA/7JTpZt3Srbfycpdx6wp675H4AmTo7iRWm+9zBXEeuzv9v57v6Ifegf+OBMHH/X/x7zDUQnhQAAYon+RpNqmNIRwOOn9fE+O856ZP9yU7fLYj1Z15Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jxsSlijYFDscurd6MHklI5i/qiLU+tHaxC1RmG68TFc=;
 b=etn+JRRqyotbYdFT62bBgjGZah2D7YBY4Grppg63imC8zfoGrNL/ip6CTOuzvMUl6dwjIcfjMJciz+h8UxvwsgLzwHotQp6+g72iwwlBVedoo/qNoKkX//wWEpLMK+ZcsoyXa/c06Ly2YZ1DGf7VviMUMdFRryPlV+2v0Vmqe9zdpp4L3hgRcFA9zJ/YouNFtzNC9iqstGG9GLWu7bH4HD4D4/XDYMGVrFdAVsc0S3P1DR/S9S75KDSLVY6ZoJknVvA+uCeOQTO4WPE3aL7XzFfbRXPVqiu4gz5nNGkxas7csPE5bP+pNdSFZcYPgq6L5INdfzBdMkhaTtEMR3HPPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jxsSlijYFDscurd6MHklI5i/qiLU+tHaxC1RmG68TFc=;
 b=aMh/igHfQbOTvifzvrzRv827WWru1iukLV0DqS0emKfAP4tF1joYoqX2WWXLNzwghT0Jk8vKRSqSjzisgvq769XnSGdG9B0hgITzXMYzA+fbrCkk1Cj43Ya8q/1kn474hXxgq54yBMh3ZRO5LP0idmQsJcVhIluwGIJEQemGWMc=
Received: from BYAPR08CA0052.namprd08.prod.outlook.com (2603:10b6:a03:117::29)
 by DS7PR12MB8372.namprd12.prod.outlook.com (2603:10b6:8:eb::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7807.27; Tue, 30 Jul 2024 04:51:27 +0000
Received: from SJ5PEPF000001EC.namprd05.prod.outlook.com
 (2603:10b6:a03:117:cafe::b) by BYAPR08CA0052.outlook.office365.com
 (2603:10b6:a03:117::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.35 via Frontend
 Transport; Tue, 30 Jul 2024 04:51:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EC.mail.protection.outlook.com (10.167.242.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 04:51:27 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 29 Jul
 2024 23:51:20 -0500
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<tglx@linutronix.de>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <rui.zhang@intel.com>
CC: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <ananth.narayan@amd.com>,
	<gautham.shenoy@amd.com>, <kprateek.nayak@amd.com>, <ravi.bangoria@amd.com>,
	<Dhananjay.Ugwekar@amd.com>
Subject: [PATCH v2 1/2] perf/x86/rapl: Fix the energy-pkg event for AMD CPUs
Date: Tue, 30 Jul 2024 04:49:18 +0000
Message-ID: <20240730044917.4680-2-Dhananjay.Ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730044917.4680-1-Dhananjay.Ugwekar@amd.com>
References: <20240730044917.4680-1-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EC:EE_|DS7PR12MB8372:EE_
X-MS-Office365-Filtering-Correlation-Id: 19527447-922c-476c-5193-08dcb053455f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EraF4b5h6A5Vr5+iL4rwdAl7ptjOgrwFKA5VpCTibC6JjWIblZzmTYRCUXcw?=
 =?us-ascii?Q?UfOMtcrOQk5ZTH9YhI47xMBvWHaGl3wiIkv88566EmuTtJW2zDoYtrWBAkG9?=
 =?us-ascii?Q?11jSlSEoexr+AIM5HUMZIwUtnJWy+BBzza3TOxtVQPFYOY0M/4SwR7SqWDi7?=
 =?us-ascii?Q?Ga0e+VaaMmfmHWTAe7nrtZADdSNnjfGzeVPpTVrrvAIPC7B/5pRwNtvT7k1j?=
 =?us-ascii?Q?AUBPvZRUAnL0MQQmCk9R+5kJP0RXG4GRoScPKvtHv8DpaqPIHm0b8/UO8O/V?=
 =?us-ascii?Q?uZa8aXvQWEzDXs/GLRb5rS5gsDqcoCU7S1SLO5bM7MEOdDe/uDzLEFrHOLIp?=
 =?us-ascii?Q?/4UNusiujf1ZJhe5IYOXC9a2wThTqEfz5HPFtlKA3vR1htJdLSq8cNG8JsHZ?=
 =?us-ascii?Q?cGo77cDy9GS7zfp7h8XeMDi2lXwQJrGlbOP6UXBLbdHA1yJ9pi9pYahVfgTC?=
 =?us-ascii?Q?1wnx4MESpSTegSa6Pi2Xr9wmzdVG/ztcrSfcX8BvSpqQYD095Mssteb18zLP?=
 =?us-ascii?Q?HC16Wn9yXSoXEaEiZoe/J11X7iURmqJfFS9aljUqUXJZ2g/sNIj+67JWdkL7?=
 =?us-ascii?Q?atVKeQxwO4iqv3gyB6csYUS6mN1y4CCrPTJBOC8cl5EhXf/p86PCvaOVmchc?=
 =?us-ascii?Q?J5N9sgh8UGe/hUi/Q31SA6iijU+kHxFBb4+qFffa20nQWBnB9OCTOnYmib0p?=
 =?us-ascii?Q?+6/OEPHniQdAkqfcjrFgvBX836QQbJLsJ2GH6z5Afd2zsD2WM0QJVShg66R6?=
 =?us-ascii?Q?M+M4ZcSJ14O5e2x73V0GB4vY2vy+PQJWkkhTa7QqDscuTUknhOn8hMBKVVgF?=
 =?us-ascii?Q?t95NwbUJooeW8YAmcVRq/VjDlhCLXpugBwE0xeJy2wlIxGfTsaiMw1sPFedl?=
 =?us-ascii?Q?2NGB9RLMSushyUXwCSR3UGfWakY+S3Gc69u9LppZeVq4uXDTjc0yLZoY8snR?=
 =?us-ascii?Q?nhyAERWqfrlDcvpP3t3op0O4+iu+g/sfSPUh1h2gip0muXU86V19UvZuSNcl?=
 =?us-ascii?Q?R2j/sXzVpA1c0doi4YtDprkTFy00M/Np7RiqEgoc4EozYKF/E3ySZm/L+Ntm?=
 =?us-ascii?Q?ZV9t13HxIPWms1DEZ+ZtzaoHPjjDN1WucXynQ2E3E209E/wC7K9Zcs05QduQ?=
 =?us-ascii?Q?eiQB0jAD7FF8EliYxEsjCt4PQS/9GZ2vpD+pFi8tBqn1saPor5DNdJFo3GNW?=
 =?us-ascii?Q?ROPXiAew5EGgjhoFqj5cj1PfON76qJrWZWKTvkIwx3zhGDdsRFlHeMQ7o1PW?=
 =?us-ascii?Q?liIo1uH0YWxEv4N1K2ez8JvRDvnx7VSmpfxd832an0GhM6dv041GfMTbDYiK?=
 =?us-ascii?Q?M2A8f9gN49WAyfhnd6vDTp/W/kSJLjYcVeW5xVRswD8P0u0J7yomevrs9S7n?=
 =?us-ascii?Q?0Xt0hGmsh++hKI0axqtB4YsYkMpQDCLAW/3+1S4+09UYscjJhZ9BLK2mIUKC?=
 =?us-ascii?Q?lfzW3Rbde/nfZAqubfhJXJf/EiUh0K+12TKeXQRvNs+HeS3qzF/0kw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 04:51:27.1010
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19527447-922c-476c-5193-08dcb053455f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8372

After commit ("x86/cpu/topology: Add support for the AMD 0x80000026 leaf"),
on AMD processors that support extended CPUID leaf 0x80000026, the
topology_die_cpumask() and topology_logical_die_id() macros, no longer
return the package cpumask and package id, instead they return the CCD
(Core Complex Die) mask and id respectively. This leads to the energy-pkg
event scope to be modified to CCD instead of package.

For more historical context, please refer to commit 32fb480e0a2c
("powercap/intel_rapl: Support multi-die/package"), which initially changed
the RAPL scope from package to die for all systems, as Intel systems
with Die enumeration have RAPL scope as die, and those without die
enumeration were not affected by it. So, all systems(Intel, AMD, Hygon),
worked correctly with topology_logical_die_id() until recently, but this
changed after the "0x80000026 leaf" commit mentioned above.

Replacing topology_logical_die_id() with topology_physical_package_id()
conditionally only for AMD and Hygon fixes the energy-pkg event.

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

Fixes: 63edbaa48a57 ("x86/cpu/topology: Add support for the AMD 0x80000026 leaf")
Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Reviewed-by: Zhang Rui <rui.zhang@intel.com>
---
Changes in v2:
* Updated the scope description comment
* Dont create rapl_pmu_cpumask and rapl_pmu_idx local variables, as they're
  used only once, instead call the get_* functions directly where needed
* Check topology_logical_(die/package)_id return value
---
 arch/x86/events/rapl.c | 47 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 42 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index b985ca79cf97..7097c0f6a71f 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -103,6 +103,19 @@ static struct perf_pmu_events_attr event_attr_##v = {				\
 	.event_str	= str,							\
 };
 
+/*
+ * RAPL Package energy counter scope:
+ * 1. AMD/HYGON platforms have a per-PKG package energy counter
+ * 2. For Intel platforms
+ *	2.1. CLX-AP is multi-die and its RAPL MSRs are die-scope
+ *	2.2. Other Intel platforms are single die systems so the scope can be
+ *	     considered as either pkg-scope or die-scope, and we are considering
+ *	     them as die-scope.
+ */
+#define rapl_pmu_is_pkg_scope()				\
+	(boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||	\
+	 boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
+
 struct rapl_pmu {
 	raw_spinlock_t		lock;
 	int			n_active;
@@ -140,9 +153,25 @@ static unsigned int rapl_cntr_mask;
 static u64 rapl_timer_ms;
 static struct perf_msr *rapl_msrs;
 
+/*
+ * Helper functions to get the correct topology macros according to the
+ * RAPL PMU scope.
+ */
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
@@ -552,7 +581,7 @@ static int rapl_cpu_offline(unsigned int cpu)
 
 	pmu->cpu = -1;
 	/* Find a new cpu to collect rapl events */
-	target = cpumask_any_but(topology_die_cpumask(cpu), cpu);
+	target = cpumask_any_but(get_rapl_pmu_cpumask(cpu), cpu);
 
 	/* Migrate rapl events to the new target */
 	if (target < nr_cpu_ids) {
@@ -565,6 +594,11 @@ static int rapl_cpu_offline(unsigned int cpu)
 
 static int rapl_cpu_online(unsigned int cpu)
 {
+	s32 rapl_pmu_idx = get_rapl_pmu_idx(cpu);
+	if (rapl_pmu_idx < 0) {
+		pr_err("topology_logical_(package/die)_id() returned a negative value");
+		return -EINVAL;
+	}
 	struct rapl_pmu *pmu = cpu_to_rapl_pmu(cpu);
 	int target;
 
@@ -579,14 +613,14 @@ static int rapl_cpu_online(unsigned int cpu)
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
+	target = cpumask_any_and(&rapl_cpu_mask, get_rapl_pmu_cpumask(cpu));
 	if (target < nr_cpu_ids)
 		return 0;
 
@@ -675,7 +709,10 @@ static const struct attribute_group *rapl_attr_update[] = {
 
 static int __init init_rapl_pmus(void)
 {
-	int nr_rapl_pmu = topology_max_packages() * topology_max_dies_per_package();
+	int nr_rapl_pmu = topology_max_packages();
+
+	if (!rapl_pmu_is_pkg_scope())
+		nr_rapl_pmu *= topology_max_dies_per_package();
 
 	rapl_pmus = kzalloc(struct_size(rapl_pmus, pmus, nr_rapl_pmu), GFP_KERNEL);
 	if (!rapl_pmus)
-- 
2.43.0


