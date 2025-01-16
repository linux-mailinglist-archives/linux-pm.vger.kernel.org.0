Return-Path: <linux-pm+bounces-20518-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFABA12FFC
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 01:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA9D93A42B4
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 00:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834562B9BB;
	Thu, 16 Jan 2025 00:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="WjfeVLMu"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658CA41C72
	for <linux-pm@vger.kernel.org>; Thu, 16 Jan 2025 00:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736987416; cv=pass; b=gg4DZxICS2G22OHwuoW/exgcltC+Erah7Rxr1whrlF/hqhm9WAKHdAvN0QApMu9v0HPsQ2EjfWLlR/x5VJqgrIrzjdV0ad+OByok2TWJD0eESeUsqyKlUlnGHC6q1YRGlyqrPNaT7EL4ileFfBF3NH6QoWv6luglkbZpqMSX4bg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736987416; c=relaxed/simple;
	bh=LZVzjdQZweOIDKg3DUXJ36u2VhsLUWRCKTfrty6ODqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gSJ9kTW8n7+VL5LzdNOKaTFspf3NNzw1AUu0kFCPcqzSZGamileKSu1tjQi/lJLLT3opALFqwGKJ+5K7zk94gmMLbTfRWoQb//N3VVgJOMy2q9OPVyY39wHODToIWUsP2TNdhOCwc2UuRNqMma5EZ5pEsSrdpitoni54NIk+ltM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=WjfeVLMu; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1736987397; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=dm8fjg2wuSccSCruIc3iusbXgrPRIatY5jjytR4GHYYGUHjptMUpXaS8g51Nt+hc3zsb9wHQogzPhvy9Hi4rUQlfhvLL1+TX9eEU6dGEApavc2Ii8Gm6H1xSHpdfZPcC76sl4PcyVFQx23Hx7iGOCUTHxiWhpVQr4Tl19Rynhsw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1736987397; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=u+cSodQLkxsNo6AJqcREnHc9Afa7Xccg5v/GqcdNIf0=; 
	b=k9wbhAFTLSrq1TO9Qidojchv/HlUCC+Th61AC5CLPdIm9lJkymEcPN6idSV7gTWEA6rKRhY29Ojp7fUKomp4kElh5+aNpy0zn9xS/zJw7szYnljTtAJpE7okRmxbpagVcMpmhMVSyesIh9QaITcg/bj3Fdbl1qnyq2XDRjtdUFE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1736987397;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=u+cSodQLkxsNo6AJqcREnHc9Afa7Xccg5v/GqcdNIf0=;
	b=WjfeVLMu72YlDRmC46hgCJnUpXvSQbZ8fuULY9WqOWZ07VxITSFZpFpogJz5Jq6P
	EMYclNwKl78GmyMbKF46M+nfCrCDDk84YWIszh3/GaQ4da0v2eGyTL1pR3pYR1pt2Mm
	+SYTUlACBUilCOgrn4iuC0NWByE3+0Rz+xqrqLv8=
Received: by mx.zohomail.com with SMTPS id 1736987394813959.7832556978211;
	Wed, 15 Jan 2025 16:29:54 -0800 (PST)
Received: by mercury (Postfix, from userid 1000)
	id 77D081060350; Thu, 16 Jan 2025 01:29:51 +0100 (CET)
Date: Thu, 16 Jan 2025 01:29:51 +0100
From: "sre@kernel.org" <sebastian.reichel@collabora.com>
To: shichunyong <shichunyong@honor.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	yuanzhen 00013066 <richard.yuan@honor.com>, yangyunmeng 00013317 <yangyunmeng@honor.com>, 
	gongxi 00013624 <gongxi4@honor.com>, yuxuesong 00013800 <xuesong.yu@honor.com>
Subject: Re: [PATCH] power: supply: sysfs: Add
 manufacturing_date,first_usage_date
Message-ID: <aq3jrzpadwu3xbly2zzcmzj5bhfjobju4fgsbz2wzmrvk3wuoj@oxokheooqmhz>
References: <ed82ec55afed40448c70831f1991f6c1@honor.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2b2m7gmqmlbx3pao"
Content-Disposition: inline
In-Reply-To: <ed82ec55afed40448c70831f1991f6c1@honor.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.3.1/232.189.87
X-ZohoMailClient: External


--2b2m7gmqmlbx3pao
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] power: supply: sysfs: Add
 manufacturing_date,first_usage_date
MIME-Version: 1.0

Hi,

On Fri, Jan 10, 2025 at 11:12:09AM +0000, shichunyong wrote:
> Please help to review, thanks.

1. Don't top post, see Documentation/process/submitting-patches.rst
and Documentation/process/2.Process.rst.

2. The manufacturing date is already exposable via MANUFACTURE_YEAR +
MANUFACTURE_MONTH + MANUFACTURE_DAY properties. It's even visible in
the patch context. There is no need for a new property, just use the
existing ABI.

3. You did not update Documentation/ABI/testing/sysfs-class-power,
which is required for any property added to the power-supply class

4. You are missing a user. If you want to add new power-supply
properties you need to either update an existing driver, so that
it makes use of the new properties, or submit a new driver using
them.

Greetings,

-- Sebastian

> -----Original Message-----
> From: shichunyong 00013399=20
> Sent: 2024-12-19 17:52
> To: 'sre@kernel.org' <sre@kernel.org>
> Cc: 'linux-pm@vger.kernel.org' <linux-pm@vger.kernel.org>; yuanzhen 00013=
066 <richard.yuan@honor.com>; yangyunmeng 00013317 <yangyunmeng@honor.com>;=
 gongxi 00013624 <gongxi4@honor.com>; yuxuesong 00013800 <xuesong.yu@honor.=
com>
> Subject: [PATCH] power: supply: sysfs: Add manufacturing_date,first_usage=
_date
>=20
> manufacturing_date/first_usage_date/state_of_health are the battery data
> required by EU regulations that are accessible for end-users.
>=20
> manufacturing_date is the date of manufacturing of the battery.
> first_usage_date is the date of first use of the battery
> after the set-up of the device by the first user.
> Both dates are the seconds since the epoch (1970-01-01 UTC).
> state_of_health(SoH) is a figure of merit of the condition of a battery,
> compared to its ideal conditions. The unit of SoH is percent
> (100% =3D the battery's conditions match the battery's specifications).
>=20
> Signed-off-by: ShiChunyong <shichunyong@honor.com>
> ---
>  drivers/power/supply/power_supply_sysfs.c | 3 +++
>  include/linux/power_supply.h              | 3 +++
>  2 files changed, 6 insertions(+)
>=20
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/su=
pply/power_supply_sysfs.c
> index 571de43fcca9..0550073224f2 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -217,6 +217,9 @@ static struct power_supply_attr power_supply_attrs[] =
__ro_after_init =3D {
>  	POWER_SUPPLY_ATTR(MANUFACTURE_YEAR),
>  	POWER_SUPPLY_ATTR(MANUFACTURE_MONTH),
>  	POWER_SUPPLY_ATTR(MANUFACTURE_DAY),
> +	POWER_SUPPLY_ATTR(MANUFACTURING_DATE),
> +	POWER_SUPPLY_ATTR(FIRST_USAGE_DATE),
> +	POWER_SUPPLY_ATTR(STATE_OF_HEALTH),
>  	/* Properties of type `const char *' */
>  	POWER_SUPPLY_ATTR(MODEL_NAME),
>  	POWER_SUPPLY_ATTR(MANUFACTURER),
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index b98106e1a90f..c8d8a8bfbf9f 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -170,6 +170,9 @@ enum power_supply_property {
>  	POWER_SUPPLY_PROP_MANUFACTURE_YEAR,
>  	POWER_SUPPLY_PROP_MANUFACTURE_MONTH,
>  	POWER_SUPPLY_PROP_MANUFACTURE_DAY,
> +	POWER_SUPPLY_PROP_MANUFACTURING_DATE,
> +	POWER_SUPPLY_PROP_FIRST_USAGE_DATE,
> +	POWER_SUPPLY_PROP_STATE_OF_HEALTH,
>  	/* Properties of type `const char *' */
>  	POWER_SUPPLY_PROP_MODEL_NAME,
>  	POWER_SUPPLY_PROP_MANUFACTURER,
> --=20
> 2.17.1
>=20

--2b2m7gmqmlbx3pao
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmeIUvUACgkQ2O7X88g7
+po5ThAApIr2xjxGSTtWlxxBfPaU+xW062VQO3+q9Kp2NXGewDDYZCZd9aXqPzNV
RQpPft5zoYVEL7OuZEFu4flT04n+z3RVPCUrhw2l2d5IGKNKbQFOtK/kbe5UK4Sf
Y8z0Nhpm1iM1bnGUE9Lbn4ziJbYOKx0rt8gpMF6qYMF1UJxONQyW+GIbRgRngp11
qEX5SSMRRpWhnGSod9ZdvECxjockH9wpZAzW6bVSgDyBnOGyuO5IB3+plUA1fVE3
zTJwSOed1M5bZ8dCvLLEukHdemwOz6kRuHaEbsxiFtxzWiwOVEGkUogim5ckQFKb
SxFtUPYxip1GjWva04uwo0w8uBCJKB1ScDFsnArtai+eLa5l4NOrrIvt070SLy9Y
j4F35v9qRnhn132/1+cA8677gIvMVMSIon911DZn0jBMhEC6XWBmhImdy0yS/iLP
ecEc3qgTK/FHGHqAe/t3z+/jhPCOamaDPpPcz22mbB8kHzgy95Q1sTG/STzxQ1GZ
OUDa+1lXQMXl94DJ+D3zkI1OFpP7zEbFl05MuY63x36/8pv+9cCxG6gFcqZ1x/Dk
aJzi0FGy+HzdlQo3LMxz+e3HT3aepx3tc6iKGizUiQdVH8nDHGLM8NmtFDzXT2bZ
8wEImQ+bNb2ylbkVkurLAKcd40BaVEloAY4Y/USrH/ecbxP4ctE=
=4jnO
-----END PGP SIGNATURE-----

--2b2m7gmqmlbx3pao--

