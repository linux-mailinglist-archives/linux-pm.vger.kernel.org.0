Return-Path: <linux-pm+bounces-15462-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C3E998B90
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 17:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87773B359FC
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 14:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB501F470C;
	Thu, 10 Oct 2024 14:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="urJG02DX"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CFA1F1319;
	Thu, 10 Oct 2024 14:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728570609; cv=none; b=IABHbn+ydsABsePS9+RHaaAIQ9a60QiOM/CmHhx9i3YwOh34Ra5Ws365Eq9ufiJpR7wPZb8eiQI9402jLujrZ7y21iYMVuCZYR9BUPHbQmMci5BX4D9n5aw+z446zWbGj1bYGAlHy4oG0vlrfFlr1nLBnuRjOL8Cd0ebdpPjbkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728570609; c=relaxed/simple;
	bh=OXYTseSavrvP5Laj4WRn5qD6AAIg2e7hd5QYSkTyaJ4=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=LWLpIaRXW7yoRWIE3R1Nb9zOpif2XZA8AKRQY9BOEmS5hw+JHZeP49yoywDNm64DSAVRCSYPKmv8JYFuxRJeTFjZBVBkcIRBOD6FmwjsgtGCjJHr2r0BQlKX7m/7TW5ZPShgbPmLebFshPbcF1RMqid5NfQvZ/hKab6a+2t8G4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=urJG02DX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8317AC4CEC5;
	Thu, 10 Oct 2024 14:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728570609;
	bh=OXYTseSavrvP5Laj4WRn5qD6AAIg2e7hd5QYSkTyaJ4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=urJG02DXdX02b2LP/wiaLOZwLu16lu8GyI4Jk1sRkMWWOfKWKjVVQCUReypybEDy3
	 +cIQnCL3c6MUiKuSx5DkwuzFqMXyG0OPFRaWFLfk7pNEYEMBew3GfMj9Dd1qVxk50Y
	 E3JUtZ8LeQNZBj/PChmbTCTmGecLlwKFPR6v3hKE8sZ48ZECOi44eUhXgxRQFt1KU+
	 S9nKcEtAYMgTY5oV+MPlw0c47c/ycMLXj8IhZ0F6F36noUClXQNwB0z57pF0CYFC1C
	 jvtsZzMg5N7o58qFRe83ugeXZtUuLZYBS9KBA9OToliDfrxNxYvl3foIByt4aKoNEH
	 7pqBLnDZg3PGg==
Date: Thu, 10 Oct 2024 09:30:08 -0500
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
Cc: alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org, 
 claudiu.beznea@tuxon.dev, nicolas.ferre@microchip.com, krzk+dt@kernel.org, 
 sre@kernel.org, mihai.sain@microchip.com, devicetree@vger.kernel.org, 
 linux-pm@vger.kernel.org, conor+dt@kernel.org, p.zabel@pengutronix.de, 
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <20241010120142.92057-1-varshini.rajendran@microchip.com>
References: <20241010120142.92057-1-varshini.rajendran@microchip.com>
Message-Id: <172857036103.1533272.15935981992235971511.robh@kernel.org>
Subject: Re: [PATCH v8 0/9] Add support for sam9x7 SoC family


On Thu, 10 Oct 2024 17:31:42 +0530, Varshini Rajendran wrote:
> This patch series adds support for the new SoC family - sam9x7.
>  - The device tree, configs and drivers are added
>  - Clock driver for sam9x7 is added
>  - Support for basic peripherals is added
>  - Target board SAM9X75 Curiosity is added
> 
>  Changes in v8:
>  --------------
> 
>  - Dropped patches that are applied from the series
>  - Picked up Reviewed-by tags
>  - Changed the node name from leds to led-controller in the board dts
>    file.
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
> Varshini Rajendran (9):
>   dt-bindings: atmel-ssc: add microchip,sam9x7-ssc
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
>  .../devicetree/bindings/misc/atmel-ssc.txt    |    1 +
>  .../power/reset/atmel,sama5d2-shdwc.yaml      |    3 +
>  .../reset/atmel,at91sam9260-reset.yaml        |    4 +
>  arch/arm/boot/dts/microchip/Makefile          |    3 +
>  .../dts/microchip/at91-sam9x75_curiosity.dts  |  324 +++++
>  arch/arm/boot/dts/microchip/sam9x7.dtsi       | 1220 +++++++++++++++++
>  drivers/power/reset/Kconfig                   |    4 +-
>  drivers/power/reset/at91-sama5d2_shdwc.c      |    1 +
>  9 files changed, 1564 insertions(+), 2 deletions(-)
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


New warnings running 'make CHECK_DTBS=y microchip/at91-sam9x75_curiosity.dtb' for 20241010120142.92057-1-varshini.rajendran@microchip.com:

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






