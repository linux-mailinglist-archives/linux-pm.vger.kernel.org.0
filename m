Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59D9124EFCB
	for <lists+linux-pm@lfdr.de>; Sun, 23 Aug 2020 23:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbgHWVMI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 23 Aug 2020 17:12:08 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:36420 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgHWVMI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 23 Aug 2020 17:12:08 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 416EF1C0BBF; Sun, 23 Aug 2020 23:12:05 +0200 (CEST)
Date:   Sun, 23 Aug 2020 23:12:04 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Keerthy <j-keerthy@ti.com>, Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, Merlijn Wajer <merlijn@wizzup.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH] thermal: ti-soc-thermal: Fix bogus thermal shutdowns for
 omap4430
Message-ID: <20200823211204.zerldmljfd6rrk7g@duo.ucw.cz>
References: <20200706183338.25622-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="imrc7pfk7bghwsac"
Content-Disposition: inline
In-Reply-To: <20200706183338.25622-1-tony@atomide.com>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--imrc7pfk7bghwsac
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> We can sometimes get bogus thermal shutdowns on omap4430 at least with
> droid4 running idle with a battery charger connected:
>=20
> thermal thermal_zone0: critical temperature reached (143 C), shutting down
>=20
> Dumping out the register values shows we can occasionally get a 0x7f value
> that is outside the TRM listed values in the ADC conversion table. And th=
en
> we get a normal value when reading again after that. Reading the register
> multiple times does not seem help avoiding the bogus values as they stay
> until the next sample is ready.
>=20
> Looking at the TRM chapter "18.4.10.2.3 ADC Codes Versus Temperature", we
> should have values from 13 to 107 listed with a total of 95 values. But
> looking at the omap4430_adc_to_temp array, the values are off, and the
> end values are missing. And it seems that the 4430 ADC table is similar
> to omap3630 rather than omap4460.
>=20
> Let's fix the issue by using values based on the omap3630 table and just
> ignoring invalid values. Compared to the 4430 TRM, the omap3630 table has
> the missing values added while the TRM table only shows every second
> value.
>=20
> Note that sometimes the ADC register values within the valid table can
> also be way off for about 1 out of 10 values. But it seems that those
> just show about 25 C too low values rather than too high values. So those
> do not cause a bogus thermal shutdown.

This does not seem to be in recent -next. Ping?

Best regards,
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--imrc7pfk7bghwsac
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX0LbpAAKCRAw5/Bqldv6
8syxAJ9PBvNHtKpZctrdFyS/NBbDxA0ooACgvS260BY0E4CHRadpt6Gmyw8ayfw=
=aSuf
-----END PGP SIGNATURE-----

--imrc7pfk7bghwsac--
