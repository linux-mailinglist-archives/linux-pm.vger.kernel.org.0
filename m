Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 283972823B4
	for <lists+linux-pm@lfdr.de>; Sat,  3 Oct 2020 12:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725768AbgJCKyv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 3 Oct 2020 06:54:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:39128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbgJCKyv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 3 Oct 2020 06:54:51 -0400
Received: from earth.universe (dyndsl-091-096-061-070.ewe-ip-backbone.de [91.96.61.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBBE82067C;
        Sat,  3 Oct 2020 10:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601722491;
        bh=/Rc1/JWjYV2KFPI0YPpVmz48quqJXU9fZDw/AUilvys=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s+uFt9CYHJnPzU4JsXKCH+MKVNo1avATk39pK2HCNGkCTKj+NzJS6v0nD1gWsJeM2
         nenIUL2F7Qu435WcQtMqypBf4PBoCsGJGfuRk/7x7UH+GcqQ2Wujtk8wpIVb4VAzWD
         1prTlLyWoC0i7VY8ins1AnPNV81XDyWCpwQQygoI=
Received: by earth.universe (Postfix, from userid 1000)
        id D374E3C0C84; Sat,  3 Oct 2020 12:54:48 +0200 (CEST)
Date:   Sat, 3 Oct 2020 12:54:48 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Cc:     robh+dt@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmurphy@ti.com
Subject: Re: [PATCH v5 2/2] power: supply: bq256xx: Introduce the BQ256XX
 charger driver
Message-ID: <20201003105448.eqeyfpr7dugsp4in@earth.universe>
References: <20201001214034.5925-1-r-rivera-matos@ti.com>
 <20201001214034.5925-3-r-rivera-matos@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rcnwlmbykgphiqxu"
Content-Disposition: inline
In-Reply-To: <20201001214034.5925-3-r-rivera-matos@ti.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--rcnwlmbykgphiqxu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ricardo,

On Thu, Oct 01, 2020 at 04:40:34PM -0500, Ricardo Rivera-Matos wrote:
> The BQ256XX family of devices are highly integrated buck chargers
> for single cell batteries.
>=20
> Signed-off-by: Ricardo Rivera-Matos <r-rivera-matos@ti.com>
>=20
> v5 - adds power_supply_put_battery_info() and devm_add_action_or_reset() =
calls
> ---

changes look good, but you are still missing
usb_unregister_notifier() calls on drival removal.

-- Sebastian

--rcnwlmbykgphiqxu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl94WHgACgkQ2O7X88g7
+prBaQ/9FfQwumIrp0Tr+iWi95cs8J9xe5kp/PWmIqtiazUYDLvS147gF9waSO8r
D5hVq/Zh5UTPGG8aBaPxHWBdG49QPmBVvRTFWxkPbKMTbruyZZuTdgOw1hI9HfYj
Z3dIFLkV29mIKM/O1xKT7mD/+k9i8/eC7szcllMOIdoHeTyxOFdoSDZ4lJkgb7gS
4ubVOfiRd0JbZMUraEG3lvktZ8OAD0SJJ/JkqArcZj2vcla20kGRpY0jfGoLQCOb
nK1SZFUNax7f+1WtKqkTV20rKjqvt3kysuT4vMAPIHTMlpdM4Fgi7CyiOc3jeB9K
AWP2dHjBrdDXwRdoVhad8gdob5/9lR5DWkoquJJXTI3PuVTRkjOxW5mr4cQrRLdV
o5cKidSxLMBj3NwEamSpfD7jddqE/Snuh9pMHdZ+lW8wdtkt5Mdoy72kkco4c9jc
8lCU5OJdxLme/6vHmtbAfn9SHAnmwqTyUFjBwZGKzNVYoD3LPGYCRYL99GQAZrN9
2oxNvNLeGc+wRsdxXKtT5IUr7K4Gw0t8WkcgvUmuftYHl9/cBxYR+wUhaD5iH3yk
b+1E9BU0e9KnvUzzMbsRl/OByoFuDl5yTOzPnB75vGktXF0GFR8+NaA1CR1u3tUS
BSHoo70bvD/rEy51MrKYFVVM41EFg5nGT6X+yW3oci4ODSSBr7U=
=Y5gn
-----END PGP SIGNATURE-----

--rcnwlmbykgphiqxu--
