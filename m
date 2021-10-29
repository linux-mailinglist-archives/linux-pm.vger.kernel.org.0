Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77B2843FE47
	for <lists+linux-pm@lfdr.de>; Fri, 29 Oct 2021 16:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbhJ2OTU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Oct 2021 10:19:20 -0400
Received: from mail-sn1anam02on2059.outbound.protection.outlook.com ([40.107.96.59]:25570
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231328AbhJ2OTU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 29 Oct 2021 10:19:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kuw8tA92+3NjPSAb1qAYzZMKYT6X58wxG12vyqtk22LYoRucjYefkRcJOrfnAmth/KyNG9aCGMhR6Y/StQ9oKMxQIr1omlOh1XIO6TugEWS6fzep0iIhxKXDhGgxXN9aqh4Iz5JYsCMh9ROwYzNHJcT0QTqq70ixFk5wk7Ze429adb3JPws/mtSdbiZlDLUQ7kNsgC8ZuJNULN/X6/nYJW5zCgsdmbWhX4s0sBLjCC1iFeIXFw74/Oqm2qsCbmOu17uoCfb9H3xb1Q7w5nADvAGYIN6Zr7+w9CkNfIfedWLtYNo1ySrJCWmmrwuyXYjCVu2iWN3Ivae7VA/BnSPwrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/kkOh/6JmQHoYAVIPMSCg8Eplkgf2PqPONsEhz//SJ0=;
 b=fIihACDpTEXWSxznn3l6N8DTtHJfT8lU8baLMWvweMpTcCZTqBSbsHOSoVMhMI3Oo+fQHlJ2vPlFATAC4KJb8BkmgRHtwsZoaSB7x7QSGafDdh6fphUIhzEvJxyYmEEPSIBwIi+SryphilzeWUEaXtyiLrQHBBor+Y1puok/+N4lgHVa5Nc9/pnHmomIYG/Ig7424FcvP52yVRdmIHq23svrV6YDyW8hYZU92LKZqby6pVbblhEFN5z7RUHKZVkIDfRsHcqvUQ5XY6qNXRLmz+2tO/0mRSUcHDvm2Uf00jCiSm/khMW52xgrzxR8Jzuhdbr5cJkse1+vSS5sQnFcEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/kkOh/6JmQHoYAVIPMSCg8Eplkgf2PqPONsEhz//SJ0=;
 b=IEdjrteFD1pUS1Scu6fPpOgmnI1AM2rPtXLXYuelRvy/2qwSZL8PyDnh4GFsGt9QXn+3zGXBOfwGT8V04kMbq1Fj9AVZkYHRCmvwYpTqmsk4gSukef5ku6cIR2vZsXgW7rb8iV5XJ+sSMG9ARQdOZyOjbccPMqWBBkLhRb1Yfh4=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8)
 by SN1PR12MB2415.namprd12.prod.outlook.com (2603:10b6:802:26::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Fri, 29 Oct
 2021 14:16:45 +0000
Received: from SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::7cbc:2454:74b9:f4ea]) by SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::7cbc:2454:74b9:f4ea%6]) with mapi id 15.20.4649.015; Fri, 29 Oct 2021
 14:16:45 +0000
Message-ID: <b645623c-8efd-c33e-4da7-009c6e2d657b@amd.com>
Date:   Fri, 29 Oct 2021 09:16:42 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v3 07/21] cpufreq: amd: add fast switch function for
 amd-pstate
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
 <20211029130241.1984459-8-ray.huang@amd.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20211029130241.1984459-8-ray.huang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0416.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::31) To SA0PR12MB4510.namprd12.prod.outlook.com
 (2603:10b6:806:94::8)
MIME-Version: 1.0
Received: from [10.254.54.68] (165.204.77.11) by BL1PR13CA0416.namprd13.prod.outlook.com (2603:10b6:208:2c2::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.4 via Frontend Transport; Fri, 29 Oct 2021 14:16:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71693902-9e88-4573-f8d6-08d99ae6bd1d
X-MS-TrafficTypeDiagnostic: SN1PR12MB2415:
X-Microsoft-Antispam-PRVS: <SN1PR12MB241573DD945078F4CAA9C435E2879@SN1PR12MB2415.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: omDPJJ4ZCdiVgITxYoCWGOmwZwhgGrtMD6scm+Rv9eQwp6k8gj4SRtrKE4fNm8AGeERipZMHjv7BLeH0fLnuQEfPiSkThWObB/20AhfgkF1qtImZV6vGqX1wJHWkfuXVNtwr/LuRkzozJmbHP67P9WQq6tky6J2+/omARaOwcoBFIaEoHAIAiVmUUFGqaTskmnBTVJMhGiH2c/qjeFu3aW5sVl/+C+s6H5MIm20Rhm1bbFwHh7Fv8h6tyzYQhqmpN0b6uMbwLF1wACIvYCKpOYcrBAU6OhD9IexC+S+SXa174/R5EJBMT3XtkHsr46UkZWk/pMLVpinBIfi8Kp1VYmqX7QUNl3uXoceS+RE7AjbNh/MhoNgGDXXxS7Ifu8cIChj6fBn/e9CVFUCiczmx5/fpUhUd2bih4RJZ4oDAIuH9hJxLzjWgJoxTMWfWjzQIJf4/34OA0jYRQK84QK25GxrrEFR9EMZL/L8fPGg18FT455VvBMgZFf8RYuOnXKb8Wkc7WsjrZM0feNf6yxq2uwdYHDnsrGLIqHEdya/v69Jsy1/FVQDiPLIJavMAsRKZdadZH2990mN1L8hipV7b9YtONEkILabRgqUhAw2c1F9koUg5THTIVyaZvJamMf8usB0XXQS6L96RAu7NIcTzn2a5nEGlODYpyGuiLV/O2idxWyZDXNtPs+oHDPyRkZK95qYkUVVKVttRjA/9wT5yRB3TROgwi/7nbAzrYuCC6jn7YKk1qKo42w2usxd7gjuQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4510.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(316002)(2906002)(508600001)(5660300002)(4326008)(54906003)(110136005)(16576012)(31696002)(36756003)(8676002)(53546011)(8936002)(31686004)(83380400001)(2616005)(66946007)(186003)(66476007)(7416002)(86362001)(26005)(66556008)(956004)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlJnK0tmbUFyNmg5eU1ycXdPRWVkUlpuT2dWeVp1UUNGcnl0d3ViT2psMHZ4?=
 =?utf-8?B?c3JqdkNIS3lJYUc4WFowZ21MbVVqakM0ZDhoQzl5Wlp4U3pWMU9VUmQySnQz?=
 =?utf-8?B?cmYxczE3eTRROElydDBKYU8vZk03SjBzVnd6ZnRDZkdnTlNiZGxaZVhlVGdC?=
 =?utf-8?B?UFRjMWNWMWhaT0hIaXRzMDJpTExobHZhQURJdFdNbC9JSHlQcGduT25nL3ha?=
 =?utf-8?B?MmRVSjNYOVBqWXB1cVhMakNRZ3JzTmxXWk50NzNJOHlXSnVvZTJGckljSG92?=
 =?utf-8?B?TDhaKzN6Q1cwUVJNQ0hrRWVmNnRlZEFyRXFrTHhQK0NydjJCSE1QWnMxdERz?=
 =?utf-8?B?aVVoOGtxNUQ2SjdNRnFLRlA0bVdwYTFGL2w5dFY3WUVjRUxlWTh1eDNaaHIv?=
 =?utf-8?B?amhNRThObHRGTFU4cXpVdXhQV3NTaGlCOUhpdzBUd09OMnpJbnZ6RDAzbUk3?=
 =?utf-8?B?UVovUkJJNEhJOUoycjUzWVJFZ1lBWHB0OTV3V3RGMUV0elhkaC9lYnVsL1o0?=
 =?utf-8?B?dmxCSzFUaEp5WG1MMkwreWVOUGFYT0JXNHBPaWRBY2NTN1k1akRjNDkvbGdC?=
 =?utf-8?B?MHZRVnFwMDExbU0rUG1QR1lJZWRTWVFTUjRFL0ZUSU40NkMwVEpzR2hIQlln?=
 =?utf-8?B?UERQWFZVaE1aR2pPUklTamVqZTNlcUV0RWxXVEp3cjZIbFR0ZXAyZFZJcGg5?=
 =?utf-8?B?SFZNakdla0RTeW91YzZxYWJuUWdlTmwrS0VaZnh4YmpYRkgzbG4vTngrSEF0?=
 =?utf-8?B?azZoYVliNDUwZmQrM1hhWjN0SytUR3B3UGttMklJSmswOVo5MnEvS0VBdHU1?=
 =?utf-8?B?YXdFM1NRVjNmTCtlWWJqN1dNejRkS1Nidm5UM0FGaktWUlhYWDZ4aTcyRDlo?=
 =?utf-8?B?bjJlQ0dKa01jWUNmVmJLWjdMWXJac2dvTnU2bHlWbzdJV3NCSFgrSW1aZHB0?=
 =?utf-8?B?YkM3VktsRFdXZXNKdCtDc0ZZUVpKK1l2by91cjJ1UHBOb2NHdURPc0xTN1dW?=
 =?utf-8?B?bHZSQ0N0NTlDdmU5bm5PKzhBdHNWS1RndEJLZlFYUGxMcmZqbzFEVXd5U0k3?=
 =?utf-8?B?VjcrV01CZVVBNmhZNWtvQ01EdGh0L1VWY1Z1SFNOdDNTZG5GandXY2kyanNk?=
 =?utf-8?B?a3FTRVR0WkY1bmErdUtVbDJZdUcwdjhVMjdIajExWmd6Qit4VjF0c3MydjBP?=
 =?utf-8?B?clFzK1YxVTlFZEtPdHJTRyt2REdQbE9BN3lWOEpUYUtLNDVSSVRTcVRtRnJ4?=
 =?utf-8?B?bVZQcHZpODR3S1FqeElPR1ZCMUU3UTZ4aHdxUDFWUWR1NndGcG92RW9nS042?=
 =?utf-8?B?bHBub3pHbmRpRS9JZi9xeCsra1hJRGNSUTJIY1VMK0g4elp2Q3liaVNicWl6?=
 =?utf-8?B?RDJKNDZKWGVDenFUM2N3TWl0a1A4eElNWTE4ZG1XS2VTWE42aGVUcUtwVFJ1?=
 =?utf-8?B?Myt3dDVYVDFoRzBxeTBiZjRydVFKM0ZNSkdCTWliZHczNC9LZmdpV3lWOTdY?=
 =?utf-8?B?ZEQ2allXUmtHSkFmTk9QSDRpS1IxNFN6WnZlTk9YNTVhdUlTTko0eUtBd0tB?=
 =?utf-8?B?NEdmeGJYYW1iSSt0dmFnYjVrN05qSjhRUzQzcE1uQ2s3UVE3dExuV0UrMHhz?=
 =?utf-8?B?a3BsQllxM2p3dGZhaXlhYmR4OGl4WWhoTTJPdVAxY0k0amVxdll4RUtUbERP?=
 =?utf-8?B?UkVBbTJMekJTVkFBK20vcmU4ZkJ5K2FwZlNyc0VhRzE4dUdPNExHNGxRYVY4?=
 =?utf-8?B?SGtSKzVaeXhFa3NNcU8zazNETlVzT21QeXR3bUY1WUhCT1ZyRkdWZ0N6ZE5Z?=
 =?utf-8?B?bEhXek1UYnRrbnZjYW5EOWYyV3FoSVNRcUE1SGpFamJRaWk4WFVLQ284WXU3?=
 =?utf-8?B?R3Bmb1dPNG1nSHk1Yi9LZEdEZnFvY2szWTNtb0FURXB4T0tLbDFkLzh0Zk0v?=
 =?utf-8?B?N0s1QlRCRGF4MzY5SDdlMGFvRW9QV1NQY3pab2pUdlk2aTI1YWxiazR1M3Mz?=
 =?utf-8?B?c0NNZmw3Y2twL1NpQ213b21DaUV2NHQyVEFZbXpQclJpRm5VZTh3UUl6bEtD?=
 =?utf-8?B?YlpCVDdDT1lYY2djWTdLREwxQUtxa1UyQ3VsTXJiTmxlVzRnajIxdVVPNG0v?=
 =?utf-8?B?SGZyQkorZGs4ekkwOHRJWXFKdTBJdXFnZS9RN01FR2xtMVp4a2Vhc3ozYk93?=
 =?utf-8?Q?B0ojSPyivl4R5IntqP+4ejU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71693902-9e88-4573-f8d6-08d99ae6bd1d
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4510.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 14:16:45.7262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aYUdBA8N7eEtp6XIM8tA05WvrXOKeFrBrzjcgEJ0+erIvMfbYP474sDM7Wq/j1Ef5OMz8421d6S+vCE0eBezbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2415
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/29/2021 08:02, Huang Rui wrote:
> Introduce the fast switch function for amd-pstate on the AMD processors
> which support the full MSR register control. It's able to decrease the
> lattency on interrupt context.

s/lattency/latency/

> 
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
>   drivers/cpufreq/amd-pstate.c | 38 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 38 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index a400861c7fdc..55ff03f85608 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -191,6 +191,41 @@ static int amd_pstate_target(struct cpufreq_policy *policy,
>   	return 0;
>   }
>   
> +static void amd_pstate_adjust_perf(unsigned int cpu,
> +				   unsigned long min_perf,
> +				   unsigned long target_perf,
> +				   unsigned long capacity)
> +{
> +	unsigned long amd_max_perf, amd_min_perf, amd_des_perf,
> +		      amd_cap_perf, lowest_nonlinear_perf;
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
>   static int amd_get_min_freq(struct amd_cpudata *cpudata)
>   {
>   	struct cppc_perf_caps cppc_perf;
> @@ -311,6 +346,8 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>   	/* It will be updated by governor */
>   	policy->cur = policy->cpuinfo.min_freq;
>   
> +	policy->fast_switch_possible = true;
> +
>   	ret = freq_qos_add_request(&policy->constraints, &cpudata->req[0],
>   				   FREQ_QOS_MIN, policy->cpuinfo.min_freq);
>   	if (ret < 0) {
> @@ -360,6 +397,7 @@ static struct cpufreq_driver amd_pstate_driver = {
>   	.flags		= CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
>   	.verify		= amd_pstate_verify,
>   	.target		= amd_pstate_target,
> +	.adjust_perf    = amd_pstate_adjust_perf,
>   	.init		= amd_pstate_cpu_init,
>   	.exit		= amd_pstate_cpu_exit,
>   	.name		= "amd-pstate",
> 

