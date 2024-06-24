Return-Path: <linux-pm+bounces-9873-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D91A591426E
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 08:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63A241F248BA
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 06:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0281CF83;
	Mon, 24 Jun 2024 06:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kghfV2KW"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58021C695;
	Mon, 24 Jun 2024 06:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719208961; cv=fail; b=fwEJALt2BI1SKYfyXbp7wCMUSrSR0nY1LW2+XBLuR905Jezkii+8aj11M1/FfEX0H16YVtDJmujnbjUJRqVYgLSzpqk/C/hxNmlh1/EYhxkEo1S+gD6bO3YUlAC8IMXVOgZZzw/TnP3zWPQ3CxJcCaGnjfIMKJm+Jx9U6heYu44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719208961; c=relaxed/simple;
	bh=SevruLCexV627iM6Dl8XSaoopRtrEYLT3wp2+/RPnLw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nUqgCyhinf4EaZE1MXKGKVgs3DQgjjEmu4hTmvTVSGcZBjdaZONDmKe8cIEYhihg4hlBa/W32xWfipdqrhsbQwoyV1bQ1pP8y2m/vPUN5snzHdRmXipvThoHD+FsRQYWjqAxvW/S+/gvZzf1PyUsH2SiXbJ7/fCsTzmM3WzzYpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kghfV2KW; arc=fail smtp.client-ip=40.107.92.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jbFtKq67JlJ3act7Bxowf0UK1jIN8Hbk3dqX2Jw3MK/Bg1ljO8W6qQaTLLmoeX0jU1/IU/oWT20ArGAncHAyzvLq3Jlkg435pb2xU4BusRnaBEVoNCuioTCy8bxHrVEAJ2A3tNhjlxtSZn76vej7krBMRdhzTMoWFK15LS/NGp9bKt4UT0yCvLDAGnCyYCgYDVheJtAFTZutU9dTjzDi5XTsVG+ZHUOqFz1qQdR2rzNnQu55+6jwPJjfX2t3deJWAI/UCsYO90O2mLssBrdDeYT0A8u+uTAWSA5Te4jep/fNu1A4cZRR3x14RgqAO8HV4SEKnBlvNdy3e6PPeqmrPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ecZ6mfsQyMQekhKSwNggBHbozRpNVr37hIhIwLMyQH0=;
 b=oAiJwpAQ6VVSAhd7qnR/hKjyMNjorlr1qgB5xG9dOWEC25WNLq8vCjhvt2H7OF+wI6Zn48DliNUaHhvv+NWNvm6mj4/D4HPRLaiWxpF6txmjU1RMyNa9rQ3jYKPtM5/pAAmmXyNAgIAvRYdDJDzlEwYpcQR6WdAHYJ2PfaXxjdg217IEo8/o1SegH2aZymtrFf1mXjC6edHR2SJe4PO2dDxJf61cLMR8VR+TH1U6na1/8Tq6mNH8cRZ0rB/q/XBVfqVqor1Ytb4OyHC/UVhIKtssSQwYyFngDv5YJNLNbDUIueXLt6mXNzUvp73wUcs34s7/vTHWeSImwU7ZaWmgSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ecZ6mfsQyMQekhKSwNggBHbozRpNVr37hIhIwLMyQH0=;
 b=kghfV2KWFFFuNtLGGghqyptJhsavmq1sDbWQdQIQkUvWb1ihRrt98/51u2ubNawHKtHBBxtub4CBNJynifNUGaUn5ln/jZw0NPBIJ58VWjm36Z9pIHT3ecUs+w9ePd4oOtYb7c5N1HRar7mGXWVR3uPKAJgStUXgb1jmOdNIe4E=
Received: from BN1PR10CA0003.namprd10.prod.outlook.com (2603:10b6:408:e0::8)
 by SN7PR12MB7980.namprd12.prod.outlook.com (2603:10b6:806:341::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Mon, 24 Jun
 2024 06:02:37 +0000
Received: from BN2PEPF000055DE.namprd21.prod.outlook.com
 (2603:10b6:408:e0:cafe::a8) by BN1PR10CA0003.outlook.office365.com
 (2603:10b6:408:e0::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Mon, 24 Jun 2024 06:02:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DE.mail.protection.outlook.com (10.167.245.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.0 via Frontend Transport; Mon, 24 Jun 2024 06:02:36 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Jun
 2024 01:02:29 -0500
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
Subject: [PATCH v3 07/10] perf/x86/rapl: Add an argument to the cleanup and init functions
Date: Mon, 24 Jun 2024 05:59:04 +0000
Message-ID: <20240624055907.7720-8-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DE:EE_|SN7PR12MB7980:EE_
X-MS-Office365-Filtering-Correlation-Id: ee6d0b4a-9821-40bf-a6de-08dc94133f6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|7416011|376011|36860700010|82310400023|1800799021|921017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Cbp9syXuAZfYy3b4Dh6APwqy+yBljUBmXeR7Had6xccqhOpUNpcgS5TpFb7Z?=
 =?us-ascii?Q?7aiUIPe8rCb5/rkUFdrtEYHc89hRx6q02hNE68AEHJKpfivRhdDwho69TMGS?=
 =?us-ascii?Q?bnk1gy8U3Elm4lTImHXxZ3/fFjApRc78fdlEF616NrGFeXdKn8vWvpz4e+Jf?=
 =?us-ascii?Q?czoe/aeZIr08ly6ueCw0iKAsR3GWFIH46GJ8VCUCHSPODmH3wm8kfANzzodA?=
 =?us-ascii?Q?AhsTN+zKMonYh2w5dHjBC5CPPEctMTLz6rYFdcZrUXYBXRFgMX4wlKDtvtRo?=
 =?us-ascii?Q?ddq98tfzItpUOQJQ/f7M0o6tCMLmH92fkjxJTffn/DPVUX4ArN790ggzG9VF?=
 =?us-ascii?Q?rZTMB6At1W3g8pMYJ0X4qD4DsavQp3T8mCdr8OhXrpsHpqB5kGVCO8dxN4hh?=
 =?us-ascii?Q?IIB4hhnDTsNhStoifrIIrJvE98PU4+MBlNHndDZ5cOZ6cm1LpaVB3qIiUnqr?=
 =?us-ascii?Q?qS0Frfs9Lsaa0rqIikFVTdZK4wz+SgtvN3ytTrmiihglXo02VnkkzEPkQaLj?=
 =?us-ascii?Q?ocKCbhrWuOXVzwgtqf1dTOx0iaNmmKDpx8G9TILoRtYWw+T3u9yTdsXj98xz?=
 =?us-ascii?Q?0QlXyfL7H2ELkflXDIxviEQyHnsTBbZiHePd1bnoglDCpC5j+X/RklAggRTg?=
 =?us-ascii?Q?+ASsVX+NT5TdcsfSKWjJRoF1Eb5zruooQelFh3K60N9pGVqL6dNTjziV2o1S?=
 =?us-ascii?Q?VCqDgUVt/n4rwbuzcR9oMQhTJzEUxMQ+5b06E+P+FQz+Mnb6h8EuAfS13pzs?=
 =?us-ascii?Q?/sdWofaIZ7zqSmDgMXV3ScaJQL/oPfn1qgl7fCC3S2gvonWDBXCFxuclaLcX?=
 =?us-ascii?Q?v/ZPNejuYqqEYe0L0Y/i9LkmYdJfSlB1GLBgnrDlUwudenPnSO9ukw+c3ns3?=
 =?us-ascii?Q?ucGU+HsRcBf+rsz12vGj0UahbqkAglr7mxNzWC1o+N/cmxlGMf1OnP23ZINY?=
 =?us-ascii?Q?uGmoxCVy4EUho1ZTWJUV1oBa5vCHesFqj6psf7CmmNeb9+G4JHLo2t1TiY08?=
 =?us-ascii?Q?idIVAbFx/JJ91HE+myugxZCNas2sJgD5a17jBvJGQ5oaEmH9E+sILa+QGIwN?=
 =?us-ascii?Q?1ca8AKi5aXkHqgyxQ2KYR7LHKhJ9zriyn+65FoBCOGC3za/vffEJHGP9FEAO?=
 =?us-ascii?Q?oZz9zLfOp+dzn7dYQNwNAJtj5uZtrRViID4iu/CpN0OUFYmggyeCDn8gpd74?=
 =?us-ascii?Q?Zt6xfU8KHHAgKfxsh/djpeFjmeCXSqIsgeMUmh65B17EZrMbpVw3B8ZYtENc?=
 =?us-ascii?Q?dyBD0PcBYIIk0Iu9lXzJE4rnd7SO4nQygYCrw2Uu8STfCpWz2u3P0bk5SSTg?=
 =?us-ascii?Q?SvwO6UU3m3fvt4ri+8HDSte+ZVk8LrVoFNDUYVMYewom/rguwllqhpOxUE1J?=
 =?us-ascii?Q?H0f76pUuKi+Sc6PdluLZ5hpSvRaIxpUKZPLTE11TuuxU7o2S2bF0wgsPA5x/?=
 =?us-ascii?Q?pdh2v93Wfgg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(7416011)(376011)(36860700010)(82310400023)(1800799021)(921017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 06:02:36.8295
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee6d0b4a-9821-40bf-a6de-08dc94133f6b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DE.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7980

Prep for per-core RAPL PMU addition.

No functional change.

Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
---
 arch/x86/events/rapl.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 70c7b35fb4d2..f815c60ec551 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -687,7 +687,7 @@ static void __init rapl_advertise(void)
 	}
 }
 
-static void cleanup_rapl_pmus(void)
+static void cleanup_rapl_pmus(struct rapl_pmus *rapl_pmus)
 {
 	int i;
 
@@ -705,8 +705,10 @@ static const struct attribute_group *rapl_attr_update[] = {
 	NULL,
 };
 
-static int __init init_rapl_pmus(void)
+static int __init init_rapl_pmus(struct rapl_pmus **rapl_pmus_ptr)
 {
+	struct rapl_pmus *rapl_pmus;
+
 	int nr_rapl_pmu = topology_max_packages() * topology_max_dies_per_package();
 
 	if (rapl_pmu_is_pkg_scope())
@@ -728,6 +730,9 @@ static int __init init_rapl_pmus(void)
 	rapl_pmus->pmu.read		= rapl_pmu_event_read;
 	rapl_pmus->pmu.module		= THIS_MODULE;
 	rapl_pmus->pmu.capabilities	= PERF_PMU_CAP_NO_EXCLUDE;
+
+	*rapl_pmus_ptr = rapl_pmus;
+
 	return 0;
 }
 
@@ -869,7 +874,7 @@ static int __init rapl_pmu_init(void)
 	if (ret)
 		return ret;
 
-	ret = init_rapl_pmus();
+	ret = init_rapl_pmus(&rapl_pmus);
 	if (ret)
 		return ret;
 
@@ -893,7 +898,7 @@ static int __init rapl_pmu_init(void)
 	cpuhp_remove_state(CPUHP_AP_PERF_X86_RAPL_ONLINE);
 out:
 	pr_warn("Initialization failed (%d), disabled\n", ret);
-	cleanup_rapl_pmus();
+	cleanup_rapl_pmus(rapl_pmus);
 	return ret;
 }
 module_init(rapl_pmu_init);
@@ -902,6 +907,6 @@ static void __exit intel_rapl_exit(void)
 {
 	cpuhp_remove_state_nocalls(CPUHP_AP_PERF_X86_RAPL_ONLINE);
 	perf_pmu_unregister(&rapl_pmus->pmu);
-	cleanup_rapl_pmus();
+	cleanup_rapl_pmus(rapl_pmus);
 }
 module_exit(intel_rapl_exit);
-- 
2.34.1


