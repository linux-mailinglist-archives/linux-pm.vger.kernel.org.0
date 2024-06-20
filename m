Return-Path: <linux-pm+bounces-9664-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8BA910556
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2024 15:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CE2F1F22194
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2024 13:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909A11AF692;
	Thu, 20 Jun 2024 13:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lcpQ9Fe+"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19871AD407;
	Thu, 20 Jun 2024 13:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718888480; cv=fail; b=AsAcQ0MEUho0eUSpvF5/v+878Ha59FnotVpK1RXSltrBpeVmn/AVVJlN5n8BSjwgzxL5mRA10cZCw1PuhHk0z/T9jECdvYjXFpH9khw2KnceL3N7IO6K8Wc7aT9LhaiPenBB4nlpCqQshwQv+suEvLtA2WDxKq91DwW9+B1suR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718888480; c=relaxed/simple;
	bh=bdHqtKQgt7guqR41b+qTLiClw9pcS6FtJ1Uis4RlDfw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R1pduAbvNtr/Fq7Zn4igbBz3E2W2zTvM4AkOa52yo13IiFszZn1hL3FjutejxUWikNy3kYdjLkfUT550enRrHNLP+jAgWDGCTE2gSykOBLtB0STmBjU7w23mjKYA+KNs2vn8pNHEo4aHCs3LixY10zBbDgdK1BcDrd4dKvWphls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lcpQ9Fe+; arc=fail smtp.client-ip=40.107.220.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TZ7kc72xw85U0Idb0AJzl7wszjEYls/pwwrkk/jcfMnOQX9QjPb2JMJ0kFbYpFIiHT1ZDavK5yMatl+CHFhkV7MtV1z1gTRjioTKH+gH7kgXr0lbRl9QVNzlo9qr55zFMgMvql61sfbcn96MlSqEyIE7sRred7Kbq5FzyaorKc6NziFV6zCFlLMvfxHEbHmpS/wc81bahAZPQsRDyJVWlaI1Ubh5S+m5mLYL44KPmIJaOTKgAK0DZgLJXQq2qlmNXH1uQD+L3ILC11ea7B1jOvBWlmw1ACTILoRBMtNyRvIHEaLqLsDgshBvtLWEi7CJ/ADtw6AMrgnPJRjWKWz1uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8NbjBZFGLCOQPKlMZfmrhLpqA0S8CIGooxpyooHDAQo=;
 b=bmFhX0NtLG006ouVi9pnG/dHQc3NcRQY5nW+uvLwGhRiDxw28zw5FCjYwLKiGPAarP3Hpeuw1ptlcKZ/1TluzjqExTm0sYcVsJ9BjJnbDcB6dJOa57DfKN0yNSpZBjAW5zC+A4Hh+sJinRZf5WEx5mRdmDSjlDV8YvQ0OXPF81TppLOc0gxGf++/TH2CCaPiSxnn3J2p96JE6GrqONHbRdP2DA6TqOsy8ZZAukSJ9ZMYqw+PyGlRNvs4+RsVH0U4gVwNN3+aphHA6nWZAmle6wdyE42u9FZxxo77ndgYXmhXeJqTmetBuqqJBKiBkOlcXCANJWisKE7j0j4jVNadnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8NbjBZFGLCOQPKlMZfmrhLpqA0S8CIGooxpyooHDAQo=;
 b=lcpQ9Fe+p30GPt+6lQrcnF9f637TbI1C76qREEnHMs2SzYhWZCb3y6PhBZ24K/siJ4/Qj8at+bSuIHrbUb6UvNViokI7rbU7d64AmZ+wdyVDSD9kTUB6/3FrE4U7AO0YW8PHWNDccmMLFzQhFvsbAC6nukP+W/mY6OV+KwyQpns=
Received: from BLAPR03CA0022.namprd03.prod.outlook.com (2603:10b6:208:32b::27)
 by SA1PR12MB7318.namprd12.prod.outlook.com (2603:10b6:806:2b3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Thu, 20 Jun
 2024 13:01:13 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:208:32b:cafe::74) by BLAPR03CA0022.outlook.office365.com
 (2603:10b6:208:32b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.34 via Frontend
 Transport; Thu, 20 Jun 2024 13:01:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 20 Jun 2024 13:01:12 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Jun
 2024 08:01:04 -0500
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
Subject: [PATCH v2 2/9] perf/x86/rapl: Rename rapl_pmu variables
Date: Thu, 20 Jun 2024 12:56:56 +0000
Message-ID: <20240620125703.3297-3-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|SA1PR12MB7318:EE_
X-MS-Office365-Filtering-Correlation-Id: dd8688f8-2127-4d4d-3b08-08dc91291003
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|1800799021|82310400023|7416011|921017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DnSIYI0NS7T43BorBXRcnTY3pYMQRDTg4ulNaJFRFc/rqKVzK6x952C9EmKo?=
 =?us-ascii?Q?kM7t29WACmYTCMbxZuCpxgm44KVvf+C9s/9vhEckQ5ynWd8PUmf7YQ3iDp4e?=
 =?us-ascii?Q?4udy0FkHCCBlFoJNabsH5dz7DN9Le7K1A0X4s1WYPY/fydPMKpDxFV3W3FHx?=
 =?us-ascii?Q?K4s5BG5rjjgnyXJz0C7ZaoDsmnVVlAr8ytSJvFOxuZS/YIgRkdCI+ArEWkUI?=
 =?us-ascii?Q?PPnuJq5IPczWaco7FBQF9TnbdHVnrdxoESjbhEvcKwsAi3m/Mm5z3rfEVq+x?=
 =?us-ascii?Q?sXY4z1K1GY9UXFrYNOMXGHwoGO7lBQ/bT90x0OxFe1MEttLyaOQZc3Tid35x?=
 =?us-ascii?Q?AnbOlAdy1iZpGwY6pbUymW0QddIZpeOFmCKQDteF29c1iyBl1qA4+NQ/iywN?=
 =?us-ascii?Q?9rFxuuhZd0McuF+wBGvdqhXR+ymHZ25SMeydR+izpdIniOw+kl0mr78avHyT?=
 =?us-ascii?Q?30UpHGR9WCSHhcQl/2ITvFC0ZMn0vY4kyy8wkuW9cXtntP38pPXwEQwQqYYj?=
 =?us-ascii?Q?5wvQwzaS+QDdYUIyYjnak9i3IDw/Yscya0x/PSy5J/dX8d8Cn/f/tYsYksNg?=
 =?us-ascii?Q?MBkRz5N9e4BD2thJdKfv4yO3XcZ8tS4N8yVKry7v8tIV7CQZ9w3qb4bapYyQ?=
 =?us-ascii?Q?JFYjsDqk/44YK/2HHvuiUW+eOW7jABeztH0DxULp6WLuqIPU/Eb57K30G5mo?=
 =?us-ascii?Q?iTBWe9IfLFdihp1fmaams1JT/pWpeH8c8fgrl6PA07gfIPUmlRrq8v8CAPUF?=
 =?us-ascii?Q?UslEhvxKLH3DoyyiSh/NwFJli32jUad/k2AAYuVRxjg2TdtVrEucqjo1dyrR?=
 =?us-ascii?Q?p5glSFPmQ+4vI+E3wE4bB3ZIcwG9mbXjJqjlrLLp6vRnNJvJb79PgOLWHQer?=
 =?us-ascii?Q?35qICG0NZJG9tQjBr0klxlqELjM4rQMQuCzYZExJSoqRox3Qdg+rNex7GfnU?=
 =?us-ascii?Q?dMYbb2bLFVEKq0DXKh4cHUvSj8NVPgKwJsEivj39+YOUr3DLaxOPZMxxqJdk?=
 =?us-ascii?Q?7XZ8IpAoucuk/dMzS8QuG4Z4pyIByZWb+TnYwUKr8zbZv1q+9UQbJfB4VcP0?=
 =?us-ascii?Q?6GRltKhfdnOx9amD+ags3EcqFOegCnPvaaXs8iO+OvlkM6SR9l82vNCNVgLz?=
 =?us-ascii?Q?u5pxJBP+oqTDt79x8pYRivoUxwDEhTlkYkwDecoKn5YItUNAffvcxtCY3eMA?=
 =?us-ascii?Q?A8I5OCFgDSN28ZRL42mRdNCgYeMbJjRsJcmzhmhoYCUN/YFDTU8ZupPuPE4P?=
 =?us-ascii?Q?3JDcAgmISIcT5kQU2JIF/6fbq1qNbSrZ+pz7BxYWQNrwg7W1fc4qimNlmUP7?=
 =?us-ascii?Q?tLHX4shXBxHXTOAi0wK/NPwe00ucxx86R6bD4haJGl0Z+cl6bv/NCOvuLcnI?=
 =?us-ascii?Q?UpVQlICm4YiFVIJGI5fM1GzASVu57Kt0Pse3Td+0pAACIRUsM+pd5ypg8sUI?=
 =?us-ascii?Q?wWZFOigbQXM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(376011)(1800799021)(82310400023)(7416011)(921017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 13:01:12.7320
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd8688f8-2127-4d4d-3b08-08dc91291003
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7318

Rename struct rapl_pmu variables from "pmu" to "rapl_pmu", to
avoid any confusion between the variables of two different
structs pmu and rapl_pmu. As rapl_pmu also contains a pointer to
struct pmu, which leads to situations in code like pmu->pmu,
which is needlessly confusing. Above scenario is replaced with
much more readable rapl_pmu->pmu with this change.

Also rename "pmus" member in rapl_pmus struct, for same reason.

No functional change.

Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
---
 arch/x86/events/rapl.c | 104 ++++++++++++++++++++---------------------
 1 file changed, 52 insertions(+), 52 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 73be25e1f4b4..b4e2073a178e 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -120,7 +120,7 @@ struct rapl_pmu {
 struct rapl_pmus {
 	struct pmu		pmu;
 	unsigned int		nr_rapl_pmu;
-	struct rapl_pmu		*pmus[] __counted_by(nr_rapl_pmu);
+	struct rapl_pmu		*rapl_pmu[] __counted_by(nr_rapl_pmu);
 };
 
 enum rapl_unit_quirk {
@@ -164,7 +164,7 @@ static inline struct rapl_pmu *cpu_to_rapl_pmu(unsigned int cpu)
 	 * The unsigned check also catches the '-1' return value for non
 	 * existent mappings in the topology map.
 	 */
-	return rapl_pmu_idx < rapl_pmus->nr_rapl_pmu ? rapl_pmus->pmus[rapl_pmu_idx] : NULL;
+	return rapl_pmu_idx < rapl_pmus->nr_rapl_pmu ? rapl_pmus->rapl_pmu[rapl_pmu_idx] : NULL;
 }
 
 static inline u64 rapl_read_counter(struct perf_event *event)
@@ -228,34 +228,34 @@ static void rapl_start_hrtimer(struct rapl_pmu *pmu)
 
 static enum hrtimer_restart rapl_hrtimer_handle(struct hrtimer *hrtimer)
 {
-	struct rapl_pmu *pmu = container_of(hrtimer, struct rapl_pmu, hrtimer);
+	struct rapl_pmu *rapl_pmu = container_of(hrtimer, struct rapl_pmu, hrtimer);
 	struct perf_event *event;
 	unsigned long flags;
 
-	if (!pmu->n_active)
+	if (!rapl_pmu->n_active)
 		return HRTIMER_NORESTART;
 
-	raw_spin_lock_irqsave(&pmu->lock, flags);
+	raw_spin_lock_irqsave(&rapl_pmu->lock, flags);
 
-	list_for_each_entry(event, &pmu->active_list, active_entry)
+	list_for_each_entry(event, &rapl_pmu->active_list, active_entry)
 		rapl_event_update(event);
 
-	raw_spin_unlock_irqrestore(&pmu->lock, flags);
+	raw_spin_unlock_irqrestore(&rapl_pmu->lock, flags);
 
-	hrtimer_forward_now(hrtimer, pmu->timer_interval);
+	hrtimer_forward_now(hrtimer, rapl_pmu->timer_interval);
 
 	return HRTIMER_RESTART;
 }
 
-static void rapl_hrtimer_init(struct rapl_pmu *pmu)
+static void rapl_hrtimer_init(struct rapl_pmu *rapl_pmu)
 {
-	struct hrtimer *hr = &pmu->hrtimer;
+	struct hrtimer *hr = &rapl_pmu->hrtimer;
 
 	hrtimer_init(hr, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	hr->function = rapl_hrtimer_handle;
 }
 
-static void __rapl_pmu_event_start(struct rapl_pmu *pmu,
+static void __rapl_pmu_event_start(struct rapl_pmu *rapl_pmu,
 				   struct perf_event *event)
 {
 	if (WARN_ON_ONCE(!(event->hw.state & PERF_HES_STOPPED)))
@@ -263,39 +263,39 @@ static void __rapl_pmu_event_start(struct rapl_pmu *pmu,
 
 	event->hw.state = 0;
 
-	list_add_tail(&event->active_entry, &pmu->active_list);
+	list_add_tail(&event->active_entry, &rapl_pmu->active_list);
 
 	local64_set(&event->hw.prev_count, rapl_read_counter(event));
 
-	pmu->n_active++;
-	if (pmu->n_active == 1)
-		rapl_start_hrtimer(pmu);
+	rapl_pmu->n_active++;
+	if (rapl_pmu->n_active == 1)
+		rapl_start_hrtimer(rapl_pmu);
 }
 
 static void rapl_pmu_event_start(struct perf_event *event, int mode)
 {
-	struct rapl_pmu *pmu = event->pmu_private;
+	struct rapl_pmu *rapl_pmu = event->pmu_private;
 	unsigned long flags;
 
-	raw_spin_lock_irqsave(&pmu->lock, flags);
-	__rapl_pmu_event_start(pmu, event);
-	raw_spin_unlock_irqrestore(&pmu->lock, flags);
+	raw_spin_lock_irqsave(&rapl_pmu->lock, flags);
+	__rapl_pmu_event_start(rapl_pmu, event);
+	raw_spin_unlock_irqrestore(&rapl_pmu->lock, flags);
 }
 
 static void rapl_pmu_event_stop(struct perf_event *event, int mode)
 {
-	struct rapl_pmu *pmu = event->pmu_private;
+	struct rapl_pmu *rapl_pmu = event->pmu_private;
 	struct hw_perf_event *hwc = &event->hw;
 	unsigned long flags;
 
-	raw_spin_lock_irqsave(&pmu->lock, flags);
+	raw_spin_lock_irqsave(&rapl_pmu->lock, flags);
 
 	/* mark event as deactivated and stopped */
 	if (!(hwc->state & PERF_HES_STOPPED)) {
-		WARN_ON_ONCE(pmu->n_active <= 0);
-		pmu->n_active--;
-		if (pmu->n_active == 0)
-			hrtimer_cancel(&pmu->hrtimer);
+		WARN_ON_ONCE(rapl_pmu->n_active <= 0);
+		rapl_pmu->n_active--;
+		if (rapl_pmu->n_active == 0)
+			hrtimer_cancel(&rapl_pmu->hrtimer);
 
 		list_del(&event->active_entry);
 
@@ -313,23 +313,23 @@ static void rapl_pmu_event_stop(struct perf_event *event, int mode)
 		hwc->state |= PERF_HES_UPTODATE;
 	}
 
-	raw_spin_unlock_irqrestore(&pmu->lock, flags);
+	raw_spin_unlock_irqrestore(&rapl_pmu->lock, flags);
 }
 
 static int rapl_pmu_event_add(struct perf_event *event, int mode)
 {
-	struct rapl_pmu *pmu = event->pmu_private;
+	struct rapl_pmu *rapl_pmu = event->pmu_private;
 	struct hw_perf_event *hwc = &event->hw;
 	unsigned long flags;
 
-	raw_spin_lock_irqsave(&pmu->lock, flags);
+	raw_spin_lock_irqsave(&rapl_pmu->lock, flags);
 
 	hwc->state = PERF_HES_UPTODATE | PERF_HES_STOPPED;
 
 	if (mode & PERF_EF_START)
-		__rapl_pmu_event_start(pmu, event);
+		__rapl_pmu_event_start(rapl_pmu, event);
 
-	raw_spin_unlock_irqrestore(&pmu->lock, flags);
+	raw_spin_unlock_irqrestore(&rapl_pmu->lock, flags);
 
 	return 0;
 }
@@ -343,7 +343,7 @@ static int rapl_pmu_event_init(struct perf_event *event)
 {
 	u64 cfg = event->attr.config & RAPL_EVENT_MASK;
 	int bit, ret = 0;
-	struct rapl_pmu *pmu;
+	struct rapl_pmu *rapl_pmu;
 
 	/* only look at RAPL events */
 	if (event->attr.type != rapl_pmus->pmu.type)
@@ -373,11 +373,11 @@ static int rapl_pmu_event_init(struct perf_event *event)
 		return -EINVAL;
 
 	/* must be done before validate_group */
-	pmu = cpu_to_rapl_pmu(event->cpu);
-	if (!pmu)
+	rapl_pmu = cpu_to_rapl_pmu(event->cpu);
+	if (!rapl_pmu)
 		return -EINVAL;
-	event->cpu = pmu->cpu;
-	event->pmu_private = pmu;
+	event->cpu = rapl_pmu->cpu;
+	event->pmu_private = rapl_pmu;
 	event->hw.event_base = rapl_msrs[bit].msr;
 	event->hw.config = cfg;
 	event->hw.idx = bit;
@@ -560,22 +560,22 @@ static struct perf_msr amd_rapl_msrs[] = {
 static int rapl_cpu_offline(unsigned int cpu)
 {
 	const struct cpumask *rapl_pmu_cpumask = get_rapl_pmu_cpumask(cpu);
-	struct rapl_pmu *pmu = cpu_to_rapl_pmu(cpu);
+	struct rapl_pmu *rapl_pmu = cpu_to_rapl_pmu(cpu);
 	int target;
 
 	/* Check if exiting cpu is used for collecting rapl events */
 	if (!cpumask_test_and_clear_cpu(cpu, &rapl_cpu_mask))
 		return 0;
 
-	pmu->cpu = -1;
+	rapl_pmu->cpu = -1;
 	/* Find a new cpu to collect rapl events */
 	target = cpumask_any_but(rapl_pmu_cpumask, cpu);
 
 	/* Migrate rapl events to the new target */
 	if (target < nr_cpu_ids) {
 		cpumask_set_cpu(target, &rapl_cpu_mask);
-		pmu->cpu = target;
-		perf_pmu_migrate_context(pmu->pmu, cpu, target);
+		rapl_pmu->cpu = target;
+		perf_pmu_migrate_context(rapl_pmu->pmu, cpu, target);
 	}
 	return 0;
 }
@@ -584,21 +584,21 @@ static int rapl_cpu_online(unsigned int cpu)
 {
 	unsigned int rapl_pmu_idx = get_rapl_pmu_idx(cpu);
 	const struct cpumask *rapl_pmu_cpumask = get_rapl_pmu_cpumask(cpu);
-	struct rapl_pmu *pmu = cpu_to_rapl_pmu(cpu);
+	struct rapl_pmu *rapl_pmu = cpu_to_rapl_pmu(cpu);
 	int target;
 
-	if (!pmu) {
-		pmu = kzalloc_node(sizeof(*pmu), GFP_KERNEL, cpu_to_node(cpu));
-		if (!pmu)
+	if (!rapl_pmu) {
+		rapl_pmu = kzalloc_node(sizeof(*rapl_pmu), GFP_KERNEL, cpu_to_node(cpu));
+		if (!rapl_pmu)
 			return -ENOMEM;
 
-		raw_spin_lock_init(&pmu->lock);
-		INIT_LIST_HEAD(&pmu->active_list);
-		pmu->pmu = &rapl_pmus->pmu;
-		pmu->timer_interval = ms_to_ktime(rapl_timer_ms);
-		rapl_hrtimer_init(pmu);
+		raw_spin_lock_init(&rapl_pmu->lock);
+		INIT_LIST_HEAD(&rapl_pmu->active_list);
+		rapl_pmu->pmu = &rapl_pmus->pmu;
+		rapl_pmu->timer_interval = ms_to_ktime(rapl_timer_ms);
+		rapl_hrtimer_init(rapl_pmu);
 
-		rapl_pmus->pmus[rapl_pmu_idx] = pmu;
+		rapl_pmus->rapl_pmu[rapl_pmu_idx] = rapl_pmu;
 	}
 
 	/*
@@ -610,7 +610,7 @@ static int rapl_cpu_online(unsigned int cpu)
 		return 0;
 
 	cpumask_set_cpu(cpu, &rapl_cpu_mask);
-	pmu->cpu = cpu;
+	rapl_pmu->cpu = cpu;
 	return 0;
 }
 
@@ -679,7 +679,7 @@ static void cleanup_rapl_pmus(void)
 	int i;
 
 	for (i = 0; i < rapl_pmus->nr_rapl_pmu; i++)
-		kfree(rapl_pmus->pmus[i]);
+		kfree(rapl_pmus->rapl_pmu[i]);
 	kfree(rapl_pmus);
 }
 
@@ -699,7 +699,7 @@ static int __init init_rapl_pmus(void)
 	if (rapl_pmu_is_pkg_scope())
 		nr_rapl_pmu = topology_max_packages();
 
-	rapl_pmus = kzalloc(struct_size(rapl_pmus, pmus, nr_rapl_pmu), GFP_KERNEL);
+	rapl_pmus = kzalloc(struct_size(rapl_pmus, rapl_pmu, nr_rapl_pmu), GFP_KERNEL);
 	if (!rapl_pmus)
 		return -ENOMEM;
 
-- 
2.34.1


