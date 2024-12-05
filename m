Return-Path: <linux-pm+bounces-18661-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1B19E60A5
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 23:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B937B2849C4
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 22:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2EF213223;
	Thu,  5 Dec 2024 22:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oEqCUND9"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25C11E008E;
	Thu,  5 Dec 2024 22:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733437760; cv=fail; b=b1pFO46ciaZbCoM9T+Nda1FJrVsygwCKnBE8o/nmGMHpQDADKA3gfb5b1xZyj7lgcFiqLf4jQETrCiin43T4NRTcZVq+f262iyjLRG2NcZ/kAagRapKy2Xq2TQ8OWfrmR7egOZjpoqjJxHLHYq+nnWoeYpTFgqqy7hc0WQ1pNio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733437760; c=relaxed/simple;
	bh=XmViq3gapgE5Fzv/GUi+sCNowHrrU9Khhkp++BvmALo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l2I/kAl5ctJTSv8sGE8/rx00GKnLbDLt0fIe4Ec44ccqTuCIr0DmzQ4stRsXvS+wQv/qGvxP/2P0Jz8vtbYCVGlrPWzazXULZ3GUZJo+QxXJRc21tfBPmEE6bQeIzmXKaY7ON7pTUW5HNMuRrsNt3CEdb2S+pPjiWYG23tvYYvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oEqCUND9; arc=fail smtp.client-ip=40.107.94.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cuuxuSxt3N5PCJo1WgvCrL+0P1N7iC4ANcBM6jpChDomX2SFvAsjrhAxc3mpamTVB/sy0f+BXsv+E1sDTYAIDeYNH4HBb+pVOAKn7fbdfhT/wMFuFumban7nnyv68lE7cz1bTxRrzpR57XkJlj6qOLISqX7oA46uuIEL7ZtIE+EefUUeviHAx1rDxSjfphNmYL+cwwvooKX9HYQI+jP8u2XF5U0kevjOUD/6kPn8kDyjk2Mf4L2eQTDO10PpZPiKup9PhTbouEss1XYxvxT/bUt42RcsOaoRTKHtllBmSRupmwDTjauF/AXize6TGRhtsRAeeTUhw2jp7s0nUQOWKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qpp8DcjqIai4lzafmzvdAOM/LeO7YVG1IMhlzc84Pbo=;
 b=xJotLEm3BoqwIvgz7WpQxZkKlzHd2LuvNa+u+LFTbTBK8VtbhquIRYITz8iyB806/djbInjk/uBcJxtoT29u0AN3c+KWoqB6ZIdGnJX9EOUax1tdIzTezSd716/6r4qSz2uJ6NIv2j8mamvmz1gSPoBQ8N/6Vwixa6+vQK1o96F73wXAGldao9zZT70jUw4Yk7IPRp0nGJ0IsjLCNsN287Xb4reUDWuSOd0Hj68xsruKljAC0BTXLroxZ10JFH3tqF8HLq8CsEy2JfZCR4lCCewX1lNz5J2yz7pkJK9Tht8n70VJ/zqtKETDZnNnb5PwJTDq2sMMzVf0IWci3j050Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qpp8DcjqIai4lzafmzvdAOM/LeO7YVG1IMhlzc84Pbo=;
 b=oEqCUND9yZf6K7Y4qYLXlkF9T1D/VXvD6nyNAXRyepyM72z5pPmDbQQAeO5ZQAZdgx8wn1UiDVuRg0RK9FOzWxmZNnvMM4JU1Cr5saVJLLdF29ugrOtjgrksiYQQXYbnerQsPqB5kAvF34p7Jw6vt9C4Ejbn0QSvyNq0Onp/Jkg=
Received: from CH0PR03CA0193.namprd03.prod.outlook.com (2603:10b6:610:e4::18)
 by PH7PR12MB6884.namprd12.prod.outlook.com (2603:10b6:510:1ba::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Thu, 5 Dec
 2024 22:29:12 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:e4:cafe::65) by CH0PR03CA0193.outlook.office365.com
 (2603:10b6:610:e4::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.9 via Frontend Transport; Thu, 5
 Dec 2024 22:29:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Thu, 5 Dec 2024 22:29:11 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Dec
 2024 16:29:06 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 11/15] cpufreq/amd-pstate: Cache EPP value and use that everywhere
Date: Thu, 5 Dec 2024 16:28:43 -0600
Message-ID: <20241205222847.7889-12-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|PH7PR12MB6884:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d07fbd9-79a5-4484-86d5-08dd157c3e00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tjEe1fMFYo6D7L1s7esIYSL/PokUm/bJguyW+SY6zrOAYxrl6153nQEYrT3W?=
 =?us-ascii?Q?cZfN34eHiw/RDbdPXHjBZLfbfWLYDoAhVTICIyqAEKe+BQMPgeuLLBl3nUQN?=
 =?us-ascii?Q?4MzATzrqDA01CHs3MoRBJv8V+8rhztEtNY+VI3K13lXipc+GJ6yWmJ73rT1H?=
 =?us-ascii?Q?UlHzvXGvKb1SI2U3Al/+RqXCWh59uzZECuSglIInujzca7TSLNc/6ssle1Gz?=
 =?us-ascii?Q?ZjYNNJGcoo2/CQFKSwmi2UgMtsIrnA8nmMRDrYTiqQCZsj4+hqrkJcsOBSBa?=
 =?us-ascii?Q?kMR1ueiqWhQtQzX3cPocsQcOMHf7uSVTAOvdaXdhC/lZ5Vk6p7Kxr9Hxnh5I?=
 =?us-ascii?Q?eg6PosOJF4C/UamKIY4ToQ4rg3hcPRxbgAuI1r96UEOHyXOIj5oTF9YIN1qV?=
 =?us-ascii?Q?vIY2hv2UR2OQKJtgViUWH2Yul1hwRvmrZcRccvuy5CAb3v7+oAV3aBYnRRJH?=
 =?us-ascii?Q?SPN2zV8szrBOYr1m8YfyYQJz7wIGU6jD9MQq5FzQ4bei9uNzZ4Brq2T/ksZ0?=
 =?us-ascii?Q?pbssE8MGpzl/aiRhDyiP0pVvyai6lMggzB4ZreTXS17gEAZGczKJSOxIrBSR?=
 =?us-ascii?Q?3IJRSNpCJXrJFgOxXEhr2HTBDaFWFo6yxlujcLbgHDQMLY3KWft5WpjzxUrU?=
 =?us-ascii?Q?06AAYyMDqHLynztQOKwynhTdYMSGTemTE/fH4ndb8HdPWDlKE5LdHLVzTqz5?=
 =?us-ascii?Q?dT6XZL3RUOXN7WpzDyBONyAe342c0unI6KodLGoJfidIVMF+qLeZ8rnlPnmP?=
 =?us-ascii?Q?2uKUQKB0qiWrn0KaAmVyWE01EvwtzNpjrWyXgoefqCJz7Vj/igK/N8E1gBf3?=
 =?us-ascii?Q?/TlxktgjjfHAwlMFTfPn5kIpsV9Y+JvdUhgZonFD2qloi7ERSyhKf5XB1/Ju?=
 =?us-ascii?Q?nTiJpuaBxFObS7tWWuPoHB8Rt/ECxSW0KnxShPBpcj5BD9rwV3Yq7iGvD/4+?=
 =?us-ascii?Q?OH21dA9iN1woikvHASXxeVZ2QxlmKI5qLBnKNs+lYT8xZBjLbdiikwnX2ZoR?=
 =?us-ascii?Q?ZSMQidRWYNDN/Lp5CUijaO0uTlyUdCZrOZE61jlvxdjq5VxrrWCMoPF4piCi?=
 =?us-ascii?Q?hUADW9jzSLsfyAIN9mMEpH/FhDK2v/Cgjvh+Bv8q0sZifko4rxlP4QzarGnO?=
 =?us-ascii?Q?cn7poY43XvcN+F0Ut3EmvBXVFCVbV/3lZIHLS9LABuqkMH1FlZiiLPGfMZGr?=
 =?us-ascii?Q?ByzmLqoCplUHx6P6wJ1BvApqD6BypyjZ+cWM6XWyi6I5joHrPQxDnYmvP89t?=
 =?us-ascii?Q?J2K+gXV77cl96kwVQe1zqXUU1x2zD9Yc8EP3z/iO4f7k/RlwF/iWSHs2ZEb+?=
 =?us-ascii?Q?UfUYwQc3NVDgyoCXaOfvLGO+HiwePwn49wTQOVi8wabe9aXyKuh43qok/ggE?=
 =?us-ascii?Q?E0D/4WSh9RM1zyejVMuB8A0Lf08luzc0OZNQf5xt+S5TXFTS8qSKSeE5Vkd3?=
 =?us-ascii?Q?pQSaxd+DKT8omMsiDHFoQm3mM5hZvV9r?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 22:29:11.5890
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d07fbd9-79a5-4484-86d5-08dd157c3e00
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6884

Cache the value in cpudata->epp_cached, and use that for all callers.
As all callers use cached value merge amd_pstate_get_energy_pref_index()
into show_energy_performance_preference().

Check if the EPP value is changed before writing it to MSR or
shared memory region.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 107 +++++++++++++++--------------------
 1 file changed, 45 insertions(+), 62 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 5ee53b45c1ca1..20de3a9fd992d 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -186,29 +186,28 @@ static inline int get_mode_idx_from_str(const char *str, size_t size)
 static DEFINE_MUTEX(amd_pstate_limits_lock);
 static DEFINE_MUTEX(amd_pstate_driver_lock);
 
-static s16 msr_get_epp(struct amd_cpudata *cpudata, u64 cppc_req_cached)
+static s16 msr_get_epp(struct amd_cpudata *cpudata)
 {
+	u64 value;
 	int ret;
 
-	if (!cppc_req_cached) {
-		ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, &cppc_req_cached);
-		if (ret < 0) {
-			pr_debug("Could not retrieve energy perf value (%d)\n", ret);
-			return ret;
-		}
+	ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, &value);
+	if (ret < 0) {
+		pr_debug("Could not retrieve energy perf value (%d)\n", ret);
+		return ret;
 	}
 
-	return FIELD_GET(AMD_PSTATE_EPP_PERF_MASK, cppc_req_cached);
+	return FIELD_GET(AMD_PSTATE_EPP_PERF_MASK, value);
 }
 
 DEFINE_STATIC_CALL(amd_pstate_get_epp, msr_get_epp);
 
-static inline s16 amd_pstate_get_epp(struct amd_cpudata *cpudata, u64 cppc_req_cached)
+static inline s16 amd_pstate_get_epp(struct amd_cpudata *cpudata)
 {
-	return static_call(amd_pstate_get_epp)(cpudata, cppc_req_cached);
+	return static_call(amd_pstate_get_epp)(cpudata);
 }
 
-static s16 shmem_get_epp(struct amd_cpudata *cpudata, u64 dummy)
+static s16 shmem_get_epp(struct amd_cpudata *cpudata)
 {
 	u64 epp;
 	int ret;
@@ -222,35 +221,6 @@ static s16 shmem_get_epp(struct amd_cpudata *cpudata, u64 dummy)
 	return (s16)(epp & 0xff);
 }
 
-static int amd_pstate_get_energy_pref_index(struct amd_cpudata *cpudata)
-{
-	s16 epp;
-	int index = -EINVAL;
-
-	epp = amd_pstate_get_epp(cpudata, 0);
-	if (epp < 0)
-		return epp;
-
-	switch (epp) {
-	case AMD_CPPC_EPP_PERFORMANCE:
-		index = EPP_INDEX_PERFORMANCE;
-		break;
-	case AMD_CPPC_EPP_BALANCE_PERFORMANCE:
-		index = EPP_INDEX_BALANCE_PERFORMANCE;
-		break;
-	case AMD_CPPC_EPP_BALANCE_POWERSAVE:
-		index = EPP_INDEX_BALANCE_POWERSAVE;
-		break;
-	case AMD_CPPC_EPP_POWERSAVE:
-		index = EPP_INDEX_POWERSAVE;
-		break;
-	default:
-		break;
-	}
-
-	return index;
-}
-
 static int msr_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
 			       u32 des_perf, u32 max_perf, bool fast_switch)
 {
@@ -275,19 +245,23 @@ static inline int amd_pstate_update_perf(struct amd_cpudata *cpudata,
 
 static int msr_set_epp(struct amd_cpudata *cpudata, u32 epp)
 {
-	u64 value = READ_ONCE(cpudata->cppc_req_cached);
+	u64 value, prev;
 	int ret;
 
+	value = prev = READ_ONCE(cpudata->cppc_req_cached);
 	value &= ~AMD_PSTATE_EPP_PERF_MASK;
 	value |= FIELD_PREP(AMD_PSTATE_EPP_PERF_MASK, epp);
 
+	if (value == prev)
+		return 0;
+
 	ret = wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
 	if (ret) {
 		pr_err("failed to set energy perf value (%d)\n", ret);
 		return ret;
 	}
 
-	cpudata->epp_cached = epp;
+	WRITE_ONCE(cpudata->epp_cached, epp);
 	WRITE_ONCE(cpudata->cppc_req_cached, value);
 
 	return ret;
@@ -305,13 +279,16 @@ static int shmem_set_epp(struct amd_cpudata *cpudata, u32 epp)
 	int ret;
 	struct cppc_perf_ctrls perf_ctrls;
 
+	if (epp == cpudata->epp_cached)
+		return 0;
+
 	perf_ctrls.energy_perf = epp;
 	ret = cppc_set_epp_perf(cpudata->cpu, &perf_ctrls, 1);
 	if (ret) {
 		pr_debug("failed to set energy perf value (%d)\n", ret);
 		return ret;
 	}
-	cpudata->epp_cached = epp;
+	WRITE_ONCE(cpudata->epp_cached, epp);
 
 	return ret;
 }
@@ -1216,9 +1193,22 @@ static ssize_t show_energy_performance_preference(
 	struct amd_cpudata *cpudata = policy->driver_data;
 	int preference;
 
-	preference = amd_pstate_get_energy_pref_index(cpudata);
-	if (preference < 0)
-		return preference;
+	switch (cpudata->epp_cached) {
+	case AMD_CPPC_EPP_PERFORMANCE:
+		preference = EPP_INDEX_PERFORMANCE;
+		break;
+	case AMD_CPPC_EPP_BALANCE_PERFORMANCE:
+		preference = EPP_INDEX_BALANCE_PERFORMANCE;
+		break;
+	case AMD_CPPC_EPP_BALANCE_POWERSAVE:
+		preference = EPP_INDEX_BALANCE_POWERSAVE;
+		break;
+	case AMD_CPPC_EPP_POWERSAVE:
+		preference = EPP_INDEX_POWERSAVE;
+		break;
+	default:
+		return -EINVAL;
+	}
 
 	return sysfs_emit(buf, "%s\n", energy_perf_strings[preference]);
 }
@@ -1503,7 +1493,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 
 	policy->driver_data = cpudata;
 
-	cpudata->epp_cached = cpudata->epp_default = amd_pstate_get_epp(cpudata, 0);
+	cpudata->epp_cached = cpudata->epp_default = amd_pstate_get_epp(cpudata);
 
 	policy->min = policy->cpuinfo.min_freq;
 	policy->max = policy->cpuinfo.max_freq;
@@ -1557,35 +1547,26 @@ static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
 	u64 value;
-	s16 epp;
 
 	amd_pstate_update_min_max_limit(policy);
 
 	value = READ_ONCE(cpudata->cppc_req_cached);
 
 	value &= ~(AMD_PSTATE_MAX_PERF_MASK | AMD_PSTATE_MIN_PERF_MASK |
-		   AMD_PSTATE_DES_PERF_MASK);
+		   AMD_PSTATE_DES_PERF_MASK | AMD_PSTATE_EPP_PERF_MASK);
 	value |= FIELD_PREP(AMD_PSTATE_MAX_PERF_MASK, cpudata->max_limit_perf);
 	value |= FIELD_PREP(AMD_PSTATE_DES_PERF_MASK, 0);
 	value |= FIELD_PREP(AMD_PSTATE_MIN_PERF_MASK, cpudata->min_limit_perf);
 
-	/* Get BIOS pre-defined epp value */
-	epp = amd_pstate_get_epp(cpudata, value);
-	if (epp < 0) {
-		/**
-		 * This return value can only be negative for shared_memory
-		 * systems where EPP register read/write not supported.
-		 */
-		return epp;
-	}
-
 	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
-		epp = 0;
+		WRITE_ONCE(cpudata->epp_cached, 0);
+	value |= FIELD_PREP(AMD_PSTATE_EPP_PERF_MASK, cpudata->epp_cached);
 
 	WRITE_ONCE(cpudata->cppc_req_cached, value);
 
 	if (trace_amd_pstate_epp_perf_enabled()) {
-		trace_amd_pstate_epp_perf(cpudata->cpu, cpudata->highest_perf, epp,
+		trace_amd_pstate_epp_perf(cpudata->cpu, cpudata->highest_perf,
+					  cpudata->epp_cached,
 					  cpudata->min_limit_perf,
 					  cpudata->max_limit_perf,
 					  cpudata->boost_state);
@@ -1594,7 +1575,7 @@ static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
 	amd_pstate_update_perf(cpudata, cpudata->min_limit_perf, 0U,
 			       cpudata->max_limit_perf, false);
 
-	return amd_pstate_set_epp(cpudata, epp);
+	return amd_pstate_set_epp(cpudata, READ_ONCE(cpudata->epp_cached));
 }
 
 static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
@@ -1610,6 +1591,8 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
 
 	cpudata->policy = policy->policy;
 
+	guard(mutex)(&amd_pstate_limits_lock);
+
 	ret = amd_pstate_epp_update_limit(policy);
 	if (ret)
 		return ret;
-- 
2.43.0


