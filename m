Return-Path: <linux-pm+bounces-9552-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B1490E6AD
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 11:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE9501C2177C
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 09:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668A780C0A;
	Wed, 19 Jun 2024 09:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="H/jAsgVA"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764D08062D;
	Wed, 19 Jun 2024 09:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718788637; cv=fail; b=POb45QZ8nUvatKXtkF9IrGu+ZQCjBxpg0QgEGkMf19ArNVvYSepYbzDNjH5f0jOXWvaQxJFBPvphfrFq+oAb0YkXIg4JQesDHx+H5C63sSEgXN39EnGgA4nUmaMA6ZKrXrpwOUG51jyNyilZXVmtKZhKGgkDVu0OnS4ihw1bMPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718788637; c=relaxed/simple;
	bh=PIN577TCP+41fE6AUyqvLdiVhAr7rJS3KFs6SkWosS4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kPhMpToXWQ0Dtwtq0uEipVFfDwWZu/rf1qfhYP5TolggyBlEhJScZWgdZSUHXEOejEZ7IKXeApOmveHU1NAO6aTfQCPXJaahs09e8fhxYBnRN4qs5PP8Q51ARRkw586kAa0Tpj4SCYF4VSU2IplsG0NOHzk7xzctQA+xZF4X3p4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=H/jAsgVA; arc=fail smtp.client-ip=40.107.244.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/LvK7xuDmQ6egPfs7lHsSLH3LecHgF6ykcYv0tjfthCk7XmqjwGC+b6JFRovV9YbPWzugG6mbCvHJWsINuXwqqOdh0jBUall6Vm7a8RD28X6II9dKlIj3fk11wNfqAQWhPvvMBYzNmL9KjHaZLTzt2nuxm72k2mFhxWedZp3aIeS9Ofdy+p7xoqaAAjzupGXEwRkYyAqHPM+8U1fsXw3SOm2vpY88trPZVJGdPP5RwH2pg+x5XasaeQqJbuXpIHd9IAzZ/sdrje5uNiVdc2cpfI1yASu3wOQYogdFANStYmel80gv/0QBwrJjSAbDMIyEwLhM+zB5uD8mD7rRK0gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pomXXX11OJXIcO2gbOda3Vrn3j19XlKOk99pIlEofUc=;
 b=DorkeaSdElEAeWMFX/5XlqiESDKO+jwwGW1Nc1E7O8DgWavF4VAJZc7VJVNkygzo0x4nUXOtz6UTE2N4DnX1rXZDaCut/gfIMMb+XL9QYGV02TthyvZfKIVX+SEQnrvHfvz8A9LWd5QpSYUIxZ4+G0lT8txDrYZhLCzZ2ceCAYp5NX/fUHZRyte2V3HVRHey3i53DrhtKALW9Ndx/NXnuB+ClC3l2c+48kBwVnkulJsuPqqD5VfFurFnEaPKm8hAcWKEwob72AMQLtQisYuWT1O1KR2Y2rmnCzbKKP0HwGtQRmKZp9DRA4rQAHNH4kD9wzv6ELbPEYcIg9aHJ1sSOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pomXXX11OJXIcO2gbOda3Vrn3j19XlKOk99pIlEofUc=;
 b=H/jAsgVApjf/f+lxfPqscXD7k1sbvda00ASh4sLzgWYgCifpUfdEKkABBrfaoBJMdHp3Gep0exl2h+LPSoy1Ivw+18f/a5gW2sWWAKf+N4uZF8KY5gVzANPYE+KftTvntsFaG5sSyfstVoKFH7hFEB0KkdKDReNFAJzTXLXWxYE=
Received: from BL0PR02CA0083.namprd02.prod.outlook.com (2603:10b6:208:51::24)
 by MN0PR12MB6320.namprd12.prod.outlook.com (2603:10b6:208:3d3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Wed, 19 Jun
 2024 09:17:12 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:51:cafe::61) by BL0PR02CA0083.outlook.office365.com
 (2603:10b6:208:51::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Wed, 19 Jun 2024 09:17:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 19 Jun 2024 09:17:12 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 19 Jun 2024 04:17:09 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <gautham.shenoy@amd.com>
CC: <Xinmei.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v12 4/9] cpufreq: amd-pstate: initialize new core precision boost state
Date: Wed, 19 Jun 2024 17:16:37 +0800
Message-ID: <a9e6d487f7405e1c5b4affbd5ebeb4098f0e70e4.1718787627.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|MN0PR12MB6320:EE_
X-MS-Office365-Filtering-Correlation-Id: e891e51f-1d8a-4d1d-b166-08dc90409acc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|82310400023|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cX3Cxcn//xGmnOZsaUI8r5ZeRaSaC5jni36bISGz3Q8+XY084KdD6gDYe1Tb?=
 =?us-ascii?Q?IzHuTCNdIgQqIHW/3adZaj+hqrQ8cTIPot2ng2eOgJQHPrNCOkthn8Ff1WLx?=
 =?us-ascii?Q?TTCFmUQigMpxfU2vOUZ5uatXQE7oHWRcOTldpkycrSmOUDsaChYBq1Y9yge5?=
 =?us-ascii?Q?kaGZUZaXQB6CfkzMgTu7L8BJqXBGHw0ROj4qNnEABIs78GYIYQ8JEYTx3DZb?=
 =?us-ascii?Q?nQfZE7brm/D/zzSKqZiUEfeiyAdca9iS9spjCWJA/7R+l9O+iQaBhCmHO7Ja?=
 =?us-ascii?Q?xf//UoPofxvalRWTpokKZKoKbQY2CLLIM/bDc3cGY/KwLfgbk3SHRLvpGxTE?=
 =?us-ascii?Q?BmqRWiVg4DYjSCxjjEXv2OvR4d5qNPZ49JeSe0vujvirXyO1zyqqn9ijmNcs?=
 =?us-ascii?Q?Ep50CcjqG1t+h5K1axkL2Uh/Ez6eXfvC23RSYdaYsTxYlUTEkwofwkJJHn6O?=
 =?us-ascii?Q?qH7mvlGv2j94Midwt6DO5UqOXw1Z8SnFuNh+8OuwcU6tVOXRS/xWGYC90qax?=
 =?us-ascii?Q?JuTu+NgkUavZ3aWc4vOa6mVrYMS0fdNuYqb5FaRZPrCB/5hhTkEgr3Y+mygw?=
 =?us-ascii?Q?bTXcc3r+TQLrZZ2S3F4/XwvNrvdHZId+Dz8Eto7cwGu1oBe63N1pRa7de7jI?=
 =?us-ascii?Q?dcIHpgsWGaNuHTaey3/tCIllTCs+AKzqQfXQYebA8T6QnL0G+l1UmRA5gXXZ?=
 =?us-ascii?Q?vU5eWj+iPZmO0lxAjsHVYzbssnLsTqlpQccfIsFQw7IzsVu69bSwXmVw365/?=
 =?us-ascii?Q?DvH2s/jQVXiZss7BTUAaE9GhMpwu01v2Ud03CwKbBMcGguS3JmG5rwVJ1Cc6?=
 =?us-ascii?Q?k1GkNqX6hEKuxiKNcbmNRMYHNQofk22LlHQLpitS3GXmf+VOE1zbKfwvIezB?=
 =?us-ascii?Q?seX9bbcHX0Nm71gDqzTLj8Tishu8dBvcNnghFyruMaZKS63bm6tphf87z/ZG?=
 =?us-ascii?Q?AE7/Tqjuzo2osFhVqykCmZyAV8Ul82Ezel5D67I9SrDDQ67UjQ6v+b2r0ogk?=
 =?us-ascii?Q?IPF9T+6S0qMr2xa3GP7s8nIwQFZU2Q/CLH4XSpBIWoJLds4Lz2Q1lVWjiTtN?=
 =?us-ascii?Q?XnbuLoYy2pAvDA4H6JvQnxKFaIq/TEJvgrK93BESVzLW0C0cyXP1jg2VacV0?=
 =?us-ascii?Q?/OX5Rl1/EjdBmCmJP0m5M0AirdnrzjlCgmaAsSlzKT2nyAK9CKhNHTsV7HSK?=
 =?us-ascii?Q?1VAOIEKMngMYiSEMyiJrLL04JXOK+PitE6dnygUAlOBh6KfVAdkgwT62RcWs?=
 =?us-ascii?Q?n8poYSLN99dT/sBrc7MDfHfBSjO2lMTOz9J44HceiPI+gWHGeprJc+KHddND?=
 =?us-ascii?Q?WOzJXN60fpzQs74nl3om71tByKZHpykwomLmEWMPLQKLJzfLMqTmEKbCXx+Q?=
 =?us-ascii?Q?PY4luhM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(376011)(82310400023)(1800799021);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 09:17:12.8399
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e891e51f-1d8a-4d1d-b166-08dc90409acc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6320

From: Perry Yuan <Perry.Yuan@amd.com>

Add one global `global_params` to represent CPU Performance Boost(cpb)
state for cpu frequency scaling, both active and passive modes all can
support CPU cores frequency boosting control which is based on the BIOS
setting, while BIOS turn on the "Core Performance Boost", it will
allow OS control each core highest perf limitation from OS side.

The active, guided and passive modes of the amd-pstate driver can
support frequency boost control when the "Core Performance Boost"
(CPB) feature is enabled in the BIOS.  When enabled in BIOS, the user
has an option at runtime to allow/disallow the cores from operating in
the boost frequency range.

Add an amd_pstate_global_params object to record whether CPB is
enabled in BIOS, and if it has been activated by the user

Reported-by: Artem S. Tashkinov" <aros@gmx.com>
Cc: Oleksandr Natalenko <oleksandr@natalenko.name>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217931
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 59 +++++++++++++++++++++++++++++-------
 drivers/cpufreq/amd-pstate.h | 13 ++++++++
 2 files changed, 61 insertions(+), 11 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 5bdcdd3ea163..0c50b8ba16b6 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -102,6 +102,8 @@ static int cppc_state = AMD_PSTATE_UNDEFINED;
 static bool cppc_enabled;
 static bool amd_pstate_prefcore = true;
 static struct quirk_entry *quirks;
+struct amd_pstate_global_params amd_pstate_global_params;
+EXPORT_SYMBOL_GPL(amd_pstate_global_params);
 
 /*
  * AMD Energy Preference Performance (EPP)
@@ -694,7 +696,7 @@ static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
 
 	if (!cpudata->boost_supported) {
 		pr_err("Boost mode is not supported by this processor or SBIOS\n");
-		return -EINVAL;
+		return -ENOTSUPP;
 	}
 
 	if (state)
@@ -712,18 +714,38 @@ static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
 	return 0;
 }
 
-static void amd_pstate_boost_init(struct amd_cpudata *cpudata)
+static int amd_pstate_boost_set(struct amd_cpudata *cpudata)
 {
-	u32 highest_perf, nominal_perf;
+	u64 boost_val;
+	int ret = -1;
 
-	highest_perf = READ_ONCE(cpudata->highest_perf);
-	nominal_perf = READ_ONCE(cpudata->nominal_perf);
+	if (!cpu_feature_enabled(X86_FEATURE_CPB)) {
+		pr_debug_once("Boost CPB capabilities not present in the processor\n");
+		ret = -EOPNOTSUPP;
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
+		WRITE_ONCE(cpudata->boost_supported, true);
+	}
 
-	cpudata->boost_supported = true;
-	current_pstate_driver->boost_enabled = true;
+	amd_pstate_global_params.cpb_boost = amd_pstate_global_params.cpb_supported;
+	return 0;
+
+exit_err:
+	WRITE_ONCE(cpudata->boost_supported, false);
+	current_pstate_driver->boost_enabled = false;
+	amd_pstate_global_params.cpb_boost = false;
+	return ret;
 }
 
 static void amd_perf_ctl_reset(unsigned int cpu)
@@ -1005,7 +1027,6 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 
 	policy->driver_data = cpudata;
 
-	amd_pstate_boost_init(cpudata);
 	if (!current_pstate_driver->adjust_perf)
 		current_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
 
@@ -1387,6 +1408,21 @@ static bool amd_pstate_acpi_pm_profile_undefined(void)
 	return false;
 }
 
+static int amd_pstate_init_boost(struct cpufreq_policy *policy)
+{
+	struct amd_cpudata *cpudata = policy->driver_data;
+	int ret;
+
+	/* initialize cpu cores boot state */
+	ret = amd_pstate_boost_set(cpudata);
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
 	int min_freq, max_freq, nominal_freq, ret;
@@ -1465,7 +1501,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 			return ret;
 		WRITE_ONCE(cpudata->cppc_cap1_cached, value);
 	}
-	amd_pstate_boost_init(cpudata);
 
 	return 0;
 
@@ -1704,6 +1739,7 @@ static struct cpufreq_driver amd_pstate_driver = {
 	.exit		= amd_pstate_cpu_exit,
 	.suspend	= amd_pstate_cpu_suspend,
 	.resume		= amd_pstate_cpu_resume,
+	.init_boost	= amd_pstate_init_boost,
 	.set_boost	= amd_pstate_set_boost,
 	.update_limits	= amd_pstate_update_limits,
 	.name		= "amd-pstate",
@@ -1721,6 +1757,7 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
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


