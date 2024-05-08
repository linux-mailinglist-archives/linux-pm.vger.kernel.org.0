Return-Path: <linux-pm+bounces-7630-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A69B78BF6EF
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 09:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35D6D1F2290B
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 07:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EAA23A29B;
	Wed,  8 May 2024 07:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TYI/VA4k"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2086.outbound.protection.outlook.com [40.107.101.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686C839FFD;
	Wed,  8 May 2024 07:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715152904; cv=fail; b=IJnVnl3QN3mX+SqDYYwaY+MUyImpTZiHvSmBArrjxJPEMuHMj7tT1EPGZqTG52+7lh+v14+skYrJ+JqSV5iMoMmOnGaJRVgolRgGhwgk+hlERfYT5i62gF6Z5NBjCSQ2kR2Jk0R9pKTTzneP+85Nk6fXuI2kcN2monE+UaMnRNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715152904; c=relaxed/simple;
	bh=SPtaTKhKS4kBximrAAIVyLl++Y6fmD1XuYHuKP4/3TM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gPn1mKKJSrgLG9xWe7tvHaUiFex3Ao/JghITUKMUUbV0oc8gQnp5kmDLYIGfcIOO3YTEA1pwEyP4OsDl8gd5ooGgGnUFyx2lKVDTXeRg+hXcK6R0y9QeiXKIg5mEjtL/d7HVRxN5m49Mk5v3RGRw8Qw8RX+w+4U7UbPJBjB797o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TYI/VA4k; arc=fail smtp.client-ip=40.107.101.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n+NPBdFCxkzBCNp/dR+RTJCRp8Gqxbbn0sSCXwf638NbaJ53PhRbKhC7iNtp+CWHkIe9zRhlv4CHu31s7K8ZtMsep/TppxaAcjIOhNS8T/YYcCUEoUZX9OfXPxXc8jypXQ6ddOUPgKaOPeLxjAyRAtZriF9STW/i5KpmmeP7V6mK1LNgQTdM6I1vDddWv+krfIB+Uis1peSkxEsrKCssUg0fD64f9RRVMwihE505UUcxRd/g26jU4qhVLMGiVXfrdyclKuzG7jR04GtiN924jN4CKg83tyO4TqYL2jNVXqCUOMngbIFjkF/q5bWE94iZq4kttbXrdGZv0ivkJXIuyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fwGsNws72j0bUsX8RT3yzn8iKBZDTYed2C6LZvdY94k=;
 b=S086xTW9jYFYAYc1aj9UXgDkpbZi/DX1bFWJ9l0pxnriGeSvkv26CZhDBLrlY6vd+eXtF57J4SjnRyuo/ymBqHJsGYR4xmF4l3FRlaZmITq0IbYardyZQ1++7K8Kd+In2n+UNDPykPysML+FCRxMaiwzJStvBIHpeSISbAB85FplH+9sIpu41skvBINVVD8q5JnZ2En37NWgefQVqzHSRhe5BiKuWErhHzLafq1tQ4lZw8B7ayyU4ViK1fMPXUikFBKnRMYimXCCn+77IN8i20+fTp2CV7fIH6DePjyx2liSeclYA1bAy5CqQdM21Yr24ImXQfvQV6rcsdEo6m7m1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fwGsNws72j0bUsX8RT3yzn8iKBZDTYed2C6LZvdY94k=;
 b=TYI/VA4k5vuOp9ZnpVQTGvmwcu6H5hqWAQxppWTdGQCZ8DCqtrp50srTIAOxjuhMW4HVoeuIaUBv/jdiTk/gZ4jUCt//YjykOfRuoD+4mNy9PCACCIK6Tr1PIdlFA+dMjsxL30wXBoAkbv4o59ltaiFfTPBBaSJcdqlyfhK58FQ=
Received: from MN2PR01CA0043.prod.exchangelabs.com (2603:10b6:208:23f::12) by
 DS0PR12MB6655.namprd12.prod.outlook.com (2603:10b6:8:d0::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.43; Wed, 8 May 2024 07:21:39 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:23f:cafe::6b) by MN2PR01CA0043.outlook.office365.com
 (2603:10b6:208:23f::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45 via Frontend
 Transport; Wed, 8 May 2024 07:21:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Wed, 8 May 2024 07:21:39 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 8 May 2024 02:21:35 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v10 3/7] cpufreq: amd-pstate: implement cpb_boost sysfs entry for boost control
Date: Wed, 8 May 2024 15:21:08 +0800
Message-ID: <90a2bf1607c525a1e5b42d7327dbcfe5dd338549.1715152592.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1715152592.git.perry.yuan@amd.com>
References: <cover.1715152592.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|DS0PR12MB6655:EE_
X-MS-Office365-Filtering-Correlation-Id: a7c12b3f-0719-46b8-43cb-08dc6f2f809c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|376005|36860700004|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Za0pTc+Yd8NN/0YYALM4CrjQoHVyWQXkrUEIPZqVB/ho9K7cNkcGg5EzD1t2?=
 =?us-ascii?Q?vjDUlHqzJdDDLVYwCoCnK2c8fDgzKsXuIc/ZKsS6EVmQCqzdIoQABIZE4xTh?=
 =?us-ascii?Q?1qY+9X+pQ9nkiVad487Etw4meySvh98dPD1WszQUDbvZfdbbw+lp6OHY4Nuy?=
 =?us-ascii?Q?c1BugFIso706UVy3x43QtLuwCQzo7U9k6VzgKuz36msFOTPssr2Ti8hY2dnA?=
 =?us-ascii?Q?cUHfoVf02twQXFyqObNuqsUBN/h4HQtk4iSpCjab6XBlUl6o7NGCilMFR8Ih?=
 =?us-ascii?Q?ZkHzoeVvOKLdYyATCCWWsUR4NCXma0kws0y8Pud62EOxZ02nFhXRoPnWRC4v?=
 =?us-ascii?Q?UBBMn+2Ww8NHUPgeVtkbwQicVX8GyH0Ug3syH0f9IQ4JwFcvimlX2AUO/jwf?=
 =?us-ascii?Q?w7GuO7g31s8n7+YvF5nSC/yTVR7GUsJs1zNQUIXcrV64idHFvDQ+thi5gYQl?=
 =?us-ascii?Q?RT1+bbkDx3DJHpQcqCdMCHcNUqszBPqWNZOsDVdkE4GF67d+G47taqVIjHvs?=
 =?us-ascii?Q?vjBhvo9AmegspffxJC6jf0mD4IVQ+rZ5xzGYc+EdlxX1tKfG1Hg06N8QhP1/?=
 =?us-ascii?Q?t8tQ5bxmCWctwBV5WOFYsBCbnY7+DeWWRc0FOIkKM3v8uvwu/mKqR4I3cn0S?=
 =?us-ascii?Q?HWasaoyox2OYxOz5SAiwZ1ozpcqMmxEKuOepvqCCs6MusSr18yrYH7rWYDO9?=
 =?us-ascii?Q?S8BKIMLlhG8t3WSCStMhfKj2XwYAJ12oC+Fsp7x4fc4LzWwQvLfjf8P8pGwS?=
 =?us-ascii?Q?MqMphpUTHL8s4jOD2B0k0ahpNw6/tVHZpGuDFGpalaza6ZcbJnIsEq0JBEwb?=
 =?us-ascii?Q?wVc2nNuGGUETWj3OBP+exnWnY836ylmsnuDC71l4AAaLf9lhEOSPgrxURoSa?=
 =?us-ascii?Q?q8MV1IwBL0LPnaQH26zjacHgh/EF9CAO/aCmzIVDP4YHUOjZWHol31nMXccc?=
 =?us-ascii?Q?h5O6iP7JFJ1Pcz8BOlIBKt+cc3t4RuGCuXABqUCw7NruUpFfJa2FXY5HvnjK?=
 =?us-ascii?Q?0lHOTd6ylXoW8UKmx08lLUiX1TdnR74mGdQo3oDkkebLjnqAH/97GuAHVyfa?=
 =?us-ascii?Q?w2Y+xCJGhIZgmoCWaSg1eRkWxeHAf43gPwGrsWtiUVe8yqMYYBTsXHjZj16P?=
 =?us-ascii?Q?NjAHGhgz4ZSqN5cEGrQzu4zBzOGpnS7TB+U7No9uppXcs+buGA2txzKpp5+2?=
 =?us-ascii?Q?un9Xl74Sii67aIUlTqQuBckfdFimA/WSH5XVuDK/Jleu7BUeUz/ZEP6d5h8+?=
 =?us-ascii?Q?i0vJUQg9RRfH+RBMvJQovAHR9uvOTtSnCvOIljDV9eVGzuA+2JwfNBBwPJFO?=
 =?us-ascii?Q?b78KR+atiy4ZYyV4sSndCp6y?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(376005)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 07:21:39.1325
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7c12b3f-0719-46b8-43cb-08dc6f2f809c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6655

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
 drivers/cpufreq/amd-pstate.c    | 114 +++++++++++++++++++++++++++++++-
 include/linux/amd-pstate.h      |   1 +
 3 files changed, 115 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
index f04ae67dda37..b3601b0e6dd3 100644
--- a/drivers/cpufreq/amd-pstate-ut.c
+++ b/drivers/cpufreq/amd-pstate-ut.c
@@ -226,7 +226,7 @@ static void amd_pstate_ut_check_freq(u32 index)
 			goto skip_test;
 		}
 
-		if (cpudata->boost_supported) {
+		if (amd_pstate_global_params.cpb_boost) {
 			if ((policy->max == cpudata->max_freq) ||
 					(policy->max == cpudata->nominal_freq))
 				amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_PASS;
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index f7dab0f7b452..f81fd61dd2a9 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -686,8 +686,10 @@ static int amd_pstate_boost_init(struct amd_cpudata *cpudata)
 	}
 
 	amd_pstate_global_params.cpb_supported = !(boost_val & MSR_K7_HWCR_CPB_DIS);
-	if (amd_pstate_global_params.cpb_supported)
+	if (amd_pstate_global_params.cpb_supported) {
 		current_pstate_driver->boost_enabled = true;
+		cpudata->boost_state = true;
+	}
 
 	amd_pstate_global_params.cpb_boost = amd_pstate_global_params.cpb_supported;
 
@@ -1293,6 +1295,114 @@ static ssize_t prefcore_show(struct device *dev,
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
+		ret = freq_qos_update_request(&cpudata->req[1],
+				      policy->cpuinfo.max_freq);
+	}
+
+	return ret;
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
+	cpudata->boost_state = !!state;
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
+			pr_warn("failed to update cpu boost for CPU%d (%d)\n", cpu, ret);
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
 
@@ -1303,6 +1413,7 @@ cpufreq_freq_attr_rw(energy_performance_preference);
 cpufreq_freq_attr_ro(energy_performance_available_preferences);
 static DEVICE_ATTR_RW(status);
 static DEVICE_ATTR_RO(prefcore);
+static DEVICE_ATTR_RW(cpb_boost);
 
 static struct freq_attr *amd_pstate_attr[] = {
 	&amd_pstate_max_freq,
@@ -1327,6 +1438,7 @@ static struct freq_attr *amd_pstate_epp_attr[] = {
 static struct attribute *pstate_global_attributes[] = {
 	&dev_attr_status.attr,
 	&dev_attr_prefcore.attr,
+	&dev_attr_cpb_boost.attr,
 	NULL
 };
 
diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
index 8ba5dd4d3405..56f616a5cd0f 100644
--- a/include/linux/amd-pstate.h
+++ b/include/linux/amd-pstate.h
@@ -106,6 +106,7 @@ struct amd_cpudata {
 	u32	policy;
 	u64	cppc_cap1_cached;
 	bool	suspended;
+	bool	boost_state;
 };
 
 /*
-- 
2.34.1


