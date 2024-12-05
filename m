Return-Path: <linux-pm+bounces-18655-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7574E9E6097
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 23:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9696F1884844
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 22:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A9F1EE01B;
	Thu,  5 Dec 2024 22:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BHmn+IwV"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2301DE2DB;
	Thu,  5 Dec 2024 22:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733437757; cv=fail; b=uAWxQSBvtRjWH16x5dwpYy7/AnsHH4F09Ztp1A5cJmS0d2FfleuQlz1SgnxmNPXHNXe17cJBIgzp9A2fU5YDfgOI9Xj9ix4tzn3xJR0zCNVTTRAkycyw8zqWiDUVkLmO/AtWk5eqbJxyVJ2BKwBHHvmzjN30WhdTviqLAsEjsQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733437757; c=relaxed/simple;
	bh=TL6cIG19MRCdQ4WcjFAzi93UaK5QdokR05QJIfAZHTA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BwNVsTu5R9AxvyaF8qn7BIWWVxhBwkmd0qiYhBZvIOfdg4iHuXXu0dhvDUy8CjjTGZHxQyaB4qVStYO9NOynrkw1a2mWgOh7SgatG7rmU7z/axExKui+R15AlfxBnWh6Ln+ZDY9VTjJ+ovQ+CuYvnnIHDYsE+U7oVNA5UEkZtIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BHmn+IwV; arc=fail smtp.client-ip=40.107.244.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=URKSMKqUnDGTwn8AXr6rX4HjkrMoNNTmB6BPmHF2M3c+yLyeCyP6rEyg76Y+WnycVHdpPNatUZSsMtxb7vIvuRa6MLERo1s2bOcjns+41zBDzeFxYZVPqCrEEs3eXaeuNZEfqFljmlZAfJ8wyzgdAKZm0KCUIYbR2yzvVpTA9pKvbAWunfgTO6j+sxieq4LRGpA9mJT3xtZhxxV0t8pgjzplX20zCl+9CWih2SscR5jDgLIsACkh0SwJpFN+3JzPfi9C07rdmrBAsRwc0hTyTD6GjQarbUfZFjtooNQEVkhIlss7DwcXCyQsgyJlwy2qcq/mF4dY+RRJkHqVcT+hZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I9d+jQrdcK5oi86lBVIqu2eyZzgs006fqk41YxSx0L8=;
 b=wwgEEIDuzUmrG73MR07rbk5+PTTyiTWaOgI4x0vt+p30UEjLTTt1BbNMxdk8Z9t4LGQsn7T9ucYnG9FbGd0YQdH8kkPMWE57NUjXFgF/q8LL1WmQpObRft+3mcPbXFDrXTKFtwFp7ZRcL0APXH7DwgGRvFwMhmJrNpm7rXVQMjgzsWX2gOlGATpWfCVkS/n435G61gBciKT3VwwksNlGGcHc/+WuFkvXPGPdtPA/EHggbybW0Kor70iUoV05a1vAX6GHmyGq3De65B616lbYH3i1msyetEIQM0HShTbrfWw0y6yhklri4pkhckvSzlXFDfiH3ioQWVSD/h1Atz818A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9d+jQrdcK5oi86lBVIqu2eyZzgs006fqk41YxSx0L8=;
 b=BHmn+IwVUC+jGppmSWHCjj2bV3LPCCc2QkTKFhUsHEBYdmg3ekvN4yuXgBe2eJLm2JlBCmqOCaYN3vOJHGxW5d6afFQEyRsrVfJIGveJ7Om9uhKIvDM4zCftXci+/2GJXwSkDCez2gRBoWm3UjUJGEBDsKN7F8dBZyxEhCJTRLU=
Received: from CH0PR03CA0217.namprd03.prod.outlook.com (2603:10b6:610:e7::12)
 by DS0PR12MB8455.namprd12.prod.outlook.com (2603:10b6:8:158::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Thu, 5 Dec
 2024 22:29:12 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:e7:cafe::8c) by CH0PR03CA0217.outlook.office365.com
 (2603:10b6:610:e7::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.10 via Frontend Transport; Thu,
 5 Dec 2024 22:29:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Thu, 5 Dec 2024 22:29:12 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Dec
 2024 16:29:06 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 13/15] cpufreq/amd-pstate: Check if CPPC request has changed before writing to the MSR or shared memory
Date: Thu, 5 Dec 2024 16:28:45 -0600
Message-ID: <20241205222847.7889-14-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|DS0PR12MB8455:EE_
X-MS-Office365-Filtering-Correlation-Id: 83e8b0d1-117f-4c1b-fc14-08dd157c3eb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U6k3tcpt7ATCvYVZNvCQEimFn5Xn5Ddo3gN9bqbPd10guFBBdeOeP4dP3ZtP?=
 =?us-ascii?Q?3a7vpGo3Xk5yGahZYZGPylOBQ1qgj4YOU4FOXAIre598V/Mv8onQGWREUH3d?=
 =?us-ascii?Q?o9dddjga2pqIGbk7lF8/oiy41RTv7XteoE37fDokl0EK/Op6Tb1IxVHZuqMJ?=
 =?us-ascii?Q?wMd0xVD1evNZhH7GGdZNhMw6LaX+8Qw0K5ovEqhmGHOU2B2AmMcFkWM+SaUt?=
 =?us-ascii?Q?zh9lLXVH7EkyBmWt8KX100LpZL1lU8f+NKVu441y3/xbdZQ/HFKwfADqPiAX?=
 =?us-ascii?Q?CiKsvC0F4+Zd6cmx9a3RvCkAOik5inXqfMVFq2aFLGD8EqFvNxDoCdzEddi2?=
 =?us-ascii?Q?Jp7USEnb/cfIcsTWN8MZdR53lg4gL6ggI1dR1r2TrcZt15/a5K+C7Q/w48Ln?=
 =?us-ascii?Q?9WcbFX1+Zn64kqQh0j+DZvDSa4YbacqVnHgiX2T+8UxQRRg7WCtwsYjBq97W?=
 =?us-ascii?Q?81zeViTa8KPq6ZYBswhw2vNpazHEe2KjZKqrDkBFL6CXMmV02hK2R5D6QRUE?=
 =?us-ascii?Q?TBpNzNGoVAgY//O9ALtMzprDYJm3lwlLm6kh2wBa1/QKpGv6hj9k9TDL2XiS?=
 =?us-ascii?Q?W67AOEbN9y3sXBInLD9ZUpAL8YJVRcwf1udB8NpVhaGqIu9O4r3d8AiYBTks?=
 =?us-ascii?Q?KNA14BEwsHjL5D8QOdARKFtNPvF57vft3MGbG7PElJ26CmkVpa6+qfpft6T7?=
 =?us-ascii?Q?qS6ce7iLhOiYY7XDRvrH+GQ+VxqGqa4KIExwwieQYqIRnxAw6iz7dwHZGCfU?=
 =?us-ascii?Q?d+SDYOvJgEqGmen3/RWlHhx4vUilW3M/Ewowh4dqvlPh/NXsF3+cHy1O+TpP?=
 =?us-ascii?Q?/+GKWhcxWZlAarHl8NswD9fXhLpwT08qRRth9PUpRvkyryT/S3jqse5ztszG?=
 =?us-ascii?Q?kuIFC5+ZNdnizQwGLZ+MnD0BvEIT3/gKLpV74tGRuG4ATz5J6859ov5OFBey?=
 =?us-ascii?Q?IxozXlH8vzqYwvjcQIYhCef59oHBmCeloQkA//ETdGAi1Hs+2s0GPPBzcIFG?=
 =?us-ascii?Q?jQs4GnCTO1+mt0in9t4NbXjE0vNmC2fc6+SoZfX5iGY/mYkqerL1khxXyx42?=
 =?us-ascii?Q?RlJEgU2EXGWe6RTOCgZ72GbKNuQgHoRigvow9wo8CH2sO4cWmxPWDJOTnhDG?=
 =?us-ascii?Q?RM/DEpAOM3b3ZtBohMJQ+K/zBESQyVssHwvRf/Xam48AIoi/uJwBUjhiKSeS?=
 =?us-ascii?Q?ihCE32KmwipU6yaSwDw27+B0YSVnIhZQCcVpHpW0NI4OnvVJWCKPiPlTPHCj?=
 =?us-ascii?Q?96e9mEixO3bF8cj4Fz7tdCDXUe4WchPQFdg5RuQGAFEaHP+twiPp67ykRKdd?=
 =?us-ascii?Q?MLQOxx7M5G6b+xBP5F79+FVWKog87Es3/cohO+gsf6aY5SamJrjl/k1L6k/G?=
 =?us-ascii?Q?oqbvB7vjpeQD7JJtdK2RHB50naVeQTv8CJ7KV6u67NW8n48lfgX4LHoVZWVD?=
 =?us-ascii?Q?AMbTRB4MwGX3nmDVO7buMrjH6QqyA5ZZ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 22:29:12.7808
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83e8b0d1-117f-4c1b-fc14-08dd157c3eb3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8455

Move the common MSR field formatting code to msr_update_perf() from
its callers.

Ensure that the MSR write is necessary before flushing a write out.
Also drop the comparison from the passive flow tracing.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate-trace.h |  7 +----
 drivers/cpufreq/amd-pstate.c       | 47 +++++++++++-------------------
 2 files changed, 18 insertions(+), 36 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate-trace.h b/drivers/cpufreq/amd-pstate-trace.h
index e2221a4b6901c..8d692415d9050 100644
--- a/drivers/cpufreq/amd-pstate-trace.h
+++ b/drivers/cpufreq/amd-pstate-trace.h
@@ -32,7 +32,6 @@ TRACE_EVENT(amd_pstate_perf,
 		 u64 aperf,
 		 u64 tsc,
 		 unsigned int cpu_id,
-		 bool changed,
 		 bool fast_switch
 		 ),
 
@@ -44,7 +43,6 @@ TRACE_EVENT(amd_pstate_perf,
 		aperf,
 		tsc,
 		cpu_id,
-		changed,
 		fast_switch
 		),
 
@@ -57,7 +55,6 @@ TRACE_EVENT(amd_pstate_perf,
 		__field(unsigned long long, aperf)
 		__field(unsigned long long, tsc)
 		__field(unsigned int, cpu_id)
-		__field(bool, changed)
 		__field(bool, fast_switch)
 		),
 
@@ -70,11 +67,10 @@ TRACE_EVENT(amd_pstate_perf,
 		__entry->aperf = aperf;
 		__entry->tsc = tsc;
 		__entry->cpu_id = cpu_id;
-		__entry->changed = changed;
 		__entry->fast_switch = fast_switch;
 		),
 
-	TP_printk("amd_min_perf=%lu amd_des_perf=%lu amd_max_perf=%lu freq=%llu mperf=%llu aperf=%llu tsc=%llu cpu_id=%u changed=%s fast_switch=%s",
+	TP_printk("amd_min_perf=%lu amd_des_perf=%lu amd_max_perf=%lu freq=%llu mperf=%llu aperf=%llu tsc=%llu cpu_id=%u fast_switch=%s",
 		  (unsigned long)__entry->min_perf,
 		  (unsigned long)__entry->target_perf,
 		  (unsigned long)__entry->capacity,
@@ -83,7 +79,6 @@ TRACE_EVENT(amd_pstate_perf,
 		  (unsigned long long)__entry->aperf,
 		  (unsigned long long)__entry->tsc,
 		  (unsigned int)__entry->cpu_id,
-		  (__entry->changed) ? "true" : "false",
 		  (__entry->fast_switch) ? "true" : "false"
 		 )
 );
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 8598f50e18b58..06464e2dd905f 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -224,15 +224,26 @@ static s16 shmem_get_epp(struct amd_cpudata *cpudata)
 static int msr_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
 			   u32 des_perf, u32 max_perf, u32 epp, bool fast_switch)
 {
-	u64 value;
+	u64 value, prev;
+
+	value = prev = READ_ONCE(cpudata->cppc_req_cached);
+
+	value &= ~(AMD_PSTATE_MAX_PERF_MASK | AMD_PSTATE_MIN_PERF_MASK |
+		   AMD_PSTATE_DES_PERF_MASK | AMD_PSTATE_EPP_PERF_MASK);
+	value |= FIELD_PREP(AMD_PSTATE_MAX_PERF_MASK, max_perf);
+	value |= FIELD_PREP(AMD_PSTATE_DES_PERF_MASK, des_perf);
+	value |= FIELD_PREP(AMD_PSTATE_MIN_PERF_MASK, min_perf);
+	value |= FIELD_PREP(AMD_PSTATE_EPP_PERF_MASK, epp);
+
+	if (value == prev)
+		return 0;
 
-	value = READ_ONCE(cpudata->cppc_req_cached);
 	if (fast_switch) {
-		wrmsrl(MSR_AMD_CPPC_REQ, READ_ONCE(cpudata->cppc_req_cached));
+		wrmsrl(MSR_AMD_CPPC_REQ, value);
 		return 0;
 	} else {
-		int ret = wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ,
-					READ_ONCE(cpudata->cppc_req_cached));
+		int ret = wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
+
 		if (ret)
 			return ret;
 	}
@@ -528,9 +539,7 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
 {
 	unsigned long max_freq;
 	struct cpufreq_policy *policy = cpufreq_cpu_get(cpudata->cpu);
-	u64 prev = READ_ONCE(cpudata->cppc_req_cached);
 	u32 nominal_perf = READ_ONCE(cpudata->nominal_perf);
-	u64 value = prev;
 
 	des_perf = clamp_t(unsigned long, des_perf, min_perf, max_perf);
 
@@ -546,27 +555,14 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
 	if (!cpudata->boost_supported)
 		max_perf = min_t(unsigned long, nominal_perf, max_perf);
 
-	value &= ~(AMD_PSTATE_MAX_PERF_MASK | AMD_PSTATE_MIN_PERF_MASK |
-		   AMD_PSTATE_DES_PERF_MASK);
-	value |= FIELD_PREP(AMD_PSTATE_MAX_PERF_MASK, max_perf);
-	value |= FIELD_PREP(AMD_PSTATE_DES_PERF_MASK, des_perf);
-	value |= FIELD_PREP(AMD_PSTATE_MIN_PERF_MASK, min_perf);
-
 	if (trace_amd_pstate_perf_enabled() && amd_pstate_sample(cpudata)) {
 		trace_amd_pstate_perf(min_perf, des_perf, max_perf, cpudata->freq,
 			cpudata->cur.mperf, cpudata->cur.aperf, cpudata->cur.tsc,
-				cpudata->cpu, (value != prev), fast_switch);
+				cpudata->cpu, fast_switch);
 	}
 
-	if (value == prev)
-		goto cpufreq_policy_put;
-
-	WRITE_ONCE(cpudata->cppc_req_cached, value);
-
 	amd_pstate_update_perf(cpudata, min_perf, des_perf, max_perf, 0, fast_switch);
 
-cpufreq_policy_put:
-
 	cpufreq_cpu_put(policy);
 }
 
@@ -1564,19 +1560,10 @@ static void amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)
 static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
-	u64 value;
 	u32 epp;
 
 	amd_pstate_update_min_max_limit(policy);
 
-	value = READ_ONCE(cpudata->cppc_req_cached);
-
-	value &= ~(AMD_PSTATE_MAX_PERF_MASK | AMD_PSTATE_MIN_PERF_MASK |
-		   AMD_PSTATE_DES_PERF_MASK | AMD_PSTATE_EPP_PERF_MASK);
-	value |= FIELD_PREP(AMD_PSTATE_MAX_PERF_MASK, cpudata->max_limit_perf);
-	value |= FIELD_PREP(AMD_PSTATE_DES_PERF_MASK, 0);
-	value |= FIELD_PREP(AMD_PSTATE_MIN_PERF_MASK, cpudata->min_limit_perf);
-
 	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
 		epp = 0;
 	else
-- 
2.43.0


