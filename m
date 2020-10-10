Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE09E28A27E
	for <lists+linux-pm@lfdr.de>; Sun, 11 Oct 2020 00:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390483AbgJJW5Y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 10 Oct 2020 18:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730459AbgJJTvA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 10 Oct 2020 15:51:00 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D685C0613B5
        for <linux-pm@vger.kernel.org>; Sat, 10 Oct 2020 04:12:10 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 5ACA81F441FF
Received: by earth.universe (Postfix, from userid 1000)
        id 2AEB73C0C87; Sat, 10 Oct 2020 13:09:23 +0200 (CEST)
Date:   Sat, 10 Oct 2020 13:09:22 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Milan =?utf-8?Q?P=2E_Stani=C4=87?= <mps@arvanta.net>
Cc:     linux-pm@vger.kernel.org, kernel@collabora.com,
        Vicente Bergas <vicencb@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: Re: [PATCH] power: supply: sbs-battery: chromebook workaround for PEC
Message-ID: <20201010110922.d4jepnvvyxod62zv@earth.universe>
References: <20201004224601.420786-1-sebastian.reichel@collabora.com>
 <20201008190701.GA10495@arya.arvanta.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fxhpu4w7glgw2klu"
Content-Disposition: inline
In-Reply-To: <20201008190701.GA10495@arya.arvanta.net>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--fxhpu4w7glgw2klu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 08, 2020 at 09:07:01PM +0200, Milan P. Stani=C4=87 wrote:
> On Mon, 2020-10-05 at 00:46, Sebastian Reichel wrote:
> > Looks like the I2C tunnel implementation from Chromebook's
> > embedded controller does not handle PEC correctly. Fix this
> > by disabling PEC for batteries behind those I2C tunnels as
> > a workaround.
> >=20
> > Reported-by: "Milan P. Stani=C4=87" <mps@arvanta.net>
> > Reported-by: Vicente Bergas <vicencb@gmail.com>
> > CC: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > Fixes: 7222bd603dd2 ("power: supply: sbs-battery: add PEC support")
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > ---
> > Hi,
> >=20
> > This is compile-tested only, since I do not have a chromebook at
> > hand. Please test if this fixes your issue.
> >=20
> > -- Sebastian
> > ---
> >  drivers/power/supply/sbs-battery.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >=20
> > diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/=
sbs-battery.c
> > index 13192cbcce71..b6a538ebb378 100644
> > --- a/drivers/power/supply/sbs-battery.c
> > +++ b/drivers/power/supply/sbs-battery.c
> > @@ -279,6 +279,12 @@ static int sbs_update_presence(struct sbs_info *ch=
ip, bool is_present)
> >  	else
> >  		client->flags &=3D ~I2C_CLIENT_PEC;
> > =20
> > +	if (of_device_is_compatible(client->dev.parent->of_node, "google,cros=
-ec-i2c-tunnel")
> > +	    && client->flags & I2C_CLIENT_PEC) {
> > +		dev_info(&client->dev, "Disabling PEC because of broken Cros-EC impl=
ementation\n");
> > +		client->flags &=3D ~I2C_CLIENT_PEC;
> > +	}
> > +
> >  	dev_dbg(&client->dev, "PEC: %s\n", (client->flags & I2C_CLIENT_PEC) ?
> >  		"enabled" : "disabled");
>  =20
> Just for info, yesterday I built kernel 5.9-rc8 from:
> https://gitlab.collabora.com/eballetbo/linux/-/commits/topic/chromeos/som=
ewhat-stable-next
> for Acer R13 chromebook (Mediatek mt8173, Machine model: Google Elm)
> without above patch, and on it sbs-battery works without any problem.

Thanks for the info. I updated the commit message stating that not
all Chromebooks are affected.

> Maybe problem is only on rk3399 (just guessing)

Maybe. I did not take a close look how the cros-ec-i2c-tunnel is
implemented in hardware. It might also be completly unrelated to the
cros-ec-i2c-tunnel and a defect battery controller instead.

For now I sent above fix to Linus, so that the final 5.9 release
works on all Chromebooks. It's better to do further investigation
with a workaround in place :)

-- Sebastian

--fxhpu4w7glgw2klu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl+Bll0ACgkQ2O7X88g7
+ppHmQ//ZiNLFKfRBbShn08a4t2Ge5EgLDDCrtgK0+UFkxsaBEoCcrjlzb/y6mvk
XMxKnpH7v6V5c017kyjDvSCW1juHeVLbOmGYGlgVDHOy+Hext/BqaZaw99zo67cy
UvFN9v8I54QciLXvWw1dkoo47HcZNpnqfV9MdE0AvX0pXHTopnUWNJcOUpTLoDOS
P91hhCEK2v712ubI9zaGH3gy5qF+POjo5xWR5HVtWE8+aED2yUtvlbhmJPxVRJD7
qDpjRAkw6W8ZDGZANAPSB2hu5sJRF1UzVwf3PlSEZiWQgvgUaTqW4G+ITMcPlCLe
1i5u8V/f++PaKiAHfDN0Udy4xem+HK+XUVp7I5RsUkuvk8zOSGLqha5La9UporOv
kfHEkpi1WRgbqrp34nBpToGqXcf4mAOeAXvBTw8W/EQlSe7SlUp+AG10LM9FXt4M
YPk6dJNXZBosu20RNSgNERyI6paQzmwwvhplJThpETvvQcJrLbEFFDl8bakacBRo
1OyhDbEs5qPkUFZWA16DkrRNxP4w+tEIhsVDU2a9e+CgTEVEeOYmnCjXplwsP31y
T7h6CSEVW/pkTdKR6yysLsIW6j2eoX9NQkkAjx5bbWXyiT9J2ANlLiihNWunM2Dt
SwG+CeMtYjOmV4Gmy66K2JmYRbhEYRzZEOvK/Uqj0O6etszhoJY=
=5VBr
-----END PGP SIGNATURE-----

--fxhpu4w7glgw2klu--
