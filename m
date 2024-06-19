Return-Path: <linux-pm+bounces-9554-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E09590E6B3
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 11:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E0B32847A1
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 09:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09C981741;
	Wed, 19 Jun 2024 09:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fgODCIxC"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBA680638;
	Wed, 19 Jun 2024 09:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718788638; cv=fail; b=MIyO+s0ye+1tPFg0T/RArpeqA5qoNs+K/XnPEAs8fwTinvYZ0oYFk7VPlSew6PCJQF2NUEG7MvkSz7tGbhWWhceIYjMPdFvW2lxp9qPjyJtpRg2RCeDeWWcHuj/K47A0XuVtNK+vQb503GuYjBEvSvBmSKlGrcSKlb6DOjqoGb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718788638; c=relaxed/simple;
	bh=RxRnAd7oO4um0tjor1ttjxsfTxV5CJ+xln902pbx9+g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A1gcRP8ZLp3EaoztS8d79GhKTGXs+TGIz9gYDj4nlF+5R0xq5BPKKfY0ivEyko2fzfafL9KS2FX05XuZnv938DOqSJUBq8vQGhqoWJozzAhnO0y0/RLuh+4/TrzeZxEYykcWT12lW5vhZK3eluJbGlE/Yx2qCN/GHXKR85ZnGDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fgODCIxC; arc=fail smtp.client-ip=40.107.236.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c14q5kjeyrLBaBeoSml9alX6Jkz4wOj63E+0UwnPe8upu+YOtNo/lVVsNyMSNS9/MmjuwQ2SUHfDRQOzA106UmKGeu2i6ZgA4ObbVw0OIAZ8+aHz0G7dVyD3WS88aaYTNWO2TOCoollBM/lSt13vHpWnCduYUXeuuWRpkdHK7Dh3xVlujX0bGK4suL88WFT0MY4T/IUBSSZcAfiJi5f4eHMzZnf6x5Esw69VflDsrvNm5ypt75yFoJV/zPVUf/XFcF8MWB0XKKeHG6piud6szV5mGK99/EPFtMZHs5ZcgkaWImDyUzRVonAmNOLf1eT+qEJvvOMDCnIst03H7DHFFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IuwSwvdbfTkLwfCZzHvQkeCbp1XYAE3bYQed4gicflo=;
 b=Q5lzz5oOEHXtz9hXcXxVLw4c6/wX1w+XQJvz/nFSVkXWIY0I3AsNXPCZ8isPWwLo59iO0L+Bkjn6d4aFOdN+Lta6KHKGj24b7pBvY9nk+VbyiniEJT8poY8aOreRWSTXmYK2A2hpEQz7Fshwt4hIS/mPwl1hi2k3YSfXaN5JbJUEFJsgdI1aUFYG1LgNGxQ/BXZFIVcmKDlQTdKmJhdeZQy26ABZO6C7atHT+EUdpKM5ch11OWq3xI+lGON33THcPPa8a2KwX5LOOUwuGiXtoU5AyiXz8ixFHWgckoKKil5LI4R0UrVWfxmfdmZViQGK7Yn4eEPlzlxWSurvjlpZQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IuwSwvdbfTkLwfCZzHvQkeCbp1XYAE3bYQed4gicflo=;
 b=fgODCIxCu9ATwW8FWRoicCz6dHb5krv+4W+KBDXWw5Kc1vXrKLibb7RFkMyAZStX02I7bxGRKnnSA7UYXaVkRRbznMRhTuu0CEroAtxQTPLMQAS7KluGOOXL3IfLGqlL8zzWHVOfahbZVsVXCeCwvh2joa+qMHXQs5w0zT8r9QE=
Received: from MN2PR15CA0049.namprd15.prod.outlook.com (2603:10b6:208:237::18)
 by CY5PR12MB6321.namprd12.prod.outlook.com (2603:10b6:930:22::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Wed, 19 Jun
 2024 09:17:12 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::a) by MN2PR15CA0049.outlook.office365.com
 (2603:10b6:208:237::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.32 via Frontend
 Transport; Wed, 19 Jun 2024 09:17:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 19 Jun 2024 09:17:12 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 19 Jun 2024 04:17:06 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <gautham.shenoy@amd.com>
CC: <Xinmei.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v12 3/9] cpufreq: introduce init_boost callback to initialize boost state for pstate drivers
Date: Wed, 19 Jun 2024 17:16:36 +0800
Message-ID: <9d1ba8e29feddcfcee0b8a91be3d6950bfa00720.1718787627.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718787627.git.perry.yuan@amd.com>
References: <cover.1718787627.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|CY5PR12MB6321:EE_
X-MS-Office365-Filtering-Correlation-Id: 8de26509-2c17-4ef3-d79d-08dc90409a9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|1800799021|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YK/87R1SG89xvn3t7wVPpjG5LOxL4Z9zOdkiiKVtZcD7xvcO2HP6y/sWtGoY?=
 =?us-ascii?Q?7Ms/dKaF2yIzZoX1ZShgdYqTboE97T9VzOHP6Hy6ff7RU8p+aAg1054FfBXx?=
 =?us-ascii?Q?vu2DqaOT0em78b0uWpZgndtYjfDbNwhjVVTL5kVEFNnPIG++3ymI8EtuNHSx?=
 =?us-ascii?Q?w8m3gMYyDdp3edtrBLLLTAsZ+MVESF9kNxPmstCFQScAJTpfsWD+U/kvWb4W?=
 =?us-ascii?Q?ohPKT73jCGQs6ZRrSvT7SzjY3/e6mFDezlWGrZc0embocExh3Txp5qPk/0U/?=
 =?us-ascii?Q?QPgw8sHNTemQgIekwD8aG2bUKZabSeCV+bDk6XvfE1jOhzi1KrKbfAbnK02V?=
 =?us-ascii?Q?28LgHe/x1WUXasb0s7r28/917K22Kl4RVp8filHTJ/filcrkWCfXVdwKmDE3?=
 =?us-ascii?Q?H97PIv218zAXyeoCkRVIIYukfFTOzmOTu7ztYvAbd4T5rlc0BAj1n0Ie1rjQ?=
 =?us-ascii?Q?B993HFQaEBa1tmEfn77RQ01zTCX89YzYOopIlKaCeIhAqGaFfIcbE5sFOZz1?=
 =?us-ascii?Q?QdVqx8188F5fPwgzlMjA3mO/HxaG7GzX+bJZmkQB6LYW9wjVJ7rg3jkCwo+G?=
 =?us-ascii?Q?JSRIDMtTRT0bNmrbgnUNPtfvz/v+5cVntri5kefVa8ZnlFGE5yF8u0jNdpDn?=
 =?us-ascii?Q?AGNHniOocCViw6KclCEVvJTSKKtMA4xrot1BewJLqpSjMcJ2aoBFitaaOtlH?=
 =?us-ascii?Q?vzSGNBMsYEGyVkCTv6k7QjHn6PHFi+92xXndrs3UyyGSYKv+2IBys0db28eL?=
 =?us-ascii?Q?isYafFHV6VyXpm5cKsiTjPga/6k7BdBkbEFzM+5BGtoCK8RfhJFFbaXEjVR0?=
 =?us-ascii?Q?NKyEEIdm1Fx+QSaI95r/buTJ9/HQIg32VfnhM4aBdFpkLu8wInGBYwZgzYDu?=
 =?us-ascii?Q?6+iQSEEfKB7Hfz6T9SDoLC1saDMrDcXxCR/aJ5y4OL1Q1EWtfe771wYlS6K7?=
 =?us-ascii?Q?CrEgRRWMT3rMsayRbZ50Ki6gHk1Fs04DznHzs9mERkZPmdUP6675mMEvEq7p?=
 =?us-ascii?Q?6Gh7nVY1ElVYnYjFYtOXqbz42y4UQy+mEg2aqccFAfVrNXe+iD9YBVFijtxm?=
 =?us-ascii?Q?G7fshvt0VKz18brKcfoXXmQKKLhrF71Mkdy7Os0lTE11mcEa/Gfcrmiy875I?=
 =?us-ascii?Q?6ECj0o0yBAIJCIv5Qap0WUuYuMkYbtfsd9cRNDrCrhNwxrfN+o9Ia95FVRUs?=
 =?us-ascii?Q?n8rz/B1m37qYb+PbPX0uxtUAMousPJf7c9xceUxfW3/2N2uMA9I1Y4KJjBZR?=
 =?us-ascii?Q?0NcE2ByvVkf0dY/72oBlt4iZq0umLYIzN1WAuXiH/zdEtASwgbDnjver1/JD?=
 =?us-ascii?Q?MIlpWdjtyu4rhtboze02T8dDUWu5OJPAqSVFagV/8qqiqNEnym9LaFOY061s?=
 =?us-ascii?Q?yW0kGG6uAnduvRwKtyWYp/JY2g2lMi6fogehFef58UW4t0c9Cw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(376011)(1800799021)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 09:17:12.5132
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8de26509-2c17-4ef3-d79d-08dc90409a9a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6321

Introduce a new init_boost callback in cpufreq to initialize the boost
state for specific pstate drivers. This initialization is required before
calling the set_boost interface for each CPU.

The init_boost callback will set up and synchronize each CPU's current
boost state before invoking the set_boost function. Without this step,
the boost state may be inconsistent across CPUs.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/cpufreq/cpufreq.c | 13 +++++++++++--
 include/linux/cpufreq.h   |  2 ++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 1fdabb660231..64c6770e24c8 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1429,8 +1429,17 @@ static int cpufreq_online(unsigned int cpu)
 			goto out_free_policy;
 		}
 
-		/* Let the per-policy boost flag mirror the cpufreq_driver boost during init */
-		policy->boost_enabled = cpufreq_boost_enabled() && policy_has_boost_freq(policy);
+		/* init boost state to prepare set_boost callback for each CPU */
+		if (cpufreq_driver->init_boost) {
+			ret = cpufreq_driver->init_boost(policy);
+			if (ret)
+				pr_debug("%s: %d: boost initialization failed\n", __func__,
+					__LINE__);
+				goto out_offline_policy;
+		} else {
+			/* Let the per-policy boost flag mirror the cpufreq_driver boost during init */
+			policy->boost_enabled = cpufreq_boost_enabled() && policy_has_boost_freq(policy);
+		}
 
 		/*
 		 * The initialization has succeeded and the policy is online.
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 20f7e98ee8af..0698c0292d8f 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -409,6 +409,8 @@ struct cpufreq_driver {
 	bool		boost_enabled;
 	int		(*set_boost)(struct cpufreq_policy *policy, int state);
 
+	/* initialize boost state to be consistent before calling set_boost */
+	int		(*init_boost)(struct cpufreq_policy *policy);
 	/*
 	 * Set by drivers that want to register with the energy model after the
 	 * policy is properly initialized, but before the governor is started.
-- 
2.34.1


