Return-Path: <linux-pm+bounces-8860-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4931901EFD
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2024 12:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 598CD28246C
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2024 10:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B0277119;
	Mon, 10 Jun 2024 10:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="X+L09qAh"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FA875813;
	Mon, 10 Jun 2024 10:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718014255; cv=fail; b=YKMYF7UDPzohuGgFWoqjuFp981mnwoWgtxV2heL7xkyM6vvO+u/Mc1dyMn/5I8qXpha2l4Jr/Rye+NMmp1qw3bo9j5Jcr5gglP0CPEr45bNWpxUtnJwnDEeWmMn4Qxp6fuiJmyuebtsLHL+WsPJtG4bcwvUnBH/Wq/S8nNBns5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718014255; c=relaxed/simple;
	bh=wyNVrvl4bFRQCFKsoquukftNS508zhi3jzTNqeK5Qdc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xxt4vgsz6kKOjVYQCzx972VJoot//IC7EPvlKRG2gKcKwiEXj1XqtROMpOkWUf3fdSRsNRcYSEnTgcnZnWxlG6FMOigw1pT55cbP+hnE/t68F58zypvAIwSc5tgU5lBMzoNnkv/LKP5+ssTU6LnJMHCPN1MhVMV9m5/JhKAtQm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=X+L09qAh; arc=fail smtp.client-ip=40.107.223.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kf5lybA9eixaqT7kbge1ZBNvpcZTQQQ/YbdbAHsqxDBWyBKrTfX/D/4Abz+zoNJbbLeufM3bNSBUIpX2GU7S+KTsGCEeXDRYwEubi4ptKBX8h6HA+lsD0cS1GVk8eUpNnnvBbJFo/OtQOs1cC90iOCH8+xcirtfCCecYDWX3PAkZ1subYh1Nml2R3HA6b+qvoI9qTf3mro5FtC5E7aebMxRxDcTyQVnD93FTnY7PFEqUu0GIBGUvEeKbaGhX1Z0R4Xhk1ASJ3SxlKytMbwosKUrM6t5UgYa8GGWAf5oDE1pTaD7ugiZoQNRVAktAYzF6Xm2nQ0MgvyMWYr8gSz5g2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kVDHBhXnrtp4ZJIT7K/9SKlFDi/rYyeXMQ8WOy9Rcsw=;
 b=UH6aKsgpGIcE3H0Om4jvPIWu8RnAabHyJxDOHho06N5oSdxqMP2/WvgE0QA1P/1YRobGcSC/QB2ojj2tNtzu4IURqHInCLa7He/pkaerJgyWgDWWFgLCbttfLGshOQgnFzH04Zz7vVw5QdwYDe5ZDgTJfNUHFnT9+0ABRsknV5XXk2259+QRHULWQsehOjqZxnIIvnyJJtG6/Z/gHJ88OkKzPZ6gItIYI+kJ13axSGwBU5Ev0N5PNTIYWP5xXfQheMZFEM7eNXcOjeqALD24ow9k/mFC94Q8yObLNmddDzJPritWeFDq3pU1KrBz1ATiWbAcCyfW0p8BWIxmtGVnig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kVDHBhXnrtp4ZJIT7K/9SKlFDi/rYyeXMQ8WOy9Rcsw=;
 b=X+L09qAhB6EZh5QFP6fpBJbKLpWQ5m5xqcgqi20z5dYqbgUQDx6pB77z5xAAJuDlDwEi3FsX3rbZPIh4RmJjymy6Lhvr8dTOps1BvqIKmN2aLiBTMTyTlV2smyi0YzqgqGmmPbcajfWOBpAbTsrjG+5K3JnmlVx6+dRdE1On8FY=
Received: from MN2PR08CA0013.namprd08.prod.outlook.com (2603:10b6:208:239::18)
 by PH8PR12MB6937.namprd12.prod.outlook.com (2603:10b6:510:1bc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 10:10:48 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:208:239:cafe::35) by MN2PR08CA0013.outlook.office365.com
 (2603:10b6:208:239::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.24 via Frontend
 Transport; Mon, 10 Jun 2024 10:10:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 10 Jun 2024 10:10:47 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Jun
 2024 05:10:40 -0500
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
Subject: [PATCH 6/6] perf/x86/rapl: Add per-core energy counter support for AMD CPUs
Date: Mon, 10 Jun 2024 10:07:51 +0000
Message-ID: <20240610100751.4855-7-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|PH8PR12MB6937:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f97bdf2-2424-42f4-fe6e-08dc8935995b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|82310400017|1800799015|7416005|921011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HiNqrty3GnTSSuT1YWUXd70KmMe1v7VttzZfbFSjZzsxwyE7b9hEo13L0ehi?=
 =?us-ascii?Q?18B8XXrM12mvwWmXy2dYbYfBMvk7H4JJU3G5MeeVLIJHWAVC6yg4XZ/VjtaS?=
 =?us-ascii?Q?2KKBeElE2Vuii5c8LpZSnMnyph7acRe5eIzg1r1/Kqy/ZXZaYB+VFWxW/VsM?=
 =?us-ascii?Q?/l4tqM1QaUUlb4mshZBZYSJz52OvTKZ3oMZindV7zWlrvL1Y81vYb3ze8SV+?=
 =?us-ascii?Q?MtF9gA95XJez/hcfTTnB3JqP0h/hQCYkWrbWE5SjXM3h45+FZtoYMkg09M+h?=
 =?us-ascii?Q?g3uSTUYOmfqniv2+gDf5dwgX8v5D2wwASwJ2eD93Cf/ydeeJRFJuoQtT+aUM?=
 =?us-ascii?Q?8p/zqsgj8yBHoBV245H9yEzKD4rSs8ySH5qCZdXSXiGM2DIbDd4DVhq45nAb?=
 =?us-ascii?Q?hDh810fA4rlRMzasz+KPDu8U+Zq/w1SuKIJLzM3C7MuA3hLJzgjgXLibBEn2?=
 =?us-ascii?Q?uOyDI1XJs8KuZv+NQ/reknF532AgA8H9Pm0F94Mh3BiFNdAYjocYMWz4f4BP?=
 =?us-ascii?Q?LyxDiE4SoQsDS9hPVE5F1wdptbAt3VQBazxPpE8dEgj86OGMlTYBtAQkTisM?=
 =?us-ascii?Q?1qajlaTgQxGSShRB5vxjTWPldXjoLAzum0iNwd1+Q6JVKwnyFatZNYLPB1BZ?=
 =?us-ascii?Q?5xbA5fwBSrlVD2GGzxht3pJN6SjDy5/Ksg5zk4QrJPSUtG9xMHfHzMBrn4X/?=
 =?us-ascii?Q?vU3bC0GOYSFPB6cqKs2DIcsBjdqrXRY61A3CSaBmFbBMFvWf7uvpB6uDMTVj?=
 =?us-ascii?Q?PdlhTsIdjHGSX7f6i7K/hiTG2SO0f1AbF9107JHwwm9SfGowtWeBpvYlZDkw?=
 =?us-ascii?Q?74UFUWsMyTOsXFDIq/LtfEGZxeYsbCYEpZmWVjwDRsxhZmL+uBbBYz/u1ghY?=
 =?us-ascii?Q?IdS9668FqsLUTy89+kSvnLW7ohNmAw9Df4DJWffcSveA0CohQr/6krOGLW/X?=
 =?us-ascii?Q?zx1PsK6xcMIF75U4rhQ8X6fjbiUboaatuw/Qyt251bkIT00ISjkPlO+Zn4w/?=
 =?us-ascii?Q?QVBIKaSwNE9ZM2xHj0PBu/HSqGh85K1Uqf95j6EJcA+OW3+zrvh5/HHbtbqc?=
 =?us-ascii?Q?z4y0xadKoKec+x4mAK0LsR6XoI5n0/MD1ng0+VALPxAISzCqak0G4Lhb7FNJ?=
 =?us-ascii?Q?7Oc5W3Rcc4/79eF+SHLuOovT0IBMei7BZJX3ZWGocm84iY/ofnHGSwz8vujN?=
 =?us-ascii?Q?mP20GQcetVtbAn+QS+GbD+N89J4GtbitxykhYrbrWAVafwW6poWo8AZUf0Go?=
 =?us-ascii?Q?b8CXHFutYr3OySQNfqEwmVglbmsGDR0VuGAJV9+qCclqg+64v7L66yZQNQtW?=
 =?us-ascii?Q?kzCgd4P4g/mRNqihQirgaCTjkssNRI0wuamaxoqrdSfZJ81J7LbQOWSdfafz?=
 =?us-ascii?Q?ftkzTJD3Wk4OuxlnuzWPO715cPNSfBnr4+gsUMnTkalRNmyxAw5RjRXBQLn1?=
 =?us-ascii?Q?ojh4sczYIVk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400017)(1800799015)(7416005)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 10:10:47.4764
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f97bdf2-2424-42f4-fe6e-08dc8935995b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6937

Add a new "power_per_core" PMU and "energy-per-core" event for
monitoring energy consumption by each core. The existing energy-cores
event aggregates the energy consumption at the package level.
This new event aligns with the AMD's per_core energy counters.

Tested the package level and core level PMU counters with workloads
pinned to different CPUs.

Results with workload pinned to CPU 1 in core 1 on a AMD Zen4 Genoa 
machine:

$ perf stat -a --per-core -e power_per_core/energy-per-core/ sleep 1

 Performance counter stats for 'system wide':

S0-D0-C0         1          0.02 Joules power_per_core/energy-per-core/
S0-D0-C1         1          5.72 Joules power_per_core/energy-per-core/
S0-D0-C2         1          0.02 Joules power_per_core/energy-per-core/
S0-D0-C3         1          0.02 Joules power_per_core/energy-per-core/
S0-D0-C4         1          0.02 Joules power_per_core/energy-per-core/
S0-D0-C5         1          0.02 Joules power_per_core/energy-per-core/
S0-D0-C6         1          0.02 Joules power_per_core/energy-per-core/
S0-D0-C7         1          0.02 Joules power_per_core/energy-per-core/
S0-D0-C8         1          0.02 Joules power_per_core/energy-per-core/
S0-D0-C9         1          0.02 Joules power_per_core/energy-per-core/
S0-D0-C10        1          0.02 Joules power_per_core/energy-per-core/

Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
---
 arch/x86/events/rapl.c | 155 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 138 insertions(+), 17 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 70c7b35fb4d2..967ecb98748a 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -39,6 +39,10 @@
  *	  event: rapl_energy_psys
  *    perf code: 0x5
  *
+ *  per_core counter: consumption of a single physical core
+ *	  event: rapl_energy_per_core
+ *    perf code: 0x6
+ *
  * We manage those counters as free running (read-only). They may be
  * use simultaneously by other tools, such as turbostat.
  *
@@ -76,6 +80,7 @@ enum perf_rapl_events {
 	PERF_RAPL_RAM,			/* DRAM */
 	PERF_RAPL_PP1,			/* gpu */
 	PERF_RAPL_PSYS,			/* psys */
+	PERF_RAPL_PERCORE,		/* per-core */
 
 	PERF_RAPL_MAX,
 	NR_RAPL_DOMAINS = PERF_RAPL_MAX,
@@ -87,6 +92,7 @@ static const char *const rapl_domain_names[NR_RAPL_DOMAINS] __initconst = {
 	"dram",
 	"pp1-gpu",
 	"psys",
+	"per-core",
 };
 
 /*
@@ -135,11 +141,13 @@ struct rapl_model {
 	unsigned long	events;
 	unsigned int	msr_power_unit;
 	enum rapl_unit_quirk	unit_quirk;
+	bool per_core;
 };
 
  /* 1/2^hw_unit Joule */
 static int rapl_hw_unit[NR_RAPL_DOMAINS] __read_mostly;
 static struct rapl_pmus *rapl_pmus;
+static struct rapl_pmus *rapl_pmus_per_core;
 static unsigned int rapl_cntr_mask;
 static u64 rapl_timer_ms;
 static struct perf_msr *rapl_msrs;
@@ -345,9 +353,14 @@ static int rapl_pmu_event_init(struct perf_event *event)
 	u64 cfg = event->attr.config & RAPL_EVENT_MASK;
 	int bit, ret = 0;
 	struct rapl_pmu *rapl_pmu;
+	struct rapl_pmus *curr_rapl_pmus;
 
 	/* only look at RAPL events */
-	if (event->attr.type != rapl_pmus->pmu.type)
+	if (event->attr.type == rapl_pmus->pmu.type)
+		curr_rapl_pmus = rapl_pmus;
+	else if (rapl_pmus_per_core && event->attr.type == rapl_pmus_per_core->pmu.type)
+		curr_rapl_pmus = rapl_pmus_per_core;
+	else
 		return -ENOENT;
 
 	/* check only supported bits are set */
@@ -374,9 +387,14 @@ static int rapl_pmu_event_init(struct perf_event *event)
 		return -EINVAL;
 
 	/* must be done before validate_group */
-	rapl_pmu = cpu_to_rapl_pmu(event->cpu);
+	if (curr_rapl_pmus == rapl_pmus_per_core)
+		rapl_pmu = curr_rapl_pmus->rapl_pmu[topology_core_id(event->cpu)];
+	else
+		rapl_pmu = curr_rapl_pmus->rapl_pmu[get_rapl_pmu_idx(event->cpu)];
+
 	if (!rapl_pmu)
 		return -EINVAL;
+
 	event->cpu = rapl_pmu->cpu;
 	event->pmu_private = rapl_pmu;
 	event->hw.event_base = rapl_msrs[bit].msr;
@@ -408,17 +426,38 @@ static struct attribute_group rapl_pmu_attr_group = {
 	.attrs = rapl_pmu_attrs,
 };
 
+static ssize_t rapl_get_attr_per_core_cpumask(struct device *dev,
+					     struct device_attribute *attr, char *buf)
+{
+	return cpumap_print_to_pagebuf(true, buf, &rapl_pmus_per_core->cpumask);
+}
+
+static struct device_attribute dev_attr_per_core_cpumask = __ATTR(cpumask, 0444,
+								 rapl_get_attr_per_core_cpumask,
+								 NULL);
+
+static struct attribute *rapl_pmu_per_core_attrs[] = {
+	&dev_attr_per_core_cpumask.attr,
+	NULL,
+};
+
+static struct attribute_group rapl_pmu_per_core_attr_group = {
+	.attrs = rapl_pmu_per_core_attrs,
+};
+
 RAPL_EVENT_ATTR_STR(energy-cores, rapl_cores, "event=0x01");
 RAPL_EVENT_ATTR_STR(energy-pkg  ,   rapl_pkg, "event=0x02");
 RAPL_EVENT_ATTR_STR(energy-ram  ,   rapl_ram, "event=0x03");
 RAPL_EVENT_ATTR_STR(energy-gpu  ,   rapl_gpu, "event=0x04");
 RAPL_EVENT_ATTR_STR(energy-psys,   rapl_psys, "event=0x05");
+RAPL_EVENT_ATTR_STR(energy-per-core,   rapl_per_core, "event=0x06");
 
 RAPL_EVENT_ATTR_STR(energy-cores.unit, rapl_cores_unit, "Joules");
 RAPL_EVENT_ATTR_STR(energy-pkg.unit  ,   rapl_pkg_unit, "Joules");
 RAPL_EVENT_ATTR_STR(energy-ram.unit  ,   rapl_ram_unit, "Joules");
 RAPL_EVENT_ATTR_STR(energy-gpu.unit  ,   rapl_gpu_unit, "Joules");
 RAPL_EVENT_ATTR_STR(energy-psys.unit,   rapl_psys_unit, "Joules");
+RAPL_EVENT_ATTR_STR(energy-per-core.unit,   rapl_per_core_unit, "Joules");
 
 /*
  * we compute in 0.23 nJ increments regardless of MSR
@@ -428,6 +467,7 @@ RAPL_EVENT_ATTR_STR(energy-pkg.scale,     rapl_pkg_scale, "2.3283064365386962890
 RAPL_EVENT_ATTR_STR(energy-ram.scale,     rapl_ram_scale, "2.3283064365386962890625e-10");
 RAPL_EVENT_ATTR_STR(energy-gpu.scale,     rapl_gpu_scale, "2.3283064365386962890625e-10");
 RAPL_EVENT_ATTR_STR(energy-psys.scale,   rapl_psys_scale, "2.3283064365386962890625e-10");
+RAPL_EVENT_ATTR_STR(energy-per-core.scale,   rapl_per_core_scale, "2.3283064365386962890625e-10");
 
 /*
  * There are no default events, but we need to create
@@ -461,6 +501,13 @@ static const struct attribute_group *rapl_attr_groups[] = {
 	NULL,
 };
 
+static const struct attribute_group *rapl_per_core_attr_groups[] = {
+	&rapl_pmu_per_core_attr_group,
+	&rapl_pmu_format_group,
+	&rapl_pmu_events_group,
+	NULL,
+};
+
 static struct attribute *rapl_events_cores[] = {
 	EVENT_PTR(rapl_cores),
 	EVENT_PTR(rapl_cores_unit),
@@ -521,6 +568,18 @@ static struct attribute_group rapl_events_psys_group = {
 	.attrs = rapl_events_psys,
 };
 
+static struct attribute *rapl_events_per_core[] = {
+	EVENT_PTR(rapl_per_core),
+	EVENT_PTR(rapl_per_core_unit),
+	EVENT_PTR(rapl_per_core_scale),
+	NULL,
+};
+
+static struct attribute_group rapl_events_per_core_group = {
+	.name  = "events",
+	.attrs = rapl_events_per_core,
+};
+
 static bool test_msr(int idx, void *data)
 {
 	return test_bit(idx, (unsigned long *) data);
@@ -535,6 +594,7 @@ static struct perf_msr intel_rapl_msrs[] = {
 	[PERF_RAPL_RAM]  = { MSR_DRAM_ENERGY_STATUS,     &rapl_events_ram_group,   test_msr, false, RAPL_MSR_MASK },
 	[PERF_RAPL_PP1]  = { MSR_PP1_ENERGY_STATUS,      &rapl_events_gpu_group,   test_msr, false, RAPL_MSR_MASK },
 	[PERF_RAPL_PSYS] = { MSR_PLATFORM_ENERGY_STATUS, &rapl_events_psys_group,  test_msr, false, RAPL_MSR_MASK },
+	[PERF_RAPL_PERCORE] = { 0,			 &rapl_events_per_core_group,   NULL, false, 0 },
 };
 
 static struct perf_msr intel_rapl_spr_msrs[] = {
@@ -543,6 +603,7 @@ static struct perf_msr intel_rapl_spr_msrs[] = {
 	[PERF_RAPL_RAM]  = { MSR_DRAM_ENERGY_STATUS,     &rapl_events_ram_group,   test_msr, false, RAPL_MSR_MASK },
 	[PERF_RAPL_PP1]  = { MSR_PP1_ENERGY_STATUS,      &rapl_events_gpu_group,   test_msr, false, RAPL_MSR_MASK },
 	[PERF_RAPL_PSYS] = { MSR_PLATFORM_ENERGY_STATUS, &rapl_events_psys_group,  test_msr, true, RAPL_MSR_MASK },
+	[PERF_RAPL_PERCORE] = { 0,			 &rapl_events_per_core_group,   NULL, false, 0 },
 };
 
 /*
@@ -556,6 +617,7 @@ static struct perf_msr amd_rapl_msrs[] = {
 	[PERF_RAPL_RAM]  = { 0, &rapl_events_ram_group,   NULL, false, 0 },
 	[PERF_RAPL_PP1]  = { 0, &rapl_events_gpu_group,   NULL, false, 0 },
 	[PERF_RAPL_PSYS] = { 0, &rapl_events_psys_group,  NULL, false, 0 },
+	[PERF_RAPL_PERCORE] = { MSR_AMD_CORE_ENERGY_STATUS, &rapl_events_per_core_group, test_msr, false, RAPL_MSR_MASK },
 };
 
 static int __rapl_cpu_offline(struct rapl_pmus *rapl_pmus, unsigned int rapl_pmu_idx,
@@ -583,8 +645,16 @@ static int __rapl_cpu_offline(struct rapl_pmus *rapl_pmus, unsigned int rapl_pmu
 
 static int rapl_cpu_offline(unsigned int cpu)
 {
-	return __rapl_cpu_offline(rapl_pmus, get_rapl_pmu_idx(cpu),
-				  get_rapl_pmu_cpumask(cpu), cpu);
+	int ret;
+
+	ret = __rapl_cpu_offline(rapl_pmus, get_rapl_pmu_idx(cpu),
+			   get_rapl_pmu_cpumask(cpu), cpu);
+
+	if (ret == 0 && rapl_model->per_core)
+		ret = __rapl_cpu_offline(rapl_pmus_per_core, topology_core_id(cpu),
+				   topology_sibling_cpumask(cpu), cpu);
+
+	return ret;
 }
 
 static int __rapl_cpu_online(struct rapl_pmus *rapl_pmus, unsigned int rapl_pmu_idx,
@@ -622,10 +692,17 @@ static int __rapl_cpu_online(struct rapl_pmus *rapl_pmus, unsigned int rapl_pmu_
 
 static int rapl_cpu_online(unsigned int cpu)
 {
-	return __rapl_cpu_online(rapl_pmus, get_rapl_pmu_idx(cpu),
-				 get_rapl_pmu_cpumask(cpu), cpu);
-}
+	int ret;
+
+	ret = __rapl_cpu_online(rapl_pmus, get_rapl_pmu_idx(cpu),
+			   get_rapl_pmu_cpumask(cpu), cpu);
 
+	if (ret == 0 && rapl_model->per_core)
+		ret = __rapl_cpu_online(rapl_pmus_per_core, topology_core_id(cpu),
+				   topology_sibling_cpumask(cpu), cpu);
+
+	return ret;
+}
 
 static int rapl_check_hw_unit(void)
 {
@@ -687,7 +764,7 @@ static void __init rapl_advertise(void)
 	}
 }
 
-static void cleanup_rapl_pmus(void)
+static void cleanup_rapl_pmus(struct rapl_pmus *rapl_pmus)
 {
 	int i;
 
@@ -705,12 +782,15 @@ static const struct attribute_group *rapl_attr_update[] = {
 	NULL,
 };
 
-static int __init init_rapl_pmus(void)
-{
-	int nr_rapl_pmu = topology_max_packages() * topology_max_dies_per_package();
+static const struct attribute_group *rapl_per_core_attr_update[] = {
+	&rapl_events_per_core_group,
+};
 
-	if (rapl_pmu_is_pkg_scope())
-		nr_rapl_pmu = topology_max_packages();
+static int __init init_rapl_pmus(struct rapl_pmus **rapl_pmus_ptr, int nr_rapl_pmu,
+				 const struct attribute_group **rapl_attr_groups,
+				 const struct attribute_group **rapl_attr_update)
+{
+	struct rapl_pmus *rapl_pmus;
 
 	rapl_pmus = kzalloc(struct_size(rapl_pmus, rapl_pmu, nr_rapl_pmu), GFP_KERNEL);
 	if (!rapl_pmus)
@@ -728,6 +808,9 @@ static int __init init_rapl_pmus(void)
 	rapl_pmus->pmu.read		= rapl_pmu_event_read;
 	rapl_pmus->pmu.module		= THIS_MODULE;
 	rapl_pmus->pmu.capabilities	= PERF_PMU_CAP_NO_EXCLUDE;
+
+	*rapl_pmus_ptr = rapl_pmus;
+
 	return 0;
 }
 
@@ -794,9 +877,11 @@ static struct rapl_model model_spr = {
 };
 
 static struct rapl_model model_amd_hygon = {
-	.events		= BIT(PERF_RAPL_PKG),
+	.events		= BIT(PERF_RAPL_PKG) |
+			  BIT(PERF_RAPL_PERCORE),
 	.msr_power_unit = MSR_AMD_RAPL_POWER_UNIT,
 	.rapl_msrs      = amd_rapl_msrs,
+	.per_core = true,
 };
 
 static const struct x86_cpu_id rapl_model_match[] __initconst = {
@@ -853,6 +938,11 @@ static int __init rapl_pmu_init(void)
 {
 	const struct x86_cpu_id *id;
 	int ret;
+	int nr_rapl_pmu = topology_max_packages() * topology_max_dies_per_package();
+	int nr_cores = topology_max_packages() * topology_num_cores_per_package();
+
+	if (rapl_pmu_is_pkg_scope())
+		nr_rapl_pmu = topology_max_packages();
 
 	id = x86_match_cpu(rapl_model_match);
 	if (!id)
@@ -869,10 +959,23 @@ static int __init rapl_pmu_init(void)
 	if (ret)
 		return ret;
 
-	ret = init_rapl_pmus();
+	ret = init_rapl_pmus(&rapl_pmus, nr_rapl_pmu, rapl_attr_groups, rapl_attr_update);
 	if (ret)
 		return ret;
 
+	if (rapl_model->per_core) {
+		ret = init_rapl_pmus(&rapl_pmus_per_core, nr_cores,
+				     rapl_per_core_attr_groups, rapl_per_core_attr_update);
+		if (ret) {
+			/*
+			 * If initialization of per_core PMU fails, reset per_core
+			 * flag, and continue with power PMU initialization.
+			 */
+			pr_warn("Per-core PMU initialization failed (%d)\n", ret);
+			rapl_model->per_core = false;
+		}
+	}
+
 	/*
 	 * Install callbacks. Core will call them for each online cpu.
 	 */
@@ -886,14 +989,28 @@ static int __init rapl_pmu_init(void)
 	if (ret)
 		goto out1;
 
+	if (rapl_model->per_core) {
+		ret = perf_pmu_register(&rapl_pmus_per_core->pmu, "power_per_core", -1);
+		if (ret) {
+			/*
+			 * If registration of per_core PMU fails, cleanup per_core PMU
+			 * variables, reset the per_core flag and keep the
+			 * power PMU untouched.
+			 */
+			pr_warn("Per-core PMU registration failed (%d)\n", ret);
+			cleanup_rapl_pmus(rapl_pmus_per_core);
+			rapl_model->per_core = false;
+		}
+	}
 	rapl_advertise();
+
 	return 0;
 
 out1:
 	cpuhp_remove_state(CPUHP_AP_PERF_X86_RAPL_ONLINE);
 out:
 	pr_warn("Initialization failed (%d), disabled\n", ret);
-	cleanup_rapl_pmus();
+	cleanup_rapl_pmus(rapl_pmus);
 	return ret;
 }
 module_init(rapl_pmu_init);
@@ -902,6 +1019,10 @@ static void __exit intel_rapl_exit(void)
 {
 	cpuhp_remove_state_nocalls(CPUHP_AP_PERF_X86_RAPL_ONLINE);
 	perf_pmu_unregister(&rapl_pmus->pmu);
-	cleanup_rapl_pmus();
+	cleanup_rapl_pmus(rapl_pmus);
+	if (rapl_model->per_core) {
+		perf_pmu_unregister(&rapl_pmus_per_core->pmu);
+		cleanup_rapl_pmus(rapl_pmus_per_core);
+	}
 }
 module_exit(intel_rapl_exit);
-- 
2.34.1


