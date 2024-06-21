Return-Path: <linux-pm+bounces-9781-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E815912BCC
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 18:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9B841F248EF
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 16:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48897171E77;
	Fri, 21 Jun 2024 16:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="B5O3zLdk"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C10D16DEA2;
	Fri, 21 Jun 2024 16:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718988696; cv=fail; b=JEmW8GbmSFMORU+lUNdXU6t9XZHWdJe1c8FZkH7eMONTKgGvLbYLE8jjBx+OT1EO3lUJH4J94zB2kaPav6UWYzVwup5pVA8fvdP2GmAa5Nl54V8NwATP/w7icYFludDF5IvOBEJl7h76d3DTSGAws0rZqeE18aLDCz1YJnhmcIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718988696; c=relaxed/simple;
	bh=NzCglbdGTbU7ySY804JLTHjW4bW7tLKrFy8ccfZ1ND4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qQMErzfIVrWrdcWE6aBHu+3jgjoOHvnP197T0rf5nIa1uNUHWhcvoYPH4uyPrLKji8HtHIpXRmNqr4SdQiDoEGNsmnKUbYGnUtwXETQS9glI6uvM/JtNcbu/gFmrtAkBbT4cRUJibC0FP+UL5JX6J29qj0Wd0HAAuASzQ2SJvrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=B5O3zLdk; arc=fail smtp.client-ip=40.107.92.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DnY6mCwTw3CetsNciICwLdoGjFmLcB+VKonXjbguqttCqk68maqPfzQBzlRUXjRS3ooedn/cZehymookxDbdiq3s/lf4mfY5FsI/gmQ2hP4oBYrR4TKVwnTIvLLbmqnuMTq9BCX39wZ/ktewFN2KYvR8ycg34KeNWMiF3XPr7sN0sRlsijqRXJXEJyWTRGcXsHBratKi0rpy25C9OZEiEzYL9xkE4w7hh3BdNXl6clUI1xzOm63H2lrrpzAtbaWQacXc0OxeYeTX7w86ulsDK9ifUeaHoodt9sU5rVF1RZcGjsZbPFE2MDUnh9Pdw/tQuEu/wPEjphQbozgiH9A+vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Te7udhJfKaN+1a2lI9KhZnB53WgS0CXp1xN1/UDB3ys=;
 b=Dr2ZuZH5fy9UTWpBl0EdH49+9tvmxyEUoAI4qjI6HFnALVWaeBdPMWgaII9b/WUqoCf9SrZhpD3fMJI/iqSS3o2qof6vEbhQtdk/OqP63AmvO3M+jbpmQp+eWMj59AblpBfwVqxZOK4nKRJukpwYrEL/TyRcryUoTzOzchlG/HNuXvVCZ1m7gmbFa9n2kkpmqJPRVNAYyUQVOVetatHv7cITJxFyMrVjnCskm9usX6pkZ08f3hYGwjCuDcvjV3ah1CX7rXQcJsQm3wPrPBlo2i2Vn9XkuUDXvnNF83qLkSPINHAMuHND7I6t3ARKYQpEuzG8xUSdEafm+pm9lgo9ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Te7udhJfKaN+1a2lI9KhZnB53WgS0CXp1xN1/UDB3ys=;
 b=B5O3zLdkeKR1/ur53OjYHmRW9Kb73Jc5mMIE5XfY3a/7CK6tvX1aYOAQgrxY0zhjM2tCPR9lrwUxEMSSuR6fZjlG6cR7zwaQ5TxJWwlrKlWrpGYLDsLUKsbzWpqs6s4ysuZE5M6xg2IjPHJ3E1jbxCctuHDhW+5hmD+uvNSEjCM=
Received: from SJ0PR03CA0262.namprd03.prod.outlook.com (2603:10b6:a03:3a0::27)
 by PH8PR12MB7206.namprd12.prod.outlook.com (2603:10b6:510:226::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Fri, 21 Jun
 2024 16:51:31 +0000
Received: from SJ5PEPF000001F6.namprd05.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::8c) by SJ0PR03CA0262.outlook.office365.com
 (2603:10b6:a03:3a0::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.37 via Frontend
 Transport; Fri, 21 Jun 2024 16:51:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F6.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 21 Jun 2024 16:51:31 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 21 Jun 2024 11:51:27 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <gautham.shenoy@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v13 4/9] cpufreq: amd-pstate: initialize new core precision boost state
Date: Sat, 22 Jun 2024 00:50:59 +0800
Message-ID: <bdfa2b1c896b054a6d6b3718ccd1bc92c8dc0a7a.1718988436.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F6:EE_|PH8PR12MB7206:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c8b2807-b595-4afa-e1a4-08dc921266d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|36860700010|82310400023|376011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iZ7pX73xtuG0SfPtgQ64fkNAYkVhEZjsfkhqdz8E2ZiCcT0kRRgJW4luGbCt?=
 =?us-ascii?Q?5uzd2CURU74zfRG+31rXW7tAlcEvnN1YgjpcSsK0f19cMPv9VbdWU3YWc7UV?=
 =?us-ascii?Q?4ZwS8JvJSM2Po/mCj7XyXlLKAMWjBxf7ZxGirx1OSNToBk0Azn1GeLKNPXIA?=
 =?us-ascii?Q?tHDNWDx/XiLwpQbBkFCnB/3Os9DBOGqJ6bgLng89MLSlfwc+ZIi9v2C6GXJe?=
 =?us-ascii?Q?zv7f9/pCT0R0/oI8CXCNydxr0Vq2kFOeP5TLowtr5HFoWELlh6ZmnlEkwZHI?=
 =?us-ascii?Q?a8wJZEbfEzys15CTrtDprI38D/AQAJSGWuQUzCudEG7cauuJGmpWt1mlbSy2?=
 =?us-ascii?Q?2oJUk/yHbqQ+CP8WJFrwR2D8qLGQ+cSmElSvuaK8LWJY9sSjUTGAfE2je9mi?=
 =?us-ascii?Q?q6zKf2DDhDl/hnPM/S58mV1TUkS/8MB4XD+1Q7vHWcM1rzKe79JyTfbd0mMW?=
 =?us-ascii?Q?NsixOQWwNcQDZhgVYzN1AH3bpz53zdAwJvTs2tiJ5DhNU5nuQ8eGopS3RfHE?=
 =?us-ascii?Q?OH6gnLiCG4+UDUuDio4dK4Cc8BTGBu6bdnVfRxg2OSVLfFubqRsSrCZibjnH?=
 =?us-ascii?Q?EMCKxEYMicbW9/+4qk3pEe9xS7POnlCjFg40HHC4JbErUsfpExkrRZZQKTlz?=
 =?us-ascii?Q?9ZmM4SOQl6g2JUkdtMtPUu2DWNXweEnLH0esKXt2aTpLSYi/M6UBcb36nWly?=
 =?us-ascii?Q?tFVCEGZiyRWc7ne2lQS+Rm+EPs7bDHZrYc/exSH8jrP3XGUiSyBingE/Jiny?=
 =?us-ascii?Q?cbISzcv5nW9NCgsgDsNeTzIJZgbx60oR7itJscjJu9MPbd1PoeC7YiJ+fsNU?=
 =?us-ascii?Q?Uvl1vvfV78G04/1uojrBA3M7Ipz9qYSN5q44oo58nHxRzyIXgy+ww4xDaykn?=
 =?us-ascii?Q?hi5H5uI2Wosp/dTD4xBHsvHGZIASLE345ZCjTiwA65ownD4wYMK3V6qSTFyA?=
 =?us-ascii?Q?u8ND75kJGPEn5+nCzcroCzNYgSpGaU6O14j9oli5vNTMlve8b6gWRej3bXYF?=
 =?us-ascii?Q?PXFvgeKW4/1rpKqVOuchrRAaG8yBMZ6N+b/TOz+GF0IWfIDyymKmfnvtIhR9?=
 =?us-ascii?Q?QsO+pq+a6I7KSJQrS8zrDsUidKIgKOB2w57HM+8mjnKjEVB/vUsxF4pW3bRN?=
 =?us-ascii?Q?yn6zKhN6wFbN3kfqasYM2rTFnNff39m2H/15WryOX/q3HGtx7UFUfwhqHa+h?=
 =?us-ascii?Q?+BjpmkOGzpboOFAdMC52L4/SPl639qxpEGTfbiCXob5K4JiWN4T4G8rZyZwW?=
 =?us-ascii?Q?7TgKOJTERJ709hXg8PpVwiscygrW8TQ/o4EaPMlKtIp6JzEIbuU95BbzsWCv?=
 =?us-ascii?Q?XgrVEGWwsCPP//DEhfDubBtoW4BlJMFWj/YuX5mccoo489WpPTdnngBsFhM9?=
 =?us-ascii?Q?PVxIpyk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(1800799021)(36860700010)(82310400023)(376011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 16:51:31.0657
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c8b2807-b595-4afa-e1a4-08dc921266d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7206

From: Perry Yuan <Perry.Yuan@amd.com>

The "Core Performance Boost (CPB) feature, when enabled in the BIOS,
allows the OS to control the highest performance for each individual
core. The active, passive and the guided modes of the amd-pstate driver
do support controlling the core frequency boost when this BIOS feature
is enabled. Additionally, the amd-pstate driver provides a sysfs
interface allowing the user to activate/deactive this core performance
boost featur at runtime.

Add an amd_pstate_global_params object to record whether CPB is enabled
in the BIOS, and if it has been activated by the user.

Reported-by: Artem S. Tashkinov" <aros@gmx.com>
Cc: Oleksandr Natalenko <oleksandr@natalenko.name>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217931
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 65 ++++++++++++++++++++++++++++++------
 drivers/cpufreq/amd-pstate.h | 13 ++++++++
 2 files changed, 67 insertions(+), 11 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index c418f2bb5ced..d3e7f9cfa5c8 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -94,6 +94,10 @@ static bool cppc_enabled;
 static bool amd_pstate_prefcore = true;
 static struct quirk_entry *quirks;
 
+/* export the amd_pstate_global_params for unit test */
+struct amd_pstate_global_params amd_pstate_global_params;
+EXPORT_SYMBOL_GPL(amd_pstate_global_params);
+
 /*
  * AMD Energy Preference Performance (EPP)
  * The EPP is used in the CCLK DPM controller to drive
@@ -686,7 +690,7 @@ static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
 
 	if (!cpudata->boost_supported) {
 		pr_err("Boost mode is not supported by this processor or SBIOS\n");
-		return -EINVAL;
+		return -ENOTSUPP;
 	}
 
 	if (state)
@@ -704,18 +708,42 @@ static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
 	return 0;
 }
 
-static void amd_pstate_boost_init(struct amd_cpudata *cpudata)
+static int amd_pstate_init_boost_support(struct amd_cpudata *cpudata)
 {
-	u32 highest_perf, nominal_perf;
+	u64 boost_val;
+	int ret = -1;
 
-	highest_perf = READ_ONCE(cpudata->highest_perf);
-	nominal_perf = READ_ONCE(cpudata->nominal_perf);
+	/*
+	 * If platform has no CPB support or disble it, initialize current driver
+	 * boost_enabled state to be false, it is not an error for cpufreq core to handle.
+	 */
+	if (!cpu_feature_enabled(X86_FEATURE_CPB)) {
+		pr_debug_once("Boost CPB capabilities not present in the processor\n");
+		ret = 0;
+		goto exit_err;
+	}
 
-	if (highest_perf <= nominal_perf)
-		return;
+	ret = rdmsrl_on_cpu(cpudata->cpu, MSR_K7_HWCR, &boost_val);
+	if (ret) {
+		pr_err_once("failed to read initial CPU boost state!\n");
+		ret = -EIO;
+		goto exit_err;
+	}
+
+	amd_pstate_global_params.cpb_supported = !(boost_val & MSR_K7_HWCR_CPB_DIS);
+	if (amd_pstate_global_params.cpb_supported) {
+		current_pstate_driver->boost_enabled = true;
+		cpudata->boost_supported = true;
+	}
+
+	amd_pstate_global_params.cpb_boost = amd_pstate_global_params.cpb_supported;
+	return 0;
 
-	cpudata->boost_supported = true;
-	current_pstate_driver->boost_enabled = true;
+exit_err:
+	cpudata->boost_supported = false;
+	current_pstate_driver->boost_enabled = false;
+	amd_pstate_global_params.cpb_boost = false;
+	return ret;
 }
 
 static void amd_perf_ctl_reset(unsigned int cpu)
@@ -1005,7 +1033,6 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 
 	policy->driver_data = cpudata;
 
-	amd_pstate_boost_init(cpudata);
 	if (!current_pstate_driver->adjust_perf)
 		current_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
 
@@ -1387,6 +1414,21 @@ static bool amd_pstate_acpi_pm_profile_undefined(void)
 	return false;
 }
 
+static int amd_pstate_init_boost(struct cpufreq_policy *policy)
+{
+	struct amd_cpudata *cpudata = policy->driver_data;
+	int ret;
+
+	/* initialize cpu cores boot state */
+	ret = amd_pstate_init_boost_support(cpudata);
+	if (ret)
+		return ret;
+
+	policy->boost_enabled = READ_ONCE(cpudata->boost_supported);
+
+	return 0;
+}
+
 static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 {
 	int min_freq, max_freq, ret;
@@ -1456,7 +1498,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 			return ret;
 		WRITE_ONCE(cpudata->cppc_cap1_cached, value);
 	}
-	amd_pstate_boost_init(cpudata);
 
 	return 0;
 
@@ -1701,6 +1742,7 @@ static struct cpufreq_driver amd_pstate_driver = {
 	.exit		= amd_pstate_cpu_exit,
 	.suspend	= amd_pstate_cpu_suspend,
 	.resume		= amd_pstate_cpu_resume,
+	.init_boost	= amd_pstate_init_boost,
 	.set_boost	= amd_pstate_set_boost,
 	.update_limits	= amd_pstate_update_limits,
 	.name		= "amd-pstate",
@@ -1718,6 +1760,7 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
 	.suspend	= amd_pstate_epp_suspend,
 	.resume		= amd_pstate_epp_resume,
 	.update_limits	= amd_pstate_update_limits,
+	.init_boost	= amd_pstate_init_boost,
 	.name		= "amd-pstate-epp",
 	.attr		= amd_pstate_epp_attr,
 };
diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
index f80b33fa5d43..133042370a8f 100644
--- a/drivers/cpufreq/amd-pstate.h
+++ b/drivers/cpufreq/amd-pstate.h
@@ -102,4 +102,17 @@ struct amd_cpudata {
 	s16	epp_default;
 };
 
+/**
+ * struct amd_pstate_global_params - Global parameters, mostly tunable via sysfs.
+ * @cpb_boost:		Whether or not to use boost CPU P-states.
+ * @cpb_supported:	Whether or not CPU boost P-states are available
+ *			based on the MSR_K7_HWCR bit[25] state
+ */
+struct amd_pstate_global_params {
+	bool cpb_boost;
+	bool cpb_supported;
+};
+
+extern struct amd_pstate_global_params amd_pstate_global_params;
+
 #endif /* _LINUX_AMD_PSTATE_H */
-- 
2.34.1


