Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF262D289A
	for <lists+linux-pm@lfdr.de>; Tue,  8 Dec 2020 11:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbgLHKOs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Dec 2020 05:14:48 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:38951 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728266AbgLHKOr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Dec 2020 05:14:47 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id F1EA99EB;
        Tue,  8 Dec 2020 05:14:00 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 08 Dec 2020 05:14:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=vdUkDeRfsoAEQzQPdIe5/Kd/oo5
        eFAZbliCK9MyCNhY=; b=HzV4Wtfi0k4C3NNil1BxlpYUUdxjDxDBROO4WwQX75j
        v1phXzc/yI4iB7R4R45MuKWxbrRwx9OwKKTr2uuH/Ho/XdD4q3paEn05pPdnvuxv
        wIE1Acf2eZMhklOK8RbzZ9rUCvkZGhux8D8KAEj9vuiYEwStNwATXxB5I3PVKjDT
        SG4HZheTBRmlAwaJBHd3K5dJavl6wQvoPS8kx0qqPtM7hfs0/VL8KeVOqEGxbwm4
        154cJBHqygimlD5cJuDxHRVv43kZXp3m0yBFYcFATbbXxXsOECt35vdqDht5rlTb
        J7zqMg9Ipg0HFCBXa87kXuOhPTJrPYXO3frZg6B7akw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=vdUkDe
        RfsoAEQzQPdIe5/Kd/oo5eFAZbliCK9MyCNhY=; b=MMfUmaSL1G49rnbMzkS3xV
        zAhklP197AgCPAz7bQfGPuc0Qs196Dkc/E5sd10aQubt0N5DQ0Kk/cGqixukiNI3
        7+wVFst1XgKmhk7LWGuSyrhm22QPDN51xl+f2mtab0o5UX5IJ6tepQaOsekeichk
        t33A7+nJ85XHsz7eKwUmoZYOBGMN6ywfTcv/jzH5rKfoJ8O7jtL0FREKnVCj7TPj
        RVGf7L1nSV96/7900YKTohhfzUKzJnJkO8D+IWy/yA9UQ4GtFCpCWZ3my9E/HbEw
        b9Ldkrv8ibUDPLd4FBLwr8rg9mHITcYddu21+C8A01adYgAzH4XZEwtgtkK8khMg
        ==
X-ME-Sender: <xms:51HPX9rsW-v8v3rHIZMWXpaDc9nJFj8vgKtmSSVo8WMq1MRELByolQ>
    <xme:51HPX_rQ3Xn8CPPfYTPxXU_5Tj3cs04dFryvqt8tPpd0CVqW482E3FumAz0VPlr1U
    eeT4wUS5nMRoDPNDTk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudejiedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepffetteevieejteeuhfffgeektefghfeileehhedtuddutefhhfejtddvtddu
    ledvnecuffhomhgrihhnpeguvghvihgtvghtrhgvvgdrohhrghenucfkphepledtrdekle
    drieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:51HPX6PuCpfoo6SO5Xp_cTsGGR3Ja97L8YGGpNlV_Teaoe0aM2JKUQ>
    <xmx:51HPX455Nb98olm_oWTYQ_rkFumY7O9AkHUswb4z3xxGu-y6uyzExw>
    <xmx:51HPX84ZJuSh3qlpHufRj_a2Hig_2w4sjGhGW7WDygjnvQBsgwSGMQ>
    <xmx:6FHPX5s8ZjgARzCBB4VO7l8favsZPYy6XLBBSCUlisJE_Ipk98PzYw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 52E901080059;
        Tue,  8 Dec 2020 05:13:59 -0500 (EST)
Date:   Tue, 8 Dec 2020 11:13:58 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Michael Klein <michael@fossekall.de>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/3] Documentation: DT: binding documentation for
 regulator-poweroff
Message-ID: <20201208101358.mwxmlgqonmunb2m2@gilmour>
References: <20201128103958.q6glewhhch7vtczr@gilmour>
 <20201207142756.17819-1-michael@fossekall.de>
 <20201207142756.17819-3-michael@fossekall.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wwouytazosfvho63"
Content-Disposition: inline
In-Reply-To: <20201207142756.17819-3-michael@fossekall.de>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--wwouytazosfvho63
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 07, 2020 at 03:27:55PM +0100, Michael Klein wrote:
> Add devicetree binding documentation for regulator-poweroff driver.
>=20
> Signed-off-by: Michael Klein <michael@fossekall.de>
> ---
>  .../power/reset/regulator-poweroff.yaml       | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/reset/regulat=
or-poweroff.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/power/reset/regulator-powe=
roff.yaml b/Documentation/devicetree/bindings/power/reset/regulator-powerof=
f.yaml
> new file mode 100644
> index 000000000000..8c8ce6bb031a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/reset/regulator-poweroff.ya=
ml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/reset/regulator-poweroff.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Force-disable power regulators to turn the power off.
> +
> +maintainers:
> +  - Michael Klein <michael@fossekall.de>
> +
> +description: |
> +  When the power-off handler is called, one more regulators are disabled
> +  by calling regulator_force_disable(). If the power is still on and the
> +  CPU still running after a 3000ms delay, a WARN_ON(1) is emitted.
> +
> +properties:
> +  compatible:
> +    const: "regulator-poweroff"
> +
> +  regulator-names:
> +    description:
> +      Array of regulator names
> +    $ref: /schemas/types.yaml#/definitions/string-array
> +
> +  REGULATOR-supply:

This should be a patternProperties

> +    description:
> +      For any REGULATOR listed in regulator-names, a phandle
> +      to the corresponding regulator node
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +
> +  timeout-ms:
> +    description:
> +      Time to wait before asserting a WARN_ON(1). If nothing is
> +      specified, 3000 ms is used.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +required:
> +  - compatible
> +  - regulator-names
> +  - REGULATOR-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    regulator-poweroff {
> +        compatible =3D "regulator-poweroff";
> +        regulator-names =3D "vcc1v2", "vcc-dram";
> +        vcc1v2-supply =3D <&reg_vcc1v2>;
> +        vcc-dram-supply =3D <&reg_vcc_dram>;
> +    };

I'm not entirely sure how multiple regulators would work here. I guess
the ordering is board/purpose sensitive. In this particular case, I
assume that vcc1v2 would be shut down before vcc-dram?

If so, I would expect that one regulator_force_disable is run, the CPU
is disabled and you never get the chance to cut vcc-dram.

Similarly, cutting the RAM regulator first would probably be fine if
you're running code from the cache / SRAM, but I don't see anything
making sure it's the case in the driver?

Maxime

--wwouytazosfvho63
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX89R5gAKCRDj7w1vZxhR
xeFUAQDcZZeVgm//dGhbQWPMt1dKcu+sWEouturNNHIfo+ZdkAD/TB5Mov4SPoOn
EnbhRNPpksqxyhx4WIXOTW4t5RX9jwA=
=VCjk
-----END PGP SIGNATURE-----

--wwouytazosfvho63--
