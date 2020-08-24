Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40F3624F34F
	for <lists+linux-pm@lfdr.de>; Mon, 24 Aug 2020 09:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgHXHpB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Aug 2020 03:45:01 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:40129 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbgHXHpA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Aug 2020 03:45:00 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200824074457euoutp0194ff7cb76a6f8d5f754586e7ec49c208~uJIsa83L40548305483euoutp01S
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2020 07:44:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200824074457euoutp0194ff7cb76a6f8d5f754586e7ec49c208~uJIsa83L40548305483euoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1598255097;
        bh=NKVy/sWYWG971/QVRyY0L+mpzmMtV3Lqj3zUr4SbB04=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Tl2QZJr3VsEaXxDOTDmz3WvAUZuJDrFdvBvZKJLjHPD9hcmwWMd9qL2xCtgVf6vBk
         oHqNcCxJkXn/49ll0p/Hflk2MMwsNwPv2gO3pX4+2Si8KHJUlsckeVLgn917iwno4o
         FIU9BHHaTK8bsPDL+LaWao7IkR/XbBI2kxAv+bNw=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200824074457eucas1p2bdfb2be072477e5e75d0899217b9b183~uJIsL_e_52951529515eucas1p2y;
        Mon, 24 Aug 2020 07:44:57 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 8F.1B.05997.9FF634F5; Mon, 24
        Aug 2020 08:44:57 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200824074456eucas1p1b3b686114ef31dd5ba8bd1e87d923894~uJIr0xGPB3199131991eucas1p1V;
        Mon, 24 Aug 2020 07:44:56 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200824074456eusmtrp1a1a589fd3020b3a0e472698664f4e453~uJIr0KeyQ2682226822eusmtrp1V;
        Mon, 24 Aug 2020 07:44:56 +0000 (GMT)
X-AuditID: cbfec7f4-65dff7000000176d-34-5f436ff90651
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 20.67.06017.8FF634F5; Mon, 24
        Aug 2020 08:44:56 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200824074456eusmtip1e013d3f459d75bd438f932a8c04efd7f~uJIrUwtoW3183231832eusmtip11;
        Mon, 24 Aug 2020 07:44:56 +0000 (GMT)
Subject: Re: [PATCH] memory: samsung: exynos5422-dmc: propagate error from
 exynos5_counters_get()
To:     Lukasz Luba <lukasz.luba@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <a0c9373b-edb4-fb85-ac00-82d20fa08495@samsung.com>
Date:   Mon, 24 Aug 2020 09:44:56 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <f5a15356-d5b9-4b04-f92a-997b92ef5630@arm.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMKsWRmVeSWpSXmKPExsWy7djP87o/853jDe4fEbHYOGM9q8X1L89Z
        Lc6f38BucXnXHDaLz71HGC1mnN/HZLGwqYXdgd1jzbw1jB6bVnWyefRtWcXo8XmTXABLFJdN
        SmpOZllqkb5dAlfGm81rWQruyVbs3vabrYHxgUQXIweHhICJxNwW3i5GLg4hgRWMEk9bPzJD
        OF8YJd4eWAjlfGaUaDvwnb2LkROsY+KmN2wQieWMEks+XGMCSQgJvGeUmLFfEMQWFkiW2DHz
        OyPIChEBH4klr9VBwswCexklVh4LA7HZBAwlut52sYHYvAJ2EmcunWQHKWcRUJWYsDUNJCwq
        ECex9fhVJogSQYmTM5+wgNicAtYSnVc/s0OMlJdo3jqbGcIWl7j1ZD4TyGkSAuvYJVZfuswM
        cbOLxP2fs1ghbGGJV8e3QP0iI3F6cg8LREMzo8TDc2vZIZweRonLTTMYIaqsJe6c+8UGch2z
        gKbE+l36EGFHif5DP5ghwcgnceOtIMQRfBKTtk2HCvNKdLQJQVSrScw6vg5u7cELl5gnMCrN
        QvLaLCTvzELyziyEvQsYWVYxiqeWFuempxYb5aWW6xUn5haX5qXrJefnbmIEJp3T/45/2cG4
        60/SIUYBDkYlHt4fh+zjhVgTy4orcw8xSnAwK4nwOp09HSfEm5JYWZValB9fVJqTWnyIUZqD
        RUmc13jRy1ghgfTEktTs1NSC1CKYLBMHp1QDo5ZT/ZWock7pqWsuF0emJXCpuH+vW/euk1X2
        a11Fd62UtpnRjzPl4oY7/4S/+Pr5v6D1d1F9j8UBOxj8avRFMzzeXtF+neeqNzmhfdfBFx2s
        T4OuuZ697+JsFht67Xrzn1bW120V4UynVlXPkFFd3ca6Wu/4ncQZev12lol/tdr2WFhpPV+g
        xFKckWioxVxUnAgAhn3NIzYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBIsWRmVeSWpSXmKPExsVy+t/xu7o/8p3jDWZ9M7fYOGM9q8X1L89Z
        Lc6f38BucXnXHDaLz71HGC1mnN/HZLGwqYXdgd1jzbw1jB6bVnWyefRtWcXo8XmTXABLlJ5N
        UX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7Gm81rWQru
        yVbs3vabrYHxgUQXIyeHhICJxMRNb9i6GLk4hASWMkr0fWpjgUjISJyc1sAKYQtL/LnWBVX0
        llFiV8dEJpCEsECyxI6Z3xm7GDk4RAR8JJa8VgepYRbYyyjxZPpPJoiGP0wSk5/eB5vKJmAo
        0fUWZBInB6+AncSZSyfZQZpZBFQlJmxNAwmLCsRJPO79zwxRIihxcuYTsFZOAWuJzquf2UFs
        ZgEziXmbHzJD2PISzVtnQ9niEreezGeawCg0C0n7LCQts5C0zELSsoCRZRWjSGppcW56brGR
        XnFibnFpXrpecn7uJkZgrG079nPLDsaud8GHGAU4GJV4eH8cso8XYk0sK67MPcQowcGsJMLr
        dPZ0nBBvSmJlVWpRfnxRaU5q8SFGU6DfJjJLiSbnA9NAXkm8oamhuYWlobmxubGZhZI4b4fA
        wRghgfTEktTs1NSC1CKYPiYOTqkGRgWZGdEN7sIhPVGmj6uUFurl3vC9KGDxyPBiy7n7/Xnq
        X+a8+RnGpv7n5AoJgVdJQu1XXp+xfVR6Pbnh508e4ZV/p355XLIgvOoIn4HPJ+fzRauf/bkW
        oZ8g//aYqO7biJsXhE3DF066JRNo+3WX8+VMzXlavJ7eBywjTxqkr65vurtqrmGIhhJLcUai
        oRZzUXEiAG+UG9jLAgAA
X-CMS-MailID: 20200824074456eucas1p1b3b686114ef31dd5ba8bd1e87d923894
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200804061225eucas1p283c1e0dc404bc420a2184480fdfd2b0d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200804061225eucas1p283c1e0dc404bc420a2184480fdfd2b0d
References: <CGME20200804061225eucas1p283c1e0dc404bc420a2184480fdfd2b0d@eucas1p2.samsung.com>
        <20200804061210.5415-1-m.szyprowski@samsung.com>
        <24675559-b807-5b80-1318-805c1530ffb3@arm.com>
        <78c95f58-8142-7607-6d74-5cfa6a7ffb77@samsung.com>
        <f3f416ac-0d63-b4e5-676f-8801b4166c11@arm.com>
        <20200817120724.GC2346@kozik-lap>
        <f5a15356-d5b9-4b04-f92a-997b92ef5630@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 17.08.2020 14:27, Lukasz Luba wrote:
> On 8/17/20 1:07 PM, Krzysztof Kozlowski wrote:
>> On Tue, Aug 04, 2020 at 01:38:11PM +0100, Lukasz Luba wrote:
>>> On 8/4/20 1:19 PM, Marek Szyprowski wrote:
>>>> On 04.08.2020 11:11, Lukasz Luba wrote:
>>>>> On 8/4/20 7:12 AM, Marek Szyprowski wrote:
>>>>>> exynos5_counters_get() might fail with -EPROBE_DEFER if the 
>>>>>> driver for
>>>>>> devfreq event counter is not yet probed. Propagate that error 
>>>>>> value to
>>>>>> the caller to ensure that the exynos5422-dmc driver will be 
>>>>>> probed again
>>>>>> when devfreq event contuner is available.
>>>>>>
>>>>>> This fixes boot hang if both exynos5422-dmc and exynos-ppmu 
>>>>>> drivers are
>>>>>> compiled as modules.
>>>>>>
>>>>>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>>>>> ---
>>>>>>     drivers/memory/samsung/exynos5422-dmc.c | 2 +-
>>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/memory/samsung/exynos5422-dmc.c
>>>>>> b/drivers/memory/samsung/exynos5422-dmc.c
>>>>>> index b9c7956e5031..639811a3eecb 100644
>>>>>> --- a/drivers/memory/samsung/exynos5422-dmc.c
>>>>>> +++ b/drivers/memory/samsung/exynos5422-dmc.c
>>>>>> @@ -914,7 +914,7 @@ static int exynos5_dmc_get_status(struct device
>>>>>> *dev,
>>>>>>         } else {
>>>>>>             ret = exynos5_counters_get(dmc, &load, &total);
>>>>>>             if (ret < 0)
>>>>>> -            return -EINVAL;
>>>>>> +            return ret;
>>>>>>               /* To protect from overflow, divide by 1024 */
>>>>>>             stat->busy_time = load >> 10;
>>>>>>
>>>>>
>>>>> Thank you for the patch, LGTM.
>>>>> Some questions are still there, though. The function
>>>>> exynos5_performance_counters_init() should capture that the counters
>>>>> couldn't be enabled or set. So the functions:
>>>>> exynos5_counters_enable_edev() and exynos5_counters_set_event()
>>>>> must pass gently because devfreq device is registered.
>>>>> Then devfreq checks device status, and reaches the state when
>>>>> counters 'get' function returns that they are not ready...
>>>>>
>>>>> If that is a kind of 2-stage initialization, maybe we should add
>>>>> another 'check' in the exynos5_performance_counters_init() and call
>>>>> the devfreq_event_get_event() to make sure that we are ready to go,
>>>>> otherwise return ret from that function (which is probably 
>>>>> EPROBE_DEFER)
>>>>> and not register the devfreq device.
>>>>
>>>> I've finally investigated this further and it turned out that the 
>>>> issue
>>>> is elsewhere. The $subject patch can be discarded, as it doesn't fix
>>>> anything. The -EPROBE_DEFER is properly returned by
>>>> exynos5_performance_counters_init(), which redirects 
>>>> exynos5_dmc_probe()
>>>> to remove_clocks label. This causes disabling mout_bpll/fout_bpll 
>>>> clocks
>>>> what in turn *sometimes* causes boot hang. This random behavior 
>>>> mislead
>>>> me that the $subject patch fixes the issue, but then longer tests
>>>> revealed that it didn't change anything.
>>>
>>> Really good investigation, great work Marek!
>>>
>>>>
>>>> It looks that the proper fix would be to keep fout_bpll enabled all 
>>>> the
>>>> time.
>>>
>>> Yes, I agree. I am looking for your next patch to test it then.
>>
>> Hi all,
>>
>> Is the patch still useful then? Shall I apply it?
>
> Marek has created different patch for it, which fixes the clock:
> https://lore.kernel.org/linux-clk/20200807133143.22748-1-m.szyprowski@samsung.com/ 
>
>
> So you don't have to apply this one IMO.

Indeed, you can drop this one.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

