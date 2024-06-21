Return-Path: <linux-pm+bounces-9783-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8D8912BD1
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 18:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A89161F26524
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 16:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31C6175543;
	Fri, 21 Jun 2024 16:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kUW0zzG7"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4428D174EC6;
	Fri, 21 Jun 2024 16:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718988701; cv=fail; b=H9y2K4J5i0iNx14QgYk/PQJUyokwhNfMZBpg4ZlOOZcQEOygIidRLi+7nISSYHarX9JPQEbmvvrEvhvd1DvRRU38x78ugXvqzfnZcNa7A1oTJNtlcZAaV/tjKzUrF6AlMYkzlQ0L3zMFANvUMo6yAOt6bDmiOeakNXojZFDqarQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718988701; c=relaxed/simple;
	bh=bBepyORGw0e2z7dKCGcvEnkJnI0hv7HvL9sf7FuXG5c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PEILTIO8xVlzw859Bxe5rW/b0aytUIrI+Lq3NklqOOrX1il+BIbvB8qcsYFStmg0jUi1y1dJ7cX60gR8HDVIAbJ7EeQYLbbRFQAgX1pNWLlCCn2jeQIGEBUCQnSLh6YvgjOM3NZrfnOGoQVswOfC8xzZZSSGVGKnIlV3LgyPUeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kUW0zzG7; arc=fail smtp.client-ip=40.107.237.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mxSlMmVHS7wMZ4A+2vKQGufHAF0oTVvI2dgClGu5PZaslk6BD1W7wL1vzrcv5xf2AMEwCnXzqOyRJmnq7r2iBiU/10L1iAgCCc/l9XHhAykD7taJrFOysjJ0piAS8u8FrDNEdHNTkEmg4+G35MLloVBziM+iXdcrlxH5z40YNiHyM+Nb10X9dwCx/NjPRXZH/6iZZVJRtCtrai1FD3+ZYBE6RJ+yABnAqscb9Gjor+9JbMrGSHOjk59ZHcWjbRYCrqGQKKKURY29BUq3yET2dhF/TqnTmGyW+mDhtyO3gNwyU7oCq+XYoqQQa7Wuc4LOCSRqFAGowB/rxey0vxg8Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EZudm9BAzo7Gu5Tqw/92zAUky1ExBkLzjnPVJ2P+1h8=;
 b=GDnqwTD5AZNKE+IlwI27VO8JuLME/aOCUDlWPdg24efl3bHjX21qckWLQp2QcsyElNrIoTGv+IBQMxZO1xS9lyU9Ylq2CE1CdJJ1t4biCQiPaMrB3y7oIJSzaSBJdTyqgM2tEhkXwNsguNuHY8X8cpOn9dB90UGSOULel9me8M9N8kCSgimXPxLdif2K96M2C1MlQwZ5nFGLRd2HtgzltChRsdJkah/uVNtiC+T7lqrAxee11sol2RB7hOh4bgpcVgvJ1n0bxJCk1GzxpuJrebJHBcb6n/9Ho6f0Pt08AH/zgj2JmnBLR0sah2uRpxek/rKgm1rOhQfjGsq5Ak435g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZudm9BAzo7Gu5Tqw/92zAUky1ExBkLzjnPVJ2P+1h8=;
 b=kUW0zzG76ncy7oD7K0r7/1gmftZX3A0+PP+sOTuc5p3huqxTED7sZA+QV6os+7hUpWN7EkSKeZjjO94Da2WXeeSGBfFqEgqA+smnQGMFZdswsGa/f/SLPA7IypLtHcl0cid8ZDKTw0m8LLCwTy0G0G48glMnhzC0WPlrGfZa6HI=
Received: from SJ0PR03CA0179.namprd03.prod.outlook.com (2603:10b6:a03:338::34)
 by IA1PR12MB6532.namprd12.prod.outlook.com (2603:10b6:208:3a3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.22; Fri, 21 Jun
 2024 16:51:37 +0000
Received: from SJ5PEPF000001F5.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::b8) by SJ0PR03CA0179.outlook.office365.com
 (2603:10b6:a03:338::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Fri, 21 Jun 2024 16:51:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F5.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 21 Jun 2024 16:51:36 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 21 Jun 2024 11:51:33 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <gautham.shenoy@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v13 6/9] cpufreq: amd-pstate: Add set_boost callback for active mode
Date: Sat, 22 Jun 2024 00:51:01 +0800
Message-ID: <e51aa7d6bf34455d256dbb6041d56bc8ee57b3a5.1718988436.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718988436.git.perry.yuan@amd.com>
References: <cover.1718988436.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F5:EE_|IA1PR12MB6532:EE_
X-MS-Office365-Filtering-Correlation-Id: e12fb8d9-9d81-46df-ec5d-08dc92126a3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|82310400023|1800799021|376011|36860700010;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pRocTqHtyS84QwvxOi4WNka16phuUU2xR+eRNb5IgNMUnnD2mhDel7y1qpWY?=
 =?us-ascii?Q?gSRrN50gAY/P3dpTEtHKql4o46dgoLIAHbXYBsA4fdo4bYvA0qpu1/OOb1qA?=
 =?us-ascii?Q?u7XRETD5PpALN+eVFDw43gfSdAkPsZPbdEDkZCYCzFR6jeiok8k0uFi5v+eZ?=
 =?us-ascii?Q?p7AnpCIOBnrNGi2aF6RigyJ/ZD5il46p72lW1khSXOC/f+wZwJuRHb8ZdXqY?=
 =?us-ascii?Q?w8mCwYYx3/QU5x8Pi88iAVmlhyQKS04jrh8OwGbtuhjIYrnI9e5OupPyFI0T?=
 =?us-ascii?Q?O3vaFD9+oxTYGGQaKS5CfUWeAZBzhyN8k6xxm9+rFi6kjLOwDY/sk+R5VJPz?=
 =?us-ascii?Q?dcamg/fwJ6QN4tMEWmEkgekh89D/IT0JjdtO8uD8Dkg3gw00C2AiHOOoqCr6?=
 =?us-ascii?Q?6WMnYTCIlKaAMjkCcdrRnnE88Cx9sFzMrLhTQfQWYGyAIixalb8QYdMuVSAU?=
 =?us-ascii?Q?PbbHg02t0fJgPJsGCD8T+kZ0XNdkaP68kDsTzEWAkNOAkiPZe8Z2VslGP5ik?=
 =?us-ascii?Q?4C6pitd7hxGXExzd3o1s62ffKuygwrewCAPF+wiIjQ8CTTAihemy0KOQ6r8c?=
 =?us-ascii?Q?nUO5W4uxBPVOu14s1aBe/LKvC1mcMtZ8VPyhJgFMVKIUOQujCprLRoYGRY51?=
 =?us-ascii?Q?XvEVJBCrQDDzedznNSOlrKNgldRVWf1ECyFDV5LF4Yw7dzMuHLrHguURbMp/?=
 =?us-ascii?Q?EdFWCKx5FUGaUMw1cgbpMwor49VzWndKHkmt87tlMHTvLGoK7es4oKevxxDE?=
 =?us-ascii?Q?OVA3PM6eCG75X67oDOjZegRpKTRdqx1AOzBOdxjaBAqkMXJF9Lg8M+RaU0J1?=
 =?us-ascii?Q?OZZTDoC9wFMW29oG86yTI6WhOrBGaIq9iJnXyNUVLElS5Fd/IxNlqQlFj39E?=
 =?us-ascii?Q?CE/fg49NPZhBUQk0wF7/nXGpCFbM7bvvHraQ9imz0Uum35iuRAr2WxqNlMPl?=
 =?us-ascii?Q?XIeKNS2CYtPKLZ5+Ft28yzLnKYkPPFPDUJPW5UXw9LAIwe4gYTZUz02339va?=
 =?us-ascii?Q?H4/UU/aLDRfqhkU2SLXJDOah+oyH42m758AjSUzOmMnso6juOPVfFwdm9ZZ4?=
 =?us-ascii?Q?9/GoH+NxvOS0GE3YEByxnuvqvh+PFrbyE4QMb3plW68BoM5nfgdByNzVDFF/?=
 =?us-ascii?Q?Dh/VtgbcxSXzoKKeQdYP0D5h0FhefGobtnVxxdOP30kA77kahupoA5+9r5eY?=
 =?us-ascii?Q?aeT1ZGCUtb9pfPLhU2BAtztxXP8wYl04DK2P6BDUCDeBqb/cp8Mi14wrN9Mg?=
 =?us-ascii?Q?A8E5J5ecn2JvRvLSxVnbF8hLXea4W2aDp5rxVXUjc8xBNIGoO5WUBLo/xx+E?=
 =?us-ascii?Q?1EeUXXDGu5d5gLBkvYWLDaVoXy7ZW0Rck1CpsVB7dZmJo2fSyAk5MvwfPbV7?=
 =?us-ascii?Q?ml3arrnDTLfM0Kg+axBGQwY8jn+uvlBi8gX++TBY8WVWZe2CpQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(82310400023)(1800799021)(376011)(36860700010);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 16:51:36.7805
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e12fb8d9-9d81-46df-ec5d-08dc92126a3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6532

Add support for the set_boost callback in the active mode driver to
enable boost control via the cpufreq core. This ensures a consistent
boost control interface across all pstate modes, including passive
mode, guided mode, and active mode.

With this addition, all three pstate modes can support the same boost
control interface with unique interface and global CPB control. Each
CPU also supports individual boost control, allowing global CPB to
change all cores' boost states simultaneously. Specific CPUs can
update their boost states separately, ensuring all cores' boost
states are synchronized.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Acked-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 6710b3c28cda..02767230524e 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -703,20 +703,11 @@ static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
 		pr_err("Boost mode is not supported by this processor or SBIOS\n");
 		return -ENOTSUPP;
 	}
+	mutex_lock(&amd_pstate_driver_lock);
+	ret = amd_pstate_cpu_boost(policy->cpu, state);
+	mutex_unlock(&amd_pstate_driver_lock);
 
-	if (state)
-		policy->cpuinfo.max_freq = cpudata->max_freq;
-	else
-		policy->cpuinfo.max_freq = cpudata->nominal_freq * 1000;
-
-	policy->max = policy->cpuinfo.max_freq;
-
-	ret = freq_qos_update_request(&cpudata->req[1],
-				      policy->cpuinfo.max_freq);
-	if (ret < 0)
-		return ret;
-
-	return 0;
+	return ret < 0 ? ret : 0;
 }
 
 static int amd_pstate_init_boost_support(struct amd_cpudata *cpudata)
@@ -1888,6 +1879,7 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
 	.resume		= amd_pstate_epp_resume,
 	.update_limits	= amd_pstate_update_limits,
 	.init_boost	= amd_pstate_init_boost,
+	.set_boost	= amd_pstate_set_boost,
 	.name		= "amd-pstate-epp",
 	.attr		= amd_pstate_epp_attr,
 };
-- 
2.34.1


