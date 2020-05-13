Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49B311D1064
	for <lists+linux-pm@lfdr.de>; Wed, 13 May 2020 13:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbgEMLAm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 May 2020 07:00:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:38684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726020AbgEMLAm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 13 May 2020 07:00:42 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4126620659;
        Wed, 13 May 2020 11:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589367641;
        bh=mJieOJy4NuNu/AlkpFgPMFAFRaWameJ9hJz3cvTR6Rg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=brO0OdFVV61zzKDNRCseKslcHhi9HdP0gLpKT/nqq43rZjoG1p0YRENXP/T8XDOMU
         ZGRuLptLqt1mNM8tlPZ8dj45gRsFNqSQXQkRt6Ju8MSb40kLPfT286TVnaaBt5Y5y7
         CKZK0bs7oNwAeXcyYG9y9va8SpXOtcX7IDaytPfw=
Date:   Wed, 13 May 2020 12:00:39 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "open list:ALLWINNER CPUFREQ DRIVER" <linux-pm@vger.kernel.org>,
        Steven Price <steven.price@arm.com>
Subject: Re: Question about OPP regulator for Panfrost Devfreq
Message-ID: <20200513110039.GD4803@sirena.org.uk>
References: <CAJiuCce9ZxeXnQzEW_3dbBDNZmmtWmKeft0hX+F9+SYu80NU=Q@mail.gmail.com>
 <20200511052530.iazkduojnba3abil@vireshk-i7>
 <CAJiuCcfRmDbBxEms=HAFQhaiBTznEd1of3TOcnAAc2yuTq0XtA@mail.gmail.com>
 <20200513054601.nvwsjhk6i4bjmgt7@vireshk-i7>
 <CAJiuCccd+ycnmirL7chtMom0uqbQ8cX9VQf_ZAvhzTto9VSDbA@mail.gmail.com>
 <20200513091922.qnpjx4kw2m3jv2ry@vireshk-i7>
 <20200513101805.GA4803@sirena.org.uk>
 <20200513104015.oyiaimjpspablq5p@vireshk-i7>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bajzpZikUji1w+G9"
Content-Disposition: inline
In-Reply-To: <20200513104015.oyiaimjpspablq5p@vireshk-i7>
X-Cookie: Long life is in store for you.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--bajzpZikUji1w+G9
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2020 at 04:10:15PM +0530, Viresh Kumar wrote:
> On 13-05-20, 11:18, Mark Brown wrote:
> > On Wed, May 13, 2020 at 02:49:22PM +0530, Viresh Kumar wrote:

> > > @Mark: Regarding enabling/disabling regulators from the OPP core, what

> > My name is spelt Mark.

> Hmm. But isn't that what I wrote ? I used @ as that's what people use
> to address questions to someone. :)

No, it isn't what people use to address a question to someone.  Some
social media uses it to prefix usernames but email is not one of those
systems.  If anything it makes it *less* likely that people will see
things as people mostly read by pattern matching the shapes of words
(especially when scanning) rather than spelling out individual letters.

> > As ever if you have requirements for the voltage of a regulator you
> > should use regulator_set_voltage() to tell the core about it.  The core
> > cannot be expected to infer these requirements without being told by the
> > users.  If you need the voltage to be a particular level when you enable
> > the regulator you should set that voltage.  Why can't the code do that
> > instead of trying to add these complex and fragile bodges?  Randomly
> > skipping applying configurations some of the time is not going to make
> > anything more robust or easier to understand.

> Right.

> Cl=E9ment is facing a problem where his regulator isn't getting enabled
> and he was asking why the OPP core can't call regulator_enable(), when
> it handles everything else around them. Can you suggest to him on what
> he should be doing here ?

The OPP code can and should be calling regulator_enable().  If the OPP
code needs some particular voltage configuration it can and should be
calling regulator_set_voltage() to tell the core what it needs.  What
I'm saying is that if when the OPP code enables the regulator it needs
a particular voltage configuration it should tell the core about that
prior to enabling.

--bajzpZikUji1w+G9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6701YACgkQJNaLcl1U
h9D9Iwf/ZeF6i/4k13G51G9vQt/ywxZ2fIQa7BoUTg/ZFq8UnkyT82wef1cny7kE
0SzsCxNepppDzU7pA8pb/uKD9tO8RP3iFPG/FgA27h7/psaClT2W6wAln9pYJei8
T0YVDUSu0M81P5S+1NZJNUVFPSUgYyrgKaidLiZen0QlGkzL8BAWbegf+nArs7mp
EbLjAHE0Xj74PszM3iqoNslNa7k9WvoKUvFMtKeFssCYcVRcP4FdMUYOheezhVgM
IL6TnhtpTocBjKHcneT2AZ3cxR0jGRuDvje/aVH8j0w7GI5DzWFRk6tIdD0s+6hM
o9EJbKAGqjtlL7FcNWR2/ythKo8oYQ==
=KRLW
-----END PGP SIGNATURE-----

--bajzpZikUji1w+G9--
