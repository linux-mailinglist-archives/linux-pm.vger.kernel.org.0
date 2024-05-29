Return-Path: <linux-pm+bounces-8336-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CEE8D2DA5
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 08:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 703271C22961
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 06:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5D316133B;
	Wed, 29 May 2024 06:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="bIoDEBfW"
X-Original-To: linux-pm@vger.kernel.org
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2036.outbound.protection.outlook.com [40.92.98.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259A815CD4C;
	Wed, 29 May 2024 06:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.98.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716965659; cv=fail; b=Df5Y3wPEaaNrIF1c/pRHo736s0AI3ciR8oCu1VnLfezrTt6GdpYQQHhhOoIGxZtv9ixwaUampIlcXHWkYCBtcpQdprgaSf5PI2BRduphu+Vc4/LutVeShb01QalgJ+EBKjq+MKOXzIUnHN0KQeK8btZP5Mrrvu+r3ZR1ynUEmW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716965659; c=relaxed/simple;
	bh=Q9zxIMyciiB0tr1jX5wiE07pgDBEcY6V+CuNRU1uB7I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KFLK8SfLN+BdJeDFrn1xovpht4hn2NgxwZQ5k6aiv07Pecbaxg21xE3cTHGPZ+CB643veTUrqjHX7xgNhHewd7ta6IOP0a0MbHo42ZaXuoApdaTZ9SPEmxx9zlPotIBrEjYivcwKpfnizr01NHYcNucSYmnWnbYQ1xdWaBs45iI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=bIoDEBfW; arc=fail smtp.client-ip=40.92.98.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oNx6YIh0dRcu6Ekn54/ylvBEGCfholshQEfOWj5U0mqDQVw02sEGNNNV7VmuFB2towsjdOeA30mOyAqwvm1P6iH/Ewudsgs2Tbbo3XRGfOw9B6PG5WepBtcqn/SKYhkdUeeYRRH78OMZMl+AiONhGbb1KjRoKjjk9Z7AJLpPqNsoJledxpdQ470y6Sqioio4GbEZJYB5hGaLOksXM6u8gq74QT70U+SvCU7pXjApsd8fsLkTNeZHbbwbOhn6YM4t84ipTGJqDiqSGgLGIEj1xNleturupmvMLYunhj8DNidmSunai0woROGLOqB5WLhBCtm8+Ltt8V/9jXtlutsXFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KPJTzzu/t1pYizWWMuQGSEH2N7dG+jbX1FboLzjMOWY=;
 b=VryWZi2jph8Jpiy0wgh4o/W7qDZv78Mpg1oDPxuAd76iMDdsM/TbWuw+IhE0Cfh9yDgq1NwTvz67b9ZG60JYC+Gn1WcJE6vsP6YTCCXlKaiA9yVFVig/GUgRirS2FrT1PtW7OG466RmdbLmm+yqYc+qC1GhwWEQDxLEVQw/OG9XtMa0aJVhbZxUfksM3Q+flM71aBkrMVY53JZtcvVk/KVcOko9ABMRXjvMu1Um10eVP6a8vFVc5QndvnOvHXoiHkma4xBl/rRa1ZIc5uhLO25ckXlMMBSvJB7/jd+lNFpIii5HozwYvddNLw7lcyGmcPvQCba2+2/kYfHWT5sbG2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KPJTzzu/t1pYizWWMuQGSEH2N7dG+jbX1FboLzjMOWY=;
 b=bIoDEBfWy10WCzfX7lxjkod1WbVCczu3dFXHoeOOWM1Y2ilqkKqUuiMqp6VyIu69Dxt8ul4wQwg5LnPUq3YvwsRmw+ySd6zEdPVhAii0F4XClZilniLpaJhelB01mARGzIDOeZkCjGppUWhw945w/eztc47tVSLCQQY8rB4sS8cF8RRztH7fqpzxvn1Uis2jlahDEJiphFTk2OhNE+r4XgntjmhWwMcBg0MKfPzpHsrkNgxNDKovUllfD0bjF0G1F0IEXOY7c2BrExAWptsT86SqwVYc0la9GUBxGEt15WqN3rKM+lkPhyzq3l/FaMs/Whjb73ceE3bGvXfy7J2Xaw==
Received: from TYCP286MB2486.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:221::11)
 by OS9P286MB4255.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2c4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Wed, 29 May
 2024 06:54:14 +0000
Received: from TYCP286MB2486.JPNP286.PROD.OUTLOOK.COM
 ([fe80::8048:573b:c353:1c19]) by TYCP286MB2486.JPNP286.PROD.OUTLOOK.COM
 ([fe80::8048:573b:c353:1c19%5]) with mapi id 15.20.7611.030; Wed, 29 May 2024
 06:54:14 +0000
Message-ID:
 <TYCP286MB248669BCAD7A7E54C5071EF9B1F22@TYCP286MB2486.JPNP286.PROD.OUTLOOK.COM>
Date: Wed, 29 May 2024 14:53:41 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpufreq/cppc: Take policy->cur into judge when set
 target
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Riwen Lu <luriwen@kylinos.cn>
References: <TYCP286MB24861BA890594C119892FB3DB1F22@TYCP286MB2486.JPNP286.PROD.OUTLOOK.COM>
 <20240529053652.pzcjoyor7i23qc4i@vireshk-i7>
Content-Language: en-US
From: Riwen Lu <luriwen@hotmail.com>
In-Reply-To: <20240529053652.pzcjoyor7i23qc4i@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [LZitFs6A8tzJQQsQMA8rUK7BpxGEp3HY]
X-ClientProxiedBy: SI2PR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:4:197::13) To TYCP286MB2486.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:221::11)
X-Microsoft-Original-Message-ID:
 <8c6c40d7-85b0-431b-9429-069c47a44d8c@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2486:EE_|OS9P286MB4255:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bfb21a3-2621-4411-3238-08dc7fac26b8
X-Microsoft-Antispam: BCL:0;ARA:14566002|461199019|440099019|3412199016;
X-Microsoft-Antispam-Message-Info:
	3eSCsCaDahFxJKYelFD9FK/Btqo9zE0oh4X8mZO8Qw+eQ2JtqaY2IAOCd2rQUr/UYMlmCpwRTxEXhtYUEz1Kuyp2Pe8QYMc0jF7UOrR5SMRmOnlHdHjxYG/S9gW7qfKchQF7HxzcZwGwITWkYhMv7EwJUZU+hAXnLOT6DauNcP9iLbJjRe6t/S5a/TmG9fzNZ6+u4LsJF3aRXiS/gE++5DVJHWezQYgFLxi34qnt7nICOub3VcWKFd7HzgrFnFMN3TvOVOVfXDxdSfQfd13x1jwum+yl/7b7fdI9LQ/769rDb/BdWqXL/f7vmvx552t66pe/x0FmGNVyvbc8P1Cfho2qnIJE8NYerkMmIaco2xOhDyNsIBsFhlXX+s59tSB5Ur9UOLxnPkSKlVv8jYgyrIet4STPWdtHcae3hWKXZMdvPWBdofkahgC99kVvqEKWGTc6INxo4s7eLCmDl9Mh3tv+71S58Wn5psvsK0f16MqV6/s/L/6hLZK1ZdxeGoWB0HnuQ4swxP825O5dJu+69uzfUujdrJ/+kikDU/GKrVlkoDryRjQopBg3Wx+D8Ho1
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?REVlTjhybDM3VCtxcWNMbWp1TUR2eitteWpOWStEQWt2ZkNMMFlrQy9hZWdx?=
 =?utf-8?B?dUJWQXB4ano4eFhTWDFoR1QwaEFNNWVEU0hSR1N6a2gwalVidnlQM0YzSEZW?=
 =?utf-8?B?MEZBSWlzSXowZTgrMlNHd3BSRVBMWm10eElqQW5LWlhydkJtbmRSSm1KQk5n?=
 =?utf-8?B?RmgyTkgzb3d6eXQ3c2xwVjh3NCtzaHU0ZDZyYmJpYlZiMHkwUC9MWDZEM1NB?=
 =?utf-8?B?R1QzYnlBbFZIa0I2L01hd1NhaXRZNXBTNzM0Z040Tzc3cExjSWg1RmxWdjl5?=
 =?utf-8?B?dm1sRnBmWmxKZDZXNWJkb0xoVmh3KzZGK013cVp6OU9hbUdPM214V0tMTDVs?=
 =?utf-8?B?NDk3YWVUWExFYUVnSEVTSlBtUklEZjVBT2VKT1g2WnRiYU1WMGFseGZpM2hi?=
 =?utf-8?B?TkRsSmdFbXc1QW9BOTFRNVpUSE9NdklqUGg3TnI2UGl3eHR4N2Nhb1BnbVhl?=
 =?utf-8?B?eW40em4veUpHS0hPcENiR0ozY0U2UTdHTzAzUmV1NnlsODJCRUhkdWo5a1dK?=
 =?utf-8?B?dmFlR214ejZ0N0h0WU9YWDNIYVdTQnN3VlM2eEhoVmFQcE9vRVJuN3RTTktz?=
 =?utf-8?B?T0xFbHBtSUNvTzZwelNrOFBCUldQblQzenFaKzBwYjdRUWNCY3lRcVFVMG9J?=
 =?utf-8?B?Yk9nRmNWTlM2SGRIY0Y3ZEpJdCtyUGtVRWdmclVlRDV2L3lvdG10SVhmRyt5?=
 =?utf-8?B?M1lIU3JYekNpc3JUNERtcHh1b3dDYk1rRkdPWkxlZUFRZFJJZ2h6RnRNRXFR?=
 =?utf-8?B?aFdPRWgxUW9aL3ZEalFsNHAyT2ZWZzJWWGdneFZINHJ4aHIrWjFFeGxYM3I1?=
 =?utf-8?B?cmVwaFRXWGZ5STB0cVYwcTFSa2lTZm5mZTluUmJtRUZ6RDdCL2RpRFhxV0Vn?=
 =?utf-8?B?ZzI3aFdpdHFvdHJiajRIRnlmZUFSZC84V1hSS0JjdVZuUlJObEFJRnhmQzhz?=
 =?utf-8?B?Q201Y3NJK251RHFzeDVjV1dRcVNwOC95Vy9LUld4UTJZWGF3M1p2QUpWVmps?=
 =?utf-8?B?dGdvZVBRdE1PWmtYZkJsTE9sWDUyVlA5aU5IQnJ1ay9iK2tMcjgrR25zSk1W?=
 =?utf-8?B?T3FvY2Y4SWhSK0ZXOENsWXFIMDFiem9zc1VENlhYNXNValBBbTlKYmlmbzhB?=
 =?utf-8?B?c0JTU09wSHN2V0ZrQWpod0ozaHp1TFg4MDV5TFQ1NXppNG1BTFJWV2lQZ1Fj?=
 =?utf-8?B?Rmw2amt2VU5mckxMazJ0dTV6VzljaVhxR3I0elluV0ZxZXV2QnhYT0EzS0Zl?=
 =?utf-8?B?aHFtRkdwSWFKQ1gyN0JqZGRWZENhblF5YS8zZTB0akdCbFJSREJ6Sk45M2FJ?=
 =?utf-8?B?czdDb3dwMnVRNEJFeDRGWkdPRnprSXFydVVlUnZSRXJxN2JrRGFNUW1vRXdH?=
 =?utf-8?B?STY0RGZiYjJhTGhBcWh4MkhnTktWaExVWFhNOWNTbWtseWFnVVA4MDhRRElz?=
 =?utf-8?B?aW9XL2FUQnllVjh6V2VUR0NpSi9OVHZJZ2R4Y0swOG93VkFoNTdhalJBenQ4?=
 =?utf-8?B?U2lOcmxzcEswZ0lxbzBvL3ZrM2xTNmlNNFpVdm9LSVNwc21CdWJOY2dLRXZC?=
 =?utf-8?B?Y3U4Qno3ZlM1ck1YQmNHclJuNGNSNi80Tm1UczZ1MHhjRjh3VGF5YiszZlJp?=
 =?utf-8?Q?viBj2FkkJbu83Wl3RbNk/IqOAmjv0K8msPqxFkgY3oM0=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bfb21a3-2621-4411-3238-08dc7fac26b8
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2486.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 06:54:14.2828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB4255

在 2024/5/29 13:36, Viresh Kumar 写道:
> On 29-05-24, 11:22, Riwen Lu wrote:
>> From: Riwen Lu <luriwen@kylinos.cn>
>>
>> There is a case that desired_perf is exactly the same with the old perf,
>> but the actual current freq is not. Add a judgment condition to return
>> only when the three values are exactly the same.
>>
>> This happened in S3 while the cpufreq governor is set to powersave.
>> During resume process, the CPU frequency is adjusted to the highest
>> perf. For the booting CPU, there's a warning that "CPU frequency out of
>> sync:", because the policy->cur is the lowest_perf while the actual
>> current frequency is the highest_perf that obtained via
>> cppc_cpufreq_get_rate(), then set policy->cur to highest_perf. The
>> governor->limits() intent to configure the CPU frequency to lowest_perf
>> and the governor->target() returned because the desired_perf is equal to
>> cpu->perf_ctrls.desired_perf leaving the actual current frequency and
>> policy->cur are remain the highest_perf. Add a judgement that if
>> policy->cur is the same with desired_perf to decide whther to return.
>>
>> Signed-off-by: Riwen Lu <luriwen@kylinos.cn>
>>
>> ---
>> v1 -> v2:
>>   - Update commit message and email.
>> ---
>>   drivers/cpufreq/cppc_cpufreq.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>> index 15f1d41920a3..802f7c7c0ad8 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -296,7 +296,8 @@ static int cppc_cpufreq_set_target(struct cpufreq_policy *policy,
>>   
>>   	desired_perf = cppc_khz_to_perf(&cpu_data->perf_caps, target_freq);
>>   	/* Return if it is exactly the same perf */
>> -	if (desired_perf == cpu_data->perf_ctrls.desired_perf)
>> +	if (desired_perf == cpu_data->perf_ctrls.desired_perf &&
>> +	    desired_perf == policy->cur)
> 
>  From my earlier understanding, desired_perf is a derived interpretation of the
> frequency and isn't an actual frequency value which can be compared with
> policy->cur.
> 
> Shouldn't we compare policy->cur with target_freq instead ? If yes, than the
> core must already be doing that somewhere I guess.
> 
Yes, you are right， I didn't think it through. In this circumstance, the 
policy->cur is the highest frequency, desired_perf converted from 
target_freq is the same with cpu_data->perf_ctrls.desired_perf which 
shouldn't.

