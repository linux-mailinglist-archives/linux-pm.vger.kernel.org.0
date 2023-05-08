Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E886FB539
	for <lists+linux-pm@lfdr.de>; Mon,  8 May 2023 18:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234265AbjEHQhh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 May 2023 12:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234256AbjEHQhe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 May 2023 12:37:34 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4026A68
        for <linux-pm@vger.kernel.org>; Mon,  8 May 2023 09:37:32 -0700 (PDT)
Received: from mercury (195-23-45-170.net.novis.pt [195.23.45.170])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3AAE46603283;
        Mon,  8 May 2023 17:37:30 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683563850;
        bh=SB3m52QouABeP4O6nD1ltP+DS95dkfei67Audxhqbzc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HwAF8La3rsTS9oCls2lNksQFX4eCUujPGqJPp735d7DrzMerqhfdiBr1ZncxQVcq/
         X1V+fJhYh6DOjaj3Ql74UHUiVzyNa2UfdtwCpleIgwMKk+YOa38/XXm1S/zFW03ggB
         XKQyNAYsUfBcpIX/YrEzDw5k2VF4Sz4i+CWwwpcIns+WVLbWS9adL9vjxn4vu1DyAr
         aKS1uLh1oBI7IsM0dAF/8P/3vVrsqRSdaxTomBBcK6bYx1TbKwY2iQi4O8+XkKyOu/
         S5xjYqo2ZDRxLL6mon0k/Kxh9Q8K81+CJBOOPUMLBz+c8ap/Iz+ytCk4afHa0ImTbH
         HLyTA31bYOGqQ==
Received: by mercury (Postfix, from userid 1000)
        id 071021067074; Mon,  8 May 2023 15:09:46 +0200 (CEST)
Date:   Mon, 8 May 2023 15:09:45 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     laji Xiao <3252204392abc@gmail.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 0/6] power: supply: Fix external_power_changed race in
 several drivers
Message-ID: <20230508130945.okud2hn47jplrlaw@mercury.elektranox.org>
References: <20230415160734.70475-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qzu24yx6zlmbvfra"
Content-Disposition: inline
In-Reply-To: <20230415160734.70475-1-hdegoede@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--qzu24yx6zlmbvfra
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Hans,

On Sat, Apr 15, 2023 at 06:07:28PM +0200, Hans de Goede wrote:
> I hit this issue where a Lenovo Yoga Book yb1-x90f would hang on boot
> every couple of boots.
>=20
> The problem was that bq25890_charger_external_power_changed() dereferences
> bq->charger, which gets sets in bq25890_power_supply_init() like this:
>    =20
>   bq->charger =3D devm_power_supply_register(bq->dev, &bq->desc, &psy_cfg=
);
>    =20
> As soon as devm_power_supply_register() has called device_add()
> the external_power_changed callback can get called. So there is a window
> where bq25890_charger_external_power_changed() may get called while
> bq->charger has not been set yet leading to a NULL pointer dereference.
>=20
> This race hits on the yb1-x90f when the cht_wcove_pwrsrc (extcon) psy is
> done with detecting the charger, which happens to exactly hit the window:
>=20
>       BUG: kernel NULL pointer dereference, address: 0000000000000018
>       <snip>
>       RIP: 0010:__power_supply_is_supplied_by+0xb/0xb0
>       <snip>
>       Call Trace:
>        <TASK>
>        __power_supply_get_supplier_property+0x19/0x50
>        class_for_each_device+0xb1/0xe0
>        power_supply_get_property_from_supplier+0x2e/0x50
>        bq25890_charger_external_power_changed+0x38/0x1b0 [bq25890_charger]
>        __power_supply_changed_work+0x30/0x40
>        class_for_each_device+0xb1/0xe0
>        power_supply_changed_work+0x5f/0xe0
>       <snip>
>=20
> This series fixes this issue in the bq25890 + 3 other drivers with
> the same issue. Patches 5-6 are small cleanup patches for 2 other
> drivers which I audited for the same issue.

Thanks, I queued the first 4 patches to my fixes branch and the 2
cleanups to for-next.

-- Sebastian

> Hans de Goede (6):
>   power: supply: ab8500: Fix external_power_changed race
>   power: supply: axp288_fuel_gauge: Fix external_power_changed race
>   power: supply: bq25890: Fix external_power_changed race
>   power: supply: sc27xx: Fix external_power_changed race
>   power: supply: max17042_battery: Refactor
>     max17042_external_power_changed()
>   power: supply: twl4030_madc_battery: Refactor
>     twl4030_madc_bat_ext_changed()
>=20
>  drivers/power/supply/ab8500_btemp.c         | 6 ++----
>  drivers/power/supply/ab8500_fg.c            | 6 ++----
>  drivers/power/supply/axp288_fuel_gauge.c    | 2 +-
>  drivers/power/supply/bq25890_charger.c      | 2 +-
>  drivers/power/supply/max17042_battery.c     | 7 +------
>  drivers/power/supply/sc27xx_fuel_gauge.c    | 9 +--------
>  drivers/power/supply/twl4030_madc_battery.c | 8 +-------
>  7 files changed, 9 insertions(+), 31 deletions(-)
>=20
> --=20
> 2.39.1
>=20

--qzu24yx6zlmbvfra
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmRY9JUACgkQ2O7X88g7
+prMCw//UVITfJiL5L9R6omlJccJBFqzG111AJ98Qy4sZlyfFo6zLlQ53kh2vpk8
tBZEoCwno0XGWXChxEhbpBBa/s0FKKHUz0Gi4scWZtTS3k8As0ZAFi9d+whFAjQa
hJXIwGMeUl4YxEcDRc7z+ihOiT6pwx218ktqf9ohjcf8n95F030uZY3wLvxssRJd
AJEQWa/hyCZrswTHVyInPbutBYLWZplVU7+QTw9AdIkshyvseSUcJZc59xwDwv0S
oBOuu99xvLNx2a8NUDpvK7+k6hI5smtjUeA0de8InYNs+bRcS4g3hD62nHqKKC0w
gq+bDXONd3VdCuzv+GUZ9sEaNgLZhxk4zLUURs4rTGFKoGVB1JpeeiIMQFRI6aSw
8stWI3sO3gZuf3IRWR5i6A0OWyNSV3Z24GZgeMj+5fKW0LJ8DUUfw8FReIGyl/Ht
/XEpUgUhOKzetA1Dk+MyJwNr0YQ4yxDHo8yIwdFCC4GLqHLGWSOSeHDsUBekhkTC
/v6f87MMwX1KTF5P1NE+ADWaJW/Ml7ahIZrLSaIydZyaE1A7x4qPHnqfI8qT/bly
ObZ87yzbdXoj3YJRApxLsz20QoXwm1Blj/sq4o8lq5jUF5lcYBT0+Mw2FXchPFKW
H6PMt2GtU7NWMjvOTL3Ig3osnwTb0qBXi1RuZiuejeepbfphF4A=
=RCWT
-----END PGP SIGNATURE-----

--qzu24yx6zlmbvfra--
