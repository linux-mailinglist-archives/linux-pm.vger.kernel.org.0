Return-Path: <linux-pm+bounces-34933-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E31B825FA
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 02:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E015F1C2171E
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 00:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F05D1F1921;
	Thu, 18 Sep 2025 00:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VCS0KNB3"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BFC1E231E;
	Thu, 18 Sep 2025 00:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758155411; cv=none; b=cb3jJTmUinUPdUUYsSiP0MJU9RXtGe8awrpTrhhe9J/LKeHU5Q31fv9wduyNiyEWQzqkvxDzbA0Lv6+TtNUmH4T5bZibKTh3CzGPFOJFnqxJDc4YxGNAU9RZPEx6av/8+pjHdPh7TsyJD+WeJWVG6T2W1t1/252KHNyVemFqMnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758155411; c=relaxed/simple;
	bh=hqiBjDTMNtIZK2c3OUTgcHqbJVWmnljVpG2n/f/ZTiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mDVbBw7EshtHA6E9i3XYEsoXAR1cImyw6M1BSUK1WvtoDxkL5O5Z5pVCXqH6iFG9avHOAYGkOCGeR6e4PnWloXeIkkbhNE1AVK06gGb9jf/6yVXEE/kv1U2wRl9ch58F3KVD9OfeM3QpI682Ma4+bLZwTv3mu2KfORcogKn1KBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VCS0KNB3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83380C4CEE7;
	Thu, 18 Sep 2025 00:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758155410;
	bh=hqiBjDTMNtIZK2c3OUTgcHqbJVWmnljVpG2n/f/ZTiw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VCS0KNB3JWofqsgTN9Fg9b/3eTr0cJ7H3mJrjAJOl6uSnj4je1myzQ7Li018BoJEb
	 N4xB82npcp7YCNnumNB4vo0ENuelxgjruP6jwc7nGt5iSTrBfaK9DhodP1pt/LrM9P
	 6lBcn1GtEmqwQ6sHL4T0sRtoJg1pAhKNCY7JO8PcXT6CgOJmm2ZkISOTIwZDRKaRGS
	 5XmPm4HU7t/r/JWe8QlhypHdRNQsxmllbCFPIR2qOeG/big3wIyeyxCQEMT2Se9CZP
	 YQgNIGZQNLj665FfU3Xl6g8qGTYkqCyRIErGc7rjC+Xz1zEWyPERcXYnT5dhObBoTL
	 2sysuT046nHIg==
Date: Thu, 18 Sep 2025 09:30:09 +0900
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Boris Brezillon <boris.brezillon@collabora.com>, Steven Price <steven.price@arm.com>, 
	Liviu Dudau <liviu.dudau@arm.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Jassi Brar <jassisinghbrar@gmail.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Chia-I Wu <olvaffe@gmail.com>, Chen-Yu Tsai <wenst@chromium.org>, 
	kernel@collabora.com, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 01/10] dt-bindings: gpu: mali-valhall-csf: add
 mediatek,mt8196-mali variant
Message-ID: <20250918-festive-chowchow-of-joy-5a51de@kuoka>
References: <20250917-mt8196-gpufreq-v3-0-c4ede4b4399e@collabora.com>
 <20250917-mt8196-gpufreq-v3-1-c4ede4b4399e@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250917-mt8196-gpufreq-v3-1-c4ede4b4399e@collabora.com>

On Wed, Sep 17, 2025 at 02:22:32PM +0200, Nicolas Frattaroli wrote:
> The Mali-based GPU on the MediaTek MT8196 SoC uses a separate MCU to
> control the power and frequency of the GPU.
> 
> It lets us omit the OPP tables from the device tree, as those can now be
> enumerated at runtime from the MCU. It also means the mali GPU node
> described in this binding does not have any clocks in this case, as all
> clock control is delegated to the MCU.
> 
> Add the mediatek,mt8196-mali compatible, and a performance-domains
> property which points to the MCU's device tree node in this case. It's
> required on mt8196 devices.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  .../bindings/gpu/arm,mali-valhall-csf.yaml         | 32 ++++++++++++++++++++--
>  1 file changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
> index 7ad5a3ffc5f5c753322eda9e74cc65de89d11c73..ccab2dd0ea852187e3ab75923e19739622b2b3b8 100644
> --- a/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
> @@ -38,7 +38,6 @@ properties:
>        - const: gpu
>  
>    clocks:
> -    minItems: 1

I don't understand why.

Best regards,
Krzysztof


