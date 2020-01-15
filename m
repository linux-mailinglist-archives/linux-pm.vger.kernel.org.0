Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A72313CE3B
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2020 21:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbgAOUsx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jan 2020 15:48:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:55984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728939AbgAOUsx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 15 Jan 2020 15:48:53 -0500
Received: from earth.universe (dyndsl-095-033-170-011.ewe-ip-backbone.de [95.33.170.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3001E2081E;
        Wed, 15 Jan 2020 20:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579121332;
        bh=nwKS0zW1NjzVj+K/jTMff6/lN/RQqdLUaC940w/PiHc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KvLE67+tXTbGZAkxNOFcfvVDgYRMHBam2zj35egGoSJ/t7FE6jfYIlNZN0KJPUcI5
         RmRaWoPN9ZlzSpwemZeH62eV12863YhMl2rxfwFpT77gLYAIZbgNVrAA9AQQsTTuEx
         cWLhcn5iKhz3aeUccSabMjFYxWLlSehq9zR9YEpM=
Received: by earth.universe (Postfix, from userid 1000)
        id 59E763C0C7C; Wed, 15 Jan 2020 21:48:50 +0100 (CET)
Date:   Wed, 15 Jan 2020 21:48:50 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, Oskari Lemmela <oskari@lemmela.net>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v4 0/4] X-Powers Power Supply Improvements
Message-ID: <20200115204850.7innme3d4agbay2r@earth.universe>
References: <20200115034048.24901-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iquki6qdoejfp2er"
Content-Disposition: inline
In-Reply-To: <20200115034048.24901-1-samuel@sholland.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--iquki6qdoejfp2er
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks, all queued to power-supply's for-next branch.

-- Sebastian

On Tue, Jan 14, 2020 at 09:40:44PM -0600, Samuel Holland wrote:
> This series adds some improvements to the axp20x_usb_power power supply
> driver to better support suspend/resume and use on mobile devices.
>=20
> Patch 1 is preparation for changes in following patches.
> Patch 2 allows userspace to take the power supply offline.
> Patch 3 allows userspace to control the wakeup behavior.
> Patch 4 avoids polling USB VBUS presence when possible.
>=20
> Changes since v3:
>  - Rebase on power-supply/for-next
>  - Add Reviewed-by (1-2)
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
> Samuel Holland (4):
>   power: supply: axp20x_usb_power: Use a match structure
>   power: supply: axp20x_usb_power: Allow offlining
>   power: supply: axp20x_usb_power: Add wakeup control
>   power: supply: axp20x_usb_power: Only poll while offline
>=20
>  drivers/power/supply/axp20x_usb_power.c | 217 ++++++++++++++++++------
>  1 file changed, 169 insertions(+), 48 deletions(-)
>=20
> --=20
> 2.23.0
>=20

--iquki6qdoejfp2er
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl4feqkACgkQ2O7X88g7
+pozAQ//f7qy+dV6jSnUkT7cC7r6FNKsMxHlcEYcsaWK2kJZRNthTFUbc57S2vlj
WQs2lDGLIy4CuP6kdJg3HjfZlMoE8GFf0Ta2yWK57B9aGu5aO5jkbZBt7y1u22An
h0DtToT+WzaQCVa14fXfYITJTJluTvzoCV8ejX4WM3yuiq7rRmWzyadthVbvb2h6
1PfGO+JEZtcWH+q/wP6LD6hg2gmjuvM00R/sEL02i3N9OCm60t1Lg6sq9nHzf0o8
Z09wZnK09V2X0q+Pp3IJ3A1NIDYRXJIGQ3bHHjAFq9xnAta3ED33yrlVvhx0DiOh
6o13ouCV0gfQFj4//ckKAsX5lP21hZQWYhZTN6LtHj14LD1aULJpTZH4+v81eWw9
emb6dVthMIpImp6GBtuM3SH0TGatk39y/MZocegWmSr43/Gx9rC337sBnXdV5pxS
Yi5mmBavJe4899PSBoexvfrzcvKjLVMrY10xVrPrv3WM0m11UANpPGulUs6cO+jr
CzZUPTVYpRW4gt/2Jnm2i+yeNldOwf2eUHu4wql9G4+D9a//QLX+5tkLmtkhsQFc
rdyK9fr8UnUPGUVf8wv9oWgq+SCLsaKAPZPS2uDcHWNbxvHKDq92lwMRF8elkVUE
StEy7hT2BImfyvwBzh5qrOQU1xGsVjKCXQ4hsYy/ENd7J+ytt9A=
=7sqy
-----END PGP SIGNATURE-----

--iquki6qdoejfp2er--
