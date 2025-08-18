Return-Path: <linux-pm+bounces-32577-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 685D6B2B035
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 20:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AE686836CF
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 18:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E922D24BF;
	Mon, 18 Aug 2025 18:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YyAhz2Kf"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C914C2D24AC;
	Mon, 18 Aug 2025 18:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755541483; cv=none; b=EIrYvU6pUa5W68ZA2haeWnvhmLV09AH5vcUG1n6fwkZ4K5TLTCyGH+guCDIQcvo8/+SbBKmCCiDGSlyj9nqCckyUQ1Fnuo6BWaYpjNC9ZagxGRgZpywC+nGsPBVyyTy/+0sRzwK/e9elFQvN4ofRXV0bb+r0jAAEh4IsBuCxMlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755541483; c=relaxed/simple;
	bh=e0T6uswFPCYymAbe+gdn+JgFiwh+mCDg31acddcY9C8=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=i2bb+PdhRSzbJ+ydrAiXFyvwgVJr0NjA+DVArVeX3jPecIaL39BBxuB0jID1JsFQF5qIUiqr/KZfjMbqe7pfb+B+z8Ol5dQbYTiD22hmGF1M6fy2JCEH69Vu9Meqm1tcBa2So2oPHA8lJEbE/KHkSJ7QkL2aEY02ayXT8jscK+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YyAhz2Kf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DCB0C4CEED;
	Mon, 18 Aug 2025 18:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755541483;
	bh=e0T6uswFPCYymAbe+gdn+JgFiwh+mCDg31acddcY9C8=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=YyAhz2KfF1h8FYPqMG/TZLyTRI42YbxfLuR/fd/nIXbkFzZwmge1E+g6l47gnf5sC
	 +5lnHt2jA16KJ1RsY8noWIlQDkxDE1jFb13EvoapqzLdmJUiEUs1dlTUPf2owgimgN
	 Fb6iYXKEkRq3clh8TDWaETgufk1gCFPwusdbpavmUhl5tiJCGDXeUWPIBoh0UYBaTp
	 0zRwUdzdeRJqH5XfNwC1KJb0X/Ezm8lnFtR37qDVMosbeU2Le1+TJk0x6yvsi3prKQ
	 viYSLwyNZd6wEAk30hPstCfGUbqmQq1B2a9i43jyS1QD/oqiwWRBnRdjH5byLWr71h
	 i8NF8UVcg1yRw==
Date: Mon, 18 Aug 2025 13:24:42 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: daniel.lezcano@linaro.org, krzk+dt@kernel.org, rafael@kernel.org, 
 geert+renesas@glider.be, linux-pm@vger.kernel.org, 
 biju.das.jz@bp.renesas.com, mturquette@baylibre.com, 
 linux-kernel@vger.kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com, 
 sboyd@kernel.org, linux-renesas-soc@vger.kernel.org, conor+dt@kernel.org, 
 will@kernel.org, magnus.damm@gmail.com, john.madieu@gmail.com, 
 linux-arm-kernel@lists.infradead.org, p.zabel@pengutronix.de, 
 devicetree@vger.kernel.org, catalin.marinas@arm.com
To: John Madieu <john.madieu.xa@bp.renesas.com>
In-Reply-To: <20250818162859.9661-1-john.madieu.xa@bp.renesas.com>
References: <20250818162859.9661-1-john.madieu.xa@bp.renesas.com>
Message-Id: <175554055722.1719725.13076334498195294379.robh@kernel.org>
Subject: Re: [PATCH v7 0/6] thermal: renesas: Add support for RZ/G3E


On Mon, 18 Aug 2025 18:28:46 +0200, John Madieu wrote:
> This series adds support for the temperature sensor unit (TSU) found on the
> Renesas RZ/G3E SoC.
> 
> The series consists of 5 patches (one of which is not related to the thermal
> framework) that progressively add TSU support as follows:
> - patch 1/6:    adds syscon/regmap support for accessing system controller
>                 registers, enabling access to TSU calibration values
> 
> - patch 2-6/6:  adds dt-bindings, actual driver, DT node, and config symbol.
> 
> Patch 1/6 has been duplicated at [1] in USB series. This series addresses comments
> got from there.
> 
> Changes:
> 
> v1 -> v2
>  * Fix yaml warnings from dt-binding
>  * Update IRQ names to reflect TSU expectations
> 
> v2 -> v3
>  * Remove useless 'renesas,tsu-operating-mode' property
> 
> v3 -> v4
>  * Improve commit messages
> 
> v4 -> v5
>  * Remove useless curly braces on single line-protected scoped guards
> 
> v5 -> v6
>  * Minor typo fix
>  * Constify regmap config in patch 1/5
> 
> v6 -> v7
>  * Update DTS trim priperty name and specifier, updading the documentation
>  accordingly
>  * Refactor main driver: remove spinlock usage, using polling timeout as computed
>  from datasheet. Also use polling for get_temp() while using IRQ for trip-point
>  cross detection, and finally add both runtime and sleep PM support.
>  * Add new patch to update sys #address-cells as trim specifier now requires an
>  offet from sys base
> 
> Regards,
> 
> [1] https://lore.kernel.org/all/20250808061806.2729274-2-claudiu.beznea.uj@bp.renesas.com/
> 
> 
> John Madieu (6):
>   soc: renesas: rz-sysc: Add syscon/regmap support
>   dt-bindings: thermal: r9a09g047-tsu: Document the TSU unit
>   thermal: renesas: rzg3e: Add thermal driver for the Renesas RZ/G3E SoC
>   arm64: dts: renesas: r9a09g047: Add #address-cells property in sys
>     node
>   arm64: dts: renesas: r9a09g047: Add TSU node
>   arm64: defconfig: Enable the Renesas RZ/G3E thermal driver
> 
>  .../thermal/renesas,r9a09g047-tsu.yaml        |  87 +++
>  MAINTAINERS                                   |   7 +
>  arch/arm64/boot/dts/renesas/r9a09g047.dtsi    |  49 ++
>  arch/arm64/configs/defconfig                  |   1 +
>  drivers/soc/renesas/Kconfig                   |   1 +
>  drivers/soc/renesas/r9a08g045-sysc.c          |   1 +
>  drivers/soc/renesas/r9a09g047-sys.c           |   1 +
>  drivers/soc/renesas/r9a09g057-sys.c           |   1 +
>  drivers/soc/renesas/rz-sysc.c                 |  28 +-
>  drivers/soc/renesas/rz-sysc.h                 |   2 +
>  drivers/thermal/renesas/Kconfig               |   7 +
>  drivers/thermal/renesas/Makefile              |   1 +
>  drivers/thermal/renesas/rzg3e_thermal.c       | 575 ++++++++++++++++++
>  13 files changed, 760 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml
>  create mode 100644 drivers/thermal/renesas/rzg3e_thermal.c
> 
> --
> 2.25.1
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
 Base: attempting to guess base-commit...
 Base: tags/v6.17-rc1-12-g0a0e0852f3f3 (best guess, 10/11 blobs matched)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/renesas/' for 20250818162859.9661-1-john.madieu.xa@bp.renesas.com:

arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dtb: system-controller@10430000 (renesas,r9a09g047-sys): '#address-cells' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/soc/renesas/renesas,r9a09g057-sys.yaml#






