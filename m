Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3CE4468BF
	for <lists+linux-pm@lfdr.de>; Fri,  5 Nov 2021 20:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbhKETCn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Nov 2021 15:02:43 -0400
Received: from mail-dm6nam11on2062.outbound.protection.outlook.com ([40.107.223.62]:2016
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233172AbhKETCl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 5 Nov 2021 15:02:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GN2ERHBroIsz2+heFcy3KmQamIOsCwodin0n2CI2zezySo07UAaj8CEBb58CICUp6dyL9pjbA4AFea3+CBjtVUBEf32E/VKEiRu2EOabhMcOzV+Qc5G+gDKXmkIgFdpB94ADWscqKiL5/qZOLRxKV6tGsFbkIDZKCl/2CnfE6nkcAK71EUXoeAWTsWRNlXkJDzFaHprbwkYk1zUUvvMCzVZ07vqXkepWcEdZkudr6E55e8bo+ra8DZ0ontah8eCDKzKH4cYEfizcfAl2GA/dh/l3hGY/986YzoU6BO3mjVcHYcJLUbSU7h858+7yOdWvSIGTSM33b4BFFwhtOE0R6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YO3jW5UGO3jTwT1zRqy6iYCaOW75+BKWpRIAJdOPMGg=;
 b=T5VBl5hcZpkFXYKwLEzYdMAWqwiJAvvppdD/6BqXBG8jOCZj8fxao0YZXelRTDKGy2+2PKZ4kRljXJshbbUja37jWA6gvnh6y2cgsn715ojKqeakatnUIjfbA5VTa/ntLsUMS3S3U38HX/5iBJX1vqdzy4wdMrcmwJ0JohjnwsMRhPWcjaCHV1e7iOH8vHEvtExzBNayAP00Aod0RC6T0S1I7vCXcEp1//u2GNgPk5xMpwrwmSrfpZefwmCKt4JBXipMwkC2H1+ZDe97caytBlazawilFPbPsPyQWbAIBJ92uP8+yKbElzuPLlPuITkAPcm5/1ycBOGsMnCgCyQCnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YO3jW5UGO3jTwT1zRqy6iYCaOW75+BKWpRIAJdOPMGg=;
 b=4GdDwHNtSiu/ESzVttly5VlR3FSp/SofiEsDgpOstm0zY1drKb+JoH/3D4ovG6ye/4JgMXCiAs+obHEam2WubPvQ3Hlpx+yhpMwPRs0k8X+ZedRQSqzVDc5u84ktJ8bk6ViRLKyUkO28pR5X3DJ1N22gJq7HB4ypZ/wNpl9+M7s=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4720.namprd12.prod.outlook.com (2603:10b6:805:e6::31)
 by SN6PR12MB2798.namprd12.prod.outlook.com (2603:10b6:805:69::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Fri, 5 Nov
 2021 18:59:59 +0000
Received: from SN6PR12MB4720.namprd12.prod.outlook.com
 ([fe80::c4b9:b9bb:e863:af39]) by SN6PR12MB4720.namprd12.prod.outlook.com
 ([fe80::c4b9:b9bb:e863:af39%5]) with mapi id 15.20.4669.013; Fri, 5 Nov 2021
 18:59:58 +0000
Subject: Re: [PATCH v3 11/21] cpufreq: amd: add amd-pstate frequencies
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
 <20211029130241.1984459-12-ray.huang@amd.com>
From:   Nathan Fontenot <nafonten@amd.com>
Message-ID: <b4a2b9df-1074-dc86-be76-7f47af202b9e@amd.com>
Date:   Fri, 5 Nov 2021 13:59:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211029130241.1984459-12-ray.huang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN6PR11CA0057.namprd11.prod.outlook.com
 (2603:10b6:404:f7::19) To SN6PR12MB4720.namprd12.prod.outlook.com
 (2603:10b6:805:e6::31)
MIME-Version: 1.0
Received: from [IPv6:2600:1700:271:b60:ca47:7240:2ff:8536] (2600:1700:271:b60:ca47:7240:2ff:8536) by BN6PR11CA0057.namprd11.prod.outlook.com (2603:10b6:404:f7::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend Transport; Fri, 5 Nov 2021 18:59:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de0142fa-fd83-46cc-cedc-08d9a08e76b4
X-MS-TrafficTypeDiagnostic: SN6PR12MB2798:
X-Microsoft-Antispam-PRVS: <SN6PR12MB279897E0755A78500BF8F43CEC8E9@SN6PR12MB2798.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ynA2H8UgXzH7jfz7RRZAjXHcoPu46LMPJd/YcOxBlsgpmln2G+YjfWbl67IWy08rPklMYI2RCaSl481RNBiSStD25Qx5ORAMn4yH4alguHnDRYzXV0c1VbzDTfCdd8+Y2ipx88APUD2J2cXF+tesyUAzhBEHPMgwXAAOGX/ZrROgDL6Oh+ib4pO7ygaqqCBIIbLGjtSzQ4pHjxnKm/Tx9QneRtu6YvdGiUZB+i4O3L2tyBdmXdqECQddrmkg0cSnlC9COLqIODxajN+VyMPh9sCTtP7kqEQ2KBk+ePcsNPPnzaMpXM2tbqdxiDKCPWEHmWNtw/EiJ2dLJOFwJDPruKmR4xngFtM+cWDgwLTpbCZ5J2dY//JJ+qlZNc+pSun+EBmWfO89y5zEwuW3Rd0LuPVp1hz/ak6D4fcfvQE4Gt7olZAvznNxXPUU8JQ4DHB6jTr37XXoZ1btX5+8p9yBbE9vN/1QwQT/6XMK0U+dO9UEBKy1wgmn89r1UmwiiYQ+oIOC+9tROIHlfuZuJDgdIB430do2y54wQrCaK+MHBaX/jznWkf9DdCM2PexaTf1z22HfpIJ441Y5xv+rN6bNUT+S8TSu8UZvjrImX+LXXWm8cCyNsUmZVM7whKVfkF+Rcx1eWXZ7S1z4w09GMWZM801vVRSd7/smVxhcivIjvaphsCVdDJFH2nc1AaaONLFEZuoOIfAcVhIFFqL0GvX/VGyMJThxws67vEsu4yJ+xkCduCrfYHCubxVhkLgbU2TN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4720.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2616005)(8936002)(54906003)(110136005)(83380400001)(53546011)(316002)(8676002)(5660300002)(508600001)(38100700002)(31696002)(4326008)(7416002)(66556008)(66476007)(66946007)(2906002)(36756003)(6486002)(31686004)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2c1RXJTbUtkWUk1bHV1VDNqcDRERE1hTGhUTlUvUEw3K2Jtc0tseUZUTjdS?=
 =?utf-8?B?aUhGMUVzaWNhZE10Y3R4L21jREpqQ1JQU2NCT0ZQTzNOdFpPMW1mUWoycjQ3?=
 =?utf-8?B?NnQyRFFuMkpBTjNnRGFkbUtpcUc2RmM2alNVZWpsU2E4L0FJNUp4SWx0b2FV?=
 =?utf-8?B?cVB5d0tnYXlSb1AzeHdwV3dXdGhSK3loUWYxNDRvZy93dVdNN3BRdSs1cUxN?=
 =?utf-8?B?QVBCaytTMG1LeFd3elUyWjhwSElaNCtZZVZMVnlpU2JRMllNMDYva2hGa04x?=
 =?utf-8?B?am1JeGdBNCt3N2FhQnhzRjgrLytpT2xhYWFlaHlteU93bGhMMlJFMTFJd1FY?=
 =?utf-8?B?eEU5UXJnZVBHNFZ0T1lQRkFzVTZMKzM2K3pJOXlzYzJiZGlFNHJUcW1DK21v?=
 =?utf-8?B?NmxHMXlSbXQ4WWdaVVJDQnAxOFZ1eUJzMEMwbUVHQ0dOUU1wYlNwTXEwd1VT?=
 =?utf-8?B?MnArL0h2SHBWK2hDUUptY05GWTJZZFNSeVdCMjd3Skc5T005cWNwY1Z0S1Ny?=
 =?utf-8?B?YnU2S0RLc1VQZmlyU0puSUlhb0ovTnVVNTNlZE4rZzFYd2FUV1h2aEJnYkhZ?=
 =?utf-8?B?aTd3M1FoMS9KQVQ2a25FdFpjK2sxV2VPNXo4S2VsMzFmd2RWc1U2dmZGOWpa?=
 =?utf-8?B?WFVITW95TnMyT1BKeEQwTVJmaWFCbUg5cFBTS2RCZjh6cVdCMWw0NjNJR1Fj?=
 =?utf-8?B?dk4xb2xhUjI0UGREZ0pEdlBQYk5LdTdPcnd1MVJWRWVISTRQVUE3aWJOdmNW?=
 =?utf-8?B?ZFNsSVlxbU9ja29ZYzlqZnV4OFg1QkNXKzNxT2FGMkM2QUlHWEsxblVoQWRU?=
 =?utf-8?B?dUFXZDJpUjN5TWVUMFpkZC94NXduRHNkN1JtbmVHNncyN3pRa2hBSzJwOG9G?=
 =?utf-8?B?RGRVMGlwQmZUdDZnQ0VXR3dhdkE4dDBkUUphWEtLSUxJMGxJZC9hViszSE5E?=
 =?utf-8?B?RlRjQ293c3BTR0dhNlh2WjZZM3pFNXJGS1RDMFpoL2ZCcFI1b2ZZN29Sekhq?=
 =?utf-8?B?NnhrZ1dGTmxraVBEZ1hpTUxCdHpCeW95ZlpiUUNsL2JNeFpvemFlSnZHRE5E?=
 =?utf-8?B?MTVNWmlJcVRRYjB0M0Ezakt0c1JRNmFkVk9ZWDZQVzdkRDVzcTlxZjVsemtr?=
 =?utf-8?B?bEJBZG9Hci9BS1dBSFJIVG5tTUpsWXpBTVpCYmV0OHR5dUdCRC9MVjhCRjhi?=
 =?utf-8?B?b2ZCM0R5U0tIcTIxeGpodlJqNkJnWTNlVUtsYWMvVTAxTEp4Wm12SnVZMktu?=
 =?utf-8?B?WHdkTGhMRWJqMjBaa2NxSEpFbjUrMkc3M1RxM3B5aWJ3TTlURW51bnV6OUNn?=
 =?utf-8?B?RGxxczd1QU1DQmUzdnZYK2tGY2czZFZIQTRKajRobHl0Vnc0RlptK1lqTC9X?=
 =?utf-8?B?ZEt4ejdDMkZnNitxc2JLLytIY0VRN0ZEVlFRM0NtcU1aSENmVCtZTlVwelMx?=
 =?utf-8?B?dDhlYlhsTHhXOTY2bW9lb3VXd2ZKM2E0UUFSbmJ0MkJ4Umg0MHlxKzIxTVE2?=
 =?utf-8?B?MWZ2eHRZSjM4MXFQM3dDcFc5bTRzVkxMbWxBWU9CRGMveHlsbmk4andOcjRZ?=
 =?utf-8?B?bndoYjdMU2VIOXZkYllORDRNb3dSN0tqQmdYcTlVVGV3Yi85SHVvK0JGZVlG?=
 =?utf-8?B?RmpQZFZkOHNkQXZDV0hPS0F4RkFOaDh1VXNWQnkwMEMza3JqS3V1V1ExQklZ?=
 =?utf-8?B?dTNkK0ZPYnUzeWl3Nks3dlBzcWhxRzl1OU51UDBtRkl2SElBWUxVQjhXT2dC?=
 =?utf-8?B?bHlreHNJbEZ2ZjgvUWZXM1FYR0RQZFRqZmRrQ1p4QjBqZ1FMSmdhSXUrMVVR?=
 =?utf-8?B?VzR5Y2NtSlZzN0ZNemxmTDJHUTlXWWpQWlFIQ3V5VUxnVzdEOVJxQm83NGhJ?=
 =?utf-8?B?ZW80MlBNR0MxVUtLd0hzR2hmL3lwSzZuQkpBbEQyS1I1MTNpdy80aytmSFE0?=
 =?utf-8?B?b1A1YW9pdEhHdEg3UGpTdmdMSVZreFFaUVZtaGVFNHd2b0xRTlF1TGpiOURz?=
 =?utf-8?B?TmwzeTFycGJhOE8xbGdwNm5LNjVJQUJnUHoyM3h0Yjlyb3Awcm5RYkw1OFZ6?=
 =?utf-8?B?ZXNuMy85QldjT0RORlRZY2kwTis4Z0gwMUpEU3pmZWtiN2NNVWprY0NBSTBM?=
 =?utf-8?B?amZnY3d3ZW44N1drS0JScjFhdFJCRnR5MExRcUgvWk1WRmh6c3dacktUdU14?=
 =?utf-8?B?L0h0c2pLY0hmZ3FLdjFGSmVPUkJxcmNOcDdhaHQ2NnVkMlF2N1g1dzIvQ1c2?=
 =?utf-8?Q?dgw8+ppee35rCv94UB5TZ74AFWavSDFbihYUloFf50=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de0142fa-fd83-46cc-cedc-08d9a08e76b4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4720.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2021 18:59:58.8116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6k+87BY+mvI5trvA6WZZFy93tkdh5PyaNqFcAIGVRjbj4+dRy2yEhHXedi02kzhA2BU65Fks9Pm4C3JCm5JDWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2798
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/29/21 8:02 AM, Huang Rui wrote:
> Introduce sysfs attributes to get the different level processor
> frequencies.
> 
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 63 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 9af27ac1f818..8cf1e80f44e0 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -485,6 +485,68 @@ static int amd_pstate_cpu_exit(struct cpufreq_policy *policy)
>  	return 0;
>  }
>  
> +/* Sysfs attributes */
> +
> +/* This frequency is to indicate the maximum hardware frequency.
> + * If boost is not active but supported, the frequency will be larger than the
> + * one in cpuinfo.
> + */
> +static ssize_t show_amd_pstate_max_freq(struct cpufreq_policy *policy,
> +					char *buf)
> +{
> +	int max_freq;
> +	struct amd_cpudata *cpudata;
> +
> +	cpudata = policy->driver_data;
> +
> +	max_freq = amd_get_max_freq(cpudata);
> +	if (max_freq < 0)
> +		return max_freq;
> +
> +	return sprintf(&buf[0], "%u\n", max_freq);
> +}
> +
> +static ssize_t show_amd_pstate_nominal_freq(struct cpufreq_policy *policy,
> +					    char *buf)
> +{
> +	int nominal_freq;
> +	struct amd_cpudata *cpudata;
> +
> +	cpudata = policy->driver_data;
> +
> +	nominal_freq = amd_get_nominal_freq(cpudata);
> +	if (nominal_freq < 0)
> +		return nominal_freq;
> +
> +	return sprintf(&buf[0], "%u\n", nominal_freq);
> +}

The nominal_freq valus is already reported in sysfs by drivers/acpi since this
value is part of the ACPI spec. Is there a reason to have multiple sysfs entries 
for the same value?

-Nathan
 
> +
> +static ssize_t show_amd_pstate_lowest_nonlinear_freq(struct cpufreq_policy *policy,
> +						     char *buf)
> +{
> +	int freq;
> +	struct amd_cpudata *cpudata;
> +
> +	cpudata = policy->driver_data;
> +
> +	freq = amd_get_lowest_nonlinear_freq(cpudata);
> +	if (freq < 0)
> +		return freq;
> +
> +	return sprintf(&buf[0], "%u\n", freq);
> +}
> +
> +cpufreq_freq_attr_ro(amd_pstate_max_freq);
> +cpufreq_freq_attr_ro(amd_pstate_nominal_freq);
> +cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
> +
> +static struct freq_attr *amd_pstate_attr[] = {
> +	&amd_pstate_max_freq,
> +	&amd_pstate_nominal_freq,
> +	&amd_pstate_lowest_nonlinear_freq,
> +	NULL,
> +};
> +
>  static struct cpufreq_driver amd_pstate_driver = {
>  	.flags		= CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
>  	.verify		= amd_pstate_verify,
> @@ -493,6 +555,7 @@ static struct cpufreq_driver amd_pstate_driver = {
>  	.exit		= amd_pstate_cpu_exit,
>  	.set_boost	= amd_pstate_set_boost,
>  	.name		= "amd-pstate",
> +	.attr           = amd_pstate_attr,
>  };
>  
>  static int __init amd_pstate_init(void)
> 
