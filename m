Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 150B4DDE87
	for <lists+linux-pm@lfdr.de>; Sun, 20 Oct 2019 15:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbfJTNEq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 20 Oct 2019 09:04:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:59256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbfJTNEq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 20 Oct 2019 09:04:46 -0400
Received: from earth.universe (tmo-104-243.customers.d1-online.com [80.187.104.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F1D82067B;
        Sun, 20 Oct 2019 13:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571576685;
        bh=BaaDNZa2WmdDajtlcOe5NfEpuESOd1YfNMU6+cnGh1g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KLL5FwKkE4nV/CejVY0RNccB3WPxc8ji0b3bduxUuMyld8kk5RojAOV4XNPwg9DIj
         LGIBcDEux2tgEIO9wit3CezvjaPZC9aIf2cK64nYDmeUWIrTmEa6QDyGHQ5DvSLNg+
         kJeY4EXj0bjXdqGwHpclQwt0JTMGneqfO6CQS5wA=
Received: by earth.universe (Postfix, from userid 1000)
        id 9455A3C09B1; Sun, 20 Oct 2019 15:04:40 +0200 (CEST)
Date:   Sun, 20 Oct 2019 15:04:40 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
Cc:     linux-kernel@lists.codethink.co.uk,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: reset: fix __le32 cast in reset code
Message-ID: <20191020130440.k5o5vxwuzb354e7w@earth.universe>
References: <20191015155414.25267-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="r3yb7dqh5bru6ocf"
Content-Disposition: inline
In-Reply-To: <20191015155414.25267-1-ben.dooks@codethink.co.uk>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--r3yb7dqh5bru6ocf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 15, 2019 at 04:54:14PM +0100, Ben Dooks (Codethink) wrote:
> The writel() takes standard integers, not __le32 so
> fix the following sparse warnings by removing the
> cpu_to_le32() calls.
>=20
> drivers/power/reset/at91-reset.c:134:9: warning: cast from restricted __l=
e32
> drivers/power/reset/at91-reset.c:143:9: warning: cast from restricted __l=
e32
>=20
> This has made no code changes, the md5sums pre and post applying
> this patch are the same. The at91 should be natively little endian
> anyway.
>=20
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---

Thanks, queued.

-- Sebastian

> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/power/reset/at91-reset.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-=
reset.c
> index 44ca983a49a1..d94e3267c3b6 100644
> --- a/drivers/power/reset/at91-reset.c
> +++ b/drivers/power/reset/at91-reset.c
> @@ -131,7 +131,7 @@ static int at91sam9g45_restart(struct notifier_block =
*this, unsigned long mode,
>  static int sama5d3_restart(struct notifier_block *this, unsigned long mo=
de,
>  			   void *cmd)
>  {
> -	writel(cpu_to_le32(AT91_RSTC_KEY | AT91_RSTC_PERRST | AT91_RSTC_PROCRST=
),
> +	writel(AT91_RSTC_KEY | AT91_RSTC_PERRST | AT91_RSTC_PROCRST,
>  	       at91_rstc_base);
> =20
>  	return NOTIFY_DONE;
> @@ -140,9 +140,7 @@ static int sama5d3_restart(struct notifier_block *thi=
s, unsigned long mode,
>  static int samx7_restart(struct notifier_block *this, unsigned long mode,
>  			 void *cmd)
>  {
> -	writel(cpu_to_le32(AT91_RSTC_KEY | AT91_RSTC_PROCRST),
> -	       at91_rstc_base);
> -
> +	writel(AT91_RSTC_KEY | AT91_RSTC_PROCRST, at91_rstc_base);
>  	return NOTIFY_DONE;
>  }
> =20
> --=20
> 2.23.0
>=20

--r3yb7dqh5bru6ocf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl2sW2gACgkQ2O7X88g7
+po77Q/8DXDRvmluSTIuWXt4yW2I8ioJJsNAyPINMtbsKQWIp6yoMWWgsFlQtV74
nWgBHDRsViRUsqqLzcSYEdnJ3rQDUoTpovAg7HqaQi9xuJ9XtOwUJ2+DHEq8MGj/
dml/EwfXMhKfS93+odQFgappZUvpucZhbqtqFQ7x5ZhzeRBdepnjU8BvqKMJEMRJ
/n1HfVW9CX9Zy81Cber5c5AV27YXHpKrftImAQ4fDxKDDL9iGarOIJmDxEpRl+vn
xR0atYdvh4kPNZw/NYEF6JHAk1E2uoctohI9zURrbUDKVHj44QiwNuOOZtnKEm75
p1mj6NiMTcPNXg0r4wYlZNyjsuFqL3lEJYEHoMW5yNJYocj78t3cEu+sN/zLGRLZ
vogOiSoO6ctMezShxXZq+6eEOcA+3EPASEb6BOI/hKgLANzrQkwzD3xlVS771ynq
E/paOFVeh4qE1xuyloS7/nMzBsPO2i/hDXACNK9EjsNgqn17LUFMHEod/tDng026
Vbk9JYMndymgnnDN6UcdWBRww3UxzCWoS9L1XlHxD171+urfTw55HDGwKGvL+u4M
VJjfpHMA6ShAIjtSgPgLz9lXR9mQAlXemw/BSR+KFs8/Y1YpOHdHmd/oArR0NYBE
1rt1766kCtdOZ2/Tw6fntCh/yERsL5N124Q8Nvgv6fCxQnhwnZA=
=kzwk
-----END PGP SIGNATURE-----

--r3yb7dqh5bru6ocf--
