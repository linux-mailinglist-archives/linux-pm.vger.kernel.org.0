Return-Path: <linux-pm+bounces-22524-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16421A3CE14
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 01:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C874189B113
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 00:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE04C1BF58;
	Thu, 20 Feb 2025 00:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="AQrG9NKo"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABB21805E;
	Thu, 20 Feb 2025 00:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740011307; cv=pass; b=NVMInxXF//Grjc6u9tjX1c0nxgwJNZjqMKs9pWC97R1ji84h4BPOVRTbUheYzC0zox70eZjpZ1c3KZVxSeu1kNq1yGRN/o/12DWC5aDPQpKCHYYcVrkaSScYmGgaBdXqn/XPuM4/4buz1uYcWGW02T8/SDmhHCBnbMaJWneGUWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740011307; c=relaxed/simple;
	bh=nbf2v6AGLqe3sDaXNkYTeZUxdwUeX4DQLJdykyqTGwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H6hndixljcqPlYSztbx8BUZ0QiHa2qTpQpCjdcts3BdxrWbEYop9eKftr6mn04xK5pO6SSnneuDsx7UQFCFtMDYXjYfRKhgFkOIkr84XijbSYHPQS6NJ8PpvxvFskHQBqLy7pxU+0+k9LhJN2ZyM18Joal5tjTyjGepoo5Y7908=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=AQrG9NKo; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1740011287; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nVmhw67RIhlVPD0U6iUgTDL+EAOOogJ4irI3NoYVYLClU6YIUS2RfqmURgDXwMxmYRKqR2Nk7J3JBY6ixM3qPBnkIl4RrvldWv9U3Mc4m51NEmCkdpgJKyFMUlMRFZG1RSgx0LODCj3YGChUwpFtsKSpPU5HEsTgChG6R84pp/Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740011287; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=tAz9mG1QzuvEf2OdpS0A1Mmv42BVI91Fqs66KZi4GbM=; 
	b=H3oEARUuGeRkGUgRS5dzetOKYF9GjV8GgFJdr+uWi0PkMveZZ/0Fbk/0QHvT6g9RxxYLsDQgRVBZcQDlnaRZi5V6nngQ3c/E0VpGhg0fxIrUa8g+5qChf+E7wGbLJlyNBUTyDS5GT9zRaBdaftw0IXFOFUViGb1fpEppCNkxjVI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740011287;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=tAz9mG1QzuvEf2OdpS0A1Mmv42BVI91Fqs66KZi4GbM=;
	b=AQrG9NKoXgF86aaBiE+9MzKBsqDDIXC2ziT2xgcTmjQT+Z9jwMC+YKQjGhhgAm4/
	xG7Cd3Y6C+MM2N1mzqVz1BmVwySI0ITIUXcWGCi1WaLE9tILNBYLO/BOQWK1YvkXEw7
	MSkDls/MFKXy95Kv7oDB4iOyInr34iBt7XHd+05I=
Received: by mx.zohomail.com with SMTPS id 1740011285906551.8635618898012;
	Wed, 19 Feb 2025 16:28:05 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id 6CCBA180608; Thu, 20 Feb 2025 01:28:00 +0100 (CET)
Date: Thu, 20 Feb 2025 01:28:00 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Dzmitry Sankouski <dsankouski@gmail.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Pavel Machek <pavel@ucw.cz>, Hans de Goede <hdegoede@redhat.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
	Purism Kernel Team <kernel@puri.sm>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v17 1/7] dt-bindings: power: supply: add maxim,max77705
 charger
Message-ID: <dsrokndf2gknamheatwslbx7d6nd6sk2g2hyggj4ee7pfu7nr4@emyeig3baryc>
References: <20250123-starqltechn_integration_upstream-v17-0-8b06685b6612@gmail.com>
 <20250123-starqltechn_integration_upstream-v17-1-8b06685b6612@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3nnsvdjlfrs3g5ul"
Content-Disposition: inline
In-Reply-To: <20250123-starqltechn_integration_upstream-v17-1-8b06685b6612@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.3.1/239.999.45
X-ZohoMailClient: External


--3nnsvdjlfrs3g5ul
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v17 1/7] dt-bindings: power: supply: add maxim,max77705
 charger
MIME-Version: 1.0

Hi,

On Thu, Jan 23, 2025 at 06:04:26PM +0300, Dzmitry Sankouski wrote:
> Add maxim,max77705 charger binding.
>=20
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

> ---
> Changes in v14:
> - fix required children nodes order: reverse reg and compatible
> - add reviewed trailers
> ---
>  Documentation/devicetree/bindings/power/supply/maxim,max77705.yaml | 50 =
++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max7770=
5.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max77705.yaml
> new file mode 100644
> index 000000000000..bce7fabbd9d3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/maxim,max77705.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/supply/maxim,max77705.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim MAX777705 charger
> +
> +maintainers:
> +  - Dzmitry Sankouski <dsankouski@gmail.com>
> +
> +description: |
> +  This is a device tree bindings for charger found in Maxim MAX77705 chi=
p.
> +
> +allOf:
> +  - $ref: power-supply.yaml#
> +
> +properties:
> +  compatible:
> +    const: maxim,max77705-charger
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - monitored-battery
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c {
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +
> +        charger@69 {
> +            compatible =3D "maxim,max77705-charger";
> +            reg =3D <0x69>;
> +            monitored-battery =3D <&battery>;
> +            interrupt-parent =3D <&pm8998_gpios>;
> +            interrupts =3D <11 IRQ_TYPE_LEVEL_LOW>;
> +        };
> +    };
>=20
> --=20
> 2.39.5
>=20

--3nnsvdjlfrs3g5ul
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAme2dwYACgkQ2O7X88g7
+pqwXw//VLCEgYBR5TpFRR5uS6nRwuRyYJsQYJvSCT0DkF8PdL1JUvIc0LA7iao5
slEskVoovRBUzx3HHyS+YAR2X4D3iwdgR/XVntfoUrqaIlti578Kbz6whhNwj2kh
ZcU0l95pwFAmlO6ESzPrlnjaiXMmvOKh97wi4W9Hd56Jq6yedxuXmLk9SLhV9o3L
0vPs1m32R7Y3ifpA0Z/YVLZ2zkvGu06SfoQCy0UMibFR3N61jyqtfH40OJ5xJxah
fHyYm1MArhBM96FU8sSYlzLj5hW9qC3OyHA7fico01GAVGunKQPG3EaIFU+CaQfI
4c4ocixlCO7yxBGR3pqHGxcGT0b/9jwp1cwel0PUTLfJz2bBCv8mSbi5SOk/L+94
5fpOC22yOgOl7ZDJTtIX6chEg98y0qT8TBHB91zDOkTaPRL+jxZk41gnQrma59eT
sx3qL6vPysqm2ff9YrJDoWiOZ87aTG/wU7YAl/ZDzIaRJQNjE2EEuaB3LGnDUVPm
WWIC5hbHAy4GIuQ7GmKPTsQW/IflA+btAZ1Ooffe4OyKEqPPTun+rvnRRmuaqB+9
VTeQfr6sQs6lHQlin1KNqlmikU4pc90/At93BZG15eQ6ptftbNCU+Zo+1o9BDyfd
k7kHKZwx6siqO1mCbhYe7iXH3G/hMeGR0hTr0Pl/i4IDNb26oJI=
=dZFk
-----END PGP SIGNATURE-----

--3nnsvdjlfrs3g5ul--

