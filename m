Return-Path: <linux-pm+bounces-23178-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6C7A49BDF
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 15:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2963A18956FF
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 14:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7A927002E;
	Fri, 28 Feb 2025 14:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OMQZTc/6"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF0226FDBE;
	Fri, 28 Feb 2025 14:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740752641; cv=none; b=XuFxgTyNAapZM5BrBF5tjJ0ftwy1UMLoEIEbCdQSAcrigl8VmY8TTqkTYTBNhm/OTW4nlyaZ0Oo89cJOXYeKySwYUWgljossURMvv2rtPuJnUngS6j7iv3zq/YR3NAzi9naT1G8W+cdvDinVk0aBRmlGJZqqN4HjTXObcyMMR9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740752641; c=relaxed/simple;
	bh=khKfY/IBW02PeE8kauJY4wJKQ61VMPyzLS8E+LWvU3I=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=AH6nCoVvp3BLj45XX3S1mm84oWORK+ttIWxqX2agsS7uoyUfBFNX6mqs/+rC0cw9uzPIaS5Lm7Vu5hzWlzn+MqBmodTH9ILYxYMD6O6j+6VRzlXW1RO5P3UxlOFnMc7YXBNXzYNfWt+F3sZw3wk268hvR5v9SiDG1uwV+Gw2DiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OMQZTc/6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38227C4CEE5;
	Fri, 28 Feb 2025 14:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740752641;
	bh=khKfY/IBW02PeE8kauJY4wJKQ61VMPyzLS8E+LWvU3I=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=OMQZTc/6QWL4nNe8A8lPHGEuMcdgvvD6ahM/H+K3Jx8mwJ3Co9yx0+M63FUzBELB4
	 BfA1+x24nR8uUyGJUFv6+JYbYpGfkXTLDMw9H01vV7DWmSVIsUj0dqXLFDpmHqlXtp
	 FUv6uaVWiDm2fJlYnigkZ2dmeCwlAPtQSg08Pf+NWiRcT3ahg9UvDgMRXpc+AxSbrv
	 4BEqGWi993HEl9c0D5TarEDv77Cc2haiN+lsJ18TXC7TrQQs5AC4DF9fyGAza5A6+t
	 LEd3KjIfUMv9KGLOL+a09YfsETfSZkbFT0Q5NMUa0yiUVb0MK0S+j8IP0WO6YnHT1f
	 o1WGLenDfacBQ==
Date: Fri, 28 Feb 2025 08:23:59 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org, 
 conor+dt@kernel.org, krzk+dt@kernel.org, devicetree@vger.kernel.org, 
 p.zabel@pengutronix.de, alexandre.belloni@bootlin.com, lee@kernel.org, 
 linux-rtc@vger.kernel.org, nicolas.ferre@microchip.com, 
 claudiu.beznea@tuxon.dev, sre@kernel.org
To: Ryan.Wanner@microchip.com
In-Reply-To: <cover.1740671156.git.Ryan.Wanner@microchip.com>
References: <cover.1740671156.git.Ryan.Wanner@microchip.com>
Message-Id: <174075232975.2756279.6056576336708729694.robh@kernel.org>
Subject: Re: [PATCH v3 00/21] Enable Power Modes Support for SAMA7D65 SoC


On Thu, 27 Feb 2025 08:51:47 -0700, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> This patch set adds support for low power modes for the SAMA7D65 SoC and
> the required components and changes for low power modes.
> 
> The series includes changes in the asm code to account for the addtional
> clocks that are in this SoC.
> 
> The Device tree additions are to enable all the components needed to
> keep the SoC in low power mode.
> 
> There are some DTB check warnings but that is due to the dt-binding not
> in the correct .yaml file format.
> 
> Changes v1 -> v2:
> - Add missing compatible for ddr3phy, it is now in both syscon sets.
> - Fix alphabetical ordering for sama7d65.
> - Remove the incorrect reorganizing patch.
> - Remove sama7g5-rtt as a compatible for sama7d65-rtt and add
>   sama7d65-rtt as a compatible wake up source in the pm driver.
> 
> Changes from v2 -> v3:
> - Correct mistake in v2 sfrbu dt-binding patch.
> - Correct incorrect dt-binding addition and formatting for rtc and rtt bindings.
> - Add missing SoB tag.
> - Cleaned up commit message for Backup mode to describe SHDWC is status
>   register is cleared for this SoC.
> - Cleaned up variable naming and usage for mcks. Changed the mcks number
>   to the correct number of clocks needed to be saved and corrected the
>   ASM code accordingly.
> - Removed the SHDWC from ULP0 wake-up source as it is not configured as
>   a valid wake-up source for ULP0.
> - Separated all the DTSI and DTS changes into individual patches.
> 
> 
> Li Bin (1):
>   ARM: at91: pm: fix at91_suspend_finish for ZQ calibration
> 
> Ryan Wanner (20):
>   dt-bindings: mfd: syscon: add microchip,sama7d65-ddr3phy
>   dt-bindings: mfd: syscon: add microchip,sama7d65-sfrbu
>   dt-bindings: sram: Add microchip,sama7d65-sram
>   dt-bindings: power: reset: atmel,sama5d2-shdwc: Add
>     microchip,sama7d65-shdwc
>   dt-bindings: reset: atmel,at91sam9260-reset: add
>     microchip,sama7d65-rstc
>   dt-bindings: rtc: at91rm9200: add microchip,sama7d65-rtc
>   dt-bindings: at91rm9260-rtt: add microchip,sama7d65-rtt
>   ARM: at91: Add PM support to sama7d65
>   ARM: at91: pm: add DT compatible support for sama7d65
>   ARM: at91: PM: Add Backup mode for SAMA7D65
>   ARM: at91: pm: Enable ULP0/ULP1 for SAMA7D65
>   power: reset: at91-sama5d2_shdwc: Add sama7d65 PMC
>   ARM: dts: microchip: sama7d65: Add SRAM and DRAM components support
>   ARM: dts: microchip: sama7d65: Add Reset Controller to sama7d65 SoC
>   ARM: dts: microchip: sama7d65: Add Shutdown controller support
>   ARM: dts: microchip: sama7d65: Add RTT and GPBR Support for sama7d65
>     SoC
>   ARM: dts: microchip: sama7d65: Add RTC support for sama7d65
>   ARM: dts: microchip: sama7d65: Add SFRBU support to sama7d65
>   ARM: dts: microchip: sama7d65: Enable shutdown controller
>   ARM: dts: microchip: sama7d65: Add RTT timer to curiosity board
> 
>  .../devicetree/bindings/mfd/syscon.yaml       |   4 +
>  .../power/reset/atmel,sama5d2-shdwc.yaml      |   5 +
>  .../reset/atmel,at91sam9260-reset.yaml        |   3 +
>  .../bindings/rtc/atmel,at91rm9200-rtc.yaml    |   4 +-
>  .../bindings/rtc/atmel,at91sam9260-rtt.yaml   |   1 +
>  .../devicetree/bindings/sram/sram.yaml        |   1 +
>  .../dts/microchip/at91-sama7d65_curiosity.dts |  13 +++
>  arch/arm/boot/dts/microchip/sama7d65.dtsi     |  77 +++++++++++++
>  arch/arm/mach-at91/Kconfig                    |   1 +
>  arch/arm/mach-at91/pm.c                       |  47 +++++---
>  arch/arm/mach-at91/pm.h                       |   1 +
>  arch/arm/mach-at91/pm_data-offsets.c          |   2 +
>  arch/arm/mach-at91/pm_suspend.S               | 101 ++++++++++++++++--
>  drivers/power/reset/at91-sama5d2_shdwc.c      |   1 +
>  14 files changed, 238 insertions(+), 23 deletions(-)
> 
> --
> 2.43.0
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


New warnings running 'make CHECK_DTBS=y for arch/arm/boot/dts/microchip/' for cover.1740671156.git.Ryan.Wanner@microchip.com:

arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dtb: /soc/secumod@e0004000: failed to match any schema with compatible: ['microchip,sama7d65-secumod', 'atmel,sama5d2-secumod', 'syscon']
arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dtb: /soc/secumod@e0004000: failed to match any schema with compatible: ['microchip,sama7d65-secumod', 'atmel,sama5d2-secumod', 'syscon']
arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dtb: sfr@e0008000: compatible:1: 'syscon' was expected
	from schema $id: http://devicetree.org/schemas/mfd/syscon.yaml#
arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dtb: sfr@e0008000: compatible: ['microchip,sama7d65-sfrbu', 'atmel,sama5d2-sfrbu', 'syscon'] is too long
	from schema $id: http://devicetree.org/schemas/mfd/syscon.yaml#
arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dtb: /soc/gpbr@e001d700: failed to match any schema with compatible: ['microchip,sama7d65-gpbr', 'syscon']
arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dtb: /soc/uddrc@e3800000: failed to match any schema with compatible: ['microchip,sama7d65-uddrc', 'microchip,sama7g5-uddrc']
arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dtb: /soc/uddrc@e3800000: failed to match any schema with compatible: ['microchip,sama7d65-uddrc', 'microchip,sama7g5-uddrc']
arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dtb: ddr3phy@e3804000: compatible:1: 'syscon' was expected
	from schema $id: http://devicetree.org/schemas/mfd/syscon.yaml#
arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dtb: ddr3phy@e3804000: compatible: ['microchip,sama7d65-ddr3phy', 'microchip,sama7g5-ddr3phy'] does not contain items matching the given schema
	from schema $id: http://devicetree.org/schemas/mfd/syscon.yaml#
arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dtb: ddr3phy@e3804000: Unevaluated properties are not allowed ('compatible' was unexpected)
	from schema $id: http://devicetree.org/schemas/mfd/syscon.yaml#
arch/arm/boot/dts/microchip/at91-sama7g5ek.dtb: sfr@e0008000: compatible:0: 'microchip,sama7g5-sfrbu' is not one of ['al,alpine-sysfabric-service', 'allwinner,sun8i-a83t-system-controller', 'allwinner,sun8i-h3-system-controller', 'allwinner,sun8i-v3s-system-controller', 'allwinner,sun50i-a64-system-controller', 'altr,l3regs', 'altr,sdr-ctl', 'amd,pensando-elba-syscon', 'amlogic,meson-mx-assist', 'amlogic,meson-mx-bootrom', 'amlogic,meson8-analog-top', 'amlogic,meson8b-analog-top', 'amlogic,meson8-pmu', 'amlogic,meson8b-pmu', 'apm,merlin-poweroff-mailbox', 'apm,mustang-poweroff-mailbox', 'apm,xgene-csw', 'apm,xgene-efuse', 'apm,xgene-mcb', 'apm,xgene-rb', 'apm,xgene-scu', 'atmel,sama5d2-sfrbu', 'atmel,sama5d3-nfc-io', 'atmel,sama5d3-sfrbu', 'atmel,sama5d4-sfrbu', 'axis,artpec6-syscon', 'brcm,cru-clkset', 'brcm,sr-cdru', 'brcm,sr-mhb', 'cirrus,ep7209-syscon1', 'cirrus,ep7209-syscon2', 'cirrus,ep7209-syscon3', 'cnxt,cx92755-uc', 'freecom,fsg-cs2-system-controller', 'fsl,imx93-aonmix-ns-
 syscfg', 'fsl,imx93-wakeupmix-syscfg', 'fsl,ls1088a-reset', 'fsl,vf610-anatop', 'fsl,vf610-mscm-cpucfg', 'hisilicon,dsa-subctrl', 'hisilicon,hi6220-sramctrl', 'hisilicon,hip04-ppe', 'hisilicon,pcie-sas-subctrl', 'hisilicon,peri-subctrl', 'hpe,gxp-sysreg', 'loongson,ls1b-syscon', 'loongson,ls1c-syscon', 'lsi,axxia-syscon', 'marvell,armada-3700-cpu-misc', 'marvell,armada-3700-nb-pm', 'marvell,armada-3700-avs', 'marvell,armada-3700-usb2-host-misc', 'marvell,dove-global-config', 'mediatek,mt2701-pctl-a-syscfg', 'mediatek,mt2712-pctl-a-syscfg', 'mediatek,mt6397-pctl-pmic-syscfg', 'mediatek,mt8135-pctl-a-syscfg', 'mediatek,mt8135-pctl-b-syscfg', 'mediatek,mt8173-pctl-a-syscfg', 'mediatek,mt8365-syscfg', 'microchip,lan966x-cpu-syscon', 'microchip,mpfs-sysreg-scb', 'microchip,sam9x60-sfr', 'microchip,sama7d65-ddr3phy', 'microchip,sama7d65-sfrbu', 'microchip,sama7g5-ddr3phy', 'mscc,ocelot-cpu-syscon', 'mstar,msc313-pmsleep', 'nuvoton,ma35d1-sys', 'nuvoton,wpcm450-shm', 'rockchip,px30-qos', '
 rockchip,rk3036-qos', 'rockchip,rk3066-qos', 'rockchip,rk3128-qos', 'rockchip,rk3228-qos', 'rockchip,rk3288-qos', 'rockchip,rk3368-qos', 'rockchip,rk3399-qos', 'rockchip,rk3562-qos', 'rockchip,rk3568-qos', 'rockchip,rk3576-qos', 'rockchip,rk3588-qos', 'rockchip,rv1126-qos', 'st,spear1340-misc', 'stericsson,nomadik-pmu', 'starfive,jh7100-sysmain', 'ti,am62-opp-efuse-table', 'ti,am62-usb-phy-ctrl', 'ti,am625-dss-oldi-io-ctrl', 'ti,am62p-cpsw-mac-efuse', 'ti,am654-dss-oldi-io-ctrl', 'ti,j784s4-acspcie-proxy-ctrl', 'ti,j784s4-pcie-ctrl', 'ti,keystone-pllctrl']
	from schema $id: http://devicetree.org/schemas/mfd/syscon.yaml#
arch/arm/boot/dts/microchip/at91-sama7g54_curiosity.dtb: sfr@e0008000: compatible:0: 'microchip,sama7g5-sfrbu' is not one of ['al,alpine-sysfabric-service', 'allwinner,sun8i-a83t-system-controller', 'allwinner,sun8i-h3-system-controller', 'allwinner,sun8i-v3s-system-controller', 'allwinner,sun50i-a64-system-controller', 'altr,l3regs', 'altr,sdr-ctl', 'amd,pensando-elba-syscon', 'amlogic,meson-mx-assist', 'amlogic,meson-mx-bootrom', 'amlogic,meson8-analog-top', 'amlogic,meson8b-analog-top', 'amlogic,meson8-pmu', 'amlogic,meson8b-pmu', 'apm,merlin-poweroff-mailbox', 'apm,mustang-poweroff-mailbox', 'apm,xgene-csw', 'apm,xgene-efuse', 'apm,xgene-mcb', 'apm,xgene-rb', 'apm,xgene-scu', 'atmel,sama5d2-sfrbu', 'atmel,sama5d3-nfc-io', 'atmel,sama5d3-sfrbu', 'atmel,sama5d4-sfrbu', 'axis,artpec6-syscon', 'brcm,cru-clkset', 'brcm,sr-cdru', 'brcm,sr-mhb', 'cirrus,ep7209-syscon1', 'cirrus,ep7209-syscon2', 'cirrus,ep7209-syscon3', 'cnxt,cx92755-uc', 'freecom,fsg-cs2-system-controller', 'fsl,imx93-a
 onmix-ns-syscfg', 'fsl,imx93-wakeupmix-syscfg', 'fsl,ls1088a-reset', 'fsl,vf610-anatop', 'fsl,vf610-mscm-cpucfg', 'hisilicon,dsa-subctrl', 'hisilicon,hi6220-sramctrl', 'hisilicon,hip04-ppe', 'hisilicon,pcie-sas-subctrl', 'hisilicon,peri-subctrl', 'hpe,gxp-sysreg', 'loongson,ls1b-syscon', 'loongson,ls1c-syscon', 'lsi,axxia-syscon', 'marvell,armada-3700-cpu-misc', 'marvell,armada-3700-nb-pm', 'marvell,armada-3700-avs', 'marvell,armada-3700-usb2-host-misc', 'marvell,dove-global-config', 'mediatek,mt2701-pctl-a-syscfg', 'mediatek,mt2712-pctl-a-syscfg', 'mediatek,mt6397-pctl-pmic-syscfg', 'mediatek,mt8135-pctl-a-syscfg', 'mediatek,mt8135-pctl-b-syscfg', 'mediatek,mt8173-pctl-a-syscfg', 'mediatek,mt8365-syscfg', 'microchip,lan966x-cpu-syscon', 'microchip,mpfs-sysreg-scb', 'microchip,sam9x60-sfr', 'microchip,sama7d65-ddr3phy', 'microchip,sama7d65-sfrbu', 'microchip,sama7g5-ddr3phy', 'mscc,ocelot-cpu-syscon', 'mstar,msc313-pmsleep', 'nuvoton,ma35d1-sys', 'nuvoton,wpcm450-shm', 'rockchip,px3
 0-qos', 'rockchip,rk3036-qos', 'rockchip,rk3066-qos', 'rockchip,rk3128-qos', 'rockchip,rk3228-qos', 'rockchip,rk3288-qos', 'rockchip,rk3368-qos', 'rockchip,rk3399-qos', 'rockchip,rk3562-qos', 'rockchip,rk3568-qos', 'rockchip,rk3576-qos', 'rockchip,rk3588-qos', 'rockchip,rv1126-qos', 'st,spear1340-misc', 'stericsson,nomadik-pmu', 'starfive,jh7100-sysmain', 'ti,am62-opp-efuse-table', 'ti,am62-usb-phy-ctrl', 'ti,am625-dss-oldi-io-ctrl', 'ti,am62p-cpsw-mac-efuse', 'ti,am654-dss-oldi-io-ctrl', 'ti,j784s4-acspcie-proxy-ctrl', 'ti,j784s4-pcie-ctrl', 'ti,keystone-pllctrl']
	from schema $id: http://devicetree.org/schemas/mfd/syscon.yaml#






