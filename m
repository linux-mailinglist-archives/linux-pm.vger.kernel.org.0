Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B047A253199
	for <lists+linux-pm@lfdr.de>; Wed, 26 Aug 2020 16:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgHZOkV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Aug 2020 10:40:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:50464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbgHZOkU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 26 Aug 2020 10:40:20 -0400
Received: from earth.universe (unknown [95.33.152.255])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3565E214F1;
        Wed, 26 Aug 2020 14:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598452819;
        bh=kSOZjgsKoINzoi95AcLDM3iSpV9pQwpFhCwaD8Qr76Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hbMrgJPOgg7sIpnTXuip5BVUq4csu3DUDLz1ft+2iiUovoI5VVxYGzGZN3CRgzF91
         wlKVf4VboPu7tE6QZBD6JdoEhOUiGX5QU15irvJwd8wgYLubiwDKokxysFyi9kmkAy
         HwqtnBbdp2+00Q9Kdl+DdgYHwInQmfyIm5bJLS+w=
Received: by earth.universe (Postfix, from userid 1000)
        id 96D353C0C82; Wed, 26 Aug 2020 16:40:17 +0200 (CEST)
Date:   Wed, 26 Aug 2020 16:40:17 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Heidelberg <david@ixit.cz>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Bruce E . Robertson" <bruce.e.robertson@intel.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Jonghwa Lee <jonghwa3.lee@samsung.com>,
        John Stultz <john.stultz@linaro.org>,
        Vinay Simha BN <simhavcs@gmail.com>,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH v3 00/10] Summit SMB3xx driver & device-tree
Message-ID: <20200826144017.nolqvzu2exchmdn2@earth.universe>
References: <20200813213409.24222-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nrlaoi7slsg5rmx7"
Content-Disposition: inline
In-Reply-To: <20200813213409.24222-1-digetx@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--nrlaoi7slsg5rmx7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I queued patches 1-8 (so everything besides the DTS changes). I
would like to see some more cleanups and will send a separate
patchset for them in a jiffy. Please test them, since I do not
have the hardware.

-- Sebastian

On Fri, Aug 14, 2020 at 12:33:59AM +0300, Dmitry Osipenko wrote:
> We gathered existing patches, fixed and improved what we could and
> final result is an working charging driver with device-tree support
> for Nexus 7.
>=20
> At this moment charging works with:
>  - Nexus 7 2012 (grouper and tilapia)
>  - Nexus 7 2013 (flo and deb)
>  - ... and there are more devices equipped with these chargers.
>=20
> Changelog:
>=20
> v3: - The uint32 type now isn't specified for standard units in the SMB
>       DT binding because standard units already have a type.
>       Thanks to Rob Herring for the suggestion!
>=20
>     - The battery binding changes are rebased on top of the new battery.y=
aml
>=20
>     - The new battery temperature DT properties now have shorter names
>       and use <min max> format. Thanks to Rob Herring for the suggestion!
>=20
>     - Added new patch that adds SMB charger node to the new Nexus 7 2012
>       device-tree which has been merged into v5.9 kernel.
>=20
> v2: - Addressed v1 review comments from Rob Herring and Sebastian Reichel
>       by moving out common battery properties from the charger node into =
the
>       battery-cell node.
>=20
>     - power_supply_register() of the SMB driver converted to resource-man=
aged
>       API variant.
>=20
>     - Improved DT property names of the SMB binding by making them to fol=
low
>       the generic power-supply naming scheme (-microvolts at the end, etc=
).
>=20
> David Heidelberg (7):
>   dt-bindings: power: supply: Add device-tree binding for Summit SMB3xx
>   power: supply: smb347-charger: Use resource-managed API
>   power: supply: smb347-charger: Implement device-tree support
>   power: supply: smb347-charger: Support SMB345 and SMB358
>   power: supply: smb347-charger: Remove virtual smb347-battery
>   ARM: dts: qcom: apq8064-nexus7: Add SMB345 battery charger
>   ARM: tegra: nexus7: Add SMB347 battery charger
>=20
> Dmitry Osipenko (3):
>   dt-bindings: battery: Add temperature properties
>   power: supply: Support battery temperature device-tree properties
>   power: supply: smb347-charger: Replace mutex with IRQ disable/enable
>=20
>  .../bindings/power/supply/battery.yaml        |  24 +
>  .../power/supply/summit,smb347-charger.yaml   | 152 +++++
>  .../boot/dts/qcom-apq8064-asus-nexus7-flo.dts |  24 +
>  .../tegra30-asus-nexus7-grouper-common.dtsi   |  24 +-
>  drivers/power/supply/Kconfig                  |   6 +-
>  drivers/power/supply/power_supply_core.c      |  19 +
>  drivers/power/supply/smb347-charger.c         | 565 +++++++++---------
>  .../dt-bindings/power/summit,smb347-charger.h |  19 +
>  include/linux/power_supply.h                  |   6 +
>  9 files changed, 568 insertions(+), 271 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/summit=
,smb347-charger.yaml
>  create mode 100644 include/dt-bindings/power/summit,smb347-charger.h
>=20
> --=20
> 2.27.0
>=20

--nrlaoi7slsg5rmx7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl9GdEIACgkQ2O7X88g7
+ppOHhAApWb5+TGOBlDwodu7HLrx3L067TxMJB7uIWhYAdsxn5X1d6O7CWViJTz4
itwiGPD1DjDngpQvk5KPttLBjk1z8zcvg3obV2Z1GX9ekyBR19eOyDGfuTDt7c0k
BfcaQ3fsefLcfZxad016XavYVbMeOHoRYEK+ett6U4KypUdCr7cxiGF537vfzmqz
D5tCvx5URgD7+hklWjV50MOA3W+V9hr51p+0ERVqSHWUZOBB+pB+F48U+3pX9Tjw
dcs5Yo54+KDRS5G0ZfRGoq++h4c+ypn+jkGt6rgEBaUTQbzRQAfXUVSVHhDi3Stw
h8gg8t0IG8r4CHZlDkcmOGNLFz/6tXyfktc5OSWJf7+Prof+UVlnhR/116ixEYHw
krkSaGCGz2U/+4DzsZpaVmihm8ysgY1qkP0Ey6/tvWuTNGQTCmipNDWD+MMTWBHN
NZEV4PfT71H1Ko4+fiOHTMC8iKy83FLgsgfZAs2qtlpCuw3aFjYRU+uBSCZuP2aF
kv1AqJ27tInH4nzxkHhgciCxZ96zoCP4vDch2Mdd1kDhJjBVCDeQZuMxzfjNh8RE
sz1LGmqfaLDCMo6sPlroLtuhG+Jh5e3nCrgKC4Z4E7DbBnpv2yoh3fvqFPiZjg0c
C7eVJa6RcNymMMity+VsrnfafBx+HPDg5W/FHBh4N5nSQecMdd4=
=iD6g
-----END PGP SIGNATURE-----

--nrlaoi7slsg5rmx7--
