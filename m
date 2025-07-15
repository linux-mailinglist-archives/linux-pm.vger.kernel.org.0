Return-Path: <linux-pm+bounces-30870-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F64CB06148
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jul 2025 16:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C42941C45212
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jul 2025 14:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6C11FBCAD;
	Tue, 15 Jul 2025 14:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t5dpuoqX"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0356E224F6;
	Tue, 15 Jul 2025 14:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752589559; cv=none; b=FGr82S7IQebT+P8CimeSpVdpb661oRvTfJeTrWx2oirPb7oWEHDnur01SwebxIZssQ+PCS10GQkloXo68Xu11e+/X4IaC64H3ZykAKKLokSa5qKZpVzP/D5o4c/os3ujQQPtOQXF+CGudQVPyy+hK+kyicBK/ABr8x2C8Hr3/RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752589559; c=relaxed/simple;
	bh=iEahhVfba6Uh9ffvi+66XYQ/OU06k9Gu0BMg3VvC2Dw=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=Ma5cpfhhOxtA5GwdQyJnsZ509NT9el9PHUpYqRmxm86Htmzt3gy4m+jAaqktdpQrfVvmKI8IZ9J1TgycwafnyXhdJv0JJCYfHH2eDU9cUZd/lBTC82YqpwF6AuWDszGMaqnzuwp9mzqTfgaYCri8Ar/4A4fYHnqhAcBkI68eers=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t5dpuoqX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E5C4C4CEE3;
	Tue, 15 Jul 2025 14:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752589558;
	bh=iEahhVfba6Uh9ffvi+66XYQ/OU06k9Gu0BMg3VvC2Dw=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=t5dpuoqXm6HVa3DBRG08lN+zmjj7BRPjRBIotcAnFz2Kq5zopaxX5NLR3uBb1hlAH
	 AXaV/8ucUW8TRpSk2ku8TmUAhGcYuY2LSIW9NGf+rV++vIvxCiDtk26aqCN2rljfcg
	 MredjEYKrOpVErVEpH34ISgFtTW6CA1/XSwZjEP4rTs5MKwh45oy23eK1jb5Ntg7cv
	 SqiGOM/wVil+HRhUisH9w0ygCHJEB5ckf0HoskDrG7dmzIu2jqltSYMXaso7C58iab
	 az435YjU5kLHCPUGrsDdGS8CwpBQmvdOAs7OfPcYTcXCv1EvYnbjAH4T4j5Z/Z7nMZ
	 obe/UUHUP4U3g==
Date: Tue, 15 Jul 2025 09:25:57 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Nagarjuna Kristam <nkristam@nvidia.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Thierry Reding <treding@nvidia.com>, 
 linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-clk@vger.kernel.org, 
 Peter De Schrijver <pdeschrijver@nvidia.com>, 
 Azkali Manad <a.ffcc7@gmail.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, JC Kuo <jckuo@nvidia.com>, 
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Prashant Gaikwad <pgaikwad@nvidia.com>, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Stephen Boyd <sboyd@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
 Mathias Nyman <mathias.nyman@intel.com>
To: Aaron Kling <webgeek1234@gmail.com>
In-Reply-To: <20250714-t210b01-v1-0-e3f5f7de5dce@gmail.com>
References: <20250714-t210b01-v1-0-e3f5f7de5dce@gmail.com>
Message-Id: <175258937492.1273515.15527524920490014931.robh@kernel.org>
Subject: Re: [PATCH 00/17] arm64: tegra: Add Tegra210B01 support


On Mon, 14 Jul 2025 23:02:43 -0500, Aaron Kling wrote:
> Also known as Tegra X1+, the Tegra210B01 has higher CPU and GPU clocks
> than the original Tegra210.
> 
> This series adds Tegra210B01 support to several drivers, as a slight
> extension to the existing Tegra210 support. Then adds a generic soc dtsi
> in the same vein as other tegra archs. And finally adds a barebones
> device dts to be used for dt checks. Further device support will be
> submitted in later series.
> 
> Earlier internal revisions of this series included changes to the dfll
> driver to support Tegra210B01, but those did not work in testing, thus
> was dropped from the series. A bindings update to match is still in the
> series so the soc dtsi can declare a separate compatible from Tegra210,
> preventing the driver from attempting incorrect initialization on
> Tegra210B01.
> 
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
> Aaron Kling (16):
>       dt-bindings: arm: tegra: pmc: Document Tegra210B01
>       dt-bindings: phy: tegra-xusb: Document Tegra210B01
>       dt-bindings: usb: tegra-xusb: Document Tegra210B01
>       dt-bindings: usb: tegra-xudc: Document Tegra210B01
>       dt-bindings: thermal: tegra: Document Tegra210B01
>       dt-bindings: clock: tegra: Document Tegra210B01
>       dt-bindings: clock: tegra124-dfll: Document Tegra210B01
>       dt-bindings: tegra: Document Shield TV 2019
>       phy: tegra: xusb: Add Tegra201B01 Support
>       usb: xhci: tegra: Add Tegra210B01 support
>       usb: gadget: tegra-xudc: Add Tegra210B01 Support
>       thermal: tegra: Add Tegra210B01 Support
>       clk: tegra: Add Tegra210B01 support
>       arm64: tegra: Add BPMP node for Tegra210
>       arm64: tegra: Add Tegra210B01 support
>       arm64: tegra: Add support for NVIDIA Shield TV Pro 2019
> 
> Azkali Manad (1):
>       soc/tegra: pmc: Add Tegra210B01 support
> 
>  Documentation/devicetree/bindings/arm/tegra.yaml   |    5 +
>  .../bindings/clock/nvidia,tegra124-dfll.txt        |    1 +
>  .../bindings/clock/nvidia,tegra20-car.yaml         |    1 +
>  .../bindings/phy/nvidia,tegra210-xusb-padctl.yaml  |    4 +-
>  .../bindings/soc/tegra/nvidia,tegra20-pmc.yaml     |    5 +-
>  .../bindings/thermal/nvidia,tegra124-soctherm.yaml |    2 +
>  .../devicetree/bindings/usb/nvidia,tegra-xudc.yaml |    2 +
>  .../bindings/usb/nvidia,tegra210-xusb.yaml         |    4 +-
>  arch/arm64/boot/dts/nvidia/Makefile                |    1 +
>  arch/arm64/boot/dts/nvidia/tegra210.dtsi           |   11 +
>  .../boot/dts/nvidia/tegra210b01-p2894-0050-a08.dts |   10 +
>  arch/arm64/boot/dts/nvidia/tegra210b01-p2894.dtsi  |   70 +
>  arch/arm64/boot/dts/nvidia/tegra210b01.dtsi        |   64 +
>  drivers/clk/tegra/Makefile                         |    1 +
>  drivers/clk/tegra/clk-tegra-periph.c               |    3 +
>  drivers/clk/tegra/clk-tegra210b01.c                | 3758 ++++++++++++++++++++
>  drivers/clk/tegra/clk-utils.c                      |    5 +-
>  drivers/clk/tegra/clk.c                            |   19 +-
>  drivers/clk/tegra/clk.h                            |    6 +
>  drivers/phy/tegra/xusb-tegra210.c                  |   41 +
>  drivers/phy/tegra/xusb.c                           |    4 +
>  drivers/phy/tegra/xusb.h                           |    1 +
>  drivers/soc/tegra/pmc.c                            |  117 +
>  drivers/thermal/tegra/soctherm.c                   |    4 +
>  drivers/thermal/tegra/soctherm.h                   |    1 +
>  drivers/thermal/tegra/tegra210-soctherm.c          |   78 +
>  drivers/usb/gadget/udc/tegra-xudc.c                |   20 +
>  drivers/usb/host/xhci-tegra.c                      |   25 +
>  include/dt-bindings/clock/tegra210-car.h           |    5 +-
>  29 files changed, 4261 insertions(+), 7 deletions(-)
> ---
> base-commit: 347e9f5043c89695b01e66b3ed111755afcf1911
> change-id: 20250509-t210b01-c154ca0f8994
> 
> Best regards,
> --
> Aaron Kling <webgeek1234@gmail.com>
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
 Base: using specified base-commit 347e9f5043c89695b01e66b3ed111755afcf1911

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/nvidia/' for 20250714-t210b01-v1-0-e3f5f7de5dce@gmail.com:

arch/arm64/boot/dts/nvidia/tegra210b01-p2894-0050-a08.dtb: /pcie@1003000: failed to match any schema with compatible: ['nvidia,tegra210-pcie']
arch/arm64/boot/dts/nvidia/tegra210b01-p2894-0050-a08.dtb: /host1x@50000000/tsec@54100000: failed to match any schema with compatible: ['nvidia,tegra210-tsec']
arch/arm64/boot/dts/nvidia/tegra210b01-p2894-0050-a08.dtb: /host1x@50000000/tsec@54500000: failed to match any schema with compatible: ['nvidia,tegra210-tsec']
arch/arm64/boot/dts/nvidia/tegra210b01-p2894-0050-a08.dtb: /gpu@57000000: failed to match any schema with compatible: ['nvidia,gm20b']
arch/arm64/boot/dts/nvidia/tegra210b01-p2894-0050-a08.dtb: /interrupt-controller@60004000: failed to match any schema with compatible: ['nvidia,tegra210-ictlr']
arch/arm64/boot/dts/nvidia/tegra210b01-p2894-0050-a08.dtb: /dma@60020000: failed to match any schema with compatible: ['nvidia,tegra210-apbdma', 'nvidia,tegra148-apbdma']
arch/arm64/boot/dts/nvidia/tegra210b01-p2894-0050-a08.dtb: /dma@60020000: failed to match any schema with compatible: ['nvidia,tegra210-apbdma', 'nvidia,tegra148-apbdma']
arch/arm64/boot/dts/nvidia/tegra210b01-p2894-0050-a08.dtb: /bpmp@70016000: failed to match any schema with compatible: ['nvidia,tegra210-bpmp']
arch/arm64/boot/dts/nvidia/tegra210b01-p2894-0050-a08.dtb: /memory-controller@70019000: failed to match any schema with compatible: ['nvidia,tegra210-mc']
arch/arm64/boot/dts/nvidia/tegra210b01-p2894-0050-a08.dtb: external-memory-controller@7001b000 (nvidia,tegra210-emc): '#cooling-cells' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/memory-controllers/nvidia,tegra210-emc.yaml#
arch/arm64/boot/dts/nvidia/tegra210b01-p2894-0050-a08.dtb: /clock@70110000: failed to match any schema with compatible: ['nvidia,tegra210b01-dfll']
arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dtb: /bpmp@70016000: failed to match any schema with compatible: ['nvidia,tegra210-bpmp']
arch/arm64/boot/dts/nvidia/tegra210b01-p2894-0050-a08.dtb: usb-phy@7d000000 (nvidia,tegra210-usb-phy): compatible: 'oneOf' conditional failed, one must be fixed:
	['nvidia,tegra210-usb-phy', 'nvidia,tegra30-usb-phy'] is too long
	'nvidia,tegra210-usb-phy' is not one of ['nvidia,tegra124-usb-phy', 'nvidia,tegra114-usb-phy']
	'nvidia,tegra210-usb-phy' is not one of ['nvidia,tegra30-usb-phy', 'nvidia,tegra20-usb-phy']
	from schema $id: http://devicetree.org/schemas/phy/nvidia,tegra20-usb-phy.yaml#
arch/arm64/boot/dts/nvidia/tegra210b01-p2894-0050-a08.dtb: /usb-phy@7d000000: failed to match any schema with compatible: ['nvidia,tegra210-usb-phy', 'nvidia,tegra30-usb-phy']
arch/arm64/boot/dts/nvidia/tegra210b01-p2894-0050-a08.dtb: usb-phy@7d004000 (nvidia,tegra210-usb-phy): compatible: 'oneOf' conditional failed, one must be fixed:
	['nvidia,tegra210-usb-phy', 'nvidia,tegra30-usb-phy'] is too long
	'nvidia,tegra210-usb-phy' is not one of ['nvidia,tegra124-usb-phy', 'nvidia,tegra114-usb-phy']
	'nvidia,tegra210-usb-phy' is not one of ['nvidia,tegra30-usb-phy', 'nvidia,tegra20-usb-phy']
	from schema $id: http://devicetree.org/schemas/phy/nvidia,tegra20-usb-phy.yaml#
arch/arm64/boot/dts/nvidia/tegra210b01-p2894-0050-a08.dtb: /usb-phy@7d004000: failed to match any schema with compatible: ['nvidia,tegra210-usb-phy', 'nvidia,tegra30-usb-phy']
arch/arm64/boot/dts/nvidia/tegra210b01-p2894-0050-a08.dtb: cpu@0 (arm,cortex-a57): 'operating-points' is a dependency of 'clock-latency'
	from schema $id: http://devicetree.org/schemas/arm/cpus.yaml#
arch/arm64/boot/dts/nvidia/tegra210b01-p2894-0050-a08.dtb: cpu@0 (arm,cortex-a57): Unevaluated properties are not allowed ('clock-latency' was unexpected)
	from schema $id: http://devicetree.org/schemas/arm/cpus.yaml#
arch/arm64/boot/dts/nvidia/tegra210b01-p2894-0050-a08.dtb: thermal-zones: mem-thermal:cooling-maps: 'dram-active', 'dram-passive' do not match any of the regexes: '^map[-a-zA-Z0-9]*$', '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/thermal/thermal-zones.yaml#
arch/arm64/boot/dts/nvidia/tegra210-p2371-0000.dtb: /bpmp@70016000: failed to match any schema with compatible: ['nvidia,tegra210-bpmp']
arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dtb: /bpmp@70016000: failed to match any schema with compatible: ['nvidia,tegra210-bpmp']
arch/arm64/boot/dts/nvidia/tegra210-smaug.dtb: /bpmp@70016000: failed to match any schema with compatible: ['nvidia,tegra210-bpmp']
arch/arm64/boot/dts/nvidia/tegra210-p2571.dtb: /bpmp@70016000: failed to match any schema with compatible: ['nvidia,tegra210-bpmp']
arch/arm64/boot/dts/nvidia/tegra210-p2894-0050-a08.dtb: /bpmp@70016000: failed to match any schema with compatible: ['nvidia,tegra210-bpmp']






