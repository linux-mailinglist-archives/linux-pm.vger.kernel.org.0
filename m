Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFE5CF20D0
	for <lists+linux-pm@lfdr.de>; Wed,  6 Nov 2019 22:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfKFV3i (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Nov 2019 16:29:38 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:56578 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbfKFV3i (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Nov 2019 16:29:38 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 9B5A81C09B6; Wed,  6 Nov 2019 22:29:36 +0100 (CET)
Date:   Wed, 6 Nov 2019 22:29:21 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        Akinobu Mita <akinobu.mita@gmail.com>,
        linux-pm@vger.kernel.org, Chris Healy <cphealy@gmail.com>
Subject: Re: [PATCH v2] nvme: Add hardware monitoring support
Message-ID: <20191106212921.GA7020@amd>
References: <20191029223214.18889-1-linux@roeck-us.net>
 <20191030005327.GC15332@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
In-Reply-To: <20191030005327.GC15332@redsun51.ssa.fujisawa.hgst.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > nvme devices report temperature information in the controller informati=
on
> > (for limits) and in the smart log. Currently, the only means to retrieve
> > this information is the nvme command line interface, which requires
> > super-user privileges.
> >=20
> > At the same time, it would be desirable to use NVME temperature informa=
tion
> > for thermal control.
> >=20
> > This patch adds support to read NVME temperatures from the kernel using=
 the
> > hwmon API and adds temperature zones for NVME drives. The thermal subsy=
stem
> > can use this information to set thermal policies, and userspace can acc=
ess
> > it using libsensors and/or the "sensors" command.
> >=20
> > Example output from the "sensors" command:
> >=20
> > nvme0-pci-0100
> > Adapter: PCI adapter
> > Composite:    +39.0=B0C  (high =3D +85.0=B0C, crit =3D +85.0=B0C)
> > Sensor 1:     +39.0=B0C
> > Sensor 2:     +41.0=B0C
> >=20
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>=20
> This looks fine to me, but I'll wait a few more days to see if there are
> any additional comments..

User wants to know temperature of /dev/sda... and we already have an
userspace tools knowing about smart, etc...

pavel@amd:/data/film$ sudo hddtemp /dev/sda
/dev/sda: ST1000LM014-1EJ164: 48=B0C

I see we also have sensors framework but it does _not_ handle
harddrive temperatures.

Does it need some kind of unification? Should NVMe devices expose
"SMART" information in the same way other SSDs do?

Best regards,
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl3DOzEACgkQMOfwapXb+vIMvACfQ4av1AszPWgW7jbyZuTg6fmz
a2EAoIkF7v4EygABLAACFFwF9dxY14dS
=o7Jq
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
