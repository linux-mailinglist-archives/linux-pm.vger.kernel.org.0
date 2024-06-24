Return-Path: <linux-pm+bounces-9921-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6482915919
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 23:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C1AC281A33
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 21:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142E41A0AFC;
	Mon, 24 Jun 2024 21:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="217zsuSI"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3EF1A08CC
	for <linux-pm@vger.kernel.org>; Mon, 24 Jun 2024 21:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719264868; cv=fail; b=jcuuy6TQQ66qo34M2HdF6vCUNBufUzAVObLnLOQNmIej3aPKTkvO5VTkd0hu6BCKZbz7aLGoABmgJWGhznWUf1VTbV+zQz9R+Qz8BgupXbFB6le3h3iOh8acWHJvb4oYZKOKZnM6obkfo+44J4jx3dGZJX+kAjR8VsWunyL3hu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719264868; c=relaxed/simple;
	bh=1vBo1Cl4K8Od/Xacsi/+zbbk4yEEr2WxFeD0vRLIq3k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DbxvWAIGeUuACR3Jmzllu30TT9FsBci3PK5Hvj72FM7gogT2K+rFwxkxNMu3LFWLCujqEmTy5c1zBhqokpuvqpWckq4mTfb3Diqzyjlj+Iofe7zNTGEmd+kYUA/W9rXyGIF4Gfz7K3agX7xswejWCkDLsyYoFDhH3hgLwz+b7fY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=217zsuSI; arc=fail smtp.client-ip=40.107.92.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FmE1doqJplDFf3AUbho+pi0yrHDSSbidbmjQfU1PlqytDmSVNEKgTUHiPRfxjDB/P/7Bxwm68EIfsBWGtX4oou9cx3F0oi71DaxYsEoP94nRPj9h/u69XR88d0qktQDykSeu1kJ6O1Al58DdQD3ZwszAE8/NRLtrBU9/RILKFW0gn1aI5tHTi0RpysHj+UurSYznaRcwW8TJksS+06VHe4Hd6SYGTzfrkyauJGjS+DAaunBEMaIN4cNj0P0w7La7nciYn/DH+POzlTXEhHnq8p1FBcZ/Ao3irEuo2UIoOVRCCSrij2Z/lRvyq9wDlFr1XflC8BYu/XWAL106zikSKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/j2klPQVapDJNhRdOP9A2LN6LlctqjLNHdyX4X25V0U=;
 b=XNY/vRi7LEiayjbb0I9LX1ilYtDTqFU9g2Bt4BMVFdGz1BrWzjw9rRgk1KzzkD0ifSiMen1Z8Lll/o7gsyfOFDK328Tz91vvT0WBaVRYkmiWe9zaxH3k2iRzJ4i1yZ7wyn9kowqGIGYhXr94EuWbCDz1f89tJ8XG9kcMFzLUHhD4hoa0tk49cy2xiQss6gj8clumBGrJYlJLQeHZJSfMOkPPPGQQTqw6BiNieFZBY6HBmJefPSzs3H7OwAije2GX8/39GlnLeInxxesj717Gn8kExmUP7+IGr0LlT1wiKiD001vdKyEfy0unLiLKMPsBRTOCoDiHM1dPXRYp9rj2Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/j2klPQVapDJNhRdOP9A2LN6LlctqjLNHdyX4X25V0U=;
 b=217zsuSIXFIHlfi9YIRohAGEArp+iKRnst2uoarWMt8eAZQ445mENjRERZEwOQVQ0BQvjbHAKzTSu1uSjSzCQnZ3UaC0S3VT889hJ79qc6CYJEFcBD/FeucHLJOAoFwAAMaQyoDrbQ9dcSTDEVuU4qVMFmIogHrx9qKxJqzJHFI=
Received: from CH5PR03CA0004.namprd03.prod.outlook.com (2603:10b6:610:1f1::6)
 by PH0PR12MB8774.namprd12.prod.outlook.com (2603:10b6:510:28e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Mon, 24 Jun
 2024 21:34:20 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:1f1:cafe::1b) by CH5PR03CA0004.outlook.office365.com
 (2603:10b6:610:1f1::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Mon, 24 Jun 2024 21:34:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 24 Jun 2024 21:34:19 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Jun
 2024 16:34:18 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <perry.yuan@amd.com>, <gautham.shenoy@amd.com>
CC: Linux PM <linux-pm@vger.kernel.org>, Perry Yuan <Perry.Yuan@amd.com>,
	Oleksandr Natalenko <oleksandr@natalenko.name>, Mario Limonciello
	<mario.limonciello@amd.com>
Subject: [PATCH v14 2/5] cpufreq: amd-pstate: initialize core precision boost state
Date: Mon, 24 Jun 2024 16:33:57 -0500
Message-ID: <20240624213400.67773-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240624213400.67773-1-mario.limonciello@amd.com>
References: <20240624213400.67773-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|PH0PR12MB8774:EE_
X-MS-Office365-Filtering-Correlation-Id: 259a880d-a234-4039-6a7e-08dc9495680a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|1800799021|82310400023|376011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8Osl7ftVhquoEowvIFDx6p8xnA720CfvvXBLh6il5RMcNTEDGnxTNKWESuCp?=
 =?us-ascii?Q?CFa56DnJ5mgr0prSK7zvVcuV9F1OsseDropDQ7bdg06fjsb9PKJyIXaeg915?=
 =?us-ascii?Q?NW3rJWA/W9iJoLyJMuyhn8lXP0UHbgmRAyTOW9IHHaqmduQ6gfCWAdqNHJVZ?=
 =?us-ascii?Q?e5eFqhS5az1frwlCQR1PekwA9J2Bba2bzD6JWm0klkxy3LNGHXTyo6Ns/adk?=
 =?us-ascii?Q?+AoCje8XajkwTLaTimvuL7nDSfmSR7iXtwu8fnsDQZgXWyrhZA+r/VU0izzN?=
 =?us-ascii?Q?1TQipg+J6yt2FaiwI4fr9NhYlFe1fmf8noFEywFZQNcCnTJIg+QZCAhh2Dyx?=
 =?us-ascii?Q?p3FkAG69yVYlawZCfF0oRzXcM3heF23vgW8g1tNyhdRK1eAH+2qR1Ek/c0bq?=
 =?us-ascii?Q?n1/G2COM66iIoB/M2McMlpRhxKKtebU1ufdW8PWhdjzaeYyZzUpSHpH/6XSv?=
 =?us-ascii?Q?qHfS2RpI6nlpVn7QfyPLm4i3zICaBF0xIgPeufb7DJfHJ02zACYRhMSpss1t?=
 =?us-ascii?Q?tkfVTT5dKOalV7vAxmALkHWvUeL6fNsXI9qGZ/z2Kh5vSzjmK93EKrjJ/cDX?=
 =?us-ascii?Q?SJBrxYWMCT4NO073UWPc1np0GZQ7eCbQrBYwCcRgr+SbsGVOR6qp11aP02UW?=
 =?us-ascii?Q?f8iqm5Wh3o/QyZJm8OIXqGOL1pbt3i2eg1b76aVIrdJJY4W+1mePGvaeGe7q?=
 =?us-ascii?Q?PDCyoNVd2I0cmvr95RXYlyCDa6mSep3QRmo03JWf1EuVJaeXDQ6DF8fTCc40?=
 =?us-ascii?Q?csg92wTqtR5w8MAoyPTijBFDcrQE8/Slcv6FUj7+Cq3zdaYixY2s6ez4iLkv?=
 =?us-ascii?Q?y84THOolqGeFHLBGgUnAO1UajvkQYikY/Vz2u+E5PWaS9OQyZ2DcnKbraplq?=
 =?us-ascii?Q?80s4QyzST3iVWQdHLCW6Ys/ypbwQeAikbpDjEDv2guhN8SPRVdD1VMkoWxGt?=
 =?us-ascii?Q?rnf3IFPWCNghIYs70oaceNs5P0z5kaTAo9j9phQ4yGOuBQ7O3w2PnA4b6BML?=
 =?us-ascii?Q?w8D5BsS3yz7Qt/0KARN38NrCuocEmjy8qjSfFbOzBhzIiuNDXwH1b15EK7lJ?=
 =?us-ascii?Q?noBtHsFxiiBTWs/WThJnua361+v+oQLdH0wF8QsBFZ8FROtV0G99T86EvSt4?=
 =?us-ascii?Q?qKc8XKozj7snwunySnSJ2L2NDXJFmGTXGi8riao1vgruqsFnGn8g1YnnOLwQ?=
 =?us-ascii?Q?Z3Q89842vv5s+dm20OoGYbJ+DrU6vY4Rx3j8mhz/mTmhEGGNV9QRFL+Hbhv0?=
 =?us-ascii?Q?u9a5GjiDBUg6kRpA/X8y8pkBf5FTMeDo0nBFIKwNqg+BQUKHYJG8FvPx+692?=
 =?us-ascii?Q?dHFeHu+9eZ0sd7Oy+Zrfma8MeIuqzW9daU0ZWIYNJo4x1W2iS/nX4pAx4r2+?=
 =?us-ascii?Q?8VDWR8E=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(1800799021)(82310400023)(376011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 21:34:19.5381
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 259a880d-a234-4039-6a7e-08dc9495680a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8774

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
 drivers/cpufreq/amd-pstate.c | 115 ++++++++++++++++++++++++++++-------
 drivers/cpufreq/amd-pstate.h |   1 +
 2 files changed, 95 insertions(+), 21 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index afcf398574f6..10cce7023208 100644
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
+	if (on)
+		policy->cpuinfo.max_freq = max_freq;
 	else
-		policy->cpuinfo.max_freq = cpudata->nominal_freq * 1000;
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
+
+static int amd_pstate_init_boost_support(struct amd_cpudata *cpudata)
+{
+	u64 boost_val;
+	int ret = -1;
 
-	cpudata->boost_supported = true;
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


