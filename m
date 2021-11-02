Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E635B44360E
	for <lists+linux-pm@lfdr.de>; Tue,  2 Nov 2021 19:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhKBSz2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Nov 2021 14:55:28 -0400
Received: from mail-bn7nam10on2068.outbound.protection.outlook.com ([40.107.92.68]:18401
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229530AbhKBSz2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 2 Nov 2021 14:55:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JfV2E/OZK+LTxLkS4QZheZj9D1cyMkrnzKGa93hb+1WIiij80ZtE5B1t2J0s+wjEjCXPRANOqGxfwjymSeHMN86NoyFwEr6x5yxvEMtSia4k6G1ytAHtxnNBRfD3oyw45RxZUoF5+0XtNWOpixynlU08aUPf5D9S0tEdCa4fB4mO0AOt/426W6aNmlLvUAdTbBdWUU9A0QfWOomYs6AeU5jc9ylEgYFpCL7qZdDoRzyiEwx60CtqZ3bNxTQ/Myb4YI1NO6aEUFGi8aTTWfWp+y0M80O00Rd+Xzm9JcqMbIsGgA+28DWfYnAWY4uEjosGK+u4UxWTUkSeekDNXVHM9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9LUdM4j1j6VrJAEZvw3LUHFgtSm1ofRxqB7yHv/Dkkg=;
 b=E62JEgDCWcyeNGRjoTk4E2WP+kXaS7YTLyWGot/XRwXPg8UxcaziuSR7EWAk537Vb+hCMfYVr5P+zzsRZS+4vVW+px0yeaWjEPTGDSo/5oDmMtOCp33RkFImzyBuUlGnwt1+zQth1jve0dLAsqorxxTyfxYAXBshi4AWrWp39N1BAceWZ7B/ueFYn1bu+ZDUznwsIBX1EzO95uIcPD2FlyeImpg9fzg4JsVxdE4QRYMbYWW/2s0QmN5vNFVI/uKnR0rEE1yN4nYkBwdyWLdx+eVA+SHyftWs7cfPCMyab8PTDob3Xh0GA69qvwdR9c11IopW37/YuGyxoaF7Xc/1bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9LUdM4j1j6VrJAEZvw3LUHFgtSm1ofRxqB7yHv/Dkkg=;
 b=Np9XsAX9lCkriTZH6qVgRCXVnMc7Tt79W+OUQXsv9H4Ah9/S32zhQlnscQGKecBglPDj7tRwANZOMhnOIm5rGVFRIZm88ssNihzxMtGIKNuc/SF+HTrdehEhM7M+UMUGYf0J6CPQAXUF6KBYZjZlA8zGES1dykVcCoKQr2lRyV0=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8)
 by SN6PR12MB2782.namprd12.prod.outlook.com (2603:10b6:805:73::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Tue, 2 Nov
 2021 18:52:49 +0000
Received: from SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::7cbc:2454:74b9:f4ea]) by SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::7cbc:2454:74b9:f4ea%6]) with mapi id 15.20.4649.019; Tue, 2 Nov 2021
 18:52:49 +0000
Message-ID: <a975268f-ed3a-f100-5bf6-cce74b6df63f@amd.com>
Date:   Tue, 2 Nov 2021 13:52:44 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v3 06/21] cpufreq: amd: introduce a new amd pstate driver
 to support future processors
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
 <20211029130241.1984459-7-ray.huang@amd.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20211029130241.1984459-7-ray.huang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR1501CA0023.namprd15.prod.outlook.com
 (2603:10b6:207:17::36) To SA0PR12MB4510.namprd12.prod.outlook.com
 (2603:10b6:806:94::8)
MIME-Version: 1.0
Received: from [10.254.54.68] (165.204.77.11) by BL0PR1501CA0023.namprd15.prod.outlook.com (2603:10b6:207:17::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend Transport; Tue, 2 Nov 2021 18:52:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b2ecd2a-11b3-40de-c165-08d99e31f75a
X-MS-TrafficTypeDiagnostic: SN6PR12MB2782:
X-Microsoft-Antispam-PRVS: <SN6PR12MB2782A7A81FE3C03D46B764D2E28B9@SN6PR12MB2782.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cyLXNiH1CZ7pfWcFRkvZ4DZasHk59WwjVdFPHUmoKQ1xgAu+MursQll8ITgD1ObO9gGOEgspZAQ9aExUuV416m+1ySrgzavtiNvEU2HsX6LclZbZVWIbsfIliPywbSFJkn9E4CaszbyolnPTDiGkTewlyNUEJYiHLMV6guSuDeTYh0XZj0/Kn7Edd0Al5XrXLJkreiytUuZl4KDp3/i6bQah+PokYNlgNsKvkHwS1M7N3G7uxWumLyccLXM5sqvm+qBkm+Pux8DngLeUkB1P2Mu0Wi/xArViuUZwHpSBwieQSdSn1UYDo3sGJgQC6dD/ZwAfeZoftdeiIqk1r6QOfFugg9nLeCjOgnupbka4KOW/L8QlThFnmk+Ow/BF24p0HW++n1rJ8I7XcApyti+tsYFpnGk9CxEsPqVX8w5hLJvd9CDxGTfAFxoZG9vhuNYeEWo18Tp8e9ZERwNUrIUhcxpkUxq+aRGICdWrW7OK1AVcfVJZrJoz01UgLj+NlpOFQemiR73IIFEUST6QUt6jMyzTvLJ0ZjtvpJtZeTTURuIj/M2JcpQgu+JxUSd6Hj7Z0dySQx5k80klV8Bp293jgtMfs8PLowI0EgDPh+bWty5lKPAdh5hGaJy1CJGjNR68AG6XwcnxlJXo20mJfS9ZLFSZuH2Fg1B+YdRAtO77grHHkeiSWL/XkHBKC9KG/HPw+bWeJkhvd/PhozYxs0X39P6GFYjUXQMFvlEvdfto9g5dsh1vBd9wTSuAxYDpmUrUOXRj/P3oM2clmxG/aTs4M6GG/Ju6246YrVQ+11jvPlJuwbVIsmeYiJ76N6pEOdMECfzT1KndU1rvk3htMHuE+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4510.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(966005)(2906002)(5660300002)(66556008)(86362001)(66476007)(8676002)(30864003)(6486002)(31686004)(4326008)(8936002)(36756003)(66946007)(7416002)(53546011)(31696002)(508600001)(54906003)(2616005)(956004)(38100700002)(316002)(110136005)(16576012)(83380400001)(6666004)(186003)(26005)(2004002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3pyTC9CWFFxN2lsMmc4ZGhJeVI0di9IeUc4VVFFWEl4UG83eWJWV3JFNFNP?=
 =?utf-8?B?WjVXSnd2UjdtNVNXazBFemQ4NlQza3BWanc3eXFuSmplbG83em1CQnhlY3FR?=
 =?utf-8?B?d1A2UmdxT3lUMXdLN3pjMndqL2NIQS9uemF3OFpERG56SDNyUEFyQm82L3E0?=
 =?utf-8?B?QmQ1a0NUSEJzTks2VlRESzJYQy9JM01IY0ZuRlJ3RUo2dE5NSEJKellUUG5x?=
 =?utf-8?B?RUdzaE5pWVd4aXlvVTVPdTYrNlFyaGphc1dFZUhsRWxpK3liZCsrcGQ3dExZ?=
 =?utf-8?B?azBSYStveFY3Ry9LVVhiM1lMSDFwSU52MkdjSWhMU1E0SlRuR1BveDcyckk5?=
 =?utf-8?B?aTBxRmhpZGhZcEF1bXVVMUJQQmExckxzeS8xc2FpbXlBcGY0T2tub2Uzb3E1?=
 =?utf-8?B?R0VWd0lqaEVDdGx4cTM5ZGhHNFQxL1lZb3BCYWhadmptQ2pHT0JxSis3TzRj?=
 =?utf-8?B?QS90T1BGOG5qL1p3TkxsRmN2eUJOUm9IODc5N2pvTW1QTEQ3eGhSWk5JSkxD?=
 =?utf-8?B?YytCT2EvUk5wc2F0Q09wb3JSeVVpMkJFNjRFV1k2dlUwZGFXNzJLaGtrNE54?=
 =?utf-8?B?emhqVGR4aHRCY25tRXAvc1VCMHNqR1dPSVE4U2lEbE5KZ2lJRGtuelc2VmM3?=
 =?utf-8?B?Y25jdUVYZVNmdjhsSkE4bFlWU1pLcmlJYmwvYSt5YmhVWTg5VXYrTmw3Mm9t?=
 =?utf-8?B?N0JXVzdubC9HSWRYb3BNRTBYWUkvMXlFdWp6bFRKSWsvcUFMclF0eUk3VlNW?=
 =?utf-8?B?bU5JU3NySVRlWHpPVjhjRmVZWWNpQkt6QXAvL21BR0VhZXIyL2FCYXVSRUU1?=
 =?utf-8?B?QlNsSXEzTXM2NHFZSGJmOTNMZDRiTjYrRTUyZ1hlYWJicWZ2Tk93V083NVNN?=
 =?utf-8?B?Y29aU3RNM25hZnBzbC9pLzhId0hwVm05WDl0ZGZmaGZWN2RxRGtma0tOaEYv?=
 =?utf-8?B?QTdMN0liYWNlTFMrcDkrQ1B3SFlXVWUvNVE5NjhHOENOdGdwVjRBbkNPT2pp?=
 =?utf-8?B?SUNJNndISE1nMFFaNHFiNDZMRzVFSVd6c1BVUjArcGwvZW94eWR6R3Z2eFk2?=
 =?utf-8?B?NWVmc3B1VnovWE96bE9vbXJXYmFLeEpyU2FtSS9aQ3NTc1I5NFNKYitBY0VH?=
 =?utf-8?B?T1hTRWJnY0dpYXhqb0hGSllOV050djJxeThSUkdXcDQwOEM5RXVmZ1BreG1I?=
 =?utf-8?B?MnRnUGQ4ZmhhbVlmMDNyMUkzL0d0dmNhWVJFbWk1Vnpid2p5Skk4QnJLVkVK?=
 =?utf-8?B?NGE5L2JuTE9DZlR3ZThqNlJuOHVqTEFuV3FKNSt4OUd6VTYwbHBicTYzb3Jq?=
 =?utf-8?B?NnNmQXBKd0ZmMUpsd2RsTCs4S24xV0Mrdmd1ZDJjUFlqVzZTM0FQMWRXTmVh?=
 =?utf-8?B?NGQyRGdhT3hGcUhiVHF6dm1SR2g1emJiWVZsN1FWeFFtckhpTmJRSVQrRVp2?=
 =?utf-8?B?WE9GZ0FzQTFvMFhsdkpZMmxHZGxJN0VvUGJDLytwd0JSaTJ2eWQwaFE5NmxC?=
 =?utf-8?B?TTFWUng3L2U5VHFiOXlEdks2c2tlQVhRU3RqYXFwYU9MUjdWdXRCYXVJNnRk?=
 =?utf-8?B?NG1LZ1Bvb1lTSHZkcngvN1pjZG96bnJoYlBVaHRqMHdqakZBaW95WVRKLytO?=
 =?utf-8?B?eklrVGZMM1BmVnNPYjM3KzROZzVMZmR6U1VObDMyM3czK3kzMTR0SHp4ZzBB?=
 =?utf-8?B?NXJ3YWcyckZYMU9rNXdkR1YycEx4VUtielFVcXdEQTh6SWNCQy9JY0IzdEhW?=
 =?utf-8?B?UktVNWNoYXBnMmFHdFpDTjJNVnRUYnFnVjFqN3hUa3VkVUh0UytlSURVcWJ0?=
 =?utf-8?B?ckE4QjQ1Q3QwRHZVYXFqT1UyT05VK1VtM2lUOGVvRWc3VlZOYzlVbjA4ZE5t?=
 =?utf-8?B?UzVOcWxWZWRjTGdQZ2kvdVJXOTdCY0pSN2Jtcy9RRFF4Z3VMTWtocjhsbWRk?=
 =?utf-8?B?NlB6ZTdBQ3JMdGRaN2pjdHhoOXEzUnlpUklUTWlHWVFkejROQzcyUnhyV1RT?=
 =?utf-8?B?MjBoQ1Q2dG5HemFQK0hMTzZ6dzljQUdseW9CYk56S0hhL21iaG1wbk8xZU5k?=
 =?utf-8?B?S3BQT3huMnhtTTlKMXhhVWNYdWcxdHIvYzIxOTAxTkFhNHVIV0pmTWZzZnlL?=
 =?utf-8?B?c1p5RUIxQ00vV3drY1ZUbFlsN3dsT1NDOVlvR1RuMWpPRGNMdHVybnJsU0Ft?=
 =?utf-8?Q?/pt4D5qE7cv9ySiiP13EgiY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b2ecd2a-11b3-40de-c165-08d99e31f75a
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4510.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2021 18:52:49.2013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OEXgeS50cEL/3TCqBGwNWwMJ7cnFf2ougqKrnYkhBiMOGUTXN8G7uz55JAVjPage48BpATExcvALNOKzEKplTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2782
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/29/2021 08:02, Huang Rui wrote:
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
> "E" is energy measured in joules.
> 
> We use the RAPL interface with "perf" tool to get the energy data of the
> package power.
> 
> The data comparsions between amd-pstate and acpi-freq module are tested on
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
>   drivers/cpufreq/Kconfig.x86  |  17 ++
>   drivers/cpufreq/Makefile     |   1 +
>   drivers/cpufreq/amd-pstate.c | 413 +++++++++++++++++++++++++++++++++++
>   3 files changed, 431 insertions(+)
>   create mode 100644 drivers/cpufreq/amd-pstate.c
> 
> diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
> index 92701a18bdd9..2e798b2c0bdb 100644
> --- a/drivers/cpufreq/Kconfig.x86
> +++ b/drivers/cpufreq/Kconfig.x86
> @@ -34,6 +34,23 @@ config X86_PCC_CPUFREQ
>   
>   	  If in doubt, say N.
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
> +	  performance levels. This driver supports the AMD processors with
> +	  _CPC object in the SBIOS.
> +
> +	  For details, take a look at:
> +	  <file:Documentation/admin-guide/pm/amd-pstate.rst>.
> +
> +	  If in doubt, say N.
> +
>   config X86_ACPI_CPUFREQ
>   	tristate "ACPI Processor P-States driver"
>   	depends on ACPI_PROCESSOR
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index 48ee5859030c..c8d307010922 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -25,6 +25,7 @@ obj-$(CONFIG_CPUFREQ_DT_PLATDEV)	+= cpufreq-dt-platdev.o
>   # speedstep-* is preferred over p4-clockmod.
>   
>   obj-$(CONFIG_X86_ACPI_CPUFREQ)		+= acpi-cpufreq.o
> +obj-$(CONFIG_X86_AMD_PSTATE)		+= amd-pstate.o
>   obj-$(CONFIG_X86_POWERNOW_K8)		+= powernow-k8.o
>   obj-$(CONFIG_X86_PCC_CPUFREQ)		+= pcc-cpufreq.o
>   obj-$(CONFIG_X86_POWERNOW_K6)		+= powernow-k6.o
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

Wouldn't it be better to default to CAP1_HIGHEST_PERF(cap1) and quirk 
the ones that don't work instead?

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
> +			 __func__);
> +		return -ENODEV;
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
> +	}
> +
> +	return 0;
> +}
> +
> +device_initcall(amd_pstate_init);
> +
> +MODULE_AUTHOR("Huang Rui <ray.huang@amd.com>");
> +MODULE_DESCRIPTION("AMD Processor P-state Frequency Driver");
> +MODULE_LICENSE("GPL");
> 

