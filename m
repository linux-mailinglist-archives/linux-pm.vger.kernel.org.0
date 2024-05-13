Return-Path: <linux-pm+bounces-7748-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA3C8C3A02
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2024 04:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EBB11F21227
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2024 02:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A737129E6E;
	Mon, 13 May 2024 02:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cOTWa5Yh"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B7385C4E;
	Mon, 13 May 2024 02:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715566082; cv=fail; b=mEbiwff8Vp0y98e2FQs85BIIz9q1MR3OfIk4pYlPKhf/Nj6DDSuxjuhrhLTGgA1769Iee1mhWk/nm6nUQnqjKXzh+Xlik1bVNGMZgpWv4Wc2uqlUfkx45tbFGAcNqebqrDYFATJa8XaMKhvKHFgcKAthqZ8ZmBe72fUgLaLwr5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715566082; c=relaxed/simple;
	bh=pAwKbu8p5c2m5lTqoqEeABKlCon+dNJ7RJCdaiPIavA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=efj43458gMs/owEBr8+OQMFTayDT1Vayy3tB95FjDWAuvBWol5we+t+eQFp/NrS2NAwhrjc6+f4imOr/8RIEicqcPSE1QkA5pKd6V22zRvYdkuKpYWgzdGUGwRP2KXMReqoVQ7oT7IKzcgsWdPOJAKrG1AHLbo8Dn0ddO9d7HVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cOTWa5Yh; arc=fail smtp.client-ip=40.107.93.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PqumbPQmPiNSjhG8qaULkJ6UwJnciaI7hsh55q6fUIsrePUeDnXIzyrFfGLstc9EQ4AlkvWsIqXinVjVeAebuFpIEO15leoQ46BZGJeZa+StCzgH/upFTK6LgCAUyK4RX7jqjMtL1h6lTx2d7ePx0nSepI6sXFZbJRh70j0eNe4geo/fJ5DRRji8u5JHGmob8FrtVrX/40FdUws/mDMfRCH/sOmxMQnnVH+GXPIZm9dJOwc0XsFPxRBoml7aZXL9UqCYiop/R/2ajrC8NRg65y9hYyVbw6PcBTzvC7OGchYkfovuJJDYDznOjFDfsFxBVWtWqc1jiJnPpLRCfd0DIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wh8ZHY3gLW6izqXw0DHlYsLQP6blLeNi/GIFxVIGqXw=;
 b=PLgdlvum6OpUyb2++afTwB6S80V2FM/uAJkf35Up/WTi0b8Q+E+Se/w5CZC1JS1JXM59l9uko8a1eDYXV32HM/QJVxucoecoFjDvotvBvnk6/2iEJhxAcw4BxfYQtoNAEHpl6u8ERtQ4NdvVM6Lcg+VesSaDQuFLp9f3aZQfppg1B91yqBhHPN/jwShRe6eI0b+8JwlSOrQD0yGJBgsCgJfOr5/rk4uMMs20PZVMcC9TOxRv9932V7FQ+zkHWNy4mSbrK2V8gkjZ+RxLF9pvv1oajm0lN+zI+/r0qUmRLluQC/OB3n3K/ZBcXKkCxak6ex5r4DpfQIKCYMlj9k57ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wh8ZHY3gLW6izqXw0DHlYsLQP6blLeNi/GIFxVIGqXw=;
 b=cOTWa5YhdmVrz2sEUsrhYh2cVf9L8gtZZ3zYe4Jiqpj9v4hnaHy2dihf1zD989om5D2Zt+b5dY1i8ELJ0TB1mSFpl6Q4sLltH/gmLfF2ydG64Z56jXSTLAPIXOwrZVNNiLEeAeTLoczJbGHM3hS3zYPTEaEMhe5VooFMKqXw7zY=
Received: from SJ0PR05CA0127.namprd05.prod.outlook.com (2603:10b6:a03:33d::12)
 by PH7PR12MB6537.namprd12.prod.outlook.com (2603:10b6:510:1f2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 02:07:55 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:33d:cafe::48) by SJ0PR05CA0127.outlook.office365.com
 (2603:10b6:a03:33d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.22 via Frontend
 Transport; Mon, 13 May 2024 02:07:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Mon, 13 May 2024 02:07:55 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 12 May 2024 21:07:46 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <Mario.Limonciello@amd.com>, <gautham.shenoy@amd.com>,
	<Ray.Huang@amd.com>, <Borislav.Petkov@amd.com>
CC: <rafael.j.wysocki@intel.com>, <Alexander.Deucher@amd.com>,
	<Xinmei.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 02/10] cpufreq: amd-pstate: remove unused  variable nominal_freq
Date: Mon, 13 May 2024 10:07:20 +0800
Message-ID: <eafcb44942942f2a4489980066712b9e505a76a1.1715356532.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1715356532.git.perry.yuan@amd.com>
References: <cover.1715356532.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|PH7PR12MB6537:EE_
X-MS-Office365-Filtering-Correlation-Id: 53f96de2-edb2-4d2c-b94c-08dc72f180ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|36860700004|376005|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Rf1+5i9LnRei7Dm2guv2BS8s1Z7gI9NRC1+4bN3AgILeKWHcSyt+kIOWfauq?=
 =?us-ascii?Q?bjFS1+omM/MYurNu7Zt1/pyE3cq+N7JjI8KCqebS8wyGbPl1HmjcIWq15TNM?=
 =?us-ascii?Q?XTI+uoZn0SFINSgkwpOeFalHKMXiEeXKg4nG14iZczL8+tET5TTTCzFpbJba?=
 =?us-ascii?Q?4eNxOSwZJw/O/o2MddCVMpFjZwYciES9r3g7FUqVAYS2KLiNFdcfl05ht4W/?=
 =?us-ascii?Q?7zEPmPIGU8XPe9x8nzftJJb0dlyzehOFXBL9p/AVaFphqvXs/f4ylLVhyabW?=
 =?us-ascii?Q?DL5OiusgWujmDAINhH5CCOYnwehDQmKJk97EFBSHvEv22GJGY15CKXtC0T3W?=
 =?us-ascii?Q?xx/k1MT45PKJbUmSqy2D+Go7IzPvhOVbdmcXdy0Q5iPvFO16N8yu84rkHpYN?=
 =?us-ascii?Q?gnAMGeUxhzNy5iADyuuhlEyOvwUH/Y7orY15z2kTFfkhKAJcbz9rLLLvUQ9D?=
 =?us-ascii?Q?sIkBx6kizpqWVpxOjaEIo5N0SdFy248Dwh0uPcd7H8UdHWW/cWsmHLGiTpzc?=
 =?us-ascii?Q?mt36Mk54LCYzC6IP3jseTqSD0DqrIMPPr1Bx/6ohdHpZNAin+a0lux9jVFCM?=
 =?us-ascii?Q?CjyT7BEuY7sIe5JPBTGpSifZqt8NDwQOVSFNq/c9CL45MF4YeLSkYLn9FUp9?=
 =?us-ascii?Q?cuwQ4ntRYWyJshSknConvUmOoB1MSZ1UCjfu3RuTQouJr0QY78aAZDA68qND?=
 =?us-ascii?Q?IEf7p9Z4WNXh+Dbtu7qsstMa2QT86Mc3KPhODp2UsV67+2A9MXiP2FLNvJmJ?=
 =?us-ascii?Q?3RHanT26PDlHZiEG58SAQhlOIxxzJAS8GPGgDa6ilDpZWJxTAZmQYKDblMbU?=
 =?us-ascii?Q?vOIDFTwB2/2S0b1jACzr4dc+CcU0CzZ5A6494n8SZ+ZxHWCv9xyuNKV5I9Db?=
 =?us-ascii?Q?Z6Jyb6DJ8Oym5/UsaE2+zjkhbBFLGgZuaDGqf+0cUvuIULtZDXOLSiB2L1UQ?=
 =?us-ascii?Q?KvvF3ZmlcIfEP0TsK8PUjFaIMmScDTl/TzVHghXkHPAamSqzrs4Dwod00fn3?=
 =?us-ascii?Q?MBGsEect7Ijycqj+R5sXCgGt8scD0byoMahsq4djLfDVMDnR3lD1Y+uHDqSB?=
 =?us-ascii?Q?Ga+vuD45/Og0W7cZ+UJweq6duT12usdsbhZFka4cMiFcqQooKG6KeXmdDDaV?=
 =?us-ascii?Q?Z0jKjyLPLliTYBr2hEduVljkddbu0uJYnFfzBqLF00vdko/U9zHwtt8fadXG?=
 =?us-ascii?Q?JfunnCH6vkT/BVxQfpGuPLpHDhY89xOIDhB4xFdzXlojB/FGLFvW6cf8aJqH?=
 =?us-ascii?Q?KkKBmaq5+KNOJVrmmvAjEdVOg42Qh2WHncVSCKlOd+eNnLKbnO3XI2dr9x7S?=
 =?us-ascii?Q?ulUXJRq0mYrx8TGiMc8dsV+C?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(376005)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 02:07:55.0923
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53f96de2-edb2-4d2c-b94c-08dc72f180ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6537

removed the unused variable `nominal_freq` for build warning.
This variable was defined and assigned a value in the previous code,
but it was not used in the subsequent code.

Closes: https://lore.kernel.org/oe-kbuild-all/202405080431.BPU6Yg9s-lkp@intel.com/
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 614f6fac0764..9ca22e94f3f3 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -912,7 +912,7 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
 
 static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 {
-	int min_freq, max_freq, nominal_freq, ret;
+	int min_freq, max_freq, ret;
 	struct device *dev;
 	struct amd_cpudata *cpudata;
 
@@ -943,7 +943,6 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 
 	min_freq = READ_ONCE(cpudata->min_freq);
 	max_freq = READ_ONCE(cpudata->max_freq);
-	nominal_freq = READ_ONCE(cpudata->nominal_freq);
 
 	policy->cpuinfo.transition_latency = amd_pstate_get_transition_latency(policy->cpu);
 	policy->transition_delay_us = amd_pstate_get_transition_delay_us(policy->cpu);
@@ -1363,7 +1362,7 @@ static bool amd_pstate_acpi_pm_profile_undefined(void)
 
 static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 {
-	int min_freq, max_freq, nominal_freq, ret;
+	int min_freq, max_freq, ret;
 	struct amd_cpudata *cpudata;
 	struct device *dev;
 	u64 value;
@@ -1396,7 +1395,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 
 	min_freq = READ_ONCE(cpudata->min_freq);
 	max_freq = READ_ONCE(cpudata->max_freq);
-	nominal_freq = READ_ONCE(cpudata->nominal_freq);
 
 	policy->cpuinfo.min_freq = min_freq;
 	policy->cpuinfo.max_freq = max_freq;
-- 
2.34.1


