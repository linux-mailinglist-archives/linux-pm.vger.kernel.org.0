Return-Path: <linux-pm+bounces-40801-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A346DD1D4A9
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 09:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E3CA307EA0C
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 08:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7DF37FF50;
	Wed, 14 Jan 2026 08:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Mdhmx3hT"
X-Original-To: linux-pm@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013055.outbound.protection.outlook.com [40.93.196.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4844237FF47;
	Wed, 14 Jan 2026 08:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768380735; cv=fail; b=AEBaZEZd+cRiki0BV/ti3A17dIE9BXEUSEJyAuJfA4aTTDbVhQz2/jJYazpUIERNYdFJeJAQIgCdAJCFyEX1YCO6oRwSfMMq6LkndJtFyVVjmpd8oh8i9dDVvUWbH8szwN/bVyH1WATYs8+ceZaiUewHtr+I9fTwFWPYcKTQFP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768380735; c=relaxed/simple;
	bh=tle58Kc0I6NXKbXsyNREy/mtMI/77jPPZ5Z4HY6z1Ms=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tmd+TWLR13S2kCIm+V5ikMANZuGy+mLT/5lmxiCvKUuhC7+Lpv9w4Tllaed+M13rzDVEHDliiNm5HX59XFXM1Z9/iFIC00AemLTkiwHMy7C+MIGenoxRVDay9KH/ZNAOYlPGnY/4btpDiIrd5QAScSWFBvYH8T6xvzaAuaHqCPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Mdhmx3hT; arc=fail smtp.client-ip=40.93.196.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QV4PnE0tzR31lvyiJud08FzYAZIfmlvUJa2NTD6B6q3VozJadftY7YnXLmoEOR/0nKgH01M0cFutVE2JfuuQ8AB2y7wKNTeMXjxYHun2dnC3GjNruvGj2QcumlEYgNTCq89kz0fYGo1P/9ci4qavqe54geaxxKKKwZY8CitQQwM7tRZn/APz/5giKIj+BLbQvLymLf6+IN+mYF2JwnamzL5OKVwWWKUidI03a3FXBhwY1h193rQ/wfU3f9imox63PV1wMf1dvRPdKOoWpaDcOtEeCHhaDpyV3S9i5bMHQWC6uSO6F2vp9DdYyPzviuNcAPMeG3YZCPJL09Qp8tbTIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ryent273MMvVf2E+DIq+++8knFWywHic5s5u+vLnPpI=;
 b=cRxXLdL76YfFQzqw72lBw6spFR9vFdRIjd9AAx8TQJAwlm6HNJChdlile5jOVfUQYsEW9tnIg6XjqDDPqZFrG5xAycRDA0/Em3xGKxqM8o2yShYnax7uqWcRNSq0463NAlSybXKAgGURtjzkuVk80EO2h596nPdA6VS9wREwczvmuYN7qRUGWQ1BMByxZHmQwvgbYw6Wq5WvbRTvVGi12PFVCkkuDpVa1VnRMFmSK2J2WpsGP8Sw2aLsImxME8QzwljGL07Qx0HKMijwg/JhIEqqTk5+iDpoLDWtzlgi6xnfWx80fyYdjC9Fd6zDPf3/Sh1Pxo6+zMineuyvEZuBbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ryent273MMvVf2E+DIq+++8knFWywHic5s5u+vLnPpI=;
 b=Mdhmx3hTSQEAgefh/zRkv0445AQu9uqN82q96ioO3OjIYC6QfuxBururjiVazofPfAbpXqkIk5Hi/f0ujTQYqvWHS4NE+jal86XpkFYzgD54fnQF1WSdNRwwho4MkhIS+I56gqiJ3yFOnxTThaeLG9h8+eO258tyFPpGe9nQfN0=
Received: from BN0PR04CA0182.namprd04.prod.outlook.com (2603:10b6:408:e9::7)
 by CH2PR12MB4168.namprd12.prod.outlook.com (2603:10b6:610:a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 08:52:06 +0000
Received: from BN2PEPF0000449F.namprd02.prod.outlook.com
 (2603:10b6:408:e9:cafe::e5) by BN0PR04CA0182.outlook.office365.com
 (2603:10b6:408:e9::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Wed,
 14 Jan 2026 08:52:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000449F.mail.protection.outlook.com (10.167.243.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 08:52:05 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 02:52:00 -0600
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy"
	<gautham.shenoy@amd.com>, Mario Limonciello <mario.limonciello@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, Srinivas Pandruvada
	<srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>,
	"Sebastian Andrzej Siewior" <bigeasy@linutronix.de>, Clark Williams
	<clrkwllms@kernel.org>, Bert Karwatzki <spasswolf@web.de>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-rt-devel@lists.linux.dev>
CC: Perry Yuan <perry.yuan@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>
Subject: [PATCH v2 1/2] cpufreq/amd-pstate: Pass the policy to amd_pstate_update()
Date: Wed, 14 Jan 2026 08:51:12 +0000
Message-ID: <20260114085113.21378-2-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260114085113.21378-1-kprateek.nayak@amd.com>
References: <20260114085113.21378-1-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449F:EE_|CH2PR12MB4168:EE_
X-MS-Office365-Filtering-Correlation-Id: 861129e4-0c84-49f6-da0d-08de534a3199
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|36860700013|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D2N/fQcm7sLV7w05M+svg2fkiNpzdxqRSTCgdx75pUIyt/xD7sjnW8kQcv6A?=
 =?us-ascii?Q?I/IrhnKj58QGfzUAPw3UQ6doje2iOnSWmBdOtKHl3Wg2ExdGlLhtSPsKonry?=
 =?us-ascii?Q?zLIF9qiGXO1mriD32EFjWvqzuzwUysZLRHrkxVZvdG63pwbMoyejQ9ZHd3Qt?=
 =?us-ascii?Q?QOh4cwnx4BQzyy20irJGz7BCL3dAxH4JYD1h2B+3t278VrcbaQGTdiQQ3Rvy?=
 =?us-ascii?Q?b3+Bs3u/hFmMJmYScoqFswUkI6WZCDJprycCNfpijTqXre1KoVWO1S6iQx8u?=
 =?us-ascii?Q?z0eGzEPmnHvl1f79wl/yE4T4Vo7y1srbZEfgaQ8esmFmZGY/8BtDLj2sFN5W?=
 =?us-ascii?Q?d/kr0SzRzrZJFdMQorcKAORmDDvQ1x8VjYxPYBP5GzgbhN+S4c+3XBtf+pkr?=
 =?us-ascii?Q?oMkKqQ6b8hVY5pXfuJ7hIWP0u4PqwiFvNmbhqdVH/8g70tb73SRW2mobZAne?=
 =?us-ascii?Q?ODQzw8QZMWVe680Qqug9y1AYo/OubHUDMoRrBuyVX5BCM9k9kSEwvbG6md4j?=
 =?us-ascii?Q?i1ux4ED2JKKYWel3CY02hg1q/m0X3S25H8NyTbhqX+3rssDsYC8iqlLib+So?=
 =?us-ascii?Q?vW2h4DAUmKcgbniOjfMmiJV1Jao9nJFslnqFI4dwK9Bn+Rr8lC4i0kwCA5MY?=
 =?us-ascii?Q?KzK3YmQ4OZc/PEZk1sAB/10tqO5c/SxxJVceRotHaAjK7/MrpW6wt3s/yCLY?=
 =?us-ascii?Q?62Sfw6PdeWKnfP8dtKm+iCiqLG5XHCxwuI6JRwHdbaqOV6PkQSskhxI+ymGv?=
 =?us-ascii?Q?Id6uMp/sZmc+n2ZAbFFySr8dQYX+zz2wDYJeXoOBt/IGvzyak0R+2pzqXZFF?=
 =?us-ascii?Q?qWOWWE5Ir3qJeVPSRTU8wpxhgcWqLM8SqtfU0KqMdTpQd5VPYtNYdMRkSnu1?=
 =?us-ascii?Q?VXe4i1d7E9WnjJKb+IBZz4Sf3BQKoteOsy++xNLg3k15gNjaJRQ4ZN5/mha7?=
 =?us-ascii?Q?SjEBdeHq5HIainxNHsP6Qze9GHhaeBUD0bdR0AxHTXoEDsDSLFVthyxrH/KJ?=
 =?us-ascii?Q?7a0fv8qlWQfmYh/aJRxARJmeS1tZbLUyHg5/moi7KGD2XoWb656kvIdYS3Uw?=
 =?us-ascii?Q?QbRakPJc3/XvOPvZehoDOyrDE5YN4pu3BSGhNUoLzPW2NxtLQt3MjMNyFxeF?=
 =?us-ascii?Q?yaIbplzccmne9SBgzn9MWh8m8TgTORkdwfe+LbU80oEICOV4Aft1vlvxesce?=
 =?us-ascii?Q?1sJNm85yAU+0EmyQyP9lvEJF5+FRIP9MbZ4lrxkBT10HpQjcxWrW+lgi04bt?=
 =?us-ascii?Q?eHC5wXNwHK9UmtVLfMHtB88idyxU/D3qStViqZHvjUod2KhyKvldVqtHi9hA?=
 =?us-ascii?Q?6lPeUvOxDAZXtMIbHQCDePt6dUZgHNFvnJ6Ds9Ebo7/c+wI6R5gYxFu0jkHQ?=
 =?us-ascii?Q?Rl2AsbICJeNXgqW8dFQqLGDW68usuQ6CkS7K92GxoYVKR8Z3y+Cr4xeNwKwe?=
 =?us-ascii?Q?NJtg1d7UnInhz6WpaEEQg0B2QkhMzQYeR/bny6vldn5PwUKxsFOEiXoGWeBy?=
 =?us-ascii?Q?m7HmuZXBy8xX3jJ9LA4HPKoGEDGVY/MMEbqu5Dfpa+BxpUpaRatsguC4jzMd?=
 =?us-ascii?Q?+zAk0BX13MSwb57G0JTYdsLrYQ8RsXvhBCk5rSDN?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(36860700013)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 08:52:05.7618
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 861129e4-0c84-49f6-da0d-08de534a3199
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4168

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
Changelog rfc v1..v2:

o Collected tags from v1. (Thank you Mario, Viresh)
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


