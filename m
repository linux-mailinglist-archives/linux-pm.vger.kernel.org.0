Return-Path: <linux-pm+bounces-22199-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4467A3820C
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 12:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE4F23A75B2
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 11:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93B0218E91;
	Mon, 17 Feb 2025 11:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cqHv1XRS"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9E721B183;
	Mon, 17 Feb 2025 11:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739792308; cv=fail; b=ESsIu2VGI5FUGYvTqq7fqho3B8ChN9fEjqLiJ7T6XBH0d8ZrWDUvcsZbu5CM8wSJPpp9NDQPA2m8zGSy8CEHtpzf3lLAyutNYu2ccmesOdIwllzVIGIoZnyu+UjTWyecLhSEm/ZZMNckuLMr1hhS1rwiMYP+BBibPFYA322m5bs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739792308; c=relaxed/simple;
	bh=fp60hMV8ONakNer2vgV8x3KT95ZVtipvjG9aXB3yuB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=M2uFSJCl/4tRbPgCX8oD1WQCfA5ySvbKoZfwdONF6YAAONnGkV0F1E8BsVJBYIMbVLkC/3cQvTzQBoplnGCs9+OmdKRJiNacqfvz+010F9NeOcFogPkrlpsizvw+8X0XlXBSEZszdMSLTpXCahiQwYBls/dCg8VbPvJ9IWxttk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cqHv1XRS; arc=fail smtp.client-ip=40.107.94.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BBc2SMkz57KCIUewHRA/Hqt0j457HhoLyszHevmcXL4iiJiZcvYCOLhocnHLdvFAwk1hdzqmhWL0mwZBens+SKTk8WqZCiiakHhUbI6/SxuKf8rqmhzs2pLFkIW4m0WO3Zy3CW3vwxIYulGYdwGiAgbtCBu0CwIil9ppoc2KguBPaONbLOd5VXeEPWIghBzI9H+lFz6OgODqavzCmtPfssGiNhqnj23FfNamtnfGgL8KtpZGB5JefL48dZCvx6hX8aSXGOR4z/oXZEG86HDvNhlzFMvgt20BdGRl/J4GN/9BwJL/vF3efEoolO9e1t56Idyv3ir5DJ9kEuTpyPZZ+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JCwcrhbDp+BPUyCOahc7/NTgWr2s0S7ISYi5X2fnsEE=;
 b=VTdywQhZwva/3yKgQTU9hDpFW4jthaoTuvXlHLvcQz8pvk6lNb99kzidr/cQvof/ykoZFZuMOgcBwwDlfTicLtcbgqG9Pj1HFSnYxvftRcUBvCXk0ZOGLkuHB8R87Rb+IB6xc29dqLNa480Nhi0UNeETVlmfTvB6uAQ6JF+4tlcfMDD8GfvT9iqrZs7gUy8zOBuLDt4ofKMBmGILnM2HV6QwtxEpzfUlGwWSm60RATIEZEdeEoe4RQkb+8wO4Gun24JKs5BqfUOhy/M7fC701RRJ8owQ3uPYKd1zC0FxwMC7LEf4MrvJ77U4f7/ee+Y01tbQdkNs91Y+QeTVmQ/pGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JCwcrhbDp+BPUyCOahc7/NTgWr2s0S7ISYi5X2fnsEE=;
 b=cqHv1XRS5ULvHP/Y6T6iZE2PSG0onWSRuzmPvFa7I4f0/+4hNZ35qVxHupqsJ9Zf5cKhnPcYYOHg/TLthRH5ayR6gPgBLkVqzvWiAGB0T75Za1QhdAVgIMwp1CGrPyLDKR5pMLqJ+X8jFaSajmKLuKG5lLd56whQ3efkk+fC5LE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 PH0PR12MB8128.namprd12.prod.outlook.com (2603:10b6:510:294::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.13; Mon, 17 Feb 2025 11:38:24 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%3]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 11:38:24 +0000
Date: Mon, 17 Feb 2025 17:08:16 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: Perry Yuan <perry.yuan@amd.com>,
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v2 09/17] cpufreq/amd-pstate-ut: Continue on missing
 policies
Message-ID: <Z7MfqEB48RqD7tuZ@BLRRASHENOY1.amd.com>
References: <20250215005244.1212285-1-superm1@kernel.org>
 <20250215005244.1212285-10-superm1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250215005244.1212285-10-superm1@kernel.org>
X-ClientProxiedBy: PN2PR01CA0229.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::11) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|PH0PR12MB8128:EE_
X-MS-Office365-Filtering-Correlation-Id: ee59f2da-6fdf-4124-bc05-08dd4f479659
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u94jjx6iU24IljXYgAbGnw6Zjj/GxqPYcJaN2Rqhp4eKR0aFVk983JUgz9Kz?=
 =?us-ascii?Q?ZVsP3IOIWKTSxgk9v3oSSJIrX2je/HbWompqBhjb5PGQ9XA5h5YG5cnmuWWw?=
 =?us-ascii?Q?VHOA++QRtLFHSxJZtGFDPOdwE7Z/n3xHadBx6OQs+TnA3wwUEIbcIiIKPXXS?=
 =?us-ascii?Q?NjwFKfGSoXaE2HAMgAGFMG0OXi7Kq5Z2MSG8VQQd7JyPFwzPwafVDvNm1Vh0?=
 =?us-ascii?Q?ahYTxiYlAHtYXg6bhbfFPyOc5j0h4o3hbN8OsnyckSt3idDoUNoUOJb9rNUb?=
 =?us-ascii?Q?Z8PzmF9oqXEG1I/R/eP4UPc84sM1Iu/07Z34QoHtUq2IW0nrvsJf1mtikjju?=
 =?us-ascii?Q?q1HigGzvrbgLcQVrNBi/SctMBFalymunn7H1GbToMoLousx3fl1q746FrjgK?=
 =?us-ascii?Q?NwI2pD4eDfeYLEtEiKUIVvEvTKor9zsnWYCGMtcLiWZzoPM3ydamk2YGx/+9?=
 =?us-ascii?Q?wzGx8jFPSnmNNAI/58P3LCAUEWs6312STt6uf+wJw3WpAiOJBi4USgb2QMW2?=
 =?us-ascii?Q?aJIRyiNMlcDeyAz8PVWUBbwPOh2ICpP0+GDic89sy5o+R0RSLF86z0c2ZGEm?=
 =?us-ascii?Q?8j4mI0C+DvlpTPIBS/hnNYGUxNr/jf3USSuHCyPfkZBmsQ0MWREYolOyPgI5?=
 =?us-ascii?Q?Hat8j88RtLjqDYAjf+kpW5z+mJ/IFyO7UZZv7+GDVrU2yz39gN1Tgafb5YeK?=
 =?us-ascii?Q?cTwNB+Q/c31+GGwHAAwdBBLalcLJDo/heYehTwC3eSyKFr9cpclVjqvt5SUe?=
 =?us-ascii?Q?YdWFPIfBDzJ3u8PChm8EB35kDxqyk4e1joEbljmBxNkdQwICq/hs+vscjr2e?=
 =?us-ascii?Q?qtXfYPSIsysQdy0QKu1p4kvahtDDfVp4T2Md9yZnanLazwTjoJ6/x0UvDrpk?=
 =?us-ascii?Q?om8t4HJAKxBkjXkqpfD5uBQm0QUdN3Mjx+zWJDZx14/fr+BSv7XlBmMDe+dr?=
 =?us-ascii?Q?Z+Jh/IhCidNGOJIAxj9VA4tLS7ivHAnC2K2YLGonIbAZjelc8Sv81ALPNPl9?=
 =?us-ascii?Q?D2PwWZSDZQTjEUNKDL9mCw71fVQJ4Z22GOokjHr5SczIwPVkHCu+pdoNL8F7?=
 =?us-ascii?Q?2ICEOeJIOnxXn9UcZue1CcVVD2hzv3yr+k2rfPIsWuD18U50LwkWEuGwPw8d?=
 =?us-ascii?Q?ciViVtgpT4jbO7g99eX4kJtoYDEZgqvLhhqg/eiGrZiCp29nZXnrhQSP0LJ+?=
 =?us-ascii?Q?/BHY9hIQ6tJAW/siM2HDYGcn75TFH9Pp8/pZa5IEngJqLQKrRxAgWK4CoUPj?=
 =?us-ascii?Q?kym9WWxwsopM9crJHW8dpPNcB/sPbfQ8ws9VkGJk0HBZmhIBETz2ydyrH3/l?=
 =?us-ascii?Q?nfOG5TK9cDQviXFIF2s3PgAX6rZz6vDvRFt8Y5eeOUSEhC2Bam3+f2JBThwg?=
 =?us-ascii?Q?NbTublxpCPODZiJ0qotuKbeQ07OR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hee5Pgqe0dO/HIjclBY1R5DX096rmiSP4o5I/njYGTX02eIlbiRUoUPEBL/N?=
 =?us-ascii?Q?3QCQN6ERtLCgMgzSx+pipgyctir4w/ds1NaPfP/Yk63D7P3xo7bFt+sQZ6jU?=
 =?us-ascii?Q?DheV53+MR7SfjxyZfTnYXeyAfeY/M44Uqy/wccN7JzT8fV4u8wZPp3ZEm1PM?=
 =?us-ascii?Q?+Lz33ZphO7NeYQ17RmZwfQIN/X0Rgl0DXYyOmEXksJpvzhQNfJ9qITDRJOtU?=
 =?us-ascii?Q?l2RCLpfbngBKuBxPcELWHN95+nELAIIxkrfBFWUEymEruZsL0IfP1/jevG0o?=
 =?us-ascii?Q?HnktMusOCcnNSNoLh8x4Y3ekNOZ3fRNktSySxSYHB1Xd3M8S/lG06lztypCe?=
 =?us-ascii?Q?JIOf+uqcbwXhLQy24yc809JMOLKfNlfaSnvUrVAakmK8vCNO4Os8pvzdb2E+?=
 =?us-ascii?Q?xK3FT94bzIJVwuPDS0WZjKDAQ31B7I1q3E9tguMrzxixnHBQwhXKvSjn2aKn?=
 =?us-ascii?Q?GB3Yy670aK5mzIFtUz8TKSIXzMGVA9hD9/8AOdUHVCQIQdw3hQdIAIw5TdDx?=
 =?us-ascii?Q?4qGY5S2p9g7pBkmj+m/oH13aQI+U0wGILD3RftjQsmmgWnOO/Wb4GiDpLH5W?=
 =?us-ascii?Q?P4yh+sIK12TVK3MSnQNKvJ10jPH9Ynxu0QbgUjubBoPAKTqoeI5F80L9yYT8?=
 =?us-ascii?Q?jKBf/6IcXLjhuqp1K3LmXYi2iHwX6A1LEiVclCjLHyaAvZKAr+9Lpmh4h8mk?=
 =?us-ascii?Q?1om8f2vUu9srTH6qvj/wcT6W4l0kIPMWX3IXCNN7aWbgh3h6tBSJ7uS2rKmw?=
 =?us-ascii?Q?TuRdOS2QwMwpQbriOJFfK5lzSPb7HVdoe1uN7wPYTc4f1s1bWdtuKbEHZOba?=
 =?us-ascii?Q?HCiKqoN6M+kgXAq/KBVhUKoWAvssoHLZuSYnPkjh/kouTUczGWsOkTHVqHmT?=
 =?us-ascii?Q?vAEYnRHUgjxJpZmSojgnt07ISyiXPt8K7Qe1o4weTSqGswITleXCukZ0v9S8?=
 =?us-ascii?Q?qMExS1lZoL8zhMDT+RVCNsuOeOJwTYju72ykHXXIyL4LXh91WmPBbsqixDUF?=
 =?us-ascii?Q?vJIDAA5+1xqsF7+uOaJ00RhLV/cQE7sAwYnyA3PqCLHKRa8fg4bPw7fjPu6o?=
 =?us-ascii?Q?xLhhxVjc/P59l2JkDQYvGOJF0swuszPrLpo04OdGbE363Dm3gU5Btui7++SW?=
 =?us-ascii?Q?jN0g8GVfALmiOHKhXuRaBxvYgpEa3hvc129OOvLjCWpgA4Zg+KoXMHW2EoGE?=
 =?us-ascii?Q?i39BT+rxYVOo57dt922VNB4b9OTvAksYw/lH9GnZTWO0Va1x8kLDdAGwa1N5?=
 =?us-ascii?Q?rBWijqAneT02OweDdEViutmnBD+RIpkfG5hNCZd+lWRLUQKaZk+MOQjvGkPO?=
 =?us-ascii?Q?dtuluyUnCMK9eXIPIWG0WTmzLMyaF3eMkWF0EiPR3couNOY/Djn4WMw14rGt?=
 =?us-ascii?Q?m5Kza+QSpvmCjE6Fz/GyFoI6TaGAS+owFcGF0yT0eYvYLJ3YGpj6gqFVHmVJ?=
 =?us-ascii?Q?N4wnE76Av2SJW05y+NCe/ON+inczMx9YWDOn7Z6YAimB9cYwiF+Oi+NQV2kD?=
 =?us-ascii?Q?cU8YHnCQGdPhIKa+qurrG/IwvHGeY483fFB1woyOiswdD54nQ32nFyit8jAt?=
 =?us-ascii?Q?jUAR8rkHKq8DRCanGOceppPlFYHmPlPqFyo7eMpc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee59f2da-6fdf-4124-bc05-08dd4f479659
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 11:38:24.1257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WFIFGMDFnvqBbGJU7WKxUcGZ1Y8iCljwEwVIjkFUtKwBEftK6kICQDGveYux2LmYdtVxpUBlnk0Xd8cQcyl16g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8128

On Fri, Feb 14, 2025 at 06:52:36PM -0600, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> If a CPU is missing a policy then the unit test is skipped for the rest
> of the CPUs on the system.
> 
> Instead just skip the rest of that test and continue to test the rest
> of them.

Along with this change, does it make sense to only loop over the
online CPUs instead of possible CPUs ?


-- 
Thanks and Regards
gautham.




> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v2:
>  * new patch
> 
>  drivers/cpufreq/amd-pstate-ut.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
> index 028527a0019ca..b888a5877ad93 100644
> --- a/drivers/cpufreq/amd-pstate-ut.c
> +++ b/drivers/cpufreq/amd-pstate-ut.c
> @@ -121,7 +121,7 @@ static int amd_pstate_ut_check_perf(u32 index)
>  
>  		policy = cpufreq_cpu_get(cpu);
>  		if (!policy)
> -			break;
> +			continue;
>  		cpudata = policy->driver_data;
>  
>  		if (get_shared_mem()) {
> @@ -193,7 +193,7 @@ static int amd_pstate_ut_check_freq(u32 index)
>  
>  		policy = cpufreq_cpu_get(cpu);
>  		if (!policy)
> -			break;
> +			continue;
>  		cpudata = policy->driver_data;
>  
>  		if (!((policy->cpuinfo.max_freq >= cpudata->nominal_freq) &&
> -- 
> 2.43.0
> 

