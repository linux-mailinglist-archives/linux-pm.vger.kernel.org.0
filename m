Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9F822E344
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jul 2020 01:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgGZXYo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 26 Jul 2020 19:24:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:55288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726669AbgGZXYn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 26 Jul 2020 19:24:43 -0400
Received: from earth.universe (unknown [185.213.155.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FC272065F;
        Sun, 26 Jul 2020 23:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595805882;
        bh=ofQ1/WYurrGyWmBS2OH75W7GcmL2vwLzjghNOvGO1Q8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FoKVoH7rLTUklVu5uEjXU+ETg6HO5SjERTfgXkG85zJ0XWlofhwFL+OIXFFIZSHal
         CBz///DKZVc4y+Ycv2hMxCHYaCT3V/rQnURG+gcFZJ5kQUdrbTmHQ5QWc0BDyp5lQk
         xa4KVxgkeEq4/ikAa0NbiZsiHVqDZCfabXWVSxy4=
Received: by earth.universe (Postfix, from userid 1000)
        id 965553C0B87; Mon, 27 Jul 2020 01:24:40 +0200 (CEST)
Date:   Mon, 27 Jul 2020 01:24:40 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Cc:     pali@kernel.org, robh@kernel.org, afd@ti.com, dmurphy@ti.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, sspatil@android.com
Subject: Re: [PATCH v17 2/4] dt-bindings: power: Convert battery.txt to
 battery.yaml
Message-ID: <20200726232440.valzl3omfbfyi75z@earth.universe>
References: <20200720204400.7351-1-r-rivera-matos@ti.com>
 <20200720204400.7351-3-r-rivera-matos@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pzxq5hlzvgf3olta"
Content-Disposition: inline
In-Reply-To: <20200720204400.7351-3-r-rivera-matos@ti.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--pzxq5hlzvgf3olta
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 20, 2020 at 03:43:58PM -0500, Ricardo Rivera-Matos wrote:
> From: Dan Murphy <dmurphy@ti.com>
>=20
> Convert the battery.txt file to yaml and fix up the examples.

The examples were correct for the existing binding. What you did
is completly changing the binding description (without modifying
the code) resulting in examples and any existing users being
incorrect and code not matching up with the binding.

> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>  .../bindings/power/supply/battery.txt         |  86 +---------
>  .../bindings/power/supply/battery.yaml        | 157 ++++++++++++++++++
>  2 files changed, 158 insertions(+), 85 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/batter=
y.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b=
/Documentation/devicetree/bindings/power/supply/battery.txt
> index 5e29595edd74..a9f80cc49068 100644
> --- a/Documentation/devicetree/bindings/power/supply/battery.txt
> +++ b/Documentation/devicetree/bindings/power/supply/battery.txt
> @@ -1,87 +1,3 @@
> -Battery Characteristics
> -
> -The devicetree battery node provides static battery characteristics.
> -In smart batteries, these are typically stored in non-volatile memory
> -on a fuel gauge chip. The battery node should be used where there is
> -no appropriate non-volatile memory, or it is unprogrammed/incorrect.
> -
> -Upstream dts files should not include battery nodes, unless the battery
> -represented cannot easily be replaced in the system by one of a
> -different type. This prevents unpredictable, potentially harmful,
> -behavior should a replacement that changes the battery type occur
> -without a corresponding update to the dtb.
> +The contents of this file has been moved to battery.yaml
> =20
>  Please note that not all charger drivers respect all of the properties.
> -
> -Required Properties:
> - - compatible: Must be "simple-battery"
> -
> -Optional Properties:
> - - over-voltage-threshold-microvolt: battery over-voltage limit
> - - re-charge-voltage-microvolt: limit to automatically start charging ag=
ain
> - - voltage-min-design-microvolt: drained battery voltage
> - - voltage-max-design-microvolt: fully charged battery voltage
> - - energy-full-design-microwatt-hours: battery design energy
> - - charge-full-design-microamp-hours: battery design capacity
> - - trickle-charge-current-microamp: current for trickle-charge phase
> - - precharge-current-microamp: current for pre-charge phase
> - - precharge-upper-limit-microvolt: limit when to change to constant cha=
rging
> - - charge-term-current-microamp: current for charge termination phase
> - - constant-charge-current-max-microamp: maximum constant input current
> - - constant-charge-voltage-max-microvolt: maximum constant input voltage
> - - factory-internal-resistance-micro-ohms: battery factory internal resi=
stance
> - - ocv-capacity-table-0: An array providing the open circuit voltage (OC=
V)
> -   of the battery and corresponding battery capacity percent, which is u=
sed
> -   to look up battery capacity according to current OCV value. And the o=
pen
> -   circuit voltage unit is microvolt.
> - - ocv-capacity-table-1: Same as ocv-capacity-table-0
> - ......
> - - ocv-capacity-table-n: Same as ocv-capacity-table-0
> - - ocv-capacity-celsius: An array containing the temperature in degree C=
elsius,
> -   for each of the battery capacity lookup table. The first temperature =
value
> -   specifies the OCV table 0, and the second temperature value specifies=
 the
> -   OCV table 1, and so on.
> - - resistance-temp-table: An array providing the temperature in degree C=
elsius
> -   and corresponding battery internal resistance percent, which is used =
to look
> -   up the resistance percent according to current temperature to get a a=
ccurate
> -   batterty internal resistance in different temperatures.
> -
> -Battery properties are named, where possible, for the corresponding
> -elements in enum power_supply_property, defined in
> -https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
include/linux/power_supply.h
> -
> -Batteries must be referenced by chargers and/or fuel-gauges
> -using a phandle. The phandle's property should be named
> -"monitored-battery".
> -
> -Example:
> -
> -	bat: battery {
> -		compatible =3D "simple-battery";
> -		voltage-min-design-microvolt =3D <3200000>;
> -		voltage-max-design-microvolt =3D <4200000>;
> -		energy-full-design-microwatt-hours =3D <5290000>;
> -		charge-full-design-microamp-hours =3D <1430000>;
> -		precharge-current-microamp =3D <256000>;
> -		charge-term-current-microamp =3D <128000>;
> -		constant-charge-current-max-microamp =3D <900000>;
> -		constant-charge-voltage-max-microvolt =3D <4200000>;
> -		factory-internal-resistance-micro-ohms =3D <250000>;
> -		ocv-capacity-celsius =3D <(-10) 0 10>;
> -		ocv-capacity-table-0 =3D <4185000 100>, <4113000 95>, <4066000 90>, ..=
=2E;
> -		ocv-capacity-table-1 =3D <4200000 100>, <4185000 95>, <4113000 90>, ..=
=2E;
> -		ocv-capacity-table-2 =3D <4250000 100>, <4200000 95>, <4185000 90>, ..=
=2E;
> -		resistance-temp-table =3D <20 100>, <10 90>, <0 80>, <(-10) 60>;
> -	};
> -
> -	charger: charger@11 {
> -		....
> -		monitored-battery =3D <&bat>;
> -		...
> -	};
> -
> -	fuel_gauge: fuel-gauge@22 {
> -		....
> -		monitored-battery =3D <&bat>;
> -		...
> -	};
> diff --git a/Documentation/devicetree/bindings/power/supply/battery.yaml =
b/Documentation/devicetree/bindings/power/supply/battery.yaml
> new file mode 100644
> index 000000000000..d7a2380b46f9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/battery.yaml
> @@ -0,0 +1,157 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/supply/battery.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Battery Characteristics
> +
> +maintainers:
> +  - Sebastian Reichel <sre@kernel.org>
> +
> +description: |
> +  The devicetree battery node provides static battery characteristics.
> +  In smart batteries, these are typically stored in non-volatile memory
> +  on a fuel gauge chip. The battery node should be used where there is
> +  no appropriate non-volatile memory, or it is unprogrammed/incorrect.
> +
> +  Upstream dts files should not include battery nodes, unless the battery
> +  represented cannot easily be replaced in the system by one of a
> +  different type. This prevents unpredictable, potentially harmful,
> +  behavior should a replacement that changes the battery type occur
> +  without a corresponding update to the dtb.
> +
> +  Battery properties are named, where possible, for the corresponding el=
ements
> +  in enum power_supply_property, defined in include/linux/power_supply.h
> +
> +  Batteries must be referenced by chargers and/or fuel-gauges using a ph=
andle.
> +  The phandle's property should be named "monitored-battery".
> +
> +properties:
> +  compatible:
> +    const: simple-battery
> +
> +  over-voltage-threshold-microvolt:
> +    description: battery over-voltage limit
> +
> +  re-charge-voltage-microvolt:
> +    description: limit to automatically start charging again
> +
> +  voltage-min-design-microvolt:
> +    description: drained battery voltage
> +
> +  voltage-max-design-microvolt:
> +    description: fully charged battery voltage
> +
> +  energy-full-design-microwatt-hours:
> +    description: battery design energy
> +
> +  charge-full-design-microamp-hours:
> +    description: battery design capacity
> +
> +  trickle-charge-current-microamp:
> +    description: current for trickle-charge phase
> +
> +  precharge-current-microamp:
> +    description: current for pre-charge phase
> +
> +  precharge-upper-limit-microvolt:
> +    description: limit when to change to constant charging
> +
> +  charge-term-current-microamp:
> +    description: current for charge termination phase
> +
> +  constant-charge-current-max-microamp:
> +    description: maximum constant input current
> +
> +  constant-charge-voltage-max-microvolt:
> +    description: maximum constant input voltage
> +
> +  factory-internal-resistance-micro-ohms:
> +    description: battery factory internal resistance
> +
> +  monitored-battery:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: phandle to the battery node being monitored

monitored-battery is not a valid property of simple-battery node
(the one having compatible =3D "simple-battery"). It needs to be
listed in the binding _using_ simple-battery (which you did in
the bq2515x binding). Drop it.

> +required:
> +  - compatible
> +
> +patternProperties:
> +  '^ocv-capacity-table-[0-100]$':
> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +    description: |
> +      An array providing the open circuit voltage (OCV)
> +      of the battery and corresponding battery capacity percent, which i=
s used
> +      to look up battery capacity according to current OCV value. And th=
e open
> +      circuit voltage unit is microvolt.
> +    maxItems: 100
> +    items:
> +      items:
> +        - description: open circuit voltage (OCV) in microvolts
> +        - description: battery capacity percent
> +          maximum: 100

This looks ok.

> +  '^resistance-temp-table-[0-100]$':
> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +    description: |
> +      An array providing the temperature in degree Celsius
> +      and corresponding battery internal resistance percent, which is us=
ed to
> +      look up the resistance percent according to current temperature to=
 get an
> +      accurate batterty internal resistance in different temperatures.
> +    maxItems: 100
> +    items:
> +      items:
> +        - description: internal resistance percent
> +        - description: battery capacity percent
> +          maximum: 100

This is a single property ("resistance-temp-table") describing
a graph with temperature on one axis and battery internal resistance
on the other axis. The first cell is temperature in degree Celsius
and the second cell is internal resistance percentage. So old
example

resistance-temp-table =3D <20 100>, <10 90>, <0 80>, <(-10) 60>;

translates into

20=B0 =3D> 100% of "factory-internal-resistance-micro-ohms"
10=B0 =3D> 90% of "factory-internal-resistance-micro-ohms"

> +  '^ocv-capacity-celsius-[0-100]$':
> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +    description: |
> +      An array containing the temperature in degree Celsius,
> +      for each of the battery capacity lookup table.
> +    maxItems: 100
> +    items:
> +      items:
> +        - description: temperature in degree Celsius
> +        - description: battery capacity percent
> +          maximum: 100

This is also incorrect. This is a single property ("ocv-capacity-celsius"),
which is the lookup table for "^ocv-capacity-table-[0-100]$". It maps
ocv-capacity tables to temperatures. Let me use the example from the
old *.txt binding again:

ocv-capacity-celsius =3D <(-10) 0 10>;
ocv-capacity-table-0 =3D <4185000 100>, <4113000 95>, <4066000 90>, ...;
ocv-capacity-table-1 =3D <4200000 100>, <4185000 95>, <4113000 90>, ...;
ocv-capacity-table-2 =3D <4250000 100>, <4200000 95>, <4185000 90>, ...;

-10 degree Celsius is index 0, so ocv-capacity-table-0 should be
used for -10 degrees Celsius.

0 degrees Celsius is index 1, so ocv-capacity-table-1 should
be used for this temperature.

10 degrees Celsius is index 2, so ocv-capacity-table-2
should be used for this temperature.

-- Sebastian

> +additionalProperties: false
> +
> +examples:
> +  - |
> +    power {
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +
> +      battery: battery {
> +        compatible =3D "simple-battery";
> +        over-voltage-threshold-microvolt =3D <4500000>;
> +        re-charge-voltage-microvolt =3D <250000>;
> +        voltage-min-design-microvolt =3D <3200000>;
> +        voltage-max-design-microvolt =3D <4200000>;
> +        energy-full-design-microwatt-hours =3D <5290000>;
> +        charge-full-design-microamp-hours =3D <1430000>;
> +        precharge-current-microamp =3D <256000>;
> +        precharge-upper-limit-microvolt =3D <2500000>;
> +        charge-term-current-microamp =3D <128000>;
> +        constant-charge-current-max-microamp =3D <900000>;
> +        constant-charge-voltage-max-microvolt =3D <4200000>;
> +        factory-internal-resistance-micro-ohms =3D <250000>;
> +        ocv-capacity-celsius-0 =3D <(-10) 10>;
> +        ocv-capacity-table-0 =3D <4185000 100>, <4113000 95>, <4066000 9=
0>;
> +        resistance-temp-table-0 =3D <20 100>, <10 90>, <0 80>, <(-10) 60=
>;
> +      };
> +
> +      charger@11 {
> +        reg =3D <0x11>;
> +        monitored-battery =3D <&battery>;
> +      };
> +
> +      fuel-gauge@22 {
> +        reg =3D <0x22>;
> +        monitored-battery =3D <&battery>;
> +      };
> +    };
> --=20
> 2.27.0
>=20

--pzxq5hlzvgf3olta
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl8eELUACgkQ2O7X88g7
+prEfA/8Dr1bhN876UHwZ6C55IVYyuqg+ohq3WyKOyOFKau51+QY0O9oPlUeRwHU
RA60xqOJNKjo6DKzGwCGRc/138dUJVuZF/pIISAezaVxnJWVtWn529WvgmmuCTzy
SlMH4z3/pcmO0UUX3f21RCzIisjYkXEWu3NOZjTpAViAI0POCwUcCrpjqxutf3Mh
itbsE5aC3oFdsDyUcoNU2GlGmuw9yqx6UvGd+NkmYg/4682YBXh3jx8XFm+3Uhu6
I81lolY0HMS+V6VBkSjCzl1IqXvNanrJXlxVlzxZe5Drb7HHrEkaWqHcgaU25WZ0
WFbMTyfM3qY897FVqRbu2Os4yeHqeUqb4cewB9zmCEm+oMIGUI5lJMvQTNNCORbS
p6kL6xuwOjdgNHQa4Bc+DWLvXlEJ9O8BFsSNcO1BtfnE1tpbPy21zJ/ZTlRxJeDo
9THhjKDWwzAQ6hNZnmjLS1KU2SyEiyqLeUYGpN3eynH7bULWXWLy3SOmIlgC/os8
Fy82WRJEoq60DYd1oL95XU7SdZjp/NT1cORpW5YjmFJtYzIPSUW1shdRvu4QCURP
f71SwxwCM0BuzHyXEFLd6vODxSGCIHrR5Ba49V7OhINOM2U46IHPmZND5JN5XAjH
bP4ufRmoX9zHyTiucvJ6/ruW787K1zsksf2tEw/b6qNohxOg3a4=
=HCnE
-----END PGP SIGNATURE-----

--pzxq5hlzvgf3olta--
