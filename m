Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E804A116EF
	for <lists+linux-pm@lfdr.de>; Thu,  2 May 2019 12:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbfEBKLd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 May 2019 06:11:33 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:50240 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfEBKLd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 May 2019 06:11:33 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190502101132euoutp01a93cfbbea9878af7e2955577da754205~a1fpEPwxs0909609096euoutp01f
        for <linux-pm@vger.kernel.org>; Thu,  2 May 2019 10:11:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190502101132euoutp01a93cfbbea9878af7e2955577da754205~a1fpEPwxs0909609096euoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1556791892;
        bh=nD4m6soRZa3s4ZYQlTYB5Pn9lG7QaoUuCQMHFmpymzo=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Cevn6rP9/mJuIgNPVx9wG4FzrXmbKKvyUZ5US/3j1yCeUw8+CAQasDzEy0QVvA2Sz
         cmYf2IeNh9UFIfD8WHHAUoZQl+/WzucarqWlVKUMqjUwSNoSQgwGkGkv8/uGa8YmT1
         lSbuL4JWpZ5d6OcJbkJMggXBbF7YzCOWRGkD/vcM=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190502101131eucas1p1c5ef883683f2243bc9bf468aa2270028~a1fofiZjK2547825478eucas1p1j;
        Thu,  2 May 2019 10:11:31 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id F2.15.04325.352CACC5; Thu,  2
        May 2019 11:11:31 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190502101130eucas1p191ded6ecb65d1003a4e654e10c59f4cf~a1fnxc83h1832818328eucas1p1W;
        Thu,  2 May 2019 10:11:30 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190502101130eusmtrp19b64bdc6824036a11b4e23c12ccd6be0~a1fnjMJgi2885928859eusmtrp1V;
        Thu,  2 May 2019 10:11:30 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-e2-5ccac25360b9
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 2C.E7.04146.252CACC5; Thu,  2
        May 2019 11:11:30 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190502101129eusmtip2b14c307027f983220512632f49223aa2~a1fmrWS8b3017030170eusmtip2j;
        Thu,  2 May 2019 10:11:29 +0000 (GMT)
Subject: Re: [PATCH v3 3/4] Documentation: devicetree: add PPMU events
 description
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
Message-ID: <869966ae-6349-a1db-59cf-eba7c0c23aee@partner.samsung.com>
Date:   Thu, 2 May 2019 12:11:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <52204c4b-80fa-1a87-2e00-1cfb774478f6@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUhTYRj13d3d7oaT16XtoSJp9KMktSjqSpIJkTP8IRQRJeXMi0nObFct
        y2pWZo7ZZqHZtKzIlDE/0mkmJWTzY31NDZ34TRpFuSjWQqMkrzfJf+ec5zzvcw68FCEfIldQ
        KWkZjDZNnaoUSYXNnbPOkL3tL+M3Npkk9KPSOpJ2/fhI0hX2tyRtnPxC0E5nvZh+c3FaTDdM
        DpD0u9ZyEe0ptCO61NkmoGvso2K60tUroIdzq0V03jO7mH4xnU/SP7vfo51YZb1jRaon5lGx
        qsFSIFI1PrigumazIJWnYXWc6KA0IolJTclitGE7EqTHBjv/oPTmoNPdJb1CHXIp9EhCAd4C
        hpYZpEdSSo6rEZjz80U8+YHA0G8QcC459iD41qtZ3JgrHhfwpioETx53iHniRtDq7kCcaxne
        B7VjAwuDAOxAUJg7SnKE4J5yTAzME4oS4VBosZzkFmR4N3i89xdkIV4LZY0xnByID8B4Zz3J
        W/zBcWtKyGEJjoQiY8WCTmAFDE1VCHgcBJeaygjuFOBcCgw9JgEfexd4rZcJHi+Dz102MY9X
        wasbBiGPWdAV3kM8zoFJ4+1/nu3woqt3IRuB10NdaxgvR0Fj9R/EyYD9YNDtz0fwg+vNNwle
        lsHVK3LevQ5shp5/YZZDlbVEbEJK85Ji5iVlzEvKmP/fvYuEFqRgMllNMsNuTmNOhbJqDZuZ
        lhx69ISmAc3/uFdzXd4W1PY7sR1hCil9ZTPFjng5qc5iszXtCChCGSAbejovyZLU2WcY7Ykj
        2sxUhm1HKymhUiE76zNxSI6T1RnMcYZJZ7SLUwElWaFDQf3hv12rpofDo9fFP9WdGzMOeUcS
        0NinyBClPra8wPd5X0fMhF/s98TZyoI1MzF52sBt0btXR6l9y6Z2ntdsrprbWOupqA7fv7Vo
        JuJX1NcRhds4/vD8lOt15OGQvpJgmWDMV5IxanPdX6vPqYlr2uBjJ9K9xXnOWbTH9NL2oUAp
        ZI+pNwUTWlb9F3lKSSNtAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPIsWRmVeSWpSXmKPExsVy+t/xe7pBh07FGEx5JmmxccZ6VovrX56z
        Wsw/co7Vov/xa2aL8+c3sFucbXrDbrHp8TVWi8u75rBZfO49wmgx4/w+Jou1R+6yWyy9fpHJ
        4nbjCjaL1r1H2C0Ov2lntfh24hGjg4DHmnlrGD12zrrL7rFpVSebx+Yl9R59W1YxenzeJBfA
        FqVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CXcePY
        X8aCbfIVJ6ZdZGlgvC7excjJISFgIvFv6n2mLkYuDiGBpYwS7bd2MUEkxCQm7dvODmELS/y5
        1sUGUfSaUWLx/dVsIAlhgRCJdfeusYMkRAROMkrMnvAXbBSzwGdGielrLjNDtExhkpg08QFQ
        GQcHm4CexI5VhSDdvAJuEp+/LmIFCbMIqEjM3uwJEhYViJA4834FC0SJoMTJmU/AbE4Be4mJ
        /fNZQWxmATOJeZsfMkPY4hK3nsxngrDlJZq3zmaewCg0C0n7LCQts5C0zELSsoCRZRWjSGpp
        cW56brGhXnFibnFpXrpecn7uJkZgZG879nPzDsZLG4MPMQpwMCrx8P6YejJGiDWxrLgy9xCj
        BAezkgjvrT1AId6UxMqq1KL8+KLSnNTiQ4ymQL9NZJYSTc4HJp28knhDU0NzC0tDc2NzYzML
        JXHeDoGDMUIC6YklqdmpqQWpRTB9TBycUg2Mfmnm0c8u7Fz2aFXqzhtfsjMWnopwam0s+PYh
        yTnxzAJDo41nDT9zvZ96avvkHzNPshbJRU9OFOBxWv+vb5qemdTyV6+FrWIkDr+2ypL9llxZ
        qLODV65QavKhVyr/9zwJkl6UY2z30n2zhYJQ7+fJilcf3lt5JJaJxSMy8LD0qXxuh4JHgRxJ
        SizFGYmGWsxFxYkAjrkHKwIDAAA=
X-CMS-MailID: 20190502101130eucas1p191ded6ecb65d1003a4e654e10c59f4cf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190419134822eucas1p29c6eff0f500311749b33c4f556123cf0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190419134822eucas1p29c6eff0f500311749b33c4f556123cf0
References: <1555681688-19643-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190419134822eucas1p29c6eff0f500311749b33c4f556123cf0@eucas1p2.samsung.com>
        <1555681688-19643-4-git-send-email-l.luba@partner.samsung.com>
        <52204c4b-80fa-1a87-2e00-1cfb774478f6@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Chanwoo,

On 4/30/19 8:16 AM, Chanwoo Choi wrote:
> Hi Lukasz,
> 
> On 19. 4. 19. 오후 10:48, Lukasz Luba wrote:
>> Extend the documenation by events description with new 'event-data-type'
>> field. Add example how the event might be defined in DT.
>>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   .../devicetree/bindings/devfreq/event/exynos-ppmu.txt  | 18 ++++++++++++++++++
>>   1 file changed, 18 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt b/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
>> index 3e36c1d..47feb5f 100644
>> --- a/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
>> +++ b/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
>> @@ -145,3 +145,21 @@ Example3 : PPMUv2 nodes in exynos5433.dtsi are listed below.
>>   			reg = <0x104d0000 0x2000>;
>>   			status = "disabled";
>>   		};
>> +
>> +The 'event' type specified in the PPMU node defines 'event-name'
>> +which also contains 'id' number and optionally 'event-data-type'.
>> +
>> +Example:
>> +
>> +		events {
>> +			ppmu_leftbus_0: ppmu-event0-leftbus {
>> +				event-name = "ppmu-event0-leftbus";
>> +				event-data-type = <PPMU_RO_DATA_CNT>;
>> +			};
>> +		};
>> +
>> +The 'event-data-type' defines the type of data which shell be counted
>> +by the counter. You can check include/dt-bindings/pmu/exynos_ppmu.h for
>> +all possible type, i.e. count read requests, count write data in bytes,
>> +etc. This field is optional and when it is missing, the driver code will
>> +use default data type.
>>
> 
> How about editing it as following?
> 
> --- a/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
> +++ b/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
> @@ -10,14 +10,23 @@ The Exynos PPMU driver uses the devfreq-event class to provide event data
>   to various devfreq devices. The devfreq devices would use the event data when
>   derterming the current state of each IP.
>   
> -Required properties:
> +Required properties for PPMU device:
>   - compatible: Should be "samsung,exynos-ppmu" or "samsung,exynos-ppmu-v2.
>   - reg: physical base address of each PPMU and length of memory mapped region.
>   
> -Optional properties:
> +Optional properties for PPMU device:
>   - clock-names : the name of clock used by the PPMU, "ppmu"
>   - clocks : phandles for clock specified in "clock-names" property
>   
> +Required properties for 'events' child node of PPMU device:
> +- event-name : the unique event name among PPMU device
> +Optional properties for 'events' child node of PPMU device:
> +- event-data-type : Define the type of data which shell be counted
> +by the counter. You can check include/dt-bindings/pmu/exynos_ppmu.h for
> +all possible type, i.e. count read requests, count write data in bytes,
> +etc. This field is optional and when it is missing, the driver code
> +will use default data type.
> +
>   Example1 : PPMUv1 nodes in exynos3250.dtsi are listed below.
>   
>                  ppmu_dmc0: ppmu_dmc0@106a0000 {
> @@ -145,3 +154,16 @@ Example3 : PPMUv2 nodes in exynos5433.dtsi are listed below.
>                          reg = <0x104d0000 0x2000>;
>                          status = "disabled";
>                  };
> +
> +Example4 : 'event-data-type' in exynos4412-ppmu-common.dtsi are listed below.
> +
> +       &ppmu_dmc0 {
> +               status = "okay";
> +               events {
> +                       ppmu_dmc0_3: ppmu-event3-dmc0 {
> +                               event-name = "ppmu-event3-dmc0";
> +                               event-data-type = <(PPMU_RO_DATA_CNT |
> +                                               PPMU_WO_DATA_CNT)>;
> +                       };
> +               };
> +       };
> 
> 
I will also add your Signed-off-by to this patch, similar to what we
have agreed for patch 'PATCH v3 2/4'.

Regards,
Lukasz
