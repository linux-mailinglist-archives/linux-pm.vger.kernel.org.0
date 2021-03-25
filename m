Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85A47348896
	for <lists+linux-pm@lfdr.de>; Thu, 25 Mar 2021 06:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbhCYFiU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Mar 2021 01:38:20 -0400
Received: from mail-co1nam11on2071.outbound.protection.outlook.com ([40.107.220.71]:21537
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229592AbhCYFht (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 25 Mar 2021 01:37:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jk6aSTNeRgG039E7dcU/e/isVaZ53I8eHn4R4uJseAyuEjj44Gq2LMaHHU1ourHiCQErWpy0IZlnzdkxHgFpAFwMOlXSHf2e7RE9mpAusc7mGJvMmFQehgWN1OIp7pm4WFobUNzq5j1wVPDViTo2GUyHRLP5UOx32wvtF6bynZ2eOeJkH+beVeYGApKwPvML/sACTTojxWByfpcS6HII3KpVSzUtT+sFqTF1zM1fkzs09acqK9Vb0j8LwBJhrTy94INKNmwzR1jY4yseN4NjzMiNckj8PZkBOt4RqT9y1nieXDaHcM2QNZk4BGnmaWoQJo5w5rox3jdfXibhu0kMNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zr3Ao0DUD/8Jh7as0WTDM5mcR2kk1dIkMoBTWayB/e8=;
 b=b8mWqO1KD567YyIg16N5FnigkrHEFikXck66WqLnbS3v7TCK9Oet9ha8IrcPaB1Ixh2igX+AtKbgi0WV4+8r8ZHS+u37opFtGKOTQccW7U3tnDAYKdWw+9jkYEVAKYS4IwqA1e2XZju2KYly543zPVTftW8c3Rj5Dbz/Or3RazjKWDvFzNMy9Cozj7jNtHwh+VZaKjL1sb7/XHjMPhVJsBgBmp7mWRcWjYVwA35eyjkr0FGzB645pMIu1XuVX5/NWQLDwjeQoKdhJCPRx+DYxmqPJ+UxxvTKBMkcbRJzj/fDCp3c8kBCCGcLrL2RB5KFxZaigCGYUdBbhIPY40NZUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zr3Ao0DUD/8Jh7as0WTDM5mcR2kk1dIkMoBTWayB/e8=;
 b=Wh3cq62+vKEX5qf7InFNS8CQp2a3vKNxmGyTT+KdxyuvjGVh5tpEKsRnCD1hMTAfMD8tAe1ioNX+CILlIO5LSGPNMyGUZQ9KuJ3P0oYaHeC1Qoq5uhnOXz7YsUstxmf+Qta622+7NJCJTXMVPOfrB6coyN3Y8bjRFbsyEhuiLc8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from CY4PR11MB0071.namprd11.prod.outlook.com (2603:10b6:910:7a::30)
 by CY4PR11MB2038.namprd11.prod.outlook.com (2603:10b6:903:30::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.24; Thu, 25 Mar
 2021 05:37:43 +0000
Received: from CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::d4fe:8135:d8fa:81c0]) by CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::d4fe:8135:d8fa:81c0%5]) with mapi id 15.20.3955.025; Thu, 25 Mar 2021
 05:37:42 +0000
Subject: Re: [PATCH] cpufreq: dt: check the error returned by
 dev_pm_opp_of_cpumask_add_table
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210325043129.2255918-1-quanyang.wang@windriver.com>
 <20210325044541.rsncitrmkpaes4dm@vireshk-i7>
 <2da8eb92-6082-35f3-b190-c7218edb35a3@windriver.com>
 <20210325052417.xyctxztqbozut3ck@vireshk-i7>
From:   "quanyang.wang" <quanyang.wang@windriver.com>
Message-ID: <e20f0c26-a357-7ddb-1c50-e84eff84b853@windriver.com>
Date:   Thu, 25 Mar 2021 13:36:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210325052417.xyctxztqbozut3ck@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: SJ0PR03CA0328.namprd03.prod.outlook.com
 (2603:10b6:a03:39d::33) To CY4PR11MB0071.namprd11.prod.outlook.com
 (2603:10b6:910:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.199] (60.247.85.82) by SJ0PR03CA0328.namprd03.prod.outlook.com (2603:10b6:a03:39d::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend Transport; Thu, 25 Mar 2021 05:37:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec2ad47c-26c0-40ed-2061-08d8ef501c7a
X-MS-TrafficTypeDiagnostic: CY4PR11MB2038:
X-Microsoft-Antispam-PRVS: <CY4PR11MB203829FA2FF55DAE641FF5C3F0629@CY4PR11MB2038.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ly2dIzszfP/9aAU1hcHzfIpxMV8iLVMPjqEw+FXEUdfq3YJgaWIc7W5lolpktiqWcyNYm+86T0el0n58AVgirSiTb7Klxcz+UdP/Nbff7fRfJxcY26pXtUnd99cp6PcWe/KnRu/XOvIDozOHG2ImxgFyfWYbjKdbuC4xJU3x3i216uss52woi08dYn3A8uzf3VqXicINS2J/SsGSEAi6r+wo91hgRfwxsYsK1bVCoHpE2UZeLJWiiVH54EBNaHDEKXfPj+2xmy6jrI8Hzo8PhhfqyWQR+wnWQyNBZ70ITU8SJyhoGAvhWEhxDhKT37dNEFqN0TXQrnlYWxzZU2ElobFl469wjrjMgbsF2FrtQxiHaTjLnYxIvYzZ+Axs5GPUZkr5VZqj+9fhf4IT8SVDYqnKqwleKwVNdrKrvm74u8MWupZTCHo9VzNlm/PDjK+WnEMdGbOFG7FUt+5E1hrQGyeX+kVUAnWgXFQyjUlPxJdvgTAyKRHxBV8WmU1syBXJ/jdhOnPl9ZKfz2TPpx3Gyr5dKd94RW9qQoEGmw73ILW8vPBcr7IsID8x3WDSv3bdSVPs8wWwTEpc1kLTx093bmAHLRwJ3edlUSf97z49BL6HAmvvQJx3VzRpyfeGS6psSgo0YFjuTcFVZBnG4YKG3ezHkOltG4NSmU9fcLS6QqdpMQlQ/iZf/L/YpfMDljbQd5s6YFrTWuTfUVoWPMYm+8oupGNq6CmwKrgOVZtSYl53BYAzWBe3IgVUjeB79UU3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB0071.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39850400004)(376002)(366004)(396003)(346002)(316002)(38100700001)(36756003)(6916009)(26005)(956004)(6706004)(4744005)(53546011)(8936002)(16576012)(8676002)(31686004)(6486002)(186003)(2616005)(2906002)(66556008)(16526019)(31696002)(66476007)(52116002)(6666004)(5660300002)(66946007)(478600001)(4326008)(86362001)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cU9nc3BzVXVjREt4M1VXQnJwZjlzNk9ianphU1NBOHQrNkQ3c1Y0TUVoOTYw?=
 =?utf-8?B?ZWYrVFNyenZITXFkUjJXcUtnYkw5a2FVYkRJSkFCTEVsaGFJMVBkaDB2OWJT?=
 =?utf-8?B?M0cwQkVlOXh1WmNPOFlZcFQzdzhNTGRBaHY3UXdKNDVuT2UxQW1PWTFMOUhD?=
 =?utf-8?B?M2V2ZHdqQmJncUh6MU80QVZoMUt0L29XaE5Icmh3eU9ZNWx2TFZsMmpTNnk2?=
 =?utf-8?B?ZzdMbDRDQUd2TjZIUUoxR1F0TjY1QTV3M2JWcXN3MnpJNXh3V3p0bXVqT1JJ?=
 =?utf-8?B?OUpjU0oyN3FuTkdqK0ZXUVhVRHpRZHlMekZVUXJhV29iTElOZzluck1FcERB?=
 =?utf-8?B?UkcrZkM3RE5uNWZFbC9qblIxM2FHaFNXaUQwMkJHYlYrUmFZdm55SFJ3dkZO?=
 =?utf-8?B?eXF1dGt0UXhMWTc5R3U0aXF6VTdORDZveUs4dnlkOW94L1B0RXFLSFg5cGRJ?=
 =?utf-8?B?YzY3QlNKQ2tqeTQ0K2tyRlFoTmFzYk94L3QvTWNyYi8ycDFhVzEzWFZGMWtZ?=
 =?utf-8?B?Sk01b3RxTXVEK0UxMWZIUTVFZE1PaHlRMUYxaWgvalNNOUw0YTdXTlRtSDZh?=
 =?utf-8?B?dU9LSm1NV05iNER3Z0NtVERnZmxCbDg4eE92MTZoeUpTRFh2SnlMUE1RY05T?=
 =?utf-8?B?Q3FwMy9oZmJYTkIrUm94aGdnNXNVc2YvSnRxQ3pZejc0cm8wRDYyRkxYNFJN?=
 =?utf-8?B?cmRldTRudU1RU2JzQ2hGZE4wTnUzelh0ZmpLVVFnV1pYeDhrTmdiZjViTG9x?=
 =?utf-8?B?dnpOTEg1UFdvSHlZeDFjUTBYVGNSdW1kcDJYV05CNzhXVTl6QnB0Q3FoKzdi?=
 =?utf-8?B?V0dPMEFKenNKZlVYVHBQTzRPN2pQUUJEM0dtbDJpS2xWam80MXhRdzNiaUF3?=
 =?utf-8?B?KzRQcUpvemNKS09GMnJ5QnVVRUFuMUV1ckZzVlBnMVE5T2pCRmY2MkNHcDZv?=
 =?utf-8?B?RzRnakNFRnVzZ1FjbVdXMVI3R0svWkEySHdPL2cvYU1NQTlmMWg1dkRyeW93?=
 =?utf-8?B?QVBuSTZOL2J1c2lDV2xjL1gzUzE5OTFyeDlMQzRnWWpHWUNWTnNPOVlhdm1Z?=
 =?utf-8?B?NTVwQW1UQ3pIY2EyZXVJeDNxYXdlTXFEM09GeGFhYTkyQVJ6aGZkMTQ5UFFu?=
 =?utf-8?B?S2NRUDBDTEx4YzJUSW9DUjE5L29mQW9Ecm5GemU0Tkx5ZmI4SlRZdk9NK0p4?=
 =?utf-8?B?dU1oVTZvUTc1VmE5VDJTa2cweGVmWmF0MFY3NGF4VTY3VVdTZ012alZZZ0Nv?=
 =?utf-8?B?UThoSG5mSmJqaWlRUk1VUEthR1poVWtNd3Q2QXNWZTBxdWluKzFOQnBNSS9v?=
 =?utf-8?B?QzAzZ0pLR2lhN2ExdVJLUWZ0RWMxNGd3Q0h6akhsc1RlUk95bXNkNkp3NUsv?=
 =?utf-8?B?RU1JbnRPSENzYS93R3I3VjFCT1d3a1RQd3pUTHJ4SlBGNFVxU1RwT2cwVzBW?=
 =?utf-8?B?NHBQTXF6ZjBUM0I2Uis2aHNwc1pwdEc0WjM3WjMzbEtVYm8rSjhDaHV2SDlS?=
 =?utf-8?B?VC8wSEZpRGNUL1VXbTBjV0pEZ2F6S1VRSElOZ0c0OFlZV25jOUk3M1ZVcDdU?=
 =?utf-8?B?b1pYblNlNTdVbThzNGk2b0d0UWxuRDVsaWN1ZUg3ZiswM0dndHhUSDBlTHNX?=
 =?utf-8?B?YTFtcUpvQ3FQV1Y0aTFiY2JTOElBTk4wekFQSm53bTlHNlB1Qi93d2Q0TUxs?=
 =?utf-8?B?dEFKWFJLU0FHNUhXakhyUENDTWxjY2dlZmpNdmNJcUdYanUwZmRlRVkxeEZP?=
 =?utf-8?Q?bUhmdxaYYwCpGnQpNUjsuocGHY8qVwIr8G8NEyY?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec2ad47c-26c0-40ed-2061-08d8ef501c7a
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB0071.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 05:37:42.8312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iWsUNNDOQK4P8ER1HgSg+fzH4DATMLWUl/jo5IVdppgdKAnbIpIa2ehEUto3IvDS7TCMhUtKemh7oO7jsE9uDt9IZPWq+k69gKkNRnpg3Uo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB2038
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,

On 3/25/21 1:24 PM, Viresh Kumar wrote:
> On 25-03-21, 13:15, quanyang.wang wrote:
>> Thank you for pointing it out.  Do you mean that even if
>> dev_pm_opp_of_cpumask_add_table returns
>>
>> an error, dev_pm_opp_get_opp_count may still return count > 0 because
>> someone may call dev_pm_opp_add
>>
>> to add OPP to cpu succcessfully at somewhere else?
> Yes.
>
> There are two ways we can add OPPs today:
>
> - Statically via device tree. This is what
>    dev_pm_opp_of_cpumask_add_table() tries to do.
>
> - Dynamically via call to dev_pm_opp_add(), which I described earlier.
>
> What failed here is the static way of adding OPPs, we still need to
> check if OPPs were added dynamically.

Thank you for shedding light on this.

I will send a V2 patch which only check the return error -EPROBE_DEFER.

Thanks,

Quanyang

>
