Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58E7D545396
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jun 2022 20:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238934AbiFISBU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Jun 2022 14:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbiFISBT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jun 2022 14:01:19 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2532C649;
        Thu,  9 Jun 2022 11:01:13 -0700 (PDT)
Received: from mercury (unknown [185.209.196.172])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9EA4E66017A8;
        Thu,  9 Jun 2022 19:01:11 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654797671;
        bh=5Y3AQzLeywES96Kh/yBOL0YLXC5PH+4Q1k1GL1ZgqU4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VUUlu6y5r818/A8/HzXcCQAIDFh3EFrwGVcKATh/wE0ejXg5gdnmOZSsBaYjFiOc/
         Chw+heWycuJaZ8UpxTcLI7vAUCyXg8fNxRoy7GPb6bc2ZnZb3H+OmcWf260wmLhML0
         El+SRXrrsY46b3baffeZIf7rOBBCiNPz3VWaCwXPnxMEiEVeg1WtkcGB1iwqnn5AU6
         aFuN+C+DPLmWTNFNzHeWYlTpSGb0TGdhTKB2WegAaxVvZrqHvYoIcGCBejdeyYySAx
         ylRFWJ4vM2+NsEoWuYWvuDSbsM7oVidnYaG1A2jP3HIdERZjlum8Ira88zekXIEB8y
         32lGsYZ1UdPSA==
Received: by mercury (Postfix, from userid 1000)
        id D9B8C10605B9; Thu,  9 Jun 2022 20:01:09 +0200 (CEST)
Date:   Thu, 9 Jun 2022 20:01:09 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Mark Gross <markgross@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 05/12] power/supply: surface_charger: Use client
 device wrappers for notifier registration
Message-ID: <20220609180109.yqbrgyj5wzi4sjor@mercury.elektranox.org>
References: <20220527023447.2460025-1-luzmaximilian@gmail.com>
 <20220527023447.2460025-6-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yjntcrry2unljjce"
Content-Disposition: inline
In-Reply-To: <20220527023447.2460025-6-luzmaximilian@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--yjntcrry2unljjce
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, May 27, 2022 at 04:34:40AM +0200, Maximilian Luz wrote:
> Use newly introduced client device wrapper functions for notifier
> registration and unregistration.
>=20
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

> ---
>=20
> Changes in v2:
>   - none
>=20
> ---
>  drivers/power/supply/surface_charger.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/power/supply/surface_charger.c b/drivers/power/suppl=
y/surface_charger.c
> index a060c36c7766..59182d55742d 100644
> --- a/drivers/power/supply/surface_charger.c
> +++ b/drivers/power/supply/surface_charger.c
> @@ -216,7 +216,7 @@ static int spwr_ac_register(struct spwr_ac_device *ac)
>  	if (IS_ERR(ac->psy))
>  		return PTR_ERR(ac->psy);
> =20
> -	return ssam_notifier_register(ac->sdev->ctrl, &ac->notif);
> +	return ssam_device_notifier_register(ac->sdev, &ac->notif);
>  }
> =20
> =20
> @@ -251,7 +251,7 @@ static void surface_ac_remove(struct ssam_device *sde=
v)
>  {
>  	struct spwr_ac_device *ac =3D ssam_device_get_drvdata(sdev);
> =20
> -	ssam_notifier_unregister(sdev->ctrl, &ac->notif);
> +	ssam_device_notifier_unregister(sdev, &ac->notif);
>  }
> =20
>  static const struct spwr_psy_properties spwr_psy_props_adp1 =3D {
> --=20
> 2.36.1
>=20

--yjntcrry2unljjce
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmKiNVYACgkQ2O7X88g7
+ppWPw/+LiV+GPK8dKvKt78fDYL5OdrW2zJFDZYcLWx+osdgMVT12yLidINyk4KQ
LRxSi1/d+dx7hdn/5yDf62d+O0s4iPN0gasyWnTxIesHOo7SxrR6+lIY7LqYTzJ0
UyLipqoZcIxswRRwG2+SBGMigRm9+rVR8Ii3p3/af7l+FPmgmfpfBswZgLC9CJlB
/EUXSoFGURzlRiyNhlBBjRaI28y9LneMzVorLSbZJtWjYfLAuQ8FB73LNbQeVwFm
uws8IqIadQs67oN/JL0gXnTIlGWstheISUji6bLv4UrsT102aY4e9zw5Vq2vjHw5
seoExnKsiwvXeXIwWpizr4Sz60SYzsszIXUnR3uL5fx7G2e9ixT07YC4iE/ocFRK
mcSNujLuVhy5BQGJtRvT7+wZi6Wzm2DIyPD9od1cjCGvZMeluBD49kWBE3IvgRuF
h5hII3XpwivvedDXolahgxrFp28iOS7RF8GXrQX0ErvWBCswvNFI4Y9m5ue12j4O
z2bH48l9HdyGWfhLPSuDe47td7S5GKJ2uPZc8nJqAxjkk8d+uVM1rGmU8ctu3Oj+
brBfUtKawJBobBoSZU1JG7rshRHRzCYFkHa7D6dxwCFwcdxWpDSoeuJTZWfTOgDf
mm58PIYInnWZ/6iQhjoeea/VFY5OM6+P3ZnevqgZ6AmohtlQVmo=
=pjwL
-----END PGP SIGNATURE-----

--yjntcrry2unljjce--
