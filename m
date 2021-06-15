Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3443A83EE
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jun 2021 17:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbhFOP2p (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Jun 2021 11:28:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:36372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230463AbhFOP2o (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 15 Jun 2021 11:28:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4A36760FF0;
        Tue, 15 Jun 2021 15:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623770800;
        bh=RQMXiudVPSpH6wfIxq+VUPwtlfDu0HxJtDbShI6iF/U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UgnMbCLwuzChYeurrAtDkmj0Wb0+3OS+IGq5iU90jNn45JfJol/dIArN7LmFX4CPD
         ADHjDDHRK34Js0/3wosKOUSnpUEsEsJQ2nljwicWm+T1VVcaKOpWhh0qhHMKU93e1A
         57cz56FXz35zVcHA+ROCi1GuuiTNYeGtOt/RgDuknq7h5RyDANKTPf3mfc2kNTwlXI
         jm5JROMMuM7VLrE3puAu6OPxiFB8qM22nD3LtWY40tmZa7iPRYoZ3iUvkaJPiGQJw7
         GoLXz0wQgHGe5A79utFI7tPJlSRcxdNbYk6SWb2r8DKYC7dONy5eAV9X1G+KFIkBFI
         SKACX0gd44kAg==
Date:   Tue, 15 Jun 2021 16:26:21 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] PM: domain: use per-genpd lockdep class
Message-ID: <20210615152620.GH5149@sirena.org.uk>
References: <20210611101540.3379937-1-dmitry.baryshkov@linaro.org>
 <20210611101540.3379937-3-dmitry.baryshkov@linaro.org>
 <CAPDyKFo5mUZZcPum9A5mniYSsbG2KBxqw628M622FaP+piG=Pw@mail.gmail.com>
 <CAA8EJprSj8FUuHkFUcinrbfd3oukeLqOivWianBrnt_9Si8ZRQ@mail.gmail.com>
 <CAPDyKFoMC_7kJx_Wb4LKgxvRCoqHYFtwsJ2b7Cr4OvjA94DtHg@mail.gmail.com>
 <20210615111012.GA5149@sirena.org.uk>
 <CAPDyKFreV-RPzweG8SqFQtvZMOyFbaG2+tMFKc2JkbEj+erb=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AqCDj3hiknadvR6t"
Content-Disposition: inline
In-Reply-To: <CAPDyKFreV-RPzweG8SqFQtvZMOyFbaG2+tMFKc2JkbEj+erb=g@mail.gmail.com>
X-Cookie: See store for details.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--AqCDj3hiknadvR6t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 15, 2021 at 04:55:24PM +0200, Ulf Hansson wrote:
> On Tue, 15 Jun 2021 at 13:10, Mark Brown <broonie@kernel.org> wrote:
> > On Tue, Jun 15, 2021 at 12:17:20PM +0200, Ulf Hansson wrote:

> > > Beyond this, perhaps we should consider removing the
> > > "regulator-fixed-domain" DT property, as to avoid similar problems
> > > from cropping up?

> > > Mark, what do you think?

> > We need to maintain compatibility for existing users...

> Normally, yes, I would agree.

> In this case, it looks like there is only one user, which is somewhat
> broken in regards to this, so what's the point of keeping this around?

Only one user in mainline and you were just suggesting removing the
property (you mean binding I think?) - at the very least we'd need to
transition that upstream user away to something else before doing
anything.

--AqCDj3hiknadvR6t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDIxpwACgkQJNaLcl1U
h9CjvQf/ZtO5g8Vauy1TwetzYXVFnoVsisCUiyhX/D5CXU0hLQIKFPPAxx5gqOCd
UAkVyyCPtCZS6a81dpQou5nrlB/xxa+fafbbHmszxCHMnlYLHe48KsbOUtCeTCVW
a0KaDBH26WeNQc9YJ5BEANBdi5ddUYog95M6tBhUuf8588jwNM+SVklhepZEcKGe
jdoUSOXdx5rh2+r0uaM3DsTP4Wq9gwrNZaMHQjSG8EoGWum0siwdxX6qUtwTezol
OXLYHMdC6fkYTLDd/W6jr0qxBuQEQP6nQnV7aBkWqklxtNbYxq2ep9OA5mY5DFbN
NLIIzxhA+NDD327u2oo/xTAn2TAMZA==
=Wq07
-----END PGP SIGNATURE-----

--AqCDj3hiknadvR6t--
