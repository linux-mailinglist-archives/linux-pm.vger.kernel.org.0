Return-Path: <linux-pm+bounces-29047-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DB3ADFD5F
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 07:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1184E1781AC
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 05:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8618B242D9A;
	Thu, 19 Jun 2025 05:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="HYePmHLQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59748239E8D;
	Thu, 19 Jun 2025 05:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750312635; cv=none; b=MlsvWNJ1KhViFOsi7tYRCNdcSpDcYRSWxe5eePZirkRv0/xX2x54tAMrpNyMuHzBTpxrcXr3cL+GT4T99TW+96kPhOOzl3Nq/LD6Rdbo4U4svjGxGSi8fuPfBNn23CjGWejflzriF7qPuFvjW3dq6JF19+d0wEYG8weRwpMXtTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750312635; c=relaxed/simple;
	bh=D/xlw55EoSMWX+1oNBIVOI7WZ/cWsoba7+lpu84WuNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=su/dg2NdaWnHxPOfHlkHIf29iIFNRan61qtj0hc/XMulH6eX445Y+B4+/u/1BvwjoqI7q739l3XHgCArlsAyqmZrT0cDXoACI96MnLGb50px5Eh+rUuDqNGg3UGx9o1kpNapgF0mO8UyBTbXktNdsVpJ1ELwdt8xL0JXgjpGjVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=HYePmHLQ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1750312631;
	bh=D/xlw55EoSMWX+1oNBIVOI7WZ/cWsoba7+lpu84WuNQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HYePmHLQBPfH9nqNrBiWlUk9B7aSLg1PcCX6BQGVyy1svSIar9TjqA+9hmSzVyIDE
	 zG4F9kSlE1W7H+GxLABGyl+VdZACo0DO+7z1srK6g5VsLuwe0iCfTfPNBQp7WvFzw0
	 DMsJ5/0IZliTgBFXU7jjyokLq9Nj21GNr3pmXJS3EHt00dv6hAdx11Ru9DMpoiSjb3
	 tSGM0qBjCCnLTZh+YChAp7g1T/JbCqvGmA/8+50mO7perxqmfusXI0MMhDkHJbIAIY
	 /tW6PeOrGSMbe0RBwzzOZTMbbLxIuZe+7YqzE56U7oPlx27ZVfQhfmDX54auoyrX6h
	 NoHEjjqxML6sQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id EC68417E1559;
	Thu, 19 Jun 2025 07:57:09 +0200 (CEST)
Message-ID: <9cdf0624-f9bb-4b11-973e-9480fd655136@collabora.com>
Date: Thu, 19 Jun 2025 07:57:09 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/13] further mt7988 devicetree work
To: Frank Wunderlich <linux@fw-web.de>,
 MyungJoo Ham <myungjoo.ham@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, Georgi Djakov <djakov@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: Frank Wunderlich <frank-w@public-files.de>,
 Jia-Wei Chang <jia-wei.chang@mediatek.com>,
 Johnson Wang <johnson.wang@mediatek.com>, =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?=
 <arinc.unal@arinc9.com>, Landen Chao <Landen.Chao@mediatek.com>,
 DENG Qingfang <dqfext@gmail.com>, Sean Wang <sean.wang@mediatek.com>,
 Daniel Golle <daniel@makrotopia.org>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Felix Fietkau <nbd@nbd.name>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20250616095828.160900-1-linux@fw-web.de>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250616095828.160900-1-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 16/06/25 11:58, Frank Wunderlich ha scritto:
> From: Frank Wunderlich <frank-w@public-files.de>
> 

I think that this series is ready to be applied; however, I need someone to take
the bindings before I can apply the devicetree part to the MediaTek trees.

Cheers,
Angelo


> This series continues mt7988 devicetree work
> 
> - Extend cpu frequency scaling with CCI
> - GPIO leds
> - Basic network-support (ethernet controller + builtin switch + SFP Cages)
> 
> depencies (i hope this list is complete and latest patches/series linked):
> 
> support interrupt-names because reserved IRQs are now dropped, so index based access is now wrong
> https://patchwork.kernel.org/project/netdevbpf/patch/20250616080738.117993-2-linux@fw-web.de/
> 
> for SFP-Function (macs currently disabled):
> 
> PCS clearance which is a 1.5 year discussion currently ongoing
> 
> e.g. something like this (one of):
> * https://patchwork.kernel.org/project/netdevbpf/patch/20250610233134.3588011-4-sean.anderson@linux.dev/ (v6)
> * https://patchwork.kernel.org/project/netdevbpf/patch/20250511201250.3789083-4-ansuelsmth@gmail.com/ (v4)
> * https://patchwork.kernel.org/project/netdevbpf/patch/ba4e359584a6b3bc4b3470822c42186d5b0856f9.1721910728.git.daniel@makrotopia.org/
> 
> full usxgmii driver:
> https://patchwork.kernel.org/project/netdevbpf/patch/07845ec900ba41ff992875dce12c622277592c32.1702352117.git.daniel@makrotopia.org/
> 
> first PCS-discussion is here:
> https://patchwork.kernel.org/project/netdevbpf/patch/8aa905080bdb6760875d62cb3b2b41258837f80e.1702352117.git.daniel@makrotopia.org/
> 
> and then dts nodes for sgmiisys+usxgmii+2g5 firmware
> 
> when above depencies are solved the mac1/2 can be enabled and 2.5G phy/SFP slots will work.
> 
> changes:
> v4:
>    net-binding:
>      - allow interrupt names and increase max interrupts to 6 because of RSS/LRO interrupts
>        (dropped Robs RB due to this change)
> 
>    dts-patches:
>    - add interrupts for RSS/LRO and interrupt-names for ethernet node
>    - eth-reg and clock whitespace-fix
>    - comment for fixed-link on gmac0
>    - drop phy-mode properties as suggested by andrew
>    - drop phy-connection-type on 2g5 board
>    - reorder some properties
>    - update 2g5 phy node
>      - unit-name dec instead of hex to match reg property
>      - move compatible before reg
>      - drop phy-mode
> 
> v3:
>    - dropped patches already applied (SPI+thermal)
>    - added soc specific cci compatible (new binding patch + changed dts)
>    - enable 2g5 phy because driver is now merged
>    - add patch for cleaning up unnecessary pins
>    - add patch for gpio-leds
>    - add patch for adding ethernet aliases
> 
> v2:
>    - change reg to list of items in eth binding
>    - changed mt7530 binding:
>      - unevaluatedProperties=false
>      - mediatek,pio subproperty
>      - from patternProperty to property
>    - board specific properties like led function and labels moved to bpi-r4 dtsi
> 
> 
> Frank Wunderlich (13):
>    dt-bindings: net: mediatek,net: update for mt7988
>    dt-bindings: net: dsa: mediatek,mt7530: add dsa-port definition for
>      mt7988
>    dt-bindings: net: dsa: mediatek,mt7530: add internal mdio bus
>    dt-bindings: interconnect: add mt7988-cci compatible
>    arm64: dts: mediatek: mt7988: add cci node
>    arm64: dts: mediatek: mt7988: add basic ethernet-nodes
>    arm64: dts: mediatek: mt7988: add switch node
>    arm64: dts: mediatek: mt7988a-bpi-r4: add proc-supply for cci
>    arm64: dts: mediatek: mt7988a-bpi-r4: drop unused pins
>    arm64: dts: mediatek: mt7988a-bpi-r4: add gpio leds
>    arm64: dts: mediatek: mt7988a-bpi-r4: add aliases for ethernet
>    arm64: dts: mediatek: mt7988a-bpi-r4: add sfp cages and link to gmac
>    arm64: dts: mediatek: mt7988a-bpi-r4: configure switch phys and leds
> 
>   .../bindings/interconnect/mediatek,cci.yaml   |  11 +-
>   .../bindings/net/dsa/mediatek,mt7530.yaml     |  24 +-
>   .../devicetree/bindings/net/mediatek,net.yaml |  28 +-
>   .../mediatek/mt7988a-bananapi-bpi-r4-2g5.dts  |  11 +
>   .../dts/mediatek/mt7988a-bananapi-bpi-r4.dts  |  19 ++
>   .../dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi | 198 ++++++-----
>   arch/arm64/boot/dts/mediatek/mt7988a.dtsi     | 307 +++++++++++++++++-
>   7 files changed, 498 insertions(+), 100 deletions(-)
> 



