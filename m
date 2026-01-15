Return-Path: <linux-pm+bounces-40939-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE51DD25668
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 16:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6DA0C3018978
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 15:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5663AE701;
	Thu, 15 Jan 2026 15:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPMKsVzD"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB05E3A9D97;
	Thu, 15 Jan 2026 15:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768491287; cv=none; b=Kq+/cjYz8eI84yaqPcBRY4+SEQZYJAV6vwyZtTzRToA3gTYNi5PFy/ZOvoS9lTE/sz6PW1rCtld0e0Jq+uf7EaupeulUDLmqD5KaV/1lqvoD05H10OftS5yvoD2ZG1dduRhDgGVFqjivFeIm3KgN+LXwyA/vNwUhY9Iulz3WiqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768491287; c=relaxed/simple;
	bh=0JxRnZ4zP0bNYiDg6+YLfy06LKhjX39gyT0+B2N4vG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gJPnZzM//n0lR2W0R6fWxVshx5aWP64YKr7Kxk8TKt5UXAsY4IzKNub+yc00jOQvs2maMwsJ3XRYBdqw2+kqAG1nYtWoiJJRNJtrKyXMerQk0jZgtS+dpA9pBR3cdJws7JA6mq2UEKmhYOoOHaJK/XwJkK2EtO/vs/UsbDxiPZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPMKsVzD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC273C116D0;
	Thu, 15 Jan 2026 15:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768491286;
	bh=0JxRnZ4zP0bNYiDg6+YLfy06LKhjX39gyT0+B2N4vG8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oPMKsVzDcCt+ji0XfhGCxdFchmNMT8/iu5YPNYfGkGwthPZPabD/negWeDvxnRiXM
	 xQip8+Hs8JehnqDmYpBQhtLttYVYQtSVRljY35Gf6PTJkck9zfxe9h+OcXPee7IRxW
	 NHxuqZ8jsWMFtcb8uOnUuD1vgL4zjn1efTGjxEP8ZnYDRPy6ZJbvcepFVb9wesUvt+
	 LjCzV7ZyCawnDLw7i4RS3aK/GLRL9lFvJia0I5E4Cvh95KwPThGbIKQZoA+T2NPh4P
	 zMblEjwY1yEe74hbSaLTSlUK6zAXCxesj5sZJMrAK4Og3wQseLMN5Gd9uARNI3zxTY
	 uu0rWf1GEuXZg==
Message-ID: <e2f028d6-774f-4773-889f-7d56b833067e@kernel.org>
Date: Thu, 15 Jan 2026 16:34:39 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] dt-bindings: mfd: Add Google GS101 TMU Syscon
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Peter Griffin <peter.griffin@linaro.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, willmcvicker@google.com,
 jyescas@google.com, shin.son@samsung.com, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20260114-acpm-tmu-v1-0-cfe56d93e90f@linaro.org>
 <20260114-acpm-tmu-v1-3-cfe56d93e90f@linaro.org>
 <20260115-slim-denim-potoo-cad9cb@quoll>
 <200d34bf-150e-4f8a-b400-2f54863502ac@linaro.org>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <200d34bf-150e-4f8a-b400-2f54863502ac@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/01/2026 15:53, Tudor Ambarus wrote:
> 
> 
> On 1/15/26 3:36 PM, Krzysztof Kozlowski wrote:
>> On Wed, Jan 14, 2026 at 02:16:31PM +0000, Tudor Ambarus wrote:
>>> Document the bindings for the Thermal Management Unit (TMU) System
>>> Controller found on Google GS101 SoCs.
>>>
>>> This memory-mapped block exposes the registers required for reading
>>> thermal interrupt status bits. It functions as a syscon provider,
>>
>> I don't think this is syscon, but the actual TMU. Syscon is various,
>> unrelated system configuration registers.
>>
>>> allowing the main thermal driver to access these registers while
>>> the firmware manages the core thermal logic.
>>>
>>> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
>>> ---
>>>  .../bindings/mfd/google,gs101-tmu-syscon.yaml      | 37 ++++++++++++++++++++++
>>>  1 file changed, 37 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mfd/google,gs101-tmu-syscon.yaml b/Documentation/devicetree/bindings/mfd/google,gs101-tmu-syscon.yaml
>>> new file mode 100644
>>> index 0000000000000000000000000000000000000000..6a11e43abeaa23ee473be2153478436856277714
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/mfd/google,gs101-tmu-syscon.yaml
>>
>> Not MFD either, but soc.
> 
> You are right, it's not a syscon, it's just a normal thermal IP block
> from which I need to access the interrupt pending registers.
> 
> Then I guess I shall describe the new binding in bindings/thermal/,
> please correct me if I'm wrong.
> 
>>
>>> @@ -0,0 +1,37 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/mfd/google,gs101-tmu-syscon.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Google GS101 TMU System Controller
>>> +
>>> +maintainers:
>>> +  - Tudor Ambarus <tudor.ambarus@linaro.org>
>>> +
>>> +description: |
>>
>> Drop |
>>
>>> +  The TMU System Controller provides a memory-mapped interface for
>>> +  accessing the interrupt status registers of the Thermal Management
>>> +  Unit. It is used as a syscon provider for the main TMU driver.
>>
>> No, it is not a syscon provider. Entire last sentence is incorrect. You
>> must describe here hardware and this hardware does not provide any sort
>> of syscon to any sort of driver.
>>
> 
> Indeed.
> 
> I'm going to link the ACPM TMU child node with the TMU node via a
> "samsung,tmu-regs" property.

This could be fine, but I actually wonder what's there. What registers
exactly. For example modern Exynos 88xx, already with APM block, still
have exactly the same TMU unit at 0x1008{04}000 with all typical
triminfo, current temperature and thresholds.

> 
> Some concern that I have is that I describe the clocks and interrupts in
> the ACPM TMU child node. Usually the clocks and interrupts belong to the
> node that contains the reg property. But I guess that's alright because
> the interrupts property is expected to be in the node that the driver
> binds to. For the clocks, by placing it in the ACPM child node, I allow
> runtime PM to manage it.

You have to first know whether these clocks and interrupts are going TO
the ACPM node.

All this looks like designing for drivers, sorry.

> 
> Do you think the below description is accurate?
> 
> soc: soc@0 {
>     tmu_top: thermal-sensor@100a0000 {
>         compatible = "google,gs101-tmu-top";
>         reg = <0x100a0000 0x800>;
>     };
> };
> 
> firmware {
>     acpm_ipc: power-management {
>         compatible = "google,gs101-acpm-ipc";
>         /* ... */
> 
>         thermal-sensor {
>             compatible = "google,gs101-acpm-tmu-top";
>             clocks = <&cmu_misc CLK_GOUT_MISC_TMU_TOP_PCLK>;
>             interrupts = <GIC_SPI 769 IRQ_TYPE_LEVEL_HIGH 0>;

This I doubt, really. Why would ACPM child be hooked via CPU clock and
interrupts?


Best regards,
Krzysztof

