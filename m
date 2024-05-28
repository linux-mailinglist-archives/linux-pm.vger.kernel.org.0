Return-Path: <linux-pm+bounces-8230-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE02E8D1681
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 10:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05C4EB216A7
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 08:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239EA13C830;
	Tue, 28 May 2024 08:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GCs2QOAY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE5B22067
	for <linux-pm@vger.kernel.org>; Tue, 28 May 2024 08:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716885721; cv=none; b=Tm8NXkWFtas572aWvDw3idKFCGQxOdIJ6WzMMDrEg0LLpFLBsgQuUoj0scH8jdOzjEgnbg1ygeOAIZjmt7Msn/VSoEZZ+AkzhAVAgLZ1yem8Jj12zabn2ju1eILOfOQ2cW9feInnXa3y8nXEwtz81H0fQMnkra5E0h/tFabAYe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716885721; c=relaxed/simple;
	bh=iXf/xBSZbXbRyTAieBsxS0pwSufFB+gzmegcfsajFxY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=hX0LlNDk38FYB+M+CMW3K3d+Z9R0bhTStVJlF52wh/TiA2TUX4Cfrn7uP0D0AhXsW96zYjjhQ4p6obkmr0bLp5gputoH7JKMpKq40/JHD+9rzdLCroXaMz5ES4AabFYicvFBe0Dcgw3zlLeMH4Vui/TPHBmX9MFFSWrRAVXhoks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GCs2QOAY; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5295f201979so653809e87.2
        for <linux-pm@vger.kernel.org>; Tue, 28 May 2024 01:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716885717; x=1717490517; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kQM6HYhZbxPatU25g9nxoYtgAi0elYZKvX9/9nM9Kkg=;
        b=GCs2QOAYwI/cNnGULvv2DzlwG3xdNzoktih0xQXBcgeBi59ZSwQEf0Rzx1QKOFnsI2
         v6DPhkN+vrPBIJvCIk7GafZyAhrEN0NSfIZSlKP9C4wreG3u5PIQIhq5EnM6uPCI3oTB
         m3itAyus5HS9GOCXmueqxjZDYWr4MCjKz2B57L8h/Z4mLsvA88OL5pPj9OcgWqfN2cml
         M/ALOd1T0zFU/GbEhkVIzyk36sJYR4NxLezOpA0npHmaK0wUG0RbASl6yXlhuVQkstfO
         p7bJWKgeKtpyNS97OOcrHhRIphOlgyK6aUHOhF+L7xyjEvVpRcxFo7jvhza065Np0IQD
         Usvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716885717; x=1717490517;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kQM6HYhZbxPatU25g9nxoYtgAi0elYZKvX9/9nM9Kkg=;
        b=ujwJxrqVXGz6c7OWItwEbgGhGcrZn0IQvL0HXAz2vsgeAvc+Qx+M3Jmi1IBR70gzOK
         c2QLXG/QZjXNcLRiIvTQbeDiaMV7RihuVosFr8Qmt20G1ZE7tJFMdhP1tpcis+UhrDLV
         XcsqUjrq2Pc2prE7Jl8bmAS8P2WX4g/BITZ7adRGpl9xVLlZwo1sc5rlqmSwaKxnU74t
         yVhwzOFM+1EYSdaoTb77+qroILIM/tPRN0g6g5fwWjqh6szI5wR6VjNH1SYqq6/TG3rX
         bg//gnxfzbByZkXZsMgRbrAy1NawhJBuHc7K+pb/XUiBrbaHxWcK2bwG45L2Wvr2LVjz
         aOXA==
X-Forwarded-Encrypted: i=1; AJvYcCWx1GpCpiMJWNYTddG3xp7o6G+tPTXIQQ2M9cfrD9mVrRjZLdWMrejdJSd3fmfSeb/Yw2zANhA14MFKfCtK0Ro4nt2nxRJGTvo=
X-Gm-Message-State: AOJu0YzxrQZ32zaPwX5EXEew1qjLi1TlOk+7n9iBt8MEHtBPlQd54/NU
	K5qU4cpXNtZSbQGcolNsBttcqURmvQ+I4iM56GfRvX4OqVcqeyTJfnAV4Bk2GZA=
X-Google-Smtp-Source: AGHT+IHSmbsd+w6NOeeMhcyPQNGVPQBayOgoB5Rg4ZeNC9bV0ohtGlQncUQuOB9hXyz9tT97E7C4MA==
X-Received: by 2002:a05:6512:3e13:b0:524:43b2:d326 with SMTP id 2adb3069b0e04-52964ca75d5mr8748177e87.37.1716885717433;
        Tue, 28 May 2024 01:41:57 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:8f19:f965:3f93:6385? ([2a01:e0a:982:cbb0:8f19:f965:3f93:6385])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4210896676bsm135394835e9.4.2024.05.28.01.41.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 01:41:57 -0700 (PDT)
Message-ID: <2f074d47-3021-4d81-93cd-c8e4593f0b0f@linaro.org>
Date: Tue, 28 May 2024 10:41:56 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/3] pmdomain: amlogic: Add support for A4 power domains
 controller
To: xianwei.zhao@amlogic.com, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Jianxin Pan <jianxin.pan@amlogic.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20240528-a4_secpowerdomain-v1-0-2a9d7df9b128@amlogic.com>
 <20240528-a4_secpowerdomain-v1-2-2a9d7df9b128@amlogic.com>
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
In-Reply-To: <20240528-a4_secpowerdomain-v1-2-2a9d7df9b128@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/05/2024 10:39, Xianwei Zhao via B4 Relay wrote:
> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
> 
> Add support for A4 power controller. A4 power control
> registers are in secure domain, and should be accessed by SMC.
> 
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>   drivers/pmdomain/amlogic/meson-secure-pwrc.c | 28 ++++++++++++++++++++++++++++
>   1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/pmdomain/amlogic/meson-secure-pwrc.c b/drivers/pmdomain/amlogic/meson-secure-pwrc.c
> index 4d5bda0d60fc..3a84d8a74a5e 100644
> --- a/drivers/pmdomain/amlogic/meson-secure-pwrc.c
> +++ b/drivers/pmdomain/amlogic/meson-secure-pwrc.c
> @@ -14,6 +14,7 @@
>   #include <dt-bindings/power/amlogic,c3-pwrc.h>
>   #include <dt-bindings/power/meson-s4-power.h>
>   #include <dt-bindings/power/amlogic,t7-pwrc.h>
> +#include <dt-bindings/power/amlogic,a4-pwrc.h>
>   #include <linux/arm-smccc.h>
>   #include <linux/firmware/meson/meson_sm.h>
>   #include <linux/module.h>
> @@ -136,6 +137,24 @@ static struct meson_secure_pwrc_domain_desc a1_pwrc_domains[] = {
>   	SEC_PD(RSA,	0),
>   };
>   
> +static struct meson_secure_pwrc_domain_desc a4_pwrc_domains[] = {
> +	SEC_PD(A4_AUDIO,	0),
> +	SEC_PD(A4_SDIOA,	0),
> +	SEC_PD(A4_EMMC,	0),
> +	SEC_PD(A4_USB_COMB,	0),
> +	SEC_PD(A4_ETH,		0),
> +	SEC_PD(A4_VOUT,		0),
> +	SEC_PD(A4_AUDIO_PDM,	0),
> +	/* DMC is for DDR PHY ana/dig and DMC, and should be always on */
> +	SEC_PD(A4_DMC,	GENPD_FLAG_ALWAYS_ON),
> +	/* WRAP is secure_top, a lot of modules are included, and should be always on */
> +	SEC_PD(A4_SYS_WRAP,	GENPD_FLAG_ALWAYS_ON),
> +	SEC_PD(A4_AO_I2C_S,	0),
> +	SEC_PD(A4_AO_UART,	0),
> +	/* IR is wake up trigger source, and should be always on */
> +	SEC_PD(A4_AO_IR,	GENPD_FLAG_ALWAYS_ON),
> +};
> +
>   static struct meson_secure_pwrc_domain_desc c3_pwrc_domains[] = {
>   	SEC_PD(C3_NNA,		0),
>   	SEC_PD(C3_AUDIO,	0),
> @@ -311,6 +330,11 @@ static struct meson_secure_pwrc_domain_data meson_secure_a1_pwrc_data = {
>   	.count = ARRAY_SIZE(a1_pwrc_domains),
>   };
>   
> +static struct meson_secure_pwrc_domain_data amlogic_secure_a4_pwrc_data = {
> +	.domains = a4_pwrc_domains,
> +	.count = ARRAY_SIZE(a4_pwrc_domains),
> +};
> +
>   static struct meson_secure_pwrc_domain_data amlogic_secure_c3_pwrc_data = {
>   	.domains = c3_pwrc_domains,
>   	.count = ARRAY_SIZE(c3_pwrc_domains),
> @@ -331,6 +355,10 @@ static const struct of_device_id meson_secure_pwrc_match_table[] = {
>   		.compatible = "amlogic,meson-a1-pwrc",
>   		.data = &meson_secure_a1_pwrc_data,
>   	},
> +	{
> +		.compatible = "amlogic,a4-pwrc",
> +		.data = &amlogic_secure_a4_pwrc_data,
> +	},
>   	{
>   		.compatible = "amlogic,c3-pwrc",
>   		.data = &amlogic_secure_c3_pwrc_data,
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

