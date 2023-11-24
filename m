Return-Path: <linux-pm+bounces-182-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDCA7F778E
	for <lists+linux-pm@lfdr.de>; Fri, 24 Nov 2023 16:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE9181F20F0E
	for <lists+linux-pm@lfdr.de>; Fri, 24 Nov 2023 15:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820071A715;
	Fri, 24 Nov 2023 15:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQPWWZJn"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BEB2E820;
	Fri, 24 Nov 2023 15:21:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7EE6C433C9;
	Fri, 24 Nov 2023 15:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700839307;
	bh=SaOIsxsJcmKcTPVRIWwhizQdS7FaIYV1Cugn/gxXAro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YQPWWZJnxbOeBekGLTi6XkWlQf/vCdwXpsr03ltrCLXAKMVrn2r0AkcMbz9s4CCZS
	 6fdKiVeIR2/UlEOwl3A2yVyE7EP7tg292eho3jTZ1YSc9MW0tsdsuuVr/QP6d8WhlO
	 YW8i6u6IIVQKUEwo/bECsYwWY0rcoChoc+QwpgRDOn72hrWhlrg04Xd9LpiRZ88JXs
	 +pS32sUxIPGiEE68DvLrQYvytvaqmzzSqHj0okn3qvMokjXZw0ncvHo6Gma8CLy/JF
	 W2XmeALe5oPkb+uXLYhbyZvJLt3EyVriKsxUJYmxysqGJg9bLpJR8G6kukeEkB2YQI
	 ONDflUYGxaUMA==
Date: Fri, 24 Nov 2023 15:21:40 +0000
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	=?iso-8859-1?Q?S=F8ren?= Andersen <san@skov.dk>
Subject: Re: [PATCH v1 0/3] introduce priority-based shutdown support
Message-ID: <ZWC/hKav0JANhWKM@finisterre.sirena.org.uk>
References: <20231124145338.3112416-1-o.rempel@pengutronix.de>
 <2023112403-laxative-lustiness-6a7f@gregkh>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9TNEDLTCLPD8iDwO"
Content-Disposition: inline
In-Reply-To: <2023112403-laxative-lustiness-6a7f@gregkh>
X-Cookie: Slow day.  Practice crawling.


--9TNEDLTCLPD8iDwO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 24, 2023 at 03:05:47PM +0000, Greg Kroah-Hartman wrote:

> Anyway, this is ripe for problems and issues in the long-run, what is so
> special about this hardware that it can not just shutdown in the
> existing order that it has to be "first" over everyone else?  What
> exactly does this prevent and what devices are requiring this?

> And most importantly, what has changed in the past 20+ years to
> suddenly require this new functionality and how does any other operating
> system handle it?

This came out of some discussions about trying to handle emergency power
failure notifications.

--9TNEDLTCLPD8iDwO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVgv4QACgkQJNaLcl1U
h9C+ywf/QUDyaKfqEG5Uhu4wENzwHqAeD17M6852+Re27F2yC/ZnL+bnN+mqpj5R
y6FvYWyi2erYzViooNf0QplHyjOiNIjR/K5/HaffGN0/YxGcIMuvfCLmn9kK2LcM
Yav14SFDXohSvc6I1VKqEQLIJSL7YhS01SXUWdWNQQKcwQ2gHbYFQj1Rok0a1YCY
OmHkvGDRYJE03Cyli5pRD7kljZqLKlcGNv0WypxNqwrydW4c0ZbteN8pXA93JYi1
zznNzh0Z8RgqpBfH3JV7xbPjgaD0+N4Niej7F/UQugSTKPLx+zjzkEaZ8TM4ndPX
6KxNw7s+dLJcwXcfgV3s5m/KTq8Dvw==
=tn5a
-----END PGP SIGNATURE-----

--9TNEDLTCLPD8iDwO--

