Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0009D100D4
	for <lists+linux-pm@lfdr.de>; Tue, 30 Apr 2019 22:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbfD3Uay (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Apr 2019 16:30:54 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:46198 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbfD3Uay (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Apr 2019 16:30:54 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190430203052euoutp02967a8f8c7512c33f9fc7f51aa904cc24~aWp04VAil2710927109euoutp02t
        for <linux-pm@vger.kernel.org>; Tue, 30 Apr 2019 20:30:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190430203052euoutp02967a8f8c7512c33f9fc7f51aa904cc24~aWp04VAil2710927109euoutp02t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1556656252;
        bh=s+7+0gQzuRVGQ1sYQI/FifyUVy/Ukm0vhqlGoNpZbE4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=YMMIJsKCbP0vF19vuLaq0NHYh21rati0x/tYSmH7anc8CIBRHwDFnOKs9XXi3bjJE
         NSZyWQOflab515o+AGA6hogO7iq+3pZ3nsxovPUFuZbSR1hNm1za0epedR+ruZeV+0
         /eZxUt26pEXL4P/B1FcwmTI462MMpn0KfpxPHtbc=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190430203050eucas1p279447fcc4b49c05c978bc862818319de~aWpzVdJuA0592805928eucas1p2a;
        Tue, 30 Apr 2019 20:30:50 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 96.25.04298.A70B8CC5; Tue, 30
        Apr 2019 21:30:50 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190430203049eucas1p1e6237ff703eff18318df0d1682887e90~aWpyUWA5s2711627116eucas1p1U;
        Tue, 30 Apr 2019 20:30:49 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190430203049eusmtrp15aa61a999c04915f627bcb2f796f0b46~aWpyEqoWC2495524955eusmtrp1C;
        Tue, 30 Apr 2019 20:30:49 +0000 (GMT)
X-AuditID: cbfec7f2-f2dff700000010ca-d6-5cc8b07a65c6
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 3F.D3.04146.970B8CC5; Tue, 30
        Apr 2019 21:30:49 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190430203048eusmtip241ffce23a4d58e91492c2727321b3036~aWpxV4I-J3151231512eusmtip2U;
        Tue, 30 Apr 2019 20:30:48 +0000 (GMT)
Subject: Re: [PATCH v6 06/10] dt-bindings: memory-controllers: add
 Exynos5422 DMC device description
To:     Chanwoo Choi <cw00.choi@samsung.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        keescook@chromium.org, tony@atomide.com, jroedel@suse.de,
        treding@nvidia.com, digetx@gmail.com, willy.mh.wolff.ml@gmail.com
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <32dfc887-5f67-3d61-08c9-0397d6852811@partner.samsung.com>
Date:   Tue, 30 Apr 2019 22:30:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <babae08b-3ea6-30f4-6a46-85dea0eacd86@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfUxNYRz2nnPuOafWbadb9FsZuqbFKOZj76YJ83Hwj7EZqnHpKKubuqek
        j82tNpGSj5uPGyKs75XkqlSo24eKWypMklWLFKYvWh+4nUz/Pc/ze37v73m2lyUV/TIH9mhg
        iKAJVAUoaUvKUD36cllEfq3X8qcNC/D9q3ky/GbokwynGl/KcPaPLoQv1d0gcMNZNU7q6iOx
        yZTP4Bcx/QxuLrlO48FEI8JXTeUEzjW2M7gtOoPGlf1xMvykZTtuG7PGI7WdaL2CHxm+SPEp
        2iaKL9a3M3xB1hmaT4z9RvPnCrMQ/6A+kh8smLeT3W/p7iMEHD0uaNzWHbT0e2A0kEGJTidu
        1pUQWtTtEI8sWOBWQUJZgSweWbIKLgPBxLPPhESGELx/9oiSyCCCXz9zyH8rrUmlpDRIR1Ca
        NklL5CuCmMxSxuyy5Y6Avscw9ZYddwdBcubYFCG5bALGh3P/nmRZmnOFoqxg84Kc2wK/i9to
        M6a4RVBn+E6Y8WxuL3RU58skjw08v9ZNmVctOA/o/e1olknOHt51pxISng+xD1Om0gF3jYUn
        FwyUFHsT3HukIyRsC19qChkJz4X6SwnTHhG0ibeRhKOgK+nGtGctVNY0TUUmucWQV+ImyRug
        t1FHm2XgrOHtVxspgjVcNFwhJVkOp08pJLcLFCY0TgeYA+k5l5nzSKmf0Us/o4x+Rhn9/7u3
        EJWF7IVQUe0riCsChTBXUaUWQwN9XQ8fUxegv3+wfrJmoAgNvzpUgTgWKa3kLttqvRQy1XEx
        XF2BgCWVdnK+pspLIfdRhUcImmMHNKEBgliBHFlKaS+PnPXRU8H5qkIEf0EIEjT/pgRr4aBF
        +6oa7g2kNZffdYr86OvWVN1ueB600mp+l1wX0RO9O+x1mv+7FvvNzm3+cQPOjMnonrpV8aHR
        w9u9EzGtj8s3Lp+YjHX0a1Eln3dZ2JFj5TRwcHyrTru6LL5yTVG8zZ7R9r5dO3Thcd67GoM9
        nTcuXXqzw2ST8T7qZDSfhqt2/EiepaREP9WKJaRGVP0BD7uVcn8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPIsWRmVeSWpSXmKPExsVy+t/xe7qVG07EGJz8KGmxccZ6VovrX56z
        Wsw/co7VYvXHx4wWk0/NZbI4051r0f/4NbPF+fMb2C3ONr1ht7i8aw6bxefeI4wWM87vY7JY
        e+Quu8XtxhVsFofftLNa7L/iZXH7N5/FtxOPGB2EPL59ncTiMbvhIovHzll32T02repk8+ht
        fsfm0bdlFaPH5tPVHp83yQVwROnZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq
        6dvZpKTmZJalFunbJehlbD6yjbmgV7Fi3qldTA2MT6S6GDk5JARMJK7272HuYuTiEBJYyihx
        +sEqFoiEmMSkfdvZIWxhiT/Xutggil4zSjzffI4JJCEskCZx+eozsAYRgcWMEl9bq0GKmAVW
        M0lM+rgFqmMKk8SKFy2sXYwcHGwCehI7VhWCNPAKuEn833mbDcRmEVCVOLXtPdhQUYEIiTPv
        V7BA1AhKnJz5hAWklVPAXuLlf2mQMLOAmcS8zQ+ZIWxxiVtP5jNB2PISzVtnM09gFJqFpHsW
        kpZZSFpmIWlZwMiyilEktbQ4Nz232FCvODG3uDQvXS85P3cTIzDytx37uXkH46WNwYcYBTgY
        lXh4L7idiBFiTSwrrsw9xCjBwawkwutx/GiMEG9KYmVValF+fFFpTmrxIUZToN8mMkuJJucD
        k1JeSbyhqaG5haWhubG5sZmFkjhvh8DBGCGB9MSS1OzU1ILUIpg+Jg5OqQZGjb4zLzxmztk0
        N+lD6gq9VNG6TZknvK4FrPS9reGxW+BLc0vM2+5Tehu+1h90YJOdvnOeofmNjc+naApIHTTw
        r8/o2aZaeLFjl++361sMJNgknybujd+0cVq2q+qd9/OTktk6w5ofWDer2Vf3hH9Mq2ff/+3L
        mojd3uxHK5Wkmrbe6DeZNumVEktxRqKhFnNRcSIAS6+04xIDAAA=
X-CMS-MailID: 20190430203049eucas1p1e6237ff703eff18318df0d1682887e90
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190419141947eucas1p13a27605e04169ab528ef5bfb385eddbc
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190419141947eucas1p13a27605e04169ab528ef5bfb385eddbc
References: <1555683568-20882-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190419141947eucas1p13a27605e04169ab528ef5bfb385eddbc@eucas1p1.samsung.com>
        <1555683568-20882-7-git-send-email-l.luba@partner.samsung.com>
        <babae08b-3ea6-30f4-6a46-85dea0eacd86@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Chanwoo,

On 4/30/19 6:46 AM, Chanwoo Choi wrote:
> On 19. 4. 19. 오후 11:19, Lukasz Luba wrote:
>> The patch adds description for DT binding for a new Exynos5422 Dynamic
>> Memory Controller device.
>>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   .../bindings/memory-controllers/exynos5422-dmc.txt | 73 ++++++++++++++++++++++
>>   1 file changed, 73 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
>>
>> diff --git a/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt b/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
>> new file mode 100644
>> index 0000000..133b3cc
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
>> @@ -0,0 +1,73 @@
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
>> +- compatible: Should be "samsung,exynos5422-bus".
> 
> As I already mentioned on many times, it is not fixed.
> You have to fix it as following:
> - exynos5422-bus -> exynos5422-dmc
I don't know how I missed it on my list. My apologies.
> 
>> +- clock-names : the name of clock used by the bus, "bus".
> 
> The below examples doesn't contain the 'bus' clock name.
True. Thank you for pointing this out. I will it.

Regards,
Lukasz
> 
>> +- clocks : phandles for clock specified in "clock-names" property.
>> +- devfreq-events : phandles for PPMU devices connected to this DMC.
>> +- vdd-supply : phandle for voltage regulator which is connected.
>> +- reg : registers of two CDREX controllers, chip information, clocks subsystem.
>> +- operating-points-v2 : phandle for OPPs described in v2 definition.
>> +- device-handle : phandle of the connected DRAM memory device. For more
>> +	information please refer to Documentation
>> +- devfreq-events : phandles of the PPMU events used by the controller.
>> +
>> +Example:
>> +
>> +	ppmu_dmc0_0: ppmu@10d00000 {
>> +		compatible = "samsung,exynos-ppmu";
>> +		reg = <0x10d00000 0x2000>;
>> +		clocks = <&clock CLK_PCLK_PPMU_DREX0_0>;
>> +		clock-names = "ppmu";
>> +		status = "okay";
>> +		events {
>> +			ppmu_event_dmc0_0: ppmu-event3-dmc0_0 {
>> +				event-name = "ppmu-event3-dmc0_0";
>> +			};
>> +		};
>> +	};
>> +
>> +	dmc: memory-controller@10c20000 {
>> +		compatible = "samsung,exynos5422-dmc";
>> +		reg = <0x10c20000 0x10000>, <0x10c30000 0x10000>,
>> +			<0x10000000 0x1000>, <0x10030000 0x1000>;
>> +		clocks = 	<&clock CLK_FOUT_SPLL>,
>> +				<&clock CLK_MOUT_SCLK_SPLL>,
>> +				<&clock CLK_FF_DOUT_SPLL2>,
>> +				<&clock CLK_FOUT_BPLL>,
>> +				<&clock CLK_MOUT_BPLL>,
>> +				<&clock CLK_SCLK_BPLL>,
>> +				<&clock CLK_MOUT_MX_MSPLL_CCORE>,
>> +				<&clock CLK_MOUT_MX_MSPLL_CCORE_PHY>,
>> +				<&clock CLK_MOUT_MCLK_CDREX>,
>> +				<&clock CLK_DOUT_CLK2X_PHY0>,
>> +				<&clock CLK_CLKM_PHY0>,
>> +				<&clock CLK_CLKM_PHY1>;
>> +		clock-names =	"fout_spll",
>> +				"mout_sclk_spll",
>> +				"ff_dout_spll2",
>> +				"fout_bpll",
>> +				"mout_bpll",
>> +				"sclk_bpll",
>> +				"mout_mx_mspll_ccore",
>> +				"mout_mx_mspll_ccore_phy",
>> +				"mout_mclk_cdrex",
>> +				"dout_clk2x_phy0",
>> +				"clkm_phy0",
>> +			        "clkm_phy1";
>> +		status = "okay";
>> +		operating-points-v2 = <&dmc_opp_table>;
>> +		devfreq-events = <&ppmu_event3_dmc0_0>,	<&ppmu_event3_dmc0_1>,
>> +				<&ppmu_event3_dmc1_0>, <&ppmu_event3_dmc1_1>;
>> +		operating-points-v2 = <&dmc_opp_table>;
>> +		device-handle = <&samsung_K3QF2F20DB>;
>> +		vdd-supply = <&buck1_reg>;
>> +	};
>>
> 
> 
