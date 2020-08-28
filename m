Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEA7255D51
	for <lists+linux-pm@lfdr.de>; Fri, 28 Aug 2020 17:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgH1PG1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Aug 2020 11:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgH1PGZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Aug 2020 11:06:25 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85E5C061264;
        Fri, 28 Aug 2020 08:06:24 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 3ED9E297C3E
Received: by earth.universe (Postfix, from userid 1000)
        id 725F23C0C82; Fri, 28 Aug 2020 17:06:21 +0200 (CEST)
Date:   Fri, 28 Aug 2020 17:06:21 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCHv1 0/2] power: supply: smb347-charger: Cleanups
Message-ID: <20200828150621.3jnljnmv6vfcjxxa@earth.universe>
References: <20200826144159.353837-1-sebastian.reichel@collabora.com>
 <4d02de0e-7345-a937-7fce-66f4438a8144@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="thufmqsn3dey2koy"
Content-Disposition: inline
In-Reply-To: <4d02de0e-7345-a937-7fce-66f4438a8144@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--thufmqsn3dey2koy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Aug 28, 2020 at 10:47:21AM +0300, Dmitry Osipenko wrote:
> 26.08.2020 17:41, Sebastian Reichel =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > Please check the following cleanup patches for smb347 driver
> > do not break functionality on your Nexus 7.
> >=20
> > -- Sebastian
> >=20
> > Sebastian Reichel (2):
> >   power: supply: smb347-charger: Drop pdata support
> >   power: supply: smb347-charger: Use generic property framework
> >=20
> >  drivers/power/supply/smb347-charger.c | 305 ++++++++++++++------------
> >  include/linux/power/smb347-charger.h  | 114 ----------
> >  2 files changed, 167 insertions(+), 252 deletions(-)
> >  delete mode 100644 include/linux/power/smb347-charger.h
> >=20
>=20
> Thank you very much, very nice cleanup! I checked that the DT properties
> are applied correctly and everything works properly on Nexus 7 after
> applying this series just like it worked before, no problems spotted,
> charger does its job and battery is charging up fine!

Thanks for reviewing and testing them. I merged both patches.

-- Sebastian

--thufmqsn3dey2koy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl9JHWQACgkQ2O7X88g7
+prfpQ/+IRDWBY6Q3aUAFu8tNkU3d7poLNMq2wGkXrfcwGBb0PG0ynUUK146V7Q9
n32wbxTV3tuTWU6PRXNtZXymTYZmcKyRIQvd79qCOKX44JfuhVy4j+Bqey01BtcG
VBXfWqGMgSvCZpB4BeqeqOodenzlc4Vy8TGMY5qmFeyk9lXjZ3HdHZmpGGGzWN1Y
OuBXnE9Ez7TQJjVJXhyvSsTzcKGzHxUwkEPi43vQrtsHipDligFHV/8Y9lRFgpzp
wwSQHMxy8DHZq2FVQhqYSzPKW23ajhMR31T9CG6aopPBhG9U9ok7elmQfzRkytHb
VJLHTii8hYuIy3+4avjaFBoCqRte1r1K9ObdJPaP7u/dYHCdS7rH/BRObOo5K9na
EbAC/fl0llVCPcjwYeIfYJLQ8wh56YmZFRiU51efwfGgvueUfON1LM8S6Il4S4cx
R/xooNrfo2vqyNT3gbEacoQ2jhWEEeWy9B/UQlAjdnaIj7qbvajfibmTDbUF/LKB
RuSK/vrYYU+LNKfVCK7etBIHvo51KR0OcQVnyPOvkwYeO5WhSIjDIcVgDQdOLveo
RRIEBKoL1iFoPuFW/vxD9KqOru5rovLjy1Ms/tmSS/kt3t+NZiy5jm3I4pUcVhBY
z7+xdOnT7hHNAFoL86bAx+C4Pr3T9TrnMzYGp8E3uIyS99bkWdU=
=VC3e
-----END PGP SIGNATURE-----

--thufmqsn3dey2koy--
