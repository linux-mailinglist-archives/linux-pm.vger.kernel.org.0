Return-Path: <linux-pm+bounces-9876-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 068F9914274
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 08:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2656F1C21C38
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 06:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D294D2030A;
	Mon, 24 Jun 2024 06:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Y+JS9tR7"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2075.outbound.protection.outlook.com [40.107.101.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91951CD25;
	Mon, 24 Jun 2024 06:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719209020; cv=fail; b=s7PU1JiCVrYyRuMmI3+kJ6NdScsPtkcr11jx108FSVALWe1BmhdU4CPk7MnfBsQmoKkItxiASnzcEZKtp7Os+UwNySMiNk194Xz/pdbiy6S2pTq9/YLl8NkCLdjj9aRVKRfFbjOUKVgib7myhYa5bGPfBQQoRqt0mtqj5BmPW8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719209020; c=relaxed/simple;
	bh=w7QAf0R/ArjoM2OO2K6rpC0fXED2wJ9uM0+KWVIEDSE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kzNqo7kSFC4dPt1o+wA256okIQGD2KaCJoMcmgw6bF5LmIZH7HTiytIgSehSno71yOTbvI6axiPVXbAGa4rRIYZzEhEIrcoN7Jnfi3RFUi4xiJ6YYDaa7DYmpU8qbZDvA+WLVkfrtsg6/Qg/yPx1IpB3MTkuMLmXBgPjJVWKt44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Y+JS9tR7; arc=fail smtp.client-ip=40.107.101.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aD6jKqSGdo27QEv9iGVn5OvzHPs7iGim2z572cJuHYKcuoKhnL5n2vr5mPfaOLptqIVnLyU4ovC9iG8G5Bsipwbu9lJMPaZ+0CKnMu1QkpIs2zwfzUNF1GuehGcH6/rd0P1wuuvA2mPN3Xl61cAfxKxI+yq0ZJ8/9THsN5n8Mb93t3HHN7fGMkrWyck6ayYx5yVkD//Bi3G6a+7oXooZV+NWASWTA96mDtgdVyFZjm7pf4wxW1jJhhi6kKYutAu9VwTh/pAzmd5ujqBekXSaUvNmtcJ4udt6HzHQudFPmbqVlezRosDIVJ8pwI8nU1EAEDDRSin8+gYunovbyRB9+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EbDYnja41ELeIw1KOOcJsb/qK8MeW7ve7Seu70I+hcA=;
 b=Su5jHbfffFAEliB/qlVV3zYJ6vlVK8IlODBIRg7MHIT+GWWKy8BCzmPvj6OQNJ+K9qoom4PQKW+1rm491fzA+MYwbo2GSOSwRhiMjvLxxxraXraD9fSRxhfH4adpw+b0Aws5/3JJvGf+TSDRdoyY7f/niDEaFDXplQd15sQs09t6DOCYE55xJ1TyISrUGKMdXeGV+I44hfKPQu1LTkqkDtsF2/1OWV5Ph+iF5A9uKMEozxLHXdbYISWZH/puyjfE8Djbh0V80pUdEPpOIIyWCZSvCt6nVnay926KKaIB1jrq8X0eT/9ESdpQFoL5JuZjRET1+b3oI7iNd2yG2SyguQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EbDYnja41ELeIw1KOOcJsb/qK8MeW7ve7Seu70I+hcA=;
 b=Y+JS9tR7T9HzLVNA0nvWWIX3AZ2oR3OlfOXlyvy+XtLrZyVTh3SYPsyRWzMhgZz4S+ELpZVZUfITn4bjosYXu68+bwaWVRoW7KLe8OaOKtHAkz26MhF7ikmTXgsUQyiVbJaK0Id3i6W6YPe4q6beu04zyJ4Cce7Y2jAynfbZb/g=
Received: from BN9PR03CA0483.namprd03.prod.outlook.com (2603:10b6:408:130::8)
 by IA1PR12MB6577.namprd12.prod.outlook.com (2603:10b6:208:3a3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.25; Mon, 24 Jun
 2024 06:03:36 +0000
Received: from BN2PEPF000055DE.namprd21.prod.outlook.com
 (2603:10b6:408:130:cafe::14) by BN9PR03CA0483.outlook.office365.com
 (2603:10b6:408:130::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Mon, 24 Jun 2024 06:03:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DE.mail.protection.outlook.com (10.167.245.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.0 via Frontend Transport; Mon, 24 Jun 2024 06:03:35 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Jun
 2024 01:03:28 -0500
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
Subject: [PATCH v3 10/10] perf/x86/rapl: Add per-core energy counter support for AMD CPUs
Date: Mon, 24 Jun 2024 05:59:07 +0000
Message-ID: <20240624055907.7720-11-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DE:EE_|IA1PR12MB6577:EE_
X-MS-Office365-Filtering-Correlation-Id: 71075a7a-1bd7-4f9e-419f-08dc9413629b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|82310400023|1800799021|36860700010|7416011|376011|921017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M4ru6vUGHeZRVcyqwHpWheXjEIGQ6XYVLKkMEdbPQNmnun3dJbDB5aiQ8iY9?=
 =?us-ascii?Q?2uTcJmt86sw9wkEewmEJimxIKOZRZ8hChruZU9BDjMS+dcntn7HhCpVM+c2H?=
 =?us-ascii?Q?+fAcaSKyENwTvBwOd/WDexUaLuhu6/mX8YCXwKm+432wd3S00ynpyDLY2V5n?=
 =?us-ascii?Q?Xvt/l5wjfSvYB1uNNve4rqPZXaXFdIIpch1KP3nYyTfZoFe5rHqdJGEJwFYi?=
 =?us-ascii?Q?BVywU1qFHryvSGpEEByvwm7CDeHyFZ6c9tNKZYx+g6+ehg8JGZpMCbo/NyEJ?=
 =?us-ascii?Q?NqMNc4fwsTOtFaBZOLAheCRDHjlMhJffaIYB/onc4En6ImSxogL2ULThWOiZ?=
 =?us-ascii?Q?XH3Z0VvnLEbOQmKfskqBG1k6/t9Rc3qGEHT7sXgm+Vd11LgYmgmz71AAQijb?=
 =?us-ascii?Q?N8Y50QqKB17E/NPUDEP1aptuGxphfJbNlqE/P6qF8Agxq+0597e/2XM88kil?=
 =?us-ascii?Q?VgTrwjuz+7azC8kr/JpZbvneUVAhpVV8lNJYj2phKnOjXObg9EUSQ9o+GJCZ?=
 =?us-ascii?Q?+/1tQCPPqhiKuCb7UK2pDiZ+SO3HTrnQGTaXK9vxT5Z9lx8bX6kOh4lR1A+V?=
 =?us-ascii?Q?1FwEDsL/EFZ64wOcHIeiH+Lzv5C1dC9/W/6ehWr7UxiJNkku/zVxyDiYVhlS?=
 =?us-ascii?Q?r/ZplJ14VNl7fTYfWi1ZsgjmglOYXs1YM/ei5ZaNMHz3efo7dpEOuF087Ft9?=
 =?us-ascii?Q?migiYnzgXATnVvAxJrFfbZFEUfZeQem2Hl6qzdUrqaeQjhcPOWmDMkYFjFH9?=
 =?us-ascii?Q?pUd7u2Xn3V1S4QUBMuDXfk1VSIKfS8hV+wjuHE+J19ozUjeBydd0MpqCCIEy?=
 =?us-ascii?Q?5W56/NJPZ3X57MvYbpbdr8VXPVJV4Yiga5TRcl4soPLgMmDYOJWEQa4DPr8f?=
 =?us-ascii?Q?4Mm9QmrIot+yGwKL25cO52KdRoYg/RtPA+2O+0t4mrvxkcJ5h6OAKIXbRa/Q?=
 =?us-ascii?Q?/ZddaQvTUpwxXWafzcQewTQPnD/rVVe6HP2DcmxOvR5m+0RlJgpH5sfddqcz?=
 =?us-ascii?Q?zg5fLN2KuwMRGL0hs3ZMN798P7ly54GVU937hjWgw3+0VYlXDcxcH3G99/7Y?=
 =?us-ascii?Q?6qyC1lj3gciva5SDCCk2rx0koeitz/zbA/pH7NJO2mNVw4ED4aewKjiNgomG?=
 =?us-ascii?Q?Qko4ZF/KQ7EluD/gyRH2iL6U0E7SnzU1XE+AkrZzXfObigkIBKqx7Rz3hfVZ?=
 =?us-ascii?Q?a9L29L/8mNbgJm5pdNz6oViTQqitluyRfLNBRpdHUAscJFxS6fIB4G72Z8Ib?=
 =?us-ascii?Q?GitGtKkw836ricgZxnT2RIyx3CY2RHI9wC4J6TxkfyyRvOykUisQofERvJnG?=
 =?us-ascii?Q?iSzX7baVH26PX8ovALbjv33zAOVvBSSkLMyJXYc5SLIl7s86A39G+bxh0/Jc?=
 =?us-ascii?Q?TU9mmh5S+NwJuClZNS8c6ZJLVLLYTJwfMxR4T6OziNCANYmd810JiuZAlx55?=
 =?us-ascii?Q?NUL45pKL+1I=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(82310400023)(1800799021)(36860700010)(7416011)(376011)(921017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 06:03:35.8774
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71075a7a-1bd7-4f9e-419f-08dc9413629b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DE.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6577

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
 arch/x86/events/rapl.c | 189 +++++++++++++++++++++++++++++++++++------
 1 file changed, 164 insertions(+), 25 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index e962209e9e4d..8206038a01ac 100644
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
+		ret = __rapl_cpu_offline(rapl_pmus_core, topology_logical_core_id(cpu),
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
+		ret = __rapl_cpu_online(rapl_pmus_core, topology_logical_core_id(cpu),
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


