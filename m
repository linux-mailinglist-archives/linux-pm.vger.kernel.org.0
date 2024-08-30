Return-Path: <linux-pm+bounces-13237-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3269661BD
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2024 14:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 972531F23C56
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2024 12:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FE31AD417;
	Fri, 30 Aug 2024 12:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IcNF3l3W"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C531ACDFD;
	Fri, 30 Aug 2024 12:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725020968; cv=none; b=B/oW/kB/MTUX7W+Q/BaFlDySneNrlC+Xwo+CaDpWtFZhPQVzGC5satER6tNRpZSeCaFqHF89Fn63a1x8pb1NeoECuV3D7fghALk9rFtj+nMb3yM0iuZnSq3ghZw2MDhsHB2gNitstcDwKeGTP/fcE/WBaGo1le70jAwZzxK+/6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725020968; c=relaxed/simple;
	bh=Mk2LUXTuEiIRSthKQD//mtV7WNBhG5yEj/aMTBvTTr8=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=KAavWZkBJpGLhxL+e1gKPp5aIGgyUxV9ZVpFvFkrfmc/xN8JypILT4ggKxFCPJXCiPOkaTOhwa2Wo09fPJcOBtNUE6SUUIzLSRtFXGX5XgiQilT3YlIx1AsHUF8p0QWaFG6TPbGKcdGkdq65jMFVeMPz5BR1+3r8T78xQpLUpsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IcNF3l3W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77A7CC4CEC6;
	Fri, 30 Aug 2024 12:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725020967;
	bh=Mk2LUXTuEiIRSthKQD//mtV7WNBhG5yEj/aMTBvTTr8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=IcNF3l3W0QnpKoqb3ySavCF49EncHG5TSDDRyIwCY+ZLYpZi4Z4BlwlmlyLAozqCl
	 U4xVapcn7+QUrOM5RlFfq7+7vqulfBdNTuYEPSP0E9xa1YclOKvqaIfp45pKWYOk3X
	 3lkuPlQX89SbUCAssvFBXGTYVR/9lTyR4asjxYXSCChgAx8cvXnHXTvdo68qheJIJZ
	 0z7ySPmVBSu+xmM1sfo63wJucldECPO8hWkzJ9LcGLhVtBPIs4k41DIAawQ3qM0d4d
	 U8DiP+Rwr2SAs95Puakw1EE1jyp1957DLHagDZsu5kpG7HyZ0GI2dOVORHQfYy+zYi
	 fCFBNuPyewiNw==
Date: Fri, 30 Aug 2024 07:29:26 -0500
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
Cc: Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org, 
 linux-sound@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, Chen-Yu Tsai <wenst@chromium.org>, 
 Sebastian Reichel <sre@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Pablo Sun <pablo.sun@mediatek.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-rtc@vger.kernel.org, Bear Wang <bear.wang@mediatek.com>, 
 Sean Wang <sean.wang@mediatek.com>, linux-mediatek@lists.infradead.org, 
 Sen Chu <sen.chu@mediatek.com>, Lee Jones <lee@kernel.org>, 
 MediaTek Chromebook Upstream <Project_Global_Chrome_Upstream_Group@mediatek.com>, 
 linux-leds@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>, 
 Pavel Machek <pavel@ucw.cz>, Flora Fu <flora.fu@mediatek.com>, 
 Mark Brown <broonie@kernel.org>, Chris-qj chen <chris-qj.chen@mediatek.com>, 
 Macpaul Lin <macpaul@gmail.com>, Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20240830110732.30080-2-macpaul.lin@mediatek.com>
References: <20240830110732.30080-1-macpaul.lin@mediatek.com>
 <20240830110732.30080-2-macpaul.lin@mediatek.com>
Message-Id: <172502096435.3785893.9921485411926968976.robh@kernel.org>
Subject: Re: [PATCH v2 2/7] dt-bindings: mfd: mediatek: mt6397: Convert to
 DT schema format


On Fri, 30 Aug 2024 19:07:27 +0800, Macpaul Lin wrote:
> Convert the mfd: mediatek: mt6397 binding to DT schema format.
> 
> MT6323/MT6358/MT6397 are PMIC devices with multiple function of
> subdevices. They have some variant of the combinations of subdevices
> but share a common PMIC design.
> 
> New updates in this conversion:
>  - RTC:
>   - Convert rtc-mt6397.txt and add it into parent's mt6397 PMIC DT schema.
>  - regulators:
>   - Align generic names "regulators" instead of origin names.
>   - mt6323-regulator: Replace "txt" reference with mt6323-regulaotr.yaml
>   - mt6358-regulator: Replace "txt" reference with mt6358-regulator.yaml
>   - mt6397-regulator: Replace "txt" reference with mt6397-reuglator.yaml
>  - audio-codec:
>   - Align generic name "audio-codec" for codec and sound subdevices.
>   - Add "mediatek,dmic-mode" and "Avdd-supply".
>  - clocks:
>   - Align generic name "clocks" for clockbuffer subdevices.
>  - leds:
>   - Convert leds-mt6323.txt and add it into parent's mt6397 PMIC DT schema.
>  - keys:
>   - Add more specific descriptions for power and home keys.
>   - Add compatible: mediatek,mt6358-keys
>  - power-controller:
>   - Add property #power-domain-cells for fixing dt-binding check error.
>   - Add "Baseband power up" as the explaination of abbrevitation "BBPU".
>  - pinctrl:
>   - Align generic name "pinctrl" instead of "pin-controller".
> 
> Signed-off-by: Sen Chu <sen.chu@mediatek.com>
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---
>  .../bindings/mfd/mediatek,mt6397.yaml         | 1026 +++++++++++++++++
>  .../devicetree/bindings/mfd/mt6397.txt        |  110 --
>  2 files changed, 1026 insertions(+), 110 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mfd/mt6397.txt
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

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/mediatek,mt6397.example.dtb: pmic: regulators: 'oneOf' conditional failed, one must be fixed:
	'buck_vcore', 'buck_vdrm', 'buck_vgpu', 'buck_vio18', 'buck_vpca15', 'buck_vpca7', 'buck_vsramca15', 'buck_vsramca7', 'ldo_va28', 'ldo_vgp4', 'ldo_vgp5', 'ldo_vgp6' do not match any of the regexes: '^(buck_)?v(pa|proc|sys)$', '^(ldo_)?v((io|rf)18)$', '^(ldo_)?v(a|rtc|tcxo|(cn|io)28)$', '^(ldo_)?v(cama|camaf|camd|emc3v3|gp[123]|ibr|m|mc|mch|sim[12])$', '^(ldo_)?v(camio|cn18)$', '^(ldo_)?v(cn33_(bt|wifi))$', '^(ldo_)?vusb$', 'pinctrl-[0-9]+'
	'buck_vdrm', 'buck_vio18', 'buck_vpca15', 'buck_vpca7', 'buck_vsramca15', 'buck_vsramca7', 'ldo_va28', 'ldo_vcama', 'ldo_vemc3v3', 'ldo_vgp1', 'ldo_vgp2', 'ldo_vgp3', 'ldo_vgp4', 'ldo_vgp5', 'ldo_vgp6', 'ldo_vtcxo' do not match any of the regexes: '^(buck_)?v(core|dram1|gpu|modem|pa|proc1[12]|s[12])$', '^(ldo_)?v((aux|cn|io|rf)18|camio)$', '^(ldo_)?v(aud|bif|cn|fe|io)28$', '^(ldo_)?v(a|rf)12$', '^(ldo_)?v(cama[12]|camd|cn33|dram2|efuse|emc|ibr|ldo28|m18|mc|mch|mddr|sim[12])$', '^(ldo_)?vsram[_-](core|gpu|others|proc1[12])$', '^(ldo_)?vusb$', '^(ldo_)?vxo22$', 'pinctrl-[0-9]+'
	False schema does not allow {'compatible': ['mediatek,mt6397-regulator'], 'buck_vpca15': {'regulator-name': ['vpca15'], 'regulator-min-microvolt': [[850000]], 'regulator-max-microvolt': [[1350000]], 'regulator-ramp-delay': 12500, 'regulator-enable-ramp-delay': 200}, 'buck_vpca7': {'regulator-name': ['vpca7'], 'regulator-min-microvolt': [[850000]], 'regulator-max-microvolt': [[1350000]], 'regulator-ramp-delay': 12500, 'regulator-enable-ramp-delay': 115}, 'buck_vsramca15': {'regulator-name': ['vsramca15'], 'regulator-min-microvolt': [[850000]], 'regulator-max-microvolt': [[1350000]], 'regulator-ramp-delay': 12500, 'regulator-enable-ramp-delay': 115}, 'buck_vsramca7': {'regulator-name': ['vsramca7'], 'regulator-min-microvolt': [[850000]], 'regulator-max-microvolt': [[1350000]], 'regulator-ramp-delay': 12500, 'regulator-enable-ramp-delay': 115}, 'buck_vcore': {'regulator-name': ['vcore'], 'regulator-min-microvolt': [[850000]], 'regulator-max-microvolt': [[1350000]], 'regulator-ramp-dela
 y': 12500, 'regulator-enable-ramp-delay': 115}, 'buck_vgpu': {'regulator-name': ['vgpu'], 'regulator-min-microvolt': [[700000]], 'regulator-max-microvolt': [[1350000]], 'regulator-ramp-delay': 12500, 'regulator-enable-ramp-delay': 115}, 'buck_vdrm': {'regulator-name': ['vdrm'], 'regulator-min-microvolt': [[800000]], 'regulator-max-microvolt': [[1400000]], 'regulator-ramp-delay': 12500, 'regulator-enable-ramp-delay': 500}, 'buck_vio18': {'regulator-name': ['vio18'], 'regulator-min-microvolt': [[1500000]], 'regulator-max-microvolt': [[2120000]], 'regulator-ramp-delay': 12500, 'regulator-enable-ramp-delay': 500}, 'ldo_vtcxo': {'regulator-name': ['vtcxo'], 'regulator-min-microvolt': [[2800000]], 'regulator-max-microvolt': [[2800000]], 'regulator-enable-ramp-delay': 90}, 'ldo_va28': {'regulator-name': ['va28'], 'regulator-enable-ramp-delay': 218}, 'ldo_vcama': {'regulator-name': ['vcama'], 'regulator-min-microvolt': [[1500000]], 'regulator-max-microvolt': [[2800000]], 'regulator-enable-r
 amp-delay': 218}, 'ldo_vio28': {'regulator-name': ['vio28'], 'regulator-enable-ramp-delay': 240}, 'ldo_vusb': {'regulator-name': ['vusb'], 'regulator-enable-ramp-delay': 218}, 'ldo_vmc': {'regulator-name': ['vmc'], 'regulator-min-microvolt': [[1800000]], 'regulator-max-microvolt': [[3300000]], 'regulator-enable-ramp-delay': 218}, 'ldo_vmch': {'regulator-name': ['vmch'], 'regulator-min-microvolt': [[3000000]], 'regulator-max-microvolt': [[3300000]], 'regulator-enable-ramp-delay': 218}, 'ldo_vemc3v3': {'regulator-name': ['vemc_3v3'], 'regulator-min-microvolt': [[3000000]], 'regulator-max-microvolt': [[3300000]], 'regulator-enable-ramp-delay': 218}, 'ldo_vgp1': {'regulator-name': ['vcamd'], 'regulator-min-microvolt': [[1220000]], 'regulator-max-microvolt': [[3300000]], 'regulator-enable-ramp-delay': 240}, 'ldo_vgp2': {'regulator-name': ['vcamio'], 'regulator-min-microvolt': [[1000000]], 'regulator-max-microvolt': [[3300000]], 'regulator-enable-ramp-delay': 218}, 'ldo_vgp3': {'regulator
 -name': ['vcamaf'], 'regulator-min-microvolt': [[1200000]], 'regulator-max-microvolt': [[3300000]], 'regulator-enable-ramp-delay': 218}, 'ldo_vgp4': {'regulator-name': ['vgp4'], 'regulator-min-microvolt': [[1200000]], 'regulator-max-microvolt': [[3300000]], 'regulator-enable-ramp-delay': 218}, 'ldo_vgp5': {'regulator-name': ['vgp5'], 'regulator-min-microvolt': [[1200000]], 'regulator-max-microvolt': [[3000000]], 'regulator-enable-ramp-delay': 218}, 'ldo_vgp6': {'regulator-name': ['vgp6'], 'regulator-min-microvolt': [[1200000]], 'regulator-max-microvolt': [[3300000]], 'regulator-enable-ramp-delay': 218}, 'ldo_vibr': {'regulator-name': ['vibr'], 'regulator-min-microvolt': [[1200000]], 'regulator-max-microvolt': [[3300000]], 'regulator-enable-ramp-delay': 218}}
	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/mediatek,mt6397.example.dtb: pmic: regulators:compatible: 'oneOf' conditional failed, one must be fixed:
		['mediatek,mt6397-regulator'] is too short
		'mediatek,mt6358-regulator' was expected
		'mediatek,mt6366-regulator' was expected
	'mediatek,mt6323-regulator' was expected
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/mediatek,mt6397.example.dtb: pmic: regulators: Unevaluated properties are not allowed ('buck_vcore', 'buck_vdrm', 'buck_vgpu', 'buck_vio18', 'buck_vpca15', 'buck_vpca7', 'buck_vsramca15', 'buck_vsramca7', 'ldo_va28', 'ldo_vcama', 'ldo_vemc3v3', 'ldo_vgp1', 'ldo_vgp2', 'ldo_vgp3', 'ldo_vgp4', 'ldo_vgp5', 'ldo_vgp6', 'ldo_vibr', 'ldo_vio28', 'ldo_vmc', 'ldo_vmch', 'ldo_vtcxo', 'ldo_vusb' were unexpected)
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#

doc reference errors (make refcheckdocs):
Warning: Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml references a file that doesn't exist: Documentation/devicetree/bindings/mfd/mt6397.txt
Warning: Documentation/devicetree/bindings/leds/leds-mt6323.txt references a file that doesn't exist: Documentation/devicetree/bindings/mfd/mt6397.txt
Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml: Documentation/devicetree/bindings/mfd/mt6397.txt
Documentation/devicetree/bindings/leds/leds-mt6323.txt: Documentation/devicetree/bindings/mfd/mt6397.txt

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240830110732.30080-2-macpaul.lin@mediatek.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


