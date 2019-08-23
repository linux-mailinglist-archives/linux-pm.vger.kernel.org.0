Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28FC89AA7A
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2019 10:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388643AbfHWIgy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Aug 2019 04:36:54 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:29037 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390581AbfHWIgy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Aug 2019 04:36:54 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190823083651epoutp020a6d1ca679c5b751596e3d219c64abec~9gGO6Kvhe1602616026epoutp02Q
        for <linux-pm@vger.kernel.org>; Fri, 23 Aug 2019 08:36:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190823083651epoutp020a6d1ca679c5b751596e3d219c64abec~9gGO6Kvhe1602616026epoutp02Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1566549411;
        bh=Jh//ZjETIZTIB0Hr14rzwCtVt6hIjQpqxhpEd0T8eto=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ujnotxYEDsQ5nReZtP09QQgvji6a8V9sfjvHV2JunFcM77/iLlXiipZsjUP6uq6ov
         CFqrgDzBXVjoUw8Lf2lCtPZeCXw19lXw93S6ua5Qmc2JTbPXodw6rI9BOz3YNQ/+G6
         WuzKDs7q5HMR2KHjWoVLbJGJR474PspSmNXyKG6Q=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190823083650epcas1p10bc3830c11cd73b0dda8827841bfb295~9gGOJa83L0136601366epcas1p11;
        Fri, 23 Aug 2019 08:36:50 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.152]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 46FFB809VvzMqYlm; Fri, 23 Aug
        2019 08:36:48 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        6A.43.04088.F95AF5D5; Fri, 23 Aug 2019 17:36:47 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190823083647epcas1p123579a604cbfd68557c4576248280400~9gGLMiNDS2827528275epcas1p11;
        Fri, 23 Aug 2019 08:36:47 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190823083647epsmtrp157f6213bc1729fb4206c027152d7a160~9gGLLvIo20080200802epsmtrp1G;
        Fri, 23 Aug 2019 08:36:47 +0000 (GMT)
X-AuditID: b6c32a35-85dff70000000ff8-61-5d5fa59fb07d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        3B.FC.03638.F95AF5D5; Fri, 23 Aug 2019 17:36:47 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190823083646epsmtip2ee3fd334328a0e60877f3f55599c3313~9gGK4MYot1724517245epsmtip2k;
        Fri, 23 Aug 2019 08:36:46 +0000 (GMT)
Subject: Re: [PATCH v3 2/2] PM / devfreq: Use dev_pm_qos for sysfs
 min/max_freq
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Jacky Bai <ping.bai@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "cpgs (cpgs@samsung.com)" <cpgs@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <c03f5a54-4c7c-f574-55ba-d84b6b160a06@samsung.com>
Date:   Fri, 23 Aug 2019 17:40:40 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB70231FF65C1A50FD6830D88FEEA50@VI1PR04MB7023.eurprd04.prod.outlook.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEJsWRmVeSWpSXmKPExsWy7bCmru78pfGxBv3dFhaHjm1lt/h6+hSj
        xctDmhbT925iszh/fgO7xdmmN+wWK+5+ZLXY9Pgaq8Xn3iOMFrcbV7BZrD53kM2i69BfNouN
        Xz0ceD3e32hl91iwqdRj06pONo871/aweWxeUu+x8d0OJo+D7/YwefRtWcXo8XmTXABnVLZN
        RmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtDRSgpliTml
        QKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwCywK94sTc4tK8dL3k/FwrQwMDI1OgwoTsjM6e
        ucwFUyQrek69YmxgvCzSxcjJISFgIjH533f2LkYuDiGBHYwSLz8vYoZwPjFKfN5ynQ3C+cYo
        sfXyfhaYlv8z3jNCJPYySjw9+JUVJCEk8J5R4vfiwC5GDg5hgUCJ2bvSQMIiAuESN5ZOBVvB
        LDCbRWL6oqNMIAk2AS2J/S9usIHY/AKKEld/PGYE6eUVsJPYNtsGJMwioCrRuOUd2F5RgQiJ
        Tw8Og63iFRCUODnzCVicUyBWYt2rB4wgNrOAuMStJ/OZIGx5ieats8G+kRDYxS7x79EFVogH
        XICGzoSyhSVeHd/CDmFLSbzsb4OyqyVWnjzCBtHcwSixZT9Ms7HE/qWTmUAOZRbQlFi/Sx8i
        rCix8/dcRgibV6Jh4292iCP4JN597WEFKQeJd7QJQZQoS1x+cJdpAqPyLCTvzELywiwkL8xC
        WLaAkWUVo1hqQXFuemqxYYEhcmRvYgSnZy3THYxTzvkcYhTgYFTi4T3RFRcrxJpYVlyZe4hR
        goNZSYS3bCJQiDclsbIqtSg/vqg0J7X4EKMpMLQnMkuJJucDc0deSbyhqZGxsbGFiaGZqaGh
        kjjvwh8WsUIC6YklqdmpqQWpRTB9TBycUg2MmTs2PHnJbDfRXzOnenvsVImaudLyzJZ7spJP
        TVyzo3H/RIEvCY33BRh/nLu8btuKpW+zJ6/IaHz1LPyPyZW26wk3f9XpVO57tu7+6QWHi0Rf
        xJas81bIPPzodXHJ/JteDYaxvvKHDh8JfMAVM2VqyIeu98Gqsv9nZ3bYvLFOn1mpOZU1yuf+
        HiWW4oxEQy3mouJEABrMdsDlAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLIsWRmVeSWpSXmKPExsWy7bCSvO78pfGxBt92slkcOraV3eLr6VOM
        Fi8PaVpM37uJzeL8+Q3sFmeb3rBbrLj7kdVi0+NrrBafe48wWtxuXMFmsfrcQTaLrkN/2Sw2
        fvVw4PV4f6OV3WPBplKPTas62TzuXNvD5rF5Sb3Hxnc7mDwOvtvD5NG3ZRWjx+dNcgGcUVw2
        Kak5mWWpRfp2CVwZnT1zmQumSFb0nHrF2MB4WaSLkZNDQsBE4v+M94xdjFwcQgK7GSUO317H
        BJGQlJh28ShzFyMHkC0scfhwMUTNW0aJ21ens4DEhQUCJWbvSgMpFxEIlzj69Q8zSA2zwFwW
        iQWfJkMN/cUiMWXBTTaQKjYBLYn9L26A2fwCihJXfzxmBBnEK2AnsW22DUiYRUBVonHLOxYQ
        W1QgQuLwjlmMIDavgKDEyZlPwOKcArES6149AIszC6hL/Jl3iRnCFpe49WQ+E4QtL9G8dTbz
        BEbhWUjaZyFpmYWkZRaSlgWMLKsYJVMLinPTc4sNC4zyUsv1ihNzi0vz0vWS83M3MYIjVUtr
        B+OJE/GHGAU4GJV4eAs64mKFWBPLiitzDzFKcDArifCWTQQK8aYkVlalFuXHF5XmpBYfYpTm
        YFES55XPPxYpJJCeWJKanZpakFoEk2Xi4JRqYGwyaAm370u/6/9McU+G7SxmwdNNN1Pj4qsX
        vti/+aGymVpHy72/G/4c6ri79W2vbXSOi1bZirW7Wf79nHLeyvSqlN3LtniLLw8r13W+nnz/
        /7Yrr5i32X+T5VurtUH9+D/fr73P07fOqLEy0d9oFxQt7djebLQ/58Tu6HSVyaq806vf+0za
        YqjEUpyRaKjFXFScCADLlrbs0AIAAA==
X-CMS-MailID: 20190823083647epcas1p123579a604cbfd68557c4576248280400
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-CPGSPASS: Y
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190820152411epcas4p33e2ef4d271ddd82a4401c0286b53d2f1
References: <cover.1566314535.git.leonard.crestez@nxp.com>
        <CGME20190820152411epcas4p33e2ef4d271ddd82a4401c0286b53d2f1@epcas4p3.samsung.com>
        <af14021b98254032e856397b54329756c1cc59c0.1566314535.git.leonard.crestez@nxp.com>
        <e2ba9b0d-1930-0d2a-c262-72f0f85c86d0@samsung.com>
        <VI1PR04MB7023A7AC7DDE349BF6D2D2C9EEAA0@VI1PR04MB7023.eurprd04.prod.outlook.com>
        <921d9eb8-aa38-6e67-ac2e-55e01bf630f5@samsung.com>
        <VI1PR04MB7023D551332373BE98CA60E8EEA50@VI1PR04MB7023.eurprd04.prod.outlook.com>
        <4bdc0742-42ab-1ab6-4868-409eb9738cd8@samsung.com>
        <VI1PR04MB70231FF65C1A50FD6830D88FEEA50@VI1PR04MB7023.eurprd04.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 8. 22. 오후 9:24, Leonard Crestez wrote:
> On 22.08.2019 14:06, Chanwoo Choi wrote:
>> On 19. 8. 22. 오후 7:58, Leonard Crestez wrote:
>>> On 8/22/2019 1:03 PM, Chanwoo Choi wrote:
>>>> This patch doesn't check the range of input value
>>>> with the supported frequencies of devfreq device.
>>>>
>>>> For example,
>>>> The devfreq0 device has the following available frequencies
>>>> 100000000 200000000 300000000
>>>>
>>>> and then user enters the 500000000 as following:
>>>> echo 500000000 > /sys/class/devfreq/devfreq0/min_freq
>>>>
>>>> In result, get_effective_min_freq() will return the 500000000.
>>>> It is wrong value. it show the unsupported frequency through
>>>> min_freq sysfs path.
>>>
>>> Through dev_pm_qos devices can also ask for a freq higher than the
>>> maximum OPP and unlike sysfs there is no way to reject such requests,
>>> instead PM qos claims it's based on "best effort".
>>>
>>> There are many requests in the kernel for "PM_QOS_CPU_DMA_LATENCY 0" and
>>> I think that DEV_PM_QOS_MIN_FREQUENCY, MAX_S32 is a reasonable way for a
>>> device to request "max performance" from devfreq.
>>>
>>> Rejecting min > max is complicated (what happens to rejected requests
>>> when max goes back up?) and I think it's better to just stick with a
>>> "max overrides min" policy since it can already deal with conflicts.
>>>
>>> Do you have a usecase for rejecting out-of-range min_freq from
>>> userspace? cpufreq also accepts arbitrary min/max values and handles them.
>>
>> I don't mean the rejecting when user enter the out-of-range frequency.
>> As I commented, user can enter the value they want. But, we should
>> check the range of input because devfreq have to show the correct supported
>> frequency through sysfs.
> 
> We can avoid showing an out-of-range value in min_freq by printing 
> min(min_freq, max_freq).

You can check the range of frequency in the get_min_freq()/get_max_freq().
I want to return the meaningful frequency from get_min_freq()/get_max_freq().

Everyone expects get_min_freq()/get_max_freq() functions will retunrn
the supported min/max frequency. If get_min_freq()/get_max_freq()
return the our-of-range frequency, it is not nice and cause the confusion
why these functions return the out-of-range frequency..

Also, if we don't check the return value of dev_pm_qos_read_value(),
the out-of-range frequency of dev_pm_qos_read_value() would be used
on multiple point of devfreq.c. I think that it is not good.

> 
> The max_freq value from pm_qos can still be between OPPs so maybe print 
> devfreq_recommended_opp(max_freq, DEVFREQ_FLAG_LEAST_UPPER_BOUND).
> 
>>> In theory pm_qos could be extended to differentiate between "soft"
>>> requests (current behavior) and "hard" requests which return errors if
>>> they can't be guaranteed but this is far out of scope.
>>
>> I think that you agreed the limitation of dev_pm_qos when entering
>> or requesting the unsupported frequency.
> 
> Yes, "best effort qos" is acceptable for now.
> 

And please don't remove the my previous comment.
Just reply your opinion without any removal.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
