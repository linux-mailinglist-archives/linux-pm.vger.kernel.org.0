Return-Path: <linux-pm+bounces-12412-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B649566A1
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 11:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55E481C21951
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 09:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A2515ECC6;
	Mon, 19 Aug 2024 09:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jC9Wn8vf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917A915E5C9
	for <linux-pm@vger.kernel.org>; Mon, 19 Aug 2024 09:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724058993; cv=none; b=MAaZe6sinuMrgD99ogyI2daDf7uAX8LxXR8PJTeFFh7Ijp7pEP+ARGdCEvXEhlGzK/zXQQwM71hZh1OEsgDJkg/8KWt4FvMvhg9vMmb4EUbR+f9nrPs+HfL4AY6ra6b0kW0+VBavaRgSHXHgTRz5KikEXo404xEWwjqouAQRTJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724058993; c=relaxed/simple;
	bh=M4HxD41AxnpTCiLQTaEKtdJBVGPgtoEks/DEOhlXdr8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Zd+sAZ95b5zHGvx9L0L7xfE96ArCPx3Gx2eJ6zgWhOd7Iiex/E00KbFKqrH4b6NRiwJjSL1S4BSdZUsITuZu1ISXr3xaMLjijf6WwcRRmqbJfJaCCbBx3UM3cUC1WVc1TLIOXY3t6KIyA/XEx9x0OySSFL5/NxxX5Dr9SrLlvyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jC9Wn8vf; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37198a6da58so2067484f8f.0
        for <linux-pm@vger.kernel.org>; Mon, 19 Aug 2024 02:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724058989; x=1724663789; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lhdgRPhROCnX5bLFVFYvhFCrgNIlRk5KqPEmPhOey3g=;
        b=jC9Wn8vfgzlHlFTqIUo8CQFm0rsu0NK2cdKUlRtgkZzh/dKc+JDgjczkmkSMOmT0fu
         vZuue28vw+giHI4xr6zFRr9+kOw1XMCR35fDE/u2FPdbfK8iu72PYcY4f33qICOVDR2s
         jkSasE/6kpW9ue9DkDymAH3SgSfIBMCHPzo9WBDz5TyKqF4nAORfjhHR3PaClqbRF2AC
         rAKsCBsm+QTWMFdFdNr5QEbk1zfntiWvtUEh41q9/px1y03tvVdS2fiZc7gvZiugQ/yD
         nRhH25FVm/wBHpFvd/9Ut0KrV9Mk1oiColmI/eZN91C3XHlGL4b+mX9C8Qcnf6/7Yb5V
         itSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724058989; x=1724663789;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lhdgRPhROCnX5bLFVFYvhFCrgNIlRk5KqPEmPhOey3g=;
        b=P8BhHObiSnTwuvIL9A5EG8twi2TzJskvwWVoHGeny+u/BnWwo2bxXdnxfsvZ4dSI8o
         YrHVqljzQrSwUrk8eE55P9z8OxpF8jqmM4W9lZRN0dxzKuL7j7945YFY+XxBa2O6GOUW
         g4Iub0rISaLR30yhha6mkyWr9TCZUwv7yAQv16BQgzRSLt6D7Y3mpBPgpwOC9ItYZY7u
         AC+vRsSROqhJ3jNmI2gHGt9hXrFN1Fi5tkYtCfIe4weBOI8j01HGTyk7/myxBqmr/GIX
         YYQ7Yx3Wzqt6X5E5KpAT1saqG6QHq0YbrHUqwrV75X1YPU5f+iIb+f0OTtwrBi8tkzPq
         dKDA==
X-Forwarded-Encrypted: i=1; AJvYcCXgdq3ZvvSkQ6akmjDizIicaC9wsJc54Thn4N+mYvLH7lJkQBCGqUVZo1+gC9engv8MJC0D7l6wuX3qHFPO1BnVswdRUle4Z5w=
X-Gm-Message-State: AOJu0YzPEBLWVkyUu90yJOlYXv9KK8ftx+mHk3y74XHOfZ3/7c0ytQY5
	6wwIdR9TxO2fhOivqVpAlNhb8fJBDf5THeuo2jTEq9sBw1RNTAV94Y3afrjjgq0=
X-Google-Smtp-Source: AGHT+IGlLNnWnVua3EpqWORlOr9KVT/7tXvAlVwexe5VlvrIqMwXSW6fc2+//ghkrLZ4/+R2Z9303w==
X-Received: by 2002:a5d:4e42:0:b0:371:8eea:24b7 with SMTP id ffacd0b85a97d-371946a04e6mr7617699f8f.50.1724058988631;
        Mon, 19 Aug 2024 02:16:28 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:f54e:4b0a:5175:5727? ([2a01:e0a:982:cbb0:f54e:4b0a:5175:5727])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3718983a397sm9970491f8f.24.2024.08.19.02.16.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 02:16:28 -0700 (PDT)
Message-ID: <d84c8f87-5f7c-4f6d-bcc6-d20b05b1755a@linaro.org>
Date: Mon, 19 Aug 2024 11:16:27 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 3/3] soc: qcom: pmic_glink: Actually communicate with
 remote goes down
To: Bjorn Andersson <quic_bjorande@quicinc.com>,
 Sebastian Reichel <sre@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Johan Hovold <johan+linaro@kernel.org>, Chris Lew
 <quic_clew@quicinc.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Stephen Boyd <swboyd@chromium.org>, Amit Pundir <amit.pundir@linaro.org>,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 stable@vger.kernel.org
References: <20240818-pmic-glink-v6-11-races-v1-0-f87c577e0bc9@quicinc.com>
 <20240818-pmic-glink-v6-11-races-v1-3-f87c577e0bc9@quicinc.com>
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
In-Reply-To: <20240818-pmic-glink-v6-11-races-v1-3-f87c577e0bc9@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/08/2024 01:17, Bjorn Andersson wrote:
> When the pmic_glink state is UP and we either receive a protection-
> domain (PD) notifcation indicating that the PD is going down, or that
> the whole remoteproc is going down, it's expected that the pmic_glink
> client instances are notified that their function has gone DOWN.
> 
> This is not what the code does, which results in the client state either
> not updating, or being wrong in many cases. So let's fix the conditions.
> 
> Fixes: 58ef4ece1e41 ("soc: qcom: pmic_glink: Introduce base PMIC GLINK driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>   drivers/soc/qcom/pmic_glink.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/qcom/pmic_glink.c b/drivers/soc/qcom/pmic_glink.c
> index e4747f1d3da5..cb202a37e8ab 100644
> --- a/drivers/soc/qcom/pmic_glink.c
> +++ b/drivers/soc/qcom/pmic_glink.c
> @@ -191,7 +191,7 @@ static void pmic_glink_state_notify_clients(struct pmic_glink *pg)
>   		if (pg->pdr_state == SERVREG_SERVICE_STATE_UP && pg->ept)
>   			new_state = SERVREG_SERVICE_STATE_UP;
>   	} else {
> -		if (pg->pdr_state == SERVREG_SERVICE_STATE_UP && pg->ept)
> +		if (pg->pdr_state == SERVREG_SERVICE_STATE_DOWN || !pg->ept)
>   			new_state = SERVREG_SERVICE_STATE_DOWN;
>   	}
>   
> 

Good catch!

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

