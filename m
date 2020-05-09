Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95A761CBBC8
	for <lists+linux-pm@lfdr.de>; Sat,  9 May 2020 02:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbgEIAat (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 May 2020 20:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727878AbgEIAat (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 May 2020 20:30:49 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAFE7C061A0C;
        Fri,  8 May 2020 17:30:48 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id A551E2A33C2
Received: by earth.universe (Postfix, from userid 1000)
        id 5EC5C3C08C6; Sat,  9 May 2020 02:30:45 +0200 (CEST)
Date:   Sat, 9 May 2020 02:30:45 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: power: reset: Convert
 syscon-reboot-mode to DT schema
Message-ID: <20200509003045.3mi7cfey6cmlidul@earth.universe>
References: <20200507233846.11548-1-Sergey.Semin@baikalelectronics.ru>
 <20200507233846.11548-2-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ur4wzzx455z2lgxp"
Content-Disposition: inline
In-Reply-To: <20200507233846.11548-2-Sergey.Semin@baikalelectronics.ru>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--ur4wzzx455z2lgxp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, May 08, 2020 at 02:38:44AM +0300, Serge Semin wrote:
> Modern device tree bindings are supposed to be created as YAML-files
> in accordance with dt-schema. This commit replaces SYSCON reboot-mode
> legacy bare text bindings with YAML file. As before the bindings file
> states that the corresponding dts node is supposed to be compatible
> "syscon-reboot-mode" device and necessarily have an offset property
> to determine which register from the regmap is supposed to keep the
> mode on reboot.
>=20
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Paul Burton <paulburton@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Allison Randal <allison@lohutok.net>
> Cc: Richard Fontana <rfontana@redhat.com>
> Cc: Kate Stewart <kstewart@linuxfoundation.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-mips@vger.kernel.org
> ---

Thanks, I queued this patch to power-supply's for-next branch. For the other
two patches I will wait for Rob's feedback.

-- Sebastian

>  .../power/reset/syscon-reboot-mode.txt        | 35 ------------
>  .../power/reset/syscon-reboot-mode.yaml       | 55 +++++++++++++++++++
>  2 files changed, 55 insertions(+), 35 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/power/reset/syscon-=
reboot-mode.txt
>  create mode 100644 Documentation/devicetree/bindings/power/reset/syscon-=
reboot-mode.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/power/reset/syscon-reboot-=
mode.txt b/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode=
=2Etxt
> deleted file mode 100644
> index f7ce1d8af04a..000000000000
> --- a/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.txt
> +++ /dev/null
> @@ -1,35 +0,0 @@
> -SYSCON reboot mode driver
> -
> -This driver gets reboot mode magic value form reboot-mode driver
> -and stores it in a SYSCON mapped register. Then the bootloader
> -can read it and take different action according to the magic
> -value stored.
> -
> -This DT node should be represented as a sub-node of a "syscon", "simple-=
mfd"
> -node.
> -
> -Required properties:
> -- compatible: should be "syscon-reboot-mode"
> -- offset: offset in the register map for the storage register (in bytes)
> -
> -Optional property:
> -- mask: bits mask of the bits in the register to store the reboot mode m=
agic value,
> -  default set to 0xffffffff if missing.
> -
> -The rest of the properties should follow the generic reboot-mode descrip=
tion
> -found in reboot-mode.txt
> -
> -Example:
> -	pmu: pmu@20004000 {
> -		compatible =3D "rockchip,rk3066-pmu", "syscon", "simple-mfd";
> -		reg =3D <0x20004000 0x100>;
> -
> -		reboot-mode {
> -			compatible =3D "syscon-reboot-mode";
> -			offset =3D <0x40>;
> -			mode-normal =3D <BOOT_NORMAL>;
> -			mode-recovery =3D <BOOT_RECOVERY>;
> -			mode-bootloader =3D <BOOT_FASTBOOT>;
> -			mode-loader =3D <BOOT_BL_DOWNLOAD>;
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/power/reset/syscon-reboot-=
mode.yaml b/Documentation/devicetree/bindings/power/reset/syscon-reboot-mod=
e.yaml
> new file mode 100644
> index 000000000000..9b1ffceefe3d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.ya=
ml
> @@ -0,0 +1,55 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/reset/syscon-reboot-mode.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Generic SYSCON reboot mode driver
> +
> +maintainers:
> +  - Sebastian Reichel <sre@kernel.org>
> +
> +description: |
> +  This driver gets reboot mode magic value from reboot-mode driver
> +  and stores it in a SYSCON mapped register. Then the bootloader
> +  can read it and take different action according to the magic
> +  value stored. The SYSCON mapped register is retrieved from the
> +  parental dt-node plus the offset. So the SYSCON reboot-mode node
> +  should be represented as a sub-node of a "syscon", "simple-mfd" node.
> +
> +properties:
> +  compatible:
> +    const: syscon-reboot-mode
> +
> +  mask:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Update only the register bits defined by the mask (32 b=
it)
> +
> +  offset:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Offset in the register map for the mode register (in by=
tes)
> +
> +patternProperties:
> +  "^mode-.+":
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Vendor-specific mode value written to the mode register
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - offset
> +
> +examples:
> +  - |
> +    #include <dt-bindings/soc/rockchip,boot-mode.h>
> +
> +    reboot-mode {
> +      compatible =3D "syscon-reboot-mode";
> +      offset =3D <0x40>;
> +      mode-normal =3D <BOOT_NORMAL>;
> +      mode-recovery =3D <BOOT_RECOVERY>;
> +      mode-bootloader =3D <BOOT_FASTBOOT>;
> +      mode-loader =3D <BOOT_BL_DOWNLOAD>;
> +    };
> +...
> --=20
> 2.25.1
>=20

--ur4wzzx455z2lgxp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl61+awACgkQ2O7X88g7
+pqzEA/+Op6qhzk78p5C+O+Dmu3nhHxsCMWMYu8TJI/RtuiicengIHySqfmjR2HM
CSleCh6877cDg5pdedah1nn5XU44+Rm5nEl7focIWuyunCsRoQlYUj6/PfFCCbTg
E1JdE4/PyB4CNQLuAcADP1dQLJXjTOWvxGGjjRV+kSAKzMAMJuTuMCLWdo9Cewvf
qf6w5lyxaskfUIO9wgMR6qe/8XiqBgEJ1Es4XfFaiotNpC9ED82lQj79rgCuofJc
K+il2gJqYkFlUQqgjlxb98M6Rrbin6xKtx/kq7SvoKoorjLom10g2EA4DEu7sIVN
hvMcfJjFt/n5qEUDEqflNTVZ04/Xzp7hB9GUEA60MgjPSIfxWT97Fxf69GbQFpOO
1DSYoUl5cHaMRalhTZYydrHiaKb6NQyikGBvGuw3kprgHvbGhakLZshzGRyzSSBl
f1dFJyrD3bKiqFNTZGEGl5qVIlspEnmAHJJL7bZJBxerTdQbtFts5gFz3iXHX2t4
p0XPnmLUCC1aX6w0QarCQVX78JHjd5F1sIRh1fwZAipN07GiqHln+f/MQbQXmMIa
WIYYEvI6q7W7lcBCQiXvKF1/OXca4lP9wA1jr+2MteMo7Il9nyUDcOeZ1SgKDdkU
JcfBD3mq5mUQodaePmY4O54ut+3rxL2rsEMtG6Zd3Sq/asjbkbg=
=FC4l
-----END PGP SIGNATURE-----

--ur4wzzx455z2lgxp--
