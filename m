Return-Path: <linux-pm+bounces-12752-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4B495BC57
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 18:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6236B2A19C
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 16:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA8A1CE6EE;
	Thu, 22 Aug 2024 16:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4Mir6Jc"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BC01CDFC5;
	Thu, 22 Aug 2024 16:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724345105; cv=none; b=hkn88pyYQ8mo2+d/vqTIihJjY8jDkJewxne/dqH451bn5FHsRdX2f+n6bWdkQKG5wutcQkevAqjfJUCD77kIflOdirPUKZj0lea9HlSJu6nWh/Yjuwu85ACSDzoywGouA0hRsMvS8OS5qcba0Z2HJQekLmwS982HXKUfLWgMuGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724345105; c=relaxed/simple;
	bh=WrlN+67fyl/9DMCWCvghwD06kAjbzcfn6dDe7h6wxn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IkS7Umyb8236Yx/k4jcwwiv02aYRYkIjsS0rZzAbh5KReem4srxgXOyOtoGk8isyoDlI/rIynU6anhKdozY6Oci8SKVQOiISzG1y5mDmtQA1WJyI93eXmOZrWiGSspvr7FdIbG2aYEor76l2zgaUpeS8FIZRraALpW1BGnLpyoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4Mir6Jc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B23FC32782;
	Thu, 22 Aug 2024 16:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724345104;
	bh=WrlN+67fyl/9DMCWCvghwD06kAjbzcfn6dDe7h6wxn0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V4Mir6Jc65AVcAqoR1k1S8yF13+rBZctf7bvL/1PJOJZH1+tn/cUFuXSSIj3n6OLh
	 h6Ce4waDtOd1SmjSD60mAYoIDQBWkGqUkG+SGPBgIphiOa2WzMRP+MorOfnhPCnRDT
	 hWwdbbVFkcqYf7GTjDz7I66oPm1LHWs/YIXqTphXQ9224UBr2s1o9Fe5csRUA2Vbrd
	 51O3KQGws+QdU31tzIICRFzBZCtcCKgVk9ew5yQdsmUxcRybXXQASNOvoR6W3Y5XDY
	 sNVmKDWoJCXsdP9rXgrsfV4TCKl/7smifMGk+AszUjvCk0gCZGNxnuWGoMp8hfLDuA
	 wlM0bISIJAmqg==
Date: Thu, 22 Aug 2024 17:44:58 +0100
From: Conor Dooley <conor@kernel.org>
To: Claudiu <claudiu.beznea@tuxon.dev>
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
Message-ID: <20240822-mountain-hurdle-dd1f08b96f64@spud>
References: <20240822152801.602318-1-claudiu.beznea.uj@bp.renesas.com>
 <20240822152801.602318-3-claudiu.beznea.uj@bp.renesas.com>
 <20240822-vanilla-enigmatic-f0b05ecca4b6@spud>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZWzRvO3ns8+wP6rp"
Content-Disposition: inline
In-Reply-To: <20240822-vanilla-enigmatic-f0b05ecca4b6@spud>


--ZWzRvO3ns8+wP6rp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 05:42:57PM +0100, Conor Dooley wrote:
> On Thu, Aug 22, 2024 at 06:27:47PM +0300, Claudiu wrote:
> > From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >=20
> > The RZ/G3S System controller has registers to control signals that need
> > to be de-asserted/asserted before/after different SoC areas are power
> > on/off. This signals are implemented as reset signals. For this document
> > the #reset-cells property.
> >=20
> > Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > ---
> >  .../bindings/soc/renesas/renesas,rzg2l-sysc.yaml | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/soc/renesas/renesas,rzg2=
l-sysc.yaml b/Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-s=
ysc.yaml
> > index 4386b2c3fa4d..6b0bb34485d9 100644
> > --- a/Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-sysc.=
yaml
> > +++ b/Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-sysc.=
yaml
> > @@ -42,12 +42,28 @@ properties:
> >        - const: cm33stbyr_int
> >        - const: ca55_deny
> > =20
> > +  "#reset-cells":
> > +    const: 1
> > +
> >  required:
> >    - compatible
> >    - reg
> > =20
> >  additionalProperties: false
> > =20
> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: renesas,r9a08g045-sysc
> > +    then:
> > +      required:
> > +        - "#reset-cells"
>=20
> Given this is new required property on an existing platform, I'd expect
> some mention of why it used to be okay to not have this but is now
> required. Did firmware or a bootloader stage take things out of reset?

Reading a bit more into the series, the peripherals in question were
just never used nor did a driver for the sysc exist, so there's neither
explanation of prior behaviour nor concerns about compatibility?

>=20
> > +    else:
> > +      properties:
> > +        "#reset-cells": false
> > +
> >  examples:
> >    - |
> >      #include <dt-bindings/interrupt-controller/arm-gic.h>
> > --=20
> > 2.39.2
> >=20



--ZWzRvO3ns8+wP6rp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZsdrCgAKCRB4tDGHoIJi
0uG8AP9KErhuqHGo0goHh4p9RoWQWSQLtxDDIaGI6XDc4GYpEAD/af+u+5EQKxfW
u6mEr8fG1pmimijNTGtbSERV+00abgY=
=TCjP
-----END PGP SIGNATURE-----

--ZWzRvO3ns8+wP6rp--

