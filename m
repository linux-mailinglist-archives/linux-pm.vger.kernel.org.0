Return-Path: <linux-pm+bounces-34692-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5A8B5840F
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 19:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 247681AA70C3
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 17:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B6229BDBA;
	Mon, 15 Sep 2025 17:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jom/24+E"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E935C96;
	Mon, 15 Sep 2025 17:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757958901; cv=none; b=bwEB6b9jwbj8JdpEINrfoHwGSE1K/4BqvgmJ2rMuy6rxWQfJudQxoEwCZF3WJHlCWNcQHd0mfk9N6DXYT4LvAMr4KCvJV5ToyTTBVK0cX/Y+aSq4M1K+xbT4K1h963pSyigwN1QqtCznAetEPx/Iby9xv3xOWZqNdTueALueBvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757958901; c=relaxed/simple;
	bh=p6i1OXOwL1SbFMy6RHcrUa5lkMegakp9xY05tYmaFnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k+7jYXMibeXWe85PU1pKY4XYAb/e+uBrwFLA1BoN/TSsrgJgfPkXVCJ8K9tKdakBvqnoBtCNq06n0WtwiQpVMyRjzh+FxMteHlPNEy5Ov/wJzyJ97fgDPnSckAQEW4uA6X4ACqjxp2Kk/kR4MoXNO3RiVPJvo22PO4xz86PcRlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jom/24+E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 562DAC4CEFB;
	Mon, 15 Sep 2025 17:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757958901;
	bh=p6i1OXOwL1SbFMy6RHcrUa5lkMegakp9xY05tYmaFnw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jom/24+EXhKUrEjPIycsMmgCYhmsBk1/WXxwQDO2r6+KPb+kDjeG8to3CCwvyqU/l
	 oawXXgrHbTKOEYTYjVPgrJyCtjfq21/GjhscZsrXfDM4bMtSvzUQ58kdqXhYkaEspt
	 Ny4iC9WtNufFJwcOxo518A1KT3kEYPnQzFoWgro6feQBLLfWND1LuAI1kIGvm+a0c6
	 E8ycaLMCXRReKt2vOMMGFf5zGJSQan6rrQZbgVIFdzB/4bbbkoLF5+Q6qljSEdny0W
	 jY5W1g7cN/dC0dhPI6/BkqxNRxPX8ESK+8pcBIjCifTi02o98uOSabpw5/AaEozXcx
	 KgMv+VhBYMdYQ==
Date: Mon, 15 Sep 2025 18:54:54 +0100
From: Conor Dooley <conor@kernel.org>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
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
Subject: Re: [PATCH v2 04/10] dt-bindings: mailbox: Add MT8196 GPUEB Mailbox
Message-ID: <20250915-reviving-evasive-8ecd2d760ba8@spud>
References: <20250912-mt8196-gpufreq-v2-0-779a8a3729d9@collabora.com>
 <20250912-mt8196-gpufreq-v2-4-779a8a3729d9@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DOVzGwk1KV7PIqCa"
Content-Disposition: inline
In-Reply-To: <20250912-mt8196-gpufreq-v2-4-779a8a3729d9@collabora.com>


--DOVzGwk1KV7PIqCa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 08:37:03PM +0200, Nicolas Frattaroli wrote:
> The MediaTek MT8196 SoC includes an embedded MCU referred to as "GPUEB",
> acting as glue logic to control power and frequency of the Mali GPU.
> This MCU runs special-purpose firmware for this use, and the main
> application processor communicates with it through a mailbox.
>=20
> Add a binding that describes this mailbox.
>=20
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  .../mailbox/mediatek,mt8196-gpueb-mbox.yaml        | 64 ++++++++++++++++=
++++++
>  1 file changed, 64 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mailbox/mediatek,mt8196-gp=
ueb-mbox.yaml b/Documentation/devicetree/bindings/mailbox/mediatek,mt8196-g=
pueb-mbox.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..56508f406fce88c7c1699aa67=
b57394fc7b1c357
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/mediatek,mt8196-gpueb-mbo=
x.yaml
> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mailbox/mediatek,mt8196-gpueb-mbox.ya=
ml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek MFlexGraphics GPUEB Mailbox Controller
> +
> +maintainers:
> +  - Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mediatek,mt8196-gpueb-mbox
> +
> +  reg:
> +    items:
> +      - description: mailbox data registers
> +      - description: mailbox control registers
> +
> +  reg-names:
> +    items:
> +      - const: data
> +      - const: ctl
> +
> +  clocks:
> +    items:
> +      - description: main clock of the GPUEB MCU
> +
> +  interrupts:
> +    items:
> +      - description: fires when a new message is received
> +
> +  "#mbox-cells":
> +    const: 1
> +    description:
> +      The number of the mailbox channel.
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - clocks
> +  - interrupts
> +  - "#mbox-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/mediatek,mt8196-clock.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    gpueb_mbox: mailbox@4b09fd80 {

drop the label, but otherwise this binding looks okay to me.
Acked-by: Conor Dooley <conor.dooley@microchip.com>

> +        compatible =3D "mediatek,mt8196-gpueb-mbox";
> +        reg =3D <0x4b09fd80 0x280>,
> +              <0x4b170000 0x7c>;
> +        reg-names =3D "data", "ctl";
> +        clocks =3D <&topckgen CLK_TOP_MFG_EB>;
> +        interrupts =3D <GIC_SPI 608 IRQ_TYPE_LEVEL_HIGH 0>;
> +        #mbox-cells =3D <1>;
> +    };
>=20
> --=20
> 2.51.0
>=20

--DOVzGwk1KV7PIqCa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaMhS7gAKCRB4tDGHoIJi
0lYlAP9XouEer/Fwt1f66kXxrg1+AQ0F+bPce66xOHq6v41wAgEA4pG93Zb9AFHi
eAUYrGfpE1XzVi8+aUoob4gbAyOwvw0=
=+tYL
-----END PGP SIGNATURE-----

--DOVzGwk1KV7PIqCa--

