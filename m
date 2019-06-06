Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF50F37170
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2019 12:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbfFFKPk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Jun 2019 06:15:40 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:37166 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727806AbfFFKPj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Jun 2019 06:15:39 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190606101537euoutp02fd0cf7332761727945544d881784f464~llINE1WT41101511015euoutp02t
        for <linux-pm@vger.kernel.org>; Thu,  6 Jun 2019 10:15:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190606101537euoutp02fd0cf7332761727945544d881784f464~llINE1WT41101511015euoutp02t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1559816137;
        bh=Th+Wb3JBdg1A91JI1PUt45rRFl0hBweF8x0+BS/sqeU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=E+Fnh9I2uJ3oaIEcYI9wd3QYTHXq0Ce2DFLPfjyfBR/Ca34uXZaZZnTPEZSe3dxFP
         JUweQ6sM767npZ5x10xLp5unPnFuFjnqyc1z65RX8LQ5k6MxXWRIcW1+gs2EsTOOLb
         /PI/JiPR4fFZTlNzptpU/Q+5rUPUb1xcH2gt4bnc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190606101536eucas1p2195d953b684e076f4ddbedd62833804e~llIMIkG8_1123511235eucas1p2n;
        Thu,  6 Jun 2019 10:15:36 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 16.D7.04377.8C7E8FC5; Thu,  6
        Jun 2019 11:15:36 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190606101535eucas1p1c40dc8dc803aa258abae3ef7d7fbd105~llILTHyXI2397023970eucas1p1s;
        Thu,  6 Jun 2019 10:15:35 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190606101535eusmtrp28731c7bb25a15e0fdf988d5fdfdb824b~llILDMb581392513925eusmtrp2b;
        Thu,  6 Jun 2019 10:15:35 +0000 (GMT)
X-AuditID: cbfec7f4-12dff70000001119-ad-5cf8e7c82608
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 04.59.04146.6C7E8FC5; Thu,  6
        Jun 2019 11:15:35 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190606101534eusmtip2df6566623252a4bcbe9231e2e9775aa7~llIJ5zpTa0368603686eusmtip2X;
        Thu,  6 Jun 2019 10:15:34 +0000 (GMT)
Subject: Re: [PATCH v8 07/13] dt-bindings: memory-controllers: add
 Exynos5422 DMC device description
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
Message-ID: <658d4f9a-633e-e64f-ea10-fbf9e758b80e@partner.samsung.com>
Date:   Thu, 6 Jun 2019 12:15:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAJKOXPdg9Fr2Y16RJ4gbRnL6PiyWw2J3e46ybkRWTKOEd28GJA@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfUzMcRz2vd/L/Tru+rmiz8rQzQybSqN9jaFFbv1h+ivRcK5fMd2V+3UR
        NmGSUlleqlMqjXIcdZq6kO26SfRyJkJrTHmrDr1I5iXd/a7pv+f5fJ7P93me7csQ8n7Kl9mj
        TeZ0WlWCgpaQdx7+bFv66ONYTFDtoARXF9yicOfIRwqX2NoofH2wB+Gzj4tFuCVLg3N7+gnc
        3l4lxq3HBsT4WX0RjYezbQgXtDeIsMnWLcZdRytp3DhwksIPOiJw1y8ZHn30Dq2TK0e/55HK
        i2lPSaXF0C1Wmo2naGX28S+0MqfGiJS3nxxSDpvnbma2SlbHcgl7Ujhd4Jqdkt0Wm5lKsgYe
        eN+dLUpDr+ZnIg8G2OUw1H1enIkkjJytRPB1YNRNRhA020yEQIYR5N97Q06eGMoHkbCoQJD1
        zUQJxIHAXn6Ccqq82DgwfL5MO7E3uxg6//xwiQi2moTauvoJE4ah2QCoM+5zaqRsOJiGGlx6
        kl0AxT2fXG6z2C0wYjEjQTMTmgt7XXMPNhKeX7rqwgTrA697S0QCnge1jiJXbGALGeg750BC
        7PXQYnW4K3hBX1ONWMBzYNwiHAPLQ1p2mVt/GHpyi92aVdDY9JRyZiYmytyqD3RCYEMh4xMt
        QBm8dMwUEsgg704+IYylkJEuF95YBDWn7W6f2VBx44L4DFIYpvQyTOlimNLF8N+2FJFG5MPp
        eU08xwdruf0BvErD67XxAepEjRlNfMEnf5tG6lD9711WxDJIMUMK1T9i5JQqhU/VWBEwhMJb
        mmIfi5FLY1WpBzld4g6dPoHjrciPIRU+0kPT3m6Ts/GqZG4vxyVxusmtiPHwTUPTS8yOyOBf
        ga3Wloq4c7G7PGVVUV+D1NfKh/z5cPmGh22mELW+Kq7L6Bt1N798ehi9Vnbf54onsvv1fYgc
        Pf9lLP1oZf/ZhpthG2X+hdz4i4qOxwsjtKj37abo1Kj8Qc6u/r44IGSWYuV2S6j+SGpy9IrS
        Z1U54WWONx0hOxn1PAXJ71YtW0LoeNU//968fH4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHIsWRmVeSWpSXmKPExsVy+t/xe7rHn/+IMXg5k9Fi44z1rBbXvzxn
        tZh/5ByrxeqPjxktJp+ay2RxpjvXov/xa2aL8+c3sFucbXrDbnF51xw2i8+9RxgtZpzfx2Sx
        9shddovbjSvYLA6/aWe12H/Fy+L2bz6LbyceMToIeXz7OonFY3bDRRaPnbPusntsWtXJ5tHb
        /I7No2/LKkaPzaerPT5vkgvgiNKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV
        0rezSUnNySxLLdK3S9DL2HlkE2vBIf2Kp3d7mRoYbyp0MXJySAiYSMxa/JERxBYSWMoo8WKz
        JERcTGLSvu3sELawxJ9rXWxdjFxANa8ZJfbNu83axcjBISyQJrH3Lli9iICmxPW/31lBapgF
        NrJIXHzVywTRMIFJ4t7uM8wgDWwCehI7VhWCNPAKuEms/bSPDcRmEVCRmPv4BQuILSoQITF7
        VwMLRI2gxMmZT8BsToFAiavzloHZzAJmEvM2P2SGsMUlbj2ZzwRhy0tsfzuHeQKj0Cwk7bOQ
        tMxC0jILScsCRpZVjCKppcW56bnFhnrFibnFpXnpesn5uZsYgXG/7djPzTsYL20MPsQowMGo
        xMMrsfF7jBBrYllxZe4hRgkOZiUR3rILP2KEeFMSK6tSi/Lji0pzUosPMZoCPTeRWUo0OR+Y
        kvJK4g1NDc0tLA3Njc2NzSyUxHk7BA7GCAmkJ5akZqemFqQWwfQxcXBKNTAGfHa6mJTvwyhd
        lu0m/mLK5Gt+n/gecZ+Qv9AY5Bi1enqp95u9z9c5d3RbrpU8fyt8pWDjp01Ox9y+Nvk+2L0i
        2+qZR8bmXv5I0293WRN58pMn2ix0ediar7qnJUDkctDaDKkeDp5bf0QCnRNPrZmW9zxNqJ5l
        37aouWJPPVT85qWePf1+urkSS3FGoqEWc1FxIgCLsk2sEQMAAA==
X-CMS-MailID: 20190606101535eucas1p1c40dc8dc803aa258abae3ef7d7fbd105
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190605165433eucas1p1214f65106df03ae74bbdc95e3eee71f1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190605165433eucas1p1214f65106df03ae74bbdc95e3eee71f1
References: <CGME20190605165433eucas1p1214f65106df03ae74bbdc95e3eee71f1@eucas1p1.samsung.com>
        <20190605165410.14606-1-l.luba@partner.samsung.com>
        <20190605165410.14606-8-l.luba@partner.samsung.com>
        <CAJKOXPdg9Fr2Y16RJ4gbRnL6PiyWw2J3e46ybkRWTKOEd28GJA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Krzysztof,

On 6/6/19 10:29 AM, Krzysztof Kozlowski wrote:
> On Wed, 5 Jun 2019 at 18:54, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>>
>> The patch adds description for DT binding for a new Exynos5422 Dynamic
>> Memory Controller device.
>>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   .../memory-controllers/exynos5422-dmc.txt     | 84 +++++++++++++++++++
>>   1 file changed, 84 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
>>
>> diff --git a/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt b/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
>> new file mode 100644
>> index 000000000000..989ee0839fdf
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
>> @@ -0,0 +1,84 @@
>> +* Exynos5422 frequency and voltage scaling for Dynamic Memory Controller device
>> +
>> +The Samsung Exynos5422 SoC has DMC (Dynamic Memory Controller) to which the DRAM
>> +memory chips are connected. The driver is to monitor the controller in runtime
>> +and switch frequency and voltage. To monitor the usage of the controller in
>> +runtime, the driver uses the PPMU (Platform Performance Monitoring Unit), which
>> +is able to measure the current load of the memory.
>> +When 'userspace' governor is used for the driver, an application is able to
>> +switch the DMC and memory frequency.
>> +
>> +Required properties for DMC device for Exynos5422:
>> +- compatible: Should be "samsung,exynos5422-dmc".
>> +- clocks : list of clock specifiers, must contain an entry for each
>> +  required entry in clock-names for CLK_FOUT_SPLL, CLK_MOUT_SCLK_SPLL,
>> +  CLK_FF_DOUT_SPLL2, CLK_FOUT_BPLL, CLK_MOUT_BPLL, CLK_SCLK_BPLL,
>> +  CLK_MOUT_MX_MSPLL_CCORE, CLK_MOUT_MX_MSPLL_CCORE_PHY, CLK_MOUT_MCLK_CDREX,
>> +  CLK_DOUT_CLK2X_PHY0, CLK_CLKM_PHY0, CLK_CLKM_PHY1
>> +- clock-names : should include "fout_spll", "mout_sclk_spll", "ff_dout_spll2",
>> +  "fout_bpll", "mout_bpll", "sclk_bpll", "mout_mx_mspll_ccore",
>> +  "mout_mx_mspll_ccore_phy", "mout_mclk_cdrex", "dout_clk2x_phy0", "clkm_phy0",
>> +  "clkm_phy1" entries
>> +- devfreq-events : phandles for PPMU devices connected to this DMC.
>> +- vdd-supply : phandle for voltage regulator which is connected.
>> +- reg : registers of two CDREX controllers.
>> +- operating-points-v2 : phandle for OPPs described in v2 definition.
>> +- device-handle : phandle of the connected DRAM memory device. For more
>> +       information please refer to documentation file:
>> +       Documentation/devicetree/bindings/ddr/lpddr3.txt
>> +- devfreq-events : phandles of the PPMU events used by the controller.
>> +- samsung,syscon-clk : phandle of the clock register set used by the controller,
>> +       these registers are used for enabling a 'pause' feature and are not
>> +       exposed by clock framework but they must be used in a safe way.
>> +       The register offsets are in the driver code and specyfic for this SoC
>> +       type.
>> +
>> +Example:
>> +
>> +       ppmu_dmc0_0: ppmu@10d00000 {
>> +               compatible = "samsung,exynos-ppmu";
>> +               reg = <0x10d00000 0x2000>;
>> +               clocks = <&clock CLK_PCLK_PPMU_DREX0_0>;
>> +               clock-names = "ppmu";
>> +               events {
>> +                       ppmu_event_dmc0_0: ppmu-event3-dmc0_0 {
>> +                               event-name = "ppmu-event3-dmc0_0";
>> +                       };
>> +               };
>> +       };
>> +
>> +       dmc: memory-controller@10c20000 {
>> +               compatible = "samsung,exynos5422-dmc";
>> +               reg = <0x10c20000 0x100>, <0x10c30000 0x100>,
>> +               clocks =        <&clock CLK_FOUT_SPLL>,
> 
> I think you should not have tab after '='. Instead align consecutive
> lines with the first one.
I will change it, since there is a need of removing the duplicates below
> 
>> +                               <&clock CLK_MOUT_SCLK_SPLL>,
>> +                               <&clock CLK_FF_DOUT_SPLL2>,
>> +                               <&clock CLK_FOUT_BPLL>,
>> +                               <&clock CLK_MOUT_BPLL>,
>> +                               <&clock CLK_SCLK_BPLL>,
>> +                               <&clock CLK_MOUT_MX_MSPLL_CCORE>,
>> +                               <&clock CLK_MOUT_MX_MSPLL_CCORE_PHY>,
>> +                               <&clock CLK_MOUT_MCLK_CDREX>,
>> +                               <&clock CLK_DOUT_CLK2X_PHY0>,
>> +                               <&clock CLK_CLKM_PHY0>,
>> +                               <&clock CLK_CLKM_PHY1>;
>> +               clock-names =   "fout_spll",
>> +                               "mout_sclk_spll",
>> +                               "ff_dout_spll2",
>> +                               "fout_bpll",
>> +                               "mout_bpll",
>> +                               "sclk_bpll",
>> +                               "mout_mx_mspll_ccore",
>> +                               "mout_mx_mspll_ccore_phy",
>> +                               "mout_mclk_cdrex",
>> +                               "dout_clk2x_phy0",
>> +                               "clkm_phy0",
>> +                               "clkm_phy1";
>> +               operating-points-v2 = <&dmc_opp_table>;
>> +               devfreq-events = <&ppmu_event3_dmc0_0>, <&ppmu_event3_dmc0_1>,
>> +                               <&ppmu_event3_dmc1_0>, <&ppmu_event3_dmc1_1>;
>> +               operating-points-v2 = <&dmc_opp_table>;
> 
> Duplicated property.
Right, I will remove it and re-send it.
> 
> Beside that:
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Thank you

Regards,
Lukasz
> 
> Best regards,
> Krzysztof
> 
>> +               device-handle = <&samsung_K3QF2F20DB>;
>> +               vdd-supply = <&buck1_reg>;
>> +               samsung,syscon-clk = <&clock>;
>> +       };
>> --
>> 2.17.1
>>
> 
> 
