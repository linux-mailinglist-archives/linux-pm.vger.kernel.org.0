Return-Path: <linux-pm+bounces-9744-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CB6911EC5
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 10:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D054D281DE9
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 08:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32841168C3F;
	Fri, 21 Jun 2024 08:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BPLsdwW1"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8840542AA9;
	Fri, 21 Jun 2024 08:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718958612; cv=fail; b=vE/qWXoCni5xZhFd5onuYBGED+iHwA0kxvJAd7dSE4M+J+WBdZ2lGHps47iC/1Ark6npgeHDtaAd60E8Ks2lsgSw6t8ZzH6ahGQ812wHqQDUB0J8VKvn+d5lCvmyE/logtPy2pgYeRGmfEIEeuHZ1iSs1EFVDQbSk99FBJh7WdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718958612; c=relaxed/simple;
	bh=dJC6c+W8/dlHCFdqaRKmBZ3I4OB7CMSub7F55LaItMI=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y2zZvSQd4BXCpWVK4X0K2eQH7GXDID6UlEWm5Olr4L0FI1+mOFN0EzB032t4qzyLSSuVPGvKyUlzh6sc6aU/XA/mNlLMs0rAUpHHoGLgsr/OufQ2eetuVjKDu/MnvEpmsz9Ek7KmOWkeHQz/bDF9oRPGQ6lfLqm5ed+6lPUFY9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BPLsdwW1; arc=fail smtp.client-ip=40.107.237.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ijQXbsi0ep/VnVDoUxS89oBtOhYUokZv1Mmeeh9RIqJFelR2UO1ZQAP4ajW5BuKcixPihQ8NdYmuLMhpCJbG79yUk78AhfvbcndUVRSvjrRsc3hBbVJTLYB/v8B2JEJBKAYPyt90fAPpTBus/9PwIEDwIttRUOxsEbvN23KLLqzPm76M/5eD996vy456hXOWByEKwnvTTELe/JqtQdwe4t7FJk06HiPOHvTwMUOuWtXP5MGkOIBTG1SgBarlJwYIKH5xwEPyJ2dghrl8YozpgqYYH7cwDJetftJt33kOiLAUiy5TwZQuJ3dbUWn+j1RLbEBypNejEj0iwlY5+ZGIyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GdPNngRH7t1nALIYU7tnbgzWWCk9JuUrvkiRRC+MDzI=;
 b=NvqrwaVw0QGdlZGExWobPhrwuJ4hyN3WTgxPNYuNfFSVJzL96LZMN3JOyqv8BW5JvdFnDl2GlW8dcNmNsbxMd+b+ExLmnMVo9yjmlboibI7FLKETL/bu/rGQsefya/tjlX2bOY0IEFzbhQ/vfYzgWvLmG5Zcy627ufrPn9Zp6bw3TceRIsGHHYRagBgJ2BBbfIPkMGFVkVqGnmE3a+a3WqkRGz0aCdBSmCSAwFE59s4Tl4Jg7clOOcHYwbFpldSfqAeehiYp1hjTiMT/7yc8AWllN0TjYA6YQqUK7W75CYmraWcjr4MbT/s3vqwTdxbL22Bg5aJGmroXIbeBmSRkZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GdPNngRH7t1nALIYU7tnbgzWWCk9JuUrvkiRRC+MDzI=;
 b=BPLsdwW1/CKyzbKovOu/gtFjmLhurJHjCA8lbFEuKY8csgoCLwY8wl3XkepujLjSR8LsguDP2TFV7Nq92ZO+zY0m/reAcCPLQh38RdbsV7uw8a3D7VhAu3T95RV6Cxbj+a2Z6rvh9ck5ClqvvNtJ9FJa1AEOdlpbzzS0CCHHxI4=
Received: from SN7PR04CA0160.namprd04.prod.outlook.com (2603:10b6:806:125::15)
 by MN2PR12MB4343.namprd12.prod.outlook.com (2603:10b6:208:26f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Fri, 21 Jun
 2024 08:30:07 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:806:125:cafe::3e) by SN7PR04CA0160.outlook.office365.com
 (2603:10b6:806:125::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.33 via Frontend
 Transport; Fri, 21 Jun 2024 08:30:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 21 Jun 2024 08:30:07 +0000
Received: from BLRRASHENOY1 (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Jun
 2024 03:30:01 -0500
From: Gautham R.Shenoy <gautham.shenoy@amd.com>
To: Perry Yuan <perry.yuan@amd.com>, <Mario.Limonciello@amd.com>
CC: <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
	<Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>, <Xiaojian.Du@amd.com>,
	<Li.Meng@amd.com>, <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 7/8] cpufreq: amd-pstate: enable shared memory type
 CPPC by default
In-Reply-To: <c705507cf3ee790e544251cfd897ed11e8e57712.1718811234.git.perry.yuan@amd.com>
References: <cover.1718811234.git.perry.yuan@amd.com>
 <c705507cf3ee790e544251cfd897ed11e8e57712.1718811234.git.perry.yuan@amd.com>
Date: Fri, 21 Jun 2024 13:59:53 +0530
Message-ID: <87cyoavgu6.fsf@BLR-5CG11610CF.amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|MN2PR12MB4343:EE_
X-MS-Office365-Filtering-Correlation-Id: f8bbb2f5-89b9-425e-d085-08dc91cc5b5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|376011|36860700010|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?raVz81cyuuoz6pJHgpJ28kc6Ri68jOqVmyUIYp2aRYRzevpXrrEPqa7AwfZv?=
 =?us-ascii?Q?x0aj5s6dA5zm9AwFjKbz9mXoKiOj1ggo8sLn2Wf7nGl3L9SWW9cU49MYEH/G?=
 =?us-ascii?Q?p1V0UbxntqVeWqfgstAnlO8SA59cghsIa5LIYh1QGg5sDDsxIxGlhwQ9FHCy?=
 =?us-ascii?Q?+eLScK4KogdEvrjEWDinuhilOp+MviQB9KwBXpf8eE5W3VsORhkWt3yhPx83?=
 =?us-ascii?Q?YbZ+SvbEfC12lJ8tYdAawPFjhG6e05LHLVEFLiP+uBLxxMyCQQC9buTQTb8m?=
 =?us-ascii?Q?JnUyQPYA54Gf4Uh3ODoSXSoXNx+ZEDCeyKCTmTAZtYO1CScKCIRFFAgIQyQb?=
 =?us-ascii?Q?YSoY/0mmx8GVMiwbg5//jLdkCHydu/pyLM9K9JycZt6Z4r3aE02INtAmGJzG?=
 =?us-ascii?Q?VI7HIZPpY9Or1VABNLiEAseLXzmg116055Qer6n5r+GVpaDVN1eGpp330zqg?=
 =?us-ascii?Q?lP5VW03frqr1ydsSpYod1eUeXYEF5Oz+XcGNu8SLpgmbWxpZ/KRxGizOrSs8?=
 =?us-ascii?Q?cB6xciYuHo5Gl1WOWxedK4q6eL6+nMEhh8xh+0pdvnp7gERHzgzkjTXG07NX?=
 =?us-ascii?Q?uyAzpS8nJBJ8RxAG37y+AREyBKHErWk3Jx7GOPKroLZUAvWvqLAfEjtIxXZl?=
 =?us-ascii?Q?TGw5Xmd2lGqABHPgvDN4Qk/pD2oODVC8twbBQXNFYbx0+JTXBup+oKlaCl0X?=
 =?us-ascii?Q?YhxTqVcMFqGYJMbg0PLH6GRDnOXs9eNtTiG4aQaIjIauzEgBEKkuDgmARCKy?=
 =?us-ascii?Q?ePMn2d3cQ5AOn9Rn5RiGgNmNeLbA2bOyThE6MoRTMRJjMg+6FffBjuXRpNuD?=
 =?us-ascii?Q?TQB4hU55djLObhXudfKUYzNcfLfcgeENt5cVjtoK7J+JCOXbZC6emDedQsYL?=
 =?us-ascii?Q?pUk9FZSB1+SIWNGwY2rOsTCxoTaVgGjI9V1AuIDnqX8I/pDEDiR1ULoSLaog?=
 =?us-ascii?Q?2AZ2wDBIBP6Bsm+vo+pXyhPfKhQu7s/TyJvFRDsqd4HLp+lIVa0qMu2CIIWl?=
 =?us-ascii?Q?rNcW0G4DHtDqMzCw/5fB0RXuARuN7OGav5+xYmz8EACVFdIydSTnyujXlPWY?=
 =?us-ascii?Q?TmD0/J7tleW4rTsFkMwBv0imdHMzx+9J8O99bcEbrhzT1CrbAcWggs8rEl4S?=
 =?us-ascii?Q?p1gb+GBoJHsdacPHhw1jMt2FA4Bwg3wJHEaafCCYdKhS/TbCbMrZEWPz5YhY?=
 =?us-ascii?Q?OsWNu4OEvbLUAkLwDndu71ftR3WdeOt1F3tHMvyNOhepOeqeqHSEITduM/lQ?=
 =?us-ascii?Q?t7Ch7RWPquc5Xp9WSjqXrkC3VV4zL3qcm3/7b2VvRI/+5skYZAETr1ltsnRi?=
 =?us-ascii?Q?xsRTFtNP3WodMTtfBe05tlB3f2uWajavXgfbLf5L6kD+SoCCTLcMGFN6ejxY?=
 =?us-ascii?Q?scA1lEG79hKs/D86//eJMWhbZbJ6UGcyImYCyYHO+5+nBCH00A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(1800799021)(376011)(36860700010)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 08:30:07.0930
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8bbb2f5-89b9-425e-d085-08dc91cc5b5b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4343

Perry Yuan <perry.yuan@amd.com> writes:

> The amd-pstate-epp driver has been implemented and resolves the
> performance drop issue seen in passive mode for shared memory type
> CPPC systems. Users who enable the active mode driver will not
> experience a performance drop compared to the passive mode driver.
> Therefore, the EPP driver should be loaded by default for shared
> memory type CPPC system to get better performance.
>
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

> ---
>  drivers/cpufreq/amd-pstate.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
>
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index cb750ef305fe..0f8ffbc0dc2a 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -86,15 +86,6 @@ struct quirk_entry {
>  	u32 lowest_freq;
>  };
>  
> -/*
> - * TODO: We need more time to fine tune processors with shared memory solution
> - * with community together.
> - *
> - * There are some performance drops on the CPU benchmarks which reports from
> - * Suse. We are co-working with them to fine tune the shared memory solution. So
> - * we disable it by default to go acpi-cpufreq on these processors and add a
> - * module parameter to be able to enable it manually for debugging.
> - */
>  static struct cpufreq_driver *current_pstate_driver;
>  static struct cpufreq_driver amd_pstate_driver;
>  static struct cpufreq_driver amd_pstate_epp_driver;
> @@ -1815,11 +1806,9 @@ static int __init amd_pstate_init(void)
>  		/* Disable on the following configs by default:
>  		 * 1. Undefined platforms
>  		 * 2. Server platforms
> -		 * 3. Shared memory designs
>  		 */
>  		if (amd_pstate_acpi_pm_profile_undefined() ||
> -		    amd_pstate_acpi_pm_profile_server() ||
> -		    !cpu_feature_enabled(X86_FEATURE_CPPC)) {
> +		    amd_pstate_acpi_pm_profile_server()) {
>  			pr_info("driver load is disabled, boot with specific mode to enable this\n");
>  			return -ENODEV;
>  		}
> -- 
> 2.34.1

