Return-Path: <linux-pm+bounces-10690-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EFF79287AE
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 13:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C6D3B23B41
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 11:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15B8149C45;
	Fri,  5 Jul 2024 11:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UCbEUYgf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A96E148FF3
	for <linux-pm@vger.kernel.org>; Fri,  5 Jul 2024 11:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720178312; cv=none; b=Tm5oLI6289as15pKtHmDaJF56qfdtA3/WDcxiZ4cR3l81onFghhxae6dS7dTS1IUQDFr4c0Gle2HgmbYrCSOkQCpYVpSIVn+zIH+IFGAMlq5jxCqi+dTWuIPwduKA/7bjNmz6nv+dIpqtri1nE2jIeRWuVsfSieLYwC+PAkCRgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720178312; c=relaxed/simple;
	bh=COzKA0BcrGQn+MbmWfktjVwdYe3fKKtWtwipRxZp4bM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E4DCzKJ0S+cRhoIWrsUvyIahrInet/TjAf0emynCJ1nTPwAuLlzC3pQk7vngoFhgST+IFwfv9XlAOUjWcSojN3xHWd0U6KVrK0nwebxi9zKX7E1ZVpO1u+eMZVOolorQegmWc+efSO+tv4u+yGr0HVsMQZnnX2MzOKZ8PUedK/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UCbEUYgf; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ec61eeed8eso19422991fa.0
        for <linux-pm@vger.kernel.org>; Fri, 05 Jul 2024 04:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720178309; x=1720783109; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OgGdrMJAOOlmaDA5n6UZ/NcHyTcSq/fRMMLBh3RpPPA=;
        b=UCbEUYgf7lZ9q8dyZVdF4VEsQqCwj/9hvE+jdXhJ+f4c34+E0lH/D+NIp9B+VZV7La
         tFKslq+8+bs0F+aYXOYZ+SXwx0GuPSo7eQ/OPUP48I8TQgRNwT5iJks3EGXTLMyXS6OC
         UcNZFRQofzbvpNLen9JTQW6KCwfg9QxZfzygFOUWhh2qTjib8BbikbUUx+ZjEv5HLcK5
         VBtIEvKmdUiv7ckSIhidfC0Yhgk8szirCiJxa8oPmU2t78GOc/A6ZYvd8uGYia03OjL7
         BG6ZpUR6z9DPYbw17WTVsdX3nkF0LhRPdzIZXMYcX3FHgTKf9zKRcfD1TNsocu6q8fPO
         Gqmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720178309; x=1720783109;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OgGdrMJAOOlmaDA5n6UZ/NcHyTcSq/fRMMLBh3RpPPA=;
        b=giy8/PW5/nfABXJ5C/5NEQMoxPC/OJ+W6hcG7a1TQp3AresTCnWFok02kUEJXzhjHR
         9gm+iycdd6WFvGTae0cSYBAAmiS+sc0YCPLyJi7Rb3eqtuCUMXO4QgLlQR0FETFY/UHk
         Sths2fjIL78R/MA/1+JVP49wqwWJXMNebM4ad3soKvY6KqpvNiw9NrDNw+vIaN05qW4G
         MU18f30D7jSzJBQ1CfrR/sylx+caGveZW34NFy+4JcPXo3YYkGDMXjkeyZXSPU+c49cs
         zKgh+2ckW0UplQR1qhRVkw59mCJk2QXSFREdZ07JpM2BGPeXswmM4t7TxNwy/kLJxYAx
         FZaA==
X-Gm-Message-State: AOJu0YxjpyVGVVSboYs6aHXfkLx5O7B+NUkZM0NjkJs1W0zsYG7vPkuB
	w84bsepL63X7wVQFnijWHHETIsV8y73CJASeUFFRVESMQhj/57O9psjYgT7Mx/g=
X-Google-Smtp-Source: AGHT+IHyMkgn3/gFNE4gv4OJO59bQCoHWgHlPXJAezaplNmRkJ1y1keb/pz2mmb4jwElkz5448BGKA==
X-Received: by 2002:a2e:2e06:0:b0:2ee:8815:8b28 with SMTP id 38308e7fff4ca-2ee8edd3ec5mr24871001fa.33.1720178308668;
        Fri, 05 Jul 2024 04:18:28 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3678fe13ef4sm7369352f8f.117.2024.07.05.04.18.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jul 2024 04:18:28 -0700 (PDT)
Message-ID: <2aa71d0f-6e4a-4056-9deb-a46526b423a9@linaro.org>
Date: Fri, 5 Jul 2024 13:18:27 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 00/22] dt-bindings: thermal: few cleanups
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Zhang Rui <rui.zhang@intel.com>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Fabio Estevam <festevam@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-sunxi@lists.linux.dev, imx@lists.linux.dev,
 linux-tegra@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Florian Fainelli <f.fainelli@gmail.com>,
 linux-rpi-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Conor Dooley <conor.dooley@microchip.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Vasily Khoruzhick <anarsoul@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Amit Kucheria <amitk@kernel.org>,
 =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
 Heiko Stuebner <heiko@sntech.de>, Biju Das <biju.das.jz@bp.renesas.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
References: <20240705-dt-bindings-thermal-allof-v1-0-554061b52fbc@linaro.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240705-dt-bindings-thermal-allof-v1-0-554061b52fbc@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05/07/2024 11:51, Krzysztof Kozlowski wrote:
> Hi,
> 
> Resending (with added tags) because patchset was still not applied.
> Daniel, can you pick it up?

Yes

> Few cleanups witout practical impact, except maybe the Amlogic schema
> (bringing required cells).
> 
> Link to v1: https://lore.kernel.org/r/20240614-dt-bindings-thermal-allof-v1-0-30b25a6ae24e@linaro.org
> 
> Best regards,
> Krzysztof
> 
> ---
> Krzysztof Kozlowski (22):
>        dt-bindings: thermal: samsung,exynos: specify cells
>        dt-bindings: thermal: amlogic: reference thermal-sensor schema
>        dt-bindings: thermal: allwinner,sun8i-a83t-ths: reference thermal-sensor schema
>        dt-bindings: thermal: brcm,avs-ro: reference thermal-sensor schema
>        dt-bindings: thermal: generic-adc: reference thermal-sensor schema
>        dt-bindings: thermal: imx8mm: reference thermal-sensor schema
>        dt-bindings: thermal: nvidia,tegra186-bpmp: reference thermal-sensor schema
>        dt-bindings: thermal: nvidia,tegra30-tsensor: reference thermal-sensor schema
>        dt-bindings: thermal: qcom-spmi-adc-tm-hc: reference thermal-sensor schema
>        dt-bindings: thermal: qcom-spmi-adc-tm5: reference thermal-sensor schema
>        dt-bindings: thermal: qcom-tsens: reference thermal-sensor schema
>        dt-bindings: thermal: qoriq: reference thermal-sensor schema
>        dt-bindings: thermal: rcar-gen3: reference thermal-sensor schema
>        dt-bindings: thermal: rockchip: reference thermal-sensor schema
>        dt-bindings: thermal: rzg2l: reference thermal-sensor schema
>        dt-bindings: thermal: socionext,uniphier: reference thermal-sensor schema
>        dt-bindings: thermal: sprd: reference thermal-sensor schema
>        dt-bindings: thermal: st,stm32: reference thermal-sensor schema
>        dt-bindings: thermal: ti,am654: reference thermal-sensor schema
>        dt-bindings: thermal: ti,j72xx: reference thermal-sensor schema
>        dt-bindings: thermal: simplify few bindings
>        dt-bindings: thermal: cleanup examples indentation
> 
>   .../bindings/thermal/allwinner,sun8i-a83t-ths.yaml |  6 +-
>   .../bindings/thermal/amlogic,thermal.yaml          | 22 ++---
>   .../bindings/thermal/brcm,avs-ro-thermal.yaml      | 22 ++---
>   .../devicetree/bindings/thermal/brcm,avs-tmon.yaml | 17 ++--
>   .../bindings/thermal/brcm,bcm2835-thermal.yaml     |  1 -
>   .../bindings/thermal/fsl,scu-thermal.yaml          |  1 -
>   .../bindings/thermal/generic-adc-thermal.yaml      |  5 +-
>   .../bindings/thermal/imx8mm-thermal.yaml           |  5 +-
>   .../bindings/thermal/loongson,ls2k-thermal.yaml    |  1 -
>   .../bindings/thermal/mediatek,lvts-thermal.yaml    |  1 -
>   .../bindings/thermal/nvidia,tegra124-soctherm.yaml |  1 -
>   .../thermal/nvidia,tegra186-bpmp-thermal.yaml      | 12 +--
>   .../bindings/thermal/nvidia,tegra30-tsensor.yaml   |  9 +-
>   .../bindings/thermal/qcom,spmi-temp-alarm.yaml     |  1 -
>   .../bindings/thermal/qcom-spmi-adc-tm-hc.yaml      |  8 +-
>   .../bindings/thermal/qcom-spmi-adc-tm5.yaml        |  8 +-
>   .../devicetree/bindings/thermal/qcom-tsens.yaml    | 96 ++++++++++------------
>   .../devicetree/bindings/thermal/qoriq-thermal.yaml |  5 +-
>   .../bindings/thermal/rcar-gen3-thermal.yaml        | 69 ++++++++--------
>   .../devicetree/bindings/thermal/rcar-thermal.yaml  | 60 +++++++-------
>   .../bindings/thermal/rockchip-thermal.yaml         |  5 +-
>   .../devicetree/bindings/thermal/rzg2l-thermal.yaml | 41 ++++-----
>   .../bindings/thermal/samsung,exynos-thermal.yaml   |  3 +-
>   .../thermal/socionext,uniphier-thermal.yaml        |  5 +-
>   .../devicetree/bindings/thermal/sprd-thermal.yaml  | 47 +++++------
>   .../bindings/thermal/st,stm32-thermal.yaml         |  5 +-
>   .../bindings/thermal/ti,am654-thermal.yaml         | 15 ++--
>   .../bindings/thermal/ti,j72xx-thermal.yaml         |  5 +-
>   28 files changed, 230 insertions(+), 246 deletions(-)
> ---
> base-commit: 0b58e108042b0ed28a71cd7edf5175999955b233
> change-id: 20240614-dt-bindings-thermal-allof-401c50e61ef2
> 
> Best regards,

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


