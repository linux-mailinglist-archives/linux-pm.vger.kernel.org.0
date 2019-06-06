Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8F837AEE
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2019 19:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbfFFRWl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Jun 2019 13:22:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:60608 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726092AbfFFRWl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 6 Jun 2019 13:22:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1878AABD0;
        Thu,  6 Jun 2019 17:22:40 +0000 (UTC)
Message-ID: <eb72a26b55cf17c29df6a7fd3c5def08182e00af.camel@suse.de>
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
Date:   Thu, 06 Jun 2019 19:22:16 +0200
In-Reply-To: <20190606170949.4A46720652@mail.kernel.org>
References: <20190606142255.29454-1-nsaenzjulienne@suse.de>
         <20190606142255.29454-5-nsaenzjulienne@suse.de>
         <20190606170949.4A46720652@mail.kernel.org>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-Pw8rcdAQwigEg8aqt+O7"
User-Agent: Evolution 3.32.2 
MIME-Version: 1.0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--=-Pw8rcdAQwigEg8aqt+O7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stephen,
Thanks for the review.

On Thu, 2019-06-06 at 10:09 -0700, Stephen Boyd wrote:
> Quoting Nicolas Saenz Julienne (2019-06-06 07:22:56)
> > diff --git a/drivers/cpufreq/raspberrypi-cpufreq.c
> > b/drivers/cpufreq/raspberrypi-cpufreq.c
> > new file mode 100644
> > index 000000000000..99b59d5a50aa
> > --- /dev/null
> > +++ b/drivers/cpufreq/raspberrypi-cpufreq.c
> [...]
> > +
> > +/*
> > + * Since the driver depends on clk-raspberrypi, which may return
> > EPROBE_DEFER,
> > + * all the activity is performed in the probe, which may be defered as
> > well.
> > + */
> > +static struct platform_driver raspberrypi_cpufreq_driver =3D {
> > +       .driver =3D {
> > +               .name =3D "raspberrypi-cpufreq",
> > +       },
> > +       .probe          =3D raspberrypi_cpufreq_probe,
> > +       .remove         =3D raspberrypi_cpufreq_remove,
> > +};
> > +module_platform_driver(raspberrypi_cpufreq_driver);
>=20
> How does this driver probe? Do you have a node in DT named
> raspberrypi-cpufreq that matches and probes this? I would think this
> would follow the drivers/cpufreq/cpufreq-dt-platdev.c design where it's
> an initcall that probes the board compatible string.
>
> Or, if it depends on clk-raspberrypi probing, maybe it could create the
> platform device in that drivers probe function.

Well you just reviewed that patch :)

> > +
> > +MODULE_AUTHOR("Nicolas Saenz Julienne <nsaenzjulienne@suse.de");
> > +MODULE_DESCRIPTION("Raspberry Pi cpufreq driver");
> > +MODULE_LICENSE("GPL");
> > +MODULE_ALIAS("platform:raspberrypi-cpufreq");
>=20
> I don't think the module alias is needed anymore.

That's surprising. I remember the driver not being loaded by udev without i=
t.

Regards,
Nicolas


--=-Pw8rcdAQwigEg8aqt+O7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAlz5S8gACgkQlfZmHno8
x/6ReQgAmTObVFlrCJjS+HsdqcP5Er91BEOTv2XnVOfYkRC/w/vFXhkOZIlokLgq
kj+GwzHmUGEGzlwyGsb1cJCnOffS7QI5Y1P2pfqqF1z0+kCfNiS8RMVJh6lvazsr
wxTIqZBjf6Qi6Hckl03htdGmFkHCP4ftoHTWP6SVjWRfm9tSzbfWSWczNMwsU2g0
ICXOdZ1BzUiDU69Tq8yWuKFavbvp7JmHKTzGI5sV7hyiFikQZDwbivbUN8dERESJ
aWlDO32Twc2v+W8z9ZJaWtfCcOtFA/Tkca2sZ+HHt8cxe67dPzcQIFC/BoPfTw/h
TVzSQVZjVbG91S6E0W+ElFkMVnI8BQ==
=zgC8
-----END PGP SIGNATURE-----

--=-Pw8rcdAQwigEg8aqt+O7--

