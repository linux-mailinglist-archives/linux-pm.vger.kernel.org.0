Return-Path: <linux-pm+bounces-42709-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PRTDVlck2ny3wEAu9opvQ
	(envelope-from <linux-pm+bounces-42709-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 16 Feb 2026 19:05:13 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3295146DDA
	for <lists+linux-pm@lfdr.de>; Mon, 16 Feb 2026 19:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B6D4C302BA6B
	for <lists+linux-pm@lfdr.de>; Mon, 16 Feb 2026 18:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8A92405EC;
	Mon, 16 Feb 2026 18:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fj7gg04T"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F1C3C2D;
	Mon, 16 Feb 2026 18:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771265089; cv=none; b=sspjmW07nQIUVYtv/6nSxEDK6MhRM+RYhu8H6+jfFRfA/jMaKMIk9Vc8PFkJbc5CGKEgkzedswykofG6TlqT+YY6ZhgJ9Hl+gZ83oyZuvqGlxO8M+ZXl3RYMLWfknyLAW6j2WPolFwQZEykKi5nOa/HTGujb2lFX4ubGyu1YrmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771265089; c=relaxed/simple;
	bh=7ezZiP8gi/HZsP61qt7oVXA2/9j3Qq37ztrS8gZuDz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rtlDYdf1883LBgEjve/grfw88OJvxT7ehSt34lEPdcYnBiINqlK3FN7qYtuqmTonDXCzNI5Q+IjZG4ofDCoSn/bQwChUpKVXZ5FS0lk0tGOHMkhM1oq5ouNy0PZjzr+x4gfNUTxO/TrZK+44llV0i7TPiJLN+IGVMuXSE2xmdeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fj7gg04T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62F13C116C6;
	Mon, 16 Feb 2026 18:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771265089;
	bh=7ezZiP8gi/HZsP61qt7oVXA2/9j3Qq37ztrS8gZuDz8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fj7gg04T8DMJDv3HOU8UwgqhEgdONA7pEWEehQoBuxgy9mPRc6RHGuo/3n55R1FrJ
	 BEKppW18fUeJo8bpxqoJGRHPiOVhIa1QfXElyRbfjQTR6jmx1rT8Vi83iCEn6fKU8j
	 as4jjWfjszl2Vyp73rx/wY1DMTsCAvCh0pnSq5AJY/AUG/05SiymMsPi2MftyH/VIC
	 99MMSNuvjpGBqmdEez5P5uvjEHqkG3cbUsunCkW/h2QVV2dgPGBh9bWzg7JczZ1I10
	 EvRMAmdt1scY3U9uNUTPh1A/B+3rLngFA0YCA/OWU4sYPolAic2TjhrrD7ocA6tMY5
	 ZhXVcDlJ+X1Yg==
Date: Mon, 16 Feb 2026 18:04:44 +0000
From: Conor Dooley <conor@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, Ion Agorria <ion@agorria.com>,
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 1/7] dt-bindings: embedded-controller: document ASUS
 Transformer EC
Message-ID: <20260216-sprung-scallop-de7b64bf528c@spud>
References: <20260214180959.30714-1-clamor95@gmail.com>
 <20260214180959.30714-2-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6jTl6NQx2jQST4GB"
Content-Disposition: inline
In-Reply-To: <20260214180959.30714-2-clamor95@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42709-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	DBL_PROHIBIT(0.00)[0.0.0.19:email];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,linux-pm@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,agorria.com,rere.qmqm.pl,vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,devicetree.org:url]
X-Rspamd-Queue-Id: D3295146DDA
X-Rspamd-Action: no action


--6jTl6NQx2jQST4GB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 14, 2026 at 08:09:53PM +0200, Svyatoslav Ryhel wrote:
> Document embedded controller used in ASUS Transformer device series.
>=20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../asus,transformer-ec.yaml                  | 98 +++++++++++++++++++
>  1 file changed, 98 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/embedded-controller=
/asus,transformer-ec.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/embedded-controller/asus,t=
ransformer-ec.yaml b/Documentation/devicetree/bindings/embedded-controller/=
asus,transformer-ec.yaml
> new file mode 100644
> index 000000000000..670c4c2d339d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/embedded-controller/asus,transfor=
mer-ec.yaml
> @@ -0,0 +1,98 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/embedded-controller/asus,transformer-=
ec.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ASUS Transformer's Embedded Controller
> +
> +description:
> +  Several Nuvoton based Embedded Controllers attached to an I2C bus,
> +  running a custom ASUS firmware, specific to the ASUS Transformer
> +  device series.
> +
> +maintainers:
> +  - Svyatoslav Ryhel <clamor95@gmail.com>
> +
> +allOf:
> +  - $ref: /schemas/power/supply/power-supply.yaml
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - asus,p1801-t-ec-pad
> +          - asus,sl101-ec-dock
> +          - asus,tf600t-ec-pad
> +          - asus,tf701t-ec-pad
> +
> +      - items:
> +          - enum:
> +              - asus,tf101-ec-dock
> +              - asus,tf101g-ec-dock
> +              - asus,tf201-ec-dock
> +              - asus,tf300t-ec-dock
> +              - asus,tf300tg-ec-dock
> +              - asus,tf300tl-ec-dock
> +              - asus,tf700t-ec-dock
> +          - const: asus,transformer-ec-dock
> +
> +      - items:
> +          - enum:
> +              - asus,tf201-ec-pad
> +              - asus,tf300t-ec-pad
> +              - asus,tf300tg-ec-pad
> +              - asus,tf300tl-ec-pad
> +              - asus,tf700t-ec-pad
> +          - const: asus,transformer-ec-pad

Can you explain somewhere here what the "dock" and "pad" devices are and
how they differ? For example, I am currently wondering why tf700t has both
"dock" and "pad".
Also, why are some of the compatibles permitted standalone? That should
be mentioned in your commit message too. Also, other than the sl101, the
standalone ones seem to have the same match data in the mfd driver. Why
are fallbacks not made use of there?

Since this transformer series seems to have multiple programming models
for "ec-pad" devices, it calls into question your use of the generic
fallback compatibles is appropriate and makes it seem like you should be
using device compatibles as a fallback.

The rest looks okay other than the filename, which doesn't match any of
the compatibles that you've got here.

Cheers,
Conor.

> +
> +  reg:
> +    description:
> +      The ASUS Transformer EC has a main I2C address and an associated
> +      DockRAM device, which provides power-related functions for the
> +      embedded controller. Both addresses are required for operation.
> +    minItems: 2
> +
> +  reg-names:
> +    items:
> +      - const: ec
> +      - const: dockram
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  request-gpios:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - interrupts
> +  - request-gpios
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c {
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +
> +      embedded-controller@19 {
> +        compatible =3D "asus,tf201-ec-dock", "asus,transformer-ec-dock";
> +        reg =3D <0x19>, <0x1b>;
> +        reg-names =3D "ec", "dockram";
> +
> +        interrupt-parent =3D <&gpio>;
> +        interrupts =3D <151 IRQ_TYPE_LEVEL_LOW>;
> +
> +        request-gpios =3D <&gpio 134 GPIO_ACTIVE_LOW>;
> +
> +        monitored-battery =3D <&dock_battery>;
> +      };
> +    };
> +...
> --=20
> 2.51.0
>=20

--6jTl6NQx2jQST4GB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaZNcPAAKCRB4tDGHoIJi
0vFtAP4828QgM/PVYTODENJre1Jf4Is/DuewBrQgQmLkEFtzGgD/bXp9LgZlzVyY
QtKJA3izVbKb48cwprpk2gHJyI2r7wE=
=FkGi
-----END PGP SIGNATURE-----

--6jTl6NQx2jQST4GB--

