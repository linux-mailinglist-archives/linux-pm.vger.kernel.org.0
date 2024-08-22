Return-Path: <linux-pm+bounces-12751-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F84995BC21
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 18:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D67D91F26921
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 16:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17341CDA20;
	Thu, 22 Aug 2024 16:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UXoQ8Yfs"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45671D130F;
	Thu, 22 Aug 2024 16:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724344984; cv=none; b=Pfj1SuGzZxprrLQ2eKERHPOniowqbI6IT4NlzvhDi7t8h4cCyQ5EjkvP/E72sDtkKk4BsnxL7OHk8aRKToqMueV+cn5oRLPcbBC55rb4FFrQP//ROJbMgaWUdPNtQS5kfXFny+T7dtI9bT0S0VJroqWSjk/O2etOKupFOlfFiiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724344984; c=relaxed/simple;
	bh=CjdcfSha03gUsdXzKaVNu7Ok/Rz/zO7wQYl59L9ABII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B23NHoEiRk6RQkOqOT4jx05gj7vo/6X9K5R2ylsKXxz/5wkgPQrzjeMyX44o87WdcCHUga8ytIazb32jyam0+jDEe0im/BoPDBL6qSiMv6+so4aBStMdYXNUMgcEQgPlCNMRyCawO6lo6oKU0wUPWGp0PWk1jObzROxhR8LnEPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UXoQ8Yfs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C278EC32782;
	Thu, 22 Aug 2024 16:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724344984;
	bh=CjdcfSha03gUsdXzKaVNu7Ok/Rz/zO7wQYl59L9ABII=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UXoQ8Yfs3CT80lVoiRhul5z9oCS6RuUDcyv8omH1omHh5JsQgAipxUsAHTIY4CpKA
	 QpFuaANfnW70UuyqF3hvLA4mLZ+umOcJOkoVk9l6wl0jddxJT+31Lq0RwThN1wh44+
	 sAX41d3uGWyg1RQP/z4UMH+HlO0D2Mi1cbwx6+9L+QBvuPwc52IqQSh0AAeEabBjrW
	 L07GVExqw6oGub71BTQwDzndDS/vZnEoV4dyTkV9Q3KCAaQP61LHovEQ+hXr2XYeq3
	 JDnOWENKTgeaYif8Jz/GGK45CF3wPZnwK2TTk62zNGI9hJcd1oILbl5wFfGoDMbx5l
	 aYdH8uwKcNRDQ==
Date: Thu, 22 Aug 2024 17:42:57 +0100
From: Conor Dooley <conor@kernel.org>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, p.zabel@pengutronix.de,
	geert+renesas@glider.be, magnus.damm@gmail.com,
	gregkh@linuxfoundation.org, mturquette@baylibre.com,
	sboyd@kernel.org, yoshihiro.shimoda.uh@renesas.com,
	biju.das.jz@bp.renesas.com, ulf.hansson@linaro.org,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH 02/16] dt-bindings: soc: renesas: renesas,rzg2l-sysc: Add
 #reset-cells for RZ/G3S
Message-ID: <20240822-vanilla-enigmatic-f0b05ecca4b6@spud>
References: <20240822152801.602318-1-claudiu.beznea.uj@bp.renesas.com>
 <20240822152801.602318-3-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="R5kWhI8jYXMnqXnv"
Content-Disposition: inline
In-Reply-To: <20240822152801.602318-3-claudiu.beznea.uj@bp.renesas.com>


--R5kWhI8jYXMnqXnv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 06:27:47PM +0300, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> The RZ/G3S System controller has registers to control signals that need
> to be de-asserted/asserted before/after different SoC areas are power
> on/off. This signals are implemented as reset signals. For this document
> the #reset-cells property.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>  .../bindings/soc/renesas/renesas,rzg2l-sysc.yaml | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-=
sysc.yaml b/Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-sys=
c.yaml
> index 4386b2c3fa4d..6b0bb34485d9 100644
> --- a/Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-sysc.ya=
ml
> +++ b/Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-sysc.ya=
ml
> @@ -42,12 +42,28 @@ properties:
>        - const: cm33stbyr_int
>        - const: ca55_deny
> =20
> +  "#reset-cells":
> +    const: 1
> +
>  required:
>    - compatible
>    - reg
> =20
>  additionalProperties: false
> =20
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: renesas,r9a08g045-sysc
> +    then:
> +      required:
> +        - "#reset-cells"

Given this is new required property on an existing platform, I'd expect
some mention of why it used to be okay to not have this but is now
required. Did firmware or a bootloader stage take things out of reset?

> +    else:
> +      properties:
> +        "#reset-cells": false
> +
>  examples:
>    - |
>      #include <dt-bindings/interrupt-controller/arm-gic.h>
> --=20
> 2.39.2
>=20

--R5kWhI8jYXMnqXnv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZsdqkQAKCRB4tDGHoIJi
0i+AAPoDjYo2y6uMTzLRLfoCjkrx4XlkdvzoEZtEObZg6r8d8AEAiMY9x4dGGNYn
rLsR+BgKd4cwAM4fW7FwAGCLjJOHbQI=
=N0Us
-----END PGP SIGNATURE-----

--R5kWhI8jYXMnqXnv--

