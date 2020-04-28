Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8A1B1BCC5F
	for <lists+linux-pm@lfdr.de>; Tue, 28 Apr 2020 21:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbgD1T0f (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Apr 2020 15:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728613AbgD1T0e (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Apr 2020 15:26:34 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A44C03C1AB;
        Tue, 28 Apr 2020 12:26:34 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 5D21D2A06C3
Received: by earth.universe (Postfix, from userid 1000)
        id D156B3C08C6; Tue, 28 Apr 2020 21:26:30 +0200 (CEST)
Date:   Tue, 28 Apr 2020 21:26:30 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, yuanjiang.yu@unisoc.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] Add some new properties for the SC27XX fuel gauge
Message-ID: <20200428192630.bnxwhclctzwqov6x@earth.universe>
References: <cover.1587353854.git.baolin.wang7@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ohtg55muwurupbgz"
Content-Disposition: inline
In-Reply-To: <cover.1587353854.git.baolin.wang7@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--ohtg55muwurupbgz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 20, 2020 at 11:42:03AM +0800, Baolin Wang wrote:
> This patch set adds some new properties for the SC27XX fuel gauge,
> as well as changing the 'POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN' as
> writeable. Thanks.
>=20
> Yuanjiang Yu (4):
>   power: supply: sc27xx: Set 'no_thermal' flag for SC27xx fuel gauge
>   power: supply: sc27xx: Allow to change the battery full capacity
>   power: supply: sc27xx: Add CURRENT_NOW/VOLTAGE_NOW properties support
>   power: supply: sc27xx: Add boot voltage support
>=20
>  drivers/power/supply/sc27xx_fuel_gauge.c | 77 +++++++++++++++++++++++-
>  1 file changed, 74 insertions(+), 3 deletions(-)

Thanks, queued.

-- Sebastian

--ohtg55muwurupbgz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl6og2YACgkQ2O7X88g7
+prZew/8DC17AQ0V4UMuWcnhm3BMkDa11x/XZDjMahHLWZBdEMiPGFuzM8Ya2KVm
PSeNNV6xs72NyNuYqNubD5L60BfdRvapYlj0ZwoVXF+ed4ZkpHxfBjaxdypt0EuQ
spJ6ZPGImIbIgl5l0NeMnrdOLsCHdYcXXPiZL0HLub0vYbFzsg38mio9hwgWrerv
sakmv+GlEIZhV39sgWeY4SZpffn1FJe1XghJjfHcEUh0DXTo1FPsPIhkiJ+VB0EU
/0vBG4eK2YkUSF7aZKahwbd23JY5mqAfCm6af2+X1w+n8aa2lw6FIPI40FaMXhi0
eboZLWdcbZG4/0XsZtjyFAEOKSenHwAWOAkSZDh5KkT2JG3aS7QedQeKSGQEXJ+B
h39j88tpYDr2Vtx9FSAgsnfQvpRXoUldaSVcPMZp/x4QUzfRT3Q/MlwgBjGUT5Ua
TZylhIlALEjiY+XT3hXmesFqXdhB7G9UBJ7BFsP42LCUM6zkoyCnxK9t+NoGH46a
6l5724PMAmTtP4/UpWRLTJBQMhbbM5ySzC1SWKj4h2GGnf4M8DwJxfOUgPlBuSXD
u+bjzUxZBS0HsSX4cBnsJmqyuZcL1mdlRa57jdu88fKHQ9CStcwsXetn1tpnzgF+
3NHc9iq7/eybLvIL3u+ui8G3rfD2nzEhvLu3kkFtTB0rwXmpZpA=
=9FQC
-----END PGP SIGNATURE-----

--ohtg55muwurupbgz--
