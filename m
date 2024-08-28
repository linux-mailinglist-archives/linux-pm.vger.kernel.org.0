Return-Path: <linux-pm+bounces-13070-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D0896329F
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2024 22:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C93E228A1E8
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2024 20:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96731B78F5;
	Wed, 28 Aug 2024 20:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rsKekD1D"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E931AC8BF
	for <linux-pm@vger.kernel.org>; Wed, 28 Aug 2024 20:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724877526; cv=none; b=Cpk/8bQ8we+q9Iu9Oe3/fRAvLVgacoKeiHqKIyHEOczhNfrcYQ3M5V3gXeSiJ4P4mjNGUsHIIOVK/aDpuwgj9GVdoQzCrx4afQcMHkchcKSIVeAd/YGlKgnxjaVWvq2a5Ufhc4OOAE/egQqMWdVg1R4Uc4BNF6wUYiWCYWfCN+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724877526; c=relaxed/simple;
	bh=K+lCygMRE3qyJWdl/GdEZGE+ba1atTZSeNTjbrLyKeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JLb9Ycr3YXVCoZd21JgQX6mxyjT1inI+tb+D7l9NwLmB9Rn/pVVC9LVneru1GlbAG5Y+MIaqp8LxZ5QTJXmGouTklHsEWBbjSbuuRtPannErrp6Aoz5CAzuqMNIZijeZZie2XT24YmmKxROWrhaZyaUQfdjhPCGvhW2vmDHA00k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rsKekD1D; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-533463f6b16so8452405e87.1
        for <linux-pm@vger.kernel.org>; Wed, 28 Aug 2024 13:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724877523; x=1725482323; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x462g7ZWs4h3Hy1zE24TOG/f1mPwTtweyG1eiKJBSx4=;
        b=rsKekD1DAQS0lNo6w80agSuaUkD8NOaO+bFzsyXze75h/rjBzlP1DzLmptrXPOgfAk
         mPzZwqwgnYWv1Ujyk9KBzsVzF55zGl6h6Bg3PUiLW8wGLCLlcgYAIOHjzk4CcFtWEN1Y
         uTWDSKxzQRh1s88GTeGNNH3Pgi8PrBVmk4V6lI5uzhdpcDrogF2aLK2oQyJH5mA1rXHD
         blds0KiDpyxGW1MWSw7aVzW+FSSS9ejVc8L7nCziJ/49/TeyM8gBnysYQFkjfQZp19iu
         +YVdRk+pJKwqYAABeGXfo3Zv1rLpLokNyQG4L3ylurIBHEKQ3UwZzXdAUFQZbxvA8+8K
         1Gfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724877523; x=1725482323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x462g7ZWs4h3Hy1zE24TOG/f1mPwTtweyG1eiKJBSx4=;
        b=GTwVAzZY25LZdsii/4zVd+9C8cjIz7FfLRunbaOlfwwcVIuDWh2RNttA1zir0jEVj+
         cP63hKswKXCpAchobC5e9p43xT22poJbG/Qdw8qVbxjkfSFXSjsVHvVe2MdP+YLhEZ9F
         DwAfRZLHwKlbbdl/O5rTipHogRARGVop6Lq79qQipReB+oOxjVSvWs3GX6Y9xBhFrjkh
         bX4p275RsDo2PVgWEfJmASFh2QjPGl5Ky/POKUldm5KrD/EKy7qaU1pQw+hSDF0Npoaa
         besBB/LCU5XblevQGZrcHQ1wttAByZXAunu79FS9t55H+jEC/A/pJOznr6K7lMPDu0hK
         b9Wg==
X-Forwarded-Encrypted: i=1; AJvYcCWQexGBj+gXCY+kwwwtPTeXKSSjWsj18tvYdfpt8nZkr0/XrsrBTKS0N2Vgbkcp4Roy7LQM8VaWnQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxbQLu1hu/HrHNiNXoz1PeXm1SeN+PxuFOROtJc+Rd2kplw69tS
	uqXdG18fGs6dVgee21kicHwKuqLTjxW1FlJLH9wQeju9aSom1oNSfw4sCGWIfh4=
X-Google-Smtp-Source: AGHT+IHc3Qk42WkdG0WrRXfObmEa8xWIHNllAS5bHRWo8S/cMne7NBCSqkvuXItwd2U/zT4/Fzw7Iw==
X-Received: by 2002:a05:6512:6cf:b0:52f:c5c0:2879 with SMTP id 2adb3069b0e04-5353e5b83d3mr280301e87.41.1724877522331;
        Wed, 28 Aug 2024 13:38:42 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5334ea292fesm2274204e87.9.2024.08.28.13.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 13:38:41 -0700 (PDT)
Date: Wed, 28 Aug 2024 23:38:40 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Tengfei Fan <quic_tengfan@quicinc.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, kernel@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 2/3] interconnect: qcom: Add SM4450 interconnect
 provider driver
Message-ID: <jsf66upx7xfhm4omzgwr5b5v7isihond62jsspsgqdjymbciha@b6jzlyqoxgqz>
References: <20240813-sm4450_interconnect-v4-0-41a426f0fc49@quicinc.com>
 <20240813-sm4450_interconnect-v4-2-41a426f0fc49@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813-sm4450_interconnect-v4-2-41a426f0fc49@quicinc.com>

On Tue, Aug 13, 2024 at 10:47:54AM GMT, Tengfei Fan wrote:
> Add driver for the Qualcomm interconnect buses found in SM4450 based
> platforms. The topology consists of several NoCs that are controlled
> by a remote processor that collects the aggregated bandwidth for each
> master-slave pairs.
> 
> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> ---
>  drivers/interconnect/qcom/Kconfig  |    9 +
>  drivers/interconnect/qcom/Makefile |    2 +
>  drivers/interconnect/qcom/sm4450.c | 1722 ++++++++++++++++++++++++++++++++++++
>  drivers/interconnect/qcom/sm4450.h |  152 ++++
>  4 files changed, 1885 insertions(+)

[skipped]

> +#define SM4450_SLAVE_TCU				591
> +#define SM4450_MASTER_LLCC_DISP				1000
> +#define SM4450_MASTER_MDP_DISP				1001
> +#define SM4450_MASTER_MNOC_HF_MEM_NOC_DISP				1002
> +#define SM4450_MASTER_ANOC_PCIE_GEM_NOC_DISP				1003
> +#define SM4450_SLAVE_EBI1_DISP				1512
> +#define SM4450_SLAVE_LLCC_DISP				1513
> +#define SM4450_SLAVE_MNOC_HF_MEM_NOC_DISP				1514

Please drop _DISP defines

> +
> +#endif
> 
> -- 
> 2.25.1
> 

-- 
With best wishes
Dmitry

