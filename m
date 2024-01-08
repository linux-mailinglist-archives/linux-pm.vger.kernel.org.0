Return-Path: <linux-pm+bounces-1963-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C68B8276CB
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jan 2024 19:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC5C91F23923
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jan 2024 18:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7400B54780;
	Mon,  8 Jan 2024 17:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMDmRdTf"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5BF55C03;
	Mon,  8 Jan 2024 17:54:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04718C433C8;
	Mon,  8 Jan 2024 17:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704736465;
	bh=H8akq1SElUrdBmNdvj6Imrs/eJEK5RTMuhgHPm3mEe0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EMDmRdTfHqEdybNxER/2rpw1nTHP4SjivCgwHJxSkPAf+NnRdMX0f8vylwCiHrkwK
	 CHJUtwBLbp9uEAj+HNgxZsUcjq7ZB7R284ghCyrPvdb4ntO8L7IIt9Ued/mVtrvfgW
	 aQF2aajkWfPDIX0GIk44VAb4mcIVsTakeRS6T55IEM6TIEnIof3Sxk0g3H2lUcUkfZ
	 6YutlHpqjmd0p4eLe2psk3U/TSCl01DowZlSPYNGKppK3Y6xRo4o2Ren/0e2rZohE+
	 RlVAkrxT/DJXMiZ9n6D0w/b4c8YEKkCOG8katbETW7JRWh/oCqxiUOlgRy11VvBkIy
	 Nt4pubSRoPTYA==
Date: Mon, 8 Jan 2024 17:54:19 +0000
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
Subject: Re: [PATCH 06/15] dt-bindings: soc: renesas: Document R-Car V4M Gray
 Hawk Single
Message-ID: <20240108-parka-wagon-5a2ef57599c9@spud>
References: <cover.1704726960.git.geert+renesas@glider.be>
 <3b1baf0eaf9f483308a6df1340dae51d4b88a337.1704726960.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DNpDcsDGXpd6taFv"
Content-Disposition: inline
In-Reply-To: <3b1baf0eaf9f483308a6df1340dae51d4b88a337.1704726960.git.geert+renesas@glider.be>


--DNpDcsDGXpd6taFv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 08, 2024 at 04:33:45PM +0100, Geert Uytterhoeven wrote:
> Document the compatible values for the Renesas R-Car V4M (R8A779H0) SoC
> and the Renesas Gray Hawk Single development board.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
> The Gray Hawk Single board is an integrated variant of the (not yet
> supported) Gray Hawk board stack, which is very similar to the White
> Hawk board stack.
>=20
> The schematics call it '"Gray Hawk"(1Board)'.
> The Setup Manual calls it 'Gray Hawk Single Board'.
>=20
> Alternative naming candidates would be 'Gray Hawk S' and/or
> 'renesas,gray-hawk-s'.
> ---
>  Documentation/devicetree/bindings/soc/renesas/renesas.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/soc/renesas/renesas.yaml b=
/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
> index 16ca3ff7b1aea146..1c8f5122bccdb5c8 100644
> --- a/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
> +++ b/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
> @@ -354,6 +354,12 @@ properties:
>            - const: renesas,white-hawk-cpu
>            - const: renesas,r8a779g0
> =20
> +      - description: R-Car V4M (R8A779H0)
> +        items:
> +          - enum:
> +              - renesas,gray-hawk-single # Gray Hawk Single (RTP8A779H0A=
SKB0F10S)
> +          - const: renesas,r8a779h0
> +
>        - description: R-Car H3e (R8A779M0)
>          items:
>            - enum:
> --=20
> 2.34.1
>=20

--DNpDcsDGXpd6taFv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZZw2ywAKCRB4tDGHoIJi
0g4lAP9EeNAWIC9UvvddnzTFvZt54hIHj2qeMfuXTKj/lsKqbgD8CkgXxShQd1A7
uO/RYoOCYddkw0Viwj/oolfyNDm/QAA=
=eDue
-----END PGP SIGNATURE-----

--DNpDcsDGXpd6taFv--

