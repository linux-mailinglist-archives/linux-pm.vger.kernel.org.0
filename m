Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 493DE43FE00
	for <lists+linux-pm@lfdr.de>; Fri, 29 Oct 2021 16:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbhJ2OMv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Oct 2021 10:12:51 -0400
Received: from mail-bn7nam10on2045.outbound.protection.outlook.com ([40.107.92.45]:19680
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231449AbhJ2OMt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 29 Oct 2021 10:12:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OxtcmIfy1zThpU+AY7o3IJ8BYnRaCtJ1XDOe4ja8rkAilFmj5HoIW0NXHZ5M3cAHFhs6dyoaeWjpDbmjv0lsvTTs4j5FuxSDITw7tQJ82JiqlwCEccw/te/hTR/QVaDWtxx/DNG3MCT6NA2anw8E7oaTFeVz96zbvzKzGgtI9GBNhZ2H/RrMbqlYtoTb6TgimHnnVhA250/bgIFuIW4LlI3xldN3m4t18JeaJcClxsX3aiZ1B1sUe67aoDuFKZggj2CVN9t7pWoQQd27d7loTRlVphLHxyRuBPHLDQv8jkv6mC3msLGJK2kXLSA1N22NUfnR40FoFuMk/gbSZFP+dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h0VnjmVt9hwX9M1BwolB1MYSXm6ua1/XA0tWoGy/eAA=;
 b=hEPUGq6lEX9WQyt07CBhlfZXQ8FUfIJKFp1WOwzlMrGdygIEJu2Ml5bJg2h5H+JK6Uer8KzfQDP0BW6xlANisk9S0Z6S9qmoUKHaLHvmj8R4lx4k+49UghocJTNi0hlEsf18dRvplkukdLOW7BwIaKjd+/h+9V5L5vWko1EVREW04VWSX6FCB4M+W6qWabIm9eUeCkFTb3ud/z8D2Yg24LRWoOM9FJi7pQMq0Vlkv2sX8IQvRjMz9lPsNClZBJUGVlTRd7NV3Gq6r9mkraL1m+dUuP4fOwcAH2NcG+uGlQN97mDYTHnoS7xWl9CXdWt8ii2sCxuVHUu/JEg9HZGGpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0VnjmVt9hwX9M1BwolB1MYSXm6ua1/XA0tWoGy/eAA=;
 b=erG/BP9McDvQ5imGibecAh/gSv2GS+mh/NjM9f3y1+8cFvvNLVgaZrRztjVrmzfxzn+AaehiXwQjw98E9V7oPjeKBGecAdBl646x9prV4uHUhwqZrL3YpNN3z8BvvefHfDU/RVxaHCoyPqxBrhO5ch9X2RWD4+JOl14ijH7FiPk=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8)
 by SN6PR12MB2639.namprd12.prod.outlook.com (2603:10b6:805:75::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Fri, 29 Oct
 2021 14:10:17 +0000
Received: from SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::7cbc:2454:74b9:f4ea]) by SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::7cbc:2454:74b9:f4ea%6]) with mapi id 15.20.4649.015; Fri, 29 Oct 2021
 14:10:17 +0000
Message-ID: <89c43242-a112-4ba2-ff3d-5e3a0b048a35@amd.com>
Date:   Fri, 29 Oct 2021 09:10:13 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v3 17/21] cpupower: add amd-pstate sysfs definition and
 access helper
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
 <20211029130241.1984459-18-ray.huang@amd.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20211029130241.1984459-18-ray.huang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0104.namprd03.prod.outlook.com
 (2603:10b6:208:32a::19) To SA0PR12MB4510.namprd12.prod.outlook.com
 (2603:10b6:806:94::8)
MIME-Version: 1.0
Received: from [10.254.54.68] (165.204.77.11) by BLAPR03CA0104.namprd03.prod.outlook.com (2603:10b6:208:32a::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend Transport; Fri, 29 Oct 2021 14:10:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 441ea2b8-2cab-42de-7426-08d99ae5d57d
X-MS-TrafficTypeDiagnostic: SN6PR12MB2639:
X-Microsoft-Antispam-PRVS: <SN6PR12MB26397F7792086A45A6E91922E2879@SN6PR12MB2639.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gFnpdPzTymKWP9uu3GbPoenhSp7cYcYq2gAQswv5YVOl4YJZ8klvr90QME/o/kWNxl218ZVa63iZJQB0YjlcmHNSgog3VLqTZ3e3qhrmzcU+DAyOf0x951iyOlqm6kXIP2Cs3Kf5GywD+HULf7EJL0a96TdkW2hRrDOwJNljzGOezgFlWYLixUAh3G5bthkNphO6ssewcRKWLY6844XQz2IbkdS6bLeJ80YkYbvIEVGKSsgzPIpAiBaREt7T2M34lyulEkn16WUF/gbpzzDwy4OEJxG0mh1TLdbi8vPbEPUwkTKZedlgc1UaPXyEHhpIQnt/9HdrJVkp7o6ae4X/OwJOwgxYTUPwPwj00/BG6OCDbQcvfJtoEnkNHEdVXv0UWVaM47I14mRfw2g2LM/QyPds7OSu1Eu9lnNNPkFQvCjsxoI20HKxWqE1S8m52xC3GDRiOOmZOwsyRtXtvAxd2AXBfpivsr/ebeJdQmRKyF1g2Ovl/KS7Yp49nNQ/vwCWu0BY8weRsIxKXJ1/H0LRS+GyDYD3UeTrKEsaRT8HABmdFbFeC/Eje2jtDJaRvacJPhLOULlZv4ne+J85DEsePbfjPMisujSBxn8g3jtl1nHY54alNEgSVEhmYPc3WtoR6TtJWqmNsSkAmFHEIP3TnaObY+xL6RUvVvo4EbTujbHlKcxkTtqbB8s2V4fd8x8sH9N2nXQU5aWrn/snnbRw0V5iG51U1hbojndImBw4TDrHfLtiuHgiNBCQSMEUMRWU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4510.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(54906003)(2906002)(66556008)(956004)(7416002)(31686004)(4326008)(31696002)(26005)(83380400001)(66946007)(66476007)(6486002)(186003)(53546011)(8676002)(316002)(110136005)(36756003)(508600001)(5660300002)(86362001)(16576012)(38100700002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MC9QMTNVNzBhVlk4RjU3RyszaU80eCtBNTFBSDFiZGY2cFpYY2tER1hLdFdi?=
 =?utf-8?B?eUZtU3NEbDVMWUppdEt5YjhTQytkbEsvSXFIR0ZZeFgyNXpORFU5MFVMSlgy?=
 =?utf-8?B?U0ZjSW1yYTNVaXlNUHovd1gwcEVkS05aS2xqeEE5Y1REd1R4b205aW4wcmlN?=
 =?utf-8?B?V3AzMjJibzJIb2NCL1FmR0psS2xPQkJGSEpwUm1ENFFsVThvOUlVU0tTM1g4?=
 =?utf-8?B?M1N1N01Nem1pZ0NKWkJYWHVJUEcyS1U1MWVseGlDRWoyRWtTbzVQV2NPaXZj?=
 =?utf-8?B?ZXRiYWJVWFdZazM1K2NnWFExVlR1YTVNU3BxL1ZRMllPU3B1MmxFQUNjUDZi?=
 =?utf-8?B?UEJrWGJiemUvYm9QRTA4WXhtOVN6VnorY2QwR0N4OWdzTzFYa1Zob0ZoRDhF?=
 =?utf-8?B?TEcrSlJLZGVhejY1RVRmZ2VoTER3RGtpenU4YjI5WjRmenoxNlhTMVhsTFJt?=
 =?utf-8?B?ZTEzT1UzV0xKbTBDTUM0eElSWWovLzd2OVVHSTVMcGtDRVRZdmlacHFGeU1X?=
 =?utf-8?B?K3hKblpyU3hRbzdMQjZ4VmxtcDNJL2RRTUx5RkxQQnI2MElRbm5WeERkbHhO?=
 =?utf-8?B?Tm0vZFFiUkpLT0pHckpHeXJ4VFFtaEhYMERKNllkS3AvNGQwajdxaldjeldq?=
 =?utf-8?B?Rm94Tk9DVmRuQ3Z5MndoWmRxOW5Wek1aYjkyZ01nNlB2RDJMYVRFRlhPUnpD?=
 =?utf-8?B?UXhRQlJkK3NFbVRGT1VUUEdRMTZ6cE1sS0lKZlhHMHhRRG1kbHBuRnRkOFRB?=
 =?utf-8?B?bFFPaVNoRjN4OTlZTkxPR0MybDhyaFR3WVFZU1ZLL3V3TWUvNkNoOVdXZTFP?=
 =?utf-8?B?SjJyT2tzeVA2a1pQUVhRNndMeWEyU0xZZ1BlSURlcWJicmNaUjh0bCtKcHk0?=
 =?utf-8?B?OWJoWjdSdHlFcHNYTWYxaGpWV2NlamdINVlrMlZPRHJrREI2ZWtJTjNQU0xD?=
 =?utf-8?B?YUJsckVLN3pGY2k4ZDM4YVdmejl4QkhyWGxESGR5UmZXNDlyakNCbzEyNHFQ?=
 =?utf-8?B?bFVLc1VKSG10MUU2RXVySHpYUklBR1pvSU55RkZzV1lXdnFickNsSkxrM2FR?=
 =?utf-8?B?cXdydUlSVmo1K3MvakViTlZhenBOSk9lYzU2Y1B2TU9HcDQrOHg1ZkQwTnVQ?=
 =?utf-8?B?YmxPZXR6cWtUZXpzbWh5akx0QjFTL0c1Uk1wdXFCcFFWeHhwOTFYQjNpNkJw?=
 =?utf-8?B?ZDE3M3I4WkhqVjZ2SmZxQ2J0VE5FaEVHb3dsbDlHVWtaZkMrOWV0VUxoNkdi?=
 =?utf-8?B?Y3VDeTZOQlJxSFpzbzFjL1NkUDNGMkpvdXM1ZnpNaGhvNC9HL1FRbFVtOVp5?=
 =?utf-8?B?Z1Zzb1hxYVMvSFhlTUMyZTBnaXhCSVgwNTJtVnlYWk5lU2h0SlNFWXk3V05j?=
 =?utf-8?B?c1duYVQ5TnVHcTNtT0ZSNkMvZWx4OGlNZnBXZnNyRXFyWEtzMG9GN09FY1FB?=
 =?utf-8?B?RUVDaUtxbWhQeE4ySlFFbk9hS0ZCSy9uNSs1Y3hqNVczT3VNRzhzQndja2xh?=
 =?utf-8?B?NUY3dUlvVWpoS3laQ1lLMlg1Q1lvZ0tXOUJycjBJUG84ME1OU3pkRlJGU0Z4?=
 =?utf-8?B?MVc4a0dkWCt4UWNQV3N4bTJ2M29HRXVmNko2cEQ3VzZjNnplc0NzOEIxK2th?=
 =?utf-8?B?RnJ5MmFRUlZBd0Y3OTlXWFBQbERjMitoUXIveGhVNnE1aXZKL09NbHV3cWdJ?=
 =?utf-8?B?QVlsNzBhcGVCMWs0M2ZPUlcyL2RzYVFBS2pmcGIzM2djSzZkRWc0NFhidkcv?=
 =?utf-8?B?Rks4TFJnU3Y1V1ZsQ2IzWFI0WENOcklkSmVoSnZBVXRhb1JCT1pGYThkVFFR?=
 =?utf-8?B?SzZDVXZ1bEpvVVY1dXFqb05FUDkwb2kxbHZsY2U1N25SY3VTL3F1U0E2d3pE?=
 =?utf-8?B?M3p0UlE0S05YT3FmK2pDMCtENTArUCt2YmRtZ3B0ZnNkOWJ3R21HUVk5N1li?=
 =?utf-8?B?N3NzZWlNTjY2ck9BVDRjQk9UckQ4Y0dlR3orUnZrWVNLcHY1dm5pT3JFMy9w?=
 =?utf-8?B?UzR5bXdJWmdhaUdjUlZ0dE4ySVNBdVgyNnZoNERjVFNia3RKQXdmNFZTY3pJ?=
 =?utf-8?B?WGQvNm1STnVncE1BZ2ZWWUdsWDJENVBNU3cxUUtDK3Y0clRzbkk0Zm5PdnJj?=
 =?utf-8?B?bkJQb2hlcE5Fc3o1N1J1YytnUFdHQ0VyYjFxdVVOVGpWbW83WUdpNDhtV3d4?=
 =?utf-8?Q?ejUAIXbGz1uexFy0w5d7Wm4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 441ea2b8-2cab-42de-7426-08d99ae5d57d
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4510.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 14:10:17.1803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YaNpDl0Dlay2wwLKjcO1BD8ze/S1aI3ji+MhbAnRwogqRWQd5tWUnb5xon2pu9AN4FpqmJummUifcg6TIN30MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2639
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/29/2021 08:02, Huang Rui wrote:
> Introduce the marco definitions and access helper function for

You've got a spelling error here.

> amd-pstate sysfs interfaces such as each performance goals and frequency
> levels in amd helper file. They will be used to read the sysfs attribute
> from amd-pstate cpufreq driver for cpupower utilities.
> 
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
>   tools/power/cpupower/utils/helpers/amd.c | 37 ++++++++++++++++++++++++
>   1 file changed, 37 insertions(+)
> 
> diff --git a/tools/power/cpupower/utils/helpers/amd.c b/tools/power/cpupower/utils/helpers/amd.c
> index 97f2c857048e..f233a6ab75ac 100644
> --- a/tools/power/cpupower/utils/helpers/amd.c
> +++ b/tools/power/cpupower/utils/helpers/amd.c
> @@ -8,7 +8,9 @@
>   #include <pci/pci.h>
>   
>   #include "helpers/helpers.h"
> +#include "cpufreq.h"
>   
> +/* ACPI P-States Helper Functions for AMD Processors ***************/ >   #define MSR_AMD_PSTATE_STATUS	0xc0010063
>   #define MSR_AMD_PSTATE		0xc0010064
>   #define MSR_AMD_PSTATE_LIMIT	0xc0010061
> @@ -146,4 +148,39 @@ int amd_pci_get_num_boost_states(int *active, int *states)
>   	pci_cleanup(pci_acc);
>   	return 0;
>   }
> +
> +/* ACPI P-States Helper Functions for AMD Processors ***************/
> +
> +/* AMD P-States Helper Functions ***************/
> +enum amd_pstate_value {
> +	AMD_PSTATE_HIGHEST_PERF,
> +	AMD_PSTATE_NOMINAL_PERF,
> +	AMD_PSTATE_LOWEST_NONLINEAR_PERF,
> +	AMD_PSTATE_LOWEST_PERF,
> +	AMD_PSTATE_MAX_FREQ,
> +	AMD_PSTATE_NOMINAL_FREQ,
> +	AMD_PSTATE_LOWEST_NONLINEAR_FREQ,
> +	MAX_AMD_PSTATE_VALUE_READ_FILES
> +};
> +
> +static const char *amd_pstate_value_files[MAX_AMD_PSTATE_VALUE_READ_FILES] = {
> +	[AMD_PSTATE_HIGHEST_PERF] = "amd_pstate_highest_perf",
> +	[AMD_PSTATE_NOMINAL_PERF] = "amd_pstate_nominal_perf",
> +	[AMD_PSTATE_LOWEST_NONLINEAR_PERF] = "amd_pstate_lowest_nonlinear_perf",
> +	[AMD_PSTATE_LOWEST_PERF] = "amd_pstate_lowest_perf",
> +	[AMD_PSTATE_MAX_FREQ] = "amd_pstate_max_freq",
> +	[AMD_PSTATE_NOMINAL_FREQ] = "amd_pstate_nominal_freq",
> +	[AMD_PSTATE_LOWEST_NONLINEAR_FREQ] = "amd_pstate_lowest_nonlinear_freq",
> +};
> +
> +static unsigned long amd_pstate_get_data(unsigned int cpu,
> +					 enum amd_pstate_value value)
> +{
> +	return cpufreq_get_sysfs_value_from_table(cpu,
> +						  amd_pstate_value_files,
> +						  value,
> +						  MAX_AMD_PSTATE_VALUE_READ_FILES);
> +}
> +
> +/* AMD P-States Helper Functions ***************/
>   #endif /* defined(__i386__) || defined(__x86_64__) */
> 

