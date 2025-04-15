Return-Path: <linux-pm+bounces-25466-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08843A89A45
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 12:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45B283B9053
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 10:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585F32918EB;
	Tue, 15 Apr 2025 10:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tPwRU9Hd"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2041.outbound.protection.outlook.com [40.107.212.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5991027A13C;
	Tue, 15 Apr 2025 10:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744713005; cv=fail; b=ibXeAvivheMhMRCfQy75HHnTVXkZTWrky7D78Oid8lemgWkNEZFU3j9vn7Hr51y6VI6VGCxMw+crLQXkFJBv9MQTddowhV5l5utGimsKcSkAV5Lk6Fp+XRKYTEs364T+J/9jdDOnhgJftS2RL5KWmxJwCFRkxU58FXyVL1+4Vr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744713005; c=relaxed/simple;
	bh=R4eU63THEgrlF2VMGXTVzJ6+zYHIYWEAXvXmzahKio0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sRnLU08NckyP6mQgBbKYJlsW21jiAf1raqPNOnfEF9Ru2hgaeVcypuLuJHMan6pXbZalW9AAhXW9VCoIuG+1N3JNOIDuGxtsTUD37lP/lQqIDAma9U/ddSkq1i3Dn7qHGaoUHssmGvAOKCbWdEBn9Br21I6Gee6yE6/SgcDPfik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tPwRU9Hd; arc=fail smtp.client-ip=40.107.212.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ov0mnlfQ8545vPEhL8dJActih/9tWp/BWXvq10Eql86yDc5YGNCDeVsuf1DOJDsLVHma697tEFY+649xmvCO7yXbH3kYTbEkOmlhb1WxgGYocpyp6T5pUpLIoh4UAxwxk42Ws+Gur2RKOBPlrTveajmxVFs7HyjXNgP/loof/d1pUPHc604q5tP0UWe/Pw9eVbj9M+YEi3cq/pe2H6jk+wVN4Og4dyY1xBiwKa7wwuVfLGkWFRztob7w2gEXn/4OyAceH56VSljNt0p1Fm6LJRX/M+T6Q07llwSXMLETITJiBO34cc/SVovp9pA3jU4PJ1vI0j2stKc3FwCchk6tkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ErxX5SkbAsebA8T3Sl8QDv1CS1CirEMuUKvUSj+03kU=;
 b=riHYraIHKwXTDCQ/J+omQanVcwyZdudLosw7yiRC4j63tRb4GUBa07A5oxD0qfyFkSZlJ19OYJ33vpMHs2ROWnlfNFIIUNf5Y+bhv87oeS6EhRvC27hB1tZb+GcfKVXLGRKoQzVw54dbB/a9RGGQaYOfq2d/YFCoT1ZjzDVMgfpx+FrHi4gq7UFvcxVKS8o7o2CUrqb1XbBi7HnODijsbZ5+2tmnblBWEPuSIsGIOo7ce22H63QTitYFa7JuU4T7+lsdPJ2WOfhMBEMaj5W65Yw1fBF319c8XrDdCUQLPm1iRzafvZMGgvyQ5rvxaPQ9ObpmcksGlRwqM9SB3r+tJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ErxX5SkbAsebA8T3Sl8QDv1CS1CirEMuUKvUSj+03kU=;
 b=tPwRU9HdGaM97/Q1RpN+ILbsXtv8kU9yUVDbrdZgBRT7YVsc26paRUngFkZR65bLFfCV9WMXPcLHLvPjOUCLSf2IoLIwGGvU7fHBCn2v8CR/wyvNvG2kKPOb93ZqP1zoqjK6skr/IVyDsEJIugQeOjKAWdw/LLPp+TPZ+74Gp38=
Received: from DM6PR02CA0081.namprd02.prod.outlook.com (2603:10b6:5:1f4::22)
 by DS7PR12MB5960.namprd12.prod.outlook.com (2603:10b6:8:7f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Tue, 15 Apr
 2025 10:29:59 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:5:1f4:cafe::d) by DM6PR02CA0081.outlook.office365.com
 (2603:10b6:5:1f4::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.32 via Frontend Transport; Tue,
 15 Apr 2025 10:29:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 10:29:59 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Apr
 2025 05:29:56 -0500
From: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
To: <gautham.shenoy@amd.com>, <mario.limonciello@amd.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Dhananjay
 Ugwekar" <dhananjay.ugwekar@amd.com>
Subject: [PATCH 2/2] cpufreq/amd-pstate: Add support for the "Requested CPU Min frequency" BIOS option
Date: Tue, 15 Apr 2025 10:21:21 +0000
Message-ID: <20250415102118.694999-3-dhananjay.ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250415102118.694999-1-dhananjay.ugwekar@amd.com>
References: <20250415102118.694999-1-dhananjay.ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|DS7PR12MB5960:EE_
X-MS-Office365-Filtering-Correlation-Id: c76677d1-47ba-4df3-2cb2-08dd7c087937
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yZc9fRY91p3V11C1mHtd/9xX8icR2Agyctqww7uLeZ/f01Q/cwwLVvGyTCo6?=
 =?us-ascii?Q?qnLA/3ODZnVWZctKsf7tCn13dFhU+tT5oVWkRSiSMlCdg73Ha3BsDI0QVNCz?=
 =?us-ascii?Q?B3dbBuoxLLujd/P92Ga2k2A5T/j8YfYtRYrJ808dGaQ/nZphoqhDJzyiL/zw?=
 =?us-ascii?Q?aF2gvk2AYqTNz90EzN/aD9f8b1DBjkcu5M9uBa41ikVYOrjlXigtm5j5DKXY?=
 =?us-ascii?Q?ZD0/j7j/mFzbvuq+WMyXUWRpYJGMis/h1CQREc/BglXPjq2f+eyGg4JRbSNJ?=
 =?us-ascii?Q?69MpfyGlLm+eamCglvZj5uP8RPNhS2x8P+Z1tCHNNwEbvNTDvqzG3wLziHe9?=
 =?us-ascii?Q?Qr4xAiteRUpNH4PZC9dk6ryWa40jOLnjHDlkXHvJJ295V9dubs2XE9sfugxI?=
 =?us-ascii?Q?ZkT0ekcelJ7yzXfq7WGGut7T1h6tVAenL0JUBsxQZY2mf5IFXOZj/L9Cw1tD?=
 =?us-ascii?Q?txthocifHj39RufA/XHiClgUytK+ZtM5dDoSQvJxP4uMydq7Evl1tz7zs57e?=
 =?us-ascii?Q?55N2WXdY3x8TuipcdZZZNp3cAR6KUSpY4Y8wzOEqaWvUJAvCYHrlCE6RpSV9?=
 =?us-ascii?Q?cRJQqVnTsA7CjbZb/77zyLIiQJO92oFv8wEuwHCShg7aT/3J7FJfqjLu9DgU?=
 =?us-ascii?Q?yHG4kO4ii1wTP5mM0xf5CcIBCdZu1Xc2Knkk/Fy07EVuYwolAIBj50adjRKV?=
 =?us-ascii?Q?TuvJ7tlNsWVsmJO/wRb0jJH/qWJU6tbl9WWiBIU6d+nGYFpODjesmCkW4STY?=
 =?us-ascii?Q?ogG269b0kowejCoMJ3sI5YXpxc1WNBcP4ZgLW9GXXwuxQy15Yrcn1HqzAWPV?=
 =?us-ascii?Q?CfpIWzWbnJh5z3E87vvaJ+x7vb4NY6+zId9pDVwCG3RIfzYv/jNhx7n1adB/?=
 =?us-ascii?Q?YLIzXy2YoawT4zykgo7brCGWOg/n9STnjX6pHkqsZPnvFhxpc8bavomZvEpi?=
 =?us-ascii?Q?ng6C3be0Kv5nBNOvhzwgz2q/LBwn7mZBNb2NU8dKvBxyxTuXAjxRGcOUM81Y?=
 =?us-ascii?Q?PeU3CgVGBFqLXiqCVN5Js4kyOg8LMQNDhLp4QbhN4um5sn+7u9fQqwJjbmuu?=
 =?us-ascii?Q?GgOcc7pImonTYALL37t4fE95afxlh+T/Koe1OK5edPHdIN84iHKqgchJdo1/?=
 =?us-ascii?Q?im0lFNH0vIXMUcNlVqQjOnXmADXnH0yDIXiNo4o6y7RPGaWbaG+DfT2D3SWZ?=
 =?us-ascii?Q?992CuyTpFb75AyC4EiYBUW2HEScntDSVul9mGd0rMLd7Q6as2OyQMp71lHoC?=
 =?us-ascii?Q?dvIBlGe7ATo4g/z1XA6+69PT1FGwVar6/k01wzujfesQtXErOLpSLDQisESa?=
 =?us-ascii?Q?IyWI+J86XgRRCd6jnOyXfgJ3JDrInZ/rhZQAXzUxERC2WMt6R0jbFf6CYqTX?=
 =?us-ascii?Q?ukwMV3tn91jTlH97YRDgPjp/klBGDNCcUrZlxI/GnE1e1QoW387Y1r9GjCAo?=
 =?us-ascii?Q?qwKTGaOzpRjegsK8PQq+AqPN9Y8OYN2EQAfrvgCidSGHntb2iZXqfx1eWP6h?=
 =?us-ascii?Q?2ClrtSPUzkt+jgYde/H3jdBawOrfXWN6YtMD?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 10:29:59.0782
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c76677d1-47ba-4df3-2cb2-08dd7c087937
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5960

Initialize lower frequency limit to the "Requested CPU Min frequency"
BIOS option (if it is set) value as part of the driver->init()
callback. The BIOS specified value is passed by the PMFW as min_perf in 
CPPC_REQ MSR. To ensure that we don't mistake a stale min_perf value in 
CPPC_REQ value as the "Requested CPU Min frequency" during a kexec wakeup, 
reset the CPPC_REQ.min_perf value back to the BIOS specified one in the 
offline, exit and suspend callbacks.

amd_pstate_target() and amd_pstate_epp_update_limit() which are invoked
as part of the resume() and online() callbacks will take care of restoring
the CPPC_REQ back to the latest sane values.

Signed-off-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 62 ++++++++++++++++++++++++++++--------
 drivers/cpufreq/amd-pstate.h |  2 ++
 2 files changed, 51 insertions(+), 13 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 02de51001eba..d94fd2a38990 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -389,7 +389,8 @@ static inline int amd_pstate_cppc_enable(struct cpufreq_policy *policy)
 static int msr_init_perf(struct amd_cpudata *cpudata)
 {
 	union perf_cached perf = READ_ONCE(cpudata->perf);
-	u64 cap1, numerator;
+	u64 cap1, numerator, cppc_req;
+	u8 min_perf;
 
 	int ret = rdmsrl_safe_on_cpu(cpudata->cpu, MSR_AMD_CPPC_CAP1,
 				     &cap1);
@@ -400,6 +401,22 @@ static int msr_init_perf(struct amd_cpudata *cpudata)
 	if (ret)
 		return ret;
 
+	ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, &cppc_req);
+	if (ret)
+		return ret;
+
+	WRITE_ONCE(cpudata->cppc_req_cached, cppc_req);
+	min_perf = FIELD_GET(AMD_CPPC_MIN_PERF_MASK, cppc_req);
+
+	/*
+	 * Clear out the min_perf part to check if the rest of the MSR is 0, if yes, this is an
+	 * indication that the min_perf value is the one specified through the BIOS option
+	 */
+	cppc_req &= ~(AMD_CPPC_MIN_PERF_MASK);
+
+	if (!cppc_req && min_perf)
+		perf.bios_min_perf = min_perf;
+
 	perf.highest_perf = numerator;
 	perf.max_limit_perf = numerator;
 	perf.min_limit_perf = FIELD_GET(AMD_CPPC_LOWEST_PERF_MASK, cap1);
@@ -580,20 +597,26 @@ static int amd_pstate_verify(struct cpufreq_policy_data *policy_data)
 {
 	/*
 	 * Initialize lower frequency limit (i.e.policy->min) with
-	 * lowest_nonlinear_frequency which is the most energy efficient
-	 * frequency. Override the initial value set by cpufreq core and
-	 * amd-pstate qos_requests.
+	 * lowest_nonlinear_frequency or the min frequency (if) specified in BIOS,
+	 * Override the initial value set by cpufreq core and amd-pstate qos_requests.
 	 */
 	if (policy_data->min == FREQ_QOS_MIN_DEFAULT_VALUE) {
 		struct cpufreq_policy *policy __free(put_cpufreq_policy) =
 					      cpufreq_cpu_get(policy_data->cpu);
 		struct amd_cpudata *cpudata;
+		union perf_cached perf;
 
 		if (!policy)
 			return -EINVAL;
 
 		cpudata = policy->driver_data;
-		policy_data->min = cpudata->lowest_nonlinear_freq;
+		perf = READ_ONCE(cpudata->perf);
+
+		if (perf.bios_min_perf)
+			policy_data->min = perf_to_freq(perf, cpudata->nominal_freq,
+							perf.bios_min_perf);
+		else
+			policy_data->min = cpudata->lowest_nonlinear_freq;
 	}
 
 	cpufreq_verify_within_cpu_limits(policy_data);
@@ -1041,6 +1064,9 @@ static void amd_pstate_cpu_exit(struct cpufreq_policy *policy)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
 
+	/* Reset CPPC_REQ MSR to the BIOS value */
+	amd_pstate_update_perf(policy, cpudata->perf.bios_min_perf, 0U, 0U, 0U, false);
+
 	freq_qos_remove_request(&cpudata->req[1]);
 	freq_qos_remove_request(&cpudata->req[0]);
 	policy->fast_switch_possible = false;
@@ -1428,7 +1454,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 	struct amd_cpudata *cpudata;
 	union perf_cached perf;
 	struct device *dev;
-	u64 value;
 	int ret;
 
 	/*
@@ -1493,12 +1518,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 		cpudata->epp_default = AMD_CPPC_EPP_BALANCE_PERFORMANCE;
 	}
 
-	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
-		ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, &value);
-		if (ret)
-			return ret;
-		WRITE_ONCE(cpudata->cppc_req_cached, value);
-	}
 	ret = amd_pstate_set_epp(policy, cpudata->epp_default);
 	if (ret)
 		return ret;
@@ -1518,6 +1537,9 @@ static void amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)
 	struct amd_cpudata *cpudata = policy->driver_data;
 
 	if (cpudata) {
+		/* Reset CPPC_REQ MSR to the BIOS value */
+		amd_pstate_update_perf(policy, cpudata->perf.bios_min_perf, 0U, 0U, 0U, false);
+
 		kfree(cpudata);
 		policy->driver_data = NULL;
 	}
@@ -1575,13 +1597,27 @@ static int amd_pstate_cpu_online(struct cpufreq_policy *policy)
 
 static int amd_pstate_cpu_offline(struct cpufreq_policy *policy)
 {
-	return 0;
+	struct amd_cpudata *cpudata = policy->driver_data;
+
+	/*
+	 * Reset CPPC_REQ MSR to the BIOS value, this will allow us to retain the BIOS specified
+	 * min_perf value across kexec reboots. If this CPU is just onlined normally after this, the
+	 * limits, epp and desired perf will get reset to the cached values in cpudata struct
+	 */
+	return amd_pstate_update_perf(policy, cpudata->perf.bios_min_perf, 0U, 0U, 0U, false);
 }
 
 static int amd_pstate_suspend(struct cpufreq_policy *policy)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
 
+	/*
+	 * Reset CPPC_REQ MSR to the BIOS value, this will allow us to retain the BIOS specified
+	 * min_perf value across kexec reboots. If this CPU is just resumed back without kexec,
+	 * the limits, epp and desired perf will get reset to the cached values in cpudata struct
+	 */
+	amd_pstate_update_perf(policy, cpudata->perf.bios_min_perf, 0U, 0U, 0U, false);
+
 	/* invalidate to ensure it's rewritten during resume */
 	cpudata->cppc_req_cached = 0;
 
diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
index fbe1c08d3f06..2f7ae364d331 100644
--- a/drivers/cpufreq/amd-pstate.h
+++ b/drivers/cpufreq/amd-pstate.h
@@ -30,6 +30,7 @@
  * @lowest_perf: the absolute lowest performance level of the processor
  * @min_limit_perf: Cached value of the performance corresponding to policy->min
  * @max_limit_perf: Cached value of the performance corresponding to policy->max
+ * @bios_min_perf: Cached perf value corresponding to the "Requested CPU Min Frequency" BIOS option
  */
 union perf_cached {
 	struct {
@@ -39,6 +40,7 @@ union perf_cached {
 		u8	lowest_perf;
 		u8	min_limit_perf;
 		u8	max_limit_perf;
+		u8	bios_min_perf;
 	};
 	u64	val;
 };
-- 
2.34.1


