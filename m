Return-Path: <linux-pm+bounces-18549-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1246D9E3D35
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 15:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6EED281AC8
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 14:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44F120ADFB;
	Wed,  4 Dec 2024 14:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gA/FoQZ5"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0226F1F709B;
	Wed,  4 Dec 2024 14:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733323787; cv=fail; b=dzRafIzHJsLMMs2qHJ03MZTlJHR+6k/U3U4VQLX6uPSNBMrmqnv7sP9DPY9ev+Tb+up9q0yO/HVVhz3RuKlIXZuxMO/HVSUmzrFz8Nb6VtM/faT4tXzFPLqGk/xs28sIgDMcNCoS8e0vp2ngMmCZvhX05MaHGOjlpFp+Jyrgwkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733323787; c=relaxed/simple;
	bh=lajOZJ3zNYtrbEAzqQu7C8X5Kz65PJvau/v8WSAw/nI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c/cxEPd/ImuQEgagQFL3sfdBVOLgju87IiRDueXjb6MreiklXqNIXiGrRRzr8VW/0HtHvzGZVdBVrOZ8oG950RjaNO/naxD8xfzMqbjRbsabMG20dLJuf1LvRJSbsX17/T0Psh4m6Gl0odf+DiNzELCw+yg/3G+kSVG+lLoTaqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gA/FoQZ5; arc=fail smtp.client-ip=40.107.93.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kj95xM8xoYMOvTYAFnEQrmX97hz6ee/UhPBNPR8/tMM0cFBY6Kiw0smpeXDlMvVIyE8XjBa51WtF/8LzPz8Y454lUsZ1Xbt0b0CBvqlvgiltg9RWdLbL3objkBH9rumwFLUnD9qgLg3wUcfA5h9mUiq/mMNCejzJ9pWOis5z1Re3dw/rjuvMmGGvzuCtbFvfqlBIXYfXoYI7mt4eYMxpYanE69WK+9idL1OmtHByw0miNLc3vweQBBWz9ChHtkfiQKKxLWNMAARplMF4kAzPVXTNMpBCf9LTs70Qai7Q8CXxHlM/mis9mgSPFrMt5H7eRZpH/T42rn3TQJZoD5kjsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8JKW00FhiWKJLvZ61pXRfLgTx0yIQTaA5Wwuw0ToXgc=;
 b=ZFjWNxsll1By3f/h/jfXLnPZNc8MY1MyahVDdIOZSecX3umIKSy0GdgIx41/Pyi8n4hxO8VCI2fpAtw2eaH3KsU8kgdGi1xf7Q3AskTdbRSBi869HR36dWyfgERH7dL9uWRj9UnBKiC0edPBBL66KnC+hUv0iET1CfAxvmnJv6PsaVacwePDVniiXRov8f4my7ev+3v5TJIuB8iOe2mr93Hh0Cmk6sfqz638vMYpoDpRvprUcDbIOzuqF71XZqWeNnHiKwcrjOqH0KN0CSfFi8VOpb0Kmh5wHsSwGbMQ2cJnfNALSg/WO4Hk/eZXfOgAuufu/31/lvh2uzxNpgoq0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8JKW00FhiWKJLvZ61pXRfLgTx0yIQTaA5Wwuw0ToXgc=;
 b=gA/FoQZ5syu1T6TKrzjFwf6M/mnoN6vedg+00VPKUz+2Lorks76hoQ52BYKsbtz1uMy+z/AyW0cSjbSyRUA+x7gHeaJDqJJ57X7d/pwKt7kFNra9xqxdf4fh2KTXfbDKmZ6c3KoXrMzL/l4PqcN7SZGkrVMkvw4aVUBzFQCXBZw=
Received: from SN6PR2101CA0023.namprd21.prod.outlook.com
 (2603:10b6:805:106::33) by MN0PR12MB5954.namprd12.prod.outlook.com
 (2603:10b6:208:37d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Wed, 4 Dec
 2024 14:49:41 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:805:106:cafe::4f) by SN6PR2101CA0023.outlook.office365.com
 (2603:10b6:805:106::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.8 via Frontend Transport; Wed, 4
 Dec 2024 14:49:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Wed, 4 Dec 2024 14:49:41 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Dec
 2024 08:49:37 -0600
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <gautham.shenoy@amd.com>, <mario.limonciello@amd.com>,
	<perry.yuan@amd.com>, <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Dhananjay
 Ugwekar" <Dhananjay.Ugwekar@amd.com>
Subject: [PATCH 1/5] cpufreq/amd-pstate: Convert the amd_pstate_get/set_epp() to static calls
Date: Wed, 4 Dec 2024 14:48:38 +0000
Message-ID: <20241204144842.164178-2-Dhananjay.Ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241204144842.164178-1-Dhananjay.Ugwekar@amd.com>
References: <20241204144842.164178-1-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|MN0PR12MB5954:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ddefad0-d021-4c29-4510-08dd1472e25a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g8CIBTHX2y1p31xrk5yxHXhouQI6Sc+i9mwLwioPbOrSPKns8iZ+xRoXRl76?=
 =?us-ascii?Q?ITl5mhddBBpxcOZ3FbSuwXwIdxZsv9pimScItOXpYMUE49L6EbHpMUrtNwNk?=
 =?us-ascii?Q?CsMDUr4ERyEgs7cOnqSLCOfNpV2MKb8hUMZT6WIMfWc1fTmGF0pBRoIPksmX?=
 =?us-ascii?Q?Ei208bfp7Zk/1KvE5sWBz1qVn4SrGftWCpNoBHHKMeUsC6rG8htA9I8LeSEf?=
 =?us-ascii?Q?hAKVsYpvYFrtPAUcxQ+eSay3Ix6/KxJqluo4rz7TET6IImKtXlMmqMOFcVxH?=
 =?us-ascii?Q?KxXwXM+kYiTyy9cWOLpfLdNQlco+ix5EwboJ84Ta+WFU6E2LLVKxwJaLza5L?=
 =?us-ascii?Q?Vc5IO+Doaoshq4nCuGQZNmCZRDUrdzCZvzHj2iz+3S8am52fzttHbwTJ1Hqx?=
 =?us-ascii?Q?oS14OgpmiNsbEq1ZELB/Z+JG4OJu1JxrqBQ+xmyxeuc0wC4bu7U7Zopoz9G3?=
 =?us-ascii?Q?2GHuExD1vXJDIxZuAfBdWnS+QMRKfQNnWdRUlGWXfFWLkvzeu1L2hyFjNRbV?=
 =?us-ascii?Q?vnpd4OL4x2RDO9CBPQtq4c5WiYB85rd4pEYblw09bn9NNG6b1v2uwAJmyNU5?=
 =?us-ascii?Q?Ny4XJ2dyEB36crCkJr5KCCYcuisONVRPk7+PdcC8SvQx3joQJnmEd7JnRPWl?=
 =?us-ascii?Q?WZjkjKm4HKDJ9FdK7Nh/s6yMkeWxBSdF4unscdpoGjwgbua0TXKQ+sk6Yoo2?=
 =?us-ascii?Q?bUONBRLyEe8kvywgV8JmFFPJ4TaFjusgALGl247VHmTYVcrsKT3XS0gRdnku?=
 =?us-ascii?Q?doDirhqvBcuhY5awx4VdJHGZXBbir8BSIPIgjgZPLaCHMYyeerOQUmPlYuKJ?=
 =?us-ascii?Q?p9th2d1oYk/2B1pAeb0/5R2PZoCi9lH0QRnKZm/RP5x8BIdrar9oZiqPmjKO?=
 =?us-ascii?Q?feGj8S5NIF1m1VdHghXwbnes8QwIpUlAt+NVNlVTgHqVM3DY1nG38XVDPMsd?=
 =?us-ascii?Q?FCrkQk6ploZ9o7KrdZTfMW44Rz0VdqroB0urH8zaVTpN19FHSYJg1y7Ri6BF?=
 =?us-ascii?Q?h38IpdLzrN7NJltYcyaKK6d5WOK59ztOrfZDlZee+CgqCRYS50GVxEwU6QQ2?=
 =?us-ascii?Q?5Ls4OfbDiwa7wzEVXb5pflvQICZPCtmXE0IlO8rupOeBWPmcykLqpqyS1L9+?=
 =?us-ascii?Q?8pjFCYN4w4cxqF63RMkyBjfYOv77GtnZhcHsG6NIXNk+l3cpaiZLMO4BVOU1?=
 =?us-ascii?Q?SbahhQYeBGCpQMHqdRKJ3YMcVy1t3H+8R8YpMF20eh5geXQdmeCUNbgIdVnc?=
 =?us-ascii?Q?Gj0VNQA40V+mgyVcfYoPRLUTkHQQBcMOmrjUnn4gbozLHQNmSjF4M+UpqyXa?=
 =?us-ascii?Q?NAvdcIVjHXYUkGsTlI1owETyKgVlxyg0o7lmErDgh80FzxxhU8OszAJ7c3lA?=
 =?us-ascii?Q?fmmQolZAqFLRkP8YbbpclwM0MMQ/gU8QPLN2G/766yP8LPDTiMaWGPSnYQRP?=
 =?us-ascii?Q?58oBy7EFr07NqyVxR2XaxZbK7HbQPUmp?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 14:49:41.2090
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ddefad0-d021-4c29-4510-08dd1472e25a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5954

MSR and shared memory based systems have different mechanisms to get and
set the epp value. Split those mechanisms into different functions and
assign them appropriately to the static calls at boot time. This eliminates
the need for the "if(cpu_feature_enabled(X86_FEATURE_CPPC))" checks at
runtime.

Also, propagate the error code from rdmsrl_on_cpu() and cppc_get_epp_perf()
to *_get_epp()'s caller, instead of returning -EIO unconditionally.

Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 92 +++++++++++++++++++++++-------------
 1 file changed, 60 insertions(+), 32 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index d7630bab2516..d391e8cafeca 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -180,26 +180,40 @@ static inline int get_mode_idx_from_str(const char *str, size_t size)
 static DEFINE_MUTEX(amd_pstate_limits_lock);
 static DEFINE_MUTEX(amd_pstate_driver_lock);
 
-static s16 amd_pstate_get_epp(struct amd_cpudata *cpudata, u64 cppc_req_cached)
+static s16 msr_get_epp(struct amd_cpudata *cpudata, u64 cppc_req_cached)
 {
 	u64 epp;
 	int ret;
 
-	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
-		if (!cppc_req_cached) {
-			epp = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ,
-					&cppc_req_cached);
-			if (epp)
-				return epp;
-		}
-		epp = (cppc_req_cached >> 24) & 0xFF;
-	} else {
-		ret = cppc_get_epp_perf(cpudata->cpu, &epp);
+	if (!cppc_req_cached) {
+		ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, &cppc_req_cached);
 		if (ret < 0) {
 			pr_debug("Could not retrieve energy perf value (%d)\n", ret);
-			return -EIO;
+			return ret;
 		}
 	}
+	epp = (cppc_req_cached >> 24) & 0xFF;
+
+	return (s16)epp;
+}
+
+DEFINE_STATIC_CALL(amd_pstate_get_epp, msr_get_epp);
+
+static inline s16 amd_pstate_get_epp(struct amd_cpudata *cpudata, u64 cppc_req_cached)
+{
+	return static_call(amd_pstate_get_epp)(cpudata, cppc_req_cached);
+}
+
+static s16 shmem_get_epp(struct amd_cpudata *cpudata, u64 dummy)
+{
+	u64 epp;
+	int ret;
+
+	ret = cppc_get_epp_perf(cpudata->cpu, &epp);
+	if (ret < 0) {
+		pr_debug("Could not retrieve energy perf value (%d)\n", ret);
+		return ret;
+	}
 
 	return (s16)(epp & 0xff);
 }
@@ -253,33 +267,45 @@ static inline void amd_pstate_update_perf(struct amd_cpudata *cpudata,
 					    max_perf, fast_switch);
 }
 
-static int amd_pstate_set_epp(struct amd_cpudata *cpudata, u32 epp)
+static int msr_set_epp(struct amd_cpudata *cpudata, u32 epp)
 {
 	int ret;
-	struct cppc_perf_ctrls perf_ctrls;
-
-	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
-		u64 value = READ_ONCE(cpudata->cppc_req_cached);
 
-		value &= ~GENMASK_ULL(31, 24);
-		value |= (u64)epp << 24;
-		WRITE_ONCE(cpudata->cppc_req_cached, value);
+	u64 value = READ_ONCE(cpudata->cppc_req_cached);
 
-		ret = wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
-		if (!ret)
-			cpudata->epp_cached = epp;
-	} else {
-		amd_pstate_update_perf(cpudata, cpudata->min_limit_perf, 0U,
-					     cpudata->max_limit_perf, false);
+	value &= ~GENMASK_ULL(31, 24);
+	value |= (u64)epp << 24;
+	WRITE_ONCE(cpudata->cppc_req_cached, value);
 
-		perf_ctrls.energy_perf = epp;
-		ret = cppc_set_epp_perf(cpudata->cpu, &perf_ctrls, 1);
-		if (ret) {
-			pr_debug("failed to set energy perf value (%d)\n", ret);
-			return ret;
-		}
+	ret = wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
+	if (!ret)
 		cpudata->epp_cached = epp;
+
+	return ret;
+}
+
+DEFINE_STATIC_CALL(amd_pstate_set_epp, msr_set_epp);
+
+static inline int amd_pstate_set_epp(struct amd_cpudata *cpudata, u32 epp)
+{
+	return static_call(amd_pstate_set_epp)(cpudata, epp);
+}
+
+static int shmem_set_epp(struct amd_cpudata *cpudata, u32 epp)
+{
+	int ret;
+	struct cppc_perf_ctrls perf_ctrls;
+
+	amd_pstate_update_perf(cpudata, cpudata->min_limit_perf, 0U,
+				     cpudata->max_limit_perf, false);
+
+	perf_ctrls.energy_perf = epp;
+	ret = cppc_set_epp_perf(cpudata->cpu, &perf_ctrls, 1);
+	if (ret) {
+		pr_debug("failed to set energy perf value (%d)\n", ret);
+		return ret;
 	}
+	cpudata->epp_cached = epp;
 
 	return ret;
 }
@@ -1867,6 +1893,8 @@ static int __init amd_pstate_init(void)
 		static_call_update(amd_pstate_cppc_enable, shmem_cppc_enable);
 		static_call_update(amd_pstate_init_perf, shmem_init_perf);
 		static_call_update(amd_pstate_update_perf, shmem_update_perf);
+		static_call_update(amd_pstate_get_epp, shmem_get_epp);
+		static_call_update(amd_pstate_set_epp, shmem_set_epp);
 	}
 
 	ret = amd_pstate_register_driver(cppc_state);
-- 
2.34.1


