Return-Path: <linux-pm+bounces-212-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12AA07F89ED
	for <lists+linux-pm@lfdr.de>; Sat, 25 Nov 2023 11:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C02A1C20BD4
	for <lists+linux-pm@lfdr.de>; Sat, 25 Nov 2023 10:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532B3211A;
	Sat, 25 Nov 2023 10:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQ0NDYAJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31536F9D2;
	Sat, 25 Nov 2023 10:30:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04F50C433C8;
	Sat, 25 Nov 2023 10:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700908245;
	bh=8M+nJvP3Pc02QBXEzHmQFiKyIaya/XkVZIIRM9foMfw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FQ0NDYAJfjaISX94FgEp8BBEXq6kVCoCIaQFOtPxwoUHwrTqO5a6BKo9odLqKeUc2
	 plyGL6jWtFx/fjYjUuCLoxuZWigXAd3jCYndMzSd5ZZexdN1wia30WP0neeVpkDfe7
	 nhAMBhLBP3F0V9S1rFittgifIzoZtljJRvloQZK7DA0P4XfWe2UUQ88s35ihaC2bRi
	 WzQwIs06ogw0Bn9655oxUIiJlT6rwexfCtABQPptnpu16Vj0Ejtghaxl7PzNACtHGt
	 8/cERrrpDU9aYFtdUVySNJbLMG+KNbhAJFfRg/l9aiBoEWZDyX1lYQXxqME7HKxMqK
	 sZh79yTv6ysLQ==
Date: Sat, 25 Nov 2023 10:30:42 +0000
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	=?iso-8859-1?Q?S=F8ren?= Andersen <san@skov.dk>
Subject: Re: [PATCH v1 0/3] introduce priority-based shutdown support
Message-ID: <ZWHM0lRPOp/efyD5@finisterre.sirena.org.uk>
References: <ZWC/hKav0JANhWKM@finisterre.sirena.org.uk>
 <2023112458-stature-commuting-c66f@gregkh>
 <ZWDGGqsCq9iSnHtO@finisterre.sirena.org.uk>
 <2023112435-dazzler-crisped-04a6@gregkh>
 <20231124163234.GC819414@pengutronix.de>
 <2023112453-flagstick-bullring-8511@gregkh>
 <20231124185725.GA872366@pengutronix.de>
 <2023112520-paper-image-ef5d@gregkh>
 <20231125085038.GA877872@pengutronix.de>
 <2023112506-unselfish-unkind-adcb@gregkh>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OWCscLjJZThyBHJJ"
Content-Disposition: inline
In-Reply-To: <2023112506-unselfish-unkind-adcb@gregkh>
X-Cookie: Slow day.  Practice crawling.


--OWCscLjJZThyBHJJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Nov 25, 2023 at 09:09:01AM +0000, Greg Kroah-Hartman wrote:
> On Sat, Nov 25, 2023 at 09:50:38AM +0100, Oleksij Rempel wrote:

> > It prevents HW damage. In a typical automotive under-voltage labor it is
> > usually possible to reproduce X amount of bricked eMMCs or NANDs on Y
> > amount of under-voltage cycles (I do not have exact numbers right now).
> > Even if the numbers not so high in the labor tests (sometimes something
> > like one bricked device in a month of tests), the field returns are
> > significant enough to care about software solution for this problem.

> So hardware is attempting to rely on software in order to prevent the
> destruction of that same hardware?  Surely hardware designers aren't
> that crazy, right?  (rhetorical question, I know...)

Surely software people aren't going to make no effort to integrate with
the notification features that the hardware engineers have so helpfully
provided us with?

> > Same problem was seen not only in automotive devices, but also in
> > industrial or agricultural. With other words, it is important enough to bring
> > some kind of solution mainline.

> But you are not providing a real solution here, only a "I am going to
> attempt to shut down a specific type of device before the others, there
> are no time or ordering guarantees here, so good luck!" solution.

I'm not sure there are great solutions here, the system integrators are
constrained by the what the application appropriate silicon that's on
the market is capable of, the siicon is constrained by the area costs of
dealing with corner cases for system robustness and how much of the
market cares about fixing these issues and software is constrained by
what hardware ends up being built.  Everyone's just got to try their
best with the reality they're confronted with, hopefully what's possible
will improve with time.

> And again, how are you going to prevent the in-fighting of all device
> types to be "first" in the list?

It doesn't seem like the most complex integration challenge we've ever
had to deal with TBH.

--OWCscLjJZThyBHJJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVhzM4ACgkQJNaLcl1U
h9Bczwf/ZOauVf2ZNMl+9um4sb53WEKA1gMNKZK4K6HTICY1ZeM6/Ke3rWF5ygNQ
upPZi5ZTDR2iTnbeTkX3vM5IuY4msSWko+SZIaxLGXB+2d0mCXyTMb5tkfevq5Ky
A6yjp5D6c9axsfQPPH5xsddudfHMdnbTXmgrwoYZeesZxLUoUH5O9QQwvqvEGkuT
0LdWzipZ6EsJVl8HNzGbomkA6CApfVz9GoS2FqKt3NS8BHwh4Ye35HiD0/b6UyCH
7aaeg0ai6ws+XN7w2PxNewkVhKkwTpOM46OPP01wjwve8qvzsjZMBQtHupMw785o
/wV5S99o4IIR7iGqW31jmfgb3RUyiA==
=JVcw
-----END PGP SIGNATURE-----

--OWCscLjJZThyBHJJ--

