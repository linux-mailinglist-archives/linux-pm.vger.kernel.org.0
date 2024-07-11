Return-Path: <linux-pm+bounces-10978-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8406292E4BC
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2024 12:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E3B51F2137A
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2024 10:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE23D143885;
	Thu, 11 Jul 2024 10:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dHZswyEp"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AFF131E4B;
	Thu, 11 Jul 2024 10:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720693816; cv=fail; b=XHCTb04sQ/B2oXtZFJhKGT28HN27yVyM++nAM0rOWKhOk17kJh01wqWTgcs64IBTYE32RU7r8G80kBVbrwckmnrPjbmSsNdKl9kBjAXiMRpg4SZZFlPa0SPKbZ3Cgsk2ghiDnY718UzNBcV6IS71NbEq6hQ3Bs4SAUysr9We+Cg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720693816; c=relaxed/simple;
	bh=ZpRCKV8MG0bncltBs7V3NJHKn1BUdctRTQT+cMT+zz0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D2Awzxi9l6zcrFdUvqGqvJlrlqvHvuJqXTVmCyy0QjVfe6UNKJ/r/L4xBuUgQDeUUeXHzTNCtXtqDn+7txkRTjPwF6tWKZKnNPBxy6UP6rbNN63KXCfwb0g+oSIVlXvxis2q3GmoH84oCQ+P4V9OBVltd3e1mKGH6aQU6dTFJPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dHZswyEp; arc=fail smtp.client-ip=40.107.93.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aFuFxQdS2eZXUfmAe+O55NfWTkOiYol0InAPqoUriXjVKKN1rskmZlgT9vPeBYCgU+BagmgNLA1i/N3hZc0sX6OdFwEmSmfEre88JSfvPlyxhY9JB6MXXc7Uk566vSDMZ3Og4f0VQnJ4PEXPzmGx4HHBHIN4Z+THb7HYKRHfmVOlHVkWSRNY8SrgbVb85lXdNxZm4YW4CfYTOdWIMwi6R+ZrtklJ03lygaxF2t1oi9qR+F5WuvfG0g9hn/9LVyr8WushnnvAwUk484Y4CU5mmp70LEXGLnWq7X4ncJxSpIXYaRRwPJc234upavIdDXkrMb0RpEQ6BoRZjVB1I/u15w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/EaiiKZrvUTa7Sb8zAt01g0JRnZEzeikAgGFVLnd2yk=;
 b=zKafuefe+Jm5ROPPrlJnUTAAxJwYcSyIJCZdK5BjfW1wxhJ0zFWnejha3t8EAX5tpK4WOt6cWMk/HW7CS+W0a75jBAzV3f5F517OFsVbx7KnScZ1beR1sBE5CEV7sjbQYSamnGe9mV2/BCJLOPHF+JAYlzfmjL4NNOZbur0aWLZlAxhsb2gxhftp9NQbpufZbErVrFFaqw62rU709/PykUr11qVENNx3IZhPA1XUN5LxqOWyKhQmfa9JpuU3Ofd6lmigx87M1Veoy8eqSm7bvAOjAaX3DOtj67rcgPpmOuqKxYC0z1OCEikrP9sBhSMfgiKZWrHtKmnC4hVVJmDIFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/EaiiKZrvUTa7Sb8zAt01g0JRnZEzeikAgGFVLnd2yk=;
 b=dHZswyEpqMO5wMLxs5j/pxmlyJSXM1Nbw1PiKRudc5dLhSPgNj1Z1v5FrcHQ/uvH/QaHfI5NwjIKp+jXSXgEJht+jntIFUgU4JQ1Lxae5yzXx7tPHWVDt2j8XkJGvPnBiYkc7OTYT/CgpoxLnB/vyxkNR92+wVup6axfnH6+xHo=
Received: from SN6PR2101CA0016.namprd21.prod.outlook.com
 (2603:10b6:805:106::26) by DS0PR12MB7656.namprd12.prod.outlook.com
 (2603:10b6:8:11f::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Thu, 11 Jul
 2024 10:30:11 +0000
Received: from SA2PEPF00003AEA.namprd02.prod.outlook.com
 (2603:10b6:805:106:cafe::97) by SN6PR2101CA0016.outlook.office365.com
 (2603:10b6:805:106::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.12 via Frontend
 Transport; Thu, 11 Jul 2024 10:30:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AEA.mail.protection.outlook.com (10.167.248.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Thu, 11 Jul 2024 10:30:11 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 11 Jul
 2024 05:30:03 -0500
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
Subject: [PATCH v4 08/11] perf/x86/rapl: Modify the generic variable names to *_pkg*
Date: Thu, 11 Jul 2024 10:24:36 +0000
Message-ID: <20240711102436.4432-9-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEA:EE_|DS0PR12MB7656:EE_
X-MS-Office365-Filtering-Correlation-Id: 8277208f-dc54-4c05-934b-08dca19471df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|7416014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4I6/6fMjuD8361AZaeDTsSxTtBut36AO+NLhbMHboy4HSYhftI2U3hbjg+N+?=
 =?us-ascii?Q?37kZGSGl+skCOQGdTTGFsGxQ6swxVAOMhAet/38egpoHTE3fmaAXphVR/dJi?=
 =?us-ascii?Q?4ULWms2sdATtiHqXa85dQPa8x7QkBQ4wddyT9ZmGWO2MQ7FRDBbgHraPWSiN?=
 =?us-ascii?Q?HUD+Hu/xGN7E1Ki+AdEOU7EhdFXSlclG1c3j7TczbtRJrKtrzox2O2HsNDaf?=
 =?us-ascii?Q?mA+LbvPvEnw3Q4hnIqiXv80SIZboOaR8fHUOTAnv4loJTDegN2HwZCc3ON/P?=
 =?us-ascii?Q?rNK3ogMZfQCSMmuMrnnltV7OobvFXRnu32JXWAwGwWeJoEYLexSqy/f7mv8u?=
 =?us-ascii?Q?uIeCxBG+ewUS560omNi9OHORC8kB2FQpe0idJf8NK3X88OiLZuaIkG6D8dhn?=
 =?us-ascii?Q?il/a3ZVGQNTcYWKC1XGit9oiZ6P/e6M+bp64Uc+pLG89HJ+uj/wX+ZwpA3Tj?=
 =?us-ascii?Q?uE96NV5yfP/+kzJUcwoQos5DtPXTLif3gGHHMSr44dwKUd5TjyW5j060gmbu?=
 =?us-ascii?Q?OhT1IvrevVysa0xrCW3jBhnQeezmXxakPGTBI+8yjNcV/vJo1/V2s15oL7Uj?=
 =?us-ascii?Q?esD0hqnZR15+Ywlivb8ecV8so3mYI6BUfYwNcWB0MHuEVqAB/OaypWdYiFgl?=
 =?us-ascii?Q?mLhmg2H8rTRAYo9ukcBZy5MfCh/+OqKogaFlo+idminTIY7ErTW6UxssFkyd?=
 =?us-ascii?Q?rTHkQ65a8xQZsPGRiD2EKxpwj3KuFUkI3ZGei6Yt3i/SIddOT6b/Oay48Mrd?=
 =?us-ascii?Q?lhlo/snUUiwWRQbPWmkJ1JGWTVaRS7fjMU8OuoF/nMh86FeH8Ce9oKT0mOnm?=
 =?us-ascii?Q?k8QU8G3wClPS0qvrmbYvOWCmYPcxh/rYb8X1dVpHHBjXBra/IvRAxABetSWq?=
 =?us-ascii?Q?J/BfmMQqu8LqsuXkHj/NczhtoOfgJ6Q8yot2+KS3RyDyNzzym/SIiGFqGQvA?=
 =?us-ascii?Q?zDduLx69Uyp5vokyS8B/W29hQZMdP+4nw/UqU6ZBoLm8YD1o8veNJFuBQBz5?=
 =?us-ascii?Q?R0qhDXZXIZCF8kHR84IitfbwT/wQmDbHwGhw0iCdJ04kq+Nc0fccddCJQPr5?=
 =?us-ascii?Q?/iJy72Sx0qeTBgL3V2r6IhYbQH1oFZcYdn83g3YfqVcfhu3j2SS7K+mtopPd?=
 =?us-ascii?Q?4htWCGYMBVYdppSdWHEMFIGudLexgqJSsJ5QBHqRfpbZr3YU34WnMsl3TrXT?=
 =?us-ascii?Q?jseooXth29JxSazw4RVNyq7BmZM2yneC82msIyBRghtgFkNvB+b9klnQuBQ+?=
 =?us-ascii?Q?yo9357ifsd7cVtw9eCgAklSUonrCo8M+QmS3KUW/RaqyCEkkP/feJFL5hgJN?=
 =?us-ascii?Q?rBabSWEa/BsHv9U1NNM25bLsYU/nx+11o2bocuzoR7hAoDJjVHBoS2W0ijmY?=
 =?us-ascii?Q?DcB72rV6SAMn97G4FFTCg7PxuWu3PQ5/wSc4fjTtxTjTH+oeaVOOHBaogh6C?=
 =?us-ascii?Q?fWSaJRD/qE6K1Z61mjl0OJd7mNeQFsdfwLu0gUUa+d1gvRyI9EpisQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(7416014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 10:30:11.6070
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8277208f-dc54-4c05-934b-08dca19471df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AEA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7656

Prep for addition of power_per_core PMU to handle core scope energy
consumption for AMD CPUs.

Replace the generic names with *_pkg*, to differentiate between the
scopes of the two different PMUs and their variables.

No functional change.

Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
---
Changes in v4:
* Move some renaming code from patch 10 to here (Rui)
---
 arch/x86/events/rapl.c | 113 +++++++++++++++++++++--------------------
 1 file changed, 57 insertions(+), 56 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 362e82284ccb..9beded3d4a14 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -70,18 +70,18 @@ MODULE_LICENSE("GPL");
 /*
  * RAPL energy status counters
  */
-enum perf_rapl_events {
+enum perf_rapl_pkg_events {
 	PERF_RAPL_PP0 = 0,		/* all cores */
 	PERF_RAPL_PKG,			/* entire package */
 	PERF_RAPL_RAM,			/* DRAM */
 	PERF_RAPL_PP1,			/* gpu */
 	PERF_RAPL_PSYS,			/* psys */
 
-	PERF_RAPL_MAX,
-	NR_RAPL_DOMAINS = PERF_RAPL_MAX,
+	PERF_RAPL_PKG_EVENTS_MAX,
+	NR_RAPL_PKG_DOMAINS = PERF_RAPL_PKG_EVENTS_MAX,
 };
 
-static const char *const rapl_domain_names[NR_RAPL_DOMAINS] __initconst = {
+static const char *const rapl_pkg_domain_names[NR_RAPL_PKG_DOMAINS] __initconst = {
 	"pp0-core",
 	"package",
 	"dram",
@@ -134,16 +134,16 @@ enum rapl_unit_quirk {
 };
 
 struct rapl_model {
-	struct perf_msr *rapl_msrs;
-	unsigned long	events;
+	struct perf_msr *rapl_pkg_msrs;
+	unsigned long	pkg_events;
 	unsigned int	msr_power_unit;
 	enum rapl_unit_quirk	unit_quirk;
 };
 
  /* 1/2^hw_unit Joule */
-static int rapl_hw_unit[NR_RAPL_DOMAINS] __read_mostly;
-static struct rapl_pmus *rapl_pmus;
-static unsigned int rapl_cntr_mask;
+static int rapl_pkg_hw_unit[NR_RAPL_PKG_DOMAINS] __read_mostly;
+static struct rapl_pmus *rapl_pmus_pkg;
+static unsigned int rapl_pkg_cntr_mask;
 static u64 rapl_timer_ms;
 static struct perf_msr *rapl_msrs;
 static struct rapl_model *rapl_model;
@@ -172,7 +172,8 @@ static inline struct rapl_pmu *cpu_to_rapl_pmu(unsigned int cpu)
 	 * The unsigned check also catches the '-1' return value for non
 	 * existent mappings in the topology map.
 	 */
-	return rapl_pmu_idx < rapl_pmus->nr_rapl_pmu ? rapl_pmus->rapl_pmu[rapl_pmu_idx] : NULL;
+	return rapl_pmu_idx < rapl_pmus_pkg->nr_rapl_pmu ?
+	       rapl_pmus_pkg->rapl_pmu[rapl_pmu_idx] : NULL;
 }
 
 static inline u64 rapl_read_counter(struct perf_event *event)
@@ -184,7 +185,7 @@ static inline u64 rapl_read_counter(struct perf_event *event)
 
 static inline u64 rapl_scale(u64 v, int cfg)
 {
-	if (cfg > NR_RAPL_DOMAINS) {
+	if (cfg > NR_RAPL_PKG_DOMAINS) {
 		pr_warn("Invalid domain %d, failed to scale data\n", cfg);
 		return v;
 	}
@@ -194,7 +195,7 @@ static inline u64 rapl_scale(u64 v, int cfg)
 	 * or use ldexp(count, -32).
 	 * Watts = Joules/Time delta
 	 */
-	return v << (32 - rapl_hw_unit[cfg - 1]);
+	return v << (32 - rapl_pkg_hw_unit[cfg - 1]);
 }
 
 static u64 rapl_event_update(struct perf_event *event)
@@ -354,7 +355,7 @@ static int rapl_pmu_event_init(struct perf_event *event)
 	struct rapl_pmu *rapl_pmu;
 
 	/* only look at RAPL events */
-	if (event->attr.type != rapl_pmus->pmu.type)
+	if (event->attr.type != rapl_pmus_pkg->pmu.type)
 		return -ENOENT;
 
 	/* check only supported bits are set */
@@ -366,14 +367,14 @@ static int rapl_pmu_event_init(struct perf_event *event)
 
 	event->event_caps |= PERF_EV_CAP_READ_ACTIVE_PKG;
 
-	if (!cfg || cfg >= NR_RAPL_DOMAINS + 1)
+	if (!cfg || cfg >= NR_RAPL_PKG_DOMAINS + 1)
 		return -EINVAL;
 
-	cfg = array_index_nospec((long)cfg, NR_RAPL_DOMAINS + 1);
+	cfg = array_index_nospec((long)cfg, NR_RAPL_PKG_DOMAINS + 1);
 	bit = cfg - 1;
 
 	/* check event supported */
-	if (!(rapl_cntr_mask & (1 << bit)))
+	if (!(rapl_pkg_cntr_mask & (1 << bit)))
 		return -EINVAL;
 
 	/* unsupported modes and filters */
@@ -401,7 +402,7 @@ static void rapl_pmu_event_read(struct perf_event *event)
 static ssize_t rapl_get_attr_cpumask(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
-	return cpumap_print_to_pagebuf(true, buf, rapl_pmus->cpumask);
+	return cpumap_print_to_pagebuf(true, buf, rapl_pmus_pkg->cpumask);
 }
 
 static DEVICE_ATTR(cpumask, S_IRUGO, rapl_get_attr_cpumask, NULL);
@@ -553,11 +554,11 @@ static struct perf_msr intel_rapl_spr_msrs[] = {
 };
 
 /*
- * Force to PERF_RAPL_MAX size due to:
- * - perf_msr_probe(PERF_RAPL_MAX)
+ * Force to PERF_RAPL_PKG_EVENTS_MAX size due to:
+ * - perf_msr_probe(PERF_RAPL_PKG_EVENTS_MAX)
  * - want to use same event codes across both architectures
  */
-static struct perf_msr amd_rapl_msrs[] = {
+static struct perf_msr amd_rapl_pkg_msrs[] = {
 	[PERF_RAPL_PP0]  = { 0, &rapl_events_cores_group, NULL, false, 0 },
 	[PERF_RAPL_PKG]  = { MSR_AMD_PKG_ENERGY_STATUS,  &rapl_events_pkg_group,   test_msr, false, RAPL_MSR_MASK },
 	[PERF_RAPL_RAM]  = { 0, &rapl_events_ram_group,   NULL, false, 0 },
@@ -590,7 +591,7 @@ static int __rapl_cpu_offline(struct rapl_pmus *rapl_pmus, unsigned int rapl_pmu
 
 static int rapl_cpu_offline(unsigned int cpu)
 {
-	return __rapl_cpu_offline(rapl_pmus, get_rapl_pmu_idx(cpu),
+	return __rapl_cpu_offline(rapl_pmus_pkg, get_rapl_pmu_idx(cpu),
 				  get_rapl_pmu_cpumask(cpu), cpu);
 }
 
@@ -629,7 +630,7 @@ static int __rapl_cpu_online(struct rapl_pmus *rapl_pmus, unsigned int rapl_pmu_
 
 static int rapl_cpu_online(unsigned int cpu)
 {
-	return __rapl_cpu_online(rapl_pmus, get_rapl_pmu_idx(cpu),
+	return __rapl_cpu_online(rapl_pmus_pkg, get_rapl_pmu_idx(cpu),
 				 get_rapl_pmu_cpumask(cpu), cpu);
 }
 
@@ -642,8 +643,8 @@ static int rapl_check_hw_unit(void)
 	/* protect rdmsrl() to handle virtualization */
 	if (rdmsrl_safe(rapl_model->msr_power_unit, &msr_rapl_power_unit_bits))
 		return -1;
-	for (i = 0; i < NR_RAPL_DOMAINS; i++)
-		rapl_hw_unit[i] = (msr_rapl_power_unit_bits >> 8) & 0x1FULL;
+	for (i = 0; i < NR_RAPL_PKG_DOMAINS; i++)
+		rapl_pkg_hw_unit[i] = (msr_rapl_power_unit_bits >> 8) & 0x1FULL;
 
 	switch (rapl_model->unit_quirk) {
 	/*
@@ -653,11 +654,11 @@ static int rapl_check_hw_unit(void)
 	 * of 2. Datasheet, September 2014, Reference Number: 330784-001 "
 	 */
 	case RAPL_UNIT_QUIRK_INTEL_HSW:
-		rapl_hw_unit[PERF_RAPL_RAM] = 16;
+		rapl_pkg_hw_unit[PERF_RAPL_RAM] = 16;
 		break;
 	/* SPR uses a fixed energy unit for Psys domain. */
 	case RAPL_UNIT_QUIRK_INTEL_SPR:
-		rapl_hw_unit[PERF_RAPL_PSYS] = 0;
+		rapl_pkg_hw_unit[PERF_RAPL_PSYS] = 0;
 		break;
 	default:
 		break;
@@ -672,9 +673,9 @@ static int rapl_check_hw_unit(void)
 	 * if hw unit is 32, then we use 2 ms 1/200/2
 	 */
 	rapl_timer_ms = 2;
-	if (rapl_hw_unit[0] < 32) {
+	if (rapl_pkg_hw_unit[0] < 32) {
 		rapl_timer_ms = (1000 / (2 * 100));
-		rapl_timer_ms *= (1ULL << (32 - rapl_hw_unit[0] - 1));
+		rapl_timer_ms *= (1ULL << (32 - rapl_pkg_hw_unit[0] - 1));
 	}
 	return 0;
 }
@@ -684,12 +685,12 @@ static void __init rapl_advertise(void)
 	int i;
 
 	pr_info("API unit is 2^-32 Joules, %d fixed counters, %llu ms ovfl timer\n",
-		hweight32(rapl_cntr_mask), rapl_timer_ms);
+		hweight32(rapl_pkg_cntr_mask), rapl_timer_ms);
 
-	for (i = 0; i < NR_RAPL_DOMAINS; i++) {
-		if (rapl_cntr_mask & (1 << i)) {
+	for (i = 0; i < NR_RAPL_PKG_DOMAINS; i++) {
+		if (rapl_pkg_cntr_mask & (1 << i)) {
 			pr_info("hw unit of domain %s 2^-%d Joules\n",
-				rapl_domain_names[i], rapl_hw_unit[i]);
+				rapl_pkg_domain_names[i], rapl_pkg_hw_unit[i]);
 		}
 	}
 }
@@ -746,71 +747,71 @@ static int __init init_rapl_pmus(struct rapl_pmus **rapl_pmus_ptr)
 }
 
 static struct rapl_model model_snb = {
-	.events		= BIT(PERF_RAPL_PP0) |
+	.pkg_events	= BIT(PERF_RAPL_PP0) |
 			  BIT(PERF_RAPL_PKG) |
 			  BIT(PERF_RAPL_PP1),
 	.msr_power_unit = MSR_RAPL_POWER_UNIT,
-	.rapl_msrs      = intel_rapl_msrs,
+	.rapl_pkg_msrs	= intel_rapl_msrs,
 };
 
 static struct rapl_model model_snbep = {
-	.events		= BIT(PERF_RAPL_PP0) |
+	.pkg_events	= BIT(PERF_RAPL_PP0) |
 			  BIT(PERF_RAPL_PKG) |
 			  BIT(PERF_RAPL_RAM),
 	.msr_power_unit = MSR_RAPL_POWER_UNIT,
-	.rapl_msrs      = intel_rapl_msrs,
+	.rapl_pkg_msrs	= intel_rapl_msrs,
 };
 
 static struct rapl_model model_hsw = {
-	.events		= BIT(PERF_RAPL_PP0) |
+	.pkg_events	= BIT(PERF_RAPL_PP0) |
 			  BIT(PERF_RAPL_PKG) |
 			  BIT(PERF_RAPL_RAM) |
 			  BIT(PERF_RAPL_PP1),
 	.msr_power_unit = MSR_RAPL_POWER_UNIT,
-	.rapl_msrs      = intel_rapl_msrs,
+	.rapl_pkg_msrs	= intel_rapl_msrs,
 };
 
 static struct rapl_model model_hsx = {
-	.events		= BIT(PERF_RAPL_PP0) |
+	.pkg_events	= BIT(PERF_RAPL_PP0) |
 			  BIT(PERF_RAPL_PKG) |
 			  BIT(PERF_RAPL_RAM),
 	.unit_quirk	= RAPL_UNIT_QUIRK_INTEL_HSW,
 	.msr_power_unit = MSR_RAPL_POWER_UNIT,
-	.rapl_msrs      = intel_rapl_msrs,
+	.rapl_pkg_msrs	= intel_rapl_msrs,
 };
 
 static struct rapl_model model_knl = {
-	.events		= BIT(PERF_RAPL_PKG) |
+	.pkg_events	= BIT(PERF_RAPL_PKG) |
 			  BIT(PERF_RAPL_RAM),
 	.unit_quirk	= RAPL_UNIT_QUIRK_INTEL_HSW,
 	.msr_power_unit = MSR_RAPL_POWER_UNIT,
-	.rapl_msrs      = intel_rapl_msrs,
+	.rapl_pkg_msrs	= intel_rapl_msrs,
 };
 
 static struct rapl_model model_skl = {
-	.events		= BIT(PERF_RAPL_PP0) |
+	.pkg_events	= BIT(PERF_RAPL_PP0) |
 			  BIT(PERF_RAPL_PKG) |
 			  BIT(PERF_RAPL_RAM) |
 			  BIT(PERF_RAPL_PP1) |
 			  BIT(PERF_RAPL_PSYS),
 	.msr_power_unit = MSR_RAPL_POWER_UNIT,
-	.rapl_msrs      = intel_rapl_msrs,
+	.rapl_pkg_msrs	= intel_rapl_msrs,
 };
 
 static struct rapl_model model_spr = {
-	.events		= BIT(PERF_RAPL_PP0) |
+	.pkg_events	= BIT(PERF_RAPL_PP0) |
 			  BIT(PERF_RAPL_PKG) |
 			  BIT(PERF_RAPL_RAM) |
 			  BIT(PERF_RAPL_PSYS),
 	.unit_quirk	= RAPL_UNIT_QUIRK_INTEL_SPR,
 	.msr_power_unit = MSR_RAPL_POWER_UNIT,
-	.rapl_msrs      = intel_rapl_spr_msrs,
+	.rapl_pkg_msrs	= intel_rapl_spr_msrs,
 };
 
 static struct rapl_model model_amd_hygon = {
-	.events		= BIT(PERF_RAPL_PKG),
+	.pkg_events	= BIT(PERF_RAPL_PKG),
 	.msr_power_unit = MSR_AMD_RAPL_POWER_UNIT,
-	.rapl_msrs      = amd_rapl_msrs,
+	.rapl_pkg_msrs	= amd_rapl_pkg_msrs,
 };
 
 static const struct x86_cpu_id rapl_model_match[] __initconst = {
@@ -874,16 +875,16 @@ static int __init rapl_pmu_init(void)
 
 	rapl_model = (struct rapl_model *) id->driver_data;
 
-	rapl_msrs = rapl_model->rapl_msrs;
+	rapl_msrs = rapl_model->rapl_pkg_msrs;
 
-	rapl_cntr_mask = perf_msr_probe(rapl_msrs, PERF_RAPL_MAX,
-					false, (void *) &rapl_model->events);
+	rapl_pkg_cntr_mask = perf_msr_probe(rapl_msrs, PERF_RAPL_PKG_EVENTS_MAX,
+					false, (void *) &rapl_model->pkg_events);
 
 	ret = rapl_check_hw_unit();
 	if (ret)
 		return ret;
 
-	ret = init_rapl_pmus(&rapl_pmus);
+	ret = init_rapl_pmus(&rapl_pmus_pkg);
 	if (ret)
 		return ret;
 
@@ -896,7 +897,7 @@ static int __init rapl_pmu_init(void)
 	if (ret)
 		goto out;
 
-	ret = perf_pmu_register(&rapl_pmus->pmu, "power", -1);
+	ret = perf_pmu_register(&rapl_pmus_pkg->pmu, "power", -1);
 	if (ret)
 		goto out1;
 
@@ -907,7 +908,7 @@ static int __init rapl_pmu_init(void)
 	cpuhp_remove_state(CPUHP_AP_PERF_X86_RAPL_ONLINE);
 out:
 	pr_warn("Initialization failed (%d), disabled\n", ret);
-	cleanup_rapl_pmus(rapl_pmus);
+	cleanup_rapl_pmus(rapl_pmus_pkg);
 	return ret;
 }
 module_init(rapl_pmu_init);
@@ -915,7 +916,7 @@ module_init(rapl_pmu_init);
 static void __exit intel_rapl_exit(void)
 {
 	cpuhp_remove_state_nocalls(CPUHP_AP_PERF_X86_RAPL_ONLINE);
-	perf_pmu_unregister(&rapl_pmus->pmu);
-	cleanup_rapl_pmus(rapl_pmus);
+	perf_pmu_unregister(&rapl_pmus_pkg->pmu);
+	cleanup_rapl_pmus(rapl_pmus_pkg);
 }
 module_exit(intel_rapl_exit);
-- 
2.34.1


