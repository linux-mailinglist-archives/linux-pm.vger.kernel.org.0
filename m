Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66A17174DA
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2019 11:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfEHJRh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 May 2019 05:17:37 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:50321 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbfEHJRg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 May 2019 05:17:36 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190508091734euoutp01752b0f2ae1403f64f6c1d4b3f58824b4~cqoPvcVPJ2157321573euoutp01C
        for <linux-pm@vger.kernel.org>; Wed,  8 May 2019 09:17:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190508091734euoutp01752b0f2ae1403f64f6c1d4b3f58824b4~cqoPvcVPJ2157321573euoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1557307054;
        bh=7tBkm4ZtupatdeJAm08/bLQ2G9rQyH25ePfOtf7iIms=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=INDpxIdwtQrw9uk2mQLNO8Dm7G5mi60bbKneFh58YF1vB7nssHx/IEf+lGPwO7V/2
         PBWES5ThBkvLoZmVZ6ufPl/hC/US+dE2yNMdqpsL35j0yQZgWhCDdNDFsGAgVlrYFC
         Vxl2Y2ZjzDgM4lE9a422r4bjGvG4l63zsug632pU=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190508091733eucas1p24c03e56cdbdb8fe30d3509b04a94f975~cqoOy1isp0746207462eucas1p2g;
        Wed,  8 May 2019 09:17:33 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id FE.86.04325.DAE92DC5; Wed,  8
        May 2019 10:17:33 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190508091732eucas1p157ea16882d06a949ac3ca7e401254e4c~cqoN3MYQ-0568605686eucas1p1N;
        Wed,  8 May 2019 09:17:32 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190508091732eusmtrp261ff770e5e358e93647d59bb1812443e~cqoNo6_Ch0062100621eusmtrp2V;
        Wed,  8 May 2019 09:17:32 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-83-5cd29ead5f34
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id F6.03.04140.CAE92DC5; Wed,  8
        May 2019 10:17:32 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190508091731eusmtip1b4b3fb389cc4ca1dbd0962761eb0a285~cqoMpYRy30741107411eusmtip19;
        Wed,  8 May 2019 09:17:31 +0000 (GMT)
Subject: Re: [PATCH v7 07/13] dt-bindings: memory-controllers: add
 Exynos5422 DMC device description
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, keescook@chromium.org, tony@atomide.com,
        jroedel@suse.de, treding@nvidia.com, digetx@gmail.com,
        willy.mh.wolff.ml@gmail.com
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <fdcbad67-65c8-36f4-1473-e2c46ccc431a@partner.samsung.com>
Date:   Wed, 8 May 2019 11:17:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190507170422.GA25179@bogus>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf0zMcRjHfe77s1vXPl3Us5jmmPkxlfzYZ2NC5MaGGeZHxuGr0CX3FZLZ
        YQtHRZG6utKGUllJSx3Srrj8qBR2lJ9do6GMK41D3H1r+u/1PJ/38zzv9/bhKWU3489vj9kj
        6GI00SpWTlfc+9E45WpOS0Sw8Zc/uZZRwhBbzweG5NY1MqToqx2RtAcmGXl0UktS7J8o0tRU
        ypGGI5858sSczRJHUh0iGU3VMnK17hVH2g4XsKT/ViVHaj8fY8idp4tJm9OLfK9vR3N91N97
        U2l1lr6ZVlcZX3HqssITrDrpaDerTi4vROrrDxPUjrLRy/l18tlbhejtewVd0JxN8qi8Pt/Y
        mvH7G1ovcXpkCjAgDx7wdLCWO2gDkvNKXICg+lsRJRU9COw/v3FS4UBwPctID4687KtjXazE
        +QicLSGSqAtBzp8qt8gHbwPLxVbOxcPxGHAmpjMuEYVvU+DoeIcMiOdZHAiVhbtdGgUOh5vn
        kt1LaTwOCp73ylw8Aq+BN/dKGUnjDfczO9z7PfBksDTa3HoK+0FrR65M4gC40ZXtjgDYxMOT
        9Bec5HoBPOsrYSX2gY/W8oH+KOivkoYBi6BPykMSHwR7imlAMwtqrc2MyzOFJ0KJOciFgOdB
        SeNKCb3geZe35MALUivOU1JbAccTldKOCVB+6vHAHV/IL07nTiOVcUgu45AsxiFZjP/PXkB0
        IfIT4kRtpCBOixH2BYoarRgXExm4ZZe2DP37hQ//WHsrUfWvzRaEeaTyVHTGNkcoGc1eMV5r
        QcBTquEK25mWCKViqyb+gKDbtVEXFy2IFjSSp1V+ioRhb9crcaRmj7BTEGIF3eCrjPfw16O5
        1rtt9bM23Jl/WTfz0uMKsNviXmptb4PHZkUfOTvNGeFn8Lnx/ktxWGnY7xGr67PNh7yVst0F
        Ts36XNOB6V/0xYcmjpvX/fX1jitrX6O8ZaGzaxpqtezBcMOq9pBrae2hJ3Mqlsp9twTFX/BX
        9c3woHsyVywMM7NJt9IWLen08txpVtFilGbqJEonav4CmWKjuIEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphleLIzCtJLcpLzFFi42I5/e/4Xd018y7FGCzbLGexccZ6VovrX56z
        Wsw/co7VYvXHx4wWk0/NZbI4051r0f/4NbPF+fMb2C3ONr1ht7i8aw6bxefeI4wWM87vY7JY
        e+Quu8XtxhVsFv/37GC3OPymndVi/xUvi9u/+Sy+nXjE6CDs8e3rJBaP2Q0XWTx2zrrL7rFp
        VSebR2/zOzaPvi2rGD02n672+LxJLoAjSs+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRSz9DY
        PNbKyFRJ384mJTUnsyy1SN8uQS9j4XexggNqFWdvLWVvYJwr38XIySEhYCJx5/sRti5GLg4h
        gaWMEq/Wt7BCJMQkJu3bzg5hC0v8udYFVfSaUeLnsw+MIAlhgTSJG0umsoHYIgKKEr/bprGC
        FDEL7GWWWL9rLlRHA5PEyZnzWLoYOTjYBPQkdqwqBGngFXCT2D21D6yZRUBFYsWNr0wgtqhA
        hMSZ9ytYIGoEgVqfgNmcAtoSh85dB6tnFjCTmLf5ITOELS5x68l8JghbXmL72znMExiFZiFp
        n4WkZRaSlllIWhYwsqxiFEktLc5Nzy020itOzC0uzUvXS87P3cQITAHbjv3csoOx613wIUYB
        DkYlHt4XBRdjhFgTy4orcw8xSnAwK4nwXp94KUaINyWxsiq1KD++qDQntfgQoynQcxOZpUST
        84HpKa8k3tDU0NzC0tDc2NzYzEJJnLdD4GCMkEB6YklqdmpqQWoRTB8TB6dUA+MyxsT3Ms8W
        xGo8kGBLeHykU+q05aa3ndyPVcJlPhYZKHQw81vJPT7KKbZwxSYjiTC147df9E84c2L5E4u3
        827znFzqbt9sddthwq6ZC4JaHXnvWtjt3/1aoGfS9n/6/VtzH5+UDzk988HqV917Kndf36Of
        ZlPvelS18IWt9a3cDu61f1hORc1TYinOSDTUYi4qTgQAC7T/4xcDAAA=
X-CMS-MailID: 20190508091732eucas1p157ea16882d06a949ac3ca7e401254e4c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190506151215eucas1p2c57147edac5671c5ec9a223efb6b4adc
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190506151215eucas1p2c57147edac5671c5ec9a223efb6b4adc
References: <1557155521-30949-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190506151215eucas1p2c57147edac5671c5ec9a223efb6b4adc@eucas1p2.samsung.com>
        <1557155521-30949-8-git-send-email-l.luba@partner.samsung.com>
        <20190507170422.GA25179@bogus>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rob,

On 5/7/19 7:04 PM, Rob Herring wrote:
> On Mon, May 06, 2019 at 05:11:55PM +0200, Lukasz Luba wrote:
>> The patch adds description for DT binding for a new Exynos5422 Dynamic
>> Memory Controller device.
>>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   .../bindings/memory-controllers/exynos5422-dmc.txt | 74 ++++++++++++++++++++++
>>   1 file changed, 74 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
>>
>> diff --git a/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt b/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
>> new file mode 100644
>> index 0000000..be602a9
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
>> @@ -0,0 +1,74 @@
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
>> +- clock-names : the name of clock used by the controller.
>> +- clocks : phandles for clock specified in "clock-names" property.
> 
> Need to enumerate the clocks and their order.
OK I will add a list here and above in 'clock-names' in the right order.
> 
>> +- devfreq-events : phandles for PPMU devices connected to this DMC.
>> +- vdd-supply : phandle for voltage regulator which is connected.
>> +- reg : registers of two CDREX controllers.
>> +- operating-points-v2 : phandle for OPPs described in v2 definition.
>> +- device-handle : phandle of the connected DRAM memory device. For more
>> +	information please refer to Documentation
> 
> Documentation... ?
I should have changed it after I moved the lpddr3.txt files in the doc
dir. I missed it, my apologies.
> 
>> +- devfreq-events : phandles of the PPMU events used by the controller.
>> +- samsung,syscon-chipid : phandle of the ChipID used by the controller.
>> +- samsung,syscon-clk : phandle of the clock register set used by the controller.
> 
> Looks like a hack. Can't you get this from the clocks property? What is
> this for?
As Krzysztof commented in the next message, the chipid register contains
information about memory size and the clock register set has some
registers from DMC (timings settings) which are not typical 'clocks'.
Chanwoo suggested to use syscon regmap to access these clock registers
safely. Krzysztof suggested to use syscon regmap similar to Sylwester's
AVS driver while accessing chipid registers.
That's why they are here. Both register sets contain needed information
for proper operation of the driver.

Regards,
Lukasz
> 
>> +
>> +Example:
>> +
>> +	ppmu_dmc0_0: ppmu@10d00000 {
>> +		compatible = "samsung,exynos-ppmu";
>> +		reg = <0x10d00000 0x2000>;
>> +		clocks = <&clock CLK_PCLK_PPMU_DREX0_0>;
>> +		clock-names = "ppmu";
>> +		events {
>> +			ppmu_event_dmc0_0: ppmu-event3-dmc0_0 {
>> +				event-name = "ppmu-event3-dmc0_0";
>> +			};
>> +		};
>> +	};
>> +
>> +	dmc: memory-controller@10c20000 {
>> +		compatible = "samsung,exynos5422-dmc";
>> +		reg = <0x10c20000 0x100>, <0x10c30000 0x100>,
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
>> +		operating-points-v2 = <&dmc_opp_table>;
>> +		devfreq-events = <&ppmu_event3_dmc0_0>,	<&ppmu_event3_dmc0_1>,
>> +				<&ppmu_event3_dmc1_0>, <&ppmu_event3_dmc1_1>;
>> +		operating-points-v2 = <&dmc_opp_table>;
>> +		device-handle = <&samsung_K3QF2F20DB>;
>> +		vdd-supply = <&buck1_reg>;
>> +		samsung,syscon-clk = <&clock>;
>> +		samsung,syscon-chipid = <&chipid>;
>> +	};
>> -- 
>> 2.7.4
>>
> 
> 
