Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDF4712561E
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2019 23:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfLRWAl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Dec 2019 17:00:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:44214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726598AbfLRWAk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 18 Dec 2019 17:00:40 -0500
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C43E2146E;
        Wed, 18 Dec 2019 22:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576706439;
        bh=BHrAQFIGbbIvTg9mW+NwpWTBkboWudvsPo35DCHjyKU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aUiiz0YBKuuTNqGtZUBFxpAtyAvA7wMfZV6DH+GQ/h96SUDYnp49gpjr195CweqU8
         jR/OTEUynai/TzIMVUvyBnqfuvp4CYlm2PzeJtATAsKDvbY8YeAkhkMIJxjWsgpe+z
         YWT6uZAFFiGY72eQYemkOy+F2LVxbpBfyKJMQbGE=
Date:   Wed, 18 Dec 2019 23:00:37 +0100
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
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/7] dt-bindings: thermal: add YAML schema for
 sun8i-thermal driver bindings
Message-ID: <20191218220037.4g6pzdvrhroaj4qu@gilmour.lan>
References: <20191218042121.1471954-1-anarsoul@gmail.com>
 <20191218042121.1471954-3-anarsoul@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nfb3broi25z4qfbb"
Content-Disposition: inline
In-Reply-To: <20191218042121.1471954-3-anarsoul@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--nfb3broi25z4qfbb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Tue, Dec 17, 2019 at 08:21:16PM -0800, Vasily Khoruzhick wrote:
> From: Yangtao Li <tiny.windzz@gmail.com>
>
> sun8i-thermal driver supports thermal sensor in wide range of Allwinner
> SoCs. Add YAML schema for its bindings.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  .../thermal/allwinner,sun8i-a83t-ths.yaml     | 146 ++++++++++++++++++
>  1 file changed, 146 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
>
> diff --git a/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
> new file mode 100644
> index 000000000000..8768c2450633
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
> @@ -0,0 +1,146 @@
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
> +    enum:
> +      - allwinner,sun8i-a83t-ths
> +      - allwinner,sun8i-h3-ths
> +      - allwinner,sun8i-r40-ths
> +      - allwinner,sun50i-a64-ths
> +      - allwinner,sun50i-h5-ths
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
> +  nvmem-cells:
> +    maxItems: 1
> +    description: Calibration data for thermal sensors
> +
> +  nvmem-cell-names:
> +    const: calibration
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: allwinner,sun50i-h6-ths
> +
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 1
> +          maxItems: 1

When minItems and maxItems are equal, you can only set one, the other
will be filled automatically.

> +
> +        clock-names:
> +          minItems: 1
> +          maxItems: 1
> +          items:
> +            - const: bus

And this can even be just

clock-names:
  const: bus

> +
> +    else:
> +      properties:
> +        clocks:
> +          minItems: 1
> +          maxItems: 2
> +
> +        clock-names:
> +          minItems: 1
> +          maxItems: 2
> +          items:
> +            - const: bus
> +            - const: mod

I'm not sure why you need the minItems set to 1 here though?

it's always 2 for the !H6 case, right?

if so, then we should even do something like:

properties:
  ...

  # This is needed because we will need to check both the H6 and !H6
  # case, and it must validate. So we make sure we match against the
  # union of both cases.
  clocks:
    minItems: 1
    maxItems: 2
    items:
      - description: Bus Clock
      - description: Module Clock

  # Same story here
  clock-names:
    minItems: 1
    maxItems: 2
    items:
      - const: bus
      - const: mod

allOf:
  - if:
    properties:
      compatible:
        contains:
	  const: allwinner,sun50i-h6-ths

    # Here we validate in the H6 case we only have one clock
    then:
      properties:
        clocks:
	  maxItems: 1

        clock-names:
	  maxItems: 1

    # and here that in the other case we have two clocks, the names
    # being validated by the schema above
    else:
      properties:
        clocks:
	  maxItems: 2

        clock-names:
	  maxItems: 2

# And now we can set this since all our properties will have been
# expressed in the upper level schema
additionalProperties: false

> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: allwinner,sun8i-h3-ths
> +
> +    then:
> +      properties:
> +        "#thermal-sensor-cells":
> +          const: 0
> +
> +    else:
> +      properties:
> +        "#thermal-sensor-cells":
> +          const: 1

Same thing here, you should have an enum accepting both values in the
upper schema, the condition here only making further checks. Also, in
the case where #thermal-sensor-cells is one, then you need to document
what that argument is.

Thanks!
Maxime

--nfb3broi25z4qfbb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXfqhhQAKCRDj7w1vZxhR
xWvSAQCi6mjrJCTS8SWPU7PcgNEc6pA17UBJm2Xk4XKoLO7m6wD9EPOHRneAtdBr
BtJRS/RwZk8fGlXI46Xa48uRjngLqw4=
=F0Nc
-----END PGP SIGNATURE-----

--nfb3broi25z4qfbb--
