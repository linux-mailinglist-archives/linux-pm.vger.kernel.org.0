Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B328140436
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2020 08:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbgAQHHd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Jan 2020 02:07:33 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:21719 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbgAQHHc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jan 2020 02:07:32 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200117070730epoutp04b84d4ebe35b956976fef5fe1d4774490~qmtMDNiOR0515205152epoutp04i
        for <linux-pm@vger.kernel.org>; Fri, 17 Jan 2020 07:07:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200117070730epoutp04b84d4ebe35b956976fef5fe1d4774490~qmtMDNiOR0515205152epoutp04i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579244850;
        bh=cFarK9MsZqNPZLwDbzZwWEM500rcWbAWdAi8QDCCiuc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=u0zZHJiquxnyUkl3N/wbUvKR9KrZgVjcGkwluOoNH7S9IrvJRh5BTkQBgO49+KIDT
         jSXk465fhCYulbLeJws9m392b57oDquxDQOWfcnhSOeq72YY+THNQfmStWLGRjzIe+
         6K0Gz/CGzPheL3JFRkFhlY4kd8YpgGwRt/8dnn4s=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200117070730epcas1p46bf5ae97bada6233a7cdc3fb95b650a3~qmtL0UyrA1348113481epcas1p4j;
        Fri, 17 Jan 2020 07:07:30 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.158]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 47zXFC0SYMzMqYkW; Fri, 17 Jan
        2020 07:07:27 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        6A.D6.48019.E2D512E5; Fri, 17 Jan 2020 16:07:27 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200117070726epcas1p176a320d4d85bb2fb7484c28f9442285e~qmtIcsmGA2514625146epcas1p1I;
        Fri, 17 Jan 2020 07:07:26 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200117070726epsmtrp143cb8f1b9a1cb1d2aa2c16f94aa5ba9d~qmtIb6DC00939509395epsmtrp1I;
        Fri, 17 Jan 2020 07:07:26 +0000 (GMT)
X-AuditID: b6c32a38-23fff7000001bb93-89-5e215d2e7633
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BB.F1.06569.E2D512E5; Fri, 17 Jan 2020 16:07:26 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200117070726epsmtip18e6a561de55eafce0267301aa362dc8b~qmtIP4Y6-2981429814epsmtip1h;
        Fri, 17 Jan 2020 07:07:26 +0000 (GMT)
Subject: Re: [PATCH v4 0/3] interconnect: Support Samsung Exynos use-case
To:     =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Cc:     georgi.djakov@linaro.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com, krzk@kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <d2fd100c-0da0-a8cf-0324-539e3345cc89@samsung.com>
Date:   Fri, 17 Jan 2020 16:14:47 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <7037771c6aaa7b72a41e33c621d4e0c6db7758ca.camel@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRTH+e1xt0nL28o8Gda8EZVg21VX19AotDDqD8koS1Nv7uKGe7G7
        WRbSu0zsTTlnPqIkEkrz1UtdmD3Ww8eskEoKs1KjRKUyiupu12j/fTjnfM/3nN/vSIWKi1iI
        VG+yMVYTbSCwAFHT3UXqCNXWsHT1xG1EvSk/iKhrjhoxVdxSh1GdnbUSqufWOYwaP9qOKEdn
        q4C60t4nWSFNrKs+giW+ftGMJR5rqEaJ43VzkkRbcmJ1DK1lrErGlGXW6k3ZccTa5Iz4DM0S
        NRlBxlBLCaWJNjJxRMK6pIjVegM3BqHMpQ12LpREsyyhWh5rNdttjFJnZm1xBGPRGiwxlsUs
        bWTtpuzFWWbjMlKtjtRwhZk5uscDBzHLxKwd7z+MYntQQVAhkkkBj4Zv9zyYlxX4DQQVz1IL
        UQDHYwgm9n4X8IlvCDo9of8EA433hXy8BYHbM4cXjCCoL3/kE0zH18D3312YNzEDdyLo7T7s
        UwjxLGgs6xZ5GcPDwTXY67MOxMPg+cQ75GU5vhxc41ckXhbh8+FR0R+xl4PwjeBuOjBZMw3c
        JQO+PjLO7NfwiJjvHwwvByoEPM+F/Y2lQu8QgI9jcMZ1UcivkACeSvckT4fhBw0SnkNg6Pih
        Sd4Fl93tGC8uQNDg6hLziShwVZ3mHKScwyKouaXiw2Fw82cZ4o2nwpevRWJvCeByKDik4Evm
        Qc/bPgHPs+DC4SPYCUQ4/dZx+q3g9FvB+d+sEomq0UzGwhqzGZa0RPt/dh3yXWg4dQM1d6xr
        Q7gUEVPkjvXKdIWYzmXzjG0IpEJihtztCE1XyLV03k7Gas6w2g0M24Y03GufFIYEZZm5ezfZ
        MkhNZFRUFBVNLtGQJBEsL07g+uDZtI3JYRgLY/2nE0hlIXuQ9sI+VZnnzLGy0sHSUPuqky1X
        I8q7X+1Nn6e8/iT1lyu2+u7Z3LaZlTGWvvrR/bJPsV2tozefVs3+nD80vPtO8u1LjSmbk2rT
        Vmf267uHQ08VbHjY8eNVTcPgtpUfN+avTJMVj5WWqBaI36unqoz9KcrrVYHn47c7wiGf7d/U
        bDu+UE6IWB1NhgutLP0X09M4drcDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAIsWRmVeSWpSXmKPExsWy7bCSnK5erGKcwcYzshb357UyWmycsZ7V
        YvreTWwW589vYLe4vGsOm8Xn3iOMFjPO72OyWHvkLrsDh8emVZ1sHneu7WHz6NuyitHj8ya5
        AJYoLpuU1JzMstQifbsErozTT1rZCn5IVjx99pGtgbFDtIuRk0NCwETiydZjzF2MXBxCArsZ
        JSYeeMEEkZCUmHbxKFCCA8gWljh8uBii5i2jxOy2OcwgNcICnhLf/11gA0mICMxilDj4ow+s
        gVkgWeLOrByIhkYmiQNdq9hAGtgEtCT2v7gBZvMLKEpc/fGYEcTmFbCT2P95LTuIzSKgKnGq
        5z8riC0qECaxc8ljJogaQYmTM5+wgNicQIv/vHoPVsMsoC7xZ94lZghbXOLWk/lMELa8RPPW
        2cwTGIVnIWmfhaRlFpKWWUhaFjCyrGKUTC0ozk3PLTYsMMpLLdcrTswtLs1L10vOz93ECI4n
        La0djCdOxB9iFOBgVOLhnRGkECfEmlhWXJl7iFGCg1lJhPfkDNk4Id6UxMqq1KL8+KLSnNTi
        Q4zSHCxK4rzy+ccihQTSE0tSs1NTC1KLYLJMHJxSDYxyzQfj+o1Pr0zkut72vGzBPJVt4seX
        KiWvVWv6MmvxiV+f995w0Sy+6Jjl0eXWfH5PqIspD490rZlPn+z8e6qTFd36Vt9c1C3pvyD9
        QMWXBSs457LM/3PqlcmO89t6Kl+fu/X47OqtFy4e25Nhs3WCYNasG7lbn33h8XzbqqGt/1Ne
        qluMZ62oEktxRqKhFnNRcSIARPJfpKMCAAA=
X-CMS-MailID: 20200117070726epcas1p176a320d4d85bb2fb7484c28f9442285e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200116144241eucas1p226c1d7fc2fad5bd1b9fb6d0fb1b22bff
References: <CGME20200116144241eucas1p226c1d7fc2fad5bd1b9fb6d0fb1b22bff@eucas1p2.samsung.com>
        <20200116144202.12116-1-a.swigon@samsung.com>
        <95ac808c-aacf-8ca8-94a7-98bbdb37b39d@samsung.com>
        <7037771c6aaa7b72a41e33c621d4e0c6db7758ca.camel@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 1/17/20 3:10 PM, Artur Świgoń wrote:
> Hi Chanwoo,
> 
> On Fri, 2020-01-17 at 14:31 +0900, Chanwoo Choi wrote:
>> Hi Artur,
>>
>> I'm concerned about that make it the separate series
>> without use-case like exynos-bus, exynos-drm.
>> If this series is applied to v5.6, it doesn't make
>> the problem and the patches for exynos-bus/exynos-drm
>> will be reviewed and then merged on later kernel version.
>>
>> But, if not, the interconnect, exynos-bus and exynos-drm
>> patches should be merged into the same kernel version,
>> it must require the immutable branch among interconnect,
>> devfreq and exynos-drm. I think that you need to consider
>> it between different subsystems.
> 
> Thanks for the feedback. Due to the fact that the RFC depends
> on the proposed changes to the interconnect framework, I need
> to ensure that these three patches come first.
> 
> If there is any disagreement over any of these three patches,
> the rest of the RFC might need to be modified. In such case,
> I will update the RFC and send the rest of v4 patches (for
> exynos-bus, exynos-mixer, and probably also exynos5-dmc).

OK. Thanks.

> 
>> On 1/16/20 11:41 PM, Artur Świgoń wrote:
>>> Previously posted as a part of a larger RFC: [1].
>>>
>>> The Exynos SoC family relies on the devfreq driver for frequency
>>> scaling. However, a way to programmatically enforce QoS contraints
>>> (i.e., minimum frequency) is desired. A solution which uses the
>>> interconnect framework to ensure QoS is currently being developed[1].
>>>
>>> The exynos-bus hierarchy is composed of multiple buses which are probed
>>> separately. Sometimes the DMC is even handled by a different driver.
>>> Since the exynos-bus driver is generic and supports multiple differing
>>> bus hierarchies, IDs for nodes (i.e. buses) are assigned dynamically. Due
>>> to the unspecified relative probing order, every bus registers its own
>>> interconnect provider.
>>>
>>> Rationale for each patch in this series:
>>> * Patch 01 (exporting of_icc_get_from_provider()) makes it easy to
>>>   retrieve the parent node from the DT (cf. patch 05 in [1]).
>>> * Patch 02 (allowing #interconnect-cells = <0>) allows to remove dummy
>>>   node IDs from the DT.
>>> * Patch 03 (allowing inter-provider node pairs) is necessary to make
>>>   such multi-provider hierarchy work. A new approach implemented in v3
>>>   ensures not to break any existing drivers.
>>>
>>> ---
>>> Changes since v3 (to patches in this series):
>>> * Improve commit messages.
>>>
>>> ---
>>> Artur Świgoń
>>> Samsung R&D Institute Poland
>>> Samsung Electronics
>>>
>>> ---
>>> References:
>>> [1] https://protect2.fireeye.com/url?k=c69d0cf5-9b4f1bfc-c69c87ba-0cc47a31cdf8-2143c550c0e479bd&u=https://patchwork.kernel.org/patch/11305287/
>>>
>>> Artur Świgoń (3):
>>>   interconnect: Export of_icc_get_from_provider()
>>>   interconnect: Relax requirement in of_icc_get_from_provider()
>>>   interconnect: Allow inter-provider pairs to be configured
>>>
>>>  drivers/interconnect/core.c           | 16 ++++++++--------
>>>  include/linux/interconnect-provider.h |  8 ++++++++
>>>  2 files changed, 16 insertions(+), 8 deletions(-)
>>>
>>
>>


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
