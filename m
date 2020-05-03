Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8AA1C2925
	for <lists+linux-pm@lfdr.de>; Sun,  3 May 2020 02:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgECAJ0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 2 May 2020 20:09:26 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:44372 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbgECAJZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 2 May 2020 20:09:25 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 322D92A0590
Received: by earth.universe (Postfix, from userid 1000)
        id 022D33C08C7; Sun,  3 May 2020 02:09:21 +0200 (CEST)
Date:   Sun, 3 May 2020 02:09:21 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 2/4] power: supply: core: add input voltage/current
 measurements
Message-ID: <20200503000921.6krrkai7onsba2uz@earth.universe>
References: <cover.1588345420.git.mirq-linux@rere.qmqm.pl>
 <249d7ad42b02bfeb8c31c49a64ee92b3e745086d.1588345420.git.mirq-linux@rere.qmqm.pl>
 <20200502222349.tfa72nr5zunybpla@earth.universe>
 <20200502224526.GA25127@qmqm.qmqm.pl>
 <20200502231158.GB25127@qmqm.qmqm.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wwkc4zuembsuqcjr"
Content-Disposition: inline
In-Reply-To: <20200502231158.GB25127@qmqm.qmqm.pl>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--wwkc4zuembsuqcjr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, May 03, 2020 at 01:11:58AM +0200, Micha=C5=82 Miros=C5=82aw wrote:
> On Sun, May 03, 2020 at 12:45:26AM +0200, Micha=C5=82 Miros=C5=82aw wrote:
> > On Sun, May 03, 2020 at 12:23:49AM +0200, Sebastian Reichel wrote:
> > > On Fri, May 01, 2020 at 05:11:18PM +0200, Micha=C5=82 Miros=C5=82aw w=
rote:
> [...]
> > > > --- a/include/linux/power_supply.h
> > > > +++ b/include/linux/power_supply.h
> > > > @@ -127,7 +127,9 @@ enum power_supply_property {
> > > >  	POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX,
> > > >  	POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD, /* in percents!=
 */
> > > >  	POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD, /* in percents! */
> > > > +	POWER_SUPPLY_PROP_INPUT_CURRENT_NOW,
> > >=20
> > > What:           /sys/class/power_supply/<supply_name>/current_avg   =
=20
> > > Date:           May 2007
> > > Contact:        linux-pm@vger.kernel.org                         =20
> > > Description:                 =20
> > >                 Reports an average IBUS current reading over a fixed =
period.  =20
> > >                 Normally devices will provide a fixed interval in whi=
ch they  =20
> > >                 average readings to smooth out the reported value.   =
         =20
> > >                                                                      =
          =20
> > >                 Access: Read   =20
> > >                 Valid values: Represented in microamps
> > >=20
> >=20
> > There are two entries for /sys/class/power_supply/<supply_name>/current=
_avg
> > in the file, the other one mentions IBAT instead. "voltage_now" has the
> > same problem.
> [...]
>=20
> So the general idea of the sysfs API seems to require separate devices fo=
r the
> input (charger) and battery elements.
>
> Since what I'm looking at is an integrated battery controller
> (bq25896) which has three connections: an USB power (VBUS), a
> battery and the system load, but it creates only a single
> power-class device.

power-supply exposes either TYPE_MAINS/TYPE_USB or TYPE_BATTERY.
If a device is combined function, then it should register two
power-supply devices.

> This is complicated by the fact that this is an OTG device and so
> it can sink or source VBUS power.

Ok.

-- Sebastian

--wwkc4zuembsuqcjr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl6uC6wACgkQ2O7X88g7
+ppcRA//UIFhxQTftT9jUww7uCRqVy59YKRey2qkQpr6H4jn47RcVYCpVe82p0sZ
Mxg2BF9LyMMquAtFXWK4sTtiCcPjklf7yd5kAl97cxy5WF9FZmBkbiAxvVdXSFmn
i2Gt43SzzWoGHW3155UYr3DMwX0K/eK4HUKAfxTmGP25EXhYPmetMff6Oz5KDP1s
EUt8QRn34K0Sc8nnb5Kxye161bCVn0dnI+Q1zAtAwAs1GCoPrluHK0Pnb60Ye/TE
8K/8zh4HHXwtRa51M+qsLQRIzoompZK5JS2b9FTAOeUpiyDCG6OCunkjpjrGKzXi
ea0afXbhltswYrUlBhbBqsrkPewqCYpaWdwwcVpntwjtTqY9rhFeSlLLbcfJFtOD
RypG6ob3leVakXodCbU4KQQjMkOv5rka6/2o9tJijwetQ1IUnSW8WqecPTBY2Rkk
F3U4tZGieL9P1DPiheb9XhQmnnUtATrAGtDS8LHOtNqgCdFLPA/oVCqQCl6I3bmz
mWHev2TtyXeTnFVH+QL6FtssYq+6J1cR4t0aqXTBpTNTQvoUj3u1oegj27wCvd0T
Co+/w2S7S+7JLwPW36TRk0Uap3mWNc4yZPOeywJZon3bpWGB9fL86k+j1Htc7aG/
GNN9HI2DA54u/Yz+11594bi7rzQEd4BbS2+SWiS+5VcYYLbYSao=
=TUBU
-----END PGP SIGNATURE-----

--wwkc4zuembsuqcjr--
