Return-Path: <linux-pm+bounces-29019-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BF0ADF9A1
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 00:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38289178753
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 22:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F61627FB14;
	Wed, 18 Jun 2025 22:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b="nGd+6EMy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F3F16B3B7
	for <linux-pm@vger.kernel.org>; Wed, 18 Jun 2025 22:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750287303; cv=none; b=NDF7TD9kQOO1BDje3+PULiEkbK4fIT5/8J/Ad0lxW8nCkZufo4RdHkIgTwKKtyM1iJNV80Y2uI7gRH6P+zPDPr4qCWysGe40W9VS56Zev1thj5StfhR3pm2kKGy78p68coImTtZ/FxFNfTpkBofnl4khyjWYnxVU6Mb147IpmFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750287303; c=relaxed/simple;
	bh=MVcOFZqeSZ2MqvQCc0Mh/4bkk3iDu1m9HAf/e2F974M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jL/QXh7a8Jfstc3ZTZMR5EDW4SqLBe9+b91YiF6QNXX9LX0rBIT7p1K16e0wrt5L99gaxC458g68GYIvuD4ckD6xV6r9FUc632JPiFP89Rxm2gnFJLfcNFEZJP82oX7rRKkZOfaIh9U/Qx+e7nBbRivh6Nj5HELnS1JMNeZR3Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com; spf=none smtp.mailfrom=pdp7.com; dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b=nGd+6EMy; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pdp7.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-234bfe37cccso3454555ad.0
        for <linux-pm@vger.kernel.org>; Wed, 18 Jun 2025 15:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pdp7-com.20230601.gappssmtp.com; s=20230601; t=1750287300; x=1750892100; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/5NwaPDyOETWv2pDddwa/aKZNaAck4pdMU751257ncI=;
        b=nGd+6EMyXEm/f7XPhD9F6aIWMRMN444fLJ0ryS73mz3Bfekd82NCX6zqFQ7hYXZ+tM
         pNQqM+/d97aZJqY34tRIYVfxXvFTNE3PmZlop+ejrjvsEDnnxbICJ47e4vkQsuXlSbmV
         kXtBnaHGifK56qrJTCTeDiM7Bp7YgaVlzz7vbHsr9dzeS1ZsGfX0supdSSsqNvbROnzW
         MfI5ELI2r6wR+kI22FH/TAQq9Z0aYkrWEA3+NJrR2Ncq186IOq+BJNpkGT/jQ2Etgzyz
         L06Of1ifi2jQZY8gsxZbXVJvTZuoSyrfbXiXcXYfJuXf88U+j613wO8b2NZyDr9Pcqec
         fPQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750287300; x=1750892100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/5NwaPDyOETWv2pDddwa/aKZNaAck4pdMU751257ncI=;
        b=KeldwboCcqXyP/fZ6ttRrH4Gplu3XqvkrUKeMmbKKyQ+4lBRO1x1/Iak6lHYT5+LFg
         yX2G9VvOv1FX0pkqUes5RjIHz48uweQklEw6YDk6JvkPKNFPH+rwbvcQbV8dVBnc4n8K
         gvLhTu2/Ow7wOQ4SG7Wvc6KFYk+qA4KAxshHlZ4Zr31YP9WpilPbPTVQ2Nf8rdcbNgQA
         LXSufN9H/i3WDkUuiQsRcGSRF58YPnbyaQsv0mXTVFtIazejODKA/7/oIKGNWMl1ubaX
         OpY5kPb1v0ASoIYrCBHOfzVRniktIDDy73P0VkDgJsHQHq7RUQMWsIWBPGZMy76LpCJH
         g8Tg==
X-Forwarded-Encrypted: i=1; AJvYcCX3ofE7tTgEfkPXLDyiDpM2KSqvymc9Tvu98VxdGoTyNGedPtQGZXo9cFQfhaVIg3ASf8Wl7LizDw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyFd93xwJkctW2XanNH59UeAcufIHm8M31XPWxhUfoJpcrH68Zi
	tbvl95Qk1R/CwD6gnRa+4EHwyFR1LolDTCsxDOVYktCt5jhgk8ZhR/29HuZDIF3ugM4=
X-Gm-Gg: ASbGncuFVarcwQvEH7wp6HwDArNouD9mPb5kTkaUXx4q1oaXDXLJ7ODBIN2U7NkrhiS
	rHDb3/97Hm2CQEK+1oNv8MLjwq9YCeqQ25W3qEQy44dRqgdrNe5Ok/47iLYZ0k+YBPGuTy6ngHL
	gzUZpz6zcq8sRma49ERHtC5Xneb1m5XmwcJSn6Sd4ERs2CSluyG5T9qmcfCt0RoB09D2+apOGD1
	B51Ylf+l0DQvFupVwjQbN1wn4XqHGhSbfKQ+DL8exUa4NaV+e1OS+NAe01CVGBp1BiAA4JtDeYx
	ipsL0SepAkQaI6XkCOuh+fiuxEaxtQju8xtt8e1Ng9y9WCoUc7EHKtlU67L23ZBSkrn7N6/zs0T
	28bzzJQ==
X-Google-Smtp-Source: AGHT+IHgVrtzzhpW+oJLMdXuYbVuOtesVP9Nvp/NylotZPQenDpgvWchZUgnqqSWky9m7BlwSjYVnw==
X-Received: by 2002:a17:90a:dfcb:b0:313:d346:f347 with SMTP id 98e67ed59e1d1-313f1e27e38mr28887847a91.35.1750287300056;
        Wed, 18 Jun 2025 15:55:00 -0700 (PDT)
Received: from x1 (97-120-250-80.ptld.qwest.net. [97.120.250.80])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3158a24be89sm591076a91.23.2025.06.18.15.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 15:54:59 -0700 (PDT)
Date: Wed, 18 Jun 2025 15:54:57 -0700
From: Drew Fustini <drew@pdp7.com>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Frank Binns <frank.binns@imgtec.com>,
	Matt Coster <matt.coster@imgtec.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v5 1/8] power: sequencing: Add T-HEAD TH1520 GPU power
 sequencer driver
Message-ID: <aFNDwcK5+ZuHBdrw@x1>
References: <20250618-apr_14_for_sending-v5-0-27ed33ea5c6f@samsung.com>
 <CGME20250618102226eucas1p112dacf9670f68b4a8581aa1a8b5ced9d@eucas1p1.samsung.com>
 <20250618-apr_14_for_sending-v5-1-27ed33ea5c6f@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618-apr_14_for_sending-v5-1-27ed33ea5c6f@samsung.com>

On Wed, Jun 18, 2025 at 12:22:07PM +0200, Michal Wilczynski wrote:
> Introduce the pwrseq-thead-gpu driver, a power sequencer provider for
> the Imagination BXM-4-64 GPU on the T-HEAD TH1520 SoC. This driver
> controls an auxiliary device instantiated by the AON power domain.
> 
> The TH1520 GPU requires a specific sequence to correctly initialize and
> power down its resources:
>  - Enable GPU clocks (core and sys).
>  - De-assert the GPU clock generator reset (clkgen_reset).
>  - Introduce a short hardware-required delay.
>  - De-assert the GPU core reset. The power-down sequence performs these
>    steps in reverse.
> 
> Implement this sequence via the pwrseq_power_on and pwrseq_power_off
> callbacks.
> 
> Crucially, the driver's match function is called when a consumer (the
> Imagination GPU driver) requests the "gpu-power" target. During this
> match, the sequencer uses clk_bulk_get() and
> reset_control_get_exclusive() on the consumer's device to obtain handles
> to the GPU's "core" and "sys" clocks, and the GPU core reset.  These,
> along with clkgen_reset obtained from parent aon node, allow it to
> perform the complete sequence.
> 
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---
>  MAINTAINERS                                 |   1 +
>  drivers/power/sequencing/Kconfig            |   8 +
>  drivers/power/sequencing/Makefile           |   1 +
>  drivers/power/sequencing/pwrseq-thead-gpu.c | 231 ++++++++++++++++++++++++++++
>  4 files changed, 241 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0183c028fa18c397d30ec82fd419894f1f50a448..3283ff592215249bcf702dbb4ab710477243477e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21395,6 +21395,7 @@ F:	drivers/mailbox/mailbox-th1520.c
>  F:	drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
>  F:	drivers/pinctrl/pinctrl-th1520.c
>  F:	drivers/pmdomain/thead/
> +F:	drivers/power/sequencing/pwrseq-thead-gpu.c
>  F:	drivers/reset/reset-th1520.c
>  F:	include/dt-bindings/clock/thead,th1520-clk-ap.h
>  F:	include/dt-bindings/power/thead,th1520-power.h
> diff --git a/drivers/power/sequencing/Kconfig b/drivers/power/sequencing/Kconfig
> index ddcc42a984921c55667c46ac586d259625e1f1a7..7fa912c9af2479cdce909467c29fe335788f0bd7 100644
> --- a/drivers/power/sequencing/Kconfig
> +++ b/drivers/power/sequencing/Kconfig
> @@ -27,4 +27,12 @@ config POWER_SEQUENCING_QCOM_WCN
>  	  this driver is needed for correct power control or else we'd risk not
>  	  respecting the required delays between enabling Bluetooth and WLAN.
>  
> +config POWER_SEQUENCING_THEAD_GPU
> +	tristate "T-HEAD TH1520 GPU power sequencing driver"
> +	depends on ARCH_THEAD && AUXILIARY_BUS
> +	help
> +	  Say Y here to enable the power sequencing driver for the TH1520 SoC
> +	  GPU. This driver handles the complex clock and reset sequence
> +	  required to power on the Imagination BXM GPU on this platform.

This is a minor nit but maybe this should be POWER_SEQUENCING_TH1520_GPU?

I often grep for TH1520 to make sure I have all the options enabled and
it took me a second to realize it was 'THEAD' instead of 'TH1520'.

In retrospect, I probably should have have used CONFIG_DWMAC_TH1520 for
the ethernet driver instead of CONFIG_DWMAC_THEAD.

Thanks,
Drew

