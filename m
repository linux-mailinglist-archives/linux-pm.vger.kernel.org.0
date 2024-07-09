Return-Path: <linux-pm+bounces-10837-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C292592B33D
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 11:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42EA21F22B0C
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 09:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0CB153801;
	Tue,  9 Jul 2024 09:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bR6e3GoC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165137BAE3
	for <linux-pm@vger.kernel.org>; Tue,  9 Jul 2024 09:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720516131; cv=none; b=mpZ9GqWACqqE/4t4Rvlz3B7EtbTl+LO++FuXgyJBGUYNEF/n3PfgUaygTgfU4m/hUgXx125j1Bq/7Q3rM8cvW3O6JvyMZlTr17ICf6EWd2uNY+Jv1V6AXDHD1HvQSKQc1e1hB05Tw4AT0gJmjmCbCO9EBWtRiwy5ZL53TNWLAR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720516131; c=relaxed/simple;
	bh=Z0xPFpGMNM1DRzaaF5OZtuXrdJ6qOuf1nCpsWBwhJ0k=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KKJz8ndD/M25yUa7bnjcWtQk3koTiL2hwqtcyZ8KzKT8chZXMPj9gAMQ9dd7Gcaqi3/YmIvm+trt3jdgvk1clf82Q4CvGHFKp+8yjM2InbGJTmVwrOskAqQxXJXfwVABB00Ou6xytuaeB8UlDQEulYvBCoutbxeaDKP8FGjYjOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bR6e3GoC; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4256742f67fso35391775e9.3
        for <linux-pm@vger.kernel.org>; Tue, 09 Jul 2024 02:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720516128; x=1721120928; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ANmKzDOIKVmKZHKX18dtZ0Xwvo3oCJHasWzFPD4tQ0=;
        b=bR6e3GoCkpNowZ88fec/nhAWdy7s974miRfJqwTkqq4F8SllCYmMuqDy/mNIogwcgN
         v4Ho56sMRJX7RwglB9yU503gA7hjoVhngvhuqJ6vzJ5B31vbI5DgZEs8V1B4ASghDwjW
         B0sgAIMMLGAYA9OLQ522X3rsscTVNVPeZW8lxg4XJBFYm1QF8e3TsGwAX/kalk++QXtF
         dmCWlGpPVFHelox/sTvDjDzVZXcPd3+a2Zqx+80p5oiWRHOUlOg32G+oc2+qATwVEos5
         AQPbyFkJVtb2ULPBK9iOrN9PsL1n1KhKOR8/xvFx/GEpBVTbkqkzlgGgdyd2vtzMUuXs
         rMcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720516128; x=1721120928;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5ANmKzDOIKVmKZHKX18dtZ0Xwvo3oCJHasWzFPD4tQ0=;
        b=fvmm2KPOI5UOQBpEKBU6Pwae302gw8pGm2bfGv0UNaCkDOusOWErN2r6eyGtYoOCV0
         t4Ib9y4pmsuyFNNQzKHt70OvoyGA1J5F4uCRRBidlA0sh0tMZY0nSU+ht98plN0A3ady
         Aucy5WR+UaSTAlnHmov0DYrDdOVT6O2TB2CmJIyktvhqRuvZ/IyyUhtWfFo7nJVt2BXO
         M8YH7xKG22np9psI/wCPk183H0tbwSoQrILFftXRqSFDFb42esKIjzTB1C7tNlru1p5U
         Tc6CKhUDZILza694DzLW6WViwNrOsUNvj0+xq15t8f20w1rR4dZLVYxffI04D+jlEPSF
         cYnw==
X-Forwarded-Encrypted: i=1; AJvYcCU8ewFk8Afl7sfyGDaN1wmYnnVqBsGEfTFnDY8PUILR0VtBhfuionTXJv0QifTvi3cWqIhcRWW/7BlmFh1/OZSPT9YFFx64Tfo=
X-Gm-Message-State: AOJu0Yy+Vh4mpVMBCvQtNc5oDudqhlOY3jl9rXTbSTtIEA3XtM5dp+W0
	97+RV/KNBZSnGzWnk3k+H/n6LI8tbm/oOKDjBwYWYZVTxhVE4zau3xwxShM33jE=
X-Google-Smtp-Source: AGHT+IE8dGfgukDFvsdorYHZw//51MvpbEXXLFPm2ybjz9IBphbGLeUpfAWThkn7OBaAt18C73eG9A==
X-Received: by 2002:a7b:c446:0:b0:426:5ddf:fd22 with SMTP id 5b1f17b1804b1-426705ce962mr12407445e9.6.1720516128261;
        Tue, 09 Jul 2024 02:08:48 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:cad:2140:b12a:8461:5e2a:dfe? ([2a01:e0a:cad:2140:b12a:8461:5e2a:dfe])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42663f049e5sm98687965e9.35.2024.07.09.02.08.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 02:08:47 -0700 (PDT)
Message-ID: <3ad982d1-6626-4618-b815-cbee1f4f4901@linaro.org>
Date: Tue, 9 Jul 2024 11:08:45 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] pmdomain: amlogic: Constify struct
 meson_secure_pwrc_domain_desc
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org
References: <871d6b708de8bb42e1fabd8a601dc9a9a217cf00.1719863475.git.christophe.jaillet@wanadoo.fr>
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
In-Reply-To: <871d6b708de8bb42e1fabd8a601dc9a9a217cf00.1719863475.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/07/2024 21:53, Christophe JAILLET wrote:
> 'struct meson_secure_pwrc_domain_desc' is not modified in this driver.
> 
> Constifying this structure moves some data to a read-only section, so
> increase overall security.
> 
> On a x86_64, with allmodconfig, as an example:
> Before:
> ======
>     text	   data	    bss	    dec	    hex	filename
>     4909	   4072	      0	   8981	   2315	drivers/pmdomain/amlogic/meson-secure-pwrc.o
> 
> After:
> =====
>     text	   data	    bss	    dec	    hex	filename
>     8605	    392	      0	   8997	   2325	drivers/pmdomain/amlogic/meson-secure-pwrc.o
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested-only.
> 
> The .is_off() function is *always* set as pwrc_secure_is_off(), so it could
> make sense to remove this function pointer and call pwrc_secure_is_off()
> directly when needed.
> This would save some memory and useless indirection.
> 
> I leave it as-is because it is maybe here for future use.
> ---
>   drivers/pmdomain/amlogic/meson-secure-pwrc.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pmdomain/amlogic/meson-secure-pwrc.c b/drivers/pmdomain/amlogic/meson-secure-pwrc.c
> index df5567418226..62857482f874 100644
> --- a/drivers/pmdomain/amlogic/meson-secure-pwrc.c
> +++ b/drivers/pmdomain/amlogic/meson-secure-pwrc.c
> @@ -46,7 +46,7 @@ struct meson_secure_pwrc_domain_desc {
>   
>   struct meson_secure_pwrc_domain_data {
>   	unsigned int count;
> -	struct meson_secure_pwrc_domain_desc *domains;
> +	const struct meson_secure_pwrc_domain_desc *domains;
>   };
>   
>   static bool pwrc_secure_is_off(struct meson_secure_pwrc_domain *pwrc_domain)
> @@ -110,7 +110,7 @@ static int meson_secure_pwrc_on(struct generic_pm_domain *domain)
>   	.parent = __parent,			\
>   }
>   
> -static struct meson_secure_pwrc_domain_desc a1_pwrc_domains[] = {
> +static const struct meson_secure_pwrc_domain_desc a1_pwrc_domains[] = {
>   	SEC_PD(DSPA,	0),
>   	SEC_PD(DSPB,	0),
>   	/* UART should keep working in ATF after suspend and before resume */
> @@ -137,7 +137,7 @@ static struct meson_secure_pwrc_domain_desc a1_pwrc_domains[] = {
>   	SEC_PD(RSA,	0),
>   };
>   
> -static struct meson_secure_pwrc_domain_desc a4_pwrc_domains[] = {
> +static const struct meson_secure_pwrc_domain_desc a4_pwrc_domains[] = {
>   	SEC_PD(A4_AUDIO,	0),
>   	SEC_PD(A4_SDIOA,	0),
>   	SEC_PD(A4_EMMC,	0),
> @@ -155,7 +155,7 @@ static struct meson_secure_pwrc_domain_desc a4_pwrc_domains[] = {
>   	SEC_PD(A4_AO_IR,	GENPD_FLAG_ALWAYS_ON),
>   };
>   
> -static struct meson_secure_pwrc_domain_desc c3_pwrc_domains[] = {
> +static const struct meson_secure_pwrc_domain_desc c3_pwrc_domains[] = {
>   	SEC_PD(C3_NNA,		0),
>   	SEC_PD(C3_AUDIO,	0),
>   	SEC_PD(C3_SDIOA,	0),
> @@ -172,7 +172,7 @@ static struct meson_secure_pwrc_domain_desc c3_pwrc_domains[] = {
>   	SEC_PD(C3_VCODEC,	0),
>   };
>   
> -static struct meson_secure_pwrc_domain_desc s4_pwrc_domains[] = {
> +static const struct meson_secure_pwrc_domain_desc s4_pwrc_domains[] = {
>   	SEC_PD(S4_DOS_HEVC,	0),
>   	SEC_PD(S4_DOS_VDEC,	0),
>   	SEC_PD(S4_VPU_HDMI,	0),
> @@ -184,7 +184,7 @@ static struct meson_secure_pwrc_domain_desc s4_pwrc_domains[] = {
>   	SEC_PD(S4_AUDIO,	0),
>   };
>   
> -static struct meson_secure_pwrc_domain_desc t7_pwrc_domains[] = {
> +static const struct meson_secure_pwrc_domain_desc t7_pwrc_domains[] = {
>   	SEC_PD(T7_DSPA,		0),
>   	SEC_PD(T7_DSPB,		0),
>   	TOP_PD(T7_DOS_HCODEC,	0, PWRC_T7_NIC3_ID),

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

