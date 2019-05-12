Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0BF51AC7B
	for <lists+linux-pm@lfdr.de>; Sun, 12 May 2019 15:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbfELNmB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 12 May 2019 09:42:01 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:41755 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbfELNmB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 May 2019 09:42:01 -0400
X-Originating-IP: 109.190.253.16
Received: from localhost (unknown [109.190.253.16])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 8AE6DE0005;
        Sun, 12 May 2019 13:41:53 +0000 (UTC)
Date:   Sun, 12 May 2019 15:41:52 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, wens@csie.org, catalin.marinas@arm.com,
        will.deacon@arm.com, davem@davemloft.net,
        mchehab+samsung@kernel.org, gregkh@linuxfoundation.org,
        Jonathan.Cameron@huawei.com, nicolas.ferre@microchip.com,
        paulmck@linux.ibm.com, andy.gross@linaro.org, olof@lixom.net,
        bjorn.andersson@linaro.org, jagan@amarulasolutions.com,
        marc.w.gonzalez@free.fr, stefan.wahren@i2se.com,
        enric.balletbo@collabora.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: thermal: add binding document for h6
 thermal controller
Message-ID: <20190512134152.yrletgtiglxncyo4@flea>
References: <20190512082614.9045-1-tiny.windzz@gmail.com>
 <20190512082614.9045-4-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ahljv2wucenn7ylv"
Content-Disposition: inline
In-Reply-To: <20190512082614.9045-4-tiny.windzz@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--ahljv2wucenn7ylv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Sun, May 12, 2019 at 04:26:14AM -0400, Yangtao Li wrote:
> This patch adds binding document for allwinner h6 thermal controller.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  .../bindings/thermal/sun50i-thermal.txt       | 32 +++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/sun50i-thermal.txt

We're starting to convert to YAML for binding descriptions that will
allow to validate that all DT are properly using the binding. It would
be great if you could use it as well.

> diff --git a/Documentation/devicetree/bindings/thermal/sun50i-thermal.txt b/Documentation/devicetree/bindings/thermal/sun50i-thermal.txt
> new file mode 100644
> index 000000000000..67eda7794262
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/sun50i-thermal.txt
> @@ -0,0 +1,32 @@
> +Binding for Thermal Sensor of Allwinner SOC.
> +
> +This describes the device tree binding for the Allwinner thermal controller
> +which measures the on-SoC temperatures.
> +
> +Required properties:
> +- compatible:
> +  - "allwinner,sun50i-h6-ths" : For H6
> +- reg: Address range of the thermal controller
> +- clocks, clock-names: Clocks needed for the thermal controller.
> +		       The required clocks for h6 are: "bus".

If there's a single clock, then we don't need clock-names

> +- resets, reset-names: Reference to the reset controller controlling
> +		       the thermal controller.

Ditto.

> +- nvmem-cells: A phandle to the calibration data provided by a nvmem device. If
> +	       unspecified default values shall be used.
> +- nvmem-cell-names: Should be "calib"

I thought you said that nvmem support was optional in the
driver. Maybe we could make it optional in the DT too?

Thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ahljv2wucenn7ylv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXNgioAAKCRDj7w1vZxhR
xXgAAP9K2xJnOzxte2sR5B23CXZbzrx5rlhRaXia5y6fdipxGQD+JTw1nNbgTjV+
hD+q/NKIiRukijuarNG8O3iM1Nov6wI=
=TJRY
-----END PGP SIGNATURE-----

--ahljv2wucenn7ylv--
