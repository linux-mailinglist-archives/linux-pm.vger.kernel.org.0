Return-Path: <linux-pm+bounces-13073-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC229632BA
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2024 22:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EE61285A92
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2024 20:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5201AD9CE;
	Wed, 28 Aug 2024 20:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hTBuPBzH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B201ACE15
	for <linux-pm@vger.kernel.org>; Wed, 28 Aug 2024 20:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724877661; cv=none; b=TFrAQE6pSo0pxX9zLk4gF+XE9E0KDO+zfjEdAUzeTSumVAE5naELIASyFEw7jd4kM9sR0GiuXY7dEsfpw+I7dp3Xkqe5sRcedhq7vByFcvqygGBnHNpG8E4tGprdUsVC28PYrbvdFejOcDvBUNUllrYW/razhRTH/DVdrMv6IQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724877661; c=relaxed/simple;
	bh=lyEKWlVXAdHnThm5a7Hsb5GZVvUabw39ifLuL5v/4d4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yoq8WvYO49+pVN/N32HLMS0sAopQvT+nvI8pJ2iqt9hiHmetqD96XAkOhnCYG+4aBhbL0Z0RPdu7NMsOO4vX09nyT9CrGq0+t+07Y4rPyXy5zwhLif5IezyKe0D9UzhROgpoI7ajZq+FQBtvc1gxq2ZE5ercQKFlGuAK+v19izg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hTBuPBzH; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5334a8a1b07so9021912e87.1
        for <linux-pm@vger.kernel.org>; Wed, 28 Aug 2024 13:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724877658; x=1725482458; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+UKb9LTQow3tyZhMojO1ZtVbADXUAPdMYsaU4aolwpQ=;
        b=hTBuPBzHJH7yH7F4CLwEMJehNWNFKdUgxkyIHLig7RmeO9vzahOXMhB3/ZYTwmjHmz
         cg3T28RneP89QRvSfFKeI/hjMtkoTXEWwR+FCxcfUDlnob4nrIs5SSdQ2jL4fF4NaqQQ
         xqCwQQqQHDzqFkew4DmCGgZByR13zN6RQpI8AkUweFvsAiTfgCUseyRrvGOcojTgpTEb
         +y1R3LAOM0+hacELCHGfONxFQHX9ongQKCMt67M/6pV2DaRjz4MXh94ooRMB16AQ9+cg
         vVEMkI1sg+sSZ0IiLcKS2NminlEmidKNKP8w6mz5jK0PJDaPZN8MdGLNzaTgkby8PvaU
         cGQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724877658; x=1725482458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+UKb9LTQow3tyZhMojO1ZtVbADXUAPdMYsaU4aolwpQ=;
        b=AexkHpShrLcZet0lIBNX5FcI4SWh6J55n8Nc9NP3O25JUC89iw8+9kZWndY/EXu2FT
         jE6FZI8MMHTxmlrmk1abtPwI4rJxOYbLYEyexCWpbtGHGHobpiuwgzGcntGQEnxhWjfj
         IUNIO4AXyynZ1/6JM8mS3UQ4AQ89kT7Sph5Xzw8zZyBEuRXZnL4Zp/ItprkI0KkQRweI
         1EavzpwTWGaedq662qpn8LbbKxo0iRxsr+zK/0CuYu6WdPoUDOA7keaXKxhbNMsq/I6t
         EcIr6m3nanRk8QHNv9ZLh+rONbDLBEh1ZNR4uAYYH7ZQt3dejhOpwOW6QL/SZ3f539pt
         cERQ==
X-Forwarded-Encrypted: i=1; AJvYcCW11jO4pPDj7bQi8lzlWpAcJdoSGYIeftwyojSZcMAwHs8L3oLeBmOv+lSWN1NYBRWI1kMI/+z3qw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1BHmFBWtdPi6GaS+mAs5HhCKc/2x6CZ7aw/JslBhi/qtcFSpc
	+tH1wnTbP5YQJnOsY3Zo8PKvNSc+7VbsQNiXmr5DCK1j7aPu6j1LikZtPIwvtBw=
X-Google-Smtp-Source: AGHT+IEepc5tO1+VRHPff38qAS3CTY6qhLxBXjCs2zlvKfu1GzMedqYjgCFt3By8Q4QgYP+zxYSYww==
X-Received: by 2002:a05:6512:33c9:b0:52e:98f6:c21f with SMTP id 2adb3069b0e04-5353e5666dbmr282747e87.16.1724877657260;
        Wed, 28 Aug 2024 13:40:57 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5334ea88e53sm2267583e87.269.2024.08.28.13.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 13:40:56 -0700 (PDT)
Date: Wed, 28 Aug 2024 23:40:55 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Tengfei Fan <quic_tengfan@quicinc.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, kernel@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 3/3] arm64: defconfig: Enable interconnect for SM4450
Message-ID: <ltvdqgwo6yuaqfrrbofsdiso2mwsbaroqtle6aqiaeecvrase7@6taplkuhpxtl>
References: <20240813-sm4450_interconnect-v4-0-41a426f0fc49@quicinc.com>
 <20240813-sm4450_interconnect-v4-3-41a426f0fc49@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813-sm4450_interconnect-v4-3-41a426f0fc49@quicinc.com>

On Tue, Aug 13, 2024 at 10:47:55AM GMT, Tengfei Fan wrote:
> Add the SM4450 interconnect driver as built-in. On SM4450 platform,
> support for features such as UFS and USB will be gradually implemented.
> These features rely on interconnect, so the internnect functionality
> need to be enabled.

Please take a look at the git log of the defconfig. Usually commits name
a device which requires the driver rather than just mentioning a
platform. Also if intercoonect driver is only required when USB or UFS
blocks are supported on the platform, please consider enabling it as a
part of the corresponding features enablement.

> 
> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 01dd286ba7ef..593b89e66166 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -1624,6 +1624,7 @@ CONFIG_INTERCONNECT_QCOM_SC8180X=y
>  CONFIG_INTERCONNECT_QCOM_SC8280XP=y
>  CONFIG_INTERCONNECT_QCOM_SDM845=y
>  CONFIG_INTERCONNECT_QCOM_SDX75=y
> +CONFIG_INTERCONNECT_QCOM_SM4450=y
>  CONFIG_INTERCONNECT_QCOM_SM6115=y
>  CONFIG_INTERCONNECT_QCOM_SM8150=y
>  CONFIG_INTERCONNECT_QCOM_SM8250=y
> 
> -- 
> 2.25.1
> 

-- 
With best wishes
Dmitry

