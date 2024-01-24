Return-Path: <linux-pm+bounces-2665-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8D583A6E1
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jan 2024 11:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A44E1B22DF2
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jan 2024 10:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7DA63B7;
	Wed, 24 Jan 2024 10:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0KB+q/6"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C24F9C8;
	Wed, 24 Jan 2024 10:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706092438; cv=none; b=fPOZEhoVuRSpCfdMtW8APCw03h0EsR2VA1TSR31esL7GVTq69va8jtPh8jnFXN6vgj2IBhLt8ZxkLE6P3ImBfffo5UdGqNmubi/JL3EX1kztIi7A50OV/koO31EYSWX10gnio7AToRSdrFRBUsXou5Mz/T5JLTebHtvOjkyyshc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706092438; c=relaxed/simple;
	bh=nmVHfsslJlEa808CDBRVtTpeFNG8yq9r7mh8I2w4JCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WsJhaPg7J66WDt4yurIyRfJM6hTJJ7z9MMiIg8J0gpdxTWWeySU8c5OyKDPIgQDvneTqwcQ9utEn2jx/dUJX5PinxwTedYV2KGrcu4CFMigxoMW2gkCWypNG/GZjMUQXajObG3G/pnmCKZh11oDxs85X4iI5ZT1eioeenr78+Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i0KB+q/6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEABAC433F1;
	Wed, 24 Jan 2024 10:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706092437;
	bh=nmVHfsslJlEa808CDBRVtTpeFNG8yq9r7mh8I2w4JCo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i0KB+q/6SiUxzxk92ErNPBerMRIkM9c6KhEQB8eIORKZ4dZUZAhnJQPtWhFRYJ/NC
	 SJdjWKCG/hBn2UZ1Xb1O5gexJNDEu/efY13RnlsTW9IvbC4DXyrWboO6VqhUTJa5Xp
	 vSSY7aFLSvtUCOUaY1L2BwKxtVo3uF3UHqwlvkGj++/YQ/yVrbdecaytctfKdGKXtN
	 AQU+0zaonJ2dVVGXm/GirB/FN7Fe7oIELrBa2801gKJ0PJPg1ElgmW008ZnEFkBK87
	 lKJ5QcAAquOFvEilaRezr0kRyVc6qUamQca+cFqggWcTySGixuUxJhgYHC51B+AR+M
	 oeUjWTcnO7mVg==
Date: Wed, 24 Jan 2024 11:33:53 +0100
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
Subject: Re: [PATCH 03/15] dt-bindings: power: renesas,rcar-sysc: Document
 R-Car V4M support
Message-ID: <ZbDnkagFNxREoJ0b@ninjato>
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
 <1196419f3ade9a27b3c7906b6a898376b817601d.1704726960.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FJhUHyiCRQsESxxx"
Content-Disposition: inline
In-Reply-To: <1196419f3ade9a27b3c7906b6a898376b817601d.1704726960.git.geert+renesas@glider.be>


--FJhUHyiCRQsESxxx
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

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--FJhUHyiCRQsESxxx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmWw55EACgkQFA3kzBSg
KbZKQBAArGHa6miwlwvA3xvRkafsS5ZBO7YgJw7e2eLNG3sm/fJEnin5j8jt9XCZ
egRHi1SfUngNaHQgZueFmDlxS343Sf4jkjofPdC9NJMS3JtRf541xd31//XJu+le
UKwuWadRwjgvhEN16f8s1qW2QYrogtaDZb8uUJbvtvNu8pQVyPmjswN6RGZ9cd8l
x1LWBGGtiixpo1doZH0n6DwHudXIRbC9/Tfl9hLqeUKnfaXdZhi9XFOM2rfInT8T
+mFDcpoHrqbnNOlwdyCFTBRYGFvTqdMSFZrmzMLVLNnWxvWdgiTw+Qd4i2VkKw78
WxuTQT6f2SENgPpqhxznoL8sywu980KauqDk+M/LVmIrgyMIaSUyrCsyoaximY5Q
CdPQLI4zt/8GjLce9XNCam2GF6uie10KNfRR8y7vVFhkRpzowdrR1PzHvv9TMKbO
n6P77PipI2HBYjE8bAnOMyTBMVjTOl6/yyTm9a2uqJw2PdSbnzzL4vBm3a388/Pb
3BsJQmnaOaSvSeMwvGQQbxno6JodRXmGz2ouHIv8yFtSLt+na8x0KqN4sq1+N0cK
JuwvWjPaNT3HcCKT3pGz+BWsiV4b0VVPvcD+PG8A9SIVDguoRmQ4Xd4pI5z9OR2x
rq7BS/JB8/NdncjMWVcfC1cy8Ck+O9RHDT2Vs34QlSf8n/LzRmg=
=T0hM
-----END PGP SIGNATURE-----

--FJhUHyiCRQsESxxx--

