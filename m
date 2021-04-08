Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C93D357A60
	for <lists+linux-pm@lfdr.de>; Thu,  8 Apr 2021 04:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbhDHC3s (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Apr 2021 22:29:48 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:13673 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhDHC3r (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Apr 2021 22:29:47 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210408022935epoutp0215822d8b961440a7cec1459896518db7~zwRJQWyy23209732097epoutp02R
        for <linux-pm@vger.kernel.org>; Thu,  8 Apr 2021 02:29:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210408022935epoutp0215822d8b961440a7cec1459896518db7~zwRJQWyy23209732097epoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1617848975;
        bh=GHCiJRRXgyYY/VI/udSRwsYVBhPBw2Y9FbSwPwzxm+A=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=EcpgnmD/7JaeeraPVAKQwUH+GyE3+tYnWLa3xzMBT8xKrskcIC+K8EnB/AZnOIdbn
         iqlNy4WkrJjp7Qa7a9OFyv8wtGhINRiQIQn5R/bStKVHG9evXIxgbBRNbWLbeaCNid
         hVuLuu3mNCVa6jzewjDs87jAQ8tYHGSANF2RdMfs=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20210408022934epcas1p4d6b9d4304851275e9306497ca17ac497~zwRIWcpH52026120261epcas1p4K;
        Thu,  8 Apr 2021 02:29:34 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.153]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4FG4wD3SV6z4x9Pp; Thu,  8 Apr
        2021 02:29:32 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        8B.8B.02277.C8A6E606; Thu,  8 Apr 2021 11:29:32 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210408022931epcas1p2538b7fe14b348daa7a0cadce2df09bff~zwRFRTwwV1887818878epcas1p2C;
        Thu,  8 Apr 2021 02:29:31 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210408022931epsmtrp1ea2aa8050e2d88697ac7191ba591cf5b~zwRFQGHKZ0798907989epsmtrp1F;
        Thu,  8 Apr 2021 02:29:31 +0000 (GMT)
X-AuditID: b6c32a36-4edff700000108e5-9f-606e6a8cb42a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        AE.D6.08745.A8A6E606; Thu,  8 Apr 2021 11:29:31 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210408022930epsmtip2b035be9198e08bd52f262dc01076746e~zwRE3CVmx0676906769epsmtip2a;
        Thu,  8 Apr 2021 02:29:30 +0000 (GMT)
Subject: Re: [PATCH V8 1/8] PM / devfreq: Add cpu based scaling support to
 passive_governor
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     "andrew-sh.cheng" <andrew-sh.cheng@mediatek.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com, Sibi Sankar <sibis@codeaurora.org>
Organization: Samsung Electronics
Message-ID: <cfdd3973-e4a7-8c09-8a7e-57118a7a3b9b@samsung.com>
Date:   Thu, 8 Apr 2021 11:47:02 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <fbb6c44b-eb77-14ce-9175-3f06030e6e0c@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFJsWRmVeSWpSXmKPExsWy7bCmvm5PVl6Cwenpwhbb179gtZj68Amb
        xfwj51gtzja9Ybf4dqWDyWLT42usFpd3zWGzuNx8kdHic+8RRoul1y8yWTS1GFvcblzBZvHm
        x1kmizOnL7FatO49wm7x79pGFotrC9+zWky/K2Sx8auHg7DHmnlrGD0u9/UyeeycdZfdY9Oq
        TjaPO9f2sHlsXlLv0XJyP4vHlqvtLB59W1Yxehy/sZ3J4/MmuQDuqGybjNTElNQihdS85PyU
        zLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKDnlBTKEnNKgUIBicXFSvp2NkX5
        pSWpChn5xSW2SqkFKTkFlgV6xYm5xaV56XrJ+blWhgYGRqZAhQnZGYfbX7MXdElVLGipb2Cc
        JdbFyMkhIWAiMe39QRYQW0hgB6PEoVXqEPYnRoknbwS7GLmA7M+MEn9u7GPsYuQAa7izXhoi
        votR4mfHJnYI5z2jxNa+ncwg3cICsRK/zt8Dm8omoCWx/8UNNhBbBKh5x8zZjCA2s0Avq8TM
        Q4ogNr+AosTVH4/B4rwCdhKX39xgBbFZBFQklr49A9YrKhAmcXJbC1SNoMTJmU9YQA7iFLCX
        aDkUDTFSXOLWk/lMELa8xPa3c5hBbpMQmM8pcbnnEAvExy4SS++/ZYKwhSVeHd/CDmFLSbzs
        b4OyqyVWnjzCBtHcwSixZf8FVoiEscT+pZOZQBYzC2hKrN+lDxFWlNj5ey7UX3wS7772sEIC
        i1eio00IokRZ4vKDu1BrJSUWt3eyTWBUmoXkm1lIXpiF5IVZCMsWMLKsYhRLLSjOTU8tNiww
        Qo7pTYzgRK9ltoNx0tsPeocYmTgYDzFKcDArifDu6M1OEOJNSaysSi3Kjy8qzUktPsRoCgzf
        icxSosn5wFyTVxJvaGpkbGxsYWJoZmpoqCTOm2jwIF5IID2xJDU7NbUgtQimj4mDU6qBye9y
        ac1zlf5rpX4vK39FnQxyslJ4MO3a8dSdPN2vCyLmGFlNbGc+ItriIP0pvLcsU2XSZEsPjjV/
        7me8DEnRdH7dUrT6/wy+Z/ukVyydafvm0MHCQ3V3jsdeqFAy7/zVtyl651mF5XMb95X2GZ49
        2yNffrOZg0GzL+/0o83McTw5EwRzdM/9fs1i0sVi/tDXp+2I39J1y2uuv/KREq1M/nCFTf96
        +ryj05YWbK7N2Vy9Qz1CXNJtneND88mGa9skmGM4M0oCTFb9zX7r6/peadEVFuurG1Zf+71u
        7an6RWoKcaqWS1K+i7tEcy35WOjUyLHYdeq0tCPps5dpX+Bh01Bj7P7iL7+lYknzqcOlSizF
        GYmGWsxFxYkAtQvSaX0EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGIsWRmVeSWpSXmKPExsWy7bCSvG53Vl6CwYJPzBbb179gtZj68Amb
        xfwj51gtzja9Ybf4dqWDyWLT42usFpd3zWGzuNx8kdHic+8RRoul1y8yWTS1GFvcblzBZvHm
        x1kmizOnL7FatO49wm7x79pGFotrC9+zWky/K2Sx8auHg7DHmnlrGD0u9/UyeeycdZfdY9Oq
        TjaPO9f2sHlsXlLv0XJyP4vHlqvtLB59W1Yxehy/sZ3J4/MmuQDuKC6blNSczLLUIn27BK6M
        w+2v2Qu6pCoWtNQ3MM4S62Lk4JAQMJG4s166i5GLQ0hgB6PE2fVHWLoYOYHikhLTLh5lhqgR
        ljh8uBii5i2jxMH3q9lBaoQFYiV+nb8HVs8moCWx/8UNNhBbBGjmjpmzGUEamAX6WSVe/uhi
        AkkICbSySNz/mAJi8wsoSlz98ZgRxOYVsJO4/OYGK4jNIqAisfTtGbBBogJhEjuXPGaCqBGU
        ODnzCQvIQZwC9hIth6JBwswC6hJ/5l1ihrDFJW49mc8EYctLbH87h3kCo/AsJN2zkLTMQtIy
        C0nLAkaWVYySqQXFuem5xYYFRnmp5XrFibnFpXnpesn5uZsYwVGvpbWDcc+qD3qHGJk4GA8x
        SnAwK4nw7ujNThDiTUmsrEotyo8vKs1JLT7EKM3BoiTOe6HrZLyQQHpiSWp2ampBahFMlomD
        U6qBSfrGmi13f98xf3fJULTVKCa+tHmi9p6iHmPnT7oJK9MCz+nL6E192TLNbdLFVN4b4t9f
        7ri/6VzLuk3Vv/LnOtn0FHRUVkxsnTDB9r7e76m6GR9m7NTlXledymvicHP5lL9Hvp2b8ud1
        xZ6o6qqTi8rE7707eS1TOTR/pcG7sN3hG/7YTXl8ZZagzspAHjlW3c8/wkv/x/6qTOV99ucW
        8+Ub7hF1p7exNW1/Ijev7dLOUK36krce5qvepAiWm0esThasubFBQuas6dOLggFLz/9L3s17
        VK6MpWdZ0NILPCHTjE4ekfn1kr1w+x71A3az2zdkzZ58pH0lX+uTt9v97sYUbdJdzn25tXGt
        aWvwikQlluKMREMt5qLiRAAY7M4yaQMAAA==
X-CMS-MailID: 20210408022931epcas1p2538b7fe14b348daa7a0cadce2df09bff
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210323113411epcas1p3b4367563007ca91c30201d7fc225bb67
References: <1616499241-4906-1-git-send-email-andrew-sh.cheng@mediatek.com>
        <CGME20210323113411epcas1p3b4367563007ca91c30201d7fc225bb67@epcas1p3.samsung.com>
        <1616499241-4906-2-git-send-email-andrew-sh.cheng@mediatek.com>
        <233a3bd6-7ab1-5da2-9184-a745eb253d86@samsung.com>
        <1617177820.15067.1.camel@mtksdaap41>
        <2ae8604d-0da6-4243-1b92-81b3917d7d48@samsung.com>
        <cad52436-b291-05bf-236f-7b7cb1fdbbff@samsung.com>
        <1617195800.18432.3.camel@mtksdaap41>
        <fbb6c44b-eb77-14ce-9175-3f06030e6e0c@samsung.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 4/1/21 9:16 AM, Chanwoo Choi wrote:
> On 3/31/21 10:03 PM, andrew-sh.cheng wrote:
>> On Wed, 2021-03-31 at 17:35 +0900, Chanwoo Choi wrote:
>>> On 3/31/21 5:27 PM, Chanwoo Choi wrote:
>>>> Hi,
>>>>
>>>> On 3/31/21 5:03 PM, andrew-sh.cheng wrote:
>>>>> On Thu, 2021-03-25 at 17:14 +0900, Chanwoo Choi wrote:
>>>>>> Hi,
>>>>>>
>>>>>> You are missing to add these patches to linux-pm mailing list.
>>>>>> Need to send them to linu-pm ML.
>>>>>>
>>>>>> Also, before received this series, I tried to clean-up these patches
>>>>>> on testing branch[1]. So that I add my comment with my clean-up case.
>>>>>> [1] https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/log/?h=devfreq-testing-passive-gov__;!!CTRNKA9wMg0ARbw!zIrzeDp9vPnm1_SDzVPuzqdHn3zWie9DnfBXaA-j9-CSrVc6aR9_rJQQiw81_CgAPh9XRRs$ 
>>>>>>
>>>>>> And 'Saravana Kannan <skannan@codeaurora.org>' is wrong email address.
>>>>>> Please update the email or drop this email.
>>>>>
>>>>> Hi Chanwoo,
>>>>>
>>>>> Thank you for the advices.
>>>>> I will resend patch v9 (add to linux-pm ML), remove this patch, and note
>>>>> that my patch set base on
>>>>> https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/log/?h=devfreq-testing-passive-gov__;!!CTRNKA9wMg0ARbw!yUlsuxrL5PcbF7o6A9DlCfvoA6w8V8VXKjYIybYyiJg3D0HM-lI2xRuxLUV6b3UJ8WFhg_g$ 
>>>>
>>>> I has not yet test this patch[1] on devfreq-testing-passive-gov branch.
>>>> So that if possible, I'd like you to test your patches with this patch[1] 
>>>> and then if there is no problem, could you send the next patches with patch[1]?
>>>>
>>>> [1]https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/commit/?h=devfreq-testing-passive-gov&id=39c80d11a8f42dd63ecea1e0df595a0ceb83b454__;!!CTRNKA9wMg0ARbw!yUlsuxrL5PcbF7o6A9DlCfvoA6w8V8VXKjYIybYyiJg3D0HM-lI2xRuxLUV6b3UJR2cQqZs$ 
>>>
>>>
>>> Sorry for the confusion. I make the devfreq-testing-passive-gov[1]
>>> branch based on latest devfreq-next branch.
>>> [1] https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/log/?h=devfreq-testing-passive-gov__;!!CTRNKA9wMg0ARbw!yUlsuxrL5PcbF7o6A9DlCfvoA6w8V8VXKjYIybYyiJg3D0HM-lI2xRuxLUV6b3UJ8WFhg_g$ 
>>>
>>> First of all, if possible, I want to test them[1] with your patches in this series.
>>> And then if there are no any problem, please let me know. After confirmed from you,
>>> I'll send the patches of devfreq-testing-passive-gov[1] branch.
>>> How about that?
>>>
>> Hi Chanwoo~
>>
>> We will use this on Google Chrome project.
>> Google Hsin-Yi has test your patch + my patch set v8 [2~8]
>>
>>     make sure cci devfreqs runs with cpufreq.
>>     suspend resume
>>     speedometer2 benchmark
>> It is okay.
>>
>> Please send the patches of devfreq-testing-passive-gov[1] branch.
>>
>> I will send patch v9 base on yours latter.
> 
> Thanks for your test. I'll send the patches today.

I'm sorry for delay because when I tested the patches
for devfreq parent type on Odroid-xu3, there are some problem
related to lazy linking of OPP. So I'm trying to analyze them.
Unfortunately, we need to postpone these patches to next linux
version.


[snip]

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
