Return-Path: <linux-pm+bounces-2672-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1977283A728
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jan 2024 11:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5C2D28C8E7
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jan 2024 10:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC5D1947D;
	Wed, 24 Jan 2024 10:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cDy3LpDW"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D561AAAE;
	Wed, 24 Jan 2024 10:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706093318; cv=none; b=sDDg5zUMoveOP1/pgwQA+l428DuRFPOkgZAAKryjM5n96v+Cwgrv6AI8WqhuWUp+EV3vK0eyweF4ZMLUDLWL05pjrLP3ju3+MmxjvRfTrmTAQ6zFSpecqvPJgRPapLOYghfFkCABGAlnhrI56oFo9guEmPyfqCxK1a15W+vh48c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706093318; c=relaxed/simple;
	bh=dA9b756dE5TNVjW47hwdr/q7DlseW+eVJMgaVDohXW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tY3tHRrMb3rd5bmuACYMgkZT6yf4ylAEjoTJ1aZ0F8AqCDO/PLEN+4JfAUIfp3qh1qVK2Vh6COUiI91QQl2TOKcjuhfpIoMDFXKWjcjby/qkyZK3aPsKD7lfAUv8Gn4KF51OwDSX2kap3248jdXtzVXJdHweCG+HqAZ5goIq8So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cDy3LpDW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F30BC433F1;
	Wed, 24 Jan 2024 10:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706093317;
	bh=dA9b756dE5TNVjW47hwdr/q7DlseW+eVJMgaVDohXW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cDy3LpDWRfgV1B0QKPekbAdNagB6INtG+2cpfVX24ZdTJaT8sMI0BosJ5rhu/n3Dr
	 /k4rmFcW3HpSgHpIMrF5RylW4CzVyfKfD4JZePTKDwJCwo/FJNm0Lp6I825I4i0Nv7
	 BjP5CKWDRr2kRr8bg+B0gJ/ZlQW3hhRfwGzraaDDCguhjBt/S83FDvFnkTPGjzAThz
	 s9OxGm1wYBvF2VO2GWc7CEdPm2HuVp86jD+EmOkPRLEd04OlOeZAT4B0YJ2X8TDs0m
	 e/dyJ1lQhTrfPNHVL4lsHXYWyC3U7o+rlWF1x/RIXt9wmePN0wCVmCUWyWRHWL2lHr
	 hIsA+FSNwVzAw==
Date: Wed, 24 Jan 2024 11:48:34 +0100
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
Subject: Re: [PATCH 10/15] soc: renesas: Introduce ARCH_RCAR_GEN4
Message-ID: <ZbDrAh0Wp1yxzy9a@ninjato>
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
 <4f4a2dbdb6ba51e151cbdc128da377083b0d850d.1704726960.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0u9aeG4dzSw4b8kX"
Content-Disposition: inline
In-Reply-To: <4f4a2dbdb6ba51e151cbdc128da377083b0d850d.1704726960.git.geert+renesas@glider.be>


--0u9aeG4dzSw4b8kX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 08, 2024 at 04:33:49PM +0100, Geert Uytterhoeven wrote:
> Currently, all Kconfig symbols for R-Car Gen4 SoCs select the
> ARCH_RCAR_GEN3 SoC family symbol, which might confuse the casual reader.
>=20
> Fix this by introducing a new SoC family symbol for R-Car Gen4 SoCs.
> For now this just selects ARCH_RCAR_GEN3, to avoid duplication, and to
> relax dependencies.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

> Once "[PATCH] i2c: rcar: Prepare for the advent of ARCH_RCAR_GEN4"[1]
> has been applied, ARCH_RCAR_GEN4 can stop selecting ARCH_RCAR_GEN3.

Oh, that's me :)

> I'm open for suggestions how to improve this.
> Perhaps factor out common parts into ARCH_RCAR?

I kinda like the situation after this patch. I'd think using ARCH_RCAR
might hurt readability. Also, if Gen5 needs to modify ARCH_RCAR, then we
need to fix up old archs. Potential regressions ahead.


--0u9aeG4dzSw4b8kX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmWw6wIACgkQFA3kzBSg
KbbloBAAs4shQCEFJDBLmp/gsHnCAwRIshO1V1BBOLcLG2SMopji71CDc/gwaBHy
3myWZYE5uDkp41iE1Y5ioygOxhrLyVQ/34cM+TVAWqfOQP7hfcORU/g3RDq0OU7+
AmL1y9o4jCQB+QcKaQygi/Q1VzQsPCtw83MZQpNr8/lsc4M4Sv8IBTqiWRq1mvoX
XhJiKY6rCl+3iZJRTSryUZ9xPlfkejYRc3fTQu4eYIO3yaWF13OrXVmcidwln5Dy
+f9A+wYf3D/vn7vejkdxluccyqhgkvzknOpD3KusM4hvveTjFvpIHMczU4h/nT5M
La6R0DGWC4UgIo4MGCaOXEgAIl1X4HHosK4fPpNB+b5SYLsN/jVH7XVIH+R7wpXY
ogrK87uIh472cLcTfmAcY5gjgYelWaGVZ5zMn1GQ9cM+JwPLoGTTHeAsSrXeBFA9
4+UC+JqP/8QVFWoXCuh6iFY3qtjLfgTFpVfpddEkDmjl8su0tKJIVUKurBfzvGGT
Kw4/Kd6yNZndVkEWGql2gbMTMxQKxTPqipjnlVbFKWFS+Dv+5D/CaaNilzEf2GWB
nsgjeAeHCMZfvEiZ1t143nNLnHo4m7Ii/JCrgZWDzFTyzfaLL+uHHkQIa1Wz+Kth
tPO5lKN1iCSDeaOzxOxg0smIhCYkgXxb1XTaM3RppGT0Barbz4I=
=3zZ/
-----END PGP SIGNATURE-----

--0u9aeG4dzSw4b8kX--

