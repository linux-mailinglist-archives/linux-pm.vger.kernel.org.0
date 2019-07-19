Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F32806E0C8
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2019 07:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbfGSF6s (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Jul 2019 01:58:48 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:58471 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727127AbfGSF6s (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Jul 2019 01:58:48 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190719055844epoutp01bbf684ee2ef1cf7314075eee451dbc13~yuXMm3sNl0820508205epoutp01G
        for <linux-pm@vger.kernel.org>; Fri, 19 Jul 2019 05:58:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190719055844epoutp01bbf684ee2ef1cf7314075eee451dbc13~yuXMm3sNl0820508205epoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563515924;
        bh=szd6xmQj3SvU6GXSwtu/sUN30XFQ9i4FBtIjtp320H4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=L4nPWE41/wc4XUD+raj5XIKVlG5syKLGamDYuckNk2O6nlwbVZoSW39tzowcha9r/
         vC/OgLzaIR2GGzEhsr9mYM7S1rrgEv5lSb/85wvRBUke2aR+cBjardRFJeeDeYGFWL
         fQQBYmDFIVJZ8SoWvR+4qZYbSbib6BkflUGsTqYo=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190719055844epcas1p108a3520911b3a51f3cd81064ffa3c012~yuXMDFWoy1828118281epcas1p1P;
        Fri, 19 Jul 2019 05:58:44 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.156]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 45qgKr4mkHzMqYm1; Fri, 19 Jul
        2019 05:58:40 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        74.96.04066.01C513D5; Fri, 19 Jul 2019 14:58:40 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190719055840epcas1p2cdb7e95837a9884de09f8d750b821d88~yuXISQCDJ2912029120epcas1p27;
        Fri, 19 Jul 2019 05:58:40 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190719055840epsmtrp252be86f41996fcb3cf6e08aaf388b3c2~yuXIRcOil0338603386epsmtrp2E;
        Fri, 19 Jul 2019 05:58:40 +0000 (GMT)
X-AuditID: b6c32a37-e27ff70000000fe2-ab-5d315c1039f5
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        84.8F.03638.01C513D5; Fri, 19 Jul 2019 14:58:40 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190719055840epsmtip15a21710833739f20107f4d22a6ed4836~yuXIHEDtN2188921889epsmtip1Z;
        Fri, 19 Jul 2019 05:58:40 +0000 (GMT)
Subject: Re: [PATCH v4 12/24] PM / devfreq: tegra30: Inline all one-line
 functions
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <8e3de3b8-d3c6-fba3-0883-a2cd8d0c4c98@samsung.com>
Date:   Fri, 19 Jul 2019 15:01:50 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190719051426.4e4145d8@dimatab>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SeUiTYRzHe/Zu76a5fFpWv6RSX6nQcu5tTV8jJehgkIR0QIVmL+5pmrva
        OzuMIruV8qBLV62oLLtrTdGVCGaFQZcd2DGyjCgzI1fRBbXtLfK/z+9+vr/np6BUF+hoRYHF
        QewW3sTQ4dKGawlJSTibzdHsuTqBO/OpG3FbnEel3O1NvXLugfcgzfl3tSGu9LOT5p6V1NHc
        d69LypWf66Cnh+kbfceRvsnpk+t3be6j9eWe00jvd4/Nki0pnJZPeAOxxxJLntVQYDGmM3Pm
        587I1aVo2CQ2jUtlYi28maQzMzOzkmYXmAIPYmJX8aaigCuLFwQmOWOa3VrkILH5VsGRzhCb
        wWRLs6kF3iwUWYzqPKt5KqvRTNYFEpcV5l+piLd1Rq1pL6tEG5EPl6EwBeApcOuEX16GwhUq
        3IigrbNSKhr9CGrqd1Oi8RVBb3l5IKIIlbx8pxX9zQge7etAovERQZW7iQr2HYYXQFfdD1mQ
        o/B4OHn9lyyYROFLErh58awkGKBxIrS87aSDHInj4NG3bhRkJc6Avd2+UCMpHgd9bzzSIA/H
        i6C/65pMzBkK7TWvQ/4wrIbKnppQHwqPhKevD0tEjoHN9QdCEgD/puHyK49MVD0THnd4kcjD
        oOemRy5yNPj7mmmR18Gp9jZaLN6BwNNy72+xFlpqd0uCu6BwAlzwJovuOGj6eQiJg4dA35ed
        MnFdStixTSWmxMODLp9E5FFwbHspXYkY5wA5zgESnAMkOP8PO4Kkp9EIYhPMRiKwNu3A33aj
        0LEmpjaii3cyWxFWICZCmWXW5Khk/CphrbkVgYJiopTP3iXnqJQGfm0xsVtz7UUmIrQiXWDb
        VVT08Dxr4PQtjlxWN1mr1XJT2BQdyzIjla5fCTkqbOQdpJAQG7H/q5MowqI3IpN/8QtjQ29p
        ZJk7o/j9aMP2mJ4bE3/OyGurksVU6DWjxrh21lXcnxt+rqfDtX/ooPuzvc67yrFP58X5Hp4f
        923pypQfnKuWOv5q69elH5avi0l9Hr9+oZrU92e/Jas3RZa8cUccGexasW1D2qRsNTmUers4
        KqK2+klJY6R8ls++v/o5IxXyeTaRsgv8H9tFdJvCAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsWy7bCSnK5AjGGsQfNtTovVHx8zWrTMWsRi
        cbbpDbvF5V1z2Cw+9x5htOj8MovN4nbjCjaLn7vmsVj0rb3E5sDpsePuEkaPnbPusnv0Nr9j
        8+jbsorR4/MmuQDWKC6blNSczLLUIn27BK6M3f3KBTdEKk52TWBsYLwr0MXIwSEhYCLx8KVx
        FyMXh5DAbkaJz8uWsXcxcgLFJSWmXTzKDFEjLHH4cDFEzVtGiVWTOlhAaoQFQiQerPjFCmKL
        CKhJLD/6hxWkiFlgM5PE2VOr2SA6mlkkJt96CDaVTUBLYv+LG2wgNr+AosTVH48ZQWxeATuJ
        qY/vMoPYLAKqEu+ebQHbICoQIXF4xyyoGkGJkzOfgMU5BfQkJryaCTaHWUBd4s+8S8wQtrjE
        rSfzmSBseYnmrbOZJzAKz0LSPgtJyywkLbOQtCxgZFnFKJlaUJybnltsWGCUl1quV5yYW1ya
        l66XnJ+7iREcYVpaOxhPnIg/xCjAwajEwxuQaxArxJpYVlyZe4hRgoNZSYT39kv9WCHelMTK
        qtSi/Pii0pzU4kOM0hwsSuK88vnHIoUE0hNLUrNTUwtSi2CyTBycUg2MZS5fLtWbqceZXWV5
        rbeY3dy/cqXNccZVinyxfb/74hKDbhwyeffzeU7lbrZDewWdftm9UnG8bn7mQuWcgtlBvo5K
        uY/fzFzzdsUpx3WCkcKvBJo4bGut6ye5rnGsOv9EtHsv1zov6fAOltbOjblLPyfXecTefOky
        SfPwZWbHRG7zT4ofn0grsRRnJBpqMRcVJwIAMZeBQawCAAA=
X-CMS-MailID: 20190719055840epcas1p2cdb7e95837a9884de09f8d750b821d88
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190707223633epcas4p3873704f3199126be0e8d5cb7454c7a51
References: <20190707223303.6755-1-digetx@gmail.com>
        <CGME20190707223633epcas4p3873704f3199126be0e8d5cb7454c7a51@epcas4p3.samsung.com>
        <20190707223303.6755-13-digetx@gmail.com>
        <b5634fbe-8bc1-0f04-e13b-6345dfbb5615@samsung.com>
        <b7da3fa2-00d1-5bd6-408c-202c85be917d@gmail.com>
        <45621f73-2f86-cde7-a92e-2a34810b9c05@samsung.com>
        <20190719042251.37cc9cda@dimatab>
        <92f82420-5c50-468f-a403-7b4c36958076@samsung.com>
        <97f2a317-989a-bcad-dd45-ccf00ba18cca@samsung.com>
        <20190719051426.4e4145d8@dimatab>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 7. 19. 오전 11:14, Dmitry Osipenko wrote:
> В Fri, 19 Jul 2019 10:27:16 +0900
> Chanwoo Choi <cw00.choi@samsung.com> пишет:
> 
>> On 19. 7. 19. 오전 10:24, Chanwoo Choi wrote:
>>> On 19. 7. 19. 오전 10:22, Dmitry Osipenko wrote:  
>>>> В Thu, 18 Jul 2019 18:09:05 +0900
>>>> Chanwoo Choi <cw00.choi@samsung.com> пишет:
>>>>  
>>>>> On 19. 7. 16. 오후 10:35, Dmitry Osipenko wrote:  
>>>>>> 16.07.2019 15:26, Chanwoo Choi пишет:    
>>>>>>> Hi Dmitry,
>>>>>>>
>>>>>>> I'm not sure that it is necessary.
>>>>>>> As I knew, usally, the 'inline' is used on header file
>>>>>>> to define the empty functions.
>>>>>>>
>>>>>>> Do we have to change it with 'inline' keyword?    
>>>>>>
>>>>>> The 'inline' attribute tells compiler that instead of jumping
>>>>>> into the function, it should take the function's code and
>>>>>> replace the function's invocation with that code. This is done
>>>>>> in order to help compiler optimize code properly, please see
>>>>>> [1]. There is absolutely no need to create a function call into
>>>>>> a function that consists of a single instruction.
>>>>>>
>>>>>> [1] https://gcc.gnu.org/onlinedocs/gcc-9.1.0/gcc/Inline.html
>>>>>>     
>>>>>
>>>>> If you want to add 'inline' keyword, I recommend that 
>>>>> you better to remove the modified function in this patch
>>>>> and then just call the 'write_relaxed or read_relaxed' function
>>>>> directly. It is same result when using inline keyword.  
>>>>
>>>> That could be done, but it makes code less readable.
>>>>
>>>> See the difference:
>>>>
>>>> device_writel(dev, ACTMON_INTR_STATUS_CLEAR,
>>>> ACTMON_DEV_INTR_STATUS);
>>>>
>>>> writel_relaxed(ACTMON_INTR_STATUS_CLEAR,
>>>> 	       dev->regs + ACTMON_DEV_INTR_STATUS);  
>>>
>>> No problem if you add the detailed comment and you want to use
>>> the 'inline' keyword.  
>>
>> Basically, I think that 'inline' keyword is not necessary.
> 
> Sure, but I'm finding that it's always nicer to explicitly inline a very
> simple functions because compiler may not do it properly itself in some
> cases.
> 
>> But if you want to use 'inline' keyword, I recommend
>> that call the 'write_relaxed or read_relaxed' function directly
>> with detailed description. 
> 
> Could you please reword this sentence? Not sure that I'm understanding
> it correctly.
> 

If you want to used 'inline' keyword,
Instead, I recommend that remove 'actmon_readl/writel' wrapper functions
and then you calls 'write_relaxed or read_relaxed' function directly
with detailed description.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
