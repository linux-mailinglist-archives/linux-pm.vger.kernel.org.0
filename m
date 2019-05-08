Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37C7B17287
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2019 09:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfEHHZx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 May 2019 03:25:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:47176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726628AbfEHHZx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 May 2019 03:25:53 -0400
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DDC021530;
        Wed,  8 May 2019 07:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557300351;
        bh=jzO050Wewk+rFMC4Z1fjI4UJ716Ph+60nlXVau0FKWE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Q3f6bwJoiG6FgNSiytY4Lo7ntjcOkVfNnNBF95tmz6VxLdqKh7txerGoc1/qEs6uN
         d+kHfup2/xoW9JvwzmycWR5++fdNTg37RNM2fMnaTU2McRSvDY7TUQyhfLuQPhDGk/
         R36mMBxjkIOMxZaMadwP3bE6OBWrWwpd80wuGjRY=
Received: by mail-lf1-f50.google.com with SMTP id f1so986599lfl.6;
        Wed, 08 May 2019 00:25:51 -0700 (PDT)
X-Gm-Message-State: APjAAAXjcTJyUDYyPxxYYrmmuJMkLC8E38kpfUg5JTH30buctBHR3LPX
        p0uD1pBp4HR0f4SchzILRO6/9N1KKESLJV95iIs=
X-Google-Smtp-Source: APXvYqwBgP9hZLm7s8pUqqsx7t0N+Zi4L4NhkNPMloo5vaBwKyVsajAn3EVlgnXJipYIPRykyxn/twffi5oMedS2vWM=
X-Received: by 2002:a19:97c8:: with SMTP id z191mr18746085lfd.167.1557300349411;
 Wed, 08 May 2019 00:25:49 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190506151219eucas1p2b5c3368873696f51e7d0d3a3e6d6bf1e@eucas1p2.samsung.com>
 <1557155521-30949-1-git-send-email-l.luba@partner.samsung.com> <1557155521-30949-13-git-send-email-l.luba@partner.samsung.com>
In-Reply-To: <1557155521-30949-13-git-send-email-l.luba@partner.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 8 May 2019 09:25:38 +0200
X-Gmail-Original-Message-ID: <CAJKOXPcOWkUa_+sLNXdhqpQNN9oaCuHzpjvagsE+ViA0mDf4Vw@mail.gmail.com>
Message-ID: <CAJKOXPcOWkUa_+sLNXdhqpQNN9oaCuHzpjvagsE+ViA0mDf4Vw@mail.gmail.com>
Subject: Re: [PATCH v7 12/13] ARM: dts: exynos: add DMC device for exynos5422
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, kgene@kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        kyungmin.park@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        keescook@chromium.org, tony@atomide.com, jroedel@suse.de,
        treding@nvidia.com, digetx@gmail.com, willy.mh.wolff.ml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 6 May 2019 at 17:12, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
> Add description of Dynamic Memory Controller and PPMU counters.
> They are used by exynos5422-dmc driver.
> There is a definition of the memory chip, which is then used during
> calculation of timings for each OPP.
> The algorithm in the driver needs these two sets to bound the timings.
>
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  arch/arm/boot/dts/exynos5420.dtsi             | 121 +++++++++++++++++++++++++
>  arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 122 ++++++++++++++++++++++++++
>  2 files changed, 243 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
> index aaff158..1b66601 100644
> --- a/arch/arm/boot/dts/exynos5420.dtsi
> +++ b/arch/arm/boot/dts/exynos5420.dtsi
> @@ -14,6 +14,7 @@
>  #include <dt-bindings/clock/exynos5420.h>
>  #include <dt-bindings/clock/exynos-audss-clk.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/pmu/exynos_ppmu.h>
>
>  / {
>         compatible = "samsung,exynos5420", "samsung,exynos5";
> @@ -235,6 +236,38 @@
>                         status = "disabled";
>                 };
>
> +               dmc: memory-controller@10c20000 {
> +                       compatible = "samsung,exynos5422-dmc";
> +                       reg = <0x10c20000 0x100>, <0x10c30000 0x100>;
> +                       clocks = <&clock CLK_FOUT_SPLL>,
> +                                <&clock CLK_MOUT_SCLK_SPLL>,
> +                                <&clock CLK_FF_DOUT_SPLL2>,
> +                                <&clock CLK_FOUT_BPLL>,
> +                                <&clock CLK_MOUT_BPLL>,
> +                                <&clock CLK_SCLK_BPLL>,
> +                                <&clock CLK_MOUT_MX_MSPLL_CCORE>,
> +                                <&clock CLK_MOUT_MX_MSPLL_CCORE_PHY>,
> +                                <&clock CLK_MOUT_MCLK_CDREX>,
> +                                <&clock CLK_DOUT_CLK2X_PHY0>,
> +                                <&clock CLK_CLKM_PHY0>,
> +                                <&clock CLK_CLKM_PHY1>;
> +                       clock-names = "fout_spll",
> +                                     "mout_sclk_spll",
> +                                     "ff_dout_spll2",
> +                                     "fout_bpll",
> +                                     "mout_bpll",
> +                                     "sclk_bpll",
> +                                     "mout_mx_mspll_ccore",
> +                                     "mout_mx_mspll_ccore_phy",
> +                                     "mout_mclk_cdrex",
> +                                     "dout_clk2x_phy0",
> +                                     "clkm_phy0",
> +                                     "clkm_phy1";
> +                       samsung,syscon-clk = <&clock>;
> +                       samsung,syscon-chipid = <&chipid>;
> +                       status = "disabled";
> +               };
> +
>                 nocp_mem0_0: nocp@10ca1000 {
>                         compatible = "samsung,exynos5420-nocp";
>                         reg = <0x10CA1000 0x200>;
> @@ -271,6 +304,94 @@
>                         status = "disabled";
>                 };
>
> +               ppmu_dmc0_0: ppmu@10d00000 {
> +                       compatible = "samsung,exynos-ppmu";
> +                       reg = <0x10d00000 0x2000>;
> +                       clocks = <&clock CLK_PCLK_PPMU_DREX0_0>;
> +                       clock-names = "ppmu";
> +                       events {
> +                               ppmu_event0_dmc0_0: ppmu-event0-dmc0_0 {
> +                                       event-name = "ppmu-event0-dmc0_0";
> +                                       event-data-type = <PPMU_RO_DATA_CNT>;
> +                               };
> +                               ppmu_event1_dmc0_0: ppmu-event1-dmc0_0 {
> +                                       event-name = "ppmu-event1-dmc0_0";
> +                                       event-data-type = <PPMU_WO_DATA_CNT>;
> +                               };
> +                               ppmu_event3_dmc0_0: ppmu-event3-dmc0_0 {
> +                                       event-name = "ppmu-event3-dmc0_0";
> +                                       event-data-type = <(PPMU_RO_DATA_CNT |
> +                                               PPMU_WO_DATA_CNT)>;
> +                               };
> +                       };
> +               };
> +
> +               ppmu_dmc0_1: ppmu@10d10000 {
> +                       compatible = "samsung,exynos-ppmu";
> +                       reg = <0x10d10000 0x2000>;
> +                       clocks = <&clock CLK_PCLK_PPMU_DREX0_1>;
> +                       clock-names = "ppmu";
> +                       events {
> +                               ppmu_event0_dmc0_1: ppmu-event0-dmc0_1 {
> +                                       event-name = "ppmu-event0-dmc0_1";
> +                                       event-data-type = <PPMU_RO_DATA_CNT>;
> +                               };
> +                               ppmu_event1_dmc0_1: ppmu-event1-dmc0_1 {
> +                                       event-name = "ppmu-event1-dmc0_1";
> +                                       event-data-type = <PPMU_WO_DATA_CNT>;
> +                               };
> +                               ppmu_event3_dmc0_1: ppmu-event3-dmc0_1 {
> +                                       event-name = "ppmu-event3-dmc0_1";
> +                                       event-data-type = <(PPMU_RO_DATA_CNT |
> +                                               PPMU_WO_DATA_CNT)>;
> +                               };
> +                       };
> +               };
> +
> +               ppmu_dmc1_0: ppmu@10d60000 {
> +                       compatible = "samsung,exynos-ppmu";
> +                       reg = <0x10d60000 0x2000>;
> +                       clocks = <&clock CLK_PCLK_PPMU_DREX1_0>;
> +                       clock-names = "ppmu";
> +                       events {
> +                               ppmu_event0_dmc1_0: ppmu-event0-dmc1_0 {
> +                                       event-name = "ppmu-event0-dmc1_0";
> +                                       event-data-type = <PPMU_RO_DATA_CNT>;
> +                               };
> +                               ppmu_event1_dmc1_0: ppmu-event1-dmc1_0 {
> +                                       event-name = "ppmu-event1-dmc1_0";
> +                                       event-data-type = <PPMU_WO_DATA_CNT>;
> +                               };
> +                               ppmu_event3_dmc1_0: ppmu-event3-dmc1_0 {
> +                                       event-name = "ppmu-event3-dmc1_0";
> +                                       event-data-type = <(PPMU_RO_DATA_CNT |
> +                                               PPMU_WO_DATA_CNT)>;
> +                               };
> +                       };
> +               };
> +
> +               ppmu_dmc1_1: ppmu@10d70000 {
> +                       compatible = "samsung,exynos-ppmu";
> +                       reg = <0x10d70000 0x2000>;
> +                       clocks = <&clock CLK_PCLK_PPMU_DREX1_1>;
> +                       clock-names = "ppmu";
> +                       events {
> +                               ppmu_event0_dmc1_1: ppmu-event0-dmc1_1 {
> +                                       event-name = "ppmu-event0-dmc1_1";
> +                                       event-data-type = <PPMU_RO_DATA_CNT>;
> +                               };
> +                               ppmu_event1_dmc1_1: ppmu-event1-dmc1_1 {
> +                                       event-name = "ppmu-event1-dmc1_1";
> +                                       event-data-type = <PPMU_WO_DATA_CNT>;
> +                               };
> +                               ppmu_event3_dmc1_1: ppmu-event3-dmc1_1 {
> +                                       event-name = "ppmu-event3-dmc1_1";
> +                                       event-data-type = <(PPMU_RO_DATA_CNT |
> +                                               PPMU_WO_DATA_CNT)>;
> +                               };
> +                       };
> +               };
> +
>                 gsc_pd: power-domain@10044000 {
>                         compatible = "samsung,exynos4210-pd";
>                         reg = <0x10044000 0x20>;
> diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> index 25d95de1..76abf03 100644
> --- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> +++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> @@ -34,6 +34,97 @@
>                         clock-frequency = <24000000>;
>                 };
>         };
> +
> +       dmc_opp_table: opp_table2 {
> +               compatible = "operating-points-v2";
> +
> +               opp00 {
> +                       opp-hz = /bits/ 64 <165000000>;
> +                       opp-microvolt = <875000>;
> +               };
> +               opp01 {
> +                       opp-hz = /bits/ 64 <206000000>;
> +                       opp-microvolt = <875000>;
> +               };
> +               opp02 {
> +                       opp-hz = /bits/ 64 <275000000>;
> +                       opp-microvolt = <875000>;
> +               };
> +               opp03 {
> +                       opp-hz = /bits/ 64 <413000000>;
> +                       opp-microvolt = <887500>;
> +               };
> +               opp04 {
> +                       opp-hz = /bits/ 64 <543000000>;
> +                       opp-microvolt = <937500>;
> +               };
> +               opp05 {
> +                       opp-hz = /bits/ 64 <633000000>;
> +                       opp-microvolt = <1012500>;
> +               };
> +               opp06 {
> +                       opp-hz = /bits/ 64 <728000000>;
> +                       opp-microvolt = <1037500>;
> +               };
> +               opp07 {
> +                       opp-hz = /bits/ 64 <825000000>;
> +                       opp-microvolt = <1050000>;
> +               };
> +       };
> +
> +       samsung_K3QF2F20DB: lpddr3 {
> +               compatible      = "Samsung,K3QF2F20DB", "jedec,lpddr3";
> +               density         = <16384>;
> +               io-width        = <32>;
> +               #address-cells  = <1>;
> +               #size-cells     = <0>;
> +
> +               tRFC-min-tck            = <17>;
> +               tRRD-min-tck            = <2>;
> +               tRPab-min-tck           = <2>;
> +               tRPpb-min-tck           = <2>;
> +               tRCD-min-tck            = <3>;
> +               tRC-min-tck             = <6>;
> +               tRAS-min-tck            = <5>;
> +               tWTR-min-tck            = <2>;
> +               tWR-min-tck             = <7>;
> +               tRTP-min-tck            = <2>;
> +               tW2W-C2C-min-tck        = <0>;
> +               tR2R-C2C-min-tck        = <0>;
> +               tWL-min-tck             = <8>;
> +               tDQSCK-min-tck          = <5>;
> +               tRL-min-tck             = <14>;
> +               tFAW-min-tck            = <5>;
> +               tXSR-min-tck            = <12>;
> +               tXP-min-tck             = <2>;
> +               tCKE-min-tck            = <2>;
> +               tCKESR-min-tck          = <2>;
> +               tMRD-min-tck            = <5>;
> +
> +               timings_samsung_K3QF2F20DB_800mhz: lpddr3-timings@0 {
> +                       compatible      = "jedec,lpddr3-timings";
> +                       reg             = <800000000>; /* workaround: it shows max-freq */

Please be sure that there are no new warnings (make dtbs W=1). This
does not look correct (reg does not match unit address).

Best regards,
Krzysztof
