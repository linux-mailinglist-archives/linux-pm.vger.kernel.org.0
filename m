Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1D832D197F
	for <lists+linux-pm@lfdr.de>; Mon,  7 Dec 2020 20:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725774AbgLGTaC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Dec 2020 14:30:02 -0500
Received: from mail-bn7nam10on2069.outbound.protection.outlook.com ([40.107.92.69]:39008
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725808AbgLGTaB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 7 Dec 2020 14:30:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VipK2AX+eKq8BzpwJQ/jGFuz9F7ACGPEL/T0ktqZyZ/Q6cei7IbCLXhypsVbZanuZeL9035c71OCH+NG1nw9Ff8gsqYmGWdp55oZpE9biktPrWhIdGfzgWumryqxb36am2ibxzbW8YHbISqXZn7dkMMhlokij4325oNrArQoq1MnPnuhSSRNww3nVuhVuwjhgAM6g0lTIetnykrTDSgxVPyAtu93qOq54Y8xkLUa2VeQWjg9rbp9D2BZERgZ5WQRVW0dMtekEZvfrk6aGmKOzrXgY/bGQFTccodvwoCNZS468NfGavu0V/GhfIZT1NKptAMRifPdsw5Zjy17UruUUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KuAi98wLTgU+JuVMX3MwXolFONiR81TOaET5RQ+GrGY=;
 b=mSdDvZyxd/fKc+D2dxTOKpfTOBo1+02SCD756mlzHwFTN3crIHeHq0y6AJWs8688bvrR04I5ixsaqo0pvoFq1T2sb5SDVurV3aPdVCTLToNrD9AJd7XhSIOxpxEPoWTKrVGqcQW0dWZJ9FWS6O5bpfKW1UXfin1azKLDgHbJrK017mBV0BviIxjghke+0a0FvZey2+4PoOo3LKKO8QTztfVb3m0TndY0dJdRNICXEBZk5Hpd312ukR4wlzqfeqm+pFghcTSpQ2ihJRvkqdYtKSdoD6w7Stk4H91GSp8ARf+P8Ap7dWm+QqjzADjRNXiV61BbXLqX4FXvsvXt3GMYfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KuAi98wLTgU+JuVMX3MwXolFONiR81TOaET5RQ+GrGY=;
 b=nyYXU5kBWunIEL/7O+ABRVhwe7sNEBe3N4IVBXrPZKa/VJBOFZcS2bsErxMaYf6cqvnJFbnYOE3Z+qJQZpoBe8ABZwRujroQoDI7Kyau8MvTo1QfvJf3iXRExurg+MMAdM65nHSZbIpuPgy0SQz0XKmIZ+780+Mt4LN8VI6SgW0=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1494.namprd12.prod.outlook.com (2603:10b6:910:f::22)
 by CY4PR12MB1926.namprd12.prod.outlook.com (2603:10b6:903:11b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Mon, 7 Dec
 2020 19:29:08 +0000
Received: from CY4PR12MB1494.namprd12.prod.outlook.com
 ([fe80::d0ac:8fdb:1968:2818]) by CY4PR12MB1494.namprd12.prod.outlook.com
 ([fe80::d0ac:8fdb:1968:2818%6]) with mapi id 15.20.3632.017; Mon, 7 Dec 2020
 19:29:08 +0000
Subject: Re: [RFC PATCH 1/4] cpufreq: acpi-cpufreq: Re-factor overriding ACPI
 PSD
To:     Punit Agrawal <punitagrawal@gmail.com>, rjw@rjwysocki.net
Cc:     wei.huang2@amd.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, bp@alien8.de, x86@kernel.org
References: <20201125144847.3920-1-punitagrawal@gmail.com>
 <20201125144847.3920-2-punitagrawal@gmail.com>
From:   Wei Huang <whuang2@amd.com>
Message-ID: <52d9b72c-5935-c28c-21cf-b24c6928de81@amd.com>
Date:   Mon, 7 Dec 2020 13:29:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <20201125144847.3920-2-punitagrawal@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.11]
X-ClientProxiedBy: CH2PR17CA0020.namprd17.prod.outlook.com
 (2603:10b6:610:53::30) To CY4PR12MB1494.namprd12.prod.outlook.com
 (2603:10b6:910:f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.10.205] (165.204.77.11) by CH2PR17CA0020.namprd17.prod.outlook.com (2603:10b6:610:53::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend Transport; Mon, 7 Dec 2020 19:29:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3b2a994d-cb06-44ce-b215-08d89ae65dd0
X-MS-TrafficTypeDiagnostic: CY4PR12MB1926:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1926B5C245D20039A615C4A3CFCE0@CY4PR12MB1926.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fFv33/eAHVmo0fyjmUn3865USVEjsH78PF1zO588Mq+CRrh/5LKriH3dOz1x3/AoZXk2LKygarHCYsvt4MvsOGidWI9iREwmE2nyP/Nd6yXi5YkevG/lWG0vYNUYvv0CoC2mp02NClUmCbPeNc/GjSIe7MLWIdCBKSmyf4koFFZC93/8/EZ+qY3Xkf9baRrwSRktrAb3CUDGqdBUTFlboXQxrNsNjq/o/8vO5d8u2DDBm+7lJpTCVyi0T7nuPWEgOoZnyCtzP1WRDrViJl7xm5ObsbQhiaqsPqlAD9IYXVPo1UKZOklNJUYLjgtsknx0b5dh4gzWQBUTCazuJiABPhRthTBSMD3mmgPzXjqtBnNpnGhGnWBcCOSeh6rtqxJRgMAz5O1j4JNoFFb5xz92EWIcBYSdnEEdYY/NXYDQVCg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR12MB1494.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(396003)(376002)(136003)(366004)(8936002)(8676002)(2616005)(6486002)(53546011)(2906002)(52116002)(5660300002)(36756003)(4326008)(16526019)(26005)(16576012)(6666004)(956004)(66556008)(31686004)(186003)(478600001)(316002)(31696002)(66476007)(66946007)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QWoxQytnb3NWT213MGpmSkhGeEh5bllaK0tpUWMrYnZIVm43bTBDSEcyZERK?=
 =?utf-8?B?a2JGeEhNcGpCUjdxWlJMa2hmWE1JNmtGdFVVTytodjFhbU5BUEpla2c3Y1pE?=
 =?utf-8?B?MDdGVWhWZitMK01zQkUrUU80RHdXZkRSUjU0TG42aUJySXRobHBhUEhLNERu?=
 =?utf-8?B?UkFGSHJwZ3I0RFc0ODNWL2VjQW94U21qeDdoNm5kdER1WXdibU9ueTRHZmU3?=
 =?utf-8?B?bjk3di9Xby8yQ1phT1FIdVMwTFROdHdQMnhXOUQ1WlFROHNEbmNDOWZKWWlJ?=
 =?utf-8?B?bHhkVlNQOHhHMnpNUGpYNlBtK3RMUzZVL1FubGx3ZDRTMjVNRytUNEU2Y2E2?=
 =?utf-8?B?MGUrdzl1cEorR0xrc0pkclJNWGNBdkxWcDFVcFNjNUcvWmtrY25UenJWcVZy?=
 =?utf-8?B?RXEwdE9hK2krd2c5Wm85Qlo5U3JTNlhYM1hIR2lEVG8rdWJ4aEF0UG1GMGl0?=
 =?utf-8?B?MS90KzNybWpySUd5Uk5hbEkwS2t6dlNIQlF3emFrWmp4SjlqOENIWTRFWGVE?=
 =?utf-8?B?Q25vQTJabWU3azBsMXdDaTY0TXJucDY2ZUZ1aGh0TEVaTkYvY1Y4MzBERDJ3?=
 =?utf-8?B?TWdKaGJhN0FiZUVscXdqTytaMThjKzBVK2FYT1JLcXdQa2dCUGtpMENHaC9k?=
 =?utf-8?B?VUptaU1reEZpQkV5WTBrWnhOTDFNY0hKQnVJQUVzYWVFcWhPbUVvN212cm5R?=
 =?utf-8?B?aUtFdXowYzVGSWttdTdyYllXMHl3VUlSUGM3cWJuVTN4Wlg3Yk1MY0FlS3Nk?=
 =?utf-8?B?dURTczE1OWMwRGxRQSttb3R4T0hUeVphcStzaDg0aGdPZmxwTjhZeGt4bGFJ?=
 =?utf-8?B?VjdzZkJZWkUvTHpXRHcxeFg5bmtyczhNZ0FQOWoxVFhNZWFEZ29FTG9Ways4?=
 =?utf-8?B?TVovaTVvaFdnVE1Zc09uNEJUbVA5Y2NXL0lrTFJtVVBJTkJ4UHc0aE5LZFIx?=
 =?utf-8?B?RTBVeEhLbUxZd0xtaEpqMDgrZnEwb05KcUVleWNrL1FmZFZ6Ym1LRW5ZK2V2?=
 =?utf-8?B?dEwyZ2VlUGl1RDM3Qitzc3U1NDU3SmthYU1wQjFxakxqMW1uenBvem5ZYlh3?=
 =?utf-8?B?bVk5N2lONmdEVlZpVWdRT1FLQzZmN0lWUTROd09NTzd2MmRheE1NWldHc1R0?=
 =?utf-8?B?UEhkOUJDLy9XeWhmdG04Q3E1RGwzQjVjakQ3b2xLOUgrZ2pMYTR2c21vamlO?=
 =?utf-8?B?S2RqTllhTURnWmhwbGV1TldpVWFudS95ZW5HNGI2cXFpWXk4ZmVUd3NBN3Z1?=
 =?utf-8?B?NlF5eG56NERacG1NZG1ZeE5xSWtrMnZ4aGVlOE5yRjV5RGxMd0JSbFoza1Z4?=
 =?utf-8?Q?BtXUpB+LhabRyvn0WQ9sUj2vwnfrsqjbin?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1494.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2020 19:29:07.9089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b2a994d-cb06-44ce-b215-08d89ae65dd0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J6IVnQZ00lQm/6yODrVUG8x54QXjeNZLfyi44BuvSoedcA01/ku6dXIZjIZnFBYW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1926
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 11/25/20 8:48 AM, Punit Agrawal wrote:
> Re-factor the code to override the firmware provided frequency domain
> information (via PSD) to localise the checks in one function.
> 
> No functional change intended.
> 
> Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
> Cc: Wei Huang <wei.huang2@amd.com>
> ---
>  drivers/cpufreq/acpi-cpufreq.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index 1e4fbb002a31..b1e7df96d428 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -191,6 +191,20 @@ static int check_amd_hwpstate_cpu(unsigned int cpuid)
>  	return cpu_has(cpu, X86_FEATURE_HW_PSTATE);
>  }
>  
> +static int override_acpi_psd(unsigned int cpu_id)
         ^^^^^
int is fine, but it might be better to use bool. Otherwise I don't see
any issues with this patch.

> +{
> +	struct cpuinfo_x86 *c = &boot_cpu_data;
> +
> +	if (c->x86_vendor == X86_VENDOR_AMD) {
> +		if (!check_amd_hwpstate_cpu(cpu_id))
> +			return false;
> +
> +		return c->x86 < 0x19;
> +	}
> +
> +	return false;
> +}
> +
>  static unsigned extract_io(struct cpufreq_policy *policy, u32 value)
>  {
>  	struct acpi_cpufreq_data *data = policy->driver_data;
> @@ -691,8 +705,7 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  		cpumask_copy(policy->cpus, topology_core_cpumask(cpu));
>  	}
>  
> -	if (check_amd_hwpstate_cpu(cpu) && boot_cpu_data.x86 < 0x19 &&
> -	    !acpi_pstate_strict) {
> +	if (override_acpi_psd(cpu) && !acpi_pstate_strict) {
>  		cpumask_clear(policy->cpus);
>  		cpumask_set_cpu(cpu, policy->cpus);
>  		cpumask_copy(data->freqdomain_cpus,
> 
