Return-Path: <linux-pm+bounces-37196-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C6FC259EC
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 15:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 981F71B223AE
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 14:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0F634CFB5;
	Fri, 31 Oct 2025 14:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N50Vm5tQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8CD1C84A2;
	Fri, 31 Oct 2025 14:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761921437; cv=none; b=domtyXDx1dSL6jfn8SaEHM8XKpPKAyMo6qXKud8ujoRJCKFu9wafcWlEin+Pg0CmgkylIdw2F1sNzyWGVi7G6D+EXzR4cfH84v5gSG7UwXCPLfBd6BU8O/LJyg+np9dgDuoArCE2cbUp03iY6vuupHMpBJk1MUhBbbcsi1DJMuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761921437; c=relaxed/simple;
	bh=Yrm5olPCZv+MKZt1QBiFa4Kqvhr/2YybfwLySCaXxMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T1nSEQaI3kQ1ZJG5sdJIBWFUhCzWMaE0t0vhJoR1M+FChh0hhpswmeQTfaUSwIxtNRQkGldv3VX1IEXtPakhJe2MLcPrOtA3UO4vpwxPh6X0Yjg04HC+hdmGsyb/Jz2MeW1UmUhPdY+ydtxd4HGD9sH65YBzPNig4wA12uaycC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N50Vm5tQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E3FDC4CEE7;
	Fri, 31 Oct 2025 14:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761921436;
	bh=Yrm5olPCZv+MKZt1QBiFa4Kqvhr/2YybfwLySCaXxMc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N50Vm5tQrO0PZCXBrwnFaZD4cz5xOyC5R5i0oU9Ke+NrJenx0xBHU4sGw4xF/oQ0V
	 7q+wNYoe8pObjsuBpItN1xA8PZvYkRQode6g4lVOkvZpNMUD2b7h7wzmF9OFqyANUu
	 Vt7J4iRtKeYzG/eVh/BxBiOYBZhTYO3ofWAmg5ac9sg8WoMbFuZugDPK4pmYHm3IAL
	 RwnQm2l/y83hw4AYKudWmWlzG66QqXUofiycqiU6WUw0asFZjocqJAG7HmMX0OCn/E
	 tfXj7rWMdkTqLKwfm/ybVQ7btG0MSSh0/1yv+eMgc2q5dD3cC/qRq4GSyqEUJ0TnV9
	 rk6NybrcSS5Aw==
Date: Fri, 31 Oct 2025 14:37:07 +0000
From: Mark Brown <broonie@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Stefan Wahren <wahrenst@gmx.net>, Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com, Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Melissa Wen <mwen@igalia.com>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
	Maxime Ripard <mripard@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	kernel-dev@igalia.com, kernel-list@raspberrypi.com,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	"open list:GENERIC PM DOMAINS" <linux-pm@vger.kernel.org>
Subject: Re: RPi 4 deferred probe timeout of V3D PM domain
Message-ID: <77bbe008-427b-4491-a191-15be5e40e708@sirena.org.uk>
References: <10a4ef77-0e70-4ef2-b1df-535b476d256d@sirena.org.uk>
 <ecd75fd5-3131-4d10-ae3d-b6f608d9622a@gmx.net>
 <25e500c2-3dc1-476c-b6c1-ac4098a0501d@sirena.org.uk>
 <d6b14388-e0ab-44f0-b4d9-78adf74c2a7f@gmx.net>
 <d88f6420-5013-4856-99d6-da28f79bd7a5@sirena.org.uk>
 <CGME20251030191426eucas1p29ce063b538b60e4a998bcd32f925267c@eucas1p2.samsung.com>
 <043f1702-52fc-4a83-82f7-683a26851623@gmx.net>
 <b02c8890-4568-4afe-8628-10b77e79bf44@samsung.com>
 <3c171b6b-f8f5-4192-a3a3-da453a900316@sirena.org.uk>
 <aff4e3de-6dde-475b-9df0-3d7d6ad5d740@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="X5uYBAMfzR7WDf5d"
Content-Disposition: inline
In-Reply-To: <aff4e3de-6dde-475b-9df0-3d7d6ad5d740@samsung.com>
X-Cookie: Byte your tongue.


--X5uYBAMfzR7WDf5d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 02:54:15PM +0100, Marek Szyprowski wrote:
> On 31.10.2025 13:39, Mark Brown wrote:

> > Or the GPU driver should be moved to a module to match the clock.

> V3D already is being built as a module in ARM64's defconfig. The problem=
=20
> is in CONFIG_BCM2835_POWER driver (defaults to 'y'), which depends on=20
> resources provided by CONFIG_CLK_RASPBERRYPI (defaults to 'm'). IMHO=20
> both of them should be built-in and this will solve this issue.

Ah, yes so it is - I agree.

--X5uYBAMfzR7WDf5d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkEyZIACgkQJNaLcl1U
h9A1Ugf/YzkqFyXsikEGtRnC21evm/sbuTehV9VfpTcKzm0S41+hb2KBsArFjUSf
6UPvt2hTKFZQGhrslYCm8/K9WCog41Ai+anzrlCtPxYZ0oJ1nImyB0DEPdLnZFbS
0ykvMWQQwRaCJbPaKL1ryv8IxfRYW1O+hDxzZQ+g4qRBN9IRsE7nVcLFdQjZPvBU
dCvpe57Id+Nd1M/wNaO46emy4juCYxdyH2kotwW2k2l/p7bYLEZS5f1YqhQfhrTI
0YA5577P19tieAncVpJM+YkWOWTz8A5kQCnJYWNIkYKesimePHek9jNN7IsNYMj4
SHkVuRoe+e9kJs0Pa2UyDL9ZLSBssg==
=h+x7
-----END PGP SIGNATURE-----

--X5uYBAMfzR7WDf5d--

