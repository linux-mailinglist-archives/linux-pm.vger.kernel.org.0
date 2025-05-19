Return-Path: <linux-pm+bounces-27356-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 510B8ABC424
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 18:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D63D16E276
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 16:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F95128982E;
	Mon, 19 May 2025 16:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cVPKVYMO"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0149C27A911;
	Mon, 19 May 2025 16:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747671131; cv=none; b=FL5MF+Os5yxizEZ3nAej9ogEcFlViLWIBrRibRYima5H12x9k/31U4gAPZ0Gcn+qb+CX9Hw1xYwQBMzAZYVLqbsd081umYMmvqzs9DlbM4qpciYc2poNTTT6x8hLFW5E6B21rA8ae8AChL2LHtlKy9cmdbbJK7CoYCk5lIP+geA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747671131; c=relaxed/simple;
	bh=l8blh10OK+0hD92twpkqVpb87BrzmAIlQA1EZ50o0tY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hZjQMH3I1r7o2TLl9k+6bSEyK6fKcpyTLgOISMPkKzJzs2Bj1x35wTizweCDLqC6bKZxSuq0HVyUUgWOvBxrhsyvFhx/KkDH8lTbbXsDkxI2RndPOWnwVoVLo8Xh8adDxdGiMOPNL6QVr7gNVq5a5Mw8ID9+08Wcx3zlQwF5JFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cVPKVYMO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15758C4CEE4;
	Mon, 19 May 2025 16:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747671130;
	bh=l8blh10OK+0hD92twpkqVpb87BrzmAIlQA1EZ50o0tY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cVPKVYMOaZToYtTsEcXK/+I3/SDkmwFYojPzngJ2eAO2RTbgmtAm/dOYf4K5Wo3yn
	 chTPeIRFPsUrqdW7d9+U1gYCrmZizHY7aZxfJ9u+VLIs+6zYNfhNJhRE2Jyq8xtBaC
	 VQy20q/fLanGWXNQudCEzGIdNFPoGnEz/70+9K9ZDME9ScztsZaGIxrB4Tjlqw2jqI
	 WdM3WD4sLxE1CorI8dSCEtl5PseH7NrVzr9u7gkJ6D+o/IOJifApCPk3hFPX8pG9rV
	 fY25RptiyzWnEwK3NgBQ8wTft5SCNcDTASNmlTe4SfFUyLNcexs/1EYKxH4Q+WJZBE
	 rOwqS969J8Tig==
Date: Mon, 19 May 2025 17:12:06 +0100
From: Conor Dooley <conor@kernel.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Stuebner <heiko@sntech.de>, Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jisheng Zhang <jszhang@kernel.org>, Yao Zi <ziyao@disroot.org>,
	Chukun Pan <amadeus@jmu.edu.cn>, linux-rockchip@lists.infradead.org,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] dt-bindings: mmc: sdhci-of-dwcmhsc: Allow use of a
 power-domain
Message-ID: <20250519-caress-traps-f61f0c6067b4@spud>
References: <20250518220707.669515-1-jonas@kwiboo.se>
 <20250518220707.669515-6-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rmhup2qVQJ30c1U+"
Content-Disposition: inline
In-Reply-To: <20250518220707.669515-6-jonas@kwiboo.se>


--rmhup2qVQJ30c1U+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 18, 2025 at 10:06:52PM +0000, Jonas Karlman wrote:
> The commit 7e856617a1f3 ("dt-bindings: mmc: Add support for rk3576
> eMMC") limited use of power-domains to Rockchip RK3576.
>=20
> Remove the power-domains: false to allow use of power-domains with more
> controllers, e.g. with SDHCI on Rockchip RK3528.

Meanwhile, you're allowing it for all devices, even ones where it is not
valid. I'm not keen on that.

>=20
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>  Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml | 4 ----
>  1 file changed, 4 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yam=
l b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> index 5fb347167004..f882219a0a26 100644
> --- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> @@ -120,10 +120,6 @@ allOf:
>        required:
>          - power-domains
> =20
> -    else:
> -      properties:
> -        power-domains: false
> -
>  unevaluatedProperties: false
> =20
>  examples:
> --=20
> 2.49.0
>=20

--rmhup2qVQJ30c1U+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaCtYVQAKCRB4tDGHoIJi
0qgBAP4pcRHqb6kp25l2OZfOs5jHIg25eLK9dmxq+YRes/Xm4QD/XFVfUBIq1AX2
fwYWkhhVTFWp1mGRW1ikApzTfF0Zvg4=
=t6Rx
-----END PGP SIGNATURE-----

--rmhup2qVQJ30c1U+--

