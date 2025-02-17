Return-Path: <linux-pm+bounces-22195-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3BDA37F9A
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 11:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 679F77A1DF5
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 10:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53D819994F;
	Mon, 17 Feb 2025 10:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UdadqqZG"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2061.outbound.protection.outlook.com [40.107.96.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C563185955;
	Mon, 17 Feb 2025 10:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739787263; cv=fail; b=oOTEU3+tSS91ZiVx1BJwoiHsTibhCuoTAhj8eANFdZf8o/dGNdodfEQdbuhEhpk4qT0YUHQa5g5n2AsKOb8Q/g9yUdsKlAGbsU7KeNOy17qMPNWGm7B88WsegHtImy6c246mqoLpPlKFjUHzONhH++e16s3FUziXq1kPf1sps/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739787263; c=relaxed/simple;
	bh=XcQJYM2ovAXIvYBd7onapktuMRpRwWvnhkYW4Ost9dI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GIRzh9l76FFiyO9Tz1ksJG6b3faNhg4p0v0rtbKbmDqzJuSTsoMRElCIVXul0oL7TXlHr7vaOSbzTSvaK1ZNERwdejl97b4M8st2qaO1K2Ym1SDSHhyw2Emr9TusGomHjjdAnqeOtp5Wr4a0JPQZXGr91SaCNgTZyHM+4Eqby4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UdadqqZG; arc=fail smtp.client-ip=40.107.96.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rIALCyYrI7YwbUn914NY5ijHXjJeQjaOX81F+Txy3nRrCdcUq9Jxcg8MEh41C99As4jQpT/rcquVtJp4Grfva/lueENh54JglZ4fJoXsxrvgOZa1BetZPsmlnJLkW0Ajk5eF/G89xn47Vk5w5DBe9lwjXpDbbtwJc8bdxAFLp9BIXpZZQupUTMP82isf0G4s28GLpPWY6v0DyNtNtY9IiCDwXQcjc7CV8UJdO/ZZ42aYdWwuM4AeT6J4TbrsaBD7PqXkVqb07avSBpqc62hmHmc9ggylEWpgx8P64LXoDZlHhqZtuiiyDySlZ3ggYqYjJDw7q7IMxroat7TL2K70hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b7W+GHSV/5Rwna1Y320z/Op+b92DFZtHp8tzKUXLIac=;
 b=ggzjmMkapv3cZ7IDZJGsjphcfCPDyNt4GkKJuq/CRZwlQ7E8UCQy2mj55nCA9YxNGBR9Utzn6IerKLEDEbA+fX4GNmPsCXorIje/2/3eyH/aaXl+385OLf5YUpTS5HWga3+BzT9UWrBAjUS0ysB5QcWM7Szp9w6R/d5sJJrTUVNExDS2g/y8jLKGFPmz55/PlFhwrPOdMfGIp9sqre2RS5xi/HYKLwLD9Ap1+F6IEtXSnZR8cZmBcB1V82wrKNl+0Dou5EMr5nncP1/Q1NMxXE4/PrqZ82mx7fbfvT7+JBJWAHJSPNq0axPq23mbwX/OOS4BF0BGAQPP1vI7jMOjEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7W+GHSV/5Rwna1Y320z/Op+b92DFZtHp8tzKUXLIac=;
 b=UdadqqZG3ChEExnT4cH/Mv8MexkB+qiY6rVP+E4eJEiubATt7tAKEO/OmbS3fWqjCF/asUlApr6CbwzXfDWDRLNBKyOqlzmGCuGP+FNxH6izQbf6cyw9frtX9PoD/AJA3ZpFsq7iHDNxF8icNGuxnpUQOdrnX1zxla0nbLtgSV0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 DM3PR12MB9351.namprd12.prod.outlook.com (2603:10b6:8:1ac::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.18; Mon, 17 Feb 2025 10:14:19 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%3]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 10:14:19 +0000
Date: Mon, 17 Feb 2025 15:44:12 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: Perry Yuan <perry.yuan@amd.com>,
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v2 07/17] cpufreq/amd-pstate-ut: Allow lowest nonlinear
 and lowest to be the same
Message-ID: <Z7ML9DCvuM3yVNgN@BLRRASHENOY1.amd.com>
References: <20250215005244.1212285-1-superm1@kernel.org>
 <20250215005244.1212285-8-superm1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250215005244.1212285-8-superm1@kernel.org>
X-ClientProxiedBy: PN3PR01CA0037.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::16) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|DM3PR12MB9351:EE_
X-MS-Office365-Filtering-Correlation-Id: e8f7a9a0-4ead-4784-da40-08dd4f3bd77f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PmsqIVAzFjcEMf2YUPWjahC/McXPv53APK/2K9S38evbup1lKyGmYK+199td?=
 =?us-ascii?Q?MW2XUUOTBTIbspi4pqlmS9WtMMOMKnRpjfbgoFFN1/J72d+vDVnKbqZUjmgz?=
 =?us-ascii?Q?5V47aZzrH2PTwMceSYJkplRzLZiDr56BPk9p0VN1G46NZ/f3yxkJszM5dPfA?=
 =?us-ascii?Q?Yrt7vUFkZO4Jj/j6u3qzjOM5CRAABEdIlw+fKZxAPqbf8yWnTJzfNn23R0T+?=
 =?us-ascii?Q?mOvLYmr9sG16q/AQZn9IyJryoshIJ4NFWlXMSlAvEk6xW0willU5TpnheO8l?=
 =?us-ascii?Q?lOdc7kYkUb5gDgZXORkrEhByGSwj9zwG1E9549oBD6ZEUF2FAPVEDSBBFtgT?=
 =?us-ascii?Q?ur+DwQyAGhLNoX3v9d8FJVYyezV4yUvfbppFVp+h9Zbg5rSsnEJCh5hQ23zV?=
 =?us-ascii?Q?cDyEziKdpucRQWKycbhkugwQ1ExKH3ck9Bt2qm4VQRsJBpjAuDvMjaRWG9Da?=
 =?us-ascii?Q?QRrKeln/AbPt4ZdAYkVkKybvzYwKAEPfgydgBYK6kdDVasUlWTMnSghNy8Fd?=
 =?us-ascii?Q?P/8CP5bBZvOEJo6oj8TN7s+V8V/3ZTXGLmG5xrZ/KGuE81nuA2XpkwnBS4A/?=
 =?us-ascii?Q?ZO39Iwo2eG0WYFnTLEl99lt9c8W+TCF39ZI2Ws3UBMhtoW7uDrheXATTe8Wq?=
 =?us-ascii?Q?ptbD4jFnqpGR9BKQn7YMuN0lEI034oU7axlzljeQjxsfGwMYSjM1H18v9tdH?=
 =?us-ascii?Q?dTRiLvbeX5oSvU8usK8yA+CqHV3cXOgLRnCJ5bxMHk1L6gKttMBBVe1WJT+8?=
 =?us-ascii?Q?IIPttXKdE3aiB9M0IIrN8cNtcWumtdsZ62jj8pMxj05U4l0cHIAglEU2JQFe?=
 =?us-ascii?Q?cMh4abfmaqYTGFFDleLsOQIOTsMhSSL0r7SdsJAcNoPw86CLuncXGKyQsMSv?=
 =?us-ascii?Q?k75xZujPWkBHt3GHLyn+58K8QVPLvNdO28ICkdX8SrVZKmXbFde3XV0BTmDH?=
 =?us-ascii?Q?BIvPVgjPDgiH5MVPx+PuH0Exp4h5Bkl2sdClDsi2Rvpq9DZrxzl3c+eEBIjn?=
 =?us-ascii?Q?tPySSFQsBYy5zk0jGvVXnpsnaboTRIOdQ3kz9Xa/sMe5LS20GamzunntRoUr?=
 =?us-ascii?Q?flmPvXen0cwtoU/tJSQpoXYIvVOyd9/F3n25cyopRveEvL5rUituOydxbzmp?=
 =?us-ascii?Q?YLHg3cAYaVEFd4k5ARXNf+17pPn0vUGHrdeEXQoHDOZckJ3PLI/x/fWJBZ4H?=
 =?us-ascii?Q?W8hiFu2McI7bARDjJT9ZPSQCjRTVRWBJXxyJxLvQvMPI7SCogc3ZM33CVnM1?=
 =?us-ascii?Q?7JyJdnj97RVWA1l+8VLfJg1AaHGHaZqXxyTFBhI3+k1vxPMk8s57jYQDGBHz?=
 =?us-ascii?Q?wMFTVdg/q8+dle15/shhqp+aR3El3A0e5MV/5ekCJ7QE6VtC31VldSrGNlpt?=
 =?us-ascii?Q?1UiR/cNZGJgbLCS7VLqrd6WLGOkK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pXV7iSR8EXzX6VYnWpqPXWETYOm0uMPxvPzKQ3bGc4R2ef1RRgoKdRQwMl80?=
 =?us-ascii?Q?Et4217wOxmpBoFph0gAhPFaD2d9r2G/4I3OpNXOoSzPRdx8RwERLcI508JUK?=
 =?us-ascii?Q?9UXHzSsqKs6a78zjk+8w0qIcZiFPfeRI426eQnY0RNRYTNijacNGiayjonI5?=
 =?us-ascii?Q?B1ZB+GLzEKkP0c3yvzTu2gJ4idTBpHpstf8GpGXHvwXYspefcNHJ6IyFdAYc?=
 =?us-ascii?Q?upNijCRtmk/CDf08jJjfJeaOwLn1/EtFNC/T5PtBIj+84aXz8CVr9Rl38cD9?=
 =?us-ascii?Q?X1nJwr0XAA77aecR2D17jyQhlq58ev8xTBblj6wV5ShhU4sruiuGNOB9v94C?=
 =?us-ascii?Q?fFRLl0x7o+DmG09uiRr7cKsad+Hq2V2vdX9gR5V8cgMviwamZ7Dr9/+3yg8h?=
 =?us-ascii?Q?F7wsA5rAGuJ+hRMw426n5CgRssM2uD1FNcTt4rGbwHLypUTbUA4KoeGsail8?=
 =?us-ascii?Q?KBvj2c+5j0q0yCpa/11Xampbtp40vzonhb5CV1meje5SXzX3BPo2WKfvXjYS?=
 =?us-ascii?Q?3b5OBderuQrGUc2WQ4PfwqUNL7tR9GaKf8ajS8LTFBnszw88orG6jGhOaBQ9?=
 =?us-ascii?Q?8ATQEpcrnzsIEDpio8tnV0L4WAtFWeAab+vLGe9mbBYVQ2oBLlDTBK1CY40M?=
 =?us-ascii?Q?F42JbFt4pTYeKyGik3Xmce4ZjPUjmL15LZawGzhPGqvJJXlH0X6ZXBYcHx5G?=
 =?us-ascii?Q?Xxg8qEsMrpVHGeY4c+6VW0azJcUo7fgWKd9QbzvZ+HKVqxh7xG3UjoBo1rWh?=
 =?us-ascii?Q?2Eif2eRfIi/ELQVt4IdzLSTySN16Y7ikrth6gKqSW564KN56FmjGRNj7mK5p?=
 =?us-ascii?Q?quiAFBIj5zS43ovYIoLIXb2ikOXu8ycOZ/7P9IU391gb+x7E3ur8R/48hsKT?=
 =?us-ascii?Q?B4EKWdOpabmkk5BtsLJJSOtMvnfbDb/jumKZ9r0yvmPQlk3Z/feC+TjzS2QJ?=
 =?us-ascii?Q?WFWCmouLTnC0J4vMjTLLaSir0zGb0hvjdRAYBMMa48ltx2X4+aT14w2vh8Bt?=
 =?us-ascii?Q?Wf6VLYGUWW4sryQ1cECrTBMlQDoV055t2vGkK3zi5f3XXHIJnTuI8rUeiipm?=
 =?us-ascii?Q?WIoZu7SNWnBnDfKZ+SQx3SWa+/NqumM38LXmY6aG/wV+CFkt/fRGDiQGUDZ3?=
 =?us-ascii?Q?HbXZnF6KLubj19+UJaOvzDE/zrJsaWX6jVCzgzgdBgJpWCy2Yz+kv1FEpkCO?=
 =?us-ascii?Q?6FP98wMpUe8UIXX516H9emtKj3DyDzneJ4NQC0lwuE451Rwwrd8UY1vE5oXk?=
 =?us-ascii?Q?c/YbepNFz51bukhwhg1Sba4Cy3aJQBY86JXoPbK7uiHKmYxYu3Plxeg2wNgX?=
 =?us-ascii?Q?QSmmas84KqQp0x636mkBeBUNuc1wnZo1Yitit533SE9GOMOcAhr1zJyvzZ9i?=
 =?us-ascii?Q?sAiG6NuKjr4s0Gr2u3L3xn8z0gP4rjhR5q1Tewj6yLp1jgcULbgBysKVgPdd?=
 =?us-ascii?Q?+2jQepA4pqKMijbcyySDCqdIwZNAtzgF9tF28ZosKtHxCTS0ek05RbZOqY7T?=
 =?us-ascii?Q?7KVxzYcbgVJAhfIDn/OBiFk1+49iroxPfu/1n47jU/JaY+rjVWldybzWC6n0?=
 =?us-ascii?Q?wcYF3w5ha19u/tCszaSSGvcqBofedxiP1FUugCjg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8f7a9a0-4ead-4784-da40-08dd4f3bd77f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 10:14:19.7155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ebNTi99S9Ycurq40UuK3J6w+vA3hSFgWH9c8C9lbpxAzLrWH0r6gv0EXj97RiFHCBzXBgJ7Ap4pPwxLeIInx8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9351

On Fri, Feb 14, 2025 at 06:52:34PM -0600, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> Several Ryzen AI processors support the exact same value for lowest
> nonlinear perf and lowest perf.  Loosen up the unit tests to allow this
> scenario.

LGTM

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

-- 
Thanks and Regards
gautham.

> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v2:
>  * New patch
> 
>  drivers/cpufreq/amd-pstate-ut.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
> index 9f790c7254d52..0f0b867e271cc 100644
> --- a/drivers/cpufreq/amd-pstate-ut.c
> +++ b/drivers/cpufreq/amd-pstate-ut.c
> @@ -184,7 +184,7 @@ static void amd_pstate_ut_check_perf(u32 index)
>  
>  		if (!((highest_perf >= nominal_perf) &&
>  			(nominal_perf > lowest_nonlinear_perf) &&
> -			(lowest_nonlinear_perf > lowest_perf) &&
> +			(lowest_nonlinear_perf >= lowest_perf) &&
>  			(lowest_perf > 0))) {
>  			amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
>  			pr_err("%s cpu%d highest=%d >= nominal=%d > lowest_nonlinear=%d > lowest=%d > 0, the formula is incorrect!\n",
> @@ -217,7 +217,7 @@ static void amd_pstate_ut_check_freq(u32 index)
>  
>  		if (!((policy->cpuinfo.max_freq >= cpudata->nominal_freq) &&
>  			(cpudata->nominal_freq > cpudata->lowest_nonlinear_freq) &&
> -			(cpudata->lowest_nonlinear_freq > policy->cpuinfo.min_freq) &&
> +			(cpudata->lowest_nonlinear_freq >= policy->cpuinfo.min_freq) &&
>  			(policy->cpuinfo.min_freq > 0))) {
>  			amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
>  			pr_err("%s cpu%d max=%d >= nominal=%d > lowest_nonlinear=%d > min=%d > 0, the formula is incorrect!\n",
> -- 
> 2.43.0
> 

