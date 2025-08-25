Return-Path: <linux-pm+bounces-33053-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0587CB34DDD
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 23:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF5051A849F3
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 21:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3CC0298CA6;
	Mon, 25 Aug 2025 21:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UcgMEh3p"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E08628D836;
	Mon, 25 Aug 2025 21:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756156975; cv=none; b=LP3mZgZGTwygbRVKRYNKBKz1ZaLAf+ke/ZgXm7hI76LStoUX2vaXbswHRu36qLQ3S4QGBpspFVKnyYws0qaO/IlAZJBLMUcfXBXxnQXz4p/l5kGDrLsjctdVLRsWA4fRAT62hXQl1TS1dztMwycao+bmYUEWW09K+eYzEa36e9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756156975; c=relaxed/simple;
	bh=l+302sdoxhUbhMzKkT4wkwdq4eHKUpQjmtWZfxKoga8=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=e1RWEGt1XB1oUgw8C0e7B30RnCBIh76P9bG1phI+zUi7z/ujabZwsyEWfG/Li+cR5U21AHjCq+rW9Etzt+4ckPG+sFO0V4G0Rl7EK42AMnEyizwGAC49ebEJ/aShuCUUxOYBE8JnHcpZzRTa2zgJON84VPrwfb+xP1KjlGQ0Gjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UcgMEh3p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6B47C4CEED;
	Mon, 25 Aug 2025 21:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756156975;
	bh=l+302sdoxhUbhMzKkT4wkwdq4eHKUpQjmtWZfxKoga8=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=UcgMEh3p+CplQZ32HJ2eXNNfERFHlx365eJRZvmWsrUE8QEntcuBZdVWBWBjL6Fck
	 +uwxzDPaocOckAC/Q0YdbYr+xE/kKh/E+NLeDYF1RdVAAL08h6p0TIxvgoLk2hfbDB
	 ZpedqxOv/j02bonBagtjTvG+WOhcW/p+d7J4zqw9ESEKT7w9jrLh7F3tFEXUo3uESj
	 NNl5HjdOrcGIeOX7nZH8Xy7HGDVV9JCZ4edcm5RMfN3QSoy8Mk9JQf5l+OSdcKkd8n
	 KGGULcvX7dr46Ew4nmlswKf/6+jHQJOzLvk5mrkkQ8r6Eg9glMpjmQeg48exFXRMx1
	 urbRBOcojTj3Q==
Date: Mon, 25 Aug 2025 16:22:54 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-pm@vger.kernel.org, kernel@pengutronix.de, primoz.fiser@norik.com, 
 davem@davemloft.net, festevam@gmail.com, alexandre.torgue@foss.st.com, 
 Markus.Niebel@ew.tq-group.com, krzk+dt@kernel.org, shawnguo@kernel.org, 
 edumazet@google.com, devicetree@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, s.hauer@pengutronix.de, 
 linux-arm-kernel@lists.infradead.org, pabeni@redhat.com, Frank.Li@nxp.com, 
 kuba@kernel.org, othacehe@gnu.org, linux-kernel@vger.kernel.org, 
 alexander.stein@ew.tq-group.com, mcoquelin.stm32@gmail.com, 
 frieder.schrempf@kontron.de, conor+dt@kernel.org, linux@ew.tq-group.com, 
 imx@lists.linux.dev, andrew+netdev@lunn.ch, netdev@vger.kernel.org, 
 richardcochran@gmail.com
To: Joy Zou <joy.zou@nxp.com>
In-Reply-To: <20250825091223.1378137-1-joy.zou@nxp.com>
References: <20250825091223.1378137-1-joy.zou@nxp.com>
Message-Id: <175615562513.578111.8377939047997958239.robh@kernel.org>
Subject: Re: [PATCH v9 0/6] Add i.MX91 platform support


On Mon, 25 Aug 2025 17:12:17 +0800, Joy Zou wrote:
> The design of i.MX91 platform is very similar to i.MX93.
> Extracts the common parts in order to reuse code.
> 
> The mainly difference between i.MX91 and i.MX93 is as follows:
> - i.MX91 removed some clocks and modified the names of some clocks.
> - i.MX91 only has one A core.
> - i.MX91 has different pinmux.
> 
> ---
> Changes for v9:
> - rebased onto commit 0f4c93f7eb86 ("Add linux-next specific files for 20250822")
>   to align with latest changes.
> - there is no functional changes for these patches.
> - Link to v8: https://lore.kernel.org/imx/20250806114119.1948624-1-joy.zou@nxp.com/
> 
> Changes for v8:
> - add Reviewed-by tag for patch #2/3/4/5/6/7/8/9/11.
> - modify commit message for patch #10.
> - move imx91 before imx93 in Makefile for patch #6.
> - modify the commit message to keep wrap at 75 chars for patch #5.
> - Link to v7: https://lore.kernel.org/imx/20250728071438.2332382-1-joy.zou@nxp.com/
> 
> Changes for v7:
> - Optimize i.MX91 num_clks hardcode with ARRAY_SIZE()for patch #10.
> - Add new patch in order to optimize i.MX93 num_clks hardcode
>   with ARRAY_SIZE() for patch #9.
> - remove this unused comments for patch #6.
> - align all pinctrl value to the same column for patch #6.
> - add aliases because remove aliases from common dtsi for patch #6.
> - remove fec property eee-broken-1000t from imx91 and imx93 board dts
>   for patch #6 and #7.
> - The aliases are removed from common.dtsi because the imx93.dtsi
>   aliases are removed for patch #4.
> - Add new patch that move aliases from imx93.dtsi to board dts for
>   patch #3.
> - These aliases aren't common, so need to drop in imx93.dtsi for patch #3.
> - Only add aliases using to imx93 board dts for patch #3.
> - patch #3 changes come from review comments:
>   https://lore.kernel.org/imx/4e8f2426-92a1-4c7e-b860-0e10e8dd886c@kernel.org/
> - add clocks constraints in the if-else branch for patch #2.
> - reorder the imx93 and imx91 if-else branch for patch #2.
> - patch #2 changes come from review comments:
>   https://lore.kernel.org/imx/urgfsmkl25woqy5emucfkqs52qu624po6rd532hpusg3fdnyg3@s5iwmhnfsi26/
> - add Reviewed-by tag for patch #2.
> - Link to v6: https://lore.kernel.org/imx/20250623095732.2139853-1-joy.zou@nxp.com/
> 
> Changes for v6:
> - add changelog in per patch.
> - correct commit message spell for patch #1.
> - merge rename imx93.dtsi to imx91_93_common.dtsi and move i.MX93
>   specific part from imx91_93_common.dtsi to imx93.dtsi for patch #3.
> - modify the commit message for patch #3.
> - restore copyright time and add modification time for common dtsi for
>   patch #3.
> - remove unused map0 label in imx91_93_common.dtsi for patch #3.
> - remove tmu related node for patch #4.
> - remove unused regulators and pinctrl settings for patch #5.
> - add new modification for aliases change patch #6.
> - Link to v5: https://lore.kernel.org/imx/20250613100255.2131800-1-joy.zou@nxp.com/
> 
> Changes for v5:
> - rename imx93.dtsi to imx91_93_common.dtsi.
> - move imx93 specific part from imx91_93_common.dtsi to imx93.dtsi.
> - modify the imx91.dtsi to use imx91_93_common.dtsi.
> - add new the imx93-blk-ctrl binding and driver patch for imx91 support.
> - add new net patch for imx91 support.
> - change node name codec and lsm6dsm into common name audio-codec and
>   inertial-meter, and add BT compatible string for imx91 board dts.
> - Link to v4: https://lore.kernel.org/imx/20250121074017.2819285-1-joy.zou@nxp.com/
> 
> Changes for v4:
> - Add one imx93 patch that add labels in imx93.dtsi
> - modify the references in imx91.dtsi
> - modify the code alignment
> - remove unused newline
> - delete the status property
> - align pad hex values
> - Link to v3: https://lore.kernel.org/imx/20241120094945.3032663-1-pengfei.li_1@nxp.com/
> 
> Changes for v3:
> - Add Conor's ack on patch #1
> - format imx91-11x11-evk.dts with the dt-format tool
> - add lpi2c1 node
> - Link to v2: https://lore.kernel.org/imx/20241118051541.2621360-1-pengfei.li_1@nxp.com/
> 
> Changes for v2:
> - change ddr node pmu compatible
> - remove mu1 and mu2
> - change iomux node compatible and enable 91 pinctrl
> - refine commit message for patch #2
> - change hex to lowercase in pinfunc.h
> - ordering nodes with the dt-format tool
> - Link to v1: https://lore.kernel.org/imx/20241108022703.1877171-1-pengfei.li_1@nxp.com/
> 
> Joy Zou (6):
>   arm64: dts: freescale: move aliases from imx93.dtsi to board dts
>   arm64: dts: freescale: rename imx93.dtsi to imx91_93_common.dtsi and
>     modify them
>   arm64: dts: imx91: add i.MX91 dtsi support
>   arm64: dts: freescale: add i.MX91 11x11 EVK basic support
>   arm64: dts: imx93-11x11-evk: remove fec property eee-broken-1000t
>   net: stmmac: imx: add i.MX91 support
> 
>  arch/arm64/boot/dts/freescale/Makefile        |    1 +
>  .../boot/dts/freescale/imx91-11x11-evk.dts    |  674 ++++++++
>  arch/arm64/boot/dts/freescale/imx91-pinfunc.h |  770 +++++++++
>  arch/arm64/boot/dts/freescale/imx91.dtsi      |   71 +
>  .../{imx93.dtsi => imx91_93_common.dtsi}      |  176 +-
>  .../boot/dts/freescale/imx93-11x11-evk.dts    |   20 +-
>  .../boot/dts/freescale/imx93-14x14-evk.dts    |   15 +
>  .../boot/dts/freescale/imx93-9x9-qsb.dts      |   18 +
>  .../dts/freescale/imx93-kontron-bl-osm-s.dts  |   21 +
>  .../dts/freescale/imx93-phyboard-nash.dts     |   21 +
>  .../dts/freescale/imx93-phyboard-segin.dts    |    9 +
>  .../freescale/imx93-tqma9352-mba91xxca.dts    |   11 +
>  .../freescale/imx93-tqma9352-mba93xxca.dts    |   25 +
>  .../freescale/imx93-tqma9352-mba93xxla.dts    |   25 +
>  .../dts/freescale/imx93-var-som-symphony.dts  |   17 +
>  arch/arm64/boot/dts/freescale/imx93.dtsi      | 1518 ++---------------
>  .../net/ethernet/stmicro/stmmac/dwmac-imx.c   |    2 +
>  17 files changed, 1863 insertions(+), 1531 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx91-11x11-evk.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/imx91-pinfunc.h
>  create mode 100644 arch/arm64/boot/dts/freescale/imx91.dtsi
>  copy arch/arm64/boot/dts/freescale/{imx93.dtsi => imx91_93_common.dtsi} (90%)
>  rewrite arch/arm64/boot/dts/freescale/imx93.dtsi (97%)
> 
> --
> 2.37.1
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
 Base: tags/v6.17-rc1-2-ge0a4a651f7c8 (best guess, 12/14 blobs matched)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/freescale/' for 20250825091223.1378137-1-joy.zou@nxp.com:

arch/arm64/boot/dts/freescale/imx91-11x11-evk.dtb: /: failed to match any schema with compatible: ['fsl,imx91-11x11-evk', 'fsl,imx91']
arch/arm64/boot/dts/freescale/imx91-11x11-evk.dtb: /: failed to match any schema with compatible: ['fsl,imx91-11x11-evk', 'fsl,imx91']
arch/arm64/boot/dts/freescale/imx91-11x11-evk.dtb: /soc@0/system-controller@4ac10000: failed to match any schema with compatible: ['fsl,imx91-media-blk-ctrl', 'syscon']






