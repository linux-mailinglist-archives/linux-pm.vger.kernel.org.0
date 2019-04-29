Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC66AE207
	for <lists+linux-pm@lfdr.de>; Mon, 29 Apr 2019 14:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbfD2MOj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Apr 2019 08:14:39 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:42048 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727969AbfD2MOj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Apr 2019 08:14:39 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190429121437euoutp02eb56ddcf79e0b5ab860c23e7815e0024~Z8PQenl6E0846208462euoutp02S
        for <linux-pm@vger.kernel.org>; Mon, 29 Apr 2019 12:14:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190429121437euoutp02eb56ddcf79e0b5ab860c23e7815e0024~Z8PQenl6E0846208462euoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1556540077;
        bh=8WtmNbCiuXOlZdfikeBW8O+Q3p5gVptpLFlSyy03NGg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=TeatuW+qhmL6kCQYo7NGVyphd+bFyzWWIW5M3CVoRw4kydBL5ufe/pIsFdOyVe6Vo
         9HSD8Q2lmijya1b7TrvJR1QJv2+ebhTPStKvPGzX0eby0DigTvf8jtTtHdT0KXo59x
         HrJOXWRy7NmcMp59RotzuQbjhBxi9VFxax4MYlWQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190429121436eucas1p208aa5083d4906f1d25f97f87ba03880a~Z8PPqmQtX1716017160eucas1p2t;
        Mon, 29 Apr 2019 12:14:36 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 9A.61.04377.CAAE6CC5; Mon, 29
        Apr 2019 13:14:36 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190429121435eucas1p1b5e6d225be2d61b0aecb4a6b726bfbfe~Z8PO3Q3F51185811858eucas1p1J;
        Mon, 29 Apr 2019 12:14:35 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190429121435eusmtrp271a7206da39948596b662145c2c96e95~Z8POpDVs10433504335eusmtrp2H;
        Mon, 29 Apr 2019 12:14:35 +0000 (GMT)
X-AuditID: cbfec7f4-12dff70000001119-38-5cc6eaac5ed7
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 2E.0C.04146.BAAE6CC5; Mon, 29
        Apr 2019 13:14:35 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190429121434eusmtip1724902234849d147d30d670fa7811939~Z8PN1Mrly1687616876eusmtip1t;
        Mon, 29 Apr 2019 12:14:34 +0000 (GMT)
Subject: Re: [PATCH v6 06/10] dt-bindings: memory-controllers: add
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
Message-ID: <e4613d6e-0893-8163-32ef-8137c40d2b24@partner.samsung.com>
Date:   Mon, 29 Apr 2019 14:14:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190425195750.GA26031@bogus>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfUzMYRz33O/1jsvTJX2X5uXMqCg1s8cyw8x+sxljNtHGqZ8yd1fuJyQv
        52WoVIqFI/FXLdGLVlcTU+lwuJqXIuWlaKUXXLLyku5+mf77fD7fz+f5Pp9nD09p+hhffodx
        t2gy6vRaVkWX1Q065hV01UXMr3rsRYovFDKksb+DITm1Txly/WsbImcfZSvI4xQDSW/7TBGH
        o4gjT452c+RZ5WWWOFNrEbnguKMgN2pbONJ8JI8lw7etHKnpPsmQu89XkeafHmTgwQe01EsY
        +J5JC5fMDbRQYWnhhJL8JFZIPdbLCmml+Ui4ZU8UnCVT1/KbVIujRP2OPaIpeMlWVUzS0Ds2
        7szMfdZ7bxRmVO6XjJQ84AVwJaWJSkYqXoPzEHws/z1K+kfI22JaJk4Egx+tTDLi3ZE/DQdd
        aQ3ORdD5MkD29CCoaq3nXAMvvB0sn8oULjwJz4CfJ7IYl4nCVRQ4298j10EsDgJr/i6XR41X
        wreOH6wL03gWNJVY3VlvvBHe1hUxsscTHl5sp11YiQPhyw+7W6ewD7xuz1HIeBqU91x2NwCc
        zUNGfx8j91wB15LzOBl7QZetdBT7wXCFHAYsgTn1GpLxAWhLzx71hEGNrcFdnsL+UFgZLMvL
        oLP+HCu/iQc09XjKV/CAzLLzlCyr4dQJjeyeA6Wn60cXTYbcgizuDNJaxhSzjCljGVPG8n/v
        VUTnIx8xXjJEi1KoUdwbJOkMUrwxOigy1lCCRr6h/Y+t34oqf22rRphH2gnq6V33IzSMbo+U
        YKhGwFPaSWrBNiKpo3QJ+0VT7BZTvF6UqtEUntb6qBPHvduswdG63eJOUYwTTf+mCl7pa0an
        FjZ3Fs6ZGNnonRbJNax5WfzKIyutZcPRczGRYdXHW537QhflNv4KD+1bHTi3yG/gYoGDv2nc
        6P/1c+XWZvv6qIUdJ0PaH3y3H8o5EnbYMS1IrxnfuzhknTKhPOVw3ftw77jY88PHkG1IM7s3
        Y0i5P9y37apZv+Tbi57l2YNGpIqYrqWlGF1IAGWSdH8BU3vuA4IDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphleLIzCtJLcpLzFFi42I5/e/4Xd3Vr47FGFw9LmmxccZ6VovrX56z
        Wsw/co7VYvXHx4wWk0/NZbI4051r0f/4NbPF+fMb2C3ONr1ht7i8aw6bxefeI4wWM87vY7JY
        e+Quu8XtxhVsFv/37GC3OPymndVi/xUvi9u/+Sy+nXjE6CDs8e3rJBaP2Q0XWTx2zrrL7rFp
        VSebR2/zOzaPvi2rGD02n672+LxJLoAjSs+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRSz9DY
        PNbKyFRJ384mJTUnsyy1SN8uQS+j89cDtoIJyhU7Dt5hamDcLtPFyMEhIWAi8e9ibRcjF4eQ
        wFJGiUdnV7B2MXICxcUkJu3bzg5hC0v8udbFBlH0mlHi54uZbCAJYYE0ictXn7GA2CICihK/
        26axghQxC+xllli/ay5URwOTxOGLjWwg69gE9CR2rCoEaeAVcJP49Pw72CAWAVWJG5t2MIHY
        ogIREmfer2CBqBGUODnzCZjNKaAt8eH7abDrmAXMJOZtfsgMYYtL3HoynwnClpfY/nYO8wRG
        oVlI2mchaZmFpGUWkpYFjCyrGEVSS4tz03OLDfWKE3OLS/PS9ZLzczcxAlPAtmM/N+9gvLQx
        +BCjAAejEg+vwqujMUKsiWXFlbmHGCU4mJVEeD2OA4V4UxIrq1KL8uOLSnNSiw8xmgI9N5FZ
        SjQ5H5ie8kriDU0NzS0sDc2NzY3NLJTEeTsEDsYICaQnlqRmp6YWpBbB9DFxcEo1MOZNmSQh
        0rZUfpmpvktt27oytq72wh27Y1cvX2s9RSF47xbVJpvVLL9CfkkEHZ/7c3XGIo5AdqbpvM+2
        aPzcz5a9ILP47+Z2ES4e4a4WhzPpixjiPv8NEKlekFHc3f799624//ck7q24FPmGwz7lm9lG
        09qOvdrrU2t3ltrZZsz4lFgi9uxmgRJLcUaioRZzUXEiAKeaLWEXAwAA
X-CMS-MailID: 20190429121435eucas1p1b5e6d225be2d61b0aecb4a6b726bfbfe
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190419141947eucas1p13a27605e04169ab528ef5bfb385eddbc
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190419141947eucas1p13a27605e04169ab528ef5bfb385eddbc
References: <1555683568-20882-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190419141947eucas1p13a27605e04169ab528ef5bfb385eddbc@eucas1p1.samsung.com>
        <1555683568-20882-7-git-send-email-l.luba@partner.samsung.com>
        <20190425195750.GA26031@bogus>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rob,

On 4/25/19 9:57 PM, Rob Herring wrote:
> On Fri, Apr 19, 2019 at 04:19:24PM +0200, Lukasz Luba wrote:
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
>> +- clock-names : the name of clock used by the bus, "bus".
>> +- clocks : phandles for clock specified in "clock-names" property.
>> +- devfreq-events : phandles for PPMU devices connected to this DMC.
>> +- vdd-supply : phandle for voltage regulator which is connected.
>> +- reg : registers of two CDREX controllers, chip information, clocks subsystem.
>> +- operating-points-v2 : phandle for OPPs described in v2 definition.
>> +- device-handle : phandle of the connected DRAM memory device. For more
>> +	information please refer to Documentation
> 
> The memory node(s) should be a child of the memory controller IMO.
I have followed the TI code for LPDDR2. They use 'device-handle'
probably because the memory controller can be moved into the common
.dtsi and taken by reference in .dts in a proper board file.
The board .dts files might specify different DRAM chips and timings.
In Exynos case we will also have such situation: one memory controller
and a few different DRAM chips.

> 
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
> 
> Don't show 'status' in examples.
Thank you, I accidentally copied it from dt file.

Regards,
Lukasz
> 
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
>> -- 
>> 2.7.4
>>
> 
> 
