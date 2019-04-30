Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B689BEFB6
	for <lists+linux-pm@lfdr.de>; Tue, 30 Apr 2019 06:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725788AbfD3EpP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Apr 2019 00:45:15 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:41778 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfD3EpP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Apr 2019 00:45:15 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190430044511epoutp0235226180978cb5384875846d41180b55~aJwIrdnBh1375213752epoutp02H
        for <linux-pm@vger.kernel.org>; Tue, 30 Apr 2019 04:45:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190430044511epoutp0235226180978cb5384875846d41180b55~aJwIrdnBh1375213752epoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1556599511;
        bh=iLtmpVoztHGHt8Xumpmublav2Pa49uLZOMWWUpLkWwg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=UZc/y0oObrRYS6wtNjgcdhNtgs6foULG2w9FiqcEj/0fEq91pbhM4MwsmatyrPKLJ
         AIACessyWWSPPQUIs/Su3KUNg8KDWbvxx4h/Nxo5/Npt6B1Un0I9YDy0lg93QgLsbH
         Pe1yU6Qyv/52NycZRMHIt4xqvyWzcSV8Xj99zCvs=
Received: from epsmges1p5.samsung.com (unknown [182.195.40.154]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190430044506epcas1p1dd0d0bb4b2dc94e7e24ffc613fe10d71~aJwEGxBA61614616146epcas1p1U;
        Tue, 30 Apr 2019 04:45:06 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        4F.F8.04108.0D2D7CC5; Tue, 30 Apr 2019 13:45:04 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190430044503epcas1p185cd2dcb2c6531565224bcab5c34a01f~aJwBXcrLA2935429354epcas1p1P;
        Tue, 30 Apr 2019 04:45:03 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190430044503epsmtrp21a4dc724d7070e700c38fb0ff8e65038~aJwBWfPUh0204202042epsmtrp2I;
        Tue, 30 Apr 2019 04:45:03 +0000 (GMT)
X-AuditID: b6c32a39-8b7ff7000000100c-5d-5cc7d2d044c5
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        33.00.03692.FC2D7CC5; Tue, 30 Apr 2019 13:45:03 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190430044502epsmtip2dc62d609fa591c63dcc2f314fd5215ac~aJwAV2KzV2453724537epsmtip2Z;
        Tue, 30 Apr 2019 04:45:02 +0000 (GMT)
Subject: Re: [PATCH v6 06/10] dt-bindings: memory-controllers: add
 Exynos5422 DMC device description
To:     Lukasz Luba <l.luba@partner.samsung.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        keescook@chromium.org, tony@atomide.com, jroedel@suse.de,
        treding@nvidia.com, digetx@gmail.com, willy.mh.wolff.ml@gmail.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <babae08b-3ea6-30f4-6a46-85dea0eacd86@samsung.com>
Date:   Tue, 30 Apr 2019 13:46:17 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1555683568-20882-7-git-send-email-l.luba@partner.samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDJsWRmVeSWpSXmKPExsWy7bCmge6FS8djDPavZ7XYOANIzD9yjtVi
        9cfHjBaTT81lsjjTnWvR//g1s8X58xvYLc42vWG3uNUgY3F51xw2i8+9RxgtZpzfx2Sx9shd
        dovbjSvYLA6/aWe12H/Fy+L2bz6LbyceMToIeXz7OonFY3bDRRaPnbPusntsWtXJ5tHb/I7N
        4+C7PUwefVtWMXpsPl3t8XmTXABnVLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWF
        uZJCXmJuqq2Si0+ArltmDtAzSgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwCywK9
        4sTc4tK8dL3k/FwrQwMDI1OgwoTsjDvne5kK5slXXL7dzNjAOF+yi5GTQ0LARGLjqlusXYxc
        HEICOxglOr69YYdwPjFK/L/8jgXC+cYosWbhJcYuRg6wlpOrgyHiexklLq1YA9XxnlFi977D
        TCBzhQXSJGY928YEkhARWM4osW/qXUYQh1lgNZPEn69rWUGq2AS0JPa/uMEGYvMLKEpc/fGY
        EcTmFbCT2HO1ix1kHYuAqsSig1kgYVGBCIn7xzawQpQISpyc+YQFxOYU8JboOtIGNoZZQFzi
        1pP5TBC2vETz1tnMIHslBG6xS3zpWcsE8bWLxPQbU1ggbGGJV8e3sEPYUhKf3+1lg7CrJVae
        PMIG0dzBKLFl/wVWiISxxP6lk5lAjmMW0JRYv0sfYhmfxLuvPayQIOKV6GgTgqhWlrj84C7U
        WkmJxe2dUOM9JN4uPs06gVFxFpJ3ZiF5YRaSF2YhLFvAyLKKUSy1oDg3PbXYsMAUObo3MYJT
        upblDsZj53wOMQpwMCrx8Hq8OxYjxJpYVlyZe4hRgoNZSYTX4/jRGCHelMTKqtSi/Pii0pzU
        4kOMpsDAnsgsJZqcD8w3eSXxhqZGxsbGFiaGZqaGhkrivOsdnGOEBNITS1KzU1MLUotg+pg4
        OKUaGPtP/fvXn/33V8T32CfFJ1hmec5P5fgvtHfxzlDZI/wr5yVJ+QlsN7i5+SmfINOJ22pB
        KiU7lk4518TLVDjxvmuXbcPlT2vkH6om2Z4wm7uP8WCurtuZ1CcB6wXf+qS7u5V0K06zyc7c
        qFZX+edGd8L8cFbFUD6HSiauOOmJE5Y6HV+wMiF6gxJLcUaioRZzUXEiAMwyW7H/AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGIsWRmVeSWpSXmKPExsWy7bCSvO75S8djDLZ9lrPYOGM9q8X8I+dY
        LVZ/fMxoMfnUXCaLM925Fv2PXzNbnD+/gd3ibNMbdotbDTIWl3fNYbP43HuE0WLG+X1MFmuP
        3GW3uN24gs3i8Jt2Vov9V7wsbv/ms/h24hGjg5DHt6+TWDxmN1xk8dg56y67x6ZVnWwevc3v
        2DwOvtvD5NG3ZRWjx+bT1R6fN8kFcEZx2aSk5mSWpRbp2yVwZdw538tUME++4vLtZsYGxvmS
        XYwcHBICJhInVwd3MXJxCAnsZpR4cXoCcxcjJ1BcUmLaxaPMEDXCEocPF0PUvGWUeDJvHytI
        jbBAmsTlq89YQBIiAssZJeb+XQrmMAusZpKY9HELG0TLfUaJ248mgo1lE9CS2P/iBhuIzS+g
        KHH1x2NGEJtXwE5iz9UudpB1LAKqEosOZoGERQUiJM68X8ECUSIocXLmEzCbU8BboutIG9gY
        ZgF1iT/zLjFD2OISt57MZ4Kw5SWat85mnsAoPAtJ+ywkLbOQtMxC0rKAkWUVo2RqQXFuem6x
        YYFhXmq5XnFibnFpXrpecn7uJkZwbGtp7mC8vCT+EKMAB6MSD6/Hu2MxQqyJZcWVuYcYJTiY
        lUR4PY4fjRHiTUmsrEotyo8vKs1JLT7EKM3BoiTO+zTvWKSQQHpiSWp2ampBahFMlomDU6qB
        kfM0M/u6EN5nOkYhhyxre/5UFgoc1rFVq7L2iKrpttRXKTHWCBVprtvfsDKTn+fA0Wvz6i+J
        Lt67PvLfxSjbV2faw3Z9b3s8K2tj0z7f79MWMnx+NOH87gxp/c1dYosqT62TesZftm6zXNS3
        btGT9hvMapr/HTu2s/x/lmK5iuD0ixypF86WK7EUZyQaajEXFScCALJjUMTpAgAA
X-CMS-MailID: 20190430044503epcas1p185cd2dcb2c6531565224bcab5c34a01f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190419141947eucas1p13a27605e04169ab528ef5bfb385eddbc
References: <1555683568-20882-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190419141947eucas1p13a27605e04169ab528ef5bfb385eddbc@eucas1p1.samsung.com>
        <1555683568-20882-7-git-send-email-l.luba@partner.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 4. 19. 오후 11:19, Lukasz Luba wrote:
> The patch adds description for DT binding for a new Exynos5422 Dynamic
> Memory Controller device.
> 
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  .../bindings/memory-controllers/exynos5422-dmc.txt | 73 ++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt b/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
> new file mode 100644
> index 0000000..133b3cc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
> @@ -0,0 +1,73 @@
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
> +- compatible: Should be "samsung,exynos5422-bus".

As I already mentioned on many times, it is not fixed.
You have to fix it as following:
- exynos5422-bus -> exynos5422-dmc

> +- clock-names : the name of clock used by the bus, "bus".

The below examples doesn't contain the 'bus' clock name.

> +- clocks : phandles for clock specified in "clock-names" property.
> +- devfreq-events : phandles for PPMU devices connected to this DMC.
> +- vdd-supply : phandle for voltage regulator which is connected.
> +- reg : registers of two CDREX controllers, chip information, clocks subsystem.
> +- operating-points-v2 : phandle for OPPs described in v2 definition.
> +- device-handle : phandle of the connected DRAM memory device. For more
> +	information please refer to Documentation
> +- devfreq-events : phandles of the PPMU events used by the controller.
> +
> +Example:
> +
> +	ppmu_dmc0_0: ppmu@10d00000 {
> +		compatible = "samsung,exynos-ppmu";
> +		reg = <0x10d00000 0x2000>;
> +		clocks = <&clock CLK_PCLK_PPMU_DREX0_0>;
> +		clock-names = "ppmu";
> +		status = "okay";
> +		events {
> +			ppmu_event_dmc0_0: ppmu-event3-dmc0_0 {
> +				event-name = "ppmu-event3-dmc0_0";
> +			};
> +		};
> +	};
> +
> +	dmc: memory-controller@10c20000 {
> +		compatible = "samsung,exynos5422-dmc";
> +		reg = <0x10c20000 0x10000>, <0x10c30000 0x10000>,
> +			<0x10000000 0x1000>, <0x10030000 0x1000>;
> +		clocks = 	<&clock CLK_FOUT_SPLL>,
> +				<&clock CLK_MOUT_SCLK_SPLL>,
> +				<&clock CLK_FF_DOUT_SPLL2>,
> +				<&clock CLK_FOUT_BPLL>,
> +				<&clock CLK_MOUT_BPLL>,
> +				<&clock CLK_SCLK_BPLL>,
> +				<&clock CLK_MOUT_MX_MSPLL_CCORE>,
> +				<&clock CLK_MOUT_MX_MSPLL_CCORE_PHY>,
> +				<&clock CLK_MOUT_MCLK_CDREX>,
> +				<&clock CLK_DOUT_CLK2X_PHY0>,
> +				<&clock CLK_CLKM_PHY0>,
> +				<&clock CLK_CLKM_PHY1>;
> +		clock-names =	"fout_spll",
> +				"mout_sclk_spll",
> +				"ff_dout_spll2",
> +				"fout_bpll",
> +				"mout_bpll",
> +				"sclk_bpll",
> +				"mout_mx_mspll_ccore",
> +				"mout_mx_mspll_ccore_phy",
> +				"mout_mclk_cdrex",
> +				"dout_clk2x_phy0",
> +				"clkm_phy0",
> +			        "clkm_phy1";
> +		status = "okay";
> +		operating-points-v2 = <&dmc_opp_table>;
> +		devfreq-events = <&ppmu_event3_dmc0_0>,	<&ppmu_event3_dmc0_1>,
> +				<&ppmu_event3_dmc1_0>, <&ppmu_event3_dmc1_1>;
> +		operating-points-v2 = <&dmc_opp_table>;
> +		device-handle = <&samsung_K3QF2F20DB>;
> +		vdd-supply = <&buck1_reg>;
> +	};
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
