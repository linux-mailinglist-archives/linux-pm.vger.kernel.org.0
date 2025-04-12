Return-Path: <linux-pm+bounces-25313-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B81A86DA4
	for <lists+linux-pm@lfdr.de>; Sat, 12 Apr 2025 16:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B26A53AE1B7
	for <lists+linux-pm@lfdr.de>; Sat, 12 Apr 2025 14:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F90D1EDA04;
	Sat, 12 Apr 2025 14:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BG9fppbe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD98A1EB198
	for <linux-pm@vger.kernel.org>; Sat, 12 Apr 2025 14:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744467564; cv=none; b=mLcSQzcdx7E6SgGEnzgZHMkVLGb9t9xlDWfWTS4xo+yuF77QD9uZ5/8eHrxzhfpJeodNa3AjYt1pF8noqogHYM/pl9a2EcIpEGt/PfHRXxl3JR/TFyRqdmfq2awQGt7S1TWT6ZaPXGlRtr6r3bQBbW15IlZN6otMQJMai3nWbkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744467564; c=relaxed/simple;
	bh=+dDevdafqQ32QcXMdXXjtMEflCBC+WxeuY0QrOwC+mI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:In-Reply-To:
	 Content-Type:References; b=KyPulFUgcmnnqMDP+fssjRZB+ha+jbIFJ7JxmD1p4RrjSxVM/LTuwKoru+OoVYbMvq8gwCau39HwJ42K7HSJWTWD7uyWgol89m2vXKDs8NdcU1g9ulHDVDtQ0rFvKOD7vwBcYvuGalrgTnKZse9D/nWh6dqZQyvlG+LyxTqUg50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=BG9fppbe; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250412141059euoutp02ce8dc8f438e02d76d45a3b6438d27945~1l4xJUuuZ2543425434euoutp02H
	for <linux-pm@vger.kernel.org>; Sat, 12 Apr 2025 14:10:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250412141059euoutp02ce8dc8f438e02d76d45a3b6438d27945~1l4xJUuuZ2543425434euoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1744467059;
	bh=9KezgrRa6es4JcT+4kYWjYIOmYWn6gXe5sAC1YUkZfQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=BG9fppbeW6mo00qlehL6bcEBGNzTtD/T1cZSQxlKbg2olY1BeI15/P2lpzCA7PrWB
	 OFBKgqRoBpF39sfg76E/pEG2R+l19kFWcObH0Xxw36dBcca37D6Qne1q9b/0uRr9q2
	 HeBslFWGRNc//tqf7oOlshLZ3GOhRe0vY/4t5J5g=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20250412141058eucas1p2feb9017db063748a836b1b083466e283~1l4wj1SjW1499714997eucas1p2E;
	Sat, 12 Apr 2025 14:10:58 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 31.56.20821.2747AF76; Sat, 12
	Apr 2025 15:10:58 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250412141058eucas1p101684164d8de27c655010ebe4c8b6e75~1l4v6nCSI1684516845eucas1p1E;
	Sat, 12 Apr 2025 14:10:58 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250412141058eusmtrp24d1f9ca0d33b3ddc116860cdbfcf3b91~1l4v520Ue2732027320eusmtrp2M;
	Sat, 12 Apr 2025 14:10:58 +0000 (GMT)
X-AuditID: cbfec7f2-b09c370000005155-50-67fa7472805b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 69.96.19920.1747AF76; Sat, 12
	Apr 2025 15:10:58 +0100 (BST)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250412141057eusmtip11e596436a0d1a77b336532b5b575c4b5~1l4vId8VH0825008250eusmtip1t;
	Sat, 12 Apr 2025 14:10:57 +0000 (GMT)
Message-ID: <3ccbf872-355c-4fec-ab9a-6f2f396625d7@samsung.com>
Date: Sat, 12 Apr 2025 16:10:57 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] dt-bindings: firmware: thead,th1520: Add clocks
 and resets
From: Michal Wilczynski <m.wilczynski@samsung.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Frank Binns
	<frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>
Cc: Stephen Boyd <sboyd@kernel.org>, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, drew@pdp7.com, guoren@kernel.org, wefu@redhat.com,
	p.zabel@pengutronix.de, m.szyprowski@samsung.com,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-pm@vger.kernel.org, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Content-Language: en-US
In-Reply-To: <9bc1ebee-7a41-4465-8015-c156fb6b74cf@samsung.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJKsWRmVeSWpSXmKPExsWy7djP87pFJb/SDVaf0bFYs/cck8X8I+dY
	Le5d2sJkse7pBXaLF3sbWSxezrrHZnF51xw2i8+9Rxgttn1uYbNYe+Quu8WSHbsYLe7eO8Fi
	8X/PDnaLf9c2slgcXxtu0bJ/CouDgEfPzjOMHptWdbJ53Lm2h81j85J6j5a1x5g8+v8aeLzf
	d5XNo2/LKkaPz5vkAjijuGxSUnMyy1KL9O0SuDL2vmxmL/ijW/H84mKmBsb3Kl2MnBwSAiYS
	v979Z+pi5OIQEljBKNH0+RUzhPOFUWL9/hmMEM5nRom2vhcsXYwcYC3zziRCxJczSsyduBCq
	4y2jxPee5Wwgc3kF7CSO77gNZrMIqEosmrifGSIuKHFy5hMWEFtUQF7i/q0Z7CC2sECExI7P
	l8BsNgEjiQfL57OCLBMRKJNonZoAEmYWeMAksXSWPIQtLnHryXwmEJtTwF5iZ89fNoi4vETz
	1tlg90gI7OaUWLbhByPEny4ST1sus0LYwhKvjm9hh7BlJP7vhBgkIZAv8WDrJ2YIuwZo6HEo
	21rizrlfbCD3MAtoSqzfpQ8RdpTofL2JFRImfBI33gpCnMAnMWnbdGaIMK9ER5sQRLWaxNSe
	Xril51ZsY5rAqDQLKUxmIXlsFpJnZiHsXcDIsopRPLW0ODc9tdgwL7Vcrzgxt7g0L10vOT93
	EyMw9Z3+d/zTDsa5rz7qHWJk4mA8xCjBwawkwsvl/CtdiDclsbIqtSg/vqg0J7X4EKM0B4uS
	OO+i/a3pQgLpiSWp2ampBalFMFkmDk6pBqaZLvbRvIflrB6VKLdqFHZNWFh++VvWxot+JSoV
	P7TmBk4zyLdW92z44JK97pSm87fbbU5mKn0bNRcwtPxft/Jp4IUNTHzeR924HZhZZzvzv7j3
	eUlUN58h3zuOnDn/5zQ75F814dyZsG1p0VrFY/cDyi0vbcxaOq96afgfji2TJ6vP172Tf/WV
	e93O33LzIvbbJh9lX2LulfiO//fNJdccJLe0qv3KkTj3aZ1RxtIPUybmZky9I3xwYy2j8S/9
	S5596hZ+NjWp1zO9v1kHxc3zX65SG9bC0bb09iJnY6fW9r8FnKor87UmR/b5C4datHjva/dd
	NFHgoN2WT+5Pptye0fBtiuHjzsUcyo4nFiixFGckGmoxFxUnAgAIg/OD7AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRmVeSWpSXmKPExsVy+t/xu7pFJb/SDa6tYbRYs/cck8X8I+dY
	Le5d2sJkse7pBXaLF3sbWSxezrrHZnF51xw2i8+9Rxgttn1uYbNYe+Quu8WSHbsYLe7eO8Fi
	8X/PDnaLf9c2slgcXxtu0bJ/CouDgEfPzjOMHptWdbJ53Lm2h81j85J6j5a1x5g8+v8aeLzf
	d5XNo2/LKkaPz5vkAjij9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxS
	UnMyy1KL9O0S9DL2vmxmL/ijW/H84mKmBsb3Kl2MHBwSAiYS884kdjFycQgJLGWU2L10HXsX
	IydQXEbiWvdLFghbWOLPtS42iKLXjBIrfuwHK+IVsJM4vuM2G4jNIqAqsWjifmaIuKDEyZlP
	wJpFBeQl7t+aAVYvLBAhsePzJTCbTcBI4sHy+awgtohAmcT1V0cZQRYwCzxgkvj6bR3UtoPM
	Eud27wKbyiwgLnHryXwmEJtTwF5iZ89fNpAXmAXUJdbPE4IokZdo3jqbeQKj0Cwkd8xC0j0L
	oWMWko4FjCyrGEVSS4tz03OLDfWKE3OLS/PS9ZLzczcxAuN927Gfm3cwznv1Ue8QIxMH4yFG
	CQ5mJRFeLudf6UK8KYmVValF+fFFpTmpxYcYTYFhMZFZSjQ5H5hw8kriDc0MTA1NzCwNTC3N
	jJXEed0un08TEkhPLEnNTk0tSC2C6WPi4JRqYPLZw/88YN0yJd7fUyX1ItWuv56VZCwkddBp
	1rd25gSR4mKTXpFE/RfCCqvPWX2Ineyqk8Um4OLMMjldxjnMqkzFZ1tx6ptZ3t+ktpnqdjor
	zrKKbVhwJO5EzNsfiXezd/CuaJlb7G1zpYQlLOOHTNLK6HX1WW8n5Sx3+vkh69fqU/+ORc4+
	zs99I+nK3bOqSSty5sZ92OW+Zu3FXSb+TdJbJy26HCJ3+5O29c8FCt5vGXN3163V03Z+43Cg
	/U6cB0tB1Ya+nffDpGedn3FeTL62yOPzqwl+mx9yswX8Dsu7O+POS4eVGh+Ed/7vVus4y59U
	5PXA56pVyw32q+3r1tqJb2sIVf3Qe+xUZ7nDdyWW4oxEQy3mouJEAHrSHgeAAwAA
X-CMS-MailID: 20250412141058eucas1p101684164d8de27c655010ebe4c8b6e75
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250409093031eucas1p2222e9dc4d354e9b66b7183922c0fb3cf
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250409093031eucas1p2222e9dc4d354e9b66b7183922c0fb3cf
References: <CGME20250409093031eucas1p2222e9dc4d354e9b66b7183922c0fb3cf@eucas1p2.samsung.com>
	<20250409093025.2917087-1-m.wilczynski@samsung.com>
	<20250409093025.2917087-2-m.wilczynski@samsung.com>
	<CAPDyKFpoSwKAmiWyvNt1fVyu6=NU1oVOmQLVuzX_bG=-5KrM2Q@mail.gmail.com>
	<75f97336-6cb5-47fc-ac88-5fe7842e2838@samsung.com>
	<CAPDyKFq=BF5f2i_Sr1cmVqtVAMgr=0FqsksL7RHZLKn++y0uwg@mail.gmail.com>
	<9bc1ebee-7a41-4465-8015-c156fb6b74cf@samsung.com>



On 4/12/25 09:53, Michal Wilczynski wrote:
> 
> 
> On 4/10/25 14:34, Ulf Hansson wrote:
>> On Thu, 10 Apr 2025 at 12:42, Michal Wilczynski
>> <m.wilczynski@samsung.com> wrote:
>>>
>>>
>>>
>>> On 4/9/25 12:41, Ulf Hansson wrote:
>>>> On Wed, 9 Apr 2025 at 11:30, Michal Wilczynski <m.wilczynski@samsung.com> wrote:
>>>>>
>>>>> Prepare for handling GPU clock and reset sequencing through a generic
>>>>> power domain by adding clock and reset properties to the TH1520 AON
>>>>> firmware bindings.
>>>>>
>>>>> The T-HEAD TH1520 GPU requires coordinated management of two clocks
>>>>> (core and sys) and two resets (GPU and GPU CLKGEN). Due to SoC-specific
>>>>> requirements, the CLKGEN reset must be carefully managed alongside clock
>>>>> enables to ensure proper GPU operation, as discussed on the mailing list
>>>>> [1].
>>>>>
>>>>> Since the coordination is now handled through a power domain, only the
>>>>> programmable clocks (core and sys) are exposed. The GPU MEM clock is
>>>>> ignored, as it is not controllable on the TH1520 SoC.
>>>>>
>>>>> This approach follows upstream maintainers' recommendations [1] to
>>>>> avoid SoC-specific details leaking into the GPU driver or clock/reset
>>>>> frameworks directly.
>>>>>
>>>>> [1] - https://lore.kernel.org/all/38d9650fc11a674c8b689d6bab937acf@kernel.org/
>>>>>
>>>>> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
>>>>> ---
>>>>>  .../bindings/firmware/thead,th1520-aon.yaml   | 28 +++++++++++++++++++
>>>>>  1 file changed, 28 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/firmware/thead,th1520-aon.yaml b/Documentation/devicetree/bindings/firmware/thead,th1520-aon.yaml
>>>>> index bbc183200400..8075874bcd6b 100644
>>>>> --- a/Documentation/devicetree/bindings/firmware/thead,th1520-aon.yaml
>>>>> +++ b/Documentation/devicetree/bindings/firmware/thead,th1520-aon.yaml
>>>>> @@ -25,6 +25,16 @@ properties:
>>>>>    compatible:
>>>>>      const: thead,th1520-aon
>>>>>
>>>>> +  clocks:
>>>>> +    items:
>>>>> +      - description: GPU core clock
>>>>> +      - description: GPU sys clock
>>>>> +
>>>>> +  clock-names:
>>>>> +    items:
>>>>> +      - const: gpu-core
>>>>> +      - const: gpu-sys
>>>>
>>>> These clocks don't look like they belong to the power-domain node, but
>>>> rather the GPU's node.
>>>>
>>>> Or is this in fact the correct description of the HW?
>>>
>>> Hi,
>>> Thank you for your input. Based on my understanding of Stephen
>>> presentation the power-domain layer could act as a middleware layer
>>> (like ACPI) that could own resources. That being said it was also stated
>>> that the proposed approach should work with already existing device
>>> trees, which implies that the DT should remain as is.
>>>
>>> So I could get the resources using attach_dev and detach_dev, but there
>>> are two problems with that:
>>>
>>> 1) The GPU driver will try to manage clocks/reset on it's own using those functions
>>>    if I provide non-stub working clocks and reset:
>>> static const struct dev_pm_ops pvr_pm_ops = {
>>>         RUNTIME_PM_OPS(pvr_power_device_suspend, pvr_power_device_resume,
>>>                        pvr_power_device_idle)
>>> };
>>>
>>> So obviously I should invent a way to tell the drm/imagination driver to
>>> NOT manage. One obvious way to do this is to introduce new flag to genpd.flags
>>> called let's say GENPD_FLAG_EXCLUSIVE_CONTROL, which would tell the consumer
>>> driver that the power management is being done only done from the PM
>>> middleware driver.
>>
>> Something along those lines. Although, I think the below twist to the
>> approach would be better.
>>
>> Some flag (maybe just a bool) should be set dynamically when the
>> ->attach_dev() callback is invoked and it should be a per device flag,
>> not a per genpd flag. In this way, the genpd provider driver can make
>> runtime decisions, perhaps even based on some DT compatible string for
>> the device being attached to it, whether it should manage PM resources
>> or not.
>>
>> Additionally, we need a new genpd helper function that allows the
>> consumer driver to check if the PM resources are managed from the PM
>> domain level (genpd) or not.
>>
>> If it sounds complicated, just let me know I can try to help put the
>> pieces together.
> 
> Thanks, this sounds doable
> 
>>
>>>
>>> 2) The GPU node doesn't want to own the gpu-clkgen reset. In fact nobody
>>>    seems to want to own it, even though theoretically it should be owned by
>>>    the clk_vo as this would describe the hardware best (it's resetting the
>>>    GPU clocks). But then it would be trickier to get it from the PM driver,
>>>    making the code more complex and harder to understand. Nonetheless I
>>>    think it would work.
>>
>> I guess it doesn't really matter to me. Perhaps model it as a reset
>> and make the GPU be the consumer of it?
> 
> GPU driver maintainers already stated that they only want to consume a
> single reset line, that would be 'gpu' [1]. The 'gpu-clkgen' is an orphan in
> this situation, or a part of a SoC specific-glue code, so theoretically
> since the PM driver in our case is also a SoC glue driver we could leave
> the 'gpu-clkgen' in PM DT node.

Frank, Matt
Just to make sure, I would like to ask what you think about this ? Would
you be open to have an extra reset that would be managed from the
generic PM driver in your GPU DT node ?

Regards,
Michał

> 
> [1] - https://lore.kernel.org/all/816db99d-7088-4c1a-af03-b9a825ac09dc@imgtec.com/
>>
>>>
>>> If this sounds good to you I will work on the code.
>>
>> Sure, let's give this a try - I am here to help review and guide the best I can.
> 
> Thank you very much for your support, it’s invaluable!
> 
>>
>> [...]
>>
>> Kind regards
>> Uffe
>>

