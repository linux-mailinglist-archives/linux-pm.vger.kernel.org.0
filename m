Return-Path: <linux-pm+bounces-34035-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A99DB4671C
	for <lists+linux-pm@lfdr.de>; Sat,  6 Sep 2025 01:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21E4FA45894
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 23:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35E428BA83;
	Fri,  5 Sep 2025 23:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dpcAwemY"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70546274FEF;
	Fri,  5 Sep 2025 23:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757114824; cv=none; b=RydnQh9TYXQOAE5a/L2Ym8sw1m3kRrlMWPsGYdWi3wX3qorBRqTHCxrc+RysI9yRJAqJqnDqW7Iwt/JuqnyWbflL3o0eC9mCBvnl9NWnbI7W7sAtUXLj8L5fmZsIGbJH8e1K4CDfkOSdXoJlyCYGqLgb3A+W+3mquSX0VwV9VHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757114824; c=relaxed/simple;
	bh=+q3cJLW4otQ2y4PEgtHdwQImmYWRyLrAZYTgi0FPf5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WHNzuLnEZBlYSeSrXVrmkHR70yFwatmCPuJIO7Y9J6aVwAPaDvCRiOnrl0cO5bctwnq4SDiQUaobBnl1OAaDZBgJy1OafNKemzpALBKwgl79qwjlSFEpiPi/BYZAhXXl3SFtxVoDdzy/L4BNlnXi7UdDDYvQqXJlX3A7aiuMp0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dpcAwemY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E0DC4CEF1;
	Fri,  5 Sep 2025 23:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757114823;
	bh=+q3cJLW4otQ2y4PEgtHdwQImmYWRyLrAZYTgi0FPf5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dpcAwemYtcEIHan3qBfZZopUwYOEZCyeLdssSnC7MNMQTp3F74FARA0sBcr2GAmvG
	 CJoYl4PAMa9ce4p3o+nVor8SwrFhakyXa4ew02lwPn9wiY4DuLJx5l662TBEpJ/rSd
	 3PshfvcwV8S3h8cZ9/kg2FbPNJYlfyI8pNj+TzzLoYi5sKcUyJWvnCQ4WgIdr0QKVd
	 Ilr90JShPKByhPGI8Y5akagsIHMp85A03mB+t+QoCw2mCiSBwtCvQ3uGpXtAraytX0
	 gU+zlYGLaJXMd807v532Zx2qL4HiUqyT2p7n8st6BRc6Vcdl/fNmy/TzjNdozNqqLw
	 qspoXkHKK/Ikg==
Date: Fri, 5 Sep 2025 18:26:57 -0500
From: Rob Herring <robh@kernel.org>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Jassi Brar <jassisinghbrar@gmail.com>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Chia-I Wu <olvaffe@gmail.com>, Chen-Yu Tsai <wenst@chromium.org>,
	kernel@collabora.com, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH RFC 01/10] dt-bindings: gpu: mali-valhall-csf: add
 mediatek,mt8196-mali variant
Message-ID: <20250905232657.GA1497794-robh@kernel.org>
References: <20250905-mt8196-gpufreq-v1-0-7b6c2d6be221@collabora.com>
 <20250905-mt8196-gpufreq-v1-1-7b6c2d6be221@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905-mt8196-gpufreq-v1-1-7b6c2d6be221@collabora.com>

On Fri, Sep 05, 2025 at 12:22:57PM +0200, Nicolas Frattaroli wrote:
> The Mali-based GPU on the MediaTek MT8196 SoC is shackled to its concept
> of "MFlexGraphics", which in this iteration includes an embedded MCU
> that needs to be poked to power on the GPU, and is in charge of
> controlling all the clocks and regulators.
> 
> In return, it lets us omit the OPP tables from the device tree, as those
> can now be enumerated at runtime from the MCU.
> 
> Add the mediatek,mt8196-mali compatible, and a performance-controller
> property which points to a node representing such setups. It's required
> on mt8196 devices.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  .../bindings/gpu/arm,mali-valhall-csf.yaml         | 36 +++++++++++++++++++++-
>  1 file changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
> index a5b4e00217587c5d1f889094e2fff7b76e6148eb..6df802e900b744d226395c29f8d87fb6d3282d26 100644
> --- a/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
> @@ -19,6 +19,7 @@ properties:
>        - items:
>            - enum:
>                - rockchip,rk3588-mali
> +              - mediatek,mt8196-mali
>            - const: arm,mali-valhall-csf   # Mali Valhall GPU model/revision is fully discoverable
>  
>    reg:
> @@ -53,6 +54,13 @@ properties:
>    opp-table:
>      type: object
>  
> +  performance-controller:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      A phandle of a device that controls this GPU's power and frequency,
> +      if any. If present, this is usually in the form of some specialised
> +      embedded MCU.

We already abuse power-domains binding with both power and performance. 
There's a performance-domain binding too, but only used on one platform 
for CPUs (Mediatek too IIRC). Or perhaps you could just point to an 
empty OPP table. I don't think you have anything new here, so don't 
invent something new.

Rob

