Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6A84334BB
	for <lists+linux-pm@lfdr.de>; Tue, 19 Oct 2021 13:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235291AbhJSLeB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Oct 2021 07:34:01 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46866 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbhJSLeA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Oct 2021 07:34:00 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 36B501F43268
Received: by earth.universe (Postfix, from userid 1000)
        id 571063C0CA8; Tue, 19 Oct 2021 13:31:44 +0200 (CEST)
Date:   Tue, 19 Oct 2021 13:31:44 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     David Heidelberg <david@ixit.cz>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~okias/devicetree@lists.sr.ht
Subject: Re: [PATCH] dt-bindings: power: reset: gpio-poweroff: Convert txt
 bindings to yaml
Message-ID: <20211019113144.77zhcagw6lvwmfjy@earth.universe>
References: <20211009163226.45564-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tyn6d3fmh7rrtjqg"
Content-Disposition: inline
In-Reply-To: <20211009163226.45564-1-david@ixit.cz>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--tyn6d3fmh7rrtjqg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Oct 09, 2021 at 06:32:26PM +0200, David Heidelberg wrote:
> Convert power-off action connected to the GPIO documentation to the YAML =
syntax.
>=20
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  .../bindings/power/reset/gpio-poweroff.txt    | 41 ------------
>  .../bindings/power/reset/gpio-poweroff.yaml   | 64 +++++++++++++++++++
>  2 files changed, 64 insertions(+), 41 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/power/reset/gpio-po=
weroff.txt
>  create mode 100644 Documentation/devicetree/bindings/power/reset/gpio-po=
weroff.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/power/reset/gpio-poweroff.=
txt b/Documentation/devicetree/bindings/power/reset/gpio-poweroff.txt
> deleted file mode 100644
> index 3e56c1b34a4c..000000000000
> --- a/Documentation/devicetree/bindings/power/reset/gpio-poweroff.txt
> +++ /dev/null
> @@ -1,41 +0,0 @@
> -Driver a GPIO line that can be used to turn the power off.
> -
> -The driver supports both level triggered and edge triggered power off.
> -At driver load time, the driver will request the given gpio line and
> -install a handler to power off the system. If the optional properties
> -'input' is not found, the GPIO line will be driven in the inactive
> -state. Otherwise its configured as an input.
> -
> -When the power-off handler is called, the gpio is configured as an
> -output, and drive active, so triggering a level triggered power off
> -condition. This will also cause an inactive->active edge condition, so
> -triggering positive edge triggered power off. After a delay of 100ms,
> -the GPIO is set to inactive, thus causing an active->inactive edge,
> -triggering negative edge triggered power off. After another 100ms
> -delay the GPIO is driver active again. If the power is still on and
> -the CPU still running after a 3000ms delay, a WARN_ON(1) is emitted.
> -
> -Required properties:
> -- compatible : should be "gpio-poweroff".
> -- gpios : The GPIO to set high/low, see "gpios property" in
> -  Documentation/devicetree/bindings/gpio/gpio.txt. If the pin should be
> -  low to power down the board set it to "Active Low", otherwise set
> -  gpio to "Active High".
> -
> -Optional properties:
> -- input : Initially configure the GPIO line as an input. Only reconfigure
> -  it to an output when the power-off handler is called. If this optional
> -  property is not specified, the GPIO is initialized as an output in its
> -  inactive state.
> -- active-delay-ms: Delay (default 100) to wait after driving gpio active
> -- inactive-delay-ms: Delay (default 100) to wait after driving gpio inac=
tive
> -- timeout-ms: Time to wait before asserting a WARN_ON(1). If nothing is
> -              specified, 3000 ms is used.
> -
> -Examples:
> -
> -gpio-poweroff {
> -	compatible =3D "gpio-poweroff";
> -	gpios =3D <&gpio 4 0>;
> -	timeout-ms =3D <3000>;
> -};
> diff --git a/Documentation/devicetree/bindings/power/reset/gpio-poweroff.=
yaml b/Documentation/devicetree/bindings/power/reset/gpio-poweroff.yaml
> new file mode 100644
> index 000000000000..50ae0cec6493
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/reset/gpio-poweroff.yaml
> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/reset/gpio-poweroff.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Driver a GPIO line that can be used to turn the power off

This is a DT binding, not kernel driver documentation. Title should
be something like

title: GPIO controlled power off

> +
> +maintainers:
> +  - Sebastian Reichel <sre@kernel.org>
> +
> +description:
> +  The driver supports both level triggered and edge triggered power off.
> +  At driver load time, the driver will request the given gpio line and
> +  install a handler to power off the system. If the optional properties
> +  'input' is not found, the GPIO line will be driven in the inactive
> +  state. Otherwise its configured as an input.
> +
> +  When the power-off handler is called, the gpio is configured as an
> +  output, and drive active, so triggering a level triggered power off
> +  condition. This will also cause an inactive->active edge condition, so
> +  triggering positive edge triggered power off. After a delay of 100ms,
> +  the GPIO is set to inactive, thus causing an active->inactive edge,
> +  triggering negative edge triggered power off. After another 100ms
> +  delay the GPIO is driver active again. If the power is still on and
> +  the CPU still running after a 3000ms delay, a WARN_ON(1) is emitted.

This description is quite Linux specific. I think it should be
easily possible to fix that:

System power off support via a GPIO line. When a shutdown is
executed the operating system is expected to switch the GPIO
=66rom inactive to active. After a delay (active-delay-ms) it
is expected to be switched back to inactive. After another
delay (inactive-delay-ms) it is configured as active again.
Finally the operating system assumes the power off failed if
the system is still running after waiting some time (timeout-ms).

> +properties:
> +  compatible:
> +    const: gpio-poweroff
> +
> +  gpios: true

maxItems: 1

> +
> +  input:
> +    description: |
> +      Initially configure the GPIO line as an input. Only reconfigure
> +      it to an output when the power-off handler is called. If this opti=
onal

type: boolean

s/handler is called/power off sequence is initiated/

> +      property is not specified, the GPIO is initialized as an output in=
 its inactive state.
> +
> +  active-delay-ms:
> +    default: 100
> +    description: Delay to wait after driving gpio active
> +
> +  inactive-delay-ms:
> +    default: 100
> +    description: Delay to wait after driving gpio inactive
> +
> +  timeout-ms:
> +    default: 3000
> +    description: Time to wait before asserting a WARN_ON(1).

Time to wait before assuming the power off sequence failed.

> +required:
> +  - compatible
> +  - gpios
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    gpio-poweroff {
> +        compatible =3D "gpio-poweroff";
> +        gpios =3D <&gpio 4 0>;
> +        timeout-ms =3D <3000>;
> +    };

Thanks,

-- Sebastian

--tyn6d3fmh7rrtjqg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmFurJkACgkQ2O7X88g7
+ppsbA/+KkgU4fyrWct6l/7zcBjWYuWDAeOb/1WjcRN6RcDWaLlf1JMVo+NCTUhj
v0brN6mzdNQnGKVnzWypjPL3BZCrxu/RYdaMoBYoCqvMjRDd4k+w9sC4XloA6ByL
Dhmz3o21GyFGxerk4H1M04+lcJkZIfE+skWbImDHRoSgpugPJC5xCMMlthoeUAmO
w1kHomDT3yl1ZJjM0VFOc963zm7sreHUDksCuI7/eZTw4d9VcNnnnNnpMtCP9L/r
2roQJHdCXsAszIPpIL84HFCRfc9V2wV5WvXQX7Y8cRrnzVSLTRXefMU9uVEn3Ol2
4OyWIcdWHYj8DgR7epN7EvHqHwbHNSh+U9/85JsSeYJDAfdyRdrW1afmenuf4Zzd
1kfdrrra3ctQbyYYo+HHMskgVzB8I4guASHqGOlbLnC9V2nmyJ6Je5FDq1DbEJnA
82H1pbgFZQ5AUxQ7MK/dTwLL5GkrQHHjddGoJyiDNSDuYYGefW/DCQvDosxbZAIr
QEfEFtgPt/sTCn1TyU+fTMBdvrX/ybaTwkURDUxWDt95aWO+VsiZbcybKQ3QKPoU
Oyzx0/PdA5cduzw9Ny3V9vbsdkiBRdYJh8Pfb4mXHPKdk6DONfI3aOwHLyxX9oz5
mnl9z9ExNDPXPUnnIt2QZiBt232Bhxgvap6aUeO6d70DI2f5A8c=
=mb4Y
-----END PGP SIGNATURE-----

--tyn6d3fmh7rrtjqg--
