Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85FE03E3136
	for <lists+linux-pm@lfdr.de>; Fri,  6 Aug 2021 23:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233214AbhHFVix (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Aug 2021 17:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbhHFVix (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Aug 2021 17:38:53 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032EDC0613CF;
        Fri,  6 Aug 2021 14:38:37 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id DA68E1F44D66
Received: by earth.universe (Postfix, from userid 1000)
        id EC2FC3C0C99; Fri,  6 Aug 2021 23:38:33 +0200 (CEST)
Date:   Fri, 6 Aug 2021 23:38:33 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     tangbin <tangbin@cmss.chinamobile.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Subject: Re: [PATCH] power: supply: qcom_smbb: Remove superfluous errormessage
Message-ID: <20210806213833.hsmd7syatpmn3nku@earth.universe>
References: <20210720141539.7716-1-tangbin@cmss.chinamobile.com>
 <YPbxS4KV+Fx01p7G@yoga>
 <f6a40fef-deac-e898-7cac-d9d246c84a24@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="srvp65x6cyhvtnnq"
Content-Disposition: inline
In-Reply-To: <f6a40fef-deac-e898-7cac-d9d246c84a24@cmss.chinamobile.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--srvp65x6cyhvtnnq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 26, 2021 at 09:16:15AM +0800, tangbin wrote:
> Hi, Bjorn Andersson:
>=20
> On 2021/7/20 23:52, Bjorn Andersson wrote:
> > On Tue 20 Jul 09:15 CDT 2021, Tang Bin wrote:
> >=20
> > > In the probe function, when get irq failed, the function
> > > platform_get_irq_byname() logs an error message, so remove
> > > redundant message here.
> > >=20
> > > Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
> > > Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> > This says "Zhang certified this patch's origin, then you took the patch
> > and you certified it's origin" - per Documentation/process/submitting-p=
atches.rst
> >=20
> > But you, Tang, is the author or the patch, so how can Zhang have touched
> > it before you wrote it?
> >=20
> > Perhaps you worked on it together? In which case you should include a
> > Co-developed-by to indicate this.
>=20
> I am sorry for the late reply to your email due to some reasons. The corr=
ect
> way to write it should be as follows:
>=20
> =C2=A0=C2=A0=C2=A0 Co-developed-by: Zhang Shengju <zhangshengju@cmss.chin=
amobile.com>
>=20
> =C2=A0=C2=A0=C2=A0 Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinam=
obile.com>
>=20
> =C2=A0=C2=A0=C2=A0 Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
>=20
> >=20
> >=20
> > Both commit message and patch looks good though!
> >=20
> whether should I send v2 for this patch=EF=BC=9F

Thanks, I queued the patch with the Co-developed-by tag.

-- Sebastian

>=20
> Thanks
>=20
> Tang Bin
>=20
> > > ---
> > >   drivers/power/supply/qcom_smbb.c | 5 +----
> > >   1 file changed, 1 insertion(+), 4 deletions(-)
> > >=20
> > > diff --git a/drivers/power/supply/qcom_smbb.c b/drivers/power/supply/=
qcom_smbb.c
> > > index c890e1cec..84cc9fba0 100644
> > > --- a/drivers/power/supply/qcom_smbb.c
> > > +++ b/drivers/power/supply/qcom_smbb.c
> > > @@ -929,11 +929,8 @@ static int smbb_charger_probe(struct platform_de=
vice *pdev)
> > >   		int irq;
> > >   		irq =3D platform_get_irq_byname(pdev, smbb_charger_irqs[i].name);
> > > -		if (irq < 0) {
> > > -			dev_err(&pdev->dev, "failed to get irq '%s'\n",
> > > -				smbb_charger_irqs[i].name);
> > > +		if (irq < 0)
> > >   			return irq;
> > > -		}
> > >   		smbb_charger_irqs[i].handler(irq, chg);
> > > --=20
> > > 2.20.1.windows.1
> > >=20
> > >=20
> > >=20
>=20
>=20

--srvp65x6cyhvtnnq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmENq9kACgkQ2O7X88g7
+poocQ//bo8q1dQDb1qGdP1y9JTLSv8XNVY7R9vpNDZq0vmrm41M3PfMP2rMqaBG
I0KENmhpjRbrKy5zbmSemYcu5aK8fpqHjtTN/Bzlvw1y29qf9I7Fz1ypemHi6IPl
BYDe4RPINT3NXqatw9Rhq2cLICfxVhumRYe+OGxpn+NGB7YDe3BhGrBOqqr5C3Gk
5Yb6Lddf12D7jGDNLqoQ8ar8+7iScVTOD0KMTUm1slmb7t2BCLzfVpYPzLjAGDQ9
mwFemir3ydwP3bfeM5g4NeNk7pC8IXnaQ7+2bBpQiZ71/dV4UrsNw+1MkmN/csTl
j+iLsonpzb8HvgJrpiK4/GgHr3JFo9OFe/1Nn6tNwo6JC1MOPRtpNrmKNrfitAff
i3HSBXjvfzO9Rx1HQts6xoWChzks/e0FtTt5csuQ3G0KNBX1BfKn4Vc4fCDeK+0C
nI2zPSBVFhrqoOOFugVOcJNxmLYbvtRtMLsF31wCP65UzZXIueKiMt1L6rU5r6tW
jbjfuyqmdcAXWvFazhW3mtYqROaMWF6/wpYNvFmsqnpuoXcZ8ke7j5GejdwzG1zG
U419BQTF4/HQR5HIKVfX3Dm/wgNGd+kCinP6BY7ahpcFfIo22M+v6HcbEzdYSdZ4
U9dwNc8MuOFx6mYRbU3/Lq5f1RGw2JcPkgJKq2slrjYnryb4JAQ=
=Fneq
-----END PGP SIGNATURE-----

--srvp65x6cyhvtnnq--
