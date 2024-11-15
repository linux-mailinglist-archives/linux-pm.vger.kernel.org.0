Return-Path: <linux-pm+bounces-17632-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCB19CF0BA
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 16:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C3C0B39F5D
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 15:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66CDC1D5AC0;
	Fri, 15 Nov 2024 15:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2OuknJs"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCF51D5AAE;
	Fri, 15 Nov 2024 15:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731683590; cv=none; b=VaAVSBfssyajUPLPHdc3pA34C4ebIIPlUPp5F7sEoYIwGVtLMPHIt5nPmHX7VcjO2nRzUC+d9N6F6jYbx3z8v+bKJ/25qoZQnYL27nc8b09nbf/WvC4MfTQvDvlkijmuxqoSpq6NZox3ALyea4EW7216XJ2sIPAhYA5t9aQxu2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731683590; c=relaxed/simple;
	bh=klAyE4yJ7Pn0JVsn2LEXwcXJbbb9kRKwa/irKLMf2T4=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=Qwqk4NfIK64+HAregbVHSzbJbjOkrXNQYffuR03R7VpFWbUGpUFb48wxHythcf2C9EyShCsGiE9Jajp9+3hFkl7QuNJyvrqZsk6z72/fRPoaXovaGJuH+yHwIDOYJxcYkXKQ1RsEJjuGTuV4Nql1twuRIbsrwuuznHEU8TDh4B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2OuknJs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 711A0C4CECF;
	Fri, 15 Nov 2024 15:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731683589;
	bh=klAyE4yJ7Pn0JVsn2LEXwcXJbbb9kRKwa/irKLMf2T4=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=Y2OuknJsoQAQB5m7vthDedO97fOYrfqPfuhYnNLlKVzFW7tZk9IRd+A1mUc7AYKSJ
	 PbyyduVPzN2oe+HqLk4I4d6Oe5V/AHzXht4DMRL0s99krwOsFnG7buZMdrloTcpeWj
	 2P1u2t7iCC6o3us+6BQars4uiZo1ddxYYDq6KLslps0O26EgkkLwJ1PFNnUSLuHdT1
	 H7jtP/DfTPZv0p+TEgJ/LISYJwjFrpD1TSPmFSu42OgVifnAhOGTlDIl9iqB4rqvgI
	 taQSFHcUReld+K139G1fP8NQ/wovMoB1ZOLFOgXoSlRPM1xcGOjD7TnJrJrKu1vny9
	 sOG8lk1AC/+Hw==
Date: Fri, 15 Nov 2024 09:13:07 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: iommu@lists.linux.dev, Zhang Rui <rui.zhang@intel.com>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, Will Deacon <will@kernel.org>, 
 linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, devicetree@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>, 
 Joerg Roedel <joro@8bytes.org>, Conor Dooley <conor+dt@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, Dang Huynh <danct12@riseup.net>, 
 linux-gpio@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, 
 linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, 
 =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
In-Reply-To: <20241113-msm8917-v6-0-c348fb599fef@mainlining.org>
References: <20241113-msm8917-v6-0-c348fb599fef@mainlining.org>
Message-Id: <173168321268.2749739.14402170098343790318.robh@kernel.org>
Subject: Re: [PATCH v6 00/10] Add MSM8917/PM8937/Redmi 5A


On Wed, 13 Nov 2024 16:11:41 +0100, Barnabás Czémán wrote:
> This patch series add support for MSM8917 soc with PM8937 and
> Xiaomi Redmi 5A (riva).
> 
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---
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
> Barnabás Czémán (7):
>       dt-bindings: pinctrl: qcom: Add MSM8917 pinctrl
>       dt-bindings: thermal: tsens: Add MSM8937
>       thermal/drivers/qcom/tsens-v1: Add support for MSM8937 tsens
>       dt-bindings: iommu: qcom,iommu: Add MSM8917 IOMMU to SMMUv1 compatibles
>       dt-bindings: nvmem: Add compatible for MS8917
>       dt-bindings: arm: qcom: Add Xiaomi Redmi 5A
>       arm64: dts: qcom: Add Xiaomi Redmi 5A
> 
> Dang Huynh (1):
>       arm64: dts: qcom: Add PM8937 PMIC
> 
> Otto Pflüger (2):
>       pinctrl: qcom: Add MSM8917 tlmm pinctrl driver
>       arm64: dts: qcom: Add initial support for MSM8917
> 
>  Documentation/devicetree/bindings/arm/qcom.yaml    |    7 +
>  .../devicetree/bindings/iommu/qcom,iommu.yaml      |    1 +
>  .../devicetree/bindings/nvmem/qcom,qfprom.yaml     |    1 +
>  .../bindings/pinctrl/qcom,msm8917-pinctrl.yaml     |  160 ++
>  .../devicetree/bindings/thermal/qcom-tsens.yaml    |    1 +
>  arch/arm64/boot/dts/qcom/Makefile                  |    1 +
>  arch/arm64/boot/dts/qcom/msm8917-xiaomi-riva.dts   |  297 +++
>  arch/arm64/boot/dts/qcom/msm8917.dtsi              | 1946 ++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/pm8937.dtsi               |  152 ++
>  drivers/pinctrl/qcom/Kconfig.msm                   |    6 +
>  drivers/pinctrl/qcom/Makefile                      |    1 +
>  drivers/pinctrl/qcom/pinctrl-msm8917.c             | 1620 ++++++++++++++++
>  drivers/thermal/qcom/tsens-v1.c                    |   21 +-
>  drivers/thermal/qcom/tsens.c                       |    3 +
>  drivers/thermal/qcom/tsens.h                       |    2 +-
>  15 files changed, 4211 insertions(+), 8 deletions(-)
> ---
> base-commit: 6d59cab07b8d74d0f0422b750038123334f6ecc2
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


New warnings running 'make CHECK_DTBS=y qcom/msm8917-xiaomi-riva.dtb' for 20241113-msm8917-v6-0-c348fb599fef@mainlining.org:

arch/arm64/boot/dts/qcom/msm8917-xiaomi-riva.dtb: /soc@0/syscon@1937000: failed to match any schema with compatible: ['qcom,tcsr-msm8917', 'syscon']
arch/arm64/boot/dts/qcom/msm8917-xiaomi-riva.dtb: pmic@0: gpio@c000:compatible:0: 'qcom,pm8937-gpio' is not one of ['qcom,pm2250-gpio', 'qcom,pm660-gpio', 'qcom,pm660l-gpio', 'qcom,pm6125-gpio', 'qcom,pm6150-gpio', 'qcom,pm6150l-gpio', 'qcom,pm6350-gpio', 'qcom,pm6450-gpio', 'qcom,pm7250b-gpio', 'qcom,pm7325-gpio', 'qcom,pm7550ba-gpio', 'qcom,pm8005-gpio', 'qcom,pm8018-gpio', 'qcom,pm8019-gpio', 'qcom,pm8038-gpio', 'qcom,pm8058-gpio', 'qcom,pm8150-gpio', 'qcom,pm8150b-gpio', 'qcom,pm8150l-gpio', 'qcom,pm8226-gpio', 'qcom,pm8350-gpio', 'qcom,pm8350b-gpio', 'qcom,pm8350c-gpio', 'qcom,pm8450-gpio', 'qcom,pm8550-gpio', 'qcom,pm8550b-gpio', 'qcom,pm8550ve-gpio', 'qcom,pm8550vs-gpio', 'qcom,pm8916-gpio', 'qcom,pm8917-gpio', 'qcom,pm8921-gpio', 'qcom,pm8941-gpio', 'qcom,pm8950-gpio', 'qcom,pm8953-gpio', 'qcom,pm8994-gpio', 'qcom,pm8998-gpio', 'qcom,pma8084-gpio', 'qcom,pmc8180-gpio', 'qcom,pmc8180c-gpio', 'qcom,pmc8380-gpio', 'qcom,pmd8028-gpio', 'qcom,pmi632-gpio', 'qcom,pmi8950-gpio', 'qc
 om,pmi8994-gpio', 'qcom,pmi8998-gpio', 'qcom,pmih0108-gpio', 'qcom,pmk8350-gpio', 'qcom,pmk8550-gpio', 'qcom,pmm8155au-gpio', 'qcom,pmm8654au-gpio', 'qcom,pmp8074-gpio', 'qcom,pmr735a-gpio', 'qcom,pmr735b-gpio', 'qcom,pmr735d-gpio', 'qcom,pms405-gpio', 'qcom,pmx55-gpio', 'qcom,pmx65-gpio', 'qcom,pmx75-gpio', 'qcom,pmxr2230-gpio']
	from schema $id: http://devicetree.org/schemas/mfd/qcom,spmi-pmic.yaml#
arch/arm64/boot/dts/qcom/msm8917-xiaomi-riva.dtb: pmic@0: mpps@a000:compatible: 'oneOf' conditional failed, one must be fixed:
	'qcom,pm8937-mpp' is not one of ['qcom,pm8019-mpp', 'qcom,pm8226-mpp', 'qcom,pm8841-mpp', 'qcom,pm8916-mpp', 'qcom,pm8941-mpp', 'qcom,pm8950-mpp', 'qcom,pmi8950-mpp', 'qcom,pm8994-mpp', 'qcom,pma8084-mpp', 'qcom,pmi8994-mpp']
	'qcom,pm8937-mpp' is not one of ['qcom,pm8018-mpp', 'qcom,pm8038-mpp', 'qcom,pm8058-mpp', 'qcom,pm8821-mpp', 'qcom,pm8901-mpp', 'qcom,pm8917-mpp', 'qcom,pm8921-mpp']
	'qcom,ssbi-mpp' was expected
	from schema $id: http://devicetree.org/schemas/mfd/qcom,spmi-pmic.yaml#
arch/arm64/boot/dts/qcom/msm8917-xiaomi-riva.dtb: gpio@c000: compatible:0: 'qcom,pm8937-gpio' is not one of ['qcom,pm2250-gpio', 'qcom,pm660-gpio', 'qcom,pm660l-gpio', 'qcom,pm6125-gpio', 'qcom,pm6150-gpio', 'qcom,pm6150l-gpio', 'qcom,pm6350-gpio', 'qcom,pm6450-gpio', 'qcom,pm7250b-gpio', 'qcom,pm7325-gpio', 'qcom,pm7550ba-gpio', 'qcom,pm8005-gpio', 'qcom,pm8018-gpio', 'qcom,pm8019-gpio', 'qcom,pm8038-gpio', 'qcom,pm8058-gpio', 'qcom,pm8150-gpio', 'qcom,pm8150b-gpio', 'qcom,pm8150l-gpio', 'qcom,pm8226-gpio', 'qcom,pm8350-gpio', 'qcom,pm8350b-gpio', 'qcom,pm8350c-gpio', 'qcom,pm8450-gpio', 'qcom,pm8550-gpio', 'qcom,pm8550b-gpio', 'qcom,pm8550ve-gpio', 'qcom,pm8550vs-gpio', 'qcom,pm8916-gpio', 'qcom,pm8917-gpio', 'qcom,pm8921-gpio', 'qcom,pm8941-gpio', 'qcom,pm8950-gpio', 'qcom,pm8953-gpio', 'qcom,pm8994-gpio', 'qcom,pm8998-gpio', 'qcom,pma8084-gpio', 'qcom,pmc8180-gpio', 'qcom,pmc8180c-gpio', 'qcom,pmc8380-gpio', 'qcom,pmd8028-gpio', 'qcom,pmi632-gpio', 'qcom,pmi8950-gpio', 'qcom,pmi8
 994-gpio', 'qcom,pmi8998-gpio', 'qcom,pmih0108-gpio', 'qcom,pmk8350-gpio', 'qcom,pmk8550-gpio', 'qcom,pmm8155au-gpio', 'qcom,pmm8654au-gpio', 'qcom,pmp8074-gpio', 'qcom,pmr735a-gpio', 'qcom,pmr735b-gpio', 'qcom,pmr735d-gpio', 'qcom,pms405-gpio', 'qcom,pmx55-gpio', 'qcom,pmx65-gpio', 'qcom,pmx75-gpio', 'qcom,pmxr2230-gpio']
	from schema $id: http://devicetree.org/schemas/pinctrl/qcom,pmic-gpio.yaml#
arch/arm64/boot/dts/qcom/msm8917-xiaomi-riva.dtb: /soc@0/spmi@200f000/pmic@0/gpio@c000: failed to match any schema with compatible: ['qcom,pm8937-gpio', 'qcom,spmi-gpio']
arch/arm64/boot/dts/qcom/msm8917-xiaomi-riva.dtb: mpps@a000: compatible: 'oneOf' conditional failed, one must be fixed:
	'qcom,pm8937-mpp' is not one of ['qcom,pm8019-mpp', 'qcom,pm8226-mpp', 'qcom,pm8841-mpp', 'qcom,pm8916-mpp', 'qcom,pm8941-mpp', 'qcom,pm8950-mpp', 'qcom,pmi8950-mpp', 'qcom,pm8994-mpp', 'qcom,pma8084-mpp', 'qcom,pmi8994-mpp']
	'qcom,pm8937-mpp' is not one of ['qcom,pm8018-mpp', 'qcom,pm8038-mpp', 'qcom,pm8058-mpp', 'qcom,pm8821-mpp', 'qcom,pm8901-mpp', 'qcom,pm8917-mpp', 'qcom,pm8921-mpp']
	'qcom,ssbi-mpp' was expected
	from schema $id: http://devicetree.org/schemas/pinctrl/qcom,pmic-mpp.yaml#
arch/arm64/boot/dts/qcom/msm8917-xiaomi-riva.dtb: /soc@0/spmi@200f000/pmic@0/mpps@a000: failed to match any schema with compatible: ['qcom,pm8937-mpp', 'qcom,spmi-mpp']






