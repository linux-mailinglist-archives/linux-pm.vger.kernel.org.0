Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67A591C190A
	for <lists+linux-pm@lfdr.de>; Fri,  1 May 2020 17:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728997AbgEAPKU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 May 2020 11:10:20 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33368 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728907AbgEAPKU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 May 2020 11:10:20 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 5D5872A3111
Received: by earth.universe (Postfix, from userid 1000)
        id E3E583C08C7; Fri,  1 May 2020 17:10:15 +0200 (CEST)
Date:   Fri, 1 May 2020 17:10:15 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH 0/4] Add support for constant power-supply property tables
Message-ID: <20200501151015.mujptv2l4u25zbv3@earth.universe>
References: <20200413183853.1088823-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5zaj5g6pk2i4yygk"
Content-Disposition: inline
In-Reply-To: <20200413183853.1088823-1-sebastian.reichel@collabora.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--5zaj5g6pk2i4yygk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 13, 2020 at 08:38:49PM +0200, Sebastian Reichel wrote:
> This marks the properties and usb_types entries in
> struct power_supply_desc as const, so that drivers
> can constify those tables.
>=20
> Sebastian Reichel (4):
>   power: supply: core: Constify usb_types
>   power: supply: charger-manager: Prepare for const properties
>   power: supply: generic-adc-battery: Prepare for const properties
>   power: supply: core: Constify properties
>=20
>  drivers/power/supply/charger-manager.c     | 40 ++++++++++++----------
>  drivers/power/supply/generic-adc-battery.c | 22 ++++++------
>  drivers/power/supply/power_supply_sysfs.c  |  2 +-
>  include/linux/power_supply.h               |  4 +--
>  4 files changed, 36 insertions(+), 32 deletions(-)

I merged the charger-manager and generic-adc-battery patches with
Enric's RB, but took over Micha=C5=82 Miros=C5=82aw's variant for the other=
 bits.

-- Sebastian

--5zaj5g6pk2i4yygk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl6sO9EACgkQ2O7X88g7
+prCzg//Y18yhV7vntsqZSEr3OCYDfAnlpBM+NEuSWUbwUqpYkodz/0XduasK04x
XFKOtFxETtF7WvWsQOWmorFJqQMZ7I96i3Ft3pNA/3MgZ18gNF8Oe11ZeL2NK5c4
of3zH6t6zJ+YDGGY1GxiQZWvMclMcRmLCMeoEyWxJrMcKW+H9ALmtcJqbZc4Byxo
DdK4yCu0Bo/T9F/b0AK5Hq26P8V4bYshHGvzBWRKAeikML6BALobm4wU3MYaLR4N
KrAwEqTX8uOD7DXISWnSSTjJkwgmhbd0DKZh7ASF9/WmoXnI9fXQyvnXnOrBCHKM
eu89/JKSXmeJvK0WXt+pAqxbaq/JEWNSku42o8ORY5CXfG0wP4FpmaIbyG9dME/M
XPXiIPyhYhrl6jHJufy5jSXNzj9xpTin0Tq2dNhKzhTot/cvxQOkiAaC4qXTpE9Z
NEceoIRP30vlm2A9NDKOBiSMxHHiWHOlQvGf9/cp1z3wnF4ogPGV2zrtdLrvgSFZ
oaPPnp3tqaY2lAMNl+kily7iyJzLn8oDDyoOQozYmSGOpUzGIwo0XzPAGAMe+PSg
SnVVxl+YmSkMkql0pR3j+0lQ/tMv+Ly91LqBY5EsZJ/vBqnIYw6yFBH89ZbWjMcw
yTurC8PzzPRAuD5kPN5KZNNiecqTpCAbzOx6QGTzyvHlq2F6Asc=
=DT2b
-----END PGP SIGNATURE-----

--5zaj5g6pk2i4yygk--
