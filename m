Return-Path: <linux-pm+bounces-9670-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B689F910569
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2024 15:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CC0B1F21AB4
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2024 13:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54A01B29C8;
	Thu, 20 Jun 2024 13:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kiZhScS/"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238DC1AD9E6;
	Thu, 20 Jun 2024 13:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718888595; cv=fail; b=WTsK45UEWfylUOqGKGAzUIszwBfD9jwOYMGFx2E/XSIRhPpLTJBc4Mp5J10JT5COltaJ0Rnpl/w+AdZeloW2KmeD6Sfj1i3MZIHC5CkoCfdnSdrNN66MUemRfEq795giozWtorAjCcdy1bXYv13flvFzZBGzpPh4I4uunKolzkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718888595; c=relaxed/simple;
	bh=r3KZn4cY29i3ZVT8o0x7Etz+i2GyJ3TuDpeR2bPZpxY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DQ4dtVSXmv8YZsUr3DNsVnCcNf9PdpjjBzINTCW75rhdxx62Tyhj3lBd9W7NsvzIaF1HVFSOc8X7xmVA8v3W4TgJ0H3kvNzFidOpRSDLR+59Eolsg7yVlVmoJfIax/6HKWCxS4yBxVRoYKjIruZKGzMWoZ4Sjw+LcdFPjjU49WA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kiZhScS/; arc=fail smtp.client-ip=40.107.237.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gVDtG5zhbnuuiTqxUPH2CRDqqSYxX3r4mbfHoEzgPhIZyYASNqcdVsKFNZO7tMZnDsZSce3XIoaW0dWDyMt5rYT7a0OsM0giPXL98bqXS8tRrhc74cC0KiyPs0mYcYr3De4VBBsQRCpDgsHvRJDjj93PzBFRV/wb9xHZZi7pyW+xkscpVcrqoh0bBAryNKDIYciQ1N01TWNuRMyAVrzDt7eUlKxlajcByG0ggkFoHAVVRFscjT5zRdIT9xGN1C9i7ZlWOrHst4EDtWkBnYGI8iDO1IT54L4soyz9kqezC0azOsWksbJI0D35kxhYxRdzVaVvc0nYz6lM4hT6C76kcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJw2vpL4ySk0o0rEFGGvb5MNBmpk6BRClOy53vqQOIY=;
 b=V2MjCrIIuUNLOr653IGxT3696NlvvF7FHcdIjDrE3sVzLbaXzPWJVFfNXTInzx1Go6xoJ3yMkmVMabBoj59P9YchB/+ZKvYxHr5gpT1FlzagttLeUjKKiqmkusOqyecH+H1dTZAa18gSzhf+2BEh5TqQ3PiaOqo/7gfy9w0dlTdIA+3Z9rbTgoYw9RyLkFI0AbBowDMJhskYu8ZqhgVROKuYBVPLkPZ2sOwN0G31UPzAKkqv2jXnfh8h6eVHIdE2uZ/c/+BfZT5qGavYkobR7QC52BqpUZftCGo81pMzxG7zPTBRyVF6svXjoznQhMYEJhfeqhNxKlwTjkQZnb7ltw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJw2vpL4ySk0o0rEFGGvb5MNBmpk6BRClOy53vqQOIY=;
 b=kiZhScS/4zSzJBRtTsydZYMkqpei860SoCDCSghlBLQJcw4dtZlWoP54F1jkQuGS7c2ba0C8KMHgq7EWdTbmtB6srttiFYfL/SoCBMI7jNUSMsqi2ZJrqnhqz4tVbv/IIYt6v+X71buNOSQw2AoaFFFafbFCuE7Ax6jFQEQVnRs=
Received: from BL0PR0102CA0065.prod.exchangelabs.com (2603:10b6:208:25::42) by
 IA1PR12MB7520.namprd12.prod.outlook.com (2603:10b6:208:42f::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.19; Thu, 20 Jun 2024 13:03:10 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:208:25:cafe::8b) by BL0PR0102CA0065.outlook.office365.com
 (2603:10b6:208:25::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Thu, 20 Jun 2024 13:03:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 20 Jun 2024 13:03:10 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Jun
 2024 08:03:03 -0500
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
Subject: [PATCH v2 8/9] perf/x86/rapl: Remove the global variable rapl_msrs
Date: Thu, 20 Jun 2024 12:57:02 +0000
Message-ID: <20240620125703.3297-9-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|IA1PR12MB7520:EE_
X-MS-Office365-Filtering-Correlation-Id: 6690c4f4-011f-4037-db58-08dc9129562c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|7416011|36860700010|82310400023|1800799021|921017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sv2UPYA5tbxlzZFTLcPrrKXzxnpWvegFTaLO1+sWmDguqJnpt+rcxj7Yeg67?=
 =?us-ascii?Q?UtkH2pD2eaM3pmzo2MJ74r4SFWphCiaFyqh1xRq/v5mbQwZ4JnM8CHipQXFd?=
 =?us-ascii?Q?B51vHPVhBZkyK45P74r4pOIzpmuE5skM9DDREYEas8tmXAQCUTD1Q/hYKzTu?=
 =?us-ascii?Q?C4riao+Ue8Zw1si9hJSd7uuGs9eTsKHtN4cZnopDuPEPFL1dYG7c2Mf8B5dV?=
 =?us-ascii?Q?z5N9uLe446WNmi2xhTSfdaBGBH3pqBMe2hGj7pYpDgx0RewkmdpfdbmaZ57T?=
 =?us-ascii?Q?dnfaKly6hLQFDN6VRddtfiJ9OJyo5fa9/BRtdy2L/2XausOFKHJWXa+9Rnr/?=
 =?us-ascii?Q?sJn1Y03H1toUKct2RrOUPJBjMyU/T8jnX1mbgdN8amECYwObtu3XxKMxk/+A?=
 =?us-ascii?Q?Uv8aMqDP7xv+5QzmWvAL00onIrhhyJPoMKpjodFmCeUvP+BQdaHMVb+H0sT/?=
 =?us-ascii?Q?qeGt7Bs/7R8zbHnQvsmP/JBq+FfjynjLw3ex4ej7KKE8wJLMtwyUmADj4jCa?=
 =?us-ascii?Q?iGDx/vherjUryZT7lH2t/YgE9QALdUGS10YEGjLbDJXfE8kPMCnuBx5efCw6?=
 =?us-ascii?Q?b8iudyr40eDr34hMc3NDTZ2/r4K/f9PEDujukuCvdEwSlYor13vqrBcHQtaO?=
 =?us-ascii?Q?t+ZeEEB/QfjJw3Tpvd4HWku92+zoqHLiRFQWISexlkrWGP2+gqG7VqMz1G2S?=
 =?us-ascii?Q?uQsMN0FJ9rqRklzqLiHppwr6B2I4+vljn0nykDGenGLundmCUOVbFVTqGpnq?=
 =?us-ascii?Q?KUSqn5a2RuZyGGtt/BXlfe46LoueTEKckkoNSAdTWwUBs/2EV7Ep1Ga5W+OM?=
 =?us-ascii?Q?17lK+FC97ncKozz3TLUkLjhIa8Vr1nnQZgFj2/6AKf8r5oz4ry6CvHs4R+Bg?=
 =?us-ascii?Q?DjUPqPI20+7T1fX7lKYvGnB6IS4W5MP29c1Ao2GXQ77SC9IpLW1yhzPyimMr?=
 =?us-ascii?Q?nn+/6J3sW48httUmk4X34rljJmTShaYp7saXm2DI5yW2ud8DagS+ofGPwHwn?=
 =?us-ascii?Q?rTcoioqqXb12E8fr4zwQVIqrUTnvR0eJ++l1VTfUUndFsEO/HlB7xgxw/ryg?=
 =?us-ascii?Q?tjpQoSoDDhmxLDMR7l97SDOLCmMnswTJlQ2c8Qech1qvoFEKza9hDbZCN6hJ?=
 =?us-ascii?Q?LrInESfBxmq+U0ZWiyGXJTMlubWekrx0i0yyfiS8hsybiAIgrxl0Q7tET07l?=
 =?us-ascii?Q?nootUZlGHkomgLQkEqpdqTi6PME3OEcz85bc0P/cAegNa/BDY0cxyRLoUCod?=
 =?us-ascii?Q?o8AAcXSzetJXpNITn+O41eq5qWZso8Ir31hIewMmTvQrdQ6MgpTmRq3qbi8X?=
 =?us-ascii?Q?U07bu9k4a3KD/N6qAViQ5akP3vwEGNfBZCnbwU9xG9CQFxChzzfMLZGPvsxa?=
 =?us-ascii?Q?EQ/TIskqhDZet1XFixkFMFd2Ms8PecFkfTR29neVCvhMLANezX6Oz4i/wEob?=
 =?us-ascii?Q?/01f/+AwtE0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(376011)(7416011)(36860700010)(82310400023)(1800799021)(921017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 13:03:10.4609
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6690c4f4-011f-4037-db58-08dc9129562c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7520

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


