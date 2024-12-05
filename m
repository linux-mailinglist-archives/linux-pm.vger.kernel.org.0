Return-Path: <linux-pm+bounces-18598-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3319E4E41
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 08:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3F4628628C
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 07:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56FD1AF0DD;
	Thu,  5 Dec 2024 07:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M5t80+72"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E42B1AE003;
	Thu,  5 Dec 2024 07:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733383640; cv=none; b=qCFfl2g+C1Nybq33vsdjEueb12R1AKlSLPe8lf+7lrwQC6r6fBcOmAMuNx12ubmuJD7uXfKJ/2GooWik/KXXCm5Luop+4RINd3M/y3Fg2jqAVDiMk5O2xa7TIrOoHIUTGvc2dpBBwLmasDmjPaGq8pOaz8ATY0cqYntQOybTULM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733383640; c=relaxed/simple;
	bh=SuJc6mzm5VsH730y7QpEg/itX9dQOpdmKNjQ5iekAEc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hCtmUpaq5I4KtOLqC32hJygOT58HvpEWaH3TqJrz9er2juYoOvfuXjtYjRJfvJrH/HKJ4LalSnIafaYLakvOZifRtRW22JUywYhtcAI+lKtu403/SOlteC4YTSrfBkdbAnao6NL4zxB0NlB8QWBVS6hOjl4fv4ZsP3ax4/k1vhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M5t80+72; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E161EC4CED1;
	Thu,  5 Dec 2024 07:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733383640;
	bh=SuJc6mzm5VsH730y7QpEg/itX9dQOpdmKNjQ5iekAEc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=M5t80+72qrafHWqFAajm0rw62IqA0kCmRHbuEeFgDKgb7NzLNU+ZFygAdw36lJ2HN
	 izmCMVJxN58ymkwAM4bmE0WEe8URuFA7696Z+R06mQBreOwGJKclSRxiUVJPRAyC/N
	 w8vCIM4ZQDN9jM1QjL+ZNKlv225yri3B2UuHd0eGImvsUnDGhbtKhZrRKZ3v47cqBk
	 FC540Tyhq7Df7JOxguYxR95MAY/kO6TysgQksysPC/MUY/v5X2mC/sOp3xEiAOQufx
	 AlHo/BR77b7UX3EkZ2IDPMJyfOScZV/zRTAUZ9LMvWJVKAYClolkG2SxJMinrZTyzY
	 CE+QRhiLlgb9A==
Message-ID: <9c6d9a42-78e8-4cf0-9591-c3d009fee582@kernel.org>
Date: Thu, 5 Dec 2024 08:27:08 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 05/14] dt-bindings: clock: thead,th1520: Add
 support for Video Output subsystem
To: Michal Wilczynski <m.wilczynski@samsung.com>, mturquette@baylibre.com,
 sboyd@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 drew@pdp7.com, guoren@kernel.org, wefu@redhat.com, jassisinghbrar@gmail.com,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 frank.binns@imgtec.com, matt.coster@imgtec.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, ulf.hansson@linaro.org,
 jszhang@kernel.org, m.szyprowski@samsung.com
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org
References: <20241203134137.2114847-1-m.wilczynski@samsung.com>
 <CGME20241203134155eucas1p1e90c71c4f8eb5da41d2cc8a500f54dc7@eucas1p1.samsung.com>
 <20241203134137.2114847-6-m.wilczynski@samsung.com>
 <f21ffd12-167b-4d10-9017-33041ec322b0@kernel.org>
 <07bfb02a-1df3-4a03-83bb-d7edc540739d@samsung.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <07bfb02a-1df3-4a03-83bb-d7edc540739d@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/12/2024 11:11, Michal Wilczynski wrote:
> 
> 
> On 12/3/24 16:45, Krzysztof Kozlowski wrote:
>> On 03/12/2024 14:41, Michal Wilczynski wrote:
>>> The device tree bindings for the T-Head TH1520 SoC clocks currently
>>> support only the Application Processor (AP) subsystem. This commit
>>> extends the bindings to include the Video Output (VO) subsystem clocks.
>>>
>>> Update the YAML schema to define the VO subsystem clocks, allowing the
>>> clock driver to configure and manage these clocks appropriately. This
>>> addition is necessary to enable the proper operation of the video output
>>> features on the TH1520 SoC.
>>>
>>> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
>>> ---
>>>  .../bindings/clock/thead,th1520-clk-ap.yaml   | 31 +++++++++++++++----
>>>  1 file changed, 25 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.yaml b/Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.yaml
>>> index 4a0806af2bf9..5a8f1041f766 100644
>>> --- a/Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.yaml
>>> +++ b/Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.yaml
>>> @@ -4,11 +4,13 @@
>>>  $id: https://protect2.fireeye.com/v1/url?k=f595e769-941ef222-f5946c26-74fe485fb305-6d0b73471bbfc1a2&q=1&e=6b918e4d-d81f-4b44-8516-776d7b4f9dae&u=http%3A%2F%2Fdevicetree.org%2Fschemas%2Fclock%2Fthead%2Cth1520-clk-ap.yaml%23
>>>  $schema: https://protect2.fireeye.com/v1/url?k=5b94114b-3a1f0400-5b959a04-74fe485fb305-0e2c50f5c24cf3e9&q=1&e=6b918e4d-d81f-4b44-8516-776d7b4f9dae&u=http%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23
>>>  
>>> -title: T-HEAD TH1520 AP sub-system clock controller
>>> +title: T-HEAD TH1520 sub-systems clock controller
>>>  
>>>  description: |
>>> -  The T-HEAD TH1520 AP sub-system clock controller configures the
>>> -  CPU, DPU, GMAC and TEE PLLs.
>>> +  The T-HEAD TH1520 sub-systems clock controller configures the
>>> +  CPU, DPU, GMAC and TEE PLLs for the AP subsystem. For the VO
>>> +  subsystem clock gates can be configured for the HDMI, MIPI and
>>> +  the GPU.
>>>  
>>>    SoC reference manual
>>>    https://protect2.fireeye.com/v1/url?k=cceb6120-ad60746b-cceaea6f-74fe485fb305-b294b70f1b52a5ab&q=1&e=6b918e4d-d81f-4b44-8516-776d7b4f9dae&u=https%3A%2F%2Fopenbeagle.org%2Fbeaglev-ahead%2Fbeaglev-ahead%2F-%2Fblob%2Fmain%2Fdocs%2FTH1520%2520System%2520User%2520Manual.pdf
>>> @@ -20,7 +22,9 @@ maintainers:
>>>  
>>>  properties:
>>>    compatible:
>>> -    const: thead,th1520-clk-ap
>>> +    enum:
>>> +      - thead,th1520-clk-ap
>>> +      - thead,th1520-clk-vo
>>>  
>>>    reg:
>>>      maxItems: 1
>>> @@ -29,6 +33,17 @@ properties:
>>>      items:
>>>        - description: main oscillator (24MHz)
>>>  
>>> +  thead,vosys-regmap:
>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>> +    description: |
>>> +      Phandle to a syscon node representing the shared register
>>> +      space of the VO (Video Output) subsystem. This register space
>>> +      includes both clock control registers and other control
>>> +      registers used for operations like resetting the GPU. Since
>>
>>
>> It seems you wanted to implement reset controller...
> 
> Thank you for your feedback.
> 
> I understand your concern about the reset controller. In the TH1520 SoC,
> the GPU doesn't have its own reset controller. Instead, its reset is
> managed through the power domain's registers as part of the power-up
> sequence.
> 
> According to the Video Image Processing Manual 1.4.1 [1], the GPU
> requires the following steps to power up:
> 
> 1) Enable the GPU clock gate.
> 2) After 32 core clock cycles, release the GPU soft reset
> 
> Since these steps are closely tied to power management, I implemented
> the reset functionality within the power-domain driver.
> 
> Because the GPU doesn't support the resets property, introducing a reset
> controller wouldn't align with the existing device tree well.

So add resets to GPU. You said here that VO has reset registers, so it
should be a reset controller.

> 
> [1] - https://openbeagle.org/beaglev-ahead/beaglev-ahead/-/blob/main/docs/TH1520%20Video%20Image%20Processing%20User%20Manual.pdf
>>
>>> +      these registers reside in the same address space, access to
>>> +      them is coordinated through a shared syscon regmap provided by
>>> +      the specified syscon node.
>>
>> Drop last sentence. syscon regmap is a Linux term, not hardware one.
>>
>> Anyway, this needs to be constrained per variant.
>>
>>> +
>>>    "#clock-cells":
>>>      const: 1
>>>      description:
>>> @@ -36,8 +51,6 @@ properties:
>>>  
>>>  required:
>>>    - compatible
>>> -  - reg
>>
>> No, that's a clear NAK. You claim you have no address space but in the
>> same time you have address space via regmap.
> 
> I see your concern. The VOSYS subsystem's address space includes
> registers for various components, such as clock gates and reset
> controls, which are scattered throughout the address space as specified
> in the manual 4.4.1 [2]. Initially, I attempted to use a shared syscon
> regmap for access, but I realize this might not be the best approach.

No, you miss the point of how device nodes are supposed to look like.
Don't bring your driver architecture here.

You cannot have regmap/syscon if you do not have reg. Your VOSYS is a
clock, reset and whatever-provider. Your power domain - if it does not
have reg - just does not exist. There is no such device and we do not
care if you have such device DRIVER.

> 
> To address this, I'll specify the 'reg' property in each node to define
> the address ranges explicitly fragmenting the address space for the VOSYS
> manually.
> 
> vosys_clk: clock-controller@ffef528050 {
> 	compatible = "thead,th1520-clk-vo";
> 	reg = <0xff 0xef528050 0x0 0x8>;
> 	#clock-cells = <1>;
> };
> 
> pd: power-domain@ffef528000 {
> 	compatible = "thead,th1520-pd";
> 	reg = <0xff 0xef528000 0x0 0x8>;
> 	#power-domain-cells = <1>;
> };

I don't think you really get the point here. Clock controllers and power
domains per one clock or domain are also a no-go.

Best regards,
Krzysztof

