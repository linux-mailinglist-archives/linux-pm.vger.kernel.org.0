Return-Path: <linux-pm+bounces-38596-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73CFDC8547F
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 14:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F68F3B1E95
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 13:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6FE2673BA;
	Tue, 25 Nov 2025 13:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e3qA7chA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACAE26B75C
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 13:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764079010; cv=none; b=u1jVChkt47YAuEMnJQfk4Bn55NjTx6QLzCas/sXWVMv6gZq05Qjl6AjTsa8++r5zoXbKBNMA1Jjv3ZzJw6dUygvjdCjjCS4NSfHPayvIRVfTKGU0/2LkKtfxmsCI72LmJjzRgRp3jkSDMYqyUi1AUkWsnL9Vphji11Rkaf8OQyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764079010; c=relaxed/simple;
	bh=L4m4mHl/f0of1YsKOYahWRuOiJNWTG7xDNnu30Tv/bw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fin7Hz2Hq6I0evMgV0UNfrHhQs7rXTmSt7odCGJz1aX0tlTHs9rkHfDImv5d+AfwoIAyniIH1CC/nokD/4kS6AuKLu+KmBFrSN2hbKBQWgHN+u29386K1NBHDpdD9rvtpnJVEtUJzqaHYVTwh/nMpXM0fz52aCfdTJn36bBoDE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e3qA7chA; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-429c8632fcbso3500236f8f.1
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 05:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764079006; x=1764683806; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QOKmJwWRVLI79glKE6xdHe9dx8mGZzY803qUnmDLg/M=;
        b=e3qA7chAmKkbcMYO3k0tjdoa2xt5F4PMQNSFYBFY4bHeoT9khtqDo5qDPlTbJAHDCy
         3Q2A1i8i9vKpj78Py275HH1v810jth3hmLaYMHTWQOuK8IY8eRJem3eM+/ITH1Y9ydm/
         QFSbksB4JGC3YS2QOlrG70OWBb9lwqOislj0TqDTvStA9GvDUscjHtanIz6MVxfDN+gc
         yhrjaQzBl7SAQ1jHOikDHSRIhHNqjGh3y8DdxTKscf29eVEdj3tDaNZgYuQsV1ix9VBi
         mkKdyjgHuf8vABdWN8R2M9i9+NU84Vwuu6fN7JiAYmsHIxUtftw2Z0WvqVClRdfbUQ2h
         JNSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764079006; x=1764683806;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QOKmJwWRVLI79glKE6xdHe9dx8mGZzY803qUnmDLg/M=;
        b=IMg6JELwpQfJldTZ2GMeXiuZuP5oDq60xvKhi4kV43eHlfYmlPd4bjczM2Y5bXQPO4
         /POl8U8Bb8U833bsZY2khavtRwN5zS6q3Nqo4ckhI59ZA0/+mYmKX7+Vwj0BNrNdOQDA
         auogrCnel/eB+Ty3P+3mmsuJR6fBHuXRuSdbi0LFmF7bt6na95ddctgKhzwzgjcKB7wm
         v4GfqtLpAXhWaBqniWCTlCG6uAr1ymqwcQisT5VrJE819IQtOchbJGwrFZQMWqv/WHJp
         AETjAEN3wO9AN5Z8lau8Wt4hUvEAVAmkxuStpLMtNWRbg2cTU7KTbV+ssrQPvoCTp9uB
         UyDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGU4Be62lRoMOns5MWOAnZ03QxxrGZKIY6AhyJ5BaV24GyGU3T7weeU/XuMmMMIh6zTivZ7jHevg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy796W8oxiFhBO8Y+9ISfSacmeIcWJwqiKvdIutI9TGKIk2AE+/
	pyxTok0NR9e5SEou5r3GbpMbDfpIKudjiZOGY9kXzbRGDjVLNdXyXVXQ01QPWNqPs18=
X-Gm-Gg: ASbGncsTjvusibBozoHh+bvErYJMLRgsWXcNhkwpB3YEDjlNm5fsvJ4X9TZosQvEGkD
	NYx/sI+MP6LuYYcLuc+3TO9J6vKeElQqQtmd95S9oUX9JBY5I+YFwsz6Yo7iIEgqSjWnIoHdHh6
	xASqTYm9Y0PzWsU8E1T+YscMb29LG266mOeSdy9ld+USpFADNRR4efpbqm9Vx16besZWUHEBXIz
	Po1sLRegaIDwcqyMzx1tqOhM5j3tgiXEuoXvQ6ay017tvMFVjQ5oGhkkzLht/1b7EEKeWAwcoI3
	b0CE5v4SomqBJL1mwMMh8VfvP5Z1gKNq0Rx1WpTzwhkdXxKmhr7rQYjqamvOGQI7Xr+NERdELZS
	0K2+KZZlC/KgywByLyHpUZP2wPIc9GUonLJY52a6T84i1H02tPspH4Dl3zVlzTuOH8gTKDfsD0T
	sdOw4bZtKOLMnz4mOeqbWtBIpGdBqV9WHJxg+JKTX2P7pdcqciOQnF/zxIm3/b2p8=
X-Google-Smtp-Source: AGHT+IHQYDOU5Wf4pw0JNABvIsPoN88FinckcxFluDh5iW8CMtfRl+GqjWzvSI8AB6Ieto+tANa5Xw==
X-Received: by 2002:a05:6000:250d:b0:42b:41d3:daf8 with SMTP id ffacd0b85a97d-42cc1ac986bmr16822822f8f.18.1764079006044;
        Tue, 25 Nov 2025 05:56:46 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3d9:2080:dea1:baf7:4d0c:118e? ([2a01:e0a:3d9:2080:dea1:baf7:4d0c:118e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cbd764dbesm31274248f8f.27.2025.11.25.05.56.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 05:56:45 -0800 (PST)
Message-ID: <8e75b00d-06c3-4f8c-91c2-42d468a67a12@linaro.org>
Date: Tue, 25 Nov 2025 14:56:45 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] power: sequencing: qcom-wcn: use device_get_match_data()
To: Bartosz Golaszewski <brgl@bgdev.pl>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20251125134700.29135-1-brgl@bgdev.pl>
From: Neil Armstrong <neil.armstrong@linaro.org>
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
In-Reply-To: <20251125134700.29135-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/25/25 14:47, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Use the generic fwnode interface for retrieving device match data
> instead of the OF-specific one.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>   drivers/power/sequencing/pwrseq-qcom-wcn.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/power/sequencing/pwrseq-qcom-wcn.c b/drivers/power/sequencing/pwrseq-qcom-wcn.c
> index 663d9a5370653..823f68ffebd1a 100644
> --- a/drivers/power/sequencing/pwrseq-qcom-wcn.c
> +++ b/drivers/power/sequencing/pwrseq-qcom-wcn.c
> @@ -12,6 +12,7 @@
>   #include <linux/module.h>
>   #include <linux/of.h>
>   #include <linux/platform_device.h>
> +#include <linux/property.h>
>   #include <linux/regulator/consumer.h>
>   #include <linux/pwrseq/provider.h>
>   #include <linux/string.h>
> @@ -373,7 +374,7 @@ static int pwrseq_qcom_wcn_probe(struct platform_device *pdev)
>   
>   	ctx->of_node = dev->of_node;
>   
> -	ctx->pdata = of_device_get_match_data(dev);
> +	ctx->pdata = device_get_match_data(dev);
>   	if (!ctx->pdata)
>   		return dev_err_probe(dev, -ENODEV,
>   				     "Failed to obtain platform data\n");

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

