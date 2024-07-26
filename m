Return-Path: <linux-pm+bounces-11432-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECE093D3DD
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2024 15:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68621286BC1
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2024 13:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A770817BB23;
	Fri, 26 Jul 2024 13:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lpq8sHos"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046B917BB03
	for <linux-pm@vger.kernel.org>; Fri, 26 Jul 2024 13:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721999636; cv=none; b=hIVfaV54tL201jDXRQmGUatqaY8oTaYkQybNfqQP5fmgdi1mMdSEoqxONTkj6LY4JqWZYTiqqgiOEsQdVT+opqm8biqj5MFAwlEYxV1EEMaHq1cT/9TT2ImLFrk4A4YViKkr1VXQRlYYIyVRh9x1r5BHZIF01PgucTS0lgcC7kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721999636; c=relaxed/simple;
	bh=Cdmr1wNOXg3YuxF+fm5Dem5hL4V7dSar/S6BwJB33LY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=JT0DNGpF56ZkL34csQhboXJifxwcyZy7H19JyEUWTsY48ey/YhtCWsHqtQ+jPSadT1rP6L46Klf5lH+kSqZqSG8tpBpqGu2O6wuUNkkNI83jNM3Xo7SO281LNmxVceXvt3spF+KAwJRPR4nyk4FBDM3S5H6fNGSeRsi/R1EeI9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lpq8sHos; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ef2cb7d562so15324871fa.3
        for <linux-pm@vger.kernel.org>; Fri, 26 Jul 2024 06:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721999629; x=1722604429; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zh3vyC1WH4G3/hH1Lds2F5b/d+/by8NtQNhwTrmTrdY=;
        b=lpq8sHosHFvYj/G4H4eyCI5FkUEXF5DO8WxdFevId+KpjjJxpyugP1IWUD4D4Oq2+L
         bxOafjX9um/OIBUE7y7/5W+r5rPGDZg/wA8crFrxSJoHsScEE3NPhR03WfusuYlGSZLV
         fj16c++4JdTXfjQZlX6Xbu8sOYgiFSlnUcxqG4TRJGBGiVe3dJnVedzKFGMr6mBud9dF
         2ekAaVNvTadEXoAKPlKbBYwSJTV070mWwUMXHZVWNWKE8qjDcpBcFFvI23Dhsw46GotL
         WcWFHcKowjXPrvz1jqZcSRsytZ2+1CuzOBHC2HxgOiK+676TG8WvM+tNty4v0VSGuVEr
         NeOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721999629; x=1722604429;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zh3vyC1WH4G3/hH1Lds2F5b/d+/by8NtQNhwTrmTrdY=;
        b=KQO4isxWQxgtufAGOvnEnAbiZrlsZep8llL4/hVLDk7gFQbha7nSje6mExWAgoLOzp
         DH3oZydtmvA1GGyK+c1Tz99YwH87jfJPKDsDFzKfxgJCrT7OHOH0Ay1o8n4yXIlAPKI4
         W3N3g367JY8SDRRpEHN2ZrE3M4yWmmT8DhKjZ2nRl+g0/JEmiPZfXSdJ0vJO2gEKGLl7
         U4RDptXlw7zFpgPfOSKht0z7EHBqafeF+Ny9EoUAm3M5DAnIQDfAk5oa1oBCBEpNm7pI
         3Bruqxvb7fIoMox5Q7YjoQbnvhoS7E8CIEB1YKsW9iVKsOhNuh+Vt/ZTrHfy2I4XMsWI
         DIbg==
X-Forwarded-Encrypted: i=1; AJvYcCU9GlREGBn7s5WCAkbuAJ0ihW5wGTw8XboF1PS5Cvr1sl4o1kkWdfr7yW85NsyuB7dOFyphbLzwei60uPEvTw7/16O29n3EPl4=
X-Gm-Message-State: AOJu0Yz0YpJktuuBNM4b/pD31xnEtoOncgnYbbuJMwJnfQekc2SJ/8M9
	w+d6TlUMNgEiJfnnlW4jxeK3XM+y2M65dUochGOICOao1vhGUaW3yshmV7GGWNw=
X-Google-Smtp-Source: AGHT+IHnthYvJSLZi9A6Pf8OaQCOFLwe8XfHMSX3Suyha+VZUk+mAsZml7xZkNIcx932RlRPoxus5w==
X-Received: by 2002:a2e:9f57:0:b0:2ef:18ae:5cc2 with SMTP id 38308e7fff4ca-2f03db8e156mr37629931fa.21.1721999628861;
        Fri, 26 Jul 2024 06:13:48 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:414f:cfed:daba:4cb? ([2a01:e0a:982:cbb0:414f:cfed:daba:4cb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4280574a8a2sm80575835e9.23.2024.07.26.06.13.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 06:13:48 -0700 (PDT)
Message-ID: <d1bee4fe-03c6-427c-ac3d-7a33f1533ecd@linaro.org>
Date: Fri, 26 Jul 2024 15:13:47 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/3] mailmap: Add an entry for Konrad Dybcio
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-pm@vger.kernel.org, iommu@lists.linux.dev, linux-gpio@vger.kernel.org,
 linux-remoteproc@vger.kernel.org, Konrad Dybcio <konradybcio@kernel.org>
References: <20240726-topic-konrad_email-v1-0-f94665da2919@kernel.org>
 <20240726-topic-konrad_email-v1-1-f94665da2919@kernel.org>
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
In-Reply-To: <20240726-topic-konrad_email-v1-1-f94665da2919@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/07/2024 13:18, Konrad Dybcio wrote:
> Map my old addresses.
> 
> Signed-off-by: Konrad Dybcio <konradybcio@kernel.org>
> ---
>   .mailmap | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/.mailmap b/.mailmap
> index e51d76df75c2..d189c6424697 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -353,6 +353,8 @@ Kenneth Westfield <quic_kwestfie@quicinc.com> <kwestfie@codeaurora.org>
>   Kiran Gunda <quic_kgunda@quicinc.com> <kgunda@codeaurora.org>
>   Kirill Tkhai <tkhai@ya.ru> <ktkhai@virtuozzo.com>
>   Kishon Vijay Abraham I <kishon@kernel.org> <kishon@ti.com>
> +Konrad Dybcio <konradybcio@kernel.org> <konrad.dybcio@linaro.org>
> +Konrad Dybcio <konradybcio@kernel.org> <konrad.dybcio@somainline.org>
>   Konstantin Khlebnikov <koct9i@gmail.com> <khlebnikov@yandex-team.ru>
>   Konstantin Khlebnikov <koct9i@gmail.com> <k.khlebnikov@samsung.com>
>   Koushik <raghavendra.koushik@neterion.com>
> 

Acked-by: Neil Armstrong <neil.armstrong@linaro.org>

