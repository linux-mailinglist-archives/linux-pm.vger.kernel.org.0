Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1A2326AFB9
	for <lists+linux-pm@lfdr.de>; Tue, 15 Sep 2020 23:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbgIOVku (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Sep 2020 17:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727573AbgIOVk0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Sep 2020 17:40:26 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71751C06178A
        for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2020 14:40:22 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id j2so4796918wrx.7
        for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2020 14:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZyrGKVFDx4BGNZ/Sa7IJ5z8va1EbUDyxko9EIPRujuM=;
        b=veI3AvonDskRaUwF5ORDqWFJETZI+22t06b/E6CdpcUb2Bzet3eVUU+UbEoXj1wSQD
         OGEwGLzQwLOITt4yQYbu1Ie+NhSn1/be3xk3XtV2QILTMQMBjh+aJ0UpN9pQ8mpszEeE
         kXSR8rL/V1SbcsTZ7EK2+nY4J4F4WSIfRRNfbWPSxbxhUMRUMI097f484mmSRO6pX6rY
         D6pt8gDg5MvVwfT1GtNlmnmorUrZ+k/hCNb2a2/hfjXAYcgXcJqZG+RTzVLyA2KUTthX
         ZjVfvZ0sTXMyhkyKNP+m95A/ZlvhmFnw/gYhj82/QTMufjmd/wgIM63mEm+fXS4iVePJ
         fpOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZyrGKVFDx4BGNZ/Sa7IJ5z8va1EbUDyxko9EIPRujuM=;
        b=HMBZ/2SXeaGUjWBntRwZfZpWjEea2ry2DnbCF/PdwJnzFvAydl4PCBsPSK74CbyoUh
         oBFlMaFYUV5r8eAwo4GXMRI/Tla6CRUzhpCAlw37/HAe9zKXRT6euZ3KjStjvAQhmEYC
         BCT9/PeLfOYS4gzT2swzSUxfkz/D2OqPyVDKLR22/nmVZEvoWdNv7Gv5nJDERdYKrsU2
         rtRe3s0G3pU6hQU/4bmchZd/OQ895rYwojPGMFKh8RE2Jd4KPhLtc7duVigJo2PeACjy
         Ei6ZQ0QnvjfYT9kp9tzZAuylK5xZbETeoWTdw+LFdi0sFQwZ2dHNylf9oCfxelz/cVOI
         3FyQ==
X-Gm-Message-State: AOAM532qbxMOHNjrdSNmjdot0ZqkzZv1Mj2DgmH56PcF0HMljynawSkG
        UwP5MO3RsOzpWLiQtnSxJA/LgQ==
X-Google-Smtp-Source: ABdhPJyxWNiKiFioPsFe2QDV2mvw1qAZrQlyU6fOTAFIT5XSLZvrE8JtKxXTq+yytVPmhh3AebY7qg==
X-Received: by 2002:a5d:69cd:: with SMTP id s13mr22613427wrw.379.1600206021323;
        Tue, 15 Sep 2020 14:40:21 -0700 (PDT)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id g14sm443358wrv.25.2020.09.15.14.40.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2020 14:40:20 -0700 (PDT)
Subject: Re: [PATCH RFC v6 1/6] dt-bindings: exynos-bus: Add documentation for
 interconnect properties
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Rob Herring <robh@kernel.org>
Cc:     cw00.choi@samsung.com, krzk@kernel.org, devicetree@vger.kernel.org,
        a.swigon@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
References: <20200702163724.2218-1-s.nawrocki@samsung.com>
 <CGME20200702163748eucas1p2cf7eab70bc072dea9a95183018b38ad3@eucas1p2.samsung.com>
 <20200702163724.2218-2-s.nawrocki@samsung.com>
 <20200709210448.GA876103@bogus>
 <65af1a5c-8f8a-ef65-07f8-e0b3d04c336c@samsung.com>
 <35d9d396-b553-a815-1f3b-1af4dc37a2ca@samsung.com>
 <b711257d-c34b-b609-3ada-312871967b98@linaro.org>
 <e6e369fb-ccf2-09ed-ad6a-680e67198359@samsung.com>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 xsFNBFjTuRcBEACyAOVzghvyN19Sa/Nit4LPBWkICi5W20p6bwiZvdjhtuh50H5q4ktyxJtp
 1+s8dMSa/j58hAWhrc2SNL3fttOCo+MM1bQWwe8uMBQJP4swgXf5ZUYkSssQlXxGKqBSbWLB
 uFHOOBTzaQBaNgsdXo+mQ1h8UCgM0zQOmbs2ort8aHnH2i65oLs5/Xgv/Qivde/FcFtvEFaL
 0TZ7odM67u+M32VetH5nBVPESmnEDjRBPw/DOPhFBPXtal53ZFiiRr6Bm1qKVu3dOEYXHHDt
 nF13gB+vBZ6x5pjl02NUEucSHQiuCc2Aaavo6xnuBc3lnd4z/xk6GLBqFP3P/eJ56eJv4d0B
 0LLgQ7c1T3fU4/5NDRRCnyk6HJ5+HSxD4KVuluj0jnXW4CKzFkKaTxOp7jE6ZD/9Sh74DM8v
 etN8uwDjtYsM07I3Szlh/I+iThxe/4zVtUQsvgXjwuoOOBWWc4m4KKg+W4zm8bSCqrd1DUgL
 f67WiEZgvN7tPXEzi84zT1PiUOM98dOnmREIamSpKOKFereIrKX2IcnZn8jyycE12zMkk+Sc
 ASMfXhfywB0tXRNmzsywdxQFcJ6jblPNxscnGMh2VlY2rezmqJdcK4G4Lprkc0jOHotV/6oJ
 mj9h95Ouvbq5TDHx+ERn8uytPygDBR67kNHs18LkvrEex/Z1cQARAQABzShHZW9yZ2kgRGph
 a292IDxnZW9yZ2kuZGpha292QGxpbmFyby5vcmc+wsF+BBMBAgAoBQJY07kXAhsDBQkHhM4A
 BgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRCyi/eZcnWWUuvsD/4miikUeAO6fU2Xy3fT
 l7RUCeb2Uuh1/nxYoE1vtXcow6SyAvIVTD32kHXucJJfYy2zFzptWpvD6Sa0Sc58qe4iLY4j
 M54ugOYK7XeRKkQHFqqR2T3g/toVG1BOLS2atooXEU+8OFbpLkBXbIdItqJ1M1SEw8YgKmmr
 JlLAaKMq3hMb5bDQx9erq7PqEKOB/Va0nNu17IL58q+Q5Om7S1x54Oj6LiG/9kNOxQTklOQZ
 t61oW1Ewjbl325fW0/Lk0QzmfLCrmGXXiedFEMRLCJbVImXVKdIt/Ubk6SAAUrA5dFVNBzm2
 L8r+HxJcfDeEpdOZJzuwRyFnH96u1Xz+7X2V26zMU6Wl2+lhvr2Tj7spxjppR+nuFiybQq7k
 MIwyEF0mb75RLhW33sdGStCZ/nBsXIGAUS7OBj+a5fm47vQKv6ekg60oRTHWysFSJm1mlRyq
 exhI6GwUo5GM/vE36rIPSJFRRgkt6nynoba/1c4VXxfhok2rkP0x3CApJ5RimbvITTnINY0o
 CU6f1ng1I0A1UTi2YcLjFq/gmCdOHExT4huywfu1DDf0p1xDyPA1FJaii/gJ32bBP3zK53hM
 dj5S7miqN7F6ZpvGSGXgahQzkGyYpBR5pda0m0k8drV2IQn+0W8Qwh4XZ6/YdfI81+xyFlXc
 CJjljqsMCJW6PdgEH87BTQRY07kXARAAvupGd4Jdd8zRRiF+jMpv6ZGz8L55Di1fl1YRth6m
 lIxYTLwGf0/p0oDLIRldKswena3fbWh5bbTMkJmRiOQ/hffhPSNSyyh+WQeLY2kzl6geiHxD
 zbw37e2hd3rWAEfVFEXOLnmenaUeJFyhA3Wd8OLdRMuoV+RaLhNfeHctiEn1YGy2gLCq4VNb
 4Wj5hEzABGO7+LZ14hdw3hJIEGKtQC65Jh/vTayGD+qdwedhINnIqslk9tCQ33a+jPrCjXLW
 X29rcgqigzsLHH7iVHWA9R5Aq7pCy5hSFsl4NBn1uV6UHlyOBUuiHBDVwTIAUnZ4S8EQiwgv
 WQxEkXEWLM850V+G6R593yZndTr3yydPgYv0xEDACd6GcNLR/x8mawmHKzNmnRJoOh6Rkfw2
 fSiVGesGo83+iYq0NZASrXHAjWgtZXO1YwjW9gCQ2jYu9RGuQM8zIPY1VDpQ6wJtjO/KaOLm
 NehSR2R6tgBJK7XD9it79LdbPKDKoFSqxaAvXwWgXBj0Oz+Y0BqfClnAbxx3kYlSwfPHDFYc
 R/ppSgnbR5j0Rjz/N6Lua3S42MDhQGoTlVkgAi1btbdV3qpFE6jglJsJUDlqnEnwf03EgjdJ
 6KEh0z57lyVcy5F/EUKfTAMZweBnkPo+BF2LBYn3Qd+CS6haZAWaG7vzVJu4W/mPQzsAEQEA
 AcLBZQQYAQIADwUCWNO5FwIbDAUJB4TOAAAKCRCyi/eZcnWWUhlHD/0VE/2x6lKh2FGP+QHH
 UTKmiiwtMurYKJsSJlQx0T+j/1f+zYkY3MDX+gXa0d0xb4eFv8WNlEjkcpSPFr+pQ7CiAI33
 99kAVMQEip/MwoTYvM9NXSMTpyRJ/asnLeqa0WU6l6Z9mQ41lLzPFBAJ21/ddT4xeBDv0dxM
 GqaH2C6bSnJkhSfSja9OxBe+F6LIAZgCFzlogbmSWmUdLBg+sh3K6aiBDAdZPUMvGHzHK3fj
 gHK4GqGCFK76bFrHQYgiBOrcR4GDklj4Gk9osIfdXIAkBvRGw8zg1zzUYwMYk+A6v40gBn00
 OOB13qJe9zyKpReWMAhg7BYPBKIm/qSr82aIQc4+FlDX2Ot6T/4tGUDr9MAHaBKFtVyIqXBO
 xOf0vQEokkUGRKWBE0uA3zFVRfLiT6NUjDQ0vdphTnsdA7h01MliZLQ2lLL2Mt5lsqU+6sup
 Tfql1omgEpjnFsPsyFebzcKGbdEr6vySGa3Cof+miX06hQXKe99a5+eHNhtZJcMAIO89wZmj
 7ayYJIXFqjl/X0KBcCbiAl4vbdBw1bqFnO4zd1lMXKVoa29UHqby4MPbQhjWNVv9kqp8A39+
 E9xw890l1xdERkjVKX6IEJu2hf7X3MMl9tOjBK6MvdOUxvh1bNNmXh7OlBL1MpJYY/ydIm3B
 KEmKjLDvB0pePJkdTw==
Message-ID: <ae438269-fbb5-326a-aa97-f04033c2b3b6@linaro.org>
Date:   Wed, 16 Sep 2020 00:40:18 +0300
MIME-Version: 1.0
In-Reply-To: <e6e369fb-ccf2-09ed-ad6a-680e67198359@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sylwester,

On 9/9/20 17:47, Sylwester Nawrocki wrote:
> Hi Georgi,
> 
> On 09.09.2020 11:07, Georgi Djakov wrote:
>> On 8/28/20 17:49, Sylwester Nawrocki wrote:
>>> On 30.07.2020 14:28, Sylwester Nawrocki wrote:
>>>> On 09.07.2020 23:04, Rob Herring wrote:
>>>>> On Thu, Jul 02, 2020 at 06:37:19PM +0200, Sylwester Nawrocki wrote:
>>>>>> Add documentation for new optional properties in the exynos bus nodes:
>>>>>> samsung,interconnect-parent, #interconnect-cells, bus-width.
>>>>>> These properties allow to specify the SoC interconnect structure which
>>>>>> then allows the interconnect consumer devices to request specific
>>>>>> bandwidth requirements.
>>>>>>
>>>>>> Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
>>>>>> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
>>>
>>>>>> --- a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
>>>>>> +++ b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
> 
>>>>>> +Optional properties for interconnect functionality (QoS frequency constraints):
>>>>>> +- samsung,interconnect-parent: phandle to the parent interconnect node; for
>>>>>> +  passive devices should point to same node as the exynos,parent-bus property.
>>>
>>>>> Adding vendor specific properties for a common binding defeats the 
>>>>> point.
>>>
>>> Actually we could do without any new property if we used existing interconnect
>>> consumers binding to specify linking between the provider nodes. I think those
>>> exynos-bus nodes could well be considered both the interconnect providers 
>>> and consumers. The example would then be something along the lines 
>>> (yes, I know the bus node naming needs to be fixed):
>>>
>>> 	soc {
>>> 		bus_dmc: bus_dmc {
>>> 			compatible = "samsung,exynos-bus";
>>> 			/* ... */
>>> 			samsung,data-clock-ratio = <4>;
>>> 			#interconnect-cells = <0>;
>>> 		};
>>>
>>> 		bus_leftbus: bus_leftbus {
>>> 			compatible = "samsung,exynos-bus";
>>> 			/* ... */
>>> 			interconnects = <&bus_leftbus &bus_dmc>;
>>> 			#interconnect-cells = <0>;
>>> 		};
>>>
>>> 		bus_display: bus_display {
>>> 			compatible = "samsung,exynos-bus";
>>> 			/* ... */
>>> 			interconnects = <&bus_display &bus_leftbus>;
>>
>> Hmm, bus_display being a consumer of itself is a bit odd? Did you mean:
>>  			interconnects = <&bus_dmc &bus_leftbus>;
> 
> Might be, but we would need to swap the phandles so <source, destination>
> order is maintained, i.e. interconnects = <&bus_leftbus &bus_dmc>;

Ok, i see. Thanks for clarifying! Currently the "interconnects" property is
defined as a pair of initiator and target nodes. You can keep it also as
interconnects = <&bus_display &bus_dmc>, but you will need to figure out
during probe that there is another node in the middle and defer. I assume
that if a provider is also an interconnect consumer, we will link it to
whatever nodes are specified in the "interconnects" property?

> My intention here was to describe the 'bus_display -> bus_leftbus' part 
> of data path 'bus_display -> bus_leftbus -> bus_dmc', bus_display is
> really a consumer of 'bus_leftbus -> bus_dmc' path.
>
> I'm not sure if it is allowed to specify only single phandle (and 
> interconnect provider specifier) in the interconnect property, that would
> be needed for the bus_leftbus node to define bus_dmc as the interconnect 
> destination port. There seems to be such a use case in arch/arm64/boot/
> dts/allwinner/sun50i-a64.dtsi.

In the general case you have to specify pairs. The "dma-mem" is a reserved
name for devices that perform DMA through another bus with separate address
translation rules.

>>> 			#interconnect-cells = <0>;
>>> 		};
>>>
>>>
>>> 		&mixer {
>>> 			compatible = "samsung,exynos4212-mixer";
>>> 			interconnects = <&bus_display &bus_dmc>;
>>> 			/* ... */
>>> 		};
>>> 	};
>>>
>>> What do you think, Georgi, Rob?
>>
>> I can't understand the above example with bus_display being it's own consumer.
>> This seems strange to me. Could you please clarify it?
> 
>> Otherwise the interconnect consumer DT bindings are already well established
>> and i don't see anything preventing a node to be both consumer and provider.
>> So this should be okay in general.
> 
> Thanks, below is an updated example according to your suggestions. 
> Does it look better now?
> 
> ---------------------------8<------------------------------
> soc {
> 	bus_dmc: bus_dmc {
> 		compatible = "samsung,exynos-bus";
> 		/* ... */
> 		samsung,data-clock-ratio = <4>;
> 		#interconnect-cells = <0>;
> 	};
> 
> 	bus_leftbus: bus_leftbus {
> 		compatible = "samsung,exynos-bus";
> 		/* ... */
> 		interconnects = <&bus_dmc>;
> 		#interconnect-cells = <0>;
> 	};
> 
> 	bus_display: bus_display {
> 		compatible = "samsung,exynos-bus";
> 		/* ... */
> 		interconnects = <&bus_leftbus &bus_dmc>;
> 		#interconnect-cells = <0>;
> 	};
> 
> 	&mixer {
> 		compatible = "samsung,exynos4212-mixer";
> 		interconnects = <&bus_display &bus_dmc>;
> 		/* ... */
> 	};
> };
> ---------------------------8<------------------------------

It's difficult to have a common way to describe all the different kinds of
topologies in DT, as some SoCs are very complex, having multi-tiered topologies
with hundreds of nodes, with multiple links between them etc. Currently, the
idea is to have the topology as platform data, but i guess that you want to
avoid this. I hope that we will be able to describe simpler topologies in DT in
the future, but we don't have such support in the framework yet.

So maybe we could try your proposal and see how it will work for exynos.

Thanks,
Georgi
