Return-Path: <linux-pm+bounces-1964-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C10D8276D5
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jan 2024 19:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C31241F225C7
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jan 2024 18:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E1A55C34;
	Mon,  8 Jan 2024 17:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/dvYL7S"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE8C55C1E;
	Mon,  8 Jan 2024 17:55:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9DD1C433C8;
	Mon,  8 Jan 2024 17:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704736544;
	bh=HDP6rRhGxi6xhGnX+lSse2qVxTNBBilN+fXoebQ3S8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q/dvYL7SRXM4imkXpicm7aHr9VY12wdTXu4gueoeNshWKNMfsCGjUxKBeKSzrT7v7
	 yrtyLTDfPikgrKLh4Gx/uwBNDkQxssztpZ2E6MM/wPYBjUi9lcXBESebBuXGxPpS8K
	 387AXnz3RFjAPCySHsk+/siGIPEwMVCk3EoOuMbf3lLVWrdYu681qzRnAo74QFc8dC
	 Dy6gNX4TZMjqZNRQ3wh6PMnA42BKaK6Z9SEUMT8adA8ZXOMQcoRAIJS5a9qav/3FE6
	 kSfrJf8ayKd+rchTpTA/HTa7b4FD+0OdMI1H9Ofkx/cCvHerJRLQrkrooP29ri4N+E
	 xdUSI5q7PrjoA==
Date: Mon, 8 Jan 2024 17:55:38 +0000
From: Conor Dooley <conor@kernel.org>
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
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 05/15] dt-bindings: reset: renesas,rst: Document R-Car
 V4M support
Message-ID: <20240108-reacquire-earthen-19a1c4f63180@spud>
References: <cover.1704726960.git.geert+renesas@glider.be>
 <1d35a435db17a240abafb091751255379825b750.1704726960.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TUmSeLXRkl9US7lp"
Content-Disposition: inline
In-Reply-To: <1d35a435db17a240abafb091751255379825b750.1704726960.git.geert+renesas@glider.be>


--TUmSeLXRkl9US7lp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 08, 2024 at 04:33:44PM +0100, Geert Uytterhoeven wrote:
> Document support for the Reset (RST) module in the Renesas R-Car V4M
> (R8A779H0) SoC.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  Documentation/devicetree/bindings/reset/renesas,rst.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/reset/renesas,rst.yaml b/D=
ocumentation/devicetree/bindings/reset/renesas,rst.yaml
> index e7e4872477517b2d..58b4a45d338006ff 100644
> --- a/Documentation/devicetree/bindings/reset/renesas,rst.yaml
> +++ b/Documentation/devicetree/bindings/reset/renesas,rst.yaml
> @@ -50,6 +50,7 @@ properties:
>        - renesas,r8a779a0-rst      # R-Car V3U
>        - renesas,r8a779f0-rst      # R-Car S4-8
>        - renesas,r8a779g0-rst      # R-Car V4H
> +      - renesas,r8a779h0-rst      # R-Car V4M
> =20
>    reg:
>      maxItems: 1
> --=20
> 2.34.1
>=20
>=20

--TUmSeLXRkl9US7lp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZZw3GgAKCRB4tDGHoIJi
0uenAP9ST27Xd6yq+oBjFQ/QOIkcPcrP27vSstQdXwrN6RUQWAD/aoMFee33F/Z8
iG0nwRT871PDyEFdvso8SPwPeHomsQg=
=CVkK
-----END PGP SIGNATURE-----

--TUmSeLXRkl9US7lp--

