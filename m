Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF3317C69D
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2020 20:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgCFT5E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Mar 2020 14:57:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:47764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbgCFT5E (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 6 Mar 2020 14:57:04 -0500
Received: from earth.universe (unknown [185.62.205.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 875BE206D5;
        Fri,  6 Mar 2020 19:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583524623;
        bh=2KI8AroYi/xsU/dZ8EDn9Ch6JDyHbrw2z1S1dS+qD90=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oYVSb2MfsQ+hbjzskjuPbz7RZYIAFtSD+XG5gHf0kCm9XdPJ9WlKVwh3cu0VjHLKu
         YD1NI3gJDF7DeWL+2ne99KUVB+DT7CoH39kV0tXHXa4vE8nAVcLC+qz6aX+Jfv+wk/
         bj2suD5BbzONFXRSVhJmQW4Ose+lqUyOepRE/Pus=
Received: by earth.universe (Postfix, from userid 1000)
        id 3F9E63C0C83; Fri,  6 Mar 2020 20:57:00 +0100 (CET)
Date:   Fri, 6 Mar 2020 20:57:00 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Sergey.Semin@baikalelectronics.ru
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] dt-bindings: power: reset: Add regmap support to the
 SYSCON reboot-mode bindings
Message-ID: <20200306195700.gg2iatlmxx7rvcol@earth.universe>
References: <20200306130341.9585-1-Sergey.Semin@baikalelectronics.ru>
 <20200306130402.1F4F0803079F@mail.baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="du3yw7tr5ihl5q4d"
Content-Disposition: inline
In-Reply-To: <20200306130402.1F4F0803079F@mail.baikalelectronics.ru>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--du3yw7tr5ihl5q4d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Mar 06, 2020 at 04:03:40PM +0300, Sergey.Semin@baikalelectronics.ru=
 wrote:
> From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
>=20
> Optional regmap property will be used to refer to a syscon-controller
> having a reboot tolerant register mapped.
>=20
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Signed-off-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Paul Burton <paulburton@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> ---

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  .../bindings/power/reset/syscon-reboot-mode.yaml         | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/power/reset/syscon-reboot-=
mode.yaml b/Documentation/devicetree/bindings/power/reset/syscon-reboot-mod=
e.yaml
> index e09bb07b1abb..f47bf52ad983 100644
> --- a/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.ya=
ml
> +++ b/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.ya=
ml
> @@ -13,9 +13,8 @@ description: |
>    This driver gets reboot mode magic value from reboot-mode driver
>    and stores it in a SYSCON mapped register. Then the bootloader
>    can read it and take different action according to the magic
> -  value stored. The SYSCON mapped register is retrieved from the
> -  parental dt-node plus the offset. So the SYSCON reboot-mode node
> -  should be represented as a sub-node of a "syscon", "simple-mfd" node.
> +  value stored. The SYSCON mapped register is retrieved either from
> +  the parental dt-node or from a regmap phandle plus the offset.
> =20
>  properties:
>    compatible:
> @@ -29,6 +28,10 @@ properties:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      description: Offset in the register map for the mode register (in by=
tes).
> =20
> +  regmap:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: Phandle to the register map node.
> +
>  patternProperties:
>    "^mode-.+":
>      $ref: /schemas/types.yaml#/definitions/uint32
> --=20
> 2.25.1
>=20

--du3yw7tr5ihl5q4d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl5iqwwACgkQ2O7X88g7
+prcSA/+PkF08wBVVFq7Q4BPHNi32tO1mtsuo1hS+qydwENk1V2r/Iw98+/z+HWv
T/n7sZGhaqiqi9M5zi46uag16RRxUVIGdYs+TmBMicX6dBl8jBZtVKCX4ENeBKZI
ao3Z1R4HYl7b++RVhntvmcNCJg+hhfueVPt/3rH1dZpLnY5OTBZvcUIejm+SLJDF
z7s1sJhVDOl2h0yAtMhJkkmGrc98Yxe3v4DRcyq2CzpOLpZXQTZm8TOocAfzamz8
+5L+iIBzHPFx/DOJjzy6Mb+63qby/epANdSJZDz01oShcZVKwQiWn0IUy3autmh7
LPOtdKxNvIshaPaZjRO5K0njqvf3+v+ylQNwiksGrMAL2DMSRVLz4kx5ydRUgHbr
DRsRAdCoU6W7N4gGeLyRojJadgw+GiHITOJwtg1iuFyUQbmYNmamU2WSMTJyHBKL
HxrDiK+55Ms1pbAUvm1O1ysrZsD9orE+9xVS14klrxabW97esUJdC2UB2tNI6CPe
EuPwDKWAl50CdPNpLYQvSb6/RUUQs/N1IqfPvMr1qFFMSHlN47PsUe9Tw4qk7bXb
2q84l86l04WD5zRNhl3GMa4yi4h5+tE9Wrur/tOoB6dpP/BrfVls/Pt7IrRI69Lg
WnTTsrzvv85mzq9IfjhEvBQvMRo5UITVzFOG2+RO4f/PWSOubTo=
=ysnP
-----END PGP SIGNATURE-----

--du3yw7tr5ihl5q4d--
