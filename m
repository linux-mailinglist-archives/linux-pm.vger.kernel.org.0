Return-Path: <linux-pm+bounces-31416-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B97FFB118BE
	for <lists+linux-pm@lfdr.de>; Fri, 25 Jul 2025 08:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F027454691D
	for <lists+linux-pm@lfdr.de>; Fri, 25 Jul 2025 06:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23579289E0B;
	Fri, 25 Jul 2025 06:59:25 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014E21096F;
	Fri, 25 Jul 2025 06:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753426765; cv=none; b=nyLTjamkTPCpVTJycFgvK+cCQqbMQJOoeJrk7rliEOS1sKfGzaKJ5esyWOwFfv7RzdQBNhCLMxYj8NSfluKgr5QeVksY21C8T7TOSqCR7mxPDILYmmdb2iAp2aDz+FM1iAhNBj4iOvmSLmn1DqaN9AFSlaK18hIOGqKz6jtT0BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753426765; c=relaxed/simple;
	bh=xBDeOPeKaVA7rwGNxmHPNH2SOW6pZyMRKqU/vbkDMtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nhyinhlB4LTeYDgA5kEXn2ldOOIO1n6AD0pQD/xteTud3i3PPKGJ/KPrZ/4KerGUlVw8U/5kKOxd7xvyvp60Vnbrn7YVwq1WsfKp9Jl7QI6ZItwPFPUsIq2tbmUJi49uaiY/wjk+NdQEMIC5rOYXcFMwWrXPs6PYY/xfuuDsBVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA7BCC4CEE7;
	Fri, 25 Jul 2025 06:59:23 +0000 (UTC)
Date: Fri, 25 Jul 2025 08:59:22 +0200
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Frank Binns <frank.binns@imgtec.com>, 
	Matt Coster <matt.coster@imgtec.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Drew Fustini <fustini@kernel.org>, linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v8 2/4] dt-bindings: gpu: img,powervr-rogue: Add TH1520
 GPU compatible
Message-ID: <20250725-gainful-saluki-of-mathematics-3c0dd0@kuoka>
References: <20250724-apr_14_for_sending-v8-0-0714bef83c59@samsung.com>
 <CGME20250724141911eucas1p17071ea620f183faff7ca00cad25cf824@eucas1p1.samsung.com>
 <20250724-apr_14_for_sending-v8-2-0714bef83c59@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250724-apr_14_for_sending-v8-2-0714bef83c59@samsung.com>

On Thu, Jul 24, 2025 at 04:18:59PM +0200, Michal Wilczynski wrote:
> Update the img,powervr-rogue.yaml to include the T-HEAD TH1520 SoC's
> specific GPU compatible string.
> 
> The thead,th1520-gpu compatible, along with its full chain
> img,img-bxm-4-64, and img,img-rogue, is added to the
> list of recognized GPU types.
> 
> While the BXM-4-64 GPU IP is designed with two distinct power domains,
> the TH1520 SoC integrates it with only a single, unified power gate that
> is controllable by the kernel.
> 
> To model this reality correctly while keeping the binding accurate for
> other devices, add conditional constraints to the `allOf` section:
>  - An if block for thead,th1520-gpu enforces a maximum of one
>    power domain and disallows the power-domain-names property.

Why?

This solves nothing, because you did not change the meaning of power
domain entry.

>  - A separate if block applies to other B-series GPUs
>    img,img-bxm-4-64 and img,img-bxs-4-64. A not clause within this
>    block excludes the thead,th1520-gpu compatible, ensuring this rule
>    requires a minimum of two power domains only for non TH1520 B-series
>    GPU's.
> 
> This makes the binding strict and correct for both the specific TH1520
> implementation and for other SoCs that use the B-series Rogue GPUs.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---
>  .../devicetree/bindings/gpu/img,powervr-rogue.yaml | 32 +++++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> index 4450e2e73b3ccf74d29f0e31e2e6687d7cbe5d65..2c5c278b730145a983d1ddfa4014b3c5046bcd52 100644
> --- a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> +++ b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> @@ -21,6 +21,11 @@ properties:
>            # work with newer dts.
>            - const: img,img-axe
>            - const: img,img-rogue
> +      - items:
> +          - enum:
> +              - thead,th1520-gpu
> +          - const: img,img-bxm-4-64
> +          - const: img,img-rogue
>        - items:
>            - enum:
>                - ti,j721s2-gpu
> @@ -84,11 +89,29 @@ allOf:
>          compatible:
>            contains:
>              const: img,img-rogue
> +      not:

Previous patch was completely different!

You cannot keep tags when you completely rewrite the patch. Drop all
reviews and all acks.

Above code is confusing and not correct, you just stuffed multiple if
causes.

Best regards,
Krzysztof


