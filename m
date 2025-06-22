Return-Path: <linux-pm+bounces-29237-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 687C7AE3255
	for <lists+linux-pm@lfdr.de>; Sun, 22 Jun 2025 23:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9FAA16F232
	for <lists+linux-pm@lfdr.de>; Sun, 22 Jun 2025 21:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8601EBA09;
	Sun, 22 Jun 2025 21:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="iJUViihH"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578E8EAC6;
	Sun, 22 Jun 2025 21:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750627586; cv=pass; b=KBYPZwajrPtF4s/2rb43jmxhKxmY+geT9wCvEwnFetctUhHb6FUGHo4NrGMHqQr4IOn/QmMbVTjeHRLuoBhAJiA+hKtWNWe1e6qgZ71u9ApQXngIVFbQugVCE5KTdAIiZ1E+xglmvcO0oLeYMKNy46W1XCa5ISWFcWx9xO73f0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750627586; c=relaxed/simple;
	bh=3qI1vB59KDHTXXseTyclwBXRlKJR2L8wddHki2G0w4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PKX0orizD/t+cwhKiP4rFPuoDwvh3//3yhBFqyojAPx2gO8xc2zatb6oUTLRaB9WchInJcJHeTKMC2ONiOFuY8rOUl/UcC983TugQrz3+stOwfbyHMYYBt4IIS3Kvt0T9hFw1++GEkTaqmRxks0WHhSs4Zg9aDyKgJ5z2TKtFuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=iJUViihH; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1750627568; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=J8awfYP+dAADLyOGNe0XrnTwqwf4Fx9cDswv9VC3aciGetXBJ8qEnVtJV2qmW9DwjZSoJ7k0iZB2pBGPyBf2sviR/qsUm0TxjHwzn5N3NywEe7pVie9wi4kNFzki9S9Y88paZklzmSSOj219tdkR0f5lxbTxQy0j8IAramk4jKM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1750627568; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=x6QYFg9MZSJaPba+bOOJAjvKweuKxu9aNrA+7HlGnWA=; 
	b=SiYwLc1Po94YTarK/yMFSGCtwjgNLvYbgblPhBC1Pxgh+7j6BCXP+n+fJUI0aCliv0BUuFUJXQcQCj4lxLnvvcpgubzbI6QU2EXj+sQz07nUrIj6QvoEaWroT09/xRB0HKro1ypb+uOATmhpc3Z/gZp3inDQjMmL8XMMWp1cpvM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1750627568;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=x6QYFg9MZSJaPba+bOOJAjvKweuKxu9aNrA+7HlGnWA=;
	b=iJUViihHNXpXsTjxi70EDTSmnFYmOpdjGnH6to6ZLrituZOKCJNEFAhO0NmXp2ea
	o0Uysj9wgCxUPkvuuuGUae6SRxupTMaTVgDtcYeNZcW66+lAdxzEuckzBFEmsfm1nKL
	GlNdkIsLmJ+jD6gCvqK5a80JVpZ9Cvc51Qh7A7W8=
Received: by mx.zohomail.com with SMTPS id 1750627566650272.8188357692733;
	Sun, 22 Jun 2025 14:26:06 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 8B069180957; Sun, 22 Jun 2025 23:26:01 +0200 (CEST)
Date: Sun, 22 Jun 2025 23:26:01 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: t.antoine@uclouvain.be
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dimitri Fedrau <dima.fedrau@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Peter Griffin <peter.griffin@linaro.org>, 
	=?utf-8?B?QW5kcsOp?= Draszik <andre.draszik@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v4 2/5] power: supply: add support for max77759 fuel gauge
Message-ID: <4cahu6dog7ly4ww6xyjmjigjfxs4m55mrnym2bjmzskscfvk34@guazy6wxbzfh>
References: <20250523-b4-gs101_max77759_fg-v4-0-b49904e35a34@uclouvain.be>
 <20250523-b4-gs101_max77759_fg-v4-2-b49904e35a34@uclouvain.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oe6ecr6a3aggzpmd"
Content-Disposition: inline
In-Reply-To: <20250523-b4-gs101_max77759_fg-v4-2-b49904e35a34@uclouvain.be>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.3/250.624.82
X-ZohoMailClient: External


--oe6ecr6a3aggzpmd
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 2/5] power: supply: add support for max77759 fuel gauge
MIME-Version: 1.0

Hi,

On Fri, May 23, 2025 at 02:51:45PM +0200, Thomas Antoine via B4 Relay wrote:
> From: Thomas Antoine <t.antoine@uclouvain.be>
>=20
> The interface of the Maxim MAX77759 fuel gauge has a lot of common with t=
he
> Maxim MAX1720x. A major difference is the lack of non-volatile memory
> slave address. No slave is available at address 0xb of the i2c bus, which
> is coherent with the following driver from google: line 5836 disables
> non-volatile memory for m5 gauge.
>=20
> Link: https://android.googlesource.com/kernel/google-modules/bms/+/1a68c3=
6bef474573cc8629cc1d121eb6a81ab68c/max1720x_battery.c
>=20
> Other differences include the lack of V_BATT register to read the battery
> level. The voltage must instead be read from V_CELL, the lowest voltage of
> all cells. The mask to identify the chip is different. The computation of
> the charge must also be changed to take into account TASKPERIOD, which
> can add a factor 2 to the result.
>=20
> Add support for the MAX77759 by taking into account all of those
> differences based on chip type.
>=20
> Do not advertise temp probes using the non-volatile memory as those are
> not available.
>=20
> The regmap was proposed by Andr=E9 Draszik in
>=20
> Link: https://lore.kernel.org/all/d1bade77b5281c1de6b2ddcb4dbbd033e455a11=
6.camel@linaro.org/
>=20
> Signed-off-by: Thomas Antoine <t.antoine@uclouvain.be>
> ---
>  drivers/power/supply/max1720x_battery.c | 265 ++++++++++++++++++++++++++=
++----
>  1 file changed, 238 insertions(+), 27 deletions(-)
>=20
> diff --git a/drivers/power/supply/max1720x_battery.c b/drivers/power/supp=
ly/max1720x_battery.c
> index 68b5314ecf3a234f906ec8fe400e586855b69cd9..c9ad452ada9d0a2a51f37d04f=
d8c3260be522405 100644
> --- a/drivers/power/supply/max1720x_battery.c
> +++ b/drivers/power/supply/max1720x_battery.c
> @@ -37,6 +37,7 @@
>  #define MAX172XX_REPCAP			0x05	/* Average capacity */
>  #define MAX172XX_REPSOC			0x06	/* Percentage of charge */
>  #define MAX172XX_TEMP			0x08	/* Temperature */
> +#define MAX172XX_VCELL			0x09	/* Lowest cell voltage */
[...]
>  	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
[...]
> +			ret =3D regmap_read(info->regmap, MAX172XX_VCELL, &reg_val);
> +			val->intval =3D max172xx_cell_voltage_to_ps(reg_val);

I haven't reviewed this fully due to all the feedback you already
got from Peter Griffin and the DT binding being broken, but something
that catched my eye:

POWER_SUPPLY_PROP_VOLTAGE_NOW provides the voltage of the whole
battery and not of a single cell. E.g. a typical Li-Ion battery
with two serial cells has a nominal voltage of roughly 7.4V while
each cell has just 3.7V.

Greetings,

-- Sebastian

--oe6ecr6a3aggzpmd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmhYdOIACgkQ2O7X88g7
+pqIpQ//aah0Ve9/wmkexuWeuXsLJcLZfrr/02nM1RWHE9+xqx9amUZmJmRHiw4E
43m7GZdks18Da8+Uqc7YI9ukBpOoabCt31kevyHGN3h5QqJjK9MuN8UQKnAkxYra
k2Unu1pmXMnfrQOACQxlkjqal4vmFvQBjNsbmM3D+ucTVyUhYZrikzclRCHgpl+L
f1mDGGPKbl5vxBp3Ij/b8uVJ0zZqrnZ0uirhxtqAZxVW0TY5uLv6BtS48eXkCcoI
9Ia1XkzJTM/ym7isTN76/fYFpSaJpou8iGF01+X+Jij4A4JY3Frqw1gOsFCfPk1o
XT6b2Vzh0fq8o0RVyw8IMgXZJsS5RWuY+HIyRAY60EJZ1uO1VSUCCZnEB9HMnxin
SfO/qmJ5uRQGzlowAiIJLaiPxAPPVc6MFBMC+NV3R1xstdZS7+DVGHroEz0Bhyqi
oOBrVfEW0d0lkaj4qZz/KQMICEniCN6qKfRboh2bRzP85j/dkGbGDbzjNC+7T9UN
A0DJdpawEUyTv3FXkkm0ehoFWkRc9EKwkEh1cug0zbhflXONXsfyjol/Gy9ecgsZ
b9wyJu1CHEahpyPq9dOa4WGZH4D2etuBeuLEPq93FAk/WJBtk2eFQgmaKXJDIDcD
esMPKU0zXu5ZKjhsNJbDag5vwLtfUDrL+1/KcHgnKhZfjA3xevs=
=sQmb
-----END PGP SIGNATURE-----

--oe6ecr6a3aggzpmd--

