Return-Path: <linux-pm+bounces-16292-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5069AC7B5
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 12:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B969B22B04
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 10:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCF21A0BD6;
	Wed, 23 Oct 2024 10:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3PAfUNsi"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E2A1A3AB1;
	Wed, 23 Oct 2024 10:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729678950; cv=fail; b=MbLfraB8er7dniWhYOIAUx8Mt51bOafgaECuWIA583vNY5MdbPfYdqneW338pO3Yc7JvP4xp2b4KDnqGU2Ye0Uf2MREGk4FGhRFU2Wllp2Z3TXiVwKM0TfxIfM+w+kWY4FNpLLQ/NrTKW0VP1yfvBqypQmiDV0Xa6r5XS+iGO9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729678950; c=relaxed/simple;
	bh=YWU43ExnNRRx+O1o/cvLg8ZoE+XGcC9xQ5a6rg1GccY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ijqatCurKsvPv9IO4tQquVuAKu6TWk6Qj3YJ29398fqIR84BHIddziM1Bsthca1xlj7qdkN7pQcfp1eyuXOSDmJXQALCD8Tqj5XLifSbfcxbbL+InWcWWcHnxuHY/PH6iX1UYFo0TE2eMPA7TcRNvLFXntj8Wztd6+fmLn9jUcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3PAfUNsi; arc=fail smtp.client-ip=40.107.92.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iyzu6MSnAAPH1pL4l9FOB2qmRLaqAl4wtytrZ8qazEOtV4NXpvTQvb9x0lNYEgeZ8cM/kGQFqy35eJkQGOHmGgrjairVX/osPENTDyk7WFjewggV8ftiiZKnuDTBT8sNFhWJbwQspZGJokxniaHLguFDynSjDNRcwFCxuTlDq9x2OBMIKvxAOGT1ObO1o2KzYbPmbqlBdmVlAJBJL8/PMO4HwzKaEuvLw5ujAj2/H4TW62VAKU0plude1a/f6ia9l0SSHeI898IBIKHBXpvBsQFEaRhjb4ZtGxrhPuQ6FoX6mu4cgn7nq4TseID7W2t7FeWeloWsbnv8Mrv6cjNz6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=THmELJVVf6pfoHTN7s94g41BqJSIgmFnwGoF19ojb1Q=;
 b=EglDGN4OXDaQF4Jt5frk7DeWDxlYZ+sRsp77DWdEkAbxv8rYIFHDMkQpcUJqUtgBMoM33BJxwZxPqDhJC2EdaY2ufqM8zKSE4Z/60/4i66kqx0eJAS+STEawxp3nEPuMXtR5qKiHxqy9He3fVbV5STR2lxSkFI2hk+BxuThAUzdxdDK9bEnuCVBOFcql1EqmjjFvduL6X4NyVQ59dzqG69pDe39DL2HYcFCaPmzvTDE3NGfQhATWFp/kEcVsVMB8OhSWQh+B8pIDjPWuHj3H8Aronw9P7z/r6KHYQmrPdHrtj/zIAuyCBZKlOOmyxT7hflrnKnq/9JnZvYoRiCs02g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=THmELJVVf6pfoHTN7s94g41BqJSIgmFnwGoF19ojb1Q=;
 b=3PAfUNsiyljq2HHaZrQJMDQcQRL+60iO9qnYFtkocsOp4RhLl/EZfk+KElYDJhNF0KxQTg8IpEE+wBtyEC+dDQ8D9EYG1SmCzCgWdw61ZLJyMQhQH7nocSU3hn+0tDVp/k0OnL/axJ2RMOqqu0ilMnCZUK1/kLItXSW0sivfDUw=
Received: from SN6PR01CA0034.prod.exchangelabs.com (2603:10b6:805:b6::47) by
 DM4PR12MB8521.namprd12.prod.outlook.com (2603:10b6:8:17e::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.18; Wed, 23 Oct 2024 10:22:22 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:805:b6:cafe::98) by SN6PR01CA0034.outlook.office365.com
 (2603:10b6:805:b6::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Wed, 23 Oct 2024 10:22:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 10:22:22 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Oct
 2024 05:22:18 -0500
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <gautham.shenoy@amd.com>, <mario.limonciello@amd.com>,
	<perry.yuan@amd.com>, <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Dhananjay
 Ugwekar" <Dhananjay.Ugwekar@amd.com>
Subject: [PATCH 1/4] cpufreq/amd-pstate: Rename functions that enable CPPC
Date: Wed, 23 Oct 2024 10:21:06 +0000
Message-ID: <20241023102108.5980-2-Dhananjay.Ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241023102108.5980-1-Dhananjay.Ugwekar@amd.com>
References: <20241023102108.5980-1-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|DM4PR12MB8521:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d937336-6e25-4b42-0bb5-08dcf34c9513
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zQLsN0geA+2ZXzq3h21KxEqODazLBarY04NvtTDThDZMnNaKS/KDTjKG0xIN?=
 =?us-ascii?Q?dJ2+pQIH5SYdRAzUk7xfOFwNwvAjRSFx5IHkCAJ5EYl7+7tjMdDM2joPfOKO?=
 =?us-ascii?Q?2jsZJGHU/NyrDesPAXos8GxJ3DlmRtUWYp7WTaXhdmlVE9/bDdJh6eT+CuRv?=
 =?us-ascii?Q?mqljfdMCCZONMOshZm1F7WPYa0HREBEA4ug3M3pItdRLriipaNIi3vpbRSrU?=
 =?us-ascii?Q?vwvcjE3ObPSgRgXQwgc0DKeTKWHcGv5FQXRT/okruZT10+PvQhH6BWVAKIdB?=
 =?us-ascii?Q?Bs8Ndmibhtp2QZ/3ZRkvYSYdptuYdYUKkn32TQLifGOj/RJTMDiw4+RYYPGS?=
 =?us-ascii?Q?x83TgTtRKGUTYbKyfO0qeK8Njf6D2HVqG5P9saIvOQ/3stGRhQgl3uFy6gy2?=
 =?us-ascii?Q?dE10/F428Vq9KzH/pXXCYmj5yqVCyqqVtUP0748ExJmd5EBFt5yYYjHxY9sC?=
 =?us-ascii?Q?oNnzVYC4dZTWQG0EDRFJ/Gl6InOcKRoDVtfBYkl88FweEQ7Aa51f0QHfai85?=
 =?us-ascii?Q?aPr3+7SP8XU3Y4UvIGQ553aR3l4fxCijD6yjjIcszoyufmP17UCt19rfndM9?=
 =?us-ascii?Q?vEEfIm5QOODTZq6x6v5FTDWLxhMyjYqXHrSmEVfAsKyIVBs+1RZ2WuHE5PuZ?=
 =?us-ascii?Q?rvFbPZkO2DMX66NrL9YWexr3/P9kIGw8q48pi32N8KyHf0SleBMNWsMDCXYW?=
 =?us-ascii?Q?CPfll4uSYYuPsUfKqce6grjZypcyu/KkhNNNjE3o1E2OeCXPJestyJoOGSXv?=
 =?us-ascii?Q?t/Fj5jGcpPwgNmfaHLJ3pepji1WHVr24Xz+N/LyjFfRdU0ui779A+wXDibYS?=
 =?us-ascii?Q?kAgGLrFVsv9M3D40TN3/KBJQEkokbjfP+B3VBPkbmjX8PLkQP0IGDQQmAknA?=
 =?us-ascii?Q?3apObKS5QjjpmTmhcrmafqKdCipJM6EZSHWR23ImmhImDm0j8hr9p1hsf7zt?=
 =?us-ascii?Q?SVmNDwmUWiFhcqPEqPGNP23ZhumejzKQb5VjhHC8ycSwDWxLfYgaLGqYPBEM?=
 =?us-ascii?Q?ZRGEZ5Hr7oJ6VhvAp7EuKOttkISE6n+oe7z5SI+i2/ySW0to1hcByBJC/4E/?=
 =?us-ascii?Q?pFooDABRZEgL7Kj0IMPm1aef+UbdqrjyVzFvI6W578ep4HCPk6zpt4wGFLz+?=
 =?us-ascii?Q?TL3rg04oTUdUbBuxP4UYccj/cbgg5DQZhQ9dXwcz6iSQrlSJT0hNdHKBvrXI?=
 =?us-ascii?Q?OZrFHNYL9voGAGljOSCqWdE2R9vLJhQF8iX05QO46wg8AIonvygzzt9wJL3b?=
 =?us-ascii?Q?K+M60dRRD3XXQkFnIM38ggNO9JXDwpB9udyAdVw+mZgI0D+vKcW68KZ4Pjw2?=
 =?us-ascii?Q?m5a7seRaUwo1TXJOcyki1S592KfuRO4vpZQ4O/hUx5WgUTXVeIA3qIJpGtdF?=
 =?us-ascii?Q?AFQaSThbMt0aoP8Tu7e9eZOD7Epj3AFZfygoy3zdCqWo2PjkTA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 10:22:22.3103
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d937336-6e25-4b42-0bb5-08dcf34c9513
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8521

Explicitly rename functions that enable CPPC as *_cppc_*.

Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 3c14962adeb2..0b4a4d69c14d 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -306,7 +306,7 @@ static int amd_pstate_set_energy_pref_index(struct amd_cpudata *cpudata,
 	return ret;
 }
 
-static inline int msr_enable(bool enable)
+static inline int msr_cppc_enable(bool enable)
 {
 	int ret, cpu;
 	unsigned long logical_proc_id_mask = 0;
@@ -332,7 +332,7 @@ static inline int msr_enable(bool enable)
 	return 0;
 }
 
-static int shmem_enable(bool enable)
+static int shmem_cppc_enable(bool enable)
 {
 	int cpu, ret = 0;
 	struct cppc_perf_ctrls perf_ctrls;
@@ -359,11 +359,11 @@ static int shmem_enable(bool enable)
 	return ret;
 }
 
-DEFINE_STATIC_CALL(amd_pstate_enable, msr_enable);
+DEFINE_STATIC_CALL(amd_pstate_cppc_enable, msr_cppc_enable);
 
-static inline int amd_pstate_enable(bool enable)
+static inline int amd_pstate_cppc_enable(bool enable)
 {
-	return static_call(amd_pstate_enable)(enable);
+	return static_call(amd_pstate_cppc_enable)(enable);
 }
 
 static int msr_init_perf(struct amd_cpudata *cpudata)
@@ -1042,7 +1042,7 @@ static int amd_pstate_cpu_resume(struct cpufreq_policy *policy)
 {
 	int ret;
 
-	ret = amd_pstate_enable(true);
+	ret = amd_pstate_cppc_enable(true);
 	if (ret)
 		pr_err("failed to enable amd-pstate during resume, return %d\n", ret);
 
@@ -1053,7 +1053,7 @@ static int amd_pstate_cpu_suspend(struct cpufreq_policy *policy)
 {
 	int ret;
 
-	ret = amd_pstate_enable(false);
+	ret = amd_pstate_cppc_enable(false);
 	if (ret)
 		pr_err("failed to disable amd-pstate during suspend, return %d\n", ret);
 
@@ -1186,7 +1186,7 @@ static ssize_t show_energy_performance_preference(
 
 static void amd_pstate_driver_cleanup(void)
 {
-	amd_pstate_enable(false);
+	amd_pstate_cppc_enable(false);
 	cppc_state = AMD_PSTATE_DISABLE;
 	current_pstate_driver = NULL;
 }
@@ -1220,7 +1220,7 @@ static int amd_pstate_register_driver(int mode)
 
 	cppc_state = mode;
 
-	ret = amd_pstate_enable(true);
+	ret = amd_pstate_cppc_enable(true);
 	if (ret) {
 		pr_err("failed to enable cppc during amd-pstate driver registration, return %d\n",
 		       ret);
@@ -1599,7 +1599,7 @@ static void amd_pstate_epp_reenable(struct amd_cpudata *cpudata)
 	u64 value, max_perf;
 	int ret;
 
-	ret = amd_pstate_enable(true);
+	ret = amd_pstate_cppc_enable(true);
 	if (ret)
 		pr_err("failed to enable amd pstate during resume, return %d\n", ret);
 
@@ -1686,7 +1686,7 @@ static int amd_pstate_epp_suspend(struct cpufreq_policy *policy)
 	cpudata->suspended = true;
 
 	/* disable CPPC in lowlevel firmware */
-	ret = amd_pstate_enable(false);
+	ret = amd_pstate_cppc_enable(false);
 	if (ret)
 		pr_err("failed to suspend, return %d\n", ret);
 
@@ -1861,7 +1861,7 @@ static int __init amd_pstate_init(void)
 			current_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
 	} else {
 		pr_debug("AMD CPPC shared memory based functionality is supported\n");
-		static_call_update(amd_pstate_enable, shmem_enable);
+		static_call_update(amd_pstate_cppc_enable, shmem_cppc_enable);
 		static_call_update(amd_pstate_init_perf, shmem_init_perf);
 		static_call_update(amd_pstate_update_perf, shmem_update_perf);
 	}
@@ -1886,7 +1886,7 @@ static int __init amd_pstate_init(void)
 
 global_attr_free:
 	cpufreq_unregister_driver(current_pstate_driver);
-	amd_pstate_enable(false);
+	amd_pstate_cppc_enable(false);
 	return ret;
 }
 device_initcall(amd_pstate_init);
-- 
2.34.1


