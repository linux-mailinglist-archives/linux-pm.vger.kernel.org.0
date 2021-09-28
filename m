Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1134941B880
	for <lists+linux-pm@lfdr.de>; Tue, 28 Sep 2021 22:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242016AbhI1UmV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Sep 2021 16:42:21 -0400
Received: from mail-bn7nam10on2053.outbound.protection.outlook.com ([40.107.92.53]:30848
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242789AbhI1UmU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 28 Sep 2021 16:42:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gWSx2Ce6YBBoVTe2LNNYH7pDfojVSEBaT/k4wrPriNXxOfShmWxP94PxIxJEDZuSAHWa1n+BNK1sr/vORoMJeT7FvMKmPRrK7wdmdT4bZyVdptF1kTc3YTs4zRHzB7VKmdVyTk1bEo6KI7ChSKfbnm6easV/yj3wxFo3APEmhgjztn0bn1E3/AEhs6apufjF3vyQzYleMhH2ePbAEhvfaoQKltgRd08A3BBpd50fJ2mfdBWSA8a0kGOBdqHOazWq3BLHdavUCzFWNpZvtuNQpZqGQe4dMeo6Tb/UtaUKjqN5yv8t9a8CeXn0p6COXsmqpjNndBeyNrBxKa+6dZYuEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ufokD54mMvn+/2QmlbbWWDPgSgcMsyhJZCTzg01QtAw=;
 b=iVvi0bKg7MBDtHPJeVMkuOZBTz2dbrsVFepJuLQVyBJkqc69e24iFwywvymDACTPhE86edzOTjrbjK+LUReBmRKGcg17K57cxXUOxLy04Y4huco+E1EtPL+WG7xRoA4qAWEB6FtH6WmVyBfMf6wfWzlFmYtDc42jYqUGVs6I/PEj6ptlpjRwm5e4VT0No5TKN3L547DsWQ19BGsgiu/EaSUUcAa4Zs+dXCYqjySY0wqHtw7gT/dXPklbkDF7KU/OzKr2lU2b1VTR+3TZT9jVObhpM7pYNCabzuAzrYzmECCQtjJ9+eXpX3cSxymgevumYwoazjlN+FtSsVW7UcSUIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ufokD54mMvn+/2QmlbbWWDPgSgcMsyhJZCTzg01QtAw=;
 b=5OPLKAGNo4biJa+xaH47abJH5xHeA5AXTJj6O9w/PP6ncMrpEQRv/26JfR6+PXAtTPrHj23O+ujFUfmF4sVIMk7hMKVBDKnbiYLSkJNf5VjeEjOFYgGvySLfAm9pZWPNSqJiLQ3WWgqXLSzAhSSnSw4GeoA4O0xwRlUEjt1Jgr8=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4720.namprd12.prod.outlook.com (2603:10b6:805:e6::31)
 by SA0PR12MB4447.namprd12.prod.outlook.com (2603:10b6:806:9b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Tue, 28 Sep
 2021 20:40:38 +0000
Received: from SN6PR12MB4720.namprd12.prod.outlook.com
 ([fe80::e134:658f:3a82:f750]) by SN6PR12MB4720.namprd12.prod.outlook.com
 ([fe80::e134:658f:3a82:f750%4]) with mapi id 15.20.4544.021; Tue, 28 Sep 2021
 20:40:38 +0000
Subject: Re: [PATCH v2 05/21] cpufreq: amd: introduce a new amd pstate driver
 to support future processors
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
 <20210926090605.3556134-6-ray.huang@amd.com>
From:   "Fontenot, Nathan" <Nathan.Fontenot@amd.com>
Message-ID: <5b467a49-c65e-50ee-5e78-755578250647@amd.com>
Date:   Tue, 28 Sep 2021 15:40:35 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20210926090605.3556134-6-ray.huang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0114.namprd05.prod.outlook.com
 (2603:10b6:803:42::31) To SN6PR12MB4720.namprd12.prod.outlook.com
 (2603:10b6:805:e6::31)
MIME-Version: 1.0
Received: from [172.31.10.217] (165.204.77.11) by SN4PR0501CA0114.namprd05.prod.outlook.com (2603:10b6:803:42::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.7 via Frontend Transport; Tue, 28 Sep 2021 20:40:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 485eef1c-989d-4108-1d08-08d982c03a7c
X-MS-TrafficTypeDiagnostic: SA0PR12MB4447:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4447CD57DACDFF68BE8F27D2ECA89@SA0PR12MB4447.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:510;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: twbQzRUELJmERHTqjJTg8417Vw7iLpRc6ad0+eoHrSbmkDp6beuIfndQtyGuNpTatCh/2Mx9gLtrx9Jnl+89aRX09xK2EIOfo4oM8i0m7JQffQ5JoAqJFBzEJk65A047PpdncMOYiR9rmkJaqtphEa3rXj046UuPUGm8O2flVxzWffZVAqvDMTzssWMYBzJ8W1mnrNfB0AhZAXlUJ22L8hi3rEWHZ9EYYoQuRkuUC1hNUxosk+gcHFLyB7iRrsPL9OjwDO/es1vq3RaoymglTZF86tAtw56TIu6VoUCO4oFy709ZOcn9gs1iXDxu4VR1RwpxmDkwi9PZuq0G8brxcmOjapRbuX/pA5giZj1VZ6XXRWShj7Ucp7h4c5U1s04JCqagJi42X0jtpNtT+A+u08WLMqNqY0/OfNpg6keFSbRdsScHF4lry0G12u9jmwXNUrlQZ+tq9MQnzXG04Z/p7Sy2OQFmKucCfUEode9v2Zwxf91Mx+ZLFHSSnfihjn8iB69v5vZDZ92g9V+JQtWmIfq05+rGzahavmaO1kG9OB26407j38AcpmqTUxFnVQ4E/j7l/cseIvGCfXTqi1UTO5VJjFHaR+zZ8PjKEHuKDSD0xmT1N1sf/gd3VAS4V41HrMqtDmXsRqdoa00meR3FrVYT8uNMBq+HqFvGKM3OrmXPlEcPtREUmN097dyYXMVOADSKyUdZJJswmOWVGixc1MaVmPfkegNtqfMA9L3pf9Wj/jgWVsg29HhVEgbFDxS09eDc28cT+5c4Dt+VgElQpCJPN3HPlj5MGVTD7CuSgnvnhe6MSSNy+lmZWpZb2YALrQZLSNbRiemZnaebvj6bfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4720.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(84040400005)(4326008)(2616005)(6486002)(5660300002)(36756003)(2906002)(30864003)(8676002)(8936002)(66556008)(66946007)(66476007)(316002)(16576012)(956004)(26005)(53546011)(110136005)(54906003)(508600001)(86362001)(83380400001)(186003)(31696002)(31686004)(38100700002)(966005)(2004002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1REbDFmbUpWQkt6dWtzTDlvQXRiNXdoY1F0VGNGMHRXWG13M3FCVGpQLzlG?=
 =?utf-8?B?Q3R6K0RtUjV6ZktHa3ZYd3VYRkhmL21NUXJyZEpQRkFqbjNXSW5jc3ZWT2lB?=
 =?utf-8?B?bVhRTkpRSnVJRnhPYmF0SEQzeFFEa3RLTU5lRGtpU0FDR0hvK2E3WFZ6ZVFH?=
 =?utf-8?B?M3hpYUE2em4rSGlxNzc1ekdFTEszN295a3BTeGtZd3JNUkEzUXgwODEyOWo4?=
 =?utf-8?B?MmZ5NDNTY2I1NklwVCtlcTh3NkJudzloaGg2RVNrWENaRTZRMHVPdkxMQi9X?=
 =?utf-8?B?VlBVYTRvcjQ4TGU5Z05oWlcvVWdUM2ZkR2d3QWgwNTUvQVNnVTlnb0NHd0JT?=
 =?utf-8?B?cEhNNHVja2F4RjloWDJiNFd1YWZNTEdZOTU4aWhvbVJkNzNBYVdEYUtRdmZP?=
 =?utf-8?B?S2FWZWI5VDJJSWZHUzBSTERaQ2pzMEVQM0FrNXdkS05XVlQyYTUzanlSSnV0?=
 =?utf-8?B?aVBrMlBUK1NCamhXUnFLVm81V05mZWphOEg1eVN1RENhRTNrV255c0paRkJO?=
 =?utf-8?B?RjJZZkFlWmJvdERyUE9kQ09nbWVBcDdZaS9GcXdibk82WmhQdU9aekxIZndG?=
 =?utf-8?B?bUxVdVNUQjVaK1g0ZGJuRDZJZ0VBOTMwL2grU1ZCSUpqVlU1RFBqanZsc2ow?=
 =?utf-8?B?ZkxyeUYrNWlnalpiMU9RaVM0dXlzK1ZuclFZSHU2NjA0Q1h5a2ovQWhna1lp?=
 =?utf-8?B?RGs3UUx1UzZHU3RqN0t3am1SM1hrazVyWVE2U0grYkJJWHRTNEM0SWNmTU5y?=
 =?utf-8?B?c3NyZXFxbG5YTGdFWXNxeElTbEt2UXFHejZ1TjRXQzM0aTQ3Qjd3d1lDSWRs?=
 =?utf-8?B?dlEwNjdya2I2aGdSc1BnSTBrUDRiSzN0cWFzam5ObFk4VHk5ZmxYdVlWa1Y1?=
 =?utf-8?B?MmhLTW9zazRYcmRpTnUvY2FPazFKRTBwTG5NNHQ2VzNZWURPOWVtbFl5WHZJ?=
 =?utf-8?B?MDMvSHd4RmRNekFIalZQN1BmRlpNdHhlR0dQaEJsWUtvdW5ySSt4YWlpeDRK?=
 =?utf-8?B?MjlMeERLVDZmWUFNbGhac0ZiRjB4ZEFmTHpGR2hoWmF2L2w3eUVVSTN2MUVP?=
 =?utf-8?B?SHdkMXJUTkNLSmV4Z0RPREFWWEI3NEZ4QkdVaGNBTE5OV3o3WFpGQ0VrUHFY?=
 =?utf-8?B?QzNndzVjVVp3SENncThkdzJhZXBhRk1nRTVLZ09Xb1plVkx0aS9SRDB0VVhu?=
 =?utf-8?B?ZE5hbzJyb3Njc3Z4aU5lZUY3Ti96cmRva3hzYjVwSW9Ka2VtVCtubVRBZVZM?=
 =?utf-8?B?eHhseGFGUWlWTThQUUg3ZjhLSTJTKys5VzlKRWd3Q3dwT0J5Q080MXk3czBD?=
 =?utf-8?B?U2tteDdiaHgyRDJkV2Y0MUhkSGdjQVRYQXkrOGEzRlIvb1Y3QjgzVlRkUDRz?=
 =?utf-8?B?U0JFNjFaS1ViOWRWZmI5ZGtyVW9IbDVlNnJJSHUxOFVwOXNqUHJoMVZ6ZHVP?=
 =?utf-8?B?SUN1QlVmVk1XZ0JPdWRBeXRQdDhDZGNWRWJoUkdLYmRrbkUyNExsTzNVOWpt?=
 =?utf-8?B?VFVOeFN0TlN3endaSEFNL3Zjb2kvdFdHUkluTXM0dXZEbytjVHVCaVVTVjF5?=
 =?utf-8?B?L2Q5cXZpRHUzYlFsL3JoaWhTWk9BWG5vZlUzUlZBeW9GdE1qK0xZV2NYRmFD?=
 =?utf-8?B?L2pZSjExRVo3Y1B3bTllWTVaOTJYSEJ0bXRLYTBIbjNQaWJZbE9ybXkram4x?=
 =?utf-8?B?TDZCdEgrT2VrekxOeDhFU093T1hVL2ovaWx4WDZDUmRhQzBzeithRHpTUTZK?=
 =?utf-8?Q?Bza2czqnZywXwtxWm7rOdFwJyLNj/CRPSMEqZQQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 485eef1c-989d-4108-1d08-08d982c03a7c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4720.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 20:40:37.8368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cRi4jzKEebm5gyjSqBSF+rSPu26RhW1IHeqFFh7dIG49TPjs+uBw3hmoG/uQ/KlccIyKF4xK6uYBsxyzo9STVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4447
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 9/26/2021 4:05 AM, Huang Rui wrote:
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
>  drivers/cpufreq/Kconfig.x86  |  13 +
>  drivers/cpufreq/Makefile     |   1 +
>  drivers/cpufreq/amd-pstate.c | 446 +++++++++++++++++++++++++++++++++++
>  3 files changed, 460 insertions(+)
>  create mode 100644 drivers/cpufreq/amd-pstate.c
> 
> diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
> index 92701a18bdd9..9cd7e338bdcd 100644
> --- a/drivers/cpufreq/Kconfig.x86
> +++ b/drivers/cpufreq/Kconfig.x86
> @@ -34,6 +34,19 @@ config X86_PCC_CPUFREQ
>  
>  	  If in doubt, say N.
>  
> +config X86_AMD_PSTATE
> +	tristate "AMD Processor P-State driver"
> +	depends on X86
> +	select ACPI_PROCESSOR if ACPI
> +	select ACPI_CPPC_LIB if X86_64 && ACPI && SCHED_MC_PRIO
> +	select CPU_FREQ_GOV_SCHEDUTIL if SMP
> +	help
> +	  This driver adds a CPUFreq driver which utilizes a fine grain
> +	  processor performance freqency control range instead of legacy
> +	  performance levels. This driver also supports newer AMD CPUs.

Go ahead and call out that this is a CPPC driver in the help message, that
is what the driver is.

The reference to "also supports newer AMD CPUs" seems vague, can you elaborate?

> +
> +	  If in doubt, say N.
> +
>  config X86_ACPI_CPUFREQ
>  	tristate "ACPI Processor P-States driver"
>  	depends on ACPI_PROCESSOR
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index 27d3bd7ea9d4..5c9a2a1ee8dc 100644
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
> index 000000000000..693d796eae55
> --- /dev/null
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -0,0 +1,446 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
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

You've included the SPDX identifier, you shouldn't need to include the license
information text also.

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
> +	struct cpufreq_policy *policy;

You include a pointer back to the policy, it's is set in amd_pstate_cpu_init()
but isn't used anywhere. This could be dropped from the struct.

> +
> +	u64	cppc_req_cached;
> +
> +	u32	highest_perf;
> +	u32	nominal_perf;
> +	u32	lowest_nonlinear_perf;
> +	u32	lowest_perf;

The lowest_perf value is saved but never referenced, should this be dropped?

It looks like it is used in a later patch to report the lowest_perf value in
sysfs. Do we need to cache it for that? Could just read the value when requested.

> +
> +	u32	max_freq;
> +	u32	min_freq;
> +	u32	nominal_freq;

You're saving the nominal freq value here but I don't see that it is used
anywhere. It looks like you grab the current nominal freq value via
cppc_get_perf_caps() instead. This could be dropped from the struct.

> +	u32	lowest_nonlinear_freq;

The same goes for lowest_nonlinear_freq.

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
> +			       u32 des_perf, u32 max_perf,
> +			       bool fast_switch)
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
> +static inline void
> +amd_pstate_update_perf(struct amd_cpudata *cpudata, u32 min_perf,

Please be consistant on function definition, this should all be on
one line (here and elsewhere);

> +		       u32 des_perf, u32 max_perf, bool fast_switch)
> +{
> +	static_call(amd_pstate_update_perf)(cpudata, min_perf, des_perf,
> +					    max_perf, fast_switch);
> +}
> +
> +static void
> +amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
> +		  u32 des_perf, u32 max_perf, bool fast_switch)
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

can you help me understand why you use the cached value for lowest
nonlinear perf here but use the value returned from cppc_get_perf_caps()
in amd_get_lowest_nonlinear_freq()?

Should we be using the value from cppc_get_perf_caps() in both cases?

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
> +static int amd_pstate_init_freqs_in_cpudata(struct amd_cpudata *cpudata,
> +					    u32 max_freq, u32 min_freq,
> +					    u32 nominal_freq,
> +					    u32 lowest_nonlinear_freq)

This is only called from one place (below in amd_pstate_cpu_init()),
this could just be inline below

-Nathan

> +{
> +	if (!cpudata)
> +		return -EINVAL;
> +
> +	/* Initial processor data capability frequencies */
> +	cpudata->max_freq = max_freq;
> +	cpudata->min_freq = min_freq;
> +	cpudata->nominal_freq = nominal_freq;
> +	cpudata->lowest_nonlinear_freq = lowest_nonlinear_freq;
> +
> +	return 0;
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
> +	cpudata->policy = policy;
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
> +	ret = amd_pstate_init_freqs_in_cpudata(cpudata, max_freq, min_freq,
> +					       nominal_freq,
> +					       lowest_nonlinear_freq);
> +	if (ret) {
> +		dev_err(dev, "Failed to init cpudata (%d)\n", ret);
> +		goto free_cpudata3;
> +	}
> +
> +	policy->driver_data = cpudata;
> +
> +	return 0;
> +
> +free_cpudata3:
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
> +static void __exit amd_pstate_exit(void)
> +{
> +	cpufreq_unregister_driver(&amd_pstate_driver);
> +
> +	amd_pstate_enable(false);
> +}
> +
> +module_init(amd_pstate_init);
> +module_exit(amd_pstate_exit);
> +
> +MODULE_AUTHOR("Huang Rui <ray.huang@amd.com>");
> +MODULE_DESCRIPTION("AMD Processor P-state Frequency Driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.25.1
> 
