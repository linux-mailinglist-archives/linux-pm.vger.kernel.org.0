Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 441D1139DED
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2020 01:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729388AbgANARb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jan 2020 19:17:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:59662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729274AbgANARb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 13 Jan 2020 19:17:31 -0500
Received: from earth.universe (dyndsl-091-096-060-001.ewe-ip-backbone.de [91.96.60.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04320214AF;
        Tue, 14 Jan 2020 00:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578961051;
        bh=PtgZWKN3HLoAj4bzYvKrd3jaasZfRYVf+RTzNAmTs2E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QteWwwAH8b5g/+NP79H3E25fFvu8uK40gphEPX/MrT/Xbxfisl6JWPxpiIjSnsIG/
         aaHU/LUYo70sDosPXCAB6+ZUcO65vo4sK0tu5auxRWD0JCJrGLCKapUnIFjwnBKKam
         SsqC3CqipYoNGEfrjKd+JtvVmppxCti25nmg+BVU=
Received: by earth.universe (Postfix, from userid 1000)
        id 3B08F3C0C7C; Tue, 14 Jan 2020 01:17:29 +0100 (CET)
Date:   Tue, 14 Jan 2020 01:17:29 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, Oskari Lemmela <oskari@lemmela.net>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v3 0/8] X-Powers Power Supply Improvements
Message-ID: <20200114001729.dgozjk4eaxjp7fzz@earth.universe>
References: <20200113035310.18950-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sqzuoh7u67ekm2kz"
Content-Disposition: inline
In-Reply-To: <20200113035310.18950-1-samuel@sholland.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--sqzuoh7u67ekm2kz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I queued patches 1-4, patch 5 does not apply and seems to be based
on an older tree.

-- Sebastian

On Sun, Jan 12, 2020 at 09:53:02PM -0600, Samuel Holland wrote:
> This series adds some improvements to the axp20x* power supply drivers
> to better support suspend/resume and use on mobile devices.
>=20
> The first two patches fix bugs I found while testing the ONLINE control
> added in later patches.
>=20
> Patches 3 and 7 allow userspace to take the power supplies offline.
> Patches 4 and 8 allow userspace to control the wakeup behavior.
>=20
> Patch 9 avoids polling USB VBUS presence when possible. While working on
> the RSB driver, I was seeing ~50 transfers per second, while idle and
> tracked it down to this VBUS polling (20 reads/second). The polling
> often caused the CPU to clock up and back down, which triggered the
> remaining transfers (changes to the CPU voltage).
>=20
> Unfortunately, I don't see a way to avoid the polling when running on
> battery (where it matters most), other than to move the polling back to
> the USB PHY driver.
>=20
> Changes since v2:
>  - Patch 1 was merged
>  - Only check ACIN_PATH_SEL when necessary (1)
>  - Update commit message (5)
>  - Avoided reordering lines until/unless necessary (5, 7)
>  - Update comment and add ID check in axp20x_usb_power_set_property
>    (it seemed more correct than adding another comment) (6)
>  - Add Reviewed-by where there were no comments (2-4, 7-8)
>=20
> Changes since v1:
>  - Add patches 1-2
>  - Shift value properly in calls to regmap_update_bits (3, 7)
>  - Use #ifdef instead of #if to avoid -Wundef warnings (4, 8)
>  - Poll once after an IRQ, instead of setting power->online in the IRQ (9)
>  - Poll once on resume, in case the state changed during suspend (9)
>=20
> Samuel Holland (8):
>   power: supply: axp20x_ac_power: Fix reporting online status
>   power: supply: axp20x_ac_power: Allow offlining
>   power: supply: axp20x_ac_power: Add wakeup control
>   power: supply: axp20x_usb_power: Remove unused device_node
>   power: supply: axp20x_usb_power: Use a match structure
>   power: supply: axp20x_usb_power: Allow offlining
>   power: supply: axp20x_usb_power: Add wakeup control
>   power: supply: axp20x_usb_power: Only poll while offline
>=20
>  drivers/power/supply/axp20x_ac_power.c  | 131 +++++++++++---
>  drivers/power/supply/axp20x_usb_power.c | 219 ++++++++++++++++++------
>  2 files changed, 276 insertions(+), 74 deletions(-)
>=20
> --=20
> 2.23.0
>=20

--sqzuoh7u67ekm2kz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl4dCJEACgkQ2O7X88g7
+poyhBAAnNnSwxvQGB617t1H1P7IT/YIV8ip8AASUUZrCjrICzsyBVlUur0gYnpx
TZlGnd/kjQk9ZMuPjdEMwhCWaprfZElCZqacKNWdPM9F1/7BGAc4sfaStWjkc2MI
yw4QH+qL6mSexEQRksxUd4LvjlGMxNkmUhH41vN1LNkvdSsD4l7Tv0I4281Fjwpk
xSp9ld6eItYp43JVo8zFa6UDaZQO18D1nVPOMHvrGv3AFaBGTf3XIvSbq6FwaMJq
8l3R9YIOdczB1AKLP5dneIR8w8t6sM6Ta0RwmMs2B70LOM31+i6HV0mnxjPNr+/e
y4YA5Q2tTA6EWR/zKMcGC6Sd/TA8eYeJ5LKS1WyBADHolHDvhmqJp9uhxxrS3otP
acXuujRMpr/dGVmb3KWAyjcMDp4WlHuZzhTxOJCXIqt2ZiKy+rLpyXccLHT2o6Bo
imKge3VQTK9R2A01zJ/eVyzK/PntgLGHJD+WmJ7m5w8kTQJiAXnr+rKXolXvjqlP
eAh7wLNVracG7Qu4WOl8kLBuk3tYCor95uxDO7esCLrL1118biXvVxcLRg8JfOxh
KRd8hEjwNA5CAWKFAnvc0jW0m0ScT5PSh4e6A+aFGOIbJ2QNvwai11KKkiY60g8l
ohqjjzPtCMVP4dNcI5KGCy4BtjtqXrie4LsaiWYa/THt7m/Rcl8=
=3fN1
-----END PGP SIGNATURE-----

--sqzuoh7u67ekm2kz--
