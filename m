Return-Path: <linux-pm+bounces-8628-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFA78FC8A5
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2024 12:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 570D7285988
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2024 10:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A43C19006C;
	Wed,  5 Jun 2024 10:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TjaOgpZE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905F4257B
	for <linux-pm@vger.kernel.org>; Wed,  5 Jun 2024 10:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717582040; cv=none; b=LQhIgIHncGb5MXhvxvvVoxKFwd4RDMyCt5uhiWOHkI7dPSBGpMuX+vPfB6tyVpEG5v7iZf4bUF4rj+0PyxO1bdO8APYHoZaV/9fumILu8FASeW/XppbmBtuqtMYnIVUFzdr6M+5/QNWWigCf7R+jGiDXFlDKDX6FCiC33DkAuYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717582040; c=relaxed/simple;
	bh=eQ+BxkDDoNzYGeZoV7pOSbf6WYkef8hUsLWmoqZRv88=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KkS3Ra+MVEZRjE1qRpVVXuvzp3SlvH2/ndj1in27iShaO7+53kbhUyawOaGrDCHYbEZy0sjckwnPvJGzFz+kZ9sYI62dUVP7gBK98E5lb7tXW9dHDmY2loPliMx1Mglh1B1x0RbG2Hze1xIzqZZisZYpSYgLJb8czHFKBHQrnfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TjaOgpZE; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2e72b8931caso72264201fa.0
        for <linux-pm@vger.kernel.org>; Wed, 05 Jun 2024 03:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717582036; x=1718186836; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y5v2wvzfpTFQoJgp9Ncwu8fEm9eW+i4elxXXvmKBJ7o=;
        b=TjaOgpZEto91TMmkJ0PWBZbD0zmhhJZ8HJmcdkvRH2Jj1PW/5SUPV/cy+nYs6Kkf5n
         SkhYUrNoxoGcQrNuBuC9XZrBRM9nTKp8Kv6Rp42NCJKfCLpCObsQMifdDkR5X0yOeWel
         aR+YVWmPnS61PanZM9yXPXWflbnRWWIcE9rzUPhKdADv9Z+Hk+wnO5UiffZkfij7F4Dx
         6/AFGLg52fYzie+s5PhJsyd04IMMgR1Dg8n8OObT7oKCp+neiAbJZ1VQi77V8HdNqwHg
         LPytrNAXsgTcjX7xzSSB7A3AC+58UwX1d3ZQvLAvPkuu9A5WCtvOGuVpkYsjY6hLKPQD
         dYtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717582036; x=1718186836;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y5v2wvzfpTFQoJgp9Ncwu8fEm9eW+i4elxXXvmKBJ7o=;
        b=ubHAdWczSGgcJBLhAflM1gWo8sKOLr2LKvxf1LMVSBNWVvtRMOwCBOPHcQGnKqFKA/
         TVod3zedLROskBFgqrmdmMRKWOKjRWUrRG96kLZJ+mVKoLCeMbJOvszQaMQuR9N8hK0G
         LHYj7FrLhR9BuSoTp2uR4zryu/1WXRSbYy/kYojOd2OxnuEK5fjcFhbAxydr9EpaVobY
         nHcdQzEWR90v0aGRY/0eQS348lCBSQR13pWWyVTtVDfPrqZmhQIj7St1QTbTHxwZ3nIX
         T8+jlH+p7xcOKFD4zeKIv36fU2hTG2jHRsedInD77YQT4A8egveFMfyNFw5Q0v8y1kdt
         1ZTw==
X-Forwarded-Encrypted: i=1; AJvYcCUwNB92ApdN39nrKHqqMoAfpnTLo4GK76GiryQR4+D/1oDArQw4Xddl2pIziVn7E5ACIo/CqqLtocnuer0KP4UZrS4ocap7q7Y=
X-Gm-Message-State: AOJu0YzVdmJ0v6AepmUAmK9E820B1KWHsQ5aCdNumIKXeeOtk2jU7sRW
	szpL/8FCVzxgrJJGZStS2a3zc5KMvl0297GJ7VLglytX2PJVwT5usS1DoTcnUfA=
X-Google-Smtp-Source: AGHT+IGxrxdoQDwGY9zNXeTKIBS/v9Z1wrUt9JmYGDol9OBU9lDeSpjdMVHII7s/W6pfdoH+//8YEQ==
X-Received: by 2002:a05:6512:3ca2:b0:52b:8613:9d2d with SMTP id 2adb3069b0e04-52bab4fa5d3mr1438631e87.55.1717582035641;
        Wed, 05 Jun 2024 03:07:15 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:c7ce:7756:462d:a8bd? ([2a01:e0a:982:cbb0:c7ce:7756:462d:a8bd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42158111143sm15697925e9.20.2024.06.05.03.07.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 03:07:14 -0700 (PDT)
Message-ID: <f9350177-6543-4979-94c1-5c08c373c6b8@linaro.org>
Date: Wed, 5 Jun 2024 12:07:13 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 3/3] arm64: dts: amlogic: a4: add power domain
 controller node
To: xianwei.zhao@amlogic.com, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Jianxin Pan <jianxin.pan@amlogic.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20240529-a4_secpowerdomain-v2-0-47502fc0eaf3@amlogic.com>
 <20240529-a4_secpowerdomain-v2-3-47502fc0eaf3@amlogic.com>
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
In-Reply-To: <20240529-a4_secpowerdomain-v2-3-47502fc0eaf3@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/05/2024 05:10, Xianwei Zhao via B4 Relay wrote:
> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
> 
> Add power domain controller node for Amlogic A4 SoC
> 
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>   arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
> index 73ca1d7eed81..de10e7aebf21 100644
> --- a/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
> @@ -4,6 +4,7 @@
>    */
>   
>   #include "amlogic-a4-common.dtsi"
> +#include <dt-bindings/power/amlogic,a4-pwrc.h>
>   / {
>   	cpus {
>   		#address-cells = <2>;
> @@ -37,4 +38,13 @@ cpu3: cpu@3 {
>   			enable-method = "psci";
>   		};
>   	};
> +
> +	sm: secure-monitor {
> +		compatible = "amlogic,meson-gxbb-sm";
> +
> +		pwrc: power-controller {
> +			compatible = "amlogic,a4-pwrc";
> +			#power-domain-cells = <1>;
> +		};
> +	};
>   };
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

