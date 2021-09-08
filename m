Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1587B403EE3
	for <lists+linux-pm@lfdr.de>; Wed,  8 Sep 2021 20:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244084AbhIHSO5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Sep 2021 14:14:57 -0400
Received: from mail-dm6nam12on2041.outbound.protection.outlook.com ([40.107.243.41]:44256
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S245528AbhIHSOz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 Sep 2021 14:14:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F/rSi7+YWLrXFrt8mBXn0ztScFbZWcKfcNQgAcTxlTeo61xVtE3IITG7ea6RPiPjj7LRU3tvHmN1nr5SAe4L3Hn5w7zeDofwHk5bAMDntp8C5RXwa05pLdCA9YNuBX0Cznol3v2w0FyqQzTQAtQqDb5EMVN/8sUM3f0Wpry01kNt8GubobqmWHWaOij+mPLForItluuH/A+jy9DlSYUUkLwzT/BlAcaRHJpnuiuGmupQvwA4EkNLT6T6Wjk/NSJ0XsWi/SMop6ZeVeNIvzFqgbtSJYfK0E1Syx+gEPmUeQAOA1eWNFP7zDaF/JGh793N1KdqxBU6/OYJD6W9T4XQ6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=3G4WvZzRmpGNP/MzQjRdmuUHKXbWm6dhUH0N8JUTb0k=;
 b=QcyIWOgaqXz56fGvkeah6ivQm82Q0QSPyr7cUxhcJHzVFB/uS0+T1BWihlSjZ0Zp6xF9khLuF/3RKQ34I+liz1Ba72aHEpkI4EVUUrXHVeVjceR9Qvv611DH6QLPrFAp0suR2IpuYQXLxbBNPkopYzIAD3wS1K/KDQlQMdeADi8l6HI79XfMkW/RFsaUGuDak9bamZ+xc3n+8+cAfQiu+oMyvpQJx+jdDbJXpWmfaliDWFzExPxO/epN45iUnqRkG3CUPDeiLOdB+O51oUxTe2C/t1wGLt3k2kOTe6zn1iAR9AWmokyPj24fGWr2V51BP5QlKQqnORqWl6vI0+Sc1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3G4WvZzRmpGNP/MzQjRdmuUHKXbWm6dhUH0N8JUTb0k=;
 b=OcZEIr6Q1NzHDfhfbZ260qT1Jk+UTTL4R9DjsDtxdxfZVHsAuIjlkdJm6jdZcoAiYCJ1AGu8cf2E7qU4DgRnDVo3JCUfxO9A+S+oy9u+Py6FoT7Lm+4/Sb2lxNJwKMwgO3kT09/c5WRpyVz0zuv+LMakSCPUDzXWQMHhNyC7Rgg=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4720.namprd12.prod.outlook.com (2603:10b6:805:e6::31)
 by SA0PR12MB4368.namprd12.prod.outlook.com (2603:10b6:806:9f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Wed, 8 Sep
 2021 18:13:45 +0000
Received: from SN6PR12MB4720.namprd12.prod.outlook.com
 ([fe80::e134:658f:3a82:f750]) by SN6PR12MB4720.namprd12.prod.outlook.com
 ([fe80::e134:658f:3a82:f750%4]) with mapi id 15.20.4478.026; Wed, 8 Sep 2021
 18:13:45 +0000
Subject: Re: [PATCH 10/19] cpufreq: amd: add amd-pstate frequencies attributes
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
 <20210908150001.3702552-11-ray.huang@amd.com>
From:   "Fontenot, Nathan" <Nathan.Fontenot@amd.com>
Message-ID: <25cbd9b4-f7f3-9b84-096a-5b2bffbd3e40@amd.com>
Date:   Wed, 8 Sep 2021 13:13:41 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210908150001.3702552-11-ray.huang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0073.namprd13.prod.outlook.com
 (2603:10b6:806:23::18) To SN6PR12MB4720.namprd12.prod.outlook.com
 (2603:10b6:805:e6::31)
MIME-Version: 1.0
Received: from [172.31.130.72] (165.204.78.25) by SA9PR13CA0073.namprd13.prod.outlook.com (2603:10b6:806:23::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.8 via Frontend Transport; Wed, 8 Sep 2021 18:13:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30b21a9e-e9ba-45fa-ed61-08d972f465c6
X-MS-TrafficTypeDiagnostic: SA0PR12MB4368:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4368236FD1FABC2AC698EBBCECD49@SA0PR12MB4368.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:612;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WCs0MtD0Du5zhcJINBrl8jsr+nerfSFqjhubm2BXL6yn9zuSPLma/XeybiFdYHVmazidiI2lNyCgZyDUC0DkIRHWvhWU8XChZfnlt8RHA36s/prt4p1W/SCDs3OGZh80WdTz0CRl+8stsrMRQ5V0P6leVvxXPyaPQOni3Dos8UyLof0ZPu2kJ1tK+DWWyx/2gydVar1BQDk8TdWeDvDeiRy2QlZ10lYxj/80QXpYO2jMZrG6HN4FTx/Ilbsbwovf6g6hhK6M7xSuzGFS4bMRfR9WVgJbimpBJK9Lu65rTv3o9paYUD9k8UYn4ANpDk6Zj7ibup6Iqcpv/ulsXE1zaETFSD3ZGEYZZcp2i648T23g+xLgXYXZzIxNGjXFpqADjOlkz8JRd4OelotPG8zE5AYw17aTLwigJ+Bzf5YkNPJPYGpk6tp676DiCeky/hZhBmqaWjhVd7OK8yBIHLQ4+VIkPma5eKVRyRXYE46d1Lz7FWm8JVOFvzKU8K5+Vj9qfCaJn1fLlK8eibP1utxpAh4wTcey/3DBm1dL0HGVvylq7cjwWY93jXWTqHgJ1Z6jJR4CTrNYYuv8XTYqG2z25KNphc0R6ec9AYlUY1UdKr+rUiPFjXLIWhGBEygYs3V7gF9ynWQ8G4h90FTJLe2STXRqphYbQ6PI7HE2YC6jJzkETSPm4us108nRHlUvkUg4INfxrsx5yFAaOIjZYmOXUsfTERou8LMyv4jg6a9DwcY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4720.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(136003)(366004)(39860400002)(38100700002)(6486002)(31686004)(478600001)(66946007)(31696002)(8936002)(4326008)(2906002)(66556008)(66476007)(54906003)(26005)(186003)(110136005)(53546011)(36756003)(5660300002)(316002)(2616005)(16576012)(8676002)(83380400001)(86362001)(956004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzcydHRmbjdJNVZZTUdBdHlXSU5BZ3dtL29uVnVQVHFZVVp0U3B6RGgyQk8y?=
 =?utf-8?B?WUxaOUtTQUVuRzlrWmNCdmR2emtXeVVxeEZGMnB2TVZGemh0MHM4U1NOakRE?=
 =?utf-8?B?ZU1YVmdDWlVmL2pBRmk5SjNGUGdkQ3A0YVJmVkFYWm5iUE5EUHJlclF6Z1Az?=
 =?utf-8?B?Qk1wdkc1MWxzcml6aGRsNCt1WUJEMWthNzB0ZEpqRXB3bEdEbG1oMkQwU3lk?=
 =?utf-8?B?cWZVa1puUEticEl3c0VOOGZDYjZaQXFwSlJjTEdTTTJ3WTlKZlI3QUZTOFlX?=
 =?utf-8?B?MEVycTBIayt5QjdJaVR5dTNIQWk0NDJ2Ym1sOVl2TkdINzd6N0d5VzdYVytG?=
 =?utf-8?B?eUEvQmdkYVdDYWRxYjZCRXA0cXRzeGpCbGtDdk9oRWMxalc1SDUyWFFQS2pv?=
 =?utf-8?B?UzczWkhqREhWbGhTQXNydS92dDBWdHhRTzlyZkZLWDJtZXFoZ200OVJjYzRX?=
 =?utf-8?B?a0VhQUhkVEVMb1BZNGRaSVU0ZnlqdWZ0eGdWc3NkSHB4ODF4R1VFY2l4K3h5?=
 =?utf-8?B?RGx4VTFGYlhLbXM1Z0NDN0ZQaFVnemJJbU1ZbUpWN1orMWlZVUZlUUVQbWkv?=
 =?utf-8?B?SWZKcWhpN2NQMWdUVktMWWFxSXpwSGtUOU9ycDZZMEJzMGcxcDJwS0FpZFl6?=
 =?utf-8?B?blorRVlmUVhRMUFUZVpPa0Mwb2t4Skl6VURVenZnNlFMcTl6V0NWVDJEREJz?=
 =?utf-8?B?Mlc3cTdUQnRiWXI3RnloN1JicFJFd2NyUDMzNDNjRkd0WVdUUFpqN1ZEd0FU?=
 =?utf-8?B?bGorNTVFVU5EdS9OMGFuV2Uyd3NnaHZxWnB4a1JYY2szTkdQc3AxcFU4UE5i?=
 =?utf-8?B?dk9CM1lJQWhNTS9teXZzdHBERVY0UkxFeXlPSEtUQUxPeWxndUR2eVhWQitq?=
 =?utf-8?B?dm9zdUszbjNrSGc4aFJZT2FUSXVFRkdkSytmL1hYeU91ZGpBdTl5NkdvWkdI?=
 =?utf-8?B?bDRkVTR6QTczY2ZCRlpmelphRVBwQnJwaWF6MktmZVRWcWdFMldGbHZ0cWww?=
 =?utf-8?B?eXpwSjV4NlRKSGZ0djQ4dm9qUlEwbHNUVHFIQW9lWnFJMnJmN1ArWThIdDFE?=
 =?utf-8?B?bnZKTTErSUJLeHEzZDVUVlluZHo0RTRLcDBieHZjUkgwR2Vvby8vWWxBQS9F?=
 =?utf-8?B?VTdzMVhuQWdEUFpFZVRtTHJGUFhaS09RdGxpelpOeW1SYk1pNzdzdCtMNExT?=
 =?utf-8?B?N3V3S056OTh5U0N1QUxUdHl0QUFCY3dZdHpRTzhUSStPdmMwaUw1dUVaZUZ3?=
 =?utf-8?B?RVNqODZqbENjVnplSzNiNW5WY241L2tFU3VWL2FkMm1sQUc0d01EL3RVcHJG?=
 =?utf-8?B?LzhGS1gwU0JwMEFFTmlqNGc0eXYxd1pCZWd1bkpQZ2J3NkpQb2NTV0ZKL2dr?=
 =?utf-8?B?aHBRL0F6Mk12eGU5NHgvdUhkMSs1dVloZE9HeXFobXh5ZnUrd3dOMlAxODc5?=
 =?utf-8?B?VFFqSlQ0UWtGQjlmU1ZVSmdLUFZVMEw5a1Q5QStBb1RZWC8wYWxWdkZhbEJ1?=
 =?utf-8?B?T2RDMVJEdHNFOFFMc2owcHZpUEdmdjF0WmZUZUQ2c2VZTG1aSUlwVzA5RGgy?=
 =?utf-8?B?RHhIVWFvVTdlWitkUHROOEc5VjEwL2MwVnlQUTFNU29hS2t3N0JQU0l4Z2FT?=
 =?utf-8?B?bGlXRVBPN0ZqQnhRc1ZNVjZDZmhsU3MyRm9rck1XRmJYaGRoME5nK1FJWEt0?=
 =?utf-8?B?VUxoQzBRbkxPUk8wVklGRDMyY2pXYXpISzZmb1crWGIyOTliVVNvU1JVL05k?=
 =?utf-8?Q?PIsr1Q+VPbOJ22xfULws1mkSVykbjan74Dm+ba0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30b21a9e-e9ba-45fa-ed61-08d972f465c6
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4720.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 18:13:45.6127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2IaCgFfCLRFXfvz3N0OkLZsw75QFi3qdRT9jIC1tbLUjgJTKvAcR5wnEvevhMSOpbnsKl+Q+NE6HdmC2dtfl7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4368
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 9/8/2021 9:59 AM, Huang Rui wrote:
> Introduce sysfs attributes to get the different level processor
> frequencies.
> 
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 80 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 79 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 48dedd5af101..3c727a22cb69 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -577,16 +577,94 @@ static int amd_pstate_cpu_exit(struct cpufreq_policy *policy)
>  	return 0;
>  }
>  
> -static ssize_t show_is_amd_pstate_enabled(struct cpufreq_policy *policy,
> +/* Sysfs attributes */
> +
> +static ssize_t show_amd_pstate_max_freq(struct cpufreq_policy *policy,
>  					char *buf)
> +{
> +	int ret = 0, max_freq;
> +	struct amd_cpudata *cpudata;
> +
> +	cpudata = policy->driver_data;
> +
> +	max_freq = amd_get_max_freq(cpudata);
> +	if (max_freq < 0)
> +		return max_freq;
> +
> +	ret += sprintf(&buf[ret], "%u\n", max_freq);
> +
> +	return ret;

Here, and in the functions below, you could just do

	return sprintf(&buf[ret], "%u\n", max_freq);

and get rid of the intermediary 'ret' variable.

-Nathan

> +}
> +
> +static ssize_t show_amd_pstate_nominal_freq(struct cpufreq_policy *policy,
> +					    char *buf)
> +{
> +	int ret = 0, nominal_freq;
> +	struct amd_cpudata *cpudata;
> +
> +	cpudata = policy->driver_data;
> +
> +	nominal_freq = amd_get_nominal_freq(cpudata);
> +	if (nominal_freq < 0)
> +		return nominal_freq;
> +
> +	ret += sprintf(&buf[ret], "%u\n", nominal_freq);
> +
> +	return ret;
> +}
> +
> +static ssize_t
> +show_amd_pstate_lowest_nonlinear_freq(struct cpufreq_policy *policy, char *buf)
> +{
> +	int ret = 0, freq;
> +	struct amd_cpudata *cpudata;
> +
> +	cpudata = policy->driver_data;
> +
> +	freq = amd_get_lowest_nonlinear_freq(cpudata);
> +	if (freq < 0)
> +		return freq;
> +
> +	ret += sprintf(&buf[ret], "%u\n", freq);
> +
> +	return ret;
> +}
> +
> +static ssize_t show_amd_pstate_min_freq(struct cpufreq_policy *policy, char *buf)
> +{
> +	int ret = 0;
> +	int freq;
> +	struct amd_cpudata *cpudata;
> +
> +	cpudata = policy->driver_data;
> +
> +	freq = amd_get_min_freq(cpudata);
> +	if (freq < 0)
> +		return freq;
> +
> +	ret += sprintf(&buf[ret], "%u\n", freq);
> +
> +	return ret;
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
