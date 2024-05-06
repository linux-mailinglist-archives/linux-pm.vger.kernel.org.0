Return-Path: <linux-pm+bounces-7523-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A7A8BCBD5
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2024 12:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CC1C280F2A
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2024 10:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF4F142909;
	Mon,  6 May 2024 10:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="d7k52rfA"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85B01422C5;
	Mon,  6 May 2024 10:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714990832; cv=fail; b=BJCskxU0cC8+ftohRSKRVHJn28Tms2IbIikxu0YO5jHwGtjNldIy8GQvPiVB6nKRGRBbvJB/o3KdSY+1vbyWQIjRAPAxqX0/isu0vyFz/9/q7MW6q5tEXe9W8Tji/6mrVQrNkOAg8mpad2mi4SDqbKmzPtrVkyl8+Iha6VPcRWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714990832; c=relaxed/simple;
	bh=0dghC9Gb1tCE887cWqM58tpg82BP2Al8QCSx8BHQYTI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ud5Ys3mBdl9mNjSiF/8cKCkGezwrUIXdm6yBCwR92DaNxzCUKBzNjeLIwnoQygPTBCaS3s0q5ZmoBJ5e9ggoE3ecNGvaz4fOb8eC0BNiNYPg7SP1AWwu10I95GptzJMByKMDC8DOG0UUvmjcub5fXTtdDAGqb+vwfU+kNg3371c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=d7k52rfA; arc=fail smtp.client-ip=40.107.94.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ph52NehHZTz9GJdXwMgF3ajVS4hhFCcj3pzZHvwHNmjI4K3n4avRB+NgsCBN5FDZwbzBaRNiu3OdkDwSeaPwpWLWl5xmxx1oKJUjCBDbi4IdRl2Jz59npxEYOO/8WwF1Tdrm2OkhAFabc2qDQh0jYsitlTgET1fS0Ywl4Sizmb3lXmxkCNOWPbxP3AvLsCO4Eofqs6ZqOeXVKXXYQ3rs9QGEGVWZVH4I6IqxWjPqxJ7r3g+q3qLg+J7YrLlCxSMhnIqqDp4rOokv57HE/yBi14EZYYxWl5SG2d5xvscopCJCWKh9GH1q3Q323hkAYVtv5FVxVmBCw7TNX8y7sXWJsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RDFlRLzJYPYSSOp5lp8EMyLfuSjXwx6x1lCUhGk8YMk=;
 b=CRW3yA/4gwQXza/qQyFuOEgak7qOPjFX5mE3zevq9goeEY3cdwjC65KICUz1kt0pgZrTKqrrKljGZaEnEKLeREwMcKXVuPJTXhtWuMcga3LoBmy0XNmI4+VELHLAV/l1jqd2RPB7D5XeODTWRHHfghIvy18fXk1hyWHTLRB1c5pG01KS1REFi+hOhTjPNKe0sDLxbFVJ7vghpSXuKrySCxsH6uJvWwqDpw1qE/Y7izKYlIy8VNhEmA80j7aCADPg7cRZk7gsoWgDt1NM+/r2JsKxys6ry86u9hohCSa1khk2Mnjvpn5cN8HQx7Cw9y3GptVB3CzAwy8M7u+2cgq9aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDFlRLzJYPYSSOp5lp8EMyLfuSjXwx6x1lCUhGk8YMk=;
 b=d7k52rfA6GyGCGg09pe9vh1nowWqkJxb/1OFC/MvpQQgT6+trCil/8L/KOkIBF5UL1BDUU5K20NnsN5obyZqOwVjm9VFFEC7DGWuTP0ICbdyrgAkvGvTDOPpTg5eBW4hyvn7qFRkVF7h11MGJqLVBbW3mr2udOz8WzATxUNNkck=
Received: from BN8PR12CA0010.namprd12.prod.outlook.com (2603:10b6:408:60::23)
 by DM4PR12MB8473.namprd12.prod.outlook.com (2603:10b6:8:183::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 10:20:27 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com
 (2603:10b6:408:60:cafe::ad) by BN8PR12CA0010.outlook.office365.com
 (2603:10b6:408:60::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42 via Frontend
 Transport; Mon, 6 May 2024 10:20:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B073.mail.protection.outlook.com (10.167.243.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 6 May 2024 10:20:27 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 6 May 2024 05:20:18 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<Borislav.Petkov@amd.com>, <gautham.shenoy@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Perry.Yuan@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v9 2/7] cpufreq: amd-pstate: initialize new core precision boost state
Date: Mon, 6 May 2024 18:19:54 +0800
Message-ID: <a72a1677b9774e0da4befef071617dcad54ecc4a.1714989803.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1714989803.git.perry.yuan@amd.com>
References: <cover.1714989803.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|DM4PR12MB8473:EE_
X-MS-Office365-Filtering-Correlation-Id: ba7d4ae1-a152-4737-d2a5-08dc6db6266f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|36860700004|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sq20MlJVpCWjIP+MaRciceRc+TYkcUV4PjAgQ+AmmuW0OEiMNPQVHSnTnDI3?=
 =?us-ascii?Q?v8nO432K1uYbMLAe5k/s9+QxcnNEUsZIL6Gq09PbyzdgF1ISY4Q3ZP7liFDb?=
 =?us-ascii?Q?5R4cWIzYikDYHf/4sSNLDlFb/Skw43kZ0q/9w0kVxZgmTn6sUv3oIdIrXD9z?=
 =?us-ascii?Q?YJhJUwlOZMOMw85WapUBm/lzZYP+RkEelUQQcFpYupgn23261U5+ST8YoQE4?=
 =?us-ascii?Q?/1PWNKi2To51PBNuqeIYjlWKajy57XiQ+BVoCJeHVW8HXKQiuYnIDpQIZKRu?=
 =?us-ascii?Q?x8D+0p/aPB/JkuBp+IbUDLdK2Wyq7HisHb+/qiSgjcgbNgscyp2Gfi2vnsne?=
 =?us-ascii?Q?L8QXloMliCAFnlaRuljE8zisnIsDNKBkj2tt54QsHB4aOn69XrKp1gXkxwou?=
 =?us-ascii?Q?Gwrj1aahFbGVBJkd5d78L51k4ID/m4cHCmKSBWhc/zYdCCPEfVrInr8FK+Wi?=
 =?us-ascii?Q?mXQglc4TVhSbOjbrw5Anuz1b3A7uhYNxHtW6ka6tPs+olcfIp+zbeNhRH5HT?=
 =?us-ascii?Q?FSverQ6iBTOLrdK5Hz39e7WwEupTr87EpSCgibG0PdVzMqG0SNYSZhs8ooAA?=
 =?us-ascii?Q?pSZjn+ten3DcLpBjkn3UqVlXZYvKPYvI/49ABV5IbYGlkLzVqTkAZ2QmpJkL?=
 =?us-ascii?Q?BpnOSLHmvggkmXs0cBFNxGrKmc0J0US7SuVwy36ZpUI7YzFbtwmDkOKvWOT4?=
 =?us-ascii?Q?o8L93qepzw8VhFOO6ikoiCIRZAWtM/drgWf2uO+X/4V4XoeHlxuyXoWmDTOU?=
 =?us-ascii?Q?W3HC7Me+F7JyVtjZ6JcyRaoZ7cANNCEqKuLbYbnVa9ds6gCoy9CfQQmfBrUC?=
 =?us-ascii?Q?5FMYrYgDKu81yQh7H9maFdxgtC+4k6Y8MgosBkszQidxtlBy1r2g0Jg0S2Cv?=
 =?us-ascii?Q?EWC/Y0NSVMlk0BJR0n6v+X41u8pKNsVqbyC0c+Y1oVaTs9qhZySTuHqvMPM9?=
 =?us-ascii?Q?cHdc3eCvpcOQrG4ZQLCLxdjrbyyg0JaBPkZUMuCIlmRtxamCNuMxq+vyCvqX?=
 =?us-ascii?Q?16otbMDYDkRDF4AlfmIo5M/lp0FKhliL0+cbwEb4R/U5lnnfWGOJB/boLT2t?=
 =?us-ascii?Q?Ggv8tuVOo7qZgRcecd5VwzuRc0i7BSETRwswz5zvodULfzZXIW4jNiYruyaT?=
 =?us-ascii?Q?WYKsHBQz+5q5D7w2tm5C4oRxl19geGta/ce0Cm+ko23xhJnZCAPsYYS8x7F/?=
 =?us-ascii?Q?10T0VR2nfjJK/t+TdO38tE9cRsb9IPz8/n+AHTXtvkYgcm0dPfW/XZqS3ovK?=
 =?us-ascii?Q?Zw7djGDHq2Zto8vegcdoauUoDWw9PuqihcANwRA15SAcd1l8mdc0uKUYf3N3?=
 =?us-ascii?Q?i8Fm0qWjG2sHWb+DBf8QGMUw?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(36860700004)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 10:20:27.5637
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba7d4ae1-a152-4737-d2a5-08dc6db6266f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8473

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
 drivers/cpufreq/amd-pstate.c | 45 +++++++++++++++++++++++++++---------
 include/linux/amd-pstate.h   | 13 +++++++++++
 2 files changed, 47 insertions(+), 11 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 2db095867d03..f7dab0f7b452 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -68,6 +68,8 @@ static int cppc_state = AMD_PSTATE_UNDEFINED;
 static bool cppc_enabled;
 static bool amd_pstate_prefcore = true;
 static struct quirk_entry *quirks;
+struct amd_pstate_global_params amd_pstate_global_params;
+EXPORT_SYMBOL_GPL(amd_pstate_global_params);
 
 /*
  * AMD Energy Preference Performance (EPP)
@@ -647,7 +649,7 @@ static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
 
 	if (!cpudata->boost_supported) {
 		pr_err("Boost mode is not supported by this processor or SBIOS\n");
-		return -EINVAL;
+		return -ENOTSUPP;
 	}
 
 	if (state)
@@ -665,18 +667,31 @@ static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
 	return 0;
 }
 
-static void amd_pstate_boost_init(struct amd_cpudata *cpudata)
+static int amd_pstate_boost_init(struct amd_cpudata *cpudata)
 {
-	u32 highest_perf, nominal_perf;
+	u64 boost_val;
+	int ret;
 
-	highest_perf = READ_ONCE(cpudata->highest_perf);
-	nominal_perf = READ_ONCE(cpudata->nominal_perf);
+	if (!cpu_feature_enabled(X86_FEATURE_CPB)) {
+		cpudata->boost_supported = false;
+		current_pstate_driver->boost_enabled = false;
+		pr_debug_once("Boost CPB capabilities not present in the processor\n");
+		return -ENOTSUPP;
+	}
 
-	if (highest_perf <= nominal_perf)
-		return;
+	ret = rdmsrl_on_cpu(cpudata->cpu, MSR_K7_HWCR, &boost_val);
+	if (ret) {
+		pr_err_once("failed to read initial CPU boost state!\n");
+		return ret;
+	}
 
-	cpudata->boost_supported = true;
-	current_pstate_driver->boost_enabled = true;
+	amd_pstate_global_params.cpb_supported = !(boost_val & MSR_K7_HWCR_CPB_DIS);
+	if (amd_pstate_global_params.cpb_supported)
+		current_pstate_driver->boost_enabled = true;
+
+	amd_pstate_global_params.cpb_boost = amd_pstate_global_params.cpb_supported;
+
+	return ret;
 }
 
 static void amd_perf_ctl_reset(unsigned int cpu)
@@ -899,6 +914,11 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 
 	amd_pstate_init_prefcore(cpudata);
 
+	/* initialize cpu cores boot state */
+	ret = amd_pstate_boost_init(cpudata);
+	if (ret)
+		goto free_cpudata1;
+
 	ret = amd_pstate_init_perf(cpudata);
 	if (ret)
 		goto free_cpudata1;
@@ -954,7 +974,6 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 
 	policy->driver_data = cpudata;
 
-	amd_pstate_boost_init(cpudata);
 	if (!current_pstate_driver->adjust_perf)
 		current_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
 
@@ -1361,6 +1380,11 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 
 	amd_pstate_init_prefcore(cpudata);
 
+	/* initialize cpu cores boot state */
+	ret = amd_pstate_boost_init(cpudata);
+	if (ret)
+		goto free_cpudata1;
+
 	ret = amd_pstate_init_perf(cpudata);
 	if (ret)
 		goto free_cpudata1;
@@ -1414,7 +1438,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 			return ret;
 		WRITE_ONCE(cpudata->cppc_cap1_cached, value);
 	}
-	amd_pstate_boost_init(cpudata);
 
 	return 0;
 
diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
index d58fc022ec46..8ba5dd4d3405 100644
--- a/include/linux/amd-pstate.h
+++ b/include/linux/amd-pstate.h
@@ -134,4 +134,17 @@ struct quirk_entry {
 	u32 lowest_freq;
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


