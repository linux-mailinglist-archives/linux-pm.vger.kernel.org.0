Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5F0543FE44
	for <lists+linux-pm@lfdr.de>; Fri, 29 Oct 2021 16:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbhJ2OSJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Oct 2021 10:18:09 -0400
Received: from mail-bn7nam10on2042.outbound.protection.outlook.com ([40.107.92.42]:8608
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229603AbhJ2OSI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 29 Oct 2021 10:18:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b3ehRmNDkswzy5xbpWvmz17TUD8pdOw9tkGs8WcKAtzGR/kLMtub8jWA05AZNl8oatqop7UjC3jHaRDWKt3DvW0pDv9xktiWMQ6dSjRYYOMd7NfdLtfE10MrlN1j3dd3jn+VdV+65EORfn7AqMdRr+sdbH+X09/TtPdm5/7agQVG8bIdhUvFBLulTcY4Am7eW1xzWqmzBq3cQw3HGySLOzJKaccfgLrx+VkBLC82xqB1QqSyoSlNPrF3rOvRJLyXrqdy+5ZqIq6R6Lfc7M4UUcJ9eiOWyAhI6LOEp9eMvQ1quzNHoI0gnVVrcdTS6dbKtUCevNsc/LU18KGQ8EM5BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CqiB6NUB8B0i0iRxv4IfX3cuXsp3nlh++ZehT4oftoc=;
 b=kzHPJeb7TsAtNFzZZ9tBNY/GMEv0hw5PNXNgxQ33S7MrjvWlpgEJMaDWmB0/4UgHMJEwAl49EIA6DN7OAK7B3+66DV5hezoGZEGwkL80sEKkjL7h9d46qz+JzzuSOaUTR9rEnundZ+G+jutFt38iJrh/00jhY+XLwoF0uN/3IGXiT1V0Qbi5Voxws/mlAQgtUEPtje12HXVHhUIApkq2t1hyTYPcKbbHh5Zi2+39ToZ2uobQgTjc9699xs3samW5+DA7isHQUhZjHynH7HbMw4/PgdIjmaQmnfAqDQcypGKBao/O9joQ7bf1QViy8FaNnV6SCxOZCR1YScPM9A/Tdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CqiB6NUB8B0i0iRxv4IfX3cuXsp3nlh++ZehT4oftoc=;
 b=aHBr4GQFzSnnvCMmAdwOmmt3l0fEW+VbAouHdV/bpF6aNbS2C6u6H4YGz3w0RXW4zRZfPx/PEVX+ZRmQiU8fucaaXb7oOQLbW1UAYBFaSk0reZ6nkU7NzTVpqx7j5kNuarn1Um2MWzsJm7gVB7cvXsfdmFWoT9u8xU+InDgmr/A=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8)
 by SN1PR12MB2509.namprd12.prod.outlook.com (2603:10b6:802:29::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Fri, 29 Oct
 2021 14:15:37 +0000
Received: from SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::7cbc:2454:74b9:f4ea]) by SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::7cbc:2454:74b9:f4ea%6]) with mapi id 15.20.4649.015; Fri, 29 Oct 2021
 14:15:37 +0000
Message-ID: <14fc11ed-1383-495c-f080-ade3f62493d6@amd.com>
Date:   Fri, 29 Oct 2021 09:15:35 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v3 05/21] ACPI: CPPC: add cppc enable register function
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
 <20211029130241.1984459-6-ray.huang@amd.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20211029130241.1984459-6-ray.huang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR16CA0057.namprd16.prod.outlook.com
 (2603:10b6:208:234::26) To SA0PR12MB4510.namprd12.prod.outlook.com
 (2603:10b6:806:94::8)
MIME-Version: 1.0
Received: from [10.254.54.68] (165.204.77.11) by MN2PR16CA0057.namprd16.prod.outlook.com (2603:10b6:208:234::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend Transport; Fri, 29 Oct 2021 14:15:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19d3ff78-8c52-41a8-0010-08d99ae69485
X-MS-TrafficTypeDiagnostic: SN1PR12MB2509:
X-Microsoft-Antispam-PRVS: <SN1PR12MB250973DA12C14AA09A230E68E2879@SN1PR12MB2509.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zdEo6Byl3yhk6OL0bLdcHsQs01EEVc0x6KuE3nOUeSPW3PPxbjRN+MPNEqe6ECIwq8Vxjibj0rQmYXwiJNffB+Z2nh1WXfyDxZhy+5HKvlAysBkqggBiYcQaOLfAd951E+IPZjpvGQVE4XJE3ebs7noxbZmZvwKsLyJzlOV4GGxqBY4YvMBy5eohL4qJSHfkFMay+BipqyKBn1pPJWFpO9zgfH7fIucu/nCp97mdSySu41SpxZbeKenW/ygopKeTSwrsgk9wBPSG8TronFI6Tz2UMmCttmEccxkcZmoxjPnVsaSl6GMVIChZ7aGl5UiAupIjHuhx9WBLfJFs34UAs1ZotVevZJKK5VJd5xyagXaeJs0PmrG8p+iw3pbeebP+7zGWpGu/QlJB3jbSFxvvdK5N1ndK1FihAfyUFyJTMgdDdW+btdSIzDgW2t1on0ueICfQFpzPZ425Ly4X3YW4mPU2nYA9iRa/ocZmG5vnx/nzqqIFRKbs5Z8aaPXnuRvcl9Lz5+mjBrp6Sp8FgfLXoJcOa12sL5yB9zsQmlf2B6NIhUb8hZihbL2j5LxbqeNdJxlAkqi62Qk8i9epnGHZSleikOG9DS6oSkf1VgSSDWJ0VgRQg+jzQol0F20lH5KGq6voFplx6HnN84MMWWZ6JD/vsJjuhZjOMiRCRRplLECERI7tYKcX+VGGdp0a0s0+z751eBa9Q+IKSkRKued5mqwtpZnOkz2amnjnTPS09MYkbO6C/UHHz/yGm4C+KJ14
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4510.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(53546011)(26005)(508600001)(86362001)(186003)(316002)(6486002)(2906002)(16576012)(54906003)(110136005)(4326008)(956004)(5660300002)(66476007)(66556008)(36756003)(31686004)(8676002)(38100700002)(2616005)(83380400001)(66946007)(7416002)(31696002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TU0rQ2hta2hybEd3ZkNjVjNUOWErY1h4MWZ0a3NUNHArUEZmbThZbDBGWXV2?=
 =?utf-8?B?UzBjTGU1V3EwZURHSmhMZDNmTEtCb21jaCswSWV3elNXTHhTekFtV2NzVGNH?=
 =?utf-8?B?Q20vcjkrVS9SbjA0ZW9wWUwvdlZjeGczcjU5Z0NEc3R3aThySTBkTk8xZVhL?=
 =?utf-8?B?SkNrNUREa3FjOGQ5VldvL3ljakhRM0JxMG9aTm9GOFJzYVNTcHM4anBrRFhz?=
 =?utf-8?B?TlRCZVBwaWQ4Ly9CQnJ4RjNDU1BKQVRpSk92d3lXM1dvN09hZndUcDJ4VUk3?=
 =?utf-8?B?dm1kWFlYM1I4anVuamFtc2VWWXFqdzBEdU4xUnQwUVJSbFpDNnhQYXMxL0FC?=
 =?utf-8?B?cklNYVF3eDlPL3kzcGNZczV2QmJiR3kwbDRhbHZKZSs1VHdCeXErak5IcnpW?=
 =?utf-8?B?TkQzK0hKVHZqeW9TM25Nc0dwRFI1VFFtUkhHakU5ZmpEZnJwYm10T3k0Si9V?=
 =?utf-8?B?Q3lMdGplYWUvcGIzaTVzV1RvNFBPekJaT3lMWGlEZ05pK0ZySG5NdkJrcFgy?=
 =?utf-8?B?UjJFZVJodTJWbnpwZFdxQzlFYzJaNHhJc09Gb3J6K3VFTkxPMnhqOElNOGFw?=
 =?utf-8?B?TCtZN2tRSHhqa09LV2t1WEdYQ2NiZktmR1hSM3VDekEyTEptUVZ2S3RLM2Ns?=
 =?utf-8?B?MUFuRDkxYkd4eEF4YldhREh0UUJRWVFQNmdwdWhPd2NzSzNJeTV3dFZJTzdi?=
 =?utf-8?B?M095MFBYVlExbEliQmVBR0N4a255R0xmVFNWUktkcFVXUWNvanRSMElTYUp5?=
 =?utf-8?B?a2xaUndHTXI3TWNVSDNndk9hQzlYbzEwNU9La09YdkgrYkJENEh3UGt6Sk9r?=
 =?utf-8?B?eEFYaGREVHhjNEZKaWxhK3hIcWoyeE91TG9vOFJ4TGp5amhqUjUzWTJzY3pa?=
 =?utf-8?B?OHpyM2RsNVRFeVk1cXpGajF0dG5XWmQ3L2NkZkErQS9yMERHWkZienU5eTZD?=
 =?utf-8?B?b3lnclp0MmZKV0pqRG5qMmZ6QXVtcGNzeDhDZUpGMlJGZWVWYTh4NGJBWlYv?=
 =?utf-8?B?clkwSDhpbWdEdUZkTmJYZVZyZnkrcldGaEx5N01ndlE1SEluME9OeEZiN1E0?=
 =?utf-8?B?U2RjdFdKRC9neVRtZEJWcU9mTDNZaElka2wvbjNZTmtTdDRDODljK0I4Nmw1?=
 =?utf-8?B?UmkzbXZxY2s0ZzE3UkQ1TFY5MWlMQ2lseXAzQS9aMUxlUDJyMGFXb0wwcUJF?=
 =?utf-8?B?K3NLYlFaM1lZRHZWWGN5b0lqWlNQNjYrQXJ5M0NBdFRQWE4weXhQNEJZeHlF?=
 =?utf-8?B?S3ZtcTB3MjJTMUxtQ0pDYnhMeHhuVC9xcFZqcUFRUTZ0MU45L0dhZzNyQ0lJ?=
 =?utf-8?B?UU85SHBrVVNwWGVaQjV0SXhaODJVdnc4UVNoK0dvSFQvNWdqelBDN1RhbU9w?=
 =?utf-8?B?WnNnNFNRRmZDUFlTNUU5M0t3WXVmSFhxeGk3enFzQnppVW4xS0Q1MGJBUDl2?=
 =?utf-8?B?bmVCaExTOUpHc3BGUjlncFZEWGt6L2M2RkNvRlNKV1hXUTRGcjI5WXVQaDZH?=
 =?utf-8?B?N2NsTjk3NmZPSHArY2pOaVRSOW5GMXZhaDkyN3Z4cEhabVVDUVlzSkpRelZr?=
 =?utf-8?B?M3pFVS9Qd1pLTjBCYS9maGoxWlhDb0c4QUJ1S2lmR2UzQzlpOWhIK3NsT2F0?=
 =?utf-8?B?SnhsbHlNMGNNK1Y0RjJtZmVjeUFsYzJOMjJ4STNKNjV5VFJmVzJBYzRhWHZp?=
 =?utf-8?B?aHVZRG1EM0t5ZVN4aHp1dXpsTVJIZUt6VVViNDF0V0NZcEszUkZCakV4a1Mr?=
 =?utf-8?B?QzA0YW9Lc1hEUU5qaHAzSEpSU0hRYzdGNW1FaTVzVTg0TFArcStEVytGelVD?=
 =?utf-8?B?NlVJck1yQ2JodlA3U00zS1R6Znd5ZHZiVGtYajZzRTYrTkYrTWFZZk9yai9p?=
 =?utf-8?B?bmUyTGU3dnM3UmMvV3R2eG1hVEZxcVhrNlQ4NkVtMVZoa3lLZWFQSFZvRWRq?=
 =?utf-8?B?Mm5TdURITy9ZRkZMcHFjS1JPTXFhdEx0SytQRkRQMUdkRUtLTjdLekxtTUFp?=
 =?utf-8?B?V2ZnV1ZtejMxbVlMcHgwZ1pjNTFKUXZEc3BadXNaYjZGNzR3S3VHR1ZuVnlK?=
 =?utf-8?B?aXRiSXFwRlJsRlIyclNDYUNtU1htR0F5SlpXNFQ3TWRxb2FOTFBEaEFrUEtP?=
 =?utf-8?B?cCsrTVpvYmQ2Nnl5NUtyZXhLcHYrSVRkTG91UjZROGxwYmV1djJsNXhTTHlI?=
 =?utf-8?Q?DQaA938pJFtu78i8oB7FKXo=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19d3ff78-8c52-41a8-0010-08d99ae69485
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4510.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 14:15:37.6068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0sNNL8SL/9nC6TG7nYxO4ytcF6U+3yOn3e6WRje8C8jD2aWfdrDGFVT3k6WhPPQXbjYUZ3rkzxUyS3aC3fINDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2509
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/29/2021 08:02, Huang Rui wrote:
> From: Jinzhou Su <Jinzhou.Su@amd.com>
> 
> Add a new function to enable CPPC feature. This function
> will write Continuous Performance Control package
> EnableRegister field on the processor.
> 
> CPPC EnableRegister register described in section 8.4.7.1 of ACPI 6.4:
> This element is optional. If supported, contains a resource descriptor
> with a single Register() descriptor that describes a register to which
> OSPM writes a One to enable CPPC on this processor. Before this register
> is set, the processor will be controlled by legacy mechanisms (ACPI
> Pstates, firmware, etc.).
> 
> This register will be used for AMD processors to enable amd-pstate
> function instead of legacy ACPI P-States.
> 
> Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
>   drivers/acpi/cppc_acpi.c | 45 ++++++++++++++++++++++++++++++++++++++++
>   include/acpi/cppc_acpi.h |  5 +++++
>   2 files changed, 50 insertions(+)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index c9169c221209..2d2297ef5bf9 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1275,6 +1275,51 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
>   }
>   EXPORT_SYMBOL_GPL(cppc_get_perf_ctrs);
>   
> +/**
> + * cppc_set_enable - Set to enable CPPC on the processor by writing the
> + * Continuous Performance Control package EnableRegister feild.

s/feild/field/

> + * @cpu: CPU for which to enable CPPC register.
> + * @enable: 0 - disable, 1 - enable CPPC feature on the processor.
> + *
> + * Return: 0 for success, -ERRNO or -EIO otherwise.
> + */
> +int cppc_set_enable(int cpu, bool enable)
> +{
> +	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
> +	struct cpc_register_resource *enable_reg;
> +	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
> +	struct cppc_pcc_data *pcc_ss_data = NULL;
> +	int ret = -EINVAL;
> +
> +	if (!cpc_desc) {
> +		pr_debug("No CPC descriptor for CPU:%d\n", cpu);
> +		return -EINVAL;
> +	}

Can this actually happen or is just an extra safety check?
Don't you block running based on acpi_cpc_valid?

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
> +		return ret;
> +	}
> +
> +	return cpc_write(cpu, enable_reg, enable);
> +}
> +EXPORT_SYMBOL_GPL(cppc_set_enable);
> +
>   /**
>    * cppc_set_perf - Set a CPU's performance controls.
>    * @cpu: CPU for which to set performance controls.
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index bc159a9b4a73..92b7ea8d8f5e 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -138,6 +138,7 @@ extern int cppc_get_desired_perf(int cpunum, u64 *desired_perf);
>   extern int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf);
>   extern int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_ctrs);
>   extern int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
> +extern int cppc_set_enable(int cpu, bool enable);
>   extern int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps);
>   extern bool acpi_cpc_valid(void);
>   extern int acpi_get_psd_map(unsigned int cpu, struct cppc_cpudata *cpu_data);
> @@ -162,6 +163,10 @@ static inline int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
>   {
>   	return -ENOTSUPP;
>   }
> +static inline int cppc_set_enable(int cpu, bool enable)
> +{
> +	return -ENOTSUPP;
> +}
>   static inline int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps)
>   {
>   	return -ENOTSUPP;
> 

