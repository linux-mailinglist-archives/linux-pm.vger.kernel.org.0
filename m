Return-Path: <linux-pm+bounces-15778-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF74E9A0D41
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 16:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71A50283ED9
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 14:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB2620C486;
	Wed, 16 Oct 2024 14:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ICZD6+iS"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E194414A4E2;
	Wed, 16 Oct 2024 14:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729090274; cv=fail; b=h3gG8Low7Bef3pDyQVj5en00l1aiMuEmOlIAWEjjlG2VUdRqcDzdjwMqH+H6wjZaxamyC+JJX1VlUuKMPs06d8Mnd8PiSzExZ3Uj2xx3L3lyZyaKljho1w5W1hP4aZEkMVc3Ja1lF3/wZg1rGORd1Evw2LuurFsOAWzT50BqTtw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729090274; c=relaxed/simple;
	bh=aA0qsjFbr/PO0uNxDGW4wyx5S3KdPI9ELpA4Zq8L6E8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W2k5mc8kGOXrhOI086I3/AxoSeRMv0K5QOyi0ADF/bOKwiLDvaBEIvpyL3cKmksk1uldjwrlGqLnnYisNSdapAuPvWzIIfOyslV3nku1qpXXRb0KqLxZHRyhYJNtcZ+hYdPd3umjsw+pK4sMPCY5dBstpVQGbx6F1nwAAwic60w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ICZD6+iS; arc=fail smtp.client-ip=40.107.92.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sPbJiBdcB10z0xWnGisXApsVAyGHCzePxFaBRMyQ2zVZc9Z5sUJCGFqXLEM/84pPq8r4L7W/olv1As1Jo7kPxOzSvLosy0rvLtczDHWBDFCZVJ8yA4SAyyZ02wTpg7sza1WGB1/vfwUu/rSJsaEar3VkRs7Bcyls8oZXt0gnMS2Hube7w5yb66bi+EL7zdwCuC16b1yOrOpiCKJqIk/1snEzu17Op+h4Vj8QX5nWjKKXfR2xwCCsMe2LkGdW1DXU8p83Zqre5lSQraTkKVb+hxMSnv2rtdcMTYFvgwrgmkAfRf6N+sGB0xz9AHUhO+bgbavi9xudecEPMNETor23Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2B4smK23xjyd4sD15htCrq/WKGbhXXBUOhcbznOFGsk=;
 b=cu/gxwfvx806qXNOsdP5NBYs4Gu4oaNrEWgbOoHMAbeC9XIs5kdUyXx1dS8br45yWIcMghAc22+7IpsOhlZj65JojG+DgH070TjwF9rMSAJ9HaRxRSBkrsYOFUw6TZVms7JIvOOFLi+WqpzOyoAeKi6b4Im31+Wha9czgsdzmG1mXbO2Oz5MOvdl/qeEAIgByFsvSWo4uLzUoSLG7M0bFQTmlB2IZD0g9/jsRwbEmZJybDP6ncgIAFz6IoK+lOSc4PlDZhxmlV9Pqq+3GQltSTSlNudsbi4W8V85Y8XzDz01pCb0YhRiMHEs7YQ87p0wTxrWCGPw0W7s9GvUALhMaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2B4smK23xjyd4sD15htCrq/WKGbhXXBUOhcbznOFGsk=;
 b=ICZD6+iShDlZt+k3y1KxvLKxhDpBxEfqmGy+RJamnbBN4mAvOMzW03Zd4RJVS4plzuhBBmAU7A4epWxSRpXh/OXTY47PE3AG3kmWMkzDO9oSHnD+RO2o8xVa++ppjP3A+M/MNRXsB3Ai7VmRCBD6pLZg3yQ/1xMH4456B7cQhKQ=
Received: from CY5P221CA0108.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:9::39) by
 DM4PR12MB8524.namprd12.prod.outlook.com (2603:10b6:8:18d::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.18; Wed, 16 Oct 2024 14:51:08 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2603:10b6:930:9:cafe::db) by CY5P221CA0108.outlook.office365.com
 (2603:10b6:930:9::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27 via Frontend
 Transport; Wed, 16 Oct 2024 14:51:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Wed, 16 Oct 2024 14:51:08 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Oct
 2024 09:51:04 -0500
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <gautham.shenoy@amd.com>, <mario.limonciello@amd.com>,
	<perry.yuan@amd.com>, <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Dhananjay
 Ugwekar" <Dhananjay.Ugwekar@amd.com>
Subject: [PATCH v2 2/2] cpufreq/amd-pstate: Set the initial min_freq to lowest_nonlinear_freq
Date: Wed, 16 Oct 2024 14:46:42 +0000
Message-ID: <20241016144639.135610-3-Dhananjay.Ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241016144639.135610-1-Dhananjay.Ugwekar@amd.com>
References: <20241016144639.135610-1-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|DM4PR12MB8524:EE_
X-MS-Office365-Filtering-Correlation-Id: e213acb0-1f21-409f-071e-08dcedf1f82c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xn1krNmA8EOdEEGsDOAIPL0JBKyHuNdqcCdnHfV06Sf0UxUCTW/dOl6DhcdH?=
 =?us-ascii?Q?vMYgrLr2zhnvMVW6UszgFcMo6vDreMgi39qBdrNiwwwCdJYIL4TOrKLT8n0j?=
 =?us-ascii?Q?KyULNmvpkfT8XX1eWVpg5ybn+lUz8omBlRqt3J16XIh626+gbtef2FFMnC0J?=
 =?us-ascii?Q?Oo3TtE9bKXy8ftiIMO0d3W7SafuNSzdsqMyuGMl6md/9tVo73R3OdYnGPZ5g?=
 =?us-ascii?Q?SFIsLiNj7EqmR2fpUQuwxpIAC0P9j83gQm++M3F5iUS/e1z4THG37j6GTfZx?=
 =?us-ascii?Q?Lkvoo4Zm1MwICeN5MhDLXTw1WJpEUyaYNeiWQ9IDLBQxjtaPv5UQN3KzRGeJ?=
 =?us-ascii?Q?UOFsBrsEFhIXeKo3BTutxHFtKGnfc8iU8JdfF70Q4NocpjPtwYrONwrUoT0G?=
 =?us-ascii?Q?Jqwx42Jtlob67aU8GBiFYA+9crRFUzHQFbEyFLHx6wq/DIcWb4S8P3GHXsil?=
 =?us-ascii?Q?NimHIRKthjdArL6eEkF8DVVES9qX9zMQHcIKKNHxpuhcX3a2Dgekr0g20bZY?=
 =?us-ascii?Q?gynclQm4ER0dFVFiSyyYIhbUmBYoo1csRLymHzpyNLcWsmSdjTsSs5LxlP1d?=
 =?us-ascii?Q?S93b7BwiTlXM9D8zZPpYYLOC+9GuPQbVyUFgL2WKZn+62KvPzwUQFcN7CDl2?=
 =?us-ascii?Q?ofgQ3s8T/q+O1K1keXaD0m6odrt2/nuivgyzeuwFWIgP3MBSPeXPOj5UuQm1?=
 =?us-ascii?Q?ypfz6VFJq3+Q0Ze/GXNR695Je2t7E446TKBWIrqG9LFFt/oz3D6usg0KSrMb?=
 =?us-ascii?Q?a7GCmaZ8B+Gg5nC382/t9qo+EMClowRCg21W0pJF3X2DrDP5mgLuRkZduW8s?=
 =?us-ascii?Q?IhLjbl5d8bAfFUVCRO1sOuWBaXKYIek4Rk618jP3i7SXMJJBS5lCulSAOhxq?=
 =?us-ascii?Q?TvReTlFGdLy5CH6QUY1r2rn5bfR11D/gxapcVjHWPaWsdcixRLxRjz2PMdVp?=
 =?us-ascii?Q?26h1JOYiNIPZs1UcBPnzPRsgQ0ZHBMDFdLMqWpae4+WHkQfsWmAXNAzsb6b1?=
 =?us-ascii?Q?WqowZWC3gE/K+P7romX6j85wN6CNBgz6pOM3bJJwZnNIF7eZx+MRx4mggdqy?=
 =?us-ascii?Q?FCSWhNNl4TFVbI1z8jGTld8JslXzLX5YSK6ThviMhZ358apKfNxC6SxQ+6Bn?=
 =?us-ascii?Q?WSS301pTlg5O94fwfA33XoIs713PjfjdTvxnc/upEYaqID+viPRFEQnXNMxU?=
 =?us-ascii?Q?nSF/tYIzbdOP5yP1PCxRoMEyr9fvQ+wddcubBpfZx1t0opvYt2N69cnQe5jl?=
 =?us-ascii?Q?sAEpjFsDT2W6+e8AJaE4Q1mI2MfxKeAj8U+mHaVjbXU0si+KWrMwgpdKECNk?=
 =?us-ascii?Q?Cmki/LHyVqPqGrswgzzGWsWYZZFy6aY/C2HYc09/Q7yEbgGz+SW1dOoNBSXR?=
 =?us-ascii?Q?SH9/ztpVdwkBGU6phelk7nQwJL+v?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 14:51:08.4429
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e213acb0-1f21-409f-071e-08dcedf1f82c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8524

According to the AMD architectural programmer's manual volume 2 [1], in
section "17.6.4.1 CPPC_CAPABILITY_1" lowest_nonlinear_perf is described
as "Reports the most energy efficient performance level (in terms of
performance per watt). Above this threshold, lower performance levels
generally result in increased energy efficiency. Reducing performance
below this threshold does not result in total energy savings for a given
computation, although it reduces instantaneous power consumption". So
lowest_nonlinear_perf is the most power efficient performance level, and
going below that would lead to a worse performance/watt.

Also, setting the minimum frequency to lowest_nonlinear_freq (instead of
lowest_freq) allows the CPU to idle at a higher frequency which leads
to more time being spent in a deeper idle state (as trivial idle tasks
are completed sooner). This has shown a power benefit in some systems,
in other systems, power consumption has increased but so has the
throughput/watt.

Modify the initial policy_data->min passed by cpufreq core to
lowest_nonlinear_freq, in the ->verify() callback. Also set the
qos_request cpudata->req[0] to FREQ_QOS_MIN_DEFAULT_VALUE (i.e. 0), 
so that it also gets overridden by the check in verify function.

Link: https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/24593.pdf [1]

Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index fa16d72d6058..117ad5988e8e 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -529,8 +529,20 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
 
 static int amd_pstate_verify(struct cpufreq_policy_data *policy_data)
 {
+	struct cpufreq_policy *policy = cpufreq_cpu_get(policy_data->cpu);
+	struct amd_cpudata *cpudata = policy->driver_data;
+
+	if (!policy)
+		return -EINVAL;
+
+	if (policy_data->min == FREQ_QOS_MIN_DEFAULT_VALUE)
+		policy_data->min = cpudata->lowest_nonlinear_freq;
+
 	cpufreq_verify_within_cpu_limits(policy_data);
 	pr_debug("policy_max =%d, policy_min=%d\n", policy_data->max, policy_data->min);
+
+	cpufreq_cpu_put(policy);
+
 	return 0;
 }
 
@@ -996,7 +1008,7 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 		policy->fast_switch_possible = true;
 
 	ret = freq_qos_add_request(&policy->constraints, &cpudata->req[0],
-				   FREQ_QOS_MIN, policy->cpuinfo.min_freq);
+				   FREQ_QOS_MIN, FREQ_QOS_MIN_DEFAULT_VALUE);
 	if (ret < 0) {
 		dev_err(dev, "Failed to add min-freq constraint (%d)\n", ret);
 		goto free_cpudata1;
-- 
2.34.1


