Return-Path: <linux-pm+bounces-30057-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A69FFAF7886
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 16:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1797A1891695
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 14:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D9B2E7BBF;
	Thu,  3 Jul 2025 14:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UOPfgh3Q"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3E3126BFF;
	Thu,  3 Jul 2025 14:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751554210; cv=none; b=NTCbOCSaYEBTZFnbMhyr/bKUrI7y8y+GEr8JrriXovIbp7qCUdEA1a0pxThorMWmGkpOIbDM/w1TKVB44KzqP3ENjwDG2n+oNkTtduLBQCDf9KrYSaKarZMHdDcnL+83XOSV8t2ByOMcwGp61ojRyxI9nPoj8R83+MQ1VubTx6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751554210; c=relaxed/simple;
	bh=F7RvP/tiiiQNXxTLIP1aaIsmsYJmGxBSXe+6aPe6DVM=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=smUGCWlzL83y0lQHEUdVcfiRIbPzLObS3gCmZirUwY7GIB2qKaw8C3y9w68kuRHEQE1Lta8m2QnZhUFxD85VbdpVgS2utxXXpzj7B7oLQXqviZYndko6fWq7G+pmjsWV2yFA72qix/vlXLmQb/JRPaASay0W9NZU45+01aBmv4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UOPfgh3Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14886C4CEE3;
	Thu,  3 Jul 2025 14:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751554210;
	bh=F7RvP/tiiiQNXxTLIP1aaIsmsYJmGxBSXe+6aPe6DVM=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=UOPfgh3QO0BLF3AWsS2lAqyghScbGjFU+/fNQdrJzJjF3i16KZFUoItNwMxmSiyIH
	 UoWUWUxeIlT8yoHROjjmKGDfSobSfzfhx3WlexkT9sZ9hDvgp+JLfIbtzqduG5qU+1
	 X7vQvVi1lMnjgPNhVUiGGM4Ycim7gCy28QllTw1VllKAQfBt030P7oh4qKSuvY2K/n
	 9EWBGaIoOmz8dLQa4rFtJePbuaspcTHxpdXIDwGAUuIIGXA/GPoEDqiHO9X2Wlk/10
	 30Po9bzBXbRRDgMtTUbN8zQEv7biSiZTuRQ0TUUBAC9Rx+qHlUBYMMviuDgJ212t1q
	 v+LjV//qCvdtw==
Date: Thu, 03 Jul 2025 09:50:09 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: y.oudjana@protonmail.com, conor+dt@kernel.org, lihongbo22@huawei.com, 
 mandyjh.liu@mediatek.com, matthias.bgg@gmail.com, linux-pm@vger.kernel.org, 
 wenst@chromium.org, linux-arm-kernel@lists.infradead.org, 
 krzk+dt@kernel.org, linux-mediatek@lists.infradead.org, 
 devicetree@vger.kernel.org, mbrugger@suse.com, kernel@collabora.com, 
 linux-kernel@vger.kernel.org, ulf.hansson@linaro.org, fshao@chromium.org
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20250703110247.99927-1-angelogioacchino.delregno@collabora.com>
References: <20250703110247.99927-1-angelogioacchino.delregno@collabora.com>
Message-Id: <175155413560.1472431.15279781929013873275.robh@kernel.org>
Subject: Re: [PATCH 00/10] pmdomain: Partial refactor, support modem and
 RTFF


On Thu, 03 Jul 2025 13:02:37 +0200, AngeloGioacchino Del Regno wrote:
> This series is a subset of [1], leaving out the Hardware Voter specific
> bits for MT8196 until the discussion around it reaches a conclusion.
> 
> Even though the proposed code was born as a preparation to support the
> MT8196/MT6991 SoCs power domain controllers, it is a necessary cleanup
> for all power domain controllers of all of the currently supported SoCs
> from MediaTek.
> 
> You may also notice the addition of support for modem power sequences:
> this was brought up 6 months ago (or more) by community contributors
> (mainly Yassine Oudjana) that were trying to upstream the MediaTek
> MT6735 Smartphone SoC and needed support to provide power to the MD
> subsystem - so, even though in this specific series the code for the
> modem power sequence is not yet triggered by any SoC, please please
> please, let it in.
> Besides, "a bunch" of upstream supported SoCs do have the MD power
> domain even though it wasn't added to their drivers (because if there
> was no support in the driver, it would just crash the system); the
> addition is something that I plan to do at some point, but definitely
> not now as I have no bandwidth for that (bar MT8196, which will have
> this domain).
> 
> Compared to v1 in [1]:
>  - Changed mediatek,bus-protection to access-controllers
>    as suggested by Rob (thanks!)
>  - Added commits to document #access-controller-cells on all of
>    the access control providers
> 
> In the meanwhile.... relevant excerpt from the old series:
> 
> This series refactors the bus protection regmaps retrieval to avoid
> searching in all power domain devicetree subnodes for vendor properties
> to get syscons for different busses, and adds a new property which is
> located in the power controller root node containing handles to the same.
> 
> Retrocompatibility is retained and was tested on multiple SoCs in the
> Collabora lab - specifically, on Genio 350/510/700/1200, and manually
> on MT6795 Helio (Xperia M5 Smartphone), MT8186, MT8192 and MT8195
> Chromebooks.
> 
> This was tested *three times*:
>  - Before the per-SoC conversion in drivers/pmdomain/mediatek
>  - With per-SoC conversion code but with *legacy* devicetree
>  - With per-SoC conversion code and with *new* devicetree conversion
> 
> All of those tests were successful on all of the aforementioned SoCs.
> 
> This also adds support for:
>  - Modem power domain for both old and new MediaTek SoCs, useful for
>    bringing up the GSM/3G/4G/5G modem for both laptop and smartphone use
>  - RTFF MCU HW, as found in MT8196 Chromebooks and MT6991 Dimensity 9400
> 
> ...and prepares the pmdomain code to accomodate only the directly
> controlled power domains for MT8196 (HW Voter support was left out).
> 
> [1] https://lore.kernel.org/all/20250623120154.109429-1-angelogioacchino.delregno@collabora.com
> 
> AngeloGioacchino Del Regno (10):
>   dt-bindings: memory: mtk-smi: Document #access-controller-cells
>   dt-bindings: clock: mediatek: Document #access-controller-cells
>   dt-bindings: power: mediatek: Document access-controllers property
>   pmdomain: mediatek: Refactor bus protection regmaps retrieval
>   pmdomain: mediatek: Handle SoCs with inverted SRAM power-down bits
>   pmdomain: mediatek: Move ctl sequences out of power_on/off functions
>   pmdomain: mediatek: Add support for modem power sequences
>   pmdomain: mediatek: Add support for RTFF Hardware in MT8196/MT6991
>   pmdomain: mediatek: Convert all SoCs to new style regmap retrieval
>   arm64: dts: mediatek: Convert all SoCs to use access-controllers
> 
>  .../bindings/clock/mediatek,infracfg.yaml     |   3 +
>  .../clock/mediatek,mt8186-sys-clock.yaml      |  15 +
>  .../clock/mediatek,mt8192-sys-clock.yaml      |  15 +
>  .../clock/mediatek,mt8365-sys-clock.yaml      |  15 +
>  .../mediatek,smi-common.yaml                  |  16 +
>  .../power/mediatek,power-controller.yaml      |  39 ++
>  arch/arm64/boot/dts/mediatek/mt6795.dtsi      |   5 +-
>  arch/arm64/boot/dts/mediatek/mt8167.dtsi      |   6 +-
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi      |   4 +-
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi      |  17 +-
>  arch/arm64/boot/dts/mediatek/mt8186.dtsi      |  12 +-
>  arch/arm64/boot/dts/mediatek/mt8188.dtsi      |  23 +-
>  arch/arm64/boot/dts/mediatek/mt8192.dtsi      |  13 +-
>  arch/arm64/boot/dts/mediatek/mt8195.dtsi      |  20 +-
>  arch/arm64/boot/dts/mediatek/mt8365.dtsi      |  16 +-
>  drivers/pmdomain/mediatek/mt6795-pm-domains.h |   5 +
>  drivers/pmdomain/mediatek/mt8167-pm-domains.h |   5 +
>  drivers/pmdomain/mediatek/mt8173-pm-domains.h |   5 +
>  drivers/pmdomain/mediatek/mt8183-pm-domains.h |   5 +
>  drivers/pmdomain/mediatek/mt8186-pm-domains.h |   5 +
>  drivers/pmdomain/mediatek/mt8188-pm-domains.h |   6 +
>  drivers/pmdomain/mediatek/mt8192-pm-domains.h |   5 +
>  drivers/pmdomain/mediatek/mt8195-pm-domains.h |   5 +
>  drivers/pmdomain/mediatek/mt8365-pm-domains.h |  14 +-
>  drivers/pmdomain/mediatek/mtk-pm-domains.c    | 399 +++++++++++++++---
>  drivers/pmdomain/mediatek/mtk-pm-domains.h    |  74 +++-
>  26 files changed, 566 insertions(+), 181 deletions(-)
> 
> --
> 2.49.0
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
 Base: tags/next-20250703 (exact match)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/mediatek/' for 20250703110247.99927-1-angelogioacchino.delregno@collabora.com:

arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dtb: syscon@10001000 (mediatek,mt8195-infracfg_ao): '#access-controller-cells' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/clock/mediatek,mt8195-sys-clock.yaml#
arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dtb: syscon@10001000 (mediatek,mt8195-infracfg_ao): '#access-controller-cells' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/clock/mediatek,mt8195-sys-clock.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku4.dtb: syscon@10001000 (mediatek,mt8188-infracfg-ao): '#access-controller-cells' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/clock/mediatek,mt8188-sys-clock.yaml#
arch/arm64/boot/dts/mediatek/mt8370-genio-510-evk.dtb: syscon@10001000 (mediatek,mt8188-infracfg-ao): '#access-controller-cells' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/clock/mediatek,mt8188-sys-clock.yaml#
arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dtb: syscon@10001000 (mediatek,mt8188-infracfg-ao): '#access-controller-cells' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/clock/mediatek,mt8188-sys-clock.yaml#
arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dtb: mt8192-afe-pcm (mediatek,mt8192-audio): clocks: [[59, 0], [59, 7], [59, 8], [59, 6], [59, 21], [59, 1], [59, 2], [59, 4], [59, 3], [59, 5], [59, 9], [59, 10], [59, 18], [59, 19], [59, 20], [59, 22], [59, 23], [59, 24], [59, 25], [59, 26], [22, 47], [22, 58], [23, 27], [23, 28], [23, 72], [23, 47], [23, 101], [23, 48], [23, 105], [23, 43], [23, 103], [23, 44], [23, 107], [23, 59], [23, 60], [23, 61], [23, 62], [23, 63], [23, 64], [23, 65], [23, 66], [23, 67], [23, 68], [23, 142], [23, 143], [23, 144], [23, 145], [23, 146], [23, 147], [23, 148], [23, 149], [23, 150], [23, 151], [23, 152], [23, 55], [2]] is too long
	from schema $id: http://devicetree.org/schemas/sound/mt8192-afe-pcm.yaml#
arch/arm64/boot/dts/mediatek/mt8395-kontron-3-5-sbc-i1200.dtb: syscon@10001000 (mediatek,mt8195-infracfg_ao): '#access-controller-cells' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/clock/mediatek,mt8195-sys-clock.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku1.dtb: syscon@10001000 (mediatek,mt8188-infracfg-ao): '#access-controller-cells' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/clock/mediatek,mt8188-sys-clock.yaml#
arch/arm64/boot/dts/mediatek/mt8195-demo.dtb: syscon@10001000 (mediatek,mt8195-infracfg_ao): '#access-controller-cells' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/clock/mediatek,mt8195-sys-clock.yaml#
arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dtb: mt8192-afe-pcm (mediatek,mt8192-audio): clocks: [[56, 0], [56, 7], [56, 8], [56, 6], [56, 21], [56, 1], [56, 2], [56, 4], [56, 3], [56, 5], [56, 9], [56, 10], [56, 18], [56, 19], [56, 20], [56, 22], [56, 23], [56, 24], [56, 25], [56, 26], [22, 47], [22, 58], [23, 27], [23, 28], [23, 72], [23, 47], [23, 101], [23, 48], [23, 105], [23, 43], [23, 103], [23, 44], [23, 107], [23, 59], [23, 60], [23, 61], [23, 62], [23, 63], [23, 64], [23, 65], [23, 66], [23, 67], [23, 68], [23, 142], [23, 143], [23, 144], [23, 145], [23, 146], [23, 147], [23, 148], [23, 149], [23, 150], [23, 151], [23, 152], [23, 55], [2]] is too long
	from schema $id: http://devicetree.org/schemas/sound/mt8192-afe-pcm.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku7.dtb: syscon@10001000 (mediatek,mt8188-infracfg-ao): '#access-controller-cells' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/clock/mediatek,mt8188-sys-clock.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku3.dtb: syscon@10001000 (mediatek,mt8188-infracfg-ao): '#access-controller-cells' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/clock/mediatek,mt8188-sys-clock.yaml#
arch/arm64/boot/dts/mediatek/mt8188-evb.dtb: syscon@10001000 (mediatek,mt8188-infracfg-ao): '#access-controller-cells' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/clock/mediatek,mt8188-sys-clock.yaml#
arch/arm64/boot/dts/mediatek/mt8195-evb.dtb: syscon@10001000 (mediatek,mt8195-infracfg_ao): '#access-controller-cells' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/clock/mediatek,mt8195-sys-clock.yaml#
arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dtb: syscon@10001000 (mediatek,mt8195-infracfg_ao): '#access-controller-cells' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/clock/mediatek,mt8195-sys-clock.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku6.dtb: syscon@10001000 (mediatek,mt8188-infracfg-ao): '#access-controller-cells' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/clock/mediatek,mt8188-sys-clock.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku0.dtb: syscon@10001000 (mediatek,mt8188-infracfg-ao): '#access-controller-cells' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/clock/mediatek,mt8188-sys-clock.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku2.dtb: syscon@10001000 (mediatek,mt8188-infracfg-ao): '#access-controller-cells' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/clock/mediatek,mt8188-sys-clock.yaml#
arch/arm64/boot/dts/mediatek/mt8195-cherry-dojo-r1.dtb: syscon@10001000 (mediatek,mt8195-infracfg_ao): '#access-controller-cells' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/clock/mediatek,mt8195-sys-clock.yaml#
arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dtb: syscon@10001000 (mediatek,mt8195-infracfg_ao): '#access-controller-cells' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/clock/mediatek,mt8195-sys-clock.yaml#
arch/arm64/boot/dts/mediatek/mt8192-evb.dtb: mt8192-afe-pcm (mediatek,mt8192-audio): clocks: [[45, 0], [45, 7], [45, 8], [45, 6], [45, 21], [45, 1], [45, 2], [45, 4], [45, 3], [45, 5], [45, 9], [45, 10], [45, 18], [45, 19], [45, 20], [45, 22], [45, 23], [45, 24], [45, 25], [45, 26], [22, 47], [22, 58], [23, 27], [23, 28], [23, 72], [23, 47], [23, 101], [23, 48], [23, 105], [23, 43], [23, 103], [23, 44], [23, 107], [23, 59], [23, 60], [23, 61], [23, 62], [23, 63], [23, 64], [23, 65], [23, 66], [23, 67], [23, 68], [23, 142], [23, 143], [23, 144], [23, 145], [23, 146], [23, 147], [23, 148], [23, 149], [23, 150], [23, 151], [23, 152], [23, 55], [2]] is too long
	from schema $id: http://devicetree.org/schemas/sound/mt8192-afe-pcm.yaml#
arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dtb: syscon@10001000 (mediatek,mt8195-infracfg_ao): '#access-controller-cells' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/clock/mediatek,mt8195-sys-clock.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku5.dtb: syscon@10001000 (mediatek,mt8188-infracfg-ao): '#access-controller-cells' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/clock/mediatek,mt8188-sys-clock.yaml#






