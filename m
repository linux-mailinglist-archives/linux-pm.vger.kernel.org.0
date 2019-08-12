Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0632789911
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2019 10:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfHLI4M (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Aug 2019 04:56:12 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:40435 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbfHLI4M (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Aug 2019 04:56:12 -0400
X-Originating-IP: 86.250.200.211
Received: from localhost (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id E3E8460006;
        Mon, 12 Aug 2019 08:56:04 +0000 (UTC)
Date:   Mon, 12 Aug 2019 10:56:04 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, wens@csie.org, mchehab+samsung@kernel.org,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        Jonathan.Cameron@huawei.com, nicolas.ferre@microchip.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 02/18] dt-bindings: thermal: add binding document for
 h6 thermal controller
Message-ID: <20190812085604.ozhl35wwm3ehlvqn@flea>
References: <20190810052829.6032-1-tiny.windzz@gmail.com>
 <20190810052829.6032-3-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4zhzclyt6oncb76d"
Content-Disposition: inline
In-Reply-To: <20190810052829.6032-3-tiny.windzz@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--4zhzclyt6oncb76d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Aug 10, 2019 at 05:28:13AM +0000, Yangtao Li wrote:
> This patch adds binding document for allwinner h6 thermal controller.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  .../bindings/thermal/sun8i-thermal.yaml       | 79 +++++++++++++++++++
>  1 file changed, 79 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/sun8i-thermal.yaml
>
> diff --git a/Documentation/devicetree/bindings/thermal/sun8i-thermal.yaml b/Documentation/devicetree/bindings/thermal/sun8i-thermal.yaml
> new file mode 100644
> index 000000000000..e0973199ba3c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/sun8i-thermal.yaml

We've used so far for the schemas the first compatible to introduce
that controller as the filename, we should be consistent here. In that
case that would be allwinner,sun8i-a23-ths.yaml

> @@ -0,0 +1,79 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/sun8i-thermal.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Allwinner SUN8I Thermal Controller Device Tree Bindings
> +
> +maintainers:
> +  - Yangtao Li <tiny.windzz@gmail.com>
> +
> +description: |-
> +  This describes the device tree binding for the Allwinner thermal
> +  controller which measures the on-SoC temperatures.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - allwinner,sun50i-h6-ths
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: bus
> +
> +  "#thermal-sensor-cells":
> +    const: 1
> +
> +  nvmem-cells:

You need a maxItems here too

> +    description: ths calibrate data

What about something like this:

Calibration data for the thermal sensor

> +
> +  nvmem-cell-names:
> +    const: calib

I'm not sure we need a abbreviation here, calibration would be more
explicit

> +
> +required:
> +  - compatible
> +  - reg
> +  - reset
> +  - clocks
> +  - clock-names
> +  - interrupts
> +  - "#thermal-sensor-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    ths: ths@5070400 {
> +        compatible = "allwinner,sun50i-h6-ths";
> +        reg = <0x05070400 0x100>;
> +        clocks = <&ccu CLK_BUS_THS>;
> +        clock-names = "bus";
> +        resets = <&ccu RST_BUS_THS>;
> +        interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;

Those examples won't compile.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--4zhzclyt6oncb76d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXVEppAAKCRDj7w1vZxhR
xbePAQD4oGzekU98J4bCgNXtImN3X9EeDQ3DpYjvOJSUQtIlZgEAnRIw2ceIxFC7
AomJrBOwFCYE3Ly30TnJfIXLEPZvYAU=
=Si6e
-----END PGP SIGNATURE-----

--4zhzclyt6oncb76d--
