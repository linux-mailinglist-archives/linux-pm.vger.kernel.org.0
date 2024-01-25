Return-Path: <linux-pm+bounces-2768-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3BC83CC04
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jan 2024 20:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EC1C1C2250F
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jan 2024 19:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5783C134730;
	Thu, 25 Jan 2024 19:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="ai6EcKs1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D6C1350E4
	for <linux-pm@vger.kernel.org>; Thu, 25 Jan 2024 19:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706210172; cv=none; b=oZxaroYMLJJ43lEhiAHS7skQ6Of3A9+57YUcErkPfVqDXhx+hU5xHjcqO4tJRd4PWz9Y9oMSJqAsixX1D2jMSpYfR+f2Ry4hxmiofu0tOGm7fp101m8Ur3xe3FzRRxkLMhy93qsFWmFhP0JSs4IqC93vfJ7CFGAD/hg0iBWh3uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706210172; c=relaxed/simple;
	bh=09vrqzF6q+v3GSLa4a6q1J4UdDnckaZNCxxfSutxA6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wj5x1cOc1uJB6ydUQk4VUPKunqrIJwqLJsm1EDtjIAiw0YIxdi5KbV9oKig63tiqDHi2edlQF+sHjqvZMOpYYXCvVTVGwJoYzgWleQMvav6k+lsKn4GtrrWbznUqwuV8Jcb2hpAEPgibd9iUrHRToQI0Xrro9g2cn6zBcMlrUW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=ai6EcKs1; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ccec119587so91130991fa.0
        for <linux-pm@vger.kernel.org>; Thu, 25 Jan 2024 11:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech.se; s=google; t=1706210168; x=1706814968; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OmBqHxoi1/NsICzRv9uA89VCC1IgkS6de7qvx7LzHjs=;
        b=ai6EcKs1WW3xq8b0KWD5jRFKW2nJKmO6F/YDvtGzm/bel97TTaO6PIP0I65mYKRSpJ
         GVYWZl5x3d/4odAz4WeIGLpgsxeYQ0bzdfu2FSzpujkpZjOy9GnbUrPTO/FwmyHVk8HP
         /R0oLb8K5bZUTsbKmPosaPNAYFw78u35EAdg72Wrp2dOjSvu+wB8PwaGrEh+2ZscScSR
         teFJ++6/b0WPOttrcl8uVQVjkk+HtPbhrOlDDchwfyh1rWGTXHMe5GyKkjRNYmrri1CT
         I8TrmXxvtwyBMXFuKrDQyswMLdIj4F3v8UN9Xcpi9XdRooS7/V5rkdjwzVdw66BKMLAK
         jZtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706210168; x=1706814968;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OmBqHxoi1/NsICzRv9uA89VCC1IgkS6de7qvx7LzHjs=;
        b=KzML0Linf7tGGBTLxqVC72uOJhVoaADa/ndKBBx62iFlxWE9NA3Fv62ruS3B61cUIB
         g2xOW2w676x4Mb3pNElhE3nnRc98O0lPDtpzux3b5z2pN4rKrMq9fzxMMEipf2HHPmJD
         Gngf2X2f0fDTiU50Ds4tH0QwRP843J1w3wAFFn79PwINT/HR9aix3RvhcYPwocrzF0CS
         ssniibY20C9I576OBdDvFnFHOuo+DebzyE3o0rqXXGNWnKrLjeFMm5d0rLmQ6RYxbLpV
         u9wXVWMsmtaMGXwWviKo5d/dbfHhOl0TtW5TEwiNlb/zJdiKuq4QyqdPkzRTMS/Fko/L
         Naew==
X-Gm-Message-State: AOJu0YzmACgWtebehtoLTIzoYmwtf8a4Uw24IoawDE8wYhz+xMcO9u7M
	DbD1GUpu0UG7g+IkUy+jVvw+t15fAScoER+mqr8LKOrvIhbbqr/ZvEECN4L7PdI=
X-Google-Smtp-Source: AGHT+IHWEkqNuG86dx3DnIpU6B2Sugfv9OUGOxAvp/LpQrYdwhdsGQTlw3AWwkerWvRzifluFaf/5A==
X-Received: by 2002:a2e:b556:0:b0:2cf:2fb0:978 with SMTP id a22-20020a2eb556000000b002cf2fb00978mr82751ljn.45.1706210168001;
        Thu, 25 Jan 2024 11:16:08 -0800 (PST)
Received: from localhost (h-46-59-36-113.A463.priv.bahnhof.se. [46.59.36.113])
        by smtp.gmail.com with ESMTPSA id f15-20020a2e918f000000b002cd35d8b018sm356032ljg.113.2024.01.25.11.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 11:16:07 -0800 (PST)
Date: Thu, 25 Jan 2024 20:16:06 +0100
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Magnus Damm <magnus.damm@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
	Cong Dang <cong.dang.xn@renesas.com>,
	Duy Nguyen <duy.nguyen.rh@renesas.com>,
	Hai Pham <hai.pham.ud@renesas.com>,
	Linh Phung <linh.phung.jy@renesas.com>,
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 14/15] arm64: dts: renesas: Add Gray Hawk Single board
 support
Message-ID: <20240125191606.GQ4126432@ragnatech.se>
References: <cover.1706194617.git.geert+renesas@glider.be>
 <b657402113267acd57aece0b4c681b707e704455.1706194617.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b657402113267acd57aece0b4c681b707e704455.1706194617.git.geert+renesas@glider.be>

Hi Geert,

On 2024-01-25 16:34:42 +0100, Geert Uytterhoeven wrote:
> Add initial support for the Renesas Gray Hawk Single board, which is
> based on the R-Car V4M (R8A779H0) SoC:
>   - Memory,
>   - Crystal oscillators,
>   - Serial console.
> 
> Based on the White Hawk Single DTS, and on a patch for the Gray Hawk
> board stack in the BSP by Hai Pham.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
> v2:
>   - Add SoC name to top-level comment.
> ---
>  arch/arm64/boot/dts/renesas/Makefile          |  2 +
>  .../dts/renesas/r8a779h0-gray-hawk-single.dts | 52 +++++++++++++++++++
>  2 files changed, 54 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/renesas/r8a779h0-gray-hawk-single.dts
> 
> diff --git a/arch/arm64/boot/dts/renesas/Makefile b/arch/arm64/boot/dts/renesas/Makefile
> index 1d7d69657a1f0559..4c5ac5f02829ff58 100644
> --- a/arch/arm64/boot/dts/renesas/Makefile
> +++ b/arch/arm64/boot/dts/renesas/Makefile
> @@ -86,6 +86,8 @@ dtb-$(CONFIG_ARCH_R8A779G0) += r8a779g0-white-hawk-ard-audio-da7212.dtbo
>  r8a779g0-white-hawk-ard-audio-da7212-dtbs := r8a779g0-white-hawk.dtb r8a779g0-white-hawk-ard-audio-da7212.dtbo
>  dtb-$(CONFIG_ARCH_R8A779G0) += r8a779g0-white-hawk-ard-audio-da7212.dtb
>  
> +dtb-$(CONFIG_ARCH_R8A779H0) += r8a779h0-gray-hawk-single.dtb
> +
>  dtb-$(CONFIG_ARCH_R8A77951) += r8a779m1-salvator-xs.dtb
>  r8a779m1-salvator-xs-panel-aa104xd12-dtbs := r8a779m1-salvator-xs.dtb salvator-panel-aa104xd12.dtbo
>  dtb-$(CONFIG_ARCH_R8A77951) += r8a779m1-salvator-xs-panel-aa104xd12.dtb
> diff --git a/arch/arm64/boot/dts/renesas/r8a779h0-gray-hawk-single.dts b/arch/arm64/boot/dts/renesas/r8a779h0-gray-hawk-single.dts
> new file mode 100644
> index 0000000000000000..1ed404712d823871
> --- /dev/null
> +++ b/arch/arm64/boot/dts/renesas/r8a779h0-gray-hawk-single.dts
> @@ -0,0 +1,52 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +/*
> + * Device Tree Source for the R-Car V4M Gray Hawk Single board
> + *
> + * Copyright (C) 2023 Renesas Electronics Corp.
> + * Copyright (C) 2024 Glider bv
> + */
> +
> +/dts-v1/;
> +#include "r8a779h0.dtsi"
> +
> +/ {
> +	model = "Renesas Gray Hawk Single board based on r8a779h0";
> +	compatible = "renesas,gray-hawk-single", "renesas,r8a779h0";
> +
> +	aliases {
> +		serial0 = &hscif0;
> +	};
> +
> +	chosen {
> +		bootargs = "ignore_loglevel";
> +		stdout-path = "serial0:921600n8";
> +	};
> +
> +	memory@48000000 {
> +		device_type = "memory";
> +		/* first 128MB is reserved for secure area. */
> +		reg = <0x0 0x48000000 0x0 0x78000000>;
> +	};
> +
> +	memory@480000000 {
> +		device_type = "memory";
> +		reg = <0x4 0x80000000 0x1 0x80000000>;
> +	};
> +};
> +
> +&extal_clk {
> +	clock-frequency = <16666666>;
> +};
> +
> +&extalr_clk {
> +	clock-frequency = <32768>;
> +};
> +
> +&hscif0 {
> +	uart-has-rtscts;
> +	status = "okay";
> +};
> +
> +&scif_clk {
> +	clock-frequency = <24000000>;
> +};
> -- 
> 2.34.1
> 
> 

-- 
Kind Regards,
Niklas Söderlund

