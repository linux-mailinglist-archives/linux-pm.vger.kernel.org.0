Return-Path: <linux-pm+bounces-10113-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F93091A5C9
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 13:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F4831F226E2
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 11:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44F51514DD;
	Thu, 27 Jun 2024 11:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uoupIsCr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DA514E2F6
	for <linux-pm@vger.kernel.org>; Thu, 27 Jun 2024 11:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719489363; cv=none; b=HgA5JQocnQuckZVxyMpWpInPRBYz6863pCyY16wUMv2TGqo1KL0sf7ZEOrBPIZgTOyM9rxP/wkRAlLoYp67EO1dS3ITCIDtqvTtObSutchxFi71BZNwgSC7DI0mtO5NbdQsmNZvmq1Wm6gO/9bmiRfcRO1U9tby0eKR//LzxrDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719489363; c=relaxed/simple;
	bh=GwnEq4JpqyrzCPOrdEAYPych673yINSKfG5ey35YvTw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=pRVrIsZWAg6M6Ouft7xgp8RxKS5FwcxzSYbz8DmtaUgl6kv+sTj9dnO7Vuy3yeKNsKTAsO2rMAZK/v5DMjW/zFYj+t+WcyQB+UhhcyMBObM04qk5G3AilfbM7bt+zabIQtopVqduzJNWOIPKlvRnRAn9KDAwiQdMXR1RggyYBjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uoupIsCr; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-424f2b73629so19410855e9.2
        for <linux-pm@vger.kernel.org>; Thu, 27 Jun 2024 04:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719489360; x=1720094160; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9KU4qzH+h7V/7aVO802pijoB5rQAb96UeWF6ZLoDpqs=;
        b=uoupIsCrVmBZi12L3EZ3aqzPgcNc1+JL73w79c3c0sPmvNomWA1DOTYPFiAsFr3b9y
         5BH7Uzq8js9QxBKyeUaPK/hpAaiUE2mKznpADfkYf7WEjDFl+UdR0qormjvPWZ41hCqH
         x9y5rOCbj7X5ZXgtAjtAgExyFX9i829V7IlI36Tx8MVqbvkpBp+g4X3kR4lNK+ccl3JF
         ZXqAKC39GaCKmOHKDFimlWbA0Dc2VQtc+n4sbK1yvdF5hkTEJeGY9AWS7RU1EcazHWVf
         lpUyj3OrIYFl+seScODgsVyQ87+WEpzM5zzMFMGdKbtM9FrPl4EnWQSdGMPnPA+sgNOh
         BRyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719489360; x=1720094160;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9KU4qzH+h7V/7aVO802pijoB5rQAb96UeWF6ZLoDpqs=;
        b=RzGYb4qHuRqegRf8titO7WU31QCFoi3qsSZqh7rapV1TCNdveyX1ppbJ/hCzteyA2K
         4CvKKk2qrtURgOC1qXEuKunN+38+AqdcEo2dZwmRhCsfutEsl2mAMsDQjqGku9owud2U
         Z6wFZw515ZYF6IqlGkeFbxDR8KGyynmnG7E0U0QtH7Eb+f6R9fDXuQJT9l8logcVXEQS
         xjxx0z6BWuSJnzx8ap1x/5kz5dslTsGqntfdwrk06I+VG0BZ8VoYB6uYOexUeNoAJ0OS
         nA79qRl7q8Vf+uVK41wsKyUjeQtrSFyAiHzQJmiDLVWdeKPAaB5P/qkjckWAqx4ohE+X
         6ffg==
X-Forwarded-Encrypted: i=1; AJvYcCWPSN3nfjbUl/AQMaY1So4A8uIdvsOOAnrNzVsTSWNOGLP3JcxVOThrypkXpNa8Op8zRozyuFpP1SwAoFtoz3tanOPUTF9ZvH8=
X-Gm-Message-State: AOJu0Yw4pH9T6P7roijZd+X55/t4YYBG30SEcoctvdZN0ltgwzzida1p
	hh6TnmXNwPjydInv1FRRS6P7b/tC6keDGMSp4WLYx7kUeRHCOVjgOICK4oLZmCE=
X-Google-Smtp-Source: AGHT+IGBQCwpcaZZygnFzFlfZfQDzSHbl0uIqHSmT2U3e/bWD6hKD6LiSAzVdptAdejwJkAZgCRqiQ==
X-Received: by 2002:a5d:410a:0:b0:367:437f:1785 with SMTP id ffacd0b85a97d-367437f198dmr1106036f8f.13.1719489359780;
        Thu, 27 Jun 2024 04:55:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:feeb:faed:66fa:9e6a? ([2a01:e0a:982:cbb0:feeb:faed:66fa:9e6a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3674369eb94sm1595939f8f.98.2024.06.27.04.55.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 04:55:59 -0700 (PDT)
Message-ID: <6c9a791b-aaef-4ad0-a10d-ec3acb42ac32@linaro.org>
Date: Thu, 27 Jun 2024 13:55:57 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/3] pmdomain: amlogic: Add support for A5 power domains
 controller
To: xianwei.zhao@amlogic.com, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Jianxin Pan <jianxin.pan@amlogic.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, Hongyu Chen <hongyu.chen1@amlogic.com>
References: <20240627-a5_secpower-v1-0-1f47dde1270c@amlogic.com>
 <20240627-a5_secpower-v1-2-1f47dde1270c@amlogic.com>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20240627-a5_secpower-v1-2-1f47dde1270c@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/06/2024 13:47, Xianwei Zhao via B4 Relay wrote:
> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
> 
> Add support for the A5 power controller, whose registers are
> in the secure domain and should be accessed via SMC.
> 
> Signed-off-by: Hongyu Chen <hongyu.chen1@amlogic.com>
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>   drivers/pmdomain/amlogic/meson-secure-pwrc.c | 26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/pmdomain/amlogic/meson-secure-pwrc.c b/drivers/pmdomain/amlogic/meson-secure-pwrc.c
> index df5567418226..f6729eea6b8c 100644
> --- a/drivers/pmdomain/amlogic/meson-secure-pwrc.c
> +++ b/drivers/pmdomain/amlogic/meson-secure-pwrc.c
> @@ -15,6 +15,7 @@
>   #include <dt-bindings/power/meson-s4-power.h>
>   #include <dt-bindings/power/amlogic,t7-pwrc.h>
>   #include <dt-bindings/power/amlogic,a4-pwrc.h>
> +#include <dt-bindings/power/amlogic,a5-pwrc.h>
>   #include <linux/arm-smccc.h>
>   #include <linux/firmware/meson/meson_sm.h>
>   #include <linux/module.h>
> @@ -155,6 +156,22 @@ static struct meson_secure_pwrc_domain_desc a4_pwrc_domains[] = {
>   	SEC_PD(A4_AO_IR,	GENPD_FLAG_ALWAYS_ON),
>   };
>   
> +static struct meson_secure_pwrc_domain_desc a5_pwrc_domains[] = {
> +	SEC_PD(A5_NNA,		0),
> +	SEC_PD(A5_AUDIO,	0),
> +	SEC_PD(A5_SDIOA,	0),
> +	SEC_PD(A5_EMMC,		0),
> +	SEC_PD(A5_USB_COMB,	0),
> +	SEC_PD(A5_ETH,		0),
> +	SEC_PD(A5_RSA,		0),
> +	SEC_PD(A5_AUDIO_PDM,	0),
> +	/* DMC is for DDR PHY ana/dig and DMC, and should be always on */
> +	SEC_PD(A5_DMC,		GENPD_FLAG_ALWAYS_ON),
> +	/* WRAP is secure_top, a lot of modules are included, and should be always on */
> +	SEC_PD(A5_SYS_WRAP,	GENPD_FLAG_ALWAYS_ON),
> +	SEC_PD(A5_DSPA,		0),
> +};
> +
>   static struct meson_secure_pwrc_domain_desc c3_pwrc_domains[] = {
>   	SEC_PD(C3_NNA,		0),
>   	SEC_PD(C3_AUDIO,	0),
> @@ -335,6 +352,11 @@ static struct meson_secure_pwrc_domain_data amlogic_secure_a4_pwrc_data = {
>   	.count = ARRAY_SIZE(a4_pwrc_domains),
>   };
>   
> +static struct meson_secure_pwrc_domain_data amlogic_secure_a5_pwrc_data = {
> +	.domains = a5_pwrc_domains,
> +	.count = ARRAY_SIZE(a5_pwrc_domains),
> +};
> +
>   static struct meson_secure_pwrc_domain_data amlogic_secure_c3_pwrc_data = {
>   	.domains = c3_pwrc_domains,
>   	.count = ARRAY_SIZE(c3_pwrc_domains),
> @@ -359,6 +381,10 @@ static const struct of_device_id meson_secure_pwrc_match_table[] = {
>   		.compatible = "amlogic,a4-pwrc",
>   		.data = &amlogic_secure_a4_pwrc_data,
>   	},
> +	{
> +		.compatible = "amlogic,a5-pwrc",
> +		.data = &amlogic_secure_a5_pwrc_data,
> +	},
>   	{
>   		.compatible = "amlogic,c3-pwrc",
>   		.data = &amlogic_secure_c3_pwrc_data,
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

