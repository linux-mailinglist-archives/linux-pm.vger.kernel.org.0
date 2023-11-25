Return-Path: <linux-pm+bounces-228-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F737F8C1F
	for <lists+linux-pm@lfdr.de>; Sat, 25 Nov 2023 16:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A86E1C20BD4
	for <lists+linux-pm@lfdr.de>; Sat, 25 Nov 2023 15:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D784E28E29;
	Sat, 25 Nov 2023 15:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vux9YSoM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6458B65C;
	Sat, 25 Nov 2023 15:43:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A61DDC433C7;
	Sat, 25 Nov 2023 15:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700926986;
	bh=BLaPjvfeCQEtXj+kiHkZzzFkV7XfGVeJkjLyuxF4lIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vux9YSoMMru/ZUHMUX8QTeTGSasuvd3Q2Ht1tZttoq8UkrDjOzpmTYs0w6wwkYHB/
	 ZzBFkyJGAiBEPKmS4fMS/CTBO6Cbm+0Nwx7PSWfuv+dEx162Dh4PJfAdr/3F/zmJel
	 r0LxkmflrFHaX2FC6Lr/6DxVzsedp82WUizP1YLIOyfmRjNJb3kMOfUkyJlxWD7qfG
	 SpbF8yS2KIv4MH1k2KafAWP3/C0l6HB7CtBCi89iTQgbe41qfpBzvHG1Yzeuez/Kyz
	 hEJristCVSs6MKW8fipy4oGaRxMWtR6bKQC3yRdQY3S7tI90FXr/XFNTR3i41sulbQ
	 Mh/bj5n3dEd0g==
Date: Sat, 25 Nov 2023 15:43:02 +0000
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	=?iso-8859-1?Q?S=F8ren?= Andersen <san@skov.dk>
Subject: Re: [PATCH v1 0/3] introduce priority-based shutdown support
Message-ID: <ZWIWBhBN8AmK7tAJ@finisterre.sirena.org.uk>
References: <ZWDGGqsCq9iSnHtO@finisterre.sirena.org.uk>
 <2023112435-dazzler-crisped-04a6@gregkh>
 <20231124163234.GC819414@pengutronix.de>
 <2023112453-flagstick-bullring-8511@gregkh>
 <20231124185725.GA872366@pengutronix.de>
 <2023112520-paper-image-ef5d@gregkh>
 <20231125085038.GA877872@pengutronix.de>
 <2023112506-unselfish-unkind-adcb@gregkh>
 <ZWHM0lRPOp/efyD5@finisterre.sirena.org.uk>
 <2023112541-uptown-tripping-05f3@gregkh>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Z8Jjdq+GPR6QIRdJ"
Content-Disposition: inline
In-Reply-To: <2023112541-uptown-tripping-05f3@gregkh>
X-Cookie: Slow day.  Practice crawling.


--Z8Jjdq+GPR6QIRdJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Nov 25, 2023 at 02:35:41PM +0000, Greg Kroah-Hartman wrote:
> On Sat, Nov 25, 2023 at 10:30:42AM +0000, Mark Brown wrote:
> > On Sat, Nov 25, 2023 at 09:09:01AM +0000, Greg Kroah-Hartman wrote:

> > > So hardware is attempting to rely on software in order to prevent the
> > > destruction of that same hardware?  Surely hardware designers aren't
> > > that crazy, right?  (rhetorical question, I know...)

> > Surely software people aren't going to make no effort to integrate with
> > the notification features that the hardware engineers have so helpfully
> > provided us with?

> That would be great, but I don't see that here, do you?  All I see is
> the shutdown sequence changing because someone wants it to go "faster"
> with the threat of hardware breaking if we don't meet that "faster"
> number, yet no knowledge or guarantee that this number can ever be known
> or happen.

The idea was to have somewhere to send notifications when the hardware
starts reporting things like power supplies starting to fail.  We do
have those from hardware, we just don't do anything terribly useful
with them yet.

TBH it does seem reasonable that there will be systems that can usefully
detect these issues but hasn't got a detailed characterisation of
exactly how long you've got before things expire, it's also likely that
the actual bound is going to be highly variable depending on what the
system is up to at the point of detection.  It's quite likely that we'd
only get a worst case bound so it's also likely that we'd have more time
in practice than in spec.  I'd expect characterisation that does happen
to be very system specific at this point, I don't think we can rely on
getting that information.  I'd certainly expect that we have vastly more
systems can usefully detect issues than systems where we have firm
numbers.

> > > > Same problem was seen not only in automotive devices, but also in
> > > > industrial or agricultural. With other words, it is important enough to bring
> > > > some kind of solution mainline.

> > > But you are not providing a real solution here, only a "I am going to
> > > attempt to shut down a specific type of device before the others, there
> > > are no time or ordering guarantees here, so good luck!" solution.

> > I'm not sure there are great solutions here, the system integrators are
> > constrained by the what the application appropriate silicon that's on
> > the market is capable of, the siicon is constrained by the area costs of
> > dealing with corner cases for system robustness and how much of the
> > market cares about fixing these issues and software is constrained by
> > what hardware ends up being built.  Everyone's just got to try their
> > best with the reality they're confronted with, hopefully what's possible
> > will improve with time.

> Agreed, but I don't think this patch is going to actually work properly
> over time as there is no time values involved :)

This seems to be more into the area of mitigation than firm solution, I
suspect users will be pleased if they can make a noticable dent in the
number of failures they're seeing.

> > > And again, how are you going to prevent the in-fighting of all device
> > > types to be "first" in the list?

> > It doesn't seem like the most complex integration challenge we've ever
> > had to deal with TBH.

> True, but we all know how this grows and thinking about how to handle it
> now is key for this to be acceptable.

It feels like if we're concerned about mitigating physical damage during
the process of power failure that's a very limited set of devices - the
storage case where we're in the middle of writing to flash or whatever
is the most obvious case.

--Z8Jjdq+GPR6QIRdJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmViFgEACgkQJNaLcl1U
h9DE8Af+No3v2LuzUEGLnrgZN0ntwjrvTuBs9ai6qr/Qp3ypgRSge5RoCTT85w+u
jqsHcnbg4DPk98rloqJMDx7RDdval38skmuTv02sfWeJLBfAaKCDE0afY2OkCVC5
zzgFREKJZzqLkwtcnmBkWd8l5CrEj4sx86pdHZcImMWZuDj9kU6SOYpXkmAlfHsF
4EC7ORkIZRSpDGX7PjzA5EckbjRxtS0IhFB5EoaH7EoYWCKJyMmajf6t/A8PD7Rf
WM6uRKY56XVevUxpGZXhtIysC0uExUleU4p/v8a7ibc8MqrJtuN1yxuA5noGtuE8
wMQzhVaGADD44NzzpPaQiV2TlZ9XEw==
=GsyE
-----END PGP SIGNATURE-----

--Z8Jjdq+GPR6QIRdJ--

