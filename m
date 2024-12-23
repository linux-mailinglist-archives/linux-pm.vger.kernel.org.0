Return-Path: <linux-pm+bounces-19662-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FE19FAE61
	for <lists+linux-pm@lfdr.de>; Mon, 23 Dec 2024 13:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D83161883782
	for <lists+linux-pm@lfdr.de>; Mon, 23 Dec 2024 12:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8FA1ACDF0;
	Mon, 23 Dec 2024 12:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FjFq49mA"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2671AC43A;
	Mon, 23 Dec 2024 12:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734958341; cv=none; b=Q/egkdD6Rl4Fyx9nKQny/fZjMm33lSa4/agh/hjTQ2h3iXtQkVOSht+RsIC2fiackqRIk2uGVHCoXgmw0FCAU9fk6Y1/BgMIlwiq+HxHBMXsXHgLqptF+ct+QrCSpD6LfcOKeZKTGJA766fPkoGkE0Qm6r4/zYsETNV6kJRyHFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734958341; c=relaxed/simple;
	bh=rKTCQO0ZQLcAA+nfRoyIdKzGw+ZOLfg3l8ikMZw26X4=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=O+f7SGFqlFmHWzbk374ZYljVIc9MQ0HEal35MarmluWOpALWWCUVkSWWMlcpQN9/eY736ijo47xSTIXEVyY6n67fgB6wZ7HTEILgKc46oiMgWvMO9m43R5LUx+mg2+2NlygWasaaTUjAMrWWnwHCsJ2yjg5fxok42Ny9Bc6NtnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FjFq49mA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3A63C4CED3;
	Mon, 23 Dec 2024 12:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734958341;
	bh=rKTCQO0ZQLcAA+nfRoyIdKzGw+ZOLfg3l8ikMZw26X4=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=FjFq49mAwHcBvTzKpdyX3k/HG4fL697jY4DFyAhDS6zxJLNeaEX0cwmdPX6aPriA6
	 hnWnImo9qSPMuUZJffzOBjU16GIM/LuEjYeYQI7D15/WeaQZlaEUn0jVx9D48uuvcB
	 mlVBaZFlDCa7Oe/Ny3gPM6Pb9gye4gcSrw2ha2owE79kGxZn7qUPEBQzPCVp4YHkZV
	 Z9zoq4K8mK7spF4ZQTcMyVOhfLLzTCY6JOhJg1oWtqDXssBLeViIcT9o/9ZSI45Pz6
	 fSuMHdaXXxPxwayjmPI2R82ZvS7+c7JhS/DxMkXBEtnxdMnvgJzhJIdnCZpXtMShmL
	 XpzYYuF6qn91A==
Date: Mon, 23 Dec 2024 06:52:19 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>, 
 linux-pm@vger.kernel.org, Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Robin Murphy <robin.murphy@arm.com>, Amit Kucheria <amitk@kernel.org>, 
 iommu@lists.linux.dev, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 Konrad Dybcio <konradybcio@kernel.org>, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Conor Dooley <conor+dt@kernel.org>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org, 
 linux-gpio@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Dang Huynh <danct12@riseup.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Joerg Roedel <joro@8bytes.org>, Zhang Rui <rui.zhang@intel.com>, 
 Bjorn Andersson <andersson@kernel.org>
To: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
In-Reply-To: <20241221-msm8917-v11-0-901a74db4805@mainlining.org>
References: <20241221-msm8917-v11-0-901a74db4805@mainlining.org>
Message-Id: <173495824869.503733.14210199491465064171.robh@kernel.org>
Subject: Re: [PATCH v11 0/4] Add MSM8917/PM8937/Redmi 5A


On Sat, 21 Dec 2024 00:40:47 +0100, Barnabás Czémán wrote:
> This patch series add support for MSM8917 soc with PM8937 and
> Xiaomi Redmi 5A (riva).
> 
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---
> Changes in v11:
> - msm8917:
>   - pll_opp_table: fix indentation
>   - gpu_opp_table: change to ascending order
> - Remove applied patches.
> - Link to v10: https://lore.kernel.org/r/20241220-msm8917-v10-0-3d5734e8c3a6@mainlining.org
> 
> Changes in v10:
> - msm8917: sdc1 cmd_on, cmd_off change bias-disable to bias-pull-up
> - Remove applied patches.
> - Link to v9: https://lore.kernel.org/r/20241215-msm8917-v9-0-bacaa26f3eef@mainlining.org
> 
> Changes in v9:
> - msm8917:
>  - add some empty lines for separating pins more
>  - order compatible, reg, ranges properties
> - Link to v8: https://lore.kernel.org/r/20241211-msm8917-v8-0-197acc042036@mainlining.org
> 
> Changes in v8:
> - pm8937, msm8917, msm8917-xiaomi-riva: remove unused includes
> - Link to v7: https://lore.kernel.org/r/20241124-msm8917-v7-0-612729834656@mainlining.org
> 
> Changes in v7:
> - msm8917-xiaomi-riva:
>   - Add pinctrls for used GPIO pins.
>   - Use interrupts-extend for charger.
>   - Order properies.
> - Link to v6: https://lore.kernel.org/r/20241113-msm8917-v6-0-c348fb599fef@mainlining.org
> 
> Changes in v6:
> - msm8917:
>   - Consolidate SDC pins, remove sdc2-cd-on/off pins.
>   - Remove cluster-sleep-0 and cluster-sleep-1
>   and rename cluster-sleep-2 to cluster-sleep-0.
>   - Fix spi, i2c and related pinctrl namings.
> - msm8917-xiaomi-riva: follow i2c name changes.
> - Link to v5: https://lore.kernel.org/r/20241112-msm8917-v5-0-3ca34d33191b@mainlining.org
> 
> Changes in v5:
> - msm8917:
>   - Remove aliases.
>   - Rename spi, i2c labels and pins.
>   - Remove clock-frequency from timers
>   - Remove unused mpss_mem region.
>   - Use mboxes where it can be used, only smd-edge uses qcom,ipc.
> - msm8917-xiaomi-riva: Follow i2c label changes.
> - Link to v4: https://lore.kernel.org/r/20241109-msm8917-v4-0-8be9904792ab@mainlining.org
> 
> Changes in v4:
> - msm8917 pinctrl: Fix gpio regexp in the schema.
> - msm8937 tsens: Rename ops_msm8976 to ops_common and use it for msm8937.
> - msm8917: fix address padding, naming and ordering, remove polling-delays.
> - Remove applied patches from the series.
> - Link to v3: https://lore.kernel.org/r/20241107-msm8917-v3-0-6ddc5acd978b@mainlining.org
> 
> Changes in v3:
> - msm8917-xiaomi-riva: Fix issues addressed by Konrad.
> - msm8917: Fix node addresses, orders of some properties.
> - pm8937: simplify vadc channels.
> - msm8917 pinctrl: Fix schema issues addressed by Krzysztof.
> - Remove applied tcsr patch from this series.
> - Reword some commit title.
> - Link to v2: https://lore.kernel.org/r/20241031-msm8917-v2-0-8a075faa89b1@mainlining.org
> 
> Changes in v2:
> - Add msm8937 tsens support.
> - Fix issues addressed by reviews.
> - Link to v1: https://lore.kernel.org/r/20241019-msm8917-v1-0-f1f3ca1d88e5@mainlining.org
> 
> ---
> Barnabás Czémán (2):
>       dt-bindings: arm: qcom: Add Xiaomi Redmi 5A
>       arm64: dts: qcom: Add Xiaomi Redmi 5A
> 
> Dang Huynh (1):
>       arm64: dts: qcom: Add PM8937 PMIC
> 
> Otto Pflüger (1):
>       arm64: dts: qcom: Add initial support for MSM8917
> 
>  Documentation/devicetree/bindings/arm/qcom.yaml  |    7 +
>  arch/arm64/boot/dts/qcom/Makefile                |    1 +
>  arch/arm64/boot/dts/qcom/msm8917-xiaomi-riva.dts |  333 ++++
>  arch/arm64/boot/dts/qcom/msm8917.dtsi            | 1954 ++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/pm8937.dtsi             |  150 ++
>  5 files changed, 2445 insertions(+)
> ---
> base-commit: 8503810115fbff903f626adc0788daa048302bc0
> change-id: 20241019-msm8917-17c3d0ff4a52
> 
> Best regards,
> --
> Barnabás Czémán <barnabas.czeman@mainlining.org>
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


New warnings running 'make CHECK_DTBS=y qcom/msm8917-xiaomi-riva.dtb' for 20241221-msm8917-v11-0-901a74db4805@mainlining.org:

arch/arm64/boot/dts/qcom/msm8917-xiaomi-riva.dtb: qfprom@a4000: compatible:0: 'qcom,msm8917-qfprom' is not one of ['qcom,apq8064-qfprom', 'qcom,apq8084-qfprom', 'qcom,ipq5332-qfprom', 'qcom,ipq6018-qfprom', 'qcom,ipq8064-qfprom', 'qcom,ipq8074-qfprom', 'qcom,ipq9574-qfprom', 'qcom,msm8226-qfprom', 'qcom,msm8916-qfprom', 'qcom,msm8974-qfprom', 'qcom,msm8976-qfprom', 'qcom,msm8996-qfprom', 'qcom,msm8998-qfprom', 'qcom,qcm2290-qfprom', 'qcom,qcs404-qfprom', 'qcom,sc7180-qfprom', 'qcom,sc7280-qfprom', 'qcom,sc8280xp-qfprom', 'qcom,sdm630-qfprom', 'qcom,sdm670-qfprom', 'qcom,sdm845-qfprom', 'qcom,sm6115-qfprom', 'qcom,sm6350-qfprom', 'qcom,sm6375-qfprom', 'qcom,sm8150-qfprom', 'qcom,sm8250-qfprom', 'qcom,sm8450-qfprom', 'qcom,sm8550-qfprom', 'qcom,sm8650-qfprom']
	from schema $id: http://devicetree.org/schemas/nvmem/qcom,qfprom.yaml#
arch/arm64/boot/dts/qcom/msm8917-xiaomi-riva.dtb: qfprom@a4000: Unevaluated properties are not allowed ('compatible' was unexpected)
	from schema $id: http://devicetree.org/schemas/nvmem/qcom,qfprom.yaml#
arch/arm64/boot/dts/qcom/msm8917-xiaomi-riva.dtb: /soc@0/qfprom@a4000: failed to match any schema with compatible: ['qcom,msm8917-qfprom', 'qcom,qfprom']
arch/arm64/boot/dts/qcom/msm8917-xiaomi-riva.dtb: iommu@1e20000: compatible: 'oneOf' conditional failed, one must be fixed:
	'qcom,msm8917-iommu' is not one of ['qcom,msm8916-iommu', 'qcom,msm8953-iommu']
	'qcom,msm8917-iommu' is not one of ['qcom,msm8953-iommu', 'qcom,msm8976-iommu']
	'qcom,msm-iommu-v2' was expected
	from schema $id: http://devicetree.org/schemas/iommu/qcom,iommu.yaml#
arch/arm64/boot/dts/qcom/msm8917-xiaomi-riva.dtb: /soc@0/iommu@1e20000: failed to match any schema with compatible: ['qcom,msm8917-iommu', 'qcom,msm-iommu-v1']
arch/arm64/boot/dts/qcom/msm8917-xiaomi-riva.dtb: iommu@1f08000: compatible: 'oneOf' conditional failed, one must be fixed:
	'qcom,msm8917-iommu' is not one of ['qcom,msm8916-iommu', 'qcom,msm8953-iommu']
	'qcom,msm8917-iommu' is not one of ['qcom,msm8953-iommu', 'qcom,msm8976-iommu']
	'qcom,msm-iommu-v2' was expected
	from schema $id: http://devicetree.org/schemas/iommu/qcom,iommu.yaml#
arch/arm64/boot/dts/qcom/msm8917-xiaomi-riva.dtb: /soc@0/iommu@1f08000: failed to match any schema with compatible: ['qcom,msm8917-iommu', 'qcom,msm-iommu-v1']






