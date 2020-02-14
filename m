Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABAC115D6CB
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2020 12:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbgBNLrx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Feb 2020 06:47:53 -0500
Received: from foss.arm.com ([217.140.110.172]:60130 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728004AbgBNLrw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 14 Feb 2020 06:47:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE7F91045;
        Fri, 14 Feb 2020 03:47:51 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 719253F68F;
        Fri, 14 Feb 2020 03:47:51 -0800 (PST)
Date:   Fri, 14 Feb 2020 11:47:49 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "Laine, Markus" <Markus.Laine@fi.rohmeurope.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "sre@kernel.org" <sre@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [RFC PATCH 2/3] power: (regmap:) Add linear_range helper
Message-ID: <20200214114749.GB4827@sirena.org.uk>
References: <cover.1581327762.git.matti.vaittinen@fi.rohmeurope.com>
 <20b107ac6e40206b82d014a145abe0569d7a6f81.1581327762.git.matti.vaittinen@fi.rohmeurope.com>
 <20200211190614.GP4543@sirena.org.uk>
 <cb9ed43aafcd8e1f6af05bfec8108ee8c14af265.camel@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Pd0ReVV5GZGQvF3a"
Content-Disposition: inline
In-Reply-To: <cb9ed43aafcd8e1f6af05bfec8108ee8c14af265.camel@fi.rohmeurope.com>
X-Cookie: Shipping not included.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--Pd0ReVV5GZGQvF3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 12, 2020 at 06:56:37AM +0000, Vaittinen, Matti wrote:
> On Tue, 2020-02-11 at 19:06 +0000, Mark Brown wrote:

> > Note also that we already have quite extensive helpers for this sort
> > of
> > stuff in the regulator API which I sense may have been involved in
> > this
> > implementation

> You sense well xD

If you're factoring stuff out of an existing implementation it'd be good
to explicitly do that - this both shows where things came from and also
means that you can show that the existing user works with the new code
which is good.

> But another option - which I thought only now - would be to see if
> current regulator implementation could be re-named to more generic and
> placed under some more generic component (I thought of regmap but as
> you pointed out this is equally usefull for devices connected to memory
> mapped buses - so maybe under lib - if static inline functions in a
> header are not a good option). I just have a feeling that the linear-
> ranges is currently kind of embedded in the code which is internal to
> regulator framework so it is probably not easily extracted from
> regulator code?

It is a bit but I think that's solvable with some refactoring in place
(eg, pushing things into a smaller struct embedded in the main regulator
one and then moving them out).  I might look at it myself if nobody else
gets to it first...

> So if we do not start pulling the range code out of regulator framework
> (for now at least) - and if we do not place this under regmap - then I
> can drop you out of the recipient list for this charger driver in order
> to not pollute your inbox ;) How do you feel Mark, do you want to be
> following this series?

Well, if there's a refactoring out of the regulator code going on I'll
need to look at that anyway.

--Pd0ReVV5GZGQvF3a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5GiOUACgkQJNaLcl1U
h9ACeAf8DB2xRPKGrvFQ8dGG0zRPuFif0voo7h906pgsLKrxhw1RdAS6b0hf2/Vf
kgaDDlXcG5xbcnXivGAh1rK/l58zaUNsEWIGg0vhkwIHajdX5qqn5lspqrSj8JT/
xo0LuYHy7Nki0SdRUgulm85zbaO6tbjqZFiLwaFDY0ZmaOH1tCbmxAD8BHweJltX
cHfajZQO9UIjSOc46qfetMGchng6pdu+TAsc7SywjwqHQis2xKjcuZSiunjpMlwA
Ixe4rx2+fbsyx9Zn1VqU7nr8JMlwILt78mrLNlKq4/6XbLAb4BCmwHvzFLe89Z7B
6ALKhYNedwGJ0oe3fI6OvNl5a/H2uA==
=6GmO
-----END PGP SIGNATURE-----

--Pd0ReVV5GZGQvF3a--
