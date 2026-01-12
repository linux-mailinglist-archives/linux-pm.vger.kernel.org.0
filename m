Return-Path: <linux-pm+bounces-40620-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8FBD10443
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jan 2026 02:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DB76A301F3F4
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jan 2026 01:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19FD1E8342;
	Mon, 12 Jan 2026 01:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="E9yiU3Cu"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9209B500948;
	Mon, 12 Jan 2026 01:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768181817; cv=pass; b=et1CurYq1w3RyPWN9HS3Mz45xbxcxja/c6fvAKr0obWRpk5aCjCuM118or15e6N3GR9if+LxxEtsk2Ph4Lylqc+/OYZQt4IBREQvN+5YY4/PETabA/fh7/kAOibh9mInWYCoTUxAhhrZM46bcNls+E9kwaJAYlssTYFckND+i2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768181817; c=relaxed/simple;
	bh=LDYLqRHKbTgqbn08zLidOwnAltxL9oPpdTN9trok3PQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ueIAt2SOxjnol9pgtKUhPA6MUfIdYb0FrA73KbHwMssSty2Ys6rJaAGguSaMqvmAocz5DmMsKbKLZGLMcV9Ieaw4tEaSRpQWe8E53PXga4PpHxldxiqsUCmfvqhec2FWsptEz4UIGru8EPfiXZ2rFzqT/93+Y4CurdXZJ/Fj7cU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=E9yiU3Cu; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1768181812; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=g20Nj4iQY4DF5Kou06Wu/8lYgcK7iMvLfNwnrut/+mE+9+8HqsIqhVw13tJWSjUTLjtFLc7VeBjIKjSkgCVasaYNMi1OAUpxCIbuLwU3TBDOhIUQWA8+CEf57ZG7hS/xhf2H71UQA3h8O/aT38BT9hTtD/YlV8cS2Vs65qfIQeg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1768181812; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=rnqk2aD4ZiYoXGVZC2N5SJMU2GH7sSJvEWHZJheVIOU=; 
	b=HzhJyKrMkCpX4g0SJFsb/pbvQOIdoFoQuRzZwCGMY09HU6ibCwUlrYjv0mepXqw7Lu0uEiGmMPD1qCFT7IZcKTof9YDw2b1YYfdrazsoMUGqrLuIPDG10g3+LHu0vDNG7XPABqwIoKum+u46oh92kn4p05xTON6wscdxyke5lF8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768181812;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=rnqk2aD4ZiYoXGVZC2N5SJMU2GH7sSJvEWHZJheVIOU=;
	b=E9yiU3Cu2FeI/MLbJHr7w8Q188QndNjWHzrTCos9nVxQ/syogYxqjUFR14Rfo9c7
	PHyFY39swrdd0JfCfAfItZKogdpT/b/E9jTcZtpGvXb1+pLHJX9RvG2eNvjuhon+xzm
	PrSj5pd9nBD88caG638oUFM5DXbS4fVfeJo+9tmw=
Received: by mx.zohomail.com with SMTPS id 1768181810207862.7708239611277;
	Sun, 11 Jan 2026 17:36:50 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id DACA21803AD; Mon, 12 Jan 2026 02:36:46 +0100 (CET)
Date: Mon, 12 Jan 2026 02:36:46 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Waqar Hameed <waqar.hameed@axis.com>
Cc: kernel@axis.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] power: supply: wm97xx: Use
 devm_power_supply_register()
Message-ID: <aWRPvn_BtqTb768i@venus>
References: <cover.1766270196.git.waqar.hameed@axis.com>
 <883bfa991f977dcda20f9ee6b82782850a0ab100.1766270196.git.waqar.hameed@axis.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="w2222oedhg2isdnv"
Content-Disposition: inline
In-Reply-To: <883bfa991f977dcda20f9ee6b82782850a0ab100.1766270196.git.waqar.hameed@axis.com>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.5.1/268.172.5
X-ZohoMailClient: External


--w2222oedhg2isdnv
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/3] power: supply: wm97xx: Use
 devm_power_supply_register()
MIME-Version: 1.0

Hi,

On Sat, Dec 20, 2025 at 11:46:24PM +0100, Waqar Hameed wrote:
> Instead of handling the registration manually, use the automatic
> `devres` variant `devm_power_supply_register()`. This is less error
> prone and cleaner.
>=20
> Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
> ---
>  drivers/power/supply/wm97xx_battery.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/power/supply/wm97xx_battery.c b/drivers/power/supply=
/wm97xx_battery.c
> index f00722c88c6fe..e91467dcab19c 100644
> --- a/drivers/power/supply/wm97xx_battery.c
> +++ b/drivers/power/supply/wm97xx_battery.c
> @@ -223,7 +223,7 @@ static int wm97xx_bat_probe(struct platform_device *d=
ev)
>  	bat_psy_desc.properties =3D prop;
>  	bat_psy_desc.num_properties =3D props;
> =20
> -	bat_psy =3D power_supply_register(&dev->dev, &bat_psy_desc, &cfg);
> +	bat_psy =3D devm_power_supply_register(&dev->dev, &bat_psy_desc, &cfg);
>  	if (!IS_ERR(bat_psy)) {
>  		schedule_work(&bat_work);
>  	} else {
> @@ -237,15 +237,12 @@ static int wm97xx_bat_probe(struct platform_device =
*dev)
>  		if (ret) {
>  			dev_err_probe(&dev->dev, ret,
>  				      "failed to request GPIO irq\n");
> -			goto unregister;
> +			goto free;
>  		}
>  	}
> =20
>  	return 0;
> =20
> -unregister:
> -	power_supply_unregister(bat_psy);
> -
>  free:
>  	kfree(prop);
> =20
> @@ -257,7 +254,6 @@ static void wm97xx_bat_remove(struct platform_device =
*dev)
>  	if (charge_gpiod)
>  		free_irq(gpiod_to_irq(charge_gpiod), dev);
>  	cancel_work_sync(&bat_work);
> -	power_supply_unregister(bat_psy);
>  	kfree(prop);
>  }

This free's prop before bat_psy. You fix that in the next patch, but
to be bisectable those two patches must be swapped.

Greetings,

-- Sebastian

--w2222oedhg2isdnv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmlkUCsACgkQ2O7X88g7
+pr9Dw//T8psXyiw7ONMKrY3KBHMCCxuzi/QfGoWpfM0lkMJnYvgPyyUG30hp7gv
HxhITeZS2/0upCjrAn+W+D345AICcuVYJjmM2dAOLED7VlxwrPnnwCp46pZVbd2F
qJg5hlSeqZ3EZGEU6HHX3uq9binqAl0dWvdN81f7naiIqALR/uzH2M/QOLMRpyKk
+juwnZCQEyT1yx5zqCT0A4gX3b80lhjB+h5ynkne4eQiCqXJGVkMMxf4Yw8+GbHr
SlVu7EutOYUQcD3aHsxfv+98XZAainv65aq5uq6PN/O/5MmFY5NtDzSYGVIJdSNO
zrefb+OEvPzrGiKskd3dYv5I+zM5j5tKNm+l3F+2n4yuvozIjq4uB0qcaT4JhhSy
Dw5w68w4zMVVIqZd06+krXxe0GUlPzS/zovgZuMbinKv83rSFJmt5IanlEnrfoaU
pie91wtjOHXbvfl02TepHN9jjQAb6xSvCf/6nOelKW3T3bThizmfjpGzwwY9kbSN
r3PkO1X1fFWhDMklUa/WCrxjJI/eUYiDgaanTnOTQiKi2dwNFkM3jHxcgMWqBglN
hacIZNxcF0W80UFS/aaN6XVORUcNa8B5qOEj/c/JiNpHDom4jO0eqmH18bLo62nQ
76S3YhD27k3Ek0spDrYFF/t69wQnwB50v3V0N0RDtnyedAjsnhQ=
=a8RT
-----END PGP SIGNATURE-----

--w2222oedhg2isdnv--

