Return-Path: <linux-pm+bounces-38645-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D05C86795
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 19:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7E03D34FFD6
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 18:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96FF32D0C3;
	Tue, 25 Nov 2025 18:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQwKWX5p"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C57C32D7DE;
	Tue, 25 Nov 2025 18:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764094179; cv=none; b=fPl99hs4ToojhdieAkrFrH5D3+3i59Gk2b3glngpNxLQDdmyOEDkmyF0oc8w4wfRvYN8wjvpwPAG8O8bEoHTr3ABIY4zkeSBBETrDjJi2MlAvwULuayjvypnarU/N3kX0jOwK5UXVZMol692on132QnseUi+LOGS44a4gEvhSpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764094179; c=relaxed/simple;
	bh=ZGvj91/ocezG1d2ldla9tCcuUOW1xhaG8x2goTgx0m4=;
	h=From:Date:Content-Type:MIME-Version:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=H5HPPqR2V/PDepgcRzj0zOl1wmfH88pYut3VPowWbej7QGNIdqNUNzKA00f9+72jhVRdTgWjyWtiGfVgwReIMYVBkhlsYaeVasfXP5gWk0SR5QGB8CmWnpL27jEglQNXtsoA4Upivl976js3cxSk66m+NYDy4mDhEN810RZ6/LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vQwKWX5p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1E6DC16AAE;
	Tue, 25 Nov 2025 18:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764094179;
	bh=ZGvj91/ocezG1d2ldla9tCcuUOW1xhaG8x2goTgx0m4=;
	h=From:Date:Cc:To:In-Reply-To:References:Subject:From;
	b=vQwKWX5piQlQhx9xWkJI+5hkDTAK8fn0RGCXpeiatlqX6wYITNA6bwiAEFUU1gwir
	 lZ7fYgiCv8DXW2J5ygat6h+VOMD+t2V//Z67nE2da0jLOMAyV/D5sk2JSDLZQ5nJaU
	 Rq+6o4gECFx2JuWLdUtgnjIYOzljzuIyNi6l6739qBhqWfhAPJLg/UUWqa9C0vtkHs
	 IMOXXZHWHmLdznDd666v33bTRdbGkImbfz6oXRMq11+m1x+y2QeouQMBSqJsclfub9
	 faCRzfWB/e+NXJZn8/0di8wWEpEnOZ77I4becloB97493jz/wz5ImQpshlFG8tbfdK
	 HWHhMdRqeKT1g==
From: Rob Herring <robh@kernel.org>
Date: Tue, 25 Nov 2025 12:09:37 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Cc: Casey Connolly <casey@connolly.tech>, 
 Richard Acayan <mailingradian@gmail.com>, 
 Sebastian Reichel <sre@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yassine Oudjana <y.oudjana@protonmail.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Alexander Martinz <amartinz@shiftphones.com>, 
 Joel Selvaraj <foss@joelselvaraj.com>, devicetree@vger.kernel.org, 
 linux-pm@vger.kernel.org, Alexey Minnekhanov <alexeymin@postmarketos.org>, 
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
To: David Heidelberg <david@ixit.cz>
In-Reply-To: <20251124-pmi8998_fuel_gauge-v1-0-dd3791f61478@ixit.cz>
References: <20251124-pmi8998_fuel_gauge-v1-0-dd3791f61478@ixit.cz>
Message-Id: <176409395655.3843824.5831772770634369017.robh@kernel.org>
Subject: Re: [PATCH RFC 0/8] Qualcomm 3rd gen fuel gauge support


On Mon, 24 Nov 2025 22:53:33 +0100, David Heidelberg wrote:
> This FG (fuel gauge) can be found on Snapdragon 835, 845, 660, 670..
> 
> Series enables the FG, which is used on phones as OnePlus 6, 6T, Pixel 3a..
> 
> Since many downstream trees (sdm845-mainline, sdm660, sdm670) carring
> these patches, after Barnabás dropped older gen support from the driver,
> cleaned up the driver, I picked changes and cleaned up device-tree
> patches and sending the whole bulk for review.
> 
> Note:
> Usually I picked the oldest commits authors.
> Since there was multiple patches, multiple names and modifications etc.,
> if someone from the authors, co-developers, contributors etc. missing,
> please let me know and I'll fix this up in the next series.
> 
> Currently some authors are unreachable or haven't given Signed-off-by
> yet, thus RFC, when this get cleaned up, I'll sent non-RFC or leave it
> to the authors to continue upstreaming process in case they want to.
> 
> Until merged (or taken over by the original authors), the series is
> available at:
>   https://gitlab.com/sdm845/sdm845-next/-/commits/b4%2Fpmi8998_fuel_gauge
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
> Changes in v1:
> - Clean and read charge full and max voltage from dts. (Joel)
> - Dont put battery info on remove. All the battery info data is devm
>   tracked so it will be freed for us on removal. (Casey)
> - Invert charging current. Battery current should be negative for charging
>   batteries, invert it so it's correct. Fixes upower charging status
>   reporting. (Casey)
> - Expose PROP_STATUS to fix upower not detecting charging status properly.
> - Adopt battery info API changes.
> - Silence -EPROBE_DEFER error. (Richard)
> - Add present sysfs property. Required for battery drivers from
>   UPower>=1.90.0 onwards to work properly. (Alexander)
> - Drop support for older gen from the driver. (Barnabás)
> - Rename the driver to pmi8998_fg. (Barnabás)
> - Remove unnecessary batt_info. (Barnabás)
> - Fix all checkpatch issues in strict mode. (Barnabás)
> - Fixed naming, properties sorting, styling issues, few checkpatch
>   warnings. (David)
> - Updated Joel to "Joel Selvaraj <foss@joelselvaraj.com>" everywhere
>   (patch author, author field inside the driver, dt docs). (David)
> - Link to v0:
>   - https://gitlab.com/msm8998-mainline/linux/ (very old)
>   - https://gitlab.com/sdm845-mainline/linux/ (multiple branches)
>   - https://github.com/sdm660-mainline/linux/
>   - https://gitlab.com/sdm670-mainline/linux-patches/-/tree/main/stable
> 
> ---
> Alexey Minnekhanov (1):
>       arm64: dts: qcom: sdm660-xiaomi-lavender: Enable support for battery
> 
> Casey Connolly (2):
>       arm64: dts: qcom: pmi8998: Add fuel gauge
>       arm64: dts: qcom: sdm845-shift-axolotl: Enable fuel gauge
> 
> Joel Selvaraj (2):
>       power: supply: Add driver for Qualcomm PMI8998 fuel gauge
>       arm64: dts: qcom: sdm845-xiaomi-beryllium: Enable fuel gauge
> 
> Richard Acayan (2):
>       arm64: dts: qcom: pm660: Add fuel gauge
>       arm64: dts: qcom: sdm670-google-sargo: Enable fuel gauge
> 
> Yassine Oudjana (1):
>       dt-bindings: power: supply: Add schema for Qualcomm pmi8998 fuel gauge
> 
>  .../bindings/power/supply/qcom,pmi8998-fg.yaml     |  77 +++
>  arch/arm64/boot/dts/qcom/pm660.dtsi                |  10 +
>  arch/arm64/boot/dts/qcom/pmi8998.dtsi              |  11 +
>  .../arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dts |  25 +
>  arch/arm64/boot/dts/qcom/sdm670-google-sargo.dts   |   7 +
>  arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts  |   7 +
>  .../dts/qcom/sdm845-xiaomi-beryllium-common.dtsi   |   7 +
>  drivers/power/supply/Kconfig                       |   8 +
>  drivers/power/supply/Makefile                      |   1 +
>  drivers/power/supply/pmi8998_fg.c                  | 687 +++++++++++++++++++++
>  10 files changed, 840 insertions(+)
> ---
> base-commit: 422f3140bbcb657e1b86c484296972ab76f6d1ff
> change-id: 20251121-pmi8998_fuel_gauge-cfaf78ed103d
> 
> Best regards,
> --
> David Heidelberg <david@ixit.cz>
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
 Base: 422f3140bbcb657e1b86c484296972ab76f6d1ff (use --merge-base to override)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/qcom/' for 20251124-pmi8998_fuel_gauge-v1-0-dd3791f61478@ixit.cz:

arch/arm64/boot/dts/qcom/msm8998-mtp.dtb: pmic@2 (qcom,pmi8998): 'fuel-gauge@4000' does not match any of the regexes: '(.*)?(wled|leds)@[0-9a-f]+$', '^adc-tm@[0-9a-f]+$', '^adc@[0-9a-f]+$', '^audio-codec@[0-9a-f]+$', '^battery@[0-9a-f]+$', '^charger@[0-9a-f]+$', '^led-controller@[0-9a-f]+$', '^mpps@[0-9a-f]+$', '^nvram@[0-9a-f]+$', '^pbs@[0-9a-f]+$', '^pinctrl-[0-9]+$', '^rtc@[0-9a-f]+$', '^temp-alarm@[0-9a-f]+$', '^typec@[0-9a-f]+$', '^usb-detect@[0-9a-f]+$', '^usb-vbus-regulator@[0-9a-f]+$', '^vibrator@[0-9a-f]+$', 'gpio@[0-9a-f]+$', 'phy@[0-9a-f]+$', 'pon@[0-9a-f]+$'
	from schema $id: http://devicetree.org/schemas/mfd/qcom,spmi-pmic.yaml
arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dtb: pmic@2 (qcom,pmi8998): 'fuel-gauge@4000' does not match any of the regexes: '(.*)?(wled|leds)@[0-9a-f]+$', '^adc-tm@[0-9a-f]+$', '^adc@[0-9a-f]+$', '^audio-codec@[0-9a-f]+$', '^battery@[0-9a-f]+$', '^charger@[0-9a-f]+$', '^led-controller@[0-9a-f]+$', '^mpps@[0-9a-f]+$', '^nvram@[0-9a-f]+$', '^pbs@[0-9a-f]+$', '^pinctrl-[0-9]+$', '^rtc@[0-9a-f]+$', '^temp-alarm@[0-9a-f]+$', '^typec@[0-9a-f]+$', '^usb-detect@[0-9a-f]+$', '^usb-vbus-regulator@[0-9a-f]+$', '^vibrator@[0-9a-f]+$', 'gpio@[0-9a-f]+$', 'phy@[0-9a-f]+$', 'pon@[0-9a-f]+$'
	from schema $id: http://devicetree.org/schemas/mfd/qcom,spmi-pmic.yaml
arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-maple.dtb: pmic@2 (qcom,pmi8998): 'fuel-gauge@4000' does not match any of the regexes: '(.*)?(wled|leds)@[0-9a-f]+$', '^adc-tm@[0-9a-f]+$', '^adc@[0-9a-f]+$', '^audio-codec@[0-9a-f]+$', '^battery@[0-9a-f]+$', '^charger@[0-9a-f]+$', '^led-controller@[0-9a-f]+$', '^mpps@[0-9a-f]+$', '^nvram@[0-9a-f]+$', '^pbs@[0-9a-f]+$', '^pinctrl-[0-9]+$', '^rtc@[0-9a-f]+$', '^temp-alarm@[0-9a-f]+$', '^typec@[0-9a-f]+$', '^usb-detect@[0-9a-f]+$', '^usb-vbus-regulator@[0-9a-f]+$', '^vibrator@[0-9a-f]+$', 'gpio@[0-9a-f]+$', 'phy@[0-9a-f]+$', 'pon@[0-9a-f]+$'
	from schema $id: http://devicetree.org/schemas/mfd/qcom,spmi-pmic.yaml
arch/arm64/boot/dts/qcom/sdm630-sony-xperia-ganges-kirin.dtb: pmic@0 (qcom,pm660): 'fuel-gauge@4000' does not match any of the regexes: '(.*)?(wled|leds)@[0-9a-f]+$', '^adc-tm@[0-9a-f]+$', '^adc@[0-9a-f]+$', '^audio-codec@[0-9a-f]+$', '^battery@[0-9a-f]+$', '^charger@[0-9a-f]+$', '^led-controller@[0-9a-f]+$', '^mpps@[0-9a-f]+$', '^nvram@[0-9a-f]+$', '^pbs@[0-9a-f]+$', '^pinctrl-[0-9]+$', '^rtc@[0-9a-f]+$', '^temp-alarm@[0-9a-f]+$', '^typec@[0-9a-f]+$', '^usb-detect@[0-9a-f]+$', '^usb-vbus-regulator@[0-9a-f]+$', '^vibrator@[0-9a-f]+$', 'gpio@[0-9a-f]+$', 'phy@[0-9a-f]+$', 'pon@[0-9a-f]+$'
	from schema $id: http://devicetree.org/schemas/mfd/qcom,spmi-pmic.yaml
arch/arm64/boot/dts/qcom/sdm845-lg-judyp.dtb: pmic@2 (qcom,pmi8998): 'fuel-gauge@4000' does not match any of the regexes: '(.*)?(wled|leds)@[0-9a-f]+$', '^adc-tm@[0-9a-f]+$', '^adc@[0-9a-f]+$', '^audio-codec@[0-9a-f]+$', '^battery@[0-9a-f]+$', '^charger@[0-9a-f]+$', '^led-controller@[0-9a-f]+$', '^mpps@[0-9a-f]+$', '^nvram@[0-9a-f]+$', '^pbs@[0-9a-f]+$', '^pinctrl-[0-9]+$', '^rtc@[0-9a-f]+$', '^temp-alarm@[0-9a-f]+$', '^typec@[0-9a-f]+$', '^usb-detect@[0-9a-f]+$', '^usb-vbus-regulator@[0-9a-f]+$', '^vibrator@[0-9a-f]+$', 'gpio@[0-9a-f]+$', 'phy@[0-9a-f]+$', 'pon@[0-9a-f]+$'
	from schema $id: http://devicetree.org/schemas/mfd/qcom,spmi-pmic.yaml
arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-discovery.dtb: pmic@0 (qcom,pm660): 'fuel-gauge@4000' does not match any of the regexes: '(.*)?(wled|leds)@[0-9a-f]+$', '^adc-tm@[0-9a-f]+$', '^adc@[0-9a-f]+$', '^audio-codec@[0-9a-f]+$', '^battery@[0-9a-f]+$', '^charger@[0-9a-f]+$', '^led-controller@[0-9a-f]+$', '^mpps@[0-9a-f]+$', '^nvram@[0-9a-f]+$', '^pbs@[0-9a-f]+$', '^pinctrl-[0-9]+$', '^rtc@[0-9a-f]+$', '^temp-alarm@[0-9a-f]+$', '^typec@[0-9a-f]+$', '^usb-detect@[0-9a-f]+$', '^usb-vbus-regulator@[0-9a-f]+$', '^vibrator@[0-9a-f]+$', 'gpio@[0-9a-f]+$', 'phy@[0-9a-f]+$', 'pon@[0-9a-f]+$'
	from schema $id: http://devicetree.org/schemas/mfd/qcom,spmi-pmic.yaml
arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dtb: pmic@0 (qcom,pm660): 'fuel-gauge@4000' does not match any of the regexes: '(.*)?(wled|leds)@[0-9a-f]+$', '^adc-tm@[0-9a-f]+$', '^adc@[0-9a-f]+$', '^audio-codec@[0-9a-f]+$', '^battery@[0-9a-f]+$', '^charger@[0-9a-f]+$', '^led-controller@[0-9a-f]+$', '^mpps@[0-9a-f]+$', '^nvram@[0-9a-f]+$', '^pbs@[0-9a-f]+$', '^pinctrl-[0-9]+$', '^rtc@[0-9a-f]+$', '^temp-alarm@[0-9a-f]+$', '^typec@[0-9a-f]+$', '^usb-detect@[0-9a-f]+$', '^usb-vbus-regulator@[0-9a-f]+$', '^vibrator@[0-9a-f]+$', 'gpio@[0-9a-f]+$', 'phy@[0-9a-f]+$', 'pon@[0-9a-f]+$'
	from schema $id: http://devicetree.org/schemas/mfd/qcom,spmi-pmic.yaml
arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dtb: pmic@2 (qcom,pmi8998): 'fuel-gauge@4000' does not match any of the regexes: '(.*)?(wled|leds)@[0-9a-f]+$', '^adc-tm@[0-9a-f]+$', '^adc@[0-9a-f]+$', '^audio-codec@[0-9a-f]+$', '^battery@[0-9a-f]+$', '^charger@[0-9a-f]+$', '^led-controller@[0-9a-f]+$', '^mpps@[0-9a-f]+$', '^nvram@[0-9a-f]+$', '^pbs@[0-9a-f]+$', '^pinctrl-[0-9]+$', '^rtc@[0-9a-f]+$', '^temp-alarm@[0-9a-f]+$', '^typec@[0-9a-f]+$', '^usb-detect@[0-9a-f]+$', '^usb-vbus-regulator@[0-9a-f]+$', '^vibrator@[0-9a-f]+$', 'gpio@[0-9a-f]+$', 'phy@[0-9a-f]+$', 'pon@[0-9a-f]+$'
	from schema $id: http://devicetree.org/schemas/mfd/qcom,spmi-pmic.yaml
arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akari.dtb: pmic@2 (qcom,pmi8998): 'fuel-gauge@4000' does not match any of the regexes: '(.*)?(wled|leds)@[0-9a-f]+$', '^adc-tm@[0-9a-f]+$', '^adc@[0-9a-f]+$', '^audio-codec@[0-9a-f]+$', '^battery@[0-9a-f]+$', '^charger@[0-9a-f]+$', '^led-controller@[0-9a-f]+$', '^mpps@[0-9a-f]+$', '^nvram@[0-9a-f]+$', '^pbs@[0-9a-f]+$', '^pinctrl-[0-9]+$', '^rtc@[0-9a-f]+$', '^temp-alarm@[0-9a-f]+$', '^typec@[0-9a-f]+$', '^usb-detect@[0-9a-f]+$', '^usb-vbus-regulator@[0-9a-f]+$', '^vibrator@[0-9a-f]+$', 'gpio@[0-9a-f]+$', 'phy@[0-9a-f]+$', 'pon@[0-9a-f]+$'
	from schema $id: http://devicetree.org/schemas/mfd/qcom,spmi-pmic.yaml
arch/arm64/boot/dts/qcom/msm8998-xiaomi-sagit.dtb: pmic@2 (qcom,pmi8998): 'fuel-gauge@4000' does not match any of the regexes: '(.*)?(wled|leds)@[0-9a-f]+$', '^adc-tm@[0-9a-f]+$', '^adc@[0-9a-f]+$', '^audio-codec@[0-9a-f]+$', '^battery@[0-9a-f]+$', '^charger@[0-9a-f]+$', '^led-controller@[0-9a-f]+$', '^mpps@[0-9a-f]+$', '^nvram@[0-9a-f]+$', '^pbs@[0-9a-f]+$', '^pinctrl-[0-9]+$', '^rtc@[0-9a-f]+$', '^temp-alarm@[0-9a-f]+$', '^typec@[0-9a-f]+$', '^usb-detect@[0-9a-f]+$', '^usb-vbus-regulator@[0-9a-f]+$', '^vibrator@[0-9a-f]+$', 'gpio@[0-9a-f]+$', 'phy@[0-9a-f]+$', 'pon@[0-9a-f]+$'
	from schema $id: http://devicetree.org/schemas/mfd/qcom,spmi-pmic.yaml
arch/arm64/boot/dts/qcom/sdm670-google-sargo.dtb: pmic@0 (qcom,pm660): 'fuel-gauge@4000' does not match any of the regexes: '(.*)?(wled|leds)@[0-9a-f]+$', '^adc-tm@[0-9a-f]+$', '^adc@[0-9a-f]+$', '^audio-codec@[0-9a-f]+$', '^battery@[0-9a-f]+$', '^charger@[0-9a-f]+$', '^led-controller@[0-9a-f]+$', '^mpps@[0-9a-f]+$', '^nvram@[0-9a-f]+$', '^pbs@[0-9a-f]+$', '^pinctrl-[0-9]+$', '^rtc@[0-9a-f]+$', '^temp-alarm@[0-9a-f]+$', '^typec@[0-9a-f]+$', '^usb-detect@[0-9a-f]+$', '^usb-vbus-regulator@[0-9a-f]+$', '^vibrator@[0-9a-f]+$', 'gpio@[0-9a-f]+$', 'phy@[0-9a-f]+$', 'pon@[0-9a-f]+$'
	from schema $id: http://devicetree.org/schemas/mfd/qcom,spmi-pmic.yaml
arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dtb: pmic@2 (qcom,pmi8998): 'fuel-gauge@4000' does not match any of the regexes: '(.*)?(wled|leds)@[0-9a-f]+$', '^adc-tm@[0-9a-f]+$', '^adc@[0-9a-f]+$', '^audio-codec@[0-9a-f]+$', '^battery@[0-9a-f]+$', '^charger@[0-9a-f]+$', '^led-controller@[0-9a-f]+$', '^mpps@[0-9a-f]+$', '^nvram@[0-9a-f]+$', '^pbs@[0-9a-f]+$', '^pinctrl-[0-9]+$', '^rtc@[0-9a-f]+$', '^temp-alarm@[0-9a-f]+$', '^typec@[0-9a-f]+$', '^usb-detect@[0-9a-f]+$', '^usb-vbus-regulator@[0-9a-f]+$', '^vibrator@[0-9a-f]+$', 'gpio@[0-9a-f]+$', 'phy@[0-9a-f]+$', 'pon@[0-9a-f]+$'
	from schema $id: http://devicetree.org/schemas/mfd/qcom,spmi-pmic.yaml
arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dtb: pmic@2 (qcom,pmi8998): 'fuel-gauge@4000' does not match any of the regexes: '(.*)?(wled|leds)@[0-9a-f]+$', '^adc-tm@[0-9a-f]+$', '^adc@[0-9a-f]+$', '^audio-codec@[0-9a-f]+$', '^battery@[0-9a-f]+$', '^charger@[0-9a-f]+$', '^led-controller@[0-9a-f]+$', '^mpps@[0-9a-f]+$', '^nvram@[0-9a-f]+$', '^pbs@[0-9a-f]+$', '^pinctrl-[0-9]+$', '^rtc@[0-9a-f]+$', '^temp-alarm@[0-9a-f]+$', '^typec@[0-9a-f]+$', '^usb-detect@[0-9a-f]+$', '^usb-vbus-regulator@[0-9a-f]+$', '^vibrator@[0-9a-f]+$', 'gpio@[0-9a-f]+$', 'phy@[0-9a-f]+$', 'pon@[0-9a-f]+$'
	from schema $id: http://devicetree.org/schemas/mfd/qcom,spmi-pmic.yaml
arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-pioneer.dtb: pmic@0 (qcom,pm660): 'fuel-gauge@4000' does not match any of the regexes: '(.*)?(wled|leds)@[0-9a-f]+$', '^adc-tm@[0-9a-f]+$', '^adc@[0-9a-f]+$', '^audio-codec@[0-9a-f]+$', '^battery@[0-9a-f]+$', '^charger@[0-9a-f]+$', '^led-controller@[0-9a-f]+$', '^mpps@[0-9a-f]+$', '^nvram@[0-9a-f]+$', '^pbs@[0-9a-f]+$', '^pinctrl-[0-9]+$', '^rtc@[0-9a-f]+$', '^temp-alarm@[0-9a-f]+$', '^typec@[0-9a-f]+$', '^usb-detect@[0-9a-f]+$', '^usb-vbus-regulator@[0-9a-f]+$', '^vibrator@[0-9a-f]+$', 'gpio@[0-9a-f]+$', 'phy@[0-9a-f]+$', 'pon@[0-9a-f]+$'
	from schema $id: http://devicetree.org/schemas/mfd/qcom,spmi-pmic.yaml
arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-apollo.dtb: pmic@2 (qcom,pmi8998): 'fuel-gauge@4000' does not match any of the regexes: '(.*)?(wled|leds)@[0-9a-f]+$', '^adc-tm@[0-9a-f]+$', '^adc@[0-9a-f]+$', '^audio-codec@[0-9a-f]+$', '^battery@[0-9a-f]+$', '^charger@[0-9a-f]+$', '^led-controller@[0-9a-f]+$', '^mpps@[0-9a-f]+$', '^nvram@[0-9a-f]+$', '^pbs@[0-9a-f]+$', '^pinctrl-[0-9]+$', '^rtc@[0-9a-f]+$', '^temp-alarm@[0-9a-f]+$', '^typec@[0-9a-f]+$', '^usb-detect@[0-9a-f]+$', '^usb-vbus-regulator@[0-9a-f]+$', '^vibrator@[0-9a-f]+$', 'gpio@[0-9a-f]+$', 'phy@[0-9a-f]+$', 'pon@[0-9a-f]+$'
	from schema $id: http://devicetree.org/schemas/mfd/qcom,spmi-pmic.yaml
arch/arm64/boot/dts/qcom/sdm845-mtp.dtb: pmic@2 (qcom,pmi8998): 'fuel-gauge@4000' does not match any of the regexes: '(.*)?(wled|leds)@[0-9a-f]+$', '^adc-tm@[0-9a-f]+$', '^adc@[0-9a-f]+$', '^audio-codec@[0-9a-f]+$', '^battery@[0-9a-f]+$', '^charger@[0-9a-f]+$', '^led-controller@[0-9a-f]+$', '^mpps@[0-9a-f]+$', '^nvram@[0-9a-f]+$', '^pbs@[0-9a-f]+$', '^pinctrl-[0-9]+$', '^rtc@[0-9a-f]+$', '^temp-alarm@[0-9a-f]+$', '^typec@[0-9a-f]+$', '^usb-detect@[0-9a-f]+$', '^usb-vbus-regulator@[0-9a-f]+$', '^vibrator@[0-9a-f]+$', 'gpio@[0-9a-f]+$', 'phy@[0-9a-f]+$', 'pon@[0-9a-f]+$'
	from schema $id: http://devicetree.org/schemas/mfd/qcom,spmi-pmic.yaml
arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-lilac.dtb: pmic@2 (qcom,pmi8998): 'fuel-gauge@4000' does not match any of the regexes: '(.*)?(wled|leds)@[0-9a-f]+$', '^adc-tm@[0-9a-f]+$', '^adc@[0-9a-f]+$', '^audio-codec@[0-9a-f]+$', '^battery@[0-9a-f]+$', '^charger@[0-9a-f]+$', '^led-controller@[0-9a-f]+$', '^mpps@[0-9a-f]+$', '^nvram@[0-9a-f]+$', '^pbs@[0-9a-f]+$', '^pinctrl-[0-9]+$', '^rtc@[0-9a-f]+$', '^temp-alarm@[0-9a-f]+$', '^typec@[0-9a-f]+$', '^usb-detect@[0-9a-f]+$', '^usb-vbus-regulator@[0-9a-f]+$', '^vibrator@[0-9a-f]+$', 'gpio@[0-9a-f]+$', 'phy@[0-9a-f]+$', 'pon@[0-9a-f]+$'
	from schema $id: http://devicetree.org/schemas/mfd/qcom,spmi-pmic.yaml
arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dtb: pmic@2 (qcom,pmi8998): 'fuel-gauge@4000' does not match any of the regexes: '(.*)?(wled|leds)@[0-9a-f]+$', '^adc-tm@[0-9a-f]+$', '^adc@[0-9a-f]+$', '^audio-codec@[0-9a-f]+$', '^battery@[0-9a-f]+$', '^charger@[0-9a-f]+$', '^led-controller@[0-9a-f]+$', '^mpps@[0-9a-f]+$', '^nvram@[0-9a-f]+$', '^pbs@[0-9a-f]+$', '^pinctrl-[0-9]+$', '^rtc@[0-9a-f]+$', '^temp-alarm@[0-9a-f]+$', '^typec@[0-9a-f]+$', '^usb-detect@[0-9a-f]+$', '^usb-vbus-regulator@[0-9a-f]+$', '^vibrator@[0-9a-f]+$', 'gpio@[0-9a-f]+$', 'phy@[0-9a-f]+$', 'pon@[0-9a-f]+$'
	from schema $id: http://devicetree.org/schemas/mfd/qcom,spmi-pmic.yaml
arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-voyager.dtb: pmic@0 (qcom,pm660): 'fuel-gauge@4000' does not match any of the regexes: '(.*)?(wled|leds)@[0-9a-f]+$', '^adc-tm@[0-9a-f]+$', '^adc@[0-9a-f]+$', '^audio-codec@[0-9a-f]+$', '^battery@[0-9a-f]+$', '^charger@[0-9a-f]+$', '^led-controller@[0-9a-f]+$', '^mpps@[0-9a-f]+$', '^nvram@[0-9a-f]+$', '^pbs@[0-9a-f]+$', '^pinctrl-[0-9]+$', '^rtc@[0-9a-f]+$', '^temp-alarm@[0-9a-f]+$', '^typec@[0-9a-f]+$', '^usb-detect@[0-9a-f]+$', '^usb-vbus-regulator@[0-9a-f]+$', '^vibrator@[0-9a-f]+$', 'gpio@[0-9a-f]+$', 'phy@[0-9a-f]+$', 'pon@[0-9a-f]+$'
	from schema $id: http://devicetree.org/schemas/mfd/qcom,spmi-pmic.yaml
arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akatsuki.dtb: pmic@2 (qcom,pmi8998): 'fuel-gauge@4000' does not match any of the regexes: '(.*)?(wled|leds)@[0-9a-f]+$', '^adc-tm@[0-9a-f]+$', '^adc@[0-9a-f]+$', '^audio-codec@[0-9a-f]+$', '^battery@[0-9a-f]+$', '^charger@[0-9a-f]+$', '^led-controller@[0-9a-f]+$', '^mpps@[0-9a-f]+$', '^nvram@[0-9a-f]+$', '^pbs@[0-9a-f]+$', '^pinctrl-[0-9]+$', '^rtc@[0-9a-f]+$', '^temp-alarm@[0-9a-f]+$', '^typec@[0-9a-f]+$', '^usb-detect@[0-9a-f]+$', '^usb-vbus-regulator@[0-9a-f]+$', '^vibrator@[0-9a-f]+$', 'gpio@[0-9a-f]+$', 'phy@[0-9a-f]+$', 'pon@[0-9a-f]+$'
	from schema $id: http://devicetree.org/schemas/mfd/qcom,spmi-pmic.yaml
arch/arm64/boot/dts/qcom/msm8998-oneplus-dumpling.dtb: pmic@2 (qcom,pmi8998): 'fuel-gauge@4000' does not match any of the regexes: '(.*)?(wled|leds)@[0-9a-f]+$', '^adc-tm@[0-9a-f]+$', '^adc@[0-9a-f]+$', '^audio-codec@[0-9a-f]+$', '^battery@[0-9a-f]+$', '^charger@[0-9a-f]+$', '^led-controller@[0-9a-f]+$', '^mpps@[0-9a-f]+$', '^nvram@[0-9a-f]+$', '^pbs@[0-9a-f]+$', '^pinctrl-[0-9]+$', '^rtc@[0-9a-f]+$', '^temp-alarm@[0-9a-f]+$', '^typec@[0-9a-f]+$', '^usb-detect@[0-9a-f]+$', '^usb-vbus-regulator@[0-9a-f]+$', '^vibrator@[0-9a-f]+$', 'gpio@[0-9a-f]+$', 'phy@[0-9a-f]+$', 'pon@[0-9a-f]+$'
	from schema $id: http://devicetree.org/schemas/mfd/qcom,spmi-pmic.yaml
arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-ebbg.dtb: pmic@2 (qcom,pmi8998): 'fuel-gauge@4000' does not match any of the regexes: '(.*)?(wled|leds)@[0-9a-f]+$', '^adc-tm@[0-9a-f]+$', '^adc@[0-9a-f]+$', '^audio-codec@[0-9a-f]+$', '^battery@[0-9a-f]+$', '^charger@[0-9a-f]+$', '^led-controller@[0-9a-f]+$', '^mpps@[0-9a-f]+$', '^nvram@[0-9a-f]+$', '^pbs@[0-9a-f]+$', '^pinctrl-[0-9]+$', '^rtc@[0-9a-f]+$', '^temp-alarm@[0-9a-f]+$', '^typec@[0-9a-f]+$', '^usb-detect@[0-9a-f]+$', '^usb-vbus-regulator@[0-9a-f]+$', '^vibrator@[0-9a-f]+$', 'gpio@[0-9a-f]+$', 'phy@[0-9a-f]+$', 'pon@[0-9a-f]+$'
	from schema $id: http://devicetree.org/schemas/mfd/qcom,spmi-pmic.yaml
arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dtb: pmic@0 (qcom,pm660): 'fuel-gauge@4000' does not match any of the regexes: '(.*)?(wled|leds)@[0-9a-f]+$', '^adc-tm@[0-9a-f]+$', '^adc@[0-9a-f]+$', '^audio-codec@[0-9a-f]+$', '^battery@[0-9a-f]+$', '^charger@[0-9a-f]+$', '^led-controller@[0-9a-f]+$', '^mpps@[0-9a-f]+$', '^nvram@[0-9a-f]+$', '^pbs@[0-9a-f]+$', '^pinctrl-[0-9]+$', '^rtc@[0-9a-f]+$', '^temp-alarm@[0-9a-f]+$', '^typec@[0-9a-f]+$', '^usb-detect@[0-9a-f]+$', '^usb-vbus-regulator@[0-9a-f]+$', '^vibrator@[0-9a-f]+$', 'gpio@[0-9a-f]+$', 'phy@[0-9a-f]+$', 'pon@[0-9a-f]+$'
	from schema $id: http://devicetree.org/schemas/mfd/qcom,spmi-pmic.yaml
arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-poplar.dtb: pmic@2 (qcom,pmi8998): 'fuel-gauge@4000' does not match any of the regexes: '(.*)?(wled|leds)@[0-9a-f]+$', '^adc-tm@[0-9a-f]+$', '^adc@[0-9a-f]+$', '^audio-codec@[0-9a-f]+$', '^battery@[0-9a-f]+$', '^charger@[0-9a-f]+$', '^led-controller@[0-9a-f]+$', '^mpps@[0-9a-f]+$', '^nvram@[0-9a-f]+$', '^pbs@[0-9a-f]+$', '^pinctrl-[0-9]+$', '^rtc@[0-9a-f]+$', '^temp-alarm@[0-9a-f]+$', '^typec@[0-9a-f]+$', '^usb-detect@[0-9a-f]+$', '^usb-vbus-regulator@[0-9a-f]+$', '^vibrator@[0-9a-f]+$', 'gpio@[0-9a-f]+$', 'phy@[0-9a-f]+$', 'pon@[0-9a-f]+$'
	from schema $id: http://devicetree.org/schemas/mfd/qcom,spmi-pmic.yaml
arch/arm64/boot/dts/qcom/sdm845-db845c.dtb: pmic@2 (qcom,pmi8998): 'fuel-gauge@4000' does not match any of the regexes: '(.*)?(wled|leds)@[0-9a-f]+$', '^adc-tm@[0-9a-f]+$', '^adc@[0-9a-f]+$', '^audio-codec@[0-9a-f]+$', '^battery@[0-9a-f]+$', '^charger@[0-9a-f]+$', '^led-controller@[0-9a-f]+$', '^mpps@[0-9a-f]+$', '^nvram@[0-9a-f]+$', '^pbs@[0-9a-f]+$', '^pinctrl-[0-9]+$', '^rtc@[0-9a-f]+$', '^temp-alarm@[0-9a-f]+$', '^typec@[0-9a-f]+$', '^usb-detect@[0-9a-f]+$', '^usb-vbus-regulator@[0-9a-f]+$', '^vibrator@[0-9a-f]+$', 'gpio@[0-9a-f]+$', 'phy@[0-9a-f]+$', 'pon@[0-9a-f]+$'
	from schema $id: http://devicetree.org/schemas/mfd/qcom,spmi-pmic.yaml
arch/arm64/boot/dts/qcom/msm8998-oneplus-cheeseburger.dtb: pmic@2 (qcom,pmi8998): 'fuel-gauge@4000' does not match any of the regexes: '(.*)?(wled|leds)@[0-9a-f]+$', '^adc-tm@[0-9a-f]+$', '^adc@[0-9a-f]+$', '^audio-codec@[0-9a-f]+$', '^battery@[0-9a-f]+$', '^charger@[0-9a-f]+$', '^led-controller@[0-9a-f]+$', '^mpps@[0-9a-f]+$', '^nvram@[0-9a-f]+$', '^pbs@[0-9a-f]+$', '^pinctrl-[0-9]+$', '^rtc@[0-9a-f]+$', '^temp-alarm@[0-9a-f]+$', '^typec@[0-9a-f]+$', '^usb-detect@[0-9a-f]+$', '^usb-vbus-regulator@[0-9a-f]+$', '^vibrator@[0-9a-f]+$', 'gpio@[0-9a-f]+$', 'phy@[0-9a-f]+$', 'pon@[0-9a-f]+$'
	from schema $id: http://devicetree.org/schemas/mfd/qcom,spmi-pmic.yaml
arch/arm64/boot/dts/qcom/sdm636-sony-xperia-ganges-mermaid.dtb: pmic@0 (qcom,pm660): 'fuel-gauge@4000' does not match any of the regexes: '(.*)?(wled|leds)@[0-9a-f]+$', '^adc-tm@[0-9a-f]+$', '^adc@[0-9a-f]+$', '^audio-codec@[0-9a-f]+$', '^battery@[0-9a-f]+$', '^charger@[0-9a-f]+$', '^led-controller@[0-9a-f]+$', '^mpps@[0-9a-f]+$', '^nvram@[0-9a-f]+$', '^pbs@[0-9a-f]+$', '^pinctrl-[0-9]+$', '^rtc@[0-9a-f]+$', '^temp-alarm@[0-9a-f]+$', '^typec@[0-9a-f]+$', '^usb-detect@[0-9a-f]+$', '^usb-vbus-regulator@[0-9a-f]+$', '^vibrator@[0-9a-f]+$', 'gpio@[0-9a-f]+$', 'phy@[0-9a-f]+$', 'pon@[0-9a-f]+$'
	from schema $id: http://devicetree.org/schemas/mfd/qcom,spmi-pmic.yaml
arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-tianma.dtb: pmic@2 (qcom,pmi8998): 'fuel-gauge@4000' does not match any of the regexes: '(.*)?(wled|leds)@[0-9a-f]+$', '^adc-tm@[0-9a-f]+$', '^adc@[0-9a-f]+$', '^audio-codec@[0-9a-f]+$', '^battery@[0-9a-f]+$', '^charger@[0-9a-f]+$', '^led-controller@[0-9a-f]+$', '^mpps@[0-9a-f]+$', '^nvram@[0-9a-f]+$', '^pbs@[0-9a-f]+$', '^pinctrl-[0-9]+$', '^rtc@[0-9a-f]+$', '^temp-alarm@[0-9a-f]+$', '^typec@[0-9a-f]+$', '^usb-detect@[0-9a-f]+$', '^usb-vbus-regulator@[0-9a-f]+$', '^vibrator@[0-9a-f]+$', 'gpio@[0-9a-f]+$', 'phy@[0-9a-f]+$', 'pon@[0-9a-f]+$'
	from schema $id: http://devicetree.org/schemas/mfd/qcom,spmi-pmic.yaml
arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dtb: pmic@2 (qcom,pmi8998): 'fuel-gauge@4000' does not match any of the regexes: '(.*)?(wled|leds)@[0-9a-f]+$', '^adc-tm@[0-9a-f]+$', '^adc@[0-9a-f]+$', '^audio-codec@[0-9a-f]+$', '^battery@[0-9a-f]+$', '^charger@[0-9a-f]+$', '^led-controller@[0-9a-f]+$', '^mpps@[0-9a-f]+$', '^nvram@[0-9a-f]+$', '^pbs@[0-9a-f]+$', '^pinctrl-[0-9]+$', '^rtc@[0-9a-f]+$', '^temp-alarm@[0-9a-f]+$', '^typec@[0-9a-f]+$', '^usb-detect@[0-9a-f]+$', '^usb-vbus-regulator@[0-9a-f]+$', '^vibrator@[0-9a-f]+$', 'gpio@[0-9a-f]+$', 'phy@[0-9a-f]+$', 'pon@[0-9a-f]+$'
	from schema $id: http://devicetree.org/schemas/mfd/qcom,spmi-pmic.yaml






