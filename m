Return-Path: <linux-pm+bounces-34690-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E54B583AB
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 19:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C97904C11A3
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 17:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1706423D7E3;
	Mon, 15 Sep 2025 17:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DyhZUOUz"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCB11917F0;
	Mon, 15 Sep 2025 17:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757957476; cv=none; b=MVLSBM/45eSPkKVJX/n47RMffpfBRv6yPPajvxWYS6Cx++Rx676LiET/Nqek/YjZkz/9QTaZ7Okq0zKkF9rYcvmO4UsYwbcoBwIRaCdayLuAwvlBmW7Z0AWywOZ4EUy6IFVxL1n4ii6HqVGQI48pWvoCTZmycfKKorxZTqUi46I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757957476; c=relaxed/simple;
	bh=22K4wg/U7hxV+5smlo1jNvFUEqXuzp4zR5U2MMNEi6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PC6tz+n4Rx7LXpDLzpn3vwuxNZpqGKn5+SGRGYVltvWl2/TM2jOwl5OPx27zJ4nJLhhtee5z+LYQ481Pzkk5SmtmmR+VsrwEWb7z6ohow47wRIGlrXJ6yH1PlNV37cSA/+3Zt1fuF7Nagv4BJyFTA2Jj0kPZhisU1ljlOvJcIY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DyhZUOUz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B080C4CEF1;
	Mon, 15 Sep 2025 17:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757957475;
	bh=22K4wg/U7hxV+5smlo1jNvFUEqXuzp4zR5U2MMNEi6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DyhZUOUz0RoTHn9hALgJ0yqXK+epIoCkIZ5xLx6jL+qhLLec4IvfcnarJm3UMvq6n
	 VJyhZz86PussaYNngPeRx9hcuA8NBmizJXqLFO71pb9ZvJwph8bG8ClRCiETvE4FAE
	 8y1k7F4iEPx2T7lkXxheV6Cz9S90B6wz+XNuZnlNuww+5+FZ7Kt1bj/BO6TFJms14B
	 1ejxCtDzsoON4+7jzADsPhy/lDm9PiLGv+qQ4uk4A3HIltJu2sMboA7E5m9fZR3nId
	 obrveM1PZLE6VgUMAYdha0FIH3FDwicvLUEHVrAAd6Q/Otk2yd6Mq60JX4ToU13nt0
	 KB77uPFK65bvg==
Date: Mon, 15 Sep 2025 18:31:11 +0100
From: Conor Dooley <conor@kernel.org>
To: t.antoine@uclouvain.be
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	=?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v6 2/2] dt-bindings: power: supply: add support for
 MAX77759 fuel gauge
Message-ID: <20250915-presoak-answering-2df6fca532ad@spud>
References: <20250915-b4-gs101_max77759_fg-v6-0-31d08581500f@uclouvain.be>
 <20250915-b4-gs101_max77759_fg-v6-2-31d08581500f@uclouvain.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="V7ywmi7UEdonQGBv"
Content-Disposition: inline
In-Reply-To: <20250915-b4-gs101_max77759_fg-v6-2-31d08581500f@uclouvain.be>


--V7ywmi7UEdonQGBv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 12:14:11PM +0200, Thomas Antoine via B4 Relay wrote:
> From: Thomas Antoine <t.antoine@uclouvain.be>
>=20
> The Maxim MAX77759 is a companion PMIC for USB Type-C. It contains
> Battery Charger, Fuel Gauge, temperature sensors, USB Type-C Port
> Controller (TCPC), NVMEM, and additional GPIO interfaces
>=20
> Use max77759-fg compatible to avoid conflict with drivers for other
> functions.
>=20
> The battery node is used to pass the REPCAP and ICHGTERM values
> needed for the initialization of the fuel gauge.
>=20
> The nvmem cells are used to get initialization values and to backup
> the learning and the number of cycles. It should work out of the box
> with gs101-oriole and gs101-raven which were previously running
> Android.
>=20
> Signed-off-by: Thomas Antoine <t.antoine@uclouvain.be>
> ---
>  .../bindings/power/supply/maxim,max77759.yaml      | 78 ++++++++++++++++=
++++++
>  1 file changed, 78 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max7775=
9.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max77759.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..4d45739fcaf26273ec57b6004=
9d6d0421df38efb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/maxim,max77759.yaml
> @@ -0,0 +1,78 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/supply/maxim,max77759.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim Integrated MAX77759 fuel gauge
> +
> +maintainers:
> +  - Thomas Antoine <t.antoine@uclouvain.be>
> +
> +allOf:
> +  - $ref: power-supply.yaml#
> +
> +properties:
> +  compatible:
> +    const: maxim,max77759-fg

Compatible doesn't match the filename, why?
I assume the "fg" is fuel-gauge, but can this device be anything else?

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  shunt-resistor-micro-ohms:
> +    description: The value of the current sense resistor in microohms.
> +
> +  monitored-battery:
> +    description: |
> +      The fuel gauge needs the following battery properties:
> +      - charge-full-design-microamp-hours
> +      - charge-term-current-microamp
> +
> +  nvmem-cells:
> +    maxItems: 1
> +    description: |
> +      Saved fuel gauge state. This state will be used during the initial=
ization
> +      and saved on exit. It must be initialized beforehand.
> +      Its layout must be composed of
> +        - RCOMP0 (characterization of the open-circuit voltage)
> +        - TCOMPO (temperature compensation information)
> +        - FULLCAPREP (reported full capacity)
> +        - QRTABLE00, QRTABLE10, QRTABLE20, QRTABLE30 (cell capacity info=
rmation)
> +        - cv_mixcap (remaining capacity of the cell without empty compen=
sation)
> +        - cv_halftime (time-to-full characterization time constant)
> +      They must all be aligned on 2 bytes. A valid CRC8 checksum must
> +      also be found at the end (polynomial x^8 + x^2 + x + 1).
> +
> +  nvmem-cell-names:
> +    const: fg_state
> +
> +required:
> +  - compatible
> +  - reg
> +  - shunt-resistor-micro-ohms
> +  - monitored-battery
> +  - nvmem-cells
> +  - nvmem-cell-names
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +
> +      fuel-gauge@36 {
> +        compatible =3D "maxim,max77759-fg";
> +        reg =3D <0x36>;
> +        interrupts-extended =3D <&gpa9 3 IRQ_TYPE_LEVEL_LOW>;
> +        shunt-resistor-micro-ohms =3D <5000>;
> +        monitored-battery =3D <&battery>;
> +        nvmem-cells =3D <&fg_state>;
> +        nvmem-cell-names =3D "fg_state";
> +      };
> +    };
>=20
> --=20
> 2.51.0
>=20
>=20

--V7ywmi7UEdonQGBv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaMhNXwAKCRB4tDGHoIJi
0sRgAQCjqqflLyAGWFrRi9i49mBqc64Q5aJTvzf5BXIZ2PChjwEAkPVtsA7uquCk
/BXHf9Qn5OBUhgIJRrEJx+MnTRQsIQ4=
=gunl
-----END PGP SIGNATURE-----

--V7ywmi7UEdonQGBv--

