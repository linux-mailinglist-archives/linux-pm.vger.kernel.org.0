Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22410951B8
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2019 01:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbfHSXkT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Aug 2019 19:40:19 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:20292 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728484AbfHSXkT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Aug 2019 19:40:19 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190819234016epoutp03976e517cf33f63a0bf45169c8d435115~8d14Yb2I23051730517epoutp03h
        for <linux-pm@vger.kernel.org>; Mon, 19 Aug 2019 23:40:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190819234016epoutp03976e517cf33f63a0bf45169c8d435115~8d14Yb2I23051730517epoutp03h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1566258016;
        bh=Fqpk06CqFwNPFsiG31Y8y2XDzS0wpckhbRfAnfTbQcU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=c1PVlFRtcArns1dksUuQ5c4QYtSkr2ccnQGrXoZI7HdhcMNgiS5sGo14vGlr/mtDV
         l50QxIH0df+KGNVTMs3UbO8N1fJp/oWiV8TEWr9N8e63AbniettVmW8g98E3LAEwxV
         CZ+taWyqiv4L+HWEBtoCgbYXrJOxVcOHZEm4GqVY=
Received: from epsnrtp5.localdomain (unknown [182.195.42.166]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190819234015epcas1p12380594e2583e1672cd9ec675a846194~8d13RTAWM0202202022epcas1p1V;
        Mon, 19 Aug 2019 23:40:15 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.157]) by
        epsnrtp5.localdomain (Postfix) with ESMTP id 46C9QM6YrfzMqYky; Mon, 19 Aug
        2019 23:40:11 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        17.A0.04066.B533B5D5; Tue, 20 Aug 2019 08:40:11 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190819234011epcas1p260fbb46efe0d0d59389fbaf41cb3d039~8d1zkVVb31816518165epcas1p2l;
        Mon, 19 Aug 2019 23:40:11 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190819234011epsmtrp129e8d8586be2e373f6f50864a2ffa363~8d1zjPxQO1289512895epsmtrp1K;
        Mon, 19 Aug 2019 23:40:11 +0000 (GMT)
X-AuditID: b6c32a37-e27ff70000000fe2-ef-5d5b335b3837
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DD.02.03706.B533B5D5; Tue, 20 Aug 2019 08:40:11 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190819234010epsmtip2c4d7913416dac07d2996c6c92cc67707~8d1zP1u510225502255epsmtip23;
        Mon, 19 Aug 2019 23:40:10 +0000 (GMT)
Subject: Re: [RFC PATCH 09/11] devfreq: exynos-bus: Add interconnect
 functionality to exynos-bus
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        "georgi.djakov@linaro.org" <georgi.djakov@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>,
        "inki.dae@samsung.com" <inki.dae@samsung.com>,
        "sw0312.kim@samsung.com" <sw0312.kim@samsung.com>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Lukasz Luba <l.luba@partner.samsung.com>,
        "cpgs (cpgs@samsung.com)" <cpgs@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <08bd637a-2038-9f64-a189-682427ce5bfb@samsung.com>
Date:   Tue, 20 Aug 2019 08:44:05 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB7023B5095F706635354C4C50EED70@VI1PR04MB7023.eurprd04.prod.outlook.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIJsWRmVeSWpSXmKPExsWy7bCmrm60cXSswaWXphaHjm1lt3h5SNNi
        /pFzrBZXvr5ns5i+dxObxaT7E1gszp/fwG5xq0HGYsXdj6wWmx5fY7W4vGsOm8Xn3iOMFjPO
        72OyWHvkLrvF7cYVbBZzv0xltug69JfNYsbkl2wWG796OAh7LNhU6rFpVSebx51re9g87ncf
        Z/LYvKTeY+O7HUweB9/tYfLo27KK0ePzJrkAzqhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hT
        MwNDXUNLC3MlhbzE3FRbJRefAF23zBygj5QUyhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqp
        BSk5BZYFesWJucWleel6yfm5VoYGBkamQIUJ2RmNd2eyFKyXrdj87StbA+M8iS5GTg4JAROJ
        R43NrF2MXBxCAjsYJaZ0tDBBOJ8YJQ51rGWEcL4xSvzYcJgVpuXPzFnsEIm9jBItl5ezQDjv
        GSX6m/4wg1QJCyRJLHh0EWywiMBlRomLp9ewgTjMAsfYJJYf/84OUsUmoCWx/8UNNhCbX0BR
        4uqPx4wgNq+AncSF3r1gNSwCqhIvXzwDs0UFIiQ+PYC4g1dAUOLkzCdAqzk4OAViJZ6e1AEJ
        MwuIS9x6Mp8JwpaXaN46mxlkr4TAPXaJHTd2s4PUSwi4SPy64gjxjrDEq+Nb2CFsKYmX/W1Q
        drXEypNH2CB6Oxgltuy/APW/scT+pZOZQOYwC2hKrN+lDxFWlNj5ey4jhM0r0bDxNzvEDXwS
        7772sEKs5ZXoaBOCKFGWuPzgLtMERuVZSJ6ZheSDWUg+mIWwbAEjyypGsdSC4tz01GLDAmPk
        6N7ECE7uWuY7GDec8znEKMDBqMTD6zEtKlaINbGsuDL3EKMEB7OSCG/FHKAQb0piZVVqUX58
        UWlOavEhRlNgWE9klhJNzgdmnrySeENTI2NjYwsTQzNTQ0Mlcd6FPyxihQTSE0tSs1NTC1KL
        YPqYODilGhjnWCrvM/C54nLu76WUQv7nc18Ubl7XuvT9v/CnuqzfeEvTzc9cmfgzU5dLpNin
        9qMDZ/XenBN585XPh+3mEfc/ubC7xkFHbrdZ2BYZaZNX/Pl/7tYsYVy6Mfk75wSl1lSOvLO/
        Vh6xm9th3uYrK/3gd53ptb5PR6bmvQw4MuX2SpaJkf8S+yqVWIozEg21mIuKEwGaOYSaBAQA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsWy7bCSvG60cXSswfVp7BaHjm1lt3h5SNNi
        /pFzrBZXvr5ns5i+dxObxaT7E1gszp/fwG5xq0HGYsXdj6wWmx5fY7W4vGsOm8Xn3iOMFjPO
        72OyWHvkLrvF7cYVbBZzv0xltug69JfNYsbkl2wWG796OAh7LNhU6rFpVSebx51re9g87ncf
        Z/LYvKTeY+O7HUweB9/tYfLo27KK0ePzJrkAzigum5TUnMyy1CJ9uwSujMa7M1kK1stWbP72
        la2BcZ5EFyMnh4SAicSfmbPYuxi5OIQEdjNKHH/6lxkiISkx7eJRIJsDyBaWOHy4GKLmLaPE
        qStf2EBqhAWSJBY8usgKkhARuMwosfXjFhaQBLPAGTaJrcdzIDquMUmsal3NDpJgE9CS2P/i
        Blg3v4CixNUfjxlBbF4BO4kLvXvBalgEVCVevngGZosKREgc3jELqkZQ4uTMJywgF3EKxEo8
        PakDsUtd4s+8S8wQtrjErSfzmSBseYnmrbOZJzAKz0LSPQtJyywkLbOQtCxgZFnFKJlaUJyb
        nltsWGCYl1quV5yYW1yal66XnJ+7iREc5VqaOxgvL4k/xCjAwajEw+sxLSpWiDWxrLgy9xCj
        BAezkghvxRygEG9KYmVValF+fFFpTmrxIUZpDhYlcd6neccihQTSE0tSs1NTC1KLYLJMHJxS
        DYw1/RKB7llvNxu18e11Zvtyu2i3xeXc4rdVlae6+af1+C/i6vcundWn3fNSfmbK+WWyxxRb
        IzI9Xzw32OAxuy7vauNpVsaTfPN/mH78Fnc1Xu+6wy1l63+NCjFPr/BW3GsVWBRtsl52/Y6t
        wbvy3S9UdPwtSzumyHZpH4ucnr/KkviFi0UYNimxFGckGmoxFxUnAgB1K60U7gIAAA==
X-CMS-MailID: 20190819234011epcas1p260fbb46efe0d0d59389fbaf41cb3d039
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-CPGSPASS: Y
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190723122028eucas1p2eb75f35b810e71d6c590370aaff0997b
References: <20190723122016.30279-1-a.swigon@partner.samsung.com>
        <CGME20190723122028eucas1p2eb75f35b810e71d6c590370aaff0997b@eucas1p2.samsung.com>
        <20190723122016.30279-10-a.swigon@partner.samsung.com>
        <5a82bf8a-d925-ba54-a26f-98b64bedc6e1@samsung.com>
        <VI1PR04MB7023B5095F706635354C4C50EED70@VI1PR04MB7023.eurprd04.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Artur and Leonard,

On 19. 8. 9. 오전 12:00, Leonard Crestez wrote:
> On 29.07.2019 04:49, Chanwoo Choi wrote:
>> On 19. 7. 23. 오후 9:20, Artur Świgoń wrote:
>>> This patch adds interconnect functionality to the exynos-bus devfreq
>>> driver.
>>>
>>> The devfreq target() callback provided by exynos-bus now selects either the
>>> frequency calculated by the devfreq governor or the frequency requested via
>>> the interconnect API for the given node, whichever is higher.
>>
>> Basically, I agree to support the QoS requirement between devices.
>> But, I think that need to consider the multiple cases.
>>
>> 1. When changing the devfreq governor by user,
>> For example of the connection between bus_dmc/leftbus/display on patch8,
>> there are possible multiple cases with various devfreq governor
>> which is changed on the runtime by user through sysfs interface.
>>
>> If users changes the devfreq governor as following:
>> Before,
>> - bus_dmc (simple_ondemand, available frequency 100/200/300/400 MHz)
>> --> bus_leftbus(simple_ondemand, available frequency 100/200/300/400 MHz)
>> ----> bus_display(passive)
>>
>> After changed governor of bus_dmc,
>> if the min_freq by interconnect requirement is 400Mhz,
>> - bus_dmc (powersave) : min_freq and max_freq and cur_freq is 100MHz
>> --> bus_leftbus(simple_ondemand) : cur_freq is 400Mhz
>> ----> bus_display(passive)
>>
>> The final frequency is 400MHz of bus_dmc
>> even if the min_freq/max_freq/cur_freq is 100MHz.
>> It cannot show the correct min_freq/max_freq through
>> devfreq sysfs interface.
>>
>>
>> 2. When disabling the some frequency by devfreq-thermal throttling,
>> This patch checks the min_freq of interconnect requirement
>> in the exynos_bus_target() and exynos_bus_passive_target().
>> Also, it cannot show the correct min_freq/max_freq through
>> devfreq sysfs interface.
>>
>> For example of bus_dmc bus,
>> - The available frequencies are 100MHz, 200MHz, 300MHz, 400MHz
>> - Disable 400MHz by devfreq-thermal throttling
>> - min_freq is 100MHz
>> - max_freq is 300MHz
>> - min_freq of interconnect is 400MHz
>>
>> In result, the final frequency is 400MHz by exynos_bus_target()
>> There are no problem for working. But, the user cannot know
>> reason why cur_freq is 400MHz even if max_freq is 300MHz.
>>
>> Basically, update_devfreq() considers the all constraints
>> of min_freq/max_freq to decide the proper target frequency.
> 
> I think that applying the interconnect min_freq via dev_pm_qos can help 
> with many of these concerns: update_devfreq controls all the min/max 
> handling, sysfs is accurate and better decisions can be made regarding 
> thermal. Enforcing constraints in the core is definitely better.
> 
> This wouldn't even be a very big change, you don't need to actually move 
> the interconnect code outside of devfreq. Just make every devfreq/icc 
> node register a dev_pm_qos_request for itself during registration and 
> call dev_pm_qos_update_request inside exynos_bus_icc_set.
> 
> See: https://patchwork.kernel.org/patch/11084279/

I agree this approach of Leonard. If we use the dev_pm_qos[1] feature,
it resolve the issue of my comment1/2.

In summary, when receive the minimum frequency requirement
from interconnect path, the each bus uses the dev_pm_qos interface
in order to inform the minimum frequency from interconnect to devfreq.
And then the devfreq core will execute the update_devfreq()
with all frequency requirements as following:
- the user input (min/max frequency though devfreq sysfs
- the target frequency provided by devfreq governor
- the minimum frequency from interconnect path

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
