Return-Path: <linux-pm+bounces-12105-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 542BB94F157
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2024 17:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6DD11F22DD1
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2024 15:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4196F184539;
	Mon, 12 Aug 2024 15:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J3lVdB02"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E3F184522;
	Mon, 12 Aug 2024 15:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723475377; cv=none; b=jLf1FLiLcAftSAgRwjwYfETpgJXj2ybQE9DaeWPjZNZ46H4U8QVoDtlqf95P3yIvpY3YgRGKXD1jGqbHZg4b2wyxOLc5fgESX61+xEXRUWLwm5FuiENJai4EQyA5kdtE2neqm59l/oEEuutl/SYRoW3cHgUjxDXg6rZOvfbTcaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723475377; c=relaxed/simple;
	bh=1kn+z+7q1wqdtmh9jhZK4uR69KYAI+zlgxdG0wzM5t8=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=hJhT/wn/nrlvALEqVlrjwRyS6qx4/ArfwqJSkTftOE/HzK2Hdp+D2XSacOkDx9w/MVdO3aWWqhowElm2Y2JgRzUm6YRpuYWis1M3wdaCP1lBmc+HnXED0htVDVwDElAcfg/AT1umAx7YgB/Wuo5WGdB8Rz9xWl0lZ31lZsrDj2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J3lVdB02; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ADA2C32782;
	Mon, 12 Aug 2024 15:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723475376;
	bh=1kn+z+7q1wqdtmh9jhZK4uR69KYAI+zlgxdG0wzM5t8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=J3lVdB02cWIw6yUSBBVFDD+VhQetYXljueChfbOWpbqVQzbTgwWzqjNSmJKocc+OM
	 58hFATKCgslm9D97NFjjduOSg17c1G+bpuqm2ll7RbHJBxtAjYM/h9GKEQ5S9YAVi8
	 6/VBFBrgu8PUoVxO6nq7mtNLurpHVeGz5GgKMuHQRKZN4Q3JwWQQz0A7NV1DsRZ6Mi
	 9nbdpuhvBtj4phXGqJ48LJZwKRbhAEjXkEpfnTzm2sVVN9etDmkwcti5vNXzmz514v
	 0IPAAAhJiI0z0cZ6ZHLU7aFvpoJbDaYWtGc1qM0f1Z3BWl7IRhIgIMksYZteuSi3c7
	 Xi/LSWVu5EHUQ==
Date: Mon, 12 Aug 2024 09:09:35 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Danila Tikhonov <danila@jiaxyga.com>
Cc: neil.armstrong@linaro.org, ulf.hansson@linaro.org, 
 linux-hardening@vger.kernel.org, dmitry.baryshkov@linaro.org, 
 linux-kernel@vger.kernel.org, kees@kernel.org, krzk+dt@kernel.org, 
 heiko.stuebner@cherry.de, devicetree@vger.kernel.org, 
 macromorgan@hotmail.com, linux-pm@vger.kernel.org, viresh.kumar@linaro.org, 
 lpieralisi@kernel.org, quic_rjendra@quicinc.com, kuba@kernel.org, 
 linux-arm-msm@vger.kernel.org, pabeni@redhat.com, fekz115@gmail.com, 
 linux@mainlining.org, andre.przywara@arm.com, conor+dt@kernel.org, 
 konradybcio@kernel.org, gpiccoli@igalia.com, andersson@kernel.org, 
 rafael@kernel.org, netdev@vger.kernel.org, rafal@milecki.pl, 
 tony.luck@intel.com, davidwronek@gmail.com, linus.walleij@linaro.org, 
 edumazet@google.com, davem@davemloft.net
In-Reply-To: <20240808184048.63030-1-danila@jiaxyga.com>
References: <20240808184048.63030-1-danila@jiaxyga.com>
Message-Id: <172347513874.603162.8901170126444753598.robh@kernel.org>
Subject: Re: [PATCH v2 00/11] Add Nothing Phone (1) support


On Thu, 08 Aug 2024 21:40:14 +0300, Danila Tikhonov wrote:
> This series of patches adds support for the Nothing Phone (1), identified
> as nothing,spacewar. The Nothing Phone (1) is built on the Qualcomm
> Snapdragon 778G+ (SM7325-AE, also known as yupik).
> 
> SM7325 is identical to SC7280 just as SM7125 is identical to SC7180, so
> SM7325 devicetree imports SC7280 devicetree as a base.
> 
> All of these patches are essential for the integration of the Nothing
> Phone (1) into the kernel. The inclusion of SoC IDs is particularly
> important, as I encounter crash dumps if the device tree lacks msm and
> board id information.
> 
> Changes in v2:
> - Add Krzysztof's R-b tag (patches no. 1, 2, 10)
> - Add Dmitry's R-b tag (patches no. 3, 4, 8)
> - Document SM7325 as fallback to QCM6490 (patch no. 5)
> - Drop patch no. 6 from v1
> - Document PN553 NFC IC as fallback to nxp-nci-i2c (patch no. 6)
> - Add Krzysztof's A-b tag (patches no. 7, 9)
> - Switch nl.nothing.tech/nothing.tech in commit msg (patch no. 9)
> - Add fallback compatibility for NFC (patch no. 10)
> - Fix interrupt type for NFC (patch no. 10)
> Note: Rob's A-b tag (patch no. 5) was not added because the patch was
> fixed. Please look at it again.
> - Link to v1:
> https://lore.kernel.org/all/20240729201843.142918-1-danila@jiaxyga.com/
> 
> To: Rob Herring <robh@kernel.org>
> To: Krzysztof Kozlowski <krzk+dt@kernel.org>
> To: Conor Dooley <conor+dt@kernel.org>
> To: Bjorn Andersson <andersson@kernel.org>
> To: Konrad Dybcio <konradybcio@kernel.org>
> To: "David S. Miller" <davem@davemloft.net>
> To: Eric Dumazet <edumazet@google.com>
> To: Jakub Kicinski <kuba@kernel.org>
> To: Paolo Abeni <pabeni@redhat.com>
> To: "Rafael J. Wysocki" <rafael@kernel.org>
> To: Viresh Kumar <viresh.kumar@linaro.org>
> To: Kees Cook <kees@kernel.org>
> To: Tony Luck <tony.luck@intel.com>
> To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
> To: Ulf Hansson <ulf.hansson@linaro.org>
> To: Andre Przywara <andre.przywara@arm.com>
> To: Rajendra Nayak <quic_rjendra@quicinc.com>
> To: David Wronek <davidwronek@gmail.com>
> To: Neil Armstrong <neil.armstrong@linaro.org>
> To: Heiko Stuebner <heiko.stuebner@cherry.de>
> To: "Rafał Miłecki" <rafal@milecki.pl>
> To: Chris Morgan <macromorgan@hotmail.com>
> To: Linus Walleij <linus.walleij@linaro.org>
> To: Lorenzo Pieralisi <lpieralisi@kernel.org>
> To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> To: Eugene Lepshy <fekz115@gmail.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-arm-msm@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> Cc: linux-hardening@vger.kernel.org
> Cc: linux@mainlining.org
> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
> 
> Danila Tikhonov (9):
>   dt-bindings: arm: qcom,ids: Add IDs for SM7325 family
>   soc: qcom: socinfo: Add Soc IDs for SM7325 family
>   cpufreq: Add SM7325 to cpufreq-dt-platdev blocklist
>   soc: qcom: pd_mapper: Add SM7325 compatible
>   dt-bindings: soc: qcom: qcom,pmic-glink: Document SM7325 compatible
>   dt-bindings: nfc: nxp,nci: Document PN553 compatible
>   dt-bindings: arm: cpus: Add qcom kryo670 compatible
>   dt-bindings: vendor-prefixes: Add Nothing Technology Limited
>   dt-bindings: arm: qcom: Add SM7325 Nothing Phone 1
> 
> Eugene Lepshy (2):
>   arm64: dts: qcom: Add SM7325 device tree
>   arm64: dts: qcom: sm7325: Add device-tree for Nothing Phone 1
> 
>  .../devicetree/bindings/arm/cpus.yaml         |    1 +
>  .../devicetree/bindings/arm/qcom.yaml         |    6 +
>  .../devicetree/bindings/net/nfc/nxp,nci.yaml  |    1 +
>  .../bindings/soc/qcom/qcom,pmic-glink.yaml    |    5 +
>  .../devicetree/bindings/vendor-prefixes.yaml  |    2 +
>  arch/arm64/boot/dts/qcom/Makefile             |    1 +
>  .../boot/dts/qcom/sm7325-nothing-spacewar.dts | 1263 +++++++++++++++++
>  arch/arm64/boot/dts/qcom/sm7325.dtsi          |   17 +
>  drivers/cpufreq/cpufreq-dt-platdev.c          |    1 +
>  drivers/soc/qcom/qcom_pd_mapper.c             |    1 +
>  drivers/soc/qcom/socinfo.c                    |    2 +
>  include/dt-bindings/arm/qcom,ids.h            |    2 +
>  12 files changed, 1302 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sm7325-nothing-spacewar.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sm7325.dtsi
> 
> --
> 2.45.2
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


New warnings running 'make CHECK_DTBS=y qcom/sm7325-nothing-spacewar.dtb' for 20240808184048.63030-1-danila@jiaxyga.com:

arch/arm64/boot/dts/qcom/sm7325-nothing-spacewar.dtb: /: qcom,board-id: False schema does not allow [[65547, 0]]
	from schema $id: http://devicetree.org/schemas/arm/qcom.yaml#
arch/arm64/boot/dts/qcom/sm7325-nothing-spacewar.dtb: /: qcom,msm-id: False schema does not allow [[475, 65536]]
	from schema $id: http://devicetree.org/schemas/arm/qcom.yaml#
arch/arm64/boot/dts/qcom/sm7325-nothing-spacewar.dtb: pcie@1c08000: interrupts: [[0, 307, 4], [0, 308, 4], [0, 309, 4], [0, 312, 4], [0, 313, 4], [0, 314, 4], [0, 374, 4], [0, 375, 4]] is too long
	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-sc7280.yaml#
arch/arm64/boot/dts/qcom/sm7325-nothing-spacewar.dtb: pcie@1c08000: interrupt-names:0: 'msi' was expected
	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-sc7280.yaml#
arch/arm64/boot/dts/qcom/sm7325-nothing-spacewar.dtb: pcie@1c08000: interrupt-names: ['msi0', 'msi1', 'msi2', 'msi3', 'msi4', 'msi5', 'msi6', 'msi7'] is too long
	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-sc7280.yaml#
arch/arm64/boot/dts/qcom/sm7325-nothing-spacewar.dtb: usb@8cf8800: interrupt-names: ['pwr_event', 'hs_phy_irq', 'dp_hs_phy_irq', 'dm_hs_phy_irq'] is too short
	from schema $id: http://devicetree.org/schemas/usb/qcom,dwc3.yaml#
arch/arm64/boot/dts/qcom/sm7325-nothing-spacewar.dtb: video-codec@aa00000: iommus: [[68, 8576, 32]] is too short
	from schema $id: http://devicetree.org/schemas/media/qcom,sc7280-venus.yaml#






