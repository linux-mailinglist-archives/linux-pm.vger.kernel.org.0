Return-Path: <linux-pm+bounces-29410-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 847E4AE552E
	for <lists+linux-pm@lfdr.de>; Tue, 24 Jun 2025 00:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D245B177E34
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 22:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0DD223DEE;
	Mon, 23 Jun 2025 22:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="G9hXsTzR"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42CC7080E;
	Mon, 23 Jun 2025 22:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750716504; cv=pass; b=r19VpoOHjotOf3Z1NlTwRHIbQ+oFOoOCymUbZDxp9Aqy6+UbmBtxifLFAdl9axfLNATmgmeSoPY+sV9dyin03zT000h1sx1eZofkN0YrBDi9i5Zlgcsu8OOgKifz+ajVA8ybtZMZ7hj1Ayp6/i5staRffSbMd+fyXJMWHpW089c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750716504; c=relaxed/simple;
	bh=JDPs4eXH1GKDynFvyfnMIazD78wsvR6WqglIGDUk0RI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G+WP2QojV/0OXelSQ5HmUvHHYCiT3EP+jE4BTy2fIZSmZhH1EgNfw9O84bJdcmf5EXgz942cYaqeR/9glLP92rEdQaexaSRahHOeELReguM+8p8LrpMFi9i4x3Sf4D4qk6r5V1Wz0mtxCR/Zjz2h/BzrEXMZIyFVNm8dInoQrRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=G9hXsTzR; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1750716490; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=YRbDsl6UDTgqiLNXD6FOOYF7QMs4k1Fof/h54LtAlOcWESaMYSLv0M/F82t7uYA6QpZoMMnYJE/YgZfr8vMlH9Vd+wgChJw+EJMJzdusBj8xRYHKg207idBBvxWLdgYinzO655PU+7j83auyS5gYrga4zrqbMtySkmH4zV2kD18=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1750716490; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=/BXgpXwhzYtQIWwdqXLgsVk4WStiLAj0XHlChIgBw3M=; 
	b=XL21455Ail7tSBw/eAf7lhtRyw5tOHGFGHcePKq5uYirNsaKLY9L765rFqUF+lsrA4ea/BOgcT3kLz1nL1+zCs6UeBQ1g7Tm65Cnl/DLKnyEjUfJ1gt+an8UNE5c5LtsCzDjAZeO4Awg/m0/Ct5b0PqLZZDmfpXWlszGAVOf4MQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1750716490;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=/BXgpXwhzYtQIWwdqXLgsVk4WStiLAj0XHlChIgBw3M=;
	b=G9hXsTzREqibMweZdE0PXJ/yFt539DBxTgFgiU0D1+YLJudVvNqIYpZXOKMfyPVL
	2uPPmYL9u5lSzxm3ulNwoQ94vtD1/KZ/SLp76EHW3JwHJCm5a+IvSzg6zRmQqc6jO4q
	JsvsIvix4nJrXwQ5fb+AN4ZOnLLmpTY628e+Jarc=
Received: by mx.zohomail.com with SMTPS id 1750716488768202.2640415999;
	Mon, 23 Jun 2025 15:08:08 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 0B36B180AAB; Tue, 24 Jun 2025 00:08:04 +0200 (CEST)
Date: Tue, 24 Jun 2025 00:08:03 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Amit Sunil Dhamne <amitsd@google.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Badhri Jagan Sridharan <badhri@google.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@kernel.org>, Kyle Tso <kyletso@google.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/5] dt-bindings: connector: extend ports property to
 model power connections
Message-ID: <z2wrzts6cgunxs5tc764izvrfi4i2d637zpt6tj5f4piry6j66@cke2yxhih6dg>
References: <20250507-batt_ops-v2-0-8d06130bffe6@google.com>
 <20250507-batt_ops-v2-1-8d06130bffe6@google.com>
 <20250514194249.GA2881453-robh@kernel.org>
 <b4a22161-8cab-4d76-a4b0-4bfd0d79cdc1@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="boxpunqqsxkyyd4w"
Content-Disposition: inline
In-Reply-To: <b4a22161-8cab-4d76-a4b0-4bfd0d79cdc1@google.com>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.3/250.696.82
X-ZohoMailClient: External


--boxpunqqsxkyyd4w
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 1/5] dt-bindings: connector: extend ports property to
 model power connections
MIME-Version: 1.0

Hi,

On Tue, May 20, 2025 at 01:10:25PM -0700, Amit Sunil Dhamne wrote:
> Hi Rob,
>=20
> Thanks for your response!
>=20
> On 5/14/25 12:42 PM, Rob Herring wrote:
> > On Wed, May 07, 2025 at 06:00:22PM -0700, Amit Sunil Dhamne wrote:
> >> Extend ports property to model power lines going between connector to
> >> charger or battery/batteries. As an example, connector VBUS can supply
> >> power in & out of the battery for a DRP.
> >>
> >> Additionally, add ports property to maxim,max33359 controller example.
> >>
> >> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
> >> ---
> >>  .../bindings/connector/usb-connector.yaml          | 20 +++++++++++--=
----
> >>  .../devicetree/bindings/usb/maxim,max33359.yaml    | 25 +++++++++++++=
+++++++++
> >>  2 files changed, 38 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/connector/usb-connector=
=2Eyaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> >> index 11e40d225b9f3a0d0aeea7bf764f1c00a719d615..706094f890026d324e6ece=
8b0c1e831d04d51eb7 100644
> >> --- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
> >> +++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> >> @@ -181,16 +181,16 @@ properties:
> >> =20
> >>    port:
> >>      $ref: /schemas/graph.yaml#/properties/port
> >> -    description: OF graph bindings modeling a data bus to the connect=
or, e.g.
> >> -      there is a single High Speed (HS) port present in this connecto=
r. If there
> >> -      is more than one bus (several port, with 'reg' property), they =
can be grouped
> >> -      under 'ports'.
> >> +    description: OF graph binding to model a logical connection betwe=
en a device
> >> +      and connector. This connection may represent a data bus or powe=
r line. For
> >> +      e.g. a High Speed (HS) data port present in this connector or V=
BUS line.
> >> +      If there is more than one connection (several port, with 'reg' =
property),
> >> +      they can be grouped under 'ports'.
> > 'port' and 'port@0' are equivalent. So you can't be changing its=20
> > definition.
>=20
> Noted!
>=20
>=20
> > I'm not sure showing a power connection with the graph is the right=20
> > approach.
>=20
> I want to provide some more context and rationale behind using this desig=
n.
>=20
> From a hardware perspective:
>=20
> The max77759/max33359 IC has Type-C port controller, charger, fuel gauge
> (FG) ICs. The Vbus from the connector goes to/from the TCPC and connects
> with the charger IP via circuitry & from there on to the battery. The FG
> is connected to the battery in parallel. As it can be seen that while
> these IPs are interconnected, there's no direct connection of the fuel
> gauge & the connector.
>=20
> For this feature, I am interested in getting the reference to the FG. As
> per graph description: "...These common bindings do not contain any
> information about the direction or type of the connections, they just
> map their existence." This works for my case because I just want the
> connector to be aware of the Fuel gauge device without imposing a
> specific directionality in terms of power supplier/supplied. This is
> also the reason why I didn't use
> "/schemas/power/supply/power-supply.yaml#power-supplies" binding.
>=20
> > We have a binding for that already with the regulator binding.
>=20
> I haven't explored the option of using regulator bindings. But in my
> case I am interested in fuel gauge and unfortunately, they're modeled as
> power_supply devices.

=46rom hardware point of view there is no direct connection at all
between the fuel gauge and the connector. The usual hardware
connection is

connector -> charger -> battery

With the charger potentially supporting reverse operation to provide
energy from the battery to the connector (with "battery" I assume
a "smart" battery, so the raw cells and some kind of fuel gauge).

Thus the following example should properly document the hardware
connections:

---------------------------------------
typec-connector {
    /* ... */
};

charger {
    /* ... */
    power-supplies =3D <&connector>;
};

fuel-gauge {
    /* ... */
    power-supplies =3D <&charger>;
};
---------------------------------------

It means instead of the direct graph lookup for the fuel gauge,
you would need a function walking through the graph build by the
power-supplies phandles. But it also means that the DT properly
describes the hardware instead of adding random graph connections.

Greetings,

-- Sebastian

> > Perhaps the connector needs to be a supply. It's already using that=20
> > binding in the supplying power to the connector case.
>=20
> Want to clarify, in this case you mean
> /schemas/regulator/regulator.yaml#*-supply$ right?
>=20
> Adding to my response above, the reason I don't want to impose a
> directionality in terms of supplier/supplied is that in case of USB Dual
> Role Port they're dynamic i.e., when USB is source, the power is
> supplied out of the battery (battery/FG will be supplier) and in case
> USB is sink, battery is supplied power. Whether the connector port is in
> source or sink role is determined on a connection to connection basis.
> Also, the knowledge of the supply direction is of no consequence for
> this feature.
>=20
>=20
> Please let me know what you think.
>=20
> Thanks,
>=20
> Amit
>=20
>=20
> > Rob
>=20

--boxpunqqsxkyyd4w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmhZ0EAACgkQ2O7X88g7
+pomEA//YVUVu98W2c34fvdaBGPXhG5LICkMydDQzHm/ycXUSLBKZdQwKFMoVYrs
GLUUn8a5VFSCBLfcUSUTN889escHyOEwjNVZlQhGhAuwaq3AVlXPR2QchgPm/JXw
kE9zcBKbzGk9KMPs/MdlGxF4gHJG2RULAQSYo3i6HgVCIKkPIoUYDMbTLOMBedWu
9kNCd6JQ0w8y/aWEfE17rwkr5wO8/tEurfBri/5NTOYSHvEZOEddKlIwNis/SZR7
BMYx8aV1cdIo+90sdyvGZdB6LQ1MbV8eI3xDOtp/8kwpvPUWUnlFmm/We1MOvrAH
uVX1kflR63hKzTxfYFqyyQV2hCBQYGInT3jocBHYhWLOm5kkmGgODpYS3xthlMdO
7uiP5fbHVW+SZYfkB8bjUlu3lT9IRLuvJ6KvMEBYsxvmMoANl7ZwXHssRqVTGygy
UbLnHLdMrVgukw6qq6cgFvbN5JygzUAW4c3+1s4s5vQ0g4bAju+Ym8m25h0F5RRo
ns9HwYaa9G+BtC/uteHyx9j7NjaSNhbmWOvp7cG+b93X7uPE2ljyvYbiPL0IGand
W6TDVRP4sZTqL64FU/4G/0iHeBkrMc1ou2CxIMRyOLlmUJepLMpjR8aA3asuHQZ4
iJZJQoFHn0RgQuAjG6wqSZUJXNtCBhPhDMliv811CFrC9L7SB1I=
=jjhP
-----END PGP SIGNATURE-----

--boxpunqqsxkyyd4w--

