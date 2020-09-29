Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6063827DC96
	for <lists+linux-pm@lfdr.de>; Wed, 30 Sep 2020 01:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728745AbgI2XT0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Sep 2020 19:19:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:46418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728223AbgI2XT0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 29 Sep 2020 19:19:26 -0400
Received: from earth.universe (unknown [185.213.155.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 748BB21531;
        Tue, 29 Sep 2020 23:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601421565;
        bh=c/XKGpjnQIM08izDBF9EkAJK9jfCtnDXdCi0b04UMNg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gy9bOMMfGL2FDLToSHuNvjsmnBN8HMzhHY6MQDVMf/FSS4C3cV282LBMkBIyPfwrh
         QnFK7Rma7YYo46YDLflEyrGkf1Hj+15Dww9ks0s6Qet5nwmqpQ02csidIiFHZtlSKz
         +J/o68eJGGj4d1Ph6eNK35uISr4BrQ1xxfDRzm7o=
Received: by earth.universe (Postfix, from userid 1000)
        id 5C4AD3C0C84; Wed, 30 Sep 2020 01:19:23 +0200 (CEST)
Date:   Wed, 30 Sep 2020 01:19:23 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Wang Qing <wangqing@vivo.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: fix spelling typo
Message-ID: <20200929231923.q6xyqyfbszys3fbg@earth.universe>
References: <1600929478-26554-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6ncpxg4jsumrrvk2"
Content-Disposition: inline
In-Reply-To: <1600929478-26554-1-git-send-email-wangqing@vivo.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--6ncpxg4jsumrrvk2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 24, 2020 at 02:37:56PM +0800, Wang Qing wrote:
> Modify the comment typo: "compliment" -> "complement".
>=20
> Signed-off-by: Wang Qing <wangqing@vivo.com>
> ---

Thanks, queued with modified patch subject.

-- Sebastian

>  drivers/power/supply/ab8500_fg.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab85=
00_fg.c
> index 7eec415..592a73d
> --- a/drivers/power/supply/ab8500_fg.c
> +++ b/drivers/power/supply/ab8500_fg.c
> @@ -653,7 +653,7 @@ int ab8500_fg_inst_curr_finalize(struct ab8500_fg *di=
, int *res)
> =20
>  	/*
>  	 * negative value for Discharging
> -	 * convert 2's compliment into decimal
> +	 * convert 2's complement into decimal
>  	 */
>  	if (high & 0x10)
>  		val =3D (low | (high << 8) | 0xFFFFE000);
> @@ -781,7 +781,7 @@ static void ab8500_fg_acc_cur_work(struct work_struct=
 *work)
>  	if (ret < 0)
>  		goto exit;
> =20
> -	/* Check for sign bit in case of negative value, 2's compliment */
> +	/* Check for sign bit in case of negative value, 2's complement */
>  	if (high & 0x10)
>  		val =3D (low | (med << 8) | (high << 16) | 0xFFE00000);
>  	else
> --=20
> 2.7.4
>=20

--6ncpxg4jsumrrvk2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl9zwPsACgkQ2O7X88g7
+ppKZA/1F5+6BU6Vt7tYWZugPoDf0NB/ZHylStSL99vYMRcx3+lwXWbqCFyTUaLV
xV4I8las5TprCzd6CGLOklHlmT4/NI7IDKQZD8YUziF+CKDMIFg9XM5mZxfFFoJf
woD8U6Ml6IbUUyGPfxUBFOLZjfOZpQVseRwyazJ8fDwu0qHjWk6dkccpFqsyqEJE
1fvKj+sHoPSjQqAqzab3HNJv4xNIbOXfZzWP7rO9FTSXLpvuNHFMwHFdWTfUpzUZ
/JRzKCU8D0O1hbsNpbxzCHtO1+DEZ9QHxBoc2+7FIHq8CL1ZTNZzqS4aoc9x8HmW
N1GKjnmP+4GQPcqzprs+leHhyaTjOAl8MFsqjqgYmDn+h16o7L3/RHvdPvV/Dndg
BMlcfFWe/HITGB6khpwabQHhTn798RNJdFp/Rf+UM2927knAI2uUrkr1gUcxyc/N
SHfPQ0rhQQ3ChdnN3ll2wf7MVMgAEy1IOdDARPtxs5rnEzvDnaq9W3v60OZzxErG
Ra6H6lO7AnVJc4+LKgJd3YNVk2pxJB03LfRapudWqeAPhhyZWeAnUfadhyq12NW8
C5lzaoSJj/hciPSpXvpV2GatsGXtjNsRIXf6KjFAKautmuS6aXHvJIqqIb1OVIyz
Ba5qbg6L332/ClCA0hveeDOU2Jn46KLrxixscCiE4RLp5M6d3A==
=reba
-----END PGP SIGNATURE-----

--6ncpxg4jsumrrvk2--
