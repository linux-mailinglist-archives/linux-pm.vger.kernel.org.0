Return-Path: <linux-pm+bounces-2823-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E62883E8B1
	for <lists+linux-pm@lfdr.de>; Sat, 27 Jan 2024 01:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E62C01F21A50
	for <lists+linux-pm@lfdr.de>; Sat, 27 Jan 2024 00:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C25211C;
	Sat, 27 Jan 2024 00:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="amWj1f6P"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D8E1FAF
	for <linux-pm@vger.kernel.org>; Sat, 27 Jan 2024 00:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706316423; cv=none; b=mXOVHDMJfzXmd36lH6fTf5Xxv8Y7YDiuBE/HAsl4Cxl1JwyVIcSPZqxMdeT1AM44TP52xXrkbcviOxynAyuM2DzgLYWzKi+lDM4lGP9JQaHZMxQFNj2Uwg8eWEkrjPvVsr6w/fT+KV8zJAJgolS+mlcf49UItTW6hFCIhoOvJQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706316423; c=relaxed/simple;
	bh=MZQl+lyidIc6Ytjk7uVe8T2doNbgUajsnsakgGQ86iM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hX1DBihFgjXJhE1hpROgqzgj3Re2X6TijVcIT91vj4jQaxXlg59amBwdWlGAggYHOYsPc3uGrXp0weOlONSvS25N1pQchjq+ySnVTvz7vr79yjGdlqqL1lTKXnx07f81seey4xr2wUh6tk9+1ty2Q3gMjccVN1gw8OYHnM2Rwwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=amWj1f6P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C00D4C433C7;
	Sat, 27 Jan 2024 00:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706316422;
	bh=MZQl+lyidIc6Ytjk7uVe8T2doNbgUajsnsakgGQ86iM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=amWj1f6PUp8xKOJHGU+SBkWd/GQFNkq7IZ/SFMtal2sJA5d8slnxYPgf+moXPdZe8
	 qfFWJ9nK2wCLkUiv3f8O911pvSlVxq8KeeathMYua2JJI2v5B2IzdwygnaV7F02azX
	 xBMWC/194rFuoiTQOQ+OAsg3p5FmRyq7/m/O61ZgVU1gNK8l4eFtFyNb37BcTWKV+l
	 N3VcVQ/UNOkBUdiaVeYrm6zaKcQvXxo5s6RHLnB+eYUvYsufr57czH6A8cDTU8sGRm
	 8AHWq0owX/vG+dh5JEuHEvNNLTvDSBE7k1HW5NdDTzjWWLU62ecEiPuxL/M3Pp5RHd
	 sOYOi/Poi7qiQ==
Received: by mercury (Postfix, from userid 1000)
	id 8E974106A754; Sat, 27 Jan 2024 01:46:59 +0100 (CET)
Date: Sat, 27 Jan 2024 01:46:59 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 3/3] power: supply: axp288_charger: Add charge-inhibit
 support
Message-ID: <m665fuuwj77duku4zsr5a22tn2ml44dh6l4vldypfxeihwipvq@fsh7rigfvgxg>
References: <20240104183516.312044-1-hdegoede@redhat.com>
 <20240104183516.312044-3-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hbppt4kgdbhu4jh2"
Content-Disposition: inline
In-Reply-To: <20240104183516.312044-3-hdegoede@redhat.com>


--hbppt4kgdbhu4jh2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Hans,

On Thu, Jan 04, 2024 at 07:35:16PM +0100, Hans de Goede wrote:
> Add charge-inhibit support by adding a rw status attribute and
> inhibiting charging when "Not charging" or "Discharging"
> is written to it.
>=20
> The userspace API with status being writable is a bit weird,
> but this is already done this way in the following psy drivers:
> axp20x_battery.c, bq24735-charger.c, bq25980_charger.c, ip5xxx_power.c,
> rt9467-charger.c, rt9471.c.

We have since then added a new property for this:

POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR

That can have auto (0), inhibit charge (1) or force discharge (2).

Greetings,

-- Sebastian

> Note on systems with an AXP288 some (about 400mA depending on load)
> current will be drawn from the battery when charging is disabled
> even if there is an external power-supply which can provide all
> the necessary current. So unfortunately one cannot simply disable
> charging to keep the battery in good health when using a tablet
> with an AXP288 permanently connected to an external power-supply.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/power/supply/axp288_charger.c | 43 +++++++++++++++++++++++++--
>  1 file changed, 40 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply=
/axp288_charger.c
> index a327933cfd6a..351431f3cf0e 100644
> --- a/drivers/power/supply/axp288_charger.c
> +++ b/drivers/power/supply/axp288_charger.c
> @@ -2,7 +2,7 @@
>  /*
>   * axp288_charger.c - X-power AXP288 PMIC Charger driver
>   *
> - * Copyright (C) 2016-2017 Hans de Goede <hdegoede@redhat.com>
> + * Copyright (C) 2016-2024 Hans de Goede <hdegoede@redhat.com>
>   * Copyright (C) 2014 Intel Corporation
>   * Author: Ramakrishna Pallala <ramakrishna.pallala@intel.com>
>   */
> @@ -148,6 +148,8 @@ struct axp288_chrg_info {
>  	unsigned int op_mode;
>  	unsigned int backend_control;
>  	bool valid;
> +	bool charge_enable;
> +	bool charge_inhibit;
>  };
> =20
>  static inline int axp288_charger_set_cc(struct axp288_chrg_info *info, i=
nt cc)
> @@ -285,9 +287,9 @@ static int axp288_charger_vbus_path_select(struct axp=
288_chrg_info *info,
>  	return ret;
>  }
> =20
> -static int axp288_charger_enable_charger(struct axp288_chrg_info *info,
> -								bool enable)
> +static int axp288_charger_update_charge_en(struct axp288_chrg_info *info)
>  {
> +	bool enable =3D info->charge_enable && !info->charge_inhibit;
>  	int ret;
> =20
>  	if (enable)
> @@ -302,6 +304,18 @@ static int axp288_charger_enable_charger(struct axp2=
88_chrg_info *info,
>  	return ret;
>  }
> =20
> +static int axp288_charger_enable_charger(struct axp288_chrg_info *info, =
bool enable)
> +{
> +	info->charge_enable =3D enable;
> +	return axp288_charger_update_charge_en(info);
> +}
> +
> +static int axp288_charger_inhibit_charger(struct axp288_chrg_info *info,=
 bool inhibit)
> +{
> +	info->charge_inhibit =3D inhibit;
> +	return axp288_charger_update_charge_en(info);
> +}
> +
>  static int axp288_get_charger_health(struct axp288_chrg_info *info)
>  {
>  	if (!(info->input_status & PS_STAT_VBUS_PRESENT))
> @@ -327,6 +341,19 @@ static int axp288_charger_usb_set_property(struct po=
wer_supply *psy,
> =20
>  	mutex_lock(&info->lock);
>  	switch (psp) {
> +	case POWER_SUPPLY_PROP_STATUS:
> +		switch (val->intval) {
> +		case POWER_SUPPLY_STATUS_CHARGING:
> +			ret =3D axp288_charger_inhibit_charger(info, false);
> +			break;
> +		case POWER_SUPPLY_STATUS_DISCHARGING:
> +		case POWER_SUPPLY_STATUS_NOT_CHARGING:
> +			ret =3D axp288_charger_inhibit_charger(info, true);
> +			break;
> +		default:
> +			ret =3D -EINVAL;
> +		}
> +		break;
>  	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
>  		scaled_val =3D min(val->intval, info->max_cc);
>  		scaled_val =3D DIV_ROUND_CLOSEST(scaled_val, 1000);
> @@ -423,6 +450,14 @@ static int axp288_charger_usb_get_property(struct po=
wer_supply *psy,
>  		goto out;
> =20
>  	switch (psp) {
> +	case POWER_SUPPLY_PROP_STATUS:
> +		if (info->charge_enable && !info->charge_inhibit)
> +			val->intval =3D POWER_SUPPLY_STATUS_CHARGING;
> +		else if (info->charge_enable && info->charge_inhibit)
> +			val->intval =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
> +		else /* !info->charge_enable && xxx */
> +			val->intval =3D POWER_SUPPLY_STATUS_DISCHARGING;
> +		break;
>  	case POWER_SUPPLY_PROP_PRESENT:
>  		/* Check for OTG case first */
>  		if (info->otg.id_short) {
> @@ -472,6 +507,7 @@ static int axp288_charger_property_is_writeable(struc=
t power_supply *psy,
>  	int ret;
> =20
>  	switch (psp) {
> +	case POWER_SUPPLY_PROP_STATUS:
>  	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
>  	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
>  	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> @@ -485,6 +521,7 @@ static int axp288_charger_property_is_writeable(struc=
t power_supply *psy,
>  }
> =20
>  static enum power_supply_property axp288_usb_props[] =3D {
> +	POWER_SUPPLY_PROP_STATUS,
>  	POWER_SUPPLY_PROP_PRESENT,
>  	POWER_SUPPLY_PROP_ONLINE,
>  	POWER_SUPPLY_PROP_TYPE,
> --=20
> 2.43.0
>=20
>=20

--hbppt4kgdbhu4jh2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmW0UoIACgkQ2O7X88g7
+prUXg/+ILZUuqCWZEeNq20Yn0W5TQRhf/VMgEHEE9VGo70JOhjQM2kXLUmytz7+
4PpwG4NpOaHvhkfoVb1UzzOlAD/Ztcv2ZwbSIMswMHzs2lwAidvpF/JyXX3Gip2Q
Z6OJWXEtksAta1W2/j4K8a13Di6YG2yjbUa+f/sYFTjxVQRUaBWZyLIBcH+i50bI
HDY/UA70lFHGhdK7TTW88HaBYTsmkSUG+7/Pfnj13wGicH1s8FnlE10UO44u9tmq
mwnrBCZsIXMMfG3CepMgZyA8glgeTXzrF/oNPNJlCqBjtIQuUTYlNmo3L7OMtc3d
fLKyDeXx/gWgDkrwu/PT1aCyVznZWgLwk2Y551pXrCHx6ggeSqoUDlzbD/oPASRu
QCUR+ifotzWtXE6E530OeB8v3n+Zt96A+RMgg4YpY+bAp6KIBhCFvwLoAmgckCa4
J7KvUF99T4tuEXTkEH+M28JJf1pa98A2ZNY1Y+zSIRhrKOaubOpfazcnIGyYLg8h
21HPP/Ej707ikR9UJ/dtR2LXpD3xLsfSr0s9cqJY2v/CLx5W9Z4F1G0Z95xrUusV
Sh4rT3Gd2QBlzNmsTOqCK5G+SwtOovjf98FEBkCDIGp5g1/95mxmZa74mZ9mkS86
5FlZEK6jVLibDYZLDGU2tFaYdbRrsrd/TbKpQDlMn9vROCkMxP0=
=QPXP
-----END PGP SIGNATURE-----

--hbppt4kgdbhu4jh2--

