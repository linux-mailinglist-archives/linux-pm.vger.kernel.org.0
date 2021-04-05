Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDCF435410D
	for <lists+linux-pm@lfdr.de>; Mon,  5 Apr 2021 12:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240938AbhDEKDC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Apr 2021 06:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbhDEKDC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Apr 2021 06:03:02 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F94C061756;
        Mon,  5 Apr 2021 03:02:56 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id CAFE11F44D7D
Received: by earth.universe (Postfix, from userid 1000)
        id 9F8CE3C0C96; Mon,  5 Apr 2021 12:02:53 +0200 (CEST)
Date:   Mon, 5 Apr 2021 12:02:53 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmurphy@ti.com
Subject: Re: [PATCH v5 0/2] Introduce the BQ25790 charger driver
Message-ID: <20210405100253.qjf3u7u37lqh5mpt@earth.universe>
References: <20210202021747.717-1-r-rivera-matos@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="o4sdkivip26urrbr"
Content-Disposition: inline
In-Reply-To: <20210202021747.717-1-r-rivera-matos@ti.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--o4sdkivip26urrbr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 01, 2021 at 08:17:45PM -0600, Ricardo Rivera-Matos wrote:
> This patchset introduces the BQ25790 integrated buck-boost charging IC.

Please add changelogs compared to previous version to
your cover letters.

> Dan Murphy (2):
>   dt-bindings: power: Add the bq25790 dt bindings
>   power: supply: bq25790: Introduce the BQ25790 charger driver
>=20
>  .../bindings/power/supply/bq25790.yaml        |   95 ++
>  drivers/power/supply/Kconfig                  |    8 +
>  drivers/power/supply/Makefile                 |    1 +
>  drivers/power/supply/bq25790_charger.c        | 1100 +++++++++++++++++
>  drivers/power/supply/bq25790_charger.h        |  148 +++
>  5 files changed, 1352 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/bq2579=
0.yaml
>  create mode 100644 drivers/power/supply/bq25790_charger.c
>  create mode 100644 drivers/power/supply/bq25790_charger.h

FYI: I don't have further review notes and wait for a new version
with the things pointed out by Krzysztof being fixed. For cleanup
of usb_register_notifier you might want to check how you fixed the
same issue for bq256xx via bq256xx_charger_reset() or my ignored
comment in v4 patchset.

Thanks,

-- Sebastian

--o4sdkivip26urrbr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmBq4D4ACgkQ2O7X88g7
+pqoCw/9EJV3eqvyVbAUdbPAN0r8CkKvxSdrenSBsIhm/XDfEnlb/35PDnOj9fKc
rkXuKWkBucXt1kVCqzvp5atD4zPx3kYtqOTR6TB9zVEZeKFC3pik9fkIQPMD3TcC
bSotGYQhAo+yWNEAAgcf1Is/N82Z8lHanMtuwEIi/DQfK8IfuQaEYigkOZPdY7dY
xiJknYbHJGXRAjOBkJpGJZc3vSOxu6oRbYphHBsvYoj2NavIwHRM6vsmiMmpGLnq
0PCK1uDzthz7DxmEXdGKO2uuYT+41ptfV+RNtX7auairOvjX5j8w65zrSEv3HWUo
9BkF687Gt8XfaMWaCZ+zE2u4i/A/8gUrdqoV7+YGJ72y39GgZtnXQgu3v9nQZMSV
2famp4WM7caK88qRDtTsOBlh02nYXHpmE3G4TClj2R745hh7rzqPvcgacOZF9I8v
5HorsO7hpqEOZkx8gjVs4AGO1kpDTNYCHYg6puGuVo4v6kgccdtfdQPeUzfvDJqI
JrUleoP0K0VB10855RuUZAJE1D+uLrJgTTYx/BYPcVY15eseky9qMB2Yo5G7v5vS
qpm686vlYWJUtfjmDokFDYY8AIbwRZe67W1Ef4r5pyHHxvUqBrC/CLb94ooPTvu0
ogqBV6HNkexVUEhRaablDdA3sDQNZdP7nEJQ88/rqhUVhjuWLT0=
=AYAc
-----END PGP SIGNATURE-----

--o4sdkivip26urrbr--
