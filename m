Return-Path: <linux-pm+bounces-22520-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 271D9A3CD68
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 00:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E44CB1789AD
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 23:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE63F25D52A;
	Wed, 19 Feb 2025 23:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="NZEoqjak"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CF81D7E30;
	Wed, 19 Feb 2025 23:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740007453; cv=pass; b=N877DPJqCYS4l2xrDQ20cHmVorMIRRrBQjgyfMREjZNVHg7TIG1NL4dP90VsGJzLkHcekdnNb9D4bFNAwfo9aNaN8bozM0a2MBMyKEVv3AjFoq+mhOq/ef3/SI5OOFp5OFCiWV+NwD1MRjriu6YzK1KQPERLW7aqhf+alimAzx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740007453; c=relaxed/simple;
	bh=iVjPFfmMvCeylRVGLAvFsqbcK47XIUjd5EdimDo32Pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LqrQDPUe2P2C413ZzmG9358KYvnMFDWnMPkC5nOVGmUj65jfj0lof4uz0EYdlN1koTrSt+zGj7W8FIgSfdcw2AwINA+5ziBmsJHbTFV9mTik1A+3GWyncXMN7OwfOg7cP9sJt/pdORs5TkNIqZyWoJKDUZfsDet7jEtyUWi8oUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=NZEoqjak; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1740007434; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ntIdjd5G+nT0caWqZLJfK7UdJjXZ79w5vGrXasLyzQjMoUWzXSfR3A7f+i4kewivOrYP9MgaCrHQGXPv7jJz+4YO64sBEPk1JB0qxeXYAECORzT8PgWyUEANGRurNh5kriv+O4xsRyRWsCu+WGqyY9ghtJgVHI1KHmuTDt+fDow=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740007434; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Mg8u9/g/tX35NdeyqR0gelmPIJgyVdAF0d+NmKLp1wA=; 
	b=iUt8QdW9X5/5m2lYqiFrUNiMdzwfUmkP7gPwInz1z5mW8jceb9JMz6T4PFnP31q5Jg3SuL6DfwmNIhoY8byveW6quk5Xxa230IpMBzKRgMox0hUm2qsrOHnfRdlI7dxfUp11++zAl2Yy/6rNTk6lM0CoOX8AUFmomng+9nXAtV0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740007434;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=Mg8u9/g/tX35NdeyqR0gelmPIJgyVdAF0d+NmKLp1wA=;
	b=NZEoqjakq83VKus/IHSuUcJs10FVwCW4uCiQJEeuwdqHn1fiTtunRyEWuGiL1hPG
	YgSGp890rkT++LfF84lX+HPcrP/gZGvsaznJrOg78CsUFXpTnZ3yH44D+D12n4nu3OU
	SbjNKfmtJJTNyv2DnaBwhEbWdP+nIj2gSwDW2AKw=
Received: by mx.zohomail.com with SMTPS id 1740007431497183.98442498438135;
	Wed, 19 Feb 2025 15:23:51 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id D0C2718093B; Thu, 20 Feb 2025 00:23:46 +0100 (CET)
Date: Thu, 20 Feb 2025 00:23:46 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-sunxi@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org, lee@kernel.org, samuel@sholland.org, jernej.skrabec@gmail.com, 
	wens@csie.org, conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org, 
	Chris Morgan <macromorgan@hotmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH V2 1/4] dt-bindings: power: supply: axp20x-battery: Add
  x-powers,no-thermistor
Message-ID: <hpxd73ci6xnkbis3rucc2pfladhrvlz3gjmca5cwwclcaklb7g@im7frp6tvv3e>
References: <20250204155835.161973-1-macroalpha82@gmail.com>
 <20250204155835.161973-2-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rlx4tsecwsn6vlez"
Content-Disposition: inline
In-Reply-To: <20250204155835.161973-2-macroalpha82@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.2/239.939.29
X-ZohoMailClient: External


--rlx4tsecwsn6vlez
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH V2 1/4] dt-bindings: power: supply: axp20x-battery: Add
  x-powers,no-thermistor
MIME-Version: 1.0

Hi,

On Tue, Feb 04, 2025 at 09:58:31AM -0600, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
>=20
> Add the vendor specific boolean property of x-powers,no-thermistor.
> This property optionally describes hardware where no thermistor is
> present on the battery and is specific to the AXP717. In rare
> circumstances this value can be set incorrectly in the efuse of the
> PMIC, and if it is not hard-coded the device will fail to charge.
>=20
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  .../x-powers,axp20x-battery-power-supply.yaml | 20 ++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/x-powers,axp2=
0x-battery-power-supply.yaml b/Documentation/devicetree/bindings/power/supp=
ly/x-powers,axp20x-battery-power-supply.yaml
> index 5ccd375eb294..3504c76a01d8 100644
> --- a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-batt=
ery-power-supply.yaml
> +++ b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-batt=
ery-power-supply.yaml
> @@ -14,9 +14,6 @@ maintainers:
>    - Chen-Yu Tsai <wens@csie.org>
>    - Sebastian Reichel <sre@kernel.org>
> =20
> -allOf:
> -  - $ref: power-supply.yaml#
> -
>  properties:
>    compatible:
>      oneOf:
> @@ -35,7 +32,24 @@ properties:
>        this gauge.
>      $ref: /schemas/types.yaml#/definitions/phandle
> =20
> +  x-powers,no-thermistor:
> +    type: boolean
> +    description: Indicates that no thermistor is connected to the TS pin
> +
>  required:
>    - compatible
> =20
> +allOf:
> +  - $ref: power-supply.yaml#
> +  - if:
> +      not:
> +        properties:
> +          compatible:
> +            contains:
> +              enum:
> +                - x-powers,axp717-battery-power-supply
> +    then:
> +      properties:
> +        x-powers,no-thermistor: false
> +
>  additionalProperties: false
> --=20
> 2.43.0
>=20
>=20

--rlx4tsecwsn6vlez
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAme2Z/cACgkQ2O7X88g7
+pqCng//fcfJcJ4vyTD7Jp0AD5KPo9l3is4rMqbdjM0EPx92eLmmwM6rPjdGPIoL
F/Cy2C7xSAN9YoTxBP4Ih2WAQM6F0qapCIZMqJKRb6Ecp1tm7UnXHDYQrtOSxC/0
w1xGeBBxzLiDZ65ZEzbrtmJN3x5Z2zlTnmqJc089kwAUoqpJjcQTQWf+JJOSeeK3
c9Vw0wRUb/GZ/saNG52O/hWgZaL0IRiyoezoX6oHq8WeqljXcXN3gpaVASUy8xsJ
FtROi8S/aQEfrvYyMEq4YGTWulo2c1Onar7HX3/O+pT20HPP4KQGdhVallFVENrS
genlJA6BCmTN41HGAIDOi6S4/MTAQtzhT0cQN6O6jAnliKjCSctF9aGefvCrUlyJ
wFOBuuf61Pn1JbokSs2OP9W35XPZ2TRrnxg9OJYC+BsZkMWFEz37dlDCHMmRvnA/
ScU9P/47ezRDeC/p9pWvwspVbCL15bQ6Ib/g1uvh2haYwPd8xuOkZavPqfM3Bql7
MF0R7+KGhrOmNf4zruA4acnNBgndsucWOrpDRU1FInKsOArn4MDde7/TFf4txV4I
1qWzlAld3P4CZ7WlTdQcf06UfTiUDPdExQt2M5Gi3cajexhd7gWbev3MbKEnCGxc
AfiXDCBCnmRnFMeMjqZ0c7IFHVpbuhEX87l4Q0WL4FmPRs3FqlI=
=DaL6
-----END PGP SIGNATURE-----

--rlx4tsecwsn6vlez--

