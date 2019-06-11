Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 787013D723
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2019 21:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405246AbfFKTq4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Jun 2019 15:46:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:58798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405627AbfFKTq4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 11 Jun 2019 15:46:56 -0400
Received: from earth.universe (unknown [185.62.205.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A97021734;
        Tue, 11 Jun 2019 19:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560282414;
        bh=KmHH51L9OWNGt+JXZgeXpCttosUAXb7SFFEMqYwrEX8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NmpKMBrZAm/zovGDFzVVJNDPkVxtHzZAPEd8JnPShvNCXa8bx/4rGKuOA3joFJkYz
         WmxCy3WPzlCH1oHk9rtzoAzhXDxenGIzxK7Za89waYvOGhM6Eo4u5iZmBF7Aj47f+V
         mJnELLOCK0P1qMJw0ihfgu4xAeCfkx+rDcqi8hZk=
Received: by earth.universe (Postfix, from userid 1000)
        id EF7E33C0C77; Tue, 11 Jun 2019 21:46:51 +0200 (CEST)
Date:   Tue, 11 Jun 2019 21:46:51 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        "Andrew F. Davis" <afd@ti.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Chris Healy <cphealy@gmail.com>,
        Cory Tusar <cory.tusar@zii.aero>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] power: supply: ucs1002: Add HWMON interface
Message-ID: <20190611194651.rmyo4jhdy7xgrgpu@earth.universe>
References: <20190605072323.21990-1-andrew.smirnov@gmail.com>
 <20190605072323.21990-3-andrew.smirnov@gmail.com>
 <d9d8b0c4-e9f4-5a92-3832-3449153f807d@ti.com>
 <CAHQ1cqFRVmZvcFyV93udAHEwZG8NhtM350BSm7JcchNFiqZDjA@mail.gmail.com>
 <20190605183945.GA2442@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="67udbxn3w4jw6xeb"
Content-Disposition: inline
In-Reply-To: <20190605183945.GA2442@roeck-us.net>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--67udbxn3w4jw6xeb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jun 05, 2019 at 11:39:45AM -0700, Guenter Roeck wrote:
> On Wed, Jun 05, 2019 at 10:47:25AM -0700, Andrey Smirnov wrote:
> > On Wed, Jun 5, 2019 at 9:26 AM Andrew F. Davis <afd@ti.com> wrote:
> > >
> > > On 6/5/19 3:23 AM, Andrey Smirnov wrote:
> > > > Expose current sensors found on UCS1002 via HWMON.
> > > >
> > > > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > > > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> > > > Cc: Chris Healy <cphealy@gmail.com>
> > > > Cc: Cory Tusar <cory.tusar@zii.aero>
> > > > Cc: Lucas Stach <l.stach@pengutronix.de>
> > > > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > > > Cc: Guenter Roeck <linux@roeck-us.net>
> > > > Cc: Sebastian Reichel <sre@kernel.org>
> > > > Cc: linux-kernel@vger.kernel.org
> > > > Cc: linux-pm@vger.kernel.org
> > > > ---
> > > >   drivers/power/supply/ucs1002_power.c | 6 ++++++
> > > >   1 file changed, 6 insertions(+)
> > > >
> > > > diff --git a/drivers/power/supply/ucs1002_power.c b/drivers/power/s=
upply/ucs1002_power.c
> > > > index 677f20a4d76f..a4b6b37549cf 100644
> > > > --- a/drivers/power/supply/ucs1002_power.c
> > > > +++ b/drivers/power/supply/ucs1002_power.c
> > > > @@ -571,6 +571,12 @@ static int ucs1002_probe(struct i2c_client *cl=
ient,
> > > >               return ret;
> > > >       }
> > > >
> > > > +     ret =3D devm_power_supply_add_hwmon_sysfs(info->charger);
> > >
> > > Could this be added to the core power supply framework on registering=
 so
> > > all devices get this, vs each driver having to add this line?
> > >
> >=20
> > I'd say it is up to Sebastian to decide if this should be opt-out
> > rather than opt-in. I have no objections to either approach.
> >=20
>=20
> Same here, and agreed.

I think this should be registered in power_supply_register() and
free'd in power_supply_unregister(). It's not device specific at
all and the functionality can be configured via Kconfig.

-- Sebastian

--67udbxn3w4jw6xeb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl0ABScACgkQ2O7X88g7
+pr18hAAok54gDCuCHySN6XdU81SMHYeFoyCmMFGc/1baJdQCmAQmCB3JDcGOMYW
XS6GO/mQprQd6JT9pSj5S9fyVEuOjs0uSo7TU/wJ4UEsNmVhUB6g63uhmmuaaj0S
Xz+l5X9Ih8v/D5agoLimN1KWx3HhGevRpOt2Vpv/frxcOOoICtA0q9KnD2yJdJks
XrWdvDjZuPUps2eqc2mlWk4k17raLs89oMgLzLfw6w5mBJ6vezKT58CTBJX3SMhE
oVR9xfzBCARCrMfPW2T2N7S6/zAUz7pYn5nSTkR3IYSF0InWVq8ithSnMuotA9En
cS040flGqohlHUT74iZngj5zDCMFYVm2hzzYlcwvYDtLZFBug3JiSBGonrLEYOqG
V62gD4dV0Mp5pmOgq6oPO/c9rws0JOtPbHCQj2xeoeiHRyi+zZ9qes6H6DZ2lcBu
2vD5BwEa9ilmrAkxDAe6a9x5JFfZIZB/846/k4v76OVUvvG6R7JCc7LPZ/MMSS+4
NokuvvMg1B/ZjVAd16bkXVjI3i1xN0DFtUnVUrBdUW1ZjDbaHXibNl3qHAXSMdqe
JfvGqpdaeZMUVRt9DGr/I8NRNfdMcEyIMgKo6sNL0L/cEePNdjSW1ThK7J1jz96j
7lWUXz8uP+Owd7y9jzaMMcvldeCXrdMaSoByO3s81DfkZlVWWXE=
=3nYa
-----END PGP SIGNATURE-----

--67udbxn3w4jw6xeb--
