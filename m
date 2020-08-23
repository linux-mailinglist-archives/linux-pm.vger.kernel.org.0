Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB0224F049
	for <lists+linux-pm@lfdr.de>; Mon, 24 Aug 2020 00:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgHWWak (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 23 Aug 2020 18:30:40 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:42566 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726624AbgHWWaj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 23 Aug 2020 18:30:39 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 5F84D1C0BC2; Mon, 24 Aug 2020 00:30:37 +0200 (CEST)
Date:   Mon, 24 Aug 2020 00:30:37 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dan Murphy <dmurphy@ti.com>,
        Sebastian Reichel <sre@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/6] leds: Add driver for Acer Iconia Tab A500
Message-ID: <20200823223037.5fkeg5ai6hry3axj@duo.ucw.cz>
References: <20200823140846.19299-1-digetx@gmail.com>
 <20200823140846.19299-4-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="6chsuobtor6dul2u"
Content-Disposition: inline
In-Reply-To: <20200823140846.19299-4-digetx@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--6chsuobtor6dul2u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Acer Iconia Tab A500 is an Android tablet device which has two LEDs
> embedded into the Power Button. Orange LED indicates "battery charging"
> status and white LED indicates "wake-up/charge-done" status. The new LED
> driver provides control over both LEDs to userspace.

> @@ -0,0 +1,121 @@
> +// SPDX-License-Identifier: GPL-2.0+

Nice.

> + * Copyright 2020 GRATE-driver project.

Probably untrue.


> +	white_led->cdev.name =3D "power-button-white";

"white:power"

> +	white_led->cdev.max_brightness =3D LED_ON;

=3D 1. (And you'll need other adjustments over the code).

> +	orange_led->cdev.name =3D "power-button-orange";

"orange:power" -- or what is this LED usually used for?

> +MODULE_LICENSE("GPL v2");

Should be "GPL"?
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--6chsuobtor6dul2u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX0LuDQAKCRAw5/Bqldv6
8to6AJ9R5ltlmy3K3jnj9kfTrFsm9vnnSgCfSRzSZElGgph2rsOdpzOgkHDfR4A=
=vV3r
-----END PGP SIGNATURE-----

--6chsuobtor6dul2u--
