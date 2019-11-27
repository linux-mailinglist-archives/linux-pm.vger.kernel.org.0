Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F53D10B4B3
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2019 18:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfK0Roh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Nov 2019 12:44:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:34304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726947AbfK0Roh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 27 Nov 2019 12:44:37 -0500
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2ECAE2071E;
        Wed, 27 Nov 2019 17:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574876676;
        bh=0mnbkXpRIAs1oWs7887fZ1hqjmi1n2cupNv6F6qcqnM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NVvBMB3wRKTxMbLvW7a7orEuxSa5qmKwIzhQPwJEA1hcD6wtHcM+iBbi2g12emuJU
         uB3XB7t7NFQXZT8q4MH4UiBt1ALildwE7zg/wS2PR1F0vre2NXqdxkNdu7oayb0qlF
         3D9AdyA4pjS85SjD7oeKkaiCzB5oYB9gDNB4U4zo=
Date:   Wed, 27 Nov 2019 18:44:34 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     Yangtao Li <tiny.windzz@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/7] dt-bindings: thermal: add YAML schema for
 sun8i-thermal driver bindings
Message-ID: <20191127174434.wousbqosmm5vxcsu@gilmour.lan>
References: <20191127052935.1719897-1-anarsoul@gmail.com>
 <20191127052935.1719897-3-anarsoul@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vy5yg3fxo523fkw5"
Content-Disposition: inline
In-Reply-To: <20191127052935.1719897-3-anarsoul@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--vy5yg3fxo523fkw5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Tue, Nov 26, 2019 at 09:29:30PM -0800, Vasily Khoruzhick wrote:
> From: Yangtao Li <tiny.windzz@gmail.com>
>
> sun8i-thermal driver supports thermal sensor in wide range of Allwinner
> SoCs. Add YAML schema for its bindings.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  .../thermal/allwinner,sun8i-a83t-ths.yaml     | 103 ++++++++++++++++++
>  1 file changed, 103 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
>
> diff --git a/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
> new file mode 100644
> index 000000000000..e622f0a4be90
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
> @@ -0,0 +1,103 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/allwinner,sun8i-a83t-ths.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Allwinner SUN8I Thermal Controller Device Tree Bindings
> +
> +maintainers:
> +  - Yangtao Li <tiny.windzz@gmail.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: allwinner,sun8i-a83t-ths
> +      - const: allwinner,sun8i-h3-ths
> +      - const: allwinner,sun8i-r40-ths
> +      - const: allwinner,sun50i-a64-ths
> +      - const: allwinner,sun50i-h5-ths
> +      - const: allwinner,sun50i-h6-ths
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
> +    minItems: 1
> +    maxItems: 2
> +
> +  clock-names:
> +    anyOf:
> +      - items:
> +        - const: bus
> +        - const: mod
> +      - items:
> +        - const: bus

This can be:

clock-names:
  minItems: 1
  maxItems: 2
  items:
    - const: bus
    - const: mod

And the length should be checked based on the compatible value, with
something like

if:
  properties:
    compatible:
      contains:
        const: allwinner,sun50i-h6-ths

then:
  properties:
    clocks:
      maxItems: 1

    clock-names:
      maxItems: 1

else:
  properties:
    clocks:
      maxItems: 2

    clock-names:
      maxItems: 2

> +
> +  '#thermal-sensor-cells':
> +    enum: [ 0, 1 ]
> +    description: |
> +      Definition depends on soc version:
> +
> +      For "allwinner,sun8i-h3-ths",
> +      value must be 0.
> +      For all other compatibles
> +      value must be 1.

This should be checked using an if as well.

> +
> +  nvmem-cells:
> +    maxItems: 1
> +    items:
> +      - description: Calibration data for thermal sensors

You can drop the items and just move the description up one level,
under nvmem-cells

> +
> +  nvmem-cell-names:
> +    items:
> +      - const: calibration

Ditto for the const

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - '#thermal-sensor-cells'

Whether clocks, clock-names and resets are thereshould be check using
an if statement as well.

> +
> +examples:
> +  - |
> +    ths_a83t: ths@1f04000 {

You don't need the label at all, and the node name should be
temperature-sensor according to the DT spec, not ths. This applies to
all you examples.

> +         compatible = "allwinner,sun8i-a83t-ths";
> +         reg = <0x01f04000 0x100>;
> +         interrupts = <0 31 0>;
> +         nvmem-cells = <&ths_calibration>;
> +         nvmem-cell-names = "calibration";
> +         #thermal-sensor-cells = <1>;
> +    };

New line.

Thanks!
Maxime

--vy5yg3fxo523fkw5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXd62AgAKCRDj7w1vZxhR
xZhDAP92TopSGYK0i/lNbBksUI+7RNfvt+FhK2eVaXRB2/XToAD/S4RzDGUA4BXe
Cx5DhAlOJY+WchG8X6c4StMtLQAUwAM=
=6CMd
-----END PGP SIGNATURE-----

--vy5yg3fxo523fkw5--
