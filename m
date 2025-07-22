Return-Path: <linux-pm+bounces-31263-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E24B0D6DF
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jul 2025 12:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 439211892C19
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jul 2025 10:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19A52E2651;
	Tue, 22 Jul 2025 10:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="caYdDcHz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7164F2DECB0
	for <linux-pm@vger.kernel.org>; Tue, 22 Jul 2025 10:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753178677; cv=none; b=AMhUBFhxOEdrFMkweibq9mQmVVfD/lhCdNW9lE67DK1dX9vEwQ8kH53kdCASsICnPZxb7C89EiEFsi63B6yze/4netcXm8CqQByC4bgFureZPKbxkFxrL6/OvU330MCBAmIpYIfpAy0iz2UP1POWqbrB/rewned2HZFibO+2LUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753178677; c=relaxed/simple;
	bh=cbUV/aoxPgUWCJZMY6VxKNUjXQckwm3iK0y+j5W/5Ho=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=P0pT/oaJZBriPq/G1TMN+/yPgEsSZ4uFWjUIfW3In0b747xj6FkjTC/fqvz1ALwzmWhkeW8fA+MYuT74cQ3Knl2oOylCKXlXCSz5nA5ro9Nm+awK2c2HHfMx+rBDenSVOoCoJs0KxvjbKZYhwiOSG7fDuDFd8TnAbMsoQ7kX5qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=caYdDcHz; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-451dbe494d6so57986155e9.1
        for <linux-pm@vger.kernel.org>; Tue, 22 Jul 2025 03:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753178674; x=1753783474; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=th8LkjBfkv7nYvFuNNGaT8FWdqcCdRHWy+pWo6pVRT4=;
        b=caYdDcHz735mhJEx22QLAABDbV4/r2dcFCKK1RCBzAPqTIgOP/PsyIzQJcU4HAT6qd
         tVZ9lP5k0h6QxWDS3jBp5xvqtTzFoNhliGVwR55BD4W6Ram5ZrUzRT71OUEC0o95LHv4
         UDhXi7n+JHYNtJJ2MNcF6RRi5qCqWSwAyo+sQ+AxcBb41AUiXNaTddejXxSiZWMaK1Kh
         SBgr9Rhn3rfMqWhVsTyVOqUN52ebvb/XSDe5FBV4JTcC8MvhiGCG5F/ow479il9w5xJ9
         SiEsKtxZ3elbY6gaPqgqZ8xygOubn2Atwcr/Ot1YBx1e4Y1eS882vTWFp1iZpTu+K8sY
         6pcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753178674; x=1753783474;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=th8LkjBfkv7nYvFuNNGaT8FWdqcCdRHWy+pWo6pVRT4=;
        b=TQ+UiMfP6pjwVqrCJThm5py6CM5avNh7TtHYz0UAoxptY+3MKbC0RDJ768lKnVgwmw
         udX2KoPKjAAjcXcTXY3R2L0pzR7tGEs0RlDB75+jt35Vtog0y2OprVTUK8LAyw25+sBj
         Va+uWW86RWwK0cHcrU1+Gy7pEkX8JCxzXdd9phDJ78GugGjAZ6EsKxcsg8kX7BDbhCu8
         wU1oBiLxChBJWiB5KLBeolZE/3ZNY1w7LwdCOfs3r2nH9HgmYlYlb1V2AOGalL3dJh6/
         CekjVpo6HjBLdwgQgasivCAdzb4idm78Ic0cNmYH/bj6mHGJGfDjf7ZfVFUViFk4t3HF
         +tPQ==
X-Gm-Message-State: AOJu0Yw2DiZdPOm20uZFNM3gMtyPtnluNAVCJiDHW4RPM5yaVLu4Gq2s
	54gvjZDVyLXhuLNGLxCNcUECmayN+UpaAchMfw8PHlUTLCHOTqMJQEFnX/wHU/htLcQ=
X-Gm-Gg: ASbGncvHvJxZ604g779zMSPaPXmVV03rE43Tp4ysRTQmRxsTBMeDmALDAHi6zhFijYV
	78AacJSPEe71u0MPaj6zjLgxQf2asPcuofveXuvfkq0ICV33vbT+uadydZHPDGbFb0GctNeGMpG
	/A9jjVS2AlmY5cA9gjDvV8rJdo0+8LHoTkYXJVgaReFfz5lDc9VuMp0+Olah7DEx400g93lyfi/
	4F0e5n3ulE8cYiUBY35HNokKrwnEOZcRweldxNomsDy1Jz2nPGlMphUgmrzC0wHJJHZc2by3RQ+
	KFTZ9qBGzmrTUOMwpe6R1VBwU3JGfpPgscpbcmxqM7PONi1+CtEvr2KcTnmM5VTtm4UAmAMvqdu
	huaVwAt17vb75989oJ7X+ffIBlPYqykPUvKBJ/HrN8Z3bgC2EUGx+PJAmdPLPkhJKX9p9it+Ip+
	s=
X-Google-Smtp-Source: AGHT+IFejVtWV8JytlClgGlAbQ/sASXBqbtoY0roVwh48A/QZMJB/xCFqE4nYCMj0t7+saAYfB6ttw==
X-Received: by 2002:a05:600c:4688:b0:456:a1b:e906 with SMTP id 5b1f17b1804b1-4562e3cbb03mr196476655e9.33.1753178673594;
        Tue, 22 Jul 2025 03:04:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:bce4:725d:6922:d1ba? ([2a01:e0a:3d9:2080:bce4:725d:6922:d1ba])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e7f33f0sm184133915e9.2.2025.07.22.03.04.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 03:04:33 -0700 (PDT)
Message-ID: <942aa300-fc49-47e8-93b7-85fd1e1fd123@linaro.org>
Date: Tue, 22 Jul 2025 12:04:32 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/3] thermal: amlogic: Support C3 thermal controller
 driver
To: xianwei.zhao@amlogic.com, Guillaume La Roque <glaroque@baylibre.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Liming Xue <liming.xue@amlogic.com>
References: <20250718-c3-thermal-v1-0-674f9a991690@amlogic.com>
 <20250718-c3-thermal-v1-2-674f9a991690@amlogic.com>
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
In-Reply-To: <20250718-c3-thermal-v1-2-674f9a991690@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/07/2025 08:37, Xianwei Zhao via B4 Relay wrote:
> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
> 
> Add the thermal controller driver for the C3 SoC family.
> 
> The main difference compared to other Amlogic chips lies in the
> offset of the sec_ao base (referred to as u_efuse_off), which is
> handled differently. Everything else remains consistent.
> 
> Signed-off-by: Liming Xue <liming.xue@amlogic.com>
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>   drivers/thermal/amlogic_thermal.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/thermal/amlogic_thermal.c b/drivers/thermal/amlogic_thermal.c
> index 5448d772db12..d1b08119c818 100644
> --- a/drivers/thermal/amlogic_thermal.c
> +++ b/drivers/thermal/amlogic_thermal.c
> @@ -226,6 +226,12 @@ static const struct amlogic_thermal_data amlogic_thermal_a1_cpu_param = {
>   	.regmap_config = &amlogic_thermal_regmap_config_g12a,
>   };
>   
> +static const struct amlogic_thermal_data amlogic_thermal_c3_cpu_param = {
> +	.u_efuse_off = 0x108,
> +	.calibration_parameters = &amlogic_thermal_g12a,
> +	.regmap_config = &amlogic_thermal_regmap_config_g12a,
> +};
> +
>   static const struct of_device_id of_amlogic_thermal_match[] = {
>   	{
>   		.compatible = "amlogic,g12a-ddr-thermal",
> @@ -239,6 +245,10 @@ static const struct of_device_id of_amlogic_thermal_match[] = {
>   		.compatible = "amlogic,a1-cpu-thermal",
>   		.data = &amlogic_thermal_a1_cpu_param,
>   	},
> +	{
> +		.compatible = "amlogic,c3-cpu-thermal",
> +		.data = &amlogic_thermal_c3_cpu_param,
> +	},
>   	{ /* sentinel */ }
>   };
>   MODULE_DEVICE_TABLE(of, of_amlogic_thermal_match);
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

