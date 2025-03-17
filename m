Return-Path: <linux-pm+bounces-24196-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A75C0A656BB
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 16:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C93A5189C89C
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 15:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BAB317A318;
	Mon, 17 Mar 2025 15:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="UnlXVTBD"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192EF1A238E;
	Mon, 17 Mar 2025 15:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742226722; cv=pass; b=rTeCUdLxGHRDmTcyqcHjNlDWDjjrmT8q/IO5kkeaTE12VDoLnbDzwpnZUtNiA0fEn8dswMauX0Z/YgiZHjFkgd7E5tL28q2Z8DOb5ifZMAw9WQ5SC1PHlB1FwmaYgGFaaQomkP7PBhmoC+IdET33C/57KxpUgyDl6Y9gxxuWxqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742226722; c=relaxed/simple;
	bh=P5LypDmvDga9XQKn80aXCmx3Xwkb8b0kppTX0ThWVLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=odjC+VG4llNhrKum3FaNT2LmPBNEws3sqQSpK80bU/94G26J4915j6U9S1fHTrojq8UavJ20LODr6/zfLswn0CNFUXTQ3DLehgCrSfRSOSedAZJ5bv1x5W/3imubsJFgqbJUkVnwl4uH/60B4FVkVpTOllAQlLCeJjAj9JmVvXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=UnlXVTBD; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1742226453; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=CHnkGe8bc+XwhKIBH7ZPncuX9d2IUd/4OikOZht21mfbchsKXKQDJ6WiyVJjPI4Mbg1Wbfb+U3Z4aIm+gbINcZ8UiLhhcLQOWORv8pBCPn1qSs3XAn86Ruhy34yY/JBVr5Yoof5mVAXHMEd9/VlOMbNx5VGQTwJH8yx0Rna9mYo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1742226453; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=NeEI1h53Am9B1mtWyRykxM7n9ZW6Na1dlrEcGPnLqAE=; 
	b=SGYkPDm84SUYN0qEJfCw7fdtHSwZircn5Tn3Fjt6m5POWQSpXusSMLtystddIAHSs0lOWkKY7dGtV1wOoSiU6b1jz5bu0X5RT3jC/SwknWEPzuq7zMLpZq1Zl084G5non5nQN4vj4rkgHp7dqs3x2hYcTkPF59k9SKSM/Ybf2Zw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742226453;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=NeEI1h53Am9B1mtWyRykxM7n9ZW6Na1dlrEcGPnLqAE=;
	b=UnlXVTBDWwQPPn/pAPMPtc3n4O/nJ9DT43/hvjHu0FIWY1AMCq7eit8QVL617AAY
	sOhKKPKYLc6yaWdF/UTAlfGSpKcbd4hy1i1dklKUMwHFFaKm6BMlWxZ8qqkt8jnfTfb
	77pFRf6RKgUPHN5oW+JAwX7Gp2lpmQvD8QsVKP40=
Received: by mx.zohomail.com with SMTPS id 1742226450524793.5875178849117;
	Mon, 17 Mar 2025 08:47:30 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 2A9A21807C3; Mon, 17 Mar 2025 16:47:26 +0100 (CET)
Date: Mon, 17 Mar 2025 16:47:26 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: "Sicelo A. Mhlongo" <absicsz@gmail.com>
Cc: linux-pm@vger.kernel.org, "H . Nikolaus Schaller" <hns@goldelico.com>, 
	pali@kernel.org, maemo-leste@lists.dyne.org, phone-devel@vger.kernel.org, 
	letux-kernel@openphoenux.org, akemnade@kernel.org
Subject: Re: [PATCH 2/2] power: supply: bq27xxx: do not report incorrect zero
 values
Message-ID: <7kkc5wxrzeinouvbgehi7boqs3o7xnecc6bvqx32x2sgjx65qa@3coezintwck3>
References: <20250312121712.146109-1-absicsz@gmail.com>
 <20250312121712.146109-3-absicsz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3cuuxarhuphg53ew"
Content-Disposition: inline
In-Reply-To: <20250312121712.146109-3-absicsz@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.2/242.165.94
X-ZohoMailClient: External


--3cuuxarhuphg53ew
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/2] power: supply: bq27xxx: do not report incorrect zero
 values
MIME-Version: 1.0

Hi,

On Wed, Mar 12, 2025 at 02:14:09PM +0200, Sicelo A. Mhlongo wrote:
> On the bq27x00 and bq27x10 variants, a number of conditions can reset the
> value stored in the NAC register. This will cause capacity, time-to-empty,
> energy, and charge to report the value 0, even when the battery is full.
> On the other hand, the chips provide a flag, EDVF, which reliably reports
> the true battery empty condition, when these properties are really zero.
> Therefore, discard readings for these properties if their value is 0 while
> EDVF is unset.
>=20
> Tested on the Nokia N900 with bq27200.
>=20
> Signed-off-by: Sicelo A. Mhlongo <absicsz@gmail.com>
> ---
>  drivers/power/supply/bq27xxx_battery.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/suppl=
y/bq27xxx_battery.c
> index 2f31d750a4c1..29fc51653b5f 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -2147,6 +2147,10 @@ static int bq27xxx_battery_get_property(struct pow=
er_supply *psy,
>  		ret =3D bq27xxx_battery_current_and_status(di, val, NULL, NULL);
>  		break;
>  	case POWER_SUPPLY_PROP_CAPACITY:
> +		/* If 0 is reported, it is expected that EDVF is also set */
> +		if (!di->cache.capacity && di->opts & BQ27XXX_O_ZERO &&
> +		   !(di->cache.flags & BQ27000_FLAG_EDVF))
> +			return -EINVAL;

This has been replicated 5 times in this patch now. Please create a
small helper function for it. Something like

/* If val =3D=3D 0 is reported, it is expected that EDVF is also set */
void bq27xxx_check_zero_edvf(int *ret, int val, struct bq27xxx_device_info =
*di) {
    if (*ret)
        return;
    if (val)
        return;
    if (!(di->opts & BQ27XXX_O_ZERO))
        return;
    if (di->cache.flags & BQ27000_FLAG_EDVF)
        return;

    *ret =3D -EINVAL;
}

bq27xxx_check_zero_edvf(ret, di->cache.capacity, di);

Otherwise I think it is sensible to wait for H . Nikolaus Schaller
to give this another test (possibly in v3).

-- Greetings,

-- Sebastian

>  		ret =3D bq27xxx_simple_value(di->cache.capacity, val);
>  		break;
>  	case POWER_SUPPLY_PROP_CAPACITY_LEVEL:
> @@ -2157,9 +2161,17 @@ static int bq27xxx_battery_get_property(struct pow=
er_supply *psy,
>  		break;
>  	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW:
>  		ret =3D bq27xxx_battery_read_time(di, BQ27XXX_REG_TTE, val);
> +		/* If 0 is reported, it is expected that EDVF is also set */
> +		if (!ret && !val->intval && di->opts & BQ27XXX_O_ZERO &&
> +		   !(di->cache.flags & BQ27000_FLAG_EDVF))
> +			return -EINVAL;
>  		break;
>  	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG:
>  		ret =3D bq27xxx_battery_read_time(di, BQ27XXX_REG_TTECP, val);
> +		/* If 0 is reported, it is expected that EDVF is also set */
> +		if (!ret && !val->intval && di->opts & BQ27XXX_O_ZERO &&
> +		   !(di->cache.flags & BQ27000_FLAG_EDVF))
> +			return -EINVAL;
>  		break;
>  	case POWER_SUPPLY_PROP_TIME_TO_FULL_NOW:
>  		ret =3D bq27xxx_battery_read_time(di, BQ27XXX_REG_TTF, val);
> @@ -2171,10 +2183,15 @@ static int bq27xxx_battery_get_property(struct po=
wer_supply *psy,
>  			val->intval =3D POWER_SUPPLY_TECHNOLOGY_LION;
>  		break;
>  	case POWER_SUPPLY_PROP_CHARGE_NOW:
> -		if (di->regs[BQ27XXX_REG_NAC] !=3D INVALID_REG_ADDR)
> +		if (di->regs[BQ27XXX_REG_NAC] !=3D INVALID_REG_ADDR) {
>  			ret =3D bq27xxx_battery_read_nac(di, val);
> -		else
> +			/* If 0 is reported, it is expected that EDVF is also set */
> +			if (!ret && !val->intval && di->opts & BQ27XXX_O_ZERO &&
> +			   !(di->cache.flags & BQ27000_FLAG_EDVF))
> +				return -EINVAL;
> +		} else {
>  			ret =3D bq27xxx_battery_read_rc(di, val);
> +		}
>  		break;
>  	case POWER_SUPPLY_PROP_CHARGE_FULL:
>  		ret =3D bq27xxx_battery_read_fcc(di, val);
> @@ -2199,6 +2216,10 @@ static int bq27xxx_battery_get_property(struct pow=
er_supply *psy,
>  		break;
>  	case POWER_SUPPLY_PROP_ENERGY_NOW:
>  		ret =3D bq27xxx_battery_read_energy(di, val);
> +		/* If 0 is reported, it is expected that EDVF is also set */
> +		if (!ret && !val->intval && di->opts & BQ27XXX_O_ZERO &&
> +		   !(di->cache.flags & BQ27000_FLAG_EDVF))
> +			return -EINVAL;
>  		break;
>  	case POWER_SUPPLY_PROP_POWER_AVG:
>  		ret =3D bq27xxx_battery_pwr_avg(di, val);
> --=20
> 2.47.2
>=20

--3cuuxarhuphg53ew
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmfYRAMACgkQ2O7X88g7
+pp8OQ/9FCJBvILON5ZE+VMAEad0+YdShiDfHnMPvFc4dPVf62jXPrG+EzKjZhjB
ObFUteJeWzEtK8F38UEO0et4UHwVuRy41b3W0Pb0OgPZeUnBSXvjkHR9UCHMf8n/
DpBZ68enDIDUh6qNTCXTu6OwtOixUpXY6+Nu/hBNB1AhEFdPLksNBnj7sbDy4252
AgoENDX6212zDnlOPPXIeHBOH3/DdvqKlpL6VLm9ID9JsJP0QrNf1O8sOMhFaIiV
ayj/c3dkolmLw/i/Kt6BZcsuD6UVE79kIfCV4Emi+jW57dW47M8nzZ3R6JIlmgyX
PSWbBq36CuyEa0AjaWDakhj/fkZhO9AG7Q4CtmJ+ip4WMisDwyS078GhRDoWqVrO
QnVsJbActcEVajbfuFvtSrB+RDZkPkmW42rgFPC/TCMdNkNSS/NUabz9LYymq5l0
Z99K8VSMohvO0RIcI2sCPchqEOBzKYolHpzLxNJ18/7XGU9IjTK2IUm3XCyLx9z2
r0WksYBY7bzhz6soVlWJTdw84YIlPJUjqTLbTUyTicob0vdOl4Ck9PmoVSRxyjQl
McD8pclCYt4wj9PXFmxT1GU/v1kGSshRaNJ1UR5PuR0aBOIYa39hMjyqUpgBk8Hs
8ZaojqalNg6b2u421zyEiniAFAZTLMjqK/tkrIrv4NgBAdGoOV0=
=y3US
-----END PGP SIGNATURE-----

--3cuuxarhuphg53ew--

