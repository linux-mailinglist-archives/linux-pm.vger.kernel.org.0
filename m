Return-Path: <linux-pm+bounces-26894-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE013AAFB27
	for <lists+linux-pm@lfdr.de>; Thu,  8 May 2025 15:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D2A81BC6F44
	for <lists+linux-pm@lfdr.de>; Thu,  8 May 2025 13:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0924A22B8AF;
	Thu,  8 May 2025 13:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uq8j7UTv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716AA22128B
	for <linux-pm@vger.kernel.org>; Thu,  8 May 2025 13:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746710428; cv=none; b=NCYPgZG66xInxX1kYM+oyVIf3e9Dtd6Mzbdzd+FxZvziYd8bZlSA0RyDIoA+8+j8qF04FazYkra/K+TEL9B8TX2aI7Al7f2wAG+u7yKGhuLiba3qG9l9+BhDDc0Re4aqJ+ZOHASo6BC2j6c7HrfPPFbf9VM2OfQK+tTuntVS2iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746710428; c=relaxed/simple;
	bh=Ggq7sLTVtObPJWu9TR8xbrcUROsW0mIC4OEmuNAJ6Sk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=STTHqxo7ORqqiYn1blZbuTNVt4Fpk3xK4cYDG5MKJhUAp9ap6/j9aODNlcapo2UwLL+s/ID9hdOoxQ00ESbACA2dWjvBQ2+xA4iMcyyS50tGOnwzI8JyWbo5VMyIHBswIh/CscK5na8XaWhBffw6sJ9XgCZ05iDmAzHPMEmfn6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=uq8j7UTv; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-74019695377so726108b3a.3
        for <linux-pm@vger.kernel.org>; Thu, 08 May 2025 06:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746710426; x=1747315226; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jyuniMudFryF3hn/u/aLddug+sED3jw9d54qmOZEBFQ=;
        b=uq8j7UTvwrwVzSLVy0LbYG77QdyXvW2YloFBmRzvtahEdFy8HPMCjhqkTmQsCErfXM
         qxABsYvtURW4R/TEHJIgC/eCdwRe3XRgVvTMUameN8+XbSRtQxtosVohRzVuLeh6F7wQ
         2TGONHlJnSDK5J/MHF7KZ+upMREemjG9eMm31k7UdFRS5X+Xvl2uZtm6QPHLb6unHnZ+
         PgInSXQRJnpEfRFuNOiJeUaUJ0AfH7Uajgsi0FQM5ZHr8dnMv43OYL19XvevoV0+XB/o
         zRpeOn+Qc/tenfW9Vqx5iu5QTLdOIw9OoEUY+5I8QR5iKfyJXVwLwrw4bRI+JRxHEL0v
         hbuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746710426; x=1747315226;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jyuniMudFryF3hn/u/aLddug+sED3jw9d54qmOZEBFQ=;
        b=doN3uSkWlEOVRIYwMQwD2WHTxxhyGjBln5MdpKIR9HDJ4+NgHyJHxi8552O7Y/xU6O
         dm2anUYdHRExbtYtPNkjoFXyqQx5tsAnlGgRqEW92h+hYz70rAGK6cmrpr/aSJa5KS/r
         ZNuObRF2Q4xL04XqERkwOahGKVX1TYPio8ngyWiNLTbDdbEnir9YkVjVkBdBfmXrM48E
         9aa+F+mtkiac+ds4WbRLba1P9Aro2qmwOGa6vuqFQ1dmnABqwfG8XjKVHTLhbWUqLoXN
         q/nnHe+nzGnjQYy1xxQXdlLGNmtsEJoDnKC2w1FIO3RhiR6ioN0dNx566CGWrOjHPJZA
         laqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAeXyXhhBqNZFEhKpb0BoqN7WM9C+vK/RZe+mqNK/VqrfCN1eJcZGncQrYppIc3xBEuHOvKwb7tQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJYv7gdPO3xQXKTYBiF8oKeXMcV67rRXXMN2RvwLJwFxDObQtJ
	kXaGT2N5UgWaEqsVCMULUS1pxR5iO/HVg9C6lU/WAJNmwcGUur5KqrQYom3Ao4E=
X-Gm-Gg: ASbGnctH+xa/yTIW/aqlhrXdEh5ECgscYG8YifyklWGwsP8UWCwfeULLFiX1F0Mnm4J
	sggWpvvrEqi60+voXQYvNxgs8XBIeOmdAFtx6HOq3rD4GO0/lMZRZZQy6vaC+Qwz+2ZPkw8FN35
	EVbkoEQgi0LheIThCI7GzSs2bShdr3XUub6YwRaAK7kGtY+C+ZgayfPlmrc951sDGsY6OjnfDjH
	jRpenIDC8kV3LqIG4qTp/1dt4gl47ZPyxwCGDK3pKgloncn47hWv9OkODUE479uyfVA5Z+WYchN
	CDjOU89vjbBjpjqU1oN3gYzikgQovfaLW3x5qFU=
X-Google-Smtp-Source: AGHT+IET79Nq5FMlY1YATt34uIy9W6bQc0RASasVjOkYJxKwtGwvC9A4L+o3Stc03w0qdqPEQha4oQ==
X-Received: by 2002:a05:6a20:3d92:b0:1f5:8072:d7f3 with SMTP id adf61e73a8af0-2159b04ebd7mr5425027637.30.1746710425718;
        Thu, 08 May 2025 06:20:25 -0700 (PDT)
Received: from localhost ([97.126.182.119])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-740b0d154b5sm1350253b3a.56.2025.05.08.06.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 06:20:24 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Sukrut Bellary <sbellary@baylibre.com>, Russell King
 <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>, Tony Lindgren
 <tony@atomide.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Nishanth
 Menon <nm@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 soc@lists.linux.dev
Cc: Sukrut Bellary <sbellary@baylibre.com>, Aaro Koskinen
 <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, Roger
 Quadros <rogerq@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Santosh
 Shilimkar <ssantosh@kernel.org>, Bajjuri Praneeth <praneeth@ti.com>,
 Raghavendra Vignesh <vigneshr@ti.com>, Bin Liu <b-liu@ti.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject: Re: [PATCH 4/4] ARM: multi_v7_defconfig: Enable am335x PM configs
In-Reply-To: <20250318230042.3138542-5-sbellary@baylibre.com>
References: <20250318230042.3138542-1-sbellary@baylibre.com>
 <20250318230042.3138542-5-sbellary@baylibre.com>
Date: Thu, 08 May 2025 06:20:24 -0700
Message-ID: <7hbjs3tf1j.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sukrut Bellary <sbellary@baylibre.com> writes:

> Enable Power management related defconfigs for TI AM335x[1].
>
> [1] AM335x TRM - https://www.ti.com/lit/ug/spruh73q/spruh73q.pdf
>
> Signed-off-by: Sukrut Bellary <sbellary@baylibre.com>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>

Arnd, can you take this via the SoC tree please?

Kevin


> ---
>  arch/arm/configs/multi_v7_defconfig | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index 37e3baa33b67..1d2600b5f975 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -985,6 +985,7 @@ CONFIG_EDAC=y
>  CONFIG_EDAC_LAYERSCAPE=y
>  CONFIG_EDAC_HIGHBANK_MC=y
>  CONFIG_EDAC_HIGHBANK_L2=y
> +CONFIG_RTC_DRV_OMAP=y
>  CONFIG_RTC_CLASS=y
>  CONFIG_RTC_DRV_AC100=y
>  CONFIG_RTC_DRV_AS3722=y
> @@ -1095,6 +1096,7 @@ CONFIG_TEGRA_IOMMU_SMMU=y
>  CONFIG_EXYNOS_IOMMU=y
>  CONFIG_QCOM_IOMMU=y
>  CONFIG_REMOTEPROC=y
> +CONFIG_WKUP_M3_RPROC=m
>  CONFIG_OMAP_REMOTEPROC=m
>  CONFIG_OMAP_REMOTEPROC_WATCHDOG=y
>  CONFIG_KEYSTONE_REMOTEPROC=m
> @@ -1146,6 +1148,8 @@ CONFIG_ARCH_TEGRA_3x_SOC=y
>  CONFIG_ARCH_TEGRA_114_SOC=y
>  CONFIG_ARCH_TEGRA_124_SOC=y
>  CONFIG_SOC_TI=y
> +CONFIG_AMX3_PM=m
> +CONFIG_WKUP_M3_IPC=m
>  CONFIG_KEYSTONE_NAVIGATOR_QMSS=y
>  CONFIG_KEYSTONE_NAVIGATOR_DMA=y
>  CONFIG_RASPBERRYPI_POWER=y
> @@ -1162,6 +1166,7 @@ CONFIG_EXTCON_MAX77693=m
>  CONFIG_EXTCON_MAX8997=m
>  CONFIG_EXTCON_USB_GPIO=y
>  CONFIG_TI_AEMIF=y
> +CONFIG_TI_EMIF_SRAM=m
>  CONFIG_STM32_FMC2_EBI=y
>  CONFIG_EXYNOS5422_DMC=m
>  CONFIG_IIO=y
> -- 
> 2.34.1

