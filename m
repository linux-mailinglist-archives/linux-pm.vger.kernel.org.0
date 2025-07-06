Return-Path: <linux-pm+bounces-30227-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BF8AFA852
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 01:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFF1816500A
	for <lists+linux-pm@lfdr.de>; Sun,  6 Jul 2025 23:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBC522CBE9;
	Sun,  6 Jul 2025 23:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="CTboGPtV"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7F71F8744;
	Sun,  6 Jul 2025 23:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751843593; cv=pass; b=FTR3IxVSy7sHQPFWlvTOShrnGJEQGDSZwx2ew1supmjhx9Q643Y9WwQh9cb3s6UbjhI2yvQdbSFiYyrI1nwAhpWbceywhrooNnHfNqdOPIL/28+bLFJ9ig/+mP0ikUCN7Q203K2tkIzf4rEczLKaCDCM7QGrmETxXaaEf3m6zM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751843593; c=relaxed/simple;
	bh=jZ4NjSj5QAxy616fyR+poFC75GZTLq2UiaMkw5XElPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X0ZNwzy8nijdnt25hpee+7TpvPQia8G8Y7SjUtsvex+CobNdbOv872WsHF+eV6t5mkC/7Pxlej2tPYEjnBNluCOkyEaiRLfZvnyOKoSZPnfYjVs2BqCmFNUVibjH6iCoioIDOV8Tj3mQuWqxieyrmKJjJC40fjc9TX9YnlMFezI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=CTboGPtV; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1751843585; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=D0Sh8zIOxvbibMTQxpCE4kLX+gmKzddi3lMmRS2GQZXdcNdBpZPtW90hWTV/7nD3jep5E6s23SPzGEmWVKM9wV7JXN0cpugW5h7fG5+tTkNzrS91tGZH1ihVNcDsBu8stuDjX2MqT5dIC1T4XTIpPCen7inuv8MW8o3QTiEHYlU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1751843585; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=t2xBmkRRQY+pjqOE2yj+R2cgHlbEKytd5ouOLlp3ZdQ=; 
	b=eRzg/RDMtYsjPqU5FymvbdHbI5XQnJW4rR+dtu8Ie0wM0/SQgX4+F7NJeKLYK8RxpnJWSiJmPkSkkIGNiPvGuytZl7zOG3vHPy3qw/UhNvlqObAgfzbJdyfg13TZlSJEBYU1FIFSRsON0njjsRsC4+P9OAi2eXuUphHoS4l752Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1751843585;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=t2xBmkRRQY+pjqOE2yj+R2cgHlbEKytd5ouOLlp3ZdQ=;
	b=CTboGPtVvvY90sc3SXOmxlL1AR7qUQMZ36c8wCXFxDlImKOtPns9KvJkYws0ctnG
	UwoN1EmrGt/qySvxzcV98ataE3qpnT7xs7NgNGawDeRnaMph49ooadA92yEOZ36eb6d
	GqcznA1yal2ifA1Yi4SagCnMC8jS582Crq+iHL60=
Received: by mx.zohomail.com with SMTPS id 1751843584199910.8305353313995;
	Sun, 6 Jul 2025 16:13:04 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 4BAD5180F17; Mon, 07 Jul 2025 01:13:01 +0200 (CEST)
Date: Mon, 7 Jul 2025 01:13:01 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Armin Wolf <W_Armin@gmx.de>
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, 
	linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] power: supply: test-power: Test access to extended
 power supply
Message-ID: <44bjrq3o4mq76a7awcl3wx2gqlyxjgtse4h37kgtgz764lwang@nsmo3xvljznx>
References: <20250627205124.250433-1-W_Armin@gmx.de>
 <20250627205124.250433-2-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pgocskjyr4hczd7t"
Content-Disposition: inline
In-Reply-To: <20250627205124.250433-2-W_Armin@gmx.de>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.3/251.827.75
X-ZohoMailClient: External


--pgocskjyr4hczd7t
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/3] power: supply: test-power: Test access to extended
 power supply
MIME-Version: 1.0

Hi,

On Fri, Jun 27, 2025 at 10:51:23PM +0200, Armin Wolf wrote:
> Test that power supply extensions can access properties of their
> power supply using power_supply_get_property_direct(). This both
> ensures that the functionality works and serves as an example for
> future driver developers.
>=20
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/power/supply/test_power.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/power/supply/test_power.c b/drivers/power/supply/tes=
t_power.c
> index 5bfdfcf6013b..2c0e9ad820c0 100644
> --- a/drivers/power/supply/test_power.c
> +++ b/drivers/power/supply/test_power.c
> @@ -259,6 +259,7 @@ static const struct power_supply_config test_power_co=
nfigs[] =3D {
>  static int test_power_battery_extmanufacture_year =3D 1234;
>  static int test_power_battery_exttemp_max =3D 1000;
>  static const enum power_supply_property test_power_battery_extprops[] =
=3D {
> +	POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW,
>  	POWER_SUPPLY_PROP_MANUFACTURE_YEAR,
>  	POWER_SUPPLY_PROP_TEMP_MAX,
>  };
> @@ -270,6 +271,9 @@ static int test_power_battery_extget_property(struct =
power_supply *psy,
>  					      union power_supply_propval *val)
>  {
>  	switch (psp) {
> +	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW:
> +		return power_supply_get_property_direct(psy, POWER_SUPPLY_PROP_TIME_TO=
_EMPTY_AVG,
> +							val);
>  	case POWER_SUPPLY_PROP_MANUFACTURE_YEAR:
>  		val->intval =3D test_power_battery_extmanufacture_year;
>  		break;
> --=20
> 2.39.5
>=20
>=20

--pgocskjyr4hczd7t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmhrAvwACgkQ2O7X88g7
+poILQ//XijUN+A1aSweBuUC8nVz/kwj9Ghczw4nAOnTL+XBT5ancuJ6LByqzj35
lGMsot9aPR2GHM5CemXh9GNLPcswZc/SQ4HGWD8u+jFKYCNIVC6Bxy4sjFZ9dHPJ
DDlWsqBb+hp6qh6T1MFXfmBcjQ/z1K5rWNJoVfFfF/Ir+NLoxZyO1nMw1wMPHURV
4XQX/nG8mkyhm0/zKLGyUd/h9q66NY01dOQPUqRUPKBFVpCmp+Oy1VWXjX2kCSPK
oupM+0IN0FHjOXeGV0uCnIKI5jHmVfd9iAOWRS6VJo9DhNc3Uk3jCOKLD2MfXORU
j9wGTUEA6gLw603OOKKGXn0u+fQN2u4WaeFdPxEHmp3KlATcF0p7c4Y53LO6R9LV
RH3xZCuFFn9vu3ZCNEqgdD1ZYs4BRVieEWct4PH2IHYKyKG6aTDB5f6Bt1S2FDrH
c1PLKfJNerh5H+CWt3r+cfGccpAEwD7r0REaNOH6KoP8Ktth7/ZDKML3+bpoz6F7
tJOEe3qS/b3XaBia+61ZXV28rgEOQ7LhaNMI0E4Uzk7YAeDz+mUR0A/dYAl7LTVr
HDl19MqHeGaNAjk2dOJ5z9dfAjMc+w4vjsISsEibufnhyynDdNA6wfYY7hHrf1Lq
8QynlI0f2YD+XfoXmOreG7+vS2Wk98mQO0btuith5vvH77Um0uw=
=AczC
-----END PGP SIGNATURE-----

--pgocskjyr4hczd7t--

