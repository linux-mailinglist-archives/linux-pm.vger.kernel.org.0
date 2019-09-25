Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 654ACBD820
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2019 08:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbfIYGJX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Sep 2019 02:09:23 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:41244 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729177AbfIYGIX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Sep 2019 02:08:23 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190925060819epoutp0480fd40dea81d6a93c49d49d9a6a2a1b8~HmW_SoiCv1037410374epoutp04F
        for <linux-pm@vger.kernel.org>; Wed, 25 Sep 2019 06:08:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190925060819epoutp0480fd40dea81d6a93c49d49d9a6a2a1b8~HmW_SoiCv1037410374epoutp04F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569391699;
        bh=NVSqgS2sD3/bkGbAWvXS1ICQ4/XfwFVNzH6vZ3uBpAc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=tdtrMAQTO/h3zjIB+p1CA0FYyYtK9Kl++wjI5TPba9KyRgdqqXU/OFwL5qEadtCr5
         5k7ykNtjAi3yRCxrReY/RTVcJM37Ch3F5pvsgUIVLk+2L6Qe0jD2vR/9EVEJEYqTGt
         35q7b7nfIi2iJ7WUf4yUuavzQEjAnzvTuCOEjoVQ=
Received: from epsnrtp6.localdomain (unknown [182.195.42.167]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190925060819epcas1p3852244ec3df9ed08372c2464adbb60fe~HmW9y2g_A1302913029epcas1p3C;
        Wed, 25 Sep 2019 06:08:19 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.153]) by
        epsnrtp6.localdomain (Postfix) with ESMTP id 46dSKX5hCDzMqYkh; Wed, 25 Sep
        2019 06:08:16 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        3E.AE.04144.0540B8D5; Wed, 25 Sep 2019 15:08:16 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190925060816epcas1p2a22fe3c6cd996269b95f40e030fccdc2~HmW7EXp2f2871028710epcas1p2t;
        Wed, 25 Sep 2019 06:08:16 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190925060816epsmtrp2ff6b0a96c92f9122ba56859a55ac5639~HmW7DhQr43029130291epsmtrp2g;
        Wed, 25 Sep 2019 06:08:16 +0000 (GMT)
X-AuditID: b6c32a35-2c7ff70000001030-e8-5d8b0450b28c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        72.5B.04081.0540B8D5; Wed, 25 Sep 2019 15:08:16 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190925060815epsmtip277b765775c4a29f81a5abf1c2c6e3577~HmW6l-Lsz0925809258epsmtip2D;
        Wed, 25 Sep 2019 06:08:15 +0000 (GMT)
Subject: Re: [RFC PATCH v2 00/11] Simple QoS for exynos-bus driver using
 interconnect
To:     =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     myungjoo.ham@samsung.com, inki.dae@samsung.com,
        sw0312.kim@samsung.com, georgi.djakov@linaro.org,
        leonard.crestez@nxp.com, m.szyprowski@samsung.com,
        b.zolnierkie@samsung.com, krzk@kernel.org,
        "cpgs (cpgs@samsung.com)" <cpgs@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <0cceb46a-fca1-62ae-c2cc-fb0f9b9bd132@samsung.com>
Date:   Wed, 25 Sep 2019 15:12:39 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <c06ca89f2b40e0282f19727b95da5e5b0158d7e3.camel@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNJsWRmVeSWpSXmKPExsWy7bCmgW4AS3esQd9ELYv781oZLTbOWM9q
        8fKQpsX8I+dYLa58fc9mMX3vJjaLSfcnsFicP7+B3WLF3Y+sFpseX2O1uLxrDpvF594jjBYz
        zu9jslh75C67xe3GFWwWMya/ZHMQ8Ni0qpPN4861PWwe97uPM3lsXlLvsfHdDiaPvi2rGD0+
        b5ILYI/KtslITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wB
        ul1JoSwxpxQoFJBYXKykb2dTlF9akqqQkV9cYquUWpCSU2BZoFecmFtcmpeul5yfa2VoYGBk
        ClSYkJ1xcsc0xoJNxhXvXjxha2CcodXFyMkhIWAicef1LMYuRi4OIYEdjBL7F81gh3A+MUpM
        WvkIKvONUaLj4xzmLkYOsJbPPckQ8b2MEq+XPIAqes8o8WJNKzPIXGGBcIm5rx+wgiREBP4z
        SpxethLMYQYZ9XXeBhaQKjYBLYn9L26wgdj8AooSV388ZgSxeQXsJI5c/QVWwyKgKvHrwWQw
        W1QgQuLTg8OsEDWCEidnPmEBOYlTwFPiRjPYGGYBcYlbT+YzQdjyEs1bZzOD7JUQOMYucX7K
        VyaIr10kWnumsEPYwhKvjm+BsqUkPr/bywZhV0usPHmEDaK5g1Fiy/4LrBAJY4n9SyczgSxm
        FtCUWL9LHyKsKLHz91xGCJtXomHjb3aII/gk3n3tYYUEHa9ER5sQRImyxOUHd5kmMCrPQvLN
        LCQvzELywiyEZQsYWVYxiqUWFOempxYbFhgiR/cmRnDC1jLdwTjlnM8hRgEORiUeXgfWrlgh
        1sSy4srcQ4wSHMxKIryzZIBCvCmJlVWpRfnxRaU5qcWHGE2BgT2RWUo0OR+YTfJK4g1NjYyN
        jS1MDM1MDQ2VxHk90htihQTSE0tSs1NTC1KLYPqYODilGhjlxL6n9fdz7z8gtuHLZ029/Iq3
        FqEHgpa9/39L30Ru2b2UD7wXZq/d9bn1xSGbevOLN/bNTblX7tIyL83xTVvQjjebG+ymyi58
        9EBussyf1+s18tdt89Vz8lrisXvGi5UH17nPbt+XJ9F8a2KA5FYb562cahd3S68Jm3FQsJNh
        zVUbjdrNd0UnKbEUZyQaajEXFScCACZmiSDuAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsWy7bCSvG4AS3eswfOlLBb357UyWmycsZ7V
        4uUhTYv5R86xWlz5+p7NYvreTWwWk+5PYLE4f34Du8WKux9ZLTY9vsZqcXnXHDaLz71HGC1m
        nN/HZLH2yF12i9uNK9gsZkx+yeYg4LFpVSebx51re9g87ncfZ/LYvKTeY+O7HUwefVtWMXp8
        3iQXwB7FZZOSmpNZllqkb5fAlXFyxzTGgk3GFe9ePGFrYJyh1cXIwSEhYCLxuSe5i5GLQ0hg
        N6PEjnOHmboYOYHikhLTLh5lhqgRljh8uBgkLCTwllFi9R09EFtYIFxi7usHrCC9IgL/GSUe
        th1jBHGYBb4xSvR9XsYGMXUrk8T0H2dZQFrYBLQk9r+4wQZi8wsoSlz98ZgRxOYVsJM4cvUX
        WA2LgKrErweTwWxRgQiJwztmQdUISpyc+YQF5CJOAU+JG81gY5gF1CX+zLvEDGGLS9x6Mp8J
        wpaXaN46m3kCo/AsJN2zkLTMQtIyC0nLAkaWVYySqQXFuem5xYYFhnmp5XrFibnFpXnpesn5
        uZsYwXGrpbmD8fKS+EOMAhyMSjy8DqxdsUKsiWXFlbmHGCU4mJVEeGfJAIV4UxIrq1KL8uOL
        SnNSiw8xSnOwKInzPs07FikkkJ5YkpqdmlqQWgSTZeLglGpgZDkxeeOmDV7bzR5qvvbaliT1
        hMtUbo1Ol8DdFwpbtHbvd3nG7CGq+nb+wqgs4aYf85cUno6XvjAnrP7WgdulBS58k1u/HFjD
        JJe7WrG0WsIwX+nfuYtHRDlidv9/8uy+PefB31knj0zJ3/3+5eXNMw72WWf+YGm0LxPydv42
        8888Zd2/88N9LymxFGckGmoxFxUnAgAKosEA1wIAAA==
X-CMS-MailID: 20190925060816epcas1p2a22fe3c6cd996269b95f40e030fccdc2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-CPGSPASS: Y
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190919142321eucas1p164c2591ad402427cb71fd00c348a29ec
References: <CGME20190919142321eucas1p164c2591ad402427cb71fd00c348a29ec@eucas1p1.samsung.com>
        <20190919142236.4071-1-a.swigon@samsung.com>
        <fe6d026d-71b5-438d-6932-6a2234fc72c2@samsung.com>
        <d8550f93-d4cf-f215-c083-8ecad267d430@samsung.com>
        <c06ca89f2b40e0282f19727b95da5e5b0158d7e3.camel@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 19. 9. 25. 오후 2:47, Artur Świgoń wrote:
> Hi,
> 
> On Fri, 2019-09-20 at 11:14 +0900, Chanwoo Choi wrote:
>> Hi Artur,
>>
>> I tried to just build this patch on mainline kernel or linux-next.
>> But, when I applied them, merge conflict happens. You didn't develop
>> them on latest version. Please rebase them based on latest mainline kernel.
> 
> I developed on top of next-20190918 on which I applied
> https://patchwork.kernel.org/cover/11149497/ as I mentioned in the cover
> letter. The dev_pm_qos patches and my RFC have just cleanly rebased together on
> top of next-20190920. Could you check if you have the dev_pm_qos patches (v5,
> the version number is missing in this one; link above) and if so, where does the
> conflict appear?

I faced on the merge conflict of drivers/devfreq/exynos-bus.c.
I think that It is not related to to dev_pm_qos patch.

Maybe, Kamil's patches[1] changed the many things of exynos-bus.c
If your test branch doesn't contain following patches, 
you need to rebase your patches based on latest mainline kernel 
from Linus Torvald.
[1] https://patchwork.kernel.org/cover/11083663/
- [RESEND PATCH v5 0/4] add coupled regulators for Exynos5422/5800

Today, I tried to apply these patch again based on latest mainline kernel.
The merge conflict happen still.

- merge conflict log
Applying: devfreq: exynos-bus: Extract exynos_bus_profile_init()
error: patch failed: drivers/devfreq/exynos-bus.c:334
error: drivers/devfreq/exynos-bus.c: patch does not apply
Patch failed at 0001 devfreq: exynos-bus: Extract exynos_bus_profile_init()


> 
>> On 19. 9. 20. 오전 10:07, Chanwoo Choi wrote:
>>> Hi Artur,
>>>
>>> On v1, I mentioned that we need to discuss how to change
>>> the v2 for this. But, I have not received any reply from you on v1.
>>> And, without your reply from v1, you just send v2.
>>>
>>> I think that it is not proper development sequence.
>>> I have spent many times to review your patches
>>> and also I'll review your patches. You have to take care
>>> the reply of reviewer and and keep the basic rule
>>> of mailing contribution for discussion.
>>>
>>> On 19. 9. 19. 오후 11:22, Artur Świgoń wrote:
>>>> The following patchset adds interconnect[1][2] framework support to the
>>>> exynos-bus devfreq driver. Extending the devfreq driver with interconnect
>>>> capabilities started as a response to the issue referenced in [3]. The
>>>> patches can be subdivided into four logical groups:
>>>>
>>>> (a) Refactoring the existing devfreq driver in order to improve readability
>>>> and accommodate for adding new code (patches 01--04/11).
>>>>
>>>> (b) Tweaking the interconnect framework to support the exynos-bus use case
>>>> (patches 05--07/11). Exporting of_icc_get_from_provider() allows us to
>>>> avoid hardcoding every single graph edge in the DT or driver source, and
>>>> relaxing the requirement contained in that function removes the need to
>>>> provide dummy node IDs in the DT. Adjusting the logic in
>>>> apply_constraints() (drivers/interconnect/core.c) accounts for the fact
>>>> that every bus is a separate entity and therefore a separate interconnect
>>>> provider, albeit constituting a part of a larger hierarchy.
>>>>
>>>> (c) Implementing interconnect providers in the exynos-bus devfreq driver
>>>> and adding required DT properties for one selected platform, namely
>>>> Exynos4412 (patches 08--09/11). Due to the fact that this aims to be a
>>>> generic driver for various Exynos SoCs, node IDs are generated dynamically
>>>> rather than hardcoded. This has been determined to be a simpler approach,
>>>> but depends on changes described in (b).
>>>>
>>>> (d) Implementing a sample interconnect consumer for exynos-mixer targeted
>>>> at the issue referenced in [3], again with DT info only for Exynos4412
>>>> (patches 10--11/11).
>>>>
>>>> Integration of devfreq and interconnect functionalities is achieved by
>>>> using dev_pm_qos_*() API[5]. All new code works equally well when
>>>> CONFIG_INTERCONNECT is 'n' (as in exynos_defconfig) in which case all
>>>> interconnect API functions are no-ops.
>>>>
>>>> This patchset depends on [5].
>>>>
>>>> --- Changes since v1 [6]:
>>>> * Rebase on [4] (coupled regulators).
>>>> * Rebase on [5] (dev_pm_qos for devfreq).
>>>> * Use dev_pm_qos_*() API[5] instead of overriding frequency in
>>>>   exynos_bus_target().
>>>> * Use IDR for node ID allocation.
>>>> * Avoid goto in functions extracted in patches 01 & 02 (cf. patch 04).
>>>> * Reverse order of multiplication and division in
>>>>   mixer_set_memory_bandwidth() (patch 11) to avoid integer overflow.
>>>>
>>>> ---
>>>> Artur Świgoń
>>>> Samsung R&D Institute Poland
>>>> Samsung Electronics
>>>>
>>>> ---
>>>> References:
>>>> [1] Documentation/interconnect/interconnect.rst
>>>> [2] Documentation/devicetree/bindings/interconnect/interconnect.txt
>>>> [3] https://patchwork.kernel.org/patch/10861757/ (original issue)
>>>> [4] https://patchwork.kernel.org/cover/11083663/ (coupled regulators; merged)
>>>> [5] https://patchwork.kernel.org/cover/11149497/ (dev_pm_qos for devfreq)
>>>> [6] https://patchwork.kernel.org/cover/11054417/ (v1 of this RFC)
>>>>
>>>> Artur Świgoń (10):
>>>>   devfreq: exynos-bus: Extract exynos_bus_profile_init()
>>>>   devfreq: exynos-bus: Extract exynos_bus_profile_init_passive()
>>>>   devfreq: exynos-bus: Change goto-based logic to if-else logic
>>>>   devfreq: exynos-bus: Clean up code
>>>>   interconnect: Export of_icc_get_from_provider()
>>>>   interconnect: Relax requirement in of_icc_get_from_provider()
>>>>   interconnect: Relax condition in apply_constraints()
>>>>   arm: dts: exynos: Add parents and #interconnect-cells to Exynos4412
>>>>   devfreq: exynos-bus: Add interconnect functionality to exynos-bus
>>>>   arm: dts: exynos: Add interconnects to Exynos4412 mixer
>>>>
>>>> Marek Szyprowski (1):
>>>>   drm: exynos: mixer: Add interconnect support
>>>>
>>>>  .../boot/dts/exynos4412-odroid-common.dtsi    |   1 +
>>>>  arch/arm/boot/dts/exynos4412.dtsi             |  10 +
>>>>  drivers/devfreq/exynos-bus.c                  | 319 +++++++++++++-----
>>>>  drivers/gpu/drm/exynos/exynos_mixer.c         |  71 +++-
>>>>  drivers/interconnect/core.c                   |  12 +-
>>>>  include/linux/interconnect-provider.h         |   6 +
>>>>  6 files changed, 327 insertions(+), 92 deletions(-)
>>>>
>>>
>>>
>>
>>


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
