Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E28C132890
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2020 15:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbgAGOOp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Jan 2020 09:14:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:51730 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727658AbgAGOOp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 7 Jan 2020 09:14:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 70DA3AC50;
        Tue,  7 Jan 2020 14:14:43 +0000 (UTC)
Message-ID: <8cef3ff20485a084ab395533f28eb0c51b47925d.camel@suse.de>
Subject: Re: [PATCH V2 0/4] ARM: Enable thermal support for Raspberry Pi 4
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Stefan Wahren <wahrenst@gmx.net>, Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org
Date:   Tue, 07 Jan 2020 15:14:41 +0100
In-Reply-To: <1578072236-31820-1-git-send-email-wahrenst@gmx.net>
References: <1578072236-31820-1-git-send-email-wahrenst@gmx.net>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-XJAu1+XbK2gXuacraTLW"
User-Agent: Evolution 3.34.2 
MIME-Version: 1.0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--=-XJAu1+XbK2gXuacraTLW
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-01-03 at 18:23 +0100, Stefan Wahren wrote:
> This series enables thermal support for the Raspberry Pi 4. Neither the
> bcm2835_thermal nor the brcmstb_thermal are suitable for the BCM2711.
> So add a new thermal driver to read out the SoC temperature from the
> AVS RO block of the BCM2711.
>=20
> Changes in V2:
> - rebase on thermal/linux-next
> - convert binding to YAML
> - make AVS RO block a subnode of AVS monitor and access it via syscon
> - drop unnecessary TSENS clock and get the rid of remove callback
> - add Florian's reviewed-by to last/unchanged patch
>=20
> Stefan Wahren (4):
>   dt-bindings: Add Broadcom AVS RO thermal
>   thermal: Add BCM2711 thermal driver
>   ARM: dts: bcm2711: Enable thermal
>   ARM: configs: Build BCM2711 thermal as module
>=20
>  .../bindings/thermal/brcm,avs-ro-thermal.yaml      |  45 +++++++
>  arch/arm/boot/dts/bcm2711.dtsi                     |  12 ++
>  arch/arm/configs/multi_v7_defconfig                |   1 +
>  arch/arm64/configs/defconfig                       |   1 +
>  drivers/thermal/broadcom/Kconfig                   |   7 ++
>  drivers/thermal/broadcom/Makefile                  |   1 +
>  drivers/thermal/broadcom/bcm2711_thermal.c         | 129
> +++++++++++++++++++++
>  7 files changed, 196 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/brcm,avs-ro=
-
> thermal.yaml
>  create mode 100644 drivers/thermal/broadcom/bcm2711_thermal.c
>=20
> --
> 2.7.4
>=20

Minus the small changes mentioned you can add my:

Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Tested-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Many Thanks!
Nicolas


--=-XJAu1+XbK2gXuacraTLW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl4UklEACgkQlfZmHno8
x/4CQAgAgO+zhdwQWVLtIsszrQRrZ0kfdbdfbJNrCOokDEca2VetcAHeJAL/cuw5
n3TWr7fqVt2u38R7e9T8lleri5Yn8ZLkzhi97Azuhox7HDYTyLU2SjRQEnrWJ4T9
1lrotXzonE48X7aouECdmfPI3RkL/wRu9wPzsgbrMC3adYZEoK8ZXLlOdGyq64bc
pdp+kF7P7DKDTmAtcpCi2XTnWlPi5OgoK+eGn0MrobV1DMKeEvo+Guq8aEeDfMbJ
QReBzmmcFf3BFrqy50L10s77vtSQ1HBU/GrIJPviPlHRfd6NCD4FIl/CiARF7RIk
abmzDRMNNKuqw00mOD69A/mIKZTd2w==
=6C0G
-----END PGP SIGNATURE-----

--=-XJAu1+XbK2gXuacraTLW--

