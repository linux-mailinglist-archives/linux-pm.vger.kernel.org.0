Return-Path: <linux-pm+bounces-9870-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3EFC914268
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 08:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 571AC285048
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 06:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43231CFBC;
	Mon, 24 Jun 2024 06:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eJnXCciI"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2041.outbound.protection.outlook.com [40.107.95.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FBB1CD25;
	Mon, 24 Jun 2024 06:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719208901; cv=fail; b=Q5pWf/zk9/qg4rpH3xFbPjv2dNHOYYyKn4f8lrajhzgiSo9cUObXcELIvyuKK/xoZd34a8IpO4ErRDWwCzJtRcp4GrIrppl/s1GHXwjqPPOX5sF/45E/Ggc58LwznuyplbcHnavHPPMYJ2Io/EtchWYQwvWrFYIqx7IbPcAOKyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719208901; c=relaxed/simple;
	bh=Gk0eDrWkM4+6BcmWgg9Zn5wMFoL1/BiV+SJ4lOA/JBg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N4qPMF3feDUiIew9TUHJx4f42UpToReRGyndHA6YPxIwZX2LZRxY7uhoCLWWvVYuYpiSk3aT9+B56ldzDS3Whlzes6xYOZHQAm5BplNvrG+3Q9lWoy5b92yjhKuyzzbDmLN8n6OOIhcrTV9a1rb8CKDFGjFOodRB6cnbAVmcqYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eJnXCciI; arc=fail smtp.client-ip=40.107.95.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M9mPUcSSbKrF35GEWXWxjiM+8gCQBSb2MpDNTV+LrbPyTo2ks0cDNVVhNaMqPp1gA1gUR8z22v4ScfA9dqrmw2c0m4nTwEOfqKDHhdSTATHh06BleXWcwwLfRIZpMOSC4xc7MKoeSmib0FbxxGEhABtqwgavGy++GCbRWLcy7HqHztU6T5gT6wWO9HeiKAzemNzm2Vae5DgEwja/N2o0sl4nGguM0sBcG4D5a/htnYm8Oc7st9DAxF2r5bIN9Gbmzs5bB+Y+LRimdCG4wBOwugtODqiA901b3t+YbufDjZiLS53BKJ0qR+htek1FpYFHDN28V5XTtiKMZl40KxKRaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3XxBOYQHTq6+VWT/1eEZw5vU3Ql+de6j2SbkY2U/TVY=;
 b=FqD26qMyvtfPg8B+3JE9k/nPd9MQvi4MF4hsNBBiSa3gsZ4MnsWiPMvsR5v/Za95kaZZYghNy85DF85Qc1JBA5Btq06t/QmZvvEZyzlnlCXPGYkq3Ar0UefobmkBbzXaSnDODUzmrMMH85Qg1YxY8r7rcXtOnXDsZEgK+goaQcjtin796RFfiTSZk2SXAEf2TzuPRUeqSKsAanL9WnybY70Jk2qSxi+HsEFkYTNDCz/MAbKQCXjArd+s2Z3oE1+UKGE86eSf7pw8Kpi6OmW27fD308W6WchzQ0apdbG16x5FK8EYJEerFC5s53KrZUJjiFzSX+nGLiw49Yh1k6hcdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3XxBOYQHTq6+VWT/1eEZw5vU3Ql+de6j2SbkY2U/TVY=;
 b=eJnXCciIkWI1YghZkUZPVmrkplg+hsdiZnk9yYCiH9eHhwbjiWYHai1Vl2EpetqrYl8FtfptfQuv6Lio/4UA1jddrZPHJiEMHHjMyKuXJRRwrVb/ulQX1DoZlO59GEvYB3X2mHsAXhQmPPqtgEH6l3G2Vba4GzVw7dXoWtYA5QU=
Received: from BN0PR04CA0164.namprd04.prod.outlook.com (2603:10b6:408:eb::19)
 by IA0PR12MB7723.namprd12.prod.outlook.com (2603:10b6:208:431::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Mon, 24 Jun
 2024 06:01:37 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:408:eb:cafe::c8) by BN0PR04CA0164.outlook.office365.com
 (2603:10b6:408:eb::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Mon, 24 Jun 2024 06:01:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.0 via Frontend Transport; Mon, 24 Jun 2024 06:01:37 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Jun
 2024 01:01:29 -0500
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
Subject: [PATCH v3 04/10] perf/x86/rapl: Make rapl_model struct global
Date: Mon, 24 Jun 2024 05:59:01 +0000
Message-ID: <20240624055907.7720-5-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|IA0PR12MB7723:EE_
X-MS-Office365-Filtering-Correlation-Id: 44c6fc9b-4649-423a-95b4-08dc94131bde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|7416011|376011|1800799021|36860700010|82310400023|921017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FC2VbGH4dfcGUrpBV3EwxwrcMuAp+2db16jUrA7LSmhpd3JvEqSdcpXJ3su3?=
 =?us-ascii?Q?idyWLqq3yMAkEBvxFRuom9GZlGL73yeNSQ3S1pVozTza4hHgXUPjggfqwFan?=
 =?us-ascii?Q?Mf6K7h7aLL8+poKhrYq/ceWCHJOJF24ZEqslFHT5lsHfQActhKGWdXnTdzJU?=
 =?us-ascii?Q?09ABwyfyLwJVCwg02fGd2OMjm1odUoE527w1OYZi1ZT5cnVy2D9o8PXz2hBP?=
 =?us-ascii?Q?t5WX6ZWPMsaFT2c/ZH87TPPPNyNPrZAqLqof1/fkpsR+x23gjZy3riSo49Iz?=
 =?us-ascii?Q?JupDgWSRS9wK1cul7O1W7wXtMZPJZx8L9Fg9WbtKCljpo1dm/fe17cZ6Svha?=
 =?us-ascii?Q?j04QYQ0cPXNez4RXXwFwd4yB4zKqz4gSA1gRBuXJWXNtwawlJywTRW3Pa2fB?=
 =?us-ascii?Q?n/FF1GOmJyxm18hGVKJXfAUez5fmJFU+TVevhwNGnvFzOrnZGcepWNXR1Spn?=
 =?us-ascii?Q?Q7iw8AKAf+A4Xg+y2XPsMAHfoh8srZpmju2otH858w/I0svKXHDD+MCWJPJU?=
 =?us-ascii?Q?3r3CdMpXCydGpOlnwf8de4pP+li5TbUnoPjA1eaKJyiEv9yiQRy6G3GRc7CP?=
 =?us-ascii?Q?vJwDWPVwS0dKYjNTWed/umdmrNAEG3AV3uoiGKnDoLjMNJn2XhltDjYxhKW0?=
 =?us-ascii?Q?YETy85C4xCAgbVlCw+hjNTN29nfZGxA3XvNizSheGoyQUvyyWCiieXjERuTh?=
 =?us-ascii?Q?8L9+jH5NSapeVHxDb1w3DrJLemHezzfvv8Oz1pprVaiaN+lOtv7PMJqur1Dv?=
 =?us-ascii?Q?xyr5XxO+nFMYPo0ocdesBS0ICLEs2R+0BGq6hsFx4qWe7rJ46MUddnoKTzBc?=
 =?us-ascii?Q?x2vh6C76u6igqQJqBtVGwgxbYfbxhjL4k+2a2UgX04QMFfXH7Ra0XtujHFJ9?=
 =?us-ascii?Q?HySsj0Zyu1dxdxU158pf41MkPMuc/+UdVpyvrM6izs8Lovo4vBlQEYFL2j1x?=
 =?us-ascii?Q?9uUf7TBKD42tFQIOeTrFiWD8SHN0b8pnanT+PFS6FLXuuaN7rFJ0QaFH51jE?=
 =?us-ascii?Q?cqj62tlOGFuI5BCSVl8xnmYmmIbYt82WN592nImnLgJo/uKvZkyda/8vZvIx?=
 =?us-ascii?Q?Cf+6AfLDN3LNzJ2dL+9mTc4tG3/UAyZOzidSPV0HguzQaFq0Bnis68QddOza?=
 =?us-ascii?Q?fumUjS9iIiEKa9NXxQIfdAVJ/MKnRhS7JyiFiHdUJ6PLLRKXNk3R5gXRNKHh?=
 =?us-ascii?Q?k3+2ujk26acpla6w7bBkP05ITillZCvf7vfBbbwp629v/B7meeyqixgEf+Vs?=
 =?us-ascii?Q?snylXIS2V3R463KDr0GBYMCaB1bNSqhGNSezsKVKaaBeTW4XK3Cztz3P1hLa?=
 =?us-ascii?Q?xhu7Tdc6BjDv1qZ6OSf0cpFDMsKOKWhz1GW3JK4h+qRC1U8ilMvhUQR6h+lI?=
 =?us-ascii?Q?D8nNzPOuiY5ScxdhHzA0rh42JS++MXoEbpIj24PMTQILZXldb0Oo54x7R/Gf?=
 =?us-ascii?Q?lSkH3L/qFEA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(7416011)(376011)(1800799021)(36860700010)(82310400023)(921017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 06:01:37.1848
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44c6fc9b-4649-423a-95b4-08dc94131bde
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7723

To support AMD's per_core RAPL counter, we will need to check
per_core capability of the current rapl_model multiple times in
rapl_cpu_online/offline, init_rapl_pmus functions, so cache the
matched rapl model in a global variable, to avoid calling
x86_match_cpu() multiple times.

No functional change.

Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
---
 arch/x86/events/rapl.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index b4e2073a178e..e5e878146542 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -143,6 +143,7 @@ static cpumask_t rapl_cpu_mask;
 static unsigned int rapl_cntr_mask;
 static u64 rapl_timer_ms;
 static struct perf_msr *rapl_msrs;
+static struct rapl_model *rapl_model;
 
 static inline unsigned int get_rapl_pmu_idx(int cpu)
 {
@@ -614,18 +615,18 @@ static int rapl_cpu_online(unsigned int cpu)
 	return 0;
 }
 
-static int rapl_check_hw_unit(struct rapl_model *rm)
+static int rapl_check_hw_unit(void)
 {
 	u64 msr_rapl_power_unit_bits;
 	int i;
 
 	/* protect rdmsrl() to handle virtualization */
-	if (rdmsrl_safe(rm->msr_power_unit, &msr_rapl_power_unit_bits))
+	if (rdmsrl_safe(rapl_model->msr_power_unit, &msr_rapl_power_unit_bits))
 		return -1;
 	for (i = 0; i < NR_RAPL_DOMAINS; i++)
 		rapl_hw_unit[i] = (msr_rapl_power_unit_bits >> 8) & 0x1FULL;
 
-	switch (rm->unit_quirk) {
+	switch (rapl_model->unit_quirk) {
 	/*
 	 * DRAM domain on HSW server and KNL has fixed energy unit which can be
 	 * different than the unit from power unit MSR. See
@@ -839,21 +840,20 @@ MODULE_DEVICE_TABLE(x86cpu, rapl_model_match);
 static int __init rapl_pmu_init(void)
 {
 	const struct x86_cpu_id *id;
-	struct rapl_model *rm;
 	int ret;
 
 	id = x86_match_cpu(rapl_model_match);
 	if (!id)
 		return -ENODEV;
 
-	rm = (struct rapl_model *) id->driver_data;
+	rapl_model = (struct rapl_model *) id->driver_data;
 
-	rapl_msrs = rm->rapl_msrs;
+	rapl_msrs = rapl_model->rapl_msrs;
 
 	rapl_cntr_mask = perf_msr_probe(rapl_msrs, PERF_RAPL_MAX,
-					false, (void *) &rm->events);
+					false, (void *) &rapl_model->events);
 
-	ret = rapl_check_hw_unit(rm);
+	ret = rapl_check_hw_unit();
 	if (ret)
 		return ret;
 
-- 
2.34.1


