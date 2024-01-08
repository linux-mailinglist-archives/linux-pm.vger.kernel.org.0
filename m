Return-Path: <linux-pm+bounces-1961-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B661D8276AD
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jan 2024 18:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C6A71F2311F
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jan 2024 17:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D3955766;
	Mon,  8 Jan 2024 17:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mAx911Og"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A1356454;
	Mon,  8 Jan 2024 17:49:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B94B7C433C8;
	Mon,  8 Jan 2024 17:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704736151;
	bh=d4qz83EjwUytJuNhWuKLXjTEVi0UOzqGjwWWhqF/k30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mAx911Ogf+xgInSFJ3LyTIBtPbGg3k4QKV+AXIt8ocru4DGZKF5LpB/i7mX0HDFXi
	 uKoFLVqzWVgjvHRjLpsSGUARwxta61MTDTEIUEG9gfpdeO6/NpaETTYv8NyhFtV9Al
	 lFZTfJzGTZTsKaSCf5Gn/Iouz8n1+FJQ51QoRHzCt61LHjJiTilYWZgJ6yq52KzOcV
	 Dog1wfDdGw1enoNQ7ocYKIxBdGHih4FkHnO4Dvf8klUSHXeBM4HUOLMG6+r/AWn3XQ
	 IDKZ0u2SpkB4sv5jF0heTsZsTjwywL7Bb8+tj2mBEQdSbH8zObOd5xyoaWvlAr403r
	 pMGVMesdneA1w==
Date: Mon, 8 Jan 2024 17:49:05 +0000
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
Subject: Re: [PATCH 01/15] dt-bindings: clock: renesas,cpg-mssr: Document
 R-Car V4M support
Message-ID: <20240108-unrigged-cage-1a6c27d1a9e0@spud>
References: <cover.1704726960.git.geert+renesas@glider.be>
 <81f5a2b55795af06f6fd54b3d566156e91138a17.1704726960.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9qCag8DPO53XwjAI"
Content-Disposition: inline
In-Reply-To: <81f5a2b55795af06f6fd54b3d566156e91138a17.1704726960.git.geert+renesas@glider.be>


--9qCag8DPO53XwjAI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 08, 2024 at 04:33:40PM +0100, Geert Uytterhoeven wrote:
> Document support for the Clock Pulse Generator (CPG) and Module Standby
> Software Reset (MSSR) module on the Renesas R-Car V4M (R8A779H0) SoC.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--9qCag8DPO53XwjAI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZZw1kQAKCRB4tDGHoIJi
0iKXAQDotiDO0pWCJa937RC3CzXY6WqmgIwXh5aWvWd4WVRvIgD/TiyGUuLhc9SJ
usbO1buDnqjU4ojF8j8vBXTCleRitAQ=
=nUgm
-----END PGP SIGNATURE-----

--9qCag8DPO53XwjAI--

