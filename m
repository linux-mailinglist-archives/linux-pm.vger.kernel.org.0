Return-Path: <linux-pm+bounces-2675-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 891C683A737
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jan 2024 11:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D046B2AB30
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jan 2024 10:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8C01947D;
	Wed, 24 Jan 2024 10:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="un1te8KA"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B751AADD;
	Wed, 24 Jan 2024 10:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706093465; cv=none; b=XiXBoqrDhKDnOmOTRxnSWV54n2lrw3DKEo1L7QeK/LcGm9jL7P7Co2pjT8I7EsCDoHFIyWZL+N8nMWw8Jiue5ap46+qmEaL2TCZ/lBDc5PFPrsU1YKjNjkSnPBVOaqeP0AfEOxY6dmVOwizDI+X+pS8jSRRGX6yqRQubh+EAk6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706093465; c=relaxed/simple;
	bh=xckjaTai+NIhJdr+U5xK5xm6EEGgFYcEd8Jw5TS/yzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f8jKPlIcxaoKv+gjpFfiZm1x26Uhsh5vV8GEZSN9tY50E6wLdgEXvIZ4W/Tl6W1k+Nb3NmXEo6M1UmocGvdh30+Z9CMeLPePusw/X4L5vV+VvS/QiJu1Enl4s1AHM5mwavDw7KhkBqrylQmbbKV5ebl6zJnngDNS8tiPiJ6lDCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=un1te8KA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D2CBC433F1;
	Wed, 24 Jan 2024 10:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706093464;
	bh=xckjaTai+NIhJdr+U5xK5xm6EEGgFYcEd8Jw5TS/yzU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=un1te8KAgfRdSYeTJpjm0sO+bk65w2EismhVsuPXCagM06zp793UJV2dzG2MRH+8A
	 RWcK3FF5c3eJYDidgQi8UeLO1E5i2BclwrEKmpHJyl0B9BohtwxyWO6XwebQE5M0Hu
	 M3gIeD1mFuC8rJhBgZNLdpqHIN0TABKnk341WWjPizW004mV3MyYM+UcmxIJtHSKTi
	 1JiyTipUNJsBMd5RVCl6i5yzBS4NSm7gSPlt+RisVoYiASHeJTlVBXXS4CfbtbIk7+
	 MjqH6Si5PsREpSCbo4+WnkNsaIHhSqPciBba0POq6GWoy7cYVNwgeXDzx6r+RXs9Qe
	 2iN4DnpB/NlaQ==
Date: Wed, 24 Jan 2024 11:51:01 +0100
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
Subject: Re: [PATCH 12/15] soc: renesas: rcar-rst: Add support for R-Car V4M
Message-ID: <ZbDrlYassvCCk1cE@ninjato>
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
 <1569c749978c3565db6dc013efa41eaa9c688844.1704726960.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Bh7dvcsQb5oS5pjY"
Content-Disposition: inline
In-Reply-To: <1569c749978c3565db6dc013efa41eaa9c688844.1704726960.git.geert+renesas@glider.be>


--Bh7dvcsQb5oS5pjY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 08, 2024 at 04:33:51PM +0100, Geert Uytterhoeven wrote:
> From: Duy Nguyen <duy.nguyen.rh@renesas.com>
>=20
> Add support for the R-Car V4M (R8A779H0) SoC to the R-Car RST driver.
>=20
> Signed-off-by: Duy Nguyen <duy.nguyen.rh@renesas.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

> ---
> Early firmware versions may not enable WDT resets, so you may need to do
> s/rcar_rst_gen4/rcar_rst_v3u/ for testing.

See, how useful this V3U patch has become ;)


--Bh7dvcsQb5oS5pjY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmWw65UACgkQFA3kzBSg
Kba2zQ//ZB3tvNcG9LDcopg/pMJinAheWmIEiU5uQmPAWRpx44URI3MhmvxeV0g2
IVLDk34h5Y1rmrwUyb4RH9U+aLRWHwvJad+HqhP8CAEzlAolOWzyD2mmBeSbq6Ak
aLxdQwUoXZs/a3QUYjVcr+ej4OI2k59+NmyqY5SYXlpoZ0la9Awd+luimE1bIjoi
MXFilS0xwNAAuqV/PMdXq/PtOpdIwRCRu+qJmh2b9saV7nZ4zgo4MA/NSZWE+xqj
1B1/RJKzzhq6jIAjzAoLZvWVF3PJ0/MPnXpzZtHWWshC+NSxuQcW4Qro0k7hnsaj
MP+gE5s9c0Etzj7NZPfQoYubghUfXOtbg5GAdNfrL4yI4ZCCiWV2x/0Gxjte/ok7
aYXwDowg0rbJavBcnj+ESzCnlQlZvsNoqX6qiDRb0M8tztak5OP2mKdMYtRfeAqw
isysxu2nlQsp0+fPdAuugZ5hjVOu5NVQ0sTWjaDqHhmc+JMoKvOYlNsgLhy2+1uP
P9BnmH8EQ/N1P2vzhNx3HyTIbYfVkDdwvoy5ZFWhZVOZEv8/EVtcgelGp3a6UwHJ
6jKiRMBY7ivFUA0G/o4RI2WrQL7I0ghR8xO/gDovbhPDNP9+HQu09WMB4+ICrHEd
2UbyNsXTma1zTmbc4WEBBpWfLor/UUZ0ky2Sjw0d8Abpco93HYg=
=UCdM
-----END PGP SIGNATURE-----

--Bh7dvcsQb5oS5pjY--

