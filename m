Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06836403FA7
	for <lists+linux-pm@lfdr.de>; Wed,  8 Sep 2021 21:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348491AbhIHTPv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Sep 2021 15:15:51 -0400
Received: from mail-dm6nam10on2083.outbound.protection.outlook.com ([40.107.93.83]:17536
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231734AbhIHTPu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 Sep 2021 15:15:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hzhqChK2dKafq6wwkAUsSKdj4SfR2wLrWiDStpzqdQG52fGx+ZtorisyIKBMYLY0gylq+jfG4zMbWMJmOhuTg8cEJM3XtiTX44KstQIewnwldF83U5Dy+tRASb0awevKyzPURoWAY7o0NCB9NNPHSz8oFzyh9ZM9aWTiNCfweMQEJaxk1X1R1pw+KcNqXdPmSXLD3g5UMXR6NY7PUjGHGhorl08Nn6y0WHalT2k1ylT2fxhy672p28JbnZ1ZeJBtjHom5L0Kcb7R9niHRR98wjGWx6hHe2dN3NflTuEvXCJb6mzBr62MCEzS7DV+VLVzny3OodyChKasoIiOZD+QFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=m9UTllVlAszaTGPbniMc+DWEQxc8MswtCBlkV1igtzU=;
 b=NOZ7cjl5iyRY+mMwhE2Evzfjwb9cmpz92Tlgk+VnDeex9L1WidQwMpwe6ok/KQ0nG/HA1OKmXC0ubMvymCwY7pwalkkWnjXhK9IV3ADPm4sP6CdDKpFHmDQKdmfqF7XZtNMsztpY4kI5V9BjybDF/sCinNXTrgM/QmS55rDn1ljGGji5ccGZC9TDWYV+I6uRU0k0QdXuDyL7iFuMZvbNC8FnVuqau4tltvJDIjtB+5jVtqmbNcyVUCCWtR1qfihRuwWGGolm5KpL/N3hoqDWvu1jrQ8Q//MTe+M5gKOC3cd9UzrEMoYc2kWolB5K67sCh55dxOMVN70lR46G7THmtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9UTllVlAszaTGPbniMc+DWEQxc8MswtCBlkV1igtzU=;
 b=g/rwGsbOp+oH8G7Mr6RPMDqL+cmQ2qyd8msqsrx9GfpXyeiSAWskon6rgVQXaKl2Bf2QA15HjNlEHU1BONM2Ul6B5KF4Uv6YWbi3mYCxaqgeycZCGaVSGjIiWZ/zt6s72C04/aUZKHcjAeSa43GcvLuJJfKAQEAliQ5zaCq6zhM=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4720.namprd12.prod.outlook.com (2603:10b6:805:e6::31)
 by SN1PR12MB2480.namprd12.prod.outlook.com (2603:10b6:802:22::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21; Wed, 8 Sep
 2021 19:14:40 +0000
Received: from SN6PR12MB4720.namprd12.prod.outlook.com
 ([fe80::e134:658f:3a82:f750]) by SN6PR12MB4720.namprd12.prod.outlook.com
 ([fe80::e134:658f:3a82:f750%4]) with mapi id 15.20.4478.026; Wed, 8 Sep 2021
 19:14:40 +0000
Subject: Re: [PATCH 03/19] ACPI: CPPC: add cppc enable register function
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
 <20210908150001.3702552-4-ray.huang@amd.com>
From:   "Fontenot, Nathan" <Nathan.Fontenot@amd.com>
Message-ID: <53962105-07cb-d964-28d0-1cc4d2e7fe8b@amd.com>
Date:   Wed, 8 Sep 2021 14:14:37 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210908150001.3702552-4-ray.huang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:806:f2::24) To SN6PR12MB4720.namprd12.prod.outlook.com
 (2603:10b6:805:e6::31)
MIME-Version: 1.0
Received: from [172.31.130.72] (165.204.78.25) by SN7PR04CA0019.namprd04.prod.outlook.com (2603:10b6:806:f2::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 19:14:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 488a52d7-6b08-44b3-afe4-08d972fce843
X-MS-TrafficTypeDiagnostic: SN1PR12MB2480:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2480357B2B0D23970E178604ECD49@SN1PR12MB2480.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: miuDAohsoYfxk8WCVZCZHmtJPLqFTkPdLWzO+mhmjRkv6Di/0G0CxKomQtakhJcZXnycpBfNEZDDXlXXSEe12FI5Q2VvUjJMXHUnDP39w0gLIDdA4Joo95k3GkRv75GcegCdV33S5dAaielNWG93PyCdvvk7f2VCxCSEPTNVaEyGCtC5Q454gNfkaRnrIdB6TowXvFt/K9ER/C18cUM1BVBMmFZvaQMY90uMcotfSS+ENmyhs7YTMmZzKWG4xZxVRWqmcRu1Us2nnWmaXn9Iav8m5pkS4twynHdkiWcY0LvUwvOVTughr5+A+Nb+Z+4v9RilrDolr1DJxqcDR6QwqrlqNUGF0FTmpD2PrwIGCG67vRly3PObLBcEdq+fKiJdi9baF4TYbBjlnsJFbV9mHcdJCDKgYP3ht1xfhWx4YepkdPju9AFtwlEOWWFkzZbf4vzvMhVUwM3iVx3T21DoXkb409yn2mKs9VPanAZYy4qhhtQPVOFVNeNdHkATKCpTSX3y0IGfIz+SbO6XeIGVc+jV2FBJgTuYdYpEzOnZWJpz43XeY/k3DG3l+CEmvvxDgl4imORZWGpjCsQN1nGpLHAE9tvTXdaqcSSKYBf/Dy5Yay1/aCajjOCH/2jLYfcPSMIXlPhqOmUwx52u2AB/B3MEAIXhPdnjy56w6KXoN432BQRwmvTTvdQCyICVjCcyU9Q9lMbjQEdMDO0J7p/pRuMb5IX8Pi8yS0BlBfVVoi4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4720.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(396003)(346002)(39860400002)(366004)(8676002)(83380400001)(478600001)(53546011)(110136005)(31696002)(54906003)(86362001)(31686004)(2616005)(956004)(186003)(38100700002)(5660300002)(26005)(8936002)(36756003)(2906002)(6486002)(316002)(16576012)(4326008)(66946007)(66476007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2ppN0hjSkRvNnhma3ZJN2hwZk1ZN3hRV3dVb2p4VVpmVkVKWTBwRkxGMHJX?=
 =?utf-8?B?NVVEcHJ6cjFCamxheGNaQ2tLZTA5dWNHN0xUYTBJQWUwR2NwV0tDRUhNWmtY?=
 =?utf-8?B?RmJ0bnYrZDc3UmpiVkUxWUJrSGdtOCsvQnM3d3N3Mmt1TnlBQWdwWXkrOElk?=
 =?utf-8?B?OWUrb2VndWIvbFdMLzRta2p0cGZVblp4aTh0Uk9aa010K21VMUx0dkRuWGx2?=
 =?utf-8?B?Y3k0bE9WdXMwakNWSGprT3VLVGVQYi9XUk4zMXc1N2thOGJlajVlUmRNS0xX?=
 =?utf-8?B?MjhJRHRBL3JXVmlIN0Y0TjRhTTZiSk5wd21rNnRqWXNoQXV1S2I5djh0SGJD?=
 =?utf-8?B?WUNmUkhhNmVMVVlHS1RBc3lSZEdpSHZkTXJrN3NJRitCVVlBSmJKak5iaHBY?=
 =?utf-8?B?QUt3bDBkUk9La1VzdkluZ0pKY1VLby8wVTF0bzRPeTd1ZmtjYjdTMXdIODFC?=
 =?utf-8?B?Nm9DdEpUT0FWR29GRFNuTHBYakkyVysyMlB6RER6cG13VUVEdW5lMm9pUzhs?=
 =?utf-8?B?ZWFhazk0NzhRNXZpaWFQMi9lK1NxcGRGYmVZUWlwWWlpOEpCWmg1UXFweU4y?=
 =?utf-8?B?RHlEUUIyQTdvUGVhVzhPSUFEUitLWTFwc2dUc3gzTUU1aTVjNThuOHVlbmlP?=
 =?utf-8?B?alZHQU1jejFtMzJvRXJ2S2U0bC82ZlFnVjBYZjk5QjBJQnhEMzNlcjdhL1hM?=
 =?utf-8?B?dldSVkhBalBlRXhMejRZSlBGc1pmZlRZTzBUT21tcXdlb3ZydUFTWUFjNDAr?=
 =?utf-8?B?SXI3eW9YeGZrRUp5OW96Znk3M0orM0dxcGhxZEt6eTc2OVAxZDRaVDYwU3Jq?=
 =?utf-8?B?Z3hvSXRIemJid0dFY1VKOTFEUTVSblVKTVVBbmx2Rnk3R2l4MzBkODBpQUsv?=
 =?utf-8?B?bE9KMmlPc3V4UWRlZktSN1Z1bGdVQjhLRkYvSXRJYTlZSDRFUVFJMDNFMDJt?=
 =?utf-8?B?OGpobng2d1V0TVd0dzAyek9ZMFdYNGs2ZElneFhHRVBuVEN0Z3UrSlY1UlBI?=
 =?utf-8?B?TGh5eHB3eUlTNkVKUEtKWXMySDVpazJ0QURyUThDUXViQ0ZpNC9uVzhQc0Fu?=
 =?utf-8?B?WVJFaWxwUGVQNlZUYXpXaTloeGRJYk1xNjF2SzBERk9nRk81WVR5Q3hpN3Fn?=
 =?utf-8?B?Y3JSZ1JhM210YTZibmlQVm14OVoycEVZR3BIUXJrK2hJYmJFMWRwb1ltdkJ4?=
 =?utf-8?B?Zm5vQko1Q0ZObFNlT0N1emk2STJyalBBZG5xR2p3MW96M1N2cWRnY2prSUhV?=
 =?utf-8?B?MERjeWg3VEc4U0R4ZncrcEJ2SFZNajBMWWl6Q09DTEk3REc4ckd3d3VtSVBK?=
 =?utf-8?B?ZSt3SFNiUXpvdXRkamc5RTFKN2hzb0VzLytBQXBQejFHWG5rbS9xTHEzVTFP?=
 =?utf-8?B?MWxUMm1Ic2FBQktYS0s4N3Zlc2VDSzByempIbGFhT3dGSFVvQ1gxWEltTW1y?=
 =?utf-8?B?akZhcVk2dnNwRW1sWkl1ZE1uRjhUK3N0SFRQQ2tRQkhDQVVIQnc5S2twOTN5?=
 =?utf-8?B?ZE5uN3U4Q2FrT25iMFFFRi9pQnNMVEFZUzE3OW5yZFIzaHNnam8vZFdoMkFI?=
 =?utf-8?B?TzlRSStWb1ZZYVBtZzA4NFpsYVJ4Q3htdFA1Q21DZEZCUEVMcHdMREh6L2da?=
 =?utf-8?B?R09Qcm9xcHpnZmM4UWVuN1lManZnRWxFQVMrWm5iNWpZbCtQVUt2cE9PQzdx?=
 =?utf-8?B?OGhvc1ovR0RNVnFyazNJOHh2UEpYVitueTVxREZOTllzaEpHOUNrNHlySUhl?=
 =?utf-8?Q?km4D2gtGpK2/TILG7xqyYGJG0T3L/dlHURTQ2IF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 488a52d7-6b08-44b3-afe4-08d972fce843
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4720.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 19:14:40.5799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kpsTuIxNBSxxhuHRke+gQNhPV2NFM/nRJvtCy0EXIyNTy9i/v+dNuquLje1To2a88myg7hS1FI6+3UW+SSicWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2480
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 9/8/2021 9:59 AM, Huang Rui wrote:
> From: Jinzhou Su <Jinzhou.Su@amd.com>
> 
> Export the cppc enable register function for future use.
> 
> Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
>  drivers/acpi/cppc_acpi.c | 42 ++++++++++++++++++++++++++++++++++++++++
>  include/acpi/cppc_acpi.h |  5 +++++
>  2 files changed, 47 insertions(+)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index a4d4eebba1da..de4b30545215 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1220,6 +1220,48 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
>  }
>  EXPORT_SYMBOL_GPL(cppc_get_perf_ctrs);
>  
> +/**
> + * cppc_set_enable - Set to enable CPPC register.
> + * @cpu: CPU for which to enable CPPC register.
> + * @enable: enable field to write into share memory.
> + *
> + * Return: 0 for success, -ERRNO otherwise.
> + */
> +int cppc_set_enable(int cpu, u32 enable)
> +{
> +	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
> +	struct cpc_register_resource *enable_reg;
> +	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
> +	struct cppc_pcc_data *pcc_ss_data = NULL;
> +	int ret = -1;
> +
> +	if (!cpc_desc) {
> +		pr_debug("No CPC descriptor for CPU:%d\n", cpu);
> +		return -ENODEV;
> +	}
> +
> +	enable_reg = &cpc_desc->cpc_regs[ENABLE];
> +
> +	if (CPC_IN_PCC(enable_reg)) {
> +
> +		if (pcc_ss_id < 0)
> +			return -EIO;
> +
> +		ret = cpc_write(cpu, enable_reg, enable);
> +		if (ret)
> +			return ret;
> +
> +		pcc_ss_data = pcc_data[pcc_ss_id];
> +
> +		down_write(&pcc_ss_data->pcc_lock);
> +		send_pcc_cmd(pcc_ss_id, CMD_WRITE);

Shouldn't we be checking the return value from send_pcc_cmd()?

Also, if the call to send_pcc_cmd() fails do we need to update
enable_reg? i.e. cpc_write(..., !enable);

-Nathan

> +		up_write(&pcc_ss_data->pcc_lock);
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(cppc_set_enable);
> +
>  /**
>   * cppc_set_perf - Set a CPU's performance controls.
>   * @cpu: CPU for which to set performance controls.
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index 9f4985b4d64d..3fdae40a75fc 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -137,6 +137,7 @@ struct cppc_cpudata {
>  extern int cppc_get_desired_perf(int cpunum, u64 *desired_perf);
>  extern int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_ctrs);
>  extern int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
> +extern int cppc_set_enable(int cpu, u32 enable);
>  extern int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps);
>  extern bool acpi_cpc_valid(void);
>  extern int acpi_get_psd_map(unsigned int cpu, struct cppc_cpudata *cpu_data);
> @@ -157,6 +158,10 @@ static inline int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
>  {
>  	return -ENOTSUPP;
>  }
> +static inline int cppc_set_enable(int cpu, u32 enable)
> +{
> +	return -ENOTSUPP;
> +}
>  static inline int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps)
>  {
>  	return -ENOTSUPP;
> -- 
> 2.25.1
> 
