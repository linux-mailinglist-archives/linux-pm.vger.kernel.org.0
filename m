Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 084F037BE7
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2019 20:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbfFFSKI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Jun 2019 14:10:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:39686 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727559AbfFFSKI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 6 Jun 2019 14:10:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 49A75AEAA;
        Thu,  6 Jun 2019 18:10:06 +0000 (UTC)
Message-ID: <153579ddd7e6bd1e5c860a7a01115e47c78a1442.camel@suse.de>
Subject: Re: [PATCH v2 4/7] cpufreq: add driver for Raspbery Pi
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>, stefan.wahren@i2se.com
Cc:     linux-arm-kernel@lists.infradead.org, f.fainelli@gmail.com,
        ptesarik@suse.com, mturquette@baylibre.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        eric@anholt.net, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        mbrugger@suse.de, ssuloev@orpaltech.com
Date:   Thu, 06 Jun 2019 20:10:04 +0200
In-Reply-To: <20190606173609.2C3952083D@mail.kernel.org>
References: <20190606142255.29454-1-nsaenzjulienne@suse.de>
         <20190606142255.29454-5-nsaenzjulienne@suse.de>
         <20190606170949.4A46720652@mail.kernel.org>
         <eb72a26b55cf17c29df6a7fd3c5def08182e00af.camel@suse.de>
         <20190606173609.2C3952083D@mail.kernel.org>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-no2LwIbczbAC+dIT76wA"
User-Agent: Evolution 3.32.2 
MIME-Version: 1.0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--=-no2LwIbczbAC+dIT76wA
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-06-06 at 10:36 -0700, Stephen Boyd wrote:
> Quoting Nicolas Saenz Julienne (2019-06-06 10:22:16)
> > Hi Stephen,
> > Thanks for the review.
> >=20
> > On Thu, 2019-06-06 at 10:09 -0700, Stephen Boyd wrote:
> > > Quoting Nicolas Saenz Julienne (2019-06-06 07:22:56)
> > > > diff --git a/drivers/cpufreq/raspberrypi-cpufreq.c
> > > > b/drivers/cpufreq/raspberrypi-cpufreq.c
> > > > new file mode 100644
> > > > index 000000000000..99b59d5a50aa
> > > > --- /dev/null
> > > > +++ b/drivers/cpufreq/raspberrypi-cpufreq.c
> > > [...]
> > > > +
> > > > +/*
> > > > + * Since the driver depends on clk-raspberrypi, which may return
> > > > EPROBE_DEFER,
> > > > + * all the activity is performed in the probe, which may be defere=
d as
> > > > well.
> > > > + */
> > > > +static struct platform_driver raspberrypi_cpufreq_driver =3D {
> > > > +       .driver =3D {
> > > > +               .name =3D "raspberrypi-cpufreq",
> > > > +       },
> > > > +       .probe          =3D raspberrypi_cpufreq_probe,
> > > > +       .remove         =3D raspberrypi_cpufreq_remove,
> > > > +};
> > > > +module_platform_driver(raspberrypi_cpufreq_driver);
> > >=20
> > > How does this driver probe? Do you have a node in DT named
> > > raspberrypi-cpufreq that matches and probes this? I would think this
> > > would follow the drivers/cpufreq/cpufreq-dt-platdev.c design where it=
's
> > > an initcall that probes the board compatible string.
> > >=20
> > > Or, if it depends on clk-raspberrypi probing, maybe it could create t=
he
> > > platform device in that drivers probe function.
> >=20
> > Well you just reviewed that patch :)
>=20
> Ok. So what's your plan?

So as discussed previously with the RPi mantainers, they preferred for the
platform device for raspberrypi-clk to be created by the firmware interface
driver. IIRC Stefan said it was more flexible and the approach used with RP=
i's
hwmon driver already. Also, it's not really clear whether this driver reall=
y
fits the device tree as it wouldn't be describing hardware.

As far as raspberrypi-cpufreq is concerned the max and min frequencies are
configurable in the firmware. So we can't really integrate cpufreq into the
device tree as we need to create the opp table dynamically. Hence the dedic=
ated
driver. On top of that the CPU might not have a clock during the init proce=
ss,
as both the firmware interface and raspberrypi-clk can be compiled as modul=
es.
So I decided the simplest solution was to create the raspberrypi-cpufreq
platform device at the end of raspberrypi-clk's probe.

Once raspberrypi-cpufreq is loaded it queries the min/max frequencies,
populates the CPU's opp table and creates an instance of cpufreq-dt. Which
finally can operate, without the need of any dt info, as opp tables are
populated and CPUs have a clock.

I hope this makes it a little more clear :).

> > > > +
> > > > +MODULE_AUTHOR("Nicolas Saenz Julienne <nsaenzjulienne@suse.de");
> > > > +MODULE_DESCRIPTION("Raspberry Pi cpufreq driver");
> > > > +MODULE_LICENSE("GPL");
> > > > +MODULE_ALIAS("platform:raspberrypi-cpufreq");
> > >=20
> > > I don't think the module alias is needed anymore.
> >=20
> > That's surprising. I remember the driver not being loaded by udev witho=
ut
> > it.
> >=20
>=20
> Maybe I'm wrong. Could be not needed for DT based platform devices with
> an OF table.

As explained in the previous paragraph, I'm not using DT.

Regards,
Nicolas


--=-no2LwIbczbAC+dIT76wA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAlz5VvwACgkQlfZmHno8
x/6TJgf/S/ZmTl7XICYFz1V03cDGo3mPnVBO0ubBvFYddpLAvoHdDh1bDKrO+m9V
OnQ6SuYjoER4z5T78q/xAYpUSXiIuZOYyN/ITJYwc+QeUJGSd6ru5o46Ewk4DkYh
V/fEtil+Y9XeiprB+oqXjwFeaWL7x3LzACc/nDzl0hR6EGEM+TFmJc+cL5w87mRw
Kzl6I2vbHITfo5lTbmygvXffsqf33Iqen1/82EiTozn3RmOBqwwTgzNiGHFyqda4
cUbC78ign/Y61FlRCPnx0Iq2fM5TCppG+8AqFSxfZinzaJUosR5egaVSzTknWiGd
YAHrGJCuwL3UUDA9Uw/a8e7f0ySPTQ==
=xfWC
-----END PGP SIGNATURE-----

--=-no2LwIbczbAC+dIT76wA--

