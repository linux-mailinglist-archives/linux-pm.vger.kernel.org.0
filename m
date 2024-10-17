Return-Path: <linux-pm+bounces-15825-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FEB9A198C
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 05:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01174288B57
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 03:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C34313AA4E;
	Thu, 17 Oct 2024 03:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fPjvRxo3"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C4436AF5;
	Thu, 17 Oct 2024 03:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729137397; cv=fail; b=O1cDKnPe/XjwNXbN0mmhjExOY2GGRBDEvqOcXb6xEI1ZssV9o5gEluHATTn+iKkxHoVfQiKyuRFgpnBreOA2taD2ilKuozgLfVHNF6fwfjhOxZtfjjLElt5Y6NnExgXDQS4gh4kRi4YrXKZPMPgkZhnrI1yrHtNFQPFoau+lSBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729137397; c=relaxed/simple;
	bh=T70+vxrma33bQFpNmjolfJCgv7E8zxDDXVh73vEGSE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GDz6Ivcg+AJlaYlqlpHyV85t3aNMN7rKVII84hAfBccYPhV9vSLhHlxVHlrPnlfY0i8DxtpeUblWtYXfLf3xD+yRXZk3sJDAjmpNO5P1gwlep/32jbCUHOimpXOJrbYWid4EXbxSJDLCalfTZcuJ9F1ptoblmz2oU4ESUjctU5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fPjvRxo3; arc=fail smtp.client-ip=40.107.237.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=omOJaAuQiAl6aylJLXHYOON2bVzxTY1G6l29Uhg8FEwxD3ki8ey6Ei828YK0r94jf7OINRO2SkPKlvNAQZb34kY56e2T5DJsxnIHtm8g5L2paOQKRH0cMXQwiQ0W/4JMextBusCS1XvD92YM9NYqQRSJv16X1pWOTc/ZpaPVw5Ter6I1/5id2JQqgYQSwFtxq04nJoxF8LqWQXak+dhn6wRX/W/OsqGxw4O/U0GAgfqnoUcdfj+nQZ0aFO3TgZFK2QsnfQ0GPdSz7VbXQ7nlbwYh7xVTpECpmwJbtGzFBoTyzXGJXqEA3Ka5NzHjJ1aoCIYRWr5td/ztsaZNFZFhDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h1FaIg8Wek02+vuemA4VRiuPqVoH11T83XxtOprWM+k=;
 b=T/PM3mh51ERukegbKMWJqjAJaX61RIcta4oKcBN2F++yJuV11BVw7zGFAbfvBdVYlyVHX45AhmMBRXgsbMIFs1HrB7f33MO33Vi7ast6h8oBgL2+r+FREUkCUOxSOB0+XJR2PPXnJTwoNJ3GHWsq+YEQ68mGXib6LCHKWB8cKBbT6z6wzwXgoSc6rsGAURfNBV6Grje/Rm2YBtVWqEmxvI3lJT4SkMTppTLFqOfwIEi/vb9nwOfgwTIFfoac8UomqP8t/kQ55/cDlfTTD8C1ksb2ZGAMTchhDE0FsMkF06kDyqIr9JHU5/VvRw5zbsJPTs8wEMmoOk6/fUJJQ1GGPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1FaIg8Wek02+vuemA4VRiuPqVoH11T83XxtOprWM+k=;
 b=fPjvRxo35NHSt7zUp78poh7CUVe1Zt0b0mQcOveOT4sEWRWTvQlw9t8l6ahqYTzVLHx6W99kXW0tsaUtV/hgn9H2kaK7KxVeVDKjM3FC3uV3/zqBQNO1E0CZNkwJMoVp89brUi9GS/HpoMnLD1P0dS7gtDwuMzGL2wzHIH+X2Jk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 BY1PR12MB8447.namprd12.prod.outlook.com (2603:10b6:a03:525::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.21; Thu, 17 Oct
 2024 03:56:31 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%5]) with mapi id 15.20.8069.019; Thu, 17 Oct 2024
 03:56:31 +0000
Date: Thu, 17 Oct 2024 09:26:23 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Cc: mario.limonciello@amd.com, perry.yuan@amd.com, rafael@kernel.org,
	viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] cpufreq/amd-pstate: Set the initial min_freq to
 lowest_nonlinear_freq
Message-ID: <ZxCK50Qvo4mgC6CZ@BLRRASHENOY1.amd.com>
References: <20241016144639.135610-1-Dhananjay.Ugwekar@amd.com>
 <20241016144639.135610-3-Dhananjay.Ugwekar@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016144639.135610-3-Dhananjay.Ugwekar@amd.com>
X-ClientProxiedBy: PN2PR01CA0242.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::8) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|BY1PR12MB8447:EE_
X-MS-Office365-Filtering-Correlation-Id: 0edb4589-8508-4e7f-1288-08dcee5faf52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8DDO0Xg0OXHERuVBM7SIMsdtKwHG3Cf+jAr6l5erxTZbvMbN7RvNB+BWP3hD?=
 =?us-ascii?Q?iD/hqbLFMKK2bZXGNEFtVDB6rCZ9H/lxNpz85w5UK8odt252BUGw1+w+coxi?=
 =?us-ascii?Q?sTev+Mjspof479pOFG7lodWvCs7TSiZyRbpWi7R6GNVIs14d/2jlBw3n5K3Z?=
 =?us-ascii?Q?L43XKc0W/dQhjOyY/f/awk8EIpyKHSDbnN/FPWgSszQ8qiXEszd5XNPq83af?=
 =?us-ascii?Q?UUOofgiuTJR7Oat0rubBbBzDsbSVTB1yayQl2CyNOtfA+WvHyH9QK05EX2Fc?=
 =?us-ascii?Q?SJEbeaPW4Kxnh0MOjG4P4Im7mf3Ftbi6ijB4FL41DpAmpHumDHVmChyaHsle?=
 =?us-ascii?Q?3wobkkuxRQE258CM+XhtOBRFWcVdyjmhj0Fyi83Q+XiNgM/6SWdjp/ldlIqu?=
 =?us-ascii?Q?x/LMInExazOaXqodV1ivMcXPWtvtZGGwHDbWxlaBFlND7+Ye5fxbc/lv/CKP?=
 =?us-ascii?Q?HU0nNBpraSbblkTR5BpNwmDlli4Ko24FRXw2Hh33uLrTt+3cTftuOTvEO7yw?=
 =?us-ascii?Q?AC7/jR4cTZdsZESrNL4Z8xDPBAopZhbPLebStpo7XEAudg34YLZynbiuRQ6D?=
 =?us-ascii?Q?nAHl7Bx+Fe0yKt6y1lcSi4W8Rrt92QqEVvQe/uA2xJM4dxhi2XGzNnpex1IN?=
 =?us-ascii?Q?GvJvIffvEC6pBo13WIgU7HH1YC2YW2UpshQ0zJlIY4RK+AkonuJb1beizRUr?=
 =?us-ascii?Q?2hzLdhAZeEKRQPl5mDi1GjRLHFXsVqoE/PpIT8rv8q2EThAupMMiLf90elNN?=
 =?us-ascii?Q?1WW8V9kTcbXc0CBq1e0eCc3b4SejVGnv5/42r5WbVZ+LYS6K0jCvw52I/hfP?=
 =?us-ascii?Q?pjkET7kb2tazhW7GqQScA1b9N9Mo2cNM8tBcWv2oLgbtQwot7wBuCAkr1k1t?=
 =?us-ascii?Q?vcuDS3xkn/0kZx5ia1rwJlkBoVt1kKYC0Tb+Ls5EFkEVjQ/G+zVo0xjO95ZL?=
 =?us-ascii?Q?4hsZ34YvOM3aQE/EJzZgc9BN7xVQkd+N7hmcA/zGLg2b2dW80PTukYHkzMj8?=
 =?us-ascii?Q?mLce4t9H/Z0HcXXl2nt8Y2/FDoiQ71C5WzqlAEmPPlTdhjWwCdo3Xn4Bk+9B?=
 =?us-ascii?Q?44vVH20QNyo6DA/leA9Q1rRGuEIRs7JhAhmvstRx3V1HqvMkU5bJ+T25eYpP?=
 =?us-ascii?Q?AX3AQ2dGH9Q+zWCVI+M0ccs/EEy+RI0b35mq5+7xYmIMbfr5NEef4e13pGA4?=
 =?us-ascii?Q?U5t3J/KfO1sQkBRkychA+6AiK0M7jhKiy81iU9Lxaw20fEYVDvYZkm1jJA0T?=
 =?us-ascii?Q?EZDeAWQ0NDwzlu4rLHc11MwVSGKPDa0Y5d5WXyLkcMgK9RUA/s2Gjf1YiF1X?=
 =?us-ascii?Q?/buGJi5/yBmLI88PwaS8Lr0D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dL5+dmIEkrJMNc3yoqueYWjTWnCQ8CKLA7aF14kycBFN1v114ljRAFAuc47C?=
 =?us-ascii?Q?/v47+uBrJGNKuWVrOsFoUkesGPutI1zb1HTPeIogeFXBjImhgJXzziIW2EM3?=
 =?us-ascii?Q?ysZABFkdx+nZgp5wqKzf7zfcxNK2JaKf6ODhh6FGCwj13LnW73Y+ZI31+YDT?=
 =?us-ascii?Q?O1TRAvkwGK84XNXR4q4ted67Q8YQYC2FVC93WXKI+PZXegpjDNuzTDwrpXp6?=
 =?us-ascii?Q?8767EZjvk8Zba3X0xE2XQYWIe1QTqTmfftiEJX0T6+Ypf/+1Ub5sD6OS15+s?=
 =?us-ascii?Q?PzPCzPwl6Fs3GPXA0N2tmWLSEvu5iNj4c6ZamyhYHEEalKh87kgnwIxUdaoy?=
 =?us-ascii?Q?yjH9O9DBAfwrhXhlRoWGjl0GKVCFhEm1rETTHapKfRXeEI1mS9k41uYIoewA?=
 =?us-ascii?Q?41RqeF1/VyU4lZKTUVtD0g+KFRwnQq6mpi5MCkjnDOgWcVJbyyZnqbKvB3Qi?=
 =?us-ascii?Q?AFWxQzlvTxaSosS21kucwAJ8YJ+p4vr76hKZwN6RTXbjtGv55tin0YpIvu1b?=
 =?us-ascii?Q?My38lCfy9HqGS/riNDzjpbpWGB1MDURCdFNQeHV1GsewDd7V6OqhDA+kljyv?=
 =?us-ascii?Q?m09kETqKxzjN2E3EPe20yib1M8+aWmR7oBJmh1dMtLLYgD3V1rnBsbfLxfF1?=
 =?us-ascii?Q?FFDPYRBctLF7GQ4xsE4DwurMdStIy/B1wjBuSr9pk4bdivIm294EQeYpczmA?=
 =?us-ascii?Q?jFlVxqsKUJaLQP4seKChJjWtG6S6POZHKbai1V6ne903LLwceyDZY5rlkLSw?=
 =?us-ascii?Q?cs8jsuLnQZMO82k7wSISbmokabA4ItyNyFcmuRK/eZzI1rL/0rLoJF6wx8pM?=
 =?us-ascii?Q?IIBGpMdzcRa6QuYiofw4/6BIvDc2vR8SexOCVgDtVtv0F1oHvUa0+MF7HzHr?=
 =?us-ascii?Q?TJS6ZzFJnhXlK+Yc/A3qLp5krqYMOc8YIjeI4ytCx8v1t/GoZWgXTnTtvKY0?=
 =?us-ascii?Q?S4yo1Wtj75N286jEmdg4TjHZmqKMbOvopv66rSYoeS5Cz6GOjkPO+ydrMHFW?=
 =?us-ascii?Q?kxNlIhQKW17/692M9M6otK5HCKwanfXp3FooAo5Z5Enkf0et7vmu5FQKZ9OH?=
 =?us-ascii?Q?tFyompMgKM+q3AZbuMLOLsy+AI0CokGfHICtrmeoy7Kxmuh81XH80Vdh/FuS?=
 =?us-ascii?Q?0QCbb7kCKvKOssvGyDSaqJDaHp1WfC2/qmZw50xxCUbaDQyJdX01rjqvb82N?=
 =?us-ascii?Q?l2RdsUMder9j9PzzpOvXjlBdClItu1FiOrMbYbaWiUnXoYL/UDJKeEVJQ11Q?=
 =?us-ascii?Q?STU8027FgFibBITc5NPGL4hbLPZr4VPiFO1xpOuMqC3uGY4fz5eJKOcpqCSd?=
 =?us-ascii?Q?7rGeLMUkSjwpGwMlORgf8LQJYUhS5kIJefQQnG7PnJtPcuxTM0ZA7gtj5VVe?=
 =?us-ascii?Q?l82oO3XE6eB//MGUzNPua4qVaYnQurufznyVmxfQdeEYhHVDTcbIHuzLiE5s?=
 =?us-ascii?Q?dL18k/hVm3YFF2PuHQ0h9MQEqKBXKB8maPKCXqe2Xdc/VYsIo998z913g1bL?=
 =?us-ascii?Q?HVPJFAXqI6s0pu6hWcjb4fPNdgbqdn20EEsEXv0wSURDQNMcu7xfB/wq6ciy?=
 =?us-ascii?Q?ZA2zRDBNBmuIxwYANTc6sQ9u306eIgHgZ/kSPKU7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0edb4589-8508-4e7f-1288-08dcee5faf52
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 03:56:31.3999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3KjAIJkbsxLtodygpm+cdXInc91ZhtzbIpnVjymV943InteTREu+HeSf2YtKZwPZuk2G+5qSSsyXmmWXdK0HVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8447

Hello Dhananjay,

On Wed, Oct 16, 2024 at 02:46:42PM +0000, Dhananjay Ugwekar wrote:
> According to the AMD architectural programmer's manual volume 2 [1], in
> section "17.6.4.1 CPPC_CAPABILITY_1" lowest_nonlinear_perf is described
> as "Reports the most energy efficient performance level (in terms of
> performance per watt). Above this threshold, lower performance levels
> generally result in increased energy efficiency. Reducing performance
> below this threshold does not result in total energy savings for a given
> computation, although it reduces instantaneous power consumption". So
> lowest_nonlinear_perf is the most power efficient performance level, and
> going below that would lead to a worse performance/watt.
> 
> Also, setting the minimum frequency to lowest_nonlinear_freq (instead of
> lowest_freq) allows the CPU to idle at a higher frequency which leads
> to more time being spent in a deeper idle state (as trivial idle tasks
> are completed sooner). This has shown a power benefit in some systems,
> in other systems, power consumption has increased but so has the
> throughput/watt.
> 
> Modify the initial policy_data->min passed by cpufreq core to
> lowest_nonlinear_freq, in the ->verify() callback. Also set the
> qos_request cpudata->req[0] to FREQ_QOS_MIN_DEFAULT_VALUE (i.e. 0), 
> so that it also gets overridden by the check in verify function.
> 
> Link: https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/24593.pdf [1]
> 
> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index fa16d72d6058..117ad5988e8e 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -529,8 +529,20 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
>  
>  static int amd_pstate_verify(struct cpufreq_policy_data *policy_data)
>  {
> +	struct cpufreq_policy *policy = cpufreq_cpu_get(policy_data->cpu);
> +	struct amd_cpudata *cpudata = policy->driver_data;
> +
> +	if (!policy)
> +		return -EINVAL;
> +
> +	if (policy_data->min == FREQ_QOS_MIN_DEFAULT_VALUE)
> +		policy_data->min = cpudata->lowest_nonlinear_freq;

Why not unconditionally set policy->min to lowest_nonlinear_freq ?


> +
>  	cpufreq_verify_within_cpu_limits(policy_data);
>  	pr_debug("policy_max =%d, policy_min=%d\n", policy_data->max, policy_data->min);
> +
> +	cpufreq_cpu_put(policy);
> +
>  	return 0;
>  }
>  
> @@ -996,7 +1008,7 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>  		policy->fast_switch_possible = true;
>  
>  	ret = freq_qos_add_request(&policy->constraints, &cpudata->req[0],
> -				   FREQ_QOS_MIN, policy->cpuinfo.min_freq);
> +				   FREQ_QOS_MIN, FREQ_QOS_MIN_DEFAULT_VALUE);


This qos request can still be set to cpuinfo.min_freq, no ? Especially
if you unconditionally initialize policy->min to lowest_nonlinear_freq
in amd_pstate_policy, no?

--
Thanks and Regards
gautham.

