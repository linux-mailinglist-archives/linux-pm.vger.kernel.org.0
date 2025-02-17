Return-Path: <linux-pm+bounces-22190-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE824A37E2F
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 10:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8569D3AAE03
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 09:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4E31AF0A4;
	Mon, 17 Feb 2025 09:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ORarUfoW"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF89D1A8404;
	Mon, 17 Feb 2025 09:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739783534; cv=fail; b=tbQkOvMIeutKSx0OvJD4hLDlvsY3foTYUJLK2Tp5Dem/cpfdcF7lvPek1YPWaQaifZev34Pt/xblsW9uMboDHAb6eJnWMmfEKZo/VseeidmYiRiadSE2bjYyJVxMJUwQYyaZDfIH2t6261flyL4kYTotdRmiC5+IbmPvqDEWT+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739783534; c=relaxed/simple;
	bh=RaOU8pSgQiM+RmQ2q+iQouPFGEALkuQijw56TYDaBrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=suXOZty+qgtKQozth+jzLX/cDft4HP4AeNgDfW+jXvHl/NOv9Zx7Bb7s0RSPEtVcQJ04oHA0tzSg/lrMV3EAgH/icR9iaJrqIhB/PoQ/5kB1Emfd3syK6IyVXlyZmAP9bN/rgYW0BWR5yJN9M5fuKeJ0ut7g9iTfjv5H1lrXPwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ORarUfoW; arc=fail smtp.client-ip=40.107.220.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=thFXza2/PcEmhvxYfjqfAzxQYghEWg6ukHbl6VCw1VyC5+2HuzjQfun3av0o01vQ8o2kcboxweSQz3y2kGUN+oQVBJUcE3ykq51+e92VkyU1AZbcJyGeqkCBLZtp+bCSXfwf2K0yqs2ZhvE0pOvNgW0s6xdKeOvNzdsRFwAUF0a4qi1OcEfY5bDyM92tt2OtfVIh095FED9YIF2GFLH6WFumwzWD6SAwCnXUo66brDmn8sfXpMU5+doAKCoy2w8ZGdCwDcQPjVjKogmtLaacK34JIi1ekFiCrjVsl4JXdQ7mfki+G9y7VHWeX3NAM2yK6VURw+GguWEEohtItQxtog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mtjSc6HkvS/vueLpceADXpqLAv5WSQZbxJs8orLiANA=;
 b=Cka4i2Ora2LQWYb4pCGNezCiAYr2UlTuKb5Vtb2ms+yNtnfjM/6GCoRNTIilmUSGQj5ROiAU+tnZKjSPdlpzXKsgy6FAavYD4ZSYHw/v94hGjVqyyXqcGbYt3RQ2jnWn1xqJ74cdr/FzO79rB8MqusJGeeFlKadeRfAVT48/QfirUzanRhwCKSpwvJ8E4FLtqs93bYu+4U9Mz4Ye84ZbK5cr81tfOefiNMHMP+LSioxPZxGNYwLkAGS9VgkRJBIBWG8Onz7qJp5AwZPHGq9tT+/WlPf16r8d0qfFA0y2RD3/zYeHL/dOperXPegufBlkB5BNtP5MsCG1rm5vQEyWjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mtjSc6HkvS/vueLpceADXpqLAv5WSQZbxJs8orLiANA=;
 b=ORarUfoW9lCAVlasDSiAg8Cvy/dpTFxmuKhPM1m6iBEhkmOr8gU0iVsnVObUYudRk5hJLLuLj6JWUWemoQHnRDbt8L5ucuTYl7nDAev4wxB8P8nUqmaavAZv/xaoGfR9aG2kfxUE9wfktLTrM3bXS4xkTdzytWlH8tsvzr98wx0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 MN2PR12MB4456.namprd12.prod.outlook.com (2603:10b6:208:266::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 09:12:10 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%3]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 09:12:10 +0000
Date: Mon, 17 Feb 2025 14:42:00 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: Perry Yuan <perry.yuan@amd.com>,
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v2 04/17] cpufreq/amd-pstate: Overhaul locking
Message-ID: <Z7L9YPhJ8f4/yCzS@BLRRASHENOY1.amd.com>
References: <20250215005244.1212285-1-superm1@kernel.org>
 <20250215005244.1212285-5-superm1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250215005244.1212285-5-superm1@kernel.org>
X-ClientProxiedBy: PN2PR01CA0125.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::10) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|MN2PR12MB4456:EE_
X-MS-Office365-Filtering-Correlation-Id: 56a2e3dc-ce23-4b2a-f078-08dd4f33286c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HVn739dGWZZFDgkPH5fJx3utIeNRsRjSs9CE+c7BBEGmit77Ghal/PLcSNVa?=
 =?us-ascii?Q?KVcoIgjRr5BBzDJPF9RoYRSeW+WoLe9aXu+LpNYUgih4nb63O8wz558DFoIk?=
 =?us-ascii?Q?eGo/klism/N6vTxue7Z2urU94PII2JEgwpzP3P1hg4J6Y6hj/PrOC6S7Z8Do?=
 =?us-ascii?Q?eJNacccO5zX8GIfElnERJPo3hSRaR7X3p5ELzbr1bXa49z0/i+Za2z32SDHU?=
 =?us-ascii?Q?I3uy/EH5gvysL5b8cUgrBMGtk++R9LWcga7D3iRFFqDMspPShwb3SDKL5dAM?=
 =?us-ascii?Q?XCzNCi6fkWLYIwHVVY4ZZ8LSVxGcoaXb+pR8AwNjxZCnQGHTQbJCn8/Iw7w3?=
 =?us-ascii?Q?1CCqXIjJxgyQNGcUgEHJZomBPRcBLPT66GD1aSZ5YqIlc0Xpm9l6e2Dth4kr?=
 =?us-ascii?Q?1wXjBMAggguTs+z7cLgONru6X5CWc/5L1rXi2vo5mCmJOJB4IC6NyUOyd51l?=
 =?us-ascii?Q?Y1GfpBa6urnarTHqXdFuXDJSyDpHnL4S3vyZDx4xBk1f098m/z1R/5XH/qJj?=
 =?us-ascii?Q?jx8GD7pwYEiVfHEG0Gr1yUYDAbMffeIWP0up94Y4h57uoNA36pPG8zmHGsvB?=
 =?us-ascii?Q?DVbpIh5hDCYXZ/TwjGbZVTvP5oX25qHgg6nSRwqbRSz/3xhh2h5szAiLSRAQ?=
 =?us-ascii?Q?9AEp2R4QUfcrDOAzCf6zHyPgEVDu8hwjqHI3L4IAGhCIsz1lavUILa20wxPh?=
 =?us-ascii?Q?nKqw6YY2H1UvhNuhX2NwqVSv7ucXUvMiflZ5cYjzoOVEtUMI3rNOGha3keZA?=
 =?us-ascii?Q?rItNfyUbdnMkGU37Nv3ZZiejm3EU4BXj70sgei4VQgPjYFRtFfePsfwuNovG?=
 =?us-ascii?Q?2UUkRcIu+UJz3cNcW3ggdf6zBkhyZ+qxK929qxB7e/pJJlds2BSVuBIElT5w?=
 =?us-ascii?Q?PspMWDFSwPi+foKKnQXnR3aTnIeoPlK2xw7tknQGSGKlQ2qeTMtSmKt83Q5J?=
 =?us-ascii?Q?PZaJNc0QPT6s55ptR4KMMXu7U+Qx8rGNYx+jsDytErTvYXTu2o0uiQaDODSn?=
 =?us-ascii?Q?KqhmpCQjj+LDSWZj8kuwyZkKYCYifUsKZm9JkfffGdrMGJwT1YimK0mG7Ez+?=
 =?us-ascii?Q?YhFaXeChuAaerolI8CcFS0lbWxAZw+4f9abw5qF8NaLi5fdaTNmTPlgv1q9i?=
 =?us-ascii?Q?IHBM0/NAhH/+2u2XJAJB9fofEP76GB/dXgJBJWAFsiFFFqkYVX3C0lFhQ/eK?=
 =?us-ascii?Q?0JoI7CiaEDEqHbBmIrE+zOuIub2opnd7HjeeNo1NeplTi6uZDj+PCCW58XIh?=
 =?us-ascii?Q?o1mQmG5oUT+Xo6+8HNYpfxszo8LqKucmLkhBEcIFpOtXC1TQQCfNb1TmuNmz?=
 =?us-ascii?Q?Jlr6y6PTwku4mlp6m0tejZd75IEOCv4AhUQF7YhEpXFx0+4GPWhxQPB3LVV8?=
 =?us-ascii?Q?HTsEMVfrH45Xx+esfMN60hN+rsHv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aJljnIjjXWViiLNkV9CFWmKXekaLxS2yg00mK6hsSHDQUF3UMOq6qKg5MX+5?=
 =?us-ascii?Q?Q630BSOD8kUmhTY4CrlI/E5O+BoIzozdOvk13SZJBHsS/9A/8qToBQoXrxQU?=
 =?us-ascii?Q?1u/kQpabN0VbnUIjIOATxXXZ1ua881Xxu8h5XICsxpR1FGHd1n6y+BNjrNt6?=
 =?us-ascii?Q?h2zFyBM5wX4kELq3JVzGIGm1DweAaR0nCNtGM8zs/iHD6AZjQTTESMCfkuoe?=
 =?us-ascii?Q?8rvomGu5UMiyG71v/pr1yeujAsN4rx1IuymHqPfwThs0Sb8J4lHAt82HGom+?=
 =?us-ascii?Q?b4F2N2ENur33GmOxeI6nEZsscf9AhVQZaW+uJV/YDjhkPLuqrZkK6A+4SKfF?=
 =?us-ascii?Q?5YqgitJ0oPMFSgUqqGnWW4xuYg2u1sdshDGQrJv9ePVm0rFkjkrU5c3h3Xwu?=
 =?us-ascii?Q?kA/z3rYV1VeeFZI0oM5zOKiIgXgP8JLBwhqHV+VckYiZUfvHGp5FhcYoCjiY?=
 =?us-ascii?Q?TAvZmTa4ZWFKw6NL0XbyydrvU33LiU5Fj8Luv5DRSRbOg9iqWmpse0Y+0o4b?=
 =?us-ascii?Q?UiJQONpFeIG5zuHZfRvTbekZCk+GacKg1+HY3b4rjTybl8ZkuNv1SRMAOXcx?=
 =?us-ascii?Q?484AtfOPMJB7xBiqDSciRMBGHcowxDikC/oX6acwvEZEdnQI1bfQcPBQgrEj?=
 =?us-ascii?Q?sk0luwXzDmPyfrp08RUyFRka62IFilR+o06KeXrdumgPaqkhqv4OOV+Agftz?=
 =?us-ascii?Q?0oEN0/ZkTk8zvjE61u87l3d1gw56AI70E7g32EAF6hxaFHJx0x9i/wg9MO/+?=
 =?us-ascii?Q?xzSQyY5q5/w5IycKX3X8sDOjg8dqa7NilerkCt8i3rjqauVXxktGQBUkFfJo?=
 =?us-ascii?Q?OeV4vpFi9PctaA0xtIsGKyhL4rmWhuXQ/Cnp5xDxWQXnETEbUIwFdafhm2Bq?=
 =?us-ascii?Q?ZdRr7jzYCshRJCc/+cTnVBGLuWPDoq2wUchmqwnNdvXutTDjVLizQaQD1+cY?=
 =?us-ascii?Q?eDVito2T2onhKMYRGQMwfbwAMdTXRC4QYtQv5HBkD1XgXf0qu2GOP9IFgzAM?=
 =?us-ascii?Q?Zbyx/eonBfSpOS4F41DkZtlDJ21f9Hv6tPQR40BrCh3WPfbCsU1ECQNM2y92?=
 =?us-ascii?Q?LD+U4g3fVD0UHJBYhc77o6myNrJQvmNfVkSw3m0aA580qAePcPXW4DB4lJnp?=
 =?us-ascii?Q?b5JB5RbqjlEgWRTapaSwtnBdrtkZo9GBZI3UQa1nvJAfhXsvc8Iny5jJA6K9?=
 =?us-ascii?Q?tjP0OlP6MMVW2H3CqzScmFkwRGAC8gcSWR1tNTd7AHQzruzJwiBSlhtGI3Eb?=
 =?us-ascii?Q?Kn57IGo7fL3ksak5zFKPYOyp16icwlsGFzzrdknrQRxM8goUWRKkMSpXey7l?=
 =?us-ascii?Q?Ozujzv6PlYpMjN3kGHd5UEG1p1QAIJEu+ywG4HU8YLyoGZmTsHHp7MHLwsv+?=
 =?us-ascii?Q?WbXQMD4tcmum7rbq5Radsx0erLh7+D8G1GbKOGsSOwICBvSRk3WIZRjZOadU?=
 =?us-ascii?Q?1hX4TD3+3TSJBfK3iS64FtVIiw/VcDFmDPi9q/7mdXW6yws1ZVbFSzDmszUg?=
 =?us-ascii?Q?HqOBBGTC6Bx2mvtu3WGOBI5cyjWZ1IAVvk772548+MrJuF4STww0idWDxTIl?=
 =?us-ascii?Q?geynSF/lfX9xQ420ik7CVuBxO3Hphuy8at6wbQXZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56a2e3dc-ce23-4b2a-f078-08dd4f33286c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 09:12:10.1054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gjK81A2ybucmbDggV2eb0hUFqtU6xEd8TzQlptzFLVkjUwseOyJATE0P5+xw1JoPT0VIUlq9+liiuTmLflZJ4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4456

On Fri, Feb 14, 2025 at 06:52:31PM -0600, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> amd_pstate_cpu_boost_update() and refresh_frequency_limits() both
> update the policy state and have nothing to do with the amd-pstate
> driver itself.
> 
> A global "limits" lock doesn't make sense because each CPU can have
> policies changed independently.  Each time a CPU changes values they
> will atomically be written to the per-CPU perf member. Drop per CPU
> locking cases.
> 
> The remaining "global" driver lock is used to ensure that only one
> entity can change driver modes at a given time.

Yup. The patch looks good to me.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

-- 
Thanks and Regards
gautham.


> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 8c3b54030ec56..044091806f14f 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -196,7 +196,6 @@ static inline int get_mode_idx_from_str(const char *str, size_t size)
>  	return -EINVAL;
>  }
>  
> -static DEFINE_MUTEX(amd_pstate_limits_lock);
>  static DEFINE_MUTEX(amd_pstate_driver_lock);
>  
>  static u8 msr_get_epp(struct amd_cpudata *cpudata)
> @@ -752,7 +751,6 @@ static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
>  		pr_err("Boost mode is not supported by this processor or SBIOS\n");
>  		return -EOPNOTSUPP;
>  	}
> -	guard(mutex)(&amd_pstate_driver_lock);
>  
>  	ret = amd_pstate_cpu_boost_update(policy, state);
>  	refresh_frequency_limits(policy);
> @@ -1172,8 +1170,6 @@ static ssize_t store_energy_performance_preference(
>  	if (ret < 0)
>  		return -EINVAL;
>  
> -	guard(mutex)(&amd_pstate_limits_lock);
> -
>  	ret = amd_pstate_set_energy_pref_index(policy, ret);
>  
>  	return ret ? ret : count;
> @@ -1346,8 +1342,10 @@ int amd_pstate_update_status(const char *buf, size_t size)
>  	if (mode_idx < 0 || mode_idx >= AMD_PSTATE_MAX)
>  		return -EINVAL;
>  
> -	if (mode_state_machine[cppc_state][mode_idx])
> +	if (mode_state_machine[cppc_state][mode_idx]) {
> +		guard(mutex)(&amd_pstate_driver_lock);
>  		return mode_state_machine[cppc_state][mode_idx](mode_idx);
> +	}
>  
>  	return 0;
>  }
> @@ -1368,7 +1366,6 @@ static ssize_t status_store(struct device *a, struct device_attribute *b,
>  	char *p = memchr(buf, '\n', count);
>  	int ret;
>  
> -	guard(mutex)(&amd_pstate_driver_lock);
>  	ret = amd_pstate_update_status(buf, p ? p - buf : count);
>  
>  	return ret < 0 ? ret : count;
> @@ -1640,8 +1637,6 @@ static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
>  	if (cpudata->suspended)
>  		return 0;
>  
> -	guard(mutex)(&amd_pstate_limits_lock);
> -
>  	if (trace_amd_pstate_epp_perf_enabled()) {
>  		trace_amd_pstate_epp_perf(cpudata->cpu, perf.highest_perf,
>  					  AMD_CPPC_EPP_BALANCE_POWERSAVE,
> @@ -1678,8 +1673,6 @@ static int amd_pstate_epp_resume(struct cpufreq_policy *policy)
>  	struct amd_cpudata *cpudata = policy->driver_data;
>  
>  	if (cpudata->suspended) {
> -		guard(mutex)(&amd_pstate_limits_lock);
> -
>  		/* enable amd pstate from suspend state*/
>  		amd_pstate_epp_reenable(policy);
>  
> -- 
> 2.43.0
> 

