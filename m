Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F22511E7FD
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2019 17:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbfLMQTa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Dec 2019 11:19:30 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:38723 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728120AbfLMQTa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Dec 2019 11:19:30 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 3998822622;
        Fri, 13 Dec 2019 11:19:29 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 13 Dec 2019 11:19:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=i/sJlT3h4PqYR1UBpYvuE7hMhIl
        2DqqsDFyV/lXybms=; b=jfu4oP1aKuqCdMEwgYngaJDa9U7roo1n+eeU4/aoi0k
        TRKOHuW0/CsvGXA2Bs9ZvgsHL6nVYwW5XPkzheiJ3Pq7LKUdMIUC/vv1ec3w+Tcu
        SsxyrrpGGwlAHOHf0aFi1sPH9caZnCsUen9SRRI7Z6uq3gurGgJiztjVka3a06/v
        Ji0xNujwQuzaLIJ80Qn10oRBkvHE9ssHVaY+zQQodp4FfBKNuqr62LQ8j6ojuPa2
        eNxUbLzcqb35nz+ZmNZJOEutZT1CpKlDyxwubYJPjMJ3WZ6okVu6ZnLf6L7qcq+V
        njHLCC4+Udvhve4x6XBfTA3L+lWm66ygmNA/0qNIwuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=i/sJlT
        3h4PqYR1UBpYvuE7hMhIl2DqqsDFyV/lXybms=; b=mW8j3UAf+WwTiSoteltXS1
        JRXjgzusHb6YnqnXhQmzR+JhUCepYza6Vgl6jeQ6yWhWeF7tWMmUvKhgN4gSgAno
        tBpG6XCjmjuwmEfazOUDJStfbe1ZpcWRDuOKnHSB+vkRUnuZV80RNqytyhRYg/4Z
        txwntd4x4uKlPirQSlj6vesmymRt8DRfMa/Ub2adBnzsWCXsUTAbUAQOgPfCZjDL
        Ep+YziByHWGF53ILnTqXmFZJZBHwKNn/Qu4YNcgbiy+WFLYS2yTtrzhFGPiHDg2J
        AqrXoZsm9xibZiAP5oYgiQAILtKgwxuk9fIp34Ygu9V2hz484Z/3zE+J4vfYQ/4Q
        ==
X-ME-Sender: <xms:ELrzXeBpoi74QceTsJEZS3N3BY_0bqt8s2lY0Ha4rl9ysTs25s8X9Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudelledgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuffhomhgrih
    hnpeguvghvihgtvghtrhgvvgdrohhrghenucfkphepledtrdekledrieekrdejieenucfr
    rghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthhenucevlh
    hushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:ELrzXZDbLCT0L1pDKNkow7Cggp162UEAdWdbS04grjpguauP9ioQ6Q>
    <xmx:ELrzXTTGhBZfWkquWRA0mccMgn9NuhKgQ87ZP9lZ_h6l0G6QveUAWw>
    <xmx:ELrzXYJRLEMyLH1exHjLyOS9iUBrBXA1H8Y-SJoed1jYrYgFw8nW3w>
    <xmx:EbrzXasrmNccCzG3Kqr3P6SDqKKONesjtKdFFODG-Yxva4tRD-u2bg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 246178005B;
        Fri, 13 Dec 2019 11:19:28 -0500 (EST)
Date:   Fri, 13 Dec 2019 17:19:25 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Frank Lee <tiny.windzz@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        georgi.djakov@linaro.org, Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: interconnect: Convert Allwinner MBUS
 controller to a schema
Message-ID: <20191213161925.33zaksfs5qnfmsdg@gilmour.lan>
References: <20191213074533.27048-1-maxime@cerno.tech>
 <CAEExFWunpXqKDyxqhHGJhtcQ7pwEYkWL0wvwUp==_jrd9wACbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dm365wf27dl23ps2"
Content-Disposition: inline
In-Reply-To: <CAEExFWunpXqKDyxqhHGJhtcQ7pwEYkWL0wvwUp==_jrd9wACbQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--dm365wf27dl23ps2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 13, 2019 at 11:41:46PM +0800, Frank Lee wrote:
> On Fri, Dec 13, 2019 at 3:45 PM Maxime Ripard <maxime@cerno.tech> wrote:
> >
> > The older Allwinner SoCs have an MBUS controller that is used by Linux,
> > with a matching Device Tree binding.
> >
> > Now that we have the DT validation in place, let's convert the device tree
> > bindings for that controller over to a YAML schemas.
> >
> > Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> > ---
> >  .../arm/sunxi/allwinner,sun4i-a10-mbus.yaml   | 65 +++++++++++++++++++
> >  .../bindings/arm/sunxi/sunxi-mbus.txt         | 37 -----------
> >  2 files changed, 65 insertions(+), 37 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-mbus.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/arm/sunxi/sunxi-mbus.txt
> >
> > diff --git a/Documentation/devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-mbus.yaml b/Documentation/devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-mbus.yaml
> > new file mode 100644
> > index 000000000000..9370e64992dd
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-mbus.yaml
> > @@ -0,0 +1,65 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/arm/sunxi/allwinner,sun4i-a10-mbus.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Allwinner Memory Bus (MBUS) controller
> > +
> > +maintainers:
> > +  - Chen-Yu Tsai <wens@csie.org>
> > +  - Maxime Ripard <mripard@kernel.org>
> > +
> > +description: |
> > +  The MBUS controller drives the MBUS that other devices in the SoC
> > +  will use to perform DMA. It also has a register interface that
> > +  allows to monitor and control the bandwidth and priorities for
> > +  masters on that bus.
> > +
> > +  Each device having to perform their DMA through the MBUS must have
> > +  the interconnects and interconnect-names properties set to the MBUS
> > +  controller and with "dma-mem" as the interconnect name.
> > +
> > +properties:
> > +  "#interconnect-cells":
> > +    const: 1
> > +    description:
> > +      The content of the cell is the MBUS ID.
> > +
> > +  compatible:
> > +    enum:
> > +      - allwinner,sun5i-a13-mbus
> > +      - allwinner,sun8i-h3-mbus
>
> Is there a driver in mainline  for it?

Not at teh moment no, it's sole use is to have the proper DMA address
translation.

Maxime

--dm365wf27dl23ps2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXfO6DQAKCRDj7w1vZxhR
xYrQAQDfnp9gbWFABgHdloSvQY2r8OTEvv+XUvBW+BsjRIHM2AEAppHqNrLxKgzQ
02TE4LlOiiQS4mM3Zb76f5b6uaHfug4=
=nNdB
-----END PGP SIGNATURE-----

--dm365wf27dl23ps2--
