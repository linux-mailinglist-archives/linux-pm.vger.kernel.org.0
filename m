Return-Path: <linux-pm+bounces-16598-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A619B3681
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 17:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D1B41C21D0E
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 16:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7681DED6C;
	Mon, 28 Oct 2024 16:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=epochal.quest header.i=@epochal.quest header.b="W5Ki2/YM"
X-Original-To: linux-pm@vger.kernel.org
Received: from thales.epochal.quest (thales.epochal.quest [51.222.15.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41B5186616;
	Mon, 28 Oct 2024 16:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.222.15.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730133122; cv=none; b=AC0MiQOPoOedXwb/pZv3yaNxrKGP5i0XRDVudTePj6bZxi1aRbOdqFvor71TcibvT0M0jbUOhUC9QRnIFCJ0dmef+WTSgfz+CcZlwhuPX2pWdJ7SAHNMpApqX3uATq9lqUa/xznbYKq4vJkQwYP7XjPyNXZERzCHmiv2YICMDxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730133122; c=relaxed/simple;
	bh=jbAf3Qjeh2+VzNtT5cDxQjaaHvxoKBVQwoZg6Fi/2qk=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=SLd0/C/lJN+5lsoCsvyKqCUNHArqAUGJ1gAorxCG4UNW3TKftJJnmns/uN/HKYT5/Y1dd0+czHPjkHT//8rBnX2v8DqDmCCswv9+VUboyLA2enqEm0E9VjNKZwa6aGgJez6OhG6U0uwRlvcfVwhrUKbrBIbttI4ZOqZl4ys5W4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=epochal.quest; spf=pass smtp.mailfrom=epochal.quest; dkim=pass (2048-bit key) header.d=epochal.quest header.i=@epochal.quest header.b=W5Ki2/YM; arc=none smtp.client-ip=51.222.15.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=epochal.quest
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=epochal.quest
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=epochal.quest;
	s=default; t=1730133119;
	bh=jbAf3Qjeh2+VzNtT5cDxQjaaHvxoKBVQwoZg6Fi/2qk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W5Ki2/YM/RJaBXLb0WwetrVYx8TZ94J/cCHj8BbY3l71bj2hxrEWdrfjDJd9qOV62
	 DanrZm8ltb+h9YxswXmDiUNXrCPfOP6+rcdi4/i/J1UjqGbaHLgbVbKwgB3jcHbWtC
	 CzIRjDLQ0xw9MpyBCLL1R2jldjpXZ0Po3Xnp5lMKrowVR9CU/run6txkPGCrJMnJ1t
	 o6+pKf3EMhT/dTUsMatNhncGK13OpC0JoEIhV00vStt02VPabfY2MpGJ5U9dj/MP2L
	 4SMAHDcko2GVG2kU5G0PL6ZY/Wnmixx4ugmRkPho+Y0+3SlCo5HOgnV6yKeOtlIICO
	 WNIrjUtZe+zeA==
X-Virus-Scanned: by epochal.quest
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 28 Oct 2024 13:31:58 -0300
From: Cody Eksal <masterr3c0rd@epochal.quest>
To: Andre Przywara <andre.przywara@arm.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-usb@vger.kernel.org, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu
 Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel
 Holland <samuel@sholland.org>, Parthiban <parthiban@linumiz.com>, Florian
 Fainelli <florian.fainelli@broadcom.com>, Vinod Koul <vkoul@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Thierry Reding
 <treding@nvidia.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Maxime Ripard <mripard@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Yangtao Li <tiny.windzz@gmail.com>, Viresh
 Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd
 <sboyd@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 07/13] arm64: dts: allwinner: a100: add usb related nodes
In-Reply-To: <20241026014444.12c8c99b@minigeek.lan>
References: <20241024170540.2721307-1-masterr3c0rd@epochal.quest>
 <20241024170540.2721307-8-masterr3c0rd@epochal.quest>
 <20241026014444.12c8c99b@minigeek.lan>
Message-ID: <09bc7b6ac779caf7a5e5ebbd7243b165@epochal.quest>
X-Sender: masterr3c0rd@epochal.quest
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/25 9:44 pm, Andre Przywara wrote:
> On Thu, 24 Oct 2024 14:05:25 -0300
> Cody Eksal <masterr3c0rd@epochal.quest> wrote:
> 
> Hi,
> 
>> From: Yangtao Li <frank@allwinnertech.com>
>> 
>> Allwinner A64 have two HCI USB controllers, a OTG controller and a USB
>> PHY device, let's add nodes on dts.
>> 
>> Signed-off-by: Yangtao Li <frank@allwinnertech.com>
>> [masterr3c0rd@epochal.quest: fallback to a33-musb instead of h3-musb]
>> Signed-off-by: Cody Eksal <masterr3c0rd@epochal.quest>
>> ---
>>  .../arm64/boot/dts/allwinner/sun50i-a100.dtsi | 91 
>> +++++++++++++++++++
>>  1 file changed, 91 insertions(+)
>> 
>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi 
>> b/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
>> index adb11b26045f..0aee1b578661 100644
>> --- a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
>> @@ -302,6 +302,97 @@ ths: thermal-sensor@5070400 {
>>  			#thermal-sensor-cells = <1>;
>>  		};
>> 
>> +		usbphy: phy@5100400 {
>> +			#phy-cells = <1>;
> 
> Please keep the compatible string first, and move #phy-cells to the 
> end.
Will be done in V2
>> +			compatible = "allwinner,sun50i-a100-usb-phy";
>> +			reg = <0x05100400 0x14>,
>> +			      <0x05101800 0x4>,
>> +			      <0x05200800 0x4>;
> 
> We need at least 0x24 for the phy_ctrl and 0x14 for the PMUs. But I
> wonder if we should use 0x100 for all of them, like for the D1, as 
> there
> are more registers. The fact that the Linux driver doesn't use more
> shouldn't prevent the DT from describing them.
This as well.
>> +			reg-names = "phy_ctrl",
>> +				    "pmu0",
>> +				    "pmu1";
>> +			clocks = <&ccu CLK_USB_PHY0>,
>> +				 <&ccu CLK_USB_PHY1>;
>> +			clock-names = "usb0_phy",
>> +				      "usb1_phy";
>> +			resets = <&ccu RST_USB_PHY0>,
>> +				 <&ccu RST_USB_PHY1>;
>> +			reset-names = "usb0_reset",
>> +				      "usb1_reset";
>> +			status = "disabled";
>> +		};
>> +
>> +		ehci0: usb@5101000 {
> 
> The nodes are ordered by their MMIO base address, so please move them
> around accordingly.
I double checked; the only note that wasn't in order was MUSB, which 
fits above the USB PHY in the memory map. I've moved those up.
>> +			compatible = "allwinner,sun50i-a100-ehci",
>> +				     "generic-ehci";
>> +			reg = <0x05101000 0x100>;
>> +			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&ccu CLK_BUS_OHCI0>,
>> +				 <&ccu CLK_BUS_EHCI0>,
>> +				 <&ccu CLK_USB_OHCI0>;
>> +			resets = <&ccu RST_BUS_OHCI0>,
>> +				 <&ccu RST_BUS_EHCI0>;
>> +			phys = <&usbphy 0>;
>> +			phy-names = "usb";
>> +			status = "disabled";
>> +		};
>> +
>> +		ohci0: usb@5101400 {
>> +			compatible = "allwinner,sun50i-a100-ohci",
>> +				     "generic-ohci";
>> +			reg = <0x05101400 0x100>;
>> +			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&ccu CLK_BUS_OHCI0>,
>> +				 <&ccu CLK_USB_OHCI0>;
>> +			resets = <&ccu RST_BUS_OHCI0>;
>> +			phys = <&usbphy 0>;
>> +			phy-names = "usb";
>> +			status = "disabled";
>> +		};
>> +
>> +		usb_otg: usb@5100000 {
>> +			compatible = "allwinner,sun50i-a100-musb",
>> +				     "allwinner,sun8i-a33-musb";
>> +			reg = <0x05100000 0x0400>;
>> +			clocks = <&ccu CLK_BUS_OTG>;
>> +			resets = <&ccu RST_BUS_OTG>;
>> +			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
>> +			interrupt-names = "mc";
>> +			phys = <&usbphy 0>;
>> +			phy-names = "usb";
>> +			extcon = <&usbphy 0>;
>> +			dr_mode = "otg";
> 
> dr_mode should be set in the board .dts, so please remove that line
> from here.
Done, and updated the Perf1 DTS to reflect this
> For the records: I checked the MMIO base addresses, clock and reset
> names and the IRQs against the manual: they all match.
Thanks again!
- Cody
> Cheers,
> Andre
> 
>> +			status = "disabled";
>> +		};
>> +

