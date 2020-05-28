Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 559921E5823
	for <lists+linux-pm@lfdr.de>; Thu, 28 May 2020 09:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgE1HDQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 May 2020 03:03:16 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50454 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgE1HDQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 May 2020 03:03:16 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 17B192A2173
Received: by earth.universe (Postfix, from userid 1000)
        id A5C563C08C7; Thu, 28 May 2020 09:03:11 +0200 (CEST)
Date:   Thu, 28 May 2020 09:03:11 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Maxim Kaurkin <Maxim.Kaurkin@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Ekaterina Skachko <Ekaterina.Skachko@baikalelectronics.ru>,
        Vadim Vlasov <V.Vlasov@baikalelectronics.ru>,
        Alexey Kolotnikov <Alexey.Kolotnikov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v3 0/2] syscon: Alter syscon and reboot drivers
Message-ID: <20200528070311.uj6bxlplxe2bths5@earth.universe>
References: <20200526135102.21236-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yrkgjjfss7htiiu2"
Content-Disposition: inline
In-Reply-To: <20200526135102.21236-1-Sergey.Semin@baikalelectronics.ru>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--yrkgjjfss7htiiu2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, May 26, 2020 at 04:50:59PM +0300, Serge Semin wrote:
> This is a small patchset about tuning the syscon infrastructure a bit.
> As it's going to be general in the framework of the Baikal-T1 SoC support
> integration into the kernel, we suggest to replace the legacy text-based
> syscon-reboot-mode dts-bindings file with yaml-based one. Then seeing a
> syscon reboot block is normally expected to be a part of a system
> controller and based on the discussion
> https://lore.kernel.org/linux-pm/20200306130402.1F4F0803079F@mail.baikale=
lectronics.ru/
> we decided to alter the syscon reboot driver so one would also try to fet=
ch
> the syscon registers map from a parental DT node. regmap property is left
> supported although it's marked as deprecated from now.
>=20
> This patchset is rebased and tested on the mainline Linux kernel 5.7-rc4:
> 0e698dfa2822 ("Linux 5.7-rc4")
> tag: v5.7-rc4
>=20
> Changelog v2:
> - Add Sebastian' Acked-by tag to patch 1.
> - Use a shorter summary describing the bindings modification patches.
> - Our corporate email server doesn't change Message-Id anymore, so the pa=
tchset
>   is resubmitted being in the cover-letter-threaded format.
> - Discard patch with syscon "-endian" property support. As Rob said It sh=
all be
>   in the common dt-schema.
> - Replace patches of adding a regmap property support to the syscon-reboo=
t-mode
>   with patches making syscon-reboot a sub-node of a system controller nod=
e.
> - Mark regmap property as deprecated from now.
>=20
> Link: https://lore.kernel.org/linux-pm/20200507233846.11548-1-Sergey.Semi=
n@baikalelectronics.ru/
> Changelog v3:
> - Discard the commit 6acd3ecd88ff ("dt-bindings: power: reset: Convert
>   syscon-reboot-mode to DT schema") since it has been merged in by Sebati=
an.
> - Add Rob's Reviewed-by tag to the patch "dt-bindings: power: reset: Unre=
quire
>   regmap property in syscon-reboot node"
>=20
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Maxim Kaurkin <Maxim.Kaurkin@baikalelectronics.ru>
> Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
> Cc: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
> Cc: Ekaterina Skachko <Ekaterina.Skachko@baikalelectronics.ru>
> Cc: Vadim Vlasov <V.Vlasov@baikalelectronics.ru>
> Cc: Alexey Kolotnikov <Alexey.Kolotnikov@baikalelectronics.ru>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: linux-mips@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
>=20
> Serge Semin (2):
>   dt-bindings: power: reset: Unrequire regmap property in syscon-reboot
>     node
>   power: reset: syscon-reboot: Add parental syscon support
>=20
>  .../bindings/power/reset/syscon-reboot.yaml       | 15 ++++++++++-----
>  drivers/power/reset/syscon-reboot.c               |  7 +++++--
>  2 files changed, 15 insertions(+), 7 deletions(-)

Thanks, I queued both patches to power-supply's for-next branch.

-- Sebastian

--yrkgjjfss7htiiu2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl7PYigACgkQ2O7X88g7
+pqx/A/+PGQflv+EzWf4PnqFYmnpcKJ1hrJ2FJit/+ww8TBUU4ZlP614YfZTkDV0
4QlsHgxFqcR//PC3WFJi2r0jy4PrVwf76Sxe39KxgVHExadsQZspuzfjRdzY6vOY
lP+5ZvRNbthc9jY3eIhKK840fyBndZMUleiufKXLWTCyU0DYpmi2H1yOV8nnrR+H
/RCjlxFBG55fyvOcK0nNiuc36/CdEIISGpmUMfUy15sQi6W6+z6HU9kVLnkDpUnN
70TrYUtfe3nmBtJLF+0Ebx2maBHFqzZJeMuyyHSpmuGLPoH5GtyPyxYsIhci4GXE
M5m4uQSMvhH4tTb/5rQz4bVL3y5RcWequsS/n4hcrjj7Dfb7aOg1flUQC2N/coQk
+kwPsWeGZTgJLNnZPuj8TDyvMxoLYTtimLapEXC+kyXoTrlFBpg9a5CM/JFMvNV6
Dwv2PuW8Xkxzbe2w9RactL/wSDkgdoXK0BKNlM0wSSQz3dCCIxWpW21761E+gJKj
EyyL3FVEWYZD8sXtqkLqsb2+p7evHGuRB1ZJKihP+4taPP50KFi7AvZjKJ3L1jF0
tzR7lMGtte/Hd20/uk7ahXbSs2+iLHBba+bM9/mrsyI66LOii8I3JtMr6Afcv/Ss
AwfTnLTDizJ9mir7G5D10haA9VJA5BbMe47VadqQ2vRfCvKUfOs=
=OULp
-----END PGP SIGNATURE-----

--yrkgjjfss7htiiu2--
