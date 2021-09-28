Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5974441B936
	for <lists+linux-pm@lfdr.de>; Tue, 28 Sep 2021 23:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242911AbhI1V0E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Sep 2021 17:26:04 -0400
Received: from mail-dm6nam10on2049.outbound.protection.outlook.com ([40.107.93.49]:30275
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242846AbhI1VZ7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 28 Sep 2021 17:25:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kglsXmvjKNvE0sdgPUBG/cxOTaHN69XxXoyhENSRUOrvjbgXqPoAAfbcMaOe25y04eqaST7fZpx8AMULMPtHpfPJI17/deHpe0aljGSbNH122CUF4WXITN1U/TCvYR5VkdtUD21D8SfePrZcMimDeRhEFkoqjDt0qooi2mrtGY8gRga4JRqAgmNJq0W3vxb77P0ooZHTI8RE+wduCl6wk/bHlAITizJjQPiGkFFAKclpD0FnxDbgIA1YMIMVrSqKU0nf/hGE3GqslSkYbkg8HI1zoi5lo26WtddnnAShVJB6Ffo/0IpDxEkbP/qyTxH4D9QF/MumWd+l5PxFUWPu7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=V9XkwqlVzy2JF2lQz8ZnyYHmavLIcbA177ctYOVkgcs=;
 b=k9xmVpR1z08LyI+NqskVO426YZJC9D4j3BRKtfviyMUaImdIFQXyK4s/UtfU7T5dUlXhQt9AaPdG0XVbdLptR66NWRAAWy5ws2XsIDdx0NXTaNcQ7BuXUoau35j4ay3pTa9LN+XKe0ssOSKooAMs9qRJt+TvcdyKIa4wnCrM+bOJgr0bHq5TnBeyXcSzrxjJccOSEV1667/FXOPPpGA55cWXmIwmmLl9bt+o6ZnUdS3zJVg0Aqab8bNlwScK/Se9lcPxqNrXWvlIZp5zqL+NtT4FOw6I3bot0TMW5C7493R9AQp+hcR6huK4eRwOG2An8eTxT17Q4gdkN9yTgY/rww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9XkwqlVzy2JF2lQz8ZnyYHmavLIcbA177ctYOVkgcs=;
 b=r2yymv8hKf3M/8jIHK6b2HZh24cylyoK15OzD3fOTZyzdG4Hvgt1mRFU6BNJM8ZE8YnwCUuMGCefo67N6C74A0wlGoVPoTBVYMNJJTiVtwCxmTJ8nQD7/5rdLuhp/oJYVCuFCbJMg7iXB1QPfxjExN9QCIAEYjExFII/OC7K/9U=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4720.namprd12.prod.outlook.com (2603:10b6:805:e6::31)
 by SN6PR12MB4719.namprd12.prod.outlook.com (2603:10b6:805:e9::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.18; Tue, 28 Sep
 2021 21:24:17 +0000
Received: from SN6PR12MB4720.namprd12.prod.outlook.com
 ([fe80::e134:658f:3a82:f750]) by SN6PR12MB4720.namprd12.prod.outlook.com
 ([fe80::e134:658f:3a82:f750%4]) with mapi id 15.20.4544.021; Tue, 28 Sep 2021
 21:24:17 +0000
Subject: Re: [PATCH v2 10/21] cpufreq: amd: add amd-pstate checking support
 check attribute
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
 <20210926090605.3556134-11-ray.huang@amd.com>
From:   "Fontenot, Nathan" <Nathan.Fontenot@amd.com>
Message-ID: <93e1079f-7450-5c5d-f1f8-7d607899343c@amd.com>
Date:   Tue, 28 Sep 2021 16:24:11 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20210926090605.3556134-11-ray.huang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:806:20::25) To SN6PR12MB4720.namprd12.prod.outlook.com
 (2603:10b6:805:e6::31)
MIME-Version: 1.0
Received: from [172.31.10.217] (165.204.77.11) by SA9PR03CA0020.namprd03.prod.outlook.com (2603:10b6:806:20::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend Transport; Tue, 28 Sep 2021 21:24:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9c70040-4b86-4d0b-0e43-08d982c653da
X-MS-TrafficTypeDiagnostic: SN6PR12MB4719:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB4719EB0B3D1A275E9D614B08ECA89@SN6PR12MB4719.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E8iWVz5hugUt6Ag163LDys9pFp3bPxdPQ05IRTbALCGtTxD007O/z+ce7PEpPID2U8GN5p326rr0F+X5EK4laTLJlVWvs3ANclvnY4Lpt4i+3BwwH5HRrgBws/F1mvG+R0YPvu23p7XaXWt4ZbpwooDCPIaPnJ9eU52GQPx9a0ZCdLk9N4X0WwY/u0J/TtTGAvaJMrBNe6qSISpTFW0CgQEMeYFnJAwK1KDuHh3ub54lOsWUKChhJCeL4teHMvm3GSvCdZWVONTkKCVWp1TqaKWDqUeaBBUgI3VYMjgmw1SnqmaN/ZpZT/LKJTF9wq+mLj71jJwIkKffQK/DzWmEWRBYCOwB/LzWEPbrS/iVcnlzCpzxlLdNK8MYCMxDMO/is0TIG13a6TBMZQX6thPmxDvxusKfu4dDBJ5J2uHHOf24B/LFxg37xFbSPl7TcVpOD3qkY1+xU29bvy6/mM0wGa/VmlVDMIQIYc0fKoTosGnHA1vD5HoyJEGvviXDwJ5Ma+DRa+mVWwhw12qVYcsAHT+zqx7jVUYdUfGvrUuiGGZ6MYZCo3I4MYnWNQKYq0FhzHn/sDV4G8eAdFMZRT6YOm60sv89R3HxPYqY7u+go2qE0qoGjPrVb+XaOKGOZJaH/jaMj253SbTvIp+pdraz502WZ1Qh6HoxXMjZoYz0YVSdm9cJUrRrI9hX5qtwbAVCkYdv+wfu8cTAKrtZzve8xWCzXQpxTCyA6RQSWL7L50A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4720.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(66946007)(66556008)(2906002)(186003)(8676002)(4326008)(5660300002)(8936002)(53546011)(31686004)(83380400001)(36756003)(508600001)(956004)(66476007)(26005)(6666004)(2616005)(31696002)(316002)(16576012)(110136005)(54906003)(38100700002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VE1DOUczbUtEOTJCelltamg3cW1oRDd5cmYrYlRSVXpQU09xNEw5VkdrNnNt?=
 =?utf-8?B?aXVMcUtPQWpqQWR0L2ZCOWxrUlY3bTRwNzFSVXVXTjFDRWZlbzhjMnI0RVhw?=
 =?utf-8?B?a2FsNnJDQjhSekp5Ui81Q3hZcVRmRG1rTmdQUm9jWlBpSjhnSGtMQ01kRnp1?=
 =?utf-8?B?WkhIUFp5ZWNjOFhlcEFqSFFRMEZia2Y5cUg2T21rNlA1NUF0OHBBb0Y5aHd2?=
 =?utf-8?B?c0hjWnRMakFFTnRFWldDbFJ1MXQzalQ2eXlaclJCR0pYdTJyNUF4azNEWXE1?=
 =?utf-8?B?clR0MGJpQ0E4L1ZPWW9nQjg3dUZmZDNLMjFjMXhwMW51OEJhVkl4Rm8wMDJX?=
 =?utf-8?B?V0FjZ2c4ZFlvbzd5ajFTclJwVmFWa1JlUmg0UGdYSGdDZnVLQTh2NzhKN2c4?=
 =?utf-8?B?SHB3QzVKKzdNWGk4QiszRVR4N2d2WTlIaEpNNVEyZ2pwRDdrZE4zTGF3bzA4?=
 =?utf-8?B?NmVyNTIwTjJXNVU3YTJsdzhTNVBCcWFSaGU0WUpscURLZXM0S0VWVmtpM1dY?=
 =?utf-8?B?UDhDdmE3cFNPOHBNWUZnNHdYYm92eTdBOS9idjhveG5vd000TXNsb0F1VGtk?=
 =?utf-8?B?emJVWnhIazBSSDBZam8vWGdsWEU5NitSWll1K1B3QmVpZlhvb291ZEZEdnNV?=
 =?utf-8?B?bHhiZFNIVGwva002VDBhcC9Ma0RLTHRCMDRNUG50TWVzaXRyNHlrVW5wN3dl?=
 =?utf-8?B?T3J2VncyR29NUVVLUDNwZVYzdFczdFRJR1FyOWt2TjUzaVd3MmdOM2diY3Z6?=
 =?utf-8?B?dWJlMWEvbmVGS0k5aU1ZazllWk5XaDJCZVUyVUloVjJkR2hOMFJZUnRha2xP?=
 =?utf-8?B?Yk9WeWVvRXJvVjNncnUwWVJCOVZrLzRsYm9SR1RYM1c4aHhSSHE1TDFER3Bo?=
 =?utf-8?B?WWh0NkFoRTllSUNqeFo4OWVNNFZIUSs1NnFyVUJCSFU1dnJWMGZKQ09Ba2x3?=
 =?utf-8?B?bm1aN3d4eDVsZkpxM0FDQjUvSmVSY3JubHlGMU0rQWpQNG9yWXVjeFZIUFov?=
 =?utf-8?B?YWVNL25iNzRKY211bS9OWU9UVUl5aE45cE52eWRPQklBNzlidXdWYjdWdjhh?=
 =?utf-8?B?aGNoUjlIY2VGN3VJUlBKRmdaRU5XUjlGMEZKazZmSUs4dGpVNWdEV3ZtZXh6?=
 =?utf-8?B?WFhLWjdNYW1DWjZlR2U5bEJiNk1lZmlKRlJPRlVxa2E1eUJQWnByV0NzVU42?=
 =?utf-8?B?VEZ5R09yNjVLYWhEbHZIUWE1S1JUcUVTK3E1RDUwekZBUHlvaHpLeU9hUlc1?=
 =?utf-8?B?OG0wZ0t0Q0RsQktJYUhtc0tRQmRSV3ZCOVhabjh5YVlYVS9PWmVHMU5JaHJS?=
 =?utf-8?B?UFJSU0QxYVRJeHNvbkNEa1R1NmdrNHZ1dy9kdjBIQ1Y2WmpBbjkvRlVmT25G?=
 =?utf-8?B?bkw5aW83UWVWSTdWOUw1UTdXWTM4dHY0YVJyejJwdjVod3BNZEdMM2w0YVlI?=
 =?utf-8?B?eVRnR3NZWHo3ZHVGRThXWTVwQis4NmNvejhVSWJ5K0lKb05wM0lLT0tpdnZC?=
 =?utf-8?B?N3ZFMm1oTmVaR05keGtLVTZRTDdQZTNmUC9sSmlmaUVLUE8ycUpkaVBYRjlB?=
 =?utf-8?B?SEFZaEh0ZlFkZDh2cXFnOFNodFlTS3M3bW5SUElvbWlQYXNuU2VUbGFsb0VZ?=
 =?utf-8?B?bmdEWDZsTSszRzU1L0pnUVMyTkdZN1NCU01JVnpMc0krbGo1aXJqYTZKdWZy?=
 =?utf-8?B?VWlGbEVyQ21BTE51U1U3NHk1UzJUYzNsMWRFemNCcytoNXdZMXFpb0dtSDRo?=
 =?utf-8?Q?vhyclXg9FXftJGET4LZJSuL+JHWG44hqEPPSIki?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9c70040-4b86-4d0b-0e43-08d982c653da
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4720.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 21:24:17.2959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hTolr7xLWpPnIlF4V1dtnz9flP2rMYukKx+GgQkoCcNhF4X8LWrlQmPsOM9MORxydCgMmJ8eSamuRemIF9V8aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4719
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 9/26/2021 4:05 AM, Huang Rui wrote:
> The amd-pstate hardware support check will be needed by cpupower to know
> whether amd-pstate is enabled and supported.
>

Is this needed?

If acpi_cpc_valid() is false, then the amd_pstate driver would not have been
loaded (see patch 5/21, module init routine will return -ENODEV). If this
driver isn't loaded then this sysfs file won't get created.

Shouldn't the cpupower command just check the scaling_driver in sysfs to see
if it's amd_pstate?

-Nathan
 
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 847ba00e3351..74f896232d5a 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -517,6 +517,19 @@ static int amd_pstate_cpu_exit(struct cpufreq_policy *policy)
>  	return 0;
>  }
>  
> +static ssize_t show_is_amd_pstate_enabled(struct cpufreq_policy *policy,
> +					char *buf)
> +{
> +	return sprintf(&buf[0], "%d\n", acpi_cpc_valid() ?  1 : 0);
> +}
> +
> +cpufreq_freq_attr_ro(is_amd_pstate_enabled);
> +
> +static struct freq_attr *amd_pstate_attr[] = {
> +	&is_amd_pstate_enabled,
> +	NULL,
> +};
> +
>  static struct cpufreq_driver amd_pstate_driver = {
>  	.flags		= CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
>  	.verify		= amd_pstate_verify,
> @@ -525,6 +538,7 @@ static struct cpufreq_driver amd_pstate_driver = {
>  	.exit		= amd_pstate_cpu_exit,
>  	.set_boost	= amd_pstate_set_boost,
>  	.name		= "amd-pstate",
> +	.attr		= amd_pstate_attr,
>  };
>  
>  static int __init amd_pstate_init(void)
> -- 
> 2.25.1
> 
