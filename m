Return-Path: <linux-pm+bounces-41495-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGorFlzJd2lOkwEAu9opvQ
	(envelope-from <linux-pm+bounces-41495-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jan 2026 21:06:52 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F7D8CDF3
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jan 2026 21:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06F613013A9D
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jan 2026 20:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A0E2BFC70;
	Mon, 26 Jan 2026 20:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FMn6U2jv"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D052882AA;
	Mon, 26 Jan 2026 20:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769458008; cv=none; b=nunaoaXRw9qabZplE6knJ4yhIjtlBPNMVPVfRMOgUYAblw8XXdUSR6IcjK7cv+Sox1xFJ9lhvwWLm6ZrDxOcse57VmaxTyOWlEzcMoIeVLXrGe1ktfDO1Q3r64y4cedzC+NP0MezPM6ZEIHwaoo7UsQ3emkY6bIAGAK9HrE8C4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769458008; c=relaxed/simple;
	bh=xiCb09/Lp+x3Rm8FtVL8vB9rPGDkllPWV05XFxT3PJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q2cfsI1BkWx2b7MtIQ6kp+lmaMnYQEFfGCNdc13D+JUFDn7nYSKHaofm1uJZqBI7jQgIX6HXH2zmbuzwKEPrEBXbgS/EL162eGc2+I6qvYL5QxI/QAqFWyehjkek38OuAtFn+hEY9DOFwZ/mPhCMIGFMqEWo8Y3nut/ts43w8ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FMn6U2jv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D326EC116C6;
	Mon, 26 Jan 2026 20:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769458007;
	bh=xiCb09/Lp+x3Rm8FtVL8vB9rPGDkllPWV05XFxT3PJ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FMn6U2jvIY+GIUSqLjNLFcA9at33CZc0EH0JoGSlb8rQeIEtf/Wfdb4Fp51GUqPWO
	 nVchVJi1SeXSrvAcE4doZ729KYrnAUjWAi0Dn9Y7jVGnYG1eBMUPnNqoA+HGSSSof5
	 3G+lHNZuoqnabAtqzy6wyqbzSmCMp5XO0vudyinNbUkjNq/QTP4g9Op7Xhgi8LZJUg
	 quHXlBwNIefDHisT7WSQvRxr6JAtG9O97Eb6JJA7m6trDiomKPBSgHFhWfwVU9E5eD
	 8LurxpkxCZYOX6qwZmhFN2reQkBvBu93PKPJ/KU+4i7nbi3WVdGE4DA3n5MsFuiPwp
	 p8VOomHbhMsSQ==
Date: Mon, 26 Jan 2026 20:06:43 +0000
From: Conor Dooley <conor@kernel.org>
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Yassine Oudjana <y.oudjana@protonmail.com>,
	Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: power: supply: document Samsung S2MU005
 battery fuel gauge
Message-ID: <20260126-goal-wasp-fa3f20d2a06a@spud>
References: <20260126-s2mu005-fuelgauge-v1-0-68a146ed0819@disroot.org>
 <20260126-s2mu005-fuelgauge-v1-1-68a146ed0819@disroot.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bHY26mlX+ts/oR0l"
Content-Disposition: inline
In-Reply-To: <20260126-s2mu005-fuelgauge-v1-1-68a146ed0819@disroot.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TAGGED_FROM(0.00)[bounces-41495-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[protonmail.com,kernel.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,3b:email,disroot.org:email,devicetree.org:url]
X-Rspamd-Queue-Id: A2F7D8CDF3
X-Rspamd-Action: no action


--bHY26mlX+ts/oR0l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 26, 2026 at 09:09:48PM +0530, Kaustabh Chakraborty wrote:
> Samsung S2MU005 is a PMIC device which has LED controllers, an MUIC and
> a battery charger. The battery charger is paired with an independent
> device connected via I2C which can be used to access various metrics of
> the battery. Document the device as a schema.
>=20
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> ---
>  .../power/supply/samsung,s2mu005-fuel-gauge.yaml   | 49 ++++++++++++++++=
++++++
>  1 file changed, 49 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/samsung,s2mu0=
05-fuel-gauge.yaml b/Documentation/devicetree/bindings/power/supply/samsung=
,s2mu005-fuel-gauge.yaml
> new file mode 100644
> index 0000000000000..5f945a5369dc8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/samsung,s2mu005-fuel=
-gauge.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/supply/samsung,s2mu005-fuel-gau=
ge.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Battery Fuel Gauge for Samsung S2M series PMICs
> +
> +maintainers:
> +  - Kaustabh Chakraborty <kauschluss@disroot.org>
> +
> +allOf:
> +  - $ref: power-supply.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - samsung,s2mu005-fuel-gauge
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
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
> +      fuelgauge@3b {

Should be "fuel-gauge" iirc (at least, that's what all the bindings do).
Seems fine to me though otherwise,
Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

> +        compatible =3D "samsung,s2mu005-fuel-gauge";
> +        reg =3D <0x3b>;
> +
> +        interrupt-parent =3D <&gpa0>;
> +        interrupts =3D <3 IRQ_TYPE_EDGE_BOTH>;
> +
> +        monitored-battery =3D <&battery>;
> +      };
> +    };
>=20
> --=20
> 2.52.0
>=20

--bHY26mlX+ts/oR0l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaXfJUwAKCRB4tDGHoIJi
0jrdAP0Qa6sBG5CobBHsxaU+LhlTaRDC8CJr8mdImz2ybyt3nQD/TTXLIOQ7oTfo
5STPs8wl4eWlzsQscAyqprqzR9pLrQg=
=Mtc4
-----END PGP SIGNATURE-----

--bHY26mlX+ts/oR0l--

