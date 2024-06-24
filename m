Return-Path: <linux-pm+bounces-9875-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0139F914272
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 08:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61EA7B23F6C
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 06:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4470420330;
	Mon, 24 Jun 2024 06:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="atsNQm54"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BB11C695;
	Mon, 24 Jun 2024 06:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719209001; cv=fail; b=MXIoj39+G+3unQmm0eEGI2poMOXUUy7FfY/vXoPEhMdbFuZ/L1nrLluzLYvqoY0rb1UWtuz7CXZarktFGmeTsOyD00qmsOdStmbCQ2QiflhTLke12NXhvU7c5SjOjX87cC3ECX3rfci5uYg0wmFSuyriTC63+0hwYn8kebEUPic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719209001; c=relaxed/simple;
	bh=r3KZn4cY29i3ZVT8o0x7Etz+i2GyJ3TuDpeR2bPZpxY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q0dbyDMyIFIvh/k+rzZhKI/2cSFRrmp/q5HZc/yrIoXuOrAYyMmGkuKGMRCxdACfMgcX3CHoUI7jrn/AM/VC0HmulDyU9x26w0EhuJGL2Tiqu3mumWxkKRpTdUqVTx5nMqyOlxKkEJMNZUNPKICre/kXtL/NjFgs0Vieqxroxg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=atsNQm54; arc=fail smtp.client-ip=40.107.236.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G0sGoIYjYuEx307MArEB+TTdu78FOeNWLW2gZFYMhNaRxDaN+I3n3g+Qa+y5CcL4ZL/AutNNM1vLZzUYFuSMBJ20m/n15ZRV1sWJJVETlG9wNwOPA5YrJtuglK3LidlmnHFyHG/7C4kMvdmuwY1Z8xV/lqoO5MmB3VWE72hm2xxIa9CsUq0KL1eSbhBdgjbzGAy/48TDTM9uULRtadJGtkYtJyuWOS2Q40tcXtwRYltGYpQrpwkfqlACfbaTtumQoTg/vrSlzWz4GEZL7x4Qmph8jcbc38NYzFXJMiSgJlcUuwhOxeOtW1Fneox4EwIu//ezSQVkxllOXXvsk8CSLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJw2vpL4ySk0o0rEFGGvb5MNBmpk6BRClOy53vqQOIY=;
 b=fYNFrvc8QEkaCZJl+sajQrWUcGuIueqIcXv9ZMbOgZXig22X4Iej/YVbcnrmylGxuAqo4vUtg5qBBVx3f5Qz8dcrAHkyQE0aBENmitgjBMNsapjA2Y7DTKYxV8VnVLmSDc+ofX7BC0S3WrBr8XMiiWDuFmpeJ19c6VXfuWm7fvrmIaYRQGzVR56qALV0AkDZutanl4S7Bre3wl7l15Xwme2uNmHjc+IhVmm9YHpL1iHdZYJFNS/s21H6tGziDxczMeQgkQDFNcY4+RkUSyXw+eXA/l1wFxNumPUgLHXRtVO1NxpaZQKAWg5CGO3zlrqJ6EwPV35JA6UF2v+QzKtLLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJw2vpL4ySk0o0rEFGGvb5MNBmpk6BRClOy53vqQOIY=;
 b=atsNQm54cRZaa9ITFxuILApOiCq9sSrwe8qxv8XX9SQ3xibgNMMtc+FDTey7GSCUVauieNaxyGuLYyPmDOrVzWhVGSgN2DV8pmtyCEXrUuDSu61w89DyjRZeDreEfM5SmGjuWxb/6oeS3x2UL7hfOp71XVxV/ID++DUzPoTSqJk=
Received: from BN0PR04CA0162.namprd04.prod.outlook.com (2603:10b6:408:eb::17)
 by DS7PR12MB5981.namprd12.prod.outlook.com (2603:10b6:8:7c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Mon, 24 Jun
 2024 06:03:16 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:408:eb:cafe::a6) by BN0PR04CA0162.outlook.office365.com
 (2603:10b6:408:eb::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Mon, 24 Jun 2024 06:03:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.0 via Frontend Transport; Mon, 24 Jun 2024 06:03:16 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Jun
 2024 01:03:08 -0500
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
Subject: [PATCH v3 09/10] perf/x86/rapl: Remove the global variable rapl_msrs
Date: Mon, 24 Jun 2024 05:59:06 +0000
Message-ID: <20240624055907.7720-10-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|DS7PR12MB5981:EE_
X-MS-Office365-Filtering-Correlation-Id: 90176e88-f801-4d61-6aa0-08dc94135704
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|36860700010|7416011|376011|82310400023|921017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pVazGTeTPOiF/h9MpX4+vvb4mUq1wKSssS0x1vzglxxIM2JiMA2zKPlAASCh?=
 =?us-ascii?Q?u4PiIe+1p+ekHarCpgNetosJ+daK8oPcTK7Xq2g1MkYMOGKazjqWtrLbTyWE?=
 =?us-ascii?Q?nTYTbBHdcaoRvQw7NhqOpMc736TXzQafXmRqTCOHTQEinlaLlfvQqIjOuYel?=
 =?us-ascii?Q?eCoSja9naGB94T5DBNZ1VPxZJ4epNRexaVpFHMI6FNTl8S92AF2KV/nmKnLU?=
 =?us-ascii?Q?qh7K1RoXpspkvjWcwiqIf95/GArJiAM8AG9GoSGOabAwy2Msmm7bcG3yyTra?=
 =?us-ascii?Q?Y0Ohh0eNNgAL7M9V7ZGVQx1gbvVUQ/uPmXsJq668K61UespsglbLanexW5D+?=
 =?us-ascii?Q?9ALCZgUoz8BQLl4Bi161swErenPbLs2PHcATptDtLRTRUV3KxsgaydkY1SMQ?=
 =?us-ascii?Q?QBAta7L7/udOJ7M0BqesWiqvcf3pM8AqHuPfv5IynzqYsqx9CszQQpsDJaSR?=
 =?us-ascii?Q?P4o9b51Er+JlkUZ8+I3HTPUpD0GijuUpE458kA8XTdyJPUh4ZKHjVLyhS14o?=
 =?us-ascii?Q?c7mtb7gPWJqGPJ3Utrpxu5clxjjsnL3rDJVOfYAa2U4l62Vj5YO0O621Gutd?=
 =?us-ascii?Q?FA/Rmdur857XnUFw+Kaz4/ZNRe+JVaCW15ImVynWB6XEp0bw0MkaOxgD0BRO?=
 =?us-ascii?Q?bYaR18C0ig6dxFOSPcMG6TL88LW2ZJcnZBfFdgHl8CQlPgC8m+IhaaS5mtxM?=
 =?us-ascii?Q?rWyX0fRtU5ePs50Hw4uNDO19y2hDclO+NAVcUjz9NlyiqhctBNQHzoC0JKDn?=
 =?us-ascii?Q?IsrD6OrFLWIlM97tiOXKX9/3vjkM47iGAG40ypvp8tfPGyKIA054UU9DI91C?=
 =?us-ascii?Q?Q92oxFaxI3BR+xfPnEZjXwjrMa0P40rh+nR1bun5AaKXfanuL19SxjRIsECq?=
 =?us-ascii?Q?3C9uIIIf9I1nyyXrWNpdmPyPVE8eXT2MWdrO0NonJaiVkimFE51Pk7g7ESjA?=
 =?us-ascii?Q?iSBCZJ6ka2hxCJdi8/ZCq8KJxjEWM79reTgSyEN0RYFOBtoVzj8GW3VRj+uM?=
 =?us-ascii?Q?jSGJxazQ0L+UCNmHvjz81k2PGcAAVHphLb+hi65W11JTK6Lpv6CVsoFryniF?=
 =?us-ascii?Q?5L4Sic/suK9Iw05l6sA+R35B2GPJGxCg0qgF8oN8h5MY/pwm9mXmsDJexwXm?=
 =?us-ascii?Q?6gfu5VcQh/QS3d2VbaquBe+vN1awRxo+HC9zJkccudvjFREDo+5ERbbLafpt?=
 =?us-ascii?Q?UIHRnG8b/nrq5qoC5kDhN/6mtdpNdP/jHibRUtcSK5mv5ZgE7b0Xnm80iFa8?=
 =?us-ascii?Q?dUioDa5Dx4gBbUsT44t4uuoxj32KNPbzeGXOLFAJlLuyVKejU3jbmVUSe+5q?=
 =?us-ascii?Q?2595kjIblyEF7EWDi92sbgQhkEfJmPAmCWRF1xiqhmzdx/G8PBcpKhQkhP/y?=
 =?us-ascii?Q?IA9fWHffJXcBAm4/uFDTqtpM/dhwnPPRyITbcvLAAxkmKHWPfTm64PgbRbGQ?=
 =?us-ascii?Q?/X+GmA8mzyk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(1800799021)(36860700010)(7416011)(376011)(82310400023)(921017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 06:03:16.4183
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90176e88-f801-4d61-6aa0-08dc94135704
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5981

After making the rapl_model struct global, the rapl_msrs global
variable isn't needed, so remove it.

Also it will be cleaner when new per-core scope PMU is added. As we will
need to maintain two rapl_msrs array(one for per-core scope and one for
package scope PMU), inside the rapl_model struct.

Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
---
 arch/x86/events/rapl.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index b03b044a390f..e962209e9e4d 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -142,7 +142,6 @@ static int rapl_hw_unit[NR_RAPL_PKG_DOMAINS] __read_mostly;
 static struct rapl_pmus *rapl_pmus_pkg;
 static unsigned int rapl_pkg_cntr_mask;
 static u64 rapl_timer_ms;
-static struct perf_msr *rapl_msrs;
 static struct rapl_model *rapl_model;
 
 static inline unsigned int get_rapl_pmu_idx(int cpu)
@@ -380,7 +379,7 @@ static int rapl_pmu_event_init(struct perf_event *event)
 		return -EINVAL;
 	event->cpu = rapl_pmu->cpu;
 	event->pmu_private = rapl_pmu;
-	event->hw.event_base = rapl_msrs[bit].msr;
+	event->hw.event_base = rapl_model->rapl_msrs[bit].msr;
 	event->hw.config = cfg;
 	event->hw.idx = bit;
 
@@ -866,9 +865,7 @@ static int __init rapl_pmu_init(void)
 
 	rapl_model = (struct rapl_model *) id->driver_data;
 
-	rapl_msrs = rapl_model->rapl_msrs;
-
-	rapl_pkg_cntr_mask = perf_msr_probe(rapl_msrs, PERF_RAPL_PKG_EVENTS_MAX,
+	rapl_pkg_cntr_mask = perf_msr_probe(rapl_model->rapl_msrs, PERF_RAPL_PKG_EVENTS_MAX,
 					false, (void *) &rapl_model->pkg_events);
 
 	ret = rapl_check_hw_unit();
-- 
2.34.1


