Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12AAC415552
	for <lists+linux-pm@lfdr.de>; Thu, 23 Sep 2021 04:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238843AbhIWCDA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Sep 2021 22:03:00 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:29622 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238820AbhIWCC7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Sep 2021 22:02:59 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210923020127epoutp02131748f23f647ed39fdc95306371b16b~nUQiPcRJ60996809968epoutp02j
        for <linux-pm@vger.kernel.org>; Thu, 23 Sep 2021 02:01:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210923020127epoutp02131748f23f647ed39fdc95306371b16b~nUQiPcRJ60996809968epoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1632362487;
        bh=htrpPC8RyjK4PpLp5m+xJVpuwzY4lLsGwaLErTEO478=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Gh767eFbUpPprUSDkEi6RPUUj1/G+ngui9k50LURVnamV2UuoW60Q14NrDTaktJBh
         5gIXTp2YnhNUgjbV24kafpg1wB7nSYEbrQOrjP0R+JoEtT30YXvLy6JTGNWVBUmppq
         DkVQfV+Ct+YE5wPwOUFICppV69jafHlck4w0nqfQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210923020126epcas1p1d74005ffae2176b488fc05c3f51e560b~nUQhRAeEj1706017060epcas1p1N;
        Thu, 23 Sep 2021 02:01:26 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.237]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4HFJL43cXJz4x9Q0; Thu, 23 Sep
        2021 02:01:16 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        47.D2.62504.AEFDB416; Thu, 23 Sep 2021 11:01:14 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20210923020112epcas1p3552159d3e948679fc1f2ceaec1a3ab75~nUQUx7GL00794907949epcas1p3b;
        Thu, 23 Sep 2021 02:01:12 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210923020112epsmtrp11e09141904c2fe342f713f0202762a7c~nUQUxIN1E2429924299epsmtrp1Q;
        Thu, 23 Sep 2021 02:01:12 +0000 (GMT)
X-AuditID: b6c32a38-79bff7000002f428-26-614bdfeace90
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        42.D6.08750.8EFDB416; Thu, 23 Sep 2021 11:01:12 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210923020112epsmtip26d1b8ad9375c4306ba47a5fe14a2a640~nUQUi184h1897118971epsmtip2_;
        Thu, 23 Sep 2021 02:01:12 +0000 (GMT)
Subject: Re: [PATCH v2 3/3] ARM: dts: exynos: align PPMU event node names
 with dtschema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <a7a4e1d3-77a7-a48e-4cbf-36cb06435e9c@samsung.com>
Date:   Thu, 23 Sep 2021 11:22:20 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20210920071753.38560-3-krzysztof.kozlowski@canonical.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEJsWRmVeSWpSXmKPExsWy7bCmge6r+96JBu/WS1lsnLGe1WL+kXOs
        Fhvf/mCyONv0ht1i0+NrrBaXd81hs/jce4TRYsb5fUwWa4/cZbe43biCzaJ17xF2i/anL5kd
        eDxmNfSyeWxa1cnmsXlJvUffllWMHp83yQWwRmXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5ua
        GRjqGlpamCsp5CXmptoqufgE6Lpl5gCdp6RQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUot
        SMkpMC3QK07MLS7NS9fLSy2xMjQwMDIFKkzIzmje0cVWsF2w4sSex8wNjHt5uxg5OCQETCTm
        /+TqYuTiEBLYwShx8ccfJgjnE6PE74P/WSGcz4wS91+uZexi5ATrmHZlMiNEYhejxKzz09kh
        nPeMEvtaWplAqoQFIiU+zdkJlhARuMYkcWTBSbDBzAKTGCWO/F7OBlLFJqAlsf/FDTCbX0BR
        4uqPx2A7eAXsJNqP3gSLswioSpz/MZEFxBYVCJM4ua0FqkZQ4uTMJ2BxTgF3ibkTH7KD2MwC
        4hK3nsxngrDlJba/ncMMslhC4AiHxPx5n9ghnnCR2Lf1C5QtLPHq+BYoW0riZX8blF0tsfLk
        ETaI5g5GiS37L7BCJIwl9i+dzAQKP2YBTYn1u/QhwooSO3/PZYRYzCfx7msPKySIeSU62oQg
        SpQlLj+4ywRhS0osbu9km8CoNAvJO7OQvDALyQuzEJYtYGRZxSiWWlCcm55abFhgAo/v5Pzc
        TYzgxKtlsYNx7tsPeocYmTgYDzFKcDArifB+vuGVKMSbklhZlVqUH19UmpNafIjRFBjAE5ml
        RJPzgak/ryTe0MTSwMTMyNjEwtDMUEmc99hry0QhgfTEktTs1NSC1CKYPiYOTqkGJuc+iyup
        v9u7f3cZ7GX5ycu3yP9R9BduvgzhQmVB+ynXl/4+MLlN8O+0V3YKvolJlvM1ZkeeUc9WPzHV
        8rZFoHfJTskZxzUN1rkrKehP+/ImfqPsLvGm26Xilzomyfzm8mKQaJz88uCFObJnTwnUSu9e
        vXtvbTrz3uuhMcu+VO7ym++bKXP/Q1nCqlch/TEiyk3tl287F1+q+SyqmR2udUlRt/hCxYvg
        4pevivxP35Q/cktinhZfmYbLl7fcBW17NG1KJl7ZGqzxau9Ni5VBzBEsBu8O/li7ZcKxTbuW
        Zsuym/7Ytf6aQtuXgk3ck8Kjn+smLZtf/mmP78cfMjPOyTwz/VXMJCC4oEuT+7nTayWW4oxE
        Qy3mouJEABd8waJFBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDIsWRmVeSWpSXmKPExsWy7bCSvO6L+96JBtOeqVhsnLGe1WL+kXOs
        Fhvf/mCyONv0ht1i0+NrrBaXd81hs/jce4TRYsb5fUwWa4/cZbe43biCzaJ17xF2i/anL5kd
        eDxmNfSyeWxa1cnmsXlJvUffllWMHp83yQWwRnHZpKTmZJalFunbJXBlNO/oYivYLlhxYs9j
        5gbGvbxdjJwcEgImEtOuTGbsYuTiEBLYwShxfdM6VoiEpMS0i0eZuxg5gGxhicOHiyFq3jJK
        XGx9wQhSIywQKbHkyCU2kISIwDUmiZ4ta5hBEswCUxglNl3XgOi4zigxb8dsdpAEm4CWxP4X
        N9hAbH4BRYmrPx6DTeIVsJNoP3oTLM4ioCpx/sdEFhBbVCBMYueSx0wQNYISJ2c+AYtzCrhL
        zJ34kB1imbrEn3mXoBaLS9x6Mp8JwpaX2P52DvMERuFZSNpnIWmZhaRlFpKWBYwsqxglUwuK
        c9Nziw0LjPJSy/WKE3OLS/PS9ZLzczcxgiNQS2sH455VH/QOMTJxMB5ilOBgVhLh/XzDK1GI
        NyWxsiq1KD++qDQntfgQozQHi5I474Wuk/FCAumJJanZqakFqUUwWSYOTqkGJnmei4ejpN9d
        athbamKoKP/ELVGBf3Kkhh9/cKzmzMYlNlF2EfG3w46kqkupd7x9wnqk1/Ro2CvprDePWmpO
        HeKeK2v0vUZspshlw7iFydkbD7PvL3nmzNpsc6ZVvn1r5dpOH6NNh9nan5/a7e8w4ebk0qYy
        7wvn3N+7bDFev9+j/+ZvPeuvl26J+H79tSrTsGr+xQBeqykRZqsf67g/e+LgPyNFJ6UhSU0+
        +HX4r59SU0y5Fi3aVfycIe3kqvq7mza2rYti/1c4Z3Vw/u6GfWtarz/dPf/DnAMMeT8UTS58
        XN54LHf9c+71JtHv1s+/cyCuj+lXlfcUQVGT55anD+2Tut/bF3/ilcWR72d3rFdiKc5INNRi
        LipOBABygoQfLwMAAA==
X-CMS-MailID: 20210923020112epcas1p3552159d3e948679fc1f2ceaec1a3ab75
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210920071811epcas1p1729f8a9c04531be71e305cebda3b84bf
References: <20210920071540.38337-1-krzysztof.kozlowski@canonical.com>
        <CGME20210920071811epcas1p1729f8a9c04531be71e305cebda3b84bf@epcas1p1.samsung.com>
        <20210920071753.38560-3-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Krzysztof,

On 9/20/21 4:17 PM, Krzysztof Kozlowski wrote:
> Use hyphen instead of underscore and align the PPMU event node name with
> dtschema.  The event-name property must match the node name, by the
> design of devfreq events and PPMU driver.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  arch/arm/boot/dts/exynos5420.dtsi | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
> index e23e8ffb093f..b2f30bea96ce 100644
> --- a/arch/arm/boot/dts/exynos5420.dtsi
> +++ b/arch/arm/boot/dts/exynos5420.dtsi
> @@ -302,8 +302,8 @@ ppmu_dmc0_0: ppmu@10d00000 {
>  			clocks = <&clock CLK_PCLK_PPMU_DREX0_0>;
>  			clock-names = "ppmu";
>  			events {
> -				ppmu_event3_dmc0_0: ppmu-event3-dmc0_0 {
> -					event-name = "ppmu-event3-dmc0_0";
> +				ppmu_event3_dmc0_0: ppmu-event3-dmc0-0 {
> +					event-name = "ppmu-event3-dmc0-0";
>  				};
>  			};
>  		};
> @@ -314,8 +314,8 @@ ppmu_dmc0_1: ppmu@10d10000 {
>  			clocks = <&clock CLK_PCLK_PPMU_DREX0_1>;
>  			clock-names = "ppmu";
>  			events {
> -				ppmu_event3_dmc0_1: ppmu-event3-dmc0_1 {
> -					event-name = "ppmu-event3-dmc0_1";
> +				ppmu_event3_dmc0_1: ppmu-event3-dmc0-1 {
> +					event-name = "ppmu-event3-dmc0-1";
>  				};
>  			};
>  		};
> @@ -326,8 +326,8 @@ ppmu_dmc1_0: ppmu@10d60000 {
>  			clocks = <&clock CLK_PCLK_PPMU_DREX1_0>;
>  			clock-names = "ppmu";
>  			events {
> -				ppmu_event3_dmc1_0: ppmu-event3-dmc1_0 {
> -					event-name = "ppmu-event3-dmc1_0";
> +				ppmu_event3_dmc1_0: ppmu-event3-dmc1-0 {
> +					event-name = "ppmu-event3-dmc1-0";
>  				};
>  			};
>  		};
> @@ -338,8 +338,8 @@ ppmu_dmc1_1: ppmu@10d70000 {
>  			clocks = <&clock CLK_PCLK_PPMU_DREX1_1>;
>  			clock-names = "ppmu";
>  			events {
> -				ppmu_event3_dmc1_1: ppmu-event3-dmc1_1 {
> -					event-name = "ppmu-event3-dmc1_1";
> +				ppmu_event3_dmc1_1: ppmu-event3-dmc1-1 {
> +					event-name = "ppmu-event3-dmc1-1";
>  				};
>  			};
>  		};
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
