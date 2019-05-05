Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C13EE14210
	for <lists+linux-pm@lfdr.de>; Sun,  5 May 2019 21:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbfEETON (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 5 May 2019 15:14:13 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:46698 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbfEETON (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 5 May 2019 15:14:13 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 1C53A803EE; Sun,  5 May 2019 21:14:02 +0200 (CEST)
Date:   Sun, 5 May 2019 21:14:12 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH 2/7] power: supply: cpcap-battery: Fix low battery check
Message-ID: <20190505191412.GA4050@amd>
References: <20190407181254.64537-1-tony@atomide.com>
 <20190407181254.64537-3-tony@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
In-Reply-To: <20190407181254.64537-3-tony@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2019-04-07 11:12:49, Tony Lindgren wrote:
> We need to check current instead of the charge counter to see if
> a charger is connected. The charge counter shows the cumulated value
> instead of the current charge current and can be negative or positive.
>=20

Acked-by: Pavel Machek <pavel@ucw.cz>

> Signed-off-by: Tony Lindgren <tony@atomide.com>


> ---
>  drivers/power/supply/cpcap-battery.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/=
cpcap-battery.c
> --- a/drivers/power/supply/cpcap-battery.c
> +++ b/drivers/power/supply/cpcap-battery.c
> @@ -562,11 +562,11 @@ static irqreturn_t cpcap_battery_irq_thread(int irq=
, void *data)
> =20
>  	switch (d->action) {
>  	case CPCAP_BATTERY_IRQ_ACTION_BATTERY_LOW:
> -		if (latest->counter_uah >=3D 0)
> +		if (latest->current_ua >=3D 0)
>  			dev_warn(ddata->dev, "Battery low at 3.3V!\n");
>  		break;
>  	case CPCAP_BATTERY_IRQ_ACTION_POWEROFF:
> -		if (latest->counter_uah >=3D 0) {
> +		if (latest->current_ua >=3D 0) {
>  			dev_emerg(ddata->dev,
>  				  "Battery empty at 3.1V, powering off\n");
>  			orderly_poweroff(true);

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlzPNgQACgkQMOfwapXb+vJkoACfa+jKGnMxD78TLrJv6xTQhYU9
CbYAnRwmWa7RdzyUAExv8D+lmgIAMz8K
=xE1L
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--
