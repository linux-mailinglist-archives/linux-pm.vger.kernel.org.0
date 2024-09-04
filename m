Return-Path: <linux-pm+bounces-13583-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 343F196BEB7
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 15:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 589B81C2221D
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 13:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9ED1DC197;
	Wed,  4 Sep 2024 13:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Of09j7Bu"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A9D1DC18F;
	Wed,  4 Sep 2024 13:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725457009; cv=none; b=Ec5ZDd7ti8vJN94mGmkXpYALnGWRGk6bmo2H/dVG5PdMvppgK9XCfwOcjEx5H4JU5FIjXVz0tAv/UuutaKv7mN0N3wbIyF1EEwOmkN9/FlBBXWGbrDVphAKrLrNkDGYa6k2ewd1vBAZc6t9PbB2ijBmP0w1IY1roAgrWUIVBF54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725457009; c=relaxed/simple;
	bh=qWY32TQVxIiG/7F7JcJ2JBNdihZus2JMmzuFFBXoAw8=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=Q+CnMXO2VeWWxwZxDADuTJ1+jO+ewC+o04j/9xkLXpN0gFzct3/BWEbzJSTPALToSGByfHXMtboAJm8nJM68KI6DJsM9bHNqZ2ecJsnkWx2SLeWmZkCSgSIE/PPkoziip6c7Gceir2qiPxDnY4jqfyTkx4VLsuetcu+VV0fDtsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Of09j7Bu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B510CC4CECC;
	Wed,  4 Sep 2024 13:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725457009;
	bh=qWY32TQVxIiG/7F7JcJ2JBNdihZus2JMmzuFFBXoAw8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Of09j7BuUK/iZCc5Z6JVx/0geBcWgWdJG67JTXEoneZVqv1rdanX4h73G7aKpgK+s
	 hD3JEuO1EEHmeCIi293LsmozCAvh6CqWjLjGb4mT5mjZqES2YNBb3IcLCPxwbhq4H9
	 ZZlljf7w7/j5c32YHnmbd+MI24QJHgmzEJwoA2gRYxBcrU2+Obu6TcnFrlTsrvsyMp
	 J0JuUk363D9BYB9AUuq896Y0DcZaOM09RRE5RpJhaQg/g76hJIQB1+LwVzeA5nEkjv
	 m2mYOdANauOKn78/QjnaVZN8Ti/7bc9vRxNaDR0yOJ/47+WNxrtFSfHRcPG6EABZRr
	 Ag+Z3bw7Lj99Q==
Date: Wed, 04 Sep 2024 08:36:47 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jingyi Wang <quic_jingyw@quicinc.com>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, Vinod Koul <vkoul@kernel.org>, 
 Zhenhua Huang <quic_zhenhuah@quicinc.com>, Andy Gross <agross@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Robin Murphy <robin.murphy@arm.com>, 
 Avri Altman <avri.altman@wdc.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, linux-arm-msm@vger.kernel.org, 
 Kyle Deng <quic_chunkaid@quicinc.com>, linux-kernel@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Tingguo Cheng <quic_tingguoc@quicinc.com>, linux-scsi@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Das Srinagesh <quic_gurus@quicinc.com>, iommu@lists.linux.dev, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Robert Marko <robimarko@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, Jassi Brar <jassisinghbrar@gmail.com>, 
 Bjorn Andersson <andersson@kernel.org>, linux-remoteproc@vger.kernel.org, 
 Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Lee Jones <lee@kernel.org>, Xin Liu <quic_liuxin@quicinc.com>, 
 Thomas Gleixner <tglx@linutronix.de>, linux-pm@vger.kernel.org, 
 Shazad Hussain <quic_shazhuss@quicinc.com>, linux-phy@lists.infradead.org, 
 Alim Akhtar <alim.akhtar@samsung.com>, Bart Van Assche <bvanassche@acm.org>, 
 devicetree@vger.kernel.org
In-Reply-To: <20240904-qcs8300_initial_dtsi-v1-0-d0ea9afdc007@quicinc.com>
References: <20240904-qcs8300_initial_dtsi-v1-0-d0ea9afdc007@quicinc.com>
Message-Id: <172545686260.2410635.12324465724634886770.robh@kernel.org>
Subject: Re: [PATCH 00/19] Add initial support for QCS8300


On Wed, 04 Sep 2024 16:33:41 +0800, Jingyi Wang wrote:
> Add initial support for QCS8300 SoC and QCS8300 RIDE board.
> 
> This revision brings support for:
> - CPUs with cpu idle
> - interrupt-controller with PDC wakeup support
> - gcc
> - TLMM
> - interconnect
> - qup with uart
> - smmu
> - pmic
> - ufs
> - ipcc
> - sram
> - remoteprocs including ADSP,CDSP and GPDSP
> 
> Signed-off-by: Jingyi Wang <quic_jingyw@quicinc.com>
> ---
> patch series organized as:
> - 1-2: remoteproc binding and driver
> - 3-5: ufs binding and driver
> - 6-7: rpmhpd binding and driver
> - 8-15: bindings for other components found on the SoC
> - 16-19: changes to support the device tree
> 
> dependencies:
> tlmm: https://lore.kernel.org/linux-arm-msm/20240819064933.1778204-1-quic_jingyw@quicinc.com/
> gcc: https://lore.kernel.org/all/20240820-qcs8300-gcc-v1-0-d81720517a82@quicinc.com/
> interconnect: https://lore.kernel.org/linux-arm-msm/20240827151622.305-1-quic_rlaggysh@quicinc.com/
> 
> dtb check got following err:
> /local/mnt/workspace/jingyi/aim500/linux/arch/arm64/boot/dts/qcom/qcs8300-ride.dtb: interconnect@1680000: Unevaluated properties are not allowed ('reg' was unexpected)
> which is cause by "reg" compatible missing in dt binding, will be fixed in interconnect patch series.
> 
> ---
> Jingyi Wang (11):
>       dt-bindings: remoteproc: qcom,sa8775p-pas: Document QCS8300 remoteproc
>       remoteproc: qcom: pas: Add QCS8300 remoteproc support
>       dt-bindings: qcom,pdc: document QCS8300 Power Domain Controller
>       dt-bindings: soc: qcom: add qcom,qcs8300-imem compatible
>       dt-bindings: mailbox: qcom-ipcc: Document QCS8300 IPCC
>       dt-bindings: mfd: qcom,tcsr: Add compatible for QCS8300
>       dt-bindings: nvmem: qfprom: Add compatible for QCS8300
>       dt-bindings: arm: qcom: document QCS8275/QCS8300 SoC and reference board
>       arm64: defconfig: enable clock controller, interconnect and pinctrl for QCS8300
>       arm64: dts: qcom: add initial support for QCS8300 DTSI
>       arm64: dts: qcom: add base QCS8300 RIDE dts
> 
> Kyle Deng (1):
>       dt-bindings: soc: qcom,aoss-qmp: Document the QCS8300 AOSS channel
> 
> Shazad Hussain (1):
>       dt-bindings: power: rpmpd: Add QCS8300 power domains
> 
> Tingguo Cheng (1):
>       pmdomain: qcom: rpmhpd: Add QCS8300 power domains
> 
> Xin Liu (3):
>       dt-bindings: phy: Add QMP UFS PHY comptible for QCS8300
>       dt-bindings: ufs: qcom: Document the QCS8300 UFS Controller
>       phy: qcom-qmp-ufs: Add support for QCS8300
> 
> Zhenhua Huang (2):
>       dt-bindings: arm-smmu: Add compatible for QCS8300 SoC
>       dt-bindings: firmware: qcom,scm: document SCM on QCS8300 SoCs
> 
>  Documentation/devicetree/bindings/arm/qcom.yaml    |    8 +
>  .../devicetree/bindings/firmware/qcom,scm.yaml     |    1 +
>  .../bindings/interrupt-controller/qcom,pdc.yaml    |    1 +
>  .../devicetree/bindings/iommu/arm,smmu.yaml        |    2 +
>  .../devicetree/bindings/mailbox/qcom-ipcc.yaml     |    1 +
>  .../devicetree/bindings/mfd/qcom,tcsr.yaml         |    1 +
>  .../devicetree/bindings/nvmem/qcom,qfprom.yaml     |    1 +
>  .../bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml    |    2 +
>  .../devicetree/bindings/power/qcom,rpmpd.yaml      |    1 +
>  .../bindings/remoteproc/qcom,sa8775p-pas.yaml      |    6 +
>  .../bindings/soc/qcom/qcom,aoss-qmp.yaml           |    1 +
>  .../devicetree/bindings/sram/qcom,imem.yaml        |    1 +
>  .../devicetree/bindings/ufs/qcom,ufs.yaml          |    2 +
>  arch/arm64/boot/dts/qcom/Makefile                  |    1 +
>  arch/arm64/boot/dts/qcom/qcs8300-ride.dts          |  246 ++++
>  arch/arm64/boot/dts/qcom/qcs8300.dtsi              | 1282 ++++++++++++++++++++
>  arch/arm64/configs/defconfig                       |    3 +
>  drivers/phy/qualcomm/phy-qcom-qmp-ufs.c            |    3 +
>  drivers/pmdomain/qcom/rpmhpd.c                     |   24 +
>  drivers/remoteproc/qcom_q6v5_pas.c                 |    3 +
>  include/dt-bindings/power/qcom-rpmpd.h             |   19 +
>  21 files changed, 1609 insertions(+)
> ---
> base-commit: eb8c5ca373cbb018a84eb4db25c863302c9b6314
> change-id: 20240829-qcs8300_initial_dtsi-1a386eb317d3
> 
> Best regards,
> --
> Jingyi Wang <quic_jingyw@quicinc.com>
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


New warnings running 'make CHECK_DTBS=y qcom/qcs8300-ride.dtb' for 20240904-qcs8300_initial_dtsi-v1-0-d0ea9afdc007@quicinc.com:

In file included from arch/arm64/boot/dts/qcom/qcs8300-ride.dts:11:
arch/arm64/boot/dts/qcom/qcs8300.dtsi:6:10: fatal error: dt-bindings/clock/qcom,qcs8300-gcc.h: No such file or directory
    6 | #include <dt-bindings/clock/qcom,qcs8300-gcc.h>
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[3]: *** [scripts/Makefile.lib:434: arch/arm64/boot/dts/qcom/qcs8300-ride.dtb] Error 1
make[2]: *** [scripts/Makefile.build:490: arch/arm64/boot/dts/qcom] Error 2
make[2]: Target 'arch/arm64/boot/dts/qcom/qcs8300-ride.dtb' not remade because of errors.
make[1]: *** [/home/rob/proj/linux-dt-testing/Makefile:1390: qcom/qcs8300-ride.dtb] Error 2
make: *** [Makefile:224: __sub-make] Error 2
make: Target 'qcom/qcs8300-ride.dtb' not remade because of errors.






