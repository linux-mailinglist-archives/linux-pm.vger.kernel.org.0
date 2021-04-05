Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58634353C5C
	for <lists+linux-pm@lfdr.de>; Mon,  5 Apr 2021 10:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbhDEIXe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Apr 2021 04:23:34 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56792 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhDEIXe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Apr 2021 04:23:34 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 012561F44ABA
Received: by earth.universe (Postfix, from userid 1000)
        id 7954A3C0C96; Mon,  5 Apr 2021 10:23:25 +0200 (CEST)
Date:   Mon, 5 Apr 2021 10:23:25 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Carl Philipp Klemm <philipp@uvos.xyz>, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Arthur Demchenkov <spinal.by@gmail.com>,
        Merlijn Wajer <merlijn@wizzup.org>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 5/5] power: supply: cpcap-charger: Add usleep to cpcap
 charger to avoid usb plug bounce
Message-ID: <20210405082325.3a4uqgyf4qie2vbu@earth.universe>
References: <20210117224853.3602368391c9785e74748239@uvos.xyz>
 <YGlpCr26qU6F/Uwl@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2oyjihuqahnkx7yh"
Content-Disposition: inline
In-Reply-To: <YGlpCr26qU6F/Uwl@atomide.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--2oyjihuqahnkx7yh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Apr 04, 2021 at 10:21:46AM +0300, Tony Lindgren wrote:
> * Carl Philipp Klemm <philipp@uvos.xyz> [210117 23:48]:
> > Adds 80000 us sleep when the usb cable is plugged in to hopefully avoid
> > bouncing contacts.
> >=20
> > Upon pluging in the usb cable vbus will bounce for some time, causing c=
pcap to
> > dissconnect charging due to detecting an undervoltage condition. This i=
s a
> > scope of vbus on xt894 while quickly inserting the usb cable with firm =
force,
> > probed at the far side of the usb socket and vbus loaded with approx 1k:
> > http://uvos.xyz/maserati/usbplug.jpg.
> >=20
> > As can clearly be seen, vbus is all over the place for the first 15 ms =
or so
> > with a small blip at ~40 ms this causes the cpcap to trip up and disable
> > charging again.
> >=20
> > The delay helps cpcap_usb_detect avoid the worst of this. It is, howeve=
r, still
> > not ideal as strong vibrations can cause the issue to reapear any time =
during
> > charging. I have however not been able to cause the device to stop char=
ging due
> > to this in practice as it is hard to vibrate the device such that the v=
bus pins
> > start bouncing again but cpcap_usb_detect is not called again due to a =
detected
> > disconnect/reconnect event.
> >=20
> > Signed-off-by: Carl Philipp Klemm <philipp@uvos.xyz>
>=20
> This patch fixes an issue where connecting a charger often fails for me:
>=20
> Tested-by: Tony Lindgren <tony@atomide.com>

Thanks, queued.

-- Sebastian

> > ---
> >  drivers/power/supply/cpcap-charger.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >=20
> > diff --git a/drivers/power/supply/cpcap-charger.c b/drivers/power/suppl=
y/cpcap-charger.c
> > index be7d1da7a5a5..3e5fbdbdd645 100644
> > --- a/drivers/power/supply/cpcap-charger.c
> > +++ b/drivers/power/supply/cpcap-charger.c
> > @@ -650,6 +650,9 @@ static void cpcap_usb_detect(struct work_struct *wo=
rk)
> >  		return;
> >  	}
> > =20
> > +	/* Delay for 80ms to avoid vbus bouncing when usb cable is plugged in=
 */
> > +	usleep_range(80000, 120000);
> > +
> >  	/* Throttle chrgcurr2 interrupt for charger done and retry */
> >  	switch (ddata->status) {
> >  	case POWER_SUPPLY_STATUS_CHARGING:
> > --=20
> > 2.29.2
> >=20

--2oyjihuqahnkx7yh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmBqyP0ACgkQ2O7X88g7
+po/ug//YcLANSAYucd6FCtQ6Reb+hK1JN0XpFx82V4ULVTxFOjc8q8n7FRMg0fe
Z117ErR76DnBMD+zkEoEhJ/8E9Bz10IrKKoOg12/vauypLCjewFanaEMxdGOg+yA
gBY+wSReWz28BDXUgMLrArZZdOD9+mJN5AO5asFQymkYPRfFKsRjZyUYyyT8yoy1
RzUtzza6gWTLQ5w4wnyRrlpP7tr6uqHizRtuIPQcSTR1wFmeRgl95jB29ZUApnFK
yZL+IYv8HRf3XQSdHfwfrNytgTC1WyRmj7jXNhtu0tKVlBCp/ugheXY00zzFAFSo
WDq530BSDOws3v+hHWTgm6PNyOtA+gJi13gW8t7P7siYOqscijHs3yTr3JlWbhpl
9eR349ceOmbkqzoxNpI/TuWmiO23Zd/E37a+fCrgB0z7nH4I7PdWQdlYbPN6rKMd
qp3EMFR4mvDVYN8FzpycnbAPw9tjpE9bteVEQEvGL87Bf1kc6B3n37sEgIw8nbLT
Zp7PT3w66zx6GgjTmPGHMxVbCb8QUMYR/lXjEeaky6vcuXHZp0MFuI8lXEAO/yaR
ppa4f7GPM2c34Ep+594NLi4VSciQGKwFNzVAOaBKg8VruogKXkwp7uWhM0Wtltpd
DiG7Og2UisJxzr//PERRRk1vPWgm+IXDEWnN3jdXKZoRdpPj18Y=
=1w2V
-----END PGP SIGNATURE-----

--2oyjihuqahnkx7yh--
