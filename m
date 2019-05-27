Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E416E2B4C2
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2019 14:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbfE0MQd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 May 2019 08:16:33 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:48139 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbfE0MQd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 May 2019 08:16:33 -0400
Received: from localhost (aaubervilliers-681-1-27-134.w90-88.abo.wanadoo.fr [90.88.147.134])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 17976240018;
        Mon, 27 May 2019 12:16:24 +0000 (UTC)
Date:   Mon, 27 May 2019 14:16:24 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, wens@csie.org, davem@davemloft.net,
        mchehab+samsung@kernel.org, gregkh@linuxfoundation.org,
        linus.walleij@linaro.org, nicolas.ferre@microchip.com,
        paulmck@linux.ibm.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: thermal: add binding document for h6
 thermal controller
Message-ID: <20190527121624.5qwrrzc4whrddbbe@flea>
References: <20190525181329.18657-1-tiny.windzz@gmail.com>
 <20190525181329.18657-3-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5l3rwiguuszwblyx"
Content-Disposition: inline
In-Reply-To: <20190525181329.18657-3-tiny.windzz@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--5l3rwiguuszwblyx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Thanks for working on this!

On Sat, May 25, 2019 at 02:13:28PM -0400, Yangtao Li wrote:
> This patch adds binding document for allwinner h6 thermal controller.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  .../bindings/thermal/sun8i-thermal.yaml       | 71 +++++++++++++++++++
>
>  1 file changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/sun8i-thermal.yaml
>
> diff --git a/Documentation/devicetree/bindings/thermal/sun8i-thermal.yaml b/Documentation/devicetree/bindings/thermal/sun8i-thermal.yaml
> new file mode 100644
> index 000000000000..54cf1277870e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/sun8i-thermal.yaml
> @@ -0,0 +1,71 @@
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
> +    items:
> +      - description: ths bus clock
> +
> +  clock-names:
> +    items:
> +      - const: bus

You don't need the items here, you can just do:

clocks:
  maxItems: 1
  description:
    Bus clock

clock-names:
  const: bus

> +  "#thermal-sensor-cells":
> +    enum: [ 0, 1 ]

You should document when you would need one or the other.

My guess is that you did it that way to deal with the A33? If so, we
can just request the cell size to be 1 for now, and then expand it to
an enum later on when we'll support the A33.

> +  nvmem-cells:
> +    items:
> +      - description: ths calibrate data
> +
> +  nvmem-cell-names:
> +    items:
> +      - const: calib

Same remark than for the clocks

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - reset
> +  - clocks
> +  - clock-names

I guess you'd need #thermal-sensor-cells too?

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--5l3rwiguuszwblyx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXOvVGAAKCRDj7w1vZxhR
xYJvAQDS6LCy+f//B51XcJuEuSglOnKVFXxiNHV/4yLfVTR9lQD+Ory2sL/zzJ11
NK/Cfa5T1w6p+sdl9MDDkpaVkRt9GQ8=
=mlQq
-----END PGP SIGNATURE-----

--5l3rwiguuszwblyx--
