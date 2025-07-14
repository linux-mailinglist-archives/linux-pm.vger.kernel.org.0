Return-Path: <linux-pm+bounces-30809-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C246FB043D4
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jul 2025 17:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFBF81639B6
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jul 2025 15:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66AD2263F36;
	Mon, 14 Jul 2025 15:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MnMay5B4"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B476263C90;
	Mon, 14 Jul 2025 15:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752506672; cv=none; b=EUsYqkAwI9mKX9xicryQqhdNaupfj1s5Yd8bnayz0Efy9JkLAOYwK36J7MtUWAeap/hoWRAGR/3rDzLu0Obh4dPtGOV/qivos07WYlsmDOeEfPUq1XlQpdAuKoE4enVpX6/tFmOtZQeKv6nh2NDYdV5wEkkeT1C0rCxvvA4N8n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752506672; c=relaxed/simple;
	bh=jmQpWZpxE51V1zI7ZcpOFojkr0HJooLaU1IlITgogwg=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=kjUToPk+sV14QYyuxeEG2p88aXhXospmL1E6CMpiUtC//kni6JIUMplf4JAUYgWiGApRsqxJfajJ0+gfCQatXa0GUdwH8EWaqBzjsyUgPeq4i4LpYoZCTWMy1vpudrV4fduQUJFjf9p0d/u5Jh6tVDuRQhpIMSSb6Q8aSrxguu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MnMay5B4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A18C9C4CEED;
	Mon, 14 Jul 2025 15:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752506671;
	bh=jmQpWZpxE51V1zI7ZcpOFojkr0HJooLaU1IlITgogwg=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=MnMay5B4uXIGs9rEPEG9MmjC8izp0qe6VSr0AYMqAyVGTPCSbzaeyAIqyFDtjLjv7
	 6CwdDSiz4MVPmRU/Ts8Zhhy5J4a0Us+MYQ7fSCwl1o2UZzHR1WgjBARS+4bxQ1VDQ5
	 V9mTpDUbegvQsbExfgMRDM+cmTwQxR7b6jSf/ClNtHPvndvmAxQsMaKNgosMNOe9+C
	 LKKZobXq7YScJ7vS9qmSHFiLa6m0b/xHEc0lHamc1oH6bA9ZOUBKXqadhjKgw3zvNY
	 kYqcQun9vGNEvaOEikOSX8Ph/ZioOGEK0xtNmUOsN765cMbN1MedZnTxSg6tH0iZll
	 4vSKhHMVm5jVg==
Date: Mon, 14 Jul 2025 10:24:31 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: s.hauer@pengutronix.de, conor+dt@kernel.org, krzk+dt@kernel.org, 
 linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org, 
 angelogioacchino.delregno@collabora.com, rafal@milecki.pl, 
 rafael@kernel.org, linux-mediatek@lists.infradead.org, 
 devicetree@vger.kernel.org, matthias.bgg@gmail.com, rui.zhang@intel.com, 
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
 lukasz.luba@arm.com
To: Aleksander Jan Bajkowski <olek2@wp.pl>
In-Reply-To: <20250712195904.6988-1-olek2@wp.pl>
References: <20250712195904.6988-1-olek2@wp.pl>
Message-Id: <175250104102.2052726.927170028799402599.robh@kernel.org>
Subject: Re: [PATCH v4 0/2] Add thermal sensors support for MT7981


On Sat, 12 Jul 2025 21:59:02 +0200, Aleksander Jan Bajkowski wrote:
> This patch adds support for the temperature sensor in the MT7981 SoC.
> This sensor is exactly the same as the one in the MT7986.
> 
> Changes in v4:
>  - sorted bindings by fallback names
>  - dropped accepted patch
> 
> Changes in v3:
>  - added fallback in bindings
> 
> Changes in v2:
>  - added fallback to an existing compatible string
>  - removed second patch as obsolete
> 
> Aleksander Jan Bajkowski (2):
>   dt-bindings: thermal: mediatek: add falback compatible string for
>     MT7981 and MT8516
>   arm64: dts: mediatek: add thermal sensor support on mt7981
> 
>  .../bindings/thermal/mediatek,thermal.yaml    | 27 ++++++++++------
>  arch/arm64/boot/dts/mediatek/mt7981b.dtsi     | 31 ++++++++++++++++++-
>  2 files changed, 47 insertions(+), 11 deletions(-)
> 
> --
> 2.39.5
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
 Base: tags/v6.16-rc1-8-g95a042a0c8ec (exact match)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/mediatek/' for 20250712195904.6988-1-olek2@wp.pl:

arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dtb: adc@1100d000 (mediatek,mt7981-auxadc): compatible: 'oneOf' conditional failed, one must be fixed:
	['mediatek,mt7981-auxadc', 'mediatek,mt7986-auxadc'] is too long
	'mediatek,mt7981-auxadc' is not one of ['mediatek,mt2701-auxadc', 'mediatek,mt2712-auxadc', 'mediatek,mt6765-auxadc', 'mediatek,mt7622-auxadc', 'mediatek,mt7986-auxadc', 'mediatek,mt8173-auxadc']
	'mediatek,mt7981-auxadc' is not one of ['mediatek,mt7623-auxadc']
	'mediatek,mt7981-auxadc' is not one of ['mediatek,mt6893-auxadc', 'mediatek,mt8183-auxadc', 'mediatek,mt8186-auxadc', 'mediatek,mt8188-auxadc', 'mediatek,mt8195-auxadc', 'mediatek,mt8516-auxadc']
	'mediatek,mt2701-auxadc' was expected
	'mediatek,mt8173-auxadc' was expected
	from schema $id: http://devicetree.org/schemas/iio/adc/mediatek,mt2701-auxadc.yaml#
arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dtb: /soc/adc@1100d000: failed to match any schema with compatible: ['mediatek,mt7981-auxadc', 'mediatek,mt7986-auxadc']
arch/arm64/boot/dts/mediatek/mt7981b-cudy-wr3000-v1.dtb: adc@1100d000 (mediatek,mt7981-auxadc): compatible: 'oneOf' conditional failed, one must be fixed:
	['mediatek,mt7981-auxadc', 'mediatek,mt7986-auxadc'] is too long
	'mediatek,mt7981-auxadc' is not one of ['mediatek,mt2701-auxadc', 'mediatek,mt2712-auxadc', 'mediatek,mt6765-auxadc', 'mediatek,mt7622-auxadc', 'mediatek,mt7986-auxadc', 'mediatek,mt8173-auxadc']
	'mediatek,mt7981-auxadc' is not one of ['mediatek,mt7623-auxadc']
	'mediatek,mt7981-auxadc' is not one of ['mediatek,mt6893-auxadc', 'mediatek,mt8183-auxadc', 'mediatek,mt8186-auxadc', 'mediatek,mt8188-auxadc', 'mediatek,mt8195-auxadc', 'mediatek,mt8516-auxadc']
	'mediatek,mt2701-auxadc' was expected
	'mediatek,mt8173-auxadc' was expected
	from schema $id: http://devicetree.org/schemas/iio/adc/mediatek,mt2701-auxadc.yaml#
arch/arm64/boot/dts/mediatek/mt7981b-cudy-wr3000-v1.dtb: /soc/adc@1100d000: failed to match any schema with compatible: ['mediatek,mt7981-auxadc', 'mediatek,mt7986-auxadc']
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku6.dtb: clock-controller@15520000 (mediatek,mt8188-imgsys-wpe2): '#reset-cells' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/clock/mediatek,mt8188-clock.yaml#
arch/arm64/boot/dts/mediatek/mt7981b-xiaomi-ax3000t.dtb: adc@1100d000 (mediatek,mt7981-auxadc): compatible: 'oneOf' conditional failed, one must be fixed:
	['mediatek,mt7981-auxadc', 'mediatek,mt7986-auxadc'] is too long
	'mediatek,mt7981-auxadc' is not one of ['mediatek,mt2701-auxadc', 'mediatek,mt2712-auxadc', 'mediatek,mt6765-auxadc', 'mediatek,mt7622-auxadc', 'mediatek,mt7986-auxadc', 'mediatek,mt8173-auxadc']
	'mediatek,mt7981-auxadc' is not one of ['mediatek,mt7623-auxadc']
	'mediatek,mt7981-auxadc' is not one of ['mediatek,mt6893-auxadc', 'mediatek,mt8183-auxadc', 'mediatek,mt8186-auxadc', 'mediatek,mt8188-auxadc', 'mediatek,mt8195-auxadc', 'mediatek,mt8516-auxadc']
	'mediatek,mt2701-auxadc' was expected
	'mediatek,mt8173-auxadc' was expected
	from schema $id: http://devicetree.org/schemas/iio/adc/mediatek,mt2701-auxadc.yaml#
arch/arm64/boot/dts/mediatek/mt7981b-xiaomi-ax3000t.dtb: /soc/adc@1100d000: failed to match any schema with compatible: ['mediatek,mt7981-auxadc', 'mediatek,mt7986-auxadc']






