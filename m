Return-Path: <linux-pm+bounces-21376-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D072EA28924
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 12:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D04F3A2D91
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 11:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A4722A4E1;
	Wed,  5 Feb 2025 11:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PlI7GyRE"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E39815198E;
	Wed,  5 Feb 2025 11:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738754767; cv=fail; b=kwNA9sksUpFL98XfYh90BVHcBrUKzvdV76UEASTsA4GmBk5/Vq32gOf8WX/NnNhprRmF2pe2nOu65FAcZHwbnE10xHj7Q7yaMRV79WJRggWGQV6dggFg2k8PB02V6Ohf9BaVV1fNhntWLDuuiGv9FKbOPqABfNTRYaJR2vtj00Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738754767; c=relaxed/simple;
	bh=PqTDPGnG/l3yQyX8/9RbKj6Q+gwfcPqz7MhwNUZLse8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qWpkXNVEonTjPy0V5QY6I1Qdp/b4OoBqDQOMYkHuXiEHu3jOsZrVb55OP/kOWsV4tYSUNzrJ9W6CM7cekJD21v3DAjgG7/azqm6rKJIb4f3eMTIHqM3FG17TQ3r9rI6W0qqimNtYNEMQVRRSt/i0GqwZmTz/RJ8KU052wXNkjkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PlI7GyRE; arc=fail smtp.client-ip=40.107.94.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z2IEzqC2pAcibRQwEWrzl3PsijfKg5cozn+rDIavMm3FHEgpf7UXJHn7/4CiHNWCXGSlYJfSGiN6uPu78BQQLNsN3+5vrqyn0fXEjjncTWNN7KV/EkCIGgJ+cGxytqIWCxL7LputYcWRuLNEc02X59WD+pjwXSkc0AOLjT5jSnYj5UclzoDisx5LQWrxHpRIV7rSPm23ChzTXb15uMFCM/taPO3wVToeUxBboTl1Xs5kjQi65c+3iabSYU+P5sWMEyMT4gS+uqyOTxzxrbgjqgwhM4CpAemtjiPvb4ydbTgIwH9RptmuxejqRzDmYmBTX0vi3MEvqfZzX6+ANOodKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C/Gvnc3YAZzH4BMOAdmUo9dQtVwJ5Kq/e/bELv8Qrfk=;
 b=OpzNCEmmcLLgtFWB3aUniOKUNPcnb7nHG1G9o9HSjXkcwwbZoxi7MdF6O0fbM884kvyxn+RtNZhG1yHeCwUSQcA7S+FTYnjorwWZ1ztruVlZxEIWveS1u6GsnuhbuZOj8rlDWFwWd4ZErZ++6tV+/tQBf7FKZrmrJ8Z0J739aY4U0mzubJAzh0S30s26eqSB0zCuLdb7cAw4g61CnHMNUGpewV//hBfKjlDt7021VPZwKOHKH7BXvqnDCcdIu5hiD2n5oTfccHsRosZkh73vPi3jC04TMvDKM1m+aWKlOY+sTcbqAiebOrii1Wi4qt7ppbhFPvCV8RyrpABnAImffg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/Gvnc3YAZzH4BMOAdmUo9dQtVwJ5Kq/e/bELv8Qrfk=;
 b=PlI7GyREhVDjttWGXHNry84xYDvY5+V0Zkcp/cX5uwzS76qlkah0OeTF8rTVAn+c+kkbO1UtGEVbUh2OepxLo//VAazFCUxmmOCsT9y5ZKKzaiSnBXII32LArNTJMauNKFxICEul+AkqTmkR6mkjzjA1Wrk22Wk99HebG/fbObE=
Received: from DS7PR03CA0235.namprd03.prod.outlook.com (2603:10b6:5:3ba::30)
 by SA1PR12MB6948.namprd12.prod.outlook.com (2603:10b6:806:24f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Wed, 5 Feb
 2025 11:25:58 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:5:3ba:cafe::2e) by DS7PR03CA0235.outlook.office365.com
 (2603:10b6:5:3ba::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.27 via Frontend Transport; Wed,
 5 Feb 2025 11:25:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 11:25:58 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 05:25:54 -0600
From: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
To: <gautham.shenoy@amd.com>, <mario.limonciello@amd.com>,
	<rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>, "Dhananjay
 Ugwekar" <dhananjay.ugwekar@amd.com>
Subject: [PATCH 01/12] cpufreq/amd-pstate: Remove the goto label in amd_pstate_update_limits
Date: Wed, 5 Feb 2025 11:25:12 +0000
Message-ID: <20250205112523.201101-2-dhananjay.ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250205112523.201101-1-dhananjay.ugwekar@amd.com>
References: <20250205112523.201101-1-dhananjay.ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|SA1PR12MB6948:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ecd709e-2c0d-4faf-f84e-08dd45d7dcea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E5zNd00ghljCDtNMeOcAZTUxJy/KkpRIeKBOc47J3rFANA19t88XY4hHpW1+?=
 =?us-ascii?Q?PhkH0jzjIXfoOLd1iZEp9Cj6kYVlJCPK+yE9BV1DpgazZseSXeOcvr+g4jDf?=
 =?us-ascii?Q?JpfVjxKf5giQ3/31Zjw98xw8ybxdZf77T26qHgRt6o17kzgBbWOvfxEcH8PB?=
 =?us-ascii?Q?YPOkm2ew6LwKYIDFSkWVvw/oH+iqe+pXxaW0vPBn720VKHdR5jd3hrtFeGXQ?=
 =?us-ascii?Q?sLklhWqo81DSBJMnY0Nea0PgDi9HsNj7faaf+/mAkRjK5YYRN2C743nyoTSF?=
 =?us-ascii?Q?4f/HCbTfZG5WRAa4zMO79NJW3VEePVz8CaoFT79Csf1BVVb5abyFkx9mkzhz?=
 =?us-ascii?Q?fiV7oNFw5mtg/s2d0bqEZ3odAUCiJCFW+mehKumldAUlDARyQ4aThFuWOOCR?=
 =?us-ascii?Q?khNiur63aC740/YU9LMjB7z/9AegvHdSQzKS6/oxzmJ/YQBytiGMxk6/FvMQ?=
 =?us-ascii?Q?T0pL2/FB0+wPxuuh3RZlICWo93gP4da6MCQabAavTBfQ81EKUvnuReOxr+Sr?=
 =?us-ascii?Q?I69r4H8eTeflSAZxu7fKjw4ZSKsiDm7SmIjJnoA7ztxbDFm1rdeSFESwn/xv?=
 =?us-ascii?Q?VxFIaAy0NVxQ4aGtqKcpjldlU0zchVXvS6nguv+CN09l4SuPGHinj57mpB8m?=
 =?us-ascii?Q?fKXVEcsm0a4PRuDYIYeiAHhhO6DqLpsqEDdg5aeZsmh59JdEnbEcXjhHMrke?=
 =?us-ascii?Q?ud1oKOGsWdQyTC1wvLMVzrX6yOHgzi2JkTnnVkecQR7AeaQxNGFx9m1xLDOt?=
 =?us-ascii?Q?8RIBxvWHnnBE3rV/Qh+kDsQMn6DOzjjVPYW8olEZ4JhzsvWifaio/nZNuyFu?=
 =?us-ascii?Q?dtOT9Du0HSBJ3CH5XPCRta+cdo771EKijuAEiYKdkvjtsQ2424deDY+3K5oj?=
 =?us-ascii?Q?/bNA3if9AwGgdCTxxTPA+QodT8QfjdsBxScXpVxCg/woclXxPZ18XoBw3oUW?=
 =?us-ascii?Q?+YlybnYsedibRjEClA22SfB+66OGU0rHbBuDIq2DRneNim823KXYneZRmWAq?=
 =?us-ascii?Q?QXaGTc7rxyjJQGrC7MOSV1rqGOLDvYcUiTcK5wRHtt0pOxS4Xsa8oI3m0b5F?=
 =?us-ascii?Q?YR4w7SDm5jSN1oG7RdLpRIpJ0xzpiQqAnmPsceJ1ZyAZczCd1ha/LRgnCnkN?=
 =?us-ascii?Q?MlPsAOTDxvivwhup2Bj1pcqDhOM5bQ2jVzB4RDtG+7oR/dmpg3jjkKB+FJQ3?=
 =?us-ascii?Q?3N430xcaAZY6uhfh/qmM+FwG/aZ3lnUrsk1HyvYeZSG13dAUGYhRI7zeQIGR?=
 =?us-ascii?Q?zDBiU7NtLskWqQbagvvvw5E/WC7LGhsJiiVy6A2qAUJXy8X0Loxm71KG+CAB?=
 =?us-ascii?Q?xJXkTMx1jBFXSaQwO67a32OMX/0N0f4ZCBim6LA7Ssg05VOfhgJT0A06GwfD?=
 =?us-ascii?Q?m3lfAS8NsTPDAGxc45K/LOMvRFbzviv18mUFmcn48NH9L99OAWOQPT4noFcT?=
 =?us-ascii?Q?tpoJFEdHiUJT94b8zGtSj5T7xH34pTBpnAzaIWJq43d9rzEvKXVJcxOI/rl+?=
 =?us-ascii?Q?AoHImbrCb/6ry8s=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 11:25:58.2056
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ecd709e-2c0d-4faf-f84e-08dd45d7dcea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6948

Scope based guard/cleanup macros should not be used together with goto
labels. Hence, remove the goto label.

Fixes: 6c093d5a5b73 ("cpufreq/amd-pstate: convert mutex use to guard()")
Signed-off-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 7120f035c0be..b163c1699821 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -838,8 +838,10 @@ static void amd_pstate_update_limits(unsigned int cpu)
 	guard(mutex)(&amd_pstate_driver_lock);
 
 	ret = amd_get_highest_perf(cpu, &cur_high);
-	if (ret)
-		goto free_cpufreq_put;
+	if (ret) {
+		cpufreq_cpu_put(policy);
+		return;
+	}
 
 	prev_high = READ_ONCE(cpudata->prefcore_ranking);
 	highest_perf_changed = (prev_high != cur_high);
@@ -849,8 +851,6 @@ static void amd_pstate_update_limits(unsigned int cpu)
 		if (cur_high < CPPC_MAX_PERF)
 			sched_set_itmt_core_prio((int)cur_high, cpu);
 	}
-
-free_cpufreq_put:
 	cpufreq_cpu_put(policy);
 
 	if (!highest_perf_changed)
-- 
2.34.1


