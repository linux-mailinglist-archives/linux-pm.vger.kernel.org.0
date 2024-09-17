Return-Path: <linux-pm+bounces-14361-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA7A97ADAD
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2024 11:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B9111F249C6
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2024 09:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40B316193C;
	Tue, 17 Sep 2024 09:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VT7p0ol2"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C68716088F;
	Tue, 17 Sep 2024 09:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726564551; cv=fail; b=TV1P7fmskEohNs4Kj8vq2QohEpe7DfWM6h9zrZeo63dO+OOhK28yzR5qDd6dMRcQOlVGL5jSDD0eh539E1+xmZZ3pJIobDh4mS9CeHzZJYgqvSSNgW17ztJW1CUhrSZ5sjPg8KEPl+UDdKL+OBpH+Hh56z6HMqu6pDJjK4coVro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726564551; c=relaxed/simple;
	bh=CjZ2tBe6himHK6bEvc0UdICBZuyx07AbEdOTFZWg3Lw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dOY7+T9Z5Ox9wS2rKQGOi+Rw70i3rJ7up4eMdKM7mmwYqavriIPK7Eq4RTDpA5xogtpg/jyVROLO1eJllbHlMECFTc9SfcKP2wr8i/us/aiSR8/SPjCHrmcv7jsaSGiGnHSi38BVnvfBXDn6jcYMwA2uk7v1wMIcRT7yyPB3GGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VT7p0ol2; arc=fail smtp.client-ip=40.107.244.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KhoFPzEYnC0RZ06wsOCIA1BmPg+9kiL1VhF3Ke8tAoYCRFcP0ApI8Lvrii8Rg6NQeEjLhoN1yNsBW4B0ubIMTXqGNs+BCpZhgslneHNZO/MU/g+S5gspDjInN//uSpOlHXNmYXlchI0qcF/KHv71Gp6UXdai0+LlQGCb5xPv74lF/DvhtNEGeP1C5wkQuzLEkkVoRL9Nj8sh10zIfOIXRL8Wn2K5a2aUH5RBpvSof5Y20EuXefwexWOdg7mrdPBJoEmyJ/E7xVAmHWipSpqHdDOY8V+rQoQKDBVVYM6JizO66hoMgT3GNR8VM2iWGQ6uhGUnGykE5VuuLmdtSLj22A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8p2UDyNfF6pM9CXETbNFjqrIxZGnjcNE49kSeItX9W8=;
 b=IBepgvh88ubsClIXpWwzX3/VAkD1KhRNzzcRH+QFUBnGJfia8dF8DQcbo41c/DJRTW3srUr9jr4Wwm2vmdPkPawf/VpYqXM64woMwCRLNKRD9gbFWishhlKGDm19cVA36RfWV9jD6S5z8OLLw0qWyYauczrUAOmofgt4S6FJrqwxtBGCsPuPeaYFuq5vm2buFddauRYuD53AanGcjD5ylYlu0YJZl6TfaUugFtUqDqDJxzFMtycIEo7EPbF9LcFF4DHxqRiTieOoxopys/AtOn7sYyW9VWIABnPxA8opXMEB7EW4jlLCKr30GUHf+xThqNRBMVCMvpHo+eBJsSOSEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8p2UDyNfF6pM9CXETbNFjqrIxZGnjcNE49kSeItX9W8=;
 b=VT7p0ol2lNVOKZikg0kUAc3vXx3lmFFRLCCyXOV3dbvFwbFat8nx+e4vZ1vB/J/frl1v8ChOzCvT5fKMUj/wuAihm3J8DL6BT4PrjeDe5xs4+K92/IgP4Xk1gNG7CQF2MyFCEOd1j8icr94sMj56ayRZi3FW1RFd/9JtCyCu6z0=
Received: from BN9PR03CA0404.namprd03.prod.outlook.com (2603:10b6:408:111::19)
 by SA3PR12MB7924.namprd12.prod.outlook.com (2603:10b6:806:313::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Tue, 17 Sep
 2024 09:15:46 +0000
Received: from BN1PEPF00005FFD.namprd05.prod.outlook.com
 (2603:10b6:408:111:cafe::b1) by BN9PR03CA0404.outlook.office365.com
 (2603:10b6:408:111::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.29 via Frontend
 Transport; Tue, 17 Sep 2024 09:15:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00005FFD.mail.protection.outlook.com (10.167.243.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 17 Sep 2024 09:15:46 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 17 Sep
 2024 04:15:42 -0500
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <gautham.shenoy@amd.com>, <mario.limonciello@amd.com>,
	<perry.yuan@amd.com>, <ray.huang@amd.com>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Dhananjay
 Ugwekar" <Dhananjay.Ugwekar@amd.com>
Subject: cpufreq/amd-pstate: Rename MSR and shared memory specific functions
Date: Tue, 17 Sep 2024 09:14:35 +0000
Message-ID: <20240917091434.10685-1-Dhananjay.Ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFD:EE_|SA3PR12MB7924:EE_
X-MS-Office365-Filtering-Correlation-Id: 016fc540-7717-4d25-8e92-08dcd6f95048
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MLhYscM+fJEd5phbQOj+/oKd5v4BwMUgtr2qIkZVk7yh9DIlLi1NEThz4if0?=
 =?us-ascii?Q?9AVL++dQqOqS4dPn0Z41O2sUw1c9dELHD4EPjUZ6WhxirRTbvGrRLX7pwaGf?=
 =?us-ascii?Q?cGmfLQThORKvSNIoCCCy5ojdNv8KuJP6Z4MSi0eTi0o0WxbLHIlGzYVCC0+Q?=
 =?us-ascii?Q?xjtw6cAk9TdnHP7VpdUCx7XXgyuM8wOxTcU4/mKtf4um6becI0yW4An1rpe3?=
 =?us-ascii?Q?6GaE+EVL+tHcpNQssTqfrZoAuttYx2kaUoLpQKsXKE8MaCsrruBoH+YtPR3/?=
 =?us-ascii?Q?6kcE/ZoFi5N9FpKC9PRM8t148GvkrHpH0tRzVN+eCwmLrIbq7mCBhzlhZqe7?=
 =?us-ascii?Q?nSDo7QNeIj65tUHWg3MQWe0i7edSDqfl3S4BnoBgTf51zg+/YC/UmHawdX2X?=
 =?us-ascii?Q?E+ev7e8U2f8yAguf3odatKfotK9vjCfx+9lkBtwHSTHbZSSON6uECL6IwtHg?=
 =?us-ascii?Q?mlaRJ1XTHZGCT2AQDCc+JxwMQrlz8702McfFiSwMFxS32hJBb6a8b1TP2Bfv?=
 =?us-ascii?Q?55AFs1gjRzW6jUkCXWq97TOVj8OzjEit5XwSSSeeuAzE4Y6l2+1isNWRZ82i?=
 =?us-ascii?Q?7U9AsryVvnir6Aho1QRRuohQFPBb1ugcHiVdjcraqV3WKO80vObobILboapP?=
 =?us-ascii?Q?cBjFD43hSq/sHET/s/XEdmZ9FqPakmgvl5rBfxhHoWfjVq6dV2RyLRV4a6ZA?=
 =?us-ascii?Q?cl88HuRFGjAFc3AxwBO98xqvJiXea+I3466T3rXAWrVrMzq5NSci60UTY6OU?=
 =?us-ascii?Q?XfoAy26kvnPdNgXJ45VHUw0wp1dP7yL1K5KS1p34PgXSfbh7OtQb4PLr9TDj?=
 =?us-ascii?Q?sd34Awy1caDBqlcrshiaqJ8g23JdflqWqSE+lNVzaPYcusNuopO07AQvHXjW?=
 =?us-ascii?Q?51T+zk6tevgEulCXS/Esh6r4bJq+ENzGewgvHSd8LbtIRk75OOXnAXp1f7kw?=
 =?us-ascii?Q?fdPpioZ/BB8VISrwffer/yWLhwqFOYmBuUNuKVRpCtmC2k+G6dL4NBbsBS8W?=
 =?us-ascii?Q?YZ0/NQn5XoBylOL2dn5Ek/qRtY+ZCWCtPW/MA5YHoODU//INUBizJOw8EaKD?=
 =?us-ascii?Q?MoIK4zIEAx0T7RopIGIpIcWwosJQnH4989pxS6/Pmr+SsbTwbnH2blfJ0q/W?=
 =?us-ascii?Q?eFwAMQCrCW4J74QQLqYIegqjcRzA2HXMl+3lYtbZt1ISgytp5HonyPjVDzi1?=
 =?us-ascii?Q?ealfb914melIggpLvHYQV+Sly9QN05oSQIHx3Iy8/u8TsOE0RHaNrCT3p6S+?=
 =?us-ascii?Q?2ypk80tiRO7YI9su7ZWZaxEixOhqGBLKSqYHV8/04PdZ0216UCPQ5SmFMalW?=
 =?us-ascii?Q?KFx9JKbOoSJVSsDT9H19dVPczXGVvMZYLzXTYZcdCUsXuBT9D6hBWTpgP6Q7?=
 =?us-ascii?Q?ROCAqmod4kBOOmxM7T9xQJeWIGRZhrC7HNMI7ixqr/92t5t1lpK9lVR/Tazu?=
 =?us-ascii?Q?cxyNp2dM236G9nbNyB71hiz52nDOtQa2?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2024 09:15:46.1119
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 016fc540-7717-4d25-8e92-08dcd6f95048
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7924

Existing function names "cppc_*" and "pstate_*" for shared memory and
MSR based systems are not intuitive enough, replace them with "shmem_*" and
"msr_*" respectively.

Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 15e201d5e911..b7a17a3ef122 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -233,7 +233,7 @@ static int amd_pstate_get_energy_pref_index(struct amd_cpudata *cpudata)
 	return index;
 }
 
-static void pstate_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
+static void msr_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
 			       u32 des_perf, u32 max_perf, bool fast_switch)
 {
 	if (fast_switch)
@@ -243,7 +243,7 @@ static void pstate_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
 			      READ_ONCE(cpudata->cppc_req_cached));
 }
 
-DEFINE_STATIC_CALL(amd_pstate_update_perf, pstate_update_perf);
+DEFINE_STATIC_CALL(amd_pstate_update_perf, msr_update_perf);
 
 static inline void amd_pstate_update_perf(struct amd_cpudata *cpudata,
 					  u32 min_perf, u32 des_perf,
@@ -306,7 +306,7 @@ static int amd_pstate_set_energy_pref_index(struct amd_cpudata *cpudata,
 	return ret;
 }
 
-static inline int pstate_enable(bool enable)
+static inline int msr_enable(bool enable)
 {
 	int ret, cpu;
 	unsigned long logical_proc_id_mask = 0;
@@ -332,7 +332,7 @@ static inline int pstate_enable(bool enable)
 	return 0;
 }
 
-static int cppc_enable(bool enable)
+static int shmem_enable(bool enable)
 {
 	int cpu, ret = 0;
 	struct cppc_perf_ctrls perf_ctrls;
@@ -359,14 +359,14 @@ static int cppc_enable(bool enable)
 	return ret;
 }
 
-DEFINE_STATIC_CALL(amd_pstate_enable, pstate_enable);
+DEFINE_STATIC_CALL(amd_pstate_enable, msr_enable);
 
 static inline int amd_pstate_enable(bool enable)
 {
 	return static_call(amd_pstate_enable)(enable);
 }
 
-static int pstate_init_perf(struct amd_cpudata *cpudata)
+static int msr_init_perf(struct amd_cpudata *cpudata)
 {
 	u64 cap1;
 
@@ -385,7 +385,7 @@ static int pstate_init_perf(struct amd_cpudata *cpudata)
 	return 0;
 }
 
-static int cppc_init_perf(struct amd_cpudata *cpudata)
+static int shmem_init_perf(struct amd_cpudata *cpudata)
 {
 	struct cppc_perf_caps cppc_perf;
 
@@ -420,14 +420,14 @@ static int cppc_init_perf(struct amd_cpudata *cpudata)
 	return ret;
 }
 
-DEFINE_STATIC_CALL(amd_pstate_init_perf, pstate_init_perf);
+DEFINE_STATIC_CALL(amd_pstate_init_perf, msr_init_perf);
 
 static inline int amd_pstate_init_perf(struct amd_cpudata *cpudata)
 {
 	return static_call(amd_pstate_init_perf)(cpudata);
 }
 
-static void cppc_update_perf(struct amd_cpudata *cpudata,
+static void shmem_update_perf(struct amd_cpudata *cpudata,
 			     u32 min_perf, u32 des_perf,
 			     u32 max_perf, bool fast_switch)
 {
@@ -1879,9 +1879,9 @@ static int __init amd_pstate_init(void)
 			current_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
 	} else {
 		pr_debug("AMD CPPC shared memory based functionality is supported\n");
-		static_call_update(amd_pstate_enable, cppc_enable);
-		static_call_update(amd_pstate_init_perf, cppc_init_perf);
-		static_call_update(amd_pstate_update_perf, cppc_update_perf);
+		static_call_update(amd_pstate_enable, shmem_enable);
+		static_call_update(amd_pstate_init_perf, shmem_init_perf);
+		static_call_update(amd_pstate_update_perf, shmem_update_perf);
 	}
 
 	if (amd_pstate_prefcore) {
-- 
2.34.1


