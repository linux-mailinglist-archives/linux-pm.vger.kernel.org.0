Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2065E1C123A
	for <lists+linux-pm@lfdr.de>; Fri,  1 May 2020 14:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbgEAMgb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 May 2020 08:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728639AbgEAMga (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 May 2020 08:36:30 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9138BC061A0C;
        Fri,  1 May 2020 05:36:30 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 23CC62A2FC1
Received: by earth.universe (Postfix, from userid 1000)
        id EC7103C08C7; Fri,  1 May 2020 14:36:26 +0200 (CEST)
Date:   Fri, 1 May 2020 14:36:26 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 04/11] power: supply: core: reduce
 power_supply_show_usb_type() parameters
Message-ID: <20200501123626.nwxd2pzhwstu2rb3@earth.universe>
References: <cover.1585944770.git.mirq-linux@rere.qmqm.pl>
 <16ca50739c664b3fa373306f3c08882d9d4cf55d.1585944770.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gwo25vnp5ep6zq4j"
Content-Disposition: inline
In-Reply-To: <16ca50739c664b3fa373306f3c08882d9d4cf55d.1585944770.git.mirq-linux@rere.qmqm.pl>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--gwo25vnp5ep6zq4j
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 03, 2020 at 10:20:32PM +0200, Micha=C5=82 Miros=C5=82aw wrote:
> Reduce power_supply_show_usb_type() parameter count by folding
> power_supply_desc dereference into the function.  This makes following
> patch making usb_types const easier.
>=20
> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/power_supply_sysfs.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/su=
pply/power_supply_sysfs.c
> index f37ad4eae60b..51de3f47b25d 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -78,8 +78,7 @@ static const char * const power_supply_scope_text[] =3D=
 {
>  };
> =20
>  static ssize_t power_supply_show_usb_type(struct device *dev,
> -					  enum power_supply_usb_type *usb_types,
> -					  ssize_t num_usb_types,
> +					  const struct power_supply_desc *desc,
>  					  union power_supply_propval *value,
>  					  char *buf)
>  {
> @@ -88,8 +87,8 @@ static ssize_t power_supply_show_usb_type(struct device=
 *dev,
>  	bool match =3D false;
>  	int i;
> =20
> -	for (i =3D 0; i < num_usb_types; ++i) {
> -		usb_type =3D usb_types[i];
> +	for (i =3D 0; i < desc->num_usb_types; ++i) {
> +		usb_type =3D desc->usb_types[i];
> =20
>  		if (value->intval =3D=3D usb_type) {
>  			count +=3D sprintf(buf + count, "[%s] ",
> @@ -163,8 +162,7 @@ static ssize_t power_supply_show_property(struct devi=
ce *dev,
>  			      power_supply_type_text[value.intval]);
>  		break;
>  	case POWER_SUPPLY_PROP_USB_TYPE:
> -		ret =3D power_supply_show_usb_type(dev, psy->desc->usb_types,
> -						 psy->desc->num_usb_types,
> +		ret =3D power_supply_show_usb_type(dev, psy->desc,
>  						 &value, buf);
>  		break;
>  	case POWER_SUPPLY_PROP_SCOPE:
> --=20
> 2.20.1
>=20

--gwo25vnp5ep6zq4j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl6sF7YACgkQ2O7X88g7
+prwyQ//QdWswtGX6RqxYWjdwijzqG9iTJPBEHqDvYNRGU4hw/946g55l71UCjnB
1PxcRlSEbHKUDcO/RLkoBoPr654aM3cQNg0ML3BIumR2Y/P3yvp0yZY6uiLtImyc
Ye6Nzz0FdCXn8Ab4x9bqgLyZHNPajON43mjWwOV7xLZ4NJPg92/i/AFu3PjsQscD
0vcdh9A1DDFcrgnZ1iG9y6J9c3aQqgPK6mE31OsldzVQrnaIciH1U0iWRaSFHRZE
9jcUF+DDpM+vryEM1duEVQ5G9svIMePjKRi0xFg0mfOg+CsY05PthiPhXBN4Oowo
fDLEdVoLi+hVfZgYxONrZx+7sfrlvKyyzjbVvfodZNbzVvWIgNPKhloLiI4JwJ/n
VETOhC3diUDB8s7mBAL4vTI0hyLUWbWyANAErAWK4rvfXm/6KchydM6HkYexmb14
SNlX/sSH9TBuvrca3b9eqdK8+hNyXuvGNNomgBD11DQg30cBxWBZAYCh0k8UXp18
UwLDdeC+2/uFzbajUFHb1Pxpa2QAYPpHD/wq1lwHvFvJx6y1RjzlUNIfDLQ6mclY
d0Tt6l5RtdZz/Mncs5tMdwgzjbowrRoigpB6JaEQsw+E0lbrlUMlKwnMy+Bv9J7T
vrtQ63G3Utv3sQsx7DtCEYVsK32DeOliM1WLhZwUi+2mSex8hOM=
=xY64
-----END PGP SIGNATURE-----

--gwo25vnp5ep6zq4j--
