Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E53B52D1A73
	for <lists+linux-pm@lfdr.de>; Mon,  7 Dec 2020 21:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgLGUVy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Dec 2020 15:21:54 -0500
Received: from mail-bn7nam10on2079.outbound.protection.outlook.com ([40.107.92.79]:23073
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726274AbgLGUVx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 7 Dec 2020 15:21:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QdOBHZacYlrjQTgPRPaEQG+fN3pytgQMIzzx9kNu7rMZrTmribjI1y3LuofagBh0o10iZP1LeL5VdnXemny2RRsHhhSdd82mcK/JENTxhpV1fY1zSjHAHiCoAGZqeE/iNFA55OUNOjs9Kc3Ah7n60HnDDrx1tLsDre+JNKWNASzxRdWCqXUwif7j+2JvxxrGs4huOzuNz3xJyiiG6LVlj7wfFYmdOxZ34LDs4or/LXX95xZN/bVdZ1QntHtelofqMOYobqVclZ/jNOX6FJLIJ+Ltd/b1FFOBFSSF+u9x04joAMWiWDGPhaf7ZmLyZgpkmpJVC6tUKQvOMZqeQUFmOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZPOopM5Q9phj0vNmNBbZ1yzis1UytadCdJmqs2f/MGg=;
 b=Epb9yz35AGg8U8kM0JZYeEw40gKz5NGWqgjwQH2ldhumW5fJnGbkNSNpftlZfSiGftBN0GvJqAbxud7cMmyS1GMN8aOrSyE5zgD9LGu/XG11JgCdl5tIlKCBdFNqcNtJoABkknn8R6LQnN7YcrgITBFF7+So/tM8qp6zMjNDhcu2zkhGqe+aRI6mF8weDKFQGP4F3gzTYf3j58euTf53ukRZiOJq3eHhnYswgfKfzjH6ulSkyBjrdhlwph4WuXhBKxYwQ3qrV4Wb1rEqroWI86A6/yYletZ4hDD2gj/x17eKL50OTckGWDbeiYinR28E6dLUTTWRHn68lyoMPT0flQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZPOopM5Q9phj0vNmNBbZ1yzis1UytadCdJmqs2f/MGg=;
 b=NmZbjM9P9N6xKV/Q4dCxVNQzfxPZrY5D6HxPoJY9EzOEuOc2RNTX3bE+3bxv+nFVTaAz7Y0fDdeJMCQFFxJ5rs/4kg0vZpmf+67BK7x0CkgK+dN+sCay0vDsX8Wh/0v/01cCr3O6PXKIv9nEhR0pf68iTuB419Sc/LGqKh6072w=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1494.namprd12.prod.outlook.com (2603:10b6:910:f::22)
 by CY4PR1201MB0149.namprd12.prod.outlook.com (2603:10b6:910:1c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Mon, 7 Dec
 2020 20:20:59 +0000
Received: from CY4PR12MB1494.namprd12.prod.outlook.com
 ([fe80::d0ac:8fdb:1968:2818]) by CY4PR12MB1494.namprd12.prod.outlook.com
 ([fe80::d0ac:8fdb:1968:2818%6]) with mapi id 15.20.3632.017; Mon, 7 Dec 2020
 20:20:58 +0000
Subject: Re: [RFC PATCH 2/4] cpufreq: acpi-cpufreq: Add processor to the
 ignore PSD override list
To:     Punit Agrawal <punitagrawal@gmail.com>, rjw@rjwysocki.net
Cc:     wei.huang2@amd.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, bp@alien8.de, x86@kernel.org
References: <20201125144847.3920-1-punitagrawal@gmail.com>
 <20201125144847.3920-3-punitagrawal@gmail.com>
From:   Wei Huang <whuang2@amd.com>
Message-ID: <cadb5d57-5aaf-79bc-e30e-502d5e522689@amd.com>
Date:   Mon, 7 Dec 2020 14:20:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <20201125144847.3920-3-punitagrawal@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.11]
X-ClientProxiedBy: SA9PR10CA0030.namprd10.prod.outlook.com
 (2603:10b6:806:a7::35) To CY4PR12MB1494.namprd12.prod.outlook.com
 (2603:10b6:910:f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.10.205] (165.204.77.11) by SA9PR10CA0030.namprd10.prod.outlook.com (2603:10b6:806:a7::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend Transport; Mon, 7 Dec 2020 20:20:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ec149df9-0800-4ebc-8708-08d89aed9c10
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0149:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0149FEDC37D61A29838022F3CFCE0@CY4PR1201MB0149.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DvPaKePzWx6i9oFODwPLIquJVHWO/nGXVscg5+dHKfs6EVmdwnMMqLaZ1jbCJyr7d/yhEarrM1s7Vp8PHN0qFzbW3hHA1Pky7tavQGMZ4VFMz4gigqbb589NZuajWU4nqjTSrWSurhZiWH2HViGFN65wt9bZyxYiTMmmBAsvWqNriNrUZJsnlr+YwngAabGORqlIz8bXfyLF1qBv7puspuSaig9h94uGt3X+8XbHX1eM6//6aYrjRxItR0mnbKnPccAgF1tzQfkMoq1NuweuP6OIYQFSM4pKaW4FTvG2gCElXTulOaTufSL//3pq1KLFcKP+IxvNOoSL9dCbSBfpqoCme/haNLXax6vx73UgyclN613bVVWvJu2mvOBXBYVpd+Wa9QxzG7KZQG22YCE6KgXO9LIo/ar+NCdNvoAEcVc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR12MB1494.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(396003)(376002)(346002)(366004)(53546011)(2906002)(66556008)(8676002)(478600001)(4326008)(8936002)(66476007)(26005)(31696002)(31686004)(16526019)(956004)(316002)(36756003)(66946007)(6486002)(83380400001)(52116002)(186003)(5660300002)(2616005)(16576012)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?d0xWSTZBeHNSSmNNbkVUajhGNjloWmx4Y2tlNVJ3MUQyTkZvM0Z4SThBdkJ3?=
 =?utf-8?B?eW5UMFdSVXV6bndMYUJ2RmUvenU3U2xHS09Hd3ZoZkRYM1pqcXRzVEhtU2Ja?=
 =?utf-8?B?SEhsampjTSt1Ujh6bTFhS0QyYjRHeWhrUTlTOC9sUUFmcnF1cHNud2JVUEg1?=
 =?utf-8?B?RTVvcWJZN3VkZks0Y0VmZklGeTIySExHSTlVbFFsQzdtU1BEWHJRbnZ0NkhK?=
 =?utf-8?B?YjJodnlyeHgycGx0ZFRWM096Um9RUEF1enBsU0VoTm5jRWVuVU5XQW5jVHNq?=
 =?utf-8?B?RmwzV0ZianFvOWdOYkJMWGJWTU9xYngxaVJLSWFxS1I5eU1veDhYQkZ2cGIy?=
 =?utf-8?B?KzIzcWFxRVFiaUsrNW9SWFV3eXF2Z2JFS1QxS0puUTZ6ejl1TmhDbG94NGNu?=
 =?utf-8?B?UWNqbUdkSUxUaFhWYndldUhMb2FzM01EL0lJV1Z4SERhT29jZEhxcjJCWE45?=
 =?utf-8?B?ZUdwVkZFbUw0OVkzLzB0L3FxN0xJKzltKzFUc2F5Y0pKa2UvUVo4cytBY1lH?=
 =?utf-8?B?S1hvNHhjUkxuZy8wQ2RwQnNXbmJjS0VndmdkMmJnNngxa2lWTU1vUkxEaXZK?=
 =?utf-8?B?M0pXUnpGc0FQdlhMck5MV2w5WWJxb3YwRitJaEkrQlRJVVJwZUZITmFoN25x?=
 =?utf-8?B?eXQwL3RsMUFhNGVGODJJUnV5cWFsL2dCcElGTmpYYUIwZ3lsUWVja1cxdkZh?=
 =?utf-8?B?SFhWeEhaVlRzaEljcnZScEhkZk0zTk9jZnJ5dXZZZzl6TG5hZmdrWG5rK2Jq?=
 =?utf-8?B?dlQxNzM0aHdDSHg5NlFMUVJxTkJ1VGJtZlE1T2kyWnBiNVg0L3JVSVZsRXJq?=
 =?utf-8?B?RWl4WmZ5NERsbURKY1Azb1lKNXh1U2xOK2VFV0grNHFHYmhLejNRZmhWVmZn?=
 =?utf-8?B?MFRYU2JKTCtPMGMrQ3BwcVM2bXk0V1FpOFZLRW44M0dFQnVCWk1McDFqS2dK?=
 =?utf-8?B?VFg5L0d1VE03NE5iMzE0bVRYWEFkT0FSWTdxT2ZrS1AzdXdwSlpSQXFUcVVx?=
 =?utf-8?B?a0hSVldtdlZlaUtTQVBFSHJGQmRYVnRZTVRqN0U0eVVTbFR2djVIaUFzVXFD?=
 =?utf-8?B?WStTKzVZUTA4VFJoTDFqZmZFMk9JT1JjT0V3WkpRaTVXTGxOaXg5R1EzaWkw?=
 =?utf-8?B?RkduOU5jTkxuQXVyV3k5K2ErZFEyczFNaGNQYU9nTTNyYmRUWWU5TEVGdFFa?=
 =?utf-8?B?SjV3UmN4QXJzOGF3U1hkOHJhWG5JdmYzT1FQSmtRenFmNnFpY0UrQjZKejVD?=
 =?utf-8?B?R2NxRENtREZid21VOUVaTFhYTXlpVEtRNVhMenQ1QkFIcFN3YVhUTm5lVThr?=
 =?utf-8?Q?bWt8CuJziIMVMcGiL7uTOmBIq9oHxNkAHp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1494.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2020 20:20:58.8041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: ec149df9-0800-4ebc-8708-08d89aed9c10
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rj2DGWEtwu2dEGkpTEfjddG2CqnWsUbHaoI23FQsFMqazE8/ork3LMaBWvs8cGTV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0149
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 11/25/20 8:48 AM, Punit Agrawal wrote:
> Booting Linux on a Zen2 based processor (family: 0x17, model: 0x60,
> stepping: 0x1) shows the following message in the logs -
> 
>     acpi_cpufreq: overriding BIOS provided _PSD data
> 
> Although commit 5368512abe08 ("acpi-cpufreq: Honor _PSD table setting
> on new AMD CPUs") indicates that the override is not required for Zen3
> onwards, it seems that domain information can be trusted even on

Given that the original quirk acd316248205 ("acpi-cpufreq: Add quirk to
disable _PSD usage on all AMD CPUs") was submitted 8 years ago, it is
not a surprise that some system firmware before family 19h might been
fixed. Unfortunately, like what Punit said, I didn't find any
documentation on the list of existing, fixed CPUs.

In my commit 5368512abe ("acpi-cpufreq: Honor _PSD table setting on new
AMD CPUs"), family 19h was picked because 1) we know BIOS will fix this
problem for this specific generation of CPUs, and 2) without this
commit, it _might_ cause issues on certain CPUs.

In summary, this patch is fine if Punit already verified it. My only
concern is the list can potentially increase over the time, and we will
keep coming back to fix override_acpi_psd() function.

> certain earlier systems. Update the check, to skip the override for
> Zen2 processors known to work without the override.
> 
> Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
> Cc: Wei Huang <wei.huang2@amd.com>
> ---
>  drivers/cpufreq/acpi-cpufreq.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index b1e7df96d428..29f1cd93541e 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -198,8 +198,13 @@ static int override_acpi_psd(unsigned int cpu_id)
>  	if (c->x86_vendor == X86_VENDOR_AMD) {
>  		if (!check_amd_hwpstate_cpu(cpu_id))
>  			return false;
> -
> -		return c->x86 < 0x19;
> +		/*
> +		 * CPU's before Zen3 (except some Zen2) need the
> +		 * override.
> +		 */
> +		return (c->x86 < 0x19) &&
> +			!(c->x86 == 0x17 && c->x86_model == 0x60 &&
> +			  c->x86_stepping == 0x1);
>  	}
>  
>  	return false;
> 
