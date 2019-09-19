Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53D52B7368
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2019 08:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387758AbfISGtO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Sep 2019 02:49:14 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:42496 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388208AbfISGtN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Sep 2019 02:49:13 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190919064911euoutp01c96475b368fe11329da4453d6cc9b8c9~FxC8NnlVM3118231182euoutp01g
        for <linux-pm@vger.kernel.org>; Thu, 19 Sep 2019 06:49:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190919064911euoutp01c96475b368fe11329da4453d6cc9b8c9~FxC8NnlVM3118231182euoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1568875751;
        bh=p7qbrmP5w9u16xdsgKqpm4yWd7pNksehgriKSn5DTq0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Il5L/GaddKTrNT403tAY0NHMzilpvdBoZlBOF3X5UXNMFdBMIktCZvYpKr/qBfb7L
         v76RqXyLfpPOCFN531Ap+5FA5allt0HjsgG76ACO2DY1q/h6UbAxXqrYMxIj91ipgb
         b/Yq67SjhIqMjKLYn2PF+c52VBdtKAk3DYiB8AhE=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190919064910eucas1p1f5d583718810e243d7a5d531253e04ea~FxC7XnmQd2575425754eucas1p1K;
        Thu, 19 Sep 2019 06:49:10 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 62.95.04309.6E4238D5; Thu, 19
        Sep 2019 07:49:10 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190919064909eucas1p1ba3cd25428c7b0162de535cf3f038cc6~FxC6jS9eX2169821698eucas1p1m;
        Thu, 19 Sep 2019 06:49:09 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190919064909eusmtrp15d2cf82b862c88a7e834d47d06e671a3~FxC6Sc9VV1215012150eusmtrp1t;
        Thu, 19 Sep 2019 06:49:09 +0000 (GMT)
X-AuditID: cbfec7f4-ae1ff700000010d5-69-5d8324e6ff34
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 11.94.04117.5E4238D5; Thu, 19
        Sep 2019 07:49:09 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190919064908eusmtip27eebb3e295389c59a871b84f5b28a15b~FxC5pTwOV1178711787eusmtip25;
        Thu, 19 Sep 2019 06:49:08 +0000 (GMT)
Subject: Re: [PATCH v2 3/3] dt-bindings: ddr: Add bindings for Samsung
 LPDDR3 memories
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?Q?Bart=c5=82omiej_=c5=bbo=c5=82nierkiewicz?= 
        <b.zolnierkie@samsung.com>, kgene@kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
        kyungmin.park@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        willy.mh.wolff.ml@gmail.com
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <4a0d1d2c-cd1d-5df4-d4b1-f2dd1ef3bb72@partner.samsung.com>
Date:   Thu, 19 Sep 2019 08:49:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAJKOXPcxG-mMKy5u-b0+xj_sOmrq5yq5-LYJx0Ds6_+yo_=JbA@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRTH++3eu3sVZ9dpetCoGFrZQ3tzoRJ7EIOIEioiEZvuoqLTtesj
        s2gZPvERaaXDR1Iy05m2hppghK5UJJ1WmoqoaWqlUD5WllabV8n/Pud7vud3zhd+FCbuJVyp
        sMhoVhUpi5AIbfGa1/PtO8fcbwXsqk1zZJ7mVRFMz+w4wRQb2wkme+QrxnR0VJPMm8RJktGP
        dBPM2/oCITOTaURMXscLAVNpHCCZ0p5OAdN/s0zIJDUYSaZpMoVgzC0fkS8t1RXpkPS5ZoCU
        6svThNJnj25IswzlSDqj33BGeNH2kJyNCItlVd4+l2xDzWneyi7HK98m7mJq9IRORzYU0Pvg
        c9YkkY5sKTFdhiApo1XAF7MI0pIHML6YQfCyqES4MtI/XojzDS0C7WgOyRdTCEyz6iWXI30B
        1GW5Ais70Z7Qs/hjaQlGN+KQVz9vaVCUkPaCuvLLVo+IPgHdOj2yMk57QPW8mbTyOss700NN
        BO9xgNb8Udw6akP7gX5BbpUx2gX6RosFPG+E2qmCpauBXiShp6GX4K8+Du8NpuUEjvCl2UDy
        vB7acjJwnjlQZ5Ygnq/BSHbhsucgNDV3Eta9mCVLVb03Lx+BBpNhSQbaHj5MOfAn2MOdmvsY
        L4sgNVnMu7eCIcMk4NkZtLp75G0k0azKpVkVRrMqjOb/3gcIL0cubAynCGG5PZFsnBcnU3Ax
        kSFewVEKPbJ8uLY/zbN1qH4hqBHRFJLYiX5uSQwQE7JYLl7RiIDCJE6igv0WSSSXxV9lVVGB
        qpgIlmtEbhQucRElrBnyF9Mhsmg2nGWVrGqlK6BsXNXosCHDvSrRLzg0t8TU9Thh80TmK7f8
        qtiG1j5lqNmttiJwTuc1fN50wG7wXfDJioLqhECjThc3omjO9qzUKgPdTgu2fxLFqpS+1b/s
        hAptJkpp75/+fs4jNXyTv2/Qwx3Oypa1g0cXfI+dmgv+7WMeK44olV/f6x+UVeYwXHj2b4wE
        50Jlu7dhKk72D8690llsAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRmVeSWpSXmKPExsVy+t/xe7pPVZpjDTY1ylhsnLGe1eL6l+es
        FvOPnGO16H/8mtni/PkN7BZnm96wW2x6fI3V4vKuOWwWn3uPMFrMOL+PyWLtkbvsFkuvX2Sy
        uN24gs2ide8RdovDb9pZLb6deMToIOCxZt4aRo+ds+6ye2xa1cnmsXlJvUffllWMHp83yQWw
        RenZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJalFunbJehlfOvU
        L7gkXPHhxVTmBsZ1Al2MnBwSAiYSt5/PZeli5OIQEljKKDH75m42iISYxKR929khbGGJP9e6
        2CCKXjNKnFs9BaxIWCBCoufYdFYQW0RAU+L63++sIEXMAodYJD5tPc4I0TGBSeL03llAozg4
        2AT0JHasKgRp4BVwk7i2ZhMjiM0ioCqx4ec3sG2iQEMP75jFCFEjKHFy5hMWkFZOgUCJTX9S
        QMLMAmYS8zY/ZIawxSVuPZnPBGHLS2x/O4d5AqPQLCTds5C0zELSMgtJywJGllWMIqmlxbnp
        ucVGesWJucWleel6yfm5mxiBUb3t2M8tOxi73gUfYhTgYFTi4f2h3hQrxJpYVlyZe4hRgoNZ
        SYR3jilQiDclsbIqtSg/vqg0J7X4EKMp0G8TmaVEk/OBCSevJN7Q1NDcwtLQ3Njc2MxCSZy3
        Q+BgjJBAemJJanZqakFqEUwfEwenVAOjw3veWSEGC69u2jAtxJxn6TKHRWeeR3U8tvd2exSU
        5ZilvMSgPSh6kvMG+7gnNe91S/5Ozdn+U/Xl91nl+5iFc5fLPNhfX81ZHihzvledN5R5EjMv
        74x4NrOD2h8+rbtz/0apNLvquWe86xIfBt1f+3ve09APt+9Pc9h3Vu68+LF/5f/50yYZKLEU
        ZyQaajEXFScCAHgiRS8AAwAA
X-CMS-MailID: 20190919064909eucas1p1ba3cd25428c7b0162de535cf3f038cc6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190916100719eucas1p206fe95982b774840b5d6e62ba9c42c79
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190916100719eucas1p206fe95982b774840b5d6e62ba9c42c79
References: <CGME20190916100719eucas1p206fe95982b774840b5d6e62ba9c42c79@eucas1p2.samsung.com>
        <20190916100704.26692-1-l.luba@partner.samsung.com>
        <20190916100704.26692-4-l.luba@partner.samsung.com>
        <CAJKOXPcxG-mMKy5u-b0+xj_sOmrq5yq5-LYJx0Ds6_+yo_=JbA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Krzysztof,

On 9/18/19 8:51 PM, Krzysztof Kozlowski wrote:
> On Mon, 16 Sep 2019 at 12:07, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>>
>> Add compatible for Samsung k3qf2f20db LPDDR3 memory bindings.
>> Introduce minor fixes in the old documentation.
>>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   Documentation/devicetree/bindings/ddr/lpddr3.txt | 9 ++++++---
>>   1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/ddr/lpddr3.txt b/Documentation/devicetree/bindings/ddr/lpddr3.txt
>> index 3b2485b84b3f..49afe794daaa 100644
>> --- a/Documentation/devicetree/bindings/ddr/lpddr3.txt
>> +++ b/Documentation/devicetree/bindings/ddr/lpddr3.txt
>> @@ -1,7 +1,9 @@
>>   * LPDDR3 SDRAM memories compliant to JEDEC JESD209-3C
>>
>>   Required properties:
>> -- compatible : Should be  - "jedec,lpddr3"
>> +- compatible : should be one of the following:
>> +       Generic default - "jedec,lpddr3".
> 
> The convention is first compatible, then description. I gave you the
> example to base on - at25. Why making it different?

I have checked at25 that you pointed me to and also checked at24, which
has a bit longer "compatible" section.

I found that there are many "jedec,spi-nor" compatible devices, which I
thought would be a better example for my "jedec,lpddr3".
For example, two configurations, where you have a single labels or dual
(with specific device)
arch/arm/boot/dts/imx6dl-rex-basic.dts:
compatible = "sst,sst25vf016b", "jedec,spi-nor";
arch/arm/boot/dts/imx6q-ba16.dtsi:
compatible = "jedec,spi-nor";

The 'compatible' in documentation for the "jedec,spi-nor" is slightly
different (similar to at24).
Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt
It has a long explanation, which is also OK. So I thought that it is
quite flexible what you put in there.

I have also checked Cadance QSPI controller.
Documentation/devicetree/bindings/mtd/cadence-quadspi.txt
The controller might be built-in into different vendor SoC's
and the "compatible" is ready to reflect it in similar fashion but
with a short explanation in this section.

Therefore, what you see in the patch draw heavily on Cadence's qspi,
with a bit of inspiration from jedec,spi-nor usage.

Should I change it to at25 "compatible" style and send next patch?

PS. Thank you for taking the other two patches. I will not respond in
their threads to keep the traffic low.

Regards,
Lukasz
