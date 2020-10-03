Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6152826ED
	for <lists+linux-pm@lfdr.de>; Sat,  3 Oct 2020 23:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbgJCVvF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 3 Oct 2020 17:51:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:57024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbgJCVvF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 3 Oct 2020 17:51:05 -0400
Received: from earth.universe (unknown [185.213.155.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55045206C3;
        Sat,  3 Oct 2020 21:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601761864;
        bh=r3SEJN9DnMEQVrmQMmce3dw0meOlw+LrQboKNd/rHYI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1wLxtVAB3DfKsoILNTJAI9O+AAlobR4gFcNdsG02CqC4LI2t0nqTJKhP8XSrBsp/U
         ztKH4dPChiRAIe4qDFEkRvo74+Mxe9xgDRj8n7mZuW9Lwa6at7bisSlsdn+HfNAW7C
         WorLzEwRuY6oSlmVxvqxL04VdY3qEWvdNdWqTySE=
Received: by earth.universe (Postfix, from userid 1000)
        id 601F53C0C87; Sat,  3 Oct 2020 23:51:02 +0200 (CEST)
Date:   Sat, 3 Oct 2020 23:51:02 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] power: supply: fix spelling mistake "unprecise" ->
 "imprecise"
Message-ID: <20201003215102.5hl5lvidyki2xu7b@earth.universe>
References: <20200902101656.57676-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uy4xpfjn2exzd2kp"
Content-Disposition: inline
In-Reply-To: <20200902101656.57676-1-colin.king@canonical.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--uy4xpfjn2exzd2kp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 02, 2020 at 11:16:56AM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> There is a spelling mistake in a dev_info message. Fix it.
>=20
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/rn5t618_power.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/rn5t618_power.c b/drivers/power/supply/=
rn5t618_power.c
> index 424d2817bee5..dee520f0fdf5 100644
> --- a/drivers/power/supply/rn5t618_power.c
> +++ b/drivers/power/supply/rn5t618_power.c
> @@ -487,7 +487,7 @@ static int rn5t618_power_probe(struct platform_device=
 *pdev)
>  		 * gauge will get decalibrated.
>  		 */
>  		dev_info(&pdev->dev, "Fuel gauge not enabled, enabling now\n");
> -		dev_info(&pdev->dev, "Expect unprecise results\n");
> +		dev_info(&pdev->dev, "Expect imprecise results\n");
>  		regmap_update_bits(info->rn5t618->regmap, RN5T618_CONTROL,
>  				   FG_ENABLE, FG_ENABLE);
>  	}
> --=20
> 2.27.0
>=20

--uy4xpfjn2exzd2kp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl948kYACgkQ2O7X88g7
+pqMJxAAiGvBhfmEp5rFXXboapypV5IeBY0hUJZap2U9RBq7Is5ZYAE/LWwK8Gp5
ukXhlWlZzzUfZ58mTRqwXxV3xxVA98ua2wa3/TmV0GulZo5DcwjJT8PutZL2CTly
4OjJheAjRdmL2pp+qc6u4sID0hrH3baeOcL9ahuhhQC/QJushuOc4As9Y6ExEALR
16x99xP/AIKhe1fxY1KKu/NLhjHB2xj/Vov+mJBM6GAQb/6LWox5otbCGQFo9q9D
KKlqqc1MBwdCa6/vX3ykXrXTfClURVK8yLbuNAoAdUuuPxingIIdTSUxClv50v+E
9uQN9GI41qFAuE5eYH6RlvfkLeLvint2i2GdhL8CUZ3FopZ31ix6Qzy8EM5plueS
Ko6UEBAYlf8eWmpnnfxbZNFagKouJnI03908iQCuLNPLHVtKNdEZVLMA90aqgJTd
PszHiMfTITrEpR7KqHyJ9J/AmCO8ONdAQqCH5jxZmPFYAp63Ybh9JF8G8+olnDS2
0GrWDNzNh8RiCjZQjizN/JuYxvHEXg6/jkt0NV4FqGEBcUnEmufL3oxzXmHR41kf
6hOK+nHtQo1EQGKtYijeCgSO/1M6pMX1shD7Mt6Dlu/Wo473Fc0syb2mLoB6rmuB
l2DmdXJE246VyylrQYjBa4Qobr38yZj1M5Mw0ND5jB7pGI+ICtI=
=r7CH
-----END PGP SIGNATURE-----

--uy4xpfjn2exzd2kp--
