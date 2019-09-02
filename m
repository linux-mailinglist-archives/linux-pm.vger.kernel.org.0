Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 214A6A5C85
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2019 21:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfIBTG0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Sep 2019 15:06:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:37604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726974AbfIBTG0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 2 Sep 2019 15:06:26 -0400
Received: from earth.universe (unknown [185.62.205.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 248EE2190F;
        Mon,  2 Sep 2019 19:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567451185;
        bh=S1+dlwDGmxYztYUwt+eKgHRMn08Lq4zajk+qvBznZbU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZLT5gfVtFgU7+zNRHIdMh9TtkFwhDfd9yjrtXC4Uaq2fMcJMJypjvx649/8LauPNp
         R3VsjPPGaRT+A7cPrip7FINkmVcD3sZwV1uqIK1QVhQrkkKffomoHfJLkPrDuV+UjK
         IG/8kRdJ5srdjpsnAK3DwhuBBlhrQ0uJAMJVjvYs=
Received: by earth.universe (Postfix, from userid 1000)
        id E66E93C0B7F; Mon,  2 Sep 2019 21:06:22 +0200 (CEST)
Date:   Mon, 2 Sep 2019 21:06:22 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     "Matwey V. Kornilov" <matwey@sai.msu.ru>
Cc:     matwey.kornilov@gmail.com,
        "open list:SYSTEM RESET/SHUTDOWN DRIVERS" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] power: reset: reboot-mode: Fix author email format
Message-ID: <20190902190622.vvl7hcgfqayf6xmk@earth.universe>
References: <20190713154248.24382-1-matwey@sai.msu.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gtgty2bekc5smtop"
Content-Disposition: inline
In-Reply-To: <20190713154248.24382-1-matwey@sai.msu.ru>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--gtgty2bekc5smtop
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jul 13, 2019 at 06:42:48PM +0300, Matwey V. Kornilov wrote:
> Closing angle bracket was missing.
>=20
> Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/reset/reboot-mode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/rebo=
ot-mode.c
> index 06ff035b57f5..b4076b10b893 100644
> --- a/drivers/power/reset/reboot-mode.c
> +++ b/drivers/power/reset/reboot-mode.c
> @@ -190,6 +190,6 @@ void devm_reboot_mode_unregister(struct device *dev,
>  }
>  EXPORT_SYMBOL_GPL(devm_reboot_mode_unregister);
> =20
> -MODULE_AUTHOR("Andy Yan <andy.yan@rock-chips.com");
> +MODULE_AUTHOR("Andy Yan <andy.yan@rock-chips.com>");
>  MODULE_DESCRIPTION("System reboot mode core library");
>  MODULE_LICENSE("GPL v2");
> --=20
> 2.16.4
>=20

--gtgty2bekc5smtop
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl1taC4ACgkQ2O7X88g7
+prjmw//ZmeR66fSYpuE5t1rAd2c/elEfz2JRPleMqCgXeAWY8uJHiOrdMNLjY38
yTIx1KUzqY8tfZGiGeLGv4t9x0c0DoWzfDYYvGKOTcrRsl2BATbqgRGumNc244Cc
1Kd9b670hotWxZ6KUgcCJxNxE9C2lY9VgWIEj4heRgc0/ZKqokMfP8pP+s43OJaM
pRv56aM9yhL/U+qOm25rbyKmlHk4J4ihAhspY/KT4UkihGlpfWeq2RQrsNKhz6pO
T4rgaR+EfoGmQs7Rnh1V/sRbGwtEdWmRyIJz1/Tcb68IV+Ar9RSHoQrfuOaPy3ie
zQ+4upbbLP5p95TNADLNl2jpySRjvjZ3EwaYtDaX9l/I0dVLvghXTUe1Tcw/TrnU
6EBPZAePTXbzY9NbxVehNjWiaq4msa3K2XQxMWq7l4qpdSNv5dnMsv0JXS5Jx9s3
PvqF+eQq+IFZ8KCimj4fM+XOHp2zOsdmYX4BhykmpHmfviasZpXcJygtU/puzFkV
fRhut6MFk6eT78gkWpeOds0/GAC8B2Zcx3slSxudXn8hYyxTk4vymWlBJEqYjb+g
XsSI+eu7AwW7hMdFtcuySQsu9vb0E+05Wlnw5KQiCRcMc2/8OjGotXmOed/1P6zO
aOs+/aZldmSTqpE0vRlu7QbOypZN2Ia/bdIEMkyDrtuHu9+oxaY=
=UZnE
-----END PGP SIGNATURE-----

--gtgty2bekc5smtop--
