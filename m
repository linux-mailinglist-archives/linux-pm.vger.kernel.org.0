Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74B3A403E63
	for <lists+linux-pm@lfdr.de>; Wed,  8 Sep 2021 19:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352465AbhIHRdt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Sep 2021 13:33:49 -0400
Received: from mail-mw2nam10on2059.outbound.protection.outlook.com ([40.107.94.59]:2422
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230091AbhIHRds (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 Sep 2021 13:33:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UPSyaPBk5zjlFlF0TDNLTIB18E8fZXsnCbkp5pc3xejR3R3cgdb0zUybN1vjVyVCPhNuGHINfmNr+/s69afpIg9cE/LYK90G3hIW1aGT3QElXaVy4CsUGqvvAr3O+F5JFdhSmQr4odaW/T83n3Vaw5kXwaOkfwgSMSpQIiyueRA7DbHP9e8nV4oIxGyv7j6rWEWxe3KZAUwWr7pYkEILOdZBWuplL8jY1FZFmYVGr5ud0cwOaX/LXPYYRgYzcQeuFG8zpUqUW1iuaA7P49W6sodUH3I8nEB3eEaJqaHZs/EU8YZ8lcbkHtBltjztUVdrfx+jkQkS1WrP7DQiX+5Klw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=A4+gnsMzF1FJ28K6HQwxm+Rr+RovIv3vRB4626zrPas=;
 b=eWd/WJI810EabEI1++hRYO7qnZmzvr9Ra9PW6SPPVnmaHbk1HIwFdGIDvTO9u40Gy2d45meaohsZBDFzyH6As5HBCcgwqZ+2hDLXQFCX2WoW6cuXanNpUeubcjOs0GDdIq9x2Iw+5uQF3bWMPMBhcLzHegl9n+VxiUkROWpVw39YVXgIP+2osEZ/pt3SMbFfFAB8APkUux8gsm1MuVrDojan0zQ/cqIOCGtuvvV6yvph6W7iGeHt1ugATFWOBssTJM8Y3mMe43BVe59zlDJhoFTdXROdvw5uyqBOlb6yKrf51p3MmGd0hY1aonk+1rZ3aXMoQNY4er1lZRdh6GS5Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A4+gnsMzF1FJ28K6HQwxm+Rr+RovIv3vRB4626zrPas=;
 b=y1be77GuY6DZzMIUPA/QSQbvUk0EyxYLb+4Lh7zE+8BOVzn2I3dwF75Tc2dpgCfG104RtH/vHgzMjCNRC1A2F7or3+vPg7ZFi4fBlVpE9BY5M1yJzfhUjuXFIk/tPVKso0xm3Gzso7ZT4vmz5OIK3M1FlACLJjfRDFjh02MstZg=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4720.namprd12.prod.outlook.com (2603:10b6:805:e6::31)
 by SN1PR12MB2480.namprd12.prod.outlook.com (2603:10b6:802:22::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21; Wed, 8 Sep
 2021 17:32:39 +0000
Received: from SN6PR12MB4720.namprd12.prod.outlook.com
 ([fe80::e134:658f:3a82:f750]) by SN6PR12MB4720.namprd12.prod.outlook.com
 ([fe80::e134:658f:3a82:f750%4]) with mapi id 15.20.4478.026; Wed, 8 Sep 2021
 17:32:39 +0000
Subject: Re: [PATCH 16/19] cpupower: enable boost state support for amd-pstate
 module
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
 <20210908150001.3702552-17-ray.huang@amd.com>
From:   "Fontenot, Nathan" <Nathan.Fontenot@amd.com>
Message-ID: <5353e053-084d-9a29-bae5-c1e1d597d1e3@amd.com>
Date:   Wed, 8 Sep 2021 12:32:37 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210908150001.3702552-17-ray.huang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0076.namprd11.prod.outlook.com
 (2603:10b6:806:d2::21) To SN6PR12MB4720.namprd12.prod.outlook.com
 (2603:10b6:805:e6::31)
MIME-Version: 1.0
Received: from [IPv6:2600:1700:271:b60:39a5:4135:fa07:41fb] (2600:1700:271:b60:39a5:4135:fa07:41fb) by SA0PR11CA0076.namprd11.prod.outlook.com (2603:10b6:806:d2::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 17:32:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a124219-5d51-4254-669e-08d972eea78b
X-MS-TrafficTypeDiagnostic: SN1PR12MB2480:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB24803574416754D5B8DF55A2ECD49@SN1PR12MB2480.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UCNHyt41YAh0CyNDdXmP1icuFgp9OTAwFlFA27+aB4PJoHCtiEpKLyaxIH1WRBT5w62YbVmcwDXN9bLTuk0fjGfr2MInHpxRCM+KA9whrZhmuxQp97AFuJh0ltBmvs0LDFdShfLrip68QR5P086qTYJBI8pKniiBexIEYJKl4SOr9sZo9FIchZjXg4gvhOHYYy9hHszZ1+JrOgy0iUV1vXVeT83ahviowH0EWW21GW8nVE6H4gPWsbHng4y0QhQNM2PDloIYiu8Qha76RfDXMjQ2r1rDY667m0bvfqHsssUBQ4vozR6kd5MfbTNyc93WfTGC3RLK0eNBFafEWaOFeIwnTheutIFvZpuFuaWD18Q3QgP4EQLz6D5R42dAyHQaDODmSUAywMtFIy5GJc5mcBAlZ8nWdEk/5ywN3go8M8PY+x4LeIhwUhi3sRP6I4QqE41tLwWJca/iiqVXrIhhxP86pTi8NWuf9hAGnUcoXc9W+I33j391OTeLxbRE7TAweBlUudX84mYBeMtyTVIxymlN0sSC5Sc3kPR+Hqhbs1U9RO4z90kCEiptfagV0xG+xivCsbAtj0EuyHEBsWNvmE0EEesKzKmjSgjM11kkCkciBWaysvKZ/80JaHFmLNxFzQmHc4J6ktw8qXqCEbOh9Ln1ofmJC6pXsFZ5lV/9CWwBsLp2wq9Z5rdA8VkT/PMRPtL+edZgQnw/p1v0bGm/G6ikb5vLqihdaaWn8bFJ/m8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4720.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(136003)(376002)(39860400002)(346002)(8676002)(31696002)(478600001)(110136005)(53546011)(54906003)(86362001)(31686004)(2616005)(38100700002)(186003)(5660300002)(8936002)(36756003)(2906002)(6486002)(316002)(4326008)(66946007)(66476007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWx3bU1BL0xoVjVJUzFlOEF1bmY5b3FaV1NkcTVzRUlra1habzA5dytvUnlU?=
 =?utf-8?B?aTNYWjNWYmFVM29Ma3VtZmI1QTRzeEdVTldaR2RnaUw4TnlKUk9nOTU3aTl6?=
 =?utf-8?B?blZqL1d0U3FadEFHRG94L1dMcDhiaEMzaXNOcENIREIvMllRWXh5L3dCVGdH?=
 =?utf-8?B?TjVQcEtoc2tVTlVHeCsrWFZWeUxPTHlBZ3IrZ2Vtb0VHQ0VaemIrdFNSc1Fw?=
 =?utf-8?B?Y3BPdHg4cEVhK0doZThucmFGNEJVSHF4aGVLai9HTnJ1NkFNbGRma1A1RDgr?=
 =?utf-8?B?aVVIZWtkdTFkVzFIRUVVT0YwZUNZTThrcENTL2E0NHVoekRnOWJRZ1hRU250?=
 =?utf-8?B?MlkxSFlmYlE5SGdqSnhYaDZ4WDhYd25hRUg3OXNSQzB0cG56S2NZTVZPVXRK?=
 =?utf-8?B?cEFSb0ptRXNJU0pYbzFyOTQwajU4T3c1bFRSZHBIaFVMY29QWVlkeUQ3Zm53?=
 =?utf-8?B?TS8raXh5ZlVhWlF5Q2R0bnZJUDd1d1V6cGZPNnN5VGduYUpvRlprRENTVEZK?=
 =?utf-8?B?VGNqSDJFUGVvVUZvdERURUVQOHh4WDNSQVF3ZXFvbWZ3dXdXc01WcEIyTHBI?=
 =?utf-8?B?Z1MzWHgwMTBCc3pnUDdjek5iUEhoZ0hac202Rmd0ekZTbUsvR1JnQkNWTEdl?=
 =?utf-8?B?dlBpdFpVQUZ5NkpyWDZSNHhqd1lyTTBzWjA3L1JMQWtFdVhKRjZ4Tzdoc09V?=
 =?utf-8?B?dzVaS1FIOUFoVWszQzRYSGZkam91elZBMlZtd0F6ZE5tWldmVXRTdUlRM0Yr?=
 =?utf-8?B?K2hUTW1rNVE1M20xYjNaeGlBblVCejZCWis1Y2o5VzVWbEdhWHpqUkpYTjBX?=
 =?utf-8?B?SktLL1cwQ2NnTlRodnd0Q1ExNUFwK1YvT2l4YmtMYTZSbWw3bjUzOUlWc2dy?=
 =?utf-8?B?bnhWT3JXRXlhOFJpcU96TzcwaFh3eE1Pbysxb3BUSzBJTFRGcHhvZ0tUMklL?=
 =?utf-8?B?TCtRaXFxS3V6ZVpMYWdoZS82TmRqeEVuNzVlQWpYVE84SEI1eVJzdVN0eloy?=
 =?utf-8?B?K2FJRnUrdk91QmZROThGVGtadDBDbWpHR3hUSXZUSVZuRmxJd2tEVm5GWWkx?=
 =?utf-8?B?NDhyaGFGWnVxTE5hVWtFaVR5NnBTbWk1Sy9yR1BRQkI2dC9qQjJyMUdUK1RD?=
 =?utf-8?B?MlFEMUthOVMwVU1pQWNZNlVyazNXQUhPUVpDdVl1VlJaVk5LNDBNZXUxRHlX?=
 =?utf-8?B?WmtzdHE2ZEsraEV5S3Y1N0xMNUh6bm1hZHloamhOR3hzcVBTWTVDVlpFaFcy?=
 =?utf-8?B?RTF4V2NaYU1MZlZ6WFh2REI2TDNyUGlLc0VBbkxBZ0RwUkpnRmpkeVAyUmdP?=
 =?utf-8?B?NUJLMCszTWR1ckhUSkg1NFkwa24yUW5XMm9mY1ZBNTR5b0E5WGppYXpjcWpD?=
 =?utf-8?B?Tmt5cjdzbWp5YVhVbE00TTk5TjNFSjU5dWdKUzZqQStrWW8rVC8zOEREYkly?=
 =?utf-8?B?SGhYdGw4YXBxOEtVNGY5ZzJlTitRdW4wZlUvM3BrSTExK1RDL3RlVFM3Q2VQ?=
 =?utf-8?B?cXpBcUJ4Y29BejgvTnZJYzFIVG1vazlZczdLRGV2SEJYU1N0VGF1a1JncmFH?=
 =?utf-8?B?QnorTVVueDRidWR3QXlJaWdKUk91NStNYUNzeGQ2WUtneHQ2eW5PVmQvWXhG?=
 =?utf-8?B?QnFsSXl5Q3F2TXBiMDV2emtOam9KK3dzZmt5cU0rZFJyL0l1b1ZZc25hQVZz?=
 =?utf-8?B?VUkrTWdCQ0JjcU1WT0FSbmdaWnlNV1E2ZS9NendQRlVYVWhrS1BoUkF5Z21G?=
 =?utf-8?B?U2dCa0l1S3BrMVQweVlKbkJUanM2R3FuSGVsQ0RQUE4zdTVlMGNJZldOc3or?=
 =?utf-8?B?Vkw5cTd1b1dSdFEzaWdGK1VVdTVJVXk4VlhFTzZ2N0w3UFkzM3d1TmMzaHg2?=
 =?utf-8?Q?LBfAKwpdNQ5Oj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a124219-5d51-4254-669e-08d972eea78b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4720.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 17:32:39.0518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: apPUYmuHcL2hb12VGV2vd9gKVfgpKjkIq6onJ/wWWb1HoXvskBAtuWrJEMBVNuugtmlh7sAqxChUUT/Zf8fUkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2480
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 9/8/2021 9:59 AM, Huang Rui wrote:
> The AMD P-state boost API is different from ACPI hardware P-states, so
> implement the support for amd-pstate kernel module.
> 
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
>  tools/power/cpupower/lib/cpufreq.c        | 20 ++++++++++++++++++++
>  tools/power/cpupower/lib/cpufreq.h        |  3 +++
>  tools/power/cpupower/utils/helpers/misc.c |  7 +++++++
>  3 files changed, 30 insertions(+)
> 
> diff --git a/tools/power/cpupower/lib/cpufreq.c b/tools/power/cpupower/lib/cpufreq.c
> index 3f92ddadaad2..37da87bdcfb1 100644
> --- a/tools/power/cpupower/lib/cpufreq.c
> +++ b/tools/power/cpupower/lib/cpufreq.c
> @@ -790,3 +790,23 @@ unsigned long cpufreq_get_transitions(unsigned int cpu)
>  {
>  	return sysfs_cpufreq_get_one_value(cpu, STATS_NUM_TRANSITIONS);
>  }
> +
> +int amd_pstate_boost_support(unsigned int cpu)
> +{
> +	unsigned int highest_perf, nominal_perf;
> +
> +	highest_perf = sysfs_cpufreq_get_one_value(cpu, AMD_PSTATE_HIGHEST_PERF);
> +	nominal_perf = sysfs_cpufreq_get_one_value(cpu, AMD_PSTATE_NOMINAL_PERF);
> +
> +	return highest_perf > nominal_perf ? 1 : 0;
> +}
> +
> +int amd_pstate_boost_enabled(unsigned int cpu)
> +{
> +	unsigned int cpuinfo_max, amd_pstate_max;
> +
> +	cpuinfo_max = sysfs_cpufreq_get_one_value(cpu, CPUINFO_MAX_FREQ);
> +	amd_pstate_max = sysfs_cpufreq_get_one_value(cpu, AMD_PSTATE_MAX_FREQ);
> +
> +	return cpuinfo_max == amd_pstate_max ? 1 : 0;
> +}
> diff --git a/tools/power/cpupower/lib/cpufreq.h b/tools/power/cpupower/lib/cpufreq.h
> index 95f4fd9e2656..d54d02a7a4f4 100644
> --- a/tools/power/cpupower/lib/cpufreq.h
> +++ b/tools/power/cpupower/lib/cpufreq.h
> @@ -203,6 +203,9 @@ int cpufreq_modify_policy_governor(unsigned int cpu, char *governor);
>  int cpufreq_set_frequency(unsigned int cpu,
>  				unsigned long target_frequency);
>  
> +int amd_pstate_boost_support(unsigned int cpu);
> +int amd_pstate_boost_enabled(unsigned int cpu);
> +
>  #ifdef __cplusplus
>  }
>  #endif
> diff --git a/tools/power/cpupower/utils/helpers/misc.c b/tools/power/cpupower/utils/helpers/misc.c
> index 07d80775fb68..aba979320760 100644
> --- a/tools/power/cpupower/utils/helpers/misc.c
> +++ b/tools/power/cpupower/utils/helpers/misc.c
> @@ -10,6 +10,7 @@
>  #if defined(__i386__) || defined(__x86_64__)
>  
>  #include "cpupower_intern.h"
> +#include "cpufreq.h"
>  
>  #define MSR_AMD_HWCR	0xc0010015
>  
> @@ -39,6 +40,12 @@ int cpufreq_has_boost_support(unsigned int cpu, int *support, int *active,
>  			if (ret)
>  				return ret;
>  		}
> +	} if ((cpupower_cpu_info.caps & CPUPOWER_CAP_AMD_PSTATE) &&

Shouldn't this be

	} else if ((cpupower_cpu_info.caps & CPUPOWER_CAP_AMD_PSTATE) &&

-Nathan

> +	      amd_pstate_boost_support(cpu)) {
> +		*support = 1;
> +
> +		if (amd_pstate_boost_enabled(cpu))
> +			*active = 1;
>  	} else if (cpupower_cpu_info.caps & CPUPOWER_CAP_INTEL_IDA)
>  		*support = *active = 1;
>  	return 0;
> -- 
> 2.25.1
> 
