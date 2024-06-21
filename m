Return-Path: <linux-pm+bounces-9782-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55366912BCF
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 18:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3ADF1F2549A
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 16:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C09717334B;
	Fri, 21 Jun 2024 16:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lbsMPAo0"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9678D172BDD;
	Fri, 21 Jun 2024 16:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718988699; cv=fail; b=smrP1bgFjEN9X49XaSysKfud/zXgPCZ1BCEDdqq8WRCys89v5cL91BAMShKJUA2VYJxQDCs6npAfmvP3dkwdVG48KEko2BWjMIvnhgkJ/emEAJn3Bml748YFRYDy1GQysO59F2NRf2SpfUS+nZKVcbhffrYScmG6Ph16sr6wkdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718988699; c=relaxed/simple;
	bh=b4YvyB5U2ifL/jf+cXL/h1xFxLzyhZVZZ0JR9bYCFw8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PxTIPZJMeVLEUux8+ood2sxlpvp3BbywVtVYoxIZ2W7JoUWiYOV/DsIqb1GvUvMPDQXQ4s4vX9xPaUkOhTmcrpAJa+FP9AJBMSARzYiJl5yiGjJNylZxsLF4hnElKlYe3PPxL7aTvc3r/dSnKHwdQHwfQvU4NNzz97NZaXUUK0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lbsMPAo0; arc=fail smtp.client-ip=40.107.237.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gWmTfVUq0EUKdmjXwWK789PPNAnSZH0cSIDTpbvxKivyZi7U68UJ/74zOqF5Xe1o4hgR1zQuE/9sSW8e0d7wJrr7d/I1dund0eCdqoYR1C+Sw5JcyQgxHE3+Nom+7At+LPs+zk5csn09iL6NCdahuBTavzZHaHuDa/ge+8VIw8ef6zDoLsZgbTqe9KBe4ScfLJQv4XVDsmOkh7auxsNQqTyzPb/YKGQnQPnMn5I47ci72EjCww+NWD7ls4QiGZxQ4DyFZ2uNK4La8WXnotPeeGtxr7pxT9y6PnVjc3yqmFoZePUTRlxBY1nbKMxpig/evD1RQ/FJj5aYvVPjQApmcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TiWftcHYi6AJT6z+rfIJDltwWR5mmUSojG7fJAnbZHs=;
 b=BhF1sa45NGb7aP+0CSjQBRdsBT+5iK+RxymM1uIGSyOA8thsPyuxAXX7GUhyK3SKgzNTcZLSgHj41Z4UuDxXpRKkA0ghaMk7RV4u2hbkhOPLgYSsytOjF+7z0OsDt+5jAcnf2lBf9MQmtPImYupTdqmUd22v4N4hGyEUKuwyd+6K1vrJPfSkDXG4y7qD8XQZ1njdXtRzIeEBM2Wo9u4JVgDIm7ct1/jwXglwZixCJVNDBRW9Rgx5Ht7MfFmfZhIm0JtC/uoYtE7e0PGkoM504q1xRp2MLPZfJ99DeBUfF//lL9XioCwljlUHsUzvtbI1S2EBDo216nrWxt1bYIMSkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TiWftcHYi6AJT6z+rfIJDltwWR5mmUSojG7fJAnbZHs=;
 b=lbsMPAo0cM8tiiGF+B4qR4rzph8O65syYJWhbxKEDEm1lCQl5ymV+BNBqa/mlntjAOZgt6HYRMfqIhN6hWl8jEFgPGaj+AVRn2qWgMzkYp69SBoPlX0WKBc925H+y0me1N99FWr6H3Uipm6CpSFknjzep0BnvDIZAhpik1aZ2QI=
Received: from SJ0PR03CA0247.namprd03.prod.outlook.com (2603:10b6:a03:3a0::12)
 by MW6PR12MB8663.namprd12.prod.outlook.com (2603:10b6:303:240::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Fri, 21 Jun
 2024 16:51:34 +0000
Received: from SJ5PEPF000001F6.namprd05.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::60) by SJ0PR03CA0247.outlook.office365.com
 (2603:10b6:a03:3a0::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.37 via Frontend
 Transport; Fri, 21 Jun 2024 16:51:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F6.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 21 Jun 2024 16:51:33 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 21 Jun 2024 11:51:30 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <gautham.shenoy@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v13 5/9] cpufreq: amd-pstate: implement cpb_boost sysfs entry for boost control
Date: Sat, 22 Jun 2024 00:51:00 +0800
Message-ID: <de7b96a323298f58a66b80709ce2040eda8c23d5.1718988436.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718988436.git.perry.yuan@amd.com>
References: <cover.1718988436.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F6:EE_|MW6PR12MB8663:EE_
X-MS-Office365-Filtering-Correlation-Id: ce25c3fe-b93c-4d3c-f3b0-08dc9212688d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|82310400023|36860700010|376011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eyRITpS9lq/aXFmSbokGNIWxKKaOxLMDWHWImzbwZmYJLykbFk6kx+mncdIk?=
 =?us-ascii?Q?xULXHnpzC8cVMlImh3j4hSDuG1w/AuhcyXWSn52JD2s58W6NjaF+JscjrL4d?=
 =?us-ascii?Q?4gBt+piqy7hT9micOSE2HRJ2WlwqA9HMUrI6v4Ykus8bwGlRGjPseedNJksB?=
 =?us-ascii?Q?92ngm1Xxw+zUaAc2JwpFCbrrKhOO/i2PX8ujD6s2CzhcPDqnfm9a0VGeyMM9?=
 =?us-ascii?Q?L3J3iFplvFt/pYww8kdGgMK59I12aEvNx9CrCUs0C9DNDXc3xzOW1egHrTmp?=
 =?us-ascii?Q?L0NRdqqLYTcm+UXloDBgZjRMTyEzrEan0q8zWAtwx+errgL2zIDow1eizIeD?=
 =?us-ascii?Q?4RdQqevK+1REIUvV5wLahOF0QX60b3JP+QYmzO3jZtNcG7m1HfundQbltCWa?=
 =?us-ascii?Q?CpxKlgA+lX5iuqltUcmpNv1sfOj/50YcWr2eIhzXudVBHV7VHv+R2G6oF/yR?=
 =?us-ascii?Q?pvIc0Na9Vt6ngUW3YR1pLbsQ71zJG51hbsrRgq3sFfKZCstSjqR1s3Bh9GtV?=
 =?us-ascii?Q?t+4YOdMzOEvk+728Wbq7CbNToOEnNgcMLgfsdunNAJgTRLT0sgZxpHjNdJXQ?=
 =?us-ascii?Q?SdD6Ins3GPX8DHyM3vqqTwFmiorio8XNxy8RaR12sub/svRkG++0le+r2BoT?=
 =?us-ascii?Q?KF31OjcVVC6sbISFWziTfZv13Pm8mgXWtNXCGhs6JdI6HTGBaGaA1s9naaoc?=
 =?us-ascii?Q?grZaE/khM74UKu64nTv9W3ASisjyRYTX9r/FqIR1NSP1VW1HhXs/9TM4gMwP?=
 =?us-ascii?Q?IIBhog0hxDmxuWUI7ZIpHPhLwtU4NP5WtxIwRLGiPn8XvT3HMWS+3/UskWHi?=
 =?us-ascii?Q?CAdjTMSR6vdw/du4KIzqbqIDejHiAEbCk40rwiT7t/HECIBMohjtOHl+pdQ+?=
 =?us-ascii?Q?xJqFg4X7GUlW4CbErUPy1n1p6KPJ9GB7/JMwn3qFGFT9RW1W6GvTE65lrhpK?=
 =?us-ascii?Q?EgBqbthoWUNA7eUjZ2pro8XlRP9IiLyZEyc4H1r6CZEajoDsw4wFjnkkgVIK?=
 =?us-ascii?Q?qbDlVkRt4PeJhIRclTbyMyE0jkQ4ps1u/vkhs0hm/aAhHiFrFQIeJq7SaZ1N?=
 =?us-ascii?Q?XR5fSEPUtoul+acXnx6QjIZj8YlJAtrz6v77QHY64KI8ocOqy0jlZsvqQ/B5?=
 =?us-ascii?Q?/VXTdaEkp0+xQBvvPbnywCV6GW2jetbzY08sNBvL9i/8ZJV0f78+sjjFHtAV?=
 =?us-ascii?Q?l4wmAjjB7yj4i/Wm2KJIbBfiZuB8YaWJPUCZ++HbU+mh7fJHH9+mIrFDTXP3?=
 =?us-ascii?Q?bDxyKszMSnQI+Tmcba3Cc7XY0oPbjFnBAn9/CVm5WUGZlKT9g1bBT9nnahzj?=
 =?us-ascii?Q?XKU1X2wb+8ULhMUp/4fQdcx5SO9ddUJjctc2cTE5n3TN+vuZK2Ii91srxfeu?=
 =?us-ascii?Q?IGrHlx8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(1800799021)(82310400023)(36860700010)(376011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 16:51:33.9561
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce25c3fe-b93c-4d3c-f3b0-08dc9212688d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8663

From: Perry Yuan <Perry.Yuan@amd.com>

With this new sysfs entry `cpb_boost` created, user can change CPU boost
state dynamically under `active`, `guided` and `passive` modes.
And the highest perf and frequency will also be updated as the boost
state changes.

Check current boost state:
$ cat /sys/devices/system/cpu/amd_pstate/cpb_boost
enabled
or
$ cat /sys/devices/system/cpu/amd_pstate/cpb_boost
disabled

Disable CPU boost
sudo bash -c "echo "disabled" > /sys/devices/system/cpu/amd_pstate/cpb_boost"

Enable CPU boost
sudo bash -c "echo "enabled" > /sys/devices/system/cpu/amd_pstate/cpb_boost"

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217931
Link: https://bugzilla.kernel.org/show_bug.cgi?id=217618
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate-ut.c |   2 +-
 drivers/cpufreq/amd-pstate.c    | 129 +++++++++++++++++++++++++++++++-
 drivers/cpufreq/amd-pstate.h    |   1 +
 3 files changed, 130 insertions(+), 2 deletions(-)

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
index d3e7f9cfa5c8..6710b3c28cda 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -97,6 +97,7 @@ static struct quirk_entry *quirks;
 /* export the amd_pstate_global_params for unit test */
 struct amd_pstate_global_params amd_pstate_global_params;
 EXPORT_SYMBOL_GPL(amd_pstate_global_params);
+static int amd_pstate_cpu_boost(int cpu, bool state);
 
 /*
  * AMD Energy Preference Performance (EPP)
@@ -139,6 +140,16 @@ static unsigned int epp_values[] = {
 	[EPP_INDEX_POWERSAVE] = AMD_CPPC_EPP_POWERSAVE,
  };
 
+enum CPB_STATE_INDEX {
+	CPB_STATE_DISABLED = 0,
+	CPB_STATE_ENABLED = 1,
+};
+
+static const char * const cpb_state[] = {
+	[CPB_STATE_DISABLED] = "disabled",
+	[CPB_STATE_ENABLED] = "enabled",
+};
+
 typedef int (*cppc_mode_transition_fn)(int);
 
 static struct quirk_entry quirk_amd_7k62 = {
@@ -734,6 +745,7 @@ static int amd_pstate_init_boost_support(struct amd_cpudata *cpudata)
 	if (amd_pstate_global_params.cpb_supported) {
 		current_pstate_driver->boost_enabled = true;
 		cpudata->boost_supported = true;
+		cpudata->boost_state = true;
 	}
 
 	amd_pstate_global_params.cpb_boost = amd_pstate_global_params.cpb_supported;
@@ -741,6 +753,7 @@ static int amd_pstate_init_boost_support(struct amd_cpudata *cpudata)
 
 exit_err:
 	cpudata->boost_supported = false;
+	cpudata->boost_state = false;
 	current_pstate_driver->boost_enabled = false;
 	amd_pstate_global_params.cpb_boost = false;
 	return ret;
@@ -1352,6 +1365,118 @@ static ssize_t prefcore_show(struct device *dev,
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
+		ret = cppc_set_perf(cpudata->cpu, &perf_ctrls);
+		if (ret) {
+			cpufreq_cpu_release(policy);
+			pr_debug("Failed to set max perf on CPU:%d. ret:%d\n",
+				cpudata->cpu, ret);
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
+	bool cpb_idx;
+
+	cpb_idx = amd_pstate_global_params.cpb_boost;
+
+	return sysfs_emit(buf, "%s\n", cpb_state[cpb_idx]);
+}
+
+static ssize_t cpb_boost_store(struct device *dev, struct device_attribute *b,
+			    const char *buf, size_t count)
+{
+	bool new_state;
+	ssize_t ret;
+	int cpu, cpb_idx;
+
+	if (!amd_pstate_global_params.cpb_supported) {
+		pr_err("Boost mode is not supported by this processor or SBIOS\n");
+		return -EINVAL;
+	}
+
+	cpb_idx = sysfs_match_string(cpb_state, buf);
+	if (cpb_idx < 0)
+		return -EINVAL;
+
+	new_state = cpb_idx;
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
 
@@ -1362,6 +1487,7 @@ cpufreq_freq_attr_rw(energy_performance_preference);
 cpufreq_freq_attr_ro(energy_performance_available_preferences);
 static DEVICE_ATTR_RW(status);
 static DEVICE_ATTR_RO(prefcore);
+static DEVICE_ATTR_RW(cpb_boost);
 
 static struct freq_attr *amd_pstate_attr[] = {
 	&amd_pstate_max_freq,
@@ -1386,6 +1512,7 @@ static struct freq_attr *amd_pstate_epp_attr[] = {
 static struct attribute *pstate_global_attributes[] = {
 	&dev_attr_status.attr,
 	&dev_attr_prefcore.attr,
+	&dev_attr_cpb_boost.attr,
 	NULL
 };
 
@@ -1424,7 +1551,7 @@ static int amd_pstate_init_boost(struct cpufreq_policy *policy)
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


