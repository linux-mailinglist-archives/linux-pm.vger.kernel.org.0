Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E815188A8
	for <lists+linux-pm@lfdr.de>; Tue,  3 May 2022 17:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238253AbiECPim (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 May 2022 11:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232159AbiECPil (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 May 2022 11:38:41 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8184D2CE16
        for <linux-pm@vger.kernel.org>; Tue,  3 May 2022 08:35:08 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 5072D1F4424E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651592107;
        bh=V8E9EyIx66AtiI9BHw/Qa2rXL3D/hA6g445w2ZErkh8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k6MafRwHbjFyPhQ2mErMo+Fx786Og97deORVr2gsz435OCLy8lkB0opF+/6n4AZBS
         Mk/SwB5LNQVvbJE3Erm9wsJWJHPtHh75aR/cOlErnDmisohPzm/ZrFkPEy1UgMr94U
         hk9VusZeo2WBhN9DWAoWVvb/FOR6VAgT4aR7GHpR40ZfxxU0keAjldZeqL6AAuxfec
         w9u32Xb0tvyRl6D/TprRTks1ez+gOyiJYqLBqaURCnN3dAKvnJ8AMQV10MVSjPCozY
         NeBAP/6n6bVo4qj16a+Q11UCin7rxgBvzEhW3pqPri1+/Xx7SuTk0AoHjkYBbwdTXs
         aTm1EVM2Ey5Tg==
Received: by mercury (Postfix, from userid 1000)
        id E11E71060430; Tue,  3 May 2022 17:35:04 +0200 (CEST)
Date:   Tue, 3 May 2022 17:35:04 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/2] power: supply: axp288_fuel_gauge: Fix battery
 reporting on the One Mix 1
Message-ID: <20220503153504.rbwtxiw2y56bjlwi@mercury.elektranox.org>
References: <20220502111235.331877-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jyyn2o75wlr2s7cm"
Content-Disposition: inline
In-Reply-To: <20220502111235.331877-1-hdegoede@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--jyyn2o75wlr2s7cm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, May 02, 2022 at 01:12:34PM +0200, Hans de Goede wrote:
> Commit 3a06b912a5ce ("power: supply: axp288_fuel_gauge: Make "T3 MRD"
> no_battery_list DMI entry more generic") added a generic no-battery DMI
> match for many mini-PCs / HDMI-sticks which use "T3 MRD" as their DMI
> board-name.
>=20
> It turns out that the One Mix 1 mini laptop also uses "T3 MRD" for its
> DMI boardname and it also has its chassis-type wrongly set to a value
> of "3" (desktop). This was causing the axp288_fuel_gauge driver to
> disable battery reporting because this matches the no-battery DMI
> list entry for generic "T3 MRD" mini-PCs.
>=20
> Change the no-battery DMI list into a quirks DMI list and add a
> specific match for the One Mix 1 mini laptop before the generic
> "T3 MRD" no-battery quirk entry to fix this.
>=20
> Fixes: 3a06b912a5ce ("power: supply: axp288_fuel_gauge: Make "T3 MRD" no_=
battery_list DMI entry more generic")
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---

Thanks, queued to my fixes branch.

-- Sebastian

>  drivers/power/supply/axp288_fuel_gauge.c | 40 +++++++++++++++++++++---
>  1 file changed, 36 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/sup=
ply/axp288_fuel_gauge.c
> index e9f285dae489..5b8aa4a980cd 100644
> --- a/drivers/power/supply/axp288_fuel_gauge.c
> +++ b/drivers/power/supply/axp288_fuel_gauge.c
> @@ -90,6 +90,8 @@
>  #define AXP288_REG_UPDATE_INTERVAL		(60 * HZ)
>  #define AXP288_FG_INTR_NUM			6
> =20
> +#define AXP288_QUIRK_NO_BATTERY			BIT(0)
> +
>  static bool no_current_sense_res;
>  module_param(no_current_sense_res, bool, 0444);
>  MODULE_PARM_DESC(no_current_sense_res, "No (or broken) current sense res=
istor");
> @@ -524,7 +526,7 @@ static struct power_supply_desc fuel_gauge_desc =3D {
>   * detection reports one despite it not being there.
>   * Please keep this listed sorted alphabetically.
>   */
> -static const struct dmi_system_id axp288_no_battery_list[] =3D {
> +static const struct dmi_system_id axp288_quirks[] =3D {
>  	{
>  		/* ACEPC T8 Cherry Trail Z8350 mini PC */
>  		.matches =3D {
> @@ -534,6 +536,7 @@ static const struct dmi_system_id axp288_no_battery_l=
ist[] =3D {
>  			/* also match on somewhat unique bios-version */
>  			DMI_EXACT_MATCH(DMI_BIOS_VERSION, "1.000"),
>  		},
> +		.driver_data =3D (void *)AXP288_QUIRK_NO_BATTERY,
>  	},
>  	{
>  		/* ACEPC T11 Cherry Trail Z8350 mini PC */
> @@ -544,6 +547,7 @@ static const struct dmi_system_id axp288_no_battery_l=
ist[] =3D {
>  			/* also match on somewhat unique bios-version */
>  			DMI_EXACT_MATCH(DMI_BIOS_VERSION, "1.000"),
>  		},
> +		.driver_data =3D (void *)AXP288_QUIRK_NO_BATTERY,
>  	},
>  	{
>  		/* Intel Cherry Trail Compute Stick, Windows version */
> @@ -551,6 +555,7 @@ static const struct dmi_system_id axp288_no_battery_l=
ist[] =3D {
>  			DMI_MATCH(DMI_SYS_VENDOR, "Intel"),
>  			DMI_MATCH(DMI_PRODUCT_NAME, "STK1AW32SC"),
>  		},
> +		.driver_data =3D (void *)AXP288_QUIRK_NO_BATTERY,
>  	},
>  	{
>  		/* Intel Cherry Trail Compute Stick, version without an OS */
> @@ -558,34 +563,55 @@ static const struct dmi_system_id axp288_no_battery=
_list[] =3D {
>  			DMI_MATCH(DMI_SYS_VENDOR, "Intel"),
>  			DMI_MATCH(DMI_PRODUCT_NAME, "STK1A32SC"),
>  		},
> +		.driver_data =3D (void *)AXP288_QUIRK_NO_BATTERY,
>  	},
>  	{
>  		/* Meegopad T02 */
>  		.matches =3D {
>  			DMI_MATCH(DMI_PRODUCT_NAME, "MEEGOPAD T02"),
>  		},
> +		.driver_data =3D (void *)AXP288_QUIRK_NO_BATTERY,
>  	},
>  	{	/* Mele PCG03 Mini PC */
>  		.matches =3D {
>  			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "Mini PC"),
>  			DMI_EXACT_MATCH(DMI_BOARD_NAME, "Mini PC"),
>  		},
> +		.driver_data =3D (void *)AXP288_QUIRK_NO_BATTERY,
>  	},
>  	{
>  		/* Minix Neo Z83-4 mini PC */
>  		.matches =3D {
>  			DMI_MATCH(DMI_SYS_VENDOR, "MINIX"),
>  			DMI_MATCH(DMI_PRODUCT_NAME, "Z83-4"),
> -		}
> +		},
> +		.driver_data =3D (void *)AXP288_QUIRK_NO_BATTERY,
>  	},
>  	{
> -		/* Various Ace PC/Meegopad/MinisForum/Wintel Mini-PCs/HDMI-sticks */
> +		/*
> +		 * One Mix 1, this uses the "T3 MRD" boardname used by
> +		 * generic mini PCs, but it is a mini laptop so it does
> +		 * actually have a battery!
> +		 */
> +		.matches =3D {
> +			DMI_MATCH(DMI_BOARD_NAME, "T3 MRD"),
> +			DMI_MATCH(DMI_BIOS_DATE, "06/14/2018"),
> +		},
> +		.driver_data =3D NULL,
> +	},
> +	{
> +		/*
> +		 * Various Ace PC/Meegopad/MinisForum/Wintel Mini-PCs/HDMI-sticks
> +		 * This entry must be last because it is generic, this allows
> +		 * adding more specifuc quirks overriding this generic entry.
> +		 */
>  		.matches =3D {
>  			DMI_MATCH(DMI_BOARD_NAME, "T3 MRD"),
>  			DMI_MATCH(DMI_CHASSIS_TYPE, "3"),
>  			DMI_MATCH(DMI_BIOS_VENDOR, "American Megatrends Inc."),
>  			DMI_MATCH(DMI_BIOS_VERSION, "5.11"),
>  		},
> +		.driver_data =3D (void *)AXP288_QUIRK_NO_BATTERY,
>  	},
>  	{}
>  };
> @@ -665,7 +691,9 @@ static int axp288_fuel_gauge_probe(struct platform_de=
vice *pdev)
>  		[BAT_D_CURR] =3D "axp288-chrg-d-curr",
>  		[BAT_VOLT] =3D "axp288-batt-volt",
>  	};
> +	const struct dmi_system_id *dmi_id;
>  	struct device *dev =3D &pdev->dev;
> +	unsigned long quirks =3D 0;
>  	int i, pirq, ret;
> =20
>  	/*
> @@ -675,7 +703,11 @@ static int axp288_fuel_gauge_probe(struct platform_d=
evice *pdev)
>  	if (!acpi_quirk_skip_acpi_ac_and_battery())
>  		return -ENODEV;
> =20
> -	if (dmi_check_system(axp288_no_battery_list))
> +	dmi_id =3D dmi_first_match(axp288_quirks);
> +	if (dmi_id)
> +		quirks =3D (unsigned long)dmi_id->driver_data;
> +
> +	if (quirks & AXP288_QUIRK_NO_BATTERY)
>  		return -ENODEV;
> =20
>  	info =3D devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
> --=20
> 2.36.0
>=20

--jyyn2o75wlr2s7cm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmJxS5sACgkQ2O7X88g7
+pqfuA/9Gkj2GGBx9YIJyaCshRXWYxYqah5Ldz+pU2Ucz47BCdKROfdRhJchDXf9
r/+Dx/TSIWvag+2cnPMk1sGvJjF2G7QrVrXDZmVo/IkQ2MrDBkZqXu3ECCJEQdWh
7rnvqFGrdoSVvjiU5jq1kGms+2ZW3RAMtz0qOo7RRUxTFzkwIy0wOdXennRjWgKG
/bheMGW7NB08sD09JxG2gEECAIXCkUzewh7VoP4zFAHRXhcGvSVlrg9ZFulhRPcn
A6gvfuXhtb/3NhmMuvUn3Px1EKi7jgJv4S36q4dHefWJ9rvohoDY6828C3mLFfIX
ftzaWslfBAEOddEmxbVNjUB6D8NYGxfxcJv3/xaQnGzuzctPF+hC2Ab40+4Sljix
Jxe79RrFCAYAsDJVAtZlRdK4AZJnTSIKO61TUG1yiFJ68f+N0RWqpiqDqS2Mx4NT
EnHs8/u1P45KTNTynllAa37EFZ0+KZmUEYUO2tf15Dbg3VgQaq6xqoVdFk84Uy9f
eFG31J5LbxXZqbo2NWbBAiue9bP8lgCTYujdp6HwfJoDWVtQmScomAXqh53XP2Mx
45xuNFQXcaVZSm6KoqSvPFQK6RU+IAoMsS8B4kBap02ZlAOGRJmR6uWmn9YPqh3c
9ksw1rCghHqOPcmkzQEHTb/J6CJrf97po7ROeiMLt5FgFeUP708=
=y33j
-----END PGP SIGNATURE-----

--jyyn2o75wlr2s7cm--
