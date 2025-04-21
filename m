Return-Path: <linux-pm+bounces-25824-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CECEA9587A
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 23:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5860D16DC9A
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 21:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E116D219312;
	Mon, 21 Apr 2025 21:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ugb/cgBn"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA4E1D95A3;
	Mon, 21 Apr 2025 21:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745272439; cv=none; b=cbFlcqChQ/0Hleh2sGa3DgTa/E7+062tCkGNqHQLEE9kepWDtGfOx2fu5ysUSS29oKSSDGy4gsTRYKLWzOT6FywsY+ww25W1tDK5N61FEjnkUpBlnX8r4dhqMcYUFpnxXC6qHae5+yS0Nwog6vuNVdaNsKtE++0YEQm3lvsZR0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745272439; c=relaxed/simple;
	bh=Vm6Hkxbe37lldY/TsbKzLITo18iBkisy8BO+yd9b7/Y=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=fSBCkU+CnoabH3orYh9mjZAOvHMvEHNSLGDFx8Vua3AVm6hAYH2v277cQZ04n0sh1TZziSHxVINdXcsZz6eo6rrlQl0ny847Xx70xbxuGxefdffKw1fmEX+GgGV6v/Tvxh5o0v+eOwrRHANlIXK9Bb66PLLuPUUhAYBIBLMplrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ugb/cgBn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8FCFC4CEE4;
	Mon, 21 Apr 2025 21:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745272439;
	bh=Vm6Hkxbe37lldY/TsbKzLITo18iBkisy8BO+yd9b7/Y=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=Ugb/cgBn9+QWTEBsbA4mE3sdjXkL/4OThNwXfUOeiJh8hqn9WlhgAQ/jeECsp/eOD
	 U/59hlDa72oTvZs241K/6kHa0g0q0rkHf9QgS/UcYIFHKSk8+txKl5VGiseNmlK825
	 cB9Zj2I8h7wKsZ87RNaeUmj8pgEN2afnoZByYR1t6xfF4BPTrgxeX6YrHTH5d6EPEO
	 55HBN47bnCd7cN61PYHrjp/00JBQUGNi+JnJF16YBXqcf4RzWri3Nh4DKAZiX4yQRH
	 3tWYmSnUtGnHAXXD4tDwiq+41DS+K8PvDfujHBxaGk2djSwCceakvjPje54SIPF0vS
	 E11WaaDo19yHQ==
Date: Mon, 21 Apr 2025 16:53:57 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 Alim Akhtar <alim.akhtar@samsung.com>, linux-pm@vger.kernel.org, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dimitri Fedrau <dima.fedrau@gmail.com>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Will Deacon <will@kernel.org>, 
 devicetree@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>
To: Thomas Antoine <t.antoine@uclouvain.be>
In-Reply-To: <20250421-b4-gs101_max77759_fg-v3-0-50cd8caf9017@uclouvain.be>
References: <20250421-b4-gs101_max77759_fg-v3-0-50cd8caf9017@uclouvain.be>
Message-Id: <174527239330.2996733.2164044396415620097.robh@kernel.org>
Subject: Re: [PATCH v3 0/5] Google Pixel 6 (oriole): max77759 fuel gauge
 enablement and driver support


On Mon, 21 Apr 2025 20:13:31 +0200, Thomas Antoine wrote:
> The Google Pixel 6 has a Maxim MAX77759 which provides a fuel gauge with
> an interface with a lot in common with the Maxim max1720x.
> 
> Modify the Maxim MAX1720x driver to be compatible with the Maxim MAX77759
> and enable it for the gs101-oriole board.
> 
> The voltage, current, capacity, temperature and charge have all been
> tested and show coherent results. The charge full design and capacity
> equal the ones seen on android, the ratio between average charge and
> average current does predict pretty accurately the time to empty under
> a constant workload and temperature is coherent with the dynamic state
> of the device.
> 
> Health is not enabled as it always reports overheating. The time to empty
> is wrong by about a factor 2 and is thus also disabled.
> 
> Signed-off-by: Thomas Antoine <t.antoine@uclouvain.be>
> 
> ---
> Changes in v3:
> - Update base tree to avoid conflicts
> - Fix capacity computation for max1720x
> - Add separate properties for the max7759 to disable non-functional ones
> - Take TASKPERIOD into account for voltage computation of max77759
> - Simplify vcell computation (Dimitri Fedrau)
> - Switch has_nvmem to bool and keep it only in chip_data (Dimitri Fedrau)
> - Drop the yes_range from the write table (Sebastian Reichel)
> - Add test_power_supply_properties.sh to cover letter (Sebastian Reichel)
> - Switch back some changes to binding and actually use allOf:if: to
>   restrict constraints (Krzysztof Kozlowski)
> - Fix style errors
> - Link to v2: https://lore.kernel.org/r/20250102-b4-gs101_max77759_fg-v2-0-87959abeb7ff@uclouvain.be
> 
> Changes in v2:
> - Add fallback for voltage measurement (André Draszik)
> - Add regmap for the max77759 (André Draszik)
> - Add chip identification for the max77759 (André Draszik, Peter Griffin)
> - Move RSense value to a devicetree property shunt-resistor-micro-ohms
>   (Dimitri Fedrau, André Draszik)
> - Use allOf:if to narrow binding per variant (Krzysztof Kozlowski)
> - Remove binding example (Krzysztof Kozlowski)
> - Change defconfig order to follow savedefconfig (Krzysztof Kozlowski)
> - Fix style errors
> - Link to v1: https://lore.kernel.org/r/20241202-b4-gs101_max77759_fg-v1-0-98d2fa7bfe30@uclouvain.be
> 
> tools/testing/selftests/power_supply/test_power_supply_properties.sh:
> ok 1 max77759-fg.exists
> ok 2 max77759-fg.uevent.NAME
> ok 3 max77759-fg.sysfs.type
> ok 4 max77759-fg.uevent.TYPE
> ok 5 max77759-fg.sysfs.usb_type # SKIP
> ok 6 max77759-fg.sysfs.online # SKIP
> ok 7 max77759-fg.sysfs.present
> ok 8 max77759-fg.sysfs.status # SKIP
> ok 9 max77759-fg.sysfs.capacity
> ok 10 max77759-fg.sysfs.capacity_level # SKIP
> ok 11 max77759-fg.sysfs.model_name
> ok 12 max77759-fg.sysfs.manufacturer
> ok 13 max77759-fg.sysfs.serial_number # SKIP
> ok 14 max77759-fg.sysfs.technology # SKIP
> ok 15 max77759-fg.sysfs.cycle_count # SKIP
> ok 16 max77759-fg.sysfs.scope # SKIP
> ok 17 max77759-fg.sysfs.input_current_limit # SKIP(Dimitri Fedrau)
> ok 18 max77759-fg.sysfs.input_voltage_limit # SKIP
> ok 19 max77759-fg.sysfs.voltage_now
> ok 20 max77759-fg.sysfs.voltage_min # SKIP
> ok 21 max77759-fg.sysfs.voltage_max # SKIP
> ok 22 max77759-fg.sysfs.voltage_min_design # SKIP
> ok 23 max77759-fg.sysfs.voltage_max_design # SKIP
> ok 24 max77759-fg.sysfs.current_now
> ok 25 max77759-fg.sysfs.current_max # SKIP
> ok 26 max77759-fg.sysfs.charge_now # SKIP
> ok 27 max77759-fg.sysfs.charge_full
> ok 28 max77759-fg.sysfs.charge_full_design
> ok 29 max77759-fg.sysfs.power_now # SKIP
> ok 30 max77759-fg.sysfs.energy_now # SKIP
> ok 31 max77759-fg.sysfs.energy_full # SKIP
> ok 32 max77759-fg.sysfs.energy_full_design # SKIP
> ok 33 max77759-fg.sysfs.energy_full_design # SKIP
> 
> ---
> Thomas Antoine (5):
>       power: supply: correct capacity computation
>       power: supply: add support for max77759 fuel gauge
>       dt-bindings: power: supply: add max77759-fg flavor
>       arm64: defconfig: enable Maxim max1720x driver
>       arm64: dts: exynos: gs101-oriole: enable Maxim max77759 fuel gauge
> 
>  .../bindings/power/supply/maxim,max17201.yaml      |  34 ++-
>  .../boot/dts/exynos/google/gs101-pixel-common.dtsi |  10 +
>  arch/arm64/configs/defconfig                       |   1 +
>  drivers/power/supply/max1720x_battery.c            | 271 ++++++++++++++++++---
>  4 files changed, 280 insertions(+), 36 deletions(-)
> ---
> base-commit: e48e99b6edf41c69c5528aa7ffb2daf3c59ee105
> change-id: 20241202-b4-gs101_max77759_fg-402e231a4b33
> 
> Best regards,
> --
> Thomas Antoine <t.antoine@uclouvain.be>
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
 Base: using specified base-commit e48e99b6edf41c69c5528aa7ffb2daf3c59ee105

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/exynos/' for 20250421-b4-gs101_max77759_fg-v3-0-50cd8caf9017@uclouvain.be:

arch/arm64/boot/dts/exynos/google/gs101-raven.dtb: fuel-gauge@36 (maxim,max77759-fg): reg: [[54]] is too short
	from schema $id: http://devicetree.org/schemas/power/supply/maxim,max17201.yaml#
arch/arm64/boot/dts/exynos/google/gs101-raven.dtb: fuel-gauge@36 (maxim,max77759-fg): reg-names: ['m5'] is too short
	from schema $id: http://devicetree.org/schemas/power/supply/maxim,max17201.yaml#
arch/arm64/boot/dts/exynos/google/gs101-raven.dtb: fuel-gauge@36 (maxim,max77759-fg): Unevaluated properties are not allowed ('reg-names' was unexpected)
	from schema $id: http://devicetree.org/schemas/power/supply/maxim,max17201.yaml#
arch/arm64/boot/dts/exynos/google/gs101-oriole.dtb: fuel-gauge@36 (maxim,max77759-fg): reg: [[54]] is too short
	from schema $id: http://devicetree.org/schemas/power/supply/maxim,max17201.yaml#
arch/arm64/boot/dts/exynos/google/gs101-oriole.dtb: fuel-gauge@36 (maxim,max77759-fg): reg-names: ['m5'] is too short
	from schema $id: http://devicetree.org/schemas/power/supply/maxim,max17201.yaml#
arch/arm64/boot/dts/exynos/google/gs101-oriole.dtb: fuel-gauge@36 (maxim,max77759-fg): Unevaluated properties are not allowed ('reg-names' was unexpected)
	from schema $id: http://devicetree.org/schemas/power/supply/maxim,max17201.yaml#






