Return-Path: <linux-pm+bounces-25794-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA1FA94DA8
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 10:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 543AF188E65F
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 08:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4741D54F7;
	Mon, 21 Apr 2025 08:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EDhJZxaJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5241C8603;
	Mon, 21 Apr 2025 08:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745222798; cv=fail; b=IUlobuJmgc9u7uOapu2KD/Q+K84KWVc7wijdb9ONlY6WkIEzZarns0aABFW0kWf9xYD9XNMteetivxIffzstdJgPrROxZqoWx9Cv4vJagGzOgHCrIYpV5XNURPQQdoNZyvNA6WanP8wFOX1QCKKPMdGnS3FAwrs/rerMM6n+z7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745222798; c=relaxed/simple;
	bh=oXRqXzli1e3zqQQsN8LGLSYH5zC02RbNgNZV0GtBidY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J+ETVk7tt38jvWFj+a/98h0E6iBYk2q8eWxYVOI6NrcpVyUfvB8bVcLTQ+RuND9RqfZA+SVzRvtoL5oTQj2Keg3Sa10lbdpeAB1Gr4//kSMedyhfycLX11NP1+hqT4AmSUg8OpcCeXsg3BhD4TITyr2Z48wY3qMBgEh8a2a/UkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EDhJZxaJ; arc=fail smtp.client-ip=40.107.92.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ClimDFXZKAZ88JsLCmFoDocErtPifHsdR6IuUV/+F3/1OqR3ZqBSUprQJD6o1c1yevuzjH9XKjZouscunT8INKwypugldUBWFUJzwR7GvnOhfaqXBDzy670WpXuRV9KPrMQGW+G3/BNmnqtmgBnDhsyKnv7KZHXXAajdhzRlLtcrlTFKfZAC5n+WTsXj2vdUYUm/xyxL9+3o/yEi//rdgwjZN1E8hsLBazROHEortt0tjE8awMhjIxZnpNAkOamPnSD7gtGZMt3F2F9OxYRZijW8gM8q9iqzE0jujNXSDiRETYK7jg5VfYyQ0wKvC4eZKh0/yMSia/od430+EwEOvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r1ohd/StRaShZ+XJESL5bdL9YkShURIQ6t6CbejeHhg=;
 b=tciTjoWXybSeDKhSecQlcmKL6j1Vxo0yJ3CXNaR6knFOGYaWoeQvxIDFbfNuIhLBxf+bJ+3z+uyoZNJAPf6E/F8ErdI906Tv3X5QigxvLNxHwqFKB1SVv2kK9zUU+wau7yuVEwKyDFPnXpgss5w6FUUuC3tRsMVLpx+T4n8PFEnKOCPlIkmPlOw7Lf1CKx/mpZOdtaJm5Fzml8Xa6AZmhvoEmQtSW2uKeL7Q72pYr/+YboqvXskBWaVWGPmzAY8FbcRNfC/Bpwkb9jRSjfYYlyUXQDcl1HF/9DDlNILNLZ9IMiCYUln6djhP1be0oXyXscse7SxBsU4xmdWNb8WmgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r1ohd/StRaShZ+XJESL5bdL9YkShURIQ6t6CbejeHhg=;
 b=EDhJZxaJ+8OfsOtkVTOl9W3kTCz9GzQCJjkgtxjmTedcVn9HfqaITh3xn9Ij6u5lFhi1fCXjVNJp6MStwGPdttXcEpe+e//nL9w1jG7379NmSzY/el2Xz40C8DS1J7mlGD7vTxls2l1T/WuVkdwFTizYA2y0jFvY/x3xSTHvDL8=
Received: from BLAPR03CA0009.namprd03.prod.outlook.com (2603:10b6:208:32b::14)
 by DS0PR12MB8528.namprd12.prod.outlook.com (2603:10b6:8:160::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Mon, 21 Apr
 2025 08:06:32 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:208:32b:cafe::9e) by BLAPR03CA0009.outlook.office365.com
 (2603:10b6:208:32b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.35 via Frontend Transport; Mon,
 21 Apr 2025 08:06:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Mon, 21 Apr 2025 08:06:31 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Apr
 2025 03:06:27 -0500
From: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
To: <gautham.shenoy@amd.com>, <mario.limonciello@amd.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Dhananjay
 Ugwekar" <dhananjay.ugwekar@amd.com>
Subject: [PATCH v2 2/2] cpufreq/amd-pstate: Add support for the "Requested CPU Min frequency" BIOS option
Date: Mon, 21 Apr 2025 08:04:47 +0000
Message-ID: <20250421080444.707538-3-dhananjay.ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250421080444.707538-1-dhananjay.ugwekar@amd.com>
References: <20250421080444.707538-1-dhananjay.ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|DS0PR12MB8528:EE_
X-MS-Office365-Filtering-Correlation-Id: ea07f414-2711-427f-f97c-08dd80ab6d68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7qfQh9x8RSPUwItNDrDQM1x4KFpRJT68YF6ON4twJ6gwoOY2/zSTdv16hVAJ?=
 =?us-ascii?Q?FhvqKN2mSS+3G8bI7HgDeK8hgNoEUKmKp5trY4p+nfW5rn7EsQUvKnEYGcHn?=
 =?us-ascii?Q?jcpBNU5lbJ/ZkV901PAWyM9sB0LiJnXXb2AosaomZVbPRbs2A9wA5mSBTWSd?=
 =?us-ascii?Q?8MjcEevNF+UOjyFMKK3SG77Wly0jSTmVwZWU/UJEt4lH55YBgSJbZidJtNgW?=
 =?us-ascii?Q?a9fchh2sjSgT7WH9fCbb7BeQl+S9W2lhcs8tAFxv97DFKH8frPso4aprvyjF?=
 =?us-ascii?Q?8rYh0L8793ToJo+2LxADjUswC9czaddQjVxIApksRzj0dL3Xj4srZzKUVjbF?=
 =?us-ascii?Q?WxhUOgfYwdnrWnwM2SrSvaVNeOxLH/6Niafz9Xp0HwWZ1lA2LBX5bxaO2qhS?=
 =?us-ascii?Q?/sPcFD2vi0k0e0QOQQaWRNQETjTH+e+f/zDMtbem9pn6TWg1+gxvYO5/ec+Q?=
 =?us-ascii?Q?p5Oj9N7d4uztBYU1KOhVkHE71khP+4dfyqyBXALDwqkA4oNpkOCjf3j4dzD5?=
 =?us-ascii?Q?wj8Gh9g48pQbAw1+dENHrw/P6OJ6jyFuBYtgjcoDunNwFJNNiPzTHFWvR+Mq?=
 =?us-ascii?Q?M/oAfNjSa2dtrxXQ49zcs0XmK30nY2Jnr1xoICn+HSiSG5BRmoQsOkEbyx+b?=
 =?us-ascii?Q?FATLt3p/f/MStigp61VbrQRUF2b11VIhNWZDKyLoMYeac2qtBVTiWOwI3I2N?=
 =?us-ascii?Q?Ivb/Tkc/S4VkOFS8fm+iacYIObOoh6kHhz7QzSEm9rCF5ZGxtqY6AijyyHqL?=
 =?us-ascii?Q?cQnQbS9xUmblnRIqW3h1wwIeJ3G1p95KP/xq/bgi09TlK2ixDK1B+qjmP7/u?=
 =?us-ascii?Q?0oSXx19Q/Z651KB/nsAg/xM09rv7ddT+jvv7Nm1PGXSxcOJQoTwg1a+NiZN6?=
 =?us-ascii?Q?xcq5uC0fcdAojdUKS/58/gwDvaockYLWss5qS+yiAdd6m/LEpCDB18pGezBb?=
 =?us-ascii?Q?ivih9sqjl3d7r33+zJpWuLGWnsEVrCdShIDK+SRv8j7Lr+wqxobJNH0mwk5e?=
 =?us-ascii?Q?AwRdB1wnhFZ0wU02kpvRULfm8rdM0c/WPEtsyJs/XteFnJUKTdOq56LlKUIS?=
 =?us-ascii?Q?f7+iI8vvXMzy0eBnaGy6UdhV5oluwjL6MxDy+RoAShDgCdch6w8lnR4US74w?=
 =?us-ascii?Q?VH088gS4QwNmt4J8mxgiJTEtccWDE5Irf+QhvekkbtEfYWqGn1syS5v43OkN?=
 =?us-ascii?Q?mTVoyVK3r6U1huiyuL0dyjcnPiSLFGhhnVXcfsmyl6WJGs3xJfQsy++oZ/X1?=
 =?us-ascii?Q?/DPOp65NzWAWIkwy4iDPJUMcTKIU7BDVTH2I6Nm/CyQSOucFoQ5Vpf+lifgj?=
 =?us-ascii?Q?N/0dQYRoCt73nlbKjA/HMpDhtsj63K7qedvVsvrkz9ajTUxtwTe3NddUfmT3?=
 =?us-ascii?Q?0XH/5Izjc7NL4ZxjZF4ExIQ0/KGMq/CnUW+D2pM0szfxdnpzEgZx0y0VKQkV?=
 =?us-ascii?Q?RSQynlYpkk7PWMFguZwCW0unkHLEBi1NX4QkW6MEaRDeoS3W1EMof+NJBG/q?=
 =?us-ascii?Q?jTwNcXSQT8YreCUaCXEl6bpzUHAND3x/VI05?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2025 08:06:31.9368
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea07f414-2711-427f-f97c-08dd80ab6d68
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8528

Initialize lower frequency limit to the "Requested CPU Min frequency"
BIOS option (if it is set) value as part of the driver->init()
callback. The BIOS specified value is passed by the PMFW as min_perf in
CPPC_REQ MSR. 

To ensure that we don't mistake a stale min_perf value in CPPC_REQ 
value as the "Requested CPU Min frequency" during a kexec wakeup, reset 
the CPPC_REQ.min_perf value back to the BIOS specified one in the offline,
exit and suspend callbacks. amd_pstate_target() and 
amd_pstate_epp_update_limit() which are invoked as part of the resume() 
and online() callbacks will take care of restoring the CPPC_REQ back to 
the latest sane values.

Signed-off-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
---
Changes in v2:
* Modify the condition in msr_init_perf to initialize perf.bios_min_perf 
  to 0 by default
* Use READ_ONCE to read cpudata->perf in exit, suspend and offline
  callbacks
---
 drivers/cpufreq/amd-pstate.c | 67 +++++++++++++++++++++++++++++-------
 drivers/cpufreq/amd-pstate.h |  2 ++
 2 files changed, 56 insertions(+), 13 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 02de51001eba..407fdd31fb0b 100644
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
@@ -1575,12 +1600,28 @@ static int amd_pstate_cpu_online(struct cpufreq_policy *policy)
 
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
+
+	/*
+	 * Reset CPPC_REQ MSR to the BIOS value, this will allow us to retain the BIOS specified
+	 * min_perf value across kexec reboots. If this CPU is just resumed back without kexec,
+	 * the limits, epp and desired perf will get reset to the cached values in cpudata struct
+	 */
+	amd_pstate_update_perf(policy, perf.bios_min_perf, 0U, 0U, 0U, false);
 
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


