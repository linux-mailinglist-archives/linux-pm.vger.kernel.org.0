Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E7354539C
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jun 2022 20:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbiFISBp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Jun 2022 14:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbiFISBp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jun 2022 14:01:45 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12380340D1;
        Thu,  9 Jun 2022 11:01:44 -0700 (PDT)
Received: from mercury (unknown [185.209.196.172])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D415A66017BA;
        Thu,  9 Jun 2022 19:01:42 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654797702;
        bh=COv9YkbXDTMR+TEI4D5j7tkKFAMKfvJAEv9mCgLuZ2Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hvPjhnr9dKTtoNpC1ASRBt+5tljQSro6Z61Aeu1Ks0AG/ImJJiKQKTWpHPZ3MNQ0v
         7ZL8u3ZOwjW+uJ1fTtc3NhhYRJuQdCrgg4YV4kw0dcQJPCWkRSuVHTcPvwADG6FX/K
         QDt72P/e/6P/fJDmwGLpLCR2JomHU2IpgBeMAhFo2FcfX9GWxLHjgEGhvAMsQyKUXc
         0ym062ENJUm+GRtlzGd/nn25j6e9JnN64IbufBi33lg2E1E1ydVSX0fopyoJdRt/2+
         8LYA6iRk1SfBhtOnrA66IxpSu72Dkt0h9M7cbWH/DV0sInodLNH3MAtoJhZ52Rb/YN
         FC+2jvIRPHHpw==
Received: by mercury (Postfix, from userid 1000)
        id D9FF510605B9; Thu,  9 Jun 2022 20:01:40 +0200 (CEST)
Date:   Thu, 9 Jun 2022 20:01:40 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Mark Gross <markgross@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 06/12] power/supply: surface_battery: Use client
 device wrappers for notifier registration
Message-ID: <20220609180140.zlpqsj7aqxihrxis@mercury.elektranox.org>
References: <20220527023447.2460025-1-luzmaximilian@gmail.com>
 <20220527023447.2460025-7-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="266k64e73ouevr3e"
Content-Disposition: inline
In-Reply-To: <20220527023447.2460025-7-luzmaximilian@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--266k64e73ouevr3e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, May 27, 2022 at 04:34:41AM +0200, Maximilian Luz wrote:
> Use newly introduced client device wrapper functions for notifier
> registration and unregistration.
>=20
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
> ---

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>=20
> Changes in v2:
>   - none
>=20
> ---
>  drivers/power/supply/surface_battery.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/power/supply/surface_battery.c b/drivers/power/suppl=
y/surface_battery.c
> index 5ec2e6bb2465..540707882bb0 100644
> --- a/drivers/power/supply/surface_battery.c
> +++ b/drivers/power/supply/surface_battery.c
> @@ -802,7 +802,7 @@ static int spwr_battery_register(struct spwr_battery_=
device *bat)
>  	if (IS_ERR(bat->psy))
>  		return PTR_ERR(bat->psy);
> =20
> -	return ssam_notifier_register(bat->sdev->ctrl, &bat->notif);
> +	return ssam_device_notifier_register(bat->sdev, &bat->notif);
>  }
> =20
> =20
> @@ -837,7 +837,7 @@ static void surface_battery_remove(struct ssam_device=
 *sdev)
>  {
>  	struct spwr_battery_device *bat =3D ssam_device_get_drvdata(sdev);
> =20
> -	ssam_notifier_unregister(sdev->ctrl, &bat->notif);
> +	ssam_device_notifier_unregister(sdev, &bat->notif);
>  	cancel_delayed_work_sync(&bat->update_work);
>  }
> =20
> --=20
> 2.36.1
>=20

--266k64e73ouevr3e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmKiNYQACgkQ2O7X88g7
+ppseA/+ObGFViG58wz5J1z1VWkyOsN3F66FzFlDxrZjD28yt8eJFmB9wLetJIqM
EBa6o+WrcjFL/LvPA6se2eRQb1aZ/FRN/0jmJtPXUQsqhY+Uk2ZNNfuPq4U3PQCY
TvS2z/VAApl2BMmofrfXTs1uxd92GF6Kdku3CED/xod7xG3VllJbD6mnEGkPB2NA
0TNr+WhRiw4dCu0+2BkaG4+Ou7Yqnyo180+TXmrxTaf4N9lhncGmlHSIO3fDb1dZ
abpDyCcoKRZbH/ndfal/kTa5TFxhqMADSKywckyJioKIDWkOHaeOvu/dPG2H/8dm
Q0hHEVtrvuwRnj4/6THG/R5Ul0FG7RP2k3FLrpGbd5JFy8Mjf8klUfB65z990Sis
aPI8xETfAng1LRAOk9x/yw40KczVSReSkJuy5LuIAqMWkWv8/+4AEi+MsHByRzGM
v5Thmbaue0kaUPSZEndWJiHUgdM7Ej+g6cjnzr4ChS7wF4/THWQpKU5a3ZjNqHro
2ZIePAd3tYKfhr69NJD/Zsm7BFoQ5E+lgLvcCSDvCrXbffzj5dHLZCeBNgeJU0zG
ipEOEhgh97/813eKwFUOQGMiBtnsnRU2/tNWewOuX+J7CEJwbM8kBVga/mvnwO1L
tsorCNhcwyM/a5GO9uUkOkVCYMthgRuTabgqJLubZVgsnFppS9M=
=PM8u
-----END PGP SIGNATURE-----

--266k64e73ouevr3e--
