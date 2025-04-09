Return-Path: <linux-pm+bounces-24977-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B10A81B5D
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 05:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76247175E69
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 03:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF691A2860;
	Wed,  9 Apr 2025 03:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tdw0ORnK"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B247F4FA;
	Wed,  9 Apr 2025 03:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744167639; cv=fail; b=CkwAStIYPm06gobGNaMahfl8zf9fwghz0IcHfA+gh6YfOk9Tg2yWAcX/mQmN9u9jHk17+QM9Dbs353dYBZHcKkC/ur/Zagi7xQ9xAxJJsXeOzDrr38fXmQeB7V9XPbULJcXdo9bdbpmwINRmSLVYgVDYIVNrmteEacAEcul8rZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744167639; c=relaxed/simple;
	bh=90T+wFxv2C2KtyvItgqtrTLVOMXOqLRe81BeieG31Wg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ibdu4waGR+0vVxyGxSBRitAjEJ7iEYgao1IKWQ5FQ2YLJn41blBQiCkTNddGZmnfWJF6m44QpcHkUiJZ2cnvJrP7dn71U3T1HJm9LAW/0FAiHujtm5HctPEfBOVKxwccxs7qd2f0Yaya21LmJPduqPUuTt47LugDkg3b0l4f+f4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tdw0ORnK; arc=fail smtp.client-ip=40.107.223.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dDKSR2HIQ+VIsDLTzNULJkKw3tkv756DZJYdsALjOiA2V0JIWYOldCrzrnIe2q1q2j0gv/hqj7gfgl7QmwaZOvxQdbAhRGCGqPhEv4ET3oxQjB06WT4EXfdNX+qBOEIvT8i40IUhul13ijlJ4LDh4pHdlZRG9UsWyPQgGTkr23OguK/FvRCmbAykp3u+WumjuhC5YytKF1WOySyZckuPp+L8XUUZK59NEpwwT1EXuaAq72gLJlOboOBgX9lD8tm9wD7fMV1/iAcWQhZ+z6eWaw+BhdON87ItxMcsVPXBC3QR00njfRS/SqrBY6B9miV02QafDEkpnf9nQNklW54QAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZeWuLAqsiYFUwqQqXKwaP0nUV6MhZTCyUaW4Uof4IRQ=;
 b=XZFFd1ox39lSbGVHZzs0zNGeAh35Mnynvx0J47GB6HjkoIg5niqdn+jV5ozrlcRAEoqtMK4CoFgBqIlU7AbQYo5gN5XRkN/WygNjs3HqA7ApK8XhtB4mf4E6CWy2QBK5BS0hBmTUHSUDzepIem8n9D+M3Uex7fDToRH+mpX/KfDSzIIh785dve3PBwzTmgbI9zIcKW2JvjA0jaeijWlKPb4KGbqluFSenUECdBfeZwPP6VAJdOuwMuC3TBSWbGrwdTurQXCMMWPAG2xDG3ZDDDyOnv3lzRQMKCFUMR+J3bYcCFCNFjGMGPaKNmoTDv/eFm87en8lzXwSJASjHrbRlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZeWuLAqsiYFUwqQqXKwaP0nUV6MhZTCyUaW4Uof4IRQ=;
 b=tdw0ORnK/eXaWmLP/1d7vn5iC0Mn/XBOk+21ULojwPrRg5qIbXnIwbVR8Hpls4rl+zEaVdZZlzobpObKsNXaK3MO9PPmuy6Pqei5qjtg6ieb433FQGlr79WcvLNxj5FFdu0mjGTXLYlVsqKx57SAFzQcSRGPZ2OQP78WwqlUxHs=
Received: from DM6PR04CA0025.namprd04.prod.outlook.com (2603:10b6:5:334::30)
 by MN0PR12MB5787.namprd12.prod.outlook.com (2603:10b6:208:376::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.35; Wed, 9 Apr
 2025 03:00:31 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:5:334:cafe::bb) by DM6PR04CA0025.outlook.office365.com
 (2603:10b6:5:334::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.35 via Frontend Transport; Wed,
 9 Apr 2025 03:00:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Wed, 9 Apr 2025 03:00:31 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Apr
 2025 22:00:27 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>, Mario Limonciello
	<mario.limonciello@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, "Viresh
 Kumar" <viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>, Huang Rui
	<ray.huang@amd.com>, Perry Yuan <perry.yuan@amd.com>, Meng Li
	<li.meng@amd.com>
Subject: [PATCH] cpufreq/amd-pstate: Enable ITMT support after initializing core rankings
Date: Wed, 9 Apr 2025 03:00:04 +0000
Message-ID: <20250409030004.23008-1-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|MN0PR12MB5787:EE_
X-MS-Office365-Filtering-Correlation-Id: e5b460d4-03b3-4c00-3234-08dd7712b0ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zw+hizmaEB88RqArBIGUgw+z62fC+XYgm6DCnvywdazSCnYWaRKrSnuXGa7Z?=
 =?us-ascii?Q?X2vX5VTlwOhFq+iY0LHU/Y2r7w5eCN8atOJJ7IRwdADrWw9UsfiUrjxBCdWm?=
 =?us-ascii?Q?Gc0+c6pd+wWoALslhraiDt8hJmIyRsG8BIzK0aFKYrXQEhkf+npj9msCPpJv?=
 =?us-ascii?Q?jq1NaH7+1Bylxs/pvAS3CdptVgSuz+3WKjj7yIvRRjs2AT7P2+jYgFWEMYSF?=
 =?us-ascii?Q?OwO9cS4/VTeIT47rfZoIxhDv0h1CznK6gr5h+uswghtiihHnKoLijb0NQPsE?=
 =?us-ascii?Q?wQEwq8B+LohXDQRfgKCLQZRlWZ/QnQr3laTN99syc7o5uveouZEbm+sQ3xhN?=
 =?us-ascii?Q?kjOO/yrHEBpIOyK+XS7v5u5729hscE9uQ+TMevWq74BJWJBPVI5J4OMNHC6P?=
 =?us-ascii?Q?2d5PF6x4bYRXDGXWtAZkCEgO8E+8L6d1EoM9nF44R9xBenpiC+28eIYUVuFq?=
 =?us-ascii?Q?s2BquexoCePPC3BxAIzQrL+Bye3jeaN917kno/UJWSxW5Qwtj/HTz1rIfpKg?=
 =?us-ascii?Q?XW37SAPTn5YfWknIMVclVgkmB0dfyX5aDwgETcU0OINfXb8KKahJ1xBofhW+?=
 =?us-ascii?Q?4W2moXfmTxRmH6KO+M8ebzuxSFK+maHiYnYG/+oDxbjQQNpH6JEIJxBVoyxL?=
 =?us-ascii?Q?bATub3UVY1ElE3qxW0ZcqJGXgnWAFUxDvxouEpITlQnFzqvAH38skt7B5YGj?=
 =?us-ascii?Q?3M4pAkdPQ9TatPy+N4k4cekgfj+9KJep8a4RyZ2i93yea9LuIVgho9qZ1Gb5?=
 =?us-ascii?Q?EYKnHeFqx/ngwHNnn+J6nAp6y6mptPAqGoQFJ/yqzuE70w+WNSV7gWC3iXdq?=
 =?us-ascii?Q?tk08rmFkdVo6eLNn9J2YGODIhbY7pRRcyBzRiR6BGN/CaAV1Z66/1batn2Nz?=
 =?us-ascii?Q?1ERo1EmBjfcBfz/NPOlZdGcfLSKC7/TiwaaY8uyIcL8+pHHfA0DiwVU9R7ca?=
 =?us-ascii?Q?fXDZste6X9kK27gvwBGdGcTK0+C7cmVrerSzniDRmOMIM6fz6PCpe3lvOyL4?=
 =?us-ascii?Q?8VpZIXkbNa/25Hfgk7cL4SzB5OSV/PKwl098VCuYFICBBcS9lqc/ep46UkLU?=
 =?us-ascii?Q?G1nAD0FeLyOZ/5BUy1YrYB/P6jwshTdp7C2PZ0r1U08L3ommYlJAkFGNH1Hh?=
 =?us-ascii?Q?F0RpCPx3BQH1ZlMBOKWtkgnIF+9/OX9e1X9w9H4Wpw7VYzow72HC8VnBTZMB?=
 =?us-ascii?Q?jfWQ1IwKC3C9gcLETBzjgkZls/h0r5UTgIY5IX4iFMp+aQWQefI+wGvZJK2K?=
 =?us-ascii?Q?0Bm7XPeCAole6OtPbO13sA3KdB67WodZy6Q2icM+wne+CkTVqKfQrIxF9nz/?=
 =?us-ascii?Q?FR9iynmv/STGdQcQCmiHIc1K/Cvsb3WGmo4iSOLk1X3cDM0BY1DP4TdX3prG?=
 =?us-ascii?Q?8UjyqjaLI0vLHT+R3HxRHUPDa6jkgD4Pt1F3bBAazYxnrUJBSNdPUKD0YsrZ?=
 =?us-ascii?Q?AenTLWpiWMQ4sjb58rRywS9sONKEo8JT7X1HPnA30yp5LLp4+1Cs6xLbbIXb?=
 =?us-ascii?Q?IEwkcKoNga6t0nU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 03:00:31.2667
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5b460d4-03b3-4c00-3234-08dd7712b0ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5787

When working on dynamic asym priority support, it was observed that
"asym_prefer_cpu" on AMD systems supporting Preferred Core ranking
was always the first CPU in the sched group after boot even though it
was not the CPU with the highest asym priority.

"asym_prefer_cpu" is cached when the sched domain hierarchy is
constructed. On AMD systems that support Preferred Core rankings, sched
domains are rebuilt when ITMT support is enabled for the first time from
amd_pstate*_cpu_init().

Since amd_pstate*_cpu_init() is called to initialize the cpudata for
each CPU, the ITMT support is enabled after the first CPU initializes
its asym priority but this is too early since other CPUs have not yet
initialized their asym priorities and the sched domain is rebuilt when
the ITMT support is toggled on for the first time.

Initialize the asym priorities first in amd_pstate*_cpu_init() and then
enable ITMT support only after amd_pstate_register_driver() is finished
to ensure all CPUs have correctly initialized their asym priorities
before sched domain hierarchy is rebuilt and "asym_prefer_cpu" is
cached.

Remove the delayed work mechanism now that ITMT support is only toggled
from the driver init path which is outside the cpuhp critical section.

Fixes: f3a052391822 ("cpufreq: amd-pstate: Enable amd-pstate preferred core support")
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index c54c031939c8..ee638589f5f9 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -794,19 +794,9 @@ static void amd_perf_ctl_reset(unsigned int cpu)
 	wrmsrl_on_cpu(cpu, MSR_AMD_PERF_CTL, 0);
 }
 
-/*
- * Set amd-pstate preferred core enable can't be done directly from cpufreq callbacks
- * due to locking, so queue the work for later.
- */
-static void amd_pstste_sched_prefcore_workfn(struct work_struct *work)
-{
-	sched_set_itmt_support();
-}
-static DECLARE_WORK(sched_prefcore_work, amd_pstste_sched_prefcore_workfn);
-
 #define CPPC_MAX_PERF	U8_MAX
 
-static void amd_pstate_init_prefcore(struct amd_cpudata *cpudata)
+static void amd_pstate_init_asym_prio(struct amd_cpudata *cpudata)
 {
 	/* user disabled or not detected */
 	if (!amd_pstate_prefcore)
@@ -814,14 +804,8 @@ static void amd_pstate_init_prefcore(struct amd_cpudata *cpudata)
 
 	cpudata->hw_prefcore = true;
 
-	/*
-	 * The priorities can be set regardless of whether or not
-	 * sched_set_itmt_support(true) has been called and it is valid to
-	 * update them at any time after it has been called.
-	 */
+	/* The priorities must be initialized before ITMT support can be toggled on. */
 	sched_set_itmt_core_prio((int)READ_ONCE(cpudata->prefcore_ranking), cpudata->cpu);
-
-	schedule_work(&sched_prefcore_work);
 }
 
 static void amd_pstate_update_limits(unsigned int cpu)
@@ -974,7 +958,7 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 	if (ret)
 		goto free_cpudata1;
 
-	amd_pstate_init_prefcore(cpudata);
+	amd_pstate_init_asym_prio(cpudata);
 
 	ret = amd_pstate_init_freq(cpudata);
 	if (ret)
@@ -1450,7 +1434,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 	if (ret)
 		goto free_cpudata1;
 
-	amd_pstate_init_prefcore(cpudata);
+	amd_pstate_init_asym_prio(cpudata);
 
 	ret = amd_pstate_init_freq(cpudata);
 	if (ret)
@@ -1780,6 +1764,10 @@ static int __init amd_pstate_init(void)
 		}
 	}
 
+	/* Enable ITMT support once all CPUs have initialized their asym priorities. */
+	if (amd_pstate_prefcore)
+		sched_set_itmt_support();
+
 	return ret;
 
 global_attr_free:

base-commit: 56a49e19e1aea1374e9ba58cfd40260587bb7355
-- 
2.34.1


