Return-Path: <linux-pm+bounces-237-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C71177F9219
	for <lists+linux-pm@lfdr.de>; Sun, 26 Nov 2023 11:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D907B20D11
	for <lists+linux-pm@lfdr.de>; Sun, 26 Nov 2023 10:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0807470;
	Sun, 26 Nov 2023 10:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b8IFm4+N"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6FD802;
	Sun, 26 Nov 2023 10:14:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE7B0C433C7;
	Sun, 26 Nov 2023 10:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700993688;
	bh=PPedvbS5DQ2FZTOoN4M0bKSN7HSiJdPxPxYv6Vn4nvw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b8IFm4+NrJH4sB0Nj6RYRs0zluBsf4CoYd+dcuFwR7zrU2bfptNXzP6VOXbpX3k6l
	 vi8OiK7zbvwXw56T4TAZSJUF94UTu4quFzAWMVwBaXWkj2HKBE2Vgm6wRHx8xdI3YC
	 cP0RUqEZrjlt97PutC4aEkt6LD7HJZbQ0IFQxvfnUT+w/74MGJU0jOzkuLd+0wrGyL
	 A/mvwCDlnvYI86VbYAQxO3EGjDSUYsR0QUxgUTZ/5+gOKX0l/lwRwOp7oSjG5yyl5e
	 bCsWee2otzBbM9REISsAnPZ9xe9iirohBrbOM4vev7+ZFZ8ZTxncxB5JJcuRRHTuik
	 9CQbRR/9HZ+Nw==
Date: Sun, 26 Nov 2023 10:14:45 +0000
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	=?iso-8859-1?Q?S=F8ren?= Andersen <san@skov.dk>
Subject: Re: [PATCH v1 0/3] introduce priority-based shutdown support
Message-ID: <ZWMaMIGUo9DeyEH+@finisterre.sirena.org.uk>
References: <20231124163234.GC819414@pengutronix.de>
 <2023112453-flagstick-bullring-8511@gregkh>
 <20231124185725.GA872366@pengutronix.de>
 <2023112520-paper-image-ef5d@gregkh>
 <20231125085038.GA877872@pengutronix.de>
 <2023112506-unselfish-unkind-adcb@gregkh>
 <ZWHM0lRPOp/efyD5@finisterre.sirena.org.uk>
 <2023112541-uptown-tripping-05f3@gregkh>
 <ZWIWBhBN8AmK7tAJ@finisterre.sirena.org.uk>
 <2023112504-cathedral-pulmonary-83ce@gregkh>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uQh9ua/qwEbUZunq"
Content-Disposition: inline
In-Reply-To: <2023112504-cathedral-pulmonary-83ce@gregkh>
X-Cookie: Slow day.  Practice crawling.


--uQh9ua/qwEbUZunq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Nov 25, 2023 at 07:58:12PM +0000, Greg Kroah-Hartman wrote:
> On Sat, Nov 25, 2023 at 03:43:02PM +0000, Mark Brown wrote:
> > On Sat, Nov 25, 2023 at 02:35:41PM +0000, Greg Kroah-Hartman wrote:

> > > That would be great, but I don't see that here, do you?  All I see is
> > > the shutdown sequence changing because someone wants it to go "faster"
> > > with the threat of hardware breaking if we don't meet that "faster"
> > > number, yet no knowledge or guarantee that this number can ever be known
> > > or happen.

> > The idea was to have somewhere to send notifications when the hardware
> > starts reporting things like power supplies starting to fail.  We do
> > have those from hardware, we just don't do anything terribly useful
> > with them yet.

> Ok, but that's not what I recall this patchset doing, or did I missing
> something?  All I saw was a "reorder the shutdown sequence" set of
> changes.  Or at least that's all I remember at this point in time,
> sorry, it's been a few days, but at least that lines up with what the
> Subject line says above :)

That's not in the series, a bunch of it is merged in some form (eg, see
hw_protection_shutdown()) and more of it would need to be built on top
if this were merged.

> > > Agreed, but I don't think this patch is going to actually work properly
> > > over time as there is no time values involved :)

> > This seems to be more into the area of mitigation than firm solution, I
> > suspect users will be pleased if they can make a noticable dent in the
> > number of failures they're seeing.

> Mitigation is good, but this patch series is just a hack by doing "throw
> this device type at the front of the shutdown list because we have
> hardware that crashes a lot" :)

Sounds like a mitigation to me.

> > It feels like if we're concerned about mitigating physical damage during
> > the process of power failure that's a very limited set of devices - the
> > storage case where we're in the middle of writing to flash or whatever
> > is the most obvious case.

> Then why isn't userspace handling this?  This is a policy decision that
> it needs to take to properly know what hardware needs to be shut down,
> and what needs to happen in order to do that (i.e. flush, unmount,
> etc.?)  And userspace today should be able to say, "power down this
> device now!" for any device in the system based on the sysfs device
> tree, or at the very least, force it to a specific power state.  So why
> not handle this policy there?

Given the tight timelines it does seem reasonable to have some of this
in the kernel - the specific decisions about how to handle these events
can always be controlled from userspace (eg, with a sysfs file like we
do for autosuspend delay times which seem to be in a similar ballpark).

--uQh9ua/qwEbUZunq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVjGpQACgkQJNaLcl1U
h9BAygf+Ovn6WFycjg4a428ShoS3nCtM+10pRkpPcJaruElrjkeYHpktjeD/z29s
VUpUoBIcyJJGDj/Y2CVGz4huMhvjay3x4Ai1UntNQ3E6Kbeqo/cPH21D8kWodRGc
QPjtzbiM8KMpQVR+lECGLwqdwoRFyC7nZu2BAPlp/1LXHzRwzIjDEgUZIXFJ9px8
fYm2d/DDiWCv6/dYDSFrGdul84kRblCGKfojhMtjAbFuZvxNJQIhEpdsXR41idj4
7srmRb9V0dTEcSrNMIZDfMCjfuZvZ90I+ai4PWjaswBfPYPXMMbEEH7UI0WWX/jR
hUMm+k8kdNq/4RpjQyA1PNGQoJwYeA==
=Qq3L
-----END PGP SIGNATURE-----

--uQh9ua/qwEbUZunq--

