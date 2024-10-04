Return-Path: <linux-pm+bounces-15138-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C86798FF11
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2024 10:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1D83B226B9
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2024 08:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4849113E88C;
	Fri,  4 Oct 2024 08:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3B3U7K6M"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B7E13D899;
	Fri,  4 Oct 2024 08:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728031681; cv=fail; b=gbJuyBlf9nvU5YU5sdomHJu4zP7QzqbO+y5CbjmzIOKE1v2FTWWzgXO5IWbE8EEDUoWQ8OaO4rcY11ET5yKA0cI4DsnkAaWG1gPNbhGSfAaaj+e5XDq91WSFr3AxXLTtI//RZk5RP9J/kBnngwmpXxlfQXVxu9glH4F9Gj+9Ibk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728031681; c=relaxed/simple;
	bh=l8vcYXVRFFV7ZWEORAPjALrzXgc1zTS2NnYdM5nARZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qnRuPIKNtFPVBWxurv5BljhFeWLOEiS5Fwf7Y7B/pNrFEibfTVQ0akEzwn2rv3RidkCenKXuyxT1zBiqkOJtrAAqNqWj42sjkHnoe+s9EurDswhNUsIfY2GucpPbHWTlILrTa+YvyTlPYKekf7aoZxJaFPvuK9XFvObFdKeXeQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3B3U7K6M; arc=fail smtp.client-ip=40.107.244.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dcjmt8MX+WUMr1BbIJNDGt6Q+iMy/DTMhGlREOpYybmDYojX7mdVsYzC8abuElMNCx8mNpL1X6vLQnVIVlJR2XqyqWa4feL8RxT5EIxmHNn+2bFmJ7zfqnXIfy1zNB5sztwhe5o7OwBVaFkcMa5Pxt3bKNopGZykC39rwVaLtIvr95sC1g7VCq9AHxCacgZ6/FffzoxttLdtBrYfBiIT984ppE0SZY7CNWTW8YgHLlYoaq7+o+rx9yg2+S/SXq+4bKs4oDXUoO8I3NJ1nPRa4PGdfumehHY4Yuop5/vaneA3/LgQJ3LfEglNtfWGj+Da3foTqn7uoACYqB/HTSjdmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wo9ONeKZnz91DWBhqnmQXGGWu9t48CQ/IOOfrw4FdRs=;
 b=sPmRHzTTEx5+zeyLpkQoD5fzbijK2XBqWzHWJrlHZzGzfOnikuqsk9aPMlsgetUby6JHuSoJT6p0EX5WXCou7wbIkciZuxZBykWzA/qL7fWtlix/847YMiaqwf/FVeho2SapEhBykOhXGrTJaQAQK1nF1R6gF5TQYevO5uxgmJJFB5ZK25YhirZeyZ/WexgxoS+HKmUZKAul1HQXeB4mCjp9T+oCzu5wtynJfZKeeRfGpRjy+9aehhl5Kap+k79ENS/uh1MdlNnen2d3yRHkl0Xobh+moNmX1Y/y4JurCbMuQAhQ0/VGsq5+uU0HX333xMs2REPa3lA6IL8S1xssCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wo9ONeKZnz91DWBhqnmQXGGWu9t48CQ/IOOfrw4FdRs=;
 b=3B3U7K6MN/QXRp1tjxm4nljTpbtf6hlAqrHSD3ej4rqzHOaphDpIl87bNaJMbX3mkq3EzruyhXBaq4DlOi0e+kA0Leev2XJ73uX/crO66hkbVsvocXygk8D1e2vDjIgyLLUO2t9m1ZVQpYxLQVh7EIgeca18+ftTVBQ4AxWimko=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 IA0PR12MB8375.namprd12.prod.outlook.com (2603:10b6:208:3dd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Fri, 4 Oct
 2024 08:47:57 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%4]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 08:47:57 +0000
Date: Fri, 4 Oct 2024 14:17:48 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Cc: mario.limonciello@amd.com, perry.yuan@amd.com, ray.huang@amd.com,
	rafael@kernel.org, viresh.kumar@linaro.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] cpufreq/amd-pstate: Set the initial min_freq to
 lowest_nonlinear_freq
Message-ID: <Zv+rtIi5NMkWzayg@BLRRASHENOY1.amd.com>
References: <20241003083952.3186-1-Dhananjay.Ugwekar@amd.com>
 <20241003083952.3186-3-Dhananjay.Ugwekar@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003083952.3186-3-Dhananjay.Ugwekar@amd.com>
X-ClientProxiedBy: SI2P153CA0021.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::20) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|IA0PR12MB8375:EE_
X-MS-Office365-Filtering-Correlation-Id: 56de3d0a-409b-43ad-5b2a-08dce4513e2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zrd/MKwpyD7aQZ/yjmcVEY9oQ/zfx4B3BGq/eWP7yar6XBDb5UWJYTVK/s32?=
 =?us-ascii?Q?SFjLVQnfZ3U/REj+V1QkoP0KqRV/YuetfBBHgfyrnXegQitnic9TbOD4SUT9?=
 =?us-ascii?Q?Y2QwmfUwAub9Twhqxk0eELotZBMIUw2XZ2sfRGFh3cKzXqTGm6Ebd0XoabWP?=
 =?us-ascii?Q?eYiU6aEUHUEewlIFk5Svgq66aWZCH1B/4pXwqLjFUHTXdi0/d+na7ompLRBE?=
 =?us-ascii?Q?lVD+ICiTB7dTuDmHlgre3INIDJpzxTHJHM0ug0KasGGHVDHqxMUY3saz/JDJ?=
 =?us-ascii?Q?wIQxmNX5PTl0XdzE/qz6zk5HfQPJW356vrqYSAkBo9v8+jX+Tcv0i9juL36B?=
 =?us-ascii?Q?XSBi9VIr0FaOXoCWyTuUBX+CW9Ed8LQAs0D44KcXEIYIW9legDlWVie00p3m?=
 =?us-ascii?Q?yhWQCfvQrSIbuvSfrBa6GOCgVmIc67W1kKa3A5IITC9NjDX0qzvCR59tE9Lx?=
 =?us-ascii?Q?gIfYiFTCRI8MdJUh62fzuHOigCP/AI5605ZHhx7nRYe/SaoQZBo9Y2YQXTII?=
 =?us-ascii?Q?hDCsZDLnh7BOmfUpF9c17V13JCyIikbqOJ3MeSGpZie7iFnP+xfG9ibWG1it?=
 =?us-ascii?Q?kc2diHsr8vHN3zz1RdZ3ahqXKpq3/hC6kfKUFpoJfvvHR4VX3FZunm+Eh9MZ?=
 =?us-ascii?Q?PhDQiY0rQTeK6kPaPFGVPB6rp0FleBXUFKE2zALeH8i/Qcvj9e1znZcChGga?=
 =?us-ascii?Q?z/NkSc9PSlGs7glkQedFJx5wIsXeKaeBYlRGo5/3Mamlkt0G8gex1iAcUJ97?=
 =?us-ascii?Q?nSb6RZYJpcYKVzoNiPPlpg8U31MdNeAnLkoCfXnLwrB1qDZBVt+akwgot6bW?=
 =?us-ascii?Q?J3cMvP1DGEGRoVUTRJ/O61WYcllhzXTsJ3fDagCplT92Sxb7TDorzYYKop2J?=
 =?us-ascii?Q?QrXreOVVSx5c12tqfyNghBiI5yD+hdklxx1gF4IdYYT3XeL5H8kNTpaEtc3J?=
 =?us-ascii?Q?iZTHNp6Dely5OXeQAcwa9n2a0P48gchuAjjrQnYdIcjX1S7E7HDYQEiZ7/+o?=
 =?us-ascii?Q?awr7XfL0amQ05b8APyT/UhXdN8Zq6k8f2yKGLDrVZTHxnSZK1waw5DXibayS?=
 =?us-ascii?Q?Postj9/AoG80Z6cIR4k99dl6I9t49NBGsC2n8G751B4VqhSg9Nk56xAho+CZ?=
 =?us-ascii?Q?N8TkSV/W4hC5ygLdTqcTRnfQdf/2ELzHuxqLg9FL2WSOIMlwNcqejD8Wt7dz?=
 =?us-ascii?Q?LnLiBw/uDwDnuKOyvxaK9g5c/K8cZ9n955Vkw7yGoW3bvY/6MG8k5cSAfqse?=
 =?us-ascii?Q?BqCYybaR+vusTemQ76YEaXgg5CrVRJ2qcm1+asLG8g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kzofol3zc/Qz4xdT+c5ZMoYiqWm9bEjumqA9Lk5shhSnlWcJZiEr2FPY0XJ7?=
 =?us-ascii?Q?i51A2JGWjlymzSLaq5vwZtLcPzzYl5bkW4M93BBVpkg2xy18QplsEHhaindQ?=
 =?us-ascii?Q?vKq+ZKkolkrevoebA1BxTI+fNiPUCCJUpg1jZpVC8BeOqA6yHp4lDTVRLhAF?=
 =?us-ascii?Q?a/UAac1HOxgPDpMKfECNWeyT9WHXIsNxEZcp1v/PTOxqBbni53WuF95LQCQ3?=
 =?us-ascii?Q?Istavjwd2Lnw7E1n6Txstq5IBKotQ6M7mfLhG59TB6FO56byYgDkBRTAHoPd?=
 =?us-ascii?Q?hqzuKR8thWq6Uqr12IwfRPx/NwyqB/ILelE+WS4OruEzNtmmuUBPGt9sECft?=
 =?us-ascii?Q?Dld2piUoSpJhDFBoRfo6KxnjvM0DkG2Qw9c3xDamsAKMBSyw9xSeuEvLIEGC?=
 =?us-ascii?Q?vQSULkEK5WbqkUu44tmy563oWlSwos7j8uIRWbU9aXGCtexIXo9U9YMxVpTs?=
 =?us-ascii?Q?AGOVSGj8qgRC9nJg26rchyv4azOYcZ77r2Y3kgVx/vVO8UHjw3aH/Q30ctSN?=
 =?us-ascii?Q?a9asyqSyDOlpMEHj0Jfze1HlbuyLshjHONwovCBWobibbLcaS4Jv7XJtrF8m?=
 =?us-ascii?Q?4BV/J5mxoxaWYLgs2t3b6e+jrs0Yhk9J0drXtPk9Y7Un1Ky7U5g+k7a+92sz?=
 =?us-ascii?Q?8xV0GNwTWPM8kmAqANYnVQzDJJGoDWlj8fjcUpqwQexR2+oxpCYY3ZdpNltq?=
 =?us-ascii?Q?zSgmqinU7a1RTUEbLCAYbu1vw8R37qiaW1VCskkH2SvAv1NbooF7ootN4gyy?=
 =?us-ascii?Q?MnwcI50ddk1aJ8Vmc2g/W4qg01zy9DjAA3kozcO3+E9+taJz+oVww4qXAhL9?=
 =?us-ascii?Q?cKDHAJLqBlIDXof8Dnlrr88B1jQUU7AoKu30y/0SnWGDpsF7HKPmI8dvTZRk?=
 =?us-ascii?Q?oAzy4xvQZeYyT4j/MjdaQ85iDqsMxU02/mNEKzxpik3/XdTVTme4sH5dy8q0?=
 =?us-ascii?Q?gENEImOyJML1xVzQy13hm6GEx1DZQchDMMDWsLQFLj8O1Cjola9WRS4kIiOq?=
 =?us-ascii?Q?JLc+qj/VmWgqK40bO4XJfTYdFzFupxXpg6IxvRGyWmA37Ee+/V5yJPwINlbf?=
 =?us-ascii?Q?3C003gk7Mbe2RYEU+JY5XuUHehpVHIUPwp5IIrTa505V1B7x2/kGYrbD9DDO?=
 =?us-ascii?Q?BM2nGwayYEX+5L5OyP2b5PNRPXSEP/3fu+MbT2GAiZ4+K+jWHeZwYmaaTnfe?=
 =?us-ascii?Q?1Rdb7E8us7caE/MpNiJiKL7pqsC9Yxn+77yqvTKpCYNWMRMwNrqyNi74Z04x?=
 =?us-ascii?Q?qQEGLKI+xgsBVn2+Mv/XVPeiB1uMu5Bx6ddKzyW22ldY5kohLDehqqu8gn8e?=
 =?us-ascii?Q?f0WLfsRNeCcylEYVmZNpgJIbrKQ6QdagKCW16xY7rbFPDdKgtESCkAkD2nMz?=
 =?us-ascii?Q?i/yYo9UmbFHtX0e/UZbAB6KiFQZQCyAGTl626yVfvcyTcGcuseOp9ZZG8JJq?=
 =?us-ascii?Q?KGuegEYxwzaNkbD8dzvNzKqPofuZFwGYRer/pcFi5sBFoMka8haTtncO/gfv?=
 =?us-ascii?Q?Tdo1QXmRyQGwNs9NkBR4fnvQmVoeQIT3H8sWz31yT5nFM2QOniM4ZOIHvGVQ?=
 =?us-ascii?Q?ZJinfGRs0so8QxEIGdPlDi3nF1pxWK6Cu1osuzVF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56de3d0a-409b-43ad-5b2a-08dce4513e2b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 08:47:56.9547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yqa/6Do3K60dR8QLv00XHDITsaxL2cZ1JSAjmxc6ny5GNz2g7JI+GDQ7iGzw547IuCezfbfFwvie8/zJdY0rKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8375

On Thu, Oct 03, 2024 at 08:39:54AM +0000, Dhananjay Ugwekar wrote:
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
> Use the get_init_min_freq() callback to set the initial lower limit for
> amd-pstate driver to lowest_nonlinear_freq instead of lowest_freq.
> 
> Link: https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/24593.pdf [1]

It is good enough to quote "AMD64 Architecture Programmer's Manual,
Volume 2, Revision 3.42" instead of providing a link.

Other than that,

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>



> 
> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>


--
Thanks and Regards
gautham.

> ---
>  drivers/cpufreq/amd-pstate.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index b7a17a3ef122..f8abae9a0156 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -995,13 +995,6 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>  	if (cpu_feature_enabled(X86_FEATURE_CPPC))
>  		policy->fast_switch_possible = true;
>  
> -	ret = freq_qos_add_request(&policy->constraints, &cpudata->req[0],
> -				   FREQ_QOS_MIN, policy->cpuinfo.min_freq);
> -	if (ret < 0) {
> -		dev_err(dev, "Failed to add min-freq constraint (%d)\n", ret);
> -		goto free_cpudata1;
> -	}
> -
>  	ret = freq_qos_add_request(&policy->constraints, &cpudata->req[1],
>  				   FREQ_QOS_MAX, policy->cpuinfo.max_freq);
>  	if (ret < 0) {
> @@ -1706,6 +1699,13 @@ static int amd_pstate_epp_resume(struct cpufreq_policy *policy)
>  	return 0;
>  }
>  
> +static int amd_pstate_get_init_min_freq(struct cpufreq_policy *policy)
> +{
> +	struct amd_cpudata *cpudata = policy->driver_data;
> +
> +	return READ_ONCE(cpudata->lowest_nonlinear_freq);
> +}
> +
>  static struct cpufreq_driver amd_pstate_driver = {
>  	.flags		= CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
>  	.verify		= amd_pstate_verify,
> @@ -1719,6 +1719,7 @@ static struct cpufreq_driver amd_pstate_driver = {
>  	.update_limits	= amd_pstate_update_limits,
>  	.name		= "amd-pstate",
>  	.attr		= amd_pstate_attr,
> +	.get_init_min_freq = amd_pstate_get_init_min_freq,
>  };
>  
>  static struct cpufreq_driver amd_pstate_epp_driver = {
> @@ -1735,6 +1736,7 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
>  	.set_boost	= amd_pstate_set_boost,
>  	.name		= "amd-pstate-epp",
>  	.attr		= amd_pstate_epp_attr,
> +	.get_init_min_freq = amd_pstate_get_init_min_freq,
>  };
>  
>  static int __init amd_pstate_set_driver(int mode_idx)
> -- 
> 2.34.1
> 

