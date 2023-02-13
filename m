Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A47C36951D0
	for <lists+linux-pm@lfdr.de>; Mon, 13 Feb 2023 21:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjBMUZr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Feb 2023 15:25:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjBMUZq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Feb 2023 15:25:46 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE36FC7
        for <linux-pm@vger.kernel.org>; Mon, 13 Feb 2023 12:25:45 -0800 (PST)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7F5B56602154;
        Mon, 13 Feb 2023 20:25:44 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676319944;
        bh=5TfMk39PWpo7zzGWYTfd0LxKrPSRhjabDjt21CsyO08=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ctVPOubi4ZqhyfaARPxy7yvWL4YeUz2Vq8nlJdhHeFVDRhqlKZ/YuIYz7RlKnRQTW
         ydilo+3fZqOVHwNjtLZVNSjWYh4S6DUSduHycGYxyFbxIZJ44tC6Bndn3CbuSlFawR
         WT28uHRoXnglpoJRDJxU6Hz5sSt2LaJtymA9vKulKGJNUxFkXB4i8GPIEpsYHdbMbG
         BqGyN1G7roiBkC01qsu/AhnojLprFUztQR+FBxo0TvLSDKdcHCDAaUmkyIA6P6MVS6
         32LMOSRCwmWwzGLGnswcTWeNpjKhGkuBdK6KT20/2RC3jvLDgnCAO7xk/6yEH39DKY
         oZKb1X6iWkUKQ==
Received: by mercury (Postfix, from userid 1000)
        id 4B1121060961; Mon, 13 Feb 2023 21:25:42 +0100 (CET)
Date:   Mon, 13 Feb 2023 21:25:42 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Daniel =?utf-8?B?R29uesOhbGV6?= Cabanelas <dgcbueu@gmail.com>
Cc:     linux-pm@vger.kernel.org
Subject: Re: [PATCH] power: reset: linkstation-poweroff: add LS220D/E
Message-ID: <20230213202542.aqsw6tzspo4nrq7n@mercury.elektranox.org>
References: <4927895.GXAFRqVoOG@tool>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y5jxko7cawj5pcwy"
Content-Disposition: inline
In-Reply-To: <4927895.GXAFRqVoOG@tool>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--y5jxko7cawj5pcwy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Feb 12, 2023 at 05:37:38PM +0100, Daniel Gonz=E1lez Cabanelas wrote:
> Add 2 new devices to the compatible list:
>   - Buffalo Linkstation LS220D
>   - Buffalo Linkstation LS220DE
>=20
> Signed-off-by: Daniel Gonz=E1lez Cabanelas <dgcbueu@gmail.com>
> ---
>  drivers/power/reset/linkstation-poweroff.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/drivers/power/reset/linkstation-poweroff.c b/drivers/power/r=
eset/linkstation-poweroff.c
> index 02f5fdb8f..cfee2efd9 100644
> --- a/drivers/power/reset/linkstation-poweroff.c
> +++ b/drivers/power/reset/linkstation-poweroff.c
> @@ -142,6 +142,12 @@ static void linkstation_poweroff(void)
>  }
> =20
>  static const struct of_device_id ls_poweroff_of_match[] =3D {
> +	{ .compatible =3D "buffalo,ls220d",
> +	  .data =3D &linkstation_power_off_cfg,
> +	},
> +	{ .compatible =3D "buffalo,ls220de",
> +	  .data =3D &linkstation_power_off_cfg,
> +	},
>  	{ .compatible =3D "buffalo,ls421d",
>  	  .data =3D &linkstation_power_off_cfg,
>  	},

Where is the patch adding these compatibles to the DT binding
documentation?

-- Sebastian

--y5jxko7cawj5pcwy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmPqnMUACgkQ2O7X88g7
+prZkxAAhgmgL3vvfGo5MLnkd8omtFOIYaGDviMJ1a9PSODtKY1rQm7tUFtZ7wP5
eLSDjKg2UF/6J5AAnI+qT2euLCgltKj4WwcUf0l+/8v6mcR8MISVj1iKFKzmEMYq
EFpV5tbHq/cjdM1oFyyMslKxGkq9I+T8+rRhf+BXq1oEtaurdlmAi+g2qHYYuS0k
/ksliVD2vCWO2GBa/B5ouH6Wc/acn+3O5esy5iHNRfUccyf88O88E/rqUfPUeFQS
CL3Nh0nTG02Ih+HsRCyu2Ze9pWv+qE3uX4F2AkmznbMcN52NguiFvOZNbVCUxVfP
ZkwANHtblIK6s91hE7Sa0wjG5NSgZ0X8KcKDQJdKFNibngYwifkhpswMV8z0JRLK
YiQy+OL9luQgF07skHXQMX3XrcFmvTlSr6ExTTQfnMPkzk7Df9hxDNJeQobRpr4A
+/QgHtTm1f5aUuAiwf+lo2nJhwD1sREsmv/9yQnsUysILoDGqKZNQHP0ahC000to
4FrM19cTde84IEssok3t0yYoxwPw7Aew4yYpaSzVegpoixgcDiP9b98bU4hrLGBx
1/kItMHHVfIuxj+D3A9drQNF6Se+Dsb9RRk3VOu2vD7Dpb+aVwYsMZfHCa1H/h88
/huJx4fDfoO9aCmMCd/LexrrWPJmQT3V2DIKgpTrX8dpUXhZ40Y=
=azu2
-----END PGP SIGNATURE-----

--y5jxko7cawj5pcwy--
