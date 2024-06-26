Return-Path: <linux-pm+bounces-10002-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4536F917745
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 06:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C602B1F21D4D
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 04:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6014213AA3C;
	Wed, 26 Jun 2024 04:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dXlLeRWt"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455572AE6A
	for <linux-pm@vger.kernel.org>; Wed, 26 Jun 2024 04:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719376096; cv=fail; b=QzDqYYgcubGk74AQkpYrI3ZCGBndAJniDwJQc3JT04bahYdpBWdgwC85oq2nMZI6cqoWQtpKGe9VipKx7JDhCZmhn3rV/aUqlIVqMxh52vt6/+lbBB4NoBXfO1sT7cLrruTl47spnfPMz3gv3vd9/9iOdSNTazQc5ybPk+cWobY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719376096; c=relaxed/simple;
	bh=hMKom6V6XxOA2UtbkFtqNTmSOaizK9eX5zLZLAxjpVw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wy2Bnm3vX5yL0vrJm8hrt8Nmgpf6cESk3wX7WRGWxyITFMBt4ICIuKeJE2x7ta6+UxgwJqbA5YhoohEvDfat6WCq+7sOno2x0luqXuk2UhY4YjO64Vz5LPuQu7xwHvsIR2yeprHFXaP8I/lN9dZIh6ueTcnzPijhHzGwChGMB2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dXlLeRWt; arc=fail smtp.client-ip=40.107.223.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=etAHNhe59gMkU6I4B77I22R4Sscas0FOpS4HcnDR3YKvl0MzKLR6B+m01d/8tJVv96pNMI4efwwK68fN856J1+xnIy4/ZhV2um0s69INju21X+C15l/Awmm6qD6Fh9CYQXpHpqATSjh/DTSJ+rxSCu7d8WF+yt1n00fL8t4fhelLG2g9UlTbyP3f5KVc2+5iUqNNdS3UvnMaiFnDe8DSubhU1cw6clsf75dwu3xtHbj9Ih1wRigHS4RU/j0C9V50AgYlNMKgFTOp0QiDgDymvUL6Yf6Ne0tpGwuWrLHYlqnpb2FQDTWlUViqByPXfqEeVKLyj5ZHbkCM9Ro4DvQrYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7/ycf6MEjYlCa9mi3ACVj/dlaepSFBRsCDAvZevWuX0=;
 b=JroCsRU8WhHJByjd53zhfUxwSDGJIMe3i16gpcrleR8HSjegliJ3pGBqH6Dzzv9g4g0APOCBx9nOvMAbVfe6v1e3ZDDSpSqEG/Pikv2r7ObKV4cjwcqQBW6PZ5BZguAblGqo7oUTfbcPnVONkY2mq3pe7cyu+8ro5F6AJrx/ymHR17DGkv3GZEnd05O61MQ3ZFwOEYmUs8fBMhqkS9h2pjad7hJQ/oXt1E1ytD4l3f56sdNdBwCT8uTeEUvRwncjZBFFIB+TPRZpKJrFFmKzzVzzK0Sd6cCYGJ9p7mT2hNd4GEdtXQgmD4qPTOHiPjjhiZEGjO1dUM6nd7D7K+Uz/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7/ycf6MEjYlCa9mi3ACVj/dlaepSFBRsCDAvZevWuX0=;
 b=dXlLeRWtsjgDoezyZgIKN8BE7SYhwMeiJ28P1XLXRr/3vZ53qY8XU5U1EQPL4QKftNxq+oCHXVTwKLhcpbfcNYN8Cu0yOyV5Zbw08vq61+3TvCAcFr9Ov7r9XjmhBXgwXkD5sGVLg+zFD2rWxIZcU6XMSuLM3TKAdaXFtD5MS1M=
Received: from SA9PR13CA0109.namprd13.prod.outlook.com (2603:10b6:806:24::24)
 by MW3PR12MB4412.namprd12.prod.outlook.com (2603:10b6:303:58::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Wed, 26 Jun
 2024 04:28:11 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:24:cafe::e7) by SA9PR13CA0109.outlook.office365.com
 (2603:10b6:806:24::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.20 via Frontend
 Transport; Wed, 26 Jun 2024 04:28:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 04:28:11 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Jun
 2024 23:28:10 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <perry.yuan@amd.com>, <gautham.shenoy@amd.com>
CC: <linux-pm@vger.kernel.org>, Perry Yuan <Perry.Yuan@amd.com>, "Oleksandr
 Natalenko" <oleksandr@natalenko.name>, Mario Limonciello
	<mario.limonciello@amd.com>
Subject: [PATCH v15 2/4] cpufreq: amd-pstate: initialize core precision boost state
Date: Tue, 25 Jun 2024 23:27:31 -0500
Message-ID: <20240626042733.3747-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626042733.3747-1-mario.limonciello@amd.com>
References: <20240626042733.3747-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|MW3PR12MB4412:EE_
X-MS-Office365-Filtering-Correlation-Id: 012702b4-01be-4512-0822-08dc95986351
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|1800799022|82310400024|36860700011|376012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BjPeoHQwtjSA3+QQj2YrPWwASIxUGRCX8Jtnt6E+Tdv3pCEDMGmIvHLWMOeB?=
 =?us-ascii?Q?2tYDNFTO4xQda/xNdS1hJ7iIvlLHqzm8kise18JpJG1w+J503hzKYfVpbVQ6?=
 =?us-ascii?Q?j+WBoiNwz7A8WjPa6HV2/kX/EoyJKYNnMaNAmbeOeM/BCkbcO8GY3Nbv6lSl?=
 =?us-ascii?Q?jk+F3lyinqdBd0lpBWnS6TTjsE4P6O0uzu7WMAXNvl8AGkmNe4hj26uCG8Il?=
 =?us-ascii?Q?vuRUSHeN4IFdx10PLWdEVyWhEMfKfFrhbZNq15HfkF73TgmxkkcpbKgL7MDM?=
 =?us-ascii?Q?ZSdRrLot8CcpV0Jjm2D4dPBSOlxUjFr3O3Z+fVTxty67tY44HdEEVOBXj92l?=
 =?us-ascii?Q?yQTZuJKvZR2ggFBteiKMKtiOWr4CyADh8yZUqTEM/lz8IIfrNCuqIYe6UWrZ?=
 =?us-ascii?Q?3fuwm4H2jXBWVmxzf0hRjSSIeiOBPtKWA7tFtBTN+QNavpIUGHDRwPJORS18?=
 =?us-ascii?Q?LuOonTZ01FG87Z13xtVbrtnppISPsquWjFFXqhFMeYtJZzoHoIkYAZbXDfO/?=
 =?us-ascii?Q?hNjz2jKjoomYYQyqRhGQ6rqLJOnM5aVBXoEjPXmaTbrmz/a3Ed1IcWQ8Ds7F?=
 =?us-ascii?Q?PhR9o3VHMF/x+PZcRHnJVZtwWwzqMNCMbHt6o7b0qR4Lpr/hmoA37BPsE7he?=
 =?us-ascii?Q?iF25Cw1AB/qlW/VgG94Rxi8VpnzJuCdSmWV/k+BLoKPPLIj+iRwJNhmiU1jF?=
 =?us-ascii?Q?Qrq1/qeBlwvJJGG4QXvY9uZ8XIHqmO+h+7gNr4qHkcCRhv7LME3uZPXYH4wd?=
 =?us-ascii?Q?4AjOaSTb3bEFpzLnK+GWPIwXCICxXZghWRi4FmzS4QU7cAjs8JLg8wSsLmA7?=
 =?us-ascii?Q?ae+TejmSWNf+dNruxIyxMxbAzz1XDxPitxPUopNmJ7DKcBa1Fit9CizHXEfw?=
 =?us-ascii?Q?IMNFbK0aus7pkSfJWYx5RJRlnU6TOea1vJZ0PDMHBwtnHr1se17I2VFE278r?=
 =?us-ascii?Q?E4ASXWshPB2f3MILNE5JFH0Qc14Fi9UXAetXYS09JljAiUPGGx4ZsPhM5DBd?=
 =?us-ascii?Q?dTOr153QS1oMz6cVoBvyguj+tRWaFAZcynqHkXKD21OaBiNf1ssqa1LO60oV?=
 =?us-ascii?Q?iH8DWJd6SXmt3y1QoF7Q6TN/PfqsnJzke0AnCsjswlDIz+UmSo2rw/Z/KdVV?=
 =?us-ascii?Q?BgurLFHPQ0ZHZY6vg5lJ1dT8M4ct9a9GEkNVliZ3OpcbI4CgPvJjyq9UcdQY?=
 =?us-ascii?Q?2YS4hsoOf/pjCA/pwZOgg9rlXI6NxVMRZFo7Q2/bopm0/XvmNk9DLsXqWoPM?=
 =?us-ascii?Q?pNwAYL5j9bedRllPQ9qz70NbmEQhaYPc0lOvhjeO97TFjsciybII9cNiRNJR?=
 =?us-ascii?Q?ZLpzGLQiz15WbCDkRgO7QJ5kWKYrqnkoaI68Ao7QCxqjksIZkXmx3NRmsz4E?=
 =?us-ascii?Q?ZL9H/tZztmgZkpMjElu4jRfCEakW?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230038)(1800799022)(82310400024)(36860700011)(376012);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 04:28:11.2809
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 012702b4-01be-4512-0822-08dc95986351
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4412

From: Perry Yuan <Perry.Yuan@amd.com>

The "Core Performance Boost (CPB) feature, when enabled in the BIOS,
allows the OS to control the highest performance for each individual
core. The active, passive and the guided modes of the amd-pstate driver
do support controlling the core frequency boost when this BIOS feature
is enabled. Additionally, the amd-pstate driver provides a sysfs
interface allowing the user to activate/deactivate this core performance
boost feature at runtime.

Add support for the set_boost callback in the active mode driver to
enable boost control via the cpufreq core. This ensures a consistent
boost control interface across all pstate modes, including passive
mode, guided mode, and active mode.

With this addition, all three pstate modes can support the same boost
control interface with unique interface and global CPB control. Each
CPU also supports individual boost control, allowing global CPB to
change all cores' boost states simultaneously. Specific CPUs can
update their boost states separately, ensuring all cores' boost
states are synchronized.

Cc: Oleksandr Natalenko <oleksandr@natalenko.name>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217931
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v14->v15:
 * When turning off boost only reset frequency if it's set above
   nominal frequency
---
 drivers/cpufreq/amd-pstate.c | 117 ++++++++++++++++++++++++++++-------
 drivers/cpufreq/amd-pstate.h |   1 +
 2 files changed, 96 insertions(+), 22 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index afcf398574f6..db4fbd8d1e06 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -679,43 +679,105 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
 	cpufreq_cpu_put(policy);
 }
 
-static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
+static int amd_pstate_cpu_boost_update(struct cpufreq_policy *policy, bool on)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
+	struct cppc_perf_ctrls perf_ctrls;
+	u32 highest_perf, nominal_perf, nominal_freq, max_freq;
 	int ret;
 
-	if (!cpudata->boost_supported) {
-		pr_err("Boost mode is not supported by this processor or SBIOS\n");
-		return -EINVAL;
+	highest_perf = READ_ONCE(cpudata->highest_perf);
+	nominal_perf = READ_ONCE(cpudata->nominal_perf);
+	nominal_freq = READ_ONCE(cpudata->nominal_freq);
+	max_freq = READ_ONCE(cpudata->max_freq);
+
+	if (boot_cpu_has(X86_FEATURE_CPPC)) {
+		u64 value = READ_ONCE(cpudata->cppc_req_cached);
+
+		value &= ~GENMASK_ULL(7, 0);
+		value |= on ? highest_perf : nominal_perf;
+		WRITE_ONCE(cpudata->cppc_req_cached, value);
+
+		wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
+	} else {
+		perf_ctrls.max_perf = on ? highest_perf : nominal_perf;
+		ret = cppc_set_perf(cpudata->cpu, &perf_ctrls);
+		if (ret) {
+			cpufreq_cpu_release(policy);
+			pr_debug("Failed to set max perf on CPU:%d. ret:%d\n",
+				cpudata->cpu, ret);
+			return ret;
+		}
 	}
 
-	if (state)
-		policy->cpuinfo.max_freq = cpudata->max_freq;
-	else
-		policy->cpuinfo.max_freq = cpudata->nominal_freq * 1000;
+	if (on)
+		policy->cpuinfo.max_freq = max_freq;
+	else if (policy->cpuinfo.max_freq > nominal_freq * 1000)
+		policy->cpuinfo.max_freq = nominal_freq * 1000;
 
 	policy->max = policy->cpuinfo.max_freq;
 
-	ret = freq_qos_update_request(&cpudata->req[1],
-				      policy->cpuinfo.max_freq);
-	if (ret < 0)
-		return ret;
+	if (cppc_state == AMD_PSTATE_PASSIVE) {
+		ret = freq_qos_update_request(&cpudata->req[1], policy->cpuinfo.max_freq);
+		if (ret < 0)
+			pr_debug("Failed to update freq constraint: CPU%d\n", cpudata->cpu);
+	}
 
-	return 0;
+	return ret < 0 ? ret : 0;
 }
 
-static void amd_pstate_boost_init(struct amd_cpudata *cpudata)
+static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
 {
-	u32 highest_perf, nominal_perf;
+	struct amd_cpudata *cpudata = policy->driver_data;
+	int ret;
 
-	highest_perf = READ_ONCE(cpudata->highest_perf);
-	nominal_perf = READ_ONCE(cpudata->nominal_perf);
+	if (!cpudata->boost_supported) {
+		pr_err("Boost mode is not supported by this processor or SBIOS\n");
+		return -EOPNOTSUPP;
+	}
+	mutex_lock(&amd_pstate_driver_lock);
+	ret = amd_pstate_cpu_boost_update(policy, state);
+	WRITE_ONCE(cpudata->boost_state, !ret ? state : false);
+	policy->boost_enabled = !ret ? state : false;
+	refresh_frequency_limits(policy);
+	mutex_unlock(&amd_pstate_driver_lock);
 
-	if (highest_perf <= nominal_perf)
-		return;
+	return ret;
+}
 
-	cpudata->boost_supported = true;
+static int amd_pstate_init_boost_support(struct amd_cpudata *cpudata)
+{
+	u64 boost_val;
+	int ret = -1;
+
+	/*
+	 * If platform has no CPB support or disable it, initialize current driver
+	 * boost_enabled state to be false, it is not an error for cpufreq core to handle.
+	 */
+	if (!cpu_feature_enabled(X86_FEATURE_CPB)) {
+		pr_debug_once("Boost CPB capabilities not present in the processor\n");
+		ret = 0;
+		goto exit_err;
+	}
+
+	/* at least one CPU supports CPB, even if others fail later on to set up */
 	current_pstate_driver->boost_enabled = true;
+
+	ret = rdmsrl_on_cpu(cpudata->cpu, MSR_K7_HWCR, &boost_val);
+	if (ret) {
+		pr_err_once("failed to read initial CPU boost state!\n");
+		ret = -EIO;
+		goto exit_err;
+	}
+
+	if (!(boost_val & MSR_K7_HWCR_CPB_DIS))
+		cpudata->boost_supported = true;
+
+	return 0;
+
+exit_err:
+	cpudata->boost_supported = false;
+	return ret;
 }
 
 static void amd_perf_ctl_reset(unsigned int cpu)
@@ -968,6 +1030,10 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 	if (ret)
 		goto free_cpudata1;
 
+	ret = amd_pstate_init_boost_support(cpudata);
+	if (ret)
+		goto free_cpudata1;
+
 	min_freq = READ_ONCE(cpudata->min_freq);
 	max_freq = READ_ONCE(cpudata->max_freq);
 
@@ -980,6 +1046,8 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 	policy->cpuinfo.min_freq = min_freq;
 	policy->cpuinfo.max_freq = max_freq;
 
+	policy->boost_enabled = READ_ONCE(cpudata->boost_supported);
+
 	/* It will be updated by governor */
 	policy->cur = policy->cpuinfo.min_freq;
 
@@ -1005,7 +1073,6 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 
 	policy->driver_data = cpudata;
 
-	amd_pstate_boost_init(cpudata);
 	if (!current_pstate_driver->adjust_perf)
 		current_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
 
@@ -1420,6 +1487,10 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 	if (ret)
 		goto free_cpudata1;
 
+	ret = amd_pstate_init_boost_support(cpudata);
+	if (ret)
+		goto free_cpudata1;
+
 	min_freq = READ_ONCE(cpudata->min_freq);
 	max_freq = READ_ONCE(cpudata->max_freq);
 
@@ -1435,6 +1506,8 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 	policy->min = policy->cpuinfo.min_freq;
 	policy->max = policy->cpuinfo.max_freq;
 
+	policy->boost_enabled = READ_ONCE(cpudata->boost_supported);
+
 	/*
 	 * Set the policy to provide a valid fallback value in case
 	 * the default cpufreq governor is neither powersave nor performance.
@@ -1456,7 +1529,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 			return ret;
 		WRITE_ONCE(cpudata->cppc_cap1_cached, value);
 	}
-	amd_pstate_boost_init(cpudata);
 
 	return 0;
 
@@ -1718,6 +1790,7 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
 	.suspend	= amd_pstate_epp_suspend,
 	.resume		= amd_pstate_epp_resume,
 	.update_limits	= amd_pstate_update_limits,
+	.set_boost	= amd_pstate_set_boost,
 	.name		= "amd-pstate-epp",
 	.attr		= amd_pstate_epp_attr,
 };
diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
index f80b33fa5d43..cc8bb2bc325a 100644
--- a/drivers/cpufreq/amd-pstate.h
+++ b/drivers/cpufreq/amd-pstate.h
@@ -100,6 +100,7 @@ struct amd_cpudata {
 	u64	cppc_cap1_cached;
 	bool	suspended;
 	s16	epp_default;
+	bool	boost_state;
 };
 
 #endif /* _LINUX_AMD_PSTATE_H */
-- 
2.43.0


