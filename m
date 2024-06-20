Return-Path: <linux-pm+bounces-9669-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0BE910565
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2024 15:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE89D285B61
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2024 13:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFE61B151F;
	Thu, 20 Jun 2024 13:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tUEjaoVt"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC161B1519;
	Thu, 20 Jun 2024 13:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718888576; cv=fail; b=QYsx3NYRE4x0w225Vb44JFo5pcXU4zA16dy6SPUrGPIXQbSLK0XEXEDTrXVke96W/+IG8L+CLbW1b1COLbCday8MclMNWkpw/rOktkla7HOkHJKvD5e3QdxOOvOzyY9XdOCqfsRT2DNVWlS2grIuHtZrkYwXWWhgYnsCG0LyGHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718888576; c=relaxed/simple;
	bh=f51elEAnnGY8jcyDm2clri5C8DYL0hi49mwoDWpy6C4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=quO7YvABiEYcP6/JgjEygP3PyqqznbJcezBaDUHkqLgU6YxQDKw5RHOOI10L7x0ZEfi6lj6K8YD8ce/JcHPB0O0qPeyfLn5PNar6BCfBaF9FjkGkM8MK4tCmWn+dGbNss2vFUloafrskoeO6eMswtaCv2bChppP3XFDzCYTrCjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tUEjaoVt; arc=fail smtp.client-ip=40.107.244.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IPKEd7nut0DX0tdxA/8azj+D8MRKYRVSyAIzx7ILhTS9gIv4L6zYGENaBBzTCy8686lZ9UfF6nCaE8V9BuQUHeyvbbehcNaJ1Bq/h31eLiKpeQuJkZJRiPPO8+QR4kb4loRpO1SnN3bkJ7Q8CdB4kFbiibSyf4Op86PmHHWcaEx9aAevUue7ZAj8eGyeD1kTUvDyP64ROKi9EBkr1SLSleWY+l94OF/2u8/uE8j2KQHiSqnvkENz7ROvOr8ngKAo89cgoq+42wdvKBRpBeiu9k52/q3dblAh0DTNqWlch1UlG132Ih5crXNi1AbJJwSCrBoobvak+bNIKRQ0ojbxQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8mpl5fVfYKHno4hVEKboGWqoDffB6RRgOtt9zFqYIyY=;
 b=BrAh8yyFPrXNp6siT3YQV58IkgvgwV1ae2M6budUYtVnsLuAwcd9NKIgtuHcGAHMuWfGzRK/c31yQPoflJMWy0GtMQ7LFWMcXlT2qKVR4n04sCb+/NWNRDryYDLo5V0cfTkyKG19Bs6rT/+DIX3YgSBNtF/iSadbpddJVF95oongUdl8idB93+hZnPXnDkVURAYK4xH6TJTsEx3jWQmY0a4JtuznPV9fzo35cqicrjdyHEtlNhMmBc5ITalRVtMSHPWVIhQmXvOfgUYsNALyRf8y1ezPLGeFXaYIj2P93AiHEOUY3ji7eH1Lf+OhXFtH++z5S5W+SxGO2uSEJTNzFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8mpl5fVfYKHno4hVEKboGWqoDffB6RRgOtt9zFqYIyY=;
 b=tUEjaoVtiDCf22IjlTCs+2FBJu80Nq86rG7W+SRU/Vlg8TvpECYJVgKbVsLoBVbUrvWOmJFIADMBCMaQ75HiH5hava8vhledTLYxDgh6EkZOqpyOxI4KcP9b8BfgL+D9dzbA3qDPfRKjOnHZ7iz3WWsWMoWK7GHD9xUTx2jNEn4=
Received: from MN2PR14CA0025.namprd14.prod.outlook.com (2603:10b6:208:23e::30)
 by BY5PR12MB4177.namprd12.prod.outlook.com (2603:10b6:a03:201::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Thu, 20 Jun
 2024 13:02:51 +0000
Received: from BL6PEPF0001AB50.namprd04.prod.outlook.com
 (2603:10b6:208:23e:cafe::68) by MN2PR14CA0025.outlook.office365.com
 (2603:10b6:208:23e::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Thu, 20 Jun 2024 13:02:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB50.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 20 Jun 2024 13:02:50 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Jun
 2024 08:02:43 -0500
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
Subject: [PATCH v2 7/9] perf/x86/rapl: Modify the generic variable names to *_pkg*
Date: Thu, 20 Jun 2024 12:57:01 +0000
Message-ID: <20240620125703.3297-8-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB50:EE_|BY5PR12MB4177:EE_
X-MS-Office365-Filtering-Correlation-Id: 8014b579-6a46-4115-4d97-08dc91294a75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|82310400023|7416011|376011|36860700010|921017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mGA3dx2K25ink7GvJN7IGDacM7enbUAlx4WaFC5UhEQVC9cL6LGg81PJa0YV?=
 =?us-ascii?Q?5rGi5RpcZ0n8JNF6q5XclQphQRRli3xNbH0jhpoiBsDCFgjuF86TkkLRpo84?=
 =?us-ascii?Q?ZFizrFgTxmhubX99x+1ac50CJBnw5ZVOP4gWwWNDkc2sFJ1gTQnCpCvHvBRp?=
 =?us-ascii?Q?rmR6dZClDvARjv8MGrXXd/y3dpWucT4igap36dfrgxjpTRWxZyI0F5VSvmXo?=
 =?us-ascii?Q?i9FXbg8XltJhq7iXmv2PuhWqNl9NP4X5Iy4Lq2Y2WJPpZRM2zzCL+YPOS5j1?=
 =?us-ascii?Q?i2J9yLHO2UW62RooxWvjSPyGz0DeX9OoJaDOfriVKLUpVL3JhQY7bKqRwuDP?=
 =?us-ascii?Q?nV0JzlS8PzDu/7EkIYRxbGJQ04NZygJxnEL5yEO7P74Y5naS3cr3sk/lQJoY?=
 =?us-ascii?Q?SlxDf2/+1m1RYxCdopatiAMmQpkJuZRzwGgFv6CN1NnO1bUvVbeH7KPFQOyQ?=
 =?us-ascii?Q?sCxI6QvMtGBUd4xCw0rajWb6OKDH1PJp8rh+hRNWZc35wcuIeALYOrFPYMvp?=
 =?us-ascii?Q?nqOx2+UqDV+OORZqCS6Jnl1u/x6SIHd7fOXSPLphrMPn8e2emcm3a9jjxoKa?=
 =?us-ascii?Q?rjkzKyPA/9fzcqeamoDFlt8au0TwC/KX8vaqSMLbg3bZbs9jPmwpiYGP2pM2?=
 =?us-ascii?Q?2Egu5Sz1uViJUllDKdW/+SfdP/5Xyq38mlem0SPb8sQgfuR0CNVsqdGL//9K?=
 =?us-ascii?Q?gSlfbo+jR7AIErFONuD1rsLIwM2OQya0GgW/IYRJat25N33kS7aGFwmodghz?=
 =?us-ascii?Q?UBQhc28RrS7WDQj7kFQKRf/XVPxTLJmLvjE5f5VmwY3qvT2iWu80ut9GV4It?=
 =?us-ascii?Q?vMhkLu8vnbQKVi3T9jhMw7E/i7s4qEWsYJ9jriYTRW01rpaK/eOlD+fxpC91?=
 =?us-ascii?Q?+3MWnYGdsUoWM2Ux9yrnJs05Gu3FkLdFYvDaonokUl1g+mRAEf4HnsInei1f?=
 =?us-ascii?Q?zIxLavDnkBV0Av14EQ3nXmqLP2mNVZoaolt/tjvO0jrWNFNq/9WDimt5vSGk?=
 =?us-ascii?Q?M1Vj9nYz5mwRBeAHuzzqvx1sDMSHTAtJlPfljLGgHMcDP12ZuOHe0pGVLKJY?=
 =?us-ascii?Q?CZz7j5IfNN4C5D/q4c+9BX7g6aaXeX+o4Nuh9YEWOcZPROG7f/rtH0+Yura+?=
 =?us-ascii?Q?sYCjp5s1pf8u9kGzb9TEySqyFcDEciqC2sJwm2Ed9h/7I1hzTihPUBEP+haN?=
 =?us-ascii?Q?zkyvdcvh/vxF53UFR00TZRKCcNvHATtjlMz1uHoHuYxRSY4Z+fbGj0Icql13?=
 =?us-ascii?Q?sno0qm/I9YEh1QE66jCLS24p6aaERPE3DeutUpt4PLbptNOCwyohdrLtPmJO?=
 =?us-ascii?Q?ZBp9zXuiZ4v6+dJLgrX2PSVjGwBGmazqFZO316bIKm0un2QlB/xLadaWAHse?=
 =?us-ascii?Q?6erxgYrpaAasklnHLSJRgaDbpEs/9ggajX2tBJpXUkMTqTld0N+HftSWF32L?=
 =?us-ascii?Q?PtmiIGeCJwE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(1800799021)(82310400023)(7416011)(376011)(36860700010)(921017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 13:02:50.8031
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8014b579-6a46-4115-4d97-08dc91294a75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB50.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4177

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


