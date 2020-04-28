Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93ABE1BCC2E
	for <lists+linux-pm@lfdr.de>; Tue, 28 Apr 2020 21:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbgD1TSV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Apr 2020 15:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728392AbgD1TSV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Apr 2020 15:18:21 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C868DC03C1AB;
        Tue, 28 Apr 2020 12:18:20 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 81E182A1F7F
Received: by earth.universe (Postfix, from userid 1000)
        id 6AB5E3C08C6; Tue, 28 Apr 2020 21:18:17 +0200 (CEST)
Date:   Tue, 28 Apr 2020 21:18:17 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Kejia Hu <kejia.hu@codethink.co.uk>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] power: reset: qcom-pon: reg write mask depends on pon
 generation
Message-ID: <20200428191817.jawbnvnyjnucxa3d@earth.universe>
References: <20200428070437.14016-1-kejia.hu@codethink.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="egloem2s3afwqov4"
Content-Disposition: inline
In-Reply-To: <20200428070437.14016-1-kejia.hu@codethink.co.uk>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--egloem2s3afwqov4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 28, 2020 at 08:04:37AM +0100, Kejia Hu wrote:
> Instead of hardcode the mask, it should be depends
> on which generation of pon it was.
>=20
> Signed-off-by: Kejia Hu <kejia.hu@codethink.co.uk>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/reset/qcom-pon.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/reset/qcom-pon.c b/drivers/power/reset/qcom-po=
n.c
> index 22a743a0bf28..4a688741a88a 100644
> --- a/drivers/power/reset/qcom-pon.c
> +++ b/drivers/power/reset/qcom-pon.c
> @@ -34,7 +34,8 @@ static int pm8916_reboot_mode_write(struct reboot_mode_=
driver *reboot,
> =20
>  	ret =3D regmap_update_bits(pon->regmap,
>  				 pon->baseaddr + PON_SOFT_RB_SPARE,
> -				 0xfc, magic << pon->reason_shift);
> +				 GENMASK(7, pon->reason_shift),
> +				 magic << pon->reason_shift);
>  	if (ret < 0)
>  		dev_err(pon->dev, "update reboot mode bits failed\n");
> =20
> --=20
> 2.11.0
>=20

--egloem2s3afwqov4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl6ogXIACgkQ2O7X88g7
+ppBBg//ddYN4j3A2I6mp+u5sDX/NidZ6aK5PjibvnU9+VeEPAHNhqOCzoDRla9u
++B6b/eeZVsJoJlC7nEML3dgwN/ABFgLZfSGGGryv4dDKqYlLzjXFhien7cfes6B
2V+/Ah8dxiqKmzSJaQk8Oj7EQC3/uw0JObDfTbdRATv0bSwixXR7rTNRrtR50nyV
hIJkscTpwYXQngd8x+9maIfUfmjGCogxgDYOhri9wHgup+nMJL/z/cD1yUTxxYt3
T5fta7yIK/5/6rhuLc1PMaXtLQ1A7FNyUc7jstzRywkCZTkRAo0oVky2FbZkXjNJ
0GRlqjsw16rB96o8r+IhUyAXwucVUEzv+OFuVPXApF7EQV+t/Ah+JFbbNnVDmvzG
0Tn/1SjSrG1inAAV2TEUe3GkfVTq54WYdVdGGufMbGY5ZLWzIhRmjMUzmr1Wmd77
bgty2YUDzaxoZYATSJ0lVPrNWV9cGAS8soVSD2VX1gIwIIlpUfgE2dKpudWysTFq
gc1ozU1F92vm/BhDHGnVumwNB6eFH2U9yqLgZCQno5qxqDCw9phJx1xCj47tuWEG
xJOCCp//DoBJNtiASuTXfO4ZD/ssK11O7fb7oD0DO+QiXeqEyu6/9bprsPVadEBS
394/hJ0jTodpdm9aA/iDj5b0Wz1n+X8NXwDLNqwPztpUs93T65w=
=54AQ
-----END PGP SIGNATURE-----

--egloem2s3afwqov4--
