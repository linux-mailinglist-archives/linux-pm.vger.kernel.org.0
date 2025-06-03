Return-Path: <linux-pm+bounces-28020-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 736E6ACC7A2
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 15:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02C381743FB
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 13:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF32230BD4;
	Tue,  3 Jun 2025 13:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NzT5xA3O"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C001A08AF;
	Tue,  3 Jun 2025 13:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748956929; cv=none; b=IeGedlJK3750FozwyuVrcn2lbs1hnoaZrmUs4lBFx41RwgBrJwV4OoZ4cykuGcmh/JY3Y+dngLWUKcYAeUunPAddG7L+KS2hGdli4uDfUUTLyW9ursyn7cgB4wmxsQVWIXv2KSD4+enX04EnBtDFDjLwmlkO4FRVlyZ5fBqEiZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748956929; c=relaxed/simple;
	bh=AeP+iL5P7qpLgfVgmLcOenednHQMm95Ci593umBxRE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=APqPR9Ryj4OPWNgCPgp4isyAYcxVq7OZBuihFviE089O9PesD6WBEbLexK5l0bksSQZEBWalVQx6qUr3lmrfm6TK/x5IXrLXVoFsrh9JI7N2/DyvFhvT9O3swZaf3cRZ0AjEYzFpe+t+KFQ4lr+Masg5W9ueWZ1dwSiyxNn7Nko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NzT5xA3O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0281C4CEED;
	Tue,  3 Jun 2025 13:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748956928;
	bh=AeP+iL5P7qpLgfVgmLcOenednHQMm95Ci593umBxRE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NzT5xA3OmAdEgRSvkvLt9CI1a+FbVuq2tkARJG7t186qPTmQtIBAqDj3Riq4lYU3X
	 hh7augS36aqONwII4MdyqFp8Cm0MD4oq5vTNoinNv5wPB7eOOpd536RG+bbiYTK5fU
	 K66Hai7QwRu4Vd/vvPeiQ7XJul0Soe/BtUzqMzGPus5AxEvZiewHu58dhX+CGt2Ex6
	 RKOYR23e8jQSTbxbSF6/Pc9+FiFjqXXDCViGzSGgQpFpHdXF8nKtO0GZoXA+SHtT5r
	 abxL40K0qMXZ0aTcHfXbJ+gjEz+wN6rXdMoxE5XeYkzO8gooxbgalqtlwh4GoCAvzF
	 KjN/DUfmd3fRQ==
Date: Tue, 3 Jun 2025 15:22:05 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>, 
	Fu Wei <wefu@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 6/8] riscv: dts: thead: Add GPU power sequencer node
Message-ID: <20250603-gleaming-mammoth-of-kindness-538add@kuoka>
References: <20250530-apr_14_for_sending-v3-0-83d5744d997c@samsung.com>
 <CGME20250529222408eucas1p20f62cea4c9c64bb5dda6db1fd38fb333@eucas1p2.samsung.com>
 <20250530-apr_14_for_sending-v3-6-83d5744d997c@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250530-apr_14_for_sending-v3-6-83d5744d997c@samsung.com>

On Fri, May 30, 2025 at 12:23:53AM GMT, Michal Wilczynski wrote:
> Add the device tree node for the T-HEAD TH1520 GPU power sequencer
> (gpu_pwrseq) to the th1520.dtsi file.
> 
> This node instantiates the thead,th1520-gpu-pwrseq driver, which

Explain the hardware, not what drivers do.

> is responsible for managing the GPU's power-on/off sequence. The node
> specifies the gpu-clkgen reset, which is one of the resources
> controlled by this sequencer.
> 
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---
>  arch/riscv/boot/dts/thead/th1520.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
> index bdbb1b985b0b76cf669a9bf40c6ec37258329056..6170eec79e919b606a2046ac8f52db07e47ef441 100644
> --- a/arch/riscv/boot/dts/thead/th1520.dtsi
> +++ b/arch/riscv/boot/dts/thead/th1520.dtsi
> @@ -238,6 +238,12 @@ aon: aon {
>  		#power-domain-cells = <1>;
>  	};
>  
> +	gpu_pwrseq: pwrseq {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +		compatible = "thead,th1520-gpu-pwrseq";
> +		resets = <&rst TH1520_RESET_ID_GPU_CLKGEN>;
> +		reset-names = "gpu-clkgen";

What is the point of pwrseq if there is no consumer/user of it? Looks
like simple placeholder and anyway maybe the future consumer should just
use reset directly.

Best regards,
Krzysztof


