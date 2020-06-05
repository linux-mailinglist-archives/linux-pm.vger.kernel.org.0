Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECAC1F036C
	for <lists+linux-pm@lfdr.de>; Sat,  6 Jun 2020 01:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbgFEXQk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Jun 2020 19:16:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:47478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728395AbgFEXQk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 5 Jun 2020 19:16:40 -0400
Received: from earth.universe (dyndsl-037-138-189-219.ewe-ip-backbone.de [37.138.189.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54C43206FA;
        Fri,  5 Jun 2020 23:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591398999;
        bh=YpO0ziCFITwHaA//k7RmpclogVpHY5ll6fncvpnpQGw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rwdjnm99jpZI/RubWJBL6SCnXnAk8oMJ8JQu+/1BbDByQE0b+uE9/8hnDhfsOMyD9
         OR6lL4SBBLXSrnorYT6TCbWb9FicgZ8loyf/osk2ShPIB96YMzrkzLVd+goUpXT53F
         wOWSbI4G2m5JQp0RX4dEuknZL/Pu75MSZzoK6yoE=
Received: by earth.universe (Postfix, from userid 1000)
        id B42313C08C7; Sat,  6 Jun 2020 01:16:37 +0200 (CEST)
Date:   Sat, 6 Jun 2020 01:16:37 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Tobias Schramm <t.schramm@manjaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pm@vger.kernel.org, kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v1] power: supply: cw2015: Attach OF ID table to the
 driver
Message-ID: <20200605231637.eo42zqryv2d7i7ae@earth.universe>
References: <20200530164030.47884-1-andriy.shevchenko@linux.intel.com>
 <6f53c126-c0e2-8869-26c0-c2ba1e8adbf1@manjaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3egqp3jog7rjf5fc"
Content-Disposition: inline
In-Reply-To: <6f53c126-c0e2-8869-26c0-c2ba1e8adbf1@manjaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--3egqp3jog7rjf5fc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, May 30, 2020 at 07:00:47PM +0200, Tobias Schramm wrote:
> Hi Andy,
>=20
> > diff --git a/drivers/power/supply/cw2015_battery.c b/drivers/power/supp=
ly/cw2015_battery.c
> > index 19f62ea957ee..0146f1bfc29b 100644
> > --- a/drivers/power/supply/cw2015_battery.c
> > +++ b/drivers/power/supply/cw2015_battery.c
> > @@ -734,6 +734,7 @@ MODULE_DEVICE_TABLE(of, cw2015_of_match);
> >  static struct i2c_driver cw_bat_driver =3D {
> >  	.driver =3D {
> >  		.name =3D "cw2015",
> > +		.of_match_table =3D cw2015_of_match,
> >  		.pm =3D &cw_bat_pm_ops,
> >  	},
> >  	.probe_new =3D cw_bat_probe,
> >=20
>=20
> LGTM.
>=20
> Acked-By: Tobias Schramm <t.schramm@manjaro.org>
> Tested-By: Tobias Schramm <t.schramm@manjaro.org>

Thanks, queued.

-- Sebastian

--3egqp3jog7rjf5fc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl7a0lUACgkQ2O7X88g7
+pprvQ/9GOsfKru1RcuaqCETghQ4zNEZxAJVmdvTjvhk/d/rulE42Dth5d1YCPSw
Pwa44Cdodz1vTJ7qAowfInlSTfDMttIjsB5jjWgGvz1hBEhJ4XCBeuG33sIXg630
gCn/sLWMJq1uWTHoj1WL1gM8uqI9XM3LLB1SO3VrnSa6bvwV79Gr7wF0CSkGBE+W
T/Tq72Jo/khM3Owap+eGdNdRr70/vQsu5VdAQh72KC4lNBO5P5yV+oqZ7DSlrInE
2jvptKFqYw5D/t82Fm+6alqc3paHqNHZJZdzW4NOM+eTHMzlXoSr4NSa+mLVdRTU
jm9D2DSbFf+gs1dxlqWPE7BvxLqDpVw1wm+Nw23i8KhHPmMc/3qKWz6MuDGUj0Qm
NPDYrv7m2QlQF8K4v28ffyt4+afMnufr8YYb1Y+TJsLh7h6LNirMzZsmaKF5dnyQ
DPk8caCKCJiUrq22lJ1Ec+NV5xyUH410E2Qxz6hQ3BsESYN+aSp1zemqrtPhVFfA
kSZrTQpIYujz4tz/hm4KmPqhtRrplZuQGxaWUMKdPotn0mmBAtnYuH9JXuXfZq3D
sunOPxlnYJM9oRv4aPqca0CHkVanScDmp7CCwHmr8Yr8a9keNjeMtk71jSDXv1fL
in6zw19xlbWG/QKUShSLCZmvePAXGQ/Q0Z13LJyd4cCvKrKh8xE=
=RKRO
-----END PGP SIGNATURE-----

--3egqp3jog7rjf5fc--
