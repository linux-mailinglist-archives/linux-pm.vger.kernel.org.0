Return-Path: <linux-pm+bounces-14199-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D247F9788DD
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2024 21:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78E4728388A
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2024 19:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9906914658B;
	Fri, 13 Sep 2024 19:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NLxfHBVw"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583FBBA2D;
	Fri, 13 Sep 2024 19:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726255402; cv=none; b=tz8IhAzza5uArMM6tvnvNlqTeWsDsQHBXqNqDNNY6kN+ELh4YrqL0Ojgv0zfZ38V+L2c6p4fgps/FRMqh3uarA0ikPPGNhM/R8ypqQl1DqecOzaAYCtiYS4SYr3fiOquIwcCE20cgm2iOeDwk+B3IGmNMmA1Y/x28hX7AZWJ+bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726255402; c=relaxed/simple;
	bh=ZICcCWxUc9OltTaJt6EfQVoBjXlgGU08ALEh3pd/AMw=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=kkeYQpADNB7SurOzBa0w55GnXIP23Pa7G9j4+NZUlBaqcKSD/Uw3tNzzUUnM+L9U0zmdW0woGSKc+HQJ8CQCB5ff3ohNQEheIHehL+WYaRtNpSRl5mDOfJ8DoBKT9GHsvGf21jHuJDdGRmFtj7cZxpp2sAgEFc7gXDaMou/SsoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NLxfHBVw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC2FDC4CEC0;
	Fri, 13 Sep 2024 19:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726255402;
	bh=ZICcCWxUc9OltTaJt6EfQVoBjXlgGU08ALEh3pd/AMw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=NLxfHBVwqLPtBVPI3ZHk5u1tM+Cqi7rEWQD9IJMGUUKxgRN3Frt2LDytcyAKyKLsd
	 R9D40663vn5UIuKSKfwmNFZFMf5qHp3Ya0+qr/Ae7VEHPNUkxMHJN4sMnQgDKve74I
	 hqrfMfBzsibsmNof6FyDUggt1U6c4kEB/lyTkHTgTeCR/eR0Zfa1P7PBpHbmwqRnY6
	 DgSLHuJ1pz/FoDo66JnYfjKj7Lxz/ca105YOe+hrPqBh3Fp1jsi7It4DjEEEUHfr9D
	 WcrlMoF3f6lZHMcN+7JjJlxjI22E/DcDelEEAs5fMNoOxM1OCExE5bUrlL7TjdRzHN
	 v2v34oi2vRmDA==
Date: Fri, 13 Sep 2024 14:23:20 -0500
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
Cc: Bear Wang <bear.wang@mediatek.com>, Conor Dooley <conor+dt@kernel.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Chen Zhong <chen.zhong@mediatek.com>, linux-leds@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>, 
 Lee Jones <lee@kernel.org>, linux-mediatek@lists.infradead.org, 
 Macpaul Lin <macpaul@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Chris-qj chen <chris-qj.chen@mediatek.com>, linux-input@vger.kernel.org, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-rtc@vger.kernel.org, 
 MediaTek Chromebook Upstream <Project_Global_Chrome_Upstream_Group@mediatek.com>, 
 Sean Wang <sean.wang@mediatek.com>, Pavel Machek <pavel@ucw.cz>, 
 linux-pm@vger.kernel.org, Chen-Yu Tsai <wenst@chromium.org>, 
 Sebastian Reichel <sre@kernel.org>, 
 Alexandre Mergnat <amergnat@baylibre.com>, devicetree@vger.kernel.org, 
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sound@vger.kernel.org, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Pablo Sun <pablo.sun@mediatek.com>
In-Reply-To: <20240913175926.7443-1-macpaul.lin@mediatek.com>
References: <20240913175926.7443-1-macpaul.lin@mediatek.com>
Message-Id: <172625540069.478205.2893721075637493498.robh@kernel.org>
Subject: Re: [PATCH v3 2/3] dt-bindings: mfd: mediatek: mt6397: Convert to
 DT schema format


On Sat, 14 Sep 2024 01:59:26 +0800, Macpaul Lin wrote:
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
>  .../bindings/mfd/mediatek,mt6397.yaml         | 1078 +++++++++++++++++
>  .../devicetree/bindings/mfd/mt6397.txt        |  110 --
>  .../bindings/power/reset/mt6323-poweroff.txt  |   20 -
>  .../devicetree/bindings/rtc/rtc-mt6397.txt    |   31 -
>  .../devicetree/bindings/sound/mt6358.txt      |   26 -
>  MAINTAINERS                                   |    8 +-
>  8 files changed, 1085 insertions(+), 253 deletions(-)
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

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Warning: Duplicate compatible "mediatek,mt6357" found in schemas matching "$id":
	http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#
	http://devicetree.org/schemas/mfd/mediatek,mt6357.yaml#
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

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240913175926.7443-1-macpaul.lin@mediatek.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


