Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B78EC8D87
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2019 18:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbfJBQAk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Oct 2019 12:00:40 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:47502 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfJBQAj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Oct 2019 12:00:39 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20191002160037euoutp018d56c1ded9904c6afcd1afc58adccc48~J39HlOI4O2053320533euoutp01Y
        for <linux-pm@vger.kernel.org>; Wed,  2 Oct 2019 16:00:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20191002160037euoutp018d56c1ded9904c6afcd1afc58adccc48~J39HlOI4O2053320533euoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1570032037;
        bh=zx9fXIrViR3O6faysvbaQv1laJb273LTvU1SgoNFeRw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=DPIGAGVE8pUlz2ohMPT4Z5LGxM/5vhQBydO5nEhLT3m1h+gy92ax0lgw4BJXRyItR
         tRm17N9euUDnBt2+BH4fAc3JIEiw/jvoxUJ6WSq+UEbYLIHe7MU9wapxDitDLS5c9/
         /2uL03MtJ8eyMbzHvpm16KTy5QP85d9q5JSY7gi8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191002160037eucas1p27ecf61c7742b27e92e255a9de3aecdc2~J39HLX6Nt2151621516eucas1p2e;
        Wed,  2 Oct 2019 16:00:37 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id D3.A2.04309.5A9C49D5; Wed,  2
        Oct 2019 17:00:37 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191002160036eucas1p12ca78e31017e81bf60064e36805a6913~J39G3SfBV1008210082eucas1p1f;
        Wed,  2 Oct 2019 16:00:36 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191002160036eusmtrp2781afda37055fb51b9038865d8864bad~J39G2nkAV0849408494eusmtrp2I;
        Wed,  2 Oct 2019 16:00:36 +0000 (GMT)
X-AuditID: cbfec7f4-afbff700000010d5-a9-5d94c9a5da81
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 28.A5.04166.4A9C49D5; Wed,  2
        Oct 2019 17:00:36 +0100 (BST)
Received: from [106.120.51.75] (unknown [106.120.51.75]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191002160036eusmtip2b36600fc018770f30e4b31f2ccc5417f~J39GNPMwD1368513685eusmtip20;
        Wed,  2 Oct 2019 16:00:36 +0000 (GMT)
Subject: Re: [PATCH v4 2/6] dt-bindings: samsung: Update the CHIP ID binding
 documentation
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh@kernel.org>
Cc:     vireshk@kernel.org, robh+dt@kernel.org, kgene@kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-ID: <272b82b6-b77f-5cdd-5f39-68e529574f66@samsung.com>
Date:   Wed, 2 Oct 2019 18:00:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191002154819.GA4072@kozik-lap>
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTYRTHe3bv3a7LyePUPFkWDT9U5it9uJRJkdY+SC9+ikr0mtcXmlM2
        tawPajIx3UxNcy1DbYUvKZaamU2jOR1maS40IypLITImlAZK4XK7Rn77nXP+5znnf3hoQtpP
        +dFpyixOpWQVMqGY7B5aHg26N1wVFzpRIWYe6tspps4ySjHXZr4TzNjYAxHTMTNJMW96a4XM
        gs6CGP1Yv4Bps3wQMZo+i4hxmHpETOf0kPCgu7yj5apQ3nk3T17W1YLkCx3bTpCnxRFJnCIt
        h1OFRCaIU1utNcLMSsFFXXk/mY8mUQlyowHvhd4hq6gEiWkpbkLw41YRyQeLCAZvNBF8sIBA
        o3u9WqFdLeMVvs5uKW5EUGTexGvsCBqnvgmdBS98Fvq+1lFO9sZyeFn/zvUQgasFsGycd4mE
        OAx0g2WuPSQ4Ep7fqXUxiQPAoTe5ND74FPycHqB4jScM35wlneyGg0F3+76LCewLVxabKZ63
        w2N7rWsYYJsItKUmgjcaBfq5pTX2gjlrl4jnreB4UifgGwoRaJ++F/FBOYJP1vq1M+2HAes4
        5fRP4F3Q3hvCpw+BrXVayJ/FA6bsnvwSHlDZXUPwaQkUF0l5dQD8bqkR8OwHpbMOshzJDOus
        GdbZMayzY/g/tx6RLciXy1anp3DqcCV3IVjNpquzlSnB5zLSO9DqrxpZsS72oN4/iWaEaSRz
        l+THXo+TUmyOOjfdjIAmZN4SW3tVnFSSxOZe4lQZ8apsBac2oy00KfOVXN4wfUaKU9gs7jzH
        ZXKqf1UB7eaXjyA0WRFkigqmbSPinMpHmiWP5LeFbdH0vpDNG2MGfNCzGJ8vR+aidxaMh8cv
        jUZUT/qPJEi8RmIt846ogrzuQONJAQ5LZIeAC1jpURi0xxsOG4+r5mwVR2s+2yb8NZGakEQB
        G/hCY9Qe+KgvKo0KHJA177EHHCv+ZV5peLVDRqpT2bDdhErN/gWzXGHnUQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsVy+t/xe7pLTk6JNTj4WN9i44z1rBbzj5xj
        teh//JrZ4vz5DewWmx5fY7W4vGsOm8Xn3iOMFjPO72OyWHvkLrtF694j7Bb/9+xgt9j84Bib
        A4/HplWdbB6bl9R79G1ZxejxeZNcAEuUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5
        rJWRqZK+nU1Kak5mWWqRvl2CXsaa49PZCiYxVfRO2MfSwHiNsYuRg0NCwETi4kTxLkYuDiGB
        pYwS/+7dZoKIS0nMb1HqYuQEMoUl/lzrYoOoec0osf/7WxaQhLBAjMTe5/NZQWwRAQ+JMwtu
        MoMUMQtMZZI4fHgHM0RHE5NEf/ceNpAqNgFDid6jfYwgNq+AncTBRXPAbBYBFYn/MyBqRAUi
        JA7vmAVVIyhxcuYTsG2cAnoSvXNXg9nMAuoSf+ZdYoawxSWavqxkhbDlJba/ncM8gVFoFpL2
        WUhaZiFpmYWkZQEjyypGkdTS4tz03GJDveLE3OLSvHS95PzcTYzA2Nx27OfmHYyXNgYfYhTg
        YFTi4W0ImhwrxJpYVlyZe4hRgoNZSYT30vopsUK8KYmVValF+fFFpTmpxYcYTYGem8gsJZqc
        D0wbeSXxhqaG5haWhubG5sZmFkrivB0CB2OEBNITS1KzU1MLUotg+pg4OKUaGCtM/OcYX785
        9Y77U6ctqUqsepvv/o2ef603fl740eO3l/OpzK4L5Xrqsu1CU0udV4Lfyk3K3tpvmFPO73/9
        4np9VLOi6QvuP/s9Zd2EpB94K1xZ1ib9dOk7kbAk9ddNweJXp806Glh7JCRk5seXnmLJevam
        tzvfRDzy3aiy4XOB57Su0x/UHyixFGckGmoxFxUnAgA9eiEl4wIAAA==
X-CMS-MailID: 20191002160036eucas1p12ca78e31017e81bf60064e36805a6913
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190910123637eucas1p26d2051f9bdd1bdf4510f1908ea98f641
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190910123637eucas1p26d2051f9bdd1bdf4510f1908ea98f641
References: <20190910123618.27985-1-s.nawrocki@samsung.com>
        <CGME20190910123637eucas1p26d2051f9bdd1bdf4510f1908ea98f641@eucas1p2.samsung.com>
        <20190910123618.27985-3-s.nawrocki@samsung.com> <20190917181322.GA683@bogus>
        <20191002154819.GA4072@kozik-lap>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/2/19 17:48, Krzysztof Kozlowski wrote:
> This will create conflicts with conversion to dt-schema (already picked
> up by Rob).
> 
> Can you convert this patch to dt-schema format and send it for Rob?

Sure, I will convert the patch.

-- 
Regards,
Sylwester
