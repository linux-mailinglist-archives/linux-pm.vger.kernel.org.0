Return-Path: <linux-pm+bounces-18648-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 258A99E608A
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 23:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 715951884354
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 22:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE48F1CEE8D;
	Thu,  5 Dec 2024 22:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VZ5Ai3wY"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1CE1CDA1A;
	Thu,  5 Dec 2024 22:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733437751; cv=fail; b=t/ITLdE5VUFXJA4jCOVBrEJiISinYemAeOhWOjO4sDC+k8MOs3GmM2ahXcZXSD7xZyAJJD9Y9+cMLtoE4/ufz/0V/uB47y87y8H4fuv1d7Vu1HPGXLfzR6gx3sRkIyIxkBSHsShoiFDsBOXQVWpSTdJG8cCQuYJHU5kO2Wp7WiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733437751; c=relaxed/simple;
	bh=T6bBaaKVySdYctXcT7/GETjgiCz2vNAxQfvBY141HRU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mY9ToPOPMY2ajT/JRkOZPeB8aBYe4gnuGdzfjgbDAQ/shBHsp/SBEqIapekKlYGAou5n1hN/sOR4ywc9m04qm5Par/MZRD6NcuLVp0Z0KtTH3ErZH+90I8hc/P8SbUakqzLri8HPu//CX8ef/iSDs7UFDRwJf9PdSo5AeTWOrZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VZ5Ai3wY; arc=fail smtp.client-ip=40.107.237.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v3nYbilLFUKlLavBwnsyia5m7AKJCdNhoSMWjP/dMpMCsVTXwxbJ9IwQtamRo/3YzLntOenZSGmnmVdmVEYn3sIIeDsfTBVz3k/yoFtKImiyKJ4jGs9tPIaTTk6ysX8FO5kepwUNaiIoyaEoOje9vIeEKB2t3was99lhd2g1QuG5w5I0wrjhko2py/0XGWlimacxPvzw0BeL44XMWgiyecC17JSnn3XwcPQ+iaW3Qm/kru9khTIkEq8C15amk/nEFaA6FUgBFN5PjX8ZLoJRpGrEtLdHK0fFpfvMm6E5njQbp/oV3tBlQ7T1wTnAvrj2Qo5f5vc05JEEb8Etgpe7Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gtDd2g0e+oUMW2MQYGGBQgjIjiAmDE5BxCwaMQW+u4U=;
 b=AY75oktm4FnDiGlnn+6+JXgw0AYM9SBjx3t6sDTtmiRoIx7eVxvpMwFo42Z+Fcr9taUQsigazDNWTqGtSai2zGkOaCkYT2Pmr/8YSE/CMoUxskIHP3PhoMj+rfm0m2AMgX1KyHux7smiEx8PQpW3g+vRQWocOjnUBAAIvVBUMRZRcV+AA/9LXqV/fOiHqFemXZs1bMMBNdVrl9fxiZ/KQ1jAH9v5GO7kfd9Do/0FXHswfjBDRH0JQmeRlnb4/b8PQ/+p2eJJ4uMxiAYB3izXFksirklThl0+ofK6Wq8yK/kk1DoTyH+uHRvQFWMf92PfiyI/UZk6AbCqnaJyTfz0bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gtDd2g0e+oUMW2MQYGGBQgjIjiAmDE5BxCwaMQW+u4U=;
 b=VZ5Ai3wYx3L5//wwQ1naGqgBr68jwP2hjdWLIQSL3uAU5F4s2/vRvrg4nbzEKDz8Q7ZHyzV6pNpaxaYNmpXee4ePOpyZFti2h1pza6IidRLw5RexmjTZoF1DMgNRxs9wlGZojlK+qMabUK5MoG1K/xgKOnplcJqsopjCBNFIpLE=
Received: from CH0PR03CA0223.namprd03.prod.outlook.com (2603:10b6:610:e7::18)
 by CH2PR12MB4246.namprd12.prod.outlook.com (2603:10b6:610:a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Thu, 5 Dec
 2024 22:29:06 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:e7:cafe::b) by CH0PR03CA0223.outlook.office365.com
 (2603:10b6:610:e7::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.10 via Frontend Transport; Thu,
 5 Dec 2024 22:29:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Thu, 5 Dec 2024 22:29:06 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Dec
 2024 16:29:02 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 03/15] cpufreq/amd-pstate: Drop cached epp_policy variable
Date: Thu, 5 Dec 2024 16:28:35 -0600
Message-ID: <20241205222847.7889-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241205222847.7889-1-mario.limonciello@amd.com>
References: <20241205222847.7889-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|CH2PR12MB4246:EE_
X-MS-Office365-Filtering-Correlation-Id: 247e63f5-9df5-4658-0229-08dd157c3acd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HHcHo2ruwoiO417fRwc/JtQg1NxTn2WKjvobDg0TVHCzQF6tRSgDpFSzZJKs?=
 =?us-ascii?Q?wiXWwcSmn6yn1u6SF1WfYZT1+IqE1+S8qGVWSdn+VClW4ybTjO7ku4SdAEK8?=
 =?us-ascii?Q?sU+uvOUQ7jJYPTrN6x04GfhtIGFVYma/eoFhZ4tCsWYTf0twNezBIJ4fAJch?=
 =?us-ascii?Q?gvVFoShQnmDbny+uis/IT2+8SQ+wzi82RVc7yZDKmKBzUbEdV3DgPlfp5fRj?=
 =?us-ascii?Q?l7MUSqTuGeB4RjObn1D6PbbuZs/XWBEAxreKHYAXal5UEmGd4cPxRWmM/h3R?=
 =?us-ascii?Q?5S3EE6aVmi/2Yt8fabfDWZBue2siKt/ub5cl5V1kojtSFhnEWczIlrGS0tGi?=
 =?us-ascii?Q?DnEut7C59twAgsYIL4Gdpi1dsTqoEkN40Esr8GjDSwX3pR2tbJo1N7h4qKsx?=
 =?us-ascii?Q?LsmsZRpIxtWEsZ8YG2qfxH37eQylue8vGE9wC4eTcOq+yEr+en275CFwpN7k?=
 =?us-ascii?Q?kpvEQpB2O1WCrq6dsg6qZPoAINZpHiMO7Q/XfDt3JcYOS5ohHxB0bEXWToco?=
 =?us-ascii?Q?ZzAkPkv3gGpWG0shYFZXUKS7iVmYVMXxx09S1+VOzS/kLYWt15Spx1hibJb2?=
 =?us-ascii?Q?WOg3qNCRx6fxhaAT6Wqp/W2als39t1Yr8KnV9lVavVJp2/O9ZoSl/KbUaw1p?=
 =?us-ascii?Q?k4EAXPh8owsXYkKxM2sj5e4z/u2sIhQwe9x6fwMwolJg8hlBsMsJmmNc+VQ2?=
 =?us-ascii?Q?e9sfkqfTz8/EDg2vlli/APZ9lgdFtv+4Ju05lIEQlZqBaEEUp3hHS9mqaPmF?=
 =?us-ascii?Q?cw6SP8ZhQ/JdRQeGOSYsW5P1+mjik/c5a8MrI/v2zyzzGK2PT22CDEevMIx3?=
 =?us-ascii?Q?vYz3I+q8sKzhAAgRz8UfRU3oJW2l39+gVI+JgGDjAOfNQKcyoZIYDeQhROtA?=
 =?us-ascii?Q?6YVkUtzZ5iYo05xSMHtJM1KTDie8hpI4Fin9eLBuj1uVwWLRxbGuIlKsgxC1?=
 =?us-ascii?Q?rsjJgUqCqvHAlOEysgadzwjr+GhdxYZ0zIBNU1QaQivR81IpJDYUu+p+Ehvm?=
 =?us-ascii?Q?4srhmsx/d6z6NqzpV8mzYreqCvBc6ZFGRCrCgg5rGmaMhNtb4oLs0ei/cEez?=
 =?us-ascii?Q?dVDQnvdpu3Elry3wAxk4efRexKRCLg2Jm9CX1BSo/CjfAqX/MLUemvkXbXhu?=
 =?us-ascii?Q?gdzGi0N/Lm1AhnWsB2beq62XcWQCppDC/IeOfysUUw/xifR4CCSirB6F/iUl?=
 =?us-ascii?Q?w9PFb+dtzN1EBhkEku2O9fVXYfW8K7l78SH7eZx8SaPu5+nCKL0If1OEf6Tq?=
 =?us-ascii?Q?q9+jf4yXR/IwxCmVRWn7A6lpOyyvTu1lT1hBLhmuSqzhFDYaKAkw6hl7RW+c?=
 =?us-ascii?Q?joz5stwy3vp0baCqssPhJ+PyCbg2i9QYLavaRuu1EqYqGIpmI7202Ub+so3+?=
 =?us-ascii?Q?J9ZKfSpTMpsL4PVzmX0SVWjH4SPpX5B3z9cEyi4URyCwO8zHSPWaLH32jW5j?=
 =?us-ascii?Q?giDQRDXvK6hC05gW8erYCbLDWqu/CGdv?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 22:29:06.2339
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 247e63f5-9df5-4658-0229-08dd157c3acd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4246

epp_policy is not used by any of the current code and there
is no need to cache it.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 3 ---
 drivers/cpufreq/amd-pstate.h | 2 --
 2 files changed, 5 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 7eb013585df51..22e212ca514c5 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1476,7 +1476,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 		return -ENOMEM;
 
 	cpudata->cpu = policy->cpu;
-	cpudata->epp_policy = 0;
 
 	ret = amd_pstate_init_perf(cpudata);
 	if (ret)
@@ -1583,8 +1582,6 @@ static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
 	value &= ~AMD_CPPC_DES_PERF(~0L);
 	value |= AMD_CPPC_DES_PERF(0);
 
-	cpudata->epp_policy = cpudata->policy;
-
 	/* Get BIOS pre-defined epp value */
 	epp = amd_pstate_get_epp(cpudata, value);
 	if (epp < 0) {
diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
index cd573bc6b6db8..7765c82f975c6 100644
--- a/drivers/cpufreq/amd-pstate.h
+++ b/drivers/cpufreq/amd-pstate.h
@@ -57,7 +57,6 @@ struct amd_aperf_mperf {
  * @hw_prefcore: check whether HW supports preferred core featue.
  * 		  Only when hw_prefcore and early prefcore param are true,
  * 		  AMD P-State driver supports preferred core featue.
- * @epp_policy: Last saved policy used to set energy-performance preference
  * @epp_cached: Cached CPPC energy-performance preference value
  * @policy: Cpufreq policy value
  * @cppc_cap1_cached Cached MSR_AMD_CPPC_CAP1 register value
@@ -94,7 +93,6 @@ struct amd_cpudata {
 	bool	hw_prefcore;
 
 	/* EPP feature related attributes*/
-	s16	epp_policy;
 	s16	epp_cached;
 	u32	policy;
 	u64	cppc_cap1_cached;
-- 
2.43.0


