Return-Path: <linux-pm+bounces-12756-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E4395BC56
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 18:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C15528552F
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 16:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443F91CE6FD;
	Thu, 22 Aug 2024 16:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gTtiZOl2"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9721CE6E8;
	Thu, 22 Aug 2024 16:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724345201; cv=none; b=FbalIZrv73iFaatmKUdaXK50aCIisI3qrX8HxtEiQ5gu54DmoB3yQociU16UceoxObiMphRtOADZQyCTm1aTtKcMgOTrIRNyGF5Z4JsfzAyJwoAMcS918tSmtKUFf3w7B8EpOGp/CTPd39erSmWuV9P605xxX7hUp1bIODErIcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724345201; c=relaxed/simple;
	bh=FvxdiKHyEdgk3+LYFNwSArmpeWuVoucsDBFvg6Z/Hro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dkKvuYHiHbhxNvGmCjsauVv5bCrbqKQOgXl1vLZPw2m1vbzZTdhwcei/V9a6FyrgMGW48m4Mbr7eEK+xS4U6ZLz2wDdSTOykWdfTwHu4yMxO7qUV6mIgBF79olgUmgzEBf8jzmqDCgZoWWSeq9q8CELi8cdG52azfJr3Sju0/vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gTtiZOl2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22688C32782;
	Thu, 22 Aug 2024 16:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724345200;
	bh=FvxdiKHyEdgk3+LYFNwSArmpeWuVoucsDBFvg6Z/Hro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gTtiZOl2pgiaJ0lGKZJOPwRpHDst0oReqOU+oGdVWRWSzkvGeAauMWry4M2oXseVm
	 DdjTwR68Rv/4Lwr2u8uz7hqPqnH5fXHm3f+mXILdvdPH1ZuewKTu4MO5T00uWH3JX9
	 XlmZZYD+n1reOcP4g7843IcnE+SFdc2aa+W1lVc/BoN7xP4x9NAhPlDZjwjC+2lF0I
	 D1pLNf5BrL3lTy+tUXjRm/5tRB+S+umjUv4AAinQv/aLwHt44Ph3xJ5tzrtaWAvAHH
	 6EuEYEzcPzoZ1AbSE3MARNVGgmgOP7rXkXkGDh8Nfa1Sd2YsyDg2hFZH0ILdz1WI5q
	 LIUfqMl0DeuWg==
Date: Thu, 22 Aug 2024 17:46:34 +0100
From: Conor Dooley <conor@kernel.org>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, p.zabel@pengutronix.de,
	geert+renesas@glider.be, magnus.damm@gmail.com,
	gregkh@linuxfoundation.org, mturquette@baylibre.com,
	sboyd@kernel.org, yoshihiro.shimoda.uh@renesas.com,
	biju.das.jz@bp.renesas.com, ulf.hansson@linaro.org,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH 11/16] dt-bindings: phy: renesas,usb2-phy: Document
 RZ/G3S phy bindings
Message-ID: <20240822-idiom-parasite-1c025f81a399@spud>
References: <20240822152801.602318-1-claudiu.beznea.uj@bp.renesas.com>
 <20240822152801.602318-12-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="n6tcZc8VQgDU6IS+"
Content-Disposition: inline
In-Reply-To: <20240822152801.602318-12-claudiu.beznea.uj@bp.renesas.com>


--n6tcZc8VQgDU6IS+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 06:27:56PM +0300, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> Document the RZ/G3S PHY bindings. The RZ/G3S USB PHY is almost identical
> with the RZ/G2L USB PHY. The difference is that there is a hardware
> limitation on the max burst size used when the BUS master interface
> issues a transfer request for RZ/G3S that is configured though PHY
> registers.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--n6tcZc8VQgDU6IS+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZsdraQAKCRB4tDGHoIJi
0tFUAP4+QkcGlFAZRCml52Rk+JBPvo9JE4TS+hLepapieOITIwEArIn+vxHSvlPF
SRdWF33ftrzazHqHTyx3A1xVMa7DngM=
=+2KY
-----END PGP SIGNATURE-----

--n6tcZc8VQgDU6IS+--

