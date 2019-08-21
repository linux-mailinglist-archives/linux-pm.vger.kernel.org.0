Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A05E5975DD
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2019 11:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbfHUJRd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Aug 2019 05:17:33 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:32800 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbfHUJRd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Aug 2019 05:17:33 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190821091731euoutp0282b957f1f2f7814312d08cda0e33be8d~85XK_tswN1967219672euoutp02H
        for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2019 09:17:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190821091731euoutp0282b957f1f2f7814312d08cda0e33be8d~85XK_tswN1967219672euoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1566379051;
        bh=U35GIxHynVoMQiX9hpVsNjntx2eSxTMxE+ImHzLg1gg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=F9kAHYCaiYsQXovnjCvYfwPVZTT2eUrbZa5j4hb3jcw9BARjkt/XW1IaJjowAjW2y
         BWi7j0ZswLwc2qLNgA19i9P0/AC/Yv6zGEHFraP5sSwzZYU0ut+VaVrIpu5KQQiBGd
         njHzWBAHrZh7gO5TeBekKrGc2fBd8grrV3W/OqRY=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190821091730eucas1p2ab9a0eac671a92205c4c68e104122634~85XJ6Akn_2177221772eucas1p2I;
        Wed, 21 Aug 2019 09:17:30 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id B6.EA.04374.92C0D5D5; Wed, 21
        Aug 2019 10:17:29 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190821091729eucas1p17ada82ea9bd6684652667c88e303d474~85XJGRuQ81444314443eucas1p1m;
        Wed, 21 Aug 2019 09:17:29 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190821091729eusmtrp21d39c8b8fdc88df54df01bce5b2b3e49~85XI36PNE1725317253eusmtrp2J;
        Wed, 21 Aug 2019 09:17:29 +0000 (GMT)
X-AuditID: cbfec7f5-4ddff70000001116-11-5d5d0c2972fb
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 01.3D.04117.92C0D5D5; Wed, 21
        Aug 2019 10:17:29 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190821091728eusmtip1bcba4252890d3013a86deabdc1e39f15~85XH9mgFU0853108531eusmtip1B;
        Wed, 21 Aug 2019 09:17:28 +0000 (GMT)
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
Message-ID: <21d22ba6-2254-ae5e-7ef4-5dfaa3f54229@partner.samsung.com>
Date:   Wed, 21 Aug 2019 11:17:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAJKOXPd96ExoCR-SiJfRqTbwO+_aQ6LSDVOQcrrt8JQHsoZBEw@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG+3auWrPT8vJmkjCIStAKu3xhRIHJITAq+yOSkTMPM3LLdrSy
        EldR62Z203Tp7MpkzcwL5q20TTIts1XkyG6kXdAszFTCsjweI//7vc/7vN/7PvCxhCqbDmS3
        GVIEo0GbpKa9ycr7P9tC503RaBY4GyJwaW4Jhdt/fKJwYeNjCt/o60T40NUSGp9rKVDgRyf0
        OKuzh8BtbbcY3HrwC4P7Tr6h8LOafBr3ZzYinNt2V4GLG18z+Hq7W4HdLatxx4EiGh++08hg
        1xczhUdelJK4/vka3DHsgwcfvEcrgXdYHYgfHDhL8t88hxn+oslN8tWW1wxfZj9G8/UFDobP
        PPSV5k9V2BFf/nAf3182a93kzd7LE4SkbbsE4/wVcd6JRS9Dkq8t3XPkcTVlQh1zjyMvFrhF
        cPpPHiWxiitCUPhZfxx5j/IPBJ6SWoVc9CNovvWR+Ddhbcgdb9gQ1B7NpOSiF8G9B05ack3n
        NsDQm1dj7MvNg/bfQ2MmgqunwHPQPvoUy9JcGFTZd0oeJRcFNXn3aUkmudnw27VYkv24TfD9
        nYuSLdOgOa+LlNiLWw+VJ1xjzxNcALzsKlTIHAy3e/MJaRVwHhZspWZKvjoS6rId4wmmQ3dT
        BSNzEPyploeBE8GUeRnJvB86swrGPRHganJT0m3EaJaSmvmyvApGip4iSQbOBzy90+QTfOBs
        5QVClpVw9IhKds+FipNPxhf5g82Rw5xGasuEYJYJYSwTwlj+772ESDsKEFJFvU4Qww3C7jBR
        qxdTDbqwrTv0ZWj0sz4caRqoQnd/xTsRxyL1FGVce6xGRWl3iWl6JwKWUPsq9+Rv1qiUCdq0
        vYJxxxZjapIgOtFMllQHKPdNeher4nTaFGG7ICQLxn9dBesVaEL68qn7czbODLYaVA1xFPkW
        DSW07JwxfNOR0helM0/2CzdHN5tnVPnT16/1QuuVznsKq7XbVBBdnKbL6on56hX5othPE7Gg
        K/DMk9q0wYsffDLWl48sCc+mbKEZ/vG3h0KLifSMb33VqWuXE8ExKT11tqBlGbGv3KxheE5Q
        0/l0NSkmaheGEEZR+xeNpQmlqAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRjG+e9cLRenOfOPH9QG3QRPHZfur5gFUR2kD1Zfwhpr1EnFXWxn
        htqHTLPylloQOq+gRk2jNNFlpqZipeali2Y2KbWim6KmFqnkXIHfHp7n+fG+L7w0JrMSnnS0
        wSyYDFqdglyDdy09sfttc1Wrd9hmCVSdd5dAgz8/E6ikvYdAlVNjAKWU3SXR9c4iCerO0KPs
        sW8Y6u29R6Hnyd8pNJU5QqCXDYUkmslqByivt0mC7rTbKVQx2C9B/Z370PCFWyRKfdROobbv
        lwm0NFCNo+ZXYWj4zzo093QU7IF8VXEV4Odmr+H85JtUii9I6sf5BxY7xddY00i+uaiK4rNS
        Jkj+aq0V8Pe7zvEzNV7hayPYEJMxziz4RBlF8y7FMQ75s1wQYv13BrGcUqUO9g9QbA8NOSXo
        os8Kpu2hJ9ioW299Y8tV8Zd6HhBJYHhrOnChIbMTFrfkSdLBGlrGVADYkPsJdwYb4LWmesqp
        3eDCQDrpLH0DsDt5VOII3JjDcH7kHenQcmYbHFycJxwljGkm4GhL5j8iRwKfFI8sEzRNMiy0
        Wc84ACmzHzbkd5AOG2c2wcW2AIftzhyFbTYLcFbWw2f54ysLuTCHYF1G28osjAmExfc/YE7t
        Ad+Ol0ic2hvW/yjEcoDMsgq3rEIsqxDLKqQU4FYgF+JEfaRe9GdFrV6MM0SyJ436GrD8J3Ud
        v2ttIH3iSCtgaKBwldqGjqllhPasmKBvBZDGFHJpfGGEWiY9pU1IFExGjSlOJ4itIGD5tlzM
        0/2kcfnrDGYNF8CpUBCnUqqUgUjhIb3CPD4uYyK1ZiFGEGIF039OQrt4JgEvpfzp14FE8vzt
        3Massqz3Exv76jrhi4NyN67x4/XX00vs/AGpq27y9NFsnHfzi77Z2FLpoq690ZFgjqlLUyXo
        rOWbpydr+epGw5GbC5yPZnegu6D0DpvVnIkP/tW8N/bxq69N9taHBYWX7Bc/GdCX7C1DnY88
        SqnF8L7Eeb9YBS5GaTlfzCRq/wL8G6CMPQMAAA==
X-CMS-MailID: 20190821091729eucas1p17ada82ea9bd6684652667c88e303d474
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190722094727eucas1p10041ba25819e6e62d639423a97435f2d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190722094727eucas1p10041ba25819e6e62d639423a97435f2d
References: <CGME20190722094727eucas1p10041ba25819e6e62d639423a97435f2d@eucas1p1.samsung.com>
        <20190722094646.13342-1-l.luba@partner.samsung.com>
        <20190722094646.13342-4-l.luba@partner.samsung.com>
        <CAJKOXPd96ExoCR-SiJfRqTbwO+_aQ6LSDVOQcrrt8JQHsoZBEw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Krzysztof,

On 7/24/19 1:31 PM, Krzysztof Kozlowski wrote:
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
> 
> To which tRAS_max_ns are you referring?
The comment failed to stand the test of time, not for the first time
though. I will update it according to the current struct.

> 
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
>>    */
>>
>>   #include <linux/device.h>
>> @@ -149,3 +155,151 @@ const struct lpddr2_timings *of_get_ddr_timings(struct device_node *np_ddr,
>>          return lpddr2_jedec_timings;
>>   }
>>   EXPORT_SYMBOL(of_get_ddr_timings);
>> +
>> +/**
>> + * of_lpddr3_get_min_tck() - extract min timing values for lpddr3
>> + * @np: pointer to ddr device tree node
>> + * @device: device requesting for min timing values
>> + *
>> + * Populates the lpddr3_min_tck structure by extracting data
>> + * from device tree node. Returns a pointer to the populated
>> + * structure. If any error in populating the structure, returns NULL.
>> + */
>> +const struct lpddr3_min_tck *of_lpddr3_get_min_tck(struct device_node *np,
>> +                                                  struct device *dev)
>> +{
>> +       int                     ret = 0;
>> +       struct lpddr3_min_tck   *min;
>> +
>> +       min = devm_kzalloc(dev, sizeof(*min), GFP_KERNEL);
>> +       if (!min)
>> +               goto default_min_tck;
>> +
>> +       ret |= of_property_read_u32(np, "tRFC-min-tck", &min->tRFC);
>> +       ret |= of_property_read_u32(np, "tRRD-min-tck", &min->tRRD);
>> +       ret |= of_property_read_u32(np, "tRPab-min-tck", &min->tRPab);
>> +       ret |= of_property_read_u32(np, "tRPpb-min-tck", &min->tRPpb);
>> +       ret |= of_property_read_u32(np, "tRCD-min-tck", &min->tRCD);
>> +       ret |= of_property_read_u32(np, "tRC-min-tck", &min->tRC);
>> +       ret |= of_property_read_u32(np, "tRAS-min-tck", &min->tRAS);
>> +       ret |= of_property_read_u32(np, "tWTR-min-tck", &min->tWTR);
>> +       ret |= of_property_read_u32(np, "tWR-min-tck", &min->tWR);
>> +       ret |= of_property_read_u32(np, "tRTP-min-tck", &min->tRTP);
>> +       ret |= of_property_read_u32(np, "tW2W-C2C-min-tck", &min->tW2W_C2C);
>> +       ret |= of_property_read_u32(np, "tR2R-C2C-min-tck", &min->tR2R_C2C);
>> +       ret |= of_property_read_u32(np, "tWL-min-tck", &min->tWL);
>> +       ret |= of_property_read_u32(np, "tDQSCK-min-tck", &min->tDQSCK);
>> +       ret |= of_property_read_u32(np, "tRL-min-tck", &min->tRL);
>> +       ret |= of_property_read_u32(np, "tFAW-min-tck", &min->tFAW);
>> +       ret |= of_property_read_u32(np, "tXSR-min-tck", &min->tXSR);
>> +       ret |= of_property_read_u32(np, "tXP-min-tck", &min->tXP);
>> +       ret |= of_property_read_u32(np, "tCKE-min-tck", &min->tCKE);
>> +       ret |= of_property_read_u32(np, "tCKESR-min-tck", &min->tCKESR);
>> +       ret |= of_property_read_u32(np, "tMRD-min-tck", &min->tMRD);
>> +
>> +       if (ret) {
>> +               dev_warn(dev, "%s: errors while parsing min-tck values\n",
>> +                        __func__);
>> +               devm_kfree(dev, min);
>> +               goto default_min_tck;
>> +       }
>> +
>> +       return min;
>> +
>> +default_min_tck:
>> +       dev_warn(dev, "%s: using default min-tck values\n", __func__);
> 
> Here and later - you return NULL, not default values. Your driver -
> consumer - also behaves like with error condition, not like with
> default values. Print just that you cannot get timings, I guess.
OK, thank you. I will change the print.

Thank you for the review.

Regards,
Lukasz
> 
> Best regards,
> Krzysztof
> 
> 
