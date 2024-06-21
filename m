Return-Path: <linux-pm+bounces-9745-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7274911EFA
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 10:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05F571C215EB
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 08:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F0916D4DF;
	Fri, 21 Jun 2024 08:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ctYyfgbV"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E3516D31E;
	Fri, 21 Jun 2024 08:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718959283; cv=fail; b=UJ9kQEQZChHFEUgjcm98L7l53Y88Vha2QoGgJ9aKxbqZCGcevxPY3fiIyzwRhWckiPRwAcVOl1Lz3ZQeXDwkXyirCUZIxkO8atDfNrOfEoeqbBn6ZAfChp2EbgLCVZO4qVT3MtaE5X0THIh8QJ93gGC1O9q6NDCt9V4AT1IG41M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718959283; c=relaxed/simple;
	bh=ZYEJXaxHca1LP7X/e5KYiEIMb0javHN4Dn0Fe3/BgfY=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZpKiqegkSKO/JjkkqExDngRkRpfzna9sikaiNUEXXv2BHdCaSZDjQDYkjwqpPpQ1HHwaB15p9JQopWX6zs2BPZ1AcsvSSPUZypmNnM5Z+5hlsQ+1iQo/42HtsOuo8d+Y1QmB24FjlcGaNo6DHIrUlKZnc06Jh02mw1rnUPwbuYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ctYyfgbV; arc=fail smtp.client-ip=40.107.237.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZsKohJR0jzkPqe2MdDBNu3PAD38RS2CU86I4PSM5H+2sJ/jE1vKYwwdkNaSv7l2vCUwb9lBMcrOGv0mYfmmFDDDoFxxZuV9ObTKzWEtqUgz4WYsZZXZVfhVcpI6nwgDJ4qqnB3KmvmPZis3qmk4VHC+E2D+LUqj7zT1FF2+O21W7WSH5nxE/Lj00O44wJedwi+yqkmOv24/HwG1pLTTKqyLqX+V2EDSqS6FoWC80bS++TogvsawrU+VO2V/pBfyzATiw85sOkwyN9kax7jtmNuk9kt7zxTp/TmcEws+rZnGh7z4z6Jq0k2JTinCeIxlAeAkkTRqINN5GMwUyPvhXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jFS0X3jPF4tMihuvFYMgDei5cAyrClutYktkMxYOddg=;
 b=UgPmzWZb+IWKX64lzfVVXlq50Va0EdAfpG4Iid/YMgV+D7BhulhNxPQ/3Th6fZxDICJyESlR5Qxc1gZ3IyiroyD8XB1Hco2gQdF9NVbGQKUuCmgZEjgeD9aOtA13d/M5GkKbWWBO4SFckP6e3LhOw/77Ss7v8HjDilCpa7nXXYuoNvSh6HxEhIPdkuCvFqX9AhuUEZcQz88zS7qm4njkjG8c4EXgZWyIusxARMSDFc4j7TOgjBH1LjtEs9Pp/LEnPI89xDemvG57wGS1Qedq+Qrl3qdiDmx2l2MXu2T6HtLjg0r74epAlWLutOXia4bQwnXwl4hPkGhjsMqBcxjdyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jFS0X3jPF4tMihuvFYMgDei5cAyrClutYktkMxYOddg=;
 b=ctYyfgbVJSzZTMCV8XiwYONI9clAxwwm32tUKGvBO8nMMoGqpZ2irAb4LGnLjOFO/UB1pKe7wuQiSjOLrxtr/6pgpwv/Jh3U2tCy9vXZEp85awxnJRU8TsfKfRcXRw8o/WCgBfZD2z487L2Rp8mN2yXIGrsGEPQzXIci4m43Np4=
Received: from BL0PR05CA0007.namprd05.prod.outlook.com (2603:10b6:208:91::17)
 by DS0PR12MB7728.namprd12.prod.outlook.com (2603:10b6:8:13a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.22; Fri, 21 Jun
 2024 08:41:19 +0000
Received: from BL6PEPF00022575.namprd02.prod.outlook.com
 (2603:10b6:208:91:cafe::a) by BL0PR05CA0007.outlook.office365.com
 (2603:10b6:208:91::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.32 via Frontend
 Transport; Fri, 21 Jun 2024 08:41:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022575.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 21 Jun 2024 08:41:18 +0000
Received: from BLRRASHENOY1 (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Jun
 2024 03:41:15 -0500
From: Gautham R.Shenoy <gautham.shenoy@amd.com>
To: Perry Yuan <perry.yuan@amd.com>, <Mario.Limonciello@amd.com>
CC: <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
	<Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>, <Xiaojian.Du@amd.com>,
	<Li.Meng@amd.com>, <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 8/8] cpufreq: amd-pstate: auto-load pstate driver by
 default
In-Reply-To: <83301c4cea4f92fb19e14b23f2bac7facfd8bdbb.1718811234.git.perry.yuan@amd.com>
References: <cover.1718811234.git.perry.yuan@amd.com>
 <83301c4cea4f92fb19e14b23f2bac7facfd8bdbb.1718811234.git.perry.yuan@amd.com>
Date: Fri, 21 Jun 2024 14:11:13 +0530
Message-ID: <87a5jevgba.fsf@BLR-5CG11610CF.amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022575:EE_|DS0PR12MB7728:EE_
X-MS-Office365-Filtering-Correlation-Id: 00bc80e5-b48a-45b4-e027-08dc91cdebcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|82310400023|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LXxMICdlz52fiexeGj+PsUNy4fDb2XBF4nhHoBjn2RytmBmtDAit9wAdoLc4?=
 =?us-ascii?Q?D/2jFu1sBOj2BAZL2uB1cy/mFWOpenporNT2HDDcrGCbiwoZyQynKFd5UAXU?=
 =?us-ascii?Q?Ht8llDZoOIAT4Cyw1hr73bvKW2qNFMKJEk44GJAvQgm/r3HTKCki1lJBAfHq?=
 =?us-ascii?Q?ah3+ltegjHScauCX3nfakUPM7B6DQMAxmZb9fR9Pl/W5hV5Z1/Rethk3/5y0?=
 =?us-ascii?Q?XMfF1JU5N2MZ8UvoGDRGMAHTzFhgcFyuIf6tdM6KfKpCPwCa173oRZgZKnQa?=
 =?us-ascii?Q?Fzf8ezf4FkbOvSnKHc+cY798MZRBnjoFn//tnVUEMO4Dw2qXoQjkgWJxM7AO?=
 =?us-ascii?Q?Z/SlglFH3icaNEdzIE7NUBbdqapr+bNflD90rv5dkFpDWAkB1Q85xMb6h7N3?=
 =?us-ascii?Q?C+dPlXBxuNVxYv4sBgT5AwtCkBjHWfAbg/1z08K2vWgJDeDEIvuX1IlV4AG8?=
 =?us-ascii?Q?4wLmvjoVPnVvj1bZy16JdQTJKu+bCYa69kJi0pUdF6htPUupa3sxXqRU+jLv?=
 =?us-ascii?Q?xC+hZ/VOSzhrhXShqRYc6X5MYLeI9O19G+KhUvaGoiBddIS4yyg+D8ZMn334?=
 =?us-ascii?Q?2BolD/EEFBAkwoG8hn0K+67DKF97GQaKpoTcMQS0hFZO9yK8rBPJiI3IAlqQ?=
 =?us-ascii?Q?sGJYlz7r4M85uWH+dwWIANo6iCwEZMdXkKqySYc19XJWvHet9Ly0xIqcJug/?=
 =?us-ascii?Q?vXNE8mvjBbQDRvNB74so1CDAqfZ4sl/FHlSMbU3DpTboci8NoBQqAh9Gx9yu?=
 =?us-ascii?Q?A4LwILb+lVQaCmA5OmvGXcOrepZcj88kYEPKQ5/aCaLAZS7HWdTIMJHfs0yT?=
 =?us-ascii?Q?HS4hY7ZvYaN733rTnMEFoPhTyU3lRr93YOo6EGF0EuUF4NKsadEaH7QHgRss?=
 =?us-ascii?Q?cRAdorSjyyOJotmErJSpZs0YKpqevyZQh8POXDZP9gwTejWj4z4t7cNMK6Bx?=
 =?us-ascii?Q?ETu0GzKo0RFsIAafvAnQNMxzEgCMqFsGetH6kh72plm8xvdEFKAPAlQMzxVo?=
 =?us-ascii?Q?Azd2J8j06nLWs8mqzzi33FI2AMTzNHb1mxQhCNtuhWiBmiAKT6g9DjGE2KM6?=
 =?us-ascii?Q?VE3Q1qHnMiy5hV+Rw+D1mvLIU6Ot5KtmDGjyAk8CBJb1IF5kZhXfaHwSjCEc?=
 =?us-ascii?Q?oCIYfF+SEViD4V93Fdsv0s8ZQrwn91ZNUyFRH2E0o4FGgsGDvkACbHcE/mil?=
 =?us-ascii?Q?loz43Dk2ddWZcOWgxiuTNm5dLjgqtwKL3XZJtoXQj2fivQkNasf3d0r+kbho?=
 =?us-ascii?Q?FeQ8yLtorCmwcjh6mt6Uy6RELqmtaIPt4B5tKBZ86HhlQCS9D0nVR33m8hrY?=
 =?us-ascii?Q?x9VsqCGlDkoXI3rzvaZBuScDyaTb3dj0YKlB/Dx5KH8rv1J9x8RvevQ9GXVM?=
 =?us-ascii?Q?m+fTJ4U=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(376011)(82310400023)(1800799021);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 08:41:18.9472
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00bc80e5-b48a-45b4-e027-08dc91cdebcb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022575.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7728

Perry Yuan <perry.yuan@amd.com> writes:

> If the `amd-pstate` driver is not loaded automatically by default,
> it is because the kernel command line parameter has not been added.
> To resolve this issue, it is necessary to call the `amd_pstate_set_driver()`
> function to enable the desired mode (passive/active/guided) before registering
> the driver instance.
>
> This ensures that the driver is loaded correctly without relying on the kernel
> command line parameter.
>
> When there is no parameter added to command line, Kernel config will
> provide the default mode to load.
>
> Meanwhile, user can add driver mode in command line which will override
> the kernel config default option.
>
> Reported-by: Andrei Amuraritei <andamu@posteo.net>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218705
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

> ---
>  drivers/cpufreq/amd-pstate.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 0f8ffbc0dc2a..a96ad7d10a4d 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1801,8 +1801,13 @@ static int __init amd_pstate_init(void)
>  	/* check if this machine need CPPC quirks */
>  	dmi_check_system(amd_pstate_quirks_table);
>  
> -	switch (cppc_state) {
> -	case AMD_PSTATE_UNDEFINED:
> +	/*
> +	* determine the driver mode from the command line or kernel config.
> +	* If no command line input is provided, cppc_state will be AMD_PSTATE_UNDEFINED.
> +	* command line options will override the kernel config settings.
> +	*/
> +
> +	if (cppc_state == AMD_PSTATE_UNDEFINED) {
>  		/* Disable on the following configs by default:
>  		 * 1. Undefined platforms
>  		 * 2. Server platforms
> @@ -1812,15 +1817,20 @@ static int __init amd_pstate_init(void)
>  			pr_info("driver load is disabled, boot with specific mode to enable this\n");
>  			return -ENODEV;
>  		}
> -		ret = amd_pstate_set_driver(CONFIG_X86_AMD_PSTATE_DEFAULT_MODE);
> -		if (ret)
> -			return ret;
> -		break;
> +		/* get driver mode from kernel config option [1:4] */
> +		cppc_state = CONFIG_X86_AMD_PSTATE_DEFAULT_MODE;
> +	}
> +
> +	switch (cppc_state) {
>  	case AMD_PSTATE_DISABLE:
> +		pr_info("driver load is disabled, boot with specific mode to enable this\n");
>  		return -ENODEV;
>  	case AMD_PSTATE_PASSIVE:
>  	case AMD_PSTATE_ACTIVE:
>  	case AMD_PSTATE_GUIDED:
> +		ret = amd_pstate_set_driver(cppc_state);
> +		if (ret)
> +			return ret;
>  		break;
>  	default:
>  		return -EINVAL;
> @@ -1841,7 +1851,7 @@ static int __init amd_pstate_init(void)
>  	/* enable amd pstate feature */
>  	ret = amd_pstate_enable(true);
>  	if (ret) {
> -		pr_err("failed to enable with return %d\n", ret);
> +		pr_err("failed to enable driver mode(%d)\n", cppc_state);
>  		return ret;
>  	}
>  
> -- 
> 2.34.1

