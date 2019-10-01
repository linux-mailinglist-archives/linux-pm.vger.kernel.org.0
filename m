Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B922C39E9
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2019 18:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730225AbfJAQGG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Oct 2019 12:06:06 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:48752 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfJAQGG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Oct 2019 12:06:06 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20191001155854euoutp02f390ec49691750cd54cedc6e6b295865~JkSVgNVwM2984629846euoutp02L
        for <linux-pm@vger.kernel.org>; Tue,  1 Oct 2019 15:58:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20191001155854euoutp02f390ec49691750cd54cedc6e6b295865~JkSVgNVwM2984629846euoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569945534;
        bh=+tY23nfPIaunW9U1IaP3j6d4TuDdnM7HmOEYyOXWP3g=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=OtM9p4symgBLi1KY1N1nh1x1l4r1x8cSzzDhp+vSp1eF8P7HSbcs1Cw82ojpcv8iG
         96D6kteudseH3ywexqzKc5WrgD4gScz4kfq91J0MsekDvNz15fnEILE7P18qSDaZL4
         o8DpLRq1RtuxzHZOYNYBGIJlyPVd8b6Sx8zs3oHQ=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191001155854eucas1p2944b3eee19c286b094cbf7a9fe874a90~JkSVIli4p3181931819eucas1p2G;
        Tue,  1 Oct 2019 15:58:54 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 51.01.04374.EB7739D5; Tue,  1
        Oct 2019 16:58:54 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191001155853eucas1p29a83adc9604633929ff91d5952029b3b~JkSUpjbOd1650616506eucas1p2E;
        Tue,  1 Oct 2019 15:58:53 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191001155853eusmtrp1a2fdc05e33cc988493cab501fc305235~JkSUoxdYH2890728907eusmtrp1Y;
        Tue,  1 Oct 2019 15:58:53 +0000 (GMT)
X-AuditID: cbfec7f5-4ddff70000001116-0a-5d9377be4712
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id DE.36.04166.DB7739D5; Tue,  1
        Oct 2019 16:58:53 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191001155853eusmtip1594d61f0672ab10c31fcc0758ec14963~JkST8lJMH0311403114eusmtip1c;
        Tue,  1 Oct 2019 15:58:53 +0000 (GMT)
Subject: Re: [PATCH v2 1/4] dt-bindings: memory-controllers: Add Exynos5422
 DMC interrupts description
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, b.zolnierkie@samsung.com,
        kgene@kernel.org, mark.rutland@arm.com, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        robh+dt@kernel.org, willy.mh.wolff.ml@gmail.com
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <74f31100-7503-e333-fa51-ca218b45bb98@partner.samsung.com>
Date:   Tue, 1 Oct 2019 17:58:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191001131807.GB30129@pi3>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SaUgUYRjHe3d2dsattXE1fdDoWApKUpOKBpJQiFiiD0VBkS266eDRuuqO
        d5dKl6YpKmWb5lmKKeZ6i5msi2tommgq3riKpWvlUVJp5DRGfvu9z/N/jv/DS2LSPtyeDFCH
        MRq1UiUTiYU1rT86nZoi0xUHq3/Z0hWZ5TjdvzSN0zmGTpxOMc1idFfXK4J+F28maJ2pD6d7
        GrJE9GKyAdGZXU0CuswwQtDP+7sF9FBcsYi+89pA0C3mezj9vW0CuVPy0melSF6vHSHkupIE
        kbyy8Jb8YVUJki/qdpwRXRK7+TKqgAhG43LcW+z/2zCKhUxtiZq6PYvFomFxIrIggToMYyn5
        KBGJSSlVjOCrqRHnH0sIWorjCU4lpRYRjDW5JiLyb8XLQgWvKUKQEduI8Zo5BIlGB46tKX8Y
        zKgXcmxD7Yf+1WWcY4zSYvAhx5HrI6Kcoa4klAtLqJMwMvzgr0RI7YH2O9UijrdRF2FhvAXn
        NVbw9smkkCu1WGs5o/fkO9rB4GSOgOedUDuXhXGrARVHwmxOrYg3eQKW58cInq1hxli1ztuh
        PT1JyDMLscl5iOfrYErJXtccgxZjN87Nxdbmlje48GEP0E6NEvxFLGFgzopfwRLSah5jfFgC
        9+9KefU+qEp6L+DZFopKHxGpSKbd4Eu7wYx2gxnt/7m5SFiC7JhwNsiPYQ+pmUhnVhnEhqv9
        nH2Cg3Ro7be1/zZ+q0NNK1f0iCKRbItk4Hy6QoorI9joID0CEpPZSNxW0hRSia8yOobRBHtp
        wlUMq0cOpFBmJ7m2adxTSvkpw5irDBPCaP5lBaSFfSzKftHoPT9fDYN1u2oqKh3HZ3XL4t6O
        szeCYwqqhhVmJ5XvUZXZ3adtUj1IFLR+cT5n0ZZm9H5KTm/tfZJ35GZCaHOP9an8Twt7o30+
        mryH8M9eo3q3wF274yYKmrWplw+gtYvkhipPP7zvXtbj8/ONZ9kFj45pstkcuJq6We4UJROy
        /kpXR0zDKv8AGJr7TmkDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDIsWRmVeSWpSXmKPExsVy+t/xu7p7yyfHGjzcYmCxccZ6VovrX56z
        Wsw/co7Vov/xa2aL8+c3sFucbXrDbrHp8TVWi8u75rBZfO49wmgx4/w+Jou1R+6yWyy9fpHJ
        4nbjCjaL1r1H2C0Ov2lntfh24hGjg4DHmnlrGD12zrrL7rFpVSebx+Yl9R59W1YxenzeJBfA
        FqVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CX8e/I
        PeaCpzwVT1teMzcw3uHqYuTgkBAwkVi9JLaLkYtDSGApo8Tbs7tYuhg5geJiEpP2bWeHsIUl
        /lzrYgOxhQReM0o8nhoCYgsLZEjcmrITrF5EQFPi+t/vrCCDmAVmMUusv9LMAjH1BaPEhI61
        7CDb2AT0JHasKgRp4BVwk7h7p5sVxGYRUJE43boVbIGoQITE4R2zGCFqBCVOznzCAtLKCbTg
        1aFokDCzgJnEvM0PmSFscYlbT+YzQdjyEtvfzmGewCg0C0n3LCQts5C0zELSsoCRZRWjSGpp
        cW56brGhXnFibnFpXrpecn7uJkZgTG879nPzDsZLG4MPMQpwMCrx8DYETY4VYk0sK67MPcQo
        wcGsJMJr82dSrBBvSmJlVWpRfnxRaU5q8SFGU6DfJjJLiSbnA9NNXkm8oamhuYWlobmxubGZ
        hZI4b4fAwRghgfTEktTs1NSC1CKYPiYOTqkGxsS4ihPtt66dYdRgibx/5WXjUb+Uhz3iy2sz
        5C/vulfQGR3WmLM51rNxpYDawcOpib8DvB4cDzHY3a2ywOTm9C8ZN9PV4iam7nya3NX28UPI
        Ei5On9WCMeYPl6lsNmz6/X/BAnPv6VFnY/uLX3bcjp3faXsrfDXfj9Kts/7eTFc0P7bi+LFT
        hkosxRmJhlrMRcWJAHnCvq//AgAA
X-CMS-MailID: 20191001155853eucas1p29a83adc9604633929ff91d5952029b3b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191001125444eucas1p2e4254acf8434e1fadf0e208dbe62b2d7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191001125444eucas1p2e4254acf8434e1fadf0e208dbe62b2d7
References: <20191001125436.24086-1-l.luba@partner.samsung.com>
        <CGME20191001125444eucas1p2e4254acf8434e1fadf0e208dbe62b2d7@eucas1p2.samsung.com>
        <20191001125436.24086-2-l.luba@partner.samsung.com>
        <20191001131807.GB30129@pi3>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 10/1/19 3:18 PM, Krzysztof Kozlowski wrote:
> On Tue, Oct 01, 2019 at 02:54:33PM +0200, Lukasz Luba wrote:
>> Add description for optional interrupt lines. It provides a new operation
>> mode, which uses internal performance counters interrupt when overflow.
>> This is more reliable than using default polling mode implemented in
>> devfreq.
>>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   .../bindings/memory-controllers/exynos5422-dmc.txt     | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt b/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
>> index 02aeb3b5a820..afc38aea6b1c 100644
>> --- a/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
>> +++ b/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
>> @@ -31,6 +31,13 @@ Required properties for DMC device for Exynos5422:
>>   	The register offsets are in the driver code and specyfic for this SoC
>>   	type.
>>   
>> +Optional properties for DMC device for Exynos5422:
>> +- interrupt-parent : The parent interrupt controller.
>> +- interrupts : Contains the IRQ line numbers for the DMC internal performance
>> +  event counters. Align with specification of the interrupt line(s) in the
>> +  interrupt-parent controller.
>> +- interrupt-names : List of IRQ names.
> 
> Since the names are important (not the order) they are part of the
> bindings and they must be listed here.

Good point, thanks. I will add it to the description.

Regards,
Lukasz
