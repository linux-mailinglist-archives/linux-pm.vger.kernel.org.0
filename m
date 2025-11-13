Return-Path: <linux-pm+bounces-37991-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3816FC59D97
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 20:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 487614E63B0
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 19:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10633191C8;
	Thu, 13 Nov 2025 19:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLGnHjbW"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F92F315D29;
	Thu, 13 Nov 2025 19:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763063564; cv=none; b=T6eUtV4aahIkDZGh1n7N7whW3jGJGa73e+9V+VWcLoQf1x6Wfj/ihtA3dfoU/m1hTWrKcBlase2TJYGtuN0ZVUwcWx0P8ZaXBO59Bosu69i7JGxyz5jD+AyjyLEfbZEBmLdO2r3DzL6e07Hzjb+bLa/03LtN3/i252smWrsCeow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763063564; c=relaxed/simple;
	bh=D6xByP9v7HA0BT4JxxGeDeAoBgYUhj6KpJENBxSZV5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TROK0BlgDGPWDTpXU9c1Co7faDLVEFX8YVqr5lx3dtTDYcvDVKTzTdnZk0Mw1X6La3tMwqpw+OSizZRnOqDaUYCpq/IhmCs2Jzi7wKy9N/ciuAZbYJqzmqwcjFqqyWillLE3rukpgB36AxbiopNV9WtenjFONPtT99j2SiveKNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLGnHjbW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61B79C4CEF8;
	Thu, 13 Nov 2025 19:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763063564;
	bh=D6xByP9v7HA0BT4JxxGeDeAoBgYUhj6KpJENBxSZV5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GLGnHjbW8w5AQLT4TCnqeRul6f5gt7WgxeT+9V7DkAV3tkBaqwEJ65N1LJnhcD8tQ
	 CmKv33y0fDkZdzyeFPVWBpEM2EA8fOLBleoBFcnRA/N+VGbS3AMwThmoKC7EniD74n
	 ureP3k9067MsWLTnxkEtvjKsCmVpzO0yDOi6p/6tDeD78nx+Q0qtgmjgoJ7m7PIVvb
	 OZ6sS6CbotGH8HAgOo1p06gSwaSeX6RvpwEJd9t1L7IPWCCwXUdJhDlmy8k5SiI89q
	 sJ08U0J4hRSIIRS8VchBU+vLCIHtId1WyzNWkem6wN9Hb1rdsuM9NcMMrM+Si2Ft3k
	 6llenEIRl0LSg==
Date: Thu, 13 Nov 2025 19:52:38 +0000
From: Conor Dooley <conor@kernel.org>
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Sebastian Reichel <sre@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	=?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	linux-rtc@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 01/13] dt-bindings: leds: document Samsung S2M series
 PMIC flash LED device
Message-ID: <20251113-silica-unashamed-6d78cdf55b35@spud>
References: <20251114-s2mu005-pmic-v1-0-9e3184d3a0c9@disroot.org>
 <20251114-s2mu005-pmic-v1-1-9e3184d3a0c9@disroot.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Pm2uUZI5hpWGqHdz"
Content-Disposition: inline
In-Reply-To: <20251114-s2mu005-pmic-v1-1-9e3184d3a0c9@disroot.org>


--Pm2uUZI5hpWGqHdz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 12:35:02AM +0530, Kaustabh Chakraborty wrote:
> Certain Samsung S2M series PMICs have a flash LED controller with
> two LED channels, and with torch and flash control modes. Document the
> devicetree schema for the device.
>=20
> The initial driver introduced has support for S2MU005, add its
> compatible as well.

Drop this sentence please.
pw-bot: changes-requested
With it gone
Acked-by: Conor Dooley <conor.dooley@microchip.com>

--Pm2uUZI5hpWGqHdz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaRY3BgAKCRB4tDGHoIJi
0hquAQCFvzpL/uf0VxfXg2G5vEFz2sazW81JFWrhtOtwcp2YfwD/QevXW5MldAvy
LgEwcl+DCU8iEfnMtBUEC5/q6eI2OQw=
=dXM/
-----END PGP SIGNATURE-----

--Pm2uUZI5hpWGqHdz--

