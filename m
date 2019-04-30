Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 237C6100F1
	for <lists+linux-pm@lfdr.de>; Tue, 30 Apr 2019 22:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfD3Uga (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Apr 2019 16:36:30 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:35162 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbfD3Uga (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Apr 2019 16:36:30 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190430203628euoutp0139d2365d20759636b891dd8c81a7793a~aWut4YlQZ1962319623euoutp01A
        for <linux-pm@vger.kernel.org>; Tue, 30 Apr 2019 20:36:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190430203628euoutp0139d2365d20759636b891dd8c81a7793a~aWut4YlQZ1962319623euoutp01A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1556656588;
        bh=9vsMiykLOjeRt1UBwt+uh9cpWO5LxcvBibQAYduQZ2k=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=qkOJAd42VxebsGSE7i8GchRoB2K3SxV+SPRpSysABmd+Mv/Ph1ZjUYCo0lF06xYA5
         JTqoaLC+sWVlgZMDrODAZ9OT9swRwgqbqsn0VvmiOgpmkPPeElCI3exODP1OuTy9o7
         umGYaD07/zQLYYlJmTfSSbCNy2dTm81D0PV2CewU=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190430203627eucas1p2cd7cdeda0a90d5f910b62e2a28f30dcd~aWus59kQn1819918199eucas1p2Z;
        Tue, 30 Apr 2019 20:36:27 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 18.34.04377.BC1B8CC5; Tue, 30
        Apr 2019 21:36:27 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190430203626eucas1p1b6c7ee4f818e4cce513bb3d2c9fed071~aWurnSe8y3007630076eucas1p1y;
        Tue, 30 Apr 2019 20:36:26 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190430203625eusmtrp278c27e285d1adecadf4629eef010cd59~aWurXp6U51705217052eusmtrp2j;
        Tue, 30 Apr 2019 20:36:25 +0000 (GMT)
X-AuditID: cbfec7f4-113ff70000001119-92-5cc8b1cb95d0
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 40.F2.04140.9C1B8CC5; Tue, 30
        Apr 2019 21:36:25 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190430203624eusmtip1b4f8457819f10c76a30cfc5f09f71ffe~aWuqdkACg1788717887eusmtip1j;
        Tue, 30 Apr 2019 20:36:24 +0000 (GMT)
Subject: Re: [PATCH v3 1/4] include: dt-bindings: add Performance Monitoring
 Unit for Exynos
To:     Chanwoo Choi <cw00.choi@samsung.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, kgene@kernel.org,
        willy.mh.wolff.ml@gmail.com
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <d07544be-50c8-4520-4637-b0938701df1e@partner.samsung.com>
Date:   Tue, 30 Apr 2019 22:36:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <a1ff3566-6117-b670-a2f3-b60a2bbec14a@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0gUURTHuzs7O6O0eh0tTxZFS0WZWUbRQNEDSoaMKCHIFHPNSSNdayc1
        S0p7mImv/GC5VhqY2mL5aBUVtNDV9VFqWmlt0mM10zQSLYzNasdR8tvvnPu79/wPXJpg3pBu
        9AnNGV6rUYerFPbyyqZf7evaypoDNmRVOLJlt0pItmdikGRzje0km275SrAdHaUU+/zSCMWW
        W16TbHfNbQU7nmpE7K2OOhn70NhHsfd7XshYc0KRgr1aa6TYhpFrJPuz+RPaibniu8WIq9b1
        UVy5/rqCe5x/kUsz6BE3Xr70gOKI/bYQPvxENK9dvz3IPszQ+5E49QyfbX97mYhHlcpkZEcD
        3gTXphLlIjO4CEFB+hKJJxBYKnwlHkdQmrZ51h9rsVDJyN7WL7T5TQWEVIwiaK9rRKLljAPh
        kSF72nLBLQhSE/pIsSDEp1o+vLYVNK3AnlClPy1eUGJvaEvpo0SW45Xwt/IKIfICfBjeN5WS
        kuMELdn901Ht8A7orP+sEJnArvC2P1cm8TK4XJEznQjwFAVNrT8UUu7dUPJgAEnsDMMmAyXx
        EvhbLV0GLEB86r0ZJw4s6XdmnK3QYHoxnZnAa6CkZr3U3gXvcqtkYhuwA/SOOkkRHCCz8iYh
        tZWQlMhI9mowpHTODFoIhcVZVAZS6eYsppuzjG7OMrr/c/OQXI9c+SghIpQXNmr4GE9BHSFE
        aUI9j0VGlCPbh2v7Y5qoQjW/g+sRppFqvrLTuzmAIdXRQmxEPQKaULkoOVNjAKMMUcee47WR
        R7VR4bxQjxbTcpWr8vy8D/4MDlWf4U/y/CleO3sqo+3c4hH9Msx9uCvej/F5+ZPrn9q7JXPt
        7t+NOYHuhxo8Mhz8vm/zLTnSvYhpJZfHfHI6FzLo8W3VgBW+BN94OmCefO/ddeH0cH7c+aKh
        rH2MOc9/aJffQb47cGzF9rHqTMfIrII9PtZXVp+uIK9JU/X+JHP2k97M4XmHj1vNRnV/rQeV
        w6nkQpjay53QCup/Qh2NJWwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsVy+t/xu7onN56IMTiwWMli44z1rBbXvzxn
        tZh/5ByrRf/j18wW589vYLc42/SG3WLT42usFpd3zWGz+Nx7hNFixvl9TBZrj9xlt1h6/SKT
        xe3GFWwWrXuPsFscftPOavHtxCNGBwGPNfPWMHrsnHWX3WPTqk42j81L6j36tqxi9Pi8SS6A
        LUrPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7MstUjfLkEvY8uN
        h8wFZwQqzt1qZm5g3MbbxcjJISFgIvHx5GP2LkYuDiGBpYwSH94fZ4NIiElM2redHcIWlvhz
        rYsNoug1o8Se/3PAioQF4iTWbZkJ1i0icJJRYvaEv0wgDrPAZ0aJ6WsuM0O0TGGSOLS2Acjh
        4GAT0JPYsaoQpJtXwE3idM9dsBUsAqoS/7e1MIPYogIREmfer2CBqBGUODnzCZjNKWAvceHQ
        M7DNzAJmEvM2P2SGsMUlbj2ZzwRhy0s0b53NPIFRaBaS9llIWmYhaZmFpGUBI8sqRpHU0uLc
        9NxiI73ixNzi0rx0veT83E2MwNjeduznlh2MXe+CDzEKcDAq8fBqeJ6IEWJNLCuuzD3EKMHB
        rCTC63H8aIwQb0piZVVqUX58UWlOavEhRlOg5yYyS4km5wPTTl5JvKGpobmFpaG5sbmxmYWS
        OG+HwMEYIYH0xJLU7NTUgtQimD4mDk6pBsaKMqeDEp6GNdNfup3y4anKX6Z3+E/j3fDwE+pv
        OXafv+5qpaCc87/LKktA9Yu/U0LQTdW+eavfL33rIjhJ5ZiptI+oteUGy/RvK1ztZt3peZps
        16gd+78gylsl4zSDRpnavM0i89WzJyqWvNa/vEjCWGfVm2cMBnEaBW3FodW19Qftnt05pMRS
        nJFoqMVcVJwIALxxx3kDAwAA
X-CMS-MailID: 20190430203626eucas1p1b6c7ee4f818e4cce513bb3d2c9fed071
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190419134820eucas1p154e839769af0e1b8bae17ce3efa0ba93
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190419134820eucas1p154e839769af0e1b8bae17ce3efa0ba93
References: <1555681688-19643-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190419134820eucas1p154e839769af0e1b8bae17ce3efa0ba93@eucas1p1.samsung.com>
        <1555681688-19643-2-git-send-email-l.luba@partner.samsung.com>
        <a1ff3566-6117-b670-a2f3-b60a2bbec14a@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 4/30/19 6:56 AM, Chanwoo Choi wrote:
> Hi,
> 
> I agree of this patch. But, I add the minor comments.
> 
> If you edit them according to my comment, feel free to add my following tag:
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> 
> On 19. 4. 19. 오후 10:48, Lukasz Luba wrote:
>> This patch add support of a new feature which can be used in DT:
>> Performance Monitoring Unit with defined event data type.
>> In this patch the event data types are defined for Exynos PPMU.
>> The patch also updates the MAINTAINERS file accordingly and
>> adds the header file to devfreq event subsystem.
>>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   MAINTAINERS                           |  1 +
>>   include/dt-bindings/pmu/exynos_ppmu.h | 26 ++++++++++++++++++++++++++
>>   2 files changed, 27 insertions(+)
>>   create mode 100644 include/dt-bindings/pmu/exynos_ppmu.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 3671fde..1ba4b9b 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -4560,6 +4560,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git
>>   S:	Supported
>>   F:	drivers/devfreq/event/
>>   F:	drivers/devfreq/devfreq-event.c
>> +F:	include/dt-bindings/pmu/exynos_ppmu.h
>>   F:	include/linux/devfreq-event.h
>>   F:	Documentation/devicetree/bindings/devfreq/event/
>>   
>> diff --git a/include/dt-bindings/pmu/exynos_ppmu.h b/include/dt-bindings/pmu/exynos_ppmu.h
>> new file mode 100644
>> index 0000000..08fdce9
>> --- /dev/null
>> +++ b/include/dt-bindings/pmu/exynos_ppmu.h
>> @@ -0,0 +1,26 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Samsung Exynos PPMU event types for counting in regs
>> + *
>> + * Copyright (c) 2019, Samsung
> 
> Mabye, "Samsung Electronics" instead of 'Samsung'.
ACK
> 
>> + * Author: Lukasz Luba <l.luba@partner.samsung.com>
>> + */
>> +
>> +#ifndef __DT_BINDINGS_PMU_EXYNOS_PPMU_H
>> +#define __DT_BINDINGS_PMU_EXYNOS_PPMU_H
>> +
>> +
> 
> Remove unneeded blank line.
OK done. I will add your 'Acked-by' in the next version.

Regards,
Lukasz

