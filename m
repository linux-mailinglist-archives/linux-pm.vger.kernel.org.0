Return-Path: <linux-pm+bounces-10972-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D08392E4AE
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2024 12:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 340CD28167F
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2024 10:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DAC158DA8;
	Thu, 11 Jul 2024 10:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gJAWRbRK"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553B3158848;
	Thu, 11 Jul 2024 10:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720693692; cv=fail; b=CmnfD4pOeOZ2GZSkrdpJPWdqDXsnBeAJykd8X75nguufZJ1f+qv9UUDkPXG1Ox2hELh+6ufZo7SODAOeJcIjwIJMZ2Pe1ntlA2yv7pHg6m3CrwhsT8t0xnYLMcEn/2NXuE8xnyt20uI0YyP8iESBts4K14ACZIYWIwyLiMZGbms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720693692; c=relaxed/simple;
	bh=tc3Q859CSwhKHx/BLwIc/LmdIQWtI9bBgazGP2E6fys=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JXITEXeF8zXOCp+7MubkJJX6hHeQH1QkPJ/1/I2I8XH3jlFP6gHsLfILVI2MVe2M/gcM5y2696tlWPDpu8U45sR2s/zHLSNPUfoaOTvdSFU43K7r6caiXamjsXSXXZ0FoH9FwmBeI67KlY36SgFv0yQmT6QhZMvA59rczuY60K4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gJAWRbRK; arc=fail smtp.client-ip=40.107.92.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LCuiNsRQrZh9iBaQdgct48aPKxTnO3KlgQeHTJcLorQ4hCb46B8YLXE8+iBGhz2/NmrigDRu8v8jp3gotBpLB6y34IKZoF+zUTS1OcAXgMbO8bwGSY97jQS7ktrk5PClWZEreXADEomkM3Qv0GwngKrISp6uhpOomjowt+bbdjkFHJeNUP36lCJM//zFrx81Ku7ggLD/dlAHQCEjflgzB84/cfjNsRh6Jff8vEAX1fLthnHikF2ZRihFlEzZy+2cA7q39iOSEGqfkE8ZUlMabetkFqvE4fm/5MNlJ//iwwSvVWDCMlaqOk+8daetzlZymSFwlfg9eAtGPe+uDSn7XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zjo3XaldyVDUq39KrnjoyFEf3qPrAenby5GCwF8FBhY=;
 b=WwrIAopiwEjn2NX7VwAo1GkMICgv74bC2b1E/ujjMfsCk+sYuFqkigi4xwlT5Htf9N+k68CmEl3KRglyhvk6m0U71pBk2Z5P8Y8w7jCP5aj+VeEjHiZCggfQoZnaMQqmR+LFjVbmFbh0BUcFhFtPTMaYmGbDNuqOlhIdCew5sfW70MPk6ohMBkYAf7I2vlDbcEGq0sNDuDTz9W/OTS39Iz7sgtmglCxdIno9clyDZg+v38/TMV50nauUK8b0h5Inw3ceBtUoeYiY27kdOC4ro945ODn3DbcNKYbuZTGDoE5/gi+CVqLhdXbQI0ZdTgm2afGQwmq9CdE2JCXfVipUmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zjo3XaldyVDUq39KrnjoyFEf3qPrAenby5GCwF8FBhY=;
 b=gJAWRbRKUXb8jE0mmkfE8vyw/aRi5/129ek4DeTN2uAnCF65SE2G4Lu+LnbOuiEg5mHhvqz6+y6g00GgD7YSbj6Bt8PbbM/lR9+AIcO/tM6MG0kRAOKqRSdwj65ufJDPFz426/rYQ1KuqljT9ACJ1IaxM9hWJsCJFy7ZUgRp5+Y=
Received: from SN7PR04CA0106.namprd04.prod.outlook.com (2603:10b6:806:122::21)
 by CH2PR12MB4102.namprd12.prod.outlook.com (2603:10b6:610:a9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.22; Thu, 11 Jul
 2024 10:28:07 +0000
Received: from SA2PEPF00003AE8.namprd02.prod.outlook.com
 (2603:10b6:806:122:cafe::51) by SN7PR04CA0106.outlook.office365.com
 (2603:10b6:806:122::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23 via Frontend
 Transport; Thu, 11 Jul 2024 10:28:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE8.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Thu, 11 Jul 2024 10:28:06 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 11 Jul
 2024 05:27:58 -0500
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
Subject: [PATCH v4 02/11] perf/x86/rapl: Fix the energy-pkg event for AMD CPUs
Date: Thu, 11 Jul 2024 10:24:30 +0000
Message-ID: <20240711102436.4432-3-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE8:EE_|CH2PR12MB4102:EE_
X-MS-Office365-Filtering-Correlation-Id: dfcaa805-a401-4356-9003-08dca194274e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/Gab+ywB1rdV73grQys8/AxaxgjwUdruts6j2oiPzWmQfwnucY9GtyHSmLQL?=
 =?us-ascii?Q?H9h9IIBnPTH9IgkKUj4G2aEaesJvokPVzgvU+Zw7FgEvoO3x2Gomf7Cd9JPC?=
 =?us-ascii?Q?uTDEI9rGec+WgHPPRYNe4oIFoHO3uvtnHoGjji4b/DLYxll/WV/iv9Bu2QT6?=
 =?us-ascii?Q?CJRA3TfE2TgTsv69Eu4W35pmIl21Mh/Tr8VEmSscYuTn83OauPmEnwOtFImq?=
 =?us-ascii?Q?HWYKww9SU5Ayokp9ZV4ctbazzJ8Ctn91fWlJ8E7RS7vBue6ed6awJ8ZVIErD?=
 =?us-ascii?Q?2pY66Wxu+LRYD3CZvJKQ5oAP+ylTCqYCEFU+BMQ0BnS91hOEOoLyNALKnPo2?=
 =?us-ascii?Q?QLfitJBLI2YTRU6oHWrtl2i6TqSd9t9j1v0OqYcHKtGbmGLtzJzOcVNpwsrP?=
 =?us-ascii?Q?BwQ5cgibNtWhXUlqhB5Zt8v9k4jR0QK8lhTogLkvVAjLd3ym52pVzlKcKt2E?=
 =?us-ascii?Q?4rnkgH4b5HPIZRIAWwQZGENP1bNf2nsjvjGbZwUQKlnfCFCAl0GoilQJLkuu?=
 =?us-ascii?Q?AMmYDjQKdNyKUXt5Vsc8uBjTzdz5i0MYD7cnY9JAhMIDgWMa7zgQWV7maZFC?=
 =?us-ascii?Q?9XnytXeLKfos9Sz/eshldzUj9gLmXX/9YeJWnlr5iymgJy/praw4oU2CyQ1i?=
 =?us-ascii?Q?L1H+hbumW5BnQ4e6NCLNkGRwm3tQ5++F8G8FQsw4z579cB7NSPsqH3qAUzch?=
 =?us-ascii?Q?xTFA7edH1GeVTsNxs/tzeOa+S5HTFzBGj6ECNh7epnP+a4NdSEBdhPK62lNX?=
 =?us-ascii?Q?EfklMc8MI+WxgBcjnFmY/DpLUumhFO6R8ZhmcImp9h/LjAXpeIrec+J/qAxS?=
 =?us-ascii?Q?1H8fW2tH8T2lpgj+bia5FzeN5IRsWTNKW2uTZtvN5m0Ns4MlqQX5jkpgJIrH?=
 =?us-ascii?Q?gMKouaL45fPh7w7Hu82KZuuRlv7jS3c627sYxYMycfQDnZsc8E4TIR/1DRJm?=
 =?us-ascii?Q?5/l1GaUE2x3qCqZh7XrOAuivLrRI4ulTuja9kjk4BR+5YKGR4HoPy5QUwNt1?=
 =?us-ascii?Q?QAggETdw7hVAyf/jydx6gvX+4c4eles78lwCOOyyF3gzTaOmlsMoBqOHEKep?=
 =?us-ascii?Q?T231kzJ/wnn8Dg3n47CRRXoUfqLkE8P/zY8YR14MoOBedcIsO9fCazNq+VqO?=
 =?us-ascii?Q?Qgh0oCaIsrb4dEBdREAcpvZhT/FuhTF+UjxGq8yHuGfp1fgZmV4M0nbswp3g?=
 =?us-ascii?Q?eENmeddyQo6lpimSek9nizlujIkjOU65Nf39oX8hyRLtAej1Qf8iKlYypAjy?=
 =?us-ascii?Q?EgfWovurA/FYwqwL9r6hKQv/CbK3xCs3Zo1c3BBxlRQt6hgbKxFBncgpUCtY?=
 =?us-ascii?Q?69ubA/HjJZtT9nucjTt458+Ntm0BEUOi68sf+eF3p2DnUzToqDYbhYtDit6T?=
 =?us-ascii?Q?1q5CvBIAQFqAOVfBSPMH7Njkl5D1+npHn/Z9HdqNUvee1pF91olzzintgOZK?=
 =?us-ascii?Q?59THtOCBCfjyOLwLWChGq+E2TJHsedyCj9UK7hCjrm/+r8wvSkFuvA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 10:28:06.4115
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfcaa805-a401-4356-9003-08dca194274e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4102

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
Changes in v4:
* Invert the pkg scope check in init_rapl_pmus() (Peter)
* Add comments to explain the pkg scope check (Peter)

PS: Scope check logic is still kept the same (i.e., all Intel systems being 
considered as die scope), Rui will be modifying it to limit the die-scope 
only to Cascadelake-AP in a future patch on top of this patchset.
---
 arch/x86/events/rapl.c | 39 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 0c5e7a7c43ac..df71f38ad98d 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -103,6 +103,13 @@ static struct perf_pmu_events_attr event_attr_##v = {				\
 	.event_str	= str,							\
 };
 
+/*
+ * RAPL PMU scope for AMD is package whereas for Intel it is die.
+ */
+#define rapl_pmu_is_pkg_scope()				\
+	(boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||	\
+	 boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
+
 struct rapl_pmu {
 	raw_spinlock_t		lock;
 	int			n_active;
@@ -140,9 +147,25 @@ static unsigned int rapl_cntr_mask;
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
@@ -543,6 +566,7 @@ static struct perf_msr amd_rapl_msrs[] = {
 
 static int rapl_cpu_offline(unsigned int cpu)
 {
+	const struct cpumask *rapl_pmu_cpumask = get_rapl_pmu_cpumask(cpu);
 	struct rapl_pmu *pmu = cpu_to_rapl_pmu(cpu);
 	int target;
 
@@ -552,7 +576,7 @@ static int rapl_cpu_offline(unsigned int cpu)
 
 	pmu->cpu = -1;
 	/* Find a new cpu to collect rapl events */
-	target = cpumask_any_but(topology_die_cpumask(cpu), cpu);
+	target = cpumask_any_but(rapl_pmu_cpumask, cpu);
 
 	/* Migrate rapl events to the new target */
 	if (target < nr_cpu_ids) {
@@ -565,6 +589,8 @@ static int rapl_cpu_offline(unsigned int cpu)
 
 static int rapl_cpu_online(unsigned int cpu)
 {
+	unsigned int rapl_pmu_idx = get_rapl_pmu_idx(cpu);
+	const struct cpumask *rapl_pmu_cpumask = get_rapl_pmu_cpumask(cpu);
 	struct rapl_pmu *pmu = cpu_to_rapl_pmu(cpu);
 	int target;
 
@@ -579,14 +605,14 @@ static int rapl_cpu_online(unsigned int cpu)
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
 
@@ -675,7 +701,10 @@ static const struct attribute_group *rapl_attr_update[] = {
 
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
2.34.1


