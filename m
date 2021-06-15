Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F16FD3A7CDF
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jun 2021 13:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbhFOLMf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Jun 2021 07:12:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:49028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230267AbhFOLMf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 15 Jun 2021 07:12:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 92C9461413;
        Tue, 15 Jun 2021 11:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623755431;
        bh=BVwvdKJlsAFOUa8C7K9FOGFeIitS2VDqscgG88QpVno=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TCanDi3FKskMeinmDgQUS5dbBeuCiiNIiPVimXpv30YRQdRyx0mlVFTKamrgR65rF
         1Xa8QzGjpjSTDivynmrvMYZmdYelUj2FVEyvVN/EZeKC0n5GjybolT2KB9F+MGAkGQ
         alrvKrK0Xpj9l6sah6BpOgw5pb/eZAYeR/EkuVRl7/qHw0EP7sQlvTWI/DSpCzjiL+
         F0Hz72UslYw14JPYgzF8sXgajstj1H9igPup96dZVq9H8Owmki5YW46huuWjopWTCt
         VI3ImBfHPGOwdNXSF69DH5V0ZmHiIGCARnmfxVU6fmboiqFNtsA1D0szJMx/9qK39D
         T5QmpDKmfQR6w==
Date:   Tue, 15 Jun 2021 12:10:12 +0100
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
Message-ID: <20210615111012.GA5149@sirena.org.uk>
References: <20210611101540.3379937-1-dmitry.baryshkov@linaro.org>
 <20210611101540.3379937-3-dmitry.baryshkov@linaro.org>
 <CAPDyKFo5mUZZcPum9A5mniYSsbG2KBxqw628M622FaP+piG=Pw@mail.gmail.com>
 <CAA8EJprSj8FUuHkFUcinrbfd3oukeLqOivWianBrnt_9Si8ZRQ@mail.gmail.com>
 <CAPDyKFoMC_7kJx_Wb4LKgxvRCoqHYFtwsJ2b7Cr4OvjA94DtHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
In-Reply-To: <CAPDyKFoMC_7kJx_Wb4LKgxvRCoqHYFtwsJ2b7Cr4OvjA94DtHg@mail.gmail.com>
X-Cookie: See store for details.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 15, 2021 at 12:17:20PM +0200, Ulf Hansson wrote:

> Beyond this, perhaps we should consider removing the
> "regulator-fixed-domain" DT property, as to avoid similar problems
> from cropping up?

> Mark, what do you think?

We need to maintain compatibility for existing users...

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDIipMACgkQJNaLcl1U
h9DTrAf/VYf6JFY3JGZgiPz9e8bdn5EMifv1WiOP9iobtKP2MlR2LH4FJPfT7xiu
AxAQcOuVD9oFSVuQ3FXqVIPxAyBFeAzWVpB6ujNU3PoE9v5dpOkM0El+oEhKlCSY
LhUO6axlcnadMYVG4HyCkQ9jf3fiIBEgyuOXb0fAGoRNDqsSigKPEqdHDOISpPV1
1wsl0JOgb79F4uE4dzVg5a7pAUmxk3G/GJXsnLqGC9A7rzMfc7rjwDKSINXz4Jl+
kVoBA65Eahi8Dhlk7qweSfpugolpraYmHgANZZlCOJiOjhq1CILkCY8Qs+4hjuAf
auGUNhab+3U2j/gvtxZ1n7F2cHsy1w==
=D0bJ
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
