Return-Path: <linux-pm+bounces-28458-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13323AD4FF1
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 11:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81C4416406C
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 09:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5FE264630;
	Wed, 11 Jun 2025 09:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="YQtxycrv"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B8A225791;
	Wed, 11 Jun 2025 09:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749634424; cv=none; b=SQyxhxhPbMqD0Gx0ejqphJw4GcULKHDhG1enxlrgyqeCIK0OyZs/fpRKVW9eLtUowiGVpZ+QTJjW84DbrCI62yT55fl9w/O/8GMmUo39YwQrntkFEGEdguWJ+GB0inmX3boeLqa/jCfjup9M49Jnk7k8YR/yDtwWDqGzIXGJbVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749634424; c=relaxed/simple;
	bh=iZRMsUTO/sHIde2R5o95I83Ls9f+Je5NTObQ20FW4lg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gXZ0qgOZIPAN+9h52Tr/uzTrtuV2S9bSrznDzJPPA1i+N9sqzXxr2TYBljM63q51y1hTXWLNLa5coKeL+0/lBghkFTrpXc5wvEJzxNzTY7rtlJZJFffMv+ncycu095eUKW3bKalRigCRA6WfhaSwIsxhnfB17rE9OymzocWc+JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=YQtxycrv; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1749634420;
	bh=iZRMsUTO/sHIde2R5o95I83Ls9f+Je5NTObQ20FW4lg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YQtxycrvDTsiKzL6sOJuBJftKXuuNSx7cBuTXaWybtsB+6/efYFAxBpfiLnfKoB5u
	 Yk4l59hj8HierCGRy9+ZGpL7x8y3PQfJul+YKaKWI2M9JVsqQLXj4/iPa9bx5fxfYf
	 zltbemEGEGA3shlWIa2Il34qSakPX2wAKqjwfY2f1FeoBaiCWJvUYWuLaYCLf/I/zQ
	 8mwljBUil21GgLqzES7Gx/gsWTK+KY7SjTvIbZYYDKeoRjfmIXvOP8YBUs45gRw4ty
	 gK1qYTvhI+n6i6/gO58rbXYFAeakLTXta3upJ0T7gpdesiLhHiZn4/Dhk6oo4frFbh
	 tggdFCeKYgDUA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6FDE417E101A;
	Wed, 11 Jun 2025 11:33:38 +0200 (CEST)
Message-ID: <37c7ac6c-a5ea-45cc-8ded-9d9bb22d092e@collabora.com>
Date: Wed, 11 Jun 2025 11:33:37 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/13] arm64: dts: mediatek: mt7988a-bpi-r4: add sfp
 cages and link to gmac
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
 <20250608211452.72920-13-linux@fw-web.de>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250608211452.72920-13-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 08/06/25 23:14, Frank Wunderlich ha scritto:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add SFP cages to Bananapi-R4 board. The 2.5g phy variant only contains the
> wan-SFP, so add this to common dtsi and the lan-sfp only to the dual-SFP
> variant.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> v3:
> - enable mac with 2.5g phy on r4 phy variant because driver is now mainline
> ---
>   .../mediatek/mt7988a-bananapi-bpi-r4-2g5.dts   | 12 ++++++++++++
>   .../dts/mediatek/mt7988a-bananapi-bpi-r4.dts   | 18 ++++++++++++++++++
>   .../dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi  | 18 ++++++++++++++++++
>   3 files changed, 48 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4-2g5.dts b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4-2g5.dts
> index 53de9c113f60..e63e17ae35a0 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4-2g5.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4-2g5.dts
> @@ -9,3 +9,15 @@ / {
>   	model = "Banana Pi BPI-R4 (1x SFP+, 1x 2.5GbE)";
>   	chassis-type = "embedded";
>   };
> +
> +&gmac1 {

phy = ...
phy-c..onnection-type
phy-m...ode

> +	phy-mode = "internal";
> +	phy-connection-type = "internal";
> +	phy = <&int_2p5g_phy>;
> +	status = "okay";
> +};
> +
> +&int_2p5g_phy {
> +	pinctrl-names = "i2p5gbe-led";
> +	pinctrl-0 = <&i2p5gbe_led0_pins>;

pinctrl-names
pinctrl-0

> +};
> diff --git a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
> index 36bd1ef2efab..3136dc4ba4cc 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
> @@ -8,6 +8,24 @@ / {
>   	compatible = "bananapi,bpi-r4", "mediatek,mt7988a";
>   	model = "Banana Pi BPI-R4 (2x SFP+)";
>   	chassis-type = "embedded";
> +
> +	/* SFP2 cage (LAN) */
> +	sfp2: sfp2 {
> +		compatible = "sff,sfp";
> +		i2c-bus = <&i2c_sfp2>;

maximum-power-milliwatt here
(blank line)
...then gpios

> +		los-gpios = <&pio 2 GPIO_ACTIVE_HIGH>;
> +		mod-def0-gpios = <&pio 83 GPIO_ACTIVE_LOW>;

(r)ate-select0-gpios before (t)x-disable....

> +		tx-disable-gpios = <&pio 0 GPIO_ACTIVE_HIGH>;
> +		tx-fault-gpios = <&pio 1 GPIO_ACTIVE_HIGH>;
> +		rate-select0-gpios = <&pio 3 GPIO_ACTIVE_LOW>;
> +		maximum-power-milliwatt = <3000>;
> +	};
> +};
> +
> +&gmac1 {
managed
phy-mode
sfp

> +	sfp = <&sfp2>;
> +	managed = "in-band-status";
> +	phy-mode = "usxgmii";
>   };
>   
>   &pca9545 {
> diff --git a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi
> index 20073eb4d1bd..d8b9cd794ee3 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi
> @@ -63,6 +63,18 @@ reg_3p3v: regulator-3p3v {
>   		regulator-boot-on;
>   		regulator-always-on;
>   	};
> +
> +	/* SFP1 cage (WAN) */
> +	sfp1: sfp1 {
> +		compatible = "sff,sfp";
> +		i2c-bus = <&i2c_sfp1>;

(same comments from sfp2)

> +		los-gpios = <&pio 54 GPIO_ACTIVE_HIGH>;
> +		mod-def0-gpios = <&pio 82 GPIO_ACTIVE_LOW>;
> +		tx-disable-gpios = <&pio 70 GPIO_ACTIVE_HIGH>;
> +		tx-fault-gpios = <&pio 69 GPIO_ACTIVE_HIGH>;
> +		rate-select0-gpios = <&pio 21 GPIO_ACTIVE_LOW>;
> +		maximum-power-milliwatt = <3000>;
> +	};
>   };
>   
>   &cci {
> @@ -133,6 +145,12 @@ map-cpu-active-low {
>   	};
>   };
>   
> +&gmac2 {

(same comments from gmac1)

> +	sfp = <&sfp1>;
> +	managed = "in-band-status";
> +	phy-mode = "usxgmii";
> +};
> +
>   &i2c0 {
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&i2c0_pins>;


Cheers,
Angelo

