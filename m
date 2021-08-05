Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE0DE3E1A3F
	for <lists+linux-pm@lfdr.de>; Thu,  5 Aug 2021 19:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239251AbhHERUK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Aug 2021 13:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239104AbhHERUJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Aug 2021 13:20:09 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7D3C061765
        for <linux-pm@vger.kernel.org>; Thu,  5 Aug 2021 10:19:55 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id F0D1D1F442FA
Received: by earth.universe (Postfix, from userid 1000)
        id CE7543C0C9B; Thu,  5 Aug 2021 19:19:51 +0200 (CEST)
Date:   Thu, 5 Aug 2021 19:19:51 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andrejus Basovas <cpp@gcc.lt>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 00/10] power: supply: axp288_fuel_gauge: Reduce number
 of register accesses + cleanups
Message-ID: <20210805171951.xkvndkzpx3od2nki@earth.universe>
References: <20210801133105.101761-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vqchxw65lzo2rot7"
Content-Disposition: inline
In-Reply-To: <20210801133105.101761-1-hdegoede@redhat.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--vqchxw65lzo2rot7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Hans,

On Sun, Aug 01, 2021 at 03:30:55PM +0200, Hans de Goede wrote:
> Hi all,
>=20
> Changes in v3:
> - Replace "depends on X86" with "depends on IOSF_MBI" as the new code uses
>   symbols which are only defined when IOSF_MBI support is enabled.
>   Depending on this is ok since IOSF_MBI support should always be enabled
>   on devices which use the AXP288 PMIC.
>=20
> Changes in v2:
> - Add a "depends on X86" to Kconfig since the iosf_mbi functions are X86 =
only
>   (the AXP288 PMIC is only used on X86 devices).
>=20
> And here is the v1 cover-letter again:
>=20
> The I2C-bus to the XPower AXP288 is shared between the Linux kernel and
> the SoCs P-Unit. The P-Unit has a semaphore which the kernel must "lock"
> before it may use the bus and while the kernel holds the semaphore the CPU
> and GPU power-states must not be changed otherwise the system will freeze.
> This is a complex process, which is quite expensive.
>=20
> To ensure that no unguarded I2C-bus accesses happen, the semaphore is
> taken by the I2C-bus-driver for every I2C transfer. When upower refreshes
> its battery stats it reads all the power-supply properties at once,
> leading to the semaphore getting hammered which sometimes causes the
> system to hang.
>=20
> Andrejus maintains a large "fleet" of affected Cherry Trail tablets
> and was seeing these hangs semi regularly. After discussing this with
> me Andrejus wrote the caching patch in this series which greatly reduces
> the number of semaphore accesses and since then there have been no
> reports of hangs in the fleet of devices which he maintains.
>=20
> I've cleaned up Andrejus work a bit before submitting it upstream and
> while working on this I found a slew of other issues in this driver
> which bugged me enough to write a bunch of cleanup patches. I've also
> added some extra patches to also reduce the semaphore use during driver
> probe.

Thanks, I applied the whole series. The double goto from the last
patch is a bit ugly and can be avoided by switching the driver to
devm_*(). Do you mind doing so?

-- Sebastian

>=20
> Regards,
>=20
> Hans
>=20
>=20
> Andrejus Basovas (1):
>   power: supply: axp288_fuel_gauge: Refresh all registers in one go
>=20
> Hans de Goede (9):
>   power: supply: axp288_fuel_gauge: Fix define alignment
>   power: supply: axp288_fuel_gauge: Remove debugfs support
>   power: supply: axp288_fuel_gauge: Silence the chatty IRQ mapping code
>   power: supply: axp288_fuel_gauge: Report register-address on readb /
>     writeb errors
>   power: supply: axp288_fuel_gauge: Drop retry logic from
>     fuel_gauge_reg_readb()
>   power: supply: axp288_fuel_gauge: Store struct device pointer in
>     axp288_fg_info
>   power: supply: axp288_fuel_gauge: Only read PWR_OP_MODE,
>     FG_LOW_CAP_REG regs once
>   power: supply: axp288_fuel_gauge: Move the AXP20X_CC_CTRL check
>     together with the other checks
>   power: supply: axp288_fuel_gauge: Take the P-Unit semaphore only once
>     during probe()
>=20
>  drivers/power/supply/Kconfig             |   2 +-
>  drivers/power/supply/axp288_fuel_gauge.c | 489 +++++++++--------------
>  2 files changed, 187 insertions(+), 304 deletions(-)
>=20
> --=20
> 2.31.1

--vqchxw65lzo2rot7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmEMHbMACgkQ2O7X88g7
+pq9hBAAjiAxFddqqo63nVci5EaJVi6CQdi/GAKFpyeowXkB30KkDRIePVgzNVHl
sOuyXwjmsZNG/8BXBeE0yvZL4TGpV1/rB9EJnnvjmyifp/9PJ9tJk88YmMCxgoAY
s7LTJuVkr3jeyf2bRY/Zcm7XCAU8bWgbNG25Kj9lZ4SOTpkhLYaqJzflci3hd1uL
XKy8byOyXzkT2vKVO8Z5eBAtUnTjiLCXALzkpmQ/GwcZgdP/8oBOCX9m43pUNqz5
RdCfF4Z9yACS4Iz7TMX3mWcuHDi+9zWHYnRSHzLoBvCBMKc2xS1gI80jd8Juih4r
yEYod0R7wB4olb5ogM/naxCqJOa1tuKYis8QtwxSvyay4htrv/33vA1yhm/TDZJ/
v4MSYV57ZkY4wymumDzc1JIHaXxZlZOoqaubjusa81tNOCLowWRzwSoZ53CRm4gf
XrFLHAe91nRBc5BHTERah4Q7+DKfZ3bVFSk1eWiL0dc9AwTesupaPHEmbsZwUeuM
bgDIIevVgEza0bGqJ94BEChVa+HSPdKybvXV3tHJvDGv9+gRzs1Z9Wyo5+RwSO0L
eb8sdpjibqEZ6Ese3F4EcdqIz2ZuCUqiJoPB4XP7K1rK48lLl/MUzizbBmmK/jHF
sxwg0wDblMvuEQPG93OPW7dE/nLlzMpBUrlWoJjxvCVZVdaUz+8=
=yLyR
-----END PGP SIGNATURE-----

--vqchxw65lzo2rot7--
