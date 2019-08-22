Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 074709952A
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2019 15:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732190AbfHVNez (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Aug 2019 09:34:55 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:60378 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732813AbfHVNez (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Aug 2019 09:34:55 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190822133453euoutp019fc9386eced6a19f547f5d5a5152dd21~9QhKin32T2450924509euoutp01A
        for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2019 13:34:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190822133453euoutp019fc9386eced6a19f547f5d5a5152dd21~9QhKin32T2450924509euoutp01A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1566480893;
        bh=ISRXkLXZPAXnwckdf6fmHNHgi8FTAkZ5Xn05li/Orso=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Ku3aBvu8g9B+pz5/FdXgzyaxqkSeKkq/b6LrFLrb9TSPLsKXNByYvCt/rvPLItVOP
         j4POKSmNl2J+v3XxILyNc++2pDv2GPLN3398razIAB6i0iyeHVFmzRR+SnPUyhtmHk
         A1LKFfYPSewGFkZef6nq6ni6IOx+CcdhFAjVpFBg=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190822133451eucas1p17120c9f1fa2393606ee4f34f55452148~9QhJX_N190655906559eucas1p1b;
        Thu, 22 Aug 2019 13:34:51 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 8C.62.04469.BF99E5D5; Thu, 22
        Aug 2019 14:34:51 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190822133451eucas1p1405e041220e236608fad9900ae19aa93~9QhIfp3qh1266212662eucas1p16;
        Thu, 22 Aug 2019 13:34:51 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190822133450eusmtrp13ba9603adcc70d8430d7db62d1b4bad0~9QhIOsF3u3229032290eusmtrp1C;
        Thu, 22 Aug 2019 13:34:50 +0000 (GMT)
X-AuditID: cbfec7f2-994db9c000001175-c7-5d5e99fb1276
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 6C.F5.04117.AF99E5D5; Thu, 22
        Aug 2019 14:34:50 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190822133449eusmtip18a766d673f80c63dd25808d8b84d4372~9QhHSDxXv0904109041eusmtip1O;
        Thu, 22 Aug 2019 13:34:49 +0000 (GMT)
Subject: Re: [PATCH v10 06/13] drivers: memory: extend of_memory by LPDDR3
 support
To:     Krzysztof Kozlowski <krzk@kernel.org>, gregkh@linuxfoundation.org,
        Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-clk@vger.kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        =?UTF-8?Q?Bart=c5=82omiej_=c5=bbo=c5=82nierkiewicz?= 
        <b.zolnierkie@samsung.com>, kgene@kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        kyungmin.park@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        keescook@chromium.org, tony@atomide.com, jroedel@suse.de,
        treding@nvidia.com, digetx@gmail.com, willy.mh.wolff.ml@gmail.com
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <2e35d4bc-92b9-cba7-bd05-a41a1dcb300e@partner.samsung.com>
Date:   Thu, 22 Aug 2019 15:34:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAJKOXPcDDyYmuX-RpkpxKSBK2JfV=tYakn+g8FM5Lau+rmkm+g@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0iTURjHO3uvjibHpflQUrTuQWrUhwPdo8tLBCUUiV1s1put3LK9atcP
        K7uumaZddCkVJoVZOnVmMpLUtvLS0i5aUQw1ummXuRUlWM23yG+/539+h/N/4PCU2sKO4nWG
        FNFo0CZpWCVd5fzhnt6ft3FDdEb2JGLLLWVIu+8tQy42PGTI9a9diKQXlrIkp7FAQZpP6klm
        10eKuN1lHGk51MORr5bXDHlck8+SvowGRHLddxTkRsMrjrQ2LiEvD15jyS9HNUfqe44xZOCZ
        jSa1T5aTl/3B5Nv9TrQgXPjmz6aFzx1HOOGCqZUWbltfcUJ58QlWqC0o4YSM9E+scKqyGAkV
        TfuFvvIxq5RxyjlbxCRdmmiMmrdJue2Myc8lOxL2vEm3sSb0fpkZBfGAZ0GWs11hRkpeja8h
        sDjLkDz4EFQ/PkwHLDXuQ1DkWfHvxtmfbbQsXUVwzOVh5KEXwYkbx6mANQKvhubapyjAoXgr
        tLv7uYBE4R80OPN8rBnxPIsjobp4V8BR4aXQ6ShkA0zjiWDraRvkMBwLXk89Izsh8CCve7BR
        EI6BnCv2QYfC4fCi+6JC5rFwqzefkps28+CoWSnzYujtvIdkHgEfXJWczBHQlGOhZZbAlHH5
        r3MAujIL/jqzod7VygQqU3gqlNZEyfFC8N5rVARiwMHQ0RsiNwiG7KrzlByr4PhRtWxPgUrL
        I4XMI+FqyTkuC2msQ/ayDtnFOmQX6/93LyG6GIWLqZI+UZRmGMTdkZJWL6UaEiM379SXoz9/
        tGnA5a1G/raEOoR5pBmuum/euEHNaNOkvfo6BDylCVWlnf4TqbZo9+4TjTvjjalJolSHRvO0
        Jly1f5hnnRonalPEHaKYLBr/nSr4oFEmpIi/+WFxyIGWMCkioi4q2har88P3y4aq7jnrB8pw
        3Oxxp1oi1+yLscxqSLDXeFKU831fejKP6CZUfIzdPl+fnO97623y2D8VuNZeeuQN61Cnzwz9
        fPd7lv/w7kLdmdxGQ0TV8BJYYziNueiiydud65jraG1omsP8fK69/519/CINLW3TzphGGSXt
        b5pKwBifAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEKsWRmVeSWpSXmKPExsVy+t/xu7q/ZsbFGkz8oGaxccZ6VovrX56z
        Wsw/co7VYvXHx4wWzYvXs1lMPjWXyeJMd65F/+PXzBbnz29gtzjb9Ibd4mPPPVaLy7vmsFl8
        7j3CaDHj/D4mi7VH7rJbXDzlanG7cQWbxf89O9gtDr9pZ7X4d20ji8X+K14Wt3/zWXw78YjR
        Qdzj29dJLB7vb7Sye8xuuMjisXPWXXaPTas62Tz2z13D7tHb/I7No2/LKkaPzaerPT5vkgvg
        itKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DLmNLw
        lb1gT1LF0+aNbA2ML927GDk5JARMJKb+usTSxcjFISSwlFFi8tudTBAJMYlJ+7azQ9jCEn+u
        dbFBFL1mlLhyfA0rSEJYIETizP6rjCC2iECaxOdpf8EmMQv8ZJFoPzcXauwEJokT1/cCdXBw
        sAnoSexYVQjSwCvgJvFoz2I2EJtFQFVi45tLYLaoQITE4R2zGCFqBCVOznzCAmJzCgRKTF6y
        FayGWcBMYt7mh8wQtrjErSfzmSBseYntb+cwT2AUmoWkfRaSlllIWmYhaVnAyLKKUSS1tDg3
        PbfYSK84Mbe4NC9dLzk/dxMjMH1sO/Zzyw7GrnfBhxgFOBiVeHhPdMXFCrEmlhVX5h5ilOBg
        VhLhLZsIFOJNSaysSi3Kjy8qzUktPsRoCvTcRGYp0eR8YGrLK4k3NDU0t7A0NDc2NzazUBLn
        7RA4GCMkkJ5YkpqdmlqQWgTTx8TBKdXAeO3JGyGTFVsWhqzu/X6t2IfFOc5TySAg2kzG4/fJ
        evFPe+TZPsdFKF3UL0+4KlSkuut2SeDzu4XRN9Q9S6Xr1h7Zm+azaGnYLsUlFRuWn3dobuYO
        Ovno7czt85/1cVy69+XAK772piO7zHP69C5s2ySh9urxi9377ryYa7Z3o5rdtsb56Qtu/1Ri
        Kc5INNRiLipOBACgnHdeNQMAAA==
X-CMS-MailID: 20190822133451eucas1p1405e041220e236608fad9900ae19aa93
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190614095325eucas1p20083d9290b36eca945ec3f1428bdbd4f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190614095325eucas1p20083d9290b36eca945ec3f1428bdbd4f
References: <CGME20190614095325eucas1p20083d9290b36eca945ec3f1428bdbd4f@eucas1p2.samsung.com>
        <20190614095309.24100-1-l.luba@partner.samsung.com>
        <20190614095309.24100-7-l.luba@partner.samsung.com>
        <CAJKOXPcDDyYmuX-RpkpxKSBK2JfV=tYakn+g8FM5Lau+rmkm+g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 6/14/19 2:43 PM, Krzysztof Kozlowski wrote:
> On Fri, 14 Jun 2019 at 11:53, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>>
>> The patch adds AC timings information needed to support LPDDR3 and memory
>> controllers. The structure is used in of_memory and currently in Exynos
>> 5422 DMC. Add parsing data needed for LPDDR3 support.
>> It is currently used in Exynos5422 Dynamic Memory Controller.
>>
>> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   drivers/memory/of_memory.c | 154 +++++++++++++++++++++++++++++++++++++
>>   drivers/memory/of_memory.h |  18 +++++
>>   include/memory/jedec_ddr.h |  62 +++++++++++++++
>>   3 files changed, 234 insertions(+)
> 
> Previously this was going through Greg, so if I am going to take it
> along with drivers/memory/samsung patches, I need some acks.
> 
> Greg, Rob,
> Are you okay with this patch and with taking it through samsung-soc?

Greg, Rob: gentle ping.

Currently there is a v13, with only minor changes to this patch:
https://lkml.org/lkml/2019/8/21/289
(you are on cc list of the patch set)

Could you please have a look. Thank you.

Regards,
Lukasz

> 
> Best regards,
> Krzysztof
>> diff --git a/drivers/memory/of_memory.c b/drivers/memory/of_memory.c
>> index 12a61f558644..30f3a3e75063 100644
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
>> @@ -148,3 +154,151 @@ const struct lpddr2_timings *of_get_ddr_timings(struct device_node *np_ddr,
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
>> +       return NULL;
>> +}
>> +EXPORT_SYMBOL(of_lpddr3_get_min_tck);
>> +
>> +static int of_lpddr3_do_get_timings(struct device_node *np,
>> +                                   struct lpddr3_timings *tim)
>> +{
>> +       int ret;
>> +
>> +       /* The 'reg' param required since DT has changed, used as 'max-freq' */
>> +       ret = of_property_read_u32(np, "reg", &tim->max_freq);
>> +       ret |= of_property_read_u32(np, "min-freq", &tim->min_freq);
>> +       ret |= of_property_read_u32(np, "tRFC", &tim->tRFC);
>> +       ret |= of_property_read_u32(np, "tRRD", &tim->tRRD);
>> +       ret |= of_property_read_u32(np, "tRPab", &tim->tRPab);
>> +       ret |= of_property_read_u32(np, "tRPpb", &tim->tRPpb);
>> +       ret |= of_property_read_u32(np, "tRCD", &tim->tRCD);
>> +       ret |= of_property_read_u32(np, "tRC", &tim->tRC);
>> +       ret |= of_property_read_u32(np, "tRAS", &tim->tRAS);
>> +       ret |= of_property_read_u32(np, "tWTR", &tim->tWTR);
>> +       ret |= of_property_read_u32(np, "tWR", &tim->tWR);
>> +       ret |= of_property_read_u32(np, "tRTP", &tim->tRTP);
>> +       ret |= of_property_read_u32(np, "tW2W-C2C", &tim->tW2W_C2C);
>> +       ret |= of_property_read_u32(np, "tR2R-C2C", &tim->tR2R_C2C);
>> +       ret |= of_property_read_u32(np, "tFAW", &tim->tFAW);
>> +       ret |= of_property_read_u32(np, "tXSR", &tim->tXSR);
>> +       ret |= of_property_read_u32(np, "tXP", &tim->tXP);
>> +       ret |= of_property_read_u32(np, "tCKE", &tim->tCKE);
>> +       ret |= of_property_read_u32(np, "tCKESR", &tim->tCKESR);
>> +       ret |= of_property_read_u32(np, "tMRD", &tim->tMRD);
>> +
>> +       return ret;
>> +}
>> +
>> +/**
>> + * of_lpddr3_get_ddr_timings() - extracts the lpddr3 timings and updates no of
>> + * frequencies available.
>> + * @np_ddr: Pointer to ddr device tree node
>> + * @dev: Device requesting for ddr timings
>> + * @device_type: Type of ddr
>> + * @nr_frequencies: No of frequencies available for ddr
>> + * (updated by this function)
>> + *
>> + * Populates lpddr3_timings structure by extracting data from device
>> + * tree node. Returns pointer to populated structure. If any error
>> + * while populating, returns NULL.
>> + */
>> +const struct lpddr3_timings
>> +*of_lpddr3_get_ddr_timings(struct device_node *np_ddr, struct device *dev,
>> +                          u32 device_type, u32 *nr_frequencies)
>> +{
>> +       struct lpddr3_timings   *timings = NULL;
>> +       u32                     arr_sz = 0, i = 0;
>> +       struct device_node      *np_tim;
>> +       char                    *tim_compat = NULL;
>> +
>> +       switch (device_type) {
>> +       case DDR_TYPE_LPDDR3:
>> +               tim_compat = "jedec,lpddr3-timings";
>> +               break;
>> +       default:
>> +               dev_warn(dev, "%s: un-supported memory type\n", __func__);
>> +       }
>> +
>> +       for_each_child_of_node(np_ddr, np_tim)
>> +               if (of_device_is_compatible(np_tim, tim_compat))
>> +                       arr_sz++;
>> +
>> +       if (arr_sz)
>> +               timings = devm_kcalloc(dev, arr_sz, sizeof(*timings),
>> +                                      GFP_KERNEL);
>> +
>> +       if (!timings)
>> +               goto default_timings;
>> +
>> +       for_each_child_of_node(np_ddr, np_tim) {
>> +               if (of_device_is_compatible(np_tim, tim_compat)) {
>> +                       if (of_lpddr3_do_get_timings(np_tim, &timings[i])) {
>> +                               devm_kfree(dev, timings);
>> +                               goto default_timings;
>> +                       }
>> +                       i++;
>> +               }
>> +       }
>> +
>> +       *nr_frequencies = arr_sz;
>> +
>> +       return timings;
>> +
>> +default_timings:
>> +       dev_warn(dev, "%s: using default timings\n", __func__);
>> +       *nr_frequencies = 0;
>> +       return NULL;
>> +}
>> +EXPORT_SYMBOL(of_lpddr3_get_ddr_timings);
>> diff --git a/drivers/memory/of_memory.h b/drivers/memory/of_memory.h
>> index b077cc836b0b..e39ecc4c733d 100644
>> --- a/drivers/memory/of_memory.h
>> +++ b/drivers/memory/of_memory.h
>> @@ -14,6 +14,11 @@ extern const struct lpddr2_min_tck *of_get_min_tck(struct device_node *np,
>>   extern const struct lpddr2_timings
>>          *of_get_ddr_timings(struct device_node *np_ddr, struct device *dev,
>>          u32 device_type, u32 *nr_frequencies);
>> +extern const struct lpddr3_min_tck
>> +       *of_lpddr3_get_min_tck(struct device_node *np, struct device *dev);
>> +extern const struct lpddr3_timings
>> +       *of_lpddr3_get_ddr_timings(struct device_node *np_ddr,
>> +       struct device *dev, u32 device_type, u32 *nr_frequencies);
>>   #else
>>   static inline const struct lpddr2_min_tck
>>          *of_get_min_tck(struct device_node *np, struct device *dev)
>> @@ -27,6 +32,19 @@ static inline const struct lpddr2_timings
>>   {
>>          return NULL;
>>   }
>> +
>> +static inline const struct lpddr3_min_tck
>> +       *of_lpddr3_get_min_tck(struct device_node *np, struct device *dev)
>> +{
>> +       return NULL;
>> +}
>> +
>> +static inline const struct lpddr3_timings
>> +       *of_lpddr3_get_ddr_timings(struct device_node *np_ddr,
>> +       struct device *dev, u32 device_type, u32 *nr_frequencies)
>> +{
>> +       return NULL;
>> +}
>>   #endif /* CONFIG_OF && CONFIG_DDR */
>>
>>   #endif /* __LINUX_MEMORY_OF_REG_ */
>> diff --git a/include/memory/jedec_ddr.h b/include/memory/jedec_ddr.h
>> index ddad0f870e5d..3601825f807d 100644
>> --- a/include/memory/jedec_ddr.h
>> +++ b/include/memory/jedec_ddr.h
>> @@ -32,6 +32,7 @@
>>   #define DDR_TYPE_LPDDR2_S4     3
>>   #define DDR_TYPE_LPDDR2_S2     4
>>   #define DDR_TYPE_LPDDR2_NVM    5
>> +#define DDR_TYPE_LPDDR3                6
>>
>>   /* DDR IO width */
>>   #define DDR_IO_WIDTH_4         1
>> @@ -172,4 +173,65 @@ extern const struct lpddr2_timings
>>          lpddr2_jedec_timings[NUM_DDR_TIMING_TABLE_ENTRIES];
>>   extern const struct lpddr2_min_tck lpddr2_jedec_min_tck;
>>
>> +
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
>>   #endif /* __LINUX_JEDEC_DDR_H */
>> --
>> 2.17.1
>>
> 
> 
