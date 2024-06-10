Return-Path: <linux-pm+bounces-8856-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0563901EF7
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2024 12:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60954282168
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2024 10:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCBB768EE;
	Mon, 10 Jun 2024 10:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ib+um/LO"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D95D75813;
	Mon, 10 Jun 2024 10:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718014164; cv=fail; b=WFGdmQs2XjFqTVvRUI7GMKJ+sxtTuFQorPLA2I23sxCJYAgqb371KVxbXDMmhEpNAbW5SGkO32ny/cjMy8yp0rVLEf4acjA/M+yvMv8rAm/GbGP2LCRk6IvPUiPVy5PeJoK3NSubCmwX9InAESd471apkpdJTp+LAfU3pWhEpDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718014164; c=relaxed/simple;
	bh=bdHqtKQgt7guqR41b+qTLiClw9pcS6FtJ1Uis4RlDfw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=azkxb/bTYFBhqMr5DJf3xv4bHVPS3mofwEfZ/5npewBNRtgLvi5VhFwWVvJ3zZCH3+PNE9iWf1W79w8tLlcpIZNmbtoCRFxjq7SK7Nf7HGr4jsbgblunMc38hIfqJ8jHesJVNj+2hePLFHRQ/x2gIUaqbSApMEe5YhuL0oTtmi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ib+um/LO; arc=fail smtp.client-ip=40.107.236.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ltstr72i1nORz/Tb9y5utjanmr3k9hz0etY0JsxP/kFW80N2kqULjNbMrDfShknzVY1rkgiaxn/9uPHTqBuq5TkPNEhxJjW6ZPBIWMp96p0DBQJbct9Cy3lxvijJecKd9lEQJTKI+cmGkMnBiSeIklonixeHler3QAYjHTyJhHEnxgsorE5TL5D8KQwNR9TgMc3dtRBrevK/1EvF5sZ20mcRb+PA7bUm9vYGavT9DWQyNxWyfJvlN7L7/ieEgB1mzL8hw4YGVXMTpjRqQC/bnpPF+VP6qsqyw47B2n+ObcN2TYrARm6q60JzUFXg49qpyCg4lVjirWeU7Ede9hHOBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8NbjBZFGLCOQPKlMZfmrhLpqA0S8CIGooxpyooHDAQo=;
 b=LStBtHoXOqQKrrLnGr6lIw+V52cmVlX+FUqeeqFum3rlIWaEQL2uCs2RXuB9dJx6kj/nIEWZ2HpEGcxbnjdQ6302q5+BmV0wzziAoBGWeFM/enOzK86x12h9eWRD3h/mKeJU0UU6OPZKNXbDGrg2Ku3zC7ndzwDLyW2odpAhA2Y3F+qT2ojjoO7JRA6SLhnDui5vB+t2fLE4bKbahkpw6rNTi31ypjD+feh0MY1+mBxzY8VQswcSsZgWedVjqn5fRXyBZ4+0RgAMDJ2t4v7GJyBxU+i6DLhGB+5osA3T6uDeAz5uQzQKzXhwMllMSm1hxHiz4iabggZtlewyPja1hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8NbjBZFGLCOQPKlMZfmrhLpqA0S8CIGooxpyooHDAQo=;
 b=ib+um/LOuUFIDWeoZFfxsFLAAkoMs6FPDQw/f+T+TxZwxTKlrV6MnNDO5RUKTvhhxOdBaB9Vaalhm0GO4gMA3ocxocNawrbPwTWAbvJK1Feotp7HYz0P+0svKAW64JEfZvr+yCcnfEVClKARKJrpqu8odNJnWQnr03kedMKtjhk=
Received: from PH0PR07CA0010.namprd07.prod.outlook.com (2603:10b6:510:5::15)
 by DM6PR12MB4044.namprd12.prod.outlook.com (2603:10b6:5:21d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 10:09:17 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:510:5:cafe::fc) by PH0PR07CA0010.outlook.office365.com
 (2603:10b6:510:5::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.23 via Frontend
 Transport; Mon, 10 Jun 2024 10:09:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 10 Jun 2024 10:09:16 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Jun
 2024 05:09:09 -0500
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
Subject: [PATCH 2/6] perf/x86/rapl: Rename rapl_pmu variables
Date: Mon, 10 Jun 2024 10:07:47 +0000
Message-ID: <20240610100751.4855-3-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|DM6PR12MB4044:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ffa9faf-ad6d-4fc9-8694-08dc89356310
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|1800799015|376005|82310400017|7416005|921011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KlrfbBgYdtPqH+eLfD2aKq6GqFauGkZHvOp4OkRnGeezCmp+Kp18HbYYlrEp?=
 =?us-ascii?Q?l8fX5wGUlaIRxjvbbbw+mE6AVHHAvSQFdpfbRnIiMVqN15LcbM0grctbfB7P?=
 =?us-ascii?Q?cDY+nwZhYOyjZnJWyQX6vwgwDZpJlBu+NmqTgxBh6+VxAFsLlhQNvDARKxdY?=
 =?us-ascii?Q?IVZyK/Pp1nGs5hMkKZRgB7Fs05J4KPtVbzz2mRAYoLjkNcal+mxLhFeoE4rH?=
 =?us-ascii?Q?3NO9NUY8BUHjsz2w/mke/InDbPhXBTx6ujvOtzbpBXH4UmD3CQ0mGNXeAMTd?=
 =?us-ascii?Q?8tDsso+Bj1Lj3CelG3q3JPObTqC+OLN0lA07qxQkKjBteTL/FrUtsnGTTsGf?=
 =?us-ascii?Q?9ixpoZ1lugY2AzBNizbwXDhMg9lcYbhmMFm/lcOkiW82c47G0DWjtowaKQp3?=
 =?us-ascii?Q?m3io9mQMgvEUg5qfZAAXev/uxy4C6iYmrNmG/8Jqu/35E350GJKF9sizZXj2?=
 =?us-ascii?Q?mA02fpMdUo6yDeCuXrg2nBXRaR6cXP5oBnWFHHpryegY0AsNj624sbopgfrB?=
 =?us-ascii?Q?LyTrhQuVnBUUB+GhAUrH/dHJqwGhju7sX5V2RaghapmWlO7cEyVBIpj97iKt?=
 =?us-ascii?Q?ch0BdWXx5+g0XLKlK1YB5io/P6qheO7wapaxB2zhCvksGoXD0AycU+0Zs3ub?=
 =?us-ascii?Q?BylUqCFmS0ldJp/oNAT1pCUdGRRyW3ub7/i5gdfwkwK40xCWcuLmBDh0qXsp?=
 =?us-ascii?Q?w0tBE7Dv+K9giQOVXoXEBm8cQvemZJCljpoRYqkXmDx5Ldxx5c3uGjwJITxp?=
 =?us-ascii?Q?EWHEIN6KI03oupUqidODXBb0hUWy3CAzc5JqSLu8bO5ADpnht1/wtH6L92Zh?=
 =?us-ascii?Q?2uNC+sP88w50nKSZMt+n6bbmzJV29+CX4HqZjZWo0HRhtys7vJFKqJwXe7sn?=
 =?us-ascii?Q?Rl1tPoR6Sscjq0FNwptol5pp/H0jX9Tom1mH8ByPcSP7GkJ5GlZD0OCR7ed1?=
 =?us-ascii?Q?5tfXrOYr1xydt50NJkIi2Ctqw9AUBStiI7QzTl93Mja3LeT30uvX/m0YqSrn?=
 =?us-ascii?Q?qh2S43rVUVzOaSfb+yR6zr50OkgPGbVdfQPA91HRbX4ITfPCAkqoqCYGkgSK?=
 =?us-ascii?Q?ZfonEJO+D/p6SzXrqbuteYSYEkm6XRDwBaWSh4ppfLZAxEvxU4jehW0tVJwK?=
 =?us-ascii?Q?zo859vsWlVxZSg6fYLbbtI+Q/KuaMW7JJOgvlNdNsYs4vNQWNcIkv/UWmAbb?=
 =?us-ascii?Q?myqjTckT/kW3VqSXRTt9041M6LIMiPDZSF40EgU8lW6rwOgmEKw6OKpgecW+?=
 =?us-ascii?Q?vsQvVRm4Ana+9dUHFyJksKYRaJK4NJxy90yW6Y3pSe65DEc+QAcS0KnDaMOr?=
 =?us-ascii?Q?DIPv4j8gEuRY5cx9Z9H3MShm3myev6coShRW3agjaowdwW/tmGvoQl5+JL1A?=
 =?us-ascii?Q?o7r5qRNm3PtKaY02hmrgHvN3SbqvMxjoWIhJWVFoc0Dg7sdG8MzV2gmutVS9?=
 =?us-ascii?Q?h8wD84L1HQI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(376005)(82310400017)(7416005)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 10:09:16.6817
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ffa9faf-ad6d-4fc9-8694-08dc89356310
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4044

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


