Return-Path: <linux-pm+bounces-23351-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA98EA4D9F4
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 11:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C22D189AD85
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 10:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0851FDA9D;
	Tue,  4 Mar 2025 10:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="suOU9Eep"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F093B1FC7E1
	for <linux-pm@vger.kernel.org>; Tue,  4 Mar 2025 10:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741083352; cv=none; b=SblHcFyzHPBVyCAZHYs3FT+YHbMpIOv5KA2U41OkwfkUFoRRqZngmkvbWnZxIh1jfwf+mm345U6RMPS07eGJWVC16E9HXhbToolTwqX7jm/DMLBqRt3Ki+jP1Bu6lwinromiI705vDm7E0lg90C0jdMj70zptLZqsBwDUnFs/jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741083352; c=relaxed/simple;
	bh=586x6KaLpuRws9oiXO3+ufXeNdlCPivVZ8T7Ww4YYog=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=DC5wZ5W64jAR9CsaLkr8UTdZPGg40kLdTBYJgo1e3HIrtrUwsa14x6Fhak2GB345ZVD9a4+SLoj0zHTYCSGObDIrDdz2fJBg8PkMtPbKl+GzSdk2hsK8w3cS6Pdpcn1GVi8YDUg6rFNKA1yn1iBKDvMbptvDFOhCdFATbC/Z9o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=suOU9Eep; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43bcbdf79cdso3394705e9.2
        for <linux-pm@vger.kernel.org>; Tue, 04 Mar 2025 02:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741083348; x=1741688148; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kIp1cph66/HGjo1LcKFC/SHdEMb7MTb3g/6N0/oA0e8=;
        b=suOU9EepyK8t7trCsQTS2KSUHIf44nBYyVaoRxw03VkjxaCCeuGEqXeUNypjS6VmK/
         gU1zjtJNuG3IWxp9CQbsmWjRXUkRfE6klqTHJSbiU3oJw3exAWU5ZQOWVOJIhwVR+gL2
         ScfofBvncgV4z6ySEqFCv2gDACgyo963VA75zmCBKW27BpHTVGeauih7xUVVGuHyt8hz
         zJ7wjjFAKVMeHVL484sNQ7Cy8ff7qCAqvdIvL1afXVb703TdFHxV3ifGOWW2T7ezJuuK
         4cJ4OfpMEsllMObHgOKJM3VF9p264XV98nRstwhmpxZEUrrF146BSZPrXSSSg6Mr6uRL
         //sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741083348; x=1741688148;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kIp1cph66/HGjo1LcKFC/SHdEMb7MTb3g/6N0/oA0e8=;
        b=KTfb5QMrXXwMqHQFs6gBG/0A+dVRYBdoFTSugNAx0u259NaTHDd0J1/lRm+HsRphlR
         a2CGWjBkl5i5+wOlr7mCq1K3GK+szITaBpeQinlAmNSMZuyIk9+x/SP05/eLOGYPfgHB
         x+cv5wXmvcLJNazkI7Kqx01J/fAxQqNrluyRjwARI8Yc5f7LEovWxWuMicZ8mLO5Mq/f
         m8uhMd+Yls5qft32chi+jOoMpoJjVV4eM8MW3x8YfAIg2zkNSoPuo99hJ1jttKVmX6rd
         tMPzhXLc6qi3/V5S6SZ0FcDHG/3JpoaFb8vlXxstHao5wnn85Wihx3vd+6b/eL+3st+0
         zP/w==
X-Gm-Message-State: AOJu0Yx5u9zabiPuhvnbstpV1UeoWja/bwX9rBdpc+W8p6Gy44NL1FV6
	XQ1ufK9S26I0uDJTCaPczwP0Qv9ncVybcvAKvgAd1fe1xCjIjeRzWxRAYMriVlc=
X-Gm-Gg: ASbGncuUoYxmICfJCemjYN4lnC8XEOZTTZ5SOji8ab0aSeCB3jXD/fLeUpY2bFUC5i8
	+34BSLc9VkCK2tqGcg+fqe25JjHLU7VrgLR4rHlq6NEJaGvAfRF+D0/iaaydrX5z6+tsPkhOCYy
	Ra/1DX78M6sjLO3OiLhmEBZHwqunixxESz8iEfwO7wnWkTjwvlrd1uycx9nlUe1A0Rzt2OCpD/5
	D6PIe3Qz+vdeNsDEgjoBITW838cOY4uXlyu8kbmx4f6hcRZLxpi+qrMHazXIoIE7INJEW213LhO
	7XVoMnopTbtba3+W9w1zvL/XHPP87d5ZwfoBbdbWRgyGB/Sild2dxOY5
X-Google-Smtp-Source: AGHT+IGey+kjBPOhuoeEklMVdzB91lv2feUrKYSiI7u29mC2m39dGVaqOGpmY1/H5pbh0BrYF7k6rg==
X-Received: by 2002:a05:6000:4029:b0:390:efe7:20fa with SMTP id ffacd0b85a97d-390efe72244mr11536252f8f.47.1741083348262;
        Tue, 04 Mar 2025 02:15:48 -0800 (PST)
Received: from [192.168.1.101] ([37.167.169.83])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bc18452c3sm69076095e9.25.2025.03.04.02.15.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 02:15:47 -0800 (PST)
Message-ID: <2b5c44c8-4eca-45d2-9599-a4d00bf44f5e@linaro.org>
Date: Tue, 4 Mar 2025 11:15:46 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] pmdomain: amlogic: fix T7 ISP secpower
To: xianwei.zhao@amlogic.com, Ulf Hansson <ulf.hansson@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250303-fix-t7-pwrc-v1-1-b563612bcd86@amlogic.com>
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
In-Reply-To: <20250303-fix-t7-pwrc-v1-1-b563612bcd86@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/03/2025 10:06, Xianwei Zhao via B4 Relay wrote:
> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
> 
> ISP and MIPI_ISP, these two have a parent-child relationship,
> ISP depends on MIPI_ISP.
> 
> Fixes: ca75e4b214c6 ("pmdomain: amlogic: Add support for T7 power domains controller")
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>   drivers/pmdomain/amlogic/meson-secure-pwrc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pmdomain/amlogic/meson-secure-pwrc.c b/drivers/pmdomain/amlogic/meson-secure-pwrc.c
> index 42ce41a2fe3a..ff76ea36835e 100644
> --- a/drivers/pmdomain/amlogic/meson-secure-pwrc.c
> +++ b/drivers/pmdomain/amlogic/meson-secure-pwrc.c
> @@ -221,7 +221,7 @@ static const struct meson_secure_pwrc_domain_desc t7_pwrc_domains[] = {
>   	SEC_PD(T7_VI_CLK2,	0),
>   	/* ETH is for ethernet online wakeup, and should be always on */
>   	SEC_PD(T7_ETH,		GENPD_FLAG_ALWAYS_ON),
> -	SEC_PD(T7_ISP,		0),
> +	TOP_PD(T7_ISP,		0, PWRC_T7_MIPI_ISP_ID),
>   	SEC_PD(T7_MIPI_ISP,	0),
>   	TOP_PD(T7_GDC,		0, PWRC_T7_NIC3_ID),
>   	TOP_PD(T7_DEWARP,	0, PWRC_T7_NIC3_ID),
> 
> ---
> base-commit: 73e4ffb27bb8a093d557bb2dac1a271474cca99c
> change-id: 20250303-fix-t7-pwrc-f33650b190ef
> 
> Best regards,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

