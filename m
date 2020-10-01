Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34D61280A4F
	for <lists+linux-pm@lfdr.de>; Fri,  2 Oct 2020 00:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733180AbgJAWeR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Oct 2020 18:34:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:45450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733053AbgJAWeQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 1 Oct 2020 18:34:16 -0400
Received: from earth.universe (unknown [185.213.155.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 143A620719;
        Thu,  1 Oct 2020 22:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601591656;
        bh=C0tsO5cNgagmCLODaUqFSnF84xDb1/vsiTrnbyr/CQE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Po8wSS7Lim+uQWRzodvEUaJSDByxhChjJ8gg1miei/1Y7Rnvmr3ss27KkeJ5JX3M6
         IjAo8XMdDo2LdE5k/DLFnOmdI73zkFltdoJtJc/qLmxeJRWyx7mTES1V0qx2fwm1eu
         gJ8uyiNdR8GOgZPNVRMUakMMddmT3H/8heDTkTU8=
Received: by earth.universe (Postfix, from userid 1000)
        id C57BC3C0C84; Fri,  2 Oct 2020 00:34:13 +0200 (CEST)
Date:   Fri, 2 Oct 2020 00:34:13 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Dan Murphy <dmurphy@ti.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] power: supply: bq27xxx: add bq34z100
Message-ID: <20201001223413.e57afzv6dwwpbpqy@earth.universe>
References: <20200919140418.3705-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s7xxlsn5s4d2k2l3"
Content-Disposition: inline
In-Reply-To: <20200919140418.3705-1-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--s7xxlsn5s4d2k2l3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Sep 19, 2020 at 04:04:12PM +0200, Krzysztof Kozlowski wrote:
> Changes since v1:
> 1. Squash patch 3 and 4 - cleanups, as suggested.
>=20
> Best regards,
> Krzysztof
>=20
> Krzysztof Kozlowski (6):
>   dt-bindings: power: bq27xxx: add bq34z100
>   power: supply: bq27xxx: report "not charging" on all types
>   power: supply: bq27xxx: adjust whitespace and use BIT() for bitflags
>   power: supply: bq27xxx: add separate flag for single SoC register
>   power: supply: bq27xxx: add separate flag for capacity inaccurate
>   power: supply: bq27xxx: add support for TI bq34z100
>=20
>  .../bindings/power/supply/bq27xxx.yaml        |  1 +
>  drivers/power/supply/bq27xxx_battery.c        | 83 +++++++++++++++----
>  drivers/power/supply/bq27xxx_battery_i2c.c    |  2 +
>  include/linux/power/bq27xxx_battery.h         |  1 +
>  4 files changed, 72 insertions(+), 15 deletions(-)

Thanks, queued.

-- Sebastian

--s7xxlsn5s4d2k2l3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl92WV4ACgkQ2O7X88g7
+poE7RAAkAxVds7XXwqb9RoEXZrWEGsPqUXIV50splqtvOilhj+dAQdnBfzE/Dwl
IZdivUrwtQKe2D441mkyYTLhxBS+NBLKqK3sySwF9pAbdiqyel3h2l/67o37nViJ
ANEa3NjrohwMzWUc8u9/utD4pb2sJYHYoLBcpX7nOkHnqrau7Etz8d3Tb/RGpAs5
pRkygMZThZHegBiP5BN10MilDBBm4V8W1P1OrbDm4RWNWAu1VtZlYjAvxO72N6Pk
fqm7btZ8VJQG4eMbnRfMywBvizUDOW3Cy+zoM6hNgTIw0/N8YnHhNm53Qm+0nLrW
Yph2BAj2CdkgQ6OFezYRvc9ARIleeDSiMZBLTcaC8AAuY1fj/HmspO5iTf+kfaI4
lESXZVFwBix/icP3ohE+1zHSaP1elQrED+INPOHXWBVxeCTr9aqmZLnSbTJcm71R
0BIs4OEnhKN/8QdguOSoqi3k8s9tBV+/KNW9gDaUHfogonCryDhZV02yKzya64I4
3vMnS+xBqR2QzM8WyyMyCXetA4ZB8Elt0Xb2YppdHtjx4qpYPH7Rd4yyrbbvUsEK
xzA767Tzih7NmaZWBl5es7ZdL+YOWpaZRuBiOD3pTxpOkx2d9GKJg19jZDGTONdo
1qMPc76Qwxh05EgI9joHTukInnx9FXs/nJeijXPqK/Vd0lwyb8E=
=HTDD
-----END PGP SIGNATURE-----

--s7xxlsn5s4d2k2l3--
