Return-Path: <linux-pm+bounces-36175-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B395ABDD98B
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 11:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 622344FD017
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 09:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CB930BB94;
	Wed, 15 Oct 2025 09:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0mZj2Iko"
X-Original-To: linux-pm@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010057.outbound.protection.outlook.com [40.93.198.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6306E30B506;
	Wed, 15 Oct 2025 09:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760519077; cv=fail; b=hwSP7LeD/kKuVJeAyTBjw8AazOL5Vafw2GGSULDnBkmkktEku3BpG5OiFjcRHdY3LjH23TgYbmqoE+I/idLBSEnTtLGpVxHuNgoHPlZ3EIIXi5SmSV+/pfbQdHvursggPKhOJY0UmiCq3UtarYyGhX9cElpC5PCAQNl7rjgH3z8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760519077; c=relaxed/simple;
	bh=HEXr3WgOIBIwXL9zpYgeehZ1LPmEp5SIbMDBnPd1GMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tsR3l0Kr7bGBYmS6oorJ1+OWNkBHyMTUeN/9tUxpduK5/S4/mCjM94Gld0sPGF6uL3ur7cPwdxIuJAyPwMAiMfUb0y2LmwAEodlWoBjsKd09F6q3D5Bv2/Gg5+y5zklmlU+H/aWJdiveEg+kHKHMrEk0K4G49wFiXSVAG2ajSiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0mZj2Iko; arc=fail smtp.client-ip=40.93.198.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rKm5g3Lh/x8htim2omvMbSyyby8NVGvRswyvNrJFHTpSqXOr3r1CohPnERLCmETiV8QUiZ72BmKn+0tKDYMhwpkHoajmoAuHgP1gOfsHfJQwHA97+1nbewRo5X6JhQDpeaNHuLRYORdWEN+lkaLUeJGuplT0VfBO7njtnDFp+NirCh/wHEHK69L6B6hv7xklD/SBQPf0BdY/M4lvivRwfu0IAWr1o7h9b4gQhS918wh9vR6MCnXiFS4CAPQzZ+vrsr1qOukECP20HaJ4Q1kF0lmDLBqTe3T0ac/2TrGT/5d/uZZT+hF8h7+5SwJCHPfTo78XhY6Qz5g/N9xXKb9LXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=36X2nJluymi46Q4i/tfYsOvRStIwSxQC4dQqEM5I3TM=;
 b=ZfR6MpYN7XAGu4lACLUZesxGxiKjgdBnTDGgl9Z272/g3ZEnEWtam2xVyBO4q/BUqVJEiD9r34eeBOAYvTN9k+5VmEhnzy4yR9EAuWXZcZH4WfPVeSYJezTYqpdultkKSqONXHKuIy2GZCuhk04iTiPxcQsPsiUX+4j64DaITawH3hQO8KCVuHRNhRIO6vLL0+c1BMvLOIJO0ZEIWd7+KC0s01bNOWmJLOyx8nd0yoa0SeXFbVtXK/6DY98lhnNGCeWBbj9m56bDTQkDp37Bf8ovgu1ntSNAE3RBZ2kSt+IcPY5xxpnwFv5BV/M7FLwuCBbg4b3NlOclTYvWlsofxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=36X2nJluymi46Q4i/tfYsOvRStIwSxQC4dQqEM5I3TM=;
 b=0mZj2IkoXIUHJDdFwhOpPTwjec95Y8/ysz7mfozapmrhtH63VIv/Lmcwbfgh6mO5Ji/HT+gK6NyWuaf3Xtwi5QkvVaSaMvqhETz1cwd0UtaTBSwT6EamBtX7XYSMS7o171IggGTPuq44yUX62s+mZfvpJ1jfWgqmDpjuK/yqkrI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 PH7PR12MB5926.namprd12.prod.outlook.com (2603:10b6:510:1d9::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.11; Wed, 15 Oct 2025 09:04:34 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.9228.009; Wed, 15 Oct 2025
 09:04:34 +0000
Date: Wed, 15 Oct 2025 14:34:26 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: Perry Yuan <perry.yuan@amd.com>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2 5/6] cpufreq/amd-pstate: Fix some whitespace issues
Message-ID: <aO9jmtcU5iOA6DtE@BLRRASHENOY1.amd.com>
References: <20251009161756.2728199-1-superm1@kernel.org>
 <20251009161756.2728199-6-superm1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009161756.2728199-6-superm1@kernel.org>
X-ClientProxiedBy: PN3PR01CA0031.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::20) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|PH7PR12MB5926:EE_
X-MS-Office365-Filtering-Correlation-Id: a687ffaf-c102-4658-8de1-08de0bc9dba4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9ElS8FD5Ap5f+vqorMoeD05cLwv4bAYA1AKP/Oxhv0ofozstwlbRYgjLMK2U?=
 =?us-ascii?Q?hCZdNkAhobVP2fedw/CMrO3dIqEPI4Hi9GCVS1hLshm0GP9dsMgAJweGTxTj?=
 =?us-ascii?Q?d6HQyFgUmlWp30BvkO1+jgmaXODBat7fyGy/9lY9hPn35a7LElN8TryOncSZ?=
 =?us-ascii?Q?vcdhMIbPvLtEzpAi0yCEEfUuxTVEYkF5iZb+BD2AIXdm0r0cHZTBCacSfcD0?=
 =?us-ascii?Q?141pGdg7sNEDdjEmEuvByw4ifLrsGTUVKuLS/uU3GzZBrOARNTtSEYw8r1UB?=
 =?us-ascii?Q?3FnTCDrhnPqXKkegqH/WZk3NMKL3UA8d4oecldZH+DE1JZmI27ibwG3BIO3J?=
 =?us-ascii?Q?YOzr1tPY3rrHl5bRZJcsbCDRMbiZxWr8Pqv3Q5caynUKYsMZ5meqU/1PVMqA?=
 =?us-ascii?Q?q/bNb7UEtFzznVTOf1o26d6InvFNr2Hr58KJtCpulXZOY2Kr5x5NFHAYPIiO?=
 =?us-ascii?Q?In0HY5LQf0I52QI8luAA00txt+lQBP3emA9Zr7325Y/uWCKBn3R1lPZAlwWa?=
 =?us-ascii?Q?MPVh4Zh1z95fzIDCTq0qytb/R/SXhrtRe7UoqsYkaxQZklPt8PAspmf0GYGn?=
 =?us-ascii?Q?MQ36lqpTh0WGRJqIYa/ucXvexc0BK0mi3vUoIEQSh6M/vouzOnlZH806AOSV?=
 =?us-ascii?Q?XRFNjmqBH4NOLgdff6u1Wq58+cIUNzx6dPCuN6aKP0GlXs4Metr+dak/jb/d?=
 =?us-ascii?Q?BACCmdAsdT+8fT+QJBLdZ7nSc4ydrRnq5h/dZ1bEcLPr8f5NDroAy4D9uq5L?=
 =?us-ascii?Q?D+H1757rVP9U+P007/xJ9aC0PwG6a3vdZWwnGAh21AUomXCciWZiQzU+jJ4s?=
 =?us-ascii?Q?YSVzAZD8ANxxYxCG4IzJpHTyAprsOexiKPtYYg3bHXkuvp4IXC3WSg180+bM?=
 =?us-ascii?Q?0SZhDOqf2fFe6p1zZBa8W9aMePblM5ZOzbQLW55TsSHslBNaVvgeEIlmiCGl?=
 =?us-ascii?Q?pLMlBgtQHGOyXMzKEi/aFz/ZkMbqEJ5G6iR41Ss+F9QJtCicyiMjZ+BJExR5?=
 =?us-ascii?Q?FIKkwcCCpVnZIyOq+IYRuPpQuvxJCxUYMvBDKaHGi2XxQKCSOIZUxnvwNLIg?=
 =?us-ascii?Q?dP9mABzcYsmBvmJZEd8H/qfEpY1GEmMcCu07UfamTAdCGLLMTI4WDyv+D9JD?=
 =?us-ascii?Q?sIQVT6pCy+6jR5onSGTgo9UI0lKtKknxaNOgu+rJ5Baqa7zdeZJEzxBJp5sU?=
 =?us-ascii?Q?Zaey5teLaaLNWTMceNJP7GewE6QCJt12Tv2uldKNCHL26xGO9R1yvAqxtF2u?=
 =?us-ascii?Q?L2ze/HVITDGk6Glx+Hew+xNVzvPH0Jo+xRpgdEExTvPz39GBkMl9cqLYlrxn?=
 =?us-ascii?Q?Z4H/djFQGpavsAblXGLFTiOmprSd0adkhI3RWGzZMgU/H9zl099M5fegCrQI?=
 =?us-ascii?Q?+r5erbVRtBE0d705pqEnhpDhcjuTqUh18mGq1YNvi0ZPglBs3EKHjgoV7fx3?=
 =?us-ascii?Q?laqzBYwd0o78nRvzzux2PnQejdQYyD2L?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?311AoLu9XlvocBc7gj0HFiwtdWdfMy861BoYmL2Mx04n4UHTlcz/YVDrCW4m?=
 =?us-ascii?Q?uahWbGz82qxyC6LCqP9QiwlCTSHrHP2UjkMfSzgnwInQEQg+Hx0ho0rot9Uz?=
 =?us-ascii?Q?TaceMA00pFsdf0mkt4EuHrwzQ+kPxsir1hBrKdB+7RzXwGGd+eGKQDzHLXjC?=
 =?us-ascii?Q?I0tSt0Xa+ADBqX3E/0mkbVeh8ZR+Cgn4ftFMVBY1EQJYMcW7et093cMuhsI9?=
 =?us-ascii?Q?WY7i4gtHzb8nralhvntb6+5xToSq7WhWtiEiMazkSuH8UO6ZU7EQB39PS4az?=
 =?us-ascii?Q?35wIZzkTZRyPjhETKjAsXElTRkhu9pbge3C0oXbU15/qEfXQLE7fmYsMkkNM?=
 =?us-ascii?Q?LfoLll3epdlFUGnApnFe+6sqnucA3mZ6mv8ibTyZOn2yKGof6aiFT1zxVgB+?=
 =?us-ascii?Q?K+NDNZ4VVaT+pDABWJcaSG/x06KTzh9pUUfXDmwHAsjfx2toZIYhe+4uCaKk?=
 =?us-ascii?Q?MP8KMs+0FhCGmQZE1ctTta8azL+SuxivzeRimyTm4OTdSl/crrQ2F7JR8Zhp?=
 =?us-ascii?Q?8SPrSrgcT0lhTkhb/BgbN0UhJDZyCKzqskC9Xgumt3ZoRvTwsvBTIvmof9MK?=
 =?us-ascii?Q?pM6v/mceYs1TqR4sP1JImzoUXJOjghRR0MgB44fQp9ycytdR8m2EaPyTJ5vW?=
 =?us-ascii?Q?05LwHduIBcEn2BZeViNDwBpCtR/qHHWeEsP0Olo83jijSS+u+9TMD5gTWj7c?=
 =?us-ascii?Q?+FaT5wL1A7M09UK7gY6nFyTtLck+bNGU1dBrewTd96HCbqp9YlSLFMfHK2Mo?=
 =?us-ascii?Q?VY/1AzIY1oIgoYaHePgb6V10NuKiiKp5iHTgcIm9Ows/CZg5eRvky3XH887Z?=
 =?us-ascii?Q?6A1xv1TtjvKDEweTGun/aUZ8FrP4Vftqwa1e69CyRShS/LajJrGxtlERwrwl?=
 =?us-ascii?Q?1AKLtzrrRZX/X3RO5j7f/lTnJNTClKXG/Egnh0tnkDJp4EC1tZSlhM1l+n15?=
 =?us-ascii?Q?5MVFzhT1gYxjstaHSUdE46D8oe5oJrwDX6AhYeFLL63NVxxBMNyn+aboArCO?=
 =?us-ascii?Q?iuNxpt6UvTOMHQs95OljqrE+VnQHby8XM2r09l+rpAMrMsdaDwG4eOsqMJmf?=
 =?us-ascii?Q?q8KNKpWXgvnxtTvbQvCxR0caAmgoY3FOh8QgMHltypp5IKzEpLUAZVrUZ+RU?=
 =?us-ascii?Q?N3qx2YlhJ+uNXaxho/w31VJaH5x2h58tAHfwAzV15B+6OsvN9rf+ewMfQ70d?=
 =?us-ascii?Q?K5xYzocVe9YLCJnVSeYFxgsK3W6eZHC7CJ4TLXyhRs2cf/jC/ZGkslz2Nf/S?=
 =?us-ascii?Q?4/LxyataGWgYzL3xcS6ScvzE8t1qGYdG6gp7fRMmuK8mSZPiLdyWF0Jw56+Q?=
 =?us-ascii?Q?1ggFFp1zSCK8hopKRmccZjQXGlZhgsCh3qJRP0n9pnRt0S1IrpNGFeBsk2Ho?=
 =?us-ascii?Q?D8kYKPCDLtZMBLdRo9fTg+w9B9bgQxM84EInobmKmwt+0fdhbO61UsBzdWBc?=
 =?us-ascii?Q?oBPYlXJH++6gjmtQet3rwFk5ssTWJ4TMU7J9xp0Uo+aYiWCHLhNLSLMP4Ibc?=
 =?us-ascii?Q?TGjt2U9pqi+Yo8UR5FPTnhBI0m2PFQpWSPY+vGTRdf7Lmo+P0/zleGSGpe+i?=
 =?us-ascii?Q?QzUwCcRSiRb9BGMTesAYAqkYb53ZSAWUGHG1X/KH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a687ffaf-c102-4658-8de1-08de0bc9dba4
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 09:04:33.8661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +tcQfmcOlySFY1PgZ0upF8r0fPtIAruU/xCf7z/F4525+CUcJccA/5g0A/Sb2Un/dN6LNnfKR3Fd8is7KoPVXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5926

On Thu, Oct 09, 2025 at 11:17:55AM -0500, Mario Limonciello (AMD) wrote:
> Add whitespace around the equals and remove leading space.
>
Thanks for cleaning this up.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>  drivers/cpufreq/amd-pstate.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 2d2ef53d12447..a0f21ac1205af 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -126,7 +126,7 @@ static unsigned int epp_values[] = {
>  	[EPP_INDEX_BALANCE_PERFORMANCE] = AMD_CPPC_EPP_BALANCE_PERFORMANCE,
>  	[EPP_INDEX_BALANCE_POWERSAVE] = AMD_CPPC_EPP_BALANCE_POWERSAVE,
>  	[EPP_INDEX_POWERSAVE] = AMD_CPPC_EPP_POWERSAVE,
> - };
> +};
>  
>  typedef int (*cppc_mode_transition_fn)(int);
>  
> @@ -182,7 +182,7 @@ static inline int get_mode_idx_from_str(const char *str, size_t size)
>  {
>  	int i;
>  
> -	for (i=0; i < AMD_PSTATE_MAX; i++) {
> +	for (i = 0; i < AMD_PSTATE_MAX; i++) {
>  		if (!strncmp(str, amd_pstate_mode_string[i], size))
>  			return i;
>  	}
> -- 
> 2.43.0
> 

-- 
Thanks and Regards
gautham.

