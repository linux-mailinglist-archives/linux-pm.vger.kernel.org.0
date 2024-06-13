Return-Path: <linux-pm+bounces-9062-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E34C906660
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 10:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84E62285EE5
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 08:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9663013D2BC;
	Thu, 13 Jun 2024 08:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="e8wzCEsl"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB7513D2AF;
	Thu, 13 Jun 2024 08:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718266767; cv=fail; b=Nt/dai9uysncfbTD+ryT6irpiNQdTU+iBTh5rmZMprYJAejd3tohdXqQiC5H3oUcxPPPfuozLOzhIsvdOcGROfcORA6AGCRlW+NWBrrmowPQqEhlmSQXRMbXDTS38m/THECmjaklu2tzH6BYyadtoX5jzzKfpxVGDtmIn+Aby0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718266767; c=relaxed/simple;
	bh=hosPDq71C8DmySX1TO4FN7iQ1faro842qGuj7vtMEUU=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=draOJ6+sZF+NDgmDubChXmJlSjMFS+VFESH4v+3rN6aIVrdf99nnc/dXXTWgtLdK76Yx48VjSQeaPAYi18OI72Knda5cRpMIpDTm03sc8Yp0qi0YQVM5/8Ynmf9jR5z2DNN0jthz9C1Ns76KyVG3Mv2q7tVzsthKIhc3gEkbZ4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=e8wzCEsl; arc=fail smtp.client-ip=40.107.244.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gyKR5lshYE4mhZtxx8Ob3jh2LAjZk2cYjBoQOfUsoJfrnwTVja/e66JmI/qFDc4N+JYd1IL+JmUNzYCv8O/It+qO7ucc46ukC11pmN1sTAAiRpaXqIk3pCAu0VHHM5OOa/oNuBwn7zs1gEt4EWf3gqEPi9BxRtQVcRrU8WJKAXIdpxnOcwlBqo6afFVUqEiYF8atGVgcMKCwO0nV4v87JwAkgnj5C+uvWxj8TzogvfaB/SkkAUscDQPQi4k3pX+oVawKZFX60ou9h4tw9uojefkVrRcD8TkeEOQ0HDuV4vU5ecEQfYBCqEitAFsn7rCY59u15+iKKIUDp2JyKxkxKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B38VU4S92u8wnV/A50Maa1uQHXb9lAhMLM1zeiHt3UM=;
 b=aSvk24GmEXD7fch0Otnd04I1E3+8wqTRW2qTWj1JXykoiZ/i76SqbK7UfClJDso9JJ8Tn7oJzmOZ/syv0K7PUR3znXF5TksekNv01lGubB8uW+lJJFmvBTp4UzvF0bCweCaiYU2vP9e+Gk9sFt3CUUSq1HtfNQOPnwdvZs/flAd8QOttVpywEKoe7hjhiBmJVAypNrfktWmychDK34wV38USWlyAun4fbH9B8/VQ9/eafJoXxRgyrnjdQPlQI2pDqN8e1/apPT2NaGlM1x+ga6S+dXDFctByWYiWKXLlupAIJ+YQqfNtM03Vsv8BAVmbhaETtjNxtSYiM0RhiFPDCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B38VU4S92u8wnV/A50Maa1uQHXb9lAhMLM1zeiHt3UM=;
 b=e8wzCEslEkyOnPkxX0m1Gh4ElZdnAK3GPGnBq1JcMCc5Ml7nqFh9y5Hxid5LjZWsexFloThahzefDCNaJge1iJ58qsGtZyYLzjldLXnM/wR5PLCBkGTBQmd4dq+3UtwqtkZJhBEDzoslSrAiOFbDAnxChPt2Um/66px+AqCf7SI=
Received: from DM6PR08CA0001.namprd08.prod.outlook.com (2603:10b6:5:80::14) by
 IA1PR12MB6066.namprd12.prod.outlook.com (2603:10b6:208:3ee::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.36; Thu, 13 Jun 2024 08:19:22 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:5:80:cafe::b8) by DM6PR08CA0001.outlook.office365.com
 (2603:10b6:5:80::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.24 via Frontend
 Transport; Thu, 13 Jun 2024 08:19:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 13 Jun 2024 08:19:22 +0000
Received: from BLRRASHENOY1 (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Jun
 2024 03:19:18 -0500
From: Gautham R.Shenoy <gautham.shenoy@amd.com>
To: Perry Yuan <perry.yuan@amd.com>, <Mario.Limonciello@amd.com>
CC: <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
	<Ray.Huang@amd.com>, <Borislav.Petkov@amd.com>, <Alexander.Deucher@amd.com>,
	<Xinmei.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 10/10] cpufreq: amd-pstate: automatically load pstate
 driver by default
In-Reply-To: <39b55abeb278d9ae1688c0b87cb7ec8a3e37932a.1718095377.git.perry.yuan@amd.com>
References: <cover.1718095377.git.perry.yuan@amd.com>
 <39b55abeb278d9ae1688c0b87cb7ec8a3e37932a.1718095377.git.perry.yuan@amd.com>
Date: Thu, 13 Jun 2024 13:49:15 +0530
Message-ID: <87wmmti7b0.fsf@BLR-5CG11610CF.amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|IA1PR12MB6066:EE_
X-MS-Office365-Filtering-Correlation-Id: 11a860e5-09e4-4b8f-ace2-08dc8b8187ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230034|376008|82310400020|1800799018|36860700007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0KaQ3Wi5KblvbuQ4LOhXo0/b9XbHlvVQzQB3bdZgzikzrzWHyFOjR5kmTDrU?=
 =?us-ascii?Q?obbV2ex0Qhpl3qgQR+4toHrDVu8ZD6pN9m3/h38Scry1BL+i8eDQ0BoVH8Vw?=
 =?us-ascii?Q?M/0z74Us/VJjCbS9PIb4jsw/b64HiH2A3GQwGl4Et81Wrx4+FO4C8neIwp3Z?=
 =?us-ascii?Q?rs1qQiIPTVVingZzWRdyWZnRbNso3kd/GrmHhcb7YnriV/Qq09lpCRJ4ma5N?=
 =?us-ascii?Q?P9vig56otXCIbBuB6zr6TC9DUIY6KdYZVXicZfn0D3E8RSAidyi8EMJS3+lU?=
 =?us-ascii?Q?CsH/C4uUAGWC6L6LY7dYCWGOJqm6tulXcSDTipH3IUeflD33sqJ0Ox6zCKmP?=
 =?us-ascii?Q?0zUsiN7U+avFWyO7mFyM8k8q+DYqnXKdAGsow+jlwqhoemDXoJ18HDfr3TsE?=
 =?us-ascii?Q?jq85AE1HIscnMRj+mniS6wlYO8X0y/dQJRaa6MRaRMdJCRr5txbB+gYf8THS?=
 =?us-ascii?Q?uHLHSDW5+RUnUGi+Wpi8abI+Rm/owiU3bhER7gZt7AxnEOdjHNqA7UQ0XukW?=
 =?us-ascii?Q?o9o2tdG2eRW+R8cBAJcbOP2q/ZrQPzqsvc22yT9xuXZdzZ8UFjfCZBBBS1Kt?=
 =?us-ascii?Q?zuffiKsUkJPJ6R06BlOsqH2ZrnTFzVnmSIR4hY8SOX7QzytBu4ewI2URHrUN?=
 =?us-ascii?Q?Cmx0XwKqLctdOIOaZ/OQ837nNXEfz7KwGOq0tScgns1bJ+2/EVG33fufc4cF?=
 =?us-ascii?Q?TjealvFFlB+dCBpfXkMNft2Wbk1hSw7pf5NGtAI6lnzYvesvwEsVqetAqtQU?=
 =?us-ascii?Q?jR40Oez0FznxnI3YYbKXXZfm84gufkubzDF/i6OJnW/J5zAlktWMErChB6J/?=
 =?us-ascii?Q?R+kLjin+kwvnmi/Zn5weMOrhThPNLdY4WNyo7rXIXJyrHJPsUZqxDvw5FrxG?=
 =?us-ascii?Q?htshIPzUezNyzgtvvlai3YMFMSTnVTlpxjj0+IA7tKVbIjSexYJhGmZT1dHT?=
 =?us-ascii?Q?qBHREdcsXE3cKWUXMrDP18o9yBQWugzbyIj+LnzIIr+9DE+uVBHCrNB8cgC3?=
 =?us-ascii?Q?5Qe6omT4XaSlIv9s736RTJUfcqrOba68wir3tLl4EzqV7aAOQ3oCzgL66Y9v?=
 =?us-ascii?Q?A6nR5Ii5i+CaLZ5SItfyBGGi/ewvt/1Ad5u1hVKq6wDlHdTm0d8LFyR/H4JG?=
 =?us-ascii?Q?zBgA0h+6OrDOxsFAb9Qlw7AvE4RK+sAp4lv7JOYcS4fLsPbsiDG8pievMo4J?=
 =?us-ascii?Q?RiClQxSl8+/dMzKDnRDpkdrJPw7MAFUZCLgbDWxQETLLeImrmlV3M+ESgsTd?=
 =?us-ascii?Q?SrelI3MhgXjCs+BNv9CM/cY63Fj9/TvrkFvfrs6ReOT/bujEGI+s3oDiROn7?=
 =?us-ascii?Q?5fIMBICmzWHzltKANUydGzP06Tgsjwvl+GKJI6FOZ3O+Qc8nBDl37KbMeqnh?=
 =?us-ascii?Q?FcH+IYc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230034)(376008)(82310400020)(1800799018)(36860700007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 08:19:22.4119
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11a860e5-09e4-4b8f-ace2-08dc8b8187ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6066

Hello Perry,


Perry Yuan <perry.yuan@amd.com> writes:

> If the `amd-pstate` driver is not loaded automatically by default,
> it is because the kernel command line parameter has not been added.
> To resolve this issue, it is necessary to call the `amd_pstate_set_driver()`
> function to enable the desired mode (passive/active/guided) before registering
> the driver instance.
> This ensures that the driver is loaded correctly without relying on the kernel
> command line parameter.
>
> Meanwhle, user can add driver mode in command line which will override
> the kernel config default option.
>
> [    0.917789] usb usb6: Manufacturer: Linux 6.9.0-rc6-amd-pstate-new-fix-v1 xhci-hcd
> [    0.982579] amd_pstate: failed to register with return -22
>
> Reported-by: Andrei Amuraritei <andamu@posteo.net>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218705
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 27 ++++++++++++++++++---------
>  1 file changed, 18 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index fa486dfaa7e8..6e5c398810bf 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1841,28 +1841,37 @@ static int __init amd_pstate_init(void)
>  	/* check if this machine need CPPC quirks */
>  	dmi_check_system(amd_pstate_quirks_table);
>  
> -	switch (cppc_state) {
> -	case AMD_PSTATE_UNDEFINED:
> +	/*
> +	 * get driver mode for loading from command line choice or kernel config
> +	 * cppc_state will be AMD_PSTATE_UNDEFINED if no command line input
> +	 * command line choice will override the kconfig option
> +	 */
> +	if (cppc_state == AMD_PSTATE_UNDEFINED) {
> +		pr_err("pyuan cppc_state == AMD_PSTATE_UNDEFINED \n");

As Mario pointed out, this needs to be removed :-)

The following review comments are assuming that you want this patch so that
amd-pstate is the default driver on shared-memory non-server platforms.


>  		/* Disable on the following configs by default:
>  		 * 1. Undefined platforms
>  		 * 2. Server platforms
>  		 * 3. Shared memory designs

The comment says the driver needs to be disabled on the shared memory
designs by default. But...



>  		 */
>  		if (amd_pstate_acpi_pm_profile_undefined() ||
> -		    amd_pstate_acpi_pm_profile_server() ||
> -		    !cpu_feature_enabled(X86_FEATURE_CPPC)) {

...the check for shared-memory design has been removed. Is this
intentional ? So do you want the comment to be fixed so that it is clear
that we want amd-pstate to be the default driver on non-server platforms
?



> +		    amd_pstate_acpi_pm_profile_server()) {
>  			pr_info("driver load is disabled, boot with specific mode to enable this\n");
>  			return -ENODEV;
>  		}
> -		ret = amd_pstate_set_driver(CONFIG_X86_AMD_PSTATE_DEFAULT_MODE);
> -		if (ret)
> -			return ret;
> -		break;
> +		/* get driver mode from kernel config option [1:4] */
> +		cppc_state = CONFIG_X86_AMD_PSTATE_DEFAULT_MODE;

If someone booted the system with "amd_pstate=disable", the above will
overwrite that preference, no ?

> +	}
> +
> +	switch (cppc_state) {
>  	case AMD_PSTATE_DISABLE:
> +		pr_info("driver load is disabled, boot with specific mode to enable this\n");
>  		return -ENODEV;

....and this "case" statement will never be reachable in the
aforementioned case.


>  	case AMD_PSTATE_PASSIVE:
>  	case AMD_PSTATE_ACTIVE:
>  	case AMD_PSTATE_GUIDED:
> +		ret = amd_pstate_set_driver(cppc_state);
> +		if (ret)
> +			return ret;
>  		break;
>  	default:
>  		return -EINVAL;
> @@ -1883,7 +1892,7 @@ static int __init amd_pstate_init(void)
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

