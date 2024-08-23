Return-Path: <linux-pm+bounces-12839-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7721E95D392
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 18:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31923283BA9
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 16:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5479218BC02;
	Fri, 23 Aug 2024 16:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sYTG5Reg"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFE618858B;
	Fri, 23 Aug 2024 16:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724430820; cv=none; b=YIgrauT1TOHY7O7+k2xamUzKHI+Hftx6rdjHa1tmPa/CItppWkEq9dPVX33v2jmSMoFdKv28jQgsE5ayesTta7eWi/Ec4Cv2QLlVV5BnRur7NZ7/olcPMwRaM05ztSddSjozl10BrdfcrFqzqD8JxnkHOn7SCUwX180+y93y048=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724430820; c=relaxed/simple;
	bh=WSH4rUm+bcwJjBbvm5rtjbFA5J4F0JTq05nNX35iUV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SpWpqLQvARg+JRRWo+sKBPKLvKW+tV8YI4aqputQVfD7PZA08x7dVxMPiqUQYAX+ijxzRTPppuxHPkrNREp4WyDU9tSlYWKWzTfiZQNtQizM+Pk2He7/GooGcnDVaunON9MOzPiSLWmDzcRF7r32W2YzlUNv3YxIbVabgSsIOQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sYTG5Reg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 277BAC32786;
	Fri, 23 Aug 2024 16:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724430819;
	bh=WSH4rUm+bcwJjBbvm5rtjbFA5J4F0JTq05nNX35iUV0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sYTG5RegZzLko0cKmECk+1jIcHjw7gFO2WvdCtHif+pORMKYzT8tC9WzFlKs1FlaN
	 UwhG0vqVsJm7sGX8DKRpyucDaJxJibDXg55bauuigXDLMK3ML6xMWKgZRjbhXttZcv
	 xmUQ4ebQSXFJsM1QD/dhLALw0CQY+sSFNE+0KCNN/za2Zpr3+KK4gZ9sD6jbeIWrj5
	 TmWJRNi6/SofZ76q6Scy3B1nI9WQFhAIgw07UM6eYQNuHu4I+IdeRL56g3D7IAEnmD
	 kytHd15OE9JXfOsZhgrjEfbHAL5rngqSfm9p10rLt6lvyybNcC2EF4gC4XlwGh2X3o
	 ZMGkHbIvJXo+A==
Date: Fri, 23 Aug 2024 17:33:33 +0100
From: Conor Dooley <conor@kernel.org>
To: claudiu beznea <claudiu.beznea@tuxon.dev>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, p.zabel@pengutronix.de,
	geert+renesas@glider.be, magnus.damm@gmail.com,
	gregkh@linuxfoundation.org, mturquette@baylibre.com,
	sboyd@kernel.org, yoshihiro.shimoda.uh@renesas.com,
	biju.das.jz@bp.renesas.com, ulf.hansson@linaro.org,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH 02/16] dt-bindings: soc: renesas: renesas,rzg2l-sysc: Add
 #reset-cells for RZ/G3S
Message-ID: <20240823-dilute-juggle-7e2d43b8b630@spud>
References: <20240822152801.602318-1-claudiu.beznea.uj@bp.renesas.com>
 <20240822152801.602318-3-claudiu.beznea.uj@bp.renesas.com>
 <20240822-vanilla-enigmatic-f0b05ecca4b6@spud>
 <0d8b1322-cf15-4ed9-b958-06516bbb64c7@tuxon.dev>
 <20240823-plywood-unfixed-d8d8a2d93f14@spud>
 <5eae2ddb-2a7b-4c1d-a7f7-41fb39058de1@tuxon.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="n5mdGyWbSuHiQTuz"
Content-Disposition: inline
In-Reply-To: <5eae2ddb-2a7b-4c1d-a7f7-41fb39058de1@tuxon.dev>


--n5mdGyWbSuHiQTuz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 07:26:42PM +0300, claudiu beznea wrote:
> On 23.08.2024 19:18, Conor Dooley wrote:
> > On Fri, Aug 23, 2024 at 10:54:06AM +0300, claudiu beznea wrote:
> >> Hi, Conor,
> >>
> >> On 22.08.2024 19:42, Conor Dooley wrote:
> >>> On Thu, Aug 22, 2024 at 06:27:47PM +0300, Claudiu wrote:
> >>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >>>>
> >>>> The RZ/G3S System controller has registers to control signals that n=
eed
> >>>> to be de-asserted/asserted before/after different SoC areas are power
> >>>> on/off. This signals are implemented as reset signals. For this docu=
ment
> >>>> the #reset-cells property.
> >>>>
> >>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >>>> ---
> >>>>  .../bindings/soc/renesas/renesas,rzg2l-sysc.yaml | 16 +++++++++++++=
+++
> >>>>  1 file changed, 16 insertions(+)
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/soc/renesas/renesas,r=
zg2l-sysc.yaml b/Documentation/devicetree/bindings/soc/renesas/renesas,rzg2=
l-sysc.yaml
> >>>> index 4386b2c3fa4d..6b0bb34485d9 100644
> >>>> --- a/Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-sy=
sc.yaml
> >>>> +++ b/Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-sy=
sc.yaml
> >>>> @@ -42,12 +42,28 @@ properties:
> >>>>        - const: cm33stbyr_int
> >>>>        - const: ca55_deny
> >>>> =20
> >>>> +  "#reset-cells":
> >>>> +    const: 1
> >>>> +
> >>>>  required:
> >>>>    - compatible
> >>>>    - reg
> >>>> =20
> >>>>  additionalProperties: false
> >>>> =20
> >>>> +allOf:
> >>>> +  - if:
> >>>> +      properties:
> >>>> +        compatible:
> >>>> +          contains:
> >>>> +            const: renesas,r9a08g045-sysc
> >>>> +    then:
> >>>> +      required:
> >>>> +        - "#reset-cells"
> >>>
> >>> Given this is new required property on an existing platform, I'd expe=
ct
> >>> some mention of why it used to be okay to not have this but is now
> >>> required. Did firmware or a bootloader stage take things out of reset?
> >>
> >> On previous SoCs the SYS controller has no support for controlling the
> >> signals going to different peripherals (USB, PCIE in case of RZ/G3S).
> >> I'll add a note about this on next version.
> >=20
> > My initial thought here wasn't about previous SoCs though, it was
> > because you didn't add the compatible in this series for /this/ SoC.
>=20
> RZ/G3S compatible is already present in this file:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/devicetree/bindings/soc/renesas/renesas,rzg2l-sysc.yaml#n26

I know, first thing I did when I read the original patch was open the
file ;)
I don't care about the old SoCs, cos you're not applying the property to
them, so what's changed between SoCs isn't really relevant. It's a mention
of why, on this SoC, it is safe to add new required properties that I want.

AFAIU the answer is that no consumer of the resets existed before, so
there's not some special state there, and I am guessing that the new
sysc driver you're adding isn't going to fail to probe if there are no
resets, it just won't register a reset controller? Which is fine, cos all
devicetrees that have the new peripherals will have #reset-cells etc.

> > What's worth noting isn't about the prior SoCs, it is about what makes
> > it okay for this one.

--n5mdGyWbSuHiQTuz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZsi53AAKCRB4tDGHoIJi
0oJNAP92c9ehJZq5fmnv1qleJEN3MobM8LhjI5S5pogRzACmrgD8C8AbjitXRcYG
U53c5w0n+oi1+4Eu53GCqNNU/LSCmgc=
=GFYM
-----END PGP SIGNATURE-----

--n5mdGyWbSuHiQTuz--

