Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E024C17C694
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2020 20:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbgCFT4n (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Mar 2020 14:56:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:47550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbgCFT4n (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 6 Mar 2020 14:56:43 -0500
Received: from earth.universe (unknown [185.62.205.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DE34206CC;
        Fri,  6 Mar 2020 19:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583524602;
        bh=BPfEbCn7SCZtVYMhZP5cF15MOUHjOncMp76kNq1znBA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vm02SjTOrPZR4CjbjHvp0zknsAzgFh70ImQaeSVkyjvissTjNmCL0i6d5ywDOOqat
         HCsF/MtKsvMcVYEp6aXq3UNTkij6JOfRBOYcrDWYTCkwLVwqJC9QicnG2sa5yk6xzx
         M5UmcLpKEG7svK6mKleLs07Nu8crZ3pXOVEd7zak=
Received: by earth.universe (Postfix, from userid 1000)
        id CE06A3C0C83; Fri,  6 Mar 2020 20:56:38 +0100 (CET)
Date:   Fri, 6 Mar 2020 20:56:38 +0100
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
Subject: Re: [PATCH 2/4] dt-bindings: power: reset: Replace SYSCON
 reboot-mode legacy bindings with YAML-based one
Message-ID: <20200306195638.45vwlgsf7pt3fcfy@earth.universe>
References: <20200306130341.9585-1-Sergey.Semin@baikalelectronics.ru>
 <20200306130401.C07838030795@mail.baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mh23np6ztot7jlnh"
Content-Disposition: inline
In-Reply-To: <20200306130401.C07838030795@mail.baikalelectronics.ru>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--mh23np6ztot7jlnh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Mar 06, 2020 at 04:03:39PM +0300, Sergey.Semin@baikalelectronics.ru=
 wrote:
> From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
>=20
> Modern device tree bindings are supposed to be created as YAML-files
> in accordance with dt-schema. This commit replaces SYSCON reboot-mode
> legacy bare text bindings with YAML file. As before the bindings file
> states that the corresponding dts node is supposed to be compatible
> "syscon-reboot-mode" device and necessarily have an offset property
> to determine which register from the regmap is supposed to keep the
> mode on reboot.
>=20
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Signed-off-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Paul Burton <paulburton@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> ---

I'm missing patch 1 and would like an Acked-by from Rob Herring, so
for now:

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

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
> index 000000000000..e09bb07b1abb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.ya=
ml
> @@ -0,0 +1,55 @@
> +# SPDX-License-Identifier: GPL-2.0
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
it).
> +
> +  offset:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Offset in the register map for the mode register (in by=
tes).
> +
> +patternProperties:
> +  "^mode-.+":
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Vendor-specific mode value written to the mode register.
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

--mh23np6ztot7jlnh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl5iqvMACgkQ2O7X88g7
+ppHaxAAok3l+727X+6xh0wOQLONz4qdybMFkm2tVvS+v3hOLi95EH1EkSE/JU7Y
DPGn9GI/vorhMcMhT3veS6izhw7Zed9Zk/9ySl0eWz8VVWcor0M7rLLtZHWEAZYA
mHEmBmWxMoemVgVKTAIJxRGLGXAKd2tI2a9W72pKCr5J7Y/Sc06sGJdiEnA/vsDv
x7IAGOOigjggbVs2C5afqrGxkEDwHDrFwkixH7GOhC6jq7u98Kmqm28hcPZHm2eD
PC869XaV+D8rSq47TfFl4VBDZ96FyrzerFVqrhEn7czf2kQ+2jG6fGX8wLTUg99z
WUpqBeXH9jxzlypRWzv3ShSy7YO8d066rxJatRyFDmUm7eKT7D3UV8qH5JYid4l2
E/gbglffGhn7wt6HYeqgKFCBDSB2Rr6TKxY6xi26NJc9n6v9GvJtbf2EQylMhae4
7hMxrgxi6gDn10l733EMLY+Y1vIna+HwyCgJqvtqhI5DGZtCZ66jVFncQ143cfaS
Uax9EN+o2421DTWsJMroJftO6BeYHfsaYn0DDOGGC+SCpFfFLkd7knYoKemCy93T
duftUY0wfwR8muJDzrHuxmw5u+XY1Q1TcZMG+ZYd+IRcVqzoZfwoIiiz5ipVbTdj
qhnXBIkHZUhdKv0OVdMpzIROIjxtABNTOvGnqYfe4p4ljUXk9TY=
=P2Vn
-----END PGP SIGNATURE-----

--mh23np6ztot7jlnh--
