Return-Path: <linux-pm+bounces-15824-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FCF9A1974
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 05:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48ACF1C2186E
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 03:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E3841A8E;
	Thu, 17 Oct 2024 03:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IeHXXQEu"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD285C139;
	Thu, 17 Oct 2024 03:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729136839; cv=fail; b=jYDL6+JBahS8H02R7DeGfIfUkGZSh6pRgGBjhOvrhQSghn4RX54I3+Ow/fX/YNMWcX3Ppa0I5JYZ4nw4OReLTh/10f9QTMf+73LnBYsW8Pg8vHt370O/1PcCDZTz9DxcS8fRG7ZCIztn9E+V8Tr1MzlfW9s656HOLHOOF5AaLQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729136839; c=relaxed/simple;
	bh=cBPosmdHP2WhRGunPGVsY9bQutBwy/3h8Z9B7rhtJw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tgsL3nJgWuOoIKHZhfntTXI9QduNfF1KvPmrVVAz2yaR5hPq+m9IDszXzJe/0bwCEV4+f1TSIvVI8IAVLQfE6fVqiRW7v+QlMadKbHeXf04LHUaSlsrHmk/uE/VcPubiYTIfSk9isXfEn76dA3JqxB3OmknHNflTKsyvLRsmgkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IeHXXQEu; arc=fail smtp.client-ip=40.107.92.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=igcv9hENZnOFNtE8plaUt8+ySIbwgBa9kfeWlMSVkCl0AkjyyikIw0OFinOzdX2lI5jg/EvzA/v5Vie7/Knfo3bqhSY0nZ7tyETwM41GVMJs3sHqR7tiQpbn7qihvxXU4RMjOV8J2zcZ0ul5KK0oK6hB4PqW/jgbsiur7FyOAi8CAORlL4bOEJpuM8v3mYRvxlHAweFYN7AZG7PIk4HaWu2etZ4eEs3bz/k1lsvu4MRjutzUs9gb+8Qyuc6btYWMP3AxAtz4ub6TAouLbHq5FVf0YYTmmst+Nq0ryQXD6YAudyfvHXByhnPU3M+Ukfcg1MoYO1TtzDQXfdcsywZ9dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BGGGJa3RWMPCmDPMFilAjcojvPgYpF1SNplsOohzcts=;
 b=BXTLd6MAqAdGv0KvJnSwgmkuaonPfDg5jzHAK2ljSmGVL+M0ZNoNnUo2KXrrKy4Pmn9JrpevX8BYr0n+4ObDn0eEVwKp+jnCMuoXmk+BaD2dv6R2e4SVTgUOzpnOulkQSEoUlFACLFYZis1EHzSeQI3DvipbQyJ+HSAwdTFP9Mn8mgJkWaG1QyKdra0A2OIC0KM13p30/u3cyIh9QI5gJIWB3Vos77ge2kOUF3VIg1ddwikzDnvzaIvVjT3xOTWq86gl0Sya7sHhThIS5I8Vs8ru/Hm4PPcrN0zFC30IU6EAHcy50jz4/d8CHdBm0mP1DKXBoqpRncIqye5kOQBLzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BGGGJa3RWMPCmDPMFilAjcojvPgYpF1SNplsOohzcts=;
 b=IeHXXQEuwhLibBHqTYaW4bl+8B9duCRaczrD8og6xJ2fovEaYsythflufa+srOxVcCcSMRPWtnOz8FfX683oVDdCYeWxYcuK5aHonxERNUk+ZbQOu59yoMHdCGScZQcAkuGc31lg/NnRmR+Jq+TVz6X6Z9SSb4xnTPEPatDvEwM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 DS0PR12MB7680.namprd12.prod.outlook.com (2603:10b6:8:11c::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17; Thu, 17 Oct 2024 03:47:14 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%5]) with mapi id 15.20.8069.019; Thu, 17 Oct 2024
 03:47:14 +0000
Date: Thu, 17 Oct 2024 09:17:05 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Cc: mario.limonciello@amd.com, perry.yuan@amd.com, rafael@kernel.org,
	viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] cpufreq/amd-pstate: Remove the redundant verify()
 function
Message-ID: <ZxCIubbRWIWwMLAH@BLRRASHENOY1.amd.com>
References: <20241016144639.135610-1-Dhananjay.Ugwekar@amd.com>
 <20241016144639.135610-2-Dhananjay.Ugwekar@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016144639.135610-2-Dhananjay.Ugwekar@amd.com>
X-ClientProxiedBy: PN1PEPF000067EC.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::28) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|DS0PR12MB7680:EE_
X-MS-Office365-Filtering-Correlation-Id: 23ccab5f-901f-41cf-6060-08dcee5e62cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6DKuddOVvWo+noDmJvAjmPtLDa51cEwuOVtJsaoPR5gmUBq6zgZBRu50EI5v?=
 =?us-ascii?Q?Uc6IOC6JoMah8YOVkCXhHSo0JOAs6cN0Q8DmQeWdIGEeAiMUViJvjVfKicpA?=
 =?us-ascii?Q?atJVmTXxc/cKTQhFffi5tLSphYqnQiv74dgTjlRsqnK8Ucv7vRiiLj9bwOg3?=
 =?us-ascii?Q?cV/zW9GbqL76rDRt2rfzKbleRJVtT0fbmL0svPVqhU8zYnvchZLYduP4v83W?=
 =?us-ascii?Q?TKAeie09ZbgD8q2Nzxc31bsq6nxts99AM0RZYSIKa7cTWEPCMOcOkh6uauce?=
 =?us-ascii?Q?T9Sb5nv1iduiiuineX9I7+H1f1bf2Evh8wS/fEWFxv6w0yQrPHhb+xJ5m6Rh?=
 =?us-ascii?Q?EAA9rxS2DqZZeaTMTHesLmW9N4g6iHcD3L7LktwkSc92Dg4ITf1fQvPEI04S?=
 =?us-ascii?Q?mZVoK+RXwjR4/SCZs3HnKB2BticzqHu++R+U4ZFFrPjL5cuHoe7Cea4JJmC/?=
 =?us-ascii?Q?kkO6/aD2UFkj1J220718s546xUN7/ZW5NaOwFOwkQl8RelvJWIaxJj8MrYxm?=
 =?us-ascii?Q?lDgwY7wg2fUhYwHJGL6HnINUOjFu6PGgArIdpc/rjLtYDz8NxFc4usUhfiV4?=
 =?us-ascii?Q?vCE//62tB8MFjZHO9YXmOdKV8Wwz/BNt+Pg/XufhsCDE1oZUwxEIjr0Gdnos?=
 =?us-ascii?Q?zqd82SxXN0B5y5W65s7Rb7OHxHZ5C1A6Bd+jv1eih3otNj6CWj0p5CyYoce4?=
 =?us-ascii?Q?QBCf61FOTlyL1u8vWImpRPdlvFwZlgsemWX45W7Qjrq70w9EPwcK/3hjVCS1?=
 =?us-ascii?Q?OalrWQlkRKS/4+QelUKr13oLIo7+LtP/07sufi/tuwbwZT3/d8J56QnTO5+r?=
 =?us-ascii?Q?4d/fMWwIUAQje4Z4tSx4PhmrveIh97Cx5D9woGt/kRznT3V+LwxZuRBO8FOA?=
 =?us-ascii?Q?/hKmdVapykbeacFNi+Hq7a6iRxXHUNMNYdDfubP6n3Oubswg1gnnR/2kHePl?=
 =?us-ascii?Q?o1VZ9FXvcHiMcZa8pvpMJYms+/x1iHAJQNjma8CpBYCfEGrcW4Jr9mroHscm?=
 =?us-ascii?Q?yWZkBbViA2gOlZLiiL+v7LuWinxZcVJMQKtm1CRoz7ozXEVHB6dUremp4i47?=
 =?us-ascii?Q?lNNuFe3nQst9CqLX5DuVqv5ijm0ad/IUZyjFo6EXzL62XxS6iG3SNlTA3cdm?=
 =?us-ascii?Q?yp+/eUcAHrsBr9O3/M9Kpgys5rGYywDaCMyQEoXCp2cZlmV770WsxLqWXbiA?=
 =?us-ascii?Q?ZSE8TaWQKEOt7OYifvRo6fxkP2wk88en28Rw0EKRlBBZuoXQoHji8a+yytoV?=
 =?us-ascii?Q?+/9khHx1iigVQrolXykbr5ZAJged86DFSXFdQ8R9N0SzCh8k+6QiczUDOaO8?=
 =?us-ascii?Q?8ZkdDNafFFzLxWAbcjmVrtkT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3L5roaz4qRUXfKqSEY6vKXxuTdxwlhyh1ZMpFibaFmWG5jALjO+EF07N3g8z?=
 =?us-ascii?Q?GBJ44rCnwQyau5hgPoWogJLmLkErUN3+oxovAT6tgMSSZZ9Hp3COCw7oo/hW?=
 =?us-ascii?Q?mEL8t3moWXvD5XfPoZQQURIKcMo950Vetsdci7g/nFrt/DfMsgVi6KHoWK61?=
 =?us-ascii?Q?ZZEBirXj047rjEi950FSgVMh75sOFF32hCGWVLvQ/pSF1e99FndSG6VCAx1a?=
 =?us-ascii?Q?MZeaIjB2s4vq5Ld0IVerJbPsuwt6Ew1BzZdmce/R4AJiVXERb0ru0aQZsDIm?=
 =?us-ascii?Q?G2I9nIIS5ovSpSgyCxTKrYKN6mlOfr2qP6uSpO/AOyg8jQ3b+piEQ3cBb0xA?=
 =?us-ascii?Q?Bx4uGR/dydzNi5tdiH/jzDR+pjjSeNwETg8Zx6xRgXi6YgnFlT42rqq9gdIm?=
 =?us-ascii?Q?y0ZUzQhlpWz4TkP4+8rTAfSGw8/fV7hEQdo5T0GrTdXGcPk1p3QCl5naihb4?=
 =?us-ascii?Q?UrmQmJHOBwSV/P64kJ0gv44cklMRhnNIJgtWweaOPsJBLFMN7z6WCEZ6VWYn?=
 =?us-ascii?Q?mjheYQ2EuEonyrnLwBLO6qI+2DIP/Zoo3CLMiV6UlHIrJ9pjteOgfvP3rZxu?=
 =?us-ascii?Q?JzbjL2CgCvLLUrsjHtVwluvq2/W+/IRj0/SeLUDla3rz3oEAUdQFmV/WWrsS?=
 =?us-ascii?Q?aBtIuMaCwRa7p67VwaWMDaz+gHHQxmwLydt+GQ3ZrVbZvNPFiVjkQvXkTymC?=
 =?us-ascii?Q?eMkXh6LAB9uofJr0agahuLWcQRPpPkMo6mODQgr0eedNPn2OWtY6lMZfvxnz?=
 =?us-ascii?Q?mp8cUAm8yziFfSKGMqJxARsHtTNyWwzUt9Z52376GwLJ9Rl8kSyMD6QQ9PgU?=
 =?us-ascii?Q?JR1k85GXjJ9saxzfAYVH1n+nbcTV4swc4uy79q26zwQPLhzmkz67qlTkivac?=
 =?us-ascii?Q?i2Xf3+mmES0JfH9xsGxkZ5WrjqSBocxZgA2cwxD8n9RjS9jH1v/YfZrJi1O7?=
 =?us-ascii?Q?cnk4nxwGFFLDfX6leLomJU3XQjOIudzXCkNh2kWaUTQlzqMpext/7xFAtZZk?=
 =?us-ascii?Q?QnAw7C/8Kbe+fqIRnoEFtkMKHhaKO1PsYvHBHXWYOkNgI81L85Vk4Oq0q3z+?=
 =?us-ascii?Q?OwjPT4e3gQ6GVyLPvBzBjQmfa8XwaVpRgLb8XBL5TAKi9NVVXrr7tSSTNvBv?=
 =?us-ascii?Q?j523IsRELiBbCkokwkUAqpwcxKducjTwoHtXid6/6T1j9q/CimsmkoHAUBAr?=
 =?us-ascii?Q?1/NGjM+PdUgfH5vdflUU7j63F3yiS1xtWlzQNKvOwQCsm1D5twPRDPjff6KO?=
 =?us-ascii?Q?fEf+kdToq91E9uyB1mn0e99lbJon/r3L6T85K4Skl1eoy4wAabc353QZwjae?=
 =?us-ascii?Q?F0Z3d4b948YaO5k8dAuvqAuEO/LuUu9/Q28rL9Ug1bVya21PKbbxQ11MmSWD?=
 =?us-ascii?Q?+hiqCcHZNR+ger5Ot7wwrzKZWLs9So+ywLygrQISI/bCPHYv0Ml9gMfphcze?=
 =?us-ascii?Q?PpCFrraxh9AVLE7EA+0p2CXaOpS0vgMfjAlyJL6GiZcAwiW5GQ1LB+zCNFzL?=
 =?us-ascii?Q?ZDQNY9U7HUW/edTNVHSZtXUotdF1KW4O3csvu32OaHViLgHpVcIH/qxsFvy0?=
 =?us-ascii?Q?+Wo7ululBBXd/F7XlnHvThx1bTOFq3UFNpsCPf/p?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23ccab5f-901f-41cf-6060-08dcee5e62cc
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 03:47:14.0917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JwxcvUWw/6+RDSQIAWl3FdRXTAs3d3ENTh7qAtr5egcu2og2+ueQoALwmDqK1xcmptXAxSU+UylU/l+i2hkyYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7680

Hello Dhananjay,

On Wed, Oct 16, 2024 at 02:46:40PM +0000, Dhananjay Ugwekar wrote:
> Merge the two verify() callback functions and rename the
> cpufreq_policy_data argument for better readability.

Thanks for cleaning this up.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

--
Thanks and Regards
gautham.

> 
> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index b7a17a3ef122..fa16d72d6058 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -527,10 +527,10 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
>  	cpufreq_cpu_put(policy);
>  }
>  
> -static int amd_pstate_verify(struct cpufreq_policy_data *policy)
> +static int amd_pstate_verify(struct cpufreq_policy_data *policy_data)
>  {
> -	cpufreq_verify_within_cpu_limits(policy);
> -
> +	cpufreq_verify_within_cpu_limits(policy_data);
> +	pr_debug("policy_max =%d, policy_min=%d\n", policy_data->max, policy_data->min);
>  	return 0;
>  }
>  
> @@ -1661,13 +1661,6 @@ static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
>  	return 0;
>  }
>  
> -static int amd_pstate_epp_verify_policy(struct cpufreq_policy_data *policy)
> -{
> -	cpufreq_verify_within_cpu_limits(policy);
> -	pr_debug("policy_max =%d, policy_min=%d\n", policy->max, policy->min);
> -	return 0;
> -}
> -
>  static int amd_pstate_epp_suspend(struct cpufreq_policy *policy)
>  {
>  	struct amd_cpudata *cpudata = policy->driver_data;
> @@ -1723,7 +1716,7 @@ static struct cpufreq_driver amd_pstate_driver = {
>  
>  static struct cpufreq_driver amd_pstate_epp_driver = {
>  	.flags		= CPUFREQ_CONST_LOOPS,
> -	.verify		= amd_pstate_epp_verify_policy,
> +	.verify		= amd_pstate_verify,
>  	.setpolicy	= amd_pstate_epp_set_policy,
>  	.init		= amd_pstate_epp_cpu_init,
>  	.exit		= amd_pstate_epp_cpu_exit,
> -- 
> 2.34.1
> 

