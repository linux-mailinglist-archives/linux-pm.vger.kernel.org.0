Return-Path: <linux-pm+bounces-2673-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76ABC83A72C
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jan 2024 11:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D0221F27AD0
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jan 2024 10:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87BE18EBB;
	Wed, 24 Jan 2024 10:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a5SmOcLv"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA481199A1;
	Wed, 24 Jan 2024 10:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706093376; cv=none; b=WkdjAI6GQOVmO+YvFvi0nPM0KRI7M7gxo9nUfU/K9jaAhBHAwnETkCbdpI0T/ExT1Y3vUoE02B2nVBHMb/D2GVwhYA3ZnCePB0znxpfbIdR/XflWxlkEnyHEEkRY/C8oMNWNrJR3AFFEaTQXhFCoEN05vsH9so6jBQ1At8BJJ1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706093376; c=relaxed/simple;
	bh=fwRMd+Dxa1ltASNwmQ0LsTQwooXOpibUP36077tMqu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fvyYgyd1O6EKHLw5mfBm9Lt/IuFDsNiQiI/FeH0DJ6vE7yJ5wFs/byXJR6nnSXFx772wdQ5aKXmMPyv2ns0ciJg0uT4RZXlE/xFI66Bee/SEVTOPMMCfg3RSnvDRBNmwMrYBbvTYdCi5G6WqID6AbG9jGsCd34jbiLb2S+GeySw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a5SmOcLv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F19C433C7;
	Wed, 24 Jan 2024 10:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706093376;
	bh=fwRMd+Dxa1ltASNwmQ0LsTQwooXOpibUP36077tMqu4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a5SmOcLvuiMMc9n5xIkFXW4DTqw42Ev27RYxbbzfgh0tCH4Vxhik8CvCVQMC/WgGj
	 YK3f7pvVCwtN3qiPS2hLjq6ru4r04B+s00ugobPDV7DdFXRgyUNo5kSQDx/pvQJwB4
	 f8uPtyXb/4LiCGdc67SQY1UY15kleWPEEKUfBh6Frtka+3slNAR0Z3ft9HIc1sOnDy
	 D/7U+ad4O40UDo4irSLUvr41kjpoDCpEgxR10wTim5NnnYZoqRkefGY3VLXohfc/ya
	 nFGKPQwN8Rxi5le0u7gBeM64LHShJnj+xlvTP7Qs/soIEiIDKQCl/n9/JS/70zSaFV
	 B1+U55VQF2Zpw==
Date: Wed, 24 Jan 2024 11:49:32 +0100
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
Subject: Re: [PATCH 11/15] soc: renesas: Identify R-Car V4M
Message-ID: <ZbDrPPAN42d4WTdZ@ninjato>
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
 <d92add6e71daf88d4f6e689f5097cf1f1addbec8.1704726960.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YyIUF92PqcFjvfUx"
Content-Disposition: inline
In-Reply-To: <d92add6e71daf88d4f6e689f5097cf1f1addbec8.1704726960.git.geert+renesas@glider.be>


--YyIUF92PqcFjvfUx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 08, 2024 at 04:33:50PM +0100, Geert Uytterhoeven wrote:
> From: Duy Nguyen <duy.nguyen.rh@renesas.com>
>=20
> Add support for identifying the R-Car V4M (R8A779H0) SoC.
>=20
> Signed-off-by: Duy Nguyen <duy.nguyen.rh@renesas.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--YyIUF92PqcFjvfUx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmWw6zwACgkQFA3kzBSg
KbY7Pg//QUUHmqAvTAwdvlhaZ2np5owE54m8mOW7cxhw5OK0FuNn2ftX2yqRNish
DCraYCsP5nxnBw+XhTjZZJxQpr6yppPGwe1mK2V0Zl+f3k/SQshnQ6gGoCB+jaXN
hkY7QZy2p5hvFjwHA0LlmiHu04+cQo2CREl47hZWkCl4WiuT1pmuWDvm91UEKiaG
LreiSwDamWFuW+Akio8a8JFH9vstxTJnAV+lbLXBHyBAZECFMUdiiySDgR/6nYf7
jY3Df9OX2Jee0AyceLtTcx31c1ja/g4fWLaCcnXc95Cf88PZP498/HBT2B4UYPFL
GayU4A+VCGPvoKhThCDEM5FwSWayGLtECZdH21nM1PA+Uj8mNksKk7jIbli5FcX9
5RbKNZUYUdZEZZm6KpAljPL0NeycNl0VUFYvIWr1Rh39B2Vru5P0Gm4gJA0rmRTK
HaR9hIIUPTOWEMjcU1HznUIk/GazMPUOJ8/zRYkfNoFmE+Pt7yg3quIjyMVeNzTF
oBZEvQISMsJN9wrqNJ8LbkG6PVkWmVtFRiu1/5hSoIG7holYFvW8hvRbvzzLudSr
16U+HUfYxqBl3Egh1ZSiKf58VBRmL8bfhuWePvG4pK7MagSBYXZfROFjlViEYXKU
79aZRQct/Ypvi6AeZKQ3gGi2GFMVgXnu7lyrrCCs4xRpv6ygF00=
=fgV2
-----END PGP SIGNATURE-----

--YyIUF92PqcFjvfUx--

