Return-Path: <linux-pm+bounces-11248-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B96199375AD
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2024 11:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC6CA1C20FD8
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2024 09:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB15280C0C;
	Fri, 19 Jul 2024 09:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EFUNICHH"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC207CF30;
	Fri, 19 Jul 2024 09:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721381228; cv=fail; b=lSdF/M+n7l6YR1UNJxQ5GZ+kezIkgj+VQl7ObWUJ5s+lZAykaFz1jQl0buByTC3EmVAGii4cJM5sXVS8ukrbmHJ6qdlBNX9DHn5fiTgrf/7MHbNaqHpNtNhIvVB+wJeYUvrkcXPMjbaSjWz31YVDDPdip5fde9UAjewanW1/WlU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721381228; c=relaxed/simple;
	bh=W1rfPuI2Ps76fwniubH9otaxlgyzPkIhOmDSsuotpcE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a3l3XktWoruMYhnMeuWAyaUc1/vaCeIKBzz9+m1Z7wJoIM0IHSNR6IUF3p2NBHGJyFQMGK5AOR0mP3V0jEVM/cfl02fPbg5RrtUOp8jwoOR0vuRGObsaL4OjkxeTmJZ9+3xa12vaQ/Wv9QLfcVK36WDZ4173GzyvvWz5YtjduaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EFUNICHH; arc=fail smtp.client-ip=40.107.237.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f9fy7wGvgKSxsnHGhg65MZ+NKDGl6CIlIfsJpiGRybssERoOGbh/yArGN6EIzK+jvx+GDFnjQ9/1WnsXFuLoUOsLVITxbE/9A2lqkPFNTjCLxwiH1pi1jQMAwHwDh1BtWrj9Z9Zj/0IjbnNN+ilcWHq0sUwM703hcS+wzgjfI/C1bidRrKRYpdFNxjERbfx4jbC35pUNzxv2RMiNSBL49HgGFMDYI+i8p35DxvSM1ku0Z+KDT6z/3hKm9evTvnEZ8g0rTNOvg+s7XFZFKGxLVe76/t5Nj/mwXzyebVzj5zvdw42nVCiA+V5eBS3umXAT4gse/ZS9tybEnSW/DXg/FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hns6iUpnsStGaUm73S7UEvM3rUovbwY6xB2r8Qg1BFw=;
 b=tu2Kj8SlV2ezMCVOGqowjKcV/iQ57fov4vZZjAxjMRnJIUhAEu2Ur2nHBheb+KGy5xzubsVS3TgrP3zP4uyhYmyxJu48wYWWkhAps2ZaKOpK2jpt6H8W93ubCFSe7kt7h7An2GpcqlvAVk/lo169y6VD8jvwohyGEdoRqhB73okw0sL8MU2D8+CHhP53eW/ZYVvzdgRqiD6XZDr/+AychakGtJvnhsQlBoyTGRfMO+WMox97tVjZvdbgciySXc/At3cJtgVTzsR0SRKRdky6rdhspkCcvm6j3uYJliIJynVsWqaRaP5+X8pn4ojVOdjNNTg6AA9sJC8oi+ROASjRQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hns6iUpnsStGaUm73S7UEvM3rUovbwY6xB2r8Qg1BFw=;
 b=EFUNICHHb2Y1vmm28ehjridK1l7vxm5siuG21mHD90vz87XT+U9AiKpHYezlc+HRfDN6A0lJUVVe+BIJjQ0UjYtvQx1XvyD0+G4D23Edrtr3yWmBW71zjcdYaePcTBaHCXuif7S7iu01pwexBsGZ9BxIohFogHYi3UCWwCbFCRQ=
Received: from SA0PR11CA0060.namprd11.prod.outlook.com (2603:10b6:806:d0::35)
 by SN7PR12MB6713.namprd12.prod.outlook.com (2603:10b6:806:273::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Fri, 19 Jul
 2024 09:27:03 +0000
Received: from SA2PEPF00003AE8.namprd02.prod.outlook.com
 (2603:10b6:806:d0:cafe::2f) by SA0PR11CA0060.outlook.office365.com
 (2603:10b6:806:d0::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Fri, 19 Jul 2024 09:27:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00003AE8.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Fri, 19 Jul 2024 09:27:02 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 19 Jul
 2024 04:26:56 -0500
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
	<sandipan.das@amd.com>, <Dhananjay.Ugwekar@amd.com>
Subject: [PATCH 1/2] perf/x86/rapl: Fix the energy-pkg event for AMD CPUs
Date: Fri, 19 Jul 2024 09:25:45 +0000
Message-ID: <20240719092545.50441-2-Dhananjay.Ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240719092545.50441-1-Dhananjay.Ugwekar@amd.com>
References: <20240719092545.50441-1-Dhananjay.Ugwekar@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE8:EE_|SN7PR12MB6713:EE_
X-MS-Office365-Filtering-Correlation-Id: b7b63bec-93b5-4762-95fa-08dca7d4f2a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|36860700013|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?07Ua3secpOOq3q+EbT+lqIEMd3MJofWgyukDDOCRTmGiInA7bMwPaOuEPaJY?=
 =?us-ascii?Q?fHIwTE5duWDHKGNTlZLjRW9yvB1lLBuMV3c9D0BiKbzA9+85ny0a0zcCkBLV?=
 =?us-ascii?Q?Beiz8+ufdR9V/KeWQhqKhvegautC8Sl+qE3bwlIzV645E6GoA2rCg5CiK2AE?=
 =?us-ascii?Q?mButRGVw+lVYiyUolFBJ8qgTkeUYLV6KqYlx5DrCD+yNb9eTHLx1YmAJW+l6?=
 =?us-ascii?Q?TAFNWNe5+CNtSP3jAC8c82SZHhCbiu+JjBNxLKuIcXwgUVO9TX1t6B1xhN/c?=
 =?us-ascii?Q?vd3x1UzSYV4qYFnDEOf8Ac1rEZuTQvPESslZMQm7RmdtqVt9YxE6Lh0DtWSR?=
 =?us-ascii?Q?/B56frOMe7InqV8X1R6lR7QOUMTQsWdntxy8s6dVmBLm8lrnMNDf812Va4wp?=
 =?us-ascii?Q?zQzH/A8orQJXhH4mNMHWtylrWbkqsodGsR4oiyACxW9vcLD4wYP5cRqw1fzf?=
 =?us-ascii?Q?Ue/RaleMMvh49jM5Lm2qmyZYa7uKrhufNJEBxWmUsQe8430bfKYBoUpPabvV?=
 =?us-ascii?Q?+1mDK5MadCQvvAceHtm/ysQCVY8V2+KCYtp0uKo5IvoGEDCX5k+2GOi6CTMx?=
 =?us-ascii?Q?8bniq3yyUyT9pVwn/P5OtU4ahyhkTMk2QIZ0+cXpfiRdKgpHCiAGa2XrybvD?=
 =?us-ascii?Q?1qoyJ9DMC8j5MBlBI/n9sX+oz+ksECLZZIxhEfjtdp6L1WseRw2gRWLojCjm?=
 =?us-ascii?Q?l2QZQH79XyX51Svi0CK+d0s+9wHyLjaxdYFjw0tXX6qVdMsOVXjTMPho1vzE?=
 =?us-ascii?Q?MYOxxHXRkLj2Sr5F3HnVcLxWh1ld3kMZ9gC8Rm3UKhcdu2LFquD5soFOHrNd?=
 =?us-ascii?Q?MavtDM3FDpWkqN8qZI9bn6nFaS+ENxaAKx8r8VeW35zyN/XHTeh4kL46Bgxj?=
 =?us-ascii?Q?cX6LUHflZCPsYRrxW0YOsXIufvUCXIS6OlSHnbX5yfO3A6XuUjixIx6JEYlo?=
 =?us-ascii?Q?Bbe+5JBNwU9icL47IioKlle/9VQwF0YJcLYB/a1JdHDENpY2/Txtsnrx8amy?=
 =?us-ascii?Q?n5GYSCpiMQ4WRCoCiFyoYpsRQVtuMG0xBbkQNtO2eE1/dIG8wfikMLtwoVmX?=
 =?us-ascii?Q?aKVQ6Yx/gSDOKvsnzIZFIpFh9f3fqY9A28JgGw0WN2iJvXkh4SKXQ/1zfC90?=
 =?us-ascii?Q?qVnI1yulNuDQWsdgdSAtFN2HoGJn93f/sOYBpHRrUoGWCFd6drPccSVUYI4h?=
 =?us-ascii?Q?PqmS90qu8xTBZWa22nVbbiz6N5yERyCVI2LIClyAYGIl/v2u8dpdRt1kB59D?=
 =?us-ascii?Q?+cbNgoV1Hd5YgGCSPKDbzvY8eOo72OVnRlrGd7GAw7UE3Z6qQiWwScpUiowA?=
 =?us-ascii?Q?pnLTeE/pSh+rLwJniupcJJzQnTs6pa4B4PmPas+7HIPf+wNQojZ/Xroogqq1?=
 =?us-ascii?Q?C1cwTuPQCOHuchOD1CaraOS7i0mqP4mRfv/u9Vk58rFUb7zySgyx0siPOet4?=
 =?us-ascii?Q?f35lT3PcIOLCplL9Dg6Kp7fijT0tN4XaZW0U2oY3z1vUiijuOyVRkg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(36860700013)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 09:27:02.4673
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7b63bec-93b5-4762-95fa-08dca7d4f2a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6713

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
 arch/x86/events/rapl.c | 44 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 39 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index b985ca79cf97..6e81bb685f7c 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -103,6 +103,18 @@ static struct perf_pmu_events_attr event_attr_##v = {				\
 	.event_str	= str,							\
 };
 
+/*
+ * Intel systems that enumerate DIE domain have RAPL domains implemented
+ * per-die, however, the same is not true for AMD and Hygon processors
+ * where RAPL domains for PKG energy are in-fact per-PKG. Since
+ * logical_die_id is same as logical_package_id in absence of DIE
+ * enumeration, use topology_logical_die_id() on Intel systems and
+ * topology_logical_package_id() on AMD and Hygon systems.
+ */
+#define rapl_pmu_is_pkg_scope()				\
+	(boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||	\
+	 boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
+
 struct rapl_pmu {
 	raw_spinlock_t		lock;
 	int			n_active;
@@ -140,9 +152,25 @@ static unsigned int rapl_cntr_mask;
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
@@ -543,6 +571,7 @@ static struct perf_msr amd_rapl_msrs[] = {
 
 static int rapl_cpu_offline(unsigned int cpu)
 {
+	const struct cpumask *rapl_pmu_cpumask = get_rapl_pmu_cpumask(cpu);
 	struct rapl_pmu *pmu = cpu_to_rapl_pmu(cpu);
 	int target;
 
@@ -552,7 +581,7 @@ static int rapl_cpu_offline(unsigned int cpu)
 
 	pmu->cpu = -1;
 	/* Find a new cpu to collect rapl events */
-	target = cpumask_any_but(topology_die_cpumask(cpu), cpu);
+	target = cpumask_any_but(rapl_pmu_cpumask, cpu);
 
 	/* Migrate rapl events to the new target */
 	if (target < nr_cpu_ids) {
@@ -565,10 +594,12 @@ static int rapl_cpu_offline(unsigned int cpu)
 
 static int rapl_cpu_online(unsigned int cpu)
 {
+	const struct cpumask *rapl_pmu_cpumask = get_rapl_pmu_cpumask(cpu);
 	struct rapl_pmu *pmu = cpu_to_rapl_pmu(cpu);
 	int target;
 
 	if (!pmu) {
+		unsigned int rapl_pmu_idx = get_rapl_pmu_idx(cpu);
 		pmu = kzalloc_node(sizeof(*pmu), GFP_KERNEL, cpu_to_node(cpu));
 		if (!pmu)
 			return -ENOMEM;
@@ -579,14 +610,14 @@ static int rapl_cpu_online(unsigned int cpu)
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
 
@@ -675,7 +706,10 @@ static const struct attribute_group *rapl_attr_update[] = {
 
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


