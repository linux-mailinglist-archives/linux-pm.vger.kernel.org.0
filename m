Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB789D55C8
	for <lists+linux-pm@lfdr.de>; Sun, 13 Oct 2019 13:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728948AbfJML2R (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 13 Oct 2019 07:28:17 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:41069 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728620AbfJML2Q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 13 Oct 2019 07:28:16 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 1776480249; Sun, 13 Oct 2019 13:27:59 +0200 (CEST)
Date:   Sun, 13 Oct 2019 13:28:11 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, Merlijn Wajer <merlijn@wizzup.org>
Subject: Re: [PATCH 1/2] power: supply: cpcap-battery: Check voltage before
 orderly_poweroff
Message-ID: <20191013112810.GB5653@amd>
References: <20191009205252.9510-1-tony@atomide.com>
 <20191009205252.9510-2-tony@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="mxv5cy4qt+RJ9ypb"
Content-Disposition: inline
In-Reply-To: <20191009205252.9510-2-tony@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--mxv5cy4qt+RJ9ypb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2019-10-09 13:52:51, Tony Lindgren wrote:
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

> +++ b/drivers/power/supply/cpcap-battery.c
> @@ -562,12 +562,15 @@ static irqreturn_t cpcap_battery_irq_thread(int irq=
, void *data)
>  	switch (d->action) {
>  	case CPCAP_BATTERY_IRQ_ACTION_BATTERY_LOW:
>  		if (latest->current_ua >=3D 0)
> -			dev_warn(ddata->dev, "Battery low at 3.3V!\n");
> +			dev_warn(ddata->dev, "Battery low at %imV!\n",
> +				latest->voltage / 1000);
>  		break;
>  	case CPCAP_BATTERY_IRQ_ACTION_POWEROFF:
> -		if (latest->current_ua >=3D 0) {
> +		if (latest->current_ua >=3D 0 && latest->voltage >=3D 0 &&
> +		    latest->voltage <=3D 3100000) {
>  			dev_emerg(ddata->dev,
> -				  "Battery empty at 3.1V, powering off\n");
> +				  "Battery empty at %imV, powering off\n",
> +				  latest->voltage / 1000);
>  			orderly_poweroff(true);
>  		}

Hmm.

So if latest->voltage is < 0, I'd preffer to shut down the machine,
too.

Actually, if we got POWEROFF irq, and voltage is close to 3.1V (like
maybe < 3.2V), maybe it would be good to shutdown anyway?

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--mxv5cy4qt+RJ9ypb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl2jCkoACgkQMOfwapXb+vKy+QCffT9FuOWR4aA6uKpBiRBmWXOX
aJwAn3lKGdHXO/XaQVFdVa25C2f6uJ4f
=nJvT
-----END PGP SIGNATURE-----

--mxv5cy4qt+RJ9ypb--
