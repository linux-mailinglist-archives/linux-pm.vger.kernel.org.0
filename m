Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70F112D8AA7
	for <lists+linux-pm@lfdr.de>; Sun, 13 Dec 2020 00:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408207AbgLLXle (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 12 Dec 2020 18:41:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:58570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbgLLXle (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 12 Dec 2020 18:41:34 -0500
Date:   Sun, 13 Dec 2020 00:40:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607816454;
        bh=IRujUVtreylw0+PBKywjFwsnU/zYpoP/tmAGqCPhPAM=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=aXJPQrxJ48EczxHTnP0DXoStESAGh6aYNDlBNcHs94k1ZuW2NkqUVsbVGqOgu2zDF
         wzTZvEaKfbzPjLgDL0WQ4hmhWAlFij++JZTwUIrkUtDTk/54C9W82ypePrA9I6uTyA
         65FiInfrPlzpThDcXfFVBzI1bLFXaP1kHnYPICPxcMn5/gyT6wy0F93xr3N3tQFCxv
         Ns/WACxFc36vcKcWQD3OCcXz3Hfd2iDaN/6G4imOc6orGcPwu1pTw11kH7UgVdLdrp
         jzA3NaYUE0lWmjmSvf5e+zLqnSHZ8qXh95WQAWrZZjkaEnv6Lv9cnXd0/lnP0WGfUm
         yGzzLHssPonCA==
From:   Sebastian Reichel <sre@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Marcus Cooper <codekipper@gmail.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 0/5] power: supply: ab8500 charger cleanup
Message-ID: <20201212234052.sjses3ieh7pwii3j@earth.universe>
References: <20201212105712.2727842-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ql7xhbhw4tzo74no"
Content-Disposition: inline
In-Reply-To: <20201212105712.2727842-1-linus.walleij@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--ql7xhbhw4tzo74no
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Dec 12, 2020 at 11:57:07AM +0100, Linus Walleij wrote:
> This patch set is a first set of cleanups for the AB8500
> charging code, I'm trying to bring this to a working
> state. The code has seen some bitrot since it was merged
> a few years back.
>=20
> Notably it makes the code probe properly when enabled.

Thanks, queued!

-- Sebastian

>=20
> Linus Walleij (5):
>   power: supply: ab8500: Use local helper
>   power: supply: ab8500: Convert to dev_pm_ops
>   power: supply: ab8500_charger: Oneshot threaded IRQs
>   power: supply: ab8500_fg: Request all IRQs as threaded
>   power: supply: ab8500: Use dev_err_probe() for IIO channels
>=20
>  drivers/power/supply/ab8500_btemp.c    |  66 +++++++--------
>  drivers/power/supply/ab8500_charger.c  |  99 ++++++++++-------------
>  drivers/power/supply/ab8500_fg.c       | 106 +++++++++----------------
>  drivers/power/supply/abx500_chargalg.c |  19 ++---
>  4 files changed, 116 insertions(+), 174 deletions(-)
>=20
> --=20
> 2.26.2
>=20

--ql7xhbhw4tzo74no
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl/VVPQACgkQ2O7X88g7
+prfQg/+NBM9OJoSuIjDs6x4dCmU+yB5PvZ1Ws1cmMJ11KVr0LnuAh9Rymy5pTAK
TyEIHYx0wOftjxI9XJZJZsnx1OMbXXCzrm9YJ5pjDAj1AbKbmaP5FzqR6cBBwD3j
tPomHBkUoIfbIyvkRgO/6Y/BiGqUKya6erBmKY0R33RcYt7iTOG5W4OpBzc73OP5
D4gs879cA7D1Q6bzNr2r/w4/8a/Zno8VW4bY3em7+A83aogI5PV4iuEYOLZdVfvB
sF7T0aSqcUp2mIrHTdoA//NPFaA/KwZ6kjpTaCeEnMuoT+HSo2o61ltXCtJ2GSXO
JYjgdPCRCkX1JLj8eX3YEd+SeAaU0aF0P/WVka7qrQnz8uekej5LKIP4hGgFsSAQ
PicL3dbcV/LxR2pC6xo4T04Usi5jEMoSHgWVV0mtJ5P43+ZObI4Tb/qeu2F8cNWo
2/w0sY3uRx4huodV+NjV/L5N3n0fy2KG3ixtsJhWCWy6XXPu/InJsp5VcA0v7xPw
kkbUWwaNyw021kUXlw3qbAVmuh+25M81/DfKSmi0WHn7ThBa7dRQoQEkxA9vtgpM
MKDo5oDXVRX676jd405EJ1eCGm1ChIjVQsBaAlJvnEjIjoG/+MOfb+H25b07EEte
HuAVEa/8yy6nDA/n6GhmNzhLd0cgoJ+9tAInB/C7CvVw9+nO3Dk=
=24wV
-----END PGP SIGNATURE-----

--ql7xhbhw4tzo74no--
