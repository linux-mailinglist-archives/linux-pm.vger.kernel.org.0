Return-Path: <linux-pm+bounces-184-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A73257F7821
	for <lists+linux-pm@lfdr.de>; Fri, 24 Nov 2023 16:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6154A281186
	for <lists+linux-pm@lfdr.de>; Fri, 24 Nov 2023 15:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD143173D;
	Fri, 24 Nov 2023 15:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WGurvF6X"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5283172C;
	Fri, 24 Nov 2023 15:49:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C290C433C7;
	Fri, 24 Nov 2023 15:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700840989;
	bh=DPNUXFZ8krOO/zfEH0Ax/h+VZrud73hwWU+1GlI2Zx0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WGurvF6Xgz485nbzHx9vsGClmcTs/4jSifsESVXcUgqmw9LZS5u4JEF9q91I8SXwP
	 yxygxoluR1o6UohVbHFTqshFBC5LQEZvG0jXhN/966FkDcFLQQcJewP7ZHWjCajPcg
	 Re/VdJHs6rx9LUYHAe9g6X1Gic/N/ojQaBbnPAw41DKd/TGHr9+CoDZU7s4/7+x9vl
	 oc7ajP0Gdbe7lyS9Y1Ltf7640L76d6IP2mc1eFHIMXs/YWXDiDiwm02Ls0rQTwuJi3
	 rF5Am2fGMI9G7QSmg76ivbqvK65HO6oBlG2z+VT356tewXXi0SMkOiFn84rDll0a2D
	 SLqXQEdsOSPuA==
Date: Fri, 24 Nov 2023 15:49:46 +0000
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	=?iso-8859-1?Q?S=F8ren?= Andersen <san@skov.dk>
Subject: Re: [PATCH v1 0/3] introduce priority-based shutdown support
Message-ID: <ZWDGGqsCq9iSnHtO@finisterre.sirena.org.uk>
References: <20231124145338.3112416-1-o.rempel@pengutronix.de>
 <2023112403-laxative-lustiness-6a7f@gregkh>
 <ZWC/hKav0JANhWKM@finisterre.sirena.org.uk>
 <2023112458-stature-commuting-c66f@gregkh>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6939kKTjmQm/xsgi"
Content-Disposition: inline
In-Reply-To: <2023112458-stature-commuting-c66f@gregkh>
X-Cookie: Slow day.  Practice crawling.


--6939kKTjmQm/xsgi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 24, 2023 at 03:27:48PM +0000, Greg Kroah-Hartman wrote:
> On Fri, Nov 24, 2023 at 03:21:40PM +0000, Mark Brown wrote:

> > This came out of some discussions about trying to handle emergency power
> > failure notifications.

> I'm sorry, but I don't know what that means.  Are you saying that the
> kernel is now going to try to provide a hard guarantee that some devices
> are going to be shut down in X number of seconds when asked?  If so, why
> not do this in userspace?

No, it was initially (or when I initially saw it anyway) handling of
notifications from regulators that they're in trouble and we have some
small amount of time to do anything we might want to do about it before
we expire.

--6939kKTjmQm/xsgi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVgxhkACgkQJNaLcl1U
h9DHEwf/URLyuQsQNf8uufQIJEo3j+d7jM8LtXL5oRAPKTnE83+rtwxOtLMGUqwr
+ZwgTGJyPFNVx9fAj5hYLf43uOpGsaJFXuDeIFxg6N3VxOjCwE9NFysnbfVhdM4n
OOLNjh+xJvurdOYyOjEfXVAzG3LzuPnr1oDv4YEsdpxg1o8Mk8RCtnFPAwfTftZF
9bMuS4LhIP5pa7mKCS2x8cB/skT7YUVxWZQ7zFTyMTslPDkriWmHu/au6u0Q61tC
jX32e5ef0nyb51z4oIYsOh1qSndAUr3Cyfv17BgxDM4NPujvGfL+FAuPdEILTXZn
pUsfQrkuZFORZg/dJvKmTltQbIThNA==
=o4Vm
-----END PGP SIGNATURE-----

--6939kKTjmQm/xsgi--

