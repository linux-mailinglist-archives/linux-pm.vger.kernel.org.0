Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E95A17595
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2019 12:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbfEHKFK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 May 2019 06:05:10 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:54443 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbfEHKFK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 May 2019 06:05:10 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190508100507euoutp023df476a1e845d6294630516b4029244f~crRw_X3jy2912429124euoutp02K
        for <linux-pm@vger.kernel.org>; Wed,  8 May 2019 10:05:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190508100507euoutp023df476a1e845d6294630516b4029244f~crRw_X3jy2912429124euoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1557309908;
        bh=Lal4PtYXV/9VLRwc99/d1O5mQ4PrmsmpztEfidkvKoQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=dLsVjQOdc/QWZcUc73XJirlnuIga1FGbno5eqNZ20VCcEGLDOgh73B1K/5VFa0pIV
         zEsgyc5+8K2eKAxjO561QeTkd/9E3l7xNXoZwWcJ0VV8JeWw+ppUWl5sOvOfbKHssG
         A3rbbIJ4CHlIQEAAp65jOF0NO6sJ5dwSKqhJDJk4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190508100507eucas1p2c8f8203ab28f455c339bcf5248d23844~crRwSGEHy2244422444eucas1p2U;
        Wed,  8 May 2019 10:05:07 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 5B.0F.04377.2D9A2DC5; Wed,  8
        May 2019 11:05:06 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190508100506eucas1p2ab217f8232db3d01a018222434e50e87~crRvj0HTf0236202362eucas1p2T;
        Wed,  8 May 2019 10:05:06 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190508100506eusmtrp1e3048af202edc8671be2a56a2867d1ba~crRvVh--Q2472424724eusmtrp1e;
        Wed,  8 May 2019 10:05:06 +0000 (GMT)
X-AuditID: cbfec7f4-12dff70000001119-70-5cd2a9d25d13
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 0C.99.04140.2D9A2DC5; Wed,  8
        May 2019 11:05:06 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190508100505eusmtip12c6ed055f8b8859ba3b841ff3111a8dc~crRuRFBUZ0420404204eusmtip1O;
        Wed,  8 May 2019 10:05:05 +0000 (GMT)
Subject: Re: [PATCH v7 12/13] ARM: dts: exynos: add DMC device for
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
Message-ID: <b8debbd9-fd49-5666-eab1-b905ed050067@partner.samsung.com>
Date:   Wed, 8 May 2019 12:05:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAJKOXPcOWkUa_+sLNXdhqpQNN9oaCuHzpjvagsE+ViA0mDf4Vw@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf0yMcRzHfe95nrun5vJ1RZ/FmMPIJjK278aikT34Iz/HaOPkWaG7ck/5
        FXPkRyJS6Do/chh1nOvX+nE2kXbJ4RR2FaY5v1XKVUSk66npv9f383m/93m/ty9LKT4zAexm
        TTyv1ahilFJvutjW5Zham1sbMf2jZTbJ11sY4mz/yJDsyicMudHmQiTj4QUJeXRMTU66vlLE
        4ciTkccHmmTkmfW8lLhTKxHRO+5IiLnytYy83J8jJfebjjCk/Pli8vK3D+l88BbNU3CdHek0
        d05XQ3NlhtcyrsB0VMqlJrVIuRNFJsQV2hM5d8GYpexa7zmb+JjN23nttJAN3tEtp83SOF3k
        zoMfnIwOGYNTkBcLeCYYLbdRCvJmFTgHwaMrbolnocDtCA5d7Wc3Al0rNWAw5zsZ0XAdQdmt
        35T4aEZQp8+WpSCW9cXh4Era4TH44UBw/vnRZ6BwPg0lpdY+jRQHQalpm0cjxwuhtrKa8TCN
        J4DpQVbfsRF4Dbyx5TGiZjhUZ72jPeyFl0GP7bLMwxT2h4Z32RKRx0JJ8/m+PICzWLjY2YXE
        1AuguzxTJrIvfKkq6ufRYM84TossgC7V2K/fA66TF/o1s+F+VQ3jyUz1lrFYp4njUDA/eSH1
        jAH7QF3zcDGCD6QXZ1LiWA7JhxWiejIUHX8qEXkkXL95VpaGlIZBxQyDyhgGlTH8v3sJ0Sbk
        zycI6ihemKHhdwQJKrWQoIkKioxVF6DeD2j/W9VeiqzdGysQZpFyqPxTXE2EglFtF3apKxCw
        lNJP7jxVG6GQb1Lt2s1rY9drE2J4oQKNYmmlvzxxSOM6BY5SxfNbeT6O1w5sJaxXgA6tTrS1
        PPeL31u95Zu7PnfKuIkbNGMbfxlzkqx/Va5Ft9+uXHat59WwjuJU/fjHU3uCLas2luYumX+x
        njSEXLIbtZErys5Nmrvi+731jjt7PjW8D9lXTYeV8KGzprvCJ8tjuxrtLfl3ucCRutCf69p8
        wwytdjaiMC95edqZG8dyUtoXYCUtRKuCp1BaQfUPiAQ0uHwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgleLIzCtJLcpLzFFi42I5/e/4Xd1LKy/FGNycx2WxccZ6VovrX56z
        Wsw/co7VYvXHx4wWk0/NZbI4051r0f/4NbPF+fMb2C3ONr1ht7i8aw6bxefeI4wWM87vY7JY
        e+Quu8XtxhVsFofftLNa7L/iZXH7N5/FtxOPGB2EPL59ncTiMbvhIovHzll32T02repk8+ht
        fsfm0bdlFaPH5tPVHp83yQVwROnZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq
        6dvZpKTmZJalFunbJehlvJuylq2gIbmi5dl11gbGhYZdjJwcEgImEms3XmftYuTiEBJYyihx
        7PV3RoiEmMSkfdvZIWxhiT/Xutggil4zSmw+8ZkNJCEs4Cux48VFsAYRAU2J63+/g01iFtjI
        InHxVS8TRMdyJokz/9YCVXFwsAnoSexYVQjSwCvgJnHpyElWEJtFQEVi1YmZzCC2qECExJn3
        K1ggagQlTs58AmZzCgRK/D+2COwiZgEziXmbHzJD2OISt57MZ4Kw5SW2v53DPIFRaBaS9llI
        WmYhaZmFpGUBI8sqRpHU0uLc9NxiI73ixNzi0rx0veT83E2MwNjfduznlh2MXe+CDzEKcDAq
        8fC+KLgYI8SaWFZcmXuIUYKDWUmE9/rESzFCvCmJlVWpRfnxRaU5qcWHGE2BnpvILCWanA9M
        S3kl8YamhuYWlobmxubGZhZK4rwdAgdjhATSE0tSs1NTC1KLYPqYODilGhiVrf/82bNrRmP1
        vP5JJwofP921RD7tB4ebQ8tS7l7J00FvFFvnf44sjW05kfq6L3jtNNGKlFwJFqYLzqXiryYX
        nc5t/vCx6A5nipbtn4vTrj0o7Vqmm/hmklSTXrWoFs++yofnthzd8qJU8HLQBJdZT/hbt16N
        +bZa5ZXEXYu5b+zv9O1hmflNiaU4I9FQi7moOBEAffcMpRMDAAA=
X-CMS-MailID: 20190508100506eucas1p2ab217f8232db3d01a018222434e50e87
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190506151219eucas1p2b5c3368873696f51e7d0d3a3e6d6bf1e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190506151219eucas1p2b5c3368873696f51e7d0d3a3e6d6bf1e
References: <CGME20190506151219eucas1p2b5c3368873696f51e7d0d3a3e6d6bf1e@eucas1p2.samsung.com>
        <1557155521-30949-1-git-send-email-l.luba@partner.samsung.com>
        <1557155521-30949-13-git-send-email-l.luba@partner.samsung.com>
        <CAJKOXPcOWkUa_+sLNXdhqpQNN9oaCuHzpjvagsE+ViA0mDf4Vw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 5/8/19 9:25 AM, Krzysztof Kozlowski wrote:
> On Mon, 6 May 2019 at 17:12, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>>
>> Add description of Dynamic Memory Controller and PPMU counters.
>> They are used by exynos5422-dmc driver.
>> There is a definition of the memory chip, which is then used during
>> calculation of timings for each OPP.
>> The algorithm in the driver needs these two sets to bound the timings.
>>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   arch/arm/boot/dts/exynos5420.dtsi             | 121 +++++++++++++++++++++++++
>>   arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 122 ++++++++++++++++++++++++++
>>   2 files changed, 243 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
>> index aaff158..1b66601 100644
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
>> @@ -235,6 +236,38 @@
>>                          status = "disabled";
>>                  };
>>
>> +               dmc: memory-controller@10c20000 {
>> +                       compatible = "samsung,exynos5422-dmc";
>> +                       reg = <0x10c20000 0x100>, <0x10c30000 0x100>;
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
>> +                       samsung,syscon-clk = <&clock>;
>> +                       samsung,syscon-chipid = <&chipid>;
>> +                       status = "disabled";
>> +               };
>> +
>>                  nocp_mem0_0: nocp@10ca1000 {
>>                          compatible = "samsung,exynos5420-nocp";
>>                          reg = <0x10CA1000 0x200>;
>> @@ -271,6 +304,94 @@
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
>> index 25d95de1..76abf03 100644
>> --- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
>> +++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
>> @@ -34,6 +34,97 @@
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
>> +               compatible      = "Samsung,K3QF2F20DB", "jedec,lpddr3";
>> +               density         = <16384>;
>> +               io-width        = <32>;
>> +               #address-cells  = <1>;
>> +               #size-cells     = <0>;
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
>> +                       compatible      = "jedec,lpddr3-timings";
>> +                       reg             = <800000000>; /* workaround: it shows max-freq */
> 
> Please be sure that there are no new warnings (make dtbs W=1). This
> does not look correct (reg does not match unit address).
Rob has also pointed out in the bindings that it should have @800000000.
Regarding the dtbs warnings, it does not produce any new even with '@0'.

I have changed it to @800000000 in the next version.

Regards,
Lukasz
> 
> Best regards,
> Krzysztof
> 
> 
