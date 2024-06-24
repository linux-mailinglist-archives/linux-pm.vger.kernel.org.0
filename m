Return-Path: <linux-pm+bounces-9869-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E59B914266
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 08:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A55EB1F230A6
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 06:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A241C68D;
	Mon, 24 Jun 2024 06:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SV5h/ffx"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB342564;
	Mon, 24 Jun 2024 06:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719208883; cv=fail; b=MRDiZVBYHZ0K6jI7EvxcZJtdXG+P+Pr8cg8liu6uOKajektBU488ozs/lFHUzXgVVCkMWaF6GOqIyVmQBULn5ZIsWfPFk7mAnRKUv8Lidf9vfCiRdk6pB/iEwpbBSVJet3ygpgXZvsrdiwrT00fYE/bKL3tqDdgDmTtvzr1hlyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719208883; c=relaxed/simple;
	bh=bdHqtKQgt7guqR41b+qTLiClw9pcS6FtJ1Uis4RlDfw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Aq4MHLnO/pd+jxD66NAJ41mvxicLLATAvWgNdGsxTjerj23urJ3aFLSxdw+hi+r9CHFWr2Xznv4HfHVJ3W+e7LugHHJsMqEhgvwWMMT5sGnKty4/rDRTDzibhlRIiDQbnLwHDbCnEK+1q0i2TkzWH8HQ59ChMMJlO9UivfNa/sI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SV5h/ffx; arc=fail smtp.client-ip=40.107.220.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N6rj1EOU2plF/Yjx/iGdWsnsbDq5UOtSyaOr9SOlc2gfnmCfDXVN6b9ZnHpuYBWGrf6YGNp5Nu58kIWPnDsTJoFf4+XdXS2JJ6kKp7RweS5Bblh8nBo0/GlXKjoIHvOCpUS2FsZs7bspsRp+rQAEybdYBMgn4EeGQTgcNlsQzpZTokKJznEwYOOB1KWsl940qeQDYKnCNcsk7DuMdzgc1VbbEWT2xWJ7lPIEMoaiLTW5f3l5gMd53HAdlbSIzr5h3ZWBObmuVrgnKB41j3Vhj7Nv9WNb+uH1J7N7pC48hB2QR+q6bYiWfBAk8/tjcZara4CTBpkof76gmvnKyT+5jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8NbjBZFGLCOQPKlMZfmrhLpqA0S8CIGooxpyooHDAQo=;
 b=XnOMQCxf+Mp6u16chhh1NApl+43C9alP458YEwAVbwaYD5X3xZTwdpd8RS7lSzxsZrZ9qaXIyYsDfapbgu11+OlSY9QRwPj3kmWAcCTmAzrL9v0U0SZWARxEr1w6sgre7o1PDhyxXFLD5seZZSA6/ybag14Lxkvt4ao7VYAGgAQqS2CPQ0+cfdoUmjydzt5Wh6FgtYAJJcIXM7rtIk7FZD5SH1Mr/1loOZ1T8mMqUDGve4YG/haqzG5ByDOIfooCdSACjZeWF4xw7EQnvoDTztcAVcjrB9bXC7pEK8Vkxx9Co2cdY3+C/DO6VBr0DY8sGe+lSfdAq11stukn0f+9QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8NbjBZFGLCOQPKlMZfmrhLpqA0S8CIGooxpyooHDAQo=;
 b=SV5h/ffx1iK4Ll+/aVqudI3Ma8Kw0pVcgSEQribCUFD6Yi/41jyrOeO8J+nBJuiWj3/TVUWhKzMDYE2bm7CoxAkP5BjZcHnXQ/IQYes3kPrXH64Qym4RGHRrqM3xddb0us5TZuYSr+YRtVViO7pQpawChqcF/7tlQFa4698yvj4=
Received: from CH2PR15CA0030.namprd15.prod.outlook.com (2603:10b6:610:51::40)
 by MN0PR12MB6200.namprd12.prod.outlook.com (2603:10b6:208:3c3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.26; Mon, 24 Jun
 2024 06:01:18 +0000
Received: from CH3PEPF0000000B.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::19) by CH2PR15CA0030.outlook.office365.com
 (2603:10b6:610:51::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Mon, 24 Jun 2024 06:01:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000B.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 24 Jun 2024 06:01:18 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Jun
 2024 01:01:10 -0500
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
Subject: [PATCH v3 03/10] perf/x86/rapl: Rename rapl_pmu variables
Date: Mon, 24 Jun 2024 05:59:00 +0000
Message-ID: <20240624055907.7720-4-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000B:EE_|MN0PR12MB6200:EE_
X-MS-Office365-Filtering-Correlation-Id: b37d6e51-21d0-4470-dab6-08dc9413107e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|7416011|82310400023|1800799021|921017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2QWBAiabiSrmGg+H09U76gb+F6TqNKwJqUccVc10bONbaPETT4lUz+r0Qt+v?=
 =?us-ascii?Q?IBSmThdjAZ3QmSBPPu+secxdzHekMKXOT24ibEA3ms6tmfJsEP1dz7//yBeM?=
 =?us-ascii?Q?BF8rO9IwRlJqxxFBc5xYl956qn9pnrq/DSEyxwlSr1FfGgghHoHPqf5d3Ho1?=
 =?us-ascii?Q?H734jYP0x7DQsVaydFFirUBAPNnmAQIiLIN0xkE2A/a4+R2McRTEjbgAuQXJ?=
 =?us-ascii?Q?7+UvzuXOElQmNmCQQz0qKV02Kwdd5NVR0wYlNiYfWwN98qs4gElzDxUTqTsi?=
 =?us-ascii?Q?CzraNwlNriTm9en/2wwt+tfGSlVwbz2/8uy44BweKHMGdLBePXdRGfwWPypl?=
 =?us-ascii?Q?7gbLrnOaQJFFCg8Xtc4fCkzb1E0CxKXmHOsUJWfL1VaggUFTQCi7p9/IuuDV?=
 =?us-ascii?Q?3C4SKWHVET0ON/5mQiz0+d1c/zGaUk7vOxq9QlDAiorqITZYmbghV+wok4aN?=
 =?us-ascii?Q?0XwNgAF4RuRL9gIQpKjgUvZ2uFC33viDil6SCTlBlpgb2EOuvRqLG9LMybEt?=
 =?us-ascii?Q?8WheccRFEXPk53pQZKH9OTwsr+REaotviY4OM+WXtZwR6EuxjA4kYxCnvjr6?=
 =?us-ascii?Q?ljqnr8L2jChUbBFTWn0HiUrNJ55x6DAWTK+quGCcSKlE9iWwzajagrUsx1FB?=
 =?us-ascii?Q?cOmwtuZEe/jfYWNCETQJv1QUAvY4g2i7P6G7MZYXveVD2ewEEwHcoj7lXa1L?=
 =?us-ascii?Q?Bf9eJHO3l4tlDpAkULe+j73jP8MpLvpUEgHXoLxcX8BPEsmWnAjYYs+Vnyre?=
 =?us-ascii?Q?KXbof58QR8KlHTxtqxibav/O/Nh6E/rZnAUyZcy4nt0JVZACE19Si+BgcBf1?=
 =?us-ascii?Q?jegTlkVllANFo5hNsHOssh4tB1eTsk50mAASP+gFIx/UQzFgLhleOJXLPZ/g?=
 =?us-ascii?Q?QubBDnkwVL3gE6GX2scz+xIS9FVUzZYhQoPiRGWnlqmvaycbHAWMq/7j5NGw?=
 =?us-ascii?Q?7NIAd4mrmuTjF5eaPE2xWutxs/rCr23W+8tth86o9F/kbFVq4VB4Ks7YV1oM?=
 =?us-ascii?Q?jDWx2xAcDkfYMLQh8CBi5Rl7WoICKdPEw6Gsg5jGe2Gr4X90z/JiXli4PlUw?=
 =?us-ascii?Q?3zmI3jr43lxxE6ws+/mAcLRJcLF42RffOlhb2Si2PY0ifuTtLjmXRXFDLLzT?=
 =?us-ascii?Q?9NcFZUcGhWKYCYIUhwVE12GqZk+SURXqqr3mUvo+qAi/XowsohU0GMqXm9br?=
 =?us-ascii?Q?CGFXcewSmh88evTpuCvAZRrPFETaIKNNTCJ8SEIbSPr6rkLHMq/cFOu1xk3n?=
 =?us-ascii?Q?wZQjiRTttqGDL+cgV1YNYzWdysHKCM8JTWpVEoGhHNXKhTxTVhiO3vqd1vaF?=
 =?us-ascii?Q?j46GHfs5gkAadgFVmJlFBWdLllGX/We4efIxS+EXkKXAEe257oc7ZpzUwGAE?=
 =?us-ascii?Q?CugBLhuPafQNIWJnKDtEqTAi0P5unl0Hn0dUy4xDM2EQK38lDe33flzwunJu?=
 =?us-ascii?Q?I4cMWmUpTAw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(376011)(7416011)(82310400023)(1800799021)(921017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 06:01:18.1024
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b37d6e51-21d0-4470-dab6-08dc9413107e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6200

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


