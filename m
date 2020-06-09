Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A30B11F3BB6
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jun 2020 15:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729800AbgFINQE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jun 2020 09:16:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:33190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729787AbgFINQD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 9 Jun 2020 09:16:03 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E788520737;
        Tue,  9 Jun 2020 13:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591708562;
        bh=fn5/yXr+s+Db1jJwZ/m79lFUBemiDJfuNnzHg1lYHVg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pxwzHiXulXcoI9AP55wyvnUrJtLD4+i3+COYPzt2f/GwI7kdH0zz4YBaYDQ6VaPf8
         FJ2dTwvOVj+Sb89FgB21g0H+FeIyrOMUo40gTC11xrTCvFt10WyodxdM6fcHbcgM8M
         gtZWH7SRS1IEnIK1PvET7VXz08RRftT/3FY8pFMU=
Date:   Tue, 9 Jun 2020 14:16:00 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Grant Likely <grant.likely@arm.com>,
        Saravana Kannan <saravanak@google.com>,
        artem.bityutskiy@linux.intel.com, balbi@kernel.org,
        fntoth@gmail.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        peter.ujfalusi@ti.com, rafael@kernel.org, kernel-team@android.com,
        nd <nd@arm.com>, kernel@pengutronix.de
Subject: Re: [PATCH v3] driver core: Break infinite loop when deferred probe
 can't be satisfied
Message-ID: <20200609131600.GE4583@sirena.org.uk>
References: <20200325032901.29551-1-saravanak@google.com>
 <20200325125120.GX1922688@smile.fi.intel.com>
 <295d25de-f01e-26de-02d6-1ac0c149d828@arm.com>
 <20200326163110.GD1922688@smile.fi.intel.com>
 <CGME20200608091722eucas1p2fa8a4ac15c70e5a6e03c4babdf9f96b7@eucas1p2.samsung.com>
 <20200608091712.GA28093@pengutronix.de>
 <437de51b-37e9-d8d1-19c7-137a9265bf45@samsung.com>
 <20200609064511.7nek2rhk6ebfjaia@pengutronix.de>
 <b413d39f-71c4-d291-276d-1087baf07080@samsung.com>
 <20200609121029.nfhgilpu5meoygoa@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6e7ZaeXHKrTJCxdu"
Content-Disposition: inline
In-Reply-To: <20200609121029.nfhgilpu5meoygoa@pengutronix.de>
X-Cookie: Be careful!  Is it classified?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--6e7ZaeXHKrTJCxdu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 09, 2020 at 02:10:29PM +0200, Marco Felsch wrote:
> On 20-06-09 11:27, Andrzej Hajda wrote:
> > On 09.06.2020 08:45, Marco Felsch wrote:
> > > On 20-06-08 13:11, Andrzej Hajda wrote:
> > >> On 08.06.2020 11:17, Marco Felsch wrote:
> > >>> On 20-03-26 18:31, Andy Shevchenko wrote:
> > >>>> On Thu, Mar 26, 2020 at 03:01:22PM +0000, Grant Likely wrote:
> > >>>>> On 25/03/2020 12:51, Andy Shevchenko wrote:
> > >>>>>> On Tue, Mar 24, 2020 at 08:29:01PM -0700, Saravana Kannan wrote:
> > >>>>>>> On Tue, Mar 24, 2020 at 5:38 AM Andy Shevchenko <andriy.shevche=
nko@linux.intel.com> wrote:

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

> > I think rule of=20
> > thumb should be "do not expose yourself, until you are ready", which in=
=20
> > this case means "do not call component_add, until resources are=20
> > acquired" - ie resource acquisition should be performed in probe.

> Hm.. there are is no documentation which forbid this use-case. I thought
> that the component framework bind() equals the driver probe() function..

It does, the issue is perhaps more clearly expressed as saying that a
driver should acquire whatever resources it needs before starting to
make resources available to others, this includes but isn't limited to
registering new device nodes.  This ensures that the users don't then
start trying to use resources and have them torn down underneath them.

> > I use=20
> > this approach mainly to avoid multiple deferred re-probes, but it shoul=
d=20
> > solve also this issue, so even if there will be solution to "deferred=
=20
> > probe issues" in core it would be good to fix imx drivers.

> Pls, see my above comments. It is not only the imx driver. Also we
> shouldn't expect that driver-developers will follow a rule which is
> not written somewhere.

If you've got an idea where this should be documented patches welcome!
I can't think of anywhere sensibly discoverable to put something off the
top of my head.

--6e7ZaeXHKrTJCxdu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7fi48ACgkQJNaLcl1U
h9BAnwf+IQAg6nhT7tQENlmhPWx3FZ4yhQkrwDmGU9T40E0yCtHmLUNcLGsh9kyn
DBlX8hGB51Btbnu0B/0A1HZ5WbI3jRLlZKcweyc2lYeBB+EYCE6QcX8Q/PZPcZc3
HkGMw18pACXYKlOxyFg6HF8Jkx+FyU4ArPyIYTCq9ONdKx/QjJHXrYPoAV/M8WX2
/hlGcoLfh2Zo8R/P/9oCbAqsZ0O4O3JZKKxOoUtLynwCymjgDd88rDsBX/FmmUwN
k7z3zuvZTHwwv9jwDsqHczyv2IwilmWHT2tYFHOz5wmdiJsngQb5+juzyDdf+B8Z
z3yiOvVVzkenkzPDl2y7/qCDurQOxw==
=ln+W
-----END PGP SIGNATURE-----

--6e7ZaeXHKrTJCxdu--
