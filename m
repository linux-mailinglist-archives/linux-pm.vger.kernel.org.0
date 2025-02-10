Return-Path: <linux-pm+bounces-21712-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 353E0A2F342
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 17:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFB4E1889D50
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 16:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1A324BD14;
	Mon, 10 Feb 2025 16:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q7kOpbmS"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431212580C8;
	Mon, 10 Feb 2025 16:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739204566; cv=none; b=S4Oi/Ivx3S2rhNE1Lh7VQ0mXo5mDv/nHSn9Qyctt0qaR534V5VWh/Oa55LVR0AcacUXZfx8s6SVgklHIMinY3+ngWxb3rFDfDtfTIJZwz6J02PTkFBvRPaaYiuSgy+7Ygv3rcki754uBhw68VGuWZoufziS1GfACG5ZhBEvcjRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739204566; c=relaxed/simple;
	bh=5pue0C/bvY7Bi4z8DCyV8fK5Y7JUy3U4ZkaQjuaNTCw=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=TMAtOLaKc/x7lzq1Ettk+5EHDQAiSIsGCXUR9vTumW580vfF1rmWZqCTW621GZrnCgV9iRAm4qaXW6yZxD2dWIHOofNXcffHjWJh9hjB5gfy+8m0CgVRjgg44nAwVMVgPk2/M0cmSn2llQfXYwtqziGHAbZXXwtgkmIfLrbU89s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q7kOpbmS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84FC0C4CEE6;
	Mon, 10 Feb 2025 16:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739204565;
	bh=5pue0C/bvY7Bi4z8DCyV8fK5Y7JUy3U4ZkaQjuaNTCw=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=Q7kOpbmSvyikwdl0vxdtsvwh3aPlVJKtOKvBumplA6jZU96aNqOf/2VNQRZsxcpFi
	 ivVRzLV+1fHR4GZ6yjJTQ9kSmhPHXHVPO7pEtbVEHdRPfwKNARwrG6CSzsdYEIipY5
	 Z/Usfk1EIFx408e+8pO5fTi91IkqEvYYgHCDLz77yy4G6Ut0EW5i3F0gM6CRbHbxby
	 Wtk8O7BufKk1n7g2d4WH37bPsPndpQtwmJU+Zpq9WIIFVIILD45ePkIrLB90FQrFQH
	 qas1Frr4pWnbkvcyyzMEQ53fNsEJjoCo0tQaluzkHzxGOw2xym+NxbGUl0YIXkaWFO
	 t1AdRCYX4NpsQ==
Date: Mon, 10 Feb 2025 10:22:44 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Chen Wang <unicorn_wang@outlook.com>, 
 linux-arm-kernel@lists.infradead.org, Sebastian Reichel <sre@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 Haylen Chu <heylenay@outlook.com>, linux-pm@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, soc@lists.linux.dev, 
 Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>, 
 Albert Ou <aou@eecs.berkeley.edu>, Inochi Amaoto <inochiama@outlook.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Catalin Marinas <catalin.marinas@arm.com>, Lee Jones <lee@kernel.org>
To: Alexander Sverdlin <alexander.sverdlin@gmail.com>
In-Reply-To: <20250209220646.1090868-1-alexander.sverdlin@gmail.com>
References: <20250209220646.1090868-1-alexander.sverdlin@gmail.com>
Message-Id: <173920412075.477254.10964125366963859194.robh@kernel.org>
Subject: Re: [PATCH 00/10] arm64 support for Milk-V Duo Module 01 EVB


On Sun, 09 Feb 2025 23:06:25 +0100, Alexander Sverdlin wrote:
> This series adds very basic support for Milk-V Duo Module 01 EVB [1] in
> arm64 mode. The SoC (SG2000) is dual-arch, RiscV and ARM64, the latter has
> been chosen because the upstream toolchain can be utilized.
> 
> Sophgo SG2000 seems to be a continuation of the Cvitek CV18xx series, same
> peripherals with an addition of ARM64 core. Therefore it would be
> beneficial not to copy-paste the peripherals' device-tree, but rather split
> the most suitable riscv DT into ARCH-specific and peripherals parts and
> just include the latter on the arm64 side.
> 
> This series adds the device-tree for Milk-V Duo Module 01 EVB, which
> in turn contains Milk-V Duo Module 01 (separate .dtsi) on it, which has
> SG2000 SoC inside (separate .dtsi).
> 
> This series has been tested with Sophgo-provided U-Boot binary [2]: it
> boots from SD card, pinctrl, serial, GPIO drivers are functional (same
> as for RiscV-based CV18xx SoCs).
> New reset driver is provided as an alternative to the ATF PSCI handler,
> which Sophgo only provides in binary form.
> 
> Partial SoC documentation is available [3].
> 
> This series lacks the support of:
> - USB
> - Audio
> - Ethernet
> - WiFi
> - Bluetooth
> - eMMC
> - Video
> 
> It would probably make sense that the whole series would go into SOC tree,
> even though technically nothing prevents the reboot/reset driver to come
> in PM/reset tree. If everything would come together, `reboot` command would
> work out of the box.
> 
> [1] https://milkv.io/docs/duo/getting-started/duo-module-01
> [2] https://github.com/milkv-duo/duo-buildroot-sdk-v2/releases/
> [3] https://github.com/sophgo/sophgo-doc/releases/download/sg2000-trm-v1.01/sg2000_trm_en.pdf
> 
> Alexander Sverdlin (10):
>   arm64: Add SOPHGO SOC family Kconfig support
>   riscv: dts: sophgo: cv18xx: Split into CPU core and peripheral parts
>   arm64: dts: sophgo: Add initial SG2000 SoC device tree
>   arm64: dts: sophgo: Add Duo Module 01
>   arm64: dts: sophgo: Add Duo Module 01 Evaluation Board
>   dt-bindings: mfd: syscon: Add Cvitek CV18xx rtcsys core and ctrl
>     compatible
>   dt-bindings: reset: sophgo: Add CV18xx reset controller
>   riscv/arm64: dts: cv18xx: Add sysctl and reset nodes
>   power: reset: cv18xx: New driver
>   arm64: defconfig: Enable rudimentary Sophgo SG2000 support
> 
>  .../devicetree/bindings/mfd/syscon.yaml       |   4 +
>  .../bindings/reset/sophgo,cv1800-reset.yaml   |  38 ++
>  MAINTAINERS                                   |   1 +
>  arch/arm64/Kconfig.platforms                  |  12 +
>  arch/arm64/boot/dts/Makefile                  |   1 +
>  arch/arm64/boot/dts/sophgo/Makefile           |   2 +
>  arch/arm64/boot/dts/sophgo/sg2000.dtsi        |  79 +++++
>  .../sophgo/sg2000_milkv_duo_module_01.dtsi    |  84 +++++
>  .../sophgo/sg2000_milkv_duo_module_01_evb.dts |  30 ++
>  arch/arm64/configs/defconfig                  |   3 +
>  arch/riscv/boot/dts/sophgo/cv181x.dtsi        |   2 +-
>  arch/riscv/boot/dts/sophgo/cv18xx-periph.dtsi | 329 ++++++++++++++++++
>  arch/riscv/boot/dts/sophgo/cv18xx.dtsi        | 305 +---------------
>  drivers/power/reset/Kconfig                   |  12 +
>  drivers/power/reset/Makefile                  |   1 +
>  drivers/power/reset/cv18xx-reset.c            |  89 +++++
>  16 files changed, 689 insertions(+), 303 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/reset/sophgo,cv1800-reset.yaml
>  create mode 100644 arch/arm64/boot/dts/sophgo/Makefile
>  create mode 100644 arch/arm64/boot/dts/sophgo/sg2000.dtsi
>  create mode 100644 arch/arm64/boot/dts/sophgo/sg2000_milkv_duo_module_01.dtsi
>  create mode 100644 arch/arm64/boot/dts/sophgo/sg2000_milkv_duo_module_01_evb.dts
>  create mode 100644 arch/riscv/boot/dts/sophgo/cv18xx-periph.dtsi
>  create mode 100644 drivers/power/reset/cv18xx-reset.c
> 
> --
> 2.48.1
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


New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/sophgo/' for 20250209220646.1090868-1-alexander.sverdlin@gmail.com:

arch/arm64/boot/dts/sophgo/sg2000_milkv_duo_module_01_evb.dtb: /: failed to match any schema with compatible: ['sophgo,sg2000']
arch/arm64/boot/dts/sophgo/sg2000_milkv_duo_module_01_evb.dtb: soc: soc-reset: 'ranges' is a required property
	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
arch/arm64/boot/dts/sophgo/sg2000_milkv_duo_module_01_evb.dtb: l2-cache: 'cache-unified' is a dependency of 'cache-size'
	from schema $id: http://devicetree.org/schemas/cache.yaml#
arch/arm64/boot/dts/sophgo/sg2000_milkv_duo_module_01_evb.dtb: l2-cache: 'cache-unified' is a required property
	from schema $id: http://devicetree.org/schemas/cache.yaml#
arch/arm64/boot/dts/sophgo/sg2000_milkv_duo_module_01_evb.dtb: l2-cache: Unevaluated properties are not allowed ('cache-level', 'cache-size' were unexpected)
	from schema $id: http://devicetree.org/schemas/cache.yaml#






