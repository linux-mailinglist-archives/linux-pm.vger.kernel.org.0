Return-Path: <linux-pm+bounces-10973-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E7692E4B0
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2024 12:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CE4D280E4A
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2024 10:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B4715957E;
	Thu, 11 Jul 2024 10:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0lrLyAu3"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A787F15884B;
	Thu, 11 Jul 2024 10:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720693714; cv=fail; b=MVZqmzdhmrD6Jkj8PxFNOcieNfxdKkysYkAjWGB/vB9L7pyRZ8fYvCocml0hV7sBNBwUazyfBPehNPh30QY/RLxIx/S8Y3/+xynr8frD80YmOM1d6oh6VBtJiQtMxa2gitAHFVWN3CImZ/tFNmBnk2jHHSDuacRTsvGwAqslKus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720693714; c=relaxed/simple;
	bh=xTBlUvYaEIIIGYJV0fVDx9dMMuSyz4NabjTP1bAYJAo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E9C9cXNGE2AbOqzAQciG2V83V4awIVyxY8lVCVL8moj7zE20oo6o6oNDmbfSkX32/KwpXcKx+pn8ezMCYZkWwE5tS2WqSIH8E3uprrH6oN+abcGcrmtfUd77/11p/cCB+3r4jPciG2LO4A3JS7cvi+1TJ3l37tFU8A0o6aysmZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0lrLyAu3; arc=fail smtp.client-ip=40.107.243.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X5U+/bwqbtS4hmvcKTU1bVaMP7oEdD9GK3YSh3HIZ1LU45hO54yiI4e6eJfHShpZ/zreW7O0lRF9IOfSoGmBkM+ZpPHTog18ChUj/4yxAFisp52Ru7bAv+DDFz2vL/8izUVMsQRaoXdd+80qK8FZw1vtWqW+4fnuYG+YfG6i+M7xBbUXlvf3T4qvXhuKtCX2RpAEmfjkKieozu0gvE5sVEKF57zN/vA2b1DlO6xo5iYgoaL4dGb1PmftNYNNOW9LRS3CclLMZLlPfoV1wsQIFdVazL+8nHS374KCHAcQF8Hg4IPvWVzZMuopuUKo48Pfl7QPE8IIrTSeSnK3o6r3MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RIPhj8h4cQiIYc0jDEwV0VDQenk3gExjAwQTQlQcimk=;
 b=ipqK2vPym0wxfAihUOK6c5AJz2hLYxlnmrfwne2LWX+/ghulwZHFweGCadHCFzJ5XtCDyVJg6NP9ic5JYnVY3DjZxj90YACCmJzpJJ+U/Pfqg+vwYFAkjjnfnQnA05geJGWq57sJNSLK5ct7PhEaGJ7j8U/+jfypq1s2sSGLnYA5/Y1EnS8NAANYlZTmA6wyrSGLuhMPvLv5x9QNbNKxx8pCJgYqzKE5zjrQBUgQrjNDDS8OBKV5aahNlN5BipUHJWVlhOQEYe6TnbSfRco7jBuDOYy6yNR6rtWDinIIetJfDE0kUlIvwb+nhN/EVY950MR1dDKQ1mWwr0GPL49GOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RIPhj8h4cQiIYc0jDEwV0VDQenk3gExjAwQTQlQcimk=;
 b=0lrLyAu3GuxfGbw+SuPtXtyM7PtqSZo/MkX8EIlFPy673Chug+fQ045PB3T2nnVbSF8Sg2NQC8i0bRxqtSl1VjweOZ9eBauQDMLdBBAIX1v9EtGUXvIfgj3+5VKBMx4ljqD1amuFCXVUqIFW9EypIWQ+EP7/6qBOQGajwm9Nr+Y=
Received: from SA1PR02CA0011.namprd02.prod.outlook.com (2603:10b6:806:2cf::28)
 by SN7PR12MB8129.namprd12.prod.outlook.com (2603:10b6:806:323::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Thu, 11 Jul
 2024 10:28:27 +0000
Received: from SA2PEPF00003AEA.namprd02.prod.outlook.com
 (2603:10b6:806:2cf:cafe::d0) by SA1PR02CA0011.outlook.office365.com
 (2603:10b6:806:2cf::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.21 via Frontend
 Transport; Thu, 11 Jul 2024 10:28:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AEA.mail.protection.outlook.com (10.167.248.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Thu, 11 Jul 2024 10:28:26 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 11 Jul
 2024 05:28:18 -0500
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
Subject: [PATCH v4 03/11] perf/x86/rapl: Rename rapl_pmu variables
Date: Thu, 11 Jul 2024 10:24:31 +0000
Message-ID: <20240711102436.4432-4-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEA:EE_|SN7PR12MB8129:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fbcab8c-05f6-4653-1c96-08dca194337e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1l+Eho19HR5ArgE6EqX8t/9tB6leb09I2p44C3P9uTxEUJcErfwonbXizUH9?=
 =?us-ascii?Q?oXC+//5dK6za3tP8XRLwU1fhIfm64rVxvfj04lHBFXn7al+Dkg1H6XCPzsaC?=
 =?us-ascii?Q?rxqNEXZcVKG8TM2PVreLnhlzC9Dqz18dsJVQXkVqlH+qFwmfNZKeuuO3mp/K?=
 =?us-ascii?Q?4PCXMHLg0JvXN+ewuOsO+g6nOGrQ4f7XKr7l29+mz06zQjTRzbuQO1yJMZ6z?=
 =?us-ascii?Q?yCOoPe9dKqxGSSdav9OZ3RkXBA75UnmxMT7/SibRFhy0bkAEm0ioE/mrUNW7?=
 =?us-ascii?Q?+Q33l1B39pOV5fmhoHdZQTh6yAfDlA0oTkJ886p93AT3QBLpnOwbyO8Vv69Z?=
 =?us-ascii?Q?aLMwr/HliJu0j+xMkp4u2fPPETXKRlhoYzYHkVHni9MBCYqoF1ZghmK42kpw?=
 =?us-ascii?Q?0g+087rKA9MqQg+8R/5Bae0Mf/zLshMvBioYURp9fELNXzX5w6TmSSraB1fW?=
 =?us-ascii?Q?IF60iMoi16qD6MZ//K+EWr2FSN+GF1k1y68IdZ9UH1HVpSZi87NKAOfBtVKZ?=
 =?us-ascii?Q?q7kFjC18CPtpiVnCqSbAUbtyUdwe48C+dRzALL28EsoYjejoUCLbedjOIBss?=
 =?us-ascii?Q?BYT6W6A80E6MJrjuj2R2SWPccddbexR3VQurFQQ/Oo+g7oM6WaglJm9ed0Q+?=
 =?us-ascii?Q?0I+o4o7u2ZJOVy/TXXgAHMbGPPwIWzFX1+y5ESSsx2OrVayIXYeTFypd9OHJ?=
 =?us-ascii?Q?XOytJbNB/TH/nRjmu3X/GFnO7TqChVSvVYETTZfSyynnXrr9sRQlsfl+9BQr?=
 =?us-ascii?Q?ZnFGSY40o+hCGA+vXrJ1AroLeSNqB6KadfTYfNbYBAjdCfhdRJyVHyPD1Twl?=
 =?us-ascii?Q?3/XdlsOVSvK0AQPgxfZwbvlL2tkKT/izJNw0QIXG+ACYRqPzJXbtLkCGH8AP?=
 =?us-ascii?Q?VFaH1l5cJywNNfcbYnwuOrfwTTXrYY5lFviltULDY0eVhF2PU9YyHlT5grKw?=
 =?us-ascii?Q?bALofP1toeIAgSyScLV4YyuEUcFcBylWSVVW6eHVQqRjEQfYTyVYNJRAYCYL?=
 =?us-ascii?Q?LDB772G2fyriE5aLr50PdM29n/0gqfACZaIiPClJ2I8DM7KVkU3Vcg4qkG1Z?=
 =?us-ascii?Q?ArmwKc+EDXYXNAfigRVP97vR2YaTc9jnHKyepB/+34EQwwoheYvspSnEVPVO?=
 =?us-ascii?Q?dkF/CfEKbKcMr7InIwxWGlRpxQ6V8hc0Gbj8KInHxklGWQjErNe84HuXeX8+?=
 =?us-ascii?Q?0KvC7M/GMK4R3Bp/cpqsxOoMJQ8oLPR7HDqLI+7mPyugtofs1LPJjmggpBT0?=
 =?us-ascii?Q?03R3StPm0Ax8VgGj+0TXBNMxmgpeMJSxoRm05ATGno7UMg0n2CfxXC0qL/yL?=
 =?us-ascii?Q?J7A77t7LVwQ40HMw0Tov1htQFBR7fL57MWpRy6k1ol1S9czMNHcg0BLwesOg?=
 =?us-ascii?Q?bKWcpqXhkpWXXwz9Zn7MCzjCBnRsGsyVZkB9uq+0lZWZS9gRyHn1L+D5uh+C?=
 =?us-ascii?Q?UfoyhL3LxnVCRUkscMsP9R5jw7dk5rRZDuQn/xChyYdhxVcT4nsxuQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 10:28:26.9027
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fbcab8c-05f6-4653-1c96-08dca194337e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AEA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8129

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
index df71f38ad98d..e6162bd84f23 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -123,7 +123,7 @@ struct rapl_pmu {
 struct rapl_pmus {
 	struct pmu		pmu;
 	unsigned int		nr_rapl_pmu;
-	struct rapl_pmu		*pmus[] __counted_by(nr_rapl_pmu);
+	struct rapl_pmu		*rapl_pmu[] __counted_by(nr_rapl_pmu);
 };
 
 enum rapl_unit_quirk {
@@ -171,7 +171,7 @@ static inline struct rapl_pmu *cpu_to_rapl_pmu(unsigned int cpu)
 	 * The unsigned check also catches the '-1' return value for non
 	 * existent mappings in the topology map.
 	 */
-	return rapl_pmu_idx < rapl_pmus->nr_rapl_pmu ? rapl_pmus->pmus[rapl_pmu_idx] : NULL;
+	return rapl_pmu_idx < rapl_pmus->nr_rapl_pmu ? rapl_pmus->rapl_pmu[rapl_pmu_idx] : NULL;
 }
 
 static inline u64 rapl_read_counter(struct perf_event *event)
@@ -235,34 +235,34 @@ static void rapl_start_hrtimer(struct rapl_pmu *pmu)
 
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
@@ -270,39 +270,39 @@ static void __rapl_pmu_event_start(struct rapl_pmu *pmu,
 
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
 
@@ -320,23 +320,23 @@ static void rapl_pmu_event_stop(struct perf_event *event, int mode)
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
@@ -350,7 +350,7 @@ static int rapl_pmu_event_init(struct perf_event *event)
 {
 	u64 cfg = event->attr.config & RAPL_EVENT_MASK;
 	int bit, ret = 0;
-	struct rapl_pmu *pmu;
+	struct rapl_pmu *rapl_pmu;
 
 	/* only look at RAPL events */
 	if (event->attr.type != rapl_pmus->pmu.type)
@@ -380,11 +380,11 @@ static int rapl_pmu_event_init(struct perf_event *event)
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
@@ -567,22 +567,22 @@ static struct perf_msr amd_rapl_msrs[] = {
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
@@ -591,21 +591,21 @@ static int rapl_cpu_online(unsigned int cpu)
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
@@ -617,7 +617,7 @@ static int rapl_cpu_online(unsigned int cpu)
 		return 0;
 
 	cpumask_set_cpu(cpu, &rapl_cpu_mask);
-	pmu->cpu = cpu;
+	rapl_pmu->cpu = cpu;
 	return 0;
 }
 
@@ -686,7 +686,7 @@ static void cleanup_rapl_pmus(void)
 	int i;
 
 	for (i = 0; i < rapl_pmus->nr_rapl_pmu; i++)
-		kfree(rapl_pmus->pmus[i]);
+		kfree(rapl_pmus->rapl_pmu[i]);
 	kfree(rapl_pmus);
 }
 
@@ -706,7 +706,7 @@ static int __init init_rapl_pmus(void)
 	if (!rapl_pmu_is_pkg_scope())
 		nr_rapl_pmu *= topology_max_dies_per_package();
 
-	rapl_pmus = kzalloc(struct_size(rapl_pmus, pmus, nr_rapl_pmu), GFP_KERNEL);
+	rapl_pmus = kzalloc(struct_size(rapl_pmus, rapl_pmu, nr_rapl_pmu), GFP_KERNEL);
 	if (!rapl_pmus)
 		return -ENOMEM;
 
-- 
2.34.1


