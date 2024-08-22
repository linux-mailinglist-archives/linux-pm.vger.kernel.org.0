Return-Path: <linux-pm+bounces-12753-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A174095BC40
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 18:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58B9C284EB8
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 16:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E0B1CDA2E;
	Thu, 22 Aug 2024 16:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SAPabIpB"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AF51CC174;
	Thu, 22 Aug 2024 16:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724345138; cv=none; b=d5pV4kuELxXJMJZLB4QahYUP1ylUfDTgVkBCB5h8bgDNksYPOlhcAeTPVBscoBO4TRKxyYMIWUXAwShNokepr0Vd52p3OSpuyLSEKD2ryexsWAtblo/9XE5hOxFD72f46W658wgQxCHrstT7vKfqtXXf9RpaUaCxuAyp2Z/Yi7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724345138; c=relaxed/simple;
	bh=LNt38baBn7GGG3MYS0fB6ojOAhRQN1lnGyQaaVoF6/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XrfKutRAF8nWY2EIUa3VWhMR2tWZakpX3jr4Rg0TaqfqPSefwiuH7rC20MxTQl1e4h+TcuXWAy0T0ieearDnbvGs9fFD0hgQJK4rcg7aB8PV8TPUkulT8Vt5C4tla7HlZTVfAjPzGmBaYO04azt4IatofuFea5FT+tLPC3Q90Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SAPabIpB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D570C32782;
	Thu, 22 Aug 2024 16:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724345137;
	bh=LNt38baBn7GGG3MYS0fB6ojOAhRQN1lnGyQaaVoF6/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SAPabIpBZLs5AcQQRmg/Q2a2NGDsDUlON3bcKHBJ5LSKbg197IjOgigna1kvU6JJL
	 2zkhmDgevoNhhhr0cds1GBLrCLKWa4x7jAXr9vLm7NWmphL1p4amJ74YtoWLiO6N3x
	 +kXo6QOpVlm7RD4pCH8+w5NRjsASeO11NB7EN3AWB8njSofBCMw3fMzs5Rd0CbqbEa
	 1fXxxDXq9RcTxJ/EILsgfUiUiyfRcGGlRZGDT5qoJhDEc/23fG8nnH2b1Ha7bwqnE5
	 THMxFbmAg3F9hfGf07vVr48yvFcrEyGVgh2G3CSushBS/ApYcghPJik3GqBvg5Ibag
	 7TeL5qFKaUf1Q==
Date: Thu, 22 Aug 2024 17:45:31 +0100
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
Subject: Re: [PATCH 03/16] dt-bindings: reset: renesas,r9a08g045-sysc: Add
 reset IDs for RZ/G3S SYSC reset
Message-ID: <20240822-antennae-mouth-b1d5e23425f0@spud>
References: <20240822152801.602318-1-claudiu.beznea.uj@bp.renesas.com>
 <20240822152801.602318-4-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="L+kFVAIM2ezB7LzQ"
Content-Disposition: inline
In-Reply-To: <20240822152801.602318-4-claudiu.beznea.uj@bp.renesas.com>


--L+kFVAIM2ezB7LzQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 06:27:48PM +0300, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> Add reset IDs for the Renesas RZ/G3S SYSC reset controller driver.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--L+kFVAIM2ezB7LzQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZsdrKgAKCRB4tDGHoIJi
0vd7AQCfa4Z/nf+oiZGT7XkDHEggTcHwVQvighgqF6SDa5dTxQD/faumDkWUMd2S
APjv8R3K8ZxHcowAkyLfqpNMtozWxgY=
=KnSG
-----END PGP SIGNATURE-----

--L+kFVAIM2ezB7LzQ--

