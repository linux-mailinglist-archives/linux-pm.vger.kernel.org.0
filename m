Return-Path: <linux-pm+bounces-12836-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A9F95D30D
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 18:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 684E01F22749
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 16:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2F818F2FB;
	Fri, 23 Aug 2024 16:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZC90Fm8O"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6E418BC14;
	Fri, 23 Aug 2024 16:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724429891; cv=none; b=Wlkf7KVlT9LvtI8Zj7zEmdcufP2KK31XRIbOUDknjeO8KZrPNRRti1HLnDguD3xuCdNXK3B2/zspjKOfTy7tn/2NAaiMq3fYM62CRRFTaEdKBxTdE6xt9m1ur+bKuCXcCAIBQvIc6HHp6zML0frRJrgM4MYKwK6N/g85EiEVoR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724429891; c=relaxed/simple;
	bh=PgdByvdiAfbXaDotznDJ0dcWaZ63H3JEqmGBNQTkNik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fgcTzg9XirlC8Soo4v9EwWMNFSWmIl/fQzjqksfiaoA5fG6p+u+cYF+vOUa6ib9wJ4MfqSfNXiV+S0XUN9FaBJUHaRAXXGuOE9npoHTSy73vP4lv+kUSUmWqAvj3TDysWy1BfjMeBkr/WQfs3fcBON4LV7MI5gi4CzQkulT0Y2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZC90Fm8O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD95EC32786;
	Fri, 23 Aug 2024 16:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724429891;
	bh=PgdByvdiAfbXaDotznDJ0dcWaZ63H3JEqmGBNQTkNik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZC90Fm8Oaw+MQx+uDsJmmODI2/hX9icvDed7tm4bS+eYRSFHflJN7lzWx7rLqnZVc
	 /EeRQapRZtyrKflOGlW921S5f2NsO84csxAlObYlSnAoSpArgtGMI1fyIeP9JFeMd+
	 wxx6FxANYeXN8kJP5XsIVDrOFWBOYyRpjxLF9MXQEWWoYz/NUKfioM1Mo5XKWcUVb2
	 Xrli84Wyw2O4//SzdGKFRgz5B8WyBrbhzXS4McahzOIuBxJGTEl95FGQdPqujyGtbz
	 LFS9h83DMHMURzMQNRTkjhJuj8I+FBR4OPZ7ykSCmj8rKCnV6Ksfnx4Ww39PmTXW/w
	 TNlBbNLVZYIWg==
Date: Fri, 23 Aug 2024 17:18:04 +0100
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
Message-ID: <20240823-plywood-unfixed-d8d8a2d93f14@spud>
References: <20240822152801.602318-1-claudiu.beznea.uj@bp.renesas.com>
 <20240822152801.602318-3-claudiu.beznea.uj@bp.renesas.com>
 <20240822-vanilla-enigmatic-f0b05ecca4b6@spud>
 <0d8b1322-cf15-4ed9-b958-06516bbb64c7@tuxon.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GSCRsUY2DblipIOX"
Content-Disposition: inline
In-Reply-To: <0d8b1322-cf15-4ed9-b958-06516bbb64c7@tuxon.dev>


--GSCRsUY2DblipIOX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 10:54:06AM +0300, claudiu beznea wrote:
> Hi, Conor,
>=20
> On 22.08.2024 19:42, Conor Dooley wrote:
> > On Thu, Aug 22, 2024 at 06:27:47PM +0300, Claudiu wrote:
> >> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >>
> >> The RZ/G3S System controller has registers to control signals that need
> >> to be de-asserted/asserted before/after different SoC areas are power
> >> on/off. This signals are implemented as reset signals. For this docume=
nt
> >> the #reset-cells property.
> >>
> >> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >> ---
> >>  .../bindings/soc/renesas/renesas,rzg2l-sysc.yaml | 16 ++++++++++++++++
> >>  1 file changed, 16 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/soc/renesas/renesas,rzg=
2l-sysc.yaml b/Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-=
sysc.yaml
> >> index 4386b2c3fa4d..6b0bb34485d9 100644
> >> --- a/Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-sysc=
=2Eyaml
> >> +++ b/Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-sysc=
=2Eyaml
> >> @@ -42,12 +42,28 @@ properties:
> >>        - const: cm33stbyr_int
> >>        - const: ca55_deny
> >> =20
> >> +  "#reset-cells":
> >> +    const: 1
> >> +
> >>  required:
> >>    - compatible
> >>    - reg
> >> =20
> >>  additionalProperties: false
> >> =20
> >> +allOf:
> >> +  - if:
> >> +      properties:
> >> +        compatible:
> >> +          contains:
> >> +            const: renesas,r9a08g045-sysc
> >> +    then:
> >> +      required:
> >> +        - "#reset-cells"
> >=20
> > Given this is new required property on an existing platform, I'd expect
> > some mention of why it used to be okay to not have this but is now
> > required. Did firmware or a bootloader stage take things out of reset?
>=20
> On previous SoCs the SYS controller has no support for controlling the
> signals going to different peripherals (USB, PCIE in case of RZ/G3S).
> I'll add a note about this on next version.

My initial thought here wasn't about previous SoCs though, it was
because you didn't add the compatible in this series for /this/ SoC.
What's worth noting isn't about the prior SoCs, it is about what makes
it okay for this one.

--GSCRsUY2DblipIOX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZsi2PAAKCRB4tDGHoIJi
0g2cAQDP31P2uZ2yJsxRp9QIUYTgXjcHmhTZPcFjJt8BD980TgD8DlBwXJ0T9MnS
uL/Znkm4rQCaBJlq8vpNa0dgniF1pAQ=
=Yj0N
-----END PGP SIGNATURE-----

--GSCRsUY2DblipIOX--

