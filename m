Return-Path: <linux-pm+bounces-34756-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7CDB5A142
	for <lists+linux-pm@lfdr.de>; Tue, 16 Sep 2025 21:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 010C9524A0C
	for <lists+linux-pm@lfdr.de>; Tue, 16 Sep 2025 19:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B742DAFD2;
	Tue, 16 Sep 2025 19:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="VT3qMEzf"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EC321E098;
	Tue, 16 Sep 2025 19:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758050364; cv=pass; b=syoxRISKjmrC7RLSlkWT7jx3E7DH4Egaq1SvnVO8nQpBuJJAGnzbtO66Hx2TqO4FhWoNkhSO0X/Nt2D8dWhGkCFHqwhoNxq2WGgcprhrAsC3fDsduYj15WXe9GhE7D+6hoCp6KoKW+Gb7dPcjs4s2s2CLzDPBcu1eYQu5YUpZ0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758050364; c=relaxed/simple;
	bh=l2W5f1wjH+NU+wN5+BLNLhE7Zjola1cMNFKsxlO3Av4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GGZERtLmSR0G2qanDBguqP4x+0eS2zfrTcinqZ2oLZqf7HkNQyUnHWL4ohcrKR3Grngn4XqneSdJqZZiTAV1XM+Zh9tYXjwOMz+MsLolehVqKQwPXg/mqN8j9XBQkqdAXw51YGvNuF58OBjmbkdKIeF8kKZ/VROmmex+AqBwr/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=VT3qMEzf; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1758050337; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=EE/E4mBeNgVMc8CgxnaAYsuEngiFC/qBKjH/XEUsQHdzdHWhTfD0+OQVgCEj0Gu65CXuFiJAZpk5cWnk+5luHZuBZthypnISlq+ukGhyYwbQsQRrQ3HZAUgygJXQILLlswRdAKj/NOBjIAPwDBg8wx7PHo1o3vM49uc/UJWEV84=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758050337; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=M6YkaVAVR8lt6A5LvHddbSlxJ7ZMT9y1dxIlFzTD5mA=; 
	b=Xbyg8loUBpnfHjL+bZg7jm4V5I3KRDcNQ/+KZII8KrLbFWaLRPH0sG+lPBcQWVaZ8KNiFooD9T7pZYBnVIiOsJuahFp61yB8NrMzAjSewY/V8sNUAdtxqCsHjqRdUbKTxPWr1aqbFXZtWwykOjX2vqofUUBuMdqDa02OpwUr67A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758050337;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=M6YkaVAVR8lt6A5LvHddbSlxJ7ZMT9y1dxIlFzTD5mA=;
	b=VT3qMEzfyoYWJeqvMzN9nQAuZvKLmIWtPgg8zaj4QFZ+YDXnxWfYbBJrqIbj0BQ2
	PHLU/GFqJSsiu/OSeStDLitodnTIiveffJuG1Nvme+wODoceJPLT0mJubl0mQMXg1pc
	s4QZTPL+fXC1n8zMXSqsxOxWEjwhFqwxoIiwKFak=
Received: by mx.zohomail.com with SMTPS id 1758050334998606.6949339145506;
	Tue, 16 Sep 2025 12:18:54 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 26E81180733; Tue, 16 Sep 2025 21:18:40 +0200 (CEST)
Date: Tue, 16 Sep 2025 21:18:40 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: fenglin.wu@oss.qualcomm.com
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>, David Collins <david.collins@oss.qualcomm.com>, 
	=?utf-8?Q?Gy=C3=B6rgy?= Kurucz <me@kuruczgy.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, kernel@oss.qualcomm.com, devicetree@vger.kernel.org, 
	linux-usb@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 2/8] power: supply: core: Add state_of_health power
 supply property
Message-ID: <5nxoadknvk5wt5gniekfinhe42dm72kbluxcmsqsw57g2xpr2a@jgury7ds6bcb>
References: <20250915-qcom_battmgr_update-v4-0-6f6464a41afe@oss.qualcomm.com>
 <20250915-qcom_battmgr_update-v4-2-6f6464a41afe@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s45526ndzapes52i"
Content-Disposition: inline
In-Reply-To: <20250915-qcom_battmgr_update-v4-2-6f6464a41afe@oss.qualcomm.com>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.3/258.4.7
X-ZohoMailClient: External


--s45526ndzapes52i
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 2/8] power: supply: core: Add state_of_health power
 supply property
MIME-Version: 1.0

Hi,

On Mon, Sep 15, 2025 at 04:49:54PM +0800, Fenglin Wu via B4 Relay wrote:
> From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
>=20
> Add state_of_health power supply property to represent battery
> health percentage.
>=20
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on Thinkpad T14S =
OLED
> Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
> ---
>  Documentation/ABI/testing/sysfs-class-power | 15 +++++++++++++++
>  drivers/power/supply/power_supply_sysfs.c   |  1 +
>  include/linux/power_supply.h                |  1 +
>  3 files changed, 17 insertions(+)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/=
ABI/testing/sysfs-class-power
> index cea1a38f5a8fb754d4e6323967ef6cf2e20a68ce..04f82e3e33aad6e16dc4fbace=
066b5d26069bf44 100644
> --- a/Documentation/ABI/testing/sysfs-class-power
> +++ b/Documentation/ABI/testing/sysfs-class-power
> @@ -568,6 +568,21 @@ Description:
> =20
>  		Valid values: Represented in microohms
> =20
> +What:		/sys/class/power_supply/<supply_name>/state_of_health
> +Date:		August 2025
> +Contact:	linux-arm-msm@vger.kernel.org
> +Description:
> +		The state_of_health parameter quantifies the overall condition
> +		of a battery as a percentage, reflecting its ability to deliver
> +		rated performance relative to its original specifications. It is
> +		dynamically computed using a combination of learned capacity
> +		and impedance-based degradation indicators, both of which evolve
> +		over the battery's lifecycle.

I think this should be extended by the following:

Note that the exact algorithms are kept secret by most battery
vendors and the value from different battery vendors cannot be
compared with each other as there is no vendor-agnostic definition
of "performance". Also this usually cannot be used for any
calculations (i.e. this is not the factor between charge_full and
charge_full_design).

-- Sebastian

> +
> +		Access: Read
> +
> +		Valid values: 0 - 100 (percent)
> +
>  **USB Properties**
> =20
>  What:		/sys/class/power_supply/<supply_name>/input_current_limit
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/su=
pply/power_supply_sysfs.c
> index cfa8f90a88ebc8fc1c7447198f138e5d2e699e5a..d96a8578308e3af60cc1a3528=
45662aa922c29b3 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -221,6 +221,7 @@ static struct power_supply_attr power_supply_attrs[] =
__ro_after_init =3D {
>  	POWER_SUPPLY_ATTR(MANUFACTURE_MONTH),
>  	POWER_SUPPLY_ATTR(MANUFACTURE_DAY),
>  	POWER_SUPPLY_ATTR(INTERNAL_RESISTANCE),
> +	POWER_SUPPLY_ATTR(STATE_OF_HEALTH),
>  	/* Properties of type `const char *' */
>  	POWER_SUPPLY_ATTR(MODEL_NAME),
>  	POWER_SUPPLY_ATTR(MANUFACTURER),
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index 8bc3b7a67eb5693a16db9b7d123e7881711c6bf4..ccb43fe44381965069dc3bd95=
05d45050b9b1bd8 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -175,6 +175,7 @@ enum power_supply_property {
>  	POWER_SUPPLY_PROP_MANUFACTURE_MONTH,
>  	POWER_SUPPLY_PROP_MANUFACTURE_DAY,
>  	POWER_SUPPLY_PROP_INTERNAL_RESISTANCE,
> +	POWER_SUPPLY_PROP_STATE_OF_HEALTH,
>  	/* Properties of type `const char *' */
>  	POWER_SUPPLY_PROP_MODEL_NAME,
>  	POWER_SUPPLY_PROP_MANUFACTURER,
>=20
> --=20
> 2.34.1
>=20
>=20

--s45526ndzapes52i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmjJuAkACgkQ2O7X88g7
+pqSXA//UyXZ+wptD9xIabMfB9X1z8ivuchEpWRVY3ZHVs0mm59ceOTqnqXkXhe7
ZZn2aIYIEdjxQWUeGH0EQwKXlOkHqt3+KpxkkSTXR2oU1bGv+7/EQq3rbnR6vg3k
BZ9IKRuDfBnfVe7WdBrtirDDUaf803L1l+yQO/6GrafCOmtN6+IJFd/7t5UL5+4m
G08fJXOKz6M0GUBLd0jmyXe4LL14bMIFBq2QCvR3YiEvkoCDjttSQNIIn1rTV86L
5cBGgq5j7ndrHK0Sgtvvz45YXj4vyVYuKOOG8p5iU6GaZL45wEgkUqN7QSFrhXhf
dckEFILjtqfW3xCrqMIX5ddnx9WMXtB00tKoUucsJfCGoyxRs2NiJIIF5D9Vjp8o
LLCcd6LZWGVFJYYQ9B5ZAEbUE520pO5pqAb3lYJgvjcEsQbtpzslWGUN97ogAmMB
QWpUGew+Epw4wcfMEKK8gdBy24Pe7Y4f/OfYz7fwJwvfTvMU3JdOzDR3acSnPXT5
sHp+2vF2Ma+qoUzMF/g6zcWHLx7qLCe9JSrSly8Jz1Y3rKUwR3ulwjBa6EPwZrEK
ZtorpEQAl66hgJuRHSeV3xiR1CQEDVYuBmqBFeof0mo141b7tbkKwX2l4517uMHd
U/i5CMxN1X3MjDAKQU9IpMTJZRmobwu7kLuVuFnOSbqBBpLFT7Q=
=b/Yd
-----END PGP SIGNATURE-----

--s45526ndzapes52i--

