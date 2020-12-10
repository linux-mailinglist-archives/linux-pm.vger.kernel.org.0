Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67EE72D65F7
	for <lists+linux-pm@lfdr.de>; Thu, 10 Dec 2020 20:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390620AbgLJTIT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Dec 2020 14:08:19 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:39835 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390457AbgLJObA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Dec 2020 09:31:00 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id BAED5F90;
        Thu, 10 Dec 2020 09:30:09 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 10 Dec 2020 09:30:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=GxHNtWYaWKBb/i5q0UOa1xNYPoH
        /CYYbbYAGp7x786A=; b=RsIbGwWv2BnvpO+vN+tpt6Wur6MZUhIuh3a6D0rGqnG
        hCd39BMLd6SuJrRn/8xetzstEjBzhhPiTJEEXtykCWCQ3oAutFTnkOTKgJ4AFJKN
        8aH+jj8GjgJiPxtXngQx87mHVfAVr0KWAOhh2JvNfehmi9GpYtwQctRJ7CTpMcJr
        XIFO11yeXS8eUn56DAdr9nxBEm/0aoU2nts2JfCbPV+scu/L8xq7mVDe0ZaVZeV0
        DupDWRYXJc/2y/HnL9NB+S1t3V+hv0uv0RcZ/+Hdi/QxsxX5f0Ujx3Kz95KgEi9d
        lirGr//GHuTckLFBG/yrx/d7ZFMlxiMCcfCkjLJfr3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=GxHNtW
        YaWKBb/i5q0UOa1xNYPoH/CYYbbYAGp7x786A=; b=a/rNGWcf9GVjUSZg4QsWzm
        vkmZYntplLLT79dxZiKjfzTN0U+5FHv7CSoVhcyJ/vPAFyKX0qEByvgh2N0h2tpD
        akjL2sqiQSXCZh34zxQ4r7GBG6RwPxA1k7s+GHk0g0CQDLYI7pC4uyVaMd2cPe64
        assJnkbU5HmgfwlXIzYUD5xrcoiJ2jTTOzWZRxgbWQm/YdLO5501jzUOom95GHTc
        xGfFAOAm1IgRTgTARv82nN966huzzyQERSAaf2WY+rtkS76a3JOFKDFGU5mVmumx
        kpEe8CMrthzsxCNx8dff5l3Wsbw0N8ibY2Xr++KtEMQLLQfzvTuzocczSd2ybuyw
        ==
X-ME-Sender: <xms:7zDSXyYczJzSCOThHI4yvfGiHk_UGiP_U-Rk6Thxb_n4eLu7Hd79uQ>
    <xme:7zDSXy_8ffYQGv8PHIdd0FQnyV6Tyg5eGfWVjpUiI3iTKHEYiP8VNvgDC4jcoBBiO
    yYoRkzdFuMnUgH4zA8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudektddgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddunecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepheeifedutefhveekieegvdfgteejgefhvdevkedvffeuffetjedtjedufffg
    udeknecuffhomhgrihhnpeguvghvihgtvghtrhgvvgdrohhrghenucfkphepledtrdekle
    drieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:8DDSXzYIOvB4hQbAhDpTqDUS9B6Qjwl86NoNVQJ5hZ6nSXwU5lf1Zg>
    <xmx:8DDSX2PXkhkdEONM6n38SlEwf9x3-51TWma5-bTqSgbBQjD77ynyTw>
    <xmx:8DDSX_AGmoxntHXVs8Mg5hZajG1jSr5ILLEz9ZGCPy9wdIgQqXMGiw>
    <xmx:8TDSX3i0cUuhOweFLdeSywTdovXSfm5fYNdfYvS5pvGFDOo-G1aOTw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id AB23E24005A;
        Thu, 10 Dec 2020 09:30:07 -0500 (EST)
Date:   Thu, 10 Dec 2020 15:30:06 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Michael Klein <michael@fossekall.de>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/3] Documentation: DT: binding documentation for
 regulator-poweroff
Message-ID: <20201210143006.y5gbjrn2rdfg37h4@gilmour>
References: <20201128103958.q6glewhhch7vtczr@gilmour>
 <20201207142756.17819-1-michael@fossekall.de>
 <20201207142756.17819-3-michael@fossekall.de>
 <20201208101358.mwxmlgqonmunb2m2@gilmour>
 <20201208125214.GA2785@a98shuttle.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="odflilct2dhsshyl"
Content-Disposition: inline
In-Reply-To: <20201208125214.GA2785@a98shuttle.de>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--odflilct2dhsshyl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi

On Tue, Dec 08, 2020 at 01:52:14PM +0100, Michael Klein wrote:
> Thanks for reviewing!
>=20
> On Tue, Dec 08, 2020 at 11:13:58AM +0100, Maxime Ripard wrote:
> > On Mon, Dec 07, 2020 at 03:27:55PM +0100, Michael Klein wrote:
> > > Add devicetree binding documentation for regulator-poweroff driver.
> > >=20
> > > Signed-off-by: Michael Klein <michael@fossekall.de>
> > > ---
> > >  .../power/reset/regulator-poweroff.yaml       | 53 +++++++++++++++++=
++
> > >  1 file changed, 53 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/power/reset/reg=
ulator-poweroff.yaml
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/power/reset/regulator-=
poweroff.yaml b/Documentation/devicetree/bindings/power/reset/regulator-pow=
eroff.yaml
> > > new file mode 100644
> > > index 000000000000..8c8ce6bb031a
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/power/reset/regulator-powerof=
f.yaml
> > > @@ -0,0 +1,53 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/power/reset/regulator-poweroff.ya=
ml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Force-disable power regulators to turn the power off.
> > > +
> > > +maintainers:
> > > +  - Michael Klein <michael@fossekall.de>
> > > +
> > > +description: |
> > > +  When the power-off handler is called, one more regulators are disa=
bled
> > > +  by calling regulator_force_disable(). If the power is still on and=
 the
> > > +  CPU still running after a 3000ms delay, a WARN_ON(1) is emitted.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: "regulator-poweroff"
> > > +
> > > +  regulator-names:
> > > +    description:
> > > +      Array of regulator names
> > > +    $ref: /schemas/types.yaml#/definitions/string-array
> > > +
> > > +  REGULATOR-supply:
> >=20
> > This should be a patternProperties
> >=20
> > > +    description:
> > > +      For any REGULATOR listed in regulator-names, a phandle
> > > +      to the corresponding regulator node
> > > +    $ref: /schemas/types.yaml#/definitions/phandle
> > > +
> > > +  timeout-ms:
> > > +    description:
> > > +      Time to wait before asserting a WARN_ON(1). If nothing is
> > > +      specified, 3000 ms is used.
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +
> > > +required:
> > > +  - compatible
> > > +  - regulator-names
> > > +  - REGULATOR-supply
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    regulator-poweroff {
> > > +        compatible =3D "regulator-poweroff";
> > > +        regulator-names =3D "vcc1v2", "vcc-dram";
> > > +        vcc1v2-supply =3D <&reg_vcc1v2>;
> > > +        vcc-dram-supply =3D <&reg_vcc_dram>;
> > > +    };
> >=20
> > I'm not entirely sure how multiple regulators would work here. I guess
> > the ordering is board/purpose sensitive. In this particular case, I
> > assume that vcc1v2 would be shut down before vcc-dram?
>=20
> yes, the regulators are shut down from left to right.
>=20
> > If so, I would expect that one regulator_force_disable is run, the CPU
> > is disabled and you never get the chance to cut vcc-dram.
>=20
> I assume that any relevant regulator here has enough capacitance on the
> output that provides enough charge to disable any remaining regulators (my
> board has 3*10=B5F for vcc1v2 and 1*10=B5F for vcc-dram). But there is of=
 course
> no guarantee, so I'm shutting down the most relevant (in terms of current
> consumption) regulator first.
>
> In any case, if it's deemed unnecessary to allow more than one regulator =
in
> the driver I could remove the regulator-names property altogether and red=
uce
> the DT node to:
>=20
>   regulator-poweroff {
>       compatible =3D "regulator-poweroff";
>       poweroff-supply =3D <&reg_vcc1v2>;
>   };

It's mostly about semantics at this point but there's value in shutting
down the RAM as well if we're taking some precautions I mentionned.
Maybe we can name that regulator cpu-supply, so that we can easily add
the DRAM one if needed, and the semantics are clear?

Maxime

--odflilct2dhsshyl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX9Iw7gAKCRDj7w1vZxhR
xQd3APwPeVpI7kR2zAa0S9NIutAmxaddlPFVl9qvGiBTK3OILwD/bYeO568BkX6F
wVW4/ieCV2uLr4VzxUomuTSkP1UEUgs=
=9fYu
-----END PGP SIGNATURE-----

--odflilct2dhsshyl--
