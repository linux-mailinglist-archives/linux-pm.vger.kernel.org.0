Return-Path: <linux-pm+bounces-24981-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E605DA81C3B
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 07:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 884EB1BA0594
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 05:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF66A1DC994;
	Wed,  9 Apr 2025 05:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Lm+afrUU"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DEE1DC997;
	Wed,  9 Apr 2025 05:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744176970; cv=fail; b=LhJrR+uLhsJ9ptPZefEPRzMnouZCWdrDccfr2NKKcL/+dyG5a+XxJYVbsGeuf3J/5mJgEAo6uCBx9azc0u/at+QRhuXFR7iCvlgNw0j/a8QOUNoEjXmnG+W42XIjtuIg+Xcmhaigy9LhVZA70nZKNvJa8moMf3ZT0SWVY855lSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744176970; c=relaxed/simple;
	bh=y+sJw537O8n3vIrVlJl69hNI1eBuTPGxEljugiuRmQ0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I078SEKZ/In1kIPNX+TzCHqmRPWF/DFDBKZGhnekO06YZjqLn8m0wwJUot5hBU4cyepNiNTRL0FU2+lYXE4sZoPPO8OSVDFIWVux3cnn0spRJUJK3i/qrEsUX2KQKiGnIgOp5b1UrvLHm7NkfZJEOyKDBK5SLVgPSHkMG94XUhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Lm+afrUU; arc=fail smtp.client-ip=40.107.237.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k2ytAyneDZzV9p+MRhIosviEQ2Up3sT3hAqNyQrdBzM0HABr2ixgh/59vF93KzviSlh1GRyqETLQ3Mu/hd5eFXjp+5jHM1eqhwRm11sX0Lld7uukdZ2i0htpWmykoroFQM98q+h11Lkoj/95Sri3Ba26/9uBZMBXlZylXe48YTxNeEaumdTzG3aqdmVEtrmrobWlJBbbg4AJ6omId2HKsOBp/whmdGTE3mAIzhLIQDmDkEbr7wdw1MmMHz/N6ORJb5gTq3Oa/FGEr1DutKQuXVjun1tnXt4PIogG6R0SHxncf2QND0EMWBd3ru+ONpWLnJwxU5aRplVrlPG4UvxG9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ttk1oyF3cF9zozJAhbovrdjff2WZS52rLspuN3uMrrU=;
 b=eOcMkl+TAInYUX1cGKq4BQWnZU/ECcLT2RC0dv/kYtLvyDMBE+Hyeu2DzluKrcmMdjjK4ABl5/f/NIP5+lZVKDFJApZsIBhzO2gpQp8I4n9+Km/P0Z/q0ygLgQkciMUONh81SqSKvmuse5P1JqPhWtHB6nHcpvVAXVGaYNNSvmcNFKBGxlge/TG7D7WJntaMbCXUAd6ZHFBWGDAY5HLzIb4DfBaAi4bIUvvdQ31Kbkh3YPQqt2geETTyJI2KSAupcMJvZ09gKwfk5ASrFTjTbj2nfgwiR80XyH3paw6rFjDG+XsxnrlaajrrV0Qn/HK8DU+Gb53fdg89gqndO5thQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ttk1oyF3cF9zozJAhbovrdjff2WZS52rLspuN3uMrrU=;
 b=Lm+afrUUR3q2r+3nKL1Bwnl98rDy/HZRQw0yXcNdmTZexs+bUkYMNykNzInZmd1cZXYT9RpgE7yzn1N3sVffTBw+eMMMRfdQPsTjVPcmWEc233plPLrhxsNpgXFh90qGaT8KgprMDDk2fgByzB/wQIGdq3JfGZedmC06n1clwCM=
Received: from DS7PR03CA0201.namprd03.prod.outlook.com (2603:10b6:5:3b6::26)
 by CH2PR12MB9543.namprd12.prod.outlook.com (2603:10b6:610:27f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Wed, 9 Apr
 2025 05:36:04 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:5:3b6:cafe::1a) by DS7PR03CA0201.outlook.office365.com
 (2603:10b6:5:3b6::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.35 via Frontend Transport; Wed,
 9 Apr 2025 05:36:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Wed, 9 Apr 2025 05:36:03 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Apr
 2025 00:35:57 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Waiman Long
	<llong@redhat.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>, "Dhananjay
 Ugwekar" <Dhananjay.Ugwekar@amd.com>, Huang Rui <ray.huang@amd.com>, "Perry
 Yuan" <perry.yuan@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>
Subject: [PATCH v2 3/4] cpufreq/amd-pstate: Update asym_prefer_cpu when core rankings change
Date: Wed, 9 Apr 2025 05:34:45 +0000
Message-ID: <20250409053446.23367-4-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250409053446.23367-1-kprateek.nayak@amd.com>
References: <20250409053446.23367-1-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|CH2PR12MB9543:EE_
X-MS-Office365-Filtering-Correlation-Id: 730df8ca-95eb-4dc6-9aa5-08dd77286b56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SRv4Q2Og9IEUJCeF2DMMk4GYofTgFN45QlYiZBUWyBWn0QA37xRhtTOlFxQZ?=
 =?us-ascii?Q?pzWEp/VFNQ5wow+r1rcRj1l+r6iMfmanuWEoEe13nKlcrz59slhNU1TFq1Dl?=
 =?us-ascii?Q?1Iru9hdCcnmjSv4Npiq1Zz5u3b7MHu9e6RXkQW10Gwv3Vc9d6nXeZEyTV//f?=
 =?us-ascii?Q?5MejInWsHAp7TXW74Rb2enGDhyCe2zSM9HCIFF65fTwX6jgxZlAjefUi43k/?=
 =?us-ascii?Q?OREQS/rOxdk8UMJw72wXSf2xCWBHIUQM4wYWjKUFwuFZoyV2xXbRip/XWZaY?=
 =?us-ascii?Q?a43Hsb6r4ckOHc108ZddfSeeCbMT+QqL+RKGn4dWu4cJiNKuafL22jp0jUwZ?=
 =?us-ascii?Q?g9sOr9axzGpd+A++tIIDk5p2+DaurW4NZpH8nRxQlFF5xChEgnr8Cj21+Ndh?=
 =?us-ascii?Q?A2/UGvJuCdFXeBAzq1OLNxpW8yjkKYqcxX5QN7QMrELKGpcvphijkanf2KFN?=
 =?us-ascii?Q?4Wn7c+8gp1Nh2Z0opICoYQo78ygi7biNk5HIoxCjcs5NW+MO4OVdV8yjhK7h?=
 =?us-ascii?Q?h4kAjTg1uFCi1AAKdhiIwwDGJOt7MxY/94uICvu36jIKYGId8L3g1LFTsVz7?=
 =?us-ascii?Q?Rjmog56Vl3oL/iV63UZb3QbhFnjsHrOB2PbkL01yWITSloAn9DVwyNSYOqen?=
 =?us-ascii?Q?NyKadE+0iRKLxH/oN/BE+4uaCL4PJnxo6ySsfteOGK75BvNnjQS04Y7Dvono?=
 =?us-ascii?Q?I+iD5bVLCF3M9bol1iyGMdAa2FH8yHaZ+QiTcEXCC7njYFEBXd5PLevuisgf?=
 =?us-ascii?Q?ARmqIc9Rhi+p4GQhIGG3+kCKpcprM6G6iqEUD+sOZJpqtFoj9QzIF0rn98nu?=
 =?us-ascii?Q?rRihi3RTrukYAKSikPDVvgQAT8UBTX9b7gY6nKjf/GDz2+mW/bdJovgsGish?=
 =?us-ascii?Q?c6I3+WPMBJUpIgpGfrNfvwxHHGOxUuzHYgt7cAFSe8Y97mglmV6TIMEwVcKe?=
 =?us-ascii?Q?doRDUWcWo5DeEXdjtUNKGSu6ldBxWIn4g+zN7yBidV+Ehb8fEfugF/+NB/fs?=
 =?us-ascii?Q?qL7Dccvc/x6WbgA986Np0jQ9DHIgvMA5N8gYVf1LpsZOpXWAoBE/JGc7z54v?=
 =?us-ascii?Q?XK0CmTkusAZSfdiD0rufnC4TmeOOyRhtg96K323FyGlfxckuWzVkISjFmnu3?=
 =?us-ascii?Q?j0AUymX7qDJG11FG2ceNEtiEj0pOznx5Rb9pR/VA/jmW0GQLDWtw6vRTc4WU?=
 =?us-ascii?Q?hAsDDYJnYLsR9h9Z63MSJPJIXJXkRgaloY+2BK2EQdVbsHcW4YbXl6Zpozfo?=
 =?us-ascii?Q?LpGiIC06MBHbO6vhoO7PZugoaX8ACoS/pU4QhvtqkhkTCuB+a8aqIgDbZWBg?=
 =?us-ascii?Q?hCxIFTnIX+dxWAo9mBQW3PivxAEOGnYfvWjU+fCM2UwYjQQMv0mWzzBLwDqk?=
 =?us-ascii?Q?7G8f/m3Gjb4ku4F5AR6jM20XeK0hyH1qnw2dpyLS4bZxrJYc9YJmZyyi9pob?=
 =?us-ascii?Q?AmmN5Ndycl7nEMLTzEVlz7QRhCzySTH3SK9t8e3FQqXe9Wy2ntmt9mmfBTUP?=
 =?us-ascii?Q?WgX2/JodwmvdXvc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 05:36:03.8932
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 730df8ca-95eb-4dc6-9aa5-08dd77286b56
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9543

A subset of AMD systems supporting Preferred Core rankings can have
their rankings changed dynamically at runtime. Update the
"sg->asym_prefer_cpu" across the local hierarchy of CPU when the
preferred core ranking changes.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 6789eed1bb5b..8796217ccc60 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -844,8 +844,10 @@ static void amd_pstate_update_limits(unsigned int cpu)
 	if (highest_perf_changed) {
 		WRITE_ONCE(cpudata->prefcore_ranking, cur_high);
 
-		if (cur_high < CPPC_MAX_PERF)
+		if (cur_high < CPPC_MAX_PERF) {
 			sched_set_itmt_core_prio((int)cur_high, cpu);
+			sched_update_asym_prefer_cpu(cpu, prev_high, cur_high);
+		}
 	}
 }
 
-- 
2.34.1


