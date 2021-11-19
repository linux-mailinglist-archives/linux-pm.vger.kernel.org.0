Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1094F4577CC
	for <lists+linux-pm@lfdr.de>; Fri, 19 Nov 2021 21:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234413AbhKSUmG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Nov 2021 15:42:06 -0500
Received: from mail-mw2nam10on2052.outbound.protection.outlook.com ([40.107.94.52]:43457
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231455AbhKSUmF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 19 Nov 2021 15:42:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V/wWHzJRHxl6tPIdmqccQQkwBDLCuhvzxElhagB3CIZobm/ZzvNMbB6DvQKSCTM8VwobY/UUrc3FzEez/NO5lGv+kRWW5FTEqpV0jNbDkgAJyRYlS1xFA0g+j95oR0iTi/1hAItswYIZlA3p1uJioRQ9KohDEluJ9qYxD5bl5Js1JxSrExRPVfe5eRSbzmWmcvpPf9X5DFqFFcVM87c5WxKrdS+pJMz0HlVE/YNazZIeYvgCoHQQremFWT//Qt2qB4jXjEEvFe8czB1Qp5cp4QrDk1AVMue1tY3Eag51MZ0D6xMR1rTnXdyv6Rw2BUW3H4Emqaz6orzgmUTaRD4JjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bvYkgRXT6xo2PZZglOzWY8HZNnOe5RSpXWoM7C3m5is=;
 b=a6e7MiEAZmmr45OLYSX8Oan5vTdG42cCe/n6Co11kdUTbYOHVuJrmLhTm0zIQHXN40UvW25LJ4Eb7LEJFkXzHc0gIftfJZ7Wnesl8acS8XSqWQwb3iw9wyKt6ZWpxqqBoDtWDC963b8nRMnyv5ghxvyZlYHBcfCSc5E6AZnymSljxnPefxFbcTWYR87BVh6PNJFJWmdmC1M9jAVxNG/P6dQe5iKRIadMsFKONAKs0eUq+/WcX5EclJPFCluHbLqS3pPZ6mwkdr2JeBnmnklyjry/djWB3YuX0HgXmzTrbtC8bV4RTdyaLlMby1NfI1xJxU44Eg/Y+zhK8Bm812AdGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bvYkgRXT6xo2PZZglOzWY8HZNnOe5RSpXWoM7C3m5is=;
 b=nPz/JxGNGYWrWTOSe1yfFZsoW5h6F6sXknHeRNtkDOvuYPEzf3wbLmcFXDjjmx+p4FqHk8j2G2+5IIU3ZWqYpozGkGpLZbmI+cTCLoxQWzrC7hEMACCjwEiwnVAj2KnOChKOg4Fb+y1NsZupwCDWKmEKP07U19ockudHqMvy98o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4720.namprd12.prod.outlook.com (2603:10b6:805:e6::31)
 by SN1PR12MB2350.namprd12.prod.outlook.com (2603:10b6:802:24::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Fri, 19 Nov
 2021 20:39:02 +0000
Received: from SN6PR12MB4720.namprd12.prod.outlook.com
 ([fe80::c4b9:b9bb:e863:af39]) by SN6PR12MB4720.namprd12.prod.outlook.com
 ([fe80::c4b9:b9bb:e863:af39%5]) with mapi id 15.20.4690.027; Fri, 19 Nov 2021
 20:39:01 +0000
Subject: Re: [PATCH v4 16/22] cpupower: add the function to get the sysfs
 value from specific table
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
References: <20211119103102.88124-1-ray.huang@amd.com>
 <20211119103102.88124-17-ray.huang@amd.com>
From:   Nathan Fontenot <nafonten@amd.com>
Message-ID: <152fb29e-c558-ec2f-7ec6-65d7f62274b7@amd.com>
Date:   Fri, 19 Nov 2021 14:38:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211119103102.88124-17-ray.huang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:2d::40) To SN6PR12MB4720.namprd12.prod.outlook.com
 (2603:10b6:805:e6::31)
MIME-Version: 1.0
Received: from [IPv6:2600:1700:271:b60:561b:7197:b7b5:aaae] (2600:1700:271:b60:561b:7197:b7b5:aaae) by BL0PR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:2d::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Fri, 19 Nov 2021 20:38:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b9f4664-795f-48d1-2502-08d9ab9c9eab
X-MS-TrafficTypeDiagnostic: SN1PR12MB2350:
X-Microsoft-Antispam-PRVS: <SN1PR12MB2350B72BC268249EA84C1917EC9C9@SN1PR12MB2350.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1091;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fXBa6cBTIsCHQcvblQcrK5U0Z66CmfCK1igg4/k6xWdpU18/ej++zkFFu3pVSjRRXbl8bzBc3aHaCrJQkBlRnIc9a1PvlznVnTypH/e57vTFad+pcMUTWOecdv1n7InQwBU7ZhSsl43lyIs+XR0GQMmKh6TnklKgUB9Mf3U46N0xJBPEiwoKD0VAa40FRMtmtxMsQ3XxMNVF68v6bSyVz7NzJJQZ1uQIbBrSkbNg471AiLV1ZkRnPnVqGBO7jJJBhuas4W0AYmSYTDPbi8xC0IDIwOEf7vI5T8fXUrsiQqTt+j4+u0UIHt1q6uAdPVDrWtDg9lbG+G6sefsCGwmHvWNb3C7+Y/9Q42go3RpwN3ODgm0KKkMa3kiKMPYn35jR2uHBfws3xh/vjKDIBWb+3dUEt3j76kE+DQwEQrmTeFVoMhlx69R0DFp3N0Pkdquip0pV3DWwRkNUcNBdytJ+OlmUN2EL6J8J10AQogceLunTl73jYx8ST4/Zq/OLoj1z9GWQUTjv9GxH6KJyO+EijIVepe7gZCizm/DnDCs/DLILQqe0rhxxazAUeqsA06nyfjfnd6rywrfYHRGUhdQu8KUvSBK3ySJRdjl1sg3fRDi5VquyG/bn5vO7g6HkLcKTkGFoevUEMGP4EVYjps5Tad+m2nMHAtsyjrcvVhs9UQeKrEWxNt+rVBwDjcEWuZwSMPHfSEoC0y8kjTjSHbQ7cYmYea++Wn+VUCCScIcm3NaEc6e9eJ4IJN2ZEFSZNi9xzwDoeN79MugrIWF5Wia6XA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4720.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(7416002)(2616005)(83380400001)(6486002)(8676002)(66946007)(508600001)(66476007)(36756003)(4326008)(38100700002)(110136005)(8936002)(5660300002)(2906002)(54906003)(53546011)(31696002)(186003)(66556008)(31686004)(316002)(15583001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODJkSlV3bFA5Q2hPQmJEei9oQkhmenFKcGtKS2cyOWZXSGt1S2ZxS3EyMEFH?=
 =?utf-8?B?aElPN1ZUcktaZS9CTXJjdmIyYlJFN0ZlZ3VFOXVjYlJ3cXZLZ1VjN0UrbGhr?=
 =?utf-8?B?RkovSURkeUZ3eEErVkFWalJYdEk3ai9QTzFDU1lOUVpKSFo4Q0p3eG40TG5H?=
 =?utf-8?B?U3NabHIraGhKUnJTdTIzclJMYXZmaGUrMDZDZEFrTTg4bVpmQjE5NkRWTHUz?=
 =?utf-8?B?azhFaFd3ZE9IeE1vM2dXZFBVN0sxbW9DS3BXMWRMNklRRjJIUEJXc3d5TWl6?=
 =?utf-8?B?dFpiSzU1MENUMndrMldVOFNLMXpXVys5S25HRDBkZE90UGpRdDkzTjhVcXB3?=
 =?utf-8?B?NWdsSDhlMFNpVTJ3cW1RdHB4ampKZnRRRHdPM1JydWtCUDBJM2JpWGdDcXFw?=
 =?utf-8?B?Q1BJUERaZ1JCNUsrSVU0R0Z0YThvYStCL1RvenliSkhac3NaYUk1OVQ1eTdr?=
 =?utf-8?B?d3RaRDVWRVFhbGxkekJQdzgyaHMwRzRCRmtCUURQMlJvQVkzMW1Jby90Njls?=
 =?utf-8?B?U1JkRHZUL2VMMG5UVDdKeGExSE50bkFZWXY2SURZZ1NPcmxuam1jWU1kWU8w?=
 =?utf-8?B?L3BqeXVLMnpMNGlWZ25PVWFmV3o4WkZraTFUL1RaZnBuaXRMVHlLZkFxeTUz?=
 =?utf-8?B?ZmpXVWdHZWsyRUkrQmJabjFXSzRuSlZkTm9meXd6WWpTTDB2QVFJQU5JeGlD?=
 =?utf-8?B?YlJwYmpISDJhYS9wdzU2UzBFTjNTLzQ3WVRVU2k5azZqUTU3SnVVMEhVZVFp?=
 =?utf-8?B?eDJMS3FvdTBRdXBucHluNVJHemRWVkgreE1sNGZ6VEwwRGJHVUhQTTdIdzRt?=
 =?utf-8?B?OURsRnBqbFdjb3VSeUExYTFaS2NFdUJjSDhwZWQvR0JwaUF6QnBjSHEzMVEy?=
 =?utf-8?B?V0YxNUlPdUFJTDVhQXNDeE00UWwwN1pXaGJjOHpTcDRrbDFrM3YvWERDU0NZ?=
 =?utf-8?B?UExBWXFBaXZWK0FlNlFqeGpEZ0MvOHFtT01lRmk4THNPUmNMNDB0WW5Yd2ZF?=
 =?utf-8?B?SnhKVE9RcXY1RGJHdVJLMlhTdVN4bElqVXNBYS9XbkdCb1V1aTFQb3F3TkZG?=
 =?utf-8?B?anNvUlY3eVVjU1ZaSE9jc3UwQjBLK1VZUmRSaHYvV2NRbGd4K2txZVNQNFVm?=
 =?utf-8?B?ZHRCQUV4Ri82ZVlBSGF5N2J6UjJkRGtKdXZQY3RwcG5TLzQ5RU1zRUtBczhY?=
 =?utf-8?B?OEt6SWs0cTNFcmR2N3pHemZra2hLVWJjNmxVcGZaakl4SkFTWjZjR0RFMURL?=
 =?utf-8?B?RzhqQ2lUNGJaL2ZlZG5UNzg2aFUvMXlkeDM1ekZ2RFVYc2g0UzJ2MG93dEZX?=
 =?utf-8?B?U0FEY2tkbldyVEhzZ1J2UUN0NXJYVVdVaFljd3MxMnZmVnlaOEJ5ZmlldGJz?=
 =?utf-8?B?T2F2Yjd1dTJDNncrOG1Td284SGtMMUJPVjJTZnhsc1NCeU5Gemh1Nmx6Qzk4?=
 =?utf-8?B?MllneXEwRHc2VERjL21QZ0hPSjdBR00xN1BkQnVZQ0lWRHdqZnJCYkZ5NCt5?=
 =?utf-8?B?VnlyZEhuQlBFckw3WVR5Ymp3WjBjNllwNkdidWFuaEhqY1pvbWp0QWtRTHgz?=
 =?utf-8?B?MnVPOUtiSTgrRElUQmk1OVMxdkVSa00rYkpiTzJkc0JjWHFpU25UTGJRclhO?=
 =?utf-8?B?Vmt1aGJKZFlkOE1DencrSldmN3FraDBpTXQzVUZPNlhUUDVIQWxSZGFGL29E?=
 =?utf-8?B?WSt4SFBGSklWMk5abm1BaFhSVWJ3TTNNUUJHQThUMUNJRlorZjdIUUY2Vm90?=
 =?utf-8?B?L201ckZCc0g2UW9KTzBYbWk4eWZuQ2pVV2llSVdlSDNoWVVpY2Vxc2EvM0ZT?=
 =?utf-8?B?Y1NpVVNmTWQ0VnJYOERpY1M2SFYzTTVFUERXRjF5MEdYS25BbzFyVGhPK3VV?=
 =?utf-8?B?aDR1ZWdkS3AxcEdKblM0cGxJekNEekVGYXlvM0x3OHNNTW8vcVBFd1JpQzQx?=
 =?utf-8?B?NUtlZkY5MDJpMGplSXJuRldjS2QzQTBXcUdYbFZXaWFrS29aV2gxTkpoNU9y?=
 =?utf-8?B?U3lwRFpoeldYb1MxMWtWWlVkdmZERjY2eHVHVXkwVXJhcTJ3KytHQTY3WXdp?=
 =?utf-8?B?UXhTNXBHSnMzbHRrOGFhZjUrSW5KOWJ4NUg2RmhJWjlCZE4wWWNLNUQvZ0dQ?=
 =?utf-8?B?c2ZFOHNhMk1Jb0ZHQTA0d250eUhZSSsrem1FbmZlK2k5dy9DM29tbEhuOTBr?=
 =?utf-8?B?MGI3WTIvendUQ25tcFo5OU0xckEzcSsyZ0hZckZSNUdnNjBuaGJ4eWZUZUtk?=
 =?utf-8?Q?vHGY4Z733qHGp56tXOMJPp/AFNEzjY4Ihm6WMvSugk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b9f4664-795f-48d1-2502-08d9ab9c9eab
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4720.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 20:39:01.6866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FaetInmhQPWbi8yodBHAJkzKF7Eh3Ovjd3vUDjTv+dU4COI8dyPDvRoQjTzwT4MIGbAIQ/KSYescMtLW9ysxNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2350
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/19/21 4:30 AM, Huang Rui wrote:
> Expose the helper into cpufreq header, then cpufreq driver can use this
> function to get the sysfs value if it has any specific sysfs interfaces.
> 
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
>  tools/power/cpupower/lib/cpufreq.c | 21 +++++++++++++++------
>  tools/power/cpupower/lib/cpufreq.h | 12 ++++++++++++
>  2 files changed, 27 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/power/cpupower/lib/cpufreq.c b/tools/power/cpupower/lib/cpufreq.c
> index c3b56db8b921..02719cc400a1 100644
> --- a/tools/power/cpupower/lib/cpufreq.c
> +++ b/tools/power/cpupower/lib/cpufreq.c
> @@ -83,20 +83,21 @@ static const char *cpufreq_value_files[MAX_CPUFREQ_VALUE_READ_FILES] = {
>  	[STATS_NUM_TRANSITIONS] = "stats/total_trans"
>  };
>  
> -
> -static unsigned long sysfs_cpufreq_get_one_value(unsigned int cpu,
> -						 enum cpufreq_value which)
> +unsigned long cpufreq_get_sysfs_value_from_table(unsigned int cpu,
> +						 const char **table,
> +						 unsigned index,
> +						 unsigned size)
>  {
>  	unsigned long value;
>  	unsigned int len;
>  	char linebuf[MAX_LINE_LEN];
>  	char *endp;
>  
> -	if (which >= MAX_CPUFREQ_VALUE_READ_FILES)
> +	if (!table && !table[index] && index >= size)

Should you validate the index before accessing table[index]

        if (!table && index >= size && !table[index])

-Nathan

>  		return 0;
>  
> -	len = sysfs_cpufreq_read_file(cpu, cpufreq_value_files[which],
> -				linebuf, sizeof(linebuf));
> +	len = sysfs_cpufreq_read_file(cpu, table[index], linebuf,
> +				      sizeof(linebuf));
>  
>  	if (len == 0)
>  		return 0;
> @@ -109,6 +110,14 @@ static unsigned long sysfs_cpufreq_get_one_value(unsigned int cpu,
>  	return value;
>  }
>  
> +static unsigned long sysfs_cpufreq_get_one_value(unsigned int cpu,
> +						 enum cpufreq_value which)
> +{
> +	return cpufreq_get_sysfs_value_from_table(cpu, cpufreq_value_files,
> +						  which,
> +						  MAX_CPUFREQ_VALUE_READ_FILES);
> +}
> +
>  /* read access to files which contain one string */
>  
>  enum cpufreq_string {
> diff --git a/tools/power/cpupower/lib/cpufreq.h b/tools/power/cpupower/lib/cpufreq.h
> index 95f4fd9e2656..107668c0c454 100644
> --- a/tools/power/cpupower/lib/cpufreq.h
> +++ b/tools/power/cpupower/lib/cpufreq.h
> @@ -203,6 +203,18 @@ int cpufreq_modify_policy_governor(unsigned int cpu, char *governor);
>  int cpufreq_set_frequency(unsigned int cpu,
>  				unsigned long target_frequency);
>  
> +/*
> + * get the sysfs value from specific table
> + *
> + * Read the value with the sysfs file name from specific table. Does
> + * only work if the cpufreq driver has the specific sysfs interfaces.
> + */
> +
> +unsigned long cpufreq_get_sysfs_value_from_table(unsigned int cpu,
> +						 const char **table,
> +						 unsigned index,
> +						 unsigned size);
> +
>  #ifdef __cplusplus
>  }
>  #endif
> 
