Return-Path: <linux-pm+bounces-19738-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BF09FBEAB
	for <lists+linux-pm@lfdr.de>; Tue, 24 Dec 2024 14:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAD5C160880
	for <lists+linux-pm@lfdr.de>; Tue, 24 Dec 2024 13:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625DB1BDA8D;
	Tue, 24 Dec 2024 13:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTsz09Zk"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE378C1F;
	Tue, 24 Dec 2024 13:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735047154; cv=none; b=SEjr0CYjsR6+v8FA2ddwym5r/0qUheoe704+y/cmFbSvgsNQTi3cdHySWSdHurwTbUhTeA3M3aupaeRmo39zTj2MZ+qsIFSNDSJdqP52W6aQa7i5e67/9SrFPkxsHG+W5LF/4Kgv+0Rwf9u8+zhtxVkIhtAtRlTs1O7boB1oPFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735047154; c=relaxed/simple;
	bh=Wj6Ge9xRyhftxbU/Vrb5rWIH7VfNQJ8RdkY2OTPlFrU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qb56Buit89ufxMzF+ieq9g3wu6wf26BmJb82/xV9b3e3ylEMSor1iFU/vLBvpvoccCmGNaV4Zv3rgAbsWRCrRWsxQH+orNF/NFtq/NOSDpc4B+hLKUJb9QC9kd7FDubDqWnW2NxYw897LXJEI/VDvXpulTqcWHctJM5floveLJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NTsz09Zk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B21DEC4CED0;
	Tue, 24 Dec 2024 13:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735047153;
	bh=Wj6Ge9xRyhftxbU/Vrb5rWIH7VfNQJ8RdkY2OTPlFrU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NTsz09ZkW2Cc/WTqOYRhMlYKJuf7B2wxPAgv7aGnE4J2l4i63uuLG2STK7MbTXlXf
	 OWkHbbPyH1WaQ5qz+JVCM311vhtmrZzDsA1gjcOkK4ga6IZ1dXnrOMJdlcHKDqRkci
	 pAXKCxntbvGsxs+ixvhq3L/zP9C4wWInpj/R/2nN7kHpbMpX0qrwMZ8khTb1L4miw2
	 FLjk6MvTAvVAIIj0M0jq5DBdCXGJNxHhdAwGa7y6I1/MK5/OskheR412z2pin1aysE
	 07yZNbS+/jtndgG9u34ZPivcmkRGaUeHxddziKsV1l5O8Ci0QQf1pl/3xZizbd/z13
	 RT7y024iYdkRA==
Message-ID: <b6935ae6-5426-440f-9dbd-775002e110fc@kernel.org>
Date: Tue, 24 Dec 2024 14:32:24 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 03/19] dt-bindings: power: thead,th1520: Add
 support for power domains
To: Michal Wilczynski <m.wilczynski@samsung.com>, mturquette@baylibre.com,
 sboyd@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 drew@pdp7.com, guoren@kernel.org, wefu@redhat.com, jassisinghbrar@gmail.com,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 frank.binns@imgtec.com, matt.coster@imgtec.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, ulf.hansson@linaro.org,
 jszhang@kernel.org, p.zabel@pengutronix.de, m.szyprowski@samsung.com
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org
References: <20241223125553.3527812-1-m.wilczynski@samsung.com>
 <CGME20241223125604eucas1p26b870756eeaf2a5666b70de3f7554c13@eucas1p2.samsung.com>
 <20241223125553.3527812-4-m.wilczynski@samsung.com>
 <db2987c2-53fc-4d3a-b85c-f5683f74e7a0@kernel.org>
 <756031bf-4f81-424d-8cbc-db27ac27f6dd@samsung.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <756031bf-4f81-424d-8cbc-db27ac27f6dd@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/12/2024 10:31, Michal Wilczynski wrote:
> 
> 
> On 12/23/24 17:09, Krzysztof Kozlowski wrote:
>> On 23/12/2024 13:55, Michal Wilczynski wrote:
>>> +  compatible:
>>> +    const: thead,th1520-pd
>>> +
>>> +  "#power-domain-cells":
>>> +    const: 1
>>> +
>>> +additionalProperties: false
>>> +
>>> +required:
>>> +  - compatible
>>> +  - "#power-domain-cells"
>>> +
>>> +examples:
>>> +  - |
>>> +    firmware {
>>
>> Drop
>>
>>> +        aon: aon {
>>> +            compatible = "thead,th1520-aon";
>>> +            mboxes = <&mbox_910t 1>;
>>> +            mbox-names = "aon";
>>
>> Drop aon node... but the main problem is you do not have any resources
>> in your power-domain device node, assuming your binding is complete.
>> This suggests that this is part of aon, not separate device. Fold the
>> device node into its parent (so everything goes to AON).
> 
> Merging everything to AON node would definitely work. I was looking at
> the other implementations of firmware protocols for example, and that's
> how I figured the current implementation:
> 
> arch/arm/boot/dts/broadcom/bcm2835-rpi.dtsi
> soc {
> 	firmware: firmware {
> 		compatible = "raspberrypi,bcm2835-firmware", "simple-mfd";
> 		mboxes = <&mailbox>;

That's a 10 year old binding. Not even reviewed initially by DT maintainers.

> 
> 		firmware_clocks: clocks {
> 			compatible = "raspberrypi,firmware-clocks";
> 			#clock-cells = <1>;
> 		};
> 	};
> 
> 	power: power {
> 		compatible = "raspberrypi,bcm2835-power";
> 		firmware = <&firmware>;
> 		#power-domain-cells = <1>;
> 	};
> };
> 
> This is fairly similar, as the firmware is passed as property, instead
> as in a parent-child relationship. Would you consider it more canonical
> ?

I consider early Raspberry bindings as antipattern. Same as many other
early approaches and that's not an accusation to their authors. Just
rules changed and capacity of DT maintainers increased.

> 
> I would be happy to merge everything to AON node, and merge the
> power-domain driver and AON driver together, but it seemed to me like
> those could use some separation, and since power-domain and the AON
> represent actual HW it's fine to represent them in the device tree.
> 

I said nothing about drivers and I did not suggest merging drivers.
Device nodes should not be split because they have different functions.
This is one single device with multiple functions. Just like hundreds of
others, e.g. clock, power domain and reset controller - all in one. Lack
of separate address space is the main aspect here indicating this is not
a separate device.

So merge the device nodes.



Best regards,
Krzysztof

