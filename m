Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0A7C1B5DE1
	for <lists+linux-pm@lfdr.de>; Thu, 23 Apr 2020 16:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbgDWOfR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Apr 2020 10:35:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:42368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728036AbgDWOfR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 23 Apr 2020 10:35:17 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC9C620728;
        Thu, 23 Apr 2020 14:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587652516;
        bh=rTNJGPsQUx5fw1XQatvpogr5TI8tvW4SJdwN6KzsVbQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kgd3dSZdZzX0zm4W8ZQ1CAi+zJwzKKzfNBpr5gzaWBcMOU9CXWIqwnKGxkK/S68oF
         DC72b8r1cFWv5yycG8vEoVc6OB1dJxs2BanFkcVhzrXxWcX4IIpTOhp7MHcRUqukfz
         9P8zIN4M89x6wF1Tq6oaEVquMYgjc4Whyjn4Hqlg=
Date:   Thu, 23 Apr 2020 15:35:14 +0100
From:   Mark Brown <broonie@kernel.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     Eugeniu Rosca <erosca@de.adit-jv.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Todd Kjos <tkjos@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-renesas-soc@vger.kernel.org,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [PATCH v5 0/6] driver core: Improve and cleanup
 driver_deferred_probe_check_state()
Message-ID: <20200423143514.GL4808@sirena.org.uk>
References: <20200225050828.56458-1-john.stultz@linaro.org>
 <20200421235836.GA8319@lxhi-065.adit-jv.com>
 <CALAqxLXX455P0V0o11scc3-1MHvecnvcUoT=XBcwB+ma7Kyjqg@mail.gmail.com>
 <20200422075413.GB4898@sirena.org.uk>
 <CALAqxLW13oA376bqj7uTR4E4zmnX5ASK=rpqw3HMr4yOWQGaOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1X+6QtwRodzgDPAC"
Content-Disposition: inline
In-Reply-To: <CALAqxLW13oA376bqj7uTR4E4zmnX5ASK=rpqw3HMr4yOWQGaOw@mail.gmail.com>
X-Cookie: This unit... must... survive.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--1X+6QtwRodzgDPAC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 22, 2020 at 01:45:49PM -0700, John Stultz wrote:
> On Wed, Apr 22, 2020 at 12:54 AM Mark Brown <broonie@kernel.org> wrote:

> > If you're reverting the timeout we should revert the regulator change
> > too I think.

> Maybe? The main issue for me was my change was clearly breaking users
> with dts with missing dependencies where their setup was working
> before. I sort of feel like having a dtb with missing dependencies is
> less valid than wanting to load module dependencies from userland, but
> they were working first, so we have to keep them happy :) And at least
> now the latter can add the timeout boot argument to make it work.

> For your case, I'm not sure if the timeout would run afoul on the nfs
> root mounting case this one tripped over.

Given that it's basically entirely about glitching displays rather than
an unrecoverable break I suspect that anyone using NFS root is some
combination of unaffected or doesn't care if they see the timeout kick
in.

--1X+6QtwRodzgDPAC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6hp6EACgkQJNaLcl1U
h9BAnQf4o2K1oT2OABX/pK3TMNmi6b4KY4XoVJSbuGguI9f01sgsNzhCfw+4txVs
2sUiq++Ug1lckGyW3I56+/ZAYAuQco4kGgHsQ6ME27rl2hnt3Es457jjw2By3rmk
VfCpvUWdq7Zifdq/2tKx2uJgNMWuRy6kPJ4wfwXeSXxLPFk3GvATDcyw7JjA0BMA
Dt4GAC8Y2PFATD0AteC+bBo9JIWR4qs4CZ/1uladh22gWL4cAkCwDXQAKAJnpgbq
ybEXCThDRbUeygV4aZD5yWwNLbyyN6+X+XN3itoIbmqBNiSnDGvILAkYGUNGTPN2
exAfj9tWxY+JKkJTibhLAvmP7bYx
=Gd5+
-----END PGP SIGNATURE-----

--1X+6QtwRodzgDPAC--
