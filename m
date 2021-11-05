Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9FB4468A3
	for <lists+linux-pm@lfdr.de>; Fri,  5 Nov 2021 19:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233044AbhKESxh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Nov 2021 14:53:37 -0400
Received: from mail-mw2nam12on2062.outbound.protection.outlook.com ([40.107.244.62]:18656
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232996AbhKESxh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 5 Nov 2021 14:53:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UBo3KJALh2Q5aW9J35HmN67mdHrS+S2C/BLw4EseoIu5X8/fQgOSF7dIO7Ihtzid5bfdG46WDBPS4X6R7A+CppFMvpJG9KoBaIcwccidqQpqQAnFbKQLR2flW32YyYbliSMqw+tC0oS4+Z25xJfJPBl3vYAL51qQl0vghI/R+TVXHAmmL36F+ovUs0KH7DZwX7bHXiGLCTXojBzzU9HzailGXd5JuLWeOgZUC6J+nEmU57XEJirJRFEv3GYdEYfB0kru4ssGd013OKBf0qMXwMx1TLME0DmLyfBaQvLZ9Lqd601yxwV5br8Sk0/oMUt/wQssIYVfTb04XSNF3nKruw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3spJF82tAC673bvujY0bSz4EVmrYuy24Li9SfYiHFus=;
 b=bE+C8kyFZJn/GBvMb7ZrFO40sMeX7t9nyOmqo931HQMNTUigzg4zi/5oMNCqHyayJTXjIQeRaWbRo7GI0v/DlzfjVP8qrcEJimSTrJ0NZWDdBQ7JMmqtfr+c5v22SEsEXBOA/jeffBc6K2uqh3B/8Byj6VAYKlwjnz4qArixKnyN/+lxEEWak6zN35/+nOcnYuvWas+e8jQxMqphrmrCJ1ckzfwg9C1dXcbjdOJdW5F7pjJeDF8daCROw1ESa1oMrqbAdgskggAsszVBPYjag5l79TFxJhQ4wNuqLBm+uLfiODEjboYdn+pK7Xa5LN+n7zcBWS4BNi9rcdIDRZ5clg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3spJF82tAC673bvujY0bSz4EVmrYuy24Li9SfYiHFus=;
 b=jNabO/9RXCRg8wCWIA8pYpRzUnRMaqmTfpTAStR7Gy/QZnADcsLYJmvpTzecH959V+7YYgsNBSCA1ZgfZVc0LsRENN2VqMU4J7ISPPZhNRiAWMCeY83ITdUWR0CdILqSRRPfKGlDcLlnWplKz7ruibWO09O4Wgvgwi1n57A6y8k=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4720.namprd12.prod.outlook.com (2603:10b6:805:e6::31)
 by SA0PR12MB4576.namprd12.prod.outlook.com (2603:10b6:806:93::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Fri, 5 Nov
 2021 18:50:53 +0000
Received: from SN6PR12MB4720.namprd12.prod.outlook.com
 ([fe80::c4b9:b9bb:e863:af39]) by SN6PR12MB4720.namprd12.prod.outlook.com
 ([fe80::c4b9:b9bb:e863:af39%5]) with mapi id 15.20.4669.013; Fri, 5 Nov 2021
 18:50:53 +0000
Subject: Re: [PATCH v3 12/21] cpufreq: amd: add amd-pstate performance
 attributes
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
 <20211029130241.1984459-13-ray.huang@amd.com>
From:   Nathan Fontenot <nafonten@amd.com>
Message-ID: <d0418254-37c2-347c-52e5-a9de72bc08d5@amd.com>
Date:   Fri, 5 Nov 2021 13:50:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211029130241.1984459-13-ray.huang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR02CA0054.namprd02.prod.outlook.com
 (2603:10b6:408:e5::29) To SN6PR12MB4720.namprd12.prod.outlook.com
 (2603:10b6:805:e6::31)
MIME-Version: 1.0
Received: from [IPv6:2600:1700:271:b60:ca47:7240:2ff:8536] (2600:1700:271:b60:ca47:7240:2ff:8536) by BN0PR02CA0054.namprd02.prod.outlook.com (2603:10b6:408:e5::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13 via Frontend Transport; Fri, 5 Nov 2021 18:50:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0423de2a-6829-4f3e-21aa-08d9a08d316e
X-MS-TrafficTypeDiagnostic: SA0PR12MB4576:
X-Microsoft-Antispam-PRVS: <SA0PR12MB45769DB361653B137267E9D6EC8E9@SA0PR12MB4576.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:561;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Q/biMP2ub27Hnq53lBLcwAS4M7bmBrilaJ65xWx3d0PrSzCBs54YK5Uau38m4xf3NGAwxKsRwoUn9qHWRDq5pSx3JyVEBnkCd5LWx1L/nhn+gu3p/XUL9jcQe1mXpv6wuGJ6CgCZWhtkHdK4L0SPCcNMQPH6J7gBU1Hf00mWcldYPWbcWYijeBXlEP9OM7r/F/uq+kvLjeQZH3QhhUxVKCNZXfCjv3KdEah1lwl6QEOlxUQ0KIBtxIyZLghZ4obIPpBriC6iqRyTJLkEGxaTCSnIJWxTGDDsxYt9Tit+P82lT8a3lPkxMguKy1EKccqbfRLCrEWq4RAlKAO1qxbFGIDljRIfMPOA2r5hThLAoftu6RxSUauGYbCSMcVY60w6v7K8PamQ/raCxXHrHiMZvOhi75IpFLwXNVUiWpMxeZEmecEiINxDreUsZaLJTob2ipTGC6NpHbcgageLE0lskN1ckK0E+zKfAsKLSbaqdOylGqeQek2GSbAhRBUXR+b7X8urQzqQe7cxPj4tyt8t9sayLKJQEmj8xwHJow9mjnxCpZrwpAX8yqBkfSG25ZfQDg0EQc0yoP0L3QYwMLy6Nr9AURFsXe+EAm2IZAp9sgdDKt/+0WIZ7oZBf1/GzMUmwz6zc4Y7/b/w99gpeANkWH7IPGxJKnzjoFDpX3TkUuUgSfteOrA+R4fEkHzU8pHtn3cYLovaqcz7PqIY0f62vZUdSAtL0Sn3zAzeNlDNb0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4720.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(31696002)(110136005)(8936002)(53546011)(66556008)(54906003)(2616005)(4326008)(83380400001)(6486002)(508600001)(186003)(7416002)(66946007)(5660300002)(36756003)(31686004)(316002)(2906002)(38100700002)(8676002)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlFlWVNFcEJ5WnQyeGgzWnRlNjZMZFhTYlR4TGNGWnQ4UDd1YW9icGhiYW5z?=
 =?utf-8?B?aXFUVHNPVTBhNFhpVjlTdXdWZ1ZjL0F5ZTQ5ajhPNTg0ZVN6N1ZibXpWN3pl?=
 =?utf-8?B?VjNyMURsYkZUYjgwSWV6dUxvWWk5bE02T1ZLemhyMWNWb1RzeWxiaFFXSXRa?=
 =?utf-8?B?UGlzcTRlZS9FZ1loeEFHbmNVRjM2Y2lSbVJFN2ljSzdRSk1tR2FCN2YrODAz?=
 =?utf-8?B?L2tZdzJuVjhXV0R3U0dzTEhZRWZCN2xOSGhnc2oxOWdTTFFvNnVNS05TREh0?=
 =?utf-8?B?ZGtEZlpoaG9QaUF6OTEwdEdXay9KTFJEay9CeWo3a21QZHhtQkRqQ1Z1REw1?=
 =?utf-8?B?RFB0a3dwZDZTanR6QmxQOXc4YnZabjdyVUlJQW1CeUx4L2ZDZWxXdllJaDBZ?=
 =?utf-8?B?ajdaYk9EbXNDSzNnb0owN2tNUFlFb3loT2J4SEJZRFFTdThpT0hjZkVxSW1j?=
 =?utf-8?B?WGZvbFIzQjlYTWoyTlFOWWJMTWhobTZYV0FuMnd4cFFPamdabGl3b1ZuQmVI?=
 =?utf-8?B?QzhkelRwZ2Jqam1XV1dvc1RGSFU3bXE5RDh5QkFhUjFCUnRoMkJ4LzBHa1RG?=
 =?utf-8?B?REROVkdoQXZ3SUVpall6RDI4ZldkamJuZWlSQUhQak95Ukw2TjgrTk1EQ1Bj?=
 =?utf-8?B?dE81aUhWWXV2bmVSS2ZzdHpyM2RUU01kN0kvZXZETFpPMTd5eVVERjZTekJR?=
 =?utf-8?B?R09SUnhPUENEdUhLY1VNdnNsdVowQkxhQ0F1SktoaS9Yck1sd0t3MDhDVndU?=
 =?utf-8?B?dmFubEtxOTVjb0lwZDJWUEQ2ZE9rdWhvYWhDU04weDdOVXViS3U1TFU3N1Ur?=
 =?utf-8?B?Q0hkdmpUYTliTkM1YjJubVNFbTNVTVBUdERVbERrSmhNT2dEMUkvQWQ4V3hi?=
 =?utf-8?B?U2U4M2JHRGRleXpXeWZleEE1cjMrc3l5TjRrRitOK2x3SlN4eHgyTlFHWGZV?=
 =?utf-8?B?ZUpCQVF1UE9PeUszVWt3V0NmNDh2SzZYdDZpRnRwcElzb1c0aHVMK3U2NFBE?=
 =?utf-8?B?WCswY05NWi9ObDNkUXNmMHJHbUUwbTYwR2F5aUxLZ01XREFzTEhiSnQ4TExI?=
 =?utf-8?B?dTAvTGxNaU5KY3hiNEJQdVg3NGt0S1ZMT2NSNVgyR1RleDBDbDRWMmxUMUk1?=
 =?utf-8?B?Y2pTLzE2bGNvd3pvZDFqREF0a1ZRYWJOUmp2UFlJWkdtZkxwRjRIWTZtZ0JP?=
 =?utf-8?B?NTVyUjhnR29OYmhXbHRlZ3JFNFdPRTU0dTMwQkFObHAxcGlhanBncDRJMzMx?=
 =?utf-8?B?dTRQTXh6NjVzVDRJSVNZOEFmYzBJTjZpcjFobVlZWnZoNlNXL2hicXo2emRT?=
 =?utf-8?B?ajM0UzIvVWU5RXY3aGhwQ2xkOHJjcjAyL2RTQ283Ny9hMmNTaEVOaVh4OGo5?=
 =?utf-8?B?R3hCSDJiR3ptVXplUnJENmhyNm5lNTl6ZGh0T0xEKzE2c0JhT084dElZYm1U?=
 =?utf-8?B?QWQ4K3J1Mlhic2RQREZoT1JrQWt0Q0tud3JESGVLdHFMeTVRbmR6RjYzRDcx?=
 =?utf-8?B?SG1NMTh3djVBRmVEZUpiVVVlUDMvUW5kdWdiVmd3a2k4Z1RCMFE2SWFuWnpw?=
 =?utf-8?B?ZXMySTRvZVFPNkxQRUFJQ1ZoSzRWQjdlMlpPVlZlcU9ablVRY2tPeUROTGk1?=
 =?utf-8?B?YU0zUGlhVGNhLzFSMGdBbHVQUG03VjJuOUJTMEViSENJSThLQkRhbHJFOXFM?=
 =?utf-8?B?Q3U3MXBJVzNjOFhPOE05YTNyNm5UMnBwenZDa3hmS2lOTE8wZWREM3RZWENw?=
 =?utf-8?B?djJ0MXZlWDhXTzFpR0xWRTcvcDJTRHVLYWVNRU1zMExTRnJ6cjExUmxSdEdZ?=
 =?utf-8?B?aTI2a0xyaWRERkU4RHBteTRqcVYyK2E3elJSdjlJODJhVFJTck9aUGFlOFVz?=
 =?utf-8?B?b2NaY096ZzNMM0ZKNjIyNkc2a09iYnd5MWVMd0tYQmMrcHFtM2hPc0EyTkNi?=
 =?utf-8?B?YXU2NVNqcFFWN1hXNk1jdzlIKzloMWk0dHliRHZkb0hpSjhFN1lCaFpsb0h1?=
 =?utf-8?B?V05PcTlpTmM4ZHZ2TmlSMy9FSWUrZ0gycE05d1pGQk5rc3hxSXRMYW9Idnov?=
 =?utf-8?B?RVZXZllqRTBjeDFDRWsvRjVmVXRXRVBuRzhzNTZjaTcvSEpsdjdxc2drRVg0?=
 =?utf-8?B?cHFyYTdhcWJ0RmlrSEJnL2VtTk9wdS95aWNuazFnOWpRZVNXVnN5d0hhOG05?=
 =?utf-8?B?Vzd0eUdZZXJ0UDQwSDRYUDZOMjRzb0lRTHFHK1VzOVo2L3JuNUI5OUxuaVRw?=
 =?utf-8?Q?/Co/ZyEemYioHhbTpZbokIblTu7O7psF/5Gdgzggqw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0423de2a-6829-4f3e-21aa-08d9a08d316e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4720.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2021 18:50:53.1848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: voro8JOInpm8C411MmGnASNZbKDxU5t61JNXiwTI4fXgejZiYxi9PfQZi9qxUthXXc0sAzk6/A474ZaUAXKebA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4576
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/29/21 8:02 AM, Huang Rui wrote:
> Introduce sysfs attributes to get the different level amd-pstate
> performances.

Can you explain why we need to provide duplicate sysfs entries for
these values?

Each one of these are already created by the drivers/acpi code and exist
in sysfs (see /sys/devices/system/cpu/cpuX/acpi_cppc).

-Nathan

> 
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 53 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 8cf1e80f44e0..58ee50bf492b 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -536,14 +536,67 @@ static ssize_t show_amd_pstate_lowest_nonlinear_freq(struct cpufreq_policy *poli
>  	return sprintf(&buf[0], "%u\n", freq);
>  }
>  
> +static ssize_t show_amd_pstate_highest_perf(struct cpufreq_policy *policy,
> +					    char *buf)
> +{
> +	u32 perf;
> +	struct amd_cpudata *cpudata = policy->driver_data;
> +
> +	perf = READ_ONCE(cpudata->highest_perf);
> +
> +	return sprintf(&buf[0], "%u\n", perf);
> +}
> +
> +static ssize_t show_amd_pstate_nominal_perf(struct cpufreq_policy *policy,
> +					    char *buf)
> +{
> +	u32 perf;
> +	struct amd_cpudata *cpudata = policy->driver_data;
> +
> +	perf = READ_ONCE(cpudata->nominal_perf);
> +
> +	return sprintf(&buf[0], "%u\n", perf);
> +}
> +
> +static ssize_t show_amd_pstate_lowest_nonlinear_perf(struct cpufreq_policy *policy,
> +						     char *buf)
> +{
> +	u32 perf;
> +	struct amd_cpudata *cpudata = policy->driver_data;
> +
> +	perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
> +
> +	return sprintf(&buf[0], "%u\n", perf);
> +}
> +
> +static ssize_t show_amd_pstate_lowest_perf(struct cpufreq_policy *policy,
> +					   char *buf)
> +{
> +	u32 perf;
> +	struct amd_cpudata *cpudata = policy->driver_data;
> +
> +	perf = READ_ONCE(cpudata->lowest_perf);
> +
> +	return sprintf(&buf[0], "%u\n", perf);
> +}
> +
>  cpufreq_freq_attr_ro(amd_pstate_max_freq);
>  cpufreq_freq_attr_ro(amd_pstate_nominal_freq);
>  cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
>  
> +cpufreq_freq_attr_ro(amd_pstate_highest_perf);
> +cpufreq_freq_attr_ro(amd_pstate_nominal_perf);
> +cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_perf);
> +cpufreq_freq_attr_ro(amd_pstate_lowest_perf);
> +
>  static struct freq_attr *amd_pstate_attr[] = {
>  	&amd_pstate_max_freq,
>  	&amd_pstate_nominal_freq,
>  	&amd_pstate_lowest_nonlinear_freq,
> +	&amd_pstate_highest_perf,
> +	&amd_pstate_nominal_perf,
> +	&amd_pstate_lowest_nonlinear_perf,
> +	&amd_pstate_lowest_perf,
>  	NULL,
>  };
>  
> 
