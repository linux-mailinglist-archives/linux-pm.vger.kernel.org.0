Return-Path: <linux-pm+bounces-14355-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8340E97AC48
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2024 09:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B679C1C21C6D
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2024 07:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C781494AD;
	Tue, 17 Sep 2024 07:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="D+sHUS7w"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5217F477
	for <linux-pm@vger.kernel.org>; Tue, 17 Sep 2024 07:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726558722; cv=pass; b=ULFZxf6grjxgGPX8GJKq1yGBKjE2lPjGBzWkY6pu5pFx4TWNS+Nl85LnmgMa51dBa7kRgSJL4knz+SSIIB5CNkMw9afDcqeChSitkgtlnpbZaLD5OQin36YRAm4J5gctKL44hS5yLQo1s+p5BDt91bOcjGrqi4fTimsIGEY8TIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726558722; c=relaxed/simple;
	bh=hHK02GsRfKPcxoi+vGl+ElSsQwtC1S+BYJ4Y38ChjJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pjLlPAHOhOE2en+goMdd4DcUiDvm75rXZgrr56dbLgu3mQWsg+vl6Ghzkkc1hMB1uDc2j0bJYVufJ9PEB8HAFsoSrOXn+uKOkdBlS8+nHjZWdvi5esDVrYxho2sEE9JEwVCvox6ohfWR2t4dPo3jwYODakwGdIYVW0dnzpOSX4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=D+sHUS7w; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1726558708; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mVe3i7lT3kSjtTmjyKbWAN9iSzwifWRWwJfYqMr3MBIRYrGPEm0J6J+bFlc1h+dF77vyHjAmhl1q4ltRqywI6wPWe8XuyHpCF2X6M3Hdzr6oDtJ6tnNU/Z+r8eefKPdRYaqBNTIWfC9WKAgKC9QFnybkNdJya4cHTlp4VsIvmxI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1726558708; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=V5BisTaNoGuWRgE7HRcbwC+sv9bqkILXe+qKUFKCx14=; 
	b=arxkMjZq46EnWMNJM1hV5jkFX/V0GsjPcVqNUyNRX1dEy4SXxWeQQq+4t2t2M6WVlgJE1J8OreY4rWyqPXdVmCtMRMjFPc689/NnokGd8JPbG77xuWvUiIWwcOmTFIwlNOpAo1e0JCelfOrlV7oLDKJ+YzsD4QtrPJqc9axr8FE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1726558708;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=V5BisTaNoGuWRgE7HRcbwC+sv9bqkILXe+qKUFKCx14=;
	b=D+sHUS7w03dZ7HPtuInO1TN9FDu1ZBHDxQbfLq2Vm3hxWxZysqT68QTYRWx//kmz
	p/ZP/527/47VcvdmsaBk7eHCyTRjKtoZSm+z3o63sMvKX/CDBu7fn2h/e+7sRASeJR3
	0F4f2KhdLRUJGjxo7222rx/dKAbr8ycL7KQxv1Ys=
Received: by mx.zohomail.com with SMTPS id 1726558706459406.1664580077638;
	Tue, 17 Sep 2024 00:38:26 -0700 (PDT)
Received: by mercury (Postfix, from userid 1000)
	id AB954106045D; Tue, 17 Sep 2024 09:38:22 +0200 (CEST)
Date: Tue, 17 Sep 2024 09:38:22 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jelle van der Waa <jelle@vdwaa.nl>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/4] power: supply: sysfs: Make
 power_supply_show_enum_with_available() deal with labels with a space
Message-ID: <2crw2apbxixaqq6vibtlewe47nvqeo2cnwo2okdiqtaelvtjce@g6mhr4iproiz>
References: <20240908192303.151562-1-hdegoede@redhat.com>
 <20240908192303.151562-2-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="flnicamozbzuup7v"
Content-Disposition: inline
In-Reply-To: <20240908192303.151562-2-hdegoede@redhat.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.3.1/223.982.64
X-ZohoMailClient: External


--flnicamozbzuup7v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Hans,

On Sun, Sep 08, 2024 at 09:23:00PM GMT, Hans de Goede wrote:
> Some enum style power-supply properties have text-values / labels for some
> of the enum values containing a space, e.g. "Long Life" for
> POWER_SUPPLY_CHARGE_TYPE_LONGLIFE.
>=20
> Make power_supply_show_enum_with_available() surround these label with ""
> when the label is not for the active enum value to make it clear that this
> is a single label and not 2 different labels for 2 different enum values.
>=20
> After this the output for a battery which support "Long Life" will be e.g=
=2E:
>=20
> Fast [Standard] "Long Life"
>=20
> or:
>=20
> Fast Standard [Long Life]
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---

This looks annoying from parsing point of view. Maybe we can just
replace " " with "_" and guarantee that space is a value separator
at the cost of the values not being exactly the same as the existing
charge_type sysfs file?

Do you know if there is prior examples for this in the kernel by
chance?

Greetings,

-- Sebastian

>  drivers/power/supply/power_supply_sysfs.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/su=
pply/power_supply_sysfs.c
> index 16b3c5880cd8..ac42784eab11 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -253,7 +253,10 @@ static ssize_t power_supply_show_enum_with_available(
>  			count +=3D sysfs_emit_at(buf, count, "[%s] ", labels[i]);
>  			match =3D true;
>  		} else if (available) {
> -			count +=3D sysfs_emit_at(buf, count, "%s ", labels[i]);
> +			if (strchr(labels[i], ' '))
> +				count +=3D sysfs_emit_at(buf, count, "\"%s\" ", labels[i]);
> +			else
> +				count +=3D sysfs_emit_at(buf, count, "%s ", labels[i]);
>  		}
>  	}
> =20
> --=20
> 2.46.0
>=20
>=20

--flnicamozbzuup7v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmbpMecACgkQ2O7X88g7
+pqSaQ/9HtRZmguxIZa7J/vf4ESiDYkCg6IhLcMAo9Xrtlv8zbqqhRLO+I2K1OuH
7kwI8DKfFDHBrWhurN4D5wS8OlkRTrjQYd0lLi7/IjUYp/BDk0Cxe4HBoqSuZXyI
ddSidBL3ovOZYuD8RqnNo9VuICz3eScn9kTF9HSy/Duya/+LFOmq+tpTCO7Durj4
FnIfNTBlCwm9BohCs4YbVmmA2uHIOTDXoSifV5QK28P8LpDu0gSTm0QkpyRSGOu6
jriVuNQRog1c+bpPw5HENHmMS36rXRqNwNENYC4ty5Lalez9UGJZbFx1/Cgf2W4Y
akI5EfInwXkNthxZWK3oIM05IX4EoyqQ7kFFETLT8n42jCmJv5Yf1e3+laCS3fIT
OBgycye84PrAZiVx7rUA3VUwWQ1HBgejTTvruwIdvQeya6211f6t267CwWouLS9k
KyzEMHPifzBzXIkZHtn56Yw/mL/HfhCMHxqUfc53kLSbqrmF1je8qu0zPSnLc3Ts
u4AFZi4Mw2tlImb8B+YcmrgndEfWGXQo4ZfPNhlqWUAN7G+o4vr9/kIkPKyWLTab
1+D9npYW8L8VtDzjouME1NneUgM6lhe1jebjYwvyPnoyG9bR4Su3lBgmky7M+q3q
BvVNfKkV2wlz1hLvzxViDpEfb1jGVWp1W4zw3M3qaBZMMJ9FzI4=
=M+k1
-----END PGP SIGNATURE-----

--flnicamozbzuup7v--

