Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3D053544E9
	for <lists+linux-pm@lfdr.de>; Mon,  5 Apr 2021 18:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239779AbhDEQLW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Apr 2021 12:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbhDEQLT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Apr 2021 12:11:19 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49163C061756;
        Mon,  5 Apr 2021 09:11:13 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 29AD61F44A04
Received: by earth.universe (Postfix, from userid 1000)
        id 9D2383C0C96; Mon,  5 Apr 2021 18:11:09 +0200 (CEST)
Date:   Mon, 5 Apr 2021 18:11:09 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Ricardo Rivera-Matos <r-rivera-matos@ti.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] power: supply: bq25980: Move props from battery
 node
Message-ID: <20210405161109.b7ku52y6hg7lgulw@earth.universe>
References: <20210210225646.10055-1-r-rivera-matos@ti.com>
 <20210210225646.10055-2-r-rivera-matos@ti.com>
 <20210211073807.sh6uwv3dt3eqxyy7@kozik-lap>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dhexdlxyadr3vlxy"
Content-Disposition: inline
In-Reply-To: <20210211073807.sh6uwv3dt3eqxyy7@kozik-lap>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--dhexdlxyadr3vlxy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Feb 11, 2021 at 08:38:07AM +0100, Krzysztof Kozlowski wrote:
> On Wed, Feb 10, 2021 at 04:56:46PM -0600, Ricardo Rivera-Matos wrote:
> > Currently POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT and
> > POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE are exposed on the battery no=
de
> > and this is incorrect.
> >=20
> > This patch exposes POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT and
> > POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE on the charger node rather
> > than the battery node.
>=20
> Now it makes sense if you only formatted it in human-readable way.
> Please fix your git/editor/email client/desktop unless you used such
> formatting intentionally. If it was intentional, then please don't - do
> like everyone else in Linux kernel (git log will help).

Thanks, queued to the power-supply tree (I fixed up the broken
commit message).

-- Sebastian

>=20
> Best regards,
> Krzysztof
>=20
> >=20
> > Fixes: 5069185fc18e ("power: supply: bq25980: Add support for the BQ259=
xx family")
> > Signed-off-by: Ricardo Rivera-Matos <r-rivera-matos@ti.com>
> > ---
> >  drivers/power/supply/bq25980_charger.c | 40 ++++++++------------------
> >  1 file changed, 12 insertions(+), 28 deletions(-)

--dhexdlxyadr3vlxy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmBrNp0ACgkQ2O7X88g7
+pq8zRAAiIbUkYQA6/PnKh66i6i0jNJh1+FtQdOuCxMzmIwbRcmm19qC2XBhzVde
kjwShtQ25gdQZ/IublmLjzJSPeiOgaFWC2GhYavC3CkFRLOoVUtfQQb9/1Nlt+RU
MkjZO85Rj7NfhP2U3UypIDmDC3CQBKz6U6oLjU/uLIxjQ2FIAIiXV0c8dZzqX8wO
k9zkh0nJblwj6lxjy1nsncJS2WAwmQ6RiPLNJ7MPTSWLvsuEOcRMZGOR1Tlhdn3H
+Ba2GDrTsNx8Ml95OWjk/JSkvZ7eM5DdoTqOSuRxg/VPrO1NTBRIDhKt4qrL8ct8
BSN1VNvz2xFrdCHF9/wEjHcmXeVV3UB1G09N9ojoSRLM4DU7e3klb0YI8fsFQt4n
DPaO7hzeeRADoJmHxiC82J9j3uuhL2yYsQLfxff5PB1fc7aKEI/IIoQ4ZWhQZp2h
GPzFjz40u4HsszY5tjJIcdML7RK0pgLjOwtP6sAzZ9+HMGbaFcY1PbWaKnh9xTBM
KUB4+s6kFPOiwiYHdHJ/QlNXdYqAUmXVXWP/iyVN/5BOR2DfAscwc5kXjZywkNTg
it3i3Ejtq7cc/BTg8SnMoYk5Q8n798CFydOkf7tqhWU4iCp2ETPaez0t5hsJd6u9
o9M+OunBWPyMrO0vONwtvbtMDc9FV9QrL6P6tJ8mNIEv2dwSKt0=
=PN3O
-----END PGP SIGNATURE-----

--dhexdlxyadr3vlxy--
