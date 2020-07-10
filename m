Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18E6621B70B
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jul 2020 15:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgGJNti (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jul 2020 09:49:38 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:43785 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbgGJNti (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jul 2020 09:49:38 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200710134936euoutp01ad5235a3be15302e8b5cf8c608b11840~gaFOF_lW10257302573euoutp01N
        for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2020 13:49:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200710134936euoutp01ad5235a3be15302e8b5cf8c608b11840~gaFOF_lW10257302573euoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1594388976;
        bh=7/l5EuCBz+J5pR0/SYvXxWUmYxH8RHGJGKjz4yVojoU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=nFI0k5r41Fw9g1cfqzSmdpYA8MaODe1a/+at2ymVhyu4suZZYFWBmADCQrBuAu3n5
         PTPeUKq2s1cKBDKMNkcZ4We3E/I4e3lBNleTpjeKwOvMki2upvqmZRBBqbQefYkVQF
         QrGspWjD9puPlhhKRnrPg8LjkWdeMPOr+eZ+phdc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200710134935eucas1p28dbfd62d73ad4a82d33e12618ac8f3bf~gaFN1sWFY3053330533eucas1p28;
        Fri, 10 Jul 2020 13:49:35 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 4B.A1.05997.FE1780F5; Fri, 10
        Jul 2020 14:49:35 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200710134935eucas1p1ccd2cbcae4729edf7e16f185148362c9~gaFNbQFtj2710327103eucas1p14;
        Fri, 10 Jul 2020 13:49:35 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200710134935eusmtrp1494e2f5a852197c5173fe7798eab11c8~gaFNZmvTG2132721327eusmtrp1B;
        Fri, 10 Jul 2020 13:49:35 +0000 (GMT)
X-AuditID: cbfec7f4-65dff7000000176d-05-5f0871ef1859
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id E2.5D.06314.FE1780F5; Fri, 10
        Jul 2020 14:49:35 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200710134934eusmtip12bec0400d3aa4a3a8cd7fe85ec8a75a1~gaFMvm3kg1055310553eusmtip1y;
        Fri, 10 Jul 2020 13:49:34 +0000 (GMT)
Subject: Re: [PATCH 1/2] memory: samsung: exynos5422-dmc: Adjust polling
 interval and uptreshold
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, willy.mh.wolff.ml@gmail.com,
        k.konieczny@samsung.com, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        s.nawrocki@samsung.com, kgene@kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <ef88644a-a75d-82c0-8b60-eb2810c68f58@samsung.com>
Date:   Fri, 10 Jul 2020 15:49:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <0bfb4332-9a2e-9ff9-1a86-d9875a8f34bb@arm.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUhTYRjl3f3YnTq5Ts2XWQoDkww1y+CSYRZD9iepfoWRNudNLTdt8yMr
        Sl2paX41IltlmjHNNNfyYwoJTslCdMrKxNIircw5JWeipta2q+S/85znnPd5zsNLIDwTxieS
        ZGm0XCZOFuBOaOvr5YHAuQtE7J7Gst1U+cg7lPqw8AOjquYrMKp0woxQRqOWTfXnzrAp3cQw
        Rpk6HuCUtbgHUBXGThZVnXudTX3MqcOp7pl8jFp88xVEuIoaKhuAqF09xhbp6m/iopdProlK
        muuByKrzOYZHOx2Mp5OTMmh5cPgZp8Su4Rw0dRxerDSVIdmgxaMQcAhIhkLTzHdWIXAieGQd
        gO1r64ApFgB8tt6MMYUVwIfqzzYZ4bBYew4xfK2Nb+tCmcICoHV8ELe/607GQY1ZxbJjD9IP
        Dg+OOUQIqURgvm4Vszdw8gAsz68Hdswlw+H07BBqx6jNYNGPO8ye5Ek4/6UbYzRu8O29SYeG
        Q4bB6qYihwYhveDo5KMN7AuVLfcR+zBIWtjQqK9BmKRCqGq4s4Hd4XRvM5vB22Gf6hbKGJ4D
        uFYwteFuA7BWtY4zqjD4aWAFtx8AIXfBpo5ghj4Mi1dK2cxdXOGIxY1ZwhXebr2LMDQXFuTx
        GPVOqNVo8c2xhe1PkTIgUG+Jpt4SR70ljvr/3CqA1gMvOl0hTaAVe2V0ZpBCLFWkyxKCJClS
        HbB9tb713gU96FiNMwCSAAIXbpWYiOVh4gxFltQAIIEIPLhH+vtieNx4cdYlWp4SK09PphUG
        4E2gAi/uvsc/T/PIBHEafZ6mU2n5ZpdFcPjZwFMIOOYXmUf5iIs2NIr4UxSo8jzVsU0YOiWN
        8O8citFI4gMjQuYmzh3Pq27BfhcodYv+V0ti1DusV8KXVD5C75xuSdpf/dyQc6Nb75hwv0zL
        D7/869uJ0pH3ZueGV/zIZWWogU496yeZLTdqlow1AVFeN3z946InR6PHIsP6BagiURwSgMgV
        4n+4hVx/ZgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRmVeSWpSXmKPExsVy+t/xu7rvCzniDQ5e5rSYeOMKi8X1L89Z
        LRZ8msFq0f/4NbPF+fMb2C3ONr1ht9j0+BqrxeVdc9gsPvceYbSYcX4fk8XCphZ2i9uNK9gs
        Dr9pZ7X4duIRowOfx5p5axg9ds66y+6xaVUnm8fmJfUefVtWMXp83iQXwBalZ1OUX1qSqpCR
        X1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl3HwWiNLwT2JinmXJzA3
        MG4V6WLk4JAQMJH4fMS+i5GLQ0hgKaPE6ovHWSHiMhLH15d1MXICmcISf651sUHUvGaUWLqw
        kQ0kISyQJLHs9WQmEFtEQFXi2oW7LCBFzALNzBLLd11ihuh4zyRxdu0+sA42ASuJie2rGEFs
        XgE7iVfvLrKA2CxA3W933AObJCoQIXF4xyyoGkGJkzOfgNVwClhLLFzfDVbDLKAu8WceyAIQ
        W1zi1pP5UHF5ieats5knMArNQtI+C0nLLCQts5C0LGBkWcUoklpanJueW2yoV5yYW1yal66X
        nJ+7iREYw9uO/dy8g/HSxuBDjAIcjEo8vAsSOeKFWBPLiitzDzFKcDArifA6nT0dJ8SbklhZ
        lVqUH19UmpNafIjRFOi5icxSosn5wPSSVxJvaGpobmFpaG5sbmxmoSTO2yFwMEZIID2xJDU7
        NbUgtQimj4mDU6qB0ZxFpm5qh4PP/CppD8sTJr9Y/11MORDJs3az68XLfUtXcnswtjpkSjyP
        4xNldRUL6HavnZHyYIUP47WY9wuuvDhc7mvTz1wn/MnKPdT98M//UcEaPZ47lW2YBCJ7omzm
        PXzzaKdmkmI5M1NUq7L5PqUvPqZpV5YvrLmm23ohmWOFQcz/ty+UWIozEg21mIuKEwH7XguV
        9wIAAA==
X-CMS-MailID: 20200710134935eucas1p1ccd2cbcae4729edf7e16f185148362c9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200708153448epcas1p438fae2327ac69fcc1a78d9c73cfda501
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200708153448epcas1p438fae2327ac69fcc1a78d9c73cfda501
References: <20200708153420.29484-1-lukasz.luba@arm.com>
        <CGME20200708153448epcas1p438fae2327ac69fcc1a78d9c73cfda501@epcas1p4.samsung.com>
        <20200708153420.29484-2-lukasz.luba@arm.com>
        <fa3f651a-3c2b-188b-e2dc-4fd05ce4a1b7@samsung.com>
        <a676fc18-6f1f-8502-e8d5-5ad1ccf0eec6@arm.com> <20200710124503.GB22897@pi3>
        <0bfb4332-9a2e-9ff9-1a86-d9875a8f34bb@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 7/10/20 2:56 PM, Lukasz Luba wrote:
> 
> 
> On 7/10/20 1:45 PM, Krzysztof Kozlowski wrote:
>> On Fri, Jul 10, 2020 at 09:34:45AM +0100, Lukasz Luba wrote:
>>> Hi Chanwoo,
>>>
>>> On 7/9/20 5:08 AM, Chanwoo Choi wrote:
>>>> Hi Lukasz,
>>>>
>>>> On 7/9/20 12:34 AM, Lukasz Luba wrote:
>>>>> In order to react faster and make better decisions under some workloads,
>>>>> benchmarking the memory subsystem behavior, adjust the polling interval
>>>>> and upthreshold value used by the simple_ondemand governor.
>>>>>
>>>>> Reported-by: Willy Wolff <willy.mh.wolff.ml@gmail.com>
>>>>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>>>>> ---
>>>>>    drivers/memory/samsung/exynos5422-dmc.c | 4 ++--
>>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/memory/samsung/exynos5422-dmc.c b/drivers/memory/samsung/exynos5422-dmc.c
>>>>> index 93e9c2429c0d..e03ee35f0ab5 100644
>>>>> --- a/drivers/memory/samsung/exynos5422-dmc.c
>>>>> +++ b/drivers/memory/samsung/exynos5422-dmc.c
>>>>> @@ -1466,10 +1466,10 @@ static int exynos5_dmc_probe(struct platform_device *pdev)
>>>>>             * Setup default thresholds for the devfreq governor.
>>>>>             * The values are chosen based on experiments.
>>>>>             */
>>>>> -        dmc->gov_data.upthreshold = 30;
>>>>> +        dmc->gov_data.upthreshold = 10;
>>>>>            dmc->gov_data.downdifferential = 5;
>>>>> -        exynos5_dmc_df_profile.polling_ms = 500;
>>>>> +        exynos5_dmc_df_profile.polling_ms = 100;
>>>>>        }
>>>>>
>>>>
>>>> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>>>>
>>>
>>> Thank you for the review. Do you think this patch could go through
>>> your tree together with your patches?
>>>
>>> I don't know Krzysztof's opinion about the patch 2/2, but
>>> I would expect, assuming the patch itself is correct, he would
>>> like to take it into his next/dt branch.
>>
>> In the cover letter you mentioned that this is a follow up for the
>> Chanwoo's patchset. But are these patches really depending on it? Can
>> they be picked up independently?
> 
> 
> They are not heavily dependent on Chanwoo's patches.
> Yes, they can be picked up independently.

Hmmm, are you sure?

Sure, they will apply fine but without Chanwoo's patches won't they
cause the dmc driver to use using polling mode with deferred timer
(unintended/bad behavior) instead of IRQs (current behavior) or
polling mode with delayed timer (future behavior)?

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> I just wanted to mention that the patch 1/2 was produced on the
> code base which had already applied Chanwoo's patch for DMC.
> If you like to take both 1/2 and 2/2 into your tree, it's good.
> 
> Thank you for having a look on this.
> 
> Regards,
> Lukasz
> 
> 
>>
>> The DTS patch must go through arm soc, so I will take it. If it really
>> depends on driver changes, then it has to wait for next release.
>>
>> Best regards,
>> Krzysztof
>>

