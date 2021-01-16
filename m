Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E45642F8DEC
	for <lists+linux-pm@lfdr.de>; Sat, 16 Jan 2021 18:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbhAPRMW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 16 Jan 2021 12:12:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728474AbhAPRKw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 16 Jan 2021 12:10:52 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207CDC0617A2;
        Sat, 16 Jan 2021 05:58:16 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 4C3F71F45AB0
Received: by earth.universe (Postfix, from userid 1000)
        id A26713C0C94; Sat, 16 Jan 2021 14:58:11 +0100 (CET)
Date:   Sat, 16 Jan 2021 14:58:11 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 0/3] power: reset: at91-sama5d2_shdwc: add support for
 SAMA7G5
Message-ID: <20210116135811.vwiwrrpprf6cawy6@earth.universe>
References: <1608123453-1423-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jkxmjym7qv3furhr"
Content-Disposition: inline
In-Reply-To: <1608123453-1423-1-git-send-email-claudiu.beznea@microchip.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--jkxmjym7qv3furhr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Dec 16, 2020 at 02:57:30PM +0200, Claudiu Beznea wrote:
> This series adds support for SAMA7G5 shutdown controller.
>=20
> Thank you,
> Claudiu Beznea
>=20
> Claudiu Beznea (3):
>   power: reset: at91-sama5d2_shdwc: fix wkupdbc mask
>   dt-bindings: atmel-sysreg: add microchip,sama7g5-shdwc
>   power: reset: at91-sama5d2_shdwc: add support for sama7g5
>=20
>  .../devicetree/bindings/arm/atmel-sysregs.txt      |  5 +-
>  drivers/power/reset/at91-sama5d2_shdwc.c           | 74 ++++++++++++++++=
------
>  2 files changed, 58 insertions(+), 21 deletions(-)

Thanks, queued.

-- Sebastian

--jkxmjym7qv3furhr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmAC8O4ACgkQ2O7X88g7
+pqssw/9FKQIzfTvzJbrp+mf9yh60qKRDouZzs7nLTi7W8ApnomDjb9gbD5fwGiP
bTq1PkN8fiO4OzRF5YP+Vq6aHKgvMQT5+QCYjU60eGZ1pRSAFARpUFbJvvjlbb/z
TRal7bMXbhi8658flDsbwYJVICt8LVNZHvefFIaWqDKcNvFt4rF/XmN9xfPVr0BD
n44c+majpD96899zzvJGVCkAsZ7DvR5TyUKr5zaHiyxupVIH8bBP7Cv1QlMyj18a
BBNN5lLhxEcOKmzBziOlDxA3rW2+90TSBfqtRTNhSOzCPwLwsyKgja/J+Z6NnO6X
qUmvKqbWlZEJs0Dsc6AKmCOonV4RddLTz5UQVcW6nvyNyR5j34UPglQIXkbdzNzV
UMixW3f6I24gkvP7NDQMW7xQyoIgY7FXHxN2fwzppfoDpQ7PWACk1MuoBg/Hamqt
JS32PHOV9wwzXsRkL7UvyxTRV2lbMLga/pIbTmvcwqDu1rXJhqvN4k/Hf2e0Gf3B
krc5+zf75npnauMpB4CiCvrO5k7BI9BDkfx+A59vbUgAiS7NI5hyFziis60ZTk/V
U4v+l3/gNF8YQ2T3BSQ/v08JJwjbw4fF1tQWYWdvUD3x4tAFJ+It/N4gbTucgfsg
4yLmc8K6tVkJGTnS6rPK+5tHWcBdnV0me2u3WFhOGBfrXbIUkyM=
=0YRi
-----END PGP SIGNATURE-----

--jkxmjym7qv3furhr--
