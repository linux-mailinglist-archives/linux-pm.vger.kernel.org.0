Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 106E02EC4EC
	for <lists+linux-pm@lfdr.de>; Wed,  6 Jan 2021 21:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbhAFUcc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Jan 2021 15:32:32 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59958 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbhAFUcc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Jan 2021 15:32:32 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 740C91F4609F
Received: by earth.universe (Postfix, from userid 1000)
        id 702733C0C94; Wed,  6 Jan 2021 21:31:48 +0100 (CET)
Date:   Wed, 6 Jan 2021 21:31:48 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Cc:     robh+dt@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmurphy@ti.com
Subject: Re: [PATCH v10 0/2] Introduce the BQ256XX family of chargers
Message-ID: <20210106203148.vl274vshztry5nka@earth.universe>
References: <20210106195849.9489-1-r-rivera-matos@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yo3hchluwdbo56sy"
Content-Disposition: inline
In-Reply-To: <20210106195849.9489-1-r-rivera-matos@ti.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--yo3hchluwdbo56sy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ricardo,

On Wed, Jan 06, 2021 at 01:58:47PM -0600, Ricardo Rivera-Matos wrote:
> Hello,
>=20
> This patchset introduces the bq256xx family of charging ICs. The bq256xx
> ICs are highly integrated, buck, switching chargers intended for use in=
=20
> smartphones, tablets, and portable electronics.
>=20
> Ricardo Rivera-Matos (2):
>   dt-bindings: power: Add the bq256xx dt bindings
>   power: supply: bq256xx: Introduce the BQ256XX charger driver
>=20
>  .../bindings/power/supply/bq256xx.yaml        |  110 ++
>  drivers/power/supply/Kconfig                  |   11 +
>  drivers/power/supply/Makefile                 |    1 +
>  drivers/power/supply/bq256xx_charger.c        | 1745 +++++++++++++++++
>  4 files changed, 1867 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/bq256x=
x.yaml
>  create mode 100644 drivers/power/supply/bq256xx_charger.c

Thanks, I merged this patchset. I fixed up another pointer issue
in bq256xx_state_changed() while applying the patch. Before the
state probably always "changed" for you, so please check everything
works as expected :)

Thanks,

-- Sebastian

--yo3hchluwdbo56sy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl/2HiwACgkQ2O7X88g7
+pqcSBAAgAvPDJyrXLuezyhALKIYpEHO3NDbaghLiCRhqhu13rmXbHXaTO0NDMh4
uY/EM4AzXKiEHoIGC1e1KT8853Ui3MODdKbgCDkDB8iiSftXlx3qgRFNQXzPazvk
YUkX5WSRDDoSU23FAr+mUuI5SjQu8zqCANg8Ra5U1Bg6pB+iWmpP3WCYTYIRWRKv
tT0auUhtR1bHbWoMvduDArtwplDoecHJym+pGjoov7MM2tn5zwQkbNfa3wjeciEy
LY2Jp4oyKxc+0el3DD7PMdPk2YYnNm3dF4NCes10uQ0cROaz9CmEOfvJyz8WX/ge
fpNFpV+0POjqlHRPtqzAZ5SpF0pKG2wz3tneuAAKB7SZfOJz+AfAWsqv/TVIyjv7
ZF01g71kkJUG4Mz0KqxjKgF4VlKLHHp42au60K+3SlTYc3Eo/vv1Y0lckh6hrUuW
suQiPuI4kni9jaeBPd2ywFm+V3Q2CuGKFx+krqNU/p9C4jsSgCdQgAy1QE3h7ggA
SatYBqD1Whk/r5ih7nhJTbH8Gvq5mvvv0qHoCKql1HRmG9V0PLrG23jFctG1T97B
6urt26Sw+4zs34jeKpifMdbLvhah8WhYspw641Ppcer94B9d+Et+kxf0D8Dk/hTL
6T+gRb8ZfUgUdwBlr/UAvjjBEfh9+rfdoP4yTCWCftJgINt9EUU=
=EC5H
-----END PGP SIGNATURE-----

--yo3hchluwdbo56sy--
