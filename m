Return-Path: <linux-pm+bounces-9555-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6040290E6B9
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 11:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC9CB28420C
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 09:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D946F84E11;
	Wed, 19 Jun 2024 09:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pTTl6DXZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2066.outbound.protection.outlook.com [40.107.100.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7D5824A7;
	Wed, 19 Jun 2024 09:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718788642; cv=fail; b=ikEz3DDslL9VuDZ/+nC2e7/hxCodQ2evAcORH+0wS7Z9T3CTirhTjyD3ASANshlvu/zucn1pOu7tvUEtBeT5c5ukNkx+HoD3gAK8htBKA6LYMnp68Xw8ZLVLz2tjwOqBQ6ak6BWWE1oOS1sAO/PnV+fQuVqpA9APdM/8YPKP7os=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718788642; c=relaxed/simple;
	bh=errgSQfIQgxAVNs6BAlJ9S6AzRDgpYCzqF+766MEraA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n9rZCI3Yho8Cz0QxEcY6B8KsFfXeRoUODR4RzMep20kyQn248HmWsSh6lPXj/jCspe13f9o8132t735bManjzpL6Wgwff0GpYtHoIyZbWxe2jdcFWVv9bvPqV5YiEtsVFTDLh0OSkAKWVzMjpZDxOfw3VBhlFOAk/lZmrtAGAIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pTTl6DXZ; arc=fail smtp.client-ip=40.107.100.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e9Nz9FNXxw7s+h6VNnXmmg0kVTDvglQG4FTSNtOQr7ikLlgBNXzxXlc7FUNLb4wEEMlzSIrPA3yq3degnv2r7irt8Z/+h0zPV1USfxXidHKh3Dxb2TAkkFVwCrzH3C2ZDPfEU6e88f26YDH0TbhGEJDbidD7c3SKQPxUxSgpDNngaF3cJf0l5amvLpRqsZJN/pSF5S5e3LmWANeQMzfDyfVxRHjPwoQJQaonyRZ3mOpBHCeW11dcfpWQ2z3cBmFqIFZonS+I28RTRh2rM0I3BqS0ntxW80T+ByRgyrajNSOhVl53+kmDGZB75Qo5pv0Qu759i+Tq2dfAy7W9RZ/ziQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+MxDSB79cKD/BJ26UPwv0LhGsRpmu8gb+TJxVKixtRA=;
 b=B+JiieQ4JsU1d5QlGexnmQJhNMa8fAB2diH7uMsqbxYGEAK5M1vKsft8ROk9s5U5QI3Y1ZmjN7AtbAInf0oCdXR8E71SrqW7PknDnuLplCyZbMe4aEerwHzU3Xxa85bPx+dVq3qbiqSHtvLOse4XyxLmlYDmtJUpd3jqQ7lwEKWgpwScNg7Zbnm3RDgWswzn5vQDQnMjNJRq6P3vfERmSV/3Jw+PsIl6TiXQ8BQryhRmg7X6oVZTDSKG66vGSca1u6vo1Td6p1ZxvcYQyB2q5grWkN/6o8WD2l1JDgpQHc6UXLs1LWI6jUFi/2XE/vHmU2bgI9VjI6rXc+rkRbWN+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+MxDSB79cKD/BJ26UPwv0LhGsRpmu8gb+TJxVKixtRA=;
 b=pTTl6DXZ7oldP2j0dQCz2yLWtPclG408UT082KiqISiycfJqqRprufSkG7W8zl85OWiK2B4b9qerwmhSXwRi09u7E9aH3GNkXm7w1nSkrm5taX8dIRK3mKMdRGKq2EYWFmw2ygwTRtirrWo3rg3B1Vg/xjlH4LnfrTRo2Q+X7uk=
Received: from MN2PR01CA0030.prod.exchangelabs.com (2603:10b6:208:10c::43) by
 DM6PR12MB4172.namprd12.prod.outlook.com (2603:10b6:5:212::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.19; Wed, 19 Jun 2024 09:17:16 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:10c:cafe::53) by MN2PR01CA0030.outlook.office365.com
 (2603:10b6:208:10c::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25 via Frontend
 Transport; Wed, 19 Jun 2024 09:17:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 19 Jun 2024 09:17:16 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 19 Jun 2024 04:17:12 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <gautham.shenoy@amd.com>
CC: <Xinmei.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v12 5/9] cpufreq: amd-pstate: implement cpb_boost sysfs entry for boost control
Date: Wed, 19 Jun 2024 17:16:38 +0800
Message-ID: <a6d890f77889555c090db754c9a7b81e91053116.1718787627.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718787627.git.perry.yuan@amd.com>
References: <cover.1718787627.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|DM6PR12MB4172:EE_
X-MS-Office365-Filtering-Correlation-Id: b372f2a3-f396-4080-a80c-08dc90409ce4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|82310400023|376011|36860700010;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ApKCExkxrZVrsHw7xc3ckSQLAMlcjyUCs2YGOBKZb+9Hv3lVv6Ljjjlu4iM0?=
 =?us-ascii?Q?x4XmQwTxe9BnNxo1hFBrzVR1P3bzFb0fWhOm9ZHnra4aJahlSYPPCykG04Am?=
 =?us-ascii?Q?7fifVL1Klq7fvdEsh1Kbl4Aldz00+51i4G4o1FUk/wyABRulvVqfYWSI9v4r?=
 =?us-ascii?Q?PruA84Q9jsy+hyQ9UamkZ25109CVnOINDhIX5XLuWCsACfAMC54oIQL3WlQ8?=
 =?us-ascii?Q?ujeKYMSldx5qou1qJopny7cq7uSUZdzeObQXV02I9olAE028ZCHbMwLSMDA9?=
 =?us-ascii?Q?waqNo6spg/TVUK59xfbRDbgaBgM7FXpuYaqN8esS3fUPyzgmwEIJxhFZHndE?=
 =?us-ascii?Q?QQrFFfxeXJu/uwEXO+Rx9w/xcBm0HKVHYKhmH/94KhVXPuqXia8Jm4ESTU7O?=
 =?us-ascii?Q?HDKrr765ZOdYRcTMbQR6Tzpb7/0XWYA/h84ngHbA2MBiu4o+mdZPtA3to/zT?=
 =?us-ascii?Q?D7kE1OrhitHcIwCg0nU4JjvUjEulCKKLms/lF3DSIqk10EZTVAxn2mRLJ9iJ?=
 =?us-ascii?Q?PsDEJ/bofomfmB/5X0yZA5avTq1jwh5q9+h5O5ovj7F3/gLu4xQPK6X0Fkik?=
 =?us-ascii?Q?+pC7mG8CsDbTITaaB7OzxGQBc9vcJgjgU9Q0gLLK8CtNbQ4U3K/0PUC6MXiw?=
 =?us-ascii?Q?pwxoamO7sKZ8uSl8BxlIOAZi/WwUaFXjnFzbkKVMBGXkt8dF5ZEflL9opo0f?=
 =?us-ascii?Q?g4g0Knx5VRmruZfqHFF8Oc63O1Gg454hGFdFxNp0QoZPkJJyr8dJPi7fChfs?=
 =?us-ascii?Q?E23kVrSSKSJqCdEHnfEcRy0f0U4L7Jwnbupn9TF445MXGKdiKgTRH1aaWO3+?=
 =?us-ascii?Q?lE/D7oVYGcd5B8Wi2/3YXnl+nejQePJ1jcKgqKk3MMooCgS9xHnDdKgi5/qs?=
 =?us-ascii?Q?FMMCjCbt//zV9BDxwQJGFMioVwkvthFNsiARxQfAFcQ1N0R8uammxxVS+ccU?=
 =?us-ascii?Q?Qfymcvw+iCHeR0invAH682s8x8o+ghw9+XhXkxWdWQ1ofnH2qkb+y93RlLof?=
 =?us-ascii?Q?hnCVY/N/u5mvnL08TFglyUY6tTvlb0/Z7X+zsA0v9fXP6aRg+7FgG79xfSHR?=
 =?us-ascii?Q?DCrl/xGnKzLp3jJzle2bxYOJWCm2vJBPt3kNb9so0byrv0rD21H7J93Xt9iS?=
 =?us-ascii?Q?Zopj8XYzj1zYxEIdBoFIjB+9DUcRxaNxgH5YJ15KLVeVoXAaUiWUwlvE/A50?=
 =?us-ascii?Q?lhiWXsg1LkR/eBaS92OLZEqjyTckWuJRigv55JNU0E2tqN6LTn8NZXSXtON5?=
 =?us-ascii?Q?GDIrQf9Ff0TJazsMJEFqLXdhgRlh5VL+QseoAMlXbWmHByEEai0D4WdTjnwQ?=
 =?us-ascii?Q?aBukcf9tFbSrzpHDtj8jF4wcN3hSkdtdX3NC7x+0SreX4VGpqQOktSCvEnQW?=
 =?us-ascii?Q?hJHWWSw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(1800799021)(82310400023)(376011)(36860700010);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 09:17:16.3524
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b372f2a3-f396-4080-a80c-08dc90409ce4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4172

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
 drivers/cpufreq/amd-pstate.c    | 112 +++++++++++++++++++++++++++++++-
 drivers/cpufreq/amd-pstate.h    |   1 +
 3 files changed, 113 insertions(+), 2 deletions(-)

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
index 0c50b8ba16b6..1c2320808ae1 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -104,6 +104,7 @@ static bool amd_pstate_prefcore = true;
 static struct quirk_entry *quirks;
 struct amd_pstate_global_params amd_pstate_global_params;
 EXPORT_SYMBOL_GPL(amd_pstate_global_params);
+static int amd_pstate_cpu_boost(int cpu, bool state);
 
 /*
  * AMD Energy Preference Performance (EPP)
@@ -736,6 +737,7 @@ static int amd_pstate_boost_set(struct amd_cpudata *cpudata)
 	if (amd_pstate_global_params.cpb_supported) {
 		current_pstate_driver->boost_enabled = true;
 		WRITE_ONCE(cpudata->boost_supported, true);
+		WRITE_ONCE(cpudata->boost_state, true);
 	}
 
 	amd_pstate_global_params.cpb_boost = amd_pstate_global_params.cpb_supported;
@@ -743,6 +745,7 @@ static int amd_pstate_boost_set(struct amd_cpudata *cpudata)
 
 exit_err:
 	WRITE_ONCE(cpudata->boost_supported, false);
+	WRITE_ONCE(cpudata->boost_state, false);
 	current_pstate_driver->boost_enabled = false;
 	amd_pstate_global_params.cpb_boost = false;
 	return ret;
@@ -1346,6 +1349,111 @@ static ssize_t prefcore_show(struct device *dev,
 	return sysfs_emit(buf, "%s\n", str_enabled_disabled(amd_pstate_prefcore));
 }
 
+static int amd_pstate_cpu_boost_update(struct cpufreq_policy *policy, bool on)
+{
+	struct amd_cpudata *cpudata = policy->driver_data;
+	struct cppc_perf_ctrls perf_ctrls;
+	u32 highest_perf, nominal_perf, nominal_freq, max_freq;
+	int ret;
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
 
@@ -1356,6 +1464,7 @@ cpufreq_freq_attr_rw(energy_performance_preference);
 cpufreq_freq_attr_ro(energy_performance_available_preferences);
 static DEVICE_ATTR_RW(status);
 static DEVICE_ATTR_RO(prefcore);
+static DEVICE_ATTR_RW(cpb_boost);
 
 static struct freq_attr *amd_pstate_attr[] = {
 	&amd_pstate_max_freq,
@@ -1380,6 +1489,7 @@ static struct freq_attr *amd_pstate_epp_attr[] = {
 static struct attribute *pstate_global_attributes[] = {
 	&dev_attr_status.attr,
 	&dev_attr_prefcore.attr,
+	&dev_attr_cpb_boost.attr,
 	NULL
 };
 
@@ -1418,7 +1528,7 @@ static int amd_pstate_init_boost(struct cpufreq_policy *policy)
 	if (ret)
 		return ret;
 
-	policy->boost_enabled = READ_ONCE(cpudata->boost_supported);
+	policy->boost_enabled = READ_ONCE(cpudata->boost_state);
 
 	return 0;
 }
diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
index 133042370a8f..fb240a870289 100644
--- a/drivers/cpufreq/amd-pstate.h
+++ b/drivers/cpufreq/amd-pstate.h
@@ -100,6 +100,7 @@ struct amd_cpudata {
 	u64	cppc_cap1_cached;
 	bool	suspended;
 	s16	epp_default;
+	bool	boost_state;
 };
 
 /**
-- 
2.34.1


