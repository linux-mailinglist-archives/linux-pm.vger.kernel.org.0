Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFEE125D5A
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 10:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbfLSJMq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 04:12:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:37064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726599AbfLSJMq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 19 Dec 2019 04:12:46 -0500
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82AEC21D7D;
        Thu, 19 Dec 2019 09:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576746765;
        bh=ZbxHfG9y4vIMWKbc3+hFLIbewsQNOoX8QrADlrcLuWU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t2alWsEOvF8DCjRjimhRTAdpzJWLpz/GTNQyHJISxzvJfKdtGuDmaCglDwOgE1Lyf
         XOnOercEVcK2Pu111Fo+Q42qArfYxIvHSt3BQTYvn0p6XEfrpnsG1PhyUTwDbGlrXV
         kbtmCaSBCgmtTdaviJG/wPa3SO3LE2F5sTLB/YFc=
Date:   Thu, 19 Dec 2019 10:12:42 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     Yangtao Li <tiny.windzz@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-linux <linux-arm-kernel@lists.infradead.org>,
        =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 2/7] dt-bindings: thermal: add YAML schema for
 sun8i-thermal driver bindings
Message-ID: <20191219091242.a3etnhybf3sfrmf5@gilmour.lan>
References: <20191218042121.1471954-1-anarsoul@gmail.com>
 <20191218042121.1471954-3-anarsoul@gmail.com>
 <20191218220037.4g6pzdvrhroaj4qu@gilmour.lan>
 <CA+E=qVdfV5LKBEar8eT286+ADrpygEkbe5OX1GVRw+khatrJhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fd7bvdcala2bzv3x"
Content-Disposition: inline
In-Reply-To: <CA+E=qVdfV5LKBEar8eT286+ADrpygEkbe5OX1GVRw+khatrJhA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--fd7bvdcala2bzv3x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 18, 2019 at 02:27:00PM -0800, Vasily Khoruzhick wrote:
> On Wed, Dec 18, 2019 at 2:00 PM Maxime Ripard <mripard@kernel.org> wrote:
> > On Tue, Dec 17, 2019 at 08:21:16PM -0800, Vasily Khoruzhick wrote:
> > > From: Yangtao Li <tiny.windzz@gmail.com>
> > >
> > > sun8i-thermal driver supports thermal sensor in wide range of Allwinner
> > > SoCs. Add YAML schema for its bindings.
> > >
> > > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> > > ---
> > >  .../thermal/allwinner,sun8i-a83t-ths.yaml     | 146 ++++++++++++++++++
> > >  1 file changed, 146 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
> > > new file mode 100644
> > > index 000000000000..8768c2450633
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
> > > @@ -0,0 +1,146 @@
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/thermal/allwinner,sun8i-a83t-ths.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Allwinner SUN8I Thermal Controller Device Tree Bindings
> > > +
> > > +maintainers:
> > > +  - Yangtao Li <tiny.windzz@gmail.com>
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - allwinner,sun8i-a83t-ths
> > > +      - allwinner,sun8i-h3-ths
> > > +      - allwinner,sun8i-r40-ths
> > > +      - allwinner,sun50i-a64-ths
> > > +      - allwinner,sun50i-h5-ths
> > > +      - allwinner,sun50i-h6-ths
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  interrupts:
> > > +    maxItems: 1
> > > +
> > > +  resets:
> > > +    maxItems: 1
> > > +
> > > +  nvmem-cells:
> > > +    maxItems: 1
> > > +    description: Calibration data for thermal sensors
> > > +
> > > +  nvmem-cell-names:
> > > +    const: calibration
> > > +
> > > +allOf:
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            const: allwinner,sun50i-h6-ths
> > > +
> > > +    then:
> > > +      properties:
> > > +        clocks:
> > > +          minItems: 1
> > > +          maxItems: 1
> >
> > When minItems and maxItems are equal, you can only set one, the other
> > will be filled automatically.
>
> Is it documented anywhere? I have a feeling like I'm shooting in the
> dark. So far I've read Documentation/devicetree/writing-schema.rst,
> Documentation/devicetree/bindings/example-schema.yaml and few other
> schemas for inspiration but yet I don't have solid understanding how
> it's supposed to be written. Examples are pretty scarce and figuring
> out why certain construction doesn't work is pretty tricky.

It's somewhat documented with
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/example-schema.yaml#n80
and
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/example-schema.yaml#n102

But I guess it wasn't clear enough? Feel free to update it to
something that would be better

Maxime

--fd7bvdcala2bzv3x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXfs/CgAKCRDj7w1vZxhR
xWnZAQDQjjz1zdDw2o0CKbXeWoqNzvCd9sNbulu3JkcPz9GjDAD/Z9Zm7vB9ZgYg
ilf8Y1BHYMty/J1hDT69ZHP/Ayu9PgY=
=KdAM
-----END PGP SIGNATURE-----

--fd7bvdcala2bzv3x--
