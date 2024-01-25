Return-Path: <linux-pm+bounces-2762-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AF083CB0E
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jan 2024 19:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C83CB252A2
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jan 2024 18:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8239B136664;
	Thu, 25 Jan 2024 18:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="insloKZU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917A013667A
	for <linux-pm@vger.kernel.org>; Thu, 25 Jan 2024 18:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706207148; cv=none; b=WgenO1YEB27vBLYNbzthXJgjVxvkQ+ZBqQDjxG0LfIv7tHO6PQP3IN9Sml2mttqhdiHfUTsGS3y+b/Eq0mMcBGIfLflev3L01WN1UOoZKPbkCbEDKS8OgrvZGjxIc0HvaSBFQP7Rh0gltc8TVbmMxMqr+5cKdeuMOa4feWKOe0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706207148; c=relaxed/simple;
	bh=ZWNlxoR+1hMRAsJWEOjGfIstKOtgcFa3ZuPFazzmu28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GvHx0Ob5KOSXfjK8XodPsyUvI2WyH/YdwfKTYvqsvC3SKkzCPZQvQck+vi2DmplKoeG02y765yCxamDON/EdX1R4U3wuqoGGjX61MO/rSBBlFGWhxGcI9ayCZhozAFHKV42DgPogG4/FKQv810/j+011dny/UqYFJUG1kqQ6I2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=insloKZU; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2cf3a0b2355so8203851fa.0
        for <linux-pm@vger.kernel.org>; Thu, 25 Jan 2024 10:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech.se; s=google; t=1706207144; x=1706811944; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R1HbNAAArmyIYx+70NVdiVPkoCSSDX9+F6wCHxLzr6w=;
        b=insloKZU939HOU4S6yqiSUmAX6YVJ64ooaw22rEtu/99nyxGSlsU86ARhWKkXMpGbO
         gWueWh+veXuPFoBVU/VbnC8lfNgAuRXOTZlX+D+YfsXhMUtde4jZM0nKFHj9sa8VoxsC
         H3jbPfs58szZDUUYPBROokaA5nqOAiru6Z8tKeaOC4FS7i0uioTTXb4O8tAF6T7MGwhm
         EAH46UFF3Am5pbESQ50jMbX/icHYcVWn6omin82//Plg2rIgQ5027uAQY2WsIFtk3ji2
         2yWrx3B1uiVVBL17Cmy8wfpsNVT4YBsVLLOkOVFm26zuqZXfSvG5hfI+hIiV6FEQgG4h
         WGfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706207144; x=1706811944;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R1HbNAAArmyIYx+70NVdiVPkoCSSDX9+F6wCHxLzr6w=;
        b=BVB4bmP0926Y+JhYeU8k3qSo5pZI4Dz2fOE5pEcnZ2tHFPHRDxC2eqi0aLQiXFa+25
         5YBtdJBHEx82c3X9ixh/f51gmpWM32eiJ8YL/Z3wkzVs6qvcUo6yNVrx/47Meyf8xqHv
         XE8Cpsri1EiWEOZ6z28vlLA8dh3KzvbtATXjauYa5tNlyYPFfJu8w7uUfeMCh0eEklWf
         r/B5wo4KMy0brN2iHI+AUfHVOHtnj2Uoc9l8f4v52IoWxwsGWeSokf/RZ7Tf8th4+L2z
         o8F2mSbsad1Jx4mvtQ6pfFi9i9GqgJgNyCD3nS0P1Q7SQuSPLINmejSnc8ag9yqi1uMx
         OWbA==
X-Gm-Message-State: AOJu0YyXnswIFf8DQSZ+BTzp3tqOax61a0fTgnw2TRo6d438CgnkpXUs
	x1G9cn9C4xHnJvfAxcpBkGf3KFZ2aAFnkpEJuludHizDBav4pA5315BrxWSUDus=
X-Google-Smtp-Source: AGHT+IEy3x/4zU1b+G6G9Nc7qJId8/pFCHll+4/GOnCvyCmbv7OGeQy6it2E16Ai2K3syZKDH52h9g==
X-Received: by 2002:a2e:a44d:0:b0:2cf:414f:772 with SMTP id v13-20020a2ea44d000000b002cf414f0772mr52932ljn.20.1706207144548;
        Thu, 25 Jan 2024 10:25:44 -0800 (PST)
Received: from localhost (h-46-59-36-113.A463.priv.bahnhof.se. [46.59.36.113])
        by smtp.gmail.com with ESMTPSA id q16-20020a2ea690000000b002cf19bb6b86sm341544lje.81.2024.01.25.10.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 10:25:44 -0800 (PST)
Date: Thu, 25 Jan 2024 19:25:43 +0100
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
	linux-pm@vger.kernel.org,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH v2 11/15] soc: renesas: Identify R-Car V4M
Message-ID: <20240125182543.GL4126432@ragnatech.se>
References: <cover.1706194617.git.geert+renesas@glider.be>
 <31e06d055aec1bc70c3e9a02f9268bcfc72b2204.1706194617.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <31e06d055aec1bc70c3e9a02f9268bcfc72b2204.1706194617.git.geert+renesas@glider.be>

Hi Geert,

Thanks for your work.

On 2024-01-25 16:34:39 +0100, Geert Uytterhoeven wrote:
> From: Duy Nguyen <duy.nguyen.rh@renesas.com>
> 
> Add support for identifying the R-Car V4M (R8A779H0) SoC.
> 
> Signed-off-by: Duy Nguyen <duy.nguyen.rh@renesas.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
> v2:
>   - Add Reviewed-by.
> 
> Changes compared to the BSP:
>   - Use lower-case hex for literals in C source code.
> ---
>  drivers/soc/renesas/Kconfig       | 7 +++++++
>  drivers/soc/renesas/renesas-soc.c | 8 ++++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
> index 2367385d84b5a17d..1b8a89ad4fd7e7a3 100644
> --- a/drivers/soc/renesas/Kconfig
> +++ b/drivers/soc/renesas/Kconfig
> @@ -282,6 +282,13 @@ config ARCH_R8A779G0
>  	help
>  	  This enables support for the Renesas R-Car V4H SoC.
>  
> +config ARCH_R8A779H0
> +	bool "ARM64 Platform support for R-Car V4M"
> +	select ARCH_RCAR_GEN4
> +	select SYSC_R8A779H0
> +	help
> +	  This enables support for the Renesas R-Car V4M SoC.
> +
>  config ARCH_R8A774C0
>  	bool "ARM64 Platform support for RZ/G2E"
>  	select ARCH_RCAR_GEN3
> diff --git a/drivers/soc/renesas/renesas-soc.c b/drivers/soc/renesas/renesas-soc.c
> index 67de980ec4244c41..083f6580cb5dae00 100644
> --- a/drivers/soc/renesas/renesas-soc.c
> +++ b/drivers/soc/renesas/renesas-soc.c
> @@ -271,6 +271,11 @@ static const struct renesas_soc soc_rcar_v4h __initconst __maybe_unused = {
>  	.id	= 0x5c,
>  };
>  
> +static const struct renesas_soc soc_rcar_v4m __initconst __maybe_unused = {
> +	.family = &fam_rcar_gen4,
> +	.id     = 0x5d,
> +};
> +
>  static const struct renesas_soc soc_shmobile_ag5 __initconst __maybe_unused = {
>  	.family	= &fam_shmobile,
>  	.id	= 0x37,
> @@ -381,6 +386,9 @@ static const struct of_device_id renesas_socs[] __initconst __maybe_unused = {
>  #ifdef CONFIG_ARCH_R8A779G0
>  	{ .compatible = "renesas,r8a779g0",	.data = &soc_rcar_v4h },
>  #endif
> +#ifdef CONFIG_ARCH_R8A779H0
> +	{ .compatible = "renesas,r8a779h0",	.data = &soc_rcar_v4m },
> +#endif
>  #ifdef CONFIG_ARCH_R9A07G043
>  #ifdef CONFIG_RISCV
>  	{ .compatible = "renesas,r9a07g043",	.data = &soc_rz_five },
> -- 
> 2.34.1
> 
> 

-- 
Kind Regards,
Niklas Söderlund

