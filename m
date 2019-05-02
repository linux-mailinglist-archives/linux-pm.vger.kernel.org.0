Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3800C122EB
	for <lists+linux-pm@lfdr.de>; Thu,  2 May 2019 21:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfEBTuy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 May 2019 15:50:54 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42318 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfEBTuy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 May 2019 15:50:54 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id A84AF28423D
Received: by earth.universe (Postfix, from userid 1000)
        id 65A1B3C0D1B; Thu,  2 May 2019 21:50:49 +0200 (CEST)
Date:   Thu, 2 May 2019 21:50:49 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com
Subject: Re: [PATCH v14 7/8] power: supply: Initial support for ROHM BD70528
 PMIC charger block
Message-ID: <20190502195049.brysexbyyq7khtr4@earth.universe>
References: <cover.1556787930.git.matti.vaittinen@fi.rohmeurope.com>
 <eece016c86483d55befab1a06fb299c9d6d17134.1556787930.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bhukgbujt2wxql42"
Content-Disposition: inline
In-Reply-To: <eece016c86483d55befab1a06fb299c9d6d17134.1556787930.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--bhukgbujt2wxql42
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 02, 2019 at 12:17:12PM +0300, Matti Vaittinen wrote:
> ROHM BD70528 PMIC includes battery charger block. Support charger
> staus queries and doing few basic settings like input current limit
> and charging current.
>=20
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Please only add Acked-by when you receive one, especially when you
do not implement all requested changes :)

[...]

> +static int bd70528_get_irqs(struct platform_device *pdev,
> +			    struct bd70528_psy *bdpsy)
> +{
> +	int irq, i, ret;
> +	unsigned int mask;
> +	const struct irq_name_pair bd70528_chg_irqs[] =3D {
> +		{ .n =3D "bd70528-bat-ov-res", .h =3D BD_IRQ_HND(BAT_OV_RES) },
> +		{ .n =3D "bd70528-bat-ov-det", .h =3D BD_IRQ_HND(BAT_OV_DET) },
> +		{ .n =3D "bd70528-bat-dead", .h =3D BD_IRQ_HND(DBAT_DET) },
> +		{ .n =3D "bd70528-bat-warmed", .h =3D BD_IRQ_HND(COLD_RES) },
> +		{ .n =3D "bd70528-bat-cold", .h =3D BD_IRQ_HND(COLD_DET) },
> +		{ .n =3D "bd70528-bat-cooled", .h =3D BD_IRQ_HND(HOT_RES) },
> +		{ .n =3D "bd70528-bat-hot", .h =3D BD_IRQ_HND(HOT_DET) },
> +		{ .n =3D "bd70528-chg-tshd", .h =3D BD_IRQ_HND(CHG_TSD) },
> +		{ .n =3D "bd70528-bat-removed", .h =3D BD_IRQ_HND(BAT_RMV) },
> +		{ .n =3D "bd70528-bat-detected", .h =3D BD_IRQ_HND(BAT_DET) },
> +		{ .n =3D "bd70528-dcin2-ov-res", .h =3D BD_IRQ_HND(DCIN2_OV_RES) },
> +		{ .n =3D "bd70528-dcin2-ov-det", .h =3D BD_IRQ_HND(DCIN2_OV_DET) },
> +		{ .n =3D "bd70528-dcin2-removed", .h =3D BD_IRQ_HND(DCIN2_RMV) },
> +		{ .n =3D "bd70528-dcin2-detected", .h =3D BD_IRQ_HND(DCIN2_DET) },
> +		{ .n =3D "bd70528-dcin1-removed", .h =3D BD_IRQ_HND(DCIN1_RMV) },
> +		{ .n =3D "bd70528-dcin1-detected", .h =3D BD_IRQ_HND(DCIN1_DET) },
> +	};

Please also make it static. That will move the whole thing to
read-only (because of const) data section. This improves the
security and the required cpu time at the same time (no need
to copy values to the stack).

But this can be changed later, so no need to block the whole
patchset just because of this. If Lee wants to merge this for
5.2, that would be fine with me. But please add it directly in
a new patch revision if the patch does not make it into 5.2.

-- Sebastian

--bhukgbujt2wxql42
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlzLShUACgkQ2O7X88g7
+pqErhAAgZNXEYhrDHkaaYDwxjL4Ch28ycvgjE9+HjCig5co2F2nW25/cQPj3IeQ
KLwc3hAAy0RzDKTc72fMtg//7b8L21Dzj4Qz4pHmQ3vhOETyAvwt3mOK8kiCSh9F
MlrJ7vtUSnOo3S/QGiBCQ6gjTzrkyYWYtJAK3UabGbwagf9t8bKAUquWNbwFbvuu
0Q2L++Z8eX4O0b8sbLJ5YxCx9eib2j3W6C2CNHUFG+WLjLom4IskqYq3Y7KELQ4U
1YQbFUI5p+WFnxZU0uklYPEBfMCRBXd4iG2XBc8c/KBMkeQKOlXkURqUl7lmNT9u
jgdqBpp0qgOlmJE7YsJTFjgyuwWR/BWLpE9QMKxBR1Ua94G6HRnoNiveq2qty18b
s6G53YnvJsjI2y0cnP0+wACEKBATa33dUCLDABsKlyXl1jSdeE8csDM3XZ/SMNxZ
CWayrYggYz3nk9y1bnJK3bkyVNAKaDRlNOA+kezZGAPUdcojFJOWin45Vkm5CFma
t9SNRSBFArbG/9x/iOcETTVE+Hb7w5czGr+D41vJd/OUM/oE+sCt4ylIi4PA6a/y
IF5fC7XzuTspKeoLuUo7WWght3JjD5+aGZ5OF6GKOSn7sdn0N2D53CdXp482U+jv
a3ojwbXAqujhOIZhw5WYMfXjMyfKvhoPjjSIbk+NNRt8ksWKMc8=
=CJv+
-----END PGP SIGNATURE-----

--bhukgbujt2wxql42--
