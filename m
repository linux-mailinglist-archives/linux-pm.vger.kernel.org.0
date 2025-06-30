Return-Path: <linux-pm+bounces-29857-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E86AEE894
	for <lists+linux-pm@lfdr.de>; Mon, 30 Jun 2025 22:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D14A37A966C
	for <lists+linux-pm@lfdr.de>; Mon, 30 Jun 2025 20:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A54223DD4;
	Mon, 30 Jun 2025 20:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="miH6P3n5"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7592022068D;
	Mon, 30 Jun 2025 20:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751316770; cv=none; b=ULhSMpoORfw69UwS0Ta2nEggbIYuYY3q48+m7ZTqn6gdI2SiurhXnC8NTN4s4v0UETiKfysCBnNJBwx9dHXkERvdrSeGkSSMkFz0eVko4tSsSPaerJE31TyqWtiribpJPTVPU2OiaUZ4IWQHXamIY9ylfVFujFZGfocYdd0Pscc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751316770; c=relaxed/simple;
	bh=HxNS8mhOfCb2u6BZlip3RJTcxTguswhUtDe5juU/JBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TuU8/iIYP5ljAmPR2tmX0mWv4ih0WsNrz/25ePPPJ4gVHKKZSPffolsmBDYks5DWe5hEnK7FQo2lgJ+rzNw+WhOybaCJPIg9tXbwp1pB8eDFx3IlrmJqdTSLkxvfqEZo1H37/8xilCEO91P0Yq5d+1r64gwLrt4D9FKeBfIUeqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=miH6P3n5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A063C4CEE3;
	Mon, 30 Jun 2025 20:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751316770;
	bh=HxNS8mhOfCb2u6BZlip3RJTcxTguswhUtDe5juU/JBM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=miH6P3n5QAkKFfbrZCDoFYqmhti01pJkS6lvdQerD1SnIftpFt/Qf/xe7XbAoFGlg
	 EjJqkwhJWK2x5MmXkwFLgNxI+VC1v3BfmWHz1aY+sFVcw0J6DtJ4RMRXuauuedNK+I
	 1KbuO53vw1Nx0Ubl0xUWpAynhUCcglsRdTSBwMyZyXGCJc8/j4GJ2qS1CLFWyVbuPR
	 wQWkRqUzkd126bIx4FdFve76YSEhhMi28G8F/43AycBB551pfKinVpjyVlX1/EU48J
	 tYQcgJCtEYl/pqDmc5jdKGZAi7yOFC2VO3pnc3aJgpEf0cnF1JuGRqSJZgOcDg1LHI
	 Mh7Eoj/UXwT2Q==
Date: Mon, 30 Jun 2025 13:52:48 -0700
From: Drew Fustini <fustini@kernel.org>
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
	dri-devel@lists.freedesktop.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v7 3/5] riscv: dts: thead: th1520: Add GPU clkgen reset
 to AON node
Message-ID: <aGL5IBDii4kLXeQH@x1>
References: <20250626-apr_14_for_sending-v7-0-6593722e0217@samsung.com>
 <CGME20250626093359eucas1p20a737f31b582ef0a2d54082eb172586e@eucas1p2.samsung.com>
 <20250626-apr_14_for_sending-v7-3-6593722e0217@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626-apr_14_for_sending-v7-3-6593722e0217@samsung.com>

On Thu, Jun 26, 2025 at 11:33:48AM +0200, Michal Wilczynski wrote:
> Add the "gpu-clkgen" reset property to the AON device tree node. This
> allows the AON power domain driver to detect the capability to power
> sequence the GPU and spawn the necessary pwrseq-thead-gpu auxiliary
> driver for managing the GPU's complex power sequence.
> 
> This commit also adds the prerequisite
> dt-bindings/reset/thead,th1520-reset.h include to make the
> TH1520_RESET_ID_GPU_CLKGEN available. This include was previously
> dropped during a conflict resolution [1].
> 
> Link: https://lore.kernel.org/all/aAvfn2mq0Ksi8DF2@x1/ [1]
> 
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Reviewed-by: Drew Fustini <drew@pdp7.com>
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---
>  arch/riscv/boot/dts/thead/th1520.dtsi | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
> index 1db0054c4e093400e9dbebcee5fcfa5b5cae6e32..f3f5db0201ab8c0306d4d63072a1573431e51893 100644
> --- a/arch/riscv/boot/dts/thead/th1520.dtsi
> +++ b/arch/riscv/boot/dts/thead/th1520.dtsi
> @@ -7,6 +7,7 @@
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/clock/thead,th1520-clk-ap.h>
>  #include <dt-bindings/power/thead,th1520-power.h>
> +#include <dt-bindings/reset/thead,th1520-reset.h>
>  
>  / {
>  	compatible = "thead,th1520";
> @@ -234,6 +235,8 @@ aon: aon {
>  		compatible = "thead,th1520-aon";
>  		mboxes = <&mbox_910t 1>;
>  		mbox-names = "aon";
> +		resets = <&rst TH1520_RESET_ID_GPU_CLKGEN>;
> +		reset-names = "gpu-clkgen";
>  		#power-domain-cells = <1>;
>  	};
>  
> 
> -- 
> 2.34.1
> 

I have applied this patch to thead-dt-for-next [1] as commit cf5e81d [2].

Thanks,
Drew

[1] https://github.com/pdp7/linux/commits/thead-dt-for-next/
[2] https://github.com/pdp7/linux/commit/cf5e81da0ed7f548367a9687ad73956a8dfb54d1

