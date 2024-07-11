Return-Path: <linux-pm+bounces-10979-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE12C92E4C0
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2024 12:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 269A3B2347B
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2024 10:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A5115920B;
	Thu, 11 Jul 2024 10:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="evqTExc7"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2046.outbound.protection.outlook.com [40.107.100.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA476131E4B;
	Thu, 11 Jul 2024 10:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720693838; cv=fail; b=WUs/6tCMhc5fmww3k2x8NKw+hsfN7p9CIvFg/E6MYo7KKmBw2bwqpaGkZnUaSlGMxn8fFo7weSXQHjbzgVkysm+ZDKKEKMNYSC+Hiwo04KXSkTMmSeo79aNt5wOFhwNcLltOee5IUfNTQgfK7JWZxdoDQV61+m69HJqNTSyVpak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720693838; c=relaxed/simple;
	bh=IBH+Xufd3E6IqOS6Hu6xkjZh0Frm+F2pU0RDYfu7xMk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CxPtF9YEGts2vnG3kirMWTTecQC0l9hW0KmLCK0bId/Vp+cGNALslifLFXJ9XzQ6H1TPi3bOClBKdXh0hyCMEtLm9wc+UtXJloLPqZQ6nz28pHQtWdg1aiOcPjHN9UqljUh3CwypJRjj6LK4PIr/C15TrIE0QRQW8SbjuE8RGLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=evqTExc7; arc=fail smtp.client-ip=40.107.100.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MntmCKYdTFtcZrfwHV9KDIHJD1yn0OWjQyjw1h8YTI1x4BZ5lXjQnw/Y13UtMW8uVKVpQln0bjmzo57MLkziU5BHFKRBy+mfuLE9eOJnZHQfaGmwsJ0d7xxkP4hOxuuZGIGXnBDL7tMAdLyOFDRVo+rTcSCoywB+bh1Tm12lizCNJ8PSoBuQYW5TuL1l8il02g1zwpWups4LRHtIpMsSFoF+3wbqyFrniopf6pUt3R9c+KpGGaq6tHka7LUva1YqT+O8AYtDGxNdr273QGdESxi8Ws6K7M3s5+Jj9Ec/pvwFbmg9q+M/BEG0WxJ0A0w3XUl861S2MtQpIa3+HFihPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tjF1E3UxHyTnhI0xHQ1zPpnsRhf1n+zD5bM302f38tE=;
 b=ATotB3oirjCi14vWIMbMmBb8U+8upLuPFJ7PqXKcdZQyKNOb8uUXzqK78dIK1WNAfIwasZ5IgA+lqBdTyMXp2deGwg+1/Kej4q2eW3AFuhXibucTJSTL6HB0Qz/t7+DfVeueEKi/ku00/vDLq21gSymieE6qM2mCbt3z6HlkBhKUOdUqzdqZPyEoLCJK60ocDtoo5K/tEnFBp1Rk8aymiC/8esatNWIdCrmS4Kq8XYJZXcjPG41t2npX/hhUPuZXI9qtxW1H0QcM7grrmtwDJXqvw7uqk6IaTUbrxKaK9c1vR6JCL1027M1rCq5YRVbDRl86atoxgMhsb7jKYj6QfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tjF1E3UxHyTnhI0xHQ1zPpnsRhf1n+zD5bM302f38tE=;
 b=evqTExc74kMNP6YkjXK1NW+qdLQz6r0eXNsHkb3Gfw6RHisf4dj44vjR4vnJpQgpag0nt8kzMqZ++OIABL0Qh4QO+qfqpmHXYXFjfHTygfokRQNikahVj7JzTElsUgPkwcOuLUGet7CR9vvZfcssQyiXvFeDiOf8G6+1eiEMdvU=
Received: from SA9PR03CA0001.namprd03.prod.outlook.com (2603:10b6:806:20::6)
 by PH7PR12MB8121.namprd12.prod.outlook.com (2603:10b6:510:2b5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Thu, 11 Jul
 2024 10:30:32 +0000
Received: from SA2PEPF00003AE9.namprd02.prod.outlook.com
 (2603:10b6:806:20:cafe::4d) by SA9PR03CA0001.outlook.office365.com
 (2603:10b6:806:20::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Thu, 11 Jul 2024 10:30:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE9.mail.protection.outlook.com (10.167.248.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Thu, 11 Jul 2024 10:30:32 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 11 Jul
 2024 05:30:24 -0500
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
Subject: [PATCH v4 09/11] perf/x86/rapl: Remove the global variable rapl_msrs
Date: Thu, 11 Jul 2024 10:24:37 +0000
Message-ID: <20240711102436.4432-10-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE9:EE_|PH7PR12MB8121:EE_
X-MS-Office365-Filtering-Correlation-Id: 90cf81d3-bc14-4b97-c210-08dca1947e55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|7416014|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eE92wSK9BRXkftTZsXd1B9weY+9llApVn/GvzYPRk3iAIhQ9se+l1VDzCcRF?=
 =?us-ascii?Q?fscT3I4gquVun2K5OF/OyodD04Ji8kjjy2dYCVCt5nou6jB2jJCQhM0+2tTl?=
 =?us-ascii?Q?UbBnxflEaPNwjeYyBUkp9CFCqTWOASX822apl5zmxHU6Ugw7VZV7cdcXFlEk?=
 =?us-ascii?Q?W4SyRjE/UdY96Y4rglTFCwd4wjVY7bJ3Yj9g1V+kb2NJGhh1KjA+0NYLeIWk?=
 =?us-ascii?Q?5STqjdiZfv7RGvbU0iDQ+aDKUlZSaPIydX45Rf33Bv1djtP8H+Tf0jrTL74a?=
 =?us-ascii?Q?FFXQBCPD1QDjiof4OJhjtghZaXeLe4YnhwrKq8Ginl9GG/Vm2v9XNjOy6cR2?=
 =?us-ascii?Q?sKMqFRIcFvCYukbqCGw6pohrFkhDSW8xU4N+AUskA6rn+uJpzsXy/qEAwOkw?=
 =?us-ascii?Q?jD9LMlv/nRSyECbYhjHQUMfr7qaMwIKg3lF2zBB58Xh9wOFWI5TxY/wpyijS?=
 =?us-ascii?Q?BM3YPUTtf3kRifE/xJhU9yl1uIoa1kJaCAEmjWRxEhOfQeG9moEQErtJkdgf?=
 =?us-ascii?Q?OIyFwjqai4C9sL4Yf3yNk+vH/KMZ368JOBtXM94R+26CNiDaYqbGH3fyMq61?=
 =?us-ascii?Q?Z/U7UC3ocBAl470n0My28/yXwwMmrJODzACN12UUZqIVsq3P+HdVC97ex7v0?=
 =?us-ascii?Q?ysPfuW4OR4RIGkKV3lswzkS5JeOeVkS4OTSHsUdJq2fgZ9RREhaoQocU4QUp?=
 =?us-ascii?Q?wuaOe9SoRBK6h/ZA60YEkRwIVyzCephyI4qLoNMGr6GGlHZGdhIFN1vSm1lI?=
 =?us-ascii?Q?Seg/ZLWM8glPSgxlAv98hWPHBSIdE+Xuk73liK7CbpKnTYTnS89VEqn2wdIL?=
 =?us-ascii?Q?UvBi0Zf6WVvX7UGF+5J05LtYZ8br59+1jiQxlVrv6DIX3SN+31IwoCYiHi7b?=
 =?us-ascii?Q?v+wnZDOhyJw6Ic5EoXOTw+BuUN1yXtN+V5Qm4CRwfxSo1C2lBlg+TgGOjakV?=
 =?us-ascii?Q?on4MqJBkpdY8Mym18DQ7HuzTY3k/CgWq8cZeBzthdHHjoimnkuvCHYTBokT9?=
 =?us-ascii?Q?PU7AMOuw/tB9qQjIc2KzE9TkR1gy1gXk9zot/ng4apmDhA9NdJoqPBjE7cqX?=
 =?us-ascii?Q?p2g3fIm1ipoDVTXUizg9BQnAng5qRrCXdHp5KJqwz6+GsFJLudNh8SZSj6uh?=
 =?us-ascii?Q?OBILX+vhQe2YsgK2xhX+IeqZYdem5JPzffTGURlqxb6YCBitjhF6wUlPr3VA?=
 =?us-ascii?Q?Mwj4KXN71NL3RFJAsCgUuoZIg4xsjokSvygtuu+7co95OiR89I5O/tVfJ9pB?=
 =?us-ascii?Q?LQMiK/iN3jXt4/GCxIQ0gxAVK21TVcmBcWAEqEfzyyIwnTA3dR1OA4RIhbZT?=
 =?us-ascii?Q?l/ElaJ+rIZcfaqTptqrZTI6ib0lT9CmjwredtyAvxb5m6/jy8WDKO7iNotR7?=
 =?us-ascii?Q?GvsZfs5BHjvNOPdJnCZE78HQOcnEKn6OgAf1jGcbNTljm/gPNXQ+19So32AT?=
 =?us-ascii?Q?lFzijAV+Ko+TwrK6PijdzR7UMWkyY4Hs?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(7416014)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 10:30:32.4516
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90cf81d3-bc14-4b97-c210-08dca1947e55
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8121

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
index 9beded3d4a14..7691497042e9 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -145,7 +145,6 @@ static int rapl_pkg_hw_unit[NR_RAPL_PKG_DOMAINS] __read_mostly;
 static struct rapl_pmus *rapl_pmus_pkg;
 static unsigned int rapl_pkg_cntr_mask;
 static u64 rapl_timer_ms;
-static struct perf_msr *rapl_msrs;
 static struct rapl_model *rapl_model;
 
 /*
@@ -387,7 +386,7 @@ static int rapl_pmu_event_init(struct perf_event *event)
 		return -EINVAL;
 	event->cpu = rapl_pmu->cpu;
 	event->pmu_private = rapl_pmu;
-	event->hw.event_base = rapl_msrs[bit].msr;
+	event->hw.event_base = rapl_model->rapl_msrs[bit].msr;
 	event->hw.config = cfg;
 	event->hw.idx = bit;
 
@@ -875,9 +874,7 @@ static int __init rapl_pmu_init(void)
 
 	rapl_model = (struct rapl_model *) id->driver_data;
 
-	rapl_msrs = rapl_model->rapl_pkg_msrs;
-
-	rapl_pkg_cntr_mask = perf_msr_probe(rapl_msrs, PERF_RAPL_PKG_EVENTS_MAX,
+	rapl_pkg_cntr_mask = perf_msr_probe(rapl_model->rapl_msrs, PERF_RAPL_PKG_EVENTS_MAX,
 					false, (void *) &rapl_model->pkg_events);
 
 	ret = rapl_check_hw_unit();
-- 
2.34.1


