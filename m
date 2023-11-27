Return-Path: <linux-pm+bounces-297-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0CE7FA64F
	for <lists+linux-pm@lfdr.de>; Mon, 27 Nov 2023 17:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56A57280F3F
	for <lists+linux-pm@lfdr.de>; Mon, 27 Nov 2023 16:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19304364BC;
	Mon, 27 Nov 2023 16:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KXLzUMq0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4F335882;
	Mon, 27 Nov 2023 16:25:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F39B0C433C7;
	Mon, 27 Nov 2023 16:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701102304;
	bh=jc8FKRZZFa7tBi4FMGUMBS1Wxj4Lg8wGqG+jw+xitxY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KXLzUMq0Pc8HJxv1LoZ2noEVGkJQhnUHrTFGCXfyiyz2VYT0BReNjuZvSDufyIdDl
	 AxTgNzgihrxN8ikKBuBR8fczBzGMKOi8ie4eie/NJi+2ufkTkvH+wDjKcJEVfNiWUP
	 ddwjfSwY77MEpfaiD+QhEn0UiNvsd4HQoBd7k2jE95jRgOSBZOg5IQ7ksU6mrusrit
	 lBG/AY4xzQEIKwtqdkhQ1r3ym632CTZDz05FvtPcmY0yUjuRt5arIX3ugUJUtZ4ZFt
	 BNBJ/bfxOiOKvJAcY7UiPOctOP4CdygFyTbSiZ3qhbEJ80n3QCwQJHA5ucXNiqoDo1
	 xc7m/vIIGrVDg==
Date: Mon, 27 Nov 2023 16:23:47 +0000
From: Mark Brown <broonie@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	=?iso-8859-1?Q?S=F8ren?= Andersen <san@skov.dk>
Subject: Re: [PATCH v1 0/3] introduce priority-based shutdown support
Message-ID: <ZWTCk7coYuZBe8me@finisterre.sirena.org.uk>
References: <2023112403-laxative-lustiness-6a7f@gregkh>
 <ZWC/hKav0JANhWKM@finisterre.sirena.org.uk>
 <2023112458-stature-commuting-c66f@gregkh>
 <ZWDGGqsCq9iSnHtO@finisterre.sirena.org.uk>
 <2023112435-dazzler-crisped-04a6@gregkh>
 <20231124163234.GC819414@pengutronix.de>
 <2023112453-flagstick-bullring-8511@gregkh>
 <CANhJrGPop=tL8y+chvPwMpSZYF1pkeWeRp3xL+7JsuY=U0fyag@mail.gmail.com>
 <2023112722-headdress-kissing-8c9f@gregkh>
 <bb332c07-6cf6-4f38-99f5-657a48c332d9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CK63ajjUxdVN8+D6"
Content-Disposition: inline
In-Reply-To: <bb332c07-6cf6-4f38-99f5-657a48c332d9@gmail.com>
X-Cookie: Slow day.  Practice crawling.


--CK63ajjUxdVN8+D6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 27, 2023 at 04:49:49PM +0200, Matti Vaittinen wrote:
> On 11/27/23 15:08, Greg Kroah-Hartman wrote:

> > Yes, using device tree would be good, but now you have created something
> > that is device-tree-specific and not all the world is device tree :(

> True. However, my understanding is that the regulator subsystem is largely
> written to work with DT-based systems. Hence supporting the DT-based
> solution would probably fit to this specific use-case as source of problem
> notifications is the regulator subsystem.

Yes, ACPI has a strong model that things like regulators and clocks are
not visible to the OS.

--CK63ajjUxdVN8+D6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVkwowACgkQJNaLcl1U
h9BDiAf+KwCxhYlcA3uQ1atUaynwHjGNkgXo8Ut7HBI+cOgmFK1J8IsfAFBCvIgf
lTsLgsELLWsxrXQi9WcasTONuH0ROLYTriDuLvnxwZxThHeTCjByNIl0S0QnTfge
6BkXfwQUX087S+8e7lgaDgmM+JcX7kBYz/akL6bLlvk3zsHK/flRnc8O1G1Sx7Bl
SZUMqpK+YftJZWv79pfMd8nQfA1BN6cvXx8+AzgfJ2hPdj0mjiA9JcYILa1UG2yT
RAOufMpiJdSIBv+tiruE7ssd5ciFsX1Ips7oJpjqmWcPVe6JB5bJUyN4LJDY7TSy
ALFwDSPvFjLQfwb8sv1EGqzUowg+EA==
=4EY+
-----END PGP SIGNATURE-----

--CK63ajjUxdVN8+D6--

