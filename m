Return-Path: <linux-pm+bounces-14286-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D834E979166
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 16:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC8991C214E0
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 14:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4991CFEC8;
	Sat, 14 Sep 2024 14:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IUoKZe8n"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13301DFFB;
	Sat, 14 Sep 2024 14:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726324124; cv=none; b=NGcdGnJbxEa9gwjBHLuAV1OFfBI98hkC1SdlDCTV2RsYqAsyLiIhI/6fZt7Y5r7KAAZfXvBsxnob7qaMS3SWLBIzhYefLCSfqM2SKXi5LqHFjFnGSS16prYEzm6wJPHHUkigSGeLTHoidkZcw1OlHpV7dTtEYNvbMO3EQUUFRBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726324124; c=relaxed/simple;
	bh=4xjjN/FzunBQlvB0oOPBJkRnVPxAo2hgjzmM4Jq3t/I=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=EpHevqitWTbU3k2AQudnM5GYSM6wDa2CSQ3E6MP0deo3Pkhsg6rhVkz719rSx4jKH+GvqCVf+qcIJyl2OquEo4Z3LzxbElm5TDjgbejbNcyXKsLB8QUQbLtBEeSiDqaPds/Dl1jgG6qSZ8eqMNzkJbMGioEHTcUhadcTQgXJ0vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IUoKZe8n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 213C8C4CEC0;
	Sat, 14 Sep 2024 14:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726324123;
	bh=4xjjN/FzunBQlvB0oOPBJkRnVPxAo2hgjzmM4Jq3t/I=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=IUoKZe8noAfLS2cTl3E9YSYLt6N7ODam51q9U0Dp1qOmJNthDZrPS6q7UXn3ol2Pg
	 RV0YwvB2w8eNg9bliXTz/NXfBBTd44MOuGj93zCspDYDmWWp1KI3fCWAzPtH3AX4Ge
	 ixgu+J+HlFoV5kyWmmYvV8HNoITJSfBc9bU4VQ7Quhy/YuG3haZaLBtGvlVKz+Hgcj
	 V0vp/l9OOuw+Xfn4QMIAPgd7vpUNipTvzlzm/SQ+94xyNBCiXBYYdbL36SX1yEM8IZ
	 scKoI4/GsQmluEPWmuteIb4cfpWIjtesiSqFErjWeD3Dx28PNwXHv0LCBJC3KIq0Jx
	 CkmClphrzqjOg==
Date: Sat, 14 Sep 2024 09:28:42 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Macpaul Lin <macpaul.lin@mediatek.com>
Cc: Pablo Sun <pablo.sun@mediatek.com>, Macpaul Lin <macpaul@gmail.com>, 
 linux-leds@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
 linux-mediatek@lists.infradead.org, Chen-Yu Tsai <wenst@chromium.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Pavel Machek <pavel@ucw.cz>, Bear Wang <bear.wang@mediatek.com>, 
 Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org, 
 Sebastian Reichel <sre@kernel.org>, linux-input@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org, 
 linux-sound@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Chen Zhong <chen.zhong@mediatek.com>, 
 Chris-qj chen <chris-qj.chen@mediatek.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Sen Chu <sen.chu@mediatek.com>, 
 Lee Jones <lee@kernel.org>, Alexandre Mergnat <amergnat@baylibre.com>, 
 linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, 
 MediaTek Chromebook Upstream <Project_Global_Chrome_Upstream_Group@mediatek.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
In-Reply-To: <20240914132811.9637-1-macpaul.lin@mediatek.com>
References: <20240914132811.9637-1-macpaul.lin@mediatek.com>
Message-Id: <172632412216.3158459.14043151462487699502.robh@kernel.org>
Subject: Re: [PATCH v4 2/3] dt-bindings: mfd: mediatek: mt6397: Convert to
 DT schema format


On Sat, 14 Sep 2024 21:28:11 +0800, Macpaul Lin wrote:
> Convert the mfd: mediatek: mt6397 binding to DT schema format.
> 
> MT6323, MT6358, and MT6397 are PMIC devices with multiple function
> subdevices. They share a common PMIC design but have variations in
> subdevice combinations.
> 
> Key updates in this conversion:
> 
> 1. RTC:
>    - Convert rtc-mt6397.txt and merge into parent MT6397 PMIC DT schema.
> 
> 2. Regulators:
>    - Align to generic name "regulators".
>    - Update references from .txt to .yaml for mt6323, mt6358, and mt6397
>      regulators.
>    - Simplify regulator name labels in device tree examples.
> 
> 3. Audio Codec:
>    - Convert sound/mt6358.txt and merge into parent MT6397 PMIC DT schema.
>    - Align to generic name "audio-codec" for codec and sound subdevices.
>    - Add "mediatek,dmic-mode" and "Avdd-supply" properties.
> 
> 4. Clocks:
>    - Align to generic name "clocks" for clockbuffer subdevices.
> 
> 5. LEDs:
>    - Convert leds-mt6323.txt and merge into parent MT6397 PMIC DT schema.
>    - Update LED binding.
> 
> 6. Keys:
>    - Add detailed descriptions for power and home keys.
>    - Add compatible: mediatek,mt6358-keys.
> 
> 7. Power Controller:
>    - Convert mt6323-poweroff.txt and merge into parent MT6397 PMIC DT
>      schema.
>    - Add #power-domain-cells property to fix dt-binding check error.
>    - Clarify "BBPU" as "Baseband power up".
> 
> 8. Pinctrl:
>    - Align to generic name "pinctrl" instead of "pin-controller".
> 
> 9. Compatible:
>    - Drop "mediatek,mt6357" since there is a separated DT Schema
>      for PMIC MT6357.
> 
> Additional updates:
> - MAINTAINERS: Add co-maintainers and reference to
>   mfd/mediatek,mt6397.yaml for LED and power-controller drivers.
> - input/mediatek,pmic-keys.yaml: Update reference to
>   mfd/mediatek,mt6397.yaml.
> 
> Signed-off-by: Sen Chu <sen.chu@mediatek.com>
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---
>  .../bindings/input/mediatek,pmic-keys.yaml    |    2 +-
>  .../devicetree/bindings/leds/leds-mt6323.txt  |   63 -
>  .../bindings/mfd/mediatek,mt6397.yaml         | 1077 +++++++++++++++++
>  .../devicetree/bindings/mfd/mt6397.txt        |  110 --
>  .../bindings/power/reset/mt6323-poweroff.txt  |   20 -
>  .../devicetree/bindings/rtc/rtc-mt6397.txt    |   31 -
>  .../devicetree/bindings/sound/mt6358.txt      |   26 -
>  MAINTAINERS                                   |    8 +-
>  8 files changed, 1084 insertions(+), 253 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/leds/leds-mt6323.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mfd/mt6397.txt
>  delete mode 100644 Documentation/devicetree/bindings/power/reset/mt6323-poweroff.txt
>  delete mode 100644 Documentation/devicetree/bindings/rtc/rtc-mt6397.txt
>  delete mode 100644 Documentation/devicetree/bindings/sound/mt6358.txt
> 
> Changes for v1:
>  - This patch depends on conversion of mediatek,mt6397-regulator.yaml
>    [1] https://lore.kernel.org/lkml/20240807091738.18387-1-macpaul.lin@mediatek.com/T/
> 
> Changes for v2:
>  - This patch has been made base on linux-next/master git repo.
>  - Keep the parent and child relationship with mediatek,pwrap in description.
>    [2] https://lore.kernel.org/all/20240826-slurp-earphone-0d5173923ae8@spud/
>  - Keep the $ref for regulators since dt_binding_check didn't report any issue
>    based on linux-next/master repo.
>  - Fix description of mt6397/mt6323 devices, use "power management chip"
>    instead of "multifunction device"
>  - Drop unnecessary comments or description according to the review.
>  - Convert sub-modules to DT Schema:
>   - RTC, LEDs, power-controllers, regulators
>  - Drop duplicate sub node name and description for sub-modules
>   - RTC, Keys
>  - examples:
>   - drop parent pwrap node
>   - Add examples from mediatek,mt6323-regulator.yaml
>   - Add examples from mediatek,mt6358-regulator.yaml
>   - Add examples from mediatek,mt6397-regulator.yaml
>   - Complete the examples as could as possible.
> 
> Changes for v3:
>  - Rebased on linux-next/master git repo near next-20240906.
>  - Revise commit message.
>  - Regulators:
>   - Use "additionalProperties: true" and add "contains" for matching
>     $ref DT bindings.
>   - Simplify regulator name labels in device tree examples.
>  - LEDs:
>   - Use LED bindings.
>  - Squash following patches in v2 for removing old text format DT bindings
>    into this patch, includes:
>   - leds-mt6323.txt, mt6323-poweroff.txt, rtc-mt6397.txt, sound/mt6358.txt.
>  - Fix file format of DT schemas, add blank between properties.
>  - Fix 'make checkrefdoc' errors, update reference in mediatek,pmic-keys.yaml.
> 
> Changes for v4:
>  - Remove "mediatek,mt6357" from PMIC's compatible string since there is a
>    seperated DT schema for PMIC mt6357.
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/mediatek,mt6397.example.dtb: pmic: regulators: False schema does not allow {'compatible': ['mediatek,mt6323-regulator'], 'buck_vproc': {'regulator-name': ['vproc'], 'regulator-min-microvolt': [[700000]], 'regulator-max-microvolt': [[1350000]], 'regulator-ramp-delay': 12500, 'regulator-always-on': True, 'regulator-boot-on': True}, 'buck_vsys': {'regulator-name': ['vsys'], 'regulator-min-microvolt': [[1400000]], 'regulator-max-microvolt': [[2987500]], 'regulator-ramp-delay': 25000, 'regulator-always-on': True, 'regulator-boot-on': True}, 'buck_vpa': {'regulator-name': ['vpa'], 'regulator-min-microvolt': [[500000]], 'regulator-max-microvolt': [[3650000]]}, 'ldo_vtcxo': {'regulator-name': ['vtcxo'], 'regulator-min-microvolt': [[2800000]], 'regulator-max-microvolt': [[2800000]], 'regulator-enable-ramp-delay': 90, 'regulator-always-on': True, 'regulator-boot-on': True}, 'ldo_vcn28': {'regulator-name': ['vcn28'], 'r
 egulator-min-microvolt': [[2800000]], 'regulator-max-microvolt': [[2800000]], 'regulator-enable-ramp-delay': 185}, 'ldo_vcn33_bt': {'regulator-name': ['vcn33_bt'], 'regulator-min-microvolt': [[3300000]], 'regulator-max-microvolt': [[3600000]], 'regulator-enable-ramp-delay': 185}, 'ldo_vcn33_wifi': {'regulator-name': ['vcn33_wifi'], 'regulator-min-microvolt': [[3300000]], 'regulator-max-microvolt': [[3600000]], 'regulator-enable-ramp-delay': 185}, 'ldo_va': {'regulator-name': ['va'], 'regulator-min-microvolt': [[2800000]], 'regulator-max-microvolt': [[2800000]], 'regulator-enable-ramp-delay': 216, 'regulator-always-on': True, 'regulator-boot-on': True}, 'ldo_vcama': {'regulator-name': ['vcama'], 'regulator-min-microvolt': [[1500000]], 'regulator-max-microvolt': [[2800000]], 'regulator-enable-ramp-delay': 216}, 'ldo_vio28': {'regulator-name': ['vio28'], 'regulator-min-microvolt': [[2800000]], 'regulator-max-microvolt': [[2800000]], 'regulator-enable-ramp-delay': 216, 'regulator-always
 -on': True, 'regulator-boot-on': True}, 'ldo_vusb': {'regulator-name': ['vusb'], 'regulator-min-microvolt': [[3300000]], 'regulator-max-microvolt': [[3300000]], 'regulator-enable-ramp-delay': 216, 'regulator-boot-on': True}, 'ldo_vmc': {'regulator-name': ['vmc'], 'regulator-min-microvolt': [[1800000]], 'regulator-max-microvolt': [[3300000]], 'regulator-enable-ramp-delay': 36, 'regulator-boot-on': True}, 'ldo_vmch': {'regulator-name': ['vmch'], 'regulator-min-microvolt': [[3000000]], 'regulator-max-microvolt': [[3300000]], 'regulator-enable-ramp-delay': 36, 'regulator-boot-on': True}, 'ldo_vemc3v3': {'regulator-name': ['vemc3v3'], 'regulator-min-microvolt': [[3000000]], 'regulator-max-microvolt': [[3300000]], 'regulator-enable-ramp-delay': 36, 'regulator-boot-on': True}, 'ldo_vgp1': {'regulator-name': ['vgp1'], 'regulator-min-microvolt': [[1200000]], 'regulator-max-microvolt': [[3300000]], 'regulator-enable-ramp-delay': 216}, 'ldo_vgp2': {'regulator-name': ['vgp2'], 'regulator-min-mi
 crovolt': [[1200000]], 'regulator-max-microvolt': [[3000000]], 'regulator-enable-ramp-delay': 216}, 'ldo_vgp3': {'regulator-name': ['vgp3'], 'regulator-min-microvolt': [[1200000]], 'regulator-max-microvolt': [[1800000]], 'regulator-enable-ramp-delay': 216}, 'ldo_vcn18': {'regulator-name': ['vcn18'], 'regulator-min-microvolt': [[1800000]], 'regulator-max-microvolt': [[1800000]], 'regulator-enable-ramp-delay': 216}, 'ldo_vsim1': {'regulator-name': ['vsim1'], 'regulator-min-microvolt': [[1800000]], 'regulator-max-microvolt': [[3000000]], 'regulator-enable-ramp-delay': 216}, 'ldo_vsim2': {'regulator-name': ['vsim2'], 'regulator-min-microvolt': [[1800000]], 'regulator-max-microvolt': [[3000000]], 'regulator-enable-ramp-delay': 216}, 'ldo_vrtc': {'regulator-name': ['vrtc'], 'regulator-min-microvolt': [[2800000]], 'regulator-max-microvolt': [[2800000]], 'regulator-always-on': True, 'regulator-boot-on': True}, 'ldo_vcamaf': {'regulator-name': ['vcamaf'], 'regulator-min-microvolt': [[1200000
 ]], 'regulator-max-microvolt': [[3300000]], 'regulator-enable-ramp-delay': 216}, 'ldo_vibr': {'regulator-name': ['vibr'], 'regulator-min-microvolt': [[1200000]], 'regulator-max-microvolt': [[3300000]], 'regulator-enable-ramp-delay': 36}, 'ldo_vrf18': {'regulator-name': ['vrf18'], 'regulator-min-microvolt': [[1825000]], 'regulator-max-microvolt': [[1825000]], 'regulator-enable-ramp-delay': 187}, 'ldo_vm': {'regulator-name': ['vm'], 'regulator-min-microvolt': [[1200000]], 'regulator-max-microvolt': [[1800000]], 'regulator-enable-ramp-delay': 216, 'regulator-always-on': True, 'regulator-boot-on': True}, 'ldo_vio18': {'regulator-name': ['vio18'], 'regulator-min-microvolt': [[1800000]], 'regulator-max-microvolt': [[1800000]], 'regulator-enable-ramp-delay': 216, 'regulator-always-on': True, 'regulator-boot-on': True}, 'ldo_vcamd': {'regulator-name': ['vcamd'], 'regulator-min-microvolt': [[1200000]], 'regulator-max-microvolt': [[1800000]], 'regulator-enable-ramp-delay': 216}, 'ldo_vcamio':
  {'regulator-name': ['vcamio'], 'regulator-min-microvolt': [[1800000]], 'regulator-max-microvolt': [[1800000]], 'regulator-enable-ramp-delay': 216}}
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/mediatek,mt6397.example.dtb: pmic: regulators: False schema does not allow {'compatible': ['mediatek,mt6397-regulator'], 'buck_vpca15': {'regulator-name': ['vpca15'], 'regulator-min-microvolt': [[850000]], 'regulator-max-microvolt': [[1350000]], 'regulator-ramp-delay': 12500, 'regulator-enable-ramp-delay': 200}, 'buck_vpca7': {'regulator-name': ['vpca7'], 'regulator-min-microvolt': [[850000]], 'regulator-max-microvolt': [[1350000]], 'regulator-ramp-delay': 12500, 'regulator-enable-ramp-delay': 115}, 'buck_vsramca15': {'regulator-name': ['vsramca15'], 'regulator-min-microvolt': [[850000]], 'regulator-max-microvolt': [[1350000]], 'regulator-ramp-delay': 12500, 'regulator-enable-ramp-delay': 115}, 'buck_vsramca7': {'regulator-name': ['vsramca7'], 'regulator-min-microvolt': [[850000]], 'regulator-max-microvolt': [[1350000]], 'regulator-ramp-delay': 12500, 'regulator-enable-ramp-delay': 115}, 'buck_vcore': {'regul
 ator-name': ['vcore'], 'regulator-min-microvolt': [[850000]], 'regulator-max-microvolt': [[1350000]], 'regulator-ramp-delay': 12500, 'regulator-enable-ramp-delay': 115}, 'buck_vgpu': {'regulator-name': ['vgpu'], 'regulator-min-microvolt': [[700000]], 'regulator-max-microvolt': [[1350000]], 'regulator-ramp-delay': 12500, 'regulator-enable-ramp-delay': 115}, 'buck_vdrm': {'regulator-name': ['vdrm'], 'regulator-min-microvolt': [[800000]], 'regulator-max-microvolt': [[1400000]], 'regulator-ramp-delay': 12500, 'regulator-enable-ramp-delay': 500}, 'buck_vio18': {'regulator-name': ['vio18'], 'regulator-min-microvolt': [[1500000]], 'regulator-max-microvolt': [[2120000]], 'regulator-ramp-delay': 12500, 'regulator-enable-ramp-delay': 500}, 'ldo_vtcxo': {'regulator-name': ['vtcxo'], 'regulator-min-microvolt': [[2800000]], 'regulator-max-microvolt': [[2800000]], 'regulator-enable-ramp-delay': 90}, 'ldo_va28': {'regulator-name': ['va28'], 'regulator-enable-ramp-delay': 218}, 'ldo_vcama': {'regul
 ator-name': ['vcama'], 'regulator-min-microvolt': [[1500000]], 'regulator-max-microvolt': [[2800000]], 'regulator-enable-ramp-delay': 218}, 'ldo_vio28': {'regulator-name': ['vio28'], 'regulator-enable-ramp-delay': 240}, 'ldo_vusb': {'regulator-name': ['vusb'], 'regulator-enable-ramp-delay': 218}, 'ldo_vmc': {'regulator-name': ['vmc'], 'regulator-min-microvolt': [[1800000]], 'regulator-max-microvolt': [[3300000]], 'regulator-enable-ramp-delay': 218}, 'ldo_vmch': {'regulator-name': ['vmch'], 'regulator-min-microvolt': [[3000000]], 'regulator-max-microvolt': [[3300000]], 'regulator-enable-ramp-delay': 218}, 'ldo_vemc3v3': {'regulator-name': ['vemc_3v3'], 'regulator-min-microvolt': [[3000000]], 'regulator-max-microvolt': [[3300000]], 'regulator-enable-ramp-delay': 218}, 'ldo_vgp1': {'regulator-name': ['vcamd'], 'regulator-min-microvolt': [[1220000]], 'regulator-max-microvolt': [[3300000]], 'regulator-enable-ramp-delay': 240}, 'ldo_vgp2': {'regulator-name': ['vcamio'], 'regulator-min-mic
 rovolt': [[1000000]], 'regulator-max-microvolt': [[3300000]], 'regulator-enable-ramp-delay': 218}, 'ldo_vgp3': {'regulator-name': ['vcamaf'], 'regulator-min-microvolt': [[1200000]], 'regulator-max-microvolt': [[3300000]], 'regulator-enable-ramp-delay': 218}, 'ldo_vgp4': {'regulator-name': ['vgp4'], 'regulator-min-microvolt': [[1200000]], 'regulator-max-microvolt': [[3300000]], 'regulator-enable-ramp-delay': 218}, 'ldo_vgp5': {'regulator-name': ['vgp5'], 'regulator-min-microvolt': [[1200000]], 'regulator-max-microvolt': [[3000000]], 'regulator-enable-ramp-delay': 218}, 'ldo_vgp6': {'regulator-name': ['vgp6'], 'regulator-min-microvolt': [[1200000]], 'regulator-max-microvolt': [[3300000]], 'regulator-enable-ramp-delay': 218}, 'ldo_vibr': {'regulator-name': ['vibr'], 'regulator-min-microvolt': [[1200000]], 'regulator-max-microvolt': [[3300000]], 'regulator-enable-ramp-delay': 218}}
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240914132811.9637-1-macpaul.lin@mediatek.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


