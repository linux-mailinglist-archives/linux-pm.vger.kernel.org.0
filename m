Return-Path: <linux-pm+bounces-5584-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5CF1890136
	for <lists+linux-pm@lfdr.de>; Thu, 28 Mar 2024 15:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55B521F21CB5
	for <lists+linux-pm@lfdr.de>; Thu, 28 Mar 2024 14:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3527F127B66;
	Thu, 28 Mar 2024 14:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="azqFJHfO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407E339FD4
	for <linux-pm@vger.kernel.org>; Thu, 28 Mar 2024 14:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711634878; cv=none; b=db3mETyJZu4/lQpLRULBVmUrjw0dagqsZPCvMCtYg6zO8CBfGUfeE/L1z8wk3k1dMykBj7aISU58xHpOvvnh3d685YlGsQ/yvFolCSP16UrZ3X28kQNrSqUW+BUwTMcwCJ033bEe4jms1Z4mrd8OLlMwUeYMM6H2hhxUQLWs56w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711634878; c=relaxed/simple;
	bh=2k6ORstxTR1rltKyQtMpHECxE1qHT1fg/ZtPbRvBX2w=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=UdbpqpU7wfPfAOPDfS7tiX1L/qdWpgL932v6oi0RdKjX6m1GBpu7URHvdB7WvOoKgWtguVfTIQQbNHRHH31FLCq/vT4/zDcFt4uAa8l7MXVZAY3QFjAlzjcKZICisQpW50Pfoa2N2KyZxu6AVYCUs8WN4lR4rJLo1gX5bZBGNkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=azqFJHfO; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d68c6a4630so10257551fa.3
        for <linux-pm@vger.kernel.org>; Thu, 28 Mar 2024 07:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711634874; x=1712239674; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wP+ZPQTFaT7dJC4++e1l/MpToBl5GmVhiDRKTTRN6DM=;
        b=azqFJHfO0F0lC77HL0+tIZxk/jYKN8YgZ1/FgOu2c7avf5oja94E3h8LxttKCL84Q4
         flgoJmWUpMvTfOsJbwNC9674CvYbqCC/8Y6V40Ws+VCga21VPBFtIcKcaRSVhH0PLroT
         THuf9BGUTyrrPkzUW5r3/zSziF3o59CTi7GJa+bfDowjDaZZesjA4GF+jdP0Ajj5NG55
         ZhT9cZHf/ewZHmqsAYxzaJ2898LBtRLokRmOZGNycAZkgpIYv2Y2mDPBtwD52rYbyAoY
         s8BRwayWGs+xKc0+zZ2DinVhWq7OlD9q9872sdSo6VexroO4chnzZunf1hbsDYNtY9rS
         20Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711634874; x=1712239674;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wP+ZPQTFaT7dJC4++e1l/MpToBl5GmVhiDRKTTRN6DM=;
        b=JXyjKZlkHsxGfU6eQ9aXW+K5AKzBHDtwEeZ1JE+p1E65PtWhCh0u3owrh7NZdOB4tC
         WPw3Ak+u+pb+XlrvLfAwnRc8s+w9ew8w+65n2trq9Ho9wXoBMLpWoxl/2ZITbZFt+Cvy
         C9lr/mZ1rd14svqlv22256zyy8q5xoFvAlNJMhAQbApqVWyM22pRESt0caFS83J4mGRR
         BBjgA7qt8knvmKU//R4TrI/uN0ALi+LoHGuUBvIcYoPOGig0qJsUQrd0akTDeBKarBbX
         F8gLMLxXJE2ceIPastIr5J7xD2Ak9Vizobepg4owGHWiaF9eeRBOj666s/DNMw5FsUvk
         TmIw==
X-Forwarded-Encrypted: i=1; AJvYcCXaLA7/x2t0sluLS7bMntz1zF27GLD7Ss3xrPhdnkEpJJSxKVB8ZdRFMeMoKKhNfYlnYcPjPF0bbGn87IgoDRJqOnnlPOt1Heg=
X-Gm-Message-State: AOJu0YwGlL4BTAZ59COPJwv8v0jUfxaiVVg9RWN7a+MjYpxv2Pq8TjEl
	ba/HYHCdNtgJAAYT7mqjZx/RL2Th1la3qgMPLGM1hvERwySm5IDbTqzpeM3pyI0=
X-Google-Smtp-Source: AGHT+IH6ZYT9rKlA75QKZqgaxnipCnDFWVuubAQIHNJlqj7IWgBBnTpQl5J08e0KHQPxv5VnxQnQwQ==
X-Received: by 2002:a2e:9156:0:b0:2d7:f26:9a9f with SMTP id q22-20020a2e9156000000b002d70f269a9fmr731480ljg.4.1711634874273;
        Thu, 28 Mar 2024 07:07:54 -0700 (PDT)
Received: from [192.168.7.190] (82-64-249-211.subs.proxad.net. [82.64.249.211])
        by smtp.gmail.com with ESMTPSA id m28-20020a05600c3b1c00b00414688af147sm5555801wms.20.2024.03.28.07.07.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 07:07:53 -0700 (PDT)
Message-ID: <19897482-2fa1-4688-aeec-855123558374@linaro.org>
Date: Thu, 28 Mar 2024 15:07:52 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 1/2] dt-bindings: thermal: amlogic: add support for A1
 thermal sensor
To: Dmitry Rokosov <ddrokosov@salutedevices.com>, jbrunet@baylibre.com,
 mturquette@baylibre.com, khilman@baylibre.com,
 martin.blumenstingl@googlemail.com, glaroque@baylibre.com,
 rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com,
 lukasz.luba@arm.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org
Cc: kernel@salutedevices.com, rockosov@gmail.com,
 linux-amlogic@lists.infradead.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240328133802.15651-1-ddrokosov@salutedevices.com>
 <20240328133802.15651-2-ddrokosov@salutedevices.com>
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
In-Reply-To: <20240328133802.15651-2-ddrokosov@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 28/03/2024 14:37, Dmitry Rokosov wrote:
> Provide right compatible properties for Amlogic A1 Thermal Sensor
> controller. A1 family supports only one thermal node - CPU thermal
> sensor.
> 
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> ---
>   .../bindings/thermal/amlogic,thermal.yaml          | 14 +++++++++-----
>   1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
> index 20f8f9b3b971..0e7f6568d385 100644
> --- a/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
> +++ b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
> @@ -13,11 +13,15 @@ description: Binding for Amlogic Thermal
>   
>   properties:
>     compatible:
> -    items:
> -      - enum:
> -          - amlogic,g12a-cpu-thermal
> -          - amlogic,g12a-ddr-thermal
> -      - const: amlogic,g12a-thermal
> +    oneOf:
> +      - items:
> +          - enum:
> +              - amlogic,g12a-cpu-thermal
> +              - amlogic,g12a-ddr-thermal
> +          - const: amlogic,g12a-thermal
> +      - items:
> +          - const: amlogic,a1-cpu-thermal
> +          - const: amlogic,a1-thermal

In this case you can just use "amlogic,a1-cpu-thermal" or "amlogic,a1-thermal", no need for a fallback.

Thanks,
Neil

>   
>     reg:
>       maxItems: 1


