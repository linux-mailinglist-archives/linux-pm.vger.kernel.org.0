Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4A1D24F04F
	for <lists+linux-pm@lfdr.de>; Mon, 24 Aug 2020 00:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgHWWej (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 23 Aug 2020 18:34:39 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:42866 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbgHWWej (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 23 Aug 2020 18:34:39 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id EBB871C0BBF; Mon, 24 Aug 2020 00:34:35 +0200 (CEST)
Date:   Mon, 24 Aug 2020 00:34:34 +0200
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
Message-ID: <20200823223434.cjxo762ehxgo4caz@duo.ucw.cz>
References: <20200823140846.19299-1-digetx@gmail.com>
 <20200823140846.19299-4-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="y36rbmittdiwjmsw"
Content-Disposition: inline
In-Reply-To: <20200823140846.19299-4-digetx@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--y36rbmittdiwjmsw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2020-08-23 17:08:43, Dmitry Osipenko wrote:
> Acer Iconia Tab A500 is an Android tablet device which has two LEDs
> embedded into the Power Button. Orange LED indicates "battery charging"
> status and white LED indicates "wake-up/charge-done" status. The new LED
> driver provides control over both LEDs to userspace.

Hmm. If the ENE controller is similar to other devices, should it also
share LED driver?

And I guess the cdev names should be different based on info above (I
gave you wrong suggestions before)... and they probably should be
parsed from the device tree.

Best regards,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--y36rbmittdiwjmsw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX0Lu+gAKCRAw5/Bqldv6
8trAAJ4ssFQXXcJeIVR4BxkaEZJmlRBQjwCgpVPn0Ey/cFIObGRlGcxK/SnGIK4=
=Rmz6
-----END PGP SIGNATURE-----

--y36rbmittdiwjmsw--
