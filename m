Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 677EF8FF64
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2019 11:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfHPJrn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Aug 2019 05:47:43 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:56769 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726993AbfHPJrm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Aug 2019 05:47:42 -0400
X-Originating-IP: 86.250.200.211
Received: from localhost (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 1026C60005;
        Fri, 16 Aug 2019 09:47:36 +0000 (UTC)
Date:   Fri, 16 Aug 2019 11:47:36 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Frank Lee <tiny.windzz@gmail.com>
Cc:     rui.zhang@intel.com, Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan.Cameron@huawei.com,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 02/18] dt-bindings: thermal: add binding document for
 h6 thermal controller
Message-ID: <20190816094736.cbxkqk7q2jvvp7c7@flea>
References: <20190810052829.6032-1-tiny.windzz@gmail.com>
 <20190810052829.6032-3-tiny.windzz@gmail.com>
 <20190812085604.ozhl35wwm3ehlvqn@flea>
 <CAEExFWswLiFknVpBEKF9c5yoFvvA4np-ivWYkQLcteYoM8qjfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="e3oyg4ksww5uov3y"
Content-Disposition: inline
In-Reply-To: <CAEExFWswLiFknVpBEKF9c5yoFvvA4np-ivWYkQLcteYoM8qjfg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--e3oyg4ksww5uov3y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 13, 2019 at 07:40:44AM +0800, Frank Lee wrote:
> On Mon, Aug 12, 2019 at 4:56 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > On Sat, Aug 10, 2019 at 05:28:13AM +0000, Yangtao Li wrote:
> > > This patch adds binding document for allwinner h6 thermal controller.
> > >
> > > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > > ---
> > >  .../bindings/thermal/sun8i-thermal.yaml       | 79 +++++++++++++++++++
> > >  1 file changed, 79 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/thermal/sun8i-thermal.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/thermal/sun8i-thermal.yaml b/Documentation/devicetree/bindings/thermal/sun8i-thermal.yaml
> > > new file mode 100644
> > > index 000000000000..e0973199ba3c
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/thermal/sun8i-thermal.yaml
> >
> > We've used so far for the schemas the first compatible to introduce
> > that controller as the filename, we should be consistent here. In that
> > case that would be allwinner,sun8i-a23-ths.yaml
> >
> > > @@ -0,0 +1,79 @@
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/thermal/sun8i-thermal.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Allwinner SUN8I Thermal Controller Device Tree Bindings
> > > +
> > > +maintainers:
> > > +  - Yangtao Li <tiny.windzz@gmail.com>
> > > +
> > > +description: |-
> > > +  This describes the device tree binding for the Allwinner thermal
> > > +  controller which measures the on-SoC temperatures.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
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
> > > +  clocks:
> > > +    maxItems: 1
> > > +
> > > +  clock-names:
> > > +    const: bus
> > > +
> > > +  "#thermal-sensor-cells":
> > > +    const: 1
> > > +
> > > +  nvmem-cells:
> >
> > You need a maxItems here too
> >
> > > +    description: ths calibrate data
> >
> > What about something like this:
> >
> > Calibration data for the thermal sensor
> >
> > > +
> > > +  nvmem-cell-names:
> > > +    const: calib
> >
> > I'm not sure we need a abbreviation here, calibration would be more
> > explicit
> >
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - reset
> > > +  - clocks
> > > +  - clock-names
> > > +  - interrupts
> > > +  - "#thermal-sensor-cells"
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    ths: ths@5070400 {
> > > +        compatible = "allwinner,sun50i-h6-ths";
> > > +        reg = <0x05070400 0x100>;
> > > +        clocks = <&ccu CLK_BUS_THS>;
> > > +        clock-names = "bus";
> > > +        resets = <&ccu RST_BUS_THS>;
> > > +        interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
> >
> > Those examples won't compile.
>
> Emmm, I have some questions about this.
> I added this information and it can be compiled.

With your patch applied,

$ ARCH=arm DT_SCHEMA_FILES=Documentation/devicetree/bindings/thermal/sun8i-thermal.yaml make -j4 dt_binding_check
  CHKDT   Documentation/devicetree/bindings/thermal/sun8i-thermal.yaml
  DTC     Documentation/devicetree/bindings/thermal/sun8i-thermal.example.dt.yaml
Error: Documentation/devicetree/bindings/thermal/sun8i-thermal.example.dts:20.28-29 syntax error
FATAL ERROR: Unable to parse input tree
make[2]: *** [scripts/Makefile.lib:299: Documentation/devicetree/bindings/thermal/sun8i-thermal.example.dt.yaml] Error 1
make[1]: *** [/home/max/Work/src/linux/Makefile:1286: dt_binding_check] Error 2
make: *** [/home/max/Work/src/linux/Makefile:179: sub-make] Error 2

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--e3oyg4ksww5uov3y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXVZ7uAAKCRDj7w1vZxhR
xWTKAQDfLyzi2ALbODyX2kPcPMmaLcp2tRh8IqLRMr6zqYgqDgD/dgWM62HXzihe
5V5fiOFI853nEXxoNxr4cglIprifmAw=
=nc3f
-----END PGP SIGNATURE-----

--e3oyg4ksww5uov3y--
