Return-Path: <linux-pm+bounces-9874-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A867914270
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 08:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C236B23A10
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 06:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4091CF83;
	Mon, 24 Jun 2024 06:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ETHdzuM0"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2041.outbound.protection.outlook.com [40.107.101.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4A61C69A;
	Mon, 24 Jun 2024 06:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719208981; cv=fail; b=RF8arevOjFDP4obm6pL8NPf1byfZQWUZlTtcsSoaRZPBQPKyF/aPpjfR2eD2pr3+WRPUQUilDGQ4EUoRt2A89EfbEFC/49/CUL2hA2SDPxdE5LEstGJK32gkHWpkwycqiajIvKp/tmaEW+F8N7uwI/5xRizh6Z43TJpRhZBVPVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719208981; c=relaxed/simple;
	bh=f51elEAnnGY8jcyDm2clri5C8DYL0hi49mwoDWpy6C4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c/ub+tCCC+azBRy+wrBKiFF/GFfPAMVw5HnHFS6IvCfdk9enfozJP56qQAMxqV3ER27rmx/6c4MsXLax9Wml2jZzZdwh5989PnQ8eAPpB1efvHUajUa6TCy7t2PIt+ojZqhajrh7jh9LKOnATTQf4/WqiHzg/9OSFbfprnxJDCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ETHdzuM0; arc=fail smtp.client-ip=40.107.101.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QJKcmkyjlSLKiHkcLZGOd8EpNOjmZVVgX11VIQhJB8TsmkqW4yeHeqpUF8TgNHcvnVVOTbOLQRnPIKBdsWovyextyCV7HLff77trh7xoHsC7Qaj7tvTBV7a6i7kqTDN4tlYXz0YU10WG6aDf6PavWeVNw0+dCmCdYl78h+wv7f39c4wF87UE6R+qQMrERX7CBSlmIuadfbRwii9SRkLg5DC4AWnQwz8PJc2NQuy4VjfiK48UVe1zbZvNyry2iqlWypMLGwYRe6iksHkvtWmcvaxsuuidY/MSJ596kuBHKIKu5HAJuKpRyjO4oa1jzM4Tgz9+8zpu4pAFDDn8QTIggQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8mpl5fVfYKHno4hVEKboGWqoDffB6RRgOtt9zFqYIyY=;
 b=bqZN8+jzRclDzm0ppRibyHxsxzErMGYuaWuFw/Ujn/NziaJoXshntRNPqg1TA/UAOU2yNCoIl1dP2Xg8bAX5iUtWidqZ7ReNs3y+wPfkaOuh20MlHW5zniXUJ9QxPIJJSvZg03AG/Uvzsr9+07ZCnYF9tsEUaQ9WrkTXed7T4qHKsu+eUDSZO3M3XIB8qKybGOUXK6A/hkSZVLonyEO6qUBscUo6Q8EV+lRG0iB/I/hoXv49XW+1hqp+n92+TzawWis5V8BLwnkwYDnPAY1X/2snYvoFvWC/51VkcziGSlqih72FwhjTzd1zgfjJtf0mdWR0p7H2islwFFlCtqSZyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8mpl5fVfYKHno4hVEKboGWqoDffB6RRgOtt9zFqYIyY=;
 b=ETHdzuM02zCro4yGmwagTwhRMjSfq3/E06YZb75cSjDVBNjZAbnb1pcIkogW2RAMSNbmVOg+EN4sdGoVPQ0OX+nBwxmbMXl0UGsnadcnjz2xCU1jX67xd2luZVkHilI4NWKdMegOoe6VxlEJb6uQEVMTJW+TR9R8xLf/3IkfztI=
Received: from BL1PR13CA0387.namprd13.prod.outlook.com (2603:10b6:208:2c0::32)
 by DS0PR12MB6607.namprd12.prod.outlook.com (2603:10b6:8:d1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Mon, 24 Jun
 2024 06:02:56 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:208:2c0:cafe::25) by BL1PR13CA0387.outlook.office365.com
 (2603:10b6:208:2c0::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.37 via Frontend
 Transport; Mon, 24 Jun 2024 06:02:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055E1.mail.protection.outlook.com (10.167.245.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.0 via Frontend Transport; Mon, 24 Jun 2024 06:02:56 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Jun
 2024 01:02:48 -0500
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
Subject: [PATCH v3 08/10] perf/x86/rapl: Modify the generic variable names to *_pkg*
Date: Mon, 24 Jun 2024 05:59:05 +0000
Message-ID: <20240624055907.7720-9-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|DS0PR12MB6607:EE_
X-MS-Office365-Filtering-Correlation-Id: e5d75695-0fa0-4857-3b25-08dc94134afa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|82310400023|376011|7416011|1800799021|921017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8+NCCY3EBILmXhmOQOrPUW+qv9o528N2MselUi3sCGD6Cl194ZvFfXvK8gkR?=
 =?us-ascii?Q?a1dk7knjPZK8xz4ocAxNdCGLzMGT/ATz9gmcarcpteG9xQ76mCrbl7ui1cBh?=
 =?us-ascii?Q?AicBWYhWtvI1XjsBJBQXpPoNQi1ghNLAnZrMCHgQ83ZFP21QeOMosAV7cXmv?=
 =?us-ascii?Q?dGjZ1t+4tOlIyJDvm7cCd8hYYOrp1Ne/PiwGGqhYhPJJxliw+Op0Lx8yNzlv?=
 =?us-ascii?Q?8Sb5wPDe7da+4+x8G2guh5EjkuA9apHWf2UOJvOl5y6c2Yn5YoLAmpt8Cjfu?=
 =?us-ascii?Q?2bpwkxYRVxk/mJCmI7sQz8h2qmcZu3VLKRuTH2xv1MQLgwNvNL6/CwauIOgc?=
 =?us-ascii?Q?Rm0/BFuKBuOohdSK2/+HWdsJAAhCs6xiMQEB1y9YzBkWnGQ+HzLB5mMwogpZ?=
 =?us-ascii?Q?ms5Mk/zeiY2S+Wdg9PsO1xORwIHxHXfyzvSbec9y4T48gxfK39EcT6p768Qn?=
 =?us-ascii?Q?me1eY5csXuK0n8FcEPvovW1FWpyeBuJFIBdt8qobueu3B6xJbzL6GHDKC1ea?=
 =?us-ascii?Q?U6/yEKZIOjzw8UTNda16SeqeJqZOQ0KiMlaJZllQE1ObHtR+raIyTV9yfnPI?=
 =?us-ascii?Q?k0ayCmGglcet5bdL2l8O7/DhRUH7ij4JJ9Y6+tP1lVRZWvd1VgK+M1kw3h0o?=
 =?us-ascii?Q?1ArAmm0Mcigoz0o9uuz6m/7F+LnrGE9hYmzC9uF2du6RuBWwJ6wCk4trD/4A?=
 =?us-ascii?Q?3vw3Rc23t6EyZJj1y12329lThyz93tj0h6E2AQBZbAJkNKCsUoo7xtOijbgg?=
 =?us-ascii?Q?6EnOFrJ+d4RBiKEPHWuhr6L/BQwG2An0eoplurO///LqgVfTMF12MkTlR0iI?=
 =?us-ascii?Q?c+47xkjufzjrIVldxHIqNyfnwhvLQ52L1fGT5xdiIe7PNlrgPMTZaJxb4jDW?=
 =?us-ascii?Q?bRUubA6kjYMG4C2wdMRsk+pbI+/XNyyDeybI7LjRCD3UL1dg/1cFMKTs9XUh?=
 =?us-ascii?Q?/y1t8U7tfvo3TRWDRo1GP0IkMBxCmNEaVLl3Pj67oWPyt5+Bzhb1xvTnSi6n?=
 =?us-ascii?Q?7Js0gNdvMpHTtWSnmT/0r2eopSfKgTVCSaA3rwFIIGkoFBH9o4OGeX3Erpal?=
 =?us-ascii?Q?4xws/zt1Rq+ScJFsDVCPvegURWXn7zbL9+eunEJ2vPeKPQY6L+SNPGRbzxUN?=
 =?us-ascii?Q?JbyHL02RI0kwo+bPQ4X4CmZ01ovsYasc0ILvXW7vMqQfoejhYopO0/DgYmv2?=
 =?us-ascii?Q?sP7YRt9hwE0jg1W8sYgobfB+OnNwvbMwpXbo65q7bCnq/Bnv2MCreifYea9s?=
 =?us-ascii?Q?wcc7wwM4s4Tr0K6vpBZ2i/mPjM8A//Eq5ZPugWzsvXNvcIvTmvMkZ1tbQOq+?=
 =?us-ascii?Q?e0OFY6PFiIuaaUBWE1hWxreBgam8lmJ4uyjiLEcP4BMuI/l3g4LkotDaXQkz?=
 =?us-ascii?Q?F1txQfr9bBpbcl+VuS3U/d37TrpWYoov2yp3oadCL3rvK3TrHr2ED/FzmYjo?=
 =?us-ascii?Q?aNdHDaQxnTs=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(82310400023)(376011)(7416011)(1800799021)(921017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 06:02:56.2189
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5d75695-0fa0-4857-3b25-08dc94134afa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6607

Prep for addition of power_per_core PMU to handle core scope energy
consumption for AMD CPUs.

Replace the generic names with *_pkg*, to differentiate between the
scopes of the two different PMUs and their variables.

No functional change.

Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
---
 arch/x86/events/rapl.c | 83 +++++++++++++++++++++---------------------
 1 file changed, 42 insertions(+), 41 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index f815c60ec551..b03b044a390f 100644
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
@@ -132,15 +132,15 @@ enum rapl_unit_quirk {
 
 struct rapl_model {
 	struct perf_msr *rapl_msrs;
-	unsigned long	events;
+	unsigned long	pkg_events;
 	unsigned int	msr_power_unit;
 	enum rapl_unit_quirk	unit_quirk;
 };
 
  /* 1/2^hw_unit Joule */
-static int rapl_hw_unit[NR_RAPL_DOMAINS] __read_mostly;
-static struct rapl_pmus *rapl_pmus;
-static unsigned int rapl_cntr_mask;
+static int rapl_hw_unit[NR_RAPL_PKG_DOMAINS] __read_mostly;
+static struct rapl_pmus *rapl_pmus_pkg;
+static unsigned int rapl_pkg_cntr_mask;
 static u64 rapl_timer_ms;
 static struct perf_msr *rapl_msrs;
 static struct rapl_model *rapl_model;
@@ -165,7 +165,8 @@ static inline struct rapl_pmu *cpu_to_rapl_pmu(unsigned int cpu)
 	 * The unsigned check also catches the '-1' return value for non
 	 * existent mappings in the topology map.
 	 */
-	return rapl_pmu_idx < rapl_pmus->nr_rapl_pmu ? rapl_pmus->rapl_pmu[rapl_pmu_idx] : NULL;
+	return rapl_pmu_idx < rapl_pmus_pkg->nr_rapl_pmu ?
+	       rapl_pmus_pkg->rapl_pmu[rapl_pmu_idx] : NULL;
 }
 
 static inline u64 rapl_read_counter(struct perf_event *event)
@@ -177,7 +178,7 @@ static inline u64 rapl_read_counter(struct perf_event *event)
 
 static inline u64 rapl_scale(u64 v, int cfg)
 {
-	if (cfg > NR_RAPL_DOMAINS) {
+	if (cfg > NR_RAPL_PKG_DOMAINS) {
 		pr_warn("Invalid domain %d, failed to scale data\n", cfg);
 		return v;
 	}
@@ -347,7 +348,7 @@ static int rapl_pmu_event_init(struct perf_event *event)
 	struct rapl_pmu *rapl_pmu;
 
 	/* only look at RAPL events */
-	if (event->attr.type != rapl_pmus->pmu.type)
+	if (event->attr.type != rapl_pmus_pkg->pmu.type)
 		return -ENOENT;
 
 	/* check only supported bits are set */
@@ -359,14 +360,14 @@ static int rapl_pmu_event_init(struct perf_event *event)
 
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
@@ -394,7 +395,7 @@ static void rapl_pmu_event_read(struct perf_event *event)
 static ssize_t rapl_get_attr_cpumask(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
-	return cpumap_print_to_pagebuf(true, buf, &rapl_pmus->cpumask);
+	return cpumap_print_to_pagebuf(true, buf, &rapl_pmus_pkg->cpumask);
 }
 
 static DEVICE_ATTR(cpumask, S_IRUGO, rapl_get_attr_cpumask, NULL);
@@ -546,11 +547,11 @@ static struct perf_msr intel_rapl_spr_msrs[] = {
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
@@ -583,7 +584,7 @@ static int __rapl_cpu_offline(struct rapl_pmus *rapl_pmus, unsigned int rapl_pmu
 
 static int rapl_cpu_offline(unsigned int cpu)
 {
-	return __rapl_cpu_offline(rapl_pmus, get_rapl_pmu_idx(cpu),
+	return __rapl_cpu_offline(rapl_pmus_pkg, get_rapl_pmu_idx(cpu),
 				  get_rapl_pmu_cpumask(cpu), cpu);
 }
 
@@ -622,7 +623,7 @@ static int __rapl_cpu_online(struct rapl_pmus *rapl_pmus, unsigned int rapl_pmu_
 
 static int rapl_cpu_online(unsigned int cpu)
 {
-	return __rapl_cpu_online(rapl_pmus, get_rapl_pmu_idx(cpu),
+	return __rapl_cpu_online(rapl_pmus_pkg, get_rapl_pmu_idx(cpu),
 				 get_rapl_pmu_cpumask(cpu), cpu);
 }
 
@@ -635,7 +636,7 @@ static int rapl_check_hw_unit(void)
 	/* protect rdmsrl() to handle virtualization */
 	if (rdmsrl_safe(rapl_model->msr_power_unit, &msr_rapl_power_unit_bits))
 		return -1;
-	for (i = 0; i < NR_RAPL_DOMAINS; i++)
+	for (i = 0; i < NR_RAPL_PKG_DOMAINS; i++)
 		rapl_hw_unit[i] = (msr_rapl_power_unit_bits >> 8) & 0x1FULL;
 
 	switch (rapl_model->unit_quirk) {
@@ -677,12 +678,12 @@ static void __init rapl_advertise(void)
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
+				rapl_pkg_domain_names[i], rapl_hw_unit[i]);
 		}
 	}
 }
@@ -737,7 +738,7 @@ static int __init init_rapl_pmus(struct rapl_pmus **rapl_pmus_ptr)
 }
 
 static struct rapl_model model_snb = {
-	.events		= BIT(PERF_RAPL_PP0) |
+	.pkg_events	= BIT(PERF_RAPL_PP0) |
 			  BIT(PERF_RAPL_PKG) |
 			  BIT(PERF_RAPL_PP1),
 	.msr_power_unit = MSR_RAPL_POWER_UNIT,
@@ -745,7 +746,7 @@ static struct rapl_model model_snb = {
 };
 
 static struct rapl_model model_snbep = {
-	.events		= BIT(PERF_RAPL_PP0) |
+	.pkg_events	= BIT(PERF_RAPL_PP0) |
 			  BIT(PERF_RAPL_PKG) |
 			  BIT(PERF_RAPL_RAM),
 	.msr_power_unit = MSR_RAPL_POWER_UNIT,
@@ -753,7 +754,7 @@ static struct rapl_model model_snbep = {
 };
 
 static struct rapl_model model_hsw = {
-	.events		= BIT(PERF_RAPL_PP0) |
+	.pkg_events	= BIT(PERF_RAPL_PP0) |
 			  BIT(PERF_RAPL_PKG) |
 			  BIT(PERF_RAPL_RAM) |
 			  BIT(PERF_RAPL_PP1),
@@ -762,7 +763,7 @@ static struct rapl_model model_hsw = {
 };
 
 static struct rapl_model model_hsx = {
-	.events		= BIT(PERF_RAPL_PP0) |
+	.pkg_events	= BIT(PERF_RAPL_PP0) |
 			  BIT(PERF_RAPL_PKG) |
 			  BIT(PERF_RAPL_RAM),
 	.unit_quirk	= RAPL_UNIT_QUIRK_INTEL_HSW,
@@ -771,7 +772,7 @@ static struct rapl_model model_hsx = {
 };
 
 static struct rapl_model model_knl = {
-	.events		= BIT(PERF_RAPL_PKG) |
+	.pkg_events	= BIT(PERF_RAPL_PKG) |
 			  BIT(PERF_RAPL_RAM),
 	.unit_quirk	= RAPL_UNIT_QUIRK_INTEL_HSW,
 	.msr_power_unit = MSR_RAPL_POWER_UNIT,
@@ -779,7 +780,7 @@ static struct rapl_model model_knl = {
 };
 
 static struct rapl_model model_skl = {
-	.events		= BIT(PERF_RAPL_PP0) |
+	.pkg_events	= BIT(PERF_RAPL_PP0) |
 			  BIT(PERF_RAPL_PKG) |
 			  BIT(PERF_RAPL_RAM) |
 			  BIT(PERF_RAPL_PP1) |
@@ -789,7 +790,7 @@ static struct rapl_model model_skl = {
 };
 
 static struct rapl_model model_spr = {
-	.events		= BIT(PERF_RAPL_PP0) |
+	.pkg_events	= BIT(PERF_RAPL_PP0) |
 			  BIT(PERF_RAPL_PKG) |
 			  BIT(PERF_RAPL_RAM) |
 			  BIT(PERF_RAPL_PSYS),
@@ -799,9 +800,9 @@ static struct rapl_model model_spr = {
 };
 
 static struct rapl_model model_amd_hygon = {
-	.events		= BIT(PERF_RAPL_PKG),
+	.pkg_events	= BIT(PERF_RAPL_PKG),
 	.msr_power_unit = MSR_AMD_RAPL_POWER_UNIT,
-	.rapl_msrs      = amd_rapl_msrs,
+	.rapl_msrs      = amd_rapl_pkg_msrs,
 };
 
 static const struct x86_cpu_id rapl_model_match[] __initconst = {
@@ -867,14 +868,14 @@ static int __init rapl_pmu_init(void)
 
 	rapl_msrs = rapl_model->rapl_msrs;
 
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
 
@@ -887,7 +888,7 @@ static int __init rapl_pmu_init(void)
 	if (ret)
 		goto out;
 
-	ret = perf_pmu_register(&rapl_pmus->pmu, "power", -1);
+	ret = perf_pmu_register(&rapl_pmus_pkg->pmu, "power", -1);
 	if (ret)
 		goto out1;
 
@@ -898,7 +899,7 @@ static int __init rapl_pmu_init(void)
 	cpuhp_remove_state(CPUHP_AP_PERF_X86_RAPL_ONLINE);
 out:
 	pr_warn("Initialization failed (%d), disabled\n", ret);
-	cleanup_rapl_pmus(rapl_pmus);
+	cleanup_rapl_pmus(rapl_pmus_pkg);
 	return ret;
 }
 module_init(rapl_pmu_init);
@@ -906,7 +907,7 @@ module_init(rapl_pmu_init);
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


