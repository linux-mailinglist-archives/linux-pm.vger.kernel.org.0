Return-Path: <linux-pm+bounces-24800-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8575A7BB85
	for <lists+linux-pm@lfdr.de>; Fri,  4 Apr 2025 13:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 030F53B952C
	for <lists+linux-pm@lfdr.de>; Fri,  4 Apr 2025 11:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF5D1DE4D3;
	Fri,  4 Apr 2025 11:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="nJwsmtKf"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8701A83E2;
	Fri,  4 Apr 2025 11:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743766335; cv=none; b=QYt2E/Ei081rBRzs1f6jYIkICI1bB5u2nBtHpn9b6ORuEPBv30Om06QyT47gdS7ETvrOohUgABV1+9KRoEHuJsOc3xpQMDmzhWSUPSCeLBvxfIPXELv+2v+WFyASExXH+La9unwsaXo33K0CjEoRxqLSDUCSxT8yq/4Awn53q4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743766335; c=relaxed/simple;
	bh=mKsqKGG/7YSKHNxFBBuOvn0Q62p5t5UmUS+Llf4Xv+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e02NuQgBwSns7iLsI+JSlfb9mQ+Dr+fMhSQ2PFgBlxkTOQaPvSdJh8pVpcK6n3ExHjSKPbQSgpaRWq3tONEM0tjisRA6mt+S9BbzAl20YffOawAYcJaTWUQOi1eXexMeMGTBE+9g9MjpAVcZIGlJm2KeWqgV4SpBdzvh1QgCbWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=nJwsmtKf; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1743766330;
	bh=mKsqKGG/7YSKHNxFBBuOvn0Q62p5t5UmUS+Llf4Xv+o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nJwsmtKfCOFaRLtdheNLsrNXHau0c/Rn80fSu9DFp9dqh0mpVplJjf/RJDWsDppZj
	 K1nRgU79IM9C/BB+INNLF9qPLoZM7FIfqo2dV2MHBZUrapbHXtTlVoq7Ee9D1ZuTvA
	 8qMfMD5BzgJZ3gmloXl2Iny0cRXUy6qQFCGB+CGeaUn3O6T65csyfoVewC2Of83ZOo
	 DuOsYQX6Qzp1rE1hL6kbztBjhtqz9ZmJEip0zPfqu9MltVplyd30pOV4KbwFUoQRBU
	 iTCF9mpsJt0L86KQv1XekkmXzJkOvzzXy+fkz+jnQl6cJXvttX+etNTWbve4UriaIw
	 PY8YN9NjjTqAA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 17A6A17E0865;
	Fri,  4 Apr 2025 13:32:08 +0200 (CEST)
Message-ID: <2a12c4e7-7df7-49c7-8abe-1c5ee769cfcc@collabora.com>
Date: Fri, 4 Apr 2025 13:32:07 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/19] dt-bindings: arm/cpus: Add missing properties
To: "Rob Herring (Arm)" <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
 Stephen Boyd <sboyd@kernel.org>, zhouyanjie@wanyeetech.com,
 Conor Dooley <conor@kernel.org>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Steen Hegelund <Steen.Hegelund@microchip.com>,
 Daniel Machon <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-mips@vger.kernel.org,
 imx@lists.linux.dev, linux-rockchip@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-renesas-soc@vger.kernel.org
References: <20250403-dt-cpu-schema-v1-0-076be7171a85@kernel.org>
 <20250403-dt-cpu-schema-v1-17-076be7171a85@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250403-dt-cpu-schema-v1-17-076be7171a85@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 04/04/25 04:59, Rob Herring (Arm) ha scritto:
> The Arm CPU schema is missing a number of properties already in use.
> This has gone unnoticed as extra properties have not been restricted.
> Add a missing reference to cpu.yaml, and add all the missing properties.
> 
> As "clock-latency" and "voltage-tolerance" are related to opp-v1, add
> those properties to the opp-v1.yaml schema.
> 
> With this, other properties can be prevented from creeping in with
> 'unevaluatedProperties: false'.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>   Documentation/devicetree/bindings/arm/cpus.yaml   | 46 ++++++++++++++++++++++-
>   Documentation/devicetree/bindings/opp/opp-v1.yaml | 16 ++++++++
>   2 files changed, 61 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
> index 3d2b6286efb8..6f74ebfd38df 100644
> --- a/Documentation/devicetree/bindings/arm/cpus.yaml
> +++ b/Documentation/devicetree/bindings/arm/cpus.yaml
> @@ -299,6 +299,16 @@ properties:
>   
>         where voltage is in V, frequency is in MHz.
>   
> +  interconnects:
> +    minItems: 1
> +    maxItems: 2
> +
> +  nvmem-cells:
> +    maxItems: 1
> +
> +  nvmem-cell-names:
> +    const: speed_grade
> +
>     performance-domains:
>       maxItems: 1
>   
> @@ -317,6 +327,31 @@ properties:
>         corresponding to the index of an SCMI performance domain provider, must be
>         "perf".
>   
> +  resets:
> +    maxItems: 1
> +
> +  arm-supply:
> +    deprecated: true
> +    description: Use 'cpu-supply' instead
> +
> +  cpu0-supply:
> +    deprecated: true
> +    description: Use 'cpu-supply' instead
> +
> +  mem-supply: true
> +
> +  proc-supply:
> +    deprecated: true
> +    description: Use 'cpu-supply' instead
> +
> +  sram-supply:
> +    deprecated: true
> +    description: Use 'mem-supply' instead
> +
> +  mediatek,cci:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: Link to Mediatek Cache Coherent Interconnect

s/Mediatek/MediaTek/g please :-)

Anyway:
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



