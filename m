Return-Path: <linux-pm+bounces-9671-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2530D91056B
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2024 15:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C9411F21454
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2024 13:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3A51B3733;
	Thu, 20 Jun 2024 13:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XsRpcGPE"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61861AD9EB;
	Thu, 20 Jun 2024 13:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718888617; cv=fail; b=ZXHi3kXDT/Lgq2WnqgB5f6TOVrJAZRltizhW7ESvP10gXgdHIQG0uiwxhOh+tOsg46Wx5HXiDVvdL2luJMZkjuejVagKT89rVQj5EwzEC4K+4Mhg8CgRrd4iSmGSPU/UIgZDMOqUc6MDLiKktE/WMVXCLlnPqLCXGl9+Hjf8kus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718888617; c=relaxed/simple;
	bh=Amentt0H3twmUDlPXsddTGxJkRRSZOY2oVtYB6C9o30=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=li39xO47UCIfTiVrH7A3EdS43Cq/QrMc2tMfkkuCfl7Z4EgTplsPX86hKficfMM50MeI+yKUhUv9P7h3MnUcclN4+7aWMlXK38qHhYCqAgT13dv/ywjd771sYgh5rE5TYIw+HfOLG3K0EbWPkWN1P49Im3iJNkTdIIysU1QR+2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XsRpcGPE; arc=fail smtp.client-ip=40.107.237.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JmG2kqCWKiC5Du1sYJhx5OWpDwtMugwho5SLqx/GI3OqRTQD9IeXlh/HwAs/kjXs84Ld22XgvoXmkaoWa2tOLZcLPCGSRp6a1L8xaYeMmfAu9XbC/l5iROKpdDn/NZ9Ks3QZSaZOP4wcbVkZ3drQJcd2E4KPF7jEpSkzSOo7f6U5Tp7w98mPw4NKYk8B4kpprXsYElLJ2vOtRHB3HCrQIlUL2udH6enFw+hZrj5r4EEXM0S1cDowbQ9sZza1rbBS6br+9VZ2L++Jh367as10sFTxsPIjeCLk3jXWBmtvfdiB3fmANzHsy0EpmzhiAv+97PTlisYwZk9bWlEzADPaCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VZXAEwoZw+j6dX9KzhPjof75Yc3UEPdLNIoTHGWVkZU=;
 b=PulQ+Mn1AliehBXx12GAZTT+5E1qFB6niPwOo55Fa27w3E3LW/MRyMfIaQDkKJ1pZ8UMti9eDoSIbNYYmdsdjutYNfgk4bAcfg9UDGC4p3yoXsUYmv3SiquwnMLh/KgZvwHqER296Sij64D78w+M7lK/CXtYN+Gf9iZawJMqV+bGbuegia8lI2vKb5EeFzmR+VoUPM+HiRtSBsjhAFvZibErR/fjVnUBEJkLJmHHKpkCAn5bwDJldxOoD3aJNe5AMPBWOPFvvW2y22QOlIWAHzfUEi7udbDz3Ev0SBgFxFLjq5t9BeBxQGC5pi9eP0NoudVrewb7d48UtNcnZt18kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VZXAEwoZw+j6dX9KzhPjof75Yc3UEPdLNIoTHGWVkZU=;
 b=XsRpcGPEXGkNgtojIkZFxIsD0aH4IEU4Wj+Cs62jEjPj8qdVz4hCI892sUNF0ZR/2G2ssLFB3sIJRyRWR69ZFoHJTox6m6MAbq1H/YTQxZ2UH8IjZo49AxWrNEuc4jkdhKOfBzohKVSYq7r2fP0ey4VZo5gBZPIHkDvK3dlyzXg=
Received: from BL0PR1501CA0017.namprd15.prod.outlook.com
 (2603:10b6:207:17::30) by CYYPR12MB8892.namprd12.prod.outlook.com
 (2603:10b6:930:be::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Thu, 20 Jun
 2024 13:03:31 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:207:17:cafe::c5) by BL0PR1501CA0017.outlook.office365.com
 (2603:10b6:207:17::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Thu, 20 Jun 2024 13:03:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 20 Jun 2024 13:03:30 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Jun
 2024 08:03:22 -0500
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
Subject: [PATCH v2 9/9] perf/x86/rapl: Add per-core energy counter support for AMD CPUs
Date: Thu, 20 Jun 2024 12:57:03 +0000
Message-ID: <20240620125703.3297-10-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|CYYPR12MB8892:EE_
X-MS-Office365-Filtering-Correlation-Id: 76755836-7387-4858-36d5-08dc91296264
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|7416011|376011|36860700010|82310400023|1800799021|921017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?STvKLjZFPTC4Zt7egqPu6OPX+YWNrqL0OLIC+9BsxWtQkwisT9J0wDW0H2Eo?=
 =?us-ascii?Q?AE9O6F26448CldW/QiALi/Vm+jtyEQm73PM4Iq/6huXBl+MZNnlzhrOffEw/?=
 =?us-ascii?Q?ZIUAS8eVKo4yB8CsVq9E9lD2KbtVVAKoa7JG1V3UAwSrvTbahJ0+5yDL/8ZG?=
 =?us-ascii?Q?1X/1sCXiDyyg7376oN345raHVRBdycugeBI0IYtORfxm8UUIgLC2o3hN4Eqy?=
 =?us-ascii?Q?sHmL4PjItCJJFuAlFXBQSDqqgyNDA/kTIh8ImURwluwMHrKXcikrs1w08DoM?=
 =?us-ascii?Q?qdr1sCWce5yE1kP4UznP11gIR9/fM29y0E9E8JSDkIVuSFqb/rB5vMuLK5jB?=
 =?us-ascii?Q?NpfAHhQu0+W3hqNX0AjcBhjjrrZ79o7JOTRiP9tioZ52xvXACSnw331vqy82?=
 =?us-ascii?Q?JCVe7B35YYT+H9P8vzXwVEbC/nBXiCR9pOgWFogogselzP5S5J67I1CfzsDl?=
 =?us-ascii?Q?LYP3f4tJcY7XE/fIaiZDy09zRPhXvlXp6HelXLY/b7PsjNaRy+mIWSyHIpuA?=
 =?us-ascii?Q?4SefFqMlwSCfhsThn8H0WIXvjVgj+fk+yF5Y8LR/JUws/6EiKbabljgY7KqX?=
 =?us-ascii?Q?crzGNICIuHmu7cgtpW1nI08FWLOb95waXErAfTwMnuyN40tS75/eni6veAbt?=
 =?us-ascii?Q?8M/2H/WBAceoJM68dCy8r0Wq/X/qiB0GKF8ZmZJ4DsfQsyVahq9M5qf4/fyC?=
 =?us-ascii?Q?HBt+A3uRozpdxOgFY3PofcF1KUFc2tDnu08baW2d7652eXOJsvOWczmhOuXu?=
 =?us-ascii?Q?eGHA/MEQNxrzJQnvwt9Ir+OsmQeiFGaoUYzrrh/S8kXv6vAtWfuY790Yn7AJ?=
 =?us-ascii?Q?l7KtmLJnLg8oytw6JnB9eG4occcZwEVZNZFyKtR3MvJGe32LB598UYAKXsiW?=
 =?us-ascii?Q?kyZmDQIOLMg7QD/w7BKQjVMSJPRHpMSymDHDyl5sKrqUGnnlmuqAHnXt5X13?=
 =?us-ascii?Q?Uc8QX98y2dmTUhgh7qWTkHjZVx5RjHFBkEzaUoqQ2VLJK507uc13GNnU0yJp?=
 =?us-ascii?Q?hnNwgU4xTXx5smYU5oo4OHrXa/NuKcp8eGF3lzGwF/g3VqUbi90qYuQmsg9t?=
 =?us-ascii?Q?DjAEXx16bH/YExgnKtLRAOYg9qQlm5MC00un8TG8gOAQPqueEeo2dkT/lgto?=
 =?us-ascii?Q?yI+Rw1HbADnnPKy3UutHcIbz9V6Dhw3A+BixOqLFIDZVgae3nlRfu2nJaXG+?=
 =?us-ascii?Q?/TDiC1sjk8LXsaFumm6ruUENswZ3nHwpRZwBZrY0UOHP8/oBG/ZEDR3G5b0I?=
 =?us-ascii?Q?Qq0TdIYJTzMlckLjOl0feqiVv3AGN0If/ozErrIgiuFMsK8lEE3kuSu2UzHU?=
 =?us-ascii?Q?K+zBjp01noWfzwXQbMWXFX0VSiY4VdjrWTGKX6XSuFeV7dLrDnSvxdyUiYIQ?=
 =?us-ascii?Q?SLMNq1csSuQK4mdS3zOUqU6s7yrlquHQYYGNYfyRKS+aZk6USyscUbHRd6r/?=
 =?us-ascii?Q?pnCNY7bmoNY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(7416011)(376011)(36860700010)(82310400023)(1800799021)(921017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 13:03:30.8939
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76755836-7387-4858-36d5-08dc91296264
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8892

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
v2 changes:
* Patches 6,7,8 added to split some changes out of the last patch
* Use container_of to get the rapl_pmus from event variable (Rui)
* Set PERF_EV_CAP_READ_ACTIVE_PKG flag only for pkg scope PMU (Rui)
* Use event id 0x1 for energy-per-core event (Rui)
* Use PERF_RAPL_PER_CORE bit instead of adding a new flag to check for
  per-core counter hw support (Rui)
---
 arch/x86/events/rapl.c | 189 +++++++++++++++++++++++++++++++++++------
 1 file changed, 164 insertions(+), 25 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index e962209e9e4d..b18f76b5242d 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -39,6 +39,10 @@
  *	  event: rapl_energy_psys
  *    perf code: 0x5
  *
+ *  per_core counter: consumption of a single physical core
+ *	  event: rapl_energy_per_core (power_per_core PMU)
+ *    perf code: 0x1
+ *
  * We manage those counters as free running (read-only). They may be
  * use simultaneously by other tools, such as turbostat.
  *
@@ -81,6 +85,13 @@ enum perf_rapl_pkg_events {
 	NR_RAPL_PKG_DOMAINS = PERF_RAPL_PKG_EVENTS_MAX,
 };
 
+enum perf_rapl_core_events {
+	PERF_RAPL_PER_CORE = 0,		/* per-core */
+
+	PERF_RAPL_CORE_EVENTS_MAX,
+	NR_RAPL_CORE_DOMAINS = PERF_RAPL_CORE_EVENTS_MAX,
+};
+
 static const char *const rapl_pkg_domain_names[NR_RAPL_PKG_DOMAINS] __initconst = {
 	"pp0-core",
 	"package",
@@ -89,6 +100,10 @@ static const char *const rapl_pkg_domain_names[NR_RAPL_PKG_DOMAINS] __initconst
 	"psys",
 };
 
+static const char *const rapl_core_domain_names[NR_RAPL_CORE_DOMAINS] __initconst = {
+	"per-core",
+};
+
 /*
  * event code: LSB 8 bits, passed in attr->config
  * any other bit is reserved
@@ -131,8 +146,10 @@ enum rapl_unit_quirk {
 };
 
 struct rapl_model {
-	struct perf_msr *rapl_msrs;
+	struct perf_msr *rapl_pkg_msrs;
+	struct perf_msr *rapl_core_msrs;
 	unsigned long	pkg_events;
+	unsigned long	core_events;
 	unsigned int	msr_power_unit;
 	enum rapl_unit_quirk	unit_quirk;
 };
@@ -140,7 +157,9 @@ struct rapl_model {
  /* 1/2^hw_unit Joule */
 static int rapl_hw_unit[NR_RAPL_PKG_DOMAINS] __read_mostly;
 static struct rapl_pmus *rapl_pmus_pkg;
+static struct rapl_pmus *rapl_pmus_core;
 static unsigned int rapl_pkg_cntr_mask;
+static unsigned int rapl_core_cntr_mask;
 static u64 rapl_timer_ms;
 static struct rapl_model *rapl_model;
 
@@ -345,9 +364,13 @@ static int rapl_pmu_event_init(struct perf_event *event)
 	u64 cfg = event->attr.config & RAPL_EVENT_MASK;
 	int bit, ret = 0;
 	struct rapl_pmu *rapl_pmu;
+	struct rapl_pmus *curr_rapl_pmus;
 
 	/* only look at RAPL events */
-	if (event->attr.type != rapl_pmus_pkg->pmu.type)
+	if (event->attr.type == rapl_pmus_pkg->pmu.type ||
+		(rapl_pmus_core && event->attr.type == rapl_pmus_core->pmu.type))
+		curr_rapl_pmus = container_of(event->pmu, struct rapl_pmus, pmu);
+	else
 		return -ENOENT;
 
 	/* check only supported bits are set */
@@ -357,7 +380,8 @@ static int rapl_pmu_event_init(struct perf_event *event)
 	if (event->cpu < 0)
 		return -EINVAL;
 
-	event->event_caps |= PERF_EV_CAP_READ_ACTIVE_PKG;
+	if (curr_rapl_pmus == rapl_pmus_pkg)
+		event->event_caps |= PERF_EV_CAP_READ_ACTIVE_PKG;
 
 	if (!cfg || cfg >= NR_RAPL_PKG_DOMAINS + 1)
 		return -EINVAL;
@@ -366,7 +390,8 @@ static int rapl_pmu_event_init(struct perf_event *event)
 	bit = cfg - 1;
 
 	/* check event supported */
-	if (!(rapl_pkg_cntr_mask & (1 << bit)))
+	if (!(rapl_pkg_cntr_mask & (1 << bit)) &&
+	    !(rapl_core_cntr_mask & (1 << bit)))
 		return -EINVAL;
 
 	/* unsupported modes and filters */
@@ -374,12 +399,18 @@ static int rapl_pmu_event_init(struct perf_event *event)
 		return -EINVAL;
 
 	/* must be done before validate_group */
-	rapl_pmu = cpu_to_rapl_pmu(event->cpu);
+	if (curr_rapl_pmus == rapl_pmus_core) {
+		rapl_pmu = curr_rapl_pmus->rapl_pmu[topology_core_id(event->cpu)];
+		event->hw.event_base = rapl_model->rapl_core_msrs[bit].msr;
+	} else {
+		rapl_pmu = curr_rapl_pmus->rapl_pmu[get_rapl_pmu_idx(event->cpu)];
+		event->hw.event_base = rapl_model->rapl_pkg_msrs[bit].msr;
+	}
+
 	if (!rapl_pmu)
 		return -EINVAL;
 	event->cpu = rapl_pmu->cpu;
 	event->pmu_private = rapl_pmu;
-	event->hw.event_base = rapl_model->rapl_msrs[bit].msr;
 	event->hw.config = cfg;
 	event->hw.idx = bit;
 
@@ -408,17 +439,38 @@ static struct attribute_group rapl_pmu_attr_group = {
 	.attrs = rapl_pmu_attrs,
 };
 
+static ssize_t rapl_get_attr_per_core_cpumask(struct device *dev,
+					     struct device_attribute *attr, char *buf)
+{
+	return cpumap_print_to_pagebuf(true, buf, &rapl_pmus_core->cpumask);
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
+RAPL_EVENT_ATTR_STR(energy-per-core,   rapl_per_core, "event=0x01");
 
 RAPL_EVENT_ATTR_STR(energy-cores.unit, rapl_cores_unit, "Joules");
 RAPL_EVENT_ATTR_STR(energy-pkg.unit  ,   rapl_pkg_unit, "Joules");
 RAPL_EVENT_ATTR_STR(energy-ram.unit  ,   rapl_ram_unit, "Joules");
 RAPL_EVENT_ATTR_STR(energy-gpu.unit  ,   rapl_gpu_unit, "Joules");
 RAPL_EVENT_ATTR_STR(energy-psys.unit,   rapl_psys_unit, "Joules");
+RAPL_EVENT_ATTR_STR(energy-per-core.unit,   rapl_per_core_unit, "Joules");
 
 /*
  * we compute in 0.23 nJ increments regardless of MSR
@@ -428,6 +480,7 @@ RAPL_EVENT_ATTR_STR(energy-pkg.scale,     rapl_pkg_scale, "2.3283064365386962890
 RAPL_EVENT_ATTR_STR(energy-ram.scale,     rapl_ram_scale, "2.3283064365386962890625e-10");
 RAPL_EVENT_ATTR_STR(energy-gpu.scale,     rapl_gpu_scale, "2.3283064365386962890625e-10");
 RAPL_EVENT_ATTR_STR(energy-psys.scale,   rapl_psys_scale, "2.3283064365386962890625e-10");
+RAPL_EVENT_ATTR_STR(energy-per-core.scale,   rapl_per_core_scale, "2.3283064365386962890625e-10");
 
 /*
  * There are no default events, but we need to create
@@ -461,6 +514,13 @@ static const struct attribute_group *rapl_attr_groups[] = {
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
@@ -521,6 +581,18 @@ static struct attribute_group rapl_events_psys_group = {
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
@@ -558,6 +630,11 @@ static struct perf_msr amd_rapl_pkg_msrs[] = {
 	[PERF_RAPL_PSYS] = { 0, &rapl_events_psys_group,  NULL, false, 0 },
 };
 
+static struct perf_msr amd_rapl_core_msrs[] = {
+	[PERF_RAPL_PER_CORE] = { MSR_AMD_CORE_ENERGY_STATUS, &rapl_events_per_core_group,
+				 test_msr, false, RAPL_MSR_MASK },
+};
+
 static int __rapl_cpu_offline(struct rapl_pmus *rapl_pmus, unsigned int rapl_pmu_idx,
 			      const struct cpumask *event_cpumask, unsigned int cpu)
 {
@@ -583,8 +660,14 @@ static int __rapl_cpu_offline(struct rapl_pmus *rapl_pmus, unsigned int rapl_pmu
 
 static int rapl_cpu_offline(unsigned int cpu)
 {
-	return __rapl_cpu_offline(rapl_pmus_pkg, get_rapl_pmu_idx(cpu),
+	int ret =  __rapl_cpu_offline(rapl_pmus_pkg, get_rapl_pmu_idx(cpu),
 				  get_rapl_pmu_cpumask(cpu), cpu);
+
+	if (ret == 0 && rapl_model->core_events)
+		ret = __rapl_cpu_offline(rapl_pmus_core, topology_core_id(cpu),
+				   topology_sibling_cpumask(cpu), cpu);
+
+	return ret;
 }
 
 static int __rapl_cpu_online(struct rapl_pmus *rapl_pmus, unsigned int rapl_pmu_idx,
@@ -622,8 +705,14 @@ static int __rapl_cpu_online(struct rapl_pmus *rapl_pmus, unsigned int rapl_pmu_
 
 static int rapl_cpu_online(unsigned int cpu)
 {
-	return __rapl_cpu_online(rapl_pmus_pkg, get_rapl_pmu_idx(cpu),
+	int ret =  __rapl_cpu_online(rapl_pmus_pkg, get_rapl_pmu_idx(cpu),
 				 get_rapl_pmu_cpumask(cpu), cpu);
+
+	if (ret == 0 && rapl_model->core_events)
+		ret = __rapl_cpu_online(rapl_pmus_core, topology_core_id(cpu),
+				   topology_sibling_cpumask(cpu), cpu);
+
+	return ret;
 }
 
 
@@ -677,7 +766,7 @@ static void __init rapl_advertise(void)
 	int i;
 
 	pr_info("API unit is 2^-32 Joules, %d fixed counters, %llu ms ovfl timer\n",
-		hweight32(rapl_pkg_cntr_mask), rapl_timer_ms);
+		hweight32(rapl_pkg_cntr_mask) + hweight32(rapl_core_cntr_mask), rapl_timer_ms);
 
 	for (i = 0; i < NR_RAPL_PKG_DOMAINS; i++) {
 		if (rapl_pkg_cntr_mask & (1 << i)) {
@@ -685,6 +774,13 @@ static void __init rapl_advertise(void)
 				rapl_pkg_domain_names[i], rapl_hw_unit[i]);
 		}
 	}
+
+	for (i = 0; i < NR_RAPL_CORE_DOMAINS; i++) {
+		if (rapl_core_cntr_mask & (1 << i)) {
+			pr_info("hw unit of domain %s 2^-%d Joules\n",
+				rapl_core_domain_names[i], rapl_hw_unit[i]);
+		}
+	}
 }
 
 static void cleanup_rapl_pmus(struct rapl_pmus *rapl_pmus)
@@ -705,15 +801,16 @@ static const struct attribute_group *rapl_attr_update[] = {
 	NULL,
 };
 
-static int __init init_rapl_pmus(struct rapl_pmus **rapl_pmus_ptr)
+static const struct attribute_group *rapl_per_core_attr_update[] = {
+	&rapl_events_per_core_group,
+};
+
+static int __init init_rapl_pmus(struct rapl_pmus **rapl_pmus_ptr, int nr_rapl_pmu,
+				 const struct attribute_group **rapl_attr_groups,
+				 const struct attribute_group **rapl_attr_update)
 {
 	struct rapl_pmus *rapl_pmus;
 
-	int nr_rapl_pmu = topology_max_packages() * topology_max_dies_per_package();
-
-	if (rapl_pmu_is_pkg_scope())
-		nr_rapl_pmu = topology_max_packages();
-
 	rapl_pmus = kzalloc(struct_size(rapl_pmus, rapl_pmu, nr_rapl_pmu), GFP_KERNEL);
 	if (!rapl_pmus)
 		return -ENOMEM;
@@ -741,7 +838,7 @@ static struct rapl_model model_snb = {
 			  BIT(PERF_RAPL_PKG) |
 			  BIT(PERF_RAPL_PP1),
 	.msr_power_unit = MSR_RAPL_POWER_UNIT,
-	.rapl_msrs      = intel_rapl_msrs,
+	.rapl_pkg_msrs	= intel_rapl_msrs,
 };
 
 static struct rapl_model model_snbep = {
@@ -749,7 +846,7 @@ static struct rapl_model model_snbep = {
 			  BIT(PERF_RAPL_PKG) |
 			  BIT(PERF_RAPL_RAM),
 	.msr_power_unit = MSR_RAPL_POWER_UNIT,
-	.rapl_msrs      = intel_rapl_msrs,
+	.rapl_pkg_msrs	= intel_rapl_msrs,
 };
 
 static struct rapl_model model_hsw = {
@@ -758,7 +855,7 @@ static struct rapl_model model_hsw = {
 			  BIT(PERF_RAPL_RAM) |
 			  BIT(PERF_RAPL_PP1),
 	.msr_power_unit = MSR_RAPL_POWER_UNIT,
-	.rapl_msrs      = intel_rapl_msrs,
+	.rapl_pkg_msrs	= intel_rapl_msrs,
 };
 
 static struct rapl_model model_hsx = {
@@ -767,7 +864,7 @@ static struct rapl_model model_hsx = {
 			  BIT(PERF_RAPL_RAM),
 	.unit_quirk	= RAPL_UNIT_QUIRK_INTEL_HSW,
 	.msr_power_unit = MSR_RAPL_POWER_UNIT,
-	.rapl_msrs      = intel_rapl_msrs,
+	.rapl_pkg_msrs	= intel_rapl_msrs,
 };
 
 static struct rapl_model model_knl = {
@@ -775,7 +872,7 @@ static struct rapl_model model_knl = {
 			  BIT(PERF_RAPL_RAM),
 	.unit_quirk	= RAPL_UNIT_QUIRK_INTEL_HSW,
 	.msr_power_unit = MSR_RAPL_POWER_UNIT,
-	.rapl_msrs      = intel_rapl_msrs,
+	.rapl_pkg_msrs	= intel_rapl_msrs,
 };
 
 static struct rapl_model model_skl = {
@@ -785,7 +882,7 @@ static struct rapl_model model_skl = {
 			  BIT(PERF_RAPL_PP1) |
 			  BIT(PERF_RAPL_PSYS),
 	.msr_power_unit = MSR_RAPL_POWER_UNIT,
-	.rapl_msrs      = intel_rapl_msrs,
+	.rapl_pkg_msrs	= intel_rapl_msrs,
 };
 
 static struct rapl_model model_spr = {
@@ -795,13 +892,15 @@ static struct rapl_model model_spr = {
 			  BIT(PERF_RAPL_PSYS),
 	.unit_quirk	= RAPL_UNIT_QUIRK_INTEL_SPR,
 	.msr_power_unit = MSR_RAPL_POWER_UNIT,
-	.rapl_msrs      = intel_rapl_spr_msrs,
+	.rapl_pkg_msrs	= intel_rapl_spr_msrs,
 };
 
 static struct rapl_model model_amd_hygon = {
 	.pkg_events	= BIT(PERF_RAPL_PKG),
+	.core_events	= BIT(PERF_RAPL_PER_CORE),
 	.msr_power_unit = MSR_AMD_RAPL_POWER_UNIT,
-	.rapl_msrs      = amd_rapl_pkg_msrs,
+	.rapl_pkg_msrs	= amd_rapl_pkg_msrs,
+	.rapl_core_msrs	= amd_rapl_core_msrs,
 };
 
 static const struct x86_cpu_id rapl_model_match[] __initconst = {
@@ -858,6 +957,11 @@ static int __init rapl_pmu_init(void)
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
@@ -865,17 +969,34 @@ static int __init rapl_pmu_init(void)
 
 	rapl_model = (struct rapl_model *) id->driver_data;
 
-	rapl_pkg_cntr_mask = perf_msr_probe(rapl_model->rapl_msrs, PERF_RAPL_PKG_EVENTS_MAX,
+	rapl_pkg_cntr_mask = perf_msr_probe(rapl_model->rapl_pkg_msrs, PERF_RAPL_PKG_EVENTS_MAX,
 					false, (void *) &rapl_model->pkg_events);
 
 	ret = rapl_check_hw_unit();
 	if (ret)
 		return ret;
 
-	ret = init_rapl_pmus(&rapl_pmus_pkg);
+	ret = init_rapl_pmus(&rapl_pmus_pkg, nr_rapl_pmu, rapl_attr_groups, rapl_attr_update);
 	if (ret)
 		return ret;
 
+	if (rapl_model->core_events) {
+		rapl_core_cntr_mask = perf_msr_probe(rapl_model->rapl_core_msrs,
+						     PERF_RAPL_CORE_EVENTS_MAX, false,
+						     (void *) &rapl_model->core_events);
+
+		ret = init_rapl_pmus(&rapl_pmus_core, nr_cores,
+				     rapl_per_core_attr_groups, rapl_per_core_attr_update);
+		if (ret) {
+			/*
+			 * If initialization of per_core PMU fails, reset per_core
+			 * flag, and continue with power PMU initialization.
+			 */
+			pr_warn("Per-core PMU initialization failed (%d)\n", ret);
+			rapl_model->core_events = 0UL;
+		}
+	}
+
 	/*
 	 * Install callbacks. Core will call them for each online cpu.
 	 */
@@ -889,6 +1010,20 @@ static int __init rapl_pmu_init(void)
 	if (ret)
 		goto out1;
 
+	if (rapl_model->core_events) {
+		ret = perf_pmu_register(&rapl_pmus_core->pmu, "power_per_core", -1);
+		if (ret) {
+			/*
+			 * If registration of per_core PMU fails, cleanup per_core PMU
+			 * variables, reset the per_core flag and keep the
+			 * power PMU untouched.
+			 */
+			pr_warn("Per-core PMU registration failed (%d)\n", ret);
+			cleanup_rapl_pmus(rapl_pmus_core);
+			rapl_model->core_events = 0UL;
+		}
+	}
+
 	rapl_advertise();
 	return 0;
 
@@ -906,5 +1041,9 @@ static void __exit intel_rapl_exit(void)
 	cpuhp_remove_state_nocalls(CPUHP_AP_PERF_X86_RAPL_ONLINE);
 	perf_pmu_unregister(&rapl_pmus_pkg->pmu);
 	cleanup_rapl_pmus(rapl_pmus_pkg);
+	if (rapl_model->core_events) {
+		perf_pmu_unregister(&rapl_pmus_core->pmu);
+		cleanup_rapl_pmus(rapl_pmus_core);
+	}
 }
 module_exit(intel_rapl_exit);
-- 
2.34.1


