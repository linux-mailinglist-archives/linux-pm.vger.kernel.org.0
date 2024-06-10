Return-Path: <linux-pm+bounces-8855-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF46901EF5
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2024 12:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20E052820A6
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2024 10:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EDF763EE;
	Mon, 10 Jun 2024 10:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="K7AlSc3/"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC79575817;
	Mon, 10 Jun 2024 10:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718014141; cv=fail; b=YTb9PnARPmIGjfJsAITxijh6X4gPPnUXKvOBKBpK1i/y0SSyz+5njC0fVcnRfCUGCTLwKhDNR2elJPx1gh8N24UnLgXQk5cK1HxQhiafJ/RVvYAF1LS9Yuz4C7cUtAN9SjIR3TMAlIse7FoMrsOegQLIx0fpqGU5hnUPVgG+nUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718014141; c=relaxed/simple;
	bh=qn4QSXEBuMAxwSFcshG+xvUo6hiIugyW1ER10YIoyOg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c1hQxMS4BOt0WL/OCe9nUjOH5OM4JxJWau2SoQ2Ewb+tYfqnc6E/XXnSvoNdvwdv7lv/ESM+DmbdqS+6waG18fXLVDuE1Wj2Gwh3JgNxQfUvqR5/pY0a8xpI65eyxbscRtxdY1Zbhy1xHPw5G7pl38dLWOFHfsCo+mXF/9XXiYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=K7AlSc3/; arc=fail smtp.client-ip=40.107.220.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lU0uDis7iXyTzyUsUggvoZhkfHb2kMVtNdAoEsI0PNyRrprN1vqyEj9q55c52qc4Oo3H7KBrJuRh+XNBXqKn9/pXF5IGVeFRfVx6daN61cBf3QnrQE/DdKDV3M+KeK4BPR40ZrbdHgTndnFiu8CTKMvc5LJE5Dpl7gIDRRN78y77AWjI3k7ezkxFzOgnmEc+5mB1aRyZdLiT8OWQH2DWC+o++FdZMJ/J3GlYChglo+GT63LRK3XxzzvFwVJCWGfLF/TLTOPBzfr9JSd94pfY87Mzg3loqrTgF+oA6jHQZqc7kkJ5yjBKd8B4c0++dEh0lB1B2K7jFJzqWoE07ZFlCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sDPTx32JggWUEdYkSXzvDNA8885xCgOuvVluLwNl/wg=;
 b=SzP6EdvFg+S8Lysl77YzoEnW4yOmk8yUzgUkPCQXDnGNjvit3N/SC0D6Tiv9arrQMxJhraIS+Ar0V8eWhRTaj5OcgSy2umA/w23UKZUtKM1lXwQ3MZJtVQHTMdv+YxVXyY0OAorFvCSak+E2Hd7L441K/Exssz7fE+0BSJjMaieOt4dLlMNHd3Eoqd8OV+ONFe8Du/aJuo2ErN9P6VpVmBb2DIFzxlC6pckygfHLTpAN3PUFsL8U9cjdFXtp/b0aB8J+1QEUQoNQnteQBZnzCnUztCSRXToPGESmEyXHubgdq1eWHXmDea5AKc7ascGSmLmMTWuz24ejrYNlqdxnjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDPTx32JggWUEdYkSXzvDNA8885xCgOuvVluLwNl/wg=;
 b=K7AlSc3/nisMxS546LsYaag0xwMJyJHpPg3bslFzux55fKdN3HB5157fAzevfv6nWNOVfGHNwBd5q3Nj++T6Vd9DXsvLRCkLKu9anfyU/1x42fOYsrMSm2bQCGfSMdSE2Cwsky1UDZ44WE6Yv6LwabZizwVIz7XltiNmH+89Cfk=
Received: from PH2PEPF00003849.namprd17.prod.outlook.com (2603:10b6:518:1::66)
 by SN7PR12MB7024.namprd12.prod.outlook.com (2603:10b6:806:26e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 10:08:55 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2a01:111:f403:c936::) by PH2PEPF00003849.outlook.office365.com
 (2603:1036:903:48::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.21 via Frontend
 Transport; Mon, 10 Jun 2024 10:08:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 10 Jun 2024 10:08:55 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Jun
 2024 05:08:48 -0500
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
Subject: [PATCH 1/6] perf/x86/rapl: Fix the energy-pkg event for AMD CPUs
Date: Mon, 10 Jun 2024 10:07:46 +0000
Message-ID: <20240610100751.4855-2-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|SN7PR12MB7024:EE_
X-MS-Office365-Filtering-Correlation-Id: 65c093b1-3f63-4455-cc23-08dc89355652
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|36860700004|376005|82310400017|1800799015|921011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z6jOhSuO/ikK9rtjbT6O8nc+HgLecQvoSc3VIbq9daHlo/T6IAt/VVUof6bI?=
 =?us-ascii?Q?Kf45IyEvkHqiIPqQsMAXTCZVAXWf/czSmI+f4dp34BD60poFWK2kS54eHv8d?=
 =?us-ascii?Q?DuFUOX/MyI28nde/674Pgvv9jxt87Sy/LsbVh6ba5PmQjmnju5SwEpxBqZte?=
 =?us-ascii?Q?QsRXowuQ1kJ5ZcQZC44tjvTBEusQ93pbuY9gV8+sUM9TBZqHJ4Gb0nXY7CvT?=
 =?us-ascii?Q?GU1WlDP5Nt4GWhVRD0tlQuHTieQg5wtuR5bVbW6Ngjre64Gdrrzb/3Hhd4mv?=
 =?us-ascii?Q?EvEX/rGVYbDEfoTF8XnptsujxsLWum68+Cre7LA0TEEn0uBvavNb49qMH9sz?=
 =?us-ascii?Q?e0FSYcTHnplwahvYSSSBa9ja3HXKOTrFVfp1W557yTFjcgkzT3t07CmDGsc+?=
 =?us-ascii?Q?gDwKJg4AByLAHPcvRWCeRv+ScrUzjYXGToG2OoxUGD0idmvNALFuLoouXiqC?=
 =?us-ascii?Q?ryn7+FhtoFjajjL6reH8hc3De/S+gL9liO/KPo0qZPMy3uJzI09mZ0A6899W?=
 =?us-ascii?Q?cZk+Rn1laXwAGz9eM9KKuUFWLTh1JkhBUrwxD7X+5E5gTiTXhbd9lRk4bQqA?=
 =?us-ascii?Q?4yH2a+ikcyzJ2C85qsFY9UKmo1pjLVAmBFRVY7OMwmjkflsVHYvxzbQ3BiDR?=
 =?us-ascii?Q?AkhzMmlKXOxiC+vaRysgBeW+ZK6QnqAnVp/+9v6zYbsFtOykr/It3ynUSoxN?=
 =?us-ascii?Q?ZXQ1YW5UR5wFBpB+NZ/ziTXSq7qj/NY6MCocxhcp7wpB8g/2VBJsBUFKXhL+?=
 =?us-ascii?Q?uPgDvnUfXeRQlBDo7i5J6O0gkf/+0uo+Yj0ERou9lIjhZIq/XxQ8bxnz7sIE?=
 =?us-ascii?Q?KJt5Z0zv+XfQcxCrq1CLLCJYStOC+jIUEraTUAYQfQbHI/WPzXW2TbX4U9Qk?=
 =?us-ascii?Q?qVLvY9tXq/G363/9zrkSamqGkq6L25aOzHACa1baOJ3vopptMMsW/DQoEdo7?=
 =?us-ascii?Q?sXpfkdKLAOH0nhbmA9y6YrMP/b6nzxUHr/dUS7GIoMC0i2w3pML+dFo0PdJq?=
 =?us-ascii?Q?b250AoHr8+n8fawqtVwPYFWNE5hlhi9VvqsryxxVQhiD2EW3rgtdRnuimqcQ?=
 =?us-ascii?Q?8LqaqdOsxXviPykYp33lyMJJHmwZBlFVvDK13/1DXlBuHnw9PKUg8u8dNPfp?=
 =?us-ascii?Q?pOMka6O8wBp2IdIGB3QdmWJcVyuwOKjTge24d248EIE/n1nIiQtlBHPOKPuT?=
 =?us-ascii?Q?sRKkDL+6mhNejDMugYZ0U8z5n6E3OUjoyVSZPRPkQu2HJeq/pfT0wgMMPJyv?=
 =?us-ascii?Q?EXW16GXXFg4W27Uu3GAiFXR/0UbNx8515Rfxz1pQfXtot/1PEdUEAFeIdAoo?=
 =?us-ascii?Q?+Hry+scB7IwI1uZHG1KGbyedzQ23PwrTD9SemqzB8gf0H92JQ/HcnKDHYZmW?=
 =?us-ascii?Q?ghIhbxMzvXWEJwLMvaK90vgTU7c0IFOGn+KC6As58Txd59KYJOwKzFnO+xXO?=
 =?us-ascii?Q?hFXpTcfZSnc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(7416005)(36860700004)(376005)(82310400017)(1800799015)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 10:08:55.3056
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65c093b1-3f63-4455-cc23-08dc89355652
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7024

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
PS: This patch was earlier sent separately(link below), it has not been 
merged yet, it is necessary for this patchset to work properly, also it 
fixes the pre-existing energy-pkg event.
https://lore.kernel.org/linux-perf-users/20240502095115.177713-1-Dhananjay.Ugwekar@amd.com/
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


