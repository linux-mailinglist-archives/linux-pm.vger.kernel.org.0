Return-Path: <linux-pm+bounces-26315-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E597A9E900
	for <lists+linux-pm@lfdr.de>; Mon, 28 Apr 2025 09:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BA183B7E87
	for <lists+linux-pm@lfdr.de>; Mon, 28 Apr 2025 07:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F7F1C1F2F;
	Mon, 28 Apr 2025 07:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RBIJKVA1"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9518D28399;
	Mon, 28 Apr 2025 07:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745824622; cv=fail; b=t6zRWDcFH4r16RKFpra43XVTSpfVAZIfyVnSYNg7LmJFeEyGxIkYg5fbAysa+37UAcTQFfQFSI4eau+5s7Td7GVdHQgd3amr/d3+TbY9Pdv9WNC57GLG+ICdevnyXSp8d4R91lQtA1RV1XbQsjCj6DAF/v/GuTqWoc3j1IZOEac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745824622; c=relaxed/simple;
	bh=7WpIrHFafqsfRUb0kcb0ZlAWh0CxDClWOPnOWjBfzwY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iFEfOipFnSbMuTY+i2IzDI/I1ir6aQqe+rpAM6YrxUWXVfO3lOw6jbnU822XggTe3Q9ml6WcY6J6xCAAMSbFlKU3ltd6pZ/f57C7oPnyupwElTuR5o5+WE6XZXnEavTX28GdidTImdl0OJuioFe1ebVh+llUNejQ+7ad35T5pX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RBIJKVA1; arc=fail smtp.client-ip=40.107.237.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vl3m/itFH8xW61m6350ejkfmEOcjRynbuzdTImjCdQIBfeL7CJ7cYDlsitJQeF+9wEqYQpvCo2b/LoL1q7hKMlD0enM2DT6VRYduafYgX7NdExFqF/8Q738wOAK4twLt9mg+3HcfE+fygjw+BUG1K2dtvVruti+kPzmIHjc+lyfuK5CW3s2TjZeFDemTnzRW2OTngla6DoNCsqbtx9l9Qnbu4VM2acIAUf3VoJHi7U4XNOmEcnwstSHykF8hdAtqXFT5fTEsbyeNoOZsvAUZ0gsRTRI+uN7RcH5HR5IjCiBi0pi9XAZa6ym0elAxLaRIdIAqKJFp9aH25KpaNAJ6aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nlsp0ApX13DQs0ezvAsLv5JhK2f5SxLPL8xyBbBF+Gs=;
 b=bgMz9IWOvjrLK3/T9kFroFAnzC0WVAkHUeheTOGfiNc6sNinN5MXkNvpyiIO95TqUpeCXxztW8mN6Giac1NPuo2aZ6pVylmYO++bO/L5KLXKnd0SYjgRG0Z3WKTzEZHbrD82F3TUOzhtJwDZ/1EHjgcl3bghwW0PTTtxYlJgcqbyukTLs5sE6+ZkzIcCNSSv9XCyfx46fj2arEYiPI6Bhtng0HlfNawPRuekWJugLYa82jUGBTwUFtbKHMXKYLWRkogohUvzK3qUKeR78GxAOykuOQj70z79IAoUFOFN9om4yeuU+rx6M+f/mlXcLQWg4Dm2iGIynZiqQaaarlMFWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nlsp0ApX13DQs0ezvAsLv5JhK2f5SxLPL8xyBbBF+Gs=;
 b=RBIJKVA1UFjFFv+I23SI3kKH1jzLKZhfkv2gm2kF6MBhhcfoyv7XugfyTcEqsQzIiN4QuJZLrcD4UbR/bUvBc5sn9yKycO0jIHfkAMpGvAH/lgXpIwYfO58WpAx/SkUm/bGvWtogQeCU2FAEDkqjhHP23Ui5tegUW6xseMzfJ6U=
Received: from BY5PR16CA0028.namprd16.prod.outlook.com (2603:10b6:a03:1a0::41)
 by BL3PR12MB6449.namprd12.prod.outlook.com (2603:10b6:208:3b8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Mon, 28 Apr
 2025 07:16:56 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::79) by BY5PR16CA0028.outlook.office365.com
 (2603:10b6:a03:1a0::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.34 via Frontend Transport; Mon,
 28 Apr 2025 07:16:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 07:16:55 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 02:16:50 -0500
From: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
To: <gautham.shenoy@amd.com>, <mario.limonciello@amd.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Dhananjay
 Ugwekar" <dhananjay.ugwekar@amd.com>
Subject: [PATCH v3 2/2] cpufreq/amd-pstate: Add support for the "Requested CPU Min frequency" BIOS option
Date: Mon, 28 Apr 2025 07:16:24 +0000
Message-ID: <20250428071623.4309-1-dhananjay.ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250428062520.4997-1-dhananjay.ugwekar@amd.com>
References: <20250428062520.4997-1-dhananjay.ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|BL3PR12MB6449:EE_
X-MS-Office365-Filtering-Correlation-Id: a08ff8d3-209a-4b84-fd32-08dd8624a802
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KeEttpUdgRD7VbEdF83xjoQvgiP5dncoZih5DV2t2G7X7YeZaPSrrahFw7uR?=
 =?us-ascii?Q?XqUNjwVhNRqbDH8ny9FgCfBiT9OkxEWWPOwWQfkE3FY9V4wRdc0T5rwCVEE0?=
 =?us-ascii?Q?/cR4jvlwUYV/vQnyQ9yx78o3/nmVAS7CPAMWrOi6Yd2obmPkM1FBbnxoCWj7?=
 =?us-ascii?Q?tkiY0B8W7QPPdfSFyBkzXuJ9TxAKbIPUwjzyF5/PyWzhsGiNvMhuv4hob/q8?=
 =?us-ascii?Q?L39vBSNhSBF7wXp05QgbSZlkFJzJ+NJ7g2yFUU/GUB9l1rfx/uBiWM4s3r1B?=
 =?us-ascii?Q?wLCcNcH5mNpgdHo6bP2GKUeL7Rq+gME3RUm15I83A7NFpfSeIUvL4fnNmOxN?=
 =?us-ascii?Q?QTZ39lb13VqquAkw+qM57Mu8lDAx7A92GARUQ5Z0zdkByRRGMeg/zif9h54j?=
 =?us-ascii?Q?cHy11xA7kTIyjfBg0Dx/bgHyxH8IaG1scaLLl70F4pYOES2halpuu3/dXIy+?=
 =?us-ascii?Q?iCuJ235Ox52CbAnsoDlr/vifyFoJFLaCuytpJ9dDOVolP7BIk+WyFxK1NEoS?=
 =?us-ascii?Q?o72TuYSX4R9TqeuqP9DNORi5M9cBbdfxU5WrqZw0yrqBh83C7XBcZIKZfH9F?=
 =?us-ascii?Q?zq3iLPCQD8hCGGElTrOV5+Lv/9XeaOfeoTDJ/LNw/Cuvdxe/jBvLenVDJhxM?=
 =?us-ascii?Q?OeU+RycevtUTzzockN1hCnqyx763Meq2WFw237lL0BvqbnbL9Iypwxaty0sf?=
 =?us-ascii?Q?SdhgxFg3PTeqPKvgJHM5R3c2C+jnT0BHjH32tHBChJKsjytA//nVzLiDn6YR?=
 =?us-ascii?Q?9OO+enZt5ifriPBeQUCin3vbe6HZu28lNWaKo+MsJhpL5OgEVuGjqA2ClZJ4?=
 =?us-ascii?Q?VvK+BQychYSskDiz4TdPx4uFrjuB0aGzkOar9K3Tl+WyOzZ3x1GKMiERO2dT?=
 =?us-ascii?Q?ae8Pb2AJ3cqPgfl8nVcJu8bVYEMDSmjy9eXZy5CBEKW+HBJRUC+Ox6f7RdGi?=
 =?us-ascii?Q?94eTzyoVi3Z3L0vZu5JgTIHhkbJmr0EhSFVOX8ObvDd45LHLwsTZDuopttd3?=
 =?us-ascii?Q?OgHYLfO2ekXp0+kUNFOKc6jV8TRPRwQbuCDyLqSikszrhKY/UJHB0DkqxPdg?=
 =?us-ascii?Q?v4fhB/aZ5EHOPZUR5zZvzugY+gIfNUyNKIsb1p2nqhPEUWRoXDTGhju/AAOB?=
 =?us-ascii?Q?9dp/kKSKMIREqQbUcjUMCKfwmR1kvR+7U78USKqH8v7vvOCQcGlkHSLY68G6?=
 =?us-ascii?Q?EAJXXnXpmkllnXhxdsxqP5FDILw62SXH/F1z8dM3pJ+/wYqgV4jUj/EEMGcX?=
 =?us-ascii?Q?nXkEaxLpjFyNdWfxyAeXMCWRjw5aZOfigPQWKRh2/bV8QgfQtq5A7A7Uey3r?=
 =?us-ascii?Q?/kJmX/c/wgyPsnYojChcdvw5YahAkD+EttH9pohr1uZX14bw6blT0n+pP4Cc?=
 =?us-ascii?Q?f8vxQu9WS8lGSadcnEWZtSmq4yxJP3F6+YjLQV9yF7SmMD29GChrS1ozoV3U?=
 =?us-ascii?Q?7+xrvhg6Dxd/7CUBKFGC/TA6QtHqH5CVe3e5jh4tx8879ntevvk+nlHsychc?=
 =?us-ascii?Q?yUo56h0mLaf+69qudgTpMkvOCDInY0UYsb9A?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 07:16:55.0601
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a08ff8d3-209a-4b84-fd32-08dd8624a802
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6449

Initialize lower frequency limit to the "Requested CPU Min frequency"
BIOS option (if it is set) value as part of the driver->init()
callback. The BIOS specified value is passed by the PMFW as min_perf in
CPPC_REQ MSR. To ensure that we don't mistake a stale min_perf value in
CPPC_REQ value as the "Requested CPU Min frequency" during a kexec wakeup,
reset the CPPC_REQ.min_perf value back to the BIOS specified one in the
offline, exit and suspend callbacks.

amd_pstate_target() and amd_pstate_epp_update_limit() which are invoked
as part of the resume() and online() callbacks will take care of restoring
the CPPC_REQ back to the correct values.

Signed-off-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
---
Changes since v2:
* Add resume callback to reset the CPPC_REQ to last sane value for
  amd-pstate driver
* Check update_perf's return value in amd_pstate_suspend
---
 drivers/cpufreq/amd-pstate.c | 82 ++++++++++++++++++++++++++++++------
 drivers/cpufreq/amd-pstate.h |  2 +
 2 files changed, 71 insertions(+), 13 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 02de51001eba..4da03c7c7fe3 100644
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
+	if (!cppc_req)
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
@@ -1040,6 +1063,10 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 static void amd_pstate_cpu_exit(struct cpufreq_policy *policy)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
+	union perf_cached perf = READ_ONCE(cpudata->perf);
+
+	/* Reset CPPC_REQ MSR to the BIOS value */
+	amd_pstate_update_perf(policy, perf.bios_min_perf, 0U, 0U, 0U, false);
 
 	freq_qos_remove_request(&cpudata->req[1]);
 	freq_qos_remove_request(&cpudata->req[0]);
@@ -1428,7 +1455,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 	struct amd_cpudata *cpudata;
 	union perf_cached perf;
 	struct device *dev;
-	u64 value;
 	int ret;
 
 	/*
@@ -1493,12 +1519,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
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
@@ -1518,6 +1538,11 @@ static void amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)
 	struct amd_cpudata *cpudata = policy->driver_data;
 
 	if (cpudata) {
+		union perf_cached perf = READ_ONCE(cpudata->perf);
+
+		/* Reset CPPC_REQ MSR to the BIOS value */
+		amd_pstate_update_perf(policy, perf.bios_min_perf, 0U, 0U, 0U, false);
+
 		kfree(cpudata);
 		policy->driver_data = NULL;
 	}
@@ -1575,12 +1600,31 @@ static int amd_pstate_cpu_online(struct cpufreq_policy *policy)
 
 static int amd_pstate_cpu_offline(struct cpufreq_policy *policy)
 {
-	return 0;
+	struct amd_cpudata *cpudata = policy->driver_data;
+	union perf_cached perf = READ_ONCE(cpudata->perf);
+
+	/*
+	 * Reset CPPC_REQ MSR to the BIOS value, this will allow us to retain the BIOS specified
+	 * min_perf value across kexec reboots. If this CPU is just onlined normally after this, the
+	 * limits, epp and desired perf will get reset to the cached values in cpudata struct
+	 */
+	return amd_pstate_update_perf(policy, perf.bios_min_perf, 0U, 0U, 0U, false);
 }
 
 static int amd_pstate_suspend(struct cpufreq_policy *policy)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
+	union perf_cached perf = READ_ONCE(cpudata->perf);
+	int ret;
+
+	/*
+	 * Reset CPPC_REQ MSR to the BIOS value, this will allow us to retain the BIOS specified
+	 * min_perf value across kexec reboots. If this CPU is just resumed back without kexec,
+	 * the limits, epp and desired perf will get reset to the cached values in cpudata struct
+	 */
+	ret = amd_pstate_update_perf(policy, perf.bios_min_perf, 0U, 0U, 0U, false);
+	if (ret)
+		return ret;
 
 	/* invalidate to ensure it's rewritten during resume */
 	cpudata->cppc_req_cached = 0;
@@ -1591,6 +1635,17 @@ static int amd_pstate_suspend(struct cpufreq_policy *policy)
 	return 0;
 }
 
+static int amd_pstate_resume(struct cpufreq_policy *policy)
+{
+	struct amd_cpudata *cpudata = policy->driver_data;
+	union perf_cached perf = READ_ONCE(cpudata->perf);
+	int cur_perf = freq_to_perf(perf, cpudata->nominal_freq, policy->cur);
+
+	/* Set CPPC_REQ to last sane value until the governor updates it */
+	return amd_pstate_update_perf(policy, perf.min_limit_perf, cur_perf, perf.max_limit_perf,
+				      0U, false);
+}
+
 static int amd_pstate_epp_resume(struct cpufreq_policy *policy)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
@@ -1619,6 +1674,7 @@ static struct cpufreq_driver amd_pstate_driver = {
 	.online		= amd_pstate_cpu_online,
 	.offline	= amd_pstate_cpu_offline,
 	.suspend	= amd_pstate_suspend,
+	.resume		= amd_pstate_resume,
 	.set_boost	= amd_pstate_set_boost,
 	.update_limits	= amd_pstate_update_limits,
 	.name		= "amd-pstate",
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


