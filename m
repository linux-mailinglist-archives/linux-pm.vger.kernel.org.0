Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1F03403F0C
	for <lists+linux-pm@lfdr.de>; Wed,  8 Sep 2021 20:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349951AbhIHS0K (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Sep 2021 14:26:10 -0400
Received: from mail-sn1anam02on2041.outbound.protection.outlook.com ([40.107.96.41]:6286
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235224AbhIHS0J (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 Sep 2021 14:26:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mlK5j++qCmSvwrQ2YG3g485rW0jwZJdPiTo674a9eflYq8xKSaEfGfpo4EkQ3DG/V7W0dHwTrM59zfrUtKORPCIeLDThSoCOZE+zg3eU44pHoSh//fW6ALG60IqTuGrjGwTNX9TMgHYodco2fSn3bw5+UjDeACm6Ke+wEU6mby/U1/ph0xbuZaUxKEQ/6gMNEYFLzVPP9uvQAVlo3LTdnCzeebwGAyyWZMZWzERqJO9byHNr79/1EhcqajmB5hFzwSYYIB94Lb264KtIUNcfddY4pzLDVJlp+TscC6WOWKVv7eQfN76jZZ5rpWvzP/EFUgeFuAMbI351wW3yzWv9BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=hCfNM8Iz7KAm5bALt8HUeJoCuTtiwTpZkOr4KM8gEKI=;
 b=TG0DqNa2nF52AXa1c58P34aoPvd5lp4l0+AGGDY5TyW8To4nC0Dy1levgNKsMraudifHdgPQ8VQLy4uANRa6LCTrX9e+qKhR22HeZT1aEMJC51AVen/gvaTkx/000IA1XbPXI2/L0XnJ8a9QfvK/ltSRzHg5oYCsAQnzBu7no9qfyuetY6RgP9S3QMLX67tcRzI/vO4woYZ6pFK53jgtfVUz3DSWhOXQLgWGPA7pLYm2p1PQsBmQxw2DL8l/kOEgplRMTHK1wGQ78Fgqb6n/+xNkX13/25MDSwE5o1L3C7qrn7HvEA0FpzOTr0SM5Ni0dlhNciDhMd+bITJlsyAkaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hCfNM8Iz7KAm5bALt8HUeJoCuTtiwTpZkOr4KM8gEKI=;
 b=ZD+Tp1duxUtFyvi4mNa8KrVgdEk/6eqP+m5KpylyZD8u5pcrZGWKY07Gj8asd4vZdklWdTg+OltIyhp/RQ8HzIicIEzAXtRkAQc4gQKCsT5o3HH0CvmTFFAHqaS+rh1htQDC5RMIVQyQa0v26c/hpAoQ4NInh2zHnZCKB3gPHys=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4720.namprd12.prod.outlook.com (2603:10b6:805:e6::31)
 by SN1PR12MB2576.namprd12.prod.outlook.com (2603:10b6:802:22::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Wed, 8 Sep
 2021 18:25:00 +0000
Received: from SN6PR12MB4720.namprd12.prod.outlook.com
 ([fe80::e134:658f:3a82:f750]) by SN6PR12MB4720.namprd12.prod.outlook.com
 ([fe80::e134:658f:3a82:f750%4]) with mapi id 15.20.4478.026; Wed, 8 Sep 2021
 18:24:58 +0000
Subject: Re: [PATCH 08/19] cpufreq: amd: add boost mode support for amd-pstate
To:     Huang Rui <ray.huang@amd.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>,
        linux-pm@vger.kernel.org
Cc:     Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
References: <20210908150001.3702552-1-ray.huang@amd.com>
 <20210908150001.3702552-9-ray.huang@amd.com>
From:   "Fontenot, Nathan" <Nathan.Fontenot@amd.com>
Message-ID: <a2718365-5975-5c91-350f-fe9098b4de7b@amd.com>
Date:   Wed, 8 Sep 2021 13:24:54 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210908150001.3702552-9-ray.huang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0147.namprd11.prod.outlook.com
 (2603:10b6:806:131::32) To SN6PR12MB4720.namprd12.prod.outlook.com
 (2603:10b6:805:e6::31)
MIME-Version: 1.0
Received: from [172.31.130.72] (165.204.78.25) by SA0PR11CA0147.namprd11.prod.outlook.com (2603:10b6:806:131::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 18:24:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2766f2e-7870-4c2e-3392-08d972f5f703
X-MS-TrafficTypeDiagnostic: SN1PR12MB2576:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB25765C899331F3AEE47C8DF0ECD49@SN1PR12MB2576.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /UnvBtBGMEaBa5K6NqR/18M9pHz5IZmw1WQZJ64SkN+77E6gz+34wdzKCxuuLJlsq1a6M9QVlfkYgDxO3wnKrWM9yP9R0ubrdQUm93mLVfC9H0B/D1ZUj+vGg8Vuaav5WtFf05nlXnRW2NeP5qYyqVT1sMmeBP7wAlRYllXNFJI8cnyzZ1bE6y2hlUOJLoXazwqikBh5C5B65L+k6G09K5Ts/8jzqfFY1EKrFZRi2XwWM1e49LsMxkCf9GRjSb8Rm1fattLkU98oSn/W7Aih1nDj9jO9hRgQ7sPFT8GrVHaT1t8CB1lO8XO4rLp+j93Kw7nIq1tzY9b1DjCBD2I+cBT0rE4sm061/bDuceGayi0tphxNcra+4Yg6s1HvRiu6pTAWvTNo29r8MgVq7LrOEkF5b2JPk3OVZ5AtuvJLPw2jkwL9JTBv6bgk/1Fu764OLdOcjxeH19QDIBZDRTBTe+WiHsWHjMtrfQGGjQefkCWlmFOx5Azk9bjqIIGeFrYCFeN9gvPCtDKOwQl4G5bh6ZVAAtg7R+qYwTucFCLdwAppAAIvudkd59Oh/CSqlASjxUPa+ZWV/9A+VohsQfqCpsK0HGJUIkX/ev0Xapb7pj3exyT5stirSpEMQ67MiUnYXkH4AAUUF5KTdAnCEgrdZTnRPq1FlXl4eskxAFnKovTXg0p7l0klrzE70t/5kmMv5WzwO36Ooj4hlJbqAG/Zh2tHDZlVIxkb0EfC3E1dNoY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4720.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(366004)(396003)(136003)(346002)(8936002)(31696002)(83380400001)(53546011)(316002)(110136005)(16576012)(956004)(54906003)(5660300002)(2906002)(6486002)(66476007)(2616005)(66556008)(66946007)(36756003)(31686004)(186003)(4326008)(26005)(8676002)(86362001)(478600001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STJ6cVlNRkU3My8xUTY4TnA2aTIrMjN4OE5GWW9aVzA0NTVpeE04QXBjRXFS?=
 =?utf-8?B?VDd5M1krb055akd1NTA0anlxK1dQUnpvWWVCMzF4M3NIREFhSUVOOGVGRDZI?=
 =?utf-8?B?NlhNUllUdS9UYkhuQU9uTU5xcHZYK0NrVUZvYUlJdklwWEUrMzVTUlpVRHdL?=
 =?utf-8?B?NGlSRVU5Z01pb0hvOUlDSG9KK3FSSGhoL0dUSFZjamh3bHdZaHlrL0FaK0lw?=
 =?utf-8?B?cEJhTG9aemZrcXlUTk1udVZ1aGtNY1VlWi9lRU94K01IZGhFZzFKODVNVXBH?=
 =?utf-8?B?Y0hGc0Z2ZnREaVI0RlQzQ3lBUm1PbDJzbTR2VEVVaEtUUVlHVjg4UlVaOE5M?=
 =?utf-8?B?TTdCZndYSEh0QUZTOWdUVHg2SWhuNlQxaWpseTM1VVdtTFkxUWYrSHp2bU1K?=
 =?utf-8?B?d09xSUhQVUJZZm82UzFaZEhjNzl6YUIraU4zVGxMVnZ6Z2tYalhiVUQvUDd2?=
 =?utf-8?B?a0hpQlFDTU04QnF6a09ndDlBU3d0WDdZM29meUQyd0tUUlFZZmFOTGxJNzJh?=
 =?utf-8?B?LzJlN3BxNTFMcU03NnJLSHV6NGlEZ3g1TTVYbkNiaUtHd0N0UEQyYTJKeTg3?=
 =?utf-8?B?QmU4VVh1eDVBdG1TWml6ZXJkMVROcFZscVdiTFNmWE5NZWduazVSV0VUb3lt?=
 =?utf-8?B?OW4wQUE2R3hYSzFQZ0F1T3dXaHBYUnlHQzN1VFlaWFBiUFRFWFhpa1lLd1FF?=
 =?utf-8?B?ekkvMldSY1c5QkF1clJnTDFCaENSa0hXd3E1aXErVjRJR1ZqeG0xZnBQdlR2?=
 =?utf-8?B?M2NqaDNGUXFYVC9RYWVVUVdiOTU3bUVWbG9vQlhNNDlQVnpkK0t6djBWSGdF?=
 =?utf-8?B?T3p3d2lRdTdDR2owNVdGZGxScUhOOGZacndGVkZNSldWZWZqQVM4RDcyQlY3?=
 =?utf-8?B?NW80dzVNYnE0ZWVqNUp4VU5KSTh1UmdmZHlvNHZaZHRTQ0c2cURUY2x1M2tk?=
 =?utf-8?B?cUNwVXBFbW9QOXdyaHBFMXJmcGJYWXJSYzNkNHJzaUVDZUpUSlhkcHFOMExE?=
 =?utf-8?B?bjlXSnpZa0ZEKzdWZllTZVMveWRGNFNHLzkrUFVMU2FUQmhsNm82VGZ2dVdP?=
 =?utf-8?B?OHV0OXR1MkU5WGJydkV2UkMzODFtNS9mdms1c3RJU0gxdE1nbnhEMHEvV2VR?=
 =?utf-8?B?bW1lSTVMNGpNa0xHQld0cDJ6c3ZSOTBhQUtjR0c5ZW5iSE45Wmk3dXVvL0R1?=
 =?utf-8?B?dmYxck5Jd2RKZDZNS2d6aGpHZktSTFFaTFJMcUgrWjFUdXMwS253WnhCTXl2?=
 =?utf-8?B?K082c3MyeUo0cXBYY2h6QTV2aklKdHJjUzkrZWh5RzJPYm9TZld4TTN6bHBq?=
 =?utf-8?B?T09RZnZPOEh3aTVFTEExbm9ONWdyeWk2MzkrZUR4V0dSemZwNndKdlZpdDYx?=
 =?utf-8?B?cUk0dGYrcTdDL2R5cGdVbjZVRmI2ZkE0aklZTFFUSXd0VlFYQTJlTjRBTFkw?=
 =?utf-8?B?RVc3TFo0V1lxS1hKRTNCZUlrVm9XUlk0Y3p4MjI0cmFUYmVEZ1ptZENNM3Ir?=
 =?utf-8?B?Y2V6Z3FPekVTT08reEFDdk1uUjJVd2czWENTSEJockZNTldmUFM5cFg1Smoy?=
 =?utf-8?B?SmlPcVNJdnZ6am9Gek9aM2d5MmhJbnBHcGp3SmpIMytBRHg4cDJjT1JrTENk?=
 =?utf-8?B?TVdoWldVMnlBTThjSEtzd0tURUUrSWRMOEtqbUt0bXpMang3R1RjeTNydHZI?=
 =?utf-8?B?ZUpPYmJacEVJcFRWRFo4RDErY2ZRdCtjaGN1Z0NBL1ZhRnNtQjB5ZlF4OStY?=
 =?utf-8?Q?RmmhRQMHJ9Ll8Xpy5f+Ik7NsBkeaup+sT9KvzRF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2766f2e-7870-4c2e-3392-08d972f5f703
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4720.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 18:24:58.7871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fB4B5Uf9+CwQjnvJttURmpAV6XMiaoYX9Oqj3be/UAm8PK49nVB3marsDk+MihSRHxpGPBhJMiD2l4dltEcFOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2576
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 9/8/2021 9:59 AM, Huang Rui wrote:
> If the sbios supports the boost mode of amd-pstate, let's switch to
> boost enabled by default.
> 
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 50 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index ea965a122431..67a9a117f524 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -75,6 +75,8 @@ struct amd_cpudata {
>  	u32	min_freq;
>  	u32	nominal_freq;
>  	u32	lowest_nonlinear_freq;
> +
> +	bool	boost_supported;
>  };
>  
>  struct amd_pstate_perf_funcs {
> @@ -229,6 +231,19 @@ amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
>  				      max_perf, fast_switch);
>  }
>  
> +static bool amd_pstate_boost_supported(struct amd_cpudata *cpudata)
> +{
> +	u32 highest_perf, nominal_perf;
> +
> +	highest_perf = READ_ONCE(cpudata->highest_perf);
> +	nominal_perf = READ_ONCE(cpudata->nominal_perf);
> +
> +	if (highest_perf > nominal_perf)
> +		return true;
> +
> +	return false;
> +}
> +
>  static int amd_pstate_verify(struct cpufreq_policy_data *policy)
>  {
>  	cpufreq_verify_within_cpu_limits(policy);
> @@ -402,6 +417,37 @@ static int amd_get_lowest_nonlinear_freq(struct amd_cpudata *cpudata)
>  	return lowest_nonlinear_freq * 1000;
>  }
>  
> +static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
> +{
> +	struct amd_cpudata *cpudata = policy->driver_data;
> +	int ret;
> +
> +	if (!cpudata->boost_supported) {
> +		pr_err("Boost mode is not supported by this processor or SBIOS\n");
> +		return -EINVAL;
> +	}
> +
> +	if (state)
> +		policy->cpuinfo.max_freq = cpudata->max_freq;
> +	else
> +		policy->cpuinfo.max_freq = cpudata->nominal_freq;
> +
> +	policy->max = policy->cpuinfo.max_freq;
> +
> +	ret = freq_qos_update_request(&cpudata->req[1],
> +				      policy->cpuinfo.max_freq);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static void amd_pstate_boost_init(struct amd_cpudata *cpudata)
> +{
> +	cpudata->boost_supported = true;
> +	amd_pstate_driver.boost_enabled = true;
> +}
> +
>  static int amd_pstate_init_freqs_in_cpudata(struct amd_cpudata *cpudata,
>  					    u32 max_freq, u32 min_freq,
>  					    u32 nominal_freq,
> @@ -504,6 +550,9 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>  
>  	policy->driver_data = cpudata;
>  
> +	if (amd_pstate_boost_supported(cpudata))
> +		amd_pstate_boost_init(cpudata);

Is there any reason to not merge amd_pstate_boost_supported() and
amd_pstate_boost_init() into a single function? I don't see that
amd_pstate_boost_supported() is called anywhere else.

-Nathan

> +
>  	return 0;
>  
>  free_cpudata3:
> @@ -535,6 +584,7 @@ static struct cpufreq_driver amd_pstate_driver = {
>  	.fast_switch    = amd_pstate_fast_switch,
>  	.init		= amd_pstate_cpu_init,
>  	.exit		= amd_pstate_cpu_exit,
> +	.set_boost	= amd_pstate_set_boost,
>  	.name		= "amd-pstate",
>  };
>  
> -- 
> 2.25.1
> 
