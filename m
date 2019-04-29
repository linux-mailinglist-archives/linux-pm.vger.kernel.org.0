Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6177E2DD
	for <lists+linux-pm@lfdr.de>; Mon, 29 Apr 2019 14:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbfD2Miv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Apr 2019 08:38:51 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:51230 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728081AbfD2Miv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Apr 2019 08:38:51 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190429123848euoutp02024f333a488e0776ab84e65e3a2187f2~Z8kYKno_f2101221012euoutp02P
        for <linux-pm@vger.kernel.org>; Mon, 29 Apr 2019 12:38:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190429123848euoutp02024f333a488e0776ab84e65e3a2187f2~Z8kYKno_f2101221012euoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1556541528;
        bh=aoHyV4TSTtaa6l6jijCfv/P1wEEkvPWF/Edn8HrTflk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=B72XrwIYi81HmphQXg+QJz6vDJVhxI3IsWnI2qO49bAf8zh2DQgldjZgkd52fgl78
         t5+I8BxUq6QDjbRKcdcCdRjMdWxJwdKi3WSf0hE4qlze9HpDqd1CwF8xGdJP9v4w0A
         KiP90Go27lhnYxo9saGyybAQtIqy0cZ+VivLRq5U=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190429123848eucas1p11249ce0038a5ab56cdb3132f80d69c81~Z8kXaBpZm2624526245eucas1p1o;
        Mon, 29 Apr 2019 12:38:48 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 63.87.04325.750F6CC5; Mon, 29
        Apr 2019 13:38:47 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190429123847eucas1p1c0d8d38a912c0f61bed165c427bf6065~Z8kWpjv5n2634626346eucas1p1K;
        Mon, 29 Apr 2019 12:38:47 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190429123847eusmtrp16605fdd82bf8dd5696f54a10c90231e7~Z8kWbTPQB1575515755eusmtrp1Q;
        Mon, 29 Apr 2019 12:38:47 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-8f-5cc6f0575059
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 33.FE.04140.650F6CC5; Mon, 29
        Apr 2019 13:38:46 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190429123846eusmtip1bff741572da010c5fa5c67c307e56fb6~Z8kVsJiJh3183831838eusmtip1W;
        Mon, 29 Apr 2019 12:38:46 +0000 (GMT)
Subject: Re: [PATCH v6 09/10] ARM: dts: exynos: add DMC device for
 exynos5422
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        =?UTF-8?Q?Bart=c5=82omiej_=c5=bbo=c5=82nierkiewicz?= 
        <b.zolnierkie@samsung.com>, kgene@kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        kyungmin.park@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        keescook@chromium.org, tony@atomide.com, jroedel@suse.de,
        treding@nvidia.com, digetx@gmail.com, willy.mh.wolff.ml@gmail.com
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <34ae95ae-9788-6334-d4ef-7f9add76b77c@partner.samsung.com>
Date:   Mon, 29 Apr 2019 14:38:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAJKOXPfE2Kt_afkH6wryRgdVqfvDUH82rMf_iKFuvDVSH00LJw@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SeUhUURTGu/OWeYpjr8n0UNEyUZTUmBRxITEFideGRrTQYo75UMkZdZ5W
        Vn9MC1Y6almYTopFkDZampmaleWS5pJmKuZG4UiWOW2WZVOSrzeS//3Oud+55/sulyGU76nZ
        TLguhtfrNBEq2pEsqR1rXrHzc+3eleYBNb6TXkDhzm+DFM6uaaZw3hcLwhcbsmS4KVGLUywf
        CNzSUijHz08Oy3FbeSaNR5JqEE5vqZDhWzV9ctxzIpfG1cNnKPy4fSPusTnj0Wf9yEfJjX5P
        JbkrhlaSu2/qk3NF5nM0l3TqI80lF5sRd7fxGDdSNC+A2e3oFcJHhB/i9R7eQY5hg8m9sqif
        wUfeWwMMqNszATkwwK6GgvPPyQTkyCjZXARD9/qRVHxDUNkwSEvFCIJHlb9kkyOXvo7bR3IQ
        JDZZ7IUVQVfXQyIBMcxM1h/Gbi4UB1zYZdD55wclagj2DgmlZeVyUUOzaigzR4saBbseHprj
        5SKT7GJoKiklRZ7F7oLXtYWUpJkB9RkD//oO7FYo/DlOiEywbtA9kC2TeD6UWjMJcRewFxgw
        pj1Akms/KOu4QEk8E4bqiuUSz4XGi0ZSYgEMSdfs+uNgScmya9ZCdV0rJXomJsIUlHuICKwv
        NJ2eI6EzvLLOkBw4Q2rJZUJqK+BsvFK6YykUG1/YX9AVcvLT5OeRyjQll2lKFtOULKb/a68i
        0ozc+FhBG8oLq3T8YbWg0QqxulD1gUhtEZr4gI3jdd/LUMXv4CrEMkjlpFgw9HSvktIcEuK0
        VQgYQuWi4OomWooQTdxRXh+5Xx8bwQtVaA5DqtwUx6a92aNkQzUx/EGej+L1k6cyxmG2AS2n
        vUYV07LdlVGBrcZtNVmVGe8eVaTTQvztZs7/U294sI9fYqNrm0t1XkL0Fpt1g9bX+JZL5QyB
        2LYvbHr99kpbx6I1Ad4jOWyHxTnfaNvcmZN24EYQAzrkFP9ynzrwZF8acTN4dJN+x0FLq3Xn
        k/1B7t1LHm++7hfnuu5du7uKFMI0nu6EXtD8BfwCn6x8AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPIsWRmVeSWpSXmKPExsVy+t/xu7phH47FGKxfZW2xccZ6VovrX56z
        Wsw/co7VYvXHx4wWk0/NZbI4051r0f/4NbPF+fMb2C3ONr1ht7i8aw6bxefeI4wWM87vY7JY
        e+Quu8XtxhVsFofftLNa7L/iZXH7N5/FtxOPGB2EPL59ncTiMbvhIovHzll32T02repk8+ht
        fsfm0bdlFaPH5tPVHp83yQVwROnZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq
        6dvZpKTmZJalFunbJehlPO+7w1TwI6ni5duABsZbhl2MnBwSAiYSUz79Y+li5OIQEljKKNHZ
        0sECkRCTmLRvOzuELSzx51oXG0TRa0aJbdfmsIIkhAV8JfrfnAMrEhHQlLj+9zsrSBGzwEYW
        iYuvepkgOpYzSXQ0fAZq5+BgE9CT2LGqEKSBV8BNYs+qNrBmFgFViTPbtoNtFhWIkDjzfgUL
        RI2gxMmZT8BsToFAiQ0//jGD2MwCZhLzNj+EssUlbj2ZzwRhy0tsfzuHeQKj0Cwk7bOQtMxC
        0jILScsCRpZVjCKppcW56bnFRnrFibnFpXnpesn5uZsYgZG/7djPLTsYu94FH2IU4GBU4uFV
        eHU0Rog1say4MvcQowQHs5IIr8dxoBBvSmJlVWpRfnxRaU5q8SFGU6DnJjJLiSbnA5NSXkm8
        oamhuYWlobmxubGZhZI4b4fAwRghgfTEktTs1NSC1CKYPiYOTqkGxiiJs4cXR4hwLGaZIPJn
        Zf7Mfxat74QDKu0XfkgNKeQ+Wbh78hXnM+tuC23gfK0k6MMc1G5/w8FDNVrUsqIuNSTwuCDn
        o/lzP25fLFItyh357m9Zqdk78dWWbVMXNdtvOT8tRvzipz1arBbpT97WZJRKsawUztNlW5+p
        r8jLdszFQ/x+Q+NfJZbijERDLeai4kQA7hm40xIDAAA=
X-CMS-MailID: 20190429123847eucas1p1c0d8d38a912c0f61bed165c427bf6065
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190419141952eucas1p11dc36f30c873a947122e0f7e8d55a3bb
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190419141952eucas1p11dc36f30c873a947122e0f7e8d55a3bb
References: <CGME20190419141952eucas1p11dc36f30c873a947122e0f7e8d55a3bb@eucas1p1.samsung.com>
        <1555683568-20882-1-git-send-email-l.luba@partner.samsung.com>
        <1555683568-20882-10-git-send-email-l.luba@partner.samsung.com>
        <CAJKOXPfE2Kt_afkH6wryRgdVqfvDUH82rMf_iKFuvDVSH00LJw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Krzysztof,

Thank you the review, please check my comments below.

On 4/23/19 1:03 PM, Krzysztof Kozlowski wrote:
> On Fri, 19 Apr 2019 at 16:19, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>>
>> Add description of Dynamic Memory Controller and PPMU counters.
>> They are used by exynos5422-dmc driver.
>> There is a definition of the memory chip, hwich is then used during
> 
> which
ACK
> 
>> calculation of timings for each OPP.
>> The algorithm in the driver needs these two sets to bound the timings.
>>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   arch/arm/boot/dts/exynos5420.dtsi             | 120 ++++++++++++++++++++++++++
>>   arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 120 ++++++++++++++++++++++++++
>>   2 files changed, 240 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
>> index aaff158..b687cd7 100644
>> --- a/arch/arm/boot/dts/exynos5420.dtsi
>> +++ b/arch/arm/boot/dts/exynos5420.dtsi
>> @@ -14,6 +14,7 @@
>>   #include <dt-bindings/clock/exynos5420.h>
>>   #include <dt-bindings/clock/exynos-audss-clk.h>
>>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +#include <dt-bindings/pmu/exynos_ppmu.h>
>>
>>   / {
>>          compatible = "samsung,exynos5420", "samsung,exynos5";
>> @@ -235,6 +236,37 @@
>>                          status = "disabled";
>>                  };
>>
>> +               dmc: memory-controller@10c20000 {
>> +                       compatible = "samsung,exynos5422-dmc";
>> +                       reg = <0x10c20000 0x10000>, <0x10c30000 0x10000>,
> 
> I think in the driver you access range up to 0xff of each DREX memory
> region. Do not map entire 0x10000 if not needed.
I agree, I will map only 0x100.
> 
> 
>> +                               <0x10000000 0x1000>, <0x10030000 0x1000>;
>> +                       clocks = <&clock CLK_FOUT_SPLL>,
>> +                                <&clock CLK_MOUT_SCLK_SPLL>,
>> +                                <&clock CLK_FF_DOUT_SPLL2>,
>> +                                <&clock CLK_FOUT_BPLL>,
>> +                                <&clock CLK_MOUT_BPLL>,
>> +                                <&clock CLK_SCLK_BPLL>,
>> +                                <&clock CLK_MOUT_MX_MSPLL_CCORE>,
>> +                                <&clock CLK_MOUT_MX_MSPLL_CCORE_PHY>,
>> +                                <&clock CLK_MOUT_MCLK_CDREX>,
>> +                                <&clock CLK_DOUT_CLK2X_PHY0>,
>> +                                <&clock CLK_CLKM_PHY0>,
>> +                                <&clock CLK_CLKM_PHY1>;
>> +                       clock-names = "fout_spll",
>> +                                     "mout_sclk_spll",
>> +                                     "ff_dout_spll2",
>> +                                     "fout_bpll",
>> +                                     "mout_bpll",
>> +                                     "sclk_bpll",
>> +                                     "mout_mx_mspll_ccore",
>> +                                     "mout_mx_mspll_ccore_phy",
>> +                                     "mout_mclk_cdrex",
>> +                                     "dout_clk2x_phy0",
>> +                                     "clkm_phy0",
>> +                                     "clkm_phy1";
>> +                       status = "disabled";
>> +               };
>> +
>>                  nocp_mem0_0: nocp@10ca1000 {
>>                          compatible = "samsung,exynos5420-nocp";
>>                          reg = <0x10CA1000 0x200>;
>> @@ -271,6 +303,94 @@
>>                          status = "disabled";
>>                  };
>>
>> +               ppmu_dmc0_0: ppmu@10d00000 {
>> +                       compatible = "samsung,exynos-ppmu";
>> +                       reg = <0x10d00000 0x2000>;
>> +                       clocks = <&clock CLK_PCLK_PPMU_DREX0_0>;
>> +                       clock-names = "ppmu";
>> +                       events {
>> +                               ppmu_event0_dmc0_0: ppmu-event0-dmc0_0 {
>> +                                       event-name = "ppmu-event0-dmc0_0";
>> +                                       event-data-type = <PPMU_RO_DATA_CNT>;
>> +                               };
>> +                               ppmu_event1_dmc0_0: ppmu-event1-dmc0_0 {
>> +                                       event-name = "ppmu-event1-dmc0_0";
>> +                                       event-data-type = <PPMU_WO_DATA_CNT>;
>> +                               };
>> +                               ppmu_event3_dmc0_0: ppmu-event3-dmc0_0 {
>> +                                       event-name = "ppmu-event3-dmc0_0";
>> +                                       event-data-type = <(PPMU_RO_DATA_CNT |
>> +                                               PPMU_WO_DATA_CNT)>;
>> +                               };
>> +                       };
>> +               };
>> +
>> +               ppmu_dmc0_1: ppmu@10d10000 {
>> +                       compatible = "samsung,exynos-ppmu";
>> +                       reg = <0x10d10000 0x2000>;
>> +                       clocks = <&clock CLK_PCLK_PPMU_DREX0_1>;
>> +                       clock-names = "ppmu";
>> +                       events {
>> +                               ppmu_event0_dmc0_1: ppmu-event0-dmc0_1 {
>> +                                       event-name = "ppmu-event0-dmc0_1";
>> +                                       event-data-type = <PPMU_RO_DATA_CNT>;
>> +                               };
>> +                               ppmu_event1_dmc0_1: ppmu-event1-dmc0_1 {
>> +                                       event-name = "ppmu-event1-dmc0_1";
>> +                                       event-data-type = <PPMU_WO_DATA_CNT>;
>> +                               };
>> +                               ppmu_event3_dmc0_1: ppmu-event3-dmc0_1 {
>> +                                       event-name = "ppmu-event3-dmc0_1";
>> +                                       event-data-type = <(PPMU_RO_DATA_CNT |
>> +                                               PPMU_WO_DATA_CNT)>;
>> +                               };
>> +                       };
>> +               };
>> +
>> +               ppmu_dmc1_0: ppmu@10d60000 {
>> +                       compatible = "samsung,exynos-ppmu";
>> +                       reg = <0x10d60000 0x2000>;
>> +                       clocks = <&clock CLK_PCLK_PPMU_DREX1_0>;
>> +                       clock-names = "ppmu";
>> +                       events {
>> +                               ppmu_event0_dmc1_0: ppmu-event0-dmc1_0 {
>> +                                       event-name = "ppmu-event0-dmc1_0";
>> +                                       event-data-type = <PPMU_RO_DATA_CNT>;
>> +                               };
>> +                               ppmu_event1_dmc1_0: ppmu-event1-dmc1_0 {
>> +                                       event-name = "ppmu-event1-dmc1_0";
>> +                                       event-data-type = <PPMU_WO_DATA_CNT>;
>> +                               };
>> +                               ppmu_event3_dmc1_0: ppmu-event3-dmc1_0 {
>> +                                       event-name = "ppmu-event3-dmc1_0";
>> +                                       event-data-type = <(PPMU_RO_DATA_CNT |
>> +                                               PPMU_WO_DATA_CNT)>;
>> +                               };
>> +                       };
>> +               };
>> +
>> +               ppmu_dmc1_1: ppmu@10d70000 {
>> +                       compatible = "samsung,exynos-ppmu";
>> +                       reg = <0x10d70000 0x2000>;
>> +                       clocks = <&clock CLK_PCLK_PPMU_DREX1_1>;
>> +                       clock-names = "ppmu";
>> +                       events {
>> +                               ppmu_event0_dmc1_1: ppmu-event0-dmc1_1 {
>> +                                       event-name = "ppmu-event0-dmc1_1";
>> +                                       event-data-type = <PPMU_RO_DATA_CNT>;
>> +                               };
>> +                               ppmu_event1_dmc1_1: ppmu-event1-dmc1_1 {
>> +                                       event-name = "ppmu-event1-dmc1_1";
>> +                                       event-data-type = <PPMU_WO_DATA_CNT>;
>> +                               };
>> +                               ppmu_event3_dmc1_1: ppmu-event3-dmc1_1 {
>> +                                       event-name = "ppmu-event3-dmc1_1";
>> +                                       event-data-type = <(PPMU_RO_DATA_CNT |
>> +                                               PPMU_WO_DATA_CNT)>;
>> +                               };
>> +                       };
>> +               };
>> +
>>                  gsc_pd: power-domain@10044000 {
>>                          compatible = "samsung,exynos4210-pd";
>>                          reg = <0x10044000 0x20>;
>> diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
>> index 25d95de1..76bf0dbf 100644
>> --- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
>> +++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
>> @@ -34,6 +34,95 @@
>>                          clock-frequency = <24000000>;
>>                  };
>>          };
>> +
>> +       dmc_opp_table: opp_table2 {
>> +               compatible = "operating-points-v2";
>> +
>> +               opp00 {
>> +                       opp-hz = /bits/ 64 <165000000>;
>> +                       opp-microvolt = <875000>;
>> +               };
>> +               opp01 {
>> +                       opp-hz = /bits/ 64 <206000000>;
>> +                       opp-microvolt = <875000>;
>> +               };
>> +               opp02 {
>> +                       opp-hz = /bits/ 64 <275000000>;
>> +                       opp-microvolt = <875000>;
>> +               };
>> +               opp03 {
>> +                       opp-hz = /bits/ 64 <413000000>;
>> +                       opp-microvolt = <887500>;
>> +               };
>> +               opp04 {
>> +                       opp-hz = /bits/ 64 <543000000>;
>> +                       opp-microvolt = <937500>;
>> +               };
>> +               opp05 {
>> +                       opp-hz = /bits/ 64 <633000000>;
>> +                       opp-microvolt = <1012500>;
>> +               };
>> +               opp06 {
>> +                       opp-hz = /bits/ 64 <728000000>;
>> +                       opp-microvolt = <1037500>;
>> +               };
>> +               opp07 {
>> +                       opp-hz = /bits/ 64 <825000000>;
>> +                       opp-microvolt = <1050000>;
>> +               };
>> +       };
>> +
>> +       samsung_K3QF2F20DB: lpddr3 {
>> +               compatible      = "Samsung,K3QF2F20DB","jedec,lpddr3";
> 
> Missing space after coma.
Good catch, thank you.
> 
>> +               density         = <16384>;
>> +               io-width        = <32>;
>> +
>> +               tRFC-min-tck            = <17>;
>> +               tRRD-min-tck            = <2>;
>> +               tRPab-min-tck           = <2>;
>> +               tRPpb-min-tck           = <2>;
>> +               tRCD-min-tck            = <3>;
>> +               tRC-min-tck             = <6>;
>> +               tRAS-min-tck            = <5>;
>> +               tWTR-min-tck            = <2>;
>> +               tWR-min-tck             = <7>;
>> +               tRTP-min-tck            = <2>;
>> +               tW2W-C2C-min-tck        = <0>;
>> +               tR2R-C2C-min-tck        = <0>;
>> +               tWL-min-tck             = <8>;
>> +               tDQSCK-min-tck          = <5>;
>> +               tRL-min-tck             = <14>;
>> +               tFAW-min-tck            = <5>;
>> +               tXSR-min-tck            = <12>;
>> +               tXP-min-tck             = <2>;
>> +               tCKE-min-tck            = <2>;
>> +               tCKESR-min-tck          = <2>;
>> +               tMRD-min-tck            = <5>;
>> +
>> +               timings_samsung_K3QF2F20DB_800mhz: lpddr3-timings@0 {
> 
> @0 does not look correct... you do not have <reg>. No DTC warnings here?
Rob also pointed out that it should have 'reg'. I have followed the
LPDDR2 definitions, but in the meantime DT rules have changed and now
'reg' is needed. I will put 'reg' instead of 'max-freq' if Rob agrees.

Regards,
Lukasz
> 
> Best regards,
> Krzysztof
> 
> 
