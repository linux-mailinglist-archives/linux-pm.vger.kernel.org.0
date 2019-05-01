Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86A4B10F13
	for <lists+linux-pm@lfdr.de>; Thu,  2 May 2019 00:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbfEAWnG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 May 2019 18:43:06 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37442 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbfEAWnG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 May 2019 18:43:06 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id F07E92639E2
Received: by earth.universe (Postfix, from userid 1000)
        id 595FA3C0D1B; Thu,  2 May 2019 00:43:02 +0200 (CEST)
Date:   Thu, 2 May 2019 00:43:02 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-pm@vger.kernel.org, Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Enric Balletbo Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/3] Driver for UCS1002
Message-ID: <20190501224302.o5ydj253synve6wl@earth.universe>
References: <20190501033434.18548-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n44xbk2hl33sq6zz"
Content-Disposition: inline
In-Reply-To: <20190501033434.18548-1-andrew.smirnov@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--n44xbk2hl33sq6zz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 30, 2019 at 08:34:31PM -0700, Andrey Smirnov wrote:
> This small series adds a driver for UCS1002 Programmable USB Port
> Power Controller with Charger Emulation. See [page] for product page
> and [datasheet] for device dataseet. Hopefully each individual patch
> is self explanatory.
>=20
> Note that this series is a revival of the upstreaming effort by Enric
> Balletbo Serra last version of which can be found at [original-effort]
>=20
> Feedback is welcome!

Patchset looks good to me (except for the indention issue).

-- Sebastian

--n44xbk2hl33sq6zz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlzKIPYACgkQ2O7X88g7
+pqNLRAAkY95bhDG6g1qJtAYZ8gFvVWHVckBHUobqlNSl+pR5I5+oCvDOJXRb8Uk
N1P4dm2/4uVdzrpM5JGYsLS8iOYjkhmZSbBJEMTqW44sp6dm6hr8zIITjHzJvCA6
rnV1BjjjOb8fK/ORZYKzU4Y0o+GSPJnbjR9dPTkL+el5Ny0T5H4Iq++fc1lJTGNl
hN1R8tLp4kN4B8Ku/nFIcbivIOS2P9RdOh6nq28oyCVKLgSu/45QNPzG55bH+KzG
9BuNoSNwpHygY1qXLB8CWOBteeCfO+5E5GKyWFOrZqdGMSrLJ2UavKdV7WZ0uUNd
GGncWjbIf6UARekeK7vaT59QFbPoRwBwwPI4dVJJM+Zt18V/sxzTbI68xGzOAsWe
NK6chymww6w64aXd+c07BKke9+uQyj5nY/fYe2i4xjdfJ5IW2R2u3sILZLSU+dqd
pYprce94mdoZausZVxYaRoFo0GFM5zSfLDOYj1sigqip/8C1gAMAtPO33D4MLOp0
p9dcVZOGyrJ0uTnxBrWuP4nSkc0Shh8G+1m6qpoVJ9ilhf+YCp1PW7VNaVyWJOcs
pjmER4uRJv5OYZ6RCqAJj1LesY9RTXzfm7nWWe+ZRF5m6e+cn+XOBBhVJEiLQFkN
J8q+NHLHl8ankKkbZ3kMK0BxVItHQfI0PB3ixlgraf+75TkIk8M=
=JQiP
-----END PGP SIGNATURE-----

--n44xbk2hl33sq6zz--
