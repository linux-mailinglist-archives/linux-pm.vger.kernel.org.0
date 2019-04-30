Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC63F052
	for <lists+linux-pm@lfdr.de>; Tue, 30 Apr 2019 08:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725554AbfD3GJk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Apr 2019 02:09:40 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:40969 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbfD3GJk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Apr 2019 02:09:40 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190430060937epoutp0369cd6c8a30518d64d3861537dc730bb5~aK523IIvy0339003390epoutp03e
        for <linux-pm@vger.kernel.org>; Tue, 30 Apr 2019 06:09:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190430060937epoutp0369cd6c8a30518d64d3861537dc730bb5~aK523IIvy0339003390epoutp03e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1556604577;
        bh=s4+gCxQmp9Ft0gltHb67tjlRyzWs9lclWGMzsc5X/xI=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=fTRsK6w/rsRH4dp7XOUr/fw3skEk6HJ68mF8kKAsy4QLGjFcSr8sTdIJLvYMqwqZ4
         iHNWwcJThl1NYKKIBRnx9lfHFpd/yiRPkclKU7vvUo24s4JBUef1eocujvu8GOQEOO
         58lZB0clT7ZIOwsxxFSkF2Z/SEXEbG859K7w4ecc=
Received: from epsmges1p1.samsung.com (unknown [182.195.40.155]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190430060931epcas1p39482c1bb63551d588b515f8ca887a9c3~aK5w8xPcP0921309213epcas1p3e;
        Tue, 30 Apr 2019 06:09:31 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        F4.EC.04139.B96E7CC5; Tue, 30 Apr 2019 15:09:31 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190430060930epcas1p4858f6f12ec5e7a0221b76178ebdc4edc~aK5wYkdYN0046400464epcas1p4i;
        Tue, 30 Apr 2019 06:09:30 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190430060930epsmtrp1f49f5db76537f4890e80f9cf41e2c4c1~aK5wXrW9I0761107611epsmtrp1_;
        Tue, 30 Apr 2019 06:09:30 +0000 (GMT)
X-AuditID: b6c32a35-deaec9c00000102b-58-5cc7e69b1984
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5E.D2.03662.A96E7CC5; Tue, 30 Apr 2019 15:09:30 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190430060930epsmtip1e427ea154bc532509ae59b8844ec8028~aK5wCKkYq2006320063epsmtip1V;
        Tue, 30 Apr 2019 06:09:30 +0000 (GMT)
Subject: Re: [PATCH v3 4/4] DT: arm: exynos4412: add event data type which
 is monitored
To:     Lukasz Luba <l.luba@partner.samsung.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, kgene@kernel.org,
        willy.mh.wolff.ml@gmail.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <cee7b5a2-377e-59d6-7c6e-b6f9b3140d4f@samsung.com>
Date:   Tue, 30 Apr 2019 15:10:45 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1555681688-19643-5-git-send-email-l.luba@partner.samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLJsWRmVeSWpSXmKPExsWy7bCmru7sZ8djDLat57LYOGM9q8X8I+dY
        Lfofv2a2OH9+A7vF2aY37Ba3GmQsNj2+xmpxedccNovPvUcYLWac38dksfbIXXaLpdcvMlnc
        blzBZtG69wi7xeE37awW3048YnQQ8Fgzbw2jx85Zd9k9Nq3qZPPYvKTe4+C7PUwefVtWMXp8
        3iQXwB6VbZORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkD
        dLuSQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8CyQK84Mbe4NC9dLzk/18rQwMDI
        FKgwITtjZ3snW8Eu/op9ex6zNzD+4epi5OSQEDCROLP+AXMXIxeHkMAORokZO6+wQDifGCVO
        TZ7PDuF8Y5TYcP8kM0zL93vzoar2MkrcmHcfqv89o8THZXPAqoQFIiV63vQwgiREBM4ySjxo
        2sYG4jALfGaUOPngGitIFZuAlsT+FzfYQGx+AUWJqz8eM4LYvAJ2EivbbjCB2CwCqhIvdv4G
        qxcViJC4f2wDK0SNoMTJmU9YQGxOAW+Jt5dngtUzC4hL3HoyH8qWl2jeOhvsPAmBY+wSTQtn
        MUI84SKxcfIFKFtY4tXxLewQtpTEy/42KLtaYuXJI2wQzR2MElv2X2CFSBhL7F86GWgDB9AG
        TYn1u/QhlvFJvPvawwoSlhDglehoE4KoVpa4/OAuE4QtKbEYGA0QtofE3Kmv2CYwKs5C8s4s
        JC/MQvLCLIRlCxhZVjGKpRYU56anFhsWGCJH+CZGcNLWMt3BOOWczyFGAQ5GJR5ej3fHYoRY
        E8uKK3MPMUpwMCuJ8HocPxojxJuSWFmVWpQfX1Sak1p8iNEUGNoTmaVEk/OBGSWvJN7Q1MjY
        2NjCxNDM1NBQSZx3vYNzjJBAemJJanZqakFqEUwfEwenVANjRetkxpzbC2Q+HChc9mevsKe+
        vbKW0VqVRra7HGnhe+T1PjG2bJZzDjx/9D7btSdzFLR1M/Nta1crL1l8IJLlr9rbTsVnljeX
        fsyefun87G9vFM1VHcsW+NYGCcQ3/jsynW8ve4XFtlNlGjaqzz7tXTC1bMnCnYeVGVf0r2Ds
        cVnFVli3NUpdiaU4I9FQi7moOBEAc4p47/ADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsWy7bCSnO6sZ8djDN6+UrDYOGM9q8X8I+dY
        Lfofv2a2OH9+A7vF2aY37Ba3GmQsNj2+xmpxedccNovPvUcYLWac38dksfbIXXaLpdcvMlnc
        blzBZtG69wi7xeE37awW3048YnQQ8Fgzbw2jx85Zd9k9Nq3qZPPYvKTe4+C7PUwefVtWMXp8
        3iQXwB7FZZOSmpNZllqkb5fAlbGzvZOtYBd/xb49j9kbGP9wdTFyckgImEh8vzefpYuRi0NI
        YDejxMPVB1kgEpIS0y4eZe5i5ACyhSUOHy6GqHnLKDHl5VdGkLiwQKTEwb4CkLiIwFlGiUWT
        FrCDOMwCnxklpq+5zAwySEjgPqPE3Zn6IDabgJbE/hc32EBsfgFFias/HjOC2LwCdhIr224w
        gdgsAqoSL3b+ZgWxRQUiJM68X8ECUSMocXLmEzCbU8Bb4u3lmWD1zALqEn/mXWKGsMUlbj2Z
        DxWXl2jeOpt5AqPwLCTts5C0zELSMgtJywJGllWMkqkFxbnpucWGBUZ5qeV6xYm5xaV56XrJ
        +bmbGMGRq6W1g/HEifhDjAIcjEo8vB7vjsUIsSaWFVfmHmKU4GBWEuH1OH40Rog3JbGyKrUo
        P76oNCe1+BCjNAeLkjivfP6xSCGB9MSS1OzU1ILUIpgsEwenVAOjSu1J7q/LZ3Q/FHT0jT71
        deXz39KPuxjqFswJfSYgkxTJ/EhUi3Xx0s889cumpPtm71co2mB7u2tlDq/0rjcf5lclfhXl
        s58hVKnAz8g5W/7Wk79BnM6GRnwFk7iDWjndHec99Dv5K9t+24If20piNyReSzt+dPXM1w9K
        pf7FzjML21LrJLdXiaU4I9FQi7moOBEAJ1cgT9gCAAA=
X-CMS-MailID: 20190430060930epcas1p4858f6f12ec5e7a0221b76178ebdc4edc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190419134823eucas1p1ff852194b1db655ed2dbce72b5f7f3a6
References: <1555681688-19643-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190419134823eucas1p1ff852194b1db655ed2dbce72b5f7f3a6@eucas1p1.samsung.com>
        <1555681688-19643-5-git-send-email-l.luba@partner.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 19. 4. 19. 오후 10:48, Lukasz Luba wrote:
> The patch adds new field in the PPMU event which shows explicitly
> what kind of data the event is monitoring. It is possible to change it
> using defined values in exynos_ppmu.h file.
> 
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  arch/arm/boot/dts/exynos4412-ppmu-common.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos4412-ppmu-common.dtsi b/arch/arm/boot/dts/exynos4412-ppmu-common.dtsi
> index 3a3b2fa..549faba 100644
> --- a/arch/arm/boot/dts/exynos4412-ppmu-common.dtsi
> +++ b/arch/arm/boot/dts/exynos4412-ppmu-common.dtsi
> @@ -6,12 +6,16 @@
>   * Author: Chanwoo Choi <cw00.choi@samsung.com>
>   */
>  
> +#include <dt-bindings/pmu/exynos_ppmu.h>
> +
>  &ppmu_dmc0 {
>         status = "okay";
>  
>         events {
>  	       ppmu_dmc0_3: ppmu-event3-dmc0 {
>  		       event-name = "ppmu-event3-dmc0";
> +		       event-data-type = <(PPMU_RO_DATA_CNT |
> +					   PPMU_WO_DATA_CNT)>;
>  	       };
>         };
>  };
> @@ -22,6 +26,8 @@
>         events {
>  	       ppmu_dmc1_3: ppmu-event3-dmc1 {
>  		       event-name = "ppmu-event3-dmc1";
> +		       event-data-type = <(PPMU_RO_DATA_CNT |
> +					   PPMU_WO_DATA_CNT)>;
>  	       };
>         };
>  };
> @@ -32,6 +38,8 @@
>         events {
>  	       ppmu_leftbus_3: ppmu-event3-leftbus {
>  		       event-name = "ppmu-event3-leftbus";
> +		       event-data-type = <(PPMU_RO_DATA_CNT |
> +					   PPMU_WO_DATA_CNT)>;
>  	       };
>         };
>  };
> @@ -42,6 +50,8 @@
>         events {
>  	       ppmu_rightbus_3: ppmu-event3-rightbus {
>  		       event-name = "ppmu-event3-rightbus";
> +		       event-data-type = <(PPMU_RO_DATA_CNT |
> +					   PPMU_WO_DATA_CNT)>;
>  	       };
>         };
>  };
> 

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
