Return-Path: <linux-pm+bounces-15724-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F6E99FFFC
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 06:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39E371F22594
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 04:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450D4176237;
	Wed, 16 Oct 2024 04:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pwjP2XaA"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6394415E5CA;
	Wed, 16 Oct 2024 04:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729051856; cv=fail; b=ZSW6rGNmAzMh2JP7uye1PJNEYX2kvwQGOfhU0+RqlprLO4SYpnD8OGNM8C6Zqd/Cy7LU6qAwXsfOlWqA3sf+eCvsyJg+6BZY3qnoat5WDqVCbbE1hLz57U0k8wYbYNM47/yDrAIIryXVkcEzpX0tg1STCi/wa46nS53oNxYjzk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729051856; c=relaxed/simple;
	bh=zKKHSgPFi/hZamy2FPclwyOlMyDMA04QoVq/rxk5zFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PgT463J6EtQXtP98yWKUZzO9e9KY8ac5yuI+u1w9a2wVbs+0xhx4iE6viVt89ACn11hLodzMoDVgu2BPSE1hJ/iht2dYsmamvriOzYLR7GrG32d1bOx0oeP/UPeSOU3XdgbPoLP4aqZrGLtXw9Z/9qzkMnL7+nB67J5piJgPzp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pwjP2XaA; arc=fail smtp.client-ip=40.107.220.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jb6WrX5DmTxrDp+sAfCK21yYHnKjOcAaOg730S+y3O7Y9+BJ37iPRR2E+APtCf12QOS0vHBEXm5bWM3PIkEm7fqHQVuaXv71Af9FtTnnRU3yFxHOJ7q5PbshyWwqZCRDPkE22xyHNbV8QOFjXZ6Zx75Ip6n+uLmhPaE+sxtVlP2TNWXzuWgoldSGEw93TBOKlBjYStwykIUyFSnw2alyFZpqwmkeAOyDVUG0PrX2P8al1TiARVxxJb37rwFynXDt44/9v1p4AwIyQ3FH2Bv6ren6++ZP6SJRdVjfghD0x0OSuZCwiVe98f8Vd9YIObljQsZlStUnqWhQEWKF8EGPJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+0p4ulNz2RAigH7mO4rFNWHIvDqe0Kihf8K1wDSUc8=;
 b=vxJM7iakNjpS+9UEGV1F9E9X+QZ92ahhBKdBdBcMWK2YydZ4MKw8cl2bNSCB8xWqWnCUpIKaLwhACJ28ipHxc+f1b6U1cX1Mx39peLQgZzpdTEjbXhCVJ+NzfrGWNZuD0xO0QL279UsKW1YpTnRx1i0Lf0/JMuIA7M2oFyPsCcxuRR1QycFXTvrnClE/Zvuhrvqs/yhK/rB7usT8EnWK8LFgQtHx9aBDgL4HlcMH961WE5U3IuuLM1SeRb1d8zc42V1Q3lRf5OzsKY4yVXTP2wJSlQhffUqO89Pb319COF5iX6sNXb8AN+oZPzqkLhm+YJIMWGP6u/cVR0jeF1HmAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+0p4ulNz2RAigH7mO4rFNWHIvDqe0Kihf8K1wDSUc8=;
 b=pwjP2XaAWEkcnp7Z19TPD1ufokLyGQuIZ9MKACFs8E9dezxmPCHupGAqctewuzDKRMtIoQuMPEz9j6671Wh5gpcLyJEpiV302/fnS+yf4NuHXppeuGBfJ+j9VWM5FTC4ook/l2yGE5DAZL3EcHePD2Il3C/JQpIKuLBtvss6cBk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 SJ0PR12MB7473.namprd12.prod.outlook.com (2603:10b6:a03:48d::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.16; Wed, 16 Oct 2024 04:10:51 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%4]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 04:10:51 +0000
Date: Wed, 16 Oct 2024 09:40:40 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	Peter Jung <ptr1337@cachyos.org>
Subject: Re: [PATCH 1/4] cpufreq/amd-pstate: Use nominal perf for limits when
 boost is disabled
Message-ID: <Zw88wPX6WqCRYyRt@BLRRASHENOY1.amd.com>
References: <20241012174519.897-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241012174519.897-1-mario.limonciello@amd.com>
X-ClientProxiedBy: PN1PEPF000067EF.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::2b) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|SJ0PR12MB7473:EE_
X-MS-Office365-Filtering-Correlation-Id: 54533c49-b82c-488f-7521-08dced9885ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X4T9fQn5AHZogpQv8Y62NvALt1HhOScntWSyvXMYOmxGpMJOY8k1c5oo1PwN?=
 =?us-ascii?Q?Fce5Wyi2lv8SkSAMUANTbyGNms2Pu0TWpJMAguf0CS4tmeLJONamDSNy53jT?=
 =?us-ascii?Q?0H3zrPJaN4hj726aNc95ziNw9JyXuHAmUXGVDmEfs7+g65AyLywsXaTVLTHH?=
 =?us-ascii?Q?Tgl7jaIku5KekJTFatq6T5ghHqucE3wx3AhrzwFmQloTaFpIMsQxDaGy3dd7?=
 =?us-ascii?Q?MFOhZSvcaQYxF6Qs43bKDzta2A7VigsvvYeyS05605kkiNPRQhV/r2Ru7sUs?=
 =?us-ascii?Q?3U/A0am1n4jbhhUW35UL2/lxaHzw3aqoWX0xooUZ7vT/qsm3Y3bK8kyP/TTJ?=
 =?us-ascii?Q?X3q5/LVnjZjkfikujSqNP9YhmOue9dz7oHd6z5ukxigThfOCG0PfCo+jQ5st?=
 =?us-ascii?Q?a9quFLsLZxLIvw6qJq4zhMp/MEJgQsqGLLsv8RCAu024uIXdbuhGHa7GosvQ?=
 =?us-ascii?Q?EEVQ7q2AKg6DlecEIk3KuXlPAPPw2s0taeod5eJFBZnWliwrS+gKSatN3Qv9?=
 =?us-ascii?Q?z1wT9qmQq6fhi+UFS5kCUqxrUnp/V5Xk+ARZ10ZBz1El9yEJruoimr6xh0tt?=
 =?us-ascii?Q?dXKeyitGJOFBfliAuqNsP3zROY6ukT4yLs/veOxonvoHTR5OgXp64WSaj0Za?=
 =?us-ascii?Q?ZG1z1Lk8r0/HySWqwkx8/Yq28OWtos1bjLFHIuXoctWXEGwayBS2W3Kh6Jni?=
 =?us-ascii?Q?3rIATYaY6OhGtpqezQyaRRnIWMUvNqv+/RqT3S6bEx0QOrepyEFPjmwWnLp9?=
 =?us-ascii?Q?Ld3B+0ZEVZeKttMed1oiwaVS23+NOEoZqIc8RHvafulce0l2inIosZXywqcE?=
 =?us-ascii?Q?DIjqPrBA/LBrnDzCI9B/O7kWFBq1HKlCu8UgjUt+fGHjLRX1fj3GrPlhk7Lg?=
 =?us-ascii?Q?8Hszr+vPxnNM6PJh/7viMNlP0fnPa7xNdRAgsFE3HuYyNZ5IcsPg+3qk8RSh?=
 =?us-ascii?Q?MNZDPfJMbRx6+FrMeNkGlzEgtCzUOZ0BpMYcVIf0DXTuaLM8ej1KY4as8EIO?=
 =?us-ascii?Q?BLVI0s0fGFqpLqthVHK110L4IOZU12JodWpasHVyckEEpvj6Qa7VtFq8YoN7?=
 =?us-ascii?Q?vtNZQWtLiTzf1uH1npZXjhQtLLiq73JKn6nOFNS7Abb9RhU1abX5RuIm7o1t?=
 =?us-ascii?Q?IfS9MhC/SYW79GZRjzV0LfJiOcLq5SI79AT4H2U6V7RsZNF8oTTsZCC3ru5H?=
 =?us-ascii?Q?CMAnESPVweQP5i8AE4eJnbGDnvt2nYgBBSLrIYQbVC9M3U2apnSIG2acx7C9?=
 =?us-ascii?Q?eaTzm2pfB5znODam4ffK0hx0LxfcCYa5YIplbsGxCQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ms8d9VgF/H0nfBiTRcI/yLHqJ075lNwjUNo/jWh3qa8sJibEeVh4HXU0rUDU?=
 =?us-ascii?Q?WSKxyZGXk2WDdFBOKrARY6fUfYd1o1pZTv3Fi1I07Y7WNKTMw2qZkcvH9bDg?=
 =?us-ascii?Q?pHQieqnWOQW5rLwKwThULk/KelgVC0+uiFGqtzSqgjAtLuvmSMLrA6KsDyMM?=
 =?us-ascii?Q?+iOUm1kHAW+S1GdlOsPZlajV0I9BQh1znNDbQckEYqbqcLyO+Bz08iDYANks?=
 =?us-ascii?Q?+yXJxlJ2rS22+aE0w/QWOejzov6ivynd4MSozYYH5vntd/gD1DoydqU1A1eP?=
 =?us-ascii?Q?L++cElL4Ag+4aWV5GBdwOokxWk9KwZE58PEtMneNXiTe+3FAT0Zdx7Lhl1eA?=
 =?us-ascii?Q?myT09zXkDZFucdALCRTF46p8mc2Yx2qPkqecjDC3gvQdBaMEP6aYeUXjjJud?=
 =?us-ascii?Q?WzUGfh99pn+a8AhSYwkjOTVzZAIpKwbGYCypu2pgRdDhgIM33PXKxDkV8mkK?=
 =?us-ascii?Q?tlg2yf44fee6HH0nk4hASw5SFAQHRpXY8ovsve6revMaRVorp4A4ZdQtajtu?=
 =?us-ascii?Q?DzmTajpcQiJkgReGvZogLBETevSGsDwiKPZ7knNPs0tbbk9sJ8PxFL+IK1uP?=
 =?us-ascii?Q?yvDOk8SkK+ShX3A1F8A3KxppsZDc0Dtno1t1zW2UIqAA5wOmmSK3PLKEXr7E?=
 =?us-ascii?Q?9omO+FqiNmHSunj62V+UNnTt//kt0EaLVikZk9+yiGdgfSRgBKlTZAIgTJfa?=
 =?us-ascii?Q?g1tvlhq8SR5XDlzguFPU7wG5zCi8fGz9vezIf1iqqVAGKaCn9Oto9Hb/rpan?=
 =?us-ascii?Q?zDW5ug/b6PB+odlXxjFohAhQ/DDJHpuh3lmdcdcvFhx2Dk71VWwl6vaNsJGN?=
 =?us-ascii?Q?Lw26CNKtvjga46h6NN87G33Gkx1OS9mBLU49uVk6GGR3U5FGkhcM4b/R5e21?=
 =?us-ascii?Q?epaHiQQ7qqJrNnHm447LQYZnNkwud3zcaTJ6mRY/eg1QapDo6plL7nSPn+pY?=
 =?us-ascii?Q?30XrX4WErxenhpeKOVvSS3+ER4gxvbVElLAa1+iEsV3sVewvO/A3ssvNKkun?=
 =?us-ascii?Q?mdqErUuFcqlIWSBx9ANAgKfQaM4T2jUAip9ytuKkmMUYaqvAksy/joDvtfII?=
 =?us-ascii?Q?JeOQEaW0a3PLFrRJCChmUcygLVk/G/3QBnB9Nt95dZSW6+tsauH35ula4GEO?=
 =?us-ascii?Q?IMAp8sbvtF790cO2FiooV/TGZyZP5jQC00zFOmfI15SsiQN29t1UNgCF2+rb?=
 =?us-ascii?Q?mjdCUkMvFBMTM7DWGZvugwnFUpDrNbY+ebIAxmZhBvm1/Ts6EpJ0jIvQ4F7c?=
 =?us-ascii?Q?+aIcH5v9l/xoJHYu4EU+tSMwP06Kbw0L1kEC4YD4VJ++1yX1jurZIPQ5gsv7?=
 =?us-ascii?Q?s3yk6KM2MuiAt+0oneF8tom89o7v6Pfvn1jPrfqIkUpSxoarMra3BAmPtDsd?=
 =?us-ascii?Q?KEpbQSCNBwYtEbhzU+bfF2agxoY3hmRj4bm+XQvZ1by7Di37uCThTnamSIp6?=
 =?us-ascii?Q?COlejvZfgbW0qb7z6mian+4TqGqA+40ZRLkmuFcMDiN8wZgWiOxVnir1G7G+?=
 =?us-ascii?Q?8VZ6pzMSSXf5dCoG05L6FpXu/AXCftR9QynXgGhl4/LUzovKpQVbFay3GRyr?=
 =?us-ascii?Q?zQ8i08wRWTaY0SmIOAxSPjJRusIhMI5tsnOu42Dm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54533c49-b82c-488f-7521-08dced9885ac
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 04:10:51.6703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mZGf08UpZRSWtWIZZgaJTe2SRF2kQZb71iA2UgXjRXZvfWkWKH7imkAmuh01fdTH7AHgQ2VmvDhizlhn5w1Rrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7473

Hello Mario,

On Sat, Oct 12, 2024 at 12:45:16PM -0500, Mario Limonciello wrote:
> When boost has been disabled the limit for perf should be nominal perf not
> the highest perf.  Using the latter to do calculations will lead to
> incorrect values that are still above nominal.
> 
> Fixes: ad4caad58d91 ("cpufreq: amd-pstate: Merge amd_pstate_highest_perf_set() into amd_get_boost_ratio_numerator()")
> Reported-by: Peter Jung <ptr1337@cachyos.org>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219348
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

The patch looks good to me.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

--
Thanks and Regards
gautham.

> ---
>  drivers/cpufreq/amd-pstate.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 30415c30d8b4..dfa9a146769b 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -536,11 +536,16 @@ static int amd_pstate_verify(struct cpufreq_policy_data *policy)
>  
>  static int amd_pstate_update_min_max_limit(struct cpufreq_policy *policy)
>  {
> -	u32 max_limit_perf, min_limit_perf, lowest_perf;
> +	u32 max_limit_perf, min_limit_perf, lowest_perf, max_perf;
>  	struct amd_cpudata *cpudata = policy->driver_data;
>  
> -	max_limit_perf = div_u64(policy->max * cpudata->highest_perf, cpudata->max_freq);
> -	min_limit_perf = div_u64(policy->min * cpudata->highest_perf, cpudata->max_freq);
> +	if (cpudata->boost_supported && !policy->boost_enabled)
> +		max_perf = READ_ONCE(cpudata->nominal_perf);
> +	else
> +		max_perf = READ_ONCE(cpudata->highest_perf);
> +
> +	max_limit_perf = div_u64(policy->max * max_perf, policy->cpuinfo.max_freq);
> +	min_limit_perf = div_u64(policy->min * max_perf, policy->cpuinfo.max_freq);


>  
>  	lowest_perf = READ_ONCE(cpudata->lowest_perf);
>  	if (min_limit_perf < lowest_perf)
> @@ -1506,10 +1511,13 @@ static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
>  	u64 value;
>  	s16 epp;
>  
> -	max_perf = READ_ONCE(cpudata->highest_perf);
> +	if (cpudata->boost_supported && !policy->boost_enabled)
> +		max_perf = READ_ONCE(cpudata->nominal_perf);
> +	else
> +		max_perf = READ_ONCE(cpudata->highest_perf);
>  	min_perf = READ_ONCE(cpudata->lowest_perf);
> -	max_limit_perf = div_u64(policy->max * cpudata->highest_perf, cpudata->max_freq);
> -	min_limit_perf = div_u64(policy->min * cpudata->highest_perf, cpudata->max_freq);
> +	max_limit_perf = div_u64(policy->max * max_perf, policy->cpuinfo.max_freq);
> +	min_limit_perf = div_u64(policy->min * max_perf, policy->cpuinfo.max_freq);
>  
>  	if (min_limit_perf < min_perf)
>  		min_limit_perf = min_perf;
> -- 
> 2.43.0
> 

