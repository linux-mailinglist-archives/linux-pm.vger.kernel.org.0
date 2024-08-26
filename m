Return-Path: <linux-pm+bounces-12895-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F7495F76E
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2024 19:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38808283050
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2024 17:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2822619885D;
	Mon, 26 Aug 2024 17:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+NKdVm+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19F018D64D;
	Mon, 26 Aug 2024 17:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724692157; cv=none; b=dhBZujzyyGGI+OkpQ/lM9r5aNKcuH36DK5fz+x/bbWmF1PxjZrGDhSEBEvD9tsGQowO41FmTkYQMbYYSzHBqOKVzMdVq/Al5Y49juydVz6lU+GXxF0VNO9/3Ml6hQk7gGGHHATRY+0Sn4/KeS8Qt6AnnTfS2ITgfNtT8tzwEpx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724692157; c=relaxed/simple;
	bh=o0yrJMcWN9NhQiyL6wLf2W3XPIcdo7ahAbqDUogj2kI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FUtoymrw8rhfH7uEWnt4/Zm/fX6i81Osv5jxvCE4Vro6KtuVwcNiZqta9jxr8KB3X44/NsJPf5INOps3vZNL4JNSY3yRY975+QYJx/O+zzhOfeHRTw0hfP+MCRVObqku3X5VS4g5GV+J5Z7gqnwPoCXex0bgeHiVOf5GYr3xJgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+NKdVm+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E69ABC5828E;
	Mon, 26 Aug 2024 17:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724692156;
	bh=o0yrJMcWN9NhQiyL6wLf2W3XPIcdo7ahAbqDUogj2kI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e+NKdVm+js++0+tUNii5X3zd86+JbZqnR5lwn7PRQdfmSWAuf/jPFpLfK/nDRPBV1
	 QuL866WhBf2qaa5M3S5LiUSm9VEKJhEyUUISkLIB7FhTT7Fk4ZYRATlqR/cVOnH2Ex
	 imv3IwC9Zws7uJhkg5ykDa4tRxRJmzMzKdM60lZkfARGazZdpy9hWplHoC7cGAhYaG
	 MZjVU3GcCf8a+kZwmG1bMiJm4QbADmyS3LD/ZtBF9wO89s9/jVbhuD9LrO7FWIAiA3
	 v69Q1qpAVOFc1hARm/tmwKmLSPg4HpoPbS+UvgU340zSSdzKEH3+IPqUmUA2tQeeT1
	 X2vFCbRQ83fUw==
Date: Mon, 26 Aug 2024 18:09:09 +0100
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
Message-ID: <20240826-daycare-freewill-c0e1400bf255@spud>
References: <20240822152801.602318-1-claudiu.beznea.uj@bp.renesas.com>
 <20240822152801.602318-3-claudiu.beznea.uj@bp.renesas.com>
 <20240822-vanilla-enigmatic-f0b05ecca4b6@spud>
 <0d8b1322-cf15-4ed9-b958-06516bbb64c7@tuxon.dev>
 <20240823-plywood-unfixed-d8d8a2d93f14@spud>
 <5eae2ddb-2a7b-4c1d-a7f7-41fb39058de1@tuxon.dev>
 <20240823-dilute-juggle-7e2d43b8b630@spud>
 <7b16791b-0d7b-49a1-82aa-c4db99ff2bfd@tuxon.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kphp1gQZZmvGGz7y"
Content-Disposition: inline
In-Reply-To: <7b16791b-0d7b-49a1-82aa-c4db99ff2bfd@tuxon.dev>


--kphp1gQZZmvGGz7y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 01:15:43PM +0300, claudiu beznea wrote:
>=20
>=20
> On 23.08.2024 19:33, Conor Dooley wrote:
> > On Fri, Aug 23, 2024 at 07:26:42PM +0300, claudiu beznea wrote:
> >> On 23.08.2024 19:18, Conor Dooley wrote:
> >>> On Fri, Aug 23, 2024 at 10:54:06AM +0300, claudiu beznea wrote:
> >>>> Hi, Conor,
> >>>>
> >>>> On 22.08.2024 19:42, Conor Dooley wrote:
> >>>>> On Thu, Aug 22, 2024 at 06:27:47PM +0300, Claudiu wrote:
> >>>>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >>>>>>
> >>>>>> The RZ/G3S System controller has registers to control signals that=
 need
> >>>>>> to be de-asserted/asserted before/after different SoC areas are po=
wer
> >>>>>> on/off. This signals are implemented as reset signals. For this do=
cument
> >>>>>> the #reset-cells property.
> >>>>>>
> >>>>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >>>>>> ---
> >>>>>>  .../bindings/soc/renesas/renesas,rzg2l-sysc.yaml | 16 +++++++++++=
+++++
> >>>>>>  1 file changed, 16 insertions(+)
> >>>>>>
> >>>>>> diff --git a/Documentation/devicetree/bindings/soc/renesas/renesas=
,rzg2l-sysc.yaml b/Documentation/devicetree/bindings/soc/renesas/renesas,rz=
g2l-sysc.yaml
> >>>>>> index 4386b2c3fa4d..6b0bb34485d9 100644
> >>>>>> --- a/Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-=
sysc.yaml
> >>>>>> +++ b/Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-=
sysc.yaml
> >>>>>> @@ -42,12 +42,28 @@ properties:
> >>>>>>        - const: cm33stbyr_int
> >>>>>>        - const: ca55_deny
> >>>>>> =20
> >>>>>> +  "#reset-cells":
> >>>>>> +    const: 1
> >>>>>> +
> >>>>>>  required:
> >>>>>>    - compatible
> >>>>>>    - reg
> >>>>>> =20
> >>>>>>  additionalProperties: false
> >>>>>> =20
> >>>>>> +allOf:
> >>>>>> +  - if:
> >>>>>> +      properties:
> >>>>>> +        compatible:
> >>>>>> +          contains:
> >>>>>> +            const: renesas,r9a08g045-sysc
> >>>>>> +    then:
> >>>>>> +      required:
> >>>>>> +        - "#reset-cells"
> >>>>>
> >>>>> Given this is new required property on an existing platform, I'd ex=
pect
> >>>>> some mention of why it used to be okay to not have this but is now
> >>>>> required. Did firmware or a bootloader stage take things out of res=
et?
> >>>>
> >>>> On previous SoCs the SYS controller has no support for controlling t=
he
> >>>> signals going to different peripherals (USB, PCIE in case of RZ/G3S).
> >>>> I'll add a note about this on next version.
> >>>
> >>> My initial thought here wasn't about previous SoCs though, it was
> >>> because you didn't add the compatible in this series for /this/ SoC.
> >>
> >> RZ/G3S compatible is already present in this file:
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-sysc.yaml#n26
> >=20
> > I know, first thing I did when I read the original patch was open the
> > file ;)
> > I don't care about the old SoCs, cos you're not applying the property to
> > them, so what's changed between SoCs isn't really relevant. It's a ment=
ion
> > of why, on this SoC, it is safe to add new required properties that I w=
ant.
>=20
>=20
> >=20
> > AFAIU the answer is that no consumer of the resets existed before, so
>=20
> That's true.
>=20
> > there's not some special state there, and I am guessing that the new
> > sysc driver you're adding isn't going to fail to probe if there are no
> > resets,=20
>=20
> That's true.
>=20
> it just won't register a reset controller?
>=20
> It will register it but,
>=20
> the new sysc driver is going to probe only for this SoC (RZ/G3S). On RZ/G=
3S
> we have 2 resets. These well be registered unconditionally, currently, on=
ly
> for RZ/G3S. If there will be no DT users for it then it should be no
> problem, AFAICT.

Okay, sounds it doesn't break for existing devicetrees.
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--kphp1gQZZmvGGz7y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZsy2tQAKCRB4tDGHoIJi
0rV7AP9DZ2q3xfYMx00ty17Bs3eDE/3N2vWVqh51vuQzlmHBaQD+MSrwIUvtdEhg
jiaBBICMFZmTjei0JYXu91UpMiCd9AM=
=MJwd
-----END PGP SIGNATURE-----

--kphp1gQZZmvGGz7y--

