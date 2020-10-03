Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0800282605
	for <lists+linux-pm@lfdr.de>; Sat,  3 Oct 2020 21:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725826AbgJCTMd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 3 Oct 2020 15:12:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:33042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbgJCTMc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 3 Oct 2020 15:12:32 -0400
Received: from earth.universe (unknown [185.213.155.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D080206DB;
        Sat,  3 Oct 2020 19:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601752351;
        bh=qH+El+Idu9/X13MY5rS8/2uN35BsyZbyOKOMO6EuwM0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sabh5m1SmeaY0uStCSD1KWWl9zXY2GLRcQPGFoEQjHVAUXuFwHFMq9jIYcI5pfQ3B
         Qf5ugk+ig6qFNEaDhjWknGO2s6STqprv8vTAUaeRuscdkSvSI29jeI3tUAR1fPaAKi
         95BfMererNVn8JfUOG/snH0U8M2EGCxA+YmGgKMQ=
Received: by earth.universe (Postfix, from userid 1000)
        id 4C58A3C0C87; Sat,  3 Oct 2020 21:12:29 +0200 (CEST)
Date:   Sat, 3 Oct 2020 21:12:29 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Iskren Chernev <iskren.chernev@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Jonathan Bakker <xc-racer2@live.ca>,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Subject: Re: [PATCH v5 0/7] power: supply: max17040 support compatible devices
Message-ID: <20201003191229.dmxov4itycdhs4hy@earth.universe>
References: <20200922114237.1803628-1-iskren.chernev@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="q4k4oxhr25ei5syr"
Content-Disposition: inline
In-Reply-To: <20200922114237.1803628-1-iskren.chernev@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--q4k4oxhr25ei5syr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 22, 2020 at 02:42:30PM +0300, Iskren Chernev wrote:
> The max17040 fuel gauge is part of a family of 8 chips that have very
> similar mode of operations and registers.
>=20
> This patch set adds:
> - compatible strings for all supported devices and handles the minor
>   differences between them;
> - handling for devices reporting double capacity via maxim,double-soc;
> - handling for setting rcomp, a compensation value for more accurate
>   reading, affected by battery chemistry and operating temps;
> - suppot for SOC alerts (capacity changes by +/- 1%), to prevent polling
>   every second;
> - improved max17040 driver with regmap and devm_
>=20
> The datasheets of the supported devices are linked [0] [1] [2] [3].
>=20
> [0] https://datasheets.maximintegrated.com/en/ds/MAX17040-MAX17041.pdf
> [1] https://datasheets.maximintegrated.com/en/ds/MAX17043-MAX17044.pdf
> [2] https://datasheets.maximintegrated.com/en/ds/MAX17048-MAX17049.pdf
> [3] https://datasheets.maximintegrated.com/en/ds/MAX17058-MAX17059.pdf
>=20
> v4: https://lkml.org/lkml/2020/9/6/237
> v3: https://lkml.org/lkml/2020/6/24/874
> v2: https://lkml.org/lkml/2020/6/18/260
> v1: https://lkml.org/lkml/2020/6/8/682
>=20
> Changes from v4:
> - fix warning reported by kernel test robot <lkp@intel.com> for v4
>   patch 4/7
> - ensure all patches have Sign-off-by matching author (was violated
>   for v4 patch 2/7)

Thanks, queued.

-- Sebastian

--q4k4oxhr25ei5syr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl94zRIACgkQ2O7X88g7
+pq12g//USMO6LOjo7Z/QuPNh4ZNG9Go4FZmbMCH7zI8qbOD8MXNXhIZ+7fy1aFr
SDJif+eai0hQTsb2o1B7Y0Z0eeSVsW624Sfnl5/hMONP+FPgptLT58nWY5R7yFYe
PsvavVcyqmfSWDYnd8MG93i5nPGMHkNLVyxjiZpDWq+Jjv8WxEzEzVxhnMgKmXql
yBi3QxyDKnupNaZpJyfe6wIRloTtLXaLs5LczbsqCq7e5weFluzE9psDeGPjlBqf
VE8v8vrR99C8sYrH4YronPfAS2rJQ9ilJ1rgUpREdX/moo5OsUubb72XXvTKltB1
HoNQQ7o2pLhBrB5LhaFfV8VQN80KJoc/qeKMLFTw2F/SPS2uboUEogemG3WCW5w2
2IP5G6nrbnRPJbvfNkR8jo2RbNqxdKnV08HpPGW4RXKGNGermYuKKAFSbmEWL6zU
U80wE5DEpoH/gTS5dyjfPiYjnmnF1pATSh7l5uI/95MkP2njfihpYhDHjdsZru/7
bvta95mvDM2YrquVNNiZSgwbRWcR4HlB7VS65ITxf0abI33dCz24zGS6Gmd2kY2Y
AieaRuO2mloB6olxImypRtr8B8J1jylfbRS2lXoeV2U3eoc+JDvM831VKWSiq8Zn
1Rcs2/0WPsokn8TSxZL3gtdk77hz9oeRemRlVC7FBZDeVJsD7dQ=
=fWvd
-----END PGP SIGNATURE-----

--q4k4oxhr25ei5syr--
