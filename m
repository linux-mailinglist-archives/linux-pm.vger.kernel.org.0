Return-Path: <linux-pm+bounces-11433-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C2193D3E7
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2024 15:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7DD71F243B4
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2024 13:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D549017C213;
	Fri, 26 Jul 2024 13:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MPI3hs3Q"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C4F17BB0B
	for <linux-pm@vger.kernel.org>; Fri, 26 Jul 2024 13:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721999639; cv=none; b=kvj5AgXET4KbIAncHkdc21USpDVUq5LSvf+xfjqvZ+fySWk+aXl1Rt+XO89Rdq2Ka1cyqVZFHVLRIDh/bwXE+lFZ9bwG/SJmIWbHjX+3p+QwXcbsmtLzwGU6aA7ssvcwjK6S1hPbW+7nFHfmiBPpXbFfpZ9ytUyODUX/lQx5hM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721999639; c=relaxed/simple;
	bh=tjpx7XT6hKUt3wpwXlT3BRKarZaJsCaSbE3FIg3d2mQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=BlsZeiZpPCYPJM8d+EoXSPfPV9rVQQvL26RYH5VOeL7j0rXMDU3dBSPwKPNOiSy4n0aiM+rt3+caeJanV/IH71YMEwgAs4SW6NuJ89z4YAzbtzSgpafZ6M1mJOIU6H/gZ/P2VTX50orU42h+BYpLYjVBDRHUEliTCajp1Y8r79Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MPI3hs3Q; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-367963ea053so1510071f8f.2
        for <linux-pm@vger.kernel.org>; Fri, 26 Jul 2024 06:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721999635; x=1722604435; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9azynhyEIv7gjWRDwglaDMiOV6j4zfrdOibDd2jjuA0=;
        b=MPI3hs3QjzV9+Vli7EY47Mm+C0DlBF1qp6/aE3kQi318wrxkgPXQQ2IFHHjnlg5Grd
         +w7HFQE9O5fBcZcyyqhZJpds3Efkp/Efv8vv3v7V+S77az7Sy/fH33yPxeV8gZN0EH8e
         3lxP6F0BbkTSkvyGROwA3are5mWqh2yE0TQyXYON0af4s9keuCpt1oAPNJveFrjC2yKG
         i1FlrqV93oCoCE8smd7tobex2aVdFCxb+07IlcmrzjvS+fPFACDrRLujCq9Mjrba1XeZ
         OAWz4lq1gygA1Jlr1ae8whKtX0diazVDRc0WqbS9wvKGmVBPKlzUJyMZuNOwrp/+/2ju
         jZYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721999635; x=1722604435;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9azynhyEIv7gjWRDwglaDMiOV6j4zfrdOibDd2jjuA0=;
        b=ANxQ2SlP9PQAuwwmPdjxWB487Dnyhx6epuIpilJowx25H1sUqpt97Ol4Z6MGz25Q0N
         5Q4mfFOv2kwFq0Kio09HEBqb52G+D42iR53mdADK0S8CkhxCe3JsjaB3hdtT1aZPFCSy
         tIw9cOjs+dfuWKI0RAD83PtaLf1UOI12t1e0o1fLItlsIZHTCVOgDUhiwi+ugzQqsqdD
         AY2pE2HgagY1O8yL4CnPjX4DOJgkwmylBT27fJVeivQcUFx+pp7oT1I1r5bRKC/UWGzN
         C5piDRkksljaDiek9yaG2mI6xzwewWXZJ6GlUU3iei1mJly/R+8ifLD2uc9uoEp92zhJ
         igYQ==
X-Forwarded-Encrypted: i=1; AJvYcCW35kVpLTwQ3hAXXQISMcMFgMLDXXn0Ib4nxODFaVZdxAH0EIOTG0huBe0h57xeZMPNuvoYLJs/PkOIZP5w0oC6pDO2Hrbt6HA=
X-Gm-Message-State: AOJu0YwaKD1EPWQLqs8FyBODwivRq1XDyBtazs0SWytqO3IE8FRW7p6U
	dUECgoACrTNSISuMirxs6mRXhCpSyyBujECKTijTNICoIRnk0zGsVEClEACQ4wA=
X-Google-Smtp-Source: AGHT+IFYFvUqydDA1IhhpeDf3coci+AwNSrGJucxAODHhP4+wvMCDNWfwzzxwPzjvhRpI/Srd3Dybg==
X-Received: by 2002:a5d:588a:0:b0:367:9903:a91 with SMTP id ffacd0b85a97d-36b363ad791mr5579706f8f.11.1721999635029;
        Fri, 26 Jul 2024 06:13:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:414f:cfed:daba:4cb? ([2a01:e0a:982:cbb0:414f:cfed:daba:4cb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4280574a8a2sm80575835e9.23.2024.07.26.06.13.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 06:13:54 -0700 (PDT)
Message-ID: <9bdd46a7-c018-4dc9-89e4-20377b5e6570@linaro.org>
Date: Fri, 26 Jul 2024 15:13:53 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/3] MAINTAINERS: Update Konrad Dybcio's email address
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
 <20240726-topic-konrad_email-v1-2-f94665da2919@kernel.org>
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
In-Reply-To: <20240726-topic-konrad_email-v1-2-f94665da2919@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/07/2024 13:18, Konrad Dybcio wrote:
> Use my @kernel.org address everywhere.
> 
> Signed-off-by: Konrad Dybcio <konradybcio@kernel.org>
> ---
>   MAINTAINERS | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9200d953868e..6c7d3951192f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2745,7 +2745,7 @@ F:	include/linux/soc/qcom/
>   
>   ARM/QUALCOMM SUPPORT
>   M:	Bjorn Andersson <andersson@kernel.org>
> -M:	Konrad Dybcio <konrad.dybcio@linaro.org>
> +M:	Konrad Dybcio <konradybcio@kernel.org>
>   L:	linux-arm-msm@vger.kernel.org
>   S:	Maintained
>   T:	git git://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git
> @@ -7107,7 +7107,7 @@ F:	drivers/gpu/drm/tiny/panel-mipi-dbi.c
>   DRM DRIVER for Qualcomm Adreno GPUs
>   M:	Rob Clark <robdclark@gmail.com>
>   R:	Sean Paul <sean@poorly.run>
> -R:	Konrad Dybcio <konrad.dybcio@linaro.org>
> +R:	Konrad Dybcio <konradybcio@kernel.org>
>   L:	linux-arm-msm@vger.kernel.org
>   L:	dri-devel@lists.freedesktop.org
>   L:	freedreno@lists.freedesktop.org
> @@ -18765,7 +18765,7 @@ F:	include/uapi/drm/qaic_accel.h
>   
>   QUALCOMM CORE POWER REDUCTION (CPR) AVS DRIVER
>   M:	Bjorn Andersson <andersson@kernel.org>
> -M:	Konrad Dybcio <konrad.dybcio@linaro.org>
> +M:	Konrad Dybcio <konradybcio@kernel.org>
>   L:	linux-pm@vger.kernel.org
>   L:	linux-arm-msm@vger.kernel.org
>   S:	Maintained
> 

Acked-by: Neil Armstrong <neil.armstrong@linaro.org>

