Return-Path: <linux-pm+bounces-28457-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8F1AD5000
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 11:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 897F01888E14
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 09:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B02A248861;
	Wed, 11 Jun 2025 09:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Kizb/z0w"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48687482EB;
	Wed, 11 Jun 2025 09:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749634422; cv=none; b=QzpdUvdOB7qf1s4A/uCm/vhAyaIZ3ewLVW8Fk6qUEf1umxAvBA5+PZohrPjVsaW+v16YYTZxOmNOMBrqw2mxcpZhwYnOBUGsFGXLD12i5VhZYma8wGWKgs0LWNg1zLEqGr/nnFIg/hNU1BpEJZflerLcKOrOR41ThzdapmEoUM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749634422; c=relaxed/simple;
	bh=oZEcpnP061nNjDS/WgnKTb1UcVd/WXF6k/yr0VPQsvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jj8OhQJpfXXXw9Qn8tR5JLACvHP5iieRzYAD86eZnpiKljM3S3QyVQJPSzCrsHNTVL1YJPE6DRk7HQ3zKojTKHuovSPBIPEQTvV1NbxNWD6hrvRTgv4ttAcwl0tqIIU8rqKt6TUtjHKfCfKZtB+oEttaG0eQzk78HK/WX46qsSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Kizb/z0w; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1749634418;
	bh=oZEcpnP061nNjDS/WgnKTb1UcVd/WXF6k/yr0VPQsvg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Kizb/z0wcw/aH9ltLLM1EZhO+eukqEK/6W7COvd3FhHzaFkMY6jpcQX0Y3jUK6y6w
	 logvkP55UMr/w1LWJkNQTgfe0gSwSyrIPV/bnnpcXaO4tA/QKK50LTVw91PWrcNb45
	 /J/Kfdw8XBbwsl3cosQH2Kpyj/TFkCrZlgFpk6qtz1qjJJqDNfiIOdsQqtPBYFh1A7
	 i0qPQQlgQuQapncN3qsw7/PbGiWHeDTQYTCxUcZUMGjEHnl24SDwe1c9hnc/bgh9ye
	 A+35IOtHqr7+cPMV18Xw3AgB4gsC0WSELGgOAtzJjR+xC0jJhePabvljxkO6AWOxW+
	 tYqNLJlm+Lw+Q==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8EC4417E05C1;
	Wed, 11 Jun 2025 11:33:36 +0200 (CEST)
Message-ID: <fecf4045-9cc4-46d2-ba4a-5818fcfcb059@collabora.com>
Date: Wed, 11 Jun 2025 11:33:36 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/13] arm64: dts: mediatek: mt7988a-bpi-r4: configure
 switch phys and leds
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
 <20250608211452.72920-14-linux@fw-web.de>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250608211452.72920-14-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 08/06/25 23:14, Frank Wunderlich ha scritto:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Assign pinctrl to switch phys and leds.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> v2:
> - add labels and led-function and include after dropping from soc dtsi
> ---
>   .../dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi | 61 +++++++++++++++++++
>   1 file changed, 61 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi
> index d8b9cd794ee3..f10d3617dcac 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi
> @@ -4,6 +4,7 @@
>   
>   #include <dt-bindings/gpio/gpio.h>
>   #include <dt-bindings/regulator/richtek,rt5190a-regulator.h>
> +#include <dt-bindings/leds/common.h>
>   
>   #include "mt7988a.dtsi"
>   
> @@ -151,6 +152,66 @@ &gmac2 {
>   	phy-mode = "usxgmii";
>   };
>   
> +&gsw_phy0 {
> +	pinctrl-names = "gbe-led";
> +	pinctrl-0 = <&gbe0_led0_pins>;

pinctrl-0
pinctrl-names (here and everywhere else)

> +};
> +
> +&gsw_phy0_led0 {

function
color
status

> +	status = "okay";
> +	function = LED_FUNCTION_WAN;
> +	color = <LED_COLOR_ID_GREEN>;
> +};
> +
> +&gsw_port0 {
> +	label = "wan";
> +};
> +
> +&gsw_phy1 {
> +	pinctrl-names = "gbe-led";
> +	pinctrl-0 = <&gbe1_led0_pins>;
> +};
> +
> +&gsw_phy1_led0 {
> +	status = "okay";
> +	function = LED_FUNCTION_LAN;
> +	color = <LED_COLOR_ID_GREEN>;
> +};
> +
> +&gsw_port1 {
> +	label = "lan1";
> +};
> +
> +&gsw_phy2 {
> +	pinctrl-names = "gbe-led";
> +	pinctrl-0 = <&gbe2_led0_pins>;
> +};
> +
> +&gsw_phy2_led0 {
> +	status = "okay";
> +	function = LED_FUNCTION_LAN;
> +	color = <LED_COLOR_ID_GREEN>;
> +};
> +
> +&gsw_port2 {
> +	label = "lan2";
> +};
> +
> +&gsw_phy3 {

function

pinctrl-0
pinctrl-names


> +	pinctrl-names = "gbe-led";
> +	function = LED_FUNCTION_LAN;
> +	pinctrl-0 = <&gbe3_led0_pins>;
> +};
> +
> +&gsw_phy3_led0 {

color
status

> +	status = "okay";
> +	color = <LED_COLOR_ID_GREEN>;
> +};

...after which

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



