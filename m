Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E40337ACC
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2019 19:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbfFFRSL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Jun 2019 13:18:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:59842 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725267AbfFFRSL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 6 Jun 2019 13:18:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C95A0ABD0;
        Thu,  6 Jun 2019 17:18:09 +0000 (UTC)
Message-ID: <2dd0a516bbfe6150112ec7dc5f7d4d85cbe3cd03.camel@suse.de>
Subject: Re: [PATCH v2 5/7] clk: raspberrypi: register platform device for
 raspberrypi-cpufreq
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        stefan.wahren@i2se.com
Cc:     linux-arm-kernel@lists.infradead.org, f.fainelli@gmail.com,
        ptesarik@suse.com, viresh.kumar@linaro.org,
        mturquette@baylibre.com, linux-pm@vger.kernel.org,
        rjw@rjwysocki.net, eric@anholt.net,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        mbrugger@suse.de, ssuloev@orpaltech.com
Date:   Thu, 06 Jun 2019 19:16:56 +0200
In-Reply-To: <20190606170505.39C5B20693@mail.kernel.org>
References: <20190606142255.29454-1-nsaenzjulienne@suse.de>
         <20190606142255.29454-6-nsaenzjulienne@suse.de>
         <20190606170505.39C5B20693@mail.kernel.org>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-kUnogK0EQ/Wuzf5iUu5P"
User-Agent: Evolution 3.32.2 
MIME-Version: 1.0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--=-kUnogK0EQ/Wuzf5iUu5P
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-06-06 at 10:05 -0700, Stephen Boyd wrote:
> Quoting Nicolas Saenz Julienne (2019-06-06 07:22:58)
> > diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-
> > raspberrypi.c
> > index b1365cf19f3a..052296b5fbe4 100644
> > --- a/drivers/clk/bcm/clk-raspberrypi.c
> > +++ b/drivers/clk/bcm/clk-raspberrypi.c
> > @@ -63,6 +63,8 @@ struct raspberrypi_firmware_prop {
> >         __le32 disable_turbo;
> >  } __packed;
> > =20
> > +static struct platform_device *rpi_cpufreq;
>=20
> Why can't this be stored in platform driver data?

It actually could, I just followed the same pattern as the code found in pa=
tch
#3. I'll update it in the next version if you prefer it.=20

>=20
> > +
> >  static int raspberrypi_clock_property(struct rpi_firmware *firmware, u=
32
> > tag,
> >                                       u32 clk, u32 *val)
> >  {
> > @@ -285,6 +287,17 @@ static int raspberrypi_clk_probe(struct platform_d=
evice
> > *pdev)
> >                 return ret;
> >         }
> > =20
> > +       rpi_cpufreq =3D platform_device_register_data(dev, "raspberrypi=
-
> > cpufreq",
> > +                                                   -1, NULL, 0);
> > +
> > +       return 0;
> > +}
> > +
> > +static int raspberrypi_clk_remove(struct platform_device *pdev)
> > +{
> > +       platform_device_unregister(rpi_cpufreq);
> > +       rpi_cpufreq =3D NULL;
>=20
> This assignment to NULL looks unnecessary.
>=20

Same as above, but now that you pointed out, it's true it doesn't have any
effect

> > +
> >         return 0;
> >  }
> > =20
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


--=-kUnogK0EQ/Wuzf5iUu5P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAlz5SogACgkQlfZmHno8
x/4VhQgAs+iCf5QclLwdbxPvkFRyZXBtati3ZFFhBMaCi1DaZZUUSSs3K37BoxW8
RbH8hNdRV0709SU3XWNHEetL5XTkJa0rBDcxxY4BNovcjJq5MXV02bZUkFVxSQDc
zjPPWadRrNsZWs/ylCDjoTFjO4Rb9OKPtvtlr3/lB11zgZZT3WSt1HWSH+58bdrO
44OehaU2kdivEHqT/M3g5cdSnkhMYYZsE874JnQsYmAOQ682FnhHrcA1n4Qjzvap
916JhXnv4rv1FeeP9WvN0wKWorSlViOOSGu97jr4mAPoJQn1wfv0WulWnw0j896i
vjBPNpJa84q+O2nkkwxpuG0bKbg4HA==
=hGpW
-----END PGP SIGNATURE-----

--=-kUnogK0EQ/Wuzf5iUu5P--

