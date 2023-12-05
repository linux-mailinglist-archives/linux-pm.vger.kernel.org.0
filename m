Return-Path: <linux-pm+bounces-715-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB4B805AE7
	for <lists+linux-pm@lfdr.de>; Tue,  5 Dec 2023 18:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9260F1F21CC0
	for <lists+linux-pm@lfdr.de>; Tue,  5 Dec 2023 17:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5315469295;
	Tue,  5 Dec 2023 17:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QBxqVkc1"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F4769280;
	Tue,  5 Dec 2023 17:12:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50413C433CA;
	Tue,  5 Dec 2023 17:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701796336;
	bh=+0SRtpBwj79hIz/hHBCulYEHeN2HzGzV1N8GdMPi31w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QBxqVkc1BziMmuPR3tIkkMNgJr+V3run3T4gG81YFKuJTAzX/zKyDCkEzv7frte7m
	 lAT1Artq+rZz/ciZE1ZjUffmsv718UE2U6YvMqCtFHC7LfI4go6ThDchoT4vKQ4OMK
	 Mf4ikzZ/4aJy7xjamZk7AdokjjW3bf4DWDvonwbsryiBj1Yd5KXmb16OyJD8DtTFB/
	 j0BXj9qdVSTsQQTvtZUYaQFBFF0L/YW0OcjTlwk0TbtgKgBon3piss3mXQGuen0iIo
	 V8+4NdEQhNh+q0kBH4psHqHgnyNRG55uDj9+vhMPIgSntYHeeu0RxO0Rt/qm0P2F5W
	 9ChT+OSFwLXtw==
Date: Tue, 5 Dec 2023 17:12:10 +0000
From: Conor Dooley <conor@kernel.org>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
	Support Opensource <support.opensource@diasemi.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Steve Twiss <stwiss.opensource@diasemi.com>,
	linux-input@vger.kernel.org, devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v3.1 8/8] dt-bindings: mfd: dlg,da9063: Convert da9062 to
 json-schema
Message-ID: <20231205-negate-matrix-0e55c151017b@spud>
References: <20231204172510.35041-1-biju.das.jz@bp.renesas.com>
 <20231204172510.35041-9-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4rzgZ3xOApeS7mXd"
Content-Disposition: inline
In-Reply-To: <20231204172510.35041-9-biju.das.jz@bp.renesas.com>


--4rzgZ3xOApeS7mXd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 04, 2023 at 05:25:10PM +0000, Biju Das wrote:

> @@ -60,8 +85,65 @@ properties:
>  required:
>    - compatible
>    - reg
> -  - interrupts
> -  - interrupt-controller
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - dlg,da9063
> +              - dlg,da9063l
> +    then:
> +      properties:
> +        thermal: false
> +        gpio: false
> +        gpio-controller: false
> +        "#gpio-cells": false
> +        regulators:
> +          patternProperties:
> +            "^buck[1-4]$": false
> +      required:
> +        - interrupts
> +        - interrupt-controller
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - dlg,da9062
> +    then:
> +      properties:
> +        regulators:
> +          patternProperties:
> +            "^(ldo([5-9]|10|11)|bcore([1-2]|s-merged)|b(pro|mem|io|peri)=
|bmem-bio-merged)$": false
> +      required:
> +        - gpio
> +        - onkey
> +        - rtc
> +        - thermal
> +        - watchdog

Why are these required for the 9062 (and another set for the 9061)?
The original binding does not seem to require them, nor does the yaml
binding for the 9063.

> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - dlg,da9061
> +    then:
> +      properties:
> +        gpio: false
> +        gpio-controller: false
> +        "#gpio-cells": false
> +        regulators:
> +          patternProperties:
> +            "^(ldo([5-9]|10|11)|bcore([1-2]|s-merged)|b(pro|mem|io|peri)=
|bmem-bio-merged|buck4)$": false
> +        rtc: false
> +      required:
> +        - onkey
> +        - thermal
> +        - watchdog
> =20
>  additionalProperties: false
> =20
> @@ -118,4 +200,98 @@ examples:
>          };
>        };
>      };
> +
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/regulator/dlg,da9063-regulator.h>
> +    i2c {
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +      pmic@58 {
> +        compatible =3D "dlg,da9062";
> +        reg =3D <0x58>;
> +        #interrupt-cells =3D <2>;
> +        interrupt-parent =3D <&gpio1>;
> +        interrupts =3D <2 IRQ_TYPE_LEVEL_LOW>;
> +        interrupt-controller;
> +
> +        gpio {
> +          compatible =3D "dlg,da9062-gpio";
> +          status =3D "disabled";

Why add it disabled? This should be enabled IMO.

> +        rtc {
> +          compatible =3D "dlg,da9062-rtc";
> +          status =3D "disabled";
> +        };
> +
> +        thermal {
> +          compatible =3D "dlg,da9062-thermal";
> +          status =3D "disabled";
> +        };

Ditto for these.

Thanks,
Conor.


--4rzgZ3xOApeS7mXd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZW9Z6QAKCRB4tDGHoIJi
0s25AQCT8XSj7t9IWgumkPnfPudYqItXou/tVFS/+9+gGopdIQD5AUYZftVFIznQ
csQ+dxbWkG9X4t5mJHnZ9/RohqMsFAU=
=qT5H
-----END PGP SIGNATURE-----

--4rzgZ3xOApeS7mXd--

