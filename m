Return-Path: <linux-pm+bounces-9668-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D35910562
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2024 15:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7DA3281C6E
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2024 13:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C971B1434;
	Thu, 20 Jun 2024 13:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yN1D4Uzz"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A83C1AD9D6;
	Thu, 20 Jun 2024 13:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718888562; cv=fail; b=OiQ1TsHlqMaxnfUmS9Vb5lVSCSDxxkhAt8hMOt6tjsVjZZ8c5zafJDr4VW/nd6GxzgKXAVePqFm14WnJMvacGlMwn3vi1a85y/t2efjiwnS6XVPMUpcHN9+GKxT8kLPf2ZL6pcF0axvLcB645QVaVuPkrMg1DN071akRSK3mBrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718888562; c=relaxed/simple;
	bh=SevruLCexV627iM6Dl8XSaoopRtrEYLT3wp2+/RPnLw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m85dpVtsnhBwv7pHn0xJlOaQY36DV1npAjM6WgR6SapAtQKSJpUyewmflY0Oh2zVlF1En9Y4VWkpbaG6CdnkmnU+diMWDl3NdlEUqW8XLDPvvctENHf3ghOD7TjNbkz1s2rKOWKlTrzW/fSmrNgtbft6jI64WNzwERjh1ZMr1Lg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yN1D4Uzz; arc=fail smtp.client-ip=40.107.220.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SssyQWqBlS6Vim7bhm4kOwWJC8mLw13ZGkjQeVDxFOE6VxdihNGsOZUnkhiLUVhPT/XKjQTmpACbXy/5wSHpHO2UYnIR58tBCZpEIWJhuDdzYQbBoLMm9U+TzHmJvLLSDDJS9abdrWIuw2q26sSVGiNSczgSCauZBTFleU8tQ0of8I4lE0QbX0UmJwvl8Y5sAoqEJmwO0NJNfpVHaDN6Ebv2loiwMOr65IWKrXNuciL+k2uBOg/HlITmjpGOC4zZHqWcyQpKA0uF95Q8GPAhwdcNMAn54f1KWH97qMk/w/i/QkDiSkD10lA5hC2TcMFeJmsFqhV450O+t5JtUuadxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ecZ6mfsQyMQekhKSwNggBHbozRpNVr37hIhIwLMyQH0=;
 b=UC5Qo6Xr8cogz9K/ut6mh7QyHldBnXmd9vY6BUoaZd9bdqdca6M2txu89Cei7Zt1UM3We4pbUsM0+xPsQyJOnSn/mBg6oXbfwVwFV6lPvek/QcHmTn34gxyEcQCanX7IYYWMqu3J4WHZBIHGTcEdoMGb4qmnrLZSbVCHMkGtFXtSiWfbLZ3C7csnqQHdOMtwXp+82V0CEyXY/J1Q3hzFgmWawbyOLVnIU6wxkPpMu8mZwtYq+1basO8EHsGrsNXj8BC499IGwppRP/o8d7vR2H1/NRAxNubBdFgiQ8tEcJUf6iiPzoUvuEJ9gshIa6w1ayZcbYwhaLpGSKLHCOXGuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ecZ6mfsQyMQekhKSwNggBHbozRpNVr37hIhIwLMyQH0=;
 b=yN1D4Uzz62u1x6pnHLdHJqUBvQpk7GQCjEMIYgtmVqnCp4aHBml7o4GXHuaf1h+T9Z/NkPrRfTJhXwhME/VJi9jux/bAiANMWjvtfCHIUoyjXkQy7SQtz7mmnKMnWFXOngLJCmTDuG84GJC0FG5+lQTxjEpxQYVG3/YXgIMyeUg=
Received: from BL0PR0102CA0068.prod.exchangelabs.com (2603:10b6:208:25::45) by
 MN0PR12MB5931.namprd12.prod.outlook.com (2603:10b6:208:37e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.19; Thu, 20 Jun 2024 13:02:32 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:208:25:cafe::c) by BL0PR0102CA0068.outlook.office365.com
 (2603:10b6:208:25::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Thu, 20 Jun 2024 13:02:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 20 Jun 2024 13:02:32 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Jun
 2024 08:02:23 -0500
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
Subject: [PATCH v2 6/9] perf/x86/rapl: Add an argument to the cleanup and init functions
Date: Thu, 20 Jun 2024 12:57:00 +0000
Message-ID: <20240620125703.3297-7-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|MN0PR12MB5931:EE_
X-MS-Office365-Filtering-Correlation-Id: 478386b2-bd6b-4728-bf9b-08dc91293f78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|82310400023|1800799021|36860700010|7416011|376011|921017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/9urNv/0xCbRdfXnhIwnV2ddLFi/XPGC1HVsgPv/+DeuOXsXgVEV69zBWgR3?=
 =?us-ascii?Q?4HC/Rp/iOLj8ouGgqy4XgH0DK0JW5Tq6JvthLjz4fa5jGOaTgNqxvbadXAC5?=
 =?us-ascii?Q?WjYRJohPeMeG4pHbIkcTJhoCk8efQD+cJdU/C0sODM5lvBF9GcsXr8hwd/FY?=
 =?us-ascii?Q?WzU6kSgmrw5/yMvkSujQ6Wd3b4HOzZmTpsB0aD2JYCgxFk9LdfDL5ao5AfYz?=
 =?us-ascii?Q?y2LtVbM75a5AoYuqFbOYWyV+l/DtDFm/kHMC4IqEoYDDrDetI4QS4VCcYxLn?=
 =?us-ascii?Q?2IkbNOJb2luEXsOioganrjqWvtR2UmQDfJF4oZNOJcSj7vlykeVTObQKZBrz?=
 =?us-ascii?Q?iBtdJk3t2LmitUd/0oT1jf4Gsq9yayM6d/dshVZ9eqp9sinHxiodOdqtVEip?=
 =?us-ascii?Q?lVuxV3PgGnsrTNIiWc8eAcUZuWAws6aX6Fsv2sHQ1oj3n9Se5VMGwSyV8vJd?=
 =?us-ascii?Q?5TA+TIseowzdMNeeFPESeoKJEQA1wa9H2u5jeEZwkulMGFmPEothg+mnucC+?=
 =?us-ascii?Q?WRXLwb2dTalSPU6Z0B6keiBXqLu25dSr1e7+pw+nKnmCk4q5ShG3WWuBxvDv?=
 =?us-ascii?Q?eC6ZztJgSpBE0IhfdILmiNLIhWBLSZvRm3yTzK6oHQlpxiCQgDPYE8ZvDtkK?=
 =?us-ascii?Q?eeSyZ+b/D8zus4zPt96pwZO9xxZUotJTMYnWXNknYQzF2qq2Z1Ri9Lz38PAM?=
 =?us-ascii?Q?RyDVyqPnD+QBK2S8DmpLSlfUfTNl2oWs0HxElEDOTkM29+hi3/Bf59IkfBXJ?=
 =?us-ascii?Q?5v431fACCDrpc7tshJn1/Z+9S1sKDQ8iRmPtnCLTlrwGYAJsDdkw4ImZ2p1N?=
 =?us-ascii?Q?2PPU+abUS3SGd/GBvFqd2aZR1jjKY4y+hL9mBbAa8vlvnyQ5mdLwqlIZsSC5?=
 =?us-ascii?Q?rTlXlmEJRarVdPkleiQopzkWORnEnDP+5dCUnaCc7QotTznXbyhuyyFYpPcR?=
 =?us-ascii?Q?kouufHDoLuUmZ525N7EZpVMIkwnqTvbXAYyOsT//KcNMLNTWmzlXSCVW1ryn?=
 =?us-ascii?Q?ETQiF0tb1lqHXXJMKXokWoGPu8hzBM+UbH/Gd/91UPAyK4GbJ7hTPx0uQi8N?=
 =?us-ascii?Q?P7jOMTGiSI5kgfhqCeUT/3JrVfWFVtKDJHoAKdkajPjepHAiXhcymiOyto4P?=
 =?us-ascii?Q?bZgQpwTNCADM1yX5fx+xtmA+moX/TIuDKPO2Ct2vXAdPxWKe9RxzTvG51vvx?=
 =?us-ascii?Q?v4ORGma2k5TyvDtODo+QUK1TblMkpUx9AM4CpqqrAx7MwVj4ihMCYC5D/OjO?=
 =?us-ascii?Q?CiRyTd0pqjOCQz/IowGKhliqMPpa4eYQrE9RIWwESZ/onwtHYh+NKbQFjcYp?=
 =?us-ascii?Q?JTzFnF/PtY1HwfUCnc06AF8i1eRtJF7QPlWTm9IljPh14sOLngb/uju+SNGq?=
 =?us-ascii?Q?1wX0vorVk4xvHa5WsPZ5U4ol3MJrqUU4sH4xkcW+4DE0SkZJbiB4eL8JWOMX?=
 =?us-ascii?Q?Th6zWXk0tvA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(82310400023)(1800799021)(36860700010)(7416011)(376011)(921017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 13:02:32.2613
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 478386b2-bd6b-4728-bf9b-08dc91293f78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5931

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


