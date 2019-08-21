Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1269758D
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2019 11:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbfHUJDg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Aug 2019 05:03:36 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:45037 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbfHUJDg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Aug 2019 05:03:36 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190821090332euoutp010db6fa358d51779637b1dec3d22f7681~85K_D3WR-3004830048euoutp01I
        for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2019 09:03:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190821090332euoutp010db6fa358d51779637b1dec3d22f7681~85K_D3WR-3004830048euoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1566378212;
        bh=HjtJNUobfqATIFzQLlgWTNQWfAG2km9Yjm1hQCOuQQ8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=kz8fanaUbfu4uRUQATUjipksL+yz6vyT1snvIKQRDsORGEM5gB/kFgWp/n8rHYraN
         dgs6OcJH6wqUQwasSoXctNdVDzAQ0kXWblOh+dliQ/QMlRMrLoW3H0/R/DdhDmDM15
         INyNtYaW6p7prkFEPXfInIYFp/8pyYzQuPcvOQOA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190821090331eucas1p2f8d80818ad60c52a691e200a581f06f3~85K8ql3wV2932829328eucas1p2J;
        Wed, 21 Aug 2019 09:03:31 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id A9.5E.04309.3E80D5D5; Wed, 21
        Aug 2019 10:03:31 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190821090330eucas1p1db7ea49c2ee537ab561af8123004ba4a~85K75ioFn2766327663eucas1p1R;
        Wed, 21 Aug 2019 09:03:30 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190821090330eusmtrp12edf7b66e01271f3c25a7f69290550db~85K7qJ_520611606116eusmtrp1S;
        Wed, 21 Aug 2019 09:03:30 +0000 (GMT)
X-AuditID: cbfec7f4-f2e849c0000010d5-1b-5d5d08e3bbc7
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 75.6B.04117.2E80D5D5; Wed, 21
        Aug 2019 10:03:30 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190821090329eusmtip1eeb5e13b722585a24120dd4de96d1109~85K6pwuEh0307103071eusmtip1V;
        Wed, 21 Aug 2019 09:03:29 +0000 (GMT)
Subject: Re: [PATCH v12 3/9] drivers: memory: extend of_memory by LPDDR3
 support
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-clk@vger.kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        =?UTF-8?Q?Bart=c5=82omiej_=c5=bbo=c5=82nierkiewicz?= 
        <b.zolnierkie@samsung.com>, kgene@kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
        kyungmin.park@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        keescook@chromium.org, tony@atomide.com, jroedel@suse.de,
        treding@nvidia.com, digetx@gmail.com, gregkh@linuxfoundation.org,
        willy.mh.wolff.ml@gmail.com
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <43c8fb01-c85c-47f7-f5c1-5fc0d0191b26@partner.samsung.com>
Date:   Wed, 21 Aug 2019 11:03:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAJKOXPdue75yF=v5vsawOdfvcCMBDP6HGVXdwngBWE264kGJwg@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf0zMYRzHPff9WVweJ/UZxpzZZESGPcYamx9f/INhfh2OvmK6w32VkpGf
        KXckFKcIo9ydpbQ6t3FTTRROaZUfV3EtP8ty+RFqur6Z/nt93s/78zzv9/bwlCqdHcpv1e8S
        DXptlJr1pwsfdLgmeHiNZtJ1C0vyzuUypLb9HUMulT5liLXNg8ihq7ksOV2eqSCPj+vISc8n
        irhctzjy5OBnjrQZ6xny3JHBEq+pFJFzrnsKcrPUzZFrtZUKUlk+l7w6kMOSI3dLOVLyOZEh
        XTV5NHFWLySvfgeQ7w/folkg2C7akPD9WyotfKk7wgkXEipp4Y7ZzQn5liRWcGbaOMF0qJUV
        ThRYkHC7Il7w5o9Y3H+1/8wIMWprjGiYGL7Bf0tSZsiO8hGxRbccTAJKD0pGfjzgKfC7OYVL
        Rv68CucgcKZ8pOWhHYH1201KHrwIqlrN7L+VjsN5vSvZCNqs9t6hBcGv6/c5n2swXgo/6l/3
        bATiEKjt/MH4TBR2MlB30NJ9L8+zOBTslp0+jxLPg8Jfnygf03gMtCVWMT4eglfC18YSRvYM
        gkfnm2gf++ElcNjd1aNTOBheNl1SyDwSiloyemIDruah2d2B5Nhz4E31M0bmwfCxrICTeThU
        nDbSMkuQYLrc698LnpOZvZ4ZUFJWyfgyU91lch0TZXk2dOVUIZ8MOADqWgbJEQIgtTCdkmUl
        HDuqkt1jocD4TCFzEGTb0rgUpDb3KWbuU8bcp4z5/7tZiLagYDFa0kWK0mS9uDtU0uqkaH1k
        6KbtunzU/V0rusra7cjxZ2MxwjxSD1DaX6zRqBhtjBSnK0bAU+pAZWzGao1KGaGN2yMatq83
        REeJUjEaxtPqYGV8v8Y1Khyp3SVuE8UdouHfqYL3G5qA0Kp1KzrH506PWbvZ6V2Q2lBjj9hf
        tGdggyn+yfLoM83jcoz1cdlfK5Y+b/wTeKr2nQ3fMI3XBg2pOhs5mh84YZnqfkZreGqaRyl0
        Tvtgndq41qVZuPxGTZhr7ux2oy4kVu/w5tUw+95fUev5rMJRZ8b+7LQuehwWnlg0/yjOcqe/
        V9PSFm3YOMogaf8CG6EILKoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNKsWRmVeSWpSXmKPExsVy+t/xu7qPOGJjDT4/FbDYOGM9q8X1L89Z
        LeYfOcdqsfrjY0aL5sXr2Swmn5rLZHGmO9ei//FrZovz5zewW5xtesNu8bHnHqvF5V1z2Cw+
        9x5htJhxfh+Txdojd9ktll6/yGRx8ZSrxe3GFWwWrXuPsFscftPOavHv2kYWi/1XvCxu/+az
        +HbiEaODhMeaeWsYPb59ncTi8f5GK7vH7IaLLB47Z91l99i0qpPNY//cNewevc3v2Dz6tqxi
        9Nh8utrj8ya5AO4oPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzM
        stQifbsEvYzOuZoFp+Qqtm/YxdrAOF2si5GTQ0LAROJny0b2LkYuDiGBpYwS+9sXsEIkxCQm
        7dvODmELS/y51sUGUfSaUWLS4SMsIAlhgSCJ7/fusIHYIgKaEtf/fmcFKWIW2M8q8ehAD1TH
        BCaJI31TgEZxcLAJ6EnsWFUI0sAr4Cax7ddrZhCbRUBV4mP7JbDNogIREod3zGKEqBGUODnz
        CdgyToFAiZa7/8BqmAXMJOZtfsgMYYtL3HoynwnClpfY/nYO8wRGoVlI2mchaZmFpGUWkpYF
        jCyrGEVSS4tz03OLjfSKE3OLS/PS9ZLzczcxAhPKtmM/t+xg7HoXfIhRgINRiYd3x83oWCHW
        xLLiytxDjBIczEoivBVzomKFeFMSK6tSi/Lji0pzUosPMZoCPTeRWUo0OR+Y7PJK4g1NDc0t
        LA3Njc2NzSyUxHk7BA7GCAmkJ5akZqemFqQWwfQxcXBKNTC6bg+94Xg6W0Y64gKjy4nHbom6
        K2r89dmzUsLlvl/kcYhud+NaLcqibSOxuUxVlsNEtGwCV0vN8kcVvdY8d9c/OL86qoBDbnno
        i6ui7yeuqZw+U63MZWO4UK3F3/NxLm0pOd+eBpkel/v+q+mXiP7lY/8sD51KFE7PzOVy6g0u
        vpOdF/RxrxJLcUaioRZzUXEiAJjDpgs+AwAA
X-CMS-MailID: 20190821090330eucas1p1db7ea49c2ee537ab561af8123004ba4a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190722094727eucas1p10041ba25819e6e62d639423a97435f2d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190722094727eucas1p10041ba25819e6e62d639423a97435f2d
References: <CGME20190722094727eucas1p10041ba25819e6e62d639423a97435f2d@eucas1p1.samsung.com>
        <20190722094646.13342-1-l.luba@partner.samsung.com>
        <20190722094646.13342-4-l.luba@partner.samsung.com>
        <CAJKOXPdue75yF=v5vsawOdfvcCMBDP6HGVXdwngBWE264kGJwg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Krzysztof,

On 7/24/19 1:39 PM, Krzysztof Kozlowski wrote:
> On Mon, 22 Jul 2019 at 11:47, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>>
>> The patch adds AC timings information needed to support LPDDR3 and memory
>> controllers. The structure is used in of_memory and currently in Exynos
>> 5422 DMC. Add parsing data needed for LPDDR3 support.
>> It is currently used in Exynos5422 Dynamic Memory Controller.
>>
>> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   drivers/memory/jedec_ddr.h |  61 +++++++++++++++
>>   drivers/memory/of_memory.c | 154 +++++++++++++++++++++++++++++++++++++
>>   drivers/memory/of_memory.h |  18 +++++
>>   3 files changed, 233 insertions(+)
>>
>> diff --git a/drivers/memory/jedec_ddr.h b/drivers/memory/jedec_ddr.h
>> index 4a21b5044ff8..38e26d461bdb 100644
>> --- a/drivers/memory/jedec_ddr.h
>> +++ b/drivers/memory/jedec_ddr.h
>> @@ -29,6 +29,7 @@
>>   #define DDR_TYPE_LPDDR2_S4     3
>>   #define DDR_TYPE_LPDDR2_S2     4
>>   #define DDR_TYPE_LPDDR2_NVM    5
>> +#define DDR_TYPE_LPDDR3                6
>>
>>   /* DDR IO width */
>>   #define DDR_IO_WIDTH_4         1
>> @@ -169,4 +170,64 @@ extern const struct lpddr2_timings
>>          lpddr2_jedec_timings[NUM_DDR_TIMING_TABLE_ENTRIES];
>>   extern const struct lpddr2_min_tck lpddr2_jedec_min_tck;
>>
>> +/*
>> + * Structure for timings for LPDDR3 based on LPDDR2 plus additional fields.
>> + * All parameters are in pico seconds(ps) unless explicitly indicated
>> + * with a suffix like tRAS_max_ns below
>> + */
>> +struct lpddr3_timings {
>> +       u32 max_freq;
>> +       u32 min_freq;
>> +       u32 tRFC;
>> +       u32 tRRD;
>> +       u32 tRPab;
>> +       u32 tRPpb;
>> +       u32 tRCD;
>> +       u32 tRC;
>> +       u32 tRAS;
>> +       u32 tWTR;
>> +       u32 tWR;
>> +       u32 tRTP;
>> +       u32 tW2W_C2C;
>> +       u32 tR2R_C2C;
>> +       u32 tWL;
>> +       u32 tDQSCK;
>> +       u32 tRL;
>> +       u32 tFAW;
>> +       u32 tXSR;
>> +       u32 tXP;
>> +       u32 tCKE;
>> +       u32 tCKESR;
>> +       u32 tMRD;
>> +};
>> +
>> +/*
>> + * Min value for some parameters in terms of number of tCK cycles(nCK)
>> + * Please set to zero parameters that are not valid for a given memory
>> + * type
>> + */
>> +struct lpddr3_min_tck {
>> +       u32 tRFC;
>> +       u32 tRRD;
>> +       u32 tRPab;
>> +       u32 tRPpb;
>> +       u32 tRCD;
>> +       u32 tRC;
>> +       u32 tRAS;
>> +       u32 tWTR;
>> +       u32 tWR;
>> +       u32 tRTP;
>> +       u32 tW2W_C2C;
>> +       u32 tR2R_C2C;
>> +       u32 tWL;
>> +       u32 tDQSCK;
>> +       u32 tRL;
>> +       u32 tFAW;
>> +       u32 tXSR;
>> +       u32 tXP;
>> +       u32 tCKE;
>> +       u32 tCKESR;
>> +       u32 tMRD;
>> +};
>> +
>>   #endif /* __JEDEC_DDR_H */
>> diff --git a/drivers/memory/of_memory.c b/drivers/memory/of_memory.c
>> index 46539b27a3fb..4f5b8c81669f 100644
>> --- a/drivers/memory/of_memory.c
>> +++ b/drivers/memory/of_memory.c
>> @@ -3,6 +3,12 @@
>>    * OpenFirmware helpers for memory drivers
>>    *
>>    * Copyright (C) 2012 Texas Instruments, Inc.
>> + * Copyright (C) 2019 Samsung Electronics Co., Ltd.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
> 
> What's this?
My bad, in the meantime Thomas Gleixner has replaced the license header.
The old part has been automatically taken again during my re-base.
I will just remove the old license comment.

Regards,
Lukasz
> 
> Please, get a independent review or ack for this patch.
> 
> Best regards,
> Krzysztof
> 
> 
