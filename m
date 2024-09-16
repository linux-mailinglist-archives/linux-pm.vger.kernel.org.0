Return-Path: <linux-pm+bounces-14323-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D60F0979D2C
	for <lists+linux-pm@lfdr.de>; Mon, 16 Sep 2024 10:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 633A51F207C7
	for <lists+linux-pm@lfdr.de>; Mon, 16 Sep 2024 08:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9541442F2;
	Mon, 16 Sep 2024 08:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="c1uA90Ws"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C8B13D61B;
	Mon, 16 Sep 2024 08:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726476503; cv=pass; b=dalcUOGSQKZLRGbB9w+tFQb4hmPPrEJcW7j5JmAP7fXy6vXdQuZ228Siq1UHd/D+ENtYS1bg1SDuL4NOOuIjz/VcpP4PIHhrmJaXRA197YPkqQcW0FYo7wdH8RmUScCktn9cYjueQDxwI/0qozA6I37Ozya/tPIdh9feGSLToj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726476503; c=relaxed/simple;
	bh=lNk3OLyjwxyTfC7SkjUR1VpRljx6vHpl91jfzH32OBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DAnl+jMpy9FW9IXIsjp0S1ZmYwA4qDBMOjO4LMoHoFCff3rSn1Gi8ZUlHw5nyyDcEnPvaZnhaHF5RnLSBtqFN8Idy4D0tmLqz2JrfNxHoT8A3x+hzv1egrm7DNbUTuJPxFOXxrTW3CD3TsqxEvWyXyxMtxoV/4u6Wh/xCwlSQa4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=c1uA90Ws; arc=pass smtp.client-ip=136.143.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1726476492; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=DRLfK1ttIGsM8SyqW80jT9iIQwRkRlwbgX9jMSW5Ncw6YC1VmeY/xUp5N/o+v2AbLnWoKLgH6+xZs34neZViujp3x7kNqmGfOz4Z/ejr6Ehh80gPVRwNBKi5XRE01pH1bb39NLklArL5rYkFNidASdp53DX5+KIkVZl+JkcxBwU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1726476492; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=46Ql7Sx91QiMZFhlAZ1LUlqI5yE8lHMmJR8Ysw/Aydc=; 
	b=Dxu0IeoGGQaMEIzKBBMUHd15oxZ/iq0nX3EiDkpOv0kknUsU246+6/HchsQMjIGtf6iZwJfBSuofLb7jft2OPjuqKspJcjYquLFfSsEJ6WKLqn3U12IaUmoEqqJHc3CM4cjpQsr7/NA+BVCiPdck2eBApYEGaFNK35zVexzfICQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1726476492;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=46Ql7Sx91QiMZFhlAZ1LUlqI5yE8lHMmJR8Ysw/Aydc=;
	b=c1uA90WsRjWKRD1/mFOe5FsciaawjP3FhTw0cUIZG22mRYYdRVWjXYDYRGt9UCsZ
	f1VgrDNemmaTG1pk9NH58PG2Ilb1auSjuvbxr3J1gL4ECVj4RL5OFXg+5x6144bXk26
	rzKLaHjHDBGNOxz/U+xwFY7e+kVO1Jo+jz/h9xSU=
Received: by mx.zohomail.com with SMTPS id 17264764913411012.8729125971017;
	Mon, 16 Sep 2024 01:48:11 -0700 (PDT)
Received: by mercury (Postfix, from userid 1000)
	id BBEF2106045D; Mon, 16 Sep 2024 10:48:04 +0200 (CEST)
Date: Mon, 16 Sep 2024 10:48:04 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: =?utf-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <trabarni@gmail.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	=?utf-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>
Subject: Re: [PATCH 1/2] dt-bindings: power: supply: bq256xx: Add
 omit-battery-class property
Message-ID: <52icxdwohfdiwjvjsbvpxvgaux7hedr6d63zkyhlvbg3t6ykrj@zm47trzk5l5k>
References: <20240907-bq256xx-omit-battery-class-v1-0-45f6d8dbd1e5@mainlining.org>
 <20240907-bq256xx-omit-battery-class-v1-1-45f6d8dbd1e5@mainlining.org>
 <5bf9a142-05d9-4e02-bca0-f988726e2873@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="po3fnon6w37rqren"
Content-Disposition: inline
In-Reply-To: <5bf9a142-05d9-4e02-bca0-f988726e2873@kernel.org>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.3.1/223.982.64
X-ZohoMailClient: External


--po3fnon6w37rqren
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Sep 07, 2024 at 01:11:57PM GMT, Krzysztof Kozlowski wrote:
> On 07/09/2024 13:07, Barnab=E1s Cz=E9m=E1n wrote:
> > Add omit-battery-class property for avoid system create a battery devic=
e.
>=20
> This does not help much, basically repeats commit subject. You need to
> answer to "why?".

Exposing two battery devices for a single battery is a bug, since that
means there are two distinct batteries. Also note, that platforms having
multiple batteries is a real thing. e.g. some Thinkpads used to have an
internal battery and a hot-swappable one.

> > Signed-off-by: Barnab=E1s Cz=E9m=E1n <barnabas.czeman@mainlining.org>
> > ---
> >  Documentation/devicetree/bindings/power/supply/bq256xx.yaml | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/power/supply/bq256xx.yam=
l b/Documentation/devicetree/bindings/power/supply/bq256xx.yaml
> > index a76afe3ca299..744f5782e8e7 100644
> > --- a/Documentation/devicetree/bindings/power/supply/bq256xx.yaml
> > +++ b/Documentation/devicetree/bindings/power/supply/bq256xx.yaml
> > @@ -62,6 +62,12 @@ properties:
> >      $ref: /schemas/types.yaml#/definitions/phandle
> >      description: phandle to the battery node being monitored
> > =20
> > +  omit-battery-class:
> > +    type: boolean
> > +    description: |
> > +      If this property is set, the operating system does not try to cr=
eate a
> > +      battery device.
>=20
> You described the desired Linux feature or behavior, not the actual
> hardware. The bindings are about the latter, so instead you need to
> rephrase the property and its description to match actual hardware
> capabilities/features/configuration etc.

Fully agreed. Also I think we already have the necessary information
in the DT bindings. If there is a fuel-gauge in addition to the
bq256xx charger, there should be a power-supplies link [0] between
those two. Without the fuel-gauge obviously no such link exists. So
the existance of this link can be used to decide wether a battery
device should be registered or not.

If the link exists, the charger driver should not create its own
battery device. In the future the extension API might be used to
let the charger extend the fuel gauge in case it is missing support
for some battery properties, which can be provided by the charger.

Note, that the link is going the other way around (from the battery
to the charger). Also the fuel-gauge device will be registered after
the charger device, so you cannot rely on power_supply_for_each_device
when the charger probes. I see two options to solve that:

1. Create a new power-supply core function, which goes through all DT
   nodes, check that the nodename is "battery" or "fuel-gauge" and have
   a property "power-supplies" with a phandle pointing to the charger
   node.

2. Register the battery device at charger probe time and when the
   fuel-gauge driver is registered, call a (to be introduced) callback
   function in the charger driver, which unregisters the charger's
   battery.

I have a slight preference for the second option, but I'm fine with
either way. This does not create new ABI and can be easily changed
in the future.

[0] Documentation/devicetree/bindings/power/supply/power-supply.yaml

Greetings,

-- Sebastian

--po3fnon6w37rqren
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmbn8MAACgkQ2O7X88g7
+pprIxAAk/vlq10XTcDhCuOyZV8T/BY1XlrmY/rdgqxeyu5BpG7NbwJ5aWtqYS0k
B+1nCd3IhGqxl0qhSIA/2CHd+H/y4w6NZzqBYaNJy6J3BwUnGKLLBLoXw/5AuvIQ
qf7sUIdZrl29j2L6LgpFo+aNN64XPDpKOPDG7ORcPQvk9B1xIHLDVOYXNGcUEScT
izULCghqv1F+YUJl1JV13SQOqv9C+E5Oc4hG97FIj7aGCaGe/jwS2iaOKVxeZfwD
C/bBWT4DFQVCeRJu/zeNpA5G4jcCKKZjtIZpg6TBKqi4B13ZBGpOmkwzvhBXs2j6
qNB+62MvnSN5driQy5W8CgBLXHbB9qL+rW8F4tCMkotDMJGMWyTFMRZHPP43CoI5
fwJXVhTeWTvp94iPc/9bUdjgzoPFyJFwNbtTY9almBPyrCd0DMJniEp6tevHB7aw
g4aJeLvpNe6UPmHUGWFTXa0YrJ1N2v2wvgbYGqrHbB04h5tTif2HWl31FAcdKVBV
ey6CrjxPqjlcL7DDI3dES3SThXX1XC4gyNJZc3dz/loXntMuZBc4neakOLSUCJTn
G9cb8s6oJF5SDOjhwyoYIx1odbfgMv9E0HV2pzSpsf60M8ChyqX0tnR8wiqQoJyx
XCntNvS+vesmZ0iTrCBDFsD9rLz+hVg59nJPWC8i0zGKfGwMCvc=
=tDBl
-----END PGP SIGNATURE-----

--po3fnon6w37rqren--

