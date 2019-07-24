Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA27672F9F
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2019 15:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbfGXNKw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Jul 2019 09:10:52 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:57987 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727405AbfGXNKt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jul 2019 09:10:49 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190724131047euoutp02959865cb0ad995b6d7feddf59ed82499~0We11O9hi1103511035euoutp02V
        for <linux-pm@vger.kernel.org>; Wed, 24 Jul 2019 13:10:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190724131047euoutp02959865cb0ad995b6d7feddf59ed82499~0We11O9hi1103511035euoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563973847;
        bh=PEOtSSoRhkQX8OsDsJURuU47w80rGtTf9ArwdLYI4tU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=o56GXd55wfxDL4xD0jeVqb82HviKy2O2dxMO3tCDxuaYTlM9kJhV9iE3VK30MfF+f
         r3oVJlOmkU56cIzeSgWzJPBLzV9h8fQhNzvHNPtaH+zFaJQhGOYUebSfAnX1WI0nL/
         el6vdQAp9naWwoSgcQBTLgio9P95vQQWbH8lDFkI=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190724131046eucas1p1e5135c654b515f7044eeb7597e0ae41a~0We1ECbTY2976329763eucas1p1L;
        Wed, 24 Jul 2019 13:10:46 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 37.D8.04325.5D8583D5; Wed, 24
        Jul 2019 14:10:45 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190724131045eucas1p162379c36506e8b94147baa865f0409f7~0We0SfRBJ2476524765eucas1p1m;
        Wed, 24 Jul 2019 13:10:45 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190724131045eusmtrp2d7e8381dfed5e5e61bd40cf0f0003339~0We0EUqBM0076200762eusmtrp2Q;
        Wed, 24 Jul 2019 13:10:45 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-31-5d3858d53e1b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 31.45.04140.4D8583D5; Wed, 24
        Jul 2019 14:10:45 +0100 (BST)
Received: from [106.120.50.63] (unknown [106.120.50.63]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190724131040eusmtip1c8fbf50afad8f6dde8c1ad38a074adcf~0WewOCuXU1901719017eusmtip1c;
        Wed, 24 Jul 2019 13:10:40 +0000 (GMT)
Subject: Re: [PATCH v2 0/9] Exynos Adaptive Supply Voltage support
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     krzk@kernel.org, robh+dt@kernel.org, vireshk@kernel.org,
        devicetree@vger.kernel.org, kgene@kernel.org,
        pankaj.dubey@samsung.com, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, b.zolnierkie@samsung.com
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <5ef302a4-5bbf-483d-dfdf-cf76f6f69cee@samsung.com>
Date:   Wed, 24 Jul 2019 15:10:39 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190723020450.z2pqwetkn2tfhacq@vireshk-i7>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOKsWRmVeSWpSXmKPExsWy7djP87pXIyxiDZ59MLPYOGM9q8X8I+dY
        Lfofv2a2OH9+A7vFpsfXWC0u75rDZvG59wijxYzz+5gsFm39wm7RuvcIu8XhN+2sFhu/elhs
        fnCMzYHXY9OqTjaPO9f2sHlsXlLv0bdlFaPH501yAaxRXDYpqTmZZalF+nYJXBmta6IKJvBU
        TDuzgLGB8RJnFyMnh4SAicTv2d9Zuxi5OIQEVjBKHL+4kQnC+cIocalxNjOE85lRovfQYzaY
        lu87T0ElljNKrG88DdX/llHi64e/YFXCAk4Se35/BbNFBCIlnk6AmMsssIxJ4vaEjWAJNgFD
        ia63XWA2r4CdxKpH/WA2i4CqxNKJc1lBbFGBGImdb3qYIWoEJU7OfMICYnMKWEosfX2dEcRm
        FpCX2P52DjOELS5x68l8sGUSArfYJTZc+gKU4AByXCTu77KCeEFY4tXxLewQtozE/50w9c2M
        Eg/PrWWHcHoYJS43zWCEqLKWOHz8IivIIGYBTYn1u/Qhwo4SfVeOMEHM55O48VYQ4gY+iUnb
        pkOt5ZXoaBOCqFaTmHV8HdzagxcuMU9gVJqF5LNZSL6ZheSbWQh7FzCyrGIUTy0tzk1PLTbO
        Sy3XK07MLS7NS9dLzs/dxAhMXqf/Hf+6g3Hfn6RDjAIcjEo8vBVM5rFCrIllxZW5hxglOJiV
        RHgDG8xihXhTEiurUovy44tKc1KLDzFKc7AoifNWMzyIFhJITyxJzU5NLUgtgskycXBKNTCa
        By7ezWPl6j4vS1tC/J9EY5Pg4exN934q6+kKqLj3/ExZI7zEMdTm2tqfyts3tdinSF37fqri
        v0zp1/VH7rZ8W87w7kq0Q2qwsu/LJj7TSD/jWTdNVx/U9xW1kuDXFtIv2ji1v+tx5Fw1XRMR
        niXPU2zY3ub+Patd9DmEq4hz1rawHuvYu0osxRmJhlrMRcWJAOcDRbxaAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBIsWRmVeSWpSXmKPExsVy+t/xu7pXIyxiDV4uYrTYOGM9q8X8I+dY
        Lfofv2a2OH9+A7vFpsfXWC0u75rDZvG59wijxYzz+5gsFm39wm7RuvcIu8XhN+2sFhu/elhs
        fnCMzYHXY9OqTjaPO9f2sHlsXlLv0bdlFaPH501yAaxRejZF+aUlqQoZ+cUltkrRhhZGeoaW
        FnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehmta6IKJvBUTDuzgLGB8RJnFyMnh4SAicT3
        naeYQWwhgaWMEodPZUDEZSROTmtghbCFJf5c62LrYuQCqnnNKDHtz3QmkISwgJPEnt9f2UBs
        EYFIiYmtC5lBipgFljFJNLSfZoGYuo9R4tjyNBCbTcBQouttF1gDr4CdxKpH/WA2i4CqxNKJ
        c8G2iQrESOw7s50dokZQ4uTMJ2BzOAUsJZa+vs4IYjMLmEnM2/yQGcKWl9j+dg6ULS5x68l8
        pgmMQrOQtM9C0jILScssJC0LGFlWMYqklhbnpucWG+kVJ+YWl+al6yXn525iBMbqtmM/t+xg
        7HoXfIhRgINRiYe3gsk8Vog1say4MvcQowQHs5IIb2CDWawQb0piZVVqUX58UWlOavEhRlOg
        5yYyS4km5wPTSF5JvKGpobmFpaG5sbmxmYWSOG+HwMEYIYH0xJLU7NTUgtQimD4mDk6pBsat
        BpObGdb8eNJ9TFIk3e1X9luVtLSYO/Hfn5gHz1o2dy5nQTbHA//GV8xaq/eGsF/doTVFYGnZ
        mrkmtsem1kxsWnAyoFfmec/a849zGFfPPiD1rXt9PtPkvjtX/36u+/tVL/iq0pLH38+8Wni8
        M9/SKmjeubJ5tu4MD+YvEnyR6Zil1rSUbfNMJZbijERDLeai4kQA1LqK2+sCAAA=
X-CMS-MailID: 20190724131045eucas1p162379c36506e8b94147baa865f0409f7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190718143117eucas1p1e534b9075d10fbbbe427c66192205eb1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190718143117eucas1p1e534b9075d10fbbbe427c66192205eb1
References: <CGME20190718143117eucas1p1e534b9075d10fbbbe427c66192205eb1@eucas1p1.samsung.com>
        <20190718143044.25066-1-s.nawrocki@samsung.com>
        <20190723020450.z2pqwetkn2tfhacq@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,

On 2019-07-23 04:04, Viresh Kumar wrote:
> On 18-07-19, 16:30, Sylwester Nawrocki wrote:
>> This is second iteration of patch series adding ASV (Adaptive Supply
>> Voltage) support for Exynos SoCs. The first one can be found at:
>> https://lore.kernel.org/lkml/20190404171735.12815-1-s.nawrocki@samsung.com
>>
>> The main changes comparing to the first (RFC) version are:
>>   - moving ASV data tables from DT to the driver,
>>   - converting the chipid and the ASV drivers to use regmap,
>>   - converting the ASV driver to proper platform driver.
>>
>> I tried the opp-supported-hw bitmask approach as in the Qualcomm CPUFreq
>> DT bindings but it resulted in too many OPPs and DT nodes, around 200
>> per CPU cluster. So the ASV OPP tables are now in the ASV driver, as in
>> downstream kernels.
> Hmm. Can you explain why do you have so many OPPs? How many
> frequencies do you actually support per cluster and what all varies
> per frequency based on hw ? How many hw version do u have ?

For big cores there are 20 frequencies (2100MHz .. 200MHz). Each SoC 
might belong to one of the 3 production 'sets' and each set contains 14 
so called 'asv groups', which assign the certain voltage values for each 
of those 20 frequencies (the lower asv group means lower voltage needed 
for given frequency).

> I am asking as the OPP core can be improved to support your case if
> possible. But I need to understand the problem first.


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

