Return-Path: <linux-pm+bounces-36887-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF548C0CFFE
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 11:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6D553B3011
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 10:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317DB2F546D;
	Mon, 27 Oct 2025 10:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="l7tF6X2h"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AF82E543B;
	Mon, 27 Oct 2025 10:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761561831; cv=none; b=l3autcLz7B+5zlYurBl2t3vSL+TPkkC8niJJMNIJhD4BOCQIhJc2Mr70HELiitwyWrG7ltbkfl4SXgTO5pUo7fTYFrmfqGqgBABJFYDjemqTr+MpNvlZVE32Rt+nZDvCHA60YQJXOoosI/nDpvY1OoWA7Fo6RDFW7sHe3Kzu1OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761561831; c=relaxed/simple;
	bh=dnFWroSYpgKTr53sV/u987Z7MyBid44fWzMJtS7rNbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pTqPob4B6cRMGx4SwMBd55E/1alln9AIrMpqQ6lsdlFVo8sIsRG4Nqdg3U6ajoBK8IDLoOoenUVI3DqKR1VG/k2v7EhIjZecDE2yQhUYTCbQUYKc+xyDGE7rod1yc/liHGgI1P/bEJD9cjdeATrL+a9tbXLj09PMU9JwDZwjZTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=l7tF6X2h; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761561826;
	bh=dnFWroSYpgKTr53sV/u987Z7MyBid44fWzMJtS7rNbQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=l7tF6X2h3MPJ5hdPR+ZmZ/oW8il+SALAIJhV77rZLNlwk3+9fORla1icaFg8wdT/e
	 RZzCuaQgV0d3W/2+PkFa1aV2KBgHmU9oPn5CXmUhr9VXhx2SGM1aHbKUXC7fd1HWH8
	 7a4KoJr9pyV04xRCqu4UhBzU8+8PwIe4NElWEnTZhF/M71+/DyqwbCbZDxDZkSXOXm
	 /viuN8U3RFjOj7kmMqKr1u+iwiCCG3v0vxYNNaTflRD7I2hBrU3YTffPW5+nlNVUNO
	 Z9bi7t6/8L9Ecxz0GmTNh8oMAGtNrADhYjye6qzRHnKP4pyTE291LHR/g8cefNsHTs
	 Uu4+LeKBXO+ew==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3E02C17E12AE;
	Mon, 27 Oct 2025 11:43:46 +0100 (CET)
Message-ID: <7a8bf2e9-5033-4588-923c-53ad23c12924@collabora.com>
Date: Mon, 27 Oct 2025 11:43:45 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/5] dt-bindings: thermal: mediatek: make interrupt
 only required for current SoCs
To: Frank Wunderlich <linux@fw-web.de>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Mason Chang <mason-cw.chang@mediatek.com>
Cc: Frank Wunderlich <frank-w@public-files.de>,
 =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Balsam CHIHI <bchihi@baylibre.com>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20251026122143.71100-1-linux@fw-web.de>
 <20251026122143.71100-2-linux@fw-web.de>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251026122143.71100-2-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 26/10/25 13:21, Frank Wunderlich ha scritto:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Upcoming MT7987 does not have a IRQ we have to make interrupt-property only
> required for current supported SoCs.

Hmm. Thermal sensor IP with no interrupt? Looks really strange.

This is odd, because LVTS always has multiple interrupts, and if this doesn't
actually feature any, it really feels like the hardware is broken somehow.

MediaTek, can you please confirm whether the LVTS IP in MT7987 is really
like that, or can you please give the right interrupt number to Frank?

Thanks,
Angelo

> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>   .../bindings/thermal/mediatek,lvts-thermal.yaml | 17 ++++++++++++++++-
>   1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml b/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
> index 0259cd3ce9c5..7ec9c46eef22 100644
> --- a/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
> +++ b/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
> @@ -58,6 +58,16 @@ properties:
>   allOf:
>     - $ref: thermal-sensor.yaml#
>   
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - mediatek,mt7988-lvts-ap
> +    then:
> +      required:
> +        - interrupts
> +
>     - if:
>         properties:
>           compatible:
> @@ -75,6 +85,9 @@ allOf:
>           nvmem-cell-names:
>             maxItems: 1
>   
> +      required:
> +        - interrupts
> +
>     - if:
>         properties:
>           compatible:
> @@ -91,10 +104,12 @@ allOf:
>           nvmem-cell-names:
>             minItems: 2
>   
> +      required:
> +        - interrupts
> +
>   required:
>     - compatible
>     - reg
> -  - interrupts
>     - clocks
>     - resets
>     - nvmem-cells


