Return-Path: <linux-pm+bounces-15833-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8459A1A34
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 07:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAF9CB227A2
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 05:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CFDD156243;
	Thu, 17 Oct 2024 05:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="j6GiaPq6"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC2144C97;
	Thu, 17 Oct 2024 05:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729143687; cv=fail; b=seomTLqDUU7gPyXg/Y7VPOKSDGMiZnzPZIMHTLyE3tbvrjo5HUNmV1TTukPg44J7WuHXRK0ctOByxYJBjqlYxm6KcBrRWcB4boNUgOjX5RTPrWmA4+uzFOZRzgKlgQb/u5CGrRB/hea8pVFv/V8Um1GtSJ6gIrFkLFt/5TrvddQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729143687; c=relaxed/simple;
	bh=jZ5JXoMpC6BApjj14bDc6X/KolISUFF5GKAiK6U9fBs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VTkYEajJ+WdVPf/vdNYwJLZSrS44MthDKz/507/Oeu+pZ6BmTAas2aVY5zDDrzWHpeLcOOYQDY9zmOnf6CCNw6i8qfh7nyNqhqG8QsnfpSOnt5knvuCUNoz67n8eWxCNcm/S/BGqQJSDPLP1DtnEefILNbBBHQE7xbx0+atsx0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=j6GiaPq6; arc=fail smtp.client-ip=40.107.243.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J+db97TrFqukpeloW8Vdsert25xBvMYt5mK1Vw+OERYa2qq+WzD8ftN1GpNhGN6LBWLTM7KL1PCpsvZpDHVvLLDUG6pq30FITEN8vSfCWrdSEuQ6sRbm66YVP++9NLkRhWUrCYZdez8ervpmIx6xK9WEb9rMp4bxZ1YPWE0Lny0A5l7pDPiuDRI3dS1pShCi8+fII+Nlb7xpw+8JDENtuI9wAh7AfVqeqAEAfyNTyTGdK6DjtLvn1aEWXvGkTf7+dh8jrATF2x2BwSQRASpUv+JqMHqvaPBMDiDreCU6SYYVVKpMav37jImibLLVphZAVXuzcbrK8ELEhwMpT3ZsTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ddgOrU+Tz4uN3jKaCh3+P49Xv6ph3bimdKDgzkvibXA=;
 b=RDJMVsiAhmRhJNlL1p2zzy1IUvqjRaoNv610i7AE5nzX62XNo5BWOiDu0m/SKz6B4+vEtZHQUiAgEchaws2N7cZSJArDz2KHsTGxMrMWybQ0M8zqb/grqjNoTCr71Pa9F87q0Y8nalGaqtzCkTEkarzbtnpe6iYYOoKcAIupkLuXMdtQFG83NoOek0Z1lSJJHqVFVZYRn5oBj9p/GNRUEBbxN/En8/wzTrw//BbNfmw4iluefbRH5KgvT8gCJwv6o2lUMFQHdnuVQtXH0g7/rEoS9P8x8+f3OMom9KYIqvzUFPCIkluT4cYpV5iToG59A0cRlJdA+1owHLC9WM5apQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ddgOrU+Tz4uN3jKaCh3+P49Xv6ph3bimdKDgzkvibXA=;
 b=j6GiaPq6jEzDWNv+J0BWzin7hlB95ah4I+F5bCiHKzbQA3a0d+euE9IPAJZGBmjzmCO80pdDBo7ER0puVt8Pc/iwDmue+C2rrAoQ0P+bFiwVm+F1IIvLIrfMIj0czCkOnbmvHtOFC2MXrRHfBKK4QaLMBRVIeDFzh5FJJFZzzEA=
Received: from DM6PR07CA0123.namprd07.prod.outlook.com (2603:10b6:5:330::24)
 by PH8PR12MB6699.namprd12.prod.outlook.com (2603:10b6:510:1ce::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Thu, 17 Oct
 2024 05:41:20 +0000
Received: from DS3PEPF0000C37E.namprd04.prod.outlook.com
 (2603:10b6:5:330:cafe::1b) by DM6PR07CA0123.outlook.office365.com
 (2603:10b6:5:330::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18 via Frontend
 Transport; Thu, 17 Oct 2024 05:41:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37E.mail.protection.outlook.com (10.167.23.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 05:41:19 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 00:41:16 -0500
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <gautham.shenoy@amd.com>, <mario.limonciello@amd.com>,
	<perry.yuan@amd.com>, <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Dhananjay
 Ugwekar" <Dhananjay.Ugwekar@amd.com>
Subject: [PATCH v3 2/2] cpufreq/amd-pstate: Set the initial min_freq to lowest_nonlinear_freq
Date: Thu, 17 Oct 2024 05:39:30 +0000
Message-ID: <20241017053927.25285-3-Dhananjay.Ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017053927.25285-1-Dhananjay.Ugwekar@amd.com>
References: <20241017053927.25285-1-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37E:EE_|PH8PR12MB6699:EE_
X-MS-Office365-Filtering-Correlation-Id: 9763d0ea-924e-40d4-6674-08dcee6e53a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|30052699003|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K692eTuyRSWx+QUVO1yjrVjmM98GAL3Bv7BXtpOIZcPUHQf6RF9h3OqxLNDw?=
 =?us-ascii?Q?w7DbTgpPhdniY1lhRO8bazgo539FAHzdHKnf7SLSUe7zx/muWp8yfsGPQhc9?=
 =?us-ascii?Q?lFBf0jfeQQvkrXER3mxxj7fJJ7+3RhiZxpgEFqJSf1fmlSagIL244IlNPijc?=
 =?us-ascii?Q?ljamrkWPGG1tStbvTOZPFEMNmjMeTralWqE58LVwVeaiLZniCG807qghV5QW?=
 =?us-ascii?Q?ZQ1F/vIY4oaOQHis+FpidId1VCE2nt40dqwte3CywBQ0SgpO6MY3BII1udDo?=
 =?us-ascii?Q?Ip8juPPddl6zN/X3LhrhQ8IdeW+DXUc5B/mZoMQF1dtySNQ+gyfvtv+hEwGu?=
 =?us-ascii?Q?eUAmGFIGYxvqT9Lojmq7nTJyDbjy3rDKWKskPW6mK30je0zuIN7Mf5bE5xGM?=
 =?us-ascii?Q?S/yGrjHq+bt9LB6WHY5NRYkA4KwqZe889i8e7u5sRjyfC9J/GobYoYFuSdN4?=
 =?us-ascii?Q?qHFY9Xk0eqsjTFUiR0sK9FnGapAlolC3SLqgkP9wyiGCvbwAuZ43rqmn+6ee?=
 =?us-ascii?Q?lNfy3vrkFdmOyXzkcCEUAiJJSFiyPoZtjLXq4HHbddGFjDH0H+9IVtoZXW8i?=
 =?us-ascii?Q?tWCPiOOtwReayvbrCpNVmYFjJt+bU1gYuN1mHH5GQ5HYhnUij1xihzudSpvV?=
 =?us-ascii?Q?lM0wI6EkX8igsi/uNdH77AysjvXowMjf5EwEJH1s6rIKH56UaRBVJFXCgBvo?=
 =?us-ascii?Q?o07mye2Cd7j9X9qpQPfVJbVY/C1Axbg1Dur5kAt6cw21WuDth0587knOHgUk?=
 =?us-ascii?Q?HUFS3KMeg18bX1aGLrYO1v3Kg+SQ8VmKtGOUg/uuA8ha1p7cEAPGSZP1vmFe?=
 =?us-ascii?Q?kwqUNUFYoCCQWQg2IgI2fjsLYtfn9COZSClPKGkzW7e8I3a9qH7HPf9zjst9?=
 =?us-ascii?Q?VuIR3+AjEN+nxSvt7NZtXK9oWie7OjGpPPdTkmGrd1vTN86bWRgm3EfV9o1/?=
 =?us-ascii?Q?EcfDr3/b2W2aMcWv6nWtZQQKQbdta+MelakRljWq3QWGI4oOT1nriXhh9cv2?=
 =?us-ascii?Q?7+TWNLqw5u9dfeOTK4PRqQCO4NCvnvEjhm6etYVMjuBrbtAszsUBbMJ9Wu6M?=
 =?us-ascii?Q?bBattJ958EnUc78lD7q5MQYqN8TI9B1mKgWAyGRyykwtsylIKfEyjHWhI7gP?=
 =?us-ascii?Q?0N2Eh1TNEPQeVz4aetwDkTkDBWC4FVER1hTzubuxvQ0WI83Q6rdSBGmKSaHd?=
 =?us-ascii?Q?AXuJAzs5CXkJxR8UU0LorE+jxF17QJIVn+MVHpBt/mpPeRqouQBfO+FTUh/d?=
 =?us-ascii?Q?T+5i8KBSULEAPhtMZBB0WpZrollvEdWrgRxWEq3JnbmxFS5uWYnd2/9XegOd?=
 =?us-ascii?Q?dsGntFuIcNhTqlExXZJGn7yMXS2qWLuaLldUFOCYXkQjetoDmnHcqDfe0jCo?=
 =?us-ascii?Q?NXZmuuaW60RhVJZx7l0xD1Zgf5zhh3Wy4DXP6teHkOipnJu/dw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(30052699003)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 05:41:19.5639
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9763d0ea-924e-40d4-6674-08dcee6e53a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6699

According to the AMD architectural programmer's manual volume 2 [1], in
section "17.6.4.1 CPPC_CAPABILITY_1" lowest_nonlinear_perf is described
as "Reports the most energy efficient performance level (in terms of
performance per watt). Above this threshold, lower performance levels
generally result in increased energy efficiency. Reducing performance
below this threshold does not result in total energy savings for a given
computation, although it reduces instantaneous power consumption". So
lowest_nonlinear_perf is the most power efficient performance level, and
going below that would lead to a worse performance/watt.

Also, setting the minimum frequency to lowest_nonlinear_freq (instead of
lowest_freq) allows the CPU to idle at a higher frequency which leads
to more time being spent in a deeper idle state (as trivial idle tasks
are completed sooner). This has shown a power benefit in some systems,
in other systems, power consumption has increased but so has the
throughput/watt.

Modify the initial policy_data->min set by cpufreq-core to
lowest_nonlinear_freq, in the ->verify() callback. Also set the
cpudata->req[0] to FREQ_QOS_MIN_DEFAULT_VALUE (i.e. 0), so that it also
gets overriden by the check in verify function.

Link: https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/24593.pdf [1]

Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index fa16d72d6058..833fc17a39f2 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -529,8 +529,27 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
 
 static int amd_pstate_verify(struct cpufreq_policy_data *policy_data)
 {
+	/*
+	 * Initialize lower frequency limit (i.e.policy->min) with
+	 * lowest_nonlinear_frequency which is the most energy efficient
+	 * frequency. Override the initial value set by cpufreq core and
+	 * amd-pstate qos_requests.
+	 */
+	if (policy_data->min == FREQ_QOS_MIN_DEFAULT_VALUE) {
+		struct cpufreq_policy *policy = cpufreq_cpu_get(policy_data->cpu);
+		struct amd_cpudata *cpudata;
+
+		if (!policy)
+			return -EINVAL;
+
+		cpudata = policy->driver_data;
+		policy_data->min = cpudata->lowest_nonlinear_freq;
+		cpufreq_cpu_put(policy);
+	}
+
 	cpufreq_verify_within_cpu_limits(policy_data);
 	pr_debug("policy_max =%d, policy_min=%d\n", policy_data->max, policy_data->min);
+
 	return 0;
 }
 
@@ -996,7 +1015,7 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 		policy->fast_switch_possible = true;
 
 	ret = freq_qos_add_request(&policy->constraints, &cpudata->req[0],
-				   FREQ_QOS_MIN, policy->cpuinfo.min_freq);
+				   FREQ_QOS_MIN, FREQ_QOS_MIN_DEFAULT_VALUE);
 	if (ret < 0) {
 		dev_err(dev, "Failed to add min-freq constraint (%d)\n", ret);
 		goto free_cpudata1;
-- 
2.34.1


