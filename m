Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9B7A101B7
	for <lists+linux-pm@lfdr.de>; Tue, 30 Apr 2019 23:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbfD3VXn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Apr 2019 17:23:43 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:51095 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfD3VXn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Apr 2019 17:23:43 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190430212341euoutp023a6dd6bcae0d0b2374f692f63f271924~aXX8pq8_C1617016170euoutp02k
        for <linux-pm@vger.kernel.org>; Tue, 30 Apr 2019 21:23:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190430212341euoutp023a6dd6bcae0d0b2374f692f63f271924~aXX8pq8_C1617016170euoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1556659421;
        bh=YEHEf386cwBjJCHJeDYVU0n83ZH5g1cs9B5q2hkxT1s=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=AJ3NSYBPz+KEhi6KikXTUB16W7VZNxQIkhG7ZanWHRRNJ8bZP1udyiB1QmOS9DqA7
         G69kK4pA0qpuwBUw3rm+fdJalA/KvmhkFWMkniC/lPZX6t4wXY5R1bHKz1a+rlODVw
         2m3eEcRsJLwx1L7FrVwqbMI/iu4/F40DYv40pPLU=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190430212340eucas1p2e2a54c2f3248cbe17e90f4a8b7f94817~aXX7ceULc2181021810eucas1p2e;
        Tue, 30 Apr 2019 21:23:40 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 58.95.04325.CDCB8CC5; Tue, 30
        Apr 2019 22:23:40 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190430212338eucas1p175060bff36acc3f080375a67c310ce0b~aXX5iXyAW0803108031eucas1p1a;
        Tue, 30 Apr 2019 21:23:38 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190430212338eusmtrp199e46e833df9964e8aede6a64bbf528f~aXX5Sr68a2100921009eusmtrp14;
        Tue, 30 Apr 2019 21:23:38 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-45-5cc8bcdcaa30
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 23.54.04146.ADCB8CC5; Tue, 30
        Apr 2019 22:23:38 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190430212337eusmtip282f66c20f479ac604197b4b114b39dde~aXX4mc_DF0376503765eusmtip2U;
        Tue, 30 Apr 2019 21:23:37 +0000 (GMT)
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
Message-ID: <03805022-f086-c83c-7481-cad9cccfa6f5@partner.samsung.com>
Date:   Tue, 30 Apr 2019 23:23:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <52204c4b-80fa-1a87-2e00-1cfb774478f6@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRTut7u7e5Um12l50jK6VNhDMwq8la2i1/xHBPsjTKipFx/p0l1X
        2sO010o0rbDmctrDcKz5WiZqJqjzMUyXKJqlJSkZpmDOCimltqvkf9/3ne+c8x04JCYZxD3J
        WEUyq1TI42mRs7C6dbbLd7C+Pdy/WC1hKjXlONM/M4YzReYunMkZ+YYxVmsFwXRemSAY00gf
        zvTUFYgYW7YZMRprg4ApNQ8RzLP+bgHzIUMvYq6/NhNM84QaZ362f0b7KZmx0IhktdohQmYy
        3BLJXhRflt2uMiCZzeQdIgpzDoxi42PPsspt0lPOMaXqUSxx3Dsl97kNS0c6j0zkRAK1E4au
        /cIzkTMpofQINLo5IU9mEAw2P0U8sSH4WtaOL7Z8ydUsFEoQdPbWi3gyicAyMCu0u9yoY1D2
        sY+wF9wpC4LsjCHHFsw+yzLc94+QpIjygxpDkr1BTB2BN50lyI6F1AaYG6l3DFpBHYdPrRU4
        73EFS/6oQ3ei9sGdnCKHjlEe8H60SMDjtXD15UPMvguoDBK6CqdEfO5D0J1eJuCxG4y3VRE8
        Xg0d97KEPOYgPfsx4vFFGMnRLXj2QHNbtyMzRm2C8rptvHwAXujnkF0GygXeTbryEVzgbvUD
        jJfFcPOGhHf7QFXW24UAK6HEeJ/IRbR2yWHaJcdolxyj/b/3ERIakAer4hKiWW6Hgj3nx8kT
        OJUi2i/yTIIJ/fu5jvm2HzWo4U9EE6JIRC8X+wS1h0tw+VkuNaEJAYnR7mJZW0u4RBwlTz3P
        Ks+cVKriWa4JeZFC2kN8YdnwCQkVLU9mT7NsIqtcrApIJ890dLQ/yNvXf5dlYj7UfNj/4OcM
        fQMtXdPbn3arx0v1ZEA9ULn1dehgZF9cfrWUGG+MGGv2w3u8P1pV0RvpgFVTMSlp+kZdoLQ6
        mP5uWRdZGGYr8rmUF2L0agzYG9ijaFpvtD449eq34fbutOxxXcvT2hVbgqenC+LUFSbpfa+8
        g0m0kIuRb9+MKTn5Xyjag5dvAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsVy+t/xe7q39pyIMWh8w2exccZ6VovrX56z
        Wsw/co7Vov/xa2aL8+c3sFucbXrDbrHp8TVWi8u75rBZfO49wmgx4/w+Jou1R+6yWyy9fpHJ
        4nbjCjaL1r1H2C0Ov2lntfh24hGjg4DHmnlrGD12zrrL7rFpVSebx+Yl9R59W1YxenzeJBfA
        FqVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CXsbb9
        CXPBK7mKCas/MzcwzhXvYuTkkBAwkXg2YQZjFyMXh5DAUkaJo/M2M0MkxCQm7dvODmELS/y5
        1sUGUfSaUWL+9/+sIAlhgRCJdfeusYMkRAROMkrMnvCXCcRhFvjMKDF9zWVmiJYpTBKTJj4A
        KuPgYBPQk9ixqhCkm1fATeLM2eWMIDaLgKrE38d7WEBsUYEIiTPvV7BA1AhKnJz5BMzmFLCX
        mNg/H2wzs4CZxLzND5khbHGJW0/mM0HY8hLNW2czT2AUmoWkfRaSlllIWmYhaVnAyLKKUSS1
        tDg3PbfYUK84Mbe4NC9dLzk/dxMjMLa3Hfu5eQfjpY3BhxgFOBiVeHgvuJ2IEWJNLCuuzD3E
        KMHBrCTC63H8aIwQb0piZVVqUX58UWlOavEhRlOg5yYyS4km5wPTTl5JvKGpobmFpaG5sbmx
        mYWSOG+HwMEYIYH0xJLU7NTUgtQimD4mDk6pBsaZfBMyl55JOLBzwTwbobKLj14v7T/I57rN
        8sw6aYFD0SdO2k8/Y1ZjpOP2wy5Kzt3YW6lpmRwfq8BbkR4D/mP1Xx0sRW5uFD7CLsOwcGWl
        vr6t+GyPej/nLzWl5e0qFzY7Mdz8Is6dE2DWv8lHo0fsTbXmk3Zl1d/BPH5TtncH7p2/1PWs
        shJLcUaioRZzUXEiAMAF2D0DAwAA
X-CMS-MailID: 20190430212338eucas1p175060bff36acc3f080375a67c310ce0b
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
> I agree. It will be changed in the next version.

Regards,
Lukasz
