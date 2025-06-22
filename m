Return-Path: <linux-pm+bounces-29219-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 224AEAE2DD0
	for <lists+linux-pm@lfdr.de>; Sun, 22 Jun 2025 03:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FEB7172C38
	for <lists+linux-pm@lfdr.de>; Sun, 22 Jun 2025 01:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B91772615;
	Sun, 22 Jun 2025 01:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="VFI/kT8L"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455DF2581;
	Sun, 22 Jun 2025 01:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750555629; cv=pass; b=nngl/8Puoo3GZafzOEFhKMhl2asd4V1JZ4nJtl7sMLP3j0RSbdT1fYk51pFrrOiU0UsGRw4l5gENHetuS5yV6wwwmxtdslEM88hfBECF9A7MjJcgexyx0dGMbAhIr0j8wxxe/RnYXW4c2TfxHqRNoYnH/jAetcbA7Maprx2tigQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750555629; c=relaxed/simple;
	bh=D0UPu1HNdTRNwid4W5kqZ802BggmR9+6yj1qcBOgkEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DS7EzMzOISaqrV+MNP3Ax+r9DeTaMIs6OPBYnlgIQIP32SCzPJ3LyZIl/3lQHygrOxiVMHl0O+H6g5aJbwCrBYomo9dVsEs6KHbJy8ImJfJMsiOurA+ZTr1LNsjbeH6AiPNH3j/BfSrM9QD9BYDRCVB38y3PppPhguZNoi/Dx3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=VFI/kT8L; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1750555617; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=RBJdQL/GN8H1veCJwnJYZhSuSxiU5BtZeTkGn+2uZTfIzwQ/gIvDl1SslquWPR3FC6kGFTszHCE9PFaXYmWBQPFr4F5riQrlinoeNEzaDMxVRri84bR8a/HFHWI6WRiKZF1MJx7rF0tI9k0hhAX1kNl36QSxtTkj1VgHVhdBZNM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1750555617; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=gQIUsgIGn42vlwD+axbELwPL5aL0OuQaX/33hU+2LEQ=; 
	b=SI9jsbjC9++rbY849bJYx3LU+zalp6Hv7etzjgH9DI5WE+m0O0KdOPuSevaDoRs62MVkWwQYKEp0pM2wAsygbgLvo9gEnp53Uz4r6wHcpaTge+eJL8zwBM0ZM0vnIGWZnEYn8xb/gbHsG8IR8GIxgoV0qLnH2BWAQAhGnhawh58=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1750555617;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=gQIUsgIGn42vlwD+axbELwPL5aL0OuQaX/33hU+2LEQ=;
	b=VFI/kT8LjLT2u+mdk5MbO3eRgskaZOuVmWN9OkpN9eVuXjim+QNc8JG4kFsVmpXO
	/jG2z294vQDc70VukhWK1pTflsyQmQ1V//QJHGsLQ4F2lEFKAXsEcqUqM8Pdu4YCZko
	ImVFPRSxGEvPCSVWa9bVb/G3PchH/mv2o9xYHCds=
Received: by mx.zohomail.com with SMTPS id 1750555615992395.33436908947795;
	Sat, 21 Jun 2025 18:26:55 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id E9303180692; Sun, 22 Jun 2025 03:26:50 +0200 (CEST)
Date: Sun, 22 Jun 2025 03:26:50 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: fenglin.wu@oss.qualcomm.com
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>, David Collins <david.collins@oss.qualcomm.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	kernel@oss.qualcomm.com, devicetree@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 1/8] power: supply: core: Add resistance power supply
 property
Message-ID: <b7m55sjc2rtvtelvez6sxnjvdostvxmfjhhsr4uxhyhh4bxrcd@xmioz2bsgis2>
References: <20250530-qcom_battmgr_update-v2-0-9e377193a656@oss.qualcomm.com>
 <20250530-qcom_battmgr_update-v2-1-9e377193a656@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ucvcx4vh7elpfixl"
Content-Disposition: inline
In-Reply-To: <20250530-qcom_battmgr_update-v2-1-9e377193a656@oss.qualcomm.com>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.3/250.540.22
X-ZohoMailClient: External


--ucvcx4vh7elpfixl
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 1/8] power: supply: core: Add resistance power supply
 property
MIME-Version: 1.0

Hi,

On Fri, May 30, 2025 at 03:35:06PM +0800, Fenglin Wu via B4 Relay wrote:
> From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
>=20
> Some battery drivers provide the ability to export resistance as a
> parameter. Add resistance power supply property for that purpose.

This is missing some information and the naming is bad.

Which resistance (I suppose battery internal resistance)?

That is heavily dependent on the battery temperature. So this needs
to document if this is for the current temperature or for some
specific one.

-- Sebastian

> Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
> ---
>  Documentation/ABI/testing/sysfs-class-power | 10 ++++++++++
>  drivers/power/supply/power_supply_sysfs.c   |  1 +
>  include/linux/power_supply.h                |  1 +
>  3 files changed, 12 insertions(+)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/=
ABI/testing/sysfs-class-power
> index 560124cc31770cde03bcdbbba0d85a5bd78b15a0..22a565a6a1c509461b8c483e1=
2975295765121d6 100644
> --- a/Documentation/ABI/testing/sysfs-class-power
> +++ b/Documentation/ABI/testing/sysfs-class-power
> @@ -552,6 +552,16 @@ Description:
>  			Integer > 0: representing full cycles
>  			Integer =3D 0: cycle_count info is not available
> =20
> +What:		/sys/class/power_supply/<supply_name>/resistance
> +Date:		May 2025
> +Contact:	linux-arm-msm@vger.kernel.org
> +Description:
> +		Reports the resistance of the battery power supply.
> +
> +		Access: Read
> +
> +		Valid values: Represented in microohms
> +
>  **USB Properties**
> =20
>  What:		/sys/class/power_supply/<supply_name>/input_current_limit
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/su=
pply/power_supply_sysfs.c
> index a438f7983d4f6a832e9d479184c7c35453e1757c..dd829148eb6fda5dcd7eab53f=
c70f99081763714 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -220,6 +220,7 @@ static struct power_supply_attr power_supply_attrs[] =
__ro_after_init =3D {
>  	POWER_SUPPLY_ATTR(MANUFACTURE_YEAR),
>  	POWER_SUPPLY_ATTR(MANUFACTURE_MONTH),
>  	POWER_SUPPLY_ATTR(MANUFACTURE_DAY),
> +	POWER_SUPPLY_ATTR(RESISTANCE),
>  	/* Properties of type `const char *' */
>  	POWER_SUPPLY_ATTR(MODEL_NAME),
>  	POWER_SUPPLY_ATTR(MANUFACTURER),
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index c4cb854971f53a244ba7742a15ce7a5515da6199..de3e88810e322546470b21258=
913abc7707c86a7 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -174,6 +174,7 @@ enum power_supply_property {
>  	POWER_SUPPLY_PROP_MANUFACTURE_YEAR,
>  	POWER_SUPPLY_PROP_MANUFACTURE_MONTH,
>  	POWER_SUPPLY_PROP_MANUFACTURE_DAY,
> +	POWER_SUPPLY_PROP_RESISTANCE,
>  	/* Properties of type `const char *' */
>  	POWER_SUPPLY_PROP_MODEL_NAME,
>  	POWER_SUPPLY_PROP_MANUFACTURER,
>=20
> --=20
> 2.34.1
>=20
>=20

--ucvcx4vh7elpfixl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmhXW9oACgkQ2O7X88g7
+prIkg//VtGhxAwUOJRpgVT7zHHrczHnFqP2fQHOqxnfV3iO6rQqf9gNloR4lPIL
e03Rm3ye13Mq7bBQxVT9dEUh5qPLJGGeHz+gyaNGMdOqXcA2a9wlMpwpW7OG/L1Z
tq9ku5MA/NCdp5AjcFo0OdYPzm+Cy7byM9W4dFb3CJcwJds3uDMG5zrgiJPQ2ksI
myIzRLHNr1tk8kProac4dmeatdeM226sRJ9RbGuQ8mz33++F0ztycPTVoYwMMdD7
DhT7O/KFjyxfoHqT/j8RFK3RYcF6cHMF2UH8pd9eBjEn60W6555Z1te55Ubgoh4N
M0PzpIBv3qlKIJknVAUHD3ib/6qGpZZ0fJdruLPTa3kgSaWqyQlPl1MP6MdRubtA
3nXL0GcsSF4PNh1XOcMwVAeWfmUACWWQgjCjul1bam/rLLUJSPJTBLAZ3Ig9RGfS
LumDXFMx3lhy5//ISZKxPOVif1cQmux23YITkqyMJCR6/ogqs1vHQzfA3hAmPLRR
UuIvEW/lIVrze93msOPXqKF0LCw4RYBl+qeebyOzl+qJVO8h1w6QpoTSNB58BCYm
gg/nHCb6FFlOGvc3D4YGAT4zDjs6/zKw4/LDgHGEtONbjhDLpFvFzYeTnfJJgMrE
MsqAjVdQUM80LqBYoT4FP1AEZ2xkwr+QuYAMYCq6eAtaGCpqNCg=
=xaOD
-----END PGP SIGNATURE-----

--ucvcx4vh7elpfixl--

