Return-Path: <linux-pm+bounces-9663-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4EAD910545
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2024 15:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47A6D28857D
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2024 13:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB24E1ACE6D;
	Thu, 20 Jun 2024 12:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="H3ZvOfFk"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2042.outbound.protection.outlook.com [40.107.101.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0831AC44F;
	Thu, 20 Jun 2024 12:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718888396; cv=fail; b=NUs939TmmgMmzT2MDo2SA5x1Tn6/rIU/+lRaEF+a9sJzEsjGyWhiJ4mzNgjm2WuQij/r76sp2cASP6z5JIleLU+QBp/N7sJ4KZ4UWj9Cp4xrDaKeS+q1JCyKspp3m9e6uYRCVA6tMKE+zYRLZCEOCQa9qSDdetTeo8aTEhhfY7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718888396; c=relaxed/simple;
	bh=8ayQTd/qimBdn61F5QCpbR4M/6gGUQSWoz9lIWUkteY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OQr/R7N8gDVnFvfdyxn8W5ft5+FkySTz7UhJsqGJoBsfULuUz9rE/vtg9hFKhBkbyU4fgeETpPA4059WMahX33B15CYnjngSzR0NauCUgPJbOSA5OZ45p62PQkLPVjtkTgybcUXbobfgez0bV028VIQgQaWG/1G3w0e6QKg3qAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=H3ZvOfFk; arc=fail smtp.client-ip=40.107.101.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TD2yFsz0ieprUoGE/mP96t0N/P+85/pGCyfnZRz3OPyOyKlFl82oEQMW3HrwjW5/GEwFQSqIzxQV3zp0s2xGJsjoX134fF9E9+iTffoSkkyTnU0ocp55Y3Kbl48QY/9nOD5Q6OPAgEmKwgt4FnUipqqWn+o2bW48HhUsI8YL2Gcem5iB4RAjWqNwYO3YrFJlpiObkdIv/VaJO6kJdVuOgr8Uw1AamGted5VKxfwCBDcvSaFwZkcbbCwB8Q6B7wy2GBQh8Z4pOk6RSjh36VlDVWzYUnXkOtqRUMM6EjdFslF4jRp8NGLp/B9dgE/q7nXS7hQNwOkecn9HajR2xWGErQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z1A1PMXRxwmFPpA2Kipxu5AUpAjeD2dSCqTpe8xo/ZU=;
 b=NIeZ6wijBQRSrs6gStuEggirbIsDVoSN2sNpwsxVCdxcSkQujLaILBAZSe97CBkivRyMmH6RwR3FeKsQ9J9D2G9cNs2gvoV3L6x5vpuZwSMKAgTGkDuFA/9eAagZz3Vvcckqv5fh8hVfzcjvhGNshOaaNadlrrUkP+lCxuncEHkDiEYOPUNceVwC5lPCDhIMw8oYBZbjqatdFQJ4PYtcCRtyd69Xx3O+VsPP+SMuiF8Yk+0RztY1cd8RzyWNanO2X4ShcClxMbI8stNsniPf3padGhbxufX2yKayEwww5KJidKp+uqe0qa13fOUYrTwsNBVIJUNS5kQR0U14K1vMlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z1A1PMXRxwmFPpA2Kipxu5AUpAjeD2dSCqTpe8xo/ZU=;
 b=H3ZvOfFkVyzz9e+ksjMZd7oZrwAuzraZGJ+LbItjZtz4MYLnqibxlA4e3i2k0CkRNbTUr2MMhgHFLeNO2O0a2n8qTGbl+iagfQcUM15Cxn+Rppow+8JRuvUcdV33354/yvim5XnauBycr1TRjbBaOsfF1HhZfcAtC5q7gifOnzY=
Received: from SJ0PR03CA0375.namprd03.prod.outlook.com (2603:10b6:a03:3a1::20)
 by SN7PR12MB6765.namprd12.prod.outlook.com (2603:10b6:806:26b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33; Thu, 20 Jun
 2024 12:59:52 +0000
Received: from CO1PEPF000066EC.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::d2) by SJ0PR03CA0375.outlook.office365.com
 (2603:10b6:a03:3a1::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Thu, 20 Jun 2024 12:59:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066EC.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 20 Jun 2024 12:59:50 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Jun
 2024 07:59:42 -0500
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
Subject: [PATCH v2 1/9] perf/x86/rapl: Fix the energy-pkg event for AMD CPUs
Date: Thu, 20 Jun 2024 12:56:55 +0000
Message-ID: <20240620125703.3297-2-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EC:EE_|SN7PR12MB6765:EE_
X-MS-Office365-Filtering-Correlation-Id: f41eb1b6-0e6c-4080-8966-08dc9128df3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|82310400023|7416011|376011|36860700010|921017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Eimc6sc/ART3E67Buxe8HJx6+hyadhmSpg/X4XDqktZuhzZ6xcO/Lwg7x8z2?=
 =?us-ascii?Q?y1C0RwymGpB2G35YGJaiImc5ECbgVZ8M4CzCX7KrVL9iGGCiFGkF1PSy8yVi?=
 =?us-ascii?Q?ZWz20fZtRCzBxDjjhlD9tCfBxKz2Wkz9u3pyfN4+NeqvPfS7EhYHHwHkM6P7?=
 =?us-ascii?Q?VuapGmPqPuiFjiBO4uLcnkmkaagitDscAy4sQk2/HNvSeTsYz0DWu2PBeYDM?=
 =?us-ascii?Q?vjWamh7HLojTOrT0S6tuqLJRKr1/7/OE7FojwQlwjZipzhl7oygLw6aR06sy?=
 =?us-ascii?Q?ubNGNzKpl0LDvbykRw2PoByZul/MmRTMS0S0Rl8/PavYzAqv7ezdyAqmxA5k?=
 =?us-ascii?Q?kCBVTnE1hKhXMIyEGnGeWYNmI5RYhjM5cqaxZOkR4oQTF05Ui1FUkITcVG8E?=
 =?us-ascii?Q?2nVNwq68l68ZQhpk5sYDAOhllc/xdL7fLuFh7HUNzQdGdBPBcKUoyKC5glxP?=
 =?us-ascii?Q?84f4Virx8bygTo6rwqgWjSTG7hb4H+xj5lhWEPqxhs6rA7bFk40oPOyZk0Dm?=
 =?us-ascii?Q?Qz85leT9u7Fd9HTdvBrjmo0xtqbzIvp/QIK7SzoIYf7nsOnw2qWF8jDImMbW?=
 =?us-ascii?Q?Sb6iDMOkCcCQ2dFleSPvlqil4nYoO6R4dUgiCOL6PiKa2qxgHc1yIAKH7ClX?=
 =?us-ascii?Q?CoWCgJ3M2LiWx/oLrF8b12SRSb2DYWzS3T6R/wmWSbdBhBj17GgzAmVu11jU?=
 =?us-ascii?Q?4B/DfLJmRti+pzPbmRUuDau8/fR7kXVTrXesBdQajr8NOqpA00gZcC7fjMvF?=
 =?us-ascii?Q?6f0EDXg+Jo/Na+5tdGORsldkhcyxPrE/8B8MTp+hgvNTjzlDHWRYMHyvQjOU?=
 =?us-ascii?Q?OfpcwsFLavb9AmQl6YTRoz0oXOGads4J4f9bCKfhUhKDkbWfEFrP9B7xDKRt?=
 =?us-ascii?Q?q33mrChvk7Yoo/5OdyxCMMZjwLEAp2z5cSp3L8D/ErUq7EcDcK+xFBrc8W4i?=
 =?us-ascii?Q?2Cyb2C3DGFrPzXd2eIQYGe8A/UPCCvb5a7dN0x3T2hroi3xZkKHM6fMu4BjA?=
 =?us-ascii?Q?TWKTK2PNNFq8hJ0REHnqE96VLunQ9A+XbYMmOWg6Nf/bYLWg6ar/5gVVgvdX?=
 =?us-ascii?Q?+EEz78u0Gh850OzyT89KeTNshn8IHk00AV69blYoIkeTaiyJ9I7KzuUOdPhR?=
 =?us-ascii?Q?qHsNim1gXL5OLS2PIHHt4S3VYreOi3X6hbNzVkmG3pI5D3Ze6upW9jKwePel?=
 =?us-ascii?Q?c090hXMHbwH622dC9nBjztRzHw/3eNf3iIz/ewk+cPb0EfxU+eRl5vXdU6rS?=
 =?us-ascii?Q?RpyZ2/GOzRXOv7gPLqJkjr5MBLbn15Q8Xu8sayyTV0FJNNo5IUscpJ3xYFqt?=
 =?us-ascii?Q?rs0wX4WKswc/cIdtSaEH+xCZLD1A/4tFryR7KCLqrpl73tDxFaQuD+lngou2?=
 =?us-ascii?Q?Np0yvikVcDHih2WBdb6EzNigwwO5EaolKNCqJcFKQ+j03k/IAw6KQ8Dg13fX?=
 =?us-ascii?Q?EfEuLfihiWY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(1800799021)(82310400023)(7416011)(376011)(36860700010)(921017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 12:59:50.7833
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f41eb1b6-0e6c-4080-8966-08dc9128df3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6765

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


