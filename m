Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38879182488
	for <lists+linux-pm@lfdr.de>; Wed, 11 Mar 2020 23:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbgCKWOY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Mar 2020 18:14:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:48846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729590AbgCKWOY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 11 Mar 2020 18:14:24 -0400
Received: from jupiter.universe (dyndsl-037-138-186-138.ewe-ip-backbone.de [37.138.186.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A714620746;
        Wed, 11 Mar 2020 22:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583964863;
        bh=MXmplTsT5vjFdQMv3ZsaPHpahG/iVEkKHob11fQMGxI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BrfmlKymKI/pr4C2z1HossSjiFnXiIWq+Rcv4K15Ca5FMkFMncBaDVuUZDCbzBKy3
         HIYK0xHq4yeR2VZ7r/F/0Xwytxvog8PuJbDm6unzQgxuEm3S4dggxMRsrOzC6hI7vb
         shKfg1ZMRGmpEMO4fujkbge4756lkYfXd/UG4lfc=
Received: by jupiter.universe (Postfix, from userid 1000)
        id B98204800FC; Wed, 11 Mar 2020 23:14:21 +0100 (CET)
Date:   Wed, 11 Mar 2020 23:14:21 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     "Andrew F. Davis" <afd@ti.com>,
        Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>,
        David Heidelberg <david@ixit.cz>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] power: supply: bq27xxx_battery: Silence
 deferred-probe error
Message-ID: <20200311221421.ygesyzeyi3rf5cqd@jupiter.universe>
References: <20200308215143.27823-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oavz7cyidstw6m2j"
Content-Disposition: inline
In-Reply-To: <20200308215143.27823-1-digetx@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--oavz7cyidstw6m2j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 09, 2020 at 12:51:43AM +0300, Dmitry Osipenko wrote:
> The driver fails to probe with -EPROBE_DEFER if battery's power supply
> (charger driver) isn't ready yet and this results in a bit noisy error
> message in KMSG during kernel's boot up. Let's silence the harmless
> error message.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/bq27xxx_battery.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/suppl=
y/bq27xxx_battery.c
> index 195c18c2f426..664e50103eaa 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -1885,7 +1885,10 @@ int bq27xxx_battery_setup(struct bq27xxx_device_in=
fo *di)
> =20
>  	di->bat =3D power_supply_register_no_ws(di->dev, psy_desc, &psy_cfg);
>  	if (IS_ERR(di->bat)) {
> -		dev_err(di->dev, "failed to register battery\n");
> +		if (PTR_ERR(di->bat) =3D=3D -EPROBE_DEFER)
> +			dev_dbg(di->dev, "failed to register battery, deferring probe\n");
> +		else
> +			dev_err(di->dev, "failed to register battery\n");
>  		return PTR_ERR(di->bat);
>  	}
> =20
> --=20
> 2.25.1
>=20

--oavz7cyidstw6m2j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl5pYroACgkQ2O7X88g7
+poFXA/9EsClWtSnD2Fei+A0iOKUk1+p52MiX08+TTK1fCWe1SQJKzFdQbyijKyl
pJteKKWNlN5B9RTYWghtIMTrEqGEorFlKoXl3tk0roDffdapsv1bW4WXIz+CxMQo
QB2PsB9obLo9PBJT6GJcf8UllNLeZ7V+uJU19lj/zT4uI6bnwUJ/aLx+mrLMPuXs
m02HltEJph5huOX7OlvzVDUOd7ZV9EG3p8GZl99AhP4lhLNTqshaA8JjFeZT0SIA
YMC5RS0VREUHBfN2P1BnGquB+1pCUx+EJk1tnbG1FNniiMHAMOPVmrRI8H9BqkD6
5fPRZouzIhQ3f8KEJr1hmiSusf5Pw2IgoD0NRmk4IEFAHNlzJijFbMsKmXbLDlGv
2GyV0zkJDaYibpjGgsBbG7LqnhMSe8JMkDa7xinL4INFaTdXrYLmGKkyjnzfP2Jr
ZJhYJisQQvAhaOvUd6TJmkBr5pugSpFbmh0lE445LXkkAnwcWgDSv7Is0oGSx2p1
vFnSFr8ziEeiuoZQcXVvkrqocPJ3bAnxSKv+ZhGNIFGG1ClyYfRojuEgbrd5herM
5/ml6qtPxoLDf28g5Zt79SnfhXTtZEog1oMlbouLgJvIhm19x/bapOhrXDjPeIYQ
EiWqRSRJa4oExGkRvlcD8pI8G4MwuGrAvXMONEIADVAShdcS5aU=
=HqpP
-----END PGP SIGNATURE-----

--oavz7cyidstw6m2j--
