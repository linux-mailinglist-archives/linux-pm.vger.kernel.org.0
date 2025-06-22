Return-Path: <linux-pm+bounces-29227-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9033EAE3157
	for <lists+linux-pm@lfdr.de>; Sun, 22 Jun 2025 20:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 101537A20CD
	for <lists+linux-pm@lfdr.de>; Sun, 22 Jun 2025 18:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AF71F3BBB;
	Sun, 22 Jun 2025 18:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="EdsCG3DA"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100FF1E485;
	Sun, 22 Jun 2025 18:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750616920; cv=pass; b=JwyBGBzmb3yJ24iNGK1Q55FDR2gjnKqvI6eyebPqFOQk4aE2Ctycwwwj6oL42B+divu2uhHcnwRfSpaeNNEOGg5Zkm7tXX9LkJZdoueNvoEAjgRqPcaSiN8m0Y3nUgnawmGh+UBw3c/Xr94sleUF1MOE7HAlUkOBL5rZGIrijtE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750616920; c=relaxed/simple;
	bh=IVAVlita6boleZEKUhomUXcQJqFjKltBqVXiNpA5MZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HcQWlZEkS3gj/KBgjWOMVf+zfzil0wIslNIWTgujnOdsH1A0/43Umdow7bfl34rYiWzvouU2rttg3r4Rb22CYAaHjzBjnFN7Fc5jr52D/12Es/vFZH4jE+e4h3nDK6VDqRSj9Y8caOatpUKoBb6BMwseqacZ/y+SUTnT7oEt3fY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=EdsCG3DA; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1750616909; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=W4rLbKE6ieDPddQO9QcLPMRmN1h5QWdVYfim2QjTPQVU2qgRJ4hL9cE+4C+HEfkrSjWUtdHMpxiZPvUkl+z+M3tc4YqWKc+5DnstLUtH9wh5tfEgUvCsI8etlHWMGV8bLICtED1EuR3Lep/z6HtNckmHBb3PUZiBVucyIFPzTt0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1750616909; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=V04dt+KAyB6LqxTY9VwDx+bR62B93/B5qtEy0zoMOGo=; 
	b=mk1bkPTWnLA1/QKQNIJ7YT74wcaSUyKZhYgy/skqWIarxwn57DfodbswkroGbRdEjoxGmG6EUSDqfGZzJgAhSuaSZOmCUK6OGPTDyz47fNJOTogziBhoa/p2GEyfbHCn21LVqnldXgqlW7wBxtAEOsduQt04M+fNJDTCrLpyDg0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1750616909;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=V04dt+KAyB6LqxTY9VwDx+bR62B93/B5qtEy0zoMOGo=;
	b=EdsCG3DAtTxa8aNaJTTCbtmAXd3vO+SEqJyjeP5km21qh2OQTn/t+nTIrM6Yj+iJ
	JSat40NrBeHD+7+UALqM6js9r++be7SVKXEOECeAcsI8bV6iaihCEt92iC+gXgbH0od
	buDJJikdN3oz2t09CPDx7wO+MZ06lK6Zf/VJetLw=
Received: by mx.zohomail.com with SMTPS id 1750616907711893.5961968072164;
	Sun, 22 Jun 2025 11:28:27 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 12774180957; Sun, 22 Jun 2025 20:28:23 +0200 (CEST)
Date: Sun, 22 Jun 2025 20:28:22 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 06/11] power: supply: qcom_smbx: respect battery
 charge-term-current-microamp
Message-ID: <6vcr6kvd5ryh3fj4j27hkl7742f4ooy4sns77pcudgox3glqyc@dz4on64p4tif>
References: <20250619-smb2-smb5-support-v1-0-ac5dec51b6e1@linaro.org>
 <20250619-smb2-smb5-support-v1-6-ac5dec51b6e1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uim6l7as6sa5ckne"
Content-Disposition: inline
In-Reply-To: <20250619-smb2-smb5-support-v1-6-ac5dec51b6e1@linaro.org>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.3/250.601.42
X-ZohoMailClient: External


--uim6l7as6sa5ckne
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 06/11] power: supply: qcom_smbx: respect battery
 charge-term-current-microamp
MIME-Version: 1.0

Hi,

On Thu, Jun 19, 2025 at 04:55:14PM +0200, Casey Connolly wrote:
> Respect the max current limit set on the battery node, one some devices
> this is set conservatively to avoid overheating since they only have a
> single charger IC (instead of two in parallel).
>=20
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
>  drivers/power/supply/qcom_smbx.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/qcom_smbx.c b/drivers/power/supply/qcom=
_smbx.c
> index fc2a8e20435639a9da4d966c43271beaeb57a03f..7fc232fa7260a7422ac12a486=
86cd7d396edd9a4 100644
> --- a/drivers/power/supply/qcom_smbx.c
> +++ b/drivers/power/supply/qcom_smbx.c
> @@ -583,9 +583,9 @@ static void smb_status_change_work(struct work_struct=
 *work)
>  	case POWER_SUPPLY_USB_TYPE_CDP:
>  		current_ua =3D CDP_CURRENT_UA;
>  		break;
>  	case POWER_SUPPLY_USB_TYPE_DCP:
> -		current_ua =3D DCP_CURRENT_UA;
> +		current_ua =3D chip->batt_info->constant_charge_current_max_ua;

"constant_charge_current_max_ua" is current information for the
battery. But current_ua is written to chip->base + USBIN_CURRENT_LIMIT_CFG,
which sounds like it would be current limit on the USB side?

Assuming the charger is using a buck converter to get from USB
voltage to battery voltage (very likely) the currents are
different.

Greetings,

-- Sebastian

--uim6l7as6sa5ckne
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmhYS0MACgkQ2O7X88g7
+poJ5RAAlJm8M2KbvbPK0Jp7ixlFsjOIdtNmwg6exfKP4ntZZXiT+z2yxRwOmjcs
U76XIhZZ52RWIo07i1RW3p8kAHJBYct3vHllSIFEsLO2BuKiQ0ck/dTxPdnFe78F
P4w8sPDcUAbYCqYAKpNgyBrvOV5mXRZjrcjsY09EM0WcbODK3zREQHTTxrLDHbmG
UrZiAjLR0CxE4LgChgYD3ttY6vZaQn/HI37qT7F8tUHdsJXC/x7Ts+T3qLpW+RMB
NOBZWV0jWuCrdDKD+uc5gRxriVh2qSDzbPgo+kq48aM5LLB5JYcB2DsdOofNaSad
vLIeOsfrRzUFF+OdfzpH8crt4XgutGA3kVYX7tJBkSPceoLc96yS+0wTJ0m2JGGe
Wuz5EvBrZv4t1MqrFUuS79QRN+xN0fi8jJhjqxIER9z6Jo7MUfTFH9+qW7bt32Uf
kWokCxvjH3KCqSQCLfBwEQ3enpn88g/2TM1WH5PV//KNx/XJF3xOOa40DFgm0/F4
dF+3emuIFKo5cmA/bC2nA7O+FTZvIJHNj5XfNiRKne9Sd7Y3lCbzkP0m/FL7hIlj
hVi7cEdewCC/IHJErzLgpJCF7Y5mmkgg3lQm5EixhZT4TduSWa8KAUEPEZxI+qal
JCPOGzNaLLnFy5Lj2NkwgP+CKMpIZWZutXoOd7IwDEuVqS1Ysf8=
=vj9o
-----END PGP SIGNATURE-----

--uim6l7as6sa5ckne--

