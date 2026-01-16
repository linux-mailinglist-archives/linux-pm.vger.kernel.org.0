Return-Path: <linux-pm+bounces-40970-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD91BD2C96E
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 07:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 313CB306AE44
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 06:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E08347BAF;
	Fri, 16 Jan 2026 06:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LUztfe7E"
X-Original-To: linux-pm@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010054.outbound.protection.outlook.com [40.93.198.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA6534A77D;
	Fri, 16 Jan 2026 06:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768545194; cv=fail; b=S7MwzJMy3YdKtK1u+LvbIxri/pM7jiGkqDIEUoT9+SYlxXoRaBkjzWSX7TCchf4ODWV/1mOesmJidPHC6ha8d4LaP3LAQB53rXyDWuiVtsWMKkCz8YJl/4TC1NRBRYNZ20Xhr4mKJjN8JnLyqtPyH8iWe0H/egvArKF3nwXOX14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768545194; c=relaxed/simple;
	bh=XRuclMgv8KM35SzNft+ydzpzmQMeyTpDwQsxrT7Ws1c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OT9h9Cc0lZXcXJcQcfk7wHmqo8123d4gpW8tY/4/PokGvePHL9AIgP59bVkSkdQsP0tnBjLaAKiV6ZZsanXflaCt7OfM7FvdZQHjlqsVugwcelrA+ecpDdFTg7EoNIw58cpZQ9GH8NytO3pypNz321UJB+kQqCTKGKo6pAkdZdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LUztfe7E; arc=fail smtp.client-ip=40.93.198.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PL5AT8a1hCg7VnHdmvEZa/O2YemEBxPAre11i+/7vXrLfbfflSSCp3dmq9p20hfdxsC/glE9EoGA8eWBUBE/hL/SK6vbI2Cc/pzFWdWgGYTsU+M7chubvCKVTaRZQQu/GqeD/N7U3+CaXkOA0i5uaET+qY1UQ9tbHKuxh/uNGc2sOiU+L/+yDVJiE5YrVkVebDosBUp8BcehRQjuh+jufqmrNj2wf2u2SceCKvJ6hculScsQan9pbEVy9r24PHi6ShPx5dryrd1fkQwQ5gNYtErqUOMt06WUpzC97oVB5F0LEF8X4omaDeU55B5BlJSK2IJ/qofu3FWCYNkTysUq6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b3SGgtFt9Y7mY8SH1pFriQ1e4DcRfV4nND5KOIAwrJA=;
 b=Bm6JLFLSGmfFPt35uYB4HoEzR/iy9Y1T52F8qMD23b5YCXxUFRqMIBopLgfHCoR0c9mxmBsR+kfvDclGipM0LoVN2kBeIIWy6wFS0ENz07sqbGhAdvidPQ8saI4lJ6QTeqh80KyIS75pStMo8G/qreyD8gUz7N3siGXaxA/4v51q3XS7SWpzvzfb2IdCL6mCXW6u5za+I1lVy7Tlnly1pvF6VnVBSOjgf0eGjBRNMA5JmIp2RU6Mcbyhxx4pYcZc5xeLAdU+eHZSMhPDPNrPfNBiQAamxL7HJ1zE2I6Pkjf4qdksbz6QB//ALoa3+ykkktWukAAReOIuUiBM5jAYfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3SGgtFt9Y7mY8SH1pFriQ1e4DcRfV4nND5KOIAwrJA=;
 b=LUztfe7EjyLk06V5LFI51jdk5T9uzrGAtmalawGf710w+eZ0HgsWjmOgHeLnOWlcmmgSyXO9Yy73rZNnoC+M2X9FNNtjfvLF33vRP/dR9vhJom1h2TljPsr5zMI7FBOMgVcAWOEooV6BGnkrmDn17HmnyB52jHGx5best2PG+EU=
Received: from SN1PR12CA0093.namprd12.prod.outlook.com (2603:10b6:802:21::28)
 by MW6PR12MB7071.namprd12.prod.outlook.com (2603:10b6:303:238::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 06:33:10 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:802:21:cafe::c) by SN1PR12CA0093.outlook.office365.com
 (2603:10b6:802:21::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.7 via Frontend Transport; Fri,
 16 Jan 2026 06:33:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Fri, 16 Jan 2026 06:33:09 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 16 Jan
 2026 00:33:04 -0600
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy"
	<gautham.shenoy@amd.com>, Mario Limonciello <mario.limonciello@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, Srinivas Pandruvada
	<srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>,
	"Sebastian Andrzej Siewior" <bigeasy@linutronix.de>, Clark Williams
	<clrkwllms@kernel.org>, Bert Karwatzki <spasswolf@web.de>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-rt-devel@lists.linux.dev>, <rust-for-linux@vger.kernel.org>
CC: Perry Yuan <perry.yuan@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>
Subject: [PATCH v3 1/2] cpufreq/amd-pstate: Pass the policy to amd_pstate_update()
Date: Fri, 16 Jan 2026 06:32:33 +0000
Message-ID: <20260116063234.24084-2-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116063234.24084-1-kprateek.nayak@amd.com>
References: <20260116063234.24084-1-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|MW6PR12MB7071:EE_
X-MS-Office365-Filtering-Correlation-Id: f1da2e51-b17a-4a2c-7324-08de54c91dc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kJ1Vt1vANJutg+cjY8P40ESfkCqnTlBNed/bSrSwkaJN8bsSb9AMcrjGQyZd?=
 =?us-ascii?Q?0gvqShxYNqa0WXZIoKSD6zOht+GMYEJIOZb20hSZvuQP+aK8w0Dey/BGAbjX?=
 =?us-ascii?Q?YorGQ0+GlXe73osXOPW4LTDlJc/stemQe3bX0hNhnGx5WhuBRVaDYHfY5yWD?=
 =?us-ascii?Q?0vlYkeKBBx/V9jYMlmLuBne0RETwq6Oar1NUw+ftat1pZLDz9yeemxKWmtay?=
 =?us-ascii?Q?dp5RC5YiHAAIYxt2mkXMgRKYFdVQUbLBxoYEJbD8TQLc6LHp8iXDqVQzltYQ?=
 =?us-ascii?Q?QzS4lOOzqBfmbz6J/man40ipUlrNn9OcV7PJqy7I3mdDU6KAwWKPDS6EmfDa?=
 =?us-ascii?Q?f8hvcCGZLG91mFodMPDCdelpIw3uNwsuqJXxW/p82sjxUIlBG8zYLKg6OyQl?=
 =?us-ascii?Q?NHdA9K2cFapvM974qTDyLmPovEWieNK7H9qgYBvd+EmVdh680o6Soe/XqKhK?=
 =?us-ascii?Q?H5gshgy78r31/+An8jJA3hkC4svT0+z6EXgEfuyTenBz7L3BAJzlpm3humEm?=
 =?us-ascii?Q?ejwd31jBWXbRImjSY8w8ebq/PrgqHOBL/pkWI3Em1o6vB2r6hjrb2tgWjid1?=
 =?us-ascii?Q?rj2hScA3nNzWkjYzE8D6zztTOthQsapePikunw2BGRMTSYx93KFJJk4SycV0?=
 =?us-ascii?Q?84Aul/OndYdqCLr4Wk5q/RBaP8ru6qHrLGGnARvH9J/VtDevwdKXaHZBnHvm?=
 =?us-ascii?Q?C3YB52CCbCZXb5WXMAaoxwMKP42VF/4ZdHjQ2OZAC1VUJhbxHRzx5Kmb1Mh8?=
 =?us-ascii?Q?Zx1KAI7O7iWunGzkj3N7/Itb2c/jSJJSjCvvOszrX0QmucjPgwh0Q3BkfgAt?=
 =?us-ascii?Q?YdyzsHTNK9dmtGd5Ct2OlogpLaWCMm4qFqw/mKtl/dSckGMx92HICandgjQb?=
 =?us-ascii?Q?HyYfShvkioNrcByrIo5zRckgT845VsDKFz6pdKzWoULfGf94wk98EDunQRsS?=
 =?us-ascii?Q?ldU9I1Cp9DpsGP3Dbt4C++rC6nviri1h/wlXn9UJdmQx5CekrWTuMLwfAWue?=
 =?us-ascii?Q?RA2GqPUP3PU9BAlIDeQoT0YzHmXPtwBiNrFPEMqxeTHENDpMzqT2U0zX/12X?=
 =?us-ascii?Q?GRTsM7MSM9lS/00JXz0fjS/3TJjdsh08VZDV16JIS6KyFzghFs3OmX9IHOiZ?=
 =?us-ascii?Q?JAw69O/SJN31yXxisM6IHRVdTZCvtYS8rkxp1Y53WaiJ08iSt60pTx6Jj4Db?=
 =?us-ascii?Q?XPWyDAfoTtgqlCXnz0NZtzw+AZdfETG1IYYl2ldp2P78PWjUYvQD+x62iMVr?=
 =?us-ascii?Q?nBQLRpbLAEcaS9ohnpuaP05D/h8zk18ruUWyHJLuV7aWNo7ArUk6VXGKfe5D?=
 =?us-ascii?Q?McNyBw8K9/bRfAL6kZW2sQhAqcakTvS7ibIejX0YjKxtxdNcbGEepoHXsK6k?=
 =?us-ascii?Q?Hdi+TD2GosVQrbUbUgPbBCPNMyvHMy8/BwfDjeWpDCa0gLnMTgwRe04RVjCK?=
 =?us-ascii?Q?DGYi+nk57c96/rt1VoALXQCMnq7LWo+bOuW92VLDi9txpCjD0YAdcH1lIQdn?=
 =?us-ascii?Q?4bp/F9Fk8qK1nQrbovnIrsaXof3jH8ia1bWHqXBbKXq6b6i+1MQXK+W1MEW2?=
 =?us-ascii?Q?+edYwhAi657LDTE0r+TghI6ONjnjga4fWLxeNy5Xysy5w4dJOzCyQvtVtKI0?=
 =?us-ascii?Q?Lbhv/qqp318AjKU91oxxDEc3SQ1j1uNjoNgjAzIZ1VC/sxES9yEXAKwE8kgz?=
 =?us-ascii?Q?Qg6QUi9kbMoKaiFAUhTa8JPXR9w=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 06:33:09.7415
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1da2e51-b17a-4a2c-7324-08de54c91dc8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7071

All callers of amd_pstate_update() already have a reference to the
cpufreq_policy object.

Pass the entire policy object and grab the cpudata using
"policy->driver_data" instead of passing the cpudata and unnecessarily
grabbing another read-side reference to the cpufreq policy object when
it is already available in the caller.

No functional changes intended.

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index c45bc98721d2..5818a92d96b9 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -565,15 +565,12 @@ static inline bool amd_pstate_sample(struct amd_cpudata *cpudata)
 	return true;
 }
 
-static void amd_pstate_update(struct amd_cpudata *cpudata, u8 min_perf,
+static void amd_pstate_update(struct cpufreq_policy *policy, u8 min_perf,
 			      u8 des_perf, u8 max_perf, bool fast_switch, int gov_flags)
 {
-	struct cpufreq_policy *policy __free(put_cpufreq_policy) = cpufreq_cpu_get(cpudata->cpu);
+	struct amd_cpudata *cpudata = policy->driver_data;
 	union perf_cached perf = READ_ONCE(cpudata->perf);
 
-	if (!policy)
-		return;
-
 	/* limit the max perf when core performance boost feature is disabled */
 	if (!cpudata->boost_supported)
 		max_perf = min_t(u8, perf.nominal_perf, max_perf);
@@ -675,7 +672,7 @@ static int amd_pstate_update_freq(struct cpufreq_policy *policy,
 	if (!fast_switch)
 		cpufreq_freq_transition_begin(policy, &freqs);
 
-	amd_pstate_update(cpudata, perf.min_limit_perf, des_perf,
+	amd_pstate_update(policy, perf.min_limit_perf, des_perf,
 			  perf.max_limit_perf, fast_switch,
 			  policy->governor->flags);
 
@@ -737,7 +734,7 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
 	if (max_perf < min_perf)
 		max_perf = min_perf;
 
-	amd_pstate_update(cpudata, min_perf, des_perf, max_perf, true,
+	amd_pstate_update(policy, min_perf, des_perf, max_perf, true,
 			policy->governor->flags);
 }
 
-- 
2.34.1


