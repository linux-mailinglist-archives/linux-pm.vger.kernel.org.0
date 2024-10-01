Return-Path: <linux-pm+bounces-14990-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49ADA98B480
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2024 08:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED4F51F244B3
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2024 06:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AFB1BC09F;
	Tue,  1 Oct 2024 06:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZNZSTRx"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D251BC07E;
	Tue,  1 Oct 2024 06:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727764479; cv=none; b=nUa1qPOk+lPNaQqiq/SZOhPCCFZHkiGlgPISa6T8R4yxcaTIlRO0SpGxkLkO9lL42d5sHTbr59HFYWGo0IMFpNoLWx4IlINtPDNYwXven0I9XNNZzV1MM/RHdMz8wdwSmAUJ6iZjasq8faw5bJ3jj7qobmS+pfme40qooLY+AE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727764479; c=relaxed/simple;
	bh=EDXsjtDekecqXOH4lKPY26hQ0HMsahBvIn48muRWd1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RQgqQHzGbBc8AVFc/d1yjHzW1cnE7fvqYF4VTmksN37pURsn2rcolbV1fPul8wm06hCrCNZjjR1nzlwotiCQPHKth4FP+W8ObmegVYLfic5JFH62lhUJCFgHTBVtvBRhvAhxdetzID1V1syxkM8WEXQ7M2vDnRhqelV+zTiMqus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZNZSTRx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3708FC4CECE;
	Tue,  1 Oct 2024 06:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727764479;
	bh=EDXsjtDekecqXOH4lKPY26hQ0HMsahBvIn48muRWd1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HZNZSTRxoYenHd2hovmWWTwlJRLs20vhDJLKuNerNPNtYlQp/Ep92+GSfopw0NOPU
	 iO/cxIx2sB/PkyR0DCrDIXE79RSdkm3OL2TAAFlLgbFNVLcTROjq3r4LKEI56NOizX
	 h3qgYazB00THLjDp8IqVosg1eRSNqKuQ0OdjqE8bEktC8x7wBhrbJDfV1GTQHlSj6I
	 WZPGEiyGchqGrtGiSo5McKjhKN5wCSwxEAe8A7UQSMAGmyOP75QhVrTJbls7DV/sVV
	 hde23wP8NKg0xToQD21c+mjDITLCYNaxhK7xk/GPq6Y+AK0QMcbrdIH4qOU5WugDbd
	 Kt+9NYEsVm0Sw==
Date: Tue, 1 Oct 2024 08:34:35 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Macpaul Lin <macpaul.lin@mediatek.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Sen Chu <sen.chu@mediatek.com>, 
	Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>, 
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-rtc@vger.kernel.org, linux-sound@vger.kernel.org, 
	Alexandre Mergnat <amergnat@baylibre.com>, Bear Wang <bear.wang@mediatek.com>, 
	Pablo Sun <pablo.sun@mediatek.com>, Macpaul Lin <macpaul@gmail.com>, 
	Chris-qj chen <chris-qj.chen@mediatek.com>, 
	MediaTek Chromebook Upstream <Project_Global_Chrome_Upstream_Group@mediatek.com>, Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH v7 2/3] ASoC: dt-bindings: mt6358: Convert to DT Schema
Message-ID: <6l6hb264yvhd6e6neurd5t4gmv5z5c5gpg27icijif3hq4cuu7@pbhfkdxb2eam>
References: <20240930073311.1486-1-macpaul.lin@mediatek.com>
 <20240930073311.1486-2-macpaul.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240930073311.1486-2-macpaul.lin@mediatek.com>

On Mon, Sep 30, 2024 at 03:33:10PM +0800, Macpaul Lin wrote:
> Convert the MediaTek MT6358 Audio CODEC bindings to DT schema.
> 
> This change implements the following updates:
> 1. Compatible property: Added the const 'mediatek,mt6358-sound'
>    to ensure alignment with the schema in the actual (DTS) file
>    "mt8186-corsola.dtsi" with 'mediatek,mt6366-sound'.
> 2. Example: Removed the example section, as it should be relocated to
>    the MT6397 PMIC file 'mfd/mediatek,mt6397.yaml'.
> 
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---
>  .../devicetree/bindings/sound/mt6358.txt      | 26 ------------
>  .../devicetree/bindings/sound/mt6358.yaml     | 41 +++++++++++++++++++
>  2 files changed, 41 insertions(+), 26 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/mt6358.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/mt6358.yaml
> 
> Changess for v1~v6:
>  - It was not in the origin patch set.
> 
> Changes for v7:
>  - It is seperated from the origin patch set (2/2, v6).
>    It could simplifies the audio-codec node in next patch (3/3, v7)
>    of 'mfd/mediatek,mt6397.yaml'
> 
> diff --git a/Documentation/devicetree/bindings/sound/mt6358.txt b/Documentation/devicetree/bindings/sound/mt6358.txt
> deleted file mode 100644
> index fbe9e55c68f5..000000000000
> --- a/Documentation/devicetree/bindings/sound/mt6358.txt
> +++ /dev/null
> @@ -1,26 +0,0 @@
> -Mediatek MT6358 Audio Codec
> -
> -The communication between MT6358 and SoC is through Mediatek PMIC wrapper.
> -For more detail, please visit Mediatek PMIC wrapper documentation.
> -
> -Must be a child node of PMIC wrapper.
> -
> -Required properties:
> -
> -- compatible - "string" - One of:
> -    "mediatek,mt6358-sound"
> -    "mediatek,mt6366-sound"
> -- Avdd-supply : power source of AVDD
> -
> -Optional properties:
> -- mediatek,dmic-mode : Indicates how many data pins are used to transmit two
> -	channels of PDM signal. 0 means two wires, 1 means one wire. Default
> -	value is 0.
> -
> -Example:
> -
> -mt6358_snd {
> -	compatible = "mediatek,mt6358-sound";
> -	Avdd-supply = <&mt6358_vaud28_reg>;
> -	mediatek,dmic-mode = <0>;
> -};
> diff --git a/Documentation/devicetree/bindings/sound/mt6358.yaml b/Documentation/devicetree/bindings/sound/mt6358.yaml
> new file mode 100644
> index 000000000000..5f7611e26a89
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/mt6358.yaml
> @@ -0,0 +1,41 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/mt6358.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mediatek MT6358 Audio Codec
> +
> +maintainers:
> +  - Jiaxin Yu <jiaxin.yu@mediatek.com>
> +  - Macpaul Lin <macpaul.lin@mediatek.com>
> +
> +description: |
> +  The communication between MT6358 and SoC is through Mediatek PMIC wrapper.
> +  For more detail, please visit Mediatek PMIC wrapper documentation.
> +  Must be a child node of PMIC wrapper.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mediatek,mt6366-sound
> +      - mediatek,mt6358-sound
> +    const: mediatek,mt6358-sound

This wasn't ever tested.

Do not send untested code, it's a waste of reviewers' time.

Best regards,
Krzysztof


