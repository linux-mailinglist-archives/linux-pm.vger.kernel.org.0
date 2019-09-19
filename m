Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED72EB75EB
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2019 11:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388084AbfISJOi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Sep 2019 05:14:38 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:41793 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387757AbfISJOh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Sep 2019 05:14:37 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 4FA5B81649; Thu, 19 Sep 2019 11:14:21 +0200 (CEST)
Date:   Thu, 19 Sep 2019 11:14:34 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, Merlijn Wajer <merlijn@wizzup.org>
Subject: Re: [PATCH 2/3] power: supply: cpcap-battery: Check voltage before
 orderly_poweroff
Message-ID: <20190919091434.GB9644@amd>
References: <20190917213501.16907-1-tony@atomide.com>
 <20190917213501.16907-3-tony@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="gj572EiMnwbLXET9"
Content-Disposition: inline
In-Reply-To: <20190917213501.16907-3-tony@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--gj572EiMnwbLXET9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2019-09-17 14:35:00, Tony Lindgren wrote:
> We can get the low voltage interrupt trigger sometimes way too early,
> maybe because of CPU load spikes. This causes orderly_poweroff() be
> called too easily.
>=20
> Let's check the voltage before orderly_poweroff in case it was not
> yet a permanent condition. We will be getting more interrupts anyways
> if the condition persists.
>=20
> Let's also show the measured voltages for low battery and battery
> empty warnings since we have them.

Well, this is decision that will shorten battery lifetime. There's
very little capacity left when battery is down to 3.3V...

What kind of "way too early" do you see?

> @@ -562,12 +562,15 @@ static irqreturn_t cpcap_battery_irq_thread(int irq=
, void *data)
>  	switch (d->action) {
>  	case CPCAP_BATTERY_IRQ_ACTION_BATTERY_LOW:
>  		if (latest->current_ua >=3D 0)
> -			dev_warn(ddata->dev, "Battery low at 3.3V!\n");
> +			dev_warn(ddata->dev, "Battery low at %i!\n",
> +				latest->voltage);
>  		break;

I'd still leave unit ("uV"?) there. Or do /1000, as and display mV, as
our=20
> -				  "Battery empty at 3.1V, powering off\n");
> +				  "Battery empty at %i, powering off\n",
> +				  latest->voltage);
>  			orderly_poweroff(true);

Same here.

Plus I see bigger problem: shutdown from mainline seems to leave
something powered in the phone (I believe I seen USB charge pump, for
example), so the battery will be completely empty next time I attempt
to use the phone. (I learned to reboot into stock android and shutdown
there).

Phone should last days when powered off, but it seems to only last
hours.

Unfortunately I don't know how to debug that :-(.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--gj572EiMnwbLXET9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl2DRvoACgkQMOfwapXb+vLvdACfQobJJv8Jz3zjZz9R/RCZi8JJ
uHcAn2vkrPLm8dhHTfKcnaerlR7EYcug
=Kcv6
-----END PGP SIGNATURE-----

--gj572EiMnwbLXET9--
