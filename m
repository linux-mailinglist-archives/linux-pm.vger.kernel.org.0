Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A81539B65B
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jun 2021 12:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbhFDKCu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Jun 2021 06:02:50 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33140 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbhFDKCt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Jun 2021 06:02:49 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id C6E8C1F43856
Received: by earth.universe (Postfix, from userid 1000)
        id 59E813C0C95; Fri,  4 Jun 2021 12:00:59 +0200 (CEST)
Date:   Fri, 4 Jun 2021 12:00:59 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-rtc@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2 6/7] power: supply: max17042: Do not enforce
 (incorrect) interrupt trigger type
Message-ID: <20210604100059.sr57dlwkqbbs6e7g@earth.universe>
References: <20210526172036.183223-1-krzysztof.kozlowski@canonical.com>
 <20210526172036.183223-7-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="d2r2o6cqzhpl36fi"
Content-Disposition: inline
In-Reply-To: <20210526172036.183223-7-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--d2r2o6cqzhpl36fi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 26, 2021 at 01:20:35PM -0400, Krzysztof Kozlowski wrote:
> From: Krzysztof Kozlowski <krzk@kernel.org>
>=20
> Interrupt line can be configured on different hardware in different way,
> even inverted.  Therefore driver should not enforce specific trigger
> type - edge falling - but instead rely on Devicetree to configure it.
>=20
> The Maxim 17047/77693 datasheets describe the interrupt line as active
> low with a requirement of acknowledge from the CPU therefore the edge
> falling is not correct.
>=20
> The interrupt line is shared between PMIC and RTC driver, so using level
> sensitive interrupt is here especially important to avoid races.  With
> an edge configuration in case if first PMIC signals interrupt followed
> shortly after by the RTC, the interrupt might not be yet cleared/acked
> thus the second one would not be noticed.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>=20
> ---
>=20
> Changes since v1:
> 1. None
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/max17042_battery.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supp=
ly/max17042_battery.c
> index 1d7326cd8fc6..ce2041b30a06 100644
> --- a/drivers/power/supply/max17042_battery.c
> +++ b/drivers/power/supply/max17042_battery.c
> @@ -1104,7 +1104,7 @@ static int max17042_probe(struct i2c_client *client,
>  	}
> =20
>  	if (client->irq) {
> -		unsigned int flags =3D IRQF_TRIGGER_FALLING | IRQF_ONESHOT;
> +		unsigned int flags =3D IRQF_ONESHOT;
> =20
>  		/*
>  		 * On ACPI systems the IRQ may be handled by ACPI-event code,
> --=20
> 2.27.0
>=20

--d2r2o6cqzhpl36fi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmC5+dAACgkQ2O7X88g7
+po1ig//VaFs/KxqHBD1C5z6LZwKfFsk1SDk9Zwmbr/nxSwQxq2y2+IWvleg2ojZ
Mau48PcpAf+BA3HlRgR7heA4ce44RzGmbKgMhW456tlmcHYzsLzqek6DU5ARI20S
/K3zAb62QLV8++7IFXZQllpMtdqrXtlJJkJ7fhc6B7s39IsMQtEwhzs4PEYqrJNI
lUdbtZkI+lDQpmg9N95aMVMY5AR9HUeNkabquNEUQ2Oj5+xmKloApTPug0r/q/hG
yNp1edRhHCXWvfMUHtydKP0CDLDEZG6I41wHbgzXD/kiUQwnnrWqZMPsityuHHYd
//5U3ZELdFWuUmeC76K4skmc+v4IjcO2lmwHUvVgRTZjvcuj/MMynfurIYlWpkTe
H1E5iwWwgPPbrZLsUX2R+wxotKcAoOeWCAkpLyKx2zxMUfm57PVqDQak+lVkonJ1
Nu3XQN94hgBdsZEhpISB/m2s1wZLSDfmJBd0Zn3Tp9fevRfNe0u9lJFapZoyJjv+
EAImy1cWkBceKj6Hc02liMpoxRmqzLn2MdlilUEsdiG1FfjaYueM7ObrXhHHVPN5
RZVhbWj0+jTbF8WUr/DyzWuSKQBx5iPySRgqWQ36lAbG3Lu6lTYusylRvCUqw//M
y9RW10u+JZKJz/qKeq5sVyF+h14oX8nMfNKNVySRei3SXpjfvN8=
=dSKy
-----END PGP SIGNATURE-----

--d2r2o6cqzhpl36fi--
