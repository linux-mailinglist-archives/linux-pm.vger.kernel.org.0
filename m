Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEAA81C2DA8
	for <lists+linux-pm@lfdr.de>; Sun,  3 May 2020 17:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbgECPs7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 3 May 2020 11:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728207AbgECPs6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 3 May 2020 11:48:58 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CB6C061A0E;
        Sun,  3 May 2020 08:48:58 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id B4F282A04E0
Received: by earth.universe (Postfix, from userid 1000)
        id 258293C08C7; Sun,  3 May 2020 17:48:55 +0200 (CEST)
Date:   Sun, 3 May 2020 17:48:55 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Tobias Schramm <t.schramm@manjaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND v6 0/3] Add support for CellWise cw2015 fuel gauge
Message-ID: <20200503154855.duwj2djgqfiyleq5@earth.universe>
References: <20200414125208.1091989-1-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h4n2rz53hnvcjnho"
Content-Disposition: inline
In-Reply-To: <20200414125208.1091989-1-t.schramm@manjaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--h4n2rz53hnvcjnho
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 14, 2020 at 02:52:05PM +0200, Tobias Schramm wrote:
> This patchset adds support for the CellWise cw2015 fuel gauge.
>=20
> The CellWise cw2015 fuel gauge is a shuntless, single-cell Li-Ion fuel
> gauge. It is used in the pine64 Pinebook Pro laptop.
>=20
> This is just a resend of v6 to the linux-pm maintainers for merging.
>=20
> I've kept the cellwise,battery-profile property in the device tree. Its
> content describes characteristics of the battery built into a device. The
> exact format is unknown and not publicly documented. It is likely
> comprised of some key parameters of the battery (chemistry, voltages,
> design capacity) and parameters for tuning the internal state of charge
> approximation function.
> Since v2 CellWise has confirmed to me that the only way to obtain the
> profile blob is to mail them batteries for testing. Thus we will need to
> keep that property.

Thanks, queued.

> In general I'm not 100 % sure about my json-schema binding for the gauge.
> It is my first time ever writing a json-schema binding and I'm not sure
> whether properties like power-supplies or monitored-battery need to be
> added to a separate, common schema for power supplies or not.

Yes, they should be referenced, but at the time of your patch the
common power-supply properties and the battery bindings have not
yet been converted to YAML. The power-supplies property is now
described in Documentation/devicetree/bindings/power/supply/power-supply.ya=
ml
and conversion of the simple-battery binding will hopefully happen
soon. Afterwards we can update the cw2015 binding accordingly.

-- Sebastian

> Best Regards,
>=20
> Tobias Schramm
>=20
> Changelog:
>  v2:
>   * Change subject to "Add support for CellWise cw2015 fuel gauge"
>   * Rewrite bindings as json-schema
>   * Use default power-supplies handling
>   * Use regmap for register access
>   * Use standard simple-battery node
>   * Replace printk/pr_* by dev_{dbg,info,warn,err}
>   * Use cancel_delayed_work_sync in remove
>   * General code cleanup
>  v3:
>   * Incorporate review by Andy
>   * Add cellwise vendor prefix
>   * Rename cellwise,bat-config-info property to cellwise,battery-profile
>   * Remove most state of charge post-processing
>   * Use fwnode interface
>   * General code cleanup
>   * Lots of code style fixes
>  v4:
>   * Implement additional changes requested by Andy
>   * Use fwnode inline wrappers
>   * Clean up waiting for gauge
>   * Minor code style fixes
>  v5:
>   * Clean up includes
>   * Handle errors during device property parsing
>   * Refactor device property parsing
>   * Replace i2c->probe by i2c->probe_new=20
>   * More code style fixes
>  v6:
>   * Fix bindings according to review by Rob
>=20
> Tobias Schramm (3):
>   dt-bindings: Document cellwise vendor-prefix
>   dt-bindings: power: supply: add cw2015_battery bindings
>   power: supply: add CellWise cw2015 fuel gauge driver
>=20
>  .../bindings/power/supply/cw2015_battery.yaml |  82 ++
>  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>  MAINTAINERS                                   |   6 +
>  drivers/power/supply/Kconfig                  |  11 +
>  drivers/power/supply/Makefile                 |   1 +
>  drivers/power/supply/cw2015_battery.c         | 749 ++++++++++++++++++
>  6 files changed, 851 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/cw2015=
_battery.yaml
>  create mode 100644 drivers/power/supply/cw2015_battery.c
>=20
> --=20
> 2.26.0
>=20

--h4n2rz53hnvcjnho
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl6u5+EACgkQ2O7X88g7
+pomrg/5ASAQXZsM9KBxE7il9Jg64/S3HPh+iaT1r5CNDWH/Z1fnThOI1Zc9cyw0
ReCDGNSuILQEfR7qCypuP60/V6hTDad/BU3ZGCIvZiifuOg3HBSGVjSyYNZA7Nfn
PYvqJBgw8WsUYTd/XFTfqjI8y5CJcbWOtP2umaIb6AX2zRCDeUMjjfW0EBWM4m1m
0uZ5HYRCQbTvs3sqc6XkXcJzrOmmn11TWGtWcwNu4U/YoR3i4qLLF0bNyFkAlxd/
EYRb1KR5/oot5pngsD5E2CFrJTy/0+/vlEsHk6TMIRqAb8nVD4xWaFfhSlukcRP2
vyYa7aynDMgll+L1ErKXdYpUXW4ACN3GVs0tkPuQm/KIqhLtT5vdBRsbAPoSqUJ8
XqMp+0Cs1qA/9ysCrRQeXTZOA7ZAu7FQ25pGgBTwF8P1RqLHkqX2JNPspZtbRgXn
jS55DclRebIJtl3KNWiiTnajaSUfh83SAPali5SS8IfTjFVX2/NJarmaZaKPdkHf
BiEGE8OJjSSQpn33mRo5tSjpFSptI7mwB2uSuVeuD4R104vv+5ZQNHAvlDa0aOKm
rLdffwRoNLdDLsjq7fTKJrv/oAU0k1H6jkNc1dRBM9FE0g/k90qeSxXypSHFB+7C
hWOwNdi7sPfPm0lqTqcJy8tjSQuvsrW4aMjUD60R58sXUO0Ua1c=
=6qYg
-----END PGP SIGNATURE-----

--h4n2rz53hnvcjnho--
