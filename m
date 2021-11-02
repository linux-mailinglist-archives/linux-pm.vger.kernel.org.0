Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 820D4443688
	for <lists+linux-pm@lfdr.de>; Tue,  2 Nov 2021 20:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhKBTl0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Nov 2021 15:41:26 -0400
Received: from mail-bn8nam11on2041.outbound.protection.outlook.com ([40.107.236.41]:23904
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229764AbhKBTlZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 2 Nov 2021 15:41:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cYil15RdQ0r4V0XXMKiK1XL5RssdgAg43YTuprviQ9UHW4YPP7zZdSIEEs6ueYhdPFHmb57GfGHzi01X8WaznP7DfzK5UKb84/NGalCujwDcXbo4V8E2KWrIqe1wNz4F2yYC3XwP1bqA4jTAIlPaWL+Nzk5mvp8LvmRPfdcxRN7BTgEnoWNVmlgco7cXxOSDdL3hPZLuhTsquDDUh0pqt375ze9aUUCL2ozP0czSDDoODjB/BUPNmsZ21xvl6lbFB8UVuk0Jojrwl9uirCINXg/XaeV2FdkJi/EkXd2jv4ArCasGteCcNxcYd5JALcTVRVkqiOE3phXcoO+f2NDiEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ndZ1pNqg4VyXA+PylRcxVGHtllJ8AhhztfN8UnW8rVA=;
 b=k7wxnAesrTT2PH3qMstEeBe3WJGhxHVNCJgwY/HXdjh5JsH/u0cJuvldQIyJohpS3T6Idq8GQVsbaIXoAUzHsy40W5Zgv9eIs0Umef84XpODh4DEsgIvDjLmuoIgxlgkdeX4EJkfIMBMxvN0DeKZ/BnwhPOKpZbp8lthyAzCYSbM9Is93Cz3f832MUzICAWIyZ1siaIxpDTX0kGS+ZIpqWns6/Jl48z9nbxw7tQgwXqqiPGa+Teiy5jHOlsxucHj+WMtF9YLzKB7ROKVolKDGGbaFNhhApg0hdce07ggHibhjgzmZS8H9l07zUTzxS7Esumgq2O65lhu4UCFIsssRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ndZ1pNqg4VyXA+PylRcxVGHtllJ8AhhztfN8UnW8rVA=;
 b=ICNt5JBwX46gxJy6bTa3SstSa1x0A0/iuUhhSqsR1N9qIQ8CM4/vIJ+YiyczcOIbU/2C2HC/UP9DwnwMYuLflMerRkRjXrQzJcIZnFkE52crPDfHdx2rU8mcRp1aawDoV9OMOTzespXJ+mw0KZCMgrfFO0CDJ5VUaMgB094lo9w=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4720.namprd12.prod.outlook.com (2603:10b6:805:e6::31)
 by SA0PR12MB4462.namprd12.prod.outlook.com (2603:10b6:806:95::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Tue, 2 Nov
 2021 19:38:47 +0000
Received: from SN6PR12MB4720.namprd12.prod.outlook.com
 ([fe80::c4b9:b9bb:e863:af39]) by SN6PR12MB4720.namprd12.prod.outlook.com
 ([fe80::c4b9:b9bb:e863:af39%5]) with mapi id 15.20.4649.020; Tue, 2 Nov 2021
 19:38:47 +0000
Subject: Re: [PATCH v3 06/21] cpufreq: amd: introduce a new amd pstate driver
 to support future processors
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
 <20211029130241.1984459-7-ray.huang@amd.com>
From:   Nathan Fontenot <nafonten@amd.com>
Message-ID: <012f60e6-af5a-5102-b35f-7b14ac9ad198@amd.com>
Date:   Tue, 2 Nov 2021 14:38:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211029130241.1984459-7-ray.huang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR04CA0206.namprd04.prod.outlook.com
 (2603:10b6:408:e9::31) To SN6PR12MB4720.namprd12.prod.outlook.com
 (2603:10b6:805:e6::31)
MIME-Version: 1.0
Received: from [IPv6:2600:1700:271:b60:1e21:1149:b336:3db3] (2600:1700:271:b60:1e21:1149:b336:3db3) by BN0PR04CA0206.namprd04.prod.outlook.com (2603:10b6:408:e9::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.18 via Frontend Transport; Tue, 2 Nov 2021 19:38:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f8cd0e2-dbaf-44ae-ed47-08d99e386352
X-MS-TrafficTypeDiagnostic: SA0PR12MB4462:
X-Microsoft-Antispam-PRVS: <SA0PR12MB4462A67DEA3DF50CD48CC83CEC8B9@SA0PR12MB4462.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jbH/U3bDOzI3QL25sAWxyA2ohgSFUVyGugja3hk1nzDRzwqgb54nlWZZdvxJ0k+8RUSAE2TZGoS7ibREWNPcMRANpH+EpqpUqaV4yiDOWIZWfk0y9m2aLTZHpWVHvbEl3lt2C9/GSzlT2aEYCA5qP3pOtqYm2YX7MyAVTAg1CyPIYsNzQXpnUKCuJ/JlmQauY2Cz4MY5qZKUKL1SGcDosALAtATkQgCzjBMhiZfnylNnkg6xs9cfs/TKxhUYgpbs3b0mxGmLjFpZXZ6Cb1xbVaxteDVJACklxuaGtqWpyG1dodFn3/TBkV142bWYfsqsYGn/4tZnfTvfU1PqgHtG4byNtM8JlOX6DUBzdQhCbPdOHX3Qk3IDyQTUNY6CVKbxNjsSxwFw+PlvxlgsTPYy7DrrT4wKXASJKSxZkakgyY7rgVG5+AFnVS2VJ6j/0U9ZqrmY5YsnpjDnFdmeA5urmQ+QJMwCKC3SFAAYge+IZoXuh1KyIj6qmAnwuRis+7nfztuQhoRQhXw9CCRYhI/jptraQG4ORJZ0yAVI5/BufbnKzowPyeBgjU6C7+exP8ggUUED59D/WiG2NMW/R0/RRAs99Feufxp6tOcxKd70YvUbFiqcx3R1E9YZDZ92YXQ8MpikgjsnqrdgIh+C6ttQIHM4EeJNJJdAxZjDBiJQ5aurWCXLpFuLoB9O7Zfzc0Cw0vBp3SwryVokpZYDjWqaae71GzGQ8ZmLA/2fEoVzgKp74QDc0TcSDOlhjaKfcCHeh+YDine66JENfkU+rcCU0ILtq6Q/1QtJAk68N5xEKH5IAigt4pbFCWrOOHjSbiroWVM412I1TOg4Y0wV1C/PCssCJhcGogqzqjf2BltRCGI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4720.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2616005)(508600001)(8936002)(30864003)(186003)(31686004)(36756003)(83380400001)(54906003)(316002)(6486002)(5660300002)(110136005)(4326008)(38100700002)(7416002)(66556008)(31696002)(2906002)(66476007)(966005)(53546011)(66946007)(8676002)(2004002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXdRYysvYzRBV28yZWpMcGQwVGcrQmliU2owbVFyejFwclRsTU5oOW9tODVT?=
 =?utf-8?B?ZTVLTVVRc0wxUnE4V2FKcWVMenF3ZVMwN1F3djdBMC8xbG13SjM0NVR2V0dD?=
 =?utf-8?B?a3dyZVVSWEtqc3ZncjlxV1lnbjhEbG1GQW4yS0dOR3dDRDRxTXk0NVFKbnhH?=
 =?utf-8?B?cjJSU1FSUklnYm9jUlRKb2ZDWG1nZGpsTndKYzVSWW5EK0VGTElzbzFXR0ph?=
 =?utf-8?B?bCtSM3ZJT1U3R09uZ3kraDlXY0xzS3UwUGQxekJBZU5GM3B0bmpnN1gvVFJz?=
 =?utf-8?B?OWRhZnI3Z0xJRkRxZlFMeGpjeGthMGp5cTRXdERGVFpoVmdwUk9wZCt0ZVlU?=
 =?utf-8?B?SXM5NDVmSHBhTmFKaTd2NjdHcmRXRDdpcUdzanZmM3lKZTZEaVFFOGY0T0dN?=
 =?utf-8?B?cXFpM3EzdkZYSjhndDRoUmsxaWRWWWE5RExNRHkyL1ZSN0lYdGE2K0V5MGlB?=
 =?utf-8?B?MVI0N1BUUWxkWFhUS3cxZUw1Q2krM1FwR1ZZS2g3QUZGMlNXWFg1M0F3SHZp?=
 =?utf-8?B?clE4Z0xoTGN3ZFhXNzR3VmpnSzlFdERYOWo1T0o5VTBzeGdsc1JOMG85b1do?=
 =?utf-8?B?bkU4MWwzbGdCcmhKeXJjTDQwVkZKZmVCQnlhREd5YjFUWWlVYlAvSEdLQjZC?=
 =?utf-8?B?M0tlNGN2eEZPMjJyUGVTeTlRUGxVSElEK1JHNThBT3FhVmN4VlpUVEJjeTl4?=
 =?utf-8?B?blRGOGRFNlA5bEZ2NFVBUWxpdGUwbmcwaW4xTUZsSHo4ZldwMWdYMXV1RUFH?=
 =?utf-8?B?dzZuQWRhMG9IK2FkR3dvV01lcWZQa21NeTBzYjFQTGVZMmxWNHFWRU53dzlP?=
 =?utf-8?B?OUhNMVVLNTBnbE9nWkVRMmxDVDNWNEtOb3NONlFTajRJNEkrNkM3TGdDMHdI?=
 =?utf-8?B?T0UyRFJaRHo5SXdGOUx1QUh1RkdRS2FwZzdmM2JJSGowMkxoRS9INHJyN3d2?=
 =?utf-8?B?YTRvZnh1QVpkbGRNYWM3cnJ1dndTcGFvQmZTc0xEbTQyK3Iyanh6VmFQRXBG?=
 =?utf-8?B?RzNhakRwRU9CU0lpLzlqajk0akNuVjdtSEFndmRrQ294dStUV1o1U3NBbDRU?=
 =?utf-8?B?dG9aTHRvNHU3UnVwaWRPSmNjUWpvUS9YMlNkRDJuR3c4UXFVYkx3TTFFNmo3?=
 =?utf-8?B?bzZ5S0VrZVd6VVJPTFQ1TXM5WXh4a1Q1cXF6eWRKMHY4bHZoTHREaEJ5QjJ1?=
 =?utf-8?B?ajJFMCtXQ1ZLVTl4VDdSSlN2VGZHT2V1Vy9IS2hOSE42V29RMjBXSEozcjIw?=
 =?utf-8?B?bzZEY0UwMDFUQkZGWVJMM2NQRXA5ZWFpNmpyVCtDQTVXdkRXNDc5U3RBeSsv?=
 =?utf-8?B?MHE1MFIxK2x1L0NGNW5VWlNtQWU0NjVWZE90UW1aMjlpRVVCbmVsZkZDemJE?=
 =?utf-8?B?SkZGNGtQSGsvZG8zTjlJR2ZPd2I0OENhL3RpZThJVllZRFV3WndhYVlLSmhm?=
 =?utf-8?B?OExsTHFGbFM1ZnpUMjVTWi9Sdnhpbko4U3JJNXBsR0lxeU9ham5HNmFoMkQ4?=
 =?utf-8?B?ZmVjYzR2VDFoRkJlOWhTZTVaZGJzTVZRanV5UW1iSXNMVnR4bUhpYU1OZnJx?=
 =?utf-8?B?R0laaG1tSWc5Zi9ocjRMOVNrOUJMME1Vc3grZFpQam4wK3dXVzNLOW9QM3da?=
 =?utf-8?B?S1dkVzFOVzBwRG9oZ3ZzcUZ6Sk54WXp2T0JCcENKanEyRG1mZGpFQ0xRTmpw?=
 =?utf-8?B?Q0N5QWtINWlibU13anpqeTF0VE5zTmlYaWdqSUt3cTQ2citQTEY0T2NiU3Zl?=
 =?utf-8?B?Z3E3bVpXZEk3QklUdzFkVWh1RW90VjdnTTk0OEdHTGNZUjJlTUNWUFdjRHVn?=
 =?utf-8?B?UlEwc25sckxQQnJMaUdISmhheHNRbXpaR2xwY0tXcDcybGRRVkF6cDMzSlhD?=
 =?utf-8?B?MzRraWpuK01yVnA4YVZDdE4zc21saUxXdmNhc1laZzJCMDBjWExyYXdKSnZE?=
 =?utf-8?B?cXNrTlpWR0M1ZmRCTkdZa3BtU3QvTkdURnhsV2dabnRVd2ZGRDZNcHZDaGRN?=
 =?utf-8?B?OFlodTNGZ3QyZUlteHBHdEtXelhoNGJOWmREOHYzNlRXK21VNE9WdHl0UzQ1?=
 =?utf-8?B?RkhLRzNFUlNDRlVGOFN1d1NZRkxJMGwwcjhjWEgxU2M2b0crODNzSldOeWZU?=
 =?utf-8?B?Z2FHYWJPQWhmVmlXcGZaOHdYdSttSFc0aU9pREVJeHVkdVlDRGtRMisvbm15?=
 =?utf-8?B?TFo2bFF4NFN6YnhoUERjMXpEc0lZV0wyUzVvNmFESjhwTmh6S1JHZmFqZDI3?=
 =?utf-8?Q?CaD8k+tbvBqo7RbFpDc1RjOUUk8s5oJZHy4VgRs0Gc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f8cd0e2-dbaf-44ae-ed47-08d99e386352
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4720.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2021 19:38:47.3510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZyXjOGwnSdW/EUUPCfJ11FN0ri7HeQT7327/gzKk2YY/mPiSjaUCbcaY6VkDJfkmjhWIaPxnPL35j++QTBMVGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4462
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/29/21 8:02 AM, Huang Rui wrote:
> amd-pstate is the AMD CPU performance scaling driver that introduces a
> new CPU frequency control mechanism on AMD Zen based CPU series in Linux
> kernel. The new mechanism is based on Collaborative processor
> performance control (CPPC) which is finer grain frequency management
> than legacy ACPI hardware P-States. Current AMD CPU platforms are using
> the ACPI P-states driver to manage CPU frequency and clocks with
> switching only in 3 P-states. AMD P-States is to replace the ACPI
> P-states controls, allows a flexible, low-latency interface for the
> Linux kernel to directly communicate the performance hints to hardware.
> 
> "amd-pstate" leverages the Linux kernel governors such as *schedutil*,
> *ondemand*, etc. to manage the performance hints which are provided by CPPC
> hardware functionality. The first version for amd-pstate is to support one
> of the Zen3 processors, and we will support more in future after we verify
> the hardware and SBIOS functionalities.
> 
> There are two types of hardware implementations for amd-pstate: one is full
> MSR support and another is shared memory support. It can use
> X86_FEATURE_AMD_CPPC_EXT feature flag to distinguish the different types.
> 
> Using the new AMD P-States method + kernel governors (*schedutil*,
> *ondemand*, ...) to manage the frequency update is the most appropriate
> bridge between AMD Zen based hardware processor and Linux kernel, the
> processor is able to ajust to the most efficiency frequency according to

s/ajust/adjust/

> the kernel scheduler loading.
> 
> Performance Per Watt (PPW) Caculation:
> 
> The PPW caculation is referred by below paper:
> https://software.intel.com/content/dam/develop/external/us/en/documents/performance-per-what-paper.pdf
> 
> Below formula is referred from below spec to measure the PPW:
> 
> (F / t) / P = F * t / (t * E) = F / E,
> 
> "F" is the number of frames per second.
> "P" is power measurd in watts.

s/measurd/measured/

> "E" is energy measured in joules.
> 
> We use the RAPL interface with "perf" tool to get the energy data of the
> package power.
> 
> The data comparsions between amd-pstate and acpi-freq module are tested on

s/comparsions/comparisons/

> AMD Cezanne processor:
> 
> 1) TBench CPU benchmark:
> 
> +---------------------------------------------------------------------+
> |                                                                     |
> |               TBench (Performance Per Watt)                         |
> |                                                    Higher is better |
> +-------------------+------------------------+------------------------+
> |                   |  Performance Per Watt  |  Performance Per Watt  |
> |   Kernel Module   |       (Schedutil)      |       (Ondemand)       |
> |                   |  Unit: MB / (s * J)    |  Unit: MB / (s * J)    |
> +-------------------+------------------------+------------------------+
> |                   |                        |                        |
> |    acpi-cpufreq   |         3.022          |        2.969           |
> |                   |                        |                        |
> +-------------------+------------------------+------------------------+
> |                   |                        |                        |
> |     amd-pstate    |         3.131          |        3.284           |
> |                   |                        |                        |
> +-------------------+------------------------+------------------------+
> 
> 2) Gitsource CPU benchmark:
> 
> +---------------------------------------------------------------------+
> |                                                                     |
> |               Gitsource (Performance Per Watt)                      |
> |                                                    Higher is better |
> +-------------------+------------------------+------------------------+
> |                   |  Performance Per Watt  |  Performance Per Watt  |
> |   Kernel Module   |       (Schedutil)      |       (Ondemand)       |
> |                   |  Unit: 1 / (s * J)     |  Unit: 1 / (s * J)     |
> +-------------------+------------------------+------------------------+
> |                   |                        |                        |
> |    acpi-cpufreq   |     3.42172E-07        |     2.74508E-07        |
> |                   |                        |                        |
> +-------------------+------------------------+------------------------+
> |                   |                        |                        |
> |     amd-pstate    |     4.09141E-07        |     3.47610E-07        |
> |                   |                        |                        |
> +-------------------+------------------------+------------------------+
> 
> 3) Speedometer 2.0 CPU benchmark:
> 
> +---------------------------------------------------------------------+
> |                                                                     |
> |               Speedometer 2.0 (Performance Per Watt)                |
> |                                                    Higher is better |
> +-------------------+------------------------+------------------------+
> |                   |  Performance Per Watt  |  Performance Per Watt  |
> |   Kernel Module   |       (Schedutil)      |       (Ondemand)       |
> |                   |  Unit: 1 / (s * J)     |  Unit: 1 / (s * J)     |
> +-------------------+------------------------+------------------------+
> |                   |                        |                        |
> |    acpi-cpufreq   |      0.116111767       |      0.110321664       |
> |                   |                        |                        |
> +-------------------+------------------------+------------------------+
> |                   |                        |                        |
> |     amd-pstate    |      0.115825281       |      0.122024299       |
> |                   |                        |                        |
> +-------------------+------------------------+------------------------+
> 
> According to above average data, we can see this solution has shown better
> performance per watt scaling on mobile CPU benchmarks in most of cases.
> 
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
>  drivers/cpufreq/Kconfig.x86  |  17 ++
>  drivers/cpufreq/Makefile     |   1 +
>  drivers/cpufreq/amd-pstate.c | 413 +++++++++++++++++++++++++++++++++++
>  3 files changed, 431 insertions(+)
>  create mode 100644 drivers/cpufreq/amd-pstate.c
> 
> diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
> index 92701a18bdd9..2e798b2c0bdb 100644
> --- a/drivers/cpufreq/Kconfig.x86
> +++ b/drivers/cpufreq/Kconfig.x86
> @@ -34,6 +34,23 @@ config X86_PCC_CPUFREQ
>  
>  	  If in doubt, say N.
>  
> +config X86_AMD_PSTATE
> +	bool "AMD Processor P-State driver"
> +	depends on X86
> +	select ACPI_PROCESSOR if ACPI
> +	select ACPI_CPPC_LIB if X86_64 && ACPI && SCHED_MC_PRIO
> +	select CPU_FREQ_GOV_SCHEDUTIL if SMP
> +	help
> +	  This driver adds a CPUFreq driver which utilizes a fine grain
> +	  processor performance freqency control range instead of legacy

s/freqency/frequency/

> +	  performance levels. This driver supports the AMD processors with
> +	  _CPC object in the SBIOS.
> +
> +	  For details, take a look at:
> +	  <file:Documentation/admin-guide/pm/amd-pstate.rst>.
> +
> +	  If in doubt, say N.
> +
>  config X86_ACPI_CPUFREQ
>  	tristate "ACPI Processor P-States driver"
>  	depends on ACPI_PROCESSOR
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index 48ee5859030c..c8d307010922 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -25,6 +25,7 @@ obj-$(CONFIG_CPUFREQ_DT_PLATDEV)	+= cpufreq-dt-platdev.o
>  # speedstep-* is preferred over p4-clockmod.
>  
>  obj-$(CONFIG_X86_ACPI_CPUFREQ)		+= acpi-cpufreq.o
> +obj-$(CONFIG_X86_AMD_PSTATE)		+= amd-pstate.o
>  obj-$(CONFIG_X86_POWERNOW_K8)		+= powernow-k8.o
>  obj-$(CONFIG_X86_PCC_CPUFREQ)		+= pcc-cpufreq.o
>  obj-$(CONFIG_X86_POWERNOW_K6)		+= powernow-k6.o
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> new file mode 100644
> index 000000000000..a400861c7fdc
> --- /dev/null
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -0,0 +1,413 @@
> +/*
> + * amd-pstate.c - AMD Processor P-state Frequency Driver
> + *
> + * Copyright (C) 2021 Advanced Micro Devices, Inc. All Rights Reserved.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.

You should use a SPDX license identifier instead of copying the GPL text
in the file. See Documentation/process/license-rules.rst
 
> + *
> + * Author: Huang Rui <ray.huang@amd.com>
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/smp.h>
> +#include <linux/sched.h>
> +#include <linux/cpufreq.h>
> +#include <linux/compiler.h>
> +#include <linux/dmi.h>
> +#include <linux/slab.h>
> +#include <linux/acpi.h>
> +#include <linux/io.h>
> +#include <linux/delay.h>
> +#include <linux/uaccess.h>
> +#include <linux/static_call.h>
> +
> +#include <acpi/processor.h>
> +#include <acpi/cppc_acpi.h>
> +
> +#include <asm/msr.h>
> +#include <asm/processor.h>
> +#include <asm/cpufeature.h>
> +#include <asm/cpu_device_id.h>
> +
> +#define AMD_PSTATE_TRANSITION_LATENCY	0x20000
> +#define AMD_PSTATE_TRANSITION_DELAY	500
> +
> +static struct cpufreq_driver amd_pstate_driver;
> +
> +struct amd_cpudata {
> +	int	cpu;
> +
> +	struct freq_qos_request req[2];
> +
> +	u64	cppc_req_cached;
> +
> +	u32	highest_perf;
> +	u32	nominal_perf;
> +	u32	lowest_nonlinear_perf;
> +	u32	lowest_perf;
> +
> +	u32	max_freq;
> +	u32	min_freq;
> +	u32	nominal_freq;
> +	u32	lowest_nonlinear_freq;
> +};
> +
> +static inline int pstate_enable(bool enable)
> +{
> +	return wrmsrl_safe(MSR_AMD_CPPC_ENABLE, enable ? 1 : 0);
> +}
> +
> +DEFINE_STATIC_CALL(amd_pstate_enable, pstate_enable);
> +
> +static inline int amd_pstate_enable(bool enable)
> +{
> +	return static_call(amd_pstate_enable)(enable);
> +}
> +
> +static int pstate_init_perf(struct amd_cpudata *cpudata)
> +{
> +	u64 cap1;
> +
> +	int ret = rdmsrl_safe_on_cpu(cpudata->cpu, MSR_AMD_CPPC_CAP1,
> +				     &cap1);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * TODO: Introduce AMD specific power feature.
> +	 *
> +	 * CPPC entry doesn't indicate the highest performance in some ASICs.
> +	 */
> +	WRITE_ONCE(cpudata->highest_perf, amd_get_highest_perf());
> +
> +	WRITE_ONCE(cpudata->nominal_perf, CAP1_NOMINAL_PERF(cap1));
> +	WRITE_ONCE(cpudata->lowest_nonlinear_perf, CAP1_LOWNONLIN_PERF(cap1));
> +	WRITE_ONCE(cpudata->lowest_perf, CAP1_LOWEST_PERF(cap1));
> +
> +	return 0;
> +}
> +
> +DEFINE_STATIC_CALL(amd_pstate_init_perf, pstate_init_perf);
> +
> +static inline int amd_pstate_init_perf(struct amd_cpudata *cpudata)
> +{
> +	return static_call(amd_pstate_init_perf)(cpudata);
> +}
> +
> +static void pstate_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
> +			       u32 des_perf, u32 max_perf, bool fast_switch)
> +{
> +	if (fast_switch)
> +		wrmsrl(MSR_AMD_CPPC_REQ, READ_ONCE(cpudata->cppc_req_cached));
> +	else
> +		wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ,
> +			      READ_ONCE(cpudata->cppc_req_cached));
> +}
> +
> +DEFINE_STATIC_CALL(amd_pstate_update_perf, pstate_update_perf);
> +
> +static inline void amd_pstate_update_perf(struct amd_cpudata *cpudata,
> +					  u32 min_perf, u32 des_perf,
> +					  u32 max_perf, bool fast_switch)
> +{
> +	static_call(amd_pstate_update_perf)(cpudata, min_perf, des_perf,
> +					    max_perf, fast_switch);
> +}
> +
> +static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
> +			      u32 des_perf, u32 max_perf, bool fast_switch)
> +{
> +	u64 prev = READ_ONCE(cpudata->cppc_req_cached);
> +	u64 value = prev;
> +
> +	value &= ~REQ_MIN_PERF(~0L);
> +	value |= REQ_MIN_PERF(min_perf);
> +
> +	value &= ~REQ_DES_PERF(~0L);
> +	value |= REQ_DES_PERF(des_perf);
> +
> +	value &= ~REQ_MAX_PERF(~0L);
> +	value |= REQ_MAX_PERF(max_perf);
> +
> +	if (value == prev)
> +		return;
> +
> +	WRITE_ONCE(cpudata->cppc_req_cached, value);
> +
> +	amd_pstate_update_perf(cpudata, min_perf, des_perf,
> +			       max_perf, fast_switch);
> +}
> +
> +static int amd_pstate_verify(struct cpufreq_policy_data *policy)
> +{
> +	cpufreq_verify_within_cpu_limits(policy);
> +
> +	return 0;
> +}
> +
> +static int amd_pstate_target(struct cpufreq_policy *policy,
> +			     unsigned int target_freq,
> +			     unsigned int relation)
> +{
> +	struct cpufreq_freqs freqs;
> +	struct amd_cpudata *cpudata = policy->driver_data;
> +	unsigned long amd_max_perf, amd_min_perf, amd_des_perf,
> +		      amd_cap_perf;

Is there a need to preface each of the variables with amd_? This is
not something you do in any of the other routines.

> +
> +	if (!cpudata->max_freq)
> +		return -ENODEV;
> +
> +	amd_cap_perf = READ_ONCE(cpudata->highest_perf);
> +	amd_min_perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
> +	amd_max_perf = amd_cap_perf;
> +
> +	freqs.old = policy->cur;
> +	freqs.new = target_freq;
> +
> +	amd_des_perf = DIV_ROUND_CLOSEST(target_freq * amd_cap_perf,
> +					 cpudata->max_freq);
> +
> +	cpufreq_freq_transition_begin(policy, &freqs);
> +	amd_pstate_update(cpudata, amd_min_perf, amd_des_perf,
> +			  amd_max_perf, false);
> +	cpufreq_freq_transition_end(policy, &freqs, false);
> +
> +	return 0;
> +}
> +
> +static int amd_get_min_freq(struct amd_cpudata *cpudata)
> +{
> +	struct cppc_perf_caps cppc_perf;
> +
> +	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
> +	if (ret)
> +		return ret;
> +
> +	/* Switch to khz */
> +	return cppc_perf.lowest_freq * 1000;
> +}
> +
> +static int amd_get_max_freq(struct amd_cpudata *cpudata)
> +{
> +	struct cppc_perf_caps cppc_perf;
> +	u32 max_perf, max_freq, nominal_freq, nominal_perf;
> +	u64 boost_ratio;
> +
> +	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
> +	if (ret)
> +		return ret;
> +
> +	nominal_freq = cppc_perf.nominal_freq;
> +	nominal_perf = READ_ONCE(cpudata->nominal_perf);
> +	max_perf = READ_ONCE(cpudata->highest_perf);
> +
> +	boost_ratio = div_u64(max_perf << SCHED_CAPACITY_SHIFT,
> +			      nominal_perf);
> +
> +	max_freq = nominal_freq * boost_ratio >> SCHED_CAPACITY_SHIFT;
> +
> +	/* Switch to khz */
> +	return max_freq * 1000;
> +}
> +
> +static int amd_get_nominal_freq(struct amd_cpudata *cpudata)
> +{
> +	struct cppc_perf_caps cppc_perf;
> +	u32 nominal_freq;
> +
> +	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
> +	if (ret)
> +		return ret;
> +
> +	nominal_freq = cppc_perf.nominal_freq;
> +
> +	/* Switch to khz */
> +	return nominal_freq * 1000;

You could just do
	return cppc_perf.nominal_freq * 1000;

> +}
> +
> +static int amd_get_lowest_nonlinear_freq(struct amd_cpudata *cpudata)
> +{
> +	struct cppc_perf_caps cppc_perf;
> +	u32 lowest_nonlinear_freq, lowest_nonlinear_perf,
> +	    nominal_freq, nominal_perf;
> +	u64 lowest_nonlinear_ratio;
> +
> +	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
> +	if (ret)
> +		return ret;
> +
> +	nominal_freq = cppc_perf.nominal_freq;
> +	nominal_perf = READ_ONCE(cpudata->nominal_perf);
> +
> +	lowest_nonlinear_perf = cppc_perf.lowest_nonlinear_perf;
> +
> +	lowest_nonlinear_ratio = div_u64(lowest_nonlinear_perf <<
> +					 SCHED_CAPACITY_SHIFT, nominal_perf);

Please put the two args to the shift operation should be on the same line.

> +
> +	lowest_nonlinear_freq = nominal_freq * lowest_nonlinear_ratio >> SCHED_CAPACITY_SHIFT;
> +
> +	/* Switch to khz */
> +	return lowest_nonlinear_freq * 1000;
> +}
> +
> +static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
> +{
> +	int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
> +	unsigned int cpu = policy->cpu;
> +	struct device *dev;
> +	struct amd_cpudata *cpudata;
> +
> +	dev = get_cpu_device(policy->cpu);
> +	if (!dev)
> +		return -ENODEV;
> +
> +	cpudata = kzalloc(sizeof(*cpudata), GFP_KERNEL);
> +	if (!cpudata)
> +		return -ENOMEM;
> +
> +	cpudata->cpu = cpu;

You could do the following and get rid of the cpu variable, it's only used here.

	cpudata->cpu = policy->cpu;

> +
> +	ret = amd_pstate_init_perf(cpudata);
> +	if (ret)
> +		goto free_cpudata1;
> +
> +	min_freq = amd_get_min_freq(cpudata);
> +	max_freq = amd_get_max_freq(cpudata);
> +	nominal_freq = amd_get_nominal_freq(cpudata);
> +	lowest_nonlinear_freq = amd_get_lowest_nonlinear_freq(cpudata);
> +
> +	if (min_freq < 0 || max_freq < 0 || min_freq > max_freq) {
> +		dev_err(dev, "min_freq(%d) or max_freq(%d) value is incorrect\n",
> +			min_freq, max_freq);
> +		ret = -EINVAL;
> +		goto free_cpudata1;
> +	}
> +
> +	policy->cpuinfo.transition_latency = AMD_PSTATE_TRANSITION_LATENCY;
> +	policy->transition_delay_us = AMD_PSTATE_TRANSITION_DELAY;
> +
> +	policy->min = min_freq;
> +	policy->max = max_freq;
> +
> +	policy->cpuinfo.min_freq = min_freq;
> +	policy->cpuinfo.max_freq = max_freq;
> +
> +	/* It will be updated by governor */
> +	policy->cur = policy->cpuinfo.min_freq;
> +
> +	ret = freq_qos_add_request(&policy->constraints, &cpudata->req[0],
> +				   FREQ_QOS_MIN, policy->cpuinfo.min_freq);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to add min-freq constraint (%d)\n", ret);
> +		goto free_cpudata1;
> +	}
> +
> +	ret = freq_qos_add_request(&policy->constraints, &cpudata->req[1],
> +				   FREQ_QOS_MAX, policy->cpuinfo.max_freq);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to add max-freq constraint (%d)\n", ret);
> +		goto free_cpudata2;
> +	}
> +
> +	/* Initial processor data capability frequencies */
> +	cpudata->max_freq = max_freq;
> +	cpudata->min_freq = min_freq;
> +	cpudata->nominal_freq = nominal_freq;
> +	cpudata->lowest_nonlinear_freq = lowest_nonlinear_freq;
> +
> +	policy->driver_data = cpudata;
> +
> +	return 0;
> +
> +	freq_qos_remove_request(&cpudata->req[1]);

Is this line of code reachable?

Perhaps this was meant as cleanup if a freq_qos_add_request() call failed but
it shouldn't be needed with the current code flow.

> +free_cpudata2:
> +	freq_qos_remove_request(&cpudata->req[0]);
> +free_cpudata1:
> +	kfree(cpudata);
> +	return ret;
> +}
> +
> +static int amd_pstate_cpu_exit(struct cpufreq_policy *policy)
> +{
> +	struct amd_cpudata *cpudata;
> +
> +	cpudata = policy->driver_data;
> +
> +	freq_qos_remove_request(&cpudata->req[1]);
> +	freq_qos_remove_request(&cpudata->req[0]);
> +	kfree(cpudata);
> +
> +	return 0;
> +}
> +
> +static struct cpufreq_driver amd_pstate_driver = {
> +	.flags		= CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
> +	.verify		= amd_pstate_verify,
> +	.target		= amd_pstate_target,
> +	.init		= amd_pstate_cpu_init,
> +	.exit		= amd_pstate_cpu_exit,
> +	.name		= "amd-pstate",
> +};
> +
> +static int __init amd_pstate_init(void)
> +{
> +	int ret;
> +
> +	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
> +		return -ENODEV;
> +
> +	if (!acpi_cpc_valid()) {
> +		pr_debug("%s, the _CPC object is not present in SBIOS\n",
> +			 __func__);

Do we need to print the function name here (and below)?

> +		return -ENODEV;
> +	}
> +
> +	/* don't keep reloading if cpufreq_driver exists */
> +	if (cpufreq_get_current_driver())
> +		return -EEXIST;
> +
> +	/* capability check */
> +	if (!boot_cpu_has(X86_FEATURE_AMD_CPPC)) {
> +		pr_debug("%s, AMD CPPC MSR based functionality is not supported\n",
> +			 __func__);> +		return -ENODEV;
> +	}
> +
> +	/* enable amd pstate feature */
> +	ret = amd_pstate_enable(true);
> +	if (ret) {
> +		pr_err("%s, failed to enable amd-pstate with return %d\n",
> +		       __func__, ret);
> +		return ret;
> +	}
> +
> +	ret = cpufreq_register_driver(&amd_pstate_driver);
> +	if (ret) {
> +		pr_err("%s, return %d\n", __func__, ret);
> +		return ret;

No need to do a return ret here...

> +	}
> +
> +	return 0;

...just do a return ret here.

-Nathan

> +}
> +
> +device_initcall(amd_pstate_init);
> +
> +MODULE_AUTHOR("Huang Rui <ray.huang@amd.com>");
> +MODULE_DESCRIPTION("AMD Processor P-state Frequency Driver");
> +MODULE_LICENSE("GPL");
> 
