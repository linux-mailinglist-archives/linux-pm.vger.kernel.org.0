Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC0D12234
	for <lists+linux-pm@lfdr.de>; Thu,  2 May 2019 20:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfEBS4Z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 May 2019 14:56:25 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:38438 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfEBS4Z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 May 2019 14:56:25 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190502185622euoutp01ea89b04c4224a5e2dc54f674886bf291~a8p49SUB90912509125euoutp01Y
        for <linux-pm@vger.kernel.org>; Thu,  2 May 2019 18:56:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190502185622euoutp01ea89b04c4224a5e2dc54f674886bf291~a8p49SUB90912509125euoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1556823382;
        bh=N9S7PNXoil6E91sSo2Q4V4J1/Vi57Ngw34C5zarPlSI=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=FyXrprbYmgr4MSpw6J2HOj52VZa+g8naeDnrroSUJispU6kR0WnT2owB18nxXtHMC
         CJs+UsGiRQSjOBYewCKh5EGdoTpzRXMF3DOLxte7HMTA74MjFgcb56tdScq8F7MFWG
         hasKVfGcWEiAgBDQdEGy0BRtlUtrXaClJA1zmXOA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190502185621eucas1p27805e185fcdc0ca5a00c19fe0928d576~a8p4PKce63063030630eucas1p2q;
        Thu,  2 May 2019 18:56:21 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 9D.83.04377.55D3BCC5; Thu,  2
        May 2019 19:56:21 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190502185621eucas1p16d2c26ff26c1ec6ed7511a20a6af5804~a8p3d1Fsh3260432604eucas1p1e;
        Thu,  2 May 2019 18:56:21 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190502185620eusmtrp2d3cf13a4e7eb0ef66255777b941f236a~a8p3PsRKl3160231602eusmtrp2O;
        Thu,  2 May 2019 18:56:20 +0000 (GMT)
X-AuditID: cbfec7f4-113ff70000001119-d6-5ccb3d5565b9
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 32.41.04146.45D3BCC5; Thu,  2
        May 2019 19:56:20 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190502185620eusmtip2a0386ef46eb36495ea1c531fb1fb0fc9~a8p2h-IrI1163911639eusmtip2Q;
        Thu,  2 May 2019 18:56:20 +0000 (GMT)
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
Message-ID: <b2992f0e-3b46-66a6-f1e4-326fb4b0501f@partner.samsung.com>
Date:   Thu, 2 May 2019 20:56:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <ed07af9b-2d17-23c2-2f3a-dc832570480d@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRju2zlnO1pnfE7Ll4qM0R1aFyI+6GJi2IiKDIQoS1ed1HJmO2qZ
        /nAKapaXLEunYhHk1ERbS9QfWWYzNW8pZJlaTosu2kUdmWa5HSP/Pe/zvA/v83x8LKX4zCxk
        Q8IieF2YJlQpdaYrLOOta/22Nfmvb6hZSu5llzHk5egHhhTUtTCk5LsVkauN+RLy/JKWpFs/
        U6S1tVxGmuO/yEhHdZ6UjKTWIZLd+lBCSut6ZKRbb5SSJ1+SGFLTuZt0T8iJ7Vk/2qFQ28Yy
        aXVuXDutrjL0yNSm4otSdWrCsFSdZi5G6vtNMeoR05L97CHnrSf40JAoXrdue6Bz8LuMSjr8
        28rzFb1GKg6ZlqYglgW8Cb698E1BzqwCGxGUdGUhcRhFcCupgxGHEQSDE5myFOTkcCTmFVGi
        UIggY6R/xjKEwJicJrFvueKTYHhfIbELbvg2gqyiCcdA4RIJTI6VMvbrUqyCyuKzdshhH2js
        8LB7abwMOp+OS+14Pj4IfZZyxo457AINOQO0HTthT+hs/uXgKewOrwcKJCL2gIQHuY50gLNY
        KHrcTYuxd4KxtoURsSt8qjfP1FkMf6pEM2AB4lJvIRHHgjU9f2ZnCzypb3dEpvBqKKteJ9Je
        8LHtmlR8Rzl0DbmIEeSQWXGDEmkOkhMV4vYqMF9umzm0AArvXpdlIKVhVjHDrDKGWWUM/+/e
        RHQxcucjBW0QL2wM48+pBI1WiAwLUh0/ozWh6S/YNFU/WomqJ4/VIswi5TwOehv9FYwmSojW
        1iJgKaUbd/T7NMWd0ERf4HVnAnSRobxQixaxtNKdi5nz9rACB2ki+NM8H87r/qkS1mlhHIqR
        2Q65/ZhyGYxdGzh8xPunjbvzEeneBKC9+Q03NvzeZfFZGR/oWbPK+9XmY6rlfiuCfPxiQ/Se
        zcNlXnL2SmWURXHAKu837z0Z7P+ydH52QntS6uOICFqfcTNHr6rb0jCVc6prz5Xj1gIc71vY
        NDfNljjGlacc2PdVb+l7NLrNVUkLwZoNayidoPkLrz1FRn4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPIsWRmVeSWpSXmKPExsVy+t/xe7ohtqdjDG4s0bPYOGM9q8X1L89Z
        LeYfOcdqsfrjY0aLyafmMlmc6c616H/8mtni/PkN7BZnm96wW1zeNYfN4nPvEUaLGef3MVms
        PXKX3eJ24wo2i8Nv2lkt9l/xsrj9m8/i24lHjA5CHt++TmLxmN1wkcVj56y77B6bVnWyefQ2
        v2Pz6NuyitFj8+lqj8+b5AI4ovRsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV
        9O1sUlJzMstSi/TtEvQyHk7YwVLwQb1i270VzA2MmxS6GDk5JARMJNrmrGTuYuTiEBJYyihx
        evNbFoiEmMSkfdvZIWxhiT/Xutggil4zSjQc3ARWJCyQJnH56jMwW0RgMaPE19ZqkCJmgdVM
        EpM+boHqaGOWuLB2MmMXIwcHm4CexI5VhSAmr4CbxKnL8iC9LAIqEleO/mQDsUUFIiTOvF8B
        NpNXQFDi5MwnYDangL3ElbO/WEFsZgEziXmbHzJD2OISt57MZ4Kw5SWat85mnsAoNAtJ+ywk
        LbOQtMxC0rKAkWUVo0hqaXFuem6xoV5xYm5xaV66XnJ+7iZGYORvO/Zz8w7GSxuDDzEKcDAq
        8fBK3DsVI8SaWFZcmXuIUYKDWUmEN+4jUIg3JbGyKrUoP76oNCe1+BCjKdBzE5mlRJPzgUkp
        ryTe0NTQ3MLS0NzY3NjMQkmct0PgYIyQQHpiSWp2ampBahFMHxMHp1QDY90/C3P2ubk3XzeJ
        fTbj+uPLZGqiWF6V///fheIl1RfOGAaynU1tkg6yZ/M+0id2ZVGy7I/Os50L6t9duH4rOVZK
        5/bWDaEFnXmTzr24fK++Qi9v0qqZz5zVDvZnnjcyU3bvTni7svTAE5NfdSKnNG4daHncdXxp
        ytmQS/vy5BVWP1lvsXjDJSWW4oxEQy3mouJEAGnMIDESAwAA
X-CMS-MailID: 20190502185621eucas1p16d2c26ff26c1ec6ed7511a20a6af5804
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
        <32dfc887-5f67-3d61-08c9-0397d6852811@partner.samsung.com>
        <ed07af9b-2d17-23c2-2f3a-dc832570480d@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Chanwoo,

On 5/2/19 3:35 AM, Chanwoo Choi wrote:
> Hi Lukasz,
> 
> On 19. 5. 1. 오전 5:30, Lukasz Luba wrote:
>> Hi Chanwoo,
>>
>> On 4/30/19 6:46 AM, Chanwoo Choi wrote:
>>> On 19. 4. 19. 오후 11:19, Lukasz Luba wrote:
>>>> The patch adds description for DT binding for a new Exynos5422 Dynamic
>>>> Memory Controller device.
>>>>
>>>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>>>> ---
>>>>    .../bindings/memory-controllers/exynos5422-dmc.txt | 73 ++++++++++++++++++++++
>>>>    1 file changed, 73 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt b/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
>>>> new file mode 100644
>>>> index 0000000..133b3cc
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
>>>> @@ -0,0 +1,73 @@
>>>> +* Exynos5422 frequency and voltage scaling for Dynamic Memory Controller device
>>>> +
>>>> +The Samsung Exynos5422 SoC has DMC (Dynamic Memory Controller) to which the DRAM
>>>> +memory chips are connected. The driver is to monitor the controller in runtime
>>>> +and switch frequency and voltage. To monitor the usage of the controller in
>>>> +runtime, the driver uses the PPMU (Platform Performance Monitoring Unit), which
>>>> +is able to measure the current load of the memory.
>>>> +When 'userspace' governor is used for the driver, an application is able to
>>>> +switch the DMC and memory frequency.
>>>> +
>>>> +Required properties for DMC device for Exynos5422:
>>>> +- compatible: Should be "samsung,exynos5422-bus".
>>>
>>> As I already mentioned on many times, it is not fixed.
>>> You have to fix it as following:
>>> - exynos5422-bus -> exynos5422-dmc
>> I don't know how I missed it on my list. My apologies.
>>>
>>>> +- clock-names : the name of clock used by the bus, "bus".
>>>
>>> The below examples doesn't contain the 'bus' clock name.
>> True. Thank you for pointing this out. I will it.
>>
>> Regards,
>> Lukasz
>>>
>>>> +- clocks : phandles for clock specified in "clock-names" property.
>>>> +- devfreq-events : phandles for PPMU devices connected to this DMC.
>>>> +- vdd-supply : phandle for voltage regulator which is connected.
>>>> +- reg : registers of two CDREX controllers, chip information, clocks subsystem.
>>>> +- operating-points-v2 : phandle for OPPs described in v2 definition.
>>>> +- device-handle : phandle of the connected DRAM memory device. For more
>>>> +	information please refer to Documentation
>>>> +- devfreq-events : phandles of the PPMU events used by the controller.
>>>> +
>>>> +Example:
>>>> +
>>>> +	ppmu_dmc0_0: ppmu@10d00000 {
>>>> +		compatible = "samsung,exynos-ppmu";
>>>> +		reg = <0x10d00000 0x2000>;
>>>> +		clocks = <&clock CLK_PCLK_PPMU_DREX0_0>;
>>>> +		clock-names = "ppmu";
>>>> +		status = "okay";
>>>> +		events {
>>>> +			ppmu_event_dmc0_0: ppmu-event3-dmc0_0 {
>>>> +				event-name = "ppmu-event3-dmc0_0";
>>>> +			};
>>>> +		};
>>>> +	};
>>>> +
>>>> +	dmc: memory-controller@10c20000 {
>>>> +		compatible = "samsung,exynos5422-dmc";
>>>> +		reg = <0x10c20000 0x10000>, <0x10c30000 0x10000>,
>>>> +			<0x10000000 0x1000>, <0x10030000 0x1000>;
> 
> As I discussed about the register region of clock subsystem
> with Sylwester on patch[1], I expected that you used the regmap
> interface to control the register region of clock subsystem.
> 
> But, this dt-binding documents doesn't include any information
> about regmap interface.
Right. I will update the doc since the clock and chipid regs will use
phandle in DT and syscon_regmap in the driver code in the v7 patch set.

Regards,
Lukasz

> 
> [1] https://lkml.org/lkml/2019/3/6/878
> 
>>>> +		clocks = 	<&clock CLK_FOUT_SPLL>,
>>>> +				<&clock CLK_MOUT_SCLK_SPLL>,
>>>> +				<&clock CLK_FF_DOUT_SPLL2>,
>>>> +				<&clock CLK_FOUT_BPLL>,
>>>> +				<&clock CLK_MOUT_BPLL>,
>>>> +				<&clock CLK_SCLK_BPLL>,
>>>> +				<&clock CLK_MOUT_MX_MSPLL_CCORE>,
>>>> +				<&clock CLK_MOUT_MX_MSPLL_CCORE_PHY>,
>>>> +				<&clock CLK_MOUT_MCLK_CDREX>,
>>>> +				<&clock CLK_DOUT_CLK2X_PHY0>,
>>>> +				<&clock CLK_CLKM_PHY0>,
>>>> +				<&clock CLK_CLKM_PHY1>;
>>>> +		clock-names =	"fout_spll",
>>>> +				"mout_sclk_spll",
>>>> +				"ff_dout_spll2",
>>>> +				"fout_bpll",
>>>> +				"mout_bpll",
>>>> +				"sclk_bpll",
>>>> +				"mout_mx_mspll_ccore",
>>>> +				"mout_mx_mspll_ccore_phy",
>>>> +				"mout_mclk_cdrex",
>>>> +				"dout_clk2x_phy0",
>>>> +				"clkm_phy0",
>>>> +			        "clkm_phy1";
>>>> +		status = "okay";
>>>> +		operating-points-v2 = <&dmc_opp_table>;
>>>> +		devfreq-events = <&ppmu_event3_dmc0_0>,	<&ppmu_event3_dmc0_1>,
>>>> +				<&ppmu_event3_dmc1_0>, <&ppmu_event3_dmc1_1>;
>>>> +		operating-points-v2 = <&dmc_opp_table>;
>>>> +		device-handle = <&samsung_K3QF2F20DB>;
>>>> +		vdd-supply = <&buck1_reg>;
>>>> +	};
>>>>
>>>
>>>
>>
>>
> 
> 
