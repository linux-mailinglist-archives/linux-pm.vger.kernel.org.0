Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 538C541B4AF
	for <lists+linux-pm@lfdr.de>; Tue, 28 Sep 2021 19:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241916AbhI1RIN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Sep 2021 13:08:13 -0400
Received: from mail-mw2nam08on2049.outbound.protection.outlook.com ([40.107.101.49]:64256
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240713AbhI1RIK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 28 Sep 2021 13:08:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ko7CT2dd5LCL5fIeij6dYVerA1nTaxRQ7QXzKpUTommGQyvBAzQNDfb32ieUDdjTPd7TZudMwlUg5mmJ8rxdII36Fs2MiPDzhDm9dzoYac34A/QYJ0QeJhgufH90F4OBXykjxT8tSgKEPuJJBngE8TwZGaU3F2UvGcaIks30b3g0RAR2w5NDNSP4TyeuRuZ1auPBUDPzIv+MG2snKKOWb+zufaDpcF55MLya5mNJhsEjHYQQIAx7nBOg/tasttG9Tlsf2o+KgUO6gK7jcRYUm0w8zKfzMFaADIZmuOnkSD53RRVZTw5cZXtauy4c+8aCv1yER1CVTd4Gbuhx8PQBBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=29AB/31lgviHByeHX+FQPSLk7BPnEHNiHmVe259CX5o=;
 b=njpHSCsuhz0XOvCrXeBAE9EEVTh5GEVG9Z7wLouSPorhIfAum7LYAusc9/ZXF/c3XRjrbBz6Z8IKX56hhXt5cRmkhk61ZrT/6CGp3qT7y909q5KbWates/8RiLRM03kz+cdHolUqriS5KSbzdlEJUpHwMiscHKM+FXzPzjmTO1aB4YWWejJAHecOhFIn7bjr1uI1G0sEJbaxXgeP2xB5GupnE5nu/SPciQ8X5TmUy03KoPZnEbsnOBfw4g/z4faRWh1RpmiBogWBMoucdG1KS5LNtHFxJil8Nwwtek2GtEMr/+aa30PlQIS+OtsBTytgU25IvVcuGkMYtsTVUJuSiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=29AB/31lgviHByeHX+FQPSLk7BPnEHNiHmVe259CX5o=;
 b=gP+/uBnStwovc01k2P5P1bll3VhChiinNvUgxaW1xrQ6aFPmg5k189Mr6LU9s/paeZyYkD14+IgMoZqLCsWaouEcVYuTcXQH9BTfh0kB1Fdf/Kr4Fh+MH91k3jGgLFM6XhL5/5sE5UE4dR6OSYCSXHB7CfV8GNPuML1FO8ErmNM=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4720.namprd12.prod.outlook.com (2603:10b6:805:e6::31)
 by SN1PR12MB2397.namprd12.prod.outlook.com (2603:10b6:802:27::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.18; Tue, 28 Sep
 2021 17:06:27 +0000
Received: from SN6PR12MB4720.namprd12.prod.outlook.com
 ([fe80::e134:658f:3a82:f750]) by SN6PR12MB4720.namprd12.prod.outlook.com
 ([fe80::e134:658f:3a82:f750%4]) with mapi id 15.20.4544.021; Tue, 28 Sep 2021
 17:06:27 +0000
Subject: Re: [PATCH v2 04/21] ACPI: CPPC: add cppc enable register function
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
 <20210926090605.3556134-5-ray.huang@amd.com>
From:   "Fontenot, Nathan" <Nathan.Fontenot@amd.com>
Message-ID: <ff0fb071-78fd-87cf-bd6d-c89c25e09d4f@amd.com>
Date:   Tue, 28 Sep 2021 12:06:22 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20210926090605.3556134-5-ray.huang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0149.namprd13.prod.outlook.com
 (2603:10b6:806:27::34) To SN6PR12MB4720.namprd12.prod.outlook.com
 (2603:10b6:805:e6::31)
MIME-Version: 1.0
Received: from [172.31.10.217] (165.204.77.11) by SA9PR13CA0149.namprd13.prod.outlook.com (2603:10b6:806:27::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend Transport; Tue, 28 Sep 2021 17:06:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20963846-735e-4757-33fd-08d982a24eea
X-MS-TrafficTypeDiagnostic: SN1PR12MB2397:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2397153EF8659185F5E4FDBAECA89@SN1PR12MB2397.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NaGRUyKgL3Dlyd3rI0+WMsPXrQ7llzphQaHSLUiFjwGBRoibGo7EWC726Gubdi5E3rDlZu2HBJk1uKCBpjLZWtE5tMgRgi+0V2CBFDfbCGCPZ5WoD0dotsyOX+T0Wfszmesvymu/MAwFDuk64xnG5Gtn1Zu8K2hxmJ/hs86+rfmdRVamlYlLP0hhgiTAFtX7hJPp6d9JxBbTZqCWlOvztliKE6tlyDcRzQFV2PyqDP2Kb339bDObQbTtElSfygIpTqmrHSf91xX5AIlCGk+mBaoxhKgURxLWJ+vbxa0ZYkM3fvM6Ge7nDWim1gR2tsAsWWkIC0yeRS5EWgJ3dHq28Qjudw52ScciYUNqd3PQZWSv9QMNRqdwJDoGK2osZUWa19vbL/rhKGYN99SqIIJaoLqqLkoEdZHBWvqETHAUPpu0k0Zsl/Q4mgLbmbYMykg4/HjorgBRvSxyMe5yZHQ1mI9kKQ4hzzdbMJXtokAfdVyljAvUndaRKd7sYzJzpeROq/1KO+BDct8XF+e60RnzxUBwy7sSQ6KqVDjqX5RR2k6IcZxTJRPhGXkGthM8Y0imw9Sm12WdKXod2lgjZ6T1cGS7/9GTdVj3zTszGb/oMA6srPCezqvlKAymAhaiQ9GlabTpIZc2N/R8VCkAHmnZaEi1rf4jFlKx7AYJtUzqvbh8m3bF5IfOomAcuSy1ViQYBxsvNc6ed1mk9uRyesS5/gQOyRXrK/5o7u0vpz+PoGk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4720.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(53546011)(186003)(110136005)(66556008)(26005)(6666004)(508600001)(31686004)(36756003)(54906003)(2906002)(66476007)(8676002)(16576012)(5660300002)(6486002)(2616005)(86362001)(4326008)(83380400001)(66946007)(8936002)(316002)(31696002)(38100700002)(956004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWFGZlgxOTdjN0FkbzBlOG9zOW04Q1k1dG8yTVhLd1hZRjJFUnpZeENoYzFW?=
 =?utf-8?B?dlFuWlZXdnVETVc4dTY3MFc5UUxWRi93OHVscHZVSStyOVYzemtWb3o4dDgz?=
 =?utf-8?B?S2xSQTNDeURoVE5Tbk1seWtVZGxQZWo0T0RRZWZKd0RFc2ZwZHJ4ditQOCtC?=
 =?utf-8?B?RXJmbHdzS2tqYU1LNjBQeHo5UkNIRTk3eldJUmQ4MGxpVkw3MDRRSHNnanlo?=
 =?utf-8?B?UktmaWs0WVdwRDc5N2d6Uy9GVVJUdllpY0F4RWM1SmsvVHhzU1Z0WGRrZDJO?=
 =?utf-8?B?Zm5wcG5md2pzbWd5U095eExrYTBiNGgxcjVsb05TejBId2NqRHhTcmFzVm5r?=
 =?utf-8?B?aG5sWDg0MlBHMnluNjQvck9IUm10YUw3cm1GN1RNSTREbzBES1U1d1lDeW5B?=
 =?utf-8?B?NzlrUm01THlQNjBPL2ZDQ1hzV1RxZnZaOGFrNUg0S0VMVHl5LzN4QXluTktC?=
 =?utf-8?B?U25Yd2tvekFIL0REVk0rUStmQ2lIT0VaQWIxenVvaDh4eXlHYlk3Y1RNQys4?=
 =?utf-8?B?ZnhVMWVHbHhsTEltaWFZZkxXS083VkZ0QkFVK2l0NkFiakRmSXNxVUpiZ1U3?=
 =?utf-8?B?NmYrT1BydDR2S1lCTmI1Qk4xQmZhcjZzZlVuQ250aUNOYTYzRGdyZFFJNWhO?=
 =?utf-8?B?K3orVitldjNrQWxlQjR6Z3lxUUw4dmJaRHFCQ0R5TDFiNHpDd1hxaDFRWVRS?=
 =?utf-8?B?YUJQV2d3ZXFZaWxxcVpSR0xXT3RLRWhrMHhidXFJVm5XbVBMbWx5V2s2NmdP?=
 =?utf-8?B?a3hld3Z0SFdUQWRBWDhVbDVoTml6YWlONzVhdlR1K3dCZ0lLWGlSQzg0Tjl3?=
 =?utf-8?B?OEROSmtrcXNTdlVVdGgvOThHSGx3b3Y3YjYzV3oxb01Ld1FvWFhqL0drTG1j?=
 =?utf-8?B?KytOdUFjRWZPMHpEZjBKbVFPRUZVSDBXbWlMSFNrQkVoMDJadi9wVnlYaVZa?=
 =?utf-8?B?bmE4ajlRbWlYSUNBV0c0enpySG1lbmtNS1A3NzIwOU9TZHV4QlNnSklxYmg5?=
 =?utf-8?B?NHhyWGZVaEdISFFXK0Q5NytZY3Nqc0R6c2xpL2VkVE9tL1hnQUVzdXFoaVEr?=
 =?utf-8?B?TjRHdlc4cDlIVlN6NWNvUFk4RjJqbnNPMjQvUWY5TVdCSnUwWXNJZlNUdURR?=
 =?utf-8?B?dlR2NXJTeFJlV2RGczJtMXVUNjVzdFk0NzFwUHRmY0Q5RzF4L0pabTVpeUNv?=
 =?utf-8?B?T241V2RiaVJlUWdrMTB4eS9mMFpiK0hhNGRnWDdtbjlsWDc1bWVGQWh3ZDE1?=
 =?utf-8?B?SnF5RWEyeTRqUnp4U2wrY1ZGSEU2WTBUYkpCOTJwaTFYVkdUbWl0NVh4ZmdB?=
 =?utf-8?B?ZmpUVHJxcGFGVzd1WWkwMSt4cGNJTnh4bU80WVJzU09tQ3ZDd3N4UTNBcytR?=
 =?utf-8?B?ZkhvWGFDMkIzdytJZmpUaHJvdjJ5YzFHbmZYZUw5OTRqTTdsOFJqeFZObVlH?=
 =?utf-8?B?a3E0ME5yNGVRd2wwUkhrSW5wM2FaNEFuWEl5SE1ad3ZOMmZLbUh5N3BabVpY?=
 =?utf-8?B?TnlRaVhHaVJPMUxYZjZEVDFPcjFNQS9uZ0JodE5FL2tOVS9uMFNFdlk5dnc4?=
 =?utf-8?B?RDFVTGIwOFRlRURHK282c0Vvb2NqaFN2K0pMeCtmVG8wRi9nU0lCS1BaakZt?=
 =?utf-8?B?TjREck1GUmlhZGdwY1g3eTRzOWN4SUIyTHNQU0Zuc3Ywam9uRnpPR3NYOVdD?=
 =?utf-8?B?VUJyc0JQenNSVytSclRFd1JBYUZxcjlsYUozOUJGWjJORjJydFBaZ2thRkJ0?=
 =?utf-8?Q?++qdyHau9ARMBhM0zz3u4Z1AOtcHecEcd4dcSdx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20963846-735e-4757-33fd-08d982a24eea
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4720.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 17:06:27.1109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KNJ2R8YbXFI1oHwTVDXAbbTi7MQknl0SrBILOHubuFtn4L49E4DecNFXlDHy4GC9d8Ke4SSrUiEBaVAir8ZG9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2397
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 9/26/2021 4:05 AM, Huang Rui wrote:
> From: Jinzhou Su <Jinzhou.Su@amd.com>
> 
> Add a new function to enable CPPC feature. This function
> will write Continuous Performance Control package
> EnableRegister field on the processor.
> 
> Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
>  drivers/acpi/cppc_acpi.c | 48 ++++++++++++++++++++++++++++++++++++++++
>  include/acpi/cppc_acpi.h |  5 +++++
>  2 files changed, 53 insertions(+)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 2efe2ba97d96..b285960c35e7 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1220,6 +1220,54 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
>  }
>  EXPORT_SYMBOL_GPL(cppc_get_perf_ctrs);
>  
> +/**
> + * cppc_set_enable - Set to enable CPPC on the processor by writing the
> + * Continuous Performance Control package EnableRegister feild.
> + * @cpu: CPU for which to enable CPPC register.
> + * @enable: 0 - disable, 1 - enable CPPC feature on the processor.
> + *
> + * Return: 0 for success, -ERRNO or -EIO otherwise.
> + */
> +int cppc_set_enable(int cpu, u32 enable)

This should take a bool instead of u32 for enable, you can only enable
or diable cppc. The only caller I see is in patch 7/21 in which the
enable arg is already a bool that's converted to a u32. This also allows
for the removal of the enable value check.

You should consider merging this patch with patch 7/21. This patch adds
the cppc_set_enable() routine but has no users. The only caller I find is
in patch 7/21.

-Nathan

> +{
> +	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
> +	struct cpc_register_resource *enable_reg;
> +	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
> +	struct cppc_pcc_data *pcc_ss_data = NULL;
> +	int ret = -1;
> +
> +	/* check the input value*/
> +	if (cpu < 0 || cpu > num_possible_cpus() - 1 || enable > 1)
> +		return -ENODEV;
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
> +		/* after writing CPC, transfer the ownership of PCC to platfrom */
> +		ret = send_pcc_cmd(pcc_ss_id, CMD_WRITE);
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
