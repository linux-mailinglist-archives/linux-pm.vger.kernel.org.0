Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2692A348845
	for <lists+linux-pm@lfdr.de>; Thu, 25 Mar 2021 06:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbhCYFQX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Mar 2021 01:16:23 -0400
Received: from mail-dm3nam07on2081.outbound.protection.outlook.com ([40.107.95.81]:21729
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229508AbhCYFQB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 25 Mar 2021 01:16:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dSpmXVg9tiJpHdPFLfj2OFRQw/FFoPFHd8k3/pbmyJHsVIpVZdzw52X1VpMy1DhpcJhsWX7vK/Ko8tBDYm5/739NaHQrEubGt9Yqs5mH7oERsn5aea72h5k/QcAthtAfjgiLCDWMFT4kgiH5MkezXoSJjAPOZMEu/QSOiwGgzwJ6eIazZ6B9ChiNK7eAEQnU8tJxz44V4T1bMHtFVctCI8Df8TEe7ESaKxEZxOOjsSMrSfw9wuqEu22OaomvY2qz/0eC5Py79tVj8bXKX+Lgs1Yd+3DYNwSYr9r4VnkL4ZmF3HDYBQfDTCbssbvlHHwYuKFACDq+YyMzGuNXxa2x7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f4ljDAicz0TpqROzQVglgZ2r/RPQrN1v3Q8IyjTbmEM=;
 b=c41avAu+niyZ3+ngwtt7VN2BHcRtZeZxhmXvursbJYd+Cw+Y00cZswq/wzBogoVVV4+NI5kIzDRMRsJ4k2kDo+Zsk48FGDSilRT7aAwEjwQtL7fSboDttHW+kDzjhan73SfIvQVIwOjU0gviQJZHBwoTYp0u1OKNJngJIRJthknF6uenLhLrgudlg6YlCC+55ibPwHprzU0eA/hkKHpPWt9AjqMWq5a5v1hT0Apht/Q0p8pTxCYJdWQFBSNA2VNpRb27PF2vPR3dnNFdUbY0XEBFnqlWNbCFilKh4pK+W0Rsf73huZnJR8ds09PI/a4fdMyPUWRvVBU2XM7wX6l1RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f4ljDAicz0TpqROzQVglgZ2r/RPQrN1v3Q8IyjTbmEM=;
 b=fbkmBUU0wo965PfI9/Eh7SN/54ddJ6PTqTVGj86jb8xqK/5I2muo0UjHaxIFyF8uOWwp9zQJFaluQoesVY7JeeWTKJ9cFa75d3cCzDegT0Nb77n7K52XIF/ehYTJcQLQxLEx/2xdNLXf3rFpcCxO820EdAUC1H/ULp3cGC30suM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from CY4PR11MB0071.namprd11.prod.outlook.com (2603:10b6:910:7a::30)
 by CY4PR11MB1544.namprd11.prod.outlook.com (2603:10b6:910:d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Thu, 25 Mar
 2021 05:15:59 +0000
Received: from CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::d4fe:8135:d8fa:81c0]) by CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::d4fe:8135:d8fa:81c0%5]) with mapi id 15.20.3955.025; Thu, 25 Mar 2021
 05:15:59 +0000
Subject: Re: [PATCH] cpufreq: dt: check the error returned by
 dev_pm_opp_of_cpumask_add_table
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210325043129.2255918-1-quanyang.wang@windriver.com>
 <20210325044541.rsncitrmkpaes4dm@vireshk-i7>
From:   "quanyang.wang" <quanyang.wang@windriver.com>
Message-ID: <2da8eb92-6082-35f3-b190-c7218edb35a3@windriver.com>
Date:   Thu, 25 Mar 2021 13:15:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210325044541.rsncitrmkpaes4dm@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: BYAPR02CA0064.namprd02.prod.outlook.com
 (2603:10b6:a03:54::41) To CY4PR11MB0071.namprd11.prod.outlook.com
 (2603:10b6:910:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.199] (60.247.85.82) by BYAPR02CA0064.namprd02.prod.outlook.com (2603:10b6:a03:54::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend Transport; Thu, 25 Mar 2021 05:15:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 888b0f14-c9fb-4c6e-e90b-08d8ef4d13af
X-MS-TrafficTypeDiagnostic: CY4PR11MB1544:
X-Microsoft-Antispam-PRVS: <CY4PR11MB1544A786C5BDA80761EE51ABF0629@CY4PR11MB1544.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 37+HWijyrMwYCU8hxemrJbBi574rSNvnZV6P1lJfjNuu/NBo6+0rmjGF/oBe1FxJeyA1cC99bMw4n50n9ZFsRil6m7wH9WPIjV2EHK01VyoGTvGTgAoC6gduhfNmRbrOPBd+Fd+6/T8Fxiu0gL1M7RNDDyPtTRhc4iVmAHoZlBXckrBqjnxffmEHXFogOirvKf8n1hKOvYTK2gr/Rb+ahU2LBAr8jThME6mld2JduYr+rNnTWe6Kopmv0PX8o4dgY5r7oUYT6SaRa2qd3zaVbPloi6rnn3KLK/GoychHxsaDOObNVyfVbhsrZbUCRx+81plNLuKHGCrKZZMuAleOeOGOP3G9Vj49OpV81PA5D2q/WBTf0Z4bcgePLKCirJRSVrgaKftqx1Jz4H8apSbXPRKCs8eJIr3d1BvrPjmL3cPmLtF4LxtcCjZhEGfOzJSSb/XDTI+NKztBsIaqzJ4yBd+tKHor9Sp/2720vNyBxr3oNdjmQKnjNm8kToAQFfmJLQ0PRbOYoA1c0a3xh13Oo92CciBXMlzLL9BmFrCFPplIPNcCRnyftoUgE+Dzj+ibJPTTJEGqB4b/EvU8meR8fSoeJ3KFyVCBFE9QqDSvy3LeSHC+rrZdXWrYZrBsJWyGtUgbMYPp4A2KChlzDxZyMKmHpMGta++84Y9t+6dWCjWdmTOb7nSIdLKS3ynVagBcKsXfsPBQZaUtHRKz+ID782PPhHwPp0vHNCgKW2DTadP1rk2dX+EPaZ4IRsARN+CE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB0071.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(366004)(376002)(39850400004)(83380400001)(2616005)(956004)(36756003)(8936002)(86362001)(4326008)(26005)(66556008)(38100700001)(66476007)(53546011)(2906002)(66946007)(6916009)(6486002)(6706004)(6666004)(31696002)(5660300002)(316002)(8676002)(186003)(52116002)(478600001)(16576012)(31686004)(16526019)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aUZqSWVCL0pRZGdBVG1zQlorYlkzNlBrVHVUV3BTSGFaL3VOdkJkbzc5d1R0?=
 =?utf-8?B?eE12eHVLSncxa2FkY09WZVhLT056bjRRN0V4THljdzRJRFoxUHY2TnR1clNq?=
 =?utf-8?B?YWlvVU82RkZLeVlYSnZFSlFOMk5na015SVBhTGtxTVkwRUVXZTNNd0poK2VY?=
 =?utf-8?B?MTM2V2l3aEE4d3NkRE81dkVvTVJDYmpxR1VOMVBuY2NKRFUzdnZUWGt0Tld0?=
 =?utf-8?B?M3Y3bnhlV3BUMlNQZ2F6TkFmeUJYV0g4dk55ZGJLT3p0eG1ZMlNOZy8xSEdl?=
 =?utf-8?B?RTNSdkoyY0JmNFFmNzVQSnp5YjRkYndxYndXbHJ6K1BzV2dkUGVYVTgxVGZM?=
 =?utf-8?B?dWZ0Mjcvd1dxN2t6elh1amgwTXBzTC9vUWxQaVNBT0l6eDA2YWdTa2xpVUJn?=
 =?utf-8?B?TTluRDlOelRGeHlKSWVGcnpTcWZDVkZzV0UwZXdCYUNUMndGQ0RydlBqb2lO?=
 =?utf-8?B?dUlVY1l5OFVpWXc0cnp3RUl6eE54Y3JDYjR1ekFEMEYrVWNzdkpUUUZxeDA0?=
 =?utf-8?B?aENzN2Yxc2ZxUURuZW03aUE3aklieXJyQUVGait2SXVPWmxvZHpRb0FHR2Fu?=
 =?utf-8?B?WlA1eHVobkVxQ2gvTzM0U1lhdmZNWEg0THVNWXFBZWgwdEhwSmlybTNCWncy?=
 =?utf-8?B?bUpOZVpoNFY2bEVkV083TWdYcjl0d1RYZThjMTdqOVdzZE5icWV4eGFhSE5n?=
 =?utf-8?B?ajZpRFJ1SDk3MXFCWWQyOFpJUDdZUkY3eWFtclRya1FoQ0VPRXpQdGFmR1lX?=
 =?utf-8?B?bmYzcHJhVkh0ZFo1REVNeEJFamxDK3REc2JzZC9EVEhxQTBCcWplQ0JFeWpJ?=
 =?utf-8?B?MTU4YUVmaTkvMjAwVmtIcG1acjlpZkdabEhZWTFiMnQ4TWRuUktxMU1YK21Y?=
 =?utf-8?B?MHc5QmxHSTJxY2dZSW9OTDNIaks3UEhvR1UxNXdSeU1LUUFsS1ZsYy8xUXJQ?=
 =?utf-8?B?a1lqQ3F2N3FkM3VHTFcyQUNIQUxaZWU5MGMrZFJGeEpUbzFBYUwraEwyTE16?=
 =?utf-8?B?QXBDTmRMOGFMdFhvK3FJRzMxeXl0Yko3cmc1OUlDTHlzVmJlMkhPRS9Sa091?=
 =?utf-8?B?K1VVQm8xZFVoTmVQTGo1dFkvdFNxTU4yZm9jaGpSKy8zMXNBMXB2YlhwQ085?=
 =?utf-8?B?SkQ3UE5ncDAvVE9yU1VtVEdtb0lqY0hlR2JXdnVERDJOak4rOFVLTTR2a3px?=
 =?utf-8?B?R0FiRGxTUlN1WFg2ejFybW5LQzJwUiswQ3hsNGJqVVNHeVh4UUdnckU0aEZi?=
 =?utf-8?B?alZHV1hjZTlPS00rRTVRZHVpRFRpVlB0OTNEc1E0aUZIY0V3b1FXMjBOQjl0?=
 =?utf-8?B?WE5xQUhoenQraG9KRzU3aTRha1pwMFJYTis1RUYwcGNhRFNXdzVWK0N3TFVZ?=
 =?utf-8?B?N0V1QkZKRGV0TFlhbUV0aTVwNmxQTm5CWlpaendUWW14VjJjeG1tOW4xRkY3?=
 =?utf-8?B?N0toc3F5TE0wbmxmZ0tNSXZDenZ5V1JVUVVKNGxmZnhSN0FZS1hYeXI0VHhs?=
 =?utf-8?B?YUdIYlNLUGZKSHpqVEhmalYzdXZRVFlEbGE3RFB0dVlVRUNsdmhPL1k1ZUxF?=
 =?utf-8?B?TExsL3RISHAxU0ZCeGkzbVAzR3NCcWN5U09ielJweFdidWRJRUxxYWNaY1A4?=
 =?utf-8?B?QmZXRFNNSlNSTUlzWTVnMTJHRmdXL3kreFlNUGszaldNVVpKdndsVVJzMjdt?=
 =?utf-8?B?S1BhRkFqelNLNDlrbkpvb1NHV2ZSdFUwN1Nib3NDWW80dEZpdCtWYUlWS2N6?=
 =?utf-8?Q?OpDD6BK1aIabmnyiKCNci+k07YYU8meVqx730gA?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 888b0f14-c9fb-4c6e-e90b-08d8ef4d13af
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB0071.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 05:15:59.5920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XoRX6At+acRU+AzjS05IFA529NDnD3U0kxg9EtJwlJX1yaW3lyuYUfxAyMwJaQoPiiap4qRpVPUoaON1793FAKAZo4wY2Pl/ZfYytu7s+vs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1544
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,

On 3/25/21 12:45 PM, Viresh Kumar wrote:
> On 25-03-21, 12:31, quanyang.wang@windriver.com wrote:
>> From: Quanyang Wang <quanyang.wang@windriver.com>
>>
>> The function dev_pm_opp_of_cpumask_add_table may return zero or an
>> error. When it returns an error, this means that no OPP table is
>> added for the cpumask because _dev_pm_opp_cpumask_remove_table is
>> called to free all OPPs associated with the cpu devices in the error
>> label "remove_table". So continuing to run the next function
>> dev_pm_opp_get_opp_count is meaningless since it always return the
>> count value as 0.
>>
>> There is another reason why we should check the error returned by
>> dev_pm_opp_of_cpumask_add_table is that it may return -EPROBE_DEFER
>> which comes from clk_get(dev, NULL) in _update_opp_table_clk. When
>> the clk for cpu device isn't ready, dt_cpufreq_probe should be deferred
>> and wait to be called again. But if we ignore the return error of
>> dev_pm_opp_of_cpumask_add_table, dt_cpufreq_probe will return -ENODEV
>> because dev_pm_opp_get_opp_count returns the count value as 0,
>> the cpufreq-dt driver will fail with the error log as below:
>>
>> [    0.724069] cpu cpu0: OPP table can't be empty
>>
>> Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
>> ---
>>   drivers/cpufreq/cpufreq-dt.c | 12 +++++++++---
>>   1 file changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
>> index b1e1bdc63b01..f24359f47b1a 100644
>> --- a/drivers/cpufreq/cpufreq-dt.c
>> +++ b/drivers/cpufreq/cpufreq-dt.c
>> @@ -255,10 +255,16 @@ static int dt_cpufreq_early_init(struct device *dev, int cpu)
>>   	 * before updating priv->cpus. Otherwise, we will end up creating
>>   	 * duplicate OPPs for the CPUs.
>>   	 *
>> -	 * OPPs might be populated at runtime, don't check for error here.
> As the comment (which you removed) clearly says, the OPPs maybe added
> at runtime, don't check for error here.
>
> When we say runtime, we mean someone may have called dev_pm_opp_add()
> for the devices.

Thank you for pointing it out.  Do you mean that even if 
dev_pm_opp_of_cpumask_add_table returns

an error, dev_pm_opp_get_opp_count may still return count > 0 because 
someone may call dev_pm_opp_add

to add OPP to cpu succcessfully at somewhere else?

Thanks,

Quanyang

>
>> +	 * We need check the return value here, if it is non-zero, there is
>> +	 * need to go on.
>>   	 */
>> -	if (!dev_pm_opp_of_cpumask_add_table(priv->cpus))
>> -		priv->have_static_opps = true;
>> +	ret = dev_pm_opp_of_cpumask_add_table(priv->cpus);
>> +	if (ret) {
>> +		dev_err(cpu_dev, "Failed to add OPP table for CPUs\n");
>> +		goto out;
>> +	}
>> +
>> +	priv->have_static_opps = true;
>>   
>>   	/*
>>   	 * The OPP table must be initialized, statically or dynamically, by this
