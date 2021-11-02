Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54AEB4435F8
	for <lists+linux-pm@lfdr.de>; Tue,  2 Nov 2021 19:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235534AbhKBStg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Nov 2021 14:49:36 -0400
Received: from mail-dm6nam11on2077.outbound.protection.outlook.com ([40.107.223.77]:14017
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235948AbhKBStS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 2 Nov 2021 14:49:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RVKwvO0QMzRtW0mToXxnxgLYHOaFZNUR2U61wRCzaXV2e++2BwiNq8UQIB+7ETYaYunY+zD8uWjuwOc/UdNbyfn/R4TKzMex8J8zFYWUiLd3+NWWguvsT6L4Wb28TXTKYxLkMwto9mErt6nnSa+s6Ije1bNPf5G1uTKeBeHlRm/WyQlt8NLvrFp5SMl24CNdD9BKHqLUqYuEAyHNngve9GlZXvK4G1Tc+IXqigqA3jQGMJjCvaKbAhsRZdjN8n08ykm4a5jBpc1cqWYDQhPNWZ4pmRPzjUXPhCbfhAW55EJuOC5uFHW+jB2/gupPFwsCRcBnwYvyw1SZG8IIsv9htw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s1gb/0+N5dmVahMl9xjI6L/ViDusn5uiM2RLua0idfI=;
 b=cIh5yTE+DCaI7G5wjNR6rvMasi6jSI7ky7HTQjRRE13aOEKtUbMm4SQ8rB/aOnZzsWlrNR4uvusV38rHu9UMOhXA0ya/MFbM4W+LI5Usm383ZRwNiwECB9l3zIWn9EfvSfmCSIjoz4na/I8FZi0AJFn5dKtj2TyHn2kLm+OPFV8aNm5JolloOR43aXInSbEG6eh7oy9G/9IwfAV9s3ekjwZgMVpdyVVxp3/gVV9yS/o3DI0kadZfDyE9Z9t/BRJSpE8IEGHqO9pe/9M1Na0AvaQ6YcolfTOFi2T0klSLGmp0wjkQSxtFGoVdkQs8krQxP0HTyBRKXeJ08SrhbgJxUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1gb/0+N5dmVahMl9xjI6L/ViDusn5uiM2RLua0idfI=;
 b=asggQnesp87LV0j8GVD5wVTtP88xI9Z0gkNegaCDIi2dpbiWdhefg3Txq/fUUGM9akUyMlnL1PO+JeWLs95bVfr/TEuYJyHuUFlmdmUO1NV+DZBOBz4scBsIG7GMgpWTBgMjwFqbm9vK7uEWlkEI1lIbWNnClRuifREGbhenQxk=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4720.namprd12.prod.outlook.com (2603:10b6:805:e6::31)
 by SN6PR12MB2752.namprd12.prod.outlook.com (2603:10b6:805:78::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Tue, 2 Nov
 2021 18:46:40 +0000
Received: from SN6PR12MB4720.namprd12.prod.outlook.com
 ([fe80::c4b9:b9bb:e863:af39]) by SN6PR12MB4720.namprd12.prod.outlook.com
 ([fe80::c4b9:b9bb:e863:af39%5]) with mapi id 15.20.4649.020; Tue, 2 Nov 2021
 18:46:40 +0000
Subject: Re: [PATCH v3 08/21] cpufreq: amd: add acpi cppc function as the
 backend for legacy processors
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
 <20211029130241.1984459-9-ray.huang@amd.com>
From:   Nathan Fontenot <nafonten@amd.com>
Message-ID: <33fe4c81-76f7-2de7-6b19-1c6b233b49aa@amd.com>
Date:   Tue, 2 Nov 2021 13:46:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211029130241.1984459-9-ray.huang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN6PR16CA0016.namprd16.prod.outlook.com
 (2603:10b6:404:f5::26) To SN6PR12MB4720.namprd12.prod.outlook.com
 (2603:10b6:805:e6::31)
MIME-Version: 1.0
Received: from [IPv6:2600:1700:271:b60:1e21:1149:b336:3db3] (2600:1700:271:b60:1e21:1149:b336:3db3) by BN6PR16CA0016.namprd16.prod.outlook.com (2603:10b6:404:f5::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend Transport; Tue, 2 Nov 2021 18:46:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15e9fead-1e2d-4744-8269-08d99e311ba2
X-MS-TrafficTypeDiagnostic: SN6PR12MB2752:
X-Microsoft-Antispam-PRVS: <SN6PR12MB2752BF659B332D4B0949097AEC8B9@SN6PR12MB2752.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:568;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JClFhpNfCwSntC78/0ipOjeiMle6CgngPiVY85iYg8ANuHaQfpP5A+9PqWqfjn4jVll/7eQ5AwZNF6wsTkGI+59nO9d/5UMaFg5UWPpU3y33tL6X1MgijpqjzdptLHyvBbLnIFK6gYnkbUh6hOpRGQjpPk4lHnmut/4t8mHiFa2CaDHuV/zRMWdvtkfWmGIxBafcMFq0I1Wu91NhbUlhVHrBypip3Vy+Nh2O3P2IsQ/dm1eDYTISxmmm4lIgmQjdhlb5oVkmMt9CioysFWr1yMnPoHNkSkikv5lsiYKhr6b7YfY9UAuDlCLtrp/CWUnM8G63gmKgmRPyMN75wFDssHgv6AXCs/RoJhsxBH+n8ZzeKS1PLT8MxqnGoUJnE6JWyHCEeqcq4cFSMSQZuIUIyBs803nGVM5sZV6lPx6DAYztYpcIgiRYER949jeB0ZzGaQzKo+hhZxRRuaB8igKeEfSyEPt/Q9DGabT+z8ougUrFN9eIAbhsVf3yMPAggl7eTpHCFfCr7hoittKf7cHQIenKTA4gm/xDBRJTApBrs/b2UeeBm5lD5Exyslhw/VtHpbPvJmKHuuJzy5mK2xmqPFC8307G8iG7hBQQjQwJONIPVHh27Rvv7SicBCK+WZWKG3l3pe2ohOcAZvgZpXuc9Tf7Hcw+suJMuf72eCVZCd5gdFbRtGSCuUrl4tR0wUd2FenreNbv/pyS0wcP1N6xFRqP2hqCthTxUJtxTYzQIoI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4720.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36756003)(110136005)(53546011)(83380400001)(8676002)(4326008)(54906003)(66946007)(508600001)(7416002)(2616005)(2906002)(316002)(8936002)(5660300002)(6486002)(38100700002)(31686004)(66556008)(66476007)(186003)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2pXekNxZWE0d3FPajAvNjd0QkZRMmZrWXMxdVJVWkxsYmdlQ0J2ME1Pd05Y?=
 =?utf-8?B?aDFCbmhUMXlQRS92aU5mbzlTSGdwcE5VWVZGZXFPcjlyNzFadHBXOGhZMkor?=
 =?utf-8?B?UlZSZEhjMUxpajcwYjhDSENvanR2dUszU2V0MlprMjNwNUJweXh5T0hNckxw?=
 =?utf-8?B?eW4rdlY1Zi81T1kvZnNCTjEzdUpBNWZORzE1WnJhclNSZFlLd3k4MmxTQ3BM?=
 =?utf-8?B?NXhwc0E5c2c2TXVaTW03YXJObWpjRlRMR2ZsUWFoaVRJd3dIblVNOUFmblBt?=
 =?utf-8?B?SlFtVnQwRi9oOEhrYkt4VXF2K1FHdjdKbjVTck0wL3hRZERRcnN3cVpPQ0Fo?=
 =?utf-8?B?WlJRWFlQY282QldGbFFZNFZOSmZHTGd3VS9mQVJuTVcyajZtZWpUSHFLYjRh?=
 =?utf-8?B?bm5CVzhhQTZGOGxLTlIwVE5UQWEvQVo2b21RWEQ3eGNBQUswMDZXQmNuUzVO?=
 =?utf-8?B?cTUzZVlyMzlCR1RjaGNMV3FpbUd2TUZucnpLYmgrZjkzVUswUnNMUEp4bm14?=
 =?utf-8?B?Q0xJTkorUkxGM1NUYkdtVmZ5K2xvRCtabWJLelBEM1BqUW5zbGZhYVVid0s2?=
 =?utf-8?B?NFFXZzU5aWFCanp2T2dlWUtYTmJvVG04Q2ZiaWlybjVyV0MwcGRRdEFlZWhx?=
 =?utf-8?B?aGZlTXhlUVlaNnp4SEpQN1pSY3FIN1I1MWFYMERjTHhVazFNM2FNTklrRHBC?=
 =?utf-8?B?TnRka1hjUlJ0Wm1xSDlqU2RhanlxWDZuU2JSV3NmOVhFc01JNmdmUlhXVVNY?=
 =?utf-8?B?cmJSUERMK1p1NGFjU2FzOXcvZmdxQ1N2d2hQbHRreEZta0hDNGlZejhoVkdk?=
 =?utf-8?B?Mkd6RHFiV09EdkVleW9NaWNyY1o0NC9jMEt1K0dHT3J1bzRVc0ZNREdSUURK?=
 =?utf-8?B?aW9SVVJtc0szeFNqL0paakZFeGxzQ05lWi9PZUY2OThTT3lvNVVCN25MKzRP?=
 =?utf-8?B?c0FxOGcwaHJYbm1WSnpZSkk1K2xTK05TYnJxMUdDSHNvR2E5V01ocndZYWNn?=
 =?utf-8?B?MVRvWVVuMVhZS3cxT0ZOaEt4QllScEhiTEZrRTk1a3lMUUlOb2pReHFxK1R0?=
 =?utf-8?B?ZHhXbjBjTE84R3BLVFNrbi8ySjFzNEorMHFaQloyOEN5WGJVRGc5bjlFWWdX?=
 =?utf-8?B?WGo2aHFwc2VJU2FibGN6Vm81ZEtDemtKbnpIeGpwblFZakVSNjFtelVuNENR?=
 =?utf-8?B?ZXlSam1xQStRY2ZEanZNQklxakg4ZzZ1QmRldmNuNHlhTzBpOHZ2eFlPb1o0?=
 =?utf-8?B?VUhpbXNwR3lkbGg0RG5HMUhLeGZjbi9iVGpyZE0wSE4wVEd6UXE1S29sN01D?=
 =?utf-8?B?Umg0UjBZNnJIa1RUTlhvZTZ3ak9kdlcvQ1hPam5xaGtzZS9nUFovOXhubnRM?=
 =?utf-8?B?L0pWMGVERHlVelNFZW1jZGRLMFJua20raHJYcE5SMGlkUnZtTTJjb0diZGRI?=
 =?utf-8?B?QXBxOGlUT0FucVZ1TzFJU1lublNIdHlPUWloVjVvQTVLRTV1SndNUFpJTVQr?=
 =?utf-8?B?WTJKM09mWjdiQmF1S1ZTTzlGaEdZY3I4NHFyVEpJc0tpUnltZ0w5dXJnR2pL?=
 =?utf-8?B?MXMyNEhHSHh0MmVYK2hoV0ppU3pjODZSWUZ5QkVScVpZaE1ZblJNd1BRdjNK?=
 =?utf-8?B?dHIzMWdmNEIydXBtT1BZRUNINldCaisxL0pWd0pXeU5lb1F2bTlGeW5hUURy?=
 =?utf-8?B?bmZRMWt5Si84OWlSanJ4WEpCRjRBb29LRCs5MDIwM0lVVkxDcHFXZk56TkVl?=
 =?utf-8?B?WEtIa0VFYUR1ZEZ0ay9qbzk3cDQ0ZHlPbWF4RU0rbzVlY2NEN1pyaGR2dGRq?=
 =?utf-8?B?WnlmN1VjNHNEbm1LcERadzIwRmhvK0FJclpHK1lEdnVSVXZ5Uzg1NW5hZGJU?=
 =?utf-8?B?U3h0ZFE2Z2o4blhQQzNKT0RxVVB5RW9BcUlDOFcvWE92RXN5Q255cm81OUV6?=
 =?utf-8?B?eTJ1dEJjQmZLd0hOd2RwV2NLT1FqdE1UdTJKZGpvc3hHTHYvc3hya3pJQ1hv?=
 =?utf-8?B?Z1U1M3ZYWUh0OHlCUTJFYWxQSTlIVTduYlZ0NFUrQlpva2NRNmpvSzJpQkdl?=
 =?utf-8?B?ZDFVNXEyRGNJdXkxR3ZtN1c1WTRqeHpCQ0tMNWVyWHJqUmpSOGVEOFZKNXFT?=
 =?utf-8?B?SjFCSVBXendCbzZkNFNVZGNDVnhZZk9wT2tHd0RnWHgrdkVzQzlBaWlXRENl?=
 =?utf-8?B?TUh3Q2pUZmxFWXZYRG9OVWFMQ2RaUldJUmhxYVk3WThNL0dBOWMxT3JTWkJk?=
 =?utf-8?Q?TV50yh4kEsHHiYb19PrCH2oK8F/qSDYvN9K053hAmQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15e9fead-1e2d-4744-8269-08d99e311ba2
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4720.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2021 18:46:40.5366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zNHgWDsHK86H/SxoZx9NmZN1QMrO8KXQ8ny5VYr7zP4H6p5XLtMCBGqbMIxHj3AZwUIrusWrUUh9MLGYzlJnFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2752
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/29/21 8:02 AM, Huang Rui wrote:
> In some old Zen based processors, they are using the shared memory that
> exposed from ACPI SBIOS.

With this you present two different approaches for support in the driver,
MSRs and shared memory. For processors using shared memory you use the 
shared memory defined in the ACPI tables but access the MSRs directly.

Is there any concern that the MSR registers (defined in patch 2/21) can
differ from what is defined in the ACPI tables?

Should you use the drivers/acpi interfaces for MSRs also?

-Nathan
 
> 
> Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 58 ++++++++++++++++++++++++++++++++----
>  1 file changed, 53 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 55ff03f85608..d399938d6d85 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -73,6 +73,19 @@ static inline int pstate_enable(bool enable)
>  	return wrmsrl_safe(MSR_AMD_CPPC_ENABLE, enable ? 1 : 0);
>  }
>  
> +static int cppc_enable(bool enable)
> +{
> +	int cpu, ret = 0;
> +
> +	for_each_online_cpu(cpu) {
> +		ret = cppc_set_enable(cpu, enable ? 1 : 0);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return ret;
> +}
> +
>  DEFINE_STATIC_CALL(amd_pstate_enable, pstate_enable);
>  
>  static inline int amd_pstate_enable(bool enable)
> @@ -103,6 +116,24 @@ static int pstate_init_perf(struct amd_cpudata *cpudata)
>  	return 0;
>  }
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
>  DEFINE_STATIC_CALL(amd_pstate_init_perf, pstate_init_perf);
>  
>  static inline int amd_pstate_init_perf(struct amd_cpudata *cpudata)
> @@ -120,6 +151,19 @@ static void pstate_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
>  			      READ_ONCE(cpudata->cppc_req_cached));
>  }
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
>  DEFINE_STATIC_CALL(amd_pstate_update_perf, pstate_update_perf);
>  
>  static inline void amd_pstate_update_perf(struct amd_cpudata *cpudata,
> @@ -346,7 +390,8 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>  	/* It will be updated by governor */
>  	policy->cur = policy->cpuinfo.min_freq;
>  
> -	policy->fast_switch_possible = true;
> +	if (boot_cpu_has(X86_FEATURE_AMD_CPPC))
> +		policy->fast_switch_possible = true;
>  
>  	ret = freq_qos_add_request(&policy->constraints, &cpudata->req[0],
>  				   FREQ_QOS_MIN, policy->cpuinfo.min_freq);
> @@ -397,7 +442,6 @@ static struct cpufreq_driver amd_pstate_driver = {
>  	.flags		= CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
>  	.verify		= amd_pstate_verify,
>  	.target		= amd_pstate_target,
> -	.adjust_perf    = amd_pstate_adjust_perf,
>  	.init		= amd_pstate_cpu_init,
>  	.exit		= amd_pstate_cpu_exit,
>  	.name		= "amd-pstate",
> @@ -421,10 +465,14 @@ static int __init amd_pstate_init(void)
>  		return -EEXIST;
>  
>  	/* capability check */
> -	if (!boot_cpu_has(X86_FEATURE_AMD_CPPC)) {
> -		pr_debug("%s, AMD CPPC MSR based functionality is not supported\n",
> +	if (boot_cpu_has(X86_FEATURE_AMD_CPPC)) {
> +		pr_debug("%s, AMD CPPC MSR based functionality is supported\n",
>  			 __func__);
> -		return -ENODEV;
> +		amd_pstate_driver.adjust_perf = amd_pstate_adjust_perf;
> +	} else {
> +		static_call_update(amd_pstate_enable, cppc_enable);
> +		static_call_update(amd_pstate_init_perf, cppc_init_perf);
> +		static_call_update(amd_pstate_update_perf, cppc_update_perf);
>  	}
>  
>  	/* enable amd pstate feature */
> 
