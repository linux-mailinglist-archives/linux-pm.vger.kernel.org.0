Return-Path: <linux-pm+bounces-9054-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C91529064FB
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 09:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6714E285A94
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 07:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FAD13C3EE;
	Thu, 13 Jun 2024 07:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZxvG7OCz"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E0B13BC25;
	Thu, 13 Jun 2024 07:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718263563; cv=fail; b=cI+Wsl8i5fpro9czCdwzkLdXQEkjJGyCUced1RvTu3alCKhhszuJJbFxz7ZUq9DahgD2TyA8AWnAH2PdLOEbkTeDLp4rp9BXMNS7KTzwf3u7nZ+7pk4kyAdIuhvuH/QeJrB1cR+eal7BjwpQ5IljWVnpIhUb+9vK5BctZwAhRYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718263563; c=relaxed/simple;
	bh=umVTnb12KRIzSMwZQK8hmJr0bNdQgfV8qTVfrcctagM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=le5sK3iczPk/+GjiASVImaJHe7NY1TX4pRxIRph3NY4ZCoV+EXMZ7uEwz7En7ldPokt5qn+REPtWYy81PV2laZJwKGcqdKUys2UuFTSrkOI2dAbCJq8xA04pvYqxSSG7MS7lxTjHN26Q8aidP8RhtNH2V1fVuT2A943H1dW66B4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZxvG7OCz; arc=fail smtp.client-ip=40.107.243.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d/bwws5awGWNTI9LhsP4WDSIQCql+jbLKfZCerAx4MIIMPs4jtVfhfdNyE2HuGqLdljb33jIyOKaAp3r0ynY5Ohc6g7zXlQSfwniBHrB77dzHvEa5m9NckRExgTmAxmHM0x/RL9FHkUPIhzjIncfzRYycB5ivRXuNWOpaym4izK8Js1T47TZHDlWA3+3pWYQ6aOrEluOKkvCuLXCGdP/+5BFSIQ1lyboEiyZH0JgHNyIv+xDdSv/x2ZJ5gQED1q5DXfcMhkgDDJ2Kh6QKs/VOR7T6Dl1DMKy7VMXXj1alhxpCqkJprZCJkGNFQOsp8W/eMav76RGkhbymhADA2b5sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VErKH78LLs+udTzZEcOyfXdi75haNVhISzG/wdXsPD8=;
 b=Y/F2HyJ7jYumJskE/lYuH64J1kK9xFcmI8UtLH/e0M4EezD1HX0chQAEU/G9zyBD0eed2GRCu817ZjeM/au0K2mquTiSXsNxz8joIJUWSmXAntKOErA7sZvYMNpwWq69kgfSOIuHS0tdKNET5LPe93O66v2odAChbVBmQ8ZYU/nIetPkTHGxe+O6ubtvqrBP/18VAx0+clkUo6VGtmu81jE+L9LRU2uXR0j+8yRtJMGPRRUKnZnYunSCH+vI6EBNOgggAigxCbENDrUyBuw5vSqT7jdb1/r0sY+t4fcx+zYw6cjz2YgxIu+gMxmfgp3CiIotQAQvIJ+PaLK/JXNwew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VErKH78LLs+udTzZEcOyfXdi75haNVhISzG/wdXsPD8=;
 b=ZxvG7OCzXl9q1f/cvKKwQD9nkINX8lm+9GJjMOyBNgPHWbZAt9IpgFyx5qyUvWfqQQFLQazF+oDErvlMw9GfcxN71BHDte7ZleMR2YIHmdFObpY0S5EAkqPoccGqEvVzlIzGKS24xqgco3eBeAN8JMV5s2lrw3NyfeI0ZIjew8Y=
Received: from MN2PR07CA0012.namprd07.prod.outlook.com (2603:10b6:208:1a0::22)
 by CH0PR12MB8530.namprd12.prod.outlook.com (2603:10b6:610:188::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.24; Thu, 13 Jun
 2024 07:25:57 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:208:1a0:cafe::e0) by MN2PR07CA0012.outlook.office365.com
 (2603:10b6:208:1a0::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.24 via Frontend
 Transport; Thu, 13 Jun 2024 07:25:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 13 Jun 2024 07:25:57 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 02:25:52 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <Mario.Limonciello@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
	<Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>, <Xiaojian.Du@amd.com>,
	<Li.Meng@amd.com>, <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v11 5/9] cpufreq: amd-pstate: implement cpb_boost sysfs entry for boost control
Date: Thu, 13 Jun 2024 15:25:17 +0800
Message-ID: <35464456ab468f389ff3816829647db77924a6b5.1718262992.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718262992.git.perry.yuan@amd.com>
References: <cover.1718262992.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|CH0PR12MB8530:EE_
X-MS-Office365-Filtering-Correlation-Id: 209a348a-8595-40cf-f18e-08dc8b7a1158
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230034|36860700007|1800799018|82310400020|376008;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+jImwwiz6uWbT5biX/x/hPWuV8kp49JBecsDZGYQcx26X/tx0DkOZSQ6vRd4?=
 =?us-ascii?Q?G4cqT0fu8QqV7nvfAPGSxDwDNTmX1G4Mi2hS1s8bpcLclrZOJfDoHAakcxuS?=
 =?us-ascii?Q?nXAWVUXp8q2QSNOErLVUhqGU9Wnpesvk2X7PczxQxJlhhDZ5HhgNT9/Aj75e?=
 =?us-ascii?Q?YdK4+WvRNALKfVLcEaAeH+l/dTNfvDjJDLq5igiFGhSqDxaz1Re7F4V0sgkr?=
 =?us-ascii?Q?Glb5k2i+igruvmtNeFggKK8k6skUq6eQl2Tmi/RDmRAPf3WwPh0NWYFMvIkm?=
 =?us-ascii?Q?2QWVZfTJKkCmfD7/we2U3QBPLZFL+kX4Jt3qvLfW9x2EYteFiKmX3Lwm6AvC?=
 =?us-ascii?Q?qI7g0szxq91qgM4IVJLEn9iELKgxc6xrwfvddgmcC4KhntDqw51hiGPidxfx?=
 =?us-ascii?Q?9MFUFh5Oek+GeICfANmVACkYWJ67nM6jBJAry62GmdkeIVSRUROAtaHbPROy?=
 =?us-ascii?Q?E/s9xHP9IomhL18CAlfOV3RzO7U3RbZszFNUJ6l7iVXJFd4sKvCHS4kkh+5t?=
 =?us-ascii?Q?E7kcemYxoL2MQtiz/P9nJ5/HATRnH3Wib3aS5/Ei+3cupWem7P8lxkETuC2D?=
 =?us-ascii?Q?eoarcgydYmzLOefEaxjgjG0Semckl/op6x48bDcVm175m1Qghpt9gJ7t0x2T?=
 =?us-ascii?Q?l6OzwvLYdXkjT7CG3o0Cvx90v3DoHXmLDQIPzkNQxG4kg2W08BYrdN9zZobC?=
 =?us-ascii?Q?npqSGsjDYUTCbsSOzmJUmnPAXxeiUKZOxxOezSeUiq1yGac+ZQ1v31RQhOCR?=
 =?us-ascii?Q?MZooeW+9e9TihfwLhxj+ZhAXsGVQJbjhd7iZE5sFMhaZ/CBhesk2StJiA1WQ?=
 =?us-ascii?Q?NLBCu7zSQRE2gz7/Joaoa0uNWJni1afaitZJU7iX/PDbQW4q2xpQwlLJ/yzv?=
 =?us-ascii?Q?k+RiFC4v3hiIs59K/twRHXmmQPk9w0Rmax0muZE1W/QTXCzCxipsySlcVzJE?=
 =?us-ascii?Q?bFVHDN4m8nQcqLVUacW74+/cAIgV2rOsXmWc43ioNcv8hJemgKS3czFP6zyr?=
 =?us-ascii?Q?1A251zgHpF2wrhcJmkoQI5fSnOVuQWy5A0kSiibQDyn/j/VCWuSrIyiBSWgQ?=
 =?us-ascii?Q?n1wvLKUyRNowJNwV3b8Ufq7sxjBPUil5Z12Mv8+QbIHSxt+g7wE18z95EGrE?=
 =?us-ascii?Q?NBx95LAFBblbvCDJv2o3RohIzXgFuso/CxRAbG5xsUH3oXzksTjJwHWQNrxH?=
 =?us-ascii?Q?24zEs0DymTQRBaMqPrdxa1bbbIC5ZAnaB0MU0tl4ggm9egWROkK/vjOi2n7X?=
 =?us-ascii?Q?Jn6sc5obdRO+iLARnpA6tdD/9E7/oHGdUP5ZoV2tNznGpTZPNmuprf33DkEa?=
 =?us-ascii?Q?8t6aRpWfNsJGcvsx4XW++B6CXOt8/PdDRXji9Bwi92cFSTjacYbKc8KminEc?=
 =?us-ascii?Q?1gIv2YM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230034)(36860700007)(1800799018)(82310400020)(376008);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 07:25:57.0580
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 209a348a-8595-40cf-f18e-08dc8b7a1158
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8530

From: Perry Yuan <Perry.Yuan@amd.com>

With this new sysfs entry `cpb_boost`created, user can change CPU boost
state dynamically under `active`, `guided` and `passive` modes.
And the highest perf and frequency will also be updated as the boost
state changing.

0): check current boost state
cat /sys/devices/system/cpu/amd_pstate/cpb_boost

1): disable CPU boost
sudo bash -c "echo 0 > /sys/devices/system/cpu/amd_pstate/cpb_boost"

2): enable CPU boost
sudo bash -c "echo 1 > /sys/devices/system/cpu/amd_pstate/cpb_boost"

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217931
Link: https://bugzilla.kernel.org/show_bug.cgi?id=217618
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate-ut.c |   2 +-
 drivers/cpufreq/amd-pstate.c    | 117 +++++++++++++++++++++++++++++++-
 drivers/cpufreq/amd-pstate.h    |   1 +
 3 files changed, 118 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
index fc275d41d51e..b528f198f4c3 100644
--- a/drivers/cpufreq/amd-pstate-ut.c
+++ b/drivers/cpufreq/amd-pstate-ut.c
@@ -227,7 +227,7 @@ static void amd_pstate_ut_check_freq(u32 index)
 			goto skip_test;
 		}
 
-		if (cpudata->boost_supported) {
+		if (amd_pstate_global_params.cpb_boost) {
 			if ((policy->max == cpudata->max_freq) ||
 					(policy->max == cpudata->nominal_freq))
 				amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_PASS;
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 9f42524074a9..fe7c9d3562c5 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -104,6 +104,7 @@ static bool amd_pstate_prefcore = true;
 static struct quirk_entry *quirks;
 struct amd_pstate_global_params amd_pstate_global_params;
 EXPORT_SYMBOL_GPL(amd_pstate_global_params);
+static int amd_pstate_cpu_boost(int cpu, bool state);
 
 /*
  * AMD Energy Preference Performance (EPP)
@@ -738,6 +739,7 @@ static int amd_pstate_boost_set(struct amd_cpudata *cpudata)
 	if (amd_pstate_global_params.cpb_supported) {
 		current_pstate_driver->boost_enabled = true;
 		WRITE_ONCE(cpudata->boost_supported, true);
+		WRITE_ONCE(cpudata->boost_state, true);
 	}
 
 	amd_pstate_global_params.cpb_boost = amd_pstate_global_params.cpb_supported;
@@ -745,6 +747,7 @@ static int amd_pstate_boost_set(struct amd_cpudata *cpudata)
 
 exit_err:
 	WRITE_ONCE(cpudata->boost_supported, false);
+	WRITE_ONCE(cpudata->boost_state, false);
 	current_pstate_driver->boost_enabled = false;
 	amd_pstate_global_params.cpb_boost = false;
 	return ret;
@@ -1348,6 +1351,116 @@ static ssize_t prefcore_show(struct device *dev,
 	return sysfs_emit(buf, "%s\n", str_enabled_disabled(amd_pstate_prefcore));
 }
 
+static int amd_pstate_cpu_boost_update(struct cpufreq_policy *policy, bool on)
+{
+	struct amd_cpudata *cpudata = policy->driver_data;
+	struct cppc_perf_ctrls perf_ctrls;
+	u32 highest_perf, nominal_perf, nominal_freq, max_freq;
+	int ret;
+
+	if (!policy) {
+		pr_err("policy is null\n");
+		return -ENODATA;
+	}
+
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
+		ret = cppc_set_epp_perf(cpudata->cpu, &perf_ctrls, 1);
+		if (ret) {
+			cpufreq_cpu_release(policy);
+			pr_debug("failed to set energy perf value (%d)\n", ret);
+			return ret;
+		}
+	}
+
+	if (on)
+		policy->cpuinfo.max_freq = max_freq;
+	else
+		policy->cpuinfo.max_freq = nominal_freq * 1000;
+
+	policy->max = policy->cpuinfo.max_freq;
+
+	if (cppc_state == AMD_PSTATE_PASSIVE) {
+		ret = freq_qos_update_request(&cpudata->req[1], policy->cpuinfo.max_freq);
+		if (ret < 0)
+			pr_debug("Failed to update freq constraint: CPU%d\n", cpudata->cpu);
+	}
+
+	return ret < 0 ? ret : 0;
+}
+
+static int amd_pstate_cpu_boost(int cpu, bool state)
+{
+	int ret;
+	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
+	struct amd_cpudata *cpudata = policy->driver_data;
+
+	if (!policy) {
+		pr_err("policy is NULL\n");
+		ret = -ENODATA;
+		goto err_exit;
+	}
+
+	ret = amd_pstate_cpu_boost_update(policy, state);
+	refresh_frequency_limits(policy);
+	WRITE_ONCE(cpudata->boost_state, state);
+	policy->boost_enabled = state;
+
+err_exit:
+	cpufreq_cpu_put(policy);
+	return ret < 0 ? ret : 0;
+}
+
+static ssize_t cpb_boost_show(struct device *dev,
+			   struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%u\n", amd_pstate_global_params.cpb_boost);
+}
+
+static ssize_t cpb_boost_store(struct device *dev, struct device_attribute *b,
+			    const char *buf, size_t count)
+{
+	bool new_state;
+	ssize_t ret;
+	int cpu;
+
+	if (!amd_pstate_global_params.cpb_supported) {
+		pr_err("Boost mode is not supported by this processor or SBIOS\n");
+		return -EINVAL;
+	}
+
+	ret = kstrtobool(buf, &new_state);
+	if (ret)
+		return ret;
+
+	mutex_lock(&amd_pstate_driver_lock);
+	for_each_present_cpu(cpu) {
+		ret = amd_pstate_cpu_boost(cpu, new_state);
+		if (ret < 0) {
+			pr_warn("failed to update cpu boost for CPU%d (%zd)\n", cpu, ret);
+			goto err_exit;
+		}
+	}
+	amd_pstate_global_params.cpb_boost = !!new_state;
+
+err_exit:
+	mutex_unlock(&amd_pstate_driver_lock);
+	return ret < 0 ? ret : count;
+}
+
 cpufreq_freq_attr_ro(amd_pstate_max_freq);
 cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
 
@@ -1358,6 +1471,7 @@ cpufreq_freq_attr_rw(energy_performance_preference);
 cpufreq_freq_attr_ro(energy_performance_available_preferences);
 static DEVICE_ATTR_RW(status);
 static DEVICE_ATTR_RO(prefcore);
+static DEVICE_ATTR_RW(cpb_boost);
 
 static struct freq_attr *amd_pstate_attr[] = {
 	&amd_pstate_max_freq,
@@ -1382,6 +1496,7 @@ static struct freq_attr *amd_pstate_epp_attr[] = {
 static struct attribute *pstate_global_attributes[] = {
 	&dev_attr_status.attr,
 	&dev_attr_prefcore.attr,
+	&dev_attr_cpb_boost.attr,
 	NULL
 };
 
@@ -1420,7 +1535,7 @@ static int amd_pstate_init_boost(struct cpufreq_policy *policy)
 	if (ret)
 		return ret;
 
-	policy->boost_enabled = READ_ONCE(cpudata->boost_supported);
+	policy->boost_enabled = READ_ONCE(cpudata->boost_state);
 
 	return 0;
 }
diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
index 0b75a6267fca..9eba854ab7d3 100644
--- a/drivers/cpufreq/amd-pstate.h
+++ b/drivers/cpufreq/amd-pstate.h
@@ -99,6 +99,7 @@ struct amd_cpudata {
 	u32	policy;
 	u64	cppc_cap1_cached;
 	bool	suspended;
+	bool	boost_state;
 };
 
 /**
-- 
2.34.1


