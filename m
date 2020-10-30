Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE1072A0561
	for <lists+linux-pm@lfdr.de>; Fri, 30 Oct 2020 13:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbgJ3M32 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 30 Oct 2020 08:29:28 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:53969 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgJ3M31 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Oct 2020 08:29:27 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201030122915euoutp02afe677b94964750206e8c5fd6aa2e1ee~CxPC0L8xx2043220432euoutp022
        for <linux-pm@vger.kernel.org>; Fri, 30 Oct 2020 12:29:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201030122915euoutp02afe677b94964750206e8c5fd6aa2e1ee~CxPC0L8xx2043220432euoutp022
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1604060955;
        bh=YV+bUm/CiXD+OTt6gutAdWC1mleNGIQH/z9V1moP9ec=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=YbsUPhrc8mcRvIGOcCetx+sGuVJbF6iIClXSGfBCpa5UKw1HFIWmTw4D/P/tRRvT4
         bcZ9itwguLLusDFiqtZ+KNYSpCCv/kpWgxvXDCUZLgZPNvejNC7rcdvmT2/FY/vcU6
         Jo9h5yQb+9zQO+V5ZNhUXnVGViqotE0bvsrXO82E=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20201030122909eucas1p21952a86630480186e4324a7d8a396064~CxO9sy9991469914699eucas1p2q;
        Fri, 30 Oct 2020 12:29:09 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 7C.FD.06318.5170C9F5; Fri, 30
        Oct 2020 12:29:09 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20201030122909eucas1p1f4b33f6fd724f174f96f1fe310c83fc1~CxO9TYFIa1809718097eucas1p1V;
        Fri, 30 Oct 2020 12:29:09 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201030122909eusmtrp1d1111caa7e8af0832da168a8dbcce695~CxO9SennR1994519945eusmtrp1h;
        Fri, 30 Oct 2020 12:29:09 +0000 (GMT)
X-AuditID: cbfec7f5-38bff700000018ae-0b-5f9c07152814
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id CE.33.06017.5170C9F5; Fri, 30
        Oct 2020 12:29:09 +0000 (GMT)
Received: from [106.210.123.115] (unknown [106.210.123.115]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20201030122908eusmtip1d4aac8f4553fc923ca43c5406b44949e~CxO8Ztr7R2036820368eusmtip14;
        Fri, 30 Oct 2020 12:29:08 +0000 (GMT)
Subject: Re: [PATCH RFC v6 1/6] dt-bindings: exynos-bus: Add documentation
 for interconnect properties
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh@kernel.org>
Cc:     cw00.choi@samsung.com, krzk@kernel.org, devicetree@vger.kernel.org,
        a.swigon@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-ID: <ca0417b2-fddf-cec5-c3b6-0ec80958d4c0@samsung.com>
Date:   Fri, 30 Oct 2020 13:29:07 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <ae438269-fbb5-326a-aa97-f04033c2b3b6@linaro.org>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRTH+e3e3XtdTa4z8aRRtBLppYk9ftDLQmIUlBGEVGorL07aTLam
        vcBqKeWcjvbHdM4UkbSFlOtltqzGdKTlJGM9nEnLiEVipgVmZW7XyP8+55zv+Z3zPfwYQuIT
        xjC5ecc5dZ5cKaVE5N3OCc+qKNqatfpx+Vo8eKUY4ZbKG0L8avyTENe6eoT45fcRCpsf2il8
        edBIYo/nJo3tH7xC3NdmpfCYwYVwpaddgJtdAzTuP9dE4SlHK40rTQEqhZXZbZcomc/roGSD
        erdAdquhSFZ+24ZkY/aFadR+0cZsTplbwKkTNx8SKbwlVH7VyhOG4l/UWfRqSSliGGDXwNWR
        2FIkYiRsEwLHRZ+QD8YRdH3U03wwhkD3zIlKUVioo1VvJflCI4JBk2kmGEVw7p2PCKoiWQVM
        3CujgjyP3Qm99Q4iKCLYCwQYAtdDT1FsEhg6ykMsZjeDt7OZDjLJxkHJsJ8MchSbCcaWCySv
        iYCnVUMhDpvWv2/pEgSZYKPh7VDtDC8C3Z3q0DBgf9MwPGmh+L1TIdCrE/AcCZ/dt2meF0C3
        qYzkG3QIyh7003xgnDbnrptxvQF8PT+p4M0IdhncaEvk01vh5tR9AX/KcHg9HMEvEQ6X75oJ
        Pi2GiyUSXr0UJm3mmRViQD80RRqR1DLLmmWWHcssO5b/c+sQaUPRnFajyuE0yXlcYYJGrtJo
        83ISjhxT2dH0n+v+4/7eitp/HXYilkHSueKURdVZEqG8QHNS5UTAENJ54m3PuzMl4mz5yVOc
        +liWWqvkNE4Uy5DSaHFyfSBDwubIj3NHOS6fU/+rCpiwmLNIG2NoSI+o8J/ybDHBt3WPyMNI
        BoVfygV7VftZhenNfAdWzgnsyszdntPXEdX0Iz41rX8ytcbpPhNvO99jubbia+8SP6XbpN79
        YUi9fkdRcfqTioo7DGF+MRK3R/87o+bA6IBo00rlGTN38JPt42LFPslwSrar0Tq69RF52v9W
        SmoU8qTlhFoj/wu5bRvibwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHIsWRmVeSWpSXmKPExsVy+t/xu7qi7HPiDS5/k7S4P6+V0WLjjPWs
        Fte/PGe1mH/kHKvFla/v2Sym793EZjHp/gQWi/PnN7BbbHp8jdXi8q45bBafe48wWsw4v4/J
        Yu2Ru+wWtxtXsFn837OD3WLG5JdsDgIem1Z1snncubaHzeN+93Emj81L6j36tqxi9Pi8SS6A
        LUrPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7MstUjfLkEv41ob
        W8FMnYre1j9sDYzXlbsYOTkkBEwkdnTPYeli5OIQEljKKNHRvoqxi5EDKCElMb9FCaJGWOLP
        tS42iJr3jBLb/v5jBUkIC2RILNv3ghHEFhHwlriwaA8zSBGzQAuzxNdJM5ggOl4wS+xe/xas
        ik3AUKL3aB+YzStgJ3Ht2Fp2EJtFQFWi7e0jFhBbVCBO4sfEXjaIGkGJkzOfgMU5geofbjzF
        BGIzC6hL/Jl3iRnCFpe49WQ+VFxeonnrbOYJjEKzkLTPQtIyC0nLLCQtCxhZVjGKpJYW56bn
        FhvpFSfmFpfmpesl5+duYgTG9bZjP7fsYOx6F3yIUYCDUYmH10F+drwQa2JZcWXuIUYJDmYl
        EV6ns6fjhHhTEiurUovy44tKc1KLDzGaAj03kVlKNDkfmHLySuINTQ3NLSwNzY3Njc0slMR5
        OwQOxggJpCeWpGanphakFsH0MXFwSjUwTm6O+bJOM2d3XIIRw9KGyG+MP1yLYnbf6HgVLHpw
        84otdT5f7X7HHoxQ2Xb9lPcz+4mnZzYsblv5yckxvqJ51dRbkxQVmNQ2v/9sdJO7uDKjRuDJ
        6hWrTr7RFsxKYMkv/zM5USLdONOdVXyliTF7/qn2Z6rHv7CbvhVgKmb692WdTsnKqfsWKLEU
        ZyQaajEXFScCAN3ChLMBAwAA
X-CMS-MailID: 20201030122909eucas1p1f4b33f6fd724f174f96f1fe310c83fc1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200702163748eucas1p2cf7eab70bc072dea9a95183018b38ad3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200702163748eucas1p2cf7eab70bc072dea9a95183018b38ad3
References: <20200702163724.2218-1-s.nawrocki@samsung.com>
        <CGME20200702163748eucas1p2cf7eab70bc072dea9a95183018b38ad3@eucas1p2.samsung.com>
        <20200702163724.2218-2-s.nawrocki@samsung.com>
        <20200709210448.GA876103@bogus>
        <65af1a5c-8f8a-ef65-07f8-e0b3d04c336c@samsung.com>
        <35d9d396-b553-a815-1f3b-1af4dc37a2ca@samsung.com>
        <b711257d-c34b-b609-3ada-312871967b98@linaro.org>
        <e6e369fb-ccf2-09ed-ad6a-680e67198359@samsung.com>
        <ae438269-fbb5-326a-aa97-f04033c2b3b6@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Georgi,

On 15.09.2020 23:40, Georgi Djakov wrote:
> On 9/9/20 17:47, Sylwester Nawrocki wrote:
>> On 09.09.2020 11:07, Georgi Djakov wrote:
>>> On 8/28/20 17:49, Sylwester Nawrocki wrote:
>>>> On 30.07.2020 14:28, Sylwester Nawrocki wrote:
>>>>> On 09.07.2020 23:04, Rob Herring wrote:
>>>>>> On Thu, Jul 02, 2020 at 06:37:19PM +0200, Sylwester Nawrocki wrote:
>>>>>>> Add documentation for new optional properties in the exynos bus nodes:
>>>>>>> samsung,interconnect-parent, #interconnect-cells, bus-width.
>>>>>>> These properties allow to specify the SoC interconnect structure which
>>>>>>> then allows the interconnect consumer devices to request specific
>>>>>>> bandwidth requirements.

>>>>>>> Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
>>>>>>> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

>>>>>>> +++ b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt

>>>> Actually we could do without any new property if we used existing interconnect
>>>> consumers binding to specify linking between the provider nodes. I think those
>>>> exynos-bus nodes could well be considered both the interconnect providers 
>>>> and consumers. The example would then be something along the lines 
>>>> (yes, I know the bus node naming needs to be fixed):
>>>>
>>>> 	soc {
>>>> 		bus_dmc: bus_dmc {
>>>> 			compatible = "samsung,exynos-bus";
>>>> 			/* ... */
>>>> 			samsung,data-clock-ratio = <4>;
>>>> 			#interconnect-cells = <0>;
>>>> 		};
>>>>
>>>> 		bus_leftbus: bus_leftbus {
>>>> 			compatible = "samsung,exynos-bus";
>>>> 			/* ... */
>>>> 			interconnects = <&bus_leftbus &bus_dmc>;
>>>> 			#interconnect-cells = <0>;
>>>> 		};
>>>>
>>>> 		bus_display: bus_display {
>>>> 			compatible = "samsung,exynos-bus";
>>>> 			/* ... */
>>>> 			interconnects = <&bus_display &bus_leftbus>;
>>>
>>> Hmm, bus_display being a consumer of itself is a bit odd? Did you mean:
>>>  			interconnects = <&bus_dmc &bus_leftbus>;
>>
>> Might be, but we would need to swap the phandles so <source, destination>
>> order is maintained, i.e. interconnects = <&bus_leftbus &bus_dmc>;
> 
> Ok, i see. Thanks for clarifying! Currently the "interconnects" property is
> defined as a pair of initiator and target nodes. You can keep it also as
> interconnects = <&bus_display &bus_dmc>, but you will need to figure out
> during probe that there is another node in the middle and defer. I assume
> that if a provider is also an interconnect consumer, we will link it to
> whatever nodes are specified in the "interconnects" property?

My apologies for the delay.

Yes, the "interconnect" property would be used (only) to determine what
links should be created.

>> My intention here was to describe the 'bus_display -> bus_leftbus' part 
>> of data path 'bus_display -> bus_leftbus -> bus_dmc', bus_display is
>> really a consumer of 'bus_leftbus -> bus_dmc' path.
>>
>> I'm not sure if it is allowed to specify only single phandle (and 
>> interconnect provider specifier) in the interconnect property, that would
>> be needed for the bus_leftbus node to define bus_dmc as the interconnect 
>> destination port. There seems to be such a use case in arch/arm64/boot/
>> dts/allwinner/sun50i-a64.dtsi.
> 
> In the general case you have to specify pairs. The "dma-mem" is a reserved
> name for devices that perform DMA through another bus with separate address
> translation rules.

I see, thanks for clarifying.

>>> I can't understand the above example with bus_display being it's own consumer.
>>> This seems strange to me. Could you please clarify it?
>>
>>> Otherwise the interconnect consumer DT bindings are already well established
>>> and i don't see anything preventing a node to be both consumer and provider.
>>> So this should be okay in general.
>>
>> Thanks, below is an updated example according to your suggestions. 
>> Does it look better now?
>>
>> ---------------------------8<------------------------------
>> soc {
>> 	bus_dmc: bus_dmc {
>> 		compatible = "samsung,exynos-bus";
>> 		/* ... */
>> 		samsung,data-clock-ratio = <4>;
>> 		#interconnect-cells = <0>;
>> 	};
>>
>> 	bus_leftbus: bus_leftbus {
>> 		compatible = "samsung,exynos-bus";
>> 		/* ... */
>> 		interconnects = <&bus_dmc>;
>> 		#interconnect-cells = <0>;
>> 	};
>>
>> 	bus_display: bus_display {
>> 		compatible = "samsung,exynos-bus";
>> 		/* ... */
>> 		interconnects = <&bus_leftbus &bus_dmc>;
>> 		#interconnect-cells = <0>;
>> 	};
>>
>> 	&mixer {
>> 		compatible = "samsung,exynos4212-mixer";
>> 		interconnects = <&bus_display &bus_dmc>;
>> 		/* ... */
>> 	};
>> };
>> ---------------------------8<------------------------------
> 
> It's difficult to have a common way to describe all the different kinds of
> topologies in DT, as some SoCs are very complex, having multi-tiered topologies
> with hundreds of nodes, with multiple links between them etc. Currently, the
> idea is to have the topology as platform data, but i guess that you want to
> avoid this. I hope that we will be able to describe simpler topologies in DT in
> the future, but we don't have such support in the framework yet.
> 
> So maybe we could try your proposal and see how it will work for exynos.

I suppose for any new Exynos SoCs with more complex interconnects exposed
for software control an approach with topology definition as platform data 
would also be used. The generic interconnect driver would likely only be 
used on existing platforms where the interconnects are somewhat abstracted 
by the devfreq.   

-- 
Regards,
Sylwester
