Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBCC1258E9
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 01:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbfLSAyo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Dec 2019 19:54:44 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39278 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfLSAyn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Dec 2019 19:54:43 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id AFFC52911A3
Received: by earth.universe (Postfix, from userid 1000)
        id 759783C0C7B; Thu, 19 Dec 2019 01:54:39 +0100 (CET)
Date:   Thu, 19 Dec 2019 01:54:39 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        yuanjiang.yu@unisoc.com, baolin.wang@linaro.org,
        zhang.lyra@gmail.com, orsonzhai@gmail.com
Subject: Re: [PATCH v3 0/5] Improve the SC27XX fuel gauge controller
Message-ID: <20191219005439.63nk4fpraveoeqyv@earth.universe>
References: <cover.1575863274.git.baolin.wang7@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qluf4zgj5ugicewn"
Content-Disposition: inline
In-Reply-To: <cover.1575863274.git.baolin.wang7@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--qluf4zgj5ugicewn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Dec 09, 2019 at 11:56:20AM +0800, Baolin Wang wrote:
> This patch set adds one battery resistance-temperature table to optimize
> the real battery internal resistance in different tempertures, and
> calibrates the resistance of coulomb counter to improve the accuracy
> of the coulomb counter.
>=20
> Any comments are welcome. Thanks.

Thanks, queued to power-supply's for-next branch. I changed the
comment for struct sc27xx_fgu_data, so that it states calib_resist
being in uOhm instead of mOhm.

-- Sebastian

> Changes from v2:
>  - Add reviewed tag from Rob.
>  - Rebased.
>=20
> Changes from v1:
>  - Fix the order of values in resistance-temp-table property's descriptio=
n.
>  - Add an unit suffix for FGU resistance property.
>=20
> Baolin Wang (4):
>   dt-bindings: power: Introduce one property to describe the battery
>     resistance with temperature changes
>   power: supply: core: Add battery internal resistance temperature
>     table support
>   dt-bindings: power: sc27xx: Add a new property to describe the real
>     resistance of coulomb counter chip
>   power: supply: sc27xx: Calibrate the resistance of coulomb counter
>=20
> Yuanjiang Yu (1):
>   power: supply: sc27xx: Optimize the battery resistance with measuring
>     temperature
>=20
>  .../devicetree/bindings/power/supply/battery.txt   |    5 ++
>  .../devicetree/bindings/power/supply/sc27xx-fg.txt |    3 +
>  drivers/power/supply/power_supply_core.c           |   67 ++++++++++++++=
+++++-
>  drivers/power/supply/sc27xx_fuel_gauge.c           |   49 +++++++++++++-
>  include/linux/power_supply.h                       |   10 +++
>  5 files changed, 130 insertions(+), 4 deletions(-)
>=20
> --=20
> 1.7.9.5
>=20

--qluf4zgj5ugicewn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl36yk8ACgkQ2O7X88g7
+poFRA//ZbDQYkhRD6/Q/fzYBgBG46iBNRtyH3Tt6DDbLi5YmKjUfS27L2gXusg7
bL44L/IGuDNLsVa8gMQrmYpznn8BjARgZD5JDcejaTl0Vxe/dPxTnjP1hlxss5rQ
FYm4D9W7Fsy30B5QSz1C6ZjOaDE2HOGb/M9ctn/MPVJwWGIHzMtKjHqJ8gu/5K9P
Afs5pRNaXtX7MUP45T2CODJG+gNqQy5/hdNyQMcCm9JJ2KuD56Qo5JHcuFY+Z3iz
n+ycAYrfCp66Aeape0ZemWa0d/rtH6fZ6rpON15KZ/759a+gGDhribDTuqVtZEu0
iolyC8pUm4MIh2YREsSbwZhr4hGnMcM1kZz4d+x4q2JeSKZXnMaXr4ZL3wjdqUYj
eV1FHzTvQ623yks3/YGjlBx414T5mPGaswuMdqwssEjkCwojXykxiAfdWNXkPaHs
0Pq4V/0SzuHro64JWeZVX7kBnymO/7XFTm1jdM6jcbEjmukPxY7PEC6xbaiUIjkQ
lj8TzPR2vF+WDyIY1BKVyDdsgQaeIW2n+2ZTOZfGm0qZ7emN53z7NWWmx3VEYdKj
LS6FvpQzDI1LOH7uO75SeksubEBqTt4xlJ5MwFD4Pk6s4zI+44bUDR1CCoJpedne
RobZE/OVQ7VELZqWZOeXYF6KfyVEZj0qDVl8ByszqPLMVYeL74Q=
=YEHq
-----END PGP SIGNATURE-----

--qluf4zgj5ugicewn--
