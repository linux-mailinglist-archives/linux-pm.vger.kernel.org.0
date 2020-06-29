Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0914320CB6F
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jun 2020 03:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbgF2Bci (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 28 Jun 2020 21:32:38 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:28015 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbgF2Bch (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 28 Jun 2020 21:32:37 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200629013232epoutp04447e4d1872d5be5e799d0f1fedc80428~c37iba4R21436114361epoutp04o
        for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2020 01:32:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200629013232epoutp04447e4d1872d5be5e799d0f1fedc80428~c37iba4R21436114361epoutp04o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593394352;
        bh=SUjZxcqXUup2bGqVpGLiZwsn0DACjWTe+2Tc3H2VfTE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Owb2ka/mpybEQ++3koEIYNTClnEbTibKG3RxnXMtVayFHBu4c4o6SggDnukTdtZKf
         XPR4NzQhXhGicPuJ1MseImhiQmIh5Q/N29sZcaZWAzf4cFeVw6EqRMfrY6xY9AIpA2
         HUovn4mw9+CZ+++P+arxjEO+qmOinuGljxiLyE3o=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200629013231epcas1p4fb7f668c10bb8bb1b2b6d3565696625f~c37htVqBf2086720867epcas1p4U;
        Mon, 29 Jun 2020 01:32:31 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.152]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 49w9302QzPzMqYkZ; Mon, 29 Jun
        2020 01:32:28 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        50.D4.29173.CA449FE5; Mon, 29 Jun 2020 10:32:28 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200629013227epcas1p159b1b6ed8c62101bb69314ee9a252ce7~c37eSEmLZ0916209162epcas1p1X;
        Mon, 29 Jun 2020 01:32:27 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200629013227epsmtrp1f3a838c3440ea0bf03ee87ec0c0919b3~c37eRTefk3161531615epsmtrp15;
        Mon, 29 Jun 2020 01:32:27 +0000 (GMT)
X-AuditID: b6c32a37-9cdff700000071f5-26-5ef944ac8808
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        04.CD.08303.BA449FE5; Mon, 29 Jun 2020 10:32:27 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200629013227epsmtip253bf65a046564e4395367b3a084211f1~c37d-rOwU0753607536epsmtip2n;
        Mon, 29 Jun 2020 01:32:27 +0000 (GMT)
Subject: Re: brocken devfreq simple_ondemand for Odroid XU3/4?
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Lukasz Luba <lukasz.luba@arm.com>
Cc:     Kamil Konieczny <k.konieczny@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Willy Wolff <willy.mh.wolff.ml@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>, linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <691bc55c-5b04-b519-4575-6dce5ea9914c@samsung.com>
Date:   Mon, 29 Jun 2020 10:43:39 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <ad4e1a73-6de3-68ee-e3b3-b30bc315bd31@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFJsWRmVeSWpSXmKPExsWy7bCmru4al59xBrPnC1hsnLGe1WLBpxms
        Fv2PXzNbnD+/gd3ibNMbdotNj6+xWlzeNYfN4nPvEUaLGef3MVksbGpht7jduILN4vCbdlaL
        byceMTrweqyZt4bRY+esu+wem1Z1snlsXlLv0bdlFaPH501yAWxR2TYZqYkpqUUKqXnJ+SmZ
        eem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QIcqKZQl5pQChQISi4uV9O1sivJL
        S1IVMvKLS2yVUgtScgosC/SKE3OLS/PS9ZLzc60MDQyMTIEKE7IzLt6ez1hw3rhi9YYnzA2M
        07S6GDk5JARMJPZsu88GYgsJ7GCUWNtX0MXIBWR/YpR4taWFBcL5zCgx6dBuJpiOHzuOMUMk
        djFKLN5+khXCec8o8XbHUUaQKmEBO4n513axgtgiArES2w7fYgcpYhb4zCzxeeFhsFFsAloS
        +1/cAFvOL6AocfXHY7BmXqDmeb2bmEFsFgFViRfH7rGD2KICYRInt7VA1QhKnJz5hAXE5hSw
        l/ixdDvYHGYBcYlbT+YzQdjyEtvfzmGGOPsCh8ShVzoQtovEz0XHoN4Rlnh1fAs7hC0l8bK/
        Dcqullh58ggbyNESAh2MElv2X2CFSBhL7F86GaiZA2iBpsT6XfoQYUWJnb/nMkLs5ZN497WH
        FaREQoBXoqNNCKJEWeLyg7tQayUlFrd3sk1gVJqF5JtZSD6YheSDWQjLFjCyrGIUSy0ozk1P
        LTYsMEaO7U2M4ESsZb6DcdrbD3qHGJk4GA8xSnAwK4nwfrb+FifEm5JYWZValB9fVJqTWnyI
        0RQYvhOZpUST84G5IK8k3tDUyNjY2MLE0MzU0FBJnNfX6kKckEB6YklqdmpqQWoRTB8TB6dU
        A5OgJEvhx6NP7GNXv/5yq81/+7H2cynTTYXWvNM+mykgtW6VVvfHOYuPVLXNCo+puPfFMMNT
        Xa553t91947OUqxI3nH//9vlVvus/z1Z/SE9blb3FQdtyZj2ufPPRe3TcLhdyHr3w8Xy20kH
        3nZs4DTrnsKSyVZ9qYKH53G3j9uvb29zXvTka566NXVVvUHOCwGOOK7jh3ZNuyxS82hhQ7GG
        o9jF24y9Oy8tnWgr1Jik0zL1SZBPN+Pp1f3St9ZtuuKc6PZlbunJo0Epk9IvJM+6OD1JOk+4
        mKXvs/uvYtMT+Rr+e3axfpJeou9w+pHpq2sbEjSnHkyy1oxtvXanVN3+kEVwWNt6f4V/TqXS
        nHOVWIozEg21mIuKEwF+uaHxTQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsWy7bCSvO5ql59xBhNuKltsnLGe1WLBpxms
        Fv2PXzNbnD+/gd3ibNMbdotNj6+xWlzeNYfN4nPvEUaLGef3MVksbGpht7jduILN4vCbdlaL
        byceMTrweqyZt4bRY+esu+wem1Z1snlsXlLv0bdlFaPH501yAWxRXDYpqTmZZalF+nYJXBkX
        b89nLDhvXLF6wxPmBsZpWl2MnBwSAiYSP3YcY+5i5OIQEtjBKNH08SkTREJSYtrFo0AJDiBb
        WOLw4WKImreMElOX32EGqREWsJOYf20XK4gtIhArseP8FhaQImaBn8wSn+fOg5r6kEViyqvb
        YFVsAloS+1/cYAOx+QUUJa7+eMwIYvMCTZrXuwlsKouAqsSLY/fYQWxRgTCJnUseM0HUCEqc
        nPmEBcTmFLCX+LF0O9gcZgF1iT/zLjFD2OISt57MZ4Kw5SW2v53DPIFReBaS9llIWmYhaZmF
        pGUBI8sqRsnUguLc9NxiwwKjvNRyveLE3OLSvHS95PzcTYzgqNTS2sG4Z9UHvUOMTByMhxgl
        OJiVRHg/W3+LE+JNSaysSi3Kjy8qzUktPsQozcGiJM77ddbCOCGB9MSS1OzU1ILUIpgsEwen
        VAMT00Xmn1UfUmrv/HqzuGh5RlCj3NWJUcdd3Zmcs6YfWaz34Um69ec1Vnw6c+W8mdkCvnA8
        iBE7MjlV/nlR2pkjBTvn8xkdMyz7soThAo+Uj2Oh336e5fJtfx9zbX83keH4C0m1B9/zFjTd
        luaNltk/eeXmct1/wpL2jzQnPL4Vesp6qeISxvz7b1acOx5rwu1rLPI3eto0cZ5Ny6cciz4/
        a0HXEbeuwrMBNse6HDxms0sKna1Ttbb4oPBrr0WyzNqdTLvK9khd5J/Wn3nqyen6cHtttVuf
        Fvz+OVOjUMVYK/5che/34HaugtNbo22a2Nffl/yzUE/fgtHWJ6udbVHUoW3rgrYpMO6zDtc/
        fjVKiaU4I9FQi7moOBEAyfHctjkDAAA=
X-CMS-MailID: 20200629013227epcas1p159b1b6ed8c62101bb69314ee9a252ce7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200624103308eucas1p188a5fe3cee1916d9430c9971c2dab3a3
References: <20200623164733.qbhua7b6cg2umafj@macmini.local>
        <CAJKOXPeLuq81NC2xZh3y32EB-_APbDAchZD4OW_eCgQKKO+p8w@mail.gmail.com>
        <20200623191129.GA4171@kozik-lap>
        <CGME20200624103308eucas1p188a5fe3cee1916d9430c9971c2dab3a3@eucas1p1.samsung.com>
        <85f5a8c0-7d48-f2cd-3385-c56d662f2c88@arm.com>
        <ef5184ed-00ff-4226-5ece-b0fc8eb16fb6@samsung.com>
        <4a72fcab-e8da-8323-1fbe-98a6a4b3e0f1@arm.com>
        <4c3b01af-2337-1eba-4675-6488105144c8@samsung.com>
        <6f8b1119-62b1-942d-cfde-6f1e9a28c40c@arm.com>
        <ee2e4acb-3986-3227-da1f-177d2756d194@samsung.com>
        <ad4e1a73-6de3-68ee-e3b3-b30bc315bd31@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

Sorry for late reply because of my perfornal issue. I count not check the email.

On 6/26/20 8:22 PM, Bartlomiej Zolnierkiewicz wrote:
> 
> On 6/25/20 2:12 PM, Kamil Konieczny wrote:
>> On 25.06.2020 14:02, Lukasz Luba wrote:
>>>
>>>
>>> On 6/25/20 12:30 PM, Kamil Konieczny wrote:
>>>> Hi Lukasz,
>>>>
>>>> On 25.06.2020 12:02, Lukasz Luba wrote:
>>>>> Hi Sylwester,
>>>>>
>>>>> On 6/24/20 4:11 PM, Sylwester Nawrocki wrote:
>>>>>> Hi All,
>>>>>>
>>>>>> On 24.06.2020 12:32, Lukasz Luba wrote:
>>>>>>> I had issues with devfreq governor which wasn't called by devfreq
>>>>>>> workqueue. The old DELAYED vs DEFERRED work discussions and my patches
>>>>>>> for it [1]. If the CPU which scheduled the next work went idle, the
>>>>>>> devfreq workqueue will not be kicked and devfreq governor won't check
>>>>>>> DMC status and will not decide to decrease the frequency based on low
>>>>>>> busy_time.
>>>>>>> The same applies for going up with the frequency. They both are
>>>>>>> done by the governor but the workqueue must be scheduled periodically.
>>>>>>
>>>>>> As I have been working on resolving the video mixer IOMMU fault issue
>>>>>> described here: https://patchwork.kernel.org/patch/10861757
>>>>>> I did some investigation of the devfreq operation, mostly on Odroid U3.
>>>>>>
>>>>>> My conclusions are similar to what Lukasz says above. I would like to add
>>>>>> that broken scheduling of the performance counters read and the devfreq
>>>>>> updates seems to have one more serious implication. In each call, which
>>>>>> normally should happen periodically with fixed interval we stop the counters,
>>>>>> read counter values and start the counters again. But if period between
>>>>>> calls becomes long enough to let any of the counters overflow, we will
>>>>>> get wrong performance measurement results. My observations are that
>>>>>> the workqueue job can be suspended for several seconds and conditions for
>>>>>> the counter overflow occur sooner or later, depending among others
>>>>>> on the CPUs load.
>>>>>> Wrong bus load measurement can lead to setting too low interconnect bus
>>>>>> clock frequency and then bad things happen in peripheral devices.
>>>>>>
>>>>>> I agree the workqueue issue needs to be fixed. I have some WIP code to use
>>>>>> the performance counters overflow interrupts instead of SW polling and with
>>>>>> that the interconnect bus clock control seems to work much better.
>>>>>>
>>>>>
>>>>> Thank you for sharing your use case and investigation results. I think
>>>>> we are reaching a decent number of developers to maybe address this
>>>>> issue: 'workqueue issue needs to be fixed'.
>>>>> I have been facing this devfreq workqueue issue ~5 times in different
>>>>> platforms.
>>>>>
>>>>> Regarding the 'performance counters overflow interrupts' there is one
>>>>> thing worth to keep in mind: variable utilization and frequency.
>>>>> For example, in order to make a conclusion in algorithm deciding that
>>>>> the device should increase or decrease the frequency, we fix the period
>>>>> of observation, i.e. to 500ms. That can cause the long delay if the
>>>>> utilization of the device suddenly drops. For example we set an
>>>>> overflow threshold to value i.e. 1000 and we know that at 1000MHz
>>>>> and full utilization (100%) the counter will reach that threshold
>>>>> after 500ms (which we want, because we don't want too many interrupts
>>>>> per sec). What if suddenly utilization drops to 2% (i.e. from 5GB/s
>>>>> to 250MB/s (what if it drops to 25MB/s?!)), the counter will reach the
>>>>> threshold after 50*500ms = 25s. It is impossible just for the counters
>>>>> to predict next utilization and adjust the threshold. [...]
>>>>
>>>> irq triggers for underflow and overflow, so driver can adjust freq
>>>>
>>>
>>> Probably possible on some platforms, depends on how many PMU registers
>>> are available, what information can be can assign to them and type of
>>> interrupt. A lot of hassle and still - platform and device specific.
>>> Also, drivers should not adjust the freq, governors (different types
>>> of them with different settings that they can handle) should do it.
>>>
>>> What the framework can do is to take this responsibility and provide
>>> generic way to monitor the devices (or stop if they are suspended).
>>> That should work nicely with the governors, which try to predict the
>>> next best frequency. From my experience the more fluctuating intervals
>>> the governors are called, the more odd decisions they make.
>>> That's why I think having a predictable interval i.e. 100ms is something
>>> desirable. Tuning the governors is easier in this case, statistics
>>> are easier to trace and interpret, solution is not to platform specific,
>>> etc.
>>>
>>> Kamil do you have plans to refresh and push your next version of the
>>> workqueue solution?
>>
>> I do not, as Bartek takes over my work,
>> +CC Bartek
> 
> Hi Lukasz,
> 
> As you remember in January Chanwoo has proposed another idea (to allow
> selecting workqueue type by devfreq device driver):
> 
> "I'm developing the RFC patch and then I'll send it as soon as possible."
> (https://lore.kernel.org/linux-pm/6107fa2b-81ad-060d-89a2-d8941ac4d17e@samsung.com/)
> 
> "After posting my suggestion, we can discuss it"
> (https://lore.kernel.org/linux-pm/f5c5cd64-b72c-2802-f6ea-ab3d28483260@samsung.com/)
> 
> so we have been waiting on the patch to be posted..

Sorry for this. I'll send it within few days.


> 
> Similarly we have been waiting on (any) feedback for exynos-bus/nocp
> fixes for Exynos5422 support (which have been posted by Kamil also in
> January):
> 
> https://lore.kernel.org/linux-pm/8f82d8d5-927b-afb4-272f-45c16b5a23b9@samsung.com/
> 
> Considering the above and how hard it has been to push the changes
> through review/merge process last year we are near giving up when it
> comes to upstream devfreq contributions. Sylwester is still working on
> exynos-bus & interconnect integration (continuation of Artur Swigon's
> work from last year) & related issues (IRQ support for PPMU)  but
> I'm seriously considering putting it all on-hold..

The Sylwester's patches (originally Artus Swigon's path) were reviewed
and I agreed this approach about devfreq/interconnect. It needs
the review from interconnect maintainer.

> 
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
