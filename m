Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1B74D8A24
	for <lists+linux-pm@lfdr.de>; Mon, 14 Mar 2022 17:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbiCNQvc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Mar 2022 12:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbiCNQva (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Mar 2022 12:51:30 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA53C31DDC
        for <linux-pm@vger.kernel.org>; Mon, 14 Mar 2022 09:50:20 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 4BFC01F43240
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647276619;
        bh=k1zEXzPkCMVXLTAeMQVGFC3yHQ/z79DcaBFLf3pgYOQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ADOHMCGBPDxelnx6OcPXB7EabjhGz9thhE7sOzwj+E2eXwHDnevOvMYR2xUNMuXna
         zNWgTLO7AgDvob9JbOE6++GqO2XGiKk094OWDTacGYnpWKORPJ+ag6kvOBCtGZ32CZ
         IV7GWEWe7mlSnmRC5mAIZkuyX5echG/5BPfXM54AwK5mQA0XsmOcf3D2a2mUpTWWWk
         MWpptdF7J1CKIXdk5848DW0kKbCI8OUWuRK+tjzSKTorj3wo+0dQ+hho9uYX7NF5TZ
         Bpwg1Y80RgcuWGeGcv8vwxXFF9PZO2lMIk2m4dFZBj/Ao+HAcDT9O6V3xv+hSDVEwa
         ref2KAhqanMPA==
Received: by mercury (Postfix, from userid 1000)
        id 46A90106025D; Mon, 14 Mar 2022 17:50:17 +0100 (CET)
Date:   Mon, 14 Mar 2022 17:50:17 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Marcus Cooper <codekipper@gmail.com>, linux-pm@vger.kernel.org,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: Re: [PATCH] power: supply: Add missing charge restart voltages
Message-ID: <20220314165017.icee2kqc3wmtudfk@mercury.elektranox.org>
References: <20220305232420.201726-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="plibiikfgj7ivez4"
Content-Disposition: inline
In-Reply-To: <20220305232420.201726-1-linus.walleij@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--plibiikfgj7ivez4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Mar 06, 2022 at 12:24:20AM +0100, Linus Walleij wrote:
> Two of the batteries were missing charging restart voltages,
> meaning they can drain if the algorithm relies on restarting
> charging at this voltage. Fix it up.
>=20
> Fixes: c8aee3f41cb8 ("power: supply: Static data for Samsung batteries")
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/samsung-sdi-battery.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/power/supply/samsung-sdi-battery.c b/drivers/power/s=
upply/samsung-sdi-battery.c
> index 9d59f277f519..b33daab798b9 100644
> --- a/drivers/power/supply/samsung-sdi-battery.c
> +++ b/drivers/power/supply/samsung-sdi-battery.c
> @@ -824,6 +824,7 @@ static struct samsung_sdi_battery samsung_sdi_batteri=
es[] =3D {
>  			.constant_charge_current_max_ua =3D 900000,
>  			.constant_charge_voltage_max_uv =3D 4200000,
>  			.charge_term_current_ua =3D 200000,
> +			.charge_restart_voltage_uv =3D 4170000,
>  			.maintenance_charge =3D samsung_maint_charge_table,
>  			.maintenance_charge_size =3D ARRAY_SIZE(samsung_maint_charge_table),
>  			.alert_low_temp_charge_current_ua =3D 300000,
> @@ -867,6 +868,7 @@ static struct samsung_sdi_battery samsung_sdi_batteri=
es[] =3D {
>  			.constant_charge_current_max_ua =3D 1500000,
>  			.constant_charge_voltage_max_uv =3D 4350000,
>  			.charge_term_current_ua =3D 120000,
> +			.charge_restart_voltage_uv =3D 4300000,
>  			.maintenance_charge =3D samsung_maint_charge_table,
>  			.maintenance_charge_size =3D ARRAY_SIZE(samsung_maint_charge_table),
>  			.alert_low_temp_charge_current_ua =3D 300000,
> --=20
> 2.35.1
>=20

--plibiikfgj7ivez4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmIvckMACgkQ2O7X88g7
+prU1BAAjCcowsClR928xPcdO/gatiOFdHoGO83noa1jZ/87phvnHaUAnInoTcXU
+b16obENf4NqsTrcqbcJXy1bhssx30XoguUAu/oxVmWpZcY4GDuANUj92Aw0Q04J
v1CzTL/wCh3VON6r5OUsudc/+sB63R4Ts0Oomkl777eV+g1AfBSNNjYJN9PawABQ
7c0SaRJXw5rQCgdJEWoeD0eB4I08KyRmCSRLuaVCfAnsafkK9+0UttowymGvUzDo
HcZ8Qz1469EfF+JgY28vP5om1GewVk7m0JrnevID6zWit5MHJ2uX7E/8Pvz7OWxd
G2zG81VTuQYjyDwJ580+k8i5c6fGyd+CYBMg18nOSQN1PUgLViigrT0XzgrI3wIJ
RkEYCuCoDE6XvFklR532nx32Y7oeZerYLzEkiOTfuthEjHPmfyv7zPVuM5LzLAbr
ariz+cQWZ99yKKxIvHVcMaklS7+shlUEFFCqKH900/IIJicFQVzBs2woAz1E+H03
OP5kcV7UvZXemVAa8eKULQpjDIskkt0YMdViCJYzTGPN8tjdPaGOseaWFyMOUKAj
iSoxW4PUC+ScXMb5aB+dc1MDUr3kj5wTeA6c8YZNiTerDWx/mD1Y7kHvHjQNCAny
95ekZz1z20L6H1SabiZW+YTIUVDYWnZoSrHSJGO+XJqhBg4uoGo=
=SEwx
-----END PGP SIGNATURE-----

--plibiikfgj7ivez4--
