Return-Path: <linux-pm+bounces-24547-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E2DA71EEC
	for <lists+linux-pm@lfdr.de>; Wed, 26 Mar 2025 20:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37B7F1891DE5
	for <lists+linux-pm@lfdr.de>; Wed, 26 Mar 2025 19:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2738325A2A5;
	Wed, 26 Mar 2025 19:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZYrZOeou"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF70259C9B;
	Wed, 26 Mar 2025 19:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743016305; cv=none; b=HyPRlh5hGuZdpHwBFEFnCqbIuipihQnI+P2QidQJN9BjMQ630kBOSQEzSewDn7txCZLXZXdMqR+pKXgLxHBKtgKJU8ltfdCY9l8s4JtnLuU5XjKQdDeb9ukhFpW/o78UU3uk62Hzv9dnnsBTEbfzedZl5WQk2y3D3NvjaHoD9Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743016305; c=relaxed/simple;
	bh=Us8YWiCzxgYODP43pk9zrPOA1Ydpaw0luFLw+yOQ/GM=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=YSqdCzMo5fautr5GegBw3CyAZDPyXcn8+/MdrzkvHGRz3l0ymBSLcLxsNYxTWj7UJ5qtl4LWiiDmkRmOMDyqqJTC0I3FiRtJgYI46n6LjslyK0cspDy+K0/ScJyo78OGo+fOPUJjXiVlylgG/wJy9WE9Lz19fYP2rN+FGqhRSOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZYrZOeou; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10FA6C4AF0B;
	Wed, 26 Mar 2025 19:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743016304;
	bh=Us8YWiCzxgYODP43pk9zrPOA1Ydpaw0luFLw+yOQ/GM=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=ZYrZOeou15Rf5L+14+/CvVZfxbArRcWExVnvlfCNh5zOPAmX2uGsIqrrC1bUXuGcn
	 Mg6UT+RMEVgfdnv3EuAnU4/jb6D6X5jGlMxQRnCi9MxNj+gTmv83JQwbfxaIriQGmh
	 +q79HCReBBreSGAp4q7vn4Kw8D3FNyrH0H3QrZRIqKxpezfTa+R1roV/EhQoAjBdEo
	 qoXAyUKX+EW5+srPVNjKGCuILCEuPy2CrrPjmll5NpnbCvDCh7N0byd5Jf6VJoMYxF
	 uz2LDtKTvA38MxvzvDP+cRpAdkougyWsoZDGtD79F+36Ve/ZgjOO9884VUvUtCsKW6
	 kcu8ddRSJCxfg==
Date: Wed, 26 Mar 2025 14:11:43 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: alexandre.belloni@bootlin.com, nicolas.ferre@microchip.com, 
 sre@kernel.org, krzk+dt@kernel.org, devicetree@vger.kernel.org, 
 lee@kernel.org, linux-kernel@vger.kernel.org, claudiu.beznea@tuxon.dev, 
 p.zabel@pengutronix.de, linux-rtc@vger.kernel.org, conor+dt@kernel.org, 
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
To: Ryan.Wanner@microchip.com
In-Reply-To: <cover.1742936082.git.Ryan.Wanner@microchip.com>
References: <cover.1742936082.git.Ryan.Wanner@microchip.com>
Message-Id: <174301524187.2716584.9866495149541048888.robh@kernel.org>
Subject: Re: [PATCH v4 00/11] Enable Power Modes Support for SAMA7D65 SoC


On Wed, 26 Mar 2025 08:35:33 -0700, Ryan.Wanner@microchip.com wrote:
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
> Changes from v3 -> v4:
> - Add sama7d65-gpbr to the dt-binding.
> - Converted the sama5d2-secumod binding into yaml format.
> - Add sama7d65-secumod to the new dt binding.
> - Collect and remove applied and accpeted pathces from the set.
> 
> v1) https://lore.kernel.org/linux-arm-kernel/cover.1738257860.git.Ryan.Wanner@microchip.com/
> v2) https://lore.kernel.org/linux-arm-kernel/cover.1739221064.git.Ryan.Wanner@microchip.com/
> v3) https://lore.kernel.org/linux-arm-kernel/cover.1740671156.git.Ryan.Wanner@microchip.com/T/#m576233e7af84d68559afb286884c2b9294e7bc1d
> 
> Ryan Wanner (11):
>   dt-bindings: sram: Add microchip,sama7d65-sram
>   dt-bindings: power: reset: atmel,sama5d2-shdwc: Add
>     microchip,sama7d65-shdwc
>   dt-bindings: reset: atmel,at91sam9260-reset: add
>     microchip,sama7d65-rstc
>   dt-bindings: rtc: at91rm9200: add microchip,sama7d65-rtc
>   dt-bindings: at91rm9260-rtt: add microchip,sama7d65-rtt
>   dt-bindings: mfd: atmel: Add microchip,sama7d65-gpbr
>   dt-bindings: mfd: syscon: atmel,sama5d2-secumod: convert to yaml
>   dt-bindings: mfd: syscon: add microchip,sama7d65-secumod
>   ARM: dts: microchip: sama7d65: Add SRAM and DRAM components support
>   ARM: dts: microchip: sama7d65: Add RTT and GPBR Support for sama7d65
>     SoC
>   ARM: dts: microchip: sama7d65: Add RTT timer to curiosity board
> 
>  .../bindings/arm/atmel,sama5d2-secumod.yaml   | 49 +++++++++++++++++++
>  .../devicetree/bindings/arm/atmel-sysregs.txt | 25 ----------
>  .../bindings/mfd/atmel,at91sam9260-gpbr.yaml  |  1 +
>  .../power/reset/atmel,sama5d2-shdwc.yaml      |  5 ++
>  .../reset/atmel,at91sam9260-reset.yaml        |  3 ++
>  .../bindings/rtc/atmel,at91rm9200-rtc.yaml    |  4 +-
>  .../bindings/rtc/atmel,at91sam9260-rtt.yaml   |  1 +
>  .../devicetree/bindings/sram/sram.yaml        |  1 +
>  .../dts/microchip/at91-sama7d65_curiosity.dts |  4 ++
>  arch/arm/boot/dts/microchip/sama7d65.dtsi     | 47 ++++++++++++++++++
>  10 files changed, 114 insertions(+), 26 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/atmel,sama5d2-secumod.yaml
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


This patch series was applied (using b4) to base:
 Base: attempting to guess base-commit...
 Base: tags/next-20250326 (best guess, 7/9 blobs matched)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm/boot/dts/microchip/' for cover.1742936082.git.Ryan.Wanner@microchip.com:

arch/arm/boot/dts/microchip/aks-cdu.dtb: /: compatible: 'oneOf' conditional failed, one must be fixed:
	['atmel,at91sam9260'] is too short
	'atmel,at91rm9200' was expected
	'olimex,sam9-l9260' was expected
	'calao,usb-a9260' was expected
	'calao,usb-a9263' was expected
	'calao,usb-a9g20' was expected
	'calao,usb-a9g20-lpw' was expected
	'atmel,at91sam9260' is not one of ['overkiz,kizboxmini-base', 'overkiz,kizboxmini-mb', 'overkiz,kizboxmini-rd', 'overkiz,smartkiz', 'gardena,smart-gateway-at91sam']
	'atmel,at91sam9260' is not one of ['atmel,at91sam9g15', 'atmel,at91sam9g25', 'atmel,at91sam9g35', 'atmel,at91sam9x25', 'atmel,at91sam9x35']
	'overkiz,kizbox3-hs' was expected
	'microchip,sama5d27-wlsom1' was expected
	'microchip,sama5d27-wlsom1-ek' was expected
	'microchip,sama5d29-curiosity' was expected
	'atmel,sama5d27' was expected
	'microchip,sama5d2-icp' was expected
	'atmel,at91sam9260' is not one of ['microchip,sam9x60ek', 'microchip,sam9x60-curiosity']
	'microchip,sam9x75-curiosity' was expected
	'axentia,nattis-2' was expected
	'axentia,tse850v3' was expected
	'axentia,linea' was expected
	'overkiz,kizbox2-2' was expected
	'microchip,sama5d3-eds' was expected
	'calamp,lmu5000' was expected
	'exegin,q5xr5' was expected
	'atmel,at91sam9260' is not one of ['atmel,sama5d31', 'atmel,sama5d33', 'atmel,sama5d34', 'atmel,sama5d35', 'atmel,sama5d36']
	'atmel,at91sam9260' is not one of ['atmel,sama5d41', 'atmel,sama5d42', 'atmel,sama5d43', 'atmel,sama5d44']
	'microchip,sama7d65-curiosity' was expected
	'microchip,sama7g5ek' was expected
	'microchip,sama7g54-curiosity' was expected
	'atmel,at91sam9260' is not one of ['microchip,lan9662-pcb8291', 'microchip,lan9662-pcb8309']
	'microchip,lan9668-pcb8290' was expected
	'atmel,at91sam9260' is not one of ['kontron,kswitch-d10-mmt-8g', 'kontron,kswitch-d10-mmt-6g-2gs']
	'atmel,at91sam9260' is not one of ['atmel,sams70j19', 'atmel,sams70j20', 'atmel,sams70j21', 'atmel,sams70n19', 'atmel,sams70n20', 'atmel,sams70n21', 'atmel,sams70q19', 'atmel,sams70q20', 'atmel,sams70q21']
	'atmel,at91sam9260' is not one of ['atmel,samv70j19', 'atmel,samv70j20', 'atmel,samv70n19', 'atmel,samv70n20', 'atmel,samv70q19', 'atmel,samv70q20']
	'atmel,at91sam9260' is not one of ['atmel,samv71j19', 'atmel,samv71j20', 'atmel,samv71j21', 'atmel,samv71n19', 'atmel,samv71n20', 'atmel,samv71n21', 'atmel,samv71q19', 'atmel,samv71q20', 'atmel,samv71q21']
	from schema $id: http://devicetree.org/schemas/arm/atmel-at91.yaml#
arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dtb: /soc/uddrc@e3800000: failed to match any schema with compatible: ['microchip,sama7d65-uddrc', 'microchip,sama7g5-uddrc']
arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dtb: /soc/uddrc@e3800000: failed to match any schema with compatible: ['microchip,sama7d65-uddrc', 'microchip,sama7g5-uddrc']
arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dtb: ddr3phy@e3804000: compatible:0: 'microchip,sama7d65-ddr3phy' is not one of ['airoha,en7581-pbus-csr', 'al,alpine-sysfabric-service', 'allwinner,sun8i-a83t-system-controller', 'allwinner,sun8i-h3-system-controller', 'allwinner,sun8i-v3s-system-controller', 'allwinner,sun50i-a64-system-controller', 'altr,l3regs', 'altr,sdr-ctl', 'amd,pensando-elba-syscon', 'amlogic,meson-mx-assist', 'amlogic,meson-mx-bootrom', 'amlogic,meson8-analog-top', 'amlogic,meson8b-analog-top', 'amlogic,meson8-pmu', 'amlogic,meson8b-pmu', 'apm,merlin-poweroff-mailbox', 'apm,mustang-poweroff-mailbox', 'apm,xgene-csw', 'apm,xgene-efuse', 'apm,xgene-mcb', 'apm,xgene-rb', 'apm,xgene-scu', 'atmel,sama5d2-sfrbu', 'atmel,sama5d3-nfc-io', 'atmel,sama5d3-sfrbu', 'atmel,sama5d4-sfrbu', 'axis,artpec6-syscon', 'brcm,cru-clkset', 'brcm,sr-cdru', 'brcm,sr-mhb', 'cirrus,ep7209-syscon1', 'cirrus,ep7209-syscon2', 'cirrus,ep7209-syscon3', 'cnxt,cx92755-uc', 'freecom,fsg-cs2
 -system-controller', 'fsl,imx93-aonmix-ns-syscfg', 'fsl,imx93-wakeupmix-syscfg', 'fsl,ls1088a-reset', 'fsl,vf610-anatop', 'fsl,vf610-mscm-cpucfg', 'hisilicon,dsa-subctrl', 'hisilicon,hi6220-sramctrl', 'hisilicon,hip04-ppe', 'hisilicon,pcie-sas-subctrl', 'hisilicon,peri-subctrl', 'hpe,gxp-sysreg', 'loongson,ls1b-syscon', 'loongson,ls1c-syscon', 'lsi,axxia-syscon', 'marvell,armada-3700-cpu-misc', 'marvell,armada-3700-nb-pm', 'marvell,armada-3700-avs', 'marvell,armada-3700-usb2-host-misc', 'marvell,dove-global-config', 'mediatek,mt2701-pctl-a-syscfg', 'mediatek,mt2712-pctl-a-syscfg', 'mediatek,mt6397-pctl-pmic-syscfg', 'mediatek,mt8135-pctl-a-syscfg', 'mediatek,mt8135-pctl-b-syscfg', 'mediatek,mt8173-pctl-a-syscfg', 'mediatek,mt8365-syscfg', 'microchip,lan966x-cpu-syscon', 'microchip,mpfs-sysreg-scb', 'microchip,sam9x60-sfr', 'microchip,sama7g5-ddr3phy', 'mscc,ocelot-cpu-syscon', 'mstar,msc313-pmsleep', 'nuvoton,ma35d1-sys', 'nuvoton,wpcm450-shm', 'rockchip,px30-qos', 'rockchip,rk3036-
 qos', 'rockchip,rk3066-qos', 'rockchip,rk3128-qos', 'rockchip,rk3228-qos', 'rockchip,rk3288-qos', 'rockchip,rk3368-qos', 'rockchip,rk3399-qos', 'rockchip,rk3528-qos', 'rockchip,rk3562-qos', 'rockchip,rk3568-qos', 'rockchip,rk3576-qos', 'rockchip,rk3588-qos', 'rockchip,rv1126-qos', 'st,spear1340-misc', 'stericsson,nomadik-pmu', 'starfive,jh7100-sysmain', 'ti,am62-opp-efuse-table', 'ti,am62-usb-phy-ctrl', 'ti,am625-dss-oldi-io-ctrl', 'ti,am62p-cpsw-mac-efuse', 'ti,am654-dss-oldi-io-ctrl', 'ti,j784s4-acspcie-proxy-ctrl', 'ti,j784s4-pcie-ctrl', 'ti,keystone-pllctrl']
	from schema $id: http://devicetree.org/schemas/mfd/syscon.yaml#
arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dtb: ddr3phy@e3804000: compatible:1: 'syscon' was expected
	from schema $id: http://devicetree.org/schemas/mfd/syscon.yaml#
arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dtb: ddr3phy@e3804000: compatible: ['microchip,sama7d65-ddr3phy', 'microchip,sama7g5-ddr3phy'] does not contain items matching the given schema
	from schema $id: http://devicetree.org/schemas/mfd/syscon.yaml#
arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dtb: ddr3phy@e3804000: Unevaluated properties are not allowed ('compatible' was unexpected)
	from schema $id: http://devicetree.org/schemas/mfd/syscon.yaml#
arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dtb: /soc/ddr3phy@e3804000: failed to match any schema with compatible: ['microchip,sama7d65-ddr3phy', 'microchip,sama7g5-ddr3phy']
arch/arm/boot/dts/microchip/usb_a9263.dtb: /ahb/apb/gadget@fff78000: failed to match any schema with compatible: ['atmel,at91sam9263-udc']






