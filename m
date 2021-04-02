Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91505352A7F
	for <lists+linux-pm@lfdr.de>; Fri,  2 Apr 2021 14:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbhDBMQW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Apr 2021 08:16:22 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56616 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbhDBMQV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Apr 2021 08:16:21 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 322E61F46A50
Received: by earth.universe (Postfix, from userid 1000)
        id 872E93C0C96; Fri,  2 Apr 2021 14:16:17 +0200 (CEST)
Date:   Fri, 2 Apr 2021 14:16:17 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Milan Djurovic <mdjurovic@zohomail.com>
Cc:     linux-pm@vger.kernel.org
Subject: Re: [PATCH] power: supply: 88pm860x_battery: Remove unnecessary int
 for long long
Message-ID: <20210402121617.pi5mg5ipcxk7rrds@earth.universe>
References: <20210327073605.7626-1-mdjurovic@zohomail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qr4ugwfiylzlrnog"
Content-Disposition: inline
In-Reply-To: <20210327073605.7626-1-mdjurovic@zohomail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--qr4ugwfiylzlrnog
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Mar 27, 2021 at 12:36:05AM -0700, Milan Djurovic wrote:
> Change 'long long int' to 'long long' because the int is unnecessary,
> as suggested by checkpatch.pl.
>=20
> Signed-off-by: Milan Djurovic <mdjurovic@zohomail.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/88pm860x_battery.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/power/supply/88pm860x_battery.c b/drivers/power/supp=
ly/88pm860x_battery.c
> index 590da88a17a2..f3f3f8cd1a7f 100644
> --- a/drivers/power/supply/88pm860x_battery.c
> +++ b/drivers/power/supply/88pm860x_battery.c
> @@ -109,8 +109,8 @@ struct pm860x_battery_info {
>  };
> =20
>  struct ccnt {
> -	unsigned long long int pos;
> -	unsigned long long int neg;
> +	unsigned long long pos;
> +	unsigned long long neg;
>  	unsigned int spos;
>  	unsigned int sneg;
> =20
> --=20
> 2.31.0
>=20

--qr4ugwfiylzlrnog
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmBnCxEACgkQ2O7X88g7
+poW3Q//TArHuylecXQGYa+h8lsaJNj2ROoDzz75WA7uibHXJ8avyFj8nvW9k6rt
0lhF/WeV1bsC6n07nLS/vDU9cFyzlZKjrQweAdBRuHzR4U77/4EgnLv8Ovw1+AxA
V75AbVcoIfouTdcEH7BdZjygOnww7FgQeBG6LcUWYBZ+j2vUPgVu3EwL7mnoHnLp
sVRGaqTqLEe+8mW4g7tcPH+bzEGLlZCSasiNZq5BYN5EHDgH3RRdC885B569kbpj
KuEjV4R86LJ4tEDz4DrKf8rCDuEBIZMc1COQDbP4mqpenwkNvjpKAkBcYnJajD4Z
+s9SCT7HXS3IuLuSUUJHSf6j7DXYRvfkupI2hXtONYfns8SYeOhFAY8g+puynFtR
wFSrrPfmZHc+brhe9s5VDTfAY5FBv0XJaOJS8SWE0dR732NltWtZ0m2ZAZlGPTdP
o99Qhv/dQKuUo30694W3R/y9FPe+qbIPMtHHt+b7XnpEGv2pEqZN2k5da4i58usD
QbdrXiHOtvGyeuGSFIHGHPDNSpGZPpag4Eqf77mWTRkU30fftYm++c6jzdZP/XbY
uti3fnEgfUehiG/lRSBamEd5kSvEWSkpSvovV1VsBJbPASODOF1Csb/f/Hq19sFs
UztrX797x6nFOJRU0NPA6KZTxYuGDqhkjQT/985Slx5o0/8l1cE=
=peoA
-----END PGP SIGNATURE-----

--qr4ugwfiylzlrnog--
