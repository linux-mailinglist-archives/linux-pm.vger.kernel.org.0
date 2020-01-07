Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 771DE1324D5
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2020 12:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgAGL2a (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Jan 2020 06:28:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:46414 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727273AbgAGL23 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 7 Jan 2020 06:28:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C7BACAD07;
        Tue,  7 Jan 2020 11:28:27 +0000 (UTC)
Message-ID: <f14bad2513cde4e57af21fdc971638c74db9ba50.camel@suse.de>
Subject: Re: [PATCH V2 2/4] thermal: Add BCM2711 thermal driver
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Stefan Wahren <wahrenst@gmx.net>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org
Date:   Tue, 07 Jan 2020 12:28:26 +0100
In-Reply-To: <98b424ff-040c-b68c-04d3-823c771986fa@gmail.com>
References: <1578072236-31820-1-git-send-email-wahrenst@gmx.net>
         <1578072236-31820-3-git-send-email-wahrenst@gmx.net>
         <98b424ff-040c-b68c-04d3-823c771986fa@gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-QjE9SpdH7vcQ556S/L5J"
User-Agent: Evolution 3.34.2 
MIME-Version: 1.0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--=-QjE9SpdH7vcQ556S/L5J
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-01-06 at 14:30 -0800, Florian Fainelli wrote:
> Hi Stefan,
>=20
> On 1/3/20 9:23 AM, Stefan Wahren wrote:
> > This adds the thermal sensor driver for the Broadcom BCM2711 SoC,
> > which is placed on the Raspberry Pi 4. The driver only provides
> > SoC temperature reading so far.
> >=20
> > Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
>=20
> This looks good, I just have a couple of nits that you can address since
> the binding needs to be re-spun, see below, in any case:
>=20
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
>=20
> [snip]
>=20
> > +	of_node_put(parent);
> > +	if (IS_ERR(regmap)) {
> > +		dev_err(dev, "failed to get regmap (error %ld)\n",
> > +			PTR_ERR(regmap));
>=20
> Here we use %ld
>=20
> > +		return PTR_ERR(regmap);
> > +	}
> > +	priv->regmap =3D regmap;
> > +	priv->dev =3D dev;
> > +
> > +	thermal =3D devm_thermal_zone_of_sensor_register(dev, 0, priv,
> > +						       &bcm2711_thermal_of_ops);
> > +	if (IS_ERR(thermal)) {
> > +		ret =3D PTR_ERR(thermal);
> > +		dev_err(dev, "could not register sensor: %d\n", ret);
>=20
> and here we do an implicit cast into int, thus using %d, could we just
> make both consistent and use %d?

Extra nit since you're changing this. I'd suggest keeping the same format
between error messages (i.e. one encloses the error message between parenth=
eses
and the other uses a colon).

Regards,
Nicolas


--=-QjE9SpdH7vcQ556S/L5J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl4Ua1oACgkQlfZmHno8
x/6Jbwf/QlXAMb6Zv08I/d4SuxsyX/MIGxjH4v6pfSY51sJLUr0J11bNSN6daz1l
b4RTVB6nAM/n7yvKXG4Fqfcp3w1N6xWYf6kuWXB5j1gzhkVzDofs/yDsJeWcMKzn
r8paTRm0gVZOIuaqrglBzRAqSL/atjROV5KWbaOxehbNYglvhBoVKNxY60v4DGs5
LqHdU2jEIO3oBc8oaPgNJS5riO91XiXVbGHw7MKAht2+mViCE3sBRmn1J1bFHxXE
coiPM7/+6iZ4+TJ6hiyDs7Ebu9x6UvAxm9HeTCHcMIeNTs7d3h2Rp1q+/vsex8OP
kjZoS4Ua9IlkqJFZAzSC5JDDlocxaw==
=/JB6
-----END PGP SIGNATURE-----

--=-QjE9SpdH7vcQ556S/L5J--

