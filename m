Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 019CB4436F9
	for <lists+linux-pm@lfdr.de>; Tue,  2 Nov 2021 21:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbhKBUNu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Nov 2021 16:13:50 -0400
Received: from mail-dm6nam11on2068.outbound.protection.outlook.com ([40.107.223.68]:61601
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229813AbhKBUNt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 2 Nov 2021 16:13:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=az82JfNad430ZWHkv08aUcBJbZ8tXkqDsLYkxBDyZuI3CqVpn5FAzKxj/NTg7qjnvT4Bqm8P+Cc9YaZTtj6HocvWFrCgPVM579yquzSUGbM/6sBcTJ17AD/4yUW4SBKFuLk95hVQVizlwLpjHDGEfGHpaYREP8jvL1/b+cF2xymizegP2P1ld73RQyVgfohFF1C5H3KnzwejAX8PjKV8/+z1My5aiDgl8p8KgTi8H4Tdaa6ooT1WxxvS0Hda/jWvPIPAaiPzlkBqglqWuhxMjgLa4I7xu2zT1m9UvkGBDj3UWkmsvJFjp2FCmUG5HiaAFnmm+6BvcLGoeC0p8L4gjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=flI2WHPTQ9AlSYRDFg/K9ApW6jmy6QiRYYD9me6e5aw=;
 b=mhDPdWj8lFEHstI+N2GPQyZTcZQ1oCV7LwwpBXW3RByYO84FqixjWCpazkVNYG9qEXBFvRSx+o8yFRuef6Uz+WKYb8RxiyWtmYA/J+CGsmn6BLACw7CAjkiHGXn2JXTuv2lj96ZF3XSDlmNVfNeMKZJ9SW3jVEBI9OzwLqj9UIGy/OMiUh8eZOUXPwOE0IT3JUhp0UmRyZlK7lhs3mKWIEobqwrbW9h74MWDSeFSfzqe3k5E4sw07opfjmJwCmA2hVhbUDwvhnhWcgu+S8MIxVU4SSAOTuGVbK2jyz4OMniQeN5kOxEIJRLx7mKGVwgj3Ed5QsOfUMxi5iQ93YdPjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flI2WHPTQ9AlSYRDFg/K9ApW6jmy6QiRYYD9me6e5aw=;
 b=DskTsxgLRop5qX703/Nb530ImzwrWv2M37tsm7dCCHPWCPw7Ia32pyZrG33dcbOrr4Qh9Yq/ZL+IHi8WvVhtwjPVxs+ZAJwM8eHs2RYGRWt4SocaDZXC5ju3w4yNpTwgA98BHumH5FAnTa7lKaOYBfxvDDF9DeL3rpAy548xM3k=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4720.namprd12.prod.outlook.com (2603:10b6:805:e6::31)
 by SA0PR12MB4447.namprd12.prod.outlook.com (2603:10b6:806:9b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Tue, 2 Nov
 2021 20:11:12 +0000
Received: from SN6PR12MB4720.namprd12.prod.outlook.com
 ([fe80::c4b9:b9bb:e863:af39]) by SN6PR12MB4720.namprd12.prod.outlook.com
 ([fe80::c4b9:b9bb:e863:af39%5]) with mapi id 15.20.4649.020; Tue, 2 Nov 2021
 20:11:12 +0000
Subject: Re: [PATCH v3 18/21] cpupower: enable boost state support for
 amd-pstate module
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
 <20211029130241.1984459-19-ray.huang@amd.com>
From:   Nathan Fontenot <nafonten@amd.com>
Message-ID: <5ec8afe8-d157-84e5-c877-649d4484ddc3@amd.com>
Date:   Tue, 2 Nov 2021 15:11:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211029130241.1984459-19-ray.huang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN8PR15CA0072.namprd15.prod.outlook.com
 (2603:10b6:408:80::49) To SN6PR12MB4720.namprd12.prod.outlook.com
 (2603:10b6:805:e6::31)
MIME-Version: 1.0
Received: from [IPv6:2600:1700:271:b60:1e21:1149:b336:3db3] (2600:1700:271:b60:1e21:1149:b336:3db3) by BN8PR15CA0072.namprd15.prod.outlook.com (2603:10b6:408:80::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.17 via Frontend Transport; Tue, 2 Nov 2021 20:11:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6953acf1-806a-4ce3-cbca-08d99e3ceae7
X-MS-TrafficTypeDiagnostic: SA0PR12MB4447:
X-Microsoft-Antispam-PRVS: <SA0PR12MB4447E959643689808886CFB8EC8B9@SA0PR12MB4447.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Zlv9MUKq+1tVn4wv4AkVtOq7g+lNHNmKGk35AG+bi0hExtOQYXV2blvTvE7M0GEGSB/+96vCuibr0LajhMF3ee+xoHTdDSkuHZA5bIia94BYyhjJPoDWH0oasgg15z0SatUIml9xq2yx9wNdIY51Ma9/gY6efaIQojuuiutEi7RBX1ygM6aAqV0jgK9H38F+Q64DGAWWK0YkyGfJfQ9BWF+CcFOS5qtcVXZ2XMlw1+waiVwRnsuP+wKmKyxIeYrOEp/rlT1MkEuDM0iiKzMnW/YsJ5HDDjnqxmuZvpUwK5nCUFb46SfObRlxpoySVvGIeA/GAqhGLwvNUcHEuqGu+iZUwuRY26S+wJ6ZSF2dIlxauTAh8q1QoPyl7YcOjLhu0Z6cNqptIsfd+w68BNWrllMH3RXmnUyohhIc9BLSdw/nApWqxFMU6Hl1zuQbnms1lK7r2jwt5S67uzzN4aE0Pvgz6EpanfY4aLIyHERm1Zu+kP4GmGIhQ0Ey0nmmDiukP5BPhQKnjFQVU7yz99T0833uJZ3rF/CdU6Uo0BjuAiSPrlpCeujgnYonmNOkqOlVzmHBX/iV7XZrid6OCxfzWcCDCIbge2ic9Qrjet3WLabWvPUntZnuZ7HaZ3Tuofo277WedU+8duK2yv6W2goqw/EQWlJCHvKMHXLFchGU2Ou8Qg1hmD473jy+W9Z3IgqzZq7Znub61612l2CJgHID01wbA7VcjcynjoIQpWfuazgQ9T1jvRib5dI5bWJCF/y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4720.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(53546011)(66946007)(8676002)(83380400001)(110136005)(66556008)(8936002)(316002)(186003)(54906003)(2616005)(66476007)(36756003)(6486002)(31686004)(7416002)(2906002)(5660300002)(31696002)(508600001)(38100700002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajY4Zk80bEs3cjdiM3h1NlRvNXh4V2JJYThWVXJuaHJWeStTOE9LL1MvZnlR?=
 =?utf-8?B?dlZHZjgvMS9EOCtvU05iQldiSEg2Q3pVOTl6Nm1HSEx3MHUxaTBmV0pUOW9L?=
 =?utf-8?B?SXZhbUNYdjhpbVRsb1NTTW9YL1Z4NGpHVjN0LzNnOHByb2VvWSt3dTNhdlEx?=
 =?utf-8?B?SUJnL3hrTzJBWXpFS3VnM0FHSGtGdnVaendqc0RKZmRNYUdlSXhVV2hDTjJD?=
 =?utf-8?B?aStwK2J1TFNKVWxjWUx5eDJrKzFYSmJha3RRdzVFY1pqaWRZM3FLOTJKT1Fm?=
 =?utf-8?B?VlhKVTJIRVR3dTM0SEo4QzB0MmVlSTA3aWlxa0VNYWE3bFZ3M0RyNjdpU0Y3?=
 =?utf-8?B?WWNmZE5GMVNSRFhHeXlDR2U5SEsveTBlMEdaNDZFaEN1Vi8yVUdRWUxEd2Z0?=
 =?utf-8?B?NmJsakp1VUdDdHREMkFtNnZIODBxelFLa0VPTVFsQnhtcXo1ai9Kc0J0blgy?=
 =?utf-8?B?c2x3aEpBQ01TTUt4d0hQZDUxQVdaZ05COGVycGhCVzB3ZksvTkxSbkNZRWg2?=
 =?utf-8?B?aDdMOC9CaGt3c1FHbWhzV2FQQmVnZjlKWTJCbmNOd3ZNWDExQjJKNm44NE8y?=
 =?utf-8?B?cXJsVWFTdmNYdGI4aTlvaEhrU1V1aWNJMDF1dFQ2dlBvNWlNR0RaRXFLVHdw?=
 =?utf-8?B?YytsYnBjVUZlUkgyUm9lYXZBTHAzNTdQekpsWm4wR3Q5TzBhNGwvSUVNdTNG?=
 =?utf-8?B?UmpuK1dNY2szbXlWTTBlenBBWVdVSHhVQ2hkRXJWcnIxeVhiY1NoUE0vQktV?=
 =?utf-8?B?ekNqY3RBVGM2K3VORUdGT2QzMjZmSFNBNndXc1ZzVFVkaVVDY3FSdEMwWERy?=
 =?utf-8?B?eVVmWjFZa0NWS3lmVXNlY2h2cG1mazVPbkE4ZlhKN0xQcm1rZGJ3RTg1VExO?=
 =?utf-8?B?dUNQZU5oWjMyUXZiYURXQTd2WVZIdmVic09sem9NSzZ4UEdBakhqOURzS3J6?=
 =?utf-8?B?OXU1M2pmVlcyRzNkR2pJZkduaUoyVUN0cjdLaTZKOXhKUDBkNi9yTjZlR0Vt?=
 =?utf-8?B?WW55alFVWjBnMld5eGtqTlBhVWRWaTFTZUdZdGE0NkhORUFxa3l5K0lsUFRV?=
 =?utf-8?B?OS9mOG9xbDRZOHh4ajBmeVEwVi80ZXVnN3JVS2VnbDZiOEpucU8yb1pMU2VR?=
 =?utf-8?B?L0hPTFFiZGpzcFFKZGN0dGdvYW9nTE1JSEpKQzFNZ3VIKy9LbDBoOXpXS2s3?=
 =?utf-8?B?K21KSjBrbkFnOVd3ZnlwTUF5elNoNTVqdDAydEFFK2VnYlhJWjh3RkZXeGNH?=
 =?utf-8?B?dU9YbWJVMWVSTFBYajlBenNJQWszMzF2M0hBbnJMVnNhZXJRS0t3c3ExazJt?=
 =?utf-8?B?cG80aHYwcFMvL2hBM1VCZlZVazQvYjFlNnNiSGFWR0ZpY2VuZllGNXQ0cWJq?=
 =?utf-8?B?Yi9rZmFMQnVnOUJPVmtzNHpoNmZFMmhKTGgvczdHcEdjbzNSRUpsZEZCSWg2?=
 =?utf-8?B?RjBvOVZKMGczQXV2R09CZGwzK2NnSUVqampRU2tPK2xKUEY5YkJIUHk0OVVz?=
 =?utf-8?B?bjRENXJvMGpjQTlaT3FtSkdxN2J4UkVxSWJGZW1NYXVDVEpEc0graHRKdHpr?=
 =?utf-8?B?QURvZDlOY0FZTTVlN2R1UEZrNXA4R2lDd1dHNDl0cG9VRTRMZFREVEZ1WU5C?=
 =?utf-8?B?UW5MTHlZL3EzaUdLRVJwWExUTXRteDdWelJQMXhqTVJMWmQ5cGdKeWRtNTFy?=
 =?utf-8?B?eWFtSXIxazc4akRsKzJkSUZOL1pSZFVwQkFlRDJUelE1dmhxMWpkVkdLNlpQ?=
 =?utf-8?B?S2JaY3VvaWJYYy9pWWhHUHlHVXc4MU51S1pjS1NOZjhmdnllS1pwTTlscTJT?=
 =?utf-8?B?ODAzOCtUeVhtWCtwdCtGOXRTeEJKYUdJZHB5VDB6SkJLdEUxRVcyQWxpVnIz?=
 =?utf-8?B?RUNCcUgxMjhMejJtNHNFTnBlaHlXTmdmclhxcVVIa0VmVHdYZmVpYkJ2cUtw?=
 =?utf-8?B?b3lPR3FKQ2FBUVVZUS9SL0p1dUJ3d0s2UUtQeEdzS05oWlUzTHMzOVh5NXV0?=
 =?utf-8?B?bStpWVQvVmpaeTNwb25SK1Z2WlNiTGNmY2hzd0I3VkZZdklpamNQV3ptSmtT?=
 =?utf-8?B?WlNWenBSL2pJL0tTRlVYNjlTUEhheXdxNnNzM0FDYUE2MEdWUGwrVG1FVjRY?=
 =?utf-8?B?anBVcVdmVEs3dWZ1TVF4UVRiV0F2ZFQ4aFNyU3YzZlBXVVVJNExnbDhwa0VH?=
 =?utf-8?B?c211VzErdzB1UXdDQTRYSDRwZWN0UllWanV4U0JIdkpXSFdmRWg3RW5SdFZ4?=
 =?utf-8?Q?r3C3MWY/Y3Vy/w9q7300M5MDy7rzE7AQV59w/gZ8wM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6953acf1-806a-4ce3-cbca-08d99e3ceae7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4720.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2021 20:11:12.7071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XTPSVfu45ZkuM4nN64v6q/l7swTnLeLqIx96GYAyK9EoEqGqO5qFlnOZ9oYx7zjmNKxEf0XqJExeD+lHbCux+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4447
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 10/29/21 8:02 AM, Huang Rui wrote:
> The legacy ACPI hardware P-States function has 3 P-States on ACPI table,
> the CPU frequency only can be switched between the 3 P-States. While the
> processor supports the boost state, it will have another boost state
> that the frequency can be higher than P0 state, and the state can be
> decoded by the function of decode_pstates() and read by
> amd_pci_get_num_boost_states().
> 
> However, the new AMD P-States function is different than legacy ACPI
> hardware P-State on AMD processors. That has a finer grain frequency
> range between the highest and lowest frequency. And boost frequency is
> actually the frequency which is mapped on highest performance ratio. The
> similiar previous P0 frequency is mapped on nominal performance ratio.

s/similiar/similar/

> If the highest performance on the processor is higher than nominal
> performance, then we think the current processor supports the boost
> state. And it uses amd_pstate_boost_init() to initialize boost for AMD
> P-States function.
> 
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
>  tools/power/cpupower/utils/helpers/amd.c     | 18 ++++++++++++++++++
>  tools/power/cpupower/utils/helpers/helpers.h |  5 +++++
>  tools/power/cpupower/utils/helpers/misc.c    |  2 ++
>  3 files changed, 25 insertions(+)
> 
> diff --git a/tools/power/cpupower/utils/helpers/amd.c b/tools/power/cpupower/utils/helpers/amd.c
> index f233a6ab75ac..92b9fb631768 100644
> --- a/tools/power/cpupower/utils/helpers/amd.c
> +++ b/tools/power/cpupower/utils/helpers/amd.c
> @@ -182,5 +182,23 @@ static unsigned long amd_pstate_get_data(unsigned int cpu,
>  						  MAX_AMD_PSTATE_VALUE_READ_FILES);
>  }
>  
> +void amd_pstate_boost_init(unsigned int cpu, int *support, int *active)
> +{
> +	unsigned long highest_perf, nominal_perf, cpuinfo_min,
> +		      cpuinfo_max, amd_pstate_max;
> +
> +	highest_perf = amd_pstate_get_data(cpu, AMD_PSTATE_HIGHEST_PERF);
> +	nominal_perf = amd_pstate_get_data(cpu, AMD_PSTATE_NOMINAL_PERF);
> +
> +	*support = highest_perf > nominal_perf ? 1 : 0;
> +	if (!(*support))
> +		return;
> +
> +	cpufreq_get_hardware_limits(cpu, &cpuinfo_min, &cpuinfo_max);
> +	amd_pstate_max = amd_pstate_get_data(cpu, AMD_PSTATE_MAX_FREQ);
> +
> +	*active = cpuinfo_max == amd_pstate_max ? 1 : 0;
> +}
> +
>  /* AMD P-States Helper Functions ***************/
>  #endif /* defined(__i386__) || defined(__x86_64__) */
> diff --git a/tools/power/cpupower/utils/helpers/helpers.h b/tools/power/cpupower/utils/helpers/helpers.h
> index e03cc97297aa..c03925bea655 100644
> --- a/tools/power/cpupower/utils/helpers/helpers.h
> +++ b/tools/power/cpupower/utils/helpers/helpers.h
> @@ -140,6 +140,8 @@ extern int cpufreq_has_boost_support(unsigned int cpu, int *support,
>  
>  /* AMD P-States stuff **************************/
>  extern bool cpupower_amd_pstate_enabled(void);
> +extern void amd_pstate_boost_init(unsigned int cpu,
> +				  int *support, int *active);
>  
>  /* AMD P-States stuff **************************/
>  
> @@ -177,6 +179,9 @@ static inline int cpufreq_has_boost_support(unsigned int cpu, int *support,
>  
>  static inline bool cpupower_amd_pstate_enabled(void)
>  { return false; }
> +static void amd_pstate_boost_init(unsigned int cpu,
> +				  int *support, int *active)
> +{ return; }

I don't believe the return statement is needed here, can just be {}

-Nathan

>  
>  /* cpuid and cpuinfo helpers  **************************/
>  
> diff --git a/tools/power/cpupower/utils/helpers/misc.c b/tools/power/cpupower/utils/helpers/misc.c
> index 0c483cdefcc2..e0d3145434d3 100644
> --- a/tools/power/cpupower/utils/helpers/misc.c
> +++ b/tools/power/cpupower/utils/helpers/misc.c
> @@ -41,6 +41,8 @@ int cpufreq_has_boost_support(unsigned int cpu, int *support, int *active,
>  			if (ret)
>  				return ret;
>  		}
> +	} else if (cpupower_cpu_info.caps & CPUPOWER_CAP_AMD_PSTATE) {
> +		amd_pstate_boost_init(cpu, support, active);
>  	} else if (cpupower_cpu_info.caps & CPUPOWER_CAP_INTEL_IDA)
>  		*support = *active = 1;
>  	return 0;
> 
