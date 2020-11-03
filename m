Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B94C2A4CE1
	for <lists+linux-pm@lfdr.de>; Tue,  3 Nov 2020 18:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbgKCRbA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Nov 2020 12:31:00 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:33386 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbgKCRa7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Nov 2020 12:30:59 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201103173048euoutp02f75e5d3e0e2fffe61bc402cc24f97682~ED7efw5I01976319763euoutp02k
        for <linux-pm@vger.kernel.org>; Tue,  3 Nov 2020 17:30:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201103173048euoutp02f75e5d3e0e2fffe61bc402cc24f97682~ED7efw5I01976319763euoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1604424648;
        bh=FvqSgYlnEFpwlpU+wYR8aeZGcpfordNaAzo8m3V9k1Y=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=e0Q0PFxldGQ5t3CCW7L+/5kKEm5g5LqgGrimRz22zkEC9Mv1WUdsBJ5zkRhTSjHQN
         TtHkcfFltoKLwwGdVVWsYvk9UE5E9RpLX81BCBLejALIO22uaeqj5DnIHr+joRmXSR
         39OlHnyjkiwoev8XsOnoyMrPTyo/GbuIAcuvRDY8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20201103173042eucas1p11d5610d3ebc068bbe49607afd374e33e~ED7ZSVmqO0494704947eucas1p18;
        Tue,  3 Nov 2020 17:30:42 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id D0.CD.05997.2C391AF5; Tue,  3
        Nov 2020 17:30:42 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20201103173042eucas1p2035478a24d6104b5782214d89e1fffd2~ED7Y5y9Zt0590405904eucas1p2J;
        Tue,  3 Nov 2020 17:30:42 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201103173042eusmtrp2412383902ac65b5e457be582d2c19af7~ED7Y5FUaq2312523125eusmtrp2j;
        Tue,  3 Nov 2020 17:30:42 +0000 (GMT)
X-AuditID: cbfec7f4-677ff7000000176d-c9-5fa193c2218e
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id E8.C7.06314.2C391AF5; Tue,  3
        Nov 2020 17:30:42 +0000 (GMT)
Received: from [106.210.123.115] (unknown [106.210.123.115]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20201103173041eusmtip1884fcdf07c829fed3a1c237954131935~ED7XtsfOD1391313913eusmtip1F;
        Tue,  3 Nov 2020 17:30:41 +0000 (GMT)
Subject: Re: [PATCH v7 2/6] interconnect: Add generic interconnect driver
 for Exynos SoCs
To:     cwchoi00@gmail.com
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-ID: <9081148f-5ed4-97a3-84a9-4ea3eb157b73@samsung.com>
Date:   Tue, 3 Nov 2020 18:30:40 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <CAGTfZH3seoTUd68pq+RCSs9BfnmkUaeoipML=85aUPyvcWZ6fw@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA03SfUhTURQA8O7e29tmzZ7T2kFDcRiUomaGPErMInBQ0Af9EUbazIdabsqe
        mhaRMee3JgrOhukKIhuKKaI5P8Axm2VqWpikMsVRKonKlvhRmttT8r/fveece86By8dEo1xP
        fpIijVYqZMkSwgVvfb82FGiseBF74vNIGGWpUSOqqaqRS32z/+RSP3oDqFrTIJf6+nuRoDRd
        zQQ1NPSWR30xVBOUrcSEqKqhbg7VYJrkUeNP6ghK3WXiUVUVc0TkQWm7dpInbdYXENKJ0U5C
        aikyc6SlLXoktTV7XyGiXcLj6eSkDFoZHHHbJbFrqQBL7dqfuaxZ4GSjekEhEvCBPAXDlk7k
        sIisQzDWLmdtR9C+hRUil23bEPwa03F3CzT5+Tw28BpB0V/9TtYyAvvwDObIcidvwnSFwWkP
        8jC0VVqRIwkjN3FYNeQ5+xFkCJT0ljotJCOgbmOa4zBO+kH5RDfu8CEyBsqacnA2xw0+PLM6
        LSCvwpv5PKcxUgzfrbUc1j7QtlDtnAjINR6MVU7i7NwXoEKlQqzdYd7cwmN9BLbaHcWOAhWC
        4o5xHnsoQ2Ax63YqzsDE4DpRiPjbLY5DoyHYQSDPwYjpGEtXGFtwY2dwhfJWDcZeCyE/V8S+
        4Qcbeg2HtScUWbfwMiTR7tlMu2cb7Z5ttP/b6hCuR2I6nZEn0MxJBX0/iJHJmXRFQtCdFHkz
        2v5t/Ztm+ztk+BNnRCQfSQ4II2ldrIgry2Cy5EYEfEziITw/0B8jEsbLsh7QypRYZXoyzRiR
        Fx+XiIWhL+duicgEWRp9j6ZTaeVulMMXeGajhIc5i30+hhbPlKnis7ZQIxb4uMbDPqPySlcq
        1JcyVa711/vXOzL1I3FRPasd488brklCWtOii3r2zQas9PkuLJE6dV0YFTZrm7KPJnoP2AM8
        knz1wxdFi1nGT0+jHl2+y0nRCl9FhByN+5gbu+nvusL4hQdor6j9025YTou9JTiTKAvxx5SM
        7B+rFaUcaQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJIsWRmVeSWpSXmKPExsVy+t/xu7qHJi+MN1i8UM7i/rxWRouNM9az
        Wlz/8pzV4tlRbYv5R86xWlz5+p7NYvreTWwW589vYLe4vGsOm8Xn3iOMFjPO72OyWHvkLrvF
        7cYVbBate4+wW8yY/JLNgd9j56y77B6bVnWyedy5tofN4373cSaPvi2rGD0+b5ILYIvSsynK
        Ly1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy9j7oZO5YC93
        xcfpb5kaGNdwdjFyckgImEhM7+hg72Lk4hASWMoosaf1G0sXIwdQQkpifosSRI2wxJ9rXWwQ
        Ne8ZJZ58uw5WIywQLTH1gyNIjYiAmMT2aU8YQWqYBVpYJW6feMEE0fCBSWLtjX5WkCo2AUOJ
        3qN9jCA2r4CdxIrfD5lAbBYBFYlJd/axgNiiAnESPyb2skHUCEqcnPkELM4pECix8lU7mM0s
        oC7xZ94lZghbXOLWk/lMELa8xPa3c5gnMArNQtI+C0nLLCQts5C0LGBkWcUoklpanJueW2yo
        V5yYW1yal66XnJ+7iREYzduO/dy8g/HSxuBDjAIcjEo8vA6pC+KFWBPLiitzDzFKcDArifA6
        nT0dJ8SbklhZlVqUH19UmpNafIjRFOi5icxSosn5wESTVxJvaGpobmFpaG5sbmxmoSTO2yFw
        MEZIID2xJDU7NbUgtQimj4mDU6qBcZbX0orpmRZaKTuYy/U3fVNjf/aUS1Hz7+PpvxMyYrpm
        XL146Laon9UkHhvjpcy7OzkfNFy+eWtSbYHFwSjRwmzVhdzsjFcazYMiBNil7nm8y0tOMEy3
        1skyYf5icCLxTbzH1eNLvu9ru7/saV7jnUaWfyeFTZZ13p4lEr+O6+wKX/3f3/snKbEUZyQa
        ajEXFScCAHCh7nv8AgAA
X-CMS-MailID: 20201103173042eucas1p2035478a24d6104b5782214d89e1fffd2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201030125301eucas1p218b0e654cb4c826b05280f28836da8d9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201030125301eucas1p218b0e654cb4c826b05280f28836da8d9
References: <20201030125149.8227-1-s.nawrocki@samsung.com>
        <CGME20201030125301eucas1p218b0e654cb4c826b05280f28836da8d9@eucas1p2.samsung.com>
        <20201030125149.8227-3-s.nawrocki@samsung.com>
        <88af4e53-6c7a-c2e6-ad28-a9d6bb5bf623@samsung.com>
        <6cc9a2f8-9d9a-68b7-9f47-e16fefb18d88@samsung.com>
        <CAGTfZH3seoTUd68pq+RCSs9BfnmkUaeoipML=85aUPyvcWZ6fw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03.11.2020 15:12, Chanwoo Choi wrote:
>>> I have a question about exynos_icc_get_parent().
>>> As I checked, this function returns the only one icc_node
>>> as parent node. But, bus_display dt node in the exynos4412.dtsi
>>> specifies the two interconnect node as following with bus_leftbus, bus_dmc,
>>>
>>> When I checked the return value of exynos_icc_get_parent()
>>> during probing for bus_display device, exynos_icc_get_parent() function
>>> only returns 'bus_leftbus' icc_node. Do you need to add two phandle
>>> of icc node?
>> Yes, as we use the interconnect consumer bindings we need to specify a path,
>> i.e. a <initiator, target> pair. When the provider node initializes it will
>> link itself to that path. Currently the provider driver uses just the first
>> phandle.

> As I knew, the interconnect consumer bindings use the two phandles
> in the interconnect core as you commented. But, in case of this,
> even if add two phandles with interconnect consuming binding style,
> the exynos interconnect driver only uses the first phandle.
> 
> Instead, I think we better explain this case into a dt-binding
> document for users.

Fair enough, I'll try to improve the description, do you perhaps have 
any suggestions?

The DT binding reflects how the hardware structure looks like and the
fact that the driver currently uses only one of the phandles could be
considered an implementation detail.

-- 
Regards,
Sylwester
