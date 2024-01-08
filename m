Return-Path: <linux-pm+bounces-1962-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C548276C6
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jan 2024 18:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D79B1C20FC2
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jan 2024 17:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CAB254BD2;
	Mon,  8 Jan 2024 17:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/JpMxLB"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FEE55C09;
	Mon,  8 Jan 2024 17:53:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 309D6C433C7;
	Mon,  8 Jan 2024 17:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704736404;
	bh=p9o0WUrxvm4o8d5MtPSblCJUPK5xVGBjrqrTBR+OpRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N/JpMxLBd/3Bo2p4x9X6xpx4XIjmx+FYbz5UjwjOqDEG6x29ARvTtwqHJG/GDpLA/
	 ZVgJP2ftdCtqQzSxdSigMbDGnRqXxC7vdX2yjGEEcalIYcWCvhuMgwJh6rRDnIqVeV
	 ovNPAt5Mm0A78ccy7pq4TzRPzM5zDDP+bNOyYOokH9vMgUgc9qNc5LHkkkj2kKZkjz
	 +1pDvH8F/ho6GCE4/hfxDxuoaziLuSlF9uSgMyPg+t76eY/AwiFDgpwsxKrZ/Rp5RB
	 BkKwAXY+TuqsWtB0qTH+3y7BSDH2smO5/nm79xtHd2jNS2jqomGhqN8oltHUmvPyYS
	 0eYSa5QpETu3w==
Date: Mon, 8 Jan 2024 17:53:17 +0000
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
Subject: Re: [PATCH 03/15] dt-bindings: power: renesas,rcar-sysc: Document
 R-Car V4M support
Message-ID: <20240108-usual-opacity-4257f2e55107@spud>
References: <cover.1704726960.git.geert+renesas@glider.be>
 <1196419f3ade9a27b3c7906b6a898376b817601d.1704726960.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RWZRcfsMNb349y0C"
Content-Disposition: inline
In-Reply-To: <1196419f3ade9a27b3c7906b6a898376b817601d.1704726960.git.geert+renesas@glider.be>


--RWZRcfsMNb349y0C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 08, 2024 at 04:33:42PM +0100, Geert Uytterhoeven wrote:
> From: Duy Nguyen <duy.nguyen.rh@renesas.com>
>=20
> Document support for the System Controller (SYSC) in the R-Car V4M
> (R8A779H0) SoC.
>=20
> Signed-off-by: Duy Nguyen <duy.nguyen.rh@renesas.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  Documentation/devicetree/bindings/power/renesas,rcar-sysc.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/power/renesas,rcar-sysc.ya=
ml b/Documentation/devicetree/bindings/power/renesas,rcar-sysc.yaml
> index 0720b54881c2c87a..e76fb273490ff588 100644
> --- a/Documentation/devicetree/bindings/power/renesas,rcar-sysc.yaml
> +++ b/Documentation/devicetree/bindings/power/renesas,rcar-sysc.yaml
> @@ -45,6 +45,7 @@ properties:
>        - renesas,r8a779a0-sysc # R-Car V3U
>        - renesas,r8a779f0-sysc # R-Car S4-8
>        - renesas,r8a779g0-sysc # R-Car V4H
> +      - renesas,r8a779h0-sysc # R-Car V4M

I like that the g0 is the v4h and the h0 is a v4m. Makes complete sense
to me!

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--RWZRcfsMNb349y0C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZZw2jQAKCRB4tDGHoIJi
0i5SAP994XukMstFRmWth8ENiuS2ZXUKJVXh7kOF0FqbJ3wwwgEAxomMxE7iqPxU
MzZCVWEBDBrcLTtHR3Zdk2IXtnT5Hgw=
=Jner
-----END PGP SIGNATURE-----

--RWZRcfsMNb349y0C--

