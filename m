Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3993C36EAA
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2019 10:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfFFI37 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Jun 2019 04:29:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:34502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbfFFI37 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 6 Jun 2019 04:29:59 -0400
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 653E420872;
        Thu,  6 Jun 2019 08:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559809797;
        bh=ESeaKWLmpng3Q+aBMJkSJpHbp1Q/R2v4Qfz1ZOHm59o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=x9R2XeSmj0RxSVJrxG06per4Q4E/B42sZuKBfMBYKb0C3wnqBFLjltp02lP7WLnZ7
         hjcAUZreGW0UznvPtDNZJTJ1Q+wjp6oCDJsDKJPyZm2ziGcyU9oZHIDPP8ASZIJKy8
         4vVJ2mgsERIMnB0c7zxXW/zpUv9aNJNhrDymvsfc=
Received: by mail-lf1-f44.google.com with SMTP id 136so897075lfa.8;
        Thu, 06 Jun 2019 01:29:57 -0700 (PDT)
X-Gm-Message-State: APjAAAXDQR5tc61eZvHiNS6psdXb2SR6qnbRnuahVme7Kwh5pFXIuChg
        CFUY02LE1K2fYWKSrfaRPrfH8WzrV9UhmGzmSjc=
X-Google-Smtp-Source: APXvYqymdIkWpecNwmxAyH50GinjhOiyhS6qt2bWxoVqqnSWRehZB24PEim8kWmV0V0gLE4yV7FLcVSzw8vFnVCmzfE=
X-Received: by 2002:a19:4f50:: with SMTP id a16mr22487584lfk.24.1559809795620;
 Thu, 06 Jun 2019 01:29:55 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190605165433eucas1p1214f65106df03ae74bbdc95e3eee71f1@eucas1p1.samsung.com>
 <20190605165410.14606-1-l.luba@partner.samsung.com> <20190605165410.14606-8-l.luba@partner.samsung.com>
In-Reply-To: <20190605165410.14606-8-l.luba@partner.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 6 Jun 2019 10:29:44 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdg9Fr2Y16RJ4gbRnL6PiyWw2J3e46ybkRWTKOEd28GJA@mail.gmail.com>
Message-ID: <CAJKOXPdg9Fr2Y16RJ4gbRnL6PiyWw2J3e46ybkRWTKOEd28GJA@mail.gmail.com>
Subject: Re: [PATCH v8 07/13] dt-bindings: memory-controllers: add Exynos5422
 DMC device description
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

On Wed, 5 Jun 2019 at 18:54, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
> The patch adds description for DT binding for a new Exynos5422 Dynamic
> Memory Controller device.
>
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  .../memory-controllers/exynos5422-dmc.txt     | 84 +++++++++++++++++++
>  1 file changed, 84 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
>
> diff --git a/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt b/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
> new file mode 100644
> index 000000000000..989ee0839fdf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
> @@ -0,0 +1,84 @@
> +* Exynos5422 frequency and voltage scaling for Dynamic Memory Controller device
> +
> +The Samsung Exynos5422 SoC has DMC (Dynamic Memory Controller) to which the DRAM
> +memory chips are connected. The driver is to monitor the controller in runtime
> +and switch frequency and voltage. To monitor the usage of the controller in
> +runtime, the driver uses the PPMU (Platform Performance Monitoring Unit), which
> +is able to measure the current load of the memory.
> +When 'userspace' governor is used for the driver, an application is able to
> +switch the DMC and memory frequency.
> +
> +Required properties for DMC device for Exynos5422:
> +- compatible: Should be "samsung,exynos5422-dmc".
> +- clocks : list of clock specifiers, must contain an entry for each
> +  required entry in clock-names for CLK_FOUT_SPLL, CLK_MOUT_SCLK_SPLL,
> +  CLK_FF_DOUT_SPLL2, CLK_FOUT_BPLL, CLK_MOUT_BPLL, CLK_SCLK_BPLL,
> +  CLK_MOUT_MX_MSPLL_CCORE, CLK_MOUT_MX_MSPLL_CCORE_PHY, CLK_MOUT_MCLK_CDREX,
> +  CLK_DOUT_CLK2X_PHY0, CLK_CLKM_PHY0, CLK_CLKM_PHY1
> +- clock-names : should include "fout_spll", "mout_sclk_spll", "ff_dout_spll2",
> +  "fout_bpll", "mout_bpll", "sclk_bpll", "mout_mx_mspll_ccore",
> +  "mout_mx_mspll_ccore_phy", "mout_mclk_cdrex", "dout_clk2x_phy0", "clkm_phy0",
> +  "clkm_phy1" entries
> +- devfreq-events : phandles for PPMU devices connected to this DMC.
> +- vdd-supply : phandle for voltage regulator which is connected.
> +- reg : registers of two CDREX controllers.
> +- operating-points-v2 : phandle for OPPs described in v2 definition.
> +- device-handle : phandle of the connected DRAM memory device. For more
> +       information please refer to documentation file:
> +       Documentation/devicetree/bindings/ddr/lpddr3.txt
> +- devfreq-events : phandles of the PPMU events used by the controller.
> +- samsung,syscon-clk : phandle of the clock register set used by the controller,
> +       these registers are used for enabling a 'pause' feature and are not
> +       exposed by clock framework but they must be used in a safe way.
> +       The register offsets are in the driver code and specyfic for this SoC
> +       type.
> +
> +Example:
> +
> +       ppmu_dmc0_0: ppmu@10d00000 {
> +               compatible = "samsung,exynos-ppmu";
> +               reg = <0x10d00000 0x2000>;
> +               clocks = <&clock CLK_PCLK_PPMU_DREX0_0>;
> +               clock-names = "ppmu";
> +               events {
> +                       ppmu_event_dmc0_0: ppmu-event3-dmc0_0 {
> +                               event-name = "ppmu-event3-dmc0_0";
> +                       };
> +               };
> +       };
> +
> +       dmc: memory-controller@10c20000 {
> +               compatible = "samsung,exynos5422-dmc";
> +               reg = <0x10c20000 0x100>, <0x10c30000 0x100>,
> +               clocks =        <&clock CLK_FOUT_SPLL>,

I think you should not have tab after '='. Instead align consecutive
lines with the first one.

> +                               <&clock CLK_MOUT_SCLK_SPLL>,
> +                               <&clock CLK_FF_DOUT_SPLL2>,
> +                               <&clock CLK_FOUT_BPLL>,
> +                               <&clock CLK_MOUT_BPLL>,
> +                               <&clock CLK_SCLK_BPLL>,
> +                               <&clock CLK_MOUT_MX_MSPLL_CCORE>,
> +                               <&clock CLK_MOUT_MX_MSPLL_CCORE_PHY>,
> +                               <&clock CLK_MOUT_MCLK_CDREX>,
> +                               <&clock CLK_DOUT_CLK2X_PHY0>,
> +                               <&clock CLK_CLKM_PHY0>,
> +                               <&clock CLK_CLKM_PHY1>;
> +               clock-names =   "fout_spll",
> +                               "mout_sclk_spll",
> +                               "ff_dout_spll2",
> +                               "fout_bpll",
> +                               "mout_bpll",
> +                               "sclk_bpll",
> +                               "mout_mx_mspll_ccore",
> +                               "mout_mx_mspll_ccore_phy",
> +                               "mout_mclk_cdrex",
> +                               "dout_clk2x_phy0",
> +                               "clkm_phy0",
> +                               "clkm_phy1";
> +               operating-points-v2 = <&dmc_opp_table>;
> +               devfreq-events = <&ppmu_event3_dmc0_0>, <&ppmu_event3_dmc0_1>,
> +                               <&ppmu_event3_dmc1_0>, <&ppmu_event3_dmc1_1>;
> +               operating-points-v2 = <&dmc_opp_table>;

Duplicated property.

Beside that:
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

> +               device-handle = <&samsung_K3QF2F20DB>;
> +               vdd-supply = <&buck1_reg>;
> +               samsung,syscon-clk = <&clock>;
> +       };
> --
> 2.17.1
>
