Return-Path: <linux-pm+bounces-13431-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 428C696A07A
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 16:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6FD81F27158
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 14:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D0B16C6A7;
	Tue,  3 Sep 2024 14:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MHLi79f5"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3614156F34;
	Tue,  3 Sep 2024 14:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725373605; cv=none; b=odMlU4jMvdktbF2+JOA68BiuCfg3JY+wGqTXZuBubscyUhIIiyYvcRYcqzKmoduEB19M0vRafumkwFaMGDt4xTj2LFJIJCGZWPSE+obySI+8snTYgHcgATzu9BilRbhsQrFITUbKFE5Zjj61CXoiaDFJ+i5lN5kQ2yo/qd/5Lzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725373605; c=relaxed/simple;
	bh=yEnhxpK2qUIZRhx8Zu3VqARXJsBeqeIDb4k6g1k29w8=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=egpor79GeHMTp0CI6VXv09UH/DESb8obVI8pY6tM0OBfG0MmX33FRfTH2LK1NEzBqNsItMU+Mbfbi2Z/Stew0TyWkAGckuEjSkwaoSj2MWvNWPNPvs1EvpKgzpEctOQH/2h9u6PKpwUfCtTdDclxr9tjmmZqgKms32C/EFIQwvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MHLi79f5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE97C4CECB;
	Tue,  3 Sep 2024 14:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725373604;
	bh=yEnhxpK2qUIZRhx8Zu3VqARXJsBeqeIDb4k6g1k29w8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=MHLi79f5BQT7Z5L8G5zMvHKmHRo5E63aloovaXYGlcJiEi7oDXMeFQfHhrc1oEmTG
	 nXiwyn3akxdqox4ln01UoV08dGHWr5/A+7PEyr2MRCUWDzV3LRL8Oi14WZ7jqFo/PJ
	 48WWS2Q/twt4cJMvsLiNOT6y+4T5KTGlyu+hpxdC0FhkNG+/I3JVPM6l68Ho1ytnLU
	 fqTvUaocBHeKF6UrS0N9CuoqH2JSFUPPu9ulw2/U5XT6bq3G+JR5xl9l1XME39T5D1
	 C5At1NA4HFApB1yXf2k6DBdORRgLBC2dIh66cV68RrBZ34jmpI8btjqArcRO5UOlYH
	 5RCMV0YrA+z9Q==
Date: Tue, 03 Sep 2024 09:26:43 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Varshini Rajendran <varshini.rajendran@microchip.com>
Cc: mihai.sain@microchip.com, krzk+dt@kernel.org, dharma.b@microchip.com, 
 alexandre.belloni@bootlin.com, andrei.simion@microchip.com, 
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 tglx@linutronix.de, conor+dt@kernel.org, sre@kernel.org, 
 claudiu.beznea@tuxon.dev, devicetree@vger.kernel.org, 
 p.zabel@pengutronix.de, nicolas.ferre@microchip.com, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240903063913.48307-1-varshini.rajendran@microchip.com>
References: <20240903063913.48307-1-varshini.rajendran@microchip.com>
Message-Id: <172537334915.874870.10281133063167664702.robh@kernel.org>
Subject: Re: [PATCH v7 00/12] Add support for sam9x7 SoC family


On Tue, 03 Sep 2024 12:09:13 +0530, Varshini Rajendran wrote:
> This patch series adds support for the new SoC family - sam9x7.
>  - The device tree, configs and drivers are added
>  - Clock driver for sam9x7 is added
>  - Support for basic peripherals is added
>  - Target board SAM9X75 Curiosity is added
> 
>  Changes in v7:
>  --------------
> 
>  - Addressed all the review comments in the patches
>  - Dropped patches that are applied from the series
>  - Removed sfr node from the DT to add it later after creating the right
>    DT documentation for microchip sfr IPs.
>  - All the specific changes are captured in the corresponding patches
> 
>  Changes in v6:
>  --------------
> 
>  - Addressed all the review comments in the patches
>  - Picked up all Acked-by and Reviewed-by tags
>  - Reverted the IRQ patch to that of version 3 of the same series
>  - All the specific changes are captured in the corresponding patches
> 
>  Changes in v5:
>  --------------
> 
>  - Addressed all the review comments in the patches
>  - Picked up all Acked-by and Reviewed-by tags
>  - Dropped applied patches from the series
>  - Addressed the ABI breakage reported in the IRQ patch
>  - All the specific changes are captured in the corresponding patches
> 
>  Changes in v4:
>  --------------
> 
>  - Addressed all the review comments in the patches
>  - Picked up all Acked-by and Reviewed-by tags
>  - Dropped applied patches from the series
>  - Added pwm node and related dt binding documentation
>  - Added support for exporting some clocks to DT
>  - Dropped USB related patches and changes. See NOTE.
>  - All the specific changes are captured in the corresponding patches
> 
>  NOTE: Owing to the discussion here
>  https://lore.kernel.org/linux-devicetree/CAL_JsqJ9PrX6fj-EbffeJce09MXs=B7t+KS_kOinxaRx38=WxA@mail.gmail.com/
>  the USB related changes are dropped from this series in order to enable
>  us to work on the mentioned issues before adding new compatibles as
>  said. The issues/warnings will be addressed in subsequent patches.
>  After which the USB related support for sam9x7 SoCs will be added. Hope
>  this works out fine.
> 
>  Changes in v3:
>  --------------
> 
>  - Fixed the DT documentation errors pointed out in v2.
>  - Dropped Acked-by tag in tcb DT doc patch as it had to be adapted
>    according to sam9x7 correctly.
>  - Picked by the previously missed tags.
>  - Dropped this patch "dt-bindings: usb: generic-ehci: Document clock-names
>    property" as the warning was not found while validating DT-schema for
>    at91-sam9x75_curiosity.dtb.
>  - Dropped redundant words in the commit message.
>  - Fixed the CHECK_DTBS warnings validated against
>    at91-sam9x75_curiosity.dtb.
>  - Renamed dt nodes according to naming convention.
>  - Dropped unwanted status property in dts.
>  - Removed nodes that are not in use from the board dts.
>  - Removed spi DT doc patch from the series as it was already applied
>    and a fix patch was applied subsequently. Added a patch to remove the
>    compatible to adapt sam9x7.
>  - Added sam9x7 compatibles in usb dt documentation.
> 
> 
>  Changes in v2:
>  --------------
> 
>  - Added sam9x7 specific compatibles in DT with fallbacks
>  - Documented all the newly added DT compatible strings
>  - Added device tree for the target board sam9x75 curiosity and
>    documented the same in the DT bindings documentation
>  - Removed the dt nodes that are not supported at the moment
>  - Removed the configs added by previous version that are not supported
>    at the moment
>  - Fixed all the corrections in the commit message
>  - Changed all the instances of copyright year to 2023
>  - Added sam9x7 flag in PIT64B configuration
>  - Moved macro definitions to header file
>  - Added another divider in mck characteristics in the pmc driver
>  - Fixed the memory leak in the pmc driver
>  - Dropped patches that are no longer needed
>  - Picked up Acked-by and Reviewed-by tags
> 
> Hari Prasath (1):
>   irqchip/atmel-aic5: Add support for sam9x7 aic
> 
> Varshini Rajendran (11):
>   dt-bindings: atmel-ssc: add microchip,sam9x7-ssc
>   dt-bindings: microchip: atmel,at91rm9200-tcb: add sam9x7 compatible
>   dt-bindings: interrupt-controller: Add support for sam9x7 aic
>   power: reset: at91-poweroff: lookup for proper pmc dt node for sam9x7
>   power: reset: at91-reset: add reset support for sam9x7 SoC
>   power: reset: at91-reset: add sdhwc support for sam9x7 SoC
>   dt-bindings: reset: atmel,at91sam9260-reset: add sam9x7
>   dt-bindings: power: reset: atmel,sama5d2-shdwc: add sam9x7
>   ARM: dts: at91: sam9x7: add device tree for SoC
>   dt-bindings: arm: add sam9x75 curiosity board
>   ARM: dts: microchip: sam9x75_curiosity: add sam9x75 curiosity board
> 
>  .../devicetree/bindings/arm/atmel-at91.yaml   |    6 +
>  .../interrupt-controller/atmel,aic.yaml       |    1 +
>  .../devicetree/bindings/misc/atmel-ssc.txt    |    1 +
>  .../power/reset/atmel,sama5d2-shdwc.yaml      |    3 +
>  .../reset/atmel,at91sam9260-reset.yaml        |    4 +
>  .../soc/microchip/atmel,at91rm9200-tcb.yaml   |   20 +-
>  arch/arm/boot/dts/microchip/Makefile          |    3 +
>  .../dts/microchip/at91-sam9x75_curiosity.dts  |  324 +++++
>  arch/arm/boot/dts/microchip/sam9x7.dtsi       | 1220 +++++++++++++++++
>  drivers/irqchip/irq-atmel-aic5.c              |    9 +
>  drivers/power/reset/Kconfig                   |    4 +-
>  drivers/power/reset/at91-sama5d2_shdwc.c      |    1 +
>  12 files changed, 1587 insertions(+), 9 deletions(-)
>  create mode 100644 arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dts
>  create mode 100644 arch/arm/boot/dts/microchip/sam9x7.dtsi
> 
> --
> 2.25.1
> 
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y microchip/at91-sam9x75_curiosity.dtb' for 20240903063913.48307-1-varshini.rajendran@microchip.com:

arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dtb: /ahb/mmc@80000000: failed to match any schema with compatible: ['microchip,sam9x7-sdhci', 'microchip,sam9x60-sdhci']
arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dtb: /ahb/mmc@80000000: failed to match any schema with compatible: ['microchip,sam9x7-sdhci', 'microchip,sam9x60-sdhci']
arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dtb: /ahb/mmc@90000000: failed to match any schema with compatible: ['microchip,sam9x7-sdhci', 'microchip,sam9x60-sdhci']
arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dtb: /ahb/mmc@90000000: failed to match any schema with compatible: ['microchip,sam9x7-sdhci', 'microchip,sam9x60-sdhci']
arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dtb: /apb/dma-controller@f0008000: failed to match any schema with compatible: ['microchip,sam9x7-dma', 'atmel,sama5d4-dma']
arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dtb: /apb/dma-controller@f0008000: failed to match any schema with compatible: ['microchip,sam9x7-dma', 'atmel,sama5d4-dma']
arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dtb: /apb/ssc@f0010000: failed to match any schema with compatible: ['microchip,sam9x7-ssc', 'atmel,at91sam9g45-ssc']
arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dtb: /apb/ssc@f0010000: failed to match any schema with compatible: ['microchip,sam9x7-ssc', 'atmel,at91sam9g45-ssc']
arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dtb: /apb/timer@f0028000: failed to match any schema with compatible: ['microchip,sam9x7-pit64b', 'microchip,sam9x60-pit64b']
arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dtb: /apb/timer@f0028000: failed to match any schema with compatible: ['microchip,sam9x7-pit64b', 'microchip,sam9x60-pit64b']
arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dtb: /apb/timer@f0040000: failed to match any schema with compatible: ['microchip,sam9x7-pit64b', 'microchip,sam9x60-pit64b']
arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dtb: /apb/timer@f0040000: failed to match any schema with compatible: ['microchip,sam9x7-pit64b', 'microchip,sam9x60-pit64b']
arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dtb: /apb/matrix@ffffde00: failed to match any schema with compatible: ['microchip,sam9x7-matrix', 'atmel,at91sam9x5-matrix', 'syscon']
arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dtb: /apb/matrix@ffffde00: failed to match any schema with compatible: ['microchip,sam9x7-matrix', 'atmel,at91sam9x5-matrix', 'syscon']
arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dtb: /apb/ecc-engine@ffffe000: failed to match any schema with compatible: ['microchip,sam9x7-pmecc', 'atmel,at91sam9g45-pmecc']
arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dtb: /apb/ecc-engine@ffffe000: failed to match any schema with compatible: ['microchip,sam9x7-pmecc', 'atmel,at91sam9g45-pmecc']
arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dtb: /apb/mpddrc@ffffe800: failed to match any schema with compatible: ['microchip,sam9x7-ddramc', 'atmel,sama5d3-ddramc']
arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dtb: /apb/mpddrc@ffffe800: failed to match any schema with compatible: ['microchip,sam9x7-ddramc', 'atmel,sama5d3-ddramc']
arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dtb: /apb/smc@ffffea00: failed to match any schema with compatible: ['microchip,sam9x7-smc', 'atmel,at91sam9260-smc', 'syscon']
arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dtb: /apb/smc@ffffea00: failed to match any schema with compatible: ['microchip,sam9x7-smc', 'atmel,at91sam9260-smc', 'syscon']
arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dtb: /apb/syscon@fffffe60: failed to match any schema with compatible: ['microchip,sam9x7-gpbr', 'atmel,at91sam9260-gpbr', 'syscon']
arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dtb: /apb/syscon@fffffe60: failed to match any schema with compatible: ['microchip,sam9x7-gpbr', 'atmel,at91sam9260-gpbr', 'syscon']






