Return-Path: <linux-pm+bounces-30233-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C599AFA86F
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 01:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1A173B888E
	for <lists+linux-pm@lfdr.de>; Sun,  6 Jul 2025 23:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83360264FBD;
	Sun,  6 Jul 2025 23:38:35 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10F11FECCD;
	Sun,  6 Jul 2025 23:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751845115; cv=none; b=XrTVT1XQf6yvMCtiFn5CXLILLR/drxTVS9ZAdEM/qP+xNqkHBduTIcNFJhEgLKX4KaSd1WiM0YAO1rPbqvTyu4M74q5V9qSNv4a1rwF5LxvIlr2E1TD+oiQ+z6Ww0GK+H/2ASsrQ0a8YJ5dE8uF8qcZGXRuw51F/FOTsGtT+WPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751845115; c=relaxed/simple;
	bh=DtsA/l6qRWiIzP2VEwKh9J0xtEva63aCnINk/rnEqfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uoazsSnEw//mN1CS1X6uO7cMbywIQ3W4bN5PXkTrFWMIvy3hEBakp8tMsGbsQONL5m7Ja/igz/78O1FlL5wDfxslRgXjqaozsC0bVVQm2a5rk0g8zm2miZ/L0Csvf3yaIjkuY9VbvGsV4+Dumx2rGUETZdPCtn3hsB64lxWXyw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42B281E8D;
	Sun,  6 Jul 2025 16:38:20 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F0F13F694;
	Sun,  6 Jul 2025 16:38:31 -0700 (PDT)
Date: Mon, 7 Jul 2025 00:37:00 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej@kernel.org>, Samuel
 Holland <samuel@sholland.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, linux-sunxi@lists.linux.dev,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/4] pmdomain: sunxi: sun20i-ppu: add A523 support
Message-ID: <20250707003700.7c69ec68@minigeek.lan>
In-Reply-To: <20250627152918.2606728-3-wens@kernel.org>
References: <20250627152918.2606728-1-wens@kernel.org>
	<20250627152918.2606728-3-wens@kernel.org>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Jun 2025 23:29:16 +0800
Chen-Yu Tsai <wens@kernel.org> wrote:

> From: Chen-Yu Tsai <wens@csie.org>
> 
> A523 has a PPU like the one in the Allwinner D1 SoC.
> 
> Add a compatible entry and a list of power domain names for it.

The user manual does not describe this PPU, but the BSP code confirms
the order of the domains, so:

> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

One suggestion below, but only if you respin anyway:

> ---
>  drivers/pmdomain/sunxi/sun20i-ppu.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/pmdomain/sunxi/sun20i-ppu.c b/drivers/pmdomain/sunxi/sun20i-ppu.c
> index 9f002748d224..b65876a68cc1 100644
> --- a/drivers/pmdomain/sunxi/sun20i-ppu.c
> +++ b/drivers/pmdomain/sunxi/sun20i-ppu.c
> @@ -193,6 +193,19 @@ static const struct sun20i_ppu_desc sun8i_v853_ppu_desc = {
>  	.num_domains	= ARRAY_SIZE(sun8i_v853_ppu_pd_names),
>  };
>  
> +static const char *const sun55i_a523_ppu_pd_names[] = {
> +	"DSP",

I wonder if we should enforce the relation between the DT binding
symbols and the names here, like:

	[PD_DSP] = "DSP",
	[PD_NPU] = "NPU",
	...

Cheers,
Andre


> +	"NPU",
> +	"AUDIO",
> +	"SRAM",
> +	"RISCV",
> +};
> +
> +static const struct sun20i_ppu_desc sun55i_a523_ppu_desc = {
> +	.names		= sun55i_a523_ppu_pd_names,
> +	.num_domains	= ARRAY_SIZE(sun55i_a523_ppu_pd_names),
> +};
> +
>  static const struct of_device_id sun20i_ppu_of_match[] = {
>  	{
>  		.compatible	= "allwinner,sun20i-d1-ppu",
> @@ -202,6 +215,10 @@ static const struct of_device_id sun20i_ppu_of_match[] = {
>  		.compatible	= "allwinner,sun8i-v853-ppu",
>  		.data		= &sun8i_v853_ppu_desc,
>  	},
> +	{
> +		.compatible	= "allwinner,sun55i-a523-ppu",
> +		.data		= &sun55i_a523_ppu_desc,
> +	},
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, sun20i_ppu_of_match);


