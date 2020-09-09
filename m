Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE08263161
	for <lists+linux-pm@lfdr.de>; Wed,  9 Sep 2020 18:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730885AbgIIQLB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Sep 2020 12:11:01 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58548 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730817AbgIIQK1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Sep 2020 12:10:27 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200909144709euoutp016689f1f3810d7bd9839de67283a444a2~zJN5VsXr02864228642euoutp014
        for <linux-pm@vger.kernel.org>; Wed,  9 Sep 2020 14:47:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200909144709euoutp016689f1f3810d7bd9839de67283a444a2~zJN5VsXr02864228642euoutp014
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1599662830;
        bh=6pD2jBm6l4NY8TMCPp0T0+uNfiB/x7JVe6XpoPosFww=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Ab58mHj/nrCKS1ik30p5kv8vxCIElYMllX720IHeoWDLwdpv5Xdxd+2F0lItj/7+p
         Id2qc+lEGkNFIv6MInMB6llvVd53Z+n07yMGIIwShjk+QiX4fU/IRyi0FrrD7Rt3RJ
         dp1rwJ0SYVMxViFYkWxDkgThm3HUmN230Sq+MBFo=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200909144709eucas1p2b4703806571a6b7d4677bb44b1129e64~zJN4vjCO_0720307203eucas1p2H;
        Wed,  9 Sep 2020 14:47:09 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 54.DC.05997.DEAE85F5; Wed,  9
        Sep 2020 15:47:09 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200909144708eucas1p22c7a9c941f4656ff4efc94e1d156a9a6~zJN4U79yv0034700347eucas1p20;
        Wed,  9 Sep 2020 14:47:08 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200909144708eusmtrp1cea369908fda34b63479819aba3041e8~zJN4UJEpe1317213172eusmtrp1G;
        Wed,  9 Sep 2020 14:47:08 +0000 (GMT)
X-AuditID: cbfec7f4-65dff7000000176d-0e-5f58eaed414a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id B1.1E.06017.CEAE85F5; Wed,  9
        Sep 2020 15:47:08 +0100 (BST)
Received: from [106.210.123.115] (unknown [106.210.123.115]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200909144707eusmtip2e63e94961e81d7208ff2d3503e173a61~zJN3U6Wu32459124591eusmtip2b;
        Wed,  9 Sep 2020 14:47:07 +0000 (GMT)
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
Message-ID: <e6e369fb-ccf2-09ed-ad6a-680e67198359@samsung.com>
Date:   Wed, 9 Sep 2020 16:47:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <b711257d-c34b-b609-3ada-312871967b98@linaro.org>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG+XYuO462jsvyRcVqSRelqRnxSSXdqFH/BFmElLb04Cy3YnPV
        Qsgww3uW1dastAso01iuMjXtDy9ZWq60THJmmCWO7KaRdtE6nkX+93ue93n5nhc+hpD3Un5M
        ki6F0+vUyQpaQlY9GHcuHXbvjAt7NyjDfZczEK602Cn8cnSQwsVN7RR+/u0Tjc31Dhqf6Ssg
        sdN5U4wdb7so3Fl7kcYjeU0IW5z3RfhGU68Y9xwvo/FkXbUYWwqH6DWsymHLolWurjpa1ZfT
        IlLdun5MlX/bhlQjjsCtdIxkVQKXnHSI04dG7ZFoskq6xQc/zj8y5rKhNFTpn428GGCXg9v6
        gs5GEkbOliEo63lDCWIUQXHveY8YQdD4I1/0b6Wr87VnUIqg3fLYI74g6HCWUnxqFquB8bu5
        NM8+7BZ4erWO4EMEe4KAvKFyxA9oNhzymvOnWMpGQeOp72Q2YhiSDYJPmTLens3GwoPWflKI
        eMOjCwNT7PU3/sE5QfBMsL7waqBYJPBcSL9TNPUWsMcZ+DqY4am9AZ5VnqUEngXulttigQOg
        rTCXFBbSEeTe6xELogBBX0sJElIrwdX+g+bbEewSsNeGCvZauDlZI+JtYGXQPewtlJDBmSoz
        IdhSyDwpF9JB8NNm9tTxg5yBSbIAKazTTrNOO8c67Rzr/3dLEGlDvpzRoE3kDMt03GGlQa01
        GHWJyvgDWgf6++naJlpGq1Htr70NiGWQYoY0s3dnnJxSHzKYtA0IGELhI133pC1WLk1Qm45y
        +gNxemMyZ2hA/gyp8JVGXB3aLWcT1Sncfo47yOn/TUWMl18aOrlZMVY+HjLvpbmgvzzkdGi8
        O/LStYhXqLk4ZsG9U67mnMiNHa31mmjb5J6IYP/UfXuv0DUVWWAPiMRPF7a+XRRo3JXU+RAb
        w7aj8ni8WnK+7VxK5jufinNVmqIVnz9bTcbu0NjCCeX76E39QWEzg43KbYuHTXNSf5dutK6P
        3mFXkAaNOjyY0BvUfwBBw3q3cAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRmVeSWpSXmKPExsVy+t/xe7pvXkXEG2zu1re4P6+V0WLjjPWs
        Fte/PGe1mH/kHKvFla/v2Sym793EZjHp/gQWi/PnN7BbbHp8jdXi8q45bBafe48wWsw4v4/J
        Yu2Ru+wWtxtXsFn837OD3WLG5JdsDgIem1Z1snncubaHzeN+93Emj81L6j36tqxi9Pi8SS6A
        LUrPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7MstUjfLkEvo3PB
        DfaCd4oVP+6sYmxg3CjdxcjJISFgInHt8j1WEFtIYCmjRP+E8C5GDqC4lMT8FiWIEmGJP9e6
        2LoYuYBK3jNKPDn0lw0kISyQIbFs3wtGEFtEwFviwqI9zCBFzAItzBJfJ81gguj4zyTR0PIW
        bAObgKFE79E+sA5eATuJw/3fWUC2sQioSLzv4AMJiwrESZzpecEGUSIocXLmExYQmxOo/M35
        f8wgNrOAusSfeZegbHGJW0/mM0HY8hLNW2czT2AUmoWkfRaSlllIWmYhaVnAyLKKUSS1tDg3
        PbfYSK84Mbe4NC9dLzk/dxMjMKq3Hfu5ZQdj17vgQ4wCHIxKPLwddyPihVgTy4orcw8xSnAw
        K4nwOp09HSfEm5JYWZValB9fVJqTWnyI0RTot4nMUqLJ+cCEk1cSb2hqaG5haWhubG5sZqEk
        ztshcDBGSCA9sSQ1OzW1ILUIpo+Jg1OqgbHZKfJ1pMsdHmPmi1Mju2In5gtEaGjr/3TT+HH7
        WPAD9tOvvXef2/dz4Trpd8u32K5esXSmZ/ncKo61qrc2FPOaTj37WuPFm1/r5VdMzVNsm3j1
        nHl6mOZlL++nu3lvTzfeov13xvzLt1kSP/JWeRQw+7MbfA7gf/G4lXVm+bGdh1KYzObEPPZS
        YinOSDTUYi4qTgQABaXelwADAAA=
X-CMS-MailID: 20200909144708eucas1p22c7a9c941f4656ff4efc94e1d156a9a6
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
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Georgi,

On 09.09.2020 11:07, Georgi Djakov wrote:
> On 8/28/20 17:49, Sylwester Nawrocki wrote:
>> On 30.07.2020 14:28, Sylwester Nawrocki wrote:
>>> On 09.07.2020 23:04, Rob Herring wrote:
>>>> On Thu, Jul 02, 2020 at 06:37:19PM +0200, Sylwester Nawrocki wrote:
>>>>> Add documentation for new optional properties in the exynos bus nodes:
>>>>> samsung,interconnect-parent, #interconnect-cells, bus-width.
>>>>> These properties allow to specify the SoC interconnect structure which
>>>>> then allows the interconnect consumer devices to request specific
>>>>> bandwidth requirements.
>>>>>
>>>>> Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
>>>>> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
>>
>>>>> --- a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
>>>>> +++ b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt

>>>>> +Optional properties for interconnect functionality (QoS frequency constraints):
>>>>> +- samsung,interconnect-parent: phandle to the parent interconnect node; for
>>>>> +  passive devices should point to same node as the exynos,parent-bus property.
>>
>>>> Adding vendor specific properties for a common binding defeats the 
>>>> point.
>>
>> Actually we could do without any new property if we used existing interconnect
>> consumers binding to specify linking between the provider nodes. I think those
>> exynos-bus nodes could well be considered both the interconnect providers 
>> and consumers. The example would then be something along the lines 
>> (yes, I know the bus node naming needs to be fixed):
>>
>> 	soc {
>> 		bus_dmc: bus_dmc {
>> 			compatible = "samsung,exynos-bus";
>> 			/* ... */
>> 			samsung,data-clock-ratio = <4>;
>> 			#interconnect-cells = <0>;
>> 		};
>>
>> 		bus_leftbus: bus_leftbus {
>> 			compatible = "samsung,exynos-bus";
>> 			/* ... */
>> 			interconnects = <&bus_leftbus &bus_dmc>;
>> 			#interconnect-cells = <0>;
>> 		};
>>
>> 		bus_display: bus_display {
>> 			compatible = "samsung,exynos-bus";
>> 			/* ... */
>> 			interconnects = <&bus_display &bus_leftbus>;
> 
> Hmm, bus_display being a consumer of itself is a bit odd? Did you mean:
>  			interconnects = <&bus_dmc &bus_leftbus>;

Might be, but we would need to swap the phandles so <source, destination>
order is maintained, i.e. interconnects = <&bus_leftbus &bus_dmc>;

My intention here was to describe the 'bus_display -> bus_leftbus' part 
of data path 'bus_display -> bus_leftbus -> bus_dmc', bus_display is
really a consumer of 'bus_leftbus -> bus_dmc' path.

I'm not sure if it is allowed to specify only single phandle (and 
interconnect provider specifier) in the interconnect property, that would
be needed for the bus_leftbus node to define bus_dmc as the interconnect 
destination port. There seems to be such a use case in arch/arm64/boot/
dts/allwinner/sun50i-a64.dtsi. 

>> 			#interconnect-cells = <0>;
>> 		};
>>
>>
>> 		&mixer {
>> 			compatible = "samsung,exynos4212-mixer";
>> 			interconnects = <&bus_display &bus_dmc>;
>> 			/* ... */
>> 		};
>> 	};
>>
>> What do you think, Georgi, Rob?
> 
> I can't understand the above example with bus_display being it's own consumer.
> This seems strange to me. Could you please clarify it?

> Otherwise the interconnect consumer DT bindings are already well established
> and i don't see anything preventing a node to be both consumer and provider.
> So this should be okay in general.

Thanks, below is an updated example according to your suggestions. 
Does it look better now?

---------------------------8<------------------------------
soc {
	bus_dmc: bus_dmc {
		compatible = "samsung,exynos-bus";
		/* ... */
		samsung,data-clock-ratio = <4>;
		#interconnect-cells = <0>;
	};

	bus_leftbus: bus_leftbus {
		compatible = "samsung,exynos-bus";
		/* ... */
		interconnects = <&bus_dmc>;
		#interconnect-cells = <0>;
	};

	bus_display: bus_display {
		compatible = "samsung,exynos-bus";
		/* ... */
		interconnects = <&bus_leftbus &bus_dmc>;
		#interconnect-cells = <0>;
	};

	&mixer {
		compatible = "samsung,exynos4212-mixer";
		interconnects = <&bus_display &bus_dmc>;
		/* ... */
	};
};
---------------------------8<------------------------------

-- 
Regards,
Sylwester
