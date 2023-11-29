Return-Path: <linux-pm+bounces-516-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A3C7FDDE4
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 18:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 335C41C209D6
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 17:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B813B7A1;
	Wed, 29 Nov 2023 17:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 16BA685;
	Wed, 29 Nov 2023 09:03:35 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D874AC15;
	Wed, 29 Nov 2023 09:04:21 -0800 (PST)
Received: from [10.1.30.35] (e110479.arm.com [10.1.30.35])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 825373F73F;
	Wed, 29 Nov 2023 09:03:31 -0800 (PST)
Message-ID: <a097a613-14c1-4a53-bbe1-c44964e7ecaa@arm.com>
Date: Wed, 29 Nov 2023 17:03:24 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] thermal: sun8i: add syscon register access code
Content-Language: en-US
To: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Vasily Khoruzhick <anarsoul@gmail.com>, Yangtao Li
 <tiny.windzz@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, "Rafael J . Wysocki"
 <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Martin Botka <martin.botka@somainline.org>,
 Bob McChesney <bob@electricworry.net>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, Icenowy Zheng <icenowy@aosc.io>,
 Maxime Ripard <mripard@kernel.org>
References: <20231128005849.19044-1-andre.przywara@arm.com>
 <20231128005849.19044-5-andre.przywara@arm.com>
 <ddceb30f-1778-4312-af91-97813fe3c6fb@linaro.org>
 <20231128143309.38a4ce61@donnerap.manchester.arm.com>
 <4e90608e-aca5-4b57-be76-350ad54f9e7c@linaro.org>
 <20231128161010.26657e76@donnerap.manchester.arm.com>
 <CAL_Jsq+9J1=+gZ83QyedAWbFN=AwSB8ue+o4TM7F6yu5_62z3g@mail.gmail.com>
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <CAL_Jsq+9J1=+gZ83QyedAWbFN=AwSB8ue+o4TM7F6yu5_62z3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 28/11/2023 16:50, Rob Herring wrote:
> On Tue, Nov 28, 2023 at 10:10 AM Andre Przywara <andre.przywara@arm.com> wrote:
>>
>> On Tue, 28 Nov 2023 15:48:18 +0100
>> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>>
>> Hi,
>>
>> (adding Maxime for the syscon question below)
>>
>>> On 28/11/2023 15:33, Andre Przywara wrote:
>>>> On Tue, 28 Nov 2023 08:43:32 +0100
>>>> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>>>>
>>>> Hi,
>>>>
>>>>> On 28/11/2023 01:58, Andre Przywara wrote:
>>>>>>
>>>>>> +static struct regmap *sun8i_ths_get_syscon_regmap(struct device_node *node)
>>>>>> +{
>>>>>> + struct device_node *syscon_node;
>>>>>> + struct platform_device *syscon_pdev;
>>>>>> + struct regmap *regmap = NULL;
>>>>>> +
>>>>>> + syscon_node = of_parse_phandle(node, "syscon", 0);
>>>>>
>>>>> Nope. For the 100th time, this cannot be generic.
> 
> Unless it is the 100th time for the submitter, please just point to
> the documentation.
> 
> Can we simply ban "syscon" as a property name? It looks like we have
> 65 cases in upstream dts files. Maybe that's doable. This is where we
> need levels of warnings with okay for existing vs. don't use in new
> designs.
> 
>>>> OK. Shall this name refer to the required functionality (temperature
>>>> offset fix) or to the target syscon node (like allwinner,misc-syscon).
>>>> The problem is that this is really a syscon, as in: "random collection of
>>>> bits that we didn't know where else to put in", so "syscon" alone actually
>>>> says it all.
>>>
>>> Every syscon is a "random collection of bits...", but not every "random
>>> collection of bits..." is a syscon.
>>>
>>> Your target device does not implement syscon nodes. Your Linux
>>> implementation does not use it as syscon. Therefore if something does
>>> not look like syscon and does not behave like syscon, it is not a syscon.
>>>
>>> I looked at the bit and this is SRAM, not syscon. I am sorry, but it is
>>> something entirely different and we have a binding for it: "sram", I think.
>>
>> Well, it's somehow both: On the face of it it's a SRAM controller, indeed:
>> it can switch the control of certain SRAM regions between CPU access and
>> peripheral access (for the video and the display engine). But then it's
>> also a syscon, because on top of that, it also controls those random bits,
>> for instance the EMAC clock register, and this ominous THS bit.
>> I guess in hindsight we should have never dropped that "syscon" string
>> then, but I am not sure if adding it back has side effects?
>>
>> And as I mentioned in the cover letter: modelling this as some SRAM
>> region, as you suggest, might be an alternative, but it doesn't sound right
>> either, as I don't think it really is one: I just tried in U-Boot, and I
>> can write and read the whole SRAM C region just fine, with and without the
>> bit set. And SRAM content is preserved, even with the thermal sensor
>> running and the bit cleared (or set).
>>
>> So adding the "syscon" to the compatible would fix most things, but then
>> we need to keep the open coded lookup code in dwmac-sun8i.c (because older
>> DTs would break otherwise).
> 
> Really, I'd like to get rid of the "syscon" compatible. It is nothing
> more than a flag for Linux to create a regmap.

Yeah, so thinking about it indeed feels a bit like we are changing the 
DT here to cater for some Linux implementation detail. After all we 
already access the regmap successfully in dwmac-sun8i.c, is that 
approach frowned upon (because: driver model) and just tolerated because 
it's already in the code base?

> Not a fully baked idea, but perhaps what is needed is drivers that
> request a regmap for a node simply get one regardless. That kind of > throws out the Linux driver model though. Alternatively with no
> "syscon" compatible, we'd have to have table(s) of 100s of compatibles
> in the kernel.

So do you mean to either just remove the explicit syscon compatible 
check in syscon_node_to_regmap(), or replace it with a check against a 
list of allowed devices?
Wouldn't it be sufficient to leave that check to the (syscon-like) 
devices, by them exporting a regmap in the first place or not? And we 
can do filtering of accesses there, like we do in sunxi_sram.c?

Cheers,
Andre


> 
> Rob

