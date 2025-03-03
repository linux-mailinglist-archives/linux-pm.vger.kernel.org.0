Return-Path: <linux-pm+bounces-23291-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8F4A4BDFD
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 12:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E90A57A42FC
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 11:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF8D1F3B82;
	Mon,  3 Mar 2025 11:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kch8e3nB"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C5D1F30DE;
	Mon,  3 Mar 2025 11:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741000496; cv=none; b=ZB5t70GZ0rtg6Y4IZaX25sFCWbMWW6b/CEVacQukDYzlmJs/viwbRFQG5E7ztJDLXb8HoaER/9tVPdB+28diObfuK/y/NZBtiDp3+h8VaXOCl2VaAdHKDaIxEwxAbKTxV/TK+lrwpShB1BkQ2RZXCklBR+1uYYl+W+lPgQCR3lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741000496; c=relaxed/simple;
	bh=MuoBkQwQu8XmRjilJqdqdSZkgFcUcL99UuUXKBQqEvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=moeow7r4EJLjiPUNZgZ8ACIqKuaogne4JSh0sEAlFB+GeH1fM8qvvcuw4qOJPFrGZSF1wEppHpT2UN2+YKdVB8V5EOB2O0+6JAEEtgN6Zs8u0JhzZBbYBuyRdasN7NfcMnqw8aYXxUMTlUtzFYVpe1jqs6kssKUDQcIWi8HRnzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kch8e3nB; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741000493;
	bh=MuoBkQwQu8XmRjilJqdqdSZkgFcUcL99UuUXKBQqEvI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kch8e3nBBmvrmd+vy1kE8xKIClonHK6gQH3zE/VKF+Z3QFwyNglddPsZ/5TOwX2W4
	 NWVhItGiYSAi0OVQ6ngICI2Xgfkfbo4naas/Jk4cB4iCHqRKjcL+bba9KbKvGG8nY7
	 MIMZvzI63sYEPIM1JyLSuReW3iHoOnliWFuSKxfv6RKOkVCNf3QoeZoRZglSF+vEjs
	 FV44VBc+4mChP+morRM2utQYTKNDAUREhV1TRRFASsNAn/BoxaxwZF5YESqekDfpLN
	 9pzp5HlzlbocKw3N82TrXi7TndScDiiHhyoxuXAD4mfQG1qs/7XSXIW7d7BU7PfGdW
	 P5oswzpj5xBtQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C56CD17E086B;
	Mon,  3 Mar 2025 12:14:51 +0100 (CET)
Message-ID: <628a81c5-b9f1-4be9-84ec-90022a3526da@collabora.com>
Date: Mon, 3 Mar 2025 12:14:51 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/20] ASoC: dt-bindings: Add document for
 mt6359-accdet
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Sen Chu <sen.chu@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>,
 Lee Jones <lee@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-pm@vger.kernel.org
References: <20250302-mt6359-accdet-dts-v2-0-5bd633ee0d47@collabora.com>
 <20250302-mt6359-accdet-dts-v2-1-5bd633ee0d47@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250302-mt6359-accdet-dts-v2-1-5bd633ee0d47@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 02/03/25 17:30, Nícolas F. R. A. Prado ha scritto:
> Add dt-binding for the MT6359 ACCDET hardware block.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>   .../bindings/sound/mediatek,mt6359-accdet.yaml     | 42 ++++++++++++++++++++++
>   1 file changed, 42 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/mediatek,mt6359-accdet.yaml b/Documentation/devicetree/bindings/sound/mediatek,mt6359-accdet.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..d08a79301409374714c76135b061e20e8e8acfaf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/mediatek,mt6359-accdet.yaml
> @@ -0,0 +1,42 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/mediatek,mt6359-accdet.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MT6359 Accessory Detection
> +
> +maintainers:
> +  - Nícolas F. R. A. Prado <nfraprado@collabora.com>
> +
> +description: |
> +  The MT6359 Accessory Detection block is part of the MT6359 PMIC and allows
> +  detecting audio jack insertion and removal, as well as identifying the type of
> +  events connected to the jack.
> +
> +properties:
> +  compatible:
> +    const: mediatek,mt6359-accdet
> +
> +  mediatek,hp-eint-high:
> +    type: boolean
> +    description:
> +      By default, the HP_EINT pin is assumed to be pulled high and connected to

Just to be clearer about this pin being an internal one and not externally sourced,
so, *not* a SoC GPIO, but somehing that is completely provided and handled by the
accdet IP...

"By default, the accdet IP's internal HP_EINT pin is assumed to be pulled ..."

After which:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> +      a normally open 3.5mm jack. Plug insertion is detected when the pin is
> +      brought low in that case. Add this property if the behavior should be
> +      inverted, for example if a normally closed 3.5mm jack is used, or if the
> +      line is pulled low on open.
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    accdet: accdet {
> +        compatible = "mediatek,mt6359-accdet";
> +        mediatek,hp-eint-high;
> +    };
> 



