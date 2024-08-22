Return-Path: <linux-pm+bounces-12754-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D8195BC44
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 18:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FE021F27813
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 16:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625661CCEC5;
	Thu, 22 Aug 2024 16:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YypZl2RC"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8E7EAC0;
	Thu, 22 Aug 2024 16:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724345163; cv=none; b=MlMvDjXrXPX5A4VW0ZeYzxVGb2ADua9M3d0uk1yAtOWWMHw8Y+E0YA+5m7tdA4g5p537+BlXdpKnvLGPCW4I6geTgp4f06QT55MZMSdYXzalGmgZ9z1c8JS9Wpzi7iIyr1OSD1EQDDLREGZmfOydQMk6j28TtgxH8olh03WVYMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724345163; c=relaxed/simple;
	bh=cMfaa0B/xMQ0ls5dtOkTDegOrA7pKxwTaEWGp6g/86Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQIN0768v+suQv5j9j3qK2qBprMKSLq+TPiWCZr+pscslR6rtnmd5PMnMKhwiR7sSGCA6ccJGQdtkXiEHX1cvFpMuu/IEJPqJVuNj8/52hveLMFd9jrENCPuXGM++EWXRmoUmTt9rIksC4jOl8rPV//JKA+YJ0m27nikfbSa1QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YypZl2RC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F311C32782;
	Thu, 22 Aug 2024 16:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724345162;
	bh=cMfaa0B/xMQ0ls5dtOkTDegOrA7pKxwTaEWGp6g/86Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YypZl2RCrZDJU1uXHF95jWfYJyUn9bJRhFJYiAt7bOr0b8sgt+rq76wlTXGOfwGPY
	 S46DV8XAXYO+XUvMq+KrOcrbnKvzceTfbU7BevvCWYdmL7iv6giaVtVaGey11fSnny
	 sNc2F1YVgtvDmzQ2tvqvXA27ELtCfGK0UdHFEDjkUlvNqDg48fbwSr65CVHGYSAWy6
	 7xFoWsGSiLlZZNWsaLdBoiDQs+O9t+ONzuP0MzdcSDNrr3cXbopYonZmGbvlyDslbj
	 vtYHPgGd5HCF7oZafeao6eRwhkfByJoexlnfhBNjiL7TyUuHo+fhlWNZkRLaaBaQKo
	 OqgjhBCkajHFw==
Date: Thu, 22 Aug 2024 17:45:56 +0100
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
Subject: Re: [PATCH 06/16] dt-bindings: reset: renesas,rzg2l-usbphy-ctrl:
 Document RZ/G3S SoC
Message-ID: <20240822-emoticon-draw-0cf557c425f7@spud>
References: <20240822152801.602318-1-claudiu.beznea.uj@bp.renesas.com>
 <20240822152801.602318-7-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wpAA43Alk9pJpKUy"
Content-Disposition: inline
In-Reply-To: <20240822152801.602318-7-claudiu.beznea.uj@bp.renesas.com>


--wpAA43Alk9pJpKUy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 06:27:51PM +0300, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> Document the Renesas RZ/G3S USB PHY Control IP. This is similar with the
> one found on the RZ/G2L SoC the exception being that the SYSC USB specific
> signal need to be configured before accessing the USB area. This is
> done though a reset signal.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--wpAA43Alk9pJpKUy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZsdrRAAKCRB4tDGHoIJi
0mS1AQDOIrI5V4Tm1BHqGgW2bvAyeS79T3se/WkG3OlitsuXywD/fdNyGMita+TO
xHGCrO2/4SSpNJhIxpNEFnRSFoyHHAY=
=Z/RQ
-----END PGP SIGNATURE-----

--wpAA43Alk9pJpKUy--

