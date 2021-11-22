Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0A6345933C
	for <lists+linux-pm@lfdr.de>; Mon, 22 Nov 2021 17:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240287AbhKVQl7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Nov 2021 11:41:59 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35594 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240038AbhKVQl6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Nov 2021 11:41:58 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 4CDF21F44C68
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1637599131; bh=9X4bhwm0j23IiOyBdPvQRq7wfOl6P4EjOM/oyJTdvko=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vv9TQjW8rwFH1gUTLE36Wjs6QY9lsedmkK2vOBLVLCF1ZVOFLkhwTDnw3lmIJZ6c9
         t9A6SUeE3Gc58b++IfzEFkIZjukyQWArUdZcIeR+MeAB2wQwQkzB5x++qKMDC5WNXj
         XcqNFne97jVsi7NJSVvXGfHtFhVTx6I7+qQfrbmDL1VSWReWhMK5VKvO0o2LTrCx1h
         ZFdNRtrnHbxc1uc10fPjlbSlHW9X2tsptq6M77TCX9gOGHL7ilql0Ra9CIfQhdGkUy
         jDLA0nK8znJdsMqCrFpVSqZng+YMcCqg2JqXxf7Zsl9Cz9rrweCA/hfbw0w3qThBg6
         qphwYA9AzWOhg==
Received: by earth.universe (Postfix, from userid 1000)
        id 773963C0F9E; Mon, 22 Nov 2021 17:38:48 +0100 (CET)
Date:   Mon, 22 Nov 2021 17:38:48 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 00/16] AB8500 charger to use power_supply_battery_info
Message-ID: <20211122163848.ivr3uehebusxrjnx@earth.universe>
References: <20211120155326.2891664-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lsqrsjd33oisvsup"
Content-Disposition: inline
In-Reply-To: <20211120155326.2891664-1-linus.walleij@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--lsqrsjd33oisvsup
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Nov 20, 2021 at 04:53:10PM +0100, Linus Walleij wrote:
> This is the first set of patches starting to migrate the
> AB8500 charging code to use the struct power_supply_battery_info.
> We drop some cruft along the road.
>=20
> This series does not add anything to the struct, just reuse
> what is already there. Adding new stuff comes in the next
> patch series.
>=20
> The AB8500 charging code has not been in working condition for
> some time, but it is slowly getting there. Some of this is
> just regular maintenance.
>=20
> ChangeLog v1->v2:
> - Fixed review comments on patch 1.

Thanks, queued.

-- Sebastian

> Linus Walleij (16):
>   power: supply: ab8500: Use core battery parser
>   power: supply: ab8500: Sink current tables into charger code
>   power: supply: ab8500: Standardize operating temperature
>   power: supply: ab8500: Drop unused battery types
>   power: supply: ab8500: Use only one battery type
>   power: supply: ab8500: Standardize design capacity
>   power: supply: ab8500: Standardize technology
>   power: supply: ab8500: Standardize voltages
>   power: supply: ab8500_fg: Init battery data in bind()
>   power: supply: ab8500: Standardize internal resistance
>   power: supply: ab8500: Standardize termination current
>   power: supply: ab8500: Make recharge capacity a constant
>   power: supply: ab8500: Standardize CC current
>   power: supply: ab8500: Standardize CV voltage
>   power: supply: ab8500: Standardize temp res lookup
>   power: supply: ab8500: Standardize capacity lookup
>=20
>  drivers/power/supply/ab8500-bm.h       | 123 ++----
>  drivers/power/supply/ab8500-chargalg.h |   8 +-
>  drivers/power/supply/ab8500_bmdata.c   | 572 ++++++-------------------
>  drivers/power/supply/ab8500_btemp.c    |  61 ++-
>  drivers/power/supply/ab8500_chargalg.c | 315 +++++++-------
>  drivers/power/supply/ab8500_charger.c  | 536 ++++++++++++-----------
>  drivers/power/supply/ab8500_fg.c       | 371 ++++++++--------
>  7 files changed, 804 insertions(+), 1182 deletions(-)
>=20
> --=20
> 2.31.1
>=20

--lsqrsjd33oisvsup
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmGbx5AACgkQ2O7X88g7
+po3uA/9FIih3f1qmCMK4JEQ6JJMTfjzWMkSVzyP7PaAa72GeNVbmRFOoQkgnWG7
RlgDwPHtTJ9OOKTbR63MJBaiXsMzKNNUwNvpF66E/dkDFh8fhxW9DHjffv5jp87N
l9lig0uTiC+O83ddNa0urjZz2MLlewid6fcSSotqUAgeZg6wQd5D2VvL0bglQJZu
TLDptTtWUTVf7bmwdwvujv292df2eNAF7wMcX3ymmB7V+Xh5fuSzNpED6/O9NegB
a1zCefzIgFkedAlIQGOQI7LEk3cBaCz1E78J6PsnDURI7Vec5tB0L3A43For9oDY
uMwsWrRlDbeHWg3H4owM+icNRAkMnznd4Bd+BKP1FlORTqqYHAfsjZXZuRlUcwso
w4y8n2s0w3drGbrYCWeJm33JHz+VB5iUV9LCKn4NYuyowY86fCydIAR/hnAQUC0U
8i7dwLyXc/BBBPeAezN24i5WUioTWm9Zz+OjPefSNZtpvg9TM8Y3rGhKomxXzQ0u
+jOsuu/yF21F0XfTidbFPeJVyv779FovT8QDFn7oy6vBkuCdtQ6OQO3yjdh66DMy
qacQRD0UD5899vR5j1SKnGQws9vjQ7az8aob9olvxHQMfPP3WEYcRfbS79KlTlrl
Srd+FVq9Hyn5RGBOJHQIVro5+YJGRzLavHBeDd7VDoYEYbAGVdU=
=yxQu
-----END PGP SIGNATURE-----

--lsqrsjd33oisvsup--
