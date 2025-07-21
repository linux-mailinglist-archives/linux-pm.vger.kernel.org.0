Return-Path: <linux-pm+bounces-31242-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4579FB0CBA3
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 22:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BD793A90FB
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 20:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B4923D287;
	Mon, 21 Jul 2025 20:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="merfMegC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677CE23A9B3
	for <linux-pm@vger.kernel.org>; Mon, 21 Jul 2025 20:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753129065; cv=none; b=TrnpKy3hLIkPPMQDRIt/7XFPtdp1pJ1bBKBGX8l5VXYzQso/PrgVwqKyrotYZma2NF8lIqDCb+Eq78e5cNrK11WOcgAT6DM9gYUjHChTw6P7BaEX0hp8QJ04vm8DkPdGhJEl2tLJUJfl8iemJdt0z8vkTSXizwBf6XA0N1OMkB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753129065; c=relaxed/simple;
	bh=qNMjXYg7gSvi1w4o66Q/qp0UaJ/AUdAOz9hXwpFbNPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nwLC2MPEx4yfQTY8EQ3IEiow29sReD04+ecbN01uxKIqSVO7jG1g6OI/RM2/jf+PAnXPwpxXErQtvaCaI+hMNx1vg0klFdmfgPKfzHY1JxCyJAexZVSM1WYK6nFTaxpGxRTyDzg0LAiDgqIce83C5ZC79+xGPQpooowmosephVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=merfMegC; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-456108bf94bso33683715e9.0
        for <linux-pm@vger.kernel.org>; Mon, 21 Jul 2025 13:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753129061; x=1753733861; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dM8V1L459ePaBP5oquLpSUwSE8BaJwvLWNciMOJOtaY=;
        b=merfMegCMYwWsN27o6ZvoKAxuiIDUz2j+UCUcAXwR4cjDZzRxEDJXuNcS09EE58Wlx
         rCQ2CjyTmdx6FINi2LCktDlVkhBg4Zhqx26Ph9KeelPhiICTgvckMXLPGGzPMLLTy5dh
         xlhFsq0nJq7x5dHhHotX9tnvk5jBzpR+ubTOAUId1ewM100vMauN/LUJIxo+dSwWmkLl
         ZK/U647XyHymDEKFHOgW0iUl/gWtu+53kCixSGvaBdX9GtRmh/oaKEafGa+oW15I0GfU
         TtWx8KAD7MrLdTTa+G7U/FL6VmAZx1O8OYTkcbmBgUadq7MO/oM86zTmrvNKkjjZiEoY
         bAhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753129061; x=1753733861;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dM8V1L459ePaBP5oquLpSUwSE8BaJwvLWNciMOJOtaY=;
        b=qYd1W9sAR7Qr2CVS63WKk6OQbhLw35nQt3JSN7H1Tpm3niPea/KeR0L5v2/SOkm7UO
         cr98A05qbea0sIaaMrIS9gBUDNud2Ct7XITWRQ0hZYEP+/NzsWfTz33nxd5rsFNGz2JC
         LEZfKTUvMRnox/Cz3raXrM/972EHOA3nm+lfXKZpg5cVs8yWp+qpN8l1ZuJajWHLw9Er
         m2SPfjRJkUng1IL9xATbfXOc5uXYI5YdsFMYRjPWB3s8cWsCDSjRkSw5FBu+WyIHeJbu
         kUQPpD0BwkujEDbJotn1ZXy0iKBypQxYA0zi124uVMZo+EV2uXmpeScXtqSnC9WghEo4
         CyNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnNKxxYXkpqb7a6/6tOkhIVt5HpI8saRoT/cKFOMc5bX+rmVJ+7S1MlTgt5O0XwRzyTTYmp6Xxlw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxIQLKqfiuHdfabXGewgN1qIqWHXUpAFdtaiESqFP9SvvTX1bSD
	Pst85MlpNWalqFLal6r2EgDv/LLvW0dkN9M1+rEgKEnNvzep7NLgLSpqyFFBA/D2Piw=
X-Gm-Gg: ASbGncuuqXVsDC49i0rjLWlTRqvHntMIGKMEqa8trVypuzgXDKCaHZwUTjCL/n0d9Zr
	mGo1K20ZJF8D81FDdlmWt6A1ZP1N2ttCpOAnt8IWbhvACJjb7oo4O4AceFqI21+AkmDC6Iv4dxL
	9THZ/5zDd2C2OBhZoYCohh9VnsuuEID8HjpGAvdjzRmgKChrZSOjAaVFBPsCdmHzFPYTluXC2VZ
	yScmbOXegvtiIRTghe50wCQUFbE7WW6n4ZTowgSjE7EFZ34wFkyQ2E3ooG+uBFQhbY/A5BvMyF+
	nwznnJRgHkSIEdBsteYFfS+mJIK07ex5DJfNTBqJLwirM6uPIz1FUjASfskGKqJBiBA0Z3d2o+d
	Ug19dEIGbpPiTyXZoUsQoeiaC6cMGYp1rAzx+leDTtixaWVsEtj68CPXI5YQsYs9Fgwik7ZuD4p
	4t+gI=
X-Google-Smtp-Source: AGHT+IF62Mz23f/3FxKSXRlhY6X69Vv1j/s22nJAkdHPupT9WjDcJMNWjSNh7x1kPOXtrItb7cZ4Dg==
X-Received: by 2002:a5d:64e8:0:b0:3a5:8a68:b839 with SMTP id ffacd0b85a97d-3b60e53ee0amr17139819f8f.45.1753129060690;
        Mon, 21 Jul 2025 13:17:40 -0700 (PDT)
Received: from ?IPV6:2a0d:e487:135f:abd:1f99:991c:5b07:cd28? ([2a0d:e487:135f:abd:1f99:991c:5b07:cd28])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b61ca4894asm11444490f8f.49.2025.07.21.13.17.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 13:17:40 -0700 (PDT)
Message-ID: <8792778e-1fe6-4eff-9328-767ed38a1583@linaro.org>
Date: Mon, 21 Jul 2025 22:17:36 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/17] dt-bindings: thermal: tegra: Document Tegra210B01
To: webgeek1234@gmail.com, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nagarjuna Kristam <nkristam@nvidia.com>, JC Kuo <jckuo@nvidia.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Mathias Nyman <mathias.nyman@intel.com>,
 Peter De Schrijver <pdeschrijver@nvidia.com>,
 Prashant Gaikwad <pgaikwad@nvidia.com>
Cc: devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-usb@vger.kernel.org, Thierry Reding <treding@nvidia.com>,
 linux-pm@vger.kernel.org, linux-clk@vger.kernel.org
References: <20250714-t210b01-v1-0-e3f5f7de5dce@gmail.com>
 <20250714-t210b01-v1-5-e3f5f7de5dce@gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250714-t210b01-v1-5-e3f5f7de5dce@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/15/25 06:02, Aaron Kling via B4 Relay wrote:
> From: Aaron Kling <webgeek1234@gmail.com>
> 
> Add the compatible string for Tegra210B01 SOC_THERM
> 
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>

Applied patch 5/17

Thanks

> ---
>   Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.yaml | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.yaml b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.yaml
> index 19bb1f324183bb22bc75630798da67fc834920b8..cf47a1f3b3847d4a0371d0bc711638fc5e3b6cd3 100644
> --- a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.yaml
> +++ b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.yaml
> @@ -21,6 +21,7 @@ properties:
>         - nvidia,tegra124-soctherm
>         - nvidia,tegra132-soctherm
>         - nvidia,tegra210-soctherm
> +      - nvidia,tegra210b01-soctherm
>   
>     reg:
>       maxItems: 2
> @@ -207,6 +208,7 @@ allOf:
>               enum:
>                 - nvidia,tegra124-soctherm
>                 - nvidia,tegra210-soctherm
> +              - nvidia,tegra210b01-soctherm
>       then:
>         properties:
>           reg:
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

