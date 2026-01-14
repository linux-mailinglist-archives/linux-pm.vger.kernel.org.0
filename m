Return-Path: <linux-pm+bounces-40785-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1F4D1D0CB
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 09:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E73D3007604
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 08:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E908B37E300;
	Wed, 14 Jan 2026 08:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHNZyi4h"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EC637E2F2
	for <linux-pm@vger.kernel.org>; Wed, 14 Jan 2026 08:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768378628; cv=none; b=GbQ5fgzO/wlyhGcQ5+zLJB9t3IMn2XkA6tgPjYtgqZJmHi3XoQUPTuqWQbKG3oAyyBJqxRcm5ctyuRzTkxi1Iz5JPePg37fSB9T3y424ucNko8aCNRLxqrDSISfo7tB0RGgFR1hQEJhzTCtwSIbfQ2JYJbm3w+hBCvJbTNa+RlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768378628; c=relaxed/simple;
	bh=o5URozGNlcTJCoUm4Mq2kJtCRIFDHpPaYBHu8P+apsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kf8gABgbK21ueqRsBfaR1tyoGOpD0r9SSrZ5YSX09RgAp/X74FmXwveClzPbJbPgmLai23L+Er14f0xDrSQvrcsfHy+OmoaJ+lIdXRCWpl5paSWFFUH9Kt0GU6qbHHEBCpU/NnQg4H37FLbhkgExB/jPKrOGMlrmADUvs1QMtLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHNZyi4h; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4327778df7fso5204150f8f.3
        for <linux-pm@vger.kernel.org>; Wed, 14 Jan 2026 00:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768378620; x=1768983420; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rdiAvhIBSkRBz7twMnAqXfiNrByqG73RL/D6sMKeEGU=;
        b=HHNZyi4hc9y+JApGqSROX7Y8aOukpnS9ItxVBFyIelltRrhL8lW5X5isxwPuJCgUGP
         xMClHs7uLwJ75kuZx2y1gsUxqDb4wTKs7vdOL0SjKQZQ28072mtp4POSEewP3adJT1ai
         QXWwVipsjcS044mepsn3IVkqPxfOuFAEduH9aBrqy4lrasIPPLGqNkXHEOsJhUwPI1Hs
         C1gL6EnXXdzTPw3zRsUUj54hhMxgS4yKegebMbZOI4GzoE0o8/jPEZZrjvDFU5oHdS0k
         3+qMVowdouDOvz+syicD5FBrVNrsk8npGrqCfpbsZ1e2rajTSJ50EkcWUj3rI4fEYDkm
         PEUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768378620; x=1768983420;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rdiAvhIBSkRBz7twMnAqXfiNrByqG73RL/D6sMKeEGU=;
        b=N7BfF3eStDOXIjqa0I7kb7Vlmb53VvGBcg8/GzF6spHQ7bXan3DqEmp8HHB95u9u5M
         lMn9Wv9GxuD/xbTLmFtTf6pLwogUzUORHpZSzfifDyowIiYZarod9T4pVKj3NANEENcP
         OISfkFQFod7Bxxc1MEtSs3fZooS/J+QIa6qAOAU9R4BRAeAAhUNCl1JNh1VgOrdEEk73
         vdCf1fM3qNqdcqRvBi10jBcekdfX9ZSLRHGeIMGpSf/JWU4U9o6PY3IQCuxdl5JGFzSX
         g0xiHyAiOvTgEHdV+WxDN84pW6qcNr0eIeTjBYMei/zYColx9LCrNMdD45jacBvkvx/B
         G1hQ==
X-Forwarded-Encrypted: i=1; AJvYcCUd337j9OzX0hxUkVwoKyd+GHh5FihM+5vr5thBy1JaI1g36QHqbXueHHlJ4q9dESmYORZkp9DPLQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwbvUmSrqv5DHO1pGhJSmFMoF4NlTh3Uc/Zc6SNpzEr2eK5aKCo
	nYZ1lJZqcDwQAsjEAZfoe99Cfqqy7mgfR/+N6dCCDQLrhB+dLKjnsu+w
X-Gm-Gg: AY/fxX4DqeJaLD80CBkRxEz1dGLZmk+d9+WmEtvDhpy1UEJdcdJvf8BU71rKZh/ats/
	4iZ3Uoh6n7aKDY5ZAdjqaAGTsQg9eqsbWgikHEOt6xicF+sHxFUEJJd9RsV8f610GB1D6ucJMyh
	+LDXwOyehGv7IjsXtnm2QapB+PHCtVPLUiICvfHDosnShGay8MGl8IoUbcOn660VZNpp7g6vjFh
	sB+Dpi8ozTqRAAVcmtOV9ueRAoKE5ubSs4bV8LWnH99/gEWhN7FPHd4U/9quXyJKUmkbpL+dr5I
	IcBUGbAW379JjCTX5wrfLoIoJHa+9Arei4XxQ+dF4XLnwsUPfUQqLb5MC2kjtkVv9dKHTy5SW8k
	6nmq7PcZSXezGhq0wb+qpA3wKv3wbvJWkiS2U2U+rjLAvXa20kwGbQtq7N40JFSZCDycNKZtuTo
	/9/C9G38x5s+SoJATCgrArNLvR/lG7NoXAtOahKHTzp0dStN6KW2vC2eM9vKlBx0vIs9g=
X-Received: by 2002:a05:600c:c0d0:b0:47e:e78a:c831 with SMTP id 5b1f17b1804b1-47ee78ac9e2mr3070835e9.36.1768378620011;
        Wed, 14 Jan 2026 00:17:00 -0800 (PST)
Received: from [192.168.1.27] (84.121.134.198.dyn.user.ono.com. [84.121.134.198])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee578d37esm15572945e9.1.2026.01.14.00.16.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jan 2026 00:16:59 -0800 (PST)
Message-ID: <0eb5086c-39f1-4cf3-aa71-440036930052@gmail.com>
Date: Wed, 14 Jan 2026 09:16:58 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] dt-bindings: clock: mediatek,mt7622-pciesys: Remove
 syscon compatible
Content-Language: en-GB
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-mediatek@lists.infradead.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 mturquette@baylibre.com, sboyd@kernel.org, matthias.bgg@gmail.com,
 ulf.hansson@linaro.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
 kernel@collabora.com
References: <20260113110012.36984-1-angelogioacchino.delregno@collabora.com>
 <20260113110012.36984-2-angelogioacchino.delregno@collabora.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20260113110012.36984-2-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/1/26 12:00, AngeloGioacchino Del Regno wrote:
> The PCIESYS register space contains a pure clock controller, which
> has no system controller register, so this definitely doesn't need
> any "syscon" compatible.
> 
> As a side note, luckily no devicetree ever added the syscon string
> to PCIESYS clock controller node compatibles, so this also resolves
> a dtbs_check warning for mt7622.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   .../bindings/clock/mediatek,mt7622-pciesys.yaml        | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt7622-pciesys.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt7622-pciesys.yaml
> index 9c3913f9092c..c77111d10f90 100644
> --- a/Documentation/devicetree/bindings/clock/mediatek,mt7622-pciesys.yaml
> +++ b/Documentation/devicetree/bindings/clock/mediatek,mt7622-pciesys.yaml
> @@ -14,11 +14,9 @@ maintainers:
>   
>   properties:
>     compatible:
> -    oneOf:
> -      - items:
> -          - const: mediatek,mt7622-pciesys
> -          - const: syscon
> -      - const: mediatek,mt7629-pciesys
> +    enum:
> +      - mediatek,mt7622-pciesys
> +      - mediatek,mt7629-pciesys
>   
>     reg:
>       maxItems: 1
> @@ -40,7 +38,7 @@ additionalProperties: false
>   examples:
>     - |
>       clock-controller@1a100800 {
> -        compatible = "mediatek,mt7622-pciesys", "syscon";
> +        compatible = "mediatek,mt7622-pciesys";
>           reg = <0x1a100800 0x1000>;
>           #clock-cells = <1>;
>           #reset-cells = <1>;


