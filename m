Return-Path: <linux-pm+bounces-2669-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7912F83A6F4
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jan 2024 11:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31A9228E0D6
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jan 2024 10:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2471078B;
	Wed, 24 Jan 2024 10:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jRypwR5O"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8396FC03;
	Wed, 24 Jan 2024 10:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706092726; cv=none; b=WCrMYAkFlRTfdBsBYVdA0W3iIQU6zDC7mx9x8W9x0OtZZQfXNlDQ1mELaD3ytcPfBPz0Aq19me6W/Y1pvTRRq7+uDqsq+2gNbH61DEcTctviDuZGGaIWZQIwOjOI9BIHg2iHeCp7bglId1OqYD5i6gnlBTH+P9HBVvsz5DFrm3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706092726; c=relaxed/simple;
	bh=saTkleaf8oytgZDqX8SpsOCL1wm7Cjo1wbtwXQO16Qw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ia49PkljN8qMrppTHGbk5i1q0epWuxpW1j4dY7DzxKcJWclRVLnw93PvTnBdjsHU7EFY1uxEDr+WTiga1TweQycyC1OSu0UNpkTsKnhT3zRmvs6oWDktHQhBYvzAOzOY7TCW/gxPXl80FScj0Vq4l5XgWoov04QTka+mzAGCAUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jRypwR5O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD07C433C7;
	Wed, 24 Jan 2024 10:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706092726;
	bh=saTkleaf8oytgZDqX8SpsOCL1wm7Cjo1wbtwXQO16Qw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jRypwR5OpCAkxn0r3eB6fkVg3u9cOI/1tn1FeJRPP1aLkCnWmWxFYO2nnVkb5b7GI
	 TPT0/T6qovie0fs2dFCOpNonDAuEEFwzxuB4FfCRd58cEQj6i8rIA0vYNtIDrqxAdl
	 EsT+dPJlawp9RN/WVp7rbnu0cViv/chNleJhtdxtLBM7pcHPUQ7Oo+h6mD5C2m129q
	 xmiSCEcbBqKn08lACc5y3wBDlGiAvI9ePa1HcITouFk6apNnKe1GgqhySxPfgwN+xH
	 lPsjprpvt4kaKqZUQBEoeOMwpLhMJFoRnrrekiWoczZM+Nu0I+//JeCWeajihGe3SM
	 iBgPmCDVEVImA==
Date: Wed, 24 Jan 2024 11:38:42 +0100
From: Wolfram Sang <wsa@kernel.org>
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
Message-ID: <ZbDosqS750KRSxhJ@ninjato>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Michael Turquette <mturquette@baylibre.com>,
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
References: <cover.1704726960.git.geert+renesas@glider.be>
 <3b1baf0eaf9f483308a6df1340dae51d4b88a337.1704726960.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4tw3XRrLsLe4wYKL"
Content-Disposition: inline
In-Reply-To: <3b1baf0eaf9f483308a6df1340dae51d4b88a337.1704726960.git.geert+renesas@glider.be>


--4tw3XRrLsLe4wYKL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 08, 2024 at 04:33:45PM +0100, Geert Uytterhoeven wrote:
> Document the compatible values for the Renesas R-Car V4M (R8A779H0) SoC
> and the Renesas Gray Hawk Single development board.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
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

I like this current version with the explicit and easy to understand
naming.

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--4tw3XRrLsLe4wYKL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmWw6K4ACgkQFA3kzBSg
KbYB8hAApaat9XchSuUJroJIs0JLwFxa6u3QiGhwzRwrNo8VAW5n/UxteJa4JCzR
YyR+X8a1qKTYnVOs30ZYbUfY81ndg/aNVy59PQ6pwyyi/9S0sl7WsHsn2a8EfAIL
NHzK5fOepk+eHCPueHB6JYiyFUt/YGxLISJ1AyeV39N/AxB4pvlnLlIzOcq4eLMd
usPx9BVyYTh7/G+samDjiX3Xli9bQZ9MuofmmBHkiOnmm0E4jei8K5jVbCak/4s5
7C21vaxZkIbgM8GmWFnecMGJ4Zatkh1LHYoiFO8/DBmfX2DcxA23tImhnhPS/SB5
JkNV3Iuw/gIh0HZr8nxfzgIzG2NI6gXNVeE4pt7pOIskUQjkc27/qSFp/SzjYusl
SaQz87DGeYCUy9wUOaxpXcjpn/O1U5t67fvvdpxF0aFFXi7nJALcnttyW3+CNoYh
HrPnYtel0nnB1v5Bu1F6MaPGoQn3dXQ5GPHun2zWuxLMk4xHoaLnZYA12os1aGJf
uy6EJkmjFTfZ8d18+kX1xNxAHziCpEk5TXyBJMMQofiNraANrxRP5KD7VR/sUFWa
a/PN0FlBDQWMUK4YVFeZOe2/G8yCipCuut3ZmiyJ1Y2nh8dkDr/j9+hJqMDAgLkZ
2j1njizPAvQArynSLfaOtzDJ8UV1qBXyuWL2PoXhCxgPSTffwaQ=
=7Fcc
-----END PGP SIGNATURE-----

--4tw3XRrLsLe4wYKL--

