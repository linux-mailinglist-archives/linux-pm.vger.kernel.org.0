Return-Path: <linux-pm+bounces-15921-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 256D69A36F2
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 09:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 791D2B22017
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 07:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8763C1885BE;
	Fri, 18 Oct 2024 07:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mT6pWflX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403B7185B6E
	for <linux-pm@vger.kernel.org>; Fri, 18 Oct 2024 07:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729236001; cv=none; b=RWX/k3GB2xX4PNppGPsBlxG0CwjFoRFxwM3qzNlftBn93/Z4XGimr2HOe0e3pW9LQ/I/IYiy+7J5TePYpZJOpkrhUrIqsh4PXHU8PjyRnCBLRiF3HLHThgBRmQQOxDgqsYiOS1pEUPZB9yt/ULEdk+vubvqnxvC3SrJMoc85LNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729236001; c=relaxed/simple;
	bh=uUctaSUeuSR/tl3n40AoJXSAlasaIsytGhGjL1hzRfw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=T5c2f/7tjAutGE/JHaviEc2emuerTBphzXLeeaoYzbcFlN6V+C89PgF15Zbezv01V6seX4ssl5Y0sD2Hg8LRZQ7d3kFt1PH5D6+azdkPOWd0ZETV6CVAjlRPzqELugf2MfwjShsbJWMO462D3d9DBXCuWcKIdKRj3TJk7p39UUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mT6pWflX; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4314b316495so16916085e9.2
        for <linux-pm@vger.kernel.org>; Fri, 18 Oct 2024 00:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729235996; x=1729840796; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EFsQArlzln8F0OTpUr5gAS0Us5DdTYm+LCK0FQeTFXo=;
        b=mT6pWflXTcn/nOUtwWlFbmBlaoRkN1DOXTE5iI2gjHhh16XF+Kl9D+QKFtWHiZF8Ds
         rTWUCd3ucMoPIxCLwFGKGIoxvjz9HTDlmitfuaAqdXm+zG+LsSsYMPncWpV2U34kKHDU
         SYuq3IESat9zoIdFFblW2wWdV8N0sJddq/1KEv5cKI9MtU+Sp8aDizBsEKtVaveWeps5
         yGO8GLeWFcI8a6xmnvK3DMr1F9dbCDibPjDNnQPtAXt9MPHFvx1rxBSlVZbKejVpAmBf
         5FKexdNJYU1ZZ5mkOehPsqh2OAEwEgXXBon2IC7YO85NghhBCj3PxYNsCNHN4agCnQR/
         7gLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729235996; x=1729840796;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EFsQArlzln8F0OTpUr5gAS0Us5DdTYm+LCK0FQeTFXo=;
        b=iFtxMmarHyRcpRyeF59KdAyU8MxiU2veAaHBfHVJ3ufdDrn59YiFA2yqzZki6t9SH4
         Jyv2TXFdcwMAV1gxE5fdWfTt6s0a4mkFD+I7LX2YdfBYil1YoaLcp1fi/OTgAgEUSoC0
         fo79X4rrrwG8M8mL3sBUp5x9ak/wSiK91kNbwfVNHnJpA3KJlqsNb4uWF4nH8yKNyq+m
         xR807iV9S64eO27DPJSoSpSNdcr3tYTfQ0X5u2OU+udrnU2STPINT3fa2sEtODayqyoN
         5puMmna5T5XGKbvXw3Soe2/6TLDbfTs+fbVKopH1dNauA5qMjVB1K7LcoCsEbYETWEyx
         QR9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXcTJJL2Bn9x6HOmQosFpLB1+fTW9BdhL6nqk378EkGcRT0zarfPsslu0ytrLaQWtNB/qNTfp4dOQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxDSWdRQCHMX8YJYP7e5Xn4/45QUK+lRae+UKEjII5jipSQ60Pb
	Yu0ZfwmYEzSN5LTepc8j9wE8cCg9LfKRhXi8aWX0lJq3pk9r9FBU9FHTLtFYmww=
X-Google-Smtp-Source: AGHT+IFRTNZaGcIqBNrqF0UQnvOY3WFj9aGTgwW75vhsIyJt3teEYr05LtJkleMEPi/b+g6VrdiNAw==
X-Received: by 2002:a5d:4b05:0:b0:37c:d11f:c591 with SMTP id ffacd0b85a97d-37ea2177e67mr1025235f8f.17.1729235996538;
        Fri, 18 Oct 2024 00:19:56 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:b623:41fc:e293:c9b1? ([2a01:e0a:982:cbb0:b623:41fc:e293:c9b1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ecf0ed24esm1133059f8f.82.2024.10.18.00.19.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2024 00:19:56 -0700 (PDT)
Message-ID: <e3386cf9-170e-477b-88d8-dab3bb437da3@linaro.org>
Date: Fri, 18 Oct 2024 09:19:55 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/2] pmdomain: qcom: rpmhpd: add support for SAR2130P
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20241017-sar2130p-rpmhpd-v1-0-f4bf7f6fd12e@linaro.org>
 <20241017-sar2130p-rpmhpd-v1-2-f4bf7f6fd12e@linaro.org>
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
In-Reply-To: <20241017-sar2130p-rpmhpd-v1-2-f4bf7f6fd12e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/10/2024 19:52, Dmitry Baryshkov wrote:
> Define power domains as supported by the RPMh on the SAR2130P platform.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>   drivers/pmdomain/qcom/rpmhpd.c | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/pmdomain/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhpd.c
> index 731feab9f17ddae699815332d193e9a298fff0e1..5c5f9542c3925045cc90872e81cae3e6c2936212 100644
> --- a/drivers/pmdomain/qcom/rpmhpd.c
> +++ b/drivers/pmdomain/qcom/rpmhpd.c
> @@ -259,6 +259,30 @@ static const struct rpmhpd_desc sa8775p_desc = {
>   	.num_pds = ARRAY_SIZE(sa8775p_rpmhpds),
>   };
>   
> +/* SAR2130P RPMH powerdomains */
> +static struct rpmhpd *sar2130p_rpmhpds[] = {
> +	[RPMHPD_CX] = &cx,
> +	[RPMHPD_CX_AO] = &cx_ao,
> +	[RPMHPD_EBI] = &ebi,
> +	[RPMHPD_GFX] = &gfx,
> +	[RPMHPD_LCX] = &lcx,
> +	[RPMHPD_LMX] = &lmx,
> +	[RPMHPD_MMCX] = &mmcx_w_cx_parent,
> +	[RPMHPD_MMCX_AO] = &mmcx_ao_w_cx_parent,
> +	[RPMHPD_MSS] = &mss,
> +	[RPMHPD_MX] = &mx,
> +	[RPMHPD_MX_AO] = &mx_ao,
> +	[RPMHPD_MXC] = &mxc,
> +	[RPMHPD_MXC_AO] = &mxc_ao,
> +	[RPMHPD_NSP] = &nsp,
> +	[RPMHPD_QPHY] = &qphy,
> +};
> +
> +static const struct rpmhpd_desc sar2130p_desc = {
> +	.rpmhpds = sar2130p_rpmhpds,
> +	.num_pds = ARRAY_SIZE(sar2130p_rpmhpds),
> +};
> +
>   /* SDM670 RPMH powerdomains */
>   static struct rpmhpd *sdm670_rpmhpds[] = {
>   	[SDM670_CX] = &cx_w_mx_parent,
> @@ -665,6 +689,7 @@ static const struct of_device_id rpmhpd_match_table[] = {
>   	{ .compatible = "qcom,sa8155p-rpmhpd", .data = &sa8155p_desc },
>   	{ .compatible = "qcom,sa8540p-rpmhpd", .data = &sa8540p_desc },
>   	{ .compatible = "qcom,sa8775p-rpmhpd", .data = &sa8775p_desc },
> +	{ .compatible = "qcom,sar2130p-rpmhpd", .data = &sar2130p_desc},
>   	{ .compatible = "qcom,sc7180-rpmhpd", .data = &sc7180_desc },
>   	{ .compatible = "qcom,sc7280-rpmhpd", .data = &sc7280_desc },
>   	{ .compatible = "qcom,sc8180x-rpmhpd", .data = &sc8180x_desc },
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

