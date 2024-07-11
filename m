Return-Path: <linux-pm+bounces-10980-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 643D892E4C2
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2024 12:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 886FA1C20B20
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2024 10:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58BDE156653;
	Thu, 11 Jul 2024 10:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qQd8VESk"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EAD1B86F3;
	Thu, 11 Jul 2024 10:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720693860; cv=fail; b=T+6hafPjOxhY1Or9r76ShrlT8UkYMTD29K+b8PBlHz7ceuTk126rnKfipytg4EbaHxZVL1HHO/+7DRKK/SwpG/E3qrataqqQkjJyV+b4LMt7qqrE8hmnKApMTkXIn3Nrutb2mJEWboay3CmDwW1QSCx3SmEVvT4ThWjUZmh+7lc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720693860; c=relaxed/simple;
	bh=VkKMggvbgJsPtH8aezMHKemKAJiVcVD/3cp4cq3ecpI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TqCShjSbnZhcBM0rMgpPw/MInIeJCouS2l9VxX1t0XbR4KNOELP6A1mjLCy7pC7mx+lYag8Lh6+AjFaw2VzzM+Cj07+51RI9PL2xdYo4TC4yucQuWZFjyXoo1VMcnaGlLd2WXdonGoslUcSwL1uvl7RNPL3A/PYXX8/ZVkxqn8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qQd8VESk; arc=fail smtp.client-ip=40.107.236.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bw6/AXemMApSjoJDDmmGNrOVrEg7VckvCD1pIAV5KfkC3MXZ0bEI1BZ7+3ccp7pCY3+wTpY+y1zPCdAapFZPv3mxuMkRnx7M5h/d5lWroRQiwS6P4XkApdVTmv2H6y6x7IAMSMatRHM9GdcRDoCw6+ajEjjPGRrUP59/ycT+rq5Xcpy7xUqlRxjNmWf2//QRuzsWGArCyil1KsP7qx/1WHstDdcLz97+GzuWbeMMs0iLz57H2vvDeSIM+POOA+Mplxayo+k+fSM2QXYoAXhU2zQ9Y5M8o6s0hdlT69oJ04ASIp/jT0SCBnp+TULgWhGSd5ecIAmSsH6hSfPMN7yYgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IN387qIp/T5RlCg2qK6ewwsa2aywr2Ta2WftVnHVx0o=;
 b=YqPS3oRiRNrDpZuv73a/L3GRwNqj1y9yt8vPwWNx4DZxPJxWiqOXoL7uMsNQ5wJNm53rEnhrqtkz53Rb3QJsNCUguD4PJhqG+W2HP3b5cRiPh2t5KrYcVFizEUOZVgjQVopSV4yMm4FoF62PnLhWZOT5RBwsGSxM4uMfmtkIPau7lVdz0jXk4yryR/3mOgG4RrP7n91VSdMtfXOIqivp5+XCYQt1/9ENGnGAVsoeTMhOOHnf45P3nf/029L2JMJjb3MutfeeD26jVPd5VEuyzz7AHsW+yvIdliK22+SmrvjMaNW64+Z7XdjbQkPQfYrScK2DAKMu1Kih9USXegxAXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IN387qIp/T5RlCg2qK6ewwsa2aywr2Ta2WftVnHVx0o=;
 b=qQd8VESkHtf24rvaRLxSv+slKTMkUqAoas9pVvKdFDVmMsLBCNIwLByIBdwhgNxYjx2Ywp9/eLDq4P+HNQyABVTWcbuafD+4kcNX539vZbbaF3rRFvd5VtR6L5xNPgTB+XXOPfCsg5o6HTw2Yq2cWRoQbQiW0OGWkzssWgxGNz8=
Received: from SA9PR13CA0147.namprd13.prod.outlook.com (2603:10b6:806:27::32)
 by CH0PR12MB8550.namprd12.prod.outlook.com (2603:10b6:610:192::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.19; Thu, 11 Jul
 2024 10:30:54 +0000
Received: from SA2PEPF00003AEB.namprd02.prod.outlook.com
 (2603:10b6:806:27:cafe::6) by SA9PR13CA0147.outlook.office365.com
 (2603:10b6:806:27::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.22 via Frontend
 Transport; Thu, 11 Jul 2024 10:30:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AEB.mail.protection.outlook.com (10.167.248.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Thu, 11 Jul 2024 10:30:53 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 11 Jul
 2024 05:30:44 -0500
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
Subject: [PATCH v4 10/11] perf/x86/rapl: Add per-core energy counter support for AMD CPUs
Date: Thu, 11 Jul 2024 10:24:38 +0000
Message-ID: <20240711102436.4432-11-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEB:EE_|CH0PR12MB8550:EE_
X-MS-Office365-Filtering-Correlation-Id: 13801b32-cdda-4017-1f4b-08dca1948b22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HjnwaY/ZuwCsM2e/dsRVelwzeLtyoDum+Xcw/tGb/8ZFrcxHSdMJXFY87PWm?=
 =?us-ascii?Q?zoNIJmQXgqKtq4ri7AIhq38M+Zza75V/FR0KU32cGwl7P2gOaIAIPwyFKsHC?=
 =?us-ascii?Q?YJQhSJ37DVYIFeU3JHRPyAuRAaG4zOCgx/I44eG5gX8VdsvNkcfGAfaCG6hA?=
 =?us-ascii?Q?RXmHNMASVQNtz9iKxAZIySftnZCqyW1SOwi5bRn1kvxWBoX4ANkeLt0EZeLp?=
 =?us-ascii?Q?IrpEyaL2RsBgGOk7Qq4JN/FcKxR7eiwGa6jmLJQGhrFMDXFN1e5yxZHJZ9WD?=
 =?us-ascii?Q?m25dlBVjHRnQQkYODVvis8OP3443ugaavvhwl+5q4qik5QXeKpevY0V7vh/o?=
 =?us-ascii?Q?lhOSH9hMUmNrOMa+aio5vwRXU2qe7itveqIKrzlgMb6d1s6UcRm3KT1uNo9t?=
 =?us-ascii?Q?LvrseWiCczDen56GnlmUIFXzLzZEnW3LLTLee9idvHOAUmRN6iysvcFkD9f2?=
 =?us-ascii?Q?5dpd/PZf4Gx6tpcVB3zBQzxpprnwxF7P6avj9yrTL65JlqyDUsVdNfxEEW45?=
 =?us-ascii?Q?LLcvzHlJxY5kdS8BMFBw+5Vt3oGTgysE2eCp0zXKtr1TJ7C/rAU68gRyYNy5?=
 =?us-ascii?Q?nIGFSsz+3/0Xe2DfgR3KsgilWWERox/fQvr8jMTzouyv4ybxxExbPoTQtfck?=
 =?us-ascii?Q?wbncw+7Mm6CO5hcQj0RUQgArhM6FnAx+pY7Zbe8/ZntSPkgh/zxwfdOXZ9QG?=
 =?us-ascii?Q?wlRVnAqEDBjj/6V8Q7hvoGHboSBVOuqu0nd4tWc1Wl0Wo8lfE1c3Dq17ETCj?=
 =?us-ascii?Q?pD6deHTTjuhceoBOL0jfs6667mu5QQd2YNEWhR1ft7kYZzG0pi+00b0Ljfvw?=
 =?us-ascii?Q?J3ORugb1Sw6J7HnqyQ5E7Wdu7ttSdVreveLRtaAqwsCVwoSSBigIkmBEJh0p?=
 =?us-ascii?Q?YqmRoinFPZhZtAY36d/9Nte1TCByqX/txkeHxPCqi2Hg8B510A6laWOPfYlK?=
 =?us-ascii?Q?6KQNuoBOhPcQ5TiBh+0g+HYH8trdGAWWGacVwRC5Gi1LLgEBZFsAnu+XQBpS?=
 =?us-ascii?Q?2NKwAB7AKthBmKBDGmo1aPS17rDfId9zSnB+QEHZvQuKVHK2ujviNLmpT/1d?=
 =?us-ascii?Q?y5wqERfTeT91yU1elj6CVNOv13HaHtaviM1tWO8JQeQh0EsKuB30dApoNPV+?=
 =?us-ascii?Q?ojkPO8dp0Y/5qo79WRFS7WRBNZFW4wT+mzhoRx9lCOwXizyZVRBk/kY1pGFh?=
 =?us-ascii?Q?49OTrTBf0yKGacUPBTPL3Vkb//2+kYhfBI2o4hOUycjke+GIT7/uEngK2qld?=
 =?us-ascii?Q?lqSA9Mh9prXgTLRCurAchzQroml3xR7ZYXX6XA6DeoBMRSpg7QwN2Pt7V1dE?=
 =?us-ascii?Q?cG4PSUqSe5RyBLyOlOjXIMo9blLuxzVq6Ev/HrrgLKEWUSGdWn/Pd0fCxl9z?=
 =?us-ascii?Q?Z3b9pEucWC7KXOkYlTK27IqqryKITf9qyBNukn8FfDUZfeKAcY6vx/HjR9ez?=
 =?us-ascii?Q?gUUcvxjlCwabEiWwZjA0r2RqzQHl7rcU9f7h55A1TgQa6iaXmCEsxA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 10:30:53.8767
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13801b32-cdda-4017-1f4b-08dca1948b22
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AEB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8550

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
Changes in v4:
* Reorder the cleanup order of per-core and per-pkg PMU (Rui)
* Add rapl_core_hw_unit variable to store the per-core PMU unit (Rui)
* Use the newly added hw_unit in rapl_scale() and rapl_advertise()
  functions
* Add a new argument in rapl_scale() to differentiate between per-core
  and per-pkg events.
---
 arch/x86/events/rapl.c | 190 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 171 insertions(+), 19 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 7691497042e9..91eb9850df9b 100644
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
@@ -135,15 +150,20 @@ enum rapl_unit_quirk {
 
 struct rapl_model {
 	struct perf_msr *rapl_pkg_msrs;
+	struct perf_msr *rapl_core_msrs;
 	unsigned long	pkg_events;
+	unsigned long	core_events;
 	unsigned int	msr_power_unit;
 	enum rapl_unit_quirk	unit_quirk;
 };
 
  /* 1/2^hw_unit Joule */
 static int rapl_pkg_hw_unit[NR_RAPL_PKG_DOMAINS] __read_mostly;
+static int rapl_core_hw_unit __read_mostly;
 static struct rapl_pmus *rapl_pmus_pkg;
+static struct rapl_pmus *rapl_pmus_core;
 static unsigned int rapl_pkg_cntr_mask;
+static unsigned int rapl_core_cntr_mask;
 static u64 rapl_timer_ms;
 static struct rapl_model *rapl_model;
 
@@ -182,19 +202,25 @@ static inline u64 rapl_read_counter(struct perf_event *event)
 	return raw;
 }
 
-static inline u64 rapl_scale(u64 v, int cfg)
+static inline u64 rapl_scale(u64 v, int cfg, bool per_core_event)
 {
-	if (cfg > NR_RAPL_PKG_DOMAINS) {
+	if ((!per_core_event && cfg > NR_RAPL_PKG_DOMAINS) ||
+	    (per_core_event && cfg > NR_RAPL_CORE_DOMAINS)) {
 		pr_warn("Invalid domain %d, failed to scale data\n", cfg);
 		return v;
 	}
+	int hw_unit = rapl_pkg_hw_unit[cfg - 1];
+
+	if (per_core_event)
+		hw_unit = rapl_core_hw_unit;
+
 	/*
 	 * scale delta to smallest unit (1/2^32)
 	 * users must then scale back: count * 1/(1e9*2^32) to get Joules
 	 * or use ldexp(count, -32).
 	 * Watts = Joules/Time delta
 	 */
-	return v << (32 - rapl_pkg_hw_unit[cfg - 1]);
+	return v << (32 - hw_unit);
 }
 
 static u64 rapl_event_update(struct perf_event *event)
@@ -203,6 +229,7 @@ static u64 rapl_event_update(struct perf_event *event)
 	u64 prev_raw_count, new_raw_count;
 	s64 delta, sdelta;
 	int shift = RAPL_CNTR_WIDTH;
+	struct rapl_pmus *curr_rapl_pmus;
 
 	prev_raw_count = local64_read(&hwc->prev_count);
 	do {
@@ -221,7 +248,12 @@ static u64 rapl_event_update(struct perf_event *event)
 	delta = (new_raw_count << shift) - (prev_raw_count << shift);
 	delta >>= shift;
 
-	sdelta = rapl_scale(delta, event->hw.config);
+	curr_rapl_pmus = container_of(event->pmu, struct rapl_pmus, pmu);
+
+	if (curr_rapl_pmus == rapl_pmus_core)
+		sdelta = rapl_scale(delta, event->hw.config, true);
+	else
+		sdelta = rapl_scale(delta, event->hw.config, false);
 
 	local64_add(sdelta, &event->count);
 
@@ -352,9 +384,13 @@ static int rapl_pmu_event_init(struct perf_event *event)
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
@@ -364,7 +400,8 @@ static int rapl_pmu_event_init(struct perf_event *event)
 	if (event->cpu < 0)
 		return -EINVAL;
 
-	event->event_caps |= PERF_EV_CAP_READ_ACTIVE_PKG;
+	if (curr_rapl_pmus == rapl_pmus_pkg)
+		event->event_caps |= PERF_EV_CAP_READ_ACTIVE_PKG;
 
 	if (!cfg || cfg >= NR_RAPL_PKG_DOMAINS + 1)
 		return -EINVAL;
@@ -373,7 +410,8 @@ static int rapl_pmu_event_init(struct perf_event *event)
 	bit = cfg - 1;
 
 	/* check event supported */
-	if (!(rapl_pkg_cntr_mask & (1 << bit)))
+	if (!(rapl_pkg_cntr_mask & (1 << bit)) &&
+	    !(rapl_core_cntr_mask & (1 << bit)))
 		return -EINVAL;
 
 	/* unsupported modes and filters */
@@ -381,12 +419,18 @@ static int rapl_pmu_event_init(struct perf_event *event)
 		return -EINVAL;
 
 	/* must be done before validate_group */
-	rapl_pmu = cpu_to_rapl_pmu(event->cpu);
+	if (curr_rapl_pmus == rapl_pmus_core) {
+		rapl_pmu = curr_rapl_pmus->rapl_pmu[topology_logical_core_id(event->cpu)];
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
 
@@ -415,17 +459,38 @@ static struct attribute_group rapl_pmu_attr_group = {
 	.attrs = rapl_pmu_attrs,
 };
 
+static ssize_t rapl_get_attr_per_core_cpumask(struct device *dev,
+					     struct device_attribute *attr, char *buf)
+{
+	return cpumap_print_to_pagebuf(true, buf, rapl_pmus_core->cpumask);
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
@@ -435,6 +500,7 @@ RAPL_EVENT_ATTR_STR(energy-pkg.scale,     rapl_pkg_scale, "2.3283064365386962890
 RAPL_EVENT_ATTR_STR(energy-ram.scale,     rapl_ram_scale, "2.3283064365386962890625e-10");
 RAPL_EVENT_ATTR_STR(energy-gpu.scale,     rapl_gpu_scale, "2.3283064365386962890625e-10");
 RAPL_EVENT_ATTR_STR(energy-psys.scale,   rapl_psys_scale, "2.3283064365386962890625e-10");
+RAPL_EVENT_ATTR_STR(energy-per-core.scale,   rapl_per_core_scale, "2.3283064365386962890625e-10");
 
 /*
  * There are no default events, but we need to create
@@ -468,6 +534,13 @@ static const struct attribute_group *rapl_attr_groups[] = {
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
@@ -528,6 +601,18 @@ static struct attribute_group rapl_events_psys_group = {
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
@@ -565,6 +650,11 @@ static struct perf_msr amd_rapl_pkg_msrs[] = {
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
@@ -590,8 +680,14 @@ static int __rapl_cpu_offline(struct rapl_pmus *rapl_pmus, unsigned int rapl_pmu
 
 static int rapl_cpu_offline(unsigned int cpu)
 {
-	return __rapl_cpu_offline(rapl_pmus_pkg, get_rapl_pmu_idx(cpu),
+	int ret =  __rapl_cpu_offline(rapl_pmus_pkg, get_rapl_pmu_idx(cpu),
 				  get_rapl_pmu_cpumask(cpu), cpu);
+
+	if (ret == 0 && rapl_model->core_events)
+		ret = __rapl_cpu_offline(rapl_pmus_core, topology_logical_core_id(cpu),
+				   topology_sibling_cpumask(cpu), cpu);
+
+	return ret;
 }
 
 static int __rapl_cpu_online(struct rapl_pmus *rapl_pmus, unsigned int rapl_pmu_idx,
@@ -629,8 +725,14 @@ static int __rapl_cpu_online(struct rapl_pmus *rapl_pmus, unsigned int rapl_pmu_
 
 static int rapl_cpu_online(unsigned int cpu)
 {
-	return __rapl_cpu_online(rapl_pmus_pkg, get_rapl_pmu_idx(cpu),
+	int ret =  __rapl_cpu_online(rapl_pmus_pkg, get_rapl_pmu_idx(cpu),
 				 get_rapl_pmu_cpumask(cpu), cpu);
+
+	if (ret == 0 && rapl_model->core_events)
+		ret = __rapl_cpu_online(rapl_pmus_core, topology_logical_core_id(cpu),
+				   topology_sibling_cpumask(cpu), cpu);
+
+	return ret;
 }
 
 
@@ -645,6 +747,8 @@ static int rapl_check_hw_unit(void)
 	for (i = 0; i < NR_RAPL_PKG_DOMAINS; i++)
 		rapl_pkg_hw_unit[i] = (msr_rapl_power_unit_bits >> 8) & 0x1FULL;
 
+	rapl_core_hw_unit = (msr_rapl_power_unit_bits >> 8) & 0x1FULL;
+
 	switch (rapl_model->unit_quirk) {
 	/*
 	 * DRAM domain on HSW server and KNL has fixed energy unit which can be
@@ -684,7 +788,7 @@ static void __init rapl_advertise(void)
 	int i;
 
 	pr_info("API unit is 2^-32 Joules, %d fixed counters, %llu ms ovfl timer\n",
-		hweight32(rapl_pkg_cntr_mask), rapl_timer_ms);
+		hweight32(rapl_pkg_cntr_mask) + hweight32(rapl_core_cntr_mask), rapl_timer_ms);
 
 	for (i = 0; i < NR_RAPL_PKG_DOMAINS; i++) {
 		if (rapl_pkg_cntr_mask & (1 << i)) {
@@ -692,6 +796,10 @@ static void __init rapl_advertise(void)
 				rapl_pkg_domain_names[i], rapl_pkg_hw_unit[i]);
 		}
 	}
+
+	if (rapl_core_cntr_mask & (1 << PERF_RAPL_PER_CORE))
+		pr_info("hw unit of domain %s 2^-%d Joules\n",
+			rapl_core_domain_names[PERF_RAPL_PER_CORE], rapl_core_hw_unit);
 }
 
 static void cleanup_rapl_pmus(struct rapl_pmus *rapl_pmus)
@@ -712,14 +820,16 @@ static const struct attribute_group *rapl_attr_update[] = {
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
-	int nr_rapl_pmu = topology_max_packages();
 	struct rapl_pmus *rapl_pmus;
 
-	if (!rapl_pmu_is_pkg_scope())
-		nr_rapl_pmu *= topology_max_dies_per_package();
-
 	rapl_pmus = kzalloc(struct_size(rapl_pmus, rapl_pmu, nr_rapl_pmu), GFP_KERNEL);
 	if (!rapl_pmus)
 		return -ENOMEM;
@@ -809,8 +919,10 @@ static struct rapl_model model_spr = {
 
 static struct rapl_model model_amd_hygon = {
 	.pkg_events	= BIT(PERF_RAPL_PKG),
+	.core_events	= BIT(PERF_RAPL_PER_CORE),
 	.msr_power_unit = MSR_AMD_RAPL_POWER_UNIT,
 	.rapl_pkg_msrs	= amd_rapl_pkg_msrs,
+	.rapl_core_msrs	= amd_rapl_core_msrs,
 };
 
 static const struct x86_cpu_id rapl_model_match[] __initconst = {
@@ -867,6 +979,11 @@ static int __init rapl_pmu_init(void)
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
@@ -874,17 +991,34 @@ static int __init rapl_pmu_init(void)
 
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
@@ -898,6 +1032,20 @@ static int __init rapl_pmu_init(void)
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
 
@@ -915,5 +1063,9 @@ static void __exit intel_rapl_exit(void)
 	cpuhp_remove_state_nocalls(CPUHP_AP_PERF_X86_RAPL_ONLINE);
+	if (rapl_model->core_events) {
+		perf_pmu_unregister(&rapl_pmus_core->pmu);
+		cleanup_rapl_pmus(rapl_pmus_core);
+	}
 	perf_pmu_unregister(&rapl_pmus_pkg->pmu);
 	cleanup_rapl_pmus(rapl_pmus_pkg);
 }
 module_exit(intel_rapl_exit);
-- 
2.34.1


