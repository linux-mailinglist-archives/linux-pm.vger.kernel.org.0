Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06D3343FE53
	for <lists+linux-pm@lfdr.de>; Fri, 29 Oct 2021 16:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbhJ2OWo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Oct 2021 10:22:44 -0400
Received: from mail-sn1anam02on2053.outbound.protection.outlook.com ([40.107.96.53]:18883
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229692AbhJ2OWn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 29 Oct 2021 10:22:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y9/81dMG5xzTkw3tQRqRrlVh01PtAwvjthd6rAWh3lF2Rs2CvYRuKD9myL/NWdSglugwKixQ21K9iUcAn4Rzg3LXLXspEgjgjLmr6gzV5G5K2Zrwdzc6ULMBMKTEiqNSaXijWEWOctJPfm2gsJ8lcVwsH5IM/etBJMsLoVSFwk7JuMAcUbl/qR7ZOHsGxKiUsgF2In5iV39OgtMK/xIv9u/aUeXY/TF0F8tabqQOFmBYnBmLABLIXbXbfnxrOU2hdF3VBEh2jBmzxQT2Zo4eR34ky1pRmKxGzgadPsudDhwb13q0CXN1vzmVxSxQBxRnuSwqzBINqBtdDDCFOZcDYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VrGLj/zbr5cU0Rvg8NHVBCSFkwLT+eFJ72+6pHaPONA=;
 b=fIrAld4RXyyLYMDZysvvu23b1ATHsI3V3mZo+KWoUo6U42DFYqV/8yWOZkTfzvQvQWwieu/jYAPHlrs+PBDjBdp0RLYADDp2vcNdvO3XbOCTlMcnT4IamgbDpwjzZ8Hh2C2HmUC16rfrRNSczEgxMLPECkV0EyJWDAIQyuQ5AHKEntusLvDwr8Drg42E86CvGiCC9n+f3q+7ZWfZwBPYpOBYqlWAg6fEzGYXjAeg2NSzT7SHrG0jBuDp8SHoqY6+y7LFnH5AVDNWmz2ksT23Kp1dOM3TQYc8KNVTMhg3LjigZo3854rBCAfeR6m8TvH264mrwfXh33wbZ1PVgxJyzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VrGLj/zbr5cU0Rvg8NHVBCSFkwLT+eFJ72+6pHaPONA=;
 b=3lw1wu7R9PAStNTIOwlYJw0q+z8oted8D9ckKV8ydPv4qS6W8f4A4bwPugVTfkKO+Eo8QIBkwgJVLDYmHHO4/MDQDoqTBhHvhtU7Qu1hEHqWFkd7X3zIfn/szNNdZ22u8aWdVH0UyZ7pLe+zE6cOYoP+zxJtRdyruAXiJf8FVTM=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8)
 by SA0PR12MB4509.namprd12.prod.outlook.com (2603:10b6:806:9e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Fri, 29 Oct
 2021 14:20:13 +0000
Received: from SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::7cbc:2454:74b9:f4ea]) by SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::7cbc:2454:74b9:f4ea%6]) with mapi id 15.20.4649.015; Fri, 29 Oct 2021
 14:20:13 +0000
Message-ID: <16386852-7ccb-47de-5b29-b64481b59237@amd.com>
Date:   Fri, 29 Oct 2021 09:20:09 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v3 08/21] cpufreq: amd: add acpi cppc function as the
 backend for legacy processors
Content-Language: en-US
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
        Steven Noonan <steven@valvesoftware.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
References: <20211029130241.1984459-1-ray.huang@amd.com>
 <20211029130241.1984459-9-ray.huang@amd.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20211029130241.1984459-9-ray.huang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR22CA0011.namprd22.prod.outlook.com
 (2603:10b6:208:238::16) To SA0PR12MB4510.namprd12.prod.outlook.com
 (2603:10b6:806:94::8)
MIME-Version: 1.0
Received: from [10.254.54.68] (165.204.77.11) by MN2PR22CA0011.namprd22.prod.outlook.com (2603:10b6:208:238::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend Transport; Fri, 29 Oct 2021 14:20:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3317e04-19ee-441d-c034-08d99ae738f0
X-MS-TrafficTypeDiagnostic: SA0PR12MB4509:
X-Microsoft-Antispam-PRVS: <SA0PR12MB450945649964DAF427A76D01E2879@SA0PR12MB4509.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eFNndGokKc4Jbr7nEPX5D6eFuP8PvflZ9MzMtijHJHkkNLWlWSQ5hNEbTaiEEVf8OYZ61+VeBaxh8yeRyKQ6wbss/EQMhABlvzgQxi1DSvhjCGuEJLVIn1xYKjjhVZvWLgAAc/UiaVfzX3iv3QYKP3YkNibrOO9EaKUGv2KBYMmPFwo/dw82Pd6l80dwoNoXPTKfDPwU+BmrgPqjGR+9msvfCY9WznZ/Gmzkp+uGiCGVw2G2Ur272Uy/lHF3AysXUew+NL4KYwHtZBftk8R9NzGcVoDddYmrWQJmLjIv/8RxLIUm6itgtm7PipuFISqVs6aEnlq8HTSFl4tFQ7UcAg8CfeKBQmwvSA3nQfdiRBjpwQYyfC8CD9afyr2gSpNgGjsOHGkwBPrq/A0md3HACIwxBuP3yKn1NRwF9D7JznDBEyTNq1FgPgChZ3BQT/ZPZCPt92Asf1NC0NvUbYVwNgSRSiAKruZTiJ8aAgkgkv1USmooC9JcOpS/C+7zVAQtA9bZZqb3rTuM+SxwVWrNT3vZCqV3aEk0yfSGVkH4VXFGALwVhhOeaEZzrxOxg85u1zgH7k49ZEpGGhGXFf+zjO3oZ68ISoOopDlsm99aIE++UrGC5AANrsI4wvYkPJDaESxX0kL0H24fXwxiWbnzOW0tVLnkhQiqCfKlADexkUJw7h6wSbax+ESQ0BWmAQ/P1VkbaJtMOQiQQYamnoIWtC+jfeZsvmRYECbB6ZVuwVty6NHKf8uLzVFpwpGD5whj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4510.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(7416002)(956004)(36756003)(2906002)(16576012)(66556008)(83380400001)(110136005)(86362001)(66946007)(2616005)(8936002)(4326008)(66476007)(8676002)(5660300002)(53546011)(316002)(54906003)(6486002)(31696002)(508600001)(186003)(38100700002)(31686004)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGZnTFZQYnhXSkhzcXNzbXBOZXlpd3ZvN0hrSXRMUm5XaGpKampaSmtmYXlM?=
 =?utf-8?B?Z0ZsakNiTStTRG52REJWYUZZbFZtdlJTYTBQd0dQQ2wxdkN6NTFQaWRRWVJu?=
 =?utf-8?B?bWVOZzBRMnMyRHlJK3BTMkpneTRZMDRWOGpRanc1TU5mOHRaM2ZFUFNJS0lm?=
 =?utf-8?B?ekVBV1lGNmpBamErTTkvdVpkVmJheHhpUTNCOGFFUkFoMVo1Qm9udHFjTEY2?=
 =?utf-8?B?YXFtVzZDMHVrU2x4Q2xoNncyZHVZSjF3dUJWVEliU1BnWHBYMEI2NTdQSjd6?=
 =?utf-8?B?VXJObGIwTGJCOFd0amlkSHBoUUdZZU80ZlJ6RG1neGNvZ2JuQStMaGlMUnZq?=
 =?utf-8?B?V21pbk5KL1hrVmdpU2l0VWcwSzdKYzNFSWdWRTMzRW4rVnNCSThERDI5QnIx?=
 =?utf-8?B?eGY2RVF1SU82N0JIdnZTMlc5U204dWM3L29Sb3lkMm02RmVkU3NUNVc1N1pt?=
 =?utf-8?B?aXFZcEE1SEdFZDg4Z2VlcmlOT2N3WGhpYjQ2cHVyMTJwN3VQOGdpM3ZjQy8w?=
 =?utf-8?B?RkRsVHVCdXJyUGpTeGE1Sjl4dGZSZExOK0Y5Rjg0M0V3bW42Y3hGbGVlT3V1?=
 =?utf-8?B?ZlBXM3pGRzI4V2xRK0RJWTdhSWVoam5VWTcwQnk0WHlIeWFMell5ZU1sd3Rs?=
 =?utf-8?B?SW9CVExndDhITWN4YWYyQjVpc1NzUDM1S1NTTXBrL1VjL1lRdHoxS1dzSmZQ?=
 =?utf-8?B?MHpQQmZlVi9KMDhNOWFXdW4ydHg4cGZ4VkNxVUlwL0lLVitoMGsrTlhJQldv?=
 =?utf-8?B?eWJyR3kwRklXc25GUFRpVHpDVEFOc2tBOGVMaXBRQUJEbThmN09WWWRZNWtP?=
 =?utf-8?B?M2U0UHk3QXFYVVFXVkkzaDNkb2ZzZ3dmR0tJcExXTWhCSHRWTFdySFh1SHhI?=
 =?utf-8?B?UzE0VmNKQldqc0pxZ1ZiSUcwQW43empSQ0QrU29ocjRyNVlrNXhIRWg5UWk3?=
 =?utf-8?B?M2NBb3RkS3dxL21HNHVjVXRGUmhmdmdTeDZTU2M3dkV0eVBRV2d2Umpudi9E?=
 =?utf-8?B?endJR25ZdkFYSEIwYWhkbjhRZ29rb0NEbE13ZmhGa2VWZXZ4dmtyRTVIamsv?=
 =?utf-8?B?N2FwVys2VmYxQTJjMHMxblRvNENqOXhnUHdYMXg4SWZIbVZEanB4UXpDRFRK?=
 =?utf-8?B?K0RkSDNDQVBwUjFhRkpwUnZxRENPS2lYbFlTSGJqOHVoV1MrQ0JmRzE3NE90?=
 =?utf-8?B?TVBBdStrUW5sdWV0SHkrc2ZOdkJYNkNobXRLam5CMVpad0JuSTgrK2NQdGE1?=
 =?utf-8?B?Rm5MSWNUdGQ5Z00rSFJNLzlFVVFuTitGdzcrZEV4anRkUUYxQjVYS3loaGFS?=
 =?utf-8?B?WnNMWkdTcmRRTEliQzB4dVUrUGV1eHdDMkNEc1cvbkhVMnd0QUhBWWhaaXll?=
 =?utf-8?B?WUV4U2hkZW56ZVBWaEdOVmxudXRxSlhmN0xrd1FSeDJrd2RDNWtFYnRQZVZn?=
 =?utf-8?B?YW0vZC8razM4eXd5bUQrOFNVVWVuUW5CU0JwamlhWVNwYXczdjNaK2xWTXlM?=
 =?utf-8?B?SXZGalZKVVJON3B3dS9pR1FTNlg2WXhGWWwyQUxBM0VRWkhOMWFWNFpqRFFG?=
 =?utf-8?B?cFM4ZG5yZjhWTEl0NVdrK0xkV0hXMnE2Y1N5YlFIOTllS2d5UjFhUVNVSmpS?=
 =?utf-8?B?c2RYOGsrSkY2SjB2RmpxMFphanpYRUl5bkcwTlBtT05lOGpVMUtCTHJjOG9H?=
 =?utf-8?B?eW9yaHZHTWxRUVNlZlA0bldvL0U0SFZsQWtraHQvc0gydEQ4TU5zYmJ4L0p6?=
 =?utf-8?B?b2xoVFJ6c3hqM1VKWDd2bmlnUTRONHdLMWkzWktJMUZ4aWpucjBOYXo2dmpF?=
 =?utf-8?B?SVBtTkN2UXdNaHU5Z0hpZE1jZzJQc0ZvWVl2c0lQWUtFb0owbnRJazVzNUJV?=
 =?utf-8?B?TjYzU2szVkw1R0lhRTNWSkNSRXYrSTVsb1FTajUvbUo5U3I2b3c3WWRwREh2?=
 =?utf-8?B?OVJ5Yzd5VTEwejJ3WU1oVG8yNHcvZXNZMjVjMHB1TUkvR1RncXRQS09KRkFV?=
 =?utf-8?B?Z0NnOEpjZ3ZDcHZNS2N2T0VOTXRvVzVCSHc4ZEpXZVVFRGZiOStNYVlDazZX?=
 =?utf-8?B?ZXh3cWhMaU5GakszcGVxb01QRXprTTI5THpBcEF5V1hsZ2hLVkxGaHdKU2pY?=
 =?utf-8?B?N1NIZXIyUjd3ZUZXN1kzY09SdWg0RzBzZlVQUGd4YUoyOUZ1cTBxQjJ2TUha?=
 =?utf-8?Q?uSOTwJ3sKydbceDdQDKNs/0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3317e04-19ee-441d-c034-08d99ae738f0
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4510.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 14:20:13.4603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q56NEN+a99MjOpPT2Ff6aPk2PFQBHcSrn0eplkS7ULIlm2rSX0KUt4jblbzo4LCRKEQptRZlm852x4Ixv4AYEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4509
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/29/2021 08:02, Huang Rui wrote:
> In some old Zen based processors, they are using the shared memory that
> exposed from ACPI SBIOS.

I don't think this is only "old" processors.  I think there are "new" 
processors that just don't happen to implement the MSR too.

> 
> Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
>   drivers/cpufreq/amd-pstate.c | 58 ++++++++++++++++++++++++++++++++----
>   1 file changed, 53 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 55ff03f85608..d399938d6d85 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -73,6 +73,19 @@ static inline int pstate_enable(bool enable)
>   	return wrmsrl_safe(MSR_AMD_CPPC_ENABLE, enable ? 1 : 0);
>   }
>   
> +static int cppc_enable(bool enable)
> +{
> +	int cpu, ret = 0;
> +
> +	for_each_online_cpu(cpu) {

I wonder if this should also be changed to present CPU instead of 
offline CPU.  Otherwise could this turn into a situation that the user 
starts with some CPU's offlined and enables them later but this doesn't 
end up applying to the CPUs that were started offlined and changed?

> +		ret = cppc_set_enable(cpu, enable ? 1 : 0);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return ret;
> +}
> +
>   DEFINE_STATIC_CALL(amd_pstate_enable, pstate_enable);
>   
>   static inline int amd_pstate_enable(bool enable)
> @@ -103,6 +116,24 @@ static int pstate_init_perf(struct amd_cpudata *cpudata)
>   	return 0;
>   }
>   
> +static int cppc_init_perf(struct amd_cpudata *cpudata)
> +{
> +	struct cppc_perf_caps cppc_perf;
> +
> +	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
> +	if (ret)
> +		return ret;
> +
> +	WRITE_ONCE(cpudata->highest_perf, amd_get_highest_perf());
> +
> +	WRITE_ONCE(cpudata->nominal_perf, cppc_perf.nominal_perf);
> +	WRITE_ONCE(cpudata->lowest_nonlinear_perf,
> +		   cppc_perf.lowest_nonlinear_perf);
> +	WRITE_ONCE(cpudata->lowest_perf, cppc_perf.lowest_perf);
> +
> +	return 0;
> +}
> +
>   DEFINE_STATIC_CALL(amd_pstate_init_perf, pstate_init_perf);
>   
>   static inline int amd_pstate_init_perf(struct amd_cpudata *cpudata)
> @@ -120,6 +151,19 @@ static void pstate_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
>   			      READ_ONCE(cpudata->cppc_req_cached));
>   }
>   
> +static void cppc_update_perf(struct amd_cpudata *cpudata,
> +			     u32 min_perf, u32 des_perf,
> +			     u32 max_perf, bool fast_switch)
> +{
> +	struct cppc_perf_ctrls perf_ctrls;
> +
> +	perf_ctrls.max_perf = max_perf;
> +	perf_ctrls.min_perf = min_perf;
> +	perf_ctrls.desired_perf = des_perf;
> +
> +	cppc_set_perf(cpudata->cpu, &perf_ctrls);
> +}
> +
>   DEFINE_STATIC_CALL(amd_pstate_update_perf, pstate_update_perf);
>   
>   static inline void amd_pstate_update_perf(struct amd_cpudata *cpudata,
> @@ -346,7 +390,8 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>   	/* It will be updated by governor */
>   	policy->cur = policy->cpuinfo.min_freq;
>   
> -	policy->fast_switch_possible = true;
> +	if (boot_cpu_has(X86_FEATURE_AMD_CPPC))
> +		policy->fast_switch_possible = true;
>   
>   	ret = freq_qos_add_request(&policy->constraints, &cpudata->req[0],
>   				   FREQ_QOS_MIN, policy->cpuinfo.min_freq);
> @@ -397,7 +442,6 @@ static struct cpufreq_driver amd_pstate_driver = {
>   	.flags		= CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
>   	.verify		= amd_pstate_verify,
>   	.target		= amd_pstate_target,
> -	.adjust_perf    = amd_pstate_adjust_perf,
>   	.init		= amd_pstate_cpu_init,
>   	.exit		= amd_pstate_cpu_exit,
>   	.name		= "amd-pstate",
> @@ -421,10 +465,14 @@ static int __init amd_pstate_init(void)
>   		return -EEXIST;
>   
>   	/* capability check */
> -	if (!boot_cpu_has(X86_FEATURE_AMD_CPPC)) {
> -		pr_debug("%s, AMD CPPC MSR based functionality is not supported\n",
> +	if (boot_cpu_has(X86_FEATURE_AMD_CPPC)) {
> +		pr_debug("%s, AMD CPPC MSR based functionality is supported\n",
>   			 __func__);
> -		return -ENODEV;
> +		amd_pstate_driver.adjust_perf = amd_pstate_adjust_perf;
> +	} else {
> +		static_call_update(amd_pstate_enable, cppc_enable);
> +		static_call_update(amd_pstate_init_perf, cppc_init_perf);
> +		static_call_update(amd_pstate_update_perf, cppc_update_perf);
>   	}
>   
>   	/* enable amd pstate feature */
> 

