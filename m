Return-Path: <linux-pm+bounces-28464-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67928AD5011
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 11:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76DAB3A511A
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 09:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7243026A1AB;
	Wed, 11 Jun 2025 09:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="jyg1Jl9g"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DBC26A081;
	Wed, 11 Jun 2025 09:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749634436; cv=none; b=PdfJg5we4y67Z4d1pWBE1K+jgmEO1lKp2WF4g1zLt3lYn5dAHpwS1E9qS+xp2wJlSaE3x5O8N7FKthaYkUUHkJa2TcAabF+Rw3tTu4UeRFy01fNYLy4QWKKTNbEX0+oPTL2VVaQNgOuATrNjzSTK/QJf3BZADaVuFezNIhszsB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749634436; c=relaxed/simple;
	bh=wc/ooy51RhFVYkSFSjjYHTGOfC/0EUimTjaFo+b0Gys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fQa0ZX7lcG0W+XIkXNqY8WH+r8SlUrh+s6pMtW51f/qTG0PdK04c+20xWsl7il01HduiDY041UfSXklhzCJQa3bsSVphYk1/EgM3NEbhqsmxTpP4S/lSK37h/1L2C72ovmhtuDcw8gXli9rwQGkpfyP45cpmwylaPXP7gRbnUTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=jyg1Jl9g; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1749634432;
	bh=wc/ooy51RhFVYkSFSjjYHTGOfC/0EUimTjaFo+b0Gys=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jyg1Jl9gXIXL3XiwY+cRetV2WE9L4pUNAmtn5lc1h7T9Jfv7tQzpHib9cqo2BFPkb
	 go28/1uZQpHHUtG99wrMPWsoMxgMe1C+f+uZHpeE11M5eNgZa24YQFrv7iPFRgFyWT
	 3gZUU7dLs4eHKaiSyTliAmyRr4ifEYkuewdsnz2sm1Bxf9zm4O4EER1uiqSjB+nOyH
	 m4fKM81ynGkouNbtvhZczw9G91jz1eNgjsL7Qa+aDQVxAitXPLUeArtTuyz2vDYH74
	 YA41fSjJoV41l8Rym7w5l/mtkmWhc6g/Iu5RRUtqv5ywZvWacFNAzYNu+M5Yd3JpFo
	 uW1g2+nDtzZ2g==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5669C17E1045;
	Wed, 11 Jun 2025 11:33:51 +0200 (CEST)
Message-ID: <a50c0a9f-1846-4542-97a0-fb9563ed3b3a@collabora.com>
Date: Wed, 11 Jun 2025 11:33:44 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/13] arm64: dts: mediatek: mt7988: add switch node
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
References: <20250608211452.72920-1-linux@fw-web.de>
 <20250608211452.72920-8-linux@fw-web.de>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250608211452.72920-8-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 08/06/25 23:14, Frank Wunderlich ha scritto:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add mt7988 builtin mt753x switch nodes.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> v2:
> - drop labels and led-function too (have to be in board)
> ---
>   arch/arm64/boot/dts/mediatek/mt7988a.dtsi | 153 ++++++++++++++++++++++
>   1 file changed, 153 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
> index ee1e01d720fe..0b35a32b9c89 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
> @@ -742,6 +742,159 @@ ethsys: clock-controller@15000000 {
>   			#reset-cells = <1>;
>   		};
>   
> +		switch: switch@15020000 {
> +			compatible = "mediatek,mt7988-switch";
> +			reg = <0 0x15020000 0 0x8000>;
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +			interrupt-parent = <&gic>;

You don't need interrupt-parent, it's already GIC here... :-)

> +			interrupts = <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>;
> +			resets = <&ethwarp MT7988_ETHWARP_RST_SWITCH>;
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				gsw_port0: port@0 {
> +					reg = <0>;

Keep it ordered alphabetically - phy-handle (h) before phy-mode (m)

> +					phy-mode = "internal";
> +					phy-handle = <&gsw_phy0>;
> +				};
> +
> +				gsw_port1: port@1 {
> +					reg = <1>;
> +					phy-mode = "internal";
> +					phy-handle = <&gsw_phy1>;
> +				};
> +
> +				gsw_port2: port@2 {
> +					reg = <2>;
> +					phy-mode = "internal";
> +					phy-handle = <&gsw_phy2>;
> +				};
> +
> +				gsw_port3: port@3 {
> +					reg = <3>;
> +					phy-mode = "internal";
> +					phy-handle = <&gsw_phy3>;
> +				};
> +
> +				port@6 {
> +					reg = <6>;
> +					ethernet = <&gmac0>;
> +					phy-mode = "internal";
> +
> +					fixed-link {
> +						speed = <10000>;
> +						full-duplex;
> +						pause;
> +					};
> +				};
> +			};
> +
> +			mdio {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				mediatek,pio = <&pio>;
> +
> +				gsw_phy0: ethernet-phy@0 {
> +					compatible = "ethernet-phy-ieee802.3-c22";
> +					reg = <0>;
> +					interrupts = <0>;
> +					phy-mode = "internal";
> +					nvmem-cells = <&phy_calibration_p0>;
> +					nvmem-cell-names = "phy-cal-data";

phy-mode (p) after nvmem-cell-names (n) please (here and everywhere else)

> +
> +					leds {
> +						#address-cells = <1>;
> +						#size-cells = <0>;
> +
> +						gsw_phy0_led0: led@0 {
> +							reg = <0>;
> +							status = "disabled";
> +						};
> +
> +						gsw_phy0_led1: led@1 {
> +							reg = <1>;
> +							status = "disabled";
> +						};
> +					};
> +				};
> +
> +				gsw_phy1: ethernet-phy@1 {
> +					compatible = "ethernet-phy-ieee802.3-c22";
> +					reg = <1>;
> +					interrupts = <1>;
> +					phy-mode = "internal";
> +					nvmem-cells = <&phy_calibration_p1>;
> +					nvmem-cell-names = "phy-cal-data";
> +
> +					leds {
> +						#address-cells = <1>;
> +						#size-cells = <0>;
> +
> +						gsw_phy1_led0: led@0 {
> +							reg = <0>;
> +							status = "disabled";
> +						};
> +
> +						gsw_phy1_led1: led@1 {
> +							reg = <1>;
> +							status = "disabled";
> +						};
> +					};
> +				};
> +
> +				gsw_phy2: ethernet-phy@2 {
> +					compatible = "ethernet-phy-ieee802.3-c22";
> +					reg = <2>;
> +					interrupts = <2>;
> +					phy-mode = "internal";
> +					nvmem-cells = <&phy_calibration_p2>;
> +					nvmem-cell-names = "phy-cal-data";
> +
> +					leds {
> +						#address-cells = <1>;
> +						#size-cells = <0>;
> +
> +						gsw_phy2_led0: led@0 {
> +							reg = <0>;
> +							status = "disabled";
> +						};
> +
> +						gsw_phy2_led1: led@1 {
> +							reg = <1>;
> +							status = "disabled";
> +						};
> +					};
> +				};
> +
> +				gsw_phy3: ethernet-phy@3 {
> +					compatible = "ethernet-phy-ieee802.3-c22";
> +					reg = <3>;
> +					interrupts = <3>;
> +					phy-mode = "internal";
> +					nvmem-cells = <&phy_calibration_p3>;
> +					nvmem-cell-names = "phy-cal-data";
> +
> +					leds {
> +						#address-cells = <1>;
> +						#size-cells = <0>;
> +
> +						gsw_phy3_led0: led@0 {
> +							reg = <0>;
> +							status = "disabled";
> +						};
> +
> +						gsw_phy3_led1: led@1 {
> +							reg = <1>;
> +							status = "disabled";
> +						};
> +					};
> +				};
> +			};
> +		};
> +
>   		ethwarp: clock-controller@15031000 {
>   			compatible = "mediatek,mt7988-ethwarp";
>   			reg = <0 0x15031000 0 0x1000>;



