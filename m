Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC2F4436D5
	for <lists+linux-pm@lfdr.de>; Tue,  2 Nov 2021 20:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbhKBT7R (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Nov 2021 15:59:17 -0400
Received: from mail-bn8nam08on2057.outbound.protection.outlook.com ([40.107.100.57]:9057
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229906AbhKBT7Q (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 2 Nov 2021 15:59:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mg9kR0Rsdcb+HyKhaLAIjo6OLEO8yT749s0/JbXj8W0ob1m7exIZ/YIreae+q97R9nxf7+5to7i3HSar4Ocb0psyAoJrBaq+7fhnPHygtAoqzQzICthf3EIG+GrdrtUwHJtKXb46h4frUUZ2RyvwwQbHf8Ox2dfo5dTnJlpTzOr1AhDwqHNoM95+9jviICvckHy8kRhylJmK7H/NM2VxFnQHguW3hg0l89Rn/3dsa1lmK8DXQejb0GNmRqwUulyTVjzF25kDLFFh6lYgN9ubeiVeiVQNsxFuLn5S4nvWpkQZvFL6uW8kRjR77QXATNtg6Sy8wxaOPiCmuBSzPfIVbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mraz7Z9BmbdNnMAVf242AYb/XU2RSbcgvM2FmUc3fj4=;
 b=A71gqsy8FFDiLIR/Xuy+lhgzksFjksvQXv5ASmPpPPUnxUQ5ofah0F88SAg08ATQnjt9j8INwjXao3JT/iccqPeKJSqepjopnzOjEFQ+NWLdzCB1qqqZmROY/XcXFl3g4HkXS9H/kj0i3KXLm8goR3R+Ig11oPsz2r1BoTPuxlEJ6JJesPLfZ8aHY8R88sjsvv8WIAPj01dFcraerkEQFJF61VAuT5c9hcOw6FISzW2Mr5C/tykYKKZXAW0i1N/Pnl0XpLEfFN/mju1EVvRo/SFTpsu9ZxBc/f0xaHbySeQzXUZnjjQJlhvLXTGdnywyZ4ZxqVgw/XI6Hli2bclfZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mraz7Z9BmbdNnMAVf242AYb/XU2RSbcgvM2FmUc3fj4=;
 b=vEzM47VytShIeIFdkojhtOU0h/XEN0YEaWpq3V0ToPvZd3dND8VHzhHxbSbfTkufpJ6SrmbwK4b5o3cKptp6Z8Qx1Q9/vPSn5ivRus9ai/uKhqDpXl0OkRxjusHpV8QT0nY1Eq1Vp03+1y1HItOtfHZ9wRz1HHrNlLrIIh6kaes=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4720.namprd12.prod.outlook.com (2603:10b6:805:e6::31)
 by SN1PR12MB2479.namprd12.prod.outlook.com (2603:10b6:802:29::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Tue, 2 Nov
 2021 19:56:38 +0000
Received: from SN6PR12MB4720.namprd12.prod.outlook.com
 ([fe80::c4b9:b9bb:e863:af39]) by SN6PR12MB4720.namprd12.prod.outlook.com
 ([fe80::c4b9:b9bb:e863:af39%5]) with mapi id 15.20.4649.020; Tue, 2 Nov 2021
 19:56:38 +0000
Subject: Re: [PATCH v3 07/21] cpufreq: amd: add fast switch function for
 amd-pstate
To:     Huang Rui <ray.huang@amd.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        linux-pm@vger.kernel.org
Cc:     Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Steven Noonan <steven@valvesoftware.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
References: <20211029130241.1984459-1-ray.huang@amd.com>
 <20211029130241.1984459-8-ray.huang@amd.com>
From:   Nathan Fontenot <nafonten@amd.com>
Message-ID: <d8f03175-1355-6b03-6146-5b0ae9aa1e97@amd.com>
Date:   Tue, 2 Nov 2021 14:56:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211029130241.1984459-8-ray.huang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0165.namprd03.prod.outlook.com
 (2603:10b6:408:f4::20) To SN6PR12MB4720.namprd12.prod.outlook.com
 (2603:10b6:805:e6::31)
MIME-Version: 1.0
Received: from [IPv6:2600:1700:271:b60:1e21:1149:b336:3db3] (2600:1700:271:b60:1e21:1149:b336:3db3) by BN9PR03CA0165.namprd03.prod.outlook.com (2603:10b6:408:f4::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.17 via Frontend Transport; Tue, 2 Nov 2021 19:56:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06c73d84-9789-4981-6c9a-08d99e3ae1dc
X-MS-TrafficTypeDiagnostic: SN1PR12MB2479:
X-Microsoft-Antispam-PRVS: <SN1PR12MB24794AF8DA57877415E671FEEC8B9@SN1PR12MB2479.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iRQUWO27mqBpzXblaDpqx+lubpAuAakrrtHZ7w3vzoaG4Bzj9YVJPw0JKmmZgh3TzHGv4gx4OPIZ3P//NSocNLztwTOCijPPR625yeQgbUs1O5uzkDifN6M5maVtgFlA5t8SL8wCLK0S+/zJBm1IFkbQqBvgb97XzdTUMDfitRravsX3WbSZD2QtHyjAlEnNIz/UZi8t8Pbv3d7xVmh2WsxyIByhZStvKBHHVvQKcqWZN5v8bxy5TdLjTtI1HuiaXy3bELs9EaSjlz+gl4USdoMuC8GiJZQqm1bPHt/vGec7Cuc7a8yi4FoB10k2dltXOGGI8MRno3fliTNpGoqCu+Jy5chzcUtzRUUINFR1HHZbtYrDkNhXBA0JeMMQx9MonDMaOly1/IL3E7e/K294NE/IospgoNbr2n0MkKcBWGu33g44IudVqALj5PK0R5H0BU/TqIMvMuwDXqnJ+AIkwtbnjb8oQ45UfITpAWRh6K//QAdAbFtiMNTEqNf4ka9FS9C/fUKi4DFEIJr2w5GWSIZI9oCI1+i29sOlQ5l9G9H6noNEqMXFsc+NksX8EeSr76hTCqAR0R6wX2QGeYG8tfjd0m0a5tsTFX7voz3bzqYjrxwq9bs9xtPUcDXAq4u0MAhg0zBlJ8kQ5zjrt5XHX8KUWSbxPKW12Kp2aFfc9J1gI3KIKlk56sl/Zw0dYE8K7ke/xlYn/6TMxWdRLVq4ecgnC5Waz9zkXnxERp7/ID5HNWV92IF5T6BiN6Ldr5LU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4720.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(508600001)(4326008)(316002)(83380400001)(110136005)(7416002)(2616005)(8936002)(6486002)(31686004)(66946007)(2906002)(8676002)(31696002)(66556008)(66476007)(5660300002)(36756003)(38100700002)(186003)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2ljUWpHc2NjbFJkR1FzR2gveVJiZ3pKRmVabWQ1dnpIWHVtek1FUWYwZ01L?=
 =?utf-8?B?Z2gxZXhaTmlKWG5EL0ZIWVVrRlVIRjlvQldVdExiaXplSFdMTjdQMk1OYVJN?=
 =?utf-8?B?K28xSmExVVpXNDYxbm1SbU9BWHEyN3VXSy8wNGl5SUIzTGZNV09vaUp4ZVdK?=
 =?utf-8?B?c001b2thLzJzY3dMa0thY2ROclowbXV0ZzRhSEtONW1UMGdUUGFUMkRKK1cx?=
 =?utf-8?B?Vlp1KytBWnFKRlRBK3pxcnh1OStHMjF1NnBWemFrVjM4NHhTQnEzOU03elJh?=
 =?utf-8?B?TEFoekZHTXFjK2I2Nkc5ZDh5OE5ybGR6UmxweXNKUkVOc2NvS2FSNFF1VWE3?=
 =?utf-8?B?WXppdFY5TlVZanlaMHBiWGg4bUJ1c2puZjBOZ3R1cytSckVhRkY0N0VNcWFu?=
 =?utf-8?B?SmpSUDNRU2JMKzVTSUg3TVhmQ1piM3R0UWJVUWxJRlhMUC9JbVBDMjlCSktw?=
 =?utf-8?B?Q1NxK2YzVnNwUi9PalRsMVJZNHZzamxLelk3WnFTSkpQWHhnK3NjN1NzT1RY?=
 =?utf-8?B?Y3Q3UDlwOEdVK0VWVXJWTFQ1dFBWRlJ2dUFwYlYwRjd2VkZJT1NyNGRrMXlM?=
 =?utf-8?B?NVE3UGZ3djJkN2JjMEhkWGNCL1N4bzE1NkVIc2FjVmJmbkxtUVhrMWdrR2Mr?=
 =?utf-8?B?N2pBcmcxUlpoRERnSWlmakF4c3A5VzkrT1RrYU1sdFVrc1VlVG0vTWlhRnJa?=
 =?utf-8?B?aXA0RUduSC9NdWhBSHNVbDV2K3plSlhocHBEOE9ieG9LV2tuSFA1VzhaS0Y3?=
 =?utf-8?B?OFl0OWpwSTRleVlKUDhJWStvRVJtN3V4ckNnRGQ4Q2FJY1BDN20yR0NrMm9E?=
 =?utf-8?B?ejdVZ2x4YWtCSnJnRTZVZ1dkM3UxbDU1cUl5M01PVUZXNWJwMDdvYm5Sb0RL?=
 =?utf-8?B?UlJFa1N6L01sdVpGdkh2Uzl4K0p1SGw0T1VhNkF3aXc3WFhNUWFQUmwrWlNn?=
 =?utf-8?B?T1UxSm1Ia3A3Y0J6akFmdmZmNXhuaGM5TXFLTHZrRjVCZXNzNXkxWkkyQVJq?=
 =?utf-8?B?aFVQa3Y5VTJEYzBzTngyLzBwT2RRUklYY2h3d1E0NUozV24rOU1BVDEzTUtm?=
 =?utf-8?B?eHNwSkdrRTlpRm4rM2ZqbEFnSDFTa3g0aCtZL0dBL01NdnNYU1BxY0tNRnRp?=
 =?utf-8?B?R0dMSzhzNzZ2ajAwYmtocnRSWWdIR1BQbzkrbTVuRFZrV3o4R3VrdWFSbHZY?=
 =?utf-8?B?M3hFWlpMYTVjVjlGcUoyWEpMOWpUVnFrMHVRbTc2c2VNK2pESkFLM1YrSjRJ?=
 =?utf-8?B?VmtLRzFzVUFHMUFPUUdrdWJUWDBaNjdubEFxalc3M3RqZGRFSitwcE5ac21N?=
 =?utf-8?B?bVZya09RellKTW94NmYxM3JwUG05M0l2Tnp0WEVXNUJLdHIwb1piN3dDcU1L?=
 =?utf-8?B?VTk1VXVNaGJsRVRadm9tdVo4NCt5SDcxZFliZ1JHN3kwNHRkZWJReGNYY2lW?=
 =?utf-8?B?TVdGV3FyZlRhMXZWRXd1WkhkZkFnZHZJZ2YwVHhBTElVRGlJNU9xN3lqcUhI?=
 =?utf-8?B?V1d3QjJjeTY5WThLNEFiaEFCcG1NeWJCYk9hbHJTTlAwL3cyYnhpbGdkS1U1?=
 =?utf-8?B?K2NSWFVZN0kySWVkenJUOEoxNEQ2UXBoamIzdmZTR0hTUzZlYjZ1aEk3VzRQ?=
 =?utf-8?B?U1kvcTFLVzA2b202Y1p3UkRuZTlvaFdEYmY3YXZRejFKWGNvTGxVcDVIdXFi?=
 =?utf-8?B?VXEwYWNhcC80b3NYOWVMTlgxbThuS1d5Ym5UMmVmeWN5ampNSDkwV2RzcWd0?=
 =?utf-8?B?RitqUUVqU3IyZG1uZGw2aXBrOTlGcFRGWC9oVXhPTVVxUmNPVUp5Mkxya0Nj?=
 =?utf-8?B?ZHJ2cFVOSndNL0pyMXkvMjNaSk1kTFZ4a2dzNnByUHcvZ0dHUUlSOHJzaGNo?=
 =?utf-8?B?MzlWV25SWjlEU1ExU0kzU0dJWm9SeXBoWVFGeTVwbk9wU3VUMzBYSWlEdFVW?=
 =?utf-8?B?eUhSY0ljNlV2MkhTQVFSemNjTTBMcW5RYzFjV1RhNjFPT09NUWhqMjcyWXM1?=
 =?utf-8?B?NjhyT0hmbHo2d05ULy90TVk5WThIaDBzTmVRM3M3VGE2QzVpT01iZ3JncEx5?=
 =?utf-8?B?UmkzRGNsd1crOUo0bHczaFVEVTg3S2NNa2FDQVpYdkNLc0ttUlVGdWcwZ29Z?=
 =?utf-8?B?bE5QUWNWNmV2UExVQndJVW9KRlBCK2ZnWG9lK05BQ2lmMkxVVHlMMVhKS3E1?=
 =?utf-8?B?V0Y4M0NKclE4a2lTZ2lmelJoY0ZXOEhlbDcwcHNoVC9LczFmb3ozY29WNVpK?=
 =?utf-8?Q?ZaE3Zcr6mPWNha+3N2+zjB5qmCJ2ZvN2Gt8iUXJ7a0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06c73d84-9789-4981-6c9a-08d99e3ae1dc
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4720.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2021 19:56:38.5386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8+lCx5psOSasXWjHaDSp+MOecl6htSHPDEgZq9+A75L5hC0cc0CKDG5m2vIlzsLjGugsazIcFx9lC4STV6lORA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2479
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/29/21 8:02 AM, Huang Rui wrote:
> Introduce the fast switch function for amd-pstate on the AMD processors
> which support the full MSR register control. It's able to decrease the
> lattency on interrupt context.
> 
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 38 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index a400861c7fdc..55ff03f85608 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -191,6 +191,41 @@ static int amd_pstate_target(struct cpufreq_policy *policy,
>  	return 0;
>  }
>  
> +static void amd_pstate_adjust_perf(unsigned int cpu,
> +				   unsigned long min_perf,
> +				   unsigned long target_perf,
> +				   unsigned long capacity)
> +{
> +	unsigned long amd_max_perf, amd_min_perf, amd_des_perf,
> +		      amd_cap_perf, lowest_nonlinear_perf;

You could drop the amd_ prefix to these local variables.

-Nathan

> +	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
> +	struct amd_cpudata *cpudata = policy->driver_data;
> +
> +	amd_cap_perf = READ_ONCE(cpudata->highest_perf);
> +	lowest_nonlinear_perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
> +
> +	if (target_perf < capacity)
> +		amd_des_perf = DIV_ROUND_UP(amd_cap_perf * target_perf,
> +					    capacity);
> +
> +	amd_min_perf = READ_ONCE(cpudata->highest_perf);
> +	if (min_perf < capacity)
> +		amd_min_perf = DIV_ROUND_UP(amd_cap_perf * min_perf, capacity);
> +
> +	if (amd_min_perf < lowest_nonlinear_perf)
> +		amd_min_perf = lowest_nonlinear_perf;
> +
> +	amd_max_perf = amd_cap_perf;
> +	if (amd_max_perf < amd_min_perf)
> +		amd_max_perf = amd_min_perf;
> +
> +	amd_des_perf = clamp_t(unsigned long, amd_des_perf,
> +			       amd_min_perf, amd_max_perf);
> +
> +	amd_pstate_update(cpudata, amd_min_perf, amd_des_perf,
> +			  amd_max_perf, true);
> +}
> +
>  static int amd_get_min_freq(struct amd_cpudata *cpudata)
>  {
>  	struct cppc_perf_caps cppc_perf;
> @@ -311,6 +346,8 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>  	/* It will be updated by governor */
>  	policy->cur = policy->cpuinfo.min_freq;
>  
> +	policy->fast_switch_possible = true;
> +
>  	ret = freq_qos_add_request(&policy->constraints, &cpudata->req[0],
>  				   FREQ_QOS_MIN, policy->cpuinfo.min_freq);
>  	if (ret < 0) {
> @@ -360,6 +397,7 @@ static struct cpufreq_driver amd_pstate_driver = {
>  	.flags		= CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
>  	.verify		= amd_pstate_verify,
>  	.target		= amd_pstate_target,
> +	.adjust_perf    = amd_pstate_adjust_perf,
>  	.init		= amd_pstate_cpu_init,
>  	.exit		= amd_pstate_cpu_exit,
>  	.name		= "amd-pstate",
> 
