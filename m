Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87B1D209D72
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jun 2020 13:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404248AbgFYLaG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jun 2020 07:30:06 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:52717 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404244AbgFYLaF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jun 2020 07:30:05 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200625113003euoutp025642cca447e1eb781dd1a4684820ceff~bxgGPRdju3222132221euoutp02K
        for <linux-pm@vger.kernel.org>; Thu, 25 Jun 2020 11:30:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200625113003euoutp025642cca447e1eb781dd1a4684820ceff~bxgGPRdju3222132221euoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593084603;
        bh=oYEzalD5G0LlXTJMPOqJqDjgEB8ql/5AHvHuXTQ9kjI=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=mU9aL5KLmNupY6bKtrNXToqKxLe1/FGiM9q0bdIS/ORJe2KfG2aypmnBLwtt6/yZF
         0LwC+Thozu5N+S5Y9Phckz8kPwEnfhFkKZ/M/nqFOjz4geTfnLUYCGkGBSz++UDnxb
         umFCqG1uvId2IlBKXLNsTlQO3c2f5ddt8/Sgvsjk=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200625113002eucas1p2b64eff27b1df8426dbb794147e903ec3~bxgFuq5t72256022560eucas1p2A;
        Thu, 25 Jun 2020 11:30:02 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id B3.9B.06318.ABA84FE5; Thu, 25
        Jun 2020 12:30:02 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200625113002eucas1p280183d359d9f8472992f3b69c1ea96b5~bxgFQdo_32305423054eucas1p2K;
        Thu, 25 Jun 2020 11:30:02 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200625113002eusmtrp1a4fca84333e785666df295c31f8bb82b~bxgFPqS2F2738827388eusmtrp14;
        Thu, 25 Jun 2020 11:30:02 +0000 (GMT)
X-AuditID: cbfec7f5-371ff700000018ae-d3-5ef48aba8657
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 19.ED.06314.ABA84FE5; Thu, 25
        Jun 2020 12:30:02 +0100 (BST)
Received: from [106.120.51.18] (unknown [106.120.51.18]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200625113001eusmtip138ab295ce37ea1272d0962c7fc22a55e~bxgEsW05k3260132601eusmtip1d;
        Thu, 25 Jun 2020 11:30:01 +0000 (GMT)
Subject: Re: brocken devfreq simple_ondemand for Odroid XU3/4?
To:     Lukasz Luba <lukasz.luba@arm.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Willy Wolff <willy.mh.wolff.ml@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>, linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Kamil Konieczny <k.konieczny@samsung.com>
Message-ID: <4c3b01af-2337-1eba-4675-6488105144c8@samsung.com>
Date:   Thu, 25 Jun 2020 13:30:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
        Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <4a72fcab-e8da-8323-1fbe-98a6a4b3e0f1@arm.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjm27nsKM6OU/FrhsVCKjMt9McRy9IK9iv8YRFBq6UHL7kpO14y
        JE3NdJlKNpvLvJSUiZrOeWmkeAl1XhiiM1GbpqKYTpTNQLBMd4z89zzv+zzf+z4vH4Hw9ZiA
        iJYl0HKZJFaI26MtvVuGMzqFVXz2/baQ+mZdwqiC+RWEMhgauNRwxiqX0syPY9SorhSnLM+/
        Akpl6OBQlRlZXGrqcTVO9aw+xahf/XPgkoOotqwWiD6rv3NFmppcXNRUlSbK19YAkUXjEYrf
        sj8fQcdGJ9Fy36C79lFTqmY8vkHwYCLLgKaDj64KQBCQ9IeNIyEKYE/wyWoA22f7AUusADa1
        ziEssQBorFLiCmBnc6wt7nDYxgcAx1YqMJaYAVTpqtA9lTMZBMvHddgediHDYP2bMttTCNmF
        wHbrELLXwElf2DWstxl4u4ac2mxbHSU9YaFqxDbOlbwJ+54VcVmNE9SXLNj0dmQgXDYO2TQI
        6QYnF8o5LD4KW82ltmGQNHHh75YCwO59BWq7TAiLneHPPi2XxUfgYFEeyhoyARxMV3JZkrd7
        D6t2P3UgtGx04ns3Q8hT8JPOly0HQ3PvKsKe0hFOmJ3YJRzhi5ZX+2UezMnms2pPuDSQx2Gx
        O1Ts1GOFQKg+EE19II76QBz1/7kVAK0BbnQiI42kGT8ZnezDSKRMoizSJzxOqgG7H2zwT99m
        G+jYvtcNSAIIHXjrkxYxH5MkMSnSbgAJROjCCxkeFPN5EZKUh7Q87o48MZZmuoE7gQrdeH5v
        l2/zyUhJAn2fpuNp+b8uh7ATpIMiYsY8ah0jZ7Ae48WxNqny3aLWezZkrd730OlYk1dM6daj
        6Z6sVJPerM8MUNZdr4xqk7zcCI2pm0dzIzcF2GsyOl31Ja3z8skAB61Rnthb8qM4Wdx4ODip
        fLpJWpw/zTxpPe4tPREe0TDQnHKDbwm7sHnt6jHTutDfIzXXOCZEmSjJOS9Ezkj+AhiaID1c
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsVy+t/xu7q7ur7EGfS/Z7W4/uU5q0X/49fM
        FufPb2C3ONv0ht1i0+NrrBaXd81hs/jce4TRYsb5fUwWC5ta2C1uN65gszj8pp3V4tuJR4wO
        PB5r5q1h9Ng56y67x6ZVnWwem5fUe/RtWcXo8XmTXABblJ5NUX5pSapCRn5xia1StKGFkZ6h
        pYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7G7Rlb2Qo2SFXcaDnP0sC4UrSLkZNDQsBE
        4t2z/0xdjFwcQgJLGSW+zd3PCJGQlmg8vZoJwhaW+HOtiw2i6DWjxKKdH5hBEsICdhLzr+1i
        BbFFBEIkLnefYQQpYhY4zCxx7NRhVoiOicwSD1rvsYFUsQnoSxw8e5IFxOYF6u5Y0wY2iUVA
        VWLCjItgNaICERIt9/+wQ9QISpyc+QSsnlPAWuLl1TNgNcwC6hJ/5l1ihrDFJW49mc8EYctL
        bH87h3kCo9AsJO2zkLTMQtIyC0nLAkaWVYwiqaXFuem5xYZ6xYm5xaV56XrJ+bmbGIExu+3Y
        z807GC9tDD7EKMDBqMTD++HW5zgh1sSy4srcQ4wSHMxKIrxOZ0/HCfGmJFZWpRblxxeV5qQW
        H2I0BXpuIrOUaHI+MJ3klcQbmhqaW1gamhubG5tZKInzdggcjBESSE8sSc1OTS1ILYLpY+Lg
        lGpgrIpQvHD0l8LrZ++3ZH0Idrs9+4AlT0bpjxQHw2ntvf9+P+t+NvdNdc/t90eSdZr3KTFN
        YlzZodP757IvU/O0IlVtbovsB/16/hmv+IyuKO8vu3phZo+a4HEpx1mbGv+EdprHv/s609GB
        W4vz2Lysq8srqx9l7/mSzt7AcCckec2Xu2ZRU33NlViKMxINtZiLihMBtAjemO8CAAA=
X-CMS-MailID: 20200625113002eucas1p280183d359d9f8472992f3b69c1ea96b5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200624103308eucas1p188a5fe3cee1916d9430c9971c2dab3a3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200624103308eucas1p188a5fe3cee1916d9430c9971c2dab3a3
References: <20200623164733.qbhua7b6cg2umafj@macmini.local>
        <CAJKOXPeLuq81NC2xZh3y32EB-_APbDAchZD4OW_eCgQKKO+p8w@mail.gmail.com>
        <20200623191129.GA4171@kozik-lap>
        <CGME20200624103308eucas1p188a5fe3cee1916d9430c9971c2dab3a3@eucas1p1.samsung.com>
        <85f5a8c0-7d48-f2cd-3385-c56d662f2c88@arm.com>
        <ef5184ed-00ff-4226-5ece-b0fc8eb16fb6@samsung.com>
        <4a72fcab-e8da-8323-1fbe-98a6a4b3e0f1@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Lukasz,

On 25.06.2020 12:02, Lukasz Luba wrote:
> Hi Sylwester,
> 
> On 6/24/20 4:11 PM, Sylwester Nawrocki wrote:
>> Hi All,
>>
>> On 24.06.2020 12:32, Lukasz Luba wrote:
>>> I had issues with devfreq governor which wasn't called by devfreq
>>> workqueue. The old DELAYED vs DEFERRED work discussions and my patches
>>> for it [1]. If the CPU which scheduled the next work went idle, the
>>> devfreq workqueue will not be kicked and devfreq governor won't check
>>> DMC status and will not decide to decrease the frequency based on low
>>> busy_time.
>>> The same applies for going up with the frequency. They both are
>>> done by the governor but the workqueue must be scheduled periodically.
>>
>> As I have been working on resolving the video mixer IOMMU fault issue
>> described here: https://patchwork.kernel.org/patch/10861757
>> I did some investigation of the devfreq operation, mostly on Odroid U3.
>>
>> My conclusions are similar to what Lukasz says above. I would like to add
>> that broken scheduling of the performance counters read and the devfreq
>> updates seems to have one more serious implication. In each call, which
>> normally should happen periodically with fixed interval we stop the counters,
>> read counter values and start the counters again. But if period between
>> calls becomes long enough to let any of the counters overflow, we will
>> get wrong performance measurement results. My observations are that
>> the workqueue job can be suspended for several seconds and conditions for
>> the counter overflow occur sooner or later, depending among others
>> on the CPUs load.
>> Wrong bus load measurement can lead to setting too low interconnect bus
>> clock frequency and then bad things happen in peripheral devices.
>>
>> I agree the workqueue issue needs to be fixed. I have some WIP code to use
>> the performance counters overflow interrupts instead of SW polling and with
>> that the interconnect bus clock control seems to work much better.
>>
> 
> Thank you for sharing your use case and investigation results. I think
> we are reaching a decent number of developers to maybe address this
> issue: 'workqueue issue needs to be fixed'.
> I have been facing this devfreq workqueue issue ~5 times in different
> platforms.
> 
> Regarding the 'performance counters overflow interrupts' there is one
> thing worth to keep in mind: variable utilization and frequency.
> For example, in order to make a conclusion in algorithm deciding that
> the device should increase or decrease the frequency, we fix the period
> of observation, i.e. to 500ms. That can cause the long delay if the
> utilization of the device suddenly drops. For example we set an
> overflow threshold to value i.e. 1000 and we know that at 1000MHz
> and full utilization (100%) the counter will reach that threshold
> after 500ms (which we want, because we don't want too many interrupts
> per sec). What if suddenly utilization drops to 2% (i.e. from 5GB/s
> to 250MB/s (what if it drops to 25MB/s?!)), the counter will reach the
> threshold after 50*500ms = 25s. It is impossible just for the counters
> to predict next utilization and adjust the threshold. [...]

irq triggers for underflow and overflow, so driver can adjust freq

-- 
Best regards,
Kamil Konieczny
Samsung R&D Institute Poland

