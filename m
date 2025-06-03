Return-Path: <linux-pm+bounces-28017-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30715ACC77A
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 15:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04AE3170E55
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 13:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E1572617;
	Tue,  3 Jun 2025 13:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eqF5A5mX"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540B73FB1B;
	Tue,  3 Jun 2025 13:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748956580; cv=none; b=VF6k22GVOyVD6/zpk4GT/aoWmsD+87u4b2icIu//oXgx4EVhetSX/L9yDWBEFgdp5nF/ESfVet7CRV+T1Rjc0/Vn79U4godUwJGKe4svDyfV2B4vvS7rDXOgaWQeBNgT0aySjvbE82LQoCT6Lr5JGTM02cnw9UprOEn1Z3dtMcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748956580; c=relaxed/simple;
	bh=nstVo8eSXrU+/4uZGunLaKdaHwxK+tYzrOakrG9UyJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y+giXomAI89qPNr4XvrIk5ZBY339xEkCSA/ZWnEdMjZUbtA12yKGyyhF1YJ3YtaldRmagDYarRSwyQTuW2WBQ0kCI2giMh+NNzMrcGKuV0rff7IDPYxOs8ko6f9+ok3oZ4vf28zgPgq9HqP52rHC8VoLQpmtojJJTv7S0wJ7LMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eqF5A5mX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42B93C4CEED;
	Tue,  3 Jun 2025 13:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748956576;
	bh=nstVo8eSXrU+/4uZGunLaKdaHwxK+tYzrOakrG9UyJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eqF5A5mXEgvowYk9pJ3rD7fX2QllYIVcA2u/tvhbO5/LHLZHII9snpzvmQeV00pAG
	 gcuMnDuvpWuWVNLNODRTP43dWcpQ+Ly13FwHtEcRaEfT/sFF3aZjKm3BiuEgWr7obe
	 rdXcRF+siS9fxgA7XEQAESFyFBBVS38IzwUjtRMK8yzBgSEI10Mk2G7tCGfaprPe3y
	 JnoaRsuV8a244UTag7slrbnuS1zyGnWGpwrNqJt37DpuPFzxh34yKcAqZcaiyYh8ls
	 HF69WN1BNycfIhoRFc8Kw5Y+hxGBsguSO1O4apT6Ii1+PGx1ecT0p2qzlNqtcf4nO9
	 S/bZVYIrhl9mQ==
Date: Tue, 3 Jun 2025 15:16:06 +0200
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
Subject: Re: [PATCH v3 4/8] dt-bindings: gpu: Add TH1520 GPU compatible to
 Imagination bindings
Message-ID: <20250603-sparkling-cryptic-pony-218cf0@kuoka>
References: <20250530-apr_14_for_sending-v3-0-83d5744d997c@samsung.com>
 <CGME20250529222406eucas1p117082ce4f06921f71bbc442c47e58574@eucas1p1.samsung.com>
 <20250530-apr_14_for_sending-v3-4-83d5744d997c@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250530-apr_14_for_sending-v3-4-83d5744d997c@samsung.com>

On Fri, May 30, 2025 at 12:23:51AM GMT, Michal Wilczynski wrote:
> Update the img,powervr-rogue.yaml device tree bindings to include the
> T-HEAD TH1520 SoC's specific GPU compatible string.
> 
> The thead,th1520-gpu compatible, along with its full chain
> img,img-bxm-4-64, and img,img-rogue, is added to the
> list of recognized GPU types. This allows the Imagination DRM driver
> to correctly bind to the GPU node defined in the TH1520 device tree.

If there is going to be any new version:

Last sentence feels redundant or obvious. That's the point of DT anyway,
so not need to state that. I suggest dropping it or replacing with some
hardware description.

A nit, subject: drop second/last, redundant "to Imagination bindings". The
"dt-bindings" prefix is already stating that these are bindings.
See also:
https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18
Use proper prefix, so:
dt-bindings: gpu: img,powervr-rogue: Add foo bar

> 
> The power-domains property requirement for img,img-bxm-4-64 is also
> ensured by adding it to the relevant allOf condition.
> 
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---
>  Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> index 4450e2e73b3ccf74d29f0e31e2e6687d7cbe5d65..c12837a0d39b8c3043b9133d444cc33a59135c33 100644
> --- a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> +++ b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> @@ -26,6 +26,11 @@ properties:
>                - ti,j721s2-gpu
>            - const: img,img-bxs-4-64
>            - const: img,img-rogue
> +      - items:
> +          - enum:
> +              - thead,th1520-gpu
> +          - const: img,img-bxm-4-64

We keep ordering by fallbacks, so this should go above items with
img,img-bxs-4-64 fallback (m < s).

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


