Return-Path: <linux-pm+bounces-2667-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8265D83A6E8
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jan 2024 11:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11F741F22140
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jan 2024 10:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6D5DF5D;
	Wed, 24 Jan 2024 10:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pIm0wVRf"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDC7D30E;
	Wed, 24 Jan 2024 10:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706092545; cv=none; b=V53FAxc6wgE9KEh43W1gIVFCtYrZgPa13BEmqZv6cayAPbyngAfCrlsC29IsOSRJ7GCCfobuZii/G7ky+2P5zVWCv3V6R3ukqI6JAyIi6tia1lRZBjuXflJSz1YwplvRMtmq6nI0v9nZsdBdMD3qq0kSjsfsKsCg8YPRW1V53yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706092545; c=relaxed/simple;
	bh=F3X6YWhEFf4xbEdg6wHb6lp/B6CwbaKQQ2rX8+R1BqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e4fHGmCQ6Bk2f2NoSY7fhZxrju0J2zLNErz9hxRvh9QSH/85ttO365lqXIHH1cQz2UYIaZiy6v+JndnchCMq3RIUOzHkbS7jWKxnpt1xm5EQO/FVHJ/UfG43p9gXM8yzDbCCvA6EOIdQuRQQmuEeQxjjO3c4wZQTQvnD7MAYHs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pIm0wVRf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 653C2C433F1;
	Wed, 24 Jan 2024 10:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706092545;
	bh=F3X6YWhEFf4xbEdg6wHb6lp/B6CwbaKQQ2rX8+R1BqY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pIm0wVRf194CFwnFa8FFkIEoxUxVTH89MLt0FSnX8ilNa1w3On1D6Ln6I6qKOZpVo
	 wdiJcJW/V2YsMuasW/ob0p7d7/wmbxdmInPV/lcV23lIyK+eqBVCL6sKGF7+dcchjc
	 mr6j2lQHNN1XUvK5e9Ro8fNClhRH5bI029b9nHHG/fNMuumjBo5wECM38dw4u8bhwG
	 a1cgNHTPijovh8J1RHEOp7ZE/q5fpqB5rZs8z/ft2LhssQs7ZPT/R1D2uy1EDZ6f+X
	 5wd1bBBX5LLTVckaM1wUShykK4QPmUv+sCGUhBY/Tk2EVsGBwMpFGnZF1d9d/SWjSq
	 f4eSYjEnSOMXQ==
Date: Wed, 24 Jan 2024 11:35:41 +0100
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
Subject: Re: [PATCH 05/15] dt-bindings: reset: renesas,rst: Document R-Car
 V4M support
Message-ID: <ZbDn_Xp38N7q8yqJ@ninjato>
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
 <1d35a435db17a240abafb091751255379825b750.1704726960.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HaIQShsb65ucNv1z"
Content-Disposition: inline
In-Reply-To: <1d35a435db17a240abafb091751255379825b750.1704726960.git.geert+renesas@glider.be>


--HaIQShsb65ucNv1z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 08, 2024 at 04:33:44PM +0100, Geert Uytterhoeven wrote:
> Document support for the Reset (RST) module in the Renesas R-Car V4M
> (R8A779H0) SoC.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--HaIQShsb65ucNv1z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmWw5/0ACgkQFA3kzBSg
KbYdig//ZmpqtbvpTpIZh4beHwATQUQXNbR+DXYAjqvd34RtXC9xb3Z+t3CGHFhw
0hVI93wpA/qlQOuqnrw/rEIrqQgPlMneo/TyyzXWgcQPfBvqGwbwJTOS8P2zlccL
OLzkoLtSRxcpXNBQi4eLKYeN7HIzWZhNQSgwG8IoK8RDDs/XJdaGRyWQ6tfSi/Vm
bnwD63xhHgwd4AAFWiOOTWUT3pmLlDq2eralaEuyF1bVVuf3R3fLrnZuD5kw/LAW
V/ic2Plj98AKJXIhe12pyHMmTg/rFe3AlmwgLPclBbMz9ey6i0+F5DqULK69mX5I
z/GkdirOw/vjWdQQ7SrvQ2M1PZ/MtfIWXvcCxMSpZflHBPJChGeAkbHkaNac+vsi
oi/S5gvmFT04ixzErvgUQDL/wG2iX539FpqkqSzjF4ERkJR70QR7priiYeVTOiY/
a0dFOcU3H2xsQWiXeLZLJQseFxvzgA770mxfmw2H30+dZzikZRMjKWOPIdGuRAOi
1VkIXO6gP60qgOO/QMhkCnVoM2BX1GnenpBtPuHJB/63oQso0tpKmHcn/MM1Nab9
FRYxvV5LXhwy0xYqqGAbnk9ZKaoO+TgYdE2hTmNSv9DtEi5wEZnMjDrVqJ2Bb8Ee
IRKHC9jYR5dB6jlsKPnVXrO8NQxpKjIqOm4hf8Dz1KLWtJYZKXg=
=gyY+
-----END PGP SIGNATURE-----

--HaIQShsb65ucNv1z--

