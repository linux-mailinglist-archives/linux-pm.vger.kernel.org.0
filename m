Return-Path: <linux-pm+bounces-9724-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 458C3911A42
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 07:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C540B1F21C76
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 05:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6469712CDA5;
	Fri, 21 Jun 2024 05:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2hoSTSfr"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2077.outbound.protection.outlook.com [40.107.96.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91232A8FE;
	Fri, 21 Jun 2024 05:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718947440; cv=fail; b=KYZuB6TyPTDZdU0a+/CHlbMXe2DIvVsx6Pk7hh7V4cPfCuwRq7n1XCXNFvzvcv2TPReB+Rc8v+e4wM3FtVOD/dJCCgQiAofuuJM0x7eZ/LwA6Qf/QAydDMm36Z9AvXfEkmAi1KGhTFb4DXuFQnPqM2UdTJlommXthHuoaVfN5yY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718947440; c=relaxed/simple;
	bh=Gare+KWvA+1dqcEVQu+ipsUETkQhKbh7tMTp4u8B13c=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hI509/q1YM+CdmTAk5OjviE/xn/5fxWz6qcirm8imTwlbMkot7WzHfHVIQ0CSlzbf8ndyKuocWJ9ptd8HpwphB1KHdBIOQc8K8H7AEzvK5r9Or5przwlEw5DX9eEKop4jH6+8OuUYoK4nv1vPuC/VSOrdjho1sCCE3ZmCzsSwfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2hoSTSfr; arc=fail smtp.client-ip=40.107.96.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mV57d2PoZIB0qhGxvXTvBX6alH3rGzEHjleKT/c0Qoy50Sr1oEUQmjsyL2QAnWcoPanPNovBl1AlMYnyV19ok/wDPJvQ9GcapoO0zuTzgWesKOsTpgtHqjSfjP2vSm2wFddEogSNo3qbq2XWGgCdpXok54HwG+H6xVoh4NvgBEGhg9U/y25UMLp/x0IvZRJGY/XlSB3CHBSjWReZ29m0MlO7iRzsQcuLl0TNVHbYMu7/e9R6lPfqHPI1ryZdEsOG3EY1llXHhexiAP/2NlXAf/1rdTtz3cuaHK3EYIeYj7uMhKNenzxmZ1XA0wbHCf0Y+bJhXC1YpUx1hyUNs7JLBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4cG0dwXOAVmIvN+zqw56/ukaaRHkUW/q9G4cAlFmnxA=;
 b=AieOdBXxci9oUlSneyEJOThnxqy/SAwKyQiC+C/acphvDtlXAPS7ALBvJtQ1gNsZOoMOgJL2MRprMaBuRRuiPzsjo7Od6Cg7BlYNSgY5PTDQwUhBr+gf5hNdozvyGIKece71GKEgoDVPe7rlvMjqz8S1KH8nGJZHW3iuy/0p2FGqFMm4DbnCmm4H67w/VVrg5LY12AdH3HOBOM0DkVPfk9Ut4lyJvI42cgT+8opZbrS20AdZ8671BJfQj/SuGbTD6ei9MZ9vFIBULzFBM/JyFG2tQfdcwrb/2FOEl97/3X4PkQsK8FBQz/7a7zcr1WiwT/x2ZcVpkw9uJYKoaN8dyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4cG0dwXOAVmIvN+zqw56/ukaaRHkUW/q9G4cAlFmnxA=;
 b=2hoSTSfrqvDiWvTFzrPDIPfRLtK9jE4RHpf2t7Yks/7FBHE5YXaGwXLziunlg3aTcTrSFZIWkX0Ka7B/LCJhEKdnux/4sggSRJ7AhuwDw1T9HMndhIXJxeDgqk2HeUDqi1xkznm4b7JLxr6Gm5SZWdqrEtRqHDUHlsu0TKXnK60=
Received: from MW4PR02CA0028.namprd02.prod.outlook.com (2603:10b6:303:16d::7)
 by SJ2PR12MB8133.namprd12.prod.outlook.com (2603:10b6:a03:4af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Fri, 21 Jun
 2024 05:23:55 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:303:16d:cafe::f8) by MW4PR02CA0028.outlook.office365.com
 (2603:10b6:303:16d::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Fri, 21 Jun 2024 05:23:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 21 Jun 2024 05:23:55 +0000
Received: from BLRRASHENOY1 (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Jun
 2024 00:23:51 -0500
From: Gautham R.Shenoy <gautham.shenoy@amd.com>
To: Perry Yuan <perry.yuan@amd.com>, <rafael.j.wysocki@intel.com>,
	<Mario.Limonciello@amd.com>, <viresh.kumar@linaro.org>
CC: <Xinmei.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v12 4/9] cpufreq: amd-pstate: initialize new core
 precision boost state
In-Reply-To: <a9e6d487f7405e1c5b4affbd5ebeb4098f0e70e4.1718787627.git.perry.yuan@amd.com>
References: <cover.1718787627.git.perry.yuan@amd.com>
 <a9e6d487f7405e1c5b4affbd5ebeb4098f0e70e4.1718787627.git.perry.yuan@amd.com>
Date: Fri, 21 Jun 2024 10:53:49 +0530
Message-ID: <87tthmvpga.fsf@BLR-5CG11610CF.amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|SJ2PR12MB8133:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cb7d46d-bd94-40f6-02b5-08dc91b258aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|1800799021|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ftzg8KDNzv2F/Az09x47cfSh5dSt5nMWNoYeRy0arb8sjihGG9Fhn3LVA3u5?=
 =?us-ascii?Q?YssYl5bLWYrLkog/1pV7XhUKC3Q5kxU+1JTeCFVDGvXOMnm+tGxxlcFyijgt?=
 =?us-ascii?Q?rQ7Jz0inMZNszZiwLMKBG9CztSSqpmt7ghjSLwUFqywGqLf84et8x1VmpA24?=
 =?us-ascii?Q?7fMq/qs1M9ce6AjLw2d5NMbe+qTSdcrHW4xTXXESF/Kj73tgPJf0muTSFYLc?=
 =?us-ascii?Q?AXSqz7yTmCt39tdeqGcYX89OMp4x7r/yqRWW/VqDJv7kFVq0B1umhOafBjq3?=
 =?us-ascii?Q?Sy8rlCY7xIE8haruf4l3womYx4GXGGTdBj/8QgKfw5TsIfvdWdD0S/xtYLO2?=
 =?us-ascii?Q?f9cxrpAtggk3nnJziVKX/d32bhOKk9n0dTlB8O4pysA84FyYSuATxwDfvId5?=
 =?us-ascii?Q?UrHne5yES7KrQZbLmx0VmHLkk6Vp4IlZ3rEb92Qx8YNH8izf5RlE/PYrQ5u7?=
 =?us-ascii?Q?KhjkHhIYc0fcLJyFkeLk3xHkSR/sv4d0XIX+2fBBgS/ypRla233bAY69XCy6?=
 =?us-ascii?Q?T95hkFIPrrNkwVmUNOy2DB8UDDh7SA4MynNj3UFGwxarHQjlJ5MRfV6y1422?=
 =?us-ascii?Q?USNSO9Ccf7XMftDZ1D5JxA7Iw3K4CpQYfBnOHIhu9zhq72ZIt7Z6EKkLHja0?=
 =?us-ascii?Q?hoTOL6uQkwW04wPdIGL6ZIuSd/cuuQrWj5vnYJ/woCTJpA/eA+UdODwc6y3L?=
 =?us-ascii?Q?sXK1aipu2FBdAPxPXxYRx0qE+TEXQvsDm+KwH31ONcefckaX8Y+WOVzHhAuV?=
 =?us-ascii?Q?GcsD0wKnQ4TI/GVoPyqo3jz26ZBh6/fYBQCqVJrn+HUJdWKKCb0e2ZMSK1fC?=
 =?us-ascii?Q?ljjhzSm46jaGGZGpOMt1urzqU0OKuqfpBi4I0w4edri6YhlUTGG/DSslyXPg?=
 =?us-ascii?Q?uohHpMdNM1+1ajKZv/jP3g4fVuW4owhFTygpos9/QtfmrHr8AiWKZPji9jg3?=
 =?us-ascii?Q?0y5fuIe3i+QbdW15V2tuxJa5Lr/9fKEc0tcdFIa1dX5lcu17rW4+dhQBQdR0?=
 =?us-ascii?Q?ZkDZVFeR//ek+59aWLI+QkJnzNCxZKMD7aZDiFhVnduuMso+sqXAEq36txih?=
 =?us-ascii?Q?ovCF9TuRtyE0tKavcMwy3PVcibHlmA9DpQuIYvvRErhC2HSTmLGopebUHWuf?=
 =?us-ascii?Q?0lqh12X3WhwZCfjDq9PtTIZClX7GJPFCiTDnzmdLj1kgLLJKhx9RED6qYjeJ?=
 =?us-ascii?Q?yOv/GKbwnplx3Mcd+Gu4YwhtKDB6QjwYuBzKeVU/IMhHHhcySpmFIHgja4Je?=
 =?us-ascii?Q?/YjeHTDYI3GNvFc9WQeApGJLTjY+cv0nF/Xxajb5KzeT+1lYWDuDA+8yrJj4?=
 =?us-ascii?Q?P+d7OK1FSGZfVMUGpK3eMwTDHWco5J3mykZMitwajCCWmd6EKUewuXqq9WXC?=
 =?us-ascii?Q?Ua5ZdTI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(376011)(1800799021)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 05:23:55.5010
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cb7d46d-bd94-40f6-02b5-08dc91b258aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8133

Perry Yuan <perry.yuan@amd.com> writes:

> From: Perry Yuan <Perry.Yuan@amd.com>
>
> Add one global `global_params` to represent CPU Performance Boost(cpb)
> state for cpu frequency scaling, both active and passive modes all can
> support CPU cores frequency boosting control which is based on the BIOS
> setting, while BIOS turn on the "Core Performance Boost", it will
> allow OS control each core highest perf limitation from OS side.
>
> The active, guided and passive modes of the amd-pstate driver can
> support frequency boost control when the "Core Performance Boost"
> (CPB) feature is enabled in the BIOS.  When enabled in BIOS, the user
> has an option at runtime to allow/disallow the cores from operating in
> the boost frequency range.
>
> Add an amd_pstate_global_params object to record whether CPB is
> enabled in BIOS, and if it has been activated by the user


Can we rephrase this as :

"The "Core Performance Boost (CPB) feature, when enabled in the BIOS,
allows the OS to control the highest performance for each individual
core. The active, passive and the guided modes of the amd-pstate driver
do support controlling the core frequency boost when this BIOS feature
is enabled. Additionally, the amd-pstate driver provides a sysfs
interface allowing the user to activate/deactive this core performance
boost featur at runtime.

Add an amd_pstate_global_params object to record whether CPB is enabled
in the BIOS, and if it has been activated by the user."


>
> Reported-by: Artem S. Tashkinov" <aros@gmx.com>
> Cc: Oleksandr Natalenko <oleksandr@natalenko.name>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217931
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 59 +++++++++++++++++++++++++++++-------
>  drivers/cpufreq/amd-pstate.h | 13 ++++++++
>  2 files changed, 61 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 5bdcdd3ea163..0c50b8ba16b6 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -102,6 +102,8 @@ static int cppc_state = AMD_PSTATE_UNDEFINED;
>  static bool cppc_enabled;
>  static bool amd_pstate_prefcore = true;
>  static struct quirk_entry *quirks;
> +struct amd_pstate_global_params amd_pstate_global_params;
> +EXPORT_SYMBOL_GPL(amd_pstate_global_params);
>  
>  /*
>   * AMD Energy Preference Performance (EPP)
> @@ -694,7 +696,7 @@ static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
>  
>  	if (!cpudata->boost_supported) {
>  		pr_err("Boost mode is not supported by this processor or SBIOS\n");
> -		return -EINVAL;
> +		return -ENOTSUPP;
>  	}
>  
>  	if (state)
> @@ -712,18 +714,38 @@ static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
>  	return 0;
>  }
>  
> -static void amd_pstate_boost_init(struct amd_cpudata *cpudata)
> +static int amd_pstate_boost_set(struct amd_cpudata *cpudata)

There is already an amd_pstate_set_boost(). The new name you are
providing is amd_pstate_boost_set(). Makes it hard to read the code.

Can we rename the existing amd_pstate_set_boost() to
amd_pstate_update_boost() and keep amd_pstate_boost_set() for this
function ?



>  {
> -	u32 highest_perf, nominal_perf;
> +	u64 boost_val;
> +	int ret = -1;
>  
> -	highest_perf = READ_ONCE(cpudata->highest_perf);
> -	nominal_perf = READ_ONCE(cpudata->nominal_perf);
> +	if (!cpu_feature_enabled(X86_FEATURE_CPB)) {
> +		pr_debug_once("Boost CPB capabilities not present in the processor\n");
> +		ret = -EOPNOTSUPP;
> +		goto exit_err;
> +	}
>  
> -	if (highest_perf <= nominal_perf)
> -		return;
> +	ret = rdmsrl_on_cpu(cpudata->cpu, MSR_K7_HWCR, &boost_val);
> +	if (ret) {
> +		pr_err_once("failed to read initial CPU boost state!\n");
> +		ret = -EIO;
> +		goto exit_err;
> +	}
> +
> +	amd_pstate_global_params.cpb_supported = !(boost_val & MSR_K7_HWCR_CPB_DIS);

"amd_pstate_global_params.cpb_supported" will always contain the
MSR_K7_HWCR[CPB_DIS] of the last CPU that calls amd_pstate_boost_set()
since the code overwrites the value each time amd_pstate_boost_set() is
called for cpudata. So would it be correct to assume the
MSR_K7_HWCR[CPB_DIS] is going to be the same for every CPU ? 

--
Thanks and Regards
gautham.

