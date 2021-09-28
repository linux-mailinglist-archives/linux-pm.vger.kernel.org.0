Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D04EF41B95D
	for <lists+linux-pm@lfdr.de>; Tue, 28 Sep 2021 23:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235874AbhI1VhS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Sep 2021 17:37:18 -0400
Received: from mail-sn1anam02on2061.outbound.protection.outlook.com ([40.107.96.61]:56513
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232358AbhI1VhS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 28 Sep 2021 17:37:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NtnEjvDlXxmNDcfKxIw/+2fiXNMOLQT5H4cZDmBOemWQTkVGRG9OWzHGUOSg+SpBdLBm3TqRP6MRc/AIHHK7PwttGC4jrbI4F1y6sfbcF8XnzdlRpzW8RRnOAH6B7qDdZk7B9C82M1mE7pMWWkehRgjomTxhu8AELb8sDPHFhJfnrLFXgyOpnN5ck7T0hHXjCzXDnmVxP89a5iB7VWVfsEV8TDb2LNcY0RmT9a7CfkqAm0ZbCeZ+k2I8/goZgZWfYiYpqC9Xd3V1xLYWWlmuw3Q4rIrjNjUjjZNgYEGbUlO3wK8xygw9EcxLRgaDTfHDzNTRJRKcSVMaqqqpILYwgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=MCmFe+3a9UI6NZaZHbp7XtuDuw9PsFFSDRMOR36eBbs=;
 b=TvQlBXPkmo8dRj9jlEuCPDUWYrfcCyfyyZkmYH/XalcDBSa3zAjaEJGaZVrBK0JXs9Hd3EUQQAdiQOASsgY1QEWBDfMAkkJUmqjQcU3T7YBTtYrx/ISXY9oQ0GKZv5zS7ZJZGK5gEQ8lwdHlSJUR6/6xZtArs9bwAcrCPtNuM2fsSxy7q+7pPhzCXEPZWZkaLwKhU54mmdAyQWzlisekbqWHJafS7bdgZejA8o7nqyXqYg4uAELrNPUgxVlNs3EWHdUJAeADWxFGPCn4pkySBLTBIIrzLJilL09ALPG/6sHpdHuIxnhYqR0asemkA26tPJvuUEZKLGO4o/JGGofhmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MCmFe+3a9UI6NZaZHbp7XtuDuw9PsFFSDRMOR36eBbs=;
 b=ecD6erxGlXOR4UE1U42OUYk7o4NqLdfCFvcqzzK9B0xwcPxUticavYTTw27/2keTw/sbTdInF07FyTWarnly4E8JlxURiHDB+Et4mjZsTKOcoZ8GY2RoDfPBMdM1O+qeV89xPQGBxHtQdz7VMNdDwz5rxTTPel9+Q6+z7wvMjNQ=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4720.namprd12.prod.outlook.com (2603:10b6:805:e6::31)
 by SA0PR12MB4462.namprd12.prod.outlook.com (2603:10b6:806:95::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Tue, 28 Sep
 2021 21:35:35 +0000
Received: from SN6PR12MB4720.namprd12.prod.outlook.com
 ([fe80::e134:658f:3a82:f750]) by SN6PR12MB4720.namprd12.prod.outlook.com
 ([fe80::e134:658f:3a82:f750%4]) with mapi id 15.20.4544.021; Tue, 28 Sep 2021
 21:35:35 +0000
Subject: Re: [PATCH v2 11/21] cpufreq: amd: add amd-pstate frequencies
 attributes
To:     Huang Rui <ray.huang@amd.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, linux-pm@vger.kernel.org
Cc:     Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
References: <20210926090605.3556134-1-ray.huang@amd.com>
 <20210926090605.3556134-12-ray.huang@amd.com>
From:   "Fontenot, Nathan" <Nathan.Fontenot@amd.com>
Message-ID: <01fab2a8-a5d0-7bff-8245-6ebb31332c64@amd.com>
Date:   Tue, 28 Sep 2021 16:35:33 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20210926090605.3556134-12-ray.huang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0060.namprd12.prod.outlook.com
 (2603:10b6:802:20::31) To SN6PR12MB4720.namprd12.prod.outlook.com
 (2603:10b6:805:e6::31)
MIME-Version: 1.0
Received: from [172.31.10.217] (165.204.77.11) by SN1PR12CA0060.namprd12.prod.outlook.com (2603:10b6:802:20::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.13 via Frontend Transport; Tue, 28 Sep 2021 21:35:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4d73614-c3b9-4c28-82b5-08d982c7e807
X-MS-TrafficTypeDiagnostic: SA0PR12MB4462:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4462AF7FFCCF14F21865D77FECA89@SA0PR12MB4462.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:773;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HQkdKWXVLtYXzgne5oKn0vb7Ihwy6iB+rwbJ8NzHqmVzko3UBZJTAJO2fMdZopuuMrA3TPQjo+/hyBg6IYrOsdTHwkxIoaXsvatgxZU/DhQ6U98SPTaPvzNIe6Ihp3fbopnEPJjxjsUOpsAkZIS68IbNHVGTq6OnK0PSK0/34lvC8f9QAdnlZpucbw4qdz+VI4sdNuh18tmKH4Yzbril61/BVvij+f+t/TZmMMVFCZSHO0dZxmj97dnzhEa5O5FPleisWSMnu9uvyyrJnbc4ZQIqVaTTUzAby7JzsUmz1TumdCUGbS5X3N2wy+QbGZNI5pocqU2WoHmEbP9FaTjvwpWC7Ec3K9fAtVgMVKJwGY20ZxPZm7wk+iBntnSDtPPPOcdmNgiBio2gB7YVJuIbtqPF4irANAqB3WCJSE4V38IXXLlDOEqlOpdNj/NT0uCEx1KlQ8iTC4AKmkRnkiDu44xlxt5R1xP/6Ci0DOvi4KYaCdV5UGFCldeKG8fZ/SsrFdYN0PZH3MLFHWACwl4Bjt08hc0SUy/B1v1bmczHfrlxbi8M8M61WiFqyF9GjHtvHHjI5zOSlhmPb0YBgxL3l+UM/E/8vo9/AZFqcbJ3CwmN6vsWAis1JTKlm1+kDOQkU23xQaX0BUBH5l10Z6ufSlXc7bddKSSyvC/DwxQUo/ractK8G1hMjT9JiYBWwKZbAfbA7B+ADDh8CGhzs/bc7AYbVQGNuzjuixW9A55sqzPANvXvIRiK8pfaF8N2pvCr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4720.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(31696002)(110136005)(16576012)(54906003)(316002)(4326008)(38100700002)(6486002)(31686004)(8676002)(66556008)(66476007)(186003)(956004)(2616005)(86362001)(508600001)(5660300002)(8936002)(66946007)(53546011)(26005)(2906002)(83380400001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTlzU2xxd1VPZ0xVVTRpdWdxNDNWTGZqOTU0Yk1ZK3k5M1RKREZ2R0dYTlJI?=
 =?utf-8?B?UGszZS9zSVU4N3dxQXdRKzdkSWIzYUhuRmtia2xVZ3JScjVhQm9nWjFKU3JQ?=
 =?utf-8?B?MHI4WkV0dC9HdkcxQzBRMEUzNTA0YzZjSmxnY2JoelZlR2pJN2ljVEMyVWxM?=
 =?utf-8?B?UG1adGpFK202eGR0WjkxUk9JeiswLzkxeWVZd3dodTBxYlZDZDJtK1RNemdu?=
 =?utf-8?B?QXVHTGU5QzNwOFpjQU04TEdrSTlHNDN2WmdlYk50NllqTWpmc0trOEtheXFF?=
 =?utf-8?B?Rllibk80WmxwUWc3cE9QK0FXM2RuTDE1K2FOWGt0TCszazJaNGcrTlNHTnNS?=
 =?utf-8?B?RGovWDdnckFXN2xFQ3V3dXZvNFdSaTY2T1NGZnA3K0U3UFZLRWhvMnJxaHk3?=
 =?utf-8?B?R3pmMFpHamdCb0ZzUGtDUEpyS3lKMUgxVlRpSXloMDUwUExJbSt4ZzcyR0ti?=
 =?utf-8?B?NE40aDd3UnpPZjNzaFhlV1JsYmplaTlzcENteFZNTTVaWWlFdEpuai80S1BO?=
 =?utf-8?B?bllmUmtVYWtkaEJRUDJFdFVTVzRjSGVJemNqYmZPMkJOTXAxNDZPWnVCR2dC?=
 =?utf-8?B?Q0Fva3V1OThUSThjRGZpQlZhNDk5MDROa0Q3MXU0YzRvckdieTRjcDE3Lzhs?=
 =?utf-8?B?ZmVkUTRtZUtvclZuUVIxaHQ0VmlPUlF3OEpTWmJleTM1eWVqZzl2SFRsYjAy?=
 =?utf-8?B?SWZsdzNWdjFDM2FNYkNIWTZmVFdwUVM0SlFyc3piOE9kbnZVTUdYWVVFaUFa?=
 =?utf-8?B?MDFXSnl5cDJpVDB0cFp4TldEelpMOHM0OVVUTzhNWVIrTC9WK05lZllVMXE4?=
 =?utf-8?B?Mk00SGFwS1VDVkQyclBrUGlsdndnQjNXS0I2VlNjLzFXemhsY0FtMGNwckZI?=
 =?utf-8?B?VVk4Q2tRYU4vZFJ1ZzVhMWliakxjbmt5azA1cm1tNVFzQktObUt6RXZUeTdQ?=
 =?utf-8?B?bmZadzBGZ09qSnM0VGo3TWkwbUZ0MExOK1pnUy9xNXowTmJWc09QQTh4Zlpj?=
 =?utf-8?B?c1orZDZ5MFFvY2pvRktwdjFjSEVHdU9KQUl2UUdzZ3huVlV3ODJIbXJPcSsz?=
 =?utf-8?B?a2lwRy9EMTNleVBna2swSWc5V2R2UHZUQ0dqT3VHV3drKy9sVjV2WEJ5NGNo?=
 =?utf-8?B?ckZnMUtKOHFtOXgvd0E0dGZtbkZTekJPcTg0b2xDK0s4OERSSE9Scnl0SjZ5?=
 =?utf-8?B?RHFKR0p1dHN5VEhDU0x1UEc0elB5RklHQ0ZTcDM5NnZuMU1tdWJBRzUrVXha?=
 =?utf-8?B?L3o2WFJhMGpLdUJaaXo2RVk0ZDF1empmaDRKNFF4MGlwWXl1MWM5dWpqK2t0?=
 =?utf-8?B?NWRlc2R4OG1pRThZQjNJOGlDV2N2d0FkOVd6MDlzVkhtYlBwMm1QZFMzNVhz?=
 =?utf-8?B?VmZBMktWMGFYQUhCTVZNSXhGL0xWYXg1eEMyazhVYjZ4YmR4YTFFM05IeGFJ?=
 =?utf-8?B?aE16dVZtQmNtSlZKamovNlQrYVZvRUl6OXFOWFkxWHFUOEtwSnFVaytwQXNN?=
 =?utf-8?B?UWFWTk9hYWRjSkVlRWFsS3FEZTB5dHFnRGhJNjNxS0N4VmNKR0VYQ1hod2hW?=
 =?utf-8?B?S3ByMk9ZYzd1eDREakc1TTRoMnEwYkVBaTljanoxaWFHUWMrNS9nNzRld0h1?=
 =?utf-8?B?NEhjMHIrbVFYMHV0ZWFlZkpLdHJ2d3pYL0h0NXF5YlRmOWlCd0xvajBUUHUw?=
 =?utf-8?B?OWtWS0xLMVVNQUlPdnp0WGZtQ3J5Q2tDbTRYSnV6SDNNWW1Hek5CRitnWjY3?=
 =?utf-8?Q?a5845yz+AAGwcbunAKusSiblXwfXYrLB4JX13JP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4d73614-c3b9-4c28-82b5-08d982c7e807
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4720.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 21:35:35.3974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MrwEwqlufDB7+ASd1gitvR65Oko2eo568nojHQAqBhhz46Eu4pZAtGyFVJudllwVyva2bSIiS/3RFhFopkepdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4462
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 9/26/2021 4:05 AM, Huang Rui wrote:
> Introduce sysfs attributes to get the different level processor
> frequencies.
> 

Can you provide an explanation on why these are needed in addition to the
sysfs files created by the core cpufreq driver? Some of these appear to
be duplicates.

-Nathan

> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 71 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 70 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 74f896232d5a..16fed25c3400 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -517,16 +517,85 @@ static int amd_pstate_cpu_exit(struct cpufreq_policy *policy)
>  	return 0;
>  }
>  
> -static ssize_t show_is_amd_pstate_enabled(struct cpufreq_policy *policy,
> +/* Sysfs attributes */
> +
> +static ssize_t show_amd_pstate_max_freq(struct cpufreq_policy *policy,
>  					char *buf)
> +{
> +	int max_freq;
> +	struct amd_cpudata *cpudata;
> +
> +	cpudata = policy->driver_data;
> +
> +	max_freq = amd_get_max_freq(cpudata);
> +	if (max_freq < 0)
> +		return max_freq;
> +
> +	return sprintf(&buf[0], "%u\n", max_freq);
> +}
> +
> +static ssize_t show_amd_pstate_nominal_freq(struct cpufreq_policy *policy,
> +					    char *buf)
> +{
> +	int nominal_freq;
> +	struct amd_cpudata *cpudata;
> +
> +	cpudata = policy->driver_data;
> +
> +	nominal_freq = amd_get_nominal_freq(cpudata);
> +	if (nominal_freq < 0)
> +		return nominal_freq;
> +
> +	return sprintf(&buf[0], "%u\n", nominal_freq);
> +}
> +
> +static ssize_t
> +show_amd_pstate_lowest_nonlinear_freq(struct cpufreq_policy *policy, char *buf)
> +{
> +	int freq;
> +	struct amd_cpudata *cpudata;
> +
> +	cpudata = policy->driver_data;
> +
> +	freq = amd_get_lowest_nonlinear_freq(cpudata);
> +	if (freq < 0)
> +		return freq;
> +
> +	return sprintf(&buf[0], "%u\n", freq);
> +}
> +
> +static ssize_t show_amd_pstate_min_freq(struct cpufreq_policy *policy, char *buf)
> +{
> +	int min_freq;
> +	struct amd_cpudata *cpudata;
> +
> +	cpudata = policy->driver_data;
> +
> +	min_freq = amd_get_min_freq(cpudata);
> +	if (min_freq < 0)
> +		return min_freq;
> +
> +	return sprintf(&buf[0], "%u\n", min_freq);
> +}
> +
> +static ssize_t show_is_amd_pstate_enabled(struct cpufreq_policy *policy,
> +					  char *buf)
>  {
>  	return sprintf(&buf[0], "%d\n", acpi_cpc_valid() ?  1 : 0);
>  }
>  
>  cpufreq_freq_attr_ro(is_amd_pstate_enabled);
> +cpufreq_freq_attr_ro(amd_pstate_max_freq);
> +cpufreq_freq_attr_ro(amd_pstate_nominal_freq);
> +cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
> +cpufreq_freq_attr_ro(amd_pstate_min_freq);
>  
>  static struct freq_attr *amd_pstate_attr[] = {
>  	&is_amd_pstate_enabled,
> +	&amd_pstate_max_freq,
> +	&amd_pstate_nominal_freq,
> +	&amd_pstate_lowest_nonlinear_freq,
> +	&amd_pstate_min_freq,
>  	NULL,
>  };
>  
> -- 
> 2.25.1
> 
