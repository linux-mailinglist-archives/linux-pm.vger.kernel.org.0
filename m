Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14AEE20C106
	for <lists+linux-pm@lfdr.de>; Sat, 27 Jun 2020 13:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgF0LWf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 27 Jun 2020 07:22:35 -0400
Received: from a80-127-99-228.adsl.xs4all.nl ([80.127.99.228]:54706 "EHLO
        hetgrotebos.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726335AbgF0LWe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 27 Jun 2020 07:22:34 -0400
X-Greylist: delayed 1383 seconds by postgrey-1.27 at vger.kernel.org; Sat, 27 Jun 2020 07:22:34 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wizzup.org;
         s=mail; h=Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:
        References:To:Subject:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
        :List-Post:List-Owner:List-Archive;
        bh=6Y0G24DWZTl7Y9d2Di6ctvuYnQTF7wIjrPXmlpmLerg=; b=nuDyOd7CHkIJrmo8+ZarVzDzGT
        SD3XBzODzapIph7h2HMq7q7vrh4/PqMW8ESsP5NBPbeqsEkErBKCVKNE1GtKglcO/EB4djM8OZghb
        mKYCFwwL4jE5Bh4rydhCOAgKmuIxersgCQmq9HZ99xvGhkQqRO781XvNBzDglJB3CAUYK2RpIE0eN
        V4UpNJvBmLCEmq+G7svBDlKhm/f/snAw5hR8uO0r+24QTw1FCgms4MfRkbNREDmY0sdnceHFmBYg0
        w7yOA0W1NLvOdhrj9JpwsG/IbyFfC7SkcG9uEm2bOakmXL04QLUmtrH1hFxFEvUGLt5uIZ3Gmud+Y
        l+OQ8SOw==;
Received: from deepwater.fritz.box ([192.168.178.25] helo=[0.0.0.0])
        by hetgrotebos.org with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <merlijn@wizzup.org>)
        id 1jp8YT-0001Q4-BK; Sat, 27 Jun 2020 10:59:29 +0000
Subject: Re: [RFC] Limiting charge current on Droid 4 (and N900)
To:     Pavel Machek <pavel@ucw.cz>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org,
        nekit1000@gmail.com, mpartap@gmx.net, martin_rysavy@centrum.cz,
        linux-pm@vger.kernel.org
References: <20200615140557.GA22781@duo.ucw.cz>
From:   Merlijn Wajer <merlijn@wizzup.org>
Autocrypt: addr=merlijn@wizzup.org; prefer-encrypt=mutual; keydata=
 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
 /XslHw==
Message-ID: <23f924be-a0ee-8efa-d92c-da83700261da@wizzup.org>
Date:   Sat, 27 Jun 2020 13:01:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200615140557.GA22781@duo.ucw.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="SwL4Cnhd8NqPrfxVtBXRx3uai6MFB7BWT"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SwL4Cnhd8NqPrfxVtBXRx3uai6MFB7BWT
Content-Type: multipart/mixed; boundary="JYTEYrIovc0tITmSmcVYhg0lVz2tkRjCJ"

--JYTEYrIovc0tITmSmcVYhg0lVz2tkRjCJ
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

On 15/06/2020 16:05, Pavel Machek wrote:
> Hi!
>=20
> Droid 4 has same problem as N900: it is often neccessary to manually
> tweak current draw from USB, for example when using thin charging cable=
=2E
>=20
> N900 creates unique attribute by hand, but I believe
> POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT looks suitable. (Should N900 be
> converted?)
>=20
> Comments? Would the patch be acceptable after fixing whitespace?

I'm not very knowledgeable on batteries - but the patch looks good to me.=


Could you perhaps explain what exactly this fixes? I've seen some
interesting behaviour when plugging a Droid 4 into a PC (or wall
charger, really): the led blinks for a few seconds until it stabilises.

And then there's the issue where, once the battery is full, it will
switch between charging and discharging every few seconds/minutes.

Cheers,
Merlijn

>=20
> Best regards,
> 									Pavel
>=20
> Signed-off-by: Pavel Machek <pavel@ucw.cz>
>=20
> diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/suppl=
y/cpcap-battery.c
> index b16848cfb58c..39a00716372f 100644
> --- a/drivers/power/supply/cpcap-battery.c
> +++ b/drivers/power/supply/cpcap-battery.c
> @@ -3,7 +3,7 @@
>   *
>   * Copyright (C) 2017 Tony Lindgren <tony@atomide.com>
>   *
> - * Some parts of the code based on earlie Motorola mapphone Linux kern=
el
> + * Some parts of the code based on earlier Motorola mapphone Linux ker=
nel
>   * drivers:
>   *
>   * Copyright (C) 2009-2010 Motorola, Inc.
> diff --git a/drivers/power/supply/cpcap-charger.c b/drivers/power/suppl=
y/cpcap-charger.c
> index cf1e05b511d9..292d7a31c663 100644
> --- a/drivers/power/supply/cpcap-charger.c
> +++ b/drivers/power/supply/cpcap-charger.c
> @@ -89,6 +89,8 @@
>   * CPCAP_REG_CRM charge currents. These seem to match MC13783UG.pdf
>   * values in "Table 8-3. Charge Path Regulator Current Limit
>   * Characteristics" for the nominal values.
> + *
> + * Except 70mA and 1.596A and unlimited, these are simply 88.7mA / ste=
p.
>   */
>  #define CPCAP_REG_CRM_ICHRG(val)	(((val) & 0xf) << 0)
>  #define CPCAP_REG_CRM_ICHRG_0A000	CPCAP_REG_CRM_ICHRG(0x0)
> @@ -147,6 +149,8 @@ struct cpcap_charger_ddata {
>  	int status;
>  	int state;
>  	int voltage;
> +	int limit_current;
> +
>  	int last_current;
>  	int last_current_retries;
>  };
> @@ -175,6 +179,7 @@ static enum power_supply_property cpcap_charger_pro=
ps[] =3D {
>  	POWER_SUPPLY_PROP_STATUS,
>  	POWER_SUPPLY_PROP_ONLINE,
>  	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
> +	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
>  	POWER_SUPPLY_PROP_VOLTAGE_NOW,
>  	POWER_SUPPLY_PROP_CURRENT_NOW,
>  };
> @@ -238,6 +243,9 @@ static int cpcap_charger_get_property(struct power_=
supply *psy,
>  	case POWER_SUPPLY_PROP_STATUS:
>  		val->intval =3D ddata->status;
>  		break;
> +  	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +		val->intval =3D ddata->limit_current;
> +		break;
>  	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
>  		val->intval =3D ddata->voltage;
>  		break;
> @@ -308,6 +316,25 @@ cpcap_charger_get_bat_const_charge_voltage(struct =
cpcap_charger_ddata *ddata)
>  	return voltage;
>  }
> =20
> +static int cpcap_charger_current_to_regval(int microamp)
> +{
> +	int miliamp =3D microamp/1000;
> +	int res;
> +	if (miliamp < 0)
> +		return -EINVAL;
> +	if (miliamp < 70)
> +		return CPCAP_REG_CRM_ICHRG(0x0);
> +	if (miliamp < 177)
> +		return CPCAP_REG_CRM_ICHRG(0x1);
> +	if (miliamp > 1596)
> +		return CPCAP_REG_CRM_ICHRG(0xe);
> +
> +	res =3D microamp / 88666;
> +	if (res > 0xd)
> +		res =3D 0xd;
> +	return CPCAP_REG_CRM_ICHRG(res);
> +}
> +
>  static int cpcap_charger_set_property(struct power_supply *psy,
>  				      enum power_supply_property psp,
>  				      const union power_supply_propval *val)
> @@ -316,6 +343,12 @@ static int cpcap_charger_set_property(struct power=
_supply *psy,
>  	int voltage, batvolt;
> =20
>  	switch (psp) {
> +  	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +		if (cpcap_charger_current_to_regval(val->intval) < 0)
> +			return -EINVAL;
> +		ddata->limit_current =3D val->intval;
> +		schedule_delayed_work(&ddata->detect_work, 0);
> +		break;
>  	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
>  		voltage =3D cpcap_charger_match_voltage(val->intval);
>  		batvolt =3D cpcap_charger_get_bat_const_charge_voltage(ddata);
> @@ -335,6 +368,7 @@ static int cpcap_charger_property_is_writeable(stru=
ct power_supply *psy,
>  					       enum power_supply_property psp)
>  {
>  	switch (psp) {
> +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
>  	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
>  		return 1;
>  	default:
> @@ -657,23 +691,21 @@ static void cpcap_usb_detect(struct work_struct *=
work)
> =20
>  	if (!ddata->feeding_vbus && cpcap_charger_vbus_valid(ddata) &&
>  	    s.chrgcurr1) {
> -		int max_current;
> -		int vchrg;
> +		int max_current =3D 532000;
> +		int vchrg, ichrg;
> =20
>  		if (cpcap_charger_battery_found(ddata))
> -			max_current =3D CPCAP_REG_CRM_ICHRG_1A596;
> -		else
> -			max_current =3D CPCAP_REG_CRM_ICHRG_0A532;
> +			max_current =3D 1596000;
> =20
>  		switch (ddata->state) {
>  		case CPCAP_CHARGER_DETECTING:
>  			ddata->last_current_retries =3D 0;
>  			break;
>  		case CPCAP_CHARGER_DISCONNECTED:
> -			if (ddata->last_current > CPCAP_REG_CRM_ICHRG_0A532) {
> +			if (ddata->last_current > 532000) {
>  				/* Attempt current 3 times before lowering */
>  				if (ddata->last_current_retries++ >=3D 3) {
> -					ddata->last_current--;
> +					ddata->last_current -=3D 100000;
>  					ddata->last_current_retries =3D 0;
>  					/* Wait a bit for voltage to ramp up */
>  					usleep_range(40000, 50000);
> @@ -688,11 +720,16 @@ static void cpcap_usb_detect(struct work_struct *=
work)
>  			break;
>  		}
> =20
> +		if (max_current > ddata->limit_current)
> +			max_current =3D ddata->limit_current;
> +
>  		ddata->last_current =3D max_current;
> +
> +		ichrg =3D cpcap_charger_current_to_regval(max_current);
>  		vchrg =3D cpcap_charger_voltage_to_regval(ddata->voltage);
>  		error =3D cpcap_charger_set_state(ddata,
>  						CPCAP_REG_CRM_VCHRG(vchrg),
> -						max_current, 0);
> +						ichrg, 0);
>  		if (error)
>  			goto out_err;
>  		cpcap_charger_update_state(ddata, CPCAP_CHARGER_CHARGING);
> @@ -864,6 +901,7 @@ static int cpcap_charger_probe(struct platform_devi=
ce *pdev)
> =20
>  	ddata->dev =3D &pdev->dev;
>  	ddata->voltage =3D 4200000;
> +	ddata->limit_current =3D 532000;
> =20
>  	ddata->reg =3D dev_get_regmap(ddata->dev->parent, NULL);
>  	if (!ddata->reg)
>=20



--JYTEYrIovc0tITmSmcVYhg0lVz2tkRjCJ--

--SwL4Cnhd8NqPrfxVtBXRx3uai6MFB7BWT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQRM5LT7NbLF9yb6a/UGN09rynK8WgUCXvcnIQAKCRAGN09rynK8
WlniAQDJzbDRCxUatgA1uE/K/Lk+/Ccck71ee/mR4SJPvpu3KwEAmGnPNi4vV/ZG
j8JKE+iATn+b1yftXQdhtJXQLEqSEwk=
=6bEJ
-----END PGP SIGNATURE-----

--SwL4Cnhd8NqPrfxVtBXRx3uai6MFB7BWT--
